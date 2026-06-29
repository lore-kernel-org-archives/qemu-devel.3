Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE80C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weIyC-0007dH-Jt; Mon, 29 Jun 2026 16:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1weIy5-0007cG-Bf
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 16:52:38 -0400
Received: from mail-07.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1weIy2-0003mF-8X
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 16:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1782766348; x=1783025548;
 bh=cYZuK3L4fb+u9YkmTSUeayMNWrYv9vEAXHix1FDvTJE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=AQ3BnLTDxemHjjuM01I3Bc2bndVazBb+y0XiKyUCy9n9sHJ/anoQWbX4skiB8SA4i
 58I504xY7vgR5lsX2sKExFe9uGR2wDNzDTB1APwjhIURyd34yruj79mQfltYjp2gEd
 KopI/eVrghn8VaS+a0JIZgVcdOApre5cTEjot/DVbAqzcF2mth7Y8QeyY0ybAiPZ1F
 fmGhRg/wdRSVAdgJYyskXmpxpVPlIDs8goJjZqLYaf+YH9Pk3jZh2M64eXRSaQSKQe
 oALqPkhWBdA1lyc0FjydnKOsBHdGp6lXhn1weeKCIxSIMns7Kyp+HwQ5l1rRv4AEFJ
 EJybXLJGUkm2w==
Date: Mon, 29 Jun 2026 20:52:20 +0000
To: agraf@csgraf.de, peter.maydell@linaro.org
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, zenghui.yu@linux.dev,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com
Subject: [PATCH v2] target/arm/hvf: seed NO_RAW ID registers from
 isar.idregs[] on vCPU init
Message-ID: <20260629205213.82391-1-wrigjl@proton.me>
In-Reply-To: <20260607182221.4357-1-wrigjl@proton.me>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
 <20260607182221.4357-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: ee5992eac7c9bbebde04f132a034bf80ddc9c0e4
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
  function hvf_arch_init_vcpu, file hvf.c, line 1441.

Reproduce with:

  qemu-system-aarch64 -M virt,accel=3Dhvf -cpu host \
                      -nographic -display none -bios /dev/null

Fix it the same way ID_AA64PFR0_EL1 already is: list
HV_SYS_REG_ID_AA64ISAR0_EL1 in the SYNC_NO_RAW_REGS block in sysreg.c.inc
so the assert loop skips it, and seed the vCPU's copy at init time.

While here, unify how the three isar.idregs[]-backed ID registers are
seeded.  isar.idregs[] already holds QEMU's intended value for each (the
host caps, probed once at realize via hv_vcpu_config_get_feature_reg(),
plus any QEMU adjustment), so there is no need to read each register back
from the vCPU first.  Seed PFR0, ISAR0 and MMFR0 directly from
isar.idregs[], dropping the two per-vCPU hv_vcpu_get_sys_reg() reads:

  - PFR0: take the GIC sysreg-interface bit from env->gicv3state, as the
    id_aa64pfr0_read() readfn does.  Identical to the previous code
    whenever a GICv3 sysreg interface is present (the configuration HVF
    runs in practice); it differs only in that a vCPU with no GICv3 now
    reports ID_AA64PFR0_EL1.GIC =3D=3D 0 instead of inheriting the host's
    value, which matches the field's meaning.
  - ISAR0: no overlay is needed; HVF does not expose EL3, so
    SCR_EL3.TRNDR is never set and the readfn is constant.
  - MMFR0: still clamp PARANGE to the chosen IPA size, updating
    isar.idregs[] in place because the page-table walker and the
    ID_AA64MMFR0_EL1 cpreg resetvalue read PARANGE back from there.

Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 887eaa8a29 ("target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS")
Signed-off-by: Jason Wright <wrigjl@proton.me>
---
v1 of this fix-up added a third way of seeding an ID register into the
vCPU at init, and Peter asked why hvf_arch_init_vcpu() should now have
three different shapes for the isar.idregs[]-backed registers, and whether
the existing per-register hv_vcpu_get_sys_reg() re-reads are needed at all.

v2 unifies the three.  isar.idregs[] is seeded once at realize from
hv_vcpu_config_get_feature_reg() (plus QEMU's own adjustments), so it
already holds the value we want to push; the init-time re-reads of PFR0
and MMFR0 are redundant.  v2 drops both and seeds PFR0, ISAR0 and MMFR0
directly from isar.idregs[].

I confirmed the re-reads are redundant by logging, at init, the seeded
isar.idregs[] value against hv_vcpu_get_sys_reg() for each register on an
Apple Silicon host (-cpu host):

  PFR0  seed=3D1101000010110011 live=3D1101000011110011  (differ in GIC onl=
y)
  MMFR0 seed=3D000010000f100022 live=3D000010000f100022  (identical)
  ISAR0 seed=3D0221100110212120 live=3D0221100110212120  (identical)

PFR0 differs only in the GIC field [27:24], which QEMU already overlays
from env->gicv3state in id_aa64pfr0_read(); MMFR0 and ISAR0 are identical.

Two things worth flagging:

  - PFR0 now takes the GIC bit purely from env->gicv3state rather than
    OR-ing it onto the host's value.  Identical for any guest with a GICv3
    sysreg interface (what HVF runs in practice); it only changes a vCPU
    with no GICv3, which now reports ID_AA64PFR0_EL1.GIC =3D=3D 0 instead o=
f
    inheriting the host bit -- arguably the correct value.

  - MMFR0 still clamps PARANGE to the chosen IPA size and writes it back
    into isar.idregs[], because the page-table walker and the
    ID_AA64MMFR0_EL1 cpreg resetvalue read PARANGE from there.  It is the
    one register that still updates isar.idregs[]; that tracks a real
    consumer, not an inconsistency.

Tested on macOS arm64 (Darwin 25.5.0), master 20553466cc:
  - HVF -cpu host vCPU init: no assertion (was SIGABRT before).
  - meson test --suite qtest-aarch64: 29/29 pass (3 skipped).
  - checkpatch clean.

v2:
  - Unify PFR0/ISAR0/MMFR0 seeding; drop the redundant
    hv_vcpu_get_sys_reg() re-reads for PFR0 and MMFR0 (Peter Maydell).
  - Take PFR0.GIC from env->gicv3state directly.
  - Reword the subject and commit message accordingly.

 target/arm/hvf/hvf.c        | 10 ++++------
 target/arm/hvf/sysreg.c.inc |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8b902c6882..6310cfaf3e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1478,20 +1478,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->mp_affinity);
     assert_hvf_ok(ret);
=20
-    ret =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1=
, &pfr);
-    assert_hvf_ok(ret);
+    pfr =3D GET_IDREG(&arm_cpu->isar, ID_AA64PFR0);
     pfr |=3D env->gicv3state ? (1 << 24) : 0;
     ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1=
, pfr);
     assert_hvf_ok(ret);
=20
-    /* We're limited to underlying hardware caps, override internal versio=
ns */
-    ret =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL=
1,
-                              &arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX])=
;
+    ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64ISAR0_EL=
1,
+                              GET_IDREG(&arm_cpu->isar, ID_AA64ISAR0));
     assert_hvf_ok(ret);
=20
     clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
     ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL=
1,
-                              arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]);
+                              GET_IDREG(&arm_cpu->isar, ID_AA64MMFR0));
     assert_hvf_ok(ret);
=20
     if (!hvf_irqchip_in_kernel()) {
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



