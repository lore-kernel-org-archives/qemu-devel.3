Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78779C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM7Z-00024e-BM; Wed, 29 May 2024 12:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM76-0001IZ-GW
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:23 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM74-0006Np-EL
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:19 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6t-006CRE-4c;
 Wed, 29 May 2024 17:25:07 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 25/26] vfio-user: add 'x-msg-timeout' option that specifies
 msg wait times
Date: Wed, 29 May 2024 17:23:18 +0100
Message-Id: <20240529162319.1476680-26-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529162319.1476680-1-levon@movementarian.org>
References: <20240529162319.1476680-1-levon@movementarian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jagannathan Raman <jag.raman@oracle.com>

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/user-pci.c | 4 ++++
 hw/vfio/user.c     | 7 ++++---
 hw/vfio/user.h     | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index b473cbc404..b70aeb6ee3 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -43,6 +43,7 @@ struct VFIOUserPCIDevice {
     bool no_direct_dma; /* disable shared mem for DMA */
     bool send_queued;   /* all sends are queued */
     bool no_post;       /* all regions write are sync */
+    uint32_t wait_time; /* timeout for message replies */
 };
 
 /*
@@ -278,6 +279,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (udev->no_post) {
         proxy->flags |= VFIO_PROXY_NO_POST;
     }
+    /* user specified or 5 sec default */
+    proxy->wait_time = udev->wait_time;
 
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
@@ -408,6 +411,7 @@ static Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_BOOL("no-direct-dma", VFIOUserPCIDevice, no_direct_dma, false),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
+    DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index 3a38aa5543..f13381f310 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -43,7 +43,6 @@
 #define VFIO_USER_MAX_REGIONS   100
 #define VFIO_USER_MAX_IRQS      50
 
-static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -723,7 +722,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 
     if (ret == 0) {
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
@@ -766,7 +766,8 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
         msg->type = VFIO_MSG_WAIT;
         proxy->last_nowait = NULL;
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index d9aa1759df..ff2aa005eb 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -72,6 +72,7 @@ typedef struct VFIOUserProxy {
     uint64_t max_bitmap;
     uint64_t migr_pgsize;
     int flags;
+    uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
-- 
2.34.1


