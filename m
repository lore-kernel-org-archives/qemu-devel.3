Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00D8C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbq-0006m5-3W; Mon, 24 Aug 2026 01:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbL-00057t-HS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:07 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbJ-000337-Ng
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:07 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so4141597a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550724; x=1788155524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h2oaOCJCF/+kDDtd38kYag9b0rC6YDKI4au6Nbv4V2A=;
 b=Z7lELOj2cABIvUMO3pV7Mba66f213Mqw4dza7BQ0Ji/CuhkMBv87hhxV/wR0MFfbKM
 YCHqzy5iPGpnLMDQEpbsinGKdkG0srF5oFdRx48TxtnA86Aj09b0aL5so9z8ubkt/x7j
 W2DMbFhTUL2q2ilMzwejPVHSa0H2Y6l9SZEjGlmTxIHjmg4/jRCFXOEctSB4vGM6enIQ
 Qza59z/AcI6VA6lS6N0ohJzjQg3I37fLbPKMAktuMULoc/15NfDSU5N0uj/scy5ZkFhi
 oyQFdD2+sqPf7Z6ehCcxyPKxo23VfoZvOc9zgDJjNxMx9M1wS6Q6doACK9Y9larvxaqG
 /66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550724; x=1788155524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h2oaOCJCF/+kDDtd38kYag9b0rC6YDKI4au6Nbv4V2A=;
 b=a5oxMdOChzyua9iMRfTzMvyi5iWU2jKaX7aJF79IC5KcJeSRcbQSGYrqh27dDUcxKe
 9AzG2h58frm4m9TyF3JXzfWuCOkV6i2k53AztNw+OyqhObeRNM8RHUzruFtJ3dYhZ81r
 mj5yWwyj2D1JH5RFhx/k5rFi7mKlLB8kLaBZfM8MjxPmfIX32f0R8uD6nHcpkBEv27Wc
 +euDpxBbzjkeyr7Jp5Eu4cdAJv4xXpmzHyOeXGsIVAjfhQtzqzeK4G/jQxW+ZIMswj3+
 HH2IOavuB1EELN84GYtou6ysSeD9fyFWpBfYUpiF19FJX5X9Nk9xM6IweZi8AFsa2ZZd
 HU3A==
X-Gm-Message-State: AFuF++mYrCSHw/EXG6pUEpI63OlJtwDnnG60LBrGryIE9dP7LeBE8qoF
 /yi6RGzv7c0LyX+gKtdFb1V7zK0N+EzS0klmek2NP0WBMCXFiG3OSlRc7UsVDw==
X-Gm-Gg: AR+sD13izwA+4buVBfhtOhaXu66Zqy+bLdhdYfR7vgqWHrDcUHk+oEG5f5dWgQZUKLC
 7bSoDPHQJyZcC0v9Ad+O6MCANXIKGorb07/JC5eDqCQKyDPE8P85QLEgdlaTQp1DDP/1prtP88J
 vKmBiLyDIjdQ8YnGgqbDHQpBWTQYhMq4ldSrRW3XWSj3HJU38qiOvoQ7qwt2cWyFNsfjjwR2Acv
 lI3t+N4tqXyRcZ/JtE2a+k91zMngCeLrRLhg0Aiz92F09u1zm2i0rf59AF1olc/IR5hEvJtETvk
 GrIb3faCUHoQ4ZkHpovsNHvZkWTXzIPzgZ3YtwmHrIP5WuCXeO+Kt9+FYl50Ugoh24tIyQEfxYp
 aYQQnEZNDn7z3EgaPUtpcLyvnUpH7So65P2rEUa5Q1CvTThCIJ3AAIURz6CQDszOkic4NprfaKU
 TQk7/6+LeA4MZqwr8sg2BdtrW7IGFUmFgWLFmTFIkYfYACvnkM1COR67mZ6j8r20qw2DdUhmpQv
 Q4ohegy2Fl5JRwL
X-Received: by 2002:a17:90b:5844:b0:393:1d92:db5 with SMTP id
 98e67ed59e1d1-395c35e1199mr48956259a91.10.1787550724304; 
 Sun, 23 Aug 2026 22:52:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 75/96] disas/riscv: Split xlrbr_opcode_data
Date: Mon, 24 Aug 2026 15:47:45 +1000
Message-ID: <20260824054806.2790041-76-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the table to riscv-xlrbr-op.c.inc and massage
the lines into OP() form.  Drop illegal as unused.
Return pointers to objects directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-43-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


