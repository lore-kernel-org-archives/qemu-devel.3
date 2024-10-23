Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631AECF538B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFO-0006LJ-9x; Wed, 23 Oct 2024 09:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bF5-00067T-2O
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bF3-0002AD-3Q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97S4qqt/tBOMDzdXmG/IY6UTHoZ7pB4u43qJXWNnO0U=;
 b=VF8ioXC+n55QuI074mzGwSdZ3pMqGzXhJ1A6c5OdA13b85Inaq2frgFB/YisreIH2edBS9
 axdd+Pgr44OAr5o0Bx0gvgIf3z1KwosBlgnFDs2usn39A9Ba2h0RwwocpY9REMCEgBjP8H
 rYEVc6ghihjKi39sMw4xzsL+gyWPN7Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-iQ3m6xgCOyCSXn960YTRXA-1; Wed,
 23 Oct 2024 09:17:33 -0400
X-MC-Unique: iQ3m6xgCOyCSXn960YTRXA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 343E11964CE7; Wed, 23 Oct 2024 13:17:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5FB419560AE; Wed, 23 Oct 2024 13:17:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 07/23] pc-bios/s390-ccw: Remove panics from ISO IPL path
Date: Wed, 23 Oct 2024 15:16:54 +0200
Message-ID: <20241023131710.906748-8-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241020012953.1380075-8-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.47.0


