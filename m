Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C3DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCU2-0005fV-AO; Wed, 14 Aug 2024 07:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1seCTy-0005ew-B7
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:48:02 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1seCTs-0001nx-C3
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723636076; x=1755172076;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7L2BRLd8kMWXNwFwW1/Yjdf+FSX99XXog9QPkjt0uA0=;
 b=GntyKsguBe2fIM+YpVPAFsNbj8OuJVPE6bh38olavA9sxS76heJM+ga0
 77YTCxEgOUf8/Eu9V59YrNKGLiDzXa5gkfMTDn4Di1FhNXp5pRGKYdu5E
 +Yfv02E5DmotijSAdbuSIJiZCiQhXbnAbLkYhRlx03sZdSc5NXYm0aNhg
 unXslZ2sFPQDWxGeTbS+HqwJQsktEUJzsw1nDvDNUMOOK/LOk+mbZ+K2A
 5aEn7HVn8FZJeHmF9yEB75Bzi9OpfjgLKMw4Jlcrprn0GUZXDQzL3lj+0
 GjBIcTsYy1IDlJveUcxyJ5YSePrWYsNNWAZUlMMn8qj/wBg1Y1SqKkXzn A==;
X-CSE-ConnectionGUID: /qo1iCPnRreeYIVzgWEkzg==
X-CSE-MsgGUID: 5JZnMrsCTtWfe09p5PoGvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39295972"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; d="scan'208";a="39295972"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 04:47:51 -0700
X-CSE-ConnectionGUID: VvE3I9i0QyKikQ6ZTSMHrg==
X-CSE-MsgGUID: CcU+wdGLQg2rSrvWI9pxaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; d="scan'208";a="63861542"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 04:47:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 04:47:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 04:47:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 04:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBhHVIy3MUQbUhmInwp+Uh+SL5/e0V60/3EJ1bdaN8nz/F7+XM5hLpC/gH21fwLKyRnkyqQUzyWLktaHqCuNzoOwqeXAbtqv+OrNf34AvZ4mxzebKYYQ+7NQZnZGdmwp39RxzxjeHEGW1XHd890GIjTImKizSoMRMs8TudhLImw71YKxUMSl+6CW/C26X6Rbs8Gy5V6xi30tE5kO/OU48dpJARyC41Da6/FsaIHDDeiXLQesqQVcD6c12omWShOn+aL/CqCzMN17ZYB85L1j+/V6EfKmtgOofc0sHW9oF44vtKVxmVAv47n/CRHm5XcrBOBce0nrxLukgMQYsoi1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpyGzUbo4DP4OTaWkj8FWw3EH5ws8lyjFzPzzqYoLPE=;
 b=xhKzoj5QG3YxgmL7W7ysHfZbQ3H2naqp9+UhWUe5R9qpoYzsCObvZ8bZmpkWVD2TTb36xqyB20xuRq8ZUcVPGpfuJstyYB1h5okENWgB6+joWZhOHn6mIGxeI+7wUZ4xBiJXhXwkHbqUFT//xHbd+eMUsPr7zoeHGD3lGt6sYKCDYhLx+cFEV+3ybENkSvkIjKrjvKBW8BVnmzsNoqjNlVnyfyorDwW8c+YsysS7YD2qwRSSw9BDwS5bZ4qhGkuYypePLQYCQyRJvyHIRYZ50+UAQqqMJzUCTjYK7KV1DK+Q5vhMwUebvCeTMszKpr+EsgkY5QgLG7r6TDkS0EzItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYXPR11MB8729.namprd11.prod.outlook.com (2603:10b6:930:dc::17)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Wed, 14 Aug
 2024 11:47:48 +0000
Received: from CYXPR11MB8729.namprd11.prod.outlook.com
 ([fe80::680a:a5bc:126d:fdfb]) by CYXPR11MB8729.namprd11.prod.outlook.com
 ([fe80::680a:a5bc:126d:fdfb%3]) with mapi id 15.20.7828.031; Wed, 14 Aug 2024
 11:47:48 +0000
