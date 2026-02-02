Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31378E7FDC2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmztT-0000Oi-C1; Mon, 02 Feb 2026 14:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztO-0000MJ-V0; Mon, 02 Feb 2026 14:47:27 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztN-0003ER-HD; Mon, 02 Feb 2026 14:47:26 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5957E18509D;
 Mon, 02 Feb 2026 22:46:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0AD9735B27F;
 Mon, 02 Feb 2026 22:46:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 11/69] block: Fix BDS use after free during shutdown
Date: Mon,  2 Feb 2026 22:45:34 +0300
Message-ID: <20260202194638.939438-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kevin Wolf <kwolf@redhat.com>

During shutdown, blockdev_close_all_bdrv_states() drops any block node
references that are still owned by the monitor (i.e. the user). However,
in doing so, it forgot to also remove the node from monitor_bdrv_states
(which qmp_blockdev_del() correctly does), which means that later calls
of bdrv_first()/bdrv_next() will still return the (now stale) pointer to
the node.

Usually there is no such call after this point, but in some cases it can
happen. In the reported case, there was an ongoing migration, and the
migration thread wasn't shut down yet: migration_shutdown() called by
qemu_cleanup() doesn't actually wait for the migration to be shut down,
but may just move it to MIGRATION_STATUS_CANCELLING. The next time
migration_iteration_finish() runs, it sees the status and tries to
re-activate all block devices that migration may have previously
inactivated. This is where bdrv_first()/bdrv_next() get called and the
access to the already freed node happens.

It is debatable if migration_shutdown() should really return before
migration has settled, but leaving a dangling pointer in the list of
monitor-owned block nodes is clearly a bug either way and fixing it
solves the immediate problem, so fix it.

Cc: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20251215150714.130214-1-kwolf@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 307bc43095b8ab1765fd66c26003d5da06681c05)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/blockdev.c b/blockdev.c
index 1d1f27cfff..d4b36fa7a9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -685,6 +685,7 @@ void blockdev_close_all_bdrv_states(void)
 
     GLOBAL_STATE_CODE();
     QTAILQ_FOREACH_SAFE(bs, &monitor_bdrv_states, monitor_list, next_bs) {
+        QTAILQ_REMOVE(&monitor_bdrv_states, bs, monitor_list);
         bdrv_unref(bs);
     }
 }
-- 
2.47.3


