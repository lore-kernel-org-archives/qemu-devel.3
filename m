Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF10BC54E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 19:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rig21-0002PN-DI; Fri, 08 Mar 2024 14:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1rig1x-0002OR-Fp; Fri, 08 Mar 2024 14:37:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1rig1t-0002ll-9p; Fri, 08 Mar 2024 14:37:20 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428Iw5Nn010515; Fri, 8 Mar 2024 19:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yq4ur3FtnbRPn9XQgca0ymIq69vnmny4YvdPAKSOuFU=;
 b=foXi1grfmI3QWm6SJMsPBqLWpAVrcMRYb9+aF7NtzFeap4tdRjAAaKVxMeXCDFoNtUFo
 8MDZbzsrrG2kjUHAdpXVHbVCHI7DolTKg7wTF+5EIUwZhtGT3Jt7UeWaG9GOchzUYh8j
 K+ciE0LBs3nx5CwrGhyNFa3RmxetpbSYoQIffdBhEUJQz0x4sWLfQtY/+hvfYwFq/P56
 dHh7yrZQlGMmoqzaIQeW1VQQacIV+eJlaFAt5RuWjulww07YdDqB1ChimiWY+sbN7adj
 5lyQEk1CTIcvSDoUx/e3VJUN0ZKc7bm+D0aZS905b9X3m+qUIoJNv/dP3KmctVMfJc1p SA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr8durncf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 19:37:06 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428Ix384013524;
 Fri, 8 Mar 2024 19:37:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr8durnc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 19:37:05 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428JYMVF025399; Fri, 8 Mar 2024 19:37:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmeu06nw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 19:37:05 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428Jb0W924051974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 19:37:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B75D58061;
 Fri,  8 Mar 2024 19:37:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A70B858060;
 Fri,  8 Mar 2024 19:36:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 19:36:59 +0000 (GMT)
Message-ID: <48fc7847-0ebd-422a-ba44-a3c5f13cb63d@linux.ibm.com>
Date: Fri, 8 Mar 2024 14:36:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] hw/ppc: SPI controller model - sequencer and
 shifter
Content-Language: en-US
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
 <20240207160833.3437779-4-chalapathi.v@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240207160833.3437779-4-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bVHvSDrfEPBtjtFP_R60pQoq2RNrnSVz
