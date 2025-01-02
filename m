Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC31E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbi-0007DU-Nr; Thu, 02 Jan 2025 13:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbP-00070w-8i
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:26 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbN-0005BX-0G
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:23 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21661be2c2dso144679595ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841240; x=1736446040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rKtyCpX9+3gf4pwXp5MVTpXwZxaLmM/OVknjlxXkSBY=;
 b=IQePaO6z346pHi16QppDzJcUwJviHFFeLA+Ml8aovmxehoIY/MGpJJJZSAWB26N9iL
 KMqQw3X1ACDsfcixJ3ufsutF5/DPTy6C4ED/+BsSRCUTyyNyvGG3kl8UhCcpeLdrPU51
 v4prFefGnoi1rDaeZ/x+Q8zkmEAu+WoB14yck1Wk3TdMbgm54CZAbqd12dtJO6yuu9VG
 ryMqstGfAdvSf9O9gIvw1JjlCJQn/kHEbRMIJONqvUyGXBLBwUyu9fDLDjkYhkrf3FeP
 ado2Q/nfGsS0CGIRcx/UCoJ3nIp8jN2mW2xk2DE8gpPgYCqG/ImP1VoBI1X7iinBTF+A
 y4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841240; x=1736446040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKtyCpX9+3gf4pwXp5MVTpXwZxaLmM/OVknjlxXkSBY=;
 b=B9CWg/CBk1POKkzs9eUohp/WQdE+uLogtIZxJV8Z8/JCpvbIiUP3k+i2E3wuEhNdWo
 GGwvJm9zX8E5hUgI2paBDZF5ouu5UOTS90IQj/0w8hTzINEXtT13DAhPsEI5dJjxZDp9
 ikqi3qvkgJFN1fyC0BmCIaLpaq0H49ZWwHtt2+jvncilgEJfILbHU6+irt5+qFMj/jTm
 K8e9nYdte8I3RdA6vtoWC9T5z7k9Tm2kfsd507aiaUoN8DogXgvAo4r3KJ66q19QCQmD
 GLa4cGFhmKFroeazq09jQ/b+iTBdiONnRukME+Oto5kxd1JqrrC401lC1naeM5wjLOrq
 Mp9g==
X-Gm-Message-State: AOJu0YyEyzaZ+tKg93u5qrQ21H69VjJpebmY4++3reZuLMeyqq5MFUDq
 yZ8q207dcJwzipwy3uLK3d2uvhaZZ7Hen3nkchulbj+owzIx9QbD+1kCnzSu10VLwFW4xrMnyBv
 H
X-Gm-Gg: ASbGncuV+XIqaBU2DMq0Y973IP0JlCKq54eF66h+5k9gvi9Mwo0FP6TKI8EL6smrxab
 Z3Zd9AwpHsLlzXac18zM9/1C1sHSBDR0dqgrpTjoatFhVXGSFsT0h4TxMLT9YFq0mig4pJgKtKt
 W0ju993XOx5nYtIlRymf4iojQBoQIqiL9c7z9m8NfHpOH+6QVyx/vDuD7KORbPb8lxhxtaFXJHJ
 y+VFzGNAqLv0+o7hCbR6VYyycVyVCpB7Mx+zSWjdg21VTwT1KE+bXTLYziQDQ==
X-Google-Smtp-Source: AGHT+IFmeAthlvVFD0UFpHYNsKMTmVqN8JBvGw7nDnEO/cniSVwFYWKYRERRXM2AhhnHeJViXb5NOQ==
X-Received: by 2002:a05:6a21:3381:b0:1e1:c26d:d7fd with SMTP id
 adf61e73a8af0-1e5e081c4demr73341833637.37.1735841239640; 
 Thu, 02 Jan 2025 10:07:19 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/73] tcg/i386: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Thu,  2 Jan 2025 10:06:11 -0800
Message-ID: <20250102180654.1420056-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
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

