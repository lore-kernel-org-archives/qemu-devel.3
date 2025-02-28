Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5FFC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 11:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tny6W-0005nF-Bo; Fri, 28 Feb 2025 06:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tny6V-0005mj-5M; Fri, 28 Feb 2025 06:00:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tny6S-0007Ps-R4; Fri, 28 Feb 2025 06:00:26 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S7WssP025575;
 Fri, 28 Feb 2025 11:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2830WV
 1bZxduA4jle7XZ4lZgCTlgEZ+BKqedq8e9IYE=; b=Kl47UZ3RMvX6CloZblkxBO
 jMn7Fw3YFVJQLRdGMzpYQm/fnqrELTdR6lF3oRDaNVemkMV4lUPSEtGNgxStpUx3
 y8sHNmzzsl7M1OGm8LiLX/v5e+pt+XZFgpjugSJU0J/PRS84oKTxNeTztBY93fYb
 YZkLqmGefQlssuh5I61Z7E8olb2aXYGh7vzY8iyA9O7S7x89SotrpVA2CJvsu6Se
 Q64LgQR8dGFRVB73mfJlvvO+tWFRJhet9ssx2jgYS6qVl7O0vuVmmJ6DfdZQBPgt
 fUCHVjye44iTtey6Q+zbQetPcmEw6VQKJ1nARtbeLqV7Of1ZcZpUVXtA4o2jz6Vw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4538uq0x6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 11:00:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51SAYeSb010471;
 Fri, 28 Feb 2025 11:00:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4538uq0x6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 11:00:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAaR8T027487;
 Fri, 28 Feb 2025 11:00:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkwy52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Feb 2025 11:00:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51SB0Dnq17039792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2025 11:00:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DC072004B;
 Fri, 28 Feb 2025 11:00:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C990E20040;
 Fri, 28 Feb 2025 11:00:10 +0000 (GMT)
Received: from [9.43.126.243] (unknown [9.43.126.243])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Feb 2025 11:00:10 +0000 (GMT)
Message-ID: <4070f546-34ab-4229-895c-79f40f1ee9ec@linux.ibm.com>
Date: Fri, 28 Feb 2025 16:30:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hw/ssi/pnv_spi: Make bus names distinct for each
 controllers of a socket
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, calebs@linux.ibm.com,
 chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-4-chalapathi.v@linux.ibm.com>
 <D82UR4MO7WG9.RGLCRWPS8I29@gmail.com>
 <b4430243-942b-43fc-9502-c0a328cecdc3@linux.ibm.com>
 <3430a63d-1fc9-4bb6-8dab-d8ae22afb4de@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <3430a63d-1fc9-4bb6-8dab-d8ae22afb4de@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UxDgyx2tsnoSMOJ9u9g4kkm7OW9NRKQZ
X-Proofpoint-ORIG-GUID: gdM2ChMsx4m2eP2m-yH0TFJZEKlSQsTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1011 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280079
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


On 28-02-2025 13:15, Cédric Le Goater wrote:
> On 2/28/25 04:03, Chalapathi V wrote:
>>
>> On 27-02-2025 07:24, Nicholas Piggin wrote:
>>> On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
>>>> Create a spi buses with distict names on each socket so that 
>>>> responders
>>>> are attached to correct SPI controllers.
>>>>
>>>> QOM tree on a 2 socket machine:
>>>> (qemu) info qom-tree
>>>> /machine (powernv10-machine)
>>>>    /chip[0] (power10_v2.0-pnv-chip)
>>>>      /pib_spic[0] (pnv-spi)
>>>>        /chip0.pnv.spi.bus.0 (SSI)
>>>>        /xscom-spi[0] (memory-region)
>>>>    /chip[1] (power10_v2.0-pnv-chip)
>>>>      /pib_spic[0] (pnv-spi)
>>>>        /chip1.pnv.spi.bus.0 (SSI)
>>>>        /xscom-spi[0] (memory-region)
>>> Mechanics of the patch looks fine. I don't know about the name
>>> though.
>>>
>>> I think "pnv-spi-bus" is the right name for the bus. Using dots as
>>> with chip0. makes it seem like each element is part of a topology.
>>>
>>> Would chip0.pnv-spi-bus be better?
>> Will rename the bus name to chip0.pnv-spi-bus . Thank You
>
> Yep. I don't think the bus suffix is useful (minor).
>
> Will you be attaching flash devices from the command line ? Can you 
> provide
> an example if so ?
>
> Thanks,
>
> C.
>
Yes, I am attaching seeprom and TPM device from command line.
"-blockdev node-name=pib_spic2,driver=file,filename=%s -device 
25csm04,bus=chip0.pnv-spi-bus.2,cs=0,drive=pib_spic2"

