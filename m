Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096BAC19F32
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 03:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnqcC-0006JK-RC; Thu, 27 Feb 2025 22:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tnqc9-0006In-0r; Thu, 27 Feb 2025 22:00:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tnqc4-0005uF-CX; Thu, 27 Feb 2025 22:00:36 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMo1DB015651;
 Fri, 28 Feb 2025 03:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=sD2G7dKcwzR3Hwfr92/HdxuQZ8hTK5
 PaBqR8iPkDjPs=; b=nUvJ8QXERbXaYj8AgPeJLQaD04WRqf9SS7c7Ychi/59bGP
 PUYzb6cS3iATzRkUwc9wAX+8NI+GIoEPOUrNAxK5wed+VLrRU3eTvjQa2MQa/0LA
 Il6aLOKPkl6KG6yw6wr768FqPNw32fSbN1EcjjrW3/GA48WbYcmQBbBeizPXp3Nz
 HdT4h/d3Ieh/ke79eQ9j4zMB3WLWDk27RF4twbwIF5Vk2HuQUyjMECNH3cMJjl54
 QWG1N4S9bfxcSVRCrRg7vxHdU/4gIwI7Jwf71QFYdNb9mp2O1q89jo3hvNVQxHhQ
 nNqqg5vo12GaKjHVeODKvq/GdSWfOKi90KhOaRdg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45316a8u51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:00:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51S2qeCC010602;
 Fri, 28 Feb 2025 03:00:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45316a8u4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:00:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1XMkp012499;
 Fri, 28 Feb 2025 03:00:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9yvdvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 03:00:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51S30APX29557318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 03:00:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 247712004D;
 Fri, 28 Feb 2025 03:00:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADDC520040;
 Fri, 28 Feb 2025 02:59:50 +0000 (GMT)
Received: from [9.43.106.183] (unknown [9.43.106.183])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Feb 2025 02:59:50 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------D0K9h9bmFtkI0bqtZIMy0CpB"
Message-ID: <a4e1e393-4f12-4242-848b-e67a9a55dc0f@linux.ibm.com>
Date: Fri, 28 Feb 2025 08:29:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8
 structure
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, clg@kaod.org,
 calebs@linux.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-2-chalapathi.v@linux.ibm.com>
 <D82UFOB22C3K.31271R5VWD0LU@gmail.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <D82UFOB22C3K.31271R5VWD0LU@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NX1s6N_rVGkzlurfu0M6DuQPzHg5EnBK
X-Proofpoint-GUID: PsG0i4Q_97nPf7Vo-f8afdVIun9t_5f_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280020
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

This is a multi-part message in MIME format.
--------------D0K9h9bmFtkI0bqtZIMy0CpB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Nick,

Thank You for reviewing this series.

