Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4989C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEncl-0007zw-AC; Tue, 13 May 2025 07:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uEncj-0007yY-9n
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:16:37 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uEnch-0006sd-DU
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:16:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZxYhQ0h1yz6M4Lf;
 Tue, 13 May 2025 19:11:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5A624140276;
 Tue, 13 May 2025 19:16:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 13:16:29 +0200
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <qemu-arm@nongnu.org>, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PATCH v13 3/5] hw/cxl-host: Allow split of establishing memory
 address and mmio setup.
Date: Tue, 13 May 2025 12:14:53 +0100
Message-ID: <20250513111455.128266-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
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

On arm/virt the memory map is set up before any devices are brought
up.  To enable this provide split functions to establish the fw->base
and later to actually map it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_host.h |  2 ++
 hw/cxl/cxl-host-stubs.c   |  2 ++
 hw/cxl/cxl-host.c         | 44 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 6dce2cde07..aee9d573d6 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -16,6 +16,8 @@
 void cxl_machine_init(Object *obj, CXLState *state);
 void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
+void cxl_fmws_update_mmio(void);
 hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr);
 GSList *cxl_fmws_get_all_sorted(void);
 
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index 13eb6bf6a4..d9e38618d6 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -11,6 +11,8 @@
 void cxl_fmws_link_targets(Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr) { return base; };
+void cxl_fmws_update_mmio(void) {};
 hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
 {
     return base;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 438f2920e1..3b9184e7e7 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -383,6 +383,7 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
 struct cfmw_update_state {
     hwaddr base;
     hwaddr maxaddr;
+    bool update_mmio;
 };
 
 static void cxl_fmws_update(Object *obj, void *opaque)
@@ -397,7 +398,9 @@ static void cxl_fmws_update(Object *obj, void *opaque)
     fw = CXL_FMW(obj);
     if (s->base + fw->size <= s->maxaddr) {
         fw->base = s->base;
-        sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+        if (s->update_mmio) {
+            sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+        }
         s->base += fw->size;
     }
 
@@ -438,6 +441,24 @@ GSList *cxl_fmws_get_all_sorted(void)
     return g_slist_sort_with_data(cxl_fmws_get_all(), cfmws_cmp, NULL);
 }
 
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+{
+    GSList *cfmws_list, *iter;
+
+    struct cfmw_update_state cfmwss = {
+        .base = base,
+        .maxaddr = max_addr,
+        .update_mmio = false,
+    };
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        cxl_fmws_update(iter->data, &cfmwss);
+    }
+    g_slist_free(cfmws_list);
+
+    return cfmwss.base;
+}
+
 hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
 {
     GSList *cfmws_list, *iter;
@@ -445,6 +466,7 @@ hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
     struct cfmw_update_state cfmwss = {
         .base = base,
         .maxaddr = max_addr,
+        .update_mmio = true,
     };
     cfmws_list = cxl_fmws_get_all_sorted();
     for (iter = cfmws_list; iter; iter = iter->next) {
@@ -455,6 +477,26 @@ hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
     return cfmwss.base;
 }
 
+static int cxl_fmws_mmio_map(Object *obj, void *opaque)
+{
+    struct CXLFixedWindow *fw;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    fw = CXL_FMW(obj);
+    sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+
+    return 0;
+}
+
+void cxl_fmws_update_mmio(void)
+{
+    /* Ordering is not required for this */
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map,
+                                   NULL);
+}
+
 static void cxl_fmw_realize(DeviceState *dev, Error **errp)
 {
     CXLFixedWindow *fw = CXL_FMW(dev);
-- 
2.43.0


