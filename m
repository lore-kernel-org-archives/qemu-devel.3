Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0295DC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkU1-0003dy-It; Wed, 07 Feb 2024 11:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rXkTy-0003cd-QR; Wed, 07 Feb 2024 11:09:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rXkTw-0000gi-Da; Wed, 07 Feb 2024 11:09:06 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 417G2LC1030732; Wed, 7 Feb 2024 16:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L9H45JJXTVFAmT2qZmG7Zk0B9tMbrlBmjncPqLX84rE=;
 b=nhTRRVUwdZUeeJiVGGYlZf4uurOkLQk6/CIQXxeh2C1m1SaiQIjO3gaEWsKabX2+8Ow/
 rslLy43bdNU5MvoS/RFDsfMAknoPWb7Of6D/m+gf1Rb48aIreK1gfeRI1CuBPz21zxuX
 zfeIzsST1pJzwCKSbNiz/rlkQEB5CyC20v4lPwhZGQlTpeo/R+g74epXvSWJ5GiJ8yGl
 AL1e1ReCGDn/T3gZ5aHTDVcvRxG/m1W/iFpXHLWBNzIBbRYTpz0SRCAFDTS49kyz11xE
 bIaFABmoUf3xubc8wZUcYF5SpkLdqA1wVfCzGXHurEE/siM7aOG3bBAzd5ehgSWjD8GS aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4d1dr8ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:53 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 417G2ZjF031717;
 Wed, 7 Feb 2024 16:08:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4d1dr8dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 417EbkYS005421; Wed, 7 Feb 2024 16:08:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akpj31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:08:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 417G8mD432506248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Feb 2024 16:08:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82C0F20043;
 Wed,  7 Feb 2024 16:08:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5D8420040;
 Wed,  7 Feb 2024 16:08:46 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Feb 2024 16:08:46 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v1 1/5] hw/ppc: SPI responder model
Date: Wed,  7 Feb 2024 10:08:29 -0600
Message-Id: <20240207160833.3437779-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1vGlNCqTJnPynaPeb7XnL8aqSzeYbovC
X-Proofpoint-ORIG-GUID: JE7MZJG9yvhmoALRCvYKr1QivTnB8ISC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_06,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070119
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Serial pheripheral interface provides full-duplex synchronous serial
communication between single controller and multiple responder devices.
One SPI Controller is implemented and supported on a SPI Bus, there is
no support for multiple controllers on the SPI bus.

The current implemetation assumes that single responder is connected to
bus, hence chip_select is not modelled.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_spi_responder.h | 109 +++++++++++++++++++
 hw/ppc/pnv_spi_responder.c         | 166 +++++++++++++++++++++++++++++
 hw/ppc/meson.build                 |   1 +
 3 files changed, 276 insertions(+)
 create mode 100644 include/hw/ppc/pnv_spi_responder.h
 create mode 100644 hw/ppc/pnv_spi_responder.c

