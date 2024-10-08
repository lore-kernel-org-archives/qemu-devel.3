Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAE4CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyq2-0004DT-Qy; Mon, 07 Oct 2024 21:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypj-00045s-Mc; Mon, 07 Oct 2024 21:16:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxyph-0008IQ-8h; Mon, 07 Oct 2024 21:16:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4980OvVu002125;
 Tue, 8 Oct 2024 01:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=t6z5uXzymn4br
 orRXCN/qJXIMEP0rIygIs2yjOMQa64=; b=R1xFCRF51eLa3tli4cONF/mP0OFYa
 1QiluNQGszslKw6H9KaUtNZxvHYkuNBoG/wh438VklVR97ESYaXk3TOjzEzVmiJq
 uaGs7ePme5g3fPvQrnWzSvcYSH6IO2278vZq4YGRgfeJwawMRADpL120elNNiXiv
 7do8A0FL6phEmaiJmgSgXQnYnGHH0/B9YjWst84fdcdFgK9Na5GxEi9fC74DfGJX
 Mh79AY4LeQGjDtKTnpLUyLjsa3XVh4Htk9BRd4PvJhYW7cKD8SuFxm5/T1dMcjVN
 wbP6qoe8qeQHT3hetJ6JLNtOnRcbBm4TG7tchH7C/g/nkpdZbgHxhzHfA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424t5tg5dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981GAEh000844;
 Tue, 8 Oct 2024 01:16:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424t5tg5dd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497LgUXT022856;
 Tue, 8 Oct 2024 01:16:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9jsfjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981G83c23528078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A41258059;
 Tue,  8 Oct 2024 01:16:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D1D458043;
 Tue,  8 Oct 2024 01:16:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:07 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 08/19] pc-bios/s390-ccw: Remove panics from ECKD IPL path
Date: Mon,  7 Oct 2024 21:15:41 -0400
Message-ID: <20241008011552.2645520-9-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d2phorUS-YxWaOUtP54ClrR0R2wpiu_p
X-Proofpoint-GUID: hvLRgaC9F-viwBQzSpfoheQMwXHWdIsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Remove panic-on-error from ECKD block device IPL specific functions so that
error recovery may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/s390-ccw.h |   1 +
 pc-bios/s390-ccw/bootmap.c  | 183 ++++++++++++++++++++++++------------
 2 files changed, 126 insertions(+), 58 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index cbd92f3671..7516e96a14 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -31,6 +31,7 @@ typedef unsigned long long u64;
 #define EBUSY   2
 #define ENODEV  3
 #define EINVAL  4
+#define ENOENT  5
 
 #ifndef MIN
 #define MIN(a, b) (((a) < (b)) ? (a) : (b))
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 7984de62fe..266b38c034 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -145,14 +145,17 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
     bool more_data;
 
     memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
-    read_block(blk, bprs, "BPRS read failed");
+    if (virtio_read(blk, bprs)) {
+        puts("BPRS read failed");
+        return -EIO;
+    }
 
     do {
         more_data = false;
         for (j = 0;; j++) {
             block_nr = gen_eckd_block_num(&bprs[j].xeckd, ldipl);
             if (is_null_block_number(block_nr)) { /* end of chunk */
-                break;
+                return -ENOENT;
             }
 
             /* we need the updated blockno for the next indirect entry
@@ -163,15 +166,20 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
             }
 
             /* List directed pointer does not store block size */
-            IPL_assert(ldipl || block_size_ok(bprs[j].xeckd.bptr.size),
-                       "bad chunk block size");
+            if (!ldipl && !block_size_ok(bprs[j].xeckd.bptr.size)) {
+                puts("Bad chunk block size");
+                return -EIO;
+            }
 
             if (!eckd_valid_address(&bprs[j].xeckd, ldipl)) {
                 /*
                  * If an invalid address is found during LD-IPL then break and
-                 * retry as CCW
+                 * retry as CCW-IPL, otherwise abort on error
                  */
-                IPL_assert(ldipl, "bad chunk ECKD addr");
+                if (!ldipl) {
+                    puts("Bad chunk ECKD address");
+                    return -EIO;
+                }
                 break;
             }
 
@@ -189,7 +197,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
                  * I.e. the next ptr must point to the unused memory area
                  */
                 memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
-                read_block(block_nr, bprs, "BPRS continuation read failed");
+                if (virtio_read(block_nr, bprs)) {
+                    puts("BPRS continuation read failed");
+                    return -EIO;
+                }
                 more_data = true;
                 break;
             }
@@ -198,7 +209,10 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
              * to memory (address).
              */
             rc = virtio_read_many(block_nr, (void *)(*address), count + 1);
-            IPL_assert(rc == 0, "code chunk read failed");
+            if (rc != 0) {
+                puts("Code chunk read failed");
+                return -EIO;
+            }
 
             *address += (count + 1) * virtio_get_block_size();
         }
