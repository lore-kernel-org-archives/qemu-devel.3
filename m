Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7594CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWyf-0004Sq-DV; Fri, 06 Sep 2024 07:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWy4-0001YL-Kp; Fri, 06 Sep 2024 07:17:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWy2-0008AN-V0; Fri, 06 Sep 2024 07:17:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 631CE8C49D;
 Fri,  6 Sep 2024 14:12:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 700CD133706;
 Fri,  6 Sep 2024 14:13:27 +0300 (MSK)
Received: (nullmailer pid 353687 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Amjad Alsharafi <amjadsharafi10@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 44/69] vvfat: Fix reading files with non-continuous
 clusters
Date: Fri,  6 Sep 2024 14:12:53 +0300
Message-Id: <20240906111324.353230-44-mjt@tls.msk.ru>
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

When reading with `read_cluster` we get the `mapping` with
`find_mapping_for_cluster` and then we call `open_file` for this
mapping.
The issue appear when its the same file, but a second cluster that is
not immediately after it, imagine clusters `500 -> 503`, this will give
us 2 mappings one has the range `500..501` and another `503..504`, both
point to the same file, but different offsets.

When we don't open the file since the path is the same, we won't assign
`s->current_mapping` and thus accessing way out of bound of the file.

From our example above, after `open_file` (that didn't open anything) we
will get the offset into the file with
`s->cluster_size*(cluster_num-s->current_mapping->begin)`, which will
give us `0x2000 * (504-500)`, which is out of bound for this mapping and
will produce some issues.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
Message-ID: <1f3ea115779abab62ba32c788073cdc99f9ad5dd.1721470238.git.amjadsharafi10@gmail.com>
[kwolf: Simplified the patch based on Amjad's analysis and input]
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 5eed3db336506b529b927ba221fe0d836e5b8819)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vvfat.c b/block/vvfat.c
index b63ac5d045..213d7989e4 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1369,8 +1369,9 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
             return -1;
         vvfat_close_current_file(s);
         s->current_fd = fd;
-        s->current_mapping = mapping;
     }
+
+    s->current_mapping = mapping;
     return 0;
 }
 
-- 
2.39.2


