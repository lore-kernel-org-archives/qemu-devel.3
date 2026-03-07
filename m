Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448ABF55103
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywFn-0005RL-2o; Sat, 07 Mar 2026 13:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywFR-0005N5-Ik
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:34 -0500
Received: from qs-2004j-snip4-1.eps.apple.com ([57.103.84.94]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywFJ-0005QH-1y
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:27 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 75E9E1800113; Sat,  7 Mar 2026 18:19:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907556; x=1775499556;
 bh=Q+dKy95WXgP57yZMicF8WWfeQvGP7Ivmn+EsXG4loHE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Q069Ep/zk2ziLz98ZM+mJXP7JsWnW67u3ug+OQ/ctLqmDRxpqUXRpcu4r7BCJomb3FrMA7PXypZsDD73SFlat1bHZ1gQ0uZcVeW+NH3Mwx9erkq9lCNx18lYvqSXBEbETWGq2ZcePFhmo5VhBGy619+YJe+YjcSpIbLBQLio+PA/ccWw3B7Zjrj9OMhKataJHkcEOX1o4CXg9qMsSpZSXcJc0N/fa8AEWnsJ9ZTx83jMG/IcG4ftTCVvsgVl26rmO59j3fL0TH/mtR1+HZ3ePo0zzDVrlX+lmjkLttixsLh+GfdxzHEN4BV6+xSuFldl5WloJT0Lc76b625pxjlxtw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 359A11800124; Sat,  7 Mar 2026 18:19:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 7/9] whpx: make Hyper-V enlightenments configurable
Date: Sat,  7 Mar 2026 19:18:54 +0100
Message-ID: <20260307181856.2209-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AZa83nXG c=1 sm=1 tr=0 ts=69ac6c22
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BRqF0JgGwH6LvUrOcfoA:9
X-Proofpoint-ORIG-GUID: YiN2qcCy6yRBPohCqUsdKcRUU-wRJCQY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfX82f88fFaTlbI
 6wvbLR9a5s+MDoyPsA6Qc+cCyF+5+XKkHntYaGw4M+xyTmZRgCvaFieBjSzTuuBZI8UUlVx8f36
 Zcy3m/hAY3V4aSBsRAwH/gA9yjo5p5ueR5ERDZ0fWiAlQRXUaDo/VTagPkB2oUF6nCcAGdSlNpu
 buy+4mtMdXNqXASFQsuxSd7XbBaKW5wcSyS7xWgh9Av40Bm4bZG8zm+vPjLy0mAzlKUFixEsCwt
 svW/WNFtkD0Mn4Gq7cuy2ihTA3e+SV1ijOo0pw7AIRE8ESuAeoZBC1/kFxWjwDO14dC9vvzWrZi
 LtPb0ev+T8KLAG/mK8LVxB/pUyBgLIY6+gQMm1eKYH7b/tfVuWWp5/F2uQnl5U=
X-Proofpoint-GUID: YiN2qcCy6yRBPohCqUsdKcRUU-wRJCQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 mlxscore=0 clxscore=1030 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABhk8PCt8rEgjgb5+rzNe+xp5ydYtn2j/xHhJ7usJwrL+iKDPFpMZhAGC4sfwItROejJGMNd1jpKtoM5e+OWCjLtuQFuS0U6E0aqFwfMKzSCyKqcC3ZWh0trfj0BYM08MOgUhTxGxsUyyOr9r+er+0QdwcRR7WnDv3fiYS6YwJuHlLi9i7MxuavE8PuSegsWW9Tkvdy7gYB0b3/BibgNzyBVTCoKV9LcbCm+MZlE9QagHKKAtEGD9sZ/3cAY1wLfYjPOxy15Ms4mEFbwsNzP1Y1R7xT4sI00WGATHAean9SaEAoUhj4MJ9yo0BMzKU0wyiNue2xXym+iMgV5QRIgf1j79KxW5frXcWj+96V5ckQmsIGwFFPihCQfQZY1l4RNkGIG8Dcij7ixMOKACUoYfd1cj/+PDoA/cRGr0sn2jvFcIJnpbiproAYrfOxul3ZIhp+RGduWJO2tqQB14vf1O7PETzwIUBN618RJwWaQ4lcb3TAU82tgfGRF5+o34vYpo/yit4TxkqHP05EB1fKjVS5ZK59bmh+NQTHwrJj848a9OhfLpQAApjSxwI7b400pHvQSMB0D8ymIUczcnN7zceIEdEXl7mqwk+8I6vGNPvgDpOlpEfgQzQIaz/4mL/ejSLl2sbe1vC6QPy7ElnwTdGkYXNANDSp3j74b6QCSNIaBlROhVIGKl6BTBu/cfLUj/hYbgG2/EHG81SyfEp8Q/0auiR1fmxEC8qB5Zc0UXwKg5NYasBOFpYcN2KwTA9b8Upi2QAwRCiod0pJe7VmPf68YPw5wUv7TUPm9e0WCKdOw==
Received-SPF: pass client-ip=57.103.84.94;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Have them be a machine option instead of a CPU one, to have something available, even if not ideal...

The existing Hyper-V enlightenments configuration mechanism is part of per-CPU configuration, which happens too late for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       | 43 ++++++++++++++++++++++++++++++++++
 include/system/whpx-internal.h |  4 ++++
 target/i386/whpx/whpx-all.c    | 20 +++++++++-------
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 4863fc8663..b813a5d9d2 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -470,6 +470,41 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_hyperv(Object *obj, Visitor *v,
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
+        whpx->hyperv_enlightenments_allowed = true;
+        whpx->hyperv_enlightenments_required = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->hyperv_enlightenments_allowed = true;
+        whpx->hyperv_enlightenments_required = false;
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
 static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
@@ -498,6 +533,11 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure WHPX in-kernel irqchip");
+    object_class_property_add(oc, "hyperv", "OnOffAuto",
+        NULL, whpx_set_hyperv,
+        NULL, NULL);
+    object_class_property_set_description(oc, "hyperv",
+        "Configure Hyper-V enlightenments");
 }
 
 static void whpx_accel_instance_init(Object *obj)
@@ -507,6 +547,9 @@ static void whpx_accel_instance_init(Object *obj)
     memset(whpx, 0, sizeof(struct whpx_state));
     /* Turn on kernel-irqchip, by default */
     whpx->kernel_irqchip_allowed = true;
+
+    whpx->hyperv_enlightenments_allowed = true;
+    whpx->hyperv_enlightenments_required = false;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 7a1c9871f1..8482901f71 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -42,6 +42,10 @@ struct whpx_state {
 
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
+
+    bool hyperv_enlightenments_allowed;
+    bool hyperv_enlightenments_required;
+
 };
 
 extern struct whpx_state whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index bc82995b33..b095c96962 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2232,15 +2232,17 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
-            &synthetic_features,
-            sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
+    if (whpx->hyperv_enlightenments_allowed) {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
+                &synthetic_features,
+                sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
     }
 
     /* Register for MSR and CPUID exits */
-- 
2.50.1 (Apple Git-155)


