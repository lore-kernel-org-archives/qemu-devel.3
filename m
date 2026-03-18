Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CCB103E171
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2qAK-0002tc-Nc; Wed, 18 Mar 2026 08:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2qAG-0002sl-19
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:38:20 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2qAA-00049s-0m
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773837494; x=1805373494;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=saN8saodrmbVdKX8pWh2n+hsVBbXwiQpmXiIeXkjGqE=;
 b=a16NCy2P1nNfodO1GEMgxjin7kFDEdjemcZjQZD1S6xF5wn+P9AgKCb3
 RYzOVdkcCtWO33VCmtXGINE/klNYWGlQEHl+uW7Z9HzSKTblalwAF8oc2
 84TlxlZZQ+VbmGNY8s/MhKaC0hzo+F1VBhIu1ishdFXt+SjevpDDalXC3
 Dwixv13GKd3QbrK7HuA4ERakdDreSHwaSyjqBVHDOruWZTSwG+VfMLqhD
 e1ozv5uCxqZoJh6vgMBQ/ZZrUpdLOq7VJJ4GljZQbHo5RxDtjJl7/LOtJ
 3yV+/ePuGEECV4crIKlN8I0hGuhmD1Wdc/2vRA0RYe7EjJLpPupdgrkTa g==;
X-CSE-ConnectionGUID: 2avHu1BRQeORAI5+6Iaddg==
X-CSE-MsgGUID: IWdwP4qyRGur60OqrbPeUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519098"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="85519098"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:38:11 -0700
X-CSE-ConnectionGUID: URlcsWwZRsyf6EEBaz8/TA==
X-CSE-MsgGUID: n5WXY22+RmSXxZoK3lRUHA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:38:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:38:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 05:38:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFsA1aDbQRVp9j1gako6Yoi7LSW5fKS6LM9nLmOnLoOZUNF7gDc3a1QbyteUaGZuKmxM1Uhu/Ft0rb/RBJMJkU2FULdxaWBHHETENsJLiKGXAFx0L8/0eStdN/er2E0nMpldPKrXnFBXGkj2wFX2QRxbSEvKwE7kVbN8uhKsoCg6Hdv7tRGju73F5+D6YBmp0y011AEBrhPRcw+3UWfj/WeBCfzeOtjVJUV/jJApDClzqK7nVGnSBYySwZJGIMJNaee4XZewvLtAJn3C1xCi4f6ebvwGhn3PV8d83DGQEyRadgfLyUl+EnUxfw9c3KAaMfuy282oCFteOImI+H1pSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF6EhPD5/L0jCyKB0XQYehk86F01/ksmLtri5/nDtYs=;
 b=SjK6HUUXor1Omno/hwWK7EVoXFe9DYgvkqeO6fmduBn/MDxi1zHzBWUO6dc+RDw234f0A0b7tREB/O1LwI5yO0cDGJjwg0htPd01dfGEZ48hfhBj5s8bqrlfBYeWUKndkI5InTWx9eEZCJtZcbEVeMMt/y25SYehYwGR63bi9ImY7/rr2eWtxS/WmV2aQB9xR7cUxSfJT+iqwqc9DoDbYNVliZWe1iZXpF6aCK0YB/GabbnEAkhJD7G/snT2gHAjs1eu2ntTfcR37UQjjCeiJOrc0prjp/Q252Yl1OB3DWlrStxKWTNW9zpcsO3L7LW/xEToFR5nqaivRshrHvpljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 12:38:07 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:38:07 +0000