@@ -232,7 +246,10 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
 
     /* Get Stage1b data */
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(s1b_block_nr, s1b, "Cannot read stage1b boot loader");
+    if (virtio_read(s1b_block_nr, s1b)) {
+        puts("Cannot read stage1b boot loader");
+        return -EIO;
+    }
 
     memset(_s2, FREE_SPACE_FILLER, sizeof(_s2));
 
@@ -244,7 +261,10 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
             break;
         }
 
-        read_block(cur_block_nr, s2_cur_blk, "Cannot read stage2 boot loader");
+        if (virtio_read(cur_block_nr, s2_cur_blk)) {
+            puts("Cannot read stage2 boot loader");
+            return -EIO;
+        }
 
         if (find_zipl_boot_menu_banner(&banner_offset)) {
             /*
@@ -252,8 +272,10 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
              * possibility of menu data spanning multiple blocks.
              */
             if (prev_block_nr) {
-                read_block(prev_block_nr, s2_prev_blk,
-                           "Cannot read stage2 boot loader");
+                if (virtio_read(prev_block_nr, s2_prev_blk)) {
+                    puts("Cannot read stage2 boot loader");
+                    return -EIO;
+                }
             }
 
             if (i + 1 < STAGE2_BLK_CNT_MAX) {
@@ -261,8 +283,10 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
             }
 
             if (next_block_nr && !is_null_block_number(next_block_nr)) {
-                read_block(next_block_nr, s2_next_blk,
-                           "Cannot read stage2 boot loader");
+                if (virtio_read(next_block_nr, s2_next_blk)) {
+                    puts("Cannot read stage2 boot loader");
+                    return -EIO;
+                }
             }
 
             return menu_get_zipl_boot_index(s2_cur_blk + banner_offset);
@@ -275,7 +299,7 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
     return 0;
 }
 
-static void run_eckd_boot_script(block_number_t bmt_block_nr,
+static int run_eckd_boot_script(block_number_t bmt_block_nr,
                                  block_number_t s1b_block_nr)
 {
     int i;
@@ -292,17 +316,28 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
     }
 
     debug_print_int("loadparm", loadparm);
-    IPL_assert(loadparm < MAX_BOOT_ENTRIES, "loadparm value greater than"
-               " maximum number of boot entries allowed");
+    if (loadparm >= MAX_BOOT_ENTRIES) {
+        puts("loadparm value greater than max number of boot entries allowed");
+        return -EINVAL;
+    }
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(bmt_block_nr, sec, "Cannot read Boot Map Table");
+    if (virtio_read(bmt_block_nr, sec)) {
+        puts("Cannot read Boot Map Table");
+        return -EIO;
+    }
 
     block_nr = gen_eckd_block_num(&bmt->entry[loadparm].xeckd, ldipl);
-    IPL_assert(block_nr != -1, "Cannot find Boot Map Table Entry");
+    if (block_nr == NULL_BLOCK_NR) {
+        puts("Cannot find Boot Map Table Entry");
+        return -EIO;
+    }
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(block_nr, sec, "Cannot read Boot Map Script");
+    if (virtio_read(block_nr, sec)) {
+        puts("Cannot read Boot Map Script");
+        return -EIO;
+    }
 
     for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
                 bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
@@ -317,21 +352,28 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
 
         do {
             block_nr = load_eckd_segments(block_nr, ldipl, &address);
-        } while (block_nr != -1);
+        } while (block_nr >= 0);
+
+        if (block_nr != -ENOENT && block_nr < 0) {
+            return ldipl ? 0 : -EIO;
+        }
     }
 
     if (ldipl && bms->entry[i].type != BOOT_SCRIPT_EXEC) {
         /* Abort LD-IPL and retry as CCW-IPL */
-        return;
+        return 0;
     }
 
