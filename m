Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720B4E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUQk-0002se-Su; Thu, 19 Dec 2024 23:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPU-0001MR-1u
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:49 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPS-0006qu-GJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:43 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso1737340b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668081; x=1735272881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnCYLrjrRoWxGmpvDns+P9bIwvUmd238WAtJ1MV9Lf8=;
 b=GSXSwG1kFf+QKhVfktH4p4zdveNpLpWr/st2HLqwDPntXQFMJCW+DSyvQT2ZfUE5zL
 SISVf/DRWLecmGYq5HfyFqIc6I/tDS/Z9Nhhv/s7ESR9+rINkGS3s5WrO1QuIqKupYtt
 sS2bXbDRSltjNsMLb+EKYyZan7T3e+pB9Yx3po+npRM6VcidWcfgVwaW03yzaxKfTKz1
 T9jolCc09msIRe4IkHQXnqrUgRlz0akczbZHrFWGyNEa4a4lyFYQYB6lq52QWkmyMxGO
 j42+KvIUT4VK1W1biB22l1oNB/9SKPZMCpWPyu0I1jZia720SCPZ559OL3K20p+rPTxI
 RSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668081; x=1735272881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnCYLrjrRoWxGmpvDns+P9bIwvUmd238WAtJ1MV9Lf8=;
 b=r7WCoSaaFbn7npljyhrhtXVe5xDX5ubsuSDnbV4S8YU+iZrpKrQwueR1ZsTyKtO10C
 +e16hgHLfIyRE76ngg8nHwepRi3WyBMfEJ7goM8hnzTyAtX9W0iIQC27ryGU92KTV9DV
 7zwBc7wSeXAR2OQ3wk9WgzaLiswAWDGBDLGVwssgUQGJfE1kEAhfDUq+7h2dSEnzxQIT
 mhXEF8jfzdJCJtAeMomtRduQoKcg9zfKD9CcsV3NgbIxW19xVgPECMIkhEQOgY5a0iC8
 ts/zQA4iLL8xADgGq47Mh7a4Xns85UqrckFYsmpKmuN0Lh43N2W49eaaPo0RRNskaKPz
 Kp1A==
X-Gm-Message-State: AOJu0YyflNO2t1pFbVttZg6q52LGkLWK7r7SzC9kv+PXj0bmq0b6hGzT
 LwLL7A+9FCX2l6FAnPJJhxbFnQiNYHVGic2mePiTf/QGqDrnOFPDWwv57j2Fvva7wiZjNEsvLoI
 p
X-Gm-Gg: ASbGncuILpA9EyNRzGWBD+lUKhfaD3uAsNk9c2hbxi/K8Gs+DY/D5LzspqpGZX3eKsT
 K5J1XwEgFtPut01/LL59dqu6z92VnTeoNCX2mO+B5XYoQ133ZMx3Bahkj4pN2+prgOOaRd1zL4S
 bT5Hd/w/m/PVD6cxnQfu42Hc0Gpot2Xf0bO8NlyUuypg86i1hUsBG/mFcSgw4siCQ/IEqopzpXv
 /nZtEF7LLYv0UgVVuci6kB2kNRDQhFaQWEqDe3/qVhTeC0SugXGodbf/Q12Smo=
X-Google-Smtp-Source: AGHT+IGrMXwEgCnARyAnl0cZWJ0hZeGFUwfiQz3HAh8YyT1sF9v8axh2Og6DzJVuehfEG4fG1TJw8A==
X-Received: by 2002:a05:6a20:7343:b0:1e1:90bd:21a0 with SMTP id
 adf61e73a8af0-1e5e081f33cmr2734296637.42.1734668081042; 
 Thu, 19 Dec 2024 20:14:41 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 47/51] tcg/optimize: Use finish_folding in fold_bitsel_vec
Date: Thu, 19 Dec 2024 20:10:59 -0800
Message-ID: <20241220041104.53105-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index 6f81d2e831..74d1ca7484 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2861,7 +2861,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             return fold_orc(ctx, op);
         }
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 /* Propagate constants and copies, fold constant expressions. */
-- 
2.43.0


