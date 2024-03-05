Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF64C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNp7-0003b2-G8; Tue, 05 Mar 2024 00:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rhNp5-0003af-Bb; Tue, 05 Mar 2024 00:58:43 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rhNp3-00058a-1F; Tue, 05 Mar 2024 00:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709618321; x=1741154321;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=fk2O6rrUd/t4U0oaN6V2F4ewyPBhTrarXen4cTvdqMM=;
 b=N94ebfJd4TiweEuRtPudkGGHD0t5PGeNDmAoaRnOJQv/PgEW+7I75zAC
 ZImmvjerC6PA6ilnLC3JgVuXYxMdotdNPKbrAyiXBSnpe5rwj2YG0ElAb
 iP2Qh973sCabICf4/oAaNZRkmduisSsIdEJr53ZRwK1caI8ogG4E7ZJ90
 pOEDLD8+uoVwIRjwyuCSCqfEfRGCt8B7XJqgQpiwM3kStvKyR9cS652Ge
 P+6P7Io8HYe/7ZzNoH+UZXXzzHW8cStTnp6LfLfe3zmPf4PtWvE8FUIg/
 tKSMcx/qcloUhYR4CrMHwQrYDlwWLk86Y1STeb8Is/DIuEudndhsMae5P w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7969548"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7969548"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 21:58:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; d="scan'208";a="46786437"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Mar 2024 21:58:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 21:58:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 21:58:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 21:58:37 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 21:58:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rlo2YYvf0xvJkq/CGfhzC879v0vYGFxZ3m9o6Uqez0FNGMAiEpNflwu0bfhrGstl2cJQqNAMp/EZaOeKJCEUCPj1beOurFfN0tUBpWlZJC5X9JW+MtA3bAAnF2cRsfAMAqC+5NJj1Rz0VYeVEsw2U98UxRDHHdetTgW3Dk2Cjc4nKresNIkP8wJJ59qFpTbNlXvVix+/eAaotxtgHTJHtmUUcrEC15Xk7G9/8/38rOWJcQRjo66gHLOcPLWIToezmO6fvfjNusfOLj7yFEQLHUc/BInQnbZnzeSOlm8C+rRs/tT4Y+bY9IdLWUHmUtkN8sW30E0PsEzCclnCE5/GuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJh0Jvne+7ITXwF5537jcWhgPjIH7TMK8UgIKf3D35c=;
 b=SdXZkFKHY7xbWPVvFm5Xeqtlee3Wl/5U+XOFTXfUWwBczVlt9mTVdzwb6pME6FhxaQPPzKXv0gNi5cxEKEKGcC70OxrmfPHGz/yN7aUxUgaFHtjOVJGguDdncITbjFVMAITFDAR5LfujptXuhBT/7GjMHBBwdWR9o9iHshL87GGkaOU93+rCSYWxIAZfxaKUb2JGAFWJ9zz0rSA9AIzvSmZc/mErZSjeHJKpbRMTHfoa3bSja44OOeedyVvDPR01TFHCAsaYT9fIGs6Bumcx9scJIIFksLT5O8TKH5IWIar/w6DArEf/51+ZmAgWVYMjThV/RgYXR96p6OUbX/OcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by IA1PR11MB6371.namprd11.prod.outlook.com (2603:10b6:208:3ad::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 05:58:28 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 05:58:28 +0000
Message-ID: <8ad091f3-c00f-4786-a89b-799304eace73@intel.com>
Date: Tue, 5 Mar 2024 13:58:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-soc] [RFC 2/2] target/riscv: Add server
 platform reference cpu
