Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2B3D3C927
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2Klu-0008S0-D2; Sat, 19 Oct 2024 21:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Kls-0008QX-K0; Sat, 19 Oct 2024 21:30:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klo-0005Od-Lh; Sat, 19 Oct 2024 21:30:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JFFSoY006856;
 Sun, 20 Oct 2024 01:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=r/Hc4QdxWjf4zzOfs
 C6VCnWsYl7tHwKrje1NlaxA8TU=; b=p+4/OMdhDH7PAitZOS2HY6YZKhZGVCsKj
 3WY3vdg1ZlWGiU6+ZByl0Ab+Ja/BBx8Swv1UonBLcBoxZmQDsMwNAYYRaxTwEQSA
 YG3/BNP2/pk2JoelQj5nqcEI9tle8bAmu3HYOdE477Rs+eNe47JxVicEFDPvElmK
 yaaeIW7UQhhly4o4DVUu0DtLWZHwf8JRXNphSe/Ezy1sJ2v3WYtPScch/G/6O24g
 2CrfLQt/fYS/I2x3xZYoudNNo7B9ItpBjgPVgtlIv7mn3mxIdUaCA55DSe9rPxDZ
 CegdSigTywPhaQO4mqH5jpZNjLgZPcdx41Zyd/uJ/1SmKgfLHRCyQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcb19r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K0BNDf026425;
 Sun, 20 Oct 2024 01:30:10 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cq3s07tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1U97P46399914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:30:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30B9A5805C;
 Sun, 20 Oct 2024 01:30:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E4B458054;
 Sun, 20 Oct 2024 01:30:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:30:08 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 08/19] pc-bios/s390-ccw: Remove panics from ECKD IPL path
Date: Sat, 19 Oct 2024 21:29:42 -0400
Message-ID: <20241020012953.1380075-9-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z2CojCdAYmjFti7UNxu3WBdEJ_dxIE9P
X-Proofpoint-GUID: z2CojCdAYmjFti7UNxu3WBdEJ_dxIE9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410200009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 pc-bios/s390-ccw/bootmap.h |   1 +
 pc-bios/s390-ccw/bootmap.c | 187 +++++++++++++++++++++++++------------
 2 files changed, 130 insertions(+), 58 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 3cb573b86b..95943441d3 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -16,6 +16,7 @@
 
 typedef uint64_t block_number_t;
 #define NULL_BLOCK_NR 0xffffffffffffffffULL
+#define ERROR_BLOCK_NR 0xfffffffffffffffeULL
 
 #define FREE_SPACE_FILLER '\xAA'
 
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index af73254acb..b9596e28c7 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -145,14 +145,17 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
     bool more_data;
 
     memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
