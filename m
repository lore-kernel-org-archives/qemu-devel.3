Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EB5C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pn-0002s0-0J; Mon, 17 Feb 2025 14:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p8-0001yi-8S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p3-0008Pw-Q4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:33 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f61b01630so88174135ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820625; x=1740425425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjENz02CQDbkRalonzQouff56ChSpitsxbPWI9dSHgw=;
 b=OQ1a7Q6V1Lympu55ysWJG1Ycx5JKZ16BaQyQiuRPjjuasA4ZRJQmydnwLWvZliPamA
 iaCAs/s1e6CMG0URG4Yxhmq/AiNGA0XGsIlj5Bi43jzw+0tMFBk8R35YcguSkZc19zOq
 zLLw0SvbS5X/gQJQ7B/GQR9sentgPN743jy+/I1u97idk55wEYDD9dkMw2XUP2zdT561
 hVxwqzdyJqv0aLfpTIZLrl0ZLqhKnz7kIblr/4qWGCDnWiwkXDaDXJaIz/VWDRzx6XEm
 Y/Rrs1DRPfNM86LnOD05T7y2j5iqwGp3i5pN0eZo5nAwg8eXSodFbwrJJaTcP3ws8rSr
 j53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820625; x=1740425425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjENz02CQDbkRalonzQouff56ChSpitsxbPWI9dSHgw=;
 b=Y8257M0kb2Ynlr3ksSKkLYeWqvQtn72bLNn0W6CCk97F4/CKZHErWNVUM2Rl4J+Ciz
 2xOF4C+RjZedlOJQ7EAaQo5D3rP7dTvaD41lX+meHmDJi2v3+N14a/bEnQ6Fn8qpd0PF
 FcMZXsbHS0cJy2rE4i3XzF7LEiIyDODs7r+ZwXgkKY3af7XYFBuPiPhVbLQIvP7akWZI
 1B/uJokdQ04B1FvaLKp6d0lFyTJGs0mjrsj1WDvRpXy3BMTaAB0+OhE8DL8RHPothZ+S
 5ltPPCrjWrYV4SbR1A8CDV0gROyAf3lLFqjKQibFg8GV9dLnqqvRn+6MAB49apxUWqZG
 LXCw==
X-Gm-Message-State: AOJu0YwD4cbDgsEc/KJXr8hWbHXlvJGerD1hjL4xdh16s6aarsonuukO
 52DxAV4i/RAWOmHkM9QtW0d8Lo/sU+Qdjgv/bdA2YwyypYLFPvNJU5su0VZf8S3qkGi+Nz89h5P
 A
X-Gm-Gg: ASbGncuJY7jnl2YFpAMF2hjhzRO9hsHbbUYLQ7uV/JMjTRgvy3XSEmUG95+Tviyk46z
 1ggSY/IiYlKZH+ZWPyxKrD+BVZwm288VNntCXOOLVu+llSirQjEu1BOsMdJ1qFzU9Zzf57QHAK4
 NZk8T39jkvNY5YprtGVuTWQFsPk1sgd1vVaPv1Fvz1XsaoGdiEQoMxwcyf4FQERg+gFAG+0Ms2s
 vdIsKMgEM/JN/TTCPKer6R0awQaDayQB0pDNToBUlLquQFa0vKn0XqbO1L5t2ElIuzbuoYs0wN+
 rJcbHTXAFEMdBfNOQFzUJpivJaazZuQKV/oapA8Zu1oFHlg=
X-Google-Smtp-Source: AGHT+IHF+Bg91LYFxKdxAWg+USY4sWdCEAGeSuriG0MEuZipz9Bxms2gNc9piahmjjROO/CM1L7GTA==
X-Received: by 2002:a05:6a20:2584:b0:1e1:a449:ff71 with SMTP id
 adf61e73a8af0-1ee8d67ef96mr16738432637.1.1739820625376; 
 Mon, 17 Feb 2025 11:30:25 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 18/27] tcg/mips: Use 'z' constraint
Date: Mon, 17 Feb 2025 11:29:59 -0800
Message-ID: <20250217193009.2873875-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Replace target-specific 'Z' with generic 'z'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-con-set.h | 26 ++++++++++-----------
 tcg/mips/tcg-target-con-str.h |  1 -
 tcg/mips/tcg-target.c.inc     | 44 ++++++++++++++---------------------
 3 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 864034f468..06ab04cc4d 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -10,24 +10,24 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rZ)
-C_O0_I3(rZ, r, r)
-C_O0_I3(rZ, rZ, r)
-C_O0_I4(rZ, rZ, rZ, rZ)
-C_O0_I4(rZ, rZ, r, r)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rz)
+C_O0_I3(rz, r, r)
+C_O0_I3(rz, rz, r)
+C_O0_I4(rz, rz, rz, rz)
+C_O0_I4(rz, rz, r, r)
 C_O1_I1(r, r)
