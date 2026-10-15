Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445F8CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4u-0002p7-7P; Thu, 15 Oct 2026 06:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4s-0002gA-1P
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4p-0007sF-UN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso17894285e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061566; x=1792666366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yTZfMe6bvkVfvzsbQUSsQrWwnuErOO6bZjRLiWn9Ehw=;
 b=BbTsNtEJ4lXxueuhjKt8AV1eA3lndV/TyGzKxzQ5cyWUg9Xcr7rtMU2DrSeJLiS3bG
 PFPmXOkspaAfv2ICrbh4yujS98NhtrNSjVT1yT3p8ep1aRBBWPjnFrlJv7IcJx4jfPHW
 ftJxd0pCdDMgUVpR7zKmU3JD9bxrcxS0I2NTQ0OL4m6j9dNnI/AJ9hIjZdshQTwaefsa
 LjV6sNCWprZqD+JDOgkLI3mHLbKM4uRbJWLR6ZWz4nN2tHuqkDjfpjz7X/HhGg19qcZf
 VTYuSHiUoOgrkpTMrWJXNVz4XrjuoZw7S/Xj9RVDWX6NztW//Ae1RkUlTkt92gLlQ2kJ
 sCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061566; x=1792666366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yTZfMe6bvkVfvzsbQUSsQrWwnuErOO6bZjRLiWn9Ehw=;
 b=CKOqmb4AuIJBq4DD67h2ffiN2KslejxMMhpXI27CBnY1kWU7Mkcitsp360vss1MQ6J
 Mez/2YJOvRCtl5dzLy7VDZ5dwp4Kb0Tkelct0CX/QDIBmXP1XT/5YdO+O+lgJdAxWY2T
 A424aP33HtnmNuE26z+75iWHeXnHs3XOngSEidOVL2wWCzrbni8Zgoocot62f6bKxdPe
 NBy47ECEjOd/9LJnJaxh7XxiTRkYfxmtmtnFclykgC7kORRdWeqAFNqfVEHdvFDe1IVb
 xNWk7vqjR4+Ndkyye6mSJwt8wEzqSO+8M/Lr60ecAuS3yyJaWUIkyD3J+Eai0i8hBAb8
 H56g==
X-Gm-Message-State: AFq9FYLjADACWCzegtOZk2IgshvwmvTuD9i9Yh3nD+Zi3tGrPjamMOG6
 PMw+2upqLSZDyTb60SBpm+x6tZxQahMzAzM8ptYasiBOuoS6PZsNJ/cul07ruOCOiDj1IcBOK+Z
 omJE1SD0=
X-Gm-Gg: AYBFou0Gq0HluSwLzRarddlDKS6uSh0EPmL31aTk1DELCXNPyDRSoY346MW/8pnaf47
 6PiBvlys9M76uqrbtpVQw0mVK8FFsVfY/H0SReM/rUIZDBOQMr2ivbtRn3YUAplfQbpYsfn+x82
 S8nWyOHP/cu6EbW/Yq5BaLvxYUahFI0vSXmc4XTrncGMxLTkQdRMx7zTvgTbCSwlmZY0af+pHsI
 tWlcD5YnQD4roZcaPD+kE5elQL7LY4v2qJPF/jYo5ZX/SWlRGBngkFWhvt8BAgFBsWRGkvNP6EQ
 r3z+aiJLcKPVk+oHf+fvnmUFr5zYPLr6ig2PMHq8VRTHWXYYFS9aqumaaARRJ1Kei4dKR9AqrTS
 SNClOmAhMN3W0t5WuQrrdmR4kzrP+i2cSDcbW0qdN67/clLyp2OAumxrM/bu7vMs6FeLKCmixDv
 lXP/yVDnbuMu81D01As2Gwx0CVNp7PzCmYjy2kELM1xtYzfeBu1c93VbVANLqgfE3Z4+qR8MlLS
 61JV4kKiJw8WgwVPkZl1tL8HuKtH+hKXD10Il2f2Xw0cGX5/zceVtNaC2N668+Rs9ODUJ3vw9QL
 eLd2
X-Received: by 2002:a05:600c:46c5:b0:4a0:eae0:769a with SMTP id
 5b1f17b1804b1-4a18e4cd224mr384709945e9.28.1792061566466; 
 Thu, 15 Oct 2026 03:52:46 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>
