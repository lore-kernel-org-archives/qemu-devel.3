Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30273C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwR9-0008IC-RZ; Tue, 11 Jun 2024 04:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwR8-0008Hf-CZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:58 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sGwR5-0006mH-OL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718092856; x=1749628856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pOnRmrOdUfWnIsRVF+pTfoAOftL+4zH+nY0GNUlN+ls=;
 b=bhMjTc7GENYUSBUn68v0+hXxIOUy8BbTSUbAx3RAkzsHljmE70D8et3h
 Qc/yKicJTg2zuH8nKUNxX2gZ96HNCwtehuVULskghOmjc6+kddRx3lMe2
 dgnPgZV70rmMd/r/Xbr1YeTZ//WofxWVdkJWjpEG/dzpBsZ1F4P2o7UnE
 eSV2So1UJPmyVR4kY2iOUglywebgAcrHPoLuLEBsxpybG5qpXheEg4x+8
 ec/BuV7bHJSCIsjxgr+6Whc0g+pf5A1vMbCLoGuouVqqLj9P+D2sCGXf1
 rLRGJAt0uzofqu7/WJTD5SG+OXG8oyOyK8gshZPCoUXBwnDetpPTdxkFU A==;
X-CSE-ConnectionGUID: TEb/M32iR4iv5nDd5SUz5g==
X-CSE-MsgGUID: MKquDT/3T3Sl0PyFFw3rVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32271357"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="32271357"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 01:00:55 -0700
X-CSE-ConnectionGUID: fpMTLqlXSPunbqlMJhwbOg==
X-CSE-MsgGUID: y1nf+aQZQBOnUJaI7h8FTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="70140918"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa002.jf.intel.com with ESMTP; 11 Jun 2024 01:00:52 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: qemu-devel@nongnu.org, yuan1.liu@intel.com, nanhai.zou@intel.com,
 shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v8 6/7] migration/multifd: implement qpl compression and
 decompression
Date: Mon, 10 Jun 2024 18:21:09 +0800
Message-ID: <20240610102110.900410-7-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610102110.900410-1-yuan1.liu@intel.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yuan1.liu@intel.com;
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

QPL compression and decompression will use IAA hardware path if the IAA
hardware is available. Otherwise the QPL library software path is used.

The hardware path will automatically fall back to QPL software path if
the IAA queues are busy. In some scenarios, this may happen frequently,
such as configuring 4 channels but only one IAA device is available. In
the case of insufficient IAA hardware resources, retry and fallback can
help optimize performance:

 1. Retry + SW fallback:
    total time: 14649 ms
    downtime: 25 ms
    throughput: 17666.57 mbps
    pages-per-second: 1509647

 2. No fallback, always wait for work queues to become available
    total time: 18381 ms
    downtime: 25 ms
    throughput: 13698.65 mbps
    pages-per-second: 859607

If both the hardware and software paths fail, the uncompressed page is
sent directly.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/multifd-qpl.c | 424 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 420 insertions(+), 4 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 6791a204d5..9265098ee7 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -13,9 +13,14 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-migration.h"
+#include "exec/ramblock.h"
 #include "multifd.h"
 #include "qpl/qpl.h"
 
+/* Maximum number of retries to resubmit a job if IAA work queues are full */
+#define MAX_SUBMIT_RETRY_NUM (3)
+
 typedef struct {
     /* the QPL hardware path job */
     qpl_job *job;
@@ -260,6 +265,225 @@ static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
     p->iov = NULL;
 }
 
