Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98951C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvur3-00025R-T8; Mon, 17 Aug 2026 06:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqk-0001oD-Kk; Mon, 17 Aug 2026 06:45:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqi-000416-UQ; Mon, 17 Aug 2026 06:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=+4hn4aatShBTFP6o/8vjIBfyTfTNgd8tzEKoiCGIsgE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SjhgC/rPdRqTsE3DmlgvdA/JuZ5mjZaIzxcb2gputB/JpwEhHkCA3MMcnCiUZtlTK
 tXxyyrUO6AOJutO/Yxst+ZFNziVCPouBFjjg5IUKazMBC5RG8sE0o8cWmi4rgaWJNI
 PBXdKBAdQx5KXb49bFPy08R1muPise28JWlVu/pFRpZJ1rQkYXqsfATrEIkqSJLQNZ
 N8aKE2q4LHUpVmpNFslNtnBdRF6gJke8sGAUPcd3l8kjIp0rxQxHi26w7maNltcA/t
 zwAQncPjqFRVs2Vc310mUb1XX5OEvVTcbMKNA9vFP9O3eZBoa3qW+5LsMp8cgPvLGD
 yMazThPL9QOaQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8902C1CBB73;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A4A840D204;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1774830E5E; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 134/161] pc-bios/s390-ccw: Verify virtio support
 when booting from virtio PCI device on s390x
Date: Mon, 17 Aug 2026 13:42:48 +0300
Message-ID: <20260817104344.2047346-14-mjt@tls.msk.ru>
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

From: Jared Rossi <jrossi@linux.ibm.com>

The virtio specification requires that each PCI device has a vendor ID of
0x1af4.  Verify this value before continuing with boot process.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260630141917.673995-5-jrossi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit e26dafb207bc6218582fe18a1386026adb4620d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 26287cfd811..fb47d29bb1f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -163,6 +163,7 @@ static bool find_fid(uint32_t fid)
     }
 
     vdev->pci_fh = entry.fh;
+    vdev->vendor_id = entry.vendor_id;
     virtio_pci_id2type(vdev, entry.device_id);
 
     return vdev->dev_type != 0;
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 2c83ec4f131..f501252c819 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -325,6 +325,20 @@ static int enable_pci_bus_master(void)
     return 0;
 }
 
+bool virtio_pci_is_supported(VDev *vdev)
+{
+    if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
+        switch (vdev->dev_type) {
+        case VIRTIO_ID_BLOCK:
+            return true;
+        default:
+            return false;
+        }
+    }
+
+    return false;
+}
+
 int virtio_pci_setup(VDev *vdev)
 {
     VRing *vr;
@@ -335,6 +349,11 @@ int virtio_pci_setup(VDev *vdev)
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
     vdev->cmd_vr_idx = 0;
 
+    if (!virtio_pci_is_supported(vdev)) {
+        puts("Virtio PCI unsupported for this device ID");
+        return -ENODEV;
+    }
+
     if (virtio_pci_read_pci_cap_config()) {
         puts("Invalid virtio PCI capabilities");
         return -EIO;
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 2494df16198..33b683bd922 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -56,6 +56,8 @@
 
 #define VIRTIO_F_VERSION_1          1   /* Feature bit 32 */
 
+#define PCI_VENDOR_VIRTIO           0x1af4
+
 struct VirtioPciCap {
     uint8_t bar;     /* Which PCIAS it's in */
     uint32_t off;    /* Offset within bar */
@@ -65,6 +67,7 @@ typedef struct VirtioPciCap  VirtioPciCap;
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
 long virtio_pci_notify(VRing *vr);
+bool virtio_pci_is_supported(VDev *vdev);
 int virtio_pci_setup(VDev *vdev);
 int virtio_pci_setup_device(void);
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index df04479aa69..a0d249db240 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -247,6 +247,8 @@ bool virtio_is_supported(VDev *vdev)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_is_supported(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_is_supported(vdev);
     default:
         return false;
     }
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 75ae5bdbc22..aa307025e0f 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -259,6 +259,7 @@ struct VDev {
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
     uint32_t pci_fh;
+    uint16_t vendor_id;
     uint32_t max_transfer;
     uint32_t guest_features[2];
 };
-- 
2.47.3


