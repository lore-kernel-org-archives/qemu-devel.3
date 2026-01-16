Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AA1C79FBF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHa-0005LU-A7; Fri, 16 Jan 2026 08:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGh-0003Vu-0e
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:41 -0500
Received: from ci-2004c-snip4-11.eps.apple.com ([57.103.89.33]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGc-0002JK-EV
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:36 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 748FF180F92B; Fri, 16 Jan 2026 13:53:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=HoyZLQTD9CWAvpmTbVwar6BKDtZmlfBCL6vzGLuGvVk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AO4JmXc4UytUmjTcHUCF5oswy8hwODB0Bxg/C/cFIrp0U0QHeWSM3nY9JmhA7cXxCbwCLGeGTM3vNK4SC9t7AxtdzFaIe6mdRhRpQ00KLZ0g9EUYAOpE8m4uOIoXj84tVWMM++NsB1vYZEByZxrruYDDueTycBLiflZRrUn4rJ5xYGx8Q5WXtS9HOCH1kM05MwX4eEjClsoRdvRDpG0XcJAC/tJnKeCm07Xp04Nj/iKj3J1cSIRXy4Tca/oDe+e2DQMck4Tuw5SYYd5/uH800kD1XiC3LDs09OU14lJfKIqZtnOkIkE5ZdMTEEdcGTvoJrzeQ8eI/3xxRCOdJGeN0w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 8249C1800212; Fri, 16 Jan 2026 13:53:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 20/26] whpx: arm64: implement -cpu host
Date: Fri, 16 Jan 2026 14:52:29 +0100
Message-ID: <20260116135235.38092-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FTGNxnyGqBZfEghlXtkcfdMFdU9lCmOW
X-Authority-Info: v=2.4 cv=VLvQXtPX c=1 sm=1 tr=0 ts=696a42db
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=L6Cw-x9jAAAA:20 a=KKAkSRfTAAAA:8 a=hGuVB2XOhXFvD5HHq_UA:9
 a=cvBusfyB2V15izCimMoJ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: FTGNxnyGqBZfEghlXtkcfdMFdU9lCmOW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX0F6l2Gq+Qn/A
 l1psG774rc2PFOxnZ0tCxVxJqUWYGhj4blu1KBAmxW0aczICxlTJJlzS5IYi41rZ0mxIz0y3B2o
 GK78KbIjUcBf6G9xYG4vnaTbQASGyYJsS0wXpyVXmrj6GvRIEvWEkSwddh5b6sxpgNPY0hmJLRf
 kxQR5IG9Qfsnb/zTlBFKGkkWPbx+4lGHzL11M12HzLjaR+/7cFFSmsjSJlFHsLNRQWrZzVoP7sD
 xm7dr+e6ogAmeTy+nARtudPuh3GahyPaT0F5lgZ0K8ZZgumRi+fZ6sj7Zb6iN7RN23tbzrLGWaj
 lQvGjNCrgkAOUB/ziPc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxscore=0
 clxscore=1030 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABGUmUgyVtRqSWQ/rpT892XqFpz6/lgmYzcYWCpfRTs5ou4+7iZ0huMpCiNK6GVG6MIiGhUhEUjEgrgd1grzCkWcCSeViSELr5U1Ap1OuGmbfbZQdSXt26Fnfr/pUxwUq6Q+ZpNRFTN/KpNWiVvbrBfrVE83yNaaj8d5ADVRupNqOlTWP2aRJ/yVbp3dbOIbNNQcrU1QIbmJmuDIKbenkr/iZj4s3rbINbV47LEndmqRoIrr0jT2Uf5W8TIb2huPN98eVzC9T3sJ/f/gNzSHw5ZUvLwyOlyibeeGEk0Dpy0q8nxo+ZXKPVMrj9RW7ypYgy2IIum6p8h0hxjQjpeh5ihG0AzCToxMENjiDtuMMiqGk5mPMEWBsKDp9EirwHT0O5EeNrwoDdbkX8lCWMiVysVytr6xipufaYYL0dX0l8fdVbR9T4ZZjD4kDD1YyHpI1shC014OFY7QmrwHyYC9lTtzErcw3HY/Wsp0YvvOC0K9CVCGOL4Gpm6WuLZXnVjaQNNZZh8ZH7dU5OE6cbl6lnjos8p6vTuZx2mJgA+lzMtgpJggTgUHDqFZEBeztcy5bqpOsR6nr5aADcS+AQh4h6oS4+rMGL3MEKBLkMlh67x4vc8ip5fjH4tVOjLgaFRJQJxa9G2WTMXTViq95ol9RybLulNFHqKwsWZkjPxkg3Z6+OV7oBx00ODuPLjphsQ+gkkWz7evTlas4WWKSVJIkykDQfEJelc874e8ykFRcOGcYDfuN4r6p5P04S79tcToOEVyLdBAnVHPyIjaBD8RIHQ3EbYzkMgCym+P+4uzoyYOMKZ8bF/wwctKvj+e07iA==
