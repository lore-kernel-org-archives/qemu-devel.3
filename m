Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF28D185F0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpY2-0001us-Fg; Thu, 08 Jan 2026 07:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdpXw-0001ty-CH
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdpXt-0005Kw-PN
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767876920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbyNt96iOeo5MCGW1ot6kEtB7evQ7Ysg+18NbyH35aQ=;
 b=AzQYqupONQjmzkw/OmvK/JGaqDeWc1CvrYpl0lgo3SqjHi/jY9w7zAs/SjcEePP7hO04Zu
 b8syTzgvDpju7zgQ/TM7EC9Vm5A05ruD5WPsZ9mXCjXO7m0fKM/hUdlzVNgJnApx5WyXp7
 STKPNqyuyojx78I9n3tiSr5I6/MfJDU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-JP5wMj5GOimk-fJkVm8OLw-1; Thu,
 08 Jan 2026 07:55:17 -0500
X-MC-Unique: JP5wMj5GOimk-fJkVm8OLw-1
X-Mimecast-MFC-AGG-ID: JP5wMj5GOimk-fJkVm8OLw_1767876916
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE21F1956096; Thu,  8 Jan 2026 12:55:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A03618008FF; Thu,  8 Jan 2026 12:55:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB4A621E61A9; Thu, 08 Jan 2026 13:55:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, devel@lists.libvirt.org,
 eblake@redhat.com
Subject: [PATCH 1/2] migration: Drop deprecated QMP command
 query-migrationthreads
Date: Thu,  8 Jan 2026 13:55:11 +0100
Message-ID: <20260108125512.2234147-2-armbru@redhat.com>
In-Reply-To: <20260108125512.2234147-1-armbru@redhat.com>
References: <20260108125512.2234147-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Deprecated in commit 228529d1fec3 (migration: Deprecate
query-migrationthreads command), v9.2.0.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/deprecated.rst       |  8 -----
 docs/about/removed-features.rst |  9 +++++
 qapi/migration.json             | 30 ----------------
 migration/threadinfo.h          | 25 -------------
 migration/migration.c           |  6 ----
 migration/multifd.c             |  5 ---
 migration/threadinfo.c          | 64 ---------------------------------
 migration/meson.build           |  1 -
 8 files changed, 9 insertions(+), 139 deletions(-)
 delete mode 100644 migration/threadinfo.h
 delete mode 100644 migration/threadinfo.c

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7abb3dab59..e9b019b41c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -111,14 +111,6 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
-``query-migrationthreads`` (since 9.2)
-''''''''''''''''''''''''''''''''''''''
-
-To be removed with no replacement, as it reports only a limited set of
-threads (for example, it only reports source side of multifd threads,
-without reporting any destination threads, or non-multifd source threads).
-For debugging purpose, please use ``-name $VM,debug-threads=on`` instead.
-
 ``block-job-pause`` (since 10.1)
 ''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e81d79da47..9e5a4dcbac 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -751,6 +751,15 @@ or list arguments were silently ignored. Other argument types were not
 checked, but an implicit conversion happened, so that e.g. string
 values could be assigned to integer device properties or vice versa.
 
+``query-migrationthreads`` (removed in 11.0)
+''''''''''''''''''''''''''''''''''''''
+
+Removed with no replacement, as it reported only a limited set of
+threads (for example, it only reported source side of multifd threads,
+without reporting any destination threads, or non-multifd source
+threads).  For debugging purpose, please use ``-name
+$VM,debug-threads=on`` instead.
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 201dedd982..7bd24e66e9 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2054,36 +2054,6 @@
 { 'command': 'query-vcpu-dirty-limit',
   'returns': [ 'DirtyLimitInfo' ] }
 
-##
-# @MigrationThreadInfo:
-#
-# Information about migrationthreads
-#
-# @name: the name of migration thread
-#
-# @thread-id: ID of the underlying host thread
-#
-# Since: 7.2
-##
-{ 'struct': 'MigrationThreadInfo',
-  'data': {'name': 'str',
-           'thread-id': 'int'} }
-
-##
-# @query-migrationthreads:
-#
-# Return information of migration threads
-#
-# Features:
-#
-# @deprecated: This command is deprecated with no replacement yet.
-#
-# Since: 7.2
-##
-{ 'command': 'query-migrationthreads',
-  'returns': ['MigrationThreadInfo'],
-  'features': ['deprecated'] }
-
 ##
 # @snapshot-save:
 #
