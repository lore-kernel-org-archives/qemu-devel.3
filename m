Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AA3E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 07:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNoiH-0007nt-SO; Wed, 18 Dec 2024 02:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNoi9-0007m9-G0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:43:15 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNoi3-0006kZ-VZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:43:12 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-728e729562fso5308943b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 23:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734507785; x=1735112585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08v+xDHjDPrZZfAoWPfyiDvPE6FENcKOOzunpUkbwIo=;
 b=Z9u26s6FQbF10aK1G4MiOHA4B7H9C/WIVNxw4iEf8DzDUMeZx3X8dR5khpCJamv3Bg
 w59huRYCjs+Ovfsxu8g7eQc8yTqgA8GDiT0ywdbdi5o8BOwLxnH/C1xDnev+0ywayrFT
 uf2sH5s8fvyat3OvTXabcG6rY6rZlCQaYshjlRIf7FpExPtNElbaQ85zZY7fJP7HdzkV
 1lJ+KjX3DOk6F9QbgD6tqqCLcCHZEQWyD1P1VMFUhk23kGLVTd8idDWgxVJIAgnKUV5R
 nbTuD5ShVDMRSB9EKNEhWrbWymr/RFGsSJykx+tDJSRy7EYbdM8LlTiPs5Vls5jKZ3re
 fEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734507785; x=1735112585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08v+xDHjDPrZZfAoWPfyiDvPE6FENcKOOzunpUkbwIo=;
 b=uYkIs7uT122ZImRQ7hcTeiGktlAspa0AL7TuEIwAZCXqgDl6V3IlHiqLQsZ0J8xccz
 Hf3B2NHbCpgJKkCMuUiFfXUhPPLc+fO3OLDnx8gBEAN1py3PjVlIEEy6cqzRScNVBtvq
 /iZxE35+r2D+nuM8ayFL+Va6jfGATC+wvad3oNkR91UrXkKttVqVDEILoeHhh3zK9uOF
 LLmFwQ9FSfkrafZI9OIBLlXouZW878ZDvFlza/Qhup+tcbnSsjI0F+jyB1ATU7dPtvGQ
 cvPj74ku7CGUmQxHqgjXpgc2GbQcNq8p9s9raw4DfsEtqNhWLkkwLEnD4uXKr+EPIRzR
 QfYg==
X-Gm-Message-State: AOJu0YxTGKrqoNaypTSDR+bPEo1WHAhsUIuLOC1R8h1bZARNLJm3T3rF
 fo1yLuY2ws0dNH6IyQhHDtbl3RJQGSMozy2v/ljsyqD9yaL2zQw1Hs7IOA==
X-Gm-Gg: ASbGnctUorV+45VsGxy0wLdkReBWMQ3+f3TAQBhYvmCt5duzVbHrpCWiND5tGWmaG/K
 4NWZ+6ozOpPHfXPavP+kaafinHyN7ue9BGNp+9O+Kr0ur0SNezclbYfPLOZy8fn2NfjZzkqeLMx
 JWSNOaoJ07Qyci7cmnVoSCpRIabOOVFlgrl8LbDuCW8tL3+eFaEqjyFtGS7YDrKvCZRSI5MiP//
 nSilTCvjSGzUT4qUwISTGehcp63e1lUjvoDDQbyK3BxL6KoVJQMcM6QHsDR8hXOyOkB7qZhrJQ8
 fvSvCmiL9A==
X-Google-Smtp-Source: AGHT+IGVg8Gc8pHg52oXwWAukS8IUHRQP0TWGKsu1WZE4Mgwv71gynqBFA6vuUgUdn69Xj+xvXXlgA==
X-Received: by 2002:a05:6a21:1011:b0:1e1:a671:7122 with SMTP id
 adf61e73a8af0-1e5b4603989mr3396529637.2.1734507785053; 
 Tue, 17 Dec 2024 23:43:05 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918af0caesm7900933b3a.86.2024.12.17.23.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:43:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/5] qtest/e1000e|igb: Fix msix to re-trigger interrupts
