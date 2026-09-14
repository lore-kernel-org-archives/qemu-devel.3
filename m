Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4148C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFN-00033I-2l; Sun, 13 Sep 2026 20:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFF-00031A-TT
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:26 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFE-0006sS-2W
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:25 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1387887a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344503; x=1789949303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8OcTNzghpuIE4ECsgWviRRjONmA9ec2AkFt+k5E+bEw=;
 b=hudMWNXOmys2gtuBjcHJZu2lz+nx8MT49mI4ifVddabgTtO8ue6BnzeqSV3PW77drV
 zVbaVocmlMScDQlDybZKb3/kdqrleLxkhmBP+SXJP2jFBS9dqAfFQYPDqvrap/VpLB69
 Q8crFvJcgMbDqbnsgZg3YWJbay19mkLz0YC4mA7F4/HL3iCk7nZ6efQgWl8L/kYPXGEH
 aHXOOe6sS7d5e+5ySr3dAvQIkDzRkFBKgqX/+B+2PzMZCBcqD7XCNTJk/gacoHbwFMpB
 JdPzVbv9S3Tv3Ct2P3IEY0kbOoW/us/7RAvhfrKNiHUbs//ptWuzhl5rULK9/bXFIAmj
 35tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344503; x=1789949303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8OcTNzghpuIE4ECsgWviRRjONmA9ec2AkFt+k5E+bEw=;
 b=ovvkjsX+cpuC5mNItYCRdV93n+1XLmA+/GX/SmiOxg8n74h5FwoUVDLmB92fjhGUHb
 VbmWI2ks7Nf92EhVyKfQZtcR4GWy705M54jk/JSSEoul3dbuRYdNEeq9U2EGsZPBMJfa
 BLQcj+3Iw4HMN+fJWaZfP82oLkU2JiU2ME1LWfonZbA/P5oJ186nAXjbYRzKGqt3sNKT
 ZFdoWDpXXj0tp31PatCWcX+wkDjESoiOLfNzMS8EIW1N9xbNzut4q5tbclSv3BApKJvG
 8ytIp1NDf5j5Rx7bZvoXiKmzRuqX93gplX9SR6yIWwMsIXN0GNpgG/z20vDT2JVbhuHl
 JiaA==
X-Gm-Message-State: AFuF++kMWoxvRAh0SVFyvJ7IqklZW/EcfFh9ccaPn/YLICApSPX8WdzU
 FMpdR7x+JZ7ZG4HJwXm/MxzbwcTqn30ve8QczvE2rJ5nxKGc8tGKvPd04wXLMkxdkbr8WmyDaA7
 JwtuckDE=
X-Gm-Gg: AYBFou0G0BXeGpXIs4rCGX5e/UaBtk32nWfeUbvVKqTqaw45OximELOHtoWuuCgnNnk
 5cLxDjCiRPDW2HlcELv6lH2cKv1XuUoAVRNoaZb9DNZt8txnhA6j7XQwXWXVVEeS2+VcE5z7TzO
 jOJr/VjRpq/69PUVA946ebDy15pvLkBM65D5Z6aB0TPyyIK1XN60nx8loVcstQ4eC9STXl7pvbu
 SEgq8/c16FZFAVq9Svvg5dIB1gBWoG+T2oLk0n8jZAN2O0MnMQmwz8fGbX0KuEj1cRgH+YERGfk
 bj+VCypxIiwUXFLinKzo47aiG8UGB7hfcNcNLQnuXQBP4e3OTaFA5C3lOjiwzWh+VDgGHr6WWco
 5BdzFCPwAMOoN+ahHKWmrwEDlMMwAJBa7YKg/AQ7vQIjv+vVGQiFUnwVIycWj2MLJHafdwRxU8M
 QdlScvHfIdjeysWUcO2l0PL/zkll489BOqwSAQWzT/bPjtwMY4v5AhzA4Uv31PNAUjm65C+Dl1N
 5zFjGJL
X-Received: by 2002:a17:90b:3b85:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39debdd9c94mr602044a91.0.1789344502624; 
 Sun, 13 Sep 2026 17:08:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 04/11] tcg/riscv64: Use signed type for encoding immediates
Date: Sun, 13 Sep 2026 14:08:07 -1000
Message-ID: <20260914000814.785155-5-richard.henderson@linaro.org>
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

The immediate operands in the 5 base instruction formats are all signed,
so passing an unsigned type was logically incorrect.  Use tcg_target_long
not int32_t to avoid truncation, which will become relevant later.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index f77fded1dfa..99bc658c264 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -445,19 +445,20 @@ static tcg_insn_unit encode_r(RISCVInsn opc, TCGReg rd, TCGReg rs1, TCGReg rs2)
 
 /* Type-I */
 
