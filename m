Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2051C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rae08-0005sM-LM; Thu, 15 Feb 2024 10:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rae08-0005s7-1P
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:50:16 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rae06-0006mm-1K
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:50:15 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so13423351fa.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708012212; x=1708617012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IzM/S9aCIn7U9ig27VcQ6F+L3MmdGn4y94+3p0ROuvI=;
 b=QWWFnV52ueXkR/Nog4nUjFrg9m9HSNPS2C7AfLtKMAiiDzqxqxmAdVD5DMnc3p/t3G
 3hWDlCJ5aVCwb6bhi+FZ9kQnT+p3S8+77JsvnljSh6qeQ8NcgtgrdPI8/nBNAuomuq4/
 SYpEWfYMdTU+5K1d+wXHe9Mz6oLIKpjgOFB3mY82A38yLTRBkGaQqe3ZF7SfebVDHORq
 BxU/JQHY7WBLutXcxdX7FBrkRAst/aR8kzIcf4mqCd9Iy8tLo5rs0YD9QWD0sN8rKx8Q
 LdV2at64Sty0/pBpGDRboRkFsE0zVrZ0OArBF53u4AzvYrU6lPOY5p+0jL6VWcJSvwzB
 1Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708012212; x=1708617012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzM/S9aCIn7U9ig27VcQ6F+L3MmdGn4y94+3p0ROuvI=;
 b=ODyaR+SY0YuKGWpqcjf/vrJzSum897eoqBnd0KyKrmON4z2+SSxjfCfGWJoZ5cMPrx
 iBw11jY9bfjHmhTHm/mNHOehcUTFj2+ZWFaELSh/YUJU9YUSWwrPoFgBN/MyBvSjmTLi
 6NfY9yPyEHZwrEkzydEFXJVaS+Gl8YHpzTBWATWeU7kqDfLIzKfucqf2K08iKdBaItFe
 1t1ZlBsJEw5eam3Cpy9MhF876Rm9SF2DPhomsfEUoUagCwvwlgXVn08gInKKCMBFBv/d
 Nx2gamoxsuTjlvEIc71wFpjNO6BymkKEQGinJhwTUz6BZIuwJXqPPUyp1DHX0k6QmKhz
 Qk5g==
X-Gm-Message-State: AOJu0YxXlFZjB07HrX6M2Xh+VI7HsgFz+DHshA3JQyZn92uzhQkJr5EV
 718pQ0oCpC85MDogX8yBWjPOvgRNTPw8oihEKLvmbTMGZhdxXrYf0Pfy59KR1f+7+bzxSO5UjkV
 o
X-Google-Smtp-Source: AGHT+IHj18Fn9T7/+NAmoYYKkbaxg4cDWY8ffZsuvN9ojxRsKEBDc0RyMGj92KJI11lYTvm3OlKjkw==
X-Received: by 2002:a2e:984d:0:b0:2d0:bef5:2483 with SMTP id
 e13-20020a2e984d000000b002d0bef52483mr1656557ljj.3.1708012211855; 
 Thu, 15 Feb 2024 07:50:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4147000000b0033ce06c303csm2141530wrq.40.2024.02.15.07.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 07:50:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] .gitlab-ci/windows.yml: Don't install libusb or spice
 packages on 32-bit
Date: Thu, 15 Feb 2024 15:50:09 +0000
Message-Id: <20240215155009.2422335-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When msys2 updated their libusb packages to libusb 1.0.27, they
dropped support for building them for mingw32, leaving only mingw64
packages.  This broke our CI job, as the 'pacman' package install now
fails with:

error: target not found: mingw-w64-i686-libusb
error: target not found: mingw-w64-i686-usbredir

(both these binary packages are from the libusb source package).

Similarly, spice is now 64-bit only:
error: target not found: mingw-w64-i686-spice

Fix this by dropping these packages from the list we install for our
msys2-32bit build.  We do this with a simple mechanism for the
msys2-64bit and msys2-32bit jobs to specify a list of extra packages
to install on top of the common ones we install for both jobs.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2160
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitlab-ci.d/windows.yml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f7645f72b7c..5c1e385dc89 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -88,7 +88,6 @@
       $MINGW_TARGET-libpng
       $MINGW_TARGET-libssh
       $MINGW_TARGET-libtasn1
-      $MINGW_TARGET-libusb
       $MINGW_TARGET-lzo2
       $MINGW_TARGET-nettle
       $MINGW_TARGET-ninja
@@ -98,9 +97,8 @@
       $MINGW_TARGET-SDL2
       $MINGW_TARGET-SDL2_image
       $MINGW_TARGET-snappy
-      $MINGW_TARGET-spice
-      $MINGW_TARGET-usbredir
-      $MINGW_TARGET-zstd "
+      $MINGW_TARGET-zstd
+      $EXTRA_PACKAGES "
   - Write-Output "Running build at $(Get-Date -Format u)"
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
@@ -123,6 +121,8 @@ msys2-64bit:
   variables:
     MINGW_TARGET: mingw-w64-x86_64
     MSYSTEM: MINGW64
+    # msys2 only ship these packages for 64-bit, not 32-bit
+    EXTRA_PACKAGES: $MINGW_TARGET-libusb $MINGW_TARGET-usbredir $MINGW_TARGET-spice
     # do not remove "--without-default-devices"!
     # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
     # changed to compile QEMU with the --without-default-devices switch
@@ -137,5 +137,6 @@ msys2-32bit:
   variables:
     MINGW_TARGET: mingw-w64-i686
     MSYSTEM: MINGW32
+    EXTRA_PACKAGES:
     CONFIGURE_ARGS:  --target-list=ppc64-softmmu -Ddebug=false -Doptimization=0
     TEST_ARGS: --no-suite qtest
-- 
2.34.1