"-chardev 
socket,id=chrtpm,path=/tmp/swtpm.chalap1.250227212039.rOWBH/swtpm-sock 
-tpmdev emulator,id=tpm0,chardev=chrtpm -device 
tpm-tis-spi,tpmdev=tpm0,bus=chip0.pnv-spi-bus.4"

Thank You,

Chalapathi

>
>>> I don't suppose there is a good way to create an alias so existing
>>> cmdline works and refers to the bus on chip0? Maybe the chip0 bus
>>> could just not have the chip0. prefix?
>>>
>>> Thanks,
>>> Nick
>> Would it be best to keep the chip0 prefix to have uniformity?
>>>> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
>>>> ---
>>>>   include/hw/ssi/pnv_spi.h           | 3 ++-
>>>>   hw/ppc/pnv.c                       | 2 ++
>>>>   hw/ssi/pnv_spi.c                   | 5 +++--
>>>>   tests/qtest/pnv-spi-seeprom-test.c | 2 +-
>>>>   4 files changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
>>>> index 9878d9a25f..7fc5da1f84 100644
>>>> --- a/include/hw/ssi/pnv_spi.h
>>>> +++ b/include/hw/ssi/pnv_spi.h
>>>> @@ -31,7 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
>>>>   #define PNV_SPI_REG_SIZE 8
>>>>   #define PNV_SPI_REGS 7
>>>>   -#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
>>>> +#define TYPE_PNV_SPI_BUS "pnv.spi.bus"
>>>>   typedef struct PnvSpi {
>>>>       SysBusDevice parent_obj;
>>>>   @@ -42,6 +42,7 @@ typedef struct PnvSpi {
>>>>       Fifo8 rx_fifo;
>>>>       /* SPI object number */
>>>>       uint32_t        spic_num;
>>>> +    uint32_t        chip_id;
>>>>       uint8_t         transfer_len;
>>>>       uint8_t         responder_select;
>>>>       /* To verify if shift_n1 happens prior to shift_n2 */
>>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>>> index 11fd477b71..ce23892fdf 100644
>>>> --- a/hw/ppc/pnv.c
>>>> +++ b/hw/ppc/pnv.c
>>>> @@ -2226,6 +2226,8 @@ static void 
>>>> pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>>>>           /* pib_spic[2] connected to 25csm04 which implements 1 
>>>> byte transfer */
>>>> object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_len",
>>>>                                   (i == 2) ? 1 : 4, &error_fatal);
>>>> + object_property_set_int(OBJECT(&chip10->pib_spic[i]), "chip-id",
>>>> +                                chip->chip_id, &error_fatal);
>>>>           if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
>>>> (&chip10->pib_spic[i])), errp)) {
>>>>               return;
>>>> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
>>>> index 87eac666bb..41beb559c6 100644
>>>> --- a/hw/ssi/pnv_spi.c
>>>> +++ b/hw/ssi/pnv_spi.c
>>>> @@ -1116,14 +1116,15 @@ static const MemoryRegionOps 
>>>> pnv_spi_xscom_ops = {
>>>>     static const Property pnv_spi_properties[] = {
>>>>       DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
>>>> +    DEFINE_PROP_UINT32("chip-id", PnvSpi, chip_id, 0),
>>>>       DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
>>>>   };
>>>>     static void pnv_spi_realize(DeviceState *dev, Error **errp)
>>>>   {
>>>>       PnvSpi *s = PNV_SPI(dev);
>>>> -    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
>>>> -                    s->spic_num);
>>>> +    g_autofree char *name = g_strdup_printf("chip%d." 
>>>> TYPE_PNV_SPI_BUS ".%d",
>>>> +                    s->chip_id, s->spic_num);
>>>>       s->ssi_bus = ssi_create_bus(dev, name);
>>>>       s->cs_line = g_new0(qemu_irq, 1);
>>>>       qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
>>>> diff --git a/tests/qtest/pnv-spi-seeprom-test.c 
>>>> b/tests/qtest/pnv-spi-seeprom-test.c
>>>> index 57f20af76e..ef1005a926 100644
>>>> --- a/tests/qtest/pnv-spi-seeprom-test.c
>>>> +++ b/tests/qtest/pnv-spi-seeprom-test.c
>>>> @@ -92,7 +92,7 @@ static void test_spi_seeprom(const void *data)
>>>>       qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
>>>>                         "threads=1 -accel tcg,thread=single 
>>>> -nographic "
>>>>                         "-blockdev node-name=pib_spic2,driver=file,"
>>>> -                      "filename=%s -device 
>>>> 25csm04,bus=pnv-spi-bus.2,cs=0,"
>>>> +                      "filename=%s -device 
>>>> 25csm04,bus=chip0.pnv.spi.bus.2,cs=0,"
>>>>                         "drive=pib_spic2", tmp_path);
>>>>       spi_seeprom_transaction(qts, chip);
>>>>       qtest_quit(qts);
>

