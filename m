Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FA1C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH75-00067L-Fw; Fri, 08 Aug 2025 03:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH70-00060p-9p
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:01:58 -0400
Received: from p-east3-cluster7-host7-snip4-10.eps.apple.com ([57.103.84.201]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH6w-0005Dt-Eg
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:01:57 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 8AEEF1800189; Fri,  8 Aug 2025 07:01:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zih/n5hIPFTTgEzsC9u+ZYJWPt6xf+DefflDe396ZjY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=SXZWY1mstlAm5bbQ7avADUsn3iWI4gEq9u3QP02EbJcrnNArujpvN3cLqFKPkoSHamINQIZB3M/Lr7zCDxro8m07IYNoZHyh3ei6xLfpWTrOK+HXzT4v4QoipfXurycq2B/MIJ8X6DEBulImIcyztAUMD+5UBuOeJDGDKTTah1ZrU3kOM0v8v/R4eiKU5O/Nb7HhxOudYMHEumxbuUwj8HG9CFvSqqGGbl5A0RDpU28/m1HVruTnCEI6In2vWBsbeKbPWCkP5Ot1OHUuGneli6dvhDi2uIGKBRET0S61GvP43USGeA/IlParyM01DyFvC6j2UZcXabUy64TBCBw5Qg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 A65AC180013F; Fri,  8 Aug 2025 07:01:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 06/13] hvf: save/restore Apple GIC state
Date: Fri,  8 Aug 2025 09:01:30 +0200
Message-Id: <20250808070137.48716-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808070137.48716-1-mohamed@unpredictable.fr>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NyBTYWx0ZWRfXw2yp7kg/Dnhf
 zyT2apbf5KTAhxEbdlQsFBLiK3/E7AYT4lurLk7ilqTPYpg6iGLeI7HZx/uiGInfQKc5psD1F8S
 fCmsMq9qTELE75o4k7M+2maJIVy7qaSCMI7aWW7VP4tdWWwbBLVv65ecxQ8DLuLtq+fFFYjDMYr
 N5I/Q+feVB32J5QMihmt/qXaxuSi+uZyFiurNvivoySsK198LI7ImXEX1kMayxQeNpiN7XMvJjI
 zkE47kN6qtFBYoo3CeDEJfcWxabxTMBYoY5MDhXSOoCQmax3Pi9rAsvc88Pg+PFO0pp2ChPDE=
X-Proofpoint-ORIG-GUID: urUpP95XdlEpapxn4iqiV-GUHqqwTxWo
X-Proofpoint-GUID: urUpP95XdlEpapxn4iqiV-GUHqqwTxWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=823 adultscore=0 malwarescore=0 clxscore=1030 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080057
Received-SPF: pass client-ip=57.103.84.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
index 483a50329b..3cc6f1e159 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -22,6 +22,7 @@
 #include "cpu-sysregs.h"
 
 #include <mach/mach_time.h>
+#include <stdint.h>
 
 #include "system/address-spaces.h"
 #include "system/memory.h"
@@ -2175,15 +2176,83 @@ static const VMStateDescription vmstate_hvf_vtimer = {
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
@@ -2193,6 +2262,10 @@ int hvf_arch_init(void)
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


