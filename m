Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD2FC3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBiV-0006Yp-3l; Wed, 14 May 2025 09:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhz-0004nO-QB; Wed, 14 May 2025 08:59:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhx-0007wQ-6o; Wed, 14 May 2025 08:59:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A47CA121AEC;
 Wed, 14 May 2025 15:57:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4F8EE20B85A;
 Wed, 14 May 2025 15:57:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 14/34] scsi-disk: Apply error policy for host_status
 errors again
Date: Wed, 14 May 2025 15:57:36 +0300
Message-Id: <20250514125758.92030-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
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

From: Kevin Wolf <kwolf@redhat.com>

Originally, all failed SG_IO requests called scsi_handle_rw_error() to
apply the configured error policy. However, commit f3126d65, which was
supposed to be a mere refactoring for scsi-disk.c, broke this and
accidentally completed the SCSI request without considering the error
policy any more if the error was signalled in the host_status field.

Apart from the commit message not describing the change as intended,
errors indicated in host_status are also obviously backend errors and
not something the guest must deal with independently of the error
policy.

This behaviour means that some recoverable errors (such as a path error
in multipath configurations) were reported to the guest anyway, which
might not expect it and might consider its disk broken.

Make sure that we apply the error policy again for host_status errors,
too. This addresses an existing FIXME comment and allows us to remove
some comments warning that callbacks weren't always called. With this
fix, they are called in all cases again.

The return value passed to the request callback doesn't have more free
values that could be used to indicate host_status errors as well as SAM
status codes and negative errno. Store the value in the host_status
field of the SCSIRequest instead and use -ENODEV as the return value (if
a path hasn't been reachable for a while, blk_aio_ioctl() will return
-ENODEV instead of just setting host_status, so just reuse it here -
it's not necessarily entirely accurate, but it's as good as any errno).

Cc: qemu-stable@nongnu.org
Fixes: f3126d65b393 ('scsi: move host_status handling into SCSI drivers')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250407155949.44736-1-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 61b6d9b749ba233784c7214cfe9585ea321159dc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 7f13b0588f..7af476dfed 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -68,10 +68,9 @@ struct SCSIDiskClass {
     SCSIDeviceClass parent_class;
     /*
      * Callbacks receive ret == 0 for success. Errors are represented either as
-     * negative errno values, or as positive SAM status codes.
-     *
-     * Beware: For errors returned in host_status, the function may directly
-     * complete the request and never call the callback.
+     * negative errno values, or as positive SAM status codes. For host_status
+     * errors, the function passes ret == -ENODEV and sets the host_status field
+     * of the SCSIRequest.
      */
     DMAIOFunc       *dma_readv;
     DMAIOFunc       *dma_writev;
@@ -226,11 +225,26 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
     SCSISense sense = SENSE_CODE(NO_SENSE);
+    int16_t host_status;
     int error;
     bool req_has_sense = false;
     BlockErrorAction action;
     int status;
 
+    /*
+     * host_status should only be set for SG_IO requests that came back with a
+     * host_status error in scsi_block_sgio_complete(). This error path passes
+     * -ENODEV as the return value.
+     *
+     * Reset host_status in the request because we may still want to complete
+     * the request successfully with the 'stop' or 'ignore' error policy.
+     */
+    host_status = r->req.host_status;
+    if (host_status != -1) {
+        assert(ret == -ENODEV);
+        r->req.host_status = -1;
+    }
+
     if (ret < 0) {
         status = scsi_sense_from_errno(-ret, &sense);
         error = -ret;
@@ -290,6 +304,10 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
         if (acct_failed) {
             block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
         }
+        if (host_status != -1) {
+            scsi_req_complete_failed(&r->req, host_status);
+            return true;
+        }
         if (req_has_sense) {
             sdc->update_sense(&r->req);
         } else if (status == CHECK_CONDITION) {
@@ -411,7 +429,6 @@ done:
     scsi_req_unref(&r->req);
 }
 
-/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_dma_complete(void *opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -452,7 +469,6 @@ done:
     scsi_req_unref(&r->req);
 }
 
-/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_read_complete(void *opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -592,7 +608,6 @@ done:
     scsi_req_unref(&r->req);
 }
 
-/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_write_complete(void * opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -2854,14 +2869,10 @@ static void scsi_block_sgio_complete(void *opaque, int ret)
     sg_io_hdr_t *io_hdr = &req->io_header;
 
     if (ret == 0) {
-        /* FIXME This skips calling req->cb() and any cleanup in it */
         if (io_hdr->host_status != SCSI_HOST_OK) {
-            scsi_req_complete_failed(&r->req, io_hdr->host_status);
-            scsi_req_unref(&r->req);
-            return;
-        }
-
-        if (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT) {
+            r->req.host_status = io_hdr->host_status;
+            ret = -ENODEV;
+        } else if (io_hdr->driver_status & SG_ERR_DRIVER_TIMEOUT) {
             ret = BUSY;
         } else {
             ret = io_hdr->status;
-- 
2.39.5


