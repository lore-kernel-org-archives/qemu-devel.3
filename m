Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472E5FCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq5q-00013V-I2; Tue, 10 Mar 2026 01:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5Z-0000oa-Ml
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5U-0006LD-VL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVj3v0zwtz5DARnu08b2c2+bJ8jCNZ9REaW+V9xzxbo=;
 b=hgd7VcAcdYpFs2QWlXOuVNH3m8ny1Q0RK8rXuX3LaLhyXn086HPW4gCpR1SPoTRzk6/8mT
 DSYTK2NPvvKSLefWYR2auvFAd9ZzUyQXkJS7IBxi9sdi5yfyAQXyP/4NXwkr/oNv+dgVxG
 rOmPlyOW+x8+2zBbpb6Uzi3xYK/cdSg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-G-HNLQw1MROZ5yL6sH_m_w-1; Tue,
 10 Mar 2026 01:56:54 -0400
X-MC-Unique: G-HNLQw1MROZ5yL6sH_m_w-1
X-Mimecast-MFC-AGG-ID: G-HNLQw1MROZ5yL6sH_m_w_1773122213
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4278619541A7; Tue, 10 Mar 2026 05:56:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB49B1955D87; Tue, 10 Mar 2026 05:56:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 20/25] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
Date: Tue, 10 Mar 2026 06:55:25 +0100
Message-ID: <20260310055530.8893-21-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add little-endian virt-queue configuration and support for virtio-blk-pci IPL
devices.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-13-jrossi@linux.ibm.com>
[thuth: Fix coding style error & spelling warning reported by checkpatch.pl]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/pci.h           |   3 +
 pc-bios/s390-ccw/virtio-pci.h    |   2 +
 pc-bios/s390-ccw/virtio.h        |   1 +
 pc-bios/s390-ccw/main.c          |  61 ++++++-
 pc-bios/s390-ccw/virtio-blkdev.c |  18 +++
 pc-bios/s390-ccw/virtio-pci.c    | 266 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio.c        |  54 ++++++-
 7 files changed, 400 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
index 968635eff11..b9eb86b2e67 100644
--- a/pc-bios/s390-ccw/pci.h
+++ b/pc-bios/s390-ccw/pci.h
@@ -26,8 +26,11 @@ union register_pair {
 };
 
 #define PCI_CFGBAR             0xF  /* Base Address Register for config space */
+#define PCI_CMD_REG            0x4  /* Offset of command register */
 #define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list entry */
 
+#define PCI_BUS_MASTER_MASK    0x0020 /* LE bit 3 of 16 bit register */
+
 int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data,
               uint8_t len);
 int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf,
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 54c524f6986..90d07cb9a76 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -65,6 +65,8 @@ typedef struct VirtioPciCap  VirtioPciCap;
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
 long virtio_pci_notify(int vq_id);
+int virtio_pci_setup(VDev *vdev);
+int virtio_pci_setup_device(void);
 
 int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
 int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 1ef64675f4a..d32a4830cad 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -273,6 +273,7 @@ struct VirtioCmd {
 };
 typedef struct VirtioCmd VirtioCmd;
 
+bool be_ipl(void);
 void vring_init(VRing *vr, VqInfo *info);
 bool virtio_is_supported(VDev *vdev);
 bool vring_notify(VRing *vr);
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 32154c5db8d..26287cfd811 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -18,6 +18,8 @@
 #include "virtio.h"
 #include "virtio-scsi.h"
 #include "dasd-ipl.h"
+#include "clp.h"
+#include "virtio-pci.h"
 
 static SubChannelId blk_schid = { .one = 1 };
 static char loadparm_str[LOADPARM_LEN + 1];
@@ -151,6 +153,21 @@ static bool find_subch(int dev_no)
     return false;
 }
 
