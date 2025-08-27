Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541FCCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHlO-0000Sw-BN; Wed, 27 Aug 2025 11:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjB-0006f6-Ur; Wed, 27 Aug 2025 11:06:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHj9-0005L3-Um; Wed, 27 Aug 2025 11:06:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 75B5314C547;
 Wed, 27 Aug 2025 18:02:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 64AA126984F;
 Wed, 27 Aug 2025 18:03:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Stable-10.0.4 31/59] scripts/make-release: Go back to cloning all
 the EDK2 submodules
Date: Wed, 27 Aug 2025 18:02:36 +0300
Message-ID: <20250827150323.2694101-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In commit bd0da3a3d4f we changed make-release so that instead of
cloning every git submodule of EDK2 we only cloned a fixed list.
The original motivation for this was that one of the submodules:
 * was from a non-github repo
 * that repo had a "SSL certificate expired" failure
 * wasn't actually needed for the set of EDK2 binaries we build
and at the time we were trying to build the EDK2 binaries in one of
our CI jobs.

Unfortunately this change meant that we were exposed to bugs where
EDK2 adds a new submodule and the sources we ship in the release
tarball won't build any more.  In particular, in EDK2 commit
c6bb7d54beb05 the MipiSysTLib submodule was added, causing failure of
the ROM build in our tarball starting from QEMU release 8.2.0:

/tmp/qemu-10.0.0/roms/edk2/MdePkg/MdePkg.dec(32): error 000E: File/directory not found in workspace
        Library/MipiSysTLib/mipisyst/library/include is not found in packages path:
        /tmp/qemu-10.0.0/roms/.
        /tmp/qemu-10.0.0/roms/edk2

(Building from a QEMU git checkout works fine.)

In the intervening time EDK2 moved the submodule that had a problem
to be one they mirrored themselves (and at time of writing all their
submodules are hosted on github), and we stopped trying to build
EDK2 binaries in our own CI jobs with commit 690ceb71936f9037f6.

Go back to cloning every EDK2 submodule, so we don't have an
untested explicit list of submodules which will break without
our noticing it.

This increases the size of the QEMU tarball .tar.xz file from
133M to 139M in my testing.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3041
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250721153341.2910800-1-peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 0311a6edb9db34a41a2662d94c37e1fbaabf6ecf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/make-release b/scripts/make-release
index 8c3594a1a4..7e37ffad42 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -61,17 +61,15 @@ meson subprojects download $SUBPROJECTS
 (cd roms/skiboot && ./make_version.sh > .version)
 # Fetch edk2 submodule's submodules, since it won't have access to them via
 # the tarball later.
-#
-# A more uniform way to handle this sort of situation would be nice, but we
-# don't necessarily have much control over how a submodule handles its
-# submodule dependencies, so we continue to handle these on a case-by-case
-# basis for now.
-(cd roms/edk2 && \
-    git submodule update --init --depth 1 -- \
-        ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3 \
-        BaseTools/Source/C/BrotliCompress/brotli \
-        CryptoPkg/Library/OpensslLib/openssl \
-        MdeModulePkg/Library/BrotliCustomDecompressLib/brotli)
+
+# As recommended by the EDK2 readme, we don't use --recursive here.
+# EDK2 won't use any code or feature from a submodule of a submodule,
+# so we don't need to add them to the tarball.
+# Although we don't necessarily need all of the submodules that EDK2
+# has, we clone them all, to avoid running into problems where EDK2
+# adds a new submodule or changes its use of an existing one and
+# the sources we ship in the tarball then fail to build.
+(cd roms/edk2 && git submodule update --init --depth 1)
 popd
 
 exclude=(--exclude=.git)
-- 
2.47.2


