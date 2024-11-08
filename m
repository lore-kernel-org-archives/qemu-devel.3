Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA84D5C0F0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R8K-0002By-O0; Fri, 08 Nov 2024 10:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8H-0002BX-HB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:45 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8F-0005Fh-Q9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:45 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso1863125b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731080562; x=1731685362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnDnIMcekCsnd3CGKNWtp2v1ooPSGgZR3bcu+6t5wxM=;
 b=lsznyKcKnw6JBuo8bT9QxRIah3bqg+AsqD7SCNl1aI6E1zps/EG+mD2f9FD1d4G1SJ
 ojf1w7C1b58cYTq4wNP8r/LGPnEielgwE8T7AqQoS1WrsZJFFng9548vK2dBCOm8PqXl
 1J86p03N9b0eXgq3YkAJBlYS9uMUS6Y8+/YlAdlyBplcJC9v5YIcFqxZcS819CHcce4r
 CbjJ2Y3E5CkHdSJHW1EAG7fejsF1uJwspsduJxixRLJlgn7Kqkv2oXjh5GKMrFspjlDY
 oc75dzOpSPKsL9U5jRvFcx0Cxw3ycYUN9vVUAFU9ZrV75yG+7JUSyi+gU+ERD8cdFJGu
 CZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080562; x=1731685362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnDnIMcekCsnd3CGKNWtp2v1ooPSGgZR3bcu+6t5wxM=;
 b=D0VGGLupB22w5dmzA+bArIJ+JlEPbwL9xjYcUy0fzsh+gy1PsL8y9deyD440yOEGu4
 pe8YU0dmc0FsXMPnITgq5WDeo/khxttdfyYjHQUn+3OAEadrP1v3UKPkvzopRiH9Ifsv
 f/ZTX7kE407uWe2GRrLUtgzxgsOimTNST1GDm853EulTXGCcTafPjzer9Zq8E8tITEhw
 X91FxDBTciKfzNtBXp4RswL9YLYkwRWYLR+hNFNSItc3vRJOjMz65QAroQSG3S51q2RY
 klfS01CjLhEepKCtEJJXs4Oj5SDVgjapVU3JRaiMNhXpBD+BI9wFnWmN+Ksewe2k0pbo
 sIfA==
X-Gm-Message-State: AOJu0YwGugqroixNOTI33a5mP32N4Gjs+m/Njx11NaYxi8VF3hX4A4Ut
 ZDCR3hDgGzmYq7mSFQPo738y7ymFDZ+KTT1TMuTqymglOYlY93HHfabvGg==
X-Google-Smtp-Source: AGHT+IHGjCysYi2G94UlgtzFj/peajwuS9DR2KidZDYU9XgpmSCraqLwfeYr89ojXk7Y5LaSSPWRYg==
X-Received: by 2002:a05:6a20:840d:b0:1db:eb56:be7c with SMTP id
 adf61e73a8af0-1dc22b1b74fmr4834228637.35.1731080561861; 
 Fri, 08 Nov 2024 07:42:41 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f48d32bsm3110444a12.17.2024.11.08.07.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:42:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 1/5] qtest/pci: Enforce balanced iomap/unmap
Date: Sat,  9 Nov 2024 01:42:24 +1000
Message-ID: <20241108154229.263097-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154229.263097-1-npiggin@gmail.com>
References: <20241108154229.263097-1-npiggin@gmail.com>
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

Add assertions to ensure a BAR is not mapped twice, and only
previously mapped BARs are unmapped. This can help catch some
bugs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/ahci.h       |  1 +
 tests/qtest/libqos/pci.h        |  2 ++
 tests/qtest/libqos/virtio-pci.h |  1 +
 tests/qtest/ahci-test.c         |  2 ++
 tests/qtest/libqos/ahci.c       |  6 ++++++
 tests/qtest/libqos/pci.c        | 32 +++++++++++++++++++++++++++++++-
 tests/qtest/libqos/virtio-pci.c |  6 +++++-
 7 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index a0487a1557..5d7e26aee2 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -575,6 +575,7 @@ QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
 void free_ahci_device(QPCIDevice *dev);
 void ahci_pci_enable(AHCIQState *ahci);
 void start_ahci_device(AHCIQState *ahci);
