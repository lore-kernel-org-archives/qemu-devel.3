Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04BFD3CCAF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFK9-0004b5-7f; Wed, 14 Jan 2026 23:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFK5-0004Z8-GV
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:05 -0500
Received: from p-west3-cluster2-host12-snip4-10.eps.apple.com ([57.103.74.103]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFK3-00062e-3V
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:04 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 D538C180011F; Thu, 15 Jan 2026 04:50:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Aa0aax6vLouElVK3Aoyqarjh14m5hBAPqVICyrIsiYM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TimPMZoUzAEezH1EbAobRWN16Do/IYZoH68jqFupLr4ikdcXipxFonTy6FNg/TvkzmoQKHzq4VDT18M6ldMfmJeGD9/9ndwes9b0suO4V6E0voex0UO4n3WlZsUniy3bXEpmvNd5jZSO5SIJKQt8GIBEoCCnN8AlMUG1eGDKQnrn7KBqFZCev4J8bj5L6hi6Y12rZQSVkzc3sZxQY7jxmHEayQhN7m7GxJ8/EHWUzqcPq26LCAHZewsWLdibdgNlj485pzU28Ttc4/2lMuVZxw58DRJCp+qealcqJNNdTrzjPLmjyFu8RNbNIxJi+vLNJHGmPY09DqwYQTb4rLBhuw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 1FA871800113; Thu, 15 Jan 2026 04:50:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v7 03/10] hvf: save/restore Apple GIC state
Date: Thu, 15 Jan 2026 05:50:35 +0100
Message-ID: <20260115045042.70086-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115045042.70086-1-mohamed@unpredictable.fr>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0qtq7Vn7yL4zs1W8drOf44C6BRtlS9b7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfX+3z/oCCkIFrA
 7RRrZOb6eHZAD3/UgSR2AkeGJ3OsvxQY0UkCMBGTZXHO3YN71GVnrFbmRAB7e7pS1V4xnFtzDpA
 vgTNXNrcea1NJl1PUEncxKWaqS4zc/Vgc5TsotOmUn1QaK/3kL94XnZM7xRMyOGBoHwGr77dvM0
 vCWKYDB0GU0Fy9FyH8XauwJ7WIl0lOBezKpZMCDy85npoY5AWqH15C7p/KTk67cNHqE31/vy/BW
 9VuXgwIYLJdBHjWLBGyjnHLWU/7RsbPoD9EMBkzyAyI/A+F1G9L2iPzEFTw/ONSD43tmu4fbv2c
 levLtjjGcnH5qWenezx
X-Proofpoint-GUID: 0qtq7Vn7yL4zs1W8drOf44C6BRtlS9b7
X-Authority-Info: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69687230
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=x93Mgmjee4_3HhNPHesA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1030
 spamscore=0 phishscore=0
 mlxlogscore=766 mlxscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150029
X-JNJ: AAAAAAABnlyuSsoav3hH0hQHXeCiY51RpmQTCFIfG8x4neCP2sx0dx0CPFYaFn5FcBGBJHZdum/XJKOppN6xt1/DNXOYVs8RchVkF7In4g8wU/AFyZnKsjGxk8jnYTN7pZtO1zy/nEGedbtPW3oqXQ1v2mlC9Yje6smvXC5dMfRekfjrfDuPCZCfatLpJDbekxNZ0FAWtP+//Po32Wc1UDWS77eGHoywziBbZjU0/y4kLg8A+aBuK7yWivFnZptNreMl9A+DwpwMo4121dBkvj54zLKw0h9qGpT7q3AgaABzhMF0t9pF7YRA3wP/w/VKJwedHw6eiPTXQEmciJ084tz2QYq6yV6AHxSoOBi3ymHWkhXOSgKXL91i36FbMuPW2bTlQokJk2I4njxur/WOu9Bdk3+Zx0PfZYO33NjYdVLmOrhUFrk1pPs40nOPDWwsCCe3gbTlZGW0evQ6miQaqNH2BYX8l27nlNRMZS5BkU1VcvjNfz7G/IwLrD2nsQHzvkMtdIfQHYOYPhZXwuuA/YhP57R6rND5yg4QxEQ8kB6qR3qfaYtu9uQB2Zkd2zeFn8QLpMBibbDgoldJyKd7A9LMD6SQmYJ5JH867ljuayxpLsEzmWSjtUGhh1gdLkGl/OJAnhuZ1Y+Nv3hjOfOlWyLZynthbvGTfUz8MFH+zWG/HTO+qUTkEraFF+wt4JJ784ewi7G+wr2QEP3rJPV4kNDeUY9TmPFALzBsJIg=
Received-SPF: pass client-ip=57.103.74.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On HVF, some of the GIC state is in an opaque Apple-provided structure.

Save/restore that state to be able to save/restore VMs.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 74b6f5e7db..a220699077 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -22,6 +22,7 @@
 #include "cpu-sysregs.h"
 
 #include <mach/mach_time.h>
+#include <stdint.h>
 
 #include "system/address-spaces.h"
 #include "system/memory.h"
@@ -2069,15 +2070,83 @@ static const VMStateDescription vmstate_hvf_vtimer = {
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
@@ -2087,6 +2156,10 @@ int hvf_arch_init(void)
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
2.50.1 (Apple Git-155)


