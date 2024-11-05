Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8F7D31761
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MOx-0003Gs-SN; Tue, 05 Nov 2024 11:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1t8MOw-0003Gg-4x
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:27:30 -0500
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1t8MOt-00023j-PO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:27:29 -0500
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83a9ca86049so204098639f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730824045; x=1731428845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IheMbRsSMuwXHZQbkqcuQddvPvg7+U0B4I3MMZEaCjI=;
 b=S0g2k2iPUHvfSgP3MJ30Sb8mza7POjnvhVf0o7X2iLD6aLVvSdrMvn2azokQasVwAy
 6Z0KqAP9RUof2PM3uhi3u7Vl99YVDbYKf8moU0Znf9c8imP14E2Z3hGDtB4fWM74QGPB
 B+9HG+k2B6HLFSDMBphz59KEiF8ugjZf9QKXEm8oWFBlWGID/Fv1rlV2zrnMCD0f3jIw
 Wgg9CzqykLaSdl0SLfMM75uC1ELMHmqOyfl/5PkmiQPyi7B7zDFGjJFv1E0TVr81KzVA
 Evd1I/DstfrTYGzTWRcGBDqFqOyzFkW0Svcnu1FDGeEqYath8VYUkAWURr5UCNw4z693
 IbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730824045; x=1731428845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IheMbRsSMuwXHZQbkqcuQddvPvg7+U0B4I3MMZEaCjI=;
 b=LMjVcm5CmPzwxalT/u0wpZf9zsxXGI6B1amfGHTthYH+xfG/7t9VCBLTEYsML5/AS8
 Mp8sj8joxUW8hR5AbMkhkKSfQ70358Ed7yvtunSNll1EvcYEWfnGZL3sX0juODGsFYJa
 yqJey5V2PuktO8N2B/MEDD+27+/+ncIi9cUxs30GfvG//DUverGx4XBQdbs8A+2xz1L1
 UQ4UXfgfhbc86BA+Ysx47mfEKr3P4676ETwaoRZ7K0NcNJo4xfmJr2OgMBe+C0gKwmMU
 eS4oWRilr4ekrph4On97vRC2QIDPrdfC5UxhEgV9HoeGv2y7OLC9rWxKZdlomDxMPX/E
 ruHw==
X-Gm-Message-State: AOJu0YyyHMiOC1PNGLANGa9UEyK1yHn8+VQsLLz5qubPQKd9zKL/TZTg
 ffjclbC3bg5J8+Yz53gRfM2nwBAOrRxITuq09pzSPh05tjcBNcZBvmX73TlL
X-Google-Smtp-Source: AGHT+IFb8YWyX2YrcVzz2tCjxzfBSW20o8QBW4QtB4zRBXvA+wsqs7M4p6GClVZvLpdwJ3blmILJ0A==
X-Received: by 2002:a05:6602:340a:b0:82a:a8af:626f with SMTP id
 ca18e2360f4ac-83b1c3b88e3mr3557344039f.2.1730824045448; 
 Tue, 05 Nov 2024 08:27:25 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-76-25-176-104.hsd1.co.comcast.net. [76.25.176.104])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04ac93besm2481273173.161.2024.11.05.08.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:27:24 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2] Hexagon (target/hexagon) Remove HEX_DEBUG/HEX_DEBUG_LOG
Date: Tue,  5 Nov 2024 09:27:22 -0700
Message-Id: <20241105162722.66247-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

All Hexagon debugging is now done with QEMU mechanisms
(e.g., -d in_asm) or with a connected debugger (lldb).

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/cpu.h       |   6 --
 target/hexagon/helper.h    |   3 -
 target/hexagon/internal.h  |  11 ----
 target/hexagon/translate.h |   2 -
 target/hexagon/genptr.c    |   7 ---
 target/hexagon/op_helper.c | 112 -------------------------------------
 target/hexagon/translate.c |  66 ----------------------
 target/hexagon/README      |   9 ---
 8 files changed, 216 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 764f3c38cc..25150d5214 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -79,12 +79,6 @@ typedef struct CPUArchState {
     uint8_t slot_cancelled;
     target_ulong new_value_usr;
 
-    /*
-     * Only used when HEX_DEBUG is on, but unconditionally included
-     * to reduce recompile time when turning HEX_DEBUG on/off.
-     */
-    target_ulong reg_written[TOTAL_PER_THREAD_REGS];
-
     MemLog mem_log_stores[STORES_MAX];
 
     float_status fp_status;
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index fa0ebaf7c8..f8baa599c8 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -19,9 +19,6 @@
 #include "helper_protos_generated.h.inc"
 
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32)
-DEF_HELPER_1(debug_start_packet, void, env)
-DEF_HELPER_FLAGS_3(debug_check_store_width, TCG_CALL_NO_WG, void, env, int, int)
-DEF_HELPER_FLAGS_5(debug_commit_end, TCG_CALL_NO_WG, void, env, i32, int, int, int)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index beb08cb7e3..32e96f00d9 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -20,17 +20,6 @@
 
 #include "qemu/log.h"
 
