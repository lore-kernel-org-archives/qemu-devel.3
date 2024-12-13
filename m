Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24F5E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XI-00077j-BA; Fri, 13 Dec 2024 12:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X7-0006zo-93
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:58 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X5-0001W8-Ag
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:57 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1543933f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111173; x=1734715973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sp4roeRQL1fuJKdKDyKEq4BIrsgp9jAp7oXPidcX4dw=;
 b=cKVneeFFkcdwJJSLwAgOgOMpVHotcTXpy7mK5OB8zF6ervLqbqZCKnBwVL44z4JUo1
 bKOefGR6NqSI0U5W3CGD1pMnA4redChW1We/MNXppFRLS/0onufDzNDecoX5MsM63xmU
 z0BwS3g4LPPovw+mb4Xf7aQRQnSoYyTZBKgLR5caNFIiqcafcA8uCD7tcPwOkKSM7kaG
 /STvejZXbPNGQ6ll5xFvcRgNHZR0oPfp4HoGuanKa+UMN8KFkiL4z6EUCFsNk5xjxPtv
 EED/7KBho7/CihgefRypnJSDX23DkrWYfEAJGzNyx0gClaLdttMVInU9JO0cNCHzFl/6
 3K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111173; x=1734715973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sp4roeRQL1fuJKdKDyKEq4BIrsgp9jAp7oXPidcX4dw=;
 b=OW/Hep9YulgOaJCuoniaZZG8jmfxqGbbVLC81x4eBh5iaLN/dfrcCVuxjyk2SM7bR8
 xjuRVSLEYE6pMjce2sTgcwCRAUKv3XExOTdD0ka6BOA/cIwgCqfZvKMt3lfceyEPcZUu
 WbP6wKQKdOsKavri3VobrKGzY9PfuRfcmTJXesPV7tXtasvFUwTpnQgovBwFIkORlMWa
 uxdxIgbPAj7vGlCaP2XuubftbffxMpVpJAdMIfaQ75qASa9D71Ar8T8db7Mip1qeWb+9
 BqlKkWAqcQ/nf2HzDlxZBGEIbM7m/QKAyO0KpMMIrvh+F1fMv5qeN4Y+G8MAadpFNzMg
 2dPg==
X-Gm-Message-State: AOJu0YyxLTZDwqHriuxt6NSptIME5I6WDwFcBeJkv8DJ1OhUyh8Y9iy9
 tTgKkB6zxIzGAPyb+aOZcaiTGOA2O79L4pYUZV+TT0kqqUA0MGEU7hjW926iFAamvDiiEEsWvxu
 N
X-Gm-Gg: ASbGncvbMzcHIRFLoX3qbrFGa4hOOmTC9YqugMRslT/tjrzyzkrA/5frhTtBmGV1x8L
 TSqVeUONVH//+IZriYT/rLwrcKQjH5MrkmvDVRJbsGyvipionQqlucCDq/u2PRwCbdgYUIdyUMY
 xRk76RBp0ZwAH5JJomnktdA7wsYVj7vdF3XH9jdEUBPJE1SqPJ0u4j54nBu2KLWSgLCQHZ0pf2x
 Tkhm0DTjq4aoRcWCMaUV51D445CvNXr8zibK5g4ka/2UoH6kVdPynGn0h4xPQ==
X-Google-Smtp-Source: AGHT+IGeGln2lMj7ZmuAtwrVoqCIXFmzRJHl6bJt5MX5OlpHgGZqyOLLH/aMhEz+jjj6bUTTbJXjSA==
X-Received: by 2002:a5d:6f1d:0:b0:386:37f5:99e7 with SMTP id
 ffacd0b85a97d-3888e0bbaeemr3200362f8f.33.1734111173067; 
 Fri, 13 Dec 2024 09:32:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/85] target/arm: Introduce fp_access_check_scalar_hsd
Date: Fri, 13 Dec 2024 17:31:24 +0000
Message-Id: <20241213173229.3308926-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Provide a simple way to check for float64, float32,
and float16 support, as well as the fpu enabled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 62 ++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9c6365f5efc..4e47b8a8041 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1239,6 +1239,27 @@ static bool fp_access_check(DisasContext *s)
     return true;
 }
 
+/*
+ * Return <0 for non-supported element sizes, with MO_16 controlled by
+ * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
+ */
+static int fp_access_check_scalar_hsd(DisasContext *s, MemOp esz)
+{
+    switch (esz) {
+    case MO_64:
+    case MO_32:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return -1;
+        }
+        break;
+    default:
+        return -1;
+    }
+    return fp_access_check(s);
+}
+
 /*
  * Check that SVE access is enabled.  If it is, return true.
  * If not, emit code to generate an appropriate exception and return false.
@@ -6628,22 +6649,10 @@ static bool trans_FCSEL(DisasContext *s, arg_FCSEL *a)
 {
     TCGv_i64 t_true, t_false;
     DisasCompare64 c;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
 
-    switch (a->esz) {
-    case MO_32:
-    case MO_64:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        return false;
-    }
-
-    if (!fp_access_check(s)) {
-        return true;
+    if (check <= 0) {
+        return check == 0;
     }
 
     /* Zero extend sreg & hreg inputs to 64 bits now.  */
@@ -6894,22 +6903,15 @@ TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
 
 static bool trans_FMOVI_s(DisasContext *s, arg_FMOVI_s *a)
 {
-    switch (a->esz) {
-    case MO_32:
-    case MO_64:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        return false;
-    }
-    if (fp_access_check(s)) {
-        uint64_t imm = vfp_expand_imm(a->esz, a->imm);
-        write_fp_dreg(s, a->rd, tcg_constant_i64(imm));
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+    uint64_t imm;
+
+    if (check <= 0) {
+        return check == 0;
     }
+
+    imm = vfp_expand_imm(a->esz, a->imm);
+    write_fp_dreg(s, a->rd, tcg_constant_i64(imm));
     return true;
 }
 
-- 
2.34.1


