Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEF1C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwR7-0008Gv-42; Tue, 11 Jun 2024 04:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwR5-0008GL-0P
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:55 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwR2-0006mp-Pj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718092852; x=1749628852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h/+xzRnNIaIK2kagnHhmAQbOZqHqMq07lzV1hIPaZdI=;
 b=fPOJTk3XPns4/LPU8iRe/q6/RBuoM7zKP12B2DK4cSZP3fUUq9xLo7ij
 9kvI2aC2hF7sy7KXzLfX4BYs67qMGDw/NJ2X9hekpm9xP+4eODJK8gaR7
 18rEeHFCGVKcZPrrx9ss9l+7oopyOLVU2ZrpIIQ3a8QfnyQOvPb+71swN
 Or5vi2ip1W4aE3vZssubVF0R00wXaiOCIVTm8hMjpVKUzXrhPVV6je4gp
 1mkTrSBOaisjBaRdH2aPCfFsnD2CzmKvTlBTDUoCAzL8nIrOph6Nwx3ZH
 1vk0sITRS1UXxIVbkKR0nnr0VJ73gwKMY4U7SLeyH6wD6W7Bu8H+4eFEK A==;
X-CSE-ConnectionGUID: v6nOUNvZQd2j0jUOySEp+w==
X-CSE-MsgGUID: iHZd2CJeTY2FaAq5TG7qbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="15013827"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="15013827"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 01:00:51 -0700
X-CSE-ConnectionGUID: +UMOR6IUR2qTe77u36fVLw==
X-CSE-MsgGUID: CKu+Pw1ER/SPjPJG4p0L/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="39415830"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2024 01:00:48 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v8 5/7] migration/multifd: implement initialization of qpl
 compression
Date: Mon, 10 Jun 2024 18:21:08 +0800
Message-ID: <20240610102110.900410-6-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610102110.900410-1-yuan1.liu@intel.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.143, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

