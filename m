Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC6FC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrIJ-0005rU-HN; Wed, 06 Mar 2024 08:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rhrII-0005rH-4r; Wed, 06 Mar 2024 08:26:50 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rhrIC-0001on-3L; Wed, 06 Mar 2024 08:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709731604; x=1741267604;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=VlvKQ6uGPkDxGa9BG/osLIXJJpxhPI0WjOnCEzcKDfc=;
 b=Bx1YTlbRnSba5wtNz6A8Ux6RXRQJrzQ3f/Jy7jal404c7xHsrvMbh2Yt
 YJ3102jud7x0qOob9LLJzOVPFR0Cvrl9hpgVsEA78TswhurKjtzpWdssD
 g0EBioYC4siXyH6M8gHzQC/NeB2LH2rGALOWraQ5p34tKtq/SfJ5KZGqZ
 JWzs1iiRniPFRnIP+u+ArMl5D5KqV25i5LMPtwucpTlLkhP7Tya8UkZey
 NhJj2ZN0YJFb6/xRarHFpuvPX2+15ceNs3yuJeGQL1w8kPrI+0QXgCNtx
 hssr4fDEW1PjQlR+gKO987i85X6/+JKNvUrGciZ8ErydIgATmJPeiiRbR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4460058"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4460058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 05:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; d="scan'208";a="14406556"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Mar 2024 05:26:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 05:26:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 05:26:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 05:26:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KabnTUNMZHlgawMevmXM18gImDKkix5p9GD7AMYAFHxzHgSUWSDeo7+46hgGH+6P5bMqL6QS+VPla+nwnilRn8SAqoJWWMKsflRkvD5xVgfFPRuf0MN0P/26hbeSE20D5YMdSgqzFtVPbz5esjN+75JlOOKeGAVluXVTB6cdO98pw72fAFbY/JWSojALLO+MO9IbBEEEjwObg4f0Eu7fsU6SKIA6hKh0Hg0RMTWW9kyzw4zZjltNiJcskV5pNLW/D6Iw2gfJHK6SV7MWdRGThhSa/mgFWcBpoZTuNp/K7jVk+0bDV6Xw+tMSKaX94yk+uy4sFO6jy/ThoJ2TbZhsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy8CTd9bNFHXxuyQJayL0Kix4JHS+P/EgHsU2z4BXMk=;
 b=CUlsj+f6DwJCG6fbExoEgNP+glOCC88OGLowv4ILofnVq/DCgeuBbPc9GNOvKd7QgExdP4xlpvZUAwnkn0eOvQM0bswJ/XlTIS5lFDc2ucOAWA0apYBDTPNi/o7PrStiwqcAb6P6AY+Qb0OR58TCuA8zCP55I/1mV2cuxFMol0IjWCwoyfs1AatOM5LwrS3xQSNJaq86jiXwiNRGw3qjVyCNPHf0FnMHI8AplVo0FQpoAbDEKufpSXz1XIroEDTPpbypJAF79aSct7SPnbi/V11jJ7LnGd7my7ASTt/loEhI+ZUmE854kXObKWltA76FIsxxCgTsQQRJRR3rZJ47rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Wed, 6 Mar
 2024 13:26:36 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 13:26:36 +0000
Message-ID: <56448108-c655-4684-bab9-b8d7747f79f7@intel.com>
Date: Wed, 6 Mar 2024 21:26:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-soc] [RFC 2/2] target/riscv: Add server
 platform reference cpu
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
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
 <8ad091f3-c00f-4786-a89b-799304eace73@intel.com>
