Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D66D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4W-0001BQ-6v; Fri, 11 Oct 2024 13:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1szJ4Q-0000hu-61
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1szHep-0007Ia-QB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jpM1xxNZzR1TWG4Eu4YrtZMHu7/KBbbXPSpDmfU5vwk=;
 b=bTgiNQzqFNY6lsxhrlABq0OYGcXjPxQV/e0NaHtPUKjo8jI5QaMh6QrCAH4xL6AwgY8CzC
 krckbuzQAV9YLzGdR05/2dq33OFQ2mYdoCwG6G+UdPXoUD2H+vdwXf+44bb1yA8JE9742E
 qPrwEjeE8ZKWIWVJ/2ndj4wdPzjDXcQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-G1-wIo7EOhm83O2TwrvGyQ-1; Fri, 11 Oct 2024 11:34:22 -0400
X-MC-Unique: G1-wIo7EOhm83O2TwrvGyQ-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a1a8b992d3so22904165ab.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660861; x=1729265661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jpM1xxNZzR1TWG4Eu4YrtZMHu7/KBbbXPSpDmfU5vwk=;
 b=QAnxddAgKOOo31488OfQ3RkyejlB5xgPmNGPSedF9Ob+0rYHRF71J2tbErQG7106gB
 +9A1jCAbk6dWUzODgmuhc+iL5rsDPRvobuFwGlHYOWLeokLRA2wwBadjHKg32GpEXubp
 Hc8TsOe5EhivCo/i7dlqIyRRfkIMwFR6isUlA0P/QpZeyfkmztCD8iWPne38Q70odfAZ
 c3B6cY6ZXWtQi2GeDumPXFsrcWvalig2xl9Pjl9B2NgP7oatKHYqnfF1P9kXS+coLSny
 HqcNz43MMkxUHA0lJ8o9UeQdJou9jJVcpOSoadk6CMIz0afAp6EAAHNSm5Y+TNVxsFcf
 mzlQ==
X-Gm-Message-State: AOJu0YwZPp8zj7HwvJgFkgTNNhJg2OsGA1aJDlj6TYk27BrTn74qm5VM
 GUHHrCzflcZEaWjic6hKqpE93sMg+rvaCQ8pZqjW1NsxQBFwcH8SzXGvuvQ6Qqnsi9UWkdGqx5K
 ygQam0zfZN5tOTeRRiRNAQFLLTdyxfDr5E5rm42A7FmAR1Dw25yQnDQIQwqvAu9WX86l95WXk10
 6SZGfWEwkqGvD4wwBZBmps29Btp52o11muuA==
X-Received: by 2002:a92:c24c:0:b0:3a0:9f36:6bf1 with SMTP id
 e9e14a558f8ab-3a3a71d1af6mr54409225ab.9.1728660861155; 
 Fri, 11 Oct 2024 08:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrO1OHSQVi7bOXnvoRhSRik6Pqm0dPjrLMJ4BXCd5Op7M/nL2yOgizqhsAnxyWHG5TOzWqEg==
X-Received: by 2002:a92:c24c:0:b0:3a0:9f36:6bf1 with SMTP id
 e9e14a558f8ab-3a3a71d1af6mr54409065ab.9.1728660860667; 
 Fri, 11 Oct 2024 08:34:20 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbad9b0e90sm675404173.15.2024.10.11.08.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:34:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Julia Suvorova <jusual@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>
Subject: [PATCH] migration: Remove interface query-migrationthreads
Date: Fri, 11 Oct 2024 11:34:17 -0400
Message-ID: <20241011153417.516715-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This reverts two commits:

671326201dac8fe91222ba0045709f04a8ec3af4
1b1f4ab69c41279a45ccd0d3178e83471e6e4ec1

Meanwhile it adds an entry to removed-features.rst for the
query-migrationthreads QMP command.

This patch originates from another patchset [1] that wanted to cleanup the
interface and add corresponding HMP command, as lots of things are missing
in the query report; so far it only reports the main thread and multifd
sender threads; all the rest migration threads are not reported, including
multifd recv threads.

As pointed out by Dan in the follow up discussions [1], the API is designed
in an awkward way where CPU pinning may not cover the whole lifecycle of
even the thread being reported.  When asked, we also didn't get chance to
hear from the developer who introduced this feature to explain how this API
can be properly used.

OTOH, this feature from debugging POV isn't very helpful either, as all
these information can be easily obtained by GDB.  Esepcially, if with
"-name $VM,debug-threads=on" we do already have names for each migration
threads (which covers more than multifd sender threads).

So it looks like the API isn't helpful in any form as of now, besides it
only adds maintenance burden to migration code, even if not much.

Considering that so far there's totally no justification on how to use this
interface correctly, let's remove this interface instead of cleaning it up.

In this special case, we even go beyond normal deprecation procedure,
because a deprecation process would only make sense when there are existing
users. In this specific case, we expect zero serious users with this API.

[1] https://lore.kernel.org/qemu-devel/20240930195837.825728-1-peterx@redhat.com/

Cc: Jiang Jiacheng <jiangjiacheng@huawei.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/removed-features.rst |  6 ++++
 qapi/migration.json             | 27 --------------
 migration/threadinfo.h          | 25 -------------
 migration/migration.c           |  6 ----
 migration/multifd.c             |  5 ---
 migration/threadinfo.c          | 64 ---------------------------------
 migration/meson.build           |  1 -
 7 files changed, 6 insertions(+), 128 deletions(-)
 delete mode 100644 migration/threadinfo.h
 delete mode 100644 migration/threadinfo.c

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c76b91a88d..02ca43dec7 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -693,6 +693,12 @@ Use ``multifd-channels`` instead.
 
 Use ``multifd-compression`` instead.
 
+``query-migrationthreads`` (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Removed with no replacement.  For debugging purpose, please use ``-name
+$VM,debug-threads=on`` instead.
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 3af6aa1740..5520a51553 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2264,33 +2264,6 @@
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
-# Returns information of migration threads
-#
-# Returns: @MigrationThreadInfo
-#
-# Since: 7.2
-##
-{ 'command': 'query-migrationthreads',
-  'returns': ['MigrationThreadInfo'] }
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
index 7609e0feed..12388c451d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -57,7 +57,6 @@
 #include "net/announce.h"
 #include "qemu/queue.h"
 #include "multifd.h"
-#include "threadinfo.h"
 #include "qemu/yank.h"
 #include "sysemu/cpus.h"
 #include "yank_functions.h"
@@ -3466,16 +3465,12 @@ static void qemu_savevm_wait_unplug(MigrationState *s, int old_state,
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
 
     object_ref(OBJECT(s));
@@ -3573,7 +3568,6 @@ out:
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-    migration_threads_remove(thread);
     return NULL;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 697fe86fdf..659022e817 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -26,7 +26,6 @@
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
-#include "threadinfo.h"
 #include "options.h"
 #include "qemu/yank.h"
 #include "io/channel-file.h"
@@ -570,13 +569,10 @@ int multifd_send_sync_main(void)
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
 
@@ -669,7 +665,6 @@ out:
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
index 66d3de86f0..28a680e5e2 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -29,7 +29,6 @@ system_ss.add(files(
   'savevm.c',
   'socket.c',
   'tls.c',
-  'threadinfo.c',
 ), gnutls, zlib)
 
 if get_option('replication').allowed()
-- 
2.45.0


