Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9467C83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuH-0004lo-Ku; Fri, 11 Jul 2025 09:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtp-0004Px-N4
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtn-00032D-2P
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so4524325e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240885; x=1752845685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8z9AtDLYqnn49RbQF2PUqhNNRXhINMXFbAw84qOvI+Y=;
 b=fwjlVYjRxc8VlTpE5DBJkWu5MGLyiXxUelHvdEo4h1T9VqyCkhTS+axCNEusXb+4zO
 8lH/P9PDvLlvY/n5Tm1TOGElcOfK8h1X++6E+wlUuMTu/3g8VgI3lqsler4S8OiZXMRK
 gs/hPUfcc16yo+BQJh9P4bgRX3RdoEMIfGmpLoQlF/YTkgZgp6zSNbtimdV0iC3bzyYW
 5tXLnHbj7eZHmGVz/R43h3SlfvVTb0HbC/rDSpiPEzjFjPFqtZ9XHoDP1ebTu+/3Vxdj
 zNBg//WzZYcEJiiH9IhJjb/+1e/cl/ktB8CfJ8YjpgHIk8en1bi3rRGH2vM3th7lqkDr
 rwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240885; x=1752845685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8z9AtDLYqnn49RbQF2PUqhNNRXhINMXFbAw84qOvI+Y=;
 b=ozGfjhQtAlw1rYB4yuOgLvKHdb/lxrOwyh3ynW5e/ee8UeO38ArSecWn3Q5RjYZQLC
 ImTsjaFgGRFJ5zJk209F38Y1QgxoXziyOCngC/umWq/spnztbSmJ3EqgFFIf1ySETBEe
 20p7eL28bMog65Jnzl+hIdLSxannI9F46cgtQ41W67d08SAU+LYpNYI0DYt+mBWRceH8
 8eegggXRixG2jl1Gc1tpRX6VKpETlZop4KpqNgmLQdhnCqZF5FEXDJAmT/Tf2sq9bS3g
 eMILTFjByPpANLqjh8U65YzlBppNYzPanHZf8ixmwgJ5YW1PUTvKCP32jCNq3+vnGUAw
 QcfQ==
X-Gm-Message-State: AOJu0Yzb9BVlgKiGP3dd9xwYWyDInaRvCapfMXapIb/cUkZtSa0YHGRZ
 wcdLyrfUfSMCcyWkLehSVvHDlcfQoCncT73yBmnXolhwBIwswAvkH9/iwS+lwA+cjLwSidbEVRD
 kXm91
X-Gm-Gg: ASbGncuoFAmEo+fmMR/5Yxtqk1Q2MqyOFTrc/UZnUBlvYdTlGkWBAsq7iYVV+uGrM3D
 3RLGL2tuKRfDchRCiOhxgwjfhVA21yRHBUvf0mMr8sKYrFO+gVql3mCxu29q3LP8ulf7gbqgAhl
 Lt/RJlqdsVk9Il+06+LsxPURLIU/s812xybS3qgmuKoVD/W1Qz6+GgNaMlsBgNRNtAcEbYznp0z
 SgYxSpOQeJAtUDeYYp3MeHyK5JccPf84+L7UYq2470+vCFuQ1sQM2ATo7d2dDt5zwHPzPnQTScS
 rbyoYtRW0OMyS0MAMQII4PTHMeC+FdBam/nALQ2aczL1TaV+71/JUfyvd9eGst/xVPXzA1JCbi5
 eoH5YOPTJpSaxgrablrdKL5NhgNKsfoe/q69uxHU=
X-Google-Smtp-Source: AGHT+IFi3VaeWODir7Dt9BsMWjv/Jvo4C/4gHUQSxvk6g6GpMPoNCZYTcynbj/CzMbtloskCqtzS+g==
X-Received: by 2002:a05:600c:8b26:b0:440:6a37:be0d with SMTP id
 5b1f17b1804b1-454ec26d101mr32138095e9.15.1752240885163; 
 Fri, 11 Jul 2025 06:34:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/36] hw/cxl: Make the CXL fixed memory windows devices.
Date: Fri, 11 Jul 2025 14:34:06 +0100
Message-ID: <20250711133429.1423030-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously these somewhat device like structures were tracked using a list
in the CXLState in each machine. This is proving restrictive in a few
cases where we need to iterate through these without being aware of the
machine type. Just make them sysbus devices.

