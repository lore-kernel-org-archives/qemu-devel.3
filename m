Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04308C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC00-0006nP-GL; Thu, 06 Mar 2025 09:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqBzy-0006mC-VN
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:14:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqBzw-0001ZE-5s
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7xl4PVyNoAGYZsF4VN6ErV6AJOrELxS7uo5iP6Ku9o=;
 b=fupyYCH0T/sd8qJBauY/+zqST9or8TtxkmKRL8EotFMR1SisJoKT+SdA9z014gYE9qJoJX
 ulUn83SHkJO1y4+JJl4NGW8GjVVCmt2Q7Cnu70OW/0I01/s+NISNJCUx/vsLs8+sfE22kb
 OE7kZa+j6uWRZbCHUi+PNn8ARg+XIjo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-L3geaJjbN9Wcz8T4d3qzYQ-1; Thu,
 06 Mar 2025 09:14:45 -0500
X-MC-Unique: L3geaJjbN9Wcz8T4d3qzYQ-1
X-Mimecast-MFC-AGG-ID: L3geaJjbN9Wcz8T4d3qzYQ_1741270484
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11FC51828A87; Thu,  6 Mar 2025 14:14:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62F6018001D3; Thu,  6 Mar 2025 14:14:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 04/42] pci: Use PCI PM capability initializer
Date: Thu,  6 Mar 2025 15:13:40 +0100
Message-ID: <20250306141419.2015340-5-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Alex Williamson <alex.williamson@redhat.com>

Switch callers directly initializing the PCI PM capability with
pci_add_capability() to use pci_pm_init().

Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Klaus Jensen <its@irrelevant.dk>
Cc: Jesper Devantier <foss@defmacro.it>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250225215237.3314011-3-alex.williamson@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/e1000e.c                 | 3 +--
 hw/net/eepro100.c               | 4 +---
 hw/net/igb.c                    | 3 +--
 hw/nvme/ctrl.c                  | 3 +--
 hw/pci-bridge/pcie_pci_bridge.c | 2 +-
 hw/vfio/pci.c                   | 7 ++++++-
 hw/virtio/virtio-pci.c          | 3 +--
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index f637853073e2610dd93b4de006f539093883fe07..b72cbab7e88904e3e6e7eb8d1904d68ca2e64d9d 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -372,8 +372,7 @@ static int
 e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
 {
     Error *local_err = NULL;
-    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
-                                 PCI_PM_SIZEOF, &local_err);
+    int ret = pci_pm_init(pdev, offset, &local_err);
 
     if (local_err) {
         error_report_err(local_err);
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 6d853229aec2ed285d212a48bdfc69812e58c30f..29a39865a6086b8f175be6be00311487bc59f25c 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -551,9 +551,7 @@ static void e100_pci_reset(EEPRO100State *s, Error **errp)
     if (info->power_management) {
         /* Power Management Capabilities */
         int cfg_offset = 0xdc;
-        int r = pci_add_capability(&s->dev, PCI_CAP_ID_PM,
-                                   cfg_offset, PCI_PM_SIZEOF,
-                                   errp);
+        int r = pci_pm_init(&s->dev, cfg_offset, errp);
         if (r < 0) {
             return;
         }
diff --git a/hw/net/igb.c b/hw/net/igb.c
index c965fc2fb68a37699c1cc4be0be2a6467522ccc0..e318df40e0138d5101f99680d17b97917e6fb559 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -356,8 +356,7 @@ static int
 igb_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
 {
     Error *local_err = NULL;
-    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
-                                 PCI_PM_SIZEOF, &local_err);
+    int ret = pci_pm_init(pdev, offset, &local_err);
 
     if (local_err) {
         error_report_err(local_err);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e62c6a358828b82d6f0cef5de9b49291f17bde96..518d02dc66706e2d2e86f1705db52188a97a67fc 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8600,8 +8600,7 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
     Error *err = NULL;
     int ret;
 
-    ret = pci_add_capability(pci_dev, PCI_CAP_ID_PM, offset,
-                             PCI_PM_SIZEOF, &err);
+    ret = pci_pm_init(pci_dev, offset, &err);
     if (err) {
         error_report_err(err);
         return ret;
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index fd4514a595ce08d82773376bd7294a43a551762a..9fa656b43b42624fd597ec6df5d986e71e5f06f0 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -52,7 +52,7 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
         goto cap_error;
     }
 
-    pos = pci_add_capability(d, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF, errp);
+    pos = pci_pm_init(d, 0, errp);
     if (pos < 0) {
         goto pm_error;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4f92b50b133060c9199079a0ab620793ecdac0ee..d33b795af079ae6999a5b4e4074c202c5a9de362 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2216,7 +2216,12 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
     case PCI_CAP_ID_PM:
         vfio_check_pm_reset(vdev, pos);
         vdev->pm_cap = pos;
-        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
+        ret = pci_pm_init(pdev, pos, errp) >= 0;
+        /*
+         * PCI-core config space emulation needs write access to the power
+         * state enabled for tracking BAR mapping relative to PM state.
+         */
+        pci_set_word(pdev->wmask + pos + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
         break;
     case PCI_CAP_ID_AF:
         vfio_check_af_flr(vdev, pos);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c773a9130c7e8890b93d20a17b099940284060be..afe8b5551c5cc5d33a184f25ac05efa2c126e796 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2204,8 +2204,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
 
-        pos = pci_add_capability(pci_dev, PCI_CAP_ID_PM, 0,
-                                 PCI_PM_SIZEOF, errp);
+        pos = pci_pm_init(pci_dev, 0, errp);
         if (pos < 0) {
             return;
         }
-- 
2.48.1


