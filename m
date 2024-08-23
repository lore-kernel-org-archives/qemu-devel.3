Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FEFC5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 19:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shZYJ-000579-7j; Fri, 23 Aug 2024 15:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXz-0003s5-GG
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:02:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXv-0004OT-IW
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:02:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-202318c4f45so23579995ad.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724439722; x=1725044522;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyQLd4VEiaZEDU+IbEBX2JDDfbtQtncP24IK0QpEAqA=;
 b=J/v+Bew9GkYME8m1eaGEebYbAQ2USepx10bRegNqaOPl/98VjRpJXL724DM4CCHbY8
 jibVvxuozJACQdD0DFkVVvo+gyYTFmD3QO7BFHJU0nvvbn5lRxWZ1EgaQpvZyDdaBEzP
 nq3YbmUr0WgLJWQBEG36bZMpj4eGN0yfdTH5FtB3Y5ujBC87qu+SvsIbIFWjlASlT2iK
 fGxsQMY6I2dvZvBTlSWq72DGgI4Z6fK7UyNlRxf8Xb/gL+Qg+PsJMphT+dNBuRF9O/sp
 pvE4XQ38mLZgP/dmJ6LxRDM7SUad/lBCxbwecxbjAslhxJmV8IRdrgDk94NccHjlbc5C
 uoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724439722; x=1725044522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CyQLd4VEiaZEDU+IbEBX2JDDfbtQtncP24IK0QpEAqA=;
 b=sWdhotDgF4MJixwI6ExJnJ3qNFSSpnyGJ60phURNGCXSjoROKGDYcHRHT/QmMvb1iY
 Xh3mrAxc4LStY+4cZ86JZ0hA2B+C9Dl9r6O77QEIBk2R7dZkN934IYkPoCJ8dp5C8Fma
 xzpnkQKv/p934CoIDAkQKyFGGq2USQD+7tefIudS0Bm6WaxxHKJspMNDcOO4Xq6oyJ6N
 zx6BWP9wETjdFVgdB7ag5MBBhg/0EZBWi6c8iLDoSLEhOIZyPQrQovDdiOJxtrtjsm/Q
 q/+dFFIY3mhk03g/QEvGoQi//t0av1YXPr4LzmPmO8gNHEyoQfdlRS1mcZke5SXzDiRm
 VbAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMFvJK9UW30advuUjhe+eUXfzNZ6zD+C2byqbBzuzzE+dv82ll7ljzFuQVT7UBCowDriRtjtT3tVRo@nongnu.org
X-Gm-Message-State: AOJu0YzsX7LIF076BbhvmhElaBHxAnthVtdzn0JIFL7CJ0C4iwxOC2zo
 XsUzQKgSXyizG/wfMqQE62/dSDRFg3AkIckV+LA612lYq9UBT3gpeCIebMkeOdQ=
X-Google-Smtp-Source: AGHT+IEjxepIxtdUodZgfcFIbDDSsi+toLtRIMvhHr9TFAS5OsBcOdTvPfL2b0ZI+uAQ32NAGm57DA==
X-Received: by 2002:a17:902:db0e:b0:1fc:5ed5:ff56 with SMTP id
 d9443c01a7336-2039e54a903mr33682615ad.61.1724439721917; 
 Fri, 23 Aug 2024 12:02:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0c37768sm1749885ad.230.2024.08.23.12.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:02:01 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v8 13/17] target/riscv: update `decode_save_opc` to store
 extra word2