On 27-02-2025 07:09, Nicholas Piggin wrote:
> On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
>> In PnvXferBuffer dynamically allocating and freeing is a
>> process overhead. Hence used an existing Fifo8 buffer with
>> capacity of 16 bytes.
>>
>> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
>> ---
>>   include/hw/ssi/pnv_spi.h |   3 +
>>   hw/ssi/pnv_spi.c         | 237 +++++++++++++--------------------------
>>   2 files changed, 81 insertions(+), 159 deletions(-)
>>
>> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
>> index 8815f67d45..9878d9a25f 100644
>> --- a/include/hw/ssi/pnv_spi.h
>> +++ b/include/hw/ssi/pnv_spi.h
>> @@ -23,6 +23,7 @@
>>   
>>   #include "hw/ssi/ssi.h"
>>   #include "hw/sysbus.h"
>> +#include "qemu/fifo8.h"
>>   
>>   #define TYPE_PNV_SPI "pnv-spi"
>>   OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
>> @@ -37,6 +38,8 @@ typedef struct PnvSpi {
>>       SSIBus *ssi_bus;
>>       qemu_irq *cs_line;
>>       MemoryRegion    xscom_spic_regs;
>> +    Fifo8 tx_fifo;
>> +    Fifo8 rx_fifo;
>>       /* SPI object number */
>>       uint32_t        spic_num;
>>       uint8_t         transfer_len;
>> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
>> index 15e25bd1be..63d298980d 100644
>> --- a/hw/ssi/pnv_spi.c
>> +++ b/hw/ssi/pnv_spi.c
>> @@ -19,6 +19,7 @@
>>   
>>   #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
>>   #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
>> +#define PNV_SPI_FIFO_SIZE 16
>>   
>>   /*
>>    * Macro from include/hw/ppc/fdt.h
>> @@ -35,48 +36,14 @@
>>           }                                                          \
>>       } while (0)
>>   
>> -/* PnvXferBuffer */
>> -typedef struct PnvXferBuffer {
>> -
>> -    uint32_t    len;
>> -    uint8_t    *data;
>> -
>> -} PnvXferBuffer;
>> -
>> -/* pnv_spi_xfer_buffer_methods */
>> -static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
>> -{
>> -    PnvXferBuffer *payload = g_malloc0(sizeof(*payload));
>> -
>> -    return payload;
>> -}
>> -
>> -static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
>> -{
>> -    g_free(payload->data);
>> -    g_free(payload);
>> -}
>> -
>> -static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
>> -                uint32_t offset, uint32_t length)
>> -{
>> -    if (payload->len < (offset + length)) {
>> -        payload->len = offset + length;
>> -        payload->data = g_realloc(payload->data, payload->len);
>> -    }
>> -    return &payload->data[offset];
>> -}
>> -
>>   static bool does_rdr_match(PnvSpi *s)
>>   {
>>       /*
>>        * According to spec, the mask bits that are 0 are compared and the
>>        * bits that are 1 are ignored.
>>        */
>> -    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK,
>> -                                        s->regs[SPI_MM_REG]);
>> -    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL,
>> -                                        s->regs[SPI_MM_REG]);
>> +    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK, s->regs[SPI_MM_REG]);
>> +    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL, s->regs[SPI_MM_REG]);
>>   
>>       if ((~rdr_match_mask & rdr_match_val) == ((~rdr_match_mask) &
>>               GETFIELD(PPC_BITMASK(48, 63), s->regs[SPI_RCV_DATA_REG]))) {
> Usually try to avoid unrelated / cleanup in the same patch that acually
> changes things. In this case it's quite minor but it helps with review
> and rebasing to avoid.
>
> If it's on the same line or very close line to your change, or
> occasional ones I don't mind so much, but you have quite a few
> more further down the patch.
Sorry about that!. Should I create a new patch in v6 or keep it as is 
for now?

Going forward will create new patches for distinct changes.

Thank You.

>> @@ -107,8 +74,8 @@ static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)
>>       return byte;
>>   }
>>   
>> -static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
>> -                uint8_t ecc_count, uint8_t shift_in_count)
>> +static uint8_t read_from_frame(PnvSpi *s, uint8_t nr_bytes, uint8_t ecc_count,
>> +                uint8_t shift_in_count)
>>   {
>>       uint8_t byte;
>>       int count = 0;
>> @@ -118,20 +85,23 @@ static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
>>           if ((ecc_count != 0) &&
>>               (shift_in_count == (PNV_SPI_REG_SIZE + ecc_count))) {
>>               shift_in_count = 0;
>> -        } else {
>> -            byte = read_buf[count];
>> +        } else if (!fifo8_is_empty(&s->rx_fifo)) {
>> +            byte = fifo8_pop(&s->rx_fifo);
>>               trace_pnv_spi_shift_rx(byte, count);
>>               s->regs[SPI_RCV_DATA_REG] = (s->regs[SPI_RCV_DATA_REG] << 8) | byte;
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: Reading empty RX_FIFO\n");
>>           }
>>           count++;
>>       } /* end of while */
>>       return shift_in_count;
>>   }
>>   
>> -static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
>> +static void spi_response(PnvSpi *s)
>>   {
>>       uint8_t ecc_count;
>>       uint8_t shift_in_count;
>> +    uint32_t rx_len;
>>   
>>       /*
>>        * Processing here must handle:
>> @@ -144,13 +114,14 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
>>        * First check that the response payload is the exact same
>>        * number of bytes as the request payload was
>>        */
>> -    if (rsp_payload->len != (s->N1_bytes + s->N2_bytes)) {
>> +    rx_len = fifo8_num_used(&s->rx_fifo);
>> +    if (rx_len != (s->N1_bytes + s->N2_bytes)) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in "
>>                          "bytes, expected %d, got %d\n",
>> -                       (s->N1_bytes + s->N2_bytes), rsp_payload->len);
>> +                       (s->N1_bytes + s->N2_bytes), rx_len);
>>       } else {
>>           uint8_t ecc_control;
>> -        trace_pnv_spi_rx_received(rsp_payload->len);
>> +        trace_pnv_spi_rx_received(rx_len);
>>           trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
>>                           s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2_rx);
>>           /*
>> @@ -175,15 +146,12 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
>>           /* Handle the N1 portion of the frame first */
>>           if (s->N1_rx != 0) {
>>               trace_pnv_spi_rx_read_N1frame();
>> -            shift_in_count = read_from_frame(s, &rsp_payload->data[0],
>> -                            s->N1_bytes, ecc_count, shift_in_count);
>> +            shift_in_count = read_from_frame(s, s->N1_bytes, ecc_count, shift_in_count);
>>           }
>>           /* Handle the N2 portion of the frame */
>>           if (s->N2_rx != 0) {
>>               trace_pnv_spi_rx_read_N2frame();
>> -            shift_in_count = read_from_frame(s,
>> -                            &rsp_payload->data[s->N1_bytes], s->N2_bytes,
>> -                            ecc_count, shift_in_count);
>> +            shift_in_count = read_from_frame(s, s->N2_bytes, ecc_count, shift_in_count);
>>           }
>>           if ((s->N1_rx + s->N2_rx) > 0) {
>>               /*
>> @@ -210,36 +178,38 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
>>       } /* end of else */
>>   } /* end of spi_response() */
>>   
>> -static void transfer(PnvSpi *s, PnvXferBuffer *payload)
>> +static void transfer(PnvSpi *s)
>>   {
>> -    uint32_t tx;
>> -    uint32_t rx;
>> -    PnvXferBuffer *rsp_payload = NULL;
>> +    uint32_t tx, rx, payload_len;
>> +    uint8_t rx_byte;
>>   
>> -    rsp_payload = pnv_spi_xfer_buffer_new();
>> -    if (!rsp_payload) {
>> -        return;
>> -    }
>> -    for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
>> +    payload_len = fifo8_num_used(&s->tx_fifo);
>> +    for (int offset = 0; offset < payload_len; offset += s->transfer_len) {
>>           tx = 0;
>>           for (int i = 0; i < s->transfer_len; i++) {
>> -            if ((offset + i) >= payload->len) {
>> +            if ((offset + i) >= payload_len) {
>>                   tx <<= 8;
>> +            } else if (!fifo8_is_empty(&s->tx_fifo)) {
>> +                tx = (tx << 8) | fifo8_pop(&s->tx_fifo);
>>               } else {
>> -                tx = (tx << 8) | payload->data[offset + i];
>> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO underflow\n");
>>               }
>>           }
>>           rx = ssi_transfer(s->ssi_bus, tx);
>>           for (int i = 0; i < s->transfer_len; i++) {
>> -            if ((offset + i) >= payload->len) {
>> +            if (((offset + i) >= payload_len) || fifo8_is_full(&s->rx_fifo)) {
>>                   break;
>>               }
>> -            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, rsp_payload->len, 1)) =
>> -                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
>> +            rx_byte = (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
>> +            if (!fifo8_is_full(&s->rx_fifo)) {
>> +                fifo8_push(&s->rx_fifo, rx_byte);
>> +            }
>>           }
>>       }
>> -    spi_response(s, s->N1_bits, rsp_payload);
>> -    pnv_spi_xfer_buffer_free(rsp_payload);
>> +    spi_response(s);
>> +    /* Reset fifo for next frame */
>> +    fifo8_reset(&s->tx_fifo);
>> +    fifo8_reset(&s->rx_fifo);
>>   }
>>   
>>   static inline uint8_t get_seq_index(PnvSpi *s)
>> @@ -310,13 +280,11 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
>>                * If Forced Implicit mode and count control doesn't
>>                * indicate transmit then reset the tx count to 0
>>                */
>> -            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
>> -                                    s->regs[SPI_CTR_CFG_REG]) == 0) {
>> +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2, s->regs[SPI_CTR_CFG_REG]) == 0) {
>>                   s->N1_tx = 0;
>>               }
>>               /* If rx count control for N1 is set, load the rx value */
>> -            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
>> -                                    s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3, s->regs[SPI_CTR_CFG_REG]) == 1) {
>>                   s->N1_rx = s->N1_bytes;
>>               }
>>           }
>> @@ -328,8 +296,7 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
>>        * cap the size at a max of 64 bits or 72 bits and set the sequencer FSM
>>        * error bit.
>>        */
>> -    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
>> -                                   s->regs[SPI_CLK_CFG_REG]);
>> +    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL, s->regs[SPI_CLK_CFG_REG]);
>>       if (ecc_control == 0 || ecc_control == 2) {
>>           if (s->N1_bytes > (PNV_SPI_REG_SIZE + 1)) {
>>               qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size when "
>> @@ -340,8 +307,7 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
>>           }
>>       } else if (s->N1_bytes > PNV_SPI_REG_SIZE) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
>> -                      "bytes = 0x%x, bits = 0x%x\n",
>> -                      s->N1_bytes, s->N1_bits);
>> +                      "bytes = 0x%x, bits = 0x%x\n", s->N1_bytes, s->N1_bits);
>>           s->N1_bytes = PNV_SPI_REG_SIZE;
>>           s->N1_bits = s->N1_bytes * 8;
>>       }
>> @@ -350,19 +316,10 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
>>   /*
>>    * Shift_N1 operation handler method
>>    */
>> -static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
>> -                       PnvXferBuffer **payload, bool send_n1_alone)
>> +static bool operation_shiftn1(PnvSpi *s, uint8_t opcode, bool send_n1_alone)
>>   {
>>       uint8_t n1_count;
>>       bool stop = false;
>> -
>> -    /*
>> -     * If there isn't a current payload left over from a stopped sequence
>> -     * create a new one.
>> -     */
>> -    if (*payload == NULL) {
>> -        *payload = pnv_spi_xfer_buffer_new();
>> -    }
>>       /*
>>        * Use a combination of N1 counters to build the N1 portion of the
>>        * transmit payload.
>> @@ -413,9 +370,10 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
>>                    */
>>                   uint8_t n1_byte = 0x00;
>>                   n1_byte = get_from_offset(s, n1_count);
>> -                trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
>> -                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1)) =
>> -                        n1_byte;
>> +                if (!fifo8_is_full(&s->tx_fifo)) {
>> +                    trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
>> +                    fifo8_push(&s->tx_fifo, n1_byte);
>> +                }
>>               } else {
>>                   /*
>>                    * We hit a shift_n1 opcode TX but the TDR is empty, tell the
>> @@ -436,16 +394,14 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
>>                * - we are receiving and the RDR is empty so we allow the operation
>>                *   to proceed.
>>                */
>> -            if ((s->N1_rx != 0) && (GETFIELD(SPI_STS_RDR_FULL,
>> -                                           s->status) == 1)) {
>> +            if ((s->N1_rx != 0) && (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1)) {
>>                   trace_pnv_spi_sequencer_stop_requested("shift N1"
>>                                   "set for receive but RDR is full");
>>                   stop = true;
>>                   break;
>> -            } else {
>> +            } else if (!fifo8_is_full(&s->tx_fifo)) {
>>                   trace_pnv_spi_tx_append_FF("n1_byte");
>> -                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
>> -                        = 0xff;
>> +                fifo8_push(&s->tx_fifo, 0xff);
>>               }
> Is there any problem or overrun that needs to be logged if the
> fifo is full in the above two places?
Will add a error log upon hitting the overflow. Thank You.
>>           }
>>           n1_count++;
>> @@ -486,15 +442,13 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
>>        */
>>       if (send_n1_alone && !stop) {
>>           /* We have a TX and a full TDR or an RX and an empty RDR */
>> -        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)->len);
>> -        transfer(s, *payload);
>> +        trace_pnv_spi_tx_request("Shifting N1 frame", fifo8_num_used(&s->tx_fifo));
>> +        transfer(s);
>>           /* The N1 frame shift is complete so reset the N1 counters */
>>           s->N2_bits = 0;
>>           s->N2_bytes = 0;
>>           s->N2_tx = 0;
>>           s->N2_rx = 0;
>> -        pnv_spi_xfer_buffer_free(*payload);
>> -        *payload = NULL;
>>       }
>>       return stop;
>>   } /* end of operation_shiftn1() */
>> @@ -552,13 +506,11 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
>>                * If Forced Implicit mode and count control doesn't
>>                * indicate a receive then reset the rx count to 0
>>                */
>> -            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
>> -                                    s->regs[SPI_CTR_CFG_REG]) == 0) {
>> +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3, s->regs[SPI_CTR_CFG_REG]) == 0) {
>>                   s->N2_rx = 0;
>>               }
>>               /* If tx count control for N2 is set, load the tx value */
>> -            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
>> -                                    s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2, s->regs[SPI_CTR_CFG_REG]) == 1) {
>>                   s->N2_tx = s->N2_bytes;
>>               }
>>           }
>> @@ -571,8 +523,7 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
>>        * cap the size at a max of 64 bits or 72 bits and set the sequencer FSM
>>        * error bit.
>>        */
>> -    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
>> -                    s->regs[SPI_CLK_CFG_REG]);
>> +    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL, s->regs[SPI_CLK_CFG_REG]);
>>       if (ecc_control == 0 || ecc_control == 2) {
>>           if (s->N2_bytes > (PNV_SPI_REG_SIZE + 1)) {
>>               /* Unsupported N2 shift size when ECC enabled */
>> @@ -590,19 +541,10 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
>>    * Shift_N2 operation handler method
>>    */
>>   
>> -static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
>> -                       PnvXferBuffer **payload)
>> +static bool operation_shiftn2(PnvSpi *s, uint8_t opcode)
>>   {
>>       uint8_t n2_count;
>>       bool stop = false;
>> -
>> -    /*
>> -     * If there isn't a current payload left over from a stopped sequence
>> -     * create a new one.
>> -     */
>> -    if (*payload == NULL) {
>> -        *payload = pnv_spi_xfer_buffer_new();
>> -    }
>>       /*
>>        * Use a combination of N2 counters to build the N2 portion of the
>>        * transmit payload.
>> @@ -629,44 +571,41 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
>>            * code continue will end up building the payload twice in the same
>>            * buffer since RDR full causes a sequence stop and restart.
>>            */
>> -        if ((s->N2_rx != 0) &&
>> -            (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1)) {
>> +        if ((s->N2_rx != 0) && (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1)) {
>>               trace_pnv_spi_sequencer_stop_requested("shift N2 set"
>>                               "for receive but RDR is full");
>>               stop = true;
>>               break;
>>           }
>> -        if ((s->N2_tx != 0) && ((s->N1_tx + n2_count) <
>> -                                PNV_SPI_REG_SIZE)) {
>> +        if ((s->N2_tx != 0) && ((s->N1_tx + n2_count) < PNV_SPI_REG_SIZE)) {
>>               /* Always append data for the N2 segment if it is set for TX */
>>               uint8_t n2_byte = 0x00;
>>               n2_byte = get_from_offset(s, (s->N1_tx + n2_count));
>> -            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + n2_count));
>> -            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
>> -                    = n2_byte;
>> -        } else {
>> +            if (!fifo8_is_full(&s->tx_fifo)) {
>> +                trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + n2_count));
>> +                fifo8_push(&s->tx_fifo, n2_byte);
>> +            }
>> +        } else if (!fifo8_is_full(&s->tx_fifo)) {
>>               /*
>>                * Regardless of whether or not N2 is set for TX or RX, we need
>>                * the number of bytes in the payload to match the overall length
>>                * of the operation.
>>                */
>>               trace_pnv_spi_tx_append_FF("n2_byte");
>> -            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
>> -                    = 0xff;
>> +            fifo8_push(&s->tx_fifo, 0xff);
>>           }
>>           n2_count++;
>>       } /* end of while */
>>       if (!stop) {
>>           /* We have a TX and a full TDR or an RX and an empty RDR */
>> -        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)->len);
>> -        transfer(s, *payload);
>> +        trace_pnv_spi_tx_request("Shifting N2 frame", fifo8_num_used(&s->tx_fifo));
>> +        transfer(s);
>>           /*
>>            * If we are doing an N2 TX and the TDR is full we need to clear the
>>            * TDR_full status. Do this here instead of up in the loop above so we
>>            * don't log the message in every loop iteration.
>>            */
>> -        if ((s->N2_tx != 0) &&
>> -            (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1)) {
>> +        if ((s->N2_tx != 0) && (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1)) {
>>               s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
>>           }
>>           /*
>> @@ -682,8 +621,6 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
>>           s->N1_bytes = 0;
>>           s->N1_tx = 0;
>>           s->N1_rx = 0;
>> -        pnv_spi_xfer_buffer_free(*payload);
>> -        *payload = NULL;
>>       }
>>       return stop;
>>   } /*  end of operation_shiftn2()*/
>> @@ -701,19 +638,6 @@ static void operation_sequencer(PnvSpi *s)
>>       uint8_t opcode = 0;
>>       uint8_t masked_opcode = 0;
>>   
>> -    /*
>> -     * PnvXferBuffer for containing the payload of the SPI frame.
>> -     * This is a static because there are cases where a sequence has to stop
>> -     * and wait for the target application to unload the RDR.  If this occurs
>> -     * during a sequence where N1 is not sent alone and instead combined with
>> -     * N2 since the N1 tx length + the N2 tx length is less than the size of
>> -     * the TDR.
>> -     */
>> -    static PnvXferBuffer *payload;
>> -
>> -    if (payload == NULL) {
>> -        payload = pnv_spi_xfer_buffer_new();
>> -    }
>>       /*
>>        * Clear the sequencer FSM error bit - general_SPI_status[3]
>>        * before starting a sequence.
>> @@ -775,10 +699,8 @@ static void operation_sequencer(PnvSpi *s)
>>                   s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_DONE);
>>               } else if (s->responder_select != 1) {
>>                   qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
>> -                              "not supported, select = 0x%x\n",
>> -                               s->responder_select);
>> -                trace_pnv_spi_sequencer_stop_requested("invalid "
>> -                                "responder select");
>> +                              "not supported, select = 0x%x\n", s->responder_select);
>> +                trace_pnv_spi_sequencer_stop_requested("invalid responder select");
>>                   s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
>>                   stop = true;
>>               } else {
>> @@ -840,9 +762,8 @@ static void operation_sequencer(PnvSpi *s)
>>                                   == SEQ_OP_SHIFT_N2) {
>>                       send_n1_alone = false;
>>                   }
>> -                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>> -                                FSM_SHIFT_N1);
>> -                stop = operation_shiftn1(s, opcode, &payload, send_n1_alone);
>> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_SHIFT_N1);
>> +                stop = operation_shiftn1(s, opcode, send_n1_alone);
>>                   if (stop) {
>>                       /*
>>                        *  The operation code says to stop, this can occur if:
>> @@ -858,7 +779,7 @@ static void operation_sequencer(PnvSpi *s)
>>                       if (GETFIELD(SPI_STS_TDR_UNDERRUN, s->status)) {
>>                           s->shift_n1_done = true;
>>                           s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>> -                                                  FSM_SHIFT_N2);
>> +                                        FSM_SHIFT_N2);
>>                           s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
>>                                           (get_seq_index(s) + 1));
>>                       } else {
>> @@ -866,8 +787,7 @@ static void operation_sequencer(PnvSpi *s)
>>                            * This is case (1) or (2) so the sequencer needs to
>>                            * wait and NOT go to the next sequence yet.
>>                            */
>> -                        s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>> -                                        FSM_WAIT);
>> +                        s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_WAIT);
>>                       }
>>                   } else {
>>                       /* Ok to move on to the next index */
>> @@ -890,21 +810,18 @@ static void operation_sequencer(PnvSpi *s)
>>                    * error bit 3 (general_SPI_status[3]) in status reg.
>>                    */
>>                   s->status = SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 1);
>> -                trace_pnv_spi_sequencer_stop_requested("shift_n2 "
>> -                                    "w/no shift_n1 done");
>> +                trace_pnv_spi_sequencer_stop_requested("shift_n2 w/no shift_n1 done");
>>                   stop = true;
>>               } else {
>>                   /* Ok to do a Shift_N2 */
>> -                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>> -                                FSM_SHIFT_N2);
>> -                stop = operation_shiftn2(s, opcode, &payload);
>> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_SHIFT_N2);
>> +                stop = operation_shiftn2(s, opcode);
>>                   /*
>>                    * If the operation code says to stop set the shifter state to
>>                    * wait and stop
>>                    */
>>                   if (stop) {
>> -                    s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>> -                                    FSM_WAIT);
>> +                    s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_WAIT);
>>                   } else {
>>                       /* Ok to move on to the next index */
>>                       next_sequencer_fsm(s);
>> @@ -988,8 +905,7 @@ static void operation_sequencer(PnvSpi *s)
>>           case SEQ_OP_BRANCH_IFNEQ_INC_2:
>>               s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
>>               trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", get_seq_index(s));
>> -            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2,
>> -                              s->regs[SPI_CTR_CFG_REG]);
>> +            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2, s->regs[SPI_CTR_CFG_REG]);
>>               /*
>>                * The spec says the loop should execute count compare + 1 times.
>>                * However we learned from engineering that we really only loop
>> @@ -1209,6 +1125,9 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
>>       s->cs_line = g_new0(qemu_irq, 1);
>>       qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
>>   
>> +    fifo8_create(&s->tx_fifo, PNV_SPI_FIFO_SIZE);
>> +    fifo8_create(&s->rx_fifo, PNV_SPI_FIFO_SIZE);
>> +
>>       /* spi scoms */
>>       pnv_xscom_region_init(&s->xscom_spic_regs, OBJECT(s), &pnv_spi_xscom_ops,
>>                             s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
> Aside from those small nits, it looks like a good cleanup and
> improvement with more error logging.
>
> Thanks,
> Nick
--------------D0K9h9bmFtkI0bqtZIMy0CpB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello Nick,</p>
    <p>Thank You for reviewing this series.  <br>
    </p>
    <div class="moz-cite-prefix">On 27-02-2025 07:09, Nicholas Piggin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:D82UFOB22C3K.31271R5VWD0LU@gmail.com">
      <pre wrap="" class="moz-quote-pre">On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">In PnvXferBuffer dynamically allocating and freeing is a
process overhead. Hence used an existing Fifo8 buffer with
capacity of 16 bytes.

Signed-off-by: Chalapathi V <a class="moz-txt-link-rfc2396E" href="mailto:chalapathi.v@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a>
---
 include/hw/ssi/pnv_spi.h |   3 +
 hw/ssi/pnv_spi.c         | 237 +++++++++++++--------------------------
 2 files changed, 81 insertions(+), 159 deletions(-)

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
index 15e25bd1be..63d298980d 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -19,6 +19,7 @@
 
 #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x &amp; 0x0F)
 #define PNV_SPI_MASKED_OPCODE(x) (x &amp; 0xF0)
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
-    g_free(payload-&gt;data);
-    g_free(payload);
-}
-
-static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
-                uint32_t offset, uint32_t length)
-{
-    if (payload-&gt;len &lt; (offset + length)) {
-        payload-&gt;len = offset + length;
-        payload-&gt;data = g_realloc(payload-&gt;data, payload-&gt;len);
-    }
-    return &amp;payload-&gt;data[offset];
-}
-
 static bool does_rdr_match(PnvSpi *s)
 {
     /*
      * According to spec, the mask bits that are 0 are compared and the
      * bits that are 1 are ignored.
      */
-    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK,
-                                        s-&gt;regs[SPI_MM_REG]);
-    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL,
-                                        s-&gt;regs[SPI_MM_REG]);
+    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK, s-&gt;regs[SPI_MM_REG]);
+    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL, s-&gt;regs[SPI_MM_REG]);
 
     if ((~rdr_match_mask &amp; rdr_match_val) == ((~rdr_match_mask) &amp;
             GETFIELD(PPC_BITMASK(48, 63), s-&gt;regs[SPI_RCV_DATA_REG]))) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Usually try to avoid unrelated / cleanup in the same patch that acually
