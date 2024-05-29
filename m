Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB78C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 09:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCFsV-0005JD-Cc; Wed, 29 May 2024 05:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCFsP-0005Hc-Mc
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCFsM-0000UN-Rh
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq4CB6bTQz6K6kr;
 Wed, 29 May 2024 17:41:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 34BDA140AA7;
 Wed, 29 May 2024 17:45:40 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:45:34 +0100
To: <peterx@redhat.com>, <farosas@suse.de>, <yuan1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>,
 <linwenkai6@hisilicon.com>, <zhangfei.gao@linaro.org>,
 <huangchenghai2@huawei.com>
Subject: [PATCH 4/7] migration/multifd: Add UADK initialization
Date: Wed, 29 May 2024 10:44:24 +0100
Message-ID: <20240529094435.11140-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Initialize UADK session and allocate buffers required. The actual
compression/decompression will only be done in a subsequent patch.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 migration/multifd-uadk.c | 207 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 1 deletion(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index c2bb07535b..3172e4d5ca 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -12,9 +12,214 @@
 
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
+static bool uadk_hw_initialised(void)
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
+    if (!uadk_hw_initialised()) {
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
+ * multifd_uadk_recv_cleanup: setup receive side
+ *
+ * For no compression this function does nothing.
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
2.17.1