X-Proofpoint-GUID: 40Gxk9a7fyghsv4zOHZJkOldmmOdNZeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080154
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 2/7/24 11:08, Chalapathi V wrote:
> In this commit SPI shift engine and sequencer logic is implemented.
> Shift engine performs serialization and de-serialization according to the
> control by the sequencer and according to the setup defined in the
> configuration registers. Sequencer implements the main control logic and
> FSM to handle data transmit and data receive control of the shift engine.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   include/hw/ppc/pnv_spi_controller.h |   58 ++
>   hw/ppc/pnv_spi_controller.c         | 1274 ++++++++++++++++++++++++++-
>   2 files changed, 1331 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/pnv_spi_controller.h b/include/hw/ppc/pnv_spi_controller.h
> index 8afaabdd1b..8160c35f5c 100644
> --- a/include/hw/ppc/pnv_spi_controller.h
> +++ b/include/hw/ppc/pnv_spi_controller.h
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
>   #ifndef PPC_PNV_SPI_CONTROLLER_H
> @@ -20,6 +28,7 @@
>   #define SPI_CONTROLLER_REG_SIZE 8
>   
>   typedef struct SpiBus SpiBus;
> +typedef struct xfer_buffer xfer_buffer;
>   
>   typedef struct PnvSpiController {
>       DeviceState parent;
> @@ -28,6 +37,39 @@ typedef struct PnvSpiController {
>       MemoryRegion    xscom_spic_regs;
>       /* SPI controller object number */
>       uint32_t        spic_num;
> +    uint8_t         responder_select;
> +    /* To verify if shift_n1 happens prior to shift_n2 */
> +    bool            shift_n1_done;
> +    /*
> +     * Internal flags for the first and last indicators for the SPI
> +     * interface methods
> +     */
> +    uint8_t         first;
> +    uint8_t         last;

Do these two correspond to the first and liast here?

xfer_buffer *seeprom_spi_request(PnvSpiResponder *resp, int first, int 
last, int bits, xfer_buffer *payload);

If so I think the data types in the prototype should be set to uint8_t 
as well and also bits should probably be an unsigned int or uint8_t?

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
> +    /*
> +     * Setting this attribute to true will cause the engine to reverse the
> +     * bit order of each byte it appends to a payload before sending the
> +     * payload to a device. There may be cases where an end device expects
> +     * a reversed order, like in the case of the Nuvoton TPM device. The
> +     * order of bytes in the payload is not reversed, only the order of the
> +     * 8 bits in each payload byte.
> +     */
> +    bool            reverse_bits;
>   
>       /* SPI Controller registers */
>       uint64_t        error_reg;
> @@ -40,4 +82,20 @@ typedef struct PnvSpiController {
>       uint8_t         sequencer_operation_reg[SPI_CONTROLLER_REG_SIZE];
>       uint64_t        status_reg;
>   } PnvSpiController;
> +
> +void log_all_N_counts(PnvSpiController *spi_controller);
> +void spi_response(PnvSpiController *spi_controller, int bits,
> +                xfer_buffer *rsp_payload);
> +void operation_sequencer(PnvSpiController *spi_controller);
> +bool operation_shiftn1(PnvSpiController *spi_controller, uint8_t opcode,
> +                       xfer_buffer **payload, bool send_n1_alone);
> +bool operation_shiftn2(PnvSpiController *spi_controller, uint8_t opcode,
> +                       xfer_buffer **payload);
> +bool does_rdr_match(PnvSpiController *spi_controller);
> +uint8_t get_from_offset(PnvSpiController *spi_controller, uint8_t offset);
> +void shift_byte_in(PnvSpiController *spi_controller, uint8_t byte);
> +void calculate_N1(PnvSpiController *spi_controller, uint8_t opcode);
> +void calculate_N2(PnvSpiController *spi_controller, uint8_t opcode);
> +void do_reset(PnvSpiController *spi_controller);
> +uint8_t reverse_bits8(uint8_t x);
>   #endif /* PPC_PNV_SPI_CONTROLLER_H */
> diff --git a/hw/ppc/pnv_spi_controller.c b/hw/ppc/pnv_spi_controller.c
> index 0f2bc25e82..ef48af5d03 100644
> --- a/hw/ppc/pnv_spi_controller.c
> +++ b/hw/ppc/pnv_spi_controller.c
> @@ -9,7 +9,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "hw/qdev-properties.h"
> -#include "hw/ppc/pnv.h"
>   #include "hw/ppc/pnv_xscom.h"
>   #include "hw/ppc/pnv_spi_controller.h"
>   #include "hw/ppc/pnv_spi_responder.h"
> @@ -155,6 +154,12 @@ static uint64_t pnv_spi_controller_read(void *opaque, hwaddr addr,
>                              val));
>           sc->status_reg = SETFIELD(STATUS_REG_RDR_FULL, sc->status_reg, 0);
>           SPI_DEBUG(qemu_log("RDR being read, RDR_full set to 0\n"));
> +        if (GETFIELD(STATUS_REG_SHIFTER_FSM, sc->status_reg) == FSM_WAIT) {

In the other patch you seemed to have used extract() and deposit(). Now 
you are switching to GETFIELD() and SETFIELD(). Any reason for this?

> +                /* call $operation_sequencer(); */

You can remove this comment -- it doesn't add much

> +            SPI_DEBUG(qemu_log("RDR being read while shifter is waiting, "
> +                           "starting sequencer\n"));
> +            operation_sequencer(sc);
> +        }
>           break;
>       case SEQUENCER_OPERATION_REG:
>           for (int i = 0; i < SPI_CONTROLLER_REG_SIZE; i++) {
> @@ -227,6 +232,9 @@ static void pnv_spi_controller_write(void *opaque, hwaddr addr,
>           sc->status_reg = SETFIELD(STATUS_REG_TDR_UNDERRUN, sc->status_reg, 0);
>           SPI_DEBUG(qemu_log("TDR being written, TDR_underrun set to 0\n"));
>           SPI_DEBUG(qemu_log("TDR being written, starting sequencer\n"));
> +        /* call $operation_sequencer(); */
> +        operation_sequencer(sc);
> +
>           break;
>       case RECEIVE_DATA_REG:
>           sc->receive_data_reg = val;
> @@ -264,8 +272,1272 @@ static const MemoryRegionOps pnv_spi_controller_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> +uint8_t reverse_bits8(uint8_t x)
> +{
> +    x = (x << 4) | (x >> 4);
> +    x = ((x & 0x33) << 2) | ((x & 0xcc) >> 2);
> +    x = ((x & 0x55) << 1) | ((x & 0xaa) >> 1);
> +    return x;
> +}
> +
> +bool does_rdr_match(PnvSpiController *sc)
> +{
> +    /*
> +     * The mask bits that are 0 are compared and the
> +     * bits that are 1 are ignored.
> +     */
> +    uint16_t rdr_match_mask = GETFIELD(MEMORY_MAPPING_REG_RDR_MATCH_MASK,
> +                                        sc->memory_mapping_reg);
> +    uint16_t rdr_match_val = GETFIELD(MEMORY_MAPPING_REG_RDR_MATCH_VAL,
> +                                        sc->memory_mapping_reg);

empty line after var decl -- applies to rest of file / all patches

> +    if ((~rdr_match_mask & rdr_match_val) == ((~rdr_match_mask) &
> +            GETFIELD(PPC_BITMASK(48, 63), sc->receive_data_reg))) {
> +        SPI_DEBUG(qemu_log("RDR match successful, match=0x%4.4x, "
> +                                 "mask=0x%4.4x, RDR[48:63]=0x%4.4llx\n",
> +                           rdr_match_val, rdr_match_mask,
> +                                  GETFIELD(PPC_BITMASK(48, 63),
> +                                   sc->receive_data_reg)));
> +        return true;
> +    } else {

No else branch necessary.

> +        SPI_DEBUG(qemu_log("RDR match failed, match=0x%4.4x, mask=0x%4.4x, "
> +              "RDR[48:63]=0x%4.4llx\n", rdr_match_val, rdr_match_mask,
> +               GETFIELD(PPC_BITMASK(48, 63), sc->receive_data_reg)));
> +        return false;
> +    }
> +}
> +
> +uint8_t get_from_offset(PnvSpiController *sc, uint8_t offset)
> +{
> +    uint8_t byte;
> +    /*
> +     * Offset is an index between 0 and SPI_CONTROLLER_REG_SIZE - 1
> +     * Check the offset before using it.
> +     */
> +    if (offset < SPI_CONTROLLER_REG_SIZE) {
> +        byte = GETFIELD(PPC_BITMASK(offset * 8 , (offset * 8) + 7),
> +                        sc->transmit_data_reg);

Would find this easier to read:

byte = sc->transmit_data_reg >> (56 - (offset * 8))

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
> +void shift_byte_in(PnvSpiController *sc, uint8_t byte)
> +{
> +    sc->receive_data_reg = (sc->receive_data_reg << 8) | byte;

No extract/deposit or SETFIELD & GETFIELD. :-) thanks

> +    SPI_DEBUG(qemu_log("0x%2.2x shifted in, RDR now = 0x%16.16lx\n", byte,
> +                    sc->receive_data_reg));
> +}
> +
> +void spi_response(PnvSpiController *sc, int bits, xfer_buffer *rsp_payload)
> +{
> +    uint8_t *read_buf = NULL;
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
> +    if (rsp_payload->len != (sc->N1_bytes + sc->N2_bytes)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload size in "
> +                       "bytes, expected %d, got %d\n",
> +                       (sc->N1_bytes + sc->N2_bytes), rsp_payload->len);
> +    } else {
> +        SPI_DEBUG(qemu_log("SPI response received, payload len = %d\n",
> +                       rsp_payload->len));
> +        log_all_N_counts(sc);
> +        /*
> +         * Adding an ECC count let's us know when we have found a payload byte
> +         * that was shifted in but cannot be loaded into RDR.  Bits 29-30

Bits 29-30 of 'what' ? clock_config_reset_control?

> +         * equal to either 0b00 or 0b10 indicate that we are taking in data
> +         * with ECC and either applying the ECC or discarding it.
> +         */
> +        uint8_t ecc_count = 0;
> +        uint8_t ecc_control = GETFIELD(CLOCK_CONFIG_REG_ECC_CONTROL,
> +                                    sc->clock_config_reset_control);
> +        uint8_t ecc_control_1_2 = GETFIELD(PPC_BITMASK8(1, 2), ecc_control);

Var devcls to top of block (vdttob).

Hm, I wished you were using extract/extract8 again...

> +        if (ecc_control_1_2 == 0 || ecc_control_1_2 == 2) {
> +            ecc_count = 1;
> +        }
> +        /*
> +         * Use the N1_rx and N2_rx counts to control shifting data from the
> +         * payload into the RDR.  Keep an overall count of the number of bytes
> +         * shifted into RDR so we can discard every 9th byte when ECC is
> +         * enabled.
> +         */
> +        uint8_t shift_in_count = 0;

vdttob

> +        /* Handle the N1 portion of the frame first */
> +        if (sc->N1_rx != 0) {
> +            uint8_t n1_count = 0;
> +            while (n1_count < sc->N1_bytes) {
> +                shift_in_count++;
> +                xfer_buffer_read_ptr(rsp_payload, &read_buf, n1_count, 1);
> +                if ((ecc_count != 0) &&
> +                    (shift_in_count == (SPI_CONTROLLER_REG_SIZE + ecc_count))) {
> +                    SPI_DEBUG(qemu_log("Discarding rx N1 ECC byte = 0x%2.2x at "
> +                           "payload index = %d\n", read_buf[0], n1_count));
> +                    shift_in_count = 0;
> +                } else { > +                    uint8_t n1_byte = 0x00;

no need to initialize it since you assign it immediately read_buf[0].

> +                    n1_byte = read_buf[0];
> +                    SPI_DEBUG(qemu_log("Extracting rx n1_byte = 0x%2.2x from "
> +                            "payload at index = %d\n", n1_byte, n1_count));
> +                    if (sc->reverse_bits) {
> +                        SPI_DEBUG(qemu_log("Reversing bit order of rx "
> +                                            "n1_byte\n"));
> +                        n1_byte = reverse_bits8(n1_byte);
> +                    }
> +                    SPI_DEBUG(qemu_log("Shifting rx N1 byte = 0x%2.2x into "
> +                                   "RDR\n", n1_byte));
> +                    shift_byte_in(sc, n1_byte);
> +                }
> +                n1_count++;
> +            } /* end of while */
> +        }
> +        /* Handle the N2 portion of the frame */
> +        if (sc->N2_rx != 0) {
> +            uint8_t n2_count = 0;
> +            while (n2_count < sc->N2_bytes) {
> +                shift_in_count++;
> +                xfer_buffer_read_ptr(rsp_payload, &read_buf,
> +                                (sc->N1_bytes + n2_count), 1);

Could you not move this outside the loop :

xfer_buffer_read_ptr(rsp_payload, &read_buf, sc->N1_bytes, sc->N2_bytes);

Same in the n1 loop above. And then you could think of creating a 
function for what seems to be almost duplicate code for the n1 and n2 loops.

> +                if ((ecc_count != 0) &&
> +                    (shift_in_count == (SPI_CONTROLLER_REG_SIZE + ecc_count))) {
> +                    SPI_DEBUG(qemu_log("Discarding rx N1 ECC byte = 0x%2.2x at "
> +                           "payload index = %d\n", read_buf[0],
> +                           (sc->N1_bytes + n2_count)));
> +                    shift_in_count = 0;
> +                } else {
> +                    /*
> +                     * The code handles shifting data from the payload received
> +                     * from the responder into the responder's RDR.  Since this
> +                     * is an N2 frame segment it is safe to assume that there
> +                     * was a preceding N1 segment which was combined with an N2
> +                     * segment to create a single frame. The response data will
> +                     * then have N1_bytes of data in the payload representing a
> +                     * responder response to the N1 section of the frame. If N2
> +                     * is set to receive the shifting for N2 data begins after
> +                     * the N1 bytes regardless of whether or not N1 was marked
> +                     * for transmit or receive.
> +                     */
> +                    uint8_t n2_byte = 0x00;

same comment as above

> +                    n2_byte = read_buf[0];
> +                    SPI_DEBUG(qemu_log("Extracting rx n2_byte = 0x%2.2x from "
> +                            "payload at index = %d\n", n2_byte,
> +                            (sc->N1_bytes + n2_count)));
> +                    if (sc->reverse_bits) {
> +                        SPI_DEBUG(qemu_log("Reversing bit order of rx "
> +                                            "n2_byte\n"));
> +                        n2_byte = reverse_bits8(n2_byte);
> +                    }
> +                    SPI_DEBUG(qemu_log("Shifting rx N2 byte = 0x%2.2x into "
> +                              "RDR\n", n2_byte));
> +                    shift_byte_in(sc, n2_byte);
> +                }
> +                n2_count++;
> +            }
> +        }
> +        if ((sc->N1_rx + sc->N2_rx) > 0) {
> +            /*
> +             * Data was received so handle RDR status.
> +             * It is easier to handle RDR_full and RDR_overrun status here
> +             * since the RDR register's shift_byte_in method is called
> +             * multiple times in a row. Controlling RDR status is done here
> +             * instead of in the RDR scoped methods for that reason.
> +             */
> +            if (GETFIELD(STATUS_REG_RDR_FULL, sc->status_reg) == 1) {
> +                /*
> +                 * Data was shifted into the RDR before having been read
> +                 * causing previous data to have been overrun.
> +                 */
> +                sc->status_reg = SETFIELD(STATUS_REG_RDR_OVERRUN,
> +                                sc->status_reg, 1);
> +            } else {
> +                /*
> +                 * Set status to indicate that the received data register is
> +                 * full. This flag is only cleared once the RDR is unloaded.
> +                 */
> +                sc->status_reg = SETFIELD(STATUS_REG_RDR_FULL,
> +                                sc->status_reg, 1);
> +                SPI_DEBUG(qemu_log("RDR_full set to 1\n"));
> +            }
> +        }
> +    } /* end of else */
> +} /* end of spi_response() */
> +
> +void log_all_N_counts(PnvSpiController *sc)
> +{
> +    SPI_DEBUG(qemu_log("N1_bits = %d, N1_bytes = %d, N1_tx = %d, N1_rx = %d, "
> +          "N2_bits = %d, N2_bytes = %d, N2_tx = %d, N2_rx = %d\n",
> +           sc->N1_bits, sc->N1_bytes, sc->N1_tx, sc->N1_rx, sc->N2_bits,
> +           sc->N2_bytes, sc->N2_tx, sc->N2_rx));
> +}
> +
> +void operation_sequencer(PnvSpiController *sc)

All function namees in this file should have a prefix I would say.

> +{
> +    /*
> +     * Loop through each sequencer operation ID and perform the requested
> +     *  operations.
> +     * Flag for indicating if we should send the N1 frame or wait to combine
> +     * it with a preceding N2 frame.
> +     */
> +    bool send_n1_alone = true;
> +    /* Flag to stop the sequencer */
> +    bool stop = false;
> +
> +    /*
> +     * xfer_buffer for containing the payload of the SPI frame.
> +     * This is a static because there are cases where a sequence has to stop
> +     * and wait for the target application to unload the RDR.  If this occurs
> +     * during a sequence where N1 is not sent alone and instead combined with
> +     * N2 since the N1 tx length + the N2 tx length is less than the size of
> +     * the TDR.
> +     */
> +    static xfer_buffer *payload;
> +    if (payload == NULL) {
> +        payload = xfer_buffer_new();
> +    }
> +    /*
> +     * Clear the sequencer FSM error bit - general_SPI_status[3]
> +     * before starting a sequence.
> +     */
> +    sc->status_reg = SETFIELD(PPC_BIT(35), sc->status_reg, 0);
> +    /*
> +     * If the FSM is idle set the sequencer index to 0
> +     * (new/restarted sequence)
> +     */
> +    if (GETFIELD(STATUS_REG_SEQUENCER_FSM, sc->status_reg) ==
> +                    SEQ_STATE_IDLE) {
> +        sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                  sc->status_reg, 0);
> +    }
> +    /*
> +     * There are only 8 possible operation IDs to iterate through though
> +     * some operations may cause more than one frame to be sequenced.
> +     */
> +    while (GETFIELD(STATUS_REG_SEQUENCER_INDEX, sc->status_reg) < 8) {
> +        uint8_t opcode = 0;

no need to assign a value.

> +        uint8_t masked_opcode = 0;
> +
> +        opcode = sc->sequencer_operation_reg[GETFIELD(
> +                        STATUS_REG_SEQUENCER_INDEX, sc->status_reg)];
> +        /* Set sequencer state to decode */
> +        sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM, sc->status_reg,
> +                                  SEQ_STATE_DECODE);
> +        /*
> +         * Only the upper nibble of the operation ID is needed to know what
> +         * kind of operation is requested.
> +         */
> +        masked_opcode = opcode & 0xF0;
> +        switch (masked_opcode) {
> +        /*
> +         * Increment the operation index in each case instead of just
> +         * once at the end in case an operation like the branch
> +         * operation needs to change the index.
> +         */
> +        case SEQ_OP_STOP:
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg, SEQ_STATE_EXECUTE);
> +            /* A stop operation in any position stops the sequencer */
> +            SPI_DEBUG(qemu_log("Sequencer STOP at index = 0x%llx, sequencer "
> +                               "idling\n", GETFIELD(
> +                               STATUS_REG_SEQUENCER_INDEX,
> +                               sc->status_reg)));
> +            stop = true;
> +            sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM, sc->status_reg,
> +                                          FSM_IDLE);
> +            sc->loop_counter_1 = 0;
> +            sc->loop_counter_2 = 0;
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg, SEQ_STATE_IDLE);
> +            break;
> +
> +        case SEQ_OP_SELECT_SLAVE:
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg, SEQ_STATE_EXECUTE);
> +            SPI_DEBUG(qemu_log("Sequencer SELECT_SLAVE at index = 0x%llx\n",
> +                GETFIELD(STATUS_REG_SEQUENCER_INDEX, sc->status_reg)));
> +            /*
> +             * This device currently only supports a single responder
> +             * connection at position 0.  De-selecting a responder is fine
> +             * and expected at the end of a sequence but selecting any
> +             * responder other than 0 should cause an error.
> +             */
> +            sc->responder_select = opcode & 0x0F;
> +            if (sc->responder_select == 0) {
> +                if (spi_disconnect_controller(sc->spi_bus)) {
> +                    SPI_DEBUG(qemu_log("Slave (present) de-selected, "
> +                                       "shifter done\n"));
> +                } else {
> +                   SPI_DEBUG(qemu_log("Slave (not-present) de-selected "
> +                                      "(no-op), shifter done\n"));
> +                }
> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                          sc->status_reg,
> +                                          (GETFIELD(
> +                                          STATUS_REG_SEQUENCER_INDEX,
> +                                          sc->status_reg) + 1));
> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                          sc->status_reg, FSM_DONE);
> +            } else if (sc->responder_select != 1) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
> +                              "not supported, select = 0x%x\n",
> +                               sc->responder_select);

