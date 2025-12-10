Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E727ED3B9AB
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTRDE-0004Zd-RI; Wed, 10 Dec 2025 15:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDC-0004YI-7d; Wed, 10 Dec 2025 15:55:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRD9-0000V4-UY; Wed, 10 Dec 2025 15:55:01 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJG6Mm000771;
 Wed, 10 Dec 2025 20:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=T221tsU4rQbXHOLBf
 XaiRSMtN2hHB1kztNXbbmpvbqw=; b=PxVJvoRNE1CHzCr02m04GtkW4vpGBiOch
 5vvkWWFIGmiLVFWoIv9pTBHSr2N1znpWllMlsPLbgto3dIJkCXmAJzp6E2OahCeB
 x5iytD95KO5S6zdgLYsVDzrgiQrwRnAS0Lyq9whAColBzhSPCnbfefs+cGH/r5Wu
 buvuDYuHqFewJ4mjxD0O4vt+8xt05O4ismJyLHNwsnXWMGmNfDPdUj1Z9QqcRl1A
 RCBbr55AEla1fWEqQtdoXQDt6noW2GYZLFLVcyEQ3Y9+gSYMpaJu49BRj4GAyCc9
 ifam2VqhABez5a65bvgCPz0xlqz5OL/uvS3m2jpniO2GPBgNhASPQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvv3gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:54:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAHUp41002057;
 Wed, 10 Dec 2025 20:54:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jjm9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:54:57 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BAKstXQ4129570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 20:54:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C388058056;
 Wed, 10 Dec 2025 20:54:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2060158052;
 Wed, 10 Dec 2025 20:54:55 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.53.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Dec 2025 20:54:55 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 02/10] pc-bios/s390-ccw: Store boot device type and bus
 separately
Date: Wed, 10 Dec 2025 15:54:41 -0500
Message-ID: <20251210205449.2783111-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210205449.2783111-1-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YUJLOll6M551GVQx4Rattsjt3wzt6egP
X-Proofpoint-ORIG-GUID: YUJLOll6M551GVQx4Rattsjt3wzt6egP
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6939de22 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=q3-f_CF3BKJy3EcvVqUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfXw6QUhlwNJYgI
 pMV7MYcyrzEUyYfnEF994iYnBMOYSyky6wx5j+vO4r3N/yxAt1PHMi9wj/6fbcUPQgf71y+yHx6
 /JIv/Wn1vnMfgrmiYn1CEbDjjeZj9tTC2ca2aRu+tF+/3FPp7vVXB3vNiNV9UsWrYxakoZHWT0B
 SqG0hgTIlbknzvlR9rrfz9+64marNAEndFLMEQSlk37Q7cKOdMA3fIAIH7T6+DpqrpzClFG2DvZ
 k/m6wPSNGcsVCVGvekdGikv6KaBnRoZl12WBTSJfI5NQfNUoPcQ6UCNV/+rMV36U3ym4im3X+O/
 N69gKrZhTrB8KS3cFYP5/g5fs/LMt/g4A4RECF9iO59gQE22rcdkspspRnCyrg9LqFUoVD63CpR
 fba0e7wSxIiQf7aNrk/WODdWTSDeQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Store both the device type (e.g. block) and device bus (e.g. CCW) to determine
IPL format rather than assume all devices can be identified by CCW specific
sense data.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.h                   |  5 ----
 include/hw/s390x/ipl/qipl.h      |  7 ++++++
 pc-bios/s390-ccw/iplb.h          |  4 ----
 pc-bios/s390-ccw/virtio.h        |  2 ++
 pc-bios/s390-ccw/main.c          | 10 +++++---
 pc-bios/s390-ccw/virtio-blkdev.c | 39 +++++++++++++++++++-------------
 pc-bios/s390-ccw/virtio.c        | 13 +++++++----
 7 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 505cded490..aec2244321 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -103,11 +103,6 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define DIAG308_PV_STORE            9
 #define DIAG308_PV_START            10
 
