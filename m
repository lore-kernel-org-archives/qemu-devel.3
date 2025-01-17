Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C631AC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq4B-0007pm-3Q; Fri, 17 Jan 2025 12:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3v-0007aR-Gf; Fri, 17 Jan 2025 12:23:15 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3s-00064O-NS; Fri, 17 Jan 2025 12:23:15 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166651f752so57170005ad.3; 
 Fri, 17 Jan 2025 09:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737134591; x=1737739391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3c/7dluxFVgKgfwsUNU3hoWNyxHyfAlaCqectWwk2w=;
 b=f36HBKQNvLwOxJdMVU66USfFK/78vCtjV1x0uvC1i46auX5bYwPLVQRKp2KjoAK25G
 C1cKKKv9TbyJ9fbawfOS27fYqJ4dUSuyugBK6F3KD379Q3z9qyszVEotHPB/N1kP8FNf
 OxFKVv1Moww3jq/AXxtccUk0SXe8/0zXtIU7BIpKAhStnBTFnXH4dUIZxKWsIrVZR5Xj
 t1iiSQ3L7EgFaPMUGbyub9a9SMhVWxN/3vOxZfQam2wlbCZ0ACWQxPz5iPls3UpyHY+z
 XQEul/35vjB9pJNcxF70KP+INg0UOMl56ReR2o3LC11va1BRrF1YKf32a+MMToY9Qk9v
 3mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134591; x=1737739391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3c/7dluxFVgKgfwsUNU3hoWNyxHyfAlaCqectWwk2w=;
 b=ezKd/1tuVVm/UdQ8G3vxelD86emLNolfK7LdYaa9iFnxc7tBj+uM3FvZZKC66rMvMK
 HpdGingao5wm9GIPEJksXeoHuaad0J9psLNrfWEnStPaaPm8Psx+br7p4MFNQor5EQCG
 ++Yzm3biE8Ox8DLaor4sOCUoX9++Fq9/KheI4RKOhXlKKdZJSB28chr7YBefu4a6Wv5n
 Wq2sPlwV35FmAuNGjjoeLXnbBdCeUMw631swDrFWejFJ0OMvw8wnA8aniyvEfxDkVhRd
 HTLD5iFIl0xkda5WszTZG3ieQRZGsLf/tpHtYidaW7qjl3w0V2ZQgSbg3mSgJhFUxRfX
 UZlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLPSiwOj78NmwIY56W0iUeDULL7EMKc5+DfNx52uwIEvWKbLrdvxKPWH/L86CQZtWDffz8yzJ6bdOl@nongnu.org,
 AJvYcCXzVD0tIYMGnfbUUif+LqE9SErfDn107+/tUXQBAe199l/YnosX2sBTEAqBNnwvZ/FgjSUFVxfKyxiZMw==@nongnu.org
X-Gm-Message-State: AOJu0Yy+ZMrscLGFyXqHkJbQDR1qiFt0IH4yE0JIpG7j7ZH/6PrKQlY1
 t4QFuYrYGn1YTTKzmhjWj+njb7OwGk5ZjZX2fPeaLODhP2BqhtUy
X-Gm-Gg: ASbGncv+E//jMHo4aqxJirLOwpXSMWAjzcrNGkVgZjJyqwVKH9Hn24pnvTDTRGmxFaa
 Yi8aaq/pUBsXg+YBqL26io1uL+O8ZL8HbP98nylX5Cyp2Cnuw4imeD+k7KAINBSvl+kUwx/ZYo0
 Vp6GCGVb9/BiuZzfa26BjGrvr5qW1DTCJI5xiVY5OHJaCTv8ZbMQxKTZ1HKazePblfPzZffiYKf
 z3nvp7Mdp5GAzzCuG2O0J4TPL396cSayy2kmiBhnW4tsMgTUnuGgjuXPOSs709T0U5+dOqwSqq5
 Qwah5kAOmpI3Dhc=
X-Google-Smtp-Source: AGHT+IE2SYtsbmNnEdBkKhXsrEZWoltXsNsj+QMQCY3IiQ5YCEwiI/WUUNX9mjE/+J/ZhA00rrzQrA==
X-Received: by 2002:a05:6a00:3e16:b0:728:ea15:6d68 with SMTP id
 d2e1a72fcca58-72dafb90858mr5080395b3a.18.1737134590760; 
 Fri, 17 Jan 2025 09:23:10 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba511a4sm2235950b3a.140.2025.01.17.09.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:23:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] qtest/libqos/pci: Factor msix entry helpers into pci
 common code
Date: Sat, 18 Jan 2025 03:22:43 +1000
Message-ID: <20250117172244.406206-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117172244.406206-1-npiggin@gmail.com>
References: <20250117172244.406206-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h        |  3 ++
 tests/qtest/libqos/pci.c        | 53 +++++++++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-pci.c | 48 ++++-------------------------
 3 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 5a7b2454ad5..d46ce4239f0 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -93,8 +93,11 @@ void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
+void qpci_msix_set_entry(QPCIDevice *dev, uint16_t entry,
+                         uint64_t guest_addr, uint32_t data);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
+void qpci_msix_set_masked(QPCIDevice *dev, uint16_t entry, bool masked);
 uint16_t qpci_msix_table_size(QPCIDevice *dev);
 
 uint8_t qpci_config_readb(QPCIDevice *dev, uint8_t offset);
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index a187349d30a..47632c4b403 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -353,6 +353,25 @@ void qpci_msix_disable(QPCIDevice *dev)
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
@@ -360,6 +379,9 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
     uint64_t  off = (entry / 32) * PCI_MSIX_ENTRY_SIZE / 4;
 
     g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, >=, 0);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
     return (pba_entry & (1 << bit_n)) != 0;
 }
@@ -371,6 +393,9 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
 
     g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, >=, 0);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
     addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=, 0);
     val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
@@ -384,6 +409,34 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
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
 uint16_t qpci_msix_table_size(QPCIDevice *dev)
 {
     uint8_t addr;
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 2b59fb181c9..ed7f50e41a5 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -318,64 +318,26 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
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
2.45.2


