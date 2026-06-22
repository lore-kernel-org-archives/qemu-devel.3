Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267C3CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbVR8-0003Hx-GQ; Sun, 21 Jun 2026 23:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbVR6-0003Hi-Nz
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:35:00 -0400
Received: from mail-eastus2azon11020087.outbound.protection.outlook.com
 ([52.101.56.87] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbVR4-0001Rw-RS
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNp9hvV/gdcJl83L8uejk3T51/SlOuTSLo+8C7JWFrbO8PotpILJ4TirtES97AoKNTls/8CFVFORxfjxhDnjgX+pg9tYv7V8GqrHxErVST1TypV7AGVyFv6KNkjQMkkx279YrC5rgrsSxJq9xKn5i5FjMNIoMpmlyK5nk2YK4OC2aKqCSApX8GyvgXRE5uvO4Q5wph4H4rcJGDTANMEPQ2hehDHx+1dIml76mN/CELeeEzTJh1HkxoilViIkPoAbrwFKQyLoChDUFUsohiXl+bcvIRkh5ZQ3WoIJv9h331czsYjIFN+v154ijLOmeFdHwhx6ujd1MBEa8xybFi95QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H/mNyvGVerYJ1RPnHBDfVnu3uTq2eIHp/yuJolbam4=;
 b=nHB9Wc5+M13OJ6HGWKoKuxu6QT9YhTTsqNayBgPTmFfoB2xXUiXaf1KAFPDE2Wu7VLEoto6C7PpBEoxsZWSioh7v+5hlXGZX/tCdk0NLV0aiwJDR6W4VVW2bIYBTZRyOn/5FpEVA3zezAQRFNewIekAfwRLHMIbvqsvm8iuOOpj3SMBz/yESNt0iJd1zMQ0djxz+r02H9eP20/8zL2n88N2BJTiF3foHxECAGpUv8TPvI8Zee5HI7f4m19QwFK2iG0cLk4ABckUIktJd7M7aqMuQ1p6U2JVuSk8EMZFdNPXNjyPrw7kyCMxs1gykPBrO2m0dJUG0TngKDdO9ciMvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H/mNyvGVerYJ1RPnHBDfVnu3uTq2eIHp/yuJolbam4=;
 b=g3lt5sSnonBmQymS2PPDtwAnjvgw5ShYX4biw4ivsUWpf3CBtH070MHT4b9/aKmo8tym3M73cd+mz4nsNlWNbmbgTCX+zYuhC5QXjMh6NZaUgpS3QgV4MVdJSUC7TJAnKhMzlRKKtdJTzvKPCyetwSKzphoC3uayM6iGQGxfyG5oKDBMcMLfzU+ng4K10ZrrflkNua0aeyt3QVyWLQRdH4BSNBCtgvvVPnG8VYRwauAYPq12lvdXAdU+/iSDw+5AX2ijYs07KIQBImKBIdyWDidT2k8gH63rMusEOHmEajKgXJtdtldGblPXGVlBg9pfZ1tnFafeui8qw2cF29JUIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by BY3PR18MB4674.namprd18.prod.outlook.com (2603:10b6:a03:3c5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 03:34:52 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 03:34:52 +0000
Message-ID: <8beb5c51-04f2-4e96-ae7d-a015d16b0ec3@axiado.com>
Date: Mon, 22 Jun 2026 11:34:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] hw/arm: ax3000-soc: Enable Axiado SD host
 controller
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-6-kchiu@axiado.com>
 <41ffebd9-00fd-4a1a-a281-1e8bc475fa9f@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <41ffebd9-00fd-4a1a-a281-1e8bc475fa9f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0058.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::9)
 To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|BY3PR18MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: b75128ee-0f07-481e-1ba9-08ded00f3859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JH51UWI4zL++3jP/pZ98uMJA210jxb+LxF5Rxv8o2/InNwqFR/scU6iPGbVq5iqV1V2tNC4NjXhFgZd9Y2D8/tzT/eZ634TD7/woBdg6vAf7mNunvwLv9xzSKjkqFx1RDWEp7IF9EYshnCaDXHEuPn2vgXJ3ZomeN2TQOZZ9hAanIBVXt0kekNx5une8wJCMF1nl3elWBEKDnRsVP771OINfCAtY9OrRVJJYA/TfYXutSL2f5RVSgcNscnMgnQ8TekszCjIzjJqsu0G3sfodEVDB0aja24F69CWPDZi7qHGdAQ+ZawPedenitUyV2HdbL6lgtT3ujFULlEde/QXfhIOKkGHoOe5iXWZbRMUPV1PTdHq0A2xHF0KBQqA32jzvYxPtQDiggcEM+dJiLR110fgaxapkBEl+tdVXbQw9L/9Wcw5Xt5xKwhnZ3SJ70PrfJ/GLpGumSbK5tHpfVsNKoQwHK4dqUtjGP7qvKUfP5yXSZTw9jnBwi+9IaFxfu82kZfnFuphLGQZptFdzFoocntTTYlzIqMtPsk2YHCzJ7njNt2iF/Gu1kExLrbSJe/HMUOKyfaXOqUTjmf8JN7W9Gn0IwGxn6CBGe5Z73wk9GxJIC+t03syccuSkYTy/fmyPkcnK8pbyjqpVmDjFowUFENq67Mwvingk8PPcDsT04ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFI5RHVrS21ab2VMekc2S0h6ckhXSXlacEcvZ1NUengyRUIzNXI3dU5TWkVv?=
 =?utf-8?B?N01SUFgyTzJoSTNOclFYVTk3NDVjOFRZT0kwUUh0TnBPV0dPQVFBOTZCbTZm?=
 =?utf-8?B?cDE5dzdxRHdSdEZ5M3FrWUw2SENDb043Zmw3YkRNMDlaMmJIRDU3UVRpZGd3?=
 =?utf-8?B?SHNuRVoyZ3RWa1NSV3I2ZXZvMG1mU1YrSERMVmlJdEhWUVYrRHcvNEdVaEpV?=
 =?utf-8?B?bml1YlRLODZ1K2JqeXBFRDltdFFxYWVnY2hjWk9CMXllZ3dDKzk1S2FsNWpE?=
 =?utf-8?B?M0hUbEpUM2Y4TU1ra3BRZWJtUU1vS1BTdm94VHd4UHhWRmdQRDZuQ2pHdmVW?=
 =?utf-8?B?YmVISSs1RFB1c3g2SUsveTZkMWhNd3lHUFAxQ0N2WmxEaWNvNmFvYlZDenZr?=
 =?utf-8?B?UWVGSUw4cnNqL1FZa1ZDZHZjQi9CaTJIbmlNQlVYcHJsNjFZMFJmREQrSVZZ?=
 =?utf-8?B?NHlkY1FoRVp2ZWlCU2I0S3ViemoyUFlVR0RPUlh4VVV2alBQY3VrYVZiZGJI?=
 =?utf-8?B?LzN0ZkZvTnNKb0VDY2JpQ1pNUWpJR2hjS3JnNkhHVUZieS9PSzExbHJYRWJu?=
 =?utf-8?B?anFlSGpzWW1MZTg0Y3dxdnNvUmRXcE5uZm1GV2F3ZGEyY1FPS0dhbkJzU05N?=
 =?utf-8?B?U1l3ZTBwbWJlOGNjUEZ5U09qbVJtWjhQcnJ2eG55VmpLMWRQaTMzR0FpSFZX?=
 =?utf-8?B?dThWaklGcVRZTkp2SExCZE5IeFY2d0ZMK2N1UVEydjRka0ZqNFlyZkhzWncw?=
 =?utf-8?B?NkVDaThJVnlVSDFCMlYwb2MvR3FlQnhlN25mQVdBem0yUUdNeE1USGgxTDNj?=
 =?utf-8?B?YmNyTVhZSXdsRERZV20ySWU3ZmJKdkdxNHIzczUvbFRtMjNVNjdLVHRSaHdn?=
 =?utf-8?B?QjhmcmVYRjBYaHdISHdoVGx5b3FyNUVVMlFMdVROZEZuYlB1Q0hMZGRRMG5i?=
 =?utf-8?B?MGFTb1ZuMGhIeDNrNk1TZmtHWkxmQkVhRTBjcS9Wc1pPWXVVVjVIZ0lBVGx0?=
 =?utf-8?B?bURrb3lnQTl3VGsyTkhiQnVjMi9ZVGMrOUdTQTEvRXoyVXJqSWNNUURqY0ox?=
 =?utf-8?B?MFRxSzNqQTBJbjhVbFNrNGt0cUxUdGdyNHdsUVE4TC9wNVZRUGl4N2pxVWRU?=
 =?utf-8?B?cnpsS1pjT1ZPckhZNWNrYWxQMktjeXBMbnJ0RTk0THM0WW5YQTRFMVBFTXEx?=
 =?utf-8?B?dUNGYUh3UVNrL3l2c0tkUkZqYWNNWm10S2xKQXozUUpLRkFhRmRLa090aDlk?=
 =?utf-8?B?MEtGRGp5cCtqQU5kQVFYbm1Sdmh0a0ZZU2cySkpuVTVHQkZSUnBtZW1YUWpN?=
 =?utf-8?B?OHptR1NGMXl0NHVocnBVbFBzWVVCVHcvV2gxbEVZVDRpYnh0NGQrSklrZTVl?=
 =?utf-8?B?VmJYVGF2MjlEanRoQllEUzdMektSYVJNc3gwUy9PYm56Mk1VZmN0MHA4WER0?=
 =?utf-8?B?ZkhxUHF0ZnZMckxIN2RvRlEvVmk1S0t5Z3R2S1BSQjQ1REcwdzFpN05Oem9B?=
 =?utf-8?B?OTlpdU8zaW5zL0x4U21BZ2tMSTRSd2Y4T3lmbDdBcEhuTkZRSTdmMzk5Smsz?=
 =?utf-8?B?VHdBenJoNGlTaU9sbWVtWjY3WERySGVRVVp5Mmc3ZHdxS2hBYldGajRSZGZt?=
 =?utf-8?B?cjJCSktKNXEwYTVSQXBpSWtqMG5OTENVczErSThORjIrd29tQmR2V00vV1Bj?=
 =?utf-8?B?ZnE2Q0c4clkyaHVCbHdYWWZIQ25rL1UrQkpCbnUybGF2TUNsVE5GbHdiQVNP?=
 =?utf-8?B?Sk4vTEtoZ2FSUElOODBoT0U0bytqRU9TRVRiYXZlbjJXZ1F0eU1jYk1uSC9j?=
 =?utf-8?B?V2tSdy90K0tRU2FrdlZzeFNtS0wxNCt1dUUvYjhzd1lRTjNab3BOTnFZbnV3?=
 =?utf-8?B?Z0g4bFNaNWhRWGhoUlM5aUJFd01XNUdpM3V0ZSs4eit2dHZwK0NGVUMxbTZk?=
 =?utf-8?B?M0JyaWRmMk85amRobUZ4d2ZCUUN5Mzl3dUpqbVZ5bkVEN3QzclNIZFFDTUhz?=
 =?utf-8?B?UHVhNDQxbDZBN2QzRXppRFdRNFBMOERtNGZHU1o5K01FaWs4aC9RQ3NRY1Nk?=
 =?utf-8?B?YkM0OG90TkREbkhCYW13MDhGeTRySWdiaHZ3SVF4YmMwR1JwQytORTgwVXZq?=
 =?utf-8?B?bEo5bXF2dG5PdTg3blhuYWxTa0d0Y2lUZUMxZTlQUUVIcWNmbmVERXlueTZN?=
 =?utf-8?B?N29DRnhjaFY0bVpRU3kwTm5kd29wdGMycklpZlM2bXNiWkFiWDVpajMzaVhz?=
 =?utf-8?B?bXpVNWI4MUJTSHNrcHhFRytuaWw3TWJHUzBGT0lUNEd2V3BhN2VYTnFOcDFw?=
 =?utf-8?B?dWNTREwvdkhtUlg4YVkyYlljUjhzYmFzSUErMGZ6QmRwVmRrbGwrUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75128ee-0f07-481e-1ba9-08ded00f3859
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 03:34:52.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPrlbb0KvpdKduK3dQTeNOdhPBxhtJlbKCxMeNFQLthKOSSva3uXIW0qvSI9Ru3RE6Z5eAUE89NfIQUBRuio0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4674
Received-SPF: pass client-ip=52.101.56.87; envelope-from=kchiu@axiado.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Philippe Mathieu-Daudé 於 2026/6/18 下午 11:17 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> Hi Kuan-Jui,
>
> On 18/6/26 12:12, Kuan-Jui Chiu wrote:
>> Enable SD host controller into Axiado AX3000 SoC to load kernel and 
>> rootfs
>> from eMMC.
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/arm/Kconfig              |  1 +
>>   hw/arm/ax3000-soc.c         | 18 ++++++++++++++++++
>>   include/hw/arm/ax3000-soc.h |  7 +++++++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 866e4b14e6f..13c0b44a180 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -724,4 +724,5 @@ config AXIADO_SOC
>>       select ARM_GIC
>>       select CADENCE # UART
>>       select AXIADO_CLK
>> +    select AXIADO_SDHCI
>>       select UNIMP
>> diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
>> index 9a01d23bcc6..159385cf913 100644
>> --- a/hw/arm/ax3000-soc.c
>> +++ b/hw/arm/ax3000-soc.c
>> @@ -35,6 +35,7 @@ static void ax3000_init(Object *obj)
>>       }
>>
>>       object_initialize_child(obj, "clk", &s->ax3000_clk, 
>> TYPE_AX3000_CLK);
>> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, 
>> TYPE_AXIADO_SDHCI);
>>   }
>>
>>   static void ax3000_realize(DeviceState *dev, Error **errp)
>> @@ -165,6 +166,23 @@ static void ax3000_realize(DeviceState *dev, 
>> Error **errp)
>>           return;
>>       }
>>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ax3000_clk), 0, 
>> AX3000_PLL_BASE);
>> +
>> +    /* SDHCI */
>> +    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
>> +    if (!sysbus_realize(sdhci0_sbd, errp)) {
>> +        return;
>> +    }
>> +
>> +    sysbus_mmio_map(sdhci0_sbd, 0, AX3000_SDHCI0_BASE);
>> +    sysbus_mmio_map(sdhci0_sbd, 1, AX3000_EMMC_PHY_BASE);
>> +    sysbus_connect_irq(sdhci0_sbd, 0,
>> +                       qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
>
> So there is no link between the SDHCI and the PHY. Thus no need for a
> particular AXIADO_SDHCI, simply instantiate a generic SDHCI here, and
> register the MMIO region for the PHY.
>
> in ax3000_init():
>
>     object_initialize_child(obj, "sdhci[0]", &s->sdhci[0],
>                             TYPE_SYSBUS_SDHCI);
>
> and in ax3000_realize():
>
>     object_property_set_uint(OBJECT(&s->sdhci[0]), "sd-spec-version", 3,
>                              &error_abort);
>     object_property_set_uint(OBJECT(&s->sdhci[0]), "capareg",
>                              0x216737eed0b0, &error_abort);
>
>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci[0]), errp)) {
>         return;
>     }
>     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[0]), 0,
>                        qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[0]),
>                     0, AX3000_SDHCI0_BASE);
>
> Then you simply map the state-less eMMC PHY region:
>
>     memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
>                           "axiado.emmc-phy", 0x1000);
>     memory_region_add_subregion(get_system_memory(),
>                                 AX3000_EMMC_PHY_BASE, &s->emmc_phy);
>
This is the original design in previous patch but PMM preferred to have 
an independent device model for this SDHC
>> +
>> +    card = qdev_new(TYPE_SD_CARD);
>> +    qdev_prop_set_drive_err(card, "drive",
>> + blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
>> +                            &error_fatal);
>> +    qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
>>   }
>>
>>   static void ax3000_class_init(ObjectClass *oc, const void *data)
>> diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
>> index 329aa4e7698..52b47aa8294 100644
>> --- a/include/hw/arm/ax3000-soc.h
>> +++ b/include/hw/arm/ax3000-soc.h
>> @@ -13,6 +13,7 @@
>>   #include "hw/intc/arm_gicv3_common.h"
>>   #include "hw/char/cadence_uart.h"
>>   #include "hw/misc/axiado_clk.h"
>> +#include "hw/sd/axiado_sdhci.h"
>>   #include "hw/core/sysbus.h"
>>   #include "qemu/units.h"
>>
>> @@ -34,6 +35,9 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, 
>> AX3000_SOC)
>>   #define AX3000_UART2_BASE       0x80620000
>>   #define AX3000_UART3_BASE       0x80520800
>>
>> +#define AX3000_SDHCI0_BASE      0x86000000
>> +#define AX3000_EMMC_PHY_BASE    0x80801C00
>> +
>>   #define AX3000_TIMER_CTRL       0x8A020000
>>   #define AX3000_PLL_BASE         0x80000000
>>
>> @@ -52,6 +56,7 @@ typedef struct Ax3000SoCState {
>>       MemoryRegion        dram[AX3000_NUM_BANKS];
>>       Ax3000ClkState      ax3000_clk;
>>       CadenceUARTState    uart[AX3000_NUM_UARTS];
>> +    AxiadoSDHCIState    sdhci0;
>>   } Ax3000SoCState;
>>
>>   typedef struct Ax3000SoCClass {
>> @@ -65,6 +70,8 @@ enum Ax3000Irqs {
>>       AX3000_UART1_IRQ    = 113,
>>       AX3000_UART2_IRQ    = 114,
>>       AX3000_UART3_IRQ    = 170,
>> +
>> +    AX3000_SDHCI0_IRQ   = 123,
>>   };
>>
>>   #endif /* AXIADO_AX3000_H */
>

