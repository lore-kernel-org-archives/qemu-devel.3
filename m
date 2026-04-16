Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51C6F8DFCC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUQq-0006An-0g; Thu, 16 Apr 2026 17:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wDUQf-00065l-5i; Thu, 16 Apr 2026 17:39:17 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wDUQd-0002Yq-6G; Thu, 16 Apr 2026 17:39:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j31UtGwsHt9GuFiq9LvuQy+PJVQZ3sVnHled/+UC785BgIeOkmalYZmbXttjPz0P7nIn/Dmp0PhijZUyPVm6wPi8ScXLNkPeU76wnpEB84mgisWXNMWRi16bmBakJ5ZqZUGU34Q5OKsMybzkxfzG//EGJtwenXjuTEmRweADl0M35Qr6hEXgTx11cqnYmCVC2qQCZb7Kj6KmEFg1h8M3LRNREW66y3MGncyqeD/i+3nzsJt48BI28m3o/vuEISj1k0SILMjU8bDu+Z28xLDQGvhb6erMPrrvgcuMdvy4DBh+JFol86bUXoklDcVjXY9Yk3KkioAp4kHSuPsgK48lrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i0mR9drh7QjJ6JZioeJgYSia3fUm4kw4xSYs/gOK3Y=;
 b=T4p5ETeleP3c2a8cHG3QglSi03t3HMj4h9i5McmaHSUwzOwxYGSps7Ovzek9uBMnhM/q5sjdCmOohUueVHBcKc/mPqNUja8wyaLWD7+MebzcxEGayoOGiDhd46zle1C/lQluo3ER6ZzMXGx1KjJUovNnPBD1SnCAppAgZDArhFUznHtra2tsdabXSuieNukPSVKlhOqCCpqAfsHMooe5/hFghpD9vIwDoJD5MaNhpjHTY5bDSWBzL2O/L0dy8IzI9W6eWTP4s1wY1WZrjq7wTnVZo+4Z5ggJjtP0yh2YA5eCwsyI5mrTzDuXGMHBXM9dPJaRPbXiBkTkXDLintdHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i0mR9drh7QjJ6JZioeJgYSia3fUm4kw4xSYs/gOK3Y=;
 b=r+IxlHbF2J903rh5x+7vpTGXxYSdeUyGBUAgpAEU1RMq5odRgnYRlD8DWMkQVCoD4j5mFMLXslb5M3raliPvBGqt7EPURAH0oFAu+6HeUH7ro+Y0ur13SbuQgWBv2dte/Ymat56kJGjc3f743C0YkbFs9R7PyIUH9F9tZb2wsDAjkJB7p2lbWSIaPNJbIP533iFWpEVll6kkqZEWSgVoJFYQUFfV/mJ/deimXveBNVHZ9eJFyftMe398dpCKkJ9JSdc3eWwerMoJvKBU4DzVUu373RzS5gbXIg6a0Rfk1lZIF8kMjVoPKiA4b1eAhsqb6PO865NgUh2oNQ07cbfMqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 21:39:07 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Thu, 16 Apr 2026
 21:39:07 +0000
