Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448ADE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 01:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQFkj-0001V5-LP; Tue, 24 Dec 2024 19:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkg-0001UM-1C
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:55 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkd-0000Q3-UZ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:53 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dd01781b56so63064196d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 16:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735088391; x=1735693191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LTNbQ+OxhgCe2YRhBnqknJo4JGQR0nnGlqcXKrdR9w=;
 b=asKX2beMNCljVP936G4P7xvKd/dkXmxUKHj3wXA9+MWHENmnnd+fUSHXJjQekHdmvu
 9DCiO22Y5w3r1vhlx3Gvz2cLTrJFfjTXDFNdhXCg1oQQ3YBD8TQVM8DwrI8imVyeHCtH
 bHkILENXQcwV0DXkw9AStBw7yZMiI6pIcIJ/oGP8Kyxfh//tYn0BPoaPSjbLmMACfOkU
 ZzQ2qM+lPIG/IXqqvLkZxlzsg1uIqi3W1xvPYJ5DWunSMC6m70nFm/lnK2SKsVIF8RGy
 7dYH28RnHTDmdr/X1MpTewwl2oU3ZN513h1Nmomurpn2hcF+fW9mNpKMUJl5f6Dh0ABP
 waRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735088391; x=1735693191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LTNbQ+OxhgCe2YRhBnqknJo4JGQR0nnGlqcXKrdR9w=;
 b=NnDTo5WIsn8nsBUwDbuadCXxNe1adoNwiWPlgizEzMdjAPtkO9fkcf/xdEs6wqyYne
 PoAQTzoK8bke0mu+nxopgZSM+NEE5111OshWJFeBsQhiVh8pUVGbt/Lspxtx480SFa0J
 3/zFGvYohwYuTaggExUO/49FR/o2yd7S8UNSA6VnxprthJJv+XegQ864+s/OW/rfd+Rv
 iHxLgv/c6kyZKTQqbxQy2Z1HQx0/N6yUqXI4i2cl8HkhtHzs8FQC9weUx5QtBxfnpXFn
 mLQ7q6tVhXtteM3y8325NgEKDQ1HaT1B7/gB0B8h6HdLNce37DBV4A/phhzinnislZlO
 z7TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA6tGKWAkG09a16BVqJwcxmQ15D458NC4/1kmxIhmFecpWQ1Nk2bnzIT4BO+51YW4o9c6MwEw7Lsdv@nongnu.org
X-Gm-Message-State: AOJu0Yx3qFO9NPURda4DVCFzJIv+xvhKuSov1AwyTr6mE+cKk1V2WHXf
 PGBkbDYP8Yji9q5XetLeySpgc0J7r9EdzQssTYWHu39g5eMxxmyXQgq9MKjomu8=
X-Gm-Gg: ASbGncteFHhv5hknU1hdgw0CyY5AS69CyWeY6kvLPbDGjKJKDD4rszknv2OGAsFi/1r
 6/dxsI+G7w/k8BDsmQaDMcYm1hGyWasc4XIj2758yg2XNqF5Kj+ns9J92YW/XFBiVVLX+bMZPik
 otkSzPM/YUtjDPibfAoDv0wuXqBRw6FEHqHmUFCUIJmyy5QczsLes63lQSE1ovgOGu4PW4BGbsN
 yfivsydv9P4nVd9/dPrz7zLkHZkXLbjve81bowpJx9gx4o+fw0nvImjpgA3ZKSNXHSjG6PvAYlJ
 pICnSrk40sMG4mDuKca1lTQncA==
X-Google-Smtp-Source: AGHT+IERS7XX5F0IyjJTpiF3uMiAs+AZS9anR8owqUcQNDug4CL3pHIiUg8AYL9IQZnq7JI30puBcw==
X-Received: by 2002:a05:6214:5189:b0:6cb:e4d3:10a0 with SMTP id
 6a1803df08f44-6dd233ab438mr258281686d6.48.1735088390773; 
 Tue, 24 Dec 2024 16:59:50 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:1799:4ca4:2dd7:ba38:ecbd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d244fsm57318206d6.98.2024.12.24.16.59.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Dec 2024 16:59:50 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v9 09/12] migration/multifd: Enable DSA offloading in multifd
 sender path.
