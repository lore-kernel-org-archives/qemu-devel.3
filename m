Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428A9E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26Y-0004bA-3C; Tue, 10 Dec 2024 10:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26V-0004TL-Dj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:51 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26T-0008PE-Mw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:50 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb66b02e1cso463116b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844288; x=1734449088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PsgEEaWYbAAaBs4PCAgZVIYW4c8IauZDyqu8ElASbpc=;
 b=fc4fSi0h2GW4kMXFcu7xcjX2oYHaqcmyilm+pARIRRiYpMdtgCPNd47036y3We6s7C
 6qctHNv9kva5KYhC54iyHr7IRiABtHSILz2tsEn3LlOrzCPDCAZkM1jyO/5R5p9/NhTo
 uWgZpJI3Ho+7mmcqCX4u5hacxJ2g4ThwoRWuWThwGOZknNkZwk3TC2xyuApd8sGQCGAr
 uf7I+rcoq/QKM6f+bXLJMpiZu9Kxx0O0AZMRr14kYaShgQcjxzRFzXq91FgmogYKQFIK
 U8qaYj4NfRyuv49bcognYHtdWkZfG0CHAG+jFDp2EXxsnz20SmZo24qbyhUztAIppHxi
 m8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844288; x=1734449088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PsgEEaWYbAAaBs4PCAgZVIYW4c8IauZDyqu8ElASbpc=;
 b=G4kZPp4bd85UFg83KMhD927dlbDKvKNIX1ZLUP7yvwCoid3jrwkaqUUCDfXPHGb8wo
 3nmq9mZnTqgYWNDAo6w4Nfkj/lD4U6yY09XC+yKQaND/6UFAs+LNFCKoEJM7UzHDPB1e
 ZUtjKQs9HoHwlfGb6/zIcfctcLzmehyqa2AwD3dPH2+9ZC0K7gjBWDyL+S/6+3PFGFUM
 2XsdexbtXMO+1Z+COMesI3UznuQ1Q7NGmXCmGjp2ht4e9WBsom+zjb5pzAxQPlKrl0iC
 iBvvgJGIl4P6p+IzYH3ZZF97lX0hq1TrfvYCv3yjk6g4NIsBgvPjyLdf86CehvHmpu8w
 HXag==
X-Gm-Message-State: AOJu0YxKZ4iZShGC1M8qiksTJ67CXKnDR5JQrVkECJdsSQ72IWou76yO
 TxwJ1MJ/L+7WfVVExbqTRXMKMZxyL8kLC7XwViprBGX+wVJZqr81czECeoRZNLWNgIgPEJdu67c
 nG9zjUMGM
X-Gm-Gg: ASbGncvf2jjOmIeP/ZP19Cj+q5OHRbGKhEwzqPHKGrcIa1lpJfURWROyPhiNRWfMyV1
 JnPPX8FbvrRdWDbONb4jPGiXeIHKK5RZzQlx+qvN1iXemwZCxqp2sKvzTr/EuDaGSqgefS9YwrA
 84hLvThvS686iyhP4JXMpIcCVJ16btmc8YF8vI3q3I3j83vtLKI2wmGcPpkJAGHce4BhwQvWpIt
 nBjhPxT5FkWzGVHH7wMbqGkNEx29qiadp1CqU3H25rIk5GzicdtQOckpb913w==
X-Google-Smtp-Source: AGHT+IHBqE1FSiOGKxiBF6JbQaO9j4Jtkz3q80ye0WNjwBe9hDqOy5HNFBoSYMC4ZrlfG6Ztv9nNWA==
X-Received: by 2002:a05:6808:1493:b0:3eb:3dd6:81be with SMTP id
 5614622812f47-3eb66b8263amr3576482b6e.0.1733844288608; 
 Tue, 10 Dec 2024 07:24:48 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/46] tcg/optimize: Use fold_masks_zs in fold_negsetcond
Date: Tue, 10 Dec 2024 09:23:47 -0600
Message-ID: <20241210152401.1823648-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index cfd4c08f11..0097502425 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2369,8 +2369,7 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
     }
 
     /* Value is {0,-1} so all bits are repetitions of the sign. */
-    ctx->s_mask = -1;
-    return false;
+    return fold_masks_zs(ctx, op, -1, -1);
 }
 
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


