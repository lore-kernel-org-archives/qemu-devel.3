Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE16CCED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxypo-00048I-02; Mon, 07 Oct 2024 21:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypj-00045n-J9; Mon, 07 Oct 2024 21:16:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypg-0008IP-Rj; Mon, 07 Oct 2024 21:16:15 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4980nwv8008385;
 Tue, 8 Oct 2024 01:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=H4vxHDbCL8uUY
 yzg5wzTi+DxZD9HqPpMlYlSNGuAaWs=; b=JmNI23oo2sn0y2gent9DOXri61pCF
 Z9my2VQSMu2HjVd/2sAPtorgCkW0wjErgVCjyz7Shtvi9raSTPHfMdwPuma3g5ss
 HhfEKivN1TKySlGLra+wxVr3YkP/PE2R64Qy/3NrhhfUn54RnOSfEmz5E3BNk2D4
 xELsnsGrYD3GfaxmLsdOqO0aQIcU4AbfxS7u/lZwHDtxGiIUZbNRO0UoBg3qphoj
 +twJ8rNPj1mpONML+hB9R+yvzCnC2TsZ1h2XjXorYn+bweGiyoBNUA/fScQYFJiF
 ipZcCoiaM8VP5P7JPygRjTJ4Vg30c68J+5DOBC3j7jdBa+uFLmjPYZUVw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424thq02k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981GBQX026895;
 Tue, 8 Oct 2024 01:16:11 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424thq02k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4980smWH013807;
 Tue, 8 Oct 2024 01:16:10 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss1r3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981G9N246793028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67FCA58059;
 Tue,  8 Oct 2024 01:16:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC64158043;
 Tue,  8 Oct 2024 01:16:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:08 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 09/19] pc-bios/s390-ccw: Remove panics from SCSI IPL path
Date: Mon,  7 Oct 2024 21:15:42 -0400
Message-ID: <20241008011552.2645520-10-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sTKXF9Db4GPhgG7zpi-MDumI4CaPzxQz
X-Proofpoint-GUID: EvsN-zoFTvx5QA2S2QwIRY9pNgwGdG7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080006
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Remove panic-on-error from virtio-scsi IPL specific functions so that error
recovery may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c       |  88 +++++++++++++-----
 pc-bios/s390-ccw/jump2ipl.c      |   1 +
 pc-bios/s390-ccw/virtio-blkdev.c |   4 +-
 pc-bios/s390-ccw/virtio-scsi.c   | 148 +++++++++++++++++++++----------
 4 files changed, 169 insertions(+), 72 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 266b38c034..534d900f9e 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -591,7 +591,7 @@ static int ipl_eckd(void)
  * IPL a SCSI disk
  */
 
-static void zipl_load_segment(ComponentEntry *entry)
+static int zipl_load_segment(ComponentEntry *entry)
 {
     const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
     ScsiBlockPtr *bprs = (void *)sec;
@@ -611,7 +611,10 @@ static void zipl_load_segment(ComponentEntry *entry)
     do {
         memset(bprs, FREE_SPACE_FILLER, bprs_size);
         fill_hex_val(blk_no, &blockno, sizeof(blockno));
-        read_block(blockno, bprs, err_msg);
+        if (virtio_read(blockno, bprs)) {
+            puts(err_msg);
+            return -EIO;
+        }
 
         for (i = 0;; i++) {
             uint64_t *cur_desc = (void *)&bprs[i];
@@ -639,23 +642,37 @@ static void zipl_load_segment(ComponentEntry *entry)
             }
             address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
                                          (void *)address);
-            IPL_assert(address != -1, "zIPL load segment failed");
+            if (!address) {
+                puts("zIPL load segment failed");
+                return -EIO;
+            }
         }
     } while (blockno);
+
+    return 0;
 }
 
 /* Run a zipl program */
-static void zipl_run(ScsiBlockPtr *pte)
+static int zipl_run(ScsiBlockPtr *pte)
 {
     ComponentHeader *header;
     ComponentEntry *entry;
     uint8_t tmp_sec[MAX_SECTOR_SIZE];
 
-    read_block(pte->blockno, tmp_sec, "Cannot read header");
+    if (virtio_read(pte->blockno, tmp_sec)) {
+        puts("Cannot read header");
+        return -EIO;
+    }
     header = (ComponentHeader *)tmp_sec;
 
-    IPL_assert(magic_match(tmp_sec, ZIPL_MAGIC), "No zIPL magic in header");
-    IPL_assert(header->type == ZIPL_COMP_HEADER_IPL, "Bad header type");
+    if (!magic_match(tmp_sec, ZIPL_MAGIC)) {
+        puts("No zIPL magic in header");
+        return -EINVAL;
+    }
+    if (header->type != ZIPL_COMP_HEADER_IPL) {
+        puts("Bad header type");
+        return -EINVAL;
+    }
 
     dputs("start loading images\n");
 
@@ -670,22 +687,30 @@ static void zipl_run(ScsiBlockPtr *pte)
             continue;
         }
 
