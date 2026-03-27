Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FAFF532CC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yi5-0000xQ-0x; Fri, 27 Mar 2026 00:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yi4-0000xE-0D; Fri, 27 Mar 2026 00:22:12 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yi1-00053D-8n; Fri, 27 Mar 2026 00:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774585329; x=1806121329;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jQv1m5UbUMBe9Irfan4pkCgn72d4uj/UVeEgaPcs4W4=;
 b=H3b3uEud3L1fLilX32u0iKw+E+AAO1Xqrh1viY92LP7NO8h5s+46+6Q/
 /8UAzIQfUQ/rDFDm7UH8ZZ0uOYGq6HTcjcthHVieWUgQkadWlE0m191gt
 TN+qUX3a4An80qvGIYGwPdskrElZffiOduy+xJ39wCG1IFygwrCyj9JnY
 eiF6aUmFYS4kAEfYVTqAjN8xHjJY/rPBewaSAj1KcYWiiTtmtFu499Xh/
 pq3rHZKhs7bAzLzeuzb/uloCtlKxIOmCjK2PoAW+xjZiVlSCwbbS/zcdA
 a4QzM4rCx0ADrAapTSscdZewv15M7x81/suZo8QuBKbgMbraV9wWp9o9n Q==;
X-CSE-ConnectionGUID: sQu9Qw8MQy2YSRMkVbpoDw==
X-CSE-MsgGUID: 8rraI6eWSw6QdcUF7fX4tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101114960"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="101114960"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:22:04 -0700
X-CSE-ConnectionGUID: KIIH8tw0Qhe6LTzpQGzaTw==
X-CSE-MsgGUID: A3pkURwYRGCjU0HZG3YQVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221889808"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:22:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:22:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:22:03 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir04ZtqBtIdBlPAmQgrtgbeRE/FPjy6qOOLKcuxt4RkUd6GgqRHmjVSdyRxgP0yh46enOauS8vVpnrTlHiN5jZqg1y/5D+gsxbk80NY0NreK3TBbRV7gle3T+FZhyjyXcj74sPrwkMgg1g7XekKu9Rat6FPiT+zwMaQb3DA3luFHUtyOBkX1fQoeZaIw1tKvm1edVt2PBgAOp19a8eZbDy68WrOHoOzs8oBtlJxzIel8GZP5jQQ9XNXmgIje0M0Irdk9/wcqV1GCh3xRYnTJG8x6v3KbJTliPpPD6RTbSRx7S5wJMzTm8bg/z4uO9VuQp9cfB0QAUkkcDXGBjRjE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVe1FTNAnyN91uINbucbtwwBdB5v6cI5xWKDGsIMGOc=;
 b=M/PAXxitJM6+T65xrN47JHRFSHOhxGdyGBatYxwlS8AFMY3M1XcJUxEE/C8KgiXUJexkVQlRmqIZB+K9kbJ0o87frz2lMsgp40O98Sml0QZhWrtu08cGHmEWZwq3+6bPGRQAN5hcHOWwbsh86CD5Jx33sawNjFyPvixiItc/2V8fphlT76n6na+KKpbPLpmBdDxsfUlIkuA1tno/aUGSy0l3FDgQ90ClQfGn/F+RoYXE9gyCd8wlu4kdhXXcz23a9zaNG1ek8LyDbcLURFMzKJRoeqVFS+oOivHlBaXIX/WdbCD4OIo+WJo9K+z06MLqz7MLHhCNIgsg4re7BOBE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 04:21:58 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 04:21:58 +0000
