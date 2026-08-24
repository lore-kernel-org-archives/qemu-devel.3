Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D7BC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNEQ-0008NJ-Ef; Mon, 24 Aug 2026 01:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wyNEF-0008KS-Mz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:28:16 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wyNED-0006eT-6A
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:28:15 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38e347638adso2716366a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787549292; x=1788154092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Ctwq1zcty+C8QKKWz8B/yZl3m/lkcBBHrDFtLloLd8=;
 b=iLwUa983zSej84lxJtabRj8YMc9Mx0oMxdzwMCVS4AoQLv92Bq6SHjuzTTrBN987ty
 9eTP8J7eZvxMJYnYJNH2pf1rIUDoaqfviTxDgpECeugrl9FA+pLPSrxJl53ug9x+UiYz
 NO4c7g6QkduNGY0TTGF5abXZ3DeDf0j3o1Zb4RWOn6gK5hLQ0/2V+1IitrNGRO+o3hGb
 O9fBG06mChuHBalzj97uwvQ+NU34oRV4tdJwT7QUAtl1t/wg2zEmGGxd/WXonpdMyaVl
 fvDBo+liLqPn3pfFeZ4K99X9Gn+cMmR0sdjOggeHEHozkJgKmGWUa+uahgNn+vRfnJTX
 W2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787549292; x=1788154092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Ctwq1zcty+C8QKKWz8B/yZl3m/lkcBBHrDFtLloLd8=;
 b=CdniYeuQAWPkD0Un4pL9l4PbRxyz3Nv9l1qQ9ynlBvhyRCS6/pHXmFIxAijEncnqs9
 0+ek74m+ZeB4SNlvaaO2qUIPAx+agRWFNERl01SP047srANGrcMRYvFwDWTZAloYeWVu
 3izt6YddKCoJKxYj4BsKHCFV/jLGISn+VWefMfOgchLjnPgfvvtC8/CsQtjlgQuHo1uX
 g8esXjET8K8gEBIaJzme6geH9s5/Gsjz3ovQSGY6Oue/O81Ggv5zpqeYIF5YGjvqG8Ve
 gfJPH/mQnyNueoW06Pp4gtvnC/JW5qIY4LlNzFFOeyDL8JP2cV2nzmI976ZGXuTKPIMp
 OPAA==
X-Gm-Message-State: AFuF++lL5ip7y3So2gwh/0mX8yMeLAY6S2PTI+pK7l9I8w2n9tLD00sc
 P5G9HxMTVvhmbrftMkBbmRBuH7bVSWf397zvTnse3+i906DE80h4utUVBKRG7A==
X-Gm-Gg: AR+sD11U71xEm9aMTWbz2YzblyE0oqDUAaGlsnFv6W69eNnne3TBSdzHILl1yOQtqBI
 i/lEagQ/7sVzkxZ9lZyP/WH6AnDeNH6XXafklYBeqEHDkaUZy73LLoFbDRoK7tE+ISbtkhnpyoG
 92EjzZPxd0r+OsMpgR/1Y1yRgjrvB3B7IR16pYFi5l956TuonwXMFSKU1n9yhY3I7GfrJM/iu5S
 Xt7v0dg1EpFtQXfrN5nVXh4pybu5jtpYK/HqOPvZ8UxzXU6O9AzUan07oveX3ikWW/I8O1tEiw1
 +ffbbpJmJylim7jlhN5CNcRNP10aVuU4SjNs2m7VBtcF662KdE5ICrjC1nt6o0JE/4LF2HeCfvS
 pMIoYo9ZeaCRl5sjBsTRttLEz8badGI6af4vDfzI+YIiCTN8dhDepV+Hq3D70ZjgjNBWE6J0c83
 wHH2Y1MbV3Px+7hI9OTHvjACbtQS5HtqHpeJ1e/8IaRfO6bE5YZpXMQfX//xX8itzWnV8EEbIJg
 u81
X-Received: by 2002:a17:90b:5112:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-395dee8a5c5mr30859924a91.4.1787549291496; 
 Sun, 23 Aug 2026 22:28:11 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e494f9fdsm8557346a91.3.2026.08.23.22.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:28:11 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, mikail.sadic@ibm.com,
 clg@kaod.org, Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PULL 1/2] hw/ufs: Separate the controller core from the PCI frontend