Message-ID: <0c403b27-ea68-47dd-ac35-8f26515d779e@nvidia.com>
Date: Thu, 16 Apr 2026 14:39:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] vfio/pci: Add ats property and mask ATS cap when
 not exposed
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-5-nathanc@nvidia.com>
 <CH3PR12MB75489F2F88BAFAC2EE8EB8ADAB232@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB75489F2F88BAFAC2EE8EB8ADAB232@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:334::14) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 29465a0a-1e37-433c-06b4-08de9c00964a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z1PJD7tnbYmls4Dwt6megXX94BG2QpeQLaB+wdYtnqlPlETIo5sPiAa2DTLq+0FITWSpS5ZB9fa5FfsOJCp36ZxoPiICZQxCgAC7OY1n2Io+uxhDei/iiLG/9PAFkiJVZH/b27ZPfxYmXi5Jc3O4BEeAU+1nOWJximof/eY/uZE34/pkhUowaxY11dntAkF6GDoEWutQX/XVPkC5ehBSIIk8wQhiA4+uWr+RPZQ4ikASw3uUcjG0Q21N7YQoQ6giyh0bfNUKlwDxQPIzQiGqt/8H8RJ0YJjTiEMAUBo2JkbxXAwho5dcbanJLT7Tjv+7SImFlLHzyS3xek9LTTHfSLWHyGq+xITaQJRWBPAFUAfeQsXh5V4i8gWb8ft469lUYsXxkzajB+t2uHnj5P9X+jMswtQgX3FATb+Q1T/mf8plTnoLjms2o6hDLNsftwSPsqk97HW5r1fAAD2VdpY7opk+R+bOcIAU9ewbheNrphIihuV8RGvJ6P8Fy+ZFcC6pBs4wVG7ShC/9pMwtkfz2l1TKE68Q6JdANFSJaM/iEgz4uqOT232NZYQ1GXMTTNhhfh5Rog0pTDqclawMYyyG4UFJXFkMWqmWQ4OZD1/6IgeXVXw4CUT0dIUsSwWCz8XggM4D4sLi8a7uTeN7ql5CM3gJaXCm2QKwbaDUpK0DcMSIhsoNSnoFZGMh6CVgm8+0+fPfiW35ustb9w5/auOQTp0qFzC3Asx/Q+/Ha/WWeGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRwYkhGY082NDNlT2ZkS2lUVUl3YjRDeVRhNGdka2JyeFNtY2FwcCs1dHZt?=
 =?utf-8?B?dEwvUk4wR3daMkxkMlBoWWdYU0FQOVdlOHV0NW03Mis5L0UwU3VHMnlZYXJE?=
 =?utf-8?B?MlZ2NENlLzhuNmhzN0tLbVBjL0QwWktTYS9KMmRWWmhXL1RrME1keVc5OUR1?=
 =?utf-8?B?bmVEbWsxZG9jbmtFenpTOEp5Yk1la2xWNEozQkN2YkV4U29JdXloK0VYMkI3?=
 =?utf-8?B?S3NnR2NSSGVjWERIbXlvdTFZd0I4VktJRHk3VWtiYVpaUlZsS3hndzBhemRW?=
 =?utf-8?B?eDd4cEtqMGxTT2kvZXVtRTNJNWdpTjdIdFVDa0RDSis5WVFPMkUvQzVnSE9E?=
 =?utf-8?B?ZHVXR2d2Z0p4cGVzUGVzc3NETENtdG5iZ3lZazlVbUtXekVISHNSZ1BsclVi?=
 =?utf-8?B?TVQ3RWhUUVlXOU0xenI2Vmc4Qnl3NmVCZmJ0TEJhRFR2NzByd1BQWlVKTmVE?=
 =?utf-8?B?RXpicUk1WnlaUkQ0UnQ5QUpVNTB4ZnlsRk9EazlGdldVb1YvTGMzNXM4Rm96?=
 =?utf-8?B?OEdSMDZvcEdPdVV3YXQvZ3c3VlZPSkxMVkxFeW9qMlNmRENuQVcrQ3hpaDhn?=
 =?utf-8?B?Y0Z0Q2ZWS1ptVFVyZWo4M3lYVDhjUWJrTHVvZ1ZsNW5lOVNoUHd5eXVudzEr?=
 =?utf-8?B?VXoxcS94cDEzMEpEUmRVcFNoRzlwZFYxVUlXLzFwK0NQMFIvMFkwZUx3OU85?=
 =?utf-8?B?S3dtUXFJT0RrYUY3a2MzdkVoNno1ZmpiQ3EwQ2RZVGx6VDcxQ1NnOWlOOGhY?=
 =?utf-8?B?dWxxZlB1OVM0dVdtODZkYi9tSnphUTJQYmF2YXp5YTZuVE1JUXJPOVBVaVBI?=
 =?utf-8?B?YytkSGYrR2psMU5PS1VxTTlBVEk4LzRNZXpFMXJwbkVic0M3YW9tS21mUkdY?=
 =?utf-8?B?SFZYWk1uQ1JUYUlBdXFTNiswRjl3K3Z3QVRxT3FnbXM2NUVqM3dqNW95OXRL?=
 =?utf-8?B?UmN5MHFVemJTK0V5SldlQ3JIN1BFZnF3Q0o5cWsyZHA5UWdvVjdQSWkrRUxn?=
 =?utf-8?B?T245bHk0aG13aTlqTHlyZFI4VkxLWHJ3MFZhS3FtaDFGMnQrZ2VSSmRVbjVw?=
 =?utf-8?B?eXM5Y3ZYa0ROOW42V2lNbm5CY1lmWmUxbzNwVkxwdkdQRHZaNng0blh2KzBM?=
 =?utf-8?B?a09OMnlPQ1BkK1ZmN2g2NmFpbVlGNlJZSW9YbVU0N0RQb3E4cGpBUmNEMlVE?=
 =?utf-8?B?dFJGUmhNN2dQd0NFbytzZENzMDUyN0lmNFI4TnZaeGFmY1NZQWtqVWprMzdh?=
 =?utf-8?B?RHRuVURSUWpjRjhrMHlCbXRyeDdnSDVjQ0s4blJuQkZudXh3WHAzY0p0dnBu?=
 =?utf-8?B?bGVrV0pwTDY5aVVBOVkyelBSV3oyajB2Zm16WnNuNitHZG9LUHIreFdEWCtq?=
 =?utf-8?B?b09TUnpNT014dU1nVWJVRDVFaFFYZ1htb3U2K3lHK0FyQW81U0swdGZuOEFT?=
 =?utf-8?B?ZmZFMWZwSEp3TGEyaGlsUDdoc3NxTnBZdlVuMkFSUnd0bE5IZjM2RDFpQyt4?=
 =?utf-8?B?SENhZGNCT3JoTGlTZDlQb0VUUEJ6Z09HU0lvYWJtV2UrbzdwZ1BNL2kwVVJL?=
 =?utf-8?B?TTEvUFR3YXZxYWhVN2dGOTgwUU9paDZKaXAzT1cvVXZRVWVhRmFKd0FoK2dC?=
 =?utf-8?B?aEpRTXU5ODRqWVhkUnpFTHYxVHRqNVpSR1dxOTJjVFliTTFzLzBPeHZhVEh5?=
 =?utf-8?B?U2t0czdVSUhyZTR0T255cUwxR0lCZWdOaG9OUUpSb2tyY1A5RHU5Nk5DU1Q2?=
 =?utf-8?B?WHV1SEFXcWtrZVloSzFSU1ZlUnhvdHUwR1l3bm9tREg5WGxIQ3JYMGYveGhl?=
 =?utf-8?B?VGhHelQ1bFNFNXN1NUF2akhPQWhBNEJodTRSZ0hMNVBNdm8vSDlOdDlvT25q?=
 =?utf-8?B?Q0JFei9pdVpsUm1jbGJycVgxaVhCaVNvZE5uNWVYSS9VejduTzZobG15cXZX?=
 =?utf-8?B?NGJrcTdxS0JZWE9MRi9qbnZHMElUVm45TkNHYVdYalZRMDE5djZzaWdPV3By?=
 =?utf-8?B?UnNBU2YyWVkvS25XTDR4dVZuSk1YYzh6OFJPc0ZxQnJzNmRhWGRNSzN6eUw5?=
 =?utf-8?B?bFlyRUM5VWtod0MwZmNuNExUS1lMakI4TE42T3lJOHV1UmJYbldzb0JGengz?=
 =?utf-8?B?WXZ4Zkl0RE9Hd291dk5TR0FDQ0xIMkZzRGNwSm5Rclh2RitXTm1hTzBibm80?=
 =?utf-8?B?QndnTUVOTW1DWDhxNmN3NnhNRzhIemRCVkk5Uk1jc3ZuYXl3TWN4eXFDZzNC?=
 =?utf-8?B?UGF0NnRoRmUvMjZOblhSUWF2UzNxRHJYalpPc0JTR3llNHBxUHFDbzdINnV0?=
 =?utf-8?B?NWpiWldvN1gwYlkvYU5oUTlHZFZEcERiOWRQZlBIUy9mSll0U0RQZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29465a0a-1e37-433c-06b4-08de9c00964a
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 21:39:06.9863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMnZLZzCRTvQYyDr9hHtvZFDi4wT6Yms5V8Sd5viNSx5LaGf5tJYCV0XmxaJ2SWNi12JGsSMP7Rl13I1wrbHFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nathanc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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



