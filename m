Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8F7C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKJ-0006Lx-8j; Mon, 21 Sep 2026 16:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKC-0006CK-G7; Mon, 21 Sep 2026 16:09:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKA-0005PX-Fu; Mon, 21 Sep 2026 16:09:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8YQr1711881; Mon, 21 Sep 2026 20:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Rz4dgk8kfR9oiKX1U
 FY0Jf53lKvK5ABW6bwWPfMj1t4=; b=pG9yev1nqWOaIGCWGOaoZZQSzXRrvkIU+
 mNP+ntUiTmfpyLKq3LoMr519HSxsImq5Zz5FmZ6UnjDKSMJNcMe3BfNza07SwVfY
 ZESrtfB7V6q4EmaqQjYjhfmrSpHF6EbvBLdC0yLUWYOZdkOcVfn3+Tqz75LFY7bY
 mw/NUyAxEmDcihPt4T2gpcgasLXLWmQwHNX5GCs//JYqsl8LFl0++mWdQ8rdBp6r
 ipLzCh9d3jhGA4QEgeQeMrjEzr6ojKkCUlBqn3cJrFo0zAqWl3fKWPbiO/Pr5Drn
 MAWf+0unakQw5aBNfPnlg9OJW3wvCzy6fbK0g1jUbR6dC3AcJOhwQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1abwc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJK5UB1451389; Mon, 21 Sep 2026 20:08:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gpu5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8nvq32113324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:49 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A0F05805E;
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8D4B58059;
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 29/33] pc-bios/s390-ccw: Add support for virtio-scsi-pci IPL
Date: Mon, 21 Sep 2026 16:08:26 -0400
Message-ID: <20260921200830.1302919-30-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CZIqQGhBpyQ0QJlD7NRZ1QVzsQ6Jfpbb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX5hfrq6tFaHrx
 0sHZT7V013SN8ykDBuRXSfqae/Vda/1fpJPJDjPrKUaJhMFaC0K5Tap0zGe+y9Ku1utZWhOwLVy
 38cO8mcAmY7mnKGyHSvoBKeRa+nA/SEUnJeGAxajzEYZgoECBktSmJl0VDbao72gLegMBhFPSg9
 DyYxFQlSD49LMnz3h5Qoe89WQEmep/6TrrqPuTRSk8wRRQJKWN+LPg8r8gpxwxvPGhq6Q4Hfp8O
 s4rDAuKneyp7Sj3JycgSrLnNmCpsTpJEHyFO4sbIatzgUCTZbTUrAon6xISnUd/zljUP9/tCXZf
 ZO1eos5QhtNsjaWYboFOW4OyrsNF0p58bHqJSfKuYzNEzoafyC+WjK0+uRmBrbieXWwtPaHJBwL
 a5z91QaQOE8uvzuuJGhNoXz5fDomuY9m0XAckQIZn8JF3v9v2ME5BPvMlb0Otf2U6S2dTn9hzIg
 IFYJ20l/93yvbZQupvQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab18ed2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_aD-10DgKkLGNpmbtU8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX6TM4yGsxAVfl
 1xRGIYLArtvSBjZzeiLmUItieSXeRQc1DALnwnEGTASU8/6WYWHav4gEw38kfRuqNjAiNdNP9hI
 SiYOOYLAp6AJGGZDh+GtRJm1Ab00a5o=
X-Proofpoint-GUID: CZIqQGhBpyQ0QJlD7NRZ1QVzsQ6Jfpbb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Read virtio-pci configuration and configure virt-queue for scsi devices.

Also add check for virtio setup failures when doing scsi setup and return
early if it fails instead of waiting for subsequent failure.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-7-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c        |  3 ++-
 pc-bios/s390-ccw/virtio-pci.c  | 30 ++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c | 18 +++++++++++++++++-
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 6ab2b8f75b..a2a24b024f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -273,6 +273,7 @@ static bool find_boot_device(void)
         }
         break;
      case S390_IPL_TYPE_PCI:
