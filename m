Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD7CC88E69
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFI-00031S-7A; Sun, 13 Sep 2026 20:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFD-00030d-HF
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:23 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFB-0006s7-7c
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:22 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so848773a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344500; x=1789949300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7+CcwxXPo43h/KNUQ7Zn18bG5lRkYVCqnQ1Dy2GQs4Q=;
 b=bpCo7RjrQZ4hQCJR57xwFxwx8bWB2VYjQaYvZ9FIdwNWZvAEXloZOWgCSp6M9UDI22
 BCdt1QuScDQgWn2BZOVK13FJut5Mlro5UknKcFbdLjctqYw8XJjVcbr2n/XnLFlwuJWc
 sGCi/W+sMTvTbG27MucG7n8NWhPsmXo4whqAH4bramkwURgveVfHK3lO7U0uMphvppTi
 p1+GUhHo+VLxlr0H5RUf8nv7YfvKs0vLWfET179BX6wISY362JRp4uNohwet+IreWEE2
 X0j8YoUKmKkyhkp3igqo3h7JAsBV0Bwi3KrPg78+faGLTGj3LGW9BpHVrrzIMXMINcsi
 p4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344500; x=1789949300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7+CcwxXPo43h/KNUQ7Zn18bG5lRkYVCqnQ1Dy2GQs4Q=;
 b=mICF/k1SJq0Zt1bWCEsbyL7covCR4U4/KRkxjNfbZtGdMAIKuxfvJ5bYYvpNnaStO2
 ZieQ1EzI8o3va2hk486vyc+K0j6LTbFTQgzAxDILLRE4mpxaEhjvqoG4NErIQUZL8gT5
 9AW3LAApAJNsBKeTaKtEQFhsd1rczmr7IawSZeejQQLhEj/Db/ZBk2vPhPM7Pt3jLA1s
 fdqf8sKkOEWL4qlqFuWDMVFJ3+p9FzF0r9MGEOAVx89oA6x7FKfimrwBmhm7Eb4vyiLB
 ZL9SYUe39GakLRAQlhD6ZXDh22tC+cfWAVV52GiC+iKhSuBxrs5RVHMEKTKjJyQSmUy2
 fCCA==
X-Gm-Message-State: AFuF++nMl1hIOXqWJF/gYeTR4cQrLdIloViSTdNJ+8SseLSF1DbNgjT0
 9/9hG2rauKtW2wXUYlzxluUKr1YfiVut3w0l2q8vqwFCmwRSXWmHxWsX6O9ZvQDq/zQkHo1pbxe
 18rPo5eU=
X-Gm-Gg: AYBFou3EoKIJdml7tkR0BQ7xDztBPBHRxSuiamhqh0XbECqkJ2F5QBZ9vmcWWfqQJgf
 l4DglzgSnLXK8xVkS5dSSZEnvtvFTQr9nlu17FcTaw8l4gKjT4ipxSGYHFCaQBMVYOLQRQqDXVO
 J6v/hMlJSW3hF9d3WJ6kZybPc4UU91PJVYWuqOypyRcwa9kCIcGaSS6pZx4r0rqRAi8O90BAmUR
 L7HBHYtvF9T6i79ocJdb0lf2kZfuAX0v524xBQPyTPrbwr9wD5tCjkEUUn8MdsZ6C3fO+kshpvb
 dyuKfrRKIQSCO+WI+pcu3VnEw2YAceQ5H5O+L/Dgn+ElTR+9M8vxVcmXL816JPSYg84O+5Mx5Hw
 eS/wO0cj2Z/GycPWoVvIf15YfeswwBeqwrn+umaIibcSKU2LOmQjV8VHmHFSkGqTJVf4uDLR58Q
 /6rTLGIWZxTrwQSLlaRHYurboDtYmTKL8V5jv5f5xUvQd30vR4gh7EQJkUYkqavnKnlE/6DeIGv
 5j7FLj8
X-Received: by 2002:a17:90b:3f4d:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-39dec064f1amr554836a91.13.1789344499652; 
 Sun, 13 Sep 2026 17:08:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 02/11] tcg/riscv64: Rename sb-type to b-type format
Date: Sun, 13 Sep 2026 14:08:05 -1000
Message-ID: <20260914000814.785155-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

The current riscv documentation calls this b-type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index a26503fa1ed..a10b433f2ff 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -472,9 +472,9 @@ static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t im
     return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_simm12(imm);
 }
 
-/* Type-SB */
+/* Type-B */
 
-static tcg_insn_unit encode_sbimm12(uint32_t imm)
+static tcg_insn_unit encode_bimm12(uint32_t imm)
 {
     tcg_insn_unit ret = 0;
 
@@ -486,9 +486,9 @@ static tcg_insn_unit encode_sbimm12(uint32_t imm)
     return ret;
 }
 
-static tcg_insn_unit encode_sb(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+static tcg_insn_unit encode_b(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
 {
-    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_sbimm12(imm);
+    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_bimm12(imm);
 }
 
 /* Type-U */
@@ -585,7 +585,7 @@ static void tcg_out_opc_store(TCGContext *s, RISCVInsn opc,
 static void tcg_out_opc_branch(TCGContext *s, RISCVInsn opc,
                                TCGReg rs1, TCGReg rs2, uint32_t imm)
 {
-    tcg_out32(s, encode_sb(opc, rs1, rs2, imm));
+    tcg_out32(s, encode_b(opc, rs1, rs2, imm));
 }
 
 static void tcg_out_opc_upper(TCGContext *s, RISCVInsn opc,
@@ -612,14 +612,14 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
  * Relocations
  */
 
-static bool reloc_sbimm12(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+static bool reloc_bimm12(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
     const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
     intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
 
     tcg_debug_assert((offset & 1) == 0);
     if (offset == sextreg(offset, 0, 12)) {
-        *src_rw |= encode_sbimm12(offset);
+        *src_rw |= encode_bimm12(offset);
         return true;
     }
 
@@ -662,7 +662,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     tcg_debug_assert(addend == 0);
     switch (type) {
     case R_RISCV_BRANCH:
-        return reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
+        return reloc_bimm12(code_ptr, (tcg_insn_unit *)value);
     case R_RISCV_JAL:
         return reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
     case R_RISCV_CALL:
@@ -1644,7 +1644,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     MemOp opc = get_memop(l->oi);
 
     /* resolve label address */
-    if (!reloc_sbimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
+    if (!reloc_bimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
@@ -1662,7 +1662,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     MemOp opc = get_memop(l->oi);
 
     /* resolve label address */
-    if (!reloc_sbimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
+    if (!reloc_bimm12(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
         return false;
     }
 
-- 
2.53.0


