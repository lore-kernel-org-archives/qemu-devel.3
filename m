Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6C1CEBF63
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzD0-00036N-DS; Thu, 26 Sep 2024 20:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCy-0002z3-Jq; Thu, 26 Sep 2024 20:51:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCv-0007Hc-Q1; Thu, 26 Sep 2024 20:51:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG1riK018857;
 Fri, 27 Sep 2024 00:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=pjsOy5v4RY7Kx
 ugvGDD1gypGyUBMIafK8bhPD7Jiecc=; b=h2zjXPGB4ef0gBelAQmhDN++5Ue+S
 8VszAoQJM1pZNv1yYf6MRIX6QN9IZc962/Cqa/n720U5qg9GCGj0QHR4ffFhWA6P
 5DLCjJxxU374LFA+dczGaAJjRnfLeMui82XIo4qAXfBQSoTketkCkkHAAb5oz704
 P0K0TOBFDj4jIrWZxcfu2C7lJkn6bdmoVZoRWSkIqNcgAuulE1dn+ide7rO3OHAt
 t2IJ47ThnvqLv9ooVYHXvgk+aE8HyN3/HzwLKK7+Tk+MEsmt0Asd6NaeJn/JZ5li
 mQNOmoAAUSW3FNsYrq9pQWOv79XIlRrzmXzt2aiLcd+rqnHOtZ8QKbJwg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjs16ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pdhP008879;
 Fri, 27 Sep 2024 00:51:40 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjs16cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R0WxOM000636;
 Fri, 27 Sep 2024 00:51:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fv2c4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0pcsf41550082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70F6A58052;
 Fri, 27 Sep 2024 00:51:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF82358056;
 Fri, 27 Sep 2024 00:51:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:37 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 12/18] pc-bios/s390-ccw: Enable failed IPL to return after
 error
Date: Thu, 26 Sep 2024 20:51:11 -0400
Message-ID: <20240927005117.1679506-13-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kHsGbwZt-4qny2ymLFY0ZPeOlcWyO_hN
X-Proofpoint-ORIG-GUID: MurYYiWf4cjOhtGDv7_RRoIMsXziK63E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409270002
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove panic-on-error from IPL functions such that a return code is propagated
back to the main IPL calling function (rather than terminating immediately),
which facilitates possible error recovery in the future.

A select few panics remain, which indicate fatal non-devices errors that must
result in termination.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

---
 pc-bios/s390-ccw/s390-ccw.h      |  2 +-
 pc-bios/s390-ccw/virtio.h        |  2 +-
 pc-bios/s390-ccw/bootmap.c       | 53 ++++++++++++++++++--------
 pc-bios/s390-ccw/cio.c           |  3 +-
 pc-bios/s390-ccw/jump2ipl.c      |  5 ++-
 pc-bios/s390-ccw/main.c          | 35 +++++++++--------
 pc-bios/s390-ccw/virtio-blkdev.c |  8 ++--
 pc-bios/s390-ccw/virtio.c        | 65 +++++++++++++++++++++-----------
 8 files changed, 113 insertions(+), 60 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 8dac070257..7e49da46a5 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -78,7 +78,7 @@ void zipl_load(void);
 
 /* jump2ipl.c */
 void write_reset_psw(uint64_t psw);
-void jump_to_IPL_code(uint64_t address);
+int jump_to_IPL_code(uint64_t address);
 void jump_to_low_kernel(void);
 
 /* menu.c */
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 6f9a558ff5..9faf3986b1 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -274,7 +274,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags);
 int vr_poll(VRing *vr);
 int vring_wait_reply(void);
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
-void virtio_setup_ccw(VDev *vdev);
+int virtio_setup_ccw(VDev *vdev);
 
 int virtio_net_init(void *mac_addr);
 
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 9459e19ffb..6e1f47821e 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -62,15 +62,34 @@ static void *s2_prev_blk = _s2;
 static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
 static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
 