+        vdev->scsi_device_selected = false;
         found = find_fid(iplb->pci.fid);
         break;
     default:
@@ -333,13 +334,13 @@ static void ipl_pci_device(void)
 {
     VDev *vdev = virtio_get_device();
     vdev->is_cdrom = false;
-    vdev->scsi_device_selected = false;
 
     if (virtio_pci_setup_device()) {
         return;
     }
 
     switch (vdev->dev_type) {
+    case VIRTIO_ID_SCSI:
     case VIRTIO_ID_BLOCK:
         if (virtio_setup() == 0) {
             zipl_load(); /* only return on error */
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 231ab6e04d..277c3ea68d 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -52,6 +52,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
     case 0x1001:
         vdev->dev_type = VIRTIO_ID_BLOCK;
         break;
+    case 0x1048:
+    case 0x1004:
+        vdev->dev_type = VIRTIO_ID_SCSI;
+        break;
     default:
         vdev->dev_type = 0;
     }
@@ -199,6 +203,26 @@ static int virtio_pci_get_blk_config(void)
     return rc;
 }
 
+static int virtio_pci_get_scsi_config(void)
+{
+    VirtioScsiConfig *cfg = &virtio_get_device()->config.scsi;
+    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, sizeof(VirtioScsiConfig));
+
+    /* all fields of scsi config must be byte swapped */
+    cfg->num_queues = bswap32(cfg->num_queues);
+    cfg->seg_max = bswap32(cfg->seg_max);
+    cfg->max_sectors = bswap32(cfg->max_sectors);
+    cfg->cmd_per_lun = bswap32(cfg->cmd_per_lun);
+    cfg->event_info_size = bswap32(cfg->event_info_size);
+    cfg->sense_size = bswap32(cfg->sense_size);
+    cfg->cdb_size = bswap32(cfg->cdb_size);
+    cfg->max_channel = bswap16(cfg->max_channel);
+    cfg->max_target = bswap16(cfg->max_target);
+    cfg->max_lun = bswap32(cfg->max_lun);
+
+    return rc;
+}
+
 static int virtio_pci_negotiate(void)
 {
     int i, rc;
@@ -330,6 +354,7 @@ bool virtio_pci_is_supported(VDev *vdev)
     if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
         switch (vdev->dev_type) {
         case VIRTIO_ID_BLOCK:
+        case VIRTIO_ID_SCSI:
             return true;
         default:
             return false;
@@ -384,6 +409,11 @@ int virtio_pci_setup(VDev *vdev)
         vdev->cmd_vr_idx = 0;
         virtio_pci_get_blk_config();
         break;
+    case VIRTIO_ID_SCSI:
+        vdev->nr_vqs = 3;
+        vdev->cmd_vr_idx = 2;
+        virtio_pci_get_scsi_config();
+        break;
     default:
         puts("Unsupported virtio device");
         return -ENODEV;
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 9ea00c6fe6..ca02ff5989 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -16,6 +16,7 @@
 #include "scsi.h"
 #include "virtio-scsi.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -479,7 +480,22 @@ static int virtio_scsi_setup(VDev *vdev)
 
 int virtio_scsi_setup_device(VDev *vdev)
 {
-    virtio_ccw_setup(vdev);
+    switch (vdev->ipl_type) {
+    case S390_IPL_TYPE_CCW:
+        if (virtio_ccw_setup(vdev)) {
+            puts("Setup failed for virtio-scsi-ccw");
+            return 1;
+        }
+        break;
+    case S390_IPL_TYPE_PCI:
+        if (virtio_pci_setup(vdev)) {
+            puts("Setup failed for virtio-scsi-pci");
+            return 1;
+        }
+        break;
+    default:
+        return 1;
+    }
 
     if (vdev->config.scsi.sense_size != VIRTIO_SCSI_SENSE_SIZE) {
         puts("Config: sense size mismatch");
-- 
2.55.0


