Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B89C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribvn-0003DY-7P; Fri, 08 Mar 2024 10:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1ribvl-0003DL-IC; Fri, 08 Mar 2024 10:14:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1ribvh-0003AB-1j; Fri, 08 Mar 2024 10:14:41 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428F3lqb005003; Fri, 8 Mar 2024 15:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0VrmE3JQ3/DNNgt+U7m8o0sRdqULgvdan4273sHp6S8=;
 b=JwJISMs4Gpegx0Zi0jjuRL1+HWCTAtATZUuQPAIgQrYaE4QngPJjN46FZOlFkude1HLs
 DkB7pjXAOllj5qYqC1G7V3MvIWauAXreDrDAm/Q/3uJQQK9MVJ7yV97j5xmeEM5mS4TJ
 j5g391iYgwXw0Sb62r+slBdZecD6fs0PHf8C2OUZ3S4EmsQ/jaH9jUAtR0d8qS/DCJYy
 6plVMeCaTNADq17WA5J6c5XMx1cSr7IOJW1oyL0iJVrQJlbKL6rOpp+6lsSiWwuNK9T3
 XILBFO6w+6rkzirru0ckw4ajAzIaeuyyvbvyF3cno4fGOYdKSBZl4Z4wDU3yWXjnxiVg ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4yx86wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 15:14:33 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428FBLSR027953;
 Fri, 8 Mar 2024 15:14:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr4yx86w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 15:14:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428E4u07026212; Fri, 8 Mar 2024 15:14:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfepd40q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 15:14:32 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428FERFH41812374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 15:14:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFB575806B;
 Fri,  8 Mar 2024 15:14:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1372E58067;
 Fri,  8 Mar 2024 15:14:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 15:14:24 +0000 (GMT)
Message-ID: <a5f87881-2861-4fdd-9cbb-adfc335e869a@linux.ibm.com>
Date: Fri, 8 Mar 2024 10:14:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] hw/ppc: SPI SEEPROM model
Content-Language: en-US
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
 <20240207160833.3437779-5-chalapathi.v@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240207160833.3437779-5-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vo-5SgqXLRCCsP8VXoyeBq0Da86uqiVJ
