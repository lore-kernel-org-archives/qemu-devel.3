Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C147CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAscj-0003jN-UL; Mon, 20 Oct 2025 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAsch-0003i2-EE; Mon, 20 Oct 2025 12:20:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAscd-0000sJ-9q; Mon, 20 Oct 2025 12:20:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBxw77018780;
 Mon, 20 Oct 2025 16:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=eaDETEqQkZCPcgw+E
 lXLQNx2g+HajjVjn39KizoJY4w=; b=h/YdWHfI3ebqoE197/XuBJaU4L1voNfbS
 sUR22601SgQ9YH8+5BASDbTwxSKgWSUUADXppwDZthhd90QAjJ9iby43EO/rpn5Q
 jdiKn4OKTPjDqUxjuSV8Eqj/2uEoCbWzBig7ToT6cNBGLaXwcDIv12DmgL8w0dYQ
 eYnckEnUQe8Z8IiPsPe2MvGJtJbsIWrGrdwE9ZmsgbG6vX6Fn4BaGfTTzyiKcGBH
 dNuf4QVeF4IL2c8U9fbJ12JKOyNt2cYFXlZ54tK5y1eONt2E155YeL4ONyVBW2GP
 chWNX7YyqdCUz+lAMkzVfjlXZiZjpgZNGF97NGZ4lJjLACuSZZaSg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326jg1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KEeiMl024303;
 Mon, 20 Oct 2025 16:20:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjpfqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KGKUKa30605934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 16:20:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F02C58065;
 Mon, 20 Oct 2025 16:20:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 783E95806B;
 Mon, 20 Oct 2025 16:20:29 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.78.141])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 16:20:29 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 2/7] pc-bios/s390-ccw: Split virtio-ccw and generic virtio
Date: Mon, 20 Oct 2025 12:20:18 -0400
Message-ID: <20251020162023.3649165-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251020162023.3649165-1-jrossi@linux.ibm.com>
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f66151 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8
 a=_Mh3Q-wYLIVKI7ItX_UA:9 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7P03iFvHEKlT
 v2CZLhmlu+kYlhWrzz3iw6b3iobqtL5LFih2P8+eiB2LTjoFsAuB1Av9EoeLl/EH2mmmanJEjdX
 kgARyAAOSb95Vs/dUj8m+2uVifcJiSkKgmIlC+O18omEKigEjqjwsT1UIZdtTnRn2pMmkB7k3F0
 DqjmIyDlPD2yZSWAgP9bpLPLi9ofv9D05Lzscd2yTXVfVVB70YgvXqrggd7/6AU7vZHV2eilaNZ
 7MVhAbTfshcI14sjNVORh5FkaROOalIi6GZTnTZ0fpV8hJVtCDCSyRGYgPM11ty/u7yeRTWpe0B
 NYELdUJ0YNF2fBCnAb2HwN+V6qcAFSgEHJSBmLiIfd5Gr6kgfTTnFJP86HyoBWsml4eD4hpA9YH
 t/GopTYzbHIkTENJqBbIjtZWafd2MQ==
X-Proofpoint-GUID: GUM8vIbpWtcbC9uz5ebvhIGomHj15mIF
X-Proofpoint-ORIG-GUID: GUM8vIbpWtcbC9uz5ebvhIGomHj15mIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
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

