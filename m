Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B2CD3C912
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2Klr-0008QC-VG; Sat, 19 Oct 2024 21:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klq-0008Ow-Hj; Sat, 19 Oct 2024 21:30:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klo-0005Oa-IW; Sat, 19 Oct 2024 21:30:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49K1H4QB017592;
 Sun, 20 Oct 2024 01:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=eFmqnFXnvrc0cV7wb
 NrCoh/lWeqHjrMafgELnZt1vS8=; b=izJu511c3za7dyXhk4Eb/NAAol1jgbg2p
 bDZ8yTX/huKqOpvnn4cdeufeMj9TEHnwLDrAXNhHHNMnpFlU0jd0UObNh589SsQv
 yhvUQZjAjU6PxXudDYveIpaFMcWeEISHFoUslSxLCkOfPZ6VXsQ769d0uiIEq+GJ
 4jBYLRbAnbfYbZ0sbfnZf2gl0yiFcrvzXaqo6M5/YQIMv7EQ/Qb5A64f6nTt33ts
 ywKCxXxFnQUYkbImqe5wJq6ptakONReRWRLeY050a8QnDiziqGqQUFxgTdzTsJvw
 IwMVHhu7YyK0iYnzDjNH/S37I/E6hENilwj68jLfllzTiKJ7D7RhA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5h2u6j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K0bIVk028879;
 Sun, 20 Oct 2024 01:30:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cqfx84wr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:30:09 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1U7qY52822512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:30:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B152D58064;
 Sun, 20 Oct 2024 01:30:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 044795805C;
 Sun, 20 Oct 2024 01:30:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:30:06 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 07/19] pc-bios/s390-ccw: Remove panics from ISO IPL path
Date: Sat, 19 Oct 2024 21:29:41 -0400
Message-ID: <20241020012953.1380075-8-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sH_gkzeU5CZzHf13tfyJ5VXG3mKYBxm-
X-Proofpoint-ORIG-GUID: sH_gkzeU5CZzHf13tfyJ5VXG3mKYBxm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410200009
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Remove panic-on-error from IPL ISO El Torito specific functions so that error
recovery may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.h  | 15 +++----
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 pc-bios/s390-ccw/bootmap.c  | 87 ++++++++++++++++++++++++-------------
 3 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 4a7d8a91f1..3cb573b86b 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -385,17 +385,14 @@ static inline uint32_t iso_733_to_u32(uint64_t x)
 
 #define ISO_PRIMARY_VD_SECTOR 16
 
-static inline void read_iso_sector(uint32_t block_offset, void *buf,
-                                   const char *errmsg)
-{
-    IPL_assert(virtio_read_many(block_offset, buf, 1) == 0, errmsg);
-}
-
-static inline void read_iso_boot_image(uint32_t block_offset, void *load_addr,
+static inline int read_iso_boot_image(uint32_t block_offset, void *load_addr,
                                        uint32_t blks_to_load)
 {
-    IPL_assert(virtio_read_many(block_offset, load_addr, blks_to_load) == 0,
-               "Failed to read boot image!");
+    if (virtio_read_many(block_offset, load_addr, blks_to_load)) {
+        puts("Failed to read boot image!");
+        return -1;
+    }
+    return 0;
 }
 
 #define ISO9660_MAX_DIR_DEPTH 8
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 6abb34e563..3e844abd71 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -30,6 +30,7 @@ typedef unsigned long long u64;
 #define EIO     1
 #define EBUSY   2
 #define ENODEV  3
+#define EINVAL  4
 
 #ifndef MIN
 #define MIN(a, b) (((a) < (b)) ? (a) : (b))
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 414c3f1b47..af73254acb 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -678,8 +678,10 @@ static bool is_iso_bc_entry_compatible(IsoBcSection *s)
     if (s->unused || !s->sector_count) {
         return false;
     }
-    read_iso_sector(bswap32(s->load_rba), magic_sec,
-                    "Failed to read image sector 0");
+    if (virtio_read(bswap32(s->load_rba), magic_sec)) {
+        puts("Failed to read image sector 0");
+        return false;
+    }
 
     /* Checking bytes 8 - 32 for S390 Linux magic */
     return !memcmp(magic_sec + 8, linux_s390_magic, 24);
@@ -692,28 +694,35 @@ static uint32_t sec_offset[ISO9660_MAX_DIR_DEPTH];
 /* Remained directory space in bytes */
 static uint32_t dir_rem[ISO9660_MAX_DIR_DEPTH];
 
-static inline uint32_t iso_get_file_size(uint32_t load_rba)
+static inline long iso_get_file_size(uint32_t load_rba)
 {
     IsoVolDesc *vd = (IsoVolDesc *)sec;
     IsoDirHdr *cur_record = &vd->vd.primary.rootdir;
     uint8_t *temp = sec + ISO_SECTOR_SIZE;
     int level = 0;
 
-    read_iso_sector(ISO_PRIMARY_VD_SECTOR, sec,
-                    "Failed to read ISO primary descriptor");
+    if (virtio_read(ISO_PRIMARY_VD_SECTOR, sec)) {
+        puts("Failed to read ISO primary descriptor");
+        return -EIO;
+    }
+
     sec_loc[0] = iso_733_to_u32(cur_record->ext_loc);
     dir_rem[0] = 0;
     sec_offset[0] = 0;
 
     while (level >= 0) {
-        IPL_assert(sec_offset[level] <= ISO_SECTOR_SIZE,
-                   "Directory tree structure violation");
+        if (sec_offset[level] > ISO_SECTOR_SIZE) {
+            puts("Directory tree structure violation");
+            return -EIO;
+        }
 
         cur_record = (IsoDirHdr *)(temp + sec_offset[level]);
 
         if (sec_offset[level] == 0) {
-            read_iso_sector(sec_loc[level], temp,
-                            "Failed to read ISO directory");
+            if (virtio_read(sec_loc[level], temp)) {
+                puts("Failed to read ISO directory");
+                return -EIO;
+            }
             if (dir_rem[level] == 0) {
                 /* Skip self and parent records */
                 dir_rem[level] = iso_733_to_u32(cur_record->data_len) -
@@ -758,8 +767,10 @@ static inline uint32_t iso_get_file_size(uint32_t load_rba)
         if (dir_rem[level] == 0) {
             /* Nothing remaining */
             level--;
-            read_iso_sector(sec_loc[level], temp,
-                            "Failed to read ISO directory");
+            if (virtio_read(sec_loc[level], temp)) {
+                puts("Failed to read ISO directory");
+                return -EIO;
+            }
         }
     }
 
@@ -774,19 +785,24 @@ static void load_iso_bc_entry(IsoBcSection *load)
      * is padded and ISO_SECTOR_SIZE bytes aligned
      */
     uint32_t blks_to_load = bswap16(s.sector_count) >> ET_SECTOR_SHIFT;
-    uint32_t real_size = iso_get_file_size(bswap32(s.load_rba));
+    long real_size = iso_get_file_size(bswap32(s.load_rba));
 
-    if (real_size) {
+    if (real_size > 0) {
         /* Round up blocks to load */
         blks_to_load = (real_size + ISO_SECTOR_SIZE - 1) / ISO_SECTOR_SIZE;
         puts("ISO boot image size verified");
     } else {
         puts("ISO boot image size could not be verified");
+        if (real_size < 0) {
+            return;
+        }
     }
 
-    read_iso_boot_image(bswap32(s.load_rba),
+    if (read_iso_boot_image(bswap32(s.load_rba),
                         (void *)((uint64_t)bswap16(s.load_segment)),
-                        blks_to_load);
+                        blks_to_load)) {
+        return;
+    }
 
     jump_to_low_kernel();
 }
@@ -809,17 +825,18 @@ static uint32_t find_iso_bc(void)
                 return bswap32(et->bc_offset);
             }
         }
-        read_iso_sector(block_num++, sec,
-                        "Failed to read ISO volume descriptor");
+        if (virtio_read(block_num++, sec)) {
+            puts("Failed to read ISO volume descriptor");
+            return 0;
+        }
     }
 
     return 0;
 }
 
