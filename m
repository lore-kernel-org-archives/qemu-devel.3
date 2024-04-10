Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5E6CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQo4-0002Oy-R3; Wed, 10 Apr 2024 01:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQmy-00072q-JV; Wed, 10 Apr 2024 01:46:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQmt-0001ng-Jb; Wed, 10 Apr 2024 01:46:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FCAD5D4EF;
 Wed, 10 Apr 2024 08:46:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E5B49B0156;
 Wed, 10 Apr 2024 08:44:17 +0300 (MSK)
Received: (nullmailer pid 4182071 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 23/41] migration: Skip only empty block devices
Date: Wed, 10 Apr 2024 08:43:44 +0300
Message-Id: <20240410054416.4181891-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

The block .save_setup() handler calls a helper routine
init_blk_migration() which builds a list of block devices to take into
account for migration. When one device is found to be empty (sectors
== 0), the loop exits and all the remaining devices are ignored. This
is a regression introduced when bdrv_iterate() was removed.

Change that by skipping only empty devices.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Fixes: fea68bb6e9fa ("block: Eliminate bdrv_iterate(), use bdrv_next()")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Link: https://lore.kernel.org/r/20240312120431.550054-1-clg@redhat.com
[peterx: fix "Suggested-by:"]
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 2e128776dc56f502c2ee41750afe83938f389528)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/block.c b/migration/block.c
index 4026b73f75..867901d2b1 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -415,7 +415,10 @@ static int init_blk_migration(QEMUFile *f)
         }
 
         sectors = bdrv_nb_sectors(bs);
-        if (sectors <= 0) {
+        if (sectors == 0) {
+            continue;
+        }
+        if (sectors < 0) {
             ret = sectors;
             bdrv_next_cleanup(&it);
             goto out;
-- 
2.39.2