Date: Mon, 24 Aug 2026 14:27:55 +0900
Message-ID: <42feb94b790523f83c1d39141c59face0e327211.1787548791.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787548791.git.jeuk20.kim@samsung.com>
References: <cover.1787548791.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UfsHc is currently also the PCI device instance, tying common code to
PCI-specific DMA and IRQ interfaces and preventing reuse by non-PCI
frontends.

Make UfsHc transport-independent and embed it in UfsPciState. Move the
PCI-specific handling to ufs-pci.c, pass the owning DeviceState and DMA
AddressSpace to the core, and record the core explicitly in UfsBus.

Split the common implementation into CONFIG_UFS, selected by
CONFIG_UFS_PCI. The user-visible "ufs" device and its properties remain
unchanged. No functional change is intended.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/Kconfig      |   5 ++
 hw/ufs/lu.c         |   2 +-
 hw/ufs/meson.build  |   3 +-
 hw/ufs/trace-events |   4 +-
 hw/ufs/ufs-pci.c    | 112 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.c        | 109 +++++++++---------------------------------
 hw/ufs/ufs.h        |  14 ++++--
 7 files changed, 153 insertions(+), 96 deletions(-)
 create mode 100644 hw/ufs/ufs-pci.c

diff --git a/hw/ufs/Kconfig b/hw/ufs/Kconfig
index b7b3392e85..47e28a30ea 100644
--- a/hw/ufs/Kconfig
+++ b/hw/ufs/Kconfig
@@ -1,4 +1,9 @@
+config UFS
+    bool
+    select SCSI
+
 config UFS_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select UFS
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 13f4a90145..eeca865eb5 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -497,7 +497,7 @@ static void ufs_lu_realize(DeviceState *dev, Error **errp)
 {
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
     BusState *s = qdev_get_parent_bus(dev);
-    UfsHc *u = UFS(s->parent);
+    UfsHc *u = UFS_BUS(s)->hc;
     BlockBackend *blk = lu->conf.blk;
 
     if (!ufs_lu_check_constraints(lu, errp)) {
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
index 6e68328b93..880fc52c05 100644
--- a/hw/ufs/meson.build
+++ b/hw/ufs/meson.build
@@ -1 +1,2 @@
-system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs.c', 'lu.c'))
+system_ss.add(when: 'CONFIG_UFS', if_true: files('ufs.c', 'lu.c'))
+system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs-pci.c'))
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 662d9afee3..0cd3ba9b02 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -1,6 +1,6 @@
 # ufs.c
-ufs_irq_raise(void) "INTx"
-ufs_irq_lower(void) "INTx"
+ufs_irq_raise(void) "IRQ"
+ufs_irq_lower(void) "IRQ"
 ufs_mmio_read(uint64_t addr, uint64_t data, unsigned size) "addr 0x%"PRIx64" data 0x%"PRIx64" size %d"
 ufs_mmio_write(uint64_t addr, uint64_t data, unsigned size) "addr 0x%"PRIx64" data 0x%"PRIx64" size %d"
 ufs_process_db(uint32_t slot) "UTRLDBR slot %"PRIu32""
diff --git a/hw/ufs/ufs-pci.c b/hw/ufs/ufs-pci.c
new file mode 100644
index 0000000000..8abd7d98e3
--- /dev/null
+++ b/hw/ufs/ufs-pci.c
@@ -0,0 +1,112 @@
+/*
+ * QEMU Universal Flash Storage (UFS) PCI Controller
+ *
+ * Copyright (c) 2023 Samsung Electronics Co., Ltd. All rights reserved.
+ *
+ * Written by Jeuk Kim <jeuk20.kim@samsung.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/**
+ * Usage
+ * -----
+ *
+ * Add options:
+ *      -drive file=<file>,if=none,id=<drive_id>
+ *      -device ufs,serial=<serial>,id=<bus_name>, \
+ *              nutrs=<N[optional]>,nutmrs=<N[optional]>
+ *      -device ufs-lu,drive=<drive_id>,bus=<bus_name>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_device.h"
+#include "migration/vmstate.h"
+#include "ufs.h"
+
+#define TYPE_UFS_PCI "ufs"
+OBJECT_DECLARE_SIMPLE_TYPE(UfsPciState, UFS_PCI)
+
+struct UfsPciState {
+    PCIDevice parent_obj;
+    UfsHc ufs;
+};
+
+static void ufs_pci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    UfsPciState *s = UFS_PCI(pci_dev);
+    UfsHc *u = &s->ufs;
+    uint8_t *pci_conf = pci_dev->config;
+
+    pci_conf[PCI_INTERRUPT_PIN] = 1;
+    pci_config_set_prog_interface(pci_conf, 0x1);
+    u->irq = pci_allocate_irq(pci_dev);
+    if (!ufs_realize(u, DEVICE(pci_dev), pci_get_address_space(pci_dev),
+                     errp)) {
+        qemu_free_irq(u->irq);
+        u->irq = NULL;
+        return;
+    }
+
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &u->iomem);
+}
+
+static void ufs_pci_exit(PCIDevice *pci_dev)
+{
+    UfsPciState *s = UFS_PCI(pci_dev);
+
+    ufs_unrealize(&s->ufs);
+    qemu_free_irq(s->ufs.irq);
+}
+
+static const Property ufs_pci_props[] = {
+    DEFINE_PROP_STRING("serial", UfsPciState, ufs.params.serial),
+    DEFINE_PROP_UINT8("nutrs", UfsPciState, ufs.params.nutrs, 32),
+    DEFINE_PROP_UINT8("nutmrs", UfsPciState, ufs.params.nutmrs, 8),
+    DEFINE_PROP_BOOL("mcq", UfsPciState, ufs.params.mcq, false),
+    DEFINE_PROP_UINT8("mcq-maxq", UfsPciState, ufs.params.mcq_maxq, 2),
+    DEFINE_PROP_UINT32("wb-max-size", UfsPciState, ufs.params.wb_max_size,
+                       0x400),
+    DEFINE_PROP_UINT32("wb-min-size", UfsPciState, ufs.params.wb_min_size,
+                       0x100),
+};
+
+static const VMStateDescription ufs_pci_vmstate = {
+    .name = "ufs",
+    .unmigratable = 1,
+};
+
+static void ufs_pci_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->realize = ufs_pci_realize;
+    pc->exit = ufs_pci_exit;
+    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
+    pc->device_id = PCI_DEVICE_ID_REDHAT_UFS;
+    pc->class_id = PCI_CLASS_STORAGE_UFS;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc = "Universal Flash Storage";
+    device_class_set_props(dc, ufs_pci_props);
+    dc->vmsd = &ufs_pci_vmstate;
+}
+
+static const TypeInfo ufs_pci_info = {
+    .name = TYPE_UFS_PCI,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = ufs_pci_class_init,
+    .instance_size = sizeof(UfsPciState),
+    .interfaces = (const InterfaceInfo[]){ { INTERFACE_PCIE_DEVICE }, {} },
+};
+
+static void ufs_pci_register_types(void)
+{
+    type_register_static(&ufs_pci_info);
+}
+
+type_init(ufs_pci_register_types)
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 464fd465b3..160a4ac4f3 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -11,19 +11,10 @@
 /**
  * Reference Specs: https://www.jedec.org/, 4.1
  *
- * Usage
- * -----
- *
- * Add options:
- *      -drive file=<file>,if=none,id=<drive_id>
- *      -device ufs,serial=<serial>,id=<bus_name>, \
- *              nutrs=<N[optional]>,nutmrs=<N[optional]>
- *      -device ufs-lu,drive=<drive_id>,bus=<bus_name>
  */
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "migration/vmstate.h"
 #include "scsi/constants.h"
 #include "hw/core/irq.h"
 #include "trace.h"
@@ -102,7 +93,7 @@ static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
         return MEMTX_DECODE_ERROR;
     }
 
-    return pci_dma_read(PCI_DEVICE(u), addr, buf, size);
+    return dma_memory_read(u->dma_as, addr, buf, size, MEMTXATTRS_UNSPECIFIED);
 }
 
 static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
