Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474D6D3F09C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 17:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl97C-00080r-7T; Wed, 28 Jan 2026 12:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vl97A-00080A-LV
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:14:00 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vl978-0007wE-OQ
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:14:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKI7PtZrvo1bazhh4Vt3MOyU24olNOnT8d9KDZsLkkrF3PrEQ3kzkD6saoS43nqbtDeH/sa8qh3ZRPskSVnacNrH2nUGnQRgf0F/pb17wkRWzCKLZiouzawYLew4k7oKleyezTNJRHdZ/RT/ERDK91c06kwJI4rCgwHMIyFwWjA7ph8NmJJcKsHmW+VIe/NXrHbf48C+9hvLiz8iSPHZJn2Zy1xvm5A4OZH27F8BBa2OFsti5nUPSSEzFQTBOJuchKUHuAjvEJcgZrqQW7UCW8dw2qVkfl/Mon+JAU5tWuemNdO1+QhpbIFb72u3a+ZUzpVHlwkkrIGUbD97aDVnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly2t9w6E74nhV6ODZJhxcaOE1+qH/yEj1bpu4EO9eFw=;
 b=OZcLNvam0uLDoxmx+lMHsPLBhSfYKeNRlA86JjAtt1M85J1xzX+A7cknEQOYNpDEw57AyrMpzuaPCjqunX+oB8641KcqKyDwn4LbwfhyX+PpmNkEywu+3r8gHmculCRNljnPRxDIDHU9EpDhhmmxZCI1vBmVdWvrnEiNKsmb/nnRvz0xrg4waIW0qSzdxNzAwlMDktilO3o/Vsm4OqJb3uKn3bKqw4NtJG15K57IX82kSugMH1OeXMke4qS+sS458EzHImDyr7G+BTeQFQj0LyBa5ZzKxZjD7DBw+ifNEp4INKeSUubUoF0eEMqaXqK10YsaLubUnQ7VwsK3Os64oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly2t9w6E74nhV6ODZJhxcaOE1+qH/yEj1bpu4EO9eFw=;
 b=BfefvIyd1RSiw+h7FHt+Nnvri9XPQ2w8HAUWPOCTYSJieaV37hA31FEOSE406KWcAjkIf2MSqJWq+bWQiB9B6lX4NAfLidE7r/FYw+CwuV/dwcpLduV1DSEtGwNzQcBtEDYwDCGLb7t/ec6c8WkESYAek1cDC4SXn291I34YyfiQDPO9PRzRG+GNuROZLtwSszMX6bBaR7vY5inWXWwLZHQyBBYEnAaQyknpVQDC0CScILj/ZijAWPldlJyeL/M3v392JS9FOoUrGWsgV2gctaFMcR2zO9E71Vujlodr9YIpaqiYTzLGz85leaW217CTN2iRkZCtLSq1vXY851vuRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 17:13:48 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 17:13:48 +0000
