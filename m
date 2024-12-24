Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CF8E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAx-0004CX-Nr; Tue, 24 Dec 2024 15:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAB-0002u3-KW
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:56 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBA9-0002c1-Pz
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:55 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so64870885ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070752; x=1735675552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RorC+bNoeysLqpLQ03oC4wLhRH1BlwQyizXHc+0rwk8=;
 b=UIgayo6OoaZ0+wtR4EIj1hnV8r1YZ04K8KkVNP+rkzErNcB3Lf7WWEFyzUZYT1aFzb
 F5OdkE3ZmlT6Dv6ADlpdcmxarVsnsrYw871lGzD81bozwOkOfmYDBbfxVhc52R4k199A
 Ka88K02fo1FfcKg3TLLEqupf2jGb//IIpViwNWqEhHgxJ/oN1f8bUytrJIJ1CMRJbFNd
 MET1h4LsPIwjAM+HtI4WcbQxbQoDTNixRT5MZSnuMRoI+g/JBXIy9Zkek6OFEw+af2kS
 /goYHbB1Gr94KGjXrrGDJKg/cTe1Re3kJ+HLhW6YaXgR2sVqq+Mt+EzAJ+vlclNNH5oG
 h1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070752; x=1735675552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RorC+bNoeysLqpLQ03oC4wLhRH1BlwQyizXHc+0rwk8=;
 b=W/DQNwL13ChyhHAeiNjvUvEygSXsvE5oquyjCdrb+rdrIiO2sh4yxZ7Y1rmPm/9M1i
 ifkApQgFOo1iKhVXxYXYiKl5fGuJ4/tv3OBk1gl2YBvY5+w0C67QYEP91jGqm/1hjA4J
 VpyaiBGMTfIE2QP+rzgDT36VBhNOKIJIebw+1iRZ/Bq6HqffrfZunJw2dxUvGhIr4SbS
 IlgVOoD2+YRBgSm7vHOJhkqAwUSLXlrL0OZH6XGMfYUfDSOwT1ONFj1lwiwC+lXCo8FF
 IcjIjmGctgLQeg5kyU1RUFaxRASWCCZttFAXHkvAg34MJ0UFXiqS8cIMrkHp8c+o8EVs
 bOcw==
X-Gm-Message-State: AOJu0YwMZiCe7q6YwTufzssDLm47qvC/4Fh7hsn6lPBrGQXvHZQx8LHZ
 Auw0Zwt/u+S2/6EdlcaJ3eGi8YijK9eBiVHLUEEgX8yAaKhz5e9FMA6Ea+P+YS6d0BkYuFXsrUl
 7l0Y=
X-Gm-Gg: ASbGncvspHigelU6DEmBpWyPeT2Syqxn7cvoDgcOVm3LtUKpQvVyEiEDLOoQ57ABANx
 J58Ig0X0nl1vuSH6eR1HvEPeOGUwQqMPChBrW+NKZZvi26+P4mcSkttlyuMp1GbvZVyfpTC9XvY
 ppIwnHCgBcNC9/dibsHrZ7t+d0VYZuXY0SmUei3XvCmSqnYdHwjGFm+NyiYMNSe+xXDrhp/mEC2
 aORGzG/MiTCGbRysW3DMvJN35/Vurx0736qVpvJey4IRjxrO/wRn01DM2r6J1eGh/rVA0n2F7Jk
 Xb+6eBoiBNDzupdUZC0w2gqnSQ==
X-Google-Smtp-Source: AGHT+IH6HFDZkcBFFL9TKKrQbGZOJ7SnizU0+LZpVQ7Ne8/QfKeAi3RwRsiwIZvYXEeENfTIF5DZ4g==
X-Received: by 2002:a05:6a20:914d:b0:1e2:5c9:6831 with SMTP id
 adf61e73a8af0-1e5e1f57c6bmr24704790637.14.1735070751644; 
 Tue, 24 Dec 2024 12:05:51 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 31/72] tcg/optimize: Use fold_masks_zs in fold_or
Date: Tue, 24 Dec 2024 12:04:40 -0800
Message-ID: <20241224200521.310066-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 tcg/optimize.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4ede218bfc..e284d79fb1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2078,17 +2078,20 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, 0) ||
         fold_xx_to_x(ctx, op)) {
         return true;
     }
 
-    ctx->z_mask = arg_info(op->args[1])->z_mask
-                | arg_info(op->args[2])->z_mask;
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z_mask = t1->z_mask | t2->z_mask;
+    s_mask = t1->s_mask & t2->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


