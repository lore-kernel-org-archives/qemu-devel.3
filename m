Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ACEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 17:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwmId-0005Jn-3y; Tue, 16 Apr 2024 13:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rwmIa-0005JJ-OL; Tue, 16 Apr 2024 13:08:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rwmIU-0003GL-V5; Tue, 16 Apr 2024 13:08:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43GH3nlW022135; Tue, 16 Apr 2024 17:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HGnB352iuv5rFMY8311Z1I9fJhkq9AOH3y0eAZpD6eM=;
 b=Wpukv10LraRY+trLRCLlU+SOGg06R3rGhRRHth2uijMbQUB5z+OqiyxuT/iaME3rSbfM
 WjB1rKKgbSFztrzDkX1wQHr8zOLTlbE6LWZQwjbsAV8ca16KzkstMzT7HFoPirDxPACk
 S1OPau0/gXewKr9y/DknL+ICmVOrWCabF/TXskuW4W8kuN0gcOZZrsr3r/fB/7pKxtz0
 0mafQ65OAwV8gMoJYNXkNUTIu/Pwi+L3DMwnlQyEotHGZ72GVb54/FHIZcQbn1O+vfGj
 56ZO3Dg54qIqeORjVglqHRxXf1BH1RTPQ/TRIdEHcGEZHmBe3lsKtzyqs+ZAsxBhbiQZ Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhwcu80gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 17:08:38 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GH8c8a028881;
 Tue, 16 Apr 2024 17:08:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhwcu80gp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 17:08:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43GFMhoo023576; Tue, 16 Apr 2024 17:08:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnyd8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 17:08:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43GH8X3N9306616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 17:08:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B49820043;
 Tue, 16 Apr 2024 17:08:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D94F120040;
 Tue, 16 Apr 2024 17:08:29 +0000 (GMT)
Received: from [9.43.21.204] (unknown [9.43.21.204])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 17:08:29 +0000 (GMT)
Message-ID: <dfe3ef32-3dab-4559-a873-c25266db8bac@linux.ibm.com>
Date: Tue, 16 Apr 2024 22:38:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/ppc: SPI controller model - sequencer and
 shifter
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com
References: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
 <20240409175700.27535-4-chalapathi.v@linux.ibm.com>
 <d41c21ae-cf32-415d-94bb-694c8e47d0f4@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <d41c21ae-cf32-415d-94bb-694c8e47d0f4@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1U0jO98_ram0FpMcyMtwdRnldsDBI_K2