Does this mean that the SPI controller can only support 1 slave?
what is responed_select = 1 -- some kind of slave id?

> +                SPI_DEBUG(qemu_log("Sequencer stop requested due to invalid "
> +                                        "responder select at index = 0x%llx, "
> +                                   "shifter idling\n", GETFIELD(
> +                                   STATUS_REG_SEQUENCER_INDEX,
> +                                   sc->status_reg)));
> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                          sc->status_reg, FSM_IDLE);
> +                stop = true;
> +            } else {
> +                /*
> +                 * Only allow an FSM_START state when a responder is
> +                 * selected
> +                 */
> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                          sc->status_reg, FSM_START);
> +                if (spi_connect_controller(sc->spi_bus, NULL)) {

My guess is sc->responder_select should be passed to the 
spi_connect_controller(). I am not much familiar with SPI but do you 
need an explicit connection or should it not rather be a lookup whether 
a slave with the given id is registered/available?

> +                    SPI_DEBUG(qemu_log("Slave 0x%x (present) selected, "
> +                                       "shifter starting\n",
> +                                       sc->responder_select));
> +                } else {
> +                    SPI_DEBUG(qemu_log("Slave 0x%x (not-present) selected "
> +                                        "(no-op), shifter starting\n",
> +                                       sc->responder_select));
> +                }
> +                sc->first = 1;
> +                sc->last = 0;
> +                /*
> +                 * A Shift_N2 operation is only valid after a Shift_N1. We
> +		 * will track the occurrence of a Shift_N1 to enforce this
> +		 * requirement in the most generic way possible by assuming
> +		 * that the rule applies once a valid responder select has
> +		 * occurred.

Indentation.

> +                 */
> +                sc->shift_n1_done = false;
> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                          sc->status_reg,
> +                                          SEQ_STATE_INDEX_INCREMENT);
> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                          sc->status_reg,
> +                                (GETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                          sc->status_reg) + 1));
> +            }
> +            break;
> +
> +        case SEQ_OP_SHIFT_N1:
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg, SEQ_STATE_EXECUTE);
> +            SPI_DEBUG(qemu_log("Sequencer SHIFT_N1 at index = 0x%llx\n",
> +                GETFIELD(STATUS_REG_SEQUENCER_INDEX, sc->status_reg)));
> +            /*
> +             * Only allow a shift_n1 when the state is not IDLE or DONE.
> +             * In either of those two cases the sequencer is not in a proper
> +             * state to perform shift operations because the sequencer has:
> +             * - processed a responder deselect (DONE)
> +             * - processed a stop opcode (IDLE)
> +             * - encountered an error (IDLE)
> +             */
> +            if ((GETFIELD(STATUS_REG_SHIFTER_FSM,
> +                               sc->status_reg) == FSM_IDLE) ||
> +                (GETFIELD(STATUS_REG_SHIFTER_FSM,
> +                               sc->status_reg) == FSM_DONE)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N1 not allowed in "
> +                              "shifter state = 0x%llx", GETFIELD(
> +                        STATUS_REG_SHIFTER_FSM, sc->status_reg));
> +                /*
> +                 * Set sequencer FSM error bit 3 (general_SPI_status[3])
> +                 * in status reg.
> +                 */
> +                sc->status_reg = SETFIELD(PPC_BIT(35), sc->status_reg, 1);
> +                SPI_DEBUG(qemu_log("Sequencer stop requested due to invalid "
> +                      "shifter state at index = 0x%llx\n", GETFIELD(
> +                         STATUS_REG_SEQUENCER_INDEX, sc->status_reg)));
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
> +                if ((sc->sequencer_operation_reg[GETFIELD(
> +                     STATUS_REG_SEQUENCER_INDEX, sc->status_reg) + 1] & 0xF0)
> +                                == SEQ_OP_SHIFT_N2) {
> +                    SPI_DEBUG(qemu_log("Not sending N1 alone\n"));
> +                    send_n1_alone = false;
> +                }
> +                /*
> +                 * If the next opcode is 0x10, which deselects the SPI device
> +                 * then this is the last shift
> +                 */
> +                if (sc->sequencer_operation_reg[GETFIELD(
> +                    STATUS_REG_SEQUENCER_INDEX, sc->status_reg) + 1] ==
> +                                SEQ_OP_SELECT_SLAVE) {
> +                    sc->last = 1;
> +                }
> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                sc->status_reg, FSM_SHIFT_N1);
> +                stop = operation_shiftn1(sc, opcode, &payload, send_n1_alone);
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
> +                    if (GETFIELD(STATUS_REG_TDR_UNDERRUN, sc->status_reg)) {
> +                        SPI_DEBUG(qemu_log("Sequencer stop requested due to N2 "
> +                              "counter reload active.\n"));
> +                        sc->shift_n1_done = true;
> +                        sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                                  sc->status_reg,
> +                                                  FSM_SHIFT_N2);
> +                        sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                                  sc->status_reg,
> +                                                  (GETFIELD(
> +                                                  STATUS_REG_SEQUENCER_INDEX,
> +                                                  sc->status_reg) + 1));
> +                        SPI_DEBUG(qemu_log("Set new sequencer index to = "
> +                                           "0x%llx\n", GETFIELD(
> +                                           STATUS_REG_SEQUENCER_INDEX,
> +                                           sc->status_reg)));
> +                    } else {
> +                        /*
> +                         * This is case (1) or (2) so the sequencer needs to
> +                         * wait and NOT go to the next sequence yet.
> +                         */
> +                        sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                                  sc->status_reg, FSM_WAIT);
> +                    }
> +                } else {
> +                    /* Ok to move on to the next index */
> +                    sc->shift_n1_done = true;
> +                    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                sc->status_reg, SEQ_STATE_INDEX_INCREMENT);
> +                    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                              sc->status_reg,
> +                                              (GETFIELD(
> +                                              STATUS_REG_SEQUENCER_INDEX,
> +                                              sc->status_reg) + 1));
> +                }
> +            }
> +            break;
> +
> +        case SEQ_OP_SHIFT_N2:
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg, SEQ_STATE_EXECUTE);
> +            SPI_DEBUG(qemu_log("Sequencer SHIFT_N2 at index = %lld\n",
> +                                GETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                         sc->status_reg)));
> +            if (!sc->shift_n1_done) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not allowed if a "
> +                              "Shift_N1 is not done, shifter state = 0x%llx",
> +                              GETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                       sc->status_reg));
> +                /*
> +                 * In case the sequencer actually stops if an N2 shift is
> +                 * requested before any N1 shift is done. Set sequencer FSM
> +                 * error bit 3 (general_SPI_status[3]) in status reg.
> +                 */
> +                sc->status_reg = SETFIELD(PPC_BIT(35), sc->status_reg, 1);
> +                SPI_DEBUG(qemu_log("Sequencer stop requested due to shift_n2 "
> +                                    "w/no shift_n1 done at index = 0x%llx\n",
> +                                   GETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                            sc->status_reg)));
> +                stop = true;
> +            } else {
> +                /*
> +                 * If the next opcode is 0x10, which deselects the SPI device

... is SEQ_OP_SELECT_SLAVE (0x10), which ...

> +                 * then this is the last shift
> +                 */
> +                if (sc->sequencer_operation_reg[GETFIELD(
> +                    STATUS_REG_SEQUENCER_INDEX,
> +                    sc->status_reg) + 1] == SEQ_OP_SELECT_SLAVE) {
> +                    sc->last = 1;
> +                }
> +                /* Ok to do a Shift_N2 */
> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                          sc->status_reg, FSM_SHIFT_N2);
> +                stop = operation_shiftn2(sc, opcode, &payload);
> +                /*
> +                 * If the operation code says to stop set the shifter state to
> +                 * wait and stop
> +                 */
> +                if (stop) {
> +                    sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                              sc->status_reg, FSM_WAIT);
> +                } else {
> +                    /* Ok to move on to the next index */
> +                    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                              sc->status_reg,
> +                                              SEQ_STATE_INDEX_INCREMENT);
> +                    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                              sc->status_reg,
> +                                              (GETFIELD(
> +                                              STATUS_REG_SEQUENCER_INDEX,
> +                                              sc->status_reg) + 1));

