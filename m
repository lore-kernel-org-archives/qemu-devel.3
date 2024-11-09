Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26510D5E122
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f8U-0003Su-Tb; Sat, 09 Nov 2024 01:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8C-00035N-LA; Sat, 09 Nov 2024 01:39:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f89-00020j-Hq; Sat, 09 Nov 2024 01:39:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E586DA12EF;
 Sat,  9 Nov 2024 09:38:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4DAF9167DD3;
 Sat,  9 Nov 2024 09:39:04 +0300 (MSK)
Received: (nullmailer pid 3272515 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 08/33] scsi: fetch unit attention when creating the
 request
Date: Sat,  9 Nov 2024 09:38:34 +0300
Message-Id: <20241109063903.3272404-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
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

From: Stefano Garzarella <sgarzare@redhat.com>

Commit 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs") split
calls to scsi_req_new() and scsi_req_enqueue() in the virtio-scsi device.
No ill effects were observed until commit 8cc5583abe ("virtio-scsi: Send
"REPORTED LUNS CHANGED" sense data upon disk hotplug events") added a
unit attention that was easy to trigger with device hotplug and
hot-unplug.

Because the two calls were separated, all requests in the batch were
prepared calling scsi_req_new() to report a sense.  The first one
submitted would report the right sense and reset it to NO_SENSE, while
the others reported CHECK_CONDITION with no sense data.  This caused
SCSI errors in Linux.

To solve this issue, let's fetch the unit attention as early as possible
when we prepare the request, so that only the first request in the batch
will use the unit attention SCSIReqOps and the others will not report
CHECK CONDITION.

Fixes: 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs")
Fixes: 8cc5583abe ("virtio-scsi: Send "REPORTED LUNS CHANGED" sense data upon disk hotplug events")
Reported-by: Thomas Huth <thuth@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20230712134352.118655-2-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 9472083e642bfb9bc836b38662baddd9bc964ebc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index e5c9f7a53d..e76bfbd47b 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -413,19 +413,35 @@ static const struct SCSIReqOps reqops_invalid_opcode = {
 
 /* SCSIReqOps implementation for unit attention conditions.  */
 
-static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
+static void scsi_fetch_unit_attention_sense(SCSIRequest *req)
 {
+    SCSISense *ua = NULL;
+
     if (req->dev->unit_attention.key == UNIT_ATTENTION) {
-        scsi_req_build_sense(req, req->dev->unit_attention);
+        ua = &req->dev->unit_attention;
     } else if (req->bus->unit_attention.key == UNIT_ATTENTION) {
-        scsi_req_build_sense(req, req->bus->unit_attention);
+        ua = &req->bus->unit_attention;
     }
+
+    /*
+     * Fetch the unit attention sense immediately so that another
+     * scsi_req_new does not use reqops_unit_attention.
+     */
+    if (ua) {
+        scsi_req_build_sense(req, *ua);
+        *ua = SENSE_CODE(NO_SENSE);
+    }
+}
+
+static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
+{
     scsi_req_complete(req, CHECK_CONDITION);
     return 0;
 }
 
 static const struct SCSIReqOps reqops_unit_attention = {
     .size         = sizeof(SCSIRequest),
+    .init_req     = scsi_fetch_unit_attention_sense,
     .send_command = scsi_unit_attention
 };
 
@@ -699,6 +715,11 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
     object_ref(OBJECT(d));
     object_ref(OBJECT(qbus->parent));
     notifier_list_init(&req->cancel_notifiers);
+
+    if (reqops->init_req) {
+        reqops->init_req(req);
+    }
+
     trace_scsi_req_alloc(req->dev->id, req->lun, req->tag);
     return req;
 }
@@ -798,6 +819,15 @@ uint8_t *scsi_req_get_buf(SCSIRequest *req)
 static void scsi_clear_unit_attention(SCSIRequest *req)
 {
     SCSISense *ua;
+
+    /*
+     * scsi_fetch_unit_attention_sense() already cleaned the unit attention
+     * in this case.
+     */
+    if (req->ops == &reqops_unit_attention) {
+        return;
+    }
+
     if (req->dev->unit_attention.key != UNIT_ATTENTION &&
         req->bus->unit_attention.key != UNIT_ATTENTION) {
         return;
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 6ea4b64fe7..60bc32da32 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -108,6 +108,7 @@ int cdrom_read_toc_raw(int nb_sectors, uint8_t *buf, int msf, int session_num);
 /* scsi-bus.c */
 struct SCSIReqOps {
     size_t size;
+    void (*init_req)(SCSIRequest *req);
     void (*free_req)(SCSIRequest *req);
     int32_t (*send_command)(SCSIRequest *req, uint8_t *buf);
     void (*read_data)(SCSIRequest *req);
-- 
2.39.5