-static inline void verify_boot_info(BootInfo *bip)
+static inline int verify_boot_info(BootInfo *bip)
 {
-    IPL_assert(magic_match(bip->magic, ZIPL_MAGIC), "No zIPL sig in BootInfo");
-    IPL_assert(bip->version == BOOT_INFO_VERSION, "Wrong zIPL version");
-    IPL_assert(bip->bp_type == BOOT_INFO_BP_TYPE_IPL, "DASD is not for IPL");
-    IPL_assert(bip->dev_type == BOOT_INFO_DEV_TYPE_ECKD, "DASD is not ECKD");
-    IPL_assert(bip->flags == BOOT_INFO_FLAGS_ARCH, "Not for this arch");
-    IPL_assert(block_size_ok(bip->bp.ipl.bm_ptr.eckd.bptr.size),
-               "Bad block size in zIPL section of the 1st record.");
+    if (!magic_match(bip->magic, ZIPL_MAGIC)) {
+        puts("No zIPL sig in BootInfo");
+        return -EINVAL;
+    }
+    if (bip->version != BOOT_INFO_VERSION) {
+        puts("Wrong zIPL version");
+        return -EINVAL;
+    }
+    if (bip->bp_type != BOOT_INFO_BP_TYPE_IPL) {
+        puts("DASD is not for IPL");
+        return -ENODEV;
+    }
+    if (bip->dev_type != BOOT_INFO_DEV_TYPE_ECKD) {
+        puts("DASD is not ECKD");
+        return -ENODEV;
+    }
+    if (bip->flags != BOOT_INFO_FLAGS_ARCH) {
+        puts("Not for this arch");
+        return -EINVAL;
+    }
+    if (!block_size_ok(bip->bp.ipl.bm_ptr.eckd.bptr.size)) {
+        puts("Bad block size in zIPL section of 1st record");
+        return -EINVAL;
+    }
+
+    return 0;
 }
 
 static void eckd_format_chs(ExtEckdBlockPtr *ptr,  bool ldipl,
@@ -368,8 +387,8 @@ static int run_eckd_boot_script(block_number_t bmt_block_nr,
         puts("Unknown script entry type");
         return -EINVAL;
     }
-    write_reset_psw(bms->entry[i].address.load_address); /* no return */
-    jump_to_IPL_code(0); /* no return */
+    write_reset_psw(bms->entry[i].address.load_address);
+    jump_to_IPL_code(0);
     return 1;
 }
 
@@ -1054,16 +1073,19 @@ void zipl_load(void)
 
     if (vdev->is_cdrom) {
         ipl_iso_el_torito();
-        panic("\n! Cannot IPL this ISO image !\n");
+        puts("Failed to IPL this ISO image!");
+        return;
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
         netmain();
-        panic("\n! Cannot IPL from this network !\n");
+        puts("Failed to IPL from this network!");
+        return;
     }
 
     if (ipl_scsi()) {
-        panic("\n! Cannot IPL this device !\n");
+        puts("Failed to IPL from this device!");
+        return;
     }
 
     switch (virtio_get_device_type()) {
@@ -1074,8 +1096,9 @@ void zipl_load(void)
         zipl_load_vscsi();
         break;
     default:
-        panic("\n! Unknown IPL device type !\n");
+        puts("Unknown IPL device type!");
+        return;
     }
 
-    puts("zIPL load failed.");
+    puts("zIPL load failed!");
 }
diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 758e74965e..35b08ba7c1 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -59,7 +59,8 @@ uint16_t cu_type(SubChannelId schid)
     };
 
     if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sense_id_ccw), CCW_FMT1)) {
-        panic("Failed to run SenseID CCw\n");
+        puts("Failed to run SenseID CCW");
+        return CU_TYPE_UNKNOWN;
     }
 
     return sense_data.cu_type;
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 80b7f6a1f3..d45aec6694 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -33,7 +33,7 @@ static void jump_to_IPL_addr(void)
     /* should not return */
 }
 
