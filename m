Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73438E7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn10R-0003mO-0r; Mon, 02 Feb 2026 15:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn10L-0003jX-MN; Mon, 02 Feb 2026 15:58:41 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn10I-0003kP-Eq; Mon, 02 Feb 2026 15:58:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B733518518D;
 Mon, 02 Feb 2026 23:57:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F0EA35B304;
 Mon, 02 Feb 2026 23:58:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 01/74] file-posix: Handle suspended dm-multipath
 better for SG_IO
Date: Mon,  2 Feb 2026 23:57:12 +0300
Message-ID: <20260202205833.941615-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

When introducing DM_MPATH_PROBE_PATHS, we already anticipated that
dm-multipath devices might be suspended for a short time when the DM
tables are reloaded and that they return -EAGAIN in this case. We then
wait for a millisecond and retry.

However, meanwhile it has also turned out that libmpathpersist (which is
used by qemu-pr-helper) may need to perform more complex recovery
operations to get reservations back to expected state if a path failure
happened in the middle of a PR operation. In this case, the device is
suspended for a longer time compared to the case we originally expected.

This patch changes hdev_co_ioctl() to treat -EAGAIN separately so that
it doesn't result in an immediate failure if the device is suspended for
more than 1ms, and moves to incremental backoff to cover both quick and
slow cases without excessive delays.

Buglink: https://issues.redhat.com/browse/RHEL-121543
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20251128221440.89125-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 2c3165a1a61c299b4a3ae30899e1cc738d20e004)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/file-posix.c b/block/file-posix.c
index 827ffa77a5..d7f489a40b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -4300,25 +4300,8 @@ hdev_open_Mac_error:
 static bool coroutine_fn sgio_path_error(int ret, sg_io_hdr_t *io_hdr)
 {
     if (ret < 0) {
-        switch (ret) {
-        case -ENODEV:
-            return true;
-        case -EAGAIN:
-            /*
-             * The device is probably suspended. This happens while the dm table
-             * is reloaded, e.g. because a path is added or removed. This is an
-             * operation that should complete within 1ms, so just wait a bit and
-             * retry.
-             *
-             * If the device was suspended for another reason, we'll wait and
-             * retry SG_IO_MAX_RETRIES times. This is a tolerable delay before
-             * we return an error and potentially stop the VM.
-             */
-            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
-            return true;
-        default:
-            return false;
-        }
+        /* Path errors sometimes result in -ENODEV */
+        return ret == -ENODEV;
     }
 
     if (io_hdr->host_status != SCSI_HOST_OK) {
@@ -4387,6 +4370,7 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
+    uint64_t eagain_sleep_ns = 1 * SCALE_MS;
     int retries = SG_IO_MAX_RETRIES;
     int ret;
 
@@ -4415,9 +4399,37 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
         },
     };
 
-    do {
-        ret = raw_thread_pool_submit(handle_aiocb_ioctl, &acb);
-    } while (req == SG_IO && retries-- && hdev_co_ioctl_sgio_retry(&acb, ret));
+retry:
+    ret = raw_thread_pool_submit(handle_aiocb_ioctl, &acb);
+    if (req == SG_IO && s->use_mpath) {
+        if (ret == -EAGAIN && eagain_sleep_ns < NANOSECONDS_PER_SECOND) {
+            /*
+             * If this is a multipath device, it is probably suspended.
+             *
+             * This can happen while the dm table is reloaded, e.g. because a
+             * path is added or removed. This is an operation that should
+             * complete within 1ms, so just wait a bit and retry.
+             *
+             * There are also some cases in which libmpathpersist must recover
+             * from path failure during its operation, which can leave the
+             * device suspended for a bit longer while the library brings back
+             * reservations into the expected state.
+             *
+             * Use increasing delays to cover both cases without waiting
+             * excessively, and stop after a bit more than a second (1023 ms).
+             * This is a tolerable delay before we return an error and
+             * potentially stop the VM.
+             */
+            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, eagain_sleep_ns);
+            eagain_sleep_ns *= 2;
+            goto retry;
+        }
+
+        /* Even for ret == 0, the SG_IO header can contain an error */
+        if (retries-- && hdev_co_ioctl_sgio_retry(&acb, ret)) {
+            goto retry;
+        }
+    }
 
     return ret;
 }
-- 
2.47.3


