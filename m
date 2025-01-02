Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF1BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbh-0007A1-Rw; Thu, 02 Jan 2025 13:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbD-0006xw-T2
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:12 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb7-00057n-Q0
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:09 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21661be2c2dso144676155ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841223; x=1736446023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hrD0/5NzV+BvoUzp4RbMZrucNLSTx7Ozt+v7L0p+ucA=;
 b=JUQu4WwJzEv+x/ttNMRA6LI55UuY2AKlRtzjBDLV/CO1OFiAovuZzeiMIonnLdmL5A
 +mZnngOvr3gIEsgPyxf3Qov0PUFikW72WjNGyuQ2seg1XhoZdnluSfepHPV+9nd7qa7H
 y8ppNlM0vhGtWrLNvAr9h3iPOSpOd9fX+Re601YajF7CkRjQdfs6uzhbxi0IQ8MmVzuq
 CrClk9r699XFvZV82gdWPbHRM1HbDw+4mPTcoXjqOZDYMEO+PQZ/DzCDc7ttbj9wF0SC
 grO3OZRthI1izI9wb9a0EDoofLx2ve58EK37y+0DwkHwT2s1EocRWKBkxQu5ZeWfACtX
 A8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841223; x=1736446023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrD0/5NzV+BvoUzp4RbMZrucNLSTx7Ozt+v7L0p+ucA=;
 b=BEnzQJGKaSXB8K96Da6JS/t3+30ldBV4hiBubvTn/0a2RZFTCfSSVuUoqaLSlYS4BR
 02jiFGhDLwyXKbjoURFxhqbkRUjIb/Pg/45XBDRtPQ34gVKSXwso+lgxB8OzMKavhlTY
 3YA3Gcp3NjOPxiZ/ecrJESeUCL7BX07WShKpnmrIACSQ1Gls2sTeGhYGXobvhe1GcRXa
 xkhsB0lomVa0Hab32wrwvK7ZKBM9GCVV92I6Na6VBEaanTvAcUT2F1XwJehSzcuyi50s
 AYkSX1Gk4YGGd+BIjKNmSGtuIHtTIrjhOH8y/HTiNXpMzEdP3ABqxLzCZyeLJkr/sak1
 S54A==
X-Gm-Message-State: AOJu0YxqUvCoBbqwsX7hZhmYbAsco7z/oLXqgnq+X27DQIwchd6/88MA
 pLO+XILoCzkpjCUo4uDi9HSK2QI1x0oqSUH6+KbwxSWwfLKA23Jthf8zM6bi9/8nsUqucxzDCzo
 I
X-Gm-Gg: ASbGnctOy2EYjfPKvwUHWAI1J/5A9nImO9xwUmyiPxCD3icRs07Re/dY/4sgZ9OGXnn
 BiiTvffMa624urWt4PHn9wKlZwgWSXspa2LALW1SgT5GLZzYHYeNNn5x+eX1PStFXjVb4YEX17r
 u3qudZ8jzN7AWbzYHyjd/PTie86JDYuoygzOofrnEDLFeJpgoU1ri+cjQ+w2mSDDaLkKbTbL/WO
 uziu24MXldSNwGKAq78emvqz2yVkHF1nEc3nIYL4h5HBuP8VfnB14cEoqakeQ==
X-Google-Smtp-Source: AGHT+IGSHdvAxeIMFG5sK2U5Emkhj1k0Yl4uHA530DYrAmyj4W1+x+5YtvpyNhjwBiobi1wBCYa1qQ==
X-Received: by 2002:a05:6a20:9c9a:b0:1e1:b062:f403 with SMTP id
 adf61e73a8af0-1e5e07ffc53mr73826562637.34.1735841222879; 
 Thu, 02 Jan 2025 10:07:02 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/73] target/arm: Use tcg_op_supported
Date: Thu,  2 Jan 2025 10:05:49 -0800
Message-ID: <20250102180654.1420056-10-richard.henderson@linaro.org>
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

Do not reference TCG_TARGET_HAS_* directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 10 ++++++----
 target/arm/tcg/translate-sve.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7c65fc3a3b..86da0c702f 100644
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
+    has_andc = tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32);
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
index 732453db6f..1a28d04f17 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -622,7 +622,7 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
      *       =         | ~(m | k)
      */
     tcg_gen_and_i64(n, n, k);
-    if (TCG_TARGET_HAS_orc_i64) {
+    if (tcg_op_supported(INDEX_op_orc_i64, TCG_TYPE_I64)) {
         tcg_gen_or_i64(m, m, k);
         tcg_gen_orc_i64(d, n, m);
     } else {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c16b59ab88..1b5bddcad1 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -493,7 +493,7 @@ static void gen_add_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 static void gen_adc_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    if (TCG_TARGET_HAS_add2_i32) {
+    if (tcg_op_supported(INDEX_op_add2_i32, TCG_TYPE_I32)) {
         tcg_gen_movi_i32(tmp, 0);
         tcg_gen_add2_i32(cpu_NF, cpu_CF, t0, tmp, cpu_CF, tmp);
         tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1, tmp);
-- 
2.43.0


