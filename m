Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43117CEBF63
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzCu-0002iS-Ha; Thu, 26 Sep 2024 20:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCs-0002a9-Ir; Thu, 26 Sep 2024 20:51:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCp-0007Fw-OG; Thu, 26 Sep 2024 20:51:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QGvxgg016194;
 Fri, 27 Sep 2024 00:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=I47/9Onhte4l5
 KxMD7+mQQtrnp/ihCqo5c/feU9fFz4=; b=sGudQZdoJf+yHJHSF2E7YoD8clqsY
 tRURC1kTjFv842snMMTsvgFz79PAu3KQ1gdFiXTxY+sfwPcMNGFJC3qubWk/gaRz
 h6w/twQLIVvQc5Oa6sSFZ2mbNADwYFoPWTWdoX/EIh+xg2Cu6HVHgFqQ6yCQw50M
 7JC15zX5kzPMraUKvlnZnXPwUZaetRYMqoxwHSbsTKqmsbmgRMdOeuV7fLXAVN3x
 Ym8YWkMGJLFB1EQPGVFjpT+S+nRlSrW3nrD1IQM4aIcF+CqTrqPs9sS+tXu6JMG6
 W7JN6E5mEXaI33dhbqQafmiPuc6v+GnWhHt4jhjijQ2ixH03pgMrKbCFw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt1rry1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pXiA000979;
 Fri, 27 Sep 2024 00:51:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snt1rrxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QLd31r013998;
 Fri, 27 Sep 2024 00:51:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9yna5vj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0pWF243254186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 189FD58056;
 Fri, 27 Sep 2024 00:51:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9978258052;
 Fri, 27 Sep 2024 00:51:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:31 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 07/18] pc-bios/s390-ccw: Remove panics from ISO IPL path
Date: Thu, 26 Sep 2024 20:51:06 -0400
Message-ID: <20240927005117.1679506-8-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927005117.1679506-1-jrossi@linux.ibm.com>
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2ZMoI_vBPRknGVIisghN12sToXkb8bXc
X-Proofpoint-GUID: JR7qrnI8j-SnpU_apVEXbbYTH-RK6A1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
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

Remove panic-on-error from IPL ISO El Torito specific functions so that error
recovery may be possible in the future.

Functions that would previously panic now provide a return code.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

---
 pc-bios/s390-ccw/bootmap.h  | 17 +++++++---
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 pc-bios/s390-ccw/bootmap.c  | 64 ++++++++++++++++++++++++-------------
 3 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index bbe2c132aa..cb5346829b 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -385,17 +385,24 @@ static inline uint32_t iso_733_to_u32(uint64_t x)
 
 #define ISO_PRIMARY_VD_SECTOR 16
 
-static inline void read_iso_sector(uint32_t block_offset, void *buf,
+static inline int read_iso_sector(uint32_t block_offset, void *buf,
                                    const char *errmsg)
 {
-    IPL_assert(virtio_read_many(block_offset, buf, 1) == 0, errmsg);
+    if (virtio_read(block_offset, buf)) {
+        puts(errmsg);
+        return 1;
+    }
+    return 0;
 }
 
-static inline void read_iso_boot_image(uint32_t block_offset, void *load_addr,
+static inline int read_iso_boot_image(uint32_t block_offset, void *load_addr,
                                        uint32_t blks_to_load)
 {
-    IPL_assert(virtio_read_many(block_offset, load_addr, blks_to_load) == 0,
-               "Failed to read boot image!");
+    if (!virtio_read_many(block_offset, load_addr, blks_to_load)) {
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
index 414c3f1b47..31cf0f6d97 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -678,8 +678,10 @@ static bool is_iso_bc_entry_compatible(IsoBcSection *s)
     if (s->unused || !s->sector_count) {
         return false;
     }
-    read_iso_sector(bswap32(s->load_rba), magic_sec,
-                    "Failed to read image sector 0");
+    if (read_iso_sector(bswap32(s->load_rba), magic_sec,
+                    "Failed to read image sector 0")) {
+        return false;
+    }
 
     /* Checking bytes 8 - 32 for S390 Linux magic */
     return !memcmp(magic_sec + 8, linux_s390_magic, 24);
@@ -706,14 +708,18 @@ static inline uint32_t iso_get_file_size(uint32_t load_rba)
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
@@ -784,9 +790,11 @@ static void load_iso_bc_entry(IsoBcSection *load)
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
@@ -809,17 +817,18 @@ static uint32_t find_iso_bc(void)
                 return bswap32(et->bc_offset);
             }
         }
-        read_iso_sector(block_num++, sec,
-                        "Failed to read ISO volume descriptor");
+        if (read_iso_sector(block_num++, sec,
+                        "Failed to read ISO volume descriptor")) {
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
 
@@ -827,11 +836,12 @@ static IsoBcSection *find_iso_bc_entry(void)
         return NULL;
     }
 
-    read_iso_sector(offset, sec, "Failed to read El Torito boot catalog");
+    if (read_iso_sector(offset, sec, "Failed to read El Torito boot catalog")) {
+        return NULL;
+    }
 
     if (!is_iso_bc_valid(e)) {
         /* The validation entry is mandatory */
-        panic("No valid boot catalog found!\n");
         return NULL;
     }
 
@@ -851,19 +861,25 @@ static IsoBcSection *find_iso_bc_entry(void)
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
@@ -893,7 +909,9 @@ static void zipl_load_vblk(void)
         if (blksize != VIRTIO_ISO_BLOCK_SIZE) {
             virtio_assume_iso9660();
         }
-        ipl_iso_el_torito();
+        if (ipl_iso_el_torito()) {
+            return;
+        }
     }
 
     if (blksize != VIRTIO_DASD_DEFAULT_BLOCK_SIZE) {
@@ -907,7 +925,9 @@ static void zipl_load_vscsi(void)
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


