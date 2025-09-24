Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A4DCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UpJ-00018e-09; Wed, 24 Sep 2025 15:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uly-0006w2-17
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:29 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujv-0007pp-5G
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77db1bcf4d3so145237b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740475; x=1759345275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCvMLg3PXpeXqCZXKGOBJu95mWvD2ZHjZee8a5dbELg=;
 b=FIocC7IwHbK1ZeQpebZVk7XQJJNN7DZ5YzsK/PPPBYT5Ll86/t3nndBfqSpzHryLm8
 /m6P4DZh79tnpcMZAec5yM4df0O9E5R6jOvujssc/DSQ23UfuoncrGodskrs179gE0y9
 URjrpKUhOcpArLkzKlpOnLgIBGkYT1NswhJuWoqTAnQMf0Cul6/TYTh0/tpgHEXsWQEc
 J/WBQSY8gZqUyVhvOzM0BBDYFHdI+aITtuk5z7PbT60LT/kGUD3Tzwi7k+2J/CAkSy89
 10VHjN2n+0RSFn2Oix0xLo8m43xkP72Meqoigp1C2Q5GBF8z3HrMGRitWOEypbn49KD7
 VNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740475; x=1759345275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCvMLg3PXpeXqCZXKGOBJu95mWvD2ZHjZee8a5dbELg=;
 b=AOOQB+M6whxj6+whjef/QQ2M4czPqkIlGbyMaLM/xxSQQOygovJ89wGIS+jh33YXfJ
 NudaSoKy74T7LitE3yb0MkRfBzbc/oI7kpM+NlC5qjslkjH6f6HMJNl+82VyEeDqeW2c
 gIVbpIz3Ky+HhJIM0P8IlvyaigjIzG8zF9TB4ARyt4EdyK9OYUuX4Tk8nWQMLqiChW1F
 yGwYVQlsfmbv+YuMlJ2Ooad+I7mUFGrCdCVqdwZe2regiigbKgcdOkGfK8E9GUf1TePM
 80zPN77GxF5V7RKdXHg/1tMjlLoa7aWt1GPrxH2nxvKv8FD0Dm0q9DPJrcfn3EmztUSM
 dC5w==
X-Gm-Message-State: AOJu0YzJw+vmfvtHpW/gZZocqaDtHUT4ND3tTsnwU33bNMi08UCve4DC
 aflCiQHQ1ckTELfHDB8I+NPo5kWh2+CxIlynyYc72M+AMeFgXb5JQtGGeU5jlYlmC5Q7pCa5h0+
 t2Ygk
X-Gm-Gg: ASbGncvJiz8xcxUmoirSvDeZlbbU4SEUxBd6TFRpT+kE/2bKfV2/YpgMT/4fGJl8xZT
 z1KJ6gAnbb4UNXQUQT6+ZCFDqDg9/RLNuVL+ZDs3mzlS0HgXqnIaq1S7HJjzUbmGoXNUjpcOW5I
 v/C5UGKn1eK0gr0j811vtvBPB0xZLHEckA/atEm3tn/88LsbPiKjPROriqQKODtAaW8oI+badmR
 4vX8B4zo/s5p+0NXgAOEyAJ2W9oofwWkgrRtW9vWdvYuEz1mV1FNce3sxwpbYbdYy/j7r+JcMOz
 ScYQPWWzUeE2oIaainowcdUZd13M2C4/eqCsw6w5roqXo77OVokHSdqH6buCIBWgOMb5P23y3wo
 TGzTP0YNoLcTN5HHwNhk5ax9HBDJY
X-Google-Smtp-Source: AGHT+IFR+dN1DApRGTduExcQrc7bmdjn9qSrmG4IXmd2SWoZ8xN/moDkMrO9XzZICtI9FeMXM5aHLg==
X-Received: by 2002:a17:90b:2786:b0:327:e59d:2cc2 with SMTP id
 98e67ed59e1d1-3342a24776cmr904658a91.10.1758740475395; 
 Wed, 24 Sep 2025 12:01:15 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 11/32] target/sparc: Relax decode of rs2_or_imm for v7
Date: Wed, 24 Sep 2025 12:00:44 -0700
Message-ID: <20250924190106.7089-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

For v7, bits [12:5] are ignored for !imm.
For v8, those same bits are reserved, but are not trapped.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 56 ++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cfdd9c1ce4..810e2491a6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2526,6 +2526,32 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS4(C)    false
 #endif
 
+/*
+ * We decoded bit 13 as imm, and bits [12:0] as rs2_or_imm.
+ * For v9, if !imm, then the unused bits [12:5] must be zero.
+ * For v7 and v8, the unused bits are ignored; clear them here.
+ */
+static bool check_rs2(DisasContext *dc, int *rs2)
+{
+    if (unlikely(*rs2 & ~0x1f)) {
+        if (avail_64(dc)) {
+            return false;
+        }
+        *rs2 &= 0x1f;
+    }
+    return true;
+}
+
+static bool check_r_r_ri(DisasContext *dc, arg_r_r_ri *a)
+{
+    return a->imm || check_rs2(dc, &a->rs2_or_imm);
+}
+
+static bool check_r_r_ri_cc(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    return a->imm || check_rs2(dc, &a->rs2_or_imm);
+}
+
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
 {
@@ -3249,8 +3275,7 @@ static bool do_wr_special(DisasContext *dc, arg_r_r_ri *a, bool priv,
 {
     TCGv src;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && (a->rs2_or_imm & ~0x1f)) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
     if (!priv) {
@@ -3693,8 +3718,7 @@ static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a,
 {
     TCGv dst, src1;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri_cc(dc, a)) {
         return false;
     }
 
@@ -3778,11 +3802,11 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
     if (!a->cc && a->rs1 == 0) {
+        if (!check_r_r_ri_cc(dc, a)) {
+            return false;
+        }
         if (a->imm || a->rs2_or_imm == 0) {
             gen_store_gpr(dc, a->rd, tcg_constant_tl(a->rs2_or_imm));
-        } else if (a->rs2_or_imm & ~0x1f) {
-            /* For simplicity, we under-decoded the rs2 form. */
-            return false;
         } else {
             gen_store_gpr(dc, a->rd, cpu_regs[a->rs2_or_imm]);
         }
@@ -3799,8 +3823,7 @@ static bool trans_UDIV(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_DIV(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -3851,8 +3874,7 @@ static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_64(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -3889,8 +3911,7 @@ static bool trans_SDIVX(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_64(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -4186,8 +4207,7 @@ TRANS(SRA_i, ALL, do_shift_i, a, false, false)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!imm && rs2_or_imm & ~0x1f) {
+    if (!imm && !check_rs2(dc, &rs2_or_imm)) {
         return NULL;
     }
     if (imm || rs2_or_imm == 0) {
@@ -4250,8 +4270,7 @@ static bool do_add_special(DisasContext *dc, arg_r_r_ri *a,
 {
     TCGv src1, sum;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -4369,8 +4388,7 @@ static TCGv gen_ldst_addr(DisasContext *dc, int rs1, bool imm, int rs2_or_imm)
 {
     TCGv addr, tmp = NULL;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!imm && rs2_or_imm & ~0x1f) {
+    if (!imm && !check_rs2(dc, &rs2_or_imm)) {
         return NULL;
     }
 
-- 
2.43.0


