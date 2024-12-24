Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EC5E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAI-00033L-Gi; Tue, 24 Dec 2024 15:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA5-0002pt-If
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:51 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA3-0002aY-C7
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:49 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21670dce0a7so73888595ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070746; x=1735675546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFhNaTorOWcHDFv/B5ASCBB74fNXcu/plUbi038NaCk=;
 b=j4tSOPVV+oTkrDAZ2wkTvij8JL3aoam2F0OcLOEEVmlUN5rGTHci0u/5rm2usrLfbc
 BqOJ/jJoULvNYcA/tGZuTuoFun+tME1L+JcYCgIC1rAUoQ4DubhQa5+yRhDQ8GMUjsnF
 yu3cnSjPKoMWXS78uLK6JHgtB+MNL9ow4Vf3FXDE6QZPDiFySpiuGc3egYfxYeQZiFSz
 q89ws4nAGmV/FpGH17P6tlkaOrnVF9x0OrLM30MJvpQhusPDvrIznAcABpLWLz75UObE
 OAKkk0jP2weDXRbGs6j+MxD0vVoLXe8TTlToRvuCytquSrNLk98CfpiqJaS2jrMLnAjT
 O78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070746; x=1735675546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFhNaTorOWcHDFv/B5ASCBB74fNXcu/plUbi038NaCk=;
 b=wMuOcVtZ0a/QxvN3DxBTeEAJqlDKCMUwV6gelFaYSYU72HqVxt4WJL5n+AxhOXK1Ik
 R5p79MEVA64TDnVf5vccAZ6KjAi1vvo67LXkehkpmJYX5EhUvqrDIt7HMOONBbIkrUVh
 Xp4oSbDPJ4JFN6i42PCA8OFjYl4NMVxNrqJmtQrDU7jNUAJQc9uu13QXYLxwYsu9HZVp
 tdl6/KAnj65rZbVDrJIS/WKn8m+XnPfgTzzV7XlqW1XdABQTqcxZbU/r3TuhKpnkiA9E
 ZAX1Qztzb2MqU0HGc5ni0AGmJ7ZVOXXRG16VtIYe/0mB9azz3jry/bPd4k/kXs2CNEaO
 ibow==
X-Gm-Message-State: AOJu0Yx8IfHxBU1fnmiGsKgCVB1zvVgKwq2eG+AYEHYGNnIUEPlpvK7y
 8y35wcqtj9C2Pj6rGG/Y7l9bA2g/UsPl0Oq2pMM17Rd7dz4GTO7DAA+i3lG9/4te/ub/BDsbHcI
 kocA=
X-Gm-Gg: ASbGncvyemmWPZyy9dQvICRsNyB66TzU/pkAf4LAdlGVvOlyGuyeWbbXas3K67rlerJ
 9GrHqcIPIxKyPjZbccpInXbdqEZHzQbEU1UYQj5hzUoHeCBAgNoq1ITgUsnjYEIWtTInJn9dHFC
 ApGaKcQWt53zYsJ9MtCYdvKMe6jcGDp427zLx6aPErd+WeZfYJQzj21PO4Yb5eodK8b8OPGiQgu
 7tn7TY2zrocv04kqgSstMcHkmEaP2qQPbU2hvfx5EbDdg+lStHzrQUFBd8Od/hZkjayKQjSA1is
 AI+92aD9yRN3JeSM8JvZ+OC/ZA==
X-Google-Smtp-Source: AGHT+IG1BqmYE1D0LDJDZazW7vpgIbbcfBkLWAH0N1uOLBiyMV1W+izHUY3ZF8is/QKqM2ErxkNcJQ==
X-Received: by 2002:a05:6a21:9017:b0:1e1:a434:2964 with SMTP id
 adf61e73a8af0-1e5e0459369mr26829413637.2.1735070746221; 
 Tue, 24 Dec 2024 12:05:46 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 25/72] tcg/optimize: Use fold_masks_zs in fold_movcond
Date: Tue, 24 Dec 2024 12:04:34 -0800
Message-ID: <20241224200521.310066-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f62e7adfe1..0104582b3a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1889,6 +1889,8 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *tt, *ft;
     int i;
 
     /* If true and false values are the same, eliminate the cmp. */
@@ -1910,14 +1912,14 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
     }
 
-    ctx->z_mask = arg_info(op->args[3])->z_mask
-                | arg_info(op->args[4])->z_mask;
-    ctx->s_mask = arg_info(op->args[3])->s_mask
-                & arg_info(op->args[4])->s_mask;
+    tt = arg_info(op->args[3]);
+    ft = arg_info(op->args[4]);
+    z_mask = tt->z_mask | ft->z_mask;
+    s_mask = tt->s_mask & ft->s_mask;
 
-    if (arg_is_const(op->args[3]) && arg_is_const(op->args[4])) {
-        uint64_t tv = arg_info(op->args[3])->val;
-        uint64_t fv = arg_info(op->args[4])->val;
+    if (ti_is_const(tt) && ti_is_const(ft)) {
+        uint64_t tv = ti_const_val(tt);
+        uint64_t fv = ti_const_val(ft);
         TCGOpcode opc, negopc = 0;
         TCGCond cond = op->args[5];
 
@@ -1956,7 +1958,8 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
             }
         }
     }
-    return false;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
-- 
2.43.0


