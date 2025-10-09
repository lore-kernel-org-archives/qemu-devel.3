Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F53CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6woQ-0003rr-Nb; Thu, 09 Oct 2025 16:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6woI-0003pw-C2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6woD-0005U7-BF
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:00:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so7824585e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760040014; x=1760644814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CfYMC0yG6+2bVV61gshC9d7Mg2mDGU4u4l79cSqObDw=;
 b=d7OEdyWYc4uSP+3Q1vXvs+BkT7usQWuW6HQx1n9m/GIOe7Ew6/zIOrM43iosKpErsr
 xZiXqYPPCfjduRb1UYAaJLfKxtxH8LrKcVBx7YKMINjpuiwmUeQLXJ2jg18G2EdpbAvw
 v7o2LGMwRF7AfiLABM1gd7D8vROV9/eioKWFLFn79P/Pj4KmF4SMhvNVElN7jdFSeUMJ
 De7zFUYRg9wO5UJ2H1Vx4FT95QAT96lE4SR1bGVh8EWQJFymriSazC82QSfj3D2cmZjj
 R4xPsZNppHPhBg9R1IINipYypH3ii+zNjMQ3csVcpW3GRrMKf7y0Pliw64tuqwE/Y2+F
 ecNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760040014; x=1760644814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CfYMC0yG6+2bVV61gshC9d7Mg2mDGU4u4l79cSqObDw=;
 b=Js8l4uIZss1mzZj7+gV+sNz2Mja7NlkFoKR5QJ+jps47S+OMB9KtJ0IeHcWLInD99S
 Ci8aocyMeNUAglCbbL8ACMkViozzua/eSRVqXDYU/+JD0cYeUURvwjfv7DC/IzLef9Bu
 qTOoxC8A/LIX9hL/KJmsLRy+mZmzj5loL/6YAS+4CrEm3ds9kQagZe2Cynv7vyERqx46
 2nARIU3TBGYa479XZdeNzjmOulaOORjJ8UsunQA60BCSED4RjUJmGgovtm3lXaQVTGd+
 aSC2MgUKg8P7yiUwZgQnaTU1ZU78BeDrgICUytm4fz31uTuCSEHeE8Ur2WwBKCme5taj
 FVWA==
X-Gm-Message-State: AOJu0Yx6gsq43NIshDPD+ePcb814RFqKYLjCZql2pSM6HCc3nyxIfQ88
 xhEhKxGcOeiJmWe+nqWlntjUzeNP9SBpuvyElo/336q3E84tXRSviCwPcP+hVDuCJJZwNmpotua
 pkbPKkut5JA==
X-Gm-Gg: ASbGncubGdF+9sY0XWSXqnW/1L+MvyXD2QFmqkMzbSEOcgt7MK0PFAbw0t0DCiF3WS3
 QEUMFG+QcrQK7AKHoKPt2wxRTEGfCJ+SQdyixzA2enxzEyEjPPlXSQ8H8OBMrqlhxdoMN75TT8b
 oDF4emLbiSZPJdc8QJCLhOkVjKBmeWv1hn+URH5GQ7aMQ5mEi9yY3LxmeyTWfXLDuGYH/HOHZ+o
 Zhk1gRDtKgO5iIUltUzQTzIYBzwoVZS6G5wjGqCbWONrVGDOEhsze5UNoFQ53f40p+Dj7AAiSlF
 6yXANebjNG+X+X/2oBDP4oW8AM/LskQWJVV8t5/91sYOPGFRHsrY9UByqjHRL20835caY3C7mFH
 0xnrht6VPYY80BS2yw5MwANSQyGI8HRqXtK6U5fSSo3md89VxtOwpVAq9Gwo6K3ASUpTeBQmF+v
 viFUAB3utvDsTx+UD9fp9w4DGG
X-Google-Smtp-Source: AGHT+IES3hyKuF24pPev3B6kT9dhgDVHx6iVSaaQnWaFJxJIiBDhZggHV4bo5mRB27aCPnC0OOvPxQ==
X-Received: by 2002:a05:600d:4203:b0:46e:6af4:ed83 with SMTP id
 5b1f17b1804b1-46fa9af9099mr65927275e9.23.1760040014424; 
 Thu, 09 Oct 2025 13:00:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab656554sm43303675e9.11.2025.10.09.13.00.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 13:00:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/rx: Un-inline various helpers
Date: Thu,  9 Oct 2025 22:00:12 +0200
Message-ID: <20251009200012.33650-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Rely on the linker to optimize at linking time.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20251009151607.26278-1-philmd@linaro.org>
---
 target/rx/translate.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 7044fa29ba4..5519b1878e9 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -166,34 +166,34 @@ static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
 }
 
 /* generic load wrapper */
-static inline void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
+static void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | mo_endian(ctx));
 }
 
 /* unsigned load wrapper */
