Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964EDC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0sN-00038o-WE; Tue, 12 Mar 2024 08:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ss0l=KS=redhat.com=clg@ozlabs.org>)
 id 1rk0sG-00034q-52; Tue, 12 Mar 2024 08:04:53 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ss0l=KS=redhat.com=clg@ozlabs.org>)
 id 1rk0sC-0008Ve-Gv; Tue, 12 Mar 2024 08:04:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TvC4S6gdYz4wnr;
 Tue, 12 Mar 2024 23:04:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvC4P4w8kz4wc7;
 Tue, 12 Mar 2024 23:04:37 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH for 9.0] migration: Skip only empty block devices
Date: Tue, 12 Mar 2024 13:04:31 +0100
Message-ID: <20240312120431.550054-1-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ss0l=KS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The block .save_setup() handler calls a helper routine
init_blk_migration() which builds a list of block devices to take into
account for migration. When one device is found to be empty (sectors
== 0), the loop exits and all the remaining devices are ignored. This
is a regression introduced when bdrv_iterate() was removed.

Change that by skipping only empty devices.

Cc: Markus Armbruster <armbru@redhat.com>
Suggested: Kevin Wolf <kwolf@redhat.com>
Fixes: fea68bb6e9fa ("block: Eliminate bdrv_iterate(), use bdrv_next()")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/block.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..2b9054889ad2ba739828594c50cf047703757e96 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -402,7 +402,10 @@ static int init_blk_migration(QEMUFile *f)
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
2.44.0


