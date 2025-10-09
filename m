Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2A2CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sO7-0001EY-8e; Thu, 09 Oct 2025 11:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sO3-0001DI-EV
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:17:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNv-00015i-MZ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so6723305e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760023009; x=1760627809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQJ+OrHYqVgBYhVx+LrRn1tYdILCbq/u6DwNuowQaY4=;
 b=wCUgChXyw4Tnb+rCSgymvYBy3YKhp4PFatBUGGKwRsUQEIS2bJjqocl2/XCXNl9m5J
 /WnBml8cMV/WmKwuruE/KQs72AJbMMZt5Obq0XF9uED8rzZQ+m+WkzblkZuRglLh9c75
 pv4Elscn5RMXRZ50TG5287DvWQV0IBCtx9r/AjfMbyPFjyKxSIvKwMVwKCGWcp3pRpWC
 qZUTXO7jTNV8vT9TFg/cBa7lGIrkVMjBe9ryt5TRcREtzBFTjb9mnRymeEZIqe5UynAw
 gd0PCPrTuy5ysvYWhe/YRcg0Oqk+rHXZbjNhPcvOcEWxJZg0Z3bppqpVY7JopIS/RUys
 1PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760023009; x=1760627809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQJ+OrHYqVgBYhVx+LrRn1tYdILCbq/u6DwNuowQaY4=;
 b=bFzI7/KQPysIrpZ67pS9n/Qr9VqmO7B6aG/ie9CdtT0rBRfJnr1OIrxfczX0KB67tE
 9lfEbavpLNZI3TslRdQuuTfIuzHNmFjukIOuocMkT7SkZsD2e7SxvujWG5L1lAyDGnCr
 4diMAJDRrrcwUAWmHVSg6VNJXcdgO6NKntAr2YlYn2mJlywXwlD37yLRv5lE3Sxq0K8k
 paCFlPq82OTcSnL/f6liuurkKT8l2ecSAJGWVZJNiH53JGIKZ4TVQSgARq9nmW4T98aO
 6ZpmpDF7G6DrqqWVwaMK4UtRINbS66ocCGX2IWQqsb+S4IoT2JYkAPql8wJHlXV54lrb
 Z6CQ==
X-Gm-Message-State: AOJu0Yzv2+eCaT54Ikqi8OXcQ8s8zRG73sDxTaQrjdwxw1gcP1VKjE9E
 srhLWM4AlzDhViHuH2c8TNXLnVu69qI7GvnvdP9M5jeG/VnmXIfaHf3cT13+JBIF4wQucwX9bdm
 S/I+uEpvFqw==
X-Gm-Gg: ASbGncuhISMK0aq35JLRguVFDr48J+G9b7uxcFE3qpghg6JOHRd/JcaT3hD0Rx4r7Iy
 Ve3rDuRfUSP1THuFONIs/8ZnSa5BzFT6eX0mB64pSXi7R9+Se3zFcfkRKY1T4nwJnLzMoJtnSpo
 eNzlEmjJieptzFZvuJzBnYQE3mME6McZePJxaRg025WoRgrgS47/TJEFWgKbv3CISKU8VW0m1C8
 jJQ2LpAMxklfDbVTFp+G2G+dQChDF/oxiGJvzz0BJ7GQYcokyJE9Tjo9tveZPcjZir/BeulY+kJ
 hsuO11iES1Urz3yHXDbNUKISZeJKrZAzoPnyMzEAhd8dqGlt1/BjMkFUC2Y9agI10zM+/DdDMTG
 2tZiF6SA0iI5Y2276LSp78mjbmzCtYmrsdP5wF4vCWTrjWQsZDSFI7ElaXCbsJI65JRbOpnx9Cs
 cEASyn2K1mVAkbuvy3fyixca09RPCohTMxow8=
X-Google-Smtp-Source: AGHT+IHK3a4DhEuBDmxE7HCwjRodvyjqb4lSjnWSsi4anAC35T8geLXSER2YaZAzKx/7uYd23/QL4g==
X-Received: by 2002:a05:600c:3f0c:b0:45b:9912:9f30 with SMTP id
 5b1f17b1804b1-46fa9a86314mr57645175e9.6.1760023008726; 
 Thu, 09 Oct 2025 08:16:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb484d056sm2213605e9.9.2025.10.09.08.16.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] target/rx: Expand TCG register definitions for 32-bit
 target
Date: Thu,  9 Oct 2025 17:16:07 +0200
Message-ID: <20251009151607.26278-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The RX target is only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/rx-*
  configs/targets/rx-softmmu.mak:5:TARGET_LONG_BITS=32

Therefore target_ulong always expands to uint32_t.\
Replace and adapt the API uses mechanically:

  TCGv -> TCGv_i32
  tcg_temp_new -> tcg_temp_new_i32

There is no functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 322 +++++++++++++++++++++---------------------
 1 file changed, 161 insertions(+), 161 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index c83e7afc60f..ada2d99f7c3 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -40,8 +40,8 @@ typedef struct DisasContext {
 } DisasContext;
 
 typedef struct DisasCompare {
-    TCGv value;
-    TCGv temp;
+    TCGv_i32 value;
+    TCGv_i32 temp;
     TCGCond cond;
 } DisasCompare;
 
@@ -63,11 +63,11 @@ const char *rx_crname(uint8_t cr)
 #define DISAS_EXIT    DISAS_TARGET_2
 
 /* global register indexes */
