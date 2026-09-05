Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AC5C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 06:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2jie-0007vf-JA; Sat, 05 Sep 2026 02:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zakinko@snowrabbit.org>)
 id 1x2eZj-0005ew-Qr; Fri, 04 Sep 2026 20:48:07 -0400
Received: from bambi.snowrabbit.org ([182.48.54.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zakinko@snowrabbit.org>)
 id 1x2eZh-0000b9-Cc; Fri, 04 Sep 2026 20:48:07 -0400
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
 id 5B560C92F2; Sat,  5 Sep 2026 09:48:00 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, zakinko@snowrabbit.org
Subject: [PATCH] target/arm/hvf: implement MDCCSR_EL0 as RAZ
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20260905004800.5B560C92F2@bambi.snowrabbit.org>
Date: Sat,  5 Sep 2026 09:48:00 +0900 (JST)
Received-SPF: pass client-ip=182.48.54.220;
 envelope-from=zakinko@snowrabbit.org; helo=bambi.snowrabbit.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 05 Sep 2026 02:17:37 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


A guest that reads MDCCSR_EL0 under hvf is killed.  The register has no
case in hvf_sysreg_read(), so it reaches the unhandled path and hvf
injects an undefined instruction:

    trace_hvf_unhandled_sysreg_read(env->pc, reg, ...);
    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);

The TCG path does not do this.  debug_helper.c defines MDCCSR_EL0 as
ARM_CP_CONST with resetvalue 0, and the comment on the neighbouring DCC
registers gives the reason:

    However we implement RAZ/WI behaviour with trapping to prevent
    spurious SIGILLs if the guest OS does access them as the support
    cannot be probed for.

That argument holds for hvf as much as for TCG, so do the same there.

The read only reaches QEMU since 37863fff59 ("hvf: arm: enable vGIC by
default for virt-11.1 and later").  With -M virt,kernel-irqchip=off the
trace point does not fire at all, so before that change the register was
never trapped out.

NetBSD/aarch64 hits this on every boot.  vmt(4) probes for the VMware
backdoor, which on arm64 is a read of MDCCSR_EL0 with a magic value in
x7, and the injected undefined instruction is fatal in kernel mode:

    [   1.0000000] cpu0 at acpi0: unknown CPU (ID = 0x610f0000), id 0x0
    [   1.0000000] panic: Trap: fatal Unknown Reason (Illegal Instruction):
      pc=ffffc000003fa318 sp=ffffc000010262e0 esr=02000000
    [   1.0000000] fp ffffc000010262f0 vmt_probe() at netbsd:vmt_probe+0x3c
    [   1.0000000] fp ffffc00001026340 vmt_match() at netbsd:vmt_match+0x1c

The pc in the panic is the same pc the trace point reports, and the
encoding it reports is MDCCSR_EL0:

    hvf_unhandled_sysreg_read unhandled sysreg read at pc=0xffffc000003fa318:
      0x0020c002 (op0=2 op1=3 crn=0 crm=1 op2=0)

With this patch the same image boots to login on -M virt -accel hvf, and
the trace point does not fire.

Fixes: 37863fff59e0 ("hvf: arm: enable vGIC by default for virt-11.1 and later")
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 target/arm/hvf/hvf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index da3ec521fc..b00a7e1a84 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -234,6 +234,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_ICC_SRE_EL1       SYSREG(3, 0, 12, 12, 5)
 
 #define SYSREG_MDSCR_EL1      SYSREG(2, 0, 0, 2, 2)
+#define SYSREG_MDCCSR_EL0     SYSREG(2, 3, 0, 1, 0)
 #define SYSREG_DBGBVR0_EL1    SYSREG(2, 0, 0, 0, 4)
 #define SYSREG_DBGBCR0_EL1    SYSREG(2, 0, 0, 0, 5)
 #define SYSREG_DBGWVR0_EL1    SYSREG(2, 0, 0, 0, 6)
@@ -1756,6 +1757,15 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_MDCCINT_EL1:
         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
         return 0;
+    case SYSREG_MDCCSR_EL0:
+        /*
+         * The Debug Communications Channel is not implemented, so RAZ,
+         * which is what the TCG path in debug_helper.c does.  A guest
+         * cannot probe for DCC support, so injecting an undefined
+         * instruction here turns a legal read into a fatal trap.
+         */
+        *val = 0;
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
-- 
2.50.1 (Apple Git-155)


