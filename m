Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D045C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchqr-00013S-39; Wed, 21 Feb 2024 03:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchql-00012A-6g; Wed, 21 Feb 2024 03:21:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqi-000292-W4; Wed, 21 Feb 2024 03:21:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 039234F3C0;
 Wed, 21 Feb 2024 11:21:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C3D018609F;
 Wed, 21 Feb 2024 11:20:58 +0300 (MSK)
Received: (nullmailer pid 2141992 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 02/60] migration: Fix use-after-free of migration state
 object
Date: Wed, 21 Feb 2024 11:19:50 +0300
Message-Id: <20240221082058.2141850-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
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

From: Fabiano Rosas <farosas@suse.de>

We're currently allowing the process_incoming_migration_bh bottom-half
to run without holding a reference to the 'current_migration' object,
which leads to a segmentation fault if the BH is still live after
migration_shutdown() has dropped the last reference to
current_migration.

In my system the bug manifests as migrate_multifd() returning true
when it shouldn't and multifd_load_shutdown() calling
multifd_recv_terminate_threads() which crashes due to an uninitialized
multifd_recv_state.

Fix the issue by holding a reference to the object when scheduling the
BH and dropping it before returning from the BH. The same is already
done for the cleanup_bh at migrate_fd_cleanup_schedule().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1969
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240119233922.32588-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 27eb8499edb2bc952c29ddae0bdac9fc959bf7b1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index 3ce04b2aaf..ee5e0ba97a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -650,6 +650,7 @@ static void process_incoming_migration_bh(void *opaque)
                       MIGRATION_STATUS_COMPLETED);
     qemu_bh_delete(mis->bh);
     migration_incoming_state_destroy();
+    object_unref(OBJECT(migrate_get_current()));
 }
 
 static void coroutine_fn
@@ -708,6 +709,7 @@ process_incoming_migration_co(void *opaque)
     }
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
+    object_ref(OBJECT(migrate_get_current()));
     qemu_bh_schedule(mis->bh);
     return;
 fail:
-- 
2.39.2


