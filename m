Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C132CD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 00:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMbDn-00068N-Ff; Mon, 11 May 2026 20:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMbDf-00067S-UC; Mon, 11 May 2026 20:43:31 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMbDe-0002vN-6s; Mon, 11 May 2026 20:43:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v21XJsGYHDQ4PR5NlL4RyMDWxztyFt9fOEJIz7HdW3ye/zVwaMUJOauQajvZ2IPQzV/XRnuP5/hCDE7Ztyq+zN3vFxyJYwOJHuC49rfEcxrqq3n5OR+k0olMC9Yx1tjzXNgedxxOcCgufsW7uoqrTcMtHFaOwv6rCpcgLzMEe3QIqiwavruNMO3qIwBpHUCa0k/4MOMGO4fkWH6wy1EVdHClLFpITed0XLiVvr5lGQPQChnvX0tJx11QCLsyKWmvNHgga7aOW0pKf+/JPKSLEOwhrCT8X+yM82zoAqztYJqIUTJyfGcdMIg3zZ40mlntS4MokoT3QjPEOauyIZi2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgu3cBMyLecwzj5yTnwWHtjQkr5m/HFL6Gxy3qqgtQo=;
 b=xpMiv4rJdLNRTka5yzGWUcfxKvtKIxsCecLsFKoGJtJ7A+BGtvZ/hnTu2Xwog2mzH3nmVi4EfJTSJHML4mbspRnwVYLF7A0jXk7khrtEAPpaDQMi/4Q6lacqEy+DI4TT17L8lYdAQZPdVpYx4VPxqJUvPd3s/HMZk0b9Qidt9hXLBoL1HYMAZg4ZUouJNqKtdWHSvrgBlveWPeirHDvH0DC6rtE8wbaORqPEWpNGSvYHfEfBkMkKpCOs6xN1rW4iwKw7sk0U3EQw+QSq0hyiXo6bdkK2BoSVtqi9yU8ZLrXkZkVQSM6RJfuFx24Oa0txo3IWycvZD57RYBt+K55/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wgu3cBMyLecwzj5yTnwWHtjQkr5m/HFL6Gxy3qqgtQo=;
 b=dp1BXf9u5pTm/MmzCxFHKJKhDtwbIdkf382TKxFD+GL1jn9K5bbJmKExaxwiirhk6YtJswbsIZZ9mwrgvZLFCUO83GwiibzbtOjdhLJfzeabajUBLOTeAGgVJzvUH4+JYuWaBuZgQiUkrZW/k8panM420sdwJfd5TK94a6MYCSgr3ntLEypyvfsqYrgIGtFzVM9psc83aqN1mH+68X4f/wS2kUpNdtNSho38IKAlZcvw8bgMSzTo593+UF8bzPqNjt+GhzxchBRp8JoGTy7REV4dVa3LxG69B1DYjETuYSS/etrstoAOIihiU8/y9c2s/LnMwAqI9A+6h5MLz3dlDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 00:43:23 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 00:43:22 +0000