@@ -117,7 +108,7 @@ static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
         return MEMTX_DECODE_ERROR;
     }
 
-    return pci_dma_write(PCI_DEVICE(u), addr, buf, size);
+    return dma_memory_write(u->dma_as, addr, buf, size, MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline hwaddr ufs_get_utrd_addr(UfsHc *u, uint32_t slot)
@@ -222,7 +213,7 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
     }
 
     req->sg = g_malloc0(sizeof(QEMUSGList));
-    pci_dma_sglist_init(req->sg, PCI_DEVICE(u), prdt_len);
+    qemu_sglist_init(req->sg, u->dev, prdt_len, u->dma_as);
     req->data_len = 0;
 
     for (uint16_t i = 0; i < prdt_len; ++i) {
@@ -317,14 +308,12 @@ static MemTxResult ufs_dma_write_upiu(UfsRequest *req)
 
 static void ufs_irq_check(UfsHc *u)
 {
-    PCIDevice *pci = PCI_DEVICE(u);
-
     if ((u->reg.is & UFS_INTR_MASK) & u->reg.ie) {
         trace_ufs_irq_raise();
-        pci_irq_assert(pci);
+        qemu_irq_raise(u->irq);
     } else {
         trace_ufs_irq_lower();
-        pci_irq_deassert(pci);
+        qemu_irq_lower(u->irq);
     }
 }
 
@@ -596,7 +585,7 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
     sq->size = qsize;
 
     sq->bh = qemu_bh_new_guarded(ufs_mcq_process_sq, sq,
-                                 &DEVICE(u)->mem_reentrancy_guard);
+                                 &u->dev->mem_reentrancy_guard);
     sq->req = g_new0(UfsRequest, sq->size);
     QTAILQ_INIT(&sq->req_list);
     for (int i = 0; i < sq->size; i++) {
@@ -690,7 +679,7 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
     cq->size = qsize;
 
     cq->bh = qemu_bh_new_guarded(ufs_mcq_process_cq, cq,
-                                 &DEVICE(u)->mem_reentrancy_guard);
+                                 &u->dev->mem_reentrancy_guard);
     QTAILQ_INIT(&cq->req_list);
 
     u->cq[qid] = cq;
