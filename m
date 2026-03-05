Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED25F47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyG-000131-RR; Thu, 05 Mar 2026 12:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxd-00086i-Dp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxZ-0003dY-8s
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dt7EAoZKeAXydHWoWZ3riEIB+P4MgzDWVBy5+zl7KHo=;
 b=VX76hkfd1+PUO9vRvjQOzIi4Sd7q8FmCZLmOCF/I837UpffVJUb9jUyrlClqwVYCx3gghj
 5V4i4f2lQQ7Wz5Ywn2BGipEkok55RUV6C3PyShFR1cr/0NY7IxXPCMAFjnu913tUs8KXFT
 Wq6PtYssm42FTyj0KGm2fuzfXeu/KaQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-f2kPqIIzNBO2bawAyRCW5w-1; Thu,
 05 Mar 2026 12:57:59 -0500
X-MC-Unique: f2kPqIIzNBO2bawAyRCW5w-1
X-Mimecast-MFC-AGG-ID: f2kPqIIzNBO2bawAyRCW5w_1772733474
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D4371800614; Thu,  5 Mar 2026 17:57:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCC003003E9F; Thu,  5 Mar 2026 17:57:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Stephen Longfield <slongfield@google.com>,
 Patrick Venture <venture@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/38] hw/i3c/dw-i3c: Add data TX and RX
Date: Thu,  5 Mar 2026 18:56:47 +0100
Message-ID: <20260305175711.1119025-15-clg@redhat.com>
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

This adds data and CCC transmission, reception, and the associated
queues required for data transmission and reception to happen.

The I3C controller transmits data by the user writing into a command
queue. When the queue has a command and an argument in it, the
controller starts executing the command.

The controller can execute 1 of 3 ways:
1. A larger data transfer that involves using the TX and RX queues. This
   is the most common way the controller does transactions.

2. A small data transfer that involves sending a couple bytes passed
   into the command queue argument.

3. An address assignment command. This is how the controller does
   ENTDAA. When ENTDAA succeeds in assigning an address to a target, it
   updates the controller's char table with the target's PID, BCR, and
   DCR.

The controller determines what addresses to send by looking at the index
in the device address table specified by the argument in the command
queue. ENTDAA also uses these addresses to assign to targets on the bus.

When the controller is done executing a command, it puts a response in
the response queue indicating how command execution went.

In order for the user to send and receive data to/from the controller,
the user reads/writes to a bidirectional TX/RX port.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-14-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i3c/aspeed_i3c.h |   1 +
 include/hw/i3c/dw-i3c.h     | 143 +++++-
 hw/i3c/dw-i3c.c             | 882 +++++++++++++++++++++++++++++++++++-
 hw/i3c/trace-events         |  10 +
 4 files changed, 1030 insertions(+), 6 deletions(-)

diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
index ade5c42d39ba..b8827d31d753 100644
--- a/include/hw/i3c/aspeed_i3c.h
+++ b/include/hw/i3c/aspeed_i3c.h
@@ -2,6 +2,7 @@
  * ASPEED I3C Controller
  *
  * Copyright (C) 2021 ASPEED Technology Inc.
+ * Copyright (C) 2023 Google, LLC
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
index 7143e8ca7a12..c50d67cc6be1 100644
--- a/include/hw/i3c/dw-i3c.h
+++ b/include/hw/i3c/dw-i3c.h
@@ -10,20 +10,159 @@
 #ifndef DW_I3C_H
 #define DW_I3C_H
 
+#include "qemu/fifo32.h"
+#include "hw/i3c/i3c.h"
 #include "hw/core/sysbus.h"
 
 #define TYPE_DW_I3C "dw.i3c"
 OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)
 