-    IPL_assert(bms->entry[i].type == BOOT_SCRIPT_EXEC,
-               "Unknown script entry type");
+    if (bms->entry[i].type != BOOT_SCRIPT_EXEC) {
+        puts("Unknown script entry type");
+        return -EINVAL;
+    }
     write_reset_psw(bms->entry[i].address.load_address); /* no return */
     jump_to_IPL_code(0); /* no return */
+    return 1;
 }
 
-static void ipl_eckd_cdl(void)
+static int ipl_eckd_cdl(void)
 {
     XEckdMbr *mbr;
     EckdCdlIpl2 *ipl2 = (void *)sec;
@@ -342,20 +384,23 @@ static void ipl_eckd_cdl(void)
     puts("CDL");
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(1, ipl2, "Cannot read IPL2 record at block 1");
+    if (virtio_read(1, ipl2)) {
+        puts("Cannot read IPL2 record at block 1");
+        return -EIO;
+    }
 
     mbr = &ipl2->mbr;
     if (!magic_match(mbr, ZIPL_MAGIC)) {
         puts("No zIPL section in IPL2 record.");
-        return;
+        return 0;
     }
     if (!block_size_ok(mbr->blockptr.xeckd.bptr.size)) {
         puts("Bad block size in zIPL section of IPL2 record.");
-        return;
+        return 0;
     }
     if (mbr->dev_type != DEV_TYPE_ECKD) {
         puts("Non-ECKD device type in zIPL section of IPL2 record.");
-        return;
+        return 0;
     }
 
     /* save pointer to Boot Map Table */
@@ -365,19 +410,21 @@ static void ipl_eckd_cdl(void)
     s1b_block_nr = eckd_block_num(&ipl2->stage1.seek[0].chs);
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(2, vlbl, "Cannot read Volume Label at block 2");
+    if (virtio_read(2, vlbl)) {
+        puts("Cannot read Volume Label at block 2");
+        return -EIO;
+    }
     if (!magic_match(vlbl->key, VOL1_MAGIC)) {
         puts("Invalid magic of volume label block.");
-        return;
+        return 0;
     }
     if (!magic_match(vlbl->f.key, VOL1_MAGIC)) {
         puts("Invalid magic of volser block.");
-        return;
+        return 0;
     }
     print_volser(vlbl->f.volser);
 
-    run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
-    /* no return */
+    return run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
 }
 
 static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
@@ -403,7 +450,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
     print_volser(vlbl->volser);
 }
 
-static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
+static int ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
     block_number_t bmt_block_nr, s1b_block_nr;
     EckdLdlIpl1 *ipl1 = (void *)sec;
@@ -415,10 +462,13 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     /* DO NOT read BootMap pointer (only one, xECKD) at block #2 */
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(0, sec, "Cannot read block 0 to grab boot info.");
+    if (virtio_read(0, sec)) {
+        puts("Cannot read block 0 to grab boot info.");
+        return -EIO;
+    }
     if (mode == ECKD_LDL_UNLABELED) {
         if (!magic_match(ipl1->bip.magic, ZIPL_MAGIC)) {
-            return; /* not applicable layout */
+            return 0; /* not applicable layout */
         }
         puts("unlabeled LDL.");
     }
@@ -430,8 +480,7 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     /* save pointer to Stage1b Data */
     s1b_block_nr = eckd_block_num(&ipl1->stage1.seek[0].chs);
 
-    run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
-    /* no return */
+    return run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
 }
 
 static block_number_t eckd_find_bmt(ExtEckdBlockPtr *ptr)
@@ -441,11 +490,14 @@ static block_number_t eckd_find_bmt(ExtEckdBlockPtr *ptr)
     BootRecord *br;
 
     blockno = gen_eckd_block_num(ptr, 0);
-    read_block(blockno, tmp_sec, "Cannot read boot record");
+    if (virtio_read(blockno, tmp_sec)) {
+        puts("Cannot read boot record");
+        return -EIO;
+    }
     br = (BootRecord *)tmp_sec;
     if (!magic_match(br->magic, ZIPL_MAGIC)) {
         /* If the boot record is invalid, return and try CCW-IPL instead */
-        return NULL_BLOCK_NR;
+        return 0;
     }
 
     return gen_eckd_block_num(&br->pgt.xeckd, 1);
