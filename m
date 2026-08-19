Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1A6C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwiS0-0005Os-61; Wed, 19 Aug 2026 11:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwiRy-0005Ok-7o
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwiRo-000227-VA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787154203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIZYh2HMKRjQS/uRnCLAvmQgv6BELsX2A0tA7NXCglI=;
 b=TmLKpeBJ7kXLKo9bu1ENDz9yePgLJCy4yKLEbbMEGnpKWKZbqHhSN/kF/aiRC4doAlEC0B
 YBGNar5t2JmO7KvyLxEIMI9bxAwTm9CL8pb/725sJPrGTTaSETiHHzSLujQKoIDTxY+joE
 CBXZjqEHL0MpkJh6sO03P5pHP29qGWU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-OMGXd9TbMbeQXypWXSkVtw-1; Wed, 19 Aug 2026 11:43:12 -0400
X-MC-Unique: OMGXd9TbMbeQXypWXSkVtw-1
X-Mimecast-MFC-AGG-ID: OMGXd9TbMbeQXypWXSkVtw_1787154192
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930b571432fso3397885a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787154192; x=1787758992; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eIZYh2HMKRjQS/uRnCLAvmQgv6BELsX2A0tA7NXCglI=;
 b=B4uzpP4f0l4U/7fQnuAIx07dYTsb4ZWkBcbRvJfSa7od1NceNq1YBOPKv02X0+EdeA
 abPTvC8o6gr5XP7SYik6qv7PLvjGgPaUIHN3MeHi5hulvpKappMblomP9if0BOEGHUMD
 vDdhpVzCZDZTDi8gYEN6Mbu98CIEmjM0nlsWQMWkUXa17qekKLo3UyJL7L4896jJKEkA
 OkWT5big2mf9i/olwSfJ6lG9GMdn4sfzMfOFF1FKId66NO95lHe3zkvruBqS1Om/c+kS
 cGBieLlJ63nwZHA5Pxx6NNRSL80wBKfZR0l9la3NYIiWrFiTJHNvNy1XosgOG65VMf2n
 2ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154192; x=1787758992;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eIZYh2HMKRjQS/uRnCLAvmQgv6BELsX2A0tA7NXCglI=;
 b=Jf0+BB9oGESZ1HyZUGCUeHPFO5L1LwRIA/cNMH09Ga75dQeXPBo98hczorML1fUj8+
 3XgNLj/SUs5yv1sp7pXbip6z/etrXx1OFbObjHGfh+hIwXgRopxb6FJn2ga0JWY7l0vT
 L1Jk2eqNBw8WXuDpiLcHKbJE/Ex1pYQPBVQLVrby9NeTG/NroK8vJq47e0340lHt/eQN
 2bkj9galSPsCvjq5Q71/EsGNcbnzh+HVIsbOnIqV/bWdufFrMCduZkrTNqznz1vJnV/G
 GH/Ty3INukrvqIqpF1BBMl+QgCZJlyIx8SHGzPkyZQXsdydyBMhzUzr7TFGyZt09OTIB
 tkdw==
X-Gm-Message-State: AOJu0Yw65GW7B++/8UHEFaZtOTOGcudn9eQkz3CJxc9vbVLRSk8jtfMD
 5LVqLTzWQk3wvQm5fFDfTbqWJbOxg7PU+KpqMG+FV4NlQ9gqtMa1jJhaaw0yT+XR4IZ2jZ62gmB
 e/afS2yHXScRkpwP8pdJAn3FBjVVNNreNjqboh4PiR4VmTfC8PjzMEqLC
X-Gm-Gg: AR+sD12IYX6vurtSW8Ia9GreUwTQ/hPza5CqdUZSa2VWqgQD3dJPgpOJjXno/chBP4V
 RSpgCCG1D0RFFVizx2o6kU/AlunEWYyAkQvpVqlOkxWPthT2anaEg13qeeUeCCK3KE0mZweo5g3
 HjgyA7vrKnFY/StXnWgrnAhNBb7GLJ3SBkqDV91MsA6b0jQs0W3HBDsDVztCp6jQRW+YnJIfiF7
 +2m72VyWv4v2CALFJeEAzqZaXZGbG5LxHuVfXSqn0UpRHCHCKM93IBRwOCe0+EXkGGBUFEPlHmJ
 IZeOr/pNYFO9EvecGpEz50BdP1kmVXz7k5bq+TFlWeP9K+T7Qi3N6FgDMyr/l8gT3Nw5
