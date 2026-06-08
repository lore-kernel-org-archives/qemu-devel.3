Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0833CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSsO-00032k-Qf; Mon, 08 Jun 2026 01:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSs6-00022d-Fm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSs0-0000oO-Ik
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qbw3fOX5gATbYU/cclDLa2EHYWUMqv0Bw3auFmr7jBg=;
 b=YvobVpH2Rg64otDpHGhrWVIZuZGjeVdlJE70yI2Js9dI3+BtVvwK5mDnu1DQ7GOIJkkyur
 LSympUDWwLD33n4w4WgqE1BGSDkSHL/mMXoxGZNi8B4WLPIzCn4dirfLRa69gKahxqoANx
 lpw8og3nTu74hhgVfpeXsPuk8GGmh3w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-goGjb7VBOGqIggGf7s56NA-1; Mon,
 08 Jun 2026 01:49:44 -0400
X-MC-Unique: goGjb7VBOGqIggGf7s56NA-1
X-Mimecast-MFC-AGG-ID: goGjb7VBOGqIggGf7s56NA_1780897783
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3371E180049F; Mon,  8 Jun 2026 05:49:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 797EC765; Mon,  8 Jun 2026 05:49:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/37] hw/i3c: rename DW-I3C queue capacity fields from _bytes
 to _words
Date: Mon,  8 Jun 2026 07:48:25 +0200
Message-ID: <20260608054826.346488-37-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>

The cmd/resp, tx/rx, and IBI queue capacity values are passed straight
to fifo32_create(), which interprets its capacity argument as a 32-bit
word count.  The fields and device properties were therefore misnamed:
setting e.g. tx-rx-queue-capacity-bytes=N sized the backing FIFO to N
words, not N bytes.

Rename the three struct fields and matching device-property strings:

  cmd_resp_queue_capacity_bytes  -> cmd_resp_queue_capacity_words
  tx_rx_queue_capacity_bytes     -> tx_rx_queue_capacity_words
  ibi_queue_capacity_bytes       -> ibi_queue_capacity_words

Defaults are unchanged (0x10 / 0x40 / 0x10) -- they were being
interpreted as word counts by fifo32_create() all along, just under a
misleading label.  No behavioral change.

Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260604142207.2118098-3-jithu.joseph@oss.qualcomm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i3c/dw-i3c.h |  6 +++---
 hw/i3c/dw-i3c.c         | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
index d26f60580f02..391470207c43 100644
--- a/include/hw/i3c/dw-i3c.h
+++ b/include/hw/i3c/dw-i3c.h
@@ -181,9 +181,9 @@ struct DWI3C {
 
     struct {
         uint8_t id;
-        uint8_t cmd_resp_queue_capacity_bytes;
-        uint16_t tx_rx_queue_capacity_bytes;
-        uint8_t ibi_queue_capacity_bytes;
+        uint8_t cmd_resp_queue_capacity_words;
+        uint16_t tx_rx_queue_capacity_words;
+        uint8_t ibi_queue_capacity_words;
         uint8_t num_addressable_devices;
         uint16_t dev_addr_table_pointer;
         uint16_t dev_addr_table_depth;
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 06c2d55f5958..0d32d9ce78a0 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -948,9 +948,9 @@ static void dw_i3c_reset(DeviceState *dev)
     ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
                      s->cfg.dev_char_table_depth);
     ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
-                     s->cfg.cmd_resp_queue_capacity_bytes);
+                     s->cfg.cmd_resp_queue_capacity_words);
     ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
-                     s->cfg.tx_rx_queue_capacity_bytes);
+                     s->cfg.tx_rx_queue_capacity_words);
 
     dw_i3c_cmd_queue_reset(s);
     dw_i3c_resp_queue_reset(s);
@@ -1798,9 +1798,9 @@ static void dw_i3c_reset_enter(Object *obj, ResetType type)
     ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
                      s->cfg.dev_char_table_depth);
     ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
-                     s->cfg.cmd_resp_queue_capacity_bytes);
+                     s->cfg.cmd_resp_queue_capacity_words);
     ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
-                     s->cfg.tx_rx_queue_capacity_bytes);
+                     s->cfg.tx_rx_queue_capacity_words);
 }
 
 static void dw_i3c_realize(DeviceState *dev, Error **errp)
@@ -1814,14 +1814,14 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
                           DW_I3C_NR_REGS << 2);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
 
-    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_bytes);
-    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);
-    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);
-    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);
-    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_bytes);
+    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_words);
+    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_words);
+    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_words);
+    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_words);
+    fifo32_create(&s->ibi_queue, s->cfg.ibi_queue_capacity_words);
     /* Arbitrarily large enough to not be an issue. */
     fifo8_create(&s->ibi_data.ibi_intermediate_queue,
-                 s->cfg.ibi_queue_capacity_bytes * 8);
+                 s->cfg.ibi_queue_capacity_words * 8);
 
     s->bus = i3c_init_bus(DEVICE(s), name);
     I3CBusClass *bc = I3C_BUS_GET_CLASS(s->bus);
@@ -1832,12 +1832,12 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
 
 static const Property dw_i3c_properties[] = {
     DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),
-    DEFINE_PROP_UINT8("command-response-queue-capacity-bytes", DWI3C,
-                      cfg.cmd_resp_queue_capacity_bytes, 0x10),
-    DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,
-                      cfg.tx_rx_queue_capacity_bytes, 0x40),
-    DEFINE_PROP_UINT8("ibi-queue-capacity-bytes", DWI3C,
-                      cfg.ibi_queue_capacity_bytes, 0x10),
+    DEFINE_PROP_UINT8("command-response-queue-capacity-words", DWI3C,
+                      cfg.cmd_resp_queue_capacity_words, 0x10),
+    DEFINE_PROP_UINT16("tx-rx-queue-capacity-words", DWI3C,
+                      cfg.tx_rx_queue_capacity_words, 0x40),
+    DEFINE_PROP_UINT8("ibi-queue-capacity-words", DWI3C,
+                      cfg.ibi_queue_capacity_words, 0x10),
     DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,
                       cfg.num_addressable_devices, 8),
     DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,
-- 
2.54.0


