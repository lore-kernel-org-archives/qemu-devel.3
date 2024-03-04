Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD80C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNfA-0004Uv-KK; Tue, 05 Mar 2024 00:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNf8-0004UQ-TE
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:26 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhNf6-0003fB-Rp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 00:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709617705; x=1741153705;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lOg7Z2NiVWexPEJdPMGkjDH7mkPnvTrF6i/RWRX6gvQ=;
 b=OO4r/tof1F7FwIQ1tu4MDJ1NOQbC3sWxp0wO4oC1U/Pn8qZ4px7VlcgD
 ilKYhs52tjK4D8jodpzCtBjClZOhQ4EQWncKoirsw6oDcRw2Vo0ZM6NxT
 +3W2zQyzhsTfjGPGaxNrzSX/CwduXxVoDeLCACxuhtTF8LlojKd9FqSBy
 QPIJyc2cuu31j+/FuSIAeLE5Y/MihvFQJzvHBnfDKYYUtGDrR0hCIt7w6
 n8fBsclkVhsxavQt3qsT5fcU8YfykAS3w+qYmF0EilfooPh1maxu/IkHW
 IBj9OwCWa8cq/LPzXP4/gjD7xrw847htFMlCuF+4oX5KzHhBaJqi56pEH A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7096091"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7096091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 21:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="46785282"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 21:48:22 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com, bryan.zhang@bytedance.com,
 yuan1.liu@intel.com, nanhai.zou@intel.com
Subject: [PATCH v4 6/8] migration/multifd: implement qpl compression and
 decompression
Date: Mon,  4 Mar 2024 22:00:26 +0800
Message-Id: <20240304140028.1590649-7-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240304140028.1590649-1-yuan1.liu@intel.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yuan1.liu@intel.com;
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

each qpl job is used to (de)compress a normal page and it can
be processed independently by the IAA hardware. All qpl jobs
are submitted to the hardware at once, and wait for all jobs
completion.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
---
 migration/multifd-qpl.c | 219 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 4 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index f4db97ca01..eb815ea3be 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -167,6 +167,112 @@ static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
     p->data = NULL;
 }
 
