Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795B7C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdV-0005VW-IR; Tue, 15 Sep 2026 13:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdN-0005Qy-R5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:53 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdM-0003Wb-62
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:53 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso2799472f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492070; x=1790096870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OarHLFLe5K7FdRBuTjkQXU60XyAs5n1eAi0rtUtmikg=;
 b=EF8M6kzYlRTIRWVyMBpIVzJxVwVDcxuFMcFK6A/NCN1e5vWlFtKuMFLntwxBQC/23f
 g0fxjNq4szEOJ9rbJryoZF0ojUAaKvEb4d//CMlFXw6pHfy+9kad19tlvF8tmJvD/ppk
 Y49Sscyb5j4LDvm/MxEvqOiVokmklbsIwy46D67s+L45LYIvpkcqN0g1UMH8XaJH8yGO
 +d6P1zWgCgVbiQpjbrboxkb88Vt/YRBGRFdH3FQgl+2VjpMglahtH/S3AuHfdAv6GTiA
 7hkjB/kOjKH0CgZxFyyolzHSuael5MdSZNgJ78IiPRXWiWSToftWOeg9dnXC30wg/adX
 B2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492070; x=1790096870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OarHLFLe5K7FdRBuTjkQXU60XyAs5n1eAi0rtUtmikg=;
 b=EVjEU3BGOHFHKziiymBVAHV9z3KbHAccGzQBpMt0AdgO15PkHdrTZaqr7Ewvla0GQk
 /CIN7zHBzzT+7MRaNtlrquRy15NAHDtlCP4EgRezXL1Sy6AOd8Eo9w/+x0mqpfDw3jGE
 nzeQwo5/cVLctxoJU1+Q88N4B56vsPiaVySOwLQaId8yEKDkZSZl194mc/YDWtl0FZho
 kW1yxH+5Ca/pWWF8iuawaYqw9TEQu3RoRTsulQENa+rgaV56E2ZENqMcKeSuY12Bu2WJ
 C9mqdlh5+N/jSVi5Vw9X2XTpl8SoCqjJrSVUHypDaB8B9EmaTtrsf5PkcZYbVIyZNG6e
 TaOA==
X-Gm-Message-State: AFuF++nQYeEOXekGzA0083Q5gr1HY2QNXNdf4EiimtPk6KZdeZc6FHVA
 CVkv+MJHeFyQXs5rme66ImaiFdgsecqeMfVeH7f2q/NPcP5a9WvVPeJaEbmvoKSXdbwbF+Ico/c
 Fee/kJ44=
X-Gm-Gg: AYBFou2fYvmb5WHInHdm+2gXyH3pZvAUMEZw3aS6k7QS3jg/SIWhEfBsqBHMx/VLnFR
 MbzXyp5rBq2G56gNpTVMTLjk9mIuyCKNdqCdr340l9ntJpF6yIa6wHYtWmV3heKy5rgy4XxlJ7g
 a9B/+P3+IywDJP1Icpps2hRQtnY8GqYJh2/DKlVACkAUgQ9w8VXwTTT0v/XBcdsEaI9uSZyuT66
 JZEwX6xy+Vj4Ag8JLSaovTXvoathJC0FcIkf/LmE+ZhCI2pVg1uvVTpL/mx/oBf/+FsUIql+v+E
 iGWm0QWDGEdWa1fDLTBmv226iTyeWS8ZvaatxBRwCbAWf97mJcRv97PIYwNVjQZVzoJtafALIWX
 JJmcyabyzilpuHlsbp0IPAApUEDi7mOf5Wi6eLiIZrjTt6Lrib45IqFDFZo2ur43wufdv3nit0I
 0JboAEfYE3TzC611B1D0Sx8/V4ZPUfzy6vq3v0FD6mDmXRYhxEyIKTjYrrdeNIAqc58n01/mO27
 FY39r/p5a4CpgCKLMPhXjrPrKpN0LD6gd4JIIe9yX55xJbJE48MaRP4muQznTQZzWX7y7LVQGo1
 vA6K
X-Received: by 2002:a05:6000:18a9:b0:487:72f:fb43 with SMTP id
 ffacd0b85a97d-487072ffc5bmr5043867f8f.15.1789492070312; 
 Tue, 15 Sep 2026 10:07:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] target/arm/hvf: implement MDCCSR_EL0 as RAZ
Date: Tue, 15 Sep 2026 18:07:26 +0100
Message-ID: <20260915170735.425445-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Showta Ishizaki <zakinko@snowrabbit.org>

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

Cc: qemu-stable@nongnu.org
Fixes: 37863fff59e0 ("hvf: arm: enable vGIC by default for virt-11.1 and later")
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260905004800.5B560C92F2@bambi.snowrabbit.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index da3ec521fc7..b00a7e1a845 100644
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
2.43.0


