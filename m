Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59791CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAscr-0003mD-DR; Mon, 20 Oct 2025 12:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAsck-0003jZ-GT; Mon, 20 Oct 2025 12:20:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAsch-0000t6-IH; Mon, 20 Oct 2025 12:20:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KC2fg3006614;
 Mon, 20 Oct 2025 16:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=s69IrhSy7IoKpJv12
 smthmV3ue0ebcyT7BZnXMXeGUY=; b=XfZYpVDODc8jbyIz8ECH1zaYFB2lLUK3r
 PNtLsDbs7apbK5jQBH/nSUdf73uos8h19cPxmL5AQ3kxSoOrlQbRT8WmVUILeodh
 lY07fGX6w7lfUZbb6tMnXFsFzrYquob6tMWBYhU//FM9YoV2+foCzmeLAZphQab9
 unjalpsle+IgSabbHdE4/FjQ4ho+S3TvHsHuhvLLrRwflNqG2VLZzkIAFjk/UIdm
 ZfBc4yFw7WfIQGI6MKd5DvGgKrqFyRQC1venFkpO7oIK5SophWHyIeusCChcEgor
 HdCinM8TuELK12PXkWWHi/3JrglmqndcD/FzC7+0m4D4KY8Q052Ug==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326jg1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KEgxOo032096;
 Mon, 20 Oct 2025 16:20:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mph79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KGKZ1I15467154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 16:20:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 354085805D;
 Mon, 20 Oct 2025 16:20:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 888B258052;
 Mon, 20 Oct 2025 16:20:34 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.78.141])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 16:20:34 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 5/7] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
Date: Mon, 20 Oct 2025 12:20:21 -0400
Message-ID: <20251020162023.3649165-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251020162023.3649165-1-jrossi@linux.ibm.com>
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f66155 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=IFyg070M5ZGC1bApo04A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwMssPJ2FGpJd
 aOnomox9OGd7vBQV6VlQcGRWTt1l/vki8dU3bh1VDGutJ9DlLjcdqZdgMJejgC8Z2obXBLdYRdO
 UfpVjiy6dJCoYfJZwTFFJUXE2MPMsDC3Ve+Jn69ZL5ejaxMy4Bblq+jeqqysMHdRW6zo89psnmk
 lFedoFojjc9S28qmqGoZQ41uQPP5Ey+8XHOhIs/o1XH9MPkgRGmi+iAWeDf8ckLUdIQQ+M8G6Aa
 DV4GFvFPVgMRryjCJbPPeC7SMDiF3DNBLxVniPHGk/XIWv7fsT7pt+IYIC2ujdRq2/0pYjOwLfd
 seefV4uZs3g7b1vmX6V2eIwO5KAQ7YJxaj/7AZxg8D1ea40A3Dsw0NiM/rKBcTNyFxA+LtrTK7p
 iLEBo3I0MKWB7gX3mBARz37nswIQ8A==
X-Proofpoint-GUID: ioaRqS4mle85IvG-8eUwUjXZfXtokjGq
X-Proofpoint-ORIG-GUID: ioaRqS4mle85IvG-8eUwUjXZfXtokjGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Enable virt-queue PCI configuration and add routines for virtio-blk-pci devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/clp.h           |   2 +-
 pc-bios/s390-ccw/virtio-pci.h    |  73 +++++++
 pc-bios/s390-ccw/virtio.h        |   1 +
 pc-bios/s390-ccw/main.c          |  59 ++++-
 pc-bios/s390-ccw/virtio-blkdev.c |   3 +
 pc-bios/s390-ccw/virtio-pci.c    | 357 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio.c        |   5 +
 pc-bios/s390-ccw/Makefile        |   2 +-
 8 files changed, 498 insertions(+), 4 deletions(-)
 create mode 100644 pc-bios/s390-ccw/virtio-pci.h
 create mode 100644 pc-bios/s390-ccw/virtio-pci.c

diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
index cb130e5e90..52232c4c48 100644
--- a/pc-bios/s390-ccw/clp.h
+++ b/pc-bios/s390-ccw/clp.h
@@ -19,6 +19,6 @@
 
 int clp_pci(void *data);
 int enable_pci_function(uint32_t *fhandle);