Received-SPF: pass client-ip=57.103.89.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Logic to fetch MIDR_EL1 for cpu 0 adapted from:
https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c74/Source/Windows/Common/CPUFeatures.cpp#L62

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu64.c         |  17 +++---
 target/arm/whpx/whpx-all.c | 104 +++++++++++++++++++++++++++++++++++++
 target/arm/whpx_arm.h      |   1 +
 3 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index bf30381370..689babe822 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -26,10 +26,13 @@
 #include "qemu/units.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/whpx.h"
+#include "system/hw_accel.h"
 #include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
+#include "whpx_arm.h"
 #include "qapi/visitor.h"
 #include "hw/core/qdev-properties.h"
 #include "internals.h"
@@ -521,7 +524,7 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
 
-    if (kvm_enabled() || hvf_enabled()) {
+    if (hwaccel_enabled()) {
         /*
          * Exit early if PAuth is enabled and fall through to disable it.
          * The algorithm selection properties are not present.
@@ -598,10 +601,10 @@ void aarch64_add_pauth_properties(Object *obj)
 
     /* Default to PAUTH on, with the architected algorithm on TCG. */
     qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_property);
-    if (kvm_enabled() || hvf_enabled()) {
+    if (hwaccel_enabled()) {
         /*
          * Mirror PAuth support from the probed sysregs back into the
-         * property for KVM or hvf. Is it just a bit backward? Yes it is!
+         * property for HW accel. Is it just a bit backward? Yes it is!
          * Note that prop_pauth is true whether the host CPU supports the
          * architected QARMA5 algorithm or the IMPDEF one. We don't
          * provide the separate pauth-impdef property for KVM or hvf,
@@ -769,6 +772,8 @@ static void aarch64_host_initfn(Object *obj)
     }
 #elif defined(CONFIG_HVF)
     hvf_arm_set_cpu_features_from_host(cpu);
+#elif defined(CONFIG_WHPX)
+    whpx_arm_set_cpu_features_from_host(cpu);
 #else
     g_assert_not_reached();
 #endif
@@ -779,8 +784,8 @@ static void aarch64_host_initfn(Object *obj)
 
 static void aarch64_max_initfn(Object *obj)
 {
-    if (kvm_enabled() || hvf_enabled()) {
-        /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */
+    if (hwaccel_enabled()) {
+        /* When hardware acceleration enabled, '-cpu max' is identical to '-cpu host' */
         aarch64_host_initfn(obj);
         return;
     }
@@ -799,7 +804,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bd88e9b57e..78ec109589 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -41,6 +41,17 @@
 
 #include <winhvplatform.h>
 #include <winhvplatformdefs.h>
+#include <winreg.h>
+
+typedef struct ARMHostCPUFeatures {
+    ARMISARegisters isar;
+    uint64_t features;
+    uint64_t midr;
+    uint32_t reset_sctlr;
+    const char *dtb_compatible;
+} ARMHostCPUFeatures;
+
+static ARMHostCPUFeatures arm_host_cpu_features;
 
 typedef struct WHPXRegMatch {
    WHV_REGISTER_NAME reg;
@@ -668,6 +679,99 @@ static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
     SET_IDREG(isar, ID_AA64MMFR0, id_aa64mmfr0);
 }
 
+static uint64_t whpx_read_midr(void)
+{
+    HKEY key;
+    uint64_t midr_el1;
+    DWORD size = sizeof(midr_el1);
+    const char *path = "Hardware\\Description\\System\\CentralProcessor\\0\\";
+    assert(!RegOpenKeyExA(HKEY_LOCAL_MACHINE, path, 0, KEY_READ, &key));
+    assert(!RegGetValueA(key, NULL, "CP 4000", RRF_RT_REG_QWORD, NULL, &midr_el1, &size));
+    RegCloseKey(key);
+    return midr_el1;
+}
+
+static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
+{
+    const struct isar_regs {
+        WHV_REGISTER_NAME reg;
+        uint64_t *val;
+    } regs[] = {
+        { WHvArm64RegisterIdAa64Pfr0El1, &ahcf->isar.idregs[ID_AA64PFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Pfr1El1, &ahcf->isar.idregs[ID_AA64PFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Dfr0El1, &ahcf->isar.idregs[ID_AA64DFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Dfr1El1 , &ahcf->isar.idregs[ID_AA64DFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar0El1, &ahcf->isar.idregs[ID_AA64ISAR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar1El1, &ahcf->isar.idregs[ID_AA64ISAR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Isar2El1, &ahcf->isar.idregs[ID_AA64ISAR2_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr0El1, &ahcf->isar.idregs[ID_AA64MMFR0_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr1El1, &ahcf->isar.idregs[ID_AA64MMFR1_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr2El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] },
+        { WHvArm64RegisterIdAa64Mmfr3El1, &ahcf->isar.idregs[ID_AA64MMFR2_EL1_IDX] }
+    };
+
+    int i;
+    WHV_REGISTER_VALUE val;
+
+    ahcf->dtb_compatible = "arm,armv8";
+    ahcf->features = (1ULL << ARM_FEATURE_V8) |
+                     (1ULL << ARM_FEATURE_NEON) |
+                     (1ULL << ARM_FEATURE_AARCH64) |
+                     (1ULL << ARM_FEATURE_PMU) |
+                     (1ULL << ARM_FEATURE_GENERIC_TIMER);
+
+    for (i = 0; i < ARRAY_SIZE(regs); i++) {
+        clean_whv_register_value(&val);
+        whpx_get_global_reg(regs[i].reg, &val);
+        *regs[i].val = val.Reg64;
+    }
+
+    /*
+     * MIDR_EL1 is not a global register on WHPX
+     * As such, read the CPU0 from the registry to get a consistent value.
+     * Otherwise, on heterogenous systems, you'll get variance between CPUs.
+     */
+    ahcf->midr = whpx_read_midr();
+
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&ahcf->isar);
+
+    /*
+     * Disable SVE, which is not supported by QEMU whpx yet.
+     * Work needed for SVE support:
+     * - SVE state save/restore
+     * - any potentially needed VL management
+     * Also disable SME at the same time. (not currently supported by Hyper-V)
+     */
+    SET_IDREG(&ahcf->isar, ID_AA64PFR0,
+              GET_IDREG(&ahcf->isar, ID_AA64PFR0) & ~R_ID_AA64PFR0_SVE_MASK);
+
+    SET_IDREG(&ahcf->isar, ID_AA64PFR1,
+              GET_IDREG(&ahcf->isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
+
+    return true;
+}
+
+void whpx_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    if (!arm_host_cpu_features.dtb_compatible) {
+        if (!whpx_enabled() ||
+            !whpx_arm_get_host_cpu_features(&arm_host_cpu_features)) {
+            /*
+             * We can't report this error yet, so flag that we need to
+             * in arm_cpu_realizefn().
+             */
+            cpu->host_cpu_probe_failed = true;
+            return;
+        }
+    }
+
+    cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
+    cpu->isar = arm_host_cpu_features.isar;
+    cpu->env.features = arm_host_cpu_features.features;
+    cpu->midr = arm_host_cpu_features.midr;
+    cpu->reset_sctlr = arm_host_cpu_features.reset_sctlr;
+}
+
 int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
diff --git a/target/arm/whpx_arm.h b/target/arm/whpx_arm.h
index de7406b66f..df65fd753c 100644
--- a/target/arm/whpx_arm.h
+++ b/target/arm/whpx_arm.h
@@ -12,5 +12,6 @@
 #include "target/arm/cpu-qom.h"
 
 uint32_t whpx_arm_get_ipa_bit_size(void);
+void whpx_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
 #endif
-- 
2.50.1 (Apple Git-155)


