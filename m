Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9DAC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNf7-0004UN-LV; Tue, 05 Mar 2024 00:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNf5-0004Tl-2M
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:23 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNf3-0003ev-85
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709617701; x=1741153701;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2iEuTnLvQ/OH0PNo/1fvbYIPLyWaF7RSSa/asMCWoTc=;
 b=VJph5R3tywJxeyzUpVK1b8rHX7/yPABNhv6JMNhnsspibn6morwArBP8
 mqAUIo6+h0n1rfF5NfxY0LEcS7Co5WItXuxuUQcfqHAx/aLHmUvPvJ1pE
 tk29GOx31GgomU8+jdRsXvHa384I1xVkOB67vzaBuWIlscqNeIpwFkwDT
 s35eoAcF/pDbrci3QmHckAWV1QbGX0USd2BJk9rR4ViW6WNT4l9tFiK4N
 veDkQvKFsExIruwNwMB6kZpF1blW+KhNoZOfvtttjlDz5gU73i7WBQG0j
 Ggh9JgSxfibXjk27IYKziAjyvROnjSJ601rH7yTQVVZsf7V/G7zjwVKxX A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4006288"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4006288"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 21:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="40135985"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa002.jf.intel.com with ESMTP; 04 Mar 2024 21:48:17 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v4 5/8] migration/multifd: implement initialization of qpl
 compression
Date: Mon,  4 Mar 2024 22:00:25 +0800
Message-Id: <20240304140028.1590649-6-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240304140028.1590649-1-yuan1.liu@intel.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.571, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

the qpl initialization includes memory allocation for compressed
data and the qpl job initialization.

the qpl initialization will check whether the In-Memory Analytics
Accelerator(IAA) hardware is available, if the platform does not
have IAA hardware or the IAA hardware is not available, the QPL
compression initialization will fail.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/multifd-qpl.c | 128 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 6 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 6b94e732ac..f4db97ca01 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -33,6 +33,100 @@ struct qpl_data {
     uint32_t *zbuf_hdr;
 };
 
+static void free_zbuf(struct qpl_data *qpl)
+{
+    if (qpl->zbuf != NULL) {
+        munmap(qpl->zbuf, qpl->job_num * qpl->data_size);
+        qpl->zbuf = NULL;
+    }
+    if (qpl->zbuf_hdr != NULL) {
+        g_free(qpl->zbuf_hdr);
+        qpl->zbuf_hdr = NULL;
+    }
+}
+
+static int alloc_zbuf(struct qpl_data *qpl, uint8_t chan_id, Error **errp)
+{
+    int flags = MAP_PRIVATE | MAP_POPULATE | MAP_ANONYMOUS;
+    uint32_t size = qpl->job_num * qpl->data_size;
+    uint8_t *buf;
+
+    buf = (uint8_t *) mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
+    if (buf == MAP_FAILED) {
+        error_setg(errp, "multifd: %u: alloc_zbuf failed, job num %u, size %u",
+                   chan_id, qpl->job_num, qpl->data_size);
+        return -1;
+    }
+    qpl->zbuf = buf;
+    qpl->zbuf_hdr = g_new0(uint32_t, qpl->job_num);
+    return 0;
+}
+
+static void free_jobs(struct qpl_data *qpl)
+{
+    for (int i = 0; i < qpl->job_num; i++) {
+        qpl_fini_job(qpl->job_array[i]);
+        g_free(qpl->job_array[i]);
+        qpl->job_array[i] = NULL;
+    }
+    g_free(qpl->job_array);
+    qpl->job_array = NULL;
+}
+
+static int alloc_jobs(struct qpl_data *qpl, uint8_t chan_id, Error **errp)
+{
+    qpl_status status;
+    uint32_t job_size = 0;
+    qpl_job *job = NULL;
+    /* always use IAA hardware accelerator */
+    qpl_path_t path = qpl_path_hardware;
+
+    status = qpl_get_job_size(path, &job_size);
+    if (status != QPL_STS_OK) {
+        error_setg(errp, "multifd: %u: qpl_get_job_size failed with error %d",
+                   chan_id, status);
+        return -1;
+    }
+    qpl->job_array = g_new0(qpl_job *, qpl->job_num);
+    for (int i = 0; i < qpl->job_num; i++) {
+        job = g_malloc0(job_size);
+        status = qpl_init_job(path, job);
+        if (status != QPL_STS_OK) {
+            error_setg(errp, "multifd: %u: qpl_init_job failed with error %d",
+                       chan_id, status);
+            free_jobs(qpl);
+            return -1;
+        }
+        qpl->job_array[i] = job;
+    }
+    return 0;
+}
+
+static int init_qpl(struct qpl_data *qpl, uint32_t job_num, uint32_t data_size,
+                    uint8_t chan_id, Error **errp)
+{
+    qpl->job_num = job_num;
+    qpl->data_size = data_size;
+    if (alloc_zbuf(qpl, chan_id, errp) != 0) {
+        return -1;
+    }
+    if (alloc_jobs(qpl, chan_id, errp) != 0) {
+        free_zbuf(qpl);
+        return -1;
+    }
+    return 0;
+}
+
+static void deinit_qpl(struct qpl_data *qpl)
+{
+    if (qpl != NULL) {
+        free_jobs(qpl);
+        free_zbuf(qpl);
+        qpl->job_num = 0;
+        qpl->data_size = 0;
+    }
+}
+
 /**
  * qpl_send_setup: setup send side
  *
@@ -45,8 +139,15 @@ struct qpl_data {
  */
 static int qpl_send_setup(MultiFDSendParams *p, Error **errp)
 {
-    /* Implement in next patch */
-    return -1;
+    struct qpl_data *qpl;
+
+    qpl = g_new0(struct qpl_data, 1);
+    if (init_qpl(qpl, p->page_count, p->page_size, p->id, errp) != 0) {
+        g_free(qpl);
+        return -1;
+    }
+    p->data = qpl;
+    return 0;
 }
 
 /**
@@ -59,7 +160,11 @@ static int qpl_send_setup(MultiFDSendParams *p, Error **errp)
  */
 static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
-    /* Implement in next patch */
+    struct qpl_data *qpl = p->data;
+
+    deinit_qpl(qpl);
+    g_free(p->data);
+    p->data = NULL;
 }
 
 /**
@@ -91,8 +196,15 @@ static int qpl_send_prepare(MultiFDSendParams *p, Error **errp)
  */
 static int qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
-    /* Implement in next patch */
-    return -1;
+    struct qpl_data *qpl;
+
+    qpl = g_new0(struct qpl_data, 1);
+    if (init_qpl(qpl, p->page_count, p->page_size, p->id, errp) != 0) {
+        g_free(qpl);
+        return -1;
+    }
+    p->data = qpl;
+    return 0;
 }
 
 /**
@@ -104,7 +216,11 @@ static int qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
  */
 static void qpl_recv_cleanup(MultiFDRecvParams *p)
 {
-    /* Implement in next patch */
+    struct qpl_data *qpl = p->data;
+
+    deinit_qpl(qpl);
+    g_free(p->data);
+    p->data = NULL;
 }
 
 /**
-- 
2.39.3


