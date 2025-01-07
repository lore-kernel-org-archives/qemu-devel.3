Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A497C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XD-0000Me-Jh; Tue, 07 Jan 2025 03:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wm-0000DL-18
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:28 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wj-0002tr-FD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:27 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21675fd60feso25202995ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236883; x=1736841683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXZzdIlxIFjTwtimzoQBa4lLqmXgKR1E12aAeDzxQGs=;
 b=dCRFeTpdHgSws0cyBgZ7nskWdIrA5fWvB1bN94cgEH43qFfRchFc86frPrscSZlZ4m
 +Q8zp+47bk2a+0OlfYam9/PBLvZbmzEWbSaHGZimqEHF5h1868qGlhqb3tBoiiuthpyY
 789G3bEOO2dTfc5kRkjAIi3wkGNRrjNmRmGRAeYDrPDwpNpG/lSO55PTAfJtlUPvXUjw
 bHCWjISM6ItCQaXYYLD6yL/g/ciRPH6ci4jlaN3ImWhzgT8aowpaI+mEV9KAUCUhZrzK
 yjeE7E4rNIoMCklSsflnlU/NX2OuPq5vnGB7FTpgf8l8d1hNnLAObwAKYhOs6xwpL5mu
 lnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236883; x=1736841683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXZzdIlxIFjTwtimzoQBa4lLqmXgKR1E12aAeDzxQGs=;
 b=EdsdycqvwXQhmlPYwUnjqswOTfoios27OcpznK+7aYJXCUV5qwgu/TjtMBdTujWh6U
 dXP7eEP13fpuptDPxabhMVEJG1PiQmG6ujhvUQTTfzpPtSJ7Fb3c0TPv8a/Hj2pPUDF/
 3rq6AIGBil0usz8ZQMl2Iv7SQP+juXtfnUAke5ALchVJbJpxIO5e0Lpy4VRJEjFfhiqt
 3elhGiDGWSDNnp1jIIDX7vFE+6g2WDaYfWRkBWYLYDHBteZl6yfk4DtjN9zQzd3Q5x1q
 D8qka6FmzcZYWyVZ6mMxcwHDmvR3KJ/cXwffsF+8JUhKWwTv6yDWBPpzEjeeCt0qukLS
 2qyg==
X-Gm-Message-State: AOJu0YyZ/oj1XHbFw5YiNuYxlSepB9xZi0/n2Abt1CyArNd/w3IivVm/
 ENVsjwDJiv1h3GqgGgxX14uwk+L04IDxAjbbnirdxW90SpfqzIpziKojdofmjf1B41B6RW8fe7b
 x
X-Gm-Gg: ASbGncunNXwwcu/wRwrQ8XqMJB9p9mXdBhkfIsiAu/xpPjCu7GxliuzecOZcohIHvXN
 8YsjHPRV7C6Tn4vCnUcPSxX/J+FsgwYY52RkRFZ4PzMnWZXU/0cGOwwDLBCNHsTF659nimBT8Bm
 emHf0pqvM1TH7hgZXsJI5smy3ttVDDpxyIXCaArky0yx+EqbY7XtXX4uyjRdFdcCCQLJM4ZiKOK
 nGtO/9V/H27YpzJAysj/692C4660g+j/uqTTDPnrJzP0h6n26ce3zrOXrRNQZCeGiZbcVpPmB0G
 6v8xDAdzo3brZaCehQ==
X-Google-Smtp-Source: AGHT+IElHovAeBD0aMKq6riJW1v4xjdkatIBFja1qrai4hOKd4MZOjXsVS+qS8yYQVZb0K4CXNAoTQ==
X-Received: by 2002:a17:902:ecc2:b0:216:6435:5001 with SMTP id
 d9443c01a7336-219e6f3ab68mr708298045ad.57.1736236883195; 
 Tue, 07 Jan 2025 00:01:23 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 08/81] target/arm: Use tcg_op_supported
Date: Mon,  6 Jan 2025 23:59:59 -0800
Message-ID: <20250107080112.1175095-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