In-Reply-To: <8ad091f3-c00f-4786-a89b-799304eace73@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|DM3PR11MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: aefef61c-f30c-42e6-18cb-08dc3de10bfe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWs2MsH+0+KbXdHzU35pJdglJ7wXE5gnD9s32MfAdNJUrtuOyT1E9g2dwHMzHZJ/V0RE+nzJ69Seav673KJyHFarDY7TOsvhCN0JRhrWNpKNS1b8O1ghqL6VOWcCgF+LFMQS2rabSioo9njOvfyzw4XKpfDUbx+HuR56OGMgYNXdg34dDnsOjxlHGqnk/f7yQ6jt3ZLIJfLmHF3QTn8D/v1rvtfluapGXHVYX1jbvvvxEkxWNZfYP2s27sqlqb8WN9q8l9e8jBQksp1wtKPl+ETt3r6SndoUlSEQREn//OsD16g/1NpCHphMgbA43wm7C5+L70ApNwS1JOr9OLimEnHuyLJsJ/HmzfDMIK0qfL0FdjUscq88glhgE9UKwY4ibeLKiqTgfZq1u+Puff1bD3yW533yU7fc7xXnFtsNIZwcXc2Wx9jtvFS9KwQoABL2Fxaiwlyn4FB3vymtpLcZ+GzkyWli1WvtKKfgJTiRjVTkRs/6pWFemcrNBhOKh5YKxuXGnaYbB9fQ6GI+aPtdl3dUBFCE0wt8ZoUvd+CEbri1r4M57dw/qYfrbbzrnr2UmIiEyeURbLxm+uAfs+313dSoym271TtQOVq/65gtkeGfjJWDE6qxFJ5owYqYPd6XpYq/dhz7mkhnH52fdiStQQrdsCEz+SFmGHdtG/8ZduI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(921011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2djSjFSQit5SXRKWXdudzdaU2lZQytEZFhXSnk4bUlETTJSeHZRL2NlMmYz?=
 =?utf-8?B?MzE3cHlEWUpjTW5jM0lFRE95bEVZN2hlVUpDYTdTcmRLU25IRlVIdzhWY0cv?=
 =?utf-8?B?R3ovdmF3TlhybVBwa051dFc4NlBzNkZkR0N4a1M1NUdrdksveFFnaXJDaklO?=
 =?utf-8?B?UG5tdXVGSEw1Uk12WVZQWnovTU00OEVHOXZ4Z0prUDVaenhpQ3ZuMFlPaUNW?=
 =?utf-8?B?YmJEM0NRVzdYMFBUS3RHVGszOStKWElyV25GWEdqejB2N3YyakdkbER0T1BL?=
 =?utf-8?B?TVd5Rk5XWmZIVTViQzFxbkE5TTAvSHdrMW5hSHNMRU5wTklzZGRIQjR6alN1?=
 =?utf-8?B?UDhBQUJ5YXBxK1lhaHhuKzBHMmFWb1F6ajBPNldITlhDRDN6Mmh5d3RTbUI5?=
 =?utf-8?B?SWlScVNtNG5OQlp6S2d1TGRkM0JpRitqc2FWSVIwR2ZmQXY0QjQ2L3R3NHc3?=
 =?utf-8?B?S2lkOFA4U3NQNEM5VTNEZm9MVCtVS2Q0L21rK0pvTlJBUk5IbnlIcWx1V0w3?=
 =?utf-8?B?QUhWUGdXSVFZb0Q0MVluUUJKS2QwcHFTOHFzMlFXREhFb21kRUNGcFZEdjZq?=
 =?utf-8?B?aW1DQW0zenA2b0M2ajM5SmlTUDk1djY3R0ZCc2tFcUFiTS8xVFFzMmM2Uk9X?=
 =?utf-8?B?Z1RLTU9oVWFBME5QR2V1WDZpVGRnbDhiWnRFTmRvNmdxNHMrR0FhRGFUS2Rv?=
 =?utf-8?B?aTk1SUNka25PZ1BieTBwL2pmdnEvZkpQRklWU1R2UFBkc1FyK2ZFbXlYNS9U?=
 =?utf-8?B?KzJYVjdYM3AvMzhHUG1NazllY1ROMkNJbHpQOTdJUWpkZHU2OTRRdS9EZWFi?=
 =?utf-8?B?N2dZOEhOK0tJY1lpMTZTbEs4amV6V3VBZGZnbzdiOCsyL0RadmQzMnJlc25Y?=
 =?utf-8?B?bGVyc1RoczJmUm1Cc0thT1R3VnF5MkZTRzljU2hSMGNuRm51WE9YanFvbVNW?=
 =?utf-8?B?dnRaM1VsRm9EY0tYd2lsT01DYnZkNnl2L2V0V1lSVFkvbjQvWDhzVy8rZ1Nh?=
 =?utf-8?B?M3JPVGZjT213OUxJRWtLM0IvUHBPWjkzQXJSc0JlMFlLSmQycDkyYnF2THlQ?=
 =?utf-8?B?RTFBc1VHcHp3amhlclJPSXlQOEFLUUhVNzROcm8yL0NkVjAzNnI2M0E4ZVJv?=
 =?utf-8?B?Q2drb1JLOXhOUnlGeUphZWE2RVd3MUVoS1M1US9mdjlhUFdhTWd2ajNZbFpN?=
 =?utf-8?B?OWlycWpBSEZSNDNhdlpnSjVmMmtFTjBTempBOTFNUWV2UHpSODBoWlNOeDgv?=
 =?utf-8?B?ZVpmOEY0M0pBL2swMmRoS3hZVFlJSGk2T1NnWXQ2RkV2WjZ6RnQzMUZhak95?=
 =?utf-8?B?MitUR1V5dVdvTnhiWXUxZ0dpYkpYdm9FYlJ6aVdqanZHbFQ2UDhkSi9CNzdV?=
 =?utf-8?B?V3YrM1lzMnY3ckNoU2hlMDR3Ym05VEdyQVpidjZGT3VhcDNXQlhDN2RMTEZr?=
 =?utf-8?B?WklyWlVCSjdOWmVIcnZ3bTR5OE9DekNHOHNMejdKV0VZMGVabzM4cStIZFI2?=
 =?utf-8?B?OXQrTkFSNmVtbXFod3oxZzhLay91NTFJYngwZnhjd1h6VUJHTlZ1NVR2cGt1?=
 =?utf-8?B?RHVjc2hVWGM4ZXkvelFWTjdOZzJFdWo4ZUZ1TG5IVlJFc3p4UnY5WHdmMHJP?=
 =?utf-8?B?Z003YnRaMUJ2aU0rYTdGTFFzN3ZGZHZXNGNURm1jVGQ4aGRwd0p1VlNsZnpY?=
 =?utf-8?B?ZEZkTHM5aGVkd0hKSmdvVDRaZ0ltdit3YmJlMDRUd1pDUlJSSG96SU9PTEQy?=
 =?utf-8?B?ZWFXcTlmY0hyUHB1RlVaOGtJazIwZ0M4T3pJblQrL3h6ejNBS3o4RThRazA4?=
 =?utf-8?B?QjdUR0xzaVQwVXgvaTRFTjdJQ05uUHRwdWM0YlJIWVR6QktIKzcyN1BpaWJn?=
 =?utf-8?B?blVUWHZyNytXaXo1L1dsSEhEeUVGK1pnK3pGYkRaalZKdVZTVTFqTTdLZG1j?=
 =?utf-8?B?RjlIM0ZZQXJZRGVua2Vmd0lZZmdRTGlGNnkzdWJJWG9XY2szUEtlZUxJM25R?=
 =?utf-8?B?V2tOaWN3NkVHWVVmcmhGNC9NTStxeGMvVWhraHRvbFNqckdhQUNhUVgwQWlX?=
 =?utf-8?B?WXJmUGtPaENqZEJjTEtiM2RTaVFqQWFwbVo3Y3gwWjhHaWEwSy9DNjhWa1ly?=
 =?utf-8?Q?vUgG8uFFDNWEicdE8fGjqxA1P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aefef61c-f30c-42e6-18cb-08dc3de10bfe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 13:26:36.1504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8bKSqPqSx/gQKkO238ZhnK4tVr+qXjCX2tL4mf9gNtU9Bt+qX1hdDAQQ8hYZxsINus7p/h2Go5Z44xBhhglVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