-int enumerate_pci_functions(void);
+int find_pci_function(uint32_t fid, ClpFhListEntry *entry);
 
 #endif
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
new file mode 100644
index 0000000000..09fff015cb
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -0,0 +1,73 @@
+/*
+ * Definitions for virtio-pci
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef VIRTIO_PCI_H
+#define VIRTIO_PCI_H
+
+/* Common configuration */
+#define VIRTIO_PCI_CAP_COMMON_CFG          1
+/* Notifications */
+#define VIRTIO_PCI_CAP_NOTIFY_CFG          2
+/* ISR access */
+#define VIRTIO_PCI_CAP_ISR_CFG             3
+/* Device specific configuration */
+#define VIRTIO_PCI_CAP_DEVICE_CFG          4
+/* PCI configuration access */
+#define VIRTIO_PCI_CAP_PCI_CFG             5
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG   8
+/* PCI vendor data configuration */
+#define VIRTIO_PCI_CAP_VENDOR_CFG          9
+
+/* Offsets within capability header */
+#define VIRTIO_PCI_CAP_VNDR        0
+#define VIRTIO_PCI_CAP_NEXT        1
+#define VIRTIO_PCI_CAP_LEN         2
+#define VIRTIO_PCI_CAP_CFG_TYPE    3
+#define VIRTIO_PCI_CAP_BAR         4
+#define VIRTIO_PCI_CAP_OFFSET      8
+#define VIRTIO_PCI_CAP_LENGTH      12
+
+#define VIRTIO_PCI_NOTIFY_CAP_MULT 16 /* VIRTIO_PCI_CAP_NOTIFY_CFG only */
+
+/* Common Area Offsets for virtio-pci queue */
+#define VPCI_C_OFFSET_DFSELECT      0
+#define VPCI_C_OFFSET_DF            4
+#define VPCI_C_OFFSET_GFSELECT      8
+#define VPCI_C_OFFSET_GF            12
+#define VPCI_C_COMMON_NUMQ          18
+#define VPCI_C_OFFSET_STATUS        20
+#define VPCI_C_OFFSET_Q_SELECT      22
+#define VPCI_C_OFFSET_Q_SIZE        24
+#define VPCI_C_OFFSET_Q_ENABLE      28
+#define VPCI_C_OFFSET_Q_NOFF        30
+#define VPCI_C_OFFSET_Q_DESCLO      32
+#define VPCI_C_OFFSET_Q_DESCHI      36
+#define VPCI_C_OFFSET_Q_AVAILLO     40
+#define VPCI_C_OFFSET_Q_AVAILHI     44
+#define VPCI_C_OFFSET_Q_USEDLO      48
+#define VPCI_C_OFFSET_Q_USEDHI      52
+
+#define VPCI_S_RESET            0
+#define VPCI_S_ACKNOWLEDGE      1
+#define VPCI_S_DRIVER           2
+#define VPCI_S_DRIVER_OK        4
+#define VPCI_S_FEATURES_OK      8
+
+#define VIRTIO_F_VERSION_1      (1 << (32 - 32)) /* Feature bit 32 */
+
+#define VIRT_Q_SIZE 16
+
+long virtio_pci_notify(uint32_t fhandle, int vq_id);
+int virtio_pci_setup(VDev *vdev);
+int virtio_pci_setup_device(void);
+int virtio_pci_reset(VDev *vdev);
+void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
+
+#endif
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 1c1017a0db..4e4a7280b6 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -259,6 +259,7 @@ struct VDev {
     uint8_t scsi_dev_heads;
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
+    uint32_t pci_fh;
     uint32_t max_transfer;
     uint32_t guest_features[2];
 };
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 7299b8911f..69e7d39862 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -15,8 +15,10 @@
 #include "s390-arch.h"
 #include "s390-ccw.h"
 #include "cio.h"
+#include "clp.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
+#include "virtio-pci.h"
 #include "dasd-ipl.h"
 
 SubChannelId blk_schid = { .one = 1 };
@@ -150,6 +152,20 @@ static bool find_subch(int dev_no)
     return false;
 }
 
+static bool find_fid(uint32_t fid) {
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
+    return (vdev->type != 0);
+}
+
 static void menu_setup(void)
 {
     if (memcmp(loadparm_str, LOADPARM_PROMPT, LOADPARM_LEN) == 0) {
@@ -233,6 +249,9 @@ static bool find_boot_device(void)
         blk_schid.ssid = iplb.scsi.ssid & 0x3;
         found = find_subch(iplb.scsi.devno);
         break;
+     case S390_IPL_TYPE_PCI:
+        found = find_fid(iplb.pci.fid);
+        break;
     default:
         puts("Unsupported IPLB");
     }
@@ -269,7 +288,7 @@ static int virtio_setup(void)
     return ret;
 }
 
