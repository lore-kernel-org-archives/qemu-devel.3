Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD443C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4q-0003sv-31; Fri, 25 Apr 2025 17:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4U-0002JY-H7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4S-0000tf-4z
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2264aefc45dso44703715ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618334; x=1746223134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0mMSKoweSAaNo+GxcEpawHH1VCi1NutdnUUHTtp4Ek=;
 b=mliS+Rh3dTRccuPK2RMarOmdactBL9y/nSc46sYf6LLVwTOpWrOLGH5Fbv72gJ+5Tg
 AEEhqXOqbIjDutdxvWBEgvbBYQmO98bppKOEMA1wyZFmWOZOdds7Mcs2ZI0K5z3dn/Cv
 B3gYDdP78cbSqVExFtH1kZHO/pXVeZk8x82q4GFVaQphbL5Om16MsJA6Qi18cS3o6+sH
 +VEnhEdW2+qtmIeQni6RWaI8Fc5JthZxTKqnrDqBkJEmr7eJ4MY39MM7pNDuyPKD4FHZ
 2WHRZ/B6AW6/Uem22GYUA1Vwfgjuv6W7mj9Ui1mHTyVmqaF82yYCv2oA+W3f7YDY8Oju
 gFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618334; x=1746223134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0mMSKoweSAaNo+GxcEpawHH1VCi1NutdnUUHTtp4Ek=;
 b=bLDmWUeJgv/OUJh+mTLuZp8hJgvOCHZ9M9S39nqgfC8zTd/QEASov8TpskfDpoYXhW
 bA1EqVjsSilxiA7eOBCW1qmYcKL17rGj7hxgGJGlRBA3/JZlLoxubsIiK16TcNslGXsP
 2ML+Q0wubHrGyi52YZbAkcqXvoaJnMlZ1EaXIPt2fG7ThkXJIQBXDD3YOJi9ZnBYNVMV
 uRztG/sClyLmu+aO6Wjnv5ATVm//eVPA23sWqIH0bo19ZPABQClbTGhkZwrW52fHL4Nv
 ylrUpvIR9jj7S/Ij07e/eYZ1hih5Zq2VSKlymTRVrKtBYAoZQTX+RaNyMC6/59NCCosi
 iOjQ==
X-Gm-Message-State: AOJu0Ywjcgmrn0o7I6NLLMqA81WqHOtC+bN8LSuJz1P1zHxXw4eTNG8l
 sbyrlDlKOeQoF9O0kwz2wnpZcnOIOqfId5FdlCXzelJPyoSPBQPGVb0BXNiQieYrYLrBLzseDV/
 V
X-Gm-Gg: ASbGncuRomr/1s2HuTeIOKr8614v02vfeUGs8OnBVPyuso7/pK3JUsKJH1T6GmoJZZ5
 B3gtCxlhcMZrQNcXHWAHj8bfNtYlGVJyc/fuo3bFT20l4dz7n4CsSIbW7cAj7gudMscaWWkoHuu
 KLDrhbpLYw1D8puw8zVs7wrARILAf6sdmu71WdwIwEZaV6UJXj0wapfWGNWCeYmeC5IK+kug53b
 4e9fFDnd8FRqO0vtEvveajomf3ADM7/3ZZRinUJqsQrKyfhXaDREUylVQFwCUfa32dBoJbnzbIh
 PDNioEpNiGjNSVHqkIXGHjkSZ6LD5vk28eWyitM5EJJThosy0g+bEEqbrTSlGQZEZMH7CNYr6oU
 =
X-Google-Smtp-Source: AGHT+IHAhi1mTqrmtDAJwSFg+mPIw8bxiXlqd8rBojWqsrF1JNf3NOblRa1hRmZzTbJS9ejgIVAUaQ==
X-Received: by 2002:a17:902:ce8b:b0:224:fa0:36da with SMTP id
 d9443c01a7336-22dbf5ef4b4mr48858965ad.18.1745618334607; 
 Fri, 25 Apr 2025 14:58:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 077/159] tcg/mips: Support negsetcond
Date: Fri, 25 Apr 2025 14:53:31 -0700
Message-ID: <20250425215454.886111-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 6a97264c7c..759f152711 100644
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
@@ -2270,6 +2289,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2364,6 +2387,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, rz, rz);
 
     case INDEX_op_deposit_i32:
-- 
2.43.0


