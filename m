Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA05CE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xa-0000nj-Di; Tue, 07 Jan 2025 03:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4XD-0000NP-MX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:57 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X9-0002zi-Jg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:53 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so22015808a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236909; x=1736841709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCrXLv46fVsyDni7RUNitDgDci2dtIKKUFU8rui6Ep0=;
 b=rW/GlrSqYhzM7/ytMiPkwfGg3y2gkTuTKTsXJe+wWvDFcnbpIK8uGeH3m8784/Ge6i
 NJLiWq+wkdNVpWWw5Sj0P7wrJ8XfGQxaRLG9F3FNyJSoUhcCcMu2FXZok/fras5sINRi
 POKR1U/EtL5HNYljBlA4ES0qPyqITB7ZCmzrxRvd9xcUiIIcuxeU9k8+viTeexCzLB/j
 T8N6aOJC8eBQlj5sLzet2LcEWCoBiEaQO0Ugv/sLQWYS0SOQOP8gjaLypXwHs9sEJ3qc
 MS3fs/GF7gbCrqR9OKa8MEO9ptKZPH5GEQFiKjZmXvQL7cVTu7aEJ+zPpaaZPsc8oLxO
 daOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236909; x=1736841709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCrXLv46fVsyDni7RUNitDgDci2dtIKKUFU8rui6Ep0=;
 b=bydDa7x0ravH1LCKedtykJDJRpbjeNBiR/q4oxW5f7eZpfWkrA78XL9HtIgU1mRvcb
 X/YtCCCkCZOWZ2gbt9sLFDtIAXhMaR52mtQWAW1FEhQwdxtOmCad5I+q2InpG7iQKsC1
 o3ej7Gs0N0Bt3eLJTOEg5GqDHdTnyG8bAWEnsKXuhm1wD36+p5CMZ/Wos/qUoHDI+NpJ
 9qQfxNy7BPjKpexZfDVyNNlWY5wmxIffBu59KgJBVbt6PN0O6YdnVVnLiBeiKHUyOrzB
 hwNTOC2qdYOdZxNDuHGCqU4/eaD5t8k7w/g1HtA7rc73rZAGXTVzE1aQ29VSohN6Bf6m
 GLBA==
X-Gm-Message-State: AOJu0Yye+0oG87XjYybLe5LOl3S2q7CDBfZtl6+flPYcoL5Y+hthVkKu
 LNRe9zRqiJ6wPrj2Jqwd2qSfNYeUvv1cbZ7yAd4wIc0yIVszOBo/kChZSdlCk2coG+5D70ibT1E
 n
X-Gm-Gg: ASbGncu2lNjovN74XOJr5PqDIcxsWVho1RIbGNGqyiwzWBKLoPKnaXwSZ6bG1iUJ6nD
 aed5bnCBPfcHPJvvf9LuPWhTQSQwPUaC4Auh9yY2kDL4H0dSSkpwj/vOe6UdhjnOUMHLMbxmK6t
 u44IH6NYDgKmyXLvXe+T2A7mVFSXpqL2bS8o+T0MX5fZzWF/xThLkj+j8zJmaJ9dmVXGmtMsI3v
 5RUSXIqUEhIKAFDoOGfCc+od6/CVaQ3s9WpZ6n/QrqsY/kvTr1pHmGDaBGMJDhSC33oSG1mi0z2
 iwfUDcHN5IrAgqCyRQ==
X-Google-Smtp-Source: AGHT+IFjV+bvE6sF34zievZozaUzypuy0gQQWXaTL0osFyz23TgQwfrH9Bm75ViTzd46jKmkRltdvQ==
X-Received: by 2002:a17:90b:2549:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2f452ec8ddamr79560687a91.26.1736236908894; 
 Tue, 07 Jan 2025 00:01:48 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 34/81] tcg/i386: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Tue,  7 Jan 2025 00:00:25 -0800
Message-ID: <20250107080112.1175095-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
index 3ea2eab807..ad69f957a7 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -80,7 +80,7 @@
 #define TCG_TARGET_HAS_ctpop_i64        have_popcnt
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -130,10 +130,47 @@
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
index 65b6a0b0cf..8ed35be8c3 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -56,11 +56,15 @@
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
index c363c5c04b..cd8ad712c4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2362,8 +2362,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
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
@@ -2373,8 +2375,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
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
index ab5ccd8dcb..d813a7f44e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1014,8 +1014,7 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         return;
     }
 
-    if (TCG_TARGET_HAS_extract_i32
-        && TCG_TARGET_extract_i32_valid(ofs, len)) {
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op4ii_i32(INDEX_op_extract_i32, ret, arg, ofs, len);
         return;
     }
@@ -1077,8 +1076,7 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
         }
     }
 
-    if (TCG_TARGET_HAS_sextract_i32
-        && TCG_TARGET_extract_i32_valid(ofs, len)) {
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
         tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
         return;
     }
@@ -2811,8 +2809,7 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         goto do_shift_and;
     }
 
-    if (TCG_TARGET_HAS_extract_i64
-        && TCG_TARGET_extract_i64_valid(ofs, len)) {
+    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
         tcg_gen_op4ii_i64(INDEX_op_extract_i64, ret, arg, ofs, len);
         return;
     }
@@ -2917,8 +2914,7 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
         return;
     }
 
-    if (TCG_TARGET_HAS_sextract_i64
-        && TCG_TARGET_extract_i64_valid(ofs, len)) {
+    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
         tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, ofs, len);
         return;
     }
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 047c5da81c..afff56956f 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3036,6 +3036,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_extract_i64:
         if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32u(s, a0, a1);
+                break;
+            }
             /* This is a 32-bit zero-extending right shift.  */
             tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
             tcg_out_shifti(s, SHIFT_SHR, a0, a2);
@@ -3043,28 +3047,53 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
 
@@ -3747,6 +3776,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
-- 
2.43.0


