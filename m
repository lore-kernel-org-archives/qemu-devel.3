Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94586C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 21:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZGU6-0007UK-E8; Sat, 18 Jan 2025 16:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@corpit.ru>)
 id 1tZGU3-0007T9-BL; Sat, 18 Jan 2025 16:35:59 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@corpit.ru>)
 id 1tZGU1-0003rf-GT; Sat, 18 Jan 2025 16:35:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6BCA2DA98F;
 Sun, 19 Jan 2025 00:35:41 +0300 (MSK)
Received: by tsrv.corpit.ru (Postfix, from userid 1000)
 id 0F4FC19EAE7; Sun, 19 Jan 2025 00:35:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 19 Jan 2025 00:26:34 +0300
Subject: [PATCH v2] vvfat: refresh writing long filename
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
Message-Id: <20250118213552.0F4FC19EAE7@tsrv.corpit.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@corpit.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
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

In function create_long_filname(), the array name[8 + 3] in
struct direntry_t is used as if it were defined as name[32].
This is intentional and works. It's nevertheless an out of
bounds array access. To avoid this problem, this patch adds a
struct lfn_direntry_t with multiple name arrays. A directory
entry for a long FAT file name is significantly different from
a directory entry for a regular FAT file name.

This change makes whole logic dealing with the long filenames
a bit more clear (hopefully).

Based on ideas by Volker Rümelin.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/vvfat.c | 73 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 26 deletions(-)

v2: also include trailing U+0000 and fill the remaining bytes with U+FFFF

diff --git a/block/vvfat.c b/block/vvfat.c
index 8ffe8b3b9b..c8a22af875 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -255,6 +255,17 @@ typedef struct direntry_t {
     uint32_t size;
 } QEMU_PACKED direntry_t;
 
+typedef struct lfn_direntry_t {
+    uint8_t sequence;
+    uint8_t name01[10];
+    uint8_t attributes;
+    uint8_t direntry_type;
+    uint8_t sfn_checksum;
+    uint8_t name0e[12];
+    uint16_t begin;
+    uint8_t name1c[4];
+} QEMU_PACKED lfn_direntry_t;
+
 /* this structure are used to transparently access the files */
 
 typedef struct mapping_t {
@@ -399,11 +410,26 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
 
 /* direntry functions */
 
+static unsigned write_lfn_part(uint8_t *dest, unsigned dsize,
+                               const gunichar2 *lptr, const gunichar2 *lend)
+{
+    unsigned i = 0;
+    for (; i < dsize / 2 && lptr + i <= lend; ++i) { /* incl. trailing U+0000 */
+        /* can't use cpu_to_be16() since dest is unaligned */
+        dest[i / 2 + 0] = lptr[i] & 0xff;
+        dest[i / 2 + 1] = lptr[i] >> 8;
+    }
+    for (; i < dsize / 2; ++i) { /* fill the rest with U+FFFF */
+        dest[i / 2 + 0] = dest[i / 2 + 1] = 0xff;
+    }
+    return i; /* return number of elements written (=dsize) */
+}
+
 static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
 {
-    int number_of_entries, i;
+    unsigned number_of_entries, enidx;
+    gunichar2 *lptr, *lend;
     glong length;
-    direntry_t *entry;
 
     gunichar2 *longname = g_utf8_to_utf16(filename, -1, NULL, &length, NULL);
     if (!longname) {
@@ -411,31 +437,26 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
         return NULL;
     }
 
-    number_of_entries = DIV_ROUND_UP(length * 2, 26);
-
-    for(i=0;i<number_of_entries;i++) {
-        entry=array_get_next(&(s->directory));
-        entry->attributes=0xf;
-        entry->reserved[0]=0;
-        entry->begin=0;
-        entry->name[0]=(number_of_entries-i)|(i==0?0x40:0);
-    }
-    for(i=0;i<26*number_of_entries;i++) {
-        int offset=(i%26);
-        if(offset<10) offset=1+offset;
-        else if(offset<22) offset=14+offset-10;
-        else offset=28+offset-22;
-        entry=array_get(&(s->directory),s->directory.next-1-(i/26));
-        if (i >= 2 * length + 2) {
-            entry->name[offset] = 0xff;
-        } else if (i % 2 == 0) {
-            entry->name[offset] = longname[i / 2] & 0xff;
-        } else {
-            entry->name[offset] = longname[i / 2] >> 8;
-        }
+    /*
+     * each lfn_direntry holds 13 utf16 chars (26 bytes) of the file name,
+     * the name is split into several directory entries.
+     */
+    number_of_entries = DIV_ROUND_UP(length, 13);
+
+    lend = longname + length; /* pointer past the end of longname */
+    for (enidx = 0, lptr = longname; enidx < number_of_entries; enidx++) {
+        lfn_direntry_t *en = array_get_next(&(s->directory));
+        en->sequence = (number_of_entries - enidx) | (enidx == 0 ? 0x40 : 0);
+        en->attributes = 0xf;
+        en->direntry_type = 0;
+        en->begin = 0;
+        /* each lftn_direntry has 3 pieces to hold parts of long file name */
+        lptr += write_lfn_part(en->name01, ARRAY_SIZE(en->name01), lptr, lend);
+        lptr += write_lfn_part(en->name0e, ARRAY_SIZE(en->name0e), lptr, lend);
+        lptr += write_lfn_part(en->name1c, ARRAY_SIZE(en->name1c), lptr, lend);
     }
     g_free(longname);
-    return array_get(&(s->directory),s->directory.next-number_of_entries);
+    return array_get(&s->directory, s->directory.next - number_of_entries);
 }
 
 static char is_free(const direntry_t* direntry)
@@ -731,7 +752,7 @@ static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
         /* calculate anew, because realloc could have taken place */
         entry_long=array_get(&(s->directory),long_index);
         while(entry_long<entry && is_long_name(entry_long)) {
-            entry_long->reserved[1]=chksum;
+            ((lfn_direntry_t *)entry_long)->sfn_checksum = chksum;
             entry_long++;
         }
     }
-- 
2.39.5


