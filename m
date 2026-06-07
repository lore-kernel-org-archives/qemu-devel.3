Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F9CCD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWI8z-0008Ia-Dd; Sun, 07 Jun 2026 14:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wWI8x-0008Hf-Rt; Sun, 07 Jun 2026 14:22:43 -0400
Received: from mail-07.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wWI8u-0001L7-KV; Sun, 07 Jun 2026 14:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1780856551; x=1781115751;
 bh=ZQdAkYVIFVaTOqJuW8j/vIjhopqCarqaDjawrzt2kCU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Lkr51H0LOWhOiK+d/yEhs+wrIyZOTkXPZxXLD/vUJv6Sg5olJHoAiAERomCsUQNNU
 589prkdYzL4olq3Eks09E5rqyiS/JPrW+pUeLm9yZteZSpqFLNswG7UW08VL9chssY
 1jtWBpA5BlQ+xoGrpua0O3lX8+pdY28Am8H6bNMz5wxbKGZvcyJ+d3mRC1jrSmtjc6
 pSaJWg1hcTdGtnnJRgGLkvR83x8Hd5OSrw/IrkI5mAz0W8aDAUJuGymbcbPTVlYYkR
 45HEpWUF3OQIJsrsja+Iue69vbxaJTUy5LiQnhL7mVqc2f3Dy6ZKmPAyCnbA46zSjH
 jCBDpnr+6Ou5g==
Date: Sun, 07 Jun 2026 18:22:26 +0000
To: agraf@csgraf.de, peter.maydell@linaro.org
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, zenghui.yu@linux.dev,
 richard.henderson@linaro.org
Subject: [PATCH] target/arm/hvf: manually sync ID_AA64ISAR0_EL1 on vCPU init
Message-ID: <20260607182221.4357-1-wrigjl@proton.me>
In-Reply-To: <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 00ef15f4273d06cd7b6cf38421dc48d0aeef72f8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139; envelope-from=wrigjl@proton.me;
 helo=mail-07.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Commit 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
gave ID_AA64ISAR0_EL1 a readfn so the RNDR field can reflect SCR_EL3.TRNDR
at read time, and marked the cpreg ARM_CP_NO_RAW in the system-emulation
path.  HVF then trips its hvf_arch_init_vcpu() assertion that no ID
register in hvf_sreg_list[] is NO_RAW, aborting on boot on Apple Silicon:

  Assertion failed: (!(ri->type & ARM_CP_NO_RAW)),
  function hvf_arch_init_vcpu, file hvf.c, line 1442.

Reproduce with:

  qemu-system-aarch64 -M virt,accel=3Dhvf -cpu host \
                      -nographic -display none -bios /dev/null

Mirror the existing treatment of ID_AA64PFR0_EL1: move
HV_SYS_REG_ID_AA64ISAR0_EL1 into the SYNC_NO_RAW_REGS block in
sysreg.c.inc so the assert loop skips it, and push QEMU's view of the
register to the vCPU at init time.  HVF does not expose EL3, so
SCR_EL3.TRNDR is never set and the readfn is functionally static there.

Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
Fixes: 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
Signed-off-by: Jason Wright <wrigjl@proton.me>
---
 target/arm/hvf/hvf.c        | 4 ++++
 target/arm/hvf/sysreg.c.inc | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d88cbe7c82..afa1120c8a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1485,6 +1485,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1=
, pfr);
     assert_hvf_ok(ret);
=20
+    ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64ISAR0_EL=
1,
+                              GET_IDREG(&arm_cpu->isar, ID_AA64ISAR0));
+    assert_hvf_ok(ret);
+
     /* We're limited to underlying hardware caps, override internal versio=
ns */
     ret =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL=
1,
                               &arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX])=
;
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index c11dbf274e..acd5a41364 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -89,13 +89,13 @@ DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 2, 0, 0, 2, 0)
 DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 3, 0, 0, 0, 0)
 DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 3, 0, 0, 0, 5)
 DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 #endif
=20
 DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
 /* Add ID_AA64PFR2_EL1 here when HVF supports it */
 DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
-DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
=20
 #ifdef SYNC_NO_MMFR0
--=20
2.50.1 (Apple Git-155)