Date: Tue, 24 Dec 2024 16:59:16 -0800
Message-Id: <20241225005919.26853-10-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241225005919.26853-1-yichen.wang@bytedance.com>
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2d.google.com
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
 migration/multifd-zero-page.c | 149 ++++++++++++++++++++++++++++++----
 migration/multifd.c           |  23 +++++-
 migration/multifd.h           |   6 ++
 migration/options.c           |  13 +++
 migration/options.h           |   1 +
 5 files changed, 176 insertions(+), 16 deletions(-)

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index f1e988a959..0a4e3fb9bd 100644
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
@@ -64,23 +89,59 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
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
+int multifd_dsa_setup(MigrationState *s, Error *local_err)
+{
+    g_autofree strList *dsa_parameter = g_malloc0(sizeof(strList));
+    migrate_dsa_accel_path(&dsa_parameter);
+    if (qemu_dsa_init(dsa_parameter, &local_err)) {
+        migrate_set_error(s, local_err);
+        return -1;
+    } else {
+        qemu_dsa_start();
+    }
+
+    return 0;
+}
+
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
 }
 
+int multifd_dsa_setup(MigrationState *s, Error *local_err)
+{
+    g_assert_not_reached();
+    return -1;
+}
+
+void multifd_dsa_cleanup(void)
+{
+    return ;
+}
+
+#endif
+
 void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
@@ -92,3 +153,63 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
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
+        goto out;
+    }
+
+    if (qemu_dsa_is_running()) {
+        zero_page_detect_dsa(p);
+    } else {
+        zero_page_detect_cpu(p);
+    }
+
+out:
+    stat64_add(&mig_stats.normal_pages, pages->normal_num);
+    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
+}
diff --git a/migration/multifd.c b/migration/multifd.c
index 4f973d70e0..50cdbd21d0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/rcu.h"
+#include "qemu/dsa.h"
 #include "exec/target_page.h"
 #include "system/system.h"
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
@@ -814,6 +819,7 @@ bool multifd_send_setup(void)
     uint32_t page_count = multifd_ram_page_count();
     bool use_packets = multifd_use_packets();
     uint8_t i;
+    Error *local_err = NULL;
 
     if (!migrate_multifd()) {
         return true;
@@ -827,9 +833,12 @@ bool multifd_send_setup(void)
     qatomic_set(&multifd_send_state->exiting, 0);
     multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
 
+    if (ret) {
+        goto err;
+    }
+
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        Error *local_err = NULL;
 
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
@@ -863,10 +872,19 @@ bool multifd_send_setup(void)
         goto err;
     }
 
+    if (s && ret == 0 &&
+        s->parameters.zero_page_detection == ZERO_PAGE_DETECTION_DSA_ACCEL) {
+        ret = multifd_dsa_setup(s, local_err);
+    }
+
+    if (ret) {
+        goto err;
+    }
+
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        Error *local_err = NULL;
 
+        p->dsa_batch_task = buffer_zero_batch_task_init(page_count);
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
             migrate_set_error(s, local_err);
@@ -1047,6 +1065,7 @@ void multifd_recv_cleanup(void)
             qemu_thread_join(&p->thread);
         }
     }
+    multifd_dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
     }
diff --git a/migration/multifd.h b/migration/multifd.h
index 50d58c0c9c..da53b0bdfd 100644
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
@@ -313,6 +317,8 @@ void multifd_send_fill_packet(MultiFDSendParams *p);
 bool multifd_send_prepare_common(MultiFDSendParams *p);
 void multifd_send_zero_page_detect(MultiFDSendParams *p);
 void multifd_recv_zero_page_process(MultiFDRecvParams *p);
+int multifd_dsa_setup(MigrationState *s, Error *local_err);
+void multifd_dsa_cleanup(void);
 
 static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 {
diff --git a/migration/options.c b/migration/options.c
index 68547b358b..9011e7f6c3 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -817,6 +817,19 @@ const strList *migrate_accel_path(void)
     return s->parameters.accel_path;
 }
 
+void migrate_dsa_accel_path(strList **dsa_accel_path)
+{
+    MigrationState *s = migrate_get_current();
+    strList *accel_path = s->parameters.accel_path;
+    strList **tail = dsa_accel_path;
+    while (accel_path) {
+        if (strncmp(accel_path->value, "dsa:", 4) == 0) {
+            QAPI_LIST_APPEND(tail, &accel_path->value[4]);
+        }
+        accel_path = accel_path->next;
+    }
+}
+
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index c994b04cb6..586d091733 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -86,6 +86,7 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 const strList *migrate_accel_path(void);
+void migrate_dsa_accel_path(strList **dsa_accel_path);
 
 /* parameters helpers */
 
-- 
Yichen Wang


