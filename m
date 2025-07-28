Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C580C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGt9-0000tg-Hi; Mon, 28 Jul 2025 01:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrU-0007G7-Fn
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:28 -0400
Received: from p-east3-cluster6-host1-snip4-7.eps.apple.com ([57.103.85.138]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrR-0007DZ-7p
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:23 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 70F2118000B0; Mon, 28 Jul 2025 05:57:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=86A60wgLWJ4xc0K/iclPiV/M1o2YUtx5PvcnU99EgeY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=YzYtqLjidbZcdaNaCOk+z83vDz84rw8mTNgthebOZiUupa1766j7dadB3llRmW+BzvNA8XGVPQuN0HZoRSWoiAJlO7ajqns72LixNnSV80ubPRtLeH5zwmrJTyaaf0tNAUL46S8QfsEswqjAanMvCiAbqmyOzPz3SksZvr/DqIRDdun2tOrZz59YA4MJ7TGoomdQICIVqL4cShyniB+oZkqjhQe3QCIoXo92RwspsO5EpJggM6+WOYkOm6txL/Omk4F9++Zt47nHLFuMWzCwenOByCL5KH9i9exzmF7tDUUVyO374Ar+Cxj1Se9coYxO6x2TNY4rL6UPaTF2PH4ysg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 BCD68180009A; Mon, 28 Jul 2025 05:57:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 05/15] hvf: save/restore Apple GIC state
Date: Mon, 28 Jul 2025 07:56:51 +0200
Message-Id: <20250728055701.38975-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728055701.38975-1-mohamed@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfX4/8orIypeOx4
 EiIR4IYF5mGWHJn6R7Dup+zo3WDLzHv+FES0kBE9ZJ7KcsLAGC8rrm0af+BMsBoZZeEWIQ0mfKP
 HkCeIWHYAyc4v/lZNzUk2XgaXpRHRdKMliEzOD7Jbd22eYYmY+iPIkCycx5HDz8ni97h3CVwQmH
 jOiCIFka4Gl1cDZJPGfJgXzmHAYTvMqZPkLYwZq7DQCGSQtzfykDohhFK4olAfRBUap3a0MGDgq
 dE5wWmIcMbup1Yv91PtM6QNOrdmYDmsn6tTOoiHpLriuPvWdkAM1UHsTtOzF99v8ciFTdVXBQ=
X-Proofpoint-GUID: CVCjsihdzAaxyLqjKEbH8s1Hc_mg_OfT
X-Proofpoint-ORIG-GUID: CVCjsihdzAaxyLqjKEbH8s1Hc_mg_OfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1030 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=820 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.85.138;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On HVF, some of the GIC state is in an opaque Apple-provided structure.

Save/restore that state to be able to save/restore VMs.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7beb47caad..766b35f937 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -22,6 +22,7 @@
 #include "cpu-sysregs.h"
 
 #include <mach/mach_time.h>
+#include <stdint.h>
 
 #include "system/address-spaces.h"
 #include "system/memory.h"
@@ -2169,15 +2170,83 @@ static const VMStateDescription vmstate_hvf_vtimer = {
     },
 };
 
+/* Apple specific opaque state for the vGIC */
+
+typedef struct HVGICState {
+    void *state;
+    uint32_t size;
+} HVGICState;
+
+static HVGICState gic;
+
+static int hvf_gic_opaque_state_get(void)
+{
+    hv_gic_state_t gic_state;
+    hv_return_t err;
+    size_t size;
+
+    gic_state = hv_gic_state_create();
+    if (gic_state == NULL) {
+        error_report("hvf: vgic: failed to create hv_gic_state_create.");
+        return 1;
+    }
+    err = hv_gic_state_get_size(gic_state, &size);
+    gic.size = size;
+    if (err != HV_SUCCESS) {
+        error_report("hvf: vgic: failed to get GIC state size.");
+        return 1;
+    }
+    gic.state = malloc(gic.size);
+    err = hv_gic_state_get_data(gic_state, gic.state);
+    if (err != HV_SUCCESS) {
+        error_report("hvf: vgic: failed to get GIC state.");
+        return 1;
+    }
+    return 0;
+}
+
+static int hvf_gic_opaque_state_set(void)
+{
+    hv_return_t err;
+    if (!gic.size) {
+        return 0;
+    }
+    err = hv_gic_set_state(gic.state, gic.size);
+    if (err != HV_SUCCESS) {
+        error_report("hvf: vgic: failed to restore GIC state.");
+        return 1;
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_hvf_gic = {
+    .name = "hvf-gic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(size, HVGICState),
+        VMSTATE_VBUFFER_UINT32(state,
+                                     HVGICState, 0, 0,
+                                     size),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static void hvf_vm_state_change(void *opaque, bool running, RunState state)
 {
     HVFVTimer *s = opaque;
 
     if (running) {
+        if (hvf_irqchip_in_kernel()) {
+            hvf_gic_opaque_state_set();
+        }
         /* Update vtimer offset on all CPUs */
         hvf_state->vtimer_offset = mach_absolute_time() - s->vtimer_val;
         cpu_synchronize_all_states();
     } else {
+        if (hvf_irqchip_in_kernel()) {
+            hvf_gic_opaque_state_get();
+        }
         /* Remember vtimer value on every pause */
         s->vtimer_val = hvf_vtimer_val_raw();
     }
@@ -2187,6 +2256,10 @@ int hvf_arch_init(void)
 {
     hvf_state->vtimer_offset = mach_absolute_time();
     vmstate_register(NULL, 0, &vmstate_hvf_vtimer, &vtimer);
+    if (hvf_irqchip_in_kernel()) {
+        gic.size = 0;
+        vmstate_register(NULL, 0, &vmstate_hvf_gic, &gic);
+    }
     qemu_add_vm_change_state_handler(hvf_vm_state_change, &vtimer);
 
     hvf_arm_init_debug();
-- 
2.39.5 (Apple Git-154)


