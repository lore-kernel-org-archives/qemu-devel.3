Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94549606B74C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ac8j1abn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8vX-0003MF-3c; Thu, 19 Nov 2026 15:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8vA-0003B6-0h
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007K0-SS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:50 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Wpb1671647
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6xMOreOGbXv
 JQEbGksluhUCb/roNQ3o09XBrj1PWOhc=; b=ac8j1abnqe4QD3hHbuNhT6Rmve0
 IKjo0+uP62ijxS8bjKII4P4YLIOorsof6yw2d6IdrX2MkNmRMh9+I60L/0C2YGI0
 uQAcUlWFTJ2Kldygi/WMZatio94ffV10TSCR9gtybrgprRD8G3iT2wbQBvDuSWAo
 zO1G15cDLc9EuJ2GO8fNAj7gRa3T5UsMZ+s7LH67yVXXkLv2DmQum+SGIKgVZCfi
 T0eFJv0qsfjGroqFexQa1gS4ppTJOLiCscIqhYPHkuPUsbjR25Y8/siFClHFRT3A
 KK218PlUuewejOfIEE8l+gwHdhl2J0hXfXWegw3S9to/59Xz7UU6fsVb4pg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1x70bc21-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdfAE1670338
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AJKdf9A1670309
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id A097A25790; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 12/13] target/hexagon: probe VMEMU upper transactions
 before lower ones
Date: Thu, 19 Nov 2026 12:39:40 -0800
Message-ID: <20261119203941.899748-13-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: 6csKvny-yqLE75qPtB_qgG_igh9uisAC
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=SFsQfBXkJAIU8DLS2pcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX0hnWRUURUHf3
 eoVGF3tu7eQURfPvyNOt0KGauzmVerTn5vNIbJG9+WnapbMVkKJng+xVksTmd1YWDrFKVHoPOtC
 Y70rtCj4vktfuQGLd5fsB6g46Y8587o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfXzDr681WjnmOs
 HfEHBW6JNrr57V+sQCWN7lseoTLJU+9FC0ABlB3wkPoVlWLhWGqP5LXo1EzRJHKKV5RzC0oJAe/
 l3OiCASfERO4LIpckoFQvP7y+ORDkiOL1DNdC1pugLq9/yvkHuxUdO+nBztCNk9xyqx/T6xJ1Sn
 EEH2bQ+Cms6TDhJ5lGwyAIdsIIdcJ65QFAWFqsbK6qwBZquxX3ux1OKdAta35yFY6hXRfzaUPNG
 nKCBmkQNap9YAXbD4D2FQueIsZhqle0ouWkqMN4/Uq3IC6eK6V0FbZIxhGGwEiU+9M6adB8W5wS
 tWv2B1K41cyRBg1bmlX///NtRaqb+5z1oJ+2AJ0ioanZqx9AJdO/aQuyJJSm62bCdBQbUtenwgf
 E2BHnJNv4C3TD1O2KqVDBcWGIEZyKS2WbPV/02/U7gkQF6fxTVW0eVHS4Im5hTFqlpCvAM1k12K
 C/3CAFiaDJCu8jgH2qQ==
X-Proofpoint-GUID: 6csKvny-yqLE75qPtB_qgG_igh9uisAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190082
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

Record both unaligned VMEMU addresses and probe the upper transaction
first. Report the architectural address, not the page boundary found
by a split TLB access. Preserve both validity bits on load and store
faults.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c       |  4 +++-
 target/hexagon/genptr.c    | 10 ++++++++++
 target/hexagon/helper.h    |  3 +++
 target/hexagon/op_helper.c | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1eb0fc588c..9146b27708 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -763,9 +763,11 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
         for (int i = 0; i < 2; i++) {
             if (valid & (1U << i)) {
                 env->t_sreg[HEX_SREG_BADVA0 + i] =
-                    i == slot ? VA : env->mem_access_va[i];
+                    (env->mem_access_valid & (1U << i)) ?
+                    env->mem_access_va[i] : VA;
             }
         }
