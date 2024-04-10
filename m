Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1EECD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSPw-0003el-Pg; Wed, 10 Apr 2024 03:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSPc-00030a-QR; Wed, 10 Apr 2024 03:30:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSPa-0005Mi-F7; Wed, 10 Apr 2024 03:30:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D2895D6BC;
 Wed, 10 Apr 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A5937B02FC;
 Wed, 10 Apr 2024 10:23:09 +0300 (MSK)
Received: (nullmailer pid 4191879 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 76/87] migration/postcopy: Ensure postcopy_start() sets
 errp if it fails
Date: Wed, 10 Apr 2024 10:22:49 +0300
Message-Id: <20240410072303.4191455-76-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Avihai Horon <avihaih@nvidia.com>

There are several places where postcopy_start() fails without setting
errp. This can cause a null pointer de-reference, as in case of error,
the caller of postcopy_start() copies/prints the error set in errp.

Fix it by setting errp in all of postcopy_start() error paths.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 908927db28ea ("migration: Update error description whenever migration fails")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240328140252.16756-3-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit d0ad271a7613459bd0a3397c8071a4ad06f3f7eb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index 982ab85f04..dbc6c3947c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2408,6 +2408,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
             migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+            error_setg(errp, "%s: Failed to establish preempt channel",
+                       __func__);
             return -1;
         }
     }
@@ -2427,17 +2429,22 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     global_state_store();
     ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed to stop the VM", __func__);
         goto fail;
     }
 
     ret = migration_maybe_pause(ms, &cur_state,
                                 MIGRATION_STATUS_POSTCOPY_ACTIVE);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed in migration_maybe_pause()",
+                         __func__);
         goto fail;
     }
 
     ret = bdrv_inactivate_all();
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "%s: Failed in bdrv_inactivate_all()",
+                         __func__);
         goto fail;
     }
     restart_block = true;
@@ -2514,6 +2521,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     /* Now send that blob */
     if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
+        error_setg(errp, "%s: Failed to send packaged data", __func__);
         goto fail_closefb;
     }
     qemu_fclose(fb);
-- 
2.39.2


