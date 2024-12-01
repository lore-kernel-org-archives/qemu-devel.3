Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76138D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWx-0001RJ-Dp; Sun, 01 Dec 2024 10:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWq-0001LT-3q
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:32 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWo-0004BZ-C4
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:31 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea32c929a3so1253904b6e.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065589; x=1733670389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mk386zyYcjzu1bF2Iqtv5npSyynpiSfA5YWKFkwiSAw=;
 b=b3yWO/Zdpb6AJip+OWFUPFr08rtqtOpI6SAJhFqxnwj7oeJQdsoXVEFaH549uw/RSc
 tH6jCalKqZoh/UftxR0r9C00XSt41oU8zAd8zUFp1qeIh87IkcBk6ZKt2NGCzuIjZFVM
 DCFED/9DIPohxcw20jBRXnUS3RlWCJdX9pYUVYM/cZevH/sukQJwcPlQ+iiUggjc8nBl
 L92ibCeYbOQKd3Az5zc+QNkzo8P542xmlZW2axNPl+zuOif/sbJjy9hS6+MryZRAp+87
 sp2YCf1JMQonxzSrx6gROB4Bdav06piz4eoGCDt/X5p6+J5gIOiMFJ3DH/nJEA2Ch5+s
 /gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065589; x=1733670389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mk386zyYcjzu1bF2Iqtv5npSyynpiSfA5YWKFkwiSAw=;
 b=Y99uyaIIlz7CJrHyI6uKtaxmB7DXBAjS0dD8rIynn3GPI9elpLOMH1tcKT9tPZ4XAq
 mAXnblsYr6NRdlAqYqKQLCwXixJnBkmsKwkXsb3rte4FifRcnQdB26pHw+hPj2D0ZgVB
 zFNGm4FpC60lL14Fix013vNnIbUA08YWG3UPDbSYh/WWGKlvz4QUCJxUHMQNTMmbL3kT
 p8RbBJiQ7GwquvEHoQdj982eDAm8cNwMEfMRDkU8KQIRZnWlrDUMVNJizjV3SK6M0fWl
 rwLcI3v8khmszB5AlAe4Pz7Y9tSfKBJnKrULnEUr907aJOy87VHbyfDJ7LbLDRi1Z6hb
 0Y1g==
X-Gm-Message-State: AOJu0YycfDhboy+ltxIYUOj21Gr7Wn/RjigvzLI3MF2Dofco9LIMJBG+
 ezxaZnhjyjM/D+PuvZ22JdUEpJ9WBUYpyp6WEsDVSgzF53+3/kCqyNH8vNzi1SseNkYu9AMDap9
 1OKk=
X-Gm-Gg: ASbGncvl9xx3IhSsLeiky3cJsIr5uRqTtgIV/+sxkvCzAj0QANnDNm+Dz6HzrcfIXy7
 l56+RqK+lC78/tTdyN7H6uLt0FnreNkarlgDi2Cg3xox/eTkJJpnfkVJ1dR7b48x/IKmwTjyDdz
 dOYsd9qC97udJg31Dai4ty9lud7469cYIZzyE17pmOMjI+Rz7u6DxvdIFKoeP5/iAWFPh4ruL7P
 37WZwvQpI8+cebbKw7LOokxzXN3gwIQqFCIapcLdbc//tpJaf15q7WMvv0K5DWumcifDlMeYPrF
 W6jeHD4d5EWhBwzGurBERbWxjGbNYgPbTKe5
X-Google-Smtp-Source: AGHT+IFgySye0stE0oK2qpqc8D4oeTbWlsyMyz8J/Bfvny4c6HGWvCcjSXmeY9D350JyUoHhH/B21A==
X-Received: by 2002:a05:6808:1455:b0:3ea:5705:2a28 with SMTP id
 5614622812f47-3ea6dd9ca93mr14379495b6e.36.1733065589204; 
 Sun, 01 Dec 2024 07:06:29 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/67] target/arm: Convert SETF8, SETF16 to decodetree
Date: Sun,  1 Dec 2024 09:05:16 -0600
Message-ID: <20241201150607.12812-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 48 +++++-----------------------------
 target/arm/tcg/a64.decode      |  4 +++
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1af41e22eb..774689641d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8077,38 +8077,21 @@ static bool trans_RMIF(DisasContext *s, arg_RMIF *a)
     return true;
 }
 
-/*
- * Evaluate into flags
- *  31 30 29                21        15   14        10      5  4      0
- * +--+--+--+-----------------+---------+----+---------+------+--+------+
- * |sf|op| S| 1 1 0 1 0 0 0 0 | opcode2 | sz | 0 0 1 0 |  Rn  |o3| mask |
- * +--+--+--+-----------------+---------+----+---------+------+--+------+
- */
-static void disas_evaluate_into_flags(DisasContext *s, uint32_t insn)
+static bool do_setf(DisasContext *s, int rn, int shift)
 {
-    int o3_mask = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int o2 = extract32(insn, 15, 6);
-    int sz = extract32(insn, 14, 1);
-    int sf_op_s = extract32(insn, 29, 3);
-    TCGv_i32 tmp;
-    int shift;
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    if (sf_op_s != 1 || o2 != 0 || o3_mask != 0xd ||
-        !dc_isar_feature(aa64_condm_4, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-    shift = sz ? 16 : 24;  /* SETF16 or SETF8 */
-
-    tmp = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(tmp, cpu_reg(s, rn));
     tcg_gen_shli_i32(cpu_NF, tmp, shift);
     tcg_gen_shli_i32(cpu_VF, tmp, shift - 1);
     tcg_gen_mov_i32(cpu_ZF, cpu_NF);
     tcg_gen_xor_i32(cpu_VF, cpu_VF, cpu_NF);
+    return true;
 }
 
+TRANS_FEAT(SETF8, aa64_condm_4, do_setf, a->rn, 24)
+TRANS_FEAT(SETF16, aa64_condm_4, do_setf, a->rn, 16)
+
 /* Conditional compare (immediate / register)
  *  31 30 29 28 27 26 25 24 23 22 21  20    16 15  12  11  10  9   5  4 3   0
  * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
@@ -8277,30 +8260,12 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 {
     int op1 = extract32(insn, 28, 1);
     int op2 = extract32(insn, 21, 4);
-    int op3 = extract32(insn, 10, 6);
 
     if (!op1) {
         goto do_unallocated;
     }
 
     switch (op2) {
-    case 0x0:
-        switch (op3) {
-        case 0x02: /* Evaluate into flags */
-        case 0x12:
-        case 0x22:
-        case 0x32:
-            disas_evaluate_into_flags(s, insn);
-            break;
-
-        default:
-        case 0x00: /* Add/subtract (with carry) */
-        case 0x01: /* Rotate right into flags */
-        case 0x21:
-            goto do_unallocated;
-        }
-        break;
-
     case 0x2: /* Conditional compare */
         disas_cc(s, insn); /* both imm and reg forms */
         break;
@@ -8311,6 +8276,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 
     default:
     do_unallocated:
+    case 0x0:
     case 0x6: /* Data-processing */
     case 0x8 ... 0xf: /* (3 source) */
         unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d13983dffe..1228c41679 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -757,6 +757,10 @@ SBCS            . 11 11010000 ..... 000000 ..... .....  @rrr_sf
 RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
 
 # Evaluate into flags
+
+SETF8           0 01 11010000 00000 000010 rn:5 01101
+SETF16          0 01 11010000 00000 010010 rn:5 01101
+
 # Conditional compare (regster)
 # Conditional compare (immediate)
 # Conditional select
-- 
2.43.0


