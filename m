Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7278F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBH0Q-0005RJ-HA; Fri, 10 Apr 2026 14:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBH0O-0005Qh-QK; Fri, 10 Apr 2026 14:55:00 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBH0L-0007rN-25; Fri, 10 Apr 2026 14:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXn2XSjBDI3aGB//deHqxy1R9WUOlBW7whZoxsp7xQ18U8ZHmXNg92U/HWugUCKrAR6+OhA/hIIib0jaNENnBI0PRFaHxFXeic3idP4n+1aZO4m0VG2GMSySFuh388LlThheMbDsvItfc+6IokSCcfvklNweQ2pZVUeZJONhSZeVr0AP4+wq3MkTl0dBRcoVy9vrvIqZzVlVf8eT6CeWJtKVt06kB4vNtYES0GNK2HTAi+xSkXpevBzWet/YFNcE5WxRFAyw581JIar3zmVmowG1yoZoE/CCSJ2jpHcs8WQVAN5tYdSRpvnWkKcfTlHcCfL3fNRUkiRrijlHLyK1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EycZZA140HkX7E+gRODQGbsHNn3cjTl/o6+0xLbtqPc=;
 b=cFQCA/SFZ1867XZhIvsg3nQBkMLAiv53L70BzroU3wiCr2Zq94k9UIGp4CMio2cNS0gb0VoxgBlBomCmlOwfzkmMFw4EUjZMG0qd+O4TLQ5iGkx982GZHaJs85QompelQKIcfSV4rSXXs9hzeT+Y4cUMyflzPwV3THR869QyZvgTPxCyzOKO3OQCZKa2kyeX6vs5V3h4fozAu3wbDZtn121MnItKgA+Vj+VQPVXFCUbLZye/untQJtkWMN5M39HNsFPUFGedR+k4RC3k7y4ARzjZSXMnRxwvDFhtxPwkSmKMSo3gqz3fMzY7vhluGPNI57JaGc27iRnmGTO2m2sR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EycZZA140HkX7E+gRODQGbsHNn3cjTl/o6+0xLbtqPc=;
 b=SJGO55nlKRuZTeNCu1BXHqpSiF5GlPMv8R7VjcdJkebcxKU9NWk2aqDoA12qyTaG5dYQl1PdNBiVYRze2e+9vMTyRB8E6cos2MYRNhlUMFe7fIU/UFMQDbyR59Yf/g8nC79UnQmEuzlCpHy2vWcM+JUNSrvgHnGDkoRbVlZNTAGSL2F1TB1G5rWVu63+a6SzWUWwq9OW1QyZfWqZ9aGpSq5uADzNXA4UsavBBii+9XVo9I6CEc8KqV3O9NRdRDSG4ysLlCSSIBcJITTBiVDHoIg0WxWID8/LukqyP4/fM5A5n/XIi1AZom82Jzfam6ZVozCtZkCc8EEJ1bINpxX4kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.42; Fri, 10 Apr 2026 18:54:50 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 18:54:50 +0000