Accept byte and word extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-has.h | 49 +++++++++++++++++++++++++++----
 tcg/tcg-has.h             | 12 +++++---
 tcg/optimize.c            |  8 +++--
 tcg/tcg-op.c              | 12 +++-----
 tcg/i386/tcg-target.c.inc | 62 +++++++++++++++++++++++++++++----------
 5 files changed, 107 insertions(+), 36 deletions(-)

diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index da99f64421..c8ad17cf9f 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -68,7 +68,7 @@
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
@@ -105,10 +105,47 @@
      (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
 #define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
 
-/* Check for the possibility of high-byte extraction and, for 64-bit,
-   zero-extending 32-bit right-shift.  */
-#define TCG_TARGET_extract_i32_valid(ofs, len) ((ofs) == 8 && (len) == 8)
-#define TCG_TARGET_extract_i64_valid(ofs, len) \
-    (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
+/*
+ * Check for the possibility of low byte/word extraction, high-byte extraction
+ * and zero-extending 32-bit right-shift.
+ *
+ * We cannot sign-extend from high byte to 64-bits without using the
+ * REX prefix that explicitly excludes access to the high-byte registers.
+ */
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    switch (ofs) {
+    case 0:
+        switch (len) {
+        case 8:
+        case 16:
+            return true;
+        case 32:
+            return type == TCG_TYPE_I64;
+        }
+        return false;
+    case 8:
+        return len == 8 && type == TCG_TYPE_I32;
+    }
+    return false;
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
+static inline bool
+tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        return true;
+    }
+    switch (ofs) {
+    case 0:
+        return len == 8 || len == 16;
+    case 8:
+        return len == 8;
+    }
+    return false;
+}
+#define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
 #endif
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 88e8cedab6..e64ac9768e 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -30,11 +30,15 @@
 #ifndef TCG_TARGET_deposit_i64_valid
 #define TCG_TARGET_deposit_i64_valid(ofs, len) 1
 #endif
-#ifndef TCG_TARGET_extract_i32_valid
-#define TCG_TARGET_extract_i32_valid(ofs, len) 1
+#ifndef TCG_TARGET_extract_valid
+#define TCG_TARGET_extract_valid(type, ofs, len) \
+    ((type) == TCG_TYPE_I32 ? TCG_TARGET_HAS_extract_i32 \
+     : TCG_TARGET_HAS_extract_i64)
 #endif
-#ifndef TCG_TARGET_extract_i64_valid
-#define TCG_TARGET_extract_i64_valid(ofs, len) 1
+#ifndef TCG_TARGET_sextract_valid
+#define TCG_TARGET_sextract_valid(type, ofs, len) \
+    ((type) == TCG_TYPE_I32 ? TCG_TARGET_HAS_sextract_i32 \
+     : TCG_TARGET_HAS_sextract_i64)
 #endif
 
 /* Only one of DIV or DIV2 should be defined.  */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6cb2232d74..e427c643b1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2364,8 +2364,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
-        if (TCG_TARGET_extract_i32_valid(sh, 1)) {
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
             uext_opc = TCG_TARGET_HAS_extract_i32 ? INDEX_op_extract_i32 : 0;
+        }
+        if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, sh, 1)) {
             sext_opc = TCG_TARGET_HAS_sextract_i32 ? INDEX_op_sextract_i32 : 0;
         }
         break;
@@ -2375,8 +2377,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
-        if (TCG_TARGET_extract_i64_valid(sh, 1)) {
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
             uext_opc = TCG_TARGET_HAS_extract_i64 ? INDEX_op_extract_i64 : 0;
+        }
+        if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, sh, 1)) {
             sext_opc = TCG_TARGET_HAS_sextract_i64 ? INDEX_op_sextract_i64 : 0;
         }
         break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c8892794c8..fab3e67e77 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1012,8 +1012,7 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         return;
     }
 
-    if (TCG_TARGET_HAS_extract_i32
-        && TCG_TARGET_extract_i32_valid(ofs, len)) {
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, ofs, len);
         return;
     }
