Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78159C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 15:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54Fe-0006xF-GA; Wed, 16 Apr 2025 11:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54Et-0006cT-E3; Wed, 16 Apr 2025 10:59:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54En-000362-T4; Wed, 16 Apr 2025 10:59:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so7242151b3a.1; 
 Wed, 16 Apr 2025 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744815573; x=1745420373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JXU/iDoCeiLKmXbMmkzTXvAvxJfUqOqd0YNU9sN6g0=;
 b=jOg6i0YEbUkwubKDT53qJX4b1Fl3/TDhkyh8WZi9tn0Oj5fMxQYqPCGqWG9TZ4ENPy
 i2uSrWijG/icOYU0xC0ImOM4GMOd78gzuMfT2azeFRxTqRAHv8bxWHSDSiKtmfaBnzrW
 VAABXZz7mxpAwevrtpp+xbDHfGMKsb3x7olX1O/5LvcH7oVeiqxj8hrO0c+FTNp5Br/g
 PK6LstXhnF65Dt0tWTHKGvOB6ddUnR7kYvkmzmvQoBWTVsnowAGEc2phPTlCgT3/a51z
 4V8U7oIPJAUUvUqfAbxh7ZRIQydHeQl4/U1PICGR3uLFqx5Ey4bxo9vsoRIZE/5gYDQi
 yJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744815573; x=1745420373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JXU/iDoCeiLKmXbMmkzTXvAvxJfUqOqd0YNU9sN6g0=;
 b=aHHGeCi28+5cBRwNEjpQpGIUqf8z5duL9mb0VkHmo7R4kLOwtqcReb3BXHpzk4yIV9
 LE87/rB8N/MHppogmSN7gj2mdAt3OFGSriZKLyXtRS7dNznstI9P6PGtbjc7UQVjIgFy
 /MJK73q2VLYGkq3szZMckl8WZGchpUk1xop1K+NmA3sGTQNtooq1rsC3QR8N61GPEnQu
 Z4A/bRKYmBDeSmHzGHldp3mkI5aiJSmd8JvtZAJVR0YgM8J7SYrSjatkhF5ILRYLPBh3
 gsNO83r5/NMyvjiOleASJwkGwRI2tm4hM9loueW5KWsOhVV36UcUpya9y55ybc6h/4lv
 h0Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC1t/6bTgLmxM80Ttmk7dk5jA/DQosvhQ8ICxZCl6Cbx2grG0RSdtV9dLKhuiZXp7yAwzKY165+/E4Hg==@nongnu.org,
 AJvYcCWOt1EAS4oRDmKYFUUr06VZgbFL4H6PeCw+r8bnzzChC+EVlshqpXaqWkQ1p/bSIhzZxHxG23mNXQt/@nongnu.org
X-Gm-Message-State: AOJu0YzaIysDdNb2R/mYyG1qfehSIbOuo6P0j9ikoavlNAbZ6Xg2+oj/
 u/bbMlhRgUTHaOATSFX/xE1Jpu5E4gQT/HnZXkpl6ojotoOgBnuibojRLg==
X-Gm-Gg: ASbGncsIPDJ3antiW8piAXA7zk1vLPOH4PtyuiHMOcA0iKRWjzQvWDL2YUO1TvCv+bi
 k7jIfnkDcopNsVWR+g+0TJZ641qoOyhfXGRUpTxWKiHCusH6D6cOvIvB/iVhuufQWe9nEo23902
 N/0aKx/gi9JsKW9NssZhCdZ0AkCwSRCjOXzlG2dFA01vAIZyepfLkBhnDDxLpM1ZhskquK4ZjS5
 8ZvGqShxdKync7/q2z4/EufWHgFggrzCXUATZKNqJLpSR6NaJN/w7r3gkLulaBS7YyOyvm+Guds
 bnzg+U9QP8dsxnm5BRPeSHewc3QC0VNqeNG5Rcz7XLFi30LpC1Dt
X-Google-Smtp-Source: AGHT+IF+u0cVhMbMIfaTbtSM87tUe5zK1Q4kvmCdKt0MtnllTzQ0HUNCyrXZI7lNvG+2r33VEP7Imw==
X-Received: by 2002:a05:6a00:390f:b0:730:8a5b:6e61 with SMTP id
 d2e1a72fcca58-73c266b4473mr2695040b3a.2.1744815573179; 
 Wed, 16 Apr 2025 07:59:33 -0700 (PDT)
Received: from wheely.local0.net ([1.145.55.85])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e355sm10814506b3a.139.2025.04.16.07.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:59:32 -0700 (PDT)
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
Subject: [PATCH 1/4] tests/qtest: Enforce zero for the "un-fired" msix message
 value
Date: Thu, 17 Apr 2025 00:59:15 +1000
Message-ID: <20250416145918.415674-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250416145918.415674-1-npiggin@gmail.com>
References: <20250416145918.415674-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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


