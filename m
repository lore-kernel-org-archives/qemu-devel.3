Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13270EDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcSm-0002Ri-KN; Tue, 03 Mar 2026 21:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSa-0002OQ-HT; Tue, 03 Mar 2026 21:59:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSX-0000WB-IN; Tue, 03 Mar 2026 21:59:40 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623G0gIw1508241; Wed, 4 Mar 2026 02:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wUGCJWsfEAwiQuSpw
 scY/VDFMxFSZL5ZLYrjjH0Cwys=; b=Qey4qaKDnpVThaLwENZD26aMGi3kKJX1G
 zxyPXYQSvEoNeFy5C4sN51VAkSajuNvtCtKb5oUXB5v63UgMNc9hVt80cCDn8kFf
 4exffrAvj0np0ySNrePrebKQwyTlfQgFj1kyg8iq7Za/FtiIqbWhf5PaqoCWD5H+
 XjIg66JCwwjvRl7YQwzivO7QEUEHmSBMZV/ha2ZfnhbtaOQPDcDyuIvPaXZleZmI
 mugLtFWzwoGzumXT+TNgh17qCt/fcYHWO6sBbg0GwGFdsOYTooMnxzB6B959gHUL
 pnbmwuXG6Slt9yvzFTTBESbbXQupcebd06whHQjujTk4zQpzIJZ7w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3wc72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623MFvt7003266;
 Wed, 4 Mar 2026 02:59:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y54t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xXKg42336610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C30E458053;
 Wed,  4 Mar 2026 02:59:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BED058043;
 Wed,  4 Mar 2026 02:59:32 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:32 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 06/15] pc-bios/s390-ccw: Split virtio-ccw and generic virtio
Date: Tue,  3 Mar 2026 21:59:08 -0500
Message-ID: <20260304025917.2157032-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KJ4pEvQPa8SgbX-HCmG1dp1lppO3f7ah
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX6tbqJwjI6H8Z
 h3QCzjAiIdlZ6fpg2hOxBy7IIiy2CNEvpYINB/nVAArw8P5AG+pak+K9Y6GHCWDkCUMwafARAD8
 Q/3eLbwsh5pcmd6F8Wi5W8fcBtmGPgs8wsz4CgTr2q1BZ+rvap8T+l1q3Pchqopztcv2Pxt/jGW
 0SsMkFof1kwMxe739Vvelu966lyLpQ88j84yjAnzuD5ki+L/cKdFCOXdlO9Q/Ck3cVPHqwG9RvV
 465iQzOEJpq80XA3wIzLOPGK68BO3SiBgQnZ/u5dGkCFMsX+wkb+sC0+zQeVxNA3HiUavKFf2ae
 Z2L4G7iH3tGQfqgTSiCaNmnlO5a7nyPO1MkMVX7dlgknuVh05dTzW/V9RpU1Tl4xVKYhhP2QIBY
 hGtU2XFAMtNprSHyi/I3Qc+A81rOPf2tvynLoeLLrlYa0LKY65Xj91ghLzpCWClRm1MquXG55WM
 ybwMOkjyh+9R1DMJcmw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a7a018 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8
 a=J5HRprwtwPFiPHPCACwA:9 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-GUID: KJ4pEvQPa8SgbX-HCmG1dp1lppO3f7ah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Separate the CCW specific virtio routines and create generic wrappers for easier
reuse of existing virtio functions with non-CCW devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile        |   3 +-
 pc-bios/s390-ccw/main.c          |   8 +-
 pc-bios/s390-ccw/netmain.c       |   2 +-
 pc-bios/s390-ccw/s390-ccw.h      |   3 -
 pc-bios/s390-ccw/virtio-blkdev.c |  15 +-
 pc-bios/s390-ccw/virtio-ccw.c    | 241 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h    |  24 +++
 pc-bios/s390-ccw/virtio-net.c    |   3 +-
 pc-bios/s390-ccw/virtio-scsi.c   |   8 +-
 pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
 pc-bios/s390-ccw/virtio.c        | 239 +++++-------------------------
 pc-bios/s390-ccw/virtio.h        |   5 +-
 12 files changed, 332 insertions(+), 221 deletions(-)
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.c
 create mode 100644 pc-bios/s390-ccw/virtio-ccw.h

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index a0f24c94a8..259cff09db 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -34,7 +34,8 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
 .PHONY : all clean build-all distclean
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
-	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
+	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
+	  virtio-ccw.o
 
 SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index b3b16f845b..c5ee575385 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -71,6 +71,7 @@ static int is_dev_possibly_bootable(int dev_no, int sch_no)
     bool is_virtio;
     Schib schib;
     int r;