Message-ID: <79809388-e441-4dd8-ae71-58405511d029@intel.com>
Date: Wed, 14 Aug 2024 19:47:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] i386/cpu: Set topology info in 0x80000008.ECX only
 for AMD CPUs
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
 <20240814075431.339209-7-xiaoyao.li@intel.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <20240814075431.339209-7-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To CYXPR11MB8729.namprd11.prod.outlook.com
 (2603:10b6:930:dc::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR11MB8729:EE_|BL1PR11MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ad4a05-331a-4693-4321-08dcbc56eb37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: yrZSUhNjlM8Bt1JpISOLPkMhe0PWtvYx2AwYAq3S+6L6VAcYdfW3lWtlCNYdwgXZthtsk21d5cxI7INkE2u+JqAEnzsLDsh5mLTtMiSclMPEw8v/VWd7HuKoUcsylw9viiUh++hRoACIZC4heRebv24TflIVLN//O5ru3n84XZeGxyFZnEvrPbarnnPgsQn76itAFsGWdu7wnFcrQ/dTUqEqq3i4ulgr8HSgeYlO8RvXiHBClUvTgD3OkIdn62qRclXf1k50jf2MPVTLyOEDOrVYNOGEYS14F+oQbNRBVFhhHXJcOIbgj/htYsOl3TaJEk4xj6OImsnoYBKbuAY8fvnnietPNfrz76AdM1I72rUxRNoddZ11Vd+DvjaaNLRbh+XhIY9oN1FxhBAZ0eNJyzHiTkixIrnPj4AI0l8DYlhtAbWfgpx4IqxMA48HixckhR+CC7Je9/OtxS5MgqzwozsQvHLKmUXcQimpIsvbyv5DRLwAuZRxfomz0e8b+SZW+BR3ioYv8uoJGvILG/18A/rkM4TXA3fYASrFRo0B8pLiUJr/ZoLdoOYLilzjq0Sptcg1YXC8Zl0OsDiqVVqlLx4IiwpWQ56TM0EtwcYDfJoW0Tj9jHtk9iBkRiXWFOR/1CN4oej0/pHC+JAUZiAIPtkdhXByX+ExspFKuyeXFtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR11MB8729.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szd5bWdXTC9YbHhlYml6UkZxSWxLb2RyKzNrTDJidnNCMDVVaFNxUXlMcEdm?=
 =?utf-8?B?ZU5Qei9MMkd6VHVrbjZJYUIxNlNid2N3Tm9ydS9JdFBYMzJUVG94RHlqQ2dx?=
 =?utf-8?B?MmVjZzdYQithZmloNllkT0FQTUoxTk9wZ3llRkUwcFFtckt2SHBzckplMHBn?=
 =?utf-8?B?NUZIcklDUVpzV2JWN1YxVndydDdlU0xFT01wTXB1WG4wVVdESis3d0FXK1Ru?=
 =?utf-8?B?RzBlTnJ4MWk3elVxblB1bVVOZlRpNU5ZZHIxWS9oOTFBdFc4TTFiRzgzd1ZF?=
 =?utf-8?B?OENBeXlRVkljaUZRc0Q5aUNFY01YNFlUMzl4S3dZSFZJZWpmMHd5ZTNteG9w?=
 =?utf-8?B?WTRSZEJFV0JHUUc2WnpGbUdUUi85aHovanE0M1NBTnVuWFhmd1Q1REV4L0V2?=
 =?utf-8?B?SmlVMElmU3N4SEFWRDg5L1Y3c3FpWjBVbElzeEQ4eS9qRHF5NGFqY1phWHA5?=
 =?utf-8?B?WmZuV3J3ZENJRDluVEdqWnRnc1Rva093L1hrd1Z6QXZINFZPNWZiMVJTa0NR?=
 =?utf-8?B?cnNDc05FV05nUVdOQzRJbFNSYjNNQkNodlJEOXF1NnNlRll0aUJFVzMremZ6?=
 =?utf-8?B?ZFFsTGJZOUN0UjQzT0l6VVBnMWFLNG41enZCRlNVWTR1bDQyNXdtejArK1Jt?=
 =?utf-8?B?VCtiTlAvT0FHVStzSVN0T3pUYmhiU3hMMnFrMUx2VzJIdWJVZk03aDZrcHJB?=
 =?utf-8?B?cjVzbHN0SFgyUlNDVUhHdWxWZjgxQkVTTitzcm92L2h4NVBxS0FhVUtwSGtx?=
 =?utf-8?B?MXF2VkMxQ1hLV0dMMFRVRlgvcHptRXBjWG1jNkREdFlBOXhHMmZ1aUgzU2Z6?=
 =?utf-8?B?ZWRHcHdWc3lnZjcwVEVrQkJNbVVNcWhWTE9mb3plbFhjK2t6SFNNU1M2TXBX?=
 =?utf-8?B?NDZGSVlVRnd6ZG1QM1NWNnIwNlRCWUtPMkVNUGRpRzM0RjkvS0xKUlBSZWF5?=
 =?utf-8?B?UXlkaDE1a21GeTVBelF6NXBweDVnMTFxT1JqOWdZRUtPYkg5SkJiN3VuU0NZ?=
 =?utf-8?B?MDhlMnhvcUNqeXlER29SbDdGNjNKVW0zMWs2TGpTQVluUy9xaVVrYTZTTUtN?=
 =?utf-8?B?TkZDK3lWY3FLNXVUTElBaHFteCtHdjJrZTBIWFVuS0RQdUo4T1dZQTlVbWR0?=
 =?utf-8?B?eVVOdUFvYWVYNWZjNGplNDdhQmxNWlBRdHZsN2ZoZktvZmMwRkJGWk0za3Ew?=
 =?utf-8?B?SWYxYnF4dE5kcGdxVERFYjJiZ2k3S0FxQXlMRy9SbjlRZGpSTjUvaEoyWWIw?=
 =?utf-8?B?b3M5cWhjT3g2UVlSMUZvdW1pbnNlMjd4azhMaGZ2SGdPejBBcHVXLzdhUXlD?=
 =?utf-8?B?SDVVSUQ0aVlnbDZuMVVBKzVaYWNwMHFkejdQUGExRUVsekR6SXBuWFVjMEU3?=
 =?utf-8?B?Y213VzdML1NkZzlvM3NFOWovUjlzRmh1Y3FucWpmTlp3bGd0Yk93czl4dVNT?=
 =?utf-8?B?SlNidytrazBWVk1uN1RrVWw1Qk1yd1M0S1ZScGlDK3ZMK3dyWXVQeDREbUtv?=
 =?utf-8?B?d1NYNTY3am5aUnZWMFlRYTlpZkZJSitVNjBKK3R2Wm15ZTM5STdCVTExRmJw?=
 =?utf-8?B?V2YwWHF1dDZwajdjQUtGMzRvUWlsTkpFaEI1bmxRdDNPMWFrZXVGdFpNaWM3?=
 =?utf-8?B?MEZiYjBZclhCemJPRlBMVzRRWlhOc29oMzk5YTQyN0VLMGkvT1p0OUM1WXhj?=
 =?utf-8?B?YTFQNnJJZ3JidzVjK2MrZGJEOEMrdlNyTllKcU5ib1YzN3lqRWhobXVrMDVs?=
 =?utf-8?B?V0RHWjJKQUZ4KzdjMXkzTkEycXo1b3BwNzgycHg3dkQrVUhKblh2ZjFvK2hX?=
 =?utf-8?B?dzhQVmpRbk4wVzFJVXNWRE9YZE9HSDkvb2dPR1Q4OXRrajZxZXBQRnhtVVFX?=
 =?utf-8?B?Q1lnMk03bHAxMWxZZ0RTZFRsNG8yWnU0MkpJVFM3UTlLRlNvRW02UzVLS3F2?=
 =?utf-8?B?YitDUXNXUk5QWEcxZ0p1aHllWFdNakZObC91a01LczNoSlAxd0dTSkh6V3FV?=
 =?utf-8?B?L09FU2EzMWJjdHJUUUVHLzRUaFRiZVAzd0xCK3p4NFd2Ny8zMHJuMnoyaUhw?=
 =?utf-8?B?bVNJNzRtNEdPOVM3Yk5LQWtDcnRxT2ZXM2RqM3BValExTDVmUTZWTFRac0tL?=
 =?utf-8?Q?gLZJeBJUlGHX6wThwmw+jrHB8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ad4a05-331a-4693-4321-08dcbc56eb37
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8729.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:47:48.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLj/VrIfw+qtGnsp9Y8zvp9j6l/xLJJCOmd6tqZoF/3iEWTzkyrPAZM2Qf82RKjutB2C8eJ8vk/bBeqNBmvIGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 8/14/2024 3:54 PM, Xiaoyao Li wrote:
> The whole ECX of CPUID 0x80000008 is reserved for Intel.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5bee84333089..7a4835289760 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6944,7 +6944,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               *eax |= (cpu->guest_phys_bits << 16);
>          }
>          *ebx = env->features[FEAT_8000_0008_EBX];
> -        if (threads_per_pkg > 1) {
> +        if (threads_per_pkg > 1 && IS_AMD_CPU(env)) {

Is it necessary to add the check like:

if (thread_per_pkg > 1 &&
    (IS_AMD_CPU(env) || !cpu->vendor_cpuid_only))

for compatibility with older machine types?

>              /*
>               * Bits 15:12 is "The number of bits in the initial
>               * Core::X86::Apic::ApicId[ApicId] value that indicate

