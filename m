Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2722C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 10:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYNgf-0001cD-8f; Mon, 29 Jul 2024 06:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=joD8=O5=kaod.org=clg@ozlabs.org>)
 id 1sYNgU-0001a2-O1; Mon, 29 Jul 2024 06:32:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=joD8=O5=kaod.org=clg@ozlabs.org>)
 id 1sYNgO-0003nJ-UZ; Mon, 29 Jul 2024 06:32:54 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WXZSC70XKz4w2M;
 Mon, 29 Jul 2024 20:32:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WXZS92C6Rz4x7H;
 Mon, 29 Jul 2024 20:32:41 +1000 (AEST)
Message-ID: <8d93da65-36a9-4642-9345-1b698191ba49@kaod.org>
Date: Mon, 29 Jul 2024 12:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 38/96] hw/ssi: Extend SPI model
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-39-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240725235410.451624-39-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=joD8=O5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/26/24 01:53, Nicholas Piggin wrote:
> From: Chalapathi V <chalapathi.v@linux.ibm.com>
> 
> In this commit SPI shift engine and sequencer logic is implemented.
> Shift engine performs serialization and de-serialization according to the
> control by the sequencer and according to the setup defined in the
> configuration registers. Sequencer implements the main control logic and
> FSM to handle data transmit and data receive control of the shift engine.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ssi/pnv_spi.c              | 1045 +++++++++++++++++++++++++++++++++
>   hw/ssi/trace-events           |   15 +
>   include/hw/ssi/pnv_spi.h      |   27 +
>   include/hw/ssi/pnv_spi_regs.h |   68 ++-
>   4 files changed, 1154 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index 468afdad07..cdff3f9621 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -17,6 +17,9 @@
>   #include "hw/irq.h"
>   #include "trace.h"
>   
> +#define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
> +#define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
> +
>   /*
>    * Macro from include/hw/ppc/fdt.h
>    * fdt.h cannot be included here as it contain ppc target specific dependency.
> @@ -32,6 +35,1040 @@
>           }                                                          \
>       } while (0)
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
> +static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
> +                uint32_t offset, uint32_t length)
> +{
> +    if (payload->len < (offset + length)) {
> +        payload->len = offset + length;
> +        payload->data = g_realloc(payload->data, payload->len);
> +    }
> +    return &payload->data[offset];
> +}
> +
> +static bool does_rdr_match(PnvSpi *s)
> +{
> +    /*
> +     * According to spec, the mask bits that are 0 are compared and the
> +     * bits that are 1 are ignored.
> +     */
> +    uint16_t rdr_match_mask = GETFIELD(SPI_MM_RDR_MATCH_MASK,
> +                                        s->regs[SPI_MM_REG]);
> +    uint16_t rdr_match_val = GETFIELD(SPI_MM_RDR_MATCH_VAL,
> +                                        s->regs[SPI_MM_REG]);
> +
> +    if ((~rdr_match_mask & rdr_match_val) == ((~rdr_match_mask) &
> +            GETFIELD(PPC_BITMASK(48, 63), s->regs[SPI_RCV_DATA_REG]))) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static uint8_t get_from_offset(PnvSpi *s, uint8_t offset)
> +{
> +    uint8_t byte;
> +
> +    /*
> +     * Offset is an index between 0 and PNV_SPI_REG_SIZE - 1
> +     * Check the offset before using it.
> +     */
> +    if (offset < PNV_SPI_REG_SIZE) {
> +        byte = (s->regs[SPI_XMIT_DATA_REG] >> (56 - offset * 8)) & 0xFF;
> +    } else {
> +        /*
> +         * Log an error and return a 0xFF since we have to assign something
> +         * to byte before returning.
> +         */
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid offset = %d used to get byte "
> +                      "from TDR\n", offset);
> +        byte = 0xff;
> +    }
> +    return byte;
> +}
> +
> +static uint8_t read_from_frame(PnvSpi *s, uint8_t *read_buf, uint8_t nr_bytes,
> +                uint8_t ecc_count, uint8_t shift_in_count)
> +{
> +    uint8_t byte;
> +    int count = 0;
> +
> +    while (count < nr_bytes) {
> +        shift_in_count++;
> +        if ((ecc_count != 0) &&
> +            (shift_in_count == (PNV_SPI_REG_SIZE + ecc_count))) {
> +            shift_in_count = 0;
> +        } else {
> +            byte = read_buf[count];
> +            trace_pnv_spi_shift_rx(byte, count);
> +            s->regs[SPI_RCV_DATA_REG] = (s->regs[SPI_RCV_DATA_REG] << 8) | byte;
> +        }
> +        count++;
> +    } /* end of while */
> +    return shift_in_count;
> +}
> +
> +static void spi_response(PnvSpi *s, int bits, PnvXferBuffer *rsp_payload)
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
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in "
> +                       "bytes, expected %d, got %d\n",
> +                       (s->N1_bytes + s->N2_bytes), rsp_payload->len);
> +    } else {
> +        uint8_t ecc_control;
> +        trace_pnv_spi_rx_received(rsp_payload->len);
> +        trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
> +                        s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2_rx);
> +        /*
> +         * Adding an ECC count let's us know when we have found a payload byte
> +         * that was shifted in but cannot be loaded into RDR.  Bits 29-30 of
> +         * clock_config_reset_control register equal to either 0b00 or 0b10
> +         * indicate that we are taking in data with ECC and either applying
> +         * the ECC or discarding it.
> +         */
> +        ecc_count = 0;
> +        ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL, s->regs[SPI_CLK_CFG_REG]);
> +        if (ecc_control == 0 || ecc_control == 2) {
> +            ecc_count = 1;
> +        }
> +        /*
> +         * Use the N1_rx and N2_rx counts to control shifting data from the
> +         * payload into the RDR.  Keep an overall count of the number of bytes
> +         * shifted into RDR so we can discard every 9th byte when ECC is
> +         * enabled.
> +         */
> +        shift_in_count = 0;
> +        /* Handle the N1 portion of the frame first */
> +        if (s->N1_rx != 0) {
> +            trace_pnv_spi_rx_read_N1frame();
> +            shift_in_count = read_from_frame(s, &rsp_payload->data[0],
> +                            s->N1_bytes, ecc_count, shift_in_count);
> +        }
> +        /* Handle the N2 portion of the frame */
> +        if (s->N2_rx != 0) {
> +            trace_pnv_spi_rx_read_N2frame();
> +            shift_in_count = read_from_frame(s,
> +                            &rsp_payload->data[s->N1_bytes], s->N2_bytes,
> +                            ecc_count, shift_in_count);
> +        }
> +        if ((s->N1_rx + s->N2_rx) > 0) {
> +            /*
> +             * Data was received so handle RDR status.
> +             * It is easier to handle RDR_full and RDR_overrun status here
> +             * since the RDR register's shift_byte_in method is called
> +             * multiple times in a row. Controlling RDR status is done here
> +             * instead of in the RDR scoped methods for that reason.
> +             */
> +            if (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1) {
> +                /*
> +                 * Data was shifted into the RDR before having been read
> +                 * causing previous data to have been overrun.
> +                 */
> +                s->status = SETFIELD(SPI_STS_RDR_OVERRUN, s->status, 1);
> +            } else {
> +                /*
> +                 * Set status to indicate that the received data register is
> +                 * full. This flag is only cleared once the RDR is unloaded.
> +                 */
> +                s->status = SETFIELD(SPI_STS_RDR_FULL, s->status, 1);
> +            }
> +        }
> +    } /* end of else */
> +} /* end of spi_response() */
> +
> +static void transfer(PnvSpi *s, PnvXferBuffer *payload)
> +{
> +    uint32_t tx;
> +    uint32_t rx;
> +    PnvXferBuffer *rsp_payload = NULL;
> +
> +    rsp_payload = pnv_spi_xfer_buffer_new();
> +    for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
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
> +            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, rsp_payload->len, 1)) =
> +                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
> +        }
> +    }
> +    if (rsp_payload != NULL) {
> +        spi_response(s, s->N1_bits, rsp_payload);
> +    }
> +}
> +
> +static inline uint8_t get_seq_index(PnvSpi *s)
> +{
> +    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
> +}

