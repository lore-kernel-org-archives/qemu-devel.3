Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A40FCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 14:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKzqI-0006xk-59; Mon, 17 Nov 2025 09:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKzqG-0006xb-RH
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 09:04:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKzqF-0000Wn-B8
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 09:04:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so46236725e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763388265; x=1763993065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g6bk/DS0zVlU3mOvpnZS7E1ShstFOzUCHUlepPd+CAw=;
 b=VDcXxTXDdmhQjx1Ng7kLcD++9NhFaDYEgWeplhPox27boAIkNqU8Sq6tR/KxNEMw+7
 0VoJ9mEqf9/GxyyCQBDMom8nt/OxOtbK5D1HQPZQw54BMNl/CJpkbB5Rq68SGlk6ckna
 j5PSsu7GuzyJEKByP3St81O6/XZILQiNpNnJfc5d9C4FY8isqz5PXO2vSh/k1A2qcDYI
 DNJXvG3PThatKz6JClT3Hwb/0A8swZ3bvMH8EvUvemefmnRecg17O357x0VYjhP0Dr7s
 iHOvVC7ThQigFmgNhzTPCrGLs0mDk+tNLvxuQ03SqEHY1roaA3dUgd2VsL9Ohal15m1C
 fL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763388265; x=1763993065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6bk/DS0zVlU3mOvpnZS7E1ShstFOzUCHUlepPd+CAw=;
 b=Zom/HkWff27+LXNGGu2vBXMz/XnLvPhsMoKm971vKBA3DC3myk8EeXR3MNa1XR9XXz
 rPaLTCroO09z1gFnuTOcllTGKawa03D/lIsPxN4QVPkvPKxVcRbwm6H3flPrKXrhzDFZ
 IaceWlPlq0i2oDG8pS04vb7/5xJJ6nlB23wKZasx6FrPOBQ3RmPLQswmE+s3w1mcilcP
 8N1LZew47xcyy+M6pzxnydrffhynVvEL9qWmO3Zb466DIxjkx4wBTe4GpZKEwMufFrxD
 MIoQ4h41QF2bH8KWwlmjPUmXQPTNb3SqVeTUUrbOfP8acZLiueeobkrcnsf+4ZtC1zUE
 YWaA==
X-Gm-Message-State: AOJu0Yz88znpnKURiELWyOg6SIKAQyZJsUFjRXlQJQC8SmuHnpvvnsVO
 P629kGuaQfEIuK+QBLx/nMLwk7zL+iHQkKcyef5TNTQMhRRgXIBXCC5tWzzDJmkrNYhPfwQVXld
 GMI+JCe/NSg==
X-Gm-Gg: ASbGncs99ZSy3eWqbTsxYXjPpOqWQavvZ81/prdssDewGismPCdtmLNw6CN6ozZeASD
 Kxuv7GloZIstDYES8uMyXLJU9ZqztUkHXc0oe5jNT+VZSkz5lEDy5hpYqv/97s2Ta5DH0/scWB3
 fFnh4jbqNHLVu7Jb1+W6SPbKPlEhCFi+D7c803i13Am4ipDaF1T7lX2Tbpz23hsn7+bKluYIu8F
 8nAUQs0kFAJnifBqPcm/MF5uilbxMtbU2zPdJtAXxp1qM5yqcvivm5zDlfOfZpLcQejQ7rEB8Gt
 wXjBc4wNSub01o2NR2ROkcXgwMXI9q0z++d22qtvTSKym3sXmCsmpPdzNrYplmLc4y6ijL+G3fB
 QTzDiaco5hNuCN8N0orKEN19GtZreZtsCSjuIjH1Xqr+Oow+uiqcgl5pK3bZ5gjkmvSLh8zcLqp
 v/9VhlCI+Va6mxOsZuovJ7aNN6BNHIhXr9EKPLamOrfIIuzcjegg==
X-Google-Smtp-Source: AGHT+IEi3G5otK/YE8p5oG9UFk6oOlXV4exv7zzItrYLbYaV45eyf1jMPZbO2/HZ6uKNdL4Xxtn3yQ==
X-Received: by 2002:a05:600c:6052:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-47799866420mr48467395e9.28.1763388265015; 
 Mon, 17 Nov 2025 06:04:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae2dsm26951084f8f.5.2025.11.17.06.04.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 06:04:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH-for-10.2] roms: Do not try to build EDK2 for 32-bit ARM on
 Fedora
Date: Mon, 17 Nov 2025 15:04:20 +0100
Message-ID: <20251117140420.62193-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

With Fedora 27, support for 32-bit ARM hosts was dropped.
QEMU also stopped building the docker images in commit
0054dc8bde4 ("Update lcitool and fedora to 37").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 roms/edk2-build.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/roms/edk2-build.py b/roms/edk2-build.py
index e564765aaa7..c7e9dc58ec0 100755
--- a/roms/edk2-build.py
+++ b/roms/edk2-build.py
@@ -293,10 +293,6 @@ def prepare_env(cfg, silent = False):
         # ubuntu
         os.environ['GCC5_ARM_PREFIX'] = 'arm-linux-gnueabi-'
         os.environ['GCC_ARM_PREFIX'] = 'arm-linux-gnueabi-'
-    elif binary_exists('arm-linux-gnu-gcc'):
-        # fedora
-        os.environ['GCC5_ARM_PREFIX'] = 'arm-linux-gnu-'
-        os.environ['GCC_ARM_PREFIX'] = 'arm-linux-gnu-'
     if binary_exists('loongarch64-linux-gnu-gcc'):
         os.environ['GCC5_LOONGARCH64_PREFIX'] = 'loongarch64-linux-gnu-'
         os.environ['GCC_LOONGARCH64_PREFIX'] = 'loongarch64-linux-gnu-'
-- 
2.51.0


