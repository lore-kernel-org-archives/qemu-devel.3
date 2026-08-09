Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DBAC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBH-0005vn-LY; Sun, 09 Aug 2026 18:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBF-0005uL-Rp
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:45 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBD-000843-Jc
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:45 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so1331864a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315182; x=1786919982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5s0IwffoMRvG3Wnu8+sauk7FlicdbDb2VjR30Cy60eg=;
 b=bx/58W/A0vkkGT/rmCMppQdeuIyBCnR8lGEk79iLtnA6kIR8JA9jkYH18Gje4Kbn/o
 950pxh/9JtglXYHVXnVZK8HkZidFmORWkO1k46UhQu4/V2VSGSHleRTXjOS9ATpq8D7T
 yrLxv+KGYWUrFZJnK0uq+BA63Ou1nJFIY2XDAnXtIMucYXnSyLooo1+ZUjAzeTnnusR1
 ROOos2fzYJKEJM+nnHw30D4hl/2SqMmE/TgmPa+WiEmUWAKgkFj05s2S7/9yGA4opOXY
 xBkruu27M+RKlq3BXvHjOoAzCucq3cpYynip85QBbPQ+ZpADIPpXAo37Ci1aLFqXA2UD
 56DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315182; x=1786919982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5s0IwffoMRvG3Wnu8+sauk7FlicdbDb2VjR30Cy60eg=;
 b=WcZDiHt+pBb5lR3zVufJIfPwBIcCd6uZ6i9McPyvQkFq/w1iGc3o9GzWOmfaNoOlBB
 LG1kPAhui3vJsMMA9YXDdJgWWw/kbRXlOXjh+R4AB+gkZv1NIA7+iYOxNFQcdAiChuKG
 Iy3Y7ecyrXEUjanWNoOmdE1Rjt70+O9dSZYqMzwNd2JJfHz1hhDeig+rF2vowzMDWThc
 KgsxDP1/3qgVfDEzF54xQ+x7tzknNxL2Re6S19y+MlfLWpbdlfToYUM7QmaqMMgenCZD
 uKarAvqDnogSVCmoQSNHr0pTr24r6ZuB10uDtgydeQxvvkFeXLcSXK+7yG+6gVtfL7xp
 vDow==
X-Gm-Message-State: AOJu0YwZCGXflKENqqKqAwwwXOWBVWvW7MB552YLnPqcGuyLFCSd3wQ6
 eS4kSrLG3UzE33owfBG/iNCD92gXpAp2g0vGEJnEuacx4unypcQMsqVORGcsGYerowg8WYQlcEq
 i8Aih
X-Gm-Gg: AR+sD11pdnSNX35MIVjOyVRXviQgMbb86tvHi9hODs2lfYpJFlFpcsc0P16T9Jjl1BB
 IQ3m0oz/qDa53ZGml/+vF/UDAsQKhy36VTkfLqkSrWKNFtqbHgu+psNpWiE+J+JRVNTJoCce2q8
 3kHFkkeFCI35s+3HTFSc/AAuhV5fUeudxJbwjnBfM4DEt96Ib6fBmmNHJkBKdREulRYKBXlrBzO
 21ToAXcRUVe8t4oEB+NhzdtVvp3Z8tny/hTK+Gm0xPbX8dTgvgSeaOnVcFi3EWdzvxg/EfNe0bt
 M4sPneHYneDtro62cCHf1oOya4+cuY8e9ogoBFPrWm59U4zlmNI+eg461C3b3RugFsG46KknZcc
 EJI7IrKjXjUvsF1J54YBmQs5dhbjDL1YAP7iYO0DsCPE7eeTSsxnfZbnU9wqfiW+IogiVD5cq3v
 I5XinpaY2YENq1Y1im8/jl5VvK78NKf7kZf2hauJEuOf4fahs/bfh7eUNTlvf8KLjeMpKOe3nEZ
 dquKyFAhJ5EZFLFryiG
X-Received: by 2002:a17:90b:3c06:b0:38d:e658:595a with SMTP id
 98e67ed59e1d1-3903c54f1fdmr37648474a91.2.1786315182209; 
 Sun, 09 Aug 2026 15:39:42 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 46/56] disas/riscv: Split xlrbr_opcode_data
