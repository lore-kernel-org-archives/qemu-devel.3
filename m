Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D9C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9FY8-0006wL-H2; Wed, 23 Sep 2026 01:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x9FY6-0006wD-GU
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:29:42 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x9FY4-00059t-Iu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790141381; x=1821677381;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q1FbG124FQieIySUvIorwonK3t1kSXGhKTW22fRM9hk=;
 b=dsacvsokCnTBD7Z9eDvYz8AMKsiKMjg2la27JZJcjVMEs0GRAOqiS7qN
 RlDb7QHT/J+gJB7Bhxn4zTynIuWRPJhrZWJI2J9pqJhyz6Uk4ZdwkZsGV
 nWHCRnPfJhwfGzl67pD2WPtgJSI65cKRgJFADPELG6OENHHD43Zr04A4Z
 EetV/DZkMD14lZcN6Ca5CWyMGu/ZTeKGooQmtxcghsqXHmvnME1w4HOok
 YxgusmC5rHEIOwHB2zlNGODy19mMsEko5ih1XHrBBDbwxztkNMzidtbui
 DP5wx5NvqFYyYkAmrg7G8cgkJImTpT5SENolGoux0qzDQ4R8KVyP3oYb9 Q==;
X-CSE-ConnectionGUID: EcHtLktORDeq9GowvQiVMA==
X-CSE-MsgGUID: 8Ju+lLAgTSK1LRe0L3PdDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90672691"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="90672691"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 22:29:38 -0700
X-CSE-ConnectionGUID: A12GGOp7TDShnSEiUDYCVg==
X-CSE-MsgGUID: de4jA+aBRl2q8FG+9NBTow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="281527242"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 22:29:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 22:29:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 22:29:37 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 22:29:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVbZmPJYZXQNt0XhTp1D2luQ2Mx3FmgI/tToKg6nq7LBgLENmsc0E4vAUoAdkX1H/G0EzS2TO0pbs2H1/LaTJQ9Td1+rrsVxDDqZavQz1haPeB0JrQn1LMCCORZcaPEuPjAakuvKnc9PrV7XsNxL1OIw1W9L5tZDxxF05h575SU71w2/fHAg6xnZTvFd81tWNH+P7paWHUw3JoQimmIcdcf+sAw2AyNnhHpaQdS0giGN8ABfqRiRorF8AD6ndCtAb0ONZ+fV2m21tXNOybW2z+y5SPYnUv0GsmFSsL5qJw+cjtKtsR+iW/QwHTI8ssXRnR0baW1s9MXYIysSNj9aDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1FbG124FQieIySUvIorwonK3t1kSXGhKTW22fRM9hk=;
 b=NRckBZsSXEGkWea89cNuVJuD32TBm8HW923Z5Rj+uovYS8tkQrofKUsKJSPsbMWEFQK4Q22AssPEGsQFlOk1/Xc3v/KWlh2XBR3bnDkk+2ZzANQ7nwdy5xzmeAIYav59aEFl8RSYm1HehXql4Cf2tcFGd0Ku5DtXZ8lKEGQQ/g4WfbxxCu755RzNbJjHVqHHLHJF+zBAMg9c9LsjjqGYozZTmESuu9F2EEdgHXDRDEMl6WSeATBigwgVG2UVmZgvCfTI9YdTjlhgExF0Ib2mpNLwRhukBMjmVqrqjBYjeT14PG6dLHNFnoRTiMoFU/x7lsyUxfuAopXW9UQkdE4hww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852) by PH8PR11MB9831.namprd11.prod.outlook.com
 (2603:10b6:510:3c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 05:29:35 +0000
Received: from SJ5PPFC295640A5.namprd11.prod.outlook.com
 ([fe80::80bb:e0b8:a9ae:716d]) by SJ5PPFC295640A5.namprd11.prod.outlook.com
 ([fe80::80bb:e0b8:a9ae:716d%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 05:29:35 +0000
Message-ID: <5beb6876-f523-4a40-bfc5-313c1e025bd1@intel.com>
Date: Wed, 23 Sep 2026 13:29:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <tomitamoeko@gmail.com>, <bosheng.xue@intel.com>,
 <junjie.cao@intel.com>
References: <20260922053658.2758332-1-yuan1.wang@intel.com>
 <9e8167d0-3072-49b5-b4c3-7f56c2121424@redhat.com>
Content-Language: en-US
From: "Wang, Yuan1" <yuan1.wang@intel.com>
In-Reply-To: <9e8167d0-3072-49b5-b4c3-7f56c2121424@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR03CA0002.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::17) To SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFC295640A5:EE_|PH8PR11MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 319c87f1-a92f-445b-5c6a-08df1933a736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10063799003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Ze+EgJ8tfGwQqMmrjH/n5b7ZRE2CK35yCNGhtuqa7j83wwMUbKv9JC5KACTn42m5aiJRfemnaiJgJP+PockIIg1T7RbNKPfFW6eBnDYR/ZT1anYuyDwuzCqIIoGtEExoxvUnmr0RFw12xgz9hvlB+FpnbQPVduBVYEXuNl/o9Ge7xQTDpW6PHBSUh6vkZSn+chId/Ti3o0yQ1i1yHgi63Vu3hniAJBRMDQvyoQTyaxZbQxr8InZFZgfnOPEh73ou74aEx7L1loM70DZzNimVkeKv2N/MaFxO1hJwIzyW4Ry7hCvVsHF5rbS+OyH+41grIwmaY+sxeCiXekOELfGIa4clW3o8bUJLLVa6Rdnen1qFhcQNbZlmmLrYjxu+jFcJsNz7Vf5dXp622poGehdkr9EC3ayIezPVS5fpPz0QYOBFoK+Xtfxa/Pq3gc1sRctgicOVq0O/gaNXxiGta1O+WGVpeY8JgjS58j2lKPGrzZEizoNPRHzQnzTwpqfAflpiQTny5WiFZmG+0Fnj+2I8aRlpnWa29AfngiYEl8kR9ZuuYYu+KndRLW9F+X6OqmkbwIjzWVxCDDifXdmL0+uB0Wjmi/FPtsEeR5atrZPc0amj0vQX5tbpQMuyD5TE5lUNsi5Ll7bt/L/MlhlKROAshm/bTU03T32ARVUrzJIMUjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFC295640A5.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10063799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW8xMGFDeGwzQmE2T3F2RnlIV2xpZy9sNGNkcjc4T1NBWDdsSlAzdmNEQjg3?=
 =?utf-8?B?RjZ5czI3L2hmOXMwaWNpaEFFWEhJZU9oU0dSRnlwS29qTTJ3TU1TTEFZQTVV?=
 =?utf-8?B?UG5HQVI1b0pYeU5NMk4wTWRBY0VoSWlvYWs2V1J4dmRYMC9rdENoc2NITlZV?=
 =?utf-8?B?Z1kzclFVY1FTWk5Qa3pqd3VENjBIU2pFN2FQZGVrZy9oOFg0Q25SMUd2S0dG?=
 =?utf-8?B?OFB1dGpZdjVFTi9DR3FTN242RVdtSzh0YnZsbFB4eWFvdmIybDN4UnZRaWlI?=
 =?utf-8?B?TFdvRS9FS3hPeXk4SS95clFuZmVUWi83SVAvT0NpVURBQ0RTR3dTcFYzRHNQ?=
 =?utf-8?B?UURDWkx3SzdLTnFZUDJRMXZ6UTlXajlGU1JzZzJBSUNEU2xXRk43VEhmMnRk?=
 =?utf-8?B?aituRTZvSmtPN3N0TW5YWTk0eU92QmFweERsZkRaODlCdXl5Y3ZFNTBnckN3?=
 =?utf-8?B?MDRJQ0tOd1pMU1RxRTRTWjFjNVNxVEx6RURwTXdtNExVUU1jUGQzZWpqeUNZ?=
 =?utf-8?B?emR3RXZGd0pZaWFyczNEM2xwMVJuTVRraEpWWDVUN0ZUNDdOYlJKdXNCQ0Zt?=
 =?utf-8?B?ekpFNndQQU51UHVjVDIxMS9KTlpRQXV6OFRKaEJjVXBoLzUyMzJBUVNiTy9J?=
 =?utf-8?B?R2NtWDh3d00zU21JRFltWnNvdVpkeWZRa3hDRmJtdlBJbDJaUC9WcWpvN3Ey?=
 =?utf-8?B?YmtvKzg3OHFJclZoREhYSHQ3d1RVVExUdzM5Z3d0Qkx4NjVsb0xFK1FlRFFV?=
 =?utf-8?B?Q05GeE0xQ0J5RmQvWEo1TSs5NVRVVEM1aFg2enhGTmRJWG15Y3FLc2V3RjNm?=
 =?utf-8?B?UUpCOEVCN09iMWtBdGVrMHFXTkl4azduek1kNEpjdExQUzZEU2lyMU9jdTZp?=
 =?utf-8?B?V2Q5Z2tZdmU3dUJZVVkyalhPcG5qd2U3ZGZZMzFCS0paUkxjaTJzWi9nVEs0?=
 =?utf-8?B?Q0ltQXNXRkR5TGFxNDhIeEtCTnZNU1Q3TjRwWHF0bnpoSWtjQThwV2VRait6?=
 =?utf-8?B?K0lsOFQrTGdSMmJ4Vy9EdzV3YUNaWDhjaGdXSUZJS2N0VG5kUDRDMHJEUjJX?=
 =?utf-8?B?VEdIeVdLTlFZQjNmUHV4RXFHOWVkVzBJUTFlQVpKallPVnc5UlkvUlI2WlVh?=
 =?utf-8?B?MmFlQzdTbWIxaFZtOHNlMjdBQXU5UEhDbEhwTnV4Qm9Ea0dHNmQ1ZUpNZlVv?=
 =?utf-8?B?NnIrVC9xMW5GemdrWGZCM2JHb1pnam1taGZnRlRBK2JlTUhySWRrSUVrRUVk?=
 =?utf-8?B?dXdsRmZDenZjalQ1UFNWNU1tT2ZQNFVxUW9SeFJOS1VpZjZjU0c4TS9oWi9N?=
 =?utf-8?B?ekFTeFE2QU1uelBDV25XYktRWUlTQU84b05lNWZTNFJ0dFpiTXRXWFZRV0dZ?=
 =?utf-8?B?RHV6L3V1d0Z4a0M3bXBtZHJaaUdqMVhEYUJkV3RWSmxXOFYySmhWSWdlbytP?=
 =?utf-8?B?aXcyWVpKd2YwaU56WHVEakdaN2p5L0ZWaFRxV2NOUkN3cDJVOVFQazZLMkRL?=
 =?utf-8?B?SG4zTUZpcHFlSytuRFBBb3Q0NGVpTG1EWG9TRzJXUkcvSElweTlXWHVTbStE?=
 =?utf-8?B?MXllS1I4d216akRzdjFsUHRLaEMyZGRVb1QrOHlOVXNqeTJtakVDTERSYXNQ?=
 =?utf-8?B?dmtZUFZlcFpwd2dZVU9acXcwOEo4Y2wyek9qWnMxKzR4UGRySXNaNGtzb3Zj?=
 =?utf-8?B?RzhVUGYvMWhoempObXh2bnF4elFuL2Irbmc5d2ExTWcwSWtrdnFvWjh3L1Jh?=
 =?utf-8?B?dUlDZDNNNyswOXhmZzBIemRkeENLM0l1eGFUVDVKcTkzejl0U3Z5VWJQU0JQ?=
 =?utf-8?B?R0NIOW90ZEt1dk0zaUNmRytCN3BGMUNDdzRhcmp6RG9nbFJoRFhCOU5PNDhm?=
 =?utf-8?B?NWFNZlVIYXQ0b1dkUkVjZkc5SUVPbC9SejNoMGZJZ3NkZCtjQzNKQWgwaEhu?=
 =?utf-8?B?UTFVa1VGbU10dmRZRUU1cTVYaTJ3QWhOQng4TXlWejZ3L1RMbHZNTFhlSnhl?=
 =?utf-8?B?N1RZcnV2b3BXbGdmcEFJY3F6b2NvUnVJSXVRanFTeUxwaWxXNUZKNHlLaVpx?=
 =?utf-8?B?bUNPQUNaVUV5K2FBdEE5b2pScjIyeXdhVVVhbFVDN0NHYzdTeGpLQ3dicXFq?=
 =?utf-8?B?ODJvTDhPcHF6WXk3N3NNL0w1cG9RcFkyWE9WSHdRSXNkdjRCYkd0Z0dUNERI?=
 =?utf-8?B?TGRaNHYvZnN0MHFwcmQ4MHJPSUxuRmVhZlVIeC9GQkVuRTZGQzJrRUhvRzYz?=
 =?utf-8?B?OE9vMzFJZVhrUUtNWExCVHRibkJzNkVLNisyeC9PWHBRWURkMzVQVFZHVkRx?=
 =?utf-8?B?VkRZbXNxKzljYzlsOGNTZVV2bTk4VGNzOFBSZkVJR1YvN3AzWnUzZz09?=
X-Exchange-RoutingPolicyChecked: B2vVh152b2gO6e0fJN3EFmoL+dEatiTD9mxaORSeOqUZglX/1pabtOlwX2qvhBZ8y+P42+uPZztKYWwOtLyl5DfXcy3jBv7qI6qfmjti94W8Z3brdMCkNTfFbVvF3SM+eig6056AaXGHHexwLaOTPcbRuOen1tPdffxoOEGmjtYFBKSe2yJXZWsmElGUY2MQEbOMXaazBnr3PmSOQVtNdhDE1xwtQcXEs/Xt87mVcqnDyG4Tb27v/FPheHlH1JHGdgx/T8xfDs9u9gtiT8i1eJQt5ApkOYm3+qmvf2Esd6x3gN356cmt13QNgR8ExOdUHzlSy/fMAV6ODwSCd8Imww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 319c87f1-a92f-445b-5c6a-08df1933a736
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFC295640A5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:29:35.5503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGmQngxFzVf3biQCy/oF2unOiNlHxyKYQsplOdEwViAoPob4qP1ELzyJH4SPcnsoKYi7ENLg5UBfQaR4GA2WNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9831
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yuan1.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 9/22/2026 5:56 PM, Cédric Le Goater wrote:
> Hello Yuan
>
> On 9/22/26 07:36, Yuan Wang wrote:
>> Meteor Lake and Arrow Lake GOP can read BAR0 MMIO offset 0x138914 to
>> detect whether direct framebuffer access via DSM is available.
>>
>> In a VFIO passthrough VM, the guest cannot access the host DSM memory
>> region via such a pointer. If the guest GOP enables that path, it may
>> hand off a DSM-based framebuffer address that the guest cannot actually
>> use.
>>
>> Intercept reads from the detection register and return 0 so the guest
>> does not enable the DSM-based path and instead keeps using the standard
>> BAR-based framebuffer address.
>>
>> Suggested-by: Tomita Moeko <tomitamoeko@gmail.com>
>> Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>
>> Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
>> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
>> ---
>> Changes:
>> v4:
>> - Address review comments from Tomita Moeko (update macro/variable
>>    names and comments).
>> - Pick up Reviewed-by tags from Tomita Moeko and Cédric Le Goater.
>>
>> v3:
>> - Emulated register 0x138914 to return 0x0, which signals the guest
>>    GOP driver to fall back to BAR-based mapping since DSM is
>>    unavailable in the VM.
>>
>> v2:
>> - Resending because the v1 patch was sent with an incorrect future
>>    system timestamp due to an unsynchronized local clock. No code
>>    changes.
>>
>> Notes:
>> MTL/ARL device IDs remain in igd_gen().
>> This is required because vfio_probe_igd_bar0_quirk() checks the
>> generation before installing BAR0 quirks, and the 0x138914 quirk
>> is added afterward.
>> Meanwhile, we also plan to remove the bdsm-size check in the OVMF
>> offline patches.
>> ---
>>   hw/vfio/igd.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 46 insertions(+), 3 deletions(-)
>
>
> This change does not apply cleanly on :
>
>     https://github.com/legoater/qemu vfio-next
>
> because of :
>
> https://lore.kernel.org/qemu-devel/20260724102959.1043264-1-mike.malyshev@gmail.com/
>
> Could you please resend on top ?
>
>
Sure! I have rebased the patch on top of your vfio-next branch and sent out v5.

Please kindly review the v5.

Thanks,
Yuan

