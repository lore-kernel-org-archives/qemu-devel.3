Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5692606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJM6ZtBR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7BK-00030C-4m; Wed, 28 Oct 2026 13:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xM7BI-0002zI-TO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xM7BH-0003FW-2q
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0BtO5t8oxsZ9HPm3yVP1TLg6x5d6xDyG6BWtWjo5R0=;
 b=RJM6ZtBRJj9bmKKOA9yHLB6137ONxNZSodg+t8/wvKaeVoMi9bjE0lDsEwyWnjBY+hqQfx
 ZGO+MZnEpUOyi9swGxNocc1rqeqJhZoaauU0Xuuz6GtbX+VxJPmVBta9JHh+gq+ZMZwcb4
 r0EJvXbuDdEwAofVdX9L5E7aBFB7kRE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-QksxcVjiMRauAKUZTMpZcg-1; Wed,
 28 Oct 2026 13:11:15 -0400
X-MC-Unique: QksxcVjiMRauAKUZTMpZcg-1
X-Mimecast-MFC-AGG-ID: QksxcVjiMRauAKUZTMpZcg_1793207474
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1B0618007F0; Wed, 28 Oct 2026 17:11:13 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3078F1800446; Wed, 28 Oct 2026 17:11:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, afaria@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] file-posix: Add 'accept-read-only-device' option
Date: Wed, 28 Oct 2026 18:10:56 +0100
Message-ID: <20261028171057.139326-2-kwolf@redhat.com>
In-Reply-To: <20261028171057.139326-1-kwolf@redhat.com>
References: <20261028171057.139326-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 qapi/block-core.json | 19 ++++++++++++++++++-
 block/file-posix.c   | 23 ++++++++++++++++++++---
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 741c8165c06..80272b878c5 100644
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


