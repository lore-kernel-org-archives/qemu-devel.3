Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142F5C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfR-0004gY-7a; Wed, 26 Aug 2026 07:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfN-0004Wn-FK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:37 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfK-0005jq-8Q
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:37 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so1531450a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743172; x=1788347972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gCAdMlliwaTOQ8SN/agGDNBF/I8r2ygm3SMyD16FGPc=;
 b=J6ug2lrA9cKdIKqjR+45506uGGxffoskxjPXgynMMhsqIPKqF1XHdVDC0NMDE/E0Ux
 p0kcGvK1cb3GYl/Ac2aS2eM2S50zSM+FGi1BiZOJVU5BzjAa/ocfVFFTqhHyz92wIanS
 ZQ2HLOmxfvrjw2vCAqTVcugbE6W0b4TLOeovqt0ZREBuwB7LSgwja5FwDf4vGjRJtFyP
 cHn6z80UMhCA78pcUHOmbAevwbLlcziyVJ9ktIqxo78j9ebCbL1BKRA9u143AamC99JN
 mkY0v0xKx1igecAuNvqMNh43PYS5FI49rF7KD/EJA3eY3frgQe4a9S/ZQtbbDB9EWwBM
 mzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743172; x=1788347972;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gCAdMlliwaTOQ8SN/agGDNBF/I8r2ygm3SMyD16FGPc=;
 b=bir31aray0KqIUHDfzLXKwC5eDewwE/Zrmqf190SuatT7DTwY0vz6Xfr40e3anUvCP
 zA7yZgZ+VoX14+qptxBn1J3AixQKakukowJfDDIeFOzRLdEpxRGzx08KGqoTk5K/b4Dd
 KJ7q1mbxjAoCpwsnKeDyUT7KA/nDJQVfQeIwUbWjqdKnSw78g8XiGyDasjzSST3hRtEQ
 qHspcKTYbFE8WP1vrRILMvC3F/ImRFBPFkFz7+9qakg6uzNGH+FK2eiJ82UwqvxbRout
 WdW0vuK7WQsGEqX1O5fB12FAumadncjf+Hs+hGIMnehDDezcoc0aC3CJz2IWIMRp47L8
 /62w==
X-Gm-Message-State: AFuF++mqiBJGHWPJhJV9TbZQ+fs8yI8GxJI/grMywDrsvxozb/QofOxv
 pK1ESxognH25TIH5gErbY2Jly/Wr5bSXB7o0fxxYiocNfjb4ROtS3o6pMIRXSs4Nhv+kVXmlYag
 BQ/4D
X-Gm-Gg: AR+sD13fF8x3LgWg/LkYOT9V4SXdU9I5lFqTWFgd7sQRlhCv1qNuczN/sdasbkeUKz6
 awLUOXR82+SVGdSZgfaFWO99MC8Ix5/JuL75ac3R1Mbzoj6EXBpc8N3eiSiTZEx7xvXxC0VF4Fr
 9xu549e8SVDI10KhnubDMMQCa8v+DN60EzftvBK1fvL/5BdsSjh9RCU+03LFjDQVdxa24HNFp4B
 yw/04Q8wkSsSd9sKtp4Sz03fY7oTQG6v7G2VLFGciSifAFUy307IdkjM4qTKe6qeteaGNYH0pzX
 Z48K8MIk+INCuLTiWgSbNlBfTHOebNw/Q/MUyoTjSFNAmoGU7X2EroJslLiyLUCIE8nejP1djSI
 npy1sn+KPDvAShhEkQ3TlOYCesH7g8YbhG9Nk8RJKfmWSjcmb/JVQQJ8w5zY4EukSJJXEoUTSI2
 vz7WU2mPXeK87O8yoxuky36uTezM12qdfW3bMfFAFupTnCbPXC8Q==
X-Received: by 2002:a05:6402:21dc:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a5df6089b6mr6875106a12.4.1787743172421; 
 Wed, 26 Aug 2026 04:19:32 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:31 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 20/28] hw/ide/ahci: refuse a PIO transfer with no command header
Date: Wed, 26 Aug 2026 13:19:07 +0200
Message-ID: <20260826111915.3387926-11-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=den@openvz.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

ahci_map_clb_address() already clears cur_cmd, so every consumer of it
has to cope with there being no current command. ahci_pio_transfer(),
ahci_commit_buf() and ahci_populate_sglist() all dereference it
unconditionally instead.

