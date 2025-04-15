Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4E2C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bXF-0001qs-TR; Tue, 15 Apr 2025 04:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u4bWe-0008UX-UU; Tue, 15 Apr 2025 04:20:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u4bWb-0002vW-TU; Tue, 15 Apr 2025 04:20:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso5083665b3a.2; 
 Tue, 15 Apr 2025 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744705207; x=1745310007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7ag/4WQb6NQh6XH9TufK+JtdflTO6cQsVupBkUwmLw=;
 b=Yzt/ENzO8HlVFGd0a8AcfLxrGlAjiDfcjBJp/1GjYjiypqha+rB4JMcJQ1CfkyN7YT
 Gd9JO5U2dlS1hVXEZaizyTZJL4ih1YaJ5lkX3JRSlHsGXziN2/z53HCHL4ugv8J5kNfk
 KQ/ySFOKEHZHRCBACajbjg0tzwU3QDT5Y9Z6KggAdVAGtvMZJTZSyecC2Z6s4CTF8F97
 RP43zkg5O8I0ogVS8mEP+VO1ce/iBKNTWAiowti2aFLMOBVtSTp2PyEdzbq9nxSuRAWF
 kE7fFDK/VVmV8pHABZinR8OBNZ5CRxAvDc8dk43qSmWsvmSjb0+2xUNXrfppA9Wu5UIX
 EcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744705207; x=1745310007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7ag/4WQb6NQh6XH9TufK+JtdflTO6cQsVupBkUwmLw=;
 b=N5wcHBFZ5VXMNnlvuMl6/XJqQXEmQGD5x2LOEoAhkMThgK75vj4DKgOUyvrZBvE9+Y
 iCIJWi6CPbCZoOCOYThj7z2lAfGToD3BB9bUylIT17jtNt6WnFzaXYDQJFoNl2gVQUXw
 WZ5huKIvf+9v6V4OiGHvzsWCKVVexhPG+etzsXaj5Lzje83aeqkn3njEGII2HyzkinZm
 ZK9quLfn4EtBAj7/TVoyTQTyXa8OgEVz0faAtvKl6b5BNs5UPyuC4+TftsCyxQvJCUa3
 +W6UVJ6FhFLHe0374ruglfI8LM3htaI4QQtw/S9sCcLD31+2feKAFhI7Zeu/Vf+w052d
 uI3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAi6uX2VJIQSdUww7JqM5eXBEWQjnjVD2pDeFvr0UkA/17Ki32JiEWlJ5wELWvnqnXQwVfeJyJMh3s@nongnu.org,
 AJvYcCXAqFsrkUWXuz1Two8cgPDNm+fZmc6FTiNb5+mt1gDGORWHZDBCAbq+EaQ8bHzN2JuYz2OFNn6Fyhqltw==@nongnu.org
X-Gm-Message-State: AOJu0YzbOxLCapjXs2guTInGESrKG+FnM67kbYTylGp8XJ+EpKhQCO0L
 SWwPrUZ5dFY35D6TyfmnMe2J1v2KxjNCRKOZ7JFctgi57wxX8kAI+moVJA==
X-Gm-Gg: ASbGncsrj73bbKrVOb3eAJU22RvrRujHxaCTQyMHQIjIXZ1AGZr7CBaMmTrmtluB0Ks
 voVg2EfUgVmMSWY53q2h+daaw9Pc2m1g5jg5hnO834ryMHGnDN3nMclE7/uxdg2c9WiSMwDksmq
 SmuqG0DhDExupqCPdxF6eWCTIrtFNI4atjnQfdUKYsoia42JXKQveQjFNUP4VQ6/7kKaQCkuj3s
 7Z1e8DnJ1zqOa7ZVMmHH/eBigHRvs2VBuo1QHfr2eMF7HXpNbqCkevYqfOh0Ygxy/1D3XtB1QMa
 XBJcx+CnqkpxAhSPeYXigprE2M/lappz1w+XBebYx7YuLcmBvbf4gLwhjXsUIeU5gZS/snwxFh2
 5TGHf373SlYgNlJKabwPDE7nfsvpf9p4dweAyOc1I
X-Google-Smtp-Source: AGHT+IE5LEo+nnSNexSerr0Ee/6nX7LcM6PlwAULMAL6uRaDoDhY4T4YOmizMD31Ea0ornP7eAy3UQ==
X-Received: by 2002:a17:90b:4d0a:b0:305:5f55:899 with SMTP id
 98e67ed59e1d1-30823670acdmr21360564a91.11.1744705206501; 
 Tue, 15 Apr 2025 01:20:06 -0700 (PDT)
Received: from wheely.local0.net
 (ppp118-208-164-196.cbr-trn-nor-bras39.tpg.internode.on.net.
 [118.208.164.196]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df08f63bsm12543098a91.24.2025.04.15.01.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:20:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [RFC PATCH 2/2] tests/qtest: Enable spapr dma with linear iommu map
Date: Tue, 15 Apr 2025 18:19:14 +1000
Message-ID: <20250415081914.378236-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250415081914.378236-1-npiggin@gmail.com>
References: <20250415081914.378236-1-npiggin@gmail.com>
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
 tests/qtest/e1000e-test.c            | 23 +++--------------------
 tests/qtest/igb-test.c               | 21 ---------------------
 tests/qtest/libqos/generic-pcihost.c |  1 -
 tests/qtest/libqos/pci-pc.c          |  3 ---
 tests/qtest/libqos/pci-spapr.c       |  7 ++++---
 tests/qtest/libqos/pci.c             | 14 --------------
 tests/qtest/vhost-user-blk-test.c    |  6 ------
 tests/qtest/virtio-blk-test.c        | 12 ------------
 10 files changed, 15 insertions(+), 85 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 83896145235..9b0b365a0d2 100644
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
index de9738fdb74..a8d6d3eb013 100644
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
@@ -173,13 +159,10 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
 
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
 
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
+    /* Use EITR for one irq and disable it for the other, for testing */
+    e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 500);
+    e1000e_macreg_write(d, E1000_EITR + E1000E_TX0_MSG_ID * 4, 0);
 
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
index a59197b9922..3bf6a0e0127 100644
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