-static TCGv cpu_regs[16];
-static TCGv cpu_psw_o, cpu_psw_s, cpu_psw_z, cpu_psw_c;
-static TCGv cpu_psw_i, cpu_psw_pm, cpu_psw_u, cpu_psw_ipl;
-static TCGv cpu_usp, cpu_fpsw, cpu_bpsw, cpu_bpc, cpu_isp;
-static TCGv cpu_fintv, cpu_intb, cpu_pc;
+static TCGv_i32 cpu_regs[16];
+static TCGv_i32 cpu_psw_o, cpu_psw_s, cpu_psw_z, cpu_psw_c;
+static TCGv_i32 cpu_psw_i, cpu_psw_pm, cpu_psw_u, cpu_psw_ipl;
+static TCGv_i32 cpu_usp, cpu_fpsw, cpu_bpsw, cpu_bpc, cpu_isp;
+static TCGv_i32 cpu_fintv, cpu_intb, cpu_pc;
 static TCGv_i64 cpu_acc;
 
 #define cpu_sp cpu_regs[0]
@@ -166,25 +166,25 @@ static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
 }
 
 /* generic load wrapper */
-static inline void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
+static inline void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | mo_endian(ctx));
 }
 
 /* unsigned load wrapper */
-static inline void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
+static inline void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* generic store wrapper */
-static inline void rx_gen_st(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
+static inline void rx_gen_st(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
 {
     tcg_gen_qemu_st_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* [ri, rb] */
-static inline void rx_gen_regindex(DisasContext *ctx, TCGv mem,
+static inline void rx_gen_regindex(DisasContext *ctx, TCGv_i32 mem,
                                    int size, int ri, int rb)
 {
     tcg_gen_shli_i32(mem, cpu_regs[ri], size);
@@ -192,7 +192,7 @@ static inline void rx_gen_regindex(DisasContext *ctx, TCGv mem,
 }
 
 /* dsp[reg] */
-static inline TCGv rx_index_addr(DisasContext *ctx, TCGv mem,
+static inline TCGv_i32 rx_index_addr(DisasContext *ctx, TCGv_i32 mem,
                                  int ld, int size, int reg)
 {
     uint32_t dsp;
@@ -223,10 +223,10 @@ static inline MemOp mi_to_mop(unsigned mi)
 }
 
 /* load source operand */
-static inline TCGv rx_load_source(DisasContext *ctx, TCGv mem,
+static inline TCGv_i32 rx_load_source(DisasContext *ctx, TCGv_i32 mem,
                                   int ld, int mi, int rs)
 {
-    TCGv addr;
+    TCGv_i32 addr;
     MemOp mop;
     if (ld < 3) {
         mop = mi_to_mop(mi);
@@ -320,7 +320,7 @@ static void psw_cond(DisasCompare *dc, uint32_t cond)
     }
 }
 
-static void move_from_cr(DisasContext *ctx, TCGv ret, int cr, uint32_t pc)
+static void move_from_cr(DisasContext *ctx, TCGv_i32 ret, int cr, uint32_t pc)
 {
     switch (cr) {
     case 0:     /* PSW */
@@ -366,7 +366,7 @@ static void move_from_cr(DisasContext *ctx, TCGv ret, int cr, uint32_t pc)
     }
 }
 
-static void move_to_cr(DisasContext *ctx, TCGv val, int cr)
+static void move_to_cr(DisasContext *ctx, TCGv_i32 val, int cr)
 {
     if (cr >= 8 && !is_privileged(ctx, 0)) {
         /* Some control registers can only be written in privileged mode. */
@@ -419,13 +419,13 @@ static void move_to_cr(DisasContext *ctx, TCGv val, int cr)
     }
 }
 
-static void push(DisasContext *ctx, TCGv val)
+static void push(DisasContext *ctx, TCGv_i32 val)
 {
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
     rx_gen_st(ctx, MO_32, val, cpu_sp);
 }
 
-static void pop(DisasContext *ctx, TCGv ret)
+static void pop(DisasContext *ctx, TCGv_i32 ret)
 {
     rx_gen_ld(ctx, MO_32, ret, cpu_sp);
     tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
@@ -434,8 +434,8 @@ static void pop(DisasContext *ctx, TCGv ret)
 /* mov.<bwl> rs,dsp5[rd] */
 static bool trans_MOV_rm(DisasContext *ctx, arg_MOV_rm *a)
 {
-    TCGv mem;
-    mem = tcg_temp_new();
+    TCGv_i32 mem;
+    mem = tcg_temp_new_i32();
     tcg_gen_addi_i32(mem, cpu_regs[a->rd], a->dsp << a->sz);
     rx_gen_st(ctx, a->sz, cpu_regs[a->rs], mem);
     return true;
@@ -444,8 +444,8 @@ static bool trans_MOV_rm(DisasContext *ctx, arg_MOV_rm *a)
 /* mov.<bwl> dsp5[rs],rd */
 static bool trans_MOV_mr(DisasContext *ctx, arg_MOV_mr *a)
 {
-    TCGv mem;
-    mem = tcg_temp_new();
+    TCGv_i32 mem;
+    mem = tcg_temp_new_i32();
     tcg_gen_addi_i32(mem, cpu_regs[a->rs], a->dsp << a->sz);
     rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], mem);
     return true;
@@ -464,9 +464,9 @@ static bool trans_MOV_ir(DisasContext *ctx, arg_MOV_ir *a)
 /* mov.<bwl> #imm, dsp[rd] */
 static bool trans_MOV_im(DisasContext *ctx, arg_MOV_im *a)
 {
-    TCGv imm, mem;
+    TCGv_i32 imm, mem;
     imm = tcg_constant_i32(a->imm);
-    mem = tcg_temp_new();
+    mem = tcg_temp_new_i32();
     tcg_gen_addi_i32(mem, cpu_regs[a->rd], a->dsp << a->sz);
     rx_gen_st(ctx, a->sz, imm, mem);
     return true;
@@ -475,8 +475,8 @@ static bool trans_MOV_im(DisasContext *ctx, arg_MOV_im *a)
 /* mov.<bwl> [ri,rb],rd */
 static bool trans_MOV_ar(DisasContext *ctx, arg_MOV_ar *a)
 {
-    TCGv mem;
-    mem = tcg_temp_new();
+    TCGv_i32 mem;
+    mem = tcg_temp_new_i32();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
     rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], mem);
     return true;
@@ -485,8 +485,8 @@ static bool trans_MOV_ar(DisasContext *ctx, arg_MOV_ar *a)
 /* mov.<bwl> rd,[ri,rb] */
 static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 {
-    TCGv mem;
-    mem = tcg_temp_new();
+    TCGv_i32 mem;
+    mem = tcg_temp_new_i32();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
     rx_gen_st(ctx, a->sz, cpu_regs[a->rs], mem);
     return true;
@@ -498,7 +498,7 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 /* mov.<bwl> rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    TCGv tmp, mem, addr;
+    TCGv_i32 tmp, mem, addr;
 
     if (a->lds == 3 && a->ldd == 3) {
         /* mov.<bwl> rs,rd */
@@ -506,7 +506,7 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
         return true;
     }
 
-    mem = tcg_temp_new();
+    mem = tcg_temp_new_i32();
     if (a->lds == 3) {
         /* mov.<bwl> rs,dsp[rd] */
         addr = rx_index_addr(ctx, mem, a->ldd, a->sz, a->rs);
@@ -517,7 +517,7 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
         rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], addr);
     } else {
         /* mov.<bwl> dsp[rs],dsp[rd] */
-        tmp = tcg_temp_new();
+        tmp = tcg_temp_new_i32();
         addr = rx_index_addr(ctx, mem, a->lds, a->sz, a->rs);
         rx_gen_ld(ctx, a->sz, tmp, addr);
         addr = rx_index_addr(ctx, mem, a->ldd, a->sz, a->rd);
@@ -530,8 +530,8 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 /* mov.<bwl> rs,[-rd] */
 static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     tcg_gen_mov_i32(val, cpu_regs[a->rs]);
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
@@ -547,8 +547,8 @@ static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 /* mov.<bwl> [-rd],rs */
 static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
@@ -564,8 +564,8 @@ static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
 /* movu.<bw> dsp[rs],rd */
 static bool trans_MOVU_mr(DisasContext *ctx, arg_MOVU_mr *a)
 {
-    TCGv mem;
-    mem = tcg_temp_new();
+    TCGv_i32 mem;
+    mem = tcg_temp_new_i32();
     tcg_gen_addi_i32(mem, cpu_regs[a->rs], a->dsp << a->sz);
     rx_gen_ldu(ctx, a->sz, cpu_regs[a->rd], mem);
     return true;
@@ -581,8 +581,8 @@ static bool trans_MOVU_rr(DisasContext *ctx, arg_MOVU_rr *a)
 /* movu.<bw> [ri,rb],rd */
 static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
 {
-    TCGv mem;
-    mem = tcg_temp_new();
+    TCGv_i32 mem;
+    mem = tcg_temp_new_i32();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
     rx_gen_ldu(ctx, a->sz, cpu_regs[a->rd], mem);
     return true;
@@ -592,8 +592,8 @@ static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
 /* mov.<bw> [-rd],rs */
 static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
@@ -622,8 +622,8 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 /* popc cr */
 static bool trans_POPC(DisasContext *ctx, arg_POPC *a)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     pop(ctx, val);
     move_to_cr(ctx, val, a->cr);
     return true;
@@ -648,8 +648,8 @@ static bool trans_POPM(DisasContext *ctx, arg_POPM *a)
 /* push.<bwl> rs */
 static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     tcg_gen_mov_i32(val, cpu_regs[a->rs]);
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
     rx_gen_st(ctx, a->sz, val, cpu_sp);
@@ -659,9 +659,9 @@ static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
 /* push.<bwl> dsp[rs] */
 static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
 {
-    TCGv mem, val, addr;
-    mem = tcg_temp_new();
-    val = tcg_temp_new();
+    TCGv_i32 mem, val, addr;
+    mem = tcg_temp_new_i32();
+    val = tcg_temp_new_i32();
     addr = rx_index_addr(ctx, mem, a->ld, a->sz, a->rs);
     rx_gen_ld(ctx, a->sz, val, addr);
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
@@ -672,8 +672,8 @@ static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
 /* pushc rx */
 static bool trans_PUSHC(DisasContext *ctx, arg_PUSHC *a)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     move_from_cr(ctx, val, a->cr, ctx->pc);
     push(ctx, val);
     return true;
@@ -698,8 +698,8 @@ static bool trans_PUSHM(DisasContext *ctx, arg_PUSHM *a)
 /* xchg rs,rd */
 static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
 {
-    TCGv tmp;
-    tmp = tcg_temp_new();
+    TCGv_i32 tmp;
+    tmp = tcg_temp_new_i32();
     tcg_gen_mov_i32(tmp, cpu_regs[a->rs]);
     tcg_gen_mov_i32(cpu_regs[a->rs], cpu_regs[a->rd]);
     tcg_gen_mov_i32(cpu_regs[a->rd], tmp);
@@ -709,8 +709,8 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
 /* xchg dsp[rs].<mi>,rd */
 static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 {
-    TCGv mem, addr;
-    mem = tcg_temp_new();
+    TCGv_i32 mem, addr;
+    mem = tcg_temp_new_i32();
     switch (a->mi) {
     case 0: /* dsp[rs].b */
     case 1: /* dsp[rs].w */
@@ -731,8 +731,8 @@ static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 
 static inline void stcond(TCGCond cond, int rd, int imm)
 {
-    TCGv z;
-    TCGv _imm;
+    TCGv_i32 z;
+    TCGv_i32 _imm;
     z = tcg_constant_i32(0);
     _imm = tcg_constant_i32(imm);
     tcg_gen_movcond_i32(cond, cpu_regs[rd], cpu_psw_z, z,
@@ -758,12 +758,12 @@ static bool trans_STNZ(DisasContext *ctx, arg_STNZ *a)
 static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 {
     DisasCompare dc;
-    TCGv val, mem, addr;
-    dc.temp = tcg_temp_new();
+    TCGv_i32 val, mem, addr;
+    dc.temp = tcg_temp_new_i32();
     psw_cond(&dc, a->cd);
     if (a->ld < 3) {
-        val = tcg_temp_new();
-        mem = tcg_temp_new();
+        val = tcg_temp_new_i32();
+        mem = tcg_temp_new_i32();
         tcg_gen_setcondi_i32(dc.cond, val, dc.value, 0);
         addr = rx_index_addr(ctx, mem, a->sz, a->ld, a->rd);
         rx_gen_st(ctx, a->sz, val, addr);
@@ -804,8 +804,8 @@ static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
     return true;
 }
 
-typedef void (*op2fn)(TCGv ret, TCGv arg1);
-typedef void (*op3fn)(TCGv ret, TCGv arg1, TCGv arg2);
+typedef void (*op2fn)(TCGv_i32 ret, TCGv_i32 arg1);
+typedef void (*op3fn)(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 
 static inline void rx_gen_op_rr(op2fn opr, int dst, int src)
 {
@@ -819,20 +819,20 @@ static inline void rx_gen_op_rrr(op3fn opr, int dst, int src, int src2)
 
 static inline void rx_gen_op_irr(op3fn opr, int dst, int src, uint32_t src2)
 {
-    TCGv imm = tcg_constant_i32(src2);
+    TCGv_i32 imm = tcg_constant_i32(src2);
     opr(cpu_regs[dst], cpu_regs[src], imm);
 }
 
 static inline void rx_gen_op_mr(op3fn opr, DisasContext *ctx,
                                 int dst, int src, int ld, int mi)
 {
-    TCGv val, mem;
-    mem = tcg_temp_new();
+    TCGv_i32 val, mem;
+    mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, ld, mi, src);
     opr(cpu_regs[dst], cpu_regs[dst], val);
 }
 
-static void rx_and(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_and(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_and_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
@@ -862,7 +862,7 @@ static bool trans_AND_rrr(DisasContext *ctx, arg_AND_rrr *a)
     return true;
 }
 
-static void rx_or(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_or(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_or_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
@@ -892,7 +892,7 @@ static bool trans_OR_rrr(DisasContext *ctx, arg_OR_rrr *a)
     return true;
 }
 
-static void rx_xor(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_xor(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_xor_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
@@ -914,7 +914,7 @@ static bool trans_XOR_mr(DisasContext *ctx, arg_XOR_mr *a)
     return true;
 }
 
-static void rx_tst(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_tst(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_and_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
@@ -935,7 +935,7 @@ static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
     return true;
 }
 
-static void rx_not(TCGv ret, TCGv arg1)
+static void rx_not(TCGv_i32 ret, TCGv_i32 arg1)
 {
     tcg_gen_not_i32(ret, arg1);
     tcg_gen_mov_i32(cpu_psw_z, ret);
@@ -950,7 +950,7 @@ static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
     return true;
 }
 
-static void rx_neg(TCGv ret, TCGv arg1)
+static void rx_neg(TCGv_i32 ret, TCGv_i32 arg1)
 {
     tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_o, arg1, 0x80000000);
     tcg_gen_neg_i32(ret, arg1);
@@ -969,9 +969,9 @@ static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
 }
 
 /* ret = arg1 + arg2 + psw_c */
-static void rx_adc(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_adc(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    TCGv z = tcg_constant_i32(0);
+    TCGv_i32 z = tcg_constant_i32(0);
     tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, arg1, z, cpu_psw_c, z);
     tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, cpu_psw_s, cpu_psw_c, arg2, z);
     tcg_gen_xor_i32(cpu_psw_o, cpu_psw_s, arg1);
@@ -1007,9 +1007,9 @@ static bool trans_ADC_mr(DisasContext *ctx, arg_ADC_mr *a)
 }
 
 /* ret = arg1 + arg2 */
-static void rx_add(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_add(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    TCGv z = tcg_constant_i32(0);
+    TCGv_i32 z = tcg_constant_i32(0);
     tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, arg1, z, arg2, z);
     tcg_gen_xor_i32(cpu_psw_o, cpu_psw_s, arg1);
     tcg_gen_xor_i32(cpu_psw_z, arg1, arg2);
@@ -1042,7 +1042,7 @@ static bool trans_ADD_rrr(DisasContext *ctx, arg_ADD_rrr *a)
 }
 
 /* ret = arg1 - arg2 */
-static void rx_sub(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_sub(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_sub_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_setcond_i32(TCG_COND_GEU, cpu_psw_c, arg1, arg2);
@@ -1056,17 +1056,17 @@ static void rx_sub(TCGv ret, TCGv arg1, TCGv arg2)
     }
 }
 
-static void rx_cmp(TCGv dummy, TCGv arg1, TCGv arg2)
+static void rx_cmp(TCGv_i32 dummy, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     rx_sub(NULL, arg1, arg2);
 }
 
 /* ret = arg1 - arg2 - !psw_c */
 /* -> ret = arg1 + ~arg2 + psw_c */
-static void rx_sbb(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_sbb(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    TCGv temp;
-    temp = tcg_temp_new();
+    TCGv_i32 temp;
+    temp = tcg_temp_new_i32();
     tcg_gen_not_i32(temp, arg2);
     rx_adc(ret, arg1, temp);
 }
@@ -1192,7 +1192,7 @@ static bool trans_MUL_rrr(DisasContext *ctx, arg_MUL_rrr *a)
 /* emul #imm, rd */
 static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
 {
-    TCGv imm = tcg_constant_i32(a->imm);
+    TCGv_i32 imm = tcg_constant_i32(a->imm);
     if (a->rd > 14) {
         qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
     }
@@ -1205,11 +1205,11 @@ static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
 /* emul dsp[rs], rd */
 static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
 {
-    TCGv val, mem;
+    TCGv_i32 val, mem;
     if (a->rd > 14) {
         qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
     }
-    mem = tcg_temp_new();
+    mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
     tcg_gen_muls2_i32(cpu_regs[a->rd], cpu_regs[(a->rd + 1) & 15],
                       cpu_regs[a->rd], val);
@@ -1219,7 +1219,7 @@ static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
 /* emulu #imm, rd */
 static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
 {
-    TCGv imm = tcg_constant_i32(a->imm);
+    TCGv_i32 imm = tcg_constant_i32(a->imm);
     if (a->rd > 14) {
         qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
     }
@@ -1232,23 +1232,23 @@ static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
 /* emulu dsp[rs], rd */
 static bool trans_EMULU_mr(DisasContext *ctx, arg_EMULU_mr *a)
 {
-    TCGv val, mem;
+    TCGv_i32 val, mem;
     if (a->rd > 14) {
         qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
     }
-    mem = tcg_temp_new();
+    mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
     tcg_gen_mulu2_i32(cpu_regs[a->rd], cpu_regs[(a->rd + 1) & 15],
                       cpu_regs[a->rd], val);
     return true;
 }
 
-static void rx_div(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_div(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     gen_helper_div(ret, tcg_env, arg1, arg2);
 }
 
-static void rx_divu(TCGv ret, TCGv arg1, TCGv arg2)
+static void rx_divu(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     gen_helper_divu(ret, tcg_env, arg1, arg2);
 }
@@ -1288,8 +1288,8 @@ static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
 /* shll #imm:5, rs2, rd */
 static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
 {
-    TCGv tmp;
-    tmp = tcg_temp_new();
+    TCGv_i32 tmp;
+    tmp = tcg_temp_new_i32();
     if (a->imm) {
         tcg_gen_sari_i32(cpu_psw_c, cpu_regs[a->rs2], 32 - a->imm);
         tcg_gen_shli_i32(cpu_regs[a->rd], cpu_regs[a->rs2], a->imm);
@@ -1311,14 +1311,14 @@ static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
 static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
 {
     TCGLabel *noshift, *done;
-    TCGv count, tmp;
+    TCGv_i32 count, tmp;
 
     noshift = gen_new_label();
     done = gen_new_label();
     /* if (cpu_regs[a->rs]) { */
     tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_regs[a->rs], 0, noshift);
-    count = tcg_temp_new();
-    tmp = tcg_temp_new();
+    count = tcg_temp_new_i32();
+    tmp = tcg_temp_new_i32();
     tcg_gen_andi_i32(tmp, cpu_regs[a->rs], 31);
     tcg_gen_sub_i32(count, tcg_constant_i32(32), tmp);
     tcg_gen_sar_i32(cpu_psw_c, cpu_regs[a->rd], count);
@@ -1342,7 +1342,7 @@ static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
 static inline void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
                               unsigned int alith)
 {
-    static void (* const gen_sXri[])(TCGv ret, TCGv arg1, int arg2) = {
+    static void (* const gen_sXri[])(TCGv_i32 ret, TCGv_i32 arg1, int arg2) = {
         tcg_gen_shri_i32, tcg_gen_sari_i32,
     };
     tcg_debug_assert(alith < 2);
@@ -1362,17 +1362,17 @@ static inline void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
 static inline void shiftr_reg(uint32_t rd, uint32_t rs, unsigned int alith)
 {
     TCGLabel *noshift, *done;
-    TCGv count;
-    static void (* const gen_sXri[])(TCGv ret, TCGv arg1, int arg2) = {
+    TCGv_i32 count;
+    static void (* const gen_sXri[])(TCGv_i32 ret, TCGv_i32 arg1, int arg2) = {
         tcg_gen_shri_i32, tcg_gen_sari_i32,
     };
-    static void (* const gen_sXr[])(TCGv ret, TCGv arg1, TCGv arg2) = {
+    static void (* const gen_sXr[])(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2) = {
         tcg_gen_shr_i32, tcg_gen_sar_i32,
     };
     tcg_debug_assert(alith < 2);
     noshift = gen_new_label();
     done = gen_new_label();
-    count = tcg_temp_new();
+    count = tcg_temp_new_i32();
     /* if (cpu_regs[rs]) { */
     tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_regs[rs], 0, noshift);
     tcg_gen_andi_i32(count, cpu_regs[rs], 31);
@@ -1424,8 +1424,8 @@ static bool trans_SHLR_rr(DisasContext *ctx, arg_SHLR_rr *a)
 /* rolc rd */
 static bool trans_ROLC(DisasContext *ctx, arg_ROLC *a)
 {
-    TCGv tmp;
-    tmp = tcg_temp_new();
+    TCGv_i32 tmp;
+    tmp = tcg_temp_new_i32();
     tcg_gen_shri_i32(tmp, cpu_regs[a->rd], 31);
     tcg_gen_shli_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1);
     tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_psw_c);
@@ -1438,8 +1438,8 @@ static bool trans_ROLC(DisasContext *ctx, arg_ROLC *a)
 /* rorc rd */
 static bool trans_RORC(DisasContext *ctx, arg_RORC *a)
 {
-    TCGv tmp;
-    tmp = tcg_temp_new();
+    TCGv_i32 tmp;
+    tmp = tcg_temp_new_i32();
     tcg_gen_andi_i32(tmp, cpu_regs[a->rd], 0x00000001);
     tcg_gen_shri_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1);
     tcg_gen_shli_i32(cpu_psw_c, cpu_psw_c, 31);
@@ -1514,8 +1514,8 @@ static bool trans_REVL(DisasContext *ctx, arg_REVL *a)
 /* revw rs, rd */
 static bool trans_REVW(DisasContext *ctx, arg_REVW *a)
 {
-    TCGv tmp;
-    tmp = tcg_temp_new();
+    TCGv_i32 tmp;
+    tmp = tcg_temp_new_i32();
     tcg_gen_andi_i32(tmp, cpu_regs[a->rs], 0x00ff00ff);
     tcg_gen_shli_i32(tmp, tmp, 8);
     tcg_gen_shri_i32(cpu_regs[a->rd], cpu_regs[a->rs], 8);
@@ -1532,7 +1532,7 @@ static void rx_bcnd_main(DisasContext *ctx, int cd, int dst)
 
     switch (cd) {
     case 0 ... 13:
-        dc.temp = tcg_temp_new();
+        dc.temp = tcg_temp_new_i32();
         psw_cond(&dc, cd);
         t = gen_new_label();
         done = gen_new_label();
@@ -1589,7 +1589,7 @@ static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
 
 static inline void rx_save_pc(DisasContext *ctx)
 {
-    TCGv pc = tcg_constant_i32(ctx->base.pc_next);
+    TCGv_i32 pc = tcg_constant_i32(ctx->base.pc_next);
     push(ctx, pc);
 }
 
@@ -1672,7 +1672,7 @@ static bool trans_SMOVB(DisasContext *ctx, arg_SMOVB *a)
 
 #define STRING(op)                              \
     do {                                        \
-        TCGv size = tcg_constant_i32(a->sz);    \
+        TCGv_i32 size = tcg_constant_i32(a->sz);    \
         gen_helper_##op(tcg_env, size);         \
     } while (0)
 
@@ -1803,7 +1803,7 @@ static bool trans_MVTACLO(DisasContext *ctx, arg_MVTACLO *a)
 /* racw #imm */
 static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
 {
-    TCGv imm = tcg_constant_i32(a->imm + 1);
+    TCGv_i32 imm = tcg_constant_i32(a->imm + 1);
     gen_helper_racw(tcg_env, imm);
     return true;
 }
@@ -1811,8 +1811,8 @@ static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
 /* sat rd */
 static bool trans_SAT(DisasContext *ctx, arg_SAT *a)
 {
-    TCGv tmp, z;
-    tmp = tcg_temp_new();
+    TCGv_i32 tmp, z;
+    tmp = tcg_temp_new_i32();
     z = tcg_constant_i32(0);
     /* S == 1 -> 0xffffffff / S == 0 -> 0x00000000 */
     tcg_gen_sari_i32(tmp, cpu_psw_s, 31);
@@ -1835,7 +1835,7 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
     static bool cat3(trans_, name, _ir)(DisasContext *ctx,              \
                                         cat3(arg_, name, _ir) * a)      \
     {                                                                   \
-        TCGv imm = tcg_constant_i32(li(ctx, 0));                        \
+        TCGv_i32 imm = tcg_constant_i32(li(ctx, 0));                        \
         gen_helper_##op(cpu_regs[a->rd], tcg_env,                       \
                         cpu_regs[a->rd], imm);                          \
         return true;                                                    \
@@ -1843,8 +1843,8 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
     static bool cat3(trans_, name, _mr)(DisasContext *ctx,              \
                                         cat3(arg_, name, _mr) * a)      \
     {                                                                   \
-        TCGv val, mem;                                                  \
-        mem = tcg_temp_new();                                           \
+        TCGv_i32 val, mem;                                                  \
+        mem = tcg_temp_new_i32();                                           \
         val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);            \
         gen_helper_##op(cpu_regs[a->rd], tcg_env,                       \
                         cpu_regs[a->rd], val);                          \
@@ -1854,8 +1854,8 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
 #define FCONVOP(name, op)                                       \
     static bool trans_##name(DisasContext *ctx, arg_##name * a) \
     {                                                           \
-        TCGv val, mem;                                          \
-        mem = tcg_temp_new();                                   \
+        TCGv_i32 val, mem;                                          \
+        mem = tcg_temp_new_i32();                                   \
         val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);    \
         gen_helper_##op(cpu_regs[a->rd], tcg_env, val);         \
         return true;                                            \
@@ -1869,7 +1869,7 @@ FOP(FDIV, fdiv)
 /* fcmp #imm, rd */
 static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
 {
-    TCGv imm = tcg_constant_i32(li(ctx, 0));
+    TCGv_i32 imm = tcg_constant_i32(li(ctx, 0));
     gen_helper_fcmp(tcg_env, cpu_regs[a->rd], imm);
     return true;
 }
@@ -1878,8 +1878,8 @@ static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
 /* fcmp rs, rd */
 static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
 {
-    TCGv val, mem;
-    mem = tcg_temp_new();
+    TCGv_i32 val, mem;
+    mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);
     gen_helper_fcmp(tcg_env, cpu_regs[a->rd], val);
     return true;
@@ -1892,70 +1892,70 @@ FCONVOP(ROUND, round)
 /* itof dsp[rs], rd */
 static bool trans_ITOF(DisasContext *ctx, arg_ITOF * a)
 {
-    TCGv val, mem;
-    mem = tcg_temp_new();
+    TCGv_i32 val, mem;
+    mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
     gen_helper_itof(cpu_regs[a->rd], tcg_env, val);
     return true;
 }
 
-static void rx_bsetm(DisasContext *ctx, TCGv mem, TCGv mask)
+static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     rx_gen_ld(ctx, MO_8, val, mem);
     tcg_gen_or_i32(val, val, mask);
     rx_gen_st(ctx, MO_8, val, mem);
 }
 
-static void rx_bclrm(DisasContext *ctx, TCGv mem, TCGv mask)
+static void rx_bclrm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     rx_gen_ld(ctx, MO_8, val, mem);
     tcg_gen_andc_i32(val, val, mask);
     rx_gen_st(ctx, MO_8, val, mem);
 }
 
-static void rx_btstm(DisasContext *ctx, TCGv mem, TCGv mask)
+static void rx_btstm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     rx_gen_ld(ctx, MO_8, val, mem);
     tcg_gen_and_i32(val, val, mask);
     tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, val, 0);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static void rx_bnotm(DisasContext *ctx, TCGv mem, TCGv mask)
+static void rx_bnotm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
-    TCGv val;
-    val = tcg_temp_new();
+    TCGv_i32 val;
+    val = tcg_temp_new_i32();
     rx_gen_ld(ctx, MO_8, val, mem);
     tcg_gen_xor_i32(val, val, mask);
     rx_gen_st(ctx, MO_8, val, mem);
 }
 
-static void rx_bsetr(DisasContext *ctx, TCGv reg, TCGv mask)
+static void rx_bsetr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
 {
     tcg_gen_or_i32(reg, reg, mask);
 }
 
-static void rx_bclrr(DisasContext *ctx, TCGv reg, TCGv mask)
+static void rx_bclrr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
 {
     tcg_gen_andc_i32(reg, reg, mask);
 }
 
-static inline void rx_btstr(DisasContext *ctx, TCGv reg, TCGv mask)
+static inline void rx_btstr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
 {
-    TCGv t0;
-    t0 = tcg_temp_new();
+    TCGv_i32 t0;
+    t0 = tcg_temp_new_i32();
     tcg_gen_and_i32(t0, reg, mask);
     tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, t0, 0);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static inline void rx_bnotr(DisasContext *ctx, TCGv reg, TCGv mask)
+static inline void rx_bnotr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
 {
     tcg_gen_xor_i32(reg, reg, mask);
 }
@@ -1964,8 +1964,8 @@ static inline void rx_bnotr(DisasContext *ctx, TCGv reg, TCGv mask)
     static bool cat3(trans_, name, _im)(DisasContext *ctx,              \
                                         cat3(arg_, name, _im) * a)      \
     {                                                                   \
-        TCGv mask, mem, addr;                                           \
-        mem = tcg_temp_new();                                           \
+        TCGv_i32 mask, mem, addr;                                           \
+        mem = tcg_temp_new_i32();                                           \
         mask = tcg_constant_i32(1 << a->imm);                           \
         addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
         cat3(rx_, op, m)(ctx, addr, mask);                              \
@@ -1974,7 +1974,7 @@ static inline void rx_bnotr(DisasContext *ctx, TCGv reg, TCGv mask)
     static bool cat3(trans_, name, _ir)(DisasContext *ctx,              \
                                         cat3(arg_, name, _ir) * a)      \
     {                                                                   \
-        TCGv mask;                                                      \
+        TCGv_i32 mask;                                                      \
         mask = tcg_constant_i32(1 << a->imm);                           \
         cat3(rx_, op, r)(ctx, cpu_regs[a->rd], mask);                   \
         return true;                                                    \
@@ -1982,9 +1982,9 @@ static inline void rx_bnotr(DisasContext *ctx, TCGv reg, TCGv mask)
     static bool cat3(trans_, name, _rr)(DisasContext *ctx,              \
                                         cat3(arg_, name, _rr) * a)      \
     {                                                                   \
-        TCGv mask, b;                                                   \
-        mask = tcg_temp_new();                                          \
-        b = tcg_temp_new();                                             \
+        TCGv_i32 mask, b;                                                   \
+        mask = tcg_temp_new_i32();                                          \
+        b = tcg_temp_new_i32();                                             \
         tcg_gen_andi_i32(b, cpu_regs[a->rs], 31);                       \
         tcg_gen_shl_i32(mask, tcg_constant_i32(1), b);                  \
         cat3(rx_, op, r)(ctx, cpu_regs[a->rd], mask);                   \
@@ -1993,12 +1993,12 @@ static inline void rx_bnotr(DisasContext *ctx, TCGv reg, TCGv mask)
     static bool cat3(trans_, name, _rm)(DisasContext *ctx,              \
                                         cat3(arg_, name, _rm) * a)      \
     {                                                                   \
-        TCGv mask, mem, addr, b;                                        \
-        mask = tcg_temp_new();                                          \
-        b = tcg_temp_new();                                             \
+        TCGv_i32 mask, mem, addr, b;                                        \
+        mask = tcg_temp_new_i32();                                          \
+        b = tcg_temp_new_i32();                                             \
         tcg_gen_andi_i32(b, cpu_regs[a->rd], 7);                        \
         tcg_gen_shl_i32(mask, tcg_constant_i32(1), b);                  \
-        mem = tcg_temp_new();                                           \
+        mem = tcg_temp_new_i32();                                           \
         addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
         cat3(rx_, op, m)(ctx, addr, mask);                              \
         return true;                                                    \
@@ -2009,12 +2009,12 @@ BITOP(BCLR, bclr)
 BITOP(BTST, btst)
 BITOP(BNOT, bnot)
 
-static inline void bmcnd_op(TCGv val, TCGCond cond, int pos)
+static inline void bmcnd_op(TCGv_i32 val, TCGCond cond, int pos)
 {
-    TCGv bit;
+    TCGv_i32 bit;
     DisasCompare dc;
-    dc.temp = tcg_temp_new();
-    bit = tcg_temp_new();
+    dc.temp = tcg_temp_new_i32();
+    bit = tcg_temp_new_i32();
     psw_cond(&dc, cond);
     tcg_gen_andi_i32(val, val, ~(1 << pos));
     tcg_gen_setcondi_i32(dc.cond, bit, dc.value, 0);
@@ -2024,9 +2024,9 @@ static inline void bmcnd_op(TCGv val, TCGCond cond, int pos)
 /* bmcnd #imm, dsp[rd] */
 static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
 {
-    TCGv val, mem, addr;
-    val = tcg_temp_new();
-    mem = tcg_temp_new();
+    TCGv_i32 val, mem, addr;
+    val = tcg_temp_new_i32();
+    mem = tcg_temp_new_i32();
     addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rd);
     rx_gen_ld(ctx, MO_8, val, addr);
     bmcnd_op(val, a->cd, a->imm);
@@ -2118,7 +2118,7 @@ static bool trans_MVTIPL(DisasContext *ctx, arg_MVTIPL *a)
 /* mvtc #imm, rd */
 static bool trans_MVTC_i(DisasContext *ctx, arg_MVTC_i *a)
 {
-    TCGv imm;
+    TCGv_i32 imm;
 
     imm = tcg_constant_i32(a->imm);
     move_to_cr(ctx, imm, a->cr);
@@ -2142,9 +2142,9 @@ static bool trans_MVFC(DisasContext *ctx, arg_MVFC *a)
 /* rtfi */
 static bool trans_RTFI(DisasContext *ctx, arg_RTFI *a)
 {
-    TCGv psw;
+    TCGv_i32 psw;
     if (is_privileged(ctx, 1)) {
-        psw = tcg_temp_new();
+        psw = tcg_temp_new_i32();
         tcg_gen_mov_i32(cpu_pc, cpu_bpc);
         tcg_gen_mov_i32(psw, cpu_bpsw);
         gen_helper_set_psw_rte(tcg_env, psw);
@@ -2156,9 +2156,9 @@ static bool trans_RTFI(DisasContext *ctx, arg_RTFI *a)
 /* rte */
 static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
 {
-    TCGv psw;
+    TCGv_i32 psw;
     if (is_privileged(ctx, 1)) {
-        psw = tcg_temp_new();
+        psw = tcg_temp_new_i32();
         pop(ctx, cpu_pc);
         pop(ctx, psw);
         gen_helper_set_psw_rte(tcg_env, psw);
@@ -2179,7 +2179,7 @@ static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
 /* int #imm */
 static bool trans_INT(DisasContext *ctx, arg_INT *a)
 {
-    TCGv vec;
+    TCGv_i32 vec;
 
     tcg_debug_assert(a->imm < 0x100);
     vec = tcg_constant_i32(a->imm);
-- 
2.51.0