On 3/5/2024 1:58 PM, Wu, Fei wrote:
> On 3/5/2024 3:43 AM, Daniel Henrique Barboza wrote:
>>
>>
>> On 3/4/24 07:25, Fei Wu wrote:
>>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>>> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
>>> a virt CPU type (rvsp-ref) as compliant as possible.
>>>
>>> [1]
>>> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>>
>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>> --->   hw/riscv/server_platform_ref.c |  6 +++-
>>>   target/riscv/cpu-qom.h         |  1 +
>>>   target/riscv/cpu.c             | 62 ++++++++++++++++++++++++++++++++++
>>>   3 files changed, 68 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/riscv/server_platform_ref.c
>>> b/hw/riscv/server_platform_ref.c
>>> index ae90c4b27a..52ec607cee 100644
>>> --- a/hw/riscv/server_platform_ref.c
>>> +++ b/hw/riscv/server_platform_ref.c
>>> @@ -1205,11 +1205,15 @@ static void
>>> rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>>>   {
>>>       char str[128];
>>>       MachineClass *mc = MACHINE_CLASS(oc);
>>> +    static const char * const valid_cpu_types[] = {
>>> +        TYPE_RISCV_CPU_RVSP_REF,
>>> +    };
>>>         mc->desc = "RISC-V Server SoC Reference board";
>>>       mc->init = rvsp_ref_machine_init;
>>>       mc->max_cpus = RVSP_CPUS_MAX;
>>> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>>> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
>>> +    mc->valid_cpu_types = valid_cpu_types;
>>
>> I suggest introducing this patch first, then the new machine type that
>> will use it as a default
>> CPU. The reason is to facilitate future bisects. If we introduce the
>> board first, a future bisect
>> might hit the previous patch, the board will be run using RV64 instead
>> of the correct CPU, and
>> we'll have different results because of it.
>>
> Good suggestion.
> 
>>>       mc->pci_allow_0_address = true;
>>>       mc->default_nic = "e1000e";
>>>       mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>> index 3670cfe6d9..adb934d19e 100644
>>> --- a/target/riscv/cpu-qom.h
>>> +++ b/target/riscv/cpu-qom.h
>>> @@ -49,6 +49,7 @@
>>>   #define TYPE_RISCV_CPU_SIFIVE_U54      
>>> RISCV_CPU_TYPE_NAME("sifive-u54")
>>>   #define TYPE_RISCV_CPU_THEAD_C906      
>>> RISCV_CPU_TYPE_NAME("thead-c906")
>>>   #define TYPE_RISCV_CPU_VEYRON_V1       
>>> RISCV_CPU_TYPE_NAME("veyron-v1")
>>> +#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>>>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>>>     OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 5ff0192c52..bc91be702b 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -2282,6 +2282,67 @@ static void rva22s64_profile_cpu_init(Object *obj)
>>>         RVA22S64.enabled = true;
>>>   }
>>> +
>>> +static void rv64_rvsp_ref_cpu_init(Object *obj)
>>> +{
>>> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
>>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>> +
>>> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
>>> +
>>> +    /* FIXME: change to 1.13 */
>>> +    env->priv_ver = PRIV_VERSION_1_12_0;
>>> +
>>> +    /* RVA22U64 */
>>> +    cpu->cfg.mmu = true;
>>> +    cpu->cfg.ext_zifencei = true;
>>> +    cpu->cfg.ext_zicsr = true;
>>> +    cpu->cfg.ext_zicntr = true;
>>> +    cpu->cfg.ext_zihpm = true;
>>> +    cpu->cfg.ext_zihintpause = true;
>>> +    cpu->cfg.ext_zba = true;
>>> +    cpu->cfg.ext_zbb = true;
>>> +    cpu->cfg.ext_zbs = true;
>>> +    cpu->cfg.zic64b = true;
>>> +    cpu->cfg.ext_zicbom = true;
>>> +    cpu->cfg.ext_zicbop = true;
>>> +    cpu->cfg.ext_zicboz = true;
>>> +    cpu->cfg.cbom_blocksize = 64;
>>> +    cpu->cfg.cbop_blocksize = 64;
>>> +    cpu->cfg.cboz_blocksize = 64;
>>> +    cpu->cfg.ext_zfhmin = true;
>>> +    cpu->cfg.ext_zkt = true;
>>
>> You can change this whole block with:
>>
>> RVA22U64.enabled = true;
>>
>>
>> riscv_cpu_add_profiles() will check if we have a profile enabled and, if
>> that's the
>> case, we'll enable all its extensions in the CPU.
>>
>> In the near future, when we implement a proper RVA23 support, we'll be
>> able to just do
>> a single RVA23S64.enabled = true in this cpu_init(). But for now we can
>> at least declare
>> RVA22U64 (perhaps RVA22S64) support for this CPU.
>>

Hi Daniel,

I'm not sure if it's a regression or the usage has been changed. I'm not
able to use '-cpu rva22s64' on latest qemu (db596ae190).

-- latest qemu, cannot see linux boot message and blocked

$Q -machine virt -nographic -m 2G -smp 2 \
  -cpu rva22s64 \
  -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
  -kernel $Kernel

Boot HART ID              : 1
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdc
Boot HART ISA Extensions  : time
Boot HART PMP Count       : 0
Boot HART PMP Granularity : 0
Boot HART PMP Address Bits: 0
Boot HART MHPM Count      : 16
Boot HART MIDELEG         : 0x0000000000000222
Boot HART MEDELEG         : 0x000000000000b109

-- latest qemu, w/o rva22s64, looks good

$Q -machine virt -nographic -m 2G -smp 2 \
  -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
  -kernel $Kernel

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdch
Boot HART ISA Extensions  : time,sstc
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 4
Boot HART PMP Address Bits: 54
Boot HART MHPM Count      : 16
Boot HART MIDELEG         : 0x0000000000001666
Boot HART MEDELEG         : 0x0000000000f0b509
[    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
(riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024

-- commit dfa3c4c57, patch to enable rva22s64, looks good

$Q -machine virt -nographic -m 2G -smp 2 \
  -cpu rva22s64 \
  -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
  -kernel $Kernel

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdc
Boot HART ISA Extensions  : time
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 4
Boot HART PMP Address Bits: 54
Boot HART MHPM Count      : 16
Boot HART MIDELEG         : 0x0000000000000222
Boot HART MEDELEG         : 0x000000000000b109
[    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
(riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024

Thanks,
Fei

> Let me try.
> 
> Thanks,
> Fei.
> 
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>> +
>>> +    /* RVA23U64 */
>>> +    cpu->cfg.ext_zvfhmin = true;
>>> +    cpu->cfg.ext_zvbb = true;
>>> +    cpu->cfg.ext_zvkt = true;
>>> +    cpu->cfg.ext_zihintntl = true;
>>> +    cpu->cfg.ext_zicond = true;
>>> +    cpu->cfg.ext_zcb = true;
>>> +    cpu->cfg.ext_zfa = true;
>>> +    cpu->cfg.ext_zawrs = true;
>>> +
>>> +    /* RVA23S64 */
>>> +    cpu->cfg.ext_zifencei = true;
>>> +    cpu->cfg.svade = true;
>>> +    cpu->cfg.ext_svpbmt = true;
>>> +    cpu->cfg.ext_svinval = true;
>>> +    cpu->cfg.ext_svnapot = true;
>>> +    cpu->cfg.ext_sstc = true;
>>> +    cpu->cfg.ext_sscofpmf = true;
>>> +    cpu->cfg.ext_smstateen = true;
>>> +
>>> +    cpu->cfg.ext_smaia = true;
>>> +    cpu->cfg.ext_ssaia = true;
>>> +
>>> +    /* Server Platform */
>>> +#ifndef CONFIG_USER_ONLY
>>> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
>>> +#endif
>>> +    cpu->cfg.ext_svadu = true;
>>> +    cpu->cfg.ext_zkr = true;
>>> +}
>>>   #endif
>>>     static const gchar *riscv_gdb_arch_name(CPUState *cs)
>>> @@ -2547,6 +2608,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64, 
>>> rv64e_bare_cpu_init),
>>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64, 
>>> rva22u64_profile_cpu_init),
>>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64, 
>>> rva22s64_profile_cpu_init),
>>> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64, 
>>> rv64_rvsp_ref_cpu_init),
>>>   #endif
>>>   };
>>>   
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#125):
>> https://lists.riscv.org/g/tech-server-soc/message/125
>> Mute This Topic: https://lists.riscv.org/mt/104719379/7152971
>> Group Owner: tech-server-soc+owner@lists.riscv.org
>> Unsubscribe:
>> https://lists.riscv.org/g/tech-server-soc/leave/12737993/7152971/1793629631/xyzzy [fei2.wu@intel.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>>
> 


