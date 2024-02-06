Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E1CC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXFn1-0002ru-9b; Tue, 06 Feb 2024 02:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rXFmz-0002pB-CO
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rXFmx-0006nf-3T
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707204158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2eAYfrdETrq+ugmpVwXy4/rB2Kw0xNkS5/rTtGRH+Vo=;
 b=BRpTFGTo9Hk+IG3P/aAlqTZnBP4LtBIUk2QV86DJpVX2C3AqvuhGtjekInuUt3A3FqRcGd
 XsEEr2EabY9BNm1xqs3TTYPvAZF19Zk6vegayElRDEW20g8rJReJ8N6ztIrR5Z7xELsLEV
 6V+39YmJdom4kYWDrpPNaDARLEQSN4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-sicPpVQYNbSWnAnq9KbvWw-1; Tue, 06 Feb 2024 02:22:34 -0500
X-MC-Unique: sicPpVQYNbSWnAnq9KbvWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74A4E101FA2C;
 Tue,  6 Feb 2024 07:22:33 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E8321121312;
 Tue,  6 Feb 2024 07:22:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Mario Casquero <mcasquer@redhat.com>
Subject: [PULL v3 3/3] oslib-posix: initialize backend memory objects in
 parallel
Date: Tue,  6 Feb 2024 08:22:25 +0100
Message-ID: <20240206072225.21187-4-david@redhat.com>
In-Reply-To: <20240206072225.21187-1-david@redhat.com>
References: <20240206072225.21187-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mark Kanda <mark.kanda@oracle.com>

QEMU initializes preallocated backend memory as the objects are parsed from
the command line. This is not optimal in some cases (e.g. memory spanning
multiple NUMA nodes) because the memory objects are initialized in series.

Allow the initialization to occur in parallel (asynchronously). In order to
ensure optimal thread placement, asynchronous initialization requires prealloc
context threads to be in use.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <20240131165327.3154970-2-mark.kanda@oracle.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem.c     |   7 ++-
 hw/virtio/virtio-mem.c |   4 +-
 include/hw/qdev-core.h |   5 ++
 include/qemu/osdep.h   |  18 +++++-
 system/vl.c            |   9 +++
 util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
 util/oslib-win32.c     |   8 ++-
 7 files changed, 145 insertions(+), 37 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 987f6f591e..81a72ce40b 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -20,6 +20,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
+#include "hw/qdev-core.h"
 
 #ifdef CONFIG_NUMA
 #include <numaif.h>
@@ -237,7 +238,7 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
         uint64_t sz = memory_region_size(&backend->mr);
 
         if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
-                               backend->prealloc_context, errp)) {
+                               backend->prealloc_context, false, errp)) {
             return;
         }
         backend->prealloc = true;
@@ -323,6 +324,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
     void *ptr;
     uint64_t sz;
+    bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
 
     if (!bc->alloc) {
         return;
@@ -402,7 +404,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     if (backend->prealloc && !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
                                                 ptr, sz,
                                                 backend->prealloc_threads,
-                                                backend->prealloc_context, errp)) {
+                                                backend->prealloc_context,
+                                                async, errp)) {
         return;
     }
 }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 99ab989852..ffd119ebac 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -605,7 +605,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
         int fd = memory_region_get_fd(&vmem->memdev->mr);
         Error *local_err = NULL;
 
-        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
+        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
             static bool warned;
 
             /*
@@ -1248,7 +1248,7 @@ static int virtio_mem_prealloc_range_cb(VirtIOMEM *vmem, void *arg,
     int fd = memory_region_get_fd(&vmem->memdev->mr);
     Error *local_err = NULL;
 
-    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
+    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
         error_report_err(local_err);
         return -ENOMEM;
     }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index d47536eadb..9228e96c87 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1083,6 +1083,11 @@ typedef enum MachineInitPhase {
      */
     PHASE_ACCEL_CREATED,
 
+    /*
+     * Late backend objects have been created and initialized.
+     */
+    PHASE_LATE_BACKENDS_CREATED,
+
     /*
      * machine_class->init has been called, thus creating any embedded
      * devices and validating machine properties.  Devices created at
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c9692cc314..7d359dabc4 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -680,6 +680,8 @@ typedef struct ThreadContext ThreadContext;
  * @area: start address of the are to preallocate
  * @sz: the size of the area to preallocate
  * @max_threads: maximum number of threads to use
+ * @tc: prealloc context threads pointer, NULL if not in use
+ * @async: request asynchronous preallocation, requires @tc
  * @errp: returns an error if this function fails
  *
  * Preallocate memory (populate/prefault page tables writable) for the virtual
@@ -687,10 +689,24 @@ typedef struct ThreadContext ThreadContext;
  * each page in the area was faulted in writable at least once, for example,
  * after allocating file blocks for mapped files.
  *
+ * When setting @async, allocation might be performed asynchronously.
+ * qemu_finish_async_prealloc_mem() must be called to finish any asynchronous
+ * preallocation.
+ *
  * Return: true on success, else false setting @errp with error.
  */
 bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp);
