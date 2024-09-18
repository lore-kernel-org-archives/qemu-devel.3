Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F94ECDD548
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxtv-0007ey-Jl; Wed, 18 Sep 2024 12:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sqxtt-0007cn-LC; Wed, 18 Sep 2024 12:51:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sqxtp-0007kq-JI; Wed, 18 Sep 2024 12:51:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEZ78R032060;
 Wed, 18 Sep 2024 16:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=WDx01dw0nqoaQ
 tq/72TUJght/MC05yJrs4L6rNPvGK4=; b=Uz5p9DpjqgIQ+SDZBzHuGW9JSNRzZ
 M3nQX6DGWc/V0JGjDlnQ4Z5Y4/3ov84JXonqyiifePSP7qGtH0IEJ2DF/BYn1d50
 XrmfXADurJ2/Tv+RaT1Yy6tR3xtv+4rOktU5RDt+kRUjKGBSAS82KO3PpLDblZJC
 fdIDaUjFo4hAbJ76p4C6GkH4zEzydCRRoDcZ5E+ZqGEzcwFc7ZIHXoK1OXkdaf7d
 435L+CZnAxqgIJPyt/CbrBAd5eJoTrWAYynZkwJx9yWjoB1gQLUG3KmHfYcHzqaG
 2rB539LxP/qvSjt4J7N4EQc3okjMtePHuEl07hZpojm6SjQRaEaVA3PqQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3udf3c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48IGpFtd025099;
 Wed, 18 Sep 2024 16:51:15 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3udf3c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48IE31nZ025033;
 Wed, 18 Sep 2024 16:51:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1n435r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48IGpBv857082280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2024 16:51:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44DB820049;
 Wed, 18 Sep 2024 16:51:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3513420040;
 Wed, 18 Sep 2024 16:51:09 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Sep 2024 16:51:09 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v3 2/3] hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8
 structure
Date: Wed, 18 Sep 2024 11:50:44 -0500
Message-Id: <20240918165045.21298-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9U3cw9a2OHDu_ydP2iiqwSZ3PTz6mtPK
X-Proofpoint-ORIG-GUID: oroqavLGfvK2pLuUp7JovUiWKkCgB7rs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=866
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180110
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In PnvXferBuffer dynamically allocating and freeing is a
process overhead. Hence used an existing Fifo8 buffer with
capacity of 16 bytes.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ssi/pnv_spi.h |   3 +
 hw/ssi/pnv_spi.c         | 167 +++++++++++++--------------------------
 2 files changed, 56 insertions(+), 114 deletions(-)

diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
index 8815f67d45..9878d9a25f 100644
--- a/include/hw/ssi/pnv_spi.h
+++ b/include/hw/ssi/pnv_spi.h
@@ -23,6 +23,7 @@
 
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
+#include "qemu/fifo8.h"
 
 #define TYPE_PNV_SPI "pnv-spi"
 OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
