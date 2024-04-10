Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC426CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSQP-0004uy-O9; Wed, 10 Apr 2024 03:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQ8-0004Ze-WF; Wed, 10 Apr 2024 03:31:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQ6-0005Px-NX; Wed, 10 Apr 2024 03:31:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 79F0F5D6C2;
 Wed, 10 Apr 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1DE46B0302;
 Wed, 10 Apr 2024 10:23:10 +0300 (MSK)
Received: (nullmailer pid 4191898 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Wei Wang <wei.w.wang@intel.com>,
 Lei Wang <lei4.wang@intel.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 82/87] migration/postcopy: ensure preempt channel is
 ready before loading states
Date: Wed, 10 Apr 2024 10:22:55 +0300
Message-Id: <20240410072303.4191455-82-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Wei Wang <wei.w.wang@intel.com>

Before loading the guest states, ensure that the preempt channel has been
ready to use, as some of the states (e.g. via virtio_load) might trigger
page faults that will be handled through the preempt channel. So yield to
the main thread in the case that the channel create event hasn't been
dispatched.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 9358982744 ("migration: Send requested page directly in rp-return thread")
Originally-by: Lei Wang <lei4.wang@intel.com>
Link: https://lore.kernel.org/all/9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com/T/
Signed-off-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Link: https://lore.kernel.org/r/20240405034056.23933-1-wei.w.wang@intel.com
[peterx: add a todo section, add Fixes and copy stable for 8.0+]
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 7afbdada7effbc2b97281bfbce0c6df351a3cf88)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/savevm.c b/migration/savevm.c
index eec5503a42..f374da85b9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2343,6 +2343,27 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
 
     QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
 
+    /*
+     * Before loading the guest states, ensure that the preempt channel has
+     * been ready to use, as some of the states (e.g. via virtio_load) might
+     * trigger page faults that will be handled through the preempt channel.
+     * So yield to the main thread in the case that the channel create event
+     * hasn't been dispatched.
+     *
+     * TODO: if we can move migration loadvm out of main thread, then we
+     * won't block main thread from polling the accept() fds.  We can drop
+     * this as a whole when that is done.
+     */
+    do {
+        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
+            mis->postcopy_qemufile_dst) {
+            break;
+        }
+
+        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
+        qemu_coroutine_yield();
+    } while (1);
+
     ret = qemu_loadvm_state_main(packf, mis);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
-- 
2.39.2