@@ -2488,19 +2477,6 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
     return true;
 }
 
-static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
-{
-    uint8_t *pci_conf = pci_dev->config;
-
-    pci_conf[PCI_INTERRUPT_PIN] = 1;
-    pci_config_set_prog_interface(pci_conf, 0x1);
-
-    memory_region_init_io(&u->iomem, OBJECT(u), &ufs_mmio_ops, u, "ufs",
-                          u->reg_size);
-    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &u->iomem);
-    u->irq = pci_allocate_irq(pci_dev);
-}
-
 static void ufs_init_state(UfsHc *u)
 {
     u->req_list = g_new0(UfsRequest, u->params.nutrs);
@@ -2512,10 +2488,10 @@ static void ufs_init_state(UfsHc *u)
         u->req_list[i].state = UFS_REQUEST_IDLE;
     }
 
-    u->doorbell_bh = qemu_bh_new_guarded(ufs_process_req, u,
-                                         &DEVICE(u)->mem_reentrancy_guard);
-    u->complete_bh = qemu_bh_new_guarded(ufs_sendback_req, u,
-                                         &DEVICE(u)->mem_reentrancy_guard);
+    u->doorbell_bh =
+        qemu_bh_new_guarded(ufs_process_req, u, &u->dev->mem_reentrancy_guard);
+    u->complete_bh =
+        qemu_bh_new_guarded(ufs_sendback_req, u, &u->dev->mem_reentrancy_guard);
 
     if (u->params.mcq) {
         memset(u->sq, 0, sizeof(u->sq));
@@ -2689,35 +2665,35 @@ static void ufs_init_hc(UfsHc *u)
     timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
-static void ufs_realize(PCIDevice *pci_dev, Error **errp)
+bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as, Error **errp)
 {
-    UfsHc *u = UFS(pci_dev);
+    u->dev = dev;
+    u->dma_as = dma_as;
 
     if (!ufs_check_constraints(u, errp)) {
-        return;
+        return false;
     }
 
-    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, &pci_dev->qdev,
-              u->parent_obj.qdev.id);
+    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, dev, dev->id);
+    u->bus.hc = u;
 
     ufs_init_state(u);
     ufs_init_hc(u);
-    ufs_init_pci(u, pci_dev);
+    memory_region_init_io(&u->iomem, OBJECT(dev), &ufs_mmio_ops, u, "ufs",
+                          u->reg_size);
 
     ufs_init_wlu(&u->report_wlu, UFS_UPIU_REPORT_LUNS_WLUN);
     ufs_init_wlu(&u->dev_wlu, UFS_UPIU_UFS_DEVICE_WLUN);
     ufs_init_wlu(&u->boot_wlu, UFS_UPIU_BOOT_WLUN);
     ufs_init_wlu(&u->rpmb_wlu, UFS_UPIU_RPMB_WLUN);
+
+    return true;
 }
 
