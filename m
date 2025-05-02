Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D213AC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgi8-0001JG-BX; Thu, 01 May 2025 23:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgi3-0001HY-IG; Thu, 01 May 2025 23:05:08 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgi0-00085t-Py; Thu, 01 May 2025 23:05:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736c277331eso2626096b3a.1; 
 Thu, 01 May 2025 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155102; x=1746759902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JXU/iDoCeiLKmXbMmkzTXvAvxJfUqOqd0YNU9sN6g0=;
 b=Yt2OAVx70ptomdtIlhaRrark4bdrOHJmwrz/0q00hrbfBx6Ngl7ddmEUHnW1BKnNFG
 ZF3Il3z7fcASF7B3WnyPmWBRFOEKnOdQT5myScWpJSK26h6cRQjC3Q5GUL8k03+baHV/
 1QyOofRE7t54ktvU7Ft0IMOYvIQuD/1FRmjCPtDApsgflm4WjW3b3v4F+/XYBbya9DTh
 Rn0PeLJfCyK2aRFRsjkYdwoy1K/hI/NMR/CmKTa8L0fLlt4hvJnlp2DUCZ0i6v/S7TEb
 n6MZ0gO3qpuRcC83nQRylVWvhaqdflRnsZSHZlF1Z9BJYr9LSkrscSt3PL4Z0nEemwru
 AbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155102; x=1746759902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JXU/iDoCeiLKmXbMmkzTXvAvxJfUqOqd0YNU9sN6g0=;
 b=mv/4JtZqRIs/1bnx5UvBmP4+47qPIq++qYq6aBlgb178NGWgMGxvHEbmmjes2WFeQd
 cb3irSJmVtVLbMAtAwzhSZ2oswfddso+rTfpx9zH+ALwUAN6XN/SofYmfiychpkGwsvG
 tsFHwTwJyS0OgXOn05GwCEbTEde6zgnBJmEKHyPYhrn24dY2DaYqU+LZpGsgo0S5GxnS
 yjyVWWS3SgfaOhAuqPayCYhr7UTENu47s2IyoKHBb08tYmJo8B99rqCslWBtyDVhhzKb
 T4fLjGW4pUqh+I8XwnrVNgYiD5SxNMFHX5ebh6XszM1R/b+CMKOMnpO2b0pZsvIlOHgh
 3Vag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfnqZd1CdMWJun+KGkUJ3iTQbWmEJlBIPU0vDl7F/DrUMfFSwKmkajicOiQQxDu892G2q3f6zCdfMU@nongnu.org,
 AJvYcCX3rsClNuFticfMT1V1xyBew4pMaiCLGRsBB3s1Mrd4Qh94hYjLQ6Gz6Ntv/dfcKqQn3FuINoZErqU=@nongnu.org
X-Gm-Message-State: AOJu0Yz11pdKMzp2C8/LKXi8ku7zAmoJbVTM707lsiyP2rOBNMfPdvVD
 WrDFqQmpl6RlSovxwp+eEwxfdoMABLsKysWSG6adxC4UPml97wJ6A7GOCA==
X-Gm-Gg: ASbGncvTRdnJzktyirdtuYHOJMI0I7xpoK/ZmXuDnxVZb1+vXolJCggjCN+X+0PyJ0/
 /g7IEkE08HzV9iBNwYZ5DzynNs6d/OlTa2xdUIDTe4YzELxem9J5qPUg1fepIdwbxtHxAqW4EM7
 zMjrHspRPbvmEuSDIRnUK1/FD9LkfuPZ0T+L5fR0AyJg/MBdRj+7y3bT1rZ25CoWtpqYNtlwsik
 Xl7CSjGVYENr6vWfNgUaHycOnNNNglhfEZDAK8720I+5BqX7yr85SAlIDADK9gCEVCDnfrCBKRE
 rXeROUKiqqmN5F9me5A/q5vVvH+h6OR98QTZhL+6z65f
X-Google-Smtp-Source: AGHT+IE1TAhhAkAbMCCVRp0HJFL4kEabWfS6X3KcU09ld7Ry/K2Ij1Hsy0zzlqMy1lLIZMKGE5wsrA==
X-Received: by 2002:a05:6a21:8cc7:b0:1ee:b5f4:b1d7 with SMTP id
 adf61e73a8af0-20ccbf33d54mr2133540637.7.1746155101902; 
 Thu, 01 May 2025 20:05:01 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:01 -0700 (PDT)
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
Subject: [PATCH v5 01/11] tests/qtest: Enforce zero for the "un-fired" msix
 message value
Date: Fri,  2 May 2025 13:04:35 +1000
Message-ID: <20250502030446.88310-2-npiggin@gmail.com>
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

virtio-pci detects an unmasked msix interrupt has fired by looking
for the data payload value at the target address. If a value of zero
is enforced for the memory value when an interrupt has not fired,
then an assertion can be added to catch the case where something
changed the memory to an unexpected value.

This catches an endian conversion bug in the message value when
running these tests on a big endian target. Previously the test
just times out waiting for interrupt, after this it fails nicely.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/virtio-pci-modern.c |  9 +++++----
 tests/qtest/libqos/virtio-pci.c        | 20 ++++++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 4e67fcbd5d3..f31b3be656d 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -137,12 +137,13 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
     }
 
     data = qtest_readl(dev->pdev->bus->qts, msix_addr);
-    if (data == msix_data) {
-        qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
-        return true;
-    } else {
+    if (data == 0) {
         return false;
     }
+    /* got a message, ensure it matches expected value then clear it. */
+    g_assert_cmphex(data, ==, msix_data);
+    qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
+    return true;
 }
 
 static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 002bf8b8c2d..102e45b5248 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -132,12 +132,13 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
             data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
-            if (data == vqpci->msix_data) {
-                qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
-                return true;
-            } else {
+            if (data == 0) {
                 return false;
             }
+            /* got a message, ensure it matches expected value then clear it. */
+            g_assert_cmphex(data, ==, vqpci->msix_data);
+            qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
+            return true;
         }
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 1;
@@ -156,12 +157,13 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
             data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
-            if (data == dev->config_msix_data) {
-                qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
-                return true;
-            } else {
+            if (data == 0) {
                 return false;
             }
+            /* got a message, ensure it matches expected value then clear it. */
+            g_assert_cmphex(data, ==, dev->config_msix_data);
+            qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
+            return true;
         }
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 2;
@@ -323,6 +325,7 @@ void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
     vqpci->msix_entry = entry;
 
     vqpci->msix_addr = guest_alloc(alloc, 4);
+    qtest_memset(d->pdev->bus->qts, vqpci->msix_addr, 0, 4);
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
                    off + PCI_MSIX_ENTRY_LOWER_ADDR, vqpci->msix_addr & ~0UL);
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
@@ -355,6 +358,7 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
 
     d->config_msix_data = 0x12345678;
     d->config_msix_addr = guest_alloc(alloc, 4);
+    qtest_memset(d->pdev->bus->qts, d->config_msix_addr, 0, 4);
 
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
                    off + PCI_MSIX_ENTRY_LOWER_ADDR, d->config_msix_addr & ~0UL);
-- 
2.47.1


