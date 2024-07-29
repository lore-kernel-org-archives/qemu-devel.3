Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA251C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTPa-0006nA-RB; Mon, 29 Jul 2024 12:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sYTPY-0006kj-EC; Mon, 29 Jul 2024 12:39:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sYTPI-0006ra-Iv; Mon, 29 Jul 2024 12:39:40 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFPPoR016989;
 Mon, 29 Jul 2024 16:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:message-id:date:mime-version:subject:to:cc
 :references:from:in-reply-to; s=pp1; bh=XKR1KNQdy4g0PYDCr82lqaoH
 KtHEg4KwIdymkS3l/Y0=; b=VxQ7TcuGKG96Kf8zepgW0gnzM/lvMLD1+oY4sagE
 bOePUkL1cyjfiW/KvvEZH6vSsPV0NTXOrTngUsUwJdSA+44Z8q8AjiNC45UaVdvx
 OfO2LgY2kq4y9L3pg5aR7JVsxnW/qx0twMgGD3TE0+DkRdLE7AelhJIkd3+pB1JG
 23kb+FJVC2SJREwXtby2eHYZEC+HBP+qyHYCJHJJw58YKEUNWD2MyYX0IOjiAUTc
 +FR7Gi6gh7pTAf57tQMp3y7ExK8UyT689GPkZUgSgYa4N0WEoi4Qqm9mExyZMtLZ
 94PYFXiuTpmWuC5fo+l1Rrb1VnEdiKxcehLSVlPggbdQvQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pdcnr7vw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 16:39:21 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46TGdL9O014999;
 Mon, 29 Jul 2024 16:39:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pdcnr7vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 16:39:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46TECQKl018863; Mon, 29 Jul 2024 16:39:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7pfq91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 16:39:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46TGdFu056754680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jul 2024 16:39:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC5E720043;
 Mon, 29 Jul 2024 16:39:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE7BD20040;
 Mon, 29 Jul 2024 16:39:12 +0000 (GMT)
Received: from [9.43.15.8] (unknown [9.43.15.8])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jul 2024 16:39:12 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------Gw0ZGIHxDcROrn20LhK1oi56"
Message-ID: <c0376e88-05b3-488e-a025-ff477741ff5f@linux.ibm.com>
Date: Mon, 29 Jul 2024 22:09:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 38/96] hw/ssi: Extend SPI model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-39-npiggin@gmail.com>
 <8d93da65-36a9-4642-9345-1b698191ba49@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <8d93da65-36a9-4642-9345-1b698191ba49@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v0qtFbgXJHiEgr3vSC1_FAljz6lmlEnm
X-Proofpoint-GUID: AjVZUdUKHLw6AGjbbvY3XYDEqPM_nVbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_14,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407290110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DC_PNG_UNO_LARGO=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------Gw0ZGIHxDcROrn20LhK1oi56
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 29-07-2024 16:02, Cédric Le Goater wrote:
> On 7/26/24 01:53, Nicholas Piggin wrote:
>> From: Chalapathi V <chalapathi.v@linux.ibm.com>
>>
>> In this commit SPI shift engine and sequencer logic is implemented.
>> Shift engine performs serialization and de-serialization according to 
>> the
>> control by the sequencer and according to the setup defined in the
>> configuration registers. Sequencer implements the main control logic and
>> FSM to handle data transmit and data receive control of the shift 
>> engine.
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
>> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/ssi/pnv_spi.c              | 1045 +++++++++++++++++++++++++++++++++
>>   hw/ssi/trace-events           |   15 +
>>   include/hw/ssi/pnv_spi.h      |   27 +
>>   include/hw/ssi/pnv_spi_regs.h |   68 ++-
>>   4 files changed, 1154 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
>> index 468afdad07..cdff3f9621 100644
>> --- a/hw/ssi/pnv_spi.c
>> +++ b/hw/ssi/pnv_spi.c
>> @@ -17,6 +17,9 @@
>>   #include "hw/irq.h"
>>   #include "trace.h"
>>   +#define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
>> +#define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
>> +
>>   /*
>>    * Macro from include/hw/ppc/fdt.h
>>    * fdt.h cannot be included here as it contain ppc target specific 
>> dependency.
>> @@ -32,6 +35,1040 @@
>> }                                                          \
>>       } while (0)
>>   +/* PnvXferBuffer */
>> +typedef struct PnvXferBuffer {
>> +
>> +    uint32_t    len;
>> +    uint8_t    *data;
>> +
>> +} PnvXferBuffer;
>> +
>> +/* pnv_spi_xfer_buffer_methods */
>> +static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
>> +{
>> +    PnvXferBuffer *payload = g_malloc0(sizeof(*payload));
>> +
>> +    return payload;
>> +}
>> +
>> +static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
>> +{
>> +    free(payload->data);
>> +    free(payload);
>> +}
>> +
>> +static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
>> +                uint32_t offset, uint32_t length)
>> +{
>> +    if (payload->len < (offset + length)) {
>> +        payload->len = offset + length;
>> +        payload->data = g_realloc(payload->data, payload->len);
>> +    }
>> +    return &payload->data[offset];
>> +}
>> +
>> +static bool does_rdr_match(PnvSpi *s)
>> +{
>> +    /*
>> +     * According to spec, the mask bits that are 0 are compared and the
>> +     * bits that are 1 are ignored.
>> +     */
>> +    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK,
>> + s->regs[SPI_MM_REG]);
>> +    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL,
>> + s->regs[SPI_MM_REG]);
>> +
>> +    if ((~rdr_match_mask & rdr_match_val) == ((~rdr_match_mask) &
>> +            GETFIELD(PPC_BITMASK(48, 63), 
>> s->regs[SPI_RCV_DATA_REG]))) {
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> +static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)
>> +{
>> +    uint8_t byte;
>> +
>> +    /*
>> +     * Offset is an index between 0 and PNV_SPI_REG_SIZE - 1
>> +     * Check the offset before using it.
>> +     */
>> +    if (offset < PNV_SPI_REG_SIZE) {
>> +        byte = (s->regs[SPI_XMIT_DATA_REG] >> (56 - offset * 8)) & 
>> 0xFF;
>> +    } else {
>> +        /*
>> +         * Log an error and return a 0xFF since we have to assign 
>> something
>> +         * to byte before returning.
>> +         */
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid offset = %d used to 
>> get byte "
>> +                      "from TDR\n", offset);
>> +        byte = 0xff;
>> +    }
>> +    return byte;
>> +}
>> +
>> +static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t 
>> nr_bytes,
>> +                uint8_t ecc_count, uint8_t shift_in_count)
>> +{
>> +    uint8_t byte;
>> +    int count = 0;
>> +
>> +    while (count < nr_bytes) {
>> +        shift_in_count++;
>> +        if ((ecc_count != 0) &&
>> +            (shift_in_count == (PNV_SPI_REG_SIZE + ecc_count))) {
>> +            shift_in_count = 0;
>> +        } else {
>> +            byte = read_buf[count];
>> +            trace_pnv_spi_shift_rx(byte, count);
>> +            s->regs[SPI_RCV_DATA_REG] = (s->regs[SPI_RCV_DATA_REG] 
>> << 8) | byte;
>> +        }
>> +        count++;
>> +    } /* end of while */
>> +    return shift_in_count;
>> +}
>> +
>> +static void spi_response(PnvSpi *s, int bits, PnvXferBuffer 
>> *rsp_payload)
>> +{
>> +    uint8_t ecc_count;
>> +    uint8_t shift_in_count;
>> +
>> +    /*
>> +     * Processing here must handle:
>> +     * - Which bytes in the payload we should move to the RDR
>> +     * - Explicit mode counter configuration settings
>> +     * - RDR full and RDR overrun status
>> +     */
>> +
>> +    /*
>> +     * First check that the response payload is the exact same
>> +     * number of bytes as the request payload was
>> +     */
>> +    if (rsp_payload->len != (s->N1_bytes + s->N2_bytes)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload 
>> size in "
>> +                       "bytes, expected %d, got %d\n",
>> +                       (s->N1_bytes + s->N2_bytes), rsp_payload->len);
>> +    } else {
>> +        uint8_t ecc_control;
>> +        trace_pnv_spi_rx_received(rsp_payload->len);
>> +        trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
>> +                        s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, 
>> s->N2_rx);
>> +        /*
>> +         * Adding an ECC count let's us know when we have found a 
>> payload byte
>> +         * that was shifted in but cannot be loaded into RDR. Bits 
>> 29-30 of
>> +         * clock_config_reset_control register equal to either 0b00 
>> or 0b10
>> +         * indicate that we are taking in data with ECC and either 
>> applying
>> +         * the ECC or discarding it.
>> +         */
>> +        ecc_count = 0;
>> +        ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL, 
>> s->regs[SPI_CLK_CFG_REG]);
>> +        if (ecc_control == 0 || ecc_control == 2) {
>> +            ecc_count = 1;
>> +        }
>> +        /*
>> +         * Use the N1_rx and N2_rx counts to control shifting data 
>> from the
>> +         * payload into the RDR.  Keep an overall count of the 
>> number of bytes
>> +         * shifted into RDR so we can discard every 9th byte when 
>> ECC is
>> +         * enabled.
>> +         */
>> +        shift_in_count = 0;
>> +        /* Handle the N1 portion of the frame first */
>> +        if (s->N1_rx != 0) {
>> +            trace_pnv_spi_rx_read_N1frame();
>> +            shift_in_count = read_from_frame(s, &rsp_payload->data[0],
>> +                            s->N1_bytes, ecc_count, shift_in_count);
>> +        }
>> +        /* Handle the N2 portion of the frame */
>> +        if (s->N2_rx != 0) {
>> +            trace_pnv_spi_rx_read_N2frame();
>> +            shift_in_count = read_from_frame(s,
>> + &rsp_payload->data[s->N1_bytes], s->N2_bytes,
>> +                            ecc_count, shift_in_count);
>> +        }
>> +        if ((s->N1_rx + s->N2_rx) > 0) {
>> +            /*
>> +             * Data was received so handle RDR status.
>> +             * It is easier to handle RDR_full and RDR_overrun 
>> status here
>> +             * since the RDR register's shift_byte_in method is called
>> +             * multiple times in a row. Controlling RDR status is 
>> done here
>> +             * instead of in the RDR scoped methods for that reason.
>> +             */
>> +            if (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1) {
>> +                /*
>> +                 * Data was shifted into the RDR before having been 
>> read
>> +                 * causing previous data to have been overrun.
>> +                 */
>> +                s->status = SETFIELD(SPI_STS_RDR_OVERRUN, s->status, 
>> 1);
>> +            } else {
>> +                /*
>> +                 * Set status to indicate that the received data 
>> register is
>> +                 * full. This flag is only cleared once the RDR is 
>> unloaded.
>> +                 */
>> +                s->status = SETFIELD(SPI_STS_RDR_FULL, s->status, 1);
>> +            }
>> +        }
>> +    } /* end of else */
>> +} /* end of spi_response() */
>> +
>> +static void transfer(PnvSpi *s, PnvXferBuffer *payload)
>> +{
>> +    uint32_t tx;
>> +    uint32_t rx;
>> +    PnvXferBuffer *rsp_payload = NULL;
>> +
>> +    rsp_payload = pnv_spi_xfer_buffer_new();
>> +    for (int offset = 0; offset < payload->len; offset += 
>> s->transfer_len) {
>> +        tx = 0;
>> +        for (int i = 0; i < s->transfer_len; i++) {
>> +            if ((offset + i) >= payload->len) {
>> +                tx <<= 8;
>> +            } else {
>> +                tx = (tx << 8) | payload->data[offset + i];
>> +            }
>> +        }
>> +        rx = ssi_transfer(s->ssi_bus, tx);
>> +        for (int i = 0; i < s->transfer_len; i++) {
>> +            if ((offset + i) >= payload->len) {
>> +                break;
>> +            }
>> +            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, 
>> rsp_payload->len, 1)) =
>> +                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
>> +        }
>> +    }
>> +    if (rsp_payload != NULL) {
>> +        spi_response(s, s->N1_bits, rsp_payload);
>> +    }
>> +}
>> +
>> +static inline uint8_t get_seq_index(PnvSpi *s)
>> +{
>> +    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
>> +}
>
> Coverity reports :
>
>>>>     CID 1558827:    (OVERRUN)
>>>>     Overrunning array "s->seq_op" of 8 bytes at byte offset 16 
>>>> using index "get_seq_index(s) + 1" (which evaluates to 16).
>
>
> get_seq_index() can return a value between 0 and 15 and it is used in 
> a couple
> of places to index array s->seq_op[] which is an 8 bytes array.
>
> Should we increase the size of the seq_op array ?
>
> Thanks,
>
> C.

Hello Cedric,

s->status.sequencer_index is 4 bits long and can have values between 0 
and 15.

However when referencing s->seq_op[], we need to check for array boundary.
Thank You

Chalapathi

