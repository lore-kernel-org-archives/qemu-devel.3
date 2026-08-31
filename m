Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D200C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x180g-0000Na-CS; Mon, 31 Aug 2026 15:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180e-0000Mo-8W; Mon, 31 Aug 2026 15:49:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180c-0002de-Ex; Mon, 31 Aug 2026 15:49:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVm6p3116228; Mon, 31 Aug 2026 19:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=kCIuRqC1KVYiP9ggr
 u0AFmuEihxTSVjItO2jS3Ly2ZM=; b=RQwDZR5kYY8pOixlvKNoiyP95SF2QimLn
 AvqFA5om0Vszb2PUZlBxGzdMBGpuMRyTU6lGMey/mS8A184qF+2FqPzGodqG46OC
 gADZTlTh8AApR/dU+bZA57r+zeZd4n2yfLqP/fPP/xEEwyR/n/EnjAaZccZMxgfB
 8LtfjIg4sl7sejmRilSokl5rNehL3fGrAfPuFAlhgORftRPB5NUYKm8FehGIvZck
 ykpIVkn7yv29t5AGZ42fHe1TcVhQNUH7rbPytun4tg/8ddL7KMcMb/57mkfADbzo
 OSgqZP6VA3n6YhyEkQOG0vGjLyjDUON4o9BYAd6O3E4mi9/ZBfclg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5bhex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJfHT5000446;
 Mon, 31 Aug 2026 19:49:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjysew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VJnUR721561882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 19:49:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B2F15805E;
 Mon, 31 Aug 2026 19:49:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9E7158052;
 Mon, 31 Aug 2026 19:49:29 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 19:49:29 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 zycai@linux.ibm.com
Subject: [PATCH v3 6/8] pc-bios/s390-ccw: Add support for virtio-scsi-pci IPL
Date: Mon, 31 Aug 2026 15:49:17 -0400
Message-ID: <20260831194919.3830270-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260831194919.3830270-1-jrossi@linux.ibm.com>
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a95dacc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=_aD-10DgKkLGNpmbtU8A:9
X-Proofpoint-GUID: 3F0m0aWWlkrVa_W-V6aKFOVxZXLQMv1S
X-Proofpoint-ORIG-GUID: 3F0m0aWWlkrVa_W-V6aKFOVxZXLQMv1S
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX+ymGROWR/kPy
 D+Smrm4xOpRjG2MpzoNN8CNULAyodPTDs+V0VqFykGUA93N9HIqZWo5SC8ZZsrpTv6ABkSRrTP1
 APy5mdJOf8gYpM8FJJhMadWJZs3TSoY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX4LXB2SBxzUGb
 TH7OwWskS2SGTQt+kvLQO8wbfnETw1FZ8yNI3L4P3lgoEQ59TzaDzgIF7FiAuHxEoKmcBqgPcUm
 d2hPMdafUYbX+0nmxeDIXJLGF6AFWl/FYVoV/rpYhnmtCdLeLIOh6WbW5eaic/pbkNvwy9M4Xph
 cEo9ThRN2pQAC8Sxf5qaZrwRRy6bAqMiM0ZpI49GxRA0jmh5qORCKUi0JCR6kfx+jXU4GGuEml1
 /Yj4+0HsCPB4mFR4yABYa/YY4Bp/07KpIbn9uNcsSU9avUUDwtOSuW/95V4z+LfWANRcn/YivCI
 qspSTIYOtN5b15cMVFEWuBa0M/UvadZSXx3TYDAGGq+eJAhU7qhXsBsGkv9W5CgmOXC4LFWkh5v
 1pHfM+NXFJ3upVuBzchCZq8TgSD5Gi0IQib9hMecG90dtOIoo1poJf2vPf+nmLmNkFleAXcZrdf
 bVmIGt81AZhOWUsziPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
2.54.0