changes things. In this case it's quite minor but it helps with review
and rebasing to avoid.

If it's on the same line or very close line to your change, or
occasional ones I don't mind so much, but you have quite a few
more further down the patch.
</pre>
    </blockquote>
    Sorry about that!. Should I create a new patch in v6 or keep it as
    is for now?<br>
    <p>Going forward will create new patches for distinct changes.</p>
    <p>Thank You.<br>
    </p>
    <blockquote type="cite"
      cite="mid:D82UFOB22C3K.31271R5VWD0LU@gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">@@ -107,8 +74,8 @@ static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)
     return byte;
 }
 
-static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
-                uint8_t ecc_count, uint8_t shift_in_count)
+static uint8_t read_from_frame(PnvSpi *s, uint8_t nr_bytes, uint8_t ecc_count,
+                uint8_t shift_in_count)
 {
     uint8_t byte;
     int count = 0;
@@ -118,20 +85,23 @@ static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
         if ((ecc_count != 0) &amp;&amp;
             (shift_in_count == (PNV_SPI_REG_SIZE + ecc_count))) {
             shift_in_count = 0;
-        } else {
-            byte = read_buf[count];
+        } else if (!fifo8_is_empty(&amp;s-&gt;rx_fifo)) {
+            byte = fifo8_pop(&amp;s-&gt;rx_fifo);
             trace_pnv_spi_shift_rx(byte, count);
             s-&gt;regs[SPI_RCV_DATA_REG] = (s-&gt;regs[SPI_RCV_DATA_REG] &lt;&lt; 8) | byte;
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
 
     /*
      * Processing here must handle:
@@ -144,13 +114,14 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
      * First check that the response payload is the exact same
      * number of bytes as the request payload was
      */
-    if (rsp_payload-&gt;len != (s-&gt;N1_bytes + s-&gt;N2_bytes)) {
+    rx_len = fifo8_num_used(&amp;s-&gt;rx_fifo);
+    if (rx_len != (s-&gt;N1_bytes + s-&gt;N2_bytes)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in "
                        "bytes, expected %d, got %d\n",
-                       (s-&gt;N1_bytes + s-&gt;N2_bytes), rsp_payload-&gt;len);
+                       (s-&gt;N1_bytes + s-&gt;N2_bytes), rx_len);
     } else {
         uint8_t ecc_control;
-        trace_pnv_spi_rx_received(rsp_payload-&gt;len);
+        trace_pnv_spi_rx_received(rx_len);
         trace_pnv_spi_log_Ncounts(s-&gt;N1_bits, s-&gt;N1_bytes, s-&gt;N1_tx,
                         s-&gt;N1_rx, s-&gt;N2_bits, s-&gt;N2_bytes, s-&gt;N2_tx, s-&gt;N2_rx);
         /*
@@ -175,15 +146,12 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
         /* Handle the N1 portion of the frame first */
         if (s-&gt;N1_rx != 0) {
             trace_pnv_spi_rx_read_N1frame();
-            shift_in_count = read_from_frame(s, &amp;rsp_payload-&gt;data[0],
-                            s-&gt;N1_bytes, ecc_count, shift_in_count);
+            shift_in_count = read_from_frame(s, s-&gt;N1_bytes, ecc_count, shift_in_count);
         }
         /* Handle the N2 portion of the frame */
         if (s-&gt;N2_rx != 0) {
             trace_pnv_spi_rx_read_N2frame();
-            shift_in_count = read_from_frame(s,
-                            &amp;rsp_payload-&gt;data[s-&gt;N1_bytes], s-&gt;N2_bytes,
-                            ecc_count, shift_in_count);
+            shift_in_count = read_from_frame(s, s-&gt;N2_bytes, ecc_count, shift_in_count);
         }
         if ((s-&gt;N1_rx + s-&gt;N2_rx) &gt; 0) {
             /*
@@ -210,36 +178,38 @@ static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
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
-    for (int offset = 0; offset &lt; payload-&gt;len; offset += s-&gt;transfer_len) {
+    payload_len = fifo8_num_used(&amp;s-&gt;tx_fifo);
+    for (int offset = 0; offset &lt; payload_len; offset += s-&gt;transfer_len) {
         tx = 0;
         for (int i = 0; i &lt; s-&gt;transfer_len; i++) {
-            if ((offset + i) &gt;= payload-&gt;len) {
+            if ((offset + i) &gt;= payload_len) {
                 tx &lt;&lt;= 8;
+            } else if (!fifo8_is_empty(&amp;s-&gt;tx_fifo)) {
+                tx = (tx &lt;&lt; 8) | fifo8_pop(&amp;s-&gt;tx_fifo);
             } else {
-                tx = (tx &lt;&lt; 8) | payload-&gt;data[offset + i];
+                qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: TX_FIFO underflow\n");
             }
         }
         rx = ssi_transfer(s-&gt;ssi_bus, tx);
         for (int i = 0; i &lt; s-&gt;transfer_len; i++) {
-            if ((offset + i) &gt;= payload-&gt;len) {
+            if (((offset + i) &gt;= payload_len) || fifo8_is_full(&amp;s-&gt;rx_fifo)) {
                 break;
             }
-            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, rsp_payload-&gt;len, 1)) =
-                    (rx &gt;&gt; (8 * (s-&gt;transfer_len - 1) - i * 8)) &amp; 0xFF;
+            rx_byte = (rx &gt;&gt; (8 * (s-&gt;transfer_len - 1) - i * 8)) &amp; 0xFF;
+            if (!fifo8_is_full(&amp;s-&gt;rx_fifo)) {
+                fifo8_push(&amp;s-&gt;rx_fifo, rx_byte);
+            }
         }
     }
-    spi_response(s, s-&gt;N1_bits, rsp_payload);
-    pnv_spi_xfer_buffer_free(rsp_payload);
+    spi_response(s);
+    /* Reset fifo for next frame */
+    fifo8_reset(&amp;s-&gt;tx_fifo);
+    fifo8_reset(&amp;s-&gt;rx_fifo);
 }
 
 static inline uint8_t get_seq_index(PnvSpi *s)
@@ -310,13 +280,11 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
              * If Forced Implicit mode and count control doesn't
              * indicate transmit then reset the tx count to 0
              */
-            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
-                                    s-&gt;regs[SPI_CTR_CFG_REG]) == 0) {
+            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2, s-&gt;regs[SPI_CTR_CFG_REG]) == 0) {
                 s-&gt;N1_tx = 0;
             }
             /* If rx count control for N1 is set, load the rx value */
