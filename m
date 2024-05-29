Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BE7C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 09:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCFsh-0005Yr-2v; Wed, 29 May 2024 05:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCFsc-0005Tq-0G
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCFsZ-0000VI-JX
 for qemu-devel@nongnu.org; Wed, 29 May 2024 05:45:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vq4Cl1mqkz6JB95;
 Wed, 29 May 2024 17:41:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E4546140AA7;
 Wed, 29 May 2024 17:45:53 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:45:48 +0100
To: <peterx@redhat.com>, <farosas@suse.de>, <yuan1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>,
 <linwenkai6@hisilicon.com>, <zhangfei.gao@linaro.org>,
 <huangchenghai2@huawei.com>
Subject: [PATCH 6/7] migration/multifd: Switch to no compression when no
 hardware support
Date: Wed, 29 May 2024 10:44:26 +0100
Message-ID: <20240529094435.11140-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Send raw packets over if UADK hardware support is not available. This is to
satisfy  Qemu qtest CI which may run on platforms that don't have UADK
hardware support. Subsequent patch will add support for uadk migration
qtest.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 migration/multifd-uadk.c | 89 +++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 37 deletions(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 3329819bd4..9325c6a2b3 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -17,6 +17,7 @@
 #include "migration.h"
 #include "multifd.h"
 #include "options.h"
+#include "qemu/error-report.h"
 #include "uadk/wd_comp.h"
 #include "uadk/wd_sched.h"
 
@@ -48,27 +49,28 @@ static struct wd_data *multifd_uadk_init_sess(uint32_t count,
     uint32_t size = count * page_size;
     struct wd_data *wd;
 
-    if (!uadk_hw_initialised()) {
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
-    param.type = ss.op_type;
-    ss.sched_param = &param;
 
-    wd->handle = wd_comp_alloc_sess(&ss);
-    if (!wd->handle) {
-        error_setg(errp, "multifd: failed wd_comp_alloc_sess");
-        goto out;
+    if (uadk_hw_initialised()) {
+        ss.alg_type = WD_ZLIB;
+        if (compress) {
+            ss.op_type = WD_DIR_COMPRESS;
+            /* Add an additional page for handling output > input */
+            size += page_size;
+        } else {
+            ss.op_type = WD_DIR_DECOMPRESS;
+        }
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
@@ -80,7 +82,9 @@ static struct wd_data *multifd_uadk_init_sess(uint32_t count,
     return wd;
 
 out_free_sess:
-    wd_comp_free_sess(wd->handle);
+    if (wd->handle) {
+        wd_comp_free_sess(wd->handle);
+    }
 out:
     wd_comp_uninit2();
     g_free(wd);
@@ -89,7 +93,9 @@ out:
 
 static void multifd_uadk_uninit_sess(struct wd_data *wd)
 {
-    wd_comp_free_sess(wd->handle);
+    if (wd->handle) {
+        wd_comp_free_sess(wd->handle);
+    }
     wd_comp_uninit2();
     g_free(wd->buf);
     g_free(wd->buf_hdr);
@@ -186,23 +192,26 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
             .dst_len = p->page_size * 2,
         };
 
-        ret = wd_do_comp_sync(uadk_data->handle, &creq);
-        if (ret || creq.status) {
-            error_setg(errp, "multifd %u: failed wd_do_comp_sync, ret %d status %d",
-                       p->id, ret, creq.status);
-            return -1;
+        if (uadk_data->handle) {
+            ret = wd_do_comp_sync(uadk_data->handle, &creq);
+            if (ret || creq.status) {
+                error_setg(errp, "multifd %u: failed wd_do_comp_sync, ret %d status %d",
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
@@ -321,6 +330,12 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
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
             error_setg(errp, "multifd %u: failed wd_do_comp_sync, ret %d status %d",
-- 
2.17.1


