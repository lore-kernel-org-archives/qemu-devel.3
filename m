Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD3C02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 09:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZRff-00039o-4m; Sun, 19 Jan 2025 04:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tZRfd-000390-Gq; Sun, 19 Jan 2025 04:32:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tZRfb-0005tP-PI; Sun, 19 Jan 2025 04:32:41 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 3D38FDAEB8;
 Sun, 19 Jan 2025 12:32:22 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 9E4C450B6D; Sun, 19 Jan 2025 12:32:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 19 Jan 2025 12:15:51 +0300
Subject: [PATCH] vvfat: create_long_filename: fix out-of-bounds array access
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
Message-Id: <20250119093233.9E4C450B6D@localhost.tls.msk.ru>
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

create_long_filename() intentionally uses direntry_t->name[8+3] array
as a larger array.  This works, but makes statid code analysis tools
unhappy.  The problem here is that a directory entry holding long file
name is significantly different from regular directory entry, and the
name is split into several parts within the entry, not just in regular
8+3 name field.

Treat the entry as array of bytes instead.  This fixes the OOB access
from the compiler/tools PoV, but does not change the resulting code
in any way.

Keep the existing code style.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/vvfat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

This code is really ugly and insanely ineffecient.
But LFN is also ugly.

I think this one is the best for now.

Another patch might optimize the second loop quite a bit,
add comments (since it is really difficult to understand,
especially since lfn is so weird), and fix coding style.

diff --git a/block/vvfat.c b/block/vvfat.c
index bb80dfb177..b53e3b452b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -403,7 +403,6 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
 {
     int number_of_entries, i;
     glong length;
-    direntry_t *entry;
 
     gunichar2 *longname = g_utf8_to_utf16(filename, -1, NULL, &length, NULL);
     if (!longname) {
@@ -414,24 +413,24 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
     number_of_entries = DIV_ROUND_UP(length * 2, 26);
 
     for(i=0;i<number_of_entries;i++) {
-        entry=array_get_next(&(s->directory));
+        direntry_t *entry=array_get_next(&(s->directory));
         entry->attributes=0xf;
         entry->reserved[0]=0;
         entry->begin=0;
         entry->name[0]=(number_of_entries-i)|(i==0?0x40:0);
     }
     for(i=0;i<26*number_of_entries;i++) {
+        unsigned char *entry=array_get(&(s->directory),s->directory.next-1-(i/26));
         int offset=(i%26);
         if(offset<10) offset=1+offset;
         else if(offset<22) offset=14+offset-10;
         else offset=28+offset-22;
-        entry=array_get(&(s->directory),s->directory.next-1-(i/26));
         if (i >= 2 * length + 2) {
-            entry->name[offset] = 0xff;
+            entry[offset] = 0xff;
         } else if (i % 2 == 0) {
-            entry->name[offset] = longname[i / 2] & 0xff;
+            entry[offset] = longname[i / 2] & 0xff;
         } else {
-            entry->name[offset] = longname[i / 2] >> 8;
+            entry[offset] = longname[i / 2] >> 8;
         }
     }
     g_free(longname);
-- 
2.39.5


