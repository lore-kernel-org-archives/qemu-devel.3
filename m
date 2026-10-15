Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02775CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4f-0002MU-62; Thu, 15 Oct 2026 06:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4c-0002Jc-NI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4a-0007pi-U0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-487049569b6so3542571f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061551; x=1792666351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UgxSvjqorZbozu944NHI8qviwoPcBKpeVr1Z3LODC8M=;
 b=h6wEZPBh05sGiJCZwzV/0hwilgJRathd4n2Ck+x783qZMuv7g4QSl8QSxQpMfUUqlu
 jIqjSYFS9Uuf4odI037/bABgtQeDOD9HsKa09T7ioBP/1WYnmF2d32X99ntnlvmFBpCo
 wfiYG96SeQiA70jvZespAhfZ6JI9fjtWK7+QJp87fjGmaajGPwXHav6cWx+qAzcTENBz
 DgdVChKHS01OMTnaUqyZaqYeTSS240Mk/lIIMuoJVIMXY5fOun23VjAuDkm/0rBJrpuW
 DlomjzX1nRQgVc6UZBZXZSpYph6WY4UcaVDnVkFA9L9c+YWA3lBZjqG9p3bMqQcijaJ4
 E8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061551; x=1792666351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UgxSvjqorZbozu944NHI8qviwoPcBKpeVr1Z3LODC8M=;
 b=WlBhI9u5Ksc0OR5p58FNbV01Do5B4ad670N1LeQYzCDmf13jbChpzmsS3AJ3PNfyuf
 6/mqScdiBctDzeGdq6WcgO6keSAIbhrnbA9rzYb8ywhpVPKPxrL1dTxSDltB2ZZShrYc
 sBhAYCculNY7vQKhViLtaAq8wnMGgfJsjRUiQZDAXAZg/4BPSVQjomcc8QzhgZ8PEqr8
 mCf00jl7AA+9ngqjiwJz3b1wuzJeCP4io72SVxqSmkmr80psMqmrP819ETE8oLzkKpOf
 pE2wOTUTvZBPU5BWprOPwZ2cWbKQyJVQ20xvy3hpEwJ2gQMdtpNK/hhuichJSDLbm512
 tZBQ==
X-Gm-Message-State: AFq9FYKP2t2mpf5dyHc47bceZZks3YqUM62VQx96rhiaI4wcYqzKjug3
 UG6RGH+QddGwliW2qkyXmC/q1s3zC2SHHQiCIYXi7pJZA69eeBJItgiLhjrqX7bKqN0gf8CYrlu
 XJD5TW0g=
X-Gm-Gg: AYBFou0WtgLbILzkTKqAz91AIg4t/+TgxSJlj1Vswl2KEUwLQParAvAkgfGgAp92S72
 1d3Npt4VbjLka4AKW11sHmLlUSNDBj+W2xYA6uVBwpqRUr6q6L6kiMtKnMApClQ+fES5f0Bmpcq
 tEdnXN13JAilwdh3N3SHwrCKarycYXXrtF2YbI27b6+JolCUjVXkwfWegKZN/WRTgLc27tp/itv
 X1T3miyRuYNG8PaGtTeulD4kBx+KV9t/Lv7XeITjo4cbi0c05dACd91+x7M6Qm8ENUqYL10txWm
 tWne6wzltTCOmie8s8d1H/Smk/wtqO/afxjAk0IrJ1692yjKClgDKpOyLnJJc8wNpuE7AoCwE9s
 dgx+H/Q7ZSvzLdOFUx1IxQ0w8S/OsiINxkEAgTY7AKHftMw0mqDtZXDZl7Z3JIqBZBFdZTab+xq
 wLTCoye9rGGWQZ+fLYA2zad3HiDIu1afNVt13WssV0ssqlJzIW8GGI9yMnIaCK4jwpYJ46+CxSJ
 us3rmLyudeY0j6S1/yjobvXCElm+t5bo/o5b9zXFR6DtTAAugAB/TLDU2OPxJmHPfsF2Ab8iOI9
 pwtP
X-Received: by 2002:adf:e013:0:20b0:487:930:8acc with SMTP id
 ffacd0b85a97d-48dbaaddbd5mr26798811f8f.16.1792061551394; 
 Thu, 15 Oct 2026 03:52:31 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/16] tcg/riscv64: Return tcg_insn_unit from insn encoders
Date: Thu, 15 Oct 2026 12:51:58 +0200
Message-ID: <20261015105212.356392-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

