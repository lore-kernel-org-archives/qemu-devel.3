Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CA0C4452E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjn-0000GI-0X; Wed, 21 Jan 2026 08:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjA-0008QE-QI
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:34 -0500
Received: from p-west3-cluster6-host6-snip4-5.eps.apple.com ([57.103.75.118]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYj8-0007FL-0v
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:31 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 DA7FD18000DA; Wed, 21 Jan 2026 13:58:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003908; x=1771595908;
 bh=Aa0aax6vLouElVK3Aoyqarjh14m5hBAPqVICyrIsiYM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CQ1u5J+cwaLT3gazv1I01qXog5KaBm1cnnjJXGLbNUM35Sj+TKIgP+/Mp/l3E9QwPu/2y4IFbSh4PkhYuc6Wbfm60CpjTIZIpAJZLlVc+IY4DVeTyvjEnyMLFtfKEGHoCiAT+OPSg3d+Cg4fKvKmIb4YckBIT4Bl6k1bcjzaBxMoHSChR9P4lmSPD7J5PwZS8TvCV/niceyLMPG44iAXSShD22nmFYJRLfT6++83YrY/O2YxCuPzWUteau2VlXqFKF+GTJ7iwwpPUyIQt7kn/XlJvsAja/iuU7AD9KVkePJv+m6/xXGoxj8rc7wcWPR63BFV5Aw6DTZu4FC10sDIKw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 CDBC2180107B; Wed, 21 Jan 2026 13:58:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v8 03/11] hvf: save/restore Apple GIC state
Date: Wed, 21 Jan 2026 14:58:08 +0100
Message-ID: <20260121135816.21258-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gBSfEZEhHf66P8JeAhEvz6euUBXpELvu
X-Authority-Info-Out: v=2.4 cv=AYy83nXG c=1 sm=1 tr=0 ts=6970db83
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=x93Mgmjee4_3HhNPHesA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfX8P55KgiyuMuJ
 Ftnueob5x/VaAntIKLKGUKBeg2kusfCQkMulnV3XPFdjKnO8HatGaG1cm4w32q9+FLRxu0ntIef
 ARjoUotdh3MTPM4iW7b7yn3CLe7Iw75p2wEk43lw/vZYpwWDs2nR477yQT6w81ZIiAoXLQeaiRc
 C7t0nmul7OcNrBDnyKAGyrL56VeVMQqPBU4M1C+22t1v2sAznti71SEVkgJlzXsGZI3leDlXjNt
 yfcrUIf1WziDuPNOfNmcIT2kk7HCK3RJGdyUrkuEFzVUn52KfCrb7KeJvoWDWwrUEBvfVDKNNpB
 Mrp9r+y5bgwj3qj5WU6
X-Proofpoint-ORIG-GUID: gBSfEZEhHf66P8JeAhEvz6euUBXpELvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1030 mlxlogscore=770 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601210118
X-JNJ: AAAAAAAB3E5isqdF7rPtIoJM02N0xX9ilsRV8SHIZAfB0XBcDTkpEWoK2dPRdPKojv5E63QoHt9wahbWkdr6HFC0F/QesXNZMhg9TfChJv2idO2VUw6hQdKefqReQKCP+CyqUmf7UATjrFOOikS8bIw2mWympEH71KQqQp2t+yHri6z9+zMPtmc+MEdCRhGVg2us6SdPCGPsEPlLFfejSueNK+4g0xR7et3dp/I1yNhXPKkZ4x+QbjtSV97VZ0Aosi9ZOy5DcvRtQIDSjLOlSFgpmc6cYPNGfYIzDCippupEFBSUu8X2nOk/8vxzsGbMZ837Tg5jQI4j7AOBSDc5K7g87aXsO3Hse7lFeS1vjnSWE3hPlipl0AJsqz9rUrD1Up96rGoTVRX5aEHVOQWI5I9+0VFf4sp8S1rUFc/fAhFx2dXKID10B7ZO9VFOsS1BvSUZ7IyiPMFwbU58OF9P4McX6EWL1kc6bk1wSgXJq45SZykQH4b5j6AFCyH5ixvs5vq5cxjx+YnP1jM04Oq0Ktk5RHWMAPJDuWDXXUsQNy33+wL7vw33uoOuiQU8Lp3/CyK6IIQkkzbD8PPIfesDWFb3xzEtPecf1P3f1ChTDZ27SZ2ZK9lnxo72yXf4smyz3+E1GLC7up/hin1euh0i94K9axEuF6BhupoiDAEP0eN3ogfQxWhO4M8jQNOhtlCCbvUoqd5+8bYyCfomrE5447T8CH5ykrS2xxiZZqtxw/+TRQ==
Received-SPF: pass client-ip=57.103.75.118;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


