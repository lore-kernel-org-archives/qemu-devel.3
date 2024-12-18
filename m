Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E88AE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvjU-0005SZ-GM; Wed, 18 Dec 2024 10:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNvjS-0005Rs-6v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:13:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNvjQ-0002NE-Ag
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:13:01 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283d48so47958185e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734534778; x=1735139578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OrboGUWQY00evIkses4YYXXYUTrbE9S1QHRbQtKTkzc=;
 b=RqJzvO3uvjKCOzow5zfy9dUChV/iv1DGWXgXvH1yTKP02C03sStJquPbWykqdiaVqm
 sTnRoDXVnqRoZalf1ioBcCD4Y9B5/8mgSD0AOhNUJA0y6Nj030J5BPG0LIJdAKQZXi11
 dVu7b21KHlALwSxplt0vabMO7WhaGBgoVqkWW//TN+Zb3khwMdcipB8eCw+LYxjEfmOU
 eB9sf+ht7w5W+0MZEYDujJCCcwjb3SCtSpF8UkuVgvVTlvD3rn3yALILrL7SMNudbSsI
 x4QXSO0k7GXocvktb9lgTk6LreIrdMpTxyGvGGgK9+Cmj4AUqOHTZvc0IYSsxvgYYFjG
 HNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734534778; x=1735139578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OrboGUWQY00evIkses4YYXXYUTrbE9S1QHRbQtKTkzc=;
 b=jPV1PVpmaOEuAE1bvr5SgrhxngECag/A4HIBycsDci1JUNYoUL0EOtjfDKVlA5Nb+3
 E+XnRgkRr0WJbU4SvNItaG+uZgSaa4ZNV3s3L2lVLtVbpC5h/Nma5yXEChJmKmR2UgfS
 vkQ1zjDtKMr5hxn+CAZL31pwn1oG4s/LKZoL45f+ptOK+eUYbsPib2mdcMot3VGhfFy/
 LFoo8hx3Jmmv8fUNHJSjojy+R1nixKyWrc9+bZoRIyM/3ef5f6TF4HVoMniW6wbslkRg
 As+LMfjYxplmmBFeD5d8aeELc3uI/Lh7MH78Bx/tdYQ7oJNsX3ud9WY++YK8NBq7STbe
 ojGA==
X-Gm-Message-State: AOJu0Yxxl7ZlUrx0I9HrrHOkkmaWeszG336mGULpLMD+YMLz4MRHfqmu
 A5TesVNjoIDSgWKXgL7kcAiAAMHxD8098E12soEFGtOYJ0yGlV6sqhsjH3mmo7r1xG3egvmzcfq
 s
X-Gm-Gg: ASbGncsYlHC/GX46WTnXb0Kfm6NifrJpqvG36VKy3XlUXWNJeLtYofKgXda9fhBZhu4
 e2AJmLGiyNVlFFsIec8xxM9aszo6hy7qIeCdlSeJuRwGjHpUw9ph8npgfT/vKDEAi92Qbd/g9Fh
 MYWBUAxCnS3i3lWWNsMedocsxAw+6cACRBb4+rcNQryWku9WB7BTS/xFZgv36QFGvbu/N2voQI2
 QTBQjBLkPHbxU4rTIVkIGVAJyWU/pRiCxX7oK3AjewI/umD9kLwz9a2obRexPHg5OQiDpRbvusS
 quEL
X-Google-Smtp-Source: AGHT+IGSzzdfomUHuhJBhh6742k7icBKzfohUdF9+5lQy3hYYONiVTRvSwief0lahQvJmbMuRFnN6Q==
X-Received: by 2002:a05:600c:1549:b0:435:194:3cdf with SMTP id
 5b1f17b1804b1-4365536fab4mr27640225e9.19.1734534778044; 
 Wed, 18 Dec 2024 07:12:58 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8012097sm14358582f8f.18.2024.12.18.07.12.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:12:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] meson: Do not define CONFIG_DEVICES on user emulation
Date: Wed, 18 Dec 2024 16:12:56 +0100
Message-ID: <20241218151256.68625-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

CONFIG_DEVICES is not generated on user emulation, so
do not define it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 85f74854735..d203e85d769 100644
--- a/meson.build
+++ b/meson.build
@@ -4110,7 +4110,7 @@ foreach target : target_dirs
   arch_deps = []
   c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
-            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
+  ]
   link_args = emulator_link_args
 
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
@@ -4130,6 +4130,7 @@ foreach target : target_dirs
       arch_deps += hw.dependencies()
     endif
 
+    c_args += ['-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
     arch_srcs += config_devices_h[target]
     link_args += ['@block.syms', '@qemu.syms']
   else
-- 
2.45.2


