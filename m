Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0CAC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1uQ-0001wO-EU; Thu, 11 Jul 2024 18:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1uO-0001v4-Hj
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:05:00 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1uM-0000Jq-CY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:05:00 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d932f991f6so796585b6e.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720735496; x=1721340296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y30kNx6mYhPmtns0WOVLEJLF7Vyb+wOWww6unPsKfy8=;
 b=HpIpebykxijvR/OOJx7rYwH1IUHxXjbWwJ23OC1GDbOaE+APDQ+sQojGJ0JDBgl0Ry
 tPeCP72W0QQPPbfG/zVeBEVKtRprgqM3Q0pjTCJIu7Cz3s4FfmMIYD+QCjhrtMtYxM+f
 gGcUTRNalsLKyylUnHlRoQla7X5JVGC6HTCMgpHfHQn0jNMLRqQCtknXb3fSiBZXpWGR
 32Bvy/BK4hwB0GDSHcwVGgjMKSIJUQ3x9jAUa8EuuRonrZhR6811lV1t1M6NeXMI2QDw
 fbBa4lisNIx5M5ToW+Zp5NDAC9y4SCV0dqs+fDhvb24S8Mo+L3goMsBGcjEAW76TB9Qe
 4Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720735496; x=1721340296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y30kNx6mYhPmtns0WOVLEJLF7Vyb+wOWww6unPsKfy8=;
 b=MKc4WyFV3oVHQcY+/xDWQU5mVF9RnMjBSy0X1VngjccDwxDe7x27k9ll1eTFMjQOS6
 UPmsxseqkZ066YtfmWNNM+9wetbqADOMtLQ2FwKFGTyyrW+Bkvp/14sfXaDPcK932P4O
 cOfmhlLJTe3lhT+SiVNvbapFv0XRK59TcpcNJWiSFN5QjRTHgmtFLJx6vKhiYb/SuGfZ
 599mzuKofJvOsaTE9BOdmaCNN8V3DE0SbNNPzZ2C0G+LdeVe5hyu6a5cBqFZPAxhlwQz
 lYI06z6VFsgSCNlZ4ebU67B+vffcEJ6mXbuUIJeavfZirYJE3POI0zla2f5WSD45cjxO
 AQvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzfnf/Yy3b5ATV9Ls/zZGylxAK+2KZYPBrmeQ2yH1IxiX51xWiSPhZQNXqofBGYGaAFzXUKgzbwUnHv+TkrI5aKcCPWO8=
X-Gm-Message-State: AOJu0YwjKJKy79wKhqunYWT8Yk16tkSdW1WX9CyhG/AwgXjyH+lMqaRR
 Ej6Ra4X3JiH9RgFsix2nRzHgQxWG/N6fp1TbMvuWSKCHOBBu7CdYA4zhhZz6cso=
X-Google-Smtp-Source: AGHT+IFl3wbDhp8TTN7KnWx2tA+l/HRGxAYk4XoZo5eMyQfIk6S8pcZN54krFIY3nWQhgmUCYioJyg==
X-Received: by 2002:a05:6808:198a:b0:3d9:2c5a:c81a with SMTP id
 5614622812f47-3d93c0a76e5mr11086807b6e.50.1720735496369; 
 Thu, 11 Jul 2024 15:04:56 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d93acff4d9sm1218578b6e.5.2024.07.11.15.04.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 15:04:56 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v5 10/13] migration/multifd: Enable DSA offloading in multifd
 sender path.
Date: Thu, 11 Jul 2024 15:04:48 -0700
Message-Id: <20240711220451.19780-1-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x235.google.com
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
 include/qemu/dsa.h            |   4 +-
 migration/migration.c         |   2 +-
 migration/multifd-zero-page.c | 100 ++++++++++++++++++++++++++++++++--
 migration/multifd.c           |  43 ++++++++++++++-
 migration/multifd.h           |   2 +-
 util/dsa.c                    |  23 ++++----
 6 files changed, 150 insertions(+), 24 deletions(-)

diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
index fd0305a7c7..a3b502ee41 100644
--- a/include/qemu/dsa.h
+++ b/include/qemu/dsa.h
@@ -83,7 +83,7 @@ typedef struct QemuDsaBatchTask {
  *
  * @return int Zero if successful, otherwise non zero.
  */
-int qemu_dsa_init(const char *dsa_parameter, Error **errp);
+int qemu_dsa_init(const strList *dsa_parameter, Error **errp);
 
 /**
  * @brief Start logic to enable using DSA.
@@ -146,7 +146,7 @@ static inline bool qemu_dsa_is_running(void)
     return false;
 }
 
-static inline int qemu_dsa_init(const char *dsa_parameter, Error **errp)
+static inline int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
 {
     error_setg(errp, "DSA accelerator is not enabled.");
     return -1;
diff --git a/migration/migration.c b/migration/migration.c
index 3dea06d577..085395b900 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3469,7 +3469,7 @@ static void *migration_thread(void *opaque)
     object_ref(OBJECT(s));
     update_iteration_initial_status(s);
 
-    if (!multifd_send_setup()) {
+    if (!multifd_send_setup(&local_err)) {
         goto out;
     }
 
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index e1b8370f88..ffb5611d44 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -37,25 +37,84 @@ static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
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
+    bool *results = p->dsa_batch_task->results;
+
+    for (int i = 0; i < p->pages->num; i++) {
+        p->dsa_batch_task->addr[i] =
+            (ram_addr_t)(rb->host + p->pages->offset[i]);
+    }
+
+    buffer_is_zero_dsa_batch_sync(p->dsa_batch_task,
+                                  (const void **)p->dsa_batch_task->addr,
+                                  p->pages->num,
+                                  p->page_size);
+
+    int i = 0;
+    int j = pages->num - 1;
+
     /*
      * Sort the page offset array by moving all normal pages to
      * the left and all zero pages to the right of the array.
@@ -63,11 +122,12 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
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
@@ -76,6 +136,15 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
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
@@ -87,3 +156,24 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
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
+    if (qemu_dsa_is_running()) {
+        zero_page_detect_dsa(p);
+    } else {
+        zero_page_detect_cpu(p);
+    }
+}
diff --git a/migration/multifd.c b/migration/multifd.c
index 6f8edd4b6a..014fee757a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -817,6 +817,32 @@ static void multifd_send_cleanup_state(void)
     multifd_send_state = NULL;
 }
 
+static bool multifd_dsa_setup(MigrationState *s, const char *role, Error **errp)
+{
+    /*
+     * Only setup DSA when needed. Currently, DSA is only used for zero page
+     * detection, which is only needed on sender side.
+     */
+    if (!s ||
+        s->parameters.zero_page_detection != ZERO_PAGE_DETECTION_DSA_ACCEL) {
+        return true;
+    }
+
+    const strList *dsa_parameter = migrate_dsa_accel_path();
+    if (qemu_dsa_init(dsa_parameter, errp)) {
+        error_setg(errp, "multifd: %s failed to initialize DSA.", role);
+        return false;
+    }
+    qemu_dsa_start();
+
+    return true;
+}
+
+static void multifd_dsa_cleanup(void)
+{
+    qemu_dsa_cleanup();
+}
+
 void multifd_send_shutdown(void)
 {
     int i;
@@ -827,6 +853,8 @@ void multifd_send_shutdown(void)
 
     multifd_send_terminate_threads();
 
+    multifd_dsa_cleanup();
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
@@ -1156,7 +1184,7 @@ static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
     return true;
 }
 
-bool multifd_send_setup(void)
+bool multifd_send_setup(Error **errp)
 {
     MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
@@ -1169,6 +1197,10 @@ bool multifd_send_setup(void)
         return true;
     }
 
+    if (!multifd_dsa_setup(s, "Sender", errp)) {
+        return false;
+    }
+
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
@@ -1395,6 +1427,7 @@ void multifd_recv_cleanup(void)
             qemu_thread_join(&p->thread);
         }
     }
+    multifd_dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
     }
@@ -1570,6 +1603,7 @@ int multifd_recv_setup(Error **errp)
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
     uint8_t i;
+    int ret;
 
     /*
      * Return successfully if multiFD recv state is already initialised
@@ -1579,6 +1613,10 @@ int multifd_recv_setup(Error **errp)
         return 0;
     }
 
+    if (!multifd_dsa_setup(NULL, "Receiver", errp)) {
+        return -1;
+    }
+
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
@@ -1617,13 +1655,12 @@ int multifd_recv_setup(Error **errp)
 
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
index 027f57bf4e..871e3aa063 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -18,7 +18,7 @@
 
 typedef struct MultiFDRecvData MultiFDRecvData;
 
-bool multifd_send_setup(void);
+bool multifd_send_setup(Error **errp);
 void multifd_send_shutdown(void);
 void multifd_send_channel_created(void);
 int multifd_recv_setup(Error **errp);
diff --git a/util/dsa.c b/util/dsa.c
index 5aba1ae23a..44b1130a51 100644
--- a/util/dsa.c
+++ b/util/dsa.c
@@ -116,27 +116,27 @@ dsa_device_cleanup(QemuDsaDevice *instance)
  */
 static int
 dsa_device_group_init(QemuDsaDeviceGroup *group,
-                      const char *dsa_parameter,
+                      const strList *dsa_parameter,
                       Error **errp)
 {
-    if (dsa_parameter == NULL || strlen(dsa_parameter) == 0) {
-        return 0;
+    if (dsa_parameter == NULL) {
+        /* HACKING ALERT. */
+        /* return 0; */
+        dsa_parameter = &(strList) {
+            .value = (char *)"/dev/dsa/wq0.0", .next = NULL
+        };
     }
 
     int ret = 0;
-    char *local_dsa_parameter = g_strdup(dsa_parameter);
     const char *dsa_path[MAX_DSA_DEVICES];
     int num_dsa_devices = 0;
-    char delim[2] = " ";
 
-    char *current_dsa_path = strtok(local_dsa_parameter, delim);
-
-    while (current_dsa_path != NULL) {
-        dsa_path[num_dsa_devices++] = current_dsa_path;
+    while (dsa_parameter) {
+        dsa_path[num_dsa_devices++] = dsa_parameter->value;
         if (num_dsa_devices == MAX_DSA_DEVICES) {
             break;
         }
-        current_dsa_path = strtok(NULL, delim);
+        dsa_parameter = dsa_parameter->next;
     }
 
     group->dsa_devices =
@@ -161,7 +161,6 @@ dsa_device_group_init(QemuDsaDeviceGroup *group,
     }
 
 exit:
-    g_free(local_dsa_parameter);
     return ret;
 }
 
@@ -718,7 +717,7 @@ dsa_globals_init(void)
  *
  * @return int Zero if successful, otherwise non zero.
  */
-int qemu_dsa_init(const char *dsa_parameter, Error **errp)
+int qemu_dsa_init(const strList *dsa_parameter, Error **errp)
 {
     dsa_globals_init();
 
-- 
Yichen Wang


