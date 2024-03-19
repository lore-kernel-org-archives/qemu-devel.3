Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DBCC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrO3-0004XN-ST; Wed, 20 Mar 2024 04:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNv-0004Wa-KR
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:20 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmrNs-0005Th-GD
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710923597; x=1742459597;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ejrg1rOtZ3/ZvVXzfZ2it1XhOgKXcEWIjQNpiJPefHc=;
 b=DQt/zLS3CIiTikCs4iy/DGRjSPKgs4NyQDux2QVBayIgmsVlsiQEeyYl
 XvElZ2j+X++i8K/eVUGq6PJO7tv+S+GR6RcoKNSzfZXrv5ZZI8LSi2sxV
 xm/1JdrOxU7k/5Go9FBFKdew/o/GZwBG+SR33wZHY1Cz6V/B03mTf4Hu3
 OYjeAEF3BtnKcOnlW/hC4Sum6Ms98bjXRl+8A9cvfjsule9ZTsNABQb7F
 nafKxN2/oWtBot4vd4Zk/u8XHRzy3O2NsaMDcuGb1cn8/CJjYLhY7ATQJ
 8rtH3NaR6ZqJ7iKxMuFd3rPm0hwzfWOCsKK+mVpfbUsskkOdmS5vUuJJX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5952946"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5952946"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 01:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="13986732"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa010.jf.intel.com with ESMTP; 20 Mar 2024 01:33:14 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v5 5/7] migration/multifd: implement initialization of qpl
 compression
Date: Wed, 20 Mar 2024 00:45:25 +0800
Message-Id: <20240319164527.1873891-6-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240319164527.1873891-1-yuan1.liu@intel.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.422, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 migration/multifd-qpl.c | 243 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 1 deletion(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 056a68a060..6de65e9da7 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -9,12 +9,253 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "multifd.h"
+#include "qpl/qpl.h"
+
+typedef struct {
+    qpl_job **job_array;
+    /* the number of allocated jobs */
+    uint32_t job_num;
+    /* the size of data processed by a qpl job */
+    uint32_t data_size;
+    /* compressed data buffer */
+    uint8_t *zbuf;
+    /* the length of compressed data */
+    uint32_t *zbuf_hdr;
+} QplData;
+
+static void free_zbuf(QplData *qpl)
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
+static int alloc_zbuf(QplData *qpl, uint8_t chan_id, Error **errp)
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
+static void free_jobs(QplData *qpl)
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
+static int alloc_jobs(QplData *qpl, uint8_t chan_id, Error **errp)
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
+static int init_qpl(QplData *qpl, uint32_t job_num, uint32_t data_size,
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
+static void deinit_qpl(QplData *qpl)
+{
+    if (qpl != NULL) {
+        free_jobs(qpl);
+        free_zbuf(qpl);
+        qpl->job_num = 0;
+        qpl->data_size = 0;
+    }
+}
+
+/**
+ * qpl_send_setup: setup send side
+ *
+ * Setup each channel with QPL compression.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    QplData *qpl;
+
+    qpl = g_new0(QplData, 1);
+    if (init_qpl(qpl, p->page_count, p->page_size, p->id, errp) != 0) {
+        g_free(qpl);
+        return -1;
+    }
+    p->compress_data = qpl;
+
+    assert(p->iov == NULL);
+    /*
+     * Each page will be compressed independently and sent using an IOV. The
+     * additional two IOVs are used to store packet header and compressed data
+     * length
+     */
+    p->iov = g_new0(struct iovec, p->page_count + 2);
+    return 0;
+}
+
+/**
+ * qpl_send_cleanup: cleanup send side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    QplData *qpl = p->compress_data;
+
+    deinit_qpl(qpl);
+    g_free(p->compress_data);
+    p->compress_data = NULL;
+}
+
+/**
+ * qpl_send_prepare: prepare data to be able to send
+ *
+ * Create a compressed buffer with all the pages that we are going to
+ * send.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    /* Implement in next patch */
+    return -1;
+}
+
+/**
+ * qpl_recv_setup: setup receive side
+ *
+ * Create the compressed channel and buffer.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    QplData *qpl;
+
+    qpl = g_new0(QplData, 1);
+    if (init_qpl(qpl, p->page_count, p->page_size, p->id, errp) != 0) {
+        g_free(qpl);
+        return -1;
+    }
+    p->compress_data = qpl;
+    return 0;
+}
+
+/**
+ * qpl_recv_cleanup: setup receive side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void qpl_recv_cleanup(MultiFDRecvParams *p)
+{
+    QplData *qpl = p->compress_data;
+
+    deinit_qpl(qpl);
+    g_free(p->compress_data);
+    p->compress_data = NULL;
+}
+
+/**
+ * qpl_recv: read the data from the channel into actual pages
+ *
+ * Read the compressed buffer, and uncompress it into the actual
+ * pages.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int qpl_recv(MultiFDRecvParams *p, Error **errp)
+{
+    /* Implement in next patch */
+    return -1;
+}
+
+static MultiFDMethods multifd_qpl_ops = {
+    .send_setup = qpl_send_setup,
+    .send_cleanup = qpl_send_cleanup,
+    .send_prepare = qpl_send_prepare,
+    .recv_setup = qpl_recv_setup,
+    .recv_cleanup = qpl_recv_cleanup,
+    .recv = qpl_recv,
+};
 
 static void multifd_qpl_register(void)
 {
-    /* noop */
+    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
 }
 
 migration_init(multifd_qpl_register);
-- 
2.39.3


