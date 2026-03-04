Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E739FEB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxiF6-0008Ll-Es; Wed, 04 Mar 2026 04:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vxiF4-0008LV-JG
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:10:06 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vxiF2-0008LH-3d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772615404; x=1804151404;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6hGiOlf5eCXtwgAJo0ijYKokUM924Q0D1DS4xGz6cXQ=;
 b=RJBPncl8V+sD6RQrTO+WB1AsB/TOZkk73hMGVOZC9GEZL0hf55zQt0Dd
 7qs5lIvTiBFShJ+BMUSTOYSzjwS1x262EgxsG121runDTnVL3MRzOYQuc
 bcd529eSg1VtgIrPEaaq9KwRdEJBWVisSLPZG6uOiKRSjVNEGq5a/bfas
 yM3YVMAsNKU3eZjVg7qNhpYYopVscdmHq/kzn73vOjfTpMiuOajz0qvoF
 fVCIqURCHR34ReaOmOdoVM0u4dN8ltoL8/iHckrUj9JaAh0jtA+FJ2M2z
 cW66HSNI3XV1YR92AWCBb/emWQ0g8UWFQY/ZaL82G4T5NmtqqjcrFQ7Zj Q==;
X-CSE-ConnectionGUID: D0lfvLgrRhy+lkpNYo5RJA==
X-CSE-MsgGUID: WgHaO1h9RfeptTvQGGxwXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73860504"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="73860504"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:09:59 -0800
X-CSE-ConnectionGUID: 2gZcrIBQQWW92sjmDpDa6Q==
X-CSE-MsgGUID: jT/5x5MgTCGAQ2hQHzJy9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="222447638"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:09:58 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 01:09:57 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 01:09:57 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 01:09:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIhAyvlwYu5PMYIn8dfmHCcv/wF9RDJlHMODMo5VSDAcBWQRFv9do8TfJC8vPDig/46ezcw1px9Soeo/yj4k17PvTHEKkE03TKC/lNmxgbCEvaPV4PQFyI9M4Oomwz/08EQXZNAF7LWiC852kZ2pZJQqW45edHK1njiTw0KWmw1K9fkBVWA1ECB3CfQ3ZqOPdvmP8uwmV6RjK10cgVpG0JPsFGUlPjNOM7+EH7apdisBi28Nx7/ZygAMusinKERIpb2eOVDPfrbB5eu2UQa0WTrrCNfI6C0JHUcsPBAchEzGo5atoYPrpm5N/+d6WM0ykMsYk+W4c0ig7D6Ysfy/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1x7m+5Ag60ej4cNzlwfJMniybcmtWxid3qVGEnXLJ4=;
 b=AF/1GDCrwDDEkqFlbVcg2b4a9G/VKlrEJL1EF3cPJPC5Dc8KVxzanhR1PHaHogrw5GvfRFquFJyjXPtiaIpp01VgVtejDEr38lwnk/hlRJT6k3qROcKlOJ7jO3pRvXPsS/QqtN9K+d0dcNiiXUeJfKCg7EEHkfZNEU6HCUnT4P95ThQXzVFQcqjc6PUNNgQDdDGowtGdunR/IBy8Th5SePWBsXImp875e+5ssS34OLXY/EQsBWFZs+jkxgF9WIIlHBKao90JuEymUqRlVO0nGKVSY7Ia/S5fD0KjQz7UTPD1LvwuAXqGPnCxSIVnZOqkD+S8O0COKtLYadYQeluDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 09:09:55 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 09:09:55 +0000
Message-ID: <7095d5e0-e6a0-46cf-aefd-44932a736b97@intel.com>
Date: Wed, 4 Mar 2026 17:09:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] kvm: replace RamDicardManager by the
 RamBlockAttribute
