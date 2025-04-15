Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2341C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m57-0007W0-Kr; Tue, 15 Apr 2025 15:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzL-0000Gw-QW
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyC-0000vJ-5g
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227b650504fso59354195ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745358; x=1745350158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VRmUCU5RGiT0RevU+cyFtfo5uoiRRSh4+rYYpOPsRow=;
 b=PAlYl+tfcKwBtg0jEmJKQ75xxtw0pZ/1zuNEBEM/LGB6uPhL9w2vzc9Mw7xtgC88vI
 r7FtouPTbsLnWRqlcfq6JqgfjSXFXmDty4Ui12HyjRgaBPC/hf6uWXMT219Jww+Lz9w/
 YChxnRzG3TUjTnYrDAmIJ0GTZ5aZZnR3OG0olR6kPxOGQ5rA8sbsDD1Bsnr6nQkYIrMV
 HU6f7TbxAyc9KCv7HO0xPfUm2DpAP1Y2+SCbEWhc/y9jDV2RHwiek6uEczLYRKUMRaSI
 9+AFf8JgRtXrqYYaw+U6QqLkftz38SJw2K68S+DPWFcLFsO2F249utXONxzLcjzrt+sM
 nAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745358; x=1745350158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRmUCU5RGiT0RevU+cyFtfo5uoiRRSh4+rYYpOPsRow=;
 b=o/wWxGhPnnkEPmrHrKQPMm48GsX9Yd1/yAaoxHp+GPUHyl+xPw1OoEZZ+ioOb7+tHm
 wDFQS/uTUJvpv/xl7uea4f2KcjJKC4EWv/3kpEa92FuB4PCn2ELIItAmMxoAWmGFGbqX
 UTM5fMjkzeD8YUPiLxHZ46m7MOU7h6x30YlY0ssYQstECxd6IxxBx6joDNQ86CZXhsnb
 CySOJFMPNox9dbxK4UOzQj4ZjjinsRA//zgJe5oi6yDBV4DhOIKkcylc6t/kJLkIwnM3
 hcV0M4d4ii8l8ThvY3Ff6buhaJ8eiyqHriWenhZ2EUyoHZ1Wvhrv3/Hn0ucxqU2kGHcG
 ZMaQ==
X-Gm-Message-State: AOJu0Yz24VnDNNlD6pm6pTehna1ZNF/45UFiacBfvYOGg711o5KNYiPA
 KS1Ctfx1sHJ2dyP8he5xvjnZXim4mthYpi44qF9WVVWKMfpYfxjhiuf7aS9yf3a7icse2YkLfUg
 +
X-Gm-Gg: ASbGncu8DWZztzsGCZ8CJfutJX6K3tSUVxRibETuwXki8yLkSP4G0SJDPSMSbblEYr5
 GS/ZIhhvEnQdznphwxL8G/NpOiQtK9mzPxt0ba8zEc4pkYiqGGgNx5daKW3jNgsaVghZKt/sQ2h
 q7jt7lQxbtWjoyeKvhKXcS+1drJdph8RhPEzxHN/rwMBQNRWV4EejFL+TiY71ThxKjqZJpYgKXf
 bLtc4UpQQQ/zGXyin/2tyPJB6HiQLdniCndGLKWRrO71MbzR01lN4+BHBZbEF4OuuvqBljDZtb1
 1c3qsCW4OEzJRnSA59Uz/ipuMQVbojFIJGsUdZv3wK8f22Pgtmh1PxMX8G4rJVPlzMJ+90e0jM0
 =
X-Google-Smtp-Source: AGHT+IEYaS+Fi4mqsjPIZTp5SL2bFtrgs8M+CU60acEt0kvQkhoZ7iyiVtmj0bfq4ERwuS4QhVMaxQ==
X-Received: by 2002:a17:902:ef44:b0:223:6657:5008 with SMTP id
 d9443c01a7336-22c31a49b33mr6386005ad.24.1744745358088; 
 Tue, 15 Apr 2025 12:29:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 072/163] tcg/loongarch64: Support negsetcond
Date: Tue, 15 Apr 2025 12:23:43 -0700
Message-ID: <20250415192515.232910-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


