Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA101C19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSf-0006xQ-Lq; Wed, 24 Apr 2024 18:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSc-0006vk-Ft
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSa-0006f3-N9
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:30 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ed112c64beso427631b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999087; x=1714603887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eljbs2yNGMGPnWHJwv7NSq5kkRuO1URzZsDZcIZtS6U=;
 b=usK6UKzCb0VsgHONVjfFftPh6lKhjR/dE9mB5CHzE+wE04bVVvnjseD/cGMgCD30lk
 0o7zo6FruHCExRFxVpGzabksn5XnfX6/OhHnyC2GXAS9+Z2RJ0bfOQ+nmyrRIjlO3YBV
 qbM8JHS1bsC1RHQsbVKI2mKeizEmp4/jSC0agJnT6VPU8L9JUl/VIc961QL9cE0kUHib
 1mxB4MizoPORy2ED+lpOrs65d2PAzmqxsGX5hS0bp6SBuGRNM66Jr41Kor6YZZqKmL+p
 4qziw7Bdp9DoyJgBQ3owTvBx0ieQNaFLaWChrtFrHvfnwVmbElujMgNLB/K/8+QzBznr
 Pc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999087; x=1714603887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eljbs2yNGMGPnWHJwv7NSq5kkRuO1URzZsDZcIZtS6U=;
 b=e/sWSAyg7byxafTUQQmWwJaFaexn5pnxozbXOlpjppEJgcK9QjYK/CnurPCYig+67f
 Aa0WKTf3e9A0EPMSwOe967bemaRjeZM9q7jIvHGtw/01Pkc2Gig0jcmXFZjwA80fNkeC
 Nc2S6NS5SudpiKfcarFoqulsQvr+VGmO+DBi7s7YZetAkqmgNjHYHDphSVfVIsN2I1xe
 K76e9fP/QaAUHmNfRwm0ez7Q2gu+J+O3rNUYVIodgWBEBq4uXAvkitmi/IT8ysyw3S1+
 En+FShW45JWbgaGd0oh86yKcQih+P6HlrlDjDt4Ho2b2jHCL8GLziO7sxNWwG5n2pNRC
 jV1g==
X-Gm-Message-State: AOJu0YxJsOpWXmlqtcyx4CZeRwag/y9tjLuFMTUU2l5V4jA7tngm7f/c
 4GSl/2Ro2MYQJS3MaNdvXQrG1VweudDVIaGAZbNJU9TEGRaeCDhP6eIEN6XwzfNEwk1aSUH6J1V
 N
X-Google-Smtp-Source: AGHT+IHEdI0+DvyCQQNVanodi94T+fv4VBJ70uSPR22vTZUPBJiIvxwprCzwvRSBMqvCqYf7yAH/SQ==
X-Received: by 2002:a05:6a20:6a12:b0:1a3:7de2:12b6 with SMTP id
 p18-20020a056a206a1200b001a37de212b6mr4250188pzk.26.1713999087335; 
 Wed, 24 Apr 2024 15:51:27 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/9] linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
Date: Wed, 24 Apr 2024 15:51:16 -0700
Message-Id: <20240424225123.929152-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

This setsockopt accepts zero-lengh optlen (current qemu implementation
does not allow this).  Also, there's no need to make a copy of the key,
it is enough to use lock_user() (which accepts zero length already).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2197
Fixes: f31dddd2fc "linux-user: Add support for setsockopt() option SOL_ALG"
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240331100737.2724186-2-mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3df2b94d9a..59fb3e911f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2277,18 +2277,13 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
         switch (optname) {
         case ALG_SET_KEY:
         {
-            char *alg_key = g_malloc(optlen);
-
+            char *alg_key = lock_user(VERIFY_READ, optval_addr, optlen, 1);
             if (!alg_key) {
-                return -TARGET_ENOMEM;
-            }
-            if (copy_from_user(alg_key, optval_addr, optlen)) {
-                g_free(alg_key);
                 return -TARGET_EFAULT;
             }
             ret = get_errno(setsockopt(sockfd, level, optname,
                                        alg_key, optlen));
-            g_free(alg_key);
+            unlock_user(alg_key, optval_addr, optlen);
             break;
         }
         case ALG_SET_AEAD_AUTHSIZE:
-- 
2.34.1


