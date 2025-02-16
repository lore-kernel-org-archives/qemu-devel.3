Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA974C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrv-00079L-Qi; Sun, 16 Feb 2025 18:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqE-0001FR-Sk
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:28 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqA-0005TF-La
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:26 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2211acda7f6so15109065ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747648; x=1740352448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4U1BsDfLBiaoj0WUw8YWBKHfrMBcHjD8bI0lXa+d+T8=;
 b=JmekbzvYrIrPwne9kzlFC+qg5QiPZ+MpGypIy2qrCU3Ww69lTwuFXZNFnrTInSTMKG
 MrgIL6z6cqovpsyijfUhL/Hqwa5u70QTIz5/F3ikHQbmmHExWxDgrhBZqs07mTsJx5j3
 n7Ll8ZoEeosXZaLszavPMhIhw6qfQOVHorOlDkjA5dtcpNVZ7zy+7Vh1nDHEoVnQ2jYR
 +oD118ssYbbYS4/BRuOcbsvd8kUV8nTKv4WG7cfdZCZv4xRYIj5SnFjS9eNNXK/euJQ9
 s3hZZzR+erCOgnHscgrUnDj89X7acsG7dirDNjAh1BkD+8MUZChL1ZBuXUyLWh/x2Gpx
 UKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747648; x=1740352448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4U1BsDfLBiaoj0WUw8YWBKHfrMBcHjD8bI0lXa+d+T8=;
 b=JssidkB3Jug2Kcy0m7i+9nLvY/MdVkASYGbQ4zXwmGspMQ7FJNUjGVU46S+Xtu1YJk
 /uI9oWiEaFVxRE0oUUHI9DTukQtzUFK6pwIxYgO1fyhehvHk5NnC9Rmnu0niEdKOWslT
 ni69Y16IJMvbTYoSYeH7lGJ2Redu4gGJh2yj4GUuYnfl/qXo8Y4KUIcH3ALOSnoSpEHL
 vo8QWIKsGVRYNDCjyOZJTaLtkGfLfqOWKKSDyhgNzhkW08AinZcUNmKa2bRt/07Q0XLe
 qgYQqUgB8uiZg3ZtER/4u7CkLCfleRVRG7fuYAwg+qJJU2Cm5sspE33xTBehpdgEKand
 UxaQ==
X-Gm-Message-State: AOJu0YyWy3b+fFVUIjqLNsF2tOzEl0IldzYDmpzGTuwU8AgtOuBj6pKW
 rjT8Ts9TNqahNzPQOy46AQLZ/wPWRSlgmt4xsmRKb5nhrRpDQiEPOmV5ExWZ3fuK5VxXo2n1WXP
 T
X-Gm-Gg: ASbGncuFHq16RmnE4DB5PTpuM7wPKLpozX62PM0AJZtffP7TBFnQJl1fryE5G/iaVLU
 UT/Dgmr2tJOEHJZ65v9H5A/YBidJjKqKPagRDArmeVV9uaZ6Jrvf2L37TvpjQQi3qYOzZGtN15X
 pFGeL3sUSR6pcMwt4B+wxmZ24ISG3KRrzn3lBLQq554U7flu91S6SitC9HcgFZZuShCcU5bPZWH
 2hauCnFAHCypRUWC7lzS4FRDa0Vu24oKRGsYzl9cxZ5xVbAiB22ZKiCM5TjzaVXG00LMh1qiB+f
 08zzJNneT4+xAzD3IW6LN/UoVqfseB1NP0cT5CHsnjBia00=
X-Google-Smtp-Source: AGHT+IHRKHjGBRkS2XDqAnP8vhzI5SpStEHn2OaThQvUdpgo0JjLfI8d8eLgxAYOYShlNZ7osAN1yg==
X-Received: by 2002:a17:903:2cb:b0:221:263:230 with SMTP id
 d9443c01a7336-2210408cdb8mr127881655ad.32.1739747647869; 
 Sun, 16 Feb 2025 15:14:07 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 072/162] tcg/mips: Support negsetcond
Date: Sun, 16 Feb 2025 15:08:41 -0800
Message-ID: <20250216231012.2808572-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-has.h |  4 ++--
 tcg/mips/tcg-target.c.inc | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 05701fd228..c77d4296cf 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -41,7 +41,7 @@ extern bool use_mips32r2_instructions;
 /* optional instructions */
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
@@ -51,7 +51,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #endif
 
 /* optional instructions detected at runtime */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 94e79c13e5..f6593b2627 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -959,6 +959,25 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
     tcg_out_setcond_end(s, ret, tmpflags);
 }
 
+static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
+                               TCGReg arg1, TCGReg arg2)
+{
+    int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2);
+    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
+
+    /* If intermediate result is zero/non-zero: test != 0. */
+    if (tmpflags & SETCOND_NEZ) {
+        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
+        tmp = ret;
+    }
+    /* Produce the 0/-1 result. */
+    if (tmpflags & SETCOND_INV) {
+        tcg_out_opc_imm(s, OPC_ADDIU, ret, tmp, -1);
+    } else {
+        tcg_out_opc_reg(s, OPC_SUBU, ret, TCG_REG_ZERO, tmp);
+    }
+}
+
 static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
                            TCGReg arg2, TCGLabel *l)
 {
@@ -2276,6 +2295,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_setcond_i64:
         tcg_out_setcond(s, args[3], a0, a1, a2);
         break;
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        tcg_out_negsetcond(s, args[3], a0, a1, a2);
+        break;
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
@@ -2370,6 +2393,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, rz, rz);
 
     case INDEX_op_deposit_i32:
-- 
2.43.0


