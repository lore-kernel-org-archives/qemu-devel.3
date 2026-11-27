Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA799606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=wkH89vFc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp1C-0002bF-4h; Fri, 27 Nov 2026 01:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0Q-0001Lh-98; Fri, 27 Nov 2026 01:00:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0K-0000N7-Ts; Fri, 27 Nov 2026 01:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=HU/JGr9pQhBuAjtmhLAn7nSdxLERsVJV7C7AKO1THZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wkH89vFcJbSGfl5pcOl0CO6y8u1OZtkXX0oTTTKnRAm2h8jQjnxYEpoq6fCBaAZ+c
 4joNsGrK1eORWlYEYiOKcvUZFC9EvvGRzG+1DCN/Mn1ehvrwlC8WvZPmfvGBEV5mAC
 jpSNodwVYwAGPJby3T6yTcEHYlwS217oTOYcTmKAp/2PC9s5IneSUSeh6C9altsuZd
 RlX52nIGw9DhdmscUJ8DEamErxvAHCLpeZedAkWrU0W4OAWQhHvhPc0fXsEUtjgM3y
 Yud2nKAsbZ/xvHOQ06lwTksO3uezRQeSPbnpS587uXt5RpBDUV3NQrJATAgaAyD3nT
 veMOcIL/LjhIA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F8941EA304;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8CFAB46993E;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8327FCF288; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 VictorCHEN <ahchen-yz@outlook.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 121/140] hw/net/rtl8139: Limit DMA transfers to
 plain memory
Date: Fri, 27 Nov 2026 08:53:47 +0300
Message-ID: <20261127055421.39015-62-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

There's no reason for the RTL8139 to be doing a DMA transfer to
something that isn't memory, and allowing it can cause weird
re-entrancy problems, such as a DMA to the PCI hot-unplug register
causing the device to be deleted while it's halfway through doing
something.

Replace the calls to pci_dma_read() and pci_dma_write() with
local functions that are identical except that they pass
a MemTxAttrs that forbids non-memory accesses.

This is the same approach we took to a similar problem with
the hcd-xhci USB controller in commit 89e653b7736 (but differs
from what we did for lsi53c895a in commit 4862d2c95104d).

The known trigger for this bug requires that you turned off
ACPI hotplug on the QEMU commandline with
  -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
so most configurations won't run into it.

Cc: qemu-stable@nongnu.org
Fixes: 3ada003aee2004d24f2 ("rtl8139: Use PCI DMA stub functions")
Fixes: CVE-2026-128868
Reported-by: VictorCHEN <ahchen-yz@outlook.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261113165015.1150646-1-peter.maydell@linaro.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 4ffa12178cfb6122f86a628ad0031afce8af2f68)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 4936dc0b82c..7e191cf390f 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -512,6 +512,28 @@ struct RTL8139State {
     int rtl8139_mmio_io_addr_dummy;
 };
 
+/*
+ * There's no reason for the RTL8139 to do DMA to something that
+ * isn't memory, and it can cause weird re-entrancy problems if e.g.
+ * a DMA write targets the PCI hot-unplug register for the device.
+ * Set memory=1 in the memory attributes to avoid that kind of thing.
+ */
+static MemTxResult rtl8139_dma_write(PCIDevice *dev, dma_addr_t addr,
+                                     const void *buf, dma_addr_t len)
+{
+    const MemTxAttrs attrs = { .memory = true };
+    return pci_dma_rw(dev, addr, (void *)buf, len,
+                      DMA_DIRECTION_FROM_DEVICE, attrs);
+}
+
+static inline MemTxResult rtl8139_dma_read(PCIDevice *dev, dma_addr_t addr,
+                                           void *buf, dma_addr_t len)
+{
+    const MemTxAttrs attrs = { .memory = true };
+    return pci_dma_rw(dev, addr, buf, len,
+                      DMA_DIRECTION_TO_DEVICE, attrs);
+}
+
 /* Writes tally counters to memory via DMA */
 static void RTL8139TallyCounters_dma_write(RTL8139State *s, dma_addr_t tc_addr);
 
@@ -755,15 +777,15 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
 
             if (size > wrapped)
             {
-                pci_dma_write(d, s->RxBuf + s->RxBufAddr,
-                              buf, size-wrapped);
+                rtl8139_dma_write(d, s->RxBuf + s->RxBufAddr,
+                                  buf, size - wrapped);
             }
 
             /* reset buffer pointer */
             s->RxBufAddr = 0;
 
-            pci_dma_write(d, s->RxBuf + s->RxBufAddr,
-                          buf + (size-wrapped), wrapped);
+            rtl8139_dma_write(d, s->RxBuf + s->RxBufAddr,
+                              buf + (size - wrapped), wrapped);
 
             s->RxBufAddr = wrapped;
 
@@ -772,7 +794,7 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
     }
 
     /* non-wrapping path or overwrapping enabled */