-            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
-                                    s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
+            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3, s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
                 s-&gt;N1_rx = s-&gt;N1_bytes;
             }
         }
@@ -328,8 +296,7 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
      * cap the size at a max of 64 bits or 72 bits and set the sequencer FSM
      * error bit.
      */
-    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
-                                   s-&gt;regs[SPI_CLK_CFG_REG]);
+    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL, s-&gt;regs[SPI_CLK_CFG_REG]);
     if (ecc_control == 0 || ecc_control == 2) {
         if (s-&gt;N1_bytes &gt; (PNV_SPI_REG_SIZE + 1)) {
             qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size when "
@@ -340,8 +307,7 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
         }
     } else if (s-&gt;N1_bytes &gt; PNV_SPI_REG_SIZE) {
         qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
-                      "bytes = 0x%x, bits = 0x%x\n",
-                      s-&gt;N1_bytes, s-&gt;N1_bits);
+                      "bytes = 0x%x, bits = 0x%x\n", s-&gt;N1_bytes, s-&gt;N1_bits);
         s-&gt;N1_bytes = PNV_SPI_REG_SIZE;
         s-&gt;N1_bits = s-&gt;N1_bytes * 8;
     }
@@ -350,19 +316,10 @@ static void calculate_N1(PnvSpi *s, uint8_t opcode)
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
@@ -413,9 +370,10 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
                  */
                 uint8_t n1_byte = 0x00;
                 n1_byte = get_from_offset(s, n1_count);
