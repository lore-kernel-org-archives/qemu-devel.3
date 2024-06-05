Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6374C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 12:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEpS9-0004sp-P2; Wed, 05 Jun 2024 08:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sEpS3-0004sN-Tw
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:09:11 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sEpS1-00066P-N5
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:09:11 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C58C144D7D;
 Wed,  5 Jun 2024 14:08:58 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, stefanha@redhat.com,
 pbonzini@redhat.com
Subject: [RFC PATCH] migration/savevm: do not schedule snapshot_save_job_bh in
 qemu_aio_context
Date: Wed,  5 Jun 2024 14:08:48 +0200
Message-Id: <20240605120848.358654-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The fact that the snapshot_save_job_bh() is scheduled in the main
loop's qemu_aio_context AioContext means that it might get executed
during a vCPU thread's aio_poll(). But saving of the VM state cannot
happen while the guest or devices are active and can lead to assertion
failures. See issue #2111 for two examples. Avoid the problem by
scheduling the snapshot_save_job_bh() in the iohandler AioContext,
which is not polled by vCPU threads.

Solves Issue #2111.

This change also solves the following issue:

Since commit effd60c878 ("monitor: only run coroutine commands in
qemu_aio_context"), the 'snapshot-save' QMP call would not respond
right after starting the job anymore, but only after the job finished,
which can take a long time. The reason is, because after commit
effd60c878, do_qmp_dispatch_bh() runs in the iohandler AioContext.
When do_qmp_dispatch_bh() wakes the qmp_dispatch() coroutine, the
coroutine cannot be entered immediately anymore, but needs to be
scheduled to the main loop's qemu_aio_context AioContext. But
snapshot_save_job_bh() was scheduled first to the same AioContext and
thus gets executed first.

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2111
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

While initial smoke testing seems fine, I'm not familiar enough with
this to rule out any pitfalls with the approach. Any reason why
scheduling to the iohandler AioContext could be wrong here?

Should the same be done for the snapshot_load_job_bh and
snapshot_delete_job_bh to keep it consistent?

 migration/savevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c621f2359b..0086b76ab0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3459,7 +3459,7 @@ static int coroutine_fn snapshot_save_job_run(Job *job, Error **errp)
     SnapshotJob *s = container_of(job, SnapshotJob, common);
     s->errp = errp;
     s->co = qemu_coroutine_self();
-    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+    aio_bh_schedule_oneshot(iohandler_get_aio_context(),
                             snapshot_save_job_bh, job);
     qemu_coroutine_yield();
     return s->ret ? 0 : -1;
-- 
2.39.2



