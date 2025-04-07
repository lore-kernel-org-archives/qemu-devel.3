Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379E8C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 16:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ouG-0005OX-4q; Mon, 07 Apr 2025 12:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u1otl-0005CW-SI
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 12:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u1oti-00056N-OR
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 12:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744041628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJohG7P5ytQ3kPDfKaBa6ul4P3IleZS6AMgA1x09nqc=;
 b=JO0RTSQzfBpz6Ao6oDMsKRkq4VwU/ZdgYv2pQO2J6S8xAQ9rgV03pVuEvDbgcNkbwD7bM9
 d3fbfEkEX45UUfXKRYmGySYjUWEebrJOmAYd+kd6aXGpC+GjVlRw/hWCWwMQiZtvxXSNi8
 BeaQY9+h8k4V0fLNRZKw7DZvYTyNl4E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-aL82j_aaPmCaeQVpYwhvUA-1; Mon,
 07 Apr 2025 12:00:26 -0400
X-MC-Unique: aL82j_aaPmCaeQVpYwhvUA-1
X-Mimecast-MFC-AGG-ID: aL82j_aaPmCaeQVpYwhvUA_1744041624
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7033180AF78; Mon,  7 Apr 2025 16:00:23 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.238])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B41619560AD; Mon,  7 Apr 2025 16:00:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH for-10.0] scsi-disk: Apply error policy for host_status errors
 again
Date: Mon,  7 Apr 2025 17:59:49 +0200
Message-ID: <20250407155949.44736-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Originally, all failed SG_IO requests called scsi_handle_rw_error() to
apply the configured error policy. However, commit f3126d65, which was
supposed to be a mere refactoring for scsi-disk.c, broke this and
accidentally completed the SCSI request without considering the error
policy any more if the error was signalled in the host_status field.

Apart from the commit message not describing the chance as intended,
errors indicated in host_status are also obviously backend errors and
not something the guest must deal with indepdently of the error policy.

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
---
 hw/scsi/scsi-disk.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8da1d5a77c..e59632e9b1 100644
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
@@ -225,11 +224,26 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
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
@@ -289,6 +303,10 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
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
@@ -409,7 +427,6 @@ done:
     scsi_req_unref(&r->req);
 }
 
-/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_dma_complete(void *opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -448,7 +465,6 @@ done:
     scsi_req_unref(&r->req);
 }
 
-/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_read_complete(void *opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -585,7 +601,6 @@ done:
     scsi_req_unref(&r->req);
 }
 
-/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_write_complete(void * opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -2846,14 +2861,10 @@ static void scsi_block_sgio_complete(void *opaque, int ret)
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
2.48.1


