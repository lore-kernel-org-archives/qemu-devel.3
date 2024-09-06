Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7045BCE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWyP-0002lR-Fh; Fri, 06 Sep 2024 07:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxh-0008U8-DF; Fri, 06 Sep 2024 07:17:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxf-0008A1-NJ; Fri, 06 Sep 2024 07:17:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 470B18C49B;
 Fri,  6 Sep 2024 14:12:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 53F22133704;
 Fri,  6 Sep 2024 14:13:27 +0300 (MSK)
Received: (nullmailer pid 353681 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Amjad Alsharafi <amjadsharafi10@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 42/69] vvfat: Fix usage of `info.file.offset`
Date: Fri,  6 Sep 2024 14:12:51 +0300
Message-Id: <20240906111324.353230-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Amjad Alsharafi <amjadsharafi10@gmail.com>

The field is marked as "the offset in the file (in clusters)", but it
was being used like this
`cluster_size*(nums)+mapping->info.file.offset`, which is incorrect.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <72f19a7903886dda1aa78bcae0e17702ee939262.1721470238.git.amjadsharafi10@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 21b25a0e466a5bba0a45600bb8100ab564202ed1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vvfat.c b/block/vvfat.c
index 19da009a5b..247b232608 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1408,7 +1408,9 @@ read_cluster_directory:
 
         assert(s->current_fd);
 
-        offset=s->cluster_size*(cluster_num-s->current_mapping->begin)+s->current_mapping->info.file.offset;
+        offset = s->cluster_size *
+            ((cluster_num - s->current_mapping->begin)
+            + s->current_mapping->info.file.offset);
         if(lseek(s->current_fd, offset, SEEK_SET)!=offset)
             return -3;
         s->cluster=s->cluster_buffer;
@@ -1929,8 +1931,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                         (mapping->mode & MODE_DIRECTORY) == 0) {
 
                     /* was modified in qcow */
-                    if (offset != mapping->info.file.offset + s->cluster_size
-                            * (cluster_num - mapping->begin)) {
+                    if (offset != s->cluster_size
+                            * ((cluster_num - mapping->begin)
+                            + mapping->info.file.offset)) {
                         /* offset of this cluster in file chain has changed */
                         abort();
                         copy_it = 1;
@@ -2404,7 +2407,7 @@ static int commit_mappings(BDRVVVFATState* s,
                         (mapping->end - mapping->begin);
             } else
                 next_mapping->info.file.offset = mapping->info.file.offset +
-                        mapping->end - mapping->begin;
+                        (mapping->end - mapping->begin);
 
             mapping = next_mapping;
         }
-- 
2.39.2


