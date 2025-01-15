Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B70DC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4u2-0004PP-Kq; Wed, 15 Jan 2025 10:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4u0-0004IR-03; Wed, 15 Jan 2025 10:01:52 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4tx-0002wI-SN; Wed, 15 Jan 2025 10:01:51 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21634338cfdso122205865ad.2; 
 Wed, 15 Jan 2025 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736953307; x=1737558107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCAzdtRpgOa7ExFBXaLuO4nmF6Dq3KEzUWWjfN/UCuo=;
 b=F9S3IhviYCzI4VvJ1Llr0l+AKcFuFdiMcrNLWfFalwTpbQ4ZiF264+fCap8Emskyhu
 3pkczWlgupLDs8g/NnMWZbV6QTZapE/SjkxBnLaej7K2ffT8Rmn+0YK/AeU22rBBdUgg
 gunzICYUvCVHuWo1PAxSzsYAmgWPfbELXRpvb5pmOkQ9iz6RUjQASiPnWBtggmbztYms
 LD62+K/neVwWMr8BZS/TV14S5tHmBaT8dkPCDeTvuGu+phy6qZf1ydhijqPQVSAHgcFv
 AeoIFm3dyXqZnAZvyEA6J5W+yoySoMd8gaDyCFPjt/LC14D/Koyxm89s3fWcillPM7hg
 fTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736953307; x=1737558107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCAzdtRpgOa7ExFBXaLuO4nmF6Dq3KEzUWWjfN/UCuo=;
 b=Rggk9ALNYCwW2H4rJz2YFD16c7FP7hxoOQqBX/c5zsbH35DuTUuYJUxRgnBol5aK/B
 aa/OqK0AzAdpM8Tf/4E1Hn7/c1LzO8ov8AIf4KlEPWqK0XWW6kmmnuV2BQSSaOoNAFH/
 Lna8hA5JBLi9jWWt7cZu5UOGLcTPTEeOL4kwuxoJ6iq+fFtvkWR9XU6Rz4xzdX4T07QQ
 Lj7AwTw2U5Fxd9tiE4TqV4htmcXF1ysdr+jyD/d7hgeozOyuiL8/RqqzjU1ofi0tw8R9
 bGNhGJtHcCgN3pKTtMHnoC9seFdgfrOJboOk2C0L20U7U6gcTu9fhh9Oh6RgtMLvmvLF
 3fqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUMjTsqZgLfplGZUIvRa5gEIMgmWOQqA69wdwpx+Dybrwtsk/6ui1FuvMZtuyC0vZfR5cWYoJpSYlM@nongnu.org
X-Gm-Message-State: AOJu0YxkpatX8XKT6K7EqLDv0PMkmCh5NmEOIAuLFT6gyi0ZnoqXMjEh
 QE/EArZVcUI5K8+64gv7w0NwtQ9fNmhcK8KtIvTifQwGx1fIV3C6RPD2DQ==
X-Gm-Gg: ASbGnctoyrY/xMQTPMvm5cVbFU9BzdHLklkIhBhC7uWXQ7rXMAIAnQWLNq7U1ICAHZY
 XBXjAVohJwpncJmvOcUwTsI77wj+h3Fx8NwwpheYsATBMbkfI8cik0VoNc+N4sghOw8ac3QqvXZ
 LNTk/nBLcd5spgFCXxN3q7ZR7XoX1rYtBXGLSo+IryuNw5dd+llAqAoznbwME0A5Ehcy/R8sRVJ
 m1ZdEHcbli5VFgDVK9g42pIyX4t6f4DZvFEvQArem+6lfoJLLgq+tqA+Th0Bg==
X-Google-Smtp-Source: AGHT+IFxxLGaXEUXpA7SwZgUM7yXX3PBualxUwgoJYTPQDsEdl/CufGqtyp7uthURbsIlHDjxd2efg==
X-Received: by 2002:a05:6a00:3c83:b0:71e:4296:2e with SMTP id
 d2e1a72fcca58-72d21f4bc9emr40833840b3a.11.1736953307190; 
 Wed, 15 Jan 2025 07:01:47 -0800 (PST)
Received: from wheely.local0.net ([118.210.104.29])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658a7esm9519592b3a.106.2025.01.15.07.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:01:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org
Subject: [PATCH v2 5/5] qtest/e1000e|igb: Fix msix to re-trigger interrupts
Date: Thu, 16 Jan 2025 01:01:11 +1000
Message-ID: <20250115150112.346497-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115150112.346497-1-npiggin@gmail.com>
References: <20250115150112.346497-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

The e1000e and igb tests don't clear the msix pending bit after waiting
for it, as it is masked so the irq doesn't get sent. This means all
subsequent waits for the interrupt does not wait or verify the interrupt
was generated, affecting the multiple_transfers tests.