@@ -1075,8 +1074,7 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
         }
     }
 
-    if (TCG_TARGET_HAS_sextract_i32
-        && TCG_TARGET_extract_i32_valid(ofs, len)) {
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
         return;
     }
@@ -2848,8 +2846,7 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         goto do_shift_and;
     }
 
-    if (TCG_TARGET_HAS_extract_i64
-        && TCG_TARGET_extract_i64_valid(ofs, len)) {
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
         tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
         return;
     }
@@ -2954,8 +2951,7 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
         return;
     }
 
-    if (TCG_TARGET_HAS_sextract_i64
-        && TCG_TARGET_extract_i64_valid(ofs, len)) {
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
         tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, ofs, len);
         return;
     }
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b7a8b3880c..0ef94071c6 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3035,6 +3035,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_extract_i64:
         if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32u(s, a0, a1);
+                break;
+            }
             /* This is a 32-bit zero-extending right shift.  */
             tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
             tcg_out_shifti(s, SHIFT_SHR, a0, a2);
@@ -3042,28 +3046,53 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         /* FALLTHRU */
     case INDEX_op_extract_i32:
-        /* On the off-chance that we can use the high-byte registers.
-           Otherwise we emit the same ext16 + shift pattern that we
-           would have gotten from the normal tcg-op.c expansion.  */
-        tcg_debug_assert(a2 == 8 && args[3] == 8);
-        if (a1 < 4 && a0 < 8) {
-            tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
-        } else {
+        if (a2 == 0 && args[3] == 8) {
+            tcg_out_ext8u(s, a0, a1);
+        } else if (a2 == 0 && args[3] == 16) {
             tcg_out_ext16u(s, a0, a1);
-            tcg_out_shifti(s, SHIFT_SHR, a0, 8);
+        } else if (a2 == 8 && args[3] == 8) {
+            /*
+             * On the off-chance that we can use the high-byte registers.
+             * Otherwise we emit the same ext16 + shift pattern that we
+             * would have gotten from the normal tcg-op.c expansion.
+             */
+            if (a1 < 4 && a0 < 8) {
+                tcg_out_modrm(s, OPC_MOVZBL, a0, a1 + 4);
+            } else {
+                tcg_out_ext16u(s, a0, a1);
+                tcg_out_shifti(s, SHIFT_SHR, a0, 8);
+            }
+        } else {
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_sextract_i64:
+        if (a2 == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, TCG_TYPE_I64, a0, a1);
+        } else if (a2 == 0 && args[3] == 16) {
+            tcg_out_ext16s(s, TCG_TYPE_I64, a0, a1);
+        } else if (a2 == 0 && args[3] == 32) {
+            tcg_out_ext32s(s, a0, a1);
+        } else {
+            g_assert_not_reached();
         }
         break;
 
     case INDEX_op_sextract_i32:
-        /* We don't implement sextract_i64, as we cannot sign-extend to
-           64-bits without using the REX prefix that explicitly excludes
-           access to the high-byte registers.  */
-        tcg_debug_assert(a2 == 8 && args[3] == 8);
-        if (a1 < 4 && a0 < 8) {
-            tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
-        } else {
+        if (a2 == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, TCG_TYPE_I32, a0, a1);
+        } else if (a2 == 0 && args[3] == 16) {
             tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
-            tcg_out_shifti(s, SHIFT_SAR, a0, 8);
+        } else if (a2 == 8 && args[3] == 8) {
+            if (a1 < 4 && a0 < 8) {
+                tcg_out_modrm(s, OPC_MOVSBL, a0, a1 + 4);
+            } else {
+                tcg_out_ext16s(s, TCG_TYPE_I32, a0, a1);
+                tcg_out_shifti(s, SHIFT_SAR, a0, 8);
+            }
+        } else {
+            g_assert_not_reached();
         }
         break;
 
@@ -3745,6 +3774,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
-- 
2.43.0


