Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA66C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 02:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzol9-0000Yq-Qg; Wed, 24 Apr 2024 22:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzol8-0000Yf-4l
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:50 -0400
Received: from out-172.mta1.migadu.com ([2001:41d0:203:375::ac])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rzol5-0005Oc-Tq
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 22:22:49 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1714011766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyXscLmfoHanQlIuNZkg8+4DhXkI75Cog5suPvjmYdI=;
 b=F2zyZnilK80+knG+VXmNz8VTZVfz+39KbG1lLD25J8BJKm6sxtlYattU1fMw7YJSU/vBKU
 /BltPXWZjULEwmOhXYRPwXcKCjB0zGQufQwS/KmXi8Xxx6/CPzA6iMPcxXEuzJuIuS7USD
 02FnLbUFfz/v/cUuhOfoGCgRpoHthUc=
From: Hao Xiang <hao.xiang@linux.dev>
To: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: [PATCH v4 10/14] migration/multifd: Enable DSA offloading in multifd
 sender path.
Date: Thu, 25 Apr 2024 02:21:13 +0000
Message-Id: <20240425022117.4035031-11-hao.xiang@linux.dev>
In-Reply-To: <20240425022117.4035031-1-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ac;
 envelope-from=hao.xiang@linux.dev; helo=out-172.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Multifd sender path gets an array of pages queued by the migration
thread. It performs zero page checking on every page in the array.
The pages are classfied as either a zero page or a normal page. This
change uses Intel DSA to offload the zero page checking from CPU to
the DSA accelerator. The sender thread submits a batch of pages to DSA
hardware and waits for the DSA completion thread to signal for work
completion.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 migration/multifd-zero-page.c | 99 +++++++++++++++++++++++++++++++++--
 migration/multifd.c           | 27 +++++++++-
 migration/multifd.h           |  1 +
 3 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index e1b8370f88..4f426289e4 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -37,25 +37,83 @@ static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
 }
 
 /**
- * multifd_send_zero_page_detect: Perform zero page detection on all pages.
+ * zero_page_detect_cpu: Perform zero page detection using CPU.
  *
  * Sorts normal pages before zero pages in p->pages->offset and updates
  * p->pages->normal_num.
  *
  * @param p A pointer to the send params.
  */
-void multifd_send_zero_page_detect(MultiFDSendParams *p)
+static void zero_page_detect_cpu(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = p->pages;
     RAMBlock *rb = pages->block;
     int i = 0;
     int j = pages->num - 1;
 
-    if (!multifd_zero_page_enabled()) {
-        pages->normal_num = pages->num;
+    /*
+     * Sort the page offset array by moving all normal pages to
+     * the left and all zero pages to the right of the array.
+     */
+    while (i <= j) {
+        uint64_t offset = pages->offset[i];
+
+        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
+            i++;
+            continue;
+        }
+
+        swap_page_offset(pages->offset, i, j);
+        ram_release_page(rb->idstr, offset);
+        j--;
+    }
+
+    pages->normal_num = i;
+}
+
+
+#ifdef CONFIG_DSA_OPT
+
+static void swap_result(bool *results, int a, int b)
+{
+    bool temp;
+
+    if (a == b) {
         return;
     }
 
+    temp = results[a];
+    results[a] = results[b];
+    results[b] = temp;
+}
+
+/**
+ * zero_page_detect_dsa: Perform zero page detection using
+ * Intel Data Streaming Accelerator (DSA).
+ *
+ * Sorts normal pages before zero pages in p->pages->offset and updates
+ * p->pages->normal_num.
+ *
+ * @param p A pointer to the send params.
+ */
+static void zero_page_detect_dsa(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = p->pages;
+    RAMBlock *rb = pages->block;
+    bool *results = p->batch_task->results;
+
+    for (int i = 0; i < p->pages->num; i++) {
+        p->batch_task->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
+    }
+
+    buffer_is_zero_dsa_batch_async(p->batch_task,
+                                   (const void **)p->batch_task->addr,
+                                   p->pages->num,
+                                   p->page_size);
+
+    int i = 0;
+    int j = pages->num - 1;
+
     /*
      * Sort the page offset array by moving all normal pages to
      * the left and all zero pages to the right of the array.
@@ -63,11 +121,12 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
     while (i <= j) {
         uint64_t offset = pages->offset[i];
 
-        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
+        if (!results[i]) {
             i++;
             continue;
         }
 
+        swap_result(results, i, j);
         swap_page_offset(pages->offset, i, j);
         ram_release_page(rb->idstr, offset);
         j--;
@@ -76,6 +135,15 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
     pages->normal_num = i;
 }
 
+#else
+
+static void zero_page_detect_dsa(MultiFDSendParams *p)
+{
+    exit(1);
+}
+
+#endif
+
 void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
@@ -87,3 +155,24 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
         }
     }
 }
+
+/**
+ * multifd_send_zero_page_detect: Perform zero page detection on all pages.
+ *
+ * @param p A pointer to the send params.
+ */
+void multifd_send_zero_page_detect(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = p->pages;
+
+    if (!multifd_zero_page_enabled()) {
+        pages->normal_num = pages->num;
+        return;
+    }
+
+    if (dsa_is_running()) {
+        zero_page_detect_dsa(p);
+    } else {
+        zero_page_detect_cpu(p);
+    }
+}
diff --git a/migration/multifd.c b/migration/multifd.c
index cfd3a92f6c..7316643d0a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -818,6 +818,8 @@ void multifd_send_shutdown(void)
 
     multifd_send_terminate_threads();
 
+    dsa_cleanup();
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
@@ -1155,11 +1157,20 @@ bool multifd_send_setup(void)
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
     uint8_t i;
+    const char *dsa_parameter = migrate_multifd_dsa_accel();
 
     if (!migrate_multifd()) {
         return true;
     }
 
+    if (dsa_init(dsa_parameter)) {
+        error_setg(&local_err, "multifd: Sender failed to initialize DSA.");
+        error_report_err(local_err);
+        return false;
+    }
+
+    dsa_start();
+
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
@@ -1393,6 +1404,7 @@ void multifd_recv_cleanup(void)
             qemu_thread_join(&p->thread);
         }
     }
+    dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
     }
@@ -1568,6 +1580,9 @@ int multifd_recv_setup(Error **errp)
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
     uint8_t i;
+    const char *dsa_parameter = migrate_multifd_dsa_accel();
+    int ret;
+    Error *local_err = NULL;
 
     /*
      * Return successfully if multiFD recv state is already initialised
@@ -1577,6 +1592,15 @@ int multifd_recv_setup(Error **errp)
         return 0;
     }
 
+    ret = dsa_init(dsa_parameter);
+    if (ret != 0) {
+        error_setg(&local_err, "multifd: Receiver failed to initialize DSA.");
+        error_propagate(errp, local_err);
+        return ret;
+    }
+
+    dsa_start();
+
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
@@ -1616,13 +1640,12 @@ int multifd_recv_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
-        int ret;
-
         ret = multifd_recv_state->ops->recv_setup(p, errp);
         if (ret) {
             return ret;
         }
     }
+
     return 0;
 }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 16e27db5e9..b3717fae24 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -14,6 +14,7 @@
 #define QEMU_MIGRATION_MULTIFD_H
 
 #include "ram.h"
+#include "qemu/dsa.h"
 
 typedef struct MultiFDRecvData MultiFDRecvData;
 
-- 
2.30.2


