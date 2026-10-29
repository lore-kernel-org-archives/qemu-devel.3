Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D7606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ItG1Lsdh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBj-0007wS-VR; Thu, 29 Oct 2026 13:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qL-9F
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bv-My
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD9Ot3873152; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ee23CAWTvZJ
 V9Ly012XJi0UreEG+ABEhGjAR4UO2vTU=; b=ItG1LsdhryChQ45Qx5nYQMblZTf
 GGxzngorrqOPdBSCygoe4CuSOd5Pnb4/btHAdncHEhoiGTixa+hNcQTNToioX8my
 NdWSlfM7c1STjy//lRQYTUDClwQFjDL9m3BWZEdS5iODy+/bjltj+wUiDlHRDbZ7
 L5fC3jdM6cGI/IQYKDdkqvXGeSn5fPcQJVtmwyKX7MXNmXEli8epC5zDVtUEXA8J
 7iTNmXBuThJHQ7sJFCSkSMS77wIYNydeUjM+/OjqIsvKQnQR9VGAejxRJov7H/9B
 lLAmeAo4GAp5u6u1DASlw/Qf4pbMGBez8/5SAQTk3gN2Xdt8CUr1FE12/og==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76217qu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEGs2549260; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69THiEoM2549241
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 9F38D2583D; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 11/20] target/hexagon: translate packets with HLX instructions
Date: Thu, 29 Oct 2026 10:44:04 -0700
Message-ID: <20261029174413.643130-12-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: zu8KB3SEJrjmUsjh-HRGgWknaJC1Aks-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX/+bjjqP3wiXk
 AWycAg90hJ5UXwlqa76W7dWT3r4beJJAMqsANFYiLb5VzH/tF5+wywWCL8IimIWFp+Exfw6F8HF
 xzhuNKcdKmpEC5lLJ0XpQyWNmIMoPNxYm3uLPdx8MkqQKpgzp0UR1LX/P/xfvElBCbqcTHs/WiV
 x9ElRAAeXH91qtRcEtZBXmbLxYWSkqK8oMkzq+DGwlhlH9+/VvRibju+jPYzhGG8amBWiRDfyyv
 04q1UFyc826/DXpS6T+Bd0FeDMy5noOUTNutYAFy3Z46Nfx9x/w3539QBS/tw0JGSQIQQNbmHFQ
 /V6BSqycbb8YaN27sfnm7lmVos7qYp2pUfvauhB6UTiurB0kp/G5PZYmsB430XBTpAaMTmbTIHC
 lJk0hDsj7KtY0/rTptfqqowNGT8i/GVu20KTEPQVf/s6xbWoEz2n9TwJYDHBeh71xb31putMXNZ
 NYcA2O7jfyb0XpnrZlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX95uzMyGwhlhc
 aXaCGhjQmi7/dGEJNsURaahp5F9U8Yjfa5POrOn3BBTfZwhaBWZ+l6G9y/31Z+fzOiwZrnOt8AF
 V78ubVw3E98wZ3CUplfAXvhbCEpSVWM=
X-Authority-Analysis: v=2.4 cv=Kv3YSmWN c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=bVSFbGziUG28uJ439S4A:9
X-Proofpoint-GUID: zu8KB3SEJrjmUsjh-HRGgWknaJC1Aks-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Track HLX register updates and commit them at packet end. Run .tmp
loads, other instructions, and stores in separate passes.

Raise the disabled-coprocessor exception without an active context.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.c | 108 +++++++++++++++++++++++++++++++++++--
 target/hexagon/translate.h |  48 +++++++++++++++++
 2 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index ed246e226f..41b7d3b0fb 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -18,6 +18,7 @@
 #define QEMU_GENERATE
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "hw/hexagon/hexagon_hlx.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/helper-gen.h"
@@ -33,6 +34,8 @@
 #include "genptr.h"
 #include "printinsn.h"
 #include "exec/target_page.h"
+#include "hlx/hlx.h"
+#include "trace.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -341,6 +344,26 @@ static bool need_slot_cancelled(Packet *pkt)
     return false;
 }
 
+#ifndef CONFIG_USER_ONLY
+static void gen_hlx_check(DisasContext *ctx)
+{
+    TCGv xe = tcg_temp_new();
+    TCGv_ptr hlx_ctx = tcg_temp_new_ptr();
+    TCGLabel *raise = gen_new_label();
+    TCGLabel *enabled = gen_new_label();
+
+    tcg_gen_extract_tl(xe, hex_t_sreg[HEX_SREG_CCR],
+            reg_field_info[CCR_XE3].offset,
+            reg_field_info[CCR_XE3].width);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, xe, 0, raise);
+    tcg_gen_ld_ptr(hlx_ctx, tcg_env, offsetof(CPUHexagonState, hlx_ctx));
+    tcg_gen_brcondi_ptr(TCG_COND_NE, hlx_ctx, 0, enabled);
+    gen_set_label(raise);
+    gen_precise_exception(HEX_CAUSE_NO_COPROC3_ENABLE, ctx->pkt.pc);
+    gen_set_label(enabled);
+}
+#endif
+
 #ifndef CONFIG_USER_ONLY
 static bool sreg_write_ends_tb(int reg_num)
 {
@@ -678,6 +701,12 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->qregs_multi_write, NUM_QREGS);
     bitmap_zero(ctx->qregs_uncond, NUM_QREGS);
     ctx->qreg_log_idx = 0;
