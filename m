Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C42C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjv-0002Db-8l; Wed, 19 Aug 2026 23:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjt-00027F-UO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjr-00046W-U8
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so1709148b3a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197606; x=1787802406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjyHLAWuHJgJ/+lIjyXwN6xYrYB6otvsADCyVj8AJtU=;
 b=ZVeatdPqflWZzDjScIfs+X5cQfemFnFL5YHF+Ase7KbLCCYnz64sj3Guo+JQMgZB6D
 j9URtZx5zYaXMKW3+89kurparuhbWPAoSfUpRf4SomAG7CqBFXUmXDD4FKBJHcSoqmHK
 SdNV3MmonGUP0OZ/CF4tuOQCiYBktNekEkQK6pHTcU2GVwlj3cg19Ny2eBo6iDqfE6TZ
 zB2TaTV5X5xad8gqLVSdLnB5DJGLVdakLOzi7gRErMKRS4LgGwhKVN+uUSAzeLxoU3dN
 dejjVEIJ/4WQhH+59zJm1N7b4GddPgqj5hRVU2MfztyA9CfB0IUQjV2crm9rEqHM2nqx
 v8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197606; x=1787802406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjyHLAWuHJgJ/+lIjyXwN6xYrYB6otvsADCyVj8AJtU=;
 b=IRooPZL+xoAe5MeWmwxxnHSsGr3EbL/WepMEQ2AKULKoJCs1UE1c1SDiiilkht5cYV
 n99heSa+A9NK/s/XxgaxIrCrCvugY8a8Jb2Q4zGoZLZSjq3h8joYDGUkTw80QtWbgH9k
 dvJcvwn0ejxtv1hw4whbn/CwdP49/QuTKU0RvgHdpK3cNXLILlE92VtrT7ZIVDDUvANi
 yrZ6O2uwfoa3v9vrNaXcLQ/Ynz5OJl5J4mgfsBl9vjUHncI1+7r5gTtlX7MUVsaR20Ey
 Yc6RwZsvQOeZe3vlwGd855WU2kdMgxfrD+TPeSeh5+mbU01y+ozaRFXiZPdUGxQSvdkN
 Hr5g==
X-Gm-Message-State: AOJu0YzYTWS7Js3BKT4kmwiYJGGa2fIFLsefB+cl2/SGC9uZNdYN2B/1
 +gVasQPDcZdYZbHvJoma7GuUzwyNWCFYPNc+3e/tSdbJMN4HpRI58xzYWINCYw==
X-Gm-Gg: AR+sD13YTV0fIIcWDfC+bcxP3j6ymt2CYFbj8uUNiMMynSFFkBhLt2+KFrCnnn1CzF9
 4BEvpKli5LYOlaaKmFy8TqJQY3mmN0+poErRu+hV1f/hToD3sX/E6FiSVF7VVc7RCCi39j8Ykd4
 CzHR0mz3fVq27xycHMYUQF+X6cJSTaiyBOleBh0IVmuPwQW0Nb//NeBVUdSqZo+GNrl35D7hTUW
 +yf+xDSMb7xczpCAZvbWfHOQGRCBP/UT8PM7xYRiv6lEFlTnq8MeWQY9+ebTiKhTgaXF/dc13gc
 xeP1pjAE2cEPAUcEFt7EakzqoVgQ+BAcFucM6rteRWgBSwuE5ne0FdJFcTSaDLtClFW8wDRh7le
 ryxT6l3D7pJYXBhm3mSE/XAUrtqD5UTPk6AgpkV52SzJxzS+u29rF+mORqf++sNBwuA8Tt1js9w
 LE8qlVShnTN/1hYr+RvgSPFuPx6d5dyZxT+a7ETs6i/pl5WxMK0RVfxwLaH8zbjLTV6ROWy4b8k
 a0hog==
X-Received: by 2002:a05:6a21:748e:b0:3c4:1493:6822 with SMTP id
 adf61e73a8af0-3cd0127962amr20225420637.18.1787197606396; 
 Wed, 19 Aug 2026 20:46:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/93] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_decompress
Date: Thu, 20 Aug 2026 13:43:38 +1000
Message-ID: <20260820034430.1186695-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

Unify 4 functions, sharing code.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-6-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 70 ++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index af43940732..47fae7316c 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5377,64 +5377,36 @@ static void decode_inst_lift_pseudo(rv_decode *dec)
 
 /* decompress instruction */
 
-static void decode_inst_decompress_rv32(rv_decode *dec)
+static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
+                                                    const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    int decomp_op = opcode_data[dec->op].decomp_rv32;
-    if (decomp_op != rv_op_illegal) {
-        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
-            && dec->imm == 0) {
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-            dec->codec = opcode_data[decomp_op].codec;
-        }
-    }
-}
-
-static void decode_inst_decompress_rv64(rv_decode *dec)
-{
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    int decomp_op = opcode_data[dec->op].decomp_rv64;
-    if (decomp_op != rv_op_illegal) {
-        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
-            && dec->imm == 0) {
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-            dec->codec = opcode_data[decomp_op].codec;
-        }
-    }
-}
+    int decomp_op;
 
-static void decode_inst_decompress_rv128(rv_decode *dec)
-{
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    int decomp_op = opcode_data[dec->op].decomp_rv128;
-    if (decomp_op != rv_op_illegal) {
-        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
-            && dec->imm == 0) {
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-            dec->codec = opcode_data[decomp_op].codec;
-        }
-    }
-}
-
-static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
-{
     switch (isa) {
     case rv32:
-        decode_inst_decompress_rv32(dec);
+        decomp_op = op->decomp_rv32;
         break;
     case rv64:
-        decode_inst_decompress_rv64(dec);
+        decomp_op = op->decomp_rv64;
         break;
     case rv128:
-        decode_inst_decompress_rv128(dec);
+        decomp_op = op->decomp_rv128;
         break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (decomp_op != rv_op_illegal) {
+        if ((op->decomp_data & rvcd_imm_nz) && dec->imm == 0) {
+            dec->opcode_data = rvi_opcode_data;
+            dec->op = rv_op_illegal;
+        } else {
+            dec->op = decomp_op;
+        }
+        op = &dec->opcode_data[decomp_op];
+        dec->codec = op->codec;
     }
+    return op;
 }
 
 /* disassemble instruction */
@@ -5491,7 +5463,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
 
     op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
-    decode_inst_decompress(&dec, isa);
+    op = decode_inst_decompress(&dec, isa, op);
     decode_inst_lift_pseudo(&dec);
     return format_inst(24, &dec);
 }
-- 
2.54.0