diff --git a/migration/threadinfo.h b/migration/threadinfo.h
deleted file mode 100644
index 2f356ff312..0000000000
--- a/migration/threadinfo.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  Migration Threads info
- *
- *  Copyright (c) 2022 HUAWEI TECHNOLOGIES CO., LTD.
- *
- *  Authors:
- *  Jiang Jiacheng <jiangjiacheng@huawei.com>
- *
- *  This work is licensed under the terms of the GNU GPL, version 2 or later.
- *  See the COPYING file in the top-level directory.
- */
-
-#include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
-
-typedef struct MigrationThread MigrationThread;
-
-struct MigrationThread {
-    const char *name; /* the name of migration thread */
-    int thread_id; /* ID of the underlying host thread */
-    QLIST_ENTRY(MigrationThread) node;
-};
-
-MigrationThread *migration_threads_add(const char *name, int thread_id);
-void migration_threads_remove(MigrationThread *info);
diff --git a/migration/migration.c b/migration/migration.c
index 9d1bf5d276..94ade36574 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -59,7 +59,6 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
-#include "threadinfo.h"
 #include "qemu/yank.h"
 #include "system/cpus.h"
 #include "yank_functions.h"
@@ -3746,16 +3745,12 @@ static void qemu_savevm_wait_unplug(MigrationState *s, int old_state,
 static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
-    MigrationThread *thread = NULL;
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     MigThrError thr_error;
     bool urgent = false;
     Error *local_err = NULL;
     int ret;
 
-    thread = migration_threads_add(MIGRATION_THREAD_SRC_MAIN,
-                                   qemu_get_thread_id());
-
     rcu_register_thread();
 
     update_iteration_initial_status(s);
@@ -3856,7 +3851,6 @@ out:
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-    migration_threads_remove(thread);
     return NULL;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index bf6da85af8..8d8f23b4b9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -29,7 +29,6 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
-#include "threadinfo.h"
 #include "options.h"
 #include "qemu/yank.h"
 #include "io/channel-file.h"
@@ -662,13 +661,10 @@ int multifd_send_sync_main(MultiFDSyncReq req)
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
-    MigrationThread *thread = NULL;
     Error *local_err = NULL;
     int ret = 0;
     bool use_packets = multifd_use_packets();
 
-    thread = migration_threads_add(p->name, qemu_get_thread_id());
-
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
 
@@ -783,7 +779,6 @@ out:
     }
 
     rcu_unregister_thread();
-    migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->packets_sent);
 
     return NULL;
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
deleted file mode 100644
index 262990dd75..0000000000
--- a/migration/threadinfo.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- *  Migration Threads info
- *
- *  Copyright (c) 2022 HUAWEI TECHNOLOGIES CO., LTD.
- *
- *  Authors:
- *  Jiang Jiacheng <jiangjiacheng@huawei.com>
- *
- *  This work is licensed under the terms of the GNU GPL, version 2 or later.
- *  See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/queue.h"
-#include "qemu/lockable.h"
-#include "threadinfo.h"
-
-QemuMutex migration_threads_lock;
-static QLIST_HEAD(, MigrationThread) migration_threads;
-
-static void __attribute__((constructor)) migration_threads_init(void)
-{
-    qemu_mutex_init(&migration_threads_lock);
-}
-
-MigrationThread *migration_threads_add(const char *name, int thread_id)
-{
-    MigrationThread *thread =  g_new0(MigrationThread, 1);
-    thread->name = name;
-    thread->thread_id = thread_id;
-
-    WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
-        QLIST_INSERT_HEAD(&migration_threads, thread, node);
-    }
-
-    return thread;
-}
-
-void migration_threads_remove(MigrationThread *thread)
-{
-    QEMU_LOCK_GUARD(&migration_threads_lock);
-    if (thread) {
-        QLIST_REMOVE(thread, node);
-        g_free(thread);
-    }
-}
-
-MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
-{
-    MigrationThreadInfoList *head = NULL;
-    MigrationThreadInfoList **tail = &head;
-    MigrationThread *thread = NULL;
-
-    QEMU_LOCK_GUARD(&migration_threads_lock);
-    QLIST_FOREACH(thread, &migration_threads, node) {
-        MigrationThreadInfo *info = g_new0(MigrationThreadInfo, 1);
-        info->name = g_strdup(thread->name);
-        info->thread_id = thread->thread_id;
-
-        QAPI_LIST_APPEND(tail, info);
-    }
-
-    return head;
-}
diff --git a/migration/meson.build b/migration/meson.build
index 16909d54c5..c7f39bdb55 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -36,7 +36,6 @@ system_ss.add(files(
   'savevm.c',
   'socket.c',
   'tls.c',
-  'threadinfo.c',
 ), gnutls, zlib)
 
 if get_option('replication').allowed()
-- 
2.52.0


