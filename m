Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF97BCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4j-0002QW-8Z; Thu, 15 Oct 2026 06:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4h-0002No-8o
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4f-0007qI-F6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso2862378f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061556; x=1792666356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dn0bBZVHK0ngGcm/GUsGpk7B1iMQrvv+FRtZdkcCkiQ=;
 b=jJ0t2rQspQkzyOAUdunWbhNbB8A2AA+Ja3WKdsRmbTpSsRrBEoqr4Zg6iHxia8+RX0
 5jaVYsTlCIvN5Hj/EF7V50gW1TBKL+Q9byTpEZqr2R/w085HF6VPNM3CdnwNRLX+ZcSM
 H7NGT2+q36xSesm07RkN2nKO0RETZTI3t9Pdpzxi4shE4t47pqrniquraY1EOUR9QjBw
 Axvtig4yR7VxUABBCoUVwQAxWBte+UHn9af56S0HjJ4AW9Nw1wl5NJT4dWWja4BkJkOy
 ajo/ZnMVdgsnCajuZDniW5PpPv3TU8E+06ITHPk6dGdXVgVP/QTSkGCy3XxlHJNUnCYj
 tw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061556; x=1792666356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dn0bBZVHK0ngGcm/GUsGpk7B1iMQrvv+FRtZdkcCkiQ=;
 b=pu64byWOqUZiOZsmZGAAwHtr5uCXPg7W2kmRbArP2qBn3Ydt2A2HiMzo/3p0xfGuxG
 IiK7brp63vcs1GnaMMiYHujsNvv6hQUTRkZiHdZ1/tbSjQLI8BAAXQOK63Q53j+TF/hW
 MjRXNjf66jCJ7L9OBZEjIqKSX1tQEzKTKv8W9afBhny+LHOacFmL5iL6U2AoUr64ywhy
 CGoMBvkqxyzeJ8RpkMXeE7vFiLcoH3m1p0edNeXEvbfiUEUYemt9HBxcJuPazBFlY8oR
 3V9wpzlSIuA6K70lh4ZXTVSCaVTFD8+t/MHkNuUZRUftzc1vuyQKUxNpyWTzhxLOkOl5
 H/pQ==
X-Gm-Message-State: AFq9FYJ3wN9hUv+Cjuc7I2r7CwRVPe+dCV2vkz9gu4huzo8PK6cDyiwD
 Evzf+416MpdzAhfUeHkTgdGjJYwDBZiahfL2if8rtj45d5CCZw9uhJ9623ODBz2A2XahBlrQSRE
 vYPTyklo=
X-Gm-Gg: AYBFou0QRZhlL+WVQvabn7yPXtQ5fgJW3LxRI4spXXtSfsRlZHCAXmSJGe5q6Ti0pP8
 giU+hL7Ob7yqPKJNSaYN79jfpdg8WfV4tsCYhuz6biQQMBgBml8oc/JGEFCOI2nf7d6GZps0CFD
 rmFgWpLSgvztEVuZqOGAUJT/SkpqKsCxVurZJ4eVG9t2iJO3ixtjXECJkPzsqXqnuSXPKDvmoNP
 5XXODPoyHM6Q6eOUEQjPxKseP0ILXePZTCcp2WWuOB7UpzBMLeFyHIWGIIyqgaju5YpWb3FZS5p
 sroJRrF/NlUYUWOM1RWhdsh3Fld0I0wcb3MHYrMo1GAF/s8VPmJi/soJl+zE6OcOwwARVC6X+ru
 qcedfCaDXjcTYBSGvjCgW0bPkjZ4Su06fKUsFCK+29qiadynFtshBtpN8ueLfG7WyIVDpejK43K
 4Xipl6RmJseRWdwzUgVSzHifkxmQReQWflKC57J+JfhHu9+tN0SUTMfihifueLCE65aye7of3Uc
 GAF7eYeKyuBzrsg7UmcmGDv12Kv9yuoQ5XFKbKLbpmiOSdb+wWSz9sCkMr39v/RYlbNcnA7ly3q
 GR5T
X-Received: by 2002:a05:6000:4b1d:b0:48d:ee3a:6c64 with SMTP id
 ffacd0b85a97d-48dee3a6e94mr9474505f8f.14.1792061555904; 
 Thu, 15 Oct 2026 03:52:35 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/16] tcg/riscv64: Use signed type for encoding immediates
Date: Thu, 15 Oct 2026 12:52:01 +0200
Message-ID: <20261015105212.356392-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 37 +++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index c582bb74bd5..1ed87646e01 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -441,19 +441,20 @@ static tcg_insn_unit encode_r(RISCVInsn opc, TCGReg rd, TCGReg rs1, TCGReg rs2)
 
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
 
@@ -463,14 +464,15 @@ static tcg_insn_unit encode_simm12(uint32_t imm)
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
 
@@ -482,26 +484,27 @@ static tcg_insn_unit encode_bimm12(uint32_t imm)
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
 
@@ -513,7 +516,7 @@ static tcg_insn_unit encode_jimm20(uint32_t imm)
     return ret;
 }
 
-static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, uint32_t imm)
+static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 {
     return opc | (rd & 0x1f) << 7 | encode_jimm20(imm);
 }
@@ -521,7 +524,7 @@ static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, uint32_t imm)
 
 /* Type-OPIVI */
 
-static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
+static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
                                TCGReg vs2, bool vm)
 {
     return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
@@ -567,31 +570,31 @@ static void tcg_out_opc_reg(TCGContext *s, RISCVInsn opc,
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
@@ -691,7 +694,7 @@ static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc,
 }
 
 static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
-                           TCGReg vd, TCGReg vs2, int32_t imm)
+                           TCGReg vd, TCGReg vs2, tcg_target_long imm)
 {
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
 }
-- 
2.53.0