Separate the CCW specific virtio routines and create generic wrappers for easier
reuse of existing virtio functions with non-CCW devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.h                   |   5 -
 include/hw/s390x/ipl/qipl.h      |   6 +
 pc-bios/s390-ccw/iplb.h          |   4 -
 pc-bios/s390-ccw/virtio-ccw.h    |  25 ++++
 pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
 pc-bios/s390-ccw/virtio.h        |  11 +-
 pc-bios/s390-ccw/main.c          |  13 +-
 pc-bios/s390-ccw/virtio-blkdev.c |  57 +++++---
 pc-bios/s390-ccw/virtio-ccw.c    | 240 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-net.c    |   5 +-
 pc-bios/s390-ccw/virtio-scsi.c   |   7 +-
 pc-bios/s390-ccw/virtio.c        | 209 +++++----------------------
 pc-bios/s390-ccw/Makefile        |   3 +-
 13 files changed, 367 insertions(+), 220 deletions(-)
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.h
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.c

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
index 6824391111..aadab87c2e 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,12 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+#define S390_IPL_TYPE_FCP 0x00
+#define S390_IPL_TYPE_CCW 0x02
+#define S390_IPL_TYPE_PCI 0x04
+#define S390_IPL_TYPE_PV 0x05
+#define S390_IPL_TYPE_QEMU_SCSI 0xff
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
diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/pc-bios/s390-ccw/virtio-ccw.h
new file mode 100644
index 0000000000..366c4812af
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-ccw.h
@@ -0,0 +1,25 @@
+/*
+ * Virtio definitions for CCW devices
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef VIRTIO_CCW_H
+#define VIRTIO_CCW_H
+
+/* main.c */
+extern SubChannelId blk_schid;
+
+/* virtio-ccw.c */
+int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli);
+int drain_irqs_ccw(SubChannelId schid);
+bool virtio_ccw_is_supported(SubChannelId schid);
+int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd);
+long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie);
+int virtio_ccw_setup(VDev *vdev);
+int virtio_ccw_reset(VDev *vdev);
+
+#endif
diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/pc-bios/s390-ccw/virtio-scsi.h
index c5612e16a2..7a37f8b45a 100644
--- a/pc-bios/s390-ccw/virtio-scsi.h
+++ b/pc-bios/s390-ccw/virtio-scsi.h
@@ -69,6 +69,6 @@ static inline bool virtio_scsi_response_ok(const VirtioScsiCmdResp *r)
 
 int virtio_scsi_read_many(VDev *vdev,
                           unsigned long sector, void *load_addr, int sec_num);
-int virtio_scsi_setup_device(SubChannelId schid);
+int virtio_scsi_setup_device(void);
 
 #endif /* VIRTIO_SCSI_H */
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 597bd42358..1c1017a0db 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -109,6 +109,8 @@ struct VRing {
 };
 typedef struct VRing VRing;
 