This sequence seems to appear multiple times. Put into 'a function'.


> +                }
> +            }
> +            break;
> +
> +        case SEQ_OP_BRANCH_IFNEQ_RDR:
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg, SEQ_STATE_EXECUTE);
> +            SPI_DEBUG(qemu_log("Sequencer BRANCH_IFNEQ_RDR at "
> +                               "index = 0x%llx\n", GETFIELD(
> +                               STATUS_REG_SEQUENCER_INDEX, sc->status_reg)));
> +            /*
> +             * The memory mapping register RDR match value is compared against
> +             * the 16 rightmost bytes of the RDR (potentially with masking).
> +             * Since this comparison is performed against the contents of the
> +             * RDR then a receive must have previously occurred otherwise
> +             * there is no data to compare and the operation cannot be
> +             * completed and will stop the sequencer until RDR full is set to
> +             * 1.
> +             */
> +            if (GETFIELD(STATUS_REG_RDR_FULL, sc->status_reg) == 1) {
> +                bool rdr_matched = false;
> +                rdr_matched = does_rdr_match(sc);
> +                if (rdr_matched) {
> +                    SPI_DEBUG(qemu_log("Proceed to next sequencer index "
> +                                   "(increment on RDR match)\n"));
> +                    /* A match occurred, increment the sequencer index. */
> +                    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                              sc->status_reg,
> +                                              SEQ_STATE_INDEX_INCREMENT);
> +                    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                              sc->status_reg,
> +                                              (GETFIELD(
> +                                              STATUS_REG_SEQUENCER_INDEX,
> +                                              sc->status_reg) + 1));