-#define DW_I3C_NR_REGS (0x300 >> 2)
+/*
+ * Sufficiently large enough to handle configurations with large device address
+ * tables.
+ */
+#define DW_I3C_NR_REGS (0x1000 >> 2)
+
+/* From datasheet. */
+#define DW_I3C_CMD_ATTR_TRANSFER_CMD 0
+#define DW_I3C_CMD_ATTR_TRANSFER_ARG 1
+#define DW_I3C_CMD_ATTR_SHORT_DATA_ARG 2
+#define DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD 3
+
+/* Enum values from datasheet. */
+typedef enum DWI3CRespQueueErr {
+    DW_I3C_RESP_QUEUE_ERR_NONE = 0,
+    DW_I3C_RESP_QUEUE_ERR_CRC = 1,
+    DW_I3C_RESP_QUEUE_ERR_PARITY = 2,
+    DW_I3C_RESP_QUEUE_ERR_FRAME = 3,
+    DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK = 4,
+    DW_I3C_RESP_QUEUE_ERR_DAA_NACK = 5,
+    DW_I3C_RESP_QUEUE_ERR_OVERFLOW = 6,
+    DW_I3C_RESP_QUEUE_ERR_ABORTED = 8,
+    DW_I3C_RESP_QUEUE_ERR_I2C_NACK = 9,
+} DWI3CRespQueueErr;
+
+typedef enum DWI3CTransferState {
+    DW_I3C_TRANSFER_STATE_IDLE = 0x00,
+    DW_I3C_TRANSFER_STATE_START = 0x01,
+    DW_I3C_TRANSFER_STATE_RESTART = 0x02,
+    DW_I3C_TRANSFER_STATE_STOP = 0x03,
+    DW_I3C_TRANSFER_STATE_START_HOLD = 0x04,
+    DW_I3C_TRANSFER_STATE_BROADCAST_W = 0x05,
+    DW_I3C_TRANSFER_STATE_BROADCAST_R = 0x06,
+    DW_I3C_TRANSFER_STATE_DAA = 0x07,
+    DW_I3C_TRANSFER_STATE_DAA_GEN = 0x08,
+    DW_I3C_TRANSFER_STATE_CCC_BYTE = 0x0b,
+    DW_I3C_TRANSFER_STATE_HDR_CMD = 0x0c,
+    DW_I3C_TRANSFER_STATE_WRITE = 0x0d,
+    DW_I3C_TRANSFER_STATE_READ = 0x0e,
+    DW_I3C_TRANSFER_STATE_IBI_READ = 0x0f,
+    DW_I3C_TRANSFER_STATE_IBI_DIS = 0x10,
+    DW_I3C_TRANSFER_STATE_HDR_DDR_CRC = 0x11,
+    DW_I3C_TRANSFER_STATE_CLK_STRETCH = 0x12,
+    DW_I3C_TRANSFER_STATE_HALT = 0x13,
+} DWI3CTransferState;
+
+typedef enum DWI3CTransferStatus {
+    DW_I3C_TRANSFER_STATUS_IDLE = 0x00,
+    DW_I3C_TRANSFER_STATUS_BROACAST_CCC = 0x01,
+    DW_I3C_TRANSFER_STATUS_DIRECT_CCC_W = 0x02,
+    DW_I3C_TRANSFER_STATUS_DIRECT_CCC_R = 0x03,
+    DW_I3C_TRANSFER_STATUS_ENTDAA = 0x04,
+    DW_I3C_TRANSFER_STATUS_SETDASA = 0x05,
+    DW_I3C_TRANSFER_STATUS_I3C_SDR_W = 0x06,
+    DW_I3C_TRANSFER_STATUS_I3C_SDR_R = 0x07,
+    DW_I3C_TRANSFER_STATUS_I2C_SDR_W = 0x08,
+    DW_I3C_TRANSFER_STATUS_I2C_SDR_R = 0x09,
+    DW_I3C_TRANSFER_STATUS_HDR_TS_W = 0x0a,
+    DW_I3C_TRANSFER_STATUS_HDR_TS_R = 0x0b,
+    DW_I3C_TRANSFER_STATUS_HDR_DDR_W = 0x0c,
+    DW_I3C_TRANSFER_STATUS_HDR_DDR_R = 0x0d,
+    DW_I3C_TRANSFER_STATUS_IBI = 0x0e,
+    DW_I3C_TRANSFER_STATUS_HALT = 0x0f,
+} DWI3CTransferStatus;
+
+/*
+ * Transfer commands and arguments are 32-bit wide values that the user passes
+ * into the command queue. We interpret each 32-bit word based on the cmd_attr
+ * field.
+ */
+typedef struct DWI3CTransferCmd {
+    uint8_t cmd_attr:3;
+    uint8_t tid:4; /* Transaction ID */
+    uint16_t cmd:8;
+    uint8_t cp:1; /* Command present */
+    uint8_t dev_index:5;
+    uint8_t speed:3;
+    uint8_t resv0:1;
+    uint8_t dbp:1; /* Defining byte present */
+    uint8_t roc:1; /* Response on completion */
+    uint8_t sdap:1; /* Short data argument present */
+    uint8_t rnw:1; /* Read not write */
+    uint8_t resv1:1;
+    uint8_t toc:1; /* Termination (I3C STOP) on completion */
+    uint8_t pec:1; /* Parity error check enabled */
+} DWI3CTransferCmd;
+
+typedef struct DWI3CTransferArg {
+    uint8_t cmd_attr:3;
+    uint8_t resv:5;
+    uint8_t db; /* Defining byte */
+    uint16_t data_len;
+} DWI3CTransferArg;
+
+typedef struct DWI3CShortArg {
+    uint8_t cmd_attr:3;
+    uint8_t byte_strb:3;
+    uint8_t resv:2;
+    uint8_t byte0;
+    uint8_t byte1;
+    uint8_t byte2;
+} DWI3CShortArg;
+
+typedef struct DWI3CAddrAssignCmd {
+    uint8_t cmd_attr:3;
+    uint8_t tid:4; /* Transaction ID */
+    uint16_t cmd:8;
+    uint8_t resv0:1;
+    uint8_t dev_index:5;
+    uint16_t dev_count:5;
+    uint8_t roc:1; /* Response on completion */
+    uint8_t resv1:3;
+    uint8_t toc:1; /* Termination (I3C STOP) on completion */
+    uint8_t resv2:1;
+} DWI3CAddrAssignCmd;
+
+typedef union DWI3CCmdQueueData {
+    uint32_t word;
+    DWI3CTransferCmd transfer_cmd;
+    DWI3CTransferArg transfer_arg;
+    DWI3CShortArg short_arg;
+    DWI3CAddrAssignCmd addr_assign_cmd;
+} DWI3CCmdQueueData;
 
 struct DWI3C {
     SysBusDevice parent_obj;
 
     MemoryRegion mr;
     qemu_irq irq;
+    I3CBus *bus;
+
+    Fifo32 cmd_queue;
+    Fifo32 resp_queue;
+    Fifo32 tx_queue;
+    Fifo32 rx_queue;
 
-    uint8_t id;
+    struct {
+        uint8_t id;
+        uint8_t cmd_resp_queue_capacity_bytes;
+        uint16_t tx_rx_queue_capacity_bytes;
+        uint8_t num_addressable_devices;
+        uint16_t dev_addr_table_pointer;
+        uint16_t dev_addr_table_depth;
+        uint16_t dev_char_table_pointer;
+        uint16_t dev_char_table_depth;
+    } cfg;
     uint32_t regs[DW_I3C_NR_REGS];
 };
 
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 0b99c7edfbfd..2453d74a8c91 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -336,12 +336,179 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] = {
     [R_SLAVE_CONFIG]                = 0xffffffff,
 };
 
