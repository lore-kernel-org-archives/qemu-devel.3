Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1338606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CFu2SbwO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQYgX-0000lM-OA; Mon, 09 Nov 2026 18:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYgO-0000iB-IQ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:21:50 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYgM-0000Na-7y
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:21:47 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LA6j12030045
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 23:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eu/YX7QIYH1
 h6VrRdNB/UgXQbuGA4H3roz731Kta6i4=; b=CFu2SbwOlOf4T3XeTiBBugkYTqV
 LvzwxhU85Jv7MflNB/QCmC4H3lEHU1uBYU+oOSroEXKdYZavnbtKA995pxJ4qEIR
 nJrMb+9C1kqVTEL6UUASnxefQp+mEhKI44OuWhf0VB8BCJS9zZEeHrxqfyM6xzJV
 SUrvcRakbvzD5fJK1A1ycFFzrCKqkN/Bp8qpuR53d+Kspww97S2Igb2MHFIyTN3g
 SiKvXMF+a/rekFBtCYqElLjWWBahrAZnflG7IzFmnxXtNKj2Mr6xx8fjHtZKOJJU
 3OG68s9bZnZugZfRgCvcdj6vKmUEaX4HA74XDKOxkieKAOcYpxVnSGRLugg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx81wnt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 23:21:44 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9NIOG92602885
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 23:21:43 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6A9NLhN92606488
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 23:21:43 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id DBACA25740; Mon,  9 Nov 2026 15:21:42 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 2/3] target/hexagon: serialize TLB invalidation and IMASK
 access
Date: Mon,  9 Nov 2026 15:21:41 -0800
Message-ID: <20261109232142.4081792-3-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
References: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af25588 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=DE7XvRD9089hcuUG1cQA:9
X-Proofpoint-GUID: VjrUs8xg98iC9mVJojjANU1dgaSkUgpJ
X-Proofpoint-ORIG-GUID: VjrUs8xg98iC9mVJojjANU1dgaSkUgpJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfX03+YN+G19iuC
 1g8zxRmapiLue0c8JMcdhaSgQ6lmcBb3+fRQ/Q8YHVy9T4m+bNvygMqilPcL3/o5kteVQYnjOqJ
 k/f3Z4EkBG9ygn1GRkLCAs1ZLNxMYaQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfX1/VZkrZMeeMr
 ipTYjIsY4Bp1jAuSD67kbkyOJIWU4klWjn9cH/tuI4RrGm+KpIXTkIhlLF8OZ+ZtcQORF71Cqb0
 rcz8DY0pC5cxYKhH7c0VUEA/gVjcnNRTVt2cIxNd/vuWzbDjspYdD+/pW9mI1rP3xLKIssWt7PF
 fB3CPBmu3WQzqk1edivbkDhbmdsmgFOPU4bR3BLerZOyq6sHB35kAiLT7+Dzc51mjJXZRm9/jb4
 1KLToHPt+pUktQLMhUaAp97PRW6jb0Ew5pJVkDe9ZE/Fvq0hnK+hd8UwN4Q6ElydQRwKS0j17Y6
 LD9OwYGN4SMBTsOmCSZtuJ41LXfWJ1rKaV+BQcdzJ0eCj71dQHzlKpf7edC6202j6NLSD56M4pz
 nrJCKy6NC2lCegSAEHGgsNWMTi/tcd2vext8WuWjX49UvubxrvzLsZa7U23X6468JAQ+4DKmWGs
 PtDd9Ka2sb5gLX/UcnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090093
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

Hold the shared TLB mutex during ASID invalidation so it cannot
overwrite a concurrent entry replacement.

