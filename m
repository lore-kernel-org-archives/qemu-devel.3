Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D9FC02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 10:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZSbR-0001Tz-FC; Sun, 19 Jan 2025 05:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tZSbM-0001Sx-Ks; Sun, 19 Jan 2025 05:32:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tZSbK-0005AJ-Qk; Sun, 19 Jan 2025 05:32:20 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 81E79DAF65;
 Sun, 19 Jan 2025 13:32:02 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id EB99850B7E; Sun, 19 Jan 2025 13:32:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 19 Jan 2025 13:29:05 +0300
Subject: [PATCH] vvfat: create_long_filename(): refresh
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
Message-Id: <20250119103213.EB99850B7E@localhost.tls.msk.ru>
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

add comments explaining what is going on (since long file names are really weird),
rewrite the second loop to do one UTF16 char at a time instead of byte,
and fix coding style.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/vvfat.c | 54 +++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

on top of the previous patch

diff --git a/block/vvfat.c b/block/vvfat.c
index b53e3b452b..4827288756 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -401,7 +401,7 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
 
 static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
 {
-    int number_of_entries, i;
+    unsigned nents, i;
     glong length;
 
     gunichar2 *longname = g_utf8_to_utf16(filename, -1, NULL, &length, NULL);
@@ -410,31 +410,39 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
         return NULL;
     }
 
-    number_of_entries = DIV_ROUND_UP(length * 2, 26);
-
-    for(i=0;i<number_of_entries;i++) {
-        direntry_t *entry=array_get_next(&(s->directory));
-        entry->attributes=0xf;
-        entry->reserved[0]=0;
-        entry->begin=0;
-        entry->name[0]=(number_of_entries-i)|(i==0?0x40:0);
-    }
-    for(i=0;i<26*number_of_entries;i++) {
-        unsigned char *entry=array_get(&(s->directory),s->directory.next-1-(i/26));
-        int offset=(i%26);
-        if(offset<10) offset=1+offset;
-        else if(offset<22) offset=14+offset-10;
-        else offset=28+offset-22;
-        if (i >= 2 * length + 2) {
-            entry[offset] = 0xff;
-        } else if (i % 2 == 0) {
-            entry[offset] = longname[i / 2] & 0xff;
-        } else {
-            entry[offset] = longname[i / 2] >> 8;
+    /*
+     * long file name is split into multiple directory entries,
+     * 13 UTF16 chars (26 bytes) in each,
+     * in reverse order.
+     */
+    nents = DIV_ROUND_UP(length, 13);
+
+    for (i = 0; i < nents; ++i) { /* allocate and basic init */
+        direntry_t *entry = array_get_next(&s->directory);
+        entry->attributes = 0xf;
+        entry->reserved[0] = 0;
+        entry->begin = 0;
+        entry->name[0] = (nents - i) | (i == 0 ? 0x40 : 0);
+    }
+
+    /* write 13 chars of name to each entry, entries in reverse order */
+    for (i = 0; i < nents * 13; ++i) {
+        unsigned char *entry =
+           array_get(&s->directory, s->directory.next - 1 - i / 13);
+        unsigned off = i % 13;
+        /* each entry has 3 different places for the name: */
+        off = off < 5 ? off * 2 + 1 /* bytes 1..10, 5 chars 0..4, unaligned */
+            : off < 11 ? (off - 5) * 2 + 14 /* bytes 14..25, 6 chars 5..10 */
+            :            (off - 11) * 2 + 28; /* bytes 28..31, 2 chars 11..12 */
+        if (i <= length) { /* name and trailing U+0000 */
+            entry[off + 0] = longname[i] & 0xff;
+            entry[off + 1] = longname[i] >> 8;
+        } else { /* fill remaining parts with U+FFFF */
+            entry[off + 0] = entry[off + 1] = 0xff;
         }
     }
     g_free(longname);
-    return array_get(&(s->directory),s->directory.next-number_of_entries);
+    return array_get(&s->directory, s->directory.next - nents);
 }
 
 static char is_free(const direntry_t* direntry)
-- 
2.39.5


