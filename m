Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70992C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoOQ-0001we-P5; Wed, 21 Feb 2024 10:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcoKw-0000wk-BN; Wed, 21 Feb 2024 10:16:43 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchuv-00031M-Pt; Wed, 21 Feb 2024 03:25:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 322174F3EE;
 Wed, 21 Feb 2024 11:21:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F1495860CD;
 Wed, 21 Feb 2024 11:21:01 +0300 (MSK)
Received: (nullmailer pid 2142134 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 48/60] .gitlab-ci/windows.yml: Don't install libusb or
 spice packages on 32-bit
Date: Wed, 21 Feb 2024 11:20:36 +0300
Message-Id: <20240221082058.2141850-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-id: 20240215155009.2422335-1-peter.maydell@linaro.org
(cherry picked from commit 8e31b744fdf2c5d933681e4128acee72a83af4b8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index f7645f72b7..5c1e385dc8 100644
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
2.39.2