@@ -37,6 +38,8 @@ typedef struct PnvSpi {
     SSIBus *ssi_bus;
     qemu_irq *cs_line;
     MemoryRegion    xscom_spic_regs;
+    Fifo8 tx_fifo;
+    Fifo8 rx_fifo;
     /* SPI object number */
     uint32_t        spic_num;
     uint8_t         transfer_len;
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 9e7207bf7c..2fd5aa0a96 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -19,6 +19,7 @@
 
 #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
 #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
+#define PNV_SPI_FIFO_SIZE 16
 
 /*
  * Macro from include/hw/ppc/fdt.h
@@ -35,38 +36,6 @@
         }                                                          \
     } while (0)
 
-/* PnvXferBuffer */
-typedef struct PnvXferBuffer {
-
-    uint32_t    len;
-    uint8_t    *data;
-
-} PnvXferBuffer;
-
-/* pnv_spi_xfer_buffer_methods */
-static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
-{
-    PnvXferBuffer *payload = g_malloc0(sizeof(*payload));
-
-    return payload;
-}
-
-static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
-{
-    free(payload->data);
-    free(payload);
-}
-
-static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
-                uint32_t offset, uint32_t length)
-{
-    if (payload->len < (offset + length)) {
-        payload->len = offset + length;
-        payload->data = g_realloc(payload->data, payload->len);
-    }
-    return &payload->data[offset];
-}
-
 static bool does_rdr_match(PnvSpi *s)
 {
     /*
@@ -107,8 +76,8 @@ static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)
     return byte;
 }
 
-static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
-                uint8_t ecc_count, uint8_t shift_in_count)
+static uint8_t read_from_frame(PnvSpi *s, uint8_t nr_bytes, uint8_t ecc_count,
+                uint8_t shift_in_count)
 {
     uint8_t byte;
     int count = 0;
@@ -118,8 +87,8 @@ static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
         if ((ecc_count != 0) &&
             (shift_in_count == (PNV_SPI_REG_SIZE + ecc_count))) {
             shift_in_count = 0;
-        } else {
-            byte = read_buf[count];
+        } else if (!fifo8_is_empty(&s->rx_fifo)) {
+            byte = fifo8_pop(&s->rx_fifo);
             trace_pnv_spi_shift_rx(byte, count);
             s->regs[SPI_RCV_DATA_REG] = (s->regs[SPI_RCV_DATA_REG] << 8) | byte;
         }
@@ -128,7 +97,7 @@ static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
     return shift_in_count;
 }
 
-static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
+static void spi_response(PnvSpi *s)
 {
     uint8_t ecc_count;
     uint8_t shift_in_count;
@@ -144,13 +113,13 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
      * First check that the response payload is the exact same
      * number of bytes as the request payload was
      */
-    if (rsp_payload->len != (s->N1_bytes + s->N2_bytes)) {
+    if ((&s->rx_fifo)->num != (s->N1_bytes + s->N2_bytes)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in "
                        "bytes, expected %d, got %d\n",
-                       (s->N1_bytes + s->N2_bytes), rsp_payload->len);
+                       (s->N1_bytes + s->N2_bytes), (&s->rx_fifo)->num);
     } else {
         uint8_t ecc_control;
-        trace_pnv_spi_rx_received(rsp_payload->len);
+        trace_pnv_spi_rx_received((&s->rx_fifo)->num);
         trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
                         s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2_rx);
         /*
@@ -175,14 +144,13 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
         /* Handle the N1 portion of the frame first */
         if (s->N1_rx != 0) {
             trace_pnv_spi_rx_read_N1frame();
-            shift_in_count = read_from_frame(s, &rsp_payload->data[0],
-                            s->N1_bytes, ecc_count, shift_in_count);
+            shift_in_count = read_from_frame(s, s->N1_bytes,
+                            ecc_count, shift_in_count);
         }
         /* Handle the N2 portion of the frame */
         if (s->N2_rx != 0) {
             trace_pnv_spi_rx_read_N2frame();
-            shift_in_count = read_from_frame(s,
-                            &rsp_payload->data[s->N1_bytes], s->N2_bytes,
+            shift_in_count = read_from_frame(s, s->N2_bytes,
                             ecc_count, shift_in_count);
         }
         if ((s->N1_rx + s->N2_rx) > 0) {
@@ -210,34 +178,36 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
     } /* end of else */
 } /* end of spi_response() */
 
