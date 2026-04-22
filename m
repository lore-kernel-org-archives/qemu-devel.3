Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D14FA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfMP-0000YX-2I; Wed, 22 Apr 2026 17:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfMK-0000ID-Qr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:48 -0400
Received: from p-east2-cluster5-host1-snip4-10.eps.apple.com ([57.103.79.13]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfMI-0007uH-7K
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:48 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 33EAC1800235; Wed, 22 Apr 2026 21:43:40 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlgFXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894225; x=1779486225;
 bh=C5WRRvURtBayyBiG835j2KXKO2FgKSgzzKn5mAraQ9M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gcjJEN+8NuwFKU7XcWiq5Nm+z5321MM2VMrr+LKzCHhTUYu6HdcWtlS0sTh0eo3Nm7E+idcNr2a2wd7RyMGTO00YDvd8gEWuV2XkPFUNN2k/emhmHdhrYDIO/kNYEAcE0hAoCAMpy4Itfi/BGq9ZAHyZLvmVe+uM1S+KfQB275iDbu7iGSeY23WSFfo3wHp2iJXdp3lm6d/q9dX6bIE0Lf3CWrQ88mpwS8C+Stf3rg22qU2aF3rqRgFWKQE/VsmlyX8tRylTDp2L0iRjCU828D0xw3Ammk8ZGeHNJcbgL6+bAYJEb6RSX3ztxZwzHJGf3d39AUFDr8g7u6GZObvy1w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 28FDF180023C; Wed, 22 Apr 2026 21:43:35 +0000 (UTC)
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
Subject: [PATCH v3 36/37] whpx: i386: add SeparateSecurityDomain flag and make
 default
Date: Wed, 22 Apr 2026 23:42:24 +0200
Message-ID: <20260422214225.2242-37-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfX9oTjBs4MnP3V
 VXfgh++ldqwJunPdVg05KdaNjofSaSc4ZGdrAbGb099el/30DS2enICL2tZQtGo5apL0v+n9weB
 oNDLZCyGOpFpONQXfpvTsw2/1zShQrXezecSw48nIQ4GfMQyxMaZProXbigU4c/qsgSRzacIOfa
 PVaZJbTpHR5HQSj9QoZY2ZmVta8Cnjh3tqSqrWcIvwlioNqXx+vxiKG/k5ytP4mL5bPDhaPNIml
 Bk+AT4ofo6XHmnhvOiu5GkH0ajnMTNW9sKYYaTv4Ths9pFHDxZuEtQpyDrB1N89fPknquufNAbg
 7h3dKiEuNVK3alo6glLyz96sh4HEdZlhKOwrCHD9OVCFBXpTzEdGfkRHA/F9Mw=
X-Proofpoint-GUID: r-kcIHqkpANMylvvMitAtNLeP4rw2eCh
X-Authority-Info-Out: v=2.4 cv=Uplu9uwB c=1 sm=1 tr=0 ts=69e9410f
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sJaswNuOvxcMbF25v3wA:9
X-Proofpoint-ORIG-GUID: r-kcIHqkpANMylvvMitAtNLeP4rw2eCh
Received-SPF: pass client-ip=57.103.79.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For workloads where isolation is less important, -accel whpx,ssd=off
will provide significantly higher MMIO performance.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       |  1 +
 include/system/whpx-internal.h |  1 +
 target/i386/whpx/whpx-all.c    | 63 ++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 305b2ae1d0..e5dabb6bdf 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -557,6 +557,7 @@ static void whpx_accel_instance_init(Object *obj)
     whpx->ignore_unknown_msr = true;
     whpx->intercept_msr_gp = false;
     whpx->nested_virt_enabled = true;
+    whpx->separate_security_domain = true;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 4436cfe6ba..08a49706ff 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -48,6 +48,7 @@ struct whpx_state {
     bool hyperv_enlightenments_enabled;
 
     bool nested_virt_enabled;
+    bool separate_security_domain;
 
     bool ignore_unknown_msr;
     bool intercept_msr_gp;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d17db73cff..035a8231b7 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3006,6 +3006,38 @@ static void whpx_set_nested_virt(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_ssd(Object *obj, Visitor *v,
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
+        whpx->separate_security_domain = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->separate_security_domain = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->separate_security_domain = true;
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
 
 void whpx_arch_accel_class_init(ObjectClass *oc)
 {
@@ -3024,6 +3056,11 @@ void whpx_arch_accel_class_init(ObjectClass *oc)
         NULL, NULL);
     object_class_property_set_description(oc, "intercept-msr-gp",
         "Toggle nested virtualization off/on.");
+    object_class_property_add(oc, "ssd", "OnOffAuto",
+        NULL, whpx_set_ssd,
+        NULL, NULL);
+    object_class_property_set_description(oc, "ssd",
+        "Separate security domain");
 }
 
 int whpx_accel_init(AccelState *as, MachineState *ms)
@@ -3223,6 +3260,32 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         info_report("WHPX: nested virtualisation not available");
     }
 
+    /*
+     * The combination of separate security domain off
+     * and disabling specifically these features results
+     * in a significant vmexit performance improvement
+     * by skipping speculative execution mitigations.
+     */
+    if (!whpx->separate_security_domain) {
+        processor_features.Bank0.IbrsSupport = 0;
+        processor_features.Bank0.StibpSupport = 0;
+        processor_features.Bank0.IbpbSupport = 0;
+        processor_features.Bank0.SsbdSupport = 0;
+        processor_features.Bank0.IbrsAllSupport = 0;
+        processor_features.Bank1.PsfdSupport = 0;
+        memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+        prop.SeparateSecurityDomain = 0;
+        hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeSeparateSecurityDomain,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+        if (FAILED(hr)) {
+            error_report("WHPX: failed to unset separate security domain, hr=%08lx", hr);
+            /* Some old Windows 10 releases didn't have this, so not fatal*/
+        }
+    }
+
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeProcessorFeaturesBanks,
-- 
2.50.1 (Apple Git-155)