-/*
- * Change HEX_DEBUG to 1 to turn on debugging output
- */
-#define HEX_DEBUG 0
-#define HEX_DEBUG_LOG(...) \
-    do { \
-        if (HEX_DEBUG) { \
-            qemu_log(__VA_ARGS__); \
-        } \
-    } while (0)
-
 int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int hexagon_hvx_gdb_read_register(CPUState *env, GByteArray *mem_buf, int n);
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 00cc2bcd63..d251e2233f 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -73,7 +73,6 @@ typedef struct DisasContext {
     bool has_hvx_overlap;
     TCGv new_value[TOTAL_PER_THREAD_REGS];
     TCGv new_pred_value[NUM_PREGS];
-    TCGv pred_written;
     TCGv branch_taken;
     TCGv dczero_addr;
 } DisasContext;
@@ -271,7 +270,6 @@ extern TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
 extern TCGv hex_pred[NUM_PREGS];
 extern TCGv hex_slot_cancelled;
 extern TCGv hex_new_value_usr;
-extern TCGv hex_reg_written[TOTAL_PER_THREAD_REGS];
 extern TCGv hex_store_addr[STORES_MAX];
 extern TCGv hex_store_width[STORES_MAX];
 extern TCGv hex_store_val32[STORES_MAX];
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index dbae6c570a..2c5e15cfcf 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -100,10 +100,6 @@ void gen_log_reg_write(DisasContext *ctx, int rnum, TCGv val)
 
     gen_masked_reg_write(val, hex_gpr[rnum], reg_mask);
     tcg_gen_mov_tl(get_result_gpr(ctx, rnum), val);
-    if (HEX_DEBUG) {
-        /* Do this so HELPER(debug_commit_end) will know */
-        tcg_gen_movi_tl(hex_reg_written[rnum], 1);
-    }
 }
 
 static void gen_log_reg_write_pair(DisasContext *ctx, int rnum, TCGv_i64 val)
@@ -151,9 +147,6 @@ void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val)
     } else {
         tcg_gen_and_tl(pred, pred, base_val);
     }
