Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93CCC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 13:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHkmV-0000HI-Bo; Thu, 13 Jun 2024 09:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sHkmT-0000GQ-Bj; Thu, 13 Jun 2024 09:46:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sHkmO-0005YN-Hm; Thu, 13 Jun 2024 09:46:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D5tnN9031468;
 Thu, 13 Jun 2024 13:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:message-id:date:mime-version:subject:to:cc
 :references:from:in-reply-to; s=pp1; bh=Bd/z42buk7arr25sFe6c1n5r
 Tzw4MM4dBswO6kt0lJc=; b=ha0C/G+fbYYC9TVz5cG0Lguk071OaDtvv5wgzYs0
 Kf9sIB9nxi37ok1EcsYmOSvWNM3JiDM79RR04hW+6lT7JRGtFTdry5kcA5Mox0CJ
 QUQPgUTKPrTY007EK0vZHZ/wQfXAsqy5Uzgn7na8PUoFK6paJ7Ro4UiO66YX5TPV
 nFvmL5poAuY4boGsjRWJjmCLlBS39pO27Luu1OgfS1spLvjp01oQwcOA1g4Nb1Fw
 5f4vWst87pOxa1dklZKEg0QvrXjDU+JosJkQ/nWWYJC6MOzTvqw4VB1nPLPI51Ds
 gXiEiRM9gLX+yGYG5MhkpfRBdOcVw6ikqXEhVtDuiMf0TA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqrw11jut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 13:46:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DDkAqS031466;
 Thu, 13 Jun 2024 13:46:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqrw11jus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 13:46:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45DC9dGI023604; Thu, 13 Jun 2024 13:46:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn3umymyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 13:46:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45DDk5bS50790702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2024 13:46:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B78E2004E;
 Thu, 13 Jun 2024 13:46:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CE4820040;
 Thu, 13 Jun 2024 13:46:02 +0000 (GMT)
Received: from [9.43.47.2] (unknown [9.43.47.2])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2024 13:46:02 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------rTBw1SzC8cFUpirawqBGRZgV"
Message-ID: <38161823-19d4-4cd1-b85b-33b9beadb56b@linux.ibm.com>
Date: Thu, 13 Jun 2024 19:15:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ppc/pnv: Add SPI controller model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
 <20240515174149.17713-2-chalapathi.v@linux.ibm.com>
 <a671f38a-f7b0-433d-b016-a024964be8be@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <a671f38a-f7b0-433d-b016-a024964be8be@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BB6HFudahoVDAj-qisWa5HNQdL-6hyy1
X-Proofpoint-ORIG-GUID: pN4ZPRxLgyuINsEwZOGSav_WO1jJOkiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_05,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406130098
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
--------------rTBw1SzC8cFUpirawqBGRZgV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 20-05-2024 11:19, Cédric Le Goater wrote:
> On 5/15/24 19:41, Chalapathi V wrote:
>> SPI controller device model supports a connection to a single SPI 
>> responder.
>> This provide access to SPI seeproms, TPM, flash device and an ADC 
>> controller.
>>
>> All SPI function control is mapped into the SPI register space to 
>> enable full
>> control by firmware. In this commit SPI configuration component is 
>> modelled
>> which contains all SPI configuration and status registers as well as 
>> the hold
>> registers for data to be sent or having been received.
>>
>> An existing QEMU SSI framework is used and SSI_BUS is created.
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   include/hw/ppc/pnv_xscom.h    |   3 +
>>   include/hw/ssi/pnv_spi.h      |  44 +++++++
>>   include/hw/ssi/pnv_spi_regs.h | 114 +++++++++++++++++
>>   hw/ppc/pnv_spi_controller.c   | 228 ++++++++++++++++++++++++++++++++++
>
> The file names are not consistent.
>
> Please rename hw/ppc/pnv_spi_controller.c to /hw/ssi/pnv_spi.c.

Hello Cedric,

I could not compile hw/ssi/pnv_spi.c because of target specific code.

/FAILED: libcommon.fa.p/hw_ssi_pnv_spi.c.o
cc -m64 -mcx16 -Ilibcommon.fa.p -I/usr/include/p11-kit-1 
-I/usr/include/pixman-1 -I/usr/include/glib-2.0 
-I/usr/lib64/glib-2.0/include -I/usr/include/gio-unix-2.0/ 
-I/usr/include/slirp -fdiagnostics-color=auto -Wall -Winvalid-pch 
-Werror -std=gnu11 -O2 -g -fstack-protector-strong -Wundef 
-Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes 
-Wredundant-decls -Wold-style-declaration -Wold-style-definition 
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self 
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels 
-Wexpansion-to-defined -Wimplicit-fallthrough=2 
-Wmissing-format-attribute -Wno-missing-include-dirs 
-Wno-shift-negative-value -Wno-psabi -isystem <qemu_dir>/linux-headers 
-isystem linux-headers -iquote . -iquote <qemu_dir> -iquote 
<<qemu_dir>>/include -iquote <qemu_dir>/host/include/x86_64 
-iquote <qemu_dir>/host/include/generic -iquote <qemu_dir>/tcg/i386 
-pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
-fno-strict-aliasing -fno-common -fwrapv -fPIE -MD -MQ 
libcommon.fa.p/hw_ssi_pnv_spi.c.o -MF 
libcommon.fa.p/hw_ssi_pnv_spi.c.o.d -o libcommon.fa.p/hw_ssi_pnv_spi.c.o 
-c ../hw/ssi/pnv_spi.c
In file included from <qemu_dir>/target/ppc/cpu.h:25,
from <qemu_dir>/include/hw/ppc/pnv.h:24,
from <qemu_dir>/include/hw/ppc/pnv_xscom.h:24,
                  from ../hw/ssi/pnv_spi.c:12:
<qemu_dir>/include/exec/cpu-defs.h:23:2: error: #error cpu.h included 
from common code
  #error cpu.h included from common code
   ^~~~~
In file included from /<qemu_dir>/target/ppc/cpu.h:25,
from <qemu_dir>/include/hw/ppc/pnv.h:24,
from <qemu_dir>/include/hw/ppc/pnv_xscom.h:24,
                  from ../hw/ssi/pnv_spi.c:12:
<qemu_dir>/include/exec/cpu-defs.h:34:10: fatal error: cpu-param.h: No 
such file or directory
  #include "cpu-param.h"
           ^~~~~~~~~~~~~
compilation terminated.
/

Hence shall I keep pnv_spi.c in /hw/ppc/ ?

Thank You,

Chalapathi

