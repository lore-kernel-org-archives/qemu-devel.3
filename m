Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F28FC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Ox-00019j-L0; Tue, 09 Jul 2024 07:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Ov-0000tI-Nj
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Oo-0006W6-3E
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yagtQE17ByL+E5UQb6+itosE17U9MyYIStQijr0aF/o=;
 b=HW0r+cFLsaOmeeqhUenLfCqd+MY1YAoGiY7lVziw1B4J1kePF0UIt3SMqsl29yz27QG/Mt
 vDJEhiirI2QXRWDro1jZQsKUANGfj+ontEcr6LKJio5nj8RyFPd/LpdKnSpI6RNjuVjnko
 PX0MqmZhXmA+XqfjRzj0qtCOeohNBGM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-t36dUyOsOsSBrwhttzf0DA-1; Tue,
 09 Jul 2024 07:52:38 -0400
X-MC-Unique: t36dUyOsOsSBrwhttzf0DA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD44D1955D66; Tue,  9 Jul 2024 11:52:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 955E33000183; Tue,  9 Jul 2024 11:52:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/8] hw/net:ftgmac100: update ring base address to 64 bits
Date: Tue,  9 Jul 2024 13:52:22 +0200
Message-ID: <20240709115228.798904-3-clg@redhat.com>
In-Reply-To: <20240709115228.798904-1-clg@redhat.com>
References: <20240709115228.798904-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Update TX and RX ring base address data type to uint64_t for
64 bits dram address DMA support.

Both "Normal Priority Transmit Ring Base Address Register(0x20)" and
"Receive Ring Base Address Register (0x24)" are used for saving the
low part physical address of descriptor manager.

Therefore, changes to set TX and RX descriptor manager address bits [31:0]
in ftgmac100_read and ftgmac100_write functions.

Incrementing the version of vmstate to 2.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/net/ftgmac100.h |  9 ++++-----
 hw/net/ftgmac100.c         | 33 ++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 269446e85838..aae57ae8cbed 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -42,10 +42,6 @@ struct FTGMAC100State {
     uint32_t isr;
     uint32_t ier;
     uint32_t rx_enabled;
-    uint32_t rx_ring;
-    uint32_t rx_descriptor;
-    uint32_t tx_ring;
-    uint32_t tx_descriptor;
     uint32_t math[2];
     uint32_t rbsr;
     uint32_t itc;
@@ -58,7 +54,10 @@ struct FTGMAC100State {
     uint32_t phycr;
     uint32_t phydata;
     uint32_t fcr;
-
+    uint64_t rx_ring;
+    uint64_t rx_descriptor;
+    uint64_t tx_ring;
+    uint64_t tx_descriptor;
 
     uint32_t phy_status;
     uint32_t phy_control;
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 9e1f12cd331b..d026242e2b54 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -515,12 +515,12 @@ out:
     return frame_size;
 }
 
-static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
-                            uint32_t tx_descriptor)
+static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
+                            uint64_t tx_descriptor)
 {
     int frame_size = 0;
     uint8_t *ptr = s->frame;
-    uint32_t addr = tx_descriptor;
+    uint64_t addr = tx_descriptor;
     uint32_t flags = 0;
 
     while (1) {
@@ -726,9 +726,9 @@ static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
     case FTGMAC100_MATH1:
         return s->math[1];
     case FTGMAC100_RXR_BADR:
-        return s->rx_ring;
+        return extract64(s->rx_ring, 0, 32);
     case FTGMAC100_NPTXR_BADR:
-        return s->tx_ring;
+        return extract64(s->tx_ring, 0, 32);
     case FTGMAC100_ITC:
         return s->itc;
     case FTGMAC100_DBLAC:
@@ -799,9 +799,8 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
                           HWADDR_PRIx "\n", __func__, value);
             return;
         }
-
-        s->rx_ring = value;
-        s->rx_descriptor = s->rx_ring;
+        s->rx_ring = deposit64(s->rx_ring, 0, 32, value);
+        s->rx_descriptor = deposit64(s->rx_descriptor, 0, 32, value);
         break;
 
     case FTGMAC100_RBSR: /* DMA buffer size */
@@ -814,8 +813,8 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
                           HWADDR_PRIx "\n", __func__, value);
             return;
         }
-        s->tx_ring = value;
-        s->tx_descriptor = s->tx_ring;
+        s->tx_ring = deposit64(s->tx_ring, 0, 32, value);
+        s->tx_descriptor = deposit64(s->tx_descriptor, 0, 32, value);
         break;
 
     case FTGMAC100_NPTXPD: /* Trigger transmit */
@@ -957,7 +956,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
     FTGMAC100State *s = FTGMAC100(qemu_get_nic_opaque(nc));
     FTGMAC100Desc bd;
     uint32_t flags = 0;
-    uint32_t addr;
+    uint64_t addr;
     uint32_t crc;
     uint32_t buf_addr;
     uint8_t *crc_ptr;
@@ -1126,18 +1125,14 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_ftgmac100 = {
     .name = TYPE_FTGMAC100,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(irq_state, FTGMAC100State),
         VMSTATE_UINT32(isr, FTGMAC100State),
         VMSTATE_UINT32(ier, FTGMAC100State),
         VMSTATE_UINT32(rx_enabled, FTGMAC100State),
-        VMSTATE_UINT32(rx_ring, FTGMAC100State),
         VMSTATE_UINT32(rbsr, FTGMAC100State),
-        VMSTATE_UINT32(tx_ring, FTGMAC100State),
-        VMSTATE_UINT32(rx_descriptor, FTGMAC100State),
-        VMSTATE_UINT32(tx_descriptor, FTGMAC100State),
         VMSTATE_UINT32_ARRAY(math, FTGMAC100State, 2),
         VMSTATE_UINT32(itc, FTGMAC100State),
         VMSTATE_UINT32(aptcr, FTGMAC100State),
@@ -1156,6 +1151,10 @@ static const VMStateDescription vmstate_ftgmac100 = {
         VMSTATE_UINT32(phy_int_mask, FTGMAC100State),
         VMSTATE_UINT32(txdes0_edotr, FTGMAC100State),
         VMSTATE_UINT32(rxdes0_edorr, FTGMAC100State),
+        VMSTATE_UINT64(rx_ring, FTGMAC100State),
+        VMSTATE_UINT64(tx_ring, FTGMAC100State),
+        VMSTATE_UINT64(rx_descriptor, FTGMAC100State),
+        VMSTATE_UINT64(tx_descriptor, FTGMAC100State),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.45.2