-                trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
-                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)-&gt;len, 1)) =
-                        n1_byte;
+                if (!fifo8_is_full(&amp;s-&gt;tx_fifo)) {
+                    trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
+                    fifo8_push(&amp;s-&gt;tx_fifo, n1_byte);
+                }
             } else {
                 /*
                  * We hit a shift_n1 opcode TX but the TDR is empty, tell the
@@ -436,16 +394,14 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
              * - we are receiving and the RDR is empty so we allow the operation
              *   to proceed.
              */
-            if ((s-&gt;N1_rx != 0) &amp;&amp; (GETFIELD(SPI_STS_RDR_FULL,
-                                           s-&gt;status) == 1)) {
+            if ((s-&gt;N1_rx != 0) &amp;&amp; (GETFIELD(SPI_STS_RDR_FULL, s-&gt;status) == 1)) {
                 trace_pnv_spi_sequencer_stop_requested("shift N1"
                                 "set for receive but RDR is full");
                 stop = true;
                 break;
-            } else {
+            } else if (!fifo8_is_full(&amp;s-&gt;tx_fifo)) {
                 trace_pnv_spi_tx_append_FF("n1_byte");
-                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)-&gt;len, 1))
-                        = 0xff;
+                fifo8_push(&amp;s-&gt;tx_fifo, 0xff);
             }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Is there any problem or overrun that needs to be logged if the
