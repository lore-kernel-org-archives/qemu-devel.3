Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E8CC982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJM-0000zq-EV; Wed, 16 Sep 2026 09:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJG-0000yc-UD
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:23 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJE-0000Gj-T7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:22 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso843076a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563859; x=1790168659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iGTYR7UCITvKY2ETDmItcN5Fwca4QkduNfX2aKwaQfk=;
 b=Z6YhuSYBRqiMSrqcavjuqDWagyUtZuGSAkoXq7bgKkR4uqZ7zsQCeo34sytOcEjxwH
 nH0kNvms9gR7/AHQ45UvliNq9bCQXJEdgD8K0zuJGbHrjMBiphzfoYhi8JFo+DdCRe+Q
 niweY38tC+ciRj8TyXJa+fvMuUTHzMh2YelDk3KXfS1dwpoRnpOI+BxTte6ENiCg2lY0
 75YUcJxpgNabTpblGVEr59hU2HuSt5PyOHJ47snvczofHNBE6Q/LKmztbUBxr5gne+m5
 jkM+Y/5IdvHlLJr70rQN+vnoSHwGgJTqAKjpQlv7F4zBckNULRbEMRNWMsqIcnAX9j5s
 USew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563859; x=1790168659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iGTYR7UCITvKY2ETDmItcN5Fwca4QkduNfX2aKwaQfk=;
 b=G4PGjhUGojlAtNpS7z4+dEScTqpz1zDvuFL+Tr50XIhlVKKOulC6z1Edxjqmk9g7A2
 /GDvXRarPCKEba3tQh5NZB6Khg9hjJRE4mvQEmTgJ4n0rsLn14uscFs96AHU/ToiH96c
 3YQci3sqAVgEomef+yEBn3xo5b1020fj1UasB1ULleDVPtvKWqToQxKVv3JaRWWNtQ5n
 6DyuC6a4wkCnNiqw73HZE/wLBssgfgvIT/0ChF9y6GTb0adNq8JM5luqoBt4OLF66DX0
 gx0GPsyp2dEtpRUUudW819z20jrcymnC3X3QzQMLj7xk1FckVnHixMN1oOYPH4VW2ANv
 iB6w==
X-Gm-Message-State: AFuF++m65vqTfBIJthuY0IAG6I0nPbha770/8pExHviUHSyMz5+I3YNY
 OxRL6cA5KSdW3Ec4hmGb98PiBptDwFMZ2O2T7HQ411kXHRMh2CLcP0c9ylbFzJy3Czg0mXKG8TF
 JV9SA
X-Gm-Gg: AYBFou3AS5iqs/OpPBuiUEEI5dB7LiH28jp1NaQUsvdhDHXyaoUG9A/gGUfv7Y0xoQK
 zwrb9Cbu4o/VzE7HRUSOrPqhOImuiSE22QaGUUvZdWTyYCZ60wZRrFx2BtGaZkK4mXKswtY6YWd
 0VykdNS/lo7Toz1uDP+0Co81ux+p6OvYnheJspUnwekua7jmVSQee5Y89pvciR5FeAtScxanRxi
 r1RPFydCqIOIUFFKSVavlmaheZXXfbMiIpHriiELDi3Sa/IQv/6Xjn5hkz74SIh8NMjzUZn22Qu
 ou/dMB6R84Xcj0VFMJJixDjCIXVL8k0xcr4Qn2yJBj8Se8ekcmPNRm63plDKJWEx1xlb6IAPsAz
 mcaAQh6n0UQ31Vjp3cWf6PY1rKCAckEc+90Js1RZ4PzNsCk+n2iQmdfZhoxH4mS5BezXiXGELjR
 WYgqS9NEKps4um52Z+VVlndEwAB7Bqu7NgEcPrOLnvIMQDndVryZ1dvOnAnmcCAQq0/ndqnDH2g
 599MVc=
X-Received: by 2002:a17:90a:d407:b0:39d:fcbe:fe00 with SMTP id
 98e67ed59e1d1-39e1e52242amr7709680a91.22.1789563859349; 
 Wed, 16 Sep 2026 06:04:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/92] tcg: Annontate functions in tcg.h with QEMU_*_NONNULL
Date: Wed, 16 Sep 2026 03:02:38 -1000
Message-ID: <20260916130409.3382710-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
index 7669dc1c2db..27ea86ce02a 100644
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
+QEMU_RET_ARG_NONNULL TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
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


