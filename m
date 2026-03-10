Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63613FD4F03
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzv8-0003Kh-QK; Tue, 10 Mar 2026 12:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzuy-0003FP-Og
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzux-0000qP-67
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2jKFiN08fRsXOaMTsgf+6IZcnZctyjQwYVDATN5P8Y=;
 b=IQDPej7PFSjlLvjN3BFUzAfNas7Btr4UdJj4zu6OSTjJvFcF1BSHHYYmovHU5srAhSp47d
 rUbNnaQw32ALojXS2RVjZd5iQCHRWKTytzjVosTWvlXgidL7MgFmNxGFnXy9+tGPrGUXJa
 Y9+LyHYA5BH2+X0S0a4huyTyn7nyEFc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-pBiNELYNPReY9K5t4I2JlA-1; Tue,
 10 Mar 2026 12:26:42 -0400
X-MC-Unique: pBiNELYNPReY9K5t4I2JlA-1
X-Mimecast-MFC-AGG-ID: pBiNELYNPReY9K5t4I2JlA_1773160002
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E39C71955E87; Tue, 10 Mar 2026 16:26:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD90419560A6; Tue, 10 Mar 2026 16:26:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/28] fuse: Fix mount options
Date: Tue, 10 Mar 2026 17:26:01 +0100
Message-ID: <20260310162622.333137-8-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

Since I actually took a look into how mounting with libfuse works[1], I
now know that the FUSE mount options are not exactly standard mount
system call options.  Specifically:
- We should add "nosuid,nodev,noatime" because that is going to be
  translated into the respective MS_ mount flags; and those flags make
  sense for us.
- We can set rw/ro to make the mount writable or not.  It makes sense to
  set this flag to produce a better error message for read-only exports
  (EROFS instead of EACCES).
  This changes behavior as can be seen in iotest 308: It is no longer
  possible to modify metadata of read-only exports.
  Similarly, in fuse-allow-other, we must now make the export writable
  to use SETATTR.

In addition, in the comment, we can note that the FUSE mount() system
call actually expects some more parameters that we can omit because
fusermount3 (i.e. libfuse) will figure them out by itself:
- fd: /dev/fuse fd
- rootmode: Inode mode of the root node
- user_id/group_id: Mounter's UID/GID

[1] It invokes fusermount3, an SUID libfuse helper program, which parses
    and processes some mount options before actually invoking the
    mount() system call.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-8-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c                           | 14 +++++++++++---
 tests/qemu-iotests/308                        |  4 ++--
 tests/qemu-iotests/308.out                    |  3 ++-
 tests/qemu-iotests/tests/fuse-allow-other     |  3 ++-
 tests/qemu-iotests/tests/fuse-allow-other.out |  9 ++++++---
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 82560ca071f..0422cf4b8af 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -246,10 +246,18 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     int ret;
 
     /*
-     * max_read needs to match what fuse_init() sets.
-     * max_write need not be supplied.
+     * Note that these mount options differ from what we would pass to a direct
+     * mount() call:
+     * - nosuid, nodev, and noatime are not understood by the kernel; libfuse
+     *   uses those options to construct the mount flags (MS_*)
+     * - The FUSE kernel driver requires additional options (fd, rootmode,
+     *   user_id, group_id); these will be set by libfuse.
+     * Note that max_read is set here, while max_write is set via the FUSE INIT
+     * operation.
      */
-    mount_opts = g_strdup_printf("max_read=%zu,default_permissions%s",
+    mount_opts = g_strdup_printf("%s,nosuid,nodev,noatime,max_read=%zu,"
+                                 "default_permissions%s",
+                                 exp->writable ? "rw" : "ro",
                                  FUSE_MAX_BOUNCE_BYTES,
                                  exp->allow_other ? ",allow_other" : "");
 
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index 6eced3aefb9..033d5cbe222 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -178,7 +178,7 @@ stat -c 'Permissions pre-chmod: %a' "$EXT_MP"
 chmod u+w "$EXT_MP" 2>&1 | _filter_testdir | _filter_imgfmt
 stat -c 'Permissions post-+w: %a' "$EXT_MP"
 
-# But that we can set, say, +x (if we are so inclined)
+# Same for other flags, like, say +x
 chmod u+x "$EXT_MP" 2>&1 | _filter_testdir | _filter_imgfmt
 stat -c 'Permissions post-+x: %a' "$EXT_MP"
 
@@ -236,7 +236,7 @@ output=$($QEMU_IO -f raw -c 'write -P 42 1M 64k' "$TEST_IMG" 2>&1 \
 
 # Expected reference output: Opening the file fails because it has no
 # write permission
-reference="Could not open 'TEST_DIR/t.IMGFMT': Permission denied"
+reference="Could not open 'TEST_DIR/t.IMGFMT': Read-only file system"
 
 if echo "$output" | grep -q "$reference"; then
     echo "Writing to read-only export failed: OK"
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index e5e233691d6..aa96faab6d0 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -53,7 +53,8 @@ Images are identical.
 Permissions pre-chmod: 400
 chmod: changing permissions of 'TEST_DIR/t.IMGFMT.fuse': Read-only file system
 Permissions post-+w: 400
-Permissions post-+x: 500
+chmod: changing permissions of 'TEST_DIR/t.IMGFMT.fuse': Read-only file system
+Permissions post-+x: 400
 
 === Mount over existing file ===
 {'execute': 'block-export-add',
diff --git a/tests/qemu-iotests/tests/fuse-allow-other b/tests/qemu-iotests/tests/fuse-allow-other
index 19f494aefb1..eaa39f8f236 100755
--- a/tests/qemu-iotests/tests/fuse-allow-other
+++ b/tests/qemu-iotests/tests/fuse-allow-other
@@ -101,7 +101,8 @@ run_permission_test()
 
     fuse_export_add 'export' \
         "'mountpoint': '$EXT_MP',
-         'allow-other': '$1'"
+         'allow-other': '$1',
+         'writable': true"
 
     # Should always work
     echo '(Removing all permissions)'
diff --git a/tests/qemu-iotests/tests/fuse-allow-other.out b/tests/qemu-iotests/tests/fuse-allow-other.out
index 3219fc35e05..62660b40bfc 100644
--- a/tests/qemu-iotests/tests/fuse-allow-other.out
+++ b/tests/qemu-iotests/tests/fuse-allow-other.out
@@ -12,7 +12,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'off'
+         'allow-other': 'off',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)
@@ -41,7 +42,8 @@ stat: cannot statx 'fuse-export': Permission denied
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'on'
+         'allow-other': 'on',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)
@@ -68,7 +70,8 @@ Permissions seen by nobody: 440
                   'id': 'export',
                   'node-name': 'node-format',
                   'mountpoint': 'TEST_DIR/fuse-export',
-         'allow-other': 'auto'
+         'allow-other': 'auto',
+         'writable': true
               } }
 {"return": {}}
 (Removing all permissions)
-- 
2.53.0