Message-ID: <591f4e36-11a8-4310-a74a-6166698d7b23@nvidia.com>
Date: Wed, 28 Jan 2026 19:13:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com> <aXoiAsGCWRv1nwW-@x1.local>
 <cb677add-ef2b-4ec6-9ba5-13aa2a50ec90@nvidia.com> <aXo3mcseNxP9bJ15@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aXo3mcseNxP9bJ15@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 18585bf4-883e-4322-e99c-08de5e9099d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmxSMmxMQTBkbVVVSkhsNFdXOTJsRlRncHhjQUd2dlpwZEZLM0hiNVJFVzNu?=
 =?utf-8?B?VDVqYy9YWVZZeWlyMzF0NDBaUHp1YitoKzRmaUNRN1RNd1M3Y3lPUERtMnNN?=
 =?utf-8?B?NmFHZ3Y0SHNmbkVxNERvYm9qR0VLQm5WSW9WTjR4QjE5N3pRRUtVeElXKzhU?=
 =?utf-8?B?Qnk5Mkx5OHRJaERuUWRTbVNnWkZKUFg1enhkZVJjclpKL2JERjR3WnBrWXZs?=
 =?utf-8?B?QUpydFl6OXRha3I5bzZ6RjgxMkgyYklQUExBNXZTUEZvQW1qWlVmb1JsSURn?=
 =?utf-8?B?Q1FncTZLekM4azlsQXdGK0hTV0lVUnc0T3dpZVFmNHdWSkYwWkFhREQ2QnVH?=
 =?utf-8?B?d0dPRnp5dEdDWkw5ZTM3Nzhtd3hXdVAwVk9uSDJUeXN5Y1JXVTZrTDZudWw4?=
 =?utf-8?B?bUo4YzBwL1R5dFcyVXdqWGRocFd2Z3k1Vi9lZjhZWG02NzZ1dVYxeVFtUlhp?=
 =?utf-8?B?eVdnaHNXZURxMlh6d0U5USt1ZkpLdTR1cWJKYTVvWm9ra1c1aHBHM2pkcGIr?=
 =?utf-8?B?NGhvdnJEOEV1TlFpZE0vRmNNMSs0YVcxVUpoNVlxUVVaWnVzeXB3eHNtWmJM?=
 =?utf-8?B?dmdId25BQ2syQlJMY1J1eDlQSXdnVlhRVWxyRGJEYjIwVG0rM1J3VVFYQith?=
 =?utf-8?B?bStUb1luME0vWU9QN1VSY2greTRsOEVRVkt2VXRONmJNRUEvME9ERTF3bmtr?=
 =?utf-8?B?enJVaXpBbVlPQk5pNzNGbUJpM1JDbDN5OExkaUVlR0ZGbWZLRXBOL29hSFNH?=
 =?utf-8?B?Q0tDdVBPS3lQNzVteVNZeUo1UXh0b2hnK1hnMXJCUDNnUzRuSTIxZE1JRmVH?=
 =?utf-8?B?VUQ2VkhLODJYUHhtbjB0cTZMSHJqNzgzMTdGQzVTM3BJZjg3Y3loWjBjUmRB?=
 =?utf-8?B?eDlOdDdrN0w1WDhaRlRNSURXQUkyaEpsNlk0QWlGQTh3NUROQzNEY3RHeGIv?=
 =?utf-8?B?c3dvVHFxVEhtLy93WmhFQWxZRkVwMnk0RTQ0c1g4Sm54TmVoczNvUzR2c1dV?=
 =?utf-8?B?Tm5ZdUV6TmVWem9mV2cwemZzZUt4Z29RTVBqbFFEOCtFaDVEbmc4bG1IT0tY?=
 =?utf-8?B?dlZHelo2eHBRcFpoWWhXZ0hsTWFUNm1XS1p6eXdaU1FCREExUlZ4aWNEb3hw?=
 =?utf-8?B?ejFwUnlKeDRhOUxlS2YrcWM3WGpVUGVPMmhRSzVuTDZMWExqaFNWQXRUQitW?=
 =?utf-8?B?cHRLU01qaGZMNXhkTytZazZqYk1pV2kzZjIyMzJickF3NHptSDg2ZSt0RTNu?=
 =?utf-8?B?enNJK2VaLzY5SWFOSTVydnVHRzllTkNvM21rNG5YTFQzOFdwUVZiWHM5L1V5?=
 =?utf-8?B?RHc3cS83ZnlSL2tWemVWblQ2ZEJtSmxtWGtyaXdNSE4yT09qL3VWbjk4dy81?=
 =?utf-8?B?QmxpeEUzMnR1cmpKMS9UK0g0bXBuejJwbnM2NlBOU2RwOXFiZGJTeU91UEZC?=
 =?utf-8?B?cU5XcnRKRHpQOXBCZ3FxODZuN2RoS2JEeTlycm1tYTNOSGF2MFkrUEs0cm01?=
 =?utf-8?B?YXl3ZWRqN200TFNZZ25aQU1TaGRsY3hVOG9mNnNnaUFoQkpVdXZSTytlNDRQ?=
 =?utf-8?B?Kzg3SmppRytSZGVzb3FyMXlaUWY4dlM2ZU1nbGdLZTd4RTBwc2o1eWdZUlVZ?=
 =?utf-8?B?NSthWWZSYkpnbGEyZTM3T0wrb2sxRWdRR3hFdmMyN3RVTjhmdHN1N2VVQkY5?=
 =?utf-8?B?T0lvR3VaU3QrcXM2SWJBZC85azQvOXpncUFRaCttQjlOcEt1UDVMSFFTdks4?=
 =?utf-8?B?WFZwODNadC9sYXpDaGlWUE5LRmJrR3lCUDdhdDNUd0RTeEYzazZIOWJCUVlQ?=
 =?utf-8?B?ZXZjK0Y2NzhmM2lsbERMSEJVTWNBYVVPdG1nRFhOam5kYWZCYksvNFljQ1lC?=
 =?utf-8?B?eFN3dXFMTTdrZGpFQU14eE1xOXZEZXI0VXJrNno1NXJHZUNTSkRUSVNIWEJl?=
 =?utf-8?B?dG5HeGExVXM4eEYrMmNON1BaaEx3WktubEJ3Q0NsZGNvQy9BK1BRN0lPTXEy?=
 =?utf-8?B?eXpScjhML01tUUFjajZUMVhCaUZZUVljMHd5aHVCUWZodUVZdmFHbmYxQzRv?=
 =?utf-8?B?K3g3aWVIZ01iRlR1bFllaG5SR1RHVGMxOE9NTVBEYXJPRG1yS2szM3phUTRz?=
 =?utf-8?Q?MQFg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm5taU5HbEp1TnhLK05kYnhaNmYwanF2SzhBclZSVVlNMXc2YjdnMktPdGJB?=
 =?utf-8?B?V29UeWlhRTFOenNtMFpyTVZnSFhXL1JQd3c4ZHlpN1o0RjZFRWNzdGlmRkpC?=
 =?utf-8?B?M1haVWV3bXI4VDBPbENLWHkyNmw5Y1RWTHdETXZYZE1jaU9MMDRFK2Uvc2c4?=
 =?utf-8?B?VHp0UEV1T2tHajVUa05zTTF5SjEwSkZSNDJmcmRkSlJuMGlqWXpvNnNvUzl0?=
 =?utf-8?B?c0hqL2tZd0xuVDRjUVErbTBZdEFqaW9sSFlyb2JEeGVzUHozRktHczJkMklr?=
 =?utf-8?B?dkNuZ0FSSVg0czJ5cExSQ1lHc0tuRlA1WCs4ZkNTU1dhcVZEUzE1L0gzd1Zq?=
 =?utf-8?B?UHB0RFl0QWJ1ZVZsQUh1SFpEdGVlODc3MVJIdGloMFVPaUMrT0Q3bi9jbXFu?=
 =?utf-8?B?alpyd2ZwaFdld1BPbndubklkOE5pMVBJSzV5c0R3eFBLMFk5emFDc3dUaEl0?=
 =?utf-8?B?VUZkWWlFNmI3MER5MlRXMUhKRFJ6dlllLzBZcTZZTFJtRXNmUUErME1MS1kz?=
 =?utf-8?B?RWFBS2xnNUY4MDNidC81M2w4MnlDK240OVFUV1FFWHpEUk93alFXL2FsTDFZ?=
 =?utf-8?B?VDV3S0VDcEFYc1d1MDFPckZXbGxxOVJMTTU4Z3BRVnNlUDBTRmx6dWpoUVNh?=
 =?utf-8?B?T291dUxGZkxvMDE5NWtJOThIMXdoVlBFcHhxZTY0czdKWUlMd3ZmSElZMVNs?=
 =?utf-8?B?OE1zTytVWnRsRDBUQ1d3R0JYYy9nV1czc0xFODU0QVc5OFROSVlOekxKU3Jm?=
 =?utf-8?B?NWY4ejBaTzNlMmM0UVloMDZJYTkrNUJuM2kraU5lZmhLR0RWcE5LTStSNjhU?=
 =?utf-8?B?M2ppUmR2c0xiOUdHZklrT1RsbHAvcGlmT1crSjJNSWtvd1B3empuZWVuRmQv?=
 =?utf-8?B?V1duMDJFNU8rTmNObXlHUnJyN2g1cTdSOEhWcnAwWkZFU2VHWE9IUWlyaXpt?=
 =?utf-8?B?Q0liSXFURXI0VzkxTE9wVCtETGhsUFNGMjg0aHp6Z2hTRDc1K25lYTVRa2Mv?=
 =?utf-8?B?LzF0NVdMNm5Ha1hBSGRKSzhuU2pkUjhPQlZTNlhuTzRBcmtkRWhBVHZia0FO?=
 =?utf-8?B?WXV5VExzQTFqNlQ1bEZ4RCtuZUlvMDJMbHpTend6QlVVTVJmSEpldjRmZmtu?=
 =?utf-8?B?S2Z4dWxBV09Gd0pMWDJZRTV4L0NOTEttQXBXY2VlNnhBV1dhb1ovQi9JU1Z6?=
 =?utf-8?B?MU9zN1VIdzRwcXBRR2s1SG9nWjYrSWM3ZTdzelVMNHJ3dndyWUlwWUJIUjlJ?=
 =?utf-8?B?WXh6elpkOW5taXVFa3hMMDczbExYUUxUSHVVZ2s3VW9zMTR1L0JsallHWmZ2?=
 =?utf-8?B?a055WUl6cGN5Wkhkam1WLzNlL3EvVEVZbmdhUEVsbjZZSi82b3ZLSjNrZTVl?=
 =?utf-8?B?ZFpTUzNXTUJZcDRldzk0a1V4MmNPMWM4dHdwbHZaQ3QyMU03UzJ0eDlLWWF2?=
 =?utf-8?B?djZRQ1Fwc1RObGZZSkttNHpnL09JTWp1TFRIb2NUWFJ6NHVHZzdpTm5ZMUhM?=
 =?utf-8?B?TU9MZWM0SWtPb2RUMWNmTFgxSzJmV1M4NkhFcjZRTWJKN0ZTa0M1NkRCcGxx?=
 =?utf-8?B?OWp6QVRhelF3Mm5oZzQ2NENpN1VZVFJXVXNoY0tmbHgrT0JRTVlDTmovbXFj?=
 =?utf-8?B?NEJad2RJSG1lTkFqckdIOVhmRitxQ0F6RWg1a0xZUFpWOGN1aTJWdnR3T1BR?=
 =?utf-8?B?SmR5K2lGamowUWV3YXNnZUc3bnJuNGhZU2N5aGFuZ1Mza0k3ZDhCSmQzREhM?=
 =?utf-8?B?ZXpDaW5RQUEzZ0k4Z3QwQm92bWVBSGg5MDhMZlFhejJsSGVyd3BnRm4yeDFJ?=
 =?utf-8?B?aVBsS3hSMDdTL2RyLzhaaWd4c1l4S2ZSOU5FUWlUT0Jxby9xRmF1KzFZUGg3?=
 =?utf-8?B?Sm1LckF0b1p2T1JmVURSeWR1cThpYkorSTdYNTYxODdURGZEVWZoUFE5NDZq?=
 =?utf-8?B?djNqRUE3a2tiS1lwR00valZGSDZJTkhIcWhvVkU0L0kwMGhPaEJTcVM0L3Qy?=
 =?utf-8?B?Mk9acnhXWUtna21VVisyQ2NsQUFkbGtnYkNzS2dKdEN1WnF6WlNwbk0vTUpU?=
 =?utf-8?B?Nk05WFA0cVpCaTYzcGxsSGFxSmJYTXZlaEkwQnVnMTVGRXovTXhsUlZiOTRq?=
 =?utf-8?B?dVZPdGhKMkxpUzVLOEtCRXkzaTQ0dU1VUE5rVjBNbnp2UlRhSTFIUFFlRzZF?=
 =?utf-8?B?TFQxYjRvZitnWlFoVXZObmdubHljcEVlQlo4WkxJVkx5bkI3VDM4emZKa3l4?=
 =?utf-8?B?emRtYk4zbjZid1pFYkFoclUzaWgwL0lDNDR2U3UrN1VpY2JuS2JackVnbmNV?=
 =?utf-8?B?RDc1K1pCYkFPYXNCR0lXL1ZGV0ZzNzV3RnViQmZtMGJ5ZmpqRnQyQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18585bf4-883e-4322-e99c-08de5e9099d6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 17:13:48.5268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xm58E5XH3pujjpRBnqY/YY5SA0LBrFkJceM3RVN2mJPMIoheaeEcl95A+hkXc6r4D2RzHqocAGXlydpzx4feQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=avihaih@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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


