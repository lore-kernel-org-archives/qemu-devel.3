Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586B3C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1yeV-0003dW-1g; Thu, 03 Sep 2026 00:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x1yeS-0003bm-Mt
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:02:12 -0400
Received: from mr-2004g-snip6-7.eps.apple.com ([2a01:b747:3000:203::44]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x1yeP-0000Pq-AX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:02:12 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPS id
 82F47180009E; Thu, 03 Sep 2026 04:02:05 +0000 (UTC)
X-ICL-RepId: 01a0656e-5849-7c13-9243-03418ca2bdfe
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsBQA1IAlgARQVED0oEQARGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788408126; x=1791000126;
 bh=G0sCQVy5ZVMJ7d5IcnGa5M5Elqj0GnZy6UVJUHpnpX8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=zQlXOq/j9pdGCsHfqgpigtJA8FhIfFgegWi0RyNPNUq26/9gBOuGC9TGDak2FVfeNnctIeTZEQRCspf8JYx10ykYt3U/jM+4GqjuvIOGrfnX8Iz9PRFP2kifiUKXuwtfWDZYkuvgf/ACTYA/vA8morHd+7jEiXSpalLNQhICXKmbgaXD6LvCN2R0VhqxUKZbVKYgN1DNHABP9R+ukJVWXNAQoc/J5ymNBS84YvzEs0drmY6WfbKjHS1GCg2xWm3Ll3DgS9cywK0Cu0pA7Ivtesw9E9PPEB4XrIKufMR1XnM795dYPVMRRT1oWTaFLExvxR0b3loaePewxOVSLyfh9A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPSA id
 DF14D18001FF; Thu, 03 Sep 2026 04:02:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 2/3] hvf: arm: add experimental VHE toggle
Date: Thu,  3 Sep 2026 06:01:56 +0200
Message-ID: <20260903040157.74627-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903040157.74627-1-mohamed@unpredictable.fr>
References: <20260903040157.74627-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMyBTYWx0ZWRfXz0Cypdgj2MX/
 0M0Ayrd/vJlVMoTJnDCRmO9ettO9H8hT0UWwOJsOvOECklI1vLj2iWtetdAv0QkIQAfjG3fo/1U
 ycI04nTONLvaO7MjOQ2Pc/WFW++nJ+0R71COotFhtm2mURqDEAd17YiNltiak84mpreTnUoma1N
 kuFBkINti13IRRyC6Sxmn5LPvsz0pW6/l+BofJn5vGyk89Pr9jj9FEU6YgRIW9aQPK0qoYiUzMG
 GtRGQQGIRnNegcPBla8+r+HlSv0en/ar75Pq/BjKo9riUno89/nf074W1/xnH+JLBp/O2uMr2xs
 w02jqmjo6BLl5t4vKfMDUnMP5ZvkkhfPDwjXk8ZvmACT6lzD+66s8j3Q1WbIF4=
X-Proofpoint-ORIG-GUID: YUs0t38_egglKpYVHpGL_vsij_SHjWPq
X-Authority-Info-Out: v=2.4 cv=JpD8bc4C c=1 sm=1 tr=0 ts=6a98f13d
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Uy8BaTlr5CIEmbXmnWEA:9
X-Proofpoint-GUID: YUs0t38_egglKpYVHpGL_vsij_SHjWPq
X-JNJ: AAAAAAABeyo7MAwrMgwFU06vnOnGsUS9+PQy/Qf9mosR444BYnmSHMkKhJtkCkDgF+xTykXMgpS0fQhjzqO0h9fP7uNtLuOSJ7mq/P2Cf58hxjpN5WCKbJ1TxKWxDcfjqQdd6mtlSNZFGRZ9d0L/mOhYui+KNyROhHSuAHtS+YfmeGcxzAcl33iSK+lNF+Ny/dKt/d1HjJQH5O+0DBixihRjZnoi81XMFQppCDPu9zKNXhARMvmo+S0FH6koXDWpPadQOhUGBUnOP3+grBniUV+qs1WZfWpHVLCQE7P7aYpKUpbfB5vuFNF4zHQiz8SkbUrAMeBz08pKt1fb4cc6U8r44+BLCKpzA4ByekrRHocxqofZPIPR4Ph9aesMPzzshOrFm4U03aKH+7sahyYtxvjlwR6Au94EOeVm8Kc8WCkgObaG6dBDJz53WgYSRAmYe3mJ4xq5/T1VIKspTLD8H5hsBFoIiVZvj0rygJNkmVd4Q45WS6yT/P2V3HmaM1zQ4UoXXGudI1QyC4+X4keapKmv3TM/knNFI0O9ZlJ0rCq0Ctiz6PvnXNNgiCu+AQUyLRmzmle/Pxq2NgFOD2b+D9jjmeQ0M4f01sP7EGJ8L9k5/RnPS0eXPOwDSM7yf0PUbG2DTKr4DbYIxGr2x+CzsDnKGUN9ywfN4Z7w+dnQavwyXUzb3DZnU7zOpOapSrhbAFJJn/LUS9iEP42RZOlrGbrm3wH2u+7SkLDlGSobxWOgTsLGhv2CWCUzN52p+5qIwq2mfIlDKw==
Received-SPF: pass client-ip=2a01:b747:3000:203::44;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