+char *virtio_get_ring_area(void);
+
 
 /***********************************************
  *               Virtio block                  *
@@ -138,6 +140,9 @@ typedef struct VRing VRing;
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER    0x80000000
 
+/* For device bus switches */
+extern int ipl_type;
+
 /* This is the first element of the read scatter-gather list. */
 struct VirtioBlkOuthdr {
         /* VIRTIO_BLK_T* */
@@ -236,6 +241,7 @@ struct VDev {
     int cmd_vr_idx;
     void *ring_area;
     long wait_reply_timeout;
+    VirtioDevType type;
     VirtioGDN guessed_disk_nature;
     SubChannelId schid;
     SenseId senseid;
@@ -268,8 +274,9 @@ struct VirtioCmd {
 };
 typedef struct VirtioCmd VirtioCmd;
 
+void vring_init(VRing *vr, VqInfo *info);
 bool vring_notify(VRing *vr);
-int drain_irqs(SubChannelId schid);
+int drain_irqs(VRing *vr);
 void vring_send_buf(VRing *vr, void *p, int len, int flags);
 int vr_poll(VRing *vr);
 int vring_wait_reply(void);
@@ -282,7 +289,7 @@ int virtio_net_init(void *mac_addr);
 void virtio_net_deinit(void);
 
 /* virtio-blkdev.c */
-int virtio_blk_setup_device(SubChannelId schid);
+int virtio_blk_setup_device(void);
 int virtio_read(unsigned long sector, void *load_addr);
 unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
                                  void *load_addr);
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 76bf743900..7299b8911f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -19,11 +19,12 @@
 #include "virtio-scsi.h"
 #include "dasd-ipl.h"
 
-static SubChannelId blk_schid = { .one = 1 };
+SubChannelId blk_schid = { .one = 1 };
 static char loadparm_str[LOADPARM_LEN + 1];
 QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 bool have_iplb;
+int ipl_type;
 static uint16_t cutype;
 LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
 
@@ -216,7 +217,7 @@ static bool find_boot_device(void)
     VDev *vdev = virtio_get_device();
     bool found = false;
 
-    switch (iplb.pbt) {
+    switch (ipl_type) {
     case S390_IPL_TYPE_CCW:
         vdev->scsi_device_selected = false;
         debug_print_int("device no. ", iplb.ccw.devno);
@@ -245,15 +246,15 @@ static int virtio_setup(void)
     vdev->is_cdrom = false;
     int ret;
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->type) {
     case VIRTIO_ID_NET:
         puts("Network boot device detected");
         return 0;
     case VIRTIO_ID_BLOCK:
-        ret = virtio_blk_setup_device(blk_schid);
+        ret = virtio_blk_setup_device();
         break;
     case VIRTIO_ID_SCSI:
-        ret = virtio_scsi_setup_device(blk_schid);
+        ret = virtio_scsi_setup_device();
         break;
     default:
         puts("\n! No IPL device available !\n");
@@ -316,11 +317,13 @@ void main(void)
     css_setup();
     have_iplb = store_iplb(&iplb);
     if (!have_iplb) {
+        ipl_type = S390_IPL_TYPE_CCW; /* Assume CCW for probing */
         boot_setup();
         probe_boot_device();
     }
 
     while (have_iplb) {
+        ipl_type = iplb.pbt;
         boot_setup();
         if (have_iplb && find_boot_device()) {
             ipl_boot_device();
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 4b819dd80f..df6a6d5b70 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "virtio-ccw.h"
 #include "virtio-scsi.h"
 
 #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
@@ -40,9 +41,10 @@ static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *load_add
                    VRING_DESC_F_WRITE | VRING_HIDDEN_IS_CHAIN);
 
     /* Now we can tell the host to read */
+    vring_notify(vr);
     vring_wait_reply();
 
-    if (drain_irqs(vr->schid)) {
+    if (drain_irqs(vr)) {
         /* Well, whatever status is supposed to contain... */
         status = 1;
     }
@@ -53,14 +55,14 @@ int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->type) {
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
@@ -119,7 +121,7 @@ void virtio_assume_iso9660(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->type) {
     case VIRTIO_ID_BLOCK:
         vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
         vdev->config.blk.blk_size = VIRTIO_ISO_BLOCK_SIZE;
@@ -129,6 +131,8 @@ void virtio_assume_iso9660(void)
     case VIRTIO_ID_SCSI:
         vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
         break;
+    default:
+        panic("Virtio device type mismatch for iso9660 IPL");
     }
 }
 
@@ -139,13 +143,15 @@ void virtio_assume_eckd(void)
     vdev->guessed_disk_nature = VIRTIO_GDN_DASD;
     vdev->blk_factor = 1;
     vdev->config.blk.physical_block_exp = 0;
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->type) {
     case VIRTIO_ID_BLOCK:
         vdev->config.blk.blk_size = VIRTIO_DASD_DEFAULT_BLOCK_SIZE;
         break;
     case VIRTIO_ID_SCSI:
         vdev->config.blk.blk_size = vdev->scsi_block_size;
         break;
+    default:
+        panic("Virtio device type mismatch for ECKD IPL");
     }
     vdev->config.blk.geometry.heads = 15;
     vdev->config.blk.geometry.sectors =
@@ -162,8 +168,7 @@ bool virtio_ipl_disk_is_valid(void)
         return true;
     }
 
-    return (vdev->senseid.cu_model == VIRTIO_ID_BLOCK ||
-            vdev->senseid.cu_model == VIRTIO_ID_SCSI) &&
+    return (vdev->type == VIRTIO_ID_BLOCK || vdev->type == VIRTIO_ID_SCSI) &&
            blksize >= 512 && blksize <= 4096;
 }
 
@@ -171,41 +176,44 @@ int virtio_get_block_size(void)
 {
     VDev *vdev = virtio_get_device();
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->type) {
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
+    switch (vdev->type) {
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
+    switch (vdev->type) {
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
@@ -213,24 +221,29 @@ uint64_t virtio_get_blocks(void)
     VDev *vdev = virtio_get_device();
     const uint64_t factor = virtio_get_block_size() / VIRTIO_SECTOR_SIZE;
 
-    switch (vdev->senseid.cu_model) {
+    switch (vdev->type) {
     case VIRTIO_ID_BLOCK:
         return vdev->config.blk.capacity / factor;
     case VIRTIO_ID_SCSI:
         return vdev->scsi_last_block / factor;
+    default:
+        return 0;
     }
-    return 0;
 }
 
-int virtio_blk_setup_device(SubChannelId schid)
+int virtio_blk_setup_device()
 {
     VDev *vdev = virtio_get_device();
 
-    vdev->guest_features[0] = VIRTIO_BLK_F_GEOMETRY | VIRTIO_BLK_F_BLK_SIZE;
-    vdev->schid = schid;
-    virtio_setup_ccw(vdev);
-
     puts("Using virtio-blk.");
 
-    return 0;
+    vdev->guest_features[0] = VIRTIO_BLK_F_GEOMETRY | VIRTIO_BLK_F_BLK_SIZE;
+    switch (ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        vdev->schid = blk_schid;
+        return virtio_ccw_setup(vdev);
+    }
+
+    return 1;
 }
diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.c
new file mode 100644
index 0000000000..1d6e8532f6
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-ccw.c
@@ -0,0 +1,240 @@
+/*
+ * Virtio functionality for CCW devices
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <string.h>
+#include "s390-ccw.h"
+#include "cio.h"
+#include "virtio.h"
+#include "virtio-ccw.h"
+#include "virtio-scsi.h"
+#include "bswap.h"
+#include "helper.h"
+#include "s390-time.h"
+
+/* virtio spec v1.0 para 4.3.3.2 */
+static long kvm_hypercall(unsigned long nr, unsigned long param1,
+                          unsigned long param2, unsigned long param3)
+{
+    register unsigned long r_nr asm("1") = nr;
+    register unsigned long r_param1 asm("2") = param1;
+    register unsigned long r_param2 asm("3") = param2;
+    register unsigned long r_param3 asm("4") = param3;
+    register long retval asm("2");
+
+    asm volatile ("diag %%r2,%%r4,0x500"
+                  : "=d" (retval)
+                  : "d" (r_nr), "0" (r_param1), "r"(r_param2), "d"(r_param3)
+                  : "memory", "cc");
+
+    return retval;
+}
+
+bool virtio_ccw_is_supported(SubChannelId schid)
+{
+    VDev *vdev = virtio_get_device();
+    vdev->schid = schid;
+    memset(&vdev->senseid, 0, sizeof(vdev->senseid));
+
+    /*
+     * Run sense id command.
+     * The size of the senseid data differs between devices (notably,
+     * between virtio devices and dasds), so specify the largest possible
+     * size and suppress the incorrect length indication for smaller sizes.
+     */
+    if (run_ccw(vdev, CCW_CMD_SENSE_ID, &vdev->senseid, sizeof(vdev->senseid),
+                true)) {
+        return false;
+    }
+
+    vdev->type = vdev->senseid.cu_model;
+
+    if (vdev->senseid.cu_type == 0x3832) {
+        switch (vdev->type) {
+        case VIRTIO_ID_BLOCK:
+        case VIRTIO_ID_SCSI:
+        case VIRTIO_ID_NET:
+            return true;
+        default:
+            return false;
+        }
+    }
+    return false;
+}
+
+int drain_irqs_ccw(SubChannelId schid)
+{
+    Irb irb = {};
+    int r = 0;
+
+    while (1) {
+        /* FIXME: make use of TPI, for that enable subchannel and isc */
+        if (tsch(schid, &irb)) {
+            /* Might want to differentiate error codes later on. */
+            if (irb.scsw.cstat) {
+                r = -EIO;
+            } else if (irb.scsw.dstat != 0xc) {
+                r = -EIO;
+            }
+            return r;
+        }
+    }
+}
+
+long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie)
+{
+    return kvm_hypercall(KVM_S390_VIRTIO_CCW_NOTIFY, *(u32 *)&schid,
+                         vq_idx, cookie);
+}
+
+int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd)
+{
+    VRing *vr = &vdev->vrings[vqid];
+    int i = 0;
+
+    do {
+        vring_send_buf(vr, cmd[i].data, cmd[i].size,
+                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
+    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
+
+    vring_wait_reply();
+    if (drain_irqs(vr)) {
+        return -1;
+    }
+    return 0;
+}
+
+int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
+{
+    Ccw1 ccw = {};
+
+    ccw.cmd_code = cmd;
+    ccw.cda = (long)ptr;
+    ccw.count = len;
+
+    if (sli) {
+        ccw.flags |= CCW_FLAG_SLI;
+    }
+
+    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
+}
+
+int virtio_ccw_reset(VDev *vdev)
+{
+    return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
+}
+
+int virtio_ccw_setup(VDev *vdev)
+{
+    int i, cfg_size = 0;
+    uint8_t status;
+    struct VirtioFeatureDesc {
+        uint32_t features;
+        uint8_t index;
+    } __attribute__((packed)) feats;
+
+    if (!virtio_is_supported(vdev->schid)) {
+        puts("Virtio unsupported for this device ID");
+        return -ENODEV;
+    }
+    /* device ID has been established now */
+
+    vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
+    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
+
+    virtio_reset(vdev);
+
+    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write ACKNOWLEDGE status to host");
+        return -EIO;
+    }
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_NET:
+        vdev->nr_vqs = 2;
+        vdev->cmd_vr_idx = 0;
+        cfg_size = sizeof(vdev->config.net);
+        break;
+    case VIRTIO_ID_BLOCK:
+        vdev->nr_vqs = 1;
+        vdev->cmd_vr_idx = 0;
+        cfg_size = sizeof(vdev->config.blk);
+        break;
+    case VIRTIO_ID_SCSI:
+        vdev->nr_vqs = 3;
+        vdev->cmd_vr_idx = VR_REQUEST;
+        cfg_size = sizeof(vdev->config.scsi);
+        break;
+    default:
+        puts("Unsupported virtio device");
+        return -ENODEV;
+    }
+
+    status |= VIRTIO_CONFIG_S_DRIVER;
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write DRIVER status to host");
+        return -EIO;
+    }
+
+    /* Feature negotiation */
+    for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
+        feats.features = 0;
+        feats.index = i;
+        if (run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), false)) {
+            puts("Could not get features bits");
+            return -EIO;
+        }
+
+        vdev->guest_features[i] &= bswap32(feats.features);
+        feats.features = bswap32(vdev->guest_features[i]);
+        if (run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), false)) {
+            puts("Could not set features bits");
+            return -EIO;
+        }
+    }
+
+    if (run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false)) {
+        puts("Could not get virtio device configuration");
+        return -EIO;
+    }
+
+    for (i = 0; i < vdev->nr_vqs; i++) {
+        VqInfo info = {
+            .queue = (unsigned long long) virtio_get_ring_area() + (i * VIRTIO_RING_SIZE),
+            .align = KVM_S390_VIRTIO_RING_ALIGN,
+            .index = i,
+            .num = 0,
+        };
+        VqConfig config = {
+            .index = i,
+            .num = 0,
+        };
+
+        if (run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config),
+                false)) {
+            puts("Could not get virtio device VQ config");
+            return -EIO;
+        }
+        info.num = config.num;
+        vring_init(&vdev->vrings[i], &info);
+        vdev->vrings[i].schid = vdev->schid;
+        if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
+            puts("Cannot set VQ info");
+            return -EIO;
+        }
+    }
+
+    status |= VIRTIO_CONFIG_S_DRIVER_OK;
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write DRIVER_OK status to host");
+        return -EIO;
+    }
+
+    return 0;
+}
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 301445bf97..604f1cf003 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -19,6 +19,7 @@
 #include <ethernet.h>
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "virtio-ccw.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -54,7 +55,7 @@ int virtio_net_init(void *mac_addr)
     rx_last_idx = 0;
 
     vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