-static void ufs_exit(PCIDevice *pci_dev)
+void ufs_unrealize(UfsHc *u)
 {
-    UfsHc *u = UFS(pci_dev);
-
     timer_del(&u->idle_timer);
 
-    qemu_free_irq(u->irq);
-
     qemu_bh_delete(u->doorbell_bh);
     qemu_bh_delete(u->complete_bh);
 
@@ -2740,38 +2716,6 @@ static void ufs_exit(PCIDevice *pci_dev)
     }
 }
 
-static const Property ufs_props[] = {
-    DEFINE_PROP_STRING("serial", UfsHc, params.serial),
-    DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
-    DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
-    DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
-    DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 2),
-    DEFINE_PROP_UINT32("wb-max-size", UfsHc, params.wb_max_size, 0x400),
-    DEFINE_PROP_UINT32("wb-min-size", UfsHc, params.wb_min_size, 0x100),
-};
-
-static const VMStateDescription ufs_vmstate = {
-    .name = "ufs",
-    .unmigratable = 1,
-};
-
-static void ufs_class_init(ObjectClass *oc, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
-
-    pc->realize = ufs_realize;
-    pc->exit = ufs_exit;
-    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
-    pc->device_id = PCI_DEVICE_ID_REDHAT_UFS;
-    pc->class_id = PCI_CLASS_STORAGE_UFS;
-
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->desc = "Universal Flash Storage";
-    device_class_set_props(dc, ufs_props);
-    dc->vmsd = &ufs_vmstate;
-}
-
 static bool ufs_bus_check_address(BusState *qbus, DeviceState *qdev,
                                   Error **errp)
 {
@@ -2798,14 +2742,6 @@ static void ufs_bus_class_init(ObjectClass *class, const void *data)
     bc->check_address = ufs_bus_check_address;
 }
 
-static const TypeInfo ufs_info = {
-    .name = TYPE_UFS,
-    .parent = TYPE_PCI_DEVICE,
-    .class_init = ufs_class_init,
-    .instance_size = sizeof(UfsHc),
-    .interfaces = (const InterfaceInfo[]){ { INTERFACE_PCIE_DEVICE }, {} },
-};
-
 static const TypeInfo ufs_bus_info = {
     .name = TYPE_UFS_BUS,
     .parent = TYPE_BUS,
@@ -2816,7 +2752,6 @@ static const TypeInfo ufs_bus_info = {
 
 static void ufs_register_types(void)
 {
-    type_register_static(&ufs_info);
     type_register_static(&ufs_bus_info);
 }
 
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index feb47f460d..aa8361d93d 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -11,9 +11,11 @@
 #ifndef HW_UFS_UFS_H
 #define HW_UFS_UFS_H
 
-#include "hw/pci/pci_device.h"
+#include "hw/core/qdev.h"
 #include "hw/scsi/scsi.h"
 #include "block/ufs.h"
+#include "scsi/constants.h"
+#include "system/dma.h"
 
 #define UFS_MAX_LUS 32
 #define UFS_MAX_MCQ_QNUM 32
@@ -27,6 +29,7 @@ typedef struct UfsBusClass {
 
 typedef struct UfsBus {
     BusState parent_bus;
+    struct UfsHc *hc;
 } UfsBus;
 
 #define TYPE_UFS_BUS "ufs-bus"
@@ -141,7 +144,8 @@ typedef struct UfsWb {
 } UfsWb;
 
 typedef struct UfsHc {
-    PCIDevice parent_obj;
+    DeviceState *dev;
+    AddressSpace *dma_as;
     UfsBus bus;
     MemoryRegion iomem;
     UfsReg reg;
@@ -268,9 +272,6 @@ static inline bool ufs_is_write_req(UfsRequest *req)
     return (cmd == WRITE_6) || (cmd == WRITE_10) || (cmd == WRITE_16);
 }
 
-#define TYPE_UFS "ufs"
-#define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
-
 #define TYPE_UFS_LU "ufs-lu"
 #define UFSLU(obj) OBJECT_CHECK(UfsLu, (obj), TYPE_UFS_LU)
 
@@ -302,4 +303,7 @@ void ufs_build_query_response(UfsRequest *req);
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
 void ufs_wb_update_avail_buffer(UfsHc *u);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
+bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
+                 Error **errp);
+void ufs_unrealize(UfsHc *u);
 #endif /* HW_UFS_UFS_H */
-- 
2.43.0