fifo is full in the above two places?
</pre>
    </blockquote>
    Will add a error log upon hitting the overflow. Thank You.<span
    style="white-space: pre-wrap">
</span>
    <blockquote type="cite"
      cite="mid:D82UFOB22C3K.31271R5VWD0LU@gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">         }
         n1_count++;
@@ -486,15 +442,13 @@ static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
      */
     if (send_n1_alone &amp;&amp; !stop) {
         /* We have a TX and a full TDR or an RX and an empty RDR */
-        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)-&gt;len);
-        transfer(s, *payload);
+        trace_pnv_spi_tx_request("Shifting N1 frame", fifo8_num_used(&amp;s-&gt;tx_fifo));
+        transfer(s);
         /* The N1 frame shift is complete so reset the N1 counters */
         s-&gt;N2_bits = 0;
         s-&gt;N2_bytes = 0;
         s-&gt;N2_tx = 0;
         s-&gt;N2_rx = 0;
-        pnv_spi_xfer_buffer_free(*payload);
-        *payload = NULL;
     }
     return stop;
 } /* end of operation_shiftn1() */
@@ -552,13 +506,11 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
              * If Forced Implicit mode and count control doesn't
              * indicate a receive then reset the rx count to 0
              */
-            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
-                                    s-&gt;regs[SPI_CTR_CFG_REG]) == 0) {
+            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3, s-&gt;regs[SPI_CTR_CFG_REG]) == 0) {
                 s-&gt;N2_rx = 0;
             }
             /* If tx count control for N2 is set, load the tx value */
