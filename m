Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EE4C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 16:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUSr6-0007vj-6O; Wed, 25 Jun 2025 12:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uUSqx-0007kv-DG; Wed, 25 Jun 2025 12:20:05 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uUSqv-0005wE-H6; Wed, 25 Jun 2025 12:20:02 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bS6V34vJfz6DJfs;
 Thu, 26 Jun 2025 00:19:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5F3A51402F7;
 Thu, 26 Jun 2025 00:19:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Jun 2025 18:19:58 +0200
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <mst@redhat.com>, Zhijian Li
 <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH qemu v16 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
Date: Wed, 25 Jun 2025 17:19:22 +0100
Message-ID: <20250625161926.549812-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To enable these to be found in a fixed order, that order needs to be known.
This will later be used to sort a list of these structures so that address
map and ACPI table entries are predictable.

Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v16: Tested tag
---
 include/hw/cxl/cxl.h | 1 +
 hw/cxl/cxl-host.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 75e47b6864..b2bcce7ed6 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -27,6 +27,7 @@
 typedef struct PXBCXLDev PXBCXLDev;
 
 typedef struct CXLFixedWindow {
+    int index;
     uint64_t size;
     char **targets;
     PXBCXLDev *target_hbs[16];
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e010163174..b7aa429ddf 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -24,13 +24,15 @@
 
 static void cxl_fixed_memory_window_config(CXLState *cxl_state,
                                            CXLFixedMemoryWindowOptions *object,
-                                           Error **errp)
+                                           int index, Error **errp)
 {
     ERRP_GUARD();
     g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
     strList *target;
     int i;
 
+    fw->index = index;
+
     for (target = object->targets; target; target = target->next) {
         fw->num_targets++;
     }
@@ -325,14 +327,15 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     CXLState *state = opaque;
     CXLFixedMemoryWindowOptionsList *cfmw_list = NULL;
     CXLFixedMemoryWindowOptionsList *it;
+    int index;
 
     visit_type_CXLFixedMemoryWindowOptionsList(v, name, &cfmw_list, errp);
     if (!cfmw_list) {
         return;
     }
 
-    for (it = cfmw_list; it; it = it->next) {
-        cxl_fixed_memory_window_config(state, it->value, errp);
+    for (it = cfmw_list, index = 0; it; it = it->next, index++) {
+        cxl_fixed_memory_window_config(state, it->value, index, errp);
     }
     state->cfmw_list = cfmw_list;
 }
-- 
2.48.1