+    ctx->lreg_log_idx = 0;
+    ctx->lreg_tmp_log_idx = 0;
+    bitmap_zero(ctx->lregs_updated, NUM_LREGS);
+    bitmap_zero(ctx->lregs_multi_write, NUM_LREGS);
+    bitmap_zero(ctx->lregs_updated_tmp, NUM_LREGS);
+    ctx->hlx_base_loaded = false;
     for (i = 0; i < STORES_MAX; i++) {
         ctx->store_width[i] = 0;
     }
@@ -701,6 +730,11 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
         return true;
     }
 
+    /* HLX instructions are unpredicated, so multiple writes conflict. */
+    if (!bitmap_empty(ctx->lregs_multi_write, NUM_LREGS)) {
+        return true;
+    }
+
 #ifndef CONFIG_USER_ONLY
     if (!bitmap_empty(ctx->gregs_multi_write, NUM_GREGS)) {
         return true;
@@ -742,6 +776,17 @@ static void analyze_packet(DisasContext *ctx)
     ctx->need_commit = need_commit(ctx);
 }
 
+static bool pkt_has_hlx_store(Packet *pkt)
+{
+    for (int i = 0; i < pkt->num_insns; i++) {
+        int opcode = pkt->insn[i].opcode;
+        if (GET_ATTRIB(opcode, A_HLX) && GET_ATTRIB(opcode, A_STORE)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static void gen_start_packet(DisasContext *ctx)
 {
     int i;
@@ -776,6 +821,11 @@ static void gen_start_packet(DisasContext *ctx)
     if (need_slot_cancelled(&ctx->pkt)) {
         tcg_gen_movi_tl(hex_slot_cancelled, 0);
     }
+    if (pkt_has_hlx_store(&ctx->pkt)) {
+        /* An earlier fault can leave a store logged. */
+        tcg_gen_st8_i32(tcg_constant_i32(0), tcg_env,
+                        offsetof(CPUHexagonState, hlx_store_pending));
+    }
     ctx->branch_taken = NULL;
     if (ctx->pkt.pkt_has_cof) {
         ctx->branch_taken = tcg_temp_new();
@@ -860,6 +910,14 @@ static void gen_start_packet(DisasContext *ctx)
         gen_precise_exception(HEX_CAUSE_NO_COPROC_ENABLE, ctx->pkt.pc);
         ctx->hvx_check_emitted = true;
     }
+    if (ctx->pkt.pkt_has_hlx) {
+        if (!ctx->hlx_coproc_enabled) {
+            gen_precise_exception(HEX_CAUSE_NO_COPROC3_ENABLE, ctx->pkt.pc);
+        } else if (!ctx->hlx_check_emitted) {
+            gen_hlx_check(ctx);
+            ctx->hlx_check_emitted = true;
+        }
+    }
 #endif
 }
 
@@ -1206,6 +1264,17 @@ static void gen_commit_hvx(DisasContext *ctx)
     }
 }
 
+static void gen_commit_hlx(DisasContext *ctx)
+{
+    int i;
+
+    for (i = 0; i < ctx->lreg_log_idx; i++) {
+        int rnum = ctx->lreg_log[i];
+        gen_helper_hlx_commit_reg(tcg_env, tcg_constant_i32(rnum));
+    }
+
+}
+
 static void update_exec_counters(DisasContext *ctx)
 {
     int num_real_insns = 0;
@@ -1332,6 +1401,9 @@ static void gen_commit_packet(DisasContext *ctx)
     }
 
     process_store_log(ctx);
+    if (pkt_has_hlx_store(&ctx->pkt)) {
+        gen_helper_hlx_commit_store(tcg_env);
+    }
 
     gen_reg_writes(ctx);
 #ifndef CONFIG_USER_ONLY
@@ -1342,6 +1414,9 @@ static void gen_commit_packet(DisasContext *ctx)
     if (ctx->pkt.pkt_has_hvx) {
         gen_commit_hvx(ctx);
     }
+    if (ctx->pkt.pkt_has_hlx) {
+        gen_commit_hlx(ctx);
+    }
     update_exec_counters(ctx);
 
     if (ctx->pkt.vhist_insn != NULL) {
@@ -1404,9 +1479,31 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         }
 #endif
         gen_start_packet(ctx);
-        for (i = 0; i < ctx->pkt.num_insns; i++) {
-            ctx->insn = &ctx->pkt.insn[i];
-            gen_insn(ctx);
+        if (ctx->pkt.pkt_has_hlx) {
+            /* Run .tmp loads first and stores last. */
+            for (int pass = 0; pass < 3; pass++) {
+                for (i = 0; i < ctx->pkt.num_insns; i++) {
+                    Insn *insn = &ctx->pkt.insn[i];
+                    bool tmp = GET_ATTRIB(insn->opcode, A_HLX_TMP);
+                    bool store = !tmp && GET_ATTRIB(insn->opcode, A_STORE);
+                    if (pass != (tmp ? 0 : store ? 2 : 1)) {
+                        continue;
+                    }
+                    ctx->insn = insn;
+                    if (GET_ATTRIB(insn->opcode, A_HLX) &&
+                        trace_event_get_state_backends(
+                            TRACE_HEXAGON_HLX_OP)) {
+                        gen_helper_hlx_trace_op(tcg_env,
+                            tcg_constant_i32(insn->opcode));
+                    }
+                    gen_insn(ctx);
+                }
+            }
+        } else {
+            for (i = 0; i < ctx->pkt.num_insns; i++) {
+                ctx->insn = &ctx->pkt.insn[i];
+                gen_insn(ctx);
+            }
         }
         gen_commit_packet(ctx);
         ctx->base.pc_next += ctx->pkt.encod_pkt_size_in_bytes;
@@ -1426,6 +1523,11 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->num_packets = 0;
     ctx->num_insns = 0;
     ctx->num_hvx_insns = 0;
+#ifndef CONFIG_USER_ONLY
+    ctx->hlx_coproc_enabled = hex_cpu->hlx != NULL &&
+                              hex_cpu->hlx->contexts_bitmap != 0;
+    ctx->hlx_check_emitted = false;
+#endif
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
     ctx->short_circuit = hex_cpu->cfg.short_circuit;
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index bc5f202163..fa7e627200 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -91,6 +91,7 @@ typedef struct DisasContext {
     TCGCond branch_cond;
     target_ulong branch_dest;
     bool is_tight_loop;
+    bool hlx_check_emitted;
     bool short_circuit;
     bool ieee_fp_extension;
     bool read_after_write;
@@ -101,10 +102,57 @@ typedef struct DisasContext {
     TCGv dczero_addr;
     bool hvx_coproc_enabled;
     bool hvx_check_emitted;
+    bool hlx_coproc_enabled;
+    TCGv_ptr hlx_base;
+    bool     hlx_base_loaded;
+    int lreg_log[NUM_LREGS];
+    int lreg_log_idx;
+    int lreg_tmp_log[NUM_LREGS];
+    int lreg_tmp_log_idx;
+    DECLARE_BITMAP(lregs_updated, NUM_LREGS);
+    DECLARE_BITMAP(lregs_multi_write, NUM_LREGS);
+    DECLARE_BITMAP(lregs_updated_tmp, NUM_LREGS);
 } DisasContext;
 
 bool is_gather_store_insn(DisasContext *ctx);
 
+static inline TCGv_ptr ctx_get_hlx_base(DisasContext *ctx)
+{
+    if (!ctx->hlx_base_loaded) {
+        ctx->hlx_base = tcg_temp_new_ptr();
+        tcg_gen_ld_ptr(ctx->hlx_base, tcg_env,
+                       offsetof(CPUHexagonState, hlx_ctx));
+        ctx->hlx_base_loaded = true;
+    }
+    return ctx->hlx_base;
+}
+
+static inline void ctx_log_lreg_write(DisasContext *ctx, int rnum)
+{
+    if (test_bit(rnum, ctx->lregs_updated)) {
+        set_bit(rnum, ctx->lregs_multi_write);
+    } else {
+        ctx->lreg_log[ctx->lreg_log_idx] = rnum;
+        ctx->lreg_log_idx++;
+        set_bit(rnum, ctx->lregs_updated);
+    }
+}
+
+static inline void ctx_log_lreg_write_pair(DisasContext *ctx, int rnum)
+{
+    ctx_log_lreg_write(ctx, rnum ^ 0);
+    ctx_log_lreg_write(ctx, rnum ^ 1);
+}
+
+static inline void ctx_log_lreg_tmp_write(DisasContext *ctx, int rnum)
+{
+    if (!test_bit(rnum, ctx->lregs_updated_tmp)) {
+        ctx->lreg_tmp_log[ctx->lreg_tmp_log_idx] = rnum;
+        ctx->lreg_tmp_log_idx++;
+        set_bit(rnum, ctx->lregs_updated_tmp);
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
 {
-- 
2.43.0


