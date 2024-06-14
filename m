Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B15C27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZW-0001As-FI; Fri, 14 Jun 2024 13:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZU-00019l-3B
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZS-000480-BG
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3681227BF;
 Fri, 14 Jun 2024 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRyPkSc3TYWVxDutYkXNAPRAADM09kh1d2QpwzpjCVU=;
 b=iXCMCRUcP0ExAD/ndjZoMXnM8rJ5ao4w+htoFDEUE8UlHMNwFLyxN90SyJfRA30XOmgSOP
 CoaOnlK4tNY3/AeqfcKc8+ioJfNTr7AhrlNJjKW8yOwEujQw90nnmRKFP4rMZUWIghiFST
 lLZf66B5q+Xmoo2BxTsYgJyiAjq4S9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRyPkSc3TYWVxDutYkXNAPRAADM09kh1d2QpwzpjCVU=;
 b=lw1/Ow+6MchfCPG5ZMDw07Mf31QEDKHZwBVLHaqsoABclIIijl8gyXTemVSQTPfFSswxBP
 GfW/mEyO3QbIdXAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRyPkSc3TYWVxDutYkXNAPRAADM09kh1d2QpwzpjCVU=;
 b=iXCMCRUcP0ExAD/ndjZoMXnM8rJ5ao4w+htoFDEUE8UlHMNwFLyxN90SyJfRA30XOmgSOP
 CoaOnlK4tNY3/AeqfcKc8+ioJfNTr7AhrlNJjKW8yOwEujQw90nnmRKFP4rMZUWIghiFST
 lLZf66B5q+Xmoo2BxTsYgJyiAjq4S9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRyPkSc3TYWVxDutYkXNAPRAADM09kh1d2QpwzpjCVU=;
 b=lw1/Ow+6MchfCPG5ZMDw07Mf31QEDKHZwBVLHaqsoABclIIijl8gyXTemVSQTPfFSswxBP
 GfW/mEyO3QbIdXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6027013AB1;
 Fri, 14 Jun 2024 17:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kFAGCmt7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PULL 15/18] migration/multifd: Add UADK initialization
Date: Fri, 14 Jun 2024 14:17:59 -0300
Message-Id: <20240614171802.28451-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Initialize UADK session and allocate buffers required. The actual
compression/decompression will only be done in a subsequent patch.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-uadk.c | 209 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 1 deletion(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index c2bb07535b..535411a405 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -12,9 +12,216 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "multifd.h"
+#include "options.h"
+#include "uadk/wd_comp.h"
+#include "uadk/wd_sched.h"
+
+struct wd_data {
+    handle_t handle;
+    uint8_t *buf;
+    uint32_t *buf_hdr;
+};
+
+static bool uadk_hw_init(void)
+{
+    char alg[] = "zlib";
+    int ret;
+
+    ret = wd_comp_init2(alg, SCHED_POLICY_RR, TASK_HW);
+    if (ret && ret != -WD_EEXIST) {
+        return false;
+    } else {
+        return true;
+    }
+}
+
+static struct wd_data *multifd_uadk_init_sess(uint32_t count,
+                                              uint32_t page_size,
+                                              bool compress, Error **errp)
+{
+    struct wd_comp_sess_setup ss = {0};
+    struct sched_params param = {0};
+    uint32_t size = count * page_size;
+    struct wd_data *wd;
+
+    if (!uadk_hw_init()) {
+        error_setg(errp, "multifd: UADK hardware not available");
+        return NULL;
+    }
+
+    wd = g_new0(struct wd_data, 1);
+    ss.alg_type = WD_ZLIB;
+    if (compress) {
+        ss.op_type = WD_DIR_COMPRESS;
+        /* Add an additional page for handling output > input */
+        size += page_size;
+    } else {
+        ss.op_type = WD_DIR_DECOMPRESS;
+    }
+
+    /* We use default level 1 compression and 4K window size */
+    param.type = ss.op_type;
+    ss.sched_param = &param;
+
+    wd->handle = wd_comp_alloc_sess(&ss);
+    if (!wd->handle) {
+        error_setg(errp, "multifd: failed wd_comp_alloc_sess");
+        goto out;
+    }
+
+    wd->buf = g_try_malloc(size);
+    if (!wd->buf) {
+        error_setg(errp, "multifd: out of mem for uadk buf");
+        goto out_free_sess;
+    }
+    wd->buf_hdr = g_new0(uint32_t, count);
+    return wd;
+
+out_free_sess:
+    wd_comp_free_sess(wd->handle);
+out:
+    wd_comp_uninit2();
+    g_free(wd);
+    return NULL;
+}
+
+static void multifd_uadk_uninit_sess(struct wd_data *wd)
+{
+    wd_comp_free_sess(wd->handle);
+    wd_comp_uninit2();
+    g_free(wd->buf);
+    g_free(wd->buf_hdr);
+    g_free(wd);
+}
+
+/**
+ * multifd_uadk_send_setup: setup send side
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int multifd_uadk_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    struct wd_data *wd;
+
+    wd = multifd_uadk_init_sess(p->page_count, p->page_size, true, errp);
+    if (!wd) {
+        return -1;
+    }
+
+    p->compress_data = wd;
+    assert(p->iov == NULL);
+    /*
+     * Each page will be compressed independently and sent using an IOV. The
+     * additional two IOVs are used to store packet header and compressed data
+     * length
+     */
+
+    p->iov = g_new0(struct iovec, p->page_count + 2);
+    return 0;
+}
+
+/**
+ * multifd_uadk_send_cleanup: cleanup send side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    struct wd_data *wd = p->compress_data;
+
+    multifd_uadk_uninit_sess(wd);
+    p->compress_data = NULL;
+}
+
+/**
+ * multifd_uadk_send_prepare: prepare data to be able to send
+ *
+ * Create a compressed buffer with all the pages that we are going to
+ * send.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    return -1;
+}
+
+/**
+ * multifd_uadk_recv_setup: setup receive side
+ *
+ * Create the compressed channel and buffer.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int multifd_uadk_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    struct wd_data *wd;
+
+    wd = multifd_uadk_init_sess(p->page_count, p->page_size, false, errp);
+    if (!wd) {
+        return -1;
+    }
+    p->compress_data = wd;
+    return 0;
+}
+
+/**
+ * multifd_uadk_recv_cleanup: cleanup receive side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void multifd_uadk_recv_cleanup(MultiFDRecvParams *p)
+{
+    struct wd_data *wd = p->compress_data;
+
+    multifd_uadk_uninit_sess(wd);
+    p->compress_data = NULL;
+}
+
+/**
+ * multifd_uadk_recv: read the data from the channel into actual pages
+ *
+ * Read the compressed buffer, and uncompress it into the actual
+ * pages.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
+{
+    return -1;
+}
+
+static MultiFDMethods multifd_uadk_ops = {
+    .send_setup = multifd_uadk_send_setup,
+    .send_cleanup = multifd_uadk_send_cleanup,
+    .send_prepare = multifd_uadk_send_prepare,
+    .recv_setup = multifd_uadk_recv_setup,
+    .recv_cleanup = multifd_uadk_recv_cleanup,
+    .recv = multifd_uadk_recv,
+};
 
 static void multifd_uadk_register(void)
 {
-    /* noop for now */
+    multifd_register_ops(MULTIFD_COMPRESSION_UADK, &multifd_uadk_ops);
 }
 migration_init(multifd_uadk_register);
-- 
2.35.3


