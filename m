Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E47F513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytmu-00011Y-Tr; Sat, 07 Mar 2026 10:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmS-0000mr-2a
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:34 -0500
Received: from qs-2002d-snip4-6.eps.apple.com ([57.103.87.167]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmQ-0001y9-GK
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:27 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 030A11800ABF; Sat,  7 Mar 2026 15:41:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898085; x=1775490085;
 bh=gtjDYmrW+yu+ItKM1liQrKzkTRIyOMXVqXcaV7Za9eo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DaesPJDjil4zf0I9ujj9ZK4Rcaod0iqIj5bGnxJlENRhIPXSI6UGUrjGxUs4SmbywOim0CvOJmebfulfwsI76+whfm/wy8XkBxLTxVzp/srzJ0ZuaLHU23sWf2s0PiQtJFUP3/IaSRfKsGhJvmctcdtTzLXZncLXPEbaqUthP/iwo5y6cpXRIZSdxUUPsO0Zw0y78Qg3iO6HeX3tuBiOX49WHuSMJz8I7vmZqrZ55GwYxK7tshXWJhLU0zepnopJ2G51T1h7UuLooRR08PexoaDYI0MPYjdaJmENTqRrEGMEHbC3PHWrx5p9Px7WFL2v9B+yPwD3qS47Y8SoHSiDFA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 6D37E180089E; Sat,  7 Mar 2026 15:41:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 7/9] whpx: make Hyper-V enlightenments configurable
Date: Sat,  7 Mar 2026 16:41:02 +0100
Message-ID: <20260307154104.84567-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xmm7C1jz_JH0scjJouAJw1PHhOSskoi0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfXwEVIjKlKEl+M
 7TWTR1yS4qASbAahWS/ak4A1jhOGzMgbTfWwhc09GzisM9kKiiAsdb+CWGS5KVS8D/E46PptEgh
 qPkcaJmZjEDUjLLSExpkDPXe+5rOLqqZb4SV4pXYqZnj5B7LQ0TtkKgBN/YvldsBK0craT+eiIp
 DOvadtB+8dXLbV8NPsp1zTWJaH8mIo8505Hj7t0RH97w8KIT/jJPVLsL1gm9twfCWdCZISWOWHi
 pTKyXGcr6f2qB5Q0ARW/wBy9xUsxJBtYlDXqFn8GMPdhlT9EXVSfwHO3mQ0AWkkolyfttPWuxEY
 FaDgKjqmOVXp21HiCwmSTLWNfSJ4eTtnU8EOAdB3ULR/bXBap4LHDrh4f1U8z4=
X-Authority-Info-Out: v=2.4 cv=M6VA6iws c=1 sm=1 tr=0 ts=69ac4723
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BRqF0JgGwH6LvUrOcfoA:9
X-Proofpoint-ORIG-GUID: Xmm7C1jz_JH0scjJouAJw1PHhOSskoi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1030
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAAB/KmfktzPSBd+GCeTohy/m8tRR6k+4GcHGhqj8307Arzs8Knsm+Q2UM75rqmO/eQn/Z8p4O/k8vxrlzBFzOYQROS/letsGGHbTjcR3BiGR5uEyy46VCANxlqpu8B4G9YPQ9YDMhyIvL83aYDx9Kc+eBr3g2I3FQvRLWfVeghimU1RjIjVf/7xduQDH8HHSWm4APVSXylYyVPYbVBlmGod6nNAWN+zE7Cgkn5MZJvhAqX58ywe2dy+miJrsTvP9ab9+XbHrOEMny2D6cDivnBqEVrEPt98VtWSdutaIiYfl5QwZBY5jVQFOT0wvr2fs49bmM4tDNjc7pUyT58aRFSTftvXuYUeI8mHJMF+OpJp8yMvo6kyrS428oCvGmGTxBQV5Q+9oeJBlZX4t/63DKyjGqg2yZGtz+D4bs2Te4dm9Cz6EVy5U3LYT2qpfOvLjkBc93b1SCveqqtqwFqFE0ivvxNc0n+EK+d8PC1ZqmsBMZG3kcukZbr7e41vbVbOBPYxPz39Ehc+fjSEOYJKGajfciNr2DGjbpZx+8pXduKkJ4CvrOtI91vOoB60vOal5tJc3kyDduihjqspPIOL7rNnezVwkPyIN57bJDEuI82ZzRwmqRwktJLprajtxhMwAaucPrTLWqydOly3WCuxeuZjZZX7UL+zcPia+cjmYRjcq6VpPHz7NeEhKF+P9lcyJi4gv5dwKYjWZY3LQd/MQ1E/eEtMGGYRw/KvRjVYonVfKA19nHOTQqe2S5B1EtS2/xkGqj+Yi9vw1pAGsC/WiYtetRbG
Received-SPF: pass client-ip=57.103.87.167;
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
 accel/whpx/whpx-common.c       | 44 ++++++++++++++++++++++++++++++++++
 include/system/whpx-internal.h |  4 ++++
 target/i386/whpx/whpx-all.c    | 20 +++++++++-------
 3 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 4863fc8663..dae9ff0800 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -25,6 +25,7 @@
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
 #include "accel/accel-cpu-target.h"
+#include "qemu/target-info.h"
 #include <winerror.h>
 
 #include "system/whpx-internal.h"
@@ -470,6 +471,41 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
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
@@ -498,6 +534,11 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
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
@@ -507,6 +548,9 @@ static void whpx_accel_instance_init(Object *obj)
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


