Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C588DF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBH4X-0006Cu-St; Fri, 10 Apr 2026 14:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBH4W-0006BN-O1; Fri, 10 Apr 2026 14:59:16 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBH4S-0001EN-VK; Fri, 10 Apr 2026 14:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec+vUyxmjvdCLHKt4ytxxyTNIZWqPFkcL2e6Ci8Gb+bzGuyAMYkbB9ANcdg36OT4mF5JZkHLHYPGfwN5pX6WpUuGFb6MtRZwR5ikuFz8MeHz2AN52xnCtOb5nSoKJ25gsmxV+ateblvVgxWzjXafdOn8PW6osGlm9mfGtEiAi16ug5UY9Koa1U0TFIvYlGouPeokfmFOOaAzcfWW3pKxqptDtOeXh7u09/Ht4gdggSCKcWfx6SyFogdVug6blJFfdE/6XjL/3JZsq2TZyUqQGW+lKUpJvBQGiVbKBA+HknEMC4ZgAUXeJ4QUAX1dyb6FpeocfpCUAcemL0M089aLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFYiEMHQ8zTYILg3R1CWJ5LHyFp8mda4/YnYod3iotQ=;
 b=zGn8HdPtbOWAP+vdbGo3YNflx8Ou7Ckb1FVzUDcWqciOHx/dUDdR5uS6JPIPclGTABEIOzKckMeoO/AmvljJSWJKJN5suBCb/ruQ7xbnoSiKHiUgY/7jHBS+g5BAv27+u4/+bPLJW38ZvyPZGlL6NS8rEzO9T88XFZYUAgEjBe8rWiq8hfIMpYZ8JJZ4DfbxhhR8529MHzcedxvB7wxQxctJRIZJNRBGub/DtmevwbuIX0/BjCEmLQmR9bEv4/2D+ma7SIWPakdJXAMCBFiJ41RJbv5XpLssFV/PN+ATiTjoB29T/Kd0wji9C8YYFjyjonpkoEj8k0zCsPdMgkV5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFYiEMHQ8zTYILg3R1CWJ5LHyFp8mda4/YnYod3iotQ=;
 b=QnyhxEVwdFiQ47EhqRGkq+qHFLRnghbEkFUkz8d33cwKpYLsSqekKr/FnCykA1UTCVXC1nbgMkGjr31x9dOc9Yd1SIrIVwk5iLOBJFfTqw14fa+2KNmrXfA2Ur1/Th0B5LmYnkJSO2jGAc4zWIccLnn+roWgAh33Igm8E8BSKJd1XhVbM5OTC2Dvayow3fGvvG6PV97DqsM+JZ4+YFysOmO5BdP3jAbeGLc/oVLjL2j1yPmEYllgy7tvrXAcaV9UBpvX4ezJKs318PWIj7Y/PliYrqWKRafo5JlJ4Y3X9Dgb7DHCygURu1HskGdOdfwmEMNjl01j+OEGuRYcHJTIdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Fri, 10 Apr 2026 18:59:04 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 18:59:04 +0000