Restrict them to not user created as they need to be visible to early
stages of machine init given effects on the memory map.

This change both simplifies state tracking and enables features needed
for performance optimization and hotness tracking by making it possible
to retrieve the fixed memory window on actions elsewhere in the topology.

In some cases the ordering of the Fixed Memory Windows matters.
For those utility functions provide a GSList sorted by the window index.
This ensures that we get consistency across:
- ordering in the command line
- ordering of the host PA ranges
- ordering of ACPI CEDT structures describing the CFMWS.

Other aspects don't have this constraint. For those direct iteration
of the underlying hash structures is fine.

In the setup path for the memory map in pc_memory_init() split the
operations into two calls. The first, cxl_fmws_set_mmemap(), loops over
fixed memory windows in order and assigns their addresses.  The second,
cxl_fmws_update_mmio() actually sets up the mmio for each window.
This is obviously less efficient than a single loop but this split design
is needed to put the logic in two different places in the arm64 support
and it is not a hot enough path to justify an x86 only implementation.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Message-id: 20250703104110.992379-3-Jonathan.Cameron@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/cxl/cxl.h      |   4 +-
 include/hw/cxl/cxl_host.h |   5 +-
 hw/acpi/cxl.c             |  76 +++++++++--------
 hw/cxl/cxl-host-stubs.c   |   7 +-
 hw/cxl/cxl-host.c         | 167 +++++++++++++++++++++++++++++++-------
 hw/i386/pc.c              |  50 +++++-------
 6 files changed, 214 insertions(+), 95 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index b2bcce7ed60..de66ab8c354 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -27,6 +27,7 @@
 typedef struct PXBCXLDev PXBCXLDev;
 
 typedef struct CXLFixedWindow {
+    SysBusDevice parent_obj;
     int index;
     uint64_t size;
     char **targets;
@@ -38,12 +39,13 @@ typedef struct CXLFixedWindow {
     MemoryRegion mr;
     hwaddr base;
 } CXLFixedWindow;
+#define TYPE_CXL_FMW "cxl-fmw"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLFixedWindow, CXL_FMW)
 
 typedef struct CXLState {
     bool is_enabled;
     MemoryRegion host_mr;
     unsigned int next_mr_idx;
-    GList *fixed_windows;
     CXLFixedMemoryWindowOptionsList *cfmw_list;
 } CXLState;
 
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index c9bc9c7c500..cd3c368c86a 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -14,8 +14,11 @@
 #define CXL_HOST_H
 
 void cxl_machine_init(Object *obj, CXLState *state);
-void cxl_fmws_link_targets(CXLState *stat, Error **errp);
+void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
+void cxl_fmws_update_mmio(void);
+GSList *cxl_fmws_get_all_sorted(void);
 
 extern const MemoryRegionOps cfmws_ops;
 
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 9cd7905ea25..75d5b30bb8b 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -22,6 +22,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -135,55 +136,52 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
  * Interleave ways encoding in CXL 2.0 ECN: 3, 6, 12 and 16-way memory
  * interleaving.
  */
-static void cedt_build_cfmws(GArray *table_data, CXLState *cxls)
+static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
 {
-    GList *it;
+    GArray *table_data = cedt->buf;
+    int i;
 
-    for (it = cxls->fixed_windows; it; it = it->next) {
-        CXLFixedWindow *fw = it->data;
-        int i;
+    /* Type */
+    build_append_int_noprefix(table_data, 1, 1);
 
-        /* Type */
-        build_append_int_noprefix(table_data, 1, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 1);
+    /* Record Length */
+    build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
 
-        /* Record Length */
-        build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 4);
+    /* Base HPA */
+    build_append_int_noprefix(table_data, fw->mr.addr, 8);
 
-        /* Base HPA */
-        build_append_int_noprefix(table_data, fw->mr.addr, 8);
+    /* Window Size */
+    build_append_int_noprefix(table_data, fw->size, 8);
 
-        /* Window Size */
-        build_append_int_noprefix(table_data, fw->size, 8);
+    /* Host Bridge Interleave Ways */
+    build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
 
-        /* Host Bridge Interleave Ways */
-        build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
+    /* Host Bridge Interleave Arithmetic */
+    build_append_int_noprefix(table_data, 0, 1);
 
-        /* Host Bridge Interleave Arithmetic */
-        build_append_int_noprefix(table_data, 0, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 2);
+    /* Host Bridge Interleave Granularity */
+    build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
-        /* Host Bridge Interleave Granularity */
-        build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
+    /* Window Restrictions */
+    build_append_int_noprefix(table_data, 0x0f, 2);
 
-        /* Window Restrictions */
-        build_append_int_noprefix(table_data, 0x0f, 2); /* No restrictions */
+    /* QTG ID */
+    build_append_int_noprefix(table_data, 0, 2);
 
-        /* QTG ID */
-        build_append_int_noprefix(table_data, 0, 2);
-
-        /* Host Bridge List (list of UIDs - currently bus_nr) */
-        for (i = 0; i < fw->num_targets; i++) {
-            g_assert(fw->target_hbs[i]);
-            build_append_int_noprefix(table_data, PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
-        }
+    /* Host Bridge List (list of UIDs - currently bus_nr) */
+    for (i = 0; i < fw->num_targets; i++) {
+        g_assert(fw->target_hbs[i]);
+        build_append_int_noprefix(table_data,
+                                  PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
     }
 }
 
@@ -202,6 +200,7 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state)
 {
+    GSList *cfmws_list, *iter;
     Aml *cedt;
     AcpiTable table = { .sig = "CEDT", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -213,7 +212,12 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
     /* reserve space for CEDT header */
 
     object_child_foreach_recursive(object_get_root(), cxl_foreach_pxb_hb, cedt);
-    cedt_build_cfmws(cedt->buf, cxl_state);
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        cedt_build_cfmws(CXL_FMW(iter->data), cedt);
+    }
+    g_slist_free(cfmws_list);
 
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, cedt->buf->data, cedt->buf->len);
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index cae4afcdde2..c015baac813 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -8,8 +8,13 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 
-void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
+void cxl_fmws_link_targets(Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+{
+    return base;
+};
+void cxl_fmws_update_mmio(void) {};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index b7aa429ddf4..5c2ce25a19c 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -22,12 +22,12 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 
-static void cxl_fixed_memory_window_config(CXLState *cxl_state,
-                                           CXLFixedMemoryWindowOptions *object,
+static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
 {
     ERRP_GUARD();
-    g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
+    DeviceState *dev = qdev_new(TYPE_CXL_FMW);
+    CXLFixedWindow *fw = CXL_FMW(dev);
     strList *target;
     int i;
 
@@ -67,35 +67,39 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         fw->targets[i] = g_strdup(target->value);
     }
 
-    cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
-                                             g_steal_pointer(&fw));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
 }
 
-void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
+static int cxl_fmws_link(Object *obj, void *opaque)
 {
-    if (cxl_state && cxl_state->fixed_windows) {
-        GList *it;
+    struct CXLFixedWindow *fw;
+    int i;
 
-        for (it = cxl_state->fixed_windows; it; it = it->next) {
-            CXLFixedWindow *fw = it->data;
-            int i;
-
-            for (i = 0; i < fw->num_targets; i++) {
-                Object *o;
-                bool ambig;
-
-                o = object_resolve_path_type(fw->targets[i],
-                                             TYPE_PXB_CXL_DEV,
-                                             &ambig);
-                if (!o) {
-                    error_setg(errp, "Could not resolve CXLFM target %s",
-                               fw->targets[i]);
-                    return;
-                }
-                fw->target_hbs[i] = PXB_CXL_DEV(o);
-            }
-        }
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
     }
+    fw = CXL_FMW(obj);
+
+    for (i = 0; i < fw->num_targets; i++) {
+        Object *o;
+        bool ambig;
+
+        o = object_resolve_path_type(fw->targets[i], TYPE_PXB_CXL_DEV,
+                                     &ambig);
+        if (!o) {
+            error_setg(&error_fatal, "Could not resolve CXLFM target %s",
+                       fw->targets[i]);
+            return 1;
+        }
+        fw->target_hbs[i] = PXB_CXL_DEV(o);
+    }
+    return 0;
+}
+
+void cxl_fmws_link_targets(Error **errp)
+{
+    /* Order doesn't matter for this, so no need to build list */
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_link, NULL);
 }
 
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
@@ -335,7 +339,7 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     }
 
     for (it = cfmw_list, index = 0; it; it = it->next, index++) {
-        cxl_fixed_memory_window_config(state, it->value, index, errp);
+        cxl_fixed_memory_window_config(it->value, index, errp);
     }
     state->cfmw_list = cfmw_list;
 }