X-Received: by 2002:a05:620a:3941:b0:932:db03:4da3 with SMTP id
 af79cd13be357-9372854c587mr1481785a.19.1787154191669; 
 Wed, 19 Aug 2026 08:43:11 -0700 (PDT)
X-Received: by 2002:a05:620a:3941:b0:932:db03:4da3 with SMTP id
 af79cd13be357-9372854c587mr1473785a.19.1787154191073; 
 Wed, 19 Aug 2026 08:43:11 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9372056b71dsm157990485a.31.2026.08.19.08.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:43:09 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:42:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v5 00/11] migration: fast snapshot load
Message-ID: <aoXPAFDYLKxbTbWZ@x1.local>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Aug 16, 2026 at 11:16:20PM +0530, Aadeshveer Singh wrote:
> This series implements a "fast snapshot load" mechanism to
> significantly reduce the perceived resume time of a VM from a snapshot
> file.

This series breaks Windows builds... we'll need three fixups into three
patches to fix it.  Attached at the end.

For Aadeshveer: in the future you can check Windows build of your own
patches locally by running this:

  $ make docker-test-build@fedora-win64-cross

I do hit Rust build failures nowadays with Windows, though, so you may need
this if you have enabled rust builds instead (I also normally use J=N for
concurrency):

  $ J=8 EXTRA_CONFIGURE_OPTS=--disable-rust make docker-test-build@fedora-win64-cross

For Fabiano: if you want, you can also directly pick up the relevant
patches I queued in my -next branch, or squash the fixups attached, or pick
your own fix. I'll leave that to you to decide.

  https://gitlab.com/peterx/qemu/-/tree/next

Thanks,

===8<===



From 572b0f8b611e430e5ed8651d99851975878624c7 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 18 Aug 2026 16:38:08 -0400
Subject: [PATCH 1/3] fixup! migration: Propagate error in postcopy setup
 functions

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 81d06917fe..3c85fa1b19 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1906,7 +1906,7 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
     g_assert_not_reached();
 }
 
-int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
+int postcopy_ram_incoming_setup(MigrationIncomingState *mis, Error **errp)
 {
     g_assert_not_reached();
 }
-- 
2.54.0




From 4273cc6ed223de1781513af9a62c1672c3f5591b Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 19 Aug 2026 10:30:35 -0400
Subject: [PATCH 2/3] fixup! migration: Extract blocktime marking helper

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3c85fa1b19..fdc65c3545 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1934,6 +1934,14 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb)
 {
 }
+
+bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
+                                       RAMBlock *rb, ram_addr_t start,
+                                       uint64_t haddr, uint32_t tid)
+{
+    g_assert_not_reached();
+    return false;
+}
 #endif
 
 /* ------------------------------------------------------------------------- */
-- 
2.54.0



From d2d397de73fe39b424b2871fe4ba0df7937cc680 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 18 Aug 2026 16:43:29 -0400
Subject: [PATCH 3/3] fixup! migration: add eager load thread and setup for
 fast snapshot load

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 135 ++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 64 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fdc65c3545..885ab58fca 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -39,6 +39,8 @@
 #include "qemu/mmap-alloc.h"
 #include "options.h"
 
+static void postcopy_incoming_complete_bh(void *opaque);
+
 /* Arbitrary limit on size of each discard command,
  * keeps them around ~200 bytes
  */
@@ -1872,6 +1874,70 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
     }
 }
 
