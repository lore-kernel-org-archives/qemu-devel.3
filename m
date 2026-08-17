Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A51C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuqw-0001uz-Sq; Mon, 17 Aug 2026 06:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqk-0001o6-Az; Mon, 17 Aug 2026 06:45:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqh-00040o-L4; Mon, 17 Aug 2026 06:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=5PAbTQM9n14IAh7vv7hdAprQh2tsKs6uvQyLKkIHKYA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MLiYv+8PHzRZfu/w3oB8d1tx+5EeTRNfMr51QmszUtuEw+ULPoGPJ0zlHlBLjrhGw
 1MP3hJQ+2yOYNAAzTvRYiYy6dx7TmXWCqgHq9XTKeW0dpF5TCLZJLWagy7cwaVczIF
 zmxHNrmTxWhKSiinSrMSzU0xCZ0mpnyzVrsa4f3V9PdXYrzI08cNyyY/fYzpdZ7gIh
 MNPxGl812P5Hr8+/H5g4efIRZtbW9KUhvMWmEJse1g4ktakan0p0ZOx2j6XnX9crBf
 nofnuyyf67VKNKLI8zrp51QIJb+0KYBVnzJ5t0jiaQXbFWGKMAL9c+enkgzvgqxWLB
 1IprVxE/RDvsA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 84B121CBB72;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 85A0640D203;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1443930E5C; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 133/161] pc-bios/s390-ccw: Add per-queue
 notification offset for multi-queue virtio configurations
Date: Mon, 17 Aug 2026 13:42:47 +0300
Message-ID: <20260817104344.2047346-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Zhuoying Cai <zycai@linux.ibm.com>

The initial support for virtio-blk-pci IPL devices used a single virt-queue, but
other device types require multiple queues, and for PCI device types this also
requires a per-queue notification offset.

Add a PCI notify field to the VRing struct so that each queue has a unique
notify offset as defined in the virtio spec.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260630141917.673995-4-jrossi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 084feb909808d542c789dcbbf0f1ad01350a90ce)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 53bdb52e76a..2c83ec4f131 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -21,7 +21,6 @@ VirtioPciCap c_cap; /* Common capabilities  */
 VirtioPciCap d_cap; /* Device capabilities  */
 VirtioPciCap n_cap; /* Notify capabilities  */
 uint32_t notify_mult;
-uint16_t q_notify_offset;
 
 static int virtio_pci_set_status(uint8_t status)
 {
@@ -74,10 +73,10 @@ int virtio_pci_reset(VDev *vdev)
     return 0;
 }
 
-long virtio_pci_notify(int vq_id)
+long virtio_pci_notify(VRing *vr)
 {
-    uint32_t offset = n_cap.off + notify_mult * q_notify_offset;
-    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vq_id);
+    uint32_t offset = n_cap.off + notify_mult * vr->pci_notify;
+    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vr->id);
 }
 
 /*
@@ -301,8 +300,7 @@ static int virtio_pci_read_pci_cap_config(void)
     }
 
     rc = vpci_read_bswap32(pos + VPCI_N_CAP_MULT, PCI_CFGBAR, &notify_mult);
-    if (rc || vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar,
-                                &q_notify_offset)) {
+    if (rc) {
         puts("Failed to read notification queue configuration");
         return -EIO;
     }
@@ -332,7 +330,6 @@ int virtio_pci_setup(VDev *vdev)
     VRing *vr;
     int rc;
     uint8_t status;
-    uint16_t vq_size;
     int i = 0;
 
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
@@ -380,28 +377,39 @@ int virtio_pci_setup(VDev *vdev)
         return -EIO;
     }
 
-    if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
-        puts("Failed to read virt-queue configuration");
-        return -EIO;
-    }
-
     /* Configure virt-queues for pci */
     for (i = 0; i < vdev->nr_vqs; i++) {
+        uint16_t vq_size;
+        uint16_t vq_notify;
         VqInfo info = {
             .queue = (unsigned long long) virtio_get_ring_area(i),
             .align = KVM_S390_VIRTIO_RING_ALIGN,
             .index = i,
-            .num = vq_size,
+            .num = 0,
         };
 
         vr = &vdev->vrings[i];
-        vring_init(vr, &info);
 
-        if (vpci_set_selected_vq(vr->id)) {
+        if (vpci_set_selected_vq(i)) {
             puts("Failed to set selected virt-queue");
             return -EIO;
         }
 
+        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
+            printf("Failed to read virt-queue %d size\n", i);
+            return -EIO;
+        }
+
+        info.num = vq_size;
+
+        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar, &vq_notify)) {
+            printf("Failed to read virt-queue %d notify offset\n", i);
+            return -EIO;
+        }
+
+        vr->pci_notify = vq_notify;
+        vring_init(vr, &info);
+
         rc = set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
         rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
         rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 90d07cb9a76..2494df16198 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -64,7 +64,7 @@ typedef struct VirtioPciCap  VirtioPciCap;
 
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
-long virtio_pci_notify(int vq_id);
+long virtio_pci_notify(VRing *vr);
 int virtio_pci_setup(VDev *vdev);
 int virtio_pci_setup_device(void);
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 7883871033c..df04479aa69 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -114,7 +114,7 @@ bool vring_notify(VRing *vr)
         vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
         break;
     case S390_IPL_TYPE_PCI:
-        vr->cookie = virtio_pci_notify(vr->id);
+        vr->cookie = virtio_pci_notify(vr);
         break;
     default:
         return 1;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index d32a4830cad..75ae5bdbc22 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -107,6 +107,7 @@ struct VRing {
     VRingUsed *used;
     long cookie;
     int id;
+    uint16_t pci_notify;
 };
 typedef struct VRing VRing;
 
-- 
2.47.3