macOS 27.0 ships with an experimental VHE enablement
private API. Expose support for it as x-vhe.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-all.c      |  2 +
 include/system/hvf_int.h |  1 +
 target/arm/hvf/hvf.c     | 89 ++++++++++++++++++++++++++++++++++++++++
 target/i386/hvf/hvf.c    |  4 ++
 4 files changed, 96 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 8bd9154a50..bbff3c6867 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -282,6 +282,8 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure HVF irqchip");
+
+    hvf_arch_accel_class_init(oc);
 }
 
 static const TypeInfo hvf_accel_type = {
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index a01691ce17..44ae2e7c4c 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -110,5 +110,6 @@ int hvf_update_guest_debug(CPUState *cpu);
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
+void hvf_arch_accel_class_init(ObjectClass *oc);
 
 #endif
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f881d6cc67..b61554e108 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -22,6 +22,7 @@
 #include "cpu-sysregs.h"
 
 #include <mach/mach_time.h>
+#include <dlfcn.h>
 
 #include "system/address-spaces.h"
 #include "system/memory.h"
@@ -39,6 +40,7 @@
 #include "target/arm/trace.h"
 #include "trace.h"
 #include "migration/vmstate.h"
+#include "migration/blocker.h"
 
 #include "gdbstub/enums.h"
 
@@ -1132,6 +1134,60 @@ static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
     SET_IDREG(isar, ID_AA64MMFR0, id_aa64mmfr0);
 }
 
+bool hvf_vhe;
+
+static void hvf_set_vhe(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        if (__builtin_available(macOS 27.0, *)) {
+            hvf_vhe = true;
+        } else {
+            error_report("VHE emulation not supported on this system.");
+        }
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        hvf_vhe = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        /* Experimental feature as of macOS 27.0 */
+        hvf_vhe = false;
+        break;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
+static bool hvf_get_vhe(void)
+{
+    return hvf_vhe;
+}
+
+void hvf_arch_accel_class_init(ObjectClass *oc)
+{
+    hvf_vhe = false;
+
+    object_class_property_add(oc, "x-vhe", "OnOffAuto",
+        NULL, hvf_set_vhe,
+        NULL, NULL);
+    object_class_property_set_description(oc, "x-vhe",
+        "Configure experimental VHE enablement");
+}
+
 static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     ARMISARegisters host_isar = {};
@@ -1227,6 +1283,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (hvf_nested_virt_enabled()) {
         /* SME is not implemented with nested virt on the Apple side */
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
+        if (hvf_get_vhe()) {
+            FIELD_DP64_IDREG(&host_isar, ID_AA64MMFR1, VH, 0x1);
+        }
     }
 
     /*
@@ -1357,6 +1416,36 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
         }
     }
 
+    if (hvf_get_vhe()) {
+        Error *vhe_migration_blocker = NULL;
+        Error* errp;
+
+        void* hvf = dlopen("/System/Library/Frameworks/Hypervisor.framework/Versions/A/Hypervisor", RTLD_LOCAL);
+
+        if (!hvf) {
+            /* Unreachable. */
+            error_report("Failed to dlopen() Hypervisor.framework.");
+            goto cleanup;
+        }
+
+        /* Experimental API: might change before release. */
+        hv_return_t (*_hv_vm_config_set_vhe_enabled)(hv_vm_config_t cfg, bool vhe) = dlsym(hvf, "_hv_vm_config_set_vhe_enabled");
+        if (!_hv_vm_config_set_vhe_enabled) {
+            error_report("_hv_vm_config_set_vhe_enabled API not available.");
+            goto cleanup;
+        }
+        _hv_vm_config_set_vhe_enabled(config, true);
+
+        error_setg(&vhe_migration_blocker,
+        "Live migration disabled because VHE support is experimental");
+        if (migrate_add_blocker(&vhe_migration_blocker, &errp)) {
+            error_report("Failed to add migration blocker.");
+            goto cleanup;
+        }
+
+        dlclose(hvf);
+    }
+
     ret = hv_vm_create(config);
     if (hvf_irqchip_in_kernel()) {
         if (__builtin_available(macOS 15.0, *)) {
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 150598418e..5a39a82492 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -1068,3 +1068,7 @@ void hvf_arch_remove_all_gdbstub_hw_breakpoints(void)
 void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
+
+void hvf_arch_accel_class_init(ObjectClass *oc)
+{
+}
-- 
2.54.0 (Apple Git-156)


