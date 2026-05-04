Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C95AFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 22:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK1ay-0001ym-81; Mon, 04 May 2026 18:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ag-0001vy-HC; Mon, 04 May 2026 18:16:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1aZ-0002sE-Bi; Mon, 04 May 2026 18:16:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644Fu4rW3001038; Mon, 4 May 2026 22:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=C7nsx+MkAUaI3LHKc
 x9PZPRwc5JqzC5aODaFyFmH8So=; b=D+p4tP8plMdEehNf1Bh7HotPLNepWMNMI
 OGS4hUbriFc8uNIw+NXQqBytgjvT8MpnP8uYbhoi0C8dRbWXam0NW4372BYGdiLH
 ufN0+dloTjNIRfPjX6AmxQWV6p3giHAiR+GCMmGhnvbmLz21g2W0n7XtIHXOb7ky
 VkMYL/tI8i4mSueNcyQqZhDAE5G7Mwnb/6aBIzMnQTMllwGjTMsmkYnFuyiD4SIT
 Smp37xtzcgZCNqcUilOAn5lGaWGNu9BLhlPKSjvkjBG3/OWXFN2jbOxZbYDNmWkg
 +Xp0lM2zMQxWK0wYsVvnakrchXQNxgMYbZDD7kT7Gy6ULlL21hPmA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4gvfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644M9gke012305;
 Mon, 4 May 2026 22:16:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg6w5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644MGNFj19399296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 22:16:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C7B758055;
 Mon,  4 May 2026 22:16:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9769B58043;
 Mon,  4 May 2026 22:16:22 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.119.68])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 22:16:22 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 4/6] s390x: Introduce PCI SCSI IPLB and boot type
Date: Mon,  4 May 2026 18:16:11 -0400
Message-ID: <20260504221613.826825-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260504221613.826825-1-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIwNSBTYWx0ZWRfX8LF8egXOIQi5
 ZOpW78DkFaI2l1GfrfjzR5fzjWSSiRzxUEQxbCX9efVnXJgiGkm8z8Mm+F8ECbgbVu84iHCppgU
 b1ZZci5RNFzQJlomQw8ORpOs7BxHRFB2UottubbgMvNSGQoQj7MdUm3b8HFNhEDMYTc6t0Yzxr6
 Jv15cHqQOtRxz1SQq+USrDzEaJl9m9WevatUg1lYTueXVQsqpH4UeZhLYyK3ZSwrOdOI+5Lze9H
 CxxiZLo+PI3d9+UwJDqXZeya9raeocn6xUX8CnmCbdcMlaIytZ5OsvB5HZGq1DhtSrGQ88hoGcF
 PB+AxLODP44aTRAuenwqOBZntKID7QEOUcIdzjQYLtv/wBwyNl5F5t+ujRN2/G1lE2SW9EPtxpY
 ErHHf/D1gaPpiKgzH4p36Cj3dExO2LVJRmjTqXHTUNsGj6G8MfP50J/MEwBYTh0Hnw1MZQrvdOk
 YP+cb+WFnLBT33kYuqA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69f91ab9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=6Cfbqmhnqq_KncMTHv0A:9
X-Proofpoint-GUID: wC7amXW52LmHscOTBpXu6iaiD-zbNXlf
X-Proofpoint-ORIG-GUID: wC7amXW52LmHscOTBpXu6iaiD-zbNXlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Define a new IPLB format for SCSI PCI devices and add cases to handle it.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 include/hw/s390x/ipl/qipl.h    | 15 +++++++++++++++
 pc-bios/s390-ccw/main.c        | 11 ++++++++++-
 pc-bios/s390-ccw/virtio-pci.c  | 29 +++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c | 14 +++++++++++++-
 pc-bios/s390-ccw/virtio.c      |  5 +++++
 5 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 67db54c964..951c5e2d8e 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -25,6 +25,7 @@ enum S390IplType {
     S390_IPL_TYPE_CCW = 0x02,
     S390_IPL_TYPE_PCI = 0x04,
     S390_IPL_TYPE_PV = 0x05,
+    S390_IPL_TYPE_PCI_SCSI = 0xfe,
     S390_IPL_TYPE_CCW_SCSI = 0xff
 };
 typedef enum S390IplType S390IplType;
@@ -117,6 +118,19 @@ struct IplBlockPci {
 } QEMU_PACKED;
 typedef struct IplBlockPci IplBlockPci;
 
