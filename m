Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B571CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgBC-0007uq-LW; Wed, 24 Apr 2024 13:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rzgBA-0007uA-BS; Wed, 24 Apr 2024 13:13:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rzgB7-00069R-Vs; Wed, 24 Apr 2024 13:13:08 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OGlqI8022254; Wed, 24 Apr 2024 17:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4N71XImNLU+eaygbqjIsi80jp704ae9Buk0fJpEgWrU=;
 b=LTtazN9qLLQrgLKfSkkX3FzpikIyGqS/5VQYvGmxYNcNG8K+P9zRKVV7xeFPTev54r92
 dyuUBC2LoCWFXBNtNhqK56OhZXcRYekELkqF7OSvCQ24/COepQSzKLdUjsdgKTRrGlOk
 ICgZ6kKuMBrPClJsDCnp78ZtFzGYutm5gO12piTm7e9JQx4R5VDAkftkvKo9lFqt2XlP
 MKFcbtO6rVJTDmeXo5MXnGdWT0+mikH23E2mmaOWj2QUzgUuQpXw11AOnojQg5gJjqbm
 f5E2SiitxT0VF44Z1Oq6h7PgCtDuruvYzhu2OsPJFclDJKVCzyvzP5GxvsAuTf22OYzj ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq5we832f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 17:12:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OHCrrn002783;
 Wed, 24 Apr 2024 17:12:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq5we832b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 17:12:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OFokF1015289; Wed, 24 Apr 2024 17:12:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmcrhg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 17:12:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43OHCmw64457000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 17:12:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BF6E20043;
 Wed, 24 Apr 2024 17:12:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33DDF20040;
 Wed, 24 Apr 2024 17:12:46 +0000 (GMT)
Received: from [9.43.104.132] (unknown [9.43.104.132])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2024 17:12:45 +0000 (GMT)
Message-ID: <9fb57d82-7cd6-4033-8898-35472fbf4a97@linux.ibm.com>
Date: Wed, 24 Apr 2024 22:42:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/ppc: SPI controller wiring to P10 chip and
 create seeprom device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com
References: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
 <20240409175700.27535-6-chalapathi.v@linux.ibm.com>
 <5cd0d411-a723-4324-b706-913ac936f77b@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <5cd0d411-a723-4324-b706-913ac936f77b@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: joC9ad-yk1LA0OGDdCkZ9O0R-0hX0meP
X-Proofpoint-GUID: AEOcWI9UOFkAA1UqKgZMAutW9vV2aTW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_14,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240074
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hello Cedric,

Thank You for reviewing v2 patches.

Regards,

Chalapathi

