Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC68E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbn-0007TS-JP; Thu, 02 Jan 2025 13:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbU-00072p-6h
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:29 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbS-0005Ct-OI
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:27 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so166197055ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841245; x=1736446045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I++M7PqcsWlr1e/k02WhSRPHQjC/Hxfh1GnBKkoUtGo=;
 b=kXI6QmrDXhucTwGuBYC3tdcPxtWq0YgXk4b/V3oyNuj9763CiRjh3Dhd4ee8Epi9Ae
 HodZQOV2OwTpeSlcZhak1cwMy+KlCbfHFbgdX0feGrTE3t9H1TyLxqtEOIVnKJ9c8H+C
 j1zszSYiMii5W9kUlf9c0LaEG07unmGG/AQOhF28Eyt27+s0JXrKKJiaexCkZOavxxi0
 sJqnyXNsLJlzwukWqKQimEpywxfQD4gnMpiN/UkYdXg5OXl/O4YfAa482gTksKexvNe+
 yBjgUOAZCUoKreBwrDIp69WdcoTrBVy4xA7tJ4uVK/u0+QQFN9wIx9bLVtNo9xn7jSnj
 7hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841245; x=1736446045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I++M7PqcsWlr1e/k02WhSRPHQjC/Hxfh1GnBKkoUtGo=;
 b=GDvE6NMOEIsECsYmYYii3G4qqGZRBW2cqB9gDCECt6BFiBkyX93i/HwdwELvj4Gzyj
 R3qsOmzQZdCGTneLja8SovXYzMKka0+UfhZBPdT24gkqvQlAe2gl1wzbMzwXMWFZmA2Z
 2yn885bRRazJhE5ax9srXJ9gWKXHyNq9xuVa6g0cIhlycvLu4TI4R2iNyF3LTzMFZjBV
 FBTlaSkJDS7tNOMWQ0XZTzVJ2SuxmGfdMba1RVtW3kSI3ExLKRH564YAFi1xpT9Ia5iv
 Mrw7Zpz0Yd3YEROiw5k58Xzi47ZqcoMEUXbZeZrXoe4aD+cJtX73W3DwCFFey8GEKrNM
 dmTQ==
X-Gm-Message-State: AOJu0YynAACp15rf62uxJi71pIG2VB0VyPeBS/ngQjJ7VbCFKlTTM/6t
 gM3wpSHDjjQi6+Ep++BMSKNus4zN/0DhgPwR9uzT1R5z5iUKuZwQQzHRMSBtdF1fvOAMd9K+3VT
 0
X-Gm-Gg: ASbGncuN5SrBGYWee1Y5+on6fnI4/ZYq8m2QjV173tfqFSfWY5K5PySPhzJ4pdH/aut
 lT9voe9EBykAvrnYXJwsf8+mGaxSDfL+RnPT+GYDbi69DI43CqrmwnOe/r9NkPVWYw/K2gS+YHD
 /VS0dTa+fF9PgE3mfKDoqPWUOw5WJQYjS97Q9VVq0GnrLGPI9lp9rVpTDUvOrmS/GARW4w37cU+
 ybuHXa5+ZgKeGG9l7oaADtD9+pZfmD4+6A/+N40rQlXUhEkJVbGvyKAzLhFZg==
X-Google-Smtp-Source: AGHT+IH6GzCnFqf2Shw1SXj5kc3CgAvzV2QZJONEhDaMibvaSgXkYjMFxIvhAN8Yynd9GkzODU5UqA==
X-Received: by 2002:a05:6a20:914d:b0:1e2:5c9:6831 with SMTP id
 adf61e73a8af0-1e5e1f57c6bmr65311188637.14.1735841245363; 
 Thu, 02 Jan 2025 10:07:25 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/73] tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
Date: Thu,  2 Jan 2025 10:06:19 -0800
Message-ID: <20250102180654.1420056-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Extracts which abut bit 32 may use 32-bit shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-has.h | 24 +++++++-----------------
 tcg/riscv/tcg-target.c.inc | 16 ++++++++++++----
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index efebc46109..2caec10a18 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -84,31 +84,21 @@
 static inline bool
 tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 {
-    if (ofs == 0) {
-        switch (len) {
-        case 16:
-            return cpuinfo & CPUINFO_ZBB;
-        case 32:
-            return (cpuinfo & CPUINFO_ZBA) && type == TCG_TYPE_I64;
-        }
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        /* ofs > 0 uses SRLIW; ofs == 0 uses add.uw. */
+        return ofs || (cpuinfo & CPUINFO_ZBA);
     }
-    return false;
+    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && len == 16;
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
 static inline bool
 tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 {
-    if (ofs == 0) {
-        switch (len) {
-        case 8:
-        case 16:
-            return cpuinfo & CPUINFO_ZBB;
-        case 32:
-            return type == TCG_TYPE_I64;
-        }
+    if (type == TCG_TYPE_I64 && ofs + len == 32) {
+        return true;
     }
-    return false;
+    return (cpuinfo & CPUINFO_ZBB) && ofs == 0 && (len == 8 || len == 16);
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 8122187665..fb7cf0ca03 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2344,8 +2344,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_extract_i64:
-        if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32u(s, a0, a1);
+        if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32u(s, a0, a1);
+            } else {
+                tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
+            }
             break;
         }
         /* FALLTHRU */
@@ -2358,8 +2362,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_sextract_i64:
-        if (a2 == 0 && args[3] == 32) {
-            tcg_out_ext32s(s, a0, a1);
+        if (a2 + args[3] == 32) {
+            if (a2 == 0) {
+                tcg_out_ext32s(s, a0, a1);
+            } else {
+                tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2);
+            }
             break;
         }
         /* FALLTHRU */
-- 
2.43.0