+static inline void prepare_job(qpl_job *job, uint8_t *input, uint32_t input_len,
+                               uint8_t *output, uint32_t output_len,
+                               bool is_compression)
+{
+    job->op = is_compression ? qpl_op_compress : qpl_op_decompress;
+    job->next_in_ptr = input;
+    job->next_out_ptr = output;
+    job->available_in = input_len;
+    job->available_out = output_len;
+    job->flags = QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERIFY;
+    /* only supports one compression level */
+    job->level = 1;
+}
+
+/**
+ * set_raw_data_hdr: set the length of raw data
+ *
+ * If the length of the compressed output data is greater than or equal to
+ * the page size, then set the compressed data length to the data size and
+ * send raw data directly.
+ *
+ * @qpl: pointer to the qpl_data structure
+ * @index: the index of the compression job header
+ */
+static inline void set_raw_data_hdr(struct qpl_data *qpl, uint32_t index)
+{
+    assert(index < qpl->job_num);
+    qpl->zbuf_hdr[index] = cpu_to_be32(qpl->data_size);
+}
+
+/**
+ * is_raw_data: check if the data is raw data
+ *
+ * The raw data length is always equal to data size, which is the
+ * size of one page.
+ *
+ * Returns true if the data is raw data, otherwise false
+ *
+ * @qpl: pointer to the qpl_data structure
+ * @index: the index of the decompressed job header
+ */
+static inline bool is_raw_data(struct qpl_data *qpl, uint32_t index)
+{
+    assert(index < qpl->job_num);
+    return qpl->zbuf_hdr[index] == qpl->data_size;
+}
+
+static int run_comp_jobs(MultiFDSendParams *p, Error **errp)
+{
+    qpl_status status;
+    struct qpl_data *qpl = p->data;
+    MultiFDPages_t *pages = p->pages;
+    uint32_t job_num = pages->num;
+    qpl_job *job = NULL;
+    uint32_t off = 0;
+
+    assert(job_num <= qpl->job_num);
+    /* submit all compression jobs */
+    for (int i = 0; i < job_num; i++) {
+        job = qpl->job_array[i];
+        /* the compressed data size should be less than one page */
+        prepare_job(job, pages->block->host + pages->offset[i], qpl->data_size,
+                    qpl->zbuf + off, qpl->data_size - 1, true);
+retry:
+        status = qpl_submit_job(job);
+        if (status == QPL_STS_OK) {
+            off += qpl->data_size;
+        } else if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
+            goto retry;
+        } else {
+            error_setg(errp, "multifd %u: qpl_submit_job failed with error %d",
+                       p->id, status);
+            return -1;
+        }
+    }
+
+    /* wait all jobs to complete */
+    for (int i = 0; i < job_num; i++) {
+        job = qpl->job_array[i];
+        status = qpl_wait_job(job);
+        if (status == QPL_STS_OK) {
+            qpl->zbuf_hdr[i] = cpu_to_be32(job->total_out);
+            p->iov[p->iovs_num].iov_len = job->total_out;
+            p->iov[p->iovs_num].iov_base = qpl->zbuf + (qpl->data_size * i);
+            p->next_packet_size += job->total_out;
+        } else if (status == QPL_STS_MORE_OUTPUT_NEEDED) {
+            /*
+             * the compression job does not fail, the output data
+             * size is larger than the provided memory size. In this
+             * case, raw data is sent directly to the destination.
+             */
+            set_raw_data_hdr(qpl, i);
+            p->iov[p->iovs_num].iov_len = qpl->data_size;
+            p->iov[p->iovs_num].iov_base = pages->block->host +
+                                           pages->offset[i];
+            p->next_packet_size += qpl->data_size;
+        } else {
+            error_setg(errp, "multifd %u: qpl_wait_job failed with error %d",
+                       p->id, status);
+            return -1;
+        }
+        p->iovs_num++;
+    }
+    return 0;
+}
+
 /**
  * qpl_send_prepare: prepare data to be able to send
  *
@@ -180,8 +286,25 @@ static void qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int qpl_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    /* Implement in next patch */
-    return -1;
+    struct qpl_data *qpl = p->data;
+    uint32_t hdr_size = p->pages->num * sizeof(uint32_t);
+
+    multifd_send_prepare_header(p);
+
+    assert(p->pages->num <= qpl->job_num);
+    /* prepare the header that stores the lengths of all compressed data */
+    p->iov[1].iov_base = (uint8_t *) qpl->zbuf_hdr;
+    p->iov[1].iov_len = hdr_size;
+    p->iovs_num++;
+    p->next_packet_size += hdr_size;
+    p->flags |= MULTIFD_FLAG_QPL;
+
+    if (run_comp_jobs(p, errp) != 0) {
+        return -1;
+    }
+
+    multifd_send_fill_packet(p);
+    return 0;
 }
 
 /**
@@ -223,6 +346,60 @@ static void qpl_recv_cleanup(MultiFDRecvParams *p)
     p->data = NULL;
 }
 
+static int run_decomp_jobs(MultiFDRecvParams *p, Error **errp)
+{
+    qpl_status status;
+    qpl_job *job;
+    struct qpl_data *qpl = p->data;
+    uint32_t off = 0;
+    uint32_t job_num = p->normal_num;
+
+    assert(job_num <= qpl->job_num);
+    /* submit all decompression jobs */
+    for (int i = 0; i < job_num; i++) {
+        /* for the raw data, load it directly */
+        if (is_raw_data(qpl, i)) {
+            memcpy(p->host + p->normal[i], qpl->zbuf + off, qpl->data_size);
+            off += qpl->data_size;
+            continue;
+        }
+        job = qpl->job_array[i];
+        prepare_job(job, qpl->zbuf + off, qpl->zbuf_hdr[i],
+                    p->host + p->normal[i], qpl->data_size, false);
+retry:
+        status = qpl_submit_job(job);
+        if (status == QPL_STS_OK) {
+            off += qpl->zbuf_hdr[i];
+        } else if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
+            goto retry;
+        } else {
+            error_setg(errp, "multifd %u: qpl_submit_job failed with error %d",
+                       p->id, status);
+            return -1;
+        }
+    }
+
+    /* wait all jobs to complete */
+    for (int i = 0; i < job_num; i++) {
+        if (is_raw_data(qpl, i)) {
+            continue;
+        }
+        job = qpl->job_array[i];
+        status = qpl_wait_job(job);
+        if (status != QPL_STS_OK) {
+            error_setg(errp, "multifd %u: qpl_wait_job failed with error %d",
+                       p->id, status);
+            return -1;
+        }
+        if (job->total_out != qpl->data_size) {
+            error_setg(errp, "multifd %u: decompressed len %u, expected len %u",
+                       p->id, job->total_out, qpl->data_size);
+            return -1;
+        }
+    }
+    return 0;
+}
+
 /**
  * qpl_recv_pages: read the data from the channel into actual pages
  *
@@ -236,8 +413,42 @@ static void qpl_recv_cleanup(MultiFDRecvParams *p)
  */
 static int qpl_recv_pages(MultiFDRecvParams *p, Error **errp)
 {
-    /* Implement in next patch */
-    return -1;
+    struct qpl_data *qpl = p->data;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    uint32_t hdr_len = p->normal_num * sizeof(uint32_t);
+    uint32_t data_len = 0;
+    int ret;
+
+    if (flags != MULTIFD_FLAG_QPL) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_QPL);
+        return -1;
+    }
+    /* read comprssed data lengths */
+    assert(hdr_len < in_size);
+    ret = qio_channel_read_all(p->c, (void *) qpl->zbuf_hdr, hdr_len, errp);
+    if (ret != 0) {
+        return ret;
+    }
+    assert(p->normal_num <= qpl->job_num);
+    for (int i = 0; i < p->normal_num; i++) {
+        qpl->zbuf_hdr[i] = be32_to_cpu(qpl->zbuf_hdr[i]);
+        data_len += qpl->zbuf_hdr[i];
+        assert(qpl->zbuf_hdr[i] <= qpl->data_size);
+    }
+
+    /* read comprssed data */
+    assert(in_size == hdr_len + data_len);
+    ret = qio_channel_read_all(p->c, (void *) qpl->zbuf, data_len, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (run_decomp_jobs(p, errp) != 0) {
+        return -1;
+    }
+    return 0;
 }
 
 /**
-- 
2.39.3