Give the three of them a NULL check. Declaring the data transferred
anyway is not enough: ide_transfer_start() goes on to call the end
transfer function, and for a multi-sector write that is
ide_sector_write(), which commits an io_buffer the guest never
refilled. Clearing PxCMD.ST during a WRITE SECTOR(S) of two sectors
therefore writes the first sector's contents over the second, at a
sector the guest chose.

Let pio_transfer report that nothing was transferred and halt there, so
no callback acts on a buffer that was never filled. Only the AHCI HBA
implements the callback, so the signature change is local to it.

Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/ahci.c            | 47 +++++++++++++++++++++++++++++++---------
 hw/ide/core.c            | 11 +++++++++-
 hw/ide/trace-events      |  2 ++
 include/hw/ide/ide-dma.h |  3 ++-
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 49f3047e6f..995b40efd5 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -906,12 +906,12 @@ static int prdt_tbl_entry_size(const AHCI_SG *tbl)
 static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
                                 AHCICmdHdr *cmd, int64_t limit, uint64_t offset)
 {
-    uint16_t opts = le16_to_cpu(cmd->opts);
-    uint16_t prdtl = le16_to_cpu(cmd->prdtl);
-    uint64_t cfis_addr = le64_to_cpu(cmd->tbl_addr);
-    uint64_t prdt_addr = cfis_addr + 0x80;
-    dma_addr_t prdt_len = (prdtl * sizeof(AHCI_SG));
-    dma_addr_t real_prdt_len = prdt_len;
+    uint16_t opts;
+    uint16_t prdtl;
+    uint64_t cfis_addr;
+    uint64_t prdt_addr;
+    dma_addr_t prdt_len;
+    dma_addr_t real_prdt_len;
     uint8_t *prdt;
     int i;
     int r = 0;
@@ -923,6 +923,18 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
 
     trace_ahci_populate_sglist(ad->hba, ad->port_no);
 
+    if (!cmd) {
+        trace_ahci_populate_sglist_no_cmd(ad->hba, ad->port_no);
+        return -1;
+    }
+
+    opts = le16_to_cpu(cmd->opts);
+    prdtl = le16_to_cpu(cmd->prdtl);
+    cfis_addr = le64_to_cpu(cmd->tbl_addr);
+    prdt_addr = cfis_addr + 0x80;
+    prdt_len = (prdtl * sizeof(AHCI_SG));
+    real_prdt_len = prdt_len;
+
     if (!prdtl) {
         trace_ahci_populate_sglist_no_prdtl(ad->hba, ad->port_no, opts);
         return -1;
@@ -1371,18 +1383,27 @@ out:
 }
 
 /* Transfer PIO data between RAM and device */
-static void ahci_pio_transfer(const IDEDMA *dma)
+static bool ahci_pio_transfer(const IDEDMA *dma)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
     IDEState *s = &ad->port.ifs[0];
     uint32_t size = (uint32_t)(s->data_end - s->data_ptr);
     /* write == ram -> device */
-    uint16_t opts = le16_to_cpu(ad->cur_cmd->opts);
-    int is_write = opts & AHCI_CMD_WRITE;
-    int is_atapi = opts & AHCI_CMD_ATAPI;
+    uint16_t opts;
+    int is_write;
+    int is_atapi;
     int has_sglist = 0;
     bool pio_fis_i;
 
+    if (ad->cur_cmd == NULL) {
+        trace_ahci_pio_transfer_no_cmd(ad->hba, ad->port_no);
+        return false;
+    }
+
+    opts = le16_to_cpu(ad->cur_cmd->opts);
+    is_write = opts & AHCI_CMD_WRITE;
+    is_atapi = opts & AHCI_CMD_ATAPI;
+
     /* The PIO Setup FIS is received prior to transfer, but the interrupt
      * is only triggered after data is received.
      *
@@ -1430,6 +1451,8 @@ out:
     if (pio_fis_i) {
         ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_PSS);
     }
+
+    return true;
 }
 
 static void ahci_start_dma(const IDEDMA *dma, IDEState *s,
@@ -1492,6 +1515,10 @@ static void ahci_commit_buf(const IDEDMA *dma, uint32_t tx_bytes)
 {
     AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
 
+    if (ad->cur_cmd == NULL) {
+        return;
+    }
+
     tx_bytes += le32_to_cpu(ad->cur_cmd->status);
     ad->cur_cmd->status = cpu_to_le32(tx_bytes);
 }
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 0dca2b5c52..06c18dbf09 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -80,6 +80,7 @@ static const char *IDE_DMA_CMD_str(enum ide_dma_cmd enval)
 }
 
 static void ide_dummy_transfer_stop(IDEState *s);
+static void ide_transfer_halt(IDEState *s);
 
 const MemoryRegionPortio ide_portio_list[] = {
     { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
@@ -568,7 +569,15 @@ bool ide_transfer_start_norecurse(IDEState *s, uint8_t *buf, int size,
         s->end_transfer_func = end_transfer_func;
         return false;
     }
-    s->bus->dma->ops->pio_transfer(s->bus->dma);
+    if (!s->bus->dma->ops->pio_transfer(s->bus->dma)) {
+        /*
+         * No data reached the buffer, so the caller must not act on it. A
+         * write would otherwise commit whatever the previous phase left
+         * there to the next sector.
+         */
+        ide_transfer_halt(s);
+        return false;
+    }
     return true;
 }
 
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 57042cafdd..f1472f5852 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -85,6 +85,7 @@ ahci_reset_port(void *s, int port) "ahci(%p)[%d]: reset port"
 ahci_unmap_fis_address_null(void *s, int port) "ahci(%p)[%d]: Attempt to unmap NULL FIS address"
 ahci_unmap_clb_address_null(void *s, int port) "ahci(%p)[%d]: Attempt to unmap NULL CLB address"
 ahci_populate_sglist(void *s, int port) "ahci(%p)[%d]"
