Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371F4EDEC02
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcTt-0003Th-4U; Tue, 03 Mar 2026 22:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSm-0002S7-3u; Tue, 03 Mar 2026 21:59:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSj-0000YN-P9; Tue, 03 Mar 2026 21:59:51 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623J7NH82198741; Wed, 4 Mar 2026 02:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vtKLwohNigpA/wf0J
 dtDnYWekMOC0ifaU6lgKFdxHPI=; b=qS6F1vOZmc/pJdVItVZVR4/NAotKdKXxG
 CdMS4cXUj2ZnerU3PTgrUkiKSxqrceJHQrmbX0yJMkLYY3PWV0CgpuBdbR8dBt/A
 pSCCQedPBXUHK+E2D5IkO5oEv9pHpvJ4Ilo7Y8TIFH51wu5st7EGILsGP/cmHUFO
 MTuF8pO7iD1krzwC23l1LRrPSfwcINwnh8uHEkdG/QlF88/1Hm9e/eT6mxQOwlok
 x006Vmaj185HICJtQ4ZYZ2y73tcp1Ts9jw+qhCM6Sc4NhwgddWEnkQBeFIdh/ocs
 fiv5Kdy0QXcTVjvcH4ficZcUF7Mxes3FPoHeNSNViu+qTt/Kab5dw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjddq7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623N5jTd016397;
 Wed, 4 Mar 2026 02:59:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpn50hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xjAH4981258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A364E58053;
 Wed,  4 Mar 2026 02:59:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78E9A58043;
 Wed,  4 Mar 2026 02:59:44 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:44 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 12/15] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
Date: Tue,  3 Mar 2026 21:59:14 -0500
Message-ID: <20260304025917.2157032-13-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a7a024 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=t5V1psBHqKC9bszW1LEA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: krkqKE5BMQ6Q38JnYRodUFk3lu1LRprM
X-Proofpoint-GUID: krkqKE5BMQ6Q38JnYRodUFk3lu1LRprM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX/iSCt2QcAR8z
 eO+JxxagVM9EN8BNCZ1cE229AOsH9gWBE6LX0Rj2Hv3czBqfEWV+obcZ8ErfBdJ52KlJeqwupGL
 IP6GsPoPEBf2xzhiHKMSFd/pNMJVIJ6xdcgEyHzpUOo6jRnWxMVnwU0OREdazQ1Asa4N18JPe08
 MT51ifCKt2ViY29dZLlcY//UdkysVpeq7OdDJxRr3zNfvektAyQtQb8B869jqEFjQZBbi/e30/Z
 o1xMy6M2eRmc+Q7AWAMRCxYQThVaQAkPmX7RvsQtUDtBhCWzSe01ofJDfxtV2dU1fa59cktWVMo
 +cXr6ypEZyRzg1ENMK0bRVG2Aj3r5inYc6UNHRSKOv6f2Er8yF2nv1XOYkeulGZafBZYXjQr3s2
 ADABRhESVnu2qGc5L4dCNa/6J5sm7ueyNhCj+A3JOHLjB/22ja57mWSbmflo3b04DQH3PqrlRV1
 LEo12BlwMIULFgZ0HcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c          |  61 ++++++-
 pc-bios/s390-ccw/pci.h           |   3 +
 pc-bios/s390-ccw/virtio-blkdev.c |  18 +++
 pc-bios/s390-ccw/virtio-pci.c    | 265 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h    |   2 +
 pc-bios/s390-ccw/virtio.c        |  54 ++++++-
 pc-bios/s390-ccw/virtio.h        |   1 +
 7 files changed, 399 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index c5ee575385..0e59ee3ea1 100644
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
 static void menu_setup(void)
 {
     if (memcmp(loadparm_str, LOADPARM_PROMPT, LOADPARM_LEN) == 0) {
@@ -239,6 +256,9 @@ static bool find_boot_device(void)
         blk_schid.ssid = iplb.scsi.ssid & 0x3;
         found = find_subch(iplb.scsi.devno);
         break;
+     case S390_IPL_TYPE_PCI:
+        found = find_fid(iplb.pci.fid);
+        break;
     default:
         puts("Unsupported IPLB");
     }
@@ -275,7 +295,7 @@ static int virtio_setup(void)
     return ret;
 }
 
-static void ipl_boot_device(void)
+static void ipl_ccw_device(void)
 {
     switch (cutype) {
     case CU_TYPE_DASD_3990:
@@ -289,7 +309,44 @@ static void ipl_boot_device(void)
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
 
diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
index 40a0bf9dcb..63825dd21c 100644
--- a/pc-bios/s390-ccw/pci.h
+++ b/pc-bios/s390-ccw/pci.h
@@ -29,8 +29,11 @@ union register_pair {
 #define PCIST_ENABLED          0x1
 
 #define PCI_CFGBAR             0xF  /* Base Address Register for config space */
+#define PCI_CMD_REG            0x4  /* Offset of command register */
 #define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list entry */
 
+#define PCI_BUS_MASTER_MASK    0x0020 /* LE bit 3 of 16 bit register */
+
 int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data,
               uint8_t len);
 int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf,
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 9722b6970f..98b6cec3a0 100644
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
index 2cfb84bf66..beb97961d0 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -165,3 +165,268 @@ int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len)
 
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
+static int enable_pci_bus_master(void) {
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
+        panic("Virtio feature negotation failed!");
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
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 54c524f698..90d07cb9a7 100644
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
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 956b34ff33..390b55c7b9 100644
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
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 0e7dbdb64c..18083b64cb 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -275,6 +275,7 @@ struct VirtioCmd {
 };
 typedef struct VirtioCmd VirtioCmd;
 
+bool be_ipl(void);
 void vring_init(VRing *vr, VqInfo *info);
 bool virtio_is_supported(VDev *vdev);
 bool vring_notify(VRing *vr);
-- 
2.52.0


