Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624F3C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM7T-0001o1-PF; Wed, 29 May 2024 12:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM75-0001IB-4I
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:23 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM72-0006N6-Nt
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:18 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6r-006CR0-9r;
 Wed, 29 May 2024 17:25:05 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 22/26] vfio-user: no-mmap DMA support
Date: Wed, 29 May 2024 17:23:15 +0100
Message-Id: <20240529162319.1476680-23-levon@movementarian.org>
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

Force remote process to use DMA r/w messages instead
of directly mapping guest memory.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/user-container.c | 2 +-
 hw/vfio/user-pci.c       | 5 +++++
 hw/vfio/user.h           | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/user-container.c b/hw/vfio/user-container.c
index 213861fb5d..1f6710e0b7 100644
--- a/hw/vfio/user-container.c
+++ b/hw/vfio/user-container.c
@@ -110,7 +110,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      * vaddr enters as a QEMU process address; make it either a file offset
      * for mapped areas or leave as 0.
      */
-    if (fd != -1) {
+    if (fd != -1 && !(container->proxy->flags & VFIO_PROXY_NO_MMAP)) {
         msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
     }
 
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index 9514f6e2fa..19fbcf77ab 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -40,6 +40,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
+    bool no_direct_dma; /* disable shared mem for DMA */
     bool send_queued;   /* all sends are queued */
     bool no_post;       /* all regions write are sync */
 };
@@ -158,6 +159,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    if (udev->no_direct_dma) {
+        proxy->flags |= VFIO_PROXY_NO_MMAP;
+    }
     if (udev->send_queued) {
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
@@ -277,6 +281,7 @@ static void vfio_user_instance_finalize(Object *obj)
 
 static Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+    DEFINE_PROP_BOOL("no-direct-dma", VFIOUserPCIDevice, no_direct_dma, false),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index 31d2c5abd9..fe24a881f2 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -94,6 +94,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_NO_MMAP       0x2
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
 
-- 
2.34.1