-    virtio_setup_ccw(vdev);
+    virtio_ccw_setup(vdev);
 
     if (!(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT)) {
         puts("virtio-net device does not support the MAC address feature");
@@ -88,7 +89,7 @@ int send(int fd, const void *buf, int len, int flags)
     while (!vr_poll(txvq)) {
         yield();
     }
-    if (drain_irqs(txvq->schid)) {
+    if (drain_irqs(txvq)) {
         puts("send: drain irqs failed");
         return -1;
     }
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 71db75ce7b..4a615599fd 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "virtio-ccw.h"
 #include "scsi.h"
 #include "virtio-scsi.h"
 #include "s390-time.h"
@@ -476,12 +477,12 @@ static int virtio_scsi_setup(VDev *vdev)
     return 0;
 }
 
-int virtio_scsi_setup_device(SubChannelId schid)
+int virtio_scsi_setup_device()
 {
     VDev *vdev = virtio_get_device();
 
-    vdev->schid = schid;
-    virtio_setup_ccw(vdev);
+    vdev->schid = blk_schid;
+    virtio_ccw_setup(vdev);
 
     if (vdev->config.scsi.sense_size != VIRTIO_SCSI_SENSE_SIZE) {
         puts("Config: sense size mismatch");
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index cd6c99c7e3..05cfca4dad 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -13,6 +13,7 @@
 #include "cio.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
+#include "virtio-ccw.h"
 #include "bswap.h"
 #include "helper.h"
 #include "s390-time.h"
@@ -41,72 +42,30 @@ VDev *virtio_get_device(void)
 
 VirtioDevType virtio_get_device_type(void)
 {
-    return vdev.senseid.cu_model;
+    return vdev.type;
 }
 
-/* virtio spec v1.0 para 4.3.3.2 */
-static long kvm_hypercall(unsigned long nr, unsigned long param1,
-                          unsigned long param2, unsigned long param3)
+char *virtio_get_ring_area(void)
 {
-    register unsigned long r_nr asm("1") = nr;
-    register unsigned long r_param1 asm("2") = param1;
-    register unsigned long r_param2 asm("3") = param2;
-    register unsigned long r_param3 asm("4") = param3;
-    register long retval asm("2");
-
-    asm volatile ("diag %%r2,%%r4,0x500"
-                  : "=d" (retval)
-                  : "d" (r_nr), "0" (r_param1), "r"(r_param2), "d"(r_param3)
-                  : "memory", "cc");
-
-    return retval;
-}
-
-static long virtio_notify(SubChannelId schid, int vq_idx, long cookie)
-{
-    return kvm_hypercall(KVM_S390_VIRTIO_CCW_NOTIFY, *(u32 *)&schid,
-                         vq_idx, cookie);
+    return ring_area;
 }
 
 /***********************************************
  *             Virtio functions                *
  ***********************************************/
 
-int drain_irqs(SubChannelId schid)
-{
-    Irb irb = {};
-    int r = 0;
-
-    while (1) {
-        /* FIXME: make use of TPI, for that enable subchannel and isc */
-        if (tsch(schid, &irb)) {
-            /* Might want to differentiate error codes later on. */
-            if (irb.scsw.cstat) {
-                r = -EIO;
-            } else if (irb.scsw.dstat != 0xc) {
-                r = -EIO;
-            }
-            return r;
-        }
-    }
-}
-
-static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
+int drain_irqs(VRing *vr)
 {
-    Ccw1 ccw = {};
-
-    ccw.cmd_code = cmd;
-    ccw.cda = (long)ptr;
-    ccw.count = len;
-
-    if (sli) {
-        ccw.flags |= CCW_FLAG_SLI;
+    switch (ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return drain_irqs_ccw(vr->schid);
     }
 
-    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
+    return 0;
 }
 
-static void vring_init(VRing *vr, VqInfo *info)
+void vring_init(VRing *vr, VqInfo *info)
 {
     void *p = (void *) info->queue;
 
@@ -134,7 +93,12 @@ static void vring_init(VRing *vr, VqInfo *info)
 
 bool vring_notify(VRing *vr)
 {
-    vr->cookie = virtio_notify(vr->schid, vr->id, vr->cookie);
+    switch (ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        vr->cookie = virtio_ccw_notify(vr->schid, vr->id, vr->cookie);
+    }
+
     return vr->cookie >= 0;
 }
 
@@ -202,134 +166,24 @@ int vring_wait_reply(void)
 
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
 {
-    VRing *vr = &vdev->vrings[vqid];
-    int i = 0;
-
-    do {
-        vring_send_buf(vr, cmd[i].data, cmd[i].size,
-                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
-    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
-
-    vring_wait_reply();
-    if (drain_irqs(vr->schid)) {
-        return -1;
+    switch (ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return virtio_ccw_run(vdev, vqid, cmd);
     }
-    return 0;
-}
 
-int virtio_reset(VDev *vdev)
-{
-    return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
+    return -1;
 }
 
-int virtio_setup_ccw(VDev *vdev)
+int virtio_reset(VDev *vdev)
 {
-    int i, cfg_size = 0;
-    uint8_t status;
-    struct VirtioFeatureDesc {
-        uint32_t features;
-        uint8_t index;
-    } __attribute__((packed)) feats;
-
-    if (!virtio_is_supported(vdev->schid)) {
-        puts("Virtio unsupported for this device ID");
-        return -ENODEV;
+    switch (ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return virtio_ccw_reset(vdev);
     }
-    /* device ID has been established now */
-
-    vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
-    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
-
-    virtio_reset(vdev);
 
-    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
-    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
-        puts("Could not write ACKNOWLEDGE status to host");
-        return -EIO;
-    }
-
-    switch (vdev->senseid.cu_model) {
-    case VIRTIO_ID_NET:
-        vdev->nr_vqs = 2;
-        vdev->cmd_vr_idx = 0;
-        cfg_size = sizeof(vdev->config.net);
-        break;
-    case VIRTIO_ID_BLOCK:
-        vdev->nr_vqs = 1;
-        vdev->cmd_vr_idx = 0;
-        cfg_size = sizeof(vdev->config.blk);
-        break;
-    case VIRTIO_ID_SCSI:
-        vdev->nr_vqs = 3;
-        vdev->cmd_vr_idx = VR_REQUEST;
-        cfg_size = sizeof(vdev->config.scsi);
-        break;
-    default:
-        puts("Unsupported virtio device");
-        return -ENODEV;
-    }
-
-    status |= VIRTIO_CONFIG_S_DRIVER;
-    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
-        puts("Could not write DRIVER status to host");
-        return -EIO;
-    }
-
-    /* Feature negotiation */
-    for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
-        feats.features = 0;
-        feats.index = i;
-        if (run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), false)) {
-            puts("Could not get features bits");
-            return -EIO;
-        }
-
-        vdev->guest_features[i] &= bswap32(feats.features);
-        feats.features = bswap32(vdev->guest_features[i]);
-        if (run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), false)) {
-            puts("Could not set features bits");
-            return -EIO;
-        }
-    }
-
-    if (run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false)) {
-        puts("Could not get virtio device configuration");
-        return -EIO;
-    }
-
-    for (i = 0; i < vdev->nr_vqs; i++) {
-        VqInfo info = {
-            .queue = (unsigned long long) ring_area + (i * VIRTIO_RING_SIZE),
-            .align = KVM_S390_VIRTIO_RING_ALIGN,
-            .index = i,
-            .num = 0,
-        };
-        VqConfig config = {
-            .index = i,
-            .num = 0,
-        };
-
-        if (run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config),
-                false)) {
-            puts("Could not get virtio device VQ config");
-            return -EIO;
-        }
-        info.num = config.num;
-        vring_init(&vdev->vrings[i], &info);
-        vdev->vrings[i].schid = vdev->schid;
-        if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
-            puts("Cannot set VQ info");
-            return -EIO;
-        }
-    }
-
-    status |= VIRTIO_CONFIG_S_DRIVER_OK;
-    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
-        puts("Could not write DRIVER_OK status to host");
-        return -EIO;
-    }
-
-    return 0;
+    return -1;
 }
 
 bool virtio_is_supported(SubChannelId schid)
@@ -347,12 +201,17 @@ bool virtio_is_supported(SubChannelId schid)
                 true)) {
         return false;
     }
+
+    vdev.type = vdev.senseid.cu_model;
+
     if (vdev.senseid.cu_type == 0x3832) {
-        switch (vdev.senseid.cu_model) {
+        switch (vdev.type) {
         case VIRTIO_ID_BLOCK:
         case VIRTIO_ID_SCSI:
         case VIRTIO_ID_NET:
             return true;
+        default:
+            return false;
         }
     }
     return false;
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index a0f24c94a8..3577ac381a 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -34,7 +34,8 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 .PHONY : all clean build-all distclean
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
-	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
+      virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
+      virtio-ccw.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
-- 
2.49.0


