Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2D4C02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 08:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZR6P-0003r6-Qh; Sun, 19 Jan 2025 03:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tZR6G-0003ph-6A; Sun, 19 Jan 2025 03:56:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tZR6D-0001z6-Ds; Sun, 19 Jan 2025 03:56:07 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 3DB27DADC4;
 Sun, 19 Jan 2025 11:55:47 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 9134A50B69; Sun, 19 Jan 2025 11:55:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 19 Jan 2025 11:34:35 +0300
Subject: [PATCH v3, do not apply] vvfat: refresh writing long filename
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
Message-Id: <20250119085558.9134A50B69@localhost.tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
 block/vvfat.c | 68 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 25 deletions(-)

v3:
 - actually make it work (long pieces are written in reverse order!)
 - use uint16_t for utf16, not uint8_t
 - use helper macro instead of function due to unaligned access

This is messy either way.  In the end this one is no better than the
version written by Volker.

The best seems to be to use the original code but treat entry pointer
as (unsigned char *) and use offsets in there, just like the original
code does with entry->name.

diff --git a/block/vvfat.c b/block/vvfat.c
index bb80dfb177..eda674a23c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -255,6 +255,17 @@ typedef struct direntry_t {
     uint32_t size;
 } QEMU_PACKED direntry_t;
 
+typedef struct lfn_direntry_t {
+    uint8_t sequence;
+    uint16_t name01[5];  /* UTF16 */
+    uint8_t attributes;
+    uint8_t direntry_type;
+    uint8_t sfn_checksum;
+    uint16_t name0e[6];  /* UTF16 */
+    uint16_t begin;
+    uint16_t name1c[2];  /* UTF16 */
+} QEMU_PACKED lfn_direntry_t;
+
 /* this structure are used to transparently access the files */
 
 typedef struct mapping_t {
@@ -401,9 +412,10 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
 
 static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
 {
-    int number_of_entries, i;
+    unsigned number_of_entries, ei, i;
+    gunichar2 *lptr, *lend;
+    lfn_direntry_t *e;
     glong length;
-    direntry_t *entry;
 
     gunichar2 *longname = g_utf8_to_utf16(filename, -1, NULL, &length, NULL);
     if (!longname) {
@@ -411,31 +423,37 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
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
+     * each direntry holds 13 utf16 chars (26 bytes) of the file name,
+     * the name is split into several directory entries (in reverse order).
+     */
+    number_of_entries = DIV_ROUND_UP(length, 13);
+
+    for (ei = 0; ei < number_of_entries; ei++) { /* allocate and basic init */
+        e = array_get_next(&s->directory);
+        e->sequence = (number_of_entries - ei) | (ei == 0 ? 0x40 : 0);
+        e->attributes = 0xf;
+        e->direntry_type = 0;
+        e->begin = 0;
+    }
+    lend = longname + length; /* pointer to the trailing U+0000 */
+    for (ei = 0, lptr = longname; ei < number_of_entries; ++ei) {
+        e = array_get(&s->directory, s->directory.next - ei - 1);
+        /* each lftn_direntry has 3 pieces to hold parts of long file name */
+#define write_lfn_part(dst, lptr, lend)	\
+    i = 0; \
+    while (i < ARRAY_SIZE(dst) && lptr <= lend) { /* with trailing U+0000 */ \
+        dst[i++] = cpu_to_le16(*lptr++); \
+    } \
+    while (i < ARRAY_SIZE(dst)) { /* fill the rest with U+FFFF */ \
+        dst[i++] = 0xffff; \
+    }
+        write_lfn_part(e->name01, lptr, lend);
+        write_lfn_part(e->name0e, lptr, lend);
+        write_lfn_part(e->name1c, lptr, lend);
     }
     g_free(longname);
-    return array_get(&(s->directory),s->directory.next-number_of_entries);
+    return array_get(&s->directory, s->directory.next - number_of_entries);
 }
 
 static char is_free(const direntry_t* direntry)
-- 
2.39.5