+void stop_ahci_device(AHCIQState *ahci);
 void ahci_hba_enable(AHCIQState *ahci);
 
 /* Port Management */
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 8389614523..9dc82ea723 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -65,6 +65,8 @@ struct QPCIDevice
 {
     QPCIBus *bus;
     int devfn;
+    bool bars_mapped[6];
+    QPCIBar bars[6];
     bool msix_enabled;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
diff --git a/tests/qtest/libqos/virtio-pci.h b/tests/qtest/libqos/virtio-pci.h
index f5115cacba..efdf904b25 100644
--- a/tests/qtest/libqos/virtio-pci.h
+++ b/tests/qtest/libqos/virtio-pci.h
@@ -26,6 +26,7 @@ typedef struct QVirtioPCIDevice {
     uint64_t config_msix_addr;
     uint32_t config_msix_data;
 
+    bool enabled;
     int bar_idx;
 
     /* VIRTIO 1.0 */
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5a1923f721..b3dae7a8ce 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1483,6 +1483,8 @@ static void test_reset_pending_callback(void)
     /* Wait for throttled write to finish. */
     sleep(1);
 
+    stop_ahci_device(ahci);
+
     /* Start again. */
     ahci_clean_mem(ahci);
     ahci_pci_enable(ahci);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 34a75b7f43..cfc435b666 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -217,6 +217,12 @@ void start_ahci_device(AHCIQState *ahci)
     qpci_device_enable(ahci->dev);
 }
 
+void stop_ahci_device(AHCIQState *ahci)
+{
+    /* Map AHCI's ABAR (BAR5) */
+    qpci_iounmap(ahci->dev, ahci->hba_bar);
+}
+
 /**
  * Test and initialize the AHCI's HBA memory areas.
  * Initialize and start any ports with devices attached.
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index b23d72346b..a42ca08261 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -93,12 +93,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
 {
     uint16_t vendor_id, device_id;
+    int i;
 
     qpci_device_set(dev, bus, addr->devfn);
     vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
     device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
     g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
     g_assert(!addr->device_id || device_id == addr->device_id);
+
+    for (i = 0; i < 6; i++) {
+        g_assert(!dev->bars_mapped[i]);
+    }
 }
 
 static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
@@ -531,6 +536,8 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
     uint64_t loc;
 
     g_assert(barno >= 0 && barno <= 5);
+    g_assert(!dev->bars_mapped[barno]);
+
     bar_reg = bar_reg_map[barno];
 
     qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
@@ -574,12 +581,35 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
     }
 
     bar.addr = loc;
+
+    dev->bars_mapped[barno] = true;
+    dev->bars[barno] = bar;
+
     return bar;
 }
 
 void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
 {
-    /* FIXME */
+    static const int bar_reg_map[] = {
+        PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
+        PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
+    };
+    int bar_reg;
+    int i;
+
+    for (i = 0; i < 6; i++) {
+        if (!dev->bars_mapped[i]) {
+            continue;
+        }
+        if (dev->bars[i].addr == bar.addr) {
+            dev->bars_mapped[i] = false;
+            bar_reg = bar_reg_map[i];
+            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
+            /* FIXME: the address space is leaked */
+            return;
+        }
+    }
+    g_assert_not_reached();
 }
 
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 485b8f6b7e..2b59fb181c 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -304,11 +304,15 @@ void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
 {
     qpci_device_enable(d->pdev);
     d->bar = qpci_iomap(d->pdev, d->bar_idx, NULL);
+    d->enabled = true;
 }
 
 void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 {
-    qpci_iounmap(d->pdev, d->bar);
+    if (d->enabled) {
+        qpci_iounmap(d->pdev, d->bar);
+        d->enabled = false;
+    }
 }
 
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
-- 
2.45.2