+    VDev *vdev = virtio_get_device();
 
     blk_schid.sch_no = sch_no;
     r = stsch_err(blk_schid, &schib);
@@ -91,7 +92,8 @@ static int is_dev_possibly_bootable(int dev_no, int sch_no)
      * Note: we always have to run virtio_is_supported() here to make
      * sure that the vdev.senseid data gets pre-initialized correctly
      */
-    is_virtio = virtio_is_supported(blk_schid);
+    vdev->schid = blk_schid;
+    is_virtio = virtio_is_supported(vdev);
 
     /* No specific devno given, just return whether the device is possibly bootable */
     if (dev_no < 0) {
@@ -255,10 +257,10 @@ static int virtio_setup(void)
         puts("Network boot device detected");
         return 0;
     case VIRTIO_ID_BLOCK:
-        ret = virtio_blk_setup_device(blk_schid);
+        ret = virtio_blk_setup_device(vdev);
         break;
     case VIRTIO_ID_SCSI:
-        ret = virtio_scsi_setup_device(blk_schid);
+        ret = virtio_scsi_setup_device(vdev);
         break;
     default:
         puts("\n! No IPL device available !\n");
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index a9521dff41..651cedf6ef 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -500,7 +500,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
             continue;
         }
         enable_subchannel(net_schid);
-        if (!virtio_is_supported(net_schid)) {
+        if (!virtio_is_supported(virtio_get_device())) {
             continue;
         }
         if (virtio_get_device_type() != VIRTIO_ID_NET) {
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 47ea66bd4d..ccd68ff0a4 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -66,9 +66,6 @@ void sclp_setup(void);
 void sclp_get_loadparm_ascii(char *loadparm);
 int sclp_read(char *str, size_t count);
 
-/* virtio.c */
-bool virtio_is_supported(SubChannelId schid);
-
 /* bootmap.c */
 void zipl_load(void);
 
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 9cc40e9108..9722b6970f 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -12,6 +12,7 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
+#include "virtio-ccw.h"
 
 #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
 #define VIRTIO_BLK_F_BLK_SIZE   (1 << 6)
@@ -229,15 +230,17 @@ uint64_t virtio_get_blocks(void)
     }
 }
 
-int virtio_blk_setup_device(SubChannelId schid)
+int virtio_blk_setup_device(VDev *vdev)
 {
-    VDev *vdev = virtio_get_device();
-
     vdev->guest_features[0] = VIRTIO_BLK_F_GEOMETRY | VIRTIO_BLK_F_BLK_SIZE;
-    vdev->schid = schid;
-    virtio_setup_ccw(vdev);
 
     puts("Using virtio-blk.");
 
-    return 0;
+    switch (vdev->ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return virtio_ccw_setup(vdev);
+    default:
+        return 1;
+    }
 }
diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.c
new file mode 100644
index 0000000000..ab98da90c3
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-ccw.c
@@ -0,0 +1,241 @@
+/*
+ * Virtio functionality for CCW devices
+ *
+ * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
+ * Copyright 2025 IBM Corp.
+ *
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
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
+static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
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
+bool virtio_ccw_is_supported(VDev *vdev)
+{
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
+    vdev->dev_type = vdev->senseid.cu_model;
+
+    if (vdev->senseid.cu_type == 0x3832) {
+        switch (vdev->dev_type) {
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
+    if (drain_irqs()) {
+        return -1;
+    }
+    return 0;
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
+    if (!virtio_ccw_is_supported(vdev)) {
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
+    switch (vdev->dev_type) {
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
+            .queue = (unsigned long long) virtio_get_ring_area(i),
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
diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/pc-bios/s390-ccw/virtio-ccw.h
new file mode 100644
index 0000000000..a506767eaa
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-ccw.h
@@ -0,0 +1,24 @@
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
+int drain_irqs_ccw(SubChannelId schid);
+bool virtio_ccw_is_supported(VDev *vdev);
+int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd);
+long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie);
+int virtio_ccw_setup(VDev *vdev);
+int virtio_ccw_reset(VDev *vdev);
+
+#endif
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 7eb0850069..f58f7ffc55 100644
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
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 71db75ce7b..9ea00c6fe6 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -15,6 +15,7 @@
 #include "virtio.h"
 #include "scsi.h"
 #include "virtio-scsi.h"
+#include "virtio-ccw.h"
 #include "s390-time.h"
 #include "helper.h"
 
@@ -476,12 +477,9 @@ static int virtio_scsi_setup(VDev *vdev)
     return 0;
 }
 
-int virtio_scsi_setup_device(SubChannelId schid)
+int virtio_scsi_setup_device(VDev *vdev)
 {
-    VDev *vdev = virtio_get_device();
-
-    vdev->schid = schid;
-    virtio_setup_ccw(vdev);
+    virtio_ccw_setup(vdev);
 
     if (vdev->config.scsi.sense_size != VIRTIO_SCSI_SENSE_SIZE) {
         puts("Config: sense size mismatch");
diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/pc-bios/s390-ccw/virtio-scsi.h
index c5612e16a2..070f24b7e5 100644
--- a/pc-bios/s390-ccw/virtio-scsi.h
+++ b/pc-bios/s390-ccw/virtio-scsi.h
@@ -69,6 +69,6 @@ static inline bool virtio_scsi_response_ok(const VirtioScsiCmdResp *r)
 
 int virtio_scsi_read_many(VDev *vdev,
                           unsigned long sector, void *load_addr, int sec_num);
-int virtio_scsi_setup_device(SubChannelId schid);
+int virtio_scsi_setup_device(VDev *vdev);
 
 #endif /* VIRTIO_SCSI_H */
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 5dd407d5c9..956b34ff33 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -2,6 +2,9 @@
  * Virtio driver bits
  *
  * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
+ * Copyright 2025 IBM Corp.
+ *
+ * Author(s): Jared Rossi <jrossi@linux.ibm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
  * your option) any later version. See the COPYING file in the top-level
@@ -13,6 +16,7 @@
 #include "cio.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
+#include "virtio-ccw.h"
 #include "bswap.h"
 #include "helper.h"
 #include "s390-time.h"
@@ -44,28 +48,9 @@ VirtioDevType virtio_get_device_type(void)
     return vdev.dev_type;
 }
 
-/* virtio spec v1.0 para 4.3.3.2 */
-static long kvm_hypercall(unsigned long nr, unsigned long param1,
-                          unsigned long param2, unsigned long param3)
+char *virtio_get_ring_area(int ring_num)
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
+    return ring_area + ring_num * VIRTIO_RING_SIZE;
 }
 
 /***********************************************
@@ -74,39 +59,27 @@ static long virtio_notify(SubChannelId schid, int vq_idx, long cookie)
 
 int drain_irqs(void)
 {
-    Irb irb = {};
-    int r = 0;
-
-    while (1) {
-        /* FIXME: make use of TPI, for that enable subchannel and isc */
-        if (tsch(vdev.schid, &irb)) {
-            /* Might want to differentiate error codes later on. */
-            if (irb.scsw.cstat) {
-                r = -EIO;
-            } else if (irb.scsw.dstat != 0xc) {
-                r = -EIO;
-            }
-            return r;
-        }
+    switch (vdev.ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return drain_irqs_ccw(vdev.schid);
+    default:
+        return 0;
     }
 }
 
