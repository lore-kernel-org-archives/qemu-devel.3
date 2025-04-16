Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D240EC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 15:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54Fr-00073u-Lr; Wed, 16 Apr 2025 11:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54F0-0006fZ-9X; Wed, 16 Apr 2025 10:59:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54Eu-00037v-1s; Wed, 16 Apr 2025 10:59:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227c7e57da2so62898795ad.0; 
 Wed, 16 Apr 2025 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744815584; x=1745420384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLsKC1VDfykrLR/xlFXBSJARqTmqeD4ZLZllGCOlULE=;
 b=Yt3br3lgOKkWbbJVY/fkIxop+3leGiPue1UFm66V+2bPsxJ9J8CEb0YyVlqy1Du3Qt
 Q9Jw/sCx4U+JstWJmngUVeGqYuUlp7pIlnQ2tpb28b/F7F6gtMaf8iiK+hr2V7ZHbK8Q
 0iayiYnR/toIBhaodZH+Vy2o9s7WbBMPy4EDB+2AFyYrEONIRTDvCnEp8+dG0DXfVCY0
 a5U5spHHMzfjaPNACP1rVJ12USZwNZUGy5ZjVQ8K9UbQUX260U1RJQOY63TjhkDjSZTU
 BNqYeImiiZMfF7Z7X1oTn9SJWsXNkhhb4Q2VHODbZwR4YOlOk+toTkqzmXvqv/ZT7T1L
 Ctxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744815584; x=1745420384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLsKC1VDfykrLR/xlFXBSJARqTmqeD4ZLZllGCOlULE=;
 b=HRuCqm3lYWmDKdhwcVBoBKkkLB1c1TogcthrDWieE/HJRU2DMF0hLPwligC/YIqRsD
 vy2l1/EJhCs1vpt3naSg84IzHyiXX6AB1Z0NfO2Vv8tVmNBYlYNzWJVu7slSf5CKSVtz
 ZIADbmI+q/tiAc/cdwkG+OnjU2Ghm2J7JGk1WhLsNVgnS1KzWBO5uFWW4VV7FifqQ4Bw
 hY6oFVC4vb3i5/eqP4UewuB4gHerqb/CsG0kQDy8rh6Av1xMMy8Y0+ByNvBN0puQUcQO
 creyshdSWX/1RSzyUrgHCJFf2tUkO4YDtpM4SRFI2e86EfqvQjGQuIu60ZCs9frTO3rF
 BjzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU//nexpJin/N63XFvGTHY5yHcWZ74G5gufers4hhsff8x4F5NBKvCYrgBBjbhjm8uB11I7lB7kNZw6dQ==@nongnu.org,
 AJvYcCUZ7O+nGlr/h/PHnuWyQFQfZWoci/Wa4VXNe3+T3BSSnOY9qQaVGMNOkzFWBX+BOTQCWtx/HkDJ8cOk@nongnu.org
X-Gm-Message-State: AOJu0Yz9yI2TFy9dvFaTDpPBqjlr5lSz6murUvgfh0fKvAuNCvjDrp91
 W7b37bJC2cfZFifWSkE8WkaW0kxcBs7r4Oy41c3TnpYvpfL7xik85NnmOQ==
X-Gm-Gg: ASbGnctdTk+4JOJCKkkk7dcap925Ri2xJJyqxxyjla2DnzzZtZGJDG7elAK4xQ6/LnE
 99EtXOvZDFqppBWfRWIdlR6mEDwKZY4aYznt+tqzikWxNQMPPJPfQ4yQArlk+RQYQUvygyhaX06
 vvUqkmuSkt0JVRxOrfnHHH41U9CpnOAn7AOleePY2l0V5LNAiBS+NM3fi4MfWpeNiQGX3jFwBM/
 WQHR0ciMGkEuMAvELtat9UyN7OfAS0+6oJkr9ErfOhKvBCE5hEHnD51YaWWU3PYFu+DsUF5IrG+
 JqYqrri+VB7oJ669KiWlKXYdZJr5XZGOACmybkZMfg==
X-Google-Smtp-Source: AGHT+IGFCNlbnGG1JRN13oUQ2YYJ6G92Z3kiQN//FM0ebPbhMkx/ebLRu4tgJy0LQJ0X77eufL/ytQ==
X-Received: by 2002:a17:902:d508:b0:225:ac99:ae0d with SMTP id
 d9443c01a7336-22c358c6242mr41921485ad.10.1744815583493; 
 Wed, 16 Apr 2025 07:59:43 -0700 (PDT)
Received: from wheely.local0.net ([1.145.55.85])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e355sm10814506b3a.139.2025.04.16.07.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:59:43 -0700 (PDT)
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
Subject: [PATCH 3/4] tests/qtest: Add libqos function for testing msix
 interrupt status
Date: Thu, 17 Apr 2025 00:59:17 +1000
Message-ID: <20250416145918.415674-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250416145918.415674-1-npiggin@gmail.com>
References: <20250416145918.415674-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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


