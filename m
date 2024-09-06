Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22C5C54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRNg-0007OL-Bz; Fri, 06 Sep 2024 01:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRNK-00054J-HC; Fri, 06 Sep 2024 01:19:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRNA-0008E6-GE; Fri, 06 Sep 2024 01:19:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E871A8C131;
 Fri,  6 Sep 2024 08:15:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 98EB4133376;
 Fri,  6 Sep 2024 08:16:35 +0300 (MSK)
Received: (nullmailer pid 10470 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Amjad Alsharafi <amjadsharafi10@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 28/40] vvfat: Fix wrong checks for cluster mappings
 invariant
Date: Fri,  6 Sep 2024 08:16:16 +0300
Message-Id: <20240906051633.10288-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
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

How this `abort` was intended to check for was:
- if the `mapping->first_mapping_index` is not the same as
  `first_mapping_index`, which **should** happen only in one case,
  when we are handling the first mapping, in that case
  `mapping->first_mapping_index == -1`, in all other cases, the other
  mappings after the first should have the condition `true`.
- From above, we know that this is the first mapping, so if the offset
  is not `0`, then abort, since this is an invalid state.

The issue was that `first_mapping_index` is not set if we are
checking from the middle, the variable `first_mapping_index` is
only set if we passed through the check `cluster_was_modified` with the
first mapping, and in the same function call we checked the other
mappings.

One approach is to go into the loop even if `cluster_was_modified`
is not true so that we will be able to set `first_mapping_index` for the
first mapping, but since `first_mapping_index` is only used here,
another approach is to just check manually for the
`mapping->first_mapping_index != -1` since we know that this is the
value for the only entry where `offset == 0` (i.e. first mapping).

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <b0fbca3ee208c565885838f6a7deeaeb23f4f9c2.1721470238.git.amjadsharafi10@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit f60a6f7e17bf2a2a0f0a08265ac9b077fce42858)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vvfat.c b/block/vvfat.c
index 3a83ab5af4..1adcc6040f 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1879,7 +1879,6 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
 
     uint32_t cluster_num = begin_of_direntry(direntry);
     uint32_t offset = 0;
-    int first_mapping_index = -1;
     mapping_t* mapping = NULL;
     const char* basename2 = NULL;
 
@@ -1941,14 +1940,9 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
 
                         if (strcmp(basename, basename2))
                             copy_it = 1;
-                        first_mapping_index = array_index(&(s->mapping), mapping);
-                    }
-
-                    if (mapping->first_mapping_index != first_mapping_index
-                            && mapping->info.file.offset > 0) {
-                        abort();
-                        copy_it = 1;
                     }
+                    assert(mapping->first_mapping_index == -1
+                            || mapping->info.file.offset > 0);
 
                     /* need to write out? */
                     if (!was_modified && is_file(direntry)) {
-- 
2.39.2