-    if (HEX_DEBUG) {
-        tcg_gen_ori_tl(ctx->pred_written, ctx->pred_written, 1 << pnum);
-    }
     set_bit(pnum, ctx->pregs_written);
 }
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 90e7aaa097..01d1a1b1a7 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -54,9 +54,6 @@ G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp)
 void log_store32(CPUHexagonState *env, target_ulong addr,
                  target_ulong val, int width, int slot)
 {
-    HEX_DEBUG_LOG("log_store%d(0x" TARGET_FMT_lx
-                  ", %" PRId32 " [0x08%" PRIx32 "])\n",
-                  width, addr, val, val);
     env->mem_log_stores[slot].va = addr;
     env->mem_log_stores[slot].width = width;
     env->mem_log_stores[slot].data32 = val;
@@ -65,35 +62,11 @@ void log_store32(CPUHexagonState *env, target_ulong addr,
 void log_store64(CPUHexagonState *env, target_ulong addr,
                  int64_t val, int width, int slot)
 {
-    HEX_DEBUG_LOG("log_store%d(0x" TARGET_FMT_lx
-                  ", %" PRId64 " [0x016%" PRIx64 "])\n",
-                   width, addr, val, val);
     env->mem_log_stores[slot].va = addr;
     env->mem_log_stores[slot].width = width;
     env->mem_log_stores[slot].data64 = val;
 }
 
-/* Handy place to set a breakpoint */
-void HELPER(debug_start_packet)(CPUHexagonState *env)
-{
-    HEX_DEBUG_LOG("Start packet: pc = 0x" TARGET_FMT_lx "\n",
-                  env->gpr[HEX_REG_PC]);
-
-    for (int i = 0; i < TOTAL_PER_THREAD_REGS; i++) {
-        env->reg_written[i] = 0;
-    }
-}
-
-/* Checks for bookkeeping errors between disassembly context and runtime */
-void HELPER(debug_check_store_width)(CPUHexagonState *env, int slot, int check)
-{
-    if (env->mem_log_stores[slot].width != check) {
-        HEX_DEBUG_LOG("ERROR: %d != %d\n",
-                      env->mem_log_stores[slot].width, check);
-        g_assert_not_reached();
-    }
-}
-
 static void commit_store(CPUHexagonState *env, int slot_num, uintptr_t ra)
 {
     uint8_t width = env->mem_log_stores[slot_num].width;
@@ -173,91 +146,6 @@ void HELPER(commit_hvx_stores)(CPUHexagonState *env)
     }
 }
 
-static void print_store(CPUHexagonState *env, int slot)
-{
-    if (!(env->slot_cancelled & (1 << slot))) {
-        uint8_t width = env->mem_log_stores[slot].width;
-        if (width == 1) {
-            uint32_t data = env->mem_log_stores[slot].data32 & 0xff;
-            HEX_DEBUG_LOG("\tmemb[0x" TARGET_FMT_lx "] = %" PRId32
-                          " (0x%02" PRIx32 ")\n",
-                          env->mem_log_stores[slot].va, data, data);
-        } else if (width == 2) {
-            uint32_t data = env->mem_log_stores[slot].data32 & 0xffff;
-            HEX_DEBUG_LOG("\tmemh[0x" TARGET_FMT_lx "] = %" PRId32
-                          " (0x%04" PRIx32 ")\n",
-                          env->mem_log_stores[slot].va, data, data);
-        } else if (width == 4) {
-            uint32_t data = env->mem_log_stores[slot].data32;
-            HEX_DEBUG_LOG("\tmemw[0x" TARGET_FMT_lx "] = %" PRId32
-                          " (0x%08" PRIx32 ")\n",
-                          env->mem_log_stores[slot].va, data, data);
-        } else if (width == 8) {
-            HEX_DEBUG_LOG("\tmemd[0x" TARGET_FMT_lx "] = %" PRId64
-                          " (0x%016" PRIx64 ")\n",
-                          env->mem_log_stores[slot].va,
-                          env->mem_log_stores[slot].data64,
-                          env->mem_log_stores[slot].data64);
-        } else {
-            HEX_DEBUG_LOG("\tBad store width %d\n", width);
-            g_assert_not_reached();
-        }
-    }
-}
-
-/* This function is a handy place to set a breakpoint */
-void HELPER(debug_commit_end)(CPUHexagonState *env, uint32_t this_PC,
-                              int pred_written, int has_st0, int has_st1)
-{
-    bool reg_printed = false;
-    bool pred_printed = false;
-    int i;
-
-    HEX_DEBUG_LOG("Packet committed: pc = 0x" TARGET_FMT_lx "\n", this_PC);
-    HEX_DEBUG_LOG("slot_cancelled = %d\n", env->slot_cancelled);
-
-    for (i = 0; i < TOTAL_PER_THREAD_REGS; i++) {
-        if (env->reg_written[i]) {
-            if (!reg_printed) {
-                HEX_DEBUG_LOG("Regs written\n");
-                reg_printed = true;
-            }
-            HEX_DEBUG_LOG("\tr%d = " TARGET_FMT_ld " (0x" TARGET_FMT_lx ")\n",
-                          i, env->gpr[i], env->gpr[i]);
-        }
-    }
-
-    for (i = 0; i < NUM_PREGS; i++) {
-        if (pred_written & (1 << i)) {
-            if (!pred_printed) {
-                HEX_DEBUG_LOG("Predicates written\n");
-                pred_printed = true;
-            }
-            HEX_DEBUG_LOG("\tp%d = 0x" TARGET_FMT_lx "\n",
-                          i, env->pred[i]);
-        }
-    }
-
-    if (has_st0 || has_st1) {
-        HEX_DEBUG_LOG("Stores\n");
-        if (has_st0) {
-            print_store(env, 0);
-        }
-        if (has_st1) {
-            print_store(env, 1);
-        }
-    }
-
-    HEX_DEBUG_LOG("Next PC = " TARGET_FMT_lx "\n", env->gpr[HEX_REG_PC]);
-    HEX_DEBUG_LOG("Exec counters: pkt = " TARGET_FMT_lx
-                  ", insn = " TARGET_FMT_lx
-                  ", hvx = " TARGET_FMT_lx "\n",
-                  env->gpr[HEX_REG_QEMU_PKT_CNT],
-                  env->gpr[HEX_REG_QEMU_INSN_CNT],
-                  env->gpr[HEX_REG_QEMU_HVX_CNT]);
-
-}
-
 int32_t HELPER(fcircadd)(int32_t RxV, int32_t offset, int32_t M, int32_t CS)
 {
     uint32_t K_const = extract32(M, 24, 4);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 4b1bee3c6d..bce85eaeb8 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -50,7 +50,6 @@ TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
 TCGv hex_pred[NUM_PREGS];
 TCGv hex_slot_cancelled;
 TCGv hex_new_value_usr;
-TCGv hex_reg_written[TOTAL_PER_THREAD_REGS];
 TCGv hex_store_addr[STORES_MAX];
 TCGv hex_store_width[STORES_MAX];
 TCGv hex_store_val32[STORES_MAX];
@@ -195,21 +194,6 @@ static void gen_exception_end_tb(DisasContext *ctx, int excp)
 
 }
 
-#define PACKET_BUFFER_LEN              1028
-static void print_pkt(Packet *pkt)
-{
-    GString *buf = g_string_sized_new(PACKET_BUFFER_LEN);
-    snprint_a_pkt_debug(buf, pkt);
-    HEX_DEBUG_LOG("%s", buf->str);
-    g_string_free(buf, true);
-}
-#define HEX_DEBUG_PRINT_PKT(pkt) \
-    do { \
-        if (HEX_DEBUG) { \
-            print_pkt(pkt); \
-        } \
-    } while (0)
-
 static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
                              uint32_t words[])
 {
@@ -235,14 +219,6 @@ static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
         g_assert(ctx->base.num_insns == 1);
     }
 