during initialization, a software job is allocated to each channel
for software path fallabck when the IAA hardware is unavailable or
the hardware job submission fails. If the IAA hardware is available,
multiple hardware jobs are allocated for batch processing.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-qpl.c | 328 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 327 insertions(+), 1 deletion(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 056a68a060..6791a204d5 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -9,12 +9,338 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
+#include "multifd.h"
+#include "qpl/qpl.h"
+
+typedef struct {
+    /* the QPL hardware path job */
+    qpl_job *job;
+    /* indicates if fallback to software path is required */
+    bool fallback_sw_path;
+    /* output data from the software path */
+    uint8_t *sw_output;
+    /* output data length from the software path */
+    uint32_t sw_output_len;
+} QplHwJob;
+
+typedef struct {
+    /* array of hardware jobs, the number of jobs equals the number pages */
+    QplHwJob *hw_jobs;
+    /* the QPL software job for the slow path and software fallback */
+    qpl_job *sw_job;
+    /* the number of pages that the QPL needs to process at one time */
+    uint32_t page_num;
+    /* array of compressed page buffers */
+    uint8_t *zbuf;
+    /* array of compressed page lengths */
+    uint32_t *zlen;
+    /* the status of the hardware device */
+    bool hw_avail;
+} QplData;
+
+/**
+ * check_hw_avail: check if IAA hardware is available
+ *
+ * If the IAA hardware does not exist or is unavailable,
+ * the QPL hardware job initialization will fail.
+ *
+ * Returns true if IAA hardware is available, otherwise false.
+ *
+ * @job_size: indicates the hardware job size if hardware is available
+ */
+static bool check_hw_avail(uint32_t *job_size)
+{
+    qpl_path_t path = qpl_path_hardware;
+    uint32_t size = 0;
+    qpl_job *job;
+
+    if (qpl_get_job_size(path, &size) != QPL_STS_OK) {
+        return false;
+    }
+    assert(size > 0);
+    job = g_malloc0(size);
+    if (qpl_init_job(path, job) != QPL_STS_OK) {
+        g_free(job);
+        return false;
+    }
+    g_free(job);
+    *job_size = size;
+    return true;
+}
+
+/**
+ * multifd_qpl_free_sw_job: clean up software job
+ *
+ * Free the software job resources.
+ *
+ * @qpl: pointer to the QplData structure
+ */
+static void multifd_qpl_free_sw_job(QplData *qpl)
+{
+    assert(qpl);
+    if (qpl->sw_job) {
+        qpl_fini_job(qpl->sw_job);
+        g_free(qpl->sw_job);
+        qpl->sw_job = NULL;
+    }
+}
+
+/**
+ * multifd_qpl_free_jobs: clean up hardware jobs
+ *
+ * Free all hardware job resources.
+ *
+ * @qpl: pointer to the QplData structure
+ */
+static void multifd_qpl_free_hw_job(QplData *qpl)
+{
+    assert(qpl);
+    if (qpl->hw_jobs) {
+        for (int i = 0; i < qpl->page_num; i++) {
+            qpl_fini_job(qpl->hw_jobs[i].job);
+            g_free(qpl->hw_jobs[i].job);
+            qpl->hw_jobs[i].job = NULL;
+        }
+        g_free(qpl->hw_jobs);
+        qpl->hw_jobs = NULL;
+    }
+}
+
+/**
+ * multifd_qpl_init_sw_job: initialize a software job
+ *
+ * Use the QPL software path to initialize a job
+ *
+ * @qpl: pointer to the QplData structure
+ * @errp: pointer to an error
+ */
+static int multifd_qpl_init_sw_job(QplData *qpl, Error **errp)
+{
+    qpl_path_t path = qpl_path_software;
+    uint32_t size = 0;
+    qpl_job *job = NULL;
+    qpl_status status;
+
+    status = qpl_get_job_size(path, &size);
+    if (status != QPL_STS_OK) {
+        error_setg(errp, "qpl_get_job_size failed with error %d", status);
+        return -1;
+    }
+    job = g_malloc0(size);
+    status = qpl_init_job(path, job);
+    if (status != QPL_STS_OK) {
+        error_setg(errp, "qpl_init_job failed with error %d", status);
+        g_free(job);
+        return -1;
+    }
+    qpl->sw_job = job;
+    return 0;
+}
+
+/**
+ * multifd_qpl_init_jobs: initialize hardware jobs
+ *
+ * Use the QPL hardware path to initialize jobs
+ *
+ * @qpl: pointer to the QplData structure
+ * @size: the size of QPL hardware path job
+ * @errp: pointer to an error
+ */
+static void multifd_qpl_init_hw_job(QplData *qpl, uint32_t size, Error **errp)
+{
+    qpl_path_t path = qpl_path_hardware;
+    qpl_job *job = NULL;
+    qpl_status status;
+
+    qpl->hw_jobs = g_new0(QplHwJob, qpl->page_num);
+    for (int i = 0; i < qpl->page_num; i++) {
+        job = g_malloc0(size);
+        status = qpl_init_job(path, job);
+        /* the job initialization should succeed after check_hw_avail */
+        assert(status == QPL_STS_OK);
+        qpl->hw_jobs[i].job = job;
+    }
+}
+
+/**
+ * multifd_qpl_init: initialize QplData structure
+ *
+ * Allocate and initialize a QplData structure
+ *
+ * Returns a QplData pointer on success or NULL on error
+ *
+ * @num: the number of pages
+ * @size: the page size
+ * @errp: pointer to an error
+ */
+static QplData *multifd_qpl_init(uint32_t num, uint32_t size, Error **errp)
+{
+    uint32_t job_size = 0;
+    QplData *qpl;
+
+    qpl = g_new0(QplData, 1);
+    qpl->page_num = num;
+    if (multifd_qpl_init_sw_job(qpl, errp) != 0) {
+        g_free(qpl);
+        return NULL;
+    }
+    qpl->hw_avail = check_hw_avail(&job_size);
+    if (qpl->hw_avail) {
+        multifd_qpl_init_hw_job(qpl, job_size, errp);
+    }
+    qpl->zbuf = g_malloc0(size * num);
+    qpl->zlen = g_new0(uint32_t, num);
+    return qpl;
+}
+
+/**
+ * multifd_qpl_deinit: clean up QplData structure
+ *
+ * Free jobs, buffers and the QplData structure
+ *
+ * @qpl: pointer to the QplData structure
+ */
+static void multifd_qpl_deinit(QplData *qpl)
+{
+    if (qpl) {
+        multifd_qpl_free_sw_job(qpl);
+        multifd_qpl_free_hw_job(qpl);
+        g_free(qpl->zbuf);
+        g_free(qpl->zlen);
+        g_free(qpl);
+    }
+}
+
+/**
+ * multifd_qpl_send_setup: set up send side
+ *
+ * Set up the channel with QPL compression.
+ *
+ * Returns 0 on success or -1 on error
+ *
+ * @p: Params for the channel being used
+ * @errp: pointer to an error
+ */
+static int multifd_qpl_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    QplData *qpl;
+
+    qpl = multifd_qpl_init(p->page_count, p->page_size, errp);
+    if (!qpl) {
+        return -1;
+    }
+    p->compress_data = qpl;
+
+    /*
+     * the page will be compressed independently and sent using an IOV. The
+     * additional two IOVs are used to store packet header and compressed data
+     * length
+     */
+    p->iov = g_new0(struct iovec, p->page_count + 2);
+    return 0;
+}
+
+/**
+ * multifd_qpl_send_cleanup: clean up send side
+ *
+ * Close the channel and free memory.
+ *
+ * @p: Params for the channel being used
+ * @errp: pointer to an error
+ */
+static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    multifd_qpl_deinit(p->compress_data);
+    p->compress_data = NULL;
+    g_free(p->iov);
+    p->iov = NULL;
+}
+
+/**
+ * multifd_qpl_send_prepare: prepare data to be able to send
+ *
+ * Create a compressed buffer with all the pages that we are going to
+ * send.
+ *
+ * Returns 0 on success or -1 on error
+ *
+ * @p: Params for the channel being used
+ * @errp: pointer to an error
+ */
+static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    /* Implement in next patch */
+    return -1;
+}
+
+/**
+ * multifd_qpl_recv_setup: set up receive side
+ *
+ * Create the compressed channel and buffer.
+ *
+ * Returns 0 on success or -1 on error
+ *
+ * @p: Params for the channel being used
+ * @errp: pointer to an error
+ */
+static int multifd_qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    QplData *qpl;
+
+    qpl = multifd_qpl_init(p->page_count, p->page_size, errp);
+    if (!qpl) {
+        return -1;
+    }
+    p->compress_data = qpl;
+    return 0;
+}
+
+/**
+ * multifd_qpl_recv_cleanup: set up receive side
+ *
+ * Close the channel and free memory.
+ *
+ * @p: Params for the channel being used
+ */
+static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
+{
+    multifd_qpl_deinit(p->compress_data);
+    p->compress_data = NULL;
+}
+
+/**
+ * multifd_qpl_recv: read the data from the channel into actual pages
+ *
+ * Read the compressed buffer, and uncompress it into the actual
+ * pages.
+ *
+ * Returns 0 on success or -1 on error
+ *
+ * @p: Params for the channel being used
+ * @errp: pointer to an error
+ */
+static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
+{
+    /* Implement in next patch */
+    return -1;
+}
+
+static MultiFDMethods multifd_qpl_ops = {
+    .send_setup = multifd_qpl_send_setup,
+    .send_cleanup = multifd_qpl_send_cleanup,
+    .send_prepare = multifd_qpl_send_prepare,
+    .recv_setup = multifd_qpl_recv_setup,
+    .recv_cleanup = multifd_qpl_recv_cleanup,
+    .recv = multifd_qpl_recv,
+};
 
 static void multifd_qpl_register(void)
 {
-    /* noop */
+    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
 }
 
 migration_init(multifd_qpl_register);
-- 
2.43.0


