Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CDDC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFa3b-00060B-6w; Fri, 07 Jun 2024 09:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa3a-0005zk-28
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:55:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa3X-0008CR-TA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:55:01 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwjJT13Mzz6JB6P;
 Fri,  7 Jun 2024 21:50:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id B75E3140DAF;
 Fri,  7 Jun 2024 21:54:57 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 14:54:48 +0100
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>
CC: <yuan1.liu@intel.com>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, <thuth@redhat.com>, <armbru@redhat.com>,
 <lvivier@redhat.com>, <linuxarm@huawei.com>, <linwenkai6@hisilicon.com>,
 <zhangfei.gao@linaro.org>, <huangchenghai2@huawei.com>
Subject: [PATCH v2 6/7] migration/multifd: Switch to no compression when no
 hardware support
Date: Fri, 7 Jun 2024 14:53:09 +0100
Message-ID: <20240607135310.46320-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Send raw packets over if UADK hardware support is not available. This is to
satisfy  Qemu qtest CI which may run on platforms that don't have UADK
hardware support. Subsequent patch will add support for uadk migration
qtest.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 migration/multifd-uadk.c | 92 +++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 70bba92eaa..d12353fb21 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -17,6 +17,7 @@
 #include "migration.h"
 #include "multifd.h"
 #include "options.h"
+#include "qemu/error-report.h"
 #include "uadk/wd_comp.h"
 #include "uadk/wd_sched.h"
 
@@ -48,29 +49,29 @@ static struct wd_data *multifd_uadk_init_sess(uint32_t count,
     uint32_t size = count * page_size;
     struct wd_data *wd;
 
-    if (!uadk_hw_init()) {
-        error_setg(errp, "multifd: UADK hardware not available");
-        return NULL;
-    }
-
     wd = g_new0(struct wd_data, 1);
-    ss.alg_type = WD_ZLIB;
-    if (compress) {
-        ss.op_type = WD_DIR_COMPRESS;
-        /* Add an additional page for handling output > input */
-        size += page_size;
-    } else {
-        ss.op_type = WD_DIR_DECOMPRESS;
-    }
-
-    /* We use default level 1 compression and 4K window size */
-    param.type = ss.op_type;
-    ss.sched_param = &param;
 
-    wd->handle = wd_comp_alloc_sess(&ss);
-    if (!wd->handle) {
-        error_setg(errp, "multifd: failed wd_comp_alloc_sess");
-        goto out;
+    if (uadk_hw_init()) {
+        ss.alg_type = WD_ZLIB;
+        if (compress) {
+            ss.op_type = WD_DIR_COMPRESS;
+            /* Add an additional page for handling output > input */
+            size += page_size;
+        } else {
+            ss.op_type = WD_DIR_DECOMPRESS;
+        }
+        /* We use default level 1 compression and 4K window size */
+        param.type = ss.op_type;
+        ss.sched_param = &param;
+
+        wd->handle = wd_comp_alloc_sess(&ss);
+        if (!wd->handle) {
+            error_setg(errp, "multifd: failed wd_comp_alloc_sess");
+            goto out;
+        }
+    } else {
+        /* For CI test use */
+        warn_report_once("UADK hardware not available. Switch to no compression mode");
     }
 
     wd->buf = g_try_malloc(size);
@@ -82,7 +83,9 @@ static struct wd_data *multifd_uadk_init_sess(uint32_t count,
     return wd;
 
 out_free_sess:
-    wd_comp_free_sess(wd->handle);
+    if (wd->handle) {
+        wd_comp_free_sess(wd->handle);
+    }
 out:
     wd_comp_uninit2();
     g_free(wd);
@@ -91,7 +94,9 @@ out:
 
 static void multifd_uadk_uninit_sess(struct wd_data *wd)
 {
-    wd_comp_free_sess(wd->handle);
+    if (wd->handle) {
+        wd_comp_free_sess(wd->handle);
+    }
     wd_comp_uninit2();
     g_free(wd->buf);
     g_free(wd->buf_hdr);
@@ -188,23 +193,26 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
             .dst_len = p->page_size * 2,
         };
 
-        ret = wd_do_comp_sync(uadk_data->handle, &creq);
-        if (ret || creq.status) {
-            error_setg(errp, "multifd %u: failed compression, ret %d status %d",
-                       p->id, ret, creq.status);
-            return -1;
+        if (uadk_data->handle) {
+            ret = wd_do_comp_sync(uadk_data->handle, &creq);
+            if (ret || creq.status) {
+                error_setg(errp, "multifd %u: failed compression, ret %d status %d",
+                           p->id, ret, creq.status);
+                return -1;
+            }
+            if (creq.dst_len < p->page_size) {
+                uadk_data->buf_hdr[i] = cpu_to_be32(creq.dst_len);
+                prepare_next_iov(p, buf, creq.dst_len);
+                buf += creq.dst_len;
+            }
         }
-        if (creq.dst_len < p->page_size) {
-            uadk_data->buf_hdr[i] = cpu_to_be32(creq.dst_len);
-            prepare_next_iov(p, buf, creq.dst_len);
-            buf += creq.dst_len;
-        } else {
-            /*
-             * Send raw data if compressed out >= page_size. We might be better
-             * off sending raw data if output is slightly less than page_size
-             * as well because at the receive end we can skip the decompression.
-             * But it is tricky to find the right number here.
-             */
+        /*
+         * Send raw data if no UADK hardware or if compressed out >= page_size.
+         * We might be better off sending raw data if output is slightly less
+         * than page_size as well because at the receive end we can skip the
+         * decompression. But it is tricky to find the right number here.
+         */
+        if (!uadk_data->handle || creq.dst_len >= p->page_size) {
             uadk_data->buf_hdr[i] = cpu_to_be32(p->page_size);
             prepare_next_iov(p, p->pages->block->host + p->pages->offset[i],
                              p->page_size);
@@ -323,6 +331,12 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
             continue;
         }
 
+        if (unlikely(!uadk_data->handle)) {
+            error_setg(errp, "multifd %u: UADK HW not available for decompression",
+                       p->id);
+            return -1;
+        }
+
         ret = wd_do_comp_sync(uadk_data->handle, &creq);
         if (ret || creq.status) {
             error_setg(errp, "multifd %u: failed decompression, ret %d status %d",
-- 
2.34.1


