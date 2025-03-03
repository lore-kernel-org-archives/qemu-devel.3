Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830F4C282D2
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6Z2-0003Qk-J1; Mon, 03 Mar 2025 09:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tp6YT-00039b-9d; Mon, 03 Mar 2025 09:14:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tp6YM-0006UC-3m; Mon, 03 Mar 2025 09:13:57 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5239DJ6M030693;
 Mon, 3 Mar 2025 14:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OEIE3bqv2w4NESOjd
 CmP0Nivm7bvAtKnJfTo453LPJk=; b=EAj+0MmRI/j3s6C898ViM4u3ck56ztZqC
 TVnvYniN6T8Sacbn9xOk/G0java3zVeT0VpVWGpjs+ebvaSfrEI1Ng8YCAJ3axjC
 hpjTn/5RWSLLn0rYckkONdHE4C7jmFRd5DIqISHeJUgOBn9ohOx2kYtBZZFh8ltf
 5PEAwpdDgsSqGzCssSnhQjelyOVyhPjZNPCGObtVsI3j9h9r6pdNeVTwlLOG4sYk
 HAcBzN5MM9ZKSIaloA2gAz3zDgHmHBbw1jy4laVLSN8NRjUZRL3KUPYtn97xIINQ
 YjWMl3XpiYAsiAyE3yPJArGsKTn9FKmPn3JAiMFe8lN/WrlyU5L5w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454xgpbx2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:43 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 523E66nh015863;
 Mon, 3 Mar 2025 14:13:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454xgpbx1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 523BXmTQ020853;
 Mon, 3 Mar 2025 14:13:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djn7mju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 523EDcrG31326940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Mar 2025 14:13:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FB282004E;
 Mon,  3 Mar 2025 14:13:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C76BF20043;
 Mon,  3 Mar 2025 14:13:35 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Mar 2025 14:13:35 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v6 1/4] hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8
 structure
Date: Mon,  3 Mar 2025 08:13:25 -0600
Message-Id: <20250303141328.23991-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303141328.23991-1-chalapathi.v@linux.ibm.com>
References: <20250303141328.23991-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O5kNmixOrGCUwi2XRLL3wY2kTwPmTkAm
X-Proofpoint-ORIG-GUID: mWYQY5hil7j7e9V2c2O7qJZZyjHNj16v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030107
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/ssi/pnv_spi.c         | 264 ++++++++++++++++-----------------------
 2 files changed, 108 insertions(+), 159 deletions(-)

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
index 15e25bd1be..388b425157 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -19,6 +19,7 @@
 
 #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
 #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
+#define PNV_SPI_FIFO_SIZE 16
 
 /*
  * Macro from include/hw/ppc/fdt.h
@@ -35,48 +36,14 @@
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
-    g_free(payload->data);
-    g_free(payload);
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
      * According to spec, the mask bits that are 0 are compared and the
      * bits that are 1 are ignored.
      */
-    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK,
-                                        s->regs[SPI_MM_REG]);
-    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL,
-                                        s->regs[SPI_MM_REG]);
+    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK, s->regs[SPI_MM_REG]);
+    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL, s->regs[SPI_MM_REG]);
 
     if ((~rdr_match_mask & rdr_match_val) == ((~rdr_match_mask) &
             GETFIELD(PPC_BITMASK(48, 63), s->regs[SPI_RCV_DATA_REG]))) {
@@ -107,8 +74,8 @@ static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)
     return byte;
 }
 
-static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
-                uint8_t ecc_count, uint8_t shift_in_count)
+static uint8_t read_from_frame(PnvSpi *s, uint8_t nr_bytes, uint8_t ecc_count,
+                uint8_t shift_in_count)
 {
     uint8_t byte;
     int count = 0;
@@ -118,20 +85,24 @@ static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
         if ((ecc_count != 0) &&
             (shift_in_count == (PNV_SPI_REG_SIZE + ecc_count))) {
             shift_in_count = 0;
-        } else {
-            byte = read_buf[count];
+        } else if (!fifo8_is_empty(&s->rx_fifo)) {
+            byte = fifo8_pop(&s->rx_fifo);
             trace_pnv_spi_shift_rx(byte, count);
             s->regs[SPI_RCV_DATA_REG] = (s->regs[SPI_RCV_DATA_REG] << 8) | byte;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: Reading empty RX_FIFO\n");
         }
         count++;
     } /* end of while */
     return shift_in_count;
 }
 
