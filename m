Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CECD34097
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkI-00042J-3I; Tue, 27 Jan 2026 11:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljr-0003gG-7j; Tue, 27 Jan 2026 11:16:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljn-0000od-1V; Tue, 27 Jan 2026 11:16:21 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6bGPS013292;
 Tue, 27 Jan 2026 16:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=m8N+1y0oU5reYuxz7
 I88hSdp6y9JqhT6u+oYf9uww4A=; b=IcU/hM89PTajhRmB3TfHtoW0fGPcrCwz0
 sb5S2H3XeoqiJGRdASvGek51knpDtyQEIB664Sm5YggM4ax7qY0ahn1d2UGjIUVC
 YIndXs13OzgazclgrkTRVe/JBkd82IwshUKywQ2VFuygo/vkutCThNx39+u9mi1E
 ql+AEuEKfymHCtlfs3oblzeSgm0trIIpYpfYlbSvWMmF2ai10WEDxpo0wRRoPvB5
 UxYFfqS8ZTPXDw+ONHlmjYmyv3DsNOLxiaFmXI6jfjpBdOyGk5Y9anxos89ylOi7
 3v1JgQcymn663DPNuMIYfXp9ihAteUf2YvSqWYgD1Xg2MCE4v+1Ew==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmv5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDEoat031044;
 Tue, 27 Jan 2026 16:16:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dshdt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGGE2r61735398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:16:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 165705805F;
 Tue, 27 Jan 2026 16:16:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E19CE58054;
 Tue, 27 Jan 2026 16:16:12 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:16:12 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 11/14] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
Date: Tue, 27 Jan 2026 11:15:44 -0500
Message-ID: <20260127161547.459443-12-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978e4d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=UgVhRPNOxoSHJgZPERoA:9
X-Proofpoint-GUID: Bb32KGP7JdWzcookGW9wZXk7Xtn8n2eF
X-Proofpoint-ORIG-GUID: Bb32KGP7JdWzcookGW9wZXk7Xtn8n2eF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX9uUbx5xwlRzb
 RcxCksqfv2BdLSL9jgf0VW5bpyRXhcbnTOKNgHoBx+GS0Ysztz5gOc7cyIfz98fuPieMzAYbLzw
 eC7l1QeMXUxZ9Y1q/xfG0mh4VDJ+h3fMvCnuuM2CS7rwHPKAJQ3nj02iaIY/qxpIiItpBU53FaF
 zQ8SOaFgOdM+Bmi3Y43oyUkSoTMvqdOqvDwzazzSKZphAMD5wqmT1Ecl1p4yUtUvvkkCCuaexts
 F9HIsbCXLtSCUkMq2w9WqV91HBlEwXLel1gG2AJlZ2LkEoik0IpvEbPDdQK178i4fcHTAbx6/4f
 wvkqLNrz3k1isxBb1OjbKdiMdNsL23iWbgCLn1hD/onJroZ2yrbobo4XCa7CnQX7E2lymEG+dzg
 oVHgmb7sPyIxf1RZRHPpFiHYaTHd5DNW18QlLsSr7tEzQkycVOBJmJ/z7qa37Gt9Dc4ZMwELrOc
 zbLKVUOhDxcAcy1i1PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 pc-bios/s390-ccw/main.c          |  60 +++++++-
 pc-bios/s390-ccw/virtio-blkdev.c |  18 +++
 pc-bios/s390-ccw/virtio-pci.c    | 256 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h    |   2 +
 pc-bios/s390-ccw/virtio.c        |  46 +++++-
 pc-bios/s390-ccw/virtio.h        |   1 +
 6 files changed, 379 insertions(+), 4 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 2ffce743bd..7d4a5b39d3 100644
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
@@ -288,7 +308,43 @@ static void ipl_boot_device(void)
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
+            zipl_load();
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
index e14bcf0382..c517a9eef3 100644
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
@@ -242,6 +258,8 @@ int virtio_blk_setup_device(void)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_setup(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_setup(vdev);
     default:
         return 1;
     }
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 70abac0256..464cfd510b 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -166,3 +166,259 @@ int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len)
 
     return 0;
 }
