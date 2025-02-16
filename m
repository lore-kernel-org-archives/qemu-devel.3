Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7F3C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuP-0004RH-Os; Sun, 16 Feb 2025 18:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntS-00033Y-3i
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:46 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntP-000664-DA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so78683815ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747862; x=1740352662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZWOTLh+v7Qvy+QAWebFNxhuSAQgbLlmVC9g8h/0PkG0=;
 b=hK7Gzy07vRVgiD4GOfQ9QACic5ub2s7tRoze3sWo1hAu9Y0QnuEYhc5Pv+8RgfmiNN
 CZ8coCYkV8qikke71g4zrqkfvJo7vgX2tJjS5bBBFUoHcmGXCcl+3v5eam8AfVzXGRCU
 JPM8IjKmyBUPXROO8/vphQIf87TsqO5KqqjWnlSSmyz47wlSg3e8Hlk2AhSc127Kw5Hz
 PBUAC0faSSoM1Nzm91L1RgKDiZHrztVZqpuxKWsq2X4m4uMVTpnhMIPCyou9YoIjODYR
 7JiMrvNu9y3BHR7EttAqzVEgqnvJ448g4kpZAP9x6BIwS7/BesygjfZEJTCnZUnZN1dh
 gKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747862; x=1740352662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWOTLh+v7Qvy+QAWebFNxhuSAQgbLlmVC9g8h/0PkG0=;
 b=I68BXOLwoKSYbMocinxO+/D6iq48pzQ9X+v5rQuZVtDAhDQ9Si6s2cPwjxneUMVNZy
 +pkG053ZAGs3szKwJQug59ouR79q44ySX0QkVs04W7u/By33Wtf0gMSy1DT7O7Eo/x4h
 4M1gHLOfYbiehe6Lel4OS9ouuD10xQdGtAzf3PTHCyIAF0543SG4juNjMXQdFXj1etP3
 0WqQSqc9wcFfAbLk95kSZNszP16qwa4SVtT4VrYh+zqiVatX5Lyvs9zDMnnRCMllfA+8
 YaPPG+SsAidGEdzHYc5xJVL8j9aCPbciAN9NEoia4NYmKaS/ZNN97lPjZJ6/hhR46nYd
 P8qQ==
X-Gm-Message-State: AOJu0Yzz2e6gmUm7Nw5J9/ztZiiU223xKPXRJjAgqGsGcM/fj2nDF9Fw
 mak4mxlRs5BprbneZA2EljURZMjesC4aXOtuiuE7Edc/F5uwye2H/x6i3mBO1kkXT6vGcT3mxa+
 Y
X-Gm-Gg: ASbGncvTUNReTql6xUBWMqnz7zk35fR0MDuV7/vhzws5mzZdN8OA1rSn4+4sfAgBBbj
 HuHK58uhjKkWcU3LCP5DmqTfg7qLI21BoyJw67EbFPmzZ8I1JNuA6SMfsDSjbUH4sA0/lOV0GTK
 DdL1kft+ixYtX6Nf+UMQiUEpvQpKFl+i8IwUJTsrdTIVEsHNpz3mr964AN0gQLhz4efwo1qmAAh
 4uKlX2wjAQUPubJIMPUlGFuxenWCqCFEAFJe00DYnCoTcueQb1ErL3oa81A8RuM0oD28PZQaVhq
 uBxSZTm60ueJAUIf5geCjGBUls1Wvt6qgX5JwYQ8unC+1bQ=
X-Google-Smtp-Source: AGHT+IE/sd8Ty4PnrnyXg4rFyinNtIM1CW/hqENNo6o5GP23j80MGHu/SoW+96YKzJcEAYxlc9nPwA==
X-Received: by 2002:a17:902:d50d:b0:216:3633:36e7 with SMTP id
 d9443c01a7336-22104062006mr124496815ad.26.1739747861816; 
 Sun, 16 Feb 2025 15:17:41 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 117/162] tcg: Use sub carry opcodes to expand sub2
Date: Sun, 16 Feb 2025 15:09:26 -0800
Message-ID: <20250216231012.2808572-118-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
index f17ec658fb..447b0ebacd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1126,7 +1126,13 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
-    if (TCG_TARGET_HAS_sub2_i32) {
+    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
+        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+    } else if (TCG_TARGET_HAS_sub2_i32) {
         tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2865,7 +2871,26 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-    if (TCG_TARGET_HAS_sub2_i64) {
+    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+
+        if (TCG_TARGET_REG_BITS == 32) {
+            tcg_gen_op3_i32(INDEX_op_subbo, TCGV_LOW(t0),
+                            TCGV_LOW(al), TCGV_LOW(bl));
+            tcg_gen_op3_i32(INDEX_op_subbio, TCGV_HIGH(t0),
+                            TCGV_HIGH(al), TCGV_HIGH(bl));
+            tcg_gen_op3_i32(INDEX_op_subbio, TCGV_LOW(rh),
+                            TCGV_LOW(ah), TCGV_LOW(bh));
+            tcg_gen_op3_i32(INDEX_op_subbi, TCGV_HIGH(rh),
+                            TCGV_HIGH(ah), TCGV_HIGH(bh));
+        } else {
+            tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
+            tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
+        }
+
+        tcg_gen_mov_i64(rl, t0);
+        tcg_temp_free_i64(t0);
+    } else if (TCG_TARGET_HAS_sub2_i64) {
         tcg_gen_op6_i64(INDEX_op_sub2_i64, rl, rh, al, ah, bl, bh);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.43.0


