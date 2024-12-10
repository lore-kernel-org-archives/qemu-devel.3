Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1CDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26a-0004fJ-W8; Tue, 10 Dec 2024 10:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26S-0004Oj-Hm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:48 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26R-0008OH-3F
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:48 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea696c4dcaso2750947b6e.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844285; x=1734449085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=04IBAbHCp8s0J2f78g8j58qzcwuLYj4MNA/t29Jadew=;
 b=fBeR+8rl4S9SFa5bkLl2WNCqbylaOBT3eK0yVMYSLurmrxyozL5yELPBfjjwjHHmf2
 Ku4XUNanR0aP2sWmbRxFT46as60n+pUFbn4hJVjYsVDc+FOSSUdhwzaFkq+JtuSY4COf
 aStotZAsUBl/6BAXoJGnrwZOW/tZ2Znoxl3XfgY/lTRMJJg38xggoeiHDdjzMXElPC2l
 dEM06sz3wEai1ye51VkrZsfWvZrIsi9d4dH5Yt7Yfd9+pxA6q3gAlCTTasSFXD9VZOaT
 Zy7mzciY7sOprD9AWYEK32v5dq8NxbOCsxsMBZn9uEItY1khS5IkWjsiwfzZbnwznIHb
 HaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844285; x=1734449085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04IBAbHCp8s0J2f78g8j58qzcwuLYj4MNA/t29Jadew=;
 b=uQQI6YL2cjRA35SsXerfaCtJacXc1/86OaqN9ISfDOhOxMLzlNdu/t4jgr6TB2CKPC
 2wJjtGs6DG+Ce4BrBEiLAe1j3wPTO6YboPKFS9qYMhNo/p5e4oKhNhD6iWo3weVLmfSy
 UdPbM1JKm+D+K5Jx1D4KI34fP2tdh2JwOg9q1vyHMlUGE7iKvBxiV+dQdXh+9VM5rmhm
 2S7gJ6ae94kvS9H7zgUHekRU6JZ8BEatgAaSATMvTX5kLFdgGdqLcjtp8BqdN68SxjIw
 czkpKEe74JXB26DylKl7NWT52knJ/f1PQVwVTmIUGrQwNQIWhbArycG/n+dbPDcfLIG5
 Chiw==
X-Gm-Message-State: AOJu0YxkMJPPs0bkr42LwuKzCfMcRe2IhVG8Bz+5wztn2BKIf2EIS3an
 /DaGTRnfZg/tocW7YMAaCX0GMbTO3EjutLnd3FeI7S2xKS/+BN0hjy2dUF+Sgqs6cekvSfjyQYK
 +9vj3Rylz
X-Gm-Gg: ASbGnct3InccTjfVH1yAc0jFXieYyDvugAni2TYTqCqMhV0+uGAf2eiVadZz1FThV0o
 QVIgoiqbEcgDlB/obHOWhj8xKGTD0p4d70TxWYDWZhsUVEfmifn45bl6XpvZm1j0w9SsPayXfZ2
 KZuzhA43sIENrNF06thxVBPOMYTkGgIwzIaa5h8/lL175G2IBAOQb1PXpuce18ctsiaqt4MaOzC
 F0SPVHLbofvKEQlQWZI/pcsiu5MlK+cq9Gv4te4vUeFAPJqPJiXJymhIlokFw==
X-Google-Smtp-Source: AGHT+IHzah/c9omnm/LsdtU5V0YjAUATOBQhIM1c8pNBJPdX9XvESGQWYtYUB3Ld1AADw/3PCc7BEA==
X-Received: by 2002:a05:6808:1802:b0:3e5:f4f9:3280 with SMTP id
 5614622812f47-3eb19c770c5mr13079993b6e.10.1733844285359; 
 Tue, 10 Dec 2024 07:24:45 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/46] tcg/optimize: Use finish_folding in fold_remainder
Date: Tue, 10 Dec 2024 09:23:44 -0600
Message-ID: <20241210152401.1823648-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ee00620ce0..eac5ef5eec 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2134,7 +2134,7 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
         fold_xx_to_i(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
-- 
2.43.0