-    read_block(blk, bprs, "BPRS read failed");
+    if (virtio_read(blk, bprs)) {
+        puts("BPRS read failed");
+        return ERROR_BLOCK_NR;
+    }
 
     do {
         more_data = false;
         for (j = 0;; j++) {
             block_nr = gen_eckd_block_num(&bprs[j].xeckd, ldipl);
             if (is_null_block_number(block_nr)) { /* end of chunk */
-                break;
+                return NULL_BLOCK_NR;
             }
 
             /* we need the updated blockno for the next indirect entry
@@ -163,15 +166,20 @@ static block_number_t load_eckd_segments(block_number_t blk, bool ldipl,
             }
 
             /* List directed pointer does not store block size */
-            IPL_assert(ldipl || block_size_ok(bprs[j].xeckd.bptr.size),
-                       "bad chunk block size");
+            if (!ldipl && !block_size_ok(bprs[j].xeckd.bptr.size)) {
+                puts("Bad chunk block size");
+                return ERROR_BLOCK_NR;
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
+                    return ERROR_BLOCK_NR;
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
+                    return ERROR_BLOCK_NR;
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
+                return ERROR_BLOCK_NR;
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
@@ -317,21 +352,27 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
 
         do {
             block_nr = load_eckd_segments(block_nr, ldipl, &address);
-        } while (block_nr != -1);
+            if (block_nr == ERROR_BLOCK_NR) {
+                return ldipl ? 0 : -EIO;
+            }
+        } while (block_nr != NULL_BLOCK_NR);
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
+    return -1;
 }
 
-static void ipl_eckd_cdl(void)
+static int ipl_eckd_cdl(void)
 {
     XEckdMbr *mbr;
     EckdCdlIpl2 *ipl2 = (void *)sec;
@@ -342,20 +383,23 @@ static void ipl_eckd_cdl(void)
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
@@ -365,19 +409,21 @@ static void ipl_eckd_cdl(void)
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
@@ -403,7 +449,7 @@ static void print_eckd_ldl_msg(ECKD_IPL_mode_t mode)
     print_volser(vlbl->volser);
 }
 
-static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
+static int ipl_eckd_ldl(ECKD_IPL_mode_t mode)
 {
     block_number_t bmt_block_nr, s1b_block_nr;
     EckdLdlIpl1 *ipl1 = (void *)sec;
@@ -415,10 +461,13 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
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
@@ -430,8 +479,7 @@ static void ipl_eckd_ldl(ECKD_IPL_mode_t mode)
     /* save pointer to Stage1b Data */
     s1b_block_nr = eckd_block_num(&ipl1->stage1.seek[0].chs);
 
-    run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
-    /* no return */
+    return run_eckd_boot_script(bmt_block_nr, s1b_block_nr);
 }
 
 static block_number_t eckd_find_bmt(ExtEckdBlockPtr *ptr)
@@ -441,7 +489,10 @@ static block_number_t eckd_find_bmt(ExtEckdBlockPtr *ptr)
     BootRecord *br;
 
     blockno = gen_eckd_block_num(ptr, 0);
-    read_block(blockno, tmp_sec, "Cannot read boot record");
+    if (virtio_read(blockno, tmp_sec)) {
+        puts("Cannot read boot record");
+        return ERROR_BLOCK_NR;
+    }
     br = (BootRecord *)tmp_sec;
     if (!magic_match(br->magic, ZIPL_MAGIC)) {
         /* If the boot record is invalid, return and try CCW-IPL instead */
@@ -470,7 +521,7 @@ static void print_eckd_msg(void)
     printf("%s", msg);
 }
 
-static void ipl_eckd(void)
+static int ipl_eckd(void)
 {
     IplVolumeLabel *vlbl = (void *)sec;
     LDL_VTOC *vtoc = (void *)sec;
@@ -480,7 +531,10 @@ static void ipl_eckd(void)
 
     /* Block 2 can contain either the CDL VOL1 label or the LDL VTOC */
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
-    read_block(2, vlbl, "Cannot read block 2");
+    if (virtio_read(2, vlbl)) {
+        puts("Cannot read block 2");
+        return -EIO;
+    }
 
     /*
      * First check for a list-directed-format pointer which would
@@ -488,36 +542,53 @@ static void ipl_eckd(void)
      */
     if (eckd_valid_address((ExtEckdBlockPtr *)&vlbl->f.br, 0)) {
         ldipl_bmt = eckd_find_bmt((ExtEckdBlockPtr *)&vlbl->f.br);
-        if (ldipl_bmt) {
+        switch (ldipl_bmt) {
+        case ERROR_BLOCK_NR:
+            return -EIO;
+        case NULL_BLOCK_NR:
+            break; /* Invalid BMT but the device may still boot with CCW-IPL */
+        default:
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
+            return -1;
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
+        return -1;
+    }
     /*
      * Ok, it is not a LDL by any means.
      * It still might be a CDL with zero record keys for IPL1 and IPL2
      */
-    ipl_eckd_cdl();
+    return ipl_eckd_cdl();
 }
 
 /***********************************************************************
@@ -910,7 +981,7 @@ static bool has_iso_signature(void)
  * Bus specific IPL sequences
  */
 
-static void zipl_load_vblk(void)
+static int zipl_load_vblk(void)
 {
     int blksize = virtio_get_block_size();
 
@@ -919,7 +990,7 @@ static void zipl_load_vblk(void)
             virtio_assume_iso9660();
         }
         if (ipl_iso_el_torito()) {
-            return;
+            return 0;
         }
     }
 
@@ -927,21 +998,21 @@ static void zipl_load_vblk(void)
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


