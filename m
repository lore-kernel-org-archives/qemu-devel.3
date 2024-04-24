Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A4BC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSg-0006xl-MT; Wed, 24 Apr 2024 18:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSf-0006wr-4C
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSd-0006g3-IV
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so434410b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999090; x=1714603890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Qew14nZN1wX0iqwNUmvetvShYAajmyZbQ1f420VzBg=;
 b=Nl1fYlMg5DMZGTM4O5nY49rVIm2dm68dYtvBjqjcSAYKaSMH4NbpzfsdtdQI+U8clA
 yfX6tXaEqyWOqvlxPeM6IhHDFPJnV+b/IMu+mmaDwHzVlDDoWayIHTs3O2OZFqnvsO0C
 b6MAmSlFE1AzUm7TXSji8YhoRRr8z0kmplehgVxAC5o9bjyXHfBbMxbheMqHkLcYjuSf
 XffCEO3isocEdoB3G7RzF+p7VrSHByjWGv3C/s3IUIbCFnbpOf4FpAkdKurf5KSAxm1v
 kB8rmZdcwvk4dFzQxP6Xtqh7mNJk5TeDUpDqWUlZmmP7BAk2wrsdsprwkJ1okUbj3RFX
 piWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999090; x=1714603890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Qew14nZN1wX0iqwNUmvetvShYAajmyZbQ1f420VzBg=;
 b=kMIoWo4+Juw69xsPyqiXfhXxaDyh8eSu5zPzVBPkhGxyTVKKf/6pxkoBDWQGEi0lQu
 YFIDmJvcVETCVREDP2S8e6YG8cq0OC2j5diLtUy4oXmIkjFa81mEy8cga3iO7bAs4pTY
 II2yUwU0YQGVlmksRcVJmzTQ/6ZW3G3Q9CabgoC8kB6ZHImE3ajPXLPPofHjhr/1Uuf+
 7+b9NUt8oHTBaCXsKn73oo8cD+9c1hLlBTr4Wp5+LUmcpfS6nt15LC/HfzgOSmpvzB54
 KOTseUyBQA2yeLksIWPdcnXLT/D47NCrLuvUC+nGknSofCU9TmGzyRrLoYx6DNVlULcc
 wYIw==
X-Gm-Message-State: AOJu0YzvV0PSYoxI/Yp0rTOEKjiy6IH87zoFMCecdRHXtjDmhi+jN77/
 f2IWNa2h0Is8jqBsJQmTSd81luN5VUGoc6TImzWjAYJcOGWfamybvrOH2DenWURARD4cIkXYmvY
 K
X-Google-Smtp-Source: AGHT+IFJAHrL3Kwrpi0ZJ2frFe2ZJ5teqk8ugDlLfhbu1sBJuuZ0Sp97UdCzx6kKiaJ7qk2Va8/dDQ==
X-Received: by 2002:a05:6a21:6d9c:b0:1a7:3d2a:7383 with SMTP id
 wl28-20020a056a216d9c00b001a73d2a7383mr5517735pzb.18.1713999090209; 
 Wed, 24 Apr 2024 15:51:30 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/9] linux-user: do_setsockopt: eliminate goto in switch for
 SO_SNDTIMEO
Date: Wed, 24 Apr 2024 15:51:19 -0700
Message-Id: <20240424225123.929152-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Michael Tokarev <mjt@tls.msk.ru>

There's identical code for SO_SNDTIMEO and SO_RCVTIMEO, currently
implemented using an ugly goto into another switch case.  Eliminate
that using arithmetic if, making code flow more natural.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240331100737.2724186-5-mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1fedf16650..41659b63f5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2301,12 +2301,10 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
     case TARGET_SOL_SOCKET:
         switch (optname) {
         case TARGET_SO_RCVTIMEO:
+        case TARGET_SO_SNDTIMEO:
         {
                 struct timeval tv;
 
-                optname = SO_RCVTIMEO;
-
-set_timeout:
                 if (optlen != sizeof(struct target_timeval)) {
                     return -TARGET_EINVAL;
                 }
@@ -2315,13 +2313,12 @@ set_timeout:
                     return -TARGET_EFAULT;
                 }
 
-                ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname,
+                ret = get_errno(setsockopt(sockfd, SOL_SOCKET,
+                                optname == TARGET_SO_RCVTIMEO ?
+                                    SO_RCVTIMEO : SO_SNDTIMEO,
                                 &tv, sizeof(tv)));
                 return ret;
         }
-        case TARGET_SO_SNDTIMEO:
-                optname = SO_SNDTIMEO;
-                goto set_timeout;
         case TARGET_SO_ATTACH_FILTER:
         {
                 struct target_sock_fprog *tfprog;
-- 
2.34.1


