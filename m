Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8BAF94CBE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLS-000808-7W; Wed, 22 Apr 2026 17:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLP-0007xX-Dz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:51 -0400
Received: from p-east2-cluster1-host5-snip4-10.eps.apple.com ([57.103.76.93]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLN-00073l-H9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:51 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 8467F180021C; Wed, 22 Apr 2026 21:42:48 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGloDXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894168; x=1779486168;
 bh=9mILSLYmqc5xAiH5ZnQxEwcrk4EQka2pJwYrbsNFZ5I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Uo7oqjr0aQv697V23aBykjkY5/gNxakz1AhQIFFZu1svI3age8jxuYNVu+S3xOpCdb3CT45LwraPYQkLaZxN9ftCYxayFQNNh9+gdnAMkNYs6s/5k5fcX4Jj1C3Nng0Nwu/bxM2NwjtghsVL30dYIxWoCraQUtCsJhEIgdOulaaTzDdDedYGEYsO43O3hcxrw+DwVgNsaVlrN7CzSgQem49NLfPxAtyzz3IiB8PJew/p2hir19SRO7UlUNSSRDHyJ57wpIywS9DV7X4aVbGs+k/XFHNE9KRzvxHA1z/xpM+y3O86THBjInLMNgDieiZo8Ub32mR7CGed2XFo2zV5Yg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 D2CA91800227; Wed, 22 Apr 2026 21:42:46 +0000 (UTC)
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
Subject: [PATCH v3 10/37] whpx: i386: disable kernel-irqchip on Windows 10
 when PIC enabled
Date: Wed, 22 Apr 2026 23:41:58 +0200
Message-ID: <20260422214225.2242-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfXxx17pSEF/3/3
 GNw0NNrEqWUNGkT/TX5lB1yIDmet4YGeVRBCa9w58cwH22pj8jPOMZYmnDvrkNx3sVX6/v8vMFa
 I51sz4nZJIy9cWFgvXEqbpKk4kEa6+ehKv1c2RUl5EWW4wFkwLeMhOTRzCi6Aq0Pomw51asGF8h
 lCVAkFGgx1y6HxGeAo4yxMuu6I6+R7wVIs+i0dcp0xuNgCJSyK1hqVsOrj9Nrs5wSyajmINK1fR
 +SodBfOT0Qj068NhD+Wt2NCk6BZkz8XfkUUw8qUbGugq0sFMUQ0S7HK1LwOVQOisWFIOdalbVmA
 o/mxu3zZwy8JXbQprITwwtMba0KEWvGdgdAWHes/75uETNQzuL1Rj4DaJzQuHE=
X-Authority-Info-Out: v=2.4 cv=f6tFxeyM c=1 sm=1 tr=0 ts=69e940d8
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nUl_a9z44qMLw6SsMv4A:9
X-Proofpoint-ORIG-GUID: dEDTRDJ00G0ti5xVmv08yGFfIq_aEtIG
X-Proofpoint-GUID: dEDTRDJ00G0ti5xVmv08yGFfIq_aEtIG
Received-SPF: pass client-ip=57.103.76.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Move WHvCapabilityCodeProcessorPerfmonFeatures queries
as that's how we distinguish if on a legacy OS.

Now that Windows guests are booting, disable kernel-irqchip=on
by default for Windows 10 when the PIC is enabled.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 69 +++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 03c146dfb8..ab8e97787f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2523,6 +2523,13 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
 
+    X86MachineState *x86ms = X86_MACHINE(ms);
+    bool pic_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pic_enabled = true;
+    }
+
     whpx = &whpx_global;
 
     if (!init_whp_dispatch()) {
@@ -2594,6 +2601,35 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable supported performance monitoring capabilities */
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
+        sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
+    /*
+     * Relying on this is a crutch to maintain Windows 10 support.
+     *
+     * WHvCapabilityCodeProcessorPerfmonFeatures and
+     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
+     * are implemented starting from Windows Server 2022 (build 20348).
+     */
+    if (FAILED(hr)) {
+        warn_report("WHPX: Failed to get performance "
+                    "monitoring features, hr=%08lx", hr);
+        is_modern_os = false;
+    } else {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeProcessorPerfmonFeatures,
+                &perfmon_features,
+                sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set performance "
+                         "monitoring features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     /*
      * Error out if WHP doesn't support apic emulation and user is requiring
      * it.
@@ -2606,8 +2642,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (whpx->kernel_irqchip_allowed && features.LocalApicEmulation &&
-        whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
+    if (whpx->kernel_irqchip_allowed && !(whpx_is_legacy_os() && pic_enabled
+        && !whpx->kernel_irqchip_required) && features.LocalApicEmulation
+        && whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeX2Apic;
         hr = whp_dispatch.WHvSetPartitionProperty(
@@ -2669,34 +2706,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    /* Enable supported performance monitoring capabilities */
-    hr = whp_dispatch.WHvGetCapability(
-        WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
-        sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
-    /*
-     * Relying on this is a crutch to maintain Windows 10 support.
-     *
-     * WHvCapabilityCodeProcessorPerfmonFeatures and
-     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
-     * are implemented starting from Windows Server 2022 (build 20348).
-     */
-    if (FAILED(hr)) {
-        warn_report("WHPX: Failed to get performance "
-                    "monitoring features, hr=%08lx", hr);
-        is_modern_os = false;
-    } else {
-        hr = whp_dispatch.WHvSetPartitionProperty(
-                whpx->partition,
-                WHvPartitionPropertyCodeProcessorPerfmonFeatures,
-                &perfmon_features,
-                sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
-        if (FAILED(hr)) {
-            error_report("WHPX: Failed to set performance "
-                         "monitoring features, hr=%08lx", hr);
-            ret = -EINVAL;
-            goto error;
-        }
-    }
 
     /* Enable synthetic processor features */
     WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
-- 
2.50.1 (Apple Git-155)


