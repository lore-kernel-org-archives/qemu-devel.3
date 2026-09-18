Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04D7C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7dJc-00058A-AE; Fri, 18 Sep 2026 14:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x7dJX-00057l-Tv
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 14:28:00 -0400
Received: from mail-centralusazon11011011.outbound.protection.outlook.com
 ([52.101.62.11] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x7dJW-0003xN-Cx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 14:27:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws6nS+tcJjLm9J+rew/Ze3902kSbi3KlFu4cr4jTQjzkzBHB/2EdbRFPK6SjxeMmPH3/PTeWRgLHfLIKgyztvloTfzStShYl9RLY4Lztlbhdk60FWDCq1QJt1ur9Fvpu4W4wTIO48xSYRKyhFSoeFSrD/fvGalZAUDL2dg7c3rbQwHLnmNfFK9sOw+GIe03cP5AlvNGwoZtOozp+k/0zvsu/Obvy5rSYNDDjBtvsv3dI2PnUh47iRUTcqPUVJ45NOzXFFJaZGIqCFns4YybF6MjGzknNDLQy2ii66jo2tN7hBocV7l26yfP1b7afbp3N2lr9GvmFQ9KoFNo3Olgo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzaS+KXdeufyu2IV0dSyqtTvp68KHT1tPeCxoNggPg0=;
 b=TlpUf5nuJvNS9LcfqHYho44kMuhR3ef8CunA6hQTzETs9PwDPHufYpoG3LZRlPI26cylDA7nhu04/h6kDiMk1aH5YYNdgTE+58meLM9/HpRIi/2HkzcPPzgAIiOfae9ryPQVvvAXQTlRmppbRfxNad6mhEik9MsMXGmfXPT5DIZNWx0tRFViPaDWftxpUWv6AxLon3AqgjtPsFI8X3m39yWgUVPDqBmI5sznFXWLs09LiO7wEXG8uiMWadOq3ITG/UsKra5g06pbzt50iHbSdnOlyBFFhlr/a3gU1L8Z/jKQPJsaAK38E3NFERCgj0S29rIg8claWjthpIB79lKViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzaS+KXdeufyu2IV0dSyqtTvp68KHT1tPeCxoNggPg0=;
 b=sqNM0wsCsFUxpQHrisFJ55bIopcKeRDzWMEE6gMGpp+nt9hmycuOD7pOMv49buUh9bVMiV9FSBcvCG6yJhDLWOzTtTr7E2vywn3ZufiTSUL/iz1kqqk/jDEMgBfHCLRUqHqmFWS0PTPRfNQMUWUfT0Spy53yosJZm+E8VFeAcXcnesnnKNth1g0ZRTEpVHd6EJevDg/yDsmPv8tla5pr5n/tspXJCogCifDBSvKle4Ks+qJM8DWKFRtmB/uzdd2dYdaXrx1aDNvPzvNcXXOjvE+LOAIaPnIdj/d7N8c92745+YlsNzR53dSAirJ+Tjc9kycwzl18pg+fVmb5DDu3Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by MN2PR12MB4486.namprd12.prod.outlook.com
 (2603:10b6:208:263::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 18:22:51 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 18:22:51 +0000
Message-ID: <7c826624-113a-40b9-841b-1bd8c375a9bc@nvidia.com>
Date: Fri, 18 Sep 2026 13:22:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] MdeModulePkg, ArmVirtPkg, OvmfPkg: fixed PCI BAR
 placement
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: devel@edk2.groups.io, gaoliming@byosoft.com.cn,
 ardb+tianocore@kernel.org, sami.mujawar@arm.com, jiewen.yao@intel.com,
 qemu-devel@nongnu.org, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
References: <20260916192408.928411-1-tdave@nvidia.com>
 <aq06JQWs6KszJI9w@nucbdw.ghoffman.csb.home.kraxel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <aq06JQWs6KszJI9w@nucbdw.ghoffman.csb.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: b188e56f-3c1e-47dd-5892-08df15b1d952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|4143699003|6133799003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oQV+g50yygKiSI4ahmaLQnd5FSC0CVYwmZxKGxjXRChscywyZaZkNBPZBC5yJyISltc3P5vOYDjrZL4b0l822lBQ5j6kBF9SlAnM7CTSUEuyUaRsXwjQ2ibQVargxXOWoMpFa69nA9goxBgaIuPyLricPf2AMgek0cNpKqjHYd1SoCaA3jSNlaDIRW0pDluv3i1FqHvJgpTdnOrXwGPRoqfiPj1xttRp+zs0UR2chRyp/NVz+c6Dmui/vIHWjKHFCMi2EsxLM0RzmQc7JruCVT0SuLv5nWXN9HeHxR2Y/31ujtgLsYbaADFHrRRQZv208cCexMObjMG8gPJ/D9KLm5BHVfzWEec4h+lSRejcnH1Nl7tgvkhan9bDecwz2V9CwMZVZ3Qjasw5is3cVRAqRoC9XYbC3UPCQCoM/5797nXdIzdNucn4+9W3DjhoGdJb3S+D7eX81OQlK+7lkxYlBtXLhOLR0wRqw6cirhbsP+At5rADzP75M9TmKA8Dzff3RO96omV227hBe/rjNI6vung5Dizng/j7cuzy1NCqL/Tu1vEu04lck4XSf3XK1/8OWtBUk8eFem0Wc5yD60cmuRAZMP7/xcODbJG17esG0R914Lc3Yy4mrypBvlfiL2mGACYUkReBpLYjXrsRLf6nqNnjnZR45GTOEK3HOTFL8OM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU9OWWJCd3AyMXN6SXFteWJqSmdsNnRuRzlacXNNcXRPY1M0QzBsYjdpTW5N?=
 =?utf-8?B?SHNrL1VZbVN4bDR3VC9hVDRkd3IzZEhCdktMR2J1WjRncWFZQWJDT2cyRmFL?=
 =?utf-8?B?ZnowTXpJMENDQXZWYk9jU3FVbU1EZjV3M2t6UmV4TzYzWGQ1eGUrQ2hYY1Bi?=
 =?utf-8?B?VmgzTkNqRVFDZmR2OEJ1SEdwTFhJUFp4SE9OOVd2VFgxZ2pHSy9vVVBiR1lu?=
 =?utf-8?B?NkYwWklOVW5kblZJL2NFbXlOU3JYUnRQOXFnMUc5SHJGeHVNdllxTkVVR3NR?=
 =?utf-8?B?VlVpTXFRWkFKZEdYT0RweVljdlY3OW44Qk5IbnBocGlabTZjSVhiVWxsVDYw?=
 =?utf-8?B?U1U2OVg4ZElmWjB4SWlYTE8vVWkxUDVRSnkxUGMwZENZd2J6cXE0N2sxdFFh?=
 =?utf-8?B?MWQvSU5xQnVJVWR3Z0d6WWoyT0hUOXowWjgzQmpFdm1ZVmpBbStQZy9tNU1j?=
 =?utf-8?B?dkNIVnlzdW9SRWhOMC9JdHBVdlI1QWMrVDllSlFUZzdaV0lXbjROUTFGQWhs?=
 =?utf-8?B?akJDZEs4Q2VkV2NBa1E2NVJWWjMrbUtCSUtyejNRdC9nL3phUnNnSGphcGRZ?=
 =?utf-8?B?RytyMGNGMTJ0UVRkd09lM0RuVDI1QlgzVHVsMnY1UkdFdUF4dnJUWjY5SzZ5?=
 =?utf-8?B?b2JpWkxCQThHVFhFWE11SXZhR0lsRlZnUENQVFlwNnBVOFFDWFA1MU5nUTJv?=
 =?utf-8?B?Sm1rdEhycHhkRVpMb3FoaFZNZStzd3JtTnRXZEFFM2daK2xCcDNiVkxqb3hl?=
 =?utf-8?B?eHRaWmttdWpCcUc3ck9BZVpFVkFsVGNYR2lwRmNiZzRxdDBHTXFLQVllbTlh?=
 =?utf-8?B?OGlRcnh3VlJHMVJja2hNMERVanc4WWhlNkluN2pLbWtGZ0xQa1JtZnZ4Rzht?=
 =?utf-8?B?V1VpNU5IMS8rL1llaEFTK25jeHVaRGtrdEx0c1FLUlNsakx4Uk0ycFZKNjhr?=
 =?utf-8?B?eENWbVpCWkt1VUNQZDJLL2dpelZiS2NPRktxK0RWWjZnZFc1eVFmRlpKTFlK?=
 =?utf-8?B?US80V2FYLzVrK25tcHJwdEFlVjZRRUtacFozYTVzckRqc0I0dTVWUEFzYlEr?=
 =?utf-8?B?ZXkyS0NwTzNvc2puV3R6UG9vZVRtajN4L3E3ampCWktQeVAwQ2FjWDZ1MkhH?=
 =?utf-8?B?STh5R0N0aCsrTDZoY0x0cXI4VFZWK2hrbURmZW1uYzA1Yzd1MHhGUzI4MkVt?=
 =?utf-8?B?anNDMzVoRFpyYnB0a2JPUVkzTHBDRlZNMFcwTWpEaXpaOWRNNjZBKzhhRTRY?=
 =?utf-8?B?MmgvUU1XR1pYS1hiQy85SEpnNFlkUHRGd3RxZ2ZpRmZSeG9kdlRSN1ErVElw?=
 =?utf-8?B?SzJyc1hwWktucGJGVkZYdnAveTM5bmlzZldsb1V5dkh6UDFZR25qSVlEV0Jo?=
 =?utf-8?B?Q2V6WXpyaWVDWnU0cjZaUytBbzZCM1gzUS9tUTdhTk5ySzBRUFBhcHMvYnIx?=
 =?utf-8?B?eis4bFRiZytMZElPSCtZQXh0NzRXNnBMSUh0Z1ZaeGZNZEl5ZW9ubUZwNmlQ?=
 =?utf-8?B?QmRTSVRJVHVDOTRaUTRyM1RsaHdJS2tHcysrZHYzcEdBbjJMdWhVZGIzRGcz?=
 =?utf-8?B?Y051WTd3TFlqYUZrWFFGNUVVY1BVSytpZ0UvalJHZStIMGx6VjFnNHR4RkZs?=
 =?utf-8?B?NnlvOU5TRUVJM0czVXZtUk11NEtwcXAvNFdhclJ3OWpHNFBIbmZEamlzbWNR?=
 =?utf-8?B?dnJkVlhObzNtMEJhK0VkNmhYVVFoajl2Yk5jWHRmb1lXTVBWM1Zsbzc4Z3hK?=
 =?utf-8?B?RnQxNVhpK0lnakxldTNuMkdmYlJ0WVdtMlhZTUhuNm94c216TXdKTzZ4SXJK?=
 =?utf-8?B?cWJ2WU1oTkp4K0MvNHJQR3Zzb3kwMkI3ZEN3N1daTDc1NGZLKzQ2TjhYTFU5?=
 =?utf-8?B?aXBmZTQ1ZEMvUWErU0JYNmZOUHlZNHRBUTdGbjdTMEppamdLNVpVN0tjZ1VJ?=
 =?utf-8?B?Q2w3V0JMa2JhNlQ1NloyTGNuMnlqNDljV3k5ekR2WmVGaER1TlZhYVJ5d0Vr?=
 =?utf-8?B?ZEdGV0tiMGhWZGhqeWNMVHZMOG5xQm9uOEZuU3N1SlA2elljbzl0QWtDQ2lk?=
 =?utf-8?B?bnNSditJWjIzWnBzZ2tvK3JMUHZENUY4OTNiZHlFaDhqMWo3UjA3c1R1dE1C?=
 =?utf-8?B?amd1dUExbmxZUkp0UTZTdThJaEd4NWgyVHN0aHpPUjV0UFdwY3FybDB1ZllJ?=
 =?utf-8?B?TmNIUnNkS25rZEljejd0R1lMS0FhcDRWaDBwekIwYnU3QlRiT29aV216ekJj?=
 =?utf-8?B?MGNNcFlpRXJpYzBDMHd5YmFjUnR3bm5naGVOWUdzNjVvemJaUmZUcGZqSjJt?=
 =?utf-8?Q?b+i3oKoZAqZ5edzBjC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b188e56f-3c1e-47dd-5892-08df15b1d952
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 18:22:51.0828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC0suP0IjhasjMhhnpdsNnr8zAOLVcaMDf5lp93iW70DpfbmpeYCepUr0Vep+FkUCYOgDQAt6EUpElmHMMiF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
Received-SPF: permerror client-ip=52.101.62.11; envelope-from=tdave@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 9/18/2026 8:24 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>> The series was tested together with the QEMU companion patches on the
>> AArch64 virt machine across a range of PCIe topologies: emulated devices,
>> VFIO passthrough devices, PCIe switches, single and multiple fixed-BAR
>> endpoints under a shared root port, and fixed BARs behind nested bridges.
> 
> Given this is active for both aarch64 and x86_64:  Any testing with OVMF
> on x86_64?

Gerd,

Thank you for the review.

Yes — tested on x86_64 OVMF (OvmfPkgX64, q35). There's no fixed-BAR
placement to actually exercise on x86 since nothing on the QEMU side
populates the fw_cfg blob there, so this was really a check that the
fixed-BAR addition to IncompatiblePciDeviceSupportDxe is a correct no-op
when that blob is absent. And it is — existing behavior is unchanged,
without any regressions.

> 
> Overall this looks good to me.  edk2 has switched to github PRs, so
> please open a PR there.  edk2 has a policy that patches should not touch
> multiple packages, so patch #2 should be split into two for ArmVirtPkg
> and OvmfPkg.

Sure, I'll open a GitHub PR for this series and split patch #2 into
ArmVirtPkg and OvmfPkg patches.

> 
> take care,
>   Gerd

Thanks.
-Tushar


