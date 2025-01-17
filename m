Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7DBC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq46-0007kg-PZ; Fri, 17 Jan 2025 12:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3k-0007Uq-Uk; Fri, 17 Jan 2025 12:23:05 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3j-00063I-9c; Fri, 17 Jan 2025 12:23:04 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21675fd60feso53732115ad.2; 
 Fri, 17 Jan 2025 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737134581; x=1737739381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QIwrFyIStAPgOTMlYQifj6PiT67/GJsSNdwJzc5QhY=;
 b=hfd4nnNc2yZxZRg+PQMNVfxThBqRgmUJ/btWjv953lUZ5ir6atRs8McRwDKqQoKQ5B
 oDyDR3gD9xpIXhg+EOwO2SecCIu1ii/9Yjy6c3havCZiY5xM5SNDl9RbA+7HMWuxpUPy
 qbL9nT27QBN3dtN5Ibxk6cUTnUU+d+9V4ciLp53AkDc0FB/81wCugvOnUWkPqswK/Tuv
 hMsy9WutyCEcFIBikA13GDeoSudVjfceVXZfCFF7PvYIMcU+FXqEHDZgmHEkim6Iyjy5
 jRAc0OQv/8uyshUPweXI5+Fr1DYE66MBBW5HONKWYjgjTwzsa7TScfWA4PLecEdAKaZ6
 Wy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134581; x=1737739381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QIwrFyIStAPgOTMlYQifj6PiT67/GJsSNdwJzc5QhY=;
 b=D3DMxn6yA2qGOKawmwQn4T0NWwvdtd+4beLk1lj+LdMcLDQLGSBXnWzI2B1EgkJWMm
 GHoVMQsRto7Y4Vu7l3qAgbFOZBJ+7vR801o25xVmPSDIStmxz+XR6WzKl7gXLNFv4smf
 4iX3k5dMfNR7LLoRb/1Qeadm1184a5JePHhBsaQVnWhU430LsjM5wYzN+W9pNV2BDnW3
 535eRtYxH3ce7mvZR49c/lc0k+gnmTqIM2L3dGK7evGctzJL2q12Y9LruksMsyVuVPb6
 zUq9x8Qv7CQyC9ww5g2Wv18O/oSN43t4V/GpKdYEuC1cdQQLgkY5/cW+Bg5VjTItNzHW
 9OQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTplks0pElR48WSszWM179alrozLuHOvmPAfqjLE/rIiQro4MaEVAm1I4VCbFfvSf3isEuPMmYWMz0@nongnu.org,
 AJvYcCWAAejxerKPsVaQuABHWlMnb2gRfJrMPGh1Ohpe3Mx4xqUuFc7hEoE1JULQT5uN1jjUhm0N7x4fnzFnzQ==@nongnu.org
X-Gm-Message-State: AOJu0Yxkp1fHiPL+daBdZf6NTqYqiHpc8bv6j6gJq02p59PqBH1AAyNs
 45A2jUH8PKHDPLXxy26UAuQ4wkCqmPnTfJheJ5RUWb5ygZwkHuTg
X-Gm-Gg: ASbGncv4kR6zENJcNzIY2ojhET3d89AqMEok2f5sN9dMh16eTi4qkVhWus4nJKHQJB9
 25fp6cmgSfIpLZUmyhMbo8a/7rEsYhlluoQEgDcMjo3WHLNHn+L1AOoX8DmnRnEjfnt1oFPGYwz
 qguBpcK0xA6gQiVNqZKgoNwld6GdPCaOPpjPyuYMmxl2dvWZFr9E+eJ9jP/cQYrQSWcAIwRHDTx
 ix+OiiHSJrwiJgR+ZdmTuAWj/edZbIsCQgW38OI38auyXZxf2Zh9JsnJQlMU69C9dlyxmQ5YSC/
 DK1H3ocUI5oKDhM=
X-Google-Smtp-Source: AGHT+IH4DUtk0f5fuhqap0s3zLrGN2cK0ZOCQqHKqvZMGgFDa1mv1pFj87J6AAYmhgQsHrfvHLcxcA==
X-Received: by 2002:a05:6a20:244e:b0:1e0:d4f4:5b39 with SMTP id
 adf61e73a8af0-1eb214caa0emr5688547637.24.1737134581339; 
 Fri, 17 Jan 2025 09:23:01 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba511a4sm2235950b3a.140.2025.01.17.09.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:23:00 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] qtest/libqos/pci: Enforce balanced iomap/unmap
Date: Sat, 18 Jan 2025 03:22:41 +1000
Message-ID: <20250117172244.406206-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117172244.406206-1-npiggin@gmail.com>
References: <20250117172244.406206-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
index a0487a1557d..5d7e26aee2a 100644
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
index 83896145235..9dc82ea723a 100644
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
index f5115cacba2..efdf904b254 100644
--- a/tests/qtest/libqos/virtio-pci.h
+++ b/tests/qtest/libqos/virtio-pci.h
@@ -26,6 +26,7 @@ typedef struct QVirtioPCIDevice {
     uint64_t config_msix_addr;
     uint32_t config_msix_data;
 
+    bool enabled;
     int bar_idx;
 
     /* VIRTIO 1.0 */
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5a1923f721b..b3dae7a8ce4 100644
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
index 34a75b7f43b..cfc435b6663 100644
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
index a59197b9922..05089a5f24f 100644
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
@@ -529,6 +534,8 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
     uint64_t loc;
 
     g_assert(barno >= 0 && barno <= 5);
+    g_assert(!dev->bars_mapped[barno]);
+
     bar_reg = bar_reg_map[barno];
 
     qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
@@ -572,12 +579,35 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
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
index 485b8f6b7e0..2b59fb181c9 100644
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


