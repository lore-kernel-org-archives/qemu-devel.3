Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75959D5C0ED
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R8Q-0002Fv-TF; Fri, 08 Nov 2024 10:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8P-0002Ck-Ds
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:53 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8N-0005Hd-Od
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:53 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-288d70788d6so1117975fac.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731080570; x=1731685370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjZQkS7NlGSMkoZpKFfXMBWMv1VZGQCZ11MhEVoVebk=;
 b=eb4UyjGqktgHerF9D+cZPgXHodI13T+HXH0GtrZA8CYbL99eI0IMWwgYhjs+Pvy2Jh
 dJD8tE9C/zC1m5ZXG+mnwcKDYLnuGpdw4OkznK9461td8MMgtQrIZmKFt6XDgdxXOFmH
 S1dVszapsqA5xt1v6GpHZu3nqQmHuQt9dmVn21rpWTienNefw0QFk+X5rfH2B6X7i7BY
 wapqJ0ACzVPM64dL7qXhYe8huXi32tY/UIDk5L6WWauHaSW4+Xfj1X6aCicYjL48ja/I
 LPcUGcqgYyvOW1dJCAh1Tyn9Epd/O8sTYjEDmt5j5F4qPvmDslp7jrT1gHpfj/uE9U0o
 dF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080570; x=1731685370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjZQkS7NlGSMkoZpKFfXMBWMv1VZGQCZ11MhEVoVebk=;
 b=DD23dJKlRRHJu+mqfBVSV4QxjbdVR0dwmCpJiWwGoNkS4bbECyT6Vg2e9fcAnZa5wI
 Hb8O1Ox85mn3dSVwnxU1qjumfMMQocZKPSRCAfWvzkosiVCINPAOqTjjcU9kSMkn7J2H
 7075tjzmzpi/E2RK2SqawoxBDBkzB3/oq3/sJgYpMZICWBnO1XPiqZqssCjUftDCCab8
 Urziv+pG8hmy7uVKLnyv5AeigLnpwiP47lJ2Zm8SxczGbPnF7akQOeMJgq/9KRvZq+9G
 UOMLwJhz0wWfOCSZiCvl8Di/WgimLgVn6dGKGbBBN58pvdF5DINIT5TnV/PrbNRNE8qU
 neKg==
X-Gm-Message-State: AOJu0Yz959kyIS7RzPINnp/BG2yoB0XwXxdPPgIDEY6f6vz0sEs/d4NT
 7YAnN3ej8gH9QbKxe3PWkLqUQp8/IWi/OIE5acWF1Y+ku4tCWzfEzSU8JA==
X-Google-Smtp-Source: AGHT+IEdWy59ywOfVbsBRmId44Ktn5Mjpu81dl5SV+t76TNTxXv4r4Rb3l019CY2HXaBlrI52Ejpng==
X-Received: by 2002:a05:6870:e0d4:b0:260:f43e:7d89 with SMTP id
 586e51a60fabf-2956000774dmr3598139fac.2.1731080569893; 
 Fri, 08 Nov 2024 07:42:49 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f48d32bsm3110444a12.17.2024.11.08.07.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:42:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 3/5] pci/msix: Implement PBA writes
Date: Sat,  9 Nov 2024 01:42:26 +1000
Message-ID: <20241108154229.263097-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154229.263097-1-npiggin@gmail.com>
References: <20241108154229.263097-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2a.google.com
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

Implement PBA write 1 to trigger and 0 to clear. This is used by
qtests which mask the MSI irq and so the bits remain pending and
expect to be cleared with stores.

Some devices like e1000e seem to have MSIX PBA pending tied to
some device state level, as such they call msix_clr_pending()
directly, and clearing pending via a store to PBA causes this
to go out of synch. So the qpci_msix_pending() function is
changed to avoid clearing, and a new test-and-clear function is
added for tests that would like to clear.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h |  1 +
 hw/pci/msix.c            | 16 ++++++++++++++++
 tests/qtest/libqos/pci.c | 21 ++++++++++++++++++---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 5a7b2454ad..de540f7803 100644
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
index 487e49834e..b16b03b888 100644
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
index 45199c7dc4..6726c401cc 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -343,11 +343,26 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 
     g_assert(dev->msix_enabled);
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
-    qpci_io_writel(dev, dev->msix_pba_bar, dev->msix_pba_off + off,
-                   pba_entry & ~(1 << bit_n));
-    return (pba_entry & (1 << bit_n)) != 0;
+    return (pba_entry & (1 << bit_n));
 }
 
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
+}
+
+
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
 {
     uint8_t addr;
-- 
2.45.2