@@ -373,3 +377,110 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
         }
     }
 }
+
+static int cxl_fmws_find(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    *list = g_slist_prepend(*list, obj);
+
+    return 0;
+}
+
+static GSList *cxl_fmws_get_all(void)
+{
+    GSList *list = NULL;
+
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_find, &list);
+
+    return list;
+}
+
+static gint cfmws_cmp(gconstpointer a, gconstpointer b, gpointer d)
+{
+    const struct CXLFixedWindow *ap = a;
+    const struct CXLFixedWindow *bp = b;
+
+    return ap->index > bp->index;
+}
+
+GSList *cxl_fmws_get_all_sorted(void)
+{
+    return g_slist_sort_with_data(cxl_fmws_get_all(), cfmws_cmp, NULL);
+}
+
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
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
+}
+
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+{
+    GSList *cfmws_list, *iter;
+    CXLFixedWindow *fw;
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        fw = CXL_FMW(iter->data);
+        if (base + fw->size <= max_addr) {
+            fw->base = base;
+            base += fw->size;
+        }
+    }
+    g_slist_free(cfmws_list);
+
+    return base;
+}
+
+static void cxl_fmw_realize(DeviceState *dev, Error **errp)
+{
+    CXLFixedWindow *fw = CXL_FMW(dev);
+
+    memory_region_init_io(&fw->mr, OBJECT(dev), &cfmws_ops, fw,
+                          "cxl-fixed-memory-region", fw->size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &fw->mr);
+}
+
+/*
+ * Note: Fixed memory windows represent fixed address decoders on the host and
+ * as such have no dynamic state to reset or migrate
+ */
+static void cxl_fmw_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "CXL Fixed Memory Window";
+    dc->realize = cxl_fmw_realize;
+    /* Reason - created by machines as tightly coupled to machine memory map */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo cxl_fmw_info = {
+    .name = TYPE_CXL_FMW,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CXLFixedWindow),
+    .class_init = cxl_fmw_class_init,
+};
+
+static void cxl_host_register_types(void)
+{
+    type_register_static(&cxl_fmw_info);
+}
+type_init(cxl_host_register_types)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b2116335752..860346d6b7f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -609,7 +609,7 @@ void pc_machine_done(Notifier *notifier, void *data)
                               &error_fatal);
 
     if (pcms->cxl_devices_state.is_enabled) {
-        cxl_fmws_link_targets(&pcms->cxl_devices_state, &error_fatal);
+        cxl_fmws_link_targets(&error_fatal);
     }
 
     /* set the number of CPUs */