+struct IplBlockPciScsi {
+    uint32_t lun;
+    uint16_t target;
+    uint16_t channel;
+    uint8_t  reserved0[74];
+    uint8_t  opt;
+    uint8_t  reserved1[3];
+    uint32_t fid;
+    uint8_t  ssid;
+    uint16_t devno;
+} QEMU_PACKED;
+typedef struct IplBlockPciScsi IplBlockPciScsi;
+
 union IplParameterBlock {
     struct {
         uint32_t len;
@@ -133,6 +147,7 @@ union IplParameterBlock {
             IPLBlockPV pv;
             IplBlockCcwScsi ccw_scsi;
             IplBlockPci pci;
+            IplBlockPciScsi pci_scsi;
         };
     } QEMU_PACKED;
     struct {
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 1a9579beab..b2bc35962a 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -257,7 +257,15 @@ static bool find_boot_device(void)
         blk_schid.ssid = iplb.ccw_scsi.ssid & 0x3;
         found = find_subch(iplb.ccw_scsi.devno);
         break;
+     case S390_IPL_TYPE_PCI_SCSI:
+        vdev->scsi_device_selected = true;
+        vdev->selected_scsi_device.channel = iplb.pci_scsi.channel;
+        vdev->selected_scsi_device.target = iplb.pci_scsi.target;
+        vdev->selected_scsi_device.lun = iplb.pci_scsi.lun;
+        found = find_fid(iplb.pci_scsi.fid);
+        break;
      case S390_IPL_TYPE_PCI:
+        vdev->scsi_device_selected = false;
         found = find_fid(iplb.pci.fid);
         break;
     default:
@@ -318,13 +326,13 @@ static void ipl_pci_device(void)
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
@@ -343,6 +351,7 @@ static void ipl_boot_device(void)
     case S390_IPL_TYPE_CCW:
         ipl_ccw_device();
         break;
+    case S390_IPL_TYPE_PCI_SCSI:
     case S390_IPL_TYPE_PCI:
         ipl_pci_device();
         break;
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 736869f4f5..01a1401ef2 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -53,6 +53,10 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
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
@@ -200,6 +204,26 @@ static int virtio_pci_get_blk_config(void)
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
@@ -367,6 +391,11 @@ int virtio_pci_setup(VDev *vdev)
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
index 9ea00c6fe6..09d2caa879 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -16,6 +16,7 @@
 #include "scsi.h"
 #include "virtio-scsi.h"
 #include "virtio-ccw.h"
+#include "virtio-pci.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -479,7 +480,18 @@ static int virtio_scsi_setup(VDev *vdev)
 
 int virtio_scsi_setup_device(VDev *vdev)
 {
-    virtio_ccw_setup(vdev);
+    switch (vdev->ipl_type) {
+    case S390_IPL_TYPE_CCW_SCSI:
+    case S390_IPL_TYPE_CCW:
+        virtio_ccw_setup(vdev);
+        break;
+    case S390_IPL_TYPE_PCI_SCSI:
+    case S390_IPL_TYPE_PCI:
+        virtio_pci_setup(vdev);
+        break;
+    default:
+        return 1;
+    }
 
     if (vdev->config.scsi.sense_size != VIRTIO_SCSI_SENSE_SIZE) {
         puts("Config: sense size mismatch");
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 79dccdcbfc..598768d12b 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -89,6 +89,8 @@ static int virtio_do_run(VDev *vdev, int vqid, VirtioCmd *cmd)
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
 {
     switch (vdev->ipl_type) {
+    case S390_IPL_TYPE_PCI_SCSI:
+    case S390_IPL_TYPE_PCI:
     case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_do_run(vdev, vqid, cmd);
@@ -130,6 +132,7 @@ bool vring_notify(VRing *vr)
     case S390_IPL_TYPE_CCW:
         vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
         break;
+    case S390_IPL_TYPE_PCI_SCSI:
     case S390_IPL_TYPE_PCI:
         vr->cookie = virtio_pci_notify(vr);
         break;
@@ -150,6 +153,7 @@ bool be_ipl(void)
     case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return true;
+    case S390_IPL_TYPE_PCI_SCSI:
     case S390_IPL_TYPE_PCI:
         return false;
     default:
@@ -252,6 +256,7 @@ int virtio_reset(VDev *vdev)
     case S390_IPL_TYPE_CCW_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_reset(vdev);
+    case S390_IPL_TYPE_PCI_SCSI:
     case S390_IPL_TYPE_PCI:
         return virtio_pci_reset(vdev);
     default:
-- 
2.52.0