-static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
+int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
 {
-    Ccw1 ccw = {};
-
-    ccw.cmd_code = cmd;
-    ccw.cda = (long)ptr;
-    ccw.count = len;
-
-    if (sli) {
-        ccw.flags |= CCW_FLAG_SLI;
+    switch (vdev->ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return virtio_ccw_run(vdev, vqid, cmd);
+    default:
+        return -1;
     }
-
-    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
 }
 
-static void vring_init(VRing *vr, VqInfo *info)
+void vring_init(VRing *vr, VqInfo *info)
 {
     void *p = (void *) info->queue;
 
@@ -134,7 +107,15 @@ static void vring_init(VRing *vr, VqInfo *info)
 
 bool vring_notify(VRing *vr)
 {
-    vr->cookie = virtio_notify(vdev.schid, vr->id, vr->cookie);
+    switch (vdev.ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
+        break;
+    default:
+        return 1;
+    }
+
     return vr->cookie >= 0;
 }
 
@@ -200,164 +181,24 @@ int vring_wait_reply(void)
     return 1;
 }
 
-int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
-{
-    VRing *vr = &vdev->vrings[vqid];
-    int i = 0;
-
-    do {
-        vring_send_buf(vr, cmd[i].data, cmd[i].size,
-                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
-    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
-
-    vring_wait_reply();
-    if (drain_irqs()) {
-        return -1;
-    }
-    return 0;
-}
-
 int virtio_reset(VDev *vdev)
 {
-    return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
-}
-
-int virtio_setup_ccw(VDev *vdev)
-{
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
-    }
-    /* device ID has been established now */
-
-    vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
-    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
-
-    virtio_reset(vdev);
-
-    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
-    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
-        puts("Could not write ACKNOWLEDGE status to host");
-        return -EIO;
-    }
-
-    switch (vdev->dev_type) {
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
+    switch (vdev->ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return virtio_ccw_reset(vdev);
     default:
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
+        return -1;
     }
-
-    return 0;
 }
 
-bool virtio_is_supported(SubChannelId schid)
+bool virtio_is_supported(VDev *vdev)
 {
-    vdev.schid = schid;
-    memset(&vdev.senseid, 0, sizeof(vdev.senseid));
-
-    /*
-     * Run sense id command.
-     * The size of the senseid data differs between devices (notably,
-     * between virtio devices and dasds), so specify the largest possible
-     * size and suppress the incorrect length indication for smaller sizes.
-     */
-    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid),
-                true)) {
+    switch (vdev->ipl_type) {
+    case S390_IPL_TYPE_QEMU_SCSI:
+    case S390_IPL_TYPE_CCW:
+        return virtio_ccw_is_supported(vdev);
+    default:
         return false;
     }
-
-    vdev.dev_type = vdev.senseid.cu_model;
-
-    if (vdev.senseid.cu_type == 0x3832) {
-        switch (vdev.dev_type) {
-        case VIRTIO_ID_BLOCK:
-        case VIRTIO_ID_SCSI:
-        case VIRTIO_ID_NET:
-            return true;
-        default:
-            return false;
-        }
-    }
-    return false;
 }
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 39b507b221..c3cb5a6ee3 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -108,6 +108,7 @@ struct VRing {
 };
 typedef struct VRing VRing;
 
+char *virtio_get_ring_area(int ring_num);
 
 /***********************************************
  *               Virtio block                  *
@@ -269,6 +270,8 @@ struct VirtioCmd {
 };
 typedef struct VirtioCmd VirtioCmd;
 
+void vring_init(VRing *vr, VqInfo *info);
+bool virtio_is_supported(VDev *vdev);
 bool vring_notify(VRing *vr);
 int drain_irqs(void);
 void vring_send_buf(VRing *vr, void *p, int len, int flags);
@@ -283,7 +286,7 @@ int virtio_net_init(void *mac_addr);
 void virtio_net_deinit(void);
 
 /* virtio-blkdev.c */
-int virtio_blk_setup_device(SubChannelId schid);
+int virtio_blk_setup_device(VDev *vdev);
 int virtio_read(unsigned long sector, void *load_addr);
 unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
                                  void *load_addr);
-- 
2.52.0


