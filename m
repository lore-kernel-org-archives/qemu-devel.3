Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C868C021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 05:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiofn-0000bB-Rg; Fri, 14 Feb 2025 00:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tiofl-0000aq-Ni; Fri, 14 Feb 2025 00:55:33 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tiofk-00084f-3G; Fri, 14 Feb 2025 00:55:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C7B2AEAB0F;
 Fri, 14 Feb 2025 08:55:12 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C6BF81B5FC5;
 Fri, 14 Feb 2025 08:55:20 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B08B453466; Fri, 14 Feb 2025 08:55:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-stable@nongnu.org
Subject: [PULL 4/4] make-release: don't rely on $CWD when excluding subproject
 directories
Date: Fri, 14 Feb 2025 08:55:20 +0300
Message-Id: <20250214055520.3159764-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214055520.3159764-1-mjt@tls.msk.ru>
References: <20250214055520.3159764-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Michael Roth <michael.roth@amd.com>

The current logic scans qemu.git/subprojects/ from *.wrap files to
determine whether or not to include the associated directories in the
release tarballs. However, the script assumes that it is being run from
the top-level of the source directory, which may not always be the case.
In particular, when generating releases via, e.g.:

  make qemu-9.2.1.tar.xz

the $CWD will either be an arbitrary external build directory, or
qemu.git/build, and the exclusions will not be processed as expected.
Fix this by using the $src parameter passed to the script as the root
directory for the various subproject/ paths referenced by this logic.

Also, the error case at the beginning of the subproject_dir() will not
result in the error message being printed, and will instead produce an
error message about "error" not being a valid command. Fix this by using
basic shell commands.

Fixes: be27b5149c86 ("make-release: only leave tarball of wrap-file subprojects")
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/make-release | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/make-release b/scripts/make-release
index 2885e87210..1b89b3423a 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -11,8 +11,9 @@
 # See the COPYING file in the top-level directory.
 
 function subproject_dir() {
-    if test ! -f "subprojects/$1.wrap"; then
-      error "scripts/archive-source.sh should only process wrap subprojects"
+    if test ! -f "$src/subprojects/$1.wrap"; then
+      echo "scripts/archive-source.sh should only process wrap subprojects"
+      exit 1
     fi
 
     # Print the directory key of the wrap file, defaulting to the
@@ -26,7 +27,7 @@ function subproject_dir() {
       -e    's///p' \
       -e    'q' \
       -e '}' \
-      "subprojects/$1.wrap")
+      "$src/subprojects/$1.wrap")
 
     echo "${dir:-$1}"
 }
@@ -76,7 +77,7 @@ popd
 exclude=(--exclude=.git)
 # include the tarballs in subprojects/packagecache but not their expansion
 for sp in $SUBPROJECTS; do
-    if grep -xqF "[wrap-file]" subprojects/$sp.wrap; then
+    if grep -xqF "[wrap-file]" $src/subprojects/$sp.wrap; then
       exclude+=(--exclude=subprojects/"$(subproject_dir $sp)")
     fi
 done
-- 
2.39.5


