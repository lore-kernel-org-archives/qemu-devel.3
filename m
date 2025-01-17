Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42C8C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1t-0003zC-3P; Fri, 17 Jan 2025 13:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1n-0003uY-Vn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:08 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1l-0007pZ-Kw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:07 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21619108a6bso44007515ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138304; x=1737743104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXZzdIlxIFjTwtimzoQBa4lLqmXgKR1E12aAeDzxQGs=;
 b=Z5Z5kAuNs8LEl69EUfBidcP2BsNkEYePd2rJARQTLrg55Ot4JkD4G9ZdFOjT+YFQCb
 BZqOR38JmwK0IAfQcGOi7RUYGzOwEIWTM0eWtKNS9rNX2YxBXdpoWU7b4XA4nqaUkHhV
 LL8HWAk5CHjQF+PYJ73dKABS+1N6XGH0IGlUcYUNkgw8jErfy6fxR4cUrdEJTN4INefn
 DpZZOyuA/g/ARCF/LaY0GIorauQt2xN9eDF8jUtmR7Pt3bxkjrHmMox55y13zjqcKQPN
 pMqvNQ40czHe8heXJ8cxt61Ju0B0V+FpGiJepjwrVXgwGIQ3r/PgahDAg5Sf+3wtc3rW
 qGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138304; x=1737743104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXZzdIlxIFjTwtimzoQBa4lLqmXgKR1E12aAeDzxQGs=;
 b=hvTstBsJtA5sV7A4pENfBrzrSmRaf5btexZAd7Y7cBoSGbDCAFWxh9i5Bd7ebpn5NR
 4ixg7FuKx3JlC5PT8yBt9tRv7IIN+7POijUlkPu3b7VuHQ5dRgK+s1huiAOlKDxqFGtv
 N1w4WKgtHMuC/CRi1ONhZLzFHcR02xr9K6y8NqZEi035X1h9EANYVt1GqaDZRgeOhzG4
 oKwwG91VC8qtuhcvEHMQXKtRlCcg3d5omkR+OcknqteU+2Jykl6COeYK/sOWo+Mz9vj0
 Dp8v+gEX/2iGjE4glb9rlL+wxV9byc/wGZ3RdWPQ8VH55pSjMGIBZgT3NxwXnhXLK2FL
 MWRQ==
X-Gm-Message-State: AOJu0Ywh13/qfz7SJkr6F+gLVk7VDvswuK3Mh66fhT3HwP/AKOebJP68
 qhCTGY1NuzQi6eT2VeCfo4uyRoMAmNeRUZIdUwjFmnLPgGlXZC931L3EW7KFzqmVzYdYnVy72Og
 r
X-Gm-Gg: ASbGncuu9xLOpgjJ4iz7F9EzBA6I8hjfZf094GjnGJ7TOem8qI0zMaU80BRi5LumQiF
 /KPzye7XZiPgdaEZDL2qACydPqfC98JEL6XJqEGTs9pLeNiAyBhWtbropzRFL8h5H/qx2feedjD
 oWEmwUiNbxPbCmVpT0JPYKg4659P6XC1TNnxoADdVTjABg+jgSccQSgfnATKwHYXkfZGPyalhnw
 dKyZ88I2DOVraXJb/Z00GQ8+49bTxiuQ7O8dGiggqWDCI2m3V4b+009jbelRkj7opZDKDb/7E2Z
 PNFCd02DYLrW+bM=
X-Google-Smtp-Source: AGHT+IGVIexlqyv8cGgYO660iDPEA8/csgXpFA2On1ce+orBnW6DnYzecFRyVuSTeRCiLfi2x/0CrA==
X-Received: by 2002:a17:902:f688:b0:215:aee1:7e3e with SMTP id
 d9443c01a7336-21c352d664fmr49588305ad.5.1737138304206; 
 Fri, 17 Jan 2025 10:25:04 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/68] target/arm: Use tcg_op_supported
Date: Fri, 17 Jan 2025 10:23:57 -0800
Message-ID: <20250117182456.2077110-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Do not reference TCG_TARGET_HAS_* directly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 10 ++++++----
 target/arm/tcg/translate-sve.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7c65fc3a3b..bd814849c1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8219,6 +8219,7 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     TCGv_i64 tcg_rn, tcg_y;
     DisasCompare c;
     unsigned nzcv;
+    bool has_andc;
 
     /* Set T0 = !COND.  */
     arm_test_cc(&c, a->cond);
@@ -8249,17 +8250,18 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     tcg_gen_subi_i32(tcg_t2, tcg_t0, 1);
 
     nzcv = a->nzcv;
+    has_andc = tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0);
     if (nzcv & 8) { /* N */
         tcg_gen_or_i32(cpu_NF, cpu_NF, tcg_t1);
     } else {
-        if (TCG_TARGET_HAS_andc_i32) {
+        if (has_andc) {
             tcg_gen_andc_i32(cpu_NF, cpu_NF, tcg_t1);
         } else {
             tcg_gen_and_i32(cpu_NF, cpu_NF, tcg_t2);
         }
     }
     if (nzcv & 4) { /* Z */
-        if (TCG_TARGET_HAS_andc_i32) {
+        if (has_andc) {
             tcg_gen_andc_i32(cpu_ZF, cpu_ZF, tcg_t1);
         } else {
             tcg_gen_and_i32(cpu_ZF, cpu_ZF, tcg_t2);
@@ -8270,7 +8272,7 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     if (nzcv & 2) { /* C */
         tcg_gen_or_i32(cpu_CF, cpu_CF, tcg_t0);
     } else {
-        if (TCG_TARGET_HAS_andc_i32) {
+        if (has_andc) {
             tcg_gen_andc_i32(cpu_CF, cpu_CF, tcg_t1);
         } else {
             tcg_gen_and_i32(cpu_CF, cpu_CF, tcg_t2);
@@ -8279,7 +8281,7 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     if (nzcv & 1) { /* V */
         tcg_gen_or_i32(cpu_VF, cpu_VF, tcg_t1);
     } else {
-        if (TCG_TARGET_HAS_andc_i32) {
+        if (has_andc) {
             tcg_gen_andc_i32(cpu_VF, cpu_VF, tcg_t1);
         } else {
             tcg_gen_and_i32(cpu_VF, cpu_VF, tcg_t2);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 732453db6f..e303196592 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -622,7 +622,7 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
      *       =         | ~(m | k)
      */
     tcg_gen_and_i64(n, n, k);
-    if (TCG_TARGET_HAS_orc_i64) {
+    if (tcg_op_supported(INDEX_op_orc_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_or_i64(m, m, k);
         tcg_gen_orc_i64(d, n, m);
     } else {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c16b59ab88..68ac393415 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -493,7 +493,7 @@ static void gen_add_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 static void gen_adc_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    if (TCG_TARGET_HAS_add2_i32) {
+    if (tcg_op_supported(INDEX_op_add2_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_movi_i32(tmp, 0);
         tcg_gen_add2_i32(cpu_NF, cpu_CF, t0, tmp, cpu_CF, tmp);
         tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1, tmp);
-- 
2.43.0


