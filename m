Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AF8EDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWin-0000gv-2k; Tue, 03 Mar 2026 15:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWii-0000Bu-Ef
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:56 -0500
Received: from p-east2-cluster3-host3-snip4-10.eps.apple.com ([57.103.77.161]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWif-0001Xm-Tf
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:55 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 18C4318000B8; Tue,  3 Mar 2026 20:51:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571113; x=1775163113;
 bh=Y3JlG+z3H9s3sHt/x0Tuo8JzSDhUpyc6A/I7Tj0fIfs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XlnWnInLNCMQxVcZpbAZ6VU98tEuKvEWU430O9JNlxlQBLGHbEPvfqXY/FAzT1fTLIUZ2eg6LnUuaere9bIOyHc7IHq5ibIaAcHLLYzsGX6yKeR8dk5LvOOF/j+94BkQSCYF0bHyjp1d1wJzUpRNo3TpkxuDCWvFb9Eohkxp5Jh9TK1FC+sDMh0yoXXyFtv+RpY6VQMO/K6CZUmHvydJyphEBuspsT5+UgoqI9FZw2JZsted9nJWw7hm/OUkD6Kfr6qb/cB2bJz7j1nhjnxaQsf9GYbLF35XcwgxFYZ/v2kg03z3tlGG8CeMuPRBViGQLc0Z5qVb7pEwFyJWQ+WaFg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 4F6D7180017C; Tue,  3 Mar 2026 20:51:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v4 5/7] whpx: make Hyper-V enlightenments configurable
Date: Tue,  3 Mar 2026 21:51:36 +0100
Message-ID: <20260303205138.32450-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303205138.32450-1-mohamed@unpredictable.fr>
References: <20260303205138.32450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J0rW0WKa4PVhX0by892mbCOvlyuabVjV
X-Proofpoint-GUID: J0rW0WKa4PVhX0by892mbCOvlyuabVjV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX04qImjl1Wpt1
 QAnwGUQ30ISEz8FOy+1N7Q9CFB/87PXeIB7IUhmsFtoScmi/44T+qfA0oAsFGMuv7wZHMsLsBG6
 nxDlFhSrSrRKp2jm/kaQbOpsKQiofF2Mc+Sc9d6NNGPfy3P11GqO8ofHxYcToxrKmmwYJWWoBIa
 EpFwt4zIVertktN7hMHeA7NF/SDpYZVqxRiWl+kt8lol8KxUr7ixwyxDNzuiFDndsSpo4Qil4tm
 urhxUC6blHIh0wI+dN7t+cWCrwHIpUWSghjIhMAkziJCT4iZc0MHJL8jTxrNlccwDdOwN4cjTZl
 LAfrBoi1p/G2BQQ0ghe8tSUBOi52elruBHsNVRUxRrXYYZNSU404hEAEQmRlHk=
X-Authority-Info-Out: v=2.4 cv=CdIFJbrl c=1 sm=1 tr=0 ts=69a749e8
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BRqF0JgGwH6LvUrOcfoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 clxscore=1030 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABAfL/pbksfYhk2CWS4rGUEQAEpgt+zteoTBKb+b1GdqBWU0juX0OM1xWTS8nxbfUVSPWCXLr/duCm3p5/ArrM5GerpfKsWQU8T2FlzPqpQoQbujLKnL8fByCvE7QdnC3SD46mzxg0QGuiY1Pp7IdYgalwtrKEH0s0UAy3ENLn1k0j/ZqNMVLPaywxT7YTy10FKRqLtTI54v746LZCyZanFo1+gPHm465u70B+tGqrUjSm5B7x1iYw4n6+FsefLCvEfrmzXG9cmYqY4vQjEFUqjpTNeqjNErpaWsgLoqDVTmhiXzKL34p3xBpd5fql6h3B2lc2yPs0JzNntqmM5CBZPkPr6xx2KRUSyP5H0uM6qePs9pzhBWq+opQmL0jQtajfUCTIoofMJSlf+pKWpfZfR6fGcu7CHdNnW/9HrF3RYLU5RvvSey5wlcom7OvajhavQ/5kjKMeS5DpZFiXzg1uHahkpzzlDCTXy/zNjuwjeXlTJGTdCu0O40WlMYW+KlLffnDSXgdX0mhMnX35zDTJuOoq2aXwKA1c3MF2ZgBxlCgn6jCwMD8vqWzMQnj4ST7nF72lSkOs0nLHBM184ZD8mGGg8iIcvAtVzc55GBTLuFxNax2Ylzy1m1Zc3ARBpnEeA+bhY+X2V4fYAM5qSDgeLETKpnn0Ai/jXwD3h/EP2C8AmXxm5kstCIup5hjTf2Wkb6yWQfAbwK0KiGlm+Mf4bFJCQLVGjuLbQVIsNnqcxUj+2LKxGCKYwqQBuSp0hw==
Received-SPF: pass client-ip=57.103.77.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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
index e7b915ccbf..abea3ddeee 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -41,6 +41,10 @@ struct whpx_state {
 
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
+
+    bool hyperv_enlightenments_allowed;
+    bool hyperv_enlightenments_required;
+
 };
 
 extern struct whpx_state whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 915d79152e..4968a5a3e4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2219,15 +2219,17 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