Route local IMASK reads and writes through BQL-protected helpers
to serialize them with cross-thread interrupt assignment. Apply
the pre-V81 writable-bit mask under the same lock.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 hw/hexagon/hexagon_tlb.c   |  1 +
 target/hexagon/genptr.c    | 17 +++++++++--------
 target/hexagon/op_helper.c |  4 ++++
 target/hexagon/translate.c | 16 ++++++++++++----
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
index 3e72026d62a..07406cea35e 100644
--- a/hw/hexagon/hexagon_tlb.c
+++ b/hw/hexagon/hexagon_tlb.c
@@ -325,6 +325,7 @@ uint32_t hexagon_tlb_invalidate_asid(HexagonTLBState *tlb, uint32_t asid)
 {
     uint32_t invalidated = 0;
 
+    QEMU_LOCK_GUARD(&tlb->lock);
     for (uint32_t i = 0; i < tlb->num_entries; i++) {
         uint64_t entry = tlb->entries[i];
 
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index addb5d23d90..52615628e3f 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -302,13 +302,11 @@ static void gen_log_sreg_write(DisasContext *ctx, int rnum, TCGv_i32 val)
     if (rnum == HEX_SREG_MODECTL || rnum == HEX_SREG_SYSCFG) {
         translator_io_start(&ctx->base);
     }
-    if (rnum == HEX_SREG_IMASK &&
-        ctx->hex_def->hex_version < HEX_VER_V81) {
-        reg_mask = 0xffff0000;
-    }
-
     if (reg_mask != IMMUTABLE) {
-        if (rnum < HEX_SREG_GLB_START) {
+        if (rnum == HEX_SREG_IMASK) {
+            /* Commit through a helper to serialize with iassignw/setimask. */
+            tcg_gen_mov_i32(ctx->t_sreg_new_value[rnum], val);
+        } else if (rnum < HEX_SREG_GLB_START) {
             gen_masked_reg_write(val, hex_t_sreg[rnum], reg_mask);
             if (ctx->need_commit || rnum == HEX_SREG_SSR ||
                 rnum == HEX_SREG_CCR) {
@@ -343,7 +341,8 @@ static void gen_read_sreg(DisasContext *ctx, TCGv_i32 dst, int reg_num)
         reg_num == HEX_SREG_PCYCLELO || reg_num == HEX_SREG_PCYCLEHI) {
         translator_io_start(&ctx->base);
     }
-    if (reg_num >= HEX_SREG_GLB_START || reg_num == HEX_SREG_BADVA) {
+    if (reg_num >= HEX_SREG_GLB_START || reg_num == HEX_SREG_BADVA ||
+        reg_num == HEX_SREG_IMASK) {
         gen_helper_sreg_read(dst, tcg_env, tcg_constant_i32(reg_num));
     } else {
         tcg_gen_mov_i32(dst, hex_t_sreg[reg_num]);
@@ -356,7 +355,9 @@ static void gen_read_sreg_pair(DisasContext *ctx, TCGv_i64 dst, int reg_num)
     if (reg_num == HEX_SREG_TIMERLO || reg_num == HEX_SREG_PCYCLELO) {
         translator_io_start(&ctx->base);
     }
-    if (reg_num < HEX_SREG_GLB_START) {
+    if (reg_num == HEX_SREG_IMASK) {
+        gen_helper_sreg_read_pair(dst, tcg_env, tcg_constant_i32(reg_num));
+    } else if (reg_num < HEX_SREG_GLB_START) {
         if (reg_num + 1 == HEX_SREG_BADVA) {
             TCGv_i32 badva = tcg_temp_new_i32();
             gen_helper_sreg_read(badva, tcg_env,
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 0a16778e5e2..71b27ef07f1 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1994,6 +1994,10 @@ void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
 {
     BQL_LOCK_GUARD();
     if (reg < HEX_SREG_GLB_START) {
+        if (reg == HEX_SREG_IMASK &&
+            env_archcpu(env)->cfg.hex_def->hex_version < HEX_VER_V81) {
+            val = deposit32(env->t_sreg[reg], 0, 16, val);
+        }
         env->t_sreg[reg] = val;
     } else {
         HexagonCPU *cpu = env_archcpu(env);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8ab28d40d34..ec1d79e31f6 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -804,8 +804,13 @@ static void gen_start_packet(DisasContext *ctx)
         int reg_num = ctx->sreg_log[i];
         if (reg_num < HEX_SREG_GLB_START) {
             ctx->t_sreg_new_value[reg_num] = tcg_temp_new();
-            tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num],
-                          hex_t_sreg[reg_num]);
+            if (reg_num == HEX_SREG_IMASK) {
+                gen_helper_sreg_read(ctx->t_sreg_new_value[reg_num], tcg_env,
+                                     tcg_constant_i32(reg_num));
+            } else {
+                tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num],
+                              hex_t_sreg[reg_num]);
+            }
         }
     }
     for (i = 0; i < NUM_GREGS; i++) {
@@ -1071,8 +1076,11 @@ static void gen_sreg_writes(DisasContext *ctx)
                                   old_reg);
             /* A CCR write can change context, so end the TB. */
             ctx->base.is_jmp = DISAS_NORETURN;
+        } else if (reg_num == HEX_SREG_IMASK) {
+            gen_helper_sreg_write_masked(tcg_env, tcg_constant_i32(reg_num),
+                                         ctx->t_sreg_new_value[reg_num]);
+            gen_helper_pending_interrupt(tcg_env);
         } else if ((reg_num == HEX_SREG_STID) ||
-                    (reg_num == HEX_SREG_IMASK) ||
                    (reg_num == HEX_SREG_IPENDAD) ||
                    (reg_num == HEX_SREG_IPEND) ||
                    (reg_num == HEX_SREG_IAD)) {
@@ -1715,7 +1723,7 @@ void hexagon_translate_init(void)
                 hexagon_gregnames[i]);
     }
     for (i = 0; i < NUM_SREGS; i++) {
-        if (i < HEX_SREG_GLB_START) {
+        if (i < HEX_SREG_GLB_START && i != HEX_SREG_IMASK) {
             hex_t_sreg[i] = tcg_global_mem_new_i32(tcg_env,
                 offsetof(CPUHexagonState, t_sreg[i]),
                 hexagon_sregnames[i]);
-- 
2.43.0


