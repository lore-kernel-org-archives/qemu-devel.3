Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDCCD3409E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkH-00040U-HX; Tue, 27 Jan 2026 11:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljb-0003Yn-Qf; Tue, 27 Jan 2026 11:16:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljY-0000kk-Lc; Tue, 27 Jan 2026 11:16:07 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R819BP021671;
 Tue, 27 Jan 2026 16:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QgwY+s5/YPV70qhaR
 N7qDH1juH+0C1sYgP0UTCDerkQ=; b=ORuk7yOwjV73ys5xJO7S7S2DvciP/1Ntg
 HNbnXonGqc+x+Bcjvc4BKr3ihyvGb2qyCJPT1X2wJt7wCW/iHW9x/7Dz3Ps+6QD0
 Yz+RH8PGNjmSGVwGngbaqREIt7HtcjMdHaRbQW1dk2jOzvd6vqwlR0UMgKCfWvq1
 Qv/0u+pJPR81N6kMwNUmSnMJ4fGIQtPxDTOUoTFwq0ATXNBkDJQ3ftc1iqvjFpIL
 eW7yU2FhjRz3YvVPcet2HMzy5ajgPFknFLIDbuJik5pYUf4fwTQQSigBHjofoFSR
 dKlrhtLxDP/v/GWd0JyEr8Zx/PdsLJHWZBPhkCAOWJZPJ+ags1vIQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6xepc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REPh6V023625;
 Tue, 27 Jan 2026 16:16:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjs51k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGFfuw16581304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:15:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50BDF5805A;
 Tue, 27 Jan 2026 16:16:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32E7758054;
 Tue, 27 Jan 2026 16:15:59 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:15:59 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 04/14] pc-bios/s390-ccw: Store device type independent of
 sense data
Date: Tue, 27 Jan 2026 11:15:37 -0500
Message-ID: <20260127161547.459443-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BSigvPKW1JTQXtxY8W7ZFVE6AGelyRCb
X-Proofpoint-ORIG-GUID: BSigvPKW1JTQXtxY8W7ZFVE6AGelyRCb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX99EcGWaP9Obj
 d4hvnIq9Q7TQWvWAa/FUPyMl6+f7a9MYkyGprh69ifwRyNox89ivL81FfCL7LtQ+ZilRoHR5h5x
 68YTThfHdm1P5BEVdOVcFwRnIiVwZycsnZtRKQ6BkTrDEl6N8BhIda3vQWaL0hTIRUSO744+Qr7
 dRCXSbN02CBzNG3kJEAcWdKsGVWy1LgbccGSVWNNXE/Od/V/AtTm/9Ww6s9zNikq1vhiOGWUMxo
 i61xUafyJtAy9HiQl+veknoVQAFxuU4WZVDVTAi4AsYv8eKybi/YnJdxu9dkcwsRSpIIdATLPay
 rMA9AtX9p3AKmgeQjvN0KPJ4V1WuJlQDfVMrDrPGEhptWg1Xj4deltDMQ58EpagYGqFaqmW/Fb9
 FflbGXbWM7pjPKJvE3VitBsoLd8WZXqopieldEmcZVyWXqNcFMIuBTETJ3n4IEbBVWON/mHDBXC
 i35be4tCcR4ZdCvsrCg==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978e4c3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=OLVzLx0gnTBhq6zLJUYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Store the device type (e.g. block) directly and an attribute of the VDev rather
than assume all devices can be identified by accessing CCW specific sense data.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c          |  2 +-
 pc-bios/s390-ccw/virtio-blkdev.c | 39 +++++++++++++++++++-------------
 pc-bios/s390-ccw/virtio.c        | 11 ++++++---
 pc-bios/s390-ccw/virtio.h        |  1 +
 4 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 0446d5de67..e7c3d9b2d6 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -250,7 +250,7 @@ static int virtio_setup(void)
     vdev->is_cdrom = false;
     int ret;
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_NET:
         puts("Network boot device detected");
         return 0;
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 019c2718b1..9cc40e9108 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -53,14 +53,14 @@ int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return virtio_blk_read_many(vdev, sector, load_addr, sec_num);
     case VIRTIO_ID_SCSI:
         return virtio_scsi_read_many(vdev, sector, load_addr, sec_num);
+    default:
+        return -1;
     }
-
-    return -1;
 }
 
 unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