-static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
+static void spi_response(PnvSpi *s)
 {
     uint8_t ecc_count;
     uint8_t shift_in_count;
+    uint32_t rx_len;
+    int i;
 
     /*
      * Processing here must handle:
@@ -144,13 +115,14 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
      * First check that the response payload is the exact same
      * number of bytes as the request payload was
      */
-    if (rsp_payload->len != (s->N1_bytes + s->N2_bytes)) {
+    rx_len = fifo8_num_used(&s->rx_fifo);
+    if (rx_len != (s->N1_bytes + s->N2_bytes)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in "
                        "bytes, expected %d, got %d\n",
-                       (s->N1_bytes + s->N2_bytes), rsp_payload->len);
+                       (s->N1_bytes + s->N2_bytes), rx_len);
     } else {
         uint8_t ecc_control;
-        trace_pnv_spi_rx_received(rsp_payload->len);
+        trace_pnv_spi_rx_received(rx_len);
         trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
                         s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2_rx);
         /*
@@ -175,15 +147,23 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
         /* Handle the N1 portion of the frame first */
         if (s->N1_rx != 0) {
             trace_pnv_spi_rx_read_N1frame();
-            shift_in_count = read_from_frame(s, &rsp_payload->data[0],
-                            s->N1_bytes, ecc_count, shift_in_count);
+            shift_in_count = read_from_frame(s, s->N1_bytes, ecc_count, shift_in_count);
         }
         /* Handle the N2 portion of the frame */
         if (s->N2_rx != 0) {
+            /* pop out N1_bytes from rx_fifo if not already */
+            if (s->N1_rx == 0) {
+                for (i = 0; i < s->N1_bytes; i++) {
+                    if (!fifo8_is_empty(&s->rx_fifo)) {
+                        fifo8_pop(&s->rx_fifo);
+                    } else {
+                        qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: Reading empty"
+                                                       " RX_FIFO\n");
+                    }
+                }
+            }
             trace_pnv_spi_rx_read_N2frame();
-            shift_in_count = read_from_frame(s,
-                            &rsp_payload->data[s->N1_bytes], s->N2_bytes,
-                            ecc_count, shift_in_count);
+            shift_in_count = read_from_frame(s, s->N2_bytes, ecc_count, shift_in_count);
         }
         if ((s->N1_rx + s->N2_rx) > 0) {
             /*
@@ -210,36 +190,41 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
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
-    if (!rsp_payload) {
-        return;
-    }
-    for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
+    payload_len = fifo8_num_used(&s->tx_fifo);
+    for (int offset = 0; offset < payload_len; offset += s->transfer_len) {
         tx = 0;
         for (int i = 0; i < s->transfer_len; i++) {
-            if ((offset + i) >= payload->len) {
+            if ((offset + i) >= payload_len) {
                 tx <<= 8;
+            } else if (!fifo8_is_empty(&s->tx_fifo)) {
+                tx = (tx << 8) | fifo8_pop(&s->tx_fifo);
             } else {
-                tx = (tx << 8) | payload->data[offset + i];
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO underflow\n");
             }
         }
         rx = ssi_transfer(s->ssi_bus, tx);
         for (int i = 0; i < s->transfer_len; i++) {
-            if ((offset + i) >= payload->len) {
+            if ((offset + i) >= payload_len) {
+                break;
+            }
+            rx_byte = (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
+            if (!fifo8_is_full(&s->rx_fifo)) {
+                fifo8_push(&s->rx_fifo, rx_byte);
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: RX_FIFO is full\n");
                 break;
             }
-            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, rsp_payload->len, 1)) =
-                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
         }
     }
-    spi_response(s, s->N1_bits, rsp_payload);
-    pnv_spi_xfer_buffer_free(rsp_payload);
+    spi_response(s);
+    /* Reset fifo for next frame */
+    fifo8_reset(&s->tx_fifo);
+    fifo8_reset(&s->rx_fifo);
 }
 
 static inline uint8_t get_seq_index(PnvSpi *s)
@@ -310,13 +295,11 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
              * If Forced Implicit mode and count control doesn't
              * indicate transmit then reset the tx count to 0
              */
-            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
-                                    s->regs[SPI_CTR_CFG_REG]) == 0) {
+            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2, s->regs[SPI_CTR_CFG_REG]) == 0) {
                 s->N1_tx = 0;
             }
             /* If rx count control for N1 is set, load the rx value */
-            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
-                                    s->regs[SPI_CTR_CFG_REG]) == 1) {
+            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3, s->regs[SPI_CTR_CFG_REG]) == 1) {
                 s->N1_rx = s->N1_bytes;
             }
         }
@@ -328,8 +311,7 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
      * cap the size at a max of 64 bits or 72 bits and set the sequencer FSM
      * error bit.
      */