+static inline bool dw_i3c_has_hdr_ts(DWI3C *s)
+{
+    return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);
+}
+
+static inline bool dw_i3c_has_hdr_ddr(DWI3C *s)
+{
+    return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_DDR);
+}
+
+static inline bool dw_i3c_can_transmit(DWI3C *s)
+{
+    /*
+     * We can only transmit if we're enabled and the resume bit is cleared.
+     * The resume bit is set on a transaction error, and software must clear it.
+     */
+    return ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_EN) &&
+           !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);
+}
+
+static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)
+{
+    return regval = regval ? (2 << regval) : 1;
+}
+
 static void dw_i3c_update_irq(DWI3C *s)
 {
     bool level = !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);
     qemu_set_irq(s->irq, level);
 }
 
+static void dw_i3c_end_transfer(DWI3C *s, bool is_i2c)
+{
+    if (is_i2c) {
+        legacy_i2c_end_transfer(s->bus);
+    } else {
+        i3c_end_transfer(s->bus);
+    }
+}
+
+static int dw_i3c_send_start(DWI3C *s, uint8_t addr, bool is_recv, bool is_i2c)
+{
+    int ret;
+
+    if (is_i2c) {
+        ret = legacy_i2c_start_transfer(s->bus, addr, is_recv);
+    } else {
+        ret = i3c_start_transfer(s->bus, addr, is_recv);
+    }
+    if (ret) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed on TX with addr 0x%.2x\n",
+                      path, addr);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                         DW_I3C_TRANSFER_STATUS_HALT);
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);
+    }
+
+    return ret;
+}
+
+static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t num_to_send,
+                       uint32_t *num_sent, bool is_i2c)
+{
+    int ret;
+    uint32_t i;
+
+    *num_sent = 0;
+    if (is_i2c) {
+        /* Legacy I2C must be byte-by-byte. */
+        for (i = 0; i < num_to_send; i++) {
+            ret = legacy_i2c_send(s->bus, data[i]);
+            if (ret) {
+                break;
+            }
+            (*num_sent)++;
+        }
+    } else {
+        ret = i3c_send(s->bus, data, num_to_send, num_sent);
+    }
+    if (ret) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed sending byte 0x%.2x\n",
+                      path, data[*num_sent]);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                         DW_I3C_TRANSFER_STATUS_HALT);
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);
+    }
+
+    trace_dw_i3c_send(s->cfg.id, *num_sent);
+
+    return ret;
+}
+
+static int dw_i3c_send_byte(DWI3C *s, uint8_t byte, bool is_i2c)
+{
+    /*
+     * Ignored, the caller will know if we sent 0 or 1 bytes depending on if
+     * we were ACKed/NACKed.
+     */
+    uint32_t num_sent;
+    return dw_i3c_send(s, &byte, 1, &num_sent, is_i2c);
+}
+
+static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uint8_t *data,
+                            uint16_t num_to_read, uint32_t *num_read)
+{
+    int ret;
+
+    if (is_i2c) {
+        for (uint16_t i = 0; i < num_to_read; i++) {
+            data[i] = legacy_i2c_recv(s->bus);
+        }
+        /* I2C devices can neither NACK a read, nor end transfers early. */
+        *num_read = num_to_read;
+        trace_dw_i3c_recv_data(s->cfg.id, *num_read);
+        return 0;
+    }
+    /* I3C devices can NACK if the controller sends an unsupported CCC. */
+    ret = i3c_recv(s->bus, data, num_to_read, num_read);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed receiving byte\n",
+                      object_get_canonical_path(OBJECT(s)));
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
+                         DW_I3C_TRANSFER_STATUS_HALT);
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);
+    }
+
+    trace_dw_i3c_recv_data(s->cfg.id, *num_read);
+
+    return ret;
+}
+
+static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)
+{
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array. */
+    uint16_t dev_index = (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER,
+                                          ADDR) / sizeof(uint32_t)) + offset;
+    return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,
+                   LEGACY_I2C_DEVICE);
+}
+
+static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t offset)
+{
+    if (offset > s->cfg.num_addressable_devices) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Device addr table offset %d out of "
+                      "bounds\n", path, offset);
+        /* If we're out of bounds, return an address of 0. */
+        return 0;
+    }
+
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array. */
+    uint16_t dev_index = (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_POINTER,
+                                          ADDR) / sizeof(uint32_t)) + offset;
+    /* I2C devices use a static address. */
+    if (dw_i3c_target_is_i2c(s, offset)) {
+        return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,
+                          DEV_STATIC_ADDR);
+    }
+    return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,
+                      DEV_DYNAMIC_ADDR);
+}
+
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)
 {
     /* Only return the status whose corresponding EN bits are set. */
@@ -376,6 +543,56 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)
     dw_i3c_update_irq(s);
 }
 