-    HEX_DEBUG_LOG("decode_packet: pc = 0x%" VADDR_PRIx "\n",
-                  ctx->base.pc_next);
-    HEX_DEBUG_LOG("    words = { ");
-    for (int i = 0; i < nwords; i++) {
-        HEX_DEBUG_LOG("0x%x, ", words[i]);
-    }
-    HEX_DEBUG_LOG("}\n");
-
     return nwords;
 }
 
@@ -465,11 +441,6 @@ static void gen_start_packet(DisasContext *ctx)
      */
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
 
-    if (HEX_DEBUG) {
-        /* Handy place to set a breakpoint before the packet executes */
-        gen_helper_debug_start_packet(tcg_env);
-    }
-
     /* Initialize the runtime state for packet semantics */
     if (need_slot_cancelled(pkt)) {
         tcg_gen_movi_tl(hex_slot_cancelled, 0);
@@ -484,10 +455,6 @@ static void gen_start_packet(DisasContext *ctx)
             tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], next_PC);
         }
     }
-    if (HEX_DEBUG) {
-        ctx->pred_written = tcg_temp_new();
-        tcg_gen_movi_tl(ctx->pred_written, 0);
-    }
 
     /* Preload the predicated registers into get_result_gpr(ctx, i) */
     if (ctx->need_commit &&
@@ -635,15 +602,6 @@ static void gen_pred_writes(DisasContext *ctx)
     }
 }
 
-static void gen_check_store_width(DisasContext *ctx, int slot_num)
-{
-    if (HEX_DEBUG) {
-        TCGv slot = tcg_constant_tl(slot_num);
-        TCGv check = tcg_constant_tl(ctx->store_width[slot_num]);
-        gen_helper_debug_check_store_width(tcg_env, slot, check);
-    }
-}
-
 static bool slot_is_predicated(Packet *pkt, int slot_num)
 {
     for (int i = 0; i < pkt->num_insns; i++) {
@@ -691,25 +649,21 @@ void process_store(DisasContext *ctx, int slot_num)
          */
         switch (ctx->store_width[slot_num]) {
         case 1:
-            gen_check_store_width(ctx, slot_num);
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
                                ctx->mem_idx, MO_UB);
             break;
         case 2:
-            gen_check_store_width(ctx, slot_num);
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
                                ctx->mem_idx, MO_TEUW);
             break;
         case 4:
-            gen_check_store_width(ctx, slot_num);
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
                                ctx->mem_idx, MO_TEUL);
             break;
         case 8:
-            gen_check_store_width(ctx, slot_num);
             tcg_gen_qemu_st_i64(hex_store_val64[slot_num],
                                 hex_store_addr[slot_num],
                                 ctx->mem_idx, MO_TEUQ);
@@ -937,16 +891,6 @@ static void gen_commit_packet(DisasContext *ctx)
         gen_commit_hvx(ctx);
     }
     update_exec_counters(ctx);
-    if (HEX_DEBUG) {
-        TCGv has_st0 =
-            tcg_constant_tl(pkt->pkt_has_store_s0 && !pkt->pkt_has_dczeroa);
-        TCGv has_st1 =
-            tcg_constant_tl(pkt->pkt_has_store_s1 && !pkt->pkt_has_dczeroa);
-
-        /* Handy place to set a breakpoint at the end of execution */
-        gen_helper_debug_commit_end(tcg_env, tcg_constant_tl(ctx->pkt->pc),
-                                    ctx->pred_written, has_st0, has_st1);
-    }
 
     if (pkt->vhist_insn != NULL) {
         ctx->pre_commit = false;
@@ -975,7 +919,6 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
     ctx->pkt = &pkt;
     if (decode_packet(ctx, nwords, words, &pkt, false) > 0) {
         pkt.pc = ctx->base.pc_next;
-        HEX_DEBUG_PRINT_PKT(&pkt);
         gen_start_packet(ctx);
         for (i = 0; i < pkt.num_insns; i++) {
             ctx->insn = &pkt.insn[i];
@@ -1093,7 +1036,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
 }
 
 #define NAME_LEN               64
-static char reg_written_names[TOTAL_PER_THREAD_REGS][NAME_LEN];
 static char store_addr_names[STORES_MAX][NAME_LEN];
 static char store_width_names[STORES_MAX][NAME_LEN];
 static char store_val32_names[STORES_MAX][NAME_LEN];
@@ -1112,14 +1054,6 @@ void hexagon_translate_init(void)
         hex_gpr[i] = tcg_global_mem_new(tcg_env,
             offsetof(CPUHexagonState, gpr[i]),
             hexagon_regnames[i]);
-
-        if (HEX_DEBUG) {
-            snprintf(reg_written_names[i], NAME_LEN, "reg_written_%s",
-                     hexagon_regnames[i]);
-            hex_reg_written[i] = tcg_global_mem_new(tcg_env,
-                offsetof(CPUHexagonState, reg_written[i]),
-                reg_written_names[i]);
-        }
     }
     hex_new_value_usr = tcg_global_mem_new(tcg_env,
         offsetof(CPUHexagonState, new_value_usr), "new_value_usr");
diff --git a/target/hexagon/README b/target/hexagon/README
index 7ffd517d70..ca617e3364 100644
--- a/target/hexagon/README
+++ b/target/hexagon/README
@@ -282,10 +282,6 @@ For Hexagon Vector eXtensions (HVX), the following fields are used
 
 *** Debugging ***
 
-You can turn on a lot of debugging by changing the HEX_DEBUG macro to 1 in
-internal.h.  This will stream a lot of information as it generates TCG and
-executes the code.
-
 To track down nasty issues with Hexagon->TCG generation, we compare the
 execution results with actual hardware running on a Hexagon Linux target.
 Run qemu with the "-d cpu" option.  Then, we can diff the results and figure
@@ -305,8 +301,3 @@ Here are some handy places to set breakpoints
     The helper function for each instruction is named helper_<TAG>, so here's
         an example that will set a breakpoint at the start
         br helper_A2_add
-    If you have the HEX_DEBUG macro set, the following will be useful
-        At the start of execution of a packet for a given PC
-            br helper_debug_start_packet if env->gpr[41] == 0xdeadbeef
-        At the end of execution of a packet for a given PC
-            br helper_debug_commit_end if this_PC == 0xdeadbeef
-- 
2.34.1