>
>
>>   hw/ppc/Kconfig                |   1 +
>>   hw/ppc/meson.build            |   1 +
>>   hw/ppc/trace-events           |   6 +
>>   7 files changed, 397 insertions(+)
>>   create mode 100644 include/hw/ssi/pnv_spi.h
>>   create mode 100644 include/hw/ssi/pnv_spi_regs.h
>>   create mode 100644 hw/ppc/pnv_spi_controller.c
>>
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index 6209e18492..a77b97f9b1 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -194,6 +194,9 @@ struct PnvXScomInterfaceClass {
>>   #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards 
>> ... */
>>   #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
>>   +#define PNV10_XSCOM_PIB_SPIC_BASE 0xc0000
>> +#define PNV10_XSCOM_PIB_SPIC_SIZE 0x20
>> +
>>   void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);
>>   int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
>>                    uint64_t xscom_base, uint64_t xscom_size,
>> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
>> new file mode 100644
>> index 0000000000..244ee1cfc0
>> --- /dev/null
>> +++ b/include/hw/ssi/pnv_spi.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * QEMU PowerPC SPI Controller model
>> + *
>> + * Copyright (c) 2024, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This model Supports a connection to a single SPI responder.
>> + * Introduced for P10 to provide access to SPI seeproms, TPM, flash 
>> device
>> + * and an ADC controller.
>> + */
>> +#include "hw/ssi/ssi.h"
>> +
>> +#ifndef PPC_PNV_SPI_CONTROLLER_H
>> +#define PPC_PNV_SPI_CONTROLLER_H
>> +
>> +#define TYPE_PNV_SPI_CONTROLLER "pnv-spi-controller"
>> +#define PNV_SPICONTROLLER(obj) \
>> +        OBJECT_CHECK(PnvSpiController, (obj), TYPE_PNV_SPI_CONTROLLER)
>
> OBJECT_DECLARE_SIMPLE_TYPE(PnvSpiController, PNV_SPI_CONTROLLER)
>
> which means PNV_SPICONTROLLER -> PNV_SPI_CONTROLLER
>
>> +
>> +#define SPI_CONTROLLER_REG_SIZE 8
>
> please add a PNV_ prefix : PNV_SPI_CONTROLLER_REG_SIZE
>
>> +
>> +#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
>> +typedef struct PnvSpiController {
>> +    SysBusDevice parent_obj;
>> +
>> +    SSIBus *ssi_bus;
>> +    qemu_irq *cs_line;
>> +    MemoryRegion    xscom_spic_regs;
>> +    /* SPI controller object number */
>> +    uint32_t        spic_num;
>> +
>> +    /* SPI Controller registers */
>> +    uint64_t        error_reg;
>> +    uint64_t        counter_config_reg;
>> +    uint64_t        config_reg1;
>> +    uint64_t        clock_config_reset_control;
>> +    uint64_t        memory_mapping_reg;
>> +    uint64_t        transmit_data_reg;
>> +    uint64_t        receive_data_reg;
>> +    uint8_t sequencer_operation_reg[SPI_CONTROLLER_REG_SIZE];
>> +    uint64_t        status_reg;
>
> I don't think the _reg suffix are needed. This is minor.
>
>> +} PnvSpiController;
>> +#endif /* PPC_PNV_SPI_CONTROLLER_H */
>> diff --git a/include/hw/ssi/pnv_spi_regs.h 
>> b/include/hw/ssi/pnv_spi_regs.h
>> new file mode 100644
>> index 0000000000..6f613aca5e
>> --- /dev/null
>> +++ b/include/hw/ssi/pnv_spi_regs.h
>> @@ -0,0 +1,114 @@
>> +/*
>> + * QEMU PowerPC SPI Controller model
>> + *
>> + * Copyright (c) 2023, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef SPI_CONTROLLER_REGS_H
>> +#define SPI_CONTROLLER_REGS_H
>
> please add a PNV_ prefix
>
>> +
>> +/* Error Register */
>> +#define ERROR_REG                               0x00
>> +
>> +/* counter_config_reg */
>> +#define COUNTER_CONFIG_REG                      0x01
>> +#define COUNTER_CONFIG_REG_SHIFT_COUNT_N1       PPC_BITMASK(0, 7)
>> +#define COUNTER_CONFIG_REG_SHIFT_COUNT_N2       PPC_BITMASK(8, 15)
>> +#define COUNTER_CONFIG_REG_COUNT_COMPARE1       PPC_BITMASK(24, 31)
>> +#define COUNTER_CONFIG_REG_COUNT_COMPARE2       PPC_BITMASK(32, 39)
>> +#define COUNTER_CONFIG_REG_N1_COUNT_CONTROL     PPC_BITMASK(48, 51)
>> +#define COUNTER_CONFIG_REG_N2_COUNT_CONTROL     PPC_BITMASK(52, 55)
>> +
>> +/* config_reg */
>> +#define CONFIG_REG1                             0x02
>> +
>> +/* clock_config_reset_control_ecc_enable_reg */
>> +#define CLOCK_CONFIG_REG                        0x03
>> +#define CLOCK_CONFIG_RESET_CONTROL_HARD_RESET 0x0084000000000000;
>> +#define CLOCK_CONFIG_REG_RESET_CONTROL          PPC_BITMASK(24, 27)
>> +#define CLOCK_CONFIG_REG_ECC_CONTROL            PPC_BITMASK(28, 30)
>> +
>> +/* memory_mapping_reg */
>> +#define MEMORY_MAPPING_REG                      0x04
>> +#define MEMORY_MAPPING_REG_MMSPISM_BASE_ADDR    PPC_BITMASK(0, 15)
>> +#define MEMORY_MAPPING_REG_MMSPISM_ADDR_MASK    PPC_BITMASK(16, 31)
>> +#define MEMORY_MAPPING_REG_RDR_MATCH_VAL        PPC_BITMASK(32, 47)
>> +#define MEMORY_MAPPING_REG_RDR_MATCH_MASK       PPC_BITMASK(48, 63)
>> +
>> +/* transmit_data_reg */
>> +#define TRANSMIT_DATA_REG                       0x05
>> +
>> +/* receive_data_reg */
>> +#define RECEIVE_DATA_REG                        0x06
>> +
>> +/* sequencer_operation_reg */
>> +#define SEQUENCER_OPERATION_REG                 0x07
>> +
>> +/* status_reg */
>> +#define STATUS_REG                              0x08
>> +#define STATUS_REG_RDR_FULL                     PPC_BIT(0)
>> +#define STATUS_REG_RDR_OVERRUN                  PPC_BIT(1)
>> +#define STATUS_REG_RDR_UNDERRUN                 PPC_BIT(2)
>> +#define STATUS_REG_TDR_FULL                     PPC_BIT(4)
>> +#define STATUS_REG_TDR_OVERRUN                  PPC_BIT(5)
>> +#define STATUS_REG_TDR_UNDERRUN                 PPC_BIT(6)
>> +#define STATUS_REG_SEQUENCER_FSM                PPC_BITMASK(8, 15)
>> +#define STATUS_REG_SHIFTER_FSM                  PPC_BITMASK(16, 27)
>> +#define STATUS_REG_SEQUENCER_INDEX              PPC_BITMASK(28, 31)
>> +#define STATUS_REG_GENERAL_SPI_STATUS           PPC_BITMASK(32, 63)
>> +#define STATUS_REG_RDR                          PPC_BITMASK(1, 3)
>> +#define STATUS_REG_TDR                          PPC_BITMASK(5, 7)
>> +
>> +/*
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
>> +
>> +#endif
>> diff --git a/hw/ppc/pnv_spi_controller.c b/hw/ppc/pnv_spi_controller.c
>> new file mode 100644
>> index 0000000000..11b119cf0f
>> --- /dev/null
>> +++ b/hw/ppc/pnv_spi_controller.c
>> @@ -0,0 +1,228 @@
>> +/*
>> + * QEMU PowerPC SPI Controller model
>> + *
>> + * Copyright (c) 2024, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/ppc/pnv_xscom.h"
>> +#include "hw/ssi/pnv_spi.h"
>> +#include "hw/ssi/pnv_spi_regs.h"
>> +#include "hw/ssi/ssi.h"
>> +#include "hw/ppc/fdt.h"
>> +#include <libfdt.h>
>> +#include <math.h>
>
> why math.h ?
>
>> +#include "hw/irq.h"
>> +#include "trace.h"
>> +
>> +static uint64_t pnv_spi_controller_read(void *opaque, hwaddr addr,
>> +                                 unsigned size)
>> +{
>> +    PnvSpiController *s = PNV_SPICONTROLLER(opaque);
>> +    uint32_t reg = addr >> 3;
>> +    uint64_t val = ~0ull;
>> +
>> +    switch (reg) {
>> +    case ERROR_REG:
>> +        val = s->error_reg;
>> +        break;
>> +    case COUNTER_CONFIG_REG:
>> +        val = s->counter_config_reg;
>> +        break;
>> +    case CONFIG_REG1:
>> +        val = s->config_reg1;
>> +        break;
>> +    case CLOCK_CONFIG_REG:
>> +        val = s->clock_config_reset_control;
>> +        break;
>> +    case MEMORY_MAPPING_REG:
>> +        val = s->memory_mapping_reg;
>> +        break;
>> +    case TRANSMIT_DATA_REG:
>> +        val = s->transmit_data_reg;
>> +        break;
>> +    case RECEIVE_DATA_REG:
>> +        val = s->receive_data_reg;
>> +        trace_pnv_spi_read_RDR(val);
>> +        s->status_reg = SETFIELD(STATUS_REG_RDR_FULL, s->status_reg, 
>> 0);
>> +        break;
>> +    case SEQUENCER_OPERATION_REG:
>> +        val = 0;
>> +        for (int i = 0; i < SPI_CONTROLLER_REG_SIZE; i++) {
>> +            val = (val << 8) | s->sequencer_operation_reg[i];
>> +        }
>> +        break;
>> +    case STATUS_REG:
>> +        val = s->status_reg;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "spi_controller_regs: Invalid 
>> xscom "
>> +                 "read at 0x%08x\n", reg);
>
> Please use PRIx32 format
>
>> +    }
>> +
>> +    trace_pnv_spi_read(addr, val);
>> +    return val;
>> +}
>> +
>> +static void pnv_spi_controller_write(void *opaque, hwaddr addr,
>> +                                 uint64_t val, unsigned size)
>> +{
>> +    PnvSpiController *s = PNV_SPICONTROLLER(opaque);
>> +    uint32_t reg = addr >> 3;
>> +
>> +    trace_pnv_spi_write(addr, val);
>> +
>> +    switch (reg) {
>> +    case ERROR_REG:
>> +        s->error_reg = val;
>> +        break;
>> +    case COUNTER_CONFIG_REG:
>> +        s->counter_config_reg = val;
>> +        break;
>> +    case CONFIG_REG1:
>> +        s->config_reg1 = val;
>> +        break;
>> +    case CLOCK_CONFIG_REG:
>> +        /*
>> +         * To reset the SPI controller write the sequence 0x5 0xA to
>> +         * reset_control field
>> +         */
>> +        if (GETFIELD(CLOCK_CONFIG_REG_RESET_CONTROL,
>> + s->clock_config_reset_control) == 0x5) {
>> +            if (GETFIELD(CLOCK_CONFIG_REG_RESET_CONTROL, val) == 0xA) {
>> +                /* SPI controller reset sequence completed, 
>> resetting */
>> +                s->clock_config_reset_control =
>> + CLOCK_CONFIG_RESET_CONTROL_HARD_RESET;
>> +            } else {
>> +                s->clock_config_reset_control = val;
>> +            }
>> +        } else {
>> +            s->clock_config_reset_control = val;
>> +        }
>> +        break;
>> +    case MEMORY_MAPPING_REG:
>> +        s->memory_mapping_reg = val;
>> +        break;
>> +    case TRANSMIT_DATA_REG:
>> +        /*
>> +         * Writing to the transmit data register causes the transmit 
>> data
>> +         * register full status bit in the status register to be 
>> set.  Writing
>> +         * when the transmit data register full status bit is 
>> already set
>> +         * causes a "Resource Not Available" condition.  This is not 
>> possible
>> +         * in the model since writes to this register are not 
>> asynchronous to
>> +         * the operation sequence like it would be in hardware.
>> +         */
>> +        s->transmit_data_reg = val;
>> +        trace_pnv_spi_write_TDR(val);
>> +        s->status_reg = SETFIELD(STATUS_REG_TDR_FULL, s->status_reg, 
>> 1);
>> +        s->status_reg = SETFIELD(STATUS_REG_TDR_UNDERRUN, 
>> s->status_reg, 0);
>> +        break;
>> +    case RECEIVE_DATA_REG:
>> +        s->receive_data_reg = val;
>> +        break;
>> +    case SEQUENCER_OPERATION_REG:
>> +        for (int i = 0; i < SPI_CONTROLLER_REG_SIZE; i++) {
>> +            s->sequencer_operation_reg[i] = (val >> (56 - i * 8)) & 
>> 0xFF;
>> +        }
>> +        break;
>> +    case STATUS_REG:
>> +        /* other fields are ignore_write */
>> +        s->status_reg = SETFIELD(STATUS_REG_RDR_OVERRUN, s->status_reg,
>> +                                  GETFIELD(STATUS_REG_RDR, val));
>> +        s->status_reg = SETFIELD(STATUS_REG_TDR_OVERRUN, s->status_reg,
>> +                                  GETFIELD(STATUS_REG_TDR, val));
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "spi_controller_regs: Invalid 
>> xscom "
>> +                 "write at 0x%08x\n", reg);
>
>
> Please use PRIx32 format
>
>
> Thanks,
>
> C.
>
>
>> +    }
>> +    return;
>> +}
>> +
>> +static const MemoryRegionOps pnv_spi_controller_xscom_ops = {
>> +    .read = pnv_spi_controller_read,
>> +    .write = pnv_spi_controller_write,
>> +    .valid.min_access_size = 8,
>> +    .valid.max_access_size = 8,
>> +    .impl.min_access_size = 8,
>> +    .impl.max_access_size = 8,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static Property pnv_spi_controller_properties[] = {
>> +    DEFINE_PROP_UINT32("spic_num", PnvSpiController, spic_num, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void pnv_spi_controller_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PnvSpiController *s = PNV_SPICONTROLLER(dev);
>> +    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
>> +                    s->spic_num);
>> +    s->ssi_bus = ssi_create_bus(dev, name);
>> +    s->cs_line = g_new0(qemu_irq, 1);
>> +    qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
>> +
>> +    /* spi controller scoms */
>> +    pnv_xscom_region_init(&s->xscom_spic_regs, OBJECT(s),
>> +                          &pnv_spi_controller_xscom_ops, s,
>> +                          "xscom-spi-controller-regs",
>> +                          PNV10_XSCOM_PIB_SPIC_SIZE);
>> +}
>> +
>> +static int pnv_spi_controller_dt_xscom(PnvXScomInterface *dev, void 
>> *fdt,
>> +                             int offset)
>> +{
>> +    PnvSpiController *s = PNV_SPICONTROLLER(dev);
>> +    g_autofree char *name;
>> +    int s_offset;
>> +    const char compat[] = "ibm,power10-spi_controller";
>> +    uint32_t spic_pcba = PNV10_XSCOM_PIB_SPIC_BASE +
>> +        s->spic_num * PNV10_XSCOM_PIB_SPIC_SIZE;
>> +    uint32_t reg[] = {
>> +        cpu_to_be32(spic_pcba),
>> +        cpu_to_be32(PNV10_XSCOM_PIB_SPIC_SIZE)
>> +    };
>> +    name = g_strdup_printf("spi_controller@%x", spic_pcba);
>> +    s_offset = fdt_add_subnode(fdt, offset, name);
>> +    _FDT(s_offset);
>> +
>> +    _FDT(fdt_setprop(fdt, s_offset, "reg", reg, sizeof(reg)));
>> +    _FDT(fdt_setprop(fdt, s_offset, "compatible", compat, 
>> sizeof(compat)));
>> +    _FDT((fdt_setprop_cell(fdt, s_offset, "spic_num#", s->spic_num)));
>> +    return 0;
>> +}
>> +
>> +static void pnv_spi_controller_class_init(ObjectClass *klass, void 
>> *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
>> +
>> +    xscomc->dt_xscom = pnv_spi_controller_dt_xscom;
>> +
>> +    dc->desc = "PowerNV SPI Controller";
>> +    dc->realize = pnv_spi_controller_realize;
>> +    device_class_set_props(dc, pnv_spi_controller_properties);
>> +}
>> +
>> +static const TypeInfo pnv_spi_controller_info = {
>> +    .name          = TYPE_PNV_SPI_CONTROLLER,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(PnvSpiController),
>> +    .class_init    = pnv_spi_controller_class_init,
>> +    .interfaces    = (InterfaceInfo[]) {
>> +        { TYPE_PNV_XSCOM_INTERFACE },
>> +        { }
>> +    }
>> +};
>> +
>> +static void pnv_spi_controller_register_types(void)
>> +{
>> +    type_register_static(&pnv_spi_controller_info);
>> +}
>> +
>> +type_init(pnv_spi_controller_register_types);
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index 78f83e78ce..6f9670b377 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -39,6 +39,7 @@ config POWERNV
>>       select PCI_POWERNV
>>       select PCA9552
>>       select PCA9554
>> +    select SSI
>>     config PPC405
>>       bool
>> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
>> index d096636ee7..68fadbae7b 100644
>> --- a/hw/ppc/meson.build
>> +++ b/hw/ppc/meson.build
>> @@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>>     'pnv_pnor.c',
>>     'pnv_nest_pervasive.c',
>>     'pnv_n1_chiplet.c',
>> +  'pnv_spi_controller.c',
>>   ))
>>   # PowerPC 4xx boards
>>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>> index bf29bbfd4b..b8e494ffc5 100644
>> --- a/hw/ppc/trace-events
>> +++ b/hw/ppc/trace-events
>> @@ -110,6 +110,12 @@ pnv_sbe_cmd_timer_stop(void) ""
>>   pnv_sbe_cmd_timer_expired(void) ""
>>   pnv_sbe_msg_recv(uint16_t cmd, uint16_t seq, uint16_t ctrl_flags) 
>> "cmd 0x%" PRIx16 " seq %"PRIu16 " ctrl_flags 0x%" PRIx16
>>   +#pnv_spi_controller.c
>> +pnv_spi_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 
>> 0x%" PRIx64
>> +pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 
>> 0x%" PRIx64
>> +pnv_spi_read_RDR(uint64_t val) "data extracted = 0x%" PRIx64
>> +pnv_spi_write_TDR(uint64_t val) "being written, data written = 0x%" 
>> PRIx64
>> +
>>   # ppc.c
>>   ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t diff, int64_t 
>> seconds) "adjusted from 0x%"PRIx64" to 0x%"PRIx64", diff %"PRId64" 
>> (%"PRId64"s)"
>>   ppc_tb_load(uint64_t tb) "tb 0x%016" PRIx64
>
--------------rTBw1SzC8cFUpirawqBGRZgV
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
    <div class="moz-cite-prefix">On 20-05-2024 11:19, Cédric Le Goater
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:a671f38a-f7b0-433d-b016-a024964be8be@kaod.org">On
      5/15/24 19:41, Chalapathi V wrote:
      <br>
      <blockquote type="cite">SPI controller device model supports a
        connection to a single SPI responder.
        <br>
        This provide access to SPI seeproms, TPM, flash device and an
        ADC controller.
        <br>
        <br>
        All SPI function control is mapped into the SPI register space
        to enable full
        <br>
        control by firmware. In this commit SPI configuration component
        is modelled
        <br>
        which contains all SPI configuration and status registers as
        well as the hold
        <br>
        registers for data to be sent or having been received.
        <br>
        <br>
        An existing QEMU SSI framework is used and SSI_BUS is created.
        <br>
        <br>
        Signed-off-by: Chalapathi V <a class="moz-txt-link-rfc2396E" href="mailto:chalapathi.v@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a>
        <br>
        ---
        <br>
          include/hw/ppc/pnv_xscom.h    |   3 +
        <br>
          include/hw/ssi/pnv_spi.h      |  44 +++++++
        <br>
          include/hw/ssi/pnv_spi_regs.h | 114 +++++++++++++++++
        <br>
          hw/ppc/pnv_spi_controller.c   | 228
        ++++++++++++++++++++++++++++++++++
        <br>
      </blockquote>
      <br>
      The file names are not consistent.
      <br>
      <br>
      Please rename hw/ppc/pnv_spi_controller.c to /hw/ssi/pnv_spi.c.<br>
    </blockquote>
    <p>Hello Cedric,</p>
    <p>I could not compile hw/ssi/pnv_spi.c because of target specific
      code. <br>
    </p>
    <p><font size="2"><i>FAILED: libcommon.fa.p/hw_ssi_pnv_spi.c.o <br>
          cc -m64 -mcx16 -Ilibcommon.fa.p -I/usr/include/p11-kit-1
          -I/usr/include/pixman-1 -I/usr/include/glib-2.0
          -I/usr/lib64/glib-2.0/include -I/usr/include/gio-unix-2.0/
          -I/usr/include/slirp -fdiagnostics-color=auto -Wall
          -Winvalid-pch -Werror -std=gnu11 -O2 -g
          -fstack-protector-strong -Wundef -Wwrite-strings
          -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls
          -Wold-style-declaration -Wold-style-definition -Wtype-limits
          -Wformat-security -Wformat-y2k -Winit-self
          -Wignored-qualifiers -Wempty-body -Wnested-externs
          -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=2
          -Wmissing-format-attribute -Wno-missing-include-dirs
          -Wno-shift-negative-value -Wno-psabi -isystem
          &lt;qemu_dir&gt;/linux-headers -isystem linux-headers -iquote
          . -iquote &lt;qemu_dir&gt; -iquote
          &lt;&lt;qemu_dir&gt;&gt;/include
          -iquote &lt;qemu_dir&gt;/host/include/x86_64
          -iquote &lt;qemu_dir&gt;/host/include/generic
          -iquote &lt;qemu_dir&gt;/tcg/i386 -pthread -D_GNU_SOURCE
          -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
          -fno-strict-aliasing -fno-common -fwrapv -fPIE -MD -MQ
          libcommon.fa.p/hw_ssi_pnv_spi.c.o -MF
          libcommon.fa.p/hw_ssi_pnv_spi.c.o.d -o
          libcommon.fa.p/hw_ssi_pnv_spi.c.o -c ../hw/ssi/pnv_spi.c<br>
          In file included from &lt;qemu_dir&gt;/target/ppc/cpu.h:25,<br>
                          
          from &lt;qemu_dir&gt;/include/hw/ppc/pnv.h:24,<br>
                          
          from &lt;qemu_dir&gt;/include/hw/ppc/pnv_xscom.h:24,<br>
                           from ../hw/ssi/pnv_spi.c:12:<br>
          &lt;qemu_dir&gt;/include/exec/cpu-defs.h:23:2: error: #error
          cpu.h included from common code<br>
           #error cpu.h included from common code<br>
            ^~~~~<br>
          In file included from /&lt;qemu_dir&gt;/target/ppc/cpu.h:25,<br>
                          
          from &lt;qemu_dir&gt;/include/hw/ppc/pnv.h:24,<br>
                          
          from &lt;qemu_dir&gt;/include/hw/ppc/pnv_xscom.h:24,<br>
                           from ../hw/ssi/pnv_spi.c:12:<br>
          &lt;qemu_dir&gt;/include/exec/cpu-defs.h:34:10: fatal error:
          cpu-param.h: No such file or directory<br>
           #include "cpu-param.h"<br>
                    ^~~~~~~~~~~~~<br>
          compilation terminated.<br>
        </i></font></p>
    <p>Hence shall I keep pnv_spi.c in /hw/ppc/ ?</p>
    <p>Thank You,</p>
    <p>Chalapathi<br>
    </p>
    <blockquote type="cite"
      cite="mid:a671f38a-f7b0-433d-b016-a024964be8be@kaod.org">
      <br>
      <br>
      <blockquote type="cite">  hw/ppc/Kconfig                |   1 +
        <br>
          hw/ppc/meson.build            |   1 +
        <br>
          hw/ppc/trace-events           |   6 +
        <br>
          7 files changed, 397 insertions(+)
        <br>
          create mode 100644 include/hw/ssi/pnv_spi.h
        <br>
          create mode 100644 include/hw/ssi/pnv_spi_regs.h
        <br>
          create mode 100644 hw/ppc/pnv_spi_controller.c
        <br>
        <br>
        diff --git a/include/hw/ppc/pnv_xscom.h
        b/include/hw/ppc/pnv_xscom.h
        <br>
        index 6209e18492..a77b97f9b1 100644
        <br>
        --- a/include/hw/ppc/pnv_xscom.h
        <br>
        +++ b/include/hw/ppc/pnv_xscom.h
        <br>
        @@ -194,6 +194,9 @@ struct PnvXScomInterfaceClass {
        <br>
          #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes
        upwards ... */
        <br>
          #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
        <br>
          +#define PNV10_XSCOM_PIB_SPIC_BASE 0xc0000
        <br>
        +#define PNV10_XSCOM_PIB_SPIC_SIZE 0x20
        <br>
        +
        <br>
          void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr
        addr);
        <br>
          int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
        <br>
                           uint64_t xscom_base, uint64_t xscom_size,
        <br>
        diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
        <br>
        new file mode 100644
        <br>
        index 0000000000..244ee1cfc0
        <br>
        --- /dev/null
        <br>
        +++ b/include/hw/ssi/pnv_spi.h
        <br>
        @@ -0,0 +1,44 @@
        <br>
        +/*
        <br>
        + * QEMU PowerPC SPI Controller model
        <br>
        + *
        <br>
        + * Copyright (c) 2024, IBM Corporation.
        <br>
        + *
        <br>
        + * SPDX-License-Identifier: GPL-2.0-or-later
        <br>
        + *
        <br>
        + * This model Supports a connection to a single SPI responder.
        <br>
        + * Introduced for P10 to provide access to SPI seeproms, TPM,
        flash device
        <br>
        + * and an ADC controller.
        <br>
        + */
        <br>
        +#include "hw/ssi/ssi.h"
        <br>
        +
        <br>
        +#ifndef PPC_PNV_SPI_CONTROLLER_H
        <br>
        +#define PPC_PNV_SPI_CONTROLLER_H
        <br>
        +
        <br>
        +#define TYPE_PNV_SPI_CONTROLLER "pnv-spi-controller"
        <br>
        +#define PNV_SPICONTROLLER(obj) \
        <br>
        +        OBJECT_CHECK(PnvSpiController, (obj),
        TYPE_PNV_SPI_CONTROLLER)
        <br>
      </blockquote>
      <br>
      OBJECT_DECLARE_SIMPLE_TYPE(PnvSpiController, PNV_SPI_CONTROLLER)
      <br>
      <br>
      which means PNV_SPICONTROLLER -&gt; PNV_SPI_CONTROLLER
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +#define SPI_CONTROLLER_REG_SIZE 8
        <br>
      </blockquote>
      <br>
      please add a PNV_ prefix : PNV_SPI_CONTROLLER_REG_SIZE
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
        <br>
        +typedef struct PnvSpiController {
        <br>
        +    SysBusDevice parent_obj;
        <br>
        +
        <br>
        +    SSIBus *ssi_bus;
        <br>
        +    qemu_irq *cs_line;
        <br>
        +    MemoryRegion    xscom_spic_regs;
        <br>
        +    /* SPI controller object number */
        <br>
        +    uint32_t        spic_num;
        <br>
        +
        <br>
        +    /* SPI Controller registers */
        <br>
        +    uint64_t        error_reg;
        <br>
        +    uint64_t        counter_config_reg;
        <br>
        +    uint64_t        config_reg1;
        <br>
        +    uint64_t        clock_config_reset_control;
        <br>
        +    uint64_t        memory_mapping_reg;
        <br>
        +    uint64_t        transmit_data_reg;
        <br>
        +    uint64_t        receive_data_reg;
        <br>
        +    uint8_t        
        sequencer_operation_reg[SPI_CONTROLLER_REG_SIZE];
        <br>
        +    uint64_t        status_reg;
        <br>
      </blockquote>
      <br>
      I don't think the _reg suffix are needed. This is minor.
      <br>
      <br>
      <blockquote type="cite">+} PnvSpiController;
        <br>
        +#endif /* PPC_PNV_SPI_CONTROLLER_H */
        <br>
        diff --git a/include/hw/ssi/pnv_spi_regs.h
        b/include/hw/ssi/pnv_spi_regs.h
        <br>
        new file mode 100644
        <br>
        index 0000000000..6f613aca5e
        <br>
        --- /dev/null
        <br>
        +++ b/include/hw/ssi/pnv_spi_regs.h
        <br>
        @@ -0,0 +1,114 @@
        <br>
        +/*
        <br>
        + * QEMU PowerPC SPI Controller model
        <br>
        + *
        <br>
        + * Copyright (c) 2023, IBM Corporation.
        <br>
        + *
        <br>
        + * SPDX-License-Identifier: GPL-2.0-or-later
        <br>
        + */
        <br>
        +
        <br>
        +#ifndef SPI_CONTROLLER_REGS_H
        <br>
        +#define SPI_CONTROLLER_REGS_H
        <br>
      </blockquote>
      <br>
      please add a PNV_ prefix
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +/* Error Register */
        <br>
        +#define ERROR_REG                               0x00
        <br>
        +
        <br>
        +/* counter_config_reg */
        <br>
        +#define COUNTER_CONFIG_REG                      0x01
        <br>
        +#define COUNTER_CONFIG_REG_SHIFT_COUNT_N1       PPC_BITMASK(0,
        7)
        <br>
        +#define COUNTER_CONFIG_REG_SHIFT_COUNT_N2       PPC_BITMASK(8,
        15)
        <br>
        +#define COUNTER_CONFIG_REG_COUNT_COMPARE1       PPC_BITMASK(24,
        31)
        <br>
        +#define COUNTER_CONFIG_REG_COUNT_COMPARE2       PPC_BITMASK(32,
        39)
        <br>
        +#define COUNTER_CONFIG_REG_N1_COUNT_CONTROL     PPC_BITMASK(48,
        51)
        <br>
        +#define COUNTER_CONFIG_REG_N2_COUNT_CONTROL     PPC_BITMASK(52,
        55)
        <br>
        +
        <br>
        +/* config_reg */
        <br>
        +#define CONFIG_REG1                             0x02
        <br>
        +
        <br>
        +/* clock_config_reset_control_ecc_enable_reg */
        <br>
        +#define CLOCK_CONFIG_REG                        0x03
        <br>
        +#define CLOCK_CONFIG_RESET_CONTROL_HARD_RESET  
        0x0084000000000000;
        <br>
        +#define CLOCK_CONFIG_REG_RESET_CONTROL          PPC_BITMASK(24,
        27)
        <br>
        +#define CLOCK_CONFIG_REG_ECC_CONTROL            PPC_BITMASK(28,
        30)
        <br>
        +
        <br>
        +/* memory_mapping_reg */
        <br>
        +#define MEMORY_MAPPING_REG                      0x04
        <br>
        +#define MEMORY_MAPPING_REG_MMSPISM_BASE_ADDR    PPC_BITMASK(0,
        15)
        <br>
        +#define MEMORY_MAPPING_REG_MMSPISM_ADDR_MASK    PPC_BITMASK(16,
        31)
        <br>
        +#define MEMORY_MAPPING_REG_RDR_MATCH_VAL        PPC_BITMASK(32,
        47)
        <br>
        +#define MEMORY_MAPPING_REG_RDR_MATCH_MASK       PPC_BITMASK(48,
        63)
        <br>
        +
        <br>
        +/* transmit_data_reg */
        <br>
        +#define TRANSMIT_DATA_REG                       0x05
        <br>
        +
        <br>
        +/* receive_data_reg */
        <br>
        +#define RECEIVE_DATA_REG                        0x06
        <br>
        +
        <br>
        +/* sequencer_operation_reg */
        <br>
        +#define SEQUENCER_OPERATION_REG                 0x07
        <br>
        +
        <br>
        +/* status_reg */
        <br>
        +#define STATUS_REG                              0x08
        <br>
        +#define STATUS_REG_RDR_FULL                     PPC_BIT(0)
        <br>
        +#define STATUS_REG_RDR_OVERRUN                  PPC_BIT(1)
        <br>
        +#define STATUS_REG_RDR_UNDERRUN                 PPC_BIT(2)
        <br>
        +#define STATUS_REG_TDR_FULL                     PPC_BIT(4)
        <br>
        +#define STATUS_REG_TDR_OVERRUN                  PPC_BIT(5)
        <br>
        +#define STATUS_REG_TDR_UNDERRUN                 PPC_BIT(6)
        <br>
        +#define STATUS_REG_SEQUENCER_FSM                PPC_BITMASK(8,
        15)
        <br>
        +#define STATUS_REG_SHIFTER_FSM                  PPC_BITMASK(16,
        27)
        <br>
        +#define STATUS_REG_SEQUENCER_INDEX              PPC_BITMASK(28,
        31)
        <br>
        +#define STATUS_REG_GENERAL_SPI_STATUS           PPC_BITMASK(32,
        63)
        <br>
        +#define STATUS_REG_RDR                          PPC_BITMASK(1,
        3)
        <br>
        +#define STATUS_REG_TDR                          PPC_BITMASK(5,
        7)
        <br>
        +
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
        +
        <br>
        +#endif
        <br>
        diff --git a/hw/ppc/pnv_spi_controller.c
        b/hw/ppc/pnv_spi_controller.c
        <br>
        new file mode 100644
        <br>
        index 0000000000..11b119cf0f
        <br>
        --- /dev/null
        <br>
        +++ b/hw/ppc/pnv_spi_controller.c
        <br>
        @@ -0,0 +1,228 @@
        <br>
        +/*
        <br>
        + * QEMU PowerPC SPI Controller model
        <br>
        + *
        <br>
        + * Copyright (c) 2024, IBM Corporation.
        <br>
        + *
        <br>
        + * SPDX-License-Identifier: GPL-2.0-or-later
        <br>
        + */
        <br>
        +
        <br>
        +#include "qemu/osdep.h"
        <br>
        +#include "qemu/log.h"
        <br>
        +#include "hw/qdev-properties.h"
        <br>
        +#include "hw/ppc/pnv_xscom.h"
        <br>
        +#include "hw/ssi/pnv_spi.h"
        <br>
        +#include "hw/ssi/pnv_spi_regs.h"
        <br>
        +#include "hw/ssi/ssi.h"
        <br>
        +#include "hw/ppc/fdt.h"
        <br>
        +#include &lt;libfdt.h&gt;
        <br>
        +#include &lt;math.h&gt;
        <br>
      </blockquote>
      <br>
      why math.h ?
      <br>
      <br>
      <blockquote type="cite">+#include "hw/irq.h"
        <br>
        +#include "trace.h"
        <br>
        +
        <br>
        +static uint64_t pnv_spi_controller_read(void *opaque, hwaddr
        addr,
        <br>
        +                                 unsigned size)
        <br>
        +{
        <br>
        +    PnvSpiController *s = PNV_SPICONTROLLER(opaque);
        <br>
        +    uint32_t reg = addr &gt;&gt; 3;
        <br>
        +    uint64_t val = ~0ull;
        <br>
        +
        <br>
        +    switch (reg) {
        <br>
        +    case ERROR_REG:
        <br>
        +        val = s-&gt;error_reg;
        <br>
        +        break;
        <br>
        +    case COUNTER_CONFIG_REG:
        <br>
        +        val = s-&gt;counter_config_reg;
        <br>
        +        break;
        <br>
        +    case CONFIG_REG1:
        <br>
        +        val = s-&gt;config_reg1;
        <br>
        +        break;
        <br>
        +    case CLOCK_CONFIG_REG:
        <br>
        +        val = s-&gt;clock_config_reset_control;
        <br>
        +        break;
        <br>
        +    case MEMORY_MAPPING_REG:
        <br>
        +        val = s-&gt;memory_mapping_reg;
        <br>
        +        break;
        <br>
        +    case TRANSMIT_DATA_REG:
        <br>
        +        val = s-&gt;transmit_data_reg;
        <br>
        +        break;
        <br>
        +    case RECEIVE_DATA_REG:
        <br>
        +        val = s-&gt;receive_data_reg;
        <br>
        +        trace_pnv_spi_read_RDR(val);
        <br>
        +        s-&gt;status_reg = SETFIELD(STATUS_REG_RDR_FULL,
        s-&gt;status_reg, 0);
        <br>
        +        break;
        <br>
        +    case SEQUENCER_OPERATION_REG:
        <br>
        +        val = 0;
        <br>
        +        for (int i = 0; i &lt; SPI_CONTROLLER_REG_SIZE; i++) {
        <br>
        +            val = (val &lt;&lt; 8) |
        s-&gt;sequencer_operation_reg[i];
        <br>
        +        }
        <br>
        +        break;
        <br>
        +    case STATUS_REG:
        <br>
        +        val = s-&gt;status_reg;
        <br>
        +        break;
        <br>
        +    default:
        <br>
        +        qemu_log_mask(LOG_GUEST_ERROR, "spi_controller_regs:
        Invalid xscom "
        <br>
        +                 "read at 0x%08x\n", reg);
        <br>
      </blockquote>
      <br>
      Please use PRIx32 format
      <br>
      <br>
      <blockquote type="cite">+    }
        <br>
        +
        <br>
        +    trace_pnv_spi_read(addr, val);
        <br>
        +    return val;
        <br>
        +}
        <br>
        +
        <br>
        +static void pnv_spi_controller_write(void *opaque, hwaddr addr,
        <br>
        +                                 uint64_t val, unsigned size)
        <br>
        +{
        <br>
        +    PnvSpiController *s = PNV_SPICONTROLLER(opaque);
        <br>
        +    uint32_t reg = addr &gt;&gt; 3;
        <br>
        +
        <br>
        +    trace_pnv_spi_write(addr, val);
        <br>
        +
        <br>
        +    switch (reg) {
        <br>
        +    case ERROR_REG:
        <br>
        +        s-&gt;error_reg = val;
        <br>
        +        break;
        <br>
        +    case COUNTER_CONFIG_REG:
        <br>
        +        s-&gt;counter_config_reg = val;
        <br>
        +        break;
        <br>
        +    case CONFIG_REG1:
        <br>
        +        s-&gt;config_reg1 = val;
        <br>
        +        break;
        <br>
        +    case CLOCK_CONFIG_REG:
        <br>
        +        /*
        <br>
        +         * To reset the SPI controller write the sequence 0x5
        0xA to
        <br>
        +         * reset_control field
        <br>
        +         */
        <br>
        +        if (GETFIELD(CLOCK_CONFIG_REG_RESET_CONTROL,
        <br>
        +                               
        s-&gt;clock_config_reset_control) == 0x5) {
        <br>
        +            if (GETFIELD(CLOCK_CONFIG_REG_RESET_CONTROL, val)
        == 0xA) {
        <br>
        +                /* SPI controller reset sequence completed,
        resetting */
        <br>
        +                s-&gt;clock_config_reset_control =
        <br>
        +                                
        CLOCK_CONFIG_RESET_CONTROL_HARD_RESET;
        <br>
        +            } else {
        <br>
        +                s-&gt;clock_config_reset_control = val;
        <br>
        +            }
        <br>
        +        } else {
        <br>
        +            s-&gt;clock_config_reset_control = val;
        <br>
        +        }
        <br>
        +        break;
        <br>
        +    case MEMORY_MAPPING_REG:
        <br>
        +        s-&gt;memory_mapping_reg = val;
        <br>
        +        break;
        <br>
        +    case TRANSMIT_DATA_REG:
        <br>
        +        /*
        <br>
        +         * Writing to the transmit data register causes the
        transmit data
        <br>
        +         * register full status bit in the status register to
        be set.  Writing
        <br>
        +         * when the transmit data register full status bit is
        already set
        <br>
        +         * causes a "Resource Not Available" condition.  This
        is not possible
        <br>
        +         * in the model since writes to this register are not
        asynchronous to
        <br>
        +         * the operation sequence like it would be in hardware.
        <br>
        +         */
        <br>
        +        s-&gt;transmit_data_reg = val;
        <br>
        +        trace_pnv_spi_write_TDR(val);
        <br>
        +        s-&gt;status_reg = SETFIELD(STATUS_REG_TDR_FULL,
        s-&gt;status_reg, 1);
        <br>
        +        s-&gt;status_reg = SETFIELD(STATUS_REG_TDR_UNDERRUN,
        s-&gt;status_reg, 0);
        <br>
        +        break;
        <br>
        +    case RECEIVE_DATA_REG:
        <br>
        +        s-&gt;receive_data_reg = val;
        <br>
        +        break;
        <br>
        +    case SEQUENCER_OPERATION_REG:
        <br>
        +        for (int i = 0; i &lt; SPI_CONTROLLER_REG_SIZE; i++) {
        <br>
        +            s-&gt;sequencer_operation_reg[i] = (val &gt;&gt;
        (56 - i * 8)) &amp; 0xFF;
        <br>
        +        }
        <br>
        +        break;
        <br>
        +    case STATUS_REG:
        <br>
        +        /* other fields are ignore_write */
        <br>
        +        s-&gt;status_reg = SETFIELD(STATUS_REG_RDR_OVERRUN,
        s-&gt;status_reg,
        <br>
        +                                  GETFIELD(STATUS_REG_RDR,
        val));
        <br>
        +        s-&gt;status_reg = SETFIELD(STATUS_REG_TDR_OVERRUN,
        s-&gt;status_reg,
        <br>
        +                                  GETFIELD(STATUS_REG_TDR,
        val));
        <br>
        +        break;
        <br>
        +    default:
        <br>
        +        qemu_log_mask(LOG_GUEST_ERROR, "spi_controller_regs:
        Invalid xscom "
        <br>
        +                 "write at 0x%08x\n", reg);
        <br>
      </blockquote>
      <br>
      <br>
      Please use PRIx32 format
      <br>
      <br>
      <br>
      Thanks,
      <br>
      <br>
      C.
      <br>
      <br>
      <br>
      <blockquote type="cite">+    }
        <br>
        +    return;
        <br>
        +}
        <br>
        +
        <br>
        +static const MemoryRegionOps pnv_spi_controller_xscom_ops = {
        <br>
        +    .read = pnv_spi_controller_read,
        <br>
        +    .write = pnv_spi_controller_write,
        <br>
        +    .valid.min_access_size = 8,
        <br>
        +    .valid.max_access_size = 8,
        <br>
        +    .impl.min_access_size = 8,
        <br>
        +    .impl.max_access_size = 8,
        <br>
        +    .endianness = DEVICE_BIG_ENDIAN,
        <br>
        +};
        <br>
        +
        <br>
        +static Property pnv_spi_controller_properties[] = {
        <br>
        +    DEFINE_PROP_UINT32("spic_num", PnvSpiController, spic_num,
        0),
        <br>
        +    DEFINE_PROP_END_OF_LIST(),
        <br>
        +};
        <br>
        +
        <br>
        +static void pnv_spi_controller_realize(DeviceState *dev, Error
        **errp)
        <br>
        +{
        <br>
        +    PnvSpiController *s = PNV_SPICONTROLLER(dev);
        <br>
        +    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS
        ".%d",
        <br>
        +                    s-&gt;spic_num);
        <br>
        +    s-&gt;ssi_bus = ssi_create_bus(dev, name);
        <br>
        +    s-&gt;cs_line = g_new0(qemu_irq, 1);
        <br>
        +    qdev_init_gpio_out_named(DEVICE(s), s-&gt;cs_line, "cs",
        1);
        <br>
        +
        <br>
        +    /* spi controller scoms */
        <br>
        +    pnv_xscom_region_init(&amp;s-&gt;xscom_spic_regs,
        OBJECT(s),
        <br>
        +                          &amp;pnv_spi_controller_xscom_ops, s,
        <br>
        +                          "xscom-spi-controller-regs",
        <br>
        +                          PNV10_XSCOM_PIB_SPIC_SIZE);
        <br>
        +}
        <br>
        +
        <br>
        +static int pnv_spi_controller_dt_xscom(PnvXScomInterface *dev,
        void *fdt,
        <br>
        +                             int offset)
        <br>
        +{
        <br>
        +    PnvSpiController *s = PNV_SPICONTROLLER(dev);
        <br>
        +    g_autofree char *name;
        <br>
        +    int s_offset;
        <br>
        +    const char compat[] = "ibm,power10-spi_controller";
        <br>
        +    uint32_t spic_pcba = PNV10_XSCOM_PIB_SPIC_BASE +
        <br>
        +        s-&gt;spic_num * PNV10_XSCOM_PIB_SPIC_SIZE;
        <br>
        +    uint32_t reg[] = {
        <br>
        +        cpu_to_be32(spic_pcba),
        <br>
        +        cpu_to_be32(PNV10_XSCOM_PIB_SPIC_SIZE)
        <br>
        +    };
        <br>
        +    name = g_strdup_printf("spi_controller@%x", spic_pcba);
        <br>
        +    s_offset = fdt_add_subnode(fdt, offset, name);
        <br>
        +    _FDT(s_offset);
        <br>
        +
        <br>
        +    _FDT(fdt_setprop(fdt, s_offset, "reg", reg, sizeof(reg)));
        <br>
        +    _FDT(fdt_setprop(fdt, s_offset, "compatible", compat,
        sizeof(compat)));
        <br>
        +    _FDT((fdt_setprop_cell(fdt, s_offset, "spic_num#",
        s-&gt;spic_num)));
        <br>
        +    return 0;
        <br>
        +}
        <br>
        +
        <br>
        +static void pnv_spi_controller_class_init(ObjectClass *klass,
        void *data)
        <br>
        +{
        <br>
        +    DeviceClass *dc = DEVICE_CLASS(klass);
        <br>
        +    PnvXScomInterfaceClass *xscomc =
        PNV_XSCOM_INTERFACE_CLASS(klass);
        <br>
        +
        <br>
        +    xscomc-&gt;dt_xscom = pnv_spi_controller_dt_xscom;
        <br>
        +
        <br>
        +    dc-&gt;desc = "PowerNV SPI Controller";
        <br>
        +    dc-&gt;realize = pnv_spi_controller_realize;
        <br>
        +    device_class_set_props(dc, pnv_spi_controller_properties);
        <br>
        +}
        <br>
        +
        <br>
        +static const TypeInfo pnv_spi_controller_info = {
        <br>
        +    .name          = TYPE_PNV_SPI_CONTROLLER,
        <br>
        +    .parent        = TYPE_SYS_BUS_DEVICE,
        <br>
        +    .instance_size = sizeof(PnvSpiController),
        <br>
        +    .class_init    = pnv_spi_controller_class_init,
        <br>
        +    .interfaces    = (InterfaceInfo[]) {
        <br>
        +        { TYPE_PNV_XSCOM_INTERFACE },
        <br>
        +        { }
        <br>
        +    }
        <br>
        +};
        <br>
        +
        <br>
        +static void pnv_spi_controller_register_types(void)
        <br>
        +{
        <br>
        +    type_register_static(&amp;pnv_spi_controller_info);
        <br>
        +}
        <br>
        +
        <br>
        +type_init(pnv_spi_controller_register_types);
        <br>
        diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
        <br>
        index 78f83e78ce..6f9670b377 100644
        <br>
        --- a/hw/ppc/Kconfig
        <br>
        +++ b/hw/ppc/Kconfig
        <br>
        @@ -39,6 +39,7 @@ config POWERNV
        <br>
              select PCI_POWERNV
        <br>
              select PCA9552
        <br>
              select PCA9554
        <br>
        +    select SSI
        <br>
            config PPC405
        <br>
              bool
        <br>
        diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
        <br>
        index d096636ee7..68fadbae7b 100644
        <br>
        --- a/hw/ppc/meson.build
        <br>
        +++ b/hw/ppc/meson.build
        <br>
        @@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true:
        files(
        <br>
            'pnv_pnor.c',
        <br>
            'pnv_nest_pervasive.c',
        <br>
            'pnv_n1_chiplet.c',
        <br>
        +  'pnv_spi_controller.c',
        <br>
          ))
        <br>
          # PowerPC 4xx boards
        <br>
          ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
        <br>
        diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
        <br>
        index bf29bbfd4b..b8e494ffc5 100644
        <br>
        --- a/hw/ppc/trace-events
        <br>
        +++ b/hw/ppc/trace-events
        <br>
        @@ -110,6 +110,12 @@ pnv_sbe_cmd_timer_stop(void) ""
        <br>
          pnv_sbe_cmd_timer_expired(void) ""
        <br>
          pnv_sbe_msg_recv(uint16_t cmd, uint16_t seq, uint16_t
        ctrl_flags) "cmd 0x%" PRIx16 " seq %"PRIu16 " ctrl_flags 0x%"
        PRIx16
        <br>
          +#pnv_spi_controller.c
        <br>
        +pnv_spi_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 "
        val 0x%" PRIx64
        <br>
        +pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 "
        val 0x%" PRIx64
        <br>
        +pnv_spi_read_RDR(uint64_t val) "data extracted = 0x%" PRIx64
        <br>
        +pnv_spi_write_TDR(uint64_t val) "being written, data written =
        0x%" PRIx64
        <br>
        +
        <br>
          # ppc.c
        <br>
          ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t diff,
        int64_t seconds) "adjusted from 0x%"PRIx64" to 0x%"PRIx64", diff
        %"PRId64" (%"PRId64"s)"
        <br>
          ppc_tb_load(uint64_t tb) "tb 0x%016" PRIx64
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------rTBw1SzC8cFUpirawqBGRZgV--


