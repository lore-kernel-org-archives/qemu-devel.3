Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37436CED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygQ4-0003PB-Ik; Wed, 09 Oct 2024 19:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPP-00035F-1q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:48:03 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygPN-0006em-0Y
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:58 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbd1a4217dso3951606d6.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728517676; x=1729122476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlYEPr5EXzua/WZWQ/aIB6wAzegCRf16oOTlmRliNYk=;
 b=ObGJZHKKYgdrfAdi43cTCGzlqGroxmwFLAB2IXilrv3+88/IaaJPjer+4+khVsqdZa
 pGndsPEJBLiPIWrEnTKHOxwTGhntlfys/knzJvi/J/kz55L0mKWNFrlshkgS5ep8wxct
 vHqqX24RnEbnJSwbpBdwR7YiOFK2/CNGk+94OxPeZ7gyoQt7xWk/+7LnKyVRQvA2B21X
 5Sza5fD/S7BkC4jz3q41KKxq/voMWHLbxVysxD3lHPufxh+67lnhmYGb0sC+osG9bqoV
 OnCTc6VFfLe22NJvuoPnQUOsqDv8qHfa4SqgQ9BI91fo5s4qyZh76yXpm9W/9fkrOiPu
 HjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517676; x=1729122476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlYEPr5EXzua/WZWQ/aIB6wAzegCRf16oOTlmRliNYk=;
 b=X8Bk1OI+HdWhze6DrdVtyZ7lVmDL/RVaqr3cIqGXWJcpC8qaGBQXpJK6FUkyeBvX/X
 Cqnm4U/RfFnReii3fHloMp9LT4glmxGezeL9xVFMeHWM3kajgfsqQQn8IZSvGrtBg68m
 4zW8lvksPRjgnb2gIk1VeDS1xgxXaJK12TEiljW5TLyrXjIgFKi3jKbYihf5P1b1wEHF
 z50xjGOqscQFex21L2mXBoKO0+xY+2T6NBV0nBLkkIkj0Jo+GSGiWvBBlURmumFR7HKU
 jArtblW0qCho/POr+4zNRZzCSb0nDCpnlpEMxmTjKXuiBKmrMUh/2uC/6WtTVeIYPIww
 Nhpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJWL2+EayD1sRM9V+z14wTy/rgwIwCcQWqoyOQ5teY7D0e2OhzEyGjX3QpkkZcGZcL7DaDS+QN14A/@nongnu.org
X-Gm-Message-State: AOJu0YxfKx2G2qio7CM1ZFCRyb8GXzwRVkaNfixRj5Zb2lcLGqRLUBY4
 R5Kbm+7oDPCfHJw0kzqz0yPrOtAPyE9m46cVQU1NTCDQisKDhFD5QlDCFyyy9JQ=
X-Google-Smtp-Source: AGHT+IGHI2l0RZMfI4/bgExczjxcWjkpzeWqZYTlDzfMuipTKy45fYIU7ZwYDsrDM7i5HsHX363YxA==
X-Received: by 2002:a05:6214:5d0c:b0:6cb:e409:8d9a with SMTP id
 6a1803df08f44-6cbe4098dc3mr33563426d6.8.1728517675763; 
 Wed, 09 Oct 2024 16:47:55 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([2605:a7c0:0:301::44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d856fsm264386d6.72.2024.10.09.16.47.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 16:47:55 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v6 09/12] migration/multifd: Enable DSA offloading in multifd
 sender path.
Date: Wed,  9 Oct 2024 16:46:07 -0700
Message-Id: <20241009234610.27039-10-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hao Xiang <hao.xiang@linux.dev>

Multifd sender path gets an array of pages queued by the migration
thread. It performs zero page checking on every page in the array.
The pages are classfied as either a zero page or a normal page. This
change uses Intel DSA to offload the zero page checking from CPU to
the DSA accelerator. The sender thread submits a batch of pages to DSA
hardware and waits for the DSA completion thread to signal for work
completion.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 migration/multifd-zero-page.c | 133 ++++++++++++++++++++++++++++++----
 migration/multifd.c           |  19 ++++-
 migration/multifd.h           |   5 ++
 3 files changed, 141 insertions(+), 16 deletions(-)

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index f1e988a959..e4bfff23a4 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -21,7 +21,9 @@
 
 static bool multifd_zero_page_enabled(void)
 {
-    return migrate_zero_page_detection() == ZERO_PAGE_DETECTION_MULTIFD;
+    ZeroPageDetection curMethod = migrate_zero_page_detection();
+    return (curMethod == ZERO_PAGE_DETECTION_MULTIFD ||
+            curMethod == ZERO_PAGE_DETECTION_DSA_ACCEL);
 }
 
 static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
@@ -37,26 +39,49 @@ static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
     pages_offset[b] = temp;
 }
 