+                       ThreadContext *tc, bool async, Error **errp);
+
+/**
+ * qemu_finish_async_prealloc_mem:
+ * @errp: returns an error if this function fails
+ *
+ * Finish all outstanding asynchronous memory preallocation.
+ *
+ * Return: true on success, else false setting @errp with error.
+ */
+bool qemu_finish_async_prealloc_mem(Error **errp);
 
 /**
  * qemu_get_pid_name:
diff --git a/system/vl.c b/system/vl.c
index bb959cbc44..2a0bd08ff1 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2013,6 +2013,14 @@ static void qemu_create_late_backends(void)
 
     object_option_foreach_add(object_create_late);
 
+    /*
+     * Wait for any outstanding memory prealloc from created memory
+     * backends to complete.
+     */
+    if (!qemu_finish_async_prealloc_mem(&error_fatal)) {
+        exit(1);
+    }
+
     if (tpm_init() < 0) {
         exit(1);
     }
@@ -3699,6 +3707,7 @@ void qemu_init(int argc, char **argv)
      * over memory-backend-file objects).
      */
     qemu_create_late_backends();
+    phase_advance(PHASE_LATE_BACKENDS_CREATED);
 
     /*
      * Note: creates a QOM object, must run only after global and
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7c297003b9..3c379f96c2 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -42,6 +42,7 @@
 #include "qemu/cutils.h"
 #include "qemu/units.h"
 #include "qemu/thread-context.h"
+#include "qemu/main-loop.h"
 
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
@@ -63,11 +64,15 @@
 
 struct MemsetThread;
 
+static QLIST_HEAD(, MemsetContext) memset_contexts =
+    QLIST_HEAD_INITIALIZER(memset_contexts);
+
 typedef struct MemsetContext {
     bool all_threads_created;
     bool any_thread_failed;
     struct MemsetThread *threads;
     int num_threads;
+    QLIST_ENTRY(MemsetContext) next;
 } MemsetContext;
 
 struct MemsetThread {
@@ -412,19 +417,44 @@ static inline int get_memset_num_threads(size_t hpagesize, size_t numpages,
     return ret;
 }
 
+static int wait_and_free_mem_prealloc_context(MemsetContext *context)
+{
+    int i, ret = 0, tmp;
+
+    for (i = 0; i < context->num_threads; i++) {
+        tmp = (uintptr_t)qemu_thread_join(&context->threads[i].pgthread);
+
+        if (tmp) {
+            ret = tmp;
+        }
+    }
+    g_free(context->threads);
+    g_free(context);
+    return ret;
+}
+
 static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
-                           int max_threads, ThreadContext *tc,
+                           int max_threads, ThreadContext *tc, bool async,
                            bool use_madv_populate_write)
 {
     static gsize initialized = 0;
-    MemsetContext context = {
-        .num_threads = get_memset_num_threads(hpagesize, numpages, max_threads),
-    };
+    MemsetContext *context = g_malloc0(sizeof(MemsetContext));
     size_t numpages_per_thread, leftover;
     void *(*touch_fn)(void *);
-    int ret = 0, i = 0;
+    int ret, i = 0;
     char *addr = area;
 
+    /*
+     * Asynchronous preallocation is only allowed when using MADV_POPULATE_WRITE
+     * and prealloc context for thread placement.
+     */
+    if (!use_madv_populate_write || !tc) {
+        async = false;
+    }
+
+    context->num_threads =
+        get_memset_num_threads(hpagesize, numpages, max_threads);
+
     if (g_once_init_enter(&initialized)) {
         qemu_mutex_init(&page_mutex);
         qemu_cond_init(&page_cond);
@@ -432,8 +462,11 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
     }
 
     if (use_madv_populate_write) {
-        /* Avoid creating a single thread for MADV_POPULATE_WRITE */
-        if (context.num_threads == 1) {
+        /*
+         * Avoid creating a single thread for MADV_POPULATE_WRITE when
+         * preallocating synchronously.
+         */
+        if (context->num_threads == 1 && !async) {
             if (qemu_madvise(area, hpagesize * numpages,
                              QEMU_MADV_POPULATE_WRITE)) {
                 return -errno;
@@ -445,50 +478,86 @@ static int touch_all_pages(char *area, size_t hpagesize, size_t numpages,
         touch_fn = do_touch_pages;
     }
 
-    context.threads = g_new0(MemsetThread, context.num_threads);
-    numpages_per_thread = numpages / context.num_threads;
-    leftover = numpages % context.num_threads;
-    for (i = 0; i < context.num_threads; i++) {
-        context.threads[i].addr = addr;
-        context.threads[i].numpages = numpages_per_thread + (i < leftover);
-        context.threads[i].hpagesize = hpagesize;
-        context.threads[i].context = &context;
+    context->threads = g_new0(MemsetThread, context->num_threads);
+    numpages_per_thread = numpages / context->num_threads;
+    leftover = numpages % context->num_threads;
+    for (i = 0; i < context->num_threads; i++) {
+        context->threads[i].addr = addr;
+        context->threads[i].numpages = numpages_per_thread + (i < leftover);
+        context->threads[i].hpagesize = hpagesize;
+        context->threads[i].context = context;
         if (tc) {
-            thread_context_create_thread(tc, &context.threads[i].pgthread,
+            thread_context_create_thread(tc, &context->threads[i].pgthread,
                                          "touch_pages",
-                                         touch_fn, &context.threads[i],
+                                         touch_fn, &context->threads[i],
                                          QEMU_THREAD_JOINABLE);
         } else {
-            qemu_thread_create(&context.threads[i].pgthread, "touch_pages",
-                               touch_fn, &context.threads[i],
+            qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
+                               touch_fn, &context->threads[i],
                                QEMU_THREAD_JOINABLE);
         }
-        addr += context.threads[i].numpages * hpagesize;
+        addr += context->threads[i].numpages * hpagesize;
+    }
+
+    if (async) {
+        /*
+         * async requests currently require the BQL. Add it to the list and kick
+         * preallocation off during qemu_finish_async_prealloc_mem().
+         */
+        assert(bql_locked());
+        QLIST_INSERT_HEAD(&memset_contexts, context, next);
+        return 0;
     }
 
     if (!use_madv_populate_write) {
-        sigbus_memset_context = &context;
+        sigbus_memset_context = context;
     }
 
     qemu_mutex_lock(&page_mutex);
-    context.all_threads_created = true;
+    context->all_threads_created = true;
     qemu_cond_broadcast(&page_cond);
     qemu_mutex_unlock(&page_mutex);
 
-    for (i = 0; i < context.num_threads; i++) {
-        int tmp = (uintptr_t)qemu_thread_join(&context.threads[i].pgthread);
+    ret = wait_and_free_mem_prealloc_context(context);
 
+    if (!use_madv_populate_write) {
+        sigbus_memset_context = NULL;
+    }
+    return ret;
+}
+
+bool qemu_finish_async_prealloc_mem(Error **errp)
+{
+    int ret = 0, tmp;
+    MemsetContext *context, *next_context;
+
+    /* Waiting for preallocation requires the BQL. */
+    assert(bql_locked());
+    if (QLIST_EMPTY(&memset_contexts)) {
+        return true;
+    }
+
+    qemu_mutex_lock(&page_mutex);
+    QLIST_FOREACH(context, &memset_contexts, next) {
+        context->all_threads_created = true;
+    }
+    qemu_cond_broadcast(&page_cond);
+    qemu_mutex_unlock(&page_mutex);
+
+    QLIST_FOREACH_SAFE(context, &memset_contexts, next, next_context) {
+        QLIST_REMOVE(context, next);
+        tmp = wait_and_free_mem_prealloc_context(context);
         if (tmp) {
             ret = tmp;
         }
     }
 
-    if (!use_madv_populate_write) {
-        sigbus_memset_context = NULL;
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "qemu_prealloc_mem: preallocating memory failed");
+        return false;
     }
-    g_free(context.threads);
-
-    return ret;
+    return true;
 }
 
 static bool madv_populate_write_possible(char *area, size_t pagesize)
@@ -498,7 +567,7 @@ static bool madv_populate_write_possible(char *area, size_t pagesize)
 }
 
 bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp)
+                       ThreadContext *tc, bool async, Error **errp)
 {
     static gsize initialized;
     int ret;
@@ -540,7 +609,7 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     }
 
     /* touch pages simultaneously */
-    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc,
+    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc, async,
                           use_madv_populate_write);
     if (ret) {
         error_setg_errno(errp, -ret,
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c4a5f05a49..b623830d62 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -265,7 +265,7 @@ int getpagesize(void)
 }
 
 bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp)
+                       ThreadContext *tc, bool async, Error **errp)
 {
     int i;
     size_t pagesize = qemu_real_host_page_size();
@@ -278,6 +278,12 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
     return true;
 }
 
+bool qemu_finish_async_prealloc_mem(Error **errp)
+{
+    /* async prealloc not supported, there is nothing to finish */
+    return true;
+}
+
 char *qemu_get_pid_name(pid_t pid)
 {
     /* XXX Implement me */
-- 
2.43.0


