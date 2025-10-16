Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D9CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Myw-0005Um-7J; Thu, 16 Oct 2025 08:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MxU-00046B-4Y
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mx9-00006H-Rc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so8351415e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617167; x=1761221967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d85xlyA85CESEyiBxTYYPiHDbiox7UbiMXSHU7pR80U=;
 b=ub6zpWUMhFx8pVCpW8JOdSJKnKUE4tJIVg4Jzp0zbaOhZ22XWz1Ff7uR2W1wj3RIx2
 wHGTgQitjcs9tbCv7JDnVhtXvLducuGTR4s0kvpFtm0xaOPhVeqw7DWrcE97XFDJm8zb
 Mdczki3S+/MBC7OkXZBPAHHMFv/h/dpR7H85o+3x4SX/M1KdiR/mpLzbsOYweX/KdSzd
 nl5o65DJ0mew0qz/si3vTgIEeX7T9l6I99xAnl4NcK/4RcSi66SssbohEGnza1qhkIQG
 HnmkYBYZptnMKJje7N3NhcEeo5aTSc7i5XiiF4b4eLuUjuxvCzZei3NRIo0WQKXdo9Ae
 TCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617167; x=1761221967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d85xlyA85CESEyiBxTYYPiHDbiox7UbiMXSHU7pR80U=;
 b=svAQ5C0HUSAMlL4uPtHKv7kPH1xfvtOdWgZrF+S7NC9P/aT2z0EIc9gUTRU6OPxomO
 73P5GhF9VI94rczviktRLLbnsrMbLHHh7Xt+jGPfH1fCl6cDBAqYL1IuzHaSDiTG7vwc
 BWMM9jGCDCS7BtqwUrbOt6xIHCEPCzIapJ8npenFn2TOghbN1p+yNwaPvs+xfkRZSRyg
 HDFZ4fxUdkfrFEOlFtSFeprgeH5rZc9SFSabYlwbFHD/IMbcIibymaZSSONh4RXjstiU
 3+98ZkPztF+yOsGpcMZ5ATr7k2LrP5fMKQ0ASkn75qoGHaSbHy/8f9lGoTzri0fIH+6G
 yH5Q==
X-Gm-Message-State: AOJu0YyFxp8c9sVfAsk7p1F6H5CSL5RHvIdiPUhHrbyBrHWPFWsn0SPi
 oFtwEoZqVfjwPs6hY+gB9yZIJ5H+hp4kFO3pE4ZW/aMU8qrAAKAJliYIKJMYY8AFA27cMKcDa2P
 uuQZ7vJY=
X-Gm-Gg: ASbGnctxSMV58rttrCGMuryHQK58M3lhFA7oAL3L7yoQJTdHrDWEOiJT3CRS8DTUzrg
 h0CGaIm8cch1hH8AvfQ4WLnu5Q3F31S39LKkNDvXSg1HQZG6IICzCbdaFixAt/GdPIjL9WzS76b
 QsOv1JjSDzNgyO3GuJc54YpRi4VcRbH/VqcAnReCMnd7jK5K4YdgN1wFR7Z8zxmEQHEp2+a8GcD
 oKZdkSTJzUm9QuUKkngO+GMO42xRV5WpzkuJPTroMovOHjadDVjiGR7gfN5USVFcoGd2mEg5wtC
 W5GPtKzJCidc68GTct0KJmNQZ85wBONK5jm3OADBPyUkRbODUsZMiLRbqJi0tdU0QCEuJu2Byx9
 eFdePCmiwLFlrst8vxkTnlIZvEUC2am51zhRLZIUzRtVRRPj7gJvnEjmbdSB92a/G3woxWpgxo2
 dnX1TIGwW9ba+fONT/6IuO9CPqSoJ5zMP71W106/KfV87PdgXw4UhQHJ7xVErz/HLSZoTJW3zZX
 Wo=
X-Google-Smtp-Source: AGHT+IGr58z8ForBOADpGJuoVCjvonqat1wh+dgGrpSdxxA6w+ocuv917/9k1c6tI8ruTw7OnXbMWg==
X-Received: by 2002:a05:600c:4e49:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-47117170686mr258955e9.24.1760617167216; 
 Thu, 16 Oct 2025 05:19:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442d6c6sm23199075e9.6.2025.10.16.05.19.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/75] target/rx: Un-inline various helpers
