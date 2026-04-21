Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4269CF8FA9B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE5P-0005qC-VF; Tue, 21 Apr 2026 12:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE4f-0004qG-CF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE4V-0007UD-5K
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4boacDBWXxI5RCVqYYkYH11QOnnmQygqQshHe9V5xU=;
 b=fncuQVJRDaTBWjn7CDKq7vGkRQXiPqfCCvw+zgJkyv7OKtUY+fQskfv8XwvpWdUZmYfyYL
 wdLUed9mrWOd78oLyLQtCj+XOQj4Fgvq8G2o2HoBARzY5ug75w8bapMBCXSl6HrbXoncTF
 t+qV91WQcSDBRfIXcrnlbZ2BbTxYum0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-kl6Dm1SGPSGekxQN19MjgQ-1; Tue,
 21 Apr 2026 12:35:14 -0400
X-MC-Unique: kl6Dm1SGPSGekxQN19MjgQ-1
X-Mimecast-MFC-AGG-ID: kl6Dm1SGPSGekxQN19MjgQ_1776789313
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 817DA19560AD; Tue, 21 Apr 2026 16:35:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBAB71956095; Tue, 21 Apr 2026 16:35:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, John Levon <john.levon@nutanix.com>,
 Patrick Mooney <patrick@matx.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/14] vfio-user: fix DMA write reply
Date: Tue, 21 Apr 2026 18:34:38 +0200
Message-ID: <20260421163438.3447280-15-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

The protocol specifies that DMA write replies should include
address+count, but the client code was only doing so for read. Fix that
up.

In addition, add a protocol clarification over how short writes may be
reported in that reply. QEMU never reports a short write via the
count field.

Reported-by: Patrick Mooney <patrick@matx.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260410085716.877185-4-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/interop/vfio-user.rst |  6 ++++++
 hw/vfio-user/pci.c         | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index d4766487ea6d0ee021316890d443814957cf6284..12deb25102af217f7f292b4cb655dc4a6a92439a 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -1429,6 +1429,9 @@ Reply
 * *count* is the size of the data transferred.
 * *data* is the data read.
 
+Note that whether short reads return an error or just set count appropriately is
+a client-side choice; servers should be prepared to handle both cases.
+
 ``VFIO_USER_DMA_WRITE``
 -----------------------
 
@@ -1469,6 +1472,9 @@ Reply
 * *address* is the client DMA memory address being accessed.
 * *count* is the size of the data transferred.
 
+Note that whether short writes return an error or just set count appropriately
+is a client-side choice; servers should be prepared to handle both cases.
+
 ``VFIO_USER_DEVICE_RESET``
 --------------------------
 
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 64b8b3cb8cf5d66879af1703c4f2b5ae0c7418ca..facc79727acb82c35fec5b4bef79e78b3878531a 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -109,6 +109,10 @@ static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 
     r = pci_dma_read(pdev, res->offset, &res->data, res->count);
 
+    /*
+     * pci_dma_read() doesn't support reporting short reads via the reply's
+     * count parameter; in this case, we'll reply with an error instead.
+     */
     switch (r) {
     case MEMTX_OK:
         if (res->hdr.flags & VFIO_USER_NO_REPLY) {
@@ -136,6 +140,7 @@ static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
     MemTxResult r;
 
     if (msg->hdr.size < sizeof(*msg)) {
@@ -150,26 +155,35 @@ static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 
     r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
 
+    res = g_malloc0(sizeof(*res));
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    /*
+     * pci_dma_write() doesn't support reporting short writes via the reply's
+     * count parameter; in this case, we'll reply with an error instead.
+     */
     switch (r) {
     case MEMTX_OK:
-        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
-            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
-        } else {
-            g_free(msg);
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
         }
+
+        vfio_user_send_reply(proxy, &res->hdr, sizeof(*res));
         break;
     case MEMTX_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
         break;
     case MEMTX_DECODE_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
         break;
     case MEMTX_ACCESS_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
         break;
     default:
         error_printf("vfio_user_dma_write unknown error %d\n", r);
-        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
     }
 }
 
-- 
2.53.0