Message-ID: <d193da58-27e5-4c1b-b11b-1e83b359bf6f@nvidia.com>
Date: Mon, 11 May 2026 17:43:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
 <20260422204335.23116-8-nathanc@nvidia.com>
 <cfdc0d2e-59ed-4460-adb2-23dee2ca157b@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <cfdc0d2e-59ed-4460-adb2-23dee2ca157b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: 0114f6d8-8a95-4904-a3e2-08deafbf7846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: HqVt4/xX8ucnAvVe2dwgOWV1LfV0J+Q04ZOusvAHPt093sSZOA6GGRI3YrGcFkuyW/Xy+ABC3VVWkn5jpaxcEISowXGWK/AADwBDjU9ozKPq4Z1toJ2eGh0qOgP2gcu8jMTPu1TKu22qdvbR9WFnHalu2T79BfeP/2QyS7xlbIpRUBo4EOD+SBaoQX0sxa3AlfFHKtq4Rr6kVhSgm857qbRs3fzFHYS/RcUa3sjY4pOxmMSz0e1D7uLLI25us358CR6RyBXABx4adm1FvQgTHwznpJuDO7h0vcHvIbhbwLJp8RotOf+LgHGULG04agTyG9PUy2liWxRmrvfB+KptskXzfK/ak+eQUjHpWOqOY8qcbHV/Dug/0HIA27pe7GtaB4zz2ALdexo+RuFgTNG0RmlbJfW95vTPK6K3nTS48mAi81xGw+NNSGvonjlhidBQ2Lb5f040x9VDp6KamSWkkmLBR0nWcO7XCvSyC9CUNYbkZ8Zc9Hof0An0Sx1u6TbOx9brFsCJRLnaK05xbzHBYzpsmCexEQM3D0nghRp7cMIUQklTvAeTBVWR1/T7uGZ6iVZBnp5LIhhm5ckh/ETC0FoVTAqoosWs82d18QQ0BVag1uWlzCrXxubkfSckv77j4RgnG7CQWQO0LaPl5k1LWUAx8PY8jlNcHf7lhkDaVZYOsmol2Bx5s1LCwFqaB4kt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEU0RmJ1SHk2Mm9SRTIva0JucU02N0NXSmFLY3duVU1ZQXN5Y2pvOXIveHM3?=
 =?utf-8?B?RlF0K0Jkd0dGQ0Y5aWl0eEVITzQvajRaM2hHcms2L05pdGhXYXBRTHUyek5B?=
 =?utf-8?B?M2FUaHBjbHBVamV3M3VEK0F3MXpwMzJ6TFJXMm0rbVV0dVdsL254VGhkZ1k5?=
 =?utf-8?B?N1F6YTRCaU5uVVRCcDY5RFpsN2hRQzU0aytxYzh0YXIzckVlTFJIbHY5T3Nz?=
 =?utf-8?B?Vk1QbzNMQkg5TGtHMHFiSnNTQkJIWmFHMmlkVmZaeE9xdGtNckVEVXM3cGcx?=
 =?utf-8?B?Z29xSU4xcHhBUFlQOGlwYVorUG1Jb1F0NmwzdmJGSnpuVXRxR3JkWU1ydkFU?=
 =?utf-8?B?UzlaWmw3d2pkR1lBeDREaStYWmp3Nlp5cnZjVW1RenlRSkNadUlVQlk5Nmk2?=
 =?utf-8?B?TUZqS1IycFdpYkg4Yjdldm9TaFdPMzM2Q21CMVBHTlVUeHQxa0hRb1IvMDZm?=
 =?utf-8?B?bEJqMG12ZXJnRFhuUUdXMUF6Zk5Tb2RUUUdCaUo5eEtNaXFwaytaT0pDL0p5?=
 =?utf-8?B?OFF4ZHp3aGRzOEtLVC9nWkt3a2YwZk44YU5BN2JyWWZPaUZlR1FqeXRVbHFI?=
 =?utf-8?B?cUxhNHVkMHQ1WDFTVjNKWFR2UjNBd1lqTEd4WitWdHg2RlFDWTd4NVRKaEFx?=
 =?utf-8?B?ZURyZWV5Mzc2ckxCRlhLRndOT3lvQ0w0V0tFb2tYTmhPZFYxR0Q4L3FIa3Jn?=
 =?utf-8?B?ay9HRWREbW9aNktkVDNyUHdnQjZidFZaSkVISnFLRjFQNVhzS20rcFlpL2VV?=
 =?utf-8?B?bWJYUmo4L2ltM0o4OW5GT2JaZks5R284UUVUSjIvZ3VzdElvK3R3OWo3WHd3?=
 =?utf-8?B?SzlldzZVODQwbkZobDhybXBPaG1pbGNabUZDWlBlcTNQdzJEREFvZWV2VUFC?=
 =?utf-8?B?aDhKaWFRRU9vS01aQjZnNUlFREp0eGNmanV6MjhRMUlHQnJQbnhOMHN4TGhu?=
 =?utf-8?B?NWF0VEJUamdtYndiRWhkcEJGaDlDMWpTLzBDbW1nZUliN2ErL2dmQWU0em53?=
 =?utf-8?B?Yjl5bjZsQ0J5cWRSaVRZeTd5eTJYZytHOFVMR091dFg1cWtLdjBQbTNnMG1D?=
 =?utf-8?B?KzNraHlNeW1QaTRHV0lDUWNHZ3N2Z1pZbFRLM0dMZVcvWGNTNFJrWlJPMitq?=
 =?utf-8?B?d1NWUXlIVG9JQ2RjZGlabXFPRVFwR3JrdUJHd3RaWXBzWHVDZlkxWlBocnJD?=
 =?utf-8?B?OUxNTncreGdMQ0o3RTVvTG9PcU9vQ29RaFdodjRzTE94ZnJka2I1eFd1QTFx?=
 =?utf-8?B?bFBOcHZDVEF3QVpEOXBXTDN3TURjdVpWYnJkTDVTMHF6TUNDUGIvdkVidEky?=
 =?utf-8?B?RnpCbDNHSzErYzYxV3NHUUt5QTBCTitjMmhUYS8yMUlZTVUwVFRVTG1hOGpD?=
 =?utf-8?B?VWRTT2p2cEMzdWxwVjIvZFdPKzdqc3YzZGt2MUpoVkowMVcyTGVSVE55ZFJq?=
 =?utf-8?B?U2x4VG9lQTVVTTVOVExiUkFJSjd3SFlhbFJNQzl0RVlQaWN0dnlOaHJRdk1k?=
 =?utf-8?B?Mlo3bHVTT0Jhbm5EM1BJajhCL1E1cjFYRm5nS0xoR2J2N0xpRnhGRkZKUzRS?=
 =?utf-8?B?L1Q5eit6Mk5ESkdMbmNhWHoyWnZ3WXQxWWVJby9JSW9EcUFpL25vK0grc2dZ?=
 =?utf-8?B?cFNFQTBHUUs4Q0ZvWUJ5cDlid1JFdWREVE4vMkU0TjlWK3BiVmxkd0MvZmJu?=
 =?utf-8?B?bDdxbXlwV3Aza2xvSXFENmVKbW9BR3V0cUIxamRsZWNpOVJBNEE0R2lmamNT?=
 =?utf-8?B?WnJuM1JnOGd4UVY3TkVGeUdoRSs2TUdkK1pVS2FyaXByUTc5V3FweWxDblY5?=
 =?utf-8?B?VWFMRXNKMXBxMk1Ycy9BbmNWaG5OcE9mL0ZnQ3RvUlBrQjVWY2VQMnQwL2RE?=
 =?utf-8?B?VTBmS2QvYmhJd3Z1QWk0R2ZWVnppeTVxdWhkb0VnTFhqbnIvVjBMUk5yYmxI?=
 =?utf-8?B?SWIyZC9Ec3ZLVEd3cmlDN3BVQkpUc1V6d05VY2pQL3hOTUpZY2xMMUhVYVBh?=
 =?utf-8?B?MUlndWtnMkxmdzhiSThVN1FuR1pHYlpwNjdtY0hTaERJbDJwUW9pWmFkbXo0?=
 =?utf-8?B?dXVzTDgweWNUUGVrM2hGT3VMYlFpbDBld29BSHd2blh4VlJFblRJb3didlhU?=
 =?utf-8?B?TnRSbU4vdjJCZTNCWUdicHdCNURBQVJIWTdXOWhrSGNDZXcvWGpYRUUrVkx1?=
 =?utf-8?B?VFNtTjJ2enNKRUtQTVI3dnFoazJ4YnkzbERmT2VTRGt4cHE4SE9nQVpYb29n?=
 =?utf-8?B?bEswK2lmYkxRVm1Ha0l4VnpYK2dpN0RVejh5ckR1QzltdklPVWthYWQ1S2ZT?=
 =?utf-8?B?VmFyTHlhYllrU1FtVGw5Z2o3S3R0bFRGQXFMYldPQ0M3YjEwY3RHZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0114f6d8-8a95-4904-a3e2-08deafbf7846
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:43:22.7680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulIZLR58ewqVfA2w+zjpGtiXtap0Sa6OI4UFL42nSB7xSCMMcBapgGaPYgYNS9QFN1eiSLBbtzbn6nPRmqQmpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nathanc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi Eric,