-    pci_dma_write(d, s->RxBuf + s->RxBufAddr, buf, size);
+    rtl8139_dma_write(d, s->RxBuf + s->RxBufAddr, buf, size);
 
     s->RxBufAddr += size;
 }
@@ -969,13 +991,13 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
 
         uint32_t val, rxdw0,rxdw1,rxbufLO,rxbufHI;
 
-        pci_dma_read(d, cplus_rx_ring_desc, &val, 4);
+        rtl8139_dma_read(d, cplus_rx_ring_desc, &val, 4);
         rxdw0 = le32_to_cpu(val);
-        pci_dma_read(d, cplus_rx_ring_desc+4, &val, 4);
+        rtl8139_dma_read(d, cplus_rx_ring_desc + 4, &val, 4);
         rxdw1 = le32_to_cpu(val);
-        pci_dma_read(d, cplus_rx_ring_desc+8, &val, 4);
+        rtl8139_dma_read(d, cplus_rx_ring_desc + 8, &val, 4);
         rxbufLO = le32_to_cpu(val);
-        pci_dma_read(d, cplus_rx_ring_desc+12, &val, 4);
+        rtl8139_dma_read(d, cplus_rx_ring_desc + 12, &val, 4);
         rxbufHI = le32_to_cpu(val);
 
         DPRINTF("+++ C+ mode RX descriptor %d %08x %08x %08x %08x\n",
@@ -1038,12 +1060,12 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
 
         /* receive/copy to target memory */
         if (dot1q_buf) {
-            pci_dma_write(d, rx_addr, buf, 2 * ETH_ALEN);
-            pci_dma_write(d, rx_addr + 2 * ETH_ALEN,
-                          buf + 2 * ETH_ALEN + VLAN_HLEN,
-                          size - 2 * ETH_ALEN);
+            rtl8139_dma_write(d, rx_addr, buf, 2 * ETH_ALEN);
+            rtl8139_dma_write(d, rx_addr + 2 * ETH_ALEN,
+                              buf + 2 * ETH_ALEN + VLAN_HLEN,
+                              size - 2 * ETH_ALEN);
         } else {
-            pci_dma_write(d, rx_addr, buf, size);
+            rtl8139_dma_write(d, rx_addr, buf, size);
         }
 
         if (s->CpCmd & CPlusRxChkSum)
@@ -1053,7 +1075,7 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
 
         /* write checksum */
         val = cpu_to_le32(crc32(0, buf, size_));
-        pci_dma_write(d, rx_addr+size, (uint8_t *)&val, 4);
+        rtl8139_dma_write(d, rx_addr + size, (uint8_t *)&val, 4);
 
 /* first segment of received packet flag */
 #define CP_RX_STATUS_FS (1<<29)
@@ -1099,9 +1121,9 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
 
         /* update ring data */
         val = cpu_to_le32(rxdw0);
-        pci_dma_write(d, cplus_rx_ring_desc, (uint8_t *)&val, 4);
+        rtl8139_dma_write(d, cplus_rx_ring_desc, (uint8_t *)&val, 4);
         val = cpu_to_le32(rxdw1);
-        pci_dma_write(d, cplus_rx_ring_desc+4, (uint8_t *)&val, 4);
+        rtl8139_dma_write(d, cplus_rx_ring_desc + 4, (uint8_t *)&val, 4);
 
         /* update tally counter */
         ++s->tally_counters.RxOk;
@@ -1298,43 +1320,43 @@ static void RTL8139TallyCounters_dma_write(RTL8139State *s, dma_addr_t tc_addr)
     uint64_t val64;
 
     val64 = cpu_to_le64(tally_counters->TxOk);
-    pci_dma_write(d, tc_addr + 0,     (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 0,     (uint8_t *)&val64, 8);
 
     val64 = cpu_to_le64(tally_counters->RxOk);
-    pci_dma_write(d, tc_addr + 8,     (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 8,     (uint8_t *)&val64, 8);
 
     val64 = cpu_to_le64(tally_counters->TxERR);
-    pci_dma_write(d, tc_addr + 16,    (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 16,    (uint8_t *)&val64, 8);
 
     val32 = cpu_to_le32(tally_counters->RxERR);
-    pci_dma_write(d, tc_addr + 24,    (uint8_t *)&val32, 4);
+    rtl8139_dma_write(d, tc_addr + 24,    (uint8_t *)&val32, 4);
 
     val16 = cpu_to_le16(tally_counters->MissPkt);
-    pci_dma_write(d, tc_addr + 28,    (uint8_t *)&val16, 2);
+    rtl8139_dma_write(d, tc_addr + 28,    (uint8_t *)&val16, 2);
 
     val16 = cpu_to_le16(tally_counters->FAE);
-    pci_dma_write(d, tc_addr + 30,    (uint8_t *)&val16, 2);
+    rtl8139_dma_write(d, tc_addr + 30,    (uint8_t *)&val16, 2);
 
     val32 = cpu_to_le32(tally_counters->Tx1Col);
-    pci_dma_write(d, tc_addr + 32,    (uint8_t *)&val32, 4);
+    rtl8139_dma_write(d, tc_addr + 32,    (uint8_t *)&val32, 4);
 
     val32 = cpu_to_le32(tally_counters->TxMCol);
-    pci_dma_write(d, tc_addr + 36,    (uint8_t *)&val32, 4);
+    rtl8139_dma_write(d, tc_addr + 36,    (uint8_t *)&val32, 4);
 
     val64 = cpu_to_le64(tally_counters->RxOkPhy);
-    pci_dma_write(d, tc_addr + 40,    (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 40,    (uint8_t *)&val64, 8);
 
     val64 = cpu_to_le64(tally_counters->RxOkBrd);
-    pci_dma_write(d, tc_addr + 48,    (uint8_t *)&val64, 8);
+    rtl8139_dma_write(d, tc_addr + 48,    (uint8_t *)&val64, 8);
 
     val32 = cpu_to_le32(tally_counters->RxOkMul);
-    pci_dma_write(d, tc_addr + 56,    (uint8_t *)&val32, 4);
+    rtl8139_dma_write(d, tc_addr + 56,    (uint8_t *)&val32, 4);
 
     val16 = cpu_to_le16(tally_counters->TxAbt);
-    pci_dma_write(d, tc_addr + 60,    (uint8_t *)&val16, 2);
+    rtl8139_dma_write(d, tc_addr + 60,    (uint8_t *)&val16, 2);
 
     val16 = cpu_to_le16(tally_counters->TxUndrn);
-    pci_dma_write(d, tc_addr + 62,    (uint8_t *)&val16, 2);
+    rtl8139_dma_write(d, tc_addr + 62,    (uint8_t *)&val16, 2);
 }
 
 static void rtl8139_ChipCmd_write(RTL8139State *s, uint32_t val)
@@ -1817,7 +1839,7 @@ static int rtl8139_transmit_one(RTL8139State *s, int descriptor)
     DPRINTF("+++ transmit reading %d bytes from host memory at 0x%08x\n",
         txsize, s->TxAddr[descriptor]);
 
-    pci_dma_read(d, s->TxAddr[descriptor], txbuffer, txsize);
+    rtl8139_dma_read(d, s->TxAddr[descriptor], txbuffer, txsize);
 
     /* Mark descriptor as transferred */
     s->TxStatus[descriptor] |= TxHostOwns;
@@ -1893,13 +1915,13 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
 
     uint32_t val, txdw0,txdw1,txbufLO,txbufHI;
 
-    pci_dma_read(d, cplus_tx_ring_desc,    (uint8_t *)&val, 4);
+    rtl8139_dma_read(d, cplus_tx_ring_desc, (uint8_t *)&val, 4);
     txdw0 = le32_to_cpu(val);
-    pci_dma_read(d, cplus_tx_ring_desc+4,  (uint8_t *)&val, 4);
+    rtl8139_dma_read(d, cplus_tx_ring_desc + 4, (uint8_t *)&val, 4);
     txdw1 = le32_to_cpu(val);
-    pci_dma_read(d, cplus_tx_ring_desc+8,  (uint8_t *)&val, 4);
+    rtl8139_dma_read(d, cplus_tx_ring_desc + 8, (uint8_t *)&val, 4);
     txbufLO = le32_to_cpu(val);
-    pci_dma_read(d, cplus_tx_ring_desc+12, (uint8_t *)&val, 4);
+    rtl8139_dma_read(d, cplus_tx_ring_desc + 12, (uint8_t *)&val, 4);
     txbufHI = le32_to_cpu(val);
 
     DPRINTF("+++ C+ mode TX descriptor %d %08x %08x %08x %08x\n", descriptor,
@@ -1993,8 +2015,8 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
             DMA_ADDR_FMT" to offset %d\n", txsize, tx_addr,
             s->cplus_txbuffer_offset);
 
-    pci_dma_read(d, tx_addr,
-                 s->cplus_txbuffer + s->cplus_txbuffer_offset, txsize);
+    rtl8139_dma_read(d, tx_addr,
+                     s->cplus_txbuffer + s->cplus_txbuffer_offset, txsize);
     s->cplus_txbuffer_offset += txsize;
 
     /* seek to next Rx descriptor */
@@ -2024,7 +2046,7 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
 
     /* update ring data */
     val = cpu_to_le32(tx_status);
-    pci_dma_write(d, cplus_tx_ring_desc, (uint8_t *)&val, 4);
+    rtl8139_dma_write(d, cplus_tx_ring_desc, (uint8_t *)&val, 4);
 
     /* Now decide if descriptor being processed is holding the last segment of packet */
     if (txdw0 & CP_TX_LS)
-- 
2.47.3