X-Proofpoint-GUID: d9fIrK_d3oEEPyI3gtQycKrRGrybLjtt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160106
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 16-04-2024 15:09, Cédric Le Goater wrote:
> Hello,
>
> Please rephrase the subject to something like:
>
>   "ppc/pnv: Extend SPI model ..."
>
> Using a verb is preferable.
Sure. Will update. Thank You.
>
> On 4/9/24 19:56, Chalapathi V wrote:
>> In this commit SPI shift engine and sequencer logic is implemented.
>> Shift engine performs serialization and de-serialization according to 
>> the
>> control by the sequencer and according to the setup defined in the
>> configuration registers. Sequencer implements the main control logic and
>> FSM to handle data transmit and data receive control of the shift 
>> engine.
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   include/hw/ppc/pnv_spi_controller.h |   72 ++
>>   hw/ppc/pnv_spi_controller.c         | 1311 ++++++++++++++++++++++++++-
>>   2 files changed, 1382 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/pnv_spi_controller.h 
>> b/include/hw/ppc/pnv_spi_controller.h
>> index 5ec50fb14c..ee8e7a17da 100644
>> --- a/include/hw/ppc/pnv_spi_controller.h
>> +++ b/include/hw/ppc/pnv_spi_controller.h
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
>>   #include "hw/ssi/ssi.h"
>>   @@ -21,6 +29,7 @@
>>   #define SPI_CONTROLLER_REG_SIZE 8
>>     typedef struct SSIBus SSIBus;
>> +typedef struct xfer_buffer xfer_buffer;
>
> Please use CamelCase names for typedef. The forward declaration doesn't
> seem useful.
Sure. Will remove and test.
>
>>   #define TYPE_PNV_SPI_BUS "pnv-spi-bus"
>>   OBJECT_DECLARE_SIMPLE_TYPE(PnvSPIBus, PNV_SPI_BUS)
>> @@ -33,6 +42,21 @@ typedef struct PnvSPIBus {
>>       uint32_t id;
>>   } PnvSPIBus;
>>   +/* xfer_buffer */
>> +typedef struct xfer_buffer {
>> +
>> +    uint32_t    len;
>> +    uint8_t    *data;
>> +
>> +} xfer_buffer;
>> +
>> +uint8_t *xfer_buffer_write_ptr(xfer_buffer *payload, uint32_t offset,
>> +                uint32_t length);
>> +void xfer_buffer_read_ptr(xfer_buffer *payload, uint8_t **read_buf,
>> +                uint32_t offset, uint32_t length);
>> +xfer_buffer *xfer_buffer_new(void);
>> +void xfer_buffer_free(xfer_buffer *payload);
>> +
>
> I don't think these helper routines need to be defined in the header file
> of the PnvPsi model. They look internal to me.
Sure. Will move them.
>
>>   typedef struct PnvSpiController {
>>       DeviceState parent;
>>   @@ -40,6 +64,39 @@ typedef struct PnvSpiController {
>>       MemoryRegion    xscom_spic_regs;
>>       /* SPI controller object number */
>>       uint32_t        spic_num;
>> +    uint8_t         responder_select;
>> +    /* To verify if shift_n1 happens prior to shift_n2 */
>> +    bool            shift_n1_done;
>> +    /*
>> +     * Internal flags for the first and last indicators for the SPI
>> +     * interface methods
>> +     */
>> +    uint8_t         first;
>> +    uint8_t         last;
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
>> +    /*
>> +     * Setting this attribute to true will cause the engine to 
>> reverse the
>> +     * bit order of each byte it appends to a payload before sending 
>> the
>> +     * payload to a device. There may be cases where an end device 
>> expects
>> +     * a reversed order, like in the case of the Nuvoton TPM device. 
>> The
>> +     * order of bytes in the payload is not reversed, only the order 
>> of the
>> +     * 8 bits in each payload byte.
>> +     */
>> +    bool            reverse_bits;
>>         /* SPI Controller registers */
>>       uint64_t        error_reg;
>> @@ -52,4 +109,19 @@ typedef struct PnvSpiController {
>>       uint8_t sequencer_operation_reg[SPI_CONTROLLER_REG_SIZE];
>>       uint64_t        status_reg;
>>   } PnvSpiController;
>> +
>> +void log_all_N_counts(PnvSpiController *spi_controller);
>> +void spi_response(PnvSpiController *spi_controller, int bits,
>> +                xfer_buffer *rsp_payload);
>> +void operation_sequencer(PnvSpiController *spi_controller);
>> +bool operation_shiftn1(PnvSpiController *spi_controller, uint8_t 
>> opcode,
>> +                       xfer_buffer **payload, bool send_n1_alone);
>> +bool operation_shiftn2(PnvSpiController *spi_controller, uint8_t 
>> opcode,
>> +                       xfer_buffer **payload);
>> +bool does_rdr_match(PnvSpiController *spi_controller);
>> +uint8_t get_from_offset(PnvSpiController *spi_controller, uint8_t 
>> offset);
>> +void shift_byte_in(PnvSpiController *spi_controller, uint8_t byte);
>> +void calculate_N1(PnvSpiController *spi_controller, uint8_t opcode);
>> +void calculate_N2(PnvSpiController *spi_controller, uint8_t opcode);
>> +uint8_t reverse_bits8(uint8_t x);
>
> These routines are internal and belong to hw/ppc/pnv_spi_controller.c. 
> Please
> don't export them. Also, adding a pnv_psi_ prefix would be a plus to 
> identify
> the sympbols.
Will move them to pnv_spi_controller.c. Thank You.
>
>
>>   #endif /* PPC_PNV_SPI_CONTROLLER_H */
>> diff --git a/hw/ppc/pnv_spi_controller.c b/hw/ppc/pnv_spi_controller.c
>> index e2478a47f2..afe7f17565 100644
>> --- a/hw/ppc/pnv_spi_controller.c
>> +++ b/hw/ppc/pnv_spi_controller.c
>> @@ -52,6 +52,11 @@ static uint64_t pnv_spi_controller_read(void 
>> *opaque, hwaddr addr,
>>                              val));
>>           sc->status_reg = SETFIELD(STATUS_REG_RDR_FULL, 
>> sc->status_reg, 0);
>>           SPI_DEBUG(qemu_log("RDR being read, RDR_full set to 0\n"));
>> +        if (GETFIELD(STATUS_REG_SHIFTER_FSM, sc->status_reg) == 
>> FSM_WAIT) {
>> +            SPI_DEBUG(qemu_log("RDR being read while shifter is 
>> waiting, "
>> +                           "starting sequencer\n"));
>
> Please use trace events instead.
Sure, will update.
>
>> +            operation_sequencer(sc);
>> +        }
>>           break;
>>       case SEQUENCER_OPERATION_REG:
>>           val = 0;
>> @@ -124,13 +129,15 @@ static void pnv_spi_controller_write(void 
>> *opaque, hwaddr addr,
>>           sc->status_reg = SETFIELD(STATUS_REG_TDR_UNDERRUN, 
>> sc->status_reg, 0);
>>           SPI_DEBUG(qemu_log("TDR being written, TDR_underrun set to 
>> 0\n"));
>>           SPI_DEBUG(qemu_log("TDR being written, starting 
>> sequencer\n"));
>> +        operation_sequencer(sc);
>> +
>>           break;
>>       case RECEIVE_DATA_REG:
>>           sc->receive_data_reg = val;
>>           break;
>>       case SEQUENCER_OPERATION_REG:
>>           for (int i = 0; i < SPI_CONTROLLER_REG_SIZE; i++) {
>> -        sc->sequencer_operation_reg[i] = (val >> (56 - i * 8)) & 0xFF;
>> +            sc->sequencer_operation_reg[i] = (val >> (56 - i * 8)) & 
>> 0xFF;
>
> This change belongs to the previous patch.
Yes, Thank you for catching. will update in v3.
>
>>           }
>>           break;
>>       case STATUS_REG:
>> @@ -157,6 +164,1306 @@ static const MemoryRegionOps 
>> pnv_spi_controller_xscom_ops = {
>>       .endianness = DEVICE_BIG_ENDIAN,
>>   };
>>   +/* xfer_buffer_methods */
>> +xfer_buffer *xfer_buffer_new(void)
>> +{
>> +    xfer_buffer *payload = g_malloc0(sizeof(*payload));
>> +
>> +    payload->data = g_malloc0(payload->len);
>
> euh. payload->len is 0. This allocation is pointless.
>
>> +    return payload;
>> +}
>> +
>> +void xfer_buffer_free(xfer_buffer *payload)
>> +{
>> +    free(payload->data);
>> +    free(payload);
>> +}
>> +
>> +uint8_t *xfer_buffer_write_ptr(xfer_buffer *payload, uint32_t offset,
>> +                            uint32_t length)
>> +{
>> +    if (payload->len < (offset + length)) {
>> +        payload->len = offset + length;
>> +        payload->data = g_realloc(payload->data, payload->len);
>> +    }
>> +    return &payload->data[offset];
>> +}
>> +
>> +void xfer_buffer_read_ptr(xfer_buffer *payload, uint8_t **read_buf,
>> +                uint32_t offset, uint32_t length)
>> +{
>> +    static uint32_t prev_len;
>> +    if ((prev_len != length) || (*read_buf == NULL)) {
>> +        *read_buf = g_realloc(*read_buf, length);
>> +        prev_len = length;
>> +    }
>> +    if (offset > payload->len) {
>> +        /* Reading outside payload, just return */
>> +        return;
>> +    }
>> +    *read_buf = &payload->data[offset];
>> +}
>
> Isn't there a maximum buffer size ? It would simplify the implementation
> and avoid all these alloc/realloc/free calls.
Will check and rework on this. Thank You.
>
>> +uint8_t reverse_bits8(uint8_t x)
>> +{
>> +    x = (x << 4) | (x >> 4);
>> +    x = ((x & 0x33) << 2) | ((x & 0xcc) >> 2);
>> +    x = ((x & 0x55) << 1) | ((x & 0xaa) >> 1);
>> +    return x;
>> +}
>
> revbit8() in qemu/host-utils.h should do the same.
>
> The rest is difficult to comment on without an intimitate knowledge of
> the controller and the datasheet. Can teammates help ?
>
> Thanks,
>
> C.
>
>
>
>> +bool does_rdr_match(PnvSpiController *sc)
>> +{
>> +    /*
>> +     * According to spec, the mask bits that are 0 are compared and the
>> +     * bits that are 1 are ignored.
>> +     */
>> +    uint16_t rdr_match_mask = 
>> GETFIELD(MEMORY_MAPPING_REG_RDR_MATCH_MASK,
>> + sc->memory_mapping_reg);
>> +    uint16_t rdr_match_val = GETFIELD(MEMORY_MAPPING_REG_RDR_MATCH_VAL,
>> + sc->memory_mapping_reg);
>> +    if ((~rdr_match_mask & rdr_match_val) == ((~rdr_match_mask) &
>> +            GETFIELD(PPC_BITMASK(48, 63), sc->receive_data_reg))) {
>> +        SPI_DEBUG(qemu_log("RDR match successful, match=0x%4.4x, "
>> +                                 "mask=0x%4.4x, 
>> RDR[48:63]=0x%4.4llx\n",
>> +                           rdr_match_val, rdr_match_mask,
>> +                                  GETFIELD(PPC_BITMASK(48, 63),
>> +                                   sc->receive_data_reg)));
>> +        return true;
>> +    } else {
>> +        SPI_DEBUG(qemu_log("RDR match failed, match=0x%4.4x, 
>> mask=0x%4.4x, "
>> +              "RDR[48:63]=0x%4.4llx\n", rdr_match_val, rdr_match_mask,
>> +               GETFIELD(PPC_BITMASK(48, 63), sc->receive_data_reg)));
>> +        return false;
>> +    }
>> +}
>> +
>> +uint8_t get_from_offset(PnvSpiController *sc, uint8_t offset)
>> +{
>> +    uint8_t byte;
>> +
>> +    /*
>> +     * Offset is an index between 0 and SPI_CONTROLLER_REG_SIZE - 1
>> +     * Check the offset before using it.
>> +     */
>> +    if (offset < SPI_CONTROLLER_REG_SIZE) {
>> +        byte = (sc->transmit_data_reg >> (56 - offset * 8)) & 0xFF;
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
>> +void shift_byte_in(PnvSpiController *sc, uint8_t byte)
>> +{
>> +    sc->receive_data_reg = (sc->receive_data_reg << 8) | byte;
>> +    SPI_DEBUG(qemu_log("0x%2.2x shifted in, RDR now = 0x%16.16lx\n", 
>> byte,
>> +                    sc->receive_data_reg));
>> +}
>> +
>> +void spi_response(PnvSpiController *sc, int bits, xfer_buffer 
>> *rsp_payload)
>> +{
>> +    uint8_t *read_buf = NULL;
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
>> +    if (rsp_payload->len != (sc->N1_bytes + sc->N2_bytes)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid response payload 
>> size in "
>> +                       "bytes, expected %d, got %d\n",
>> +                       (sc->N1_bytes + sc->N2_bytes), 
>> rsp_payload->len);
>> +    } else {
>> +        uint8_t ecc_control;
>> +        SPI_DEBUG(qemu_log("SPI response received, payload len = %d\n",
>> +                       rsp_payload->len));
>> +        log_all_N_counts(sc);
>> +        /*
>> +         * Adding an ECC count let's us know when we have found a 
>> payload byte
>> +         * that was shifted in but cannot be loaded into RDR. Bits 
>> 29-30
>> +         * equal to either 0b00 or 0b10 indicate that we are taking 
>> in data
>> +         * with ECC and either applying the ECC or discarding it.
>> +         */
>> +        ecc_count = 0;
>> +        ecc_control = GETFIELD(PPC_BITMASK(29, 30),
>> + sc->clock_config_reset_control);
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
>> +        if (sc->N1_rx != 0) {
>> +            uint8_t n1_count = 0;
>> +            while (n1_count < sc->N1_bytes) {
>> +                shift_in_count++;
>> +                xfer_buffer_read_ptr(rsp_payload, &read_buf, 
>> n1_count, 1);
>> +                if ((ecc_count != 0) &&
>> +                    (shift_in_count == (SPI_CONTROLLER_REG_SIZE + 
>> ecc_count))) {
>> +                    SPI_DEBUG(qemu_log("Discarding rx N1 ECC byte = 
>> 0x%2.2x at "
>> +                           "payload index = %d\n", read_buf[0], 
>> n1_count));
>> +                    shift_in_count = 0;
>> +                } else {
>> +                    uint8_t n1_byte = 0x00;
>> +                    n1_byte = read_buf[0];
>> +                    SPI_DEBUG(qemu_log("Extracting rx n1_byte = 
>> 0x%2.2x from "
>> +                            "payload at index = %d\n", n1_byte, 
>> n1_count));
>> +                    if (sc->reverse_bits) {
>> +                        SPI_DEBUG(qemu_log("Reversing bit order of rx "
>> +                                            "n1_byte\n"));
>> +                        n1_byte = reverse_bits8(n1_byte);
>> +                    }
>> +                    SPI_DEBUG(qemu_log("Shifting rx N1 byte = 
>> 0x%2.2x into "
>> +                                   "RDR\n", n1_byte));
>> +                    shift_byte_in(sc, n1_byte);
>> +                }
>> +                n1_count++;
>> +            } /* end of while */
>> +        }
>> +        /* Handle the N2 portion of the frame */
>> +        if (sc->N2_rx != 0) {
>> +            uint8_t n2_count = 0;
>> +            while (n2_count < sc->N2_bytes) {
>> +                shift_in_count++;
>> +                xfer_buffer_read_ptr(rsp_payload, &read_buf,
>> +                                (sc->N1_bytes + n2_count), 1);
>> +                if ((ecc_count != 0) &&
>> +                    (shift_in_count == (SPI_CONTROLLER_REG_SIZE + 
>> ecc_count))) {
>> +                    SPI_DEBUG(qemu_log("Discarding rx N1 ECC byte = 
>> 0x%2.2x at "
>> +                           "payload index = %d\n", read_buf[0],
>> +                           (sc->N1_bytes + n2_count)));
>> +                    shift_in_count = 0;
>> +                } else {
>> +                    /*
>> +                     * The code handles shifting data from the 
>> payload received
>> +                     * from the responder into the responder's RDR.  
>> Since this
>> +                     * is an N2 frame segment it is safe to assume 
>> that there
>> +                     * was a preceding N1 segment which was combined 
>> with an N2
>> +                     * segment to create a single frame. The 
>> response data will
>> +                     * then have N1_bytes of data in the payload 
>> representing a
>> +                     * responder response to the N1 section of the 
>> frame. If N2
>> +                     * is set to receive the shifting for N2 data 
>> begins after
>> +                     * the N1 bytes regardless of whether or not N1 
>> was marked
>> +                     * for transmit or receive.
>> +                     */
>> +                    uint8_t n2_byte = 0x00;
>> +                    n2_byte = read_buf[0];
>> +                    SPI_DEBUG(qemu_log("Extracting rx n2_byte = 
>> 0x%2.2x from "
>> +                            "payload at index = %d\n", n2_byte,
>> +                            (sc->N1_bytes + n2_count)));
>> +                    if (sc->reverse_bits) {
>> +                        SPI_DEBUG(qemu_log("Reversing bit order of rx "
>> +                                            "n2_byte\n"));
>> +                        n2_byte = reverse_bits8(n2_byte);
>> +                    }
>> +                    SPI_DEBUG(qemu_log("Shifting rx N2 byte = 
>> 0x%2.2x into "
>> +                              "RDR\n", n2_byte));
>> +                    shift_byte_in(sc, n2_byte);
>> +                }
>> +                n2_count++;
>> +            }
>> +        }
>> +        if ((sc->N1_rx + sc->N2_rx) > 0) {
>> +            /*
>> +             * Data was received so handle RDR status.
>> +             * It is easier to handle RDR_full and RDR_overrun 
>> status here
>> +             * since the RDR register's shift_byte_in method is called
>> +             * multiple times in a row. Controlling RDR status is 
>> done here
>> +             * instead of in the RDR scoped methods for that reason.
>> +             */
>> +            if (GETFIELD(STATUS_REG_RDR_FULL, sc->status_reg) == 1) {
>> +                /*
>> +                 * Data was shifted into the RDR before having been 
>> read
>> +                 * causing previous data to have been overrun.
>> +                 */
>> +                sc->status_reg = SETFIELD(STATUS_REG_RDR_OVERRUN,
>> +                                sc->status_reg, 1);
>> +            } else {
>> +                /*
>> +                 * Set status to indicate that the received data 
>> register is
>> +                 * full. This flag is only cleared once the RDR is 
>> unloaded.
>> +                 */
>> +                sc->status_reg = SETFIELD(STATUS_REG_RDR_FULL,
>> +                                sc->status_reg, 1);
>> +                SPI_DEBUG(qemu_log("RDR_full set to 1\n"));
>> +            }
>> +        }
>> +    } /* end of else */
>> +} /* end of spi_response() */
>> +
>> +void log_all_N_counts(PnvSpiController *sc)
>> +{
>> +    SPI_DEBUG(qemu_log("N1_bits = %d, N1_bytes = %d, N1_tx = %d, 
>> N1_rx = %d, "
>> +          "N2_bits = %d, N2_bytes = %d, N2_tx = %d, N2_rx = %d\n",
>> +           sc->N1_bits, sc->N1_bytes, sc->N1_tx, sc->N1_rx, 
>> sc->N2_bits,
>> +           sc->N2_bytes, sc->N2_tx, sc->N2_rx));
>> +}
>> +
>> +static inline void next_sequencer_fsm(PnvSpiController *sc)
>> +{
>> +    uint8_t seq_index = GETFIELD(STATUS_REG_SEQUENCER_INDEX, 
>> sc->status_reg);
>> +    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX, 
>> sc->status_reg,
>> +                              (seq_index + 1));
>> +    sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM, sc->status_reg,
>> + SEQ_STATE_INDEX_INCREMENT);
>> +}
>> +
>> +void operation_sequencer(PnvSpiController *sc)
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
>> +     * xfer_buffer for containing the payload of the SPI frame.
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
>> +    static xfer_buffer *payload;
>> +
>> +    if (payload == NULL) {
>> +        payload = xfer_buffer_new();
>> +    }
>> +    /*
>> +     * Clear the sequencer FSM error bit - general_SPI_status[3]
>> +     * before starting a sequence.
>> +     */
>> +    sc->status_reg = SETFIELD(PPC_BIT(35), sc->status_reg, 0);
>> +    /*
>> +     * If the FSM is idle set the sequencer index to 0
>> +     * (new/restarted sequence)
>> +     */
>> +    if (GETFIELD(STATUS_REG_SEQUENCER_FSM, sc->status_reg) ==
>> +                    SEQ_STATE_IDLE) {
>> +        sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> +                                  sc->status_reg, 0);
>> +    }
>> +    /*
>> +     * There are only 8 possible operation IDs to iterate through 
>> though
>> +     * some operations may cause more than one frame to be sequenced.
>> +     */
>> +    while (GETFIELD(STATUS_REG_SEQUENCER_INDEX, sc->status_reg) < 8) {
>> +        opcode = sc->sequencer_operation_reg[GETFIELD(
>> +                        STATUS_REG_SEQUENCER_INDEX, sc->status_reg)];
>> +        /* Set sequencer state to decode */
>> +        sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM, 
>> sc->status_reg,
>> +                                  SEQ_STATE_DECODE);
>> +        /*
>> +         * Only the upper nibble of the operation ID is needed to 
>> know what
>> +         * kind of operation is requested.
>> +         */
>> +        masked_opcode = opcode & 0xF0;
>> +        switch (masked_opcode) {
>> +        /*
>> +         * Increment the operation index in each case instead of just
>> +         * once at the end in case an operation like the branch
>> +         * operation needs to change the index.
>> +         */
>> +        case SEQ_OP_STOP:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            /* A stop operation in any position stops the sequencer */
>> +            SPI_DEBUG(qemu_log("Sequencer STOP at index = 0x%llx, 
>> sequencer "
>> +                               "idling\n", GETFIELD(
>> +                               STATUS_REG_SEQUENCER_INDEX,
>> +                               sc->status_reg)));
>> +            stop = true;
>> +            sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM, 
>> sc->status_reg,
>> +                                          FSM_IDLE);
>> +            sc->loop_counter_1 = 0;
>> +            sc->loop_counter_2 = 0;
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, SEQ_STATE_IDLE);
>> +            break;
>> +
>> +        case SEQ_OP_SELECT_SLAVE:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            SPI_DEBUG(qemu_log("Sequencer SELECT_SLAVE at index = 
>> 0x%llx\n",
>> +                GETFIELD(STATUS_REG_SEQUENCER_INDEX, sc->status_reg)));
>> +            /*
>> +             * This device currently only supports a single responder
>> +             * connection at position 0.  De-selecting a responder 
>> is fine
>> +             * and expected at the end of a sequence but selecting any
>> +             * responder other than 0 should cause an error.
>> +             */
>> +            sc->responder_select = opcode & 0x0F;
>> +            if (sc->responder_select == 0) {
>> +                SPI_DEBUG(qemu_log("Shifter done, pull the CS line 
>> high\n"));
>> +                qemu_set_irq((sc->bus).cs_line[0], 1);
>> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> +                                          sc->status_reg,
>> +                                          (GETFIELD(
>> + STATUS_REG_SEQUENCER_INDEX,
>> +                                          sc->status_reg) + 1));
>> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                                          sc->status_reg, FSM_DONE);
>> +            } else if (sc->responder_select != 1) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "Slave selection 
>> other than 1 "
>> +                              "not supported, select = 0x%x\n",
>> +                               sc->responder_select);
>> +                SPI_DEBUG(qemu_log("Sequencer stop requested due to 
>> invalid "
>> +                                        "responder select at index = 
>> 0x%llx, "
>> +                                   "shifter idling\n", GETFIELD(
>> +                                   STATUS_REG_SEQUENCER_INDEX,
>> +                                   sc->status_reg)));
>> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                                          sc->status_reg, FSM_IDLE);
>> +                stop = true;
>> +            } else {
>> +                /*
>> +                 * Only allow an FSM_START state when a responder is
>> +                 * selected
>> +                 */
>> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                                          sc->status_reg, FSM_START);
>> +                SPI_DEBUG(qemu_log("shifter starting, pull CS line 
>> low\n"));
>> +                qemu_set_irq((sc->bus).cs_line[0], 0);
>> +                sc->first = 1;
>> +                sc->last = 0;
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
>> +                sc->shift_n1_done = false;
>> +                next_sequencer_fsm(sc);
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_SHIFT_N1:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            SPI_DEBUG(qemu_log("Sequencer SHIFT_N1 at index = 
>> 0x%llx\n",
>> +                GETFIELD(STATUS_REG_SEQUENCER_INDEX, sc->status_reg)));
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
>> +            if ((GETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                               sc->status_reg) == FSM_IDLE) ||
>> +                (GETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                               sc->status_reg) == FSM_DONE)) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N1 not allowed 
>> in "
>> +                              "shifter state = 0x%llx", GETFIELD(
>> +                        STATUS_REG_SHIFTER_FSM, sc->status_reg));
>> +                /*
>> +                 * Set sequencer FSM error bit 3 
>> (general_SPI_status[3])
>> +                 * in status reg.
>> +                 */
>> +                sc->status_reg = SETFIELD(PPC_BIT(35), 
>> sc->status_reg, 1);
>> +                SPI_DEBUG(qemu_log("Sequencer stop requested due to 
>> invalid "
>> +                      "shifter state at index = 0x%llx\n", GETFIELD(
>> +                         STATUS_REG_SEQUENCER_INDEX, sc->status_reg)));
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
>> +                if ((sc->sequencer_operation_reg[GETFIELD(
>> +                     STATUS_REG_SEQUENCER_INDEX, sc->status_reg) + 
>> 1] & 0xF0)
>> +                                == SEQ_OP_SHIFT_N2) {
>> +                    SPI_DEBUG(qemu_log("Not sending N1 alone\n"));
>> +                    send_n1_alone = false;
>> +                }
>> +                /*
>> +                 * If the next opcode is 0x10, which deselects the 
>> SPI device
>> +                 * then this is the last shift
>> +                 */
>> +                if (sc->sequencer_operation_reg[GETFIELD(
>> +                    STATUS_REG_SEQUENCER_INDEX, sc->status_reg) + 1] ==
>> +                                SEQ_OP_SELECT_SLAVE) {
>> +                    sc->last = 1;
>> +                }
>> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                                sc->status_reg, FSM_SHIFT_N1);
>> +                stop = operation_shiftn1(sc, opcode, &payload, 
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
>> +                    if (GETFIELD(STATUS_REG_TDR_UNDERRUN, 
>> sc->status_reg)) {
>> +                        SPI_DEBUG(qemu_log("Sequencer stop requested 
>> due to N2 "
>> +                              "counter reload active.\n"));
>> +                        sc->shift_n1_done = true;
>> +                        sc->status_reg = 
>> SETFIELD(STATUS_REG_SHIFTER_FSM,
>> + sc->status_reg,
>> + FSM_SHIFT_N2);
>> +                        sc->status_reg = 
>> SETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> + sc->status_reg,
>> +                                                  (GETFIELD(
>> + STATUS_REG_SEQUENCER_INDEX,
>> + sc->status_reg) + 1));
>> +                        SPI_DEBUG(qemu_log("Set new sequencer index 
>> to = "
>> +                                           "0x%llx\n", GETFIELD(
>> + STATUS_REG_SEQUENCER_INDEX,
>> + sc->status_reg)));
>> +                    } else {
>> +                        /*
>> +                         * This is case (1) or (2) so the sequencer 
>> needs to
>> +                         * wait and NOT go to the next sequence yet.
>> +                         */
>> +                        sc->status_reg = 
>> SETFIELD(STATUS_REG_SHIFTER_FSM,
>> + sc->status_reg, FSM_WAIT);
>> +                    }
>> +                } else {
>> +                    /* Ok to move on to the next index */
>> +                    sc->shift_n1_done = true;
>> +                    next_sequencer_fsm(sc);
>> +                }
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_SHIFT_N2:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            SPI_DEBUG(qemu_log("Sequencer SHIFT_N2 at index = %lld\n",
>> + GETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> +                                         sc->status_reg)));
>> +            if (!sc->shift_n1_done) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not 
>> allowed if a "
>> +                              "Shift_N1 is not done, shifter state = 
>> 0x%llx",
>> +                              GETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                                       sc->status_reg));
>> +                /*
>> +                 * In case the sequencer actually stops if an N2 
>> shift is
>> +                 * requested before any N1 shift is done. Set 
>> sequencer FSM
>> +                 * error bit 3 (general_SPI_status[3]) in status reg.
>> +                 */
>> +                sc->status_reg = SETFIELD(PPC_BIT(35), 
>> sc->status_reg, 1);
>> +                SPI_DEBUG(qemu_log("Sequencer stop requested due to 
>> shift_n2 "
>> +                                    "w/no shift_n1 done at index = 
>> 0x%llx\n",
>> + GETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> + sc->status_reg)));
>> +                stop = true;
>> +            } else {
>> +                /*
>> +                 * If the next opcode is 0x10, which deselects the 
>> SPI device
>> +                 * then this is the last shift
>> +                 */
>> +                if (sc->sequencer_operation_reg[GETFIELD(
>> +                    STATUS_REG_SEQUENCER_INDEX,
>> +                    sc->status_reg) + 1] == SEQ_OP_SELECT_SLAVE) {
>> +                    sc->last = 1;
>> +                }
>> +                /* Ok to do a Shift_N2 */
>> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                                          sc->status_reg, 
>> FSM_SHIFT_N2);
>> +                stop = operation_shiftn2(sc, opcode, &payload);
>> +                /*
>> +                 * If the operation code says to stop set the 
>> shifter state to
>> +                 * wait and stop
>> +                 */
>> +                if (stop) {
>> +                    sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
>> + sc->status_reg, FSM_WAIT);
>> +                } else {
>> +                    /* Ok to move on to the next index */
>> +                    next_sequencer_fsm(sc);
>> +                }
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_BRANCH_IFNEQ_RDR:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            SPI_DEBUG(qemu_log("Sequencer BRANCH_IFNEQ_RDR at "
>> +                               "index = 0x%llx\n", GETFIELD(
>> +                               STATUS_REG_SEQUENCER_INDEX, 
>> sc->status_reg)));
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
>> +            if (GETFIELD(STATUS_REG_RDR_FULL, sc->status_reg) == 1) {
>> +                bool rdr_matched = false;
>> +                rdr_matched = does_rdr_match(sc);
>> +                if (rdr_matched) {
>> +                    SPI_DEBUG(qemu_log("Proceed to next sequencer 
>> index "
>> +                                   "(increment on RDR match)\n"));
>> +                    /* A match occurred, increment the sequencer 
>> index. */
>> +                    next_sequencer_fsm(sc);
>> +                } else {
>> +                    SPI_DEBUG(qemu_log("Proceed to sequencer 
>> index=0x%x "
>> +                          "(branch on RDR match fail)\n", (opcode & 
>> 0x7)));
>> +                    /*
>> +                     * Branch the sequencer to the index coded into 
>> the op
>> +                     * code.
>> +                     */
>> +                    sc->status_reg = 
>> SETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> + sc->status_reg, (opcode & 0x7));
>> +                }
>> +                /*
>> +                 * Regardless of where the branch ended up we want the
>> +                 * sequencer to continue shifting so we have to clear
>> +                 * RDR_full.
>> +                 */
>> +                sc->status_reg = SETFIELD(STATUS_REG_RDR_FULL,
>> +                                sc->status_reg, 0);
>> +            } else {
>> +                SPI_DEBUG(qemu_log("RDR not full for 0x6x opcode! 
>> Stopping "
>> +                      "sequencer.\n"));
>> +                stop = true;
>> +                sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM,
>> +                                         sc->status_reg, FSM_WAIT);
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_TRANSFER_TDR:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not 
>> supported\n");
>> +            next_sequencer_fsm(sc);
>> +            break;
>> +
>> +        case SEQ_OP_BRANCH_IFNEQ_INC_1:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            SPI_DEBUG(qemu_log("Sequencer BRANCH_IFNEQ_INC_1 at 
>> index = "
>> +                               "0x%llx, next index = %d, 
>> count_compare_1 = "
>> +                               "0x%llx, loop_counter_1 = %d\n", 
>> GETFIELD(
>> +                               STATUS_REG_SEQUENCER_INDEX, 
>> sc->status_reg),
>> +                               (opcode & 0x07),
>> +                  GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE1,
>> +                  sc->status_reg), sc->loop_counter_1));
>> +            /*
>> +             * The spec says the loop should execute count compare + 
>> 1 times.
>> +             * However we learned from engineering that we really 
>> only loop
>> +             * count_compare times, count compare = 0 makes this op 
>> code a
>> +             * no-op
>> +             */
>> +            if (sc->loop_counter_1 !=
>> +                GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE1,
>> +                                sc->counter_config_reg)) {
>> +                /*
>> +                 * If the next opcode is 0x10, which deselects the 
>> SPI device
>> +                 * and we know that the next opcode is the last one 
>> in the
>> +                 * loop then the next shift is the last shift
>> +                 */
>> +                uint8_t condition1 = sc->sequencer_operation_reg[
>> + GETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> +                                     sc->status_reg) + 1];
>> +                uint8_t condition2 = 
>> GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE1,
>> +                                 sc->counter_config_reg);
>> +
>> +                if ((condition1 == SEQ_OP_SELECT_SLAVE) &&
>> +                    ((sc->loop_counter_1 + 1) == condition2)) {
>> +                    sc->last = 1;
>> +                }
>> +                /*
>> +                 * Next index is the lower nibble of the branch 
>> operation ID,
>> +                 * mask off all but the first three bits so we don't 
>> try to
>> +                 * access beyond the sequencer_operation_reg boundary.
>> +                 */
>> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> +                                          sc->status_reg, (opcode & 
>> 0x7));
>> +                sc->loop_counter_1++;
>> +                SPI_DEBUG(qemu_log("Branching to index = %d, 
>> loop_counter_1 = "
>> +                      "%d\n", (opcode & 0x7), sc->loop_counter_1));
>> +            } else {
>> +                /* Continue to next index if loop counter is reached */
>> +                next_sequencer_fsm(sc);
>> +                SPI_DEBUG(qemu_log("loop counter 1 achieved, next 
>> sequencer "
>> +                      "index = 0x%llx\n", 
>> GETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> + sc->status_reg)));
>> +            }
>> +            break;
>> +
>> +        case SEQ_OP_BRANCH_IFNEQ_INC_2:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            SPI_DEBUG(qemu_log("Sequencer BRANCH_IFNEQ_INC_2 at 
>> index = "
>> +                               "0x%llx, next index = %d, 
>> count_compare_2 = "
>> +                               "0x%llx, loop_counter_2 = %d\n", 
>> GETFIELD(
>> +                               STATUS_REG_SEQUENCER_INDEX, 
>> sc->status_reg),
>> +                               (opcode & 0x07), GETFIELD(
>> + COUNTER_CONFIG_REG_COUNT_COMPARE2,
>> +                               sc->status_reg), sc->loop_counter_2));
>> +            /*
>> +             * If the next opcode is 0x10, which deselects the SPI 
>> device
>> +             * and we know that the next opcode is the last one in the
>> +             * loop then the next shift is the last shift
>> +             */
>> +            uint8_t condition1 = sc->sequencer_operation_reg[
>> + GETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> +                                          sc->status_reg) + 1];
>> +            uint8_t condition2 = 
>> GETFIELD(COUNTER_CONFIG_REG_COUNT_COMPARE2,
>> +                              sc->counter_config_reg);
>> +
>> +            if ((condition1 == SEQ_OP_SELECT_SLAVE) &&
>> +                ((sc->loop_counter_2 + 1) == condition2)) {
>> +                sc->last = 1;
>> +            }
>> +            /*
>> +             * The spec says the loop should execute count compare + 
>> 1 times.
>> +             * However we learned from engineering that we really 
>> only loop
>> +             * count_compare times, count compare = 0 makes this op 
>> code a
>> +             * no-op
>> +             */
>> +            if (sc->loop_counter_2 != condition2) {
>> +                /*
>> +                 * Next index is the lower nibble of the branch 
>> operation ID,
>> +                 * mask off all but the first three bits so we don't 
>> try to
>> +                 * access beyond the sequencer_operation_reg boundary.
>> +                 */
>> +                sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> +                                          sc->status_reg,
>> +                                          (opcode & 0x7));
>> +                sc->loop_counter_2++;
>> +                SPI_DEBUG(qemu_log("Branching to index = %d, 
>> loop_counter_2 "
>> +                                   "= %d", (opcode & 0x7),
>> +                                   sc->loop_counter_2));
>> +            } else {
>> +                /* Continue to next index if loop counter is reached */
>> +                next_sequencer_fsm(sc);
>> +                SPI_DEBUG(qemu_log("loop counter 2 achieved, next 
>> sequencer "
>> +                      "index = 0x%llx\n", 
>> GETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> + sc->status_reg)));
>> +            }
>> +            break;
>> +
>> +        default:
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, 
>> SEQ_STATE_EXECUTE);
>> +            qemu_log_mask(LOG_GUEST_ERROR, "Sequencer opcode 0x%x is 
>> not "
>> +                      "supported\n", opcode);
>> +            /* Ignore unsupported operations. */
>> +            next_sequencer_fsm(sc);
>> +            break;
>> +        } /* end of switch */
>> +        /*
>> +         * If we used all 8 opcodes without seeing a 00 - STOP in 
>> the sequence
>> +         * we need to go ahead and end things as if there was a STOP 
>> at the
>> +         * end.
>> +         */
>> +        if (GETFIELD(STATUS_REG_SEQUENCER_INDEX, sc->status_reg) == 
>> 8) {
>> +            SPI_DEBUG(qemu_log("All 8 opcodes completed, sequencer "
>> +                               "idling\n"));
>> +            sc->status_reg = SETFIELD(STATUS_REG_SHIFTER_FSM, 
>> sc->status_reg,
>> +                                      FSM_IDLE);
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_INDEX,
>> +                                      sc->status_reg, 0);
>> +            sc->loop_counter_1 = 0;
>> +            sc->loop_counter_2 = 0;
>> +            sc->status_reg = SETFIELD(STATUS_REG_SEQUENCER_FSM,
>> +                                      sc->status_reg, SEQ_STATE_IDLE);
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
>> +void calculate_N1(PnvSpiController *sc, uint8_t opcode)
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
>> +    if (GETFIELD(PPC_BITMASK8(4, 7), opcode) == 0) {
>> +        /* Explicit mode */
>> +        sc->N1_bits = GETFIELD(COUNTER_CONFIG_REG_SHIFT_COUNT_N1,
>> + sc->counter_config_reg);
>> +        sc->N1_bytes = ceil(sc->N1_bits / 8);
>> +        sc->N1_tx = 0;
>> +        sc->N1_rx = 0;
>> +        /* If tx count control for N1 is set, load the tx value */
>> +        if (GETFIELD(PPC_BIT(50), sc->counter_config_reg) == 1) {
>> +            sc->N1_tx = sc->N1_bytes;
>> +        }
>> +        /* If rx count control for N1 is set, load the rx value */
>> +        if (GETFIELD(PPC_BIT(51), sc->counter_config_reg) == 1) {
>> +            sc->N1_rx = sc->N1_bytes;
>> +        }
>> +    } else {
>> +        /* Implicit mode/Forced Implicit mode, use M field from 
>> opcode */
>> +        sc->N1_bytes = GETFIELD(PPC_BITMASK8(4, 7), opcode);
>> +        sc->N1_bits = sc->N1_bytes * 8;
>> +        /*
>> +         * Assume that we are going to transmit the count
>> +         * (pure Implicit only)
>> +         */
>> +        sc->N1_tx = sc->N1_bytes;
>> +        sc->N1_rx = 0;
>> +        /* Let Forced Implicit mode have an effect on the counts */
>> +        if (GETFIELD(PPC_BIT(49), sc->counter_config_reg) == 1) {
>> +            /*
>> +             * If Forced Implicit mode and count control doesn't
>> +             * indicate transmit then reset the tx count to 0
>> +             */
>> +            if (GETFIELD(PPC_BIT(50), sc->counter_config_reg) == 0) {
>> +                sc->N1_tx = 0;
>> +            }
>> +            /* If rx count control for N1 is set, load the rx value */
>> +            if (GETFIELD(PPC_BIT(51), sc->counter_config_reg) == 1) {
>> +                sc->N1_rx = sc->N1_bytes;
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
>> +    uint8_t ecc_control = GETFIELD(PPC_BITMASK(29, 30),
>> + sc->clock_config_reset_control);
>> +    if (ecc_control == 0 || ecc_control == 2) {
>> +        if (sc->N1_bytes > (SPI_CONTROLLER_REG_SIZE + 1)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift 
>> size when "
>> +                          "ECC enabled, bytes = 0x%x, bits = 0x%x\n",
>> +                          sc->N1_bytes, sc->N1_bits);
>> +            sc->N1_bytes = SPI_CONTROLLER_REG_SIZE + 1;
>> +            sc->N1_bits = sc->N1_bytes * 8;
>> +        }
>> +    } else if (sc->N1_bytes > SPI_CONTROLLER_REG_SIZE) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Unsupported N1 shift size, "
>> +                      "bytes = 0x%x, bits = 0x%x\n",
>> +                      sc->N1_bytes, sc->N1_bits);
>> +        sc->N1_bytes = SPI_CONTROLLER_REG_SIZE;
>> +        sc->N1_bits = sc->N1_bytes * 8;
>> +    }
>> +} /* end of calculate_N1 */
>> +
>> +/*
>> + * Shift_N1 operation handler method
>> + */
>> +bool operation_shiftn1(PnvSpiController *sc, uint8_t opcode,
>> +                       xfer_buffer **payload, bool send_n1_alone)
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
>> +        SPI_DEBUG(qemu_log("Creating new payload xfer_buffer\n"));
>> +        *payload = xfer_buffer_new();
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
>> +    calculate_N1(sc, opcode);
>> +    SPI_DEBUG(qemu_log("Shift N1 started..\n"));
>> +    log_all_N_counts(sc);
>> +    /*
>> +     * Zero out the N2 counters here in case there is no N2 
>> operation following
>> +     * the N1 operation in the sequencer.  This keeps leftover N2 
>> information
>> +     * from interfering with spi_response logic.
>> +     */
>> +    sc->N2_bits = 0;
>> +    sc->N2_bytes = 0;
>> +    sc->N2_tx = 0;
>> +    sc->N2_rx = 0;
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
>> +    while (n1_count < sc->N1_bytes) {
>> +        /*
>> +         * Assuming that if N1_tx is not equal to 0 then it is the 
>> same as
>> +         * N1_bytes.
>> +         */
>> +        if ((sc->N1_tx != 0) && (n1_count < SPI_CONTROLLER_REG_SIZE)) {
>> +
>> +            if (GETFIELD(STATUS_REG_TDR_FULL, sc->status_reg) == 1) {
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
>> +                n1_byte = get_from_offset(sc, n1_count);
>> +                SPI_DEBUG(qemu_log("Extracting tx n1_byte = 0x%2.2x 
>> at index "
>> +                                   "%d from TDR\n", n1_byte, 
>> n1_count));
>> +                if (sc->reverse_bits) {
>> +                    SPI_DEBUG(qemu_log("Reversing bit order of tx 
>> n1_byte\n"));
>> +                    n1_byte = reverse_bits8(n1_byte);
>> +                }
>> +                SPI_DEBUG(qemu_log("Appending tx n1_byte = 0x%2.2x to "
>> +                            "Payload\n", n1_byte));
>> +                *(xfer_buffer_write_ptr(*payload, (*payload)->len, 
>> 1)) =
>> +                        n1_byte;
>> +            } else {
>> +                /*
>> +                 * We hit a shift_n1 opcode TX but the TDR is empty, 
>> tell the
>> +                 * sequencer to stop and break this loop.
>> +                 */
>> +                SPI_DEBUG(qemu_log("Shift N1 set for transmit but 
>> TDR is empty,"
>> +                      " requesting sequencer stop\n"));
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
>> +            if ((sc->N1_rx != 0) && (GETFIELD(STATUS_REG_RDR_FULL,
>> +                                           sc->status_reg) == 1)) {
>> +                SPI_DEBUG(qemu_log("Shift N1 set for receive but RDR 
>> is full, "
>> +                      "requesting sequencer stop\n"));
>> +                stop = true;
>> +                break;
>> +            } else {
>> +                SPI_DEBUG(qemu_log("Appending tx n1_byte = 0xFF to 
>> Payload\n"));
>> +                *(xfer_buffer_write_ptr(*payload, (*payload)->len, 
>> 1)) = 0xff;
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
>> +    if (!stop && (sc->N1_tx != 0) &&
>> +        (GETFIELD(STATUS_REG_TDR_FULL, sc->status_reg) == 1)) {
>> +
>> +        sc->status_reg = SETFIELD(STATUS_REG_TDR_FULL, 
>> sc->status_reg, 0);
>> +        SPI_DEBUG(qemu_log("TDR_full set to 0\n"));
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
>> +       (GETFIELD(PPC_BIT(52), sc->counter_config_reg) == 1)) {
>> +        SPI_DEBUG(qemu_log("N2 counter reload active, stop N1 shift, "
>> +              "TDR_underrun set to 1\n"));
>> +        stop = true;
>> +        sc->status_reg = SETFIELD(STATUS_REG_TDR_UNDERRUN, 
>> sc->status_reg, 1);
>> +    }
>> +    /*
>> +     * If send_n1_alone is set AND we have a full TDR then this is 
>> the first and
>> +     * last payload to send and we don't have an N2 frame segment to 
>> add to the
>> +     * payload.
>> +     */
>> +    if (send_n1_alone && !stop) {
>> +        uint32_t tx;
>> +        uint32_t rx;
>> +        uint8_t *read_buf = NULL;
>> +        xfer_buffer *rsp_payload = NULL;
>> +
>> +        /* We have a TX and a full TDR or an RX and an empty RDR */
>> +        SPI_DEBUG(qemu_log("Shifting N1 frame: first = %d, last = %d, "
>> +                           "n1 bits = %d\n", sc->first, sc->last,
>> +                           sc->N1_bits));
>> +        rsp_payload = xfer_buffer_new();
>> +        for (int offset = 0; offset < (*payload)->len; offset = 
>> offset + 4) {
>> +            xfer_buffer_read_ptr(*payload, &read_buf, offset, 4);
>> +            tx = 0;
>> +            for (int i = 0; i < 4; i++) {
>> +                if ((offset + i) >= (*payload)->len) {
>> +                    break;
>> +                }
>> +                tx = (tx << 8) | read_buf[i];
>> +            }
>> +            rx = ssi_transfer((sc->bus).ssi_bus, tx);
>> +            for (int i = 0; i < 4; i++) {
>> +                if ((offset + i) >= (*payload)->len) {
>> +                    break;
>> +                }
>> +                *(xfer_buffer_write_ptr(rsp_payload, 
>> rsp_payload->len, 1)) =
>> +                        (rx >> (24 - i * 8)) & 0xFF;
>> +            }
>> +        }
>> +        if (rsp_payload != NULL) {
>> +            spi_response(sc, sc->N1_bits, rsp_payload);
>> +        }
>> +        sc->first = 0;
>> +        sc->last = 0;
>> +        /* The N1 frame shift is complete so reset the N1 counters */
>> +        sc->N2_bits = 0;
>> +        sc->N2_bytes = 0;
>> +        sc->N2_tx = 0;
>> +        sc->N2_rx = 0;
>> +        xfer_buffer_free(*payload);
>> +        *payload = NULL;
>> +        SPI_DEBUG(qemu_log("Payload buffer freed\n"));
>> +    } else {
>> +        SPI_DEBUG(qemu_log("Not shifting N1, send_n1_alone = %d, 
>> stop = %d\n",
>> +              send_n1_alone, stop));
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
>> +void calculate_N2(PnvSpiController *sc, uint8_t opcode)
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
>> +    if (GETFIELD(PPC_BITMASK8(4, 7), opcode) == 0) {
>> +        /* Explicit mode */
>> +        sc->N2_bits = GETFIELD(COUNTER_CONFIG_REG_SHIFT_COUNT_N2,
>> +                               sc->counter_config_reg);
>> +        sc->N2_bytes = ceil(sc->N2_bits / 8);
>> +        sc->N2_tx = 0;
>> +        sc->N2_rx = 0;
>> +        /* If tx count control for N2 is set, load the tx value */
>> +        if (GETFIELD(PPC_BIT(54), sc->counter_config_reg) == 1) {
>> +            sc->N2_tx = sc->N2_bytes;
>> +        }
>> +        /* If rx count control for N2 is set, load the rx value */
>> +        if (GETFIELD(PPC_BIT(55), sc->counter_config_reg) == 1) {
>> +            sc->N2_rx = sc->N2_bytes;
>> +        }
>> +    } else {
>> +        /* Implicit mode/Forced Implicit mode, use M field from 
>> opcode */
>> +        sc->N2_bytes = GETFIELD(PPC_BITMASK8(4, 7), opcode);
>> +        sc->N2_bits = sc->N2_bytes * 8;
>> +        /* Assume that we are going to receive the count */
>> +        sc->N2_rx = sc->N2_bytes;
>> +        sc->N2_tx = 0;
>> +        /* Let Forced Implicit mode have an effect on the counts */
>> +        if (GETFIELD(PPC_BIT(53), sc->counter_config_reg) == 1) {
>> +            /*
>> +             * If Forced Implicit mode and count control doesn't
>> +             * indicate a receive then reset the rx count to 0
>> +             */
>> +            if (GETFIELD(PPC_BIT(55), sc->counter_config_reg) == 0) {
>> +                sc->N2_rx = 0;
>> +            }
>> +            /* If tx count control for N2 is set, load the tx value */
>> +            if (GETFIELD(PPC_BIT(54), sc->counter_config_reg) == 1) {
>> +                sc->N2_tx = sc->N2_bytes;
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
>> +    uint8_t ecc_control = GETFIELD(PPC_BITMASK(29, 30),
>> + sc->clock_config_reset_control);
>> +    if (ecc_control == 0 || ecc_control == 2) {
>> +        if (sc->N2_bytes > (SPI_CONTROLLER_REG_SIZE + 1)) {
>> +            SPI_DEBUG(qemu_log("Unsupported N2 shift size when ECC 
>> enabled, "
>> +                                     "bytes = 0x%x, bits = 0x%x\n",
>> +                               sc->N2_bytes, sc->N2_bits));
>> +            sc->N2_bytes = SPI_CONTROLLER_REG_SIZE + 1;
>> +            sc->N2_bits = sc->N2_bytes * 8;
>> +        }
>> +    } else if (sc->N2_bytes > SPI_CONTROLLER_REG_SIZE) {
>> +        SPI_DEBUG(qemu_log("Unsupported N2 shift size, bytes = 0x%x, "
>> +                           "bits = 0x%x\n", sc->N2_bytes, 
>> sc->N2_bits));
>> +        sc->N2_bytes = SPI_CONTROLLER_REG_SIZE;
>> +        sc->N2_bits = sc->N2_bytes * 8;
>> +    }
>> +} /* end of calculate_N2 */
>> +
>> +/*
>> + * Shift_N2 operation handler method
>> + */
>> +
>> +bool operation_shiftn2(PnvSpiController *sc, uint8_t opcode,
>> +                       xfer_buffer **payload)
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
>> +        SPI_DEBUG(qemu_log("Creating new payload xfer_buffer\n"));
>> +        *payload = xfer_buffer_new();
>> +    }
>> +    /*
>> +     * Use a combination of N2 counters to build the N2 portion of the
>> +     * transmit payload.
>> +     */
>> +    calculate_N2(sc, opcode);
>> +    SPI_DEBUG(qemu_log("Shift N2 started\n"));
>> +    log_all_N_counts(sc);
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
>> +    while (n2_count < sc->N2_bytes) {
>> +        /*
>> +         * If the RDR is full and we need to RX just bail out, 
>> letting the
>> +         * code continue will end up building the payload twice in 
>> the same
>> +         * buffer since RDR full causes a sequence stop and restart.
>> +         */
>> +        if ((sc->N2_rx != 0) &&
>> +            (GETFIELD(STATUS_REG_RDR_FULL, sc->status_reg) == 1)) {
>> +            SPI_DEBUG(qemu_log("Shift N2 set for receive but RDR is 
>> full, "
>> +                  "requesting sequencer stop\n"));
>> +            stop = true;
>> +            break;
>> +        }
>> +        if ((sc->N2_tx != 0) && ((sc->N1_tx + n2_count) <
>> +                                SPI_CONTROLLER_REG_SIZE)) {
>> +            /* Always append data for the N2 segment if it is set 
>> for TX */
>> +            uint8_t n2_byte = 0x00;
>> +            n2_byte = get_from_offset(sc, (sc->N1_tx + n2_count));
>> +            SPI_DEBUG(qemu_log("Extracting tx n2_byte = 0x%2.2x at 
>> index %d "
>> +                  "from TDR\n", n2_byte, (sc->N1_tx + n2_count)));
>> +            if (sc->reverse_bits) {
>> +                SPI_DEBUG(qemu_log("Reversing bit order of tx 
>> n2_byte\n"));
>> +                n2_byte = reverse_bits8(n2_byte);
>> +            }
>> +            SPI_DEBUG(qemu_log("Appending tx n2_byte = 0x%2.2x to 
>> Payload\n",
>> +                            n2_byte));
>> +            *(xfer_buffer_write_ptr(*payload, (*payload)->len, 1)) = 
>> n2_byte;
>> +        } else {
>> +            /*
>> +             * Regardless of whether or not N2 is set for TX or RX, 
>> we need
>> +             * the number of bytes in the payload to match the 
>> overall length
>> +             * of the operation.
>> +             */
>> +            SPI_DEBUG(qemu_log("Appending tx n2_byte = 0xFF to 
>> Payload\n"));
>> +            *(xfer_buffer_write_ptr(*payload, (*payload)->len, 1)) = 
>> 0xff;
>> +        }
>> +        n2_count++;
>> +    } /* end of while */
>> +    if (!stop) {
>> +        uint32_t tx;
>> +        uint32_t rx;
>> +        uint8_t *read_buf = NULL;
>> +        xfer_buffer *rsp_payload = NULL;
>> +
>> +        /* We have a TX and a full TDR or an RX and an empty RDR */
>> +        SPI_DEBUG(qemu_log("Shifting N2 frame: first = %d, last = %d, "
>> +              "n1+n2 bits = %d\n", sc->first, sc->last,
>> +              (sc->N1_bits + sc->N2_bits)));
>> +        rsp_payload = xfer_buffer_new();
>> +        for (int offset = 0; offset < (*payload)->len; offset = 
>> offset + 4) {
>> +            xfer_buffer_read_ptr(*payload, &read_buf, offset, 4);
>> +            tx = 0;
>> +            for (int i = 0; i < 4; i++) {
>> +                if ((offset + i) >= (*payload)->len) {
>> +                    break;
>> +                }
>> +                tx = (tx << 8) | read_buf[i];
>> +            }
>> +            rx = ssi_transfer((sc->bus).ssi_bus, tx);
>> +            for (int i = 0; i < 4; i++) {
>> +                if ((offset + i) >= (*payload)->len) {
>> +                    break;
>> +                }
>> +                *(xfer_buffer_write_ptr(rsp_payload, 
>> rsp_payload->len, 1)) =
>> +                        (rx >> (24 - i * 8)) & 0xFF;
>> +            }
>> +        }
>> +        if (rsp_payload != NULL) {
>> +            spi_response(sc, (sc->N1_bits + sc->N2_bits), rsp_payload);
>> +        }
>> +        sc->first = 0;
>> +        sc->last = 0;
>> +        /*
>> +         * If we are doing an N2 TX and the TDR is full we need to 
>> clear the
>> +         * TDR_full status. Do this here instead of up in the loop 
>> above so we
>> +         * don't log the message in every loop iteration.
>> +         */
>> +        if ((sc->N2_tx != 0) &&
>> +            (GETFIELD(STATUS_REG_TDR_FULL, sc->status_reg) == 1)) {
>> +            sc->status_reg = SETFIELD(STATUS_REG_TDR_FULL, 
>> sc->status_reg, 0);
>> +            SPI_DEBUG(qemu_log("TDR_full set to 0\n"));
>> +        }
>> +        /*
>> +         * The N2 frame shift is complete so reset the N2 counters.
>> +         * Reset the N1 counters also in case the frame was a 
>> combination of
>> +         * N1 and N2 segments.
>> +         */
>> +        sc->N2_bits = 0;
>> +        sc->N2_bytes = 0;
>> +        sc->N2_tx = 0;
>> +        sc->N2_rx = 0;
>> +        sc->N1_bits = 0;
>> +        sc->N1_bytes = 0;
>> +        sc->N1_tx = 0;
>> +        sc->N1_rx = 0;
>> +        xfer_buffer_free(*payload);
>> +        *payload = NULL;
>> +        SPI_DEBUG(qemu_log("Payload buffer freed\n"));
>> +    } else {
>> +        SPI_DEBUG(qemu_log("Not shifting N2, stop = %d\n", stop));
>> +    }
>> +    return stop;
>> +} /*  end of operation_shiftn2()*/
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
>> +    PnvSpiController *sc = PNV_SPICONTROLLER(dev);
>> +    SPI_DEBUG(qemu_log("Resetting spic engine sequencer 
>> configuration and spi "
>> +                           "communication\n"));
>> +    /* Reset all N1 and N2 counters, and other constants */
>> +    sc->first = 0;
>> +    sc->last = 0;
>> +    sc->N2_bits = 0;
>> +    sc->N2_bytes = 0;
>> +    sc->N2_tx = 0;
>> +    sc->N2_rx = 0;
>> +    sc->N1_bits = 0;
>> +    sc->N1_bytes = 0;
>> +    sc->N1_tx = 0;
>> +    sc->N1_rx = 0;
>> +    sc->loop_counter_1 = 0;
>> +    sc->loop_counter_2 = 0;
>> +    SPI_DEBUG(qemu_log("Disconnected from responder\n"));
>> +    qemu_set_irq((sc->bus).cs_line[0], 1);
>> +}
>> +
>>   static void pnv_spi_bus_realize(DeviceState *dev, Error **errp)
>>   {
>>       PnvSPIBus *s = PNV_SPI_BUS(dev);
>> @@ -191,6 +1498,7 @@ static const TypeInfo pnv_spi_bus_info = {
>>     static Property pnv_spi_controller_properties[] = {
>>       DEFINE_PROP_UINT32("spic_num", PnvSpiController, spic_num, 0),
>> +    DEFINE_PROP_BOOL("reverse_bits", PnvSpiController, reverse_bits, 
>> false),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   @@ -254,6 +1562,7 @@ static void 
>> pnv_spi_controller_class_init(ObjectClass *klass, void *data)
>>         dc->desc = "PowerNV SPI Controller";
>>       dc->realize = pnv_spi_controller_realize;
>> +    dc->reset = do_reset;
>>       device_class_set_props(dc, pnv_spi_controller_properties);
>>   }
>