On 22-04-2024 20:33, Cédric Le Goater wrote:
> On 4/9/24 19:56, Chalapathi V wrote:
>> In this commit
>> Creates SPI controller on p10 chip.
>> Create the keystore seeprom of type "seeprom-25csm04"
>> Connect the cs of seeprom to PIB_SPIC[2] cs irq.
>>
>> The QOM tree of spi controller and seeprom are.
>> /machine (powernv10-machine)
>>    /chip[0] (power10_v2.0-pnv-chip)
>>      /pib_spic[2] (pnv-spi-controller)
>>        /bus (pnv-spi-bus)
>>          /pnv-spi-bus.2 (SSI)
>>        /xscom-spi-controller-regs[0] (memory-region)
>>
>> /machine (powernv10-machine)
>>    /unattached (container)
>>      /device[7] (seeprom-25csm04)
>>        /ssi-gpio-cs[0] (irq)
>>
>> (qemu) qom-get /machine/unattached/device[7] "parent_bus"
>> "/machine/chip[0]/pib_spic[2]/bus/pnv-spi-bus.2"
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   include/hw/ppc/pnv_chip.h |  3 +++
>>   hw/ppc/pnv.c              | 36 +++++++++++++++++++++++++++++++++++-
>>   2 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
>> index 8589f3291e..3edf13e8f9 100644
>> --- a/include/hw/ppc/pnv_chip.h
>> +++ b/include/hw/ppc/pnv_chip.h
>> @@ -6,6 +6,7 @@
>>   #include "hw/ppc/pnv_core.h"
>>   #include "hw/ppc/pnv_homer.h"
>>   #include "hw/ppc/pnv_n1_chiplet.h"
>> +#include "hw/ppc/pnv_spi_controller.h"
>>   #include "hw/ppc/pnv_lpc.h"
>>   #include "hw/ppc/pnv_occ.h"
>>   #include "hw/ppc/pnv_psi.h"
>> @@ -118,6 +119,8 @@ struct Pnv10Chip {
>>       PnvSBE       sbe;
>>       PnvHomer     homer;
>>       PnvN1Chiplet     n1_chiplet;
>> +#define PNV10_CHIP_MAX_PIB_SPIC 6
>> +    PnvSpiController pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
>>         uint32_t     nr_quads;
>>       PnvQuad      *quads;
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 6e3a5ccdec..eeb2d650bd 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -46,6 +46,7 @@
>>   #include "hw/pci-host/pnv_phb.h"
>>   #include "hw/pci-host/pnv_phb3.h"
>>   #include "hw/pci-host/pnv_phb4.h"
>> +#include "hw/ssi/ssi.h"
>>     #include "hw/ppc/xics.h"
>>   #include "hw/qdev-properties.h"
>> @@ -1829,6 +1830,11 @@ static void 
>> pnv_chip_power10_instance_init(Object *obj)
>>       for (i = 0; i < pcc->i2c_num_engines; i++) {
>>           object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], 
>> TYPE_PNV_I2C);
>>       }
>> +
>> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC ; i++) {
>> +        object_initialize_child(obj, "pib_spic[*]", 
>> &chip10->pib_spic[i],
>> +                                TYPE_PNV_SPI_CONTROLLER);
>> +    }
>>   }
>>     static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, 
>> Error **errp)
>> @@ -2043,7 +2049,35 @@ static void 
>> pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>> qdev_get_gpio_in(DEVICE(&chip10->psi),
>> PSIHB9_IRQ_SBE_I2C));
>>       }
>> -
>> +    /* PIB SPI Controller */
>> +    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
>> + object_property_set_int(OBJECT(&chip10->pib_spic[i]), "spic_num",
>> +                                i , &error_fatal);
>> +        /*
>> +         * The TPM attached SPIC needs to reverse the bit order in 
>> each byte
>> +         * it sends to the TPM.
>> +         */
>> +        if (i == 4) {
>> + object_property_set_bool(OBJECT(&chip10->pib_spic[i]),
>> +                    "reverse_bits", true, &error_fatal);
>> +        }
>
> or
>
> object_property_set_bool(OBJECT(&chip10->pib_spic[i]),
>                     "reverse_bits", (i == 4) , &error_fatal);
>
>
> That said. This setting looks weird to me.
>
> Why do we need to reverse the bits ? is it an endian issue ?
>
> Are there other SPI devices on the buses ?
There are no other SPI devices attached to this bus.
Checking about reversing the bits that sent to TPM.
>
>> +        if (!qdev_realize(DEVICE(&chip10->pib_spic[i]), NULL, errp)) {
>> +            return;
>> +        }
>> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_PIB_SPIC_BASE +
>> +                                i * PNV10_XSCOM_PIB_SPIC_SIZE,
>> + &chip10->pib_spic[i].xscom_spic_regs);
>> +    }
>
>
> The devices below belong to the rainer machine it seems. We should 
> introduce
> a per-machine handler to create them like it was done for the I2C 
> devices.
> For this purpose, the PnvMachineClass::i2c_init) handler could be changed
> to create all machine specific devices.
ACK, Thank You.
>
>> +    /* Primary MEAS/MVPD/Keystore SEEPROM connected to pib_spic[2] */
>> +    DeviceState *seeprom = qdev_new("seeprom-25csm04");
>> +    qdev_prop_set_string(seeprom, "filename",
>> +                         "sbe_measurement_seeprom.bin.ecc");
>
> This should be done differently. Here is a command line example :
>
> $ qemu-system-arm -M ast2600-evb \
>       -blockdev node-name=fmc0,driver=file,filename=/path/to/fmc0.img \
>       -device mx66u51235f,bus=ssi.0,cs=0x0,drive=fmc0 \
>       -blockdev node-name=fmc1,driver=file,filename=/path/to/fmc1.img \
>       -device mx66u51235f,bus=ssi.0,cs=0x1,drive=fmc1 \
>       -blockdev node-name=spi1,driver=file,filename=/path/to/spi1.img \
>       -device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \
>       ...
>
> Please try to rework "seeprom-25csm04" on top of "m25p80". It should 
> help.
Sure, Will check and do the updates.
>
>
>> +    ssi_realize_and_unref(seeprom, 
>> ((&chip10->pib_spic[2])->bus).ssi_bus,
>> +                          &error_fatal);
>> +    qemu_irq seeprom_cs = qdev_get_gpio_in_named(seeprom, 
>> SSI_GPIO_CS, 0);
>> +    Object *bus = OBJECT(&(&chip10->pib_spic[2])->bus);
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(bus), 0, seeprom_cs);
>
> Could you please slightly change the models to connect the IRQ line using
> qdev_connect_gpio_out instead ?  See pnv_rainier_i2c_init.
>
> Thanks,
>
> C.
Sure, Will check and update. Thank You.
>
>>   }
>>     static void pnv_rainier_i2c_init(PnvMachineState *pnv)
>

