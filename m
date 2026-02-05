Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC81EC1EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzB1-0000tJ-Dn; Thu, 05 Feb 2026 08:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAx-0000kn-Lv
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:39 -0500
Received: from p-west2-cluster3-host12-snip4-9.eps.apple.com ([57.103.69.42]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAr-0001i9-O5
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:13:37 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 CADE5180024C; Thu,  5 Feb 2026 13:13:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297211; x=1772889211;
 bh=CD7WXAJUs520lYihpYaluR3foYw2WDZXLPihgzEb9wc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HbHn0ZZpAp5LHYQeyqGiP5v595jdOANVK/I14DSnilkJlLiExdvjhaB67lVTKcKs61qLZHjrb4KUCJre5O4KljBqvv2Jk0BwcrFU1TJObt3ZEVUd9BHWv/yni1AwAvw3p9gTOCffRVZieW/Wgb29zlOCrGr1+rQG0IdsUOJnSstqCkzEDXoY9JnzD/kMcMkQ4jYc6RpoUhGA7T1bZtCw4hCY64RV+ydlfUW0svxUmQirza75i6dOKFGbBOkfdFWXQ33n2TvrMMO0aBaKgDkmO7+psPY3f//MKOs/3Pz+4x6pHm8+0R18Jabt+rN6vAon59BPygcGP7wg54TNhKqt+Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 49E4718013AE; Thu,  5 Feb 2026 13:13:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 19/22] whpx: arm64: implement -cpu host
Date: Thu,  5 Feb 2026 14:11:48 +0100
Message-ID: <20260205131155.22780-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=JZCxbEKV c=1 sm=1 tr=0 ts=6984977a
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=L6Cw-x9jAAAA:20 a=KKAkSRfTAAAA:8 a=hGuVB2XOhXFvD5HHq_UA:9
 a=cvBusfyB2V15izCimMoJ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: bzdiac2jdeQmvjDdZBJxNmKCrfh9yQ52
X-Proofpoint-GUID: bzdiac2jdeQmvjDdZBJxNmKCrfh9yQ52
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX43GoRSf4+bej
 b12ufa0BLqNoKYtUNwMG+7kRqaztZwr7pbMP6q5rmK+ZAjJLUj4OaOA47BRjG/V2DqC390ND1uB
 cPKSoRTMn25P1Z62keWoYNhPMHWR1Kb1n6D4JKE1heCbgz/S4Bu1jGbPuDYzdxJSSJo3nfZ+6N/
 DcPY2sjVakICMTgzHWumCyk0N4N7Ho1auyQbl+Bi43MhXvUWQ/dwD3MTBEC0P3VTF/gIkj7loMR
 ZXh3zljl3LZMejZGRSoqo+ug+xuNw0/pGAx+PfGRQ/En3qbvZ7DMGCgnia2wrbNW/Ziz1fdm8qE
 4qKbpUc0kF3jTsA4xJquG2svbANuO+kiT395e85ne9ATrxgAcB0IyVuUV83RLU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1030 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAAB2lJ35GnZEJYOYklxb9myen8Wez/7Sfs8qQVdHRtVGOA+aU7VtM7XlGO6uO/1jQHb/DIbJoqvdr+F9mB3YxwKI6+XAOA60gP75ADHhu2Ig83+CfqFCmuVPHKIyel79cIVIK687mY4nx/sfx05J7bsekY8xu0Cobch0sduTCMhY2n1N+lUQHxFZTFyK+2bZlAOn5j0DLePJhurL1kohQxeJ4W0OcH9IS9wxkRYONHhxZd3DGyoLpKMn2+rFJJXT8I8FVvaRsYhgqDZV4BuW41kakxlWgYXxRp2tbS8VepNHXZvyobLnD2CoujKVjIY2RcM38Ebhf8lIV2urEa7Bt0mDwhQKtzORyXGnseLimwevO2xFxRBPBWroE4w76qAnVrOVmXzESHLPfwYrCUVHc7fu4bABXBudHO+u3EaZma4ZMvHkcBDXWyOHr+foGM6Cw/+hzFDXfNv7G/eADR+OZ7ZfODz8WucjyYitYkZE6jLonR9k9EXbKrGhAjRww18s5oeVbQUnhDivTxdxdYKS6jsEeD07yxbEHXRdKx1N3se1kgtfWrAHAfb6HWfxmYangHJCUvJvSA65zPKLY1xmkP3Body0hDzKri/x0/QopLSjmQkBzKHAybzCqNr3c3WOXkUYWBmlWaowprQ2Mad7p2BeY4ukR94fOa9vBzR1nPkCMobD3jgY37XFCMF9pMqZ3CYXgNbVrBhnYs9b8pbyFc0skizk3xbUjaMJS88Y86DkaofemE/pMGMK8RMqs0pv1QQ0WEBwQM7wlQFlbreNFS/eFGv79bDm7L3zZrFFdL0IqtXu568qld08QpAlcRgYWxvoNw2ULArEjQk3sKyva9frdLN4q55p8CJghEZ+UMA5gUSzrU8H3yhIFcnGInHU7xRxSGAp2Alcvoga8tgJyeuVLi3o3+nE4OQaMxTOqGmp18r8LcN4idRJAXTE+Y=
Received-SPF: pass client-ip=57.103.69.42;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


