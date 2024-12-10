Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569B3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26Z-0004d0-Dm; Tue, 10 Dec 2024 10:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26Q-0004Jv-7p
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:46 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26N-0008Na-Bd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:45 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eb7ecc3c54so115794b6e.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844281; x=1734449081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a4N9bPFDP7T+aM0K2UyKGwYWn3KJAmJBBMEiibnYB2M=;
 b=YpERKivaD1595GSpJ3+13xBbuEfubQNfZeGI5c2w8RB7nKgwy7gire3zctbZETB59d
 SNGKkhmmZxFdTdsG5KtoUVbOHoAVTi63zFzsO+DTbFzfkw1JfuwrOtCmSK3MvM0T4kfT
 4LtC8dx6UyqyDIbLSaEOhJ+dStAXKo3pq+U2lPQGHPj2672/pQZQPnaKPPNoqlgDQUxx
 v6I+dhZASbzWMITF09OHXS5O3OaybyV/Xj/1DvhdkIKzHpV0i1B284tBpWFFpxdW9G/I
 YivrjgULb3v6dcqSVosJP+TU/nesCf29REO7CGjbLPr1isRKJ8SClaO6taIqAXVM3qj+
 90RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844281; x=1734449081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4N9bPFDP7T+aM0K2UyKGwYWn3KJAmJBBMEiibnYB2M=;
 b=RNv+EpOELeQrrMHQslaphpIL74shW6IdAegu5sUJvJ+nmPamA1nc9B5h9WbHQZVi/c
 xr8iToIwqFLuAZSI36ZuvfVo3oSbXZO83Fvp3ttDjzvHRlhe68QAcNDmbLVaSQwueSpo
 cVyzJICGrS0NaO/mhEwIBS/EnAlaZ2ubLU2AtK4ozqKw41nuth8RgMmSpQDL8FIFAULg
 rUxMpXhiO9kaGgjoLId+6dWFZE8vglhMwcGfc57ajV4MKnJ4hsxBxlwM3lWRXCciizV3
 QjGL95lCv4sSAozzdHlvZBDUVEZjUQOfXqo0DJiWdaplmM5Ki0wYLbVgKS86ZnvCyq1y
 B/8Q==
X-Gm-Message-State: AOJu0YyiGee5OC1wr9Xwn21ipHBepLLiuzm5/a4Am4dYFL2QQ11Bbiww
 boeOWZmRHlm5vr1IYarZD/SY/aMypJPbSyiukinT6RtbkT1p505Ctqig8rA8oTA4EJaHr3oVg2o
 kaiuH+hwQ
X-Gm-Gg: ASbGnctvUWoNjdwsseLgIKQKx5/Ch/RopqsUCjaJ58V8qiVPALp1taxH1/gyXLIVDND
 L/rd8RZAP5r+5PQ8HfJglPQqKMbWV5A5YWl4xvSgyp1b9zD5b3JOK5H1Zo+eja4XueC0+r5xKlD
 s1od28EfrtYdlfTtEDaoq4oNbZBPQJzt8xab1LYVzwwlWjRucKw9zrm0LMp03Z28Xs4RTRDuQuj
 FrzEoFmSGGev9PLr/maRBYIyd5oHtlXkjdFwcdOExDy7lMbtJKeqKvn2gqunQ==
X-Google-Smtp-Source: AGHT+IGh7aJ2ScOPK9umcaQIuoewctDjQausuNn2T5BLWGacuChBb0YZIBKhNNWiCrYucieiw8bN5Q==
X-Received: by 2002:a05:6808:498:b0:3eb:3bcc:a9e7 with SMTP id
 5614622812f47-3eb3bccdcd0mr6842475b6e.34.1733844281423; 
 Tue, 10 Dec 2024 07:24:41 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/46] tcg/optimize: Use fold_masks_zs in fold_orc
Date: Tue, 10 Dec 2024 09:23:41 -0600
Message-ID: <20241210152401.1823648-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3d852b44e4..76ad02d73b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2078,6 +2078,8 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, -1) ||
         fold_xi_to_x(ctx, op, -1) ||
@@ -2085,9 +2087,9 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_zs(ctx, op, -1, s_mask);
 }
 
 static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
-- 
2.43.0


