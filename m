Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4090AC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2A-000736-Al; Fri, 25 Apr 2025 11:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1z-00067V-Bc
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1w-000464-72
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso17118545e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595114; x=1746199914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bn8ZwlSg8DF1L5LTUuHBCXKlF5X/HcHey9e05VeENiM=;
 b=CWz+dmRDvO6Xnf0yWkkoBvU7/adWxJfWICSOBFFa/5ZLvGYk9LoQv8uJJDw1w4TChW
 cLtbXvnNm47um5+EMCmLoFypOHcjlhbtxGzpSQi3GZpuqSZ7AFRR/lB+BIJALzyu+8+4
 x5/gW7ma/BzE6Gi+io2ylronuKTF6y8cMrWQVL+HCXchR0MJwGasY5CLGgc2aCbBsyYN
 98+2gxOIM4JA/OeH8haOxo5aVc/Lr7HFktjcAF1w2tVtDdNB/r31aWvWPViHrPbK+R2K
 559I1wbFKBId+3JOVlEbTWlrgKDuTTCrsbrz2/x51W2/akaV4bM2uKDIfr9EXd5ynDYx
 iQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595114; x=1746199914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bn8ZwlSg8DF1L5LTUuHBCXKlF5X/HcHey9e05VeENiM=;
 b=NjnwCibXAQDmOzC8QCcAd8K8vjRQJ0B8K6fKtToZbswdIkw6jocUdGS6p+8/4zsHF5
 KYdLfe6s+536y/cEg3+g5tyEZzjEzFrqkDWKhSPzckiUopCeZ8sO5vRwZ0Gp+PgSG/oh
 4WZW4nZxP2TMjJ4siY+OR5TGLa5uayAeVV7G99VChopF5TeU8LnjoFdmOIT5a3M3ozBl
 3Mlqrejh6iOK3XY9A5OQQyJCq2jB4UNmM7AupiecKxii3DoyQSVvWLkilrnanSU4ZCLG
 Wkq0A7DfKWUnpAbh5Yps4vIvtAkrRJ18xlRV5b/P3+XvOLZ2DJWlzX8P6bYPYPNCXBrf
 MW6A==
X-Gm-Message-State: AOJu0YxG2z5uocUgPN+KMdS77BlpdHoz7gRfDT1UM2Il1u14ByctcRfU
 TTP1N8d1GMfOGAhADX1ggdbXni8rWS+ehb59alLl+0NAbjc9BrL6rLc5LZJwVhFlLSD64MIZpDQ
 N
X-Gm-Gg: ASbGnctAPBxny7h8n+JGFsDg+3s1N44Dv5q53NW/A3wq8w/ipBCixHpuCS+GEWi1DvN
 j+LoUBDkNsCDGUoFidcv8Ees1bbYt5EZjciLfwVpQmGIBuS2XrDpzGOsnIupHwPCSxu7+OGaNxY
 bEnX/9L0F3MPoRGif5hQm64dQVnRvZJEokyPYf9gxkyFqAmlny0jkfK0twIEAHLerK0DuU1RUbY
 wJ9P6zGwiK2XPaYiZw0UoEWxcj0lA5v8jlmD9dJuxnnZpDyuUECgkziMJCbNv+PfC/j4dvpYCB1
 958ejEWimzfoemzjk+1vJsnzDM1HttZk4xGTrLEqQElLD9/3623dcaikz2SID7la9dF8NPD9+AZ
 9Pl6pvB48+JS+qEo=
X-Google-Smtp-Source: AGHT+IHr0/PNK30nFOlUIPGSBYhibii8vvP5pDNoKKzYU9WZ3cLOu1ogqPFHe1ZuKrgHEjPMKyEL6w==
X-Received: by 2002:a05:600c:3484:b0:440:6a79:6df0 with SMTP id
 5b1f17b1804b1-440a66973c7mr23499305e9.22.1745595113843; 
 Fri, 25 Apr 2025 08:31:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5303c15sm28045965e9.11.2025.04.25.08.31.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/58] meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
Date: Fri, 25 Apr 2025 17:28:22 +0200
Message-ID: <20250425152843.69638-39-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

CONFIG_STATX and CONFIG_STATX_MNT_ID are not used since commit
e0dc2631ec4 ("virtiofsd: Remove source").

Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424-buildsys-v1-2-97655e3b25d7@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/meson.build b/meson.build
index f77a9ce569e..35dcec8ce5c 100644
--- a/meson.build
+++ b/meson.build
@@ -2191,14 +2191,6 @@ gnu_source_prefix = '''
   #endif
 '''
 
-# Check whether the glibc provides STATX_BASIC_STATS
-
-has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_source_prefix)
-
-# Check whether statx() provides mount ID information
-
-has_statx_mnt_id = cc.has_header_symbol('sys/stat.h', 'STATX_MNT_ID', prefix: gnu_source_prefix)
-
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
   .require(host_os == 'linux',
            error_message: 'vhost_user_blk_server requires linux') \
@@ -2560,8 +2552,6 @@ config_host_data.set('CONFIG_CRYPTO_SM3', crypto_sm3.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
 config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
-config_host_data.set('CONFIG_STATX', has_statx)
-config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())
-- 
2.47.1


