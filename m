Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C8E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLefi-0006jp-Sh; Thu, 12 Dec 2024 03:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefd-0006jK-Rb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:42 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefb-0004Yq-W0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:41 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso290345a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733992538; x=1734597338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRzGHL8a7jlvTqq7ZxETU8b2iDxcAK+LJXWt+PmXXJ8=;
 b=W3EgflyQrMjey7r7CdotaeEgSJjIQB/Y1/s3RhY9mJangpV5I5AZkiCpGTEhGal2JU
 YA/D7hzlzetwdqO8FVwcrUyEqi/itvdIJxaaioOxY6pZ04dwFZ9eaWVRwKdrvjdoA2E5
 X5Wy4Z/LsjJ06efMEpwS84zeOd5EuYwvHHbtSuof6K5XNJs0JXpS+yc/oUrPPObYLBYd
 hK10DPr7PFM2yydX/W2QdzzPA2gcEhbRzKoikw4Nj8FKbF+vgbWgRAuMrSKXfMFGzgR/
 YdYLDZSBr10FKNC3FaUs3MnvobybC55ZaqvOKq9t7NRgk76OEORqa1EJ3VdS3cQWoc4L
 +XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733992538; x=1734597338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRzGHL8a7jlvTqq7ZxETU8b2iDxcAK+LJXWt+PmXXJ8=;
 b=sXTJWxPv3zOb+0UElxplB7x4ui1f7HcwqrlVmbMWwwV5dfa27rk16TDUPi/qBA3z7i
 0NnvwMg8EoqUaHM0WFulJG91cRXR3CT5aK8MbTO0lECj8FlYcCAVSuSzrZIrtyU3l+0Q
 CAc4gWMEraKDmK0PaYS8RSDhCJ1bejfEuF71jOt3hbPJmycnICDFghdOupUPYUhFPrHJ
 Lpli5IR6UQQvKJfLzkfeEQJIR8jH8PrTjTnTRi6D0bypl7nVG8gqbTDrFQS4mvXG8vPE
 UnSHbDbJviTNugum0P6g/cYj0M9IUqdT2J1o6xWvOXwxaV5tRDR+N69CgipmKYdL54/i
 fivQ==
X-Gm-Message-State: AOJu0Yy/K5Z0+V0udrWwdjQ6bcRXKlYquwgw+wrCDQU5uybWyRxuzkos
 Fd7f5H7eWPjWWsADogl1Mq83KzBmsNDLt4GREK1l+FbYxIzJUr9ymxYXMA==
X-Gm-Gg: ASbGncvLrMAP9R6Zi3t+R10GDcp235yR4iw0yH0wYszVqP6Y4q9Av2BGoIxx8U3LQ9F
 omJNJVUYHEQBWkuJpvI7vt1axbvwMnkKOdK35yajZh9tZb/Nb4ixY3kavnL5lERCHXRM970gXOc
 XEuQLK2jVUDV/4gGwvOK4hTB4MZdGcYnkRXHX3y9/nm66QjhmPCvAmEAeV9DuUiXq6jPDTdXz/2
 NnGutBwrxqJSEHFUTHVC3D25KjdHWVeNw5uqYb9Mas72/AruG/p9FzLYOI=
X-Google-Smtp-Source: AGHT+IEocK2ZRipITNsC67Ce6El/pxrG8FwV4hELc5xRDbueT9T55VH48nAGEENfCqen5+p3x/8yaQ==
X-Received: by 2002:a17:90b:4c84:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2f13930c5afmr4261498a91.28.1733992536903; 
 Thu, 12 Dec 2024 00:35:36 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142dae788sm714624a91.12.2024.12.12.00.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:35:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 3/8] pci/msix: Implement PBA writes
Date: Thu, 12 Dec 2024 18:34:56 +1000
Message-ID: <20241212083502.1439033-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212083502.1439033-1-npiggin@gmail.com>
References: <20241212083502.1439033-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
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

Implement MMIO PBA writes, 1 to trigger and 0 to clear.

This functionality is used by some qtests, which keep the msix irq
masked and test irq pending via the PBA bits, for simplicity. Some
tests expect to be able to clear the irq with a store, so a side-effect
of this is that qpci_msix_pending() would actually clear the pending
bit where it previously did not. This actually causes some [possibly
buggy] tests to fail. So to avoid breakage until tests are re-examined,
prior behavior of qpci_msix_pending() is kept by changing it to avoid
clearing PBA.

A new function qpci_msix_test_clear_pending() is added for tests that
do want the PBA clearing, and it will be used by XHCI and e1000e/igb
tests in subsequent changes.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h |  1 +
 hw/pci/msix.c            | 16 ++++++++++++++++
 tests/qtest/libqos/pci.c | 20 +++++++++++++++++---
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 5a7b2454ad5..de540f7803f 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -94,6 +94,7 @@ uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
+bool qpci_msix_test_clear_pending(QPCIDevice *dev, uint16_t entry);
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
 uint16_t qpci_msix_table_size(QPCIDevice *dev);
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 487e49834ee..b16b03b888f 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -260,6 +260,22 @@ static uint64_t msix_pba_mmio_read(void *opaque, hwaddr addr,
 static void msix_pba_mmio_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
+    PCIDevice *dev = opaque;
+    unsigned vector_start = addr * 8;
+    unsigned vector_end = MIN(addr + size * 8, dev->msix_entries_nr);
+    unsigned i;
+
+    for (i = vector_start; i < vector_end; i++) {
+        if ((val >> i) & 1) {
+            if (!msix_is_pending(dev, i)) {
+                msix_notify(dev, i);
+            }
+        } else {
+            if (msix_is_pending(dev, i)) {
+                msix_clr_pending(dev, i);
+            }
+        }
+    }
 }
 
 static const MemoryRegionOps msix_pba_mmio_ops = {
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 023c1617680..f8d655a0e61 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -361,9 +361,23 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 
     g_assert(dev->msix_enabled);
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
-    qpci_io_writel(dev, dev->msix_pba_bar, dev->msix_pba_off + off,
-                   pba_entry & ~(1 << bit_n));
-    return (pba_entry & (1 << bit_n)) != 0;
+    return pba_entry & (1 << bit_n);
+}
+
+bool qpci_msix_test_clear_pending(QPCIDevice *dev, uint16_t entry)
+{
+    uint32_t pba_entry;
+    uint8_t bit_n = entry % 32;
+    uint64_t  off = (entry / 32) * PCI_MSIX_ENTRY_SIZE / 4;
+
+    g_assert(dev->msix_enabled);
+    pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
+    if (pba_entry & (1 << bit_n)) {
+        qpci_io_writel(dev, dev->msix_pba_bar, dev->msix_pba_off + off,
+                       pba_entry & ~(1 << bit_n));
+        return true;
+    }
+    return false;
 }
 
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
-- 
2.45.2