+static bool find_fid(uint32_t fid)
+{
+    ClpFhListEntry entry;
+    VDev *vdev = virtio_get_device();
+
+    if (find_pci_function(fid, &entry)) {
+        return false;
+    }
+
+    vdev->pci_fh = entry.fh;
+    virtio_pci_id2type(vdev, entry.device_id);
+
+    return vdev->dev_type != 0;
+}
+
 static void menu_setup(VDev *vdev)
 {
     if (memcmp(loadparm_str, LOADPARM_PROMPT, LOADPARM_LEN) == 0) {
@@ -240,6 +257,9 @@ static bool find_boot_device(void)
         blk_schid.ssid = iplb.scsi.ssid & 0x3;
         found = find_subch(iplb.scsi.devno);
         break;
+     case S390_IPL_TYPE_PCI:
+        found = find_fid(iplb.pci.fid);
+        break;
     default:
         puts("Unsupported IPLB");
     }
@@ -276,7 +296,7 @@ static int virtio_setup(void)
     return ret;
 }
 
-static void ipl_boot_device(void)
+static void ipl_ccw_device(void)
 {
     switch (cutype) {
     case CU_TYPE_DASD_3990:
@@ -290,7 +310,44 @@ static void ipl_boot_device(void)
         }
         break;
     default:
-        printf("Attempting to boot from unexpected device type 0x%X\n", cutype);
+        printf("Cannot boot CCW device with cu type 0x%X\n", cutype);
+    }
+}
+
+static void ipl_pci_device(void)
+{
+    VDev *vdev = virtio_get_device();
+    vdev->is_cdrom = false;
+    vdev->scsi_device_selected = false;
+
+    if (virtio_pci_setup_device()) {
+        return;
+    }
+
+    switch (vdev->dev_type) {
+    case VIRTIO_ID_BLOCK:
+        if (virtio_setup() == 0) {
+            zipl_load(); /* only return on error */
+            virtio_reset(virtio_get_device());
+        }
+        break;
+    default:
+        printf("Cannot boot PCI device type 0x%X\n", vdev->dev_type);
+    }
+}
+
+static void ipl_boot_device(void)
+{
+    switch (virtio_get_device()->ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        ipl_ccw_device();
+        break;
+    case S390_IPL_TYPE_PCI:
+        ipl_pci_device();
+        break;
+    default:
+        puts("Unrecognized IPL type!");
     }
 }
 
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 9722b6970f1..98b6cec3a09 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -13,10 +13,22 @@
 #include "virtio.h"
 #include "virtio-scsi.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
+#include "bswap.h"
 
 #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
 #define VIRTIO_BLK_F_BLK_SIZE   (1 << 6)
 
+/*
+ * Format header for little endian IPL
+ */
+static void fmt_blk_hdr_le(VirtioBlkOuthdr *hdr)
+{
+    hdr->type = bswap32(hdr->type);
+    hdr->ioprio = bswap32(hdr->ioprio);
+    hdr->sector = bswap64(hdr->sector);
+}
+
 static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *load_addr,
                                 int sec_num)
 {
@@ -29,6 +41,10 @@ static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *load_add
     out_hdr.ioprio = 99;
     out_hdr.sector = virtio_sector_adjust(sector);
 
+    if (!be_ipl()) {
+        fmt_blk_hdr_le(&out_hdr);
+    }
+
     vring_send_buf(vr, &out_hdr, sizeof(out_hdr), VRING_DESC_F_NEXT);
 
     /* This is where we want to receive data */
@@ -240,6 +256,8 @@ int virtio_blk_setup_device(VDev *vdev)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_setup(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_setup(vdev);
     default:
         return 1;
     }
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index f6ce7ec7661..53bdb52e76a 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -165,3 +165,269 @@ int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len)
 
     return 0;
 }
