Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D214E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAn-0003mT-Pp; Tue, 24 Dec 2024 15:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA3-0002om-2Y
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:47 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9z-0002Zs-PA
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:46 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216728b1836so49402085ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070741; x=1735675541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMXDaMRpMuM4NGt0K+4xH1eKpmwbvk+xmZf9n7LcDNI=;
 b=DmcC6s+gp6hiqc+SjBCQ1eCNGXcm93q8HWQzPcL1mtm5+eO3A80eU6I+PJQVtTC7sj
 hpnXyf8iKTZHyBzKdf7Du2smVrtx4Ac2/U6mKyV4uhpLJONjbdeEnm7IvbftoVMLuZ7b
 bFvYnIYR5LvvhqOA21wfod+c17FgFk9izybnCz7HytBpRFTiHxyOV9693A045jJAdMHM
 GzOM5Ufomj7UQQZ5lIytpZKVZPi6bGbhvwkeIvFS6v4vwMpB+hGGeWHDDc2Okn3Ja9i7
 yqq6XnE46Tbm4RUqC+85gnujWHccH3StbvChMgAsEd4Kvub+X+KtZtCkMz+t7bluDnvh
 X5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070741; x=1735675541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMXDaMRpMuM4NGt0K+4xH1eKpmwbvk+xmZf9n7LcDNI=;
 b=Gx7aH//Wi9jnJsI4wcSc8MHNJngg/K75QorTB9ft7qCkMoXirBVe8FekvDikU491Wi
 zQ3tuusbKZhI+LB4SOBGQ6u2L2z9vCUW950ulYImto0p7PIBHEvN7HqFMj0R2rCIF83V
 2O2w8BPkY71ggWbY+dnSBtHozng0kRz/twqQMQWMGTlNM6ijasUCjhaMzqXIbcmeo7XH
 eXs3mDo9h5iuB78VFs7gxXOQRPuuvbTko2bwewe5E1GVODCeUZKaY5F61AQvdUmBwvrM
 WlcMDve4JNMlHvmkc5KSPi6ENfqNA++NJVH1Q4TkfYaD01JjWbdgVRZG7adZ4Jqgu9Gt
 uTqg==
X-Gm-Message-State: AOJu0YyqQyc0+1BNMb8iGR3uTmXyy9FGKgsKR4rsnsoaeHTWa1P0Al/M
 9wMoU7Z+ukadtdIJczW36dqe+bC1x7JsypaVBtL6OOb/2y0FDe8ci1eF1vVCR9aXFzlZ3liLubX
 Kwj0=
X-Gm-Gg: ASbGnctVqf30MBpkU2VzgbY3wo5e9PZ3BsdD0BtwJYNiMb21d3aEge25kMwdt+ZseeJ
 rObS3DruAMcXwZYtjXRj5IHfVFj/Y+jXv9ipFqdrz6epu8AgynmbOvCCcHbYoaowy7dh9quCDBg
 KV2fLWUWs3+W04nwjxQit8eexs+nLZz9SG5lgg4RzFdcGEKAH1p3c8JfxJcdl+uHnHhBBvkPd2j
 hIYvgACInHX5mj2bMg/IyV2Xw1lL/+WXHy3hGghmzcDl0YyVmsGNYPMk4Ir6jHfp/SweXk0PMFS
 MZSHApzYIxPltBUyS4aKKlCjEQ==
X-Google-Smtp-Source: AGHT+IEOK4VkFKE+QqV4RsVqkW2qXui7w+8ney6fBdZGAhb49CXGjVgS1CyLq14iWMfHxgVn1AV0Lw==
X-Received: by 2002:a05:6a00:240f:b0:728:e40d:c5fc with SMTP id
 d2e1a72fcca58-72abdeb6267mr19386465b3a.22.1735070741555; 
 Tue, 24 Dec 2024 12:05:41 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 20/72] tcg/optimize: Use fold_masks_s in fold_eqv
Date: Tue, 24 Dec 2024 12:04:29 -0800
Message-ID: <20241224200521.310066-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
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

Add fold_masks_s as a trivial wrapper around fold_masks_zs.
Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 803bceb4bd..f948cc48c9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1072,6 +1072,11 @@ static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
     return fold_masks_zs(ctx, op, z_mask, 0);
 }
 
+static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
+{
+    return fold_masks_zs(ctx, op, -1, s_mask);
+}
+
 static bool fold_masks(OptContext *ctx, TCGOp *op)
 {
     return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
@@ -1718,15 +1723,17 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, -1) ||
         fold_xi_to_not(ctx, op, 0)) {
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


