Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A411C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Lgd-0003mS-6Y; Fri, 04 Sep 2026 00:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2Lgb-0003ku-FM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:57 -0400
Received: from pv-2001b-snip6-11.eps.apple.com ([2a01:b747:3003:200::15]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2LgZ-0003j1-7n
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:57 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 6E48A1800116; Fri, 04 Sep 2026 04:37:50 +0000 (UTC)
X-ICL-RepId: 01a06ab5-6ea7-7931-8efe-7aa0aad4db0c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsGQA1LBFkFRQtGD0kAQARGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788496672; x=1791088672;
 bh=G0sCQVy5ZVMJ7d5IcnGa5M5Elqj0GnZy6UVJUHpnpX8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=hfQVFS4puqranQ9AzduzN4WiOWE8iGsBADZyJNSyHVey4lEIvYuFCQkbN15+kEmaMOMh0VvcP3d8iCl1gHiKAcVfTmR6m8no0eUweJp9HCEKcJaxaB32j5ff37q/U7UKSqOdSfOZIBO0L80F5Gok+26pEq7lqUIYAyUEkGpl+SIZ6+RSLqUjtoqOT2O/GWrtBTbx/QPM2VB7PkyMbB+uTBafWVXQURWrg7EQwemU4T72DoVx3QsOVw+gnKOpffay3qTmwUzez8Tt2dvzN/4ubqQwCvAx3LR90XXfkenZaM9U39pERRMJ6ztzvc4Eqz9Jwx7fXO64pAmRE+z9HfPjDA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 7E11118000A0; Fri, 04 Sep 2026 04:37:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 2/5] hvf: arm: add experimental VHE toggle
Date: Fri,  4 Sep 2026 06:37:39 +0200
Message-ID: <20260904043742.96613-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904043742.96613-1-mohamed@unpredictable.fr>
References: <20260904043742.96613-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfXwOfI+WX6eDfy
 yMzQQCVTIqLchW6Ds/waB/EyHustEfwQg2cqgu/z9vDM5tIT2zF7HYbIUDsT3TKRPESxIuPx/P9
 ZptDOwaZCZsfyJ0vhxCd2XQiB+w/1XmD2d0QHgvl56aSy3GDOFx3sWW6NNwNPMAt+h9UTuzZjfK
 UCztBDXX8HTum39TJTucLQ56NEh2w09S7v5zFl9WbxKCvjcpAfX2aqyqWRQ9j3/UMh/mw277d0v
 tC/CGYvauKPEhN4GNk4/bX7+9P7Fupzx+/tBNPMQaGsJ/pgwDIMrZeJDH4l7thCitIR3ugKwlji
 dOQNd36M+7eobSSI3PJM6z0oBIYSKCLY4S/JD5HqKpyEpxx0dS2S87rPrWm+LM=
X-Proofpoint-GUID: IaFef-evPMSch0NrjIm1t0n7ob0kczLF
X-Proofpoint-ORIG-GUID: IaFef-evPMSch0NrjIm1t0n7ob0kczLF
X-Authority-Info-Out: v=2.4 cv=EpHfbCcA c=1 sm=1 tr=0 ts=6a9a4b1e
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Uy8BaTlr5CIEmbXmnWEA:9
X-JNJ: AAAAAAABQQgngGqO7X78r1rbDi5jg/WjTgiQVtFc3DOYiY8pmjRcYyJdfH1KQTa7bB/r1CLaP08sBDXg3j2Kko7iIBmz8bSE+BdIPwTEJQ/rejocbiifLJeEbeuURQDp1dKOtAtLPrd8Ernq5xWndgk9YNMu5jgJ4jj/u1ye3JbtfLGghKBcYl2bDPKD6GsT9N0MIKg1BcwCkl06+oDPWI9J9kMV04hbeth0Ais/5OT7MrBw2Qf5H8yAJCZkJgn77S8qv6Titj1suY4ZLTt4TG3wutLFEAybpOEfRTzHZZXUn07R1a443tqoBglHMra8tph8tXdDEY/rT0HQyzT4Sk8NcnltncxcJfq/tofhfvfQQMyFvcyitr/wX2aKo5pKblLUBCl8TSWduxhxumYsk25LIWHfV3VHKud/hd+28f0X/bhy+qhBN01LXWs1KkO6d5FgVoeBN5qrRZ5lK2NvuEvm5W+T3gAcrfujipVj3eNMbUFMY+SzvYq26tfRWG6eZ2YzTdT2U9RZdl+In0NqY7buLoYKwjRJ3E+9hyIVwTwlfc2fDcp5BwMHk6fYi4LYaiMDdGQrCGD4ZtFNaQdyNn4g0K+Ok0L1yQoXFne7R1I1Gf4VW5jxhV8fGHSyXHRPFw6TqEl+6rz2+CixnjaHrvIdHpxo1m/DDcrz03GqlFUlb36hXj5icLrxp2z/NyBmZy7vmuEGgST3TDHfaSURcBG96RQEARdeJzyaUn7IOfc8tfc0aIsv6tJf+b7GcEnqo2eoydhF
Received-SPF: pass client-ip=2a01:b747:3003:200::15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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