X-Proofpoint-ORIG-GUID: uMLlumh6iQSaAVoV-gVgCjpaNov0QZl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080122
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
> This commit implements a Serial EEPROM utilizing the Serial Peripheral
> Interface (SPI) compatible bus.
> Currently implemented SEEPROM is Microchip's 25CSM04 which provides 4 Mbits
> of Serial EEPROM utilizing the Serial Peripheral Interface (SPI) compatible
> bus. The device is organized as 524288 bytes of 8 bits each (512Kbyte) and
> is optimized for use in consumer and industrial applications where reliable
> and dependable nonvolatile memory storage is essential.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   include/hw/ppc/pnv_spi_seeprom.h |  70 +++
>   hw/ppc/pnv_spi_seeprom.c         | 989 +++++++++++++++++++++++++++++++
>   hw/ppc/meson.build               |   1 +
>   3 files changed, 1060 insertions(+)
>   create mode 100644 include/hw/ppc/pnv_spi_seeprom.h
>   create mode 100644 hw/ppc/pnv_spi_seeprom.c
> 
> diff --git a/include/hw/ppc/pnv_spi_seeprom.h b/include/hw/ppc/pnv_spi_seeprom.h
> new file mode 100644
> index 0000000000..9739e411b5
> --- /dev/null
> +++ b/include/hw/ppc/pnv_spi_seeprom.h
> @@ -0,0 +1,70 @@
> +/*
> + * QEMU PowerPC SPI SEEPROM model
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This model implements a Serial EEPROM utilizing the Serial Peripheral
> + * Interface (SPI) compatible bus.
> + * Currently supported variants: 25CSM04.
> + * The Microchip Technology Inc. 25CSM04 provides 4 Mbits of Serial EEPROM
> + * utilizing the Serial Peripheral Interface (SPI) compatible bus. The device
> + * is organized as 524288 bytes of 8 bits each (512Kbyte) and is optimized
> + * for use in consumer and industrial applications where reliable and
> + * dependable nonvolatile memory storage is essential
> + */
> +
> +#ifndef PPC_PNV_SPI_SEEPROM_H
> +#define PPC_PNV_SPI_SEEPROM_H
> +
> +#include "hw/ppc/pnv_spi_responder.h"
> +#include "qom/object.h"
> +
> +#define TYPE_PNV_SPI_SEEPROM "pnv-spi-seeprom"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(PnvSpiSeeprom, PNV_SPI_SEEPROM)
> +
> +typedef struct xfer_buffer xfer_buffer;
> +
> +typedef struct PnvSpiSeeprom {
> +    PnvSpiResponder resp;
> +
> +    char            *file; /* SEEPROM image file */
> +    uint8_t         opcode; /* SEEPROM Opcode */
> +    uint32_t        addr; /* SEEPROM Command Address */
> +    uint8_t         rd_state; /* READ State Machine state variable */
> +    bool            locked; /* Security Register Locked */
> +    bool            controller_connected; /* Flag for master connection */
> +    /*
> +     * Device registers
> +     * The 25CSM04 contains four types of registers that modulate device
> +     * operation and/or report on the current status of the device. These
> +     * registers are:
> +     * STATUS register
> +     * Security register
> +     * Memory Partition registers (eight total)
> +     * Identification register
> +     */
> +    uint8_t         status0;
> +    uint8_t         status1;
> +    /*
> +     * The Security register is split into
> +     * 1. user-programmable lockable ID page section.
> +     * 2. The read-only section contains a preprogrammed, globally unique,
> +     *    128-bit serial number.
> +     */
> +    uint8_t         uplid[256];
> +    uint8_t         dsn[16];
> +    uint8_t         mpr[8];
> +    uint8_t         idr[5];
> +} PnvSpiSeeprom;
> +
> +xfer_buffer *seeprom_spi_request(PnvSpiResponder *resp, int first, int last,
> +                int bits, xfer_buffer *payload);
> +void seeprom_connect_controller(PnvSpiResponder *resp, const char *port);
> +void seeprom_disconnect_controller(PnvSpiResponder *resp);
> +bool compute_addr(PnvSpiSeeprom *spi_resp, xfer_buffer *req_payload,
> +                   xfer_buffer *rsp_payload, int bits, uint32_t *data_offset);
> +bool validate_addr(PnvSpiSeeprom *spi_resp);
> +#endif /* PPC_PNV_SPI_SEEPROM_H */
> diff --git a/hw/ppc/pnv_spi_seeprom.c b/hw/ppc/pnv_spi_seeprom.c
> new file mode 100644
> index 0000000000..ae46610045
> --- /dev/null
> +++ b/hw/ppc/pnv_spi_seeprom.c
> @@ -0,0 +1,989 @@
> +/*
> + * QEMU PowerPC SPI SEEPROM model
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/ppc/pnv_spi_seeprom.h"
> +#include <math.h>
> +
> +#define SPI_DEBUG(x)
> +
> +/*
> + * 2-byte STATUS register which is a combination of six nonvolatile bits of
> + * EEPROM and five volatile latches.
> + *
> + * status 0:
> + * bit 7 WPEN: Write-Protect Enable bit
> + * 1 = Write-Protect pin is enabled, 0 = Write-Protect pin is ignored
> + *
> + * bit 3-2 BP<1:0>: Block Protection bits
> + * 00 = No array write protection
> + * 01 = Upper quarter memory array protection
> + * 10 = Upper half memory array protection
> + * 11 = Entire memory array protection
> + *
> + * bit 1 WEL: Write Enable Latch bit
> + * 1 = WREN has been executed and device is enabled for writing
> + * 0 = Device is not write-enabled
> + *
> + * bit 0 RDY/BSY: Ready/Busy Status Latch bit
> + * 1 = Device is busy with an internal write cycle
> + * 0 = Device is ready for a new sequence
> + */
> +#define STATUS0_WPEN        0x7
> +#define STATUS0_BP          0x2
> +#define STATUS0_WEL         0x1
> +#define STATUS0_BUSY        0x0
> +
> +/*
> + * status 1:
> + * bit 7 WPM: Write Protection Mode bit(1)
> + * 1 = Enhanced Write Protection mode selected (factory default)
> + * 0 = Legacy Write Protection mode selected
> + *
> + * bit 6 ECS: Error Correction State Latch bit
> + * 1 = The previously executed read sequence did require the ECC
> + * 0 = The previous executed read sequence did not require the ECC
> + *
> + * bit 5 FMPC: Freeze Memory Protection Configuration bit(2)
> + * 1 = Memory Partition registers and write protection mode are permanently
> + *     frozen and cannot be modified
> + * 0 = Memory Partition registers and write protection mode are not frozen
> + *     and are modifiable
> + *
> + * bit 4 PREL: Partition Register Write Enable Latch bit
> + * 1 = PRWE has been executed and WMPR, FRZR and PPAB instructions are enabled
> + * 0 = WMPR, FRZR and PPAB instructions are disabled
> + *
> + * bit 3 PABP: Partition Address Boundary Protection bit
> + * 1 = Partition Address Endpoints set in Memory Partition registers
> + *     cannot be modified
> + * 0 = Partition Address Endpoints set in Memory Partition registers
> + *     are modifiable
> + *
> + * bit 0 RDY/BSY: Ready/Busy Status Latch bit
> + * 1 = Device is busy with an internal write cycle
> + * 0 = Device is ready for a new sequence
> + */
> +#define STATUS1_WPM             0x7
> +#define STATUS1_ECS             0x6
> +#define STATUS1_FMPC            0x5
> +#define STATUS1_PREL            0x4
> +#define STATUS1_PABP            0x3
> +#define STATUS1_BUSY            0x0
> +
> +/*
> + * MEMORY PARTITION REGISTERS
> + * Note 1: The MPR cannot be written if the FMPC bit has been set.
> + *      2: The Partition Endpoint Address bits cannot be written if the PABP
> + *         bit has been set.
> + *
> + * bits 7-6 PB<1:0>: Partition Behavior bits(1)
> + * 00 = Partition is open and writing is permitted
> + *      factory default is unprotected.
> + * 01 = Partition is always write-protected but can be reversed at a later
> + *      time (software write-protected).
> + * 10 = Partition is write-protected only when WP pin is asserted
> + *      (hardware write-protected).
> + * 11 = Partition is software write-protected and MPR is permanently locked
> + *
> + * bit 5-0 A<18:13>: Partition Endpoint Address bits(1, 2)
> + * 000000 = Endpoint address of partition is set to 01FFFh.
> + * 000001 = Endpoint address of partition is set to 03FFFh.
> + * ----
> + * 111110 = Endpoint address of partition is set to 7DFFFh.
> + * 111111 = Endpoint address of partition is set to 7FFFFh.
> + */
> +#define MPR_PB                  0x6
> +#define MPR_PEA                 0x5
> +
> +/* INSTRUCTION SET FOR 25CSM04 */
> +#define RDSR        0x05
> +#define WRBP        0x08
> +#define WREN        0x06
> +#define WRDI        0x04
> +#define WRSR        0x01
> +#define READ        0x03
> +#define WRITE       0x0
> +#define RDEX_CHLK   0x83
> +#define WREX_LOCK   0x82
> +#define RMPR        0x31
> +#define PRWE        0x07
> +#define PRWD        0x0A
> +#define WMPR        0x32
> +#define PPAB        0x34
> +#define FRZR        0x37
> +#define SPID        0x9F
> +#define SRST        0x7C
> +
> +/* READ FSM state */
> +#define ST_IDLE     0
> +#define ST_READ     1
> +#define ST_SEC_READ 2
> +
> +xfer_buffer *seeprom_spi_request(PnvSpiResponder *resp,
> +        int first, int last, int bits, xfer_buffer *payload)
> +{
> +    PnvSpiSeeprom *seeprom = PNV_SPI_SEEPROM(resp);
> +    uint32_t data_offset = 0;
> +    int data_len = 0;
> +    xfer_buffer *rsp_payload = NULL;
> +    uint8_t *read_buf = NULL;
> +    uint8_t *buf = NULL;
> +    uint16_t idx;
> +    bool failed = false;

Add empty line after variables declaration.

> +    SPI_DEBUG(qemu_log("Received SPI request, first=%d, last=%d, bits=%d, "
> +              "payload length=%d\n", first, last, bits, payload->len));
> +    if (seeprom->controller_connected == false) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Controller is disconnected, invoke "
> +                      "connect method of spi_responder interface\n");
> +        return rsp_payload;
> +    }
> +    if (rsp_payload == NULL) {
> +        rsp_payload = xfer_buffer_new();
> +    }
> +    buf = xfer_buffer_write_ptr(rsp_payload, 0, payload->len);
> +    memset(buf, 0xFF, payload->len);
> +    /*
> +     * SPI communication is always full-duplex, so the controller receives as
> +     * many bits as it sends, although often both the responder and controller
> +     * device ignores some incoming bits. To simulate half-duplex the controller
> +     * sends zeros to the responder when controller is receiving and ignores
> +     * incoming data when the controller transmitting. So, a SPI response should
> +     * always have the same length in bits as the corresponding request.
> +     */
> +    if ((payload->len != ceil(bits / 8)) || (payload->len <= 0)) {

len is a uint32 and can never be < 0.

> +        qemu_log_mask(LOG_GUEST_ERROR, "Incorrect Payload size bits(%d) "
> +                      "Payload_len(%d bytes)\n", bits, payload->len);
> +        return rsp_payload;
> +    }
> +    if ((bits % 8) != 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "non-8bit aligned SPI transfer is "
> +                      "unimplemented\n");
> +        return rsp_payload;
> +    }
> +    /*
> +     * Different scenarios for first and last SPI interface method parameters
> +     *
> +     * first(1) and last(1)
> +     * SPI Controller can invoke spi_request with parameters first(1) and
> +     * last(1), which indicates this is first and last spi_request in this
> +     * transaction. This can be used when the valid data (excluding fake bytes)
> +     * transmitted or received over SPI is less than or equal to 8 Bytes
> +     *
> +     * first(1) and last(0), # (required) first request
> +     * first(0) and last(0), # (optional) in-between requests
> +     * first(0) and last(0), # (optional) in-between requests
> +     * ..
> +     * ..
> +     * first(0) and last(1), # (required) last request in the transaction
> +     * SPI Controller can invoke spi_request multiple times with parameters
> +     * first and last as shown in the sequence above for a transaction. This
> +     * can be used when the valid data(excluding fake bytes) transmitted or
> +     * received over SPI is more than 8 Bytes, SPI controller splits the
> +     * transaction into multiple requests, this is due to TDR and RDR size(8B)
> +     * restriction in SPI Controller.
> +     */
> +
> +    /*
> +     * check if first is "1", indicates a new incoming command sequence fetch
> +     * the opcode and address from payload.
> +     */
> +    if (first == 1) {
> +        /* Fetch opcode from offset 0 of payload */
> +        xfer_buffer_read_ptr(payload, &read_buf, 0, 1);
> +        seeprom->opcode = read_buf[0];
> +        SPI_DEBUG(qemu_log("Command Opcode (0x%x)\n", seeprom->opcode));
> +        /*
> +         * Check if device is busy with internal write cycle, During this
> +         * time, only the Read STATUS Register (RDSR) and the Write Ready/Busy
> +         * Poll (WRBP) instructions will be executed by the device.
> +         */
> +        bool status0_busy = extract8(seeprom->status0, STATUS0_BUSY, 1);
> +        bool status1_busy = extract8(seeprom->status1, STATUS1_BUSY, 1);

Variables should be declared at the top of the function or block.

> +        if (((status0_busy == 1) || (status1_busy == 1)) &&
> +            ((seeprom->opcode != RDSR) || (seeprom->opcode != WRBP))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Busy with Internal Write Cycle, "
> +                           "opcode(0x%x) not executed\n", seeprom->opcode);
> +            return rsp_payload;
> +        }
> +        /*
> +         * Implement a state machine for READ sequence, to catch an error
> +         * scenario when controller generates a new command sequence, with out
> +         * properly terminating the READ sequence, as shown below
> +         * first(1) and last(0), # READ command
> +         * first(0) and last(0), # READ command continues
> +         * ...
> +         * first(1) and last(0,1), # New command sequence
> +         * Not required to implement a state machine for write sequence as
> +         * we can leverage status register for it
> +         */
> +        if (seeprom->rd_state != ST_IDLE) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "New Command Sequence with "
> +                           "opcode(0x%x)is ignored Previous READ sequence is "
> +                           "not terminated properly!!! Continuing the previous "
> +                           "READ sequence\n", seeprom->opcode);
> +            seeprom->opcode = (seeprom->rd_state == ST_READ) ? READ :
> +                                                                 RDEX_CHLK;
> +        } else {
> +            /*
> +             * For a new command sequence compute Address and data offset in
> +             * xfer_buffer.
> +             */
> +            failed = compute_addr(seeprom, payload, rsp_payload, bits,
> +                            &data_offset);
> +            /*
> +             * Address computation failed, nothing to do further, just send
> +             * response and return from here.
> +             */ > +            if (failed == true) {
if (failed) {
> +                return rsp_payload;
> +            }
> +        }
> +    } /* end of branch if (first == 1) */

