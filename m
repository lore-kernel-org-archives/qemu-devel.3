Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65BAC30658
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 06:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNRWL-0001E3-9T; Sat, 29 Jun 2024 02:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRWJ-0001Co-6G
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:25:11 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRWH-0000K2-LO
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:25:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so8538365ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 23:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719642306; x=1720247106;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nOI+/hoYgC2+kd3/KX8my+UtuxBUiUAkeuQfM1cW05g=;
 b=osG7Suu7IwDY0STthecn+OtmBR3ZAZQMRgorhQKw/UE3tBIkt7nc1f0pkDpJnEEBKO
 zPSOWeuusEPmyM2SKTOpKdoMot6mK3u30lrDQ1h/MoYzGvb6liyk7UG0rscfYo3d1uP2
 J7/r5b3t5BiuuYRNKPPwKp+xaU85z+47hj69/U4I6Zqd7qNXJfiF7m1juld3Fa7Kpz4g
 Jf1oXmsBUKXIWPEwk3UCruhQK1t0eglaVZneVcv40zakcX6WfTZxzVn0EvwcDmRvqNqN
 7szn0k8gfxkpGWnDrwK4L6atxRXl5MRWfeImhnibIRd5pXWKduoxsDqXOx+RKo8IvwwI
 dMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719642306; x=1720247106;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOI+/hoYgC2+kd3/KX8my+UtuxBUiUAkeuQfM1cW05g=;
 b=A+TbiIoctgosYjb5SHD9QDkckpsOhXAF/nrgPImBZLRl1iro4VunQbcalg5jjpEGdV
 2H24u28zvj4+JQiNd3Cq8l8CBkMWcB/CH//jH1+f1ujqPfyUF9CJZmcjXl1aSF7Vb0hx
 IbaHZscuIbAss+iO0XSmrbmITepJsVzyLqBtob8/LMUq9YQ9cOmZu6UPQBJsHLT/LYDS
 /r1ewbyWrZze/AJ4s+6Y/wywFin/DzfVfn9YC0WKn4RCt/YOqCDyCdaFwstlOulwdBAO
 bMBtLkZrRtTKXBod6cVBvbmAhZ6ik9psi4P0IHD5nRdFd3joYHUHYiRvQ+TK8VLG5gw1
 u/dw==
X-Gm-Message-State: AOJu0YwpIOltFXakdGGoPpcIovW3T7gNL6TANjm7IihV4nJQuiJzh68r
 o9qkmLqt/71SnBG5MXcUoGGZ0APT3HZbS/StgutUGBdZTZNrQ+fJUf2EL3tgmSg=
X-Google-Smtp-Source: AGHT+IGI47h+FQSxc7tw6xDlfFWwRmvMscvqx/GqEB9tXD4n8By+Seopj6Gb2WYeNi6flQpA5bmkpw==
X-Received: by 2002:a17:902:e546:b0:1fa:2760:c3d0 with SMTP id
 d9443c01a7336-1fadbce6a97mr1508445ad.51.1719642306144; 
 Fri, 28 Jun 2024 23:25:06 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac10d2652sm25376725ad.1.2024.06.28.23.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 23:25:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 15:24:46 +0900
Subject: [PATCH 3/4] block/file-posix: Drop ifdef for macOS versions older
 than 12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-macos-v1-3-6e70a6b700a0@daynix.com>
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
In-Reply-To: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
To: Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 block/file-posix.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index be25e35ff6ef..29c7aaade8a8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3929,11 +3929,6 @@ BlockDriver bdrv_file = {
 static kern_return_t GetBSDPath(io_iterator_t mediaIterator, char *bsdPath,
                                 CFIndex maxPathSize, int flags);
 
-#if !defined(MAC_OS_VERSION_12_0) \
-    || (MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_12_0)
-#define IOMainPort IOMasterPort
-#endif
-
 static char *FindEjectableOpticalMedia(io_iterator_t *mediaIterator)
 {
     kern_return_t kernResult = KERN_FAILURE;

-- 
2.45.2


