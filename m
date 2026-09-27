Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DB7C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkJ-0002Sj-Pz; Sun, 27 Sep 2026 05:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk8-0002Pb-1u
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:20 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk6-0007OE-0E
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:19 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-88379342f7fso25566b3a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499617; x=1791104417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C4CpkgywQVTv0mD7MmRnQOlutEFAGtvT+lSMXYyHd/s=;
 b=q96h93Aql3Ywi+T6Uy4F4r+tYuQ1dZMRupKB+vbSEOfgxx6vYgKfF750arb3VLQc3v
 ih8YU0OkGHnC7QsS+01uNifKKRIi02FxjBqF7JSH/q5R+1pBdELiN+XHL0Jyp1vqsaKT
 H1T2H/EFsr2h77SrumobZkjgNX5Sr77X4UrSkozxAWSwxuQhGk3HJ/8GfAPceMA/f5P0
 1BCTBtlBhCB7FfaiZWjmaixRNu/e7bRD9qxLPoaejoNEc1u2yQsgk7BKKiysO7lzXubS
 UUI/sGZgSD1CNZueJyJ7h9Q8nIAG5Uok3I+BCmARgGdnnrdZNKkknhEmzp8glU/cWDoJ
 Smxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499617; x=1791104417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C4CpkgywQVTv0mD7MmRnQOlutEFAGtvT+lSMXYyHd/s=;
 b=O8O2D8/EFNcQvbcHdWSX0nsAqAUeTr1N75F+J254lPyZh8RtFDgxboHJ5eVfozqNBg
 GohQY4Oao8tkyBdNuNo279zmHb4wIagYV96YplOVPLupdfjtpUyxKWZo8Uxp9vm4G48X
 kGlRZrT5ldHTwiDKa3OAm2NUqU1+cFvt1aQ74X+fMcQ2UDnA8UbfNB/tGzacX+N0xMp2
 k7n4EEID5jK8Cz5MW4IGu9+2YynoVoXb1r3/FIIJ5l6R5MxMYyqb4wA0vNGVuUUtSyyT
 OK8iLBHaJdWL7tcTFr/DMIn21sDtaKjds42fNxxEZuXuCwJp2Ob/ixcv6Ur2d/Duxc4l
 zmEQ==
X-Gm-Message-State: AFq9FYL1V0kJzpG+awIGLB41lstOR3opFV+CDlhtli7ME/Xoqq+CH/QM
 eln1IQcG5eKcnXjbM8I9AMn95aUj2leaIsuPGlajht/VBMpQ3K4JKInY8C/NoWfe8N2RM/CF5bE
 rCBF0
X-Gm-Gg: AYBFou1g2ADyXZStf4YuRBbM5h6H6nYX5DSyICZwb1qrTGXd5zpeCKlcqyMRJod4p0G
 OtVSOgZumMX/y5OoexdI1iN2E3gqEEIDRJUuyIvec4ekSC+9vLOORJTLC6Wmq0L5FhRcwI5laAe
 C05vpcDvQL4j7W3xi3fB1AAhUuow6q9ieZdW5qcQr1/cAYDTQkgg6LaPhCKSidCfCHfnp2n53n2
 myHxNiZvhOe9qahMtcRtoAvQ8L80YzqnBNTeZSzyxrWt4hUZuLphoUHDyh/bzqPVVNHK54YehKH
 jSICpcFDWSdyJrXm6DWANjubSM2dGDCAG+on/4jnKedQvKV5K84iyWwp44jIudgHWfKDlBAwzIA
 RiCGnfFg3ZnqAirjZ4Cge4QGnvhtgnaUtzxsvsU6gT8QJlTLyOFBrnsa1EFTlJJ7d8i5CCUYNF6
 4KCECtgLQ5HkFWdc/G2nOUbw2vaWSuWcG9fBvZNHjBJavhwzzfq+O6q6y0nQ+2RQmYOh5kF7mDM
 0858wv+mvJ2rVlUIFHfuxE2suGgDw==
X-Received: by 2002:a17:90a:1649:b0:3a0:abe7:f0f3 with SMTP id
 98e67ed59e1d1-3a0abe7f56emr4668255a91.0.1790499616506; 
 Sun, 27 Sep 2026 02:00:16 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 003/101] tcg: Annontate functions in tcg.h with
 QEMU_*_NONNULL
