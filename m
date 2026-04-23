Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A39FC037B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwGC-0005Sh-Gh; Thu, 23 Apr 2026 11:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wFwFq-0005ST-7C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wFwFn-0007Kk-Uh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776959166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=whbzFQ4VHP3kJIXELgoI1gtvCiwr1NhPhtpv2xU4JYM=;
 b=N2mom7vT9bX19+8pe+zCnCzb5Mk+B7WF1aI0XPXb6YL0/iXXJMY6WCjNPrMMpHXzHu2K+u
 269DzawekedzkaQPOskCHf2WUnDyM69Z3CO9V+ajn9pftWW7bU3vEQ+PFfbb9rkRqFM+Rg
 bkiXoZsES/20qIgkVm31/EYVS3TzKkE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-aeA0Byb6Nd-Al1GiaGTttg-1; Thu,
 23 Apr 2026 11:46:02 -0400
X-MC-Unique: aeA0Byb6Nd-Al1GiaGTttg-1
X-Mimecast-MFC-AGG-ID: aeA0Byb6Nd-Al1GiaGTttg_1776959161
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDCC7195608F; Thu, 23 Apr 2026 15:46:00 +0000 (UTC)
Received: from fedora (unknown [10.43.3.182])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD714180047F; Thu, 23 Apr 2026 15:45:58 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [RFC PATCH] migration: Synchronize CPUs sooner in postcopy switchover
 phase
Date: Thu, 23 Apr 2026 17:45:20 +0200
Message-ID: <20260423154525.10292-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

Previously, the post init CPU synchronization with the accelerator, like
KVM, was performed in the bottom half of the POSTCOPY_RUN command
handler. However, this causes several problems.

First issue is that if CPU synchronization fails, the destination QEMU
crashes. However, it is too late to recover the source side as the
response to special PING has been already sent, and both sides are
already in the POSTCOPY_ACTIVE state.

By moving synchronization before responding, if the machine crashes, the
response is never sent and the source side can resume from the
POSTCOPY_DEVICE state.

Second issue is caused when migration is paused due to a network
failure or user command right after transitioning to the POSTCOPY_ACTIVE
state and the CPU synchronization causes a page fault. This page fault
blocks the CPU and the main QEMU threads and cannot be resolved until
postcopy migration is recovered. However, as libvirt also tries to
execute 'cont' QMP command at this time (destination side transitions
from POSTCOPY_DEVICE to POSTCOPY_ACTIVE), it will also halt waiting for
the response from the blocked main QEMU thread, unaware of the fact that
the migration is paused and needs to be recovered. Thus, it will wait
indefinitely and never report postcopy migration error.

When the CPU synchronization happens sooner, and the network fails
during it, the source side can transition from POSTCOPY_DEVICE to FAILED
state and resume safely. If migration is paused later, the main thread
won't be blocked by CPU synchronization and can respond to libvirt.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
I am posting this as RFC to discuss the point at which the CPU
synchronization should happen.

For the POSTCOPY_DEVICE state to be effective, this synchronization must
happen before the destination machine responds to the special PING
command. This leaves us with 2 options:

1) In the PING command handler before responding to the specific
   request, as proposed in this patch.

2) After loading CPU VMSD, for example in the post_load hook.

The first solution limits the number of places where synchronization
needs to happen, however, having it in the PING command handler feels
somewhat hacky.

I have also tested the second solution, and while it seems natural to
synchronize the CPU after its data is loaded in the post_load, there are
multiple CPU types and VMSDs and each one would need to call
synchronization in its post_load hook. This would basically revert Jan
Kiszka's commit [1] which refactored CPU synchronization and united it
to one place.

Kind of middle ground idea I have, is to add a special flag to VMSDs
that contain CPU data. After loading such VMSD the loadvm core would
then run CPU synchronization for that specific CPU. This solution would
bring the synchronization close to the actual load from the migration
stream but also keep it in one place.

[1]: ea375f9ab8c7 ("KVM: Rework VCPU state writeback API")
---
 migration/migration.c |  1 +
 migration/migration.h |  7 +++++++
 migration/savevm.c    | 16 +++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58..9753f7dc26 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -320,6 +320,7 @@ void migration_object_init(void)
     current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
 
     current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
+    current_incoming->postcopy_device_cpu_synchronized = false;
 
     migration_object_check(current_migration, &error_fatal);
 
diff --git a/migration/migration.h b/migration/migration.h
index b6888daced..799a686a0b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -210,6 +210,13 @@ struct MigrationIncomingState {
      */
     QemuSemaphore postcopy_pause_sem_fast_load;
 
+    /*
+     * CPUs have been synchronized during POSTCOPY_DEVICE state before
+     * responding to a special PING to source. This means, synchronization is
+     * not required later during loadvm_postcopy_handle_run_bh().
+     */
+    bool postcopy_device_cpu_synchronized;
+
     /* List of listening socket addresses  */
     SocketAddressList *socket_address_list;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index dd58f2a705..ad00c85887 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2143,9 +2143,10 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     /* TODO we should move all of this lot into postcopy_ram.c or a shared code
      * in migration.c
      */
-    cpu_synchronize_all_post_init();
-
-    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cpu-synced");
+    if (!mis->postcopy_device_cpu_synchronized) {
+        cpu_synchronize_all_post_init();
+        trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cpu-synced");
+    }
 
     qemu_announce_self(&mis->announce_timer, migrate_announce_params());
 
@@ -2510,6 +2511,15 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
                        tmp32);
             return -1;
         }
+        if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
+            /*
+             * Try synchronizing CPU before responding. If it fails, QEMU exits
+             * and source side can resume.
+             */
+            cpu_synchronize_all_post_init();
+            mis->postcopy_device_cpu_synchronized = true;
+            trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cpu-synced");
+        }
         migrate_send_rp_pong(mis, tmp32);
         return 0;
 
-- 
2.53.0