-static void transfer(PnvSpi *s, PnvXferBuffer *payload)
+static void transfer(PnvSpi *s)
 {
-    uint32_t tx;
-    uint32_t rx;
-    PnvXferBuffer *rsp_payload = NULL;
+    uint32_t tx, rx, payload_len;
+    uint8_t rx_byte;
 
-    rsp_payload = pnv_spi_xfer_buffer_new();
-    for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
+    payload_len = (&s->tx_fifo)->num;
+    for (int offset = 0; offset < payload_len; offset += s->transfer_len) {
         tx = 0;
         for (int i = 0; i < s->transfer_len; i++) {
-            if ((offset + i) >= payload->len) {
+            if ((offset + i) >= payload_len) {
                 tx <<= 8;
-            } else {
-                tx = (tx << 8) | payload->data[offset + i];
+            } else if (!fifo8_is_empty(&s->tx_fifo)) {
+                tx = (tx << 8) | fifo8_pop(&s->tx_fifo);
             }
         }
         rx = ssi_transfer(s->ssi_bus, tx);
         for (int i = 0; i < s->transfer_len; i++) {
-            if ((offset + i) >= payload->len) {
+            if ((offset + i) >= payload_len) {
                 break;
             }
-            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, rsp_payload->len, 1)) =
-                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
+            rx_byte = (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
+            if (!fifo8_is_full(&s->rx_fifo)) {
+                fifo8_push(&s->rx_fifo, rx_byte);
+            }
         }
     }
-    if (rsp_payload != NULL) {
-        spi_response(s, s->N1_bits, rsp_payload);
-    }
+    spi_response(s);
+    /* Reset fifo for next frame */
+    fifo8_reset(&s->tx_fifo);
+    fifo8_reset(&s->rx_fifo);
 }
 
 static inline uint8_t get_seq_index(PnvSpi *s)
@@ -348,19 +318,10 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
 /*
  * Shift_N1 operation handler method
  */
-static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
-                       PnvXferBuffer **payload, bool send_n1_alone)
+static bool operation_shiftn1(PnvSpi *s, uint8_t opcode, bool send_n1_alone)
 {
     uint8_t n1_count;
     bool stop = false;
-
-    /*
-     * If there isn't a current payload left over from a stopped sequence
-     * create a new one.
-     */
-    if (*payload == NULL) {
-        *payload = pnv_spi_xfer_buffer_new();
-    }
     /*
      * Use a combination of N1 counters to build the N1 portion of the
      * transmit payload.
@@ -411,9 +372,10 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
                  */
                 uint8_t n1_byte = 0x00;
                 n1_byte = get_from_offset(s, n1_count);
-                trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
-                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1)) =
-                        n1_byte;
+                if (!fifo8_is_full(&s->tx_fifo)) {
+                    trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
+                    fifo8_push(&s->tx_fifo, n1_byte);
+                }
             } else {
                 /*
                  * We hit a shift_n1 opcode TX but the TDR is empty, tell the
@@ -440,10 +402,9 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
                                 "set for receive but RDR is full");
                 stop = true;
                 break;
-            } else {
+            } else if (!fifo8_is_full(&s->tx_fifo)) {
                 trace_pnv_spi_tx_append_FF("n1_byte");
-                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
-                        = 0xff;
+                fifo8_push(&s->tx_fifo, 0xff);
             }
         }
         n1_count++;
@@ -484,15 +445,13 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
      */
     if (send_n1_alone && !stop) {
         /* We have a TX and a full TDR or an RX and an empty RDR */
-        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)->len);
-        transfer(s, *payload);
+        trace_pnv_spi_tx_request("Shifting N1 frame", (&s->tx_fifo)->num);
+        transfer(s);
         /* The N1 frame shift is complete so reset the N1 counters */
         s->N2_bits = 0;
         s->N2_bytes = 0;
         s->N2_tx = 0;
         s->N2_rx = 0;
-        pnv_spi_xfer_buffer_free(*payload);
-        *payload = NULL;
     }
     return stop;
 } /* end of operation_shiftn1() */
@@ -588,19 +547,10 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
  * Shift_N2 operation handler method
  */
 
