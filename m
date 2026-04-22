Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4835FFA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfML-0000Ik-2l; Wed, 22 Apr 2026 17:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfMG-0000BY-Ee
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:45 -0400
Received: from p-east2-cluster5-host5-snip4-1.eps.apple.com ([57.103.79.84]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfMD-0007mr-Mq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:44 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 EC9AC1800219; Wed, 22 Apr 2026 21:43:35 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlgEXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894220; x=1779486220;
 bh=fW1u47ze30rJgld8zY70vRzg5SwPNuoMbTd0WP/7YIY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YunTlq9UNMraO+3ivVWkrPMsgaQZEwdRkNREaLdyOxO4TleB45gNTxfLdgmftlzuq8Y17YZA/PWQw2OngXqFn9+A3UAVcA85hZrFoaXCSsaTfavMxIqxTWQOeK1yRWBQMBoBV2MEjQmlZmSAuxTGCJMMwBlM+Pyxkv+JhQHlmWdT1vHTSmO/W1X12N294Xnzs0Z8ADEA94GzOhr3pfYTZdt4gd98niNi84ha3iHO/OhYnGO/nwXfSqf8m/1lW2vF7ALYnOlkI2DDdOe8CTauN3Lkjj3xpJ0gdVnHLGLNeXIRKvZg3WT7ycrXvK6MBXk0PcKpJtcn7Sl1du0If+UFaA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 3EC57180020A; Wed, 22 Apr 2026 21:43:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 35/37] whpx: i386: nested virt settings
Date: Wed, 22 Apr 2026 23:42:23 +0200
Message-ID: <20260422214225.2242-36-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=a4U9NESF c=1 sm=1 tr=0 ts=69e9410a
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20kCj1oTBhCq6H0YB64A:9
X-Proofpoint-ORIG-GUID: RGN4i7LvkEGStE27k1_LBWOjRKbi_5r_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfXznMUZpcdKttZ
 vizU05v6cQ0mxtZXjSxqOTrD6xCX/gngajIsw5+a3HoFtgdUQ4SVsaT5Ft31a+DBlF6XTdQFemc
 y8NjpZ0YIQbHKZgpB+IuUU8mdprcMK9CCQ/0CxqFVc+bod0kkQlMD572MnWZ6U7pGU9KQcXl7p7
 wCowXB8nZcAxJiTnOhOpoiKx52zQSsb1wNoDk3n8C3F45/GD01howYrmpePX1W5j0HA7ovTjiFn
 R2pO66pvE0llJSahP7WbV871Qs12c3/6bymhldsDf6LL++bj3ZbeGKazfsxZ+SvuRNt1PT0kARy
 xSsDm8hWY3015WPUOzVKpzJKxC3Q/uz6cSg/QZNKpZW89SVBEXlZ2DtySBMkhg=
X-Proofpoint-GUID: RGN4i7LvkEGStE27k1_LBWOjRKbi_5r_
Received-SPF: pass client-ip=57.103.79.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       |  1 +
 include/system/whpx-internal.h |  2 +
 target/i386/whpx/whpx-all.c    | 68 +++++++++++++++++++++++++++++++---
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index d846e08714..305b2ae1d0 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -556,6 +556,7 @@ static void whpx_accel_instance_init(Object *obj)
     whpx->hyperv_enlightenments_enabled = false;
     whpx->ignore_unknown_msr = true;
     whpx->intercept_msr_gp = false;
+    whpx->nested_virt_enabled = true;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 15027a7d52..4436cfe6ba 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -47,6 +47,8 @@ struct whpx_state {
     bool hyperv_enlightenments_required;
     bool hyperv_enlightenments_enabled;
 
+    bool nested_virt_enabled;
+
     bool ignore_unknown_msr;
     bool intercept_msr_gp;
 };
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ea5d1e535c..d17db73cff 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2974,6 +2974,39 @@ static void whpx_set_intercept_msr_gp(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_nested_virt(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->nested_virt_enabled = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->nested_virt_enabled = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->nested_virt_enabled = true;
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
+
 void whpx_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
@@ -2986,6 +3019,11 @@ void whpx_arch_accel_class_init(ObjectClass *oc)
         NULL, NULL);
     object_class_property_set_description(oc, "intercept-msr-gp",
         "Intercept #GP to log erroring MSR accesses.");
+    object_class_property_add(oc, "nested", "OnOffAuto",
+        NULL, whpx_set_nested_virt,
+        NULL, NULL);
+    object_class_property_set_description(oc, "intercept-msr-gp",
+        "Toggle nested virtualization off/on.");
 }
 
 int whpx_accel_init(AccelState *as, MachineState *ms)
@@ -3166,7 +3204,8 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     whpx_rdtsc_cap = processor_features.Bank0.RdtscpSupport;
     whpx_invpcid_cap = processor_features.Bank0.InvpcidSupport;
 
-    if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
+    if (whpx_irqchip_in_kernel() && whpx->nested_virt_enabled
+        && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
         hr = whp_dispatch.WHvSetPartitionProperty(
@@ -3174,11 +3213,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             WHvPartitionPropertyCodeNestedVirtualization,
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
-            if (FAILED(hr)) {
-                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
-                ret = -EINVAL;
-                goto error;
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
         }
+    } else if (whpx->nested_virt_enabled) {
+        whpx->nested_virt_enabled = 0;
+        info_report("WHPX: nested virtualisation not available");
     }
 
     hr = whp_dispatch.WHvSetPartitionProperty(
@@ -3222,6 +3264,22 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     }
 
+    if (whpx->nested_virt_enabled) {
+        /* enlightened VMCS is an Intel-specific enlightenment. */
+        hr = whp_dispatch.WHvGetCapability(
+            WHvCapabilityCodeProcessorVendor, &whpx_cap,
+            sizeof(whpx_cap), &whpx_cap_size);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to query processor vendor, hr=%08lx", hr);
+            ret = -ENOSPC;
+            goto error;
+        }
+        if (whpx_cap.ProcessorVendor == WHvProcessorVendorIntel) {
+            synthetic_features.Bank0.EnlightenedVmcs = 1;
+            synthetic_features.Bank0.NestedDebugCtl = 1;
+        }
+    }
+
     if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
         whpx->hyperv_enlightenments_enabled = true;
         hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.50.1 (Apple Git-155)