add empty line here

> +    switch (seeprom->opcode) {
> +    case READ:
> +        SPI_DEBUG(qemu_log("READ(0x%x), addr(0x%x)\n",
> +                  seeprom->opcode, seeprom->addr));
> +        seeprom->rd_state = ST_READ;
> +        data_len = payload->len - data_offset;
> +        /* Make sure data is at least 1 Byte */
> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB), "
> +                           "should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        /* Fill the buffer with the data read from image */
> +        buf = xfer_buffer_write_ptr(rsp_payload, data_offset, data_len);
> +        FILE *f;

Move variable decl to top of the block.

> +        if (seeprom->file) {
> +            f = fopen(seeprom->file, "rb+");
> +            if (f) {
> +                fseek(f, seeprom->addr, SEEK_SET);

Check return code.

> +                int read_len = fread(buf, sizeof(uint8_t), data_len, f);

move variable declaration to top of block

> +                if (read_len == data_len) {
> +                    SPI_DEBUG(qemu_log("Read %d bytes from seeprom\n",
> +                                            read_len));
> +                } else {
> +                    if (ferror(f)) {
> +                        SPI_DEBUG(qemu_log("Error reading seeprom\n"));
> +                    }
> +                }
> +            }
> +            fclose(f);
> +        }
> +        /* Check if last is 0 and increase address by data length */
> +        if (last == 0) {
> +            seeprom->addr = (seeprom->addr & 0x7FFFF) + data_len;
> +        } else {
> +            seeprom->rd_state = ST_IDLE;
> +        }
> +        break;
> +
> +    case RDSR:
> +        SPI_DEBUG(qemu_log("READ Status Register RDSR(0x%x)\n",
> +                    seeprom->opcode));
> +        data_len = payload->len - data_offset;
> +        /* Make sure data is at least 1 Byte */
> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB), "
> +                           "should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        buf = xfer_buffer_write_ptr(rsp_payload, data_offset, data_len);
> +        buf[0] = seeprom->status0;
> +        if (data_len == 2) {
> +            buf[1] = seeprom->status1;
> +        }
> +        break;
> +
> +    case WRBP:
> +        SPI_DEBUG(qemu_log("Write Ready/Busy Poll WRBP(0x%x)\n",
> +                    seeprom->opcode));
> +        data_len = payload->len - data_offset;
> +        /* Make sure data is at least 1 Byte */
> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB), "
> +                           "should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        buf = xfer_buffer_write_ptr(rsp_payload, data_offset, 0x1);
> +        bool status0_busy = extract8(seeprom->status0, STATUS0_BUSY, 1);
> +        bool status1_busy = extract8(seeprom->status1, STATUS1_BUSY, 1);