Date: Sun, 27 Sep 2026 01:58:33 -0700
Message-ID: <20260927090011.10724-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 58 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 7669dc1c2db..16ac528340a 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -478,9 +478,10 @@ static inline TCGTemp *arg_temp(TCGArg a)
 }
 
 #ifdef CONFIG_DEBUG_TCG
-size_t temp_idx(TCGTemp *ts);
-TCGTemp *tcgv_i32_temp(TCGv_i32 v);
+QEMU_ARG_NONNULL size_t temp_idx(TCGTemp *ts);
+QEMU_RET_ARG_NONNULL TCGTemp *tcgv_i32_temp(TCGv_i32 v);
 #else
+QEMU_ARG_NONNULL
 static inline size_t temp_idx(TCGTemp *ts)
 {
     return ts - tcg_ctx->temps;
@@ -491,104 +492,124 @@ static inline size_t temp_idx(TCGTemp *ts)
  * its index means that we don't use 0.  That leaves offset 0 free for
  * a NULL representation without having to leave index 0 unused.
  */
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 {
     return (void *)tcg_ctx + (uintptr_t)v;
 }
 #endif
 
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_i64_temp(TCGv_i64 v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_i128_temp(TCGv_i128 v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_ptr_temp(TCGv_ptr v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGTemp *tcgv_vec_temp(TCGv_vec v)
 {
     return tcgv_i32_temp((TCGv_i32)v);
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_i32_arg(TCGv_i32 v)
 {
     return temp_arg(tcgv_i32_temp(v));
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_i64_arg(TCGv_i64 v)
 {
     return temp_arg(tcgv_i64_temp(v));
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_i128_arg(TCGv_i128 v)
 {
     return temp_arg(tcgv_i128_temp(v));
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_ptr_arg(TCGv_ptr v)
 {
     return temp_arg(tcgv_ptr_temp(v));
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcgv_vec_arg(TCGv_vec v)
 {
     return temp_arg(tcgv_vec_temp(v));
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
 {
     (void)temp_idx(t); /* trigger embedded assert */
     return (TCGv_i32)((void *)t - (void *)tcg_ctx);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
 {
     return (TCGv_i64)temp_tcgv_i32(t);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_i128 temp_tcgv_i128(TCGTemp *t)
 {
     return (TCGv_i128)temp_tcgv_i32(t);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_ptr temp_tcgv_ptr(TCGTemp *t)
 {
     return (TCGv_ptr)temp_tcgv_i32(t);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_vaddr temp_tcgv_vaddr(TCGTemp *t)
 {
     return (TCGv_vaddr)temp_tcgv_i32(t);
 }
 
+QEMU_RET_ARG_NONNULL
 static inline TCGv_vec temp_tcgv_vec(TCGTemp *t)
 {
     return (TCGv_vec)temp_tcgv_i32(t);
 }
 
+QEMU_ARG_NONNULL
 static inline TCGArg tcg_get_insn_param(TCGOp *op, unsigned arg)
 {
     return op->args[arg];
 }
 
+QEMU_ARG_NONNULL
 static inline void tcg_set_insn_param(TCGOp *op, unsigned arg, TCGArg v)
 {
     op->args[arg] = v;
 }
 
+QEMU_ARG_NONNULL
 static inline uint64_t tcg_get_insn_start_param(TCGOp *op, unsigned arg)
 {
     tcg_debug_assert(arg < INSN_START_WORDS);
     return tcg_get_insn_param(op, arg);
 }
 
+QEMU_ARG_NONNULL
 static inline void tcg_set_insn_start_param(TCGOp *op, unsigned arg, uint64_t v)
 {
     tcg_debug_assert(arg < INSN_START_WORDS);
@@ -617,9 +638,9 @@ static inline bool tcg_op_buf_full(void)
 /* pool based memory allocation */
 
 /* user-mode: mmap_lock must be held for tcg_malloc_internal. */
-void *tcg_malloc_internal(TCGContext *s, int size);
-void tcg_pool_reset(TCGContext *s);
-TranslationBlock *tcg_tb_alloc(TCGContext *s);
+QEMU_RET_ARG_NONNULL void *tcg_malloc_internal(TCGContext *s, int size);
+QEMU_ARG_NONNULL void tcg_pool_reset(TCGContext *s);
+QEMU_ARG_NONNULL TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
 void tcg_region_reset_all(void);
 
@@ -632,7 +653,7 @@ size_t tcg_code_capacity(void);
  *
  * Insert @tb into the region trees.
  */
-void tcg_tb_insert(TranslationBlock *tb);
+QEMU_ARG_NONNULL void tcg_tb_insert(TranslationBlock *tb);
 
 /**
  * tcg_tb_remove:
@@ -640,7 +661,7 @@ void tcg_tb_insert(TranslationBlock *tb);
  *
  * Remove @tb from the region trees.
  */
-void tcg_tb_remove(TranslationBlock *tb);
+QEMU_ARG_NONNULL void tcg_tb_remove(TranslationBlock *tb);
 
 /**
  * tcg_tb_lookup:
@@ -674,6 +695,7 @@ void tcg_tb_foreach(GTraverseFunc func, gpointer user_data);
 size_t tcg_nb_tbs(void);
 
 /* user-mode: Called with mmap_lock held.  */
+QEMU_RET_NONNULL
 static inline void *tcg_malloc(int size)
 {
     TCGContext *s = tcg_ctx;
@@ -692,8 +714,10 @@ static inline void *tcg_malloc(int size)
     }
 }
 
+QEMU_ARG_NONNULL
 void tcg_func_start(TCGContext *s);
 
+QEMU_ARG_NONNULL
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
 
 void tb_target_set_jmp_target(const TranslationBlock *, int,
@@ -783,7 +807,10 @@ void tcg_gen_call7(void *func, TCGHelperInfo *, TCGTemp *ret,
                    TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *,
                    TCGTemp *, TCGTemp *, TCGTemp *);
 
+QEMU_RET_NONNULL
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
+
+QEMU_ARG_NONNULL
 void tcg_op_remove(TCGContext *s, TCGOp *op);
 
 /**
@@ -794,10 +821,13 @@ void tcg_op_remove(TCGContext *s, TCGOp *op);
  * a starting point with tcg_last_op(), speculatively emit opcodes,
  * then decide whether or not to keep those opcodes after the fact.
  */
+QEMU_ARG_NONNULL
 void tcg_remove_ops_after(TCGOp *op);
 
+QEMU_ARG_NONNULL
 void tcg_optimize(TCGContext *s);
 
+QEMU_RET_NONNULL
 TCGLabel *gen_new_label(void);
 
 /**
@@ -806,7 +836,7 @@ TCGLabel *gen_new_label(void);
  *
  * Encode a label for storage in the TCG opcode stream.
  */
-
+QEMU_ARG_NONNULL
 static inline TCGArg label_arg(TCGLabel *l)
 {
     return (uintptr_t)l;
@@ -837,7 +867,7 @@ static inline TCGLabel *arg_label(TCGArg i)
  * This version relies on GCC's void pointer arithmetic to get the
  * correct result.
  */
-
+QEMU_ARG_NONNULL
 static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
 {
     return a - b;
@@ -851,7 +881,7 @@ static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
  * Produce a pc-relative difference, from the current code_ptr
  * to the destination address.
  */
-
+QEMU_ARG_NONNULL
 static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_ptr));
@@ -865,6 +895,7 @@ static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
  * Produce a difference, from the beginning of the current TB code
  * to the destination address.
  */
+QEMU_ARG_NONNULL
 static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_buf));
@@ -877,7 +908,7 @@ static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
  * Compute the current code size within the translation block.
  * This is used to fill in qemu's data structures for goto_tb.
  */
-
+QEMU_ARG_NONNULL
 static inline size_t tcg_current_code_size(TCGContext *s)
 {
     return tcg_ptr_byte_diff(s->code_ptr, s->code_buf);
@@ -935,12 +966,15 @@ static inline size_t tcg_current_code_size(TCGContext *s)
 #define TB_EXIT_REQUESTED 3
 
 #ifdef CONFIG_TCG_INTERPRETER
+QEMU_ARG_NONNULL
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *tb_ptr);
 #else
-typedef uintptr_t tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
+typedef QEMU_ARG_NONNULL uintptr_t
+    tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
 extern tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
+QEMU_ARG_NONNULL
 void tcg_register_jit(const void *buf, size_t buf_size);
 
 /* Return zero if the tuple (opc, type, vece) is unsupportable;
-- 
2.53.0


