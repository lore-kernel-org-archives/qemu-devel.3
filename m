Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B215CC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ4G-0005vF-DV; Mon, 27 Jan 2025 09:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ49-0005qZ-SN; Mon, 27 Jan 2025 09:26:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ48-0003KJ-6d; Mon, 27 Jan 2025 09:26:17 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id AC3B6E0F85;
 Mon, 27 Jan 2025 17:25:41 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id B96A151DB3; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 39/41] make-release: only leave tarball of wrap-file
 subprojects
Date: Mon, 27 Jan 2025 17:17:53 +0300
Message-Id: <20250127141803.3514882-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

The QEMU source archive is including the sources downloaded from crates.io
in both tarball form (in subprojects/packagecache) and expanded/patched
form (in the subprojects directory).  The former is the more authoritative
form, as it has a hash that can be verified in the wrap file and checked
against the download URL, so keep that one only.  This works also with
--disable-download; when building QEMU for the first time from the
tarball, Meson will print something like

    Using proc-macro2-1-rs source from cache.

for each subproject, and then go on to extract the tarball and apply the
overlay or the patches in subprojects/packagefiles.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2719
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit be27b5149c86f81531f8fc609baf3480fc4d9ca0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/make-release b/scripts/make-release
index 8dc939124c..2885e87210 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -10,6 +10,27 @@
 # This work is licensed under the terms of the GNU GPLv2 or later.
 # See the COPYING file in the top-level directory.
 
+function subproject_dir() {
+    if test ! -f "subprojects/$1.wrap"; then
+      error "scripts/archive-source.sh should only process wrap subprojects"
+    fi
+
+    # Print the directory key of the wrap file, defaulting to the
+    # subproject name.  The wrap file is in ini format and should
+    # have a single section only.  There should be only one section
+    # named "[wrap-*]", which helps keeping the script simple.
+    local dir
+    dir=$(sed -n \
+      -e '/^\[wrap-[a-z][a-z]*\]$/,/^\[/{' \
+      -e    '/^directory *= */!b' \
+      -e    's///p' \
+      -e    'q' \
+      -e '}' \
+      "subprojects/$1.wrap")
+
+    echo "${dir:-$1}"
+}
+
 if [ $# -ne 2 ]; then
     echo "Usage:"
     echo " $0 gitrepo version"
@@ -51,5 +72,13 @@ meson subprojects download $SUBPROJECTS
         CryptoPkg/Library/OpensslLib/openssl \
         MdeModulePkg/Library/BrotliCustomDecompressLib/brotli)
 popd
-tar --exclude=.git -cJf ${destination}.tar.xz ${destination}
+
+exclude=(--exclude=.git)
+# include the tarballs in subprojects/packagecache but not their expansion
+for sp in $SUBPROJECTS; do
+    if grep -xqF "[wrap-file]" subprojects/$sp.wrap; then
+      exclude+=(--exclude=subprojects/"$(subproject_dir $sp)")
+    fi
+done
+tar "${exclude[@]}" -cJf ${destination}.tar.xz ${destination}
 rm -rf ${destination}
-- 
2.39.5