+static uint32_t dw_i3c_pop_rx(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->rx_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to read RX FIFO when empty\n",
+                      path);
+        return 0;
+    }
+
+    uint32_t val = fifo32_pop(&s->rx_queue);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,
+                     fifo32_num_used(&s->rx_queue));
+
+    /* Threshold is 2^RX_BUF_THLD. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,
+                                         RX_BUF_THLD);
+    threshold = dw_i3c_fifo_threshold_from_reg(threshold);
+    if (fifo32_num_used(&s->rx_queue) < threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);
+        dw_i3c_update_irq(s);
+    }
+
+    trace_dw_i3c_pop_rx(s->cfg.id, val);
+    return val;
+}
+
+static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->resp_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to read response FIFO when "
+                      "empty\n", path);
+        return 0;
+    }
+
+    uint32_t val = fifo32_pop(&s->resp_queue);
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,
+                     fifo32_num_used(&s->resp_queue));
+
+    /* Threshold is the register value + 1. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                         RESP_BUF_THLD) + 1;
+    if (fifo32_num_used(&s->resp_queue) < threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);
+        dw_i3c_update_irq(s);
+    }
+
+    return val;
+}
+
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
 {
     DWI3C *s = DW_I3C(opaque);
@@ -392,16 +609,635 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
     case R_INTR_STATUS:
         value = dw_i3c_intr_status_r(s);
         break;
+    case R_RX_TX_DATA_PORT:
+        value = dw_i3c_pop_rx(s);
+        break;
+    case R_RESPONSE_QUEUE_PORT:
+        value = dw_i3c_resp_queue_port_r(s);
+        break;
     default:
         value = s->regs[addr];
         break;
     }
 
-    trace_dw_i3c_read(s->id, offset, value);
+    trace_dw_i3c_read(s->cfg.id, offset, value);
 
     return value;
 }
 
+static void dw_i3c_resp_queue_push(DWI3C *s, uint8_t err, uint8_t tid,
+                                   uint8_t ccc_type, uint16_t data_len)
+{
+    uint32_t val = 0;
+    val = FIELD_DP32(val, RESPONSE_QUEUE_PORT, ERR_STATUS, err);
+    val = FIELD_DP32(val, RESPONSE_QUEUE_PORT, TID, tid);
+    val = FIELD_DP32(val, RESPONSE_QUEUE_PORT, CCCT, ccc_type);
+    val = FIELD_DP32(val, RESPONSE_QUEUE_PORT, DL, data_len);
+    if (!fifo32_is_full(&s->resp_queue)) {
+        trace_dw_i3c_resp_queue_push(s->cfg.id, val);
+        fifo32_push(&s->resp_queue, val);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,
+                     fifo32_num_used(&s->resp_queue));
+    /* Threshold is the register value + 1. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                         RESP_BUF_THLD) + 1;
+    if (fifo32_num_used(&s->resp_queue) >= threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 1);
+        dw_i3c_update_irq(s);
+    }
+}
+
+static void dw_i3c_push_tx(DWI3C *s, uint32_t val)
+{
+    if (fifo32_is_full(&s->tx_queue)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to TX FIFO when "
+                      "full\n", object_get_canonical_path(OBJECT(s)));
+        return;
+    }
+
+    trace_dw_i3c_push_tx(s->cfg.id, val);
+    fifo32_push(&s->tx_queue, val);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     fifo32_num_free(&s->tx_queue));
+
+    /* Threshold is 2^TX_BUF_THLD. */
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,
+                                               TX_BUF_THLD);
+    empty_threshold =
+        dw_i3c_fifo_threshold_from_reg(empty_threshold);
+    if (fifo32_num_free(&s->tx_queue) < empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 0);
+        dw_i3c_update_irq(s);
+    }
+}
+
+static uint32_t dw_i3c_pop_tx(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->tx_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to pop from TX FIFO when "
+                      "empty\n", path);
+        return 0;
+    }
+
+    uint32_t val = fifo32_pop(&s->tx_queue);
+    trace_dw_i3c_pop_tx(s->cfg.id, val);
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,
+                     fifo32_num_free(&s->tx_queue));
+
+    /* Threshold is 2^TX_BUF_THLD. */
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,
+                                               TX_BUF_THLD);
+    empty_threshold =
+        dw_i3c_fifo_threshold_from_reg(empty_threshold);
+    if (fifo32_num_free(&s->tx_queue) >= empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);
+        dw_i3c_update_irq(s);
+    }
+    return val;
+}
+
+static void dw_i3c_push_rx(DWI3C *s, uint32_t val)
+{
+    if (fifo32_is_full(&s->rx_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to RX FIFO when "
+                      "full\n", path);
+        return;
+    }
+    trace_dw_i3c_push_rx(s->cfg.id, val);
+    fifo32_push(&s->rx_queue, val);
+
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,
+                     fifo32_num_used(&s->rx_queue));
+    /* Threshold is 2^RX_BUF_THLD. */
+    uint8_t threshold = ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,
+                                         RX_BUF_THLD);
+    threshold = dw_i3c_fifo_threshold_from_reg(threshold);
+    if (fifo32_num_used(&s->rx_queue) >= threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 1);
+        dw_i3c_update_irq(s);
+    }
+}
+
+static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,
+                                  DWI3CShortArg arg)
+{
+    uint8_t err = DW_I3C_RESP_QUEUE_ERR_NONE;
+    uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index);
+    bool is_i2c = dw_i3c_target_is_i2c(s, cmd.dev_index);
+    uint8_t data[4]; /* Max we can send on a short transfer is 4 bytes. */
+    uint8_t len = 0;
+    uint32_t bytes_sent; /* Ignored on short transfers. */
+
+    /* Can't do reads on a short transfer. */
+    if (cmd.rnw) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Cannot do a read on a short "
+                      "transfer\n", path);
+        return;
+    }
+
+    if (dw_i3c_send_start(s, addr, /*is_recv=*/false, is_i2c)) {
+        err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+        goto transfer_done;
+    }
+
+    /* Are we sending a command? */
+    if (cmd.cp) {
+        data[len] = cmd.cmd;
+        len++;
+        /*
+         * byte0 is the defining byte for a command, and is only sent if a
+         * command is present and if the command has a defining byte present.
+         * (byte_strb & 0x01) is always treated as set by the controller, and is
+         * ignored.
+         */
+        if (cmd.dbp) {
+            data[len] += arg.byte0;
+            len++;
+        }
+    }
+
+    /* Send the bytes passed in the argument. */
+    if (arg.byte_strb & 0x02) {
+        data[len] = arg.byte1;
+        len++;
+    }
+    if (arg.byte_strb & 0x04) {
+        data[len] = arg.byte2;
+        len++;
+    }
+
+    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
+        err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+    } else {
+        /* Only go to an idle state on a successful transfer. */
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_IDLE);
+    }
+
+transfer_done:
+    if (cmd.toc) {
+        dw_i3c_end_transfer(s, is_i2c);
+    }
+    if (cmd.roc) {
+        /*
+         * ccc_type is always 0 in controller mode, data_len is 0 in short
+         * transfers.
+         */
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=*/0,
+                                          /*data_len=*/0);
+    }
+}
+
+/* Returns number of bytes transmitted. */
+static uint16_t dw_i3c_tx(DWI3C *s, uint16_t num, bool is_i2c)
+{
+    uint16_t bytes_sent = 0;
+    union {
+        uint8_t b[sizeof(uint32_t)];
+        uint32_t val;
+    } val32;
+
+    while (bytes_sent < num) {
+        val32.val = dw_i3c_pop_tx(s);
+        for (uint8_t i = 0; i < sizeof(val32.val); i++) {
+            if (dw_i3c_send_byte(s, val32.b[i], is_i2c)) {
+                return bytes_sent;
+            }
+            bytes_sent++;
+
+            /* We're not sending the full 32-bits, break early. */
+            if (bytes_sent >= num) {
+                break;
+            }
+        }
+    }
+
+    return bytes_sent;
+}
+
+/* Returns number of bytes received. */
+static uint16_t dw_i3c_rx(DWI3C *s, uint16_t num, bool is_i2c)
+{
+    /*
+     * Allocate a temporary buffer to read data from the target.
+     * Zero it and word-align it as well in case we're reading unaligned data.
+     */
+    g_autofree uint8_t *data = g_new0(uint8_t, num + (4 - (num & 0x03)));
+    uint32_t *data32 = (uint32_t *)data;
+    /*
+     * 32-bits since the I3C API wants a 32-bit number, even though the
+     * controller can only do 16-bit transfers.
+     */
+    uint32_t num_read = 0;
+
+    /* Can NACK if the target receives an unsupported CCC. */
+    if (dw_i3c_recv_data(s, is_i2c, data, num, &num_read)) {
+        return 0;
+    }
+
+    for (uint16_t i = 0; i < num_read / 4; i++) {
+        dw_i3c_push_rx(s, *data32);
+        data32++;
+    }
+    /*
+     * If we're pushing data that isn't 32-bit aligned, push what's left.
+     * It's software's responsibility to know what bits are valid in the partial
+     * data.
+     */
+    if (num_read & 0x03) {
+        dw_i3c_push_rx(s, *data32);
+    }
+
+    return num_read;
+}
+
+static int dw_i3c_transfer_ccc(DWI3C *s, DWI3CTransferCmd cmd,
+                               DWI3CTransferArg arg)
+{
+    /* CCC start is always a write. CCCs cannot be done on I2C devices. */
+    if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=*/false,
+                                     /*is_i2c=*/false)) {
+        return DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+    }
+    trace_dw_i3c_transfer_ccc(s->cfg.id, cmd.cmd);
+    if (dw_i3c_send_byte(s, cmd.cmd, /*is_i2c=*/false)) {
+        return DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+    }
+
+    /* On a direct CCC, we do a restart and then send the target's address. */
+    if (CCC_IS_DIRECT(cmd.cmd)) {
+        bool is_recv = cmd.rnw;
+        uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index);
+        if (dw_i3c_send_start(s, addr, is_recv, /*is_i2c=*/false)) {
+            return DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+        }
+    }
+
+    return DW_I3C_RESP_QUEUE_ERR_NONE;
+}
+
+static void dw_i3c_transfer(DWI3C *s, DWI3CTransferCmd cmd,
+                            DWI3CTransferArg arg)
+{
+    bool is_recv = cmd.rnw;
+    uint8_t err = DW_I3C_RESP_QUEUE_ERR_NONE;
+    uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index);
+    bool is_i2c = dw_i3c_target_is_i2c(s, cmd.dev_index);
+    uint16_t bytes_transferred = 0;
+
+    if (cmd.cp) {
+        /* We're sending a CCC. */
+        err = dw_i3c_transfer_ccc(s, cmd, arg);
+        if (err != DW_I3C_RESP_QUEUE_ERR_NONE) {
+            goto transfer_done;
+        }
+    } else {
+        if (ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_BROADCAST_ADDR_INC) &&
+            is_i2c == false) {
+            if (dw_i3c_send_start(s, I3C_BROADCAST,
+                                             /*is_recv=*/false, is_i2c)) {
+                err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+                goto transfer_done;
+            }
+        }
+        /* Otherwise we're doing a private transfer. */
+        if (dw_i3c_send_start(s, addr, is_recv, is_i2c)) {
+            err = DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
+            goto transfer_done;
+        }
+    }
+
+    if (is_recv) {
+        bytes_transferred = dw_i3c_rx(s, arg.data_len, is_i2c);
+    } else {
+        bytes_transferred = dw_i3c_tx(s, arg.data_len, is_i2c);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                     DW_I3C_TRANSFER_STATE_IDLE);
+
+transfer_done:
+    if (cmd.toc) {
+        dw_i3c_end_transfer(s, is_i2c);
+    }
+    if (cmd.roc) {
+        /*
+         * data_len is the number of bytes that still need to be TX'd, or the
+         * number of bytes RX'd.
+         */
+        uint16_t data_len = is_recv ? bytes_transferred : arg.data_len -
+                                                          bytes_transferred;
+        /* CCCT is always 0 in controller mode. */
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=*/0,
+                                          data_len);
+    }
+
+    dw_i3c_update_irq(s);
+}
+
+static void dw_i3c_transfer_cmd(DWI3C *s, DWI3CTransferCmd cmd,
+                                DWI3CCmdQueueData arg)
+{
+    uint8_t arg_attr = FIELD_EX32(arg.word, COMMAND_QUEUE_PORT, CMD_ATTR);
+
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CMD_TID, cmd.tid);
+
+    /* User is trying to do HDR transfers, see if we can do them. */
+    if (cmd.speed == 0x06 && !dw_i3c_has_hdr_ddr(s)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: HDR DDR is not supported\n", path);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        return;
+    }
+    if (cmd.speed == 0x05 && !dw_i3c_has_hdr_ts(s)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: HDR TS is not supported\n", path);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+        return;
+    }
+
+    if (arg_attr == DW_I3C_CMD_ATTR_TRANSFER_ARG) {
+        dw_i3c_transfer(s, cmd, arg.transfer_arg);
+    } else if (arg_attr == DW_I3C_CMD_ATTR_SHORT_DATA_ARG) {
+        dw_i3c_short_transfer(s, cmd, arg.short_arg);
+    } else {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown command queue cmd_attr 0x%x"
+                      "\n", path, arg_attr);
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                         DW_I3C_TRANSFER_STATE_HALT);
+    }
+}
+
+static void dw_i3c_update_char_table(DWI3C *s, uint8_t offset, uint64_t pid,
+                                     uint8_t bcr, uint8_t dcr, uint8_t addr)
+{
+    if (offset > s->cfg.num_addressable_devices) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Device char table offset %d out of "
+                      "bounds\n", path, offset);
+        /* If we're out of bounds, do nothing. */
+        return;
+    }
+
+    /*
+     * Each device offset is 128 bits apart in the table, since each device gets
+     * 4 * 32-bits of entries in the table.
+     * / sizeof(uint32_t) because we're indexing into our 32-bit reg array.
+     */
+    uint16_t dev_index = (ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,
+                                          P_DEV_CHAR_TABLE_START_ADDR) /
+                                          sizeof(uint32_t)) +
+                                          (offset * sizeof(uint32_t));
+    s->regs[dev_index] = pid & 0xffffffff;
+    pid >>= 32;
+    s->regs[dev_index + 1] = FIELD_DP32(s->regs[dev_index + 1],
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC2,
+                                        MSB_PID, pid);
+    s->regs[dev_index + 2] = FIELD_DP32(s->regs[dev_index + 2],
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR,
+                                        dcr);
+    s->regs[dev_index + 2] = FIELD_DP32(s->regs[dev_index + 2],
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC3, BCR,
+                                        bcr);
+    s->regs[dev_index + 3] = FIELD_DP32(s->regs[dev_index + 3],
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC4,
+                                        DEV_DYNAMIC_ADDR, addr);
+
+    /* Increment PRESENT_DEV_CHAR_TABLE_INDEX. */
+    uint8_t idx = ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,
+                     PRESENT_DEV_CHAR_TABLE_INDEX);
+    /* Increment and rollover. */
+    idx++;
+    if (idx >= ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,
+                               DEV_CHAR_TABLE_DEPTH) / 4) {
+        idx = 0;
+    }
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,
+                     PRESENT_DEV_CHAR_TABLE_INDEX, idx);
+}
+
+static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
+{
+    uint8_t i = 0;
+    uint8_t err = DW_I3C_RESP_QUEUE_ERR_NONE;
+
+    /* Tell everyone to ENTDAA. If these error, no one is on the bus. */
+    if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=*/false,
+                                     /*is_i2c=*/false)) {
+        err = DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+        goto transfer_done;
+    }
+    if (dw_i3c_send_byte(s, cmd.cmd, /*is_i2c=*/false)) {
+        err = DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+        goto transfer_done;
+    }
+
+    /* Go through each device in the table and assign it an address. */
+    for (i = 0; i < cmd.dev_count; i++) {
+        uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index + i);
+        union {
+            uint64_t pid:48;
+            uint8_t bcr;
+            uint8_t dcr;
+            uint32_t w[2];
+            uint8_t b[8];
+        } target_info;
+
+        /* If this fails, there was no one left to ENTDAA. */
+        if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=*/false,
+                                         /*is_i2c=*/false)) {
+            err = DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;
+            break;
+        }
+
+        /*
+         * In ENTDAA, we read 8 bytes from the target, which will be the
+         * target's PID, BCR, and DCR. After that, we send it the dynamic
+         * address.
+         * Don't bother checking the number of bytes received, it must send 8
+         * bytes during ENTDAA.
+         */
+        uint32_t num_read;
+        if (dw_i3c_recv_data(s, /*is_i2c=*/false, target_info.b,
+                                        I3C_ENTDAA_SIZE, &num_read)) {
+            g_autofree char *path = object_get_canonical_path(OBJECT(s));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Target NACKed ENTDAA CCC\n",
+                          path);
+            err = DW_I3C_RESP_QUEUE_ERR_DAA_NACK;
+            goto transfer_done;
+        }
+        if (dw_i3c_send_byte(s, addr, /*is_i2c=*/false)) {
+            g_autofree char *path = object_get_canonical_path(OBJECT(s));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Target NACKed addr 0x%.2x "
+                          "during ENTDAA\n", path, addr);
+            err = DW_I3C_RESP_QUEUE_ERR_DAA_NACK;
+            break;
+        }
+        dw_i3c_update_char_table(s, cmd.dev_index + i,
+                                            target_info.pid, target_info.bcr,
+                                            target_info.dcr, addr);
+
+        /* Push the PID, BCR, and DCR to the RX queue. */
+        dw_i3c_push_rx(s, target_info.w[0]);
+        dw_i3c_push_rx(s, target_info.w[1]);
+    }
+
+transfer_done:
+    /* Do we send a STOP? */
+    if (cmd.toc) {
+        dw_i3c_end_transfer(s, /*is_i2c=*/false);
+    }
+    /*
+     * For addr assign commands, the length field is the number of devices
+     * left to assign. CCCT is always 0 in controller mode.
+     */
+    if (cmd.roc) {
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=*/0,
+                                         cmd.dev_count - i);
+    }
+}
+
+static uint32_t dw_i3c_cmd_queue_pop(DWI3C *s)
+{
+    if (fifo32_is_empty(&s->cmd_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to dequeue command queue "
+                      "when it was empty\n", path);
+        return 0;
+    }
+    uint32_t val = fifo32_pop(&s->cmd_queue);
+
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                               CMD_BUF_EMPTY_THLD);
+    uint8_t cmd_queue_empty_loc = ARRAY_FIELD_EX32(s->regs,
+                                                   QUEUE_STATUS_LEVEL,
+                                                   CMD_QUEUE_EMPTY_LOC);
+    cmd_queue_empty_loc++;
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                     cmd_queue_empty_loc);
+    if (cmd_queue_empty_loc >= empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);
+        dw_i3c_update_irq(s);
+    }
+
+    return val;
+}
+
+static void dw_i3c_cmd_queue_execute(DWI3C *s)
+{
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
+                     DW_I3C_TRANSFER_STATE_IDLE);
+    if (!dw_i3c_can_transmit(s)) {
+        return;
+    }
+
+    /*
+     * We only start executing when a command is passed into the FIFO.
+     * We expect there to be a multiple of 2 items in the queue. The first item
+     * should be an argument to a command, and the command should be the second
+     * item.
+     */
+    if (fifo32_num_used(&s->cmd_queue) & 1) {
+        return;
+    }
+
+    while (!fifo32_is_empty(&s->cmd_queue)) {
+        DWI3CCmdQueueData arg;
+        arg.word = dw_i3c_cmd_queue_pop(s);
+        DWI3CCmdQueueData cmd;
+        cmd.word = dw_i3c_cmd_queue_pop(s);
+        trace_dw_i3c_cmd_queue_execute(s->cfg.id, cmd.word, arg.word);
+
+        uint8_t cmd_attr = FIELD_EX32(cmd.word, COMMAND_QUEUE_PORT, CMD_ATTR);
+        switch (cmd_attr) {
+        case DW_I3C_CMD_ATTR_TRANSFER_CMD:
+            dw_i3c_transfer_cmd(s, cmd.transfer_cmd, arg);
+            break;
+        case DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD:
+            /* Arg is discarded for addr assign commands. */
+            dw_i3c_addr_assign_cmd(s, cmd.addr_assign_cmd);
+            break;
+        case DW_I3C_CMD_ATTR_TRANSFER_ARG:
+        case DW_I3C_CMD_ATTR_SHORT_DATA_ARG:
+            {
+                g_autofree char *path = object_get_canonical_path(OBJECT(s));
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received "
+                              "argument packet when it expected a command "
+                              "packet\n", path);
+            }
+            break;
+        default:
+            /*
+             * The caller's check before queueing an item should prevent this
+             * from happening.
+             */
+            g_assert_not_reached();
+            break;
+        }
+    }
+}
+
+static void dw_i3c_cmd_queue_push(DWI3C *s, uint32_t val)
+{
+    if (fifo32_is_full(&s->cmd_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received packet when "
+                      "already full\n", path);
+        return;
+    }
+    trace_dw_i3c_cmd_queue_push(s->cfg.id, val);
+    fifo32_push(&s->cmd_queue, val);
+
+    uint8_t empty_threshold = ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,
+                                               CMD_BUF_EMPTY_THLD);
+    uint8_t cmd_queue_empty_loc = ARRAY_FIELD_EX32(s->regs,
+                                                   QUEUE_STATUS_LEVEL,
+                                                   CMD_QUEUE_EMPTY_LOC);
+    if (cmd_queue_empty_loc) {
+        cmd_queue_empty_loc--;
+        ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,
+                         cmd_queue_empty_loc);
+    }
+    if (cmd_queue_empty_loc < empty_threshold) {
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 0);
+        dw_i3c_update_irq(s);
+    }
+}
+
+static void dw_i3c_cmd_queue_port_w(DWI3C *s, uint32_t val)
+{
+    uint8_t cmd_attr = FIELD_EX32(val, COMMAND_QUEUE_PORT, CMD_ATTR);
+
+    switch (cmd_attr) {
+    /* If a command is received we can start executing it. */
+    case DW_I3C_CMD_ATTR_TRANSFER_CMD:
+    case DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD:
+        dw_i3c_cmd_queue_push(s, val);
+        dw_i3c_cmd_queue_execute(s);
+        break;
+    /* If we get an argument just push it. */
+    case DW_I3C_CMD_ATTR_TRANSFER_ARG:
+    case DW_I3C_CMD_ATTR_SHORT_DATA_ARG:
+        dw_i3c_cmd_queue_push(s, val);
+        break;
+    default:
+        {
+            g_autofree char *path = object_get_canonical_path(OBJECT(s));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received packet "
+                          "with unknown cmd attr 0x%x\n", path, cmd_attr);
+        }
+        break;
+    }
+}
+
 static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
                          unsigned size)
 {
@@ -409,7 +1245,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
     uint32_t addr = offset >> 2;
     uint32_t val32 = (uint32_t)value;
 
-    trace_dw_i3c_write(s->id, offset, value);
+    trace_dw_i3c_write(s->cfg.id, offset, value);
 
     val32 &= ~dw_i3c_ro[addr];
     switch (addr) {
@@ -433,6 +1269,10 @@ static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
                       __func__, offset, value);
         break;
     case R_RX_TX_DATA_PORT:
+        dw_i3c_push_tx(s, val32);
+        break;
+    case R_COMMAND_QUEUE_PORT:
+        dw_i3c_cmd_queue_port_w(s, val32);
         break;
     case R_RESET_CTRL:
         break;
@@ -475,22 +1315,56 @@ static void dw_i3c_reset_enter(Object *obj, ResetType type)
     DWI3C *s = DW_I3C(obj);
 
     memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));
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
 }
 
 static void dw_i3c_realize(DeviceState *dev, Error **errp)
 {
     DWI3C *s = DW_I3C(dev);
-    g_autofree char *name = g_strdup_printf(TYPE_DW_I3C ".%d", s->id);
+    g_autofree char *name = g_strdup_printf(TYPE_DW_I3C ".%d", s->cfg.id);
 
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 
     memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,
                           DW_I3C_NR_REGS << 2);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+
