Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389C4C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgj1-0002O2-Dg; Thu, 01 May 2025 23:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgiz-0002Mj-BL; Thu, 01 May 2025 23:06:05 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgix-0000nj-8c; Thu, 01 May 2025 23:06:05 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so1873003b3a.2; 
 Thu, 01 May 2025 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155161; x=1746759961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLBXVJOKqFw9SMHdJeArw8ZHGpPwbggoVTwrSmHP6lQ=;
 b=YrnjdQESXmV5rFlV6lU4irNQYWvRoT1jCDtKXuEgGxHhiT0uMktHPCReNjz3CH6ftN
 OIerPZkuXrehIT3liEwuNOkAn4bo4ptNHVbbXTo4WlWTebmPQ/nrgINW9ONwJpYH4Cs4
 gITpBSlVI2Q38Dakxtq2kzYQAo71qUhQ495ncO58SkJBwuCyRxv1r1wn5ukgNEczlTaH
 nNB3jBtZNBKVi9tq1aylii82sVcg6xpCKF9aXlsRtOcbh5UNSPbuYF8vsDuS+6oAq5a7
 CXgJ8RrzZnHF0Xg6AbXmb5NXUh+/JtNGgfAtHuW18q6el6tyalBGEeGGmPBMmxoc5Ghc
 K7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155161; x=1746759961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLBXVJOKqFw9SMHdJeArw8ZHGpPwbggoVTwrSmHP6lQ=;
 b=ZjRo/Ckza984ng2R7OdlMeGfj42bhDBwOSjnTj8iqklvvoidrEdniTeULdTkz7cHw4
 2arZbAV1iVe+AeSEedKS4oLMJTnJMXhOF87JHHTn3ruwJjBQvI6Pi1JoF2W9KC1s6GvC
 CCOPaQVnynHbYJwOJE+/ZyPHeONl59bE7CsKNreJZntgFuG8PB5zNxzOC7Qy/yTG9Ux6
 VyhiubwkFvbuG01RyrrlMxmmBM6iVEP+Y0ruU16/lkCxOhU8w+alP3IeF+lPhK+IBcsz
 zFhCIz2lfdHJdtoIWgTnyHE1Sb/k2L4betSArQnZ+25RVyKCUsHlSUHEgBZW4nc+2Fb9
 NLpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1wZqdxvSE+ZQqs6pw+asSLxZ0mFNw2C0FwfztArVZdIBv9yB1ibh/ywRROcn9ceSrM2RJx9ZNvLWh@nongnu.org,
 AJvYcCWhSl6IVSZdswWIJUej/ODmHUhvtz98U0xTaWMNlYjgVBEP4irsw6eyAwqorJCMVkzFnVfMlih7Yl0=@nongnu.org
X-Gm-Message-State: AOJu0YxfrCLpx8oTXXH/ZFc25La05z7bCcF1vuxGBjv0qEkzGjXVccyG
 lO9DTOZ5nHaM9cJ3lSKuZQ9tyrh9ZNVt1Yc3ycDgHQS+WVWxKaMF8p6i7w==
X-Gm-Gg: ASbGnct2utG/bjyhM5mtkqUn4YaFt5GwMDgsxvwlWVS8kUA/+tOb+ta1NccvZhp78WZ
 BRXocuY7CB2bEiGc2iv2C7qAJBXL5A1x66NYnvZTQnOJiCMH2a0tMUTygv22KxF18+ZtkBFsjBy
 jS894e244622gTIMCotfVkYpQxct034fztiE9ffgOt5cfkIsbNTbE6p7q4bg7+6/6za58aNYxXm
 aJN2k0O/htk+GXyEONO5f+VSXhYXy/vRfezZAS2slo336VaV+tMFsr5CII6i4g++BsfHlvEXWcx
 3ds7b71c0OGzKQj1vUyt+RHjainRi9RFpUzQJjaP1465
X-Google-Smtp-Source: AGHT+IEspwl9jq1Xr5NstoYF65ZfKZ9VVlI8qW6ZEJYj0L5GOxeDpNxCPz0zznJ4zKJJQ5GeCya6YA==
X-Received: by 2002:a05:6a20:cfa7:b0:1f5:839e:ecdd with SMTP id
 adf61e73a8af0-20cde46b948mr1806850637.9.1746155160816; 
 Thu, 01 May 2025 20:06:00 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:06:00 -0700 (PDT)
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
Subject: [PATCH v5 11/11] qtest/libqos/pci: Factor msix entry helpers into pci
 common code
Date: Fri,  2 May 2025 13:04:45 +1000
Message-ID: <20250502030446.88310-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

Setting msix entry address and data and masking is moved into
common code helpers from virtio tests.

For now that remains the only user, but there are changes under
development to enable msix vectors for msix, e1000e, and xhci
tests, which can make use of them.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h        |  3 ++
 tests/qtest/libqos/pci.c        | 53 +++++++++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-pci.c | 48 ++++-------------------------
 3 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 852d4a85f6f..1c4f5406c58 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -96,8 +96,11 @@ void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
