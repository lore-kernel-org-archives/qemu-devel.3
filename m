Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1E3CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxypj-00045z-Vj; Mon, 07 Oct 2024 21:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxyph-00045H-Hv; Mon, 07 Oct 2024 21:16:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypf-0008HY-5f; Mon, 07 Oct 2024 21:16:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497Nt8Jr026653;
 Tue, 8 Oct 2024 01:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=EMFlUjXFbClm+
 byH4iu81LclUpFGQnIekH0pDh+MOKo=; b=trka2cqO46iZNNtsDmZ5DgYZRQma9
 XaP+ERCHRxOHTfBOi5bqdv/rRNzC2jBR96WiygJXMiBaSG7LasVTF6rFevXd2Zme
 +Qoq7VpQtf7847aHU5dZD6szOQbMaONONq0zSY4R+kbGNbNpksVHwlVmm9HtyAlN
 EStCPOyotgKTtrZkfb011LZJcWmcHREA94MUQAthMZXHGGvAQBVXhT77B8oYipXY
 AIJjBtMqizRwx9vP1ISVlVOQU0CSlLOt9HnSprMkGDb5KYo9brXBz1D59SIWipVd
 qB8T68a3JUYzZrjAxz9osQ58EalJR8nRw4bUDRt8UffXs7U1n0pjK8ZwQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424sr4g7gy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981G8nD017417;
 Tue, 8 Oct 2024 01:16:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424sr4g7gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497Kicxn030253;
 Tue, 8 Oct 2024 01:16:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmhjj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981G7MH2818594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D81C258055;
 Tue,  8 Oct 2024 01:16:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63CDC58043;
 Tue,  8 Oct 2024 01:16:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:06 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 07/19] pc-bios/s390-ccw: Remove panics from ISO IPL path
Date: Mon,  7 Oct 2024 21:15:40 -0400
Message-ID: <20241008011552.2645520-8-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vZBnXx5xjy6E4L-dPcuZdnXKNMHL6_om
X-Proofpoint-GUID: 64DOKli3yBS7e3vuRftSlJATWx37MMYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410080003
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

Remove panic-on-error from IPL ISO El Torito specific functions so that error
recovery may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.h  | 15 +++----
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 pc-bios/s390-ccw/bootmap.c  | 78 ++++++++++++++++++++++++-------------
 3 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index bbe2c132aa..d639258eca 100644
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
+        return 1;
+    }
+    return 0;
 }
 
 #define ISO9660_MAX_DIR_DEPTH 8
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 0ed7eb8ade..cbd92f3671 100644
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
index 414c3f1b47..7984de62fe 100644
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
@@ -699,21 +701,28 @@ static inline uint32_t iso_get_file_size(uint32_t load_rba)
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
 
@@ -784,9 +795,11 @@ static void load_iso_bc_entry(IsoBcSection *load)
         puts("ISO boot image size could not be verified");
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
@@ -809,17 +822,18 @@ static uint32_t find_iso_bc(void)
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
 
@@ -827,11 +841,13 @@ static IsoBcSection *find_iso_bc_entry(void)
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
 
@@ -851,19 +867,25 @@ static IsoBcSection *find_iso_bc_entry(void)
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
+        return 1;
     }
+
+    puts("No suitable boot entry found on ISO-9660 media!");
+    return -EIO;
 }
 
 /**
@@ -893,7 +915,9 @@ static void zipl_load_vblk(void)
         if (blksize != VIRTIO_ISO_BLOCK_SIZE) {
             virtio_assume_iso9660();
         }
-        ipl_iso_el_torito();
+        if (ipl_iso_el_torito()) {
+            return;
+        }
     }
 
     if (blksize != VIRTIO_DASD_DEFAULT_BLOCK_SIZE) {
@@ -907,7 +931,9 @@ static void zipl_load_vscsi(void)
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


