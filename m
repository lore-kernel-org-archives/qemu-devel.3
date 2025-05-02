Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E9CC3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgiK-0001MB-29; Thu, 01 May 2025 23:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgiG-0001Lf-9B; Thu, 01 May 2025 23:05:21 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgiC-00089g-R5; Thu, 01 May 2025 23:05:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so1641171b3a.3; 
 Thu, 01 May 2025 20:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155113; x=1746759913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W77vlivYJ42VB0S6zdFNj4APmV0zHeYCYhnqX6BBAyE=;
 b=WMfdRQaeakMvJFfyWsbDryd8ZMVxXr1xAHusW1GjOd6YqE43YFVQ7lxY7YjZgqr7tB
 2RKpvFuWWhAy0Bs6GODfBiQMU8IbU4/D0xoY3hxB/1LdLUSwrKMBKZlWOnPqQhI4YKcX
 eyFMVMDYA2PBNCvEkSlz0dbEklO0CHoARjNe8YL8Pyhi/5TC9nEzqL9ioHFYcGS1Wj2j
 yPAU3PwmqxuCCW3u671/EitCLznEg15fEXHo37fFi1J8UVkR2yYcvdF+eghLh7oEbsLl
 KQvJMZ+pVQo0y/OtEaX8KMJpUbXuf1Yjb7uBsezhkKxHXj6rXsF0X+QfYhkZhGHeRMAL
 TxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155113; x=1746759913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W77vlivYJ42VB0S6zdFNj4APmV0zHeYCYhnqX6BBAyE=;
 b=igJ6Y4to8Taqb0VVVt5Zmn4aan4DjWVfnfpPqEvEA8kOMv7zuFl53eZ6WNm5rujP2m
 g54BpVgmCekngrcHcNCzBJrUN3wFH1YjwLKgUKiDBjXGlfcdn0+ggvMw4myTKvFUgwy/
 3+U9MGitNDrN6AdMNowpbz9Hmrd6/cs4Ui14jIcMj0IXU7PQRt/h326y9WHWsf4Ocxas
 XsCTv2w8IM0pfxIC0B28ou+oKU2EZXuCaXzMVirvoX6n0IACYGvuv56owIf61FGToQfo
 Ey9id7DIcKsQATA4OdXjqtjEEJmj6+NWs73BixiDgWuOAo3hzi/QTCoy7tJNl7vaF85y
 15yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPptWM8m/datVtQAWPptZC9Jf/4z+3S3RwWzNDdweuxCcoIP9xFL0jADyIpjgCz5HjRRMoUsj00mU=@nongnu.org,
 AJvYcCWPQavb3SXEIcSzT3xJ6Zk4OpQuOkMj3KhWeLzklgEttmbfoh3ki49NVkqa1kbaLkp+kZjHEtfHievl@nongnu.org
X-Gm-Message-State: AOJu0YwstvgfBFjTvkCFsC2yRzaiYSb705cQ3wknDBBSxNGAdsjd/82J
 VtbC/K7iHVPjTT6Jk9mzwFs4XpNM2FxYMvRMU81am8dB3ctaK0lvmxNuQg==
X-Gm-Gg: ASbGncuFMoQjqB0wIwh4efwIg9CuPQCqDh75C+BG/nSZ3qUlZTlXYlWXCaUzzoAIhIr
 zO73EilxUeMHkFbwc0Fx0lJIupr8Mgw4lIV7bWitgPyEwZSCpUmmoSWS/iIYY9gXr37TLDNVQx/
 SYepeXrEMjsA3hQI6P77Ms0IPY0lFDc9EDrN+fKBXxU+LpbRxUnsPpEq4QksWDnYriC/+tgboNP
 FrjB3ZPnw4wXQys18heJ2b5aCTCeNnQRfi7tL/MUwA1D2w/tcROBPvZZn2Bo5UvD//NZ1Ek6pAd
 WUOyYjCpscr+YZ6ENiwuKMCae62r6aVCzTsd7ikhIQGQ
X-Google-Smtp-Source: AGHT+IH7vM94N//YGGTTZRY6IMwqmnn4tB75npsy3PW818+r0wUdbnicD+dmvvYB+H5xSw/eUY53Aw==
X-Received: by 2002:a05:6a20:939d:b0:1f5:6e71:e45 with SMTP id
 adf61e73a8af0-20cdfee995bmr1880681637.27.1746155113434; 
 Thu, 01 May 2025 20:05:13 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 03/11] tests/qtest: Add libqos function for testing msix
 interrupt status
Date: Fri,  2 May 2025 13:04:37 +1000
Message-ID: <20250502030446.88310-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

This function is duplicated 3 times, with more potential future users.
Factor it into libqos, using qtest_memset instead of qtest_writel to
clear the message just because that looks nicer with the qtest_memread
used to read it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h               |  2 ++
 tests/qtest/libqos/pci.c               | 48 ++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-pci-modern.c | 31 +++--------------
 tests/qtest/libqos/virtio-pci.c        | 40 ++++-----------------
 4 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 83896145235..9f8f154c301 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -92,6 +92,8 @@ void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
+bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
+                              uint64_t msix_addr, uint32_t msix_data);
 uint16_t qpci_msix_table_size(QPCIDevice *dev);
 
 uint8_t qpci_config_readb(QPCIDevice *dev, uint8_t offset);
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index a59197b9922..773fd1fb6cf 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -351,6 +351,54 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     }
 }
 