+    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_bytes);
+    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);
+    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);
+    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);
+
+    s->bus = i3c_init_bus(DEVICE(s), name);
 }
 
 static const Property dw_i3c_properties[] = {
-    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),
+    DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),
+    DEFINE_PROP_UINT8("command-response-queue-capacity-bytes", DWI3C,
+                      cfg.cmd_resp_queue_capacity_bytes, 0x10),
+    DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,
+                      cfg.tx_rx_queue_capacity_bytes, 0x40),
+    DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,
+                      cfg.num_addressable_devices, 8),
+    DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,
+                       cfg.dev_addr_table_pointer, 0x280),
+    DEFINE_PROP_UINT16("dev-addr-table-depth", DWI3C,
+                       cfg.dev_addr_table_depth, 0x08),
+    DEFINE_PROP_UINT16("dev-char-table-pointer", DWI3C,
+                       cfg.dev_char_table_pointer, 0x200),
+    DEFINE_PROP_UINT16("dev-char-table-depth", DWI3C,
+                       cfg.dev_char_table_depth, 0x20),
 };
 
 static void dw_i3c_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
index 2d944387db29..044ff06a01bf 100644
--- a/hw/i3c/trace-events
+++ b/hw/i3c/trace-events
@@ -7,6 +7,16 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64
 # dw-i3c,c
 dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
+dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PRId32 " bytes to bus"
+dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv %" PRId32 " bytes from bus"
+dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx32 " from RX FIFO"
+dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to response queue"
+dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to TX FIFO"
+dw_i3c_pop_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx32 " from TX FIFO"
+dw_i3c_push_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to RX FIFO"
+dw_i3c_transfer_ccc(uint32_t deviceid, uint8_t ccc) "I3C Dev[%u] transfer CCC 0x%" PRIx8
+dw_i3c_cmd_queue_execute(uint32_t deviceid, uint32_t cmd, uint32_t arg) "I3C Dev[%u] execute command 0x%" PRIx32 " arg 0x%" PRIx32
+dw_i3c_cmd_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PRIx32 " to cmd queue"
 
 # core.c
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " event 0x%" PRIx8
-- 
2.53.0