... call 'the function'

> +                } else {
> +                    SPI_DEBUG(qemu_log("Proceed to sequencer index=0x%x "
> +                          "(branch on RDR match fail)\n", (opcode & 0x7)));
> +                    /*
> +                     * Branch the sequencer to the index coded into the op
> +                     * code.
> +                     */
> +                    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                              sc->status_reg, (opcode & 0x7));
> +                }
> +                /*
> +                 * Regardless of where the branch ended up we want the
> +                 * sequencer to continue shifting so we have to clear
> +                 * RDR_full.
> +                 */
> +                sc->status_reg = SETFIELD(STATUS_REG_RDR_FULL,
> +                                sc->status_reg, 0);
> +            } else {
> +                SPI_DEBUG(qemu_log("RDR not full for 0x6x opcode! Stopping "
> +                      "sequencer.\n"));
> +                stop = true;
> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
> +                                         sc->status_reg, FSM_WAIT);
> +            }
> +            break;
> +
> +        case SEQ_OP_TRANSFER_TDR:
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg, SEQ_STATE_EXECUTE);
> +            qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not supported\n");
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg,
> +                                      SEQ_STATE_INDEX_INCREMENT);
> +            /* status_reg.sequencer_index++ */
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                      sc->status_reg,
> +                                      (GETFIELD(
> +                                      STATUS_REG_SEQUENCER_INDEX, > +                                      sc->status_reg) + 1));