+/**
+ * qpci_msix_test_interrupt - test whether msix interrupt has been raised
+ * @dev: PCI device
+ * @msix_entry: msix entry to test
+ * @msix_addr: address of msix message
+ * @msix_data: expected msix message payload
+ *
+ * This tests whether the msix source has raised an interrupt. If the msix
+ * entry is masked, it tests the pending bit array for a pending message
+ * and @msix_addr and @msix_data need not be supplied. If the entry is not
+ * masked, it tests the address for corresponding data to see if the interrupt
+ * fired.
+ *
+ * Note that this does not lower the interrupt, however it does clear the
+ * msix message address to 0 if it is found set. This must be called with
+ * the msix address memory containing either 0 or the value of data, otherwise
+ * it will assert on incorrect message.
+ */
+bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
+                              uint64_t msix_addr, uint32_t msix_data)
+{
+    uint32_t data;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(msix_entry, !=, -1);
+
+    if (qpci_msix_masked(dev, msix_entry)) {
+        /* No ISR checking should be done if masked, but read anyway */
+        return qpci_msix_pending(dev, msix_entry);
+    }
+
+    g_assert_cmpint(msix_addr, !=, 0);
+    g_assert_cmpint(msix_data, !=, 0);
+
+    /* msix payload is written in little-endian format */
+    qtest_memread(dev->bus->qts, msix_addr, &data, 4);
+    data = le32_to_cpu(data);
+    if (data == 0) {
+        return false;
+    }
+
+    /* got a message, ensure it matches expected value then clear it. */
+    g_assert_cmphex(data, ==, msix_data);
+    qtest_memset(dev->bus->qts, msix_addr, 0, 4);
+
+    return true;
+}
+
 uint16_t qpci_msix_table_size(QPCIDevice *dev)
 {
     uint8_t addr;
diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 5dae41e6d74..0d7d89bbcb1 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -126,28 +126,6 @@ static void set_status(QVirtioDevice *d, uint8_t status)
                           status);
 }
 
-static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
-                            uint32_t msix_addr, uint32_t msix_data)
-{
-    uint32_t data;
-
-    g_assert_cmpint(msix_entry, !=, -1);
-    if (qpci_msix_masked(dev->pdev, msix_entry)) {
-        /* No ISR checking should be done if masked, but read anyway */
-        return qpci_msix_pending(dev->pdev, msix_entry);
-    }
-
-    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
-    data = le32_to_cpu(data);
-    if (data == 0) {
-        return false;
-    }
-    /* got a message, ensure it matches expected value then clear it. */
-    g_assert_cmphex(data, ==, msix_data);
-    qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
-    return true;
-}
-
 static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
@@ -155,8 +133,8 @@ static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
     if (dev->pdev->msix_enabled) {
         QVirtQueuePCI *vqpci = container_of(vq, QVirtQueuePCI, vq);
 
-        return get_msix_status(dev, vqpci->msix_entry, vqpci->msix_addr,
-                               vqpci->msix_data);
+        return qpci_msix_test_interrupt(dev->pdev, vqpci->msix_entry,
+                                        vqpci->msix_addr, vqpci->msix_data);
     }
 
     return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 1;
@@ -167,8 +145,9 @@ static bool get_config_isr_status(QVirtioDevice *d)
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
 
     if (dev->pdev->msix_enabled) {
-        return get_msix_status(dev, dev->config_msix_entry,
-                               dev->config_msix_addr, dev->config_msix_data);
+        return qpci_msix_test_interrupt(dev->pdev, dev->config_msix_entry,
+                                        dev->config_msix_addr,
+                                        dev->config_msix_data);
     }
 
     return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 2;
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 76ea1f45ba9..ea8114e2438 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -122,25 +122,12 @@ static void qvirtio_pci_set_status(QVirtioDevice *d, uint8_t status)
 static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
-    QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
-    uint32_t data;
 
     if (dev->pdev->msix_enabled) {
-        g_assert_cmpint(vqpci->msix_entry, !=, -1);
-        if (qpci_msix_masked(dev->pdev, vqpci->msix_entry)) {
-            /* No ISR checking should be done if masked, but read anyway */
-            return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
-        } else {
-            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data, 4);
-            data = le32_to_cpu(data);
-            if (data == 0) {
-                return false;
-            }
-            /* got a message, ensure it matches expected value then clear it. */
-            g_assert_cmphex(data, ==, vqpci->msix_data);
-            qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
-            return true;
-        }
+        QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
+
+        return qpci_msix_test_interrupt(dev->pdev, vqpci->msix_entry,
+                                        vqpci->msix_addr, vqpci->msix_data);
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 1;
     }
@@ -149,24 +136,11 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
-    uint32_t data;
 
     if (dev->pdev->msix_enabled) {
-        g_assert_cmpint(dev->config_msix_entry, !=, -1);
-        if (qpci_msix_masked(dev->pdev, dev->config_msix_entry)) {
-            /* No ISR checking should be done if masked, but read anyway */
-            return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
-        } else {
-            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr, &data, 4);
-            data = le32_to_cpu(data);
-            if (data == 0) {
-                return false;
-            }
-            /* got a message, ensure it matches expected value then clear it. */
-            g_assert_cmphex(data, ==, dev->config_msix_data);
-            qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
-            return true;
-        }
+        return qpci_msix_test_interrupt(dev->pdev, dev->config_msix_entry,
+                                        dev->config_msix_addr,
+                                        dev->config_msix_data);
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 2;
     }
-- 
2.47.1