On 1/28/2026 6:21 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jan 28, 2026 at 05:32:26PM +0200, Avihai Horon wrote:
>> On 1/28/2026 4:49 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Jan 28, 2026 at 12:03:46PM +0100, Cédric Le Goater wrote:
>>>> +Peter, + Fabiano
>>> Thanks, looks benign to me from migration POV. I have one question though,
>>> and not sure if I'm the only one wondering..
>>>
>>>> On 1/28/26 11:51, Avihai Horon wrote:
>>>>> Currently, VFIO device migration event is sent after the device state
>>>>> transition has been completed. However, it may be useful to additionally
>>>>> send a "prepare" event before the state transition, to notify users that
>>>>> it's about to happen.
>>>>>
>>>>> For example, in some cases with heavy resource utilization, stopping the
>>>>> VFIO device may take a long time. In time-sensitive scenarios, the
>>>>> management application that consumes the event may be notified about the
>>>>> state transition too late.
>>> Could there be more elaborations on the problem?
>> Of course.
>>
>>>     For example:
>>>
>>> (1) What would the mgmt do when receiving the notification?  What would go
>>>       wrong if the state notification will be very late?
>> In our case, upon receiving an event that the VFIO device is stopped (during
>> migration switchover), the mgmt app prevents timeout of RDMA connections to
>> the migrated VFIO device.
>> This is needed because RDMA connections may have very low timeout, even a
>> few tens of ms, which is far below the migration downtime we have.
> Makes sense, thanks.
>
> Could you be explicit on the "mgmt app"?  Is it libvirt, or something else?