Date: Sun,  9 Aug 2026 15:35:35 -0700
Message-ID: <20260809223545.730664-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Move the table to riscv-xlrbr-op.c.inc and massage
the lines into OP() form.  Drop illegal as unused.
Return pointers to objects directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv-xlrbr.c        | 54 +++++++++-----------------------------
 disas/riscv-xlrbr-op.c.inc |  8 ++++++
 2 files changed, 20 insertions(+), 42 deletions(-)
 create mode 100644 disas/riscv-xlrbr-op.c.inc

diff --git a/disas/riscv-xlrbr.c b/disas/riscv-xlrbr.c
index b12916c9da..b4229e5c83 100644
--- a/disas/riscv-xlrbr.c
+++ b/disas/riscv-xlrbr.c
@@ -8,38 +8,16 @@
  */
 
 #include "qemu/osdep.h"
-
 #include "disas/riscv.h"
 #include "disas/riscv-xlrbr.h"
 
-typedef enum {
-    /* 0 is reserved for rv_op_illegal. */
-    rv_op_crc32_b = 1,
-    rv_op_crc32_h = 2,
-    rv_op_crc32_w = 3,
-    rv_op_crc32_d = 4,
-    rv_op_crc32c_b = 5,
-    rv_op_crc32c_h = 6,
-    rv_op_crc32c_w = 7,
-    rv_op_crc32c_d = 8,
-} rv_xlrbr_op;
-
-static const rv_opcode_data xlrbr_opcode_data[] = {
-    { "illegal", rv_codec_illegal, rv_fmt_none },
-    { "crc32.b", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32.h", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32.w", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32.d", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32c.b", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32c.h", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32c.w", rv_codec_r, rv_fmt_rd_rs1 },
-    { "crc32c.d", rv_codec_r, rv_fmt_rd_rs1 },
-};
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
+#include "riscv-xlrbr-op.c.inc"
+#undef OP
 
 const rv_opcode_data *decode_xlrbr(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch ((inst >> 0) & 0b1111111) {
     case 0b0010011:
@@ -47,34 +25,26 @@ const rv_opcode_data *decode_xlrbr(rv_decode *dec, rv_isa isa)
         case 0b001:
             switch ((inst >> 20 & 0b111111111111)) {
             case 0b011000010000:
-                op = rv_op_crc32_b;
-                break;
+                return &op_crc32_b;
             case 0b011000010001:
-                op = rv_op_crc32_h;
-                break;
+                return &op_crc32_h;
             case 0b011000010010:
-                op = rv_op_crc32_w;
-                break;
+                return &op_crc32_w;
             case 0b011000010011:
-                op = rv_op_crc32_d;
-                break;
+                return &op_crc32_d;
             case 0b011000011000:
-                op = rv_op_crc32c_b;
-                break;
+                return &op_crc32c_b;
             case 0b011000011001:
-                op = rv_op_crc32c_h;
-                break;
+                return &op_crc32c_h;
             case 0b011000011010:
-                op = rv_op_crc32c_w;
-                break;
+                return &op_crc32c_w;
             case 0b011000011011:
-                op = rv_op_crc32c_d;
-                break;
+                return &op_crc32c_d;
             }
             break;
         }
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &xlrbr_opcode_data[op];
+    return NULL;
 }
diff --git a/disas/riscv-xlrbr-op.c.inc b/disas/riscv-xlrbr-op.c.inc
new file mode 100644
index 0000000000..57add37c24
--- /dev/null
+++ b/disas/riscv-xlrbr-op.c.inc
@@ -0,0 +1,8 @@
+OP(crc32_b, "crc32.b", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32_h, "crc32.h", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32_w, "crc32.w", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32_d, "crc32.d", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32c_b, "crc32c.b", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32c_h, "crc32c.h", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32c_w, "crc32c.w", rv_codec_r, rv_fmt_rd_rs1)
+OP(crc32c_d, "crc32c.d", rv_codec_r, rv_fmt_rd_rs1)
-- 
2.43.0