Date: Wed, 18 Dec 2024 17:42:31 +1000
Message-ID: <20241218074232.1784427-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218074232.1784427-1-npiggin@gmail.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
for it, as it is masked so the irq doesn't get sent. Failing to clear
the pending interrupt means all subsequent waits for that interrupt
after the first do not actually wait for an interrupt genreated by the
device.

This affects the multiple_transfers tests, they never actually verify
more than one interrupt is generated. So for those tests, enable the
msix vectors for the queue interrupts so they are delivered and the
pending bit is cleared.

Add assertions to ensure the masked pending tests are not used to test
an interrupt multiple times.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/e1000e.h |   8 +++
 tests/qtest/e1000e-test.c   |   2 +
 tests/qtest/igb-test.c      |   2 +
 tests/qtest/libqos/e1000e.c | 113 +++++++++++++++++++++++++++++++++++-
 4 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
index 30643c80949..6cc1a9732b1 100644
--- a/tests/qtest/libqos/e1000e.h
+++ b/tests/qtest/libqos/e1000e.h
@@ -25,6 +25,9 @@
 #define E1000E_RX0_MSG_ID           (0)
 #define E1000E_TX0_MSG_ID           (1)
 
+#define E1000E_RX0_MSIX_DATA        (0x12345678)
+#define E1000E_TX0_MSIX_DATA        (0xabcdef00)
+
 #define E1000E_ADDRESS { 0x52, 0x54, 0x00, 0x12, 0x34, 0x56 }
 
 typedef struct QE1000E QE1000E;
@@ -40,6 +43,10 @@ struct QE1000E_PCI {
     QPCIDevice pci_dev;
     QPCIBar mac_regs;
     QE1000E e1000e;
+    uint64_t msix_rx0_addr;
+    uint64_t msix_tx0_addr;
+    bool msix_found_rx0_pending;
+    bool msix_found_tx0_pending;
 };
 
 static inline void e1000e_macreg_write(QE1000E *d, uint32_t reg, uint32_t val)
@@ -57,5 +64,6 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d, uint32_t reg)
 void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
 void e1000e_tx_ring_push(QE1000E *d, void *descr);
 void e1000e_rx_ring_push(QE1000E *d, void *descr);
+void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E *d, QGuestAllocator *alloc);
 
 #endif
diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index a69759da70e..4921a141ffe 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -185,6 +185,8 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
         return;
     }
 