-static tcg_insn_unit encode_imm12(uint32_t imm)
+static tcg_insn_unit encode_imm12(tcg_target_long imm)
 {
     return (imm & 0xfff) << 20;
 }
 
-static tcg_insn_unit encode_i(RISCVInsn opc, TCGReg rd, TCGReg rs1, uint32_t imm)
+static tcg_insn_unit encode_i(RISCVInsn opc, TCGReg rd,
+                              TCGReg rs1, tcg_target_long imm)
 {
     return opc | (rd & 0x1f) << 7 | (rs1 & 0x1f) << 15 | encode_imm12(imm);
 }
 
 /* Type-S */
 
-static tcg_insn_unit encode_simm12(uint32_t imm)
+static tcg_insn_unit encode_simm12(tcg_target_long imm)
 {
     tcg_insn_unit ret = 0;
 
@@ -467,14 +468,15 @@ static tcg_insn_unit encode_simm12(uint32_t imm)
     return ret;
 }
 
-static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1,
+                              TCGReg rs2, tcg_target_long imm)
 {
     return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_simm12(imm);
 }
 
 /* Type-B */
 
-static tcg_insn_unit encode_bimm12(uint32_t imm)
+static tcg_insn_unit encode_bimm12(tcg_target_long imm)
 {
     tcg_insn_unit ret = 0;
 
@@ -486,26 +488,27 @@ static tcg_insn_unit encode_bimm12(uint32_t imm)
     return ret;
 }
 
-static tcg_insn_unit encode_b(RISCVInsn opc, TCGReg rs1, TCGReg rs2, uint32_t imm)
+static tcg_insn_unit encode_b(RISCVInsn opc, TCGReg rs1,
+                              TCGReg rs2, tcg_target_long imm)
 {
     return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_bimm12(imm);
 }
 
 /* Type-U */
 
-static tcg_insn_unit encode_uimm20(uint32_t imm)
+static tcg_insn_unit encode_uimm20(tcg_target_long imm)
 {
     return imm & 0xfffff000;
 }
 
-static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, uint32_t imm)
+static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 {
     return opc | (rd & 0x1f) << 7 | encode_uimm20(imm);
 }
 
 /* Type-J */
 
-static tcg_insn_unit encode_jimm20(uint32_t imm)
+static tcg_insn_unit encode_jimm20(tcg_target_long imm)
 {
     tcg_insn_unit ret = 0;
 
@@ -517,7 +520,7 @@ static tcg_insn_unit encode_jimm20(uint32_t imm)
     return ret;
 }
 
-static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, uint32_t imm)
+static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 {
     return opc | (rd & 0x1f) << 7 | encode_jimm20(imm);
 }
@@ -571,31 +574,31 @@ static void tcg_out_opc_reg(TCGContext *s, RISCVInsn opc,
 }
 
 static void tcg_out_opc_imm(TCGContext *s, RISCVInsn opc,
-                            TCGReg rd, TCGReg rs1, TCGArg imm)
+                            TCGReg rd, TCGReg rs1, tcg_target_long imm)
 {
     tcg_out32(s, encode_i(opc, rd, rs1, imm));
 }
 
 static void tcg_out_opc_store(TCGContext *s, RISCVInsn opc,
-                              TCGReg rs1, TCGReg rs2, uint32_t imm)
+                              TCGReg rs1, TCGReg rs2, tcg_target_long imm)
 {
     tcg_out32(s, encode_s(opc, rs1, rs2, imm));
 }
 
 static void tcg_out_opc_branch(TCGContext *s, RISCVInsn opc,
-                               TCGReg rs1, TCGReg rs2, uint32_t imm)
+                               TCGReg rs1, TCGReg rs2, tcg_target_long imm)
 {
     tcg_out32(s, encode_b(opc, rs1, rs2, imm));
 }
 
 static void tcg_out_opc_upper(TCGContext *s, RISCVInsn opc,
-                              TCGReg rd, uint32_t imm)
+                              TCGReg rd, tcg_target_long imm)
 {
     tcg_out32(s, encode_u(opc, rd, imm));
 }
 
 static void tcg_out_opc_jump(TCGContext *s, RISCVInsn opc,
-                             TCGReg rd, uint32_t imm)
+                             TCGReg rd, tcg_target_long imm)
 {
     tcg_out32(s, encode_j(opc, rd, imm));
 }
-- 
2.53.0


