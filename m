Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD6C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9P1-0001f1-Mw; Tue, 09 Jul 2024 07:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9P0-0001Wd-2D
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Op-0006aD-Vj
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jw7jEkCHrcZLyWCWBDwvgon0tb/macRlRtuKDB5qNaU=;
 b=LeP/ksYtkXE4FGAXAzJrCUhgCVNropUWEeGMa+fsYoe2ZiLyZwYEvUNhQHpIHyTXzIDxNV
 96957jB6dye9BKBSNPxtNgiL1VbhgXjkW1NsxpV/dNkxA4tRMidjAxWBFNTTEVtHEvzYUM
 nhkNxpguqjnm3uk65q4Gks4ha5jxK5k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-dHHRDGMbPx-nMyBKWQxcnA-1; Tue,
 09 Jul 2024 07:52:42 -0400
X-MC-Unique: dHHRDGMbPx-nMyBKWQxcnA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80DE41955F49; Tue,  9 Jul 2024 11:52:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FDCC3000183; Tue,  9 Jul 2024 11:52:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/8] hw/net:ftgmac100: update TX and RX packet buffers address
 to 64 bits
Date: Tue,  9 Jul 2024 13:52:24 +0200
Message-ID: <20240709115228.798904-5-clg@redhat.com>
In-Reply-To: <20240709115228.798904-1-clg@redhat.com>
References: <20240709115228.798904-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
And the base address of dram is "0x4 00000000" which
is 64bits address.

It have "TXDES 2" and "RXDES 2" to save the high part
physical address of packet buffer.
Ex: TX packet buffer address [34:0]
The "TXDES 2" bits [18:16] which corresponds the bits [34:32]
of the 64 bits address of the TX packet buffer address
and "TXDES 3" bits [31:0] which corresponds the bits [31:0]
of the 64 bits address of the TX packet buffer address.

Update TX and RX packet buffers address type to
64 bits for dram 64 bits address DMA support.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/ftgmac100.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 68956aeb94ae..80f9cd56d53f 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -175,6 +175,8 @@
 #define FTGMAC100_TXDES1_TX2FIC          (1 << 30)
 #define FTGMAC100_TXDES1_TXIC            (1 << 31)
 
+#define FTGMAC100_TXDES2_TXBUF_BADR_HI(x)   (((x) >> 16) & 0x7)
+
 /*
  * Receive descriptor
  */
@@ -208,13 +210,15 @@
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR  (1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR   (1 << 27)
 
+#define FTGMAC100_RXDES2_RXBUF_BADR_HI(x)   (((x) >> 16) & 0x7)
+
 /*
  * Receive and transmit Buffer Descriptor
  */
 typedef struct {
     uint32_t        des0;
     uint32_t        des1;
-    uint32_t        des2;        /* not used by HW */
+    uint32_t        des2;        /* used by HW 64 bits DMA */
     uint32_t        des3;
 } FTGMAC100Desc;
 
@@ -531,6 +535,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
     int frame_size = 0;
     uint8_t *ptr = s->frame;
     uint64_t addr = tx_descriptor;
+    uint64_t buf_addr = 0;
     uint32_t flags = 0;
 
     while (1) {
@@ -569,7 +574,12 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
             len =  sizeof(s->frame) - frame_size;
         }
 
-        if (dma_memory_read(&address_space_memory, bd.des3,
+        buf_addr = bd.des3;
+        if (s->dma64) {
+            buf_addr = deposit64(buf_addr, 32, 32,
+                                 FTGMAC100_TXDES2_TXBUF_BADR_HI(bd.des2));
+        }
+        if (dma_memory_read(&address_space_memory, buf_addr,
                             ptr, len, MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read packet @ 0x%x\n",
                           __func__, bd.des3);
@@ -1022,7 +1032,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
     uint32_t flags = 0;
     uint64_t addr;
     uint32_t crc;
-    uint32_t buf_addr;
+    uint64_t buf_addr = 0;
     uint8_t *crc_ptr;
     uint32_t buf_len;
     size_t size = len;
@@ -1087,7 +1097,12 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
         if (size < 4) {
             buf_len += size - 4;
         }
+
         buf_addr = bd.des3;
+        if (s->dma64) {
+            buf_addr = deposit64(buf_addr, 32, 32,
+                                 FTGMAC100_RXDES2_RXBUF_BADR_HI(bd.des2));
+        }
         if (first && proto == ETH_P_VLAN && buf_len >= 18) {
             bd.des1 = lduw_be_p(buf + 14) | FTGMAC100_RXDES1_VLANTAG_AVAIL;
 
-- 
2.45.2


