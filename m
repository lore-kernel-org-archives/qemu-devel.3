Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8350BCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA61-00040w-CT; Wed, 29 Oct 2025 13:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5s-0003pa-29
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:22 -0400
Received: from p-east2-cluster4-host8-snip4-4.eps.apple.com ([57.103.78.245]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5U-0003SP-9R
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:19 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 BE4A8180E584; Wed, 29 Oct 2025 17:35:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=UOGHA4PGi6Sk/oKzT0z+MFnVyAcKEZbG5DcuwsP+3fI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=D9zGaxu9wNQOUTOm58A2iZ6CP15dmT1RPkA8pnxLBkES+sqm5Nfn24pmtkjFzXIpSWumNORLMiIo8cYSo22k/ueNgn0RL3iL7VMKiL1y76zOTtDBMZ7oUpAuB0pRzgbtP5phIiISb68M5yuwJYHtOwFzm8Ca7yDkDxaA0OOlYbRY8FHGaEhBPvoEpwuhsEOhD+zDRt5MmNqM7v5br9rxZ/k7hpigdcuisA9kbchqBCaKlw1xcJSKZ4FK9wsC5EDsc79P1UN8C9SrAZ+SA1igFrTKOAq+Qt7oX5QLsLTWdaKtgaVcoKZYZ5mCjBv9CsN6BXfAg7JCQezOUFZglL7NLQ==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 3D35718017A0; Wed, 29 Oct 2025 16:55:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 21/28] whpx: arm64: implement -cpu host
Date: Wed, 29 Oct 2025 17:55:03 +0100
Message-ID: <20251029165510.45824-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX6V96n1Jm+xuM
 gECQInqZjLfG5KG2KGCaUyt45S1208W2LirybLirdeZaCLZ1KHbCZvMknlEN1lxb2jHrFKLGCFs
 bryPCDsaUJU6DJaQLU+LKOpKsmw4fieUyXOjPWeZj8ylQazSAH3myQr/5sZ6GFnGJhOehRrji0h
 TJEXHVtFsNwI61vqdF3rLini+xGVzKMpu23+boWHGB1HVm2ZdtqB0+suiVG4rF49rs6BKS9HnvI
 UC5Bxx2gf9rMeqR1/mpeaXR2E/EUreOCViJVsbg4XuhTwMpO/CFYo9rqvudH7ZpqwCn9FjMW8=
X-Proofpoint-ORIG-GUID: PJueE6EPFzk_Uoo3WP182UDpBJblRUaj
X-Proofpoint-GUID: PJueE6EPFzk_Uoo3WP182UDpBJblRUaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 clxscore=1030 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABx7JyGNJI9H4u5iWDhD4KZ1/WEYiGEcDTrRbWm8N5Pe+zi3+Ty85QRRzlE+yOeIvedMbsl688DL73jOENQruZnnS7zVfkmgP1r+xVs0HC/XU060ayLMO2/DEceOW+kfSzN+aQdCKC6sB7oTFTMj1xC8L+/J3HvFaEMNnXqpYGFTiYVIs2O6QsQWpux7gPV1AdR2az/Fqkz5wiUmZm3B1ia++kf6A5H91aRhjcPRtJJ6ScDjnENsggZdgRRCIL6ElCYubDbFGxdRvX/RiHvZfTWNZ3F8qeyc936jDFM+rSBUwpG/fhsLZ2qVWlOJNq4XfRM4sGiWSDe4lX0fgWX0jajrohrrJpcO7tEevxJ9+9oejBNysIr082KaTRIvt5iKMl83qm5YkKXmNmpcSjZ3kpRdZ+ZZsmEBpyOhzst7sPkCRfLwJwraoGDYUU8Pc0pMRZIkuSQUAnPfqxvFgq1CfJIhkGS7NciVUT1wFS4GQzprB5AQ5xLn7041OtHi5Fytq2Tb90WXtlZA4yz6s5a+NEh+avy+U6+yiXpeNhHKxJFdOj4E8z7dizKMJU8qADVxwwhuQRa2dImwgF4835ZLpaHbDe2eoncp5UlSS9hhf4CKIHwwb+KvRr/Wu4rPb9lR6hMfpYrLUuD1X2UhPekQYxR0C0PwtJRbXNkDoLfm26ZQ2j8nU6uk4BcScMkk5NGvTV4YmK0W5++Ah9zYOmLfbZ7mO6DYvLB+EnD1cTsLByv+2fjkw7hbCuXsj3eTX3petF6PtEyIjSvcxaNBk=
Received-SPF: pass client-ip=57.103.78.245;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
 hw/arm/virt.c              |   2 +-
 target/arm/cpu64.c         |  19 ++++---
 target/arm/whpx/whpx-all.c | 104 +++++++++++++++++++++++++++++++++++++
 target/arm/whpx_arm.h      |   1 +
 4 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 58fa657cae..9ec3cf00f5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3371,7 +3371,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 #ifdef TARGET_AARCH64
         ARM_CPU_TYPE_NAME("cortex-a53"),
         ARM_CPU_TYPE_NAME("cortex-a57"),
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
         ARM_CPU_TYPE_NAME("host"),
 #endif /* CONFIG_KVM || CONFIG_HVF */
 #endif /* TARGET_AARCH64 */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa..3f00071081 100644
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
 #include "hw/qdev-properties.h"
 #include "internals.h"
@@ -522,7 +525,7 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
 
-    if (kvm_enabled() || hvf_enabled()) {
+    if (hwaccel_enabled()) {
         /*
          * Exit early if PAuth is enabled and fall through to disable it.
          * The algorithm selection properties are not present.
@@ -599,10 +602,10 @@ void aarch64_add_pauth_properties(Object *obj)
 
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
@@ -773,6 +776,10 @@ static void aarch64_host_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
     hvf_arm_set_cpu_features_from_host(cpu);
     aarch64_add_pauth_properties(obj);
+#elif defined(CONFIG_WHPX)
+    ARMCPU *cpu = ARM_CPU(obj);
+    whpx_arm_set_cpu_features_from_host(cpu);
+    aarch64_add_pauth_properties(obj);
 #else
     g_assert_not_reached();
 #endif
@@ -780,8 +787,8 @@ static void aarch64_host_initfn(Object *obj)
 
 static void aarch64_max_initfn(Object *obj)
 {
-    if (kvm_enabled() || hvf_enabled()) {
-        /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */
+    if (hwaccel_enabled()) {
+        /* When hardware acceleration enabled, '-cpu max' is identical to '-cpu host' */
         aarch64_host_initfn(obj);
         return;
     }
@@ -800,7 +807,7 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX)
     { .name = "host",               .initfn = aarch64_host_initfn },
 #endif
 };
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 23c7beefaf..8f0a54f080 100644
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
 
 struct whpx_reg_match {
     WHV_REGISTER_NAME reg;
@@ -692,6 +703,99 @@ static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
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


