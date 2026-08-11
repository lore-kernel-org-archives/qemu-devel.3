Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCBDC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnke-0002a4-5W; Tue, 11 Aug 2026 10:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkc-0002YD-Hc; Tue, 11 Aug 2026 10:46:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnka-0003g6-R3; Tue, 11 Aug 2026 10:46:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDXAaK3634660; Tue, 11 Aug 2026 14:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wYRRuc+muzR2Kk+N6
 viEz8MaYF32b4UxfVveXUWeW3U=; b=FB0DNXfgjvefITQyjwhvkGmuXVCUhp4fw
 UZnESBh5X2pNWFbGbQF2TxIKaQ3sE53UDONXgvxaRE4BBX5KMJtixm/H0HMp6tjz
 tnJ0Ay30uqrXwyZMf5xgv5djg9UyZ5SVoiLaFx9oOLf3pLI9OSgkKq2lDYPVopCh
 9km4uVnzsPpyurwQG2ijcD2w2XjhtoaakhWS7rxrzfIMT6AJ4DW/x3uaDWK4N2nL
 FaQiiq4DoSTkdYSgCwIsX3RMPqY+a02UxZdwKjGQuLuPMwzCO+UU1WXyvFPpkWLy
 jGy+g/orLVXO0Kbvf0wGWxqv23G1jPf4OptI6/e6hydg72BSvQdVQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23p62d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfIMS023482;
 Tue, 11 Aug 2026 14:46:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h198j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEkfO546203186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20CD458055;
 Tue, 11 Aug 2026 14:46:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89A445805D;
 Tue, 11 Aug 2026 14:46:40 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:40 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 6/8] pc-bios/s390-ccw: Add support for virtio-scsi-pci IPL
Date: Tue, 11 Aug 2026 10:46:27 -0400
Message-ID: <20260811144629.866641-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260811144629.866641-1-jrossi@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b35d3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=_aD-10DgKkLGNpmbtU8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXw7jRjpz5egON
 bwKAnPHk6ahvpQs8gObdSOQ6LMKgad00eds3/S2RRBNbFkQVfOJ6m42SYWQ2HtVl6QYBkxtqRoN
 +ZNXLH3u/Z/sJH3moTheX7Gp5eVc0Ev3Pv33+GnyHnQBiQwyJ2WXTAmq2uWs6UFCOnUji071SSM
 RQpVPBXpVyc/wuJm7yFTHl3tbvMBkzr4GEeIqC59h2dGsse9zJ4dMrB03PWlZublizz8fuhmg8q
 Ksb8HqJEoUez5PClNdwb8xBb2KQWqkJzJxGmPlx+LtSDji/zCrNv5MzNYILgjNMMeDztCVFsPSR
 gBzAVcxCmgKm5vic6Lvyp5pnO2TyBZemLL1Xlzbb4ATmsTFDbR8U8CcKpqJ4oi8owfdEv04zP9e
 9G2Jssj7WqAMui8OId+6dWqUQsTPPSK3ITJ3IySAug/gMG9C3XkrERrb2oCqWwxm+uJJqGpx4zD
 slia8wIwJs0qmBXzUYQ==
X-Proofpoint-ORIG-GUID: sEn56dJLIMKL-o9VZhFdvEP5XqVW2kh9
X-Proofpoint-GUID: sEn56dJLIMKL-o9VZhFdvEP5XqVW2kh9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX9nNhg+F0yMoH
 BzkEAOAiAdAtdHYvT0FseFS1u5cBeDONS5DpOU/Ds7ea7VUDQ2E909UD7uvufxZM0blvNeCSN4C
 /WJG7vqmM6mqdyfgVVoQc4tEXQf1P+Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c        |  3 ++-
 pc-bios/s390-ccw/virtio-pci.c  | 30 ++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c | 12 +++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 63692260a4..50f455324e 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -269,6 +269,7 @@ static bool find_boot_device(void)
         }
         break;
      case S390_IPL_TYPE_PCI:
+        vdev->scsi_device_selected = false;
         found = find_fid(iplb.pci.fid);
         break;
     default:
@@ -329,13 +330,13 @@ static void ipl_pci_device(void)
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
index 9ea00c6fe6..095d7ac430 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -16,6 +16,7 @@
 #include "scsi.h"
 #include "virtio-scsi.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -479,7 +480,16 @@ static int virtio_scsi_setup(VDev *vdev)
 
 int virtio_scsi_setup_device(VDev *vdev)
 {
-    virtio_ccw_setup(vdev);
+    switch (vdev->ipl_type) {
+    case S390_IPL_TYPE_CCW:
+        virtio_ccw_setup(vdev);
+        break;
+    case S390_IPL_TYPE_PCI:
+        virtio_pci_setup(vdev);
+        break;
+    default:
+        return 1;
+    }
 
     if (vdev->config.scsi.sense_size != VIRTIO_SCSI_SENSE_SIZE) {
         puts("Config: sense size mismatch");
-- 
2.54.0