+ahci_populate_sglist_no_cmd(void *s, int port) "ahci(%p)[%d]: no command header"
 ahci_populate_sglist_no_prdtl(void *s, int port, uint16_t opts) "ahci(%p)[%d]: no sg list given by guest: 0x%04x"
 ahci_populate_sglist_no_map(void *s, int port) "ahci(%p)[%d]: DMA mapping failed"
 ahci_populate_sglist_short_map(void *s, int port) "ahci(%p)[%d]: mapped less than expected"
@@ -109,6 +110,7 @@ handle_cmd_badfis(void *s, int port) "ahci(%p)[%d]: guest provided an invalid cm
 handle_cmd_badmap(void *s, int port, uint64_t len) "ahci(%p)[%d]: dma_memory_map failed, 0x%02"PRIx64" != 0x80"
 handle_cmd_unhandled_fis(void *s, int port, uint8_t b0, uint8_t b1, uint8_t b2) "ahci(%p)[%d]: unhandled FIS type. cmd_fis: 0x%02x-%02x-%02x"
 ahci_pio_transfer(void *s, int port, const char *rw, uint32_t size, const char *tgt, const char *sgl) "ahci(%p)[%d]: %sing %d bytes on %s w/%s sglist"
+ahci_pio_transfer_no_cmd(void *s, int port) "ahci(%p)[%d]: PIO transfer without a command header"
 ahci_start_dma(void *s, int port) "ahci(%p)[%d]: start dma"
 ahci_dma_prepare_buf(void *s, int port, int32_t io_buffer_size, int32_t limit) "ahci(%p)[%d]: prepare buf limit=%"PRId32" prepared=%"PRId32
 ahci_dma_prepare_buf_fail(void *s, int port) "ahci(%p)[%d]: sglist population failed"
diff --git a/include/hw/ide/ide-dma.h b/include/hw/ide/ide-dma.h
index 296010a4e0..34154b7cbc 100644
--- a/include/hw/ide/ide-dma.h
+++ b/include/hw/ide/ide-dma.h
@@ -10,6 +10,7 @@ typedef struct IDEDMA IDEDMA;
 
 typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
 typedef void DMAVoidFunc(const IDEDMA *);
+typedef bool DMABoolFunc(const IDEDMA *);
 typedef int DMAIntFunc(const IDEDMA *, bool);
 typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
 typedef void DMAu32Func(const IDEDMA *, uint32_t);
@@ -17,7 +18,7 @@ typedef void DMAStopFunc(const IDEDMA *, bool);
 
 struct IDEDMAOps {
     DMAStartFunc *start_dma;
-    DMAVoidFunc *pio_transfer;
+    DMABoolFunc *pio_transfer;
     DMAInt32Func *prepare_buf;
     DMAu32Func *commit_buf;
     DMAIntFunc *rw_buf;
-- 
2.53.0