@@ -119,7 +119,7 @@ void virtio_assume_iso9660(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
         vdev->config.blk.blk_size = VIRTIO_ISO_BLOCK_SIZE;
@@ -129,6 +129,8 @@ void virtio_assume_iso9660(void)
     case VIRTIO_ID_SCSI:
         vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
         break;
+    default:
+        return;
     }
 }
 
@@ -139,13 +141,15 @@ void virtio_assume_eckd(void)
     vdev->guessed_disk_nature = VIRTIO_GDN_DASD;
     vdev->blk_factor = 1;
     vdev->config.blk.physical_block_exp = 0;
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         vdev->config.blk.blk_size = VIRTIO_DASD_DEFAULT_BLOCK_SIZE;
         break;
     case VIRTIO_ID_SCSI:
         vdev->config.blk.blk_size = vdev->scsi_block_size;
         break;
+    default:
+        break;
     }
     vdev->config.blk.geometry.heads = 15;
     vdev->config.blk.geometry.sectors =
@@ -162,50 +166,52 @@ bool virtio_ipl_disk_is_valid(void)
         return true;
     }
 
-    return (vdev->senseid.cu_model == VIRTIO_ID_BLOCK ||
-            vdev->senseid.cu_model == VIRTIO_ID_SCSI) &&
-           blksize >= 512 && blksize <= 4096;
+    return (vdev->dev_type == VIRTIO_ID_BLOCK || vdev->dev_type == VIRTIO_ID_SCSI)
+            && blksize >= 512 && blksize <= 4096;
 }
 
 int virtio_get_block_size(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.blk_size;
     case VIRTIO_ID_SCSI:
         return vdev->scsi_block_size;
+    default:
+        return 0;
     }
-    return 0;
 }
 
 uint8_t virtio_get_heads(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.geometry.heads;
     case VIRTIO_ID_SCSI:
         return vdev->guessed_disk_nature == VIRTIO_GDN_DASD
                ? vdev->config.blk.geometry.heads : 255;
+    default:
+        return 0;
     }
-    return 0;
 }
 
 uint8_t virtio_get_sectors(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.geometry.sectors;
     case VIRTIO_ID_SCSI:
         return vdev->guessed_disk_nature == VIRTIO_GDN_DASD
                ? vdev->config.blk.geometry.sectors : 63;
+    default:
+        return 0;
     }
-    return 0;
 }
 
 uint64_t virtio_get_blocks(void)
@@ -213,13 +219,14 @@ uint64_t virtio_get_blocks(void)
     VDev *vdev = virtio_get_device();
     const uint64_t factor = virtio_get_block_size() / VIRTIO_SECTOR_SIZE;
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.capacity / factor;
     case VIRTIO_ID_SCSI:
         return vdev->scsi_last_block / factor;
+    default:
+        return 0;
     }
-    return 0;
 }
 
 int virtio_blk_setup_device(SubChannelId schid)
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index f384a990dc..5dd407d5c9 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -41,7 +41,7 @@ VDev *virtio_get_device(void)
 
 VirtioDevType virtio_get_device_type(void)
 {
-    return vdev.senseid.cu_model;
+    return vdev.dev_type;
 }
 
 /* virtio spec v1.0 para 4.3.3.2 */
@@ -248,7 +248,7 @@ int virtio_setup_ccw(VDev *vdev)
         return -EIO;
     }
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_NET:
         vdev->nr_vqs = 2;
         vdev->cmd_vr_idx = 0;
@@ -346,12 +346,17 @@ bool virtio_is_supported(SubChannelId schid)
                 true)) {
         return false;
     }
+
+    vdev.dev_type = vdev.senseid.cu_model;
+
     if (vdev.senseid.cu_type == 0x3832) {
-        switch (vdev.senseid.cu_model) {
+        switch (vdev.dev_type) {
         case VIRTIO_ID_BLOCK:
         case VIRTIO_ID_SCSI:
         case VIRTIO_ID_NET:
             return true;
+        default:
+            return false;
         }
     }
     return false;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 391d6ff2f7..39b507b221 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -239,6 +239,7 @@ struct VDev {
     SubChannelId schid;
     SenseId senseid;
     S390IplType ipl_type;
+    VirtioDevType dev_type;
     union {
         VirtioBlkConfig blk;
         VirtioScsiConfig scsi;
-- 
2.52.0