Message-ID: <2d2848b1-cf80-4432-82fa-801cc5f09086@nvidia.com>
Date: Fri, 10 Apr 2026 11:59:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] hw/arm/smmuv3: Change the default ril support to
 match the host
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-7-nathanc@nvidia.com>
 <a8cece25-47ff-4210-8962-cbc39ba7646e@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <a8cece25-47ff-4210-8962-cbc39ba7646e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 48751cd3-a5f7-45cf-146d-08de97333bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: nt9tQGDAKPvtZ4Gth/KHZ50wEZXZgPbN5OORRXaeNASDIHv4IRwFac3r6PIf8xAV92dQoFcEa1179t4DTCXOCPsMUbP5KD9rCRyTpD9ltPZ0SrcEi4STDbb0H4r/cEmwQs4lMo/pLiHR9HGDb5Pc/6JdqKbHkS8X1pyLPE7hif/yJC3422b0hFLTx+HX5TB4y7nr6a/5nQOITe8BHFG6rTY6xOWkwXqgG6PTBD1Q6hN5el0AMsIA3itfsei/z9nQCZro2mcPY37vjFqphFo/7EyoIazb0GpOjkPI3MO5RqNWc6Ts3YcCULhi1ZWlQ+ggsJ4jWzHxrYeekgkAWRU1ASqc/21kLYkRUoQKUVOrg1k7SLCjkMjfL+anfl/zpKGCJ4auK9sEJLFaPVcgw1/M+Czrb2ZTS3gwHHULNgVT8ZRHtHHDTJIudaGJn2esjX324m7iQy/NbjDnY9pcTAh1fU7l6TwXFpMYHAvN/AmCdc0Ede8vR8248rOxjDjhQxebmjmnjIsGfHLYpLOF/a6MAU3Q8r4VBYmMV1ybdacyAKSdT5xSvfHdslU0IFxPVOVqfsKp4tAr0yKtg9Z9Ge9wj66JIlSlF2bqFzlCavbOr8jtxDDs6fLyJiQVVEE55MqX/IhBEpzmCHYOXXeMKWqzMqgPzad8zT+pQHnaXbBqZGJ4EJTF0xyqwLjFmXaxZuCghxc98xtQb5ePFh2DZTJG8fDvs9IWWx+95PXT941KxgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjQ4OTZlTXE5WjBOcWdzUXNGMWxaUTUxL3RMVFJVSThaUndMeXhSaFBXVS9I?=
 =?utf-8?B?V1NCdW9DNDV6V0kyVW4rM1NDVXdtcDRpRExNbmlVb24wVmZYc0tkNnpOL3By?=
 =?utf-8?B?TS9wMmszdDB3YnNjU1c4QzNPMUYwRnBNTWdSUUNISmlIcEFCNGk3akI4Ritr?=
 =?utf-8?B?QmRhZVNocHZpdmdaRXh5V1cxRGk0cVZIWmUrMytFeVo0ckVNRVZYdWwzcGxn?=
 =?utf-8?B?dm8xRkpMTXovd0NrL2hWOVNkTFdHK0pUVEpvOVh3eXNDdk5CSGF4b0hHYjM2?=
 =?utf-8?B?SXlzcHZKMVpvd2Q2ajBpSnRYTEpVQk5iYW5MVWd4L3B4d0NGS0Z6S2syL2JP?=
 =?utf-8?B?aTJpbThuNFZHdGYwazJKU3JZTHpSS1RUdlVLYzdsSEdvM3lkd0FmRW8za0py?=
 =?utf-8?B?aFBxd2dXUjlhY1NiOFRNdG5MQnFxMWhKaFd5aloveGZtUUZvcWRJNEF2VWVQ?=
 =?utf-8?B?WndkeStENU04NFpRZ0l0VEFWN2JBTWFURW0zdlVSbVM5Ym15N0N6NmVpa0dV?=
 =?utf-8?B?dnV6c2E2ZVRobzVObElsUm5MUXpSV3VRaEVzTDRVbHU4WCtFWmxuNjR5eno0?=
 =?utf-8?B?RXMvYWNNWlAycDhzbHlPaGhTNE1qT01jcWdENnVLT1cvODBMaTJvS1RSa0Zj?=
 =?utf-8?B?ZVJRVCtRRGNjZzZ3RW91cUtpcC9MN1JKbG9MRURtUDlaSzhuVUd2MVNRRUEr?=
 =?utf-8?B?OTY5Q2t4ZXlUTHBpOTl6L2YyNDN6T3ZwQ0RKWkVNUWszYmR2QjdIbWduTUtT?=
 =?utf-8?B?SWt4YWh2cW9LakNyTEpZV0lrdnlpZVg5cnNyallLTTJITmNqVW1hREYzQWdU?=
 =?utf-8?B?c2VmNlVxcmtKQTZZMW5TUlRsNW1CMG1uM0M2TGw2N0RPenlKU2huQzR0QkZx?=
 =?utf-8?B?c0hzSE90Z0kvTWE4dEZCaXF5WW5iblNheHdSSk5HcHFJdDhONkZjcG9NUFJ0?=
 =?utf-8?B?azVENWxOVWVObzFnY1lnZjRUNmlQQ21xVzBJdTdnTG1FYTRaK25iM09YZXhV?=
 =?utf-8?B?QXRQekNlNXM0R2FleXhGVXA3dTJRR0NJbVk0d0JoWXkyL0FJRklqTmpXM0p6?=
 =?utf-8?B?MzJaTnN2WEJWQUU0dllrcUMyeU55VlFTcjVhZjRyRkZVY3JiR2JTa1B4STYw?=
 =?utf-8?B?K1JOd1BEbmh5TjNsVEsvWWRKVGxHVFErSHprSnFoN3BBTmR3MjJ0dE1TSGVC?=
 =?utf-8?B?RDg2c0lZRUZvQ0ZtcFhxME5HUXZRUmJGYVBZT2pTOXYyVlNZVVFIZGZzQW53?=
 =?utf-8?B?NThZS3JJaEpvT3UxYWdlb2diK3VnZDYwN0ZkUDd6cG04S0o5Qm90VmhvblVC?=
 =?utf-8?B?WDAzSGNBQ3ZHNW8rdHgwcTJ4eG1ZUGpCM2FySWxKeW9abkRoekFMdFkrbk1q?=
 =?utf-8?B?T0VGVnZNaFpYazk0WUdwd3lTcmhuLzlxeDV1dSszOGJzQldpbHBZRFphUVlY?=
 =?utf-8?B?VzdQMUZIcTJRa1dlenQ4Z2ZiMHFWeGh6T2k0S1RiOTJZcGd4UUlCcTVZSk1S?=
 =?utf-8?B?QVluempDNXM4L2g5SDQ0cWczc2syb1FzeWloNUhSaEJrTFVqRHMzb1FhZlpa?=
 =?utf-8?B?MlhlbDZRV3JjemJFL2psRmxIeFZVYlRxL0o0SjJHM2crc3c1a2MxRTQ2Mmwv?=
 =?utf-8?B?c2laRm9xMzkrM29PQ0diVGhDQzVxMFNyTmVwZU1KaWVvT2FQZDlZWEVXVHJs?=
 =?utf-8?B?dGFmTXZKSDU4Um5PWWJJeTFGV0ZBWnY4K3FjMmFyRDhGTzRQMFJoelQ2YkJ2?=
 =?utf-8?B?cmpxWE5lREtmc1RRNjlZM01TS0dFY2cyWURDQ3NWb0xaWlNJTUk4TThtRmVM?=
 =?utf-8?B?clNDZXp0NjFkcXZwWk15U2RwOTJJSXd5ZGZrSUxLRFJtQkRBeThLRU93c1BQ?=
 =?utf-8?B?Mm9paGdkMUM2UGtuVHJ1OFB2TVM5WFFDRGl4Z3dQYThTSDdEa2NnTjFrcmRh?=
 =?utf-8?B?bmYwaGt5djYzejlNWlNzbysyWGhSNmlpT3ZQMGR2b1lkcU56UDYybHFQbllB?=
 =?utf-8?B?QmNYdGY0VG04V050NkV4NzN4Nyt2dDVRTHVBcGVXQ25jUkpHM3k3c1p6azh0?=
 =?utf-8?B?Nkc0OGRzdXJIRW8zRU1nOHpYQ2lBLzF2TnZFYVZ4RmpjQklDQWI4ZUpqcDJM?=
 =?utf-8?B?YnNsZjlneDlvOUx5cWpDdVhEdFkwSGUrR1ROR3ZPc0tPVGFmVldFU21lUU9V?=
 =?utf-8?B?VUtnOU9JOTBlbjJSTW16NStVUDljSjhLbEI4NVE1Ky9xbUx0aFNjZUpJais4?=
 =?utf-8?B?bnRsSEhWVG4rdUFrQTFiT1lpNTdRNEYrMHQvWlN1dDJlM2oxeDJkQVB3c0pl?=
 =?utf-8?B?Ym1sQU85Vm40OXp0MGIzdDRQOFFENW9pTG9LMnNNREJrOXlYaHI5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48751cd3-a5f7-45cf-146d-08de97333bf7
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:59:03.9905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hay16WomGU6XoOue2Ae9Gb6eYJ7aROwsFJEqguWKhLazQcmcgeiRluDyyCWuopHl8IlarDw06M1wqXGWz7ZSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=nathanc@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On 4/10/2026 12:41 AM, Eric Auger wrote:
> Hi Nathan,
> 
> On 4/1/26 3:02 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Set the default value of RIL to auto. The default for RIL support used
>> to be set to on, but we change it to match what the host IOMMU
>> properties report so that users do not have to introspect host IDR3 for
>> Range Invalidation support. Include the previous default for ril in the
>> 11.0 compat.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3.c   | 2 +-
>>   hw/core/machine.c | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index a2d2f0e3bc..74cc81ae32 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -2153,7 +2153,7 @@ static const Property smmuv3_properties[] = {
>>       /* GPA of MSI doorbell, for SMMUv3 accel use. */
>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>       /* RIL can be turned off for accel cases */
>> -    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>>       DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 6796ab63cc..8f8c26bbe8 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -41,6 +41,7 @@
>>   
>>   GlobalProperty hw_compat_11_0[] = {
>>       { TYPE_ARM_SMMUV3, "ats", "off" },
>> +    { TYPE_ARM_SMMUV3, "ril", "on" },
> I wonder if you shouldn't squash all the patches that change the default
> values of accel props to auto mode into a single patch, at the end of
> the series.
Yes that sounds good to me. I will consolidate them in the next refresh.

Thanks,
Nathan

