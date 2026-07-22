Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2443C4453E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWWL-0006Yn-6h; Wed, 22 Jul 2026 08:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWUV-0003DZ-8Y; Wed, 22 Jul 2026 08:56:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWUT-0003Qy-3T; Wed, 22 Jul 2026 08:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=lQAE9nuvOimPgePIS01y9p0O4ucc3VvnYzHOzunr/sw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gJNnnuT+g0+jOwVRBmCPBLs1DK6jA5RbcLEwLeIJzDN+auT6lkJftmKMMbmCEp/81
 RhEPOb0/M0d+6Ip/k+S4y8ZFj1uVq+P63GBCzCpVQk2yjSmKkhzTCT8AZf931WmOdI
 Mk4q59u1h6OesxMLgvhpsiVXMtEWBIBuR8o84etMdjyD60L9rNWy+pQ8Ytd2sm9mBD
 SuCEgHxqUZN9YPSiAq8d6dtqAmvpuQ34nvWnt5qDqO55dNs4IhXHMOcpA4pqxIF78+
 Q2bxWYE6Sw/3smqBat2XmiiUPXMK5PmD+kK58++WY/nTLrjBmTywhjdyTPOegcpVsJ
 88R8XN5MVPZ/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B06B1C3B5D;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C42113F37AC;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0AE0917F8D; Wed, 22 Jul 2026 15:49:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Haotian Jiang <jianghaotian.sunday@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 127/127] hw/audio/intel-hda: restrict all DMA
 engine paths to memories
Date: Wed, 22 Jul 2026 15:48:52 +0300
Message-ID: <20260722124859.32371-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

CVE-2021-3611 (commit 79fa99831d) restricted the DMA engine to memories
by setting attrs.memory=true, but only applied this to intel_hda_response.
Three other DMA engine access points still use MEMTXATTRS_UNSPECIFIED,
allowing a malicious guest to trigger DMA-to-self-MMIO reentry:

  - intel_hda_xfer (line 398): called from the audio timer callback
    (hda_codec_xfer -> bus->xfer), so the MemReentrancyGuard does not
    fire (engaged_in_io is false outside MMIO dispatch). A guest that
    points a BDL entry at the HDA controller's own MMIO BAR can write
    audio samples to device registers, triggering whandler side effects
    such as starting/stopping streams or injecting codec commands via
    CORBWP.
  - intel_hda_parse_bdl (line 478): uses pci_dma_read which hardcodes
    MEMTXATTRS_UNSPECIFIED. A guest-controlled BDL base address can
    point at controller MMIO, allowing the DMA engine to read device
    registers as BDL descriptors.
  - intel_hda_corb_run (line 333): ldl_le_pci_dma reads the CORB ring
    with MEMTXATTRS_UNSPECIFIED, allowing the DMA engine to read
    controller MMIO as CORB entries.

Fix all three by passing {.memory = true} explicitly, matching the
fix already applied to intel_hda_response. For intel_hda_parse_bdl,
replace pci_dma_read with pci_dma_rw to pass the controlled attrs.

Fixes: 79fa99831d ("hw/audio/intel-hda: Restrict DMA engine to memories (not MMIO devices)")
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721060941.2989396-1-jianghaotian.sunday@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit c257745248b02fd468619b4b1fdbbade5344191d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index d7c2c3c2fd4..3d361a4976c 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -305,6 +305,7 @@ static int intel_hda_send_command(IntelHDAState *d, uint32_t verb)
 
 static void intel_hda_corb_run(IntelHDAState *d)
 {
+    const MemTxAttrs attrs = { .memory = true };
     hwaddr addr;
     uint32_t rp, verb;
 
@@ -330,7 +331,7 @@ static void intel_hda_corb_run(IntelHDAState *d)
 
         rp = (d->corb_rp + 1) & 0xff;
         addr = intel_hda_addr(d->corb_lbase, d->corb_ubase);
-        ldl_le_pci_dma(&d->pci, addr + 4 * rp, &verb, MEMTXATTRS_UNSPECIFIED);
+        ldl_le_pci_dma(&d->pci, addr + 4 * rp, &verb, attrs);
         d->corb_rp = rp;
 
         dprint(d, 2, "%s: [rp 0x%x] verb 0x%08x\n", __func__, rp, verb);
@@ -395,7 +396,7 @@ static void intel_hda_response(HDACodecDevice *dev, bool solicited, uint32_t res
 static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
                            uint8_t *buf, uint32_t len)
 {
-    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    const MemTxAttrs attrs = { .memory = true };
     HDACodecBus *bus = HDA_BUS(dev->qdev.parent_bus);
     IntelHDAState *d = container_of(bus, IntelHDAState, codecs);
     hwaddr addr;
@@ -466,6 +467,7 @@ static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
 
 static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
 {
+    const MemTxAttrs attrs = { .memory = true };
     hwaddr addr;
     uint8_t buf[16];
     uint32_t i;
@@ -475,7 +477,8 @@ static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
     g_free(st->bpl);
     st->bpl = g_new(bpl, st->bentries);
     for (i = 0; i < st->bentries; i++, addr += 16) {
-        pci_dma_read(&d->pci, addr, buf, 16);
+        pci_dma_rw(&d->pci, addr, buf, 16,
+                   DMA_DIRECTION_TO_DEVICE, attrs);
         st->bpl[i].addr  = le64_to_cpu(*(uint64_t *)buf);
         st->bpl[i].len   = le32_to_cpu(*(uint32_t *)(buf + 8));
         st->bpl[i].flags = le32_to_cpu(*(uint32_t *)(buf + 12));
-- 
2.47.3