-        zipl_load_segment(entry);
+        if (zipl_load_segment(entry)) {
+            return 1;
+        }
 
         entry++;
 
-        IPL_assert((uint8_t *)(&entry[1]) <= (tmp_sec + MAX_SECTOR_SIZE),
-                   "Wrong entry value");
+        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {
+            puts("Wrong entry value");
+            return -EINVAL;
+        }
     }
 
-    IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
+    if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
+        puts("No EXEC entry");
+        return -EINVAL;
+    }
 
     /* should not return */
     write_reset_psw(entry->compdat.load_psw);
     jump_to_IPL_code(0);
+    return 1;
 }
 
-static void ipl_scsi(void)
+static int ipl_scsi(void)
 {
     ScsiMbr *mbr = (void *)sec;
     int program_table_entries = 0;
@@ -696,10 +721,13 @@ static void ipl_scsi(void)
 
     /* Grab the MBR */
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(0, mbr, "Cannot read block 0");
+    if (virtio_read(0, mbr)) {
+        puts("Cannot read block 0");
+        return -EIO;
+    }
 
     if (!magic_match(mbr->magic, ZIPL_MAGIC)) {
-        return;
+        return 0;
     }
 
     puts("Using SCSI scheme.");
@@ -707,11 +735,20 @@ static void ipl_scsi(void)
     IPL_check(mbr->version_id == 1,
               "Unknown MBR layout version, assuming version 1");
     debug_print_int("program table", mbr->pt.blockno);
-    IPL_assert(mbr->pt.blockno, "No Program Table");
+    if (!mbr->pt.blockno) {
+        puts("No Program Table");
+        return -EINVAL;
+    }
 
     /* Parse the program table */
-    read_block(mbr->pt.blockno, sec, "Error reading Program Table");
-    IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
+    if (virtio_read(mbr->pt.blockno, sec)) {
+        puts("Error reading Program Table");
+        return -EIO;
+    }
+    if (!magic_match(sec, ZIPL_MAGIC)) {
+        puts("No zIPL magic in Program Table");
+        return -EINVAL;
+    }
 
     for (i = 0; i < MAX_BOOT_ENTRIES; i++) {
         if (prog_table->entry[i].scsi.blockno) {
@@ -721,17 +758,22 @@ static void ipl_scsi(void)
     }
 
     debug_print_int("program table entries", program_table_entries);
-    IPL_assert(program_table_entries != 0, "Empty Program Table");
+    if (program_table_entries == 0) {
+        puts("Empty Program Table");
+        return -EINVAL;
+    }
 
     if (menu_is_enabled_enum()) {
         loadparm = menu_get_enum_boot_index(valid_entries);
     }
 
     debug_print_int("loadparm", loadparm);
-    IPL_assert(loadparm < MAX_BOOT_ENTRIES, "loadparm value greater than"
-               " maximum number of boot entries allowed");
+    if (loadparm >= MAX_BOOT_ENTRIES) {
+        puts("loadparm value greater than max number of boot entries allowed");
+        return -EINVAL;
+    }
 
-    zipl_run(&prog_table->entry[loadparm].scsi); /* no return */
+    return zipl_run(&prog_table->entry[loadparm].scsi);
 }
 
 /***********************************************************************
@@ -1025,7 +1067,9 @@ void zipl_load(void)
         netmain();
     }
 
-    ipl_scsi();
+    if (ipl_scsi()) {
+        panic("\n! Cannot IPL this SCSI device !\n");
+    }
 
     switch (virtio_get_device_type()) {
     case VIRTIO_ID_BLOCK:
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 80b7f6a1f3..6671e4fe5c 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -16,6 +16,7 @@
 #define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
 
 static uint64_t *reset_psw = 0, save_psw, ipl_continue;
+extern bool have_iplb;
 
 void write_reset_psw(uint64_t psw)
 {
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 2666326801..1c585f034b 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
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
 
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 0e274d0c38..60bc6fcbfa 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -26,7 +26,7 @@ static uint8_t scsi_inquiry_std_response[256];
 static ScsiInquiryEvpdPages scsi_inquiry_evpd_pages_response;
 static ScsiInquiryEvpdBl scsi_inquiry_evpd_bl_response;
 
-static inline void vs_assert(bool term, const char **msgs)
+static inline bool vs_assert(bool term, const char **msgs)
 {
     if (!term) {
         int i = 0;
@@ -35,11 +35,13 @@ static inline void vs_assert(bool term, const char **msgs)
         while (msgs[i]) {
             printf("%s", msgs[i++]);
         }
-        panic(" !\n");
+        puts(" !");
     }
+
+    return term;
 }
 
-static void virtio_scsi_verify_response(VirtioScsiCmdResp *resp,
+static bool virtio_scsi_verify_response(VirtioScsiCmdResp *resp,
                                         const char *title)
 {
     const char *mr[] = {
@@ -56,8 +58,12 @@ static void virtio_scsi_verify_response(VirtioScsiCmdResp *resp,
         0
     };
 
-    vs_assert(resp->response == VIRTIO_SCSI_S_OK, mr);
-    vs_assert(resp->status == CDB_STATUS_GOOD, ms);
+    if (!vs_assert(resp->response == VIRTIO_SCSI_S_OK, mr) ||
+                !vs_assert(resp->status == CDB_STATUS_GOOD, ms)) {
+        return false;
+    }
+
+    return true;
 }
 
 static void prepare_request(VDev *vdev, const void *cdb, int cdb_size,
@@ -78,24 +84,30 @@ static void prepare_request(VDev *vdev, const void *cdb, int cdb_size,
     }
 }
 
-static inline void vs_io_assert(bool term, const char *msg)
+static inline bool vs_io_assert(bool term, const char *msg)
 {
-    if (!term) {
-        virtio_scsi_verify_response(&resp, msg);
+    if (!term && !virtio_scsi_verify_response(&resp, msg)) {
+        return false;
     }
+
+    return true;
 }
 
-static void vs_run(const char *title, VirtioCmd *cmd, VDev *vdev,
+static int vs_run(const char *title, VirtioCmd *cmd, VDev *vdev,
                    const void *cdb, int cdb_size,
                    void *data, uint32_t data_size)
 {
     prepare_request(vdev, cdb, cdb_size, data, data_size);
-    vs_io_assert(virtio_run(vdev, VR_REQUEST, cmd) == 0, title);
+    if (!vs_io_assert(virtio_run(vdev, VR_REQUEST, cmd) == 0, title)) {
+        puts(title);
+    }
+
+    return 0;
 }
 
 /* SCSI protocol implementation routines */
 
-static bool scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
+static int scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
                          void *data, uint32_t data_size)
 {
     ScsiCdbInquiry cdb = {
@@ -110,12 +122,13 @@ static bool scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
         { data, data_size, VRING_DESC_F_WRITE },
     };
 
-    vs_run("inquiry", inquiry, vdev, &cdb, sizeof(cdb), data, data_size);
+    int cc = vs_run("inquiry", inquiry,
+            vdev, &cdb, sizeof(cdb), data, data_size);
 
-    return virtio_scsi_response_ok(&resp);
+    return cc ? cc : virtio_scsi_response_ok(&resp);
 }
 
