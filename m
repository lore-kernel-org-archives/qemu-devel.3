Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BFAFED9E8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2X8U-0004B3-1v; Tue, 17 Mar 2026 12:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X8S-0004Am-Oh; Tue, 17 Mar 2026 12:19:12 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X8R-0004CN-8T; Tue, 17 Mar 2026 12:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyG45XL3wGwL0TyHVe39eOh9uYcrQU0LRDh0PknAUub3IlmfG4XXG6moZe4X6dWQIxTmUf7ZxNC64gb7KgaEbjFFY7vOZ+8WMrkcPEwFBQgCE47PzPn9sMTXXgVMH5C/59ZIffX1c56mS6miNNXKawZTx23AyVgv5C5kI/pJn/fDLwPpH/bM9UMBmxSRfF64cj5Tp6Da4j63v/Uig1h4uZH/oY2R3htj0dBuUUwGe/Z6zjsDMNwhP78bFODyl9pDZMA5A71B7U28i0dnZyMNXYCDA3da9MWd5JV+vkzOobWARcKFb90G356g2Np90HWinQTEipUKco0kls9ZA1Naow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhnXVDUuTB0OEOpcOGt6FIZvlX6kuUa2viP5zxxXMwg=;
 b=mXpjoQ+RXSPa0cKcPswIIiVTT/qTR1U6f9z+v1v9Dalo7vjq+gQWjr4jpMTinaupcVnFU63tW2UK2cRgCTVNPDsXg7eiFXi4ZGtnFItXLdoUi6JzmUv4cRq6tFMNHwFe6oTFaRcd8m1I/+MiF+MgGmp5SghBjWeKNRxibeJ5MiMgkSlLH1QhB2CH6zj5nEYyGjM6ihe5vi6gxOoo/oSOJ4TS81MeAsPQnaUQ6UznIwMHFzVmjJRvlIT4wDyw6NK6rnnZmOY2hrsAngBB6BgVL54ynbvXXMwKLYLbjQGosfmEyvvtAbIVPXfp3RAiES+VeRP2026fb+z1kqfn7tnyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhnXVDUuTB0OEOpcOGt6FIZvlX6kuUa2viP5zxxXMwg=;
 b=uLi/JkOSamPHKBBSlRoHUkE7QE0359ISLkx9X5UK+Vo1zG9crqa9Iakz5wP2Jb9Th3wuDRM3LTkHKtvQ3etRv/37D8GKaRnNFW6ymSqCBN+UkFhOCOU7qrLU9oztOPWobK8os7m2eALdkoVzBZP6FstvTtRS3hbnWhl0nZskPDZyoGkm1wxTomTcTKxKFOfPb+Iz7sqjEuVafxBLFeCl+uE0Ij1U6GI6Rz9tu6GnqyUl8HVe55sRLS6ErSk1jdhRDEYMYtmfJ4lyv3VghMrL/OCa1br6OxPH5FnYYoNZzI26s7ABPeiyp4MIyqhLnb+2FGJJjsz1ajndhmbuSbtjHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:19:01 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:19:01 +0000
