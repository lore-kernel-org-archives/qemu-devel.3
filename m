Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02808606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ExaayGKc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO3F-0001Jj-4M; Tue, 17 Nov 2026 13:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2o-0001Fi-KR
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2j-0000oj-85
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:38 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQYeM1141785
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IKwyn1IrCO1
 UiJY8MPxrs7q38TwkBZPe2ziCL6RAptw=; b=ExaayGKcdfjHVsY+bFA160DvE2Y
 V8wDmQivNN/gBkFU5a8AdfDzCLQkk7ZNSmHchVTR1IE6P+ro6P2AqpKk2UmQl54o
 1Q4zq8lJ+XijEMcHMdTodBYvW01a2/ahrvcsH3o5+ltgboxI5y6kdVDj0vejzJQp
 +eboJsT0Fk+xxyCkZxm+x3U1YWRU7yH+x4T122Yvg2xMDO4wOReZWWaVKlLavUFO
 CjD8iyrLqp5t3qhVNM1Btiyh9h5VGMpl/7f0AouD/KBt09QuNSidGW7AIulY7v01
 alHRo1tYTt5qYVhaMcXJozLXyCKm7QH4Asm4zMyIdHjUgIqpu+gqro4pz0A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0s9t0y3f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUgs3167723
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AHIaUcg3167761
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id C256B2563E; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 13/14] target/hexagon: validate both stores before packet
 commit
Date: Tue, 17 Nov 2026 10:36:28 -0800
Message-ID: <20261117183629.2002840-14-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: iFKlpFrqRxCuY-FQTba6uKbl5UhSWoO3
X-Proofpoint-GUID: iFKlpFrqRxCuY-FQTba6uKbl5UhSWoO3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX+HsHTR71vAwi
 nybTICB0tlKIhSmQ0T1kapm+2esVO3faM+un+xBjwY7WFeXJtYLI2UB/TeZzbtsseOO1Jm+oNl3
 2Ok4JgZJoeuCurW8rXzQIXGwMoXTdmnBJHyTqxFf50m3Z2Snf06zZu8vSrgF5sw8CNazGYCz8Ie
 4VL9zdc1I4z3ND6Fn+N9M5ZUdxELdRNZQYxgfXCVXTNTOy3y6oDfDlXSlViJEvLI4zLRxfy1yMv
 KkvthyYDdV3nUCN5zkZvmMelzyIoumglr8czibORu9nx1tVI+nZoQhUnm/enXWPvkm3U/YVppc8
 kdwApuz48q00gjE28xEOxes+Vi9MG3ipfiZqv4Rhy6iwvLGY9/zByjdh9XkpoYEGQr5HFqM38KF
 7sl6dgxTbhiY2yUfPa24D5KIITJeihZ6iUoOss4+acW9WXR8paWJ3wxWfFNnRqJUckpdwg4tnOb
 y3m1AZWLD49A2bshKWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfXzuR5ofndU0fb
 Lu5aoiK5G6jFCFEj42fuxXL1Wplo7w1pDsNF45XZGjb6vG9IdWoLPeK3c5FjkdXx4v+J/cHKqCD
 SlaqtMi1WsaCqvBp8E0jvSalYeOBYgo=
X-Authority-Analysis: v=2.4 cv=d5xgWhjE c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=7mGCjcqtN82T8rJ3q0sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check alignment in store probes and validate both logged stores before
committing either one. This also covers stores without generated
address preflight code.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/helper.h    |  2 +-
 target/hexagon/op_helper.c | 26 +++++++++++++++++++++-----
 target/hexagon/translate.c | 15 ++++++++-------
 target/hexagon/translate.h |  5 +++--
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 32d71d84b5..754f341faf 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -148,7 +148,7 @@ DEF_HELPER_2(vwhist128m, void, env, s32)
 DEF_HELPER_2(vwhist128qm, void, env, s32)
 
 DEF_HELPER_4(probe_noshuf_load, void, env, i32, int, int)
-DEF_HELPER_2(probe_pkt_scalar_store_s0, void, env, int)
+DEF_HELPER_2(probe_pkt_scalar_stores, void, env, int)
 DEF_HELPER_2(probe_hvx_stores, void, env, int)
 DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 7afd13c996..95e9f8b912 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -502,6 +502,9 @@ static void probe_store(CPUHexagonState *env, int slot, int mmu_idx,
 #endif
         uint32_t width = env->mem_log_stores[slot].width;
         target_ulong va = env->mem_log_stores[slot].va;
+#ifndef CONFIG_USER_ONLY
+        hexagon_check_alignment(env, va, width, slot, MMU_DATA_STORE, retaddr);
+#endif
         probe_write(env, va, width, mmu_idx, retaddr);
     }
 }