-static inline void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
+static void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* generic store wrapper */
-static inline void rx_gen_st(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
+static void rx_gen_st(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
 {
     tcg_gen_qemu_st_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* [ri, rb] */
-static inline void rx_gen_regindex(DisasContext *ctx, TCGv_i32 mem,
-                                   int size, int ri, int rb)
+static void rx_gen_regindex(DisasContext *ctx, TCGv_i32 mem,
+                            int size, int ri, int rb)
 {
     tcg_gen_shli_i32(mem, cpu_regs[ri], size);
     tcg_gen_add_i32(mem, mem, cpu_regs[rb]);
 }
 
 /* dsp[reg] */
-static inline TCGv_i32 rx_index_addr(DisasContext *ctx, TCGv_i32 mem,
-                                 int ld, int size, int reg)
+static TCGv_i32 rx_index_addr(DisasContext *ctx, TCGv_i32 mem,
+                              int ld, int size, int reg)
 {
     uint32_t dsp;
 
@@ -223,8 +223,8 @@ static inline MemOp mi_to_mop(unsigned mi)
 }
 
 /* load source operand */
-static inline TCGv_i32 rx_load_source(DisasContext *ctx, TCGv_i32 mem,
-                                  int ld, int mi, int rs)
+static TCGv_i32 rx_load_source(DisasContext *ctx, TCGv_i32 mem,
+                               int ld, int mi, int rs)
 {
     TCGv_i32 addr;
     MemOp mop;
@@ -729,7 +729,7 @@ static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
     return true;
 }
 
-static inline void stcond(TCGCond cond, int rd, int imm)
+static void stcond(TCGCond cond, int rd, int imm)
 {
     TCGv_i32 z;
     TCGv_i32 _imm;
@@ -807,24 +807,24 @@ static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
 typedef void (*op2fn)(TCGv_i32 ret, TCGv_i32 arg1);
 typedef void (*op3fn)(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 
-static inline void rx_gen_op_rr(op2fn opr, int dst, int src)
+static void rx_gen_op_rr(op2fn opr, int dst, int src)
 {
     opr(cpu_regs[dst], cpu_regs[src]);
 }
 
-static inline void rx_gen_op_rrr(op3fn opr, int dst, int src, int src2)
+static void rx_gen_op_rrr(op3fn opr, int dst, int src, int src2)
 {
     opr(cpu_regs[dst], cpu_regs[src], cpu_regs[src2]);
 }
 
-static inline void rx_gen_op_irr(op3fn opr, int dst, int src, uint32_t src2)
+static void rx_gen_op_irr(op3fn opr, int dst, int src, uint32_t src2)
 {
     TCGv_i32 imm = tcg_constant_i32(src2);
     opr(cpu_regs[dst], cpu_regs[src], imm);
 }
 
-static inline void rx_gen_op_mr(op3fn opr, DisasContext *ctx,
-                                int dst, int src, int ld, int mi)
+static void rx_gen_op_mr(op3fn opr, DisasContext *ctx,
+                         int dst, int src, int ld, int mi)
 {
     TCGv_i32 val, mem;
     mem = tcg_temp_new_i32();
@@ -1339,8 +1339,8 @@ static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
     return true;
 }
 
-static inline void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
-                              unsigned int alith)
+static void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
+                       unsigned int alith)
 {
     static void (* const gen_sXri[])(TCGv_i32 ret, TCGv_i32 arg1, int arg2) = {
         tcg_gen_shri_i32, tcg_gen_sari_i32,
@@ -1359,7 +1359,7 @@ static inline void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
     tcg_gen_mov_i32(cpu_psw_s, cpu_regs[rd]);
 }
 
-static inline void shiftr_reg(uint32_t rd, uint32_t rs, unsigned int alith)
+static void shiftr_reg(uint32_t rd, uint32_t rs, unsigned int alith)
 {
     TCGLabel *noshift, *done;
     TCGv_i32 count;
@@ -1452,7 +1452,7 @@ static bool trans_RORC(DisasContext *ctx, arg_RORC *a)
 
 enum {ROTR = 0, ROTL = 1};
 enum {ROT_IMM = 0, ROT_REG = 1};
-static inline void rx_rot(int ir, int dir, int rd, int src)
+static void rx_rot(int ir, int dir, int rd, int src)
 {
     switch (dir) {
     case ROTL:
@@ -1587,7 +1587,7 @@ static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
     return true;
 }
 
-static inline void rx_save_pc(DisasContext *ctx)
+static void rx_save_pc(DisasContext *ctx)
 {
     TCGv_i32 pc = tcg_constant_i32(ctx->base.pc_next);
     push(ctx, pc);
@@ -1946,7 +1946,7 @@ static void rx_bclrr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
     tcg_gen_andc_i32(reg, reg, mask);
 }
 
-static inline void rx_btstr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
+static void rx_btstr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
 {
     TCGv_i32 t0;
     t0 = tcg_temp_new_i32();
@@ -1955,7 +1955,7 @@ static inline void rx_btstr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static inline void rx_bnotr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
+static void rx_bnotr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
 {
     tcg_gen_xor_i32(reg, reg, mask);
 }
@@ -2009,7 +2009,7 @@ BITOP(BCLR, bclr)
 BITOP(BTST, btst)
 BITOP(BNOT, bnot)
 
-static inline void bmcnd_op(TCGv_i32 val, TCGCond cond, int pos)
+static void bmcnd_op(TCGv_i32 val, TCGCond cond, int pos)
 {
     TCGv_i32 bit;
     DisasCompare dc;
@@ -2050,7 +2050,7 @@ enum {
     PSW_U = 9,
 };
 
-static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
+static void clrsetpsw(DisasContext *ctx, int cb, int val)
 {
     if (cb < 8) {
         switch (cb) {
-- 
2.51.0