Message-ID: <40b0724c-bd15-4050-9476-9538eafadd8e@nvidia.com>
Date: Tue, 17 Mar 2026 09:18:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/arm/smmuv3-accel: Change RIL property to
 OnOffAuto
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-4-nathanc@nvidia.com>
 <CH3PR12MB75481996C9F7D1580E169A80AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB75481996C9F7D1580E169A80AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 69eabb60-6843-4a2c-26f0-08de8440e632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: S1KzHREeCUtG88Rorl1EpYZNjkvWdtQnLLJu4JBhDKDUL8CTBS3BVXK83g6sw1beiqDH6BevY9he/I0TYnI4N/IczwNuzDjjXrN9pfDUIkTg7XxKFyZDeISGtMdUX03OyYKxIggzRRdGlIrcUy3nQyNn6CA8h7AvhFhY0GVOB224vbQ1dljYGpVxgjDqcXiQBwWoR+dScuvvmOjS17wgC4+K7rA7F+3w1EnT5hdSMrP6poMBTeJYSiaxzzm8evRUPgfAIpBdrGJ+sRfZRySv90Yd3pf8w1O9IusJuPjpMybxMfNpYHuIW6Uj/UXL5H0xRToLtKTor5z5ugaUA/MS6TfB5O2aN6tzlwUGv3Ppb8NlC5YphgRlGl2wwkWZo9uDZDyogOH+jDN4A3rkK+dobqdJ7di6sWq5DdtYlZrNzsmuoziJj0WcD+RyZvEuCL2IWECaXd0Wmg6v7xcfbz2c6ngP5M86BW75o58ILpgxN9nbB3FHHOk8D4Eamas/7jaOvWslSlTVtd3zjeYgYAXGUYf1xqs+7s7PwEcdc3aBmvkxdFxmHJjggKuSieH/jEVBQ/bNqNO1mhGPduh0hSeH4S32CraDwIpijQoff4HMzQ8nka7+dvA6jY7bk7UiWs3Vhb/SBMg4jv1XrD3sdLpSB6SWF9x+B1fRz7IRC29RML6IiQXvhyNcOhVw1fkz2bVLO/GB4QNY+Wbz+azr04n9zhBXkz0fjYFCIQvwDt2pZEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZZRVZZaGdGK251TjU1dGUwOWl1aURGazNwYXFhbVYvaWRNQkozWmtlc0pj?=
 =?utf-8?B?MXk5amhVa3pvSVJzcW9waUk2dUFRT3lFY3JlWVZQa2RsZ2pZbUxtakw4R0xr?=
 =?utf-8?B?eHF1L0ovR2FhMU5ZZTJ2eEl3QkVJREVGWjRKV25vSmh4ejJHa3pFTHRtTW5l?=
 =?utf-8?B?UlQvQjZoS1BXNnNjb2lPTHJ5Qkh1ZFQySmFJMUpQQVlaZnlCZ2NodGVxMGlW?=
 =?utf-8?B?c2FFUWIwMXBTaUlJV1ZPbmE2UjdSbXk5a3ZncWJ3YWtjMEgydmllejBRdkhy?=
 =?utf-8?B?a0pjUytDbng5YW5EcWNYUVJjNUNvSk53K2ZvZ3lkazRpTWhvOXJjQnZiaUxy?=
 =?utf-8?B?RElFWTdXeHJTTWZIc0I5TzlKOHpKaUZXdTlnMHdkK2hJUTFrVXdDT0JqRkxP?=
 =?utf-8?B?cW1MVjJPYWF1V2U3WWRwMVdEdkQ1SW5FU2NBRit6YURlQStRNWkrMld1VElF?=
 =?utf-8?B?Y0RlVWRSYjJoZ1F0bUZkbEgwS0lYWWRMcVV0L3l4cXJndUh1cXAyWkNkQ0Ri?=
 =?utf-8?B?SFhUR2hZZFVhNkU3SGRxTHEzdFJacTNMSEVFUFBoRHd5SERaSWszTDIrbmVh?=
 =?utf-8?B?bmM3MVJ0VUZnNTFJWUlNaVV4LzZWb0M4MEErWi9VaWZCYlFFZkFodGMxMnpP?=
 =?utf-8?B?L3F5bWtja09ZbGJubndQVWNrdy9CRVRCRTZJMExUZXVJMGF1dC9ZN3dtcGtn?=
 =?utf-8?B?NmFjY1BEa3gxeUpXSUV4amZDdnR3elJodHVRVnpZdDczc1BXeFA0by8weUFE?=
 =?utf-8?B?dVdNaE56YkxYakhCTDRUNjN5L05aL1VFNFVYYTIySW9SazdtZkpkMkFHZW1y?=
 =?utf-8?B?Y0hyc09hakcwUkpVRDdLUGphanBZc3dvTTFGQk1ubDBRcU1FQVdDUzNlcjJ5?=
 =?utf-8?B?Y29pQnFZZHVWRmVTYW5OeUg2em52OTZ6SHg3T0FGWThOc0N5ckxVTm1DWDk3?=
 =?utf-8?B?bTFWNTNsZWlOVTkwQzNhRk1SZmV3MGlQNlFHcXJTc0d3L2dxd0RDSmlvUVZ0?=
 =?utf-8?B?QVZvdzc3TnlEWTFHNE5HM05tNlQ5VVZVa25ZRnZmQmdRdWVTU0VJd1RRQlpx?=
 =?utf-8?B?eXdLajJJMTN4TVhSN3lYMnZlWDV4VGFkaE85aEwvVHFsWjhZeXYxb0hzVlFt?=
 =?utf-8?B?a29xNlR1dm03WWdJTmdSVGtuMWZhMER4Y2NTd0hXSVBXWTZ2cHBHMjJOQTNE?=
 =?utf-8?B?cHNYN3hPcGg4RUZaTFYrTVhta2YvenNsNlhrTnFXRURvV3ZaZi9ueE0xdnlM?=
 =?utf-8?B?MFhxbmdIeHVyQWZqL3JFUUZCWStUYmJneUYxdDcwNGFRRTR4L0greUhGSDBq?=
 =?utf-8?B?OGtDRzFLejhnTlpSU2VjUHZCMGV1QXBiajNZamlVMkZXalN0cEVHRFhaMUI0?=
 =?utf-8?B?NnJJbG00anE5clFDeHBaWTlTT3puNkwyQytDSTk1WFhwWld0dkVLYktiSGxC?=
 =?utf-8?B?aTdZY1YzaWRLbmIzV3VxYXVZcm83dldQTUw3Z2ZEeXNkRk0vZnlLWkJyNW4z?=
 =?utf-8?B?NWpPQmxsWVI5b2E5Q0E4U0RQdkxvVDZGYkhzYzRzRitoVHJ1SUFwVCsvcjdy?=
 =?utf-8?B?R2t5aVRQeWRhSFBYd3FFSTl2alErWmkzMk9BRTIrT2hwU3YvWVVsa0VTTGJu?=
 =?utf-8?B?UGdtYm45eElVMVB3dURLM1luSW0rK2d4QVI4Y0hSOGlEdGp2VzF6Nm1qM3Bj?=
 =?utf-8?B?TWJMbTBTbEhFenU4akZsSlNMeEdoajhUdjNJZk42YzB3WDhsZU8zVHFQRHIv?=
 =?utf-8?B?V3FQSUF0RkJlZ2pIbWUzc3pOaUNPN2hkV05yRmR4MU96RUVaQjUxU1R3SGpQ?=
 =?utf-8?B?QmtzUmVJSWFGNE9kcUFZWTBCcnFpanZzWU1WTnU5eGNMZ1VDaEdRdzVzRmNB?=
 =?utf-8?B?b2NTSU1kd1VRdjFtdjNiTEJLWVk1TmlEM0lGZkhJM0hQYnEzV0x5dE9HVEN5?=
 =?utf-8?B?RHpmZC9pTTM1VTJjS2NDbklZUmNXNE40ZzdzQ2RzeVJxR2tLWm1HblIzUElj?=
 =?utf-8?B?YzY3Um53VDF6MkpXQlFWck9Xa1k0V3g0bFBMbFRpNGsvOG9OWUVQem16eUVj?=
 =?utf-8?B?S2I1eVZ2eE5vSUlHVElmMkZ6elA1bmVYc1dqYmRtWTVLT3gxU3RraHRZTkNF?=
 =?utf-8?B?Y25vN0hWc2hzZ01UZlVXY0VSY0IzRkY4Szd0SHlPUjBkenJkdlY3NUFCNWxF?=
 =?utf-8?B?TWxPMXdJUU1KS3k2eG10cWw4eGh4OXNlVFppRlBlS2NUOUladjcva3hHWXIr?=
 =?utf-8?B?WUJxOHhkTTEzdXlWa2hjRGFMb1dOQjBBNW5hK2FkNzJvVDJIZm5sV2l2L1FX?=
 =?utf-8?B?K2NwSy92YUtOK0I3blpYeDY0Ump3M2xlNzVJWFlOT1B4K3lNdlo1UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eabb60-6843-4a2c-26f0-08de8440e632
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:19:01.0399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOjs+dOfPBULHecaxAA2dIklg+ijGFmn0FYHAm2z+cjnjDqfPNgB+uKIKPGI3Q8JRRvEvJbk2VNO3teK7p2Hbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 3/16/2026 1:50 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 12 March 2026 21:03
>> To:qemu-devel@nongnu.org;qemu-arm@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Michael S . Tsirkin<mst@redhat.com>; Igor
>> Mammedov<imammedo@redhat.com>; Ani Sinha<anisinha@redhat.com>;
>> Shannon Zhao<shannon.zhaosl@gmail.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Daniel P . Berrangé<berrange@redhat.com>;
>> Eduardo Habkost<eduardo@habkost.net>; Eric Blake<eblake@redhat.com>;
>> Markus Armbruster<armbru@redhat.com>; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Matt
>> Ochs<mochs@nvidia.com>; Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH v2 3/8] hw/arm/smmuv3-accel: Change RIL property to
>> OnOffAuto
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Change accel SMMUv3 RIL property from bool to OnOffAuto. Setting 'auto'
>> will use the default set in smmuv3_init_id_regs(), i.e. 1 in IDR3 which
>> translates to 'on'. A future patch will implement resolution of 'auto'
>> value to match the host SMMUv3 RIL support.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 8 ++++++--
>>   hw/arm/smmuv3.c         | 4 ++--
>>   include/hw/arm/smmuv3.h | 2 +-
>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 5d14abe307..6f44fd3469 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -824,8 +824,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>           return;
>>       }
>>
>> -    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>> -    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>> +    /* Only override RIL if user explicitly set ON or OFF */
>> +    if (s->ril == ON_OFF_AUTO_ON) {
>> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>> +    } else if (s->ril == ON_OFF_AUTO_OFF) {
>> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
>> +    }
> Same here. We only need override if RIL is explicitly OFF.

Ok, I will remove the condition for setting it to ON.

Thanks,
Nathan