-            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
-                                    s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
+            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2, s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
                 s-&gt;N2_tx = s-&gt;N2_bytes;
             }
         }
@@ -571,8 +523,7 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
      * cap the size at a max of 64 bits or 72 bits and set the sequencer FSM
      * error bit.
      */
-    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
-                    s-&gt;regs[SPI_CLK_CFG_REG]);
+    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL, s-&gt;regs[SPI_CLK_CFG_REG]);
     if (ecc_control == 0 || ecc_control == 2) {
         if (s-&gt;N2_bytes &gt; (PNV_SPI_REG_SIZE + 1)) {
             /* Unsupported N2 shift size when ECC enabled */
@@ -590,19 +541,10 @@ static void calculate_N2(PnvSpi *s, uint8_t opcode)
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
@@ -629,44 +571,41 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
          * code continue will end up building the payload twice in the same
          * buffer since RDR full causes a sequence stop and restart.
          */
-        if ((s-&gt;N2_rx != 0) &amp;&amp;
-            (GETFIELD(SPI_STS_RDR_FULL, s-&gt;status) == 1)) {
+        if ((s-&gt;N2_rx != 0) &amp;&amp; (GETFIELD(SPI_STS_RDR_FULL, s-&gt;status) == 1)) {
             trace_pnv_spi_sequencer_stop_requested("shift N2 set"
                             "for receive but RDR is full");
             stop = true;
             break;
         }
-        if ((s-&gt;N2_tx != 0) &amp;&amp; ((s-&gt;N1_tx + n2_count) &lt;
-                                PNV_SPI_REG_SIZE)) {
+        if ((s-&gt;N2_tx != 0) &amp;&amp; ((s-&gt;N1_tx + n2_count) &lt; PNV_SPI_REG_SIZE)) {
             /* Always append data for the N2 segment if it is set for TX */
             uint8_t n2_byte = 0x00;
             n2_byte = get_from_offset(s, (s-&gt;N1_tx + n2_count));
-            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s-&gt;N1_tx + n2_count));
-            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)-&gt;len, 1))
-                    = n2_byte;
-        } else {
+            if (!fifo8_is_full(&amp;s-&gt;tx_fifo)) {
+                trace_pnv_spi_tx_append("n2_byte", n2_byte, (s-&gt;N1_tx + n2_count));
+                fifo8_push(&amp;s-&gt;tx_fifo, n2_byte);
+            }
+        } else if (!fifo8_is_full(&amp;s-&gt;tx_fifo)) {
             /*
              * Regardless of whether or not N2 is set for TX or RX, we need
              * the number of bytes in the payload to match the overall length
              * of the operation.
              */
             trace_pnv_spi_tx_append_FF("n2_byte");
-            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)-&gt;len, 1))
-                    = 0xff;
+            fifo8_push(&amp;s-&gt;tx_fifo, 0xff);
         }
         n2_count++;
     } /* end of while */
     if (!stop) {
         /* We have a TX and a full TDR or an RX and an empty RDR */
-        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)-&gt;len);
-        transfer(s, *payload);
+        trace_pnv_spi_tx_request("Shifting N2 frame", fifo8_num_used(&amp;s-&gt;tx_fifo));
+        transfer(s);
         /*
          * If we are doing an N2 TX and the TDR is full we need to clear the
          * TDR_full status. Do this here instead of up in the loop above so we
          * don't log the message in every loop iteration.
          */