+void qpci_msix_set_entry(QPCIDevice *dev, uint16_t entry,
+                         uint64_t guest_addr, uint32_t data);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
+void qpci_msix_set_masked(QPCIDevice *dev, uint16_t entry, bool masked);
 bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
                               uint64_t msix_addr, uint32_t msix_data);
 uint16_t qpci_msix_table_size(QPCIDevice *dev);
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index cc83dcc163a..e26cb4dee13 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -339,6 +339,25 @@ void qpci_msix_disable(QPCIDevice *dev)
     dev->msix_pba_off = 0;
 }
 
+void qpci_msix_set_entry(QPCIDevice *dev, uint16_t entry,
+                         uint64_t guest_addr, uint32_t data)
+{
+    uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, >=, 0);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_LOWER_ADDR, guest_addr & ~0UL);
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_UPPER_ADDR,
+                   (guest_addr >> 32) & ~0UL);
+
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_DATA, data);
+}
+
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 {
     uint32_t pba_entry;
@@ -346,6 +365,9 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
     uint64_t  off = (entry / 32) * PCI_MSIX_ENTRY_SIZE / 4;
 
     g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, >=, 0);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
     return (pba_entry & (1 << bit_n)) != 0;
 }
@@ -357,6 +379,9 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
 
     g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, >=, 0);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
     addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=, 0);
     val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
@@ -370,6 +395,34 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     }
 }
 
+void qpci_msix_set_masked(QPCIDevice *dev, uint16_t entry, bool masked)
+{
+    uint8_t addr;
+    uint16_t val;
+    uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, >=, 0);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
+    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
+    g_assert_cmphex(addr, !=, 0);
+    val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
+    g_assert(!(val & PCI_MSIX_FLAGS_MASKALL));
+
+    val = qpci_io_readl(dev, dev->msix_table_bar,
+                         vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL);
+    if (masked && !(val & PCI_MSIX_ENTRY_CTRL_MASKBIT)) {
+        qpci_io_writel(dev, dev->msix_table_bar,
+                      vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                      val | PCI_MSIX_ENTRY_CTRL_MASKBIT);
+    } else if (!masked && (val & PCI_MSIX_ENTRY_CTRL_MASKBIT)) {
+        qpci_io_writel(dev, dev->msix_table_bar,
+                      vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                      val & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
+    }
+}
+
 /**
  * qpci_msix_test_interrupt - test whether msix interrupt has been raised
  * @dev: PCI device
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index d6333a4d576..4e27b7a7931 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -299,66 +299,28 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
                                         QGuestAllocator *alloc, uint16_t entry)
 {
-    uint32_t control;
-    uint64_t off;
-
     g_assert(d->pdev->msix_enabled);
-    off = d->pdev->msix_table_off + (entry * 16);
-
-    g_assert_cmpint(entry, >=, 0);
-    g_assert_cmpint(entry, <, qpci_msix_table_size(d->pdev));
     vqpci->msix_entry = entry;
-
     vqpci->msix_addr = guest_alloc(alloc, 4);
     qtest_memset(d->pdev->bus->qts, vqpci->msix_addr, 0, 4);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_LOWER_ADDR, vqpci->msix_addr & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_UPPER_ADDR,
-                   (vqpci->msix_addr >> 32) & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_DATA, vqpci->msix_data);
-
-    control = qpci_io_readl(d->pdev, d->pdev->msix_table_bar,
-                            off + PCI_MSIX_ENTRY_VECTOR_CTRL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_VECTOR_CTRL,
-                   control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
+    qpci_msix_set_entry(d->pdev, entry, vqpci->msix_addr, vqpci->msix_data);
+    qpci_msix_set_masked(d->pdev, entry, false);
     d->msix_ops->set_queue_vector(d, vqpci->vq.index, entry);
 }
 
 void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
                                         QGuestAllocator *alloc, uint16_t entry)
 {
-    uint32_t control;
-    uint64_t off;
-
     g_assert(d->pdev->msix_enabled);
-    off = d->pdev->msix_table_off + (entry * 16);
-
-    g_assert_cmpint(entry, >=, 0);
-    g_assert_cmpint(entry, <, qpci_msix_table_size(d->pdev));
     d->config_msix_entry = entry;
-
     d->config_msix_data = 0x12345678;
     d->config_msix_addr = guest_alloc(alloc, 4);
     qtest_memset(d->pdev->bus->qts, d->config_msix_addr, 0, 4);
 
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_LOWER_ADDR, d->config_msix_addr & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_UPPER_ADDR,
-                   (d->config_msix_addr >> 32) & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_DATA, d->config_msix_data);
-
-    control = qpci_io_readl(d->pdev, d->pdev->msix_table_bar,
-                            off + PCI_MSIX_ENTRY_VECTOR_CTRL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_VECTOR_CTRL,
-                   control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
+    qpci_msix_set_entry(d->pdev, entry, d->config_msix_addr,
+                                        d->config_msix_data);
+    qpci_msix_set_masked(d->pdev, entry, false);
     d->msix_ops->set_config_vector(d, entry);
 }
 
-- 
2.47.1


