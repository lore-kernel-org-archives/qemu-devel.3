Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495E7C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgXh-0002lM-D5; Tue, 28 Jan 2025 03:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXW-00023W-FM; Tue, 28 Jan 2025 03:01:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXU-0001re-Mb; Tue, 28 Jan 2025 03:01:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A07AFE1B50;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1C3E01A6303;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id EBE9A52097; Tue, 28 Jan 2025 10:57:33 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 09/58] migration: Allow pipes to keep working for fd
 migrations
Date: Mon, 27 Jan 2025 23:24:55 +0300
Message-Id: <20250127202547.3723716-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Libvirt may still use pipes for old file migrations in fd: URI form,
especially when loading old images dumped from Libvirt's compression
algorithms.

In that case, Libvirt needs to compress / uncompress the images on its own
over the migration binary stream, and pipes are passed over to QEMU for
outgoing / incoming migrations in "fd:" URIs.

For future such use case, it should be suggested to use mapped-ram when
saving such VM image.  However there can still be old images that was
compressed in such way, so libvirt needs to be able to load those images,
uncompress them and use the same pipe mechanism to pass that over to QEMU.

It means, even if new file migrations can be gradually moved over to
mapped-ram (after Libvirt start supporting it), Libvirt still needs the
uncompressor for the old images to be able to load like before.

Meanwhile since Libvirt currently exposes the compression capability to
guest images, it may needs its own lifecycle management to move that over
to mapped-ram, maybe can be done after mapped-ram saved the image, however
Dan and PeterK raised concern on temporary double disk space consumption.
I suppose for now the easiest is to enable pipes for both sides of "fd:"
migrations, until all things figured out from Libvirt side on how to move
on.

And for "channels" QMP interface support on "migrate" / "migrate-incoming"
commands, we'll also need to move away from pipe.  But let's leave that for
later too.

So far, still allow pipes to happen like before on both save/load sides,
just like we would allow sockets to pass.

Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Peter Krempa <pkrempa@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Fixes: c55deb860c ("migration: Deprecate fd: for file migration")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241120160132.3659735-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 87ae45e602e2943d58509e470e3a1d4ba084ab2f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/fd.c b/migration/fd.c
index aab5189eac..9bf9be6acb 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -25,6 +25,29 @@
 #include "io/channel-util.h"
 #include "trace.h"
 
+static bool fd_is_pipe(int fd)
+{
+    struct stat statbuf;
+
+    if (fstat(fd, &statbuf) == -1) {
+        return false;
+    }
+
+    return S_ISFIFO(statbuf.st_mode);
+}
+
+static bool migration_fd_valid(int fd)
+{
+    if (fd_is_socket(fd)) {
+        return true;
+    }
+
+    if (fd_is_pipe(fd)) {
+        return true;
+    }
+
+    return false;
+}
 
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp)
 {
@@ -34,7 +57,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
         return;
     }
 
-    if (!fd_is_socket(fd)) {
+    if (!migration_fd_valid(fd)) {
         warn_report("fd: migration to a file is deprecated."
                     " Use file: instead.");
     }
@@ -68,7 +91,7 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
         return;
     }
 
-    if (!fd_is_socket(fd)) {
+    if (!migration_fd_valid(fd)) {
         warn_report("fd: migration to a file is deprecated."
                     " Use file: instead.");
     }
-- 
2.39.5


