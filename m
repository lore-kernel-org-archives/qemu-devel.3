Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6758C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUAG-0003Bc-7e; Tue, 20 Feb 2024 12:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUAF-0003BD-7g
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:44:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUAD-0005JI-J4
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:44:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so3063490f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708451056; x=1709055856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laarQAHoeg6zp0ocxwYi8SXTwFh/gqSlyDW7enxYe6E=;
 b=tw80efnqEYnOj9bf1GUwtMsQAA0S81IJ3yf/pliXXlmjxP3DPS8PWI9cSGOVRAAltu
 f0MuF9taH4RFlLGQNzuNA79uWHdH7YAuKRQm6BsnsWqq72Z446qxLcplSI7cqyG7Pnl7
 gAZ/A34NDp4t/Fb8n+p5cZ2/Pni9M4t5dLwKrWz0o6CNx759904z08+xBPAf8E/Y3aer
 PR1DJl14T0eGVUvRfQruc44n5AOeZBI6nDmqXeeNuS9tjlotWo8TFtlwMxu9+tONGXdl
 NGDTOOL1rRqRTZLb1vbVvie9OrDEpChva7f2bSZdza8s0FqXKysZ9H3XaxdoOZyLTUqx
 wajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708451056; x=1709055856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=laarQAHoeg6zp0ocxwYi8SXTwFh/gqSlyDW7enxYe6E=;
 b=EFJM/3Vm1V/j5UQRdXXT8rCVhRyW4VIcYcJlTO4LvKZIBPD4GJnJX0rx+xUWtD80gG
 pw9G8agrJVD95plbN1rVJOfgaCsOqI4f6z/xyyns/tfwt0M5LLSbiTnx7Yzmc3k2Amax
 FzYtnusngkKW6KZTo7Uu0c0tUTD548Z+pjZif1gzKxhrSAGpDUfJLVmZLwK4tjptJvRA
 EJEjiltSwxCol/urQFxu02x0PDG4nTso/sejp6AgkNgf3JX2R8s157nznErckZCMmYrP
 46nluLdbPk2Yc25CRKrdmvL8Lmy0yCpoVaMjjFTMupUuh0wbppUk1fvVtFscaPoGT40c
 bf1w==
X-Gm-Message-State: AOJu0YwuHwx3ektM9CgghiW2/3K0Hw9QBPA7CRvDx2JeE3R6sssxijvM
 IiXa4cISbaiXNAva1cXePvpKPc/NQMdGiETFXN6nYmRGdPIzlHNk5m2D3G7Et7WzFzVRnnlsyjK
 2
X-Google-Smtp-Source: AGHT+IH5AifXsrok4dGQyRSdknMojwBsGMXIsYuFD7ttK4nwKwmc26EdLrZjZ4O1jou8uBWiQeNy0Q==
X-Received: by 2002:adf:f2c3:0:b0:33c:deed:6745 with SMTP id
 d3-20020adff2c3000000b0033cdeed6745mr11548719wrp.13.1708451056037; 
 Tue, 20 Feb 2024 09:44:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k5-20020adfe3c5000000b0033b66c2d61esm13988443wrm.48.2024.02.20.09.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:44:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 3/3] .gitlab-ci.d/windows.yml: Remove shared-msys2 abstraction
Date: Tue, 20 Feb 2024 17:44:12 +0000
Message-Id: <20240220174412.155885-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220174412.155885-1-peter.maydell@linaro.org>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
 .gitlab-ci.d/windows.yml | 84 +++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 8fc08218d28..e784d5a68cd 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -1,4 +1,4 @@
-.shared_msys2_builder:
+msys2-64bit:
   extends: .base_job_template
   tags:
   - shared-windows
@@ -14,9 +14,19 @@
   stage: build
   timeout: 100m
   variables:
+    MINGW_TARGET: mingw-w64-x86_64
+    MSYSTEM: MINGW64
     # This feature doesn't (currently) work with PowerShell, it stops
     # the echo'ing of commands being run and doesn't show any timing
     FF_SCRIPT_SECTIONS: 0
+    # do not remove "--without-default-devices"!
+    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
+    # changed to compile QEMU with the --without-default-devices switch
+    # for the msys2 64-bit job, due to the build could not complete within
+    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
+    # qTests don't run successfully with "--without-default-devices",
+    # so let's exclude the qtests from CI for now.
+    TEST_ARGS: --no-suite qtest
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
@@ -72,33 +82,35 @@
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
@@ -115,19 +127,3 @@
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