+        env->t_sreg[HEX_SREG_BADVA] = env->t_sreg[HEX_SREG_BADVA0 + slot];
         SET_SSR_FIELD(env, SSR_V0, valid & 1);
         SET_SSR_FIELD(env, SSR_V1, (valid >> 1) & 1);
         SET_SSR_FIELD(env, SSR_BVS, slot);
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 339f43b7ae..077319a7b6 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -1635,6 +1635,11 @@ static void gen_vreg_load(DisasContext *ctx, TCGv_ptr dstbase,
                           intptr_t dstoff, TCGv src, bool aligned)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
+#ifndef CONFIG_USER_ONLY
+    gen_helper_probe_hvx_mem(tcg_env, src, tcg_constant_i32(ctx->insn->slot),
+                             tcg_constant_i32(aligned), tcg_constant_i32(0),
+                             tcg_constant_i32(ctx->mem_idx));
+#endif
     if (aligned) {
         tcg_gen_andi_tl(src, src, ~((int32_t)VECTOR_SIZE_BYTE - 1));
     }
@@ -1657,6 +1662,11 @@ static void gen_vreg_store(DisasContext *ctx, TCGv EA, TCGv_ptr srcbase,
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
+    gen_helper_probe_hvx_mem(tcg_env, EA, tcg_constant_i32(slot),
+                             tcg_constant_i32(aligned), tcg_constant_i32(1),
+                             tcg_constant_i32(ctx->mem_idx));
+#endif
     tcg_gen_movi_tl(hex_vstore_pending[slot], 1);
     if (aligned) {
         tcg_gen_andi_tl(hex_vstore_addr[slot], EA,
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 0303ea9bba..1c4de477fe 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -22,6 +22,9 @@ DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_6(probe_hvx_mem, void, env, i32, i32, i32, i32, i32)
+#endif
 DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32)
 DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_4(sfrecipa, i64, env, f32, f32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 31e1140270..3492c99c08 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -54,6 +54,41 @@
 #include "hexswi.h"
 #endif
 
+#ifndef CONFIG_USER_ONLY
+static void log_mem_address(CPUHexagonState *env, uint32_t va, uint32_t slot)
+{
+    assert(slot < 2);
+    env->mem_access_valid |= 1U << slot;
+    env->mem_access_va[slot] = va;
+}
+
+void HELPER(probe_hvx_mem)(CPUHexagonState *env, uint32_t va, uint32_t slot,
+                           uint32_t aligned, uint32_t store, uint32_t mmu_idx)
+{
+    uintptr_t ra = GETPC();
+    uint32_t base = va & ~(VECTOR_SIZE_BYTE - 1);
+
+    if (aligned) {
+        log_mem_address(env, base, slot);
+    } else {
+        /* VMEMU uses both slots; BADVA records the unaligned addresses. */
+        log_mem_address(env, va, 0);
+        log_mem_address(env, va + VECTOR_SIZE_BYTE, 1);
+    }
+    int first = aligned ? slot : 1;
+    int last = aligned ? slot : 0;
+    for (int s = first; s >= last; s--) {
+        uint32_t address = base + (aligned ? 0 : s * VECTOR_SIZE_BYTE);
+        env->mem_slot = s;
+        if (store) {
+            probe_write(env, address, VECTOR_SIZE_BYTE, mmu_idx, ra);
+        } else {
+            probe_read(env, address, VECTOR_SIZE_BYTE, mmu_idx, ra);
+        }
+    }
+}
+#endif
+
 #ifdef CONFIG_USER_ONLY
 /*
  * User mode has no qtimer device backing TIMERLO/TIMERHI, so derive the
@@ -493,6 +528,9 @@ static void probe_hvx_stores(CPUHexagonState *env, int mmu_idx,
     /* Normal (possibly masked) vector store */
     for (int i = 0; i < VSTORES_MAX; i++) {
         if (env->vstore_pending[i]) {
+#ifndef CONFIG_USER_ONLY
+            env->mem_slot = i;
+#endif
             target_ulong va = env->vstore[i].va;
             int size = env->vstore[i].size;
             for (int j = 0; j < size; j++) {
-- 
2.43.0