To fix this, have device setup always enable and unmask the RXQ and TXQ
irq vectors, and verify interrupt was seen by checking the msix message
was seen.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/e1000e.h | 11 ++++-
 tests/qtest/libqos/e1000e.c | 87 +++++++++++++++++++++++++++++++++++--
 tests/qtest/libqos/igb.c    |  9 ++++
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
index 30643c80949..63aa8c28a39 100644
--- a/tests/qtest/libqos/e1000e.h
+++ b/tests/qtest/libqos/e1000e.h
@@ -22,8 +22,13 @@
 #include "qgraph.h"
 #include "pci.h"
 
-#define E1000E_RX0_MSG_ID           (0)
-#define E1000E_TX0_MSG_ID           (1)
+enum  {
+    E1000E_RX0_MSG_ID,
+    E1000E_TX0_MSG_ID,
+    E1000E_MSG_ID_MAX
+};
+
+#define E1000E_MSIX_DATA ((uint32_t[]) { 0x12345678, 0xabcdef00 })
 
 #define E1000E_ADDRESS { 0x52, 0x54, 0x00, 0x12, 0x34, 0x56 }
 
@@ -40,6 +45,7 @@ struct QE1000E_PCI {
     QPCIDevice pci_dev;
     QPCIBar mac_regs;
     QE1000E e1000e;
+    uint64_t msix_msg_addr[E1000E_MSG_ID_MAX];
 };
 
 static inline void e1000e_macreg_write(QE1000E *d, uint32_t reg, uint32_t val)
@@ -57,5 +63,6 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
 void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
 void e1000e_tx_ring_push(QE1000E *d, void *descr);
 void e1000e_rx_ring_push(QE1000E *d, void *descr);
+void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E_PCI *d);
 
 #endif
diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
index 925654c7fd4..49bedb5e009 100644
--- a/tests/qtest/libqos/e1000e.c
+++ b/tests/qtest/libqos/e1000e.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "hw/net/e1000_regs.h"
 #include "hw/pci/pci_ids.h"
+#include "hw/pci/pci_regs.h"
 #include "../libqtest.h"
 #include "pci-pc.h"
 #include "qemu/sockets.h"
@@ -77,16 +78,48 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
     g_free(dev);
 }
 
+static bool e1000e_test_msix_irq(QE1000E *d, uint16_t msg_id,
+                                 uint64_t guest_msix_addr,
+                                 uint32_t msix_data)
+{
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
+    QPCIDevice *pci_dev = &d_pci->pci_dev;
+    uint32_t data;
+
+    /* msix irq test must enable msix */
+    g_assert(pci_dev->msix_enabled);
+
+    /* Vector must be enabled (e.g., with enable_rxtxq_vectors) */
+    g_assert(!qpci_msix_masked(pci_dev, msg_id));
+
+    data = qtest_readl(pci_dev->bus->qts, guest_msix_addr);
+    if (data == msix_data) {
+        /* Clear msix addr ready for next interrupt */
+        qtest_writel(pci_dev->bus->qts, guest_msix_addr, 0);
+        return true;
+    } else if (data == 0) {
+        return false;
+    } else {
+        /* Must only be either 0 (no interrupt) or the msix data. */
+        g_assert_not_reached();
+    }
+}
+
 void e1000e_wait_isr(QE1000E *d, uint16_t msg_id)
 {
     QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
-    guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    QPCIDevice *pci_dev = &d_pci->pci_dev;
+    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    uint64_t guest_msix_addr = d_pci->msix_msg_addr[msg_id];
+    uint32_t msix_data = E1000E_MSIX_DATA[msg_id];
+
+    assert(pci_dev->msix_enabled);
 
     do {
-        if (qpci_msix_pending(&d_pci->pci_dev, msg_id)) {
+        if (e1000e_test_msix_irq(d, msg_id, guest_msix_addr, msix_data)) {
             return;
         }
-        qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);
+        qtest_clock_step(pci_dev->bus->qts, 10000);
     } while (g_get_monotonic_time() < end_time);
 
     g_error("Timeout expired");
@@ -99,6 +132,45 @@ static void e1000e_pci_destructor(QOSGraphObject *obj)
     qpci_msix_disable(&epci->pci_dev);
 }
 
