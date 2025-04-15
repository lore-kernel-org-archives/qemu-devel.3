Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAE3C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHa-0003lV-Jd; Tue, 15 Apr 2025 15:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAS-0006Ju-Gh
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:42:16 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8x-0006ii-3X
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:41:21 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-875b8807011so20534241.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746022; x=1745350822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GVClMtq+qpH9xhrl7s4WqRl6mw5bCbbA1nThQkkb/Jo=;
 b=SU1RQDuD0u9E/ntxoT95gg3HuV1yyvq3X4vU3/QkwQgm9vYllfQt6OW2XZjTeP+wJU
 h7y+2N7Q8A0hNiWS0QW9rNvrKyNbO5zhQiH/A6FIiWWh7FpX++SxTOdYTymT+2goQWmz
 yJJd5Mm7lE09zUXnotVWAnaZG4YlO+st6f3cBOqikTCCh5Fk9DXnuRyw6cRt3TvnKW2Z
 jPnEFugcL513BXL6O5UVvThoyDvOX6zfEEfRBEPO+dxvQSXysPBg+xK7JcAR0S32o0uu
 MgbtsBA3vGigocNJgcWCkcex5LWSwTPBgeB7wyMakydzCwXt5CrpWru8alEQC0rqkju0
 njnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746022; x=1745350822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVClMtq+qpH9xhrl7s4WqRl6mw5bCbbA1nThQkkb/Jo=;
 b=jpEFlXPWqS5O0pw81YCrWGwxs3SrtrO9pbTcG2wh0rKQ674CJRol7ld9x/px7sfM0c
 S2JfXt9EVJPOY4aH0curqKTSer1j8LYS+DNchHhqHmd9902I/IyPtIgB7nMFThSkGSKY
 Vr4hopqGFMbXSLOCbt3pbRvIOCf5EbHscw1hmZ4qc+yHP6sNkugYRMFqVFKmbaGemy9M
 3skZaCtJWN4kMQ+HxUAhS8F2ugPqvMfXX1RjGqwkvTlByE4IsloF91O2ys7PJ4l6FpC9
 1kiSKm23lGzEMJvtfUtUJJyAJoro+p48FoPNnXhgTIPQyrXK1T70grHSk2nvpHkimTy1
 0FKw==
X-Gm-Message-State: AOJu0YwXM7cPRBbpT0N7FYABL9/JpOv2GzhDSlsddbFAHYY88WGXwIY8
 hPfR052MkYav8sfXFJVkZ2ibazCKwRG7Z9JJKyKadj5ZSszHhI63/2LT5YU+s64Qx2T3Z1wR0pS
 R
X-Gm-Gg: ASbGnct+j0/YAUcuJ3WIXNYdS+RVMXJgQaZShvAJPbHamz/XRlvZV1KEcS5GMhQmscv
 moxLTEmxA7DR2GzXZHXq/ZJrAEAiOhubEke3BD1lVeFFhRzIDlA5Syb/0dzq+Cq+9YP1MPXGSXE
 CyIrTQCZNzQ45cv48+mp8qB78XfA7KIosci1AHUeneHC3/uh8O8Bu2RW/3fqkbuXrsFzMZcOx1U
 Mp/TJljmGKjGte2RnlhnG6/TNXK/IzW2GnQlblZn2dRAElhWFHDZU68tp6FVZBHoyPvWAbi+Xct
 bc+MZyqS/3b8ywf6uBqGZHIs2uzMBJ30E71WwVrAJwkiwbZEArMHO0tX7wnbaMbAZ5B6wucgJiT
 EHB1/SLt2Ig==
X-Google-Smtp-Source: AGHT+IFPzX7VzWWhLkepYjMs4tD2TuLndV+5WFvh/LSAwfXG6gNxBlVmP00R/xUOO8A/FJ5JAej85w==
X-Received: by 2002:a17:902:f648:b0:215:ba2b:cd55 with SMTP id
 d9443c01a7336-22c30cf9767mr10524825ad.2.1744745574298; 
 Tue, 15 Apr 2025 12:32:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 117/163] tcg: Use add carry opcodes to expand add2
Date: Tue, 15 Apr 2025 12:24:28 -0700
Message-ID: <20250415192515.232910-118-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=richard.henderson@linaro.org; helo=mail-ua1-x932.google.com
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
 tcg/tcg-op.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 127338b994..f17ec658fb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1102,7 +1102,13 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
-    if (TCG_TARGET_HAS_add2_i32) {
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
+        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+    } else if (TCG_TARGET_HAS_add2_i32) {
         tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2822,7 +2828,26 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-    if (TCG_TARGET_HAS_add2_i64) {
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+
+        if (TCG_TARGET_REG_BITS == 32) {
+            tcg_gen_op3_i32(INDEX_op_addco, TCGV_LOW(t0),
+                            TCGV_LOW(al), TCGV_LOW(bl));
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(t0),
+                            TCGV_HIGH(al), TCGV_HIGH(bl));
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(rh),
+                            TCGV_LOW(ah), TCGV_LOW(bh));
+            tcg_gen_op3_i32(INDEX_op_addci, TCGV_HIGH(rh),
+                            TCGV_HIGH(ah), TCGV_HIGH(bh));
+        } else {
+            tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
+            tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
+        }
+
+        tcg_gen_mov_i64(rl, t0);
+        tcg_temp_free_i64(t0);
+    } else if (TCG_TARGET_HAS_add2_i64) {
         tcg_gen_op6_i64(INDEX_op_add2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.43.0