Message-ID: <953db036-af16-45ef-89be-40fdd5d2b52b@intel.com>
Date: Fri, 27 Mar 2026 12:29:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>, <qemu-arm@nongnu.org>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260326091130.321483-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6122d530-d00a-4090-5ec1-08de8bb862d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|42112799006|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: WmGOxZnIWrIzUWv8q2s+thL29T9Bt1cKfNfCrUGyQF5oFFMfEMHEGT6i2if5XlHjds1slaVCgMp3TV1Aq5EcA5VhqoJK7lA/PvCueGGTo5K28XSBXs3CHdE80Cy4oDK1NrmzUP1ws3VCvbhCuUZh0au5FDQzvPM6FLreQok/a57Mp4tUYr2OmiiKNyQbR1EFSMEr29TkIiBNUiPPEglzHQLhTpx9i220h/CiOwx7bGVW3hrcgk0O2qMG8CJGOcemwF1w62EoSXnM6S6rH5qVEACOQ7XQFFzODZeuqtbsbp2XnuNcDbdwXLq/fEz2ms3X8mHzu+vgY1vX4oNm59QkJiRj5MVWfkxNLfSlPtENT0yd6xsOMFRtigBw4hYYiWNWmlJ2FPHeV4jMe15PNmWYfcxt2ejp+HTW7WDPyo6l9iVYIrjwFKOmc8XZEwPUfO/H8Z8wOKZDFsFab45CZDfzZVa3Zmf6tPRuUgtbw8TxPt9Zpm77T/jzPMGIOzQev7X7yedhBBd4S3A1N5z8C2so1x+hReTwZSlPU2NTkEb8+jx3+Hhb7ldQAmLZ9rJrBFpiAXlwRCSxoxS1dfXBcR+QH/oiptkSYIaHH2YAXTOv5do3Pj8AN9fzTnf+IAAIzW8xMJNV1q7S773gnwRJC6msgY/3W/LGktBMrjf2DyEwukjt/ZqRVLS3607wPTKC3WD7Q6lbX07t9t/FACxbbms/T9i2MTZ6H4YkuZMvXs1V3MQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(42112799006)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytTQVFvcUlaVlkyb3FHT2xYR0w5QlhSNDJnNEFtNm9rdXdiQzJrdWlENFJz?=
 =?utf-8?B?RTAwTlRnQXlJb2J6OGMzT3J4L2FlZ0FVQ3EyNGMyZTc2SVQxVzRFYnZzY2Q3?=
 =?utf-8?B?dk5RMVZwUUJlMWc0RGZ3VzBKVzk1YVQzeUxBV1lsWE92S1RvdmpCMmpOTTdC?=
 =?utf-8?B?bUViWFNsem1mK1F1dXM5M09YQjcyMlc2czFwZzJtV1IycVpRaFZxN0FaTER1?=
 =?utf-8?B?YXpielJ5by9HZUswZ2NVcWNoNDlSTFpqd2ZmZGRBUVVnRnl1MXU2d0MxV3NM?=
 =?utf-8?B?eW0xa0U3cnZPeHZaWm8zazFFQks2bTdPcENOWlhLYU1CSS9taDVjbzZ6Z3kw?=
 =?utf-8?B?blJmd2tiRG9TeFBxeitRZHJ3NXJwR1FwUGNBbU1LNDZTMUxqbFYweFNBcVNl?=
 =?utf-8?B?SnpRaksvSjZQWXNWdHE4bWYrSGxleTQ1VTlESzFnMXBIaGRGT3o4ekxJRmhw?=
 =?utf-8?B?Z0dHNFFRYzRReFFHak80QmcvMXQwckZvbmtTSjVBSVJyZzQ0WjN3OTl2eXVH?=
 =?utf-8?B?VXNGUWtmUTAwT1hGNFZ3RWgyeXk5NFAvZ244TXlGL2t0RTVleEZkQVpLL3Nj?=
 =?utf-8?B?YzJSdDJWQ2RGelZMdWZWTWZwMUFFNFkrSitLQkIyazN2cFFsbWoyakdjbGY1?=
 =?utf-8?B?TXZHbmgyNTVubzBmSExZUUtJTy9NdldIRkMzZlh0NElPTURhTTF1TGlDclpp?=
 =?utf-8?B?TWh5NG9Wa3V5eFpobGJ4MDZwN0JhcnM0LzBrVkE4SGYrWm9LaStPNGM2TnJP?=
 =?utf-8?B?K1c1aUgrQUk4QUtqREJIM2M4MGJzYVphelpxazY3cjllcGl5UE5jOFJQa2dD?=
 =?utf-8?B?QTAzZVFGRTFhTzhRbU9xSmVIbVMyNngvL3ZGeWYzcm1BaWs2c01DQXU3WlBj?=
 =?utf-8?B?QjhkSHZON0t0c0FyS25sNkRoMlhNYm8ySW1NRGFQd29rd3ZHc3dieDRCemNq?=
 =?utf-8?B?NDc2NVBab1RPRXc3NXUrakVHVmM2b093T202aXJQNVZBWTVXRi82ZmcxdzZW?=
 =?utf-8?B?bWlmYWpuQzRmQlZPRUpJWHlMN3c2MUNMUjZ0amgwUlRJM0J2VGJ1MEFSSDFi?=
 =?utf-8?B?bW1oM1piUEVxVXQwRnk1V09TZ3Vhb1QwK2tEM2VSUnpielBoNUhoRDlUS2Zt?=
 =?utf-8?B?ZjRxRldBajZEYnoyWk0yUVZlclIvM0E0S1BLSW5NeDNnVGxtYndDOG5XemhX?=
 =?utf-8?B?R3lmL2lUT29nUnBweWJ0ZWZReHc2dkh4YXFqR3hrOW56QXc2VndsbnpOSGVF?=
 =?utf-8?B?NnorYnQyMlIrUDJwWnJ6d3lVQ1NYemMxZ1pRYmxEVjlmbmVBT280eWtwRlh6?=
 =?utf-8?B?WE81SnFTTGJGU2VUbFRtaDBuNGFyRTZUWGNhYk81TTVMMEwxY0VMRHA2K0NV?=
 =?utf-8?B?V2ZwQmRTTWplZ0VlaGs2bVFINVhObGtEZzE0V0FGODdWQlNzbmVvcTVUZWlB?=
 =?utf-8?B?NkJZaVp0S3RRaE4rcmtRaGFoYllmenpqRDNna21RWEp5Qmk2S2kzdzc4VkFL?=
 =?utf-8?B?MTM3V1BYVUpPc1JETmJqTmEyQkxyRk9KZnBOK0dlMGs4RTBiTnh1bHZISUk2?=
 =?utf-8?B?QjJRUDVqb1EwQlR3SThsTU5oTDE3a0k0dU90bU80N1BDRGtPVjZTR1pEclBZ?=
 =?utf-8?B?S0U1aVltU05EUU1jVUFPcHdRY0JKVXM4SHc0b3BlVlFiMFBOMVhDL2F1d1Bz?=
 =?utf-8?B?dHNOTElacHpxMTFXSW1ua2w3MHo2US9jbklZbS9uNEJBellYZXhONU9GRjl2?=
 =?utf-8?B?czRiR05SRDl1dzV2TERlbWFFYmo0aXBHTndheFRlOU5qUVFpRmJYbnZnclJH?=
 =?utf-8?B?RTdUT3hNajVtcEFhTEdZanlLTERGUWZ4alpSdi9xM2czWGtqbEFWZ1JrWllz?=
 =?utf-8?B?TXY0ZFBTSmQ5cEx4Q25yRUN6MU1lODFOQnlMT05FVHVwLzhzSTVWT3dFTXh2?=
 =?utf-8?B?UUtEdmNmRnIzQXlxUC9qOWxYUmJoU3VGQTBVNXdMdXp2LzBMSStNOTd2Q2k3?=
 =?utf-8?B?amdidmRKK2RJYk81bnk3dEtWOWZTNXdrNTJDSVNqVmM5cnNSMHlNdjNPaU5q?=
 =?utf-8?B?bUtZWkJoL1lKcHozclZ3OEtSeHFmUGtQSVNsTzhJb3dFcmNVZGRwZ0Q4bGFQ?=
 =?utf-8?B?TTRocmxCSEFKbDdGaTF1dGgrQzV2Y0VSb2hRemRzdmh4NXRSbTVRTFFuS3dN?=
 =?utf-8?B?SXgvVE03a1VGaC83bEdMV0dzZmRCWlpJSitBc045ekZGeGsyeG5hNHQwTkQ4?=
 =?utf-8?B?bUxvaHBiendtckRnbitPeFBucXk0MFlwSm55OU5vcmc2RHA4cGhKR1dXQnpo?=
 =?utf-8?B?QVJFNzVUZ010NmJVOHJIWjhNTXhBeHJjbEl6MTk1T2xjeXpveGtVdz09?=
