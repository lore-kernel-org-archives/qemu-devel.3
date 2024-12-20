Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647F9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUQA-000234-HF; Thu, 19 Dec 2024 23:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPS-00019J-Cc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:47 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPQ-0006qY-ND
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:41 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-725dac69699so1341488b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668079; x=1735272879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTDMls7e5F8COX2pnh1l1cFEzOeTN6vk1DRjDz2cVHM=;
 b=uc5FR20CKs8swpIdVSecAkQyUrWM6CWJMGWHc/Z6BsJMDWtsEOR+uFCY75ZzCKeklj
 Zf6d7EfPpShSRhXsGkmEtnb8UyuPo5bQwTlpGyKrlLgDYEQ/RYR+raNowFzd49xF7jc6
 UpemXGcOVoTcXS+gXRio4O2esWWNNE6q1FuPWXTNOjIYuq3OZ/mjHKRDzngI1L5iI50d
 gFte+dP4HE+hsshRBALkdbu2Q/ZQ+UhWR6Q3C86NXNVGcnVxBkOnUYkCfw/ycQxMijdP
 o5LZ6nwdREh8p58sH4EygRelPRNQYNAanfyKNhQzM/MKTj+R1nI+yoJwaUdad5HK3GUa
 gUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668079; x=1735272879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTDMls7e5F8COX2pnh1l1cFEzOeTN6vk1DRjDz2cVHM=;
 b=i8iLrXcPUoXL2n6JynKpabZiwTXhl2CbbIdeErAJd3Lc2LKm+TYXreeB7PM1fXfR02
 jICfsP7pEAvJxBkehhv/YJ4BzJlFXmZUH7A5xXtI9Pfb7K9HKJLnxBiyN4v10L7v2mEa
 z9q1zs4uqXFbWR1JQFzMJZhHjhSpYTymL2fBXksG1tf4+EkuolNvpwDLTLt09zmWWFrt
 C6ZOIkIcehdb1A4nER7VR6fFenYPS9mTvl9LRr0PXC71yKoXL+Lr4DIlYNyvXoCBLsvu
 tYxb9RJnIgYRBo+Jf5X4IKzJT5XklYg7eq1YDSEMIlqd3h1aN1/qTDEAMMB999Np9Ki0
 c+Ew==
X-Gm-Message-State: AOJu0YyyQzAJAB/TjuI35YFzoUIuKkB6/kAkZeLJ68E67t6IgBq32tlf
 A1Vy7UC1cRRZqPiiLydQsNmp38NASLUuuRBIYzxV8NQyCxviCgz3wYU/UM41vAqShJyy1ZKGMT+
 b
X-Gm-Gg: ASbGncs0H/rtREW9/yqcqJO8wC7NXDlbLZvz+WNvmmpJmSUi+/aRjXc/5Gmut2u9rHl
 SCGKIHVjaqbFgFJZo0QtzTxHXvMhIpJysJkDX2Xc2OIHWiP6L8lgQO/ZugoK60TlUDL+tr/XWnp
 Wi5wMhHppMONAe/L+H8y4hcJc/MLPIJEj5YMgGi9XjE0hBIp+CHMkcFpdq47GzQSRqjklUayzH2
 IEimq2OS5KeYAMcDePl5d6WDAJ8tnzz0v3d9wJuZDFzdQ6FxQ/2gCmieibsKgA=
X-Google-Smtp-Source: AGHT+IHnzHbHJIy1nS98CAtTEeTxdzl3rH0TAuG59hILFOmdQP9zRXTjU7AUj0O/rhnZFyZd+J5h9A==
X-Received: by 2002:a05:6a20:7f87:b0:1e0:d0c8:7100 with SMTP id
 adf61e73a8af0-1e5e0447f07mr2859361637.7.1734668079560; 
 Thu, 19 Dec 2024 20:14:39 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 45/51] tcg/optimize: Use finish_folding in
 fold_tcg_ld_memcopy
Date: Thu, 19 Dec 2024 20:10:57 -0800
Message-ID: <20241220041104.53105-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index 56bf3c1aaa..0a84959f4c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2713,7 +2713,7 @@ static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
     TCGType type;
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        return false;
+        return finish_folding(ctx, op);
     }
 
     type = ctx->type;
-- 
2.43.0


