Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714A8C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBx5-0000pz-FW; Wed, 28 May 2025 04:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvw-00080P-IC
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvn-0005GW-Kc
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442ed8a275fso55593365e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420074; x=1749024874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODczWVFhugZyrfXTTAs5E9r1pVIS+LEQMKc+n0efkhM=;
 b=kQcqn/XnCKXuEeguocT4CnxMsF8/7A4IhSCjMzdzqi+yUvbTSwVTwXqkw64HqzwCgY
 Os9x+MoRfTniHKvDILWa/QwREjmwCcc1Pv8U/ey5of1Ex7EQ1EPXNrNVKBsyCEU4yxPQ
 2+ShDWwgyjVTP4tGQ/Q/2iq37no4hzf3KluVmaZzl7IvhUMnArs4sdPootg3Jk8qAIW5
 EiGtojo6wGfCrtmN666ygXYTUKXZ+9UIpIidOO+bCZllStcGmKrYgubqiKMh0q0O1b1R
 JySKgKJ7hXCGMgUYbX92BA/I79rMu5kRKNJDtKHWJ9V6rJvJMEcqE8HWsYTwlBwRf3Ts
 HYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420074; x=1749024874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODczWVFhugZyrfXTTAs5E9r1pVIS+LEQMKc+n0efkhM=;
 b=Ce9cbK5WC4MFe5vkauockQFdKIlbof/ENZV9zPVmgZpfucWfMwQX01pp2YTtwvjyXk
 R6DUmmrVhmmX/B/TDimU0s2Q2qpCpWtgQJk7Kjk/D+74BNOz/JXK1AoiGWt560bt9uHn
 InO+9UXqIWKFKRn14D8RuEQfQ4Xwy61b3TMU4V2Ygm0MfzmWU6jmrxdsyE6Yn6vgEFb5
 bNe+6snoiLo2t3axEuRFPRtzra3QO4G/9TWV+3il1YhwlVuU34a6ixzIQnTR17Cq3uNb
 ozk9ZtmWkQTpUBM6Hx2VExVOoG84WGenxs8mWV334LJPa+EOLifMzhZAeyiD5RZNMU64
 50jA==
X-Gm-Message-State: AOJu0Yz403ZCvSH67ly/OnUrYRa6rN8rCDkjEJt1AdYCjmWxLrtdfiBC
 MoTP7PrGyQKbaFYlsS8jLc/i2eUjjmksuP2xaBmmA1SzeNs15Dos1L4lUk9F+mKDqnTdjoVVZfT
 UjAmY8NauEQ==
X-Gm-Gg: ASbGncvpZeeVGDx4rtz6vxNiooCT+NLOqwv3ze1GmpI0obzBA8K+rSpnYZdvEldA+8t
 eO4CGRZlj62X3qbOTuZECG1WqkUuX6X9HWVYKb+r1678m42HOnuix/WE2lK8PAY+cj9EZRGjnv7
 izcirePM6s4/pgLjd/4RH2BZB8C1I9/noli9PAxwxWgXUazplpPqJXHPaI3Z/esJ6GedhBoYemh
 Tzf0qkOxmzUhE2Jl7EZpi868bnoDLDCwNBUXFhhvDyYM03Lu4DvmaXF0hkFBjYPzRH71j6MGv1Z
 ls/tRTCreI/ZOsN0f3IFPXNZQsJVfWQjFTguaNXd5XF/Ftq42uoFrlTZ
X-Google-Smtp-Source: AGHT+IEzfcHS6WWiJ2+ul4XXuWeJI51WBtKspp8e4mjc9r/fNA1XnXZE1nEgzHnmYamLV38ulwykjw==
X-Received: by 2002:a5d:64e7:0:b0:3a4:ea40:4d64 with SMTP id
 ffacd0b85a97d-3a4ea404fcamr849888f8f.8.1748420073947; 
 Wed, 28 May 2025 01:14:33 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/28] target/sh4: Use MO_ALIGN for system UNALIGN()
Date: Wed, 28 May 2025 09:13:58 +0100
Message-ID: <20250528081410.157251-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This should have been done before removing TARGET_ALIGNED_ONLY,
as we did for hppa and alpha.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: 8244189419f9 ("target/sh4: Remove TARGET_ALIGNED_ONLY")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bf8828fce8..70fd13aa3f 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -54,7 +54,7 @@ typedef struct DisasContext {
 #define UNALIGN(C)   (ctx->tbflags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN)
 #else
 #define IS_USER(ctx) (!(ctx->tbflags & (1u << SR_MD)))
-#define UNALIGN(C)   0
+#define UNALIGN(C)   MO_ALIGN
 #endif
 
 /* Target-specific values for ctx->base.is_jmp.  */
-- 
2.43.0


