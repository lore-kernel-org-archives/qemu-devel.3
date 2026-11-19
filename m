Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A609606A93B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pnOwZd7G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8vv-0003OO-1T; Thu, 19 Nov 2026 15:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v6-0003Ay-NC
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007L6-9T
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:48 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUXTx3367487
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zfYts+PyqAk
 eKACTqYHsIQD4pmvNjphWhN7roV4gbIU=; b=pnOwZd7GwIaYJ0CcABTzTZcL8TB
 I59oDMuZO0h8riC8cVB7e2M7b86prtp1rqFiZ+Gc6lWgryASJ78Oa+SONzapaFie
 CYw0wdIISOJzJ6T5+5ZQHlV7Zx5ebC2L/wySWq148hMi5KJck+0BtNTvENrPm5on
 s0Fztuv7o2at71taPsRcfUFFKbjDgqeqQDWvxopm72Jj1XBhkIDwB8LY2KdFFV64
 lQPZU24RBq8eGc1bfeY7/8KOTE185VoZ2skwOqXd+gYFiMFU5Rp+RDdGAdHgfHoz
 B1eC8YA11Ztt49CTJh65+Dj38JE4H/s4lCgI1ZY7OvFA6N69IVWbFPTzb1A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5ra7n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdgev3570599; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AJKdftb3570568
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 9C1D42578F; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 11/13] target/hexagon: validate both stores before packet
 commit
Date: Thu, 19 Nov 2026 12:39:39 -0800
Message-ID: <20261119203941.899748-12-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX/8nKJy99z2yS
 ACEHNiqx8bYlhAdQbD/shi0F2yChGEBQ8q5zcD/vC0n2Sika8igTqt95hkaUesWbnxFoyOa+nJr
 IZwu6nI7CZP2O3DsVnmxu+sSzUPk1Fk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX5YOwZ/v1pn6l
 cMmxvH99x7z9S6BqmwRFkobh5jvc1JGDpVWwhJWRy3UWI+g0YC7om8OaZ+gWoVVzO+nhnuIEeyf
 SorPZlFVuQoWl0m5dg1BEeJeT7suzTxuNG9sNEFnPrai/5D8yuvOOq7e+lVJfboAnwYJKjMdmt4
 gKqCu69/fsyHHUwn3Wm0MSyvyZq1b9PoIHrUDlxml024YKHmK1HkmSzUmJh9m+mBPYLVh8VZip6
 xCm92If7/QRHtrpXblv3hJS71v23jxvVPZOQHtA0xueCuYTFkOAnnL9ECVckscs2pb+tVOsBKum
 ra6fNtttiMsULXr/6yi29MQ5aY6wiAa2Pn+0+2N3TqTuRLlsdkIP2ZwydAiaaIE/S5uf36P0J0C
 ZZ/sJCuOZGwGa617MvNI792claPo3NVu32a0zi3KaGxrDE/LkYESj78ZbKQH7ta68V7IkD7lrnn
 7pXYZJIr3L8ZKZ9UPrw==
X-Proofpoint-GUID: QukEkwWNqiGoNFUbgcnpehF0bJH-uGVx
X-Proofpoint-ORIG-GUID: QukEkwWNqiGoNFUbgcnpehF0bJH-uGVx
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff5e8f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=vAFW47GOeLQmlYVeWGsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
 target/hexagon/op_helper.c | 16 +++++++++++-----
 target/hexagon/translate.c | 15 ++++++++-------
 target/hexagon/translate.h |  5 +++--
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 292ca8eb7c..0303ea9bba 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -143,7 +143,7 @@ DEF_HELPER_2(vwhist128m, void, env, s32)
 DEF_HELPER_2(vwhist128qm, void, env, s32)
 
 DEF_HELPER_4(probe_noshuf_load, void, env, i32, int, int)
-DEF_HELPER_2(probe_pkt_scalar_store_s0, void, env, int)
+DEF_HELPER_2(probe_pkt_scalar_stores, void, env, int)
 DEF_HELPER_2(probe_hvx_stores, void, env, int)
 DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 354b9a2c91..31e1140270 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -446,6 +446,9 @@ static void probe_store(CPUHexagonState *env, int slot, int mmu_idx,
 #endif
         uint32_t width = env->mem_log_stores[slot].width;
         target_ulong va = env->mem_log_stores[slot].va;
+#ifndef CONFIG_USER_ONLY
+        hexagon_check_alignment(env, va, width, slot, MMU_DATA_STORE, retaddr);
+#endif
         probe_write(env, va, width, mmu_idx, retaddr);
     }
 }
@@ -472,13 +475,16 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
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
+    probe_store(env, 1, mmu_idx, pred[1], ra);
+    probe_store(env, 0, mmu_idx, pred[0], ra);
 }
 
 static void probe_hvx_stores(CPUHexagonState *env, int mmu_idx,
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 83b1ecd898..e10f9e21c5 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1486,19 +1486,20 @@ static void gen_commit_packet(DisasContext *ctx)
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
index 1b6c326052..34d8ff5e6a 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -442,8 +442,9 @@ void hex_gen_exception_end_tb(DisasContext *ctx, int cause);
 
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


