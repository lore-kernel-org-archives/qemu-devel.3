Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E77D11711
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTDi-0001Lh-BH; Tue, 02 Dec 2025 11:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vQTDV-0001Ia-1V
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vQTDR-0004j3-M4
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764692819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdFoqoPtpNXd2mLP5ioJuP9OoHXHj4M2PucLwFqcNOI=;
 b=bVjLT/35hsaH3HdiCPgx6Y3F0RjS1QzSEstqvF/SXCawNp2wf3nVQukQq+IdJew9XJBOGG
 pXRRk8jP5dWvbp+JYvP0ejRqst93XJ1HJZA22Yf0F7FZBVFaKHY92QHbM9uUkKDUfgXm2w
 5HkXD3vI7Lj0RImiOf3K/fieSXVGNJ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-bNrSn5EPNy2FgzZh98k5Ag-1; Tue,
 02 Dec 2025 11:26:57 -0500
X-MC-Unique: bNrSn5EPNy2FgzZh98k5Ag-1
X-Mimecast-MFC-AGG-ID: bNrSn5EPNy2FgzZh98k5Ag_1764692815
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 412FF18005B2; Tue,  2 Dec 2025 16:26:55 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.249])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 655DF30001A4; Tue,  2 Dec 2025 16:26:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 1/1] file-posix: Handle suspended dm-multipath better for SG_IO
Date: Tue,  2 Dec 2025 17:26:45 +0100
Message-ID: <20251202162645.182909-2-kwolf@redhat.com>
In-Reply-To: <20251202162645.182909-1-kwolf@redhat.com>
References: <20251202162645.182909-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When introducing DM_MPATH_PROBE_PATHS, we already anticipated that
dm-multipath devices might be suspended for a short time when the DM
tables are reloaded and that they return -EAGAIN in this case. The
behaviour promised in the comment wasn't actually implemented, though:
We don't get SG_IO_MAX_RETRIES in practice, because after the first
1ms sleep, DM_MPATH_PROBE_PATHS is called and if that still fails with
-EAGAIN, we error out immediately without any retry.

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
---
 block/file-posix.c | 56 ++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index c9e367a222..6265d2e248 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -4288,25 +4288,8 @@ hdev_open_Mac_error:
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
@@ -4375,6 +4358,7 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
+    uint64_t eagain_sleep_ns = 1 * SCALE_MS;
     int retries = SG_IO_MAX_RETRIES;
     int ret;
 
@@ -4403,9 +4387,37 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
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
2.52.0