Subject: [PULL 16/16] tcg/riscv64: Fall back when AUIPC pairs are out of range
Date: Thu, 15 Oct 2026 12:52:08 +0200
Message-ID: <20261015105212.356392-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Max Chou <max.chou@sifive.com>

tcg_out_movi, tcg_out_call_int, and tcg_out_ldst only check whether a
PC-relative displacement is signed 32-bit before emitting an AUIPC pair.
This does not account for rounding the signed 12-bit immediate, which
can require an unencodable positive 0x80000000 AUIPC contribution.

Validate the split and emit the pair only when it fits.

Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Drop 'ret' local variables; update tcg_out_ldst too.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 54 +++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 99c81dc6521..03f32c5819f 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -806,7 +806,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
 {
     tcg_target_long tmp;
     int32_t lo, hi;
-    int shift, ret;
+    int shift;
 
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
@@ -827,12 +827,9 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
         return;
     }
 
-    tmp = tcg_pcrel_diff(s, (void *)val);
-    if (tmp == (int32_t)tmp) {
-        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
-        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
-        ret = reloc_call(s->code_ptr - 2, (const tcg_insn_unit *)val);
-        tcg_debug_assert(ret == true);
+    if (split_auipc_offset(s->code_ptr, val, &hi, &lo)) {
+        tcg_out_opc_upper(s, OPC_AUIPC, rd, hi);
+        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, lo);
         return;
     }
 
@@ -950,16 +947,16 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg ret, TCGReg arg)
 static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
                          TCGReg addr, intptr_t offset)
 {
-    intptr_t imm12 = sextreg(offset, 0, 12);
+    int32_t lo = sextract32(offset, 0, 12);
 
-    if (offset != imm12) {
-        intptr_t diff = tcg_pcrel_diff(s, (void *)offset);
+    if (offset != lo) {
+        int32_t hi;
 
-        if (addr == TCG_REG_ZERO && diff == (int32_t)diff) {
-            imm12 = sextreg(diff, 0, 12);
-            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP2, diff - imm12);
+        if (addr == TCG_REG_ZERO &&
+            split_auipc_offset(s->code_ptr, offset, &hi, &lo)) {
+            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP2, hi);
         } else {
-            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - imm12);
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - lo);
             if (addr != TCG_REG_ZERO) {
                 tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, addr);
             }
@@ -972,7 +969,7 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     case OPC_SH:
     case OPC_SW:
     case OPC_SD:
-        tcg_out_opc_store(s, opc, addr, data, imm12);
+        tcg_out_opc_store(s, opc, addr, data, lo);
         break;
     case OPC_LB:
     case OPC_LBU:
@@ -981,7 +978,7 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     case OPC_LW:
     case OPC_LWU:
     case OPC_LD:
-        tcg_out_opc_imm(s, opc, data, addr, imm12);
+        tcg_out_opc_imm(s, opc, data, addr, lo);
         break;
     default:
         g_assert_not_reached();
@@ -1592,7 +1589,7 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
     tcg_insn_unit insn = encode_j(OPC_JAL, link, 0);
-    int ret;
+    int32_t lo, hi;
 
     init_setting_vtype(s);
 
@@ -1600,19 +1597,18 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
     if (encode_jimm20(&insn, offset)) {
         /* short jump */
         tcg_out32(s, insn);
-    } else if (offset == (int32_t)offset) {
-        /* long jump: -2147483646 to 2147483648 */
-        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
-        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
-        ret = reloc_call(s->code_ptr - 2, arg);
-        tcg_debug_assert(ret == true);
-    } else {
-        /* far jump: 64-bit */
-        tcg_target_long imm = sextreg((tcg_target_long)arg, 0, 12);
-        tcg_target_long base = (tcg_target_long)arg - imm;
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, base);
-        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, imm);
+        return;
     }
+
+    if (split_auipc_offset(s->code_ptr, (intptr_t)arg, &hi, &lo)) {
+        /* long jump */
+        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, hi);
+    } else {
+        /* far jump */
+        lo = sextract32((intptr_t)arg, 0, 12);
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, (intptr_t)arg - lo);
+    }
+    tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, lo);
 }
 
 static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg,
-- 
2.53.0


