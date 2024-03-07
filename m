Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601A3C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 07:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8JM-0006mX-It; Thu, 07 Mar 2024 02:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1ri8JK-0006fZ-IV; Thu, 07 Mar 2024 02:37:02 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1ri8JH-0004ey-Eb; Thu, 07 Mar 2024 02:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709797020; x=1741333020;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=dBbrDEzcENO/rshE7xqMYGC6VOqX97qdsx44Yg2jAZ0=;
 b=JXfOCwV3EfIFZKKXsuz9NUr1QTiw76P5Htt6xG828fT9Rcpb2Y7P8bnZ
 55uJ4M++JSyR6P7b3mahqj+xFQYpFmKELyCSZNrIXcs31+HuWRQb8rF1I
 YTE+1HzQWBKH1+ILqeBw5YW60uwO++8iRUnNrPKE//AoPtL6CsnKNExM0
 q34jlGZy+MlzUFQaqGUNKmSYnOvBJ4vG/ekw/ZyeRIMXHk+m3f8+vy84K
 /PWshaDgBlONePhnAbwnRWO3HtOMUvmmaZs0dDlcm1Nqyx35zfc5FMKZ0
 02nYWQgtT+g3PRucvwKh0RUiliHBdHUerNTDAa5zK4YuStRw4WQ2wIthp g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4573367"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4573367"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 23:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; d="scan'208";a="14681834"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Mar 2024 23:36:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 23:36:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 23:36:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 23:36:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 23:36:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiSOcuQycBGMI0nmFIJfHAoK/8LxTKaYhbOFfWFZErgbqV89f3LKTZAtuQ4TtiMvj/nhOJBolwep1MZxziZettiuh3elowxMIPivsH8y16gkdUm/vnCOXmSrYHJzo74rvgZnjPAWsPvN+HzIZZXnu5yPZxc/bpC+6qvGrzDGwI7DonVPiZR62Q9kkeBEPM8FNN8RUYpglLDDFVi2kZif2EuKpFAJHyN6uCwuljAsh4WCqq4/zJ+UEayIloagJNC5QJb8Kp3ZhrGZhHfJvQJq3295hQoIuBrhIDhDx/6PsCv6HucTTCBO+x4e+Sg070TJyzhDpexS/NqtU4gRpGEwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBc47/kL8JO+WzCjTQzIDv6dRDqnpqlEHCQBYRO5uDU=;
 b=og81H7bfl2sBQljCxrY5y0wXT+CUnD3jXxyyMMgA1OfEZuRGX7yjhPvb2qgtGM4UcOjsagbffzcdXRkAwVcxA9mcG7M30guFHq4JkwkzZw1KFxhrkHFlOG2KWvzX15jbCnw63mbwxHpzyF/PXLUO8e4nYx6QjaVsOMQ9H838jEYTQh9XP9cre/p5Syug0i8+jdjFHcpSKfWRJnwdD0sA7M462YIoE27Rzv1qOWWNiXwoofMmv+dukvM4yNHRCIGBcA7HPw4ypkSUyO1w9O+vLyORmnsAjJ/SkpgLpHaeGD1fqGyiJ32p0+Xhm5Qwb8jsfI/vQDnvZjdrFcZaqzCs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 07:36:47 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 07:36:47 +0000
Message-ID: <4e16f394-fe9b-4edf-80eb-fc3220bcf6e1@intel.com>
Date: Thu, 7 Mar 2024 15:36:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RISC-V][tech-server-soc] [RFC 2/2] target/riscv: Add server
 platform reference cpu
From: "Wu, Fei" <fei2.wu@intel.com>
To: <tech-server-soc@lists.riscv.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <andrei.warkentin@intel.com>, <shaolin.xie@alibaba-inc.com>,
 <ved@rivosinc.com>, <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>,
 <evan.chai@intel.com>, <yin.wang@intel.com>,
 <tech-server-platform@lists.riscv.org>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-3-fei2.wu@intel.com>
 <bd34501b-3dda-40eb-aa92-73ea289297d1@ventanamicro.com>
 <8ad091f3-c00f-4786-a89b-799304eace73@intel.com>
 <56448108-c655-4684-bab9-b8d7747f79f7@intel.com>
