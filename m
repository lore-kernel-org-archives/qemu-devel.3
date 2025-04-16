Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA568C369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 15:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54Fu-0007Fn-Ex; Wed, 16 Apr 2025 11:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54F2-0006gE-AZ; Wed, 16 Apr 2025 10:59:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54Ey-00039o-02; Wed, 16 Apr 2025 10:59:54 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736c277331eso897775b3a.1; 
 Wed, 16 Apr 2025 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744815589; x=1745420389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JL3huZLXxTALjzanwjU/xxJHfPMSswJPDxEWj9Jb8pw=;
 b=EklONd6xgWVqbYM7y/D+w+i9B4O7/ZNPxiE29YyctHEJcYj92QrN5ZQHEtC9HuOdN2
 Qs2I4zGz3saOrQ17IK07ztMHxvF0A1RX6rQNM5VO4K34se4sZZ7S6voyiCcSG1VQcYWz
 +0DIGeHRzwzhiEtapwF9lPlxi3MePj/2bmGsJ20v9dzjY2gzrHudL0RTjxvJwGmV9VUD
 u/p9DIVqfNj+8oZZAHdLnJOUPGmQkojZBjICwynUXYaiM9A8IOikQ2iJSR4x5mrZnJJ2
 V5wq1PXkM4xsS4aIVr48i/4TTPG2GZlvTZfYcUlip6WBxIsHsLxsgMImyKBxkAki7XM3
 tThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744815589; x=1745420389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JL3huZLXxTALjzanwjU/xxJHfPMSswJPDxEWj9Jb8pw=;
 b=QGEvZa2s88QEV5HhxN/gfT57SiTFbq3p06h6fQ01nnMW1+i7ZlqpHcxHhwsLHPlsNg
 ktIXRGgCYEFXs2dh1f/mV/hboz84l/Hfj/QbQOWHLI96jbp2k5QQpcehry2GP/h9LITP
 dNXP4A3vxlfjCa+c5TeEWl8An4pQWrLgT8whncxD/JiLvGAFXyDYah9ACQyj3TewXq8M
 hGT+j9W1Y2j5haVt2u8CHbMI/ilC0Lzm/794r1+SqCQosNpsTJvGyC8ppk5JFq0E0HoQ
 xYZpPRxPdYQ6LO2BBYd0s2upX80/cAhCP67dKxDX+r6GKMGimeyJgoi6RfZ+D+m13ZD5
 2Jfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfDDD/3J52V+BT2PgTX4r35FfKT1+N+E7xXbNqHZKjXlyCsMkuA0TCDHwvg+Hrg7PxpuT0BnKFcdNx@nongnu.org,
 AJvYcCXRBtOTHmahBZAlyoNrw/ad5LvLliZY64Jj0TC7ttRqRA9trQVFyKA9ThVBp0x00SJqicL5EAu6XMAjzQ==@nongnu.org
X-Gm-Message-State: AOJu0YydS77Wak3e+ATaSoS5aMZmuH1XGwxRsJcjUVOXdgWkeXYCu5AX
 8BayM7dxl78hZE7/Q29eeDHWWD8LQNgTb6A+xRffNxxNL0nBJUkNSgOOrQ==
X-Gm-Gg: ASbGnctzH6xV8eZ4VsunVCJA9PNMy00euHI90SSuL3jdwVI+P2pzEr5tO4H+Izz15fX
 V3syVghzEMKXcrrfT+C+koSNMXoQmHql31W3WyoKMJ74xhG7PlTfG+ohDKgLuZ9r0UBvcW+KSQj
 x1/exm1qgBfPqAvKiAno/uf7HWURmXt2k+pVWHD7+nUywF+9acPGeIFZaFLgeIocftRsmBzD7pc
 iWWZHCgYFGzKF63lbEZ6uOOntQVbz/iZbE90M7zPEa3d/vk8lF6111k7k3QLrUxc9ijiLTXn6DH
 dVUp5qjeq1qwarg3MQOPzHDPIFxNPaZU1mQr94Hn9Otc3Jjf6VnG
X-Google-Smtp-Source: AGHT+IGEE++RC7qEhGL8O0gwOdXz4/rfg5nmivuNx12pjqJsUKEVGB9bqG8aXgX/FoBWgbTDD6/fNw==
X-Received: by 2002:a05:6a00:3a96:b0:736:aea8:c9b7 with SMTP id
 d2e1a72fcca58-73c26d17aa0mr3101368b3a.2.1744815589266; 
 Wed, 16 Apr 2025 07:59:49 -0700 (PDT)
Received: from wheely.local0.net ([1.145.55.85])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e355sm10814506b3a.139.2025.04.16.07.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:59:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH 4/4] tests/qtest: Enable spapr dma with linear iommu map
Date: Thu, 17 Apr 2025 00:59:18 +1000
Message-ID: <20250416145918.415674-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250416145918.415674-1-npiggin@gmail.com>
References: <20250416145918.415674-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

qtests spapr dma was broken because the iommu was not set up.

spapr requires hypercalls to set up the iommu (TCE tables), but
there is no support for that or a side-channel to the iommu in
qtests at the moment, so add a quick workaround in QEMU to have
the spapr iommu provide a linear map to memory when running
qtests.

