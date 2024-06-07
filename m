Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22924C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFa3Q-0005Jl-6m; Fri, 07 Jun 2024 09:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa3O-0005J6-M1
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:54:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa3M-0008As-Te
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:54:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwjHw4tQyz6H7KH;
 Fri,  7 Jun 2024 21:50:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3D4E4140B33;
 Fri,  7 Jun 2024 21:54:47 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 14:54:39 +0100
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>
CC: <yuan1.liu@intel.com>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, <thuth@redhat.com>, <armbru@redhat.com>,
 <lvivier@redhat.com>, <linuxarm@huawei.com>, <linwenkai6@hisilicon.com>,
 <zhangfei.gao@linaro.org>, <huangchenghai2@huawei.com>
Subject: [PATCH v2 5/7] migration/multifd: Add UADK based compression and
 decompression
Date: Fri, 7 Jun 2024 14:53:08 +0100
Message-ID: <20240607135310.46320-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Uses UADK wd_do_comp_sync() API to (de)compress a normal page using
hardware accelerator.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 migration/multifd-uadk.c | 132 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 535411a405..70bba92eaa 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "exec/ramblock.h"
 #include "migration.h"
 #include "multifd.h"
 #include "options.h"
@@ -142,6 +143,15 @@ static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
     p->compress_data = NULL;
 }
 
+static inline void prepare_next_iov(MultiFDSendParams *p, void *base,
+                                    uint32_t len)
+{
+    p->iov[p->iovs_num].iov_base = (uint8_t *)base;
+    p->iov[p->iovs_num].iov_len = len;
+    p->next_packet_size += len;
+    p->iovs_num++;
+}
+
 /**
  * multifd_uadk_send_prepare: prepare data to be able to send
  *
@@ -155,7 +165,56 @@ static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    return -1;
+    struct wd_data *uadk_data = p->compress_data;
+    uint32_t hdr_size;
+    uint8_t *buf = uadk_data->buf;
+    int ret = 0;
+
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
+
+    hdr_size = p->pages->normal_num * sizeof(uint32_t);
+    /* prepare the header that stores the lengths of all compressed data */
+    prepare_next_iov(p, uadk_data->buf_hdr, hdr_size);
+
+    for (int i = 0; i < p->pages->normal_num; i++) {
+        struct wd_comp_req creq = {
+            .op_type = WD_DIR_COMPRESS,
+            .src     = p->pages->block->host + p->pages->offset[i],
+            .src_len = p->page_size,
+            .dst     = buf,
+            /* Set dst_len to double the src in case compressed out >= page_size */
+            .dst_len = p->page_size * 2,
+        };
+
+        ret = wd_do_comp_sync(uadk_data->handle, &creq);
+        if (ret || creq.status) {
+            error_setg(errp, "multifd %u: failed compression, ret %d status %d",
+                       p->id, ret, creq.status);
+            return -1;
+        }
+        if (creq.dst_len < p->page_size) {
+            uadk_data->buf_hdr[i] = cpu_to_be32(creq.dst_len);
+            prepare_next_iov(p, buf, creq.dst_len);
+            buf += creq.dst_len;
+        } else {
+            /*
+             * Send raw data if compressed out >= page_size. We might be better
+             * off sending raw data if output is slightly less than page_size
+             * as well because at the receive end we can skip the decompression.
+             * But it is tricky to find the right number here.
+             */
+            uadk_data->buf_hdr[i] = cpu_to_be32(p->page_size);
+            prepare_next_iov(p, p->pages->block->host + p->pages->offset[i],
+                             p->page_size);
+            buf += p->page_size;
+        }
+    }
+out:
+    p->flags |= MULTIFD_FLAG_UADK;
+    multifd_send_fill_packet(p);
+    return 0;
 }
 
 /**
@@ -208,7 +267,76 @@ static void multifd_uadk_recv_cleanup(MultiFDRecvParams *p)
  */
 static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 {
-    return -1;
+    struct wd_data *uadk_data = p->compress_data;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    uint32_t hdr_len = p->normal_num * sizeof(uint32_t);
+    uint32_t data_len = 0;
+    uint8_t *buf = uadk_data->buf;
+    int ret = 0;
+
+    if (flags != MULTIFD_FLAG_UADK) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_ZLIB);
+        return -1;
+    }
+
+    multifd_recv_zero_page_process(p);
+    if (!p->normal_num) {
+        assert(in_size == 0);
+        return 0;
+    }
+
+    /* read compressed data lengths */
+    assert(hdr_len < in_size);
+    ret = qio_channel_read_all(p->c, (void *) uadk_data->buf_hdr,
+                               hdr_len, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    for (int i = 0; i < p->normal_num; i++) {
+        uadk_data->buf_hdr[i] = be32_to_cpu(uadk_data->buf_hdr[i]);
+        data_len += uadk_data->buf_hdr[i];
+        assert(uadk_data->buf_hdr[i] <= p->page_size);
+    }
+
+    /* read compressed data */
+    assert(in_size == hdr_len + data_len);
+    ret = qio_channel_read_all(p->c, (void *)buf, data_len, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    for (int i = 0; i < p->normal_num; i++) {
+        struct wd_comp_req creq = {
+            .op_type = WD_DIR_DECOMPRESS,
+            .src     = buf,
+            .src_len = uadk_data->buf_hdr[i],
+            .dst     = p->host + p->normal[i],
+            .dst_len = p->page_size,
+        };
+
+        if (uadk_data->buf_hdr[i] == p->page_size) {
+            memcpy(p->host + p->normal[i], buf, p->page_size);
+            buf += p->page_size;
+            continue;
+        }
+
+        ret = wd_do_comp_sync(uadk_data->handle, &creq);
+        if (ret || creq.status) {
+            error_setg(errp, "multifd %u: failed decompression, ret %d status %d",
+                       p->id, ret, creq.status);
+            return -1;
+        }
+        if (creq.dst_len != p->page_size) {
+            error_setg(errp, "multifd %u: decompressed length error", p->id);
+            return -1;
+        }
+        buf += uadk_data->buf_hdr[i];
+     }
+
+    return 0;
 }
 
 static MultiFDMethods multifd_uadk_ops = {
-- 
2.34.1