Date: Fri, 23 Aug 2024 12:01:35 -0700
Message-ID: <20240823190140.4156920-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240823190140.4156920-1-debug@rivosinc.com>
References: <20240823190140.4156920-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Extra word 2 is stored during tcg compile and `decode_save_opc` needs
additional argument in order to pass the value. This will be used during
unwind to get extra information about instruction like how to massage
exceptions. Updated all callsites as well.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/insn_trans/trans_privileged.c.inc |  8 ++++----
 target/riscv/insn_trans/trans_rva.c.inc        |  4 ++--
 target/riscv/insn_trans/trans_rvd.c.inc        |  4 ++--
 target/riscv/insn_trans/trans_rvf.c.inc        |  4 ++--
 target/riscv/insn_trans/trans_rvh.c.inc        |  8 ++++----
 target/riscv/insn_trans/trans_rvi.c.inc        |  6 +++---
 target/riscv/insn_trans/trans_rvvk.c.inc       | 10 +++++-----
 target/riscv/insn_trans/trans_rvzacas.c.inc    |  4 ++--
 target/riscv/insn_trans/trans_rvzfh.c.inc      |  4 ++--
 target/riscv/insn_trans/trans_svinval.c.inc    |  6 +++---
 target/riscv/translate.c                       | 11 ++++++-----
 11 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index bc5263a4e0..ecd3b8b2c9 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -78,7 +78,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
-        decode_save_opc(ctx);
+        decode_save_opc(ctx, 0);
         translator_io_start(&ctx->base);
         gen_helper_sret(cpu_pc, tcg_env);
         exit_tb(ctx); /* no chaining */
@@ -95,7 +95,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     translator_io_start(&ctx->base);
     gen_helper_mret(cpu_pc, tcg_env);
     exit_tb(ctx); /* no chaining */
@@ -109,7 +109,7 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
 #ifndef CONFIG_USER_ONLY
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_update_pc(ctx, ctx->cur_insn_len);
     gen_helper_wfi(tcg_env);
     return true;
@@ -121,7 +121,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 {
 #ifndef CONFIG_USER_ONLY
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_helper_tlb_flush(tcg_env);
     return true;
 #endif
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 39bbf60f3c..9cf3ae8019 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -34,7 +34,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
     TCGv src1;
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
     if (a->rl) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
@@ -61,7 +61,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
     tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
 
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 1f5fac65a2..d779ec75c7 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -51,7 +51,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
         memop |= MO_ATOM_WITHIN16;
     }
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], addr, ctx->mem_idx, memop);
 
@@ -71,7 +71,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
         memop |= MO_ATOM_WITHIN16;
     }
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
     return true;
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index f771aa1939..084c184e65 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -52,7 +52,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
         memop |= MO_ATOM_WITHIN16;
     }
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
     dest = cpu_fpr[a->rd];
     tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, memop);
@@ -74,7 +74,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
         memop |= MO_ATOM_WITHIN16;
     }
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], addr, ctx->mem_idx, memop);
     return true;
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index aa9d41c18c..03c6694430 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -44,7 +44,7 @@ static bool do_hlv(DisasContext *ctx, arg_r2 *a,
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv addr = get_gpr(ctx, a->rs1, EXT_NONE);
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     func(dest, tcg_env, addr);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -56,7 +56,7 @@ static bool do_hsv(DisasContext *ctx, arg_r2_s *a,
     TCGv addr = get_gpr(ctx, a->rs1, EXT_NONE);
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     func(tcg_env, addr, data);
     return true;
 }
@@ -147,7 +147,7 @@ static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
 {
     REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_helper_hyp_gvma_tlb_flush(tcg_env);
     return true;
 #endif
@@ -158,7 +158,7 @@ static bool trans_hfence_vvma(DisasContext *ctx, arg_sfence_vma *a)
 {
     REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_helper_hyp_tlb_flush(tcg_env);
     return true;
 #endif
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index b427f3a939..a619ea7c0e 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -326,7 +326,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
         memop |= MO_ATOM_WITHIN16;
     }
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
     } else {
@@ -427,7 +427,7 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
         memop |= MO_ATOM_WITHIN16;
     }
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
     } else {
@@ -889,7 +889,7 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
 static bool do_csr_post(DisasContext *ctx)
 {
     /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     /* We may have changed important cpu state -- exit to main loop. */
     gen_update_pc(ctx, ctx->cur_insn_len);
     exit_tb(ctx);
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index ae1f40174a..27bf3f0b68 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -249,7 +249,7 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
-                decode_save_opc(s);                                           \
+                decode_save_opc(s, 0);                                        \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
             }                                                                 \
@@ -322,7 +322,7 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
-                decode_save_opc(s);                                           \
+                decode_save_opc(s, 0);                                        \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
             }                                                                 \