Coverity reports :

>>>     CID 1558827:    (OVERRUN)
>>>     Overrunning array "s->seq_op" of 8 bytes at byte offset 16 using index "get_seq_index(s) + 1" (which evaluates to 16).


get_seq_index() can return a value between 0 and 15 and it is used in a couple
of places to index array s->seq_op[] which is an 8 bytes array.

Should we increase the size of the seq_op array ?

Thanks,

C.



> +static inline void next_sequencer_fsm(PnvSpi *s)
> +{
> +    uint8_t seq_index = get_seq_index(s);
> +    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, (seq_index + 1));
> +    s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_INCREMENT);
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
> + * N1_bytes: Total count of payload bytes for the N1 (portion of the) frame.
> + * N1_tx: Total number of bytes taken from TDR for N1
> + * N1_rx: Total number of bytes taken from the payload for N1
> + */
> +static void calculate_N1(PnvSpi *s, uint8_t opcode)
> +{
> +    /*
> +     * Shift_N1 opcode form: 0x3M
> +     * Implicit mode:
> +     * If M != 0 the shift count is M bytes and M is the number of tx bytes.
> +     * Forced Implicit mode:
> +     * M is the shift count but tx and rx is determined by the count control
> +     * register fields.  Note that we only check for forced Implicit mode when
> +     * M != 0 since the mode doesn't make sense when M = 0.
> +     * Explicit mode:
> +     * If M == 0 then shift count is number of bits defined in the
> +     * Counter Configuration Register's shift_count_N1 field.
> +     */
> +    if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) == 0) {
> +        /* Explicit mode */
> +        s->N1_bits = GETFIELD(SPI_CTR_CFG_N1, s->regs[SPI_CTR_CFG_REG]);
> +        s->N1_bytes = (s->N1_bits + 7) / 8;
> +        s->N1_tx = 0;
> +        s->N1_rx = 0;
> +        /* If tx count control for N1 is set, load the tx value */
> +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2, s->regs[SPI_CTR_CFG_REG]) == 1) {
> +            s->N1_tx = s->N1_bytes;
> +        }
> +        /* If rx count control for N1 is set, load the rx value */
> +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3, s->regs[SPI_CTR_CFG_REG]) == 1) {
> +            s->N1_rx = s->N1_bytes;
> +        }
> +    } else {
> +        /* Implicit mode/Forced Implicit mode, use M field from opcode */
> +        s->N1_bytes = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
> +        s->N1_bits = s->N1_bytes * 8;
> +        /*
> +         * Assume that we are going to transmit the count
> +         * (pure Implicit only)
> +         */
> +        s->N1_tx = s->N1_bytes;
> +        s->N1_rx = 0;
> +        /* Let Forced Implicit mode have an effect on the counts */
> +        if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B1, s->regs[SPI_CTR_CFG_REG]) == 1) {
> +            /*
> +             * If Forced Implicit mode and count control doesn't
> +             * indicate transmit then reset the tx count to 0
> +             */
> +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B2,
> +                                    s->regs[SPI_CTR_CFG_REG]) == 0) {
> +                s->N1_tx = 0;
> +            }
> +            /* If rx count control for N1 is set, load the rx value */
> +            if (GETFIELD(SPI_CTR_CFG_N1_CTRL_B3,
> +                                    s->regs[SPI_CTR_CFG_REG]) == 1) {
> +                s->N1_rx = s->N1_bytes;
> +            }
> +        }
> +    }
> +    /*
> +     * Enforce an upper limit on the size of N1 that is equal to the known size
> +     * of the shift register, 64 bits or 72 bits if ECC is enabled.
> +     * If the size exceeds 72 bits it is a user error so log an error,
> +     * cap the size at a max of 64 bits or 72 bits and set the sequencer FSM
> +     * error bit.
> +     */
> +    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
> +                                   s->regs[SPI_CLK_CFG_REG]);
> +    if (ecc_control == 0 || ecc_control == 2) {
> +        if (s->N1_bytes > (PNV_SPI_REG_SIZE + 1)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size when "
> +                          "ECC enabled, bytes = 0x%x, bits = 0x%x\n",
> +                          s->N1_bytes, s->N1_bits);
> +            s->N1_bytes = PNV_SPI_REG_SIZE + 1;
> +            s->N1_bits = s->N1_bytes * 8;
> +        }
> +    } else if (s->N1_bytes > PNV_SPI_REG_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
> +                      "bytes = 0x%x, bits = 0x%x\n",
> +                      s->N1_bytes, s->N1_bits);
> +        s->N1_bytes = PNV_SPI_REG_SIZE;
> +        s->N1_bits = s->N1_bytes * 8;
> +    }
> +} /* end of calculate_N1 */
> +
> +/*
> + * Shift_N1 operation handler method
> + */
> +static bool operation_shiftn1(PnvSpi *s, uint8_t opcode,
> +                       PnvXferBuffer **payload, bool send_n1_alone)
> +{
> +    uint8_t n1_count;
> +    bool stop = false;
> +
> +    /*
> +     * If there isn't a current payload left over from a stopped sequence
> +     * create a new one.
> +     */
> +    if (*payload == NULL) {
> +        *payload = pnv_spi_xfer_buffer_new();
> +    }
> +    /*
> +     * Use a combination of N1 counters to build the N1 portion of the
> +     * transmit payload.
> +     * We only care about transmit at this time since the request payload
> +     * only represents data going out on the controller output line.
> +     * Leave mode specific considerations in the calculate function since
> +     * all we really care about are counters that tell use exactly how
> +     * many bytes are in the payload and how many of those bytes to
> +     * include from the TDR into the payload.
> +     */
> +    calculate_N1(s, opcode);
> +    trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
> +                    s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2_rx);
> +    /*
> +     * Zero out the N2 counters here in case there is no N2 operation following
> +     * the N1 operation in the sequencer.  This keeps leftover N2 information
> +     * from interfering with spi_response logic.
> +     */
> +    s->N2_bits = 0;
> +    s->N2_bytes = 0;
> +    s->N2_tx = 0;
> +    s->N2_rx = 0;
> +    /*
> +     * N1_bytes is the overall size of the N1 portion of the frame regardless of
> +     * whether N1 is used for tx, rx or both.  Loop over the size to build a
> +     * payload that is N1_bytes long.
> +     * N1_tx is the count of bytes to take from the TDR and "shift" into the
> +     * frame which means append those bytes to the payload for the N1 portion
> +     * of the frame.
> +     * If N1_tx is 0 or if the count exceeds the size of the TDR append 0xFF to
> +     * the frame until the overall N1 count is reached.
> +     */
> +    n1_count = 0;
> +    while (n1_count < s->N1_bytes) {
> +        /*
> +         * Assuming that if N1_tx is not equal to 0 then it is the same as
> +         * N1_bytes.
> +         */
> +        if ((s->N1_tx != 0) && (n1_count < PNV_SPI_REG_SIZE)) {
> +
> +            if (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1) {
> +                /*
> +                 * Note that we are only appending to the payload IF the TDR
> +                 * is full otherwise we don't touch the payload because we are
> +                 * going to NOT send the payload and instead tell the sequencer
> +                 * that called us to stop and wait for a TDR write so we have
> +                 * data to load into the payload.
> +                 */
> +                uint8_t n1_byte = 0x00;
> +                n1_byte = get_from_offset(s, n1_count);
> +                trace_pnv_spi_tx_append("n1_byte", n1_byte, n1_count);
> +                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1)) =
> +                        n1_byte;
> +            } else {
> +                /*
> +                 * We hit a shift_n1 opcode TX but the TDR is empty, tell the
> +                 * sequencer to stop and break this loop.
> +                 */
> +                trace_pnv_spi_sequencer_stop_requested("Shift N1"
> +                                "set for transmit but TDR is empty");
> +                stop = true;
> +                break;
> +            }
> +        } else {
> +            /*
> +             * Cases here:
> +             * - we are receiving during the N1 frame segment and the RDR
> +             *   is full so we need to stop until the RDR is read
> +             * - we are transmitting and we don't care about RDR status
> +             *   since we won't be loading RDR during the frame segment.
> +             * - we are receiving and the RDR is empty so we allow the operation
> +             *   to proceed.
> +             */
> +            if ((s->N1_rx != 0) && (GETFIELD(SPI_STS_RDR_FULL,
> +                                           s->status) == 1)) {
> +                trace_pnv_spi_sequencer_stop_requested("shift N1"
> +                                "set for receive but RDR is full");
> +                stop = true;
> +                break;
> +            } else {
> +                trace_pnv_spi_tx_append_FF("n1_byte");
> +                *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
> +                        = 0xff;
> +            }
> +        }
> +        n1_count++;
> +    } /* end of while */
> +    /*
> +     * If we are not stopping due to an empty TDR and we are doing an N1 TX
> +     * and the TDR is full we need to clear the TDR_full status.
> +     * Do this here instead of up in the loop above so we don't log the message
> +     * in every loop iteration.
> +     * Ignore the send_n1_alone flag, all that does is defer the TX until the N2
> +     * operation, which was found immediately after the current opcode.  The TDR
> +     * was unloaded and will be shifted so we have to clear the TDR_full status.
> +     */
> +    if (!stop && (s->N1_tx != 0) &&
> +        (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1)) {
> +        s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
> +    }
> +    /*
> +     * There are other reasons why the shifter would stop, such as a TDR empty
> +     * or RDR full condition with N1 set to receive.  If we haven't stopped due
> +     * to either one of those conditions then check if the send_n1_alone flag is
> +     * equal to False, indicating the next opcode is an N2 operation, AND if
> +     * the N2 counter reload switch (bit 0 of the N2 count control field) is
> +     * set.  This condition requires a pacing write to "kick" off the N2
> +     * shift which includes the N1 shift as well when send_n1_alone is False.
> +     */
> +    if (!stop && !send_n1_alone &&
> +       (GETFIELD(SPI_CTR_CFG_N2_CTRL_B0, s->regs[SPI_CTR_CFG_REG]) == 1)) {
> +        trace_pnv_spi_sequencer_stop_requested("N2 counter reload "
> +                        "active, stop N1 shift, TDR_underrun set to 1");
> +        stop = true;
> +        s->status = SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 1);
> +    }
> +    /*
> +     * If send_n1_alone is set AND we have a full TDR then this is the first and
> +     * last payload to send and we don't have an N2 frame segment to add to the
> +     * payload.
> +     */
> +    if (send_n1_alone && !stop) {
> +        /* We have a TX and a full TDR or an RX and an empty RDR */
> +        trace_pnv_spi_tx_request("Shifting N1 frame", (*payload)->len);
> +        transfer(s, *payload);
> +        /* The N1 frame shift is complete so reset the N1 counters */
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
> +static void calculate_N2(PnvSpi *s, uint8_t opcode)
> +{
> +    /*
> +     * Shift_N2 opcode form: 0x4M
> +     * Implicit mode:
> +     * If M!=0 the shift count is M bytes and M is the number of rx bytes.
> +     * Forced Implicit mode:
> +     * M is the shift count but tx and rx is determined by the count control
> +     * register fields.  Note that we only check for Forced Implicit mode when
> +     * M != 0 since the mode doesn't make sense when M = 0.
> +     * Explicit mode:
> +     * If M==0 then shift count is number of bits defined in the
> +     * Counter Configuration Register's shift_count_N1 field.
> +     */
> +    if (PNV_SPI_OPCODE_LO_NIBBLE(opcode) == 0) {
> +        /* Explicit mode */
> +        s->N2_bits = GETFIELD(SPI_CTR_CFG_N2, s->regs[SPI_CTR_CFG_REG]);
> +        s->N2_bytes = (s->N2_bits + 7) / 8;
> +        s->N2_tx = 0;
> +        s->N2_rx = 0;
> +        /* If tx count control for N2 is set, load the tx value */
> +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2, s->regs[SPI_CTR_CFG_REG]) == 1) {
> +            s->N2_tx = s->N2_bytes;
> +        }
> +        /* If rx count control for N2 is set, load the rx value */
> +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3, s->regs[SPI_CTR_CFG_REG]) == 1) {
> +            s->N2_rx = s->N2_bytes;
> +        }
> +    } else {
> +        /* Implicit mode/Forced Implicit mode, use M field from opcode */
> +        s->N2_bytes = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
> +        s->N2_bits = s->N2_bytes * 8;
> +        /* Assume that we are going to receive the count */
> +        s->N2_rx = s->N2_bytes;
> +        s->N2_tx = 0;
> +        /* Let Forced Implicit mode have an effect on the counts */
> +        if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B1, s->regs[SPI_CTR_CFG_REG]) == 1) {
> +            /*
> +             * If Forced Implicit mode and count control doesn't
> +             * indicate a receive then reset the rx count to 0
> +             */
> +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B3,
> +                                    s->regs[SPI_CTR_CFG_REG]) == 0) {
> +                s->N2_rx = 0;
> +            }
> +            /* If tx count control for N2 is set, load the tx value */
> +            if (GETFIELD(SPI_CTR_CFG_N2_CTRL_B2,
> +                                    s->regs[SPI_CTR_CFG_REG]) == 1) {
> +                s->N2_tx = s->N2_bytes;
> +            }
> +        }
> +    }
> +    /*
> +     * Enforce an upper limit on the size of N1 that is equal to the
> +     * known size of the shift register, 64 bits or 72 bits if ECC
> +     * is enabled.
> +     * If the size exceeds 72 bits it is a user error so log an error,
> +     * cap the size at a max of 64 bits or 72 bits and set the sequencer FSM
> +     * error bit.
> +     */
> +    uint8_t ecc_control = GETFIELD(SPI_CLK_CFG_ECC_CTRL,
> +                    s->regs[SPI_CLK_CFG_REG]);
> +    if (ecc_control == 0 || ecc_control == 2) {
> +        if (s->N2_bytes > (PNV_SPI_REG_SIZE + 1)) {
> +            /* Unsupported N2 shift size when ECC enabled */
> +            s->N2_bytes = PNV_SPI_REG_SIZE + 1;
> +            s->N2_bits = s->N2_bytes * 8;
> +        }
> +    } else if (s->N2_bytes > PNV_SPI_REG_SIZE) {
> +        /* Unsupported N2 shift size */
> +        s->N2_bytes = PNV_SPI_REG_SIZE;
> +        s->N2_bits = s->N2_bytes * 8;
> +    }
> +} /* end of calculate_N2 */
> +
> +/*
> + * Shift_N2 operation handler method
> + */
> +
> +static bool operation_shiftn2(PnvSpi *s, uint8_t opcode,
> +                       PnvXferBuffer **payload)
> +{
> +    uint8_t n2_count;
> +    bool stop = false;
> +
> +    /*
> +     * If there isn't a current payload left over from a stopped sequence
> +     * create a new one.
> +     */
> +    if (*payload == NULL) {
> +        *payload = pnv_spi_xfer_buffer_new();
> +    }
> +    /*
> +     * Use a combination of N2 counters to build the N2 portion of the
> +     * transmit payload.
> +     */
> +    calculate_N2(s, opcode);
> +    trace_pnv_spi_log_Ncounts(s->N1_bits, s->N1_bytes, s->N1_tx,
> +                    s->N1_rx, s->N2_bits, s->N2_bytes, s->N2_tx, s->N2_rx);
> +    /*
> +     * The only difference between this code and the code for shift N1 is
> +     * that this code has to account for the possible presence of N1 transmit
> +     * bytes already taken from the TDR.
> +     * If there are bytes to be transmitted for the N2 portion of the frame
> +     * and there are still bytes in TDR that have not been copied into the
> +     * TX data of the payload, this code will handle transmitting those
> +     * remaining bytes.
> +     * If for some reason the transmit count(s) add up to more than the size
> +     * of the TDR we will just append 0xFF to the transmit payload data until
> +     * the payload is N1 + N2 bytes long.
> +     */
> +    n2_count = 0;
> +    while (n2_count < s->N2_bytes) {
> +        /*
> +         * If the RDR is full and we need to RX just bail out, letting the
> +         * code continue will end up building the payload twice in the same
> +         * buffer since RDR full causes a sequence stop and restart.
> +         */
> +        if ((s->N2_rx != 0) &&
> +            (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1)) {
> +            trace_pnv_spi_sequencer_stop_requested("shift N2 set"
> +                            "for receive but RDR is full");
> +            stop = true;
> +            break;
> +        }
> +        if ((s->N2_tx != 0) && ((s->N1_tx + n2_count) <
> +                                PNV_SPI_REG_SIZE)) {
> +            /* Always append data for the N2 segment if it is set for TX */
> +            uint8_t n2_byte = 0x00;
> +            n2_byte = get_from_offset(s, (s->N1_tx + n2_count));
> +            trace_pnv_spi_tx_append("n2_byte", n2_byte, (s->N1_tx + n2_count));
> +            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
> +                    = n2_byte;
> +        } else {
> +            /*
> +             * Regardless of whether or not N2 is set for TX or RX, we need
> +             * the number of bytes in the payload to match the overall length
> +             * of the operation.
> +             */
> +            trace_pnv_spi_tx_append_FF("n2_byte");
> +            *(pnv_spi_xfer_buffer_write_ptr(*payload, (*payload)->len, 1))
> +                    = 0xff;
> +        }
> +        n2_count++;
> +    } /* end of while */
> +    if (!stop) {
> +        /* We have a TX and a full TDR or an RX and an empty RDR */
> +        trace_pnv_spi_tx_request("Shifting N2 frame", (*payload)->len);
> +        transfer(s, *payload);
> +        /*
> +         * If we are doing an N2 TX and the TDR is full we need to clear the
> +         * TDR_full status. Do this here instead of up in the loop above so we
> +         * don't log the message in every loop iteration.
> +         */
> +        if ((s->N2_tx != 0) &&
> +            (GETFIELD(SPI_STS_TDR_FULL, s->status) == 1)) {
> +            s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 0);
> +        }
> +        /*
> +         * The N2 frame shift is complete so reset the N2 counters.
> +         * Reset the N1 counters also in case the frame was a combination of
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
> +static void operation_sequencer(PnvSpi *s)
> +{
> +    /*
> +     * Loop through each sequencer operation ID and perform the requested
> +     *  operations.
> +     * Flag for indicating if we should send the N1 frame or wait to combine
> +     * it with a preceding N2 frame.
> +     */
> +    bool send_n1_alone = true;
> +    bool stop = false; /* Flag to stop the sequencer */
> +    uint8_t opcode = 0;
> +    uint8_t masked_opcode = 0;
> +
> +    /*
> +     * PnvXferBuffer for containing the payload of the SPI frame.
> +     * This is a static because there are cases where a sequence has to stop
> +     * and wait for the target application to unload the RDR.  If this occurs
> +     * during a sequence where N1 is not sent alone and instead combined with
> +     * N2 since the N1 tx length + the N2 tx length is less than the size of
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
> +    s->status = SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 0);
> +    /*
> +     * If the FSM is idle set the sequencer index to 0
> +     * (new/restarted sequence)
> +     */
> +    if (GETFIELD(SPI_STS_SEQ_FSM, s->status) == SEQ_STATE_IDLE) {
> +        s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
> +    }
> +    /*
> +     * There are only 8 possible operation IDs to iterate through though
> +     * some operations may cause more than one frame to be sequenced.
> +     */
> +    while (get_seq_index(s) < NUM_SEQ_OPS) {
> +        opcode = s->seq_op[get_seq_index(s)];
> +        /* Set sequencer state to decode */
> +        s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_DECODE);
> +        /*
> +         * Only the upper nibble of the operation ID is needed to know what
> +         * kind of operation is requested.
> +         */
> +        masked_opcode = PNV_SPI_MASKED_OPCODE(opcode);
> +        switch (masked_opcode) {
> +        /*
> +         * Increment the operation index in each case instead of just
> +         * once at the end in case an operation like the branch
> +         * operation needs to change the index.
> +         */
> +        case SEQ_OP_STOP:
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            /* A stop operation in any position stops the sequencer */
> +            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
> +
> +            stop = true;
> +            s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
> +            s->loop_counter_1 = 0;
> +            s->loop_counter_2 = 0;
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_IDLE);
> +            break;
> +
> +        case SEQ_OP_SELECT_SLAVE:
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("SELECT_SLAVE", get_seq_index(s));
> +            /*
> +             * This device currently only supports a single responder
> +             * connection at position 0.  De-selecting a responder is fine
> +             * and expected at the end of a sequence but selecting any
> +             * responder other than 0 should cause an error.
> +             */
> +            s->responder_select = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
> +            if (s->responder_select == 0) {
> +                trace_pnv_spi_shifter_done();
> +                qemu_set_irq(s->cs_line[0], 1);
> +                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
> +                                (get_seq_index(s) + 1));
> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_DONE);
> +            } else if (s->responder_select != 1) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
> +                              "not supported, select = 0x%x\n",
> +                               s->responder_select);
> +                trace_pnv_spi_sequencer_stop_requested("invalid "
> +                                "responder select");
> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
> +                stop = true;
> +            } else {
> +                /*
> +                 * Only allow an FSM_START state when a responder is
> +                 * selected
> +                 */
> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_START);
> +                trace_pnv_spi_shifter_stating();
> +                qemu_set_irq(s->cs_line[0], 0);
> +                /*
> +                 * A Shift_N2 operation is only valid after a Shift_N1
> +                 * according to the spec. The spec doesn't say if that means
> +                 * immediately after or just after at any point. We will track
> +                 * the occurrence of a Shift_N1 to enforce this requirement in
> +                 * the most generic way possible by assuming that the rule
> +                 * applies once a valid responder select has occurred.
> +                 */
> +                s->shift_n1_done = false;
> +                next_sequencer_fsm(s);
> +            }
> +            break;
> +
> +        case SEQ_OP_SHIFT_N1:
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("SHIFT_N1", get_seq_index(s));
> +            /*
> +             * Only allow a shift_n1 when the state is not IDLE or DONE.
> +             * In either of those two cases the sequencer is not in a proper
> +             * state to perform shift operations because the sequencer has:
> +             * - processed a responder deselect (DONE)
> +             * - processed a stop opcode (IDLE)
> +             * - encountered an error (IDLE)
> +             */
> +            if ((GETFIELD(SPI_STS_SHIFTER_FSM, s->status) == FSM_IDLE) ||
> +                (GETFIELD(SPI_STS_SHIFTER_FSM, s->status) == FSM_DONE)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N1 not allowed in "
> +                              "shifter state = 0x%llx", GETFIELD(
> +                        SPI_STS_SHIFTER_FSM, s->status));
> +                /*
> +                 * Set sequencer FSM error bit 3 (general_SPI_status[3])
> +                 * in status reg.
> +                 */
> +                s->status = SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 1);
> +                trace_pnv_spi_sequencer_stop_requested("invalid shifter state");
> +                stop = true;
> +            } else {
> +                /*
> +                 * Look for the special case where there is a shift_n1 set for
> +                 * transmit and it is followed by a shift_n2 set for transmit
> +                 * AND the combined transmit length of the two operations is
> +                 * less than or equal to the size of the TDR register. In this
> +                 * case we want to use both this current shift_n1 opcode and the
> +                 * following shift_n2 opcode to assemble the frame for
> +                 * transmission to the responder without requiring a refill of
> +                 * the TDR between the two operations.
> +                 */
> +                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) + 1])
> +                                == SEQ_OP_SHIFT_N2) {
> +                    send_n1_alone = false;
> +                }
> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> +                                FSM_SHIFT_N1);
> +                stop = operation_shiftn1(s, opcode, &payload, send_n1_alone);
> +                if (stop) {
> +                    /*
> +                     *  The operation code says to stop, this can occur if:
> +                     * (1) RDR is full and the N1 shift is set for receive
> +                     * (2) TDR was empty at the time of the N1 shift so we need
> +                     * to wait for data.
> +                     * (3) Neither 1 nor 2 are occurring and we aren't sending
> +                     * N1 alone and N2 counter reload is set (bit 0 of the N2
> +                     * counter reload field).  In this case TDR_underrun will
> +                     * will be set and the Payload has been loaded so it is
> +                     * ok to advance the sequencer.
> +                     */
> +                    if (GETFIELD(SPI_STS_TDR_UNDERRUN, s->status)) {
> +                        s->shift_n1_done = true;
> +                        s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> +                                                  FSM_SHIFT_N2);
> +                        s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
> +                                        (get_seq_index(s) + 1));
> +                    } else {
> +                        /*
> +                         * This is case (1) or (2) so the sequencer needs to
> +                         * wait and NOT go to the next sequence yet.
> +                         */
> +                        s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> +                                        FSM_WAIT);
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
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("SHIFT_N2", get_seq_index(s));
> +            if (!s->shift_n1_done) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not allowed if a "
> +                              "Shift_N1 is not done, shifter state = 0x%llx",
> +                              GETFIELD(SPI_STS_SHIFTER_FSM, s->status));
> +                /*
> +                 * In case the sequencer actually stops if an N2 shift is
> +                 * requested before any N1 shift is done. Set sequencer FSM
> +                 * error bit 3 (general_SPI_status[3]) in status reg.
> +                 */
> +                s->status = SETFIELD(SPI_STS_GEN_STATUS_B3, s->status, 1);
> +                trace_pnv_spi_sequencer_stop_requested("shift_n2 "
> +                                    "w/no shift_n1 done");
> +                stop = true;
> +            } else {
> +                /* Ok to do a Shift_N2 */
> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> +                                FSM_SHIFT_N2);
> +                stop = operation_shiftn2(s, opcode, &payload);
> +                /*
> +                 * If the operation code says to stop set the shifter state to
> +                 * wait and stop
> +                 */
> +                if (stop) {
> +                    s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> +                                    FSM_WAIT);
> +                } else {
> +                    /* Ok to move on to the next index */
> +                    next_sequencer_fsm(s);
> +                }
> +            }
> +            break;
> +
> +        case SEQ_OP_BRANCH_IFNEQ_RDR:
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR", get_seq_index(s));
> +            /*
> +             * The memory mapping register RDR match value is compared against
> +             * the 16 rightmost bytes of the RDR (potentially with masking).
> +             * Since this comparison is performed against the contents of the
> +             * RDR then a receive must have previously occurred otherwise
> +             * there is no data to compare and the operation cannot be
> +             * completed and will stop the sequencer until RDR full is set to
> +             * 1.
> +             */
> +            if (GETFIELD(SPI_STS_RDR_FULL, s->status) == 1) {
> +                bool rdr_matched = false;
> +                rdr_matched = does_rdr_match(s);
> +                if (rdr_matched) {
> +                    trace_pnv_spi_RDR_match("success");
> +                    /* A match occurred, increment the sequencer index. */
> +                    next_sequencer_fsm(s);
> +                } else {
> +                    trace_pnv_spi_RDR_match("failed");
> +                    /*
> +                     * Branch the sequencer to the index coded into the op
> +                     * code.
> +                     */
> +                    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
> +                                    PNV_SPI_OPCODE_LO_NIBBLE(opcode));
> +                }
> +                /*
> +                 * Regardless of where the branch ended up we want the
> +                 * sequencer to continue shifting so we have to clear
> +                 * RDR_full.
> +                 */
> +                s->status = SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
> +            } else {
> +                trace_pnv_spi_sequencer_stop_requested("RDR not"
> +                                "full for 0x6x opcode");
> +                stop = true;
> +                s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_WAIT);
> +            }
> +            break;
> +
> +        case SEQ_OP_TRANSFER_TDR:
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not supported\n");
> +            next_sequencer_fsm(s);
> +            break;
> +
> +        case SEQ_OP_BRANCH_IFNEQ_INC_1:
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1", get_seq_index(s));
> +            /*
> +             * The spec says the loop should execute count compare + 1 times.
> +             * However we learned from engineering that we really only loop
> +             * count_compare times, count compare = 0 makes this op code a
> +             * no-op
> +             */
> +            if (s->loop_counter_1 !=
> +                GETFIELD(SPI_CTR_CFG_CMP1, s->regs[SPI_CTR_CFG_REG])) {
> +                /*
> +                 * Next index is the lower nibble of the branch operation ID,
> +                 * mask off all but the first three bits so we don't try to
> +                 * access beyond the sequencer_operation_reg boundary.
> +                 */
> +                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
> +                                PNV_SPI_OPCODE_LO_NIBBLE(opcode));
> +                s->loop_counter_1++;
> +            } else {
> +                /* Continue to next index if loop counter is reached */
> +                next_sequencer_fsm(s);
> +            }
> +            break;
> +
> +        case SEQ_OP_BRANCH_IFNEQ_INC_2:
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", get_seq_index(s));
> +            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2,
> +                              s->regs[SPI_CTR_CFG_REG]);
> +            /*
> +             * The spec says the loop should execute count compare + 1 times.
> +             * However we learned from engineering that we really only loop
> +             * count_compare times, count compare = 0 makes this op code a
> +             * no-op
> +             */
> +            if (s->loop_counter_2 != condition2) {
> +                /*
> +                 * Next index is the lower nibble of the branch operation ID,
> +                 * mask off all but the first three bits so we don't try to
> +                 * access beyond the sequencer_operation_reg boundary.
> +                 */
> +                s->status = SETFIELD(SPI_STS_SEQ_INDEX,
> +                                s->status, PNV_SPI_OPCODE_LO_NIBBLE(opcode));
> +                s->loop_counter_2++;
> +            } else {
> +                /* Continue to next index if loop counter is reached */
> +                next_sequencer_fsm(s);
> +            }
> +            break;
> +
> +        default:
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
> +            /* Ignore unsupported operations. */
> +            next_sequencer_fsm(s);
> +            break;
> +        } /* end of switch */
> +        /*
> +         * If we used all 8 opcodes without seeing a 00 - STOP in the sequence
> +         * we need to go ahead and end things as if there was a STOP at the
> +         * end.
> +         */
> +        if (get_seq_index(s) == NUM_SEQ_OPS) {
> +            /* All 8 opcodes completed, sequencer idling */
> +            s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
> +            s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
> +            s->loop_counter_1 = 0;
> +            s->loop_counter_2 = 0;
> +            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_IDLE);
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
> + * The SPIC engine and its internal sequencer can be interrupted and reset by
> + * a hardware signal, the sbe_spicst_hard_reset bits from Pervasive
> + * Miscellaneous Register of sbe_register_bo device.
> + * Reset immediately aborts any SPI transaction in progress and returns the
> + * sequencer and state machines to idle state.
> + * The configuration register values are not changed. The status register is
> + * not reset. The engine registers are not reset.
> + * The SPIC engine reset does not have any affect on the attached devices.
> + * Reset handling of any attached devices is beyond the scope of the engine.
> + */
> +static void do_reset(DeviceState *dev)
> +{
> +    PnvSpi *s = PNV_SPI(dev);
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
>   static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       PnvSpi *s = PNV_SPI(opaque);
> @@ -51,6 +1088,10 @@ static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, unsigned size)
>           val = s->regs[reg];
>           trace_pnv_spi_read_RDR(val);
>           s->status = SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
> +        if (GETFIELD(SPI_STS_SHIFTER_FSM, s->status) == FSM_WAIT) {
> +            trace_pnv_spi_start_sequencer();
> +            operation_sequencer(s);
> +        }
>           break;
>       case SPI_SEQ_OP_REG:
>           val = 0;
> @@ -112,6 +1153,8 @@ static void pnv_spi_xscom_write(void *opaque, hwaddr addr,
>           trace_pnv_spi_write_TDR(val);
>           s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 1);
>           s->status = SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 0);
> +        trace_pnv_spi_start_sequencer();
> +        operation_sequencer(s);
>           break;
>       case SPI_SEQ_OP_REG:
>           for (int i = 0; i < PNV_SPI_REG_SIZE; i++) {
> @@ -144,6 +1187,7 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
>   
>   static Property pnv_spi_properties[] = {
>       DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
> +    DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -193,6 +1237,7 @@ static void pnv_spi_class_init(ObjectClass *klass, void *data)
>   
>       dc->desc = "PowerNV SPI";
>       dc->realize = pnv_spi_realize;
> +    dc->reset = do_reset;
>       device_class_set_props(dc, pnv_spi_properties);
>   }
>   
> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> index 2cc29e1284..089d269994 100644
> --- a/hw/ssi/trace-events
> +++ b/hw/ssi/trace-events
> @@ -38,3 +38,18 @@ pnv_spi_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
>   pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
>   pnv_spi_read_RDR(uint64_t val) "data extracted = 0x%" PRIx64
>   pnv_spi_write_TDR(uint64_t val) "being written, data written = 0x%" PRIx64
> +pnv_spi_start_sequencer(void) ""
> +pnv_spi_reset(void) "spic engine sequencer configuration and spi communication"
> +pnv_spi_sequencer_op(const char* op, uint8_t index) "%s at index = 0x%x"
> +pnv_spi_shifter_stating(void) "pull CS line low"
> +pnv_spi_shifter_done(void) "pull the CS line high"
> +pnv_spi_log_Ncounts(uint8_t N1_bits, uint8_t N1_bytes, uint8_t N1_tx, uint8_t N1_rx, uint8_t N2_bits, uint8_t N2_bytes, uint8_t N2_tx, uint8_t N2_rx) "N1_bits = %d, N1_bytes = %d, N1_tx = %d, N1_rx = %d, N2_bits = %d, N2_bytes = %d, N2_tx = %d, N2_rx = %d"
> +pnv_spi_tx_append(const char* frame, uint8_t byte, uint8_t tdr_index) "%s = 0x%2.2x to payload from TDR at index %d"
> +pnv_spi_tx_append_FF(const char* frame) "%s to Payload"
> +pnv_spi_tx_request(const char* frame, uint32_t payload_len) "%s, payload len = %d"
> +pnv_spi_rx_received(uint32_t payload_len) "payload len = %d"
> +pnv_spi_rx_read_N1frame(void) ""
> +pnv_spi_rx_read_N2frame(void) ""
> +pnv_spi_shift_rx(uint8_t byte, uint32_t index) "byte = 0x%2.2x into RDR from payload index %d"
> +pnv_spi_sequencer_stop_requested(const char* reason) "due to %s"
> +pnv_spi_RDR_match(const char* result) "%s"
> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
> index 833042b74b..8815f67d45 100644
> --- a/include/hw/ssi/pnv_spi.h
> +++ b/include/hw/ssi/pnv_spi.h
> @@ -8,6 +8,14 @@
>    * This model Supports a connection to a single SPI responder.
>    * Introduced for P10 to provide access to SPI seeproms, TPM, flash device
>    * and an ADC controller.
> + *
> + * All SPI function control is mapped into the SPI register space to enable
> + * full control by firmware.
> + *
> + * SPI Controller has sequencer and shift engine. The SPI shift engine
> + * performs serialization and de-serialization according to the control by
> + * the sequencer and according to the setup defined in the configuration
> + * registers and the SPI sequencer implements the main control logic.
>    */
>   
>   #ifndef PPC_PNV_SPI_H
> @@ -31,6 +39,25 @@ typedef struct PnvSpi {
>       MemoryRegion    xscom_spic_regs;
>       /* SPI object number */
>       uint32_t        spic_num;
> +    uint8_t         transfer_len;
> +    uint8_t         responder_select;
> +    /* To verify if shift_n1 happens prior to shift_n2 */
> +    bool            shift_n1_done;
> +    /* Loop counter for branch operation opcode Ex/Fx */
> +    uint8_t         loop_counter_1;
> +    uint8_t         loop_counter_2;
> +    /* N1/N2_bits specifies the size of the N1/N2 segment of a frame in bits.*/
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
>       /* SPI registers */
>       uint64_t        regs[PNV_SPI_REGS];
> diff --git a/include/hw/ssi/pnv_spi_regs.h b/include/hw/ssi/pnv_spi_regs.h
> index 5b6ff72d02..596e2c1911 100644
> --- a/include/hw/ssi/pnv_spi_regs.h
> +++ b/include/hw/ssi/pnv_spi_regs.h
> @@ -28,6 +28,17 @@
>   
>   /* counter_config_reg */
>   #define SPI_CTR_CFG_REG         0x01
> +#define SPI_CTR_CFG_N1          PPC_BITMASK(0, 7)
> +#define SPI_CTR_CFG_N2          PPC_BITMASK(8, 15)
> +#define SPI_CTR_CFG_CMP1        PPC_BITMASK(24, 31)
> +#define SPI_CTR_CFG_CMP2        PPC_BITMASK(32, 39)
> +#define SPI_CTR_CFG_N1_CTRL_B1  PPC_BIT(49)
> +#define SPI_CTR_CFG_N1_CTRL_B2  PPC_BIT(50)
> +#define SPI_CTR_CFG_N1_CTRL_B3  PPC_BIT(51)
> +#define SPI_CTR_CFG_N2_CTRL_B0  PPC_BIT(52)
> +#define SPI_CTR_CFG_N2_CTRL_B1  PPC_BIT(53)
> +#define SPI_CTR_CFG_N2_CTRL_B2  PPC_BIT(54)
> +#define SPI_CTR_CFG_N2_CTRL_B3  PPC_BIT(55)
>   
>   /* config_reg */
>   #define CONFIG_REG1             0x02
> @@ -36,9 +47,13 @@
>   #define SPI_CLK_CFG_REG         0x03
>   #define SPI_CLK_CFG_HARD_RST    0x0084000000000000;
>   #define SPI_CLK_CFG_RST_CTRL    PPC_BITMASK(24, 27)
> +#define SPI_CLK_CFG_ECC_EN      PPC_BIT(28)
> +#define SPI_CLK_CFG_ECC_CTRL    PPC_BITMASK(29, 30)
>   
>   /* memory_mapping_reg */
>   #define SPI_MM_REG              0x04
> +#define SPI_MM_RDR_MATCH_VAL    PPC_BITMASK(32, 47)
> +#define SPI_MM_RDR_MATCH_MASK   PPC_BITMASK(48, 63)
>   
>   /* transmit_data_reg */
>   #define SPI_XMIT_DATA_REG       0x05
> @@ -60,8 +75,59 @@
>   #define SPI_STS_SEQ_FSM         PPC_BITMASK(8, 15)
>   #define SPI_STS_SHIFTER_FSM     PPC_BITMASK(16, 27)
>   #define SPI_STS_SEQ_INDEX       PPC_BITMASK(28, 31)
> -#define SPI_STS_GEN_STATUS      PPC_BITMASK(32, 63)
> +#define SPI_STS_GEN_STATUS_B3   PPC_BIT(35)
>   #define SPI_STS_RDR             PPC_BITMASK(1, 3)
>   #define SPI_STS_TDR             PPC_BITMASK(5, 7)
>   
> +/*
> + * Shifter states
> + *
> + * These are the same values defined for the Shifter FSM field of the
> + * status register.  It's a 12 bit field so we will represent it as three
> + * nibbles in the constants.
> + *
> + * These are shifter_fsm values
> + *
> + * Status reg bits 16-27 -> field bits 0-11
> + * bits 0,1,2,5 unused/reserved
> + * bit 4 crc shift in (unused)
> + * bit 8 crc shift out (unused)
> + */
> +
> +#define FSM_DONE                        0x100   /* bit 3 */
> +#define FSM_SHIFT_N2                    0x020   /* bit 6 */
> +#define FSM_WAIT                        0x010   /* bit 7 */
> +#define FSM_SHIFT_N1                    0x004   /* bit 9 */
> +#define FSM_START                       0x002   /* bit 10 */
> +#define FSM_IDLE                        0x001   /* bit 11 */
> +
> +/*
> + * Sequencer states
> + *
> + * These are sequencer_fsm values
> + *
> + * Status reg bits 8-15 -> field bits 0-7
> + * bits 0-3 unused/reserved
> + *
> + */
> +#define SEQ_STATE_INDEX_INCREMENT       0x08    /* bit 4 */
> +#define SEQ_STATE_EXECUTE               0x04    /* bit 5 */
> +#define SEQ_STATE_DECODE                0x02    /* bit 6 */
> +#define SEQ_STATE_IDLE                  0x01    /* bit 7 */
> +
> +/*
> + * These are the supported sequencer operations.
> + * Only the upper nibble is significant because for many operations
> + * the lower nibble is a variable specific to the operation.
> + */
> +#define SEQ_OP_STOP                     0x00
> +#define SEQ_OP_SELECT_SLAVE             0x10
> +#define SEQ_OP_SHIFT_N1                 0x30
> +#define SEQ_OP_SHIFT_N2                 0x40
> +#define SEQ_OP_BRANCH_IFNEQ_RDR         0x60
> +#define SEQ_OP_TRANSFER_TDR             0xC0
> +#define SEQ_OP_BRANCH_IFNEQ_INC_1       0xE0
> +#define SEQ_OP_BRANCH_IFNEQ_INC_2       0xF0
> +#define NUM_SEQ_OPS                     8
> +
>   #endif