Returning int32_t was logically incorrect.

Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 47 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 14a397117a2..158697cbc93 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -434,28 +434,28 @@ static bool tcg_target_const_match(int64_t val, int ct,
 
 /* Type-R */
 
-static int32_t encode_r(RISCVInsn opc, TCGReg rd, TCGReg rs1, TCGReg rs2)
+static tcg_insn_unit encode_r(RISCVInsn opc, TCGReg rd, TCGReg rs1, TCGReg rs2)
 {
     return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20;
 }
 
 /* Type-I */
 
-static int32_t encode_imm12(uint32_t imm)
+static tcg_insn_unit encode_imm12(uint32_t imm)
 {
     return (imm & 0xfff) << 20;
 }
 
-static int32_t encode_i(RISCVInsn opc, TCGReg rd, TCGReg rs1, uint32_t imm)
+static tcg_insn_unit encode_i(RISCVInsn opc, TCGReg rd, TCGReg rs1, uint32_t imm)
 {
     return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | encode_imm12(imm);
 }
 
 /* Type-S */
 
-static int32_t encode_simm12(uint32_t imm)
+static tcg_insn_unit encode_simm12(uint32_t imm)
 {
-    int32_t ret = 0;
+    tcg_insn_unit ret = 0;
 
     ret |= (imm & 0xFE0) << 20;
     ret |= (imm & 0x1F) << 7;
@@ -463,16 +463,16 @@ static int32_t encode_simm12(uint32_t imm)
     return ret;
 }
 
-static int32_t encode_s(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
 {
     return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_simm12(imm);
 }
 
 /* Type-SB */
 
-static int32_t encode_sbimm12(uint32_t imm)
+static tcg_insn_unit encode_sbimm12(uint32_t imm)
 {
-    int32_t ret = 0;
+    tcg_insn_unit ret = 0;
 
     ret |= (imm & 0x1000) << 19;
     ret |= (imm & 0x7e0) << 20;
@@ -482,28 +482,28 @@ static int32_t encode_sbimm12(uint32_t imm)
     return ret;
 }
 
-static int32_t encode_sb(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+static tcg_insn_unit encode_sb(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
 {
     return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_sbimm12(imm);
 }
 
 /* Type-U */
 
-static int32_t encode_uimm20(uint32_t imm)
+static tcg_insn_unit encode_uimm20(uint32_t imm)
 {
     return imm & 0xfffff000;
 }
 
-static int32_t encode_u(RISCVInsn opc, TCGReg rd, uint32_t imm)
+static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, uint32_t imm)
 {
     return opc | (rd & 0x1f) << 7 | encode_uimm20(imm);
 }
 
 /* Type-UJ */
 
-static int32_t encode_ujimm20(uint32_t imm)
+static tcg_insn_unit encode_ujimm20(uint32_t imm)
 {
-    int32_t ret = 0;
+    tcg_insn_unit ret = 0;
 
     ret |= (imm & 0x0007fe) << (21 - 1);
     ret |= (imm & 0x000800) << (20 - 11);
@@ -513,7 +513,7 @@ static int32_t encode_ujimm20(uint32_t imm)
     return ret;
 }
 
-static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
+static tcg_insn_unit encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
 {
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
@@ -521,8 +521,8 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
 
 /* Type-OPIVI */
 
-static int32_t encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
-                         TCGReg vs2, bool vm)
+static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
+                               TCGReg vs2, bool vm)
 {
     return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
            (vs2 & 0x1f) << 20 | (vm << 25);
@@ -530,8 +530,8 @@ static int32_t encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
 
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
 
-static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
-                        TCGReg s2, bool vm)
+static tcg_insn_unit encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
+                              TCGReg s2, bool vm)
 {
     return opc | (d & 0x1f) << 7 | (s1 & 0x1f) << 15 |
            (s2 & 0x1f) << 20 | (vm << 25);
@@ -539,20 +539,19 @@ static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
 
 /* Vector vtype */
 
-static uint32_t encode_vtype(bool vta, bool vma,
-                            MemOp vsew, RISCVVlmul vlmul)
+static uint32_t encode_vtype(bool vta, bool vma, MemOp vsew, RISCVVlmul vlmul)
 {
     return vma << 7 | vta << 6 | vsew << 3 | vlmul;
 }
 
-static int32_t encode_vset(RISCVInsn opc, TCGReg rd,
-                           TCGArg rs1, uint32_t vtype)
+static tcg_insn_unit encode_vset(RISCVInsn opc, TCGReg rd,
+                                 TCGArg rs1, uint32_t vtype)
 {
     return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | (vtype & 0x7ff) << 20;
 }
 
-static int32_t encode_vseti(RISCVInsn opc, TCGReg rd,
-                            uint32_t uimm, uint32_t vtype)
+static tcg_insn_unit encode_vseti(RISCVInsn opc, TCGReg rd,
+                                  uint32_t uimm, uint32_t vtype)
 {
     return opc | (rd & 0x1f) << 7 | (uimm & 0x1f) << 15 | (vtype & 0x3ff) << 20;
 }
-- 
2.53.0


