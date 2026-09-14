Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDCEC88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFK-00031f-NH; Sun, 13 Sep 2026 20:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFE-00030r-UM
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:25 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFD-0006sL-A2
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:24 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so1071961a12.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344501; x=1789949301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5xEbEy2sAnJ0uzzrJQuBzI/Eaa3crDuL6b/2mmoZJrA=;
 b=GeB8VmtsFi/myzLg6jottxWnUh5n71m7H6BkVQDrmhHgftzVXY/6UkMvoBLLRDNOGB
 LhZXhInygw/I0ojI73T/zQ2C6UShfw4HLrvOAl/F68f8/wOc1G072RZDvKG53QxTO+5d
 85E3A30cFQq3dkMWndksATLQ74bWdTiw3CxvPaEDaC4xKVLGYse/EV38QF6Qp6685gU2
 9WduyXdO+F3AnjkQavFokgGBUgfegQB3yR1s4Zh7d7fPYci4ekWxRinkZdXg6JWFQ2Uu
 OrVOlWifyohK3tQdh2Fdz16gYsL9DfoGJmOlACyZfmlXGdxsxp/hmY/nMGgoLXQi6AWx
 DhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344501; x=1789949301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5xEbEy2sAnJ0uzzrJQuBzI/Eaa3crDuL6b/2mmoZJrA=;
 b=LsslJllVgiq4OQEiEdlI39I3FyfZhlphNu3IA0VQPshTjPlIfiZLORcP60b/BDm/wS
 wVLquN3aKgONbcgPfEkRN4CNEg910uIw7q1ylnBG14Mi3sBMIW3xZHARGLzFG+oRMlOR
 zVe+nlqd8KbG/ZEbSSGjdxe74gtIDgRVzzxfrrPAzMhuKnsIIEiTbwA7x262i4cCTFd1
 tP90BNB6Uz/usgESYOGqFrXmgL4w1M4RnADEAr2P27IR5j0ZbLhlJwCah0RVU1GgHErZ
 8Fh9r2yF7uYgnT4okJMkYRiAx6HSoU5LV2pHVHhqh9w6EKhJgoj7mF/2bfB8vjPdflUt
 gzng==
X-Gm-Message-State: AFuF++kXb72mzhLpmgqhopAih2LA+/RpUUNvSLIsQ+42gi5zn3GEUgtB
 hGiy0QLZ44YUVmP3Z8benR+OQZ7NoeetYtEjSXaLTAhpAv1mJWTiIyrOBL7Q0WOSS5Qy8zsa0Fb
 jtVO7lqM=
X-Gm-Gg: AYBFou3pLmURnMSIi5L2RfU3nVmQK4mGH6XnTAj66btsNbYnHG5zMm7/zx5SMPXKugE
 dEH+YjNLTYeKyomWO0mW9+YX4R+HSsnZRv63Qglxo2saWTmWQDh677sJiiqjJvRgkGXeigcM5P3
 Iq8tvP5x/UKB5GcmE8LV2937jyi2TnyDhDK9Bc8UCjPSP19EnKVm70pyxhjc3H4nHFQClckq7wx
 cAQNYNaZxuIQTHI2DijabcK5js2/uYHfDUm/i/5eMlXIzAf10ReHV3s/T3XnxoNmvOALjulhACO
 9VuLs7tI8Xsw929Tj44J0cNgH+nQio0azL7o4dOak/W7vkWJUWcYfRZpNJsovOUF2rsNMI2ngtH
 GrUtER1SV95ZI7U5CM8tn26020F5V1nzvVeLZiackjlDpctzt8ASMYrTq1WtF9KlnRC+do6/4E3
 q4kd6zyrEAIOpE8B0kqJu9fdpCAsGPncIBM0s+9TWvgsTTcE+TEM27OkMJ5Nb1PZJWeKh2i9mB+
 E/eP0A=
X-Received: by 2002:a17:90b:2885:b0:398:b46d:48c0 with SMTP id
 98e67ed59e1d1-39dec0849e5mr593283a91.18.1789344501316; 
 Sun, 13 Sep 2026 17:08:21 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 03/11] tcg/riscv64: Rename uj-type to j-type format
Date: Sun, 13 Sep 2026 14:08:06 -1000
Message-ID: <20260914000814.785155-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

The current riscv documentation calls this j-type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index a10b433f2ff..f77fded1dfa 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -503,9 +503,9 @@ static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_uimm20(imm);
 }
 
-/* Type-UJ */
+/* Type-J */
 
-static tcg_insn_unit encode_ujimm20(uint32_t imm)
+static tcg_insn_unit encode_jimm20(uint32_t imm)
 {
     tcg_insn_unit ret = 0;
 
@@ -517,9 +517,9 @@ static tcg_insn_unit encode_ujimm20(uint32_t imm)
     return ret;
 }
 
-static tcg_insn_unit encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
+static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, uint32_t imm)
 {
-    return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
+    return opc | (rd & 0x1f) << 7 | encode_jimm20(imm);
 }
 
 
@@ -597,7 +597,7 @@ static void tcg_out_opc_upper(TCGContext *s, RISCVInsn opc,
 static void tcg_out_opc_jump(TCGContext *s, RISCVInsn opc,
                              TCGReg rd, uint32_t imm)
 {
-    tcg_out32(s, encode_uj(opc, rd, imm));
+    tcg_out32(s, encode_j(opc, rd, imm));
 }
 
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
@@ -633,7 +633,7 @@ static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 
     tcg_debug_assert((offset & 1) == 0);
     if (offset == sextreg(offset, 0, 20)) {
-        *src_rw |= encode_ujimm20(offset);
+        *src_rw |= encode_jimm20(offset);
         return true;
     }
 
@@ -1958,7 +1958,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 
     /* Either directly branch, or fall through to indirect branch. */
     if (offset == sextreg(offset, 0, 20)) {
-        insn = encode_uj(OPC_JAL, TCG_REG_ZERO, offset);
+        insn = encode_j(OPC_JAL, TCG_REG_ZERO, offset);
     } else {
         insn = OPC_NOP;
     }
-- 
2.53.0