To: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>
CC: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>, Fabiano Rosas
 <farosas@suse.de>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, <kvm@vger.kernel.org>, Mark Kanda
 <mark.kanda@oracle.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-6-marcandre.lureau@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260226140001.3622334-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH3PR11MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c926ac-e704-4e3d-abbe-08de79cdccf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: qyPbZomtp5kgmo9KhWp033bFzmmnlnwVxzS/C40s0vtObBaVQCuxHIGyw239MOBGJ5d206XwxItJyAvcP28t/izoSCjfSKHzECqoUpVzL54cMwwpWbUB8bhwap9RRQQmQua2YsLt1TXHjwvuwse2M19uUJs4rp00ZudyArPurYj3TLObMfuAk0a6Kp9dFE94H1CqdG6c5xTW7l7PQTPMGLEj6QvP37jqMpNjQp5pDxSqK5uXfqzyq0lgY0a9InYp4EMj9onfXnU10TNvXQs6qXQ2gPu5qrUzZOEK8ua1xLCmIJCCCh6iCrZu14i5zsBNNrp5aYauxLnLkeTSJXkrGI3Q8h4cKhOudlgBDxOt6IJ2z6jJJ/Mti5oxnoTKeRYVjI2a0YxlVDCniIXV2aG5TS5Z1EUSVkss5oiSAli1ii3xG61NehPLVeTQnX2llT6a/iSkHXqKM2J8F+/cAs/tl+oG8c/7dTT8a4O+9JfXW7mcCOD5/5SXudA5p/pVbVY7yGWM4c5ZdzAsN7BZMJlefGCVio5nkcge6a87mOw1J+wBmj2ANCM0oW+AKxOycAGdzkFjbyZAY/fccPeOcMwq6/zLR8AdM3CoeiVkZ6Ch9ZUcIOP50LGGU8I9nGUqiKZhrwV72s0gYbY9mAuCsgFTwetBFF8vG3x2UoiJcDtwUddxoDjoP+3GnXmIwSsBMG5jvwg0Hqf+DCxGAkH9Dupc5wm8LRtFS6Ro6KJSXqTwy9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdVNENFTFpEbEFKUUZLZ2dWZFhyaG40T21zbnZKdjlNZzRUWFZzUk4zWXk3?=
 =?utf-8?B?aVptTmNnTjZsWGtxYWFZVGtNd3BVTW12dW5SRWdJNzg5NzNkVkpSMUlWaktJ?=
 =?utf-8?B?eURGajV3RTRobUVIVS9sUy95dGEzSDgyZWNpN2ZYenVHVXZlTm9VYXlPTmIv?=
 =?utf-8?B?aUlaZWdZSUd0L1FlZzAxRWhHaHRaNVdCUk0vMlo1akdNUHVscXJIZWp1U3hX?=
 =?utf-8?B?QjZ0eGd1dHVCazVQUUh6NFlINTM5YzExN3M4eVpRclMxRGNFSVNxaUpENFlF?=
 =?utf-8?B?d2ROenpSOTYxaGtpR2g1cHpERC9jcTBPVHlJZUQ3VnZpWXdPeEwwcDcyOGJH?=
 =?utf-8?B?dWJmRWNna2daUjMvSmpNKzhVbVZPbGIyblZlVWU4RVMxTG5sTkNSQnpLZUln?=
 =?utf-8?B?SmkzaTQ2YVVYK2dYQjVxbzhvWk01STBmYlVLQ2VIY2R2U2w1QjhsVitkekZz?=
 =?utf-8?B?TllHNkRNc1c4VW8xdGZqUit1WFZ3dnZYU3A2QklmaFpMMDk1WGFJMlVVd1hL?=
 =?utf-8?B?UnBHQXRxTWxEaUdDUzhqS0RGV1FSNEZSN1ZZU05td3hjL3Fway9henNVbUNT?=
 =?utf-8?B?QVhYbS9QMmQ1NmE2WGQ5cEs4Q3JVS2lrRXZOVWFOMEdGa1REUjZWdm9FQnc1?=
 =?utf-8?B?b2FrTDNQY29EcFdYZzg1VUsrRVFOazN1RVUvblFmOGZhc2ZFaVgybGUwcjRR?=
 =?utf-8?B?dVI3dkdmOUxzeHVyWDI1dExYenVqc1FTZnRhRzRsUTd4YmFKTmZlY2hFdnN4?=
 =?utf-8?B?YytIdFFhajRUK3VFc3NsbjhTTEZUckJ6cFpINzRXOXp4K2tDMklKcUEvektN?=
 =?utf-8?B?WlNPMHFXUGZhUG9ZalJTbzl5RmlTRTdEb1JRcVpLVEFYVFBvYXpHK3lWS0Zw?=
 =?utf-8?B?UzRqUGx1dm5qTlljS0ZYL1daT0k2V1plbks1bWJNTUp3aGd0K1htSWFvNkRQ?=
 =?utf-8?B?NFYyeENLVVlMdG80M3NlV2ZaNDF6aG93aEdqM0RpVDlVVnNGUXRLMCtVMGNE?=
 =?utf-8?B?eG83S0RFK3NoOEVYT251MXhERSsrNk9Ia05aUXRCRFFMY29EdkxyQW9aUngv?=
 =?utf-8?B?OEJVaHdvdlBHOFdEam1EVkFWOWtCNk8yUXc2OGk5ZUx0OFJ1WS9WVTNncUdw?=
 =?utf-8?B?TzRiMlJUTzlBYlBkL1JheXl0THpldkUxTjBKNVFmRGtsdW95WU5IVlVIRE5X?=
 =?utf-8?B?d25POU5wVFFMYUx2aUxyQ1hhZGFjQzR5MEtKQzNUaUFLdWtjV2lyQVpoUTZa?=
 =?utf-8?B?Yi9Od1Nyd2lBeHRvT3N4N1ZETlErdXBEaVA3QlZaT0tUWml2NUt3YjVqaWNy?=
 =?utf-8?B?NmpXVXRVSEJjUWJ2dllsSm9FdmVyU1p1SGJuVXkrY0pSK0FWTTgybHF2V2ZV?=
 =?utf-8?B?OTdScENqL3F1UDFtMUQydDV0dWdCZGtSQTlHR3liTmRrbmlaMFlRcFpteHpV?=
 =?utf-8?B?WEl2bUdSNDRtYVpiTitIdjhNV0NxSjBCM2kwbkx0YUErcmF2OUlVWWV3Q2dq?=
 =?utf-8?B?YlI0YjdUWkswYmw5bExTbysyeUdtYXVPZ1lKUit2Ymg4NjFLVHRHd0RGU2hD?=
 =?utf-8?B?OTJmUTBaSVl3Q29tRlhJWnQ4dXlreDJrNUpTRTRIVmo4SWtHUHg2bE80NFpq?=
 =?utf-8?B?ZDIzRlcxdnhFei9kemFla0ZaS0d2eGJRcVpNb2d5Q3NpcEFpdE1VUFFSNmRp?=
 =?utf-8?B?UGJvNm5ydkR0WmxkSHJGb255N3JZQkRMN0J0SmUxcFlreWxEUE95d1h3TE1z?=
 =?utf-8?B?aTl0ZnJGcGZYMXZCVWVPeVd2SnY1MENKMGJZcjl0d0ZKR3R4TEcyMk1uQmFY?=
 =?utf-8?B?SHVmclh5OFBKTm01OG5PVXdLZkluN09OMHhjOEgyUzRPRWh5a2lwb1Judkhi?=
 =?utf-8?B?b0NLeVgxQVV2K2NNQkx0TFJhTjI5cEpiVDhQK0Jzc2NsMkxqVEJkK0VEdVlD?=
 =?utf-8?B?MDBUY1F6aTd1emtGWFpwY2gwUHhqOGpqVmpOcFZ2UmF5STh4MFlwN3J4R1M3?=
 =?utf-8?B?dkJuOWJoUUtXZXhwN2UwVStpR1EzbkxTM0lHRkUyL25XQ1RBTkQxMzdTMnZ1?=
 =?utf-8?B?Qjk4WE1IOTI4MGFnL3NXbTM4ZWM4T25wSEhkY2ZUdmhySmRVRmVJd0I2MUVR?=
 =?utf-8?B?Yk0wQkI5c2hnQUF4ZVdyQjhkUGhuT3Rkeld0OVZsTk1aelBZT1ZhNmNWLzEv?=
 =?utf-8?B?ZVBkNnZtMXh6WGVZbnkwblJPaHRVK2x4OGt2T0o4SDQyY3VmVVA5dzk0QUpa?=
 =?utf-8?B?Nlo5cVZ0dXhaSFVyRGswMjdUZW1xVURnNExqRVZoWDlyZUJuMUR5TW51eVB6?=
 =?utf-8?B?YURiVFZSU3BOYkV1UUwzVlRsQWRTdU82V0JoZkxPTFlsZDhkQzNiUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c926ac-e704-4e3d-abbe-08de79cdccf9
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 09:09:55.1578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUTvPbSXQi90cRk6gUdaD8tkp2dKnyBGEEh1Pm2uPTx29LmapOocCQy//1OHpzXdP47lU6rOSrimMr/YY3EMNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/26/2026 9:59 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> No need to cast through the RamDiscardManager interface, use the
> RamBlock already retrieved. Makes it more direct and readable, and allow
> further refactoring to make RamDiscardManager an aggregator object in
> the following patches.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Chenyi Qiang <chenyi.qiang@intel.com>