Message-ID: <2f49aa5c-4139-4c81-93f5-288a6a6c6249@intel.com>
Date: Wed, 18 Mar 2026 20:45:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/vfio/iommufd.c: report hint to user when
 vfio-dev/vfio*/dev is missing
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <qemu-devel@nongnu.org>
CC: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex@shazbot.org>, Eric Auger
 <eric.auger@redhat.com>, <philmd@linaro.org>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH7PR11MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: e77fddb3-458b-455a-d4eb-08de84eb34ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|42112799006|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: 3virL7Ny3CxpwDwvKijHCTdyYzYVMqGr1S0yeTgH9o76BUMe1xl2iC+yx9ak8yXHeI2A8AXGxinUmvCFY9dFIWrAOCo432rJCCjpA2PQuzMVwRX31z2gRfR1Pu/FREGQH1v3YXEeSSwvl1kQ3R5ZSIjcQaRF+CEKZRKGcV4HrnhHmF0rYTTYjRj6o72Quxjd2JVas2QDPKd+laUPRFp6Iw0ZgL5d3I5r5kE33SnaO4AIf09aM3psr9My0ZmFmwEPfRdCL3LzopICekveorRXAXne0NAXafwj19sW3lNH6FSAz7fRRq3bCImQ3YoOsoovS1hCMuH20PvfWqFvcUrUhNugGJhWD8hiLc8WO85IGI9w5uxwZ9DZVAN1syQF7Ow2bxA7TpEzmtkLhGCxXkXT/WnZ4sOZkaif+/eldXJ9d9qpbrWvf1e0zxJM59U5HtyZ1YNoxtAYef0Em9MCoobke7V9RGw1E3uH1Bs2DKdP1tyCnpRd9avKbj3H3QfomYFxUWtmvwgdRlWSAGUKm92xq/wQsA4ik4Yp5/EZ3YLhGy4+eT2lVt7Mxc/MO60bipvBDNXbjXP2kC/BKoCUwGNWDC3FTBC63LjNoLUzWZa7cVkwthETIwc4QcZnmEx7Tvk1Q6PeWsbCYtpvTNCQk3Yt6sBVa+9FthawLr06daxid/lQK2WyBmyzQ0koGiELsKFIfVE0/v7EcLTo44YGeBGVgG3af9Gylv9A1C+MqEsrhsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(42112799006)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzB4V2lLTHNFS0FBK3ZQSXR5bThpbVgrK3dlR0xrTmFrcU5BajdNc3h4NFlx?=
 =?utf-8?B?VE14T3NXRFRnUzZvcVNZaEJoMGlYclEyTUtIOHcrcVB3eVpQZU00NXNSam1h?=
 =?utf-8?B?UUNzWHJTUzd5UXd2aU1NZjNpUHVsNDdTVFMvTWxtcW8vZUFYVVcramFwSUpY?=
 =?utf-8?B?eEdXWDJVRmF6RDRBeUNJb3hvWjhzVzQ4YmdRWGNBWERCU2JiVGtuTDAxZHRZ?=
 =?utf-8?B?WlNCMStjVFAvREpBQUdlZG5Rai83aDdhTm0vcWtkajhKWEFadGlLYTVoT0h6?=
 =?utf-8?B?WGpiRTM3OThGQnRhaVZCaVF3Y2puRnVaSlhUa1psa1l1RDdveWVIbm94Wis2?=
 =?utf-8?B?bmNrQVhhZE02cnRLZm90NUdaeCszV3N2WmkycVNJN1p4dlBXZmJieTU3bE12?=
 =?utf-8?B?ZmVtUjQ4UTQ1ZU82V3BnRDdJSDdNbmloQXFsWlB3MVVMdms1QVZWWUQrTnVS?=
 =?utf-8?B?OG52NExJYXN3RG52c2VDL25WTTQ2NWtlWnp4dEtneWFJODFJaHRtdUU3clBq?=
 =?utf-8?B?WSt5emNEVjBuWURDYitma1dvRU9BZktncTRiaVU4Q2NFaHVrQVVOc1lPYTBm?=
 =?utf-8?B?c0RiYW1qQ2lEUDRCVTV1L2hpbkRuSXlPU0xXOXkzNUkzRkV5citYMEF3Q0Ir?=
 =?utf-8?B?OHhkY05tYmNYN1k5K0ZaU283Zy9GdmtqL0lOK09rUTBaajBLSkFhN09YcXBm?=
 =?utf-8?B?emNvSlRMSFF2T2VIYjc1YVdHWHhyRWx4RUpYWURtUU9ZNkZwRlJsQVZxNEZQ?=
 =?utf-8?B?VXdRd3RhSkJnU1orYzF3ZVMvOGJJa2lmUWErUGROd2d6UnFYbUdpOFFGa3VY?=
 =?utf-8?B?NWxVdkptZERZWXhyNEtEalBKSndNcDRDZU5kbXgyVXFJdjlhN0J1VVl6d3Ey?=
 =?utf-8?B?T2phVUg1NlN3V2RVOU82ekF1bTg3NStOUkdiRjFmd1J3Q1hFOXRaMEJBZE1a?=
 =?utf-8?B?UVc5QlRKRmJjbHlXeWZIeGFEdXNsd3NBMGl3a2F3WkNBQXBucFVJOWV3R0dT?=
 =?utf-8?B?dUFzazRabGFKK000bFoxTWI2K250bWgxaW14NGhwY1VNbmtLWW4yNC8wRWJU?=
 =?utf-8?B?NXVJZ2hzTklRZjhMY0tIZ0NmT2Z0SVJJOGFwRDlXZ3ZhcUpQYmh6R0Z3ZnNj?=
 =?utf-8?B?dmxPbm00ZklmSko0SFdnaHV0MndHT3BlalJTVEFXMU1jYVEvSzFkNm1GTXVR?=
 =?utf-8?B?VjBMSXZWalhaR2JSR0hJSHB6ZVU0cndER3p1cXhDYjdSWkY0VU5samVjd2dI?=
 =?utf-8?B?eXJHNlcxaWEzd1J5LzNsQUhQRGtCWERoc0NlRGFETjVGUUwwcXdubzRiZ0xl?=
 =?utf-8?B?NXJicHUzR1A3a0hTQ2pvV0ZqaWJXdDBrWWJlQVBhSEVna1J5d2ZIWitLVDgy?=
 =?utf-8?B?RWhjWm1DaXpjZGk2YTkvbzVxdkNxdXk4ZnFRMUdMMjMvb3BlT3FKUlZUM0wy?=
 =?utf-8?B?czEvV3daK0wwb20vRDF4Z0g0Z1ZNcFduVVVPOVJjV0hvR3E5TE1VaWdlYTRN?=
 =?utf-8?B?clVpcVB0LzQ5S0wwQk4xbml2WVZWVHpUVG9kRlhlOHdHT0h2UGZ2ZmhWa2lo?=
 =?utf-8?B?Zm42NVF2b1RET3lRQWI4OG9YSXYvTDVsdmx5b1VuV2lFcFZWZGFyY056aE5P?=
 =?utf-8?B?bHZoSzJKN0ZVOUY0VU5BSkV4N2E3VjlMdTZ4R1N5eUpyRlRZU0hYWGFLQWEy?=
 =?utf-8?B?VHQxbDVEdFFTUzZpd2pXUFZKaWFUZkhDRXMwN1hUYTh2VDJYYTRqRy9pelR4?=
 =?utf-8?B?ZE9vaTBlRmVwS1k4K2VwdWM0a1Noei8ya3NaMG1xOUZGQkxBcytyUERGdDBW?=
 =?utf-8?B?ejEycnQwVlZ1dU91NS9rcW9xd0MyQmE2YWU4c2Z4RzZiZlAvZHNhcFpPK0FQ?=
 =?utf-8?B?b2RLZVpYa0VsQU1LT0M5Q1g3VEhVa0xoVU1pVXp2Y0Joc2t6RzJDak1mZEQ4?=
 =?utf-8?B?ZHN1MzJYbjNPREM2WnI3SktUMXFpOTV6WFlPTFhNRU1SSEppMWdpKy9lVitV?=
 =?utf-8?B?b1AvRUVkZ2tpNkZsbHVKUU1QN0p1MkNTNE1vNDN5S01zMjM1YkVJMmVoUm1w?=
 =?utf-8?B?WG91VUZuL0FrZVlrY1lub1hkeVVwczdHV2loNWF5MFp3RHJOcWRnUzhSRmw4?=
 =?utf-8?B?a3Y0b2gxcTVkOUJCMEdydHFZK3F6SGRnZU1zQVpsaXJPejUxOUdRc2VxRWNV?=
 =?utf-8?B?WVB1UFFKQkJBQzJtN2wwK0hHYjdUeWVtWi9BVmxlejZWN1gvYU14R2R2Vkps?=
 =?utf-8?B?MVFGMmpMKzZ6U3l3T1VyWDJyRGZ3ZTl0RURQOUlWbkVzelVUU3AvTk1mN1dH?=
 =?utf-8?B?akozSmYrRUhrZjkycEl4V0pXb081SG1GNVBpa1REcmE2cXF5WnRvZz09?=
