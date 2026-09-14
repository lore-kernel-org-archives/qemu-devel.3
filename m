Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32043C88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFG-00031B-VB; Sun, 13 Sep 2026 20:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFB-00030N-Vu
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:22 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFA-0006s3-2k
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so2369923a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344498; x=1789949298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0m2rAXMoagFHDfOq9qhvJe8XyC+YxtbYvXg3PJbo7Lg=;
 b=FgbRllSuT14AJkl0jExjoYSrA5ew0FmfdKXWx5HeDiPUn5/y6W0uQlCkGN7FMqfGwt
 GX8yGgKp51Fct8tijXTiwVKRwN7DyC2XnnQ8w49WRlp8eAVIbil4i0xntsgg2pHNtMD4
 jU2sYOokRenBpL2AxjFKOHO6Xq4aHSqzH3OjjSNOV1GaI6tYXXSM/rs2Y3GfgXtitmbz
 /ZiUYVsAtGm8upHiZVVmuDZ2LPwI7IWS/hOMsmxJvy1rhewqNkcSAfoDTxyeJyF/07dE
 5Db4URkHPWiIEXPFD5yFjuz0MBIesR9BjUx5A2nABH9/g3QkMDUP1YzCdOND0B5P+czj
 K57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344498; x=1789949298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0m2rAXMoagFHDfOq9qhvJe8XyC+YxtbYvXg3PJbo7Lg=;
 b=Vx/q+AJfySaK1J/LWLQzNWzPUlO/Sv9PcLD4AFa1Tmsmm9XtgvML1nk/uaGsFyMzTW
 XVIMvsP8FYvaEzj77X20luLi0326spTFtXCWXGmeAk40M6e0w8OWcKeaGKJi5oWneWzr
 1Ab3Jd235dX9EEFsyunSfDVMUG1x8FdANkmyQj1nLas4RXNNwjjvsnqIOpdXmzIOMAC8
 9SKNSf2ytbv72geFCitU1m5KOaK97WAtAjuhqv7JsSHKsk7B7a00rAGCQSLpnBRf7en+
 QVQ65mEO9JKiaPrNhf2/dXQ8CbamLFKLpXsZBNyyjbwX4rgdQwxjVktnrbV5nAA+lqeC
 CFsg==
X-Gm-Message-State: AFuF++kaBctM9TqCm983JhBstYAJtj2OnlhF2T5QLCJZ6k0VbA7oqqYi
 8fAqXIS+t1WLb3JsAAup9Er3Q0tFiRsM5YfR+RfLEp3K1HRDZu2FGYOZ50UvjMAFYfAMl8M0B6J
 vd1DM
X-Gm-Gg: AYBFou0M9U8TIaTxkB8OAFKP9dD0yynkGt4ivxQjSkmuaDL7F5PmD7+ZFweKuShUc9a
 Qc8i4vjkxqGD/6wFWVifWKU9YxN69Isoizo0+numpFHymSX078901M4eascxguO5uD6oloDtLQk
 fTG0ruMgtrnRgguw5CLfKYBskKNbThZ78oFgPa5F4iBoI38WBy17mHVd8gA4imI5SAevhHF1SC8
 gykUwdyuUD+idGhzfeRKZwz90hBpYeKmmW3DPUhrdn3Wib6FHGJ65FPhIM6c46K2JeiNWitKHih
 dHB4FoxSiGsC64ig8M9jMFMeGj+cdzTFakZOui4joGT4cIeMniUo1LAQ1O0h7D/X3Xd7RbQ73gi
 tBXknKz+ojbZmkU3vNV/J/4HyKxLG69WDXxOjJVTxcMTdIy0nrOCHUlMxmNnSTKoqaoLd4nC7hL
 k4M1Fsm7S/iXb2z8Z3olXn2QJo1RYccOvvxlIW/esuwKNgT3qDt1EDMWpaK5eIW4fvDQgPtUjQ9
 cjYd1oX3YWB5WKQSg==
X-Received: by 2002:a17:90b:2e0e:b0:38e:250b:122f with SMTP id
 98e67ed59e1d1-39dec056382mr553110a91.16.1789344498332; 
 Sun, 13 Sep 2026 17:08:18 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 01/11] tcg/riscv64: Return tcg_insn_unit from insn encoders
Date: Sun, 13 Sep 2026 14:08:04 -1000
Message-ID: <20260914000814.785155-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 47 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a633..a26503fa1ed 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -438,28 +438,28 @@ static bool tcg_target_const_match(int64_t val, int ct,
 
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
@@ -467,16 +467,16 @@ static int32_t encode_simm12(uint32_t imm)
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
@@ -486,28 +486,28 @@ static int32_t encode_sbimm12(uint32_t imm)
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
@@ -517,7 +517,7 @@ static int32_t encode_ujimm20(uint32_t imm)
     return ret;
 }
 
-static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
+static tcg_insn_unit encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
 {
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
@@ -525,8 +525,8 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
 
 /* Type-OPIVI */
 
-static int32_t encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
-                         TCGReg vs2, bool vm)
+static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
+                               TCGReg vs2, bool vm)
 {
     return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
            (vs2 & 0x1f) << 20 | (vm << 25);
@@ -534,8 +534,8 @@ static int32_t encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
 
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
 
-static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
-                        TCGReg s2, bool vm)
+static tcg_insn_unit encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
+                              TCGReg s2, bool vm)
 {
     return opc | (d & 0x1f) << 7 | (s1 & 0x1f) << 15 |
            (s2 & 0x1f) << 20 | (vm << 25);
@@ -543,20 +543,19 @@ static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
 
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