>
>
>
>> +static inline void next_sequencer_fsm(PnvSpi *s)
>> +{
>> +    uint8_t seq_index = get_seq_index(s);
>> +    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, (seq_index + 
>> 1));
>> +    s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_INDEX_INCREMENT);
>> +}
>> +
>> +/*
>> + * Calculate the N1 counters based on passed in opcode and
>> + * internal register values.
>> + * The method assumes that the opcode is a Shift_N1 opcode
>> + * and doesn't test it.
>> + * The counters returned are:
>> + * N1 bits: Number of bits in the payload data that are significant
>> + * to the responder.
>> + * N1_bytes: Total count of payload bytes for the N1 (portion of 
>> the) frame.
>> + * N1_tx: Total number of bytes taken from TDR for N1
>> + * N1_rx: Total number of bytes taken from the payload for N1
>> + */
>> +static void calculate_N1(PnvSpi *s, uint8_t opcode)
>> +{
>> +    /*
>> +     * Shift_N1 opcode form: 0x3M
>> +     * Implicit mode:
>> +     * If M != 0 the shift count is M bytes and M is the number of 
>> tx bytes.
>> +     * Forced Implicit mode:
>> +     * M is the shift count but tx and rx is determined by the count 
>> control
>> +     * register fields.  Note that we only check for forced Implicit 
>> mode when
>> +     * M != 0 since the mode doesn't make sense when M = 0.
>> +     * Explicit mode:
>> +     * If M == 0 then shift count is number of bits defined in the
>> +     * Counter Configuration Register's shift_count_N1 field.
>> +     */
>> +    if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) == 0) {
>> +        /* Explicit mode */
>> +        s->N1_bits = GETFIELD(SPI_CTR_CFG_N1, 
>> s->regs[SPI_CTR_CFG_REG]);
>> +        s->N1_bytes = (s->N1_bits + 7) / 8;
>> +        s->N1_tx = 0;
>> +        s->N1_rx = 0;
>> +        /* If tx count control for N1 is set, load the tx value */
>> +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2, 
>> s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +            s->N1_tx = s->N1_bytes;
>> +        }
>> +        /* If rx count control for N1 is set, load the rx value */
>> +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3, 
>> s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +            s->N1_rx = s->N1_bytes;
>> +        }
>> +    } else {
>> +        /* Implicit mode/Forced Implicit mode, use M field from 
>> opcode */
>> +        s->N1_bytes = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
>> +        s->N1_bits = s->N1_bytes * 8;
>> +        /*
>> +         * Assume that we are going to transmit the count
>> +         * (pure Implicit only)
>> +         */
>> +        s->N1_tx = s->N1_bytes;
>> +        s->N1_rx = 0;
>> +        /* Let Forced Implicit mode have an effect on the counts */
>> +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B1, 
>> s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +            /*
>> +             * If Forced Implicit mode and count control doesn't
>> +             * indicate transmit then reset the tx count to 0
>> +             */
>> +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
>> + s->regs[SPI_CTR_CFG_REG]) == 0) {
>> +                s->N1_tx = 0;
>> +            }
>> +            /* If rx count control for N1 is set, load the rx value */
>> +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
>> + s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +                s->N1_rx = s->N1_bytes;
>> +            }
>> +        }
>> +    }
>> +    /*
>> +     * Enforce an upper limit on the size of N1 that is equal to the 
>> known size
>> +     * of the shift register, 64 bits or 72 bits if ECC is enabled.
>> +     * If the size exceeds 72 bits it is a user error so log an error,
>> +     * cap the size at a max of 64 bits or 72 bits and set the 
>> sequencer FSM
>> +     * error bit.
>> +     */
>> +    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
>> + s->regs[SPI_CLK_CFG_REG]);
>> +    if (ecc_control == 0 || ecc_control == 2) {
>> +        if (s->N1_bytes > (PNV_SPI_REG_SIZE + 1)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift 
>> size when "
>> +                          "ECC enabled, bytes = 0x%x, bits = 0x%x\n",
>> +                          s->N1_bytes, s->N1_bits);
>> +            s->N1_bytes = PNV_SPI_REG_SIZE + 1;
>> +            s->N1_bits = s->N1_bytes * 8;
>> +        }
>> +    } else if (s->N1_bytes > PNV_SPI_REG_SIZE) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
>> +                      "bytes = 0x%x, bits = 0x%x\n",
>> +                      s->N1_bytes, s->N1_bits);
>> +        s->N1_bytes = PNV_SPI_REG_SIZE;
>> +        s->N1_bits = s->N1_bytes * 8;
>> +    }
>> +} /* end of calculate_N1 */
>> +
>> +/*
>> + * Shift_N1 operation handler method
>> + */
>> +static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
>> +                       PnvXferBuffer **payload, bool send_n1_alone)
>> +{
>> +    uint8_t n1_count;
>> +    bool stop = false;
>> +
>> +    /*
>> +     * If there isn't a current payload left over from a stopped 
>> sequence
>> +     * create a new one.
>> +     */
>> +    if (*payload == NULL) {
>> +        *payload = pnv_spi_xfer_buffer_new();
>> +    }
>> +    /*
>> +     * Use a combination of N1 counters to build the N1 portion of the
>> +     * transmit payload.
>> +     * We only care about transmit at this time since the request 
>> payload
>> +     * only represents data going out on the controller output line.
>> +     * Leave mode specific considerations in the calculate function 
>> since
>> +     * all we really care about are counters that tell use exactly how
>> +     * many bytes are in the payload and how many of those bytes to
>> +     * include from the TDR into the payload.
>> +     */
>> +    calculate_N1(s, opcode);
>> +    trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
>> +                    s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, 
>> s->N2_rx);
>> +    /*
>> +     * Zero out the N2 counters here in case there is no N2 
>> operation following
>> +     * the N1 operation in the sequencer.  This keeps leftover N2 
>> information
>> +     * from interfering with spi_response logic.
>> +     */
>> +    s->N2_bits = 0;
>> +    s->N2_bytes = 0;
>> +    s->N2_tx = 0;
>> +    s->N2_rx = 0;
>> +    /*
>> +     * N1_bytes is the overall size of the N1 portion of the frame 
>> regardless of
>> +     * whether N1 is used for tx, rx or both.  Loop over the size to 
>> build a
>> +     * payload that is N1_bytes long.
>> +     * N1_tx is the count of bytes to take from the TDR and "shift" 
>> into the
>> +     * frame which means append those bytes to the payload for the 
>> N1 portion
>> +     * of the frame.
>> +     * If N1_tx is 0 or if the count exceeds the size of the TDR 
>> append 0xFF to
>> +     * the frame until the overall N1 count is reached.
>> +     */
>> +    n1_count = 0;
>> +    while (n1_count < s->N1_bytes) {
>> +        /*
>> +         * Assuming that if N1_tx is not equal to 0 then it is the 
>> same as
>> +         * N1_bytes.
>> +         */
>> +        if ((s->N1_tx != 0) && (n1_count < PNV_SPI_REG_SIZE)) {
>> +
>> +            if (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1) {
>> +                /*
>> +                 * Note that we are only appending to the payload IF 
>> the TDR
>> +                 * is full otherwise we don't touch the payload 
>> because we are
>> +                 * going to NOT send the payload and instead tell 
>> the sequencer
>> +                 * that called us to stop and wait for a TDR write 
>> so we have
>> +                 * data to load into the payload.
>> +                 */
>> +                uint8_t n1_byte = 0x00;
>> +                n1_byte = get_from_offset(s, n1_count);
>> +                trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
>> +                *(pnv_spi_xfer_buffer_write_ptr(*payload, 
>> (*payload)->len, 1)) =
>> +                        n1_byte;
>> +            } else {
>> +                /*
>> +                 * We hit a shift_n1 opcode TX but the TDR is empty, 
>> tell the
>> +                 * sequencer to stop and break this loop.
>> +                 */
>> +                trace_pnv_spi_sequencer_stop_requested("Shift N1"
>> +                                "set for transmit but TDR is empty");
>> +                stop = true;
>> +                break;
>> +            }
>> +        } else {
>> +            /*
>> +             * Cases here:
>> +             * - we are receiving during the N1 frame segment and 
>> the RDR
>> +             *   is full so we need to stop until the RDR is read
>> +             * - we are transmitting and we don't care about RDR status
>> +             *   since we won't be loading RDR during the frame 
>> segment.
>> +             * - we are receiving and the RDR is empty so we allow 
>> the operation
>> +             *   to proceed.
>> +             */
>> +            if ((s->N1_rx != 0) && (GETFIELD(SPI_STS_RDR_FULL,
>> +                                           s->status) == 1)) {
>> +                trace_pnv_spi_sequencer_stop_requested("shift N1"
>> +                                "set for receive but RDR is full");
>> +                stop = true;
>> +                break;
>> +            } else {
>> +                trace_pnv_spi_tx_append_FF("n1_byte");
>> +                *(pnv_spi_xfer_buffer_write_ptr(*payload, 
>> (*payload)->len, 1))
>> +                        = 0xff;
>> +            }
>> +        }
>> +        n1_count++;
>> +    } /* end of while */
>> +    /*
>> +     * If we are not stopping due to an empty TDR and we are doing 
>> an N1 TX
>> +     * and the TDR is full we need to clear the TDR_full status.
>> +     * Do this here instead of up in the loop above so we don't log 
>> the message
>> +     * in every loop iteration.
>> +     * Ignore the send_n1_alone flag, all that does is defer the TX 
>> until the N2
>> +     * operation, which was found immediately after the current 
>> opcode.  The TDR
>> +     * was unloaded and will be shifted so we have to clear the 
>> TDR_full status.
>> +     */
>> +    if (!stop && (s->N1_tx != 0) &&
>> +        (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1)) {
>> +        s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
>> +    }
>> +    /*
>> +     * There are other reasons why the shifter would stop, such as a 
>> TDR empty
>> +     * or RDR full condition with N1 set to receive.  If we haven't 
>> stopped due
>> +     * to either one of those conditions then check if the 
>> send_n1_alone flag is
>> +     * equal to False, indicating the next opcode is an N2 
>> operation, AND if
>> +     * the N2 counter reload switch (bit 0 of the N2 count control 
>> field) is
>> +     * set.  This condition requires a pacing write to "kick" off 
>> the N2
>> +     * shift which includes the N1 shift as well when send_n1_alone 
>> is False.
>> +     */
>> +    if (!stop && !send_n1_alone &&
>> +       (GETFIELD(SPI_CTR_CFG_N2_CTRL_B0, s->regs[SPI_CTR_CFG_REG]) 
>> == 1)) {
>> +        trace_pnv_spi_sequencer_stop_requested("N2 counter reload "
>> +                        "active, stop N1 shift, TDR_underrun set to 
>> 1");
>> +        stop = true;
>> +        s->status = SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 1);
>> +    }
>> +    /*
>> +     * If send_n1_alone is set AND we have a full TDR then this is 
>> the first and
>> +     * last payload to send and we don't have an N2 frame segment to 
>> add to the
>> +     * payload.
>> +     */
>> +    if (send_n1_alone && !stop) {
>> +        /* We have a TX and a full TDR or an RX and an empty RDR */
>> +        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)->len);
>> +        transfer(s, *payload);
>> +        /* The N1 frame shift is complete so reset the N1 counters */
>> +        s->N2_bits = 0;
>> +        s->N2_bytes = 0;
>> +        s->N2_tx = 0;
>> +        s->N2_rx = 0;
>> +        pnv_spi_xfer_buffer_free(*payload);
>> +        *payload = NULL;
>> +    }
>> +    return stop;
>> +} /* end of operation_shiftn1() */
>> +
>> +/*
>> + * Calculate the N2 counters based on passed in opcode and
>> + * internal register values.
>> + * The method assumes that the opcode is a Shift_N2 opcode
>> + * and doesn't test it.
>> + * The counters returned are:
>> + * N2 bits: Number of bits in the payload data that are significant
>> + * to the responder.
>> + * N2_bytes: Total count of payload bytes for the N2 frame.
>> + * N2_tx: Total number of bytes taken from TDR for N2
>> + * N2_rx: Total number of bytes taken from the payload for N2
>> + */
>> +static void calculate_N2(PnvSpi *s, uint8_t opcode)
>> +{
>> +    /*
>> +     * Shift_N2 opcode form: 0x4M
>> +     * Implicit mode:
>> +     * If M!=0 the shift count is M bytes and M is the number of rx 
>> bytes.
>> +     * Forced Implicit mode:
>> +     * M is the shift count but tx and rx is determined by the count 
>> control
>> +     * register fields.  Note that we only check for Forced Implicit 
>> mode when
>> +     * M != 0 since the mode doesn't make sense when M = 0.
>> +     * Explicit mode:
>> +     * If M==0 then shift count is number of bits defined in the
>> +     * Counter Configuration Register's shift_count_N1 field.
>> +     */
>> +    if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) == 0) {
>> +        /* Explicit mode */
>> +        s->N2_bits = GETFIELD(SPI_CTR_CFG_N2, 
>> s->regs[SPI_CTR_CFG_REG]);
>> +        s->N2_bytes = (s->N2_bits + 7) / 8;
>> +        s->N2_tx = 0;
>> +        s->N2_rx = 0;
>> +        /* If tx count control for N2 is set, load the tx value */
>> +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2, 
>> s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +            s->N2_tx = s->N2_bytes;
>> +        }
>> +        /* If rx count control for N2 is set, load the rx value */
>> +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3, 
>> s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +            s->N2_rx = s->N2_bytes;
>> +        }
>> +    } else {
>> +        /* Implicit mode/Forced Implicit mode, use M field from 
>> opcode */
>> +        s->N2_bytes = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
>> +        s->N2_bits = s->N2_bytes * 8;
>> +        /* Assume that we are going to receive the count */
>> +        s->N2_rx = s->N2_bytes;
>> +        s->N2_tx = 0;
>> +        /* Let Forced Implicit mode have an effect on the counts */
>> +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B1, 
>> s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +            /*
>> +             * If Forced Implicit mode and count control doesn't
>> +             * indicate a receive then reset the rx count to 0
>> +             */
>> +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
>> + s->regs[SPI_CTR_CFG_REG]) == 0) {
>> +                s->N2_rx = 0;
>> +            }
>> +            /* If tx count control for N2 is set, load the tx value */
>> +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
>> + s->regs[SPI_CTR_CFG_REG]) == 1) {
>> +                s->N2_tx = s->N2_bytes;
>> +            }
>> +        }
>> +    }
>> +    /*
>> +     * Enforce an upper limit on the size of N1 that is equal to the
>> +     * known size of the shift register, 64 bits or 72 bits if ECC
>> +     * is enabled.
>> +     * If the size exceeds 72 bits it is a user error so log an error,
>> +     * cap the size at a max of 64 bits or 72 bits and set the 
>> sequencer FSM
>> +     * error bit.
>> +     */
>> +    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
>> +                    s->regs[SPI_CLK_CFG_REG]);
>> +    if (ecc_control == 0 || ecc_control == 2) {
>> +        if (s->N2_bytes > (PNV_SPI_REG_SIZE + 1)) {
>> +            /* Unsupported N2 shift size when ECC enabled */
>> +            s->N2_bytes = PNV_SPI_REG_SIZE + 1;
>> +            s->N2_bits = s->N2_bytes * 8;
>> +        }
>> +    } else if (s->N2_bytes > PNV_SPI_REG_SIZE) {
>> +        /* Unsupported N2 shift size */
>> +        s->N2_bytes = PNV_SPI_REG_SIZE;
>> +        s->N2_bits = s->N2_bytes * 8;
>> +    }
>> +} /* end of calculate_N2 */
>> +
>> +/*
>> + * Shift_N2 operation handler method
>> + */
>> +
>> +static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
>> +                       PnvXferBuffer **payload)
>> +{
>> +    uint8_t n2_count;
>> +    bool stop = false;
>> +
>> +    /*
>> +     * If there isn't a current payload left over from a stopped 
>> sequence
>> +     * create a new one.
>> +     */
>> +    if (*payload == NULL) {
>> +        *payload = pnv_spi_xfer_buffer_new();
>> +    }
>> +    /*
>> +     * Use a combination of N2 counters to build the N2 portion of the
>> +     * transmit payload.
>> +     */
>> +    calculate_N2(s, opcode);
>> +    trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
>> +                    s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, 
>> s->N2_rx);
>> +    /*
>> +     * The only difference between this code and the code for shift 
>> N1 is
>> +     * that this code has to account for the possible presence of N1 
>> transmit
>> +     * bytes already taken from the TDR.
>> +     * If there are bytes to be transmitted for the N2 portion of 
>> the frame
>> +     * and there are still bytes in TDR that have not been copied 
>> into the
>> +     * TX data of the payload, this code will handle transmitting those
>> +     * remaining bytes.
>> +     * If for some reason the transmit count(s) add up to more than 
>> the size
>> +     * of the TDR we will just append 0xFF to the transmit payload 
>> data until
>> +     * the payload is N1 + N2 bytes long.
>> +     */
>> +    n2_count = 0;
>> +    while (n2_count < s->N2_bytes) {
>> +        /*
>> +         * If the RDR is full and we need to RX just bail out, 
>> letting the
>> +         * code continue will end up building the payload twice in 
>> the same
>> +         * buffer since RDR full causes a sequence stop and restart.
>> +         */
>> +        if ((s->N2_rx != 0) &&
>> +            (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1)) {
>> +            trace_pnv_spi_sequencer_stop_requested("shift N2 set"
>> +                            "for receive but RDR is full");
>> +            stop = true;
>> +            break;
>> +        }
>> +        if ((s->N2_tx != 0) && ((s->N1_tx + n2_count) <
>> +                                PNV_SPI_REG_SIZE)) {
>> +            /* Always append data for the N2 segment if it is set 
>> for TX */
>> +            uint8_t n2_byte = 0x00;
>> +            n2_byte = get_from_offset(s, (s->N1_tx + n2_count));
>> +            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + 
>> n2_count));
>> +            *(pnv_spi_xfer_buffer_write_ptr(*payload, 
>> (*payload)->len, 1))
>> +                    = n2_byte;
>> +        } else {
>> +            /*
>> +             * Regardless of whether or not N2 is set for TX or RX, 
>> we need
>> +             * the number of bytes in the payload to match the 
>> overall length
>> +             * of the operation.
>> +             */
>> +            trace_pnv_spi_tx_append_FF("n2_byte");
>> +            *(pnv_spi_xfer_buffer_write_ptr(*payload, 
>> (*payload)->len, 1))
>> +                    = 0xff;
>> +        }
>> +        n2_count++;
>> +    } /* end of while */
>> +    if (!stop) {
>> +        /* We have a TX and a full TDR or an RX and an empty RDR */
>> +        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)->len);
>> +        transfer(s, *payload);
>> +        /*
>> +         * If we are doing an N2 TX and the TDR is full we need to 
>> clear the
>> +         * TDR_full status. Do this here instead of up in the loop 
>> above so we
>> +         * don't log the message in every loop iteration.
>> +         */
>> +        if ((s->N2_tx != 0) &&
>> +            (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1)) {
>> +            s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
>> +        }
>> +        /*
>> +         * The N2 frame shift is complete so reset the N2 counters.
>> +         * Reset the N1 counters also in case the frame was a 
>> combination of
>> +         * N1 and N2 segments.
>> +         */
>> +        s->N2_bits = 0;
>> +        s->N2_bytes = 0;
>> +        s->N2_tx = 0;
>> +        s->N2_rx = 0;
>> +        s->N1_bits = 0;
>> +        s->N1_bytes = 0;
>> +        s->N1_tx = 0;
>> +        s->N1_rx = 0;
>> +        pnv_spi_xfer_buffer_free(*payload);
>> +        *payload = NULL;
>> +    }
>> +    return stop;
>> +} /*  end of operation_shiftn2()*/
>> +
>> +static void operation_sequencer(PnvSpi *s)
>> +{
>> +    /*
>> +     * Loop through each sequencer operation ID and perform the 
>> requested
>> +     *  operations.
>> +     * Flag for indicating if we should send the N1 frame or wait to 
>> combine
>> +     * it with a preceding N2 frame.
>> +     */
>> +    bool send_n1_alone = true;
>> +    bool stop = false; /* Flag to stop the sequencer */
>> +    uint8_t opcode = 0;
>> +    uint8_t masked_opcode = 0;
>> +
>> +    /*
>> +     * PnvXferBuffer for containing the payload of the SPI frame.
>> +     * This is a static because there are cases where a sequence has 
>> to stop
>> +     * and wait for the target application to unload the RDR. If 
>> this occurs
>> +     * during a sequence where N1 is not sent alone and instead 
>> combined with
>> +     * N2 since the N1 tx length + the N2 tx length is less than the 
>> size of
>> +     * the TDR.
>> +     */
>> +    static PnvXferBuffer *payload;
>> +
>> +    if (payload == NULL) {
>> +        payload = pnv_spi_xfer_buffer_new();
>> +    }
>> +    /*
>> +     * Clear the sequencer FSM error bit - general_SPI_status[3]
>> +     * before starting a sequence.
>> +     */
>> +    s->status = SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 0);
>> +    /*
>> +     * If the FSM is idle set the sequencer index to 0
>> +     * (new/restarted sequence)
>> +     */
>> +    if (GETFIELD(SPI_STS_SEQ_FSM, s->status) == SEQ_STATE_IDLE) {
>> +        s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
>> +    }
>> +    /*
>> +     * There are only 8 possible operation IDs to iterate through 
>> though
>> +     * some operations may cause more than one frame to be sequenced.
>> +     */
>> +    while (get_seq_index(s) < NUM_SEQ_OPS) {
>> +        opcode = s->seq_op[get_seq_index(s)];
>> +        /* Set sequencer state to decode */
>> +        s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_DECODE);
>> +        /*
>> +         * Only the upper nibble of the operation ID is needed to 
>> know what
>> +         * kind of operation is requested.
>> +         */
>> +        masked_opcode = PNV_SPI_MASKED_OPCODE(opcode);
>> +        switch (masked_opcode) {
>> +        /*
>> +         * Increment the operation index in each case instead of just
>> +         * once at the end in case an operation like the branch
>> +         * operation needs to change the index.
>> +         */
>> +        case SEQ_OP_STOP:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            /* A stop operation in any position stops the sequencer */
>> +            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
>> +
>> +            stop = true;
>> +            s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, 
>> FSM_IDLE);
>> +            s->loop_counter_1 = 0;
>> +            s->loop_counter_2 = 0;
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_IDLE);
>> +            break;
>> +
>> +        case SEQ_OP_SELECT_SLAVE:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            trace_pnv_spi_sequencer_op("SELECT_SLAVE", 
>> get_seq_index(s));
>> +            /*
>> +             * This device currently only supports a single responder
>> +             * connection at position 0.  De-selecting a responder 
>> is fine
>> +             * and expected at the end of a sequence but selecting any
>> +             * responder other than 0 should cause an error.
>> +             */
>> +            s->responder_select = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
>> +            if (s->responder_select == 0) {
>> +                trace_pnv_spi_shifter_done();
>> +                qemu_set_irq(s->cs_line[0], 1);
>> +                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
>> +                                (get_seq_index(s) + 1));
>> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, 
>> FSM_DONE);
>> +            } else if (s->responder_select != 1) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "Slave selection 
>> other than 1 "
>> +                              "not supported, select = 0x%x\n",
>> +                               s->responder_select);
>> +                trace_pnv_spi_sequencer_stop_requested("invalid "
>> +                                "responder select");
>> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, 
>> FSM_IDLE);
>> +                stop = true;
>> +            } else {
>> +                /*
>> +                 * Only allow an FSM_START state when a responder is
>> +                 * selected
>> +                 */
>> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, 
>> FSM_START);
>> +                trace_pnv_spi_shifter_stating();
>> +                qemu_set_irq(s->cs_line[0], 0);
>> +                /*
>> +                 * A Shift_N2 operation is only valid after a Shift_N1
>> +                 * according to the spec. The spec doesn't say if 
>> that means
>> +                 * immediately after or just after at any point. We 
>> will track
>> +                 * the occurrence of a Shift_N1 to enforce this 
>> requirement in
>> +                 * the most generic way possible by assuming that 
>> the rule
>> +                 * applies once a valid responder select has occurred.
>> +                 */
>> +                s->shift_n1_done = false;
>> +                next_sequencer_fsm(s);
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_SHIFT_N1:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            trace_pnv_spi_sequencer_op("SHIFT_N1", get_seq_index(s));
>> +            /*
>> +             * Only allow a shift_n1 when the state is not IDLE or 
>> DONE.
>> +             * In either of those two cases the sequencer is not in 
>> a proper
>> +             * state to perform shift operations because the 
>> sequencer has:
>> +             * - processed a responder deselect (DONE)
>> +             * - processed a stop opcode (IDLE)
>> +             * - encountered an error (IDLE)
>> +             */
>> +            if ((GETFIELD(SPI_STS_SHIFTER_FSM, s->status) == 
>> FSM_IDLE) ||
>> +                (GETFIELD(SPI_STS_SHIFTER_FSM, s->status) == 
>> FSM_DONE)) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N1 not allowed 
>> in "
>> +                              "shifter state = 0x%llx", GETFIELD(
>> +                        SPI_STS_SHIFTER_FSM, s->status));
>> +                /*
>> +                 * Set sequencer FSM error bit 3 
>> (general_SPI_status[3])
>> +                 * in status reg.
>> +                 */
>> +                s->status = SETFIELD(SPI_STS_GEN_STATUS_B3, 
>> s->status, 1);
>> +                trace_pnv_spi_sequencer_stop_requested("invalid 
>> shifter state");
>> +                stop = true;
>> +            } else {
>> +                /*
>> +                 * Look for the special case where there is a 
>> shift_n1 set for
>> +                 * transmit and it is followed by a shift_n2 set for 
>> transmit
>> +                 * AND the combined transmit length of the two 
>> operations is
>> +                 * less than or equal to the size of the TDR 
>> register. In this
>> +                 * case we want to use both this current shift_n1 
>> opcode and the
>> +                 * following shift_n2 opcode to assemble the frame for
>> +                 * transmission to the responder without requiring a 
>> refill of
>> +                 * the TDR between the two operations.
>> +                 */
>> +                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) 
>> + 1])
>> +                                == SEQ_OP_SHIFT_N2) {
>> +                    send_n1_alone = false;
>> +                }
>> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>> +                                FSM_SHIFT_N1);
>> +                stop = operation_shiftn1(s, opcode, &payload, 
>> send_n1_alone);
>> +                if (stop) {
>> +                    /*
>> +                     *  The operation code says to stop, this can 
>> occur if:
>> +                     * (1) RDR is full and the N1 shift is set for 
>> receive
>> +                     * (2) TDR was empty at the time of the N1 shift 
>> so we need
>> +                     * to wait for data.
>> +                     * (3) Neither 1 nor 2 are occurring and we 
>> aren't sending
>> +                     * N1 alone and N2 counter reload is set (bit 0 
>> of the N2
>> +                     * counter reload field).  In this case 
>> TDR_underrun will
>> +                     * will be set and the Payload has been loaded 
>> so it is
>> +                     * ok to advance the sequencer.
>> +                     */
>> +                    if (GETFIELD(SPI_STS_TDR_UNDERRUN, s->status)) {
>> +                        s->shift_n1_done = true;
>> +                        s->status = SETFIELD(SPI_STS_SHIFTER_FSM, 
>> s->status,
>> + FSM_SHIFT_N2);
>> +                        s->status = SETFIELD(SPI_STS_SEQ_INDEX, 
>> s->status,
>> +                                        (get_seq_index(s) + 1));
>> +                    } else {
>> +                        /*
>> +                         * This is case (1) or (2) so the sequencer 
>> needs to
>> +                         * wait and NOT go to the next sequence yet.
>> +                         */
>> +                        s->status = SETFIELD(SPI_STS_SHIFTER_FSM, 
>> s->status,
>> +                                        FSM_WAIT);
>> +                    }
>> +                } else {
>> +                    /* Ok to move on to the next index */
>> +                    s->shift_n1_done = true;
>> +                    next_sequencer_fsm(s);
>> +                }
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_SHIFT_N2:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            trace_pnv_spi_sequencer_op("SHIFT_N2", get_seq_index(s));
>> +            if (!s->shift_n1_done) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not 
>> allowed if a "
>> +                              "Shift_N1 is not done, shifter state = 
>> 0x%llx",
>> +                              GETFIELD(SPI_STS_SHIFTER_FSM, 
>> s->status));
>> +                /*
>> +                 * In case the sequencer actually stops if an N2 
>> shift is
>> +                 * requested before any N1 shift is done. Set 
>> sequencer FSM
>> +                 * error bit 3 (general_SPI_status[3]) in status reg.
>> +                 */
>> +                s->status = SETFIELD(SPI_STS_GEN_STATUS_B3, 
>> s->status, 1);
>> + trace_pnv_spi_sequencer_stop_requested("shift_n2 "
>> +                                    "w/no shift_n1 done");
>> +                stop = true;
>> +            } else {
>> +                /* Ok to do a Shift_N2 */
>> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
>> +                                FSM_SHIFT_N2);
>> +                stop = operation_shiftn2(s, opcode, &payload);
>> +                /*
>> +                 * If the operation code says to stop set the 
>> shifter state to
>> +                 * wait and stop
>> +                 */
>> +                if (stop) {
>> +                    s->status = SETFIELD(SPI_STS_SHIFTER_FSM, 
>> s->status,
>> +                                    FSM_WAIT);
>> +                } else {
>> +                    /* Ok to move on to the next index */
>> +                    next_sequencer_fsm(s);
>> +                }
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_BRANCH_IFNEQ_RDR:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR", 
>> get_seq_index(s));
>> +            /*
>> +             * The memory mapping register RDR match value is 
>> compared against
>> +             * the 16 rightmost bytes of the RDR (potentially with 
>> masking).
>> +             * Since this comparison is performed against the 
>> contents of the
>> +             * RDR then a receive must have previously occurred 
>> otherwise
>> +             * there is no data to compare and the operation cannot be
>> +             * completed and will stop the sequencer until RDR full 
>> is set to
>> +             * 1.
>> +             */
>> +            if (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1) {
>> +                bool rdr_matched = false;
>> +                rdr_matched = does_rdr_match(s);
>> +                if (rdr_matched) {
>> +                    trace_pnv_spi_RDR_match("success");
>> +                    /* A match occurred, increment the sequencer 
>> index. */
>> +                    next_sequencer_fsm(s);
>> +                } else {
>> +                    trace_pnv_spi_RDR_match("failed");
>> +                    /*
>> +                     * Branch the sequencer to the index coded into 
>> the op
>> +                     * code.
>> +                     */
>> +                    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
>> + PNV_SPI_OPCODE_LO_NIBBLE(opcode));
>> +                }
>> +                /*
>> +                 * Regardless of where the branch ended up we want the
>> +                 * sequencer to continue shifting so we have to clear
>> +                 * RDR_full.
>> +                 */
>> +                s->status = SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
>> +            } else {
>> +                trace_pnv_spi_sequencer_stop_requested("RDR not"
>> +                                "full for 0x6x opcode");
>> +                stop = true;
>> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, 
>> FSM_WAIT);
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_TRANSFER_TDR:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not 
>> supported\n");
>> +            next_sequencer_fsm(s);
>> +            break;
>> +
>> +        case SEQ_OP_BRANCH_IFNEQ_INC_1:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1", 
>> get_seq_index(s));
>> +            /*
>> +             * The spec says the loop should execute count compare + 
>> 1 times.
>> +             * However we learned from engineering that we really 
>> only loop
>> +             * count_compare times, count compare = 0 makes this op 
>> code a
>> +             * no-op
>> +             */
>> +            if (s->loop_counter_1 !=
>> +                GETFIELD(SPI_CTR_CFG_CMP1, s->regs[SPI_CTR_CFG_REG])) {
>> +                /*
>> +                 * Next index is the lower nibble of the branch 
>> operation ID,
>> +                 * mask off all but the first three bits so we don't 
>> try to
>> +                 * access beyond the sequencer_operation_reg boundary.
>> +                 */
>> +                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
>> + PNV_SPI_OPCODE_LO_NIBBLE(opcode));
>> +                s->loop_counter_1++;
>> +            } else {
>> +                /* Continue to next index if loop counter is reached */
>> +                next_sequencer_fsm(s);
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_BRANCH_IFNEQ_INC_2:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", 
>> get_seq_index(s));
>> +            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2,
>> +                              s->regs[SPI_CTR_CFG_REG]);
>> +            /*
>> +             * The spec says the loop should execute count compare + 
>> 1 times.
>> +             * However we learned from engineering that we really 
>> only loop
>> +             * count_compare times, count compare = 0 makes this op 
>> code a
>> +             * no-op
>> +             */
>> +            if (s->loop_counter_2 != condition2) {
>> +                /*
>> +                 * Next index is the lower nibble of the branch 
>> operation ID,
>> +                 * mask off all but the first three bits so we don't 
>> try to
>> +                 * access beyond the sequencer_operation_reg boundary.
>> +                 */
>> +                s->status = SETFIELD(SPI_STS_SEQ_INDEX,
>> +                                s->status, 
>> PNV_SPI_OPCODE_LO_NIBBLE(opcode));
>> +                s->loop_counter_2++;
>> +            } else {
>> +                /* Continue to next index if loop counter is reached */
>> +                next_sequencer_fsm(s);
>> +            }
>> +            break;
>> +
>> +        default:
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_EXECUTE);
>> +            /* Ignore unsupported operations. */
>> +            next_sequencer_fsm(s);
>> +            break;
>> +        } /* end of switch */
>> +        /*
>> +         * If we used all 8 opcodes without seeing a 00 - STOP in 
>> the sequence
>> +         * we need to go ahead and end things as if there was a STOP 
>> at the
>> +         * end.
>> +         */
>> +        if (get_seq_index(s) == NUM_SEQ_OPS) {
>> +            /* All 8 opcodes completed, sequencer idling */
>> +            s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, 
>> FSM_IDLE);
>> +            s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
>> +            s->loop_counter_1 = 0;
>> +            s->loop_counter_2 = 0;
>> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, 
>> SEQ_STATE_IDLE);
>> +            break;
>> +        }
>> +        /* Break the loop if a stop was requested */
>> +        if (stop) {
>> +            break;
>> +        }
>> +    } /* end of while */
>> +    return;
>> +} /* end of operation_sequencer() */
>> +
>> +/*
>> + * The SPIC engine and its internal sequencer can be interrupted and 
>> reset by
>> + * a hardware signal, the sbe_spicst_hard_reset bits from Pervasive
>> + * Miscellaneous Register of sbe_register_bo device.
>> + * Reset immediately aborts any SPI transaction in progress and 
>> returns the
>> + * sequencer and state machines to idle state.
>> + * The configuration register values are not changed. The status 
>> register is
>> + * not reset. The engine registers are not reset.
>> + * The SPIC engine reset does not have any affect on the attached 
>> devices.
>> + * Reset handling of any attached devices is beyond the scope of the 
>> engine.
>> + */
>> +static void do_reset(DeviceState *dev)
>> +{
>> +    PnvSpi *s = PNV_SPI(dev);
>> +
>> +    trace_pnv_spi_reset();
>> +
>> +    /* Reset all N1 and N2 counters, and other constants */
>> +    s->N2_bits = 0;
>> +    s->N2_bytes = 0;
>> +    s->N2_tx = 0;
>> +    s->N2_rx = 0;
>> +    s->N1_bits = 0;
>> +    s->N1_bytes = 0;
>> +    s->N1_tx = 0;
>> +    s->N1_rx = 0;
>> +    s->loop_counter_1 = 0;
>> +    s->loop_counter_2 = 0;
>> +    /* Disconnected from responder */
>> +    qemu_set_irq(s->cs_line[0], 1);
>> +}
>> +
>>   static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, 
>> unsigned size)
>>   {
>>       PnvSpi *s = PNV_SPI(opaque);
>> @@ -51,6 +1088,10 @@ static uint64_t pnv_spi_xscom_read(void *opaque, 
>> hwaddr addr, unsigned size)
>>           val = s->regs[reg];
>>           trace_pnv_spi_read_RDR(val);
>>           s->status = SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
>> +        if (GETFIELD(SPI_STS_SHIFTER_FSM, s->status) == FSM_WAIT) {
>> +            trace_pnv_spi_start_sequencer();
>> +            operation_sequencer(s);
>> +        }
>>           break;
>>       case SPI_SEQ_OP_REG:
>>           val = 0;
>> @@ -112,6 +1153,8 @@ static void pnv_spi_xscom_write(void *opaque, 
>> hwaddr addr,
>>           trace_pnv_spi_write_TDR(val);
>>           s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 1);
>>           s->status = SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 0);
>> +        trace_pnv_spi_start_sequencer();
>> +        operation_sequencer(s);
>>           break;
>>       case SPI_SEQ_OP_REG:
>>           for (int i = 0; i < PNV_SPI_REG_SIZE; i++) {
>> @@ -144,6 +1187,7 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
>>     static Property pnv_spi_properties[] = {
>>       DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
>> +    DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   @@ -193,6 +1237,7 @@ static void pnv_spi_class_init(ObjectClass 
>> *klass, void *data)
>>         dc->desc = "PowerNV SPI";
>>       dc->realize = pnv_spi_realize;
>> +    dc->reset = do_reset;
>>       device_class_set_props(dc, pnv_spi_properties);
>>   }
>>   diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
>> index 2cc29e1284..089d269994 100644
>> --- a/hw/ssi/trace-events
>> +++ b/hw/ssi/trace-events
>> @@ -38,3 +38,18 @@ pnv_spi_read(uint64_t addr, uint64_t val) "addr 
>> 0x%" PRIx64 " val 0x%" PRIx64
>>   pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 
>> 0x%" PRIx64
>>   pnv_spi_read_RDR(uint64_t val) "data extracted = 0x%" PRIx64
>>   pnv_spi_write_TDR(uint64_t val) "being written, data written = 0x%" 
>> PRIx64
>> +pnv_spi_start_sequencer(void) ""
>> +pnv_spi_reset(void) "spic engine sequencer configuration and spi 
>> communication"
>> +pnv_spi_sequencer_op(const char* op, uint8_t index) "%s at index = 
>> 0x%x"
>> +pnv_spi_shifter_stating(void) "pull CS line low"
>> +pnv_spi_shifter_done(void) "pull the CS line high"
>> +pnv_spi_log_Ncounts(uint8_t N1_bits, uint8_t N1_bytes, uint8_t 
>> N1_tx, uint8_t N1_rx, uint8_t N2_bits, uint8_t N2_bytes, uint8_t 
>> N2_tx, uint8_t N2_rx) "N1_bits = %d, N1_bytes = %d, N1_tx = %d, N1_rx 
>> = %d, N2_bits = %d, N2_bytes = %d, N2_tx = %d, N2_rx = %d"
>> +pnv_spi_tx_append(const char* frame, uint8_t byte, uint8_t 
>> tdr_index) "%s = 0x%2.2x to payload from TDR at index %d"
>> +pnv_spi_tx_append_FF(const char* frame) "%s to Payload"
>> +pnv_spi_tx_request(const char* frame, uint32_t payload_len) "%s, 
>> payload len = %d"
>> +pnv_spi_rx_received(uint32_t payload_len) "payload len = %d"
>> +pnv_spi_rx_read_N1frame(void) ""
>> +pnv_spi_rx_read_N2frame(void) ""
>> +pnv_spi_shift_rx(uint8_t byte, uint32_t index) "byte = 0x%2.2x into 
>> RDR from payload index %d"
>> +pnv_spi_sequencer_stop_requested(const char* reason) "due to %s"
>> +pnv_spi_RDR_match(const char* result) "%s"
>> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
>> index 833042b74b..8815f67d45 100644
>> --- a/include/hw/ssi/pnv_spi.h
>> +++ b/include/hw/ssi/pnv_spi.h
>> @@ -8,6 +8,14 @@
>>    * This model Supports a connection to a single SPI responder.
>>    * Introduced for P10 to provide access to SPI seeproms, TPM, flash 
>> device
>>    * and an ADC controller.
>> + *
>> + * All SPI function control is mapped into the SPI register space to 
>> enable
>> + * full control by firmware.
>> + *
>> + * SPI Controller has sequencer and shift engine. The SPI shift engine
>> + * performs serialization and de-serialization according to the 
>> control by
>> + * the sequencer and according to the setup defined in the 
>> configuration
>> + * registers and the SPI sequencer implements the main control logic.
>>    */
>>     #ifndef PPC_PNV_SPI_H
>> @@ -31,6 +39,25 @@ typedef struct PnvSpi {
>>       MemoryRegion    xscom_spic_regs;
>>       /* SPI object number */
>>       uint32_t        spic_num;
>> +    uint8_t         transfer_len;
>> +    uint8_t         responder_select;
>> +    /* To verify if shift_n1 happens prior to shift_n2 */
>> +    bool            shift_n1_done;
>> +    /* Loop counter for branch operation opcode Ex/Fx */
>> +    uint8_t         loop_counter_1;
>> +    uint8_t         loop_counter_2;
>> +    /* N1/N2_bits specifies the size of the N1/N2 segment of a frame 
>> in bits.*/
>> +    uint8_t         N1_bits;
>> +    uint8_t         N2_bits;
>> +    /* Number of bytes in a payload for the N1/N2 frame segment.*/
>> +    uint8_t         N1_bytes;
>> +    uint8_t         N2_bytes;
>> +    /* Number of N1/N2 bytes marked for transmit */
>> +    uint8_t         N1_tx;
>> +    uint8_t         N2_tx;
>> +    /* Number of N1/N2 bytes marked for receive */
>> +    uint8_t         N1_rx;
>> +    uint8_t         N2_rx;
>>         /* SPI registers */
>>       uint64_t        regs[PNV_SPI_REGS];
>> diff --git a/include/hw/ssi/pnv_spi_regs.h 
>> b/include/hw/ssi/pnv_spi_regs.h
>> index 5b6ff72d02..596e2c1911 100644
>> --- a/include/hw/ssi/pnv_spi_regs.h
>> +++ b/include/hw/ssi/pnv_spi_regs.h
>> @@ -28,6 +28,17 @@
>>     /* counter_config_reg */
>>   #define SPI_CTR_CFG_REG         0x01
>> +#define SPI_CTR_CFG_N1          PPC_BITMASK(0, 7)
>> +#define SPI_CTR_CFG_N2          PPC_BITMASK(8, 15)
>> +#define SPI_CTR_CFG_CMP1        PPC_BITMASK(24, 31)
>> +#define SPI_CTR_CFG_CMP2        PPC_BITMASK(32, 39)
>> +#define SPI_CTR_CFG_N1_CTRL_B1  PPC_BIT(49)
>> +#define SPI_CTR_CFG_N1_CTRL_B2  PPC_BIT(50)
>> +#define SPI_CTR_CFG_N1_CTRL_B3  PPC_BIT(51)
>> +#define SPI_CTR_CFG_N2_CTRL_B0  PPC_BIT(52)
>> +#define SPI_CTR_CFG_N2_CTRL_B1  PPC_BIT(53)
>> +#define SPI_CTR_CFG_N2_CTRL_B2  PPC_BIT(54)
>> +#define SPI_CTR_CFG_N2_CTRL_B3  PPC_BIT(55)
>>     /* config_reg */
>>   #define CONFIG_REG1             0x02
>> @@ -36,9 +47,13 @@
>>   #define SPI_CLK_CFG_REG         0x03
>>   #define SPI_CLK_CFG_HARD_RST    0x0084000000000000;
>>   #define SPI_CLK_CFG_RST_CTRL    PPC_BITMASK(24, 27)
>> +#define SPI_CLK_CFG_ECC_EN      PPC_BIT(28)
>> +#define SPI_CLK_CFG_ECC_CTRL    PPC_BITMASK(29, 30)
>>     /* memory_mapping_reg */
>>   #define SPI_MM_REG              0x04
>> +#define SPI_MM_RDR_MATCH_VAL    PPC_BITMASK(32, 47)
>> +#define SPI_MM_RDR_MATCH_MASK   PPC_BITMASK(48, 63)
>>     /* transmit_data_reg */
>>   #define SPI_XMIT_DATA_REG       0x05
>> @@ -60,8 +75,59 @@
>>   #define SPI_STS_SEQ_FSM         PPC_BITMASK(8, 15)
>>   #define SPI_STS_SHIFTER_FSM     PPC_BITMASK(16, 27)
>>   #define SPI_STS_SEQ_INDEX       PPC_BITMASK(28, 31)
>> -#define SPI_STS_GEN_STATUS      PPC_BITMASK(32, 63)
>> +#define SPI_STS_GEN_STATUS_B3   PPC_BIT(35)
>>   #define SPI_STS_RDR             PPC_BITMASK(1, 3)
>>   #define SPI_STS_TDR             PPC_BITMASK(5, 7)
>>   +/*
>> + * Shifter states
>> + *
>> + * These are the same values defined for the Shifter FSM field of the
>> + * status register.  It's a 12 bit field so we will represent it as 
>> three
>> + * nibbles in the constants.
>> + *
>> + * These are shifter_fsm values
>> + *
>> + * Status reg bits 16-27 -> field bits 0-11
>> + * bits 0,1,2,5 unused/reserved
>> + * bit 4 crc shift in (unused)
>> + * bit 8 crc shift out (unused)
>> + */
>> +
>> +#define FSM_DONE                        0x100   /* bit 3 */
>> +#define FSM_SHIFT_N2                    0x020   /* bit 6 */
>> +#define FSM_WAIT                        0x010   /* bit 7 */
>> +#define FSM_SHIFT_N1                    0x004   /* bit 9 */
>> +#define FSM_START                       0x002   /* bit 10 */
>> +#define FSM_IDLE                        0x001   /* bit 11 */
>> +
>> +/*
>> + * Sequencer states
>> + *
>> + * These are sequencer_fsm values
>> + *
>> + * Status reg bits 8-15 -> field bits 0-7
>> + * bits 0-3 unused/reserved
>> + *
>> + */
>> +#define SEQ_STATE_INDEX_INCREMENT       0x08    /* bit 4 */
>> +#define SEQ_STATE_EXECUTE               0x04    /* bit 5 */
>> +#define SEQ_STATE_DECODE                0x02    /* bit 6 */
>> +#define SEQ_STATE_IDLE                  0x01    /* bit 7 */
>> +
>> +/*
>> + * These are the supported sequencer operations.
>> + * Only the upper nibble is significant because for many operations
>> + * the lower nibble is a variable specific to the operation.
>> + */
>> +#define SEQ_OP_STOP                     0x00
>> +#define SEQ_OP_SELECT_SLAVE             0x10
>> +#define SEQ_OP_SHIFT_N1                 0x30
>> +#define SEQ_OP_SHIFT_N2                 0x40
>> +#define SEQ_OP_BRANCH_IFNEQ_RDR         0x60
>> +#define SEQ_OP_TRANSFER_TDR             0xC0
>> +#define SEQ_OP_BRANCH_IFNEQ_INC_1       0xE0
>> +#define SEQ_OP_BRANCH_IFNEQ_INC_2       0xF0
>> +#define NUM_SEQ_OPS                     8
>> +
>>   #endif
>
--------------Gw0ZGIHxDcROrn20LhK1oi56
Content-Type: multipart/related;
 boundary="------------AsiX0aWtQ9UPkoQ2ozIemWwV"

--------------AsiX0aWtQ9UPkoQ2ozIemWwV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 29-07-2024 16:02, Cédric Le Goater
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:8d93da65-36a9-4642-9345-1b698191ba49@kaod.org">On
      7/26/24 01:53, Nicholas Piggin wrote:
      <br>
      <blockquote type="cite">From: Chalapathi V
        <a class="moz-txt-link-rfc2396E" href="mailto:chalapathi.v@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a>
        <br>
        <br>
        In this commit SPI shift engine and sequencer logic is
        implemented.
        <br>
        Shift engine performs serialization and de-serialization
        according to the
        <br>
        control by the sequencer and according to the setup defined in
        the
        <br>
        configuration registers. Sequencer implements the main control
        logic and
        <br>
        FSM to handle data transmit and data receive control of the
        shift engine.
        <br>
        <br>
        Signed-off-by: Chalapathi V <a class="moz-txt-link-rfc2396E" href="mailto:chalapathi.v@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a>
        <br>
        Reviewed-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.vnet.ibm.com">&lt;calebs@linux.vnet.ibm.com&gt;</a>
        <br>
        Reviewed-by: Glenn Miles <a class="moz-txt-link-rfc2396E" href="mailto:milesg@linux.ibm.com">&lt;milesg@linux.ibm.com&gt;</a>
        <br>
        Signed-off-by: Nicholas Piggin <a class="moz-txt-link-rfc2396E" href="mailto:npiggin@gmail.com">&lt;npiggin@gmail.com&gt;</a>
        <br>
        ---
        <br>
          hw/ssi/pnv_spi.c              | 1045
        +++++++++++++++++++++++++++++++++
        <br>
          hw/ssi/trace-events           |   15 +
        <br>
          include/hw/ssi/pnv_spi.h      |   27 +
        <br>
          include/hw/ssi/pnv_spi_regs.h |   68 ++-
        <br>
          4 files changed, 1154 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
        <br>
        index 468afdad07..cdff3f9621 100644
        <br>
        --- a/hw/ssi/pnv_spi.c
        <br>
        +++ b/hw/ssi/pnv_spi.c
        <br>
        @@ -17,6 +17,9 @@
        <br>
          #include "hw/irq.h"
        <br>
          #include "trace.h"
        <br>
          +#define PNV_SPI_OPCODE_LO_NIBBLE(x) (x &amp; 0x0F)
        <br>
        +#define PNV_SPI_MASKED_OPCODE(x) (x &amp; 0xF0)
        <br>
        +
        <br>
          /*
        <br>
           * Macro from include/hw/ppc/fdt.h
        <br>
           * fdt.h cannot be included here as it contain ppc target
        specific dependency.
        <br>
        @@ -32,6 +35,1040 @@
        <br>
                 
        }                                                          \
        <br>
              } while (0)
        <br>
          +/* PnvXferBuffer */
        <br>
        +typedef struct PnvXferBuffer {
        <br>
        +
        <br>
        +    uint32_t    len;
        <br>
        +    uint8_t    *data;
        <br>
        +
        <br>
        +} PnvXferBuffer;
        <br>
        +
        <br>
        +/* pnv_spi_xfer_buffer_methods */
        <br>
        +static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
        <br>
        +{
        <br>
        +    PnvXferBuffer *payload = g_malloc0(sizeof(*payload));
        <br>
        +
        <br>
        +    return payload;
        <br>
        +}
        <br>
        +
        <br>
        +static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
        <br>
        +{
        <br>
        +    free(payload-&gt;data);
        <br>
        +    free(payload);
        <br>
        +}
        <br>
        +
        <br>
        +static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer
        *payload,
        <br>
        +                uint32_t offset, uint32_t length)
        <br>
        +{
        <br>
        +    if (payload-&gt;len &lt; (offset + length)) {
        <br>
        +        payload-&gt;len = offset + length;
        <br>
        +        payload-&gt;data = g_realloc(payload-&gt;data,
        payload-&gt;len);
        <br>
        +    }
        <br>
        +    return &amp;payload-&gt;data[offset];
        <br>
        +}
        <br>
        +
        <br>
        +static bool does_rdr_match(PnvSpi *s)
        <br>
        +{
        <br>
        +    /*
        <br>
        +     * According to spec, the mask bits that are 0 are compared
        and the
        <br>
        +     * bits that are 1 are ignored.
        <br>
        +     */
        <br>
        +    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK,
        <br>
        +                                       
        s-&gt;regs[SPI_MM_REG]);
        <br>
        +    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL,
        <br>
        +                                       
        s-&gt;regs[SPI_MM_REG]);
        <br>
        +
        <br>
        +    if ((~rdr_match_mask &amp; rdr_match_val) ==
        ((~rdr_match_mask) &amp;
        <br>
        +            GETFIELD(PPC_BITMASK(48, 63),
        s-&gt;regs[SPI_RCV_DATA_REG]))) {
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +    return false;
        <br>
        +}
        <br>
        +
        <br>
        +static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)
        <br>
        +{
        <br>
        +    uint8_t byte;
        <br>
        +
        <br>
        +    /*
        <br>
        +     * Offset is an index between 0 and PNV_SPI_REG_SIZE - 1
        <br>
        +     * Check the offset before using it.
        <br>
        +     */
        <br>
        +    if (offset &lt; PNV_SPI_REG_SIZE) {
        <br>
        +        byte = (s-&gt;regs[SPI_XMIT_DATA_REG] &gt;&gt; (56 -
        offset * 8)) &amp; 0xFF;
        <br>
        +    } else {
        <br>
        +        /*
        <br>
        +         * Log an error and return a 0xFF since we have to
        assign something
        <br>
        +         * to byte before returning.
        <br>
        +         */
        <br>
        +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid offset = %d
        used to get byte "
        <br>
        +                      "from TDR\n", offset);
        <br>
        +        byte = 0xff;
        <br>
        +    }
        <br>
        +    return byte;
        <br>
        +}
        <br>
        +
        <br>
        +static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf,
        uint8_t nr_bytes,
        <br>
        +                uint8_t ecc_count, uint8_t shift_in_count)
        <br>
        +{
        <br>
        +    uint8_t byte;
        <br>
        +    int count = 0;
        <br>
        +
        <br>
        +    while (count &lt; nr_bytes) {
        <br>
        +        shift_in_count++;
        <br>
        +        if ((ecc_count != 0) &amp;&amp;
        <br>
        +            (shift_in_count == (PNV_SPI_REG_SIZE + ecc_count)))
        {
        <br>
        +            shift_in_count = 0;
        <br>
        +        } else {
        <br>
        +            byte = read_buf[count];
        <br>
        +            trace_pnv_spi_shift_rx(byte, count);
        <br>
        +            s-&gt;regs[SPI_RCV_DATA_REG] =
        (s-&gt;regs[SPI_RCV_DATA_REG] &lt;&lt; 8) | byte;
        <br>
        +        }
        <br>
        +        count++;
        <br>
        +    } /* end of while */
        <br>
        +    return shift_in_count;
        <br>
        +}
        <br>
        +
        <br>
        +static void spi_response(PnvSpi *s, int bits, PnvXferBuffer
        *rsp_payload)
        <br>
        +{
        <br>
        +    uint8_t ecc_count;
        <br>
        +    uint8_t shift_in_count;
        <br>
        +
        <br>
        +    /*
        <br>
        +     * Processing here must handle:
        <br>
        +     * - Which bytes in the payload we should move to the RDR
        <br>
        +     * - Explicit mode counter configuration settings
        <br>
        +     * - RDR full and RDR overrun status
        <br>
        +     */
        <br>
        +
        <br>
        +    /*
        <br>
        +     * First check that the response payload is the exact same
        <br>
        +     * number of bytes as the request payload was
        <br>
        +     */
        <br>
        +    if (rsp_payload-&gt;len != (s-&gt;N1_bytes +
        s-&gt;N2_bytes)) {
        <br>
        +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid response
        payload size in "
        <br>
        +                       "bytes, expected %d, got %d\n",
        <br>
        +                       (s-&gt;N1_bytes + s-&gt;N2_bytes),
        rsp_payload-&gt;len);
        <br>
        +    } else {
        <br>
        +        uint8_t ecc_control;
        <br>
        +        trace_pnv_spi_rx_received(rsp_payload-&gt;len);
        <br>
        +        trace_pnv_spi_log_Ncounts(s-&gt;N1_bits,
        s-&gt;N1_bytes, s-&gt;N1_tx,
        <br>
        +                        s-&gt;N1_rx, s-&gt;N2_bits,
        s-&gt;N2_bytes, s-&gt;N2_tx, s-&gt;N2_rx);
        <br>
        +        /*
        <br>
        +         * Adding an ECC count let's us know when we have found
        a payload byte
        <br>
        +         * that was shifted in but cannot be loaded into RDR. 
        Bits 29-30 of
        <br>
        +         * clock_config_reset_control register equal to either
        0b00 or 0b10
        <br>
        +         * indicate that we are taking in data with ECC and
        either applying
        <br>
        +         * the ECC or discarding it.
        <br>
        +         */
        <br>
        +        ecc_count = 0;
        <br>
        +        ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
        s-&gt;regs[SPI_CLK_CFG_REG]);
        <br>
        +        if (ecc_control == 0 || ecc_control == 2) {
        <br>
        +            ecc_count = 1;
        <br>
        +        }
        <br>
        +        /*
        <br>
        +         * Use the N1_rx and N2_rx counts to control shifting
        data from the
        <br>
        +         * payload into the RDR.  Keep an overall count of the
        number of bytes
        <br>
        +         * shifted into RDR so we can discard every 9th byte
        when ECC is
        <br>
        +         * enabled.
        <br>
        +         */
        <br>
        +        shift_in_count = 0;
        <br>
        +        /* Handle the N1 portion of the frame first */
        <br>
        +        if (s-&gt;N1_rx != 0) {
        <br>
        +            trace_pnv_spi_rx_read_N1frame();
        <br>
        +            shift_in_count = read_from_frame(s,
        &amp;rsp_payload-&gt;data[0],
        <br>
        +                            s-&gt;N1_bytes, ecc_count,
        shift_in_count);
        <br>
        +        }
        <br>
        +        /* Handle the N2 portion of the frame */
        <br>
        +        if (s-&gt;N2_rx != 0) {
        <br>
        +            trace_pnv_spi_rx_read_N2frame();
        <br>
        +            shift_in_count = read_from_frame(s,
        <br>
        +                           
        &amp;rsp_payload-&gt;data[s-&gt;N1_bytes], s-&gt;N2_bytes,
        <br>
        +                            ecc_count, shift_in_count);
        <br>
        +        }
        <br>
        +        if ((s-&gt;N1_rx + s-&gt;N2_rx) &gt; 0) {
        <br>
        +            /*
        <br>
        +             * Data was received so handle RDR status.
        <br>
        +             * It is easier to handle RDR_full and RDR_overrun
        status here
        <br>
        +             * since the RDR register's shift_byte_in method is
        called
        <br>
        +             * multiple times in a row. Controlling RDR status
        is done here
        <br>
        +             * instead of in the RDR scoped methods for that
        reason.
        <br>
        +             */
        <br>
        +            if (GETFIELD(SPI_STS_RDR_FULL, s-&gt;status) == 1)
        {
        <br>
        +                /*
        <br>
        +                 * Data was shifted into the RDR before having
        been read
        <br>
        +                 * causing previous data to have been overrun.
        <br>
        +                 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_RDR_OVERRUN,
        s-&gt;status, 1);
        <br>
        +            } else {
        <br>
        +                /*
        <br>
        +                 * Set status to indicate that the received
        data register is
        <br>
        +                 * full. This flag is only cleared once the RDR
        is unloaded.
        <br>
        +                 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_RDR_FULL,
        s-&gt;status, 1);
        <br>
        +            }
        <br>
        +        }
        <br>
        +    } /* end of else */
        <br>
        +} /* end of spi_response() */
        <br>
        +
        <br>
        +static void transfer(PnvSpi *s, PnvXferBuffer *payload)
        <br>
        +{
        <br>
        +    uint32_t tx;
        <br>
        +    uint32_t rx;
        <br>
        +    PnvXferBuffer *rsp_payload = NULL;
        <br>
        +
        <br>
        +    rsp_payload = pnv_spi_xfer_buffer_new();
        <br>
        +    for (int offset = 0; offset &lt; payload-&gt;len; offset +=
        s-&gt;transfer_len) {
        <br>
        +        tx = 0;
        <br>
        +        for (int i = 0; i &lt; s-&gt;transfer_len; i++) {
        <br>
        +            if ((offset + i) &gt;= payload-&gt;len) {
        <br>
        +                tx &lt;&lt;= 8;
        <br>
        +            } else {
        <br>
        +                tx = (tx &lt;&lt; 8) | payload-&gt;data[offset
        + i];
        <br>
        +            }
        <br>
        +        }
        <br>
        +        rx = ssi_transfer(s-&gt;ssi_bus, tx);
        <br>
        +        for (int i = 0; i &lt; s-&gt;transfer_len; i++) {
        <br>
        +            if ((offset + i) &gt;= payload-&gt;len) {
        <br>
        +                break;
        <br>
        +            }
        <br>
        +            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload,
        rsp_payload-&gt;len, 1)) =
        <br>
        +                    (rx &gt;&gt; (8 * (s-&gt;transfer_len - 1)
        - i * 8)) &amp; 0xFF;
        <br>
        +        }
        <br>
        +    }
        <br>
        +    if (rsp_payload != NULL) {
        <br>
        +        spi_response(s, s-&gt;N1_bits, rsp_payload);
        <br>
        +    }
        <br>
        +}
        <br>
        +
        <br>
        +static inline uint8_t get_seq_index(PnvSpi *s)
        <br>
        +{
        <br>
        +    return GETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status);
        <br>
        +}
        <br>
      </blockquote>
      <br>
      Coverity reports :
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">    CID 1558827:    (OVERRUN)
            <br>
                Overrunning array "s-&gt;seq_op" of 8 bytes at byte
            offset 16 using index "get_seq_index(s) + 1" (which
            evaluates to 16).
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
      <br>
      get_seq_index() can return a value between 0 and 15 and it is used
      in a couple
      <br>
      of places to index array s-&gt;seq_op[] which is an 8 bytes array.
      <br>
      <br>
      Should we increase the size of the seq_op array ?
      <br>
      <br>
      Thanks,
      <br>
      <br>
      C.
      <br>
    </blockquote>
    <p>Hello Cedric,</p>
    <p>s-&gt;status.sequencer_index is 4 bits long and can have values
      between 0 and 15. <br>
      <img src="cid:part1.ChV0HYaF.T02xP4Qq@linux.ibm.com" alt=""><br>
      However when referencing s-&gt;seq_op[], we need to check for
      array boundary. <br>
      Thank You</p>
    <p>Chalapathi<br>
    </p>
    <blockquote type="cite"
      cite="mid:8d93da65-36a9-4642-9345-1b698191ba49@kaod.org">
      <br>
      <br>
      <br>
      <blockquote type="cite">+static inline void
        next_sequencer_fsm(PnvSpi *s)
        <br>
        +{
        <br>
        +    uint8_t seq_index = get_seq_index(s);
        <br>
        +    s-&gt;status = SETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status,
        (seq_index + 1));
        <br>
        +    s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status,
        SEQ_STATE_INDEX_INCREMENT);
        <br>
        +}
        <br>
        +
        <br>
        +/*
        <br>
        + * Calculate the N1 counters based on passed in opcode and
        <br>
        + * internal register values.
        <br>
        + * The method assumes that the opcode is a Shift_N1 opcode
        <br>
        + * and doesn't test it.
        <br>
        + * The counters returned are:
        <br>
        + * N1 bits: Number of bits in the payload data that are
        significant
        <br>
        + * to the responder.
        <br>
        + * N1_bytes: Total count of payload bytes for the N1 (portion
        of the) frame.
        <br>
        + * N1_tx: Total number of bytes taken from TDR for N1
        <br>
        + * N1_rx: Total number of bytes taken from the payload for N1
        <br>
        + */
        <br>
        +static void calculate_N1(PnvSpi *s, uint8_t opcode)
        <br>
        +{
        <br>
        +    /*
        <br>
        +     * Shift_N1 opcode form: 0x3M
        <br>
        +     * Implicit mode:
        <br>
        +     * If M != 0 the shift count is M bytes and M is the number
        of tx bytes.
        <br>
        +     * Forced Implicit mode:
        <br>
        +     * M is the shift count but tx and rx is determined by the
        count control
        <br>
        +     * register fields.  Note that we only check for forced
        Implicit mode when
        <br>
        +     * M != 0 since the mode doesn't make sense when M = 0.
        <br>
        +     * Explicit mode:
        <br>
        +     * If M == 0 then shift count is number of bits defined in
        the
        <br>
        +     * Counter Configuration Register's shift_count_N1 field.
        <br>
        +     */
        <br>
        +    if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) == 0) {
        <br>
        +        /* Explicit mode */
        <br>
        +        s-&gt;N1_bits = GETFIELD(SPI_CTR_CFG_N1,
        s-&gt;regs[SPI_CTR_CFG_REG]);
        <br>
        +        s-&gt;N1_bytes = (s-&gt;N1_bits + 7) / 8;
        <br>
        +        s-&gt;N1_tx = 0;
        <br>
        +        s-&gt;N1_rx = 0;
        <br>
        +        /* If tx count control for N1 is set, load the tx value
        */
        <br>
        +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
        <br>
        +            s-&gt;N1_tx = s-&gt;N1_bytes;
        <br>
        +        }
        <br>
        +        /* If rx count control for N1 is set, load the rx value
        */
        <br>
        +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
        <br>
        +            s-&gt;N1_rx = s-&gt;N1_bytes;
        <br>
        +        }
        <br>
        +    } else {
        <br>
        +        /* Implicit mode/Forced Implicit mode, use M field from
        opcode */
        <br>
        +        s-&gt;N1_bytes = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
        <br>
        +        s-&gt;N1_bits = s-&gt;N1_bytes * 8;
        <br>
        +        /*
        <br>
        +         * Assume that we are going to transmit the count
        <br>
        +         * (pure Implicit only)
        <br>
        +         */
        <br>
        +        s-&gt;N1_tx = s-&gt;N1_bytes;
        <br>
        +        s-&gt;N1_rx = 0;
        <br>
        +        /* Let Forced Implicit mode have an effect on the
        counts */
        <br>
        +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B1,
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
        <br>
        +            /*
        <br>
        +             * If Forced Implicit mode and count control
        doesn't
        <br>
        +             * indicate transmit then reset the tx count to 0
        <br>
        +             */
        <br>
        +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
        <br>
        +                                   
        s-&gt;regs[SPI_CTR_CFG_REG]) == 0) {
        <br>
        +                s-&gt;N1_tx = 0;
        <br>
        +            }
        <br>
        +            /* If rx count control for N1 is set, load the rx
        value */
        <br>
        +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
        <br>
        +                                   
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
        <br>
        +                s-&gt;N1_rx = s-&gt;N1_bytes;
        <br>
        +            }
        <br>
        +        }
        <br>
        +    }
        <br>
        +    /*
        <br>
        +     * Enforce an upper limit on the size of N1 that is equal
        to the known size
        <br>
        +     * of the shift register, 64 bits or 72 bits if ECC is
        enabled.
        <br>
        +     * If the size exceeds 72 bits it is a user error so log an
        error,
        <br>
        +     * cap the size at a max of 64 bits or 72 bits and set the
        sequencer FSM
        <br>
        +     * error bit.
        <br>
        +     */
        <br>
        +    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
        <br>
        +                                  
        s-&gt;regs[SPI_CLK_CFG_REG]);
        <br>
        +    if (ecc_control == 0 || ecc_control == 2) {
        <br>
        +        if (s-&gt;N1_bytes &gt; (PNV_SPI_REG_SIZE + 1)) {
        <br>
        +            qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1
        shift size when "
        <br>
        +                          "ECC enabled, bytes = 0x%x, bits =
        0x%x\n",
        <br>
        +                          s-&gt;N1_bytes, s-&gt;N1_bits);
        <br>
        +            s-&gt;N1_bytes = PNV_SPI_REG_SIZE + 1;
        <br>
        +            s-&gt;N1_bits = s-&gt;N1_bytes * 8;
        <br>
        +        }
        <br>
        +    } else if (s-&gt;N1_bytes &gt; PNV_SPI_REG_SIZE) {
        <br>
        +        qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift
        size, "
        <br>
        +                      "bytes = 0x%x, bits = 0x%x\n",
        <br>
        +                      s-&gt;N1_bytes, s-&gt;N1_bits);
        <br>
        +        s-&gt;N1_bytes = PNV_SPI_REG_SIZE;
        <br>
        +        s-&gt;N1_bits = s-&gt;N1_bytes * 8;
        <br>
        +    }
        <br>
        +} /* end of calculate_N1 */
        <br>
        +
        <br>
        +/*
        <br>
        + * Shift_N1 operation handler method
        <br>
        + */
        <br>
        +static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
        <br>
        +                       PnvXferBuffer **payload, bool
        send_n1_alone)
        <br>
        +{
        <br>
        +    uint8_t n1_count;
        <br>
        +    bool stop = false;
        <br>
        +
        <br>
        +    /*
        <br>
        +     * If there isn't a current payload left over from a
        stopped sequence
        <br>
        +     * create a new one.
        <br>
        +     */
        <br>
        +    if (*payload == NULL) {
        <br>
        +        *payload = pnv_spi_xfer_buffer_new();
        <br>
        +    }
        <br>
        +    /*
        <br>
        +     * Use a combination of N1 counters to build the N1 portion
        of the
        <br>
        +     * transmit payload.
        <br>
        +     * We only care about transmit at this time since the
        request payload
        <br>
        +     * only represents data going out on the controller output
        line.
        <br>
        +     * Leave mode specific considerations in the calculate
        function since
        <br>
        +     * all we really care about are counters that tell use
        exactly how
        <br>
        +     * many bytes are in the payload and how many of those
        bytes to
        <br>
        +     * include from the TDR into the payload.
        <br>
        +     */
        <br>
        +    calculate_N1(s, opcode);
        <br>
        +    trace_pnv_spi_log_Ncounts(s-&gt;N1_bits, s-&gt;N1_bytes,
        s-&gt;N1_tx,
        <br>
        +                    s-&gt;N1_rx, s-&gt;N2_bits, s-&gt;N2_bytes,
        s-&gt;N2_tx, s-&gt;N2_rx);
        <br>
        +    /*
        <br>
        +     * Zero out the N2 counters here in case there is no N2
        operation following
        <br>
        +     * the N1 operation in the sequencer.  This keeps leftover
        N2 information
        <br>
        +     * from interfering with spi_response logic.
        <br>
        +     */
        <br>
        +    s-&gt;N2_bits = 0;
        <br>
        +    s-&gt;N2_bytes = 0;
        <br>
        +    s-&gt;N2_tx = 0;
        <br>
        +    s-&gt;N2_rx = 0;
        <br>
        +    /*
        <br>
        +     * N1_bytes is the overall size of the N1 portion of the
        frame regardless of
        <br>
        +     * whether N1 is used for tx, rx or both.  Loop over the
        size to build a
        <br>
        +     * payload that is N1_bytes long.
        <br>
        +     * N1_tx is the count of bytes to take from the TDR and
        "shift" into the
        <br>
        +     * frame which means append those bytes to the payload for
        the N1 portion
        <br>
        +     * of the frame.
        <br>
        +     * If N1_tx is 0 or if the count exceeds the size of the
        TDR append 0xFF to
        <br>
        +     * the frame until the overall N1 count is reached.
        <br>
        +     */
        <br>
        +    n1_count = 0;
        <br>
        +    while (n1_count &lt; s-&gt;N1_bytes) {
        <br>
        +        /*
        <br>
        +         * Assuming that if N1_tx is not equal to 0 then it is
        the same as
        <br>
        +         * N1_bytes.
        <br>
        +         */
        <br>
        +        if ((s-&gt;N1_tx != 0) &amp;&amp; (n1_count &lt;
        PNV_SPI_REG_SIZE)) {
        <br>
        +
        <br>
        +            if (GETFIELD(SPI_STS_TDR_FULL, s-&gt;status) == 1)
        {
        <br>
        +                /*
        <br>
        +                 * Note that we are only appending to the
        payload IF the TDR
        <br>
        +                 * is full otherwise we don't touch the payload
        because we are
        <br>
        +                 * going to NOT send the payload and instead
        tell the sequencer
        <br>
        +                 * that called us to stop and wait for a TDR
        write so we have
        <br>
        +                 * data to load into the payload.
        <br>
        +                 */
        <br>
        +                uint8_t n1_byte = 0x00;
        <br>
        +                n1_byte = get_from_offset(s, n1_count);
        <br>
        +                trace_pnv_spi_tx_append("n1_byte", n1_byte,
        n1_count);
        <br>
        +                *(pnv_spi_xfer_buffer_write_ptr(*payload,
        (*payload)-&gt;len, 1)) =
        <br>
        +                        n1_byte;
        <br>
        +            } else {
        <br>
        +                /*
        <br>
        +                 * We hit a shift_n1 opcode TX but the TDR is
        empty, tell the
        <br>
        +                 * sequencer to stop and break this loop.
        <br>
        +                 */
        <br>
        +                trace_pnv_spi_sequencer_stop_requested("Shift
        N1"
        <br>
        +                                "set for transmit but TDR is
        empty");
        <br>
        +                stop = true;
        <br>
        +                break;
        <br>
        +            }
        <br>
        +        } else {
        <br>
        +            /*
        <br>
        +             * Cases here:
        <br>
        +             * - we are receiving during the N1 frame segment
        and the RDR
        <br>
        +             *   is full so we need to stop until the RDR is
        read
        <br>
        +             * - we are transmitting and we don't care about
        RDR status
        <br>
        +             *   since we won't be loading RDR during the frame
        segment.
        <br>
        +             * - we are receiving and the RDR is empty so we
        allow the operation
        <br>
        +             *   to proceed.
        <br>
        +             */
        <br>
        +            if ((s-&gt;N1_rx != 0) &amp;&amp;
        (GETFIELD(SPI_STS_RDR_FULL,
        <br>
        +                                           s-&gt;status) == 1))
        {
        <br>
        +                trace_pnv_spi_sequencer_stop_requested("shift
        N1"
        <br>
        +                                "set for receive but RDR is
        full");
        <br>
        +                stop = true;
        <br>
        +                break;
        <br>
        +            } else {
        <br>
        +                trace_pnv_spi_tx_append_FF("n1_byte");
        <br>
        +                *(pnv_spi_xfer_buffer_write_ptr(*payload,
        (*payload)-&gt;len, 1))
        <br>
        +                        = 0xff;
        <br>
        +            }
        <br>
        +        }
        <br>
        +        n1_count++;
        <br>
        +    } /* end of while */
        <br>
        +    /*
        <br>
        +     * If we are not stopping due to an empty TDR and we are
        doing an N1 TX
        <br>
        +     * and the TDR is full we need to clear the TDR_full
        status.
        <br>
        +     * Do this here instead of up in the loop above so we don't
        log the message
        <br>
        +     * in every loop iteration.
        <br>
        +     * Ignore the send_n1_alone flag, all that does is defer
        the TX until the N2
        <br>
        +     * operation, which was found immediately after the current
        opcode.  The TDR
        <br>
        +     * was unloaded and will be shifted so we have to clear the
        TDR_full status.
        <br>
        +     */
        <br>
        +    if (!stop &amp;&amp; (s-&gt;N1_tx != 0) &amp;&amp;
        <br>
        +        (GETFIELD(SPI_STS_TDR_FULL, s-&gt;status) == 1)) {
        <br>
        +        s-&gt;status = SETFIELD(SPI_STS_TDR_FULL, s-&gt;status,
        0);
        <br>
        +    }
        <br>
        +    /*
        <br>
        +     * There are other reasons why the shifter would stop, such
        as a TDR empty
        <br>
        +     * or RDR full condition with N1 set to receive.  If we
        haven't stopped due
        <br>
        +     * to either one of those conditions then check if the
        send_n1_alone flag is
        <br>
        +     * equal to False, indicating the next opcode is an N2
        operation, AND if
        <br>
        +     * the N2 counter reload switch (bit 0 of the N2 count
        control field) is
        <br>
        +     * set.  This condition requires a pacing write to "kick"
        off the N2
        <br>
        +     * shift which includes the N1 shift as well when
        send_n1_alone is False.
        <br>
        +     */
        <br>
        +    if (!stop &amp;&amp; !send_n1_alone &amp;&amp;
        <br>
        +       (GETFIELD(SPI_CTR_CFG_N2_CTRL_B0,
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1)) {
        <br>
        +        trace_pnv_spi_sequencer_stop_requested("N2 counter
        reload "
        <br>
        +                        "active, stop N1 shift, TDR_underrun
        set to 1");
        <br>
        +        stop = true;
        <br>
        +        s-&gt;status = SETFIELD(SPI_STS_TDR_UNDERRUN,
        s-&gt;status, 1);
        <br>
        +    }
        <br>
        +    /*
        <br>
        +     * If send_n1_alone is set AND we have a full TDR then this
        is the first and
        <br>
        +     * last payload to send and we don't have an N2 frame
        segment to add to the
        <br>
        +     * payload.
        <br>
        +     */
        <br>
        +    if (send_n1_alone &amp;&amp; !stop) {
        <br>
        +        /* We have a TX and a full TDR or an RX and an empty
        RDR */
        <br>
        +        trace_pnv_spi_tx_request("Shifting N1 frame",
        (*payload)-&gt;len);
        <br>
        +        transfer(s, *payload);
        <br>
        +        /* The N1 frame shift is complete so reset the N1
        counters */
        <br>
        +        s-&gt;N2_bits = 0;
        <br>
        +        s-&gt;N2_bytes = 0;
        <br>
        +        s-&gt;N2_tx = 0;
        <br>
        +        s-&gt;N2_rx = 0;
        <br>
        +        pnv_spi_xfer_buffer_free(*payload);
        <br>
        +        *payload = NULL;
        <br>
        +    }
        <br>
        +    return stop;
        <br>
        +} /* end of operation_shiftn1() */
        <br>
        +
        <br>
        +/*
        <br>
        + * Calculate the N2 counters based on passed in opcode and
        <br>
        + * internal register values.
        <br>
        + * The method assumes that the opcode is a Shift_N2 opcode
        <br>
        + * and doesn't test it.
        <br>
        + * The counters returned are:
        <br>
        + * N2 bits: Number of bits in the payload data that are
        significant
        <br>
        + * to the responder.
        <br>
        + * N2_bytes: Total count of payload bytes for the N2 frame.
        <br>
        + * N2_tx: Total number of bytes taken from TDR for N2
        <br>
        + * N2_rx: Total number of bytes taken from the payload for N2
        <br>
        + */
        <br>
        +static void calculate_N2(PnvSpi *s, uint8_t opcode)
        <br>
        +{
        <br>
        +    /*
        <br>
        +     * Shift_N2 opcode form: 0x4M
        <br>
        +     * Implicit mode:
        <br>
        +     * If M!=0 the shift count is M bytes and M is the number
        of rx bytes.
        <br>
        +     * Forced Implicit mode:
        <br>
        +     * M is the shift count but tx and rx is determined by the
        count control
        <br>
        +     * register fields.  Note that we only check for Forced
        Implicit mode when
        <br>
        +     * M != 0 since the mode doesn't make sense when M = 0.
        <br>
        +     * Explicit mode:
        <br>
        +     * If M==0 then shift count is number of bits defined in
        the
        <br>
        +     * Counter Configuration Register's shift_count_N1 field.
        <br>
        +     */
        <br>
        +    if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) == 0) {
        <br>
        +        /* Explicit mode */
        <br>
        +        s-&gt;N2_bits = GETFIELD(SPI_CTR_CFG_N2,
        s-&gt;regs[SPI_CTR_CFG_REG]);
        <br>
        +        s-&gt;N2_bytes = (s-&gt;N2_bits + 7) / 8;
        <br>
        +        s-&gt;N2_tx = 0;
        <br>
        +        s-&gt;N2_rx = 0;
        <br>
        +        /* If tx count control for N2 is set, load the tx value
        */
        <br>
        +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
        <br>
        +            s-&gt;N2_tx = s-&gt;N2_bytes;
        <br>
        +        }
        <br>
        +        /* If rx count control for N2 is set, load the rx value
        */
        <br>
        +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
        <br>
        +            s-&gt;N2_rx = s-&gt;N2_bytes;
        <br>
        +        }
        <br>
        +    } else {
        <br>
        +        /* Implicit mode/Forced Implicit mode, use M field from
        opcode */
        <br>
        +        s-&gt;N2_bytes = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
        <br>
        +        s-&gt;N2_bits = s-&gt;N2_bytes * 8;
        <br>
        +        /* Assume that we are going to receive the count */
        <br>
        +        s-&gt;N2_rx = s-&gt;N2_bytes;
        <br>
        +        s-&gt;N2_tx = 0;
        <br>
        +        /* Let Forced Implicit mode have an effect on the
        counts */
        <br>
        +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B1,
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
        <br>
        +            /*
        <br>
        +             * If Forced Implicit mode and count control
        doesn't
        <br>
        +             * indicate a receive then reset the rx count to 0
        <br>
        +             */
        <br>
        +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
        <br>
        +                                   
        s-&gt;regs[SPI_CTR_CFG_REG]) == 0) {
        <br>
        +                s-&gt;N2_rx = 0;
        <br>
        +            }
        <br>
        +            /* If tx count control for N2 is set, load the tx
        value */
        <br>
        +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
        <br>
        +                                   
        s-&gt;regs[SPI_CTR_CFG_REG]) == 1) {
        <br>
        +                s-&gt;N2_tx = s-&gt;N2_bytes;
        <br>
        +            }
        <br>
        +        }
        <br>
        +    }
        <br>
        +    /*
        <br>
        +     * Enforce an upper limit on the size of N1 that is equal
        to the
        <br>
        +     * known size of the shift register, 64 bits or 72 bits if
        ECC
        <br>
        +     * is enabled.
        <br>
        +     * If the size exceeds 72 bits it is a user error so log an
        error,
        <br>
        +     * cap the size at a max of 64 bits or 72 bits and set the
        sequencer FSM
        <br>
        +     * error bit.
        <br>
        +     */
        <br>
        +    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
        <br>
        +                    s-&gt;regs[SPI_CLK_CFG_REG]);
        <br>
        +    if (ecc_control == 0 || ecc_control == 2) {
        <br>
        +        if (s-&gt;N2_bytes &gt; (PNV_SPI_REG_SIZE + 1)) {
        <br>
        +            /* Unsupported N2 shift size when ECC enabled */
        <br>
        +            s-&gt;N2_bytes = PNV_SPI_REG_SIZE + 1;
        <br>
        +            s-&gt;N2_bits = s-&gt;N2_bytes * 8;
        <br>
        +        }
        <br>
        +    } else if (s-&gt;N2_bytes &gt; PNV_SPI_REG_SIZE) {
        <br>
        +        /* Unsupported N2 shift size */
        <br>
        +        s-&gt;N2_bytes = PNV_SPI_REG_SIZE;
        <br>
        +        s-&gt;N2_bits = s-&gt;N2_bytes * 8;
        <br>
        +    }
        <br>
        +} /* end of calculate_N2 */
        <br>
        +
        <br>
        +/*
        <br>
        + * Shift_N2 operation handler method
        <br>
        + */
        <br>
        +
        <br>
        +static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
        <br>
        +                       PnvXferBuffer **payload)
        <br>
        +{
        <br>
        +    uint8_t n2_count;
        <br>
        +    bool stop = false;
        <br>
        +
        <br>
        +    /*
        <br>
        +     * If there isn't a current payload left over from a
        stopped sequence
        <br>
        +     * create a new one.
        <br>
        +     */
        <br>
        +    if (*payload == NULL) {
        <br>
        +        *payload = pnv_spi_xfer_buffer_new();
        <br>
        +    }
        <br>
        +    /*
        <br>
        +     * Use a combination of N2 counters to build the N2 portion
        of the
        <br>
        +     * transmit payload.
        <br>
        +     */
        <br>
        +    calculate_N2(s, opcode);
        <br>
        +    trace_pnv_spi_log_Ncounts(s-&gt;N1_bits, s-&gt;N1_bytes,
        s-&gt;N1_tx,
        <br>
        +                    s-&gt;N1_rx, s-&gt;N2_bits, s-&gt;N2_bytes,
        s-&gt;N2_tx, s-&gt;N2_rx);
        <br>
        +    /*
        <br>
        +     * The only difference between this code and the code for
        shift N1 is
        <br>
        +     * that this code has to account for the possible presence
        of N1 transmit
        <br>
        +     * bytes already taken from the TDR.
        <br>
        +     * If there are bytes to be transmitted for the N2 portion
        of the frame
        <br>
        +     * and there are still bytes in TDR that have not been
        copied into the
        <br>
        +     * TX data of the payload, this code will handle
        transmitting those
        <br>
        +     * remaining bytes.
        <br>
        +     * If for some reason the transmit count(s) add up to more
        than the size
        <br>
        +     * of the TDR we will just append 0xFF to the transmit
        payload data until
        <br>
        +     * the payload is N1 + N2 bytes long.
        <br>
        +     */
        <br>
        +    n2_count = 0;
        <br>
        +    while (n2_count &lt; s-&gt;N2_bytes) {
        <br>
        +        /*
        <br>
        +         * If the RDR is full and we need to RX just bail out,
        letting the
        <br>
        +         * code continue will end up building the payload twice
        in the same
        <br>
        +         * buffer since RDR full causes a sequence stop and
        restart.
        <br>
        +         */
        <br>
        +        if ((s-&gt;N2_rx != 0) &amp;&amp;
        <br>
        +            (GETFIELD(SPI_STS_RDR_FULL, s-&gt;status) == 1)) {
        <br>
        +            trace_pnv_spi_sequencer_stop_requested("shift N2
        set"
        <br>
        +                            "for receive but RDR is full");
        <br>
        +            stop = true;
        <br>
        +            break;
        <br>
        +        }
        <br>
        +        if ((s-&gt;N2_tx != 0) &amp;&amp; ((s-&gt;N1_tx +
        n2_count) &lt;
        <br>
        +                                PNV_SPI_REG_SIZE)) {
        <br>
        +            /* Always append data for the N2 segment if it is
        set for TX */
        <br>
        +            uint8_t n2_byte = 0x00;
        <br>
        +            n2_byte = get_from_offset(s, (s-&gt;N1_tx +
        n2_count));
        <br>
        +            trace_pnv_spi_tx_append("n2_byte", n2_byte,
        (s-&gt;N1_tx + n2_count));
        <br>
        +            *(pnv_spi_xfer_buffer_write_ptr(*payload,
        (*payload)-&gt;len, 1))
        <br>
        +                    = n2_byte;
        <br>
        +        } else {
        <br>
        +            /*
        <br>
        +             * Regardless of whether or not N2 is set for TX or
        RX, we need
        <br>
        +             * the number of bytes in the payload to match the
        overall length
        <br>
        +             * of the operation.
        <br>
        +             */
        <br>
        +            trace_pnv_spi_tx_append_FF("n2_byte");
        <br>
        +            *(pnv_spi_xfer_buffer_write_ptr(*payload,
        (*payload)-&gt;len, 1))
        <br>
        +                    = 0xff;
        <br>
        +        }
        <br>
        +        n2_count++;
        <br>
        +    } /* end of while */
        <br>
        +    if (!stop) {
        <br>
        +        /* We have a TX and a full TDR or an RX and an empty
        RDR */
        <br>
        +        trace_pnv_spi_tx_request("Shifting N2 frame",
        (*payload)-&gt;len);
        <br>
        +        transfer(s, *payload);
        <br>
        +        /*
        <br>
        +         * If we are doing an N2 TX and the TDR is full we need
        to clear the
        <br>
        +         * TDR_full status. Do this here instead of up in the
        loop above so we
        <br>
        +         * don't log the message in every loop iteration.
        <br>
        +         */
        <br>
        +        if ((s-&gt;N2_tx != 0) &amp;&amp;
        <br>
        +            (GETFIELD(SPI_STS_TDR_FULL, s-&gt;status) == 1)) {
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_TDR_FULL,
        s-&gt;status, 0);
        <br>
        +        }
        <br>
        +        /*
        <br>
        +         * The N2 frame shift is complete so reset the N2
        counters.
        <br>
        +         * Reset the N1 counters also in case the frame was a
        combination of
        <br>
        +         * N1 and N2 segments.
        <br>
        +         */
        <br>
        +        s-&gt;N2_bits = 0;
        <br>
        +        s-&gt;N2_bytes = 0;
        <br>
        +        s-&gt;N2_tx = 0;
        <br>
        +        s-&gt;N2_rx = 0;
        <br>
        +        s-&gt;N1_bits = 0;
        <br>
        +        s-&gt;N1_bytes = 0;
        <br>
        +        s-&gt;N1_tx = 0;
        <br>
        +        s-&gt;N1_rx = 0;
        <br>
        +        pnv_spi_xfer_buffer_free(*payload);
        <br>
        +        *payload = NULL;
        <br>
        +    }
        <br>
        +    return stop;
        <br>
        +} /*  end of operation_shiftn2()*/
        <br>
        +
        <br>
        +static void operation_sequencer(PnvSpi *s)
        <br>
        +{
        <br>
        +    /*
        <br>
        +     * Loop through each sequencer operation ID and perform the
        requested
        <br>
        +     *  operations.
        <br>
        +     * Flag for indicating if we should send the N1 frame or
        wait to combine
        <br>
        +     * it with a preceding N2 frame.
        <br>
        +     */
        <br>
        +    bool send_n1_alone = true;
        <br>
        +    bool stop = false; /* Flag to stop the sequencer */
        <br>
        +    uint8_t opcode = 0;
        <br>
        +    uint8_t masked_opcode = 0;
        <br>
        +
        <br>
        +    /*
        <br>
        +     * PnvXferBuffer for containing the payload of the SPI
        frame.
        <br>
        +     * This is a static because there are cases where a
        sequence has to stop
        <br>
        +     * and wait for the target application to unload the RDR. 
        If this occurs
        <br>
        +     * during a sequence where N1 is not sent alone and instead
        combined with
        <br>
        +     * N2 since the N1 tx length + the N2 tx length is less
        than the size of
        <br>
        +     * the TDR.
        <br>
        +     */
        <br>
        +    static PnvXferBuffer *payload;
        <br>
        +
        <br>
        +    if (payload == NULL) {
        <br>
        +        payload = pnv_spi_xfer_buffer_new();
        <br>
        +    }
        <br>
        +    /*
        <br>
        +     * Clear the sequencer FSM error bit -
        general_SPI_status[3]
        <br>
        +     * before starting a sequence.
        <br>
        +     */
        <br>
        +    s-&gt;status = SETFIELD(SPI_STS_GEN_STATUS_B3,
        s-&gt;status, 0);
        <br>
        +    /*
        <br>
        +     * If the FSM is idle set the sequencer index to 0
        <br>
        +     * (new/restarted sequence)
        <br>
        +     */
        <br>
        +    if (GETFIELD(SPI_STS_SEQ_FSM, s-&gt;status) ==
        SEQ_STATE_IDLE) {
        <br>
        +        s-&gt;status = SETFIELD(SPI_STS_SEQ_INDEX,
        s-&gt;status, 0);
        <br>
        +    }
        <br>
        +    /*
        <br>
        +     * There are only 8 possible operation IDs to iterate
        through though
        <br>
        +     * some operations may cause more than one frame to be
        sequenced.
        <br>
        +     */
        <br>
        +    while (get_seq_index(s) &lt; NUM_SEQ_OPS) {
        <br>
        +        opcode = s-&gt;seq_op[get_seq_index(s)];
        <br>
        +        /* Set sequencer state to decode */
        <br>
        +        s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM, s-&gt;status,
        SEQ_STATE_DECODE);
        <br>
        +        /*
        <br>
        +         * Only the upper nibble of the operation ID is needed
        to know what
        <br>
        +         * kind of operation is requested.
        <br>
        +         */
        <br>
        +        masked_opcode = PNV_SPI_MASKED_OPCODE(opcode);
        <br>
        +        switch (masked_opcode) {
        <br>
        +        /*
        <br>
        +         * Increment the operation index in each case instead
        of just
        <br>
        +         * once at the end in case an operation like the branch
        <br>
        +         * operation needs to change the index.
        <br>
        +         */
        <br>
        +        case SEQ_OP_STOP:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            /* A stop operation in any position stops the
        sequencer */
        <br>
        +            trace_pnv_spi_sequencer_op("STOP",
        get_seq_index(s));
        <br>
        +
        <br>
        +            stop = true;
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status, FSM_IDLE);
        <br>
        +            s-&gt;loop_counter_1 = 0;
        <br>
        +            s-&gt;loop_counter_2 = 0;
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_IDLE);
        <br>
        +            break;
        <br>
        +
        <br>
        +        case SEQ_OP_SELECT_SLAVE:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            trace_pnv_spi_sequencer_op("SELECT_SLAVE",
        get_seq_index(s));
        <br>
        +            /*
        <br>
        +             * This device currently only supports a single
        responder
        <br>
        +             * connection at position 0.  De-selecting a
        responder is fine
        <br>
        +             * and expected at the end of a sequence but
        selecting any
        <br>
        +             * responder other than 0 should cause an error.
        <br>
        +             */
        <br>
        +            s-&gt;responder_select =
        PNV_SPI_OPCODE_LO_NIBBLE(opcode);
        <br>
        +            if (s-&gt;responder_select == 0) {
        <br>
        +                trace_pnv_spi_shifter_done();
        <br>
        +                qemu_set_irq(s-&gt;cs_line[0], 1);
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SEQ_INDEX,
        s-&gt;status,
        <br>
        +                                (get_seq_index(s) + 1));
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status, FSM_DONE);
        <br>
        +            } else if (s-&gt;responder_select != 1) {
        <br>
        +                qemu_log_mask(LOG_GUEST_ERROR, "Slave selection
        other than 1 "
        <br>
        +                              "not supported, select = 0x%x\n",
        <br>
        +                               s-&gt;responder_select);
        <br>
        +                trace_pnv_spi_sequencer_stop_requested("invalid
        "
        <br>
        +                                "responder select");
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status, FSM_IDLE);
        <br>
        +                stop = true;
        <br>
        +            } else {
        <br>
        +                /*
        <br>
        +                 * Only allow an FSM_START state when a
        responder is
        <br>
        +                 * selected
        <br>
        +                 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status, FSM_START);
        <br>
        +                trace_pnv_spi_shifter_stating();
        <br>
        +                qemu_set_irq(s-&gt;cs_line[0], 0);
        <br>
        +                /*
        <br>
        +                 * A Shift_N2 operation is only valid after a
        Shift_N1
        <br>
        +                 * according to the spec. The spec doesn't say
        if that means
        <br>
        +                 * immediately after or just after at any
        point. We will track
        <br>
        +                 * the occurrence of a Shift_N1 to enforce this
        requirement in
        <br>
        +                 * the most generic way possible by assuming
        that the rule
        <br>
        +                 * applies once a valid responder select has
        occurred.
        <br>
        +                 */
        <br>
        +                s-&gt;shift_n1_done = false;
        <br>
        +                next_sequencer_fsm(s);
        <br>
        +            }
        <br>
        +            break;
        <br>
        +
        <br>
        +        case SEQ_OP_SHIFT_N1:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            trace_pnv_spi_sequencer_op("SHIFT_N1",
        get_seq_index(s));
        <br>
        +            /*
        <br>
        +             * Only allow a shift_n1 when the state is not IDLE
        or DONE.
        <br>
        +             * In either of those two cases the sequencer is
        not in a proper
        <br>
        +             * state to perform shift operations because the
        sequencer has:
        <br>
        +             * - processed a responder deselect (DONE)
        <br>
        +             * - processed a stop opcode (IDLE)
        <br>
        +             * - encountered an error (IDLE)
        <br>
        +             */
        <br>
        +            if ((GETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status) ==
        FSM_IDLE) ||
        <br>
        +                (GETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status) ==
        FSM_DONE)) {
        <br>
        +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N1 not
        allowed in "
        <br>
        +                              "shifter state = 0x%llx",
        GETFIELD(
        <br>
        +                        SPI_STS_SHIFTER_FSM, s-&gt;status));
        <br>
        +                /*
        <br>
        +                 * Set sequencer FSM error bit 3
        (general_SPI_status[3])
        <br>
        +                 * in status reg.
        <br>
        +                 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_GEN_STATUS_B3,
        s-&gt;status, 1);
        <br>
        +                trace_pnv_spi_sequencer_stop_requested("invalid
        shifter state");
        <br>
        +                stop = true;
        <br>
        +            } else {
        <br>
        +                /*
        <br>
        +                 * Look for the special case where there is a
        shift_n1 set for
        <br>
        +                 * transmit and it is followed by a shift_n2
        set for transmit
        <br>
        +                 * AND the combined transmit length of the two
        operations is
        <br>
        +                 * less than or equal to the size of the TDR
        register. In this
        <br>
        +                 * case we want to use both this current
        shift_n1 opcode and the
        <br>
        +                 * following shift_n2 opcode to assemble the
        frame for
        <br>
        +                 * transmission to the responder without
        requiring a refill of
        <br>
        +                 * the TDR between the two operations.
        <br>
        +                 */
        <br>
        +                if
        (PNV_SPI_MASKED_OPCODE(s-&gt;seq_op[get_seq_index(s) + 1])
        <br>
        +                                == SEQ_OP_SHIFT_N2) {
        <br>
        +                    send_n1_alone = false;
        <br>
        +                }
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status,
        <br>
        +                                FSM_SHIFT_N1);
        <br>
        +                stop = operation_shiftn1(s, opcode,
        &amp;payload, send_n1_alone);
        <br>
        +                if (stop) {
        <br>
        +                    /*
        <br>
        +                     *  The operation code says to stop, this
        can occur if:
        <br>
        +                     * (1) RDR is full and the N1 shift is set
        for receive
        <br>
        +                     * (2) TDR was empty at the time of the N1
        shift so we need
        <br>
        +                     * to wait for data.
        <br>
        +                     * (3) Neither 1 nor 2 are occurring and we
        aren't sending
        <br>
        +                     * N1 alone and N2 counter reload is set
        (bit 0 of the N2
        <br>
        +                     * counter reload field).  In this case
        TDR_underrun will
        <br>
        +                     * will be set and the Payload has been
        loaded so it is
        <br>
        +                     * ok to advance the sequencer.
        <br>
        +                     */
        <br>
        +                    if (GETFIELD(SPI_STS_TDR_UNDERRUN,
        s-&gt;status)) {
        <br>
        +                        s-&gt;shift_n1_done = true;
        <br>
        +                        s-&gt;status =
        SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,
        <br>
        +                                                 
        FSM_SHIFT_N2);
        <br>
        +                        s-&gt;status =
        SETFIELD(SPI_STS_SEQ_INDEX, s-&gt;status,
        <br>
        +                                        (get_seq_index(s) +
        1));
        <br>
        +                    } else {
        <br>
        +                        /*
        <br>
        +                         * This is case (1) or (2) so the
        sequencer needs to
        <br>
        +                         * wait and NOT go to the next sequence
        yet.
        <br>
        +                         */
        <br>
        +                        s-&gt;status =
        SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,
        <br>
        +                                        FSM_WAIT);
        <br>
        +                    }
        <br>
        +                } else {
        <br>
        +                    /* Ok to move on to the next index */
        <br>
        +                    s-&gt;shift_n1_done = true;
        <br>
        +                    next_sequencer_fsm(s);
        <br>
        +                }
        <br>
        +            }
        <br>
        +            break;
        <br>
        +
        <br>
        +        case SEQ_OP_SHIFT_N2:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            trace_pnv_spi_sequencer_op("SHIFT_N2",
        get_seq_index(s));
        <br>
        +            if (!s-&gt;shift_n1_done) {
        <br>
        +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not
        allowed if a "
        <br>
        +                              "Shift_N1 is not done, shifter
        state = 0x%llx",
        <br>
        +                              GETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status));
        <br>
        +                /*
        <br>
        +                 * In case the sequencer actually stops if an
        N2 shift is
        <br>
        +                 * requested before any N1 shift is done. Set
        sequencer FSM
        <br>
        +                 * error bit 3 (general_SPI_status[3]) in
        status reg.
        <br>
        +                 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_GEN_STATUS_B3,
        s-&gt;status, 1);
        <br>
        +               
        trace_pnv_spi_sequencer_stop_requested("shift_n2 "
        <br>
        +                                    "w/no shift_n1 done");
        <br>
        +                stop = true;
        <br>
        +            } else {
        <br>
        +                /* Ok to do a Shift_N2 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status,
        <br>
        +                                FSM_SHIFT_N2);
        <br>
        +                stop = operation_shiftn2(s, opcode,
        &amp;payload);
        <br>
        +                /*
        <br>
        +                 * If the operation code says to stop set the
        shifter state to
        <br>
        +                 * wait and stop
        <br>
        +                 */
        <br>
        +                if (stop) {
        <br>
        +                    s-&gt;status =
        SETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status,
        <br>
        +                                    FSM_WAIT);
        <br>
        +                } else {
        <br>
        +                    /* Ok to move on to the next index */
        <br>
        +                    next_sequencer_fsm(s);
        <br>
        +                }
        <br>
        +            }
        <br>
        +            break;
        <br>
        +
        <br>
        +        case SEQ_OP_BRANCH_IFNEQ_RDR:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR",
        get_seq_index(s));
        <br>
        +            /*
        <br>
        +             * The memory mapping register RDR match value is
        compared against
        <br>
        +             * the 16 rightmost bytes of the RDR (potentially
        with masking).
        <br>
        +             * Since this comparison is performed against the
        contents of the
        <br>
        +             * RDR then a receive must have previously occurred
        otherwise
        <br>
        +             * there is no data to compare and the operation
        cannot be
        <br>
        +             * completed and will stop the sequencer until RDR
        full is set to
        <br>
        +             * 1.
        <br>
        +             */
        <br>
        +            if (GETFIELD(SPI_STS_RDR_FULL, s-&gt;status) == 1)
        {
        <br>
        +                bool rdr_matched = false;
        <br>
        +                rdr_matched = does_rdr_match(s);
        <br>
        +                if (rdr_matched) {
        <br>
        +                    trace_pnv_spi_RDR_match("success");
        <br>
        +                    /* A match occurred, increment the
        sequencer index. */
        <br>
        +                    next_sequencer_fsm(s);
        <br>
        +                } else {
        <br>
        +                    trace_pnv_spi_RDR_match("failed");
        <br>
        +                    /*
        <br>
        +                     * Branch the sequencer to the index coded
        into the op
        <br>
        +                     * code.
        <br>
        +                     */
        <br>
        +                    s-&gt;status = SETFIELD(SPI_STS_SEQ_INDEX,
        s-&gt;status,
        <br>
        +                                   
        PNV_SPI_OPCODE_LO_NIBBLE(opcode));
        <br>
        +                }
        <br>
        +                /*
        <br>
        +                 * Regardless of where the branch ended up we
        want the
        <br>
        +                 * sequencer to continue shifting so we have to
        clear
        <br>
        +                 * RDR_full.
        <br>
        +                 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_RDR_FULL,
        s-&gt;status, 0);
        <br>
        +            } else {
        <br>
        +                trace_pnv_spi_sequencer_stop_requested("RDR
        not"
        <br>
        +                                "full for 0x6x opcode");
        <br>
        +                stop = true;
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status, FSM_WAIT);
        <br>
        +            }
        <br>
        +            break;
        <br>
        +
        <br>
        +        case SEQ_OP_TRANSFER_TDR:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not
        supported\n");
        <br>
        +            next_sequencer_fsm(s);
        <br>
        +            break;
        <br>
        +
        <br>
        +        case SEQ_OP_BRANCH_IFNEQ_INC_1:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1",
        get_seq_index(s));
        <br>
        +            /*
        <br>
        +             * The spec says the loop should execute count
        compare + 1 times.
        <br>
        +             * However we learned from engineering that we
        really only loop
        <br>
        +             * count_compare times, count compare = 0 makes
        this op code a
        <br>
        +             * no-op
        <br>
        +             */
        <br>
        +            if (s-&gt;loop_counter_1 !=
        <br>
        +                GETFIELD(SPI_CTR_CFG_CMP1,
        s-&gt;regs[SPI_CTR_CFG_REG])) {
        <br>
        +                /*
        <br>
        +                 * Next index is the lower nibble of the branch
        operation ID,
        <br>
        +                 * mask off all but the first three bits so we
        don't try to
        <br>
        +                 * access beyond the sequencer_operation_reg
        boundary.
        <br>
        +                 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SEQ_INDEX,
        s-&gt;status,
        <br>
        +                               
        PNV_SPI_OPCODE_LO_NIBBLE(opcode));
        <br>
        +                s-&gt;loop_counter_1++;
        <br>
        +            } else {
        <br>
        +                /* Continue to next index if loop counter is
        reached */
        <br>
        +                next_sequencer_fsm(s);
        <br>
        +            }
        <br>
        +            break;
        <br>
        +
        <br>
        +        case SEQ_OP_BRANCH_IFNEQ_INC_2:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2",
        get_seq_index(s));
        <br>
        +            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2,
        <br>
        +                              s-&gt;regs[SPI_CTR_CFG_REG]);
        <br>
        +            /*
        <br>
        +             * The spec says the loop should execute count
        compare + 1 times.
        <br>
        +             * However we learned from engineering that we
        really only loop
        <br>
        +             * count_compare times, count compare = 0 makes
        this op code a
        <br>
        +             * no-op
        <br>
        +             */
        <br>
        +            if (s-&gt;loop_counter_2 != condition2) {
        <br>
        +                /*
        <br>
        +                 * Next index is the lower nibble of the branch
        operation ID,
        <br>
        +                 * mask off all but the first three bits so we
        don't try to
        <br>
        +                 * access beyond the sequencer_operation_reg
        boundary.
        <br>
        +                 */
        <br>
        +                s-&gt;status = SETFIELD(SPI_STS_SEQ_INDEX,
        <br>
        +                                s-&gt;status,
        PNV_SPI_OPCODE_LO_NIBBLE(opcode));
        <br>
        +                s-&gt;loop_counter_2++;
        <br>
        +            } else {
        <br>
        +                /* Continue to next index if loop counter is
        reached */
        <br>
        +                next_sequencer_fsm(s);
        <br>
        +            }
        <br>
        +            break;
        <br>
        +
        <br>
        +        default:
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_EXECUTE);
        <br>
        +            /* Ignore unsupported operations. */
        <br>
        +            next_sequencer_fsm(s);
        <br>
        +            break;
        <br>
        +        } /* end of switch */
        <br>
        +        /*
        <br>
        +         * If we used all 8 opcodes without seeing a 00 - STOP
        in the sequence
        <br>
        +         * we need to go ahead and end things as if there was a
        STOP at the
        <br>
        +         * end.
        <br>
        +         */
        <br>
        +        if (get_seq_index(s) == NUM_SEQ_OPS) {
        <br>
        +            /* All 8 opcodes completed, sequencer idling */
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SHIFTER_FSM,
        s-&gt;status, FSM_IDLE);
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_INDEX,
        s-&gt;status, 0);
        <br>
        +            s-&gt;loop_counter_1 = 0;
        <br>
        +            s-&gt;loop_counter_2 = 0;
        <br>
        +            s-&gt;status = SETFIELD(SPI_STS_SEQ_FSM,
        s-&gt;status, SEQ_STATE_IDLE);
        <br>
        +            break;
        <br>
        +        }
        <br>
        +        /* Break the loop if a stop was requested */
        <br>
        +        if (stop) {
        <br>
        +            break;
        <br>
        +        }
        <br>
        +    } /* end of while */
        <br>
        +    return;
        <br>
        +} /* end of operation_sequencer() */
        <br>
        +
        <br>
        +/*
        <br>
        + * The SPIC engine and its internal sequencer can be
        interrupted and reset by
        <br>
        + * a hardware signal, the sbe_spicst_hard_reset bits from
        Pervasive
        <br>
        + * Miscellaneous Register of sbe_register_bo device.
        <br>
        + * Reset immediately aborts any SPI transaction in progress and
        returns the
        <br>
        + * sequencer and state machines to idle state.
        <br>
        + * The configuration register values are not changed. The
        status register is
        <br>
        + * not reset. The engine registers are not reset.
        <br>
        + * The SPIC engine reset does not have any affect on the
        attached devices.
        <br>
        + * Reset handling of any attached devices is beyond the scope
        of the engine.
        <br>
        + */
        <br>
        +static void do_reset(DeviceState *dev)
        <br>
        +{
        <br>
        +    PnvSpi *s = PNV_SPI(dev);
        <br>
        +
        <br>
        +    trace_pnv_spi_reset();
        <br>
        +
        <br>
        +    /* Reset all N1 and N2 counters, and other constants */
        <br>
        +    s-&gt;N2_bits = 0;
        <br>
        +    s-&gt;N2_bytes = 0;
        <br>
        +    s-&gt;N2_tx = 0;
        <br>
        +    s-&gt;N2_rx = 0;
        <br>
        +    s-&gt;N1_bits = 0;
        <br>
        +    s-&gt;N1_bytes = 0;
        <br>
        +    s-&gt;N1_tx = 0;
        <br>
        +    s-&gt;N1_rx = 0;
        <br>
        +    s-&gt;loop_counter_1 = 0;
        <br>
        +    s-&gt;loop_counter_2 = 0;
        <br>
        +    /* Disconnected from responder */
        <br>
        +    qemu_set_irq(s-&gt;cs_line[0], 1);
        <br>
        +}
        <br>
        +
        <br>
          static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr,
        unsigned size)
        <br>
          {
        <br>
              PnvSpi *s = PNV_SPI(opaque);
        <br>
        @@ -51,6 +1088,10 @@ static uint64_t pnv_spi_xscom_read(void
        *opaque, hwaddr addr, unsigned size)
        <br>
                  val = s-&gt;regs[reg];
        <br>
                  trace_pnv_spi_read_RDR(val);
        <br>
                  s-&gt;status = SETFIELD(SPI_STS_RDR_FULL,
        s-&gt;status, 0);
        <br>
        +        if (GETFIELD(SPI_STS_SHIFTER_FSM, s-&gt;status) ==
        FSM_WAIT) {
        <br>
        +            trace_pnv_spi_start_sequencer();
        <br>
        +            operation_sequencer(s);
        <br>
        +        }
        <br>
                  break;
        <br>
              case SPI_SEQ_OP_REG:
        <br>
                  val = 0;
        <br>
        @@ -112,6 +1153,8 @@ static void pnv_spi_xscom_write(void
        *opaque, hwaddr addr,
        <br>
                  trace_pnv_spi_write_TDR(val);
        <br>
                  s-&gt;status = SETFIELD(SPI_STS_TDR_FULL,
        s-&gt;status, 1);
        <br>
                  s-&gt;status = SETFIELD(SPI_STS_TDR_UNDERRUN,
        s-&gt;status, 0);
        <br>
        +        trace_pnv_spi_start_sequencer();
        <br>
        +        operation_sequencer(s);
        <br>
                  break;
        <br>
              case SPI_SEQ_OP_REG:
        <br>
                  for (int i = 0; i &lt; PNV_SPI_REG_SIZE; i++) {
        <br>
        @@ -144,6 +1187,7 @@ static const MemoryRegionOps
        pnv_spi_xscom_ops = {
        <br>
            static Property pnv_spi_properties[] = {
        <br>
              DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
        <br>
        +    DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
        <br>
              DEFINE_PROP_END_OF_LIST(),
        <br>
          };
        <br>
          @@ -193,6 +1237,7 @@ static void
        pnv_spi_class_init(ObjectClass *klass, void *data)
        <br>
                dc-&gt;desc = "PowerNV SPI";
        <br>
              dc-&gt;realize = pnv_spi_realize;
        <br>
        +    dc-&gt;reset = do_reset;
        <br>
              device_class_set_props(dc, pnv_spi_properties);
        <br>
          }
        <br>
          diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
        <br>
        index 2cc29e1284..089d269994 100644
        <br>
        --- a/hw/ssi/trace-events
        <br>
        +++ b/hw/ssi/trace-events
        <br>
        @@ -38,3 +38,18 @@ pnv_spi_read(uint64_t addr, uint64_t val)
        "addr 0x%" PRIx64 " val 0x%" PRIx64
        <br>
          pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 "
        val 0x%" PRIx64
        <br>
          pnv_spi_read_RDR(uint64_t val) "data extracted = 0x%" PRIx64
        <br>
          pnv_spi_write_TDR(uint64_t val) "being written, data written =
        0x%" PRIx64
        <br>
        +pnv_spi_start_sequencer(void) ""
        <br>
        +pnv_spi_reset(void) "spic engine sequencer configuration and
        spi communication"
        <br>
        +pnv_spi_sequencer_op(const char* op, uint8_t index) "%s at
        index = 0x%x"
        <br>
        +pnv_spi_shifter_stating(void) "pull CS line low"
        <br>
        +pnv_spi_shifter_done(void) "pull the CS line high"
        <br>
        +pnv_spi_log_Ncounts(uint8_t N1_bits, uint8_t N1_bytes, uint8_t
        N1_tx, uint8_t N1_rx, uint8_t N2_bits, uint8_t N2_bytes, uint8_t
        N2_tx, uint8_t N2_rx) "N1_bits = %d, N1_bytes = %d, N1_tx = %d,
        N1_rx = %d, N2_bits = %d, N2_bytes = %d, N2_tx = %d, N2_rx = %d"
        <br>
        +pnv_spi_tx_append(const char* frame, uint8_t byte, uint8_t
        tdr_index) "%s = 0x%2.2x to payload from TDR at index %d"
        <br>
        +pnv_spi_tx_append_FF(const char* frame) "%s to Payload"
        <br>
        +pnv_spi_tx_request(const char* frame, uint32_t payload_len)
        "%s, payload len = %d"
        <br>
        +pnv_spi_rx_received(uint32_t payload_len) "payload len = %d"
        <br>
        +pnv_spi_rx_read_N1frame(void) ""
        <br>
        +pnv_spi_rx_read_N2frame(void) ""
        <br>
        +pnv_spi_shift_rx(uint8_t byte, uint32_t index) "byte = 0x%2.2x
        into RDR from payload index %d"
        <br>
        +pnv_spi_sequencer_stop_requested(const char* reason) "due to
        %s"
        <br>
        +pnv_spi_RDR_match(const char* result) "%s"
        <br>
        diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
        <br>
        index 833042b74b..8815f67d45 100644
        <br>
        --- a/include/hw/ssi/pnv_spi.h
        <br>
        +++ b/include/hw/ssi/pnv_spi.h
        <br>
        @@ -8,6 +8,14 @@
        <br>
           * This model Supports a connection to a single SPI responder.
        <br>
           * Introduced for P10 to provide access to SPI seeproms, TPM,
        flash device
        <br>
           * and an ADC controller.
        <br>
        + *
        <br>
        + * All SPI function control is mapped into the SPI register
        space to enable
        <br>
        + * full control by firmware.
        <br>
        + *
        <br>
        + * SPI Controller has sequencer and shift engine. The SPI shift
        engine
        <br>
        + * performs serialization and de-serialization according to the
        control by
        <br>
        + * the sequencer and according to the setup defined in the
        configuration
        <br>
        + * registers and the SPI sequencer implements the main control
        logic.
        <br>
           */
        <br>
            #ifndef PPC_PNV_SPI_H
        <br>
        @@ -31,6 +39,25 @@ typedef struct PnvSpi {
        <br>
              MemoryRegion    xscom_spic_regs;
        <br>
              /* SPI object number */
        <br>
              uint32_t        spic_num;
        <br>
        +    uint8_t         transfer_len;
        <br>
        +    uint8_t         responder_select;
        <br>
        +    /* To verify if shift_n1 happens prior to shift_n2 */
        <br>
        +    bool            shift_n1_done;
        <br>
        +    /* Loop counter for branch operation opcode Ex/Fx */
        <br>
        +    uint8_t         loop_counter_1;
        <br>
        +    uint8_t         loop_counter_2;
        <br>
        +    /* N1/N2_bits specifies the size of the N1/N2 segment of a
        frame in bits.*/
        <br>
        +    uint8_t         N1_bits;
        <br>
        +    uint8_t         N2_bits;
        <br>
        +    /* Number of bytes in a payload for the N1/N2 frame
        segment.*/
        <br>
        +    uint8_t         N1_bytes;
        <br>
        +    uint8_t         N2_bytes;
        <br>
        +    /* Number of N1/N2 bytes marked for transmit */
        <br>
        +    uint8_t         N1_tx;
        <br>
        +    uint8_t         N2_tx;
        <br>
        +    /* Number of N1/N2 bytes marked for receive */
        <br>
        +    uint8_t         N1_rx;
        <br>
        +    uint8_t         N2_rx;
        <br>
                /* SPI registers */
        <br>
              uint64_t        regs[PNV_SPI_REGS];
        <br>
        diff --git a/include/hw/ssi/pnv_spi_regs.h
        b/include/hw/ssi/pnv_spi_regs.h
        <br>
        index 5b6ff72d02..596e2c1911 100644
        <br>
        --- a/include/hw/ssi/pnv_spi_regs.h
        <br>
        +++ b/include/hw/ssi/pnv_spi_regs.h
        <br>
        @@ -28,6 +28,17 @@
        <br>
            /* counter_config_reg */
        <br>
          #define SPI_CTR_CFG_REG         0x01
        <br>
        +#define SPI_CTR_CFG_N1          PPC_BITMASK(0, 7)
        <br>
        +#define SPI_CTR_CFG_N2          PPC_BITMASK(8, 15)
        <br>
        +#define SPI_CTR_CFG_CMP1        PPC_BITMASK(24, 31)
        <br>
        +#define SPI_CTR_CFG_CMP2        PPC_BITMASK(32, 39)
        <br>
        +#define SPI_CTR_CFG_N1_CTRL_B1  PPC_BIT(49)
        <br>
        +#define SPI_CTR_CFG_N1_CTRL_B2  PPC_BIT(50)
        <br>
        +#define SPI_CTR_CFG_N1_CTRL_B3  PPC_BIT(51)
        <br>
        +#define SPI_CTR_CFG_N2_CTRL_B0  PPC_BIT(52)
        <br>
        +#define SPI_CTR_CFG_N2_CTRL_B1  PPC_BIT(53)
        <br>
        +#define SPI_CTR_CFG_N2_CTRL_B2  PPC_BIT(54)
        <br>
        +#define SPI_CTR_CFG_N2_CTRL_B3  PPC_BIT(55)
        <br>
            /* config_reg */
        <br>
          #define CONFIG_REG1             0x02
        <br>
        @@ -36,9 +47,13 @@
        <br>
          #define SPI_CLK_CFG_REG         0x03
        <br>
          #define SPI_CLK_CFG_HARD_RST    0x0084000000000000;
        <br>
          #define SPI_CLK_CFG_RST_CTRL    PPC_BITMASK(24, 27)
        <br>
        +#define SPI_CLK_CFG_ECC_EN      PPC_BIT(28)
        <br>
        +#define SPI_CLK_CFG_ECC_CTRL    PPC_BITMASK(29, 30)
        <br>
            /* memory_mapping_reg */
        <br>
          #define SPI_MM_REG              0x04
        <br>
        +#define SPI_MM_RDR_MATCH_VAL    PPC_BITMASK(32, 47)
        <br>
        +#define SPI_MM_RDR_MATCH_MASK   PPC_BITMASK(48, 63)
        <br>
            /* transmit_data_reg */
        <br>
          #define SPI_XMIT_DATA_REG       0x05
        <br>
        @@ -60,8 +75,59 @@
        <br>
          #define SPI_STS_SEQ_FSM         PPC_BITMASK(8, 15)
        <br>
          #define SPI_STS_SHIFTER_FSM     PPC_BITMASK(16, 27)
        <br>
          #define SPI_STS_SEQ_INDEX       PPC_BITMASK(28, 31)
        <br>
        -#define SPI_STS_GEN_STATUS      PPC_BITMASK(32, 63)
        <br>
        +#define SPI_STS_GEN_STATUS_B3   PPC_BIT(35)
        <br>
          #define SPI_STS_RDR             PPC_BITMASK(1, 3)
        <br>
          #define SPI_STS_TDR             PPC_BITMASK(5, 7)
        <br>
          +/*
        <br>
        + * Shifter states
        <br>
        + *
        <br>
        + * These are the same values defined for the Shifter FSM field
        of the
        <br>
        + * status register.  It's a 12 bit field so we will represent
        it as three
        <br>
        + * nibbles in the constants.
        <br>
        + *
        <br>
        + * These are shifter_fsm values
        <br>
        + *
        <br>
        + * Status reg bits 16-27 -&gt; field bits 0-11
        <br>
        + * bits 0,1,2,5 unused/reserved
        <br>
        + * bit 4 crc shift in (unused)
        <br>
        + * bit 8 crc shift out (unused)
        <br>
        + */
        <br>
        +
        <br>
        +#define FSM_DONE                        0x100   /* bit 3 */
        <br>
        +#define FSM_SHIFT_N2                    0x020   /* bit 6 */
        <br>
        +#define FSM_WAIT                        0x010   /* bit 7 */
        <br>
        +#define FSM_SHIFT_N1                    0x004   /* bit 9 */
        <br>
        +#define FSM_START                       0x002   /* bit 10 */
        <br>
        +#define FSM_IDLE                        0x001   /* bit 11 */
        <br>
        +
        <br>
        +/*
        <br>
        + * Sequencer states
        <br>
        + *
        <br>
        + * These are sequencer_fsm values
        <br>
        + *
        <br>
        + * Status reg bits 8-15 -&gt; field bits 0-7
        <br>
        + * bits 0-3 unused/reserved
        <br>
        + *
        <br>
        + */
        <br>
        +#define SEQ_STATE_INDEX_INCREMENT       0x08    /* bit 4 */
        <br>
        +#define SEQ_STATE_EXECUTE               0x04    /* bit 5 */
        <br>
        +#define SEQ_STATE_DECODE                0x02    /* bit 6 */
        <br>
        +#define SEQ_STATE_IDLE                  0x01    /* bit 7 */
        <br>
        +
        <br>
        +/*
        <br>
        + * These are the supported sequencer operations.
        <br>
        + * Only the upper nibble is significant because for many
        operations
        <br>
        + * the lower nibble is a variable specific to the operation.
        <br>
        + */
        <br>
        +#define SEQ_OP_STOP                     0x00
        <br>
        +#define SEQ_OP_SELECT_SLAVE             0x10
        <br>
        +#define SEQ_OP_SHIFT_N1                 0x30
        <br>
        +#define SEQ_OP_SHIFT_N2                 0x40
        <br>
        +#define SEQ_OP_BRANCH_IFNEQ_RDR         0x60
        <br>
        +#define SEQ_OP_TRANSFER_TDR             0xC0
        <br>
        +#define SEQ_OP_BRANCH_IFNEQ_INC_1       0xE0
        <br>
        +#define SEQ_OP_BRANCH_IFNEQ_INC_2       0xF0
        <br>
        +#define NUM_SEQ_OPS                     8
        <br>
        +
        <br>
          #endif
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
--------------AsiX0aWtQ9UPkoQ2ozIemWwV
Content-Type: image/png; name="omEHvb0BVQb7fR5h.png"
Content-Disposition: inline; filename="omEHvb0BVQb7fR5h.png"
Content-Id: <part1.ChV0HYaF.T02xP4Qq@linux.ibm.com>
Content-Transfer-Encoding: base64

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
m8BVIrILXBWQXQAvrHUpb9IVEBRI6aFSwXCvDK3RcGMjz6SAFJACUiBZBQSuktW/HLMLXJVD
1cDGFLgKKyACNql4SIew1qW8EbjKtgYErsK9MgSuwo2NPJMCUkAKSIFkFRC4Slb/cswucFUO
VQMbU+AqrIAI2AhchbUi5U02BQQFUqoIXIV7fWiNhhsbeSYFpIAUkALJKiBwlaz+5Zhd4Koc
qgY2psBVWAERuBK4CmtFyhuBq9xrQOAq3OtD4Crc2MgzKSAFpIAUSFYBgatk9S/H7AJX5VA1
sDGTBle///67HX/88fVUmWeeeax58+a2+OKL27bbbmurrLJKYMqVx52GgqvXX3/d/vOf/zin
NttsM1tjjTXK42CFRo2rw4cffmjXXHNNQa/QpF+/fvbrr7/aiSee6I5fffXV7YADDij42swD
HnzwQRs3bpz7MWO1b98+7xjvv/++XXvtte6YHXbYwTbZZJOcx7/77rt24403pv3+/PPPt5Yt
W6b9bOjQofbTTz/V/YxrZKuttir6XGr1BaWIcz5tioECUV/i6H3QQQdZ165d4xya+DGVAld/
/vmnHXvssVnPl8+KVq1a2fLLL29bbrmlLbvssonrks+B77//3hZeeOGy+1jMGi27M5pAChSh
QPQzM/qypk2b2kILLWSdO3d294XcI1ableOzKfM9pdh7lGrTUP5KgVIoIHBVChXDGkPgKqx4
lMWbpMEVD98LLLBAwXPjQf3cc88teFy1HxAX2GSe54UXXmgnnXSS+/FVV11lgwYNqmop4urw
1FNP2dZbb13wXI855hgbPny4/fjjj+7GFwNkPfTQQwVfm3nAUUcdZVdccYX78TvvvOMAWD57
7LHHbLvttnOHXHLJJTkfwPn9fffdZzvvvHPacE8++WQalJo+fbp7SI/asGHD7Mwzzyz6XGr1
BaWIcz5tioECUV/i6M1Dx/bbbx/n0MSPqRS4+u2332I9pM4333x2+eWX2+GHH564NpkOcN0C
35ZaainnY7mtmDVabl80vhQoRoHoZ2au17Vt29ZuueUW22abbYoZOvFjS/nZlOs9pdh7lMRF
kQNSIAEFBK4SEL3MUwpclVngEIYPCVzNO++8ttxyy9k///xjf/zxh3311VfGN+3e7r//fttx
xx1DkK1sPsQFNpkOCFyZA6Bk6GUzslgAe9w0+mP69u1r9957b9GxLPamsLHgykM37ygZWQce
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
KsgHrt59911bY401bPDgwXb55ZcXPL1FF13U2rZta5MmTXLH/v7773b88cfb999/b7fcckvB
148YMcKOO+44++eff2yppZayWbNmGdBr2WWXtaefftpWXnnlgmPoALOHHnrIgcarrrrKBg0a
FEuSrbfe2po2bWqPPPJIrON1UH0FfvzxR1tooYVsp512cvBVJgWkQPUrIHBV/THMPAOBq9qL
qcBV4DEVuBK4CnyJyr1/FVAZVmoZqFQw3MuhlODq6quvdplR+++/vzvhzz//3JZeemnbc889
7bbbbssrwssvv2w9e/a0Tp062YMPPmirrLKKA1jXXHONgy9du3a1CRMmKBsoxlIqFlyRKQRw
ufTSS+2www6LMYMOyaaAwJXWhRSoPQUErmovpgJXtRdTgavAYypwJXAV+BKVewJXdWtA4Crc
y6GU4CrzLIsBV5RWUa42btw423jjjdOG6tevn8sEeuedd2z11VcPV8xAPCsWXI0dO9a22mor
V5654oorBnIW1eeGwFX1xUweS4FCCghcFVKo+n4vcFV9MSvaY5UKFi1ZWV8gcCVwVdYFpsFL
ooAyrlIyClyVZDmVZZC44IpSMkr5PvvsM+vQoYPLzOnTp0+aT2RG0cvqggsusBdffNGuuOIK
VzK1/PLLW+/evV0mViaU8gNwLFlXN910U71+VkcffbQrVaRccPPNN3cvYf6ff/7ZRo0albf/
1dSpU+3MM8+0vn372s4775zm7x133GFPPvmknXPOObbMMsu4dXrqqac6P+eff367+OKL7cMP
P7Q2bdrYjjvuaEcddZT7ubeBAwe6c+M1UXv77bftsssus7333tu22GIL96tffvnF/ezZZ591
mWhkOKHJkCFDrF27dmmvnzlzptOaY4EhK6ywgg0YMMB23333emvgvffec36+9dZb1qpVKzfn
kksuaf37949dKogPgMGPP/445xr75JNP7PTTT7eDDjrIXnvtNRs9erTz66KLLnJZcthjjz1m
119/vSsVbd68uW244YauVJSsu6ihM6/D5++++86VhQInDznkkDR9445JDInlueeea8OGDbPx
48fbuuuu63qjkenH35lrlbGPPPJIm2eeeerKYP/44w/XG+zee+81+rtR9opfRxxxhLVs2bJe
jNAd0Prbb7+5dUlJLetBpYJleavSoFIgEQUErhKRvayTClyVVd4wBhe4CiMO3guBq5QS0iGs
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
KoWKgY8hcBVWgARsUvGQDmGtS3mTroDAVUoPgatwr4xSgqurr77aWrRoYfvvv7874c8//9yW
Xnpp23PPPe22224rSoSrrrrKjjzySPcagav60mVq/dprr9l6662XBkV41YEHHmg33nijy8Iq
BK4yxywqYHkO/uyzz2yVVVax4cOH26GHHlqqYatunGzgipMg0+2GG26wjz76yFq3bl115yWH
pUAtKyBwVXvRFbiqvZjWOyOBq7CCLGCTiod0CGtdypt0BQSuUnoIXIV7ZZQSXGWeZUPBFSVv
a621lq266qr2zjvvCFzFWD7PPvusbb755nbmmWfasGHD6l5RDLiKMU2DDjn66KPtpptusq+/
/tqaN2/eoDFq4UW5wBW6tG/f3pXlHnfccbVwqjoHKVAzCghc1Uwo605E4Kr2YipwFXhMBWwE
rgJfonLvXwUErgSuQr8Q4oKrrbfe2vXjIXuGzJ3DDjvM+vTpk3Z6gwYNcr2syJB68cUX7Yor
rnAlUZSw0buJTKyNN944rySUF66zzjquJ9O5555r22+/fVZwxfw///yzjRo1ymV5FTIAGOVq
b7/9ts0zzzzWrVs3V35IJhD2ySef2Omnn24HHXSQkb00evRoV8J10UUXWadOney3336z66+/
3u6//3778ssvXSYZvagAQ/PNN1/e6Snju+yyywy4BMyjXAw9hgwZYu3atXOvjZYK7r333nbx
xRfbBx984HpVMc9RRx2VNk9U69NOO81effVVe+aZZ2z11Vd3f9CNGDz66KOuPI/eUssss4yL
SS6LjskxTz/9tN16661Of3wnc4tzZ5yBAwfarrvuWkh2A9YstdRSLusu+rAwdepUB9n69u3r
el9F7Y477rAnn3zSzjnnHDcX4PvUU09164c+XWhDX6g2bdrYjjvu6LSJ9u/CN9Ycr4kasScO
6LvFFlvU/er222835pw2bZorsfTlsfwdtZkzZ7prAC04L9bHgAEDbPfdd6+nA8fi57hx49za
ASpScotf0VJB/0KuJdYo67Bp06YFddUBUkAKVEYBgavK6FzJWQSuKql2QnMp4yoh4XNMK3CV
EkY6hLUu5U26AgJXKT2UcRXulREHXPGAzkP9uuuu60DCc889Z999950DC6ecckrdyUV7JD3+
+ON21llnOQi02GKLuewpskkAFfmMnlj006I/Ew3LAWbZSgWBFrNmzbIffvjBAYx8BpigIThA
gEbzrVq1ckAHOPb888/b+uuv7+br3r270VfrqaeesiZNmhjtVSnfAi5tuummNn78eAe61l57
bffZM2HCBNc4/oEHHnAwLJsxB1ACEAOsQkvgxAsvvGBLLrmkG2eRRRapA1crrbSSK+tbbbXV
nNYAqW+//dbBEeCKt6jWwDN8o58V/a34A1AhBi+99JLLdAIGApDwNZdl9rgiDmRLcY6PPPKI
K0UEEuL7X3/95UCWLwvNNSaZVvTYevjhh9Ni70sbTzjhBJdpFDVAFIANkAOE81Bv2223tSee
eMKtpWWXXdZpQ/wBUfSI8gbEAjoxR9QeeughB/CAV8yBsbbYTIAxiT9rijmIG+t8ww03dMdN
njzZNtpoI2PDgF69etmKK67o5ufnaA3o9Aac5BjivMEGG7g4A7CIM7HNBq6uvfZaV0ZJzLbZ
Zptw3zDkmRSYyxQQuKq9gAtc1V5M652RwFVYQRawScVDOoS1LuVNugICVyk9BK7CvTLigCu8
J1vpiCOOcCfCwzsAiCbslPWRkYRlgo9iSwWBSIxLpgqQC4CUC1wBccjOIpMnX4YKGUIdO3Z0
cAsQ4X197733HKjgdwAfD644DyAEoAsoAagiMwrYceyxx7oMLA+pABY0nScLi8yfbEbWE8CD
7C4giTdgzUknneQyeBjfwxl+f/PNN9ftvEdj+65duzqI980337jm99m09qWCmTCxmFLBXOCK
rC9iQ5YaBrAB9nXp0sV9Bucz4kOsor5zfEPAFa8jA2yvvfZyUwL0AFRoQ5wXX3xx9/O44Ir1
Q4YgIJLrAFgZ9W277bZzwA7jmLfeessefPBBl82GAbfQl/US9WuPPfawO++802Xo8XsMeMjO
mKy7bOAKSMdug8ccc4zrBSaTAlIgDAUErsKIQym9ELgqpZqBjiVwFVZgBGxS8ZAOYa1LeZOu
gMBVSg+Bq3CvjDjgin5TgJ2o8QAPrAG+nH/++e5XjQFXZM4AaMhkAZIAh/KBq7iK+ibv11xz
Tb3G4EAjgAolgh5kAUIoKfMGnACIAMcok5x33nnrfkdGDTvlUeq25ZZbZnWJ7B0yhQA4QC7/
+jlz5rhsLjKsFlhggTpwRVYbYChqAEN2GuTn/D6b1uUEV9myogCAlCD+8ccfeUNBWSlldZTO
Ra0h4KpHjx71sqjIUiJb6eWXX3YwDYsLrn766SenPXASf6KZe2+88YbL6iL2r7/+utN9l112
sbvvvjvtPFi3rHuy0biWGBPQR6YYWXBRo/SSdZINXP36668um61nz54uS04mBaRAGAoIXIUR
h1J6IXBVSjUDHUvgKqzACNik4iEdwlqX8iZdAYGrlB4CV+FeGXHAFZlGl1xySdpJACIoAaR3
Dw/kWGPA1W677ebKpHhPp9QNKwW48llRZFUBxnKZz7jKLPuaPn2660sEpCOzqlijvxVghGsA
CEIpIllk/KF0zJvPuKL0jhK8qJFFRR8reliRtZNN63KCK8rwKMeLGpAIkEY5ZT4DDBFPwGDU
GgKusmlDmR+ZbMBOMtuwuOCKY4GO9GEDGlEOSlwAjQBUbx5+koHFes80enXRbw345LPR6GdF
qWXUPJzKBq44DnDGGgFoyqSAFAhDAYGrMOJQSi8ErkqpZqBjCVyFFRgBm1Q8pENY61LepCsg
cJXSQ+Aq3CsjDri69NJLXa+jqJFpQyPraBZMQ8EV4ACAQAkYZVbegElkQ+2zzz4G2KLvE1kw
xRiw4bHHHnPZUvR4ymUeXB155JFpDcwpD6NMjD5NN9xwQzFT1x3L+qcXGOcJ4MDIKANg0Fwe
3Ty4oun81VdfnTYPTeppNJ4UuLrnnnvqNVAnM4gsp3zgij5YNK7PlimVD1wBfShNzexxlU0b
dCXrLQ648lmC0R5XgEX09Y3nvfD4TCYXGXisQfq1FTLGohyVnmaAxmyvoTSRrCvWQqaxsyCN
3CmBlEkBKRCGAgJXYcShlF4IXJVSzUDHErgKKzACNql4SIew1qW8SVdA4Cqlh8BVuFdGHHDF
g/3QoUPTTuLTTz91mTQ8hJMZhTUUXMUFA0CeQw45pCgx2fkO8MIudH4HQT8AZYC+X5UHV5mZ
MryOxt2Mc9ddd9WbOzpGIceAEuhNo3bGQkMgB43io7sKUhYYtaTB1b333ut2NoxaHHDF8YAa
dmBkh8SoeXCVLZuPnR3pD5UJrg4//HBXMhm1XOAKyEm5X9TotUXJZhRc+d8D4JiP7EHOlzI/
+okRI+Zk0wBAlu9ZlS3WlIG+8sorriE755D5cERPLbLBcmVckZ1G1hW94WRSQAqEoYDAVRhx
KKUXAlelVDPQsQSuwgqMgE0qHtIhrHUpb9IVELhK6SFwFe6VEQdckQ0F/IkavX7IgorT44os
Knb2y2VADZq8Zxowif5ZvB5wQvPqaAlXHFV9mV20ebZ/HTvL0Qid8i56E9GsPRNckVnm4Qs7
wkWNnRXZcZCMsFzZWPQrosE30MWXQDIGPa7IHgNm8O9ygyvKz2hEn89yNWdvDLhaeeWVjQbz
9BKLms9kA0QCJKNGg34yqBoKrgBAwDKgY9TOPvtsGzZsWB24okcZZZD0p9piiy3SjgXIArFY
g/hOCWHm7oW8gKwysuHQFqhFPy90pCwV/6MGSGN3x2zgCqjZvHlz10srs8dZnHWuY6SAFCiP
AgJX5dE1yVEFrpJUv0JzC1xVSOiY0wjYpISSDjEXjA5LRAGBq5TsAleJLL9Yk8YBV5R7URbG
QzcGsCHjptCugjNmzLAllljC9XUiy6hYy9fjCr///PNP69WrV1rD9Mw5gE3Ak86dOxs7/Pm+
UuxER1ZOq1atjD5WgJRs4IrxAFOAL252yaTx5vsrUWZG/6VsdttttzngQYN1yt+8scscvbNW
WGEFB+3KBa5883IynCh/y2flAFf0BqNEL3NXQd8jjfPnc7xly5bONd+ri383FFyx2yEwlHGJ
O0YWE+uX3Qd9xhXlo8sss4yx+QCZUpS+YsAoYBbQiuNZM/jJmsE/wJo3dplkx8hoKanP8rvp
pptsv/32c4cCKMmuo9wzG7hiQwD8yJapVex1o+OlgBQonQICV6XTMpSRBK5CiUQZ/RC4KqO4
DRhawCYlmnRowOLRSyqmgMBVSmqBq4otuaInigOuyAwCPABwAAz05yGmF154obHjnLdM8EEZ
3UILLWSzZ892u6yR4ZQL8GRzPB+4oqRq1qxZxq5u0d3gso1z8cUXOz/pcQVIoaQLEEUmED2J
aOqdq1SQ8QBwQB8AF/ChW7du7vixY8e6TB2gnC85zJyfTJoNN9zQlZ4xD8CPDCsy1r766ivX
8B2fygWuhg8fbscdd5yDL5Q8/uc//7EmTZpkXSflAFfAG6DOAw88YDvssEPavH379nVlkmQr
ATdZU/y/d+/ejcq4oifbMccc49YFOwECjYBngCEyuaKlgr6fFrs79uvXz/XkIq6ApGj23Qsv
vOCyrogn2X+UnQI72TWSnRPRs63OAAAgAElEQVS5joC0GIAL8MX5EFvOj+OAdfxhnsweV74B
PD8HbMmkgBQIQwGBqzDiUEovBK5KqWagYwlchRUYAZtUPKRDWOtS3qQrIHCV0kPgKtwrI98a
nTJlioMOZAsBbej1A8QBgJBlAhSIGg/kwALKr7yxU+AZZ5zhGk5TFhYFXYVUAfYAXcgaijZt
53UAJAAQ45M1VcgefvhhA2ABiDBKsvALkIRNnjzZZbuQLTNo0KB6wwEc2D2OcciWopH27rvv
7krPKPHKZwAy5gaecC34pvZouPHGG7uXeq2BIgCTqAHZrrvuOgPIAF+wTK2BKEOGDHHnEN0B
kBJIGs4DXih5BNRFdzPMFz8gyhVXXGGU2AGTosaaYKdGxs1nrJcll1zSBg4c6HpERY340d+M
MlTWB9lRlN01bdrUQVEy2YBC+bThGMo98RM46o0G9/yZOnWqi9XBBx/s4gV8RV/fs4vsKsbg
QWbatGkOcnXq1Mkdz9qPAkky4yg9HTdunCsJBOjS/J9yWfphRQ0oydpgYwAAK+sMH5kbCJrZ
uJ31TFkpa6vQeiq01vV7KSAFSqeAwFXptAxlJIGrUCJRRj8ErsoobgOGFrBJiSYdGrB49JKK
KSBwlZJa4KpiS67oibRGi5ZMLyhSgX333ddBO6BMixYtinx17R9OOSLZgJSe0ohfJgWkQDgK
CFyFE4tSeSJwVSolAx5H4Cqs4AjYCFyFtSLlTTYFBAUErkK/MrRGQ49Q9ftHLzSymEaPHm0D
Bgyo/hMq8RkAq/gD4KdcUyYFpEA4CghchROLUnkicFUqJQMeR+AqrOAIXAlchbUi5Y3AVe41
oIyrcK8PgatwY1NLnh199NH20EMPuYb+vgl6LZ1fQ8+FHm006adkklJPmRSQAmEpIHAVVjxK
4Y3AVSlUDHwMgauwAiRwJXAV1oqUNwJXAlfVeBUIXFVj1KrP519++cXt6ke/LXqdyVIKAKzo
E0bvsVwN/qWVFJACySkgcJWc9uWaWeCqXMoGNK7AVUDB+NcVgSuBq7BWpLwRuBK4qsarQOCq
GqMmn6WAFJACUqASCghcVULlys4hcFVZvROZTeAqEdlzTipwJXAV1oqUNwJXAlfVeBUIXFVj
1OSzFJACUkAKVEIBgatKqFzZOQSuKqt3IrMJXCUiu8BVAdkF8MJal/ImXQFBgZQe6nEV7pWh
NRpubOSZFJACUkAKJKuAwFWy+pdjdoGrcqga2JgCV2EFRMAmFQ/pENa6lDcCV9nWgMBVuFeG
wFW4sZFnUkAKSAEpkKwCAlfJ6l+O2QWuyqFqYGMKXIUVEAEbgauwVqS8yaaAoEBKFYGrcK+P
fGv0iy++sAsvvNA22WQT22GHHQqexNChQ23BBRe0k08+Oe3Y2bNnu58Xsq+++sqeeuqprIe1
aNHCdt1110JD6Pf/KsD9wXXXXWe77LKL9erVK5YmN998s3Ez/9JLL1mTJk1ivUYHpSvw66+/
2oknnmhrrrmm7bfffpJHCkiBGlBA4KoGgphxCgJXtRfTemckcBVWkAWuBK7CWpHyRuAq9xoQ
uAr3+sgHrt59911bY401bPDgwXb55ZcXPIlFF13U2rZta5MmTXLH/v7773b88cfb999/b7fc
ckvB199444124IEHZj1u8cUXt6+//rrgGDrA7KGHHnKg8aqrrrJBgwbFkmTrrbe2pk2b2iOP
PBLreB1UX4Eff/zRFlpoIdtpp53svvvuk0RSQArUgAICVzUQRIGr2gtioTMSuCqkUGV/L3Al
cFXZFafZGqKAMq5SqglcNWT1VOY1pQRXV199tZEZtf/++zvnP//8c1t66aVtzz33tNtuu63g
CR1xxBE2cuRIly202GKLpR0///zzG3BFVliBYsEVmUIAl0svvdQOO+ywwhPoiKwKCFxpYUiB
2lNA4Kr2YqqMq9qLab0zErgKK8gCVwJXYa1IeZNNAYErgavQr4xSgqvMcy0WXPXs2dMmTJhg
s2bNUrlaIxZOseBq7NixttVWW9mUKVNsxRVXbMTMc/dLBa7m7vjr7GtTAYGr2ourwFXtxVTg
KvCYClwJXAW+ROXevwoIXAlchX4hxAVXZDuNGDHCPvvsM+vQoYPLzOnTp0/a6VGWRi+rCy64
wF588UW74oorXMnU8ssvb71793aZWBtvvHFWSf755x/32rXXXtteeOGFgrIx/88//2yjRo1y
WV65bOrUqXbmmWda3759beedd0477I477rAnn3zSzjnnHFtmmWVcZuCpp57q/CTD6+KLL7YP
P/zQ2rRpYzvuuKMdddRR7ufeBg4c6M6N10Tt7bfftssuu8z23ntv22KLLdyvfvnlF/ezZ599
1mWikeGEJkOGDLF27dqlvX7mzJlOa44Fhqywwgo2YMAA23333eud5nvvvef8fOutt6xVq1Zu
ziWXXNL69+8fu1QQHygR/Pjjj3Pq+Mknn9jpp59uBx10kL322ms2evRo59dFF11knTp1cq97
7LHH7Prrr3elos2bN7cNN9zQlYqSdRc1dOZ1+Pzdd9/ZUkstZf369bNDDjkkTd+4YxJDYnnu
uefasGHDbPz48bbuuuu6nmhk+vF35lpl7COPPNLmmWeeujLYP/74w2X73XvvvUZ/N8pe8YtM
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
z7buuuvaRx995CLPwi0buCLS67vvvrMFCxakpWQSvfWPf/zDRV798MMPseimQaWAFJACdVkB
gau6t7sCV3VvTwWuPN9TARuBK89dVOb9nwICVwJXvp8IUcEVUImUty+//NKAMX379q1KVQvW
SGQPtayuueYaB5pGjRrloo8AKx06dHCRWPvss09WSU4++WQbO3asffrpp9aiRYu0Pr/++qtL
vQvXamJ+AM+tt95asP4V4HTEiBE2ffp0W7x4sW288cbWtWtXVycKUEQLwBWpfURIEekFCCLt
77TTTkur8QWQI8Jp//33txNPPNEuvvhimzZtmr3wwgsuCot/rPOVV15x6//zzz/t6KOPtj33
3NONlathC1pR0wv4hY2PP/54XnDF2AMGDHAaXHvttdWGJtWTlE8g1mqrrea7O8o+KSAFpIBX
CghcebUdJTFG4KokMvo9iCKu/NofgSuBK788UtZkU0DgSuDK9zMjCrgCJH322We2++67W7Nm
zVzKHgDoyiuvdIXEgxaucUUR8SuuuMKl0G2wwQbWsmVLO/fcc61Lly5ZJWnbtq2ry0Th87lz
57oaTqTk7bTTTg7gULsp3EiHW7p0qX3//fcuNS5X++abb2zXXXd10VoHHXSQK5r+9ttvG4XU
+X8ivcLgatttt3U1uvbaay8Hy1599VUXscSN7imnnOL6Zta4IpXxrbfesvfff9+BLv4ddthh
Djqx/r/++stBKyKygFy5WgCuGB+b3333XZdiSapl0LJFXOUaLwBvzZs3dwXj1aSAFJACUqA4
BQSuitOrEnoLXFXCLtXSRoGrWgpY4sMFrlKCSocSO5aGK6kCAlcpOZUqWFK3KulgUcAVE950
003Wv39/NzdwiZpTAB4AELCHllmcvZhUQVIAASxEG5133nmuMHvQiGDibXkbbbRR1e+oAUUU
EVAnXyQR8OzSSy91gApQRWPsgw8+2P2OKCzgWBBxBQQDVgVvFnzzzTcdsNt+++2rCqxnK84e
pApmwrxiUwWJuEJXIBgwb+2113Ypg02bNnW2FwOujjrqKBfx9Z///MdFZalJASkgBaRAcQoI
XBWnVyX0FriqhF2qpY0CV7UUsMSHC9ikBJUOJXYsDVdSBQSuUnIKXJXUrUo6WBRwBUDhDXnh
9thjj7li4Oeff75RHJxWG3AFfCLCiTfkkfJ2zDHHuALjV111lUvbo3D7a6+9VvTaeavhdddd
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
eaSsEbgSuKrEs0DgqhJ3TTZLASkgBaRAORQQuCqHyuWdQ+CqvHonMpvAVSKy55xU4Ergyi+P
lDUCVwJXlXgWCFxV4q7JZikgBaSAFCiHAgJX5VC5vHMIXJVX70RmE7hKRHaBqwKyC+D55Zey
Jl0BQYGUHkoV9PfMkI/6uzeyTApIASkgBZJVQOAqWf3jmF3gKg5VPRtT4MqvDRGwSe2HdPDL
L2WNwFU2HxC48vfMyAeu5s+fb8OHD7d9993XunXrVnARQ4YMsXXWWccuuOCCtL7Lli1zv4/S
5s6daw888IDNmzfPmjVrZkcccYTtsMMOUQ6tVZ/JkyfbhAkTrFevXta6deu8Y3399dc2bNgw
a9++vXXv3r2q74cffmhDhw61Tz75xBo1auReub3ZZptZ1PWfc8459scff9iFF15oG264YVYb
Jk6caM8995z16dPHvXUvW/vrr7+MsTp27GidOnWqlS46WApIASmwIisgcFX3dl/gqu7tabUV
CVz5tckCNgJXfnmkrMmmgKJZUqoIXPl7fuTz0ZkzZ1qbNm3szDPPtBtvvLHgItZff31r3Lix
zZo1y/X97bffbNCgQbZkyRIbN25cweO5mTz99NPtzz//tCZNmtgPP/xgv/zyi5111ll2/fXX
20orrVRwjJp2YH0DBw60hx9+2I488si8w3zwwQcOpp166ql22223ub7Lly93kGrhwoW26aab
2uqrr27vvPOOjR8/3kaOHOm+ZCnU1lhjDacZkPDRRx/N2h2oxZv2nnrqKevcuXPWPpdccokD
aNddd50DWGpSQApIASlQMwUErmqmm89HCVz5vDslsk3gqkRClmgYgauUkNKhRA6lYWJRQOAq
JavAVSzuVZJBSwmuxowZY/Xq1bOePXs627766ivbZJNN7Pjjj7f77rsvr71Tp061du3a2QYb
bOAin/baay/7/fffHXi56aabHDgDoMXVigFXixYtsrvuustFZh1wwAHOpDfeeMP22GMPFyGG
/UHbYostHHxDi0ItAFf0I+rs2GOPrXZIPnAF8CPa7dprr3XHCVwVUlx/lwJSQArkV0Dgqu55
iMBV3dvTaisSuPJrkwVsUvshHfzyS1mTroDAVUoPgSt/z4xSgqvMVRYDrki5I9rpoYceSku/
I+2NqK8vvvjCvvnmGwPuxNGKAVfZ5n/xxRcdxLr88suNiKegFQuuWN/PP/9s6667rn300Ucu
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
wy7EbIPAVcwCFzm8gE1KMOlQpOOoe1kVELhKyS1wVVa3K2qyKOCK6CFS8cLtu+++cymABxxw
gE2aNMn9qS6Bq4MOOsit6/vvv6+W0kf6IGmEuSKu+D3pjkSinXbaadX2gzcsvvXWWy7tcLfd
ditqv9RZCkgBKSAFyqeAwFX5tC7XTAJX5VI6wXkErhIUP8vUAjYCV355pKzJpoDAlcCV72dG
FHB1ww032MCBA9OWQuHx1Vdf3YEXAExdA1e77LKLizL766+/bKWVVkpbO3qQApgLXL366qt5
i9AHg1H4naL3alJACkgBKeCnAgJXfu5LbawSuKqNehVyrMCVXxslcCVw5ZdHyhqBq9w+oIgr
f8+PKODqqquusiFDhqQt4osvvrBNN93UiEx67rnn6hy4orA6ta0WLFhgTZs2TVs7WpAemQtc
vf3227brrrvasccea/fee2/OzafuVSYU89dTZJkUkAJSYMVTQOCq7u25wFXd29NqKxK48muT
Ba4ErvzySFkjcCVwVYlnQRRwddRRR9n48ePTlvfQQw/ZMcccE6nG1XHHHWf3339/UfKUojh7
MRNm1rgaNGiQS4+kltdhhx2WNtQhhxxiREvlAlc//fSTq2/VvHlz++STT2yVVVZJO/7WW2+1
H3/80U455RS9WbCYTVJfKSAFpECZFRC4KrPgZZhO4KoMIic9hcBV0juQPr/AlcCVXx4pawSu
BK4q8SyIAq4oLj516lQXRURbvHixtWvXruBbBRcuXGhNmjSxjh072rPPPluUPKUAVwAkop/W
Xntt23nnnfPOnwmuPvjgA1enijcLTpkypQowvfLKK+6NirR8bxUE6gH3Lr/8crvkkkuq5kbv
Dh06WIsWLWzOnDmKuCrKK9RZCkgBKVBeBQSuyqt3OWYTuCqHygnPIXCV8AZkTC9wJXDll0fK
GoErgatKPAuigCsih7799lvr0aOHewvehAkTXMH94cOH23nnnVe17Mzi7NSHatiwoS1btsxa
t25tAwYMsJ49e0aSqRTgaubMmdamTRtr1aqV8XO+lgmu6MtbBXm7ICmRRxxxhC1atMhFjm28
8cbubYH5wNU333xje+yxh33++efWvn1794+0wwceeMBIEaTwO79TkwJSQApIAX8VELjyd29q
apnAVU2Vq6DjBK782iyBK4ErvzxS1ghcCVxV4lmQD1zNnTvXevXqZf3793egZvTo0UYUVcuW
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
AABJRU5ErkJggg==

--------------AsiX0aWtQ9UPkoQ2ozIemWwV--

--------------Gw0ZGIHxDcROrn20LhK1oi56--


