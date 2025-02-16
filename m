Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA943C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrv-00078l-Gx; Sun, 16 Feb 2025 18:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqG-0001J9-L9
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:32 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqC-0005TB-MQ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:28 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220d39a5627so54485165ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747647; x=1740352447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VRmUCU5RGiT0RevU+cyFtfo5uoiRRSh4+rYYpOPsRow=;
 b=K3QeeZdp5Mc5lt/HMkwY6BR0n4FVPSoHvwQkZpXKZ6m64sZPb3T6PBTayT2KlMpS0R
 AolZzUxx5LCvOeMiODkt0UZ6ZZLIIqwnYEUDK+RZSR+DhorRgMWQosBoXjzouy/ywWys
 hu83SyPdqGH2neT4ooxQT+acn1dsQ1fj8QbRZfn305JhvIsIxEo84cKf0BCjl8ub8dcO
 WMNJ+vxwqgkpuVYmhsrP1kh/hu32ni/auqA1Cmr/TH5zAoQ5xMM+YfljWlzpy62W9CaY
 AwEiZl+ej0eh4qWZaz39eUiJPY7Zhe5cOrKdHB3ONlXZu7s1sKCf5TYis8DiSg1VL7Yb
 Aqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747647; x=1740352447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRmUCU5RGiT0RevU+cyFtfo5uoiRRSh4+rYYpOPsRow=;
 b=B485LvEJecOAaZLclJG39AtSTfSAd5Fj8pfyaPk43SNz9yB1nZ4+nouY+l9shLplz3
 EYD+6mSmOGGAzbqk98N6ZqDcMngcHK5kEBjWHAdZJkHzoO7+73H0XhDTQt3tRFHRAjjV
 nxQCpojU85mXcGHY6/+m5FESa2OwqwYqPEy1lYIOptXkH4X7wWfEXD72bu8PL0kMxFdT
 FlMUL0PC1f5SHZisZ2gDXAPVdRV9uY9oht3qsh+YcRIr9+YS81H1VuzeHBLhZqPZbCnm
 /atK7/kxOJzubkZvHK+3d0EbY6ybqPR9t4mJwigPNo/R+Wx7N6ksEAo6IruWUolOd8FY
 3z8w==
X-Gm-Message-State: AOJu0YxPO2bwJ0bUY2NGyL+8x3OyE0wQoUZ7NXpR7iSOJc32bh6ZFn1+
 Zzs6htO+GhSbIFO1eLiqoGYF3pmC8L4Uz6T4fzZ5ozIE/ePjzBMKlGYQb01Dz5SizUIpAAKSu1S
 T
X-Gm-Gg: ASbGncuRej5NKx2JbsjYbP49tJuW1kepoEpHKzPx1rz4SyewXy7JuhvPW7muoTaI3Ep
 Ly8OjQrVesrQ26mMFaLyThjSZnix9mLIxsa+EXq+hx4645VMWGqfs6OJqYiDsy/Ra1vYEkpaBSI
 KzJne4SEy3MvWcc6ZChetrNxa/WdFV2lsd1cwPJtytRcET94/M4lUSWiFIH0O+RH4C8b9nlp2RM
 CMrQ+YTEKl9n0keMHPnNpfbygMmpCaXvjHV+vEPIeWiBG3DntvV89EOev/x+dYb2fK9cx+dm/5g
 Tu/yqhgSAVfB36NA+DoLdHPma14mGRXct5E9W4nMdknKl4Q=
X-Google-Smtp-Source: AGHT+IHZoqd548T61AMnHiyOrxkQRET+D9KTynbKoWGlykpWJkQSfbz8iHGwVauhJCEoZoeK+xYMYw==
X-Received: by 2002:a17:902:d4cd:b0:221:2f4:5446 with SMTP id
 d9443c01a7336-22104048145mr123491155ad.25.1739747647292; 
 Sun, 16 Feb 2025 15:14:07 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 071/162] tcg/loongarch64: Support negsetcond
Date: Sun, 16 Feb 2025 15:08:40 -0800
Message-ID: <20250216231012.2808572-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 tcg/loongarch64/tcg-target-con-set.h |  2 --
 tcg/loongarch64/tcg-target-has.h     |  4 ++--
 tcg/loongarch64/tcg-target.c.inc     | 34 ++++++++++++++++++++++------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index da84e4d49c..c145d4ab66 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -29,8 +29,6 @@ C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rW)
 C_O1_I2(r, 0, rz)
-C_O1_I2(r, rz, ri)
-C_O1_I2(r, rz, rJ)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 12a721b4da..e9bb913961 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -10,7 +10,7 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
@@ -19,7 +19,7 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_bswap16_i64      1
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index aed1d9712d..c4f908f3ae 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -634,14 +634,29 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
 }
 
 static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
-                            TCGReg arg1, tcg_target_long arg2, bool c2)
+                            TCGReg arg1, tcg_target_long arg2,
+                            bool c2, bool neg)
 {
     int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2, c2);
+    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
 
-    if (tmpflags != ret) {
-        TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
-
+    if (neg) {
+        /* If intermediate result is zero/non-zero: test != 0. */
+        if (tmpflags & SETCOND_NEZ) {
+            tcg_out_opc_sltu(s, ret, TCG_REG_ZERO, tmp);
+            tmp = ret;
+        }
+        /* Produce the 0/-1 result. */
+        if (tmpflags & SETCOND_INV) {
+            tcg_out_opc_addi_d(s, ret, tmp, -1);
+        } else {
+            tcg_out_opc_sub_d(s, ret, TCG_REG_ZERO, tmp);
+        }
+    } else {
         switch (tmpflags & SETCOND_FLAGS) {
+        case 0:
+            tcg_debug_assert(tmp == ret);
+            break;
         case SETCOND_INV:
             /* Intermediate result is boolean: simply invert. */
             tcg_out_opc_xori(s, ret, tmp, 1);
@@ -1788,7 +1803,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
-        tcg_out_setcond(s, args[3], a0, a1, a2, c2);
+        tcg_out_setcond(s, args[3], a0, a1, a2, c2, false);
+        break;
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        tcg_out_setcond(s, args[3], a0, a1, a2, c2, true);
         break;
 
     case INDEX_op_movcond_i32:
@@ -2428,9 +2447,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I2(r, 0, rz);
 
     case INDEX_op_setcond_i32:
-        return C_O1_I2(r, rz, ri);
     case INDEX_op_setcond_i64:
-        return C_O1_I2(r, rz, rJ);
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        return C_O1_I2(r, r, rJ);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-- 
2.43.0


