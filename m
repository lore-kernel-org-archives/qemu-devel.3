Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8C1C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7h-0000lp-1W; Sun, 09 Aug 2026 18:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7f-0000kA-CU
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:03 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7d-0007Jj-8F
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:03 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso1099030b3a.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314960; x=1786919760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uxmlZCK7DL17d4NutzDtlfNr/qFd5kbUmapKHvQVXXc=;
 b=WWcFLqra8Twumg/KnNZiKz6pECCd9VR1GpPG013uEf3uIvQL6/nBuKe8AxJWimjVpo
 YqeG0tTeKlwiDg3pHg+EuTKPDesTNcRxJyO3ckrjw/F3oY+rTq9h/ouhDIjeLnVIJ80q
 MLel3y/5U3dnVDjmz5QxfXrzq6AxPeXLPBrQkyi5CQhmjXNuQYzl+LYaOMKbGvAQGuh3
 5ec6UMyMumagTOYUu1H23WOrUOVfh4vH3zzKs54vcTl34L5iI13wqerWd82eQrZ58yX5
 sNmglxa+KraxbyQ6mgCuYP9aQ9DPSMoV0gvFA+FnXunxHA+KBxjvPOpoz2qqa8ACgWC7
 xvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314960; x=1786919760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uxmlZCK7DL17d4NutzDtlfNr/qFd5kbUmapKHvQVXXc=;
 b=kY1az3kZmgIMds46t+lxX2unYSOB4+bsMZAirG/WY0JUgc2FXG45rtMN0gpiTWZxN+
 KW7jWu2u5EJUG9GJqsR+Y2qtU0S41mFrrBttxZEcEjWJsaZUgP/20/T5A65NjwAFg/k9
 pQ7SUgHIkTCqTR/+aWayJvP9CMFgXT/SULcyvU+e5LadYz+1oB3tE17zsP29+qa9s6TK
 vvHikrx1XF5FYtvh0ZlL3b4YiTRZDu5wbBy+UIRhZBKMEAvFwnymFXaNuoFY2AmiMD9W
 fMfbVjvg0844S7GX9ngqlZbpPM8SVTPuB8Nz/aNd+Noy5SST1ERuIrGrtQzIfcaLQwVK
 sJRQ==
X-Gm-Message-State: AOJu0Yy0974X/qG3kTBz8Au2Wi9iFhDqqMjhp5vIQRDoFtKbx9HAEhNg
 e9O2194Sy7uF/43q4IriDpXWhixNRok37oZ+w0JuqkjNw5NI3jBz8S3KQrKDzzdxa3+i6+lVrDU
 zta45
X-Gm-Gg: AR+sD114N3S60svNWfr65dc+TEfnYqJvt7jHUPYjLw2H/6059lI6r3/Pk14dDC+noUF
 lAtdL0x6YH30BHZ4OHyZLp4jDAujWubNQRMzpM6q5Z7p2KUKnCkWEcO2PyQxH0XR9FhstM8dtUU
 LDvZN6/DDPVdcYUtfmJp1v0li1vEQQ0/zBWYFji39nTTm+0zTgeIorx6JZqmFLQxRQvnVvO+Yli
 I6Ftl+EuuwMAoqQ9int18XLfppLDMrFFQpW/AASjk+3OPmy68sxB+UcVaAieszYybME94c9k+u8
 Ape4HjLcJPsOPy09cguE54ElhEMvgkq1EhMW/39hUmhVzvC7oLLH9o/sh6OeoF+DxxeQ4agUdd4
 DCSr/fHzketKh+BIPiNy6wz4WiKlUz0enEhZ546zrSJHDdzue8kBLrsje7CckUgw/XqafB+Kz+8
 D4BI6To5eiLTD7uN7b2deQQC4xwpaHeMxeIsbkeBZHvShadZKcWIjX8zRanJS0epjEn5Lu+/ueO
 EmbIrsHt/y+jKsEYlJb
X-Received: by 2002:a05:6a00:4106:b0:837:f111:b70 with SMTP id
 d2e1a72fcca58-84f6b649b12mr15308396b3a.4.1786314959792; 
 Sun, 09 Aug 2026 15:35:59 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:35:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 10/56] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_decompress
Date: Sun,  9 Aug 2026 15:34:59 -0700
Message-ID: <20260809223545.730664-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Unify 4 functions, sharing code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
+    int decomp_op;
 
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
-
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
     }
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
+    }
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
2.43.0