+    /* Triggering msix interrupts multiple times so must enable vectors */
+    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
     for (i = 0; i < iterations; i++) {
         e1000e_send_verify(d, data, alloc);
         e1000e_receive_verify(d, data, alloc);
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 2f22c4fb208..06082cbe7ff 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -188,6 +188,8 @@ static void test_igb_multiple_transfers(void *obj, void *data,
         return;
     }
 
+    /* Triggering msix interrupts multiple times so must enable vectors */
+    e1000e_pci_msix_enable_rxtxq_vectors(d, alloc);
     for (i = 0; i < iterations; i++) {
         igb_send_verify(d, data, alloc);
         igb_receive_verify(d, data, alloc);
diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
index 925654c7fd4..7b7e811bce7 100644
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
@@ -77,16 +78,77 @@ static void e1000e_foreach_callback(QPCIDevice *dev, int devfn, void *data)
     g_free(dev);
 }
 
+static bool e1000e_test_msix_irq(QE1000E *d, uint16_t msg_id,
+                                 uint64_t guest_msix_addr,
+                                 uint32_t msix_data)
+{
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
+    QPCIDevice *pci_dev = &d_pci->pci_dev;
+
+    if (msg_id == E1000E_RX0_MSG_ID) {
+        g_assert(!d_pci->msix_found_rx0_pending);
+    } else if (msg_id == E1000E_TX0_MSG_ID) {
+        g_assert(!d_pci->msix_found_tx0_pending);
+    } else {
+        /* Must enable MSI-X vector to test multiple messages */
+        g_assert_not_reached();
+    }
+
+    if (pci_dev->msix_enabled) {
+        if (qpci_msix_masked(pci_dev, msg_id)) {
+            /* No ISR checking should be done if masked, but read anyway */
+            bool p = qpci_msix_pending(pci_dev, msg_id);
+            if (p) {
+                if (msg_id == E1000E_RX0_MSG_ID) {
+                    d_pci->msix_found_rx0_pending = true;
+                } else if (msg_id == E1000E_TX0_MSG_ID) {
+                    d_pci->msix_found_tx0_pending = true;
+                } else {
+                    g_assert_not_reached();
+                }
+            }
+            return p;
+        } else {
+            uint32_t data = qtest_readl(pci_dev->bus->qts, guest_msix_addr);
+            if (data == msix_data) {
+                qtest_writel(pci_dev->bus->qts, guest_msix_addr, 0);
+                return true;
+            } else if (data == 0) {
+                return false;
+            } else {
+                g_assert_not_reached();
+            }
+        }
+    } else {
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
+    uint64_t guest_msix_addr;
+    uint32_t msix_data;
+
+    assert(pci_dev->msix_enabled);
+
+    if (msg_id == E1000E_RX0_MSG_ID) {
+        guest_msix_addr = d_pci->msix_rx0_addr;
+        msix_data = E1000E_RX0_MSIX_DATA;
+    } else if (msg_id == E1000E_TX0_MSG_ID) {
+        guest_msix_addr = d_pci->msix_tx0_addr;
+        msix_data = E1000E_TX0_MSIX_DATA;
+    } else {
+        g_assert_not_reached();
+    }
 
     do {
-        if (qpci_msix_pending(&d_pci->pci_dev, msg_id)) {
+        if (e1000e_test_msix_irq(d, msg_id, guest_msix_addr, msix_data)) {
             return;
         }
-        qtest_clock_step(d_pci->pci_dev.bus->qts, 10000);
+        qtest_clock_step(pci_dev->bus->qts, 10000);
     } while (g_get_monotonic_time() < end_time);
 
     g_error("Timeout expired");
@@ -99,6 +161,51 @@ static void e1000e_pci_destructor(QOSGraphObject *obj)
     qpci_msix_disable(&epci->pci_dev);
 }
 
+static void e1000e_pci_msix_enable_vector(QE1000E *d, uint16_t msg_id,
+                                          uint64_t guest_msix_addr,
+                                          uint32_t msix_data)
+{
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
+    QPCIDevice *pci_dev = &d_pci->pci_dev;
+    uint32_t control;
+    uint64_t off;
+
+    g_assert_cmpint(msg_id , >=, 0);
+    g_assert_cmpint(msg_id , <, qpci_msix_table_size(pci_dev));
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
+void e1000e_pci_msix_enable_rxtxq_vectors(QE1000E *d, QGuestAllocator *alloc)
+{
+    QE1000E_PCI *d_pci = container_of(d, QE1000E_PCI, e1000e);
+    QPCIDevice *pci_dev = &d_pci->pci_dev;
+
+    g_assert(pci_dev->msix_enabled);
+
+    d_pci->msix_rx0_addr = guest_alloc(alloc, 4);
+    d_pci->msix_tx0_addr = guest_alloc(alloc, 4);
+
+    e1000e_pci_msix_enable_vector(d, E1000E_RX0_MSG_ID,
+                                  d_pci->msix_rx0_addr, E1000E_RX0_MSIX_DATA);
+    e1000e_pci_msix_enable_vector(d, E1000E_TX0_MSG_ID,
+                                  d_pci->msix_tx0_addr, E1000E_TX0_MSIX_DATA);
+}
+
 static void e1000e_pci_start_hw(QOSGraphObject *obj)
 {
     QE1000E_PCI *d = (QE1000E_PCI *) obj;
-- 
2.45.2