diff --git a/include/hw/ppc/pnv_spi_responder.h b/include/hw/ppc/pnv_spi_responder.h
new file mode 100644
index 0000000000..1cf7279aad
--- /dev/null
+++ b/include/hw/ppc/pnv_spi_responder.h
@@ -0,0 +1,109 @@
+/*
+ * QEMU SPI Responder.
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * SPI provides full-duplex synchronous serial communication between single
+ * controller and multiple responder devices. One SPI Controller is
+ * implemented and supported on a SPI Bus, there is no support for multiple
+ * controllers on the SPI bus.
+ *
+ * The current implementation assumes that single responder is connected to
+ * bus, hence chip_select is not modelled.
+ */
+
+#ifndef PPC_PNV_SPI_RESPONDER_H
+#define PPC_PNV_SPI_RESPONDER_H
+
+#include "hw/qdev-core.h"
+#include "qom/object.h"
+#include "qemu/log.h"
+
+#define TYPE_PNV_SPI_RESPONDER "spi-responder"
+OBJECT_DECLARE_TYPE(PnvSpiResponder, PnvSpiResponderClass,
+                    PNV_SPI_RESPONDER)
+
+typedef struct xfer_buffer xfer_buffer;
+
+struct PnvSpiResponderClass {
+    DeviceClass parent_class;
+
+    /*
+     * These methods are from controller to responder and implemented
+     * by all responders.
+     * Connect_controller/disconnect_controller methods are called by
+     * controller to initiate/stop the SPI transfer.
+     */
+    void (*connect_controller)(PnvSpiResponder *responder, const char *port);
+    void (*disconnect_controller)(PnvSpiResponder *responder);
+    /*
+     * SPI transfer consists of a number of consecutive calls to the request
+     * method.
+     * The parameter first is true on first call of the transfer and last is on
+     * the final call of the transfer. Parameter bits and payload defines the
+     * number of bits and data payload sent by controller.
+     * Responder returns the response payload.
+     */
+    xfer_buffer *(*request)(PnvSpiResponder *responder, int first, int last,
+                    int bits, xfer_buffer *payload);
+};
+
+struct PnvSpiResponder {
+    DeviceState parent_obj;
+};
+
+#define TYPE_SPI_BUS "spi-bus"
+OBJECT_DECLARE_SIMPLE_TYPE(SpiBus, SPI_BUS)
+
+struct SpiBus {
+    BusState parent_obj;
+};
+
+/*
+ * spi_realize_and_unref: realize and unref an SPI responder
+ * @dev: SPI responder to realize
+ * @bus: SPI bus to put it on
+ * @errp: error pointer
+ */
+bool spi_realize_and_unref(DeviceState *dev, SpiBus *bus, Error **errp);
+
+/*
+ * spi_create_responder: create a SPI responder.
+ * @bus: SPI bus to put it on
+ * @name: name of the responder object.
+ * call spi_realize_and_unref() after creating the responder.
+ */
+
+PnvSpiResponder *spi_create_responder(SpiBus *bus, const char *name);
+
+/* xfer_buffer */
+typedef struct xfer_buffer {
+
+    uint32_t    len;
+    uint8_t    *data;
+
+} xfer_buffer;
+
+/*
+ * xfer_buffer_read_ptr: Increment the payload length and return the pointer
+ * to the data at offset
+ */
+uint8_t *xfer_buffer_write_ptr(xfer_buffer *payload, uint32_t offset,
+                uint32_t length);
+/* xfer_buffer_read_ptr: Return the pointer to the data at offset */
+void xfer_buffer_read_ptr(xfer_buffer *payload, uint8_t **read_buf,
+                uint32_t offset, uint32_t length);
+/* xfer_buffer_new: Allocate memory and return the pointer */
+xfer_buffer *xfer_buffer_new(void);
+/* xfer_buffer_free: free the payload */
+void xfer_buffer_free(xfer_buffer *payload);
+
+/* Controller interface */
+SpiBus *spi_create_bus(DeviceState *parent, const char *name);
+xfer_buffer *spi_request(SpiBus *bus, int first, int last, int bits,
+                xfer_buffer *payload);
+bool spi_connect_controller(SpiBus *bus, const char *port);
+bool spi_disconnect_controller(SpiBus *bus);
+#endif /* PPC_PNV_SPI_SEEPROM_H */
diff --git a/hw/ppc/pnv_spi_responder.c b/hw/ppc/pnv_spi_responder.c
new file mode 100644
index 0000000000..c3bc659b1b
--- /dev/null
+++ b/hw/ppc/pnv_spi_responder.c
@@ -0,0 +1,166 @@
+/*
+ * QEMU PowerPC SPI Responder
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/ppc/pnv_spi_responder.h"
+#include "qapi/error.h"
+
+static const TypeInfo spi_bus_info = {
+    .name = TYPE_SPI_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(SpiBus),
+};
+
+SpiBus *spi_create_bus(DeviceState *parent, const char *name)
+{
+    BusState *bus;
+    bus = qbus_new(TYPE_SPI_BUS, parent, name);
+    return SPI_BUS(bus);
+}
+
+/* xfer_buffer_methods */
+xfer_buffer *xfer_buffer_new(void)
+{
+    xfer_buffer *payload = g_malloc0(sizeof(*payload));
+    payload->data = g_malloc0(payload->len * sizeof(uint8_t));
+    return payload;
+}
+
+void xfer_buffer_free(xfer_buffer *payload)
+{
+    free(payload->data);
+    payload->data = NULL;
+    free(payload);
+}
+
+uint8_t *xfer_buffer_write_ptr(xfer_buffer *payload, uint32_t offset,
+                            uint32_t length)
+{
+    if (payload->len < (offset + length)) {
+        payload->len = offset + length;
+        payload->data = g_realloc(payload->data,
+                        payload->len * sizeof(uint8_t));
+    }
+    return &payload->data[offset];
+}
+
+void xfer_buffer_read_ptr(xfer_buffer *payload, uint8_t **read_buf,
+                uint32_t offset, uint32_t length)
+{
+    static uint32_t prev_len;
+    uint32_t offset_org = offset;
+    if (offset > payload->len) {
+        if (length < payload->len) {
+            offset = payload->len - length;
+        } else {
+            offset = 0;
+            length = payload->len;
+        }
+        qemu_log_mask(LOG_GUEST_ERROR, "Read offset(%d) exceeds buffer "
+                        "length(%d), altered offset to %d and length to %d to "
+                        "read within buffer\n", offset_org, payload->len,
+                        offset, length);
+    } else if ((offset + length) > payload->len) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Read length(%d) bytes from offset (%d)"
+                        ", exceeds buffer length(%d)\n", length, offset,
+                        payload->len);
+        length = payload->len - offset;
+    }
+
+    if ((prev_len != length) || (*read_buf == NULL)) {
+        *read_buf = g_realloc(*read_buf, length * sizeof(uint8_t));
+        prev_len = length;
+    }
+    *read_buf = &payload->data[offset];
+}
+
+/* Controller interface methods */
+bool spi_connect_controller(SpiBus *bus, const char *port)
+{
+    BusState *b = BUS(bus);
+    BusChild *kid;
+    QTAILQ_FOREACH(kid, &b->children, sibling) {
+        PnvSpiResponder *r = PNV_SPI_RESPONDER(kid->child);
+        PnvSpiResponderClass *rc = PNV_SPI_RESPONDER_GET_CLASS(r);
+        rc->connect_controller(r, port);
+        return true;
+    }
+    return false;
+}
+bool spi_disconnect_controller(SpiBus *bus)
+{
+    BusState *b = BUS(bus);
+    BusChild *kid;
+    QTAILQ_FOREACH(kid, &b->children, sibling) {
+        PnvSpiResponder *r = PNV_SPI_RESPONDER(kid->child);
+        PnvSpiResponderClass *rc = PNV_SPI_RESPONDER_GET_CLASS(r);
+        rc->disconnect_controller(r);
+        return true;
+    }
+    return false;
+}
+
+xfer_buffer *spi_request(SpiBus *bus,
+                int first, int last, int bits, xfer_buffer *payload)
+{
+    BusState *b = BUS(bus);
+    BusChild *kid;
+    xfer_buffer *rsp_payload = NULL;
+    uint8_t *buf = NULL;
+
+    QTAILQ_FOREACH(kid, &b->children, sibling) {
+        PnvSpiResponder *r = PNV_SPI_RESPONDER(kid->child);
+        PnvSpiResponderClass *rc = PNV_SPI_RESPONDER_GET_CLASS(r);
+        rsp_payload = rc->request(r, first, last, bits, payload);
+        return rsp_payload;
+    }
+    if (rsp_payload == NULL) {
+        rsp_payload = xfer_buffer_new();
+    }
+    buf = xfer_buffer_write_ptr(rsp_payload, 0, payload->len);
+    memset(buf, 0, payload->len);
+    return rsp_payload;
+}
+
+/* create and realise spi responder device */
+bool spi_realize_and_unref(DeviceState *dev, SpiBus *bus, Error **errp)
+{
+    return qdev_realize_and_unref(dev, &bus->parent_obj, errp);
+}
+
+PnvSpiResponder *spi_create_responder(SpiBus *bus, const char *name)
+{
+    DeviceState *dev = qdev_new(name);
+
+    spi_realize_and_unref(dev, bus, &error_fatal);
+    return PNV_SPI_RESPONDER(dev);
+}
+
+static void pnv_spi_responder_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PowerNV SPI RESPONDER";
+}
+
+static const TypeInfo pnv_spi_responder_info = {
+    .name          = TYPE_PNV_SPI_RESPONDER,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvSpiResponder),
+    .class_init    = pnv_spi_responder_class_init,
+    .abstract      = true,
+    .class_size    = sizeof(PnvSpiResponderClass),
+};
+
+static void pnv_spi_responder_register_types(void)
+{
+    type_register_static(&pnv_spi_responder_info);
+    type_register_static(&spi_bus_info);
+}
+
+type_init(pnv_spi_responder_register_types);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index eba3406e7f..9bfd5a5613 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -53,6 +53,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_bmc.c',
   'pnv_homer.c',
   'pnv_pnor.c',
+  'pnv_spi_responder.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
-- 
2.31.1