-static void ipl_boot_device(void)
+static void ipl_ccw_device(void)
 {
     switch (cutype) {
     case CU_TYPE_DASD_3990:
@@ -282,7 +301,43 @@ static void ipl_boot_device(void)
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
+    switch (vdev->type) {
+    case VIRTIO_ID_BLOCK:
+        if (virtio_setup() == 0) {
+            zipl_load();
+        }
+        break;
+    default:
+        printf("Cannot boot PCI device type 0x%X\n", vdev->type);
+    }
+}
+
+static void ipl_boot_device(void)
+{
+    switch (ipl_type) {
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
index df6a6d5b70..c5b65d021b 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -13,6 +13,7 @@
 #include "virtio.h"
 #include "virtio-ccw.h"
 #include "virtio-scsi.h"
+#include "virtio-pci.h"
 
 #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
 #define VIRTIO_BLK_F_BLK_SIZE   (1 << 6)
@@ -243,6 +244,8 @@ int virtio_blk_setup_device()
     case S390_IPL_TYPE_CCW:
         vdev->schid = blk_schid;
         return virtio_ccw_setup(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_setup(vdev);
     }
 
     return 1;
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
new file mode 100644
index 0000000000..b6cb4a661a
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -0,0 +1,357 @@
+/*
+ * Functionality for virtio-pci
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "clp.h"
+#include "pci.h"
+#include "helper.h"
+#include "s390-ccw.h"
+#include "virtio.h"
+#include "bswap.h"
+#include "virtio-pci.h"
+#include "s390-time.h"
+#include <stdio.h>
+
+/* Variable offsets used for reads/writes to modern memory region BAR 4 */
+uint32_t common_offset;
+uint32_t device_offset;
+uint32_t notify_offset;
+uint32_t notify_mult;
+uint16_t q_notify_offset;
+
+static int virtio_pci_set_status(VDev *vdev, uint8_t status)
+{
+    uint64_t status64 = status;
+
+    return pci_write(vdev->pci_fh, VPCI_C_OFFSET_STATUS, status64, 1);
+}
+
+static int virtio_pci_get_status(VDev *vdev, uint8_t *status)
+{
+    uint64_t status64;
+    int rc;
+
+    rc = pci_read(vdev->pci_fh, VPCI_C_OFFSET_STATUS, 4, &status64, 1);
+    if (rc) {
+        puts("Failed to read virtio-pci status");
+        return rc;
+    }
+
+    *status = (uint8_t) status64;
+    return 0;
+}
+
+static int virtio_pci_get_hfeatures(VDev *vdev, uint64_t *features)
+{
+    uint64_t feat0, feat1;
+    uint32_t selector;
+    int rc;
+
+    selector = bswap32(0);
+    rc = pci_write(vdev->pci_fh, VPCI_C_OFFSET_DFSELECT, selector, 4);
+    rc |= pci_read(vdev->pci_fh, VPCI_C_OFFSET_DF, 4, &feat0, 4);
+    feat0 = bswap32(feat0);
+
+    selector = bswap32(1);
+    rc |= pci_write(vdev->pci_fh, VPCI_C_OFFSET_DFSELECT, selector, 4);
+    rc |= pci_read(vdev->pci_fh, VPCI_C_OFFSET_DF, 4, &feat1, 4);
+    feat1 = bswap32(feat1);
+
+    *features = feat1 << 32;
+    *features |= feat0;
+
+    return rc;
+}
+
+static int virtio_pci_set_gfeatures(VDev *vdev)
+{
+    uint64_t feats;
+    uint32_t selector;
+    int rc;
+
+    selector = bswap32(0);
+    rc = pci_write(vdev->pci_fh, VPCI_C_OFFSET_GFSELECT, selector, 4);
+
+    feats = bswap32((uint64_t)vdev->guest_features[1]);
+    rc |= pci_write(vdev->pci_fh, VPCI_C_OFFSET_GF, feats, 4);
+
+    selector = bswap32(1);
+    rc |= pci_write(vdev->pci_fh, VPCI_C_OFFSET_GFSELECT, selector, 4);
+
+    feats = bswap32((uint64_t)vdev->guest_features[0]);
+    rc |= pci_write(vdev->pci_fh, VPCI_C_OFFSET_GF, feats, 4);
+
+    return rc;
+}
+
+static int virtio_pci_get_blk_config(VDev *vdev)
+{
+    return pci_read(vdev->pci_fh, device_offset, 4, (uint64_t *)&vdev->config.blk,
+                    sizeof(VirtioBlkConfig));
+
+}
+
+int virtio_pci_set_selected_vq(VDev *vdev, uint16_t queue_num)
+{
+    uint16_t le_queue_num;
+
+    le_queue_num = bswap16(queue_num);
+    return pci_write(vdev->pci_fh, VPCI_C_OFFSET_Q_SELECT, (uint64_t)le_queue_num, 2);
+}
+
+int virtio_pci_set_queue_size(VDev *vdev, uint16_t queue_size)
+{
+    uint16_t le_queue_size;
+
+    le_queue_size = bswap16(queue_size);
+    return pci_write(vdev->pci_fh, VPCI_C_OFFSET_Q_SIZE, (uint64_t)le_queue_size, 2);
+}
+
+static int virtio_pci_set_queue_enable(VDev *vdev, uint16_t enabled)
+{
+    uint16_t le_enabled;
+
+    le_enabled = bswap16(enabled);
+    return pci_write(vdev->pci_fh, VPCI_C_OFFSET_Q_ENABLE, (uint64_t)le_enabled, 2);
+}
+
+static int set_pci_vq_addr(VDev *vdev, void* addr, uint64_t config_offset_lo)
+{
+    uint32_t le_lo, le_hi;
+    uint32_t tmp;
+    int rc;
+
+    tmp = (uint32_t)(((uint64_t)addr) >> 32);
+    le_hi = bswap32(tmp);
+
+    tmp = (uint32_t)((uint64_t)addr & 0xFFFFFFFF);
+    le_lo = bswap32(tmp);
+
+    rc =  pci_write(vdev->pci_fh, config_offset_lo, (uint64_t)le_lo, 4);
+    rc |=  pci_write(vdev->pci_fh, config_offset_lo + 4, (uint64_t)le_hi, 4);
+
+    return rc;
+}
+
+/* virtio spec v1.1 para 4.1.2.1 */
+void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
+{
+    switch(device_id) {
+    case 0x1001:
+        vdev->type = VIRTIO_ID_BLOCK;
+        break;
+    case 0x1000: /* Other valid but currently unsupported virtio device types */
+    case 0x1004:
+    default:
+        vdev->type = 0;
+    }
+}
+
+/*
+ * Read PCI configuration space to find the offset of the Common, Device, and
+ * Notification memory regions within the modern memory space.
+ * Returns 0 if success, 1 if a capability could not be located, or a
+ * negative RC if the configuration read failed.
+ */
+static int virtio_pci_read_pci_cap_config(VDev *vdev)
+{
+    uint8_t pos;
+    uint64_t data;
+
+    /* Common cabilities */
+    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_COMMON_CFG);
+    if (!pos) {
+        puts("Failed to locate PCI common configuration");
+        return 1;
+    }
+    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
+        return -EIO;
+    }
+    common_offset = bswap32(data);
+
+    /* Device cabilities */
+    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_DEVICE_CFG);
+    if (!pos) {
+        puts("Failed to locate PCI device configuration");
+        return 1;
+    }
+    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
+        return -EIO;
+    }
+    device_offset = bswap32(data);
+
+    /* Notification cabilities */
+    pos = find_cap_pos(vdev->pci_fh, VIRTIO_PCI_CAP_NOTIFY_CFG);
+    if (!pos) {
+        puts("Failed to locate PCI notification configuration");
+        return 1;
+    }
+    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_CAP_OFFSET, 15, &data, 4)) {
+        return -EIO;
+    }
+    notify_offset = bswap32(data);
+
+    if (pci_read(vdev->pci_fh, pos + VIRTIO_PCI_NOTIFY_CAP_MULT, 15, &data, 4)) {
+        return -EIO;
+    }
+    notify_mult = bswap32(data);
+
+    if (pci_read(vdev->pci_fh, device_offset + VPCI_C_OFFSET_Q_NOFF, 4, &data, 2)) {
+        return -EIO;
+    }
+    q_notify_offset = bswap16(data);
+
+    return 0;
+}
+
+int virtio_pci_reset(VDev *vdev)
+{
+    int rc;
+    uint8_t status = VPCI_S_RESET;
+
+    rc = virtio_pci_set_status(vdev, status);
+    rc |= virtio_pci_get_status(vdev, &status);
+
+    if (rc || status) {
+        puts("Failed to reset virtio-pci device");
+        return 1;
+    }
+
+    return 0;
+}
+
+int virtio_pci_setup(VDev *vdev)
+{
+    VRing *vr;
+    int rc;
+    uint64_t pci_features, data;
+    uint8_t status;
+    int i = 0;
+
+    vdev->config.blk.blk_size = 0;
+    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
+    vdev->cmd_vr_idx = 0;
+
+    if (virtio_reset(vdev)) {
+        return -EIO;
+    }
+
+    status = VPCI_S_ACKNOWLEDGE;
+    rc = virtio_pci_set_status(vdev, status);
+    if (rc) {
+        puts("Virtio-pci device Failed to ACKNOWLEDGE");
+        return -EIO;
+    }
+
+    virtio_pci_read_pci_cap_config(vdev);
+    if (rc) {
+        printf("Invalid PCI capabilities");
+        return -EIO;
+    }
+
+    switch (vdev->type) {
+    case VIRTIO_ID_BLOCK:
+        vdev->nr_vqs = 1;
+        vdev->cmd_vr_idx = 0;
+        virtio_pci_get_blk_config(vdev);
+        break;
+    default:
+        puts("Unsupported virtio device");
+        return -ENODEV;
+    }
+
+    status |= VPCI_S_DRIVER;
+    rc = virtio_pci_set_status(vdev, status);
+    if (rc) {
+        puts("Set status failed");
+        return -EIO;
+    }
+
+    /* Feature negotiation */
+    rc = virtio_pci_get_hfeatures(vdev, &pci_features);
+    if (rc) {
+        puts("Failed to get feature bits");
+        return -EIO;
+    }
+
+    rc = virtio_pci_set_gfeatures(vdev);
+    if (rc) {
+        puts("Failed to set feature bits");
+        return -EIO;
+    }
+
+    /* Configure virt-queues for pci */
+    for (i = 0; i < vdev->nr_vqs; i++) {
+        VqInfo info = {
+            .queue = (unsigned long long) virtio_get_ring_area() + (i * VIRTIO_RING_SIZE),
+            .align = KVM_S390_VIRTIO_RING_ALIGN,
+            .index = i,
+            .num = 0,
+        };
+
+        vr = &vdev->vrings[i];
+        rc = pci_read(vdev->pci_fh, VPCI_C_COMMON_NUMQ, 4, &data, 2);
+        if (rc) {
+            return rc;
+        }
+
+        info.num = data;
+        vring_init(vr, &info);
+
+        rc = virtio_pci_set_selected_vq(vdev, vr->id);
+        if (rc) {
+            puts("Failed to set selected virt-queue");
+            return -EIO;
+        }
+
+        rc = virtio_pci_set_queue_size(vdev, 16);
+        if (rc) {
+            puts("Failed to set virt-queue size");
+            return -EIO;
+        }
+
+        rc = set_pci_vq_addr(vdev, vr->desc, VPCI_C_OFFSET_Q_DESCLO);
+        rc |= set_pci_vq_addr(vdev, vr->avail, VPCI_C_OFFSET_Q_AVAILLO);
+        rc |= set_pci_vq_addr(vdev, vr->used, VPCI_C_OFFSET_Q_USEDLO);
+        if (rc) {
+            puts("Failed to set virt-queue address");
+            return -EIO;
+        }
+
+        rc = virtio_pci_set_queue_enable(vdev, true);
+        if (rc) {
+            puts("Failed to set virt-queue enabled");
+            return -EIO;
+        }
+    }
+
+    status |= VPCI_S_FEATURES_OK | VPCI_S_DRIVER_OK;
+    return virtio_pci_set_status(vdev, status);
+}
+
+int virtio_pci_setup_device(void)
+{
+    int rc;
+    VDev *vdev = virtio_get_device();
+
+    rc = enable_pci_function(&vdev->pci_fh);
+    if (rc) {
+        puts("Failed to enable PCI function");
+        return rc;
+    }
+
+    return 0;
+}
+
+long virtio_pci_notify(uint32_t fhandle, int vq_id)
+{
+    uint64_t notice = 1;
+    uint32_t offset = notify_offset + vq_id * q_notify_offset;
+
+    return pci_write(fhandle, offset, notice, 4);
+}
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 05cfca4dad..dba30335b7 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -14,6 +14,7 @@
 #include "virtio.h"
 #include "virtio-scsi.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "bswap.h"
 #include "helper.h"
 #include "s390-time.h"
@@ -97,6 +98,8 @@ bool vring_notify(VRing *vr)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         vr->cookie = virtio_ccw_notify(vr->schid, vr->id, vr->cookie);
+    case S390_IPL_TYPE_PCI:
+        vr->cookie = virtio_pci_notify(virtio_get_device()->pci_fh, vr->id);
     }
 
     return vr->cookie >= 0;
@@ -181,6 +184,8 @@ int virtio_reset(VDev *vdev)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_reset(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_reset(vdev);
     }
 
     return -1;
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 1f17f98fc1..589962b998 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
       virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
-      virtio-ccw.o clp.o pci.o
+      virtio-ccw.o clp.o pci.o virtio-pci.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.49.0


