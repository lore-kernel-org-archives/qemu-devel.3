Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38571EDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcSZ-0002NI-4P; Tue, 03 Mar 2026 21:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSX-0002Mz-Oe; Tue, 03 Mar 2026 21:59:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSV-0000Vw-Vz; Tue, 03 Mar 2026 21:59:37 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623IbjUW2397074; Wed, 4 Mar 2026 02:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=md4CysbsBmdl7lNFD
 QWHTmv3Azkm6rqCzI0dEfykoCw=; b=tNNrN9HZA5ZpOZbyE+721kcoGb7J0PMI/
 ETA4V79zSxG8b/4lb+nie0j+W2RvvegPbaUaaSSm+HN0JkTcSHxMlQS3e5k9XJNa
 aDFS9bAhC9LM7e0GKX69fkCraPvo34SxZN9a+Sif8JZydeCzz6m/QU2H70LDiGO4
 lTUWSYlK97YTEdymSXvV2iCjoZuHNlTOz0GLSp1lpqqepxyXtNrfawVj96HldzM1
 mkO2yaKh6zWGNhwB6m0VXzKEztA5fOTUmIWi4fTnl4RJT8txa1t1OhS6bJSNS580
 U1L9QRN0lxisZG1BsFjgOpCwn5QsvSanhllEguaNmQ1CAGvPI3zHg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj5qhd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623M194e003253;
 Wed, 4 Mar 2026 02:59:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y54t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xVl023003774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1C015805D;
 Wed,  4 Mar 2026 02:59:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E08E58043;
 Wed,  4 Mar 2026 02:59:30 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:30 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 05/15] pc-bios/s390-ccw: Store device type independent of
 sense data
Date: Tue,  3 Mar 2026 21:59:07 -0500
Message-ID: <20260304025917.2157032-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a7a016 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=qVW2lH4TfVjATuXUM1kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfXyEtUsDhvOB3L
 tT0lSAEIXhEcogFVwPz3CIFm5vmi2LqcRzE1u53gMENGPFo/vxDBaUx5v2Xb4pCuEH2QatSHoHS
 OtUTIJm5eSIu7rjAZFVl15YxNMMKGVnm5ZenPrC8lep5+hZT9biuNsbQx65/nyvH7DuVgE4A5PB
 Ii4W5K2HUbpci52g3KVq3zcOmTIJlU3W6ltaoYoq/Bbts7t8vKQEtFIyUpZAymYyW3f0LCsc7sB
 ajknMFAAAcPjztGoXAyx/Yhv4zRIcXwGqpSDYu3ZuKINwJcVRBmC96kPezJPn/xuq6f0U9JriYl
 pS1xjt5m0JMyH8La6UgMITEG0Gjun7QpHGS46jQIXmXGG5TiN0n3imWJ29fpcWd1U9Vw49cR9CR
 7XHJ9XL6xAHb6gJCgVwALaoOCWlPVDktjlW9KfVCjkBjHZJ5ZLqC7tGh/eC7khZbhF9hCyp20aD
 t+YamtMDwvz3aY4K25w==
X-Proofpoint-GUID: 9hcJtL9THZYdNbn9zoI3_BRmqbU2d7sM
X-Proofpoint-ORIG-GUID: 9hcJtL9THZYdNbn9zoI3_BRmqbU2d7sM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
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

Store the device type (e.g. block) directly as an attribute of the VDev rather
than assume all devices can be identified by accessing CCW specific sense data.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c          |  2 +-
 pc-bios/s390-ccw/virtio-blkdev.c | 39 +++++++++++++++++++-------------
 pc-bios/s390-ccw/virtio.c        | 11 ++++++---
 pc-bios/s390-ccw/virtio.h        |  1 +
 4 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index ef5acc1985..b3b16f845b 100644
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


