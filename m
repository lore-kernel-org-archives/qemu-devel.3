Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0262C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC19-0008SK-NW; Thu, 06 Mar 2025 09:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0a-0007MN-Qv
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0X-0001o7-ME
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lBo8krjcIEnw3jWVq23SGS/3MsVWrcDF6+cmTHeCWXU=;
 b=gtIGxbXoUZCr+jfTWQQEpwBwYKOBy7v8aHeEzVT4bwrMbRzWAxFvu6EE1DLgPjbNVjZVsc
 LgJljzGYCYy9+Ifpz0LWeXciCcsi/FhQBOkFZx+aRX5R+CRK/1Q3oygoQT8NcQZYua/Pao
 3qKq3gv2daPp+sCaNU9Xf3UCNHB1Mho=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-qUgFnNE7MG6oznCWyK7O_Q-1; Thu,
 06 Mar 2025 09:15:19 -0500
X-MC-Unique: qUgFnNE7MG6oznCWyK7O_Q-1
X-Mimecast-MFC-AGG-ID: qUgFnNE7MG6oznCWyK7O_Q_1741270518
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43C56180AF67; Thu,  6 Mar 2025 14:15:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F44418009BC; Thu,  6 Mar 2025 14:15:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/42] migration: Always take BQL for
 migration_incoming_state_destroy()
Date: Thu,  6 Mar 2025 15:13:52 +0100
Message-ID: <20250306141419.2015340-17-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

All callers to migration_incoming_state_destroy() other than
postcopy_ram_listen_thread() do this call with BQL held.

Since migration_incoming_state_destroy() ultimately calls "load_cleanup"
SaveVMHandlers and it will soon call BQL-sensitive code it makes sense
to always call that function under BQL rather than to have it deal with
both cases (with BQL and without BQL).
Add the necessary bql_lock() and bql_unlock() to
postcopy_ram_listen_thread().

qemu_loadvm_state_main() in postcopy_ram_listen_thread() could call
"load_state" SaveVMHandlers that are expecting BQL to be held.

In principle, the only devices that should be arriving on migration
channel serviced by postcopy_ram_listen_thread() are those that are
postcopiable and whose load handlers are safe to be called without BQL
being held.

But nothing currently prevents the source from sending data for "unsafe"
devices which would cause trouble there.
Add a TODO comment there so it's clear that it would be good to improve
handling of such (erroneous) case in the future.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/21bb5ca337b1d5a802e697f553f37faf296b5ff4.1741193259.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/migration.c | 13 +++++++++++++
 migration/savevm.c    |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 9e9db26667f1adbeaae428be9b97750755c1c144..0bf70ea9717d73b0816f6ae52b99ae67924e8030 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -402,10 +402,23 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     multifd_recv_cleanup();
+
     /*
      * RAM state cleanup needs to happen after multifd cleanup, because
      * multifd threads can use some of its states (receivedmap).
+     * The VFIO load_cleanup() implementation is BQL-sensitive. It requires
+     * BQL must NOT be taken when recycling load threads, so that it won't
+     * block the load threads from making progress on address space
+     * modification operations.
+     *
+     * To make it work, we could try to not take BQL for all load_cleanup(),
+     * or conditionally unlock BQL only if bql_locked() in VFIO.
+     *
+     * Since most existing call sites take BQL for load_cleanup(), make
+     * it simple by taking BQL always as the rule, so that VFIO can unlock
+     * BQL and retake unconditionally.
      */
+    assert(bql_locked());
     qemu_loadvm_state_cleanup();
 
     if (mis->to_src_file) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 7c1aa8ad7b9d5c1460467c36e9923ed13768fbad..3e86b572cfa82c201b1bf935080a2e0ca651be0e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1986,6 +1986,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * in qemu_file, and thus we must be blocking now.
      */
     qemu_file_set_blocking(f, true);
+
+    /* TODO: sanity check that only postcopiable data will be loaded here */
     load_res = qemu_loadvm_state_main(f, mis);
 
     /*
@@ -2046,7 +2048,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * (If something broke then qemu will have to exit anyway since it's
      * got a bad migration state).
      */
+    bql_lock();
     migration_incoming_state_destroy();
+    bql_unlock();
 
     rcu_unregister_thread();
     mis->have_listen_thread = false;
-- 
2.48.1