-static bool scsi_test_unit_ready(VDev *vdev)
+static int scsi_test_unit_ready(VDev *vdev)
 {
     ScsiCdbTestUnitReady cdb = {
         .command = 0x00,
@@ -131,7 +144,7 @@ static bool scsi_test_unit_ready(VDev *vdev)
     return virtio_scsi_response_ok(&resp);
 }
 
-static bool scsi_report_luns(VDev *vdev, void *data, uint32_t data_size)
+static int scsi_report_luns(VDev *vdev, void *data, uint32_t data_size)
 {
     ScsiCdbReportLuns cdb = {
         .command = 0xa0,
@@ -144,13 +157,13 @@ static bool scsi_report_luns(VDev *vdev, void *data, uint32_t data_size)
         { data, data_size, VRING_DESC_F_WRITE },
     };
 
-    vs_run("report luns", report_luns,
+    int cc = vs_run("report luns", report_luns,
            vdev, &cdb, sizeof(cdb), data, data_size);
 
-    return virtio_scsi_response_ok(&resp);
+    return cc ? cc : virtio_scsi_response_ok(&resp);
 }
 
-static bool scsi_read_10(VDev *vdev,
+static int scsi_read_10(VDev *vdev,
                          unsigned long sector, int sectors, void *data,
                          unsigned int data_size)
 {
@@ -168,12 +181,13 @@ static bool scsi_read_10(VDev *vdev,
     debug_print_int("read_10  sector", sector);
     debug_print_int("read_10 sectors", sectors);
 
-    vs_run("read(10)", read_10, vdev, &cdb, sizeof(cdb), data, data_size);
+    int cc = vs_run("read(10)", read_10,
+            vdev, &cdb, sizeof(cdb), data, data_size);
 
-    return virtio_scsi_response_ok(&resp);
+    return cc ? cc : virtio_scsi_response_ok(&resp);
 }
 
-static bool scsi_read_capacity(VDev *vdev,
+static int scsi_read_capacity(VDev *vdev,
                                void *data, uint32_t data_size)
 {
     ScsiCdbReadCapacity16 cdb = {
@@ -187,10 +201,10 @@ static bool scsi_read_capacity(VDev *vdev,
         { data, data_size, VRING_DESC_F_WRITE },
     };
 
-    vs_run("read capacity", read_capacity_16,
+    int cc = vs_run("read capacity", read_capacity_16,
            vdev, &cdb, sizeof(cdb), data, data_size);
 
-    return virtio_scsi_response_ok(&resp);
+    return cc ? cc : virtio_scsi_response_ok(&resp);
 }
 
 /* virtio-scsi routines */
@@ -207,7 +221,7 @@ static int virtio_scsi_locate_device(VDev *vdev)
     static uint8_t data[16 + 8 * 63];
     ScsiLunReport *r = (void *) data;
     ScsiDevice *sdev = vdev->scsi_device;
-    int i, luns;
+    int i, cc, luns;
 
     /* QEMU has hardcoded channel #0 in many places.
      * If this hardcoded value is ever changed, we'll need to add code for
@@ -233,13 +247,21 @@ static int virtio_scsi_locate_device(VDev *vdev)
         sdev->channel = channel;
         sdev->target = target;
         sdev->lun = 0;          /* LUN has to be 0 for REPORT LUNS */
-        if (!scsi_report_luns(vdev, data, sizeof(data))) {
+        cc = scsi_report_luns(vdev, data, sizeof(data));
+        if (cc < 0) {
+            return cc;
+        }
+
+        else if (cc == 0) {
             if (resp.response == VIRTIO_SCSI_S_BAD_TARGET) {
                 continue;
             }
             printf("target 0x%X", target);
-            virtio_scsi_verify_response(&resp, "SCSI cannot report LUNs");
+            if (!virtio_scsi_verify_response(&resp, "SCSI cannot report LUNs")) {
+                return -EIO;
+            }
         }
+
         if (r->lun_list_len == 0) {
             printf("no LUNs for target 0x%X", target);
             continue;
@@ -283,7 +305,9 @@ int virtio_scsi_read_many(VDev *vdev,
         data_size = sector_count * virtio_get_block_size() * f;
         if (!scsi_read_10(vdev, sector * f, sector_count * f, load_addr,
                           data_size)) {
-            virtio_scsi_verify_response(&resp, "virtio-scsi:read_many");
+            if (!virtio_scsi_verify_response(&resp, "virtio-scsi:read_many")) {
+                return 1;
+            }
         }
         load_addr += data_size;
         sector += sector_count;
@@ -337,7 +361,7 @@ static int virtio_scsi_setup(VDev *vdev)
     uint32_t data_size = sizeof(data);
     ScsiInquiryEvpdPages *evpd = &scsi_inquiry_evpd_pages_response;
     ScsiInquiryEvpdBl *evpd_bl = &scsi_inquiry_evpd_bl_response;
-    int i, ret;
+    int i, cc, ret;
 
     vdev->scsi_device = &default_scsi_device;
     ret = virtio_scsi_locate_device(vdev);
@@ -352,11 +376,16 @@ static int virtio_scsi_setup(VDev *vdev)
             uint8_t code = resp.sense[0] & SCSI_SENSE_CODE_MASK;
             uint8_t sense_key = resp.sense[2] & SCSI_SENSE_KEY_MASK;
 
-            IPL_assert(resp.sense_len != 0, "virtio-scsi:setup: no SENSE data");
+            if (resp.sense_len == 0) {
+                puts("virtio-scsi: setup: no SENSE data");
+                return -EINVAL;
+            }
 
-            IPL_assert(retry_test_unit_ready && code == 0x70 &&
-                       sense_key == SCSI_SENSE_KEY_UNIT_ATTENTION,
-                       "virtio-scsi:setup: cannot retry");
+            if (!retry_test_unit_ready || code != 0x70 ||
+                       sense_key != SCSI_SENSE_KEY_UNIT_ATTENTION) {
+                puts("virtio-scsi:setup: cannot retry");
+                return -EIO;
+            }
 
             /* retry on CHECK_CONDITION/UNIT_ATTENTION as it
              * may not designate a real error, but it may be
@@ -367,16 +396,22 @@ static int virtio_scsi_setup(VDev *vdev)
             continue;
         }
 
-        virtio_scsi_verify_response(&resp, "virtio-scsi:setup");
+        if (!virtio_scsi_verify_response(&resp, "virtio-scsi:setup")) {
+            return 1;
+        }
     }
 
     /* read and cache SCSI INQUIRY response */
-    if (!scsi_inquiry(vdev,
+    cc = scsi_inquiry(vdev,
                       SCSI_INQUIRY_STANDARD,
                       SCSI_INQUIRY_STANDARD_NONE,
                       scsi_inquiry_std_response,
-                      sizeof(scsi_inquiry_std_response))) {
-        virtio_scsi_verify_response(&resp, "virtio-scsi:setup:inquiry");
+                      sizeof(scsi_inquiry_std_response));
+    if (cc < 1) {
+        if (cc != 0 || !virtio_scsi_verify_response(&resp,
+                "virtio-scsi:setup:inquiry")) {
+            return 1;
+        }
     }
 
     if (virtio_scsi_inquiry_response_is_cdrom(scsi_inquiry_std_response)) {
@@ -385,12 +420,16 @@ static int virtio_scsi_setup(VDev *vdev)
         vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
     }
 
-    if (!scsi_inquiry(vdev,
+    cc = scsi_inquiry(vdev,
                       SCSI_INQUIRY_EVPD,
                       SCSI_INQUIRY_EVPD_SUPPORTED_PAGES,
                       evpd,
-                      sizeof(*evpd))) {
-        virtio_scsi_verify_response(&resp, "virtio-scsi:setup:supported_pages");
+                      sizeof(*evpd));
+    if (cc < 1) {
+        if (cc != 0 || !virtio_scsi_verify_response(&resp,
+                "virtio-scsi:setup:supported_pages")) {
+            return 1;
+        }
     }
 
     debug_print_int("EVPD length", evpd->page_length);
@@ -402,12 +441,16 @@ static int virtio_scsi_setup(VDev *vdev)
             continue;
         }
 
-        if (!scsi_inquiry(vdev,
+        cc = scsi_inquiry(vdev,
                           SCSI_INQUIRY_EVPD,
                           SCSI_INQUIRY_EVPD_BLOCK_LIMITS,
                           evpd_bl,
-                          sizeof(*evpd_bl))) {
-            virtio_scsi_verify_response(&resp, "virtio-scsi:setup:blocklimits");
+                          sizeof(*evpd_bl));
+        if (cc < 1) {
+            if (cc != 0 || !virtio_scsi_verify_response(&resp,
+                    "virtio-scsi:setup:blocklimits")) {
+                return 1;
+            }
         }
 
         debug_print_int("max transfer", evpd_bl->max_transfer);
@@ -423,8 +466,12 @@ static int virtio_scsi_setup(VDev *vdev)
     vdev->max_transfer = MIN_NON_ZERO(VIRTIO_SCSI_MAX_SECTORS,
                                       vdev->max_transfer);
 
-    if (!scsi_read_capacity(vdev, data, data_size)) {
-        virtio_scsi_verify_response(&resp, "virtio-scsi:setup:read_capacity");
+    cc = scsi_read_capacity(vdev, data, data_size);
+    if (cc < 1) {
+        if (cc != 0 || !virtio_scsi_verify_response(&resp,
+                "virtio-scsi:setup:read_capacity")) {
+            return 1;
+        }
     }
     scsi_parse_capacity_report(data, &vdev->scsi_last_block,
                                (uint32_t *) &vdev->scsi_block_size);
@@ -439,10 +486,15 @@ int virtio_scsi_setup_device(SubChannelId schid)
     vdev->schid = schid;
     virtio_setup_ccw(vdev);
 
-    IPL_assert(vdev->config.scsi.sense_size == VIRTIO_SCSI_SENSE_SIZE,
-               "Config: sense size mismatch");
-    IPL_assert(vdev->config.scsi.cdb_size == VIRTIO_SCSI_CDB_SIZE,
-               "Config: CDB size mismatch");
+    if (vdev->config.scsi.sense_size != VIRTIO_SCSI_SENSE_SIZE) {
+        puts("Config: sense size mismatch");
+        return -EINVAL;
+    }
+
+    if (vdev->config.scsi.cdb_size != VIRTIO_SCSI_CDB_SIZE) {
+        puts("Config: CDB size mismatch");
+        return -EINVAL;
+    }
 
     puts("Using virtio-scsi.");
 
-- 
2.45.1


