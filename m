Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8292E83063
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 08:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCB3-00066F-Gz; Tue, 03 Feb 2026 03:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCAQ-0005FV-IM; Tue, 03 Feb 2026 03:53:54 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnCAO-0003Po-Vq; Tue, 03 Feb 2026 03:53:50 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 16:52:37 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 16:52:36 +0800
To: <komlodi@google.com>, <nabihestefan@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>, Patrick Venture <venture@google.com>, "Stephen
 Longfield" <slongfield@google.com>
Subject: [PATCH v2 15/20] hw/i3c/dw-i3c: Add controller resets
Date: Tue, 3 Feb 2026 16:52:15 +0800
Message-ID: <20260203085229.1543287-16-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Joe Komlodi <komlodi@google.com>

Adds behavior to the device reset register.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/i3c/dw-i3c.c     | 117 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i3c/trace-events |   1 +
 2 files changed, 118 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 7a1f79e10d..87ad344e5d 100644
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
index a262fcce39..39f33d9a50 100644
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
2.43.0