X-Exchange-RoutingPolicyChecked: M3aBKfDDOURhCylM7s+I0JR9O8FsZ6KQef+HkLDqI7JTio3aAaiF9SEPivP0ARXQOQSbjftGjs0Xk1nzQTR0poh1ZmTOGF4d2AUxKEUbIC3q5t2pkSBgYYoyMTMSTngHjd0gzAcWzVoFAWg2kJS8WaGRNDB6Su6wa7DcJvZkPJ6uTB2LAgfS6reBjFo62DNEq76itNctTmI4UyKIgIXdsNJdq1a7otQiTrmiMdLxVEJwV84bAnhCx5wGpu4+s4taxoggY4wxKBUO2QJIdD3IXhWkzLGDqBtLy3qUlpUTV9tVRFL7Y+RPGovdV2t/k7TdEjEkBdPXAnvLlDYfQLzcjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e77fddb3-458b-455a-d4eb-08de84eb34ff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:38:07.5951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeBrB6Oux310D/FjAPj5kIvwqRGNJOlgasmQO1kVVcXPGQ8tKm7lhh7pQsazeMpFrJgeECFiQ7aEg7zMcRIGmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 3/18/26 06:57, Pierrick Bouvier wrote:
> Give a hint about missing kernel config CONFIG_VFIO_DEVICE_CDEV.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/iommufd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 131612eb836..3e33dfbb356 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -274,7 +274,10 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>       }
>   
>       if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) {
> -        error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
> +        error_setg(errp,
> +                   "failed to load \"%s\""
> +                   " (is your kernel config missing CONFIG_VFIO_DEVICE_CDEV?)",
> +                   vfio_dev_path);
>           goto out_close_dir;
>       }
>   

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