-C_O1_I2(r, 0, rZ)
+C_O1_I2(r, 0, rz)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rJ)
-C_O1_I2(r, r, rWZ)
-C_O1_I2(r, rZ, rN)
-C_O1_I2(r, rZ, rZ)
-C_O1_I4(r, rZ, rZ, rZ, 0)
-C_O1_I4(r, rZ, rZ, rZ, rZ)
+C_O1_I2(r, r, rzW)
+C_O1_I2(r, rz, rN)
+C_O1_I2(r, rz, rz)
+C_O1_I4(r, rz, rz, rz, 0)
+C_O1_I4(r, rz, rz, rz, rz)
 C_O2_I1(r, r, r)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rZ, rZ, rN, rN)
+C_O2_I4(r, r, rz, rz, rN, rN)
diff --git a/tcg/mips/tcg-target-con-str.h b/tcg/mips/tcg-target-con-str.h
index 413c280a7a..dfe2b156df 100644
--- a/tcg/mips/tcg-target-con-str.h
+++ b/tcg/mips/tcg-target-con-str.h
@@ -19,4 +19,3 @@ CONST('J', TCG_CT_CONST_S16)
 CONST('K', TCG_CT_CONST_P2M1)
 CONST('N', TCG_CT_CONST_N16)
 CONST('W', TCG_CT_CONST_WSZ)
-CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 14b3cb1eba..f8c105ba37 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -184,12 +184,11 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     g_assert_not_reached();
 }
 
-#define TCG_CT_CONST_ZERO 0x100
-#define TCG_CT_CONST_U16  0x200    /* Unsigned 16-bit: 0 - 0xffff.  */
-#define TCG_CT_CONST_S16  0x400    /* Signed 16-bit: -32768 - 32767 */
-#define TCG_CT_CONST_P2M1 0x800    /* Power of 2 minus 1.  */
-#define TCG_CT_CONST_N16  0x1000   /* "Negatable" 16-bit: -32767 - 32767 */
-#define TCG_CT_CONST_WSZ  0x2000   /* word size */
+#define TCG_CT_CONST_U16  0x100    /* Unsigned 16-bit: 0 - 0xffff.  */
+#define TCG_CT_CONST_S16  0x200    /* Signed 16-bit: -32768 - 32767 */
+#define TCG_CT_CONST_P2M1 0x400    /* Power of 2 minus 1.  */
+#define TCG_CT_CONST_N16  0x800    /* "Negatable" 16-bit: -32767 - 32767 */
+#define TCG_CT_CONST_WSZ  0x1000   /* word size */
 
 #define ALL_GENERAL_REGS  0xffffffffu
 
@@ -204,8 +203,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
 {
     if (ct & TCG_CT_CONST) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
     } else if ((ct & TCG_CT_CONST_U16) && val == (uint16_t)val) {
         return 1;
     } else if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
@@ -1666,11 +1663,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a0, a1, a2;
     int c2;
 
-    /*
-     * Note that many operands use the constraint set "rZ".
-     * We make use of the fact that 0 is the ZERO register,
-     * and hence such cases need not check for const_args.
-     */
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
@@ -2181,14 +2173,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
         return C_O1_I2(r, r, rJ);
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
+        return C_O1_I2(r, rz, rN);
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
@@ -2207,7 +2199,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_remu_i64:
     case INDEX_op_nor_i64:
     case INDEX_op_setcond_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
     case INDEX_op_muls2_i32:
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i64:
@@ -2234,35 +2226,35 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I2(r, r, ri);
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-        return C_O1_I2(r, r, rWZ);
+        return C_O1_I2(r, r, rzW);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return C_O1_I2(r, 0, rZ);
+        return C_O1_I2(r, 0, rz);
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rZ);
+        return C_O0_I2(rz, rz);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return (use_mips32r6_instructions
-                ? C_O1_I4(r, rZ, rZ, rZ, rZ)
-                : C_O1_I4(r, rZ, rZ, rZ, 0));
+                ? C_O1_I4(r, rz, rz, rz, rz)
+                : C_O1_I4(r, rz, rz, rz, 0));
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rZ, rZ, rN, rN);
+        return C_O2_I4(r, r, rz, rz, rN, rN);
     case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, rZ, rZ, rZ, rZ);
+        return C_O1_I4(r, rz, rz, rz, rz);
     case INDEX_op_brcond2_i32:
-        return C_O0_I4(rZ, rZ, rZ, rZ);
+        return C_O0_I4(rz, rz, rz, rz);
 
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_st_i32:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
     case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
     case INDEX_op_qemu_st_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rZ, r) : C_O0_I3(rZ, rZ, r);
+        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rz, r) : C_O0_I3(rz, rz, r);
 
     default:
         return C_NotImplemented;
-- 
2.43.0