The buggy msix checks can all be removed since the tests all work
now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h             |  4 ----
 hw/ppc/spapr_iommu.c                 |  9 ++++++++-
 tests/qtest/e1000e-test.c            | 21 ---------------------
 tests/qtest/igb-test.c               | 21 ---------------------
 tests/qtest/libqos/generic-pcihost.c |  1 -
 tests/qtest/libqos/pci-pc.c          |  3 ---
 tests/qtest/libqos/pci-spapr.c       |  7 ++++---
 tests/qtest/libqos/pci.c             | 14 --------------
 tests/qtest/vhost-user-blk-test.c    |  6 ------
 tests/qtest/virtio-blk-test.c        | 12 ------------
 10 files changed, 12 insertions(+), 86 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 9f8f154c301..ef40a6917d3 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -51,7 +51,6 @@ struct QPCIBus {
     QTestState *qts;
     uint64_t pio_alloc_ptr, pio_limit;
     uint64_t mmio_alloc_ptr, mmio_limit;
-    bool has_buggy_msi; /* TRUE for spapr, FALSE for pci */
     bool not_hotpluggable; /* TRUE if devices cannot be hotplugged */
 
 };
@@ -83,9 +82,6 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
 int qpci_secondary_buses_init(QPCIBus *bus);
 
-bool qpci_has_buggy_msi(QPCIDevice *dev);
-bool qpci_check_buggy_msi(QPCIDevice *dev);
-
 void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index db3a14c1dfd..77895c597df 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/kvm.h"
+#include "system/qtest.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
@@ -125,7 +126,13 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
         .perm = IOMMU_NONE,
     };
 
-    if ((addr >> tcet->page_shift) < tcet->nb_table) {
+    if (qtest_enabled()) {
+        /* spapr qtests does not set up the IOMMU, shortcut a linear map */
+        ret.iova = addr & TARGET_PAGE_MASK;
+        ret.translated_addr = addr & TARGET_PAGE_MASK;
+        ret.addr_mask = ~TARGET_PAGE_MASK;
+        ret.perm = IOMMU_RW;
+    } else if ((addr >> tcet->page_shift) < tcet->nb_table) {
         /* Check if we are in bound */
         hwaddr page_mask = IOMMU_PAGE_MASK(tcet->page_shift);
 
diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index de9738fdb74..8300bf5a5b3 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -139,13 +139,6 @@ static void test_e1000e_tx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     e1000e_send_verify(d, data, alloc);
 }
@@ -154,13 +147,6 @@ static void test_e1000e_rx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     e1000e_receive_verify(d, data, alloc);
 }
@@ -173,13 +159,6 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
 
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     for (i = 0; i < iterations; i++) {
         e1000e_send_verify(d, data, alloc);
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 3d397ea6973..1b3b5aa6c76 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -142,13 +142,6 @@ static void test_igb_tx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     igb_send_verify(d, data, alloc);
 }
@@ -157,13 +150,6 @@ static void test_igb_rx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     igb_receive_verify(d, data, alloc);
 }
@@ -176,13 +162,6 @@ static void test_igb_multiple_transfers(void *obj, void *data,
 
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     for (i = 0; i < iterations; i++) {
         igb_send_verify(d, data, alloc);
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index 4bbeb5ff508..568897e0ecc 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -182,7 +182,6 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestState *qts,
 
     qpci->gpex_pio_base = 0x3eff0000;
     qpci->bus.not_hotpluggable = !hotpluggable;
-    qpci->bus.has_buggy_msi = false;
 
     qpci->bus.pio_readb = qpci_generic_pio_readb;
     qpci->bus.pio_readw = qpci_generic_pio_readw;
diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
index 147009f4f44..8b79d858bd5 100644
--- a/tests/qtest/libqos/pci-pc.c
+++ b/tests/qtest/libqos/pci-pc.c
@@ -124,9 +124,6 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, QGuestAllocator *alloc)
 {
     assert(qts);
 
-    /* tests can use pci-bus */
-    qpci->bus.has_buggy_msi = false;
-
     qpci->bus.pio_readb = qpci_pc_pio_readb;
     qpci->bus.pio_readw = qpci_pc_pio_readw;
     qpci->bus.pio_readl = qpci_pc_pio_readl;
diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
index 0f1023e4a73..dfa2087a599 100644
--- a/tests/qtest/libqos/pci-spapr.c
+++ b/tests/qtest/libqos/pci-spapr.c
@@ -20,6 +20,10 @@
  * PCI devices are always little-endian
  * SPAPR by default is big-endian
  * so PCI accessors need to swap data endianness
+ *
+ * The spapr iommu model has a qtest_enabled() check that short-cuts
+ * the TCE table and provides a linear map for DMA, since qtests does
+ * not have a way to make hcalls to set up the TCE table.
  */
 
 static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
@@ -155,9 +159,6 @@ void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *qts,
 {
     assert(qts);
 
-    /* tests cannot use spapr, needs to be fixed first */
-    qpci->bus.has_buggy_msi = true;
-
     qpci->alloc = alloc;
 
     qpci->bus.pio_readb = qpci_spapr_pio_readb;
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 773fd1fb6cf..2bae119bfca 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -53,20 +53,6 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
     }
 }
 
-bool qpci_has_buggy_msi(QPCIDevice *dev)
-{
-    return dev->bus->has_buggy_msi;
-}
-
-bool qpci_check_buggy_msi(QPCIDevice *dev)
-{
-    if (qpci_has_buggy_msi(dev)) {
-        g_test_skip("Skipping due to incomplete support for MSI");
-        return true;
-    }
-    return false;
-}
-
 static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
 {
     g_assert(dev);
diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index ea90d41232e..3e71fdb9d78 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -554,14 +554,8 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t desc_idx;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
index 98c906ebb4a..3a005d600c1 100644
--- a/tests/qtest/virtio-blk-test.c
+++ b/tests/qtest/virtio-blk-test.c
@@ -474,14 +474,8 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t free_head;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
@@ -584,14 +578,8 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t desc_idx;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
-- 
2.47.1


