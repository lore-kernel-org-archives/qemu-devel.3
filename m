Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3161710775F9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vYB-0005T6-EK; Wed, 18 Mar 2026 14:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vY9-0005SK-0L; Wed, 18 Mar 2026 14:23:21 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vY7-0000jT-FS; Wed, 18 Mar 2026 14:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahnjIhiXnYJs+7GwdrL/k07dTk++fyBxWf2RuUZBJfwd/6x1bfAIThBUvABj9+lxhb/KgDn84159/2mcM5rzABpGgbsGFoX+MYzPcGci8dyKQRYkFbja738ZaA0G2L4Dj3p58dFIycua70heEDIIMigzA3zdEXu8tDx4ssxsBq/qjcxOUgA0SOxvFNcl+oeW51sbbel3tCgSGd5nwm0ofFnXweCahqfwuKd7ScDEpT3Uc3Pmc7bXExYejwUjl8iEQ5iL38xt3w0Y4DDoDcCBcyAoAQLQojfe5sUhY5FWs5cXAcT1TmcumigtMSt/WxfOMCrSvGBCeTAHxEvLbIxk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmLQiI/OkY9533MR3ecbU2fjohBhDxdI4ejIQEtXLZw=;
 b=EKGCpTRfAAKtWzrvy2qutCmnCYozxMwOTgVNNvh6+2xMZunPohghnm8STNaverilXvJEE/eBrFK9zzyMd4ttoGxkKJ95BtRi+ApabKjWAAa0pO2CUjd/DnCgzKIiCRsC7C+/C3OqAs2khYSPPoOHZRYIg8M6cBwq+HQcG0w9j1cFPL0GL/NGDRok1odDQSsS6wVOyng5F8b6leazPk7auCnawmtepGUyl2z6i5dD4zSYdCRqoue8i5YAJ/xAbrg1RC0ADiPD/H/FwlEk+m8CzlVwzJXCg6VvzU/DfQ2E0ZnV9X5kt9O4jJ/L6hXINrq8/CcJR2pkQrHLjPHs1x/2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmLQiI/OkY9533MR3ecbU2fjohBhDxdI4ejIQEtXLZw=;
 b=A8u66STiRmczRNX0ZZFZK4uV0xl7s2+0tAoffv0CZQc+f1tfQiDPoZzsBAhuZfThdjOhTlPSEMmsJqXpD5MyTKY81AeP/ne2wPOryZMi/pNAfCgTXwH/MizyzQnFuvADNnnWvaSgeoEadgUDdjzn7NGvupOFIirM+YgVeSf/Mu3dh8OcnPXk3qWa7kBy3asYi6fzIByZKa+1iHt/r5vS0yEL86iBynJ0ZpxaNIPwN/19f2lGO2hCUX86tCdLfUcQe2h1ODzfBomyDQB0BCRjyMhJIZjhVKIv/0OcNM8UQjyWUm176TZjLH8ipsy0R7dqBflZybtRre0eczEfjYrsQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 18:23:10 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:23:10 +0000