@@ -389,7 +389,7 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                                                                               \
             if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
-                decode_save_opc(s);                                           \
+                decode_save_opc(s, 0);                                        \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
             }                                                                 \
@@ -440,7 +440,7 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
 
         if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
             /* save opcode for unwinding in case we throw an exception */
-            decode_save_opc(s);
+            decode_save_opc(s, 0);
             egs = tcg_constant_i32(ZVKNH_EGS);
             gen_helper_egs_check(egs, tcg_env);
         }
@@ -471,7 +471,7 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
 
         if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
             /* save opcode for unwinding in case we throw an exception */
-            decode_save_opc(s);
+            decode_save_opc(s, 0);
             egs = tcg_constant_i32(ZVKNH_EGS);
             gen_helper_egs_check(egs, tcg_env);
         }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index fcced99fc7..15e688a033 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
 
     gen_set_gpr_pair(ctx, a->rd, dest);
@@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
 
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
                                 (MO_ALIGN | MO_TEUO));
 
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index 1eb458b491..bece48e600 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -48,7 +48,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
         TCGv temp = tcg_temp_new();
@@ -71,7 +71,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
         TCGv temp = tcg_temp_new();
diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
index 0f692a1088..a06c3b214f 100644
--- a/target/riscv/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/insn_trans/trans_svinval.c.inc
@@ -28,7 +28,7 @@ static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
     /* Do the same as sfence.vma currently */
     REQUIRE_EXT(ctx, RVS);
 #ifndef CONFIG_USER_ONLY
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_helper_tlb_flush(tcg_env);
     return true;
 #endif
@@ -57,7 +57,7 @@ static bool trans_hinval_vvma(DisasContext *ctx, arg_hinval_vvma *a)
     /* Do the same as hfence.vvma currently */
     REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_helper_hyp_tlb_flush(tcg_env);
     return true;
 #endif
@@ -70,7 +70,7 @@ static bool trans_hinval_gvma(DisasContext *ctx, arg_hinval_gvma *a)
     /* Do the same as hfence.gvma currently */
     REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_helper_hyp_gvma_tlb_flush(tcg_env);
     return true;
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 16fff70dac..e677062a10 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -209,11 +209,12 @@ static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
     tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
 }
 
-static void decode_save_opc(DisasContext *ctx)
+static void decode_save_opc(DisasContext *ctx, target_ulong excp_uw2)
 {
     assert(!ctx->insn_start_updated);
     ctx->insn_start_updated = true;
     tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
+    tcg_set_insn_start_param(ctx->base.insn_start, 2, excp_uw2);
 }
 
 static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
@@ -699,7 +700,7 @@ static void gen_set_rm(DisasContext *ctx, int rm)
     }
 
     /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_helper_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
 }
 
@@ -712,7 +713,7 @@ static void gen_set_rm_chkfrm(DisasContext *ctx, int rm)
     ctx->frm_valid = true;
 
     /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, 0);
     gen_helper_set_rounding_mode_chkfrm(tcg_env, tcg_constant_i32(rm));
 }
 
@@ -1096,7 +1097,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
         mop |= MO_ALIGN;
     }
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
     func(dest, src1, src2, ctx->mem_idx, mop);
 
@@ -1110,7 +1111,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
 
-    decode_save_opc(ctx);
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
 
     gen_set_gpr(ctx, a->rd, dest);
-- 
2.44.0