On 5/8/2026 5:08 AM, Eric Auger wrote:
> Hi Nathan,
> On 4/22/26 10:43 PM, Nathan Chen wrote:
>> Update documentation now that "auto" is supported for accelerated SMMUv3
>> properties.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   qemu-options.hx | 33 +++++++++++++++++++++++----------
>>   1 file changed, 23 insertions(+), 10 deletions(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 21972f8326..2c6ba16a26 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1291,30 +1291,43 @@ SRST
>>           Enabling accel configures the host SMMUv3 in nested mode to support
>>           vfio-pci passthrough.
>>   
>> -     The following options are available when accel=on.
>> -     Note: 'auto' mode is not currently supported.
>> -
>> -    ``ril=on|off`` (default: on)
>> +     The following options will be set to auto by default if not manually
>> +     set. When accel=on and these properties are set to auto, the value is
>> +     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
>> +     accel=on, this requires at least one cold-plugged vfio-pci device; if
>> +     none is present at machine init, QEMU will abort.
>> +
>> +     If accel=off and these property values are set to auto, the values will
>> +     not be derived from the host SMMUv3 capabilities. Instead, they will
>> +     resolve to the defaults described below, and a cold-plugged vfio-pci
>> +     device is not required.
> I would simply say:
> 
> If accel=off auto values resolve to the non accel default given below.
> 
Got it, I will simplify the accel=off explanation accordingly.

> 
>> +
>> +    ``ril=on|off`` (default: auto)
> ril=on|off|auto (default: auto)
>            -------
> 
> I would rewrite it into:
> 
> Support for Range Invalidation, which allows the SMMUv3 driver to
> invalidate TLB entries for a range of IOVAs at once instead of issuing
> separate commands to invalidate each page.
> - with accel=on auto means the value is automatically derived from the host SMMU
>    if explicitly set to 'on', the host must also support it.
> - with accel=off auto is resolved into 'on'
> 
> If we have this explanation here in object_class_property_set_description()
> just explain the basic semantic and list the valid values and default value.
> No use to rexplain the auto mode semantic.
> 
> 
> 
>>           Support for Range Invalidation, which allows the SMMUv3 driver to
>>           invalidate TLB entries for a range of IOVAs at once instead of issuing
>>           separate commands to invalidate each page. Must match with host SMMUv3
>> -        Range Invalidation support.
>> +        Range Invalidation support. If accel=off and ril is set to auto, this
>> +        property value will resolve to on.
> Same for the others ...
Ok, I will leave the auto explanation out of 
object_class_property_set_description() and keep it here.

Thanks,
Nathan