+
+static int vpci_set_selected_vq(uint16_t queue_num)
+{
+    return vpci_bswap16_write(c_cap.off + VPCI_C_OFFSET_Q_SELECT, c_cap.bar, queue_num);
+}
+
+static int vpci_set_queue_size(uint16_t queue_size)
+{
+    return vpci_bswap16_write(c_cap.off + VPCI_C_OFFSET_Q_SIZE, c_cap.bar, queue_size);
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
+int virtio_pci_setup(VDev *vdev)
+{
+    VRing *vr;
+    int rc;
+    uint8_t status;
+    int i = 0;
+
+    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
+    vdev->cmd_vr_idx = 0;
+
+    if (virtio_reset(vdev)) {
+        return -EIO;
+    }
+
+    status = VPCI_S_ACKNOWLEDGE;
+    if (virtio_pci_set_status(status)) {
+        puts("Virtio-pci device Failed to ACKNOWLEDGE");
+        return -EIO;
+    }
+
+    rc = virtio_pci_read_pci_cap_config();
+    if (rc) {
+        puts("Invalid virtio PCI capabilities");
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
+        vdev->config.blk.blk_size = 0;
+        virtio_pci_get_blk_config();
+        break;
+    default:
+        puts("Unsupported virtio device");
+        return -ENODEV;
+    }
+
+    status |= VPCI_S_DRIVER;
+    rc = virtio_pci_set_status(status);
+    if (rc) {
+        puts("Set status failed");
+        return -EIO;
+    }
+
+    /* Configure virt-queues for pci */
+    for (i = 0; i < vdev->nr_vqs; i++) {
+        VqInfo info = {
+            .queue = (unsigned long long) virtio_get_ring_area(i),
+            .align = KVM_S390_VIRTIO_RING_ALIGN,
+            .index = i,
+            .num = 0,
+        };
+
+        vr = &vdev->vrings[i];
+
+        if (vpci_read_flex(VPCI_C_COMMON_NUMQ, c_cap.bar, &info.num, 2)) {
+            return -EIO;
+        }
+
+        vring_init(vr, &info);
+
+        if (vpci_set_selected_vq(vr->id)) {
+            puts("Failed to set selected virt-queue");
+            return -EIO;
+        }
+
+        if (vpci_set_queue_size(VIRTIO_RING_SIZE)) {
+            puts("Failed to set virt-queue size");
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
+    status |= VPCI_S_FEATURES_OK | VPCI_S_DRIVER_OK;
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
index 96c17ac3c7..883b00e0c6 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -71,6 +71,8 @@ typedef struct VirtioPciCap  VirtioPciCap;
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
 long virtio_pci_notify(int vq_id);
+int virtio_pci_setup(VDev *vdev);
+int virtio_pci_setup_device(void);
 
 int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
 int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 956b34ff33..f65571a920 100644
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
@@ -112,6 +113,8 @@ bool vring_notify(VRing *vr)
     case S390_IPL_TYPE_CCW:
         vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
         break;
+    case S390_IPL_TYPE_PCI:
+        vr->cookie = virtio_pci_notify(vr->id);
     default:
         return 1;
     }
@@ -119,8 +122,43 @@ bool vring_notify(VRing *vr)
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
+static uint16_t vr_fmt_descriptor(VRingDesc *desc)
+{
+    if (!be_ipl()) {
+        desc->addr = bswap64(desc->addr);
+        desc->len = bswap32(desc->len);
+        desc->flags = bswap16(desc->flags);
+        desc->next = bswap16(desc->next);
+    }
+
+    return be_ipl() ? 1 : bswap16(1);
+}
+
 void vring_send_buf(VRing *vr, void *p, int len, int flags)
 {
+    uint16_t increment;
+
     /* For follow-up chains we need to keep the first entry point */
     if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
         vr->avail->ring[vr->avail->idx % vr->num] = vr->next_idx;
@@ -131,11 +169,13 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
     vr->desc[vr->next_idx].flags = flags & ~VRING_HIDDEN_IS_CHAIN;
     vr->desc[vr->next_idx].next = vr->next_idx;
     vr->desc[vr->next_idx].next++;
+
+    increment = vr_fmt_descriptor(&vr->desc[vr->next_idx]);
     vr->next_idx++;
 
     /* Chains only have a single ID */
     if (!(flags & VRING_DESC_F_NEXT)) {
-        vr->avail->idx++;
+        vr->avail->idx += increment;
     }
 }
 
@@ -147,7 +187,7 @@ int vr_poll(VRing *vr)
         return 0;
     }
 
-    vr->used_idx = vr->used->idx;
+    vr->used_idx = vr->used->idx; /* Endianness is preserved */
     vr->next_idx = 0;
     vr->desc[0].len = 0;
     vr->desc[0].flags = 0;
@@ -187,6 +227,8 @@ int virtio_reset(VDev *vdev)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_reset(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_reset(vdev);
     default:
         return -1;
     }
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 0c34d59be2..4705c8f456 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -271,6 +271,7 @@ struct VirtioCmd {
 };
 typedef struct VirtioCmd VirtioCmd;
 
+bool be_ipl(void);
 void vring_init(VRing *vr, VqInfo *info);
 bool virtio_is_supported(VDev *vdev);
 bool vring_notify(VRing *vr);
-- 
2.52.0