It's not libvirt, it's a separate service running in the background.

>
> When introducing a new API like this events, IMHO it would always be good
> to explicitly state the consumers.

Sure.
I kept it vague since I wanted the description to be generic and not 
tied to my specific use case, as this event can be consumed by any app 
that talks over QMP, be it libvirt or something else.

>
>> As I wrote in the commit message, if the VFIO device has a lot of resources
>> it may take long time (even a few hundreds of ms) to stop it and in that
>> case, by the time the event is sent (after the state transition), the RDMA
>> connection can already timeout.
>> This is an issue we actually experienced.
>>
>>> (2) Why would a prepare message help this situation?
>> Sending the event before the state transition will allow the mgmt app to act
>> on time, regardless of how long the VFIO state transition takes.
> It might also be good to state explicitly on what is the planned work to be
> done as "act on time".  Per my read until now it seems to be some mechanism
> that some "mgmt app" would do to mask the RDMA timeout mechanism to avoid
> RDMA retries and finally connection got torn down, but maybe I'm wrong.

Yes, that's exactly what it does.

>
>>> (3) Doc below says, the prepare message does not imply the event will be
>>>       guaranteed to happen.  Would it confuse the mgmt?
>> The expectation is for the mgmt app to be robust and handle these kind of
>> scenarios.
> I wonder if there can be deterministic way of solving this problem rather
> than allowing false positive reports.