Message-ID: <952bd338-834c-41c5-a070-36861c956706@nvidia.com>
Date: Wed, 18 Mar 2026 11:23:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
 <20260317183755.3721625-8-nathanc@nvidia.com>
 <CH3PR12MB75483F53015873AA0497F3DFAB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB75483F53015873AA0497F3DFAB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: d3585fa2-2e15-455a-6f3c-08de851b68f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: vIXMi2Ey02WHwW6Daiq4k5yvXrMglWYXST5lfmj/1VELDHeAYm0tDBxKA0gbj4WhvO9hu4D4MCnlOdG3nwt+qe4YXjdxJRef2nhoVhWi7X9wK7eBKmyWw0lVufQCaoeO3V5fSdO2wxBLcn6OqNkTIGf12MEIPVHEr4Gb92tN74SJAQoDbnDQ9ycdqIttkJsNzYy2B+UaDIgVID5seh0q32F9xgqqgXAdwMPThiaH1MwMc1XvhK8jt45xnj/RvD46w6FAy6LvjUEP1Y3fCNCu+Yp/Yo1N352fnQItCj88sb5beqwGZwaucL7y3XHy6aHsQrmL9G61FKvGgteE0L+TbWpXbeJq2ksrBJ+cAAHs0KeauLImHh0A4KffxH/rNPHji4o7a4j67b6PUZDOx33NaJQAzbQm1RfRmNlQr2WY61C09+WiUWx4UvFCx+qCFqjWqbtUlyorqOfaf6tmlmSA5edvXASTWC6nViJN7t6rCF/TZB5GPyTtonB7Huz1HWg+aosqoNFr3umVeDiY4pOPkbIgm2PXPAD3XrboKJkx68ouPH7CVjc0qd1mv/XRWgBK7nzzYJtHXhq4QKwJlGaJv6LdWXAS6SGukbJ3OCO9f8N3HE3q2X5xeVS0ONeoOOys5joO83c/iD9WzpKPpXnDPsFFztcslZJrRHIZ4H2Zf4azFyQDRi+4r6sc+dTVW4M8Do8exctlTHsFO3UI/DppZNhOKTq+gH2GdpbR+/Gvq84=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNWZTlBdzVWR0JqYzczejhaN1Z4Q1RSbGhmZjlzSVIvVzA3bGRadGhpeUhK?=
 =?utf-8?B?ZndXTFpaMjZVSGhjSzl6QklPeER1T1FweWczZVRyYWM2RHFtQXltUi8vKy9M?=
 =?utf-8?B?Yk5aMGpkM3hrdGJ2Y1N4dHFoNW1UOERhUFg3OElDQ0ZRQlVBd1VpTFpqN1dK?=
 =?utf-8?B?TzdmdG1xUXIvM3I5N0NHREhtNzNyY2Rpdk02b2FiM0hQSkpwNFBGbUZLRzRl?=
 =?utf-8?B?TW42ZnRGRjRqdTRhMzduaStPczRGOUQ2OXQ5SVlIbXNqZDgwM0ErMDRUWXcr?=
 =?utf-8?B?RkpOMUFocXRMRjhkM3U4Q05YeGZaa1BlaHVZWU5DZ0lYbjY0bVNqNWY4UHpJ?=
 =?utf-8?B?dEtTY29xNnFIK3ZtR1Bka3lKTjVHVG5KblBaT1JNcEJBZUNFNzhEWk9ubWpl?=
 =?utf-8?B?SFY0cDN0bkkyd3NpRFJLT0c4Y2tsL01vQU5kVHpWV0s1anBBQjN4S0lGcFlG?=
 =?utf-8?B?VWRLSTNWYWFGclEvTFVHZTY5a1FRbGFqeXZWOHozeSs3T0tlcWc0b2kwVERq?=
 =?utf-8?B?UVE2Yk1Nd3lSQnRaMmVjYjg4OWhtODBLak4weUJqaDdzanFjV0lBOUJWRm9Y?=
 =?utf-8?B?N3R4V1hqZ0xFMmJraTczTC9FTUpENkM3Lzd6VnI1OGlDU2xYRkthbG5Fd2xQ?=
 =?utf-8?B?Q09nWVBNQy90aldTR1BzeG9rckdGLzd5WWlkc0srOGdyU2ttUTdlTC91b3Vl?=
 =?utf-8?B?RG5NblV5SkwxRFFGY29WcEVDNkFMVW5RcHhjUVBVeGtaSkxDUzd6R0h5cGRq?=
 =?utf-8?B?SW5oSUh6S1loL1VZUWlKVkora3UxRmN3TDBGeGRpMUpmZnBMdFNURmR1Q3dL?=
 =?utf-8?B?Vm12VXkvNmFOZkpnS1hDd09NazFUQ2UrVSthRnFUR2VPMVhuUExUUGdBT3ZN?=
 =?utf-8?B?bExvbEVtMEZ4ZmJaTWhoVzlJNThUNkdUUnpzRlQ3WWlXTGJoanIzcnJWZGgv?=
 =?utf-8?B?YzZBUzREc3B0bFBpWFBYUzhNUkE1QXVSbTRHTEcxRG5TMm1sQjhJd1VPRngr?=
 =?utf-8?B?a0p4QS9VbjBRUE01T3d4eVBibkU5RS9lMXVydjlxNmU3UWg1VW9Bc3BFeGlJ?=
 =?utf-8?B?SFQ5ekRUdW5RQmkySThSbkpOWG1HNmVCb2tvNGJ2cnRKVDYvS1pLNFM0eHdu?=
 =?utf-8?B?cSt2VElWWjl4RVhZZ0IxOGRJd3BXUHVIZjllaXJXTnVRSUF5Rm9ZWm9wTFYr?=
 =?utf-8?B?TVpnOG1ldzYzZkxyQkdBUklRakNpUHBMaFM1VUgwSFBIVDUzZEpKcit3SkxY?=
 =?utf-8?B?WEtDcVN2cElsTnpmR3kxczYzc2F3WlVEZjl3aDcvTEhJUHNjbnMzNUVDcDlS?=
 =?utf-8?B?R2VGSUxDZXo3aDJaU3VLUXBzRGZ4K0U2OCtHT2xWZkg5cWpKRmgrQzRtSlpI?=
 =?utf-8?B?ZnlFSFM1d1pNY2lVWWNYRE45Y3d4TU5jbkJNQ1NWWVUwUUl4U2pTeEFNL3lF?=
 =?utf-8?B?S2JCTE93UmV1UVZFZ1RYSmlPck1lRFYrN0N2Vkp2bWhHb1lEZmx1aU8wZEFx?=
 =?utf-8?B?NytTTHYxWXBKbTh2VkRCeDF2c3REalQvMjhKcjJPcU9KQ01PYmVoSktEMThP?=
 =?utf-8?B?L2RzcWs4dnluVGxDdXdwNUowQ1dzOTMvd2pGaC9jOVFTajVHbGFoL3RQMTgy?=
 =?utf-8?B?bnJ6emJRSVVZcnlCNHVOWXNITDJXb3UxLzBCY0ZlMHB4MDgzME1qYXU2WDRZ?=
 =?utf-8?B?SlV6ZDRzL3Q0NlQ0UEZRak51SE56QjVVSlBWS212Ui9jV1Mzbk9UY2t2TE44?=
 =?utf-8?B?aHNHcFZBRXFUM2RkK0JSNkV4Ylp6NlFrNU5aenlBaHdTTmFLa0V1S201YkxN?=
 =?utf-8?B?bll1eU1lbDlYbk1JZ2hwWCt0a0hqVHJFaXlQZE5VZWs1am4yUG1VQXgvdDBp?=
 =?utf-8?B?NlYyY251VE5aZEJIb1Nsd2dZYVg4cG5FRDJ4Y1JLZEZENi8yUitzQUxEM0lG?=
 =?utf-8?B?SmZmVnVIaVJKZDFGelZtTm1PTmJ2ZGtLOW40VWpabElsdGxRUUtMOGo5SlE0?=
 =?utf-8?B?T1NKRGU4dzZlOGhrcU93dlAxaWxXUHUyZkRQQk9DTXVHUmExV0MvMUgrRjR1?=
 =?utf-8?B?MDAwM1RGL3RFOW1RaUxnN25Vcm1VeHJEVkJWc2MxY1Z1UnYwbEZkNXlEYnRC?=
 =?utf-8?B?QkpiSTJqNzBxQWxaeU9GT0J0WDdPWVp0Zk5xOTFOWS80WExFMXdZZXp0NEEz?=
 =?utf-8?B?ejJ4cHJkOHp2S1pBVGwralNTanVDbnB4T0xxV1FhSHA0UDNQT1ZnNkN3aEdh?=
 =?utf-8?B?Y3RtcjhtSmh5QlAxVkkzQXlVUlNsRmp3TUJ4OTFrUDFrRWVDdEg4WElKYlVG?=
 =?utf-8?B?TEY0N0IvVEFRSEJ3M3B5SDZ1UDExaU01YVVoQWZRdk92d05hSjRKQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3585fa2-2e15-455a-6f3c-08de851b68f0
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:23:10.6135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XA+5N7Tc2U/tp1kG2wabR9cSv/5p5yoyDVfKIvgfw4iwmskjHF+Jv/r5u47LhmxXCLJcqD+HEGQjVvKwb8+xrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nathanc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/18/2026 2:51 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 17 March 2026 18:38
>> To:qemu-devel@nongnu.org;qemu-arm@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Shannon Zhao<shannon.zhaosl@gmail.com>;
>> Michael S . Tsirkin<mst@redhat.com>; Igor Mammedov
>> <imammedo@redhat.com>; Ani Sinha<anisinha@redhat.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Daniel P . Berrangé<berrange@redhat.com>; Eric
>> Blake<eblake@redhat.com>; Markus Armbruster<armbru@redhat.com>;
>> Shameer Kolothum Thodi<skolothumtho@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Nathan Chen
>> <nathanc@nvidia.com>
>> Subject: [PATCH v3 7/8] hw/arm/smmuv3-accel: Change OAS property to
>> OasMode
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Change accel SMMUv3 OAS property from uint8_t to OasMode. The
>> 'auto' value is not implemented, as this commit is meant to
>> set the property to the correct type and avoid breaking JSON/QMP
>> when the auto mode is introduced. A future patch will implement
>> resolution of 'auto' value to match the host SMMUv3 OAS value.
>>
>> Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS
>> bits")
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 2 +-
>>   hw/arm/smmuv3.c         | 6 +++---
>>   include/hw/arm/smmuv3.h | 2 +-
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index c90fa9f5bb..08a4e2a1c8 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>       }
>>
>>       /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>> -    if (s->oas == SMMU_OAS_48BIT) {
>> +    if (s->oas == OAS_MODE_48) {
>>           s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
>>       }
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index e7fec7a69e..5b85247606 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1981,7 +1981,7 @@ static bool
>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>               error_setg(errp, "ats can only be enabled if accel=on");
>>               return false;
>>           }
>> -        if (s->oas != SMMU_OAS_44BIT) {
>> +        if (s->oas > OAS_MODE_44) {
>>               error_setg(errp, "OAS must be 44 bits when accel=off");
>>               return false;
>>           }
>> @@ -2014,7 +2014,7 @@ static bool
>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>           return false;
>>       }
>>
>> -    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
>> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
> Same here. We can get rid of SMMU_OAS_44BIT/_48BIT defines.

Right, I will remove the SMMU_OAS_44BIT/_48BIT and SMMU_SSID_MAX_BITS 
defines.

Thanks,
Nathan