-void jump_to_IPL_code(uint64_t address)
+int jump_to_IPL_code(uint64_t address)
 {
     /* store the subsystem information _after_ the bootmap was loaded */
     write_subsystem_identification();
@@ -68,7 +68,8 @@ void jump_to_IPL_code(uint64_t address)
     asm volatile("lghi %%r1,1\n\t"
                  "diag %%r1,%%r1,0x308\n\t"
                  : : : "1", "memory");
-    panic("\n! IPL returns !\n");
+    puts("IPL code jump failed");
+    return 1;
 }
 
 void jump_to_low_kernel(void)
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 2345432abb..f818bd7210 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -77,6 +77,9 @@ static int is_dev_possibly_bootable(int dev_no, int sch_no)
 
     enable_subchannel(blk_schid);
     cutype = cu_type(blk_schid);
+    if (cutype == CU_TYPE_UNKNOWN) {
+        return -EIO;
+    }
 
     /*
      * Note: we always have to run virtio_is_supported() here to make
@@ -194,10 +197,10 @@ static void boot_setup(void)
     have_iplb = store_iplb(&iplb);
 }
 
-static void find_boot_device(void)
+static bool find_boot_device(void)
 {
     VDev *vdev = virtio_get_device();
-    bool found;
+    bool found = false;
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
@@ -215,10 +218,10 @@ static void find_boot_device(void)
         found = find_subch(iplb.scsi.devno);
         break;
     default:
-        panic("List-directed IPL not supported yet!\n");
+        puts("Invalid IPLB");
     }
 
-    IPL_assert(found, "Boot device not found\n");
+    return found;
 }
 
 static int virtio_setup(void)
@@ -244,11 +247,13 @@ static int virtio_setup(void)
         ret = virtio_scsi_setup_device(blk_schid);
         break;
     default:
-        panic("\n! No IPL device available !\n");
+        puts("\n! No IPL device available !\n");
+        return 1;
     }
 
-    if (!ret) {
-        IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
+    if (!ret && !virtio_ipl_disk_is_valid()) {
+        puts("No valid IPL device detected");
+        return -ENODEV;
     }
 
     return ret;
@@ -259,16 +264,16 @@ static void ipl_boot_device(void)
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-        dasd_ipl(blk_schid, cutype); /* no return */
+        dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
-        if (virtio_setup() == 0) {
-            zipl_load();             /* Only returns in case of errors */
+        if (virtio_setup()) {
+            return;    /* Only returns in case of errors */
         }
+        zipl_load();
         break;
     default:
         printf("Attempting to boot from unexpected device type 0x%X", cutype);
-        panic("\nBoot failed.\n");
     }
 }
 
@@ -288,7 +293,8 @@ static void probe_boot_device(void)
                 break;
             }
             if (ret == true) {
-                ipl_boot_device();      /* Only returns if unsuccessful */
+                ipl_boot_device(); /* Only returns if unsuccessful */
+                return;
             }
         }
     }
@@ -301,12 +307,11 @@ void main(void)
     sclp_setup();
     css_setup();
     boot_setup();
-    if (have_iplb) {
-        find_boot_device();
+    if (have_iplb && find_boot_device()) {
         ipl_boot_device();
     } else {
         probe_boot_device();
     }
 
-    panic("Failed to load OS from hard disk\n");
+    panic("Failed to IPL. Halting...");
 }
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 2666326801..5ef273bdc0 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -59,8 +59,8 @@ int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
     case VIRTIO_ID_SCSI:
         return virtio_scsi_read_many(vdev, sector, load_addr, sec_num);
     }
-    panic("\n! No readable IPL device !\n");
-    return -1;
+
+    return 1;
 }
 
 unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list2,
