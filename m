Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE10E8B39F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0Jz-0001Sg-8R; Thu, 05 Feb 2026 09:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jl-0001AP-GF
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:50 -0500
Received: from qs-2004g-snip4-11.eps.apple.com ([57.103.84.73]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Jj-00083W-J3
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:49 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 983FD180027B; Thu,  5 Feb 2026 14:26:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301606; x=1772893606;
 bh=CD7WXAJUs520lYihpYaluR3foYw2WDZXLPihgzEb9wc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CHdmJ0lZMdnN9Oc7mBYggp9ZFUodjKcDagevcLd0d67wGJcW8K82+SwnzIWTqI8lh78EmfH/FyOVGKMW7X+Gobl0g/0ObQZ82TGQgn/9C+UJRigGaNWyOUzBdPWsfYZ33lEhMmvR3F4SbObnD4rXtLDhBl2xceljVF3GggjzrHyKPHPveZ1rkIGLObKDICdhEatIlh10qP0huBS3auc4e5NZvypDkKNm11WBgU+32T7zGJv1U+m8TirmeCPay/YAfXCSXm/N8Jwj0PsHUjEzNBLiOUcy2yYMEuoQs8ZVNq3sCiBnjaVbcuc4AFmK5o/neQpRrj5SB/M82mGpgchSSw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 5FDC11800D80; Thu,  5 Feb 2026 14:26:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 19/22] whpx: arm64: implement -cpu host
Date: Thu,  5 Feb 2026 15:25:37 +0100
Message-ID: <20260205142543.64818-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=WZMBqkhX c=1 sm=1 tr=0 ts=6984a8a5
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=L6Cw-x9jAAAA:20 a=KKAkSRfTAAAA:8 a=hGuVB2XOhXFvD5HHq_UA:9
 a=cvBusfyB2V15izCimMoJ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: KavsYq3HQTQ7uxsPy37QHvw6vfekIXQy
X-Proofpoint-GUID: KavsYq3HQTQ7uxsPy37QHvw6vfekIXQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX92lobvA2u2tj
 pGHIdD2e8pbWLMkU06MBN5gSYW+sPvTtteld+iCesmbJC95zWNFg3xpw8YhXdFdtnnmA7p59v1T
 Cd4knHXzWrxIgJZq71g2hCFq8uIGJeWiXwG2TfegpMatHPdrnaTUjaRgt0S5BTgG4HzwbP08ph6
 Zr+suswopBCwTVG4lGUkMwK9Psw4zXzQZDKXoqvrpWoTLAGZE7FTct/PcTCb1mzWy8xteKX0PbN
 n7OKBDwczrvsSPoN6+GYv/nBkU1GOzvSf7yGo5ERzBp/Cg0yPG1FvVC24I0tiIibzWyXQbgAULd
 MXcj1ruskOqFRwV4KGvT/iSGNdrcRUqbrQQIYYElqPWtrUAthsJPgFL+ALp6f8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 clxscore=1030 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABnMm6CgCZsKvwk732CQANZjwnT6KVXPCBeFV2jco9ptCwJ5hteyfGSN47eElOoqC/o2FvqBb+MzL98M7G0K5TzAl2Rymij78trhDshlSiD8yUOGD6vipq796cpt2zqlpzYu3nS23W0roNX5TqRmzKsiG7X6eJFW8TV2nGNYygcFkwly77hy/gGWLiVc4/ERkHH8qnOU/u56MzuRupV/Jxsgipur8F/Ja8TWXI8qv/7h3aLNjJGZCG8if5NvhBL4pWN7W5oqaSbwkS6GDlxr8Ga411p0P4SqSEp9WhNUMWHk2bvACd/7I4ngP6xmL9YzlH+gmwdi/WgsUvGfQZC1CxVeBW+SxoATgSy3a/tC/Ke5wcjOHr5DvY/Dgw8LnbpgcKwXqzDuCG7lNxo6owh8M+SjVei+nN2DLesV9ZnL8m3ifIjw9iAYlKlgJmuy9GOuWxm05xxBbLJ7OKvYHnkV5aRRg1CBbizpCEi8qnBRdvDD3tgh3Nx7/wsKdw7cylxcRIH6DAr81YaVwn+hm2t4xh+Hh2/lU9NHraEPzjJ76CC9PrBUGPwEz89UdS2pix283Ic5SD3w9MHiIlHEJrhqzUrB3lfGSHcZuLDR+1by34KNOUv6UD/c8Hrb0ack1KiAZlftys0mx6KyV869+VGFccdNiJ6LfpALPNrvmRejY+4xk2aLKRF2aiGAcdh0ZLYfhuuEk2/V1jqPoGRBLAzbPANYspkYO9jj9ozLEVO1mliHKvbmc4okRUuJgMpwfvxAWFbbKwgoUAke2Rs2HsSlRQJh5iQE8LZPgXXhV+FdvEazydTMxFAZoZ1/EZOCLffSOeJHF0/VNctdv08wlpJVf/uzHgeAgbczKjiLu8O6MAo/LU5xle8gU+6XLh9BaYxxZsXrUaQJ0URS6VSvHwLZ9PKtqarh7TOx9ycS6krzyP2+0226l29qkA8N5Uawhc
Received-SPF: pass client-ip=57.103.84.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Logic to fetch MIDR_EL1 for cpu 0 adapted from:
https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c74/Source/Windows/Common/CPUFeatures.cpp#L62

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/cpu64.c         |  17 +++---
 target/arm/whpx/whpx-all.c | 104 +++++++++++++++++++++++++++++++++++++
 target/arm/whpx_arm.h      |   1 +
 3 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4dfc03973e..5d7c6b7fbb 100644
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
index 6067918b27..c88c67a9e2 100644
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