@@ -718,20 +718,28 @@ static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
     return cxl_base;
 }
 
+static int cxl_get_fmw_end(Object *obj, void *opaque)
+{
+    struct CXLFixedWindow *fw;
+    uint64_t *start = opaque;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    fw = CXL_FMW(obj);
+
+    *start += fw->size;
+
+    return 0;
+}
+
 static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
 {
     uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
 
-    if (pcms->cxl_devices_state.fixed_windows) {
-        GList *it;
-
-        start = ROUND_UP(start, 256 * MiB);
-        for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
-            CXLFixedWindow *fw = it->data;
-            start += fw->size;
-        }
-    }
-
+    /* Ordering doesn't matter so no need to build a sorted list */
+    object_child_foreach_recursive(object_get_root(), cxl_get_fmw_end,
+                                   &start);
     return start;
 }
 
@@ -933,23 +941,9 @@ void pc_memory_init(PCMachineState *pcms,
         cxl_base = pc_get_cxl_range_start(pcms);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
-        cxl_resv_end = cxl_base + cxl_size;
-        if (pcms->cxl_devices_state.fixed_windows) {
-            hwaddr cxl_fmw_base;
-            GList *it;
-
-            cxl_fmw_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
-            for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
-                CXLFixedWindow *fw = it->data;
-
-                fw->base = cxl_fmw_base;
-                memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
-                                      "cxl-fixed-memory-region", fw->size);
-                memory_region_add_subregion(system_memory, fw->base, &fw->mr);
-                cxl_fmw_base += fw->size;
-                cxl_resv_end = cxl_fmw_base;
-            }
-        }
+        cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
+        cxl_resv_end = cxl_fmws_set_memmap(cxl_base, maxphysaddr);
+        cxl_fmws_update_mmio();
     }
 
     /* Initialize PC system firmware */
-- 
2.43.0