@@ -73,13 +73,13 @@ unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long rec_list
     unsigned long addr = (unsigned long)load_addr;
 
     if (sec_len != virtio_get_block_size()) {
-        return -1;
+        return 0;
     }
 
     printf(".");
     status = virtio_read_many(sec, (void *)addr, sec_num);
     if (status) {
-        panic("I/O Error");
+        return 0;
     }
     addr += sec_num * virtio_get_block_size();
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 8c6b0a8a92..e3fdb95b3c 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -217,16 +217,19 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
     return 0;
 }
 
-void virtio_setup_ccw(VDev *vdev)
+int virtio_setup_ccw(VDev *vdev)
 {
-    int i, rc, cfg_size = 0;
+    int i, cfg_size = 0;
     uint8_t status;
     struct VirtioFeatureDesc {
         uint32_t features;
         uint8_t index;
     } __attribute__((packed)) feats;
 
-    IPL_assert(virtio_is_supported(vdev->schid), "PE");
+    if (!virtio_is_supported(vdev->schid)) {
+        puts("PE");
+        return -ENODEV;
+    }
     /* device ID has been established now */
 
     vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
@@ -235,8 +238,10 @@ void virtio_setup_ccw(VDev *vdev)
     run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
 
     status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
-    rc = run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false);
-    IPL_assert(rc == 0, "Could not write ACKNOWLEDGE status to host");
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write ACKNOWLEDGE status to host");
+        return -EIO;
+    }
 
     switch (vdev->senseid.cu_model) {
     case VIRTIO_ID_NET:
@@ -255,27 +260,37 @@ void virtio_setup_ccw(VDev *vdev)
         cfg_size = sizeof(vdev->config.scsi);
         break;
     default:
-        panic("Unsupported virtio device\n");
+        puts("Unsupported virtio device");
+        return -ENODEV;
     }
 
     status |= VIRTIO_CONFIG_S_DRIVER;
-    rc = run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false);
-    IPL_assert(rc == 0, "Could not write DRIVER status to host");
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write DRIVER status to host");
+        return -EIO;
+    }
 
     /* Feature negotiation */
     for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
         feats.features = 0;
         feats.index = i;
-        rc = run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), false);
-        IPL_assert(rc == 0, "Could not get features bits");
+        if (run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), false)) {
+            puts("Could not get features bits");
+            return -EIO;
+        }
+
         vdev->guest_features[i] &= bswap32(feats.features);
         feats.features = bswap32(vdev->guest_features[i]);
-        rc = run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), false);
-        IPL_assert(rc == 0, "Could not set features bits");
+        if (run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), false)) {
+            puts("Could not set features bits");
+            return -EIO;
+        }
     }
 
-    rc = run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false);
-    IPL_assert(rc == 0, "Could not get virtio device configuration");
+    if (run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, false)) {
+        puts("Could not get virtio device configuration");
+        return -EIO;
+    }
 
     for (i = 0; i < vdev->nr_vqs; i++) {
         VqInfo info = {
@@ -289,19 +304,27 @@ void virtio_setup_ccw(VDev *vdev)
             .num = 0,
         };
 
-        rc = run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config), false);
-        IPL_assert(rc == 0, "Could not get virtio device VQ configuration");
+        if (run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, sizeof(config),
+                false)) {
+            puts("Could not get virtio device VQ config");
+            return -EIO;
+        }
         info.num = config.num;
         vring_init(&vdev->vrings[i], &info);
         vdev->vrings[i].schid = vdev->schid;
-        IPL_assert(
-            run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false) == 0,
-            "Cannot set VQ info");
+        if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
+            puts("Cannot set VQ info");
+            return -EIO;
+        }
     }
 
     status |= VIRTIO_CONFIG_S_DRIVER_OK;
-    rc = run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false);
-    IPL_assert(rc == 0, "Could not write DRIVER_OK status to host");
+    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), false)) {
+        puts("Could not write DRIVER_OK status to host");
+        return -EIO;
+    }
+
+    return 0;
 }
 
 bool virtio_is_supported(SubChannelId schid)
-- 
2.45.1


