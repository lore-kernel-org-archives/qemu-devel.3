Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28FCF47CA5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyF-0000vr-Qm; Thu, 05 Mar 2026 12:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxg-0008Iy-74
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxc-0003gg-Re
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wjuRCWduN2YFiMCaCyutWXrpIG1mYNVbr7fXCFputc=;
 b=EnxwLFBzfsasUe9uP9RHIi8RjBpFgAhW7QHQI0dWqV0CTjx6GtoreKTyQ8E1N94VUMDAw4
 6ImYq9+MfK9JTamBm1EhGfVpRNE766mBvQejzLminMe4md4fL6tKPQfQDBFF9bcvn7v+V0
 Ppnf+/5Z56imDcEa/524/KyezTkH2M0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-4lSEkYACPmSirQA9PsYnOA-1; Thu,
 05 Mar 2026 12:58:05 -0500
X-MC-Unique: 4lSEkYACPmSirQA9PsYnOA-1
X-Mimecast-MFC-AGG-ID: 4lSEkYACPmSirQA9PsYnOA_1772733483
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84B3F180060F; Thu,  5 Mar 2026 17:58:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DCBD3003E9E; Thu,  5 Mar 2026 17:58:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>,
 Stephen Longfield <slongfield@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/38] hw/i3c/dw-i3c: Add controller resets
Date: Thu,  5 Mar 2026 18:56:50 +0100
Message-ID: <20260305175711.1119025-18-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Adds behavior to the device reset register.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-17-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/dw-i3c.c     | 117 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i3c/trace-events |   1 +
 2 files changed, 118 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index b6ec0d957936..d7424581290e 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -860,6 +860,122 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)
     dw_i3c_update_irq(s);
 }
 
+static void dw_i3c_cmd_queue_reset(DWI3C *s)
+{
+    fifo32_reset(&s->cmd_queue);
+
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                     fifo32_num_free(&s->cmd_queue));
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                               CMD_BUF_EMPTY_THLD);
+    if (fifo32_num_free(&s->cmd_queue) >= empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);
+        dw_i3c_update_irq(s);
+    };
+}
+
+static void dw_i3c_resp_queue_reset(DWI3C *s)
+{
+    fifo32_reset(&s->resp_queue);
+
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,
+                     fifo32_num_used(&s->resp_queue));
+    /*
+     * This interrupt will always be cleared because the threshold is a minimum
+     * of 1 and the queue size is 0.
+     */
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_ibi_queue_reset(DWI3C *s)
+{
+    fifo32_reset(&s->ibi_queue);
+
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,
+                     fifo32_num_used(&s->resp_queue));
+    /*
+     * This interrupt will always be cleared because the threshold is a minimum
+     * of 1 and the queue size is 0.
+     */
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_tx_queue_reset(DWI3C *s)
+{
+    fifo32_reset(&s->tx_queue);
+
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     fifo32_num_free(&s->tx_queue));
+    /* TX buf is empty, so this interrupt will always be set. */
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_rx_queue_reset(DWI3C *s)
+{
+    fifo32_reset(&s->rx_queue);
+
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,
+                     fifo32_num_used(&s->resp_queue));
+    /*
+     * This interrupt will always be cleared because the threshold is a minimum
+     * of 1 and the queue size is 0.
+     */
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_reset(DeviceState *dev)
+{
+    DWI3C *s = DW_I3C(dev);
+    trace_dw_i3c_reset(s->cfg.id);
+
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));
+    /*
+     * The user config for these may differ from our resets array, set them
+     * manually.
+     */
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, ADDR,
+                     s->cfg.dev_addr_table_pointer);
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, DEPTH,
+                     s->cfg.dev_addr_table_depth);
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,
+                     P_DEV_CHAR_TABLE_START_ADDR,
+                     s->cfg.dev_char_table_pointer);
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,
+                     s->cfg.dev_char_table_depth);
+
+    dw_i3c_cmd_queue_reset(s);
+    dw_i3c_resp_queue_reset(s);
+    dw_i3c_ibi_queue_reset(s);
+    dw_i3c_tx_queue_reset(s);
+    dw_i3c_rx_queue_reset(s);
+}
+
+static void dw_i3c_reset_ctrl_w(DWI3C *s, uint32_t val)
+{
+    if (FIELD_EX32(val, RESET_CTRL, CORE_RESET)) {
+        dw_i3c_reset(DEVICE(s));
+    }
+    if (FIELD_EX32(val, RESET_CTRL, CMD_QUEUE_RESET)) {
+        dw_i3c_cmd_queue_reset(s);
+    }
+    if (FIELD_EX32(val, RESET_CTRL, RESP_QUEUE_RESET)) {
+        dw_i3c_resp_queue_reset(s);
+    }
+    if (FIELD_EX32(val, RESET_CTRL, TX_BUF_RESET)) {
+        dw_i3c_tx_queue_reset(s);
+    }
+    if (FIELD_EX32(val, RESET_CTRL, RX_BUF_RESET)) {
+        dw_i3c_rx_queue_reset(s);
+    }
+    if (FIELD_EX32(val, RESET_CTRL, IBI_QUEUE_RESET)) {
+        dw_i3c_ibi_queue_reset(s);
+    }
+}
+
 static uint32_t dw_i3c_pop_rx(DWI3C *s)
 {
     if (fifo32_is_empty(&s->rx_queue)) {
@@ -1617,6 +1733,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
         dw_i3c_cmd_queue_port_w(s, val32);
         break;
     case R_RESET_CTRL:
+        dw_i3c_reset_ctrl_w(s, val32);
         break;
     case R_INTR_STATUS:
         dw_i3c_intr_status_w(s, val32);
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
index a262fcce39de..39f33d9a50bc 100644
--- a/hw/i3c/trace-events
+++ b/hw/i3c/trace-events
@@ -11,6 +11,7 @@ dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PRId32 "
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv %" PRId32 " bytes from bus"
 dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI byte 0x%" PRIx8
 dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] handle IBI from address 0x%" PRIx8 " RnW=%d"
+dw_i3c_reset(uint32_t deviceid) "I3C Dev[%u] reset"
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx32 " from RX FIFO"
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to response queue"
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to TX FIFO"
-- 
2.53.0


