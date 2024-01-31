Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDECC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVAxK-0003eD-M9; Wed, 31 Jan 2024 08:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVAxA-0003bJ-77
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:48:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVAx7-00053G-91
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:48:35 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VD3iHt026701; Wed, 31 Jan 2024 13:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=u54WAkMqXuYeFFEYAZ/vlxh6EaqVAP+j541RsGLkzJw=;
 b=GEx1k3ACrNOw2W78cOeWY/M+nnVKHyjg44EvK7pvnNdzJXqeMIT/Sip6FviRXBl8aSlF
 aFMNDlUObHGCSfoP9hJpnTmlY3VnHJNbYl/5B51Tfcrq7o9X2rhjOcnce5Gs591EYZRA
 phH7XS29VDmQLqdTO4xpJkzxg39sYF4ikEW1Tl84EYd3cKaoxQ5vZNOJpjGAaeTe/z1e
 sSpmeOoth8CfnuY3kzIdtc+0F8jtalsBIL1+nh1VSxIBQBA/prjchm/3Z+APpdS+e8na
 HFp2hgFm8WzSD/tMI23lkUydaOCvttl2gh557sV0bA6bqSDylE9LDxeOoIgaupIu0dKU +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseuht1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 13:48:30 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40VCsbXo014626; Wed, 31 Jan 2024 13:48:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9f3epv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 13:48:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VDmSxI007814;
 Wed, 31 Jan 2024 13:48:28 GMT
Received: from linux-3.us.oracle.com (dhcp-10-39-210-13.vpn.oracle.com
 [10.39.210.13])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vvr9f3ep1-2; Wed, 31 Jan 2024 13:48:28 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, mark.kanda@oracle.com,
 berrange@redhat.com
Subject: [PATCH v3 1/1] oslib-posix: initialize backend memory objects in
 parallel
Date: Wed, 31 Jan 2024 07:48:43 -0600
Message-Id: <20240131134843.3074922-2-mark.kanda@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240131134843.3074922-1-mark.kanda@oracle.com>
References: <20240131134843.3074922-1-mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310106
X-Proofpoint-ORIG-GUID: 6fbsKhcfvh3MFX6s_Eb200gwEI6rYErR
X-Proofpoint-GUID: 6fbsKhcfvh3MFX6s_Eb200gwEI6rYErR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU initializes preallocated backend memory as the objects are parsed from
the command line. This is not optimal in some cases (e.g. memory spanning
multiple NUMA nodes) because the memory objects are initialized in series.

Allow the initialization to occur in parallel (asynchronously). In order to
ensure optimal thread placement, asynchronous initialization requires prealloc
context threads to be in use.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem.c     |   8 ++-
 hw/virtio/virtio-mem.c |   4 +-
 include/qemu/osdep.h   |  18 +++++-
 system/vl.c            |   8 +++
 util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
 util/oslib-win32.c     |   8 ++-
 6 files changed, 140 insertions(+), 37 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 30f69b2cb5..8f602dc86f 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -20,6 +20,7 @@
 #include "qom/object_interfaces.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
+#include "hw/qdev-core.h"
 
 #ifdef CONFIG_NUMA
 #include <numaif.h>
@@ -235,9 +236,10 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
         int fd = memory_region_get_fd(&backend->mr);
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
+        bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
 
         if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
-                               backend->prealloc_context, errp)) {
+                               backend->prealloc_context, async, errp)) {
             return;
         }
         backend->prealloc = true;
@@ -323,6 +325,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
     void *ptr;
     uint64_t sz;
+    bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
 
     if (!bc->alloc) {
         return;
@@ -398,7 +401,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
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
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c9692cc314..f45954b512 100644
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
+ * qemu_finish_async_mem_prealloc() must be called to finish any asynchronous
+ * preallocation.
+ *
  * Return: true on success, else false setting @errp with error.
  */
 bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
-                       ThreadContext *tc, Error **errp);
+                       ThreadContext *tc, bool async, Error **errp);
+
+/**
+ * qemu_finish_async_mem_prealloc:
+ * @errp: returns an error if this function fails
+ *
+ * Finish all outstanding asynchronous memory preallocation.
+ *
+ * Return: true on success, else false setting @errp with error.
+ */
+bool qemu_finish_async_mem_prealloc(Error **errp);
 
 /**
  * qemu_get_pid_name:
diff --git a/system/vl.c b/system/vl.c
index 788d88ea03..290bb3232b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
 
     object_option_foreach_add(object_create_late);
 
+    /*
+     * Wait for any outstanding memory prealloc from created memory
+     * backends to complete.
+     */
+    if (!qemu_finish_async_mem_prealloc(&error_fatal)) {
+        exit(1);
+    }
+
     if (tpm_init() < 0) {
         exit(1);
     }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7c297003b9..74493e3cf7 100644
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
+         * preallocation off during qemu_finish_async_mem_prealloc().
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
+bool qemu_finish_async_mem_prealloc(Error **errp)
+{
+    int ret, tmp;
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
index c4a5f05a49..107f0efe37 100644
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
 
+bool qemu_finish_async_mem_prealloc(Error **errp)
+{
+    /* async prealloc not supported, there is nothing to finish */
+    return true;
+}
+
 char *qemu_get_pid_name(pid_t pid)
 {
     /* XXX Implement me */
-- 
2.39.3