+#ifdef CONFIG_DSA_OPT
+
+static void swap_result(bool *results, int a, int b)
+{
+    bool temp;
+
+    if (a == b) {
+        return;
+    }
+
+    temp = results[a];
+    results[a] = results[b];
+    results[b] = temp;
+}
+
 /**
- * multifd_send_zero_page_detect: Perform zero page detection on all pages.
+ * zero_page_detect_dsa: Perform zero page detection using
+ * Intel Data Streaming Accelerator (DSA).
  *
- * Sorts normal pages before zero pages in p->pages->offset and updates
- * p->pages->normal_num.
+ * Sorts normal pages before zero pages in pages->offset and updates
+ * pages->normal_num.
  *
  * @param p A pointer to the send params.
  */
-void multifd_send_zero_page_detect(MultiFDSendParams *p)
+static void zero_page_detect_dsa(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = &p->data->u.ram;
     RAMBlock *rb = pages->block;
-    int i = 0;
-    int j = pages->num - 1;
+    bool *results = p->dsa_batch_task->results;
 
-    if (!multifd_zero_page_enabled()) {
-        pages->normal_num = pages->num;
-        goto out;
+    for (int i = 0; i < pages->num; i++) {
+        p->dsa_batch_task->addr[i] =
+            (ram_addr_t)(rb->host + pages->offset[i]);
     }
 
+    buffer_is_zero_dsa_batch_sync(p->dsa_batch_task,
+                                  (const void **)p->dsa_batch_task->addr,
+                                  pages->num,
+                                  multifd_ram_page_size());
+
+    int i = 0;
+    int j = pages->num - 1;
+
     /*
      * Sort the page offset array by moving all normal pages to
      * the left and all zero pages to the right of the array.
@@ -64,23 +89,39 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
     while (i <= j) {
         uint64_t offset = pages->offset[i];
 
-        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size())) {
+        if (!results[i]) {
             i++;
             continue;
         }
 
+        swap_result(results, i, j);
         swap_page_offset(pages->offset, i, j);
         ram_release_page(rb->idstr, offset);
         j--;
     }
 
     pages->normal_num = i;
+}
 
-out:
-    stat64_add(&mig_stats.normal_pages, pages->normal_num);
-    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
+void multifd_dsa_cleanup(void)
+{
+    qemu_dsa_cleanup();
+}
+
+#else
+
+static void zero_page_detect_dsa(MultiFDSendParams *p)
+{
+    g_assert_not_reached();
+}
+
+void multifd_dsa_cleanup(void)
+{
+    g_assert_not_reached();
 }
 
+#endif
+
 void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
@@ -92,3 +133,67 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
         }
     }
 }
+
+/**
+ * zero_page_detect_cpu: Perform zero page detection using CPU.
+ *
+ * Sorts normal pages before zero pages in p->pages->offset and updates
+ * p->pages->normal_num.
+ *
+ * @param p A pointer to the send params.
+ */
+static void zero_page_detect_cpu(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = &p->data->u.ram;
+    RAMBlock *rb = pages->block;
+    int i = 0;
+    int j = pages->num - 1;
+
+    if (!multifd_zero_page_enabled()) {
+        pages->normal_num = pages->num;
+        return;
+    }
+
+    /*
+     * Sort the page offset array by moving all normal pages to
+     * the left and all zero pages to the right of the array.
+     */
+    while (i <= j) {
+        uint64_t offset = pages->offset[i];
+
+        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size())) {
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
+/**
+ * multifd_send_zero_page_detect: Perform zero page detection on all pages.
+ *
+ * @param p A pointer to the send params.
+ */
+void multifd_send_zero_page_detect(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = &p->data->u.ram;
+
+    if (!multifd_zero_page_enabled()) {
+        pages->normal_num = pages->num;
+        return;
+    }
+
+    if (qemu_dsa_is_running()) {
+        zero_page_detect_dsa(p);
+    } else {
+        zero_page_detect_cpu(p);
+    }
+
+    stat64_add(&mig_stats.normal_pages, pages->normal_num);
+    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
+}
diff --git a/migration/multifd.c b/migration/multifd.c
index 9b200f4ad9..e255ccf0c7 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/rcu.h"
+#include "qemu/dsa.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
@@ -462,6 +463,8 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     p->name = NULL;
     g_free(p->data);
     p->data = NULL;
+    buffer_zero_batch_task_destroy(p->dsa_batch_task);
+    p->dsa_batch_task = NULL;
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
@@ -493,6 +496,8 @@ void multifd_send_shutdown(void)
 
     multifd_send_terminate_threads();
 
+    multifd_dsa_cleanup();
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
@@ -814,11 +819,21 @@ bool multifd_send_setup(void)
     uint32_t page_count = multifd_ram_page_count();
     bool use_packets = multifd_use_packets();
     uint8_t i;
+    Error *local_err = NULL;
 
     if (!migrate_multifd()) {
         return true;
     }
 
+    if (s &&
+        s->parameters.zero_page_detection == ZERO_PAGE_DETECTION_DSA_ACCEL) {
+        const strList *dsa_parameter = migrate_dsa_accel_path();
+        if (qemu_dsa_init(dsa_parameter, &local_err)) {
+            return false;
+        }
+        qemu_dsa_start();
+    }
+
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
@@ -829,12 +844,12 @@ bool multifd_send_setup(void)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        Error *local_err = NULL;
 
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
         p->data = multifd_send_data_alloc();
+        p->dsa_batch_task = buffer_zero_batch_task_init(page_count);
 
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
@@ -865,7 +880,6 @@ bool multifd_send_setup(void)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        Error *local_err = NULL;
 
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
@@ -1047,6 +1061,7 @@ void multifd_recv_cleanup(void)
             qemu_thread_join(&p->thread);
         }
     }
+    multifd_dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
     }
diff --git a/migration/multifd.h b/migration/multifd.h
index 50d58c0c9c..e293ddbc1d 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -15,6 +15,7 @@
 
 #include "exec/target_page.h"
 #include "ram.h"
+#include "qemu/dsa.h"
 
 typedef struct MultiFDRecvData MultiFDRecvData;
 typedef struct MultiFDSendData MultiFDSendData;
@@ -155,6 +156,9 @@ typedef struct {
     bool pending_sync;
     MultiFDSendData *data;
 
+    /* Zero page checking batch task */
+    QemuDsaBatchTask *dsa_batch_task;
+
     /* thread local variables. No locking required */
 
     /* pointer to the packet */
@@ -313,6 +317,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p);
 bool multifd_send_prepare_common(MultiFDSendParams *p);
 void multifd_send_zero_page_detect(MultiFDSendParams *p);
 void multifd_recv_zero_page_process(MultiFDRecvParams *p);
+void multifd_dsa_cleanup(void);
 
 static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 {
-- 
Yichen Wang


