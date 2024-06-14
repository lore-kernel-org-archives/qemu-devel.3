Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59017C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZM-00016o-M2; Fri, 14 Jun 2024 13:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZH-00016B-T2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:27 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZF-00044E-OV
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B36320726;
 Fri, 14 Jun 2024 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKQ+UvrKUDVvIEdQ2MPCcUE36t6xt8+2LMyymHctKEY=;
 b=qjNXH6U5WKi+0zIs757ibu9UzAHUpghrTuBhhEYUaXcIal0+lJDDqslZe+PYMYdSbGa/Rw
 UozFseGu48NLpMFuqw6y7RXig9L1biJu/v2BQoYXhUQph/w4f/LK4BnmoaKwZGMrvjxRwW
 0BobWIJjg/H0q0FtAxE8CsFKEmJ5ruY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKQ+UvrKUDVvIEdQ2MPCcUE36t6xt8+2LMyymHctKEY=;
 b=PQNeNuclBEta/mHZCJPAYAMUfs6OvooJPt29Kj9GrtC+lSxlO2NAKhibWLE7qr2oGLY2oJ
 JdMd5xiXVJqT/VCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qjNXH6U5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PQNeNucl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKQ+UvrKUDVvIEdQ2MPCcUE36t6xt8+2LMyymHctKEY=;
 b=qjNXH6U5WKi+0zIs757ibu9UzAHUpghrTuBhhEYUaXcIal0+lJDDqslZe+PYMYdSbGa/Rw
 UozFseGu48NLpMFuqw6y7RXig9L1biJu/v2BQoYXhUQph/w4f/LK4BnmoaKwZGMrvjxRwW
 0BobWIJjg/H0q0FtAxE8CsFKEmJ5ruY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKQ+UvrKUDVvIEdQ2MPCcUE36t6xt8+2LMyymHctKEY=;
 b=PQNeNuclBEta/mHZCJPAYAMUfs6OvooJPt29Kj9GrtC+lSxlO2NAKhibWLE7qr2oGLY2oJ
 JdMd5xiXVJqT/VCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC35E13AB1;
 Fri, 14 Jun 2024 17:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mO6BJF57bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yuan Liu <yuan1.liu@intel.com>, Nanhai Zou <nanhai.zou@intel.com>
Subject: [PULL 09/18] migration/multifd: implement initialization of qpl
 compression
Date: Fri, 14 Jun 2024 14:17:53 -0300
Message-Id: <20240614171802.28451-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B36320726
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,intel.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Yuan Liu <yuan1.liu@intel.com>

during initialization, a software job is allocated to each channel
for software path fallabck when the IAA hardware is unavailable or
the hardware job submission fails. If the IAA hardware is available,
multiple hardware jobs are allocated for batch processing.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
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
2.35.3


