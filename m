Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D8DC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 19:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s83f3-00088b-Iy; Fri, 17 May 2024 15:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s83f1-00087W-Q7; Fri, 17 May 2024 15:54:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s83ex-0006EO-Dw; Fri, 17 May 2024 15:54:35 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HG1voY015921; Fri, 17 May 2024 19:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=WMBArr9Ce7cQEAVqOtmSTc1EsMGcyeGPnFWSCf5rZ7Q=;
 b=LVhku9fE7JPtHwz+knHs6cNoxZzx45EYGnzGYR5lSkX+25638/DPnq5NoMirEtirVyF2
 s/Z6cH9ARE+t0Dwy+dCm8vnU0g6lPvtl1Nupi6ddc1xAKizCTltcv3XZSWPADYdx5pMd
 lweNOhHoCXeU4iRF+ld25zFw0YNfmXoFcHs5VKtqkMYPDkQO+00MuNkoIPGmqcYcUq8w
 f9xPUJ9Kuq/VSx8iUER2HGZ/+57HVDTMn/tFhS4qjBpX49QNq3ax+PqKVpxOh0jmQ7lX
 DnHlw9pdaZVG6M4eQszuZkRkzjjEwHXrH8D2542Fz2qJWw7TrTOvMzExfKkNdHnWTyZx 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y69f40m0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 19:54:21 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HJsLZY025161;
 Fri, 17 May 2024 19:54:21 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y69f40m0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 19:54:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HJLDFT029636; Fri, 17 May 2024 19:54:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2n7m9mru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 19:54:20 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44HJsElr27066944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 May 2024 19:54:16 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14C7D5803F;
 Fri, 17 May 2024 19:54:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46DD258054;
 Fri, 17 May 2024 19:54:13 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 May 2024 19:54:13 +0000 (GMT)
Message-ID: <2005a4443f8e33d1ee979b25fb886edba85200e5.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/5] ppc/pnv: Extend SPI model
From: Miles Glenn <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: fbarrat@linux.ibm.com, npiggin@gmail.com, clg@kaod.org, calebs@us.ibm.com, 
 chalapathi.v@ibm.com, chalapathi.v@linux.ibm.com,
 saif.abrar@linux.vnet.ibm.com, dantan@us.ibm.com
Date: Fri, 17 May 2024 14:54:12 -0500
In-Reply-To: <20240516163304.25191-3-chalapathi.v@linux.ibm.com>
References: <20240516163304.25191-1-chalapathi.v@linux.ibm.com>
 <20240516163304.25191-3-chalapathi.v@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qMEZKnM2r2US52jUzBsSjEwAW4eoxHKN
X-Proofpoint-ORIG-GUID: W4Y7S-xI4N9issvwdkqrze0GyZ3COkGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_09,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Chalapathi,

I'm having trouble seeing the benefit of breaking this commit out from
patch 1/5.  It seems like the two should be merged into a single commit
responsible for adding the PNV SPI Controller model.

-Glenn


