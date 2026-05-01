Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041CDCCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 11:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wImSf-0006Jc-2Z; Fri, 01 May 2026 07:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wImSd-0006JQ-CK
 for qemu-devel@nongnu.org; Fri, 01 May 2026 07:55:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wImSb-0007sl-Ji
 for qemu-devel@nongnu.org; Fri, 01 May 2026 07:55:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so19159025e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 04:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777636507; x=1778241307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ri3eUcDTlecVfmcTVYau6OSqjmsbZRWYAoIVa4ILugU=;
 b=YyPHegs8wXTFBv7GERjFceFVVshsXUp9LnAAr9+AhLCtHiUWHB0P6dP3AFzXtP9Twj
 SQkSmrcItxsvVKtQkQOBfrZ1HdC8NztzWfNT21KJqRRAYhjgh/b5jrlEoGMAhEuDBjqk
 uIZze0iEcQ7UVLTvvtZ6F9hEkbgrD7cpZQ/bts7Lt28/IQoEW9d3rlOchYQZEBaimRD6
 Iae9NThNAkXH+kl/nr0xV1LTqi3FJ3e4tOWi19U7+uTRIk3RCWQFkYTrzSTfBQ2Euxd3
 kByen7eZ0PLrspRvkSWM3wyXDSwem7tBA/IdjjYuxhI7s7dChNAKoyAY1mHDPM8AJKy5
 xDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777636507; x=1778241307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ri3eUcDTlecVfmcTVYau6OSqjmsbZRWYAoIVa4ILugU=;
 b=MtyHBaDuYGmpBD5X3RZhYSvMImAjcsNcOoR1m1aObJanrynjLAPAh65gxAb9KyDqB3
 2i2eLlemDVXvx10fxtM3/JcAif+x2TscbZM+kMR7aHKTX8LL1t0t3L6wvPzRqfQFQIE1
 wU0jKl2OdUlLUP4PkgKSeVpxaAde6nXC9WHZtmDLZnIzXkDB1NzrYBhNwiMq5LE/vOYF
 qjmdqUF2ePw1fNDdqO4vcUcLKF0iNH7FqHpSGMOCu756pCb8x8nLw0fP9olJZ0VZs6aJ
 PBLWbzGCfYLMyNgu/5a7WQ91PnpvNWF8HgilW4eV8VGToHM4EimtaqKkucL4SyD3x1aS
 TFmQ==
X-Gm-Message-State: AOJu0YwPxXUyK8lA974oN90vdJ3Iw+kgudAMWCk0FidNQX29paDA4nVD
 3fGGXHIY3Sp1rg1T5esnOwG8NMQG/BPj8/ea1vwxitfH9DL/lYdZMqnbE8RLaOe91nc5002I4G3
 ptMXZ
X-Gm-Gg: AeBDiesYarVTIcCt0AWYjuRreZN6JI9Gr1ek23mcj6LpphsMTggFYkdPadqrsUa0E/9
 b/rhiwvibLFD8zv3jyOVuveGB2CTXCry3OBszCC0iLYkgRVRQYrtRfStp/7Y8t+jFpR7ZvNw7DU
 0eFaf8F+g7BlfpzGK5Mqszm2Owx2uPwMkNHwyuCnhnhw85ycU+DgSvfKwDID8+okLGB6ihVQ8Gl
 lRgxZn6jwWIjGWbags/zZKCafiUEfU3FmYtnX9kojmZbAIGeVI+eQhaKuHrN7rMwkN7HzR3oLIv
 s+6BF5AIl4lHqE8bjV7ZGlWNPl1D3BzApr7HkHZ/paDu3MvkOm36v0e4fxx/9Fw95iYYJZGzUwN
 52u5kfXEHEuqtY1KOyKhbpI8iur4QCCNBn6h7oqMxkC1TClVz2t+Oll30EDADwVj9UVuRZgQOat
 AfGwxH9eALmpEGOXPGLaqsZHRakyI+C9zI/lh2QyKCTzKNVtdGJ7lFAWgHYDPJ4kTbEh2KGRtOT
 x7BN/Bre2IPU5EBiVtTruYi82ByIJ7QRbt1wg3ZFw==
X-Received: by 2002:a05:600c:83c5:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a8eba3b09mr42874505e9.27.1777636507451; 
 Fri, 01 May 2026 04:55:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fee325asm14374745e9.7.2026.05.01.04.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 04:55:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/functional/qemu_test/asset.py: Don't use setxattr when
 it doesn't exist
Date: Fri,  1 May 2026 12:55:06 +0100
Message-ID: <20260501115506.3792110-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Python os.setxattr() API is Linux-specific, so trying to use
it on other OSes triggers a failure:

  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 227, in fetch
    os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
    ^^^^^^^^^^^
AttributeError: module 'os' has no attribute 'setxattr'

Since we only set the attributes here for informational
purposes, skip them when os.setxattr() isn't available.

Cc: qemu-stable@nongnu.org
Fixes: 9903217a4ed013 ("tests/functional: add a module for handling asset download & caching")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/qemu_test/asset.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 51a434b2b7..0abd89e0a3 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -223,11 +223,14 @@ def fetch(self):
             raise AssetError(self, "Download retries exceeded", transient=True)
 
         try:
-            # Set these just for informational purposes
-            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
-                        self.url.encode('utf8'))
-            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
-                        self.hash.encode('utf8'))
+            # Set these just for informational purposes. Note that
+            # setxattr is Linux-only; as this is only informational
+            # we can simply skip it on other platforms.
+            if hasattr(os, "setxattr"):
+                os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
+                            self.url.encode('utf8'))
+                os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
+                            self.hash.encode('utf8'))
         except OSError as e:
             self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
 
-- 
2.43.0