Message-ID: <bfea1ee1-af6f-4b27-b37f-13f7aa3a30e2@nvidia.com>
Date: Fri, 10 Apr 2026 11:54:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] hw/arm/smmuv3: Change the default ats support to
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
 <20260401010231.4166776-4-nathanc@nvidia.com>
 <1bdba168-e5fb-491e-a9ee-6311bc95b38d@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <1bdba168-e5fb-491e-a9ee-6311bc95b38d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 344b7eef-db32-4bfb-e3af-08de9732a488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FE5qO7NdhjnBz2cr7NarxR9BpKSW4OuUmqrwF2nDA6ggXgqT/9fJxU/C6CRzL1i/PpHysK3iacTBNM0HpqROyW/+ib0fcKjR5YpvfFQ7F0z7qc8KMUDK/o2mW52/P645w2mhYS1m6vEt8jDbUbUZAhaicFgp+m1eUdI4CNrR+FuFngYNcCIfZzZrq59qtA5UGOFAKlBJxbjBzLosqAHEQD6f5S5ceimfIBkwAaulEYkcBTzYIDq1EV8NkEeYeZ8zA6l/cSft/jXjwDucxcuqw7g/L6cN3dyb3QGbXSQkzOcpJKMn2j/XR2CIJlWrMaIkGQ6jEVbvu30OC4cNsICOrGLRRgaydFcEyc6LPvbBro2YIoybLTz27NlMpzJTWFTgJDxXba5FZ1mNIHVj0Fm557m1Yc0ylvw11BD6YP4JhW/F78z5YNAtn1MK93/UhO3+DBBz07kz+USAhlDWkiEhKO9qvO2+n1D81zo/F+w/Eowvrtc5wU3Ulkt8JDdQscZUr4FdlsPdUTqRiEnFZ5mIVbizMXbPWMCnDoX7cUdRzlRzejIBqlnsX8v819rtE/o4xOW+FeaCucy8yLVqbygqs2HC8sAVyIgFCD6TaMfkyJ5BG5MrF7OzUlpmE7cKf0bhW8fU/LYfhX2vzz+RpKl0UddUUJ0i9mgsi9Q7gmzvHEcLLkXh1N1K16VvNB4HbcHzLgN8VhZflCdgFlgRGqVWSRREShdJP01rYkBWs5Qhk5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJBNEpiRFpxdDB5T2JDQUZ4MWl2L2Y4d2I1cnRxOHhRaTB3UGZtTkZvZVNi?=
 =?utf-8?B?YXB6bjloNjFPVFJsZU1WNDdSdHAzZWtqbnZ5UnpSanhZbjZpVlV3azhjK3l6?=
 =?utf-8?B?eSt0QTB5MXBYWGl3NTk1bXBoeDFkdzh5cXdtRFZtZ2NVYzI4MzE3ZjduUytX?=
 =?utf-8?B?RDAwN2xLVlFxMzIxRTZUTlU0dTFiN090NHltN1VEcXlTVkFPb2ZBc2ZOdlYv?=
 =?utf-8?B?R2JKVnA0b3FNL3YxRzhsRWtDS0RHZVZCMjRTTXFUSEZ2enpRdEFUcEN0Z3JD?=
 =?utf-8?B?dVhEeUN6RlFQRWp5L1NrMyt4OEh2bGNwbFhkdWZJUWc1YTBCT0J6cFJ1Mi9J?=
 =?utf-8?B?TTZ1YkNRbytSUGVrcFZxQVVmVDA1UllXaEZveVJWVmVqZzJjaVBvVlJia1k0?=
 =?utf-8?B?d2kzbFcrUXZBc1dmYVdSbFJwR1diZkkvRmRZYitiQmpOQ213SWt1bWxxRW5x?=
 =?utf-8?B?UENySjlwWmMrTDgzTldDK0VlTTdEd0ZmTE1LdXRqWFM3RldWcGg5czlsckNV?=
 =?utf-8?B?Nzl0R21sY1lOVVlMbmZod0hYSjIweEVRRmJxL0thbDAwemRmWEdhTEtEazVO?=
 =?utf-8?B?NE54UXAyWmlYaURHWk0xdmxYNkZqaDl3K09nRlRqZVFmNXQzRG1pb0V3cGdm?=
 =?utf-8?B?bU8rWCtpTzdRUzc3M215dFRjbWoxK0JCUDNoMXdmT0NYMlFEa3E3V0NXR1Qz?=
 =?utf-8?B?NzMyWHhrbFF2ay9mUHNCTGN2WTIzSDNydDJzU2JDWWZWZmVKNkJtaEVYVWwr?=
 =?utf-8?B?aDdMOXlmTkRzOEo2MlgydDF2bENDamJKYm44emlYNzd5dkRuZ2RaOGxRZTkr?=
 =?utf-8?B?VkJucjlVZlVxM21ERmJKVDNObjZGMThjRDhMekIxdjlWbElBT2tQbWhONkFK?=
 =?utf-8?B?dlhtNDV4Q2M1T2pFSS9hSnRuUGpic2luSnhlUHJvUjl4cHNnbkZJNVNnRm9t?=
 =?utf-8?B?OFJxcXI3YjJkQjJLTldjY0ZNNlJlcExpdmlGZkN0SkhPTE0vaUI5VUZCSk0z?=
 =?utf-8?B?alB3QWQ1cG5NalJscEZia0doSS9HbUhyWDdMQnZydnBhWHZlSzE3K25KYXlz?=
 =?utf-8?B?ODVHZmxFdkxZNlRyMnJNcFVscVVpRHVGa3hHT1Z2cUZET28vN00wVVJrOEps?=
 =?utf-8?B?RFMvdVkvNE4xVUpoTThpKzBzdWFjN3hESFYzSHNBNGQ1aGg2dXk5Y3NOUjdl?=
 =?utf-8?B?aTZxaGRBK3VvVSsvK21oemZGNGVBbTRveWFyZHpkVmZVaHhSVm9XakQrNURu?=
 =?utf-8?B?SWp2bks4TUQxOUI0TzdDOGl4TXNQWjg5dmxick16ME15WWZGcHpzeVQyMDNI?=
 =?utf-8?B?clFQb3U4VjJYbXUyS0lWaFFoMFMxdjZGNSt0Mkw5S01FRUNOTUpPYTAxOER4?=
 =?utf-8?B?UmUyNmhFelBLdVBiSFFFWjdCYXlFUG80Y29ldVdrWjhJNGtPT1o4WGFHZlF5?=
 =?utf-8?B?Qkh0MTBCMTRCZ2VBa3BHNnVCRmJncWdrQmlVZmVPQlEwaExmOEFGY1pEa3Bj?=
 =?utf-8?B?OGFYQmdaU2lUSTh4UDNrei8zemxlNCtsckVlMkExMDFNSWJHRVRFTEdnRzFH?=
 =?utf-8?B?Vm0ydHZQMDhYVmZuRnhYWlJ5UHJ4Rk80a1AwUTMwM2t5VnJpdER3cnU1V1o0?=
 =?utf-8?B?cHlieUNzVjNYSVM3ZEhzL3pWYXJET3RWKzltQ3pqUTRKOWhxRkJzVGlRMkdK?=
 =?utf-8?B?TUp4akR2bTNwZkIvUHdVL3VLZytuSk1TYUV2NlhtUHlxVzZ4Q0IzUTZtcjRz?=
 =?utf-8?B?NHRpZHhSa0dEUVVqQ1UrNnVZc0Evc05aTkJVQ2Z2QitZWmdKbUFtMHUvcGVr?=
 =?utf-8?B?SmR0eUJQU0NqbllCbUNXd2tJVkJnbTFTcWp2MFYzMFZXTVg4cC9mZ0dHRkc3?=
 =?utf-8?B?SWtPWTY4ZGUxbHcxeDhiNUcvUmZjVnZRMkxGeHkxOWNxTDFxUVQ1ZmNueHEy?=
 =?utf-8?B?Ti9DTlhQcjJTZnp0SUZxazZLQkRWMUpLZ3VjVnprQ0dKZWhxRW4xaS9oT05S?=
 =?utf-8?B?YWVaRmt0Wkt1a0lFS2xteThyY3ozQWpIaXlFdERMOTZXYWF6QmJEMm8zamZn?=
 =?utf-8?B?dWtxR2lTWTMyalJVTTQ2QUY2NVF2SFpEb056N3pUcnQyeEUybXltWUQweHNi?=
 =?utf-8?B?T0FzRGZBR2xHck5aQ1pKWG5COVVsQ0s4U3V0eGN1eEcxbGEzQk9kSWNNSzlz?=
 =?utf-8?B?NTZIREo5WTJVZlRPYitadnBBYi95T2lhSEQ0S2NoS3BGZ2o1M1YzM1RJU0ov?=
 =?utf-8?B?S1BvYlg3VHUrRDd6ajhpUTQzM01qbW5KV29iRGVtNWQyYmVJcXpGMnVTd3BU?=
 =?utf-8?B?bXMrbE9tZUM2b1VaalplNUJqTUlLVFE1MVdtcnN3a3JuYVlIck9KQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344b7eef-db32-4bfb-e3af-08de9732a488
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:54:49.9094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFdXy9S3B3jN9SxYg4U53NBP1rzhHb8orzXj0SklHzKX60evsjeP2gLSEAqow5J9GjY4+p2RlnBzeo6Dy3jKbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nathanc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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



On 4/10/2026 12:42 AM, Eric Auger wrote:
> 
> On 4/1/26 3:02 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Set the default value of ATS to auto. The default for ATS support used
>> to be set to off, but we change it to match what the host IOMMU
>> properties report. Introduce a new compat for the changed default.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3.c   | 2 +-
>>   hw/core/machine.c | 5 +++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index f3603554e3..f353865187 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -2158,7 +2158,7 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>       /* RIL can be turned off for accel cases */
>>       DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>> -    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
> see my previous comment about squashing all those patches. Besides you
> need to update qemu-options.hx where the default value is documented as
> non auto.
Ok, will squash all those patches into a single one and fix qemu-options.hx.

Thanks,
Nathan