-#define S390_IPL_TYPE_FCP 0x00
-#define S390_IPL_TYPE_CCW 0x02
-#define S390_IPL_TYPE_PV 0x05
-#define S390_IPL_TYPE_QEMU_SCSI 0xff
-
 #define S390_IPLB_HEADER_LEN 8
 #define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6824391111..8199b839f0 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,13 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+#define S390_IPL_TYPE_FCP 0x00
+#define S390_IPL_TYPE_CCW 0x02
+#define S390_IPL_TYPE_PV 0x05
+#define S390_IPL_TYPE_QEMU_SCSI 0xff
+
+#define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW
+
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 08f259ff31..926e8eed5d 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -23,10 +23,6 @@ extern QemuIplParameters qipl;
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 extern bool have_iplb;
 
-#define S390_IPL_TYPE_FCP 0x00
-#define S390_IPL_TYPE_CCW 0x02
-#define S390_IPL_TYPE_QEMU_SCSI 0xff
-
 static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
 {
     register unsigned long addr asm("0") = (unsigned long) iplb;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 597bd42358..d557a4a90e 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -239,6 +239,8 @@ struct VDev {
     VirtioGDN guessed_disk_nature;
     SubChannelId schid;
     SenseId senseid;
+    VirtioDevType dev_type;
+    int ipl_type;
     union {
         VirtioBlkConfig blk;
         VirtioScsiConfig scsi;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 76bf743900..fef192c934 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -162,7 +162,7 @@ static void menu_setup(void)
         return;
     }
 
-    switch (iplb.pbt) {
+    switch (virtio_get_device()->ipl_type) {
     case S390_IPL_TYPE_CCW:
     case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
@@ -190,6 +190,7 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
+    VDev *vdev = virtio_get_device();
 
     if (have_iplb && memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
         ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
@@ -198,7 +199,10 @@ static void boot_setup(void)
     }
 
     if (have_iplb) {
+        vdev->ipl_type = iplb.pbt;
         menu_setup();
+    } else {
+        vdev->ipl_type = QEMU_DEFAULT_IPL;
     }
 
     memcpy(lpmsg + 10, loadparm_str, 8);
@@ -216,7 +220,7 @@ static bool find_boot_device(void)
     VDev *vdev = virtio_get_device();
     bool found = false;
 
-    switch (iplb.pbt) {
+    switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW:
         vdev->scsi_device_selected = false;
         debug_print_int("device no. ", iplb.ccw.devno);
@@ -245,7 +249,7 @@ static int virtio_setup(void)
     vdev->is_cdrom = false;
     int ret;
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_NET:
         puts("Network boot device detected");
         return 0;
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 4b819dd80f..f40a9407c2 100644
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
+        return;
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
+           && blksize >= 512 && blksize <= 4096;
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
index cd6c99c7e3..0f4f201038 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -41,7 +41,7 @@ VDev *virtio_get_device(void)
 
 VirtioDevType virtio_get_device_type(void)
 {
-    return vdev.senseid.cu_model;
+    return vdev.dev_type;
 }
 
 /* virtio spec v1.0 para 4.3.3.2 */
@@ -103,7 +103,7 @@ static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
         ccw.flags |= CCW_FLAG_SLI;
     }
 
-    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
+    return do_cio(vdev->schid, vdev->dev_type, ptr2u32(&ccw), CCW_FMT1);
 }
 
 static void vring_init(VRing *vr, VqInfo *info)
@@ -248,7 +248,7 @@ int virtio_setup_ccw(VDev *vdev)
         return -EIO;
     }
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->dev_type) {
     case VIRTIO_ID_NET:
         vdev->nr_vqs = 2;
         vdev->cmd_vr_idx = 0;
@@ -347,12 +347,17 @@ bool virtio_is_supported(SubChannelId schid)
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
-- 
2.49.0