-static IsoBcSection *find_iso_bc_entry(void)
+static IsoBcSection *find_iso_bc_entry(uint32_t offset)
 {
     IsoBcEntry *e = (IsoBcEntry *)sec;
-    uint32_t offset = find_iso_bc();
     int i;
     unsigned int loadparm = get_loadparm_index();
 
@@ -827,11 +844,13 @@ static IsoBcSection *find_iso_bc_entry(void)
         return NULL;
     }
 
-    read_iso_sector(offset, sec, "Failed to read El Torito boot catalog");
+    if (virtio_read(offset, sec)) {
+        puts("Failed to read El Torito boot catalog");
+        return NULL;
+    }
 
     if (!is_iso_bc_valid(e)) {
         /* The validation entry is mandatory */
-        panic("No valid boot catalog found!\n");
         return NULL;
     }
 
@@ -851,19 +870,25 @@ static IsoBcSection *find_iso_bc_entry(void)
         }
     }
 
-    panic("No suitable boot entry found on ISO-9660 media!\n");
-
     return NULL;
 }
 
-static void ipl_iso_el_torito(void)
+static int ipl_iso_el_torito(void)
 {
-    IsoBcSection *s = find_iso_bc_entry();
+    uint32_t offset = find_iso_bc();
+    if (!offset) {
+        return 0;
+    }
+
+    IsoBcSection *s = find_iso_bc_entry(offset);
 
     if (s) {
-        load_iso_bc_entry(s);
-        /* no return */
+        load_iso_bc_entry(s); /* only return in error */
+        return -1;
     }
+
+    puts("No suitable boot entry found on ISO-9660 media!");
+    return -EIO;
 }
 
 /**
@@ -893,7 +918,9 @@ static void zipl_load_vblk(void)
         if (blksize != VIRTIO_ISO_BLOCK_SIZE) {
             virtio_assume_iso9660();
         }
-        ipl_iso_el_torito();
+        if (ipl_iso_el_torito()) {
+            return;
+        }
     }
 
     if (blksize != VIRTIO_DASD_DEFAULT_BLOCK_SIZE) {
@@ -907,7 +934,9 @@ static void zipl_load_vscsi(void)
 {
     if (virtio_get_block_size() == VIRTIO_ISO_BLOCK_SIZE) {
         /* Is it an ISO image in non-CD drive? */
-        ipl_iso_el_torito();
+        if (ipl_iso_el_torito()) {
+            return;
+        }
     }
 
     puts("Using guessed DASD geometry.");
-- 
2.45.1


