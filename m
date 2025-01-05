Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A1E77197
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2025 14:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tURAL-0008Nd-Aa; Sun, 05 Jan 2025 08:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1tURAI-0008Ml-Mq; Sun, 05 Jan 2025 08:59:38 -0500
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1tURAG-0005B2-JV; Sun, 05 Jan 2025 08:59:38 -0500
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout12.t-online.de (Postfix) with SMTP id 1C4F2896;
 Sun,  5 Jan 2025 14:59:31 +0100 (CET)
Received: from linpower.localnet ([93.236.158.175]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1tURA9-18sldZ0; Sun, 5 Jan 2025 14:59:29 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 2C0252001C7; Sun,  5 Jan 2025 14:59:29 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] vvfat: fix out of bounds array write
Date: Sun,  5 Jan 2025 14:59:29 +0100
Message-ID: <20250105135929.6286-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1736085569-68FF7448-AB51C9E3/0/0 CLEAN NORMAL
X-TOI-MSGID: d4c4643e-ab34-46d1-8400-b162c84435e1
Received-SPF: pass client-ip=194.25.134.22;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout12.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

In function create_long_filname(), the array name[8 + 3] in
struct direntry_t is used as if it were defined as name[32].
This is intentional and works. It's nevertheless an out of
bounds array access. To avoid this problem, this patch adds a
struct lfn_direntry_t with multiple name arrays. A directory
entry for a long FAT file name is significantly different from
a directory entry for a regular FAT file name.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 block/vvfat.c | 55 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 8ffe8b3b9b..626c4f0163 100644
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
@@ -399,11 +410,28 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
 
 /* direntry functions */
 
+static void write_long_filename(lfn_direntry_t *entry, int index, uint8_t c)
+{
+    if (index < ARRAY_SIZE(entry->name01)) {
+        entry->name01[index] = c;
+        return;
+    }
+    index -= ARRAY_SIZE(entry->name01);
+    if (index < ARRAY_SIZE(entry->name0e)) {
+        entry->name0e[index] = c;
+        return;
+    }
+    index -= ARRAY_SIZE(entry->name0e);
+    if (index < ARRAY_SIZE(entry->name1c)) {
+        entry->name1c[index] = c;
+    }
+}
+
 static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
 {
     int number_of_entries, i;
     glong length;
-    direntry_t *entry;
+    lfn_direntry_t *entry;
 
     gunichar2 *longname = g_utf8_to_utf16(filename, -1, NULL, &length, NULL);
     if (!longname) {
@@ -415,24 +443,23 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
 
     for(i=0;i<number_of_entries;i++) {
         entry=array_get_next(&(s->directory));
+        entry->sequence = (number_of_entries - i) | (i == 0 ? 0x40 : 0);
         entry->attributes=0xf;
-        entry->reserved[0]=0;
+        entry->direntry_type = 0;
         entry->begin=0;
-        entry->name[0]=(number_of_entries-i)|(i==0?0x40:0);
-    }
-    for(i=0;i<26*number_of_entries;i++) {
-        int offset=(i%26);
-        if(offset<10) offset=1+offset;
-        else if(offset<22) offset=14+offset-10;
-        else offset=28+offset-22;
-        entry=array_get(&(s->directory),s->directory.next-1-(i/26));
+    }
+    for (i = 0; i < 26 * number_of_entries; i++) {
+        uint8_t c;
+
+        entry = array_get(&s->directory, s->directory.next - i / 26 - 1);
         if (i >= 2 * length + 2) {
-            entry->name[offset] = 0xff;
+            c = 0xff;
         } else if (i % 2 == 0) {
-            entry->name[offset] = longname[i / 2] & 0xff;
+            c = longname[i / 2] & 0xff;
         } else {
-            entry->name[offset] = longname[i / 2] >> 8;
+            c = longname[i / 2] >> 8;
         }
+        write_long_filename(entry, i % 26, c);
     }
     g_free(longname);
     return array_get(&(s->directory),s->directory.next-number_of_entries);
@@ -731,7 +758,7 @@ static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
         /* calculate anew, because realloc could have taken place */
         entry_long=array_get(&(s->directory),long_index);
         while(entry_long<entry && is_long_name(entry_long)) {
-            entry_long->reserved[1]=chksum;
+            ((lfn_direntry_t *)entry_long)->sfn_checksum = chksum;
             entry_long++;
         }
     }
-- 
2.43.0