+
+static int vpci_set_selected_vq(uint16_t queue_num)
+{
+    return vpci_bswap16_write(c_cap.off + VPCI_C_OFFSET_Q_SELECT, c_cap.bar, queue_num);
+}
+
+static int vpci_set_queue_enable(uint16_t enabled)
+{
+    return vpci_bswap16_write(c_cap.off + VPCI_C_OFFSET_Q_ENABLE, c_cap.bar, enabled);
+}
+
+static int set_pci_vq_addr(uint64_t config_off, void *addr)
+{
+    return vpci_bswap64_write(c_cap.off + config_off, c_cap.bar, (uint64_t) addr);
+}
+
+static int virtio_pci_get_blk_config(void)
+{
+    VirtioBlkConfig *cfg = &virtio_get_device()->config.blk;
+    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioBlkConfig));
+
+    /* single byte fields are not touched */
+    cfg->capacity = bswap64(cfg->capacity);
+    cfg->size_max = bswap32(cfg->size_max);
+    cfg->seg_max = bswap32(cfg->seg_max);
+
+    cfg->geometry.cylinders = bswap16(cfg->geometry.cylinders);
+
+    cfg->blk_size = bswap32(cfg->blk_size);
+    cfg->min_io_size = bswap16(cfg->min_io_size);
+    cfg->opt_io_size = bswap32(cfg->opt_io_size);
+
+    return rc;
+}
+
+static int virtio_pci_negotiate(void)
+{
+    int i, rc;
+    VDev *vdev = virtio_get_device();
+    struct VirtioFeatureDesc {
+        uint32_t features;
+        uint8_t index;
+    } __attribute__((packed)) feats;
+
+    for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
+        feats.features = 0;
+        feats.index = i;
+
+        rc = vpci_bswap32_write(c_cap.off + VPCI_C_OFFSET_DFSELECT, c_cap.bar,
+                                feats.index);
+        rc |= vpci_read_flex(c_cap.off + VPCI_C_OFFSET_DF, c_cap.bar, &feats, 4);
+
+        vdev->guest_features[i] &= bswap32(feats.features);
+        feats.features = vdev->guest_features[i];
+
+
+        rc |= vpci_bswap32_write(c_cap.off + VPCI_C_OFFSET_GFSELECT, c_cap.bar,
+                                 feats.index);
+        rc |= vpci_bswap32_write(c_cap.off + VPCI_C_OFFSET_GF, c_cap.bar,
+                                 feats.features);
+    }
+
+    return rc;
+}
+
+/*
+ * Find the position of the capability config within PCI configuration
+ * space for a given cfg type.  Return the position if found, otherwise 0.
+ */
+static uint8_t virtio_pci_find_cap_pos(uint8_t cfg_type)
+{
+    uint8_t next, cfg;
+    int rc;
+
+    rc = vpci_read_byte(PCI_CAPABILITY_LIST, PCI_CFGBAR, &next);
+    rc |= vpci_read_byte(next + 3, PCI_CFGBAR, &cfg);
+
+    while (!rc && (cfg != cfg_type) && next) {
+        rc = vpci_read_byte(next + 1, PCI_CFGBAR, &next);
+        rc |= vpci_read_byte(next + 3, PCI_CFGBAR, &cfg);
+    }
+
+    return rc ? 0 : next;
+}
+
+/*
+ * Read PCI configuration space to find the offset of the Common, Device, and
+ * Notification memory regions within the modern memory space.
+ * Returns 0 if success, 1 if a capability could not be located, or a
+ * negative RC if the configuration read failed.
+ */
+static int virtio_pci_read_pci_cap_config(void)
+{
+    uint8_t pos;
+    int rc;
+
+    /* Common capabilities */
+    pos = virtio_pci_find_cap_pos(VPCI_CAP_COMMON_CFG);
+    if (!pos) {
+        puts("Failed to locate PCI common configuration");
+        return 1;
+    }
+
+    rc = vpci_read_byte(pos + VPCI_CAP_BAR, PCI_CFGBAR, &c_cap.bar);
+    if (rc || vpci_read_bswap32(pos + VPCI_CAP_OFFSET, PCI_CFGBAR, &c_cap.off)) {
+        puts("Failed to read PCI common configuration");
+        return -EIO;
+    }
+
+    /* Device capabilities */
+    pos = virtio_pci_find_cap_pos(VPCI_CAP_DEVICE_CFG);
+    if (!pos) {
+        puts("Failed to locate PCI device configuration");
+        return 1;
+    }
+
+    rc = vpci_read_byte(pos + VPCI_CAP_BAR, PCI_CFGBAR, &d_cap.bar);
+    if (rc || vpci_read_bswap32(pos + VPCI_CAP_OFFSET, PCI_CFGBAR, &d_cap.off)) {
+        puts("Failed to read PCI device configuration");
+        return -EIO;
+    }
+
+    /* Notification capabilities */
+    pos = virtio_pci_find_cap_pos(VPCI_CAP_NOTIFY_CFG);
+    if (!pos) {
+        puts("Failed to locate PCI notification configuration");
+        return 1;
+    }
+
+    rc = vpci_read_byte(pos + VPCI_CAP_BAR, PCI_CFGBAR, &n_cap.bar);
+    if (rc || vpci_read_bswap32(pos + VPCI_CAP_OFFSET, PCI_CFGBAR, &n_cap.off)) {
+        puts("Failed to read PCI notification configuration");
+        return -EIO;
+    }
+
+    rc = vpci_read_bswap32(pos + VPCI_N_CAP_MULT, PCI_CFGBAR, &notify_mult);
+    if (rc || vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar,
+                                &q_notify_offset)) {
+        puts("Failed to read notification queue configuration");
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static int enable_pci_bus_master(void)
+{
+    uint16_t cmd_reg;
+
+    if (vpci_read_bswap16(PCI_CMD_REG, PCI_CFGBAR, &cmd_reg)) {
+        puts("Failed to read PCI command register");
+        return -EIO;
+    }
+
+    if (vpci_bswap16_write(PCI_CMD_REG, PCI_CFGBAR, cmd_reg | PCI_BUS_MASTER_MASK)) {
+        puts("Failed to enable PCI bus mastering");
+        return -EIO;
+    }
+
+    return 0;
+}
+
+int virtio_pci_setup(VDev *vdev)
+{
+    VRing *vr;
+    int rc;
+    uint8_t status;
+    uint16_t vq_size;
+    int i = 0;
+
+    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
+    vdev->cmd_vr_idx = 0;
+
+    if (virtio_pci_read_pci_cap_config()) {
+        puts("Invalid virtio PCI capabilities");
+        return -EIO;
+    }
+
+    if (enable_pci_bus_master()) {
+        return -EIO;
+    }
+
+    if (virtio_reset(vdev)) {
+        return -EIO;
+    }
+
+    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
+    if (virtio_pci_set_status(status)) {
+        puts("Virtio-pci device Failed to ACKNOWLEDGE");
+        return -EIO;
+    }
+
+    vdev->guest_features[1] = VIRTIO_F_VERSION_1;
+    if (virtio_pci_negotiate()) {
+        panic("Virtio feature negotiation failed!");
+    }
+
+    switch (vdev->dev_type) {
+    case VIRTIO_ID_BLOCK:
+        vdev->nr_vqs = 1;
+        vdev->cmd_vr_idx = 0;
+        virtio_pci_get_blk_config();
+        break;
+    default:
+        puts("Unsupported virtio device");
+        return -ENODEV;
+    }
+
+    status |= VIRTIO_CONFIG_S_DRIVER;
+    rc = virtio_pci_set_status(status);
+    if (rc) {
+        puts("Set status failed");
+        return -EIO;
+    }
+
+    if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
+        puts("Failed to read virt-queue configuration");
+        return -EIO;
+    }
+
+    /* Configure virt-queues for pci */
+    for (i = 0; i < vdev->nr_vqs; i++) {
+        VqInfo info = {
+            .queue = (unsigned long long) virtio_get_ring_area(i),
+            .align = KVM_S390_VIRTIO_RING_ALIGN,
+            .index = i,
+            .num = vq_size,
+        };
+
+        vr = &vdev->vrings[i];
+        vring_init(vr, &info);
+
+        if (vpci_set_selected_vq(vr->id)) {
+            puts("Failed to set selected virt-queue");
+            return -EIO;
+        }
+
+        rc = set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
+        rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
+        rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
+        if (rc) {
+            puts("Failed to configure virt-queue address");
+            return -EIO;
+        }
+
+        if (vpci_set_queue_enable(true)) {
+            puts("Failed to set virt-queue enabled");
+            return -EIO;
+        }
+    }
+
+    status |= VIRTIO_CONFIG_S_FEATURES_OK | VIRTIO_CONFIG_S_DRIVER_OK;
+    return virtio_pci_set_status(status);
+}
+
+int virtio_pci_setup_device(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    if (enable_pci_function(&vdev->pci_fh)) {
+        puts("Failed to enable PCI function");
+        return -ENODEV;
+    }
+
+    return 0;
+}
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 956b34ff33a..390b55c7b92 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -17,6 +17,7 @@
 #include "virtio.h"
 #include "virtio-scsi.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "bswap.h"
 #include "helper.h"
 #include "s390-time.h"