X-Exchange-RoutingPolicyChecked: A99HMj1GUUN84ZSKAiNiZkeE5efuyTCMgb2jZjWsvhF6dteCupkNz7GtL+i7RSKSS/L/HIcFQXvqFQ1MJbwoHe5a4366bJndZiGrxbfNeSwC0lGJbsPaT0LTaFlxzx21YO6iNT6wa6HAex3Bcrz1Gi2sr33IFsWM1+hmP4bHrMsJi87cJqLNWvUT+7u5UpIwbPrFZX0lPSDQJ7VsLTQiIR8BtPkGoJIHkTHr46CqMCnuYnsRcdPVfTv2rdTxeho7F4wNL+aXOwXwzWBMhBnC/Aq2ZMAU3XU/Vod+eyCNJgD6nzL2PMLsL4siEJoOC5MLxxM9QNG+2F94KmTqCiGxAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6122d530-d00a-4090-5ec1-08de8bb862d2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:21:58.4307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCRFOAf8SI88OwtQzlPmib9WfA4UIsb28rAKp4RlKMd3nd0uVgA9mX9+p1QJ8WIPEHydTZwGwJi8UIC1SoZuTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/26/26 17:11, Zhenzhong Duan wrote:

> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 67d54849f2..45c08c8f6f 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -121,7 +121,8 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>           }
>       }
>   
> -    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
> +                                                errp);
>       trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);

The trace looks to use the wrong pasid. could you make it use
IOMMU_NO_PASID as well? Same to the below chunks.

>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
> @@ -145,7 +146,7 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>       bool ret;
>   
>       if (s->dmar_enabled && s->root_scalable) {
> -        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        ret = host_iommu_device_iommufd_detach_hwpt(idev, IOMMU_NO_PASID, errp);
>           trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
>       } else {
>           /*
> @@ -153,7 +154,8 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>            * we fallback to the default HWPT which contains shadow page table.
>            * So guest DMA could still work.
>            */
> -        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
> +                                                    idev->hwpt_id, errp);
>           trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
>                                              ret);

Regards,
Yi Liu