-        if ((s-&gt;N2_tx != 0) &amp;&amp;
-            (GETFIELD(SPI_STS_TDR_FULL, s-&gt;status) == 1)) {
+        if ((s-&gt;N2_tx != 0) &amp;&amp; (GETFIELD(SPI_STS_TDR_FULL, s-&gt;status) == 1)) {
             s-&gt;status = SETFIELD(SPI_STS_TDR_FULL, s-&gt;status, 0);
         }
         /*
@@ -682,8 +621,6 @@ static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
         s-&gt;N1_bytes = 0;
         s-&gt;N1_tx = 0;
         s-&gt;N1_rx = 0;
-        pnv_spi_xfer_buffer_free(*payload);
-        *payload = NULL;
     }
     return stop;
 } /*  end of operation_shiftn2()*/
@@ -701,19 +638,6 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -775,10 +699,8 @@ static void operation_sequencer(PnvSpi *s)
                 s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status, FSM_DONE);
             } else if (s-&gt;responder_select != 1) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
-                              "not supported, select = 0x%x\n",
-                               s-&gt;responder_select);
-                trace_pnv_spi_sequencer_stop_requested("invalid "
-                                "responder select");
+                              "not supported, select = 0x%x\n", s-&gt;responder_select);
+                trace_pnv_spi_sequencer_stop_requested("invalid responder select");
                 s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status, FSM_IDLE);
                 stop = true;
             } else {
@@ -840,9 +762,8 @@ static void operation_sequencer(PnvSpi *s)
                                 == SEQ_OP_SHIFT_N2) {
                     send_n1_alone = false;
                 }
-                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,
-                                FSM_SHIFT_N1);
-                stop = operation_shiftn1(s, opcode, &amp;payload, send_n1_alone);
+                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status, FSM_SHIFT_N1);
+                stop = operation_shiftn1(s, opcode, send_n1_alone);
                 if (stop) {
                     /*
                      *  The operation code says to stop, this can occur if:
@@ -858,7 +779,7 @@ static void operation_sequencer(PnvSpi *s)
                     if (GETFIELD(SPI_STS_TDR_UNDERRUN, s-&gt;status)) {
                         s-&gt;shift_n1_done = true;
                         s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,
-                                                  FSM_SHIFT_N2);
+                                        FSM_SHIFT_N2);
                         s-&gt;status = SETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status,
                                         (get_seq_index(s) + 1));
                     } else {
@@ -866,8 +787,7 @@ static void operation_sequencer(PnvSpi *s)
                          * This is case (1) or (2) so the sequencer needs to
                          * wait and NOT go to the next sequence yet.
                          */
-                        s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,
-                                        FSM_WAIT);
+                        s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status, FSM_WAIT);
                     }
                 } else {
                     /* Ok to move on to the next index */
@@ -890,21 +810,18 @@ static void operation_sequencer(PnvSpi *s)
                  * error bit 3 (general_SPI_status[3]) in status reg.
                  */
                 s-&gt;status = SETFIELD(SPI_STS_GEN_STATUS_B3, s-&gt;status, 1);
-                trace_pnv_spi_sequencer_stop_requested("shift_n2 "
-                                    "w/no shift_n1 done");
+                trace_pnv_spi_sequencer_stop_requested("shift_n2 w/no shift_n1 done");
                 stop = true;
             } else {
                 /* Ok to do a Shift_N2 */
-                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,
-                                FSM_SHIFT_N2);
-                stop = operation_shiftn2(s, opcode, &amp;payload);
+                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status, FSM_SHIFT_N2);
+                stop = operation_shiftn2(s, opcode);
                 /*
                  * If the operation code says to stop set the shifter state to
                  * wait and stop
                  */
                 if (stop) {
-                    s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,
-                                    FSM_WAIT);
+                    s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status, FSM_WAIT);
                 } else {
                     /* Ok to move on to the next index */
                     next_sequencer_fsm(s);
@@ -988,8 +905,7 @@ static void operation_sequencer(PnvSpi *s)
         case SEQ_OP_BRANCH_IFNEQ_INC_2:
             s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status, SEQ_STATE_EXECUTE);
             trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", get_seq_index(s));
-            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2,
-                              s-&gt;regs[SPI_CTR_CFG_REG]);
+            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2, s-&gt;regs[SPI_CTR_CFG_REG]);
             /*
              * The spec says the loop should execute count compare + 1 times.
              * However we learned from engineering that we really only loop
@@ -1209,6 +1125,9 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
     s-&gt;cs_line = g_new0(qemu_irq, 1);
     qdev_init_gpio_out_named(DEVICE(s), s-&gt;cs_line, "cs", 1);
 
+    fifo8_create(&amp;s-&gt;tx_fifo, PNV_SPI_FIFO_SIZE);
+    fifo8_create(&amp;s-&gt;rx_fifo, PNV_SPI_FIFO_SIZE);
+
     /* spi scoms */
     pnv_xscom_region_init(&amp;s-&gt;xscom_spic_regs, OBJECT(s), &amp;pnv_spi_xscom_ops,
                           s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Aside from those small nits, it looks like a good cleanup and
improvement with more error logging.

Thanks,
Nick
</pre>
    </blockquote>
  </body>
</html>

--------------D0K9h9bmFtkI0bqtZIMy0CpB--