-    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
-                                   s->regs[SPI_CLK_CFG_REG]);
+    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL, s->regs[SPI_CLK_CFG_REG]);
     if (ecc_control == 0 || ecc_control == 2) {
         if (s->N1_bytes > (PNV_SPI_REG_SIZE + 1)) {
             qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size when "
@@ -340,8 +322,7 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
         }
     } else if (s->N1_bytes > PNV_SPI_REG_SIZE) {
         qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
-                      "bytes = 0x%x, bits = 0x%x\n",
-                      s->N1_bytes, s->N1_bits);
+                      "bytes = 0x%x, bits = 0x%x\n", s->N1_bytes, s->N1_bits);
         s->N1_bytes = PNV_SPI_REG_SIZE;
         s->N1_bits = s->N1_bytes * 8;
     }
@@ -350,19 +331,10 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
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
@@ -413,9 +385,13 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
                  */
                 uint8_t n1_byte = 0x00;
                 n1_byte = get_from_offset(s, n1_count);
-                trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
-                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1)) =
-                        n1_byte;
+                if (!fifo8_is_full(&s->tx_fifo)) {
+                    trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
+                    fifo8_push(&s->tx_fifo, n1_byte);
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO is full\n");
+                    break;
+                }
             } else {
                 /*
                  * We hit a shift_n1 opcode TX but the TDR is empty, tell the
@@ -436,16 +412,17 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
              * - we are receiving and the RDR is empty so we allow the operation
              *   to proceed.
              */
-            if ((s->N1_rx != 0) && (GETFIELD(SPI_STS_RDR_FULL,
-                                           s->status) == 1)) {
+            if ((s->N1_rx != 0) && (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1)) {
                 trace_pnv_spi_sequencer_stop_requested("shift N1"
                                 "set for receive but RDR is full");
                 stop = true;
                 break;
-            } else {
+            } else if (!fifo8_is_full(&s->tx_fifo)) {
                 trace_pnv_spi_tx_append_FF("n1_byte");
-                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
-                        = 0xff;
+                fifo8_push(&s->tx_fifo, 0xff);
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO is full\n");
+                break;
             }
         }
         n1_count++;
@@ -486,15 +463,13 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
      */
     if (send_n1_alone && !stop) {
         /* We have a TX and a full TDR or an RX and an empty RDR */
-        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)->len);
-        transfer(s, *payload);
+        trace_pnv_spi_tx_request("Shifting N1 frame", fifo8_num_used(&s->tx_fifo));
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
@@ -552,13 +527,11 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
              * If Forced Implicit mode and count control doesn't
              * indicate a receive then reset the rx count to 0
              */
-            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
-                                    s->regs[SPI_CTR_CFG_REG]) == 0) {
+            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3, s->regs[SPI_CTR_CFG_REG]) == 0) {
                 s->N2_rx = 0;
             }
             /* If tx count control for N2 is set, load the tx value */
-            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
-                                    s->regs[SPI_CTR_CFG_REG]) == 1) {
+            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2, s->regs[SPI_CTR_CFG_REG]) == 1) {
                 s->N2_tx = s->N2_bytes;
             }
         }
@@ -571,8 +544,7 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
      * cap the size at a max of 64 bits or 72 bits and set the sequencer FSM
      * error bit.
      */
-    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
-                    s->regs[SPI_CLK_CFG_REG]);
+    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL, s->regs[SPI_CLK_CFG_REG]);
     if (ecc_control == 0 || ecc_control == 2) {
         if (s->N2_bytes > (PNV_SPI_REG_SIZE + 1)) {
             /* Unsupported N2 shift size when ECC enabled */
@@ -590,19 +562,10 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
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
@@ -629,44 +592,47 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
          * code continue will end up building the payload twice in the same
          * buffer since RDR full causes a sequence stop and restart.
          */
-        if ((s->N2_rx != 0) &&
-            (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1)) {
+        if ((s->N2_rx != 0) && (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1)) {
             trace_pnv_spi_sequencer_stop_requested("shift N2 set"
                             "for receive but RDR is full");
             stop = true;
             break;
         }
-        if ((s->N2_tx != 0) && ((s->N1_tx + n2_count) <
-                                PNV_SPI_REG_SIZE)) {
+        if ((s->N2_tx != 0) && ((s->N1_tx + n2_count) < PNV_SPI_REG_SIZE)) {
             /* Always append data for the N2 segment if it is set for TX */
             uint8_t n2_byte = 0x00;
             n2_byte = get_from_offset(s, (s->N1_tx + n2_count));
-            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + n2_count));
-            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
-                    = n2_byte;
-        } else {
+            if (!fifo8_is_full(&s->tx_fifo)) {
+                trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + n2_count));
+                fifo8_push(&s->tx_fifo, n2_byte);
+            } else {
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO is full\n");
+                break;
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
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO is full\n");
+            break;
         }
         n2_count++;
     } /* end of while */
     if (!stop) {
         /* We have a TX and a full TDR or an RX and an empty RDR */
-        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)->len);
-        transfer(s, *payload);
+        trace_pnv_spi_tx_request("Shifting N2 frame", fifo8_num_used(&s->tx_fifo));
+        transfer(s);
         /*
          * If we are doing an N2 TX and the TDR is full we need to clear the
          * TDR_full status. Do this here instead of up in the loop above so we
          * don't log the message in every loop iteration.
          */