-static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
-                       PnvXferBuffer **payload)
+static bool operation_shiftn2(PnvSpi *s, uint8_t opcode)
 {
     uint8_t n2_count;
     bool stop = false;
-
-    /*
-     * If there isn't a current payload left over from a stopped sequence
-     * create a new one.
-     */
-    if (*payload == NULL) {
-        *payload = pnv_spi_xfer_buffer_new();
-    }
     /*
      * Use a combination of N2 counters to build the N2 portion of the
      * transmit payload.
@@ -639,25 +589,26 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
             /* Always append data for the N2 segment if it is set for TX */
             uint8_t n2_byte = 0x00;
             n2_byte = get_from_offset(s, (s->N1_tx + n2_count));
-            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + n2_count));
-            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
-                    = n2_byte;
-        } else {
+            if (!fifo8_is_full(&s->tx_fifo)) {
+                trace_pnv_spi_tx_append("n2_byte", n2_byte,
+                                (s->N1_tx + n2_count));
+                fifo8_push(&s->tx_fifo, n2_byte);
+            }
+        } else if (!fifo8_is_full(&s->tx_fifo)) {
             /*
              * Regardless of whether or not N2 is set for TX or RX, we need
              * the number of bytes in the payload to match the overall length
              * of the operation.
              */
             trace_pnv_spi_tx_append_FF("n2_byte");
-            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
-                    = 0xff;
+            fifo8_push(&s->tx_fifo, 0xff);
         }
         n2_count++;
     } /* end of while */
     if (!stop) {
         /* We have a TX and a full TDR or an RX and an empty RDR */
-        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)->len);
-        transfer(s, *payload);
+        trace_pnv_spi_tx_request("Shifting N2 frame", (&s->tx_fifo)->num);
+        transfer(s);
         /*
          * If we are doing an N2 TX and the TDR is full we need to clear the
          * TDR_full status. Do this here instead of up in the loop above so we
@@ -680,8 +631,6 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
         s->N1_bytes = 0;
         s->N1_tx = 0;
         s->N1_rx = 0;
-        pnv_spi_xfer_buffer_free(*payload);
-        *payload = NULL;
     }
     return stop;
 } /*  end of operation_shiftn2()*/
@@ -699,19 +648,6 @@ static void operation_sequencer(PnvSpi *s)
     uint8_t opcode = 0;
     uint8_t masked_opcode = 0;
 
-    /*
-     * PnvXferBuffer for containing the payload of the SPI frame.
-     * This is a static because there are cases where a sequence has to stop
-     * and wait for the target application to unload the RDR.  If this occurs
-     * during a sequence where N1 is not sent alone and instead combined with
-     * N2 since the N1 tx length + the N2 tx length is less than the size of
-     * the TDR.
-     */
-    static PnvXferBuffer *payload;
-
-    if (payload == NULL) {
-        payload = pnv_spi_xfer_buffer_new();
-    }
     /*
      * Clear the sequencer FSM error bit - general_SPI_status[3]
      * before starting a sequence.
@@ -840,7 +776,7 @@ static void operation_sequencer(PnvSpi *s)
                 }
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
                                 FSM_SHIFT_N1);
-                stop = operation_shiftn1(s, opcode, &payload, send_n1_alone);
+                stop = operation_shiftn1(s, opcode, send_n1_alone);
                 if (stop) {
                     /*
                      *  The operation code says to stop, this can occur if:
@@ -895,7 +831,7 @@ static void operation_sequencer(PnvSpi *s)
                 /* Ok to do a Shift_N2 */
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
                                 FSM_SHIFT_N2);
-                stop = operation_shiftn2(s, opcode, &payload);
+                stop = operation_shiftn2(s, opcode);
                 /*
                  * If the operation code says to stop set the shifter state to
                  * wait and stop
@@ -1208,6 +1144,9 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
     s->cs_line = g_new0(qemu_irq, 1);
     qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
 
+    fifo8_create(&s->tx_fifo, PNV_SPI_FIFO_SIZE);
+    fifo8_create(&s->rx_fifo, PNV_SPI_FIFO_SIZE);
+
     /* spi scoms */
     pnv_xscom_region_init(&s->xscom_spic_regs, OBJECT(s), &pnv_spi_xscom_ops,
                           s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
-- 
2.39.5