Content-Language: en-US
In-Reply-To: <56448108-c655-4684-bab9-b8d7747f79f7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: ad39cadd-8c8a-4408-8732-08dc3e795825
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyd6c8DcUuW2sLp780xgNFbiAnd6U/3noBBGL+QLKiMjkPcYcA+MnC8J9sCf+csVdtUA59jNz6/5w8QKSBAdgjh86YjQSFK5i/OOC+fyVCPpSKVl30BVp+aWXakDqkLVCLDO4hXy8Ucld6pcmgzJzihbTbLbYrtqDvg1HQDUPFVyphZJFV4a/ACANfFXoGyozam8rekOuVEwUBchDMLL6/6URm6ZIMN2XFPikJeK9GSrbjzJohtCrIulSAFZ4BrQEhFnQ2N6M2yXRHu39cJSWzKN8VF3MyPmzadVHn10duAkI0OS2RzJg175ml7p3VsFi0lWtSODviu3m0ITcBVGc0Z5LeQadUo4hdg0Bd5x2MyQXrYOILhJ7XKvS1SpnBGgTInVUjVNNJb4F7gAP79yghNEdnoiNahZIeWZyRHXPfb5urKuvIZawPeshO+3srd1XsBt5VxrM9tIqVZN5a2+VXrIn48BQfsWMmajUO5ZklTeBN9yo8x4p3mQAziTyFi/iVoziCUi9PAU/gY5eao3w4EFVmtCofhyBnV/+NGFqGFe2gufbD9YUpRm0EcP3mIH/YoJasxFc+ZrmrvWQJnowBo6NbxwW0FtLQ0FO+Zw8Scnog1kKFzIt/Zq3ZSDNc9M3IRGuNrpSoGCeNTMIv/ag4UETZUR+y7o7op8AjkrOng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(921011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRXS0NROVVJVnJLU0w2UnhTTjZqZWhOR0RnemN2cWphY29kVFY4ZG55Mm5j?=
 =?utf-8?B?RmVyNVpIMUhpc2xaNCtJaWpmMmxlMkN5ZzEydWx2QTM1QnVzN2J1UW1jNTBL?=
 =?utf-8?B?RUdTSU1HRjJwdWhxOEsxZDdDaEViZC90MmZ3YjdwTGxNMmpmVUZWOVIzV1Jv?=
 =?utf-8?B?MDVtckh0ZHdJY0dCNW1WNXBhOVZSdUNUTmRrN0xEalRsdGxkSnRDdDVoQnZm?=
 =?utf-8?B?d0ljaVhrRHo3NDRicWRGQml5L1hFZUJhb2ljeFRJRkovbDQrYVZNWkhtbzJV?=
 =?utf-8?B?ZTlMSGVXWUZ5ZHRwOFJDS05rZ3BEcFdEUldxVGkvb25xK0J4OFJyUllqNElG?=
 =?utf-8?B?ckRVRW9UTjE5YnplSnZ2MU9rU2NROGFWOG82eUhWL2NRR1F4TnZWcStYaUFP?=
 =?utf-8?B?M2ZaYkJYNE1WWm5HZ2xKcDVldzkrTXdCQ3UxNm9qNmZYU0dhK1NYSnc0aU5O?=
 =?utf-8?B?clh0MmkrZFBoTDk4YmpDeWZBSnFrT243Z0VTcXRveTNRRWhQenhHY3RYTFN3?=
 =?utf-8?B?NDRCaUd6QklNWERxRzVucEpaR1NIU3MxTzB2R1RBTXlMbDQ3SGowalJpQXNz?=
 =?utf-8?B?SnZQWWNiSUxTWjJ2SkkzNVJTeitTbjQzSlhTNURuSThkL3laRTJiaGpmWEFL?=
 =?utf-8?B?UjFxZGRRbWpQeUhZbWZLVkRNOS8rdmsvK3FBeG9INlNZYUNzbjk1eVhxSFU0?=
 =?utf-8?B?K0U3MEtCcnJBUzdYMTV1NE1nSy9IMGlYWVQyNnpSUno2aXVuUTFRYnhRNTQx?=
 =?utf-8?B?N2NZOXpkSVRtVHZmMkFIUjdGMTJIeDV0aXRuV0ZDdjk4M0U0ZmFSVzg4a2ZP?=
 =?utf-8?B?by9pZk9peExUYjlDczUydFRudTJZUk1nR0hNdHJHd2VhK3gxZVZEOFRuRFg2?=
 =?utf-8?B?WEtNK1AyamFRRGRlcGhNeGJ4TXpqdVVESmd4S2J6U0tTRXVpNm5lS0JJQ0x2?=
 =?utf-8?B?TkNER0QwYndrU2hoaWZJYXc0anNGTWFDNFQ2TG5nN0xqRHY4Uk83YTRCZERT?=
 =?utf-8?B?ZUpZeUhKenI5VnpCRnArODRJTDVOU1paR1dQL2xjcGQvRUc1ZjRtbUtwRnNi?=
 =?utf-8?B?Y2RXMWE2V2FnY1ZFRDFBdVFPb3lWOVh2NTVjSFkxMFhrb0c0ZnlqeFNBN0Yr?=
 =?utf-8?B?bi9yZk1vRXdHVW8xWnQ5YjdneHY2QVFpL2VCU09TWHZwb05RUUR6YlJaNjU1?=
 =?utf-8?B?c3RFdFZ1aGFJVmlqc0NGdjhCdnpDc0ZLTjkxN3VIUUwvc2gydlV3aDJSUm9U?=
 =?utf-8?B?WnIreEpWVWJvZjlpSjh5Y21PTU00VVBRdGtrSkhDZWx3OXpnQUdsVHRxeXJF?=
 =?utf-8?B?QlJiRFlMOElKT2I1blBOUVd2NlBCYjkvS0NoVkhrN0Q0SUlKcDRFdno2ZWNX?=
 =?utf-8?B?N0wrMkQwTnprbk9FRUoyMzgyR3Q4NEl3N3dacFYzRFM4YXI0U2xzOEV2NFhh?=
 =?utf-8?B?aHBsbCt6eElWbW5LL1JNaTJNRWFyZm9lOTROTUlPV0ZvS1kraDY3aDlsaW0z?=
 =?utf-8?B?V1d3Y0t0ZkQ1d0twSXo5QTMrTTAvMjN1eW45UFdtbEVEK0t3cTFXMTdPcEFS?=
 =?utf-8?B?cytZSXBZZTVabUdHSVQ0OVp0dDU5MXBjRzdSSlAvN0h1K1E1NHpXU3RiTFJ2?=
 =?utf-8?B?ZC9acjNiMVE2SmEwWEtXNmE2SmdSVXZyci9pZk9VTGhUM2Y2dTljMFZaUGU3?=
 =?utf-8?B?ZXVUQXRaTmxieC9OZkZ5dzNkSkx0b3pGVzd5SGQ3OHFUa0FraDVVVS9QajlH?=
 =?utf-8?B?OGYrd3k4RFpPOVN1bnowMGRUcWtxZTc3Z2g1NVB3cWk0OWxqMFU3aGYvUjBh?=
 =?utf-8?B?RjVSbHRva0FqdDM2ZzVOdUhQai90TU93ZUQ4MnUrMzBJc2ltZWFtVlI3UVdv?=
 =?utf-8?B?dHhacHpEZ0dpdFNHZU1ia0xGZ2RLak1LY0dzTndpYTU2VndDcW9tNzNQYkRB?=
 =?utf-8?B?ZFUrSnMvZmJZbU5TdmdabDB2RnQvMk5qb2FDS3BJbGZaSkhvVzVnR1VnQTFv?=
 =?utf-8?B?Wjc4ZE9EcHN4dWRINW5wVm9RMjlGKzZ6VnErTzBFSVA1am0rdnM0eVdmZjFu?=
 =?utf-8?B?YUJJQ1JXdkF2WldtckR0UnhMbnpDaFNoUkNiVXl3bmgyd0wvMVVzLzJ4TzUw?=
 =?utf-8?Q?t9OOwT3koHQRN/Ljca+Q8cG8D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad39cadd-8c8a-4408-8732-08dc3e795825
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 07:36:47.4375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDRlirKClTHfr5+vj4iMI5YHq6KJb7P0hpCXzfCHzJawgl9qwT3n+wqWCDdXtTtO4YOuI1nbtkluriTzkpIhiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
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

On 3/6/2024 9:26 PM, Wu, Fei wrote:
> On 3/5/2024 1:58 PM, Wu, Fei wrote:
>> On 3/5/2024 3:43 AM, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 3/4/24 07:25, Fei Wu wrote:
>>>> The harts requirements of RISC-V server platform [1] require RVA23 ISA
>>>> profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
>>>> a virt CPU type (rvsp-ref) as compliant as possible.
>>>>
>>>> [1]
>>>> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>>>
>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>> --->   hw/riscv/server_platform_ref.c |  6 +++-
>>>>   target/riscv/cpu-qom.h         |  1 +
>>>>   target/riscv/cpu.c             | 62 ++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 68 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/riscv/server_platform_ref.c
>>>> b/hw/riscv/server_platform_ref.c
>>>> index ae90c4b27a..52ec607cee 100644
>>>> --- a/hw/riscv/server_platform_ref.c
>>>> +++ b/hw/riscv/server_platform_ref.c
>>>> @@ -1205,11 +1205,15 @@ static void
>>>> rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
>>>>   {
>>>>       char str[128];
>>>>       MachineClass *mc = MACHINE_CLASS(oc);
>>>> +    static const char * const valid_cpu_types[] = {
>>>> +        TYPE_RISCV_CPU_RVSP_REF,
>>>> +    };
>>>>         mc->desc = "RISC-V Server SoC Reference board";
>>>>       mc->init = rvsp_ref_machine_init;
>>>>       mc->max_cpus = RVSP_CPUS_MAX;
>>>> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
>>>> +    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
>>>> +    mc->valid_cpu_types = valid_cpu_types;
>>>
>>> I suggest introducing this patch first, then the new machine type that
>>> will use it as a default
>>> CPU. The reason is to facilitate future bisects. If we introduce the
>>> board first, a future bisect
>>> might hit the previous patch, the board will be run using RV64 instead
>>> of the correct CPU, and
>>> we'll have different results because of it.
>>>
>> Good suggestion.
>>
>>>>       mc->pci_allow_0_address = true;
>>>>       mc->default_nic = "e1000e";
>>>>       mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>>> index 3670cfe6d9..adb934d19e 100644
>>>> --- a/target/riscv/cpu-qom.h
>>>> +++ b/target/riscv/cpu-qom.h
>>>> @@ -49,6 +49,7 @@
>>>>   #define TYPE_RISCV_CPU_SIFIVE_U54      
>>>> RISCV_CPU_TYPE_NAME("sifive-u54")
>>>>   #define TYPE_RISCV_CPU_THEAD_C906      
>>>> RISCV_CPU_TYPE_NAME("thead-c906")
>>>>   #define TYPE_RISCV_CPU_VEYRON_V1       
>>>> RISCV_CPU_TYPE_NAME("veyron-v1")
>>>> +#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
>>>>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>>>>     OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index 5ff0192c52..bc91be702b 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -2282,6 +2282,67 @@ static void rva22s64_profile_cpu_init(Object *obj)
>>>>         RVA22S64.enabled = true;
>>>>   }
>>>> +
>>>> +static void rv64_rvsp_ref_cpu_init(Object *obj)
>>>> +{
>>>> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
>>>> +    RISCVCPU *cpu = RISCV_CPU(obj);
>>>> +
>>>> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
>>>> +
>>>> +    /* FIXME: change to 1.13 */
>>>> +    env->priv_ver = PRIV_VERSION_1_12_0;
>>>> +
>>>> +    /* RVA22U64 */
>>>> +    cpu->cfg.mmu = true;
>>>> +    cpu->cfg.ext_zifencei = true;
>>>> +    cpu->cfg.ext_zicsr = true;
>>>> +    cpu->cfg.ext_zicntr = true;
>>>> +    cpu->cfg.ext_zihpm = true;
>>>> +    cpu->cfg.ext_zihintpause = true;
>>>> +    cpu->cfg.ext_zba = true;
>>>> +    cpu->cfg.ext_zbb = true;
>>>> +    cpu->cfg.ext_zbs = true;
>>>> +    cpu->cfg.zic64b = true;
>>>> +    cpu->cfg.ext_zicbom = true;
>>>> +    cpu->cfg.ext_zicbop = true;
>>>> +    cpu->cfg.ext_zicboz = true;
>>>> +    cpu->cfg.cbom_blocksize = 64;
>>>> +    cpu->cfg.cbop_blocksize = 64;
>>>> +    cpu->cfg.cboz_blocksize = 64;
>>>> +    cpu->cfg.ext_zfhmin = true;
>>>> +    cpu->cfg.ext_zkt = true;
>>>
>>> You can change this whole block with:
>>>
>>> RVA22U64.enabled = true;
>>>
>>>
>>> riscv_cpu_add_profiles() will check if we have a profile enabled and, if
>>> that's the
>>> case, we'll enable all its extensions in the CPU.
>>>
>>> In the near future, when we implement a proper RVA23 support, we'll be
>>> able to just do
>>> a single RVA23S64.enabled = true in this cpu_init(). But for now we can
>>> at least declare
>>> RVA22U64 (perhaps RVA22S64) support for this CPU.
>>>
> 
> Hi Daniel,
> 
> I'm not sure if it's a regression or the usage has been changed. I'm not
> able to use '-cpu rva22s64' on latest qemu (db596ae190).
> 
I did a quick git bisect and found that commit d06f28db6 "target/riscv:
move 'mmu' to riscv_cpu_properties[]" disabled mmu by default, so that
an explicit mmu option should be added to qemu command line like '-cpu
rva22s64,mmu=true', I think rva22s64 should enable it by default.

Thanks,
Fei.

> -- latest qemu, cannot see linux boot message and blocked
> 
> $Q -machine virt -nographic -m 2G -smp 2 \
>   -cpu rva22s64 \
>   -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>   -kernel $Kernel
> 
> Boot HART ID              : 1
> Boot HART Domain          : root
> Boot HART Priv Version    : v1.12
> Boot HART Base ISA        : rv64imafdc
> Boot HART ISA Extensions  : time
> Boot HART PMP Count       : 0
> Boot HART PMP Granularity : 0
> Boot HART PMP Address Bits: 0
> Boot HART MHPM Count      : 16
> Boot HART MIDELEG         : 0x0000000000000222
> Boot HART MEDELEG         : 0x000000000000b109
> 
> -- latest qemu, w/o rva22s64, looks good
> 
> $Q -machine virt -nographic -m 2G -smp 2 \
>   -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>   -kernel $Kernel
> 
> Boot HART ID              : 0
> Boot HART Domain          : root
> Boot HART Priv Version    : v1.12
> Boot HART Base ISA        : rv64imafdch
> Boot HART ISA Extensions  : time,sstc
> Boot HART PMP Count       : 16
> Boot HART PMP Granularity : 4
> Boot HART PMP Address Bits: 54
> Boot HART MHPM Count      : 16
> Boot HART MIDELEG         : 0x0000000000001666
> Boot HART MEDELEG         : 0x0000000000f0b509
> [    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
> (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
> Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024
> 
> -- commit dfa3c4c57, patch to enable rva22s64, looks good
> 
> $Q -machine virt -nographic -m 2G -smp 2 \
>   -cpu rva22s64 \
>   -bios /usr/lib/riscv64-linux-gnu/opensbi/generic/fw_jump.elf \
>   -kernel $Kernel
> 
> Boot HART ID              : 0
> Boot HART Domain          : root
> Boot HART Priv Version    : v1.12
> Boot HART Base ISA        : rv64imafdc
> Boot HART ISA Extensions  : time
> Boot HART PMP Count       : 16
> Boot HART PMP Granularity : 4
> Boot HART PMP Address Bits: 54
> Boot HART MHPM Count      : 16
> Boot HART MIDELEG         : 0x0000000000000222
> Boot HART MEDELEG         : 0x000000000000b109
> [    0.000000] Linux version 6.8.0-rc6+ (box@riscv-sw-lvm-1)
> (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU
> Binutils for Ubuntu) 2.34) #17 SMP Wed Feb 28 08:38:42 UTC 2024
> 
> Thanks,
> Fei
> 
>> Let me try.
>>
>> Thanks,
>> Fei.
>>
>>>
>>> Thanks,
>>>
>>> Daniel
>>>
>>>
>>>> +
>>>> +    /* RVA23U64 */
>>>> +    cpu->cfg.ext_zvfhmin = true;
>>>> +    cpu->cfg.ext_zvbb = true;
>>>> +    cpu->cfg.ext_zvkt = true;
>>>> +    cpu->cfg.ext_zihintntl = true;
>>>> +    cpu->cfg.ext_zicond = true;
>>>> +    cpu->cfg.ext_zcb = true;
>>>> +    cpu->cfg.ext_zfa = true;
>>>> +    cpu->cfg.ext_zawrs = true;
>>>> +
>>>> +    /* RVA23S64 */
>>>> +    cpu->cfg.ext_zifencei = true;
>>>> +    cpu->cfg.svade = true;
>>>> +    cpu->cfg.ext_svpbmt = true;
>>>> +    cpu->cfg.ext_svinval = true;
>>>> +    cpu->cfg.ext_svnapot = true;
>>>> +    cpu->cfg.ext_sstc = true;
>>>> +    cpu->cfg.ext_sscofpmf = true;
>>>> +    cpu->cfg.ext_smstateen = true;
>>>> +
>>>> +    cpu->cfg.ext_smaia = true;
>>>> +    cpu->cfg.ext_ssaia = true;
>>>> +
>>>> +    /* Server Platform */
>>>> +#ifndef CONFIG_USER_ONLY
>>>> +    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
>>>> +#endif
>>>> +    cpu->cfg.ext_svadu = true;
>>>> +    cpu->cfg.ext_zkr = true;
>>>> +}
>>>>   #endif
>>>>     static const gchar *riscv_gdb_arch_name(CPUState *cs)
>>>> @@ -2547,6 +2608,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>>>>       DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64, 
>>>> rv64e_bare_cpu_init),
>>>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64, 
>>>> rva22u64_profile_cpu_init),
>>>>       DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64, 
>>>> rva22s64_profile_cpu_init),
>>>> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64, 
>>>> rv64_rvsp_ref_cpu_init),
>>>>   #endif
>>>>   };
>>>>   
>>>
>>>
>>> -=-=-=-=-=-=-=-=-=-=-=-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#125):
>>> https://lists.riscv.org/g/tech-server-soc/message/125
>>> Mute This Topic: https://lists.riscv.org/mt/104719379/7152971
>>> Group Owner: tech-server-soc+owner@lists.riscv.org
>>> Unsubscribe:
>>> https://lists.riscv.org/g/tech-server-soc/leave/12737993/7152971/1793629631/xyzzy [fei2.wu@intel.com]
>>> -=-=-=-=-=-=-=-=-=-=-=-
>>>
>>>
>>
> 