variable declaration

> +        if ((status0_busy == 1) || (status1_busy == 1)) {
> +            buf[0] = 0xFF;
> +        } else {
> +            buf[0] = 0x00;
> +        }
> +        break;
> +
> +    case WREN:
> +        SPI_DEBUG(qemu_log("Set Write Enable Latch (WEL) WREN(0x%x)\n",
> +                    seeprom->opcode));
> +        seeprom->status0 = deposit32(seeprom->status0, STATUS0_WEL, 1, 1);
> +        break;
> +
> +    case WRDI:
> +        SPI_DEBUG(qemu_log("Set Write Enable Latch (WEL) WRDI(0x%x)\n",
> +                    seeprom->opcode));
> +        seeprom->status0 = deposit32(seeprom->status0, STATUS0_WEL, 1, 0);
> +        break;
> +
> +    case WRSR:
> +        SPI_DEBUG(qemu_log("Write STATUS Register WRSR(0x%x)\n",
> +                    seeprom->opcode));
> +        if (extract8(seeprom->status0, STATUS0_WEL, 1) == 1) {
> +            data_len = payload->len - data_offset;
> +            /* Make sure data is at least 1 Byte */
> +            if (data_len <= 0) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB),"
> +                                 " should be at least 1 Byte\n", data_len);
> +                break;
> +            }
> +            /* Mask and update status0/1 bytes */
> +            xfer_buffer_read_ptr(payload, &read_buf, 1, 2);
> +            seeprom->status0 = read_buf[0] & 0x8C;
> +            /* 2nd Status Byte is optional */
> +            if (data_len == 2) {
> +                seeprom->status1 = read_buf[1] & 0x80;
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Set Write Enable Latch (WEL) "
> +                            "before doing WRSR\n");
> +        }
> +        break;
> +
> +    case SPID:
> +        SPI_DEBUG(qemu_log("READ IDENTIFICATION REGISTER, SPID(0x%x)\n",
> +                    seeprom->opcode));
> +        data_len = payload->len - data_offset;

Missing check here for data_len <= 0?

> +        buf = xfer_buffer_write_ptr(rsp_payload, data_offset, data_len);
> +        for (idx = 0; idx < data_len; idx++) {
> +            buf[idx] = seeprom->idr[idx];
> +        }

Use memcpy().

> +        break;
> +
> +    case SRST:
> +        SPI_DEBUG(qemu_log("Software Device Reset, SRST(0x%x)\n",
> +                    seeprom->opcode));
> +        /*
> +         * Note: The SRST instruction cannot interrupt the device while it is
> +         * in a Busy state (Section 6.1.4 Ready/Busy Status Latch).
> +         * This is already taken care when the command opcode is fetched
... taken care of ...

> +         *
> +         * 1.2 Device Default State
> +         * 1.2.1 POWER-UP DEFAULT STATE
> +         * The 25CSM04 default state upon power-up consists of:
> +         * - Standby Power mode (CS = HIGH)
> +         * - A high-to-low level transition on CS is required to enter the
> +         *   active state
> +         `* - WEL bit in the STATUS register = 0

stray '`'

> +         * - ECS bit in the STATUS register = 0
> +         * - PREL bit in the STATUS register = 0
> +         * - Ready/Busy (RDY/BUSY) bit in the STATUS register = 0, indicating
> +         *   the device is ready to accept a new instruction.
> +         */
> +        seeprom->status0 = deposit32(seeprom->status0, STATUS0_WEL, 1, 0);
> +        seeprom->status1 = deposit32(seeprom->status1, STATUS1_ECS, 1, 0);
> +        seeprom->status1 = deposit32(seeprom->status1, STATUS1_PREL, 1, 0);
> +        seeprom->status0 = deposit32(seeprom->status0, STATUS0_BUSY, 1, 0);
> +        seeprom->status1 = deposit32(seeprom->status1, STATUS1_BUSY, 1, 0);
> +        break;
> +
> +    case WRITE:
> +        SPI_DEBUG(qemu_log("WRITE(0x%x), addr(0x%x)\n",
> +                    seeprom->opcode, seeprom->addr));
> +        if (extract8(seeprom->status0, STATUS0_WEL, 1) != 1) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Device is not Write Enabled, "
> +                            "ignoring WRITE instruction\n");
> +            break;
> +        }
> +        /* Make sure data is at least 1 Byte */

You forgot to calculate data_len here it seems.

> +        if (data_len <= 0) {
> +            /*
> +             * first   last    comment
> +             * 0       0       data length cannot be 0
> +             * 0       1       data length cannot be 0
> +             * 1       0       data length can be 0, don't log error
> +             * 1       1       data length cannot be 0
> +             */
> +            if (!(first == 1 && (last == 0))) {

(first == 1) so it looks like (last == 0)

> +                qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB),"
> +                                    " should be at least 1 Byte\n", data_len);
> +                break;
> +            }
> +        }
> +        /* Write into SEEPROM Array */
> +        SPI_DEBUG(qemu_log("(%d)%s Write sequence\n", data_len,
> +                            (data_len == 1) ? "Byte" : "Bytes Page"));
> +        xfer_buffer_read_ptr(payload, &read_buf, data_offset, data_len);
> +        if (seeprom->file) {
> +            f = fopen(seeprom->file, "rb+");
> +            if (f) {
> +                fseek(f, seeprom->addr, SEEK_SET);

check return code

> +                int write_len = fwrite(read_buf, sizeof(uint8_t), data_len, f);

variable declaration

> +                if (write_len == data_len) {
> +                    SPI_DEBUG(qemu_log("Write %d bytes to seeprom\n",
> +                                            write_len));
> +                } else {
> +                    SPI_DEBUG(qemu_log("Failed to write seeprom\n"));
> +                }
> +            }
> +            fclose(f);
> +        }
> +        /* Increase offset in the page */
> +        seeprom->addr += data_len;
> +        /* Check if last is 1 and end the sequence */
> +        if (last == 1) {
> +            seeprom->status0 = deposit32(seeprom->status0, STATUS0_WEL, 1, 0);
> +        }
> +        break;
> +
> +    case RMPR:
> +        SPI_DEBUG(qemu_log("RMPR(0x%x) for MPR[%d]\n", seeprom->opcode,
> +                  extract8(seeprom->addr, 16, 2)));
> +        data_len = payload->len - data_offset
It may be worth considering another switch statement before this one 
where you do this repetitive data_len handling just once:

switch (seeprom->opcode) {
case READ:
...
case RMPR:
case WMPR:
case PPAB:
     data_len = payload->len - data_offset;
     if (data_len <= 0) {
         qem_log_mask(LOG_GUEST_ERROR, "%s: Insufficient number of 
bytes: %d", __func__, data_len););
         return NULL;
     }
     break;
default:
   /* does not access payload  */
}



> +        /* Make sure data is at least 1 Byte */
> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB),"
> +                             " should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        buf = xfer_buffer_write_ptr(rsp_payload, data_offset, 0x1);
> +        buf[0] = seeprom->mpr[extract8(seeprom->addr, 16, 2)];

What is '16' in this case (used agaoin below also)? Add comment or 
define a constant?

> +        break;
> +
> +    case PRWE:
> +        SPI_DEBUG(qemu_log("Set Memory Partition Write Enable Latch "
> +                    "PRWE(0x%x)\n", seeprom->opcode));
> +        seeprom->status1 = deposit32(seeprom->status1, STATUS1_PREL, 1, 1);
> +        break;
> +
> +    case PRWD:
> +        SPI_DEBUG(qemu_log("Reset Memory Partition Write Enable Latch "
> +                    "PRWD(0x%x)\n", seeprom->opcode));
> +        seeprom->status1 = deposit32(seeprom->status1, STATUS1_PREL, 1, 0);
> +        break;
> +
> +    case WMPR:
> +        SPI_DEBUG(qemu_log("Write Memory Partition Register[%d] WMPR(0x%x)\n",
> +                    extract8(seeprom->addr, 16, 2), seeprom->opcode));
> +        /*
> +         * Once the WEL and PREL bits in the STATUS register have been set to
> +         * 1, the Memory Partition registers can be programmed provided that
> +         * the FMPC bit in the STATUS register has not already been set to a
> +         * logic 1.
> +         */
> +        if ((extract8(seeprom->status0, STATUS0_WEL, 1) != 1) ||
> +            (extract8(seeprom->status1, STATUS1_PREL, 1) != 1) ||
> +            (extract8(seeprom->status1, STATUS1_FMPC, 1) == 1)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "ignoring Write to MPR\n");
> +            break;
> +        }
> +        data_len = payload->len - data_offset;
> +        /* Make sure data is at least 1 Byte */
> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB),"
> +                             " should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        xfer_buffer_read_ptr(payload, &read_buf, data_offset, 0x1);
> +        if (extract8(seeprom->status1, STATUS1_PABP, 1) == 1) {
> +            /* Partition Address Boundaries Protected */
> +            seeprom->mpr[extract8(seeprom->addr, 16, 2)] =
> +                ((read_buf[0] >> 6) & 0x3);
> +        } else {
> +            seeprom->mpr[extract8(seeprom->addr, 16, 2)] = read_buf[0];
> +        }
> +        seeprom->status0 = deposit32(seeprom->status0, STATUS0_WEL, 1, 0);
> +        seeprom->status1 = deposit32(seeprom->status1, STATUS1_PREL, 1, 0);
> +        break;
> +
> +    case PPAB:
> +        SPI_DEBUG(qemu_log("Protect Partition Address Boundaries PPAB(0x%x)\n",
> +                            seeprom->opcode));
> +        if ((extract8(seeprom->status0, STATUS0_WEL, 1) != 1) ||
> +            (extract8(seeprom->status1, STATUS1_PREL, 1) != 1) ||
> +            (extract8(seeprom->status1, STATUS1_FMPC, 1) == 1)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Ignoring PPAB command\n");
> +            break;
> +        }
> +        data_len = payload->len - data_offset;
> +        /* Make sure data is at least 1 Byte */
> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB),"
> +                             " should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        xfer_buffer_read_ptr(payload, &read_buf, data_offset, 0x1);
> +        if (read_buf[0] == 0xFF) {
> +            seeprom->status1 = deposit32(seeprom->status1,
> +                                            STATUS1_PABP, 1, 1);
> +        } else if (read_buf[0] == 0x0) {
> +            seeprom->status1 = deposit32(seeprom->status1,
> +                                            STATUS1_PABP, 1, 0);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Incorrect Data Byte(0x%x), "
> +                            "should be 0x0 or 0xFF\n", read_buf[0]);
> +        }
> +        seeprom->status0 = deposit32(seeprom->status0, STATUS0_WEL, 1, 0);
> +        seeprom->status1 = deposit32(seeprom->status1, STATUS1_PREL, 1, 0);
> +        break;
> +
> +    case FRZR:
> +        SPI_DEBUG(qemu_log("Freeze Memory Protection Configuration "
> +                                "FRZR(0x%x)\n", seeprom->opcode));
> +        if ((extract8(seeprom->status0, STATUS0_WEL, 1) != 1) ||
> +            (extract8(seeprom->status1, STATUS1_PREL, 1) != 1) ||
> +            (extract8(seeprom->status1, STATUS1_FMPC, 1) == 1)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "ignoring FRZR command\n");
> +            break;
> +        }
> +        data_len = payload->len - data_offset;
> +        /* Make sure data is at least 1 Byte */
> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB),"
> +                             " should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        xfer_buffer_read_ptr(payload, &read_buf, data_offset, 0x1);
> +        if (read_buf[0] == 0xD2) {
> +            seeprom->status1 = deposit32(seeprom->status1,
> +                                            STATUS1_FMPC, 1, 1);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Invalid Confirmation Data "
> +                            "byte(0x%x), expecting 0xD2", read_buf[0]);
> +        }
> +        seeprom->status0 = deposit32(seeprom->status0, STATUS0_WEL, 1, 0);
> +        seeprom->status1 = deposit32(seeprom->status1, STATUS1_PREL, 1, 0);
> +        break;
> +
> +    case RDEX_CHLK:
> +        SPI_DEBUG(qemu_log("OPCODE = (0x%x)\n", seeprom->opcode));
> +        data_len = payload->len - data_offset;
> +        /* Make sure data is at least 1 Byte */