@@ -470,7 +522,7 @@ static void print_eckd_msg(void)
     printf("%s", msg);
 }
 
-static void ipl_eckd(void)
+static int ipl_eckd(void)
 {
     IplVolumeLabel *vlbl = (void *)sec;
     LDL_VTOC *vtoc = (void *)sec;
@@ -480,7 +532,10 @@ static void ipl_eckd(void)
 
     /* Block 2 can contain either the CDL VOL1 label or the LDL VTOC */
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(2, vlbl, "Cannot read block 2");
+    if (virtio_read(2, vlbl)) {
+        puts("Cannot read block 2");
+        return -EIO;
+    }
 
     /*
      * First check for a list-directed-format pointer which would
@@ -490,34 +545,46 @@ static void ipl_eckd(void)
         ldipl_bmt = eckd_find_bmt((ExtEckdBlockPtr *)&vlbl->f.br);
         if (ldipl_bmt) {
             puts("List-Directed");
-            /* LD-IPL does not use the S1B bock, just make it NULL */
-            run_eckd_boot_script(ldipl_bmt, NULL_BLOCK_NR);
-            /* Only return in error, retry as CCW-IPL */
+            /*
+             * LD-IPL does not use the S1B bock, just make it NULL_BLOCK_NR.
+             * In some failure cases retry IPL before aborting.
+             */
+            if (run_eckd_boot_script(ldipl_bmt, NULL_BLOCK_NR)) {
+                return -EIO;
+            }
+            /* Non-fatal error, retry as CCW-IPL */
             printf("Retrying IPL ");
             print_eckd_msg();
         }
         memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-        read_block(2, vtoc, "Cannot read block 2");
+        if (virtio_read(2, vtoc)) {
+            puts("Cannot read block 2");
+            return -EIO;
+        }
     }
 
     /* Not list-directed */
     if (magic_match(vtoc->magic, VOL1_MAGIC)) {
-        ipl_eckd_cdl(); /* may return in error */
+        if (ipl_eckd_cdl()) {
+            return 1;
+        }
     }
 
     if (magic_match(vtoc->magic, CMS1_MAGIC)) {
-        ipl_eckd_ldl(ECKD_CMS); /* no return */
+        return ipl_eckd_ldl(ECKD_CMS);
     }
     if (magic_match(vtoc->magic, LNX1_MAGIC)) {
-        ipl_eckd_ldl(ECKD_LDL); /* no return */
+        return ipl_eckd_ldl(ECKD_LDL);
     }
 
-    ipl_eckd_ldl(ECKD_LDL_UNLABELED); /* it still may return */
+    if (ipl_eckd_ldl(ECKD_LDL_UNLABELED)) {
+        return 1;
+    }
     /*
      * Ok, it is not a LDL by any means.
      * It still might be a CDL with zero record keys for IPL1 and IPL2
      */
-    ipl_eckd_cdl();
+    return ipl_eckd_cdl();
 }
 
 /***********************************************************************
@@ -907,7 +974,7 @@ static bool has_iso_signature(void)
  * Bus specific IPL sequences
  */
 
-static void zipl_load_vblk(void)
+static int zipl_load_vblk(void)
 {
     int blksize = virtio_get_block_size();
 
@@ -916,7 +983,7 @@ static void zipl_load_vblk(void)
             virtio_assume_iso9660();
         }
         if (ipl_iso_el_torito()) {
-            return;
+            return 0;
         }
     }
 
@@ -924,21 +991,21 @@ static void zipl_load_vblk(void)
         puts("Using guessed DASD geometry.");
         virtio_assume_eckd();
     }
-    ipl_eckd();
+    return ipl_eckd();
 }
 
-static void zipl_load_vscsi(void)
+static int zipl_load_vscsi(void)
 {
     if (virtio_get_block_size() == VIRTIO_ISO_BLOCK_SIZE) {
         /* Is it an ISO image in non-CD drive? */
         if (ipl_iso_el_torito()) {
-            return;
+            return 0;
         }
     }
 
     puts("Using guessed DASD geometry.");
     virtio_assume_eckd();
-    ipl_eckd();
+    return ipl_eckd();
 }
 
 /***********************************************************************
-- 
2.45.1