Content-Language: en-US
To: <tech-server-soc@lists.riscv.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <andrei.warkentin@intel.com>, <shaolin.xie@alibaba-inc.com>,
 <ved@rivosinc.com>, <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>,
 <evan.chai@intel.com>, <yin.wang@intel.com>,
 <tech-server-platform@lists.riscv.org>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-3-fei2.wu@intel.com>
 <bd34501b-3dda-40eb-aa92-73ea289297d1@ventanamicro.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <bd34501b-3dda-40eb-aa92-73ea289297d1@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|IA1PR11MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 23646f43-6447-4547-57c4-08dc3cd94787
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jtgiNFLRz3gHIHdJy9+deNZascrnk/iNZxMGJw01Bu3lRaSQsFH0WhXvzLIk6+zMnV7ncn9wzlcMMeVYYX0+70LJcTR2mzYc6dfqS4cENdYzbJQMDVfYNtPA/VpRSjnfEqdwF0L7HqC6b3I1kAtKZfWbGxGHxvttTd4UcuxTFxExYGiJmqofismJ4kIhgQb9CRYA0hZnFcIUCaB7nNLn2nMZGqMe6cSsaskGkTMUYIMon6hdiUl5WmE9FmlENRXnQNy3J+opgjdjbWc7AdgV5/1R6JYy45FNPIUDJzXoglvasGOB+S/Y2Hffhn2d1MJZzNlkXljjt2O+Az2UlcX05Jwr7/3Owwy92cbmrZ0w6QFRPJIXEeS89kHqZH/hfBSaRAq2Oi0eQF7zJxttO717mYFC2QVOzQpvQmQ2OdZQdX4dNC7Aau88VxgJEghplabJCF4WG5o8qLUM5S8gvXBNnobsqH0Dl8Qi46n+LdJyDLNjzU93Cqymc87kZYKNGP1vasqfkoxS8qS0ipST4Ioic9iV3s1OXS6bp80i3hDXH7+scG9xWHabKI5LRd5t1+C46orG7W0bmS32VIgfLznwjELbUqFTdSj9xhhZTJFcq4r03AC1mbOf9SZCmfn9xJdIdUFbUVp4Sqbulrh295G4I46PPUOrhhj2b6JixKL1Kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(921011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0FWMUw4NmZkZzY2Y0pQZmtMSVAvZFg3cWwrMDB1OVFNY2lEbG9kUUZaNjZH?=
 =?utf-8?B?OS9iVkcxR2NmdVFSWDZ4TUlNeDhUeWN3MEJaa1ZFcm9NWkpMOVBrbGl3RmQx?=
 =?utf-8?B?a3V2NEZuYlAwOEJFOFZ1cnV1bXVjM244ek5lSGwvMHNmQjVveWpadS9oZTh4?=
 =?utf-8?B?eU4zVWJiN2ZINkVhZE9IWEVnTjNibVhCOHh1VmdScUU2WUZuK2Y4UzVnanUw?=
 =?utf-8?B?Q29vNFB3WWl2UmxKSzdMam5qNkp0eEltL3MxN2wrWTBLQUNGVk84cWZSM2lL?=
 =?utf-8?B?elBycjdIUitEZFI4aVZreHZKa2Z4ZEVZR0Ryd085UXAzQTZnZnZVejU4T1lD?=
 =?utf-8?B?TjJmc0UrNVk1L3Q5ZGpaWnFaOGpGdlhsYXBFOWMydzZ6clJtclZNNm1HaXJN?=
 =?utf-8?B?bmY0UTJPUWh1aHZnVXl5aXRYRGtUN3lhdERYYjZ6VW5vVGZZdThWL21EQWNm?=
 =?utf-8?B?U2hicVMzRHVleXk2UHZUWXZ3UU1mN20zT1hmRWZTY2FvUEVDaytrSGlIOGV3?=
 =?utf-8?B?a05sTEg2Q25GdFFSNFM4THM2R3k5czZ3TXBrbjZ3bGwwcDdrRDlzY3FkVWVE?=
 =?utf-8?B?dUt6ODdKMWtIbnR3RmV5QXlSaEdzKzkrTmc5OGtGTE0xeW9TQWpNajdINnBp?=
 =?utf-8?B?MzIyK0xlSGl6REFaVTVpUllPSGIxekRYK1oreTZEZ0NKdmlEcHEyTmZXdktl?=
 =?utf-8?B?cE52cVZBMy8zRnB2Qkx2RXB1VzdIRmsxUy81QnNEUXVVNDRDaVFOVnV6Qi9Q?=
 =?utf-8?B?M09vOGtrVnlZZ01uditidE4xd1JUR2FwcnRpNVpPdHF3dldXN2pPdTZpcWxJ?=
 =?utf-8?B?RmI4OTFmSE0xUkxleWlaLzVRWllPbUt2cXdJNEdjb0EvVnlYRkZYMjZKaTVN?=
 =?utf-8?B?WmUxNEtlZkNiS1V3ZlF3MDU0bXpsbkZHQmpnaTdsdlQ4Ry90SllqQ2pBdUl0?=
 =?utf-8?B?ajBKU3RSVlcxMWE4VStaUER2RnpDSHZRekxSeDlqQ3NnNnR1ci8zVU9ob1c5?=
 =?utf-8?B?ZHVTaXdvdnRuRnF6WG1wTnVDVHkxeWNxd2xrREZ5Qnd1eE5ZR3FIb0ljWWc3?=
 =?utf-8?B?bUV5dHBibkxOYXdzQ3R0aWNUU3hXQkF3Y0dJKytGWWRkZnl0dkFJREZpaXox?=
 =?utf-8?B?TDNZeTl2ODFOTWRsblVVUDFIV0dtb1VxM21pS0FSSjkzVTg3ejJMM0Z3YlZI?=
 =?utf-8?B?Z0lvS2FUSDhXeExoOCtOT2pqeTRmRFlQVFFVRGFmNExJUWxyWHlIOXV0M1lk?=
 =?utf-8?B?OHBnQ05rbW1WUGYrVVJzbGxNWXBjdG9VYW5UYWRob2tCSWthS0hCQjR6OGFP?=
 =?utf-8?B?QjNVWHUrRlJnTkJsa1h3ZW9RY2hTNUpqTC83SWtuNHhYTmNBWjRFZFYwaTRB?=
 =?utf-8?B?L25jLzJqZkJWTTQzYi81SGlseHZTZWJINUJXemtuWU5Ra0NSZ3ZkekhLc3Mv?=
 =?utf-8?B?cmszUDFlZjM3VE9hVEdNeGtTbHVkY3hkblFFd3dCdzE1b0gzb1VOcVRkWHJ5?=
 =?utf-8?B?UXQ4Vm1qdDZ2bjFOTzd2SUFqaVo5QWpaNmQ3OHhnV21RNnoxTDFKb2xNcC9w?=
 =?utf-8?B?WlFHbjFJUkpZUGxiN1I2WFRpZ1haM0VZU3BaTy9ySkNzYU45WVVxYjF4a2Vj?=
 =?utf-8?B?eGZNOHp6d05nMHUyZkJ0bE8vSWdOZlUwT3ppWE41TkZ2KzNtNzVXaXZLdk82?=
 =?utf-8?B?N3F3ZXErVENhcnoxZDRyOUc0QXAxK0l4R2JXZDFrYWczK2dsamZWc0JpWlA4?=
 =?utf-8?B?REtUWk5wc1NQblpMSVBGMmFvb2pxbEd5VEF5WmE2aVpXN2ZTeXFUVlBJTE53?=
 =?utf-8?B?NFpnTTVETU1HbC9WSkR2MkpRM3VxbmpzRGJiUHc0T0p4aXBQZmRHSjJ4UCt1?=
 =?utf-8?B?Y3I0MVhZUkZmZ3JkbXNPSmhwZEhxNHJCNlhGMkZBbVVXS2JFVVZJZ2VrVitS?=
 =?utf-8?B?Q3pNRjM5YU5kRnhwT3J3RW9XRndOMlRST3NTczQrMzJRbE81MnZnbk1zU0Vn?=
 =?utf-8?B?ZFZ2bG52ZDhnMkkwQTBMTmlnRUNYUG5MUlM1VkE3RHlVVGQyZjdYOWYzb1ZQ?=
 =?utf-8?B?MDNEdU92d0xnQzB5cHM1bm05L2pEWUpVbjd1RmJNMXMxZTRBUmpEaWdnSXZz?=
 =?utf-8?Q?vrXYdO8Gd7chg7TEjadRiU1XX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23646f43-6447-4547-57c4-08dc3cd94787
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 05:58:28.8669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PgO5rfDJ0xb5TpYGUq3pGHQHwQJkTe52EmfXLKWmX1wPQ20BVgNh9eah2Wv0ZLTALhWXJuBhc3he5SbHWtOnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6371
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/5/2024 3:43 AM, Daniel Henrique Barboza wrote:
> 
> 
> On 3/4/24 07:25, Fei Wu wrote:
>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
>> a virt CPU type (rvsp-ref) as compliant as possible.
>>
>> [1]
>> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> --->   hw/riscv/server_platform_ref.c |  6 +++-
>>   target/riscv/cpu-qom.h         |  1 +
>>   target/riscv/cpu.c             | 62 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/riscv/server_platform_ref.c
>> b/hw/riscv/server_platform_ref.c
>> index ae90c4b27a..52ec607cee 100644
>> --- a/hw/riscv/server_platform_ref.c
>> +++ b/hw/riscv/server_platform_ref.c
>> @@ -1205,11 +1205,15 @@ static void
>> rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>>   {
>>       char str[128];
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> +    static const char * const valid_cpu_types[] = {
>> +        TYPE_RISCV_CPU_RVSP_REF,
>> +    };
>>         mc->desc = "RISC-V Server SoC Reference board";
>>       mc->init = rvsp_ref_machine_init;
>>       mc->max_cpus = RVSP_CPUS_MAX;
>> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
>> +    mc->valid_cpu_types = valid_cpu_types;
> 
> I suggest introducing this patch first, then the new machine type that
> will use it as a default
> CPU. The reason is to facilitate future bisects. If we introduce the
> board first, a future bisect
> might hit the previous patch, the board will be run using RV64 instead
> of the correct CPU, and
> we'll have different results because of it.
> 
Good suggestion.

>>       mc->pci_allow_0_address = true;
>>       mc->default_nic = "e1000e";
>>       mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index 3670cfe6d9..adb934d19e 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -49,6 +49,7 @@
>>   #define TYPE_RISCV_CPU_SIFIVE_U54      
>> RISCV_CPU_TYPE_NAME("sifive-u54")
>>   #define TYPE_RISCV_CPU_THEAD_C906      
>> RISCV_CPU_TYPE_NAME("thead-c906")
>>   #define TYPE_RISCV_CPU_VEYRON_V1       
>> RISCV_CPU_TYPE_NAME("veyron-v1")
>> +#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>>     OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 5ff0192c52..bc91be702b 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2282,6 +2282,67 @@ static void rva22s64_profile_cpu_init(Object *obj)
>>         RVA22S64.enabled = true;
>>   }
>> +
>> +static void rv64_rvsp_ref_cpu_init(Object *obj)
>> +{
>> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>> +
>> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
>> +
>> +    /* FIXME: change to 1.13 */
>> +    env->priv_ver = PRIV_VERSION_1_12_0;
>> +
>> +    /* RVA22U64 */
>> +    cpu->cfg.mmu = true;
>> +    cpu->cfg.ext_zifencei = true;
>> +    cpu->cfg.ext_zicsr = true;
>> +    cpu->cfg.ext_zicntr = true;
>> +    cpu->cfg.ext_zihpm = true;
>> +    cpu->cfg.ext_zihintpause = true;
>> +    cpu->cfg.ext_zba = true;
>> +    cpu->cfg.ext_zbb = true;
>> +    cpu->cfg.ext_zbs = true;
>> +    cpu->cfg.zic64b = true;
>> +    cpu->cfg.ext_zicbom = true;
>> +    cpu->cfg.ext_zicbop = true;
>> +    cpu->cfg.ext_zicboz = true;
>> +    cpu->cfg.cbom_blocksize = 64;
>> +    cpu->cfg.cbop_blocksize = 64;
>> +    cpu->cfg.cboz_blocksize = 64;
>> +    cpu->cfg.ext_zfhmin = true;
>> +    cpu->cfg.ext_zkt = true;
> 
> You can change this whole block with:
> 
> RVA22U64.enabled = true;
> 
> 
> riscv_cpu_add_profiles() will check if we have a profile enabled and, if
> that's the
> case, we'll enable all its extensions in the CPU.
> 
> In the near future, when we implement a proper RVA23 support, we'll be
> able to just do
> a single RVA23S64.enabled = true in this cpu_init(). But for now we can
> at least declare
> RVA22U64 (perhaps RVA22S64) support for this CPU.
> 
Let me try.

Thanks,
Fei.

> 
> Thanks,
> 
> Daniel
> 
> 
>> +
>> +    /* RVA23U64 */
>> +    cpu->cfg.ext_zvfhmin = true;
>> +    cpu->cfg.ext_zvbb = true;
>> +    cpu->cfg.ext_zvkt = true;
>> +    cpu->cfg.ext_zihintntl = true;
>> +    cpu->cfg.ext_zicond = true;
>> +    cpu->cfg.ext_zcb = true;
>> +    cpu->cfg.ext_zfa = true;
>> +    cpu->cfg.ext_zawrs = true;
>> +
>> +    /* RVA23S64 */
>> +    cpu->cfg.ext_zifencei = true;
>> +    cpu->cfg.svade = true;
>> +    cpu->cfg.ext_svpbmt = true;
>> +    cpu->cfg.ext_svinval = true;
>> +    cpu->cfg.ext_svnapot = true;
>> +    cpu->cfg.ext_sstc = true;
>> +    cpu->cfg.ext_sscofpmf = true;
>> +    cpu->cfg.ext_smstateen = true;
>> +
>> +    cpu->cfg.ext_smaia = true;
>> +    cpu->cfg.ext_ssaia = true;
>> +
>> +    /* Server Platform */
>> +#ifndef CONFIG_USER_ONLY
>> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
>> +#endif
>> +    cpu->cfg.ext_svadu = true;
>> +    cpu->cfg.ext_zkr = true;
>> +}
>>   #endif
>>     static const gchar *riscv_gdb_arch_name(CPUState *cs)
>> @@ -2547,6 +2608,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64, 
>> rv64e_bare_cpu_init),
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64, 
>> rva22u64_profile_cpu_init),
>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64, 
>> rva22s64_profile_cpu_init),
>> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64, 
>> rv64_rvsp_ref_cpu_init),
>>   #endif
>>   };
>>   
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#125):
> https://lists.riscv.org/g/tech-server-soc/message/125
> Mute This Topic: https://lists.riscv.org/mt/104719379/7152971
> Group Owner: tech-server-soc+owner@lists.riscv.org
> Unsubscribe:
> https://lists.riscv.org/g/tech-server-soc/leave/12737993/7152971/1793629631/xyzzy [fei2.wu@intel.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 