... again

> +            break;
> +
> +        case SEQ_OP_BRANCH_IFNEQ_INC_1:
> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                      sc->status_reg, SEQ_STATE_EXECUTE);
> +            SPI_DEBUG(qemu_log("Sequencer BRANCH_IFNEQ_INC_1 at index = "
> +                               "0x%llx, next index = %d, count_compare_1 = "
> +                               "0x%llx, loop_counter_1 = %d\n", GETFIELD(
> +                               STATUS_REG_SEQUENCER_INDEX, sc->status_reg),
> +                               (opcode & 0x07),
> +                  GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE1,
> +                  sc->status_reg), sc->loop_counter_1));
> +            if (sc->loop_counter_1 !=
> +                GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE1,
> +                                sc->counter_config_reg)) {
> +                /*
> +                 * If the next opcode is 0x10, which deselects the SPI device
> +                 * and we know that the next opcode is the last one in the
> +                 * loop then the next shift is the last shift
> +                 */
> +                uint8_t condition1 = sc->sequencer_operation_reg[
> +                                     GETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                     sc->status_reg) + 1];
> +                uint8_t condition2 =
> +                        GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE1,
> +                                 sc->counter_config_reg);
> +                if ((condition1 == SEQ_OP_SELECT_SLAVE) &&
> +                    ((sc->loop_counter_1 + 1) == condition2)) {
> +                    sc->last = 1;
> +                }
> +                /*
> +                 * Next index is the lower nibble of the branch operation ID,
> +                 * mask off all but the first three bits so we don't try to
> +                 * access beyond the sequencer_operation_reg boundary.
> +                 */
> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                          sc->status_reg, (opcode & 0x7));
> +                sc->loop_counter_1++;
> +                SPI_DEBUG(qemu_log("Branching to index = %d, loop_counter_1 = "
> +                      "%d\n", (opcode & 0x7), sc->loop_counter_1));
> +            } else {
> +                /* Continue to next index if loop counter is reached */
> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
> +                                          sc->status_reg,
> +                                          SEQ_STATE_INDEX_INCREMENT);
> +                /* status_reg.sequencer_index++ */
> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
> +                                          sc->status_reg,
> +                                          (GETFIELD(
> +                                          STATUS_REG_SEQUENCER_INDEX,
> +                                          sc->status_reg) + 1));

.. and again.


That's how far I got for now. I think it will take multiple passes and 
others will have yet other comments on the code.

    Stefan