On 4/16/2026 6:43 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 01 April 2026 02:02
>> To:qemu-arm@nongnu.org;qemu-devel@nongnu.org
>> Cc: Yi Liu<yi.l.liu@intel.com>; Eric Auger<eric.auger@redhat.com>;
>> Zhenzhong Duan<zhenzhong.duan@intel.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Marcel Apfelbaum
>> <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
>> <philmd@linaro.org>; Yanan Wang<wangyanan55@huawei.com>; Zhao Liu
>> <zhao1.liu@intel.com>; Alex Williamson<alex@shazbot.org>; Cédric Le Goater
>> <clg@redhat.com>; Shameer Kolothum Thodi<skolothumtho@nvidia.com>;
>> Matt Ochs<mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>;
>> Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH 04/11] vfio/pci: Add ats property and mask ATS cap when
>> not exposed
>>
> [...]
>   
>> +/*
>> + * Determine whether ATS capability should be advertised for @vdev, based
>> on
>> + * whether it was enabled on the command line and whether it is supported
>> + * according to the kernel's IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>> bit.
>> + *
>> + * Store whether ATS capability should be advertised in @ats_need.
>> + *
>> + * Return false if kernel enables
>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>> + * and ATS is effectively unsupported.
>> + */
> Returns false only when ats=on is explicitly requested but the kernel reports
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. Returns true in all other cases.
> 
> Isn't it?
Yes, I will fix the comment to say it returns false only when ats=on is 
requested but kernel reports it's not supported. If kernel reports 
IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED but ats=off or ats=auto, then we 
still return true but set ats_need to false.

Thanks,
Nathan

