Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A23C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRW-0000MA-4l; Mon, 30 Jun 2025 11:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRN-0000L7-FN
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:08 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRL-0008CE-EG
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:05 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73a43d327d6so1152074a34.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297341; x=1751902141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMI3zk1yx7l0ZvxOUeqOoFW7RCKjr7ZEIlQI75AA6SE=;
 b=KCgK177sx0JKReZZkHgLFD/2rLfzvBwXRahhM3WVd804UTxZlCZyOWWDMiQxF/Ypn1
 Mh/tOKVP8ZtKNwQR/c7l5nOfUrauMYmeICFZFw7AxYjyyro4ZUkSkXpE1EhVMYuQOyxV
 DSmmOKJawz0YAIAh5b7iSxiFC2wQfsdM2KCsgF1oCbqbWCBe9J9LFaym/CYK53BAHxB/
 pz9MGuT+gABsavWbfxtsDGikgWw+e7QqIBl6yVP7ZC9M4bDpxN1ewmvnCyYIETk19/4H
 Bfp7Lm0gNpCjKIXVU/1R2+IDZHKrj3xegqPuP8bVL9yCClFxPPNg1PB8fUgEtZSrVHo4
 F/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297341; x=1751902141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMI3zk1yx7l0ZvxOUeqOoFW7RCKjr7ZEIlQI75AA6SE=;
 b=L7+LY+/LmMAIz7l2bOXZCGCQY9niyhMa+nNdxDAltbI9YJNR1bAA4/qjYHdUrqUQru
 BsOe1cLsht5Ro8NckZL4JmTfXp2LMaHcIRMU3wmE8GI0Ty3dnc2I3T7d5p6dNAi2GrkI
 ZMnP+3miWTJaN+mLUab2ySp/tCTcXAd0/G6EpA0ugDAd6rwrxCpohmlc/XMiiUj37f5A
 5aZjMJTM7JniphYwDibHBuNdsr//3dILk+Hz7KodTYsJSfuO4NNiNji5SAzD+JlxlIo7
 /hArwIn/dnLjHsyh5kRydFDGMahzQNv7B/BevQHc+J/+QWgf3suCM38v01r+ksqvUZVt
 MVNg==
X-Gm-Message-State: AOJu0YzU6SbfENhGFSJjK9c/Bz6rW4w5+Ig/2rpBKKJYVcwEOrm/VzJf
 +EesHIHDp2a2zh8OqBktW5Ljy0//kLMuDC9p7aJ6haJ2sAkJtdOVDGPrYOyPtQC5JfLjJcHCwkX
 y9/AK
X-Gm-Gg: ASbGncv4L3q6TcINAMeL0gMPYQRemDEjzh7LaLUlv5vhWEkX3++37xIZ7okTA5BJSwE
 HngnjE6eV2PajYm9YJQ71XHDLhswVXUtrz6y0RUV2/MM787+7r91gD+hGhefMnW021x8MW2GZ9J
 hx/HolhmSLfMkZgk+UnAbN+KdcnjoknDh9ZujwiZ/Wa/0u0zRBXXazZX8wuOuJjAgvnaGhA0nm6
 bqzT+Le5CiNU2SkP30eLuszrgWyrrDZC0SNKlRjLfyyLxbM2ycgDsoSYdkiQSQ1v4oQ/DHdbfnt
 1k9g8xwEvKOLnfQTi1Dj4MXuW41HaXC2brFKoo/UhmYJdG1Pyx5G2p1PcjIg1jDzqEi4mg==
X-Google-Smtp-Source: AGHT+IFOimJtMECRJ37QymRBkd5IBS+R0nigGFd23VswaTuTca44zBjBci2ECOJpRrf5OpBeMhr0sw==
X-Received: by 2002:a9d:6014:0:b0:73b:1efa:5f6d with SMTP id
 46e09a7af769-73b1efa6d00mr3355738a34.16.1751297340892; 
 Mon, 30 Jun 2025 08:29:00 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/29] tcg/optimize: Build and use o_bits in fold_and
Date: Mon, 30 Jun 2025 09:28:30 -0600
Message-ID: <20250630152855.148018-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 49ef039932..d9ccbb36e2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1422,7 +1422,7 @@ static bool fold_addco(OptContext *ctx, TCGOp *op)
 
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1, z2, z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -1434,18 +1434,9 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z1 = t1->z_mask;
-    z2 = t2->z_mask;
 
-    /*
-     * Known-zeros does not imply known-ones.  Therefore unless
-     * arg2 is constant, we can't infer affected bits from it.
-     */
-    if (ti_is_const(t2) && fold_affected_mask(ctx, op, z1 & ~z2)) {
-        return true;
-    }
-
-    z_mask = z1 & z2;
+    z_mask = t1->z_mask & t2->z_mask;
+    o_mask = t1->o_mask & t2->o_mask;
 
     /*
      * Sign repetitions are perforce all identical, whether they are 1 or 0.
@@ -1453,7 +1444,10 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
      */
     s_mask = t1->s_mask & t2->s_mask;
 
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    /* Affected bits are those not known zero, masked by those known one. */
+    a_mask = t1->z_mask & ~t2->o_mask;
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