@@ -522,13 +525,26 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
 }
 
 /* Called during packet commit when there are two scalar stores */
-void HELPER(probe_pkt_scalar_store_s0)(CPUHexagonState *env, int args)
+void HELPER(probe_pkt_scalar_stores)(CPUHexagonState *env, int args)
 {
-    int mmu_idx = FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX);
-    bool is_predicated =
-        FIELD_EX32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED);
+    int mmu_idx = FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, MMU_IDX);
+    bool pred[2] = {
+        FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, S0_IS_PREDICATED),
+        FIELD_EX32(args, PROBE_PKT_SCALAR_STORES, S1_IS_PREDICATED),
+    };
     uintptr_t ra = GETPC();
-    probe_store(env, 0, mmu_idx, is_predicated, ra);
+#ifndef CONFIG_USER_ONLY
+    /* Do not let an alignment fault occur after either store commits. */
+    for (int slot = 1; slot >= 0; slot--) {
+        if (!pred[slot] || !(env->slot_cancelled & (1U << slot))) {
+            hexagon_check_alignment(env, env->mem_log_stores[slot].va,
+                                    env->mem_log_stores[slot].width, slot,
+                                    MMU_DATA_STORE, ra);
+        }
+    }
+#endif
+    probe_store(env, 1, mmu_idx, pred[1], ra);
+    probe_store(env, 0, mmu_idx, pred[0], ra);
 }
 
 static void probe_hvx_stores(CPUHexagonState *env, int mmu_idx,
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 130e1be8ed..15c4be401d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1473,19 +1473,20 @@ static void gen_commit_packet(DisasContext *ctx)
                                                    tcg_constant_tl(mask));
         }
     } else if (has_store_s0 && has_store_s1) {
-        /*
-         * process_store_log will execute the slot 1 store first,
-         * so we only have to probe the store in slot 0
-         */
+        /* Validate both stores, including alignment, before commit. */
         int args = 0;
         args =
-            FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, MMU_IDX, ctx->mem_idx);
+            FIELD_DP32(args, PROBE_PKT_SCALAR_STORES, MMU_IDX, ctx->mem_idx);
         if (slot_is_predicated(&ctx->pkt, 0)) {
             args =
-                FIELD_DP32(args, PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED, 1);
+                FIELD_DP32(args, PROBE_PKT_SCALAR_STORES, S0_IS_PREDICATED, 1);
+        }
+        if (slot_is_predicated(&ctx->pkt, 1)) {
+            args = FIELD_DP32(args, PROBE_PKT_SCALAR_STORES,
+                              S1_IS_PREDICATED, 1);
         }
         TCGv args_tcgv = tcg_constant_tl(args);
-        gen_helper_probe_pkt_scalar_store_s0(tcg_env, args_tcgv);
+        gen_helper_probe_pkt_scalar_stores(tcg_env, args_tcgv);
     }
 
     if (ctx->hex_def->hex_version >= HEX_VER_V83) {
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index b4df21b70a..849264e83b 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -441,8 +441,9 @@ void hex_gen_exception_end_tb(DisasContext *ctx, int cause);
 
 void process_store(DisasContext *ctx, int slot_num);
 
-FIELD(PROBE_PKT_SCALAR_STORE_S0, MMU_IDX,       0, 2)
-FIELD(PROBE_PKT_SCALAR_STORE_S0, IS_PREDICATED, 2, 1)
+FIELD(PROBE_PKT_SCALAR_STORES, MMU_IDX,           0, 2)
+FIELD(PROBE_PKT_SCALAR_STORES, S0_IS_PREDICATED,  2, 1)
+FIELD(PROBE_PKT_SCALAR_STORES, S1_IS_PREDICATED,  3, 1)
 
 FIELD(PROBE_PKT_SCALAR_HVX_STORES, HAS_ST0,        0, 1)
 FIELD(PROBE_PKT_SCALAR_HVX_STORES, HAS_ST1,        1, 1)
-- 
2.43.0


