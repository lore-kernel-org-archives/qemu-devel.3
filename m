Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42666072EE4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iTP1MkQn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvY-0006Og-9N; Mon, 02 Nov 2026 11:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvV-0006L0-09
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvR-0002H8-Mv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/pghLjNRaWF66up7yWnfwnuFabovykKkuWBoCd7/Bo=;
 b=iTP1MkQnuei0f0WozUfcsbTOu3P07NQhArB7Bahf8USoQzHfR/gk/00e6Px6nOQ5YQaUWa
 GPJGJWnwntAwMVSEu/lyuP4FMsDtHvJHbs3JKN+Sl0s3YFmwYYJWYR8DUGj5oP/FxQe2lF
 TzTvDOESa9GIjTWn9xm+WMoNgIhO0po=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-WQiuZK1eOV-1TTviHhZa2Q-1; Mon,
 02 Nov 2026 11:30:21 -0500
X-MC-Unique: WQiuZK1eOV-1TTviHhZa2Q-1
X-Mimecast-MFC-AGG-ID: WQiuZK1eOV-1TTviHhZa2Q_1793637020
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70BCB18021ED; Mon,  2 Nov 2026 16:30:20 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8988F1956087; Mon,  2 Nov 2026 16:30:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/17] file-posix: Add 'accept-read-only-device' option
Date: Mon,  2 Nov 2026 17:29:47 +0100
Message-ID: <20261102162955.268763-10-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The host_device block driver refuses to open a block device read-write
if the BLKROGET ioctl tells it that it's actually read-only. For such
devices it's possible to open a read-write file descriptor, but any
writes to the device would fail.

There are valid use cases for which this check gets in the way, as
explained in the bug report:

    However, this behavior prevents a legitimate enterprise use case:
    running VMs against storage replication target LUNs in a disaster
    recovery configuration. Enterprise storage arrays (Dell Powermax,
    Pure Storage) set the SCSI Write Protect bit on replication target
    LUNs, causing the Linux kernel to mark them read-only via BLKROGET.
    The VMs on the passive DR site need to start with these LUNs
    attached - writes are expected to fail (the application middleware
    knows it's on the passive side), and after a DR role swap the LUN
    becomes writable and writes should succeed immediately without any
    VM restart.

In order to allow such use cases in which a currently read-only device
is deliberately opened read-write, add a new option to the host_device
driver that allows the user to skip the check.

Buglink: https://redhat.atlassian.net/browse/RHEL-186136
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20261029164522.103918-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 19 ++++++++++++++++++-
 block/file-posix.c   | 23 ++++++++++++++++++++---
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 469297ea70f..32a36c76c89 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3390,6 +3390,23 @@
   'features': [ { 'name': 'dynamic-auto-read-only',
                   'if': 'CONFIG_POSIX' } ] }
 
+##
+# @BlockdevOptionsHostDevice:
+#     Driver specific block device options for the host_device
+#     backend.
+#
+# @accept-read-only-device: allow opening a read-only device as
+#     read-write.  If this is false, opening a host device read-write
+#     requires on Linux that the BLKROGET ioctl considers the device
+#     writable.  If it is true, this check is skipped.  (since: 11.2,
+#     default: false)
+#
+# Since: 11.2
+##
+{ 'struct': 'BlockdevOptionsHostDevice',
+  'base': 'BlockdevOptionsFile',
+  'data': { '*accept-read-only-device': 'bool' } }
+
 ##
 # @BlockdevOptionsNull:
 #     Driver specific block device options for the null backend.
@@ -4777,7 +4794,7 @@
       'ftps':       'BlockdevOptionsCurlFtps',
       'host_cdrom':  { 'type': 'BlockdevOptionsFile',
                        'if': 'HAVE_HOST_BLOCK_DEVICE' },
-      'host_device': { 'type': 'BlockdevOptionsFile',
+      'host_device': { 'type': 'BlockdevOptionsHostDevice',
                        'if': 'HAVE_HOST_BLOCK_DEVICE' },
       'http':       'BlockdevOptionsCurlHttp',
       'https':      'BlockdevOptionsCurlHttps',
diff --git a/block/file-posix.c b/block/file-posix.c
index bad7ccdb733..3318912b5ac 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -177,6 +177,7 @@ typedef struct BDRVRawState {
     bool has_laio_fdsync:1;
     bool use_linux_io_uring:1;
     bool use_mpath:1;
+    bool accept_read_only_device:1;
     int page_cache_inconsistent; /* errno from fdatasync failure */
     bool has_fallocate;
     bool needs_alignment;
@@ -513,7 +514,7 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
     }
 }
 
-static int check_hdev_writable(int fd)
+static int check_hdev_writable(BlockDriverState *bs, int fd)
 {
 #if defined(BLKROGET)
     /* Linux block devices can be configured "read-only" using blockdev(8).
@@ -523,10 +524,19 @@ static int check_hdev_writable(int fd)
      * bdrv_open() is supposed to fail if the disk is read-only.  Explicitly
      * check for read-only block devices so that Linux block devices behave
      * properly.
+     *
+     * Users can use the accept-read-only-device option to skip the check if
+     * they deliberately open a read-only block device as writable, e.g. because
+     * it may become read-write later.
      */
+    BDRVRawState *s = bs->opaque;
     struct stat st;
     int readonly = 0;
 
+    if (s->accept_read_only_device) {
+        return 0;
+    }
+
     if (fstat(fd, &st)) {
         return -errno;
     }
@@ -620,6 +630,11 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "check that page cache was dropped on live migration (default: off)"
         },
+        {
+            .name = "accept-read-only-device",
+            .type = QEMU_OPT_BOOL,
+            .help = "allow opening a read-only device as read-write (default: off)"
+        },
         { /* end of list */ }
     },
 };
@@ -737,8 +752,10 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     s->fd = fd;
 
     /* Check s->open_flags rather than bdrv_flags due to auto-read-only */
+    s->accept_read_only_device =
+        qemu_opt_get_bool(opts, "accept-read-only-device", false);
     if (s->open_flags & O_RDWR) {
-        ret = check_hdev_writable(s->fd);
+        ret = check_hdev_writable(bs, s->fd);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "The device is not writable");
             goto fail;
@@ -1116,7 +1133,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
     }
 
     if (fd != -1 && (*open_flags & O_RDWR)) {
-        ret = check_hdev_writable(fd);
+        ret = check_hdev_writable(bs, fd);
         if (ret < 0) {
             qemu_close(fd);
             error_setg_errno(errp, -ret, "The device is not writable");
-- 
2.56.0