+static void e1000e_pci_msix_enable_vector(QE1000E_PCI *d, uint16_t msg_id)
+{
+    QPCIDevice *pci_dev = &d->pci_dev;
+    uint64_t guest_msix_addr = d->msix_msg_addr[msg_id];
+    uint32_t msix_data = E1000E_MSIX_DATA[msg_id];
+    uint32_t control;
+    uint64_t off;
+
+    g_assert_cmpint(msg_id , >=, 0);
+    g_assert_cmpint(msg_id , <, qpci_msix_table_size(pci_dev));
+    g_assert_cmpint(msg_id , <, E1000E_MSG_ID_MAX);
+    g_assert(guest_msix_addr != 0);
+    g_assert(msix_data != 0);
+
+    off = pci_dev->msix_table_off + (msg_id * 16);
+
+    qpci_io_writel(pci_dev, pci_dev->msix_table_bar,
+                   off + PCI_MSIX_ENTRY_LOWER_ADDR, guest_msix_addr & ~0UL);
+    qpci_io_writel(pci_dev, pci_dev->msix_table_bar,
+                   off + PCI_MSIX_ENTRY_UPPER_ADDR,
+                   (guest_msix_addr >> 32) & ~0UL);
+    qpci_io_writel(pci_dev, pci_dev->msix_table_bar,
+                   off + PCI_MSIX_ENTRY_DATA, msix_data);
+
+    control = qpci_io_readl(pci_dev, pci_dev->msix_table_bar,
+                            off + PCI_MSIX_ENTRY_VECTOR_CTRL);
+    qpci_io_writel(pci_dev, pci_dev->msix_table_bar,
+                   off + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                   control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
+}
+
+void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E_PCI *d)
+{
+    g_assert(d->pci_dev.msix_enabled);
+
+    e1000e_pci_msix_enable_vector(d, E1000E_RX0_MSG_ID);
+    e1000e_pci_msix_enable_vector(d, E1000E_TX0_MSG_ID);
+}
+
 static void e1000e_pci_start_hw(QOSGraphObject *obj)
 {
     QE1000E_PCI *d = (QE1000E_PCI *) obj;
@@ -113,6 +185,7 @@ static void e1000e_pci_start_hw(QOSGraphObject *obj)
 
     /* Enable and configure MSI-X */
     qpci_msix_enable(&d->pci_dev);
+    e1000e_pci_msix_enable_rxtxq_vectors(d);
     e1000e_macreg_write(&d->e1000e, E1000_IVAR, E1000E_IVAR_TEST_CFG);
 
     /* Check the device status - link and speed */
@@ -196,6 +269,14 @@ static void *e1000e_pci_create(void *pci_bus, QGuestAllocator *alloc,
     d->e1000e.rx_ring = guest_alloc(alloc, E1000E_RING_LEN);
     g_assert(d->e1000e.rx_ring != 0);
 
+    /* Allocate and clear msix msg addr for TX */
+    d->msix_msg_addr[E1000E_TX0_MSG_ID] = guest_alloc(alloc, 4);
+    g_assert(d->msix_msg_addr[E1000E_TX0_MSG_ID] != 0);
+
+    /* Allocate and clear msix msg addr for RX */
+    d->msix_msg_addr[E1000E_RX0_MSG_ID] = guest_alloc(alloc, 4);
+    g_assert(d->msix_msg_addr[E1000E_RX0_MSG_ID] != 0);
+
     d->obj.get_driver = e1000e_pci_get_driver;
     d->obj.start_hw = e1000e_pci_start_hw;
     d->obj.destructor = e1000e_pci_destructor;
diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index f40c4ec4cd2..c902634b3df 100644
--- a/tests/qtest/libqos/igb.c
+++ b/tests/qtest/libqos/igb.c
@@ -75,6 +75,7 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
 
     /* Enable and configure MSI-X */
     qpci_msix_enable(&d->pci_dev);
+    e1000e_pci_msix_enable_rxtxq_vectors(d);
     e1000e_macreg_write(&d->e1000e, E1000_IVAR0, IGB_IVAR_TEST_CFG);
 
     /* Check the device link status */
@@ -161,6 +162,14 @@ static void *igb_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
     d->e1000e.rx_ring = guest_alloc(alloc, E1000E_RING_LEN);
     g_assert(d->e1000e.rx_ring != 0);
 
+    /* Allocate and clear msix msg addr for TX */
+    d->msix_msg_addr[E1000E_TX0_MSG_ID] = guest_alloc(alloc, 4);
+    g_assert(d->msix_msg_addr[E1000E_TX0_MSG_ID] != 0);
+
+    /* Allocate and clear msix msg addr for RX */
+    d->msix_msg_addr[E1000E_RX0_MSG_ID] = guest_alloc(alloc, 4);
+    g_assert(d->msix_msg_addr[E1000E_RX0_MSG_ID] != 0);
+
     d->obj.get_driver = igb_pci_get_driver;
     d->obj.start_hw = igb_pci_start_hw;
     d->obj.destructor = e1000e_pci_destructor;
-- 
2.45.2