I wouldn't call it false positive, as the meaning of the event is that 
the device is about to try transitioning to state X, but may not 
succeed. The consumer of this event is aware of this.

>   E.g. attaching one explicit message
> to a 100% determined state transition that requires the rdma timeout
> mechanism to be turned off.
>
> It just seems still a bit weird to need a prepare event for every state
> transition, even for e.g. RUNNING and RESUME - when talking about a
> possible masking of rdma timeouts, it should really be the existing event
> that matters for those (after device got fully recovered, should the mgmt
> app re-enable timeout mechanisms).

In our case we only use the PRE_COPY_P2P prepare event. The prepare 
events for the other states are ignored.
For re-enabling the timeout mechanism we indeed use the "regular" (not 
prepare) events.

However, this new event can be used by anyone for any purpose, so I 
didn't want to limit it only for my use case.

>
> I do not know VFIO state machine well, also not familiar with this specific
> problem.  So please treat them as pure questions. Anyway, it'll be always
> nice to attach some more information into the commit log IMHO.

Sure.
As I said earlier, I didn't want to tie this new event to my specific 
use case, but rather wanted to describe the general problem it can solve.
But if that helps, I can add some more details in the commit message in 
next version.

Thanks!

>
> Thanks,
>
>> Hope that clarifies the use case/need.
>>
>> Thanks.
>>
>>> Thanks,
>>>
>>>>> To overcome this issue, send an additional "prepare" migration event
>>>>> before the device state transition.
>>>>>
>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>> ---
>>>>>     qapi/vfio.json      | 33 +++++++++++++++++++++++++++++++++
>>>>>     hw/vfio/migration.c | 18 +++++++++++++-----
>>>>>     2 files changed, 46 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>>>>> index a1a9c5b673..de41211f1d 100644
>>>>> --- a/qapi/vfio.json
>>>>> +++ b/qapi/vfio.json
>>>>> @@ -66,3 +66,36 @@
>>>>>           'qom-path': 'str',
>>>>>           'device-state': 'QapiVfioMigrationState'
>>>>>       } }
>>>>> +
>>>>> +##
>>>>> +# @VFIO_MIGRATION_PREPARE:
>>>>> +#
>>>>> +# This event is emitted when a VFIO device migration state is about to
>>>>> +# be changed.  Note that even if this event is received for state X,
>>>>> +# the VFIO device may transition to a different state if the original
>>>>> +# state transition to X failed.
>>>>> +#
>>>>> +# @device-id: The device's id, if it has one.
>>>>> +#
>>>>> +# @qom-path: The device's QOM path.
>>>>> +#
>>>>> +# @device-state: The new device migration state that is about to be
>>>>> +#     changed.
>>>>> +#
>>>>> +# Since: 11.0
>>>>> +#
>>>>> +# .. qmp-example::
>>>>> +#
>>>>> +#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
>>>>> +#          "event": "VFIO_MIGRATION_PREPARE",
>>>>> +#          "data": {
>>>>> +#              "device-id": "vfio_dev1",
>>>>> +#              "qom-path": "/machine/peripheral/vfio_dev1",
>>>>> +#              "device-state": "stop" } }
>>>>> +##
>>>>> +{ 'event': 'VFIO_MIGRATION_PREPARE',
>>>>> +  'data': {
>>>>> +      'device-id': 'str',
>>>>> +      'qom-path': 'str',
>>>>> +      'device-state': 'QapiVfioMigrationState'
>>>>> +  } }
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index b4695030c7..9f887c148f 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -90,9 +90,11 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>>>>         }
>>>>>     }
>>>>> -static void vfio_migration_send_event(VFIODevice *vbasedev)
>>>>> +static void vfio_migration_send_event(VFIODevice *vbasedev,
>>>>> +                                      enum vfio_device_mig_state state,
>>>>> +                                      bool prep)
>>>>>     {
>>>>> -    VFIOMigration *migration = vbasedev->migration;
>>>>> +    QapiVfioMigrationState qapi_state;
>>>>>         DeviceState *dev = vbasedev->dev;
>>>>>         g_autofree char *qom_path = NULL;
>>>>>         Object *obj;
>>>>> @@ -105,9 +107,13 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
>>>>>         obj = vbasedev->ops->vfio_get_object(vbasedev);
>>>>>         g_assert(obj);
>>>>>         qom_path = object_get_canonical_path(obj);
>>>>> +    qapi_state = mig_state_to_qapi_state(state);
>>>>> -    qapi_event_send_vfio_migration(
>>>>> -        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
>>>>> +    if (prep) {
>>>>> +        qapi_event_send_vfio_migration_prepare(dev->id, qom_path, qapi_state);
>>>>> +    } else {
>>>>> +        qapi_event_send_vfio_migration(dev->id, qom_path, qapi_state);
>>>>> +    }
>>>>>     }
>>>>>     static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>>>>> @@ -119,7 +125,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>>>>>                                               mig_state_to_str(state));
>>>>>         migration->device_state = state;
>>>>> -    vfio_migration_send_event(vbasedev);
>>>>> +    vfio_migration_send_event(vbasedev, state, false);
>>>>>     }
>>>>>     int vfio_migration_set_state(VFIODevice *vbasedev,
>>>>> @@ -146,6 +152,8 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>>>>>             return 0;
>>>>>         }
>>>>> +    vfio_migration_send_event(vbasedev, new_state, true);
>>>>> +
>>>>>         feature->argsz = sizeof(buf);
>>>>>         feature->flags =
>>>>>             VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
>>> --
>>> Peter Xu
>>>
> --
> Peter Xu
>

