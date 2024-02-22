Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA19C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8pQ-00010c-Na; Thu, 22 Feb 2024 08:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8pL-0000tn-Pm
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:09:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8pI-00087Q-W6
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:09:27 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-410e820a4feso5021575e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 05:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708607363; x=1709212163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8W+UANmwR+ARAJvEHPeMk1jgmwwFEN1lfPcpS12yAY=;
 b=KQUICCqqiwDOqkaCycOKZAnhEM5eYOZfHZGEEw4KtRa4R5F76FlfT9Q+XvYE9jbQzj
 t27INwu1HBwL0sb93uzgGEJEke2PS9H4Va3QQU9aZ7xr07ZQ8IU7DQ/ea1b43WNwxXeu
 jTQp38wVBELCr50ylmHOLrVse0Ft3nAzhWo2JdqpRNjiSsMbXHlPenF+xZROVrUbAyfs
 0G0qXdhxJmY5mMSTRwcEWXY4oB8bTSl5hW7UG2ZJuFJWjSDreG5Tjjrd3Ic4bn3xDsiZ
 NVgJ87M/0I/CzFokxYAEn2zaNalFVhoy+7lezTo58R4BigFE18A6GMxz2+NWXvc2zJTg
 2ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708607363; x=1709212163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8W+UANmwR+ARAJvEHPeMk1jgmwwFEN1lfPcpS12yAY=;
 b=luCiS6yUtvYgf4t+m01l8XPruaBhOU/KnkAZ10rSDMOBBVkbR27PrPe7GiCkPbshFx
 gCqxMHjkA/+9McnfDGwyaC5ZoTXypyBh6eHPea2rKbXoXRyY4aHaRooQdy+thBzZTlJV
 XLhmT6Y4oX8P8fVEonsb1xydlq04bbylGcCoukFKHo8SZFHZXNYZmM/UB0SXkTFVMZDe
 O68nmxMCs/v9qe+xh/Bx+DekGziw1E6fKjnKyyZxNLcFra2PS/OBtPUkbXr6tmjD98QO
 36yvFNhjR7W6YdBv4EksgFt0hE3ReLdlEG4jkIrFRlAtuimr7ijGDgRc8jha4fv6boDj
 u/9g==
X-Gm-Message-State: AOJu0YxBrxfcyv89AesFIZGHvozwbs3mU3CI2oHJ9vruMgmNfANqq9nZ
 J/RHvIkw/VX8IJuB2m+MH0kojB1Z5XueYf3koXEjWvwhBbdDCDWkOslGIROj+z5gwy8YsTx3J/T
 s
X-Google-Smtp-Source: AGHT+IFTrhE3ThNn3zn32Zn1hhw1VoBMQgj60IZo81iSC0htZmdQVgsdIxIqzFpEHIGxYvbaSCQiyw==
X-Received: by 2002:a05:600c:444a:b0:411:c8a7:7b09 with SMTP id
 v10-20020a05600c444a00b00411c8a77b09mr2156623wmn.10.1708607363736; 
 Thu, 22 Feb 2024 05:09:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c155300b00411ff030f06sm22434458wmg.9.2024.02.22.05.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:09:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 3/3] .gitlab-ci.d/windows.yml: Remove shared-msys2
 abstraction
Date: Thu, 22 Feb 2024 13:09:20 +0000
Message-Id: <20240222130920.362517-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222130920.362517-1-peter.maydell@linaro.org>
References: <20240222130920.362517-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now we don't build msys2-32bit we don't need the abstraction out of the
common msys2 handling from the 32-vs-64-bit specifics. Collapse it
down into the msys2-64bit job definition.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v2:
 - drop now-unused MINGW_TARGET variable
 - document why we need to set MSYSTEM
 - restore comment text truncated in commit 11961d08fcbddf
---
 .gitlab-ci.d/windows.yml | 85 +++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 8fc08218d28..f116b8012db 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -1,4 +1,4 @@
-.shared_msys2_builder:
+msys2-64bit:
   extends: .base_job_template
   tags:
   - shared-windows
@@ -14,9 +14,20 @@
   stage: build
   timeout: 100m
   variables:
+    # Select the "64 bit, gcc and MSVCRT" MSYS2 environment
+    MSYSTEM: MINGW64
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
     FF_SCRIPT_SECTIONS: 0
+    # do not remove "--without-default-devices"!
+    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
+    # changed to compile QEMU with the --without-default-devices switch
+    # for this job, because otherwise the build could not complete within
+    # the project timeout.
+    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
+    # qTests don't run successfully with "--without-default-devices",
+    # so let's exclude the qtests from CI for now.
+    TEST_ARGS: --no-suite qtest
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
@@ -72,33 +83,35 @@
   - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
       bison diffutils flex
       git grep make sed
-      $MINGW_TARGET-binutils
-      $MINGW_TARGET-capstone
-      $MINGW_TARGET-ccache
-      $MINGW_TARGET-curl
-      $MINGW_TARGET-cyrus-sasl
-      $MINGW_TARGET-dtc
-      $MINGW_TARGET-gcc
-      $MINGW_TARGET-glib2
-      $MINGW_TARGET-gnutls
-      $MINGW_TARGET-gtk3
-      $MINGW_TARGET-libgcrypt
-      $MINGW_TARGET-libjpeg-turbo
-      $MINGW_TARGET-libnfs
-      $MINGW_TARGET-libpng
-      $MINGW_TARGET-libssh
-      $MINGW_TARGET-libtasn1
-      $MINGW_TARGET-lzo2
-      $MINGW_TARGET-nettle
-      $MINGW_TARGET-ninja
-      $MINGW_TARGET-pixman
-      $MINGW_TARGET-pkgconf
-      $MINGW_TARGET-python
-      $MINGW_TARGET-SDL2
-      $MINGW_TARGET-SDL2_image
-      $MINGW_TARGET-snappy
-      $MINGW_TARGET-zstd
-      $EXTRA_PACKAGES "
+      mingw-w64-x86_64-binutils
+      mingw-w64-x86_64-capstone
+      mingw-w64-x86_64-ccache
+      mingw-w64-x86_64-curl
+      mingw-w64-x86_64-cyrus-sasl
+      mingw-w64-x86_64-dtc
+      mingw-w64-x86_64-gcc
+      mingw-w64-x86_64-glib2
+      mingw-w64-x86_64-gnutls
+      mingw-w64-x86_64-gtk3
+      mingw-w64-x86_64-libgcrypt
+      mingw-w64-x86_64-libjpeg-turbo
+      mingw-w64-x86_64-libnfs
+      mingw-w64-x86_64-libpng
+      mingw-w64-x86_64-libssh
+      mingw-w64-x86_64-libtasn1
+      mingw-w64-x86_64-libusb
+      mingw-w64-x86_64-lzo2
+      mingw-w64-x86_64-nettle
+      mingw-w64-x86_64-ninja
+      mingw-w64-x86_64-pixman
+      mingw-w64-x86_64-pkgconf
+      mingw-w64-x86_64-python
+      mingw-w64-x86_64-SDL2
+      mingw-w64-x86_64-SDL2_image
+      mingw-w64-x86_64-snappy
+      mingw-w64-x86_64-spice
+      mingw-w64-x86_64-usbredir
+      mingw-w64-x86_64-zstd"
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
@@ -115,19 +128,3 @@
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
   - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
   - Write-Output "Finished build at $(Get-Date -Format u)"
-
-msys2-64bit:
-  extends: .shared_msys2_builder
-  variables:
-    MINGW_TARGET: mingw-w64-x86_64
-    MSYSTEM: MINGW64
-    # msys2 only ship these packages for 64-bit, not 32-bit
-    EXTRA_PACKAGES: $MINGW_TARGET-libusb $MINGW_TARGET-usbredir $MINGW_TARGET-spice
-    # do not remove "--without-default-devices"!
-    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
-    # changed to compile QEMU with the --without-default-devices switch
-    # for the msys2 64-bit job, due to the build could not complete within
-    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
-    # qTests don't run successfully with "--without-default-devices",
-    # so let's exclude the qtests from CI for now.
-    TEST_ARGS: --no-suite qtest
-- 
2.34.1