byte not Byte -- everywhere

> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB),"
> +                             " should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        buf = xfer_buffer_write_ptr(rsp_payload, data_offset, data_len);
> +        if (extract8(seeprom->addr, 10, 1) == 0) {
> +            /* RDEX */
> +            seeprom->rd_state = ST_SEC_READ;
> +            for (idx = 0; idx < data_len; idx++) {

Probably the same and IMO easier to follow:

sidx = seeprom->addr & 0x1ff;
if (sidx <= 0xff)
    buf[idx] = seeprom->dsn[sidx]
else
    buf[idx] = seeprom->uplid[sidx & 0xff];

> +                if (extract32(seeprom->addr, 0, 9) <= 0xFF) {
> +                    buf[idx] = seeprom->dsn[extract8(seeprom->addr, 0, 8)];
> +                } else {
> +                    buf[idx] = seeprom->uplid[extract8(seeprom->addr, 0, 8)];
> +                }
> +                seeprom->addr = deposit32(seeprom->addr, 0, 9,
> +                                 ((extract32(seeprom->addr, 0, 9)) + 1));

I wonder what this is doing ...

seeprom->addr = (seeprom->addr & ~0x1ff) | ((seeprom->addr + 1) & 0x1ff)

> +            }
> +            if (last == 1) {
> +                seeprom->rd_state = ST_IDLE;
> +            } else {
> +                /* CHLK */
> +                if (seeprom->locked == true) {

if (seeprom->locked)

> +                    buf[0] = 0x01;
> +                } else {
> +                    buf[0] = 0x00;
> +                }
> +            }
> +        }
> +        break;
> +
> +    case WREX_LOCK:
> +        SPI_DEBUG(qemu_log("OPCODE = (0x%x)\n", seeprom->opcode));
> +        if (seeprom->locked == true) {

if (seeprom->locked)

> +            qemu_log_mask(LOG_GUEST_ERROR, "Device is already Locked, "
> +                            "command is ignored\n");
> +            break;
> +        }
> +        if (extract8(seeprom->status0, STATUS0_WEL, 1) != 1) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Device is not Write Enabled, "
> +                            "command is ignored\n");
> +            break;
> +        }
> +        data_len = payload->len - data_offset;
> +        /* Make sure data is at least 1 Byte */
> +        if (data_len <= 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Insufficient Data Bytes(%dB),"
> +                             " should be at least 1 Byte\n", data_len);
> +            break;
> +        }
> +        xfer_buffer_read_ptr(payload, &read_buf, data_offset, data_len);
> +        if (extract8(seeprom->addr, 10, 1) == 0) {

Can you add a comment why bit 10 must be 0?

> +            /* WREX */
> +            for (idx = 0; idx < data_len; idx++) {
> +                seeprom->uplid[extract8(seeprom->addr, 0, 8)] = read_buf[idx];
> +                /* Increase address with the page, and let it rool over */

you mean 'roll' over ? not sure what this means, though.

> +                seeprom->addr = deposit32(seeprom->addr, 0, 8,
> +                                 ((extract32(seeprom->addr, 0, 8)) + 1));

Are you just advancing the addr by '1' but then only modifying the 
lowest 9 bit and never touching bit 9?

> +            }
> +        } else {
> +            /*
> +             * LOCK (82h) instruction is clocked in on the  SI line, followed
> +             * by a fake address where  bits A[23:0] are don't care bits with
> +             * the exception that bit A10 must be set to 1. Finally, a
> +             * confirmation data byte of xxxx_xx1xb  is  sent
> +             */
> +            if ((buf[0] & 0x02) == 0x2) {
> +                seeprom->locked = true;
> +            }
> +        }
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid instruction(0x%x)\n",
> +                        seeprom->opcode);
> +    } /* end of switch */
> +    return rsp_payload;
> +} /* end of seeprom_spi_request */
> +
> +void seeprom_connect_controller(PnvSpiResponder *resp, const char *port)
> +{
> +    PnvSpiSeeprom *seeprom = PNV_SPI_SEEPROM(resp);
> +    seeprom->controller_connected = true;
> +}
> +
> +void seeprom_disconnect_controller(PnvSpiResponder *resp)
> +{
> +    PnvSpiSeeprom *seeprom = PNV_SPI_SEEPROM(resp);
> +    /* This method is invoked when Controller wants to deslect responder */

This method is called when the controller wants to deselect the responder

> +    seeprom->controller_connected = false;
> +    seeprom->rd_state = ST_IDLE; /* Reset Read state */
> +    if (seeprom->opcode == WRITE) { /* Reset Write enable */
> +        seeprom->status0 = deposit32(seeprom->status0, STATUS0_WEL, 1, 0);
> +    }
> +}
> +
> +/*
> + * Method : compute_addr
> + * This method is used to compute address and data offset for supported
> + * opcodes and only invoked when a valid new command sequence starts aka
> + * first is 1.
> + */
> +bool compute_addr(PnvSpiSeeprom *seeprom, xfer_buffer *req_payload,
> +                  xfer_buffer *rsp_payload, int bits, uint32_t  *data_offset)

remove additional space: uint32_t *data_offset