+/**
+ * multifd_qpl_prepare_job: prepare the job
+ *
+ * Set the QPL job parameters and properties.
+ *
+ * @job: pointer to the qpl_job structure
+ * @is_compression: indicates compression and decompression
+ * @input: pointer to the input data buffer
+ * @input_len: the length of the input data
+ * @output: pointer to the output data buffer
+ * @output_len: the length of the output data
+ */
+static void multifd_qpl_prepare_job(qpl_job *job, bool is_compression,
+                                    uint8_t *input, uint32_t input_len,
+                                    uint8_t *output, uint32_t output_len)
+{
+    job->op = is_compression ? qpl_op_compress : qpl_op_decompress;
+    job->next_in_ptr = input;
+    job->next_out_ptr = output;
+    job->available_in = input_len;
+    job->available_out = output_len;
+    job->flags = QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERIFY;
+    /* only supports compression level 1 */
+    job->level = 1;
+}
+
+/**
+ * multifd_qpl_prepare_comp_job: prepare the compression job
+ *
+ * Set the compression job parameters and properties.
+ *
+ * @job: pointer to the qpl_job structure
+ * @input: pointer to the input data buffer
+ * @output: pointer to the output data buffer
+ * @size: the page size
+ */
+static void multifd_qpl_prepare_comp_job(qpl_job *job, uint8_t *input,
+                                         uint8_t *output, uint32_t size)
+{
+    /*
+     * Set output length to less than the page size to force the job to
+     * fail in case it compresses to a larger size. We'll send that page
+     * without compression and skip the decompression operation on the
+     * destination.
+     */
+    multifd_qpl_prepare_job(job, true, input, size, output, size - 1);
+}
+
+/**
+ * multifd_qpl_prepare_decomp_job: prepare the decompression job
+ *
+ * Set the decompression job parameters and properties.
+ *
+ * @job: pointer to the qpl_job structure
+ * @input: pointer to the input data buffer
+ * @len: the length of the input data
+ * @output: pointer to the output data buffer
+ * @size: the page size
+ */
+static void multifd_qpl_prepare_decomp_job(qpl_job *job, uint8_t *input,
+                                           uint32_t len, uint8_t *output,
+                                           uint32_t size)
+{
+    multifd_qpl_prepare_job(job, false, input, len, output, size);
+}
+
+/**
+ * multifd_qpl_fill_iov: fill in the IOV
+ *
+ * Fill in the QPL packet IOV
+ *
+ * @p: Params for the channel being used
+ * @data: pointer to the IOV data
+ * @len: The length of the IOV data
+ */
+static void multifd_qpl_fill_iov(MultiFDSendParams *p, uint8_t *data,
+                                 uint32_t len)
+{
+    p->iov[p->iovs_num].iov_base = data;
+    p->iov[p->iovs_num].iov_len = len;
+    p->iovs_num++;
+    p->next_packet_size += len;
+}
+
+/**
+ * multifd_qpl_fill_packet: fill the compressed page into the QPL packet
+ *
+ * Fill the compressed page length and IOV into the QPL packet
+ *
+ * @idx: The index of the compressed length array
+ * @p: Params for the channel being used
+ * @data: pointer to the compressed page buffer
+ * @len: The length of the compressed page
+ */
+static void multifd_qpl_fill_packet(uint32_t idx, MultiFDSendParams *p,
+                                    uint8_t *data, uint32_t len)
+{
+    QplData *qpl = p->compress_data;
+
+    qpl->zlen[idx] = cpu_to_be32(len);
+    multifd_qpl_fill_iov(p, data, len);
+}
+
+/**
+ * multifd_qpl_submit_job: submit a job to the hardware
+ *
+ * Submit a QPL hardware job to the IAA device
+ *
+ * Returns true if the job is submitted successfully, otherwise false.
+ *
+ * @job: pointer to the qpl_job structure
+ */
+static bool multifd_qpl_submit_job(qpl_job *job)
+{
+    qpl_status status;
+    uint32_t num = 0;
+
+retry:
+    status = qpl_submit_job(job);
+    if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
+        if (num < MAX_SUBMIT_RETRY_NUM) {
+            num++;
+            goto retry;
+        }
+    }
+    return (status == QPL_STS_OK);
+}
+
+/**
+ * multifd_qpl_compress_pages_slow_path: compress pages using slow path
+ *
+ * Compress the pages using software. If compression fails, the uncompressed
+ * page will be sent.
+ *
+ * @p: Params for the channel being used
+ */
+static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
+{
+    QplData *qpl = p->compress_data;
+    uint32_t size = p->page_size;
+    qpl_job *job = qpl->sw_job;
+    uint8_t *zbuf = qpl->zbuf;
+    uint8_t *buf;
+
+    for (int i = 0; i < p->pages->normal_num; i++) {
+        buf = p->pages->block->host + p->pages->offset[i];
+        multifd_qpl_prepare_comp_job(job, buf, zbuf, size);
+        if (qpl_execute_job(job) == QPL_STS_OK) {
+            multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
+        } else {
+            /* send the uncompressed page */
+            multifd_qpl_fill_packet(i, p, buf, size);
+        }
+        zbuf += size;
+    }
+}
+
+/**
+ * multifd_qpl_compress_pages: compress pages
+ *
+ * Submit the pages to the IAA hardware for compression. If hardware
+ * compression fails, it falls back to software compression. If software
+ * compression also fails, the uncompressed page is sent.
+ *
+ * @p: Params for the channel being used
+ */
+static void multifd_qpl_compress_pages(MultiFDSendParams *p)
+{
+    QplData *qpl = p->compress_data;
+    MultiFDPages_t *pages = p->pages;
+    uint32_t size = p->page_size;
+    QplHwJob *hw_job;
+    uint8_t *buf;
+    uint8_t *zbuf;
+
+    for (int i = 0; i < pages->normal_num; i++) {
+        buf = pages->block->host + pages->offset[i];
+        zbuf = qpl->zbuf + (size * i);
+        hw_job = &qpl->hw_jobs[i];
+        multifd_qpl_prepare_comp_job(hw_job->job, buf, zbuf, size);
+        if (multifd_qpl_submit_job(hw_job->job)) {
+            hw_job->fallback_sw_path = false;
+        } else {
+            /*
+             * The IAA work queue is full, any immediate subsequent job
+             * submission is likely to fail, sending the page via the QPL
+             * software path at this point gives us a better chance of
+             * finding the queue open for the next pages.
+             */
+            hw_job->fallback_sw_path = true;
+            multifd_qpl_prepare_comp_job(qpl->sw_job, buf, zbuf, size);
+            if (qpl_execute_job(qpl->sw_job) == QPL_STS_OK) {
+                hw_job->sw_output = zbuf;
+                hw_job->sw_output_len = qpl->sw_job->total_out;
+            } else {
+                hw_job->sw_output = buf;
+                hw_job->sw_output_len = size;
+            }
+        }
+    }
+
+    for (int i = 0; i < pages->normal_num; i++) {
+        buf = pages->block->host + pages->offset[i];
+        zbuf = qpl->zbuf + (size * i);
+        hw_job = &qpl->hw_jobs[i];
+        if (hw_job->fallback_sw_path) {
+            multifd_qpl_fill_packet(i, p, hw_job->sw_output,
+                                    hw_job->sw_output_len);
+            continue;
+        }
+        if (qpl_wait_job(hw_job->job) == QPL_STS_OK) {
+            multifd_qpl_fill_packet(i, p, zbuf, hw_job->job->total_out);
+        } else {
+            /* send the uncompressed page */
+            multifd_qpl_fill_packet(i, p, buf, size);
+        }
+    }
+}
+
 /**
  * multifd_qpl_send_prepare: prepare data to be able to send
  *
@@ -273,8 +497,26 @@ static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    /* Implement in next patch */
-    return -1;
+    QplData *qpl = p->compress_data;
+    uint32_t len = 0;
+
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
+
+    /* The first IOV is used to store the compressed page lengths */
+    len = p->pages->normal_num * sizeof(uint32_t);
+    multifd_qpl_fill_iov(p, (uint8_t *) qpl->zlen, len);
+    if (qpl->hw_avail) {
+        multifd_qpl_compress_pages(p);
+    } else {
+        multifd_qpl_compress_pages_slow_path(p);
+    }
+
+out:
+    p->flags |= MULTIFD_FLAG_QPL;
+    multifd_send_fill_packet(p);
+    return 0;
 }
 
 /**
@@ -312,6 +554,140 @@ static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
     p->compress_data = NULL;
 }
 
+/**
+ * multifd_qpl_process_and_check_job: process and check a QPL job
+ *
+ * Process the job and check whether the job output length is the
+ * same as the specified length
+ *
+ * Returns true if the job execution succeeded and the output length
+ * is equal to the specified length, otherwise false.
+ *
+ * @job: pointer to the qpl_job structure
+ * @is_hardware: indicates whether the job is a hardware job
+ * @len: Specified output length
+ * @errp: pointer to an error
+ */
+static bool multifd_qpl_process_and_check_job(qpl_job *job, bool is_hardware,
+                                              uint32_t len, Error **errp)
+{
+    qpl_status status;
+
+    status = (is_hardware ? qpl_wait_job(job) : qpl_execute_job(job));
+    if (status != QPL_STS_OK) {
+        error_setg(errp, "qpl job failed with error %d", status);
+        return false;
+    }
+    if (job->total_out != len) {
+        error_setg(errp, "qpl decompressed len %u, expected len %u",
+                   job->total_out, len);
+        return false;
+    }
+    return true;
+}
+
+/**
+ * multifd_qpl_decompress_pages_slow_path: decompress pages using slow path
+ *
+ * Decompress the pages using software
+ *
+ * Returns 0 on success or -1 on error
+ *
+ * @p: Params for the channel being used
+ * @errp: pointer to an error
+ */
+static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p,
+                                                  Error **errp)
+{
+    QplData *qpl = p->compress_data;
+    uint32_t size = p->page_size;
+    qpl_job *job = qpl->sw_job;
+    uint8_t *zbuf = qpl->zbuf;
+    uint8_t *addr;
+    uint32_t len;
+
+    for (int i = 0; i < p->normal_num; i++) {
+        len = qpl->zlen[i];
+        addr = p->host + p->normal[i];
+        /* the page is uncompressed, load it */
+        if (len == size) {
+            memcpy(addr, zbuf, size);
+            zbuf += size;
+            continue;
+        }
+        multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
+        if (!multifd_qpl_process_and_check_job(job, false, size, errp)) {
+            return -1;
+        }
+        zbuf += len;
+    }
+    return 0;
+}
+
+/**
+ * multifd_qpl_decompress_pages: decompress pages
+ *
+ * Decompress the pages using the IAA hardware. If hardware
+ * decompression fails, it falls back to software decompression.
+ *
+ * Returns 0 on success or -1 on error
+ *
+ * @p: Params for the channel being used
+ * @errp: pointer to an error
+ */
+static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error **errp)
+{
+    QplData *qpl = p->compress_data;
+    uint32_t size = p->page_size;
+    uint8_t *zbuf = qpl->zbuf;
+    uint8_t *addr;
+    uint32_t len;
+    qpl_job *job;
+
+    for (int i = 0; i < p->normal_num; i++) {
+        addr = p->host + p->normal[i];
+        len = qpl->zlen[i];
+        /* the page is uncompressed if received length equals the page size */
+        if (len == size) {
+            memcpy(addr, zbuf, size);
+            zbuf += size;
+            continue;
+        }
+
+        job = qpl->hw_jobs[i].job;
+        multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
+        if (multifd_qpl_submit_job(job)) {
+            qpl->hw_jobs[i].fallback_sw_path = false;
+        } else {
+            /*
+             * The IAA work queue is full, any immediate subsequent job
+             * submission is likely to fail, sending the page via the QPL
+             * software path at this point gives us a better chance of
+             * finding the queue open for the next pages.
+             */
+            qpl->hw_jobs[i].fallback_sw_path = true;
+            job = qpl->sw_job;
+            multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
+            if (!multifd_qpl_process_and_check_job(job, false, size, errp)) {
+                return -1;
+            }
+        }
+        zbuf += len;
+    }
+
+    for (int i = 0; i < p->normal_num; i++) {
+        /* ignore pages that have already been processed */
+        if (qpl->zlen[i] == size || qpl->hw_jobs[i].fallback_sw_path) {
+            continue;
+        }
+
+        job = qpl->hw_jobs[i].job;
+        if (!multifd_qpl_process_and_check_job(job, true, size, errp)) {
+            return -1;
+        }
+    }
+    return 0;
+}
 /**
  * multifd_qpl_recv: read the data from the channel into actual pages
  *
@@ -325,8 +701,48 @@ static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
  */
 static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
 {
-    /* Implement in next patch */
-    return -1;
+    QplData *qpl = p->compress_data;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    uint32_t len = 0;
+    uint32_t zbuf_len = 0;
+    int ret;
+
+    if (flags != MULTIFD_FLAG_QPL) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_QPL);
+        return -1;
+    }
+    multifd_recv_zero_page_process(p);
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
+    /* read compressed page lengths */
+    len = p->normal_num * sizeof(uint32_t);
+    assert(len < in_size);
+    ret = qio_channel_read_all(p->c, (void *) qpl->zlen, len, errp);
+    if (ret != 0) {
+        return ret;
+    }
+    for (int i = 0; i < p->normal_num; i++) {
+        qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
+        assert(qpl->zlen[i] <= p->page_size);
+        zbuf_len += qpl->zlen[i];
+    }
+
+    /* read compressed pages */
+    assert(in_size == len + zbuf_len);
+    ret = qio_channel_read_all(p->c, (void *) qpl->zbuf, zbuf_len, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (qpl->hw_avail) {
+        return multifd_qpl_decompress_pages(p, errp);
+    }
+    return multifd_qpl_decompress_pages_slow_path(p, errp);
 }
 
 static MultiFDMethods multifd_qpl_ops = {
-- 
2.43.0


