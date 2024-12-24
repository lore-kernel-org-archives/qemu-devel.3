Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EE3E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBA8-0002po-HE; Tue, 24 Dec 2024 15:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9u-0002lx-NI
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:38 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9t-0002Yc-5U
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso53747255ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070736; x=1735675536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/uXovwT+peKJg+4w3zvH44hwa1dOgTurwD+a66/j/A=;
 b=AF91Q8OV/RUZhcV3F0f6yyryH5Ut3fTIDNfgEafA7pQIkz9AL6WHSLjdZ0E/zRPhf0
 gH+2q9IrBvbRUuFuio9dg/g/6BLOTYcleSJdpFRCGYY/C/uc3imLH1mVh2EI79aeZpte
 zZ1+u1PnriNquBED8CiOvQiRRGzKKhaRjQwLGIcBpfPKfvN4KTsa6thJ3eJB2Z+EviZ3
 zv30Wnw0930dvEX+SoAJ1a1Aur43G7EybIUHxFWHvIYRSjd6VdUSTFlLiBEESPQMgBUz
 W3MZrwMxaUitfMBxp+PczFyyIg13zHafh3FF7yofSN85MM8qgraVir1IsDrKhjZfNKIj
 zPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070736; x=1735675536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/uXovwT+peKJg+4w3zvH44hwa1dOgTurwD+a66/j/A=;
 b=WCRWJ0hS5Qc0N/8FCmImpqoQhfrmAvz8voHNL30fJf2z5TrFYImpgTd9ZrN5/xSZYy
 M0m43RLbN4MpsnuemGbhKcm3O+BoGzk3Sl0nQtG1G3FIVNqsvTh3K8c5I5j/Bv48E6M/
 sEzdRdn0Mo0SGes7P7LocCOs4wLG9l5sAl88JzhSXuVcrO9xaIGCueP1r2F5b0VHo4Gh
 MqU1vrBRnWwC5h/nblXK2xBalIf88+lPVK2PE9bpoxnY31nfmOAsU3yuw5ntuc9egZ0G
 mKcirui55y20vkhE0dc/nK0qf0GiO6jv3xqq0x0yfDTX/ufTasMKvvnga7RenUukA2Yj
 kDoQ==
X-Gm-Message-State: AOJu0YzNUrhH8/Yl65YE8PpjZvaP2dKm4ncMSld909sxbPy9+gLS2nL9
 Vto0FWTGxoXLFFK98iU0DVkgGLakihBMsywIlOvim39gbLjIzGzNhxPO/OgKbDc86XCONrqeZUV
 AWcs=
X-Gm-Gg: ASbGncvwZbgYP0X49Fz8kUFIyBmH31Ah+i45TGVVFXa4rrAQAoMMt8/UT+Q6F/RlSuQ
 gQ+t2VK5i5Vs8Ur5CbgPQFm4avWflNMHGAFudnkD1zWe+sO74RSEUDxkF7hvYlMkHeimPreSa41
 nignGMnBDlaIT1QjKyrcIH+mi3v1QOMC7DYfQYkdtC47cIlw6I7RXrc7MjHQQ57GRggwmO32Y6C
 tOOHxLxLZLrCAFi3ggRLVCaN5TytlwT+7nXG8SjrL7pejRfaqb+M9TSRs3CN1qO2LJxP9JMV7//
 Dmr94M8I8ZBA15XLYAL7Wuhobg==
X-Google-Smtp-Source: AGHT+IGYu6HQZOrFX5XlLQJEN13CA/IEw/693zbVd+jqpSO6bK2B7EDsYe9fVG8mQzejx2aAZLWEmA==
X-Received: by 2002:a05:6a21:3a44:b0:1e0:ca95:3cb3 with SMTP id
 adf61e73a8af0-1e5e083e416mr28581928637.37.1735070735680; 
 Tue, 24 Dec 2024 12:05:35 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/72] tcg/optimize: Use fold_masks_zs in fold_count_zeros
Date: Tue, 24 Dec 2024 12:04:23 -0800
Message-ID: <20241224200521.310066-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Avoid the use of the OptContext slots. Find TempOptInfo once.
Compute s_mask from the union of the maximum count and the
op2 fallback for op1 being zero.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 054109d347..0766a452b5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1566,10 +1566,12 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
 
 static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t = arg_info(op->args[1])->val;
+    if (ti_is_const(t1)) {
+        uint64_t t = ti_const_val(t1);
 
         if (t != 0) {
             t = do_constant_folding(op->opc, ctx->type, t, 0);
@@ -1588,8 +1590,11 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
     default:
         g_assert_not_reached();
     }
-    ctx->z_mask = arg_info(op->args[2])->z_mask | z_mask;
-    return false;
+    s_mask = ~z_mask;
+    z_mask |= t2->z_mask;
+    s_mask &= t2->s_mask;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_ctpop(OptContext *ctx, TCGOp *op)
-- 
2.43.0


