Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679DDC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36Dh-0003di-H9; Fri, 11 Apr 2025 00:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DY-0003aE-Hu; Fri, 11 Apr 2025 00:42:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DW-0001hf-Pq; Fri, 11 Apr 2025 00:42:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22403cbb47fso16553865ad.0; 
 Thu, 10 Apr 2025 21:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744346533; x=1744951333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKyqrN482MxUi8aGlGxTp85Ez/bPRUp+V1nk5qGRW08=;
 b=ecEi1JF/UIDxxUQjvy7yqTolPWXJaOL7ciOKAOwxILMmItyAx/1pI0ShJgrIRRdNk8
 Ao9xUYOmYWFsdQNx5hdvbKkYkmqilhcadpP34hDriSbZiIgAVQod+ayntowa38eeKD8c
 /N6nhSbdSAzFbD0K71f8o5wwFWlRbP0gtj8OLBMUBuqjWEr5EfVpvI17NIp4Odk5Zuua
 B4AVGI/ujdawlxPfp7PBTni6mQ4sBH0SPdenrLwuX7TyA56ak9xeoQKTYCsJHxxR+tA4
 BzfJVa3Rr0g7rblnmJoq+xt7FMMypZUJrfpSv+DKBkq65F4XyGKY5N+JVgPouDKW7p/9
 IcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744346533; x=1744951333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKyqrN482MxUi8aGlGxTp85Ez/bPRUp+V1nk5qGRW08=;
 b=BdE/VPLJP/Kvru4pDmdoJwFpfCDjCBTKeyA+HE56hGOlJ2ntvK5R2XXm2oebM5/MZd
 bMjveOYmyNL6FMILG3MPSeW9RdbqYt8J070YZd82hb3Wjw6CMWT3X4lPSh4G4xXe/ic6
 CprGrtOHJkVoMa6zodoN1FYfzWEU/RBkLd6JsuDyZPuPJ+1B/SlGZEFLE9GLxUJuriEa
 WYszpb1XEkU/wpdl9tfIDt882+NDvaKEesSUHHkn+4wTEq/GXK14zbeTmkvigwI0YTvE
 m2mbuNh0aDWUr7EshgcogK739X4yg6FAxWiUhQD0xE5NLCmR9Coa2eG38jf2z7lDk9NV
 SW7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw5qHzA4OcDTItcErWKR0jAh/A/ygDjezSomhRKoU2e2qSwqifmuXNPPj4g2QaUrP5X6bRNRscnqir@nongnu.org
X-Gm-Message-State: AOJu0Yznc1NZBdP3iHOvyMwM/IOMoMAttfmIqLH9I2ABrg4j3hK7DR3F
 u57uEBwize6WjbIyhR500Eo/nrVqExXurkwwmlqbd1cXkcjds3fawWaP/w==
X-Gm-Gg: ASbGncvXs6oCbvGMPC8rKwLYb5b6PWwgOwZ1Tev6jy3qrNEX+SkO2R9Umq742vTdzSy
 XkDs6RnjXHMGRjdoeT7m7vOSYPYwMXYQ1aSK2ATWKeVU1RttC+BCSdTdupXerWIPemHDp8QiLMr
 trL+yKY5Rhg+SpX4PqBE1/wVALYbTnxkPnMNkBIyBVio5AiX6YLFvmpwTQNE5yZ/ECXn8JKrKln
 GNWw/1z2yoS/UStNCI6eOYGReZdtwfpdGqk7bPCDtXlu6dg3VU+3q5buMkLaWQrNnVS4XIeqg/z
 8/eocwYYv/UDp9pINwoKoTH8YLi9S+VxwddggyevKxre
X-Google-Smtp-Source: AGHT+IG3tB7DxXSlgCT5ZkTIi1LG6Zl0zvamMoMbxjbGyFqZFeTIG8R1dRNqvfmmiy6phegym0XUpg==
X-Received: by 2002:a17:903:2385:b0:227:e74a:a066 with SMTP id
 d9443c01a7336-22bea4c755cmr24707665ad.28.1744346532796; 
 Thu, 10 Apr 2025 21:42:12 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971e4sm39672745ad.136.2025.04.10.21.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:42:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v4 7/7] qtest/libqos/pci: Factor msix entry helpers into pci
 common code
Date: Fri, 11 Apr 2025 14:41:29 +1000
Message-ID: <20250411044130.201724-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411044130.201724-1-npiggin@gmail.com>
References: <20250411044130.201724-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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
index d334d9c0837..c63342d8c72 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -100,8 +100,11 @@ void qpci_device_enable(QPCIDevice *dev);
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
index 72adf81ddd6..4627f324200 100644
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
index cb52a7c3f2e..8dfe0ff310d 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -321,64 +321,26 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
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
2.47.1