@@ -96,7 +97,7 @@ void vring_init(VRing *vr, VqInfo *info)
     vr->avail->idx = 0;
 
     /* We're running with interrupts off anyways, so don't bother */
-    vr->used->flags = VRING_USED_F_NO_NOTIFY;
+    vr->used->flags = be_ipl() ? VRING_USED_F_NO_NOTIFY : bswap16(VRING_USED_F_NO_NOTIFY);
     vr->used->idx = 0;
     vr->used_idx = 0;
     vr->next_idx = 0;
@@ -112,6 +113,8 @@ bool vring_notify(VRing *vr)
     case S390_IPL_TYPE_CCW:
         vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
         break;
+    case S390_IPL_TYPE_PCI:
+        vr->cookie = virtio_pci_notify(vr->id);
     default:
         return 1;
     }
@@ -119,11 +122,45 @@ bool vring_notify(VRing *vr)
     return vr->cookie >= 0;
 }
 
+/*
+ * Get endienness of the IPL type
+ * Return true for s390x native big-endian
+ */
+bool be_ipl(void)
+{
+    switch (virtio_get_device()->ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return true;
+    case S390_IPL_TYPE_PCI:
+        return false;
+    default:
+        return true;
+    }
+}
+
+/*
+ * Format the virtio ring descriptor endianness
+ * Return the available index increment in the appropriate endianness
+ */
+static void vr_bswap_descriptor(VRingDesc *desc)
+{
+    desc->addr = bswap64(desc->addr);
+    desc->len = bswap32(desc->len);
+    desc->flags = bswap16(desc->flags);
+    desc->next = bswap16(desc->next);
+}
+
 void vring_send_buf(VRing *vr, void *p, int len, int flags)
 {
+    if (!be_ipl()) {
+        vr->avail->idx = bswap16(vr->avail->idx);
+    }
+
     /* For follow-up chains we need to keep the first entry point */
     if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
-        vr->avail->ring[vr->avail->idx % vr->num] = vr->next_idx;
+        vr->avail->ring[vr->avail->idx % vr->num] = be_ipl() ? vr->next_idx :
+                                                               bswap16(vr->next_idx);
     }
 
     vr->desc[vr->next_idx].addr = (unsigned long)p;
@@ -131,12 +168,21 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
     vr->desc[vr->next_idx].flags = flags & ~VRING_HIDDEN_IS_CHAIN;
     vr->desc[vr->next_idx].next = vr->next_idx;
     vr->desc[vr->next_idx].next++;
+
+    if (!be_ipl()) {
+        vr_bswap_descriptor(&vr->desc[vr->next_idx]);
+    }
+
     vr->next_idx++;
 
     /* Chains only have a single ID */
     if (!(flags & VRING_DESC_F_NEXT)) {
         vr->avail->idx++;
     }
+
+    if (!be_ipl()) {
+        vr->avail->idx = bswap16(vr->avail->idx);
+    }
 }
 
 int vr_poll(VRing *vr)
@@ -147,7 +193,7 @@ int vr_poll(VRing *vr)
         return 0;
     }
 
-    vr->used_idx = vr->used->idx;
+    vr->used_idx = vr->used->idx; /* Endianness is preserved */
     vr->next_idx = 0;
     vr->desc[0].len = 0;
     vr->desc[0].flags = 0;
@@ -187,6 +233,8 @@ int virtio_reset(VDev *vdev)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_reset(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_reset(vdev);
     default:
         return -1;
     }
-- 
2.53.0