> +{
> +    bool addr_wr_protected = false;
> +    uint8_t *read_buf = NULL;
> +    *data_offset = 0;

move below variable declarations

> +    bool failed = false;
> +
> +    xfer_buffer_read_ptr(req_payload, &read_buf, 1, 3);
> +    switch (seeprom->opcode) {
> +    case READ:
> +    case WRITE:
> +        SPI_DEBUG(qemu_log("Compute address and payload buffer data offset "
> +                  "for %s\n", (seeprom->opcode == READ) ? "READ" : "WRITE"));
> +        /* command size is 4 bytes for READ/WRITE, data_offset is 4 */
> +        *data_offset = 4;
> +
> +        /* Make sure buffer length is at least 4 Bytes */
> +        if (req_payload->len >= 4) {
> +            /*
> +             * Fetch address from size 24 bit from offset 1,2,3 of payload
> +             * and mask of higher 5 bits as valid memory array size is 512KB
> +             */
> +            seeprom->addr = deposit32(seeprom->addr, 0, 8, read_buf[2]);
> +            seeprom->addr = deposit32(seeprom->addr, 8, 8, read_buf[1]);
> +            seeprom->addr = deposit32(seeprom->addr, 16, 8,
> +                            (read_buf[0] & 0x7));

seeprom->addr = ((read_buf[0] & 7) << 16) | (read_buf[1] << 8) | 
read_buf[2];

> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Payload_len(0x%x) should be at "
> +                          "least 4Bytes to fetch Address\n", req_payload->len);
> +            failed = true;
> +        }
> +        if (seeprom->opcode == WRITE) {
> +            addr_wr_protected = validate_addr(seeprom);
> +            if (addr_wr_protected) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "SEEPROM Address(0x%x) is Write "
> +                              "protected\n", seeprom->addr);
> +                failed = true;
> +            }
> +        }
> +        break;
> +
> +    case RDSR:
> +    case WRBP:
> +    case WRSR:
> +    case SPID:
> +        /*
> +         * command size is 1 bytes for RDSR, WRBP, WRSR, SPID. So data_offset
> +         * is 1
> +         */
> +        *data_offset = 1;
> +        break;
> +
> +    case RMPR:
> +    case WMPR:
> +        SPI_DEBUG(qemu_log("Compute MPR address for %s MPR\n",
> +                  (seeprom->opcode == RMPR) ? "READ" : "WRITE"));
> +        /* command size is 4 bytes for WMPR/RMPR, data_offset is 4 */
> +        *data_offset = 4;
> +
> +        /* Make sure buffer length is at least 4 Bytes */
> +        if (req_payload->len >= 4) {
> +            /*
> +             * The address for each Memory Partition register is embedded into
> +             * the first address byte sent to the device,in bit positions A18
> +             * through A16.
> +             */
> +            seeprom->addr = deposit32(seeprom->addr, 0, 15, 0);
> +            seeprom->addr = deposit32(seeprom->addr, 16, 8,
> +                                    (read_buf[0] & 0x7));

Imo the following would be better to read and understand:

seeprom->addr = (read_buf[0] & 7) << 16;

> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Payload_len(0x%x) should be at "
> +                          "least 4Bytes to fetch Address\n", req_payload->len);
> +            failed = true;
> +        }
> +        break;
> +
> +    case PPAB:
> +    case FRZR:
> +        SPI_DEBUG(qemu_log("Validate if addr[15:0] is %s\n",
> +                  (seeprom->opcode == PPAB) ? "0xCCFF for PPAB" :
> +                                               "0xAA40 for FRZR"));
> +        /* command size is 4 bytes for PPAB/FRZR, data_offset is 4 */
> +        *data_offset = 4;
> +        /* Make sure buffer length is at least 4 Bytes */
> +        if (req_payload->len >= 4) {
> +            /* Address bits A23-A16 are ignored. */
> +            seeprom->addr = deposit32(seeprom->addr, 0, 8, read_buf[2]);
> +            seeprom->addr = deposit32(seeprom->addr, 8, 8, read_buf[1]);
> +            seeprom->addr = deposit32(seeprom->addr, 16, 8, 0);

seeprom->addr = (read_buf[1] << 8) | read_buf[2];

> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Payload_len(0x%x) should be at "
> +                          "least 4Bytes to fetch Address\n", req_payload->len);
> +            failed = true;
> +            break;
> +        }
> +        /* Address bits A15-A0 must be set to CC55h. */
> +        if ((seeprom->opcode == PPAB) &&
> +            (extract32(seeprom->addr, 0, 15) != 0xCC55)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Invalid addr[15:0] = 0x%x sent for "
> +                          "PPAB\n", extract32(seeprom->addr, 0, 15));
> +            failed = true;
> +        }
> +        /* Address bits A15-A0 must be set to AA40h. */
> +        if ((seeprom->opcode == FRZR) &&
> +            (extract32(seeprom->addr, 0, 15) != 0xAA40)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Invalid addr[15:0] = 0x%x sent for "
> +                          "FRZR\n", extract32(seeprom->addr, 0, 15));
> +            failed = true;
> +        }
> +        break;
> +
> +    case RDEX_CHLK:
> +    case WREX_LOCK:
> +        SPI_DEBUG(qemu_log("Compute Address for Security reg command\n"));
> +        /* command size is 4 bytes for PPAB/FRZR, data_offset is 4 */
> +        *data_offset = 4;
> +
> +        /* Make sure buffer length is at least 4 Bytes */
> +        if (req_payload->len >= 4) {
> +            /*
> +             * RDEX : A[23:9] are don't care bits, except A10 which must be a
> +             *        logic 0.
> +             * WREX : A[23:9] are don't care bits, except A10 which must be a
> +             *        logic 0 and A8 which must be a logic 1 to address the
> +             *        second Security register byte that is user programmable.
> +             * CHLK : A[23:0] are don't care bits, except A10 which must be a
> +             *        logic 1.
> +             * LOCK : A[23:0] are don't care bits, except A10 which must be a
> +             *        logic 1.
> +             */
> +            seeprom->addr = deposit32(seeprom->addr, 0, 8, read_buf[2]);
> +            seeprom->addr = deposit32(seeprom->addr, 8, 8,
> +                                    (read_buf[1] & 0x05));
> +            seeprom->addr = deposit32(seeprom->addr, 16, 8, 0);

seeprom->addr = ((read_buf[1] & 0x5) << 8) | read_buf[2];

> +            SPI_DEBUG(qemu_log("Received Command %s\n",
> +                      (seeprom->opcode == RDEX_CHLK)
> +                       ? (extract32(seeprom->addr, 10, 1) ?
> +                          "CHLK : Check Lock Status of Security Register" :
> +                          "RDEX : Read from the Security Register")
> +                       : (extract32(seeprom->addr, 10, 1) ?
> +                          "LOCK : Lock the Security Register (permanent)" :
> +                          "WREX : Write to the Security Register")));
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Payload_len(0x%x) should be at "
> +                          "least 4Bytes to fetch Address\n", req_payload->len);
> +            failed = true;
> +        }
> +
> +        if ((seeprom->opcode == WREX_LOCK) &&
> +            (extract32(seeprom->addr, 10, 1) == 0)) {
> +            /*
> +             * WREX
> +             * In Legacy Write Protection mode, the Security register is
> +             * write-protected when the BP <1:0> bits (bits 3-2 byte0) of
> +             * the STATUS register = 11.
> +             */
> +            if (extract8(seeprom->status1, STATUS1_WPM, 1) == 0) {
> +                addr_wr_protected = validate_addr(seeprom);
> +            } else {
> +                if (extract32(seeprom->addr, 0, 9) <= 0xFF) {
> +                    addr_wr_protected = true;
> +                }
> +            }
> +            if (addr_wr_protected) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "SEEPROM Address(0x%x) is "
> +                              "Write protected\n", seeprom->addr);
> +                failed = true;
> +            }
> +        }
> +        break;
> +    } /* end of switch */
> +    return failed;
> +} /* end of method compute_addr */
> +
> +/*
> + * Method : validate_addr
> + * This method validates whether SEEPROM address is write protected or not
> + */
> +
> +bool validate_addr(PnvSpiSeeprom *seeprom)
> +{
> +    bool addr_wr_protected = false;
> +    uint8_t mpr_idx = 0;
> +
> +    if (extract8(seeprom->status1, STATUS1_WPM, 1) == 1) {
> +        /*
> +         * enhanced write protection
> +         * Memory partition register Bit5  through  bit0 contain the Partition
> +         * Endpoint Address of A18:A13, where A12:A0 are a logic "1". For
> +         * example, if the first partition of the memory array is desired to
> +         * stop after 128-Kbit of memory, that end point address is 03FFFh. The
> +         * corresponding A18:A13 address bits to be loaded into MPR0 are
> +         * therefore 000001b. The eight MPRs are each decoded sequentially by
> +         * the device, starting with MPR0. Each MPR should be set to a
> +         * Partition Endpoint Address greater than the ending address of the
> +         * previous MPR. If a higher order MPR sets a Partition Endpoint Address
> +         * less than or equal to the ending address of a lower order MPR, that
> +         * higher order MPR is ignored and no protection is set by it's
> +         * contents.
> +         */
> +        for (mpr_idx = 0; mpr_idx < 8; mpr_idx++) {
> +            if ((extract32(seeprom->addr, 13, 6)) <=
> +                (extract8(seeprom->mpr[mpr_idx], MPR_PEA, 1))) {
> +                switch (extract8(seeprom->mpr[mpr_idx], MPR_PB, 1)) {

Don't you have to extract 2 bits for the case values 0..3 below?

> +                case 0:
> +                    /*
> +                     * 0b00 = Partition is open and writing is permitted
> +                     * (factory default is unprotected).
> +                     */
> +                    addr_wr_protected = false;
> +                    break;
> +                case 1:
> +                    /*
> +                     * 0b01 = Partition is always write-protected but can be
> +                     * reversed at a later time (software write-protected).
> +                     */
> +                    addr_wr_protected = true;
> +                    break;
> +                case 2:
> +                    /*
> +                     * 0b10 = Partition is write-protected only when WP pin is
> +                     * asserted (hardware write-protected).
> +                     */
> +                    addr_wr_protected = false;
> +                    break;
> +                case 3:
> +                    /*
> +                     * 0b11 = Partition is software write-protected and Memory
> +                     * Partition register is permanently locked.
> +                     */
> +                    addr_wr_protected = true;
> +                    break;
> +                } /* end of switch */
> +                break; /* break from for loop. */
> +            }
> +        } /* end of for loop */
> +    } else {
> +        /* Legacy write protection mode */
> +        switch (extract8(seeprom->status0, STATUS0_BP, 2)) {

2 bits extracted -- good

> +        case 0:
> +            /*
> +             * 0b00 = No array write protection
> +             * EEPROM None
> +             * Security Register 00000h - 000FFh
> +             */
> +            if ((seeprom->opcode == WREX_LOCK) &&
> +                (extract32(seeprom->addr, 0, 9)  <= 0xFF)) {
> +                addr_wr_protected = true;
> +            }
> +            break;
> +        case 1:
> +            /*
> +             * 0b01 = Upper quarter memory array protection
> +             * EEPROM 60000h - 7FFFFh
> +             * Security Register 00000h - 000FFh
> +             */
> +            if ((seeprom->opcode == WREX_LOCK) &&
> +                (extract32(seeprom->addr, 0, 9)  <= 0xFF)) {
> +                addr_wr_protected = true;
> +            } else if ((seeprom->opcode == WRITE) &&
> +                       (extract32(seeprom->addr, 0, 19)  <= 0x60000)) {
> +                addr_wr_protected = true;
> +            }
> +            break;
> +        case 2:
> +            /*
> +             * 0b10 = Upper half memory array protection
> +             * EEPROM 40000h - 7FFFFh
> +             * Security Register 00000h - 000FFh
> +             */
> +            if ((seeprom->opcode == WREX_LOCK) &&
> +                (extract32(seeprom->addr, 0, 9)  <= 0xFF)) {
> +                addr_wr_protected = true;
> +            } else if ((seeprom->opcode == WRITE) &&
> +                       (extract32(seeprom->addr, 0, 19)  <= 0x40000)) {
> +                addr_wr_protected = true;
> +            }
> +            break;
> +        case 3:
> +            /*
> +             * 0b11 = Entire memory array protection
> +             * EEPROM 00000h - 7FFFFh
> +             * Security Register 00000h - 001FFh
> +             */
> +            addr_wr_protected = true;
> +            break;
> +        } /* end of switch */
> +    }
> +    return addr_wr_protected;
> +} /* end of validate_addr */
> +
> +static void pnv_spi_seeprom_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvSpiResponderClass *resp_class = PNV_SPI_RESPONDER_CLASS(klass);
> +
> +    resp_class->connect_controller = seeprom_connect_controller;
> +    resp_class->disconnect_controller = seeprom_disconnect_controller;
> +    resp_class->request = seeprom_spi_request;
> +
> +    dc->desc = "PowerNV SPI SEEPROM";
> +    dc->bus_type = TYPE_SPI_BUS;
> +}
> +
> +static const TypeInfo pnv_spi_seeprom_info = {
> +    .name          = TYPE_PNV_SPI_SEEPROM,
> +    .parent        = TYPE_PNV_SPI_RESPONDER,
> +    .instance_size = sizeof(PnvSpiSeeprom),
> +    .class_init    = pnv_spi_seeprom_class_init,
> +};
> +
> +static void pnv_spi_seeprom_register_types(void)
> +{
> +    type_register_static(&pnv_spi_seeprom_info);
> +}
> +
> +type_init(pnv_spi_seeprom_register_types);
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index de25cac763..2c1ef0c937 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -55,6 +55,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_pnor.c',
>     'pnv_spi_responder.c',
>     'pnv_spi_controller.c',
> +  'pnv_spi_seeprom.c',
>   ))
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(

