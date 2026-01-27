Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F6ED2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko4x-0000sZ-1s; Tue, 27 Jan 2026 13:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4W-0000OW-6H
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:54 -0500
Received: from p-east2-cluster6-host4-snip4-3.eps.apple.com ([57.103.76.144]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4G-0007c6-UU
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:40 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 EF69F180065F; Tue, 27 Jan 2026 18:45:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539534; x=1772131534;
 bh=6kh/bj0nHhgErGSCM1HUbgyZJ3F/fBPgM0DxR9gPyCU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bBj6PyVNwYQBUw5b3kLNTEuoEhcqko5ge7codE8hFpY4oDOwQN6wGlFnzeSJjoqfwG4G9Yl+RHiB+IxsamYEfkvQGv32IjjYDX2TppFrSuyB8KaoSfrB+cZxvT5Mofk2qqXfSKA7IOqAoJ84xvmpHQ7Z2BIt052Ucj85Cti1EV+hhmZjSghGQD9uXJbW7t8xo/xyiz4aa0GETJgUF9xDYDtkndQD2ATmNN9de1RTPDt2AfPrX7QliGmr9hvJKfhl+CCxnphLZsNl6q4hBNPmgdKsLzgYHXLGRQSDnOGTY1558mxjPGk3fchamU/+b2LNuLMezGwJX/B2qxa7l62fJg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 4EA9518012C1; Tue, 27 Jan 2026 18:45:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 04/12] hvf: save/restore Apple GIC state
Date: Tue, 27 Jan 2026 19:45:15 +0100
Message-ID: <20260127184523.5357-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QnztviPCG2Hvyjt8kwVfxqN_bzSHWRFl
X-Proofpoint-GUID: QnztviPCG2Hvyjt8kwVfxqN_bzSHWRFl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX75Owt6R+xChk
 pDR8Fqqeeny2BqsRrG0+33yEqXwW2bNJX4a3xcRJY4hWjxg6j0n/39sNF4ReFK2pqmo8fPixuEN
 ZIVAXnrlAIf09f+EkOum4nyY5zG9BJktoqE3sHkzs+eDYqlJrcSMcyWx1VperptsFUrI/8WlV8n
 RbrvbrAe9HYUhLrnoVwqm3x8UteqxbrQXB3zWJrGm5vVj0rVJThX2qQnlSIe5kh8Gzb3SzPrM+W
 NyW1w4t3KclYbeEdw4kAtf+SFu+LCyjjneTR44WLny5ZRY+FscZvurxJJOUNJIhvXCVDFMWWBi4
 Ur0ENg7QOLIJ2lMR9di
X-Authority-Info-Out: v=2.4 cv=Zq/g6t7G c=1 sm=1 tr=0 ts=697907ce
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=x93Mgmjee4_3HhNPHesA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=790 spamscore=0
 bulkscore=0 clxscore=1030 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601270153
X-JNJ: AAAAAAABpvTbOTKlBNeymIDVsbNfqtgkwJXltHUlRwzi9IiieK9cHw2FBHVpGVEw9FDRcQltwLZHgE/9p7Gy421XMKumdHQKzIKBPx4BK9f6ubSX0H0JTuO9IMZvnLvS2w19ACKASjDWpEwIe4UvN0Ts/cXhaWjj6UwN5mGnmDgtcTbY+506apNqkfL+TbVZ9pHOoJvNNDd12jJOgcB0ZKzYqXoxn9zoLtuZ/713/TWt1AwJK3/HpgdJmQ6SjvWJO1vXdBgnKStAFaQ9zExghyVynbMNVqJKJoJtOWU08IYpd0J0w1CKqvs24k8reWAuZjjFmgVZXkE+ibgbknXoDTPmTtX3cbDfonVL7pNwwYAhpRp5cradtVW5B3rxQBJu6oPwUGs7XAAd0SWpB2WvM9GCgV+2TIgyRpHi0QwLZgWInrXT56hWlVGeoxUWTTD1fqD2sW3TpMLWPXw6tDYulOMhV91dEZeR2BLYNojUYwG42Sc+vfmk5ZAWXezgM8Tg8x0J1qE6lBXdiB+oWVAAVeJ3Ytctx8eNaLi5QFvim5jAMCfGq3ikLpOeMq66vK/3p1odZaxCeGJb4eZdvMC8dL/9yCr/tvVIjsjDl8BWUaDBZIQtRCgNQ1BqH0wmda25wIgTwSbe6nR9J3sCNBWnPFxp8P3CfDfw0qec7tjfky1AATfJ7djCEbgIqM7mwYH9f2uhSgWlfA5v0+WeslhgVZ4YmtSs61tl3hMfcqWwjZcErkyhu/iN
Received-SPF: pass client-ip=57.103.76.144;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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
 target/arm/hvf/hvf.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 77ab56778d..55c21aa740 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2085,15 +2085,83 @@ static const VMStateDescription vmstate_hvf_vtimer = {
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
@@ -2103,6 +2171,10 @@ int hvf_arch_init(void)
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


