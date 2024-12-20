Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3006E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMO-0008RH-AT; Thu, 19 Dec 2024 23:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMA-0008OH-8x
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:18 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM8-0006JU-Mi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:18 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so1398045a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667875; x=1735272675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5rs4vqPumew13A8ZSX+8VQdxJZqMApYfWlhr06K4Zg=;
 b=s/rDZ9KKJbgirDDL8FUf/SJdmpdN3IOwpNEsgnA5Iu3NyqJhIwGBdGcpsH7Gk5BPe4
 m9fNHiaMpyXKICMxYA0Gvk9ZLFkNVm8CZf0Rei0XnLgLcCe6eMjhzYFm+upUzpjk0Ipj
 k779AAwwP8N270KUH27yLLecmA3EvIWsgwQHnlfmboN7SQa0hGOpdWV4gJr/5TSypc5t
 FDfC0VSb+YEF5G2fPG9X8QkTsleUMaL5bmB2rDhPr8/S1i/X7VksSPrIzBjVBnqoK/S6
 emOJIAVC0c+OkrR92td4s2080RPe/2UOzCfEuDFs3Hz0FamoSOkukVb5nDx2Y9dv1jTD
 UhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667875; x=1735272675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5rs4vqPumew13A8ZSX+8VQdxJZqMApYfWlhr06K4Zg=;
 b=CZ4t7kLImjRbKO57wR1Mk31WEvOdZleo3bW3/ZH2HmMCk2AS4sUmCXy32NSR3h8eGl
 X2F9UMkHRqOBp5oi7RoUZHKJCZ+fYsahBofKM87CHxxyTuyHunjiiJanQE+Xo0ZsoBqN
 TMdPPgRspEeW1Px75K9v8yGcWEOzDjDaYsU4giOrqOu4n32+LP6Y2mPxJQ8TOCC/r+mD
 gac/+I/5uOGqRhtWugKr+5u7Ko1FuZVzKZdSpmKtAXYyP3QxF5LP5cP6aQ5DPg8O83FQ
 Z8BJS0y+mfbF7Hgp2UvKV942cq0kBoIH+np9dt1MNrpyLItgLcB3ntpkuLaduVfZHMJz
 IzSw==
X-Gm-Message-State: AOJu0YzSH366/nP/BRkxVSYQ+GZ3UOiT3SJdoJLB7Wu6AuEdYhHQlHbh
 EpTM7XlVwBfz4V2NM9DVzV43e6rL4gF6qWKtq8z+vej6e9oXJvZPkVVQo0FusrM6g7EGkN2nnhd
 w
X-Gm-Gg: ASbGncum51r/1jRK2mHbyHwyxds5r0HlEmS+E0Vm21cOCzVAAVbQx0cfqsyYE1YqAsp
 OQH5XFhaUlzU94fTWUMgDDB03dXdtY9Y91w5E5rjaEUba7BLYA7DKID/shaCnzhcEaTamUMuuay
 fv0HgDQvVbTZEP0uGTkWzDfNqYX6/jteLv6Aoeo1th7S1taCz6a3AH0wKukyb7iYlM9D0YmeRMT
 9g263gcqZIDqVgtxMitUyV5c0x0OLv3rIDODosNcLfJOC1Gj0cgXH3h0KX34IM=
X-Google-Smtp-Source: AGHT+IEEsEgp5pLsb9HDGntalkPQvXsBQrwYoRNhzWNHpKbMr6820mLVrGm81g1qiYmxcfAKgI3njA==
X-Received: by 2002:a17:90a:c2d0:b0:2ea:8aac:6aa9 with SMTP id
 98e67ed59e1d1-2f452e3ed33mr1988000a91.21.1734667875192; 
 Thu, 19 Dec 2024 20:11:15 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 14/51] tcg/optimize: Use finish_folding in fold_divide
Date: Thu, 19 Dec 2024 20:10:26 -0800
Message-ID: <20241220041104.53105-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e4f68241ce..0ae96f34e5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1704,7 +1704,7 @@ static bool fold_divide(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 1)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_dup(OptContext *ctx, TCGOp *op)
-- 
2.43.0