Date: Thu, 16 Oct 2025 14:15:06 +0200
Message-ID: <20251016121532.14042-51-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009200012.33650-1-philmd@linaro.org>
---
 target/rx/translate.c | 51 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 55285d8166f..ef865f14bf5 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -166,37 +166,34 @@ static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
 }
 
 /* generic load wrapper */
-static inline void rx_gen_ld(DisasContext *ctx, MemOp size,
-                             TCGv_i32 reg, TCGv_i32 mem)
+static void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | mo_endian(ctx));
 }
 
 /* unsigned load wrapper */
-static inline void rx_gen_ldu(DisasContext *ctx, MemOp size,
-                              TCGv_i32 reg, TCGv_i32 mem)
+static void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* generic store wrapper */
-static inline void rx_gen_st(DisasContext *ctx, MemOp size,
-                             TCGv_i32 reg, TCGv_i32 mem)
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
 
@@ -226,8 +223,8 @@ static inline MemOp mi_to_mop(unsigned mi)
 }
 
 /* load source operand */
-static inline TCGv_i32 rx_load_source(DisasContext *ctx, TCGv_i32 mem,
-                                  int ld, int mi, int rs)
+static TCGv_i32 rx_load_source(DisasContext *ctx, TCGv_i32 mem,
+                               int ld, int mi, int rs)
 {
     TCGv_i32 addr;
     MemOp mop;
@@ -732,7 +729,7 @@ static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
     return true;
 }
 
-static inline void stcond(TCGCond cond, int rd, int imm)
+static void stcond(TCGCond cond, int rd, int imm)
 {
     TCGv_i32 z;
     TCGv_i32 _imm;
@@ -810,24 +807,24 @@ static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
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
@@ -1342,8 +1339,8 @@ static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
     return true;
 }
 
-static inline void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
-                              unsigned int alith)
+static void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
+                       unsigned int alith)
 {
     static void (* const gen_sXri[])(TCGv_i32 ret, TCGv_i32 arg1, int arg2) = {
         tcg_gen_shri_i32, tcg_gen_sari_i32,
@@ -1362,7 +1359,7 @@ static inline void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
     tcg_gen_mov_i32(cpu_psw_s, cpu_regs[rd]);
 }
 
-static inline void shiftr_reg(uint32_t rd, uint32_t rs, unsigned int alith)
+static void shiftr_reg(uint32_t rd, uint32_t rs, unsigned int alith)
 {
     TCGLabel *noshift, *done;
     TCGv_i32 count;
@@ -1456,7 +1453,7 @@ static bool trans_RORC(DisasContext *ctx, arg_RORC *a)
 
 enum {ROTR = 0, ROTL = 1};
 enum {ROT_IMM = 0, ROT_REG = 1};
-static inline void rx_rot(int ir, int dir, int rd, int src)
+static void rx_rot(int ir, int dir, int rd, int src)
 {
     switch (dir) {
     case ROTL:
@@ -1591,7 +1588,7 @@ static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
     return true;
 }
 
-static inline void rx_save_pc(DisasContext *ctx)
+static void rx_save_pc(DisasContext *ctx)
 {
     TCGv_i32 pc = tcg_constant_i32(ctx->base.pc_next);
     push(ctx, pc);
@@ -1950,7 +1947,7 @@ static void rx_bclrr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
     tcg_gen_andc_i32(reg, reg, mask);
 }
 
-static inline void rx_btstr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
+static void rx_btstr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
 {
     TCGv_i32 t0;
     t0 = tcg_temp_new_i32();
@@ -1959,7 +1956,7 @@ static inline void rx_btstr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static inline void rx_bnotr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
+static void rx_bnotr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
 {
     tcg_gen_xor_i32(reg, reg, mask);
 }
@@ -2013,7 +2010,7 @@ BITOP(BCLR, bclr)
 BITOP(BTST, btst)
 BITOP(BNOT, bnot)
 
-static inline void bmcnd_op(TCGv_i32 val, TCGCond cond, int pos)
+static void bmcnd_op(TCGv_i32 val, TCGCond cond, int pos)
 {
     TCGv_i32 bit;
     DisasCompare dc;
@@ -2054,7 +2051,7 @@ enum {
     PSW_U = 9,
 };
 
-static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
+static void clrsetpsw(DisasContext *ctx, int cb, int val)
 {
     if (cb < 8) {
         switch (cb) {
-- 
2.51.0