On Thu, 2024-05-16 at 11:33 -0500, Chalapathi V wrote:
> In this commit SPI shift engine and sequencer logic is implemented.
> Shift engine performs serialization and de-serialization according to
> the
> control by the sequencer and according to the setup defined in the
> configuration registers. Sequencer implements the main control logic
> and
> FSM to handle data transmit and data receive control of the shift
> engine.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  include/hw/ssi/pnv_spi.h    |   28 +
>  hw/ppc/pnv_spi_controller.c | 1074
> +++++++++++++++++++++++++++++++++++
>  hw/ppc/trace-events         |   15 +
>  3 files changed, 1117 insertions(+)
> 
> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
> index 244ee1cfc0..6e2bceab3b 100644
> --- a/include/hw/ssi/pnv_spi.h
> +++ b/include/hw/ssi/pnv_spi.h
> @@ -8,6 +8,14 @@
>   * This model Supports a connection to a single SPI responder.
>   * Introduced for P10 to provide access to SPI seeproms, TPM, flash
> device
>   * and an ADC controller.
> + *
> + * All SPI function control is mapped into the SPI register space to
> enable
> + * full control by firmware.
> + *
> + * SPI Controller has sequencer and shift engine. The SPI shift
> engine
> + * performs serialization and de-serialization according to the
> control by
> + * the sequencer and according to the setup defined in the
> configuration
> + * registers and the SPI sequencer implements the main control
> logic.
>   */
>  #include "hw/ssi/ssi.h"
>  
> @@ -29,6 +37,25 @@ typedef struct PnvSpiController {
>      MemoryRegion    xscom_spic_regs;
>      /* SPI controller object number */
>      uint32_t        spic_num;
> +    uint8_t         transfer_len;
> +    uint8_t         responder_select;
> +    /* To verify if shift_n1 happens prior to shift_n2 */
> +    bool            shift_n1_done;
> +    /* Loop counter for branch operation opcode Ex/Fx */
> +    uint8_t         loop_counter_1;
> +    uint8_t         loop_counter_2;
> +    /* N1/N2_bits specifies the size of the N1/N2 segment of a frame
> in bits.*/
> +    uint8_t         N1_bits;
> +    uint8_t         N2_bits;
> +    /* Number of bytes in a payload for the N1/N2 frame segment.*/
> +    uint8_t         N1_bytes;
> +    uint8_t         N2_bytes;
> +    /* Number of N1/N2 bytes marked for transmit */
> +    uint8_t         N1_tx;
> +    uint8_t         N2_tx;
> +    /* Number of N1/N2 bytes marked for receive */
> +    uint8_t         N1_rx;
> +    uint8_t         N2_rx;
>  
>      /* SPI Controller registers */
>      uint64_t        error_reg;
> @@ -40,5 +67,6 @@ typedef struct PnvSpiController {
>      uint64_t        receive_data_reg;
>      uint8_t         sequencer_operation_reg[SPI_CONTROLLER_REG_SIZE]
> ;
>      uint64_t        status_reg;
> +
>  } PnvSpiController;
>  #endif /* PPC_PNV_SPI_CONTROLLER_H */
> diff --git a/hw/ppc/pnv_spi_controller.c
> b/hw/ppc/pnv_spi_controller.c
> index 11b119cf0f..e87f583074 100644
> --- a/hw/ppc/pnv_spi_controller.c
> +++ b/hw/ppc/pnv_spi_controller.c
> @@ -19,6 +19,1072 @@
>  #include "hw/irq.h"
>  #include "trace.h"
>  
> +/* PnvXferBuffer */
> +typedef struct PnvXferBuffer {
> +
> +    uint32_t    len;
> +    uint8_t    *data;
> +
> +} PnvXferBuffer;
> +
> +/* pnv_spi_xfer_buffer_methods */
> +static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
> +{
> +    PnvXferBuffer *payload = g_malloc0(sizeof(*payload));
> +
> +    return payload;
> +}
> +
> +static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
> +{
> +    free(payload->data);
> +    free(payload);
> +}
> +
> +static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer
> *payload,
> +                uint32_t offset, uint32_t length)
> +{
> +    if (payload->len < (offset + length)) {
> +        payload->len = offset + length;
> +        payload->data = g_realloc(payload->data, payload->len);
> +    }
> +    return &payload->data[offset];
> +}
> +
> +static bool does_rdr_match(PnvSpiController *s)
> +{
> +    /*
> +     * According to spec, the mask bits that are 0 are compared and
> the
> +     * bits that are 1 are ignored.
> +     */
> +    uint16_t rdr_match_mask =
> GETFIELD(MEMORY_MAPPING_REG_RDR_MATCH_MASK,
> +                                        s->memory_mapping_reg);
> +    uint16_t rdr_match_val =
> GETFIELD(MEMORY_MAPPING_REG_RDR_MATCH_VAL,
> +                                        s->memory_mapping_reg);
> +
> +    if ((~rdr_match_mask & rdr_match_val) == ((~rdr_match_mask) &
> +            GETFIELD(PPC_BITMASK(48, 63), s->receive_data_reg))) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static uint8_t get_from_offset(PnvSpiController *s, uint8_t offset)
> +{
> +    uint8_t byte;
> +
> +    /*
> +     * Offset is an index between 0 and SPI_CONTROLLER_REG_SIZE - 1
> +     * Check the offset before using it.
> +     */
> +    if (offset < SPI_CONTROLLER_REG_SIZE) {
> +        byte = (s->transmit_data_reg >> (56 - offset * 8)) & 0xFF;
> +    } else {
> +        /*
> +         * Log an error and return a 0xFF since we have to assign
> something
> +         * to byte before returning.
> +         */
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid offset = %d used to
> get byte "
> +                      "from TDR\n", offset);
> +        byte = 0xff;
> +    }
> +    return byte;
> +}
> +
> +static uint8_t read_from_frame(PnvSpiController *s, uint8_t
> *read_buf,
> +                uint8_t nr_bytes, uint8_t ecc_count, uint8_t
> shift_in_count)
> +{
> +    uint8_t byte;
> +    int count = 0;
> +
> +    while (count < nr_bytes) {
> +        shift_in_count++;
> +        if ((ecc_count != 0) &&
> +            (shift_in_count == (SPI_CONTROLLER_REG_SIZE +
> ecc_count))) {
> +            shift_in_count = 0;
> +        } else {
> +            byte = read_buf[count];
> +            trace_pnv_spi_shift_rx(byte, count);
> +            s->receive_data_reg = (s->receive_data_reg << 8) | byte;
> +        }
> +        count++;
> +    } /* end of while */
> +    return shift_in_count;
> +}
> +
> +static void spi_response(PnvSpiController *s, int bits,
> +                PnvXferBuffer *rsp_payload)
> +{
> +    uint8_t ecc_count;
> +    uint8_t shift_in_count;
> +
> +    /*
> +     * Processing here must handle:
> +     * - Which bytes in the payload we should move to the RDR
> +     * - Explicit mode counter configuration settings
> +     * - RDR full and RDR overrun status
> +     */
> +
> +    /*
> +     * First check that the response payload is the exact same
> +     * number of bytes as the request payload was
> +     */
> +    if (rsp_payload->len != (s->N1_bytes + s->N2_bytes)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload
> size in "
> +                       "bytes, expected %d, got %d\n",
> +                       (s->N1_bytes + s->N2_bytes), rsp_payload-
> >len);
> +    } else {
> +        uint8_t ecc_control;
> +        trace_pnv_spi_rx_received(rsp_payload->len);
> +        trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
> +                        s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, 
> s->N2_rx);
> +        /*
> +         * Adding an ECC count let's us know when we have found a
> payload byte
> +         * that was shifted in but cannot be loaded into RDR.  Bits
> 29-30 of
> +         * clock_config_reset_control register equal to either 0b00
> or 0b10
> +         * indicate that we are taking in data with ECC and either
> applying
> +         * the ECC or discarding it.
> +         */
> +        ecc_count = 0;
> +        ecc_control = GETFIELD(PPC_BITMASK(29, 30),
> +                                    s->clock_config_reset_control);
> +        if (ecc_control == 0 || ecc_control == 2) {
> +            ecc_count = 1;
> +        }
> +        /*
> +         * Use the N1_rx and N2_rx counts to control shifting data
> from the
> +         * payload into the RDR.  Keep an overall count of the
> number of bytes
> +         * shifted into RDR so we can discard every 9th byte when
> ECC is
> +         * enabled.
> +         */
> +        shift_in_count = 0;
> +        /* Handle the N1 portion of the frame first */
> +        if (s->N1_rx != 0) {
> +            trace_pnv_spi_rx_read_N1frame();
> +            shift_in_count = read_from_frame(s, &rsp_payload-
> >data[0],
> +                            s->N1_bytes, ecc_count, shift_in_count);
> +        }
> +        /* Handle the N2 portion of the frame */
> +        if (s->N2_rx != 0) {
> +            trace_pnv_spi_rx_read_N2frame();
> +            shift_in_count = read_from_frame(s,
> +                            &rsp_payload->data[s->N1_bytes], s-
> >N2_bytes,
> +                            ecc_count, shift_in_count);
> +        }
> +        if ((s->N1_rx + s->N2_rx) > 0) {
> +            /*
> +             * Data was received so handle RDR status.
> +             * It is easier to handle RDR_full and RDR_overrun
> status here
> +             * since the RDR register's shift_byte_in method is
> called
> +             * multiple times in a row. Controlling RDR status is
> done here
> +             * instead of in the RDR scoped methods for that reason.
> +             */
> +            if (GETFIELD(STATUS_REG_RDR_FULL, s->status_reg) == 1) {
> +                /*
> +                 * Data was shifted into the RDR before having been
> read
> +                 * causing previous data to have been overrun.
> +                 */
> +                s->status_reg = SETFIELD(STATUS_REG_RDR_OVERRUN,
> +                                s->status_reg, 1);
> +            } else {
> +                /*
> +                 * Set status to indicate that the received data
> register is
> +                 * full. This flag is only cleared once the RDR is
> unloaded.
> +                 */
> +                s->status_reg = SETFIELD(STATUS_REG_RDR_FULL,
> +                                s->status_reg, 1);
> +            }
> +        }
> +    } /* end of else */
> +} /* end of spi_response() */
> +
> +static void transfer(PnvSpiController *s, PnvXferBuffer *payload)
> +{
> +    uint32_t tx;
> +    uint32_t rx;
> +    PnvXferBuffer *rsp_payload = NULL;
> +
> +    rsp_payload = pnv_spi_xfer_buffer_new();
> +    for (int offset = 0; offset < payload->len; offset += s-
> >transfer_len) {
> +        tx = 0;
> +        for (int i = 0; i < s->transfer_len; i++) {
> +            if ((offset + i) >= payload->len) {
> +                tx <<= 8;
> +            } else {
> +                tx = (tx << 8) | payload->data[offset + i];
> +            }
> +        }
> +        rx = ssi_transfer(s->ssi_bus, tx);
> +        for (int i = 0; i < s->transfer_len; i++) {
> +            if ((offset + i) >= payload->len) {
> +                break;
> +            }
> +            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload,
> rsp_payload->len, 1)) =
> +                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) &
> 0xFF;
> +        }
> +    }
> +    if (rsp_payload != NULL) {
> +        spi_response(s, s->N1_bits, rsp_payload);
> +    }
> +}
> +
> +static inline uint8_t get_seq_index(PnvSpiController *s)
> +{
> +    return GETFIELD(STATUS_REG_SEQUENCER_INDEX, s->status_reg);
> +}
> +
> +static inline void next_sequencer_fsm(PnvSpiController *s)
> +{
> +    uint8_t seq_index = get_seq_index(s);
> +    s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX, s-
> >status_reg,
> +                              (seq_index + 1));
> +    s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM, s-
> >status_reg,
> +                                      SEQ_STATE_INDEX_INCREMENT);
> +}
> +
> +/*
> + * Calculate the N1 counters based on passed in opcode and
> + * internal register values.
> + * The method assumes that the opcode is a Shift_N1 opcode
> + * and doesn't test it.
> + * The counters returned are:
> + * N1 bits: Number of bits in the payload data that are significant
> + * to the responder.
> + * N1_bytes: Total count of payload bytes for the N1 (portion of
> the) frame.
> + * N1_tx: Total number of bytes taken from TDR for N1
> + * N1_rx: Total number of bytes taken from the payload for N1
> + */
> +static void calculate_N1(PnvSpiController *s, uint8_t opcode)
> +{
> +    /*
> +     * Shift_N1 opcode form: 0x3M
> +     * Implicit mode:
> +     * If M != 0 the shift count is M bytes and M is the number of
> tx bytes.
> +     * Forced Implicit mode:
> +     * M is the shift count but tx and rx is determined by the count
> control
> +     * register fields.  Note that we only check for forced Implicit
> mode when
> +     * M != 0 since the mode doesn't make sense when M = 0.
> +     * Explicit mode:
> +     * If M == 0 then shift count is number of bits defined in the
> +     * Counter Configuration Register's shift_count_N1 field.
> +     */
> +    if (GETFIELD(PPC_BITMASK8(4, 7), opcode) == 0) {
> +        /* Explicit mode */
> +        s->N1_bits = GETFIELD(COUNTER_CONFIG_REG_SHIFT_COUNT_N1,
> +                                       s->counter_config_reg);
> +        s->N1_bytes = ceil(s->N1_bits / 8);
> +        s->N1_tx = 0;
> +        s->N1_rx = 0;
> +        /* If tx count control for N1 is set, load the tx value */
> +        if (GETFIELD(PPC_BIT(50), s->counter_config_reg) == 1) {
> +            s->N1_tx = s->N1_bytes;
> +        }
> +        /* If rx count control for N1 is set, load the rx value */
> +        if (GETFIELD(PPC_BIT(51), s->counter_config_reg) == 1) {
> +            s->N1_rx = s->N1_bytes;
> +        }
> +    } else {
> +        /* Implicit mode/Forced Implicit mode, use M field from
> opcode */
> +        s->N1_bytes = GETFIELD(PPC_BITMASK8(4, 7), opcode);
> +        s->N1_bits = s->N1_bytes * 8;
> +        /*
> +         * Assume that we are going to transmit the count
> +         * (pure Implicit only)
> +         */
> +        s->N1_tx = s->N1_bytes;
> +        s->N1_rx = 0;
> +        /* Let Forced Implicit mode have an effect on the counts */
> +        if (GETFIELD(PPC_BIT(49), s->counter_config_reg) == 1) {
> +            /*
> +             * If Forced Implicit mode and count control doesn't
> +             * indicate transmit then reset the tx count to 0
> +             */
> +            if (GETFIELD(PPC_BIT(50), s->counter_config_reg) == 0) {
> +                s->N1_tx = 0;
> +            }
> +            /* If rx count control for N1 is set, load the rx value
> */
> +            if (GETFIELD(PPC_BIT(51), s->counter_config_reg) == 1) {
> +                s->N1_rx = s->N1_bytes;
> +            }
> +        }
> +    }
> +    /*
> +     * Enforce an upper limit on the size of N1 that is equal to the
> known size
> +     * of the shift register, 64 bits or 72 bits if ECC is enabled.
> +     * If the size exceeds 72 bits it is a user error so log an
> error,
> +     * cap the size at a max of 64 bits or 72 bits and set the
> sequencer FSM
> +     * error bit.
> +     */
> +    uint8_t ecc_control = GETFIELD(PPC_BITMASK(29, 30),
> +                                   s->clock_config_reset_control);
> +    if (ecc_control == 0 || ecc_control == 2) {
> +        if (s->N1_bytes > (SPI_CONTROLLER_REG_SIZE + 1)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift
> size when "
> +                          "ECC enabled, bytes = 0x%x, bits =
> 0x%x\n",
> +                          s->N1_bytes, s->N1_bits);
> +            s->N1_bytes = SPI_CONTROLLER_REG_SIZE + 1;
> +            s->N1_bits = s->N1_bytes * 8;
> +        }
> +    } else if (s->N1_bytes > SPI_CONTROLLER_REG_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
> +                      "bytes = 0x%x, bits = 0x%x\n",
> +                      s->N1_bytes, s->N1_bits);
> +        s->N1_bytes = SPI_CONTROLLER_REG_SIZE;
> +        s->N1_bits = s->N1_bytes * 8;
> +    }
> +} /* end of calculate_N1 */
> +
> +/*
> + * Shift_N1 operation handler method
> + */
> +static bool operation_shiftn1(PnvSpiController *s, uint8_t opcode,
> +                       PnvXferBuffer **payload, bool send_n1_alone)
> +{
> +    uint8_t n1_count;
> +    bool stop = false;
> +
> +    /*
> +     * If there isn't a current payload left over from a stopped
> sequence
> +     * create a new one.
> +     */
> +    if (*payload == NULL) {
> +        *payload = pnv_spi_xfer_buffer_new();
> +    }
> +    /*
> +     * Use a combination of N1 counters to build the N1 portion of
> the
> +     * transmit payload.
> +     * We only care about transmit at this time since the request
> payload
> +     * only represents data going out on the controller output line.
> +     * Leave mode specific considerations in the calculate function
> since
> +     * all we really care about are counters that tell use exactly
> how
> +     * many bytes are in the payload and how many of those bytes to
> +     * include from the TDR into the payload.
> +     */
> +    calculate_N1(s, opcode);
> +    trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
> +                    s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s-
> >N2_rx);
> +    /*
> +     * Zero out the N2 counters here in case there is no N2
> operation following
> +     * the N1 operation in the sequencer.  This keeps leftover N2
> information
> +     * from interfering with spi_response logic.
> +     */
> +    s->N2_bits = 0;
> +    s->N2_bytes = 0;
> +    s->N2_tx = 0;
> +    s->N2_rx = 0;
> +    /*
> +     * N1_bytes is the overall size of the N1 portion of the frame
> regardless of
> +     * whether N1 is used for tx, rx or both.  Loop over the size to
> build a
> +     * payload that is N1_bytes long.
> +     * N1_tx is the count of bytes to take from the TDR and "shift"
> into the
> +     * frame which means append those bytes to the payload for the
> N1 portion
> +     * of the frame.
> +     * If N1_tx is 0 or if the count exceeds the size of the TDR
> append 0xFF to
> +     * the frame until the overall N1 count is reached.
> +     */
> +    n1_count = 0;
> +    while (n1_count < s->N1_bytes) {
> +        /*
> +         * Assuming that if N1_tx is not equal to 0 then it is the
> same as
> +         * N1_bytes.
> +         */
> +        if ((s->N1_tx != 0) && (n1_count < SPI_CONTROLLER_REG_SIZE))
> {
> +
> +            if (GETFIELD(STATUS_REG_TDR_FULL, s->status_reg) == 1) {
> +                /*
> +                 * Note that we are only appending to the payload IF
> the TDR
> +                 * is full otherwise we don't touch the payload
> because we are
> +                 * going to NOT send the payload and instead tell
> the sequencer
> +                 * that called us to stop and wait for a TDR write
> so we have
> +                 * data to load into the payload.
> +                 */
> +                uint8_t n1_byte = 0x00;
> +                n1_byte = get_from_offset(s, n1_count);
> +                trace_pnv_spi_tx_append("n1_byte", n1_byte,
> n1_count);
> +                *(pnv_spi_xfer_buffer_write_ptr(*payload,
> (*payload)->len, 1)) =
> +                        n1_byte;
> +            } else {
> +                /*
> +                 * We hit a shift_n1 opcode TX but the TDR is empty,
> tell the
> +                 * sequencer to stop and break this loop.
> +                 */
> +                trace_pnv_spi_sequencer_stop_requested("Shift N1"
> +                                "set for transmit but TDR is
> empty");
> +                stop = true;
> +                break;
> +            }
> +        } else {
> +            /*
> +             * Cases here:
> +             * - we are receiving during the N1 frame segment and
> the RDR
> +             *   is full so we need to stop until the RDR is read
> +             * - we are transmitting and we don't care about RDR
> status
> +             *   since we won't be loading RDR during the frame
> segment.
> +             * - we are receiving and the RDR is empty so we allow
> the operation
> +             *   to proceed.
> +             */
> +            if ((s->N1_rx != 0) && (GETFIELD(STATUS_REG_RDR_FULL,
> +                                           s->status_reg) == 1)) {
> +                trace_pnv_spi_sequencer_stop_requested("shift N1"
> +                                "set for receive but RDR is full");
> +                stop = true;
> +                break;
> +            } else {
> +                trace_pnv_spi_tx_append_FF("n1_byte");
> +                *(pnv_spi_xfer_buffer_write_ptr(*payload,
> (*payload)->len, 1))
> +                        = 0xff;
> +            }
> +        }
> +        n1_count++;
> +    } /* end of while */
> +    /*
> +     * If we are not stopping due to an empty TDR and we are doing
> an N1 TX
> +     * and the TDR is full we need to clear the TDR_full status.
> +     * Do this here instead of up in the loop above so we don't log
> the message
> +     * in every loop iteration.
> +     * Ignore the send_n1_alone flag, all that does is defer the TX
> until the N2
> +     * operation, which was found immediately after the current
> opcode.  The TDR
> +     * was unloaded and will be shifted so we have to clear the
> TDR_full status.
> +     */
> +    if (!stop && (s->N1_tx != 0) &&
> +        (GETFIELD(STATUS_REG_TDR_FULL, s->status_reg) == 1)) {
> +        s->status_reg = SETFIELD(STATUS_REG_TDR_FULL, s->status_reg, 
> 0);
> +    }
> +    /*
> +     * There are other reasons why the shifter would stop, such as a
> TDR empty
> +     * or RDR full condition with N1 set to receive.  If we haven't
> stopped due
> +     * to either one of those conditions then check if the
> send_n1_alone flag is
> +     * equal to False, indicating the next opcode is an N2
> operation, AND if
> +     * the N2 counter reload switch (bit 0 of the N2 count control
> field) is
> +     * set.  This condition requires a pacing write to "kick" off
> the N2
> +     * shift which includes the N1 shift as well when send_n1_alone
> is False.
> +     */
> +    if (!stop && !send_n1_alone &&
> +       (GETFIELD(PPC_BIT(52), s->counter_config_reg) == 1)) {
> +        trace_pnv_spi_sequencer_stop_requested("N2 counter reload "
> +                        "active, stop N1 shift, TDR_underrun set to
> 1");
> +        stop = true;
> +        s->status_reg = SETFIELD(STATUS_REG_TDR_UNDERRUN, s-
> >status_reg, 1);
> +    }
> +    /*
> +     * If send_n1_alone is set AND we have a full TDR then this is
> the first and
> +     * last payload to send and we don't have an N2 frame segment to
> add to the
> +     * payload.
> +     */
> +    if (send_n1_alone && !stop) {
> +        /* We have a TX and a full TDR or an RX and an empty RDR */
> +        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)-
> >len);
> +        transfer(s, *payload);
> +        /* The N1 frame shift is complete so reset the N1 counters
> */
> +        s->N2_bits = 0;
> +        s->N2_bytes = 0;
> +        s->N2_tx = 0;
> +        s->N2_rx = 0;
> +        pnv_spi_xfer_buffer_free(*payload);
> +        *payload = NULL;
> +    }
> +    return stop;
> +} /* end of operation_shiftn1() */
> +
> +/*
> + * Calculate the N2 counters based on passed in opcode and
> + * internal register values.
> + * The method assumes that the opcode is a Shift_N2 opcode
> + * and doesn't test it.
> + * The counters returned are:
> + * N2 bits: Number of bits in the payload data that are significant
> + * to the responder.
> + * N2_bytes: Total count of payload bytes for the N2 frame.
> + * N2_tx: Total number of bytes taken from TDR for N2
> + * N2_rx: Total number of bytes taken from the payload for N2
> + */
> +static void calculate_N2(PnvSpiController *s, uint8_t opcode)
> +{
> +    /*
> +     * Shift_N2 opcode form: 0x4M
> +     * Implicit mode:
> +     * If M!=0 the shift count is M bytes and M is the number of rx
> bytes.
> +     * Forced Implicit mode:
> +     * M is the shift count but tx and rx is determined by the count
> control
> +     * register fields.  Note that we only check for Forced Implicit
> mode when
> +     * M != 0 since the mode doesn't make sense when M = 0.
> +     * Explicit mode:
> +     * If M==0 then shift count is number of bits defined in the
> +     * Counter Configuration Register's shift_count_N1 field.
> +     */
> +    if (GETFIELD(PPC_BITMASK8(4, 7), opcode) == 0) {
> +        /* Explicit mode */
> +        s->N2_bits = GETFIELD(COUNTER_CONFIG_REG_SHIFT_COUNT_N2,
> +                               s->counter_config_reg);
> +        s->N2_bytes = ceil(s->N2_bits / 8);
> +        s->N2_tx = 0;
> +        s->N2_rx = 0;
> +        /* If tx count control for N2 is set, load the tx value */
> +        if (GETFIELD(PPC_BIT(54), s->counter_config_reg) == 1) {
> +            s->N2_tx = s->N2_bytes;
> +        }
> +        /* If rx count control for N2 is set, load the rx value */
> +        if (GETFIELD(PPC_BIT(55), s->counter_config_reg) == 1) {
> +            s->N2_rx = s->N2_bytes;
> +        }
> +    } else {
> +        /* Implicit mode/Forced Implicit mode, use M field from
> opcode */
> +        s->N2_bytes = GETFIELD(PPC_BITMASK8(4, 7), opcode);
> +        s->N2_bits = s->N2_bytes * 8;
> +        /* Assume that we are going to receive the count */
> +        s->N2_rx = s->N2_bytes;
> +        s->N2_tx = 0;
> +        /* Let Forced Implicit mode have an effect on the counts */
> +        if (GETFIELD(PPC_BIT(53), s->counter_config_reg) == 1) {
> +            /*
> +             * If Forced Implicit mode and count control doesn't
> +             * indicate a receive then reset the rx count to 0
> +             */
> +            if (GETFIELD(PPC_BIT(55), s->counter_config_reg) == 0) {
> +                s->N2_rx = 0;
> +            }
> +            /* If tx count control for N2 is set, load the tx value
> */
> +            if (GETFIELD(PPC_BIT(54), s->counter_config_reg) == 1) {
> +                s->N2_tx = s->N2_bytes;
> +            }
> +        }
> +    }
> +    /*
> +     * Enforce an upper limit on the size of N1 that is equal to the
> +     * known size of the shift register, 64 bits or 72 bits if ECC
> +     * is enabled.
> +     * If the size exceeds 72 bits it is a user error so log an
> error,
> +     * cap the size at a max of 64 bits or 72 bits and set the
> sequencer FSM
> +     * error bit.
> +     */
> +    uint8_t ecc_control = GETFIELD(PPC_BITMASK(29, 30),
> +                                   s->clock_config_reset_control);
> +    if (ecc_control == 0 || ecc_control == 2) {
> +        if (s->N2_bytes > (SPI_CONTROLLER_REG_SIZE + 1)) {
> +            /* Unsupported N2 shift size when ECC enabled */
> +            s->N2_bytes = SPI_CONTROLLER_REG_SIZE + 1;
> +            s->N2_bits = s->N2_bytes * 8;
> +        }
> +    } else if (s->N2_bytes > SPI_CONTROLLER_REG_SIZE) {
> +        /* Unsupported N2 shift size */
> +        s->N2_bytes = SPI_CONTROLLER_REG_SIZE;
> +        s->N2_bits = s->N2_bytes * 8;
> +    }
> +} /* end of calculate_N2 */
> +
> +/*
> + * Shift_N2 operation handler method
> + */
> +
> +static bool operation_shiftn2(PnvSpiController *s, uint8_t opcode,
> +                       PnvXferBuffer **payload)
> +{
> +    uint8_t n2_count;
> +    bool stop = false;
> +
> +    /*
> +     * If there isn't a current payload left over from a stopped
> sequence
> +     * create a new one.
> +     */
> +    if (*payload == NULL) {
> +        *payload = pnv_spi_xfer_buffer_new();
> +    }
> +    /*
> +     * Use a combination of N2 counters to build the N2 portion of
> the
> +     * transmit payload.
> +     */
> +    calculate_N2(s, opcode);
> +    trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
> +                    s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s-
> >N2_rx);
> +    /*
> +     * The only difference between this code and the code for shift
> N1 is
> +     * that this code has to account for the possible presence of N1
> transmit
> +     * bytes already taken from the TDR.
> +     * If there are bytes to be transmitted for the N2 portion of
> the frame
> +     * and there are still bytes in TDR that have not been copied
> into the
> +     * TX data of the payload, this code will handle transmitting
> those
> +     * remaining bytes.
> +     * If for some reason the transmit count(s) add up to more than
> the size
> +     * of the TDR we will just append 0xFF to the transmit payload
> data until
> +     * the payload is N1 + N2 bytes long.
> +     */
> +    n2_count = 0;
> +    while (n2_count < s->N2_bytes) {
> +        /*
> +         * If the RDR is full and we need to RX just bail out,
> letting the
> +         * code continue will end up building the payload twice in
> the same
> +         * buffer since RDR full causes a sequence stop and restart.
> +         */
> +        if ((s->N2_rx != 0) &&
> +            (GETFIELD(STATUS_REG_RDR_FULL, s->status_reg) == 1)) {
> +            trace_pnv_spi_sequencer_stop_requested("shift N2 set"
> +                            "for receive but RDR is full");
> +            stop = true;
> +            break;
> +        }
> +        if ((s->N2_tx != 0) && ((s->N1_tx + n2_count) <
> +                                SPI_CONTROLLER_REG_SIZE)) {
> +            /* Always append data for the N2 segment if it is set
> for TX */
> +            uint8_t n2_byte = 0x00;
> +            n2_byte = get_from_offset(s, (s->N1_tx + n2_count));
> +            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx +
> n2_count));
> +            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)-
> >len, 1))
> +                    = n2_byte;
> +        } else {
> +            /*
> +             * Regardless of whether or not N2 is set for TX or RX,
> we need
> +             * the number of bytes in the payload to match the
> overall length
> +             * of the operation.
> +             */
> +            trace_pnv_spi_tx_append_FF("n2_byte");
> +            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)-
> >len, 1))
> +                    = 0xff;
> +        }
> +        n2_count++;
> +    } /* end of while */
> +    if (!stop) {
> +        /* We have a TX and a full TDR or an RX and an empty RDR */
> +        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)-
> >len);
> +        transfer(s, *payload);
> +        /*
> +         * If we are doing an N2 TX and the TDR is full we need to
> clear the
> +         * TDR_full status. Do this here instead of up in the loop
> above so we
> +         * don't log the message in every loop iteration.
> +         */
> +        if ((s->N2_tx != 0) &&
> +            (GETFIELD(STATUS_REG_TDR_FULL, s->status_reg) == 1)) {
> +            s->status_reg = SETFIELD(STATUS_REG_TDR_FULL, s-
> >status_reg, 0);
> +        }
> +        /*
> +         * The N2 frame shift is complete so reset the N2 counters.
> +         * Reset the N1 counters also in case the frame was a
> combination of
> +         * N1 and N2 segments.
> +         */
> +        s->N2_bits = 0;
> +        s->N2_bytes = 0;
> +        s->N2_tx = 0;
> +        s->N2_rx = 0;
> +        s->N1_bits = 0;
> +        s->N1_bytes = 0;
> +        s->N1_tx = 0;
> +        s->N1_rx = 0;
> +        pnv_spi_xfer_buffer_free(*payload);
> +        *payload = NULL;
> +    }
> +    return stop;
> +} /*  end of operation_shiftn2()*/
> +
> +static void operation_sequencer(PnvSpiController *s)
> +{
> +    /*
> +     * Loop through each sequencer operation ID and perform the
> requested
> +     *  operations.
> +     * Flag for indicating if we should send the N1 frame or wait to
> combine
> +     * it with a preceding N2 frame.
> +     */
> +    bool send_n1_alone = true;
> +    bool stop = false; /* Flag to stop the sequencer */
> +    uint8_t opcode = 0;
> +    uint8_t masked_opcode = 0;
> +
> +    /*
> +     * PnvXferBuffer for containing the payload of the SPI frame.
> +     * This is a static because there are cases where a sequence has
> to stop
> +     * and wait for the target application to unload the RDR.  If
> this occurs
> +     * during a sequence where N1 is not sent alone and instead
> combined with
> +     * N2 since the N1 tx length + the N2 tx length is less than the
> size of
> +     * the TDR.
> +     */
> +    static PnvXferBuffer *payload;
> +
> +    if (payload == NULL) {
> +        payload = pnv_spi_xfer_buffer_new();
> +    }
> +    /*
> +     * Clear the sequencer FSM error bit - general_SPI_status[3]
> +     * before starting a sequence.
> +     */
> +    s->status_reg = SETFIELD(PPC_BIT(35), s->status_reg, 0);
> +    /*
> +     * If the FSM is idle set the sequencer index to 0
> +     * (new/restarted sequence)
> +     */
> +    if (GETFIELD(STATUS_REG_SEQUENCER_FSM, s->status_reg) ==
> +                    SEQ_STATE_IDLE) {
> +        s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                  s->status_reg, 0);
> +    }
> +    /*
> +     * There are only 8 possible operation IDs to iterate through
> though
> +     * some operations may cause more than one frame to be
> sequenced.
> +     */
> +    while (get_seq_index(s) < 8) {
> +        opcode = s->sequencer_operation_reg[get_seq_index(s)];
> +        /* Set sequencer state to decode */
> +        s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM, s-
> >status_reg,
> +                                  SEQ_STATE_DECODE);
> +        /*
> +         * Only the upper nibble of the operation ID is needed to
> know what
> +         * kind of operation is requested.
> +         */
> +        masked_opcode = opcode & 0xF0;
> +        switch (masked_opcode) {
> +        /*
> +         * Increment the operation index in each case instead of
> just
> +         * once at the end in case an operation like the branch
> +         * operation needs to change the index.
> +         */
> +        case SEQ_OP_STOP:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            /* A stop operation in any position stops the sequencer
> */
> +            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
> +
> +            stop = true;
> +            s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM, s-
> >status_reg,
> +                                          FSM_IDLE);
> +            s->loop_counter_1 = 0;
> +            s->loop_counter_2 = 0;
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_IDLE);
> +            break;
> +
> +        case SEQ_OP_SELECT_SLAVE:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("SELECT_SLAVE",
> get_seq_index(s));
> +            /*
> +             * This device currently only supports a single
> responder
> +             * connection at position 0.  De-selecting a responder
> is fine
> +             * and expected at the end of a sequence but selecting
> any
> +             * responder other than 0 should cause an error.
> +             */
> +            s->responder_select = opcode & 0x0F;
> +            if (s->responder_select == 0) {
> +                trace_pnv_spi_shifter_done();
> +                qemu_set_irq(s->cs_line[0], 1);
> +                s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                s->status_reg, (get_seq_index(s) +
> 1));
> +                s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                          s->status_reg, FSM_DONE);
> +            } else if (s->responder_select != 1) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Slave selection
> other than 1 "
> +                              "not supported, select = 0x%x\n",
> +                               s->responder_select);
> +                trace_pnv_spi_sequencer_stop_requested("invalid "
> +                                "responder select");
> +                s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                          s->status_reg, FSM_IDLE);
> +                stop = true;
> +            } else {
> +                /*
> +                 * Only allow an FSM_START state when a responder is
> +                 * selected
> +                 */
> +                s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                          s->status_reg, FSM_START);
> +                trace_pnv_spi_shifter_stating();
> +                qemu_set_irq(s->cs_line[0], 0);
> +                /*
> +                 * A Shift_N2 operation is only valid after a
> Shift_N1
> +                 * according to the spec. The spec doesn't say if
> that means
> +                 * immediately after or just after at any point. We
> will track
> +                 * the occurrence of a Shift_N1 to enforce this
> requirement in
> +                 * the most generic way possible by assuming that
> the rule
> +                 * applies once a valid responder select has
> occurred.
> +                 */
> +                s->shift_n1_done = false;
> +                next_sequencer_fsm(s);
> +            }
> +            break;
> +
> +        case SEQ_OP_SHIFT_N1:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("SHIFT_N1",
> get_seq_index(s));
> +            /*
> +             * Only allow a shift_n1 when the state is not IDLE or
> DONE.
> +             * In either of those two cases the sequencer is not in
> a proper
> +             * state to perform shift operations because the
> sequencer has:
> +             * - processed a responder deselect (DONE)
> +             * - processed a stop opcode (IDLE)
> +             * - encountered an error (IDLE)
> +             */
> +            if ((GETFIELD(STATUS_REG_SHIFTER_FSM,
> +                               s->status_reg) == FSM_IDLE) ||
> +                (GETFIELD(STATUS_REG_SHIFTER_FSM,
> +                               s->status_reg) == FSM_DONE)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N1 not allowed
> in "
> +                              "shifter state = 0x%llx", GETFIELD(
> +                        STATUS_REG_SHIFTER_FSM, s->status_reg));
> +                /*
> +                 * Set sequencer FSM error bit 3
> (general_SPI_status[3])
> +                 * in status reg.
> +                 */
> +                s->status_reg = SETFIELD(PPC_BIT(35), s->status_reg, 
> 1);
> +                trace_pnv_spi_sequencer_stop_requested("invalid
> shifter state");
> +                stop = true;
> +            } else {
> +                /*
> +                 * Look for the special case where there is a
> shift_n1 set for
> +                 * transmit and it is followed by a shift_n2 set for
> transmit
> +                 * AND the combined transmit length of the two
> operations is
> +                 * less than or equal to the size of the TDR
> register. In this
> +                 * case we want to use both this current shift_n1
> opcode and the
> +                 * following shift_n2 opcode to assemble the frame
> for
> +                 * transmission to the responder without requiring a
> refill of
> +                 * the TDR between the two operations.
> +                 */
> +                if ((s->sequencer_operation_reg[get_seq_index(s) +
> 1] & 0xF0)
> +                                == SEQ_OP_SHIFT_N2) {
> +                    send_n1_alone = false;
> +                }
> +                s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                s->status_reg, FSM_SHIFT_N1);
> +                stop = operation_shiftn1(s, opcode, &payload,
> send_n1_alone);
> +                if (stop) {
> +                    /*
> +                     *  The operation code says to stop, this can
> occur if:
> +                     * (1) RDR is full and the N1 shift is set for
> receive
> +                     * (2) TDR was empty at the time of the N1 shift
> so we need
> +                     * to wait for data.
> +                     * (3) Neither 1 nor 2 are occurring and we
> aren't sending
> +                     * N1 alone and N2 counter reload is set (bit 0
> of the N2
> +                     * counter reload field).  In this case
> TDR_underrun will
> +                     * will be set and the Payload has been loaded
> so it is
> +                     * ok to advance the sequencer.
> +                     */
> +                    if (GETFIELD(STATUS_REG_TDR_UNDERRUN, s-
> >status_reg)) {
> +                        s->shift_n1_done = true;
> +                        s->status_reg =
> SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                                  s->status_reg,
> +                                                  FSM_SHIFT_N2);
> +                        s->status_reg =
> SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                        s->status_reg,
> (get_seq_index(s) + 1));
> +                    } else {
> +                        /*
> +                         * This is case (1) or (2) so the sequencer
> needs to
> +                         * wait and NOT go to the next sequence yet.
> +                         */
> +                        s->status_reg =
> SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                                  s->status_reg,
> FSM_WAIT);
> +                    }
> +                } else {
> +                    /* Ok to move on to the next index */
> +                    s->shift_n1_done = true;
> +                    next_sequencer_fsm(s);
> +                }
> +            }
> +            break;
> +
> +        case SEQ_OP_SHIFT_N2:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("SHIFT_N2",
> get_seq_index(s));
> +            if (!s->shift_n1_done) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not
> allowed if a "
> +                              "Shift_N1 is not done, shifter state =
> 0x%llx",
> +                              GETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                       s->status_reg));
> +                /*
> +                 * In case the sequencer actually stops if an N2
> shift is
> +                 * requested before any N1 shift is done. Set
> sequencer FSM
> +                 * error bit 3 (general_SPI_status[3]) in status
> reg.
> +                 */
> +                s->status_reg = SETFIELD(PPC_BIT(35), s->status_reg, 
> 1);
> +                trace_pnv_spi_sequencer_stop_requested("shift_n2 "
> +                                    "w/no shift_n1 done");
> +                stop = true;
> +            } else {
> +                /* Ok to do a Shift_N2 */
> +                s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                          s->status_reg,
> FSM_SHIFT_N2);
> +                stop = operation_shiftn2(s, opcode, &payload);
> +                /*
> +                 * If the operation code says to stop set the
> shifter state to
> +                 * wait and stop
> +                 */
> +                if (stop) {
> +                    s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                              s->status_reg,
> FSM_WAIT);
> +                } else {
> +                    /* Ok to move on to the next index */
> +                    next_sequencer_fsm(s);
> +                }
> +            }
> +            break;
> +
> +        case SEQ_OP_BRANCH_IFNEQ_RDR:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR",
> get_seq_index(s));
> +            /*
> +             * The memory mapping register RDR match value is
> compared against
> +             * the 16 rightmost bytes of the RDR (potentially with
> masking).
> +             * Since this comparison is performed against the
> contents of the
> +             * RDR then a receive must have previously occurred
> otherwise
> +             * there is no data to compare and the operation cannot
> be
> +             * completed and will stop the sequencer until RDR full
> is set to
> +             * 1.
> +             */
> +            if (GETFIELD(STATUS_REG_RDR_FULL, s->status_reg) == 1) {
> +                bool rdr_matched = false;
> +                rdr_matched = does_rdr_match(s);
> +                if (rdr_matched) {
> +                    trace_pnv_spi_RDR_match("success");
> +                    /* A match occurred, increment the sequencer
> index. */
> +                    next_sequencer_fsm(s);
> +                } else {
> +                    trace_pnv_spi_RDR_match("failed");
> +                    /*
> +                     * Branch the sequencer to the index coded into
> the op
> +                     * code.
> +                     */
> +                    s->status_reg =
> SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                              s->status_reg, (opcode
> & 0x7));
> +                }
> +                /*
> +                 * Regardless of where the branch ended up we want
> the
> +                 * sequencer to continue shifting so we have to
> clear
> +                 * RDR_full.
> +                 */
> +                s->status_reg = SETFIELD(STATUS_REG_RDR_FULL,
> +                                s->status_reg, 0);
> +            } else {
> +                trace_pnv_spi_sequencer_stop_requested("RDR not"
> +                                "full for 0x6x opcode");
> +                stop = true;
> +                s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                         s->status_reg, FSM_WAIT);
> +            }
> +            break;
> +
> +        case SEQ_OP_TRANSFER_TDR:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not
> supported\n");
> +            next_sequencer_fsm(s);
> +            break;
> +
> +        case SEQ_OP_BRANCH_IFNEQ_INC_1:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1",
> get_seq_index(s));
> +            /*
> +             * The spec says the loop should execute count compare +
> 1 times.
> +             * However we learned from engineering that we really
> only loop
> +             * count_compare times, count compare = 0 makes this op
> code a
> +             * no-op
> +             */
> +            if (s->loop_counter_1 !=
> +                GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE1,
> +                                s->counter_config_reg)) {
> +                /*
> +                 * Next index is the lower nibble of the branch
> operation ID,
> +                 * mask off all but the first three bits so we don't
> try to
> +                 * access beyond the sequencer_operation_reg
> boundary.
> +                 */
> +                s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                          s->status_reg, (opcode &
> 0x7));
> +                s->loop_counter_1++;
> +            } else {
> +                /* Continue to next index if loop counter is reached
> */
> +                next_sequencer_fsm(s);
> +            }
> +            break;
> +
> +        case SEQ_OP_BRANCH_IFNEQ_INC_2:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2",
> get_seq_index(s));
> +            uint8_t condition2 =
> GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE2,
> +                              s->counter_config_reg);
> +            /*
> +             * The spec says the loop should execute count compare +
> 1 times.
> +             * However we learned from engineering that we really
> only loop
> +             * count_compare times, count compare = 0 makes this op
> code a
> +             * no-op
> +             */
> +            if (s->loop_counter_2 != condition2) {
> +                /*
> +                 * Next index is the lower nibble of the branch
> operation ID,
> +                 * mask off all but the first three bits so we don't
> try to
> +                 * access beyond the sequencer_operation_reg
> boundary.
> +                 */
> +                s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                          s->status_reg,
> +                                          (opcode & 0x7));
> +                s->loop_counter_2++;
> +            } else {
> +                /* Continue to next index if loop counter is reached
> */
> +                next_sequencer_fsm(s);
> +            }
> +            break;
> +
> +        default:
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_EXECUTE);
> +            /* Ignore unsupported operations. */
> +            next_sequencer_fsm(s);
> +            break;
> +        } /* end of switch */
> +        /*
> +         * If we used all 8 opcodes without seeing a 00 - STOP in
> the sequence
> +         * we need to go ahead and end things as if there was a STOP
> at the
> +         * end.
> +         */
> +        if (get_seq_index(s) == 8) {
> +            /* All 8 opcodes completed, sequencer idling */
> +            s->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM, s-
> >status_reg,
> +                                      FSM_IDLE);
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                      s->status_reg, 0);
> +            s->loop_counter_1 = 0;
> +            s->loop_counter_2 = 0;
> +            s->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      s->status_reg,
> SEQ_STATE_IDLE);
> +            break;
> +        }
> +        /* Break the loop if a stop was requested */
> +        if (stop) {
> +            break;
> +        }
> +    } /* end of while */
> +    return;
> +} /* end of operation_sequencer() */
> +
> +/*
> + * The SPIC engine and its internal sequencer can be interrupted and
> reset by
> + * a hardware signal, the sbe_spicst_hard_reset bits from Pervasive
> + * Miscellaneous Register of sbe_register_bo device.
> + * Reset immediately aborts any SPI transaction in progress and
> returns the
> + * sequencer and state machines to idle state.
> + * The configuration register values are not changed. The status
> register is
> + * not reset. The engine registers are not reset.
> + * The SPIC engine reset does not have any affect on the attached
> devices.
> + * Reset handling of any attached devices is beyond the scope of the
> engine.
> + */
> +static void do_reset(DeviceState *dev)
> +{
> +    PnvSpiController *s = PNV_SPICONTROLLER(dev);
> +
> +    trace_pnv_spi_reset();
> +
> +    /* Reset all N1 and N2 counters, and other constants */
> +    s->N2_bits = 0;
> +    s->N2_bytes = 0;
> +    s->N2_tx = 0;
> +    s->N2_rx = 0;
> +    s->N1_bits = 0;
> +    s->N1_bytes = 0;
> +    s->N1_tx = 0;
> +    s->N1_rx = 0;
> +    s->loop_counter_1 = 0;
> +    s->loop_counter_2 = 0;
> +    /* Disconnected from responder */
> +    qemu_set_irq(s->cs_line[0], 1);
> +}
> +
>  static uint64_t pnv_spi_controller_read(void *opaque, hwaddr addr,
>                                   unsigned size)
>  {
> @@ -49,6 +1115,10 @@ static uint64_t pnv_spi_controller_read(void
> *opaque, hwaddr addr,
>          val = s->receive_data_reg;
>          trace_pnv_spi_read_RDR(val);
>          s->status_reg = SETFIELD(STATUS_REG_RDR_FULL, s->status_reg, 
> 0);
> +        if (GETFIELD(STATUS_REG_SHIFTER_FSM, s->status_reg) ==
> FSM_WAIT) {
> +            trace_pnv_spi_start_sequencer();
> +            operation_sequencer(s);
> +        }
>          break;
>      case SEQUENCER_OPERATION_REG:
>          val = 0;
> @@ -120,6 +1190,8 @@ static void pnv_spi_controller_write(void
> *opaque, hwaddr addr,
>          trace_pnv_spi_write_TDR(val);
>          s->status_reg = SETFIELD(STATUS_REG_TDR_FULL, s->status_reg, 
> 1);
>          s->status_reg = SETFIELD(STATUS_REG_TDR_UNDERRUN, s-
> >status_reg, 0);
> +        trace_pnv_spi_start_sequencer();
> +        operation_sequencer(s);
>          break;
>      case RECEIVE_DATA_REG:
>          s->receive_data_reg = val;
> @@ -155,6 +1227,7 @@ static const MemoryRegionOps
> pnv_spi_controller_xscom_ops = {
>  
>  static Property pnv_spi_controller_properties[] = {
>      DEFINE_PROP_UINT32("spic_num", PnvSpiController, spic_num, 0),
> +    DEFINE_PROP_UINT8("transfer_len", PnvSpiController,
> transfer_len, 4),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -206,6 +1279,7 @@ static void
> pnv_spi_controller_class_init(ObjectClass *klass, void *data)
>  
>      dc->desc = "PowerNV SPI Controller";
>      dc->realize = pnv_spi_controller_realize;
> +    dc->reset = do_reset;
>      device_class_set_props(dc, pnv_spi_controller_properties);
>  }
>  
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index b8e494ffc5..4b08311160 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -115,6 +115,21 @@ pnv_spi_read(uint64_t addr, uint64_t val) "addr
> 0x%" PRIx64 " val 0x%" PRIx64
>  pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val
> 0x%" PRIx64
>  pnv_spi_read_RDR(uint64_t val) "data extracted = 0x%" PRIx64
>  pnv_spi_write_TDR(uint64_t val) "being written, data written = 0x%"
> PRIx64
> +pnv_spi_start_sequencer(void) ""
> +pnv_spi_reset(void) "spic engine sequencer configuration and spi
> communication"
> +pnv_spi_sequencer_op(const char* op, uint8_t index) "%s at index =
> 0x%x"
> +pnv_spi_shifter_stating(void) "pull CS line low"
> +pnv_spi_shifter_done(void) "pull the CS line high"
> +pnv_spi_log_Ncounts(uint8_t N1_bits, uint8_t N1_bytes, uint8_t
> N1_tx, uint8_t N1_rx, uint8_t N2_bits, uint8_t N2_bytes, uint8_t
> N2_tx, uint8_t N2_rx) "N1_bits = %d, N1_bytes = %d, N1_tx = %d, N1_rx
> = %d, N2_bits = %d, N2_bytes = %d, N2_tx = %d, N2_rx = %d"
> +pnv_spi_tx_append(const char* frame, uint8_t byte, uint8_t
> tdr_index) "%s = 0x%2.2x to payload from TDR at index %d"
> +pnv_spi_tx_append_FF(const char* frame) "%s to Payload"
> +pnv_spi_tx_request(const char* frame, uint32_t payload_len) "%s,
> payload len = %d"
> +pnv_spi_rx_received(uint32_t payload_len) "payload len = %d"
> +pnv_spi_rx_read_N1frame(void) ""
> +pnv_spi_rx_read_N2frame(void) ""
> +pnv_spi_shift_rx(uint8_t byte, uint32_t index) "byte = 0x%2.2x into
> RDR from payload index %d"
> +pnv_spi_sequencer_stop_requested(const char* reason) "due to %s"
> +pnv_spi_RDR_match(const char* result) "%s"
>  
>  # ppc.c
>  ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t diff, int64_t
> seconds) "adjusted from 0x%"PRIx64" to 0x%"PRIx64", diff %"PRId64"
> (%"PRId64"s)"