-        if ((s->N2_tx != 0) &&
-            (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1)) {
+        if ((s->N2_tx != 0) && (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1)) {
             s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
         }
         /*
@@ -682,8 +648,6 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
         s->N1_bytes = 0;
         s->N1_tx = 0;
         s->N1_rx = 0;
-        pnv_spi_xfer_buffer_free(*payload);
-        *payload = NULL;
     }
     return stop;
 } /*  end of operation_shiftn2()*/
@@ -701,19 +665,6 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -775,10 +726,8 @@ static void operation_sequencer(PnvSpi *s)
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_DONE);
             } else if (s->responder_select != 1) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
-                              "not supported, select = 0x%x\n",
-                               s->responder_select);
-                trace_pnv_spi_sequencer_stop_requested("invalid "
-                                "responder select");
+                              "not supported, select = 0x%x\n", s->responder_select);
+                trace_pnv_spi_sequencer_stop_requested("invalid responder select");
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
                 stop = true;
             } else {
@@ -840,9 +789,8 @@ static void operation_sequencer(PnvSpi *s)
                                 == SEQ_OP_SHIFT_N2) {
                     send_n1_alone = false;
                 }
-                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
-                                FSM_SHIFT_N1);
-                stop = operation_shiftn1(s, opcode, &payload, send_n1_alone);
+                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_SHIFT_N1);
+                stop = operation_shiftn1(s, opcode, send_n1_alone);
                 if (stop) {
                     /*
                      *  The operation code says to stop, this can occur if:
@@ -858,7 +806,7 @@ static void operation_sequencer(PnvSpi *s)
                     if (GETFIELD(SPI_STS_TDR_UNDERRUN, s->status)) {
                         s->shift_n1_done = true;
                         s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
-                                                  FSM_SHIFT_N2);
+                                        FSM_SHIFT_N2);
                         s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
                                         (get_seq_index(s) + 1));
                     } else {
@@ -866,8 +814,7 @@ static void operation_sequencer(PnvSpi *s)
                          * This is case (1) or (2) so the sequencer needs to
                          * wait and NOT go to the next sequence yet.
                          */
-                        s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
-                                        FSM_WAIT);
+                        s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_WAIT);
                     }
                 } else {
                     /* Ok to move on to the next index */
@@ -890,21 +837,18 @@ static void operation_sequencer(PnvSpi *s)
                  * error bit 3 (general_SPI_status[3]) in status reg.
                  */
                 s->status = SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 1);
-                trace_pnv_spi_sequencer_stop_requested("shift_n2 "
-                                    "w/no shift_n1 done");
+                trace_pnv_spi_sequencer_stop_requested("shift_n2 w/no shift_n1 done");
                 stop = true;
             } else {
                 /* Ok to do a Shift_N2 */
-                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
-                                FSM_SHIFT_N2);
-                stop = operation_shiftn2(s, opcode, &payload);
+                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_SHIFT_N2);
+                stop = operation_shiftn2(s, opcode);
                 /*
                  * If the operation code says to stop set the shifter state to
                  * wait and stop
                  */
                 if (stop) {
-                    s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
-                                    FSM_WAIT);
+                    s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_WAIT);
                 } else {
                     /* Ok to move on to the next index */
                     next_sequencer_fsm(s);
@@ -988,8 +932,7 @@ static void operation_sequencer(PnvSpi *s)
         case SEQ_OP_BRANCH_IFNEQ_INC_2:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
             trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", get_seq_index(s));
-            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2,
-                              s->regs[SPI_CTR_CFG_REG]);
+            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2, s->regs[SPI_CTR_CFG_REG]);
             /*
              * The spec says the loop should execute count compare + 1 times.
              * However we learned from engineering that we really only loop
@@ -1209,6 +1152,9 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
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


