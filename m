Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0248DE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XD-000749-5C; Fri, 13 Dec 2024 12:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X5-0006zX-Hd
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X1-0001Uz-SH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:54 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so13676895e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111170; x=1734715970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BZjeQ+Sa4YO/ce7b2afs7u8lMwFiQyyn1m0P7q0dhTc=;
 b=o3AA/S2NxWnPWvPx0RMFuPAgiPywv72pDx1YY5iR99+33d6VYj+i5mfU0bMP8uxUcr
 r6lcIB4yQyKedzXOnWijNF3O4+oVGn6zixxaR9U2c88JXhRPy4kH4luz9oSKkz7GQBrp
 uUR0N+/FigqOVpeF4pY41FRQMVywY6dMwkoaSnLxSM1qIfblkrMzzgk+BpEKRaelH8sN
 FwG++hYscls2jTiAzgp8BJfv7cerv7GFZIltDLQx3drKMXTWYH8+Z3lpPyA9ytKersRw
 sTHtvhGxDxkSFqg7oAzNmMgHmAx5Owu7EOUmbUySGNUQLAOBV+clKF+TuaO9yWCvFhff
 UNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111170; x=1734715970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZjeQ+Sa4YO/ce7b2afs7u8lMwFiQyyn1m0P7q0dhTc=;
 b=jOoHjEsSKHnUEIw3iqA9Rho/sdbHguNUwKgiqQjbakq8S7ckYN/yjYLPyhiu4PHRKG
 R1Lj9QWuOT2mSHFN0rY4/LqlzItpdx5ySZ8em6bXxdys3+TKHOsOKCPdZMTy3fO+DzfB
 NFr8x1g+Op3IgsTrqnvDk2oaZCrrze+xUvPCXvba82oaqAostKjEplaeDTP9Lqb40A6k
 aHn857jfDYB+XzMvVZxK9KpEObfSwuFVfqNQCCl39nv8U0eYsRli6jIWkk+dvOxE2ngx
 GcoO2oErp1gqP84huxKQfKRSxeON4X1yF+SM+jU8nYdMm76+OXs04Ejz7tG3kQo4aeB0
 YMmw==
X-Gm-Message-State: AOJu0YzzpN2ZzrJGrX8zEjVbJksd7uyVAQNRj3mJvXTA/xvkEf8+pSmE
 QcbjJjcDWmCjHzeoExO7mdw3iFko0Sxv6EChIber3ZCBpUK1FrNK2wCKc9Awnd/8aC1Cg4PpuDV
 /
X-Gm-Gg: ASbGncsZZE1WUGrAuwv7yQHPBVOkUx4o7YHsmxj+ZNyFAfmvMCqxrgyHjEP4NiUYktv
 bEqjfMSbsEyqM44c91b47xFT9WP4ckC5FEO72ryGduuNfcyFm5UIMGq/+tK+9N7U4JgM05owcGp
 wy4dckDk5OT3/Qf2qds2wNCD6Pt42I4t6X8eXsvAkQL6a3ziWew5ylW+z/ubzjVpipHzbu+YxdH
 C7jduWJup0ByklUoLpPiNwgV3JrxVr2IhbhI84jdASRkNSDnJLNpIxjjmHnsw==
X-Google-Smtp-Source: AGHT+IEIIBegM07MgD4yjS9MzBkPv3TlgJtVXczaIhM0jas9EQUu7TmZLiqFTgHEBTUsbzTVAV549A==
X-Received: by 2002:a5d:64a1:0:b0:385:df73:2f3a with SMTP id
 ffacd0b85a97d-38880ac7440mr2869787f8f.14.1734111169725; 
 Fri, 13 Dec 2024 09:32:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/85] target/arm: Convert SETF8, SETF16 to decodetree
Date: Fri, 13 Dec 2024 17:31:21 +0000
Message-Id: <20241213173229.3308926-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 +++
 target/arm/tcg/translate-a64.c | 48 +++++-----------------------------
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 454494742e6..ae2c6831d77 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1af41e22eb5..774689641d0 100644
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
-- 
2.34.1