+/*
+ * Called by postcopy_ram_eager_load_thread over all blocks to load in all the
+ * pending pages of given ram block
+ */
+static int ram_block_load_eager(RAMBlock *rb, void *opaque)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    MigrationState *s = migrate_get_current();
+    Error *errp = NULL;
+    void *host = qemu_ram_get_host_addr(rb);
+    void *target;
+
+    for (ram_addr_t page_loc = 0; page_loc < rb->used_length;
+         page_loc += qemu_ram_pagesize(rb)) {
+        target = (uint8_t *)host + page_loc;
+        if (!postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)target,
+                                           RAM_CHANNEL_PRECOPY, &errp)) {
+            migrate_error_propagate(s, errp);
+            return -1;
+        }
+    }
+    return 0;
+}
+
+/*
+ * Used by fast snapshot load to eagerly load in all pages of RAM and schedule
+ * cleanup after entire RAM is loaded
+ */
+static void *postcopy_ram_eager_load_thread(void *opaque)
+{
+    MigrationIncomingState *mis = opaque;
+    MigrationStatus next_state;
+
+    trace_postcopy_ram_eager_load_thread_entry();
+    rcu_register_thread();
+    qemu_event_set(&mis->thread_sync_event);
+
+    if (foreach_not_ignored_block(ram_block_load_eager, NULL)) {
+        next_state = MIGRATION_STATUS_FAILED;
+    } else {
+        next_state = MIGRATION_STATUS_COMPLETED;
+    }
+    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      next_state);
+
+    postcopy_state_set(POSTCOPY_INCOMING_END);
+    migration_bh_schedule(postcopy_incoming_complete_bh, mis);
+
+    rcu_unregister_thread();
+    trace_postcopy_ram_eager_load_thread_exit();
+    return NULL;
+}
+
+/*
+ * Create thread for eager loading in fast snapshot load case
+ */
+void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
+{
+    postcopy_thread_create(
+        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_SNAPSHOT_LOAD,
+        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
+    mis->have_eager_load_thread = true;
+}
+
 #else
 /* No target OS support, stubs just fail */
 void fill_destination_postcopy_migration_info(MigrationInfo *info)
@@ -1942,6 +2008,11 @@ bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
     g_assert_not_reached();
     return false;
 }
+
+void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
+{
+    g_assert_not_reached();
+}
 #endif
 
 /* ------------------------------------------------------------------------- */
@@ -2426,67 +2497,3 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
 
     return rc;
 }
-
-/*
- * Called by postcopy_ram_eager_load_thread over all blocks to load in all the
- * pending pages of given ram block
- */
-static int ram_block_load_eager(RAMBlock *rb, void *opaque)
-{
-    MigrationIncomingState *mis = migration_incoming_get_current();
-    MigrationState *s = migrate_get_current();
-    Error *errp = NULL;
-    void *host = qemu_ram_get_host_addr(rb);
-    void *target;
-
-    for (ram_addr_t page_loc = 0; page_loc < rb->used_length;
-         page_loc += qemu_ram_pagesize(rb)) {
-        target = (uint8_t *)host + page_loc;
-        if (!postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)target,
-                                           RAM_CHANNEL_PRECOPY, &errp)) {
-            migrate_error_propagate(s, errp);
-            return -1;
-        }
-    }
-    return 0;
-}
-
-/*
- * Used by fast snapshot load to eagerly load in all pages of RAM and schedule
- * cleanup after entire RAM is loaded
- */
-static void *postcopy_ram_eager_load_thread(void *opaque)
-{
-    MigrationIncomingState *mis = opaque;
-    MigrationStatus next_state;
-
-    trace_postcopy_ram_eager_load_thread_entry();
-    rcu_register_thread();
-    qemu_event_set(&mis->thread_sync_event);
-
-    if (foreach_not_ignored_block(ram_block_load_eager, NULL)) {
-        next_state = MIGRATION_STATUS_FAILED;
-    } else {
-        next_state = MIGRATION_STATUS_COMPLETED;
-    }
-    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                      next_state);
-
-    postcopy_state_set(POSTCOPY_INCOMING_END);
-    migration_bh_schedule(postcopy_incoming_complete_bh, mis);
-
-    rcu_unregister_thread();
-    trace_postcopy_ram_eager_load_thread_exit();
-    return NULL;
-}
-
-/*
- * Create thread for eager loading in fast snapshot load case
- */
-void postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
-{
-    postcopy_thread_create(
-        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_SNAPSHOT_LOAD,
-        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
-    mis->have_eager_load_thread = true;
-}
-- 
2.54.0


-- 
Peter Xu


