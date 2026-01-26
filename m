Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F5CF65E9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLGr-0008Dj-51; Mon, 26 Jan 2026 07:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLGJ-0007x6-Oy; Mon, 26 Jan 2026 07:00:15 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLGB-0003QX-RT; Mon, 26 Jan 2026 07:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769428800; x=1800964800;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y+WFnPKJDXIZMp+xmXA3Btg2GrXdJGycHxzCbqfkpf0=;
 b=MFn6yRp4cWmxFH7S3762JA6S1CsWeh0i+MQBG/ZV0KmrfWkYnz5HBSgn
 l33STFkxG5AFGsedmHct2lhnrtLzt14Quwx3TblAqXffCd7QCl6izwEzo
 YLKow5Z7I071Pi5+t2hTyIwbPRj7k6QC3J7C2fbAbmhVs7+a4lz8+tnyc
 5nfYVGPiEj1c2vxn7V9C04KHnii2eMQwmKommyJNGUPG80oe3h3MUQn8D
 HqA33T1n52Pm0YDsYPapoSjdw0vrk6CZJIkNwZ4C0BjTYE+NHkxz1qz4l
 foHC4MWOEnoOTFQn+PLz750nWvbMjLqcAGq6a59xqYcr0Twp/fRJtgCKu A==;
X-CSE-ConnectionGUID: RzrjPKyERoGyrsSaYIRAng==
X-CSE-MsgGUID: cxdUBPM0QNKmn0F84zsy1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="81237822"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="81237822"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:57 -0800
X-CSE-ConnectionGUID: 1nBKHNMtSyqrteIf4WHtQg==
X-CSE-MsgGUID: At25sEFmRRiuYWky8fyrKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="212648811"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:56 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 03:59:56 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgpM3gZH6DnuyAGl/qtftbKU0m2JCI10hP2YXa31aV8ZjHrWDblFAvK4Ce6irDGey6YVefSeI0Bwubq1YjHrsVZ/nSW5NAFDT5FyblywUypxt/F3elEaapfrj/m1bkCRGGkvCCJvpQemjKvFfRBOKrZ2arITdMrElbPZUy5t42v5Rhb/dW7G+dc6Uh14gNnTDNdvD7nuryZ/UTsHcMHNdLH9/NNLsp/4guS5jul20D1vP48lpvcUQt+vFt5Q0Yg9CLUexqEOnP0sJTNJpoWV3yRcGU87bZ0u7AoQpelXKP7Vz8iFcRKxtJl8WW4JUmBZwazWkWP3wTqVLly+6DA27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWJVnkaVf7rnyUEz17Pq+CN4h2aISuVwYy7JFhc2CbQ=;
 b=yqFnDapF/zWbo7ezMrbpuNbCjl+nBWAJHSuN5Gf+fxo9hoZifCTjCsbW12pbYB6Of+zmQvsBXf4sdNJc96OO0fChxDfYmoDB6FS+CO8nuOj4lLXZyp8jP+R1vvuXG1y3CKgtr1v9Y5JILdueHMkvZF1J2OAiI1Rov9MmqdnEAZ+5BeXTH8+DxuJSIIY7Oez8sh+XeTN7JY2BXNeZ0RY2zfLDg3ZPwdWw+VZfBPwJ/sVeovCeNhf4xb+6DoTJhMP5eJQajk8lgBsKUGz7XvdBGHQoaFf71D8SE+U84fwtMoU5r3zVQB/hMRdsNk9Ig7OUy4+1dz4N1zJwX10iiyQ4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 11:59:54 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 11:59:54 +0000
Message-ID: <63b28d08-1b00-4d6d-9645-7dbc3592e847@intel.com>
Date: Mon, 26 Jan 2026 20:06:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/37] hw/pci/pci: Add optional
 supports_address_space() callback
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-9-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce62d50-74a6-414f-f6dc-08de5cd26ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eThJNmh2bTkxMjZNOGN2RFEyVTBWb1JnZnorcUFsVDBBNEVoOFh1WGdFYjM4?=
 =?utf-8?B?NlFudVhTVllpQUM2bnhXSFBPN3ZXSURpdnhOMjB2N2YxWFo1TDIxTWFxM2pT?=
 =?utf-8?B?TlJJYzVzaXgxdUVQM1RXNjFFSmJzNTRJNCtxK2VCekdadWlTUHJRR0Z6Qmx6?=
 =?utf-8?B?aXFiTWpQVTJ5VHVtaTBnckFwOHI1YzRaTHU0d1ZxZ280c0pOaWVBVVdrZC81?=
 =?utf-8?B?V2RjNEFlSXo5MmJsM3lXRjlNZGZhSUJ0L0ZSeVowcU03cmdxdjZUNmsvdDVS?=
 =?utf-8?B?eUtjUkNzdVRaUGgxRU1pR3VXWFpvTzZFRnFIbzlUQmVWNnljWWVCcWJhMGs2?=
 =?utf-8?B?SUhpbmc4RFJoK2xXMWdRM3FWTmtqRHBkRzd2Q0x1K29JWkhjeVgvNWNOM0l2?=
 =?utf-8?B?Z2p6YzZra25jUVpFZ3k0TklxbEdyekpCZjNCNjVFVDRpZFVHYWRHeTNyYzMy?=
 =?utf-8?B?VVpSWjI1a25wWjVCaUFjbmx5MFJub0YzZDZ4U3hnYTQ4WnJQY1pFeVREM2Rk?=
 =?utf-8?B?clFEcnFZN25ZZ1IxZDRiSnB0V20vaWNlWnQ4T0FwaUFhazBPWXVqckh5WHVM?=
 =?utf-8?B?R092UU1GaUwvQk4yd2JnS2NGZ3R3SlFqalFmQVp1eWEweWxIMEphcUZhWU9X?=
 =?utf-8?B?d2hOcmo5Q05CU0IrQWpJbkUyVXhlbDV2RksyeXhEYWdoU3dRTUljdERnMUJs?=
 =?utf-8?B?NGJwZmRtYkNQdzllcjFqK3VFL29POEVZVjd0UEs5YVlrMzdkY29hS0FaNVBl?=
 =?utf-8?B?SDIyczJIS1VqTUtuWmcyZkFoMUJ6NVZCSVQvR3RvZklFaXBjaUVDM3cxeGpn?=
 =?utf-8?B?QWltS1JOOUdCWFBsb0RaYkVkbWhpNytMdE9KYkkxV3hGUmxqY3RyY2NXR29m?=
 =?utf-8?B?Uk5VT1R5ZXRhMEI4eUk0a2tqejhiWEZqYnRFcHQyS3UzT3lzdzNqMmV0VUY4?=
 =?utf-8?B?Y0tERjh4RGNFODlrNjNCTkZIaXBia0M3REM0VDRSSy9Iek5NRXBHWnFSdkRZ?=
 =?utf-8?B?eW9KNFJlZXhNbzR5TFI4b3ZLV0Q4Q24yUkV3VE9GSEc5STVOZmNMNWpOZkkw?=
 =?utf-8?B?Vk52L1ljL1ZCdzlDQ3N1TnhkZEJKdStHSHdmVkM2bzVwSUZHR3hFZW1HR1lo?=
 =?utf-8?B?YkM0NmlDc0NtMkpHcDlmMlFBR2M1eHE3dVlaU3hvT1FYczVkdHpLTjBJYW1E?=
 =?utf-8?B?cUhuMXROMG1QSDYwdmxBOG1BdWpmYlJScHM1Q0FaL2swckRsT09ibnV1M2p1?=
 =?utf-8?B?RjNpNVJMUXFGZkJMMTdkTGpUc042RXBqVXZTQVhhTEhhSVQ0bjY5NEFvUndy?=
 =?utf-8?B?b1JXZ2hmc3VGWTQrYlZFcWZtWW1wOFN4NFY0dDJvWUFGUFJXaVhtT1RidFEy?=
 =?utf-8?B?dGpBQW56K3Y1bDVBdDltZlpDL01LZEp4YXg0QUdEVWpSYmZVU3doWXRQZWZZ?=
 =?utf-8?B?ZVhUbTJtS0tTTUJUSWtqa1grNVZJRW1DbDFkWGI3NUpGZ29VOFVxS2dlYVhS?=
 =?utf-8?B?NWZCZzUyV2U0TnZ3d1VjZ2dhc3BYYjJsbTlTMnFkTTI0RGI4c3FtWkFDZGo5?=
 =?utf-8?B?eVFzWDkxTmIxOWpMaUlCd3VicXBNOWFhc1llMWFPUG9VMzZBZVFDTk9zeld6?=
 =?utf-8?B?WmcyM0JVOGYrZDM3a24xMmNzWjYwdFJSNFVZK1IvcjZMWDdGOTQ5cnRUdGFx?=
 =?utf-8?B?cC8vNFFxNEpjaHNKaUZvY2VMMmphc1phS3ZaZUZ4ektHYTA3UDVIakVQMWhr?=
 =?utf-8?B?YnhlTUJ3YjEvcU1MUkRYYzh0TGxuWVhnRjVjbG5RL05SdjNod01sR1BiZUZy?=
 =?utf-8?B?KzRFMEh6TTVWQlRTZU54amZ0TXRhbUhUSDRIa2l5OW4yOCs2TmJoaDY1Tjg3?=
 =?utf-8?B?Y01EaTNTckZKdDRoUUU5SW0zOUVJR29XM1lNazduOU9vbXY2cDNGRjQwTmNj?=
 =?utf-8?B?OG1BMzBEWHo2WE54OWVjdGVSb3ZHYUg4bE8xOTdGNFBGYjlzYTJwL3kvTGNC?=
 =?utf-8?B?M0p2K0I4d0VkRG4wcUFQRjZMTWllWmY2MmozNDRlZG9nRkhOV2toU3ZtbnpJ?=
 =?utf-8?B?RHdXWE1neEd4clNXUXgxNXYzT2orK09WTTF3MkR2RDkyYW4vdTBOT3NvaVU2?=
 =?utf-8?Q?Gh7I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHg2eHBndU1jU0FwdnZHTWR6K1JZYTdRNU5pY21ORUZkSHJZZzFERUJrOUwz?=
 =?utf-8?B?djFnODRLdWVNR0NUUVNQRTlKdXpvTVplYk1pWHlER2VTNVJibGFNZTdlUGlm?=
 =?utf-8?B?YUkySXhqQ2k5YU95Q2FGWkMyRHBRMG1PejJHbjVtNVp4TWRidjlrWTlFOGcv?=
 =?utf-8?B?YW9QL1NZaFpiRnJHUU1SM2YxYzFLMG1PbkladlphOXpqNGV0aUpSRWt1WHNi?=
 =?utf-8?B?aHJXQXBrbHNGbDZRWUV6Z2Y1Y3UxQkdpMHB1Y2Y0MWFSSW9Zb1ozQnhEM2I0?=
 =?utf-8?B?elJ5VnUyVkZsVVAwYXdjMlZJNTRuMkpoMTY5NTdXYUJwektTcTZzY09PalVv?=
 =?utf-8?B?eGV5SkVlUkNRdDdsVUFGSEtGbmJlZnFzR1lMdWdlUkpVZkk3cGw2cThFTGts?=
 =?utf-8?B?d2pLZnpSYmhpM1IzVDR4T3E4K0prVXE4L1ArbWowU1Zha09TY2JCSmhlTG1l?=
 =?utf-8?B?ZVlKNVRSV1BVdFZITHcvdVlkS25WbnBROFcxKzJ2VEIzclhEWlFNRGxRQUti?=
 =?utf-8?B?Y1Zlc201MUpCc3BNeVRaVU50ZktOQ2I0THIzYlRvSFVJY0NLUmFwK2lDWjVP?=
 =?utf-8?B?eTN4N1NjSHZ2bEhPelBNU1RyWDFGL3JJV05mSi85Rmp2NDl0RDNmRDBLbVdx?=
 =?utf-8?B?ZVdqQkZzeEtCY2IxNjdhQTZwZEprSnd5Nk0rZXNaZExIRWtmaEs5Rytka01s?=
 =?utf-8?B?NVhpM0o5V1htY0VRdHFtaHBPWXpIVVpnMS9FVTM2NEdrVW1lZHNyb1ZEMGpV?=
 =?utf-8?B?bWdsZmgwYVRFSUN1M0RZR2hWOWpuUGRNNnp0MUZEYlAwZ05rZTE3WXh2ZFhj?=
 =?utf-8?B?RnpGTWIyVUpkSjdEMmNIcGFiazNoajY4N1o0aW81eTZ5dG0wUDJYS0pha2hJ?=
 =?utf-8?B?MGlIZHpTMEdrdU9aYkhMWEswUDFOZjdraU1NZWxqcEV5K3ZST3BudDdoVURO?=
 =?utf-8?B?WVV5RFlkbENvQktIV1U4R0cxdTJKSlFuTmpEMTVHdmtKalFUYTkwNmRvNDhY?=
 =?utf-8?B?azgxa0tNZW03cWtmenhSQ3VsbnVVN2ZLOG8zeEQyTFA3REduRVV1b25iNCtC?=
 =?utf-8?B?clo1UTMyZW9sQkFaKzNyYUZncENkUnd1OXI1bUszRjRNUGl1WDYwYUF2c2hS?=
 =?utf-8?B?bFJFVzN6UkNBbXRGUjdxUmtwWnhHSlVlb2dSOUYwU3YzQmdFSmxnMUJseWR3?=
 =?utf-8?B?eXdCV3hPSllvcUJIQ1lMbk5Zb05xMGRzUGZSelFkd1p5bHhuaVFDVHVKL3Np?=
 =?utf-8?B?MVdnMGk0RmI3RktubkpodWEyUXdNdXNrVVkzb2YrS3VMR1kwcW9ubzRQdUVT?=
 =?utf-8?B?a2RNOUZGd2trRE5nNUFldXQwVUdrUTZmcFdVZDNWNXQwWHFiTStrUWE2My9I?=
 =?utf-8?B?aHo0eGZ6bFBZSVlBbE9xeW1vZEVsM0laZ3RGK3FRZ054aGlzNEVHZ1J5WFRt?=
 =?utf-8?B?REJyTXJPTTl2UkMvQVpVTEFzaVVpZVBXYTJKdHh1MzM5M0dIUFhaRkgvT29h?=
 =?utf-8?B?SFhmOVdyTFgyVjJkd3FQOFdtT2UrUEwvRGI0UW9HaUNPbGNxRWdJR0ZXcE0y?=
 =?utf-8?B?alBMKzhHSWNlNWpid0ZLbEpxVlZ5OWVlak5YN1NtRTZvNHNVajdGOFR6TU12?=
 =?utf-8?B?S1gxdXoyMlp1SUhHZER4YVBmOXF0bzFWMldwVzluRG9SWXlTNFFDSWdFK0Fj?=
 =?utf-8?B?N1JxSjg5dWduYXZiTVgrTHI4NG9oakJCMHlrZ1E5c2hIdkRNSlpMbFVnd1Qv?=
 =?utf-8?B?cGxyZFlVTld1UFVuMWxQVCtkM3VCMGQvV3V5MEtQNWhwZWpoSU5JNDhHSG96?=
 =?utf-8?B?bDlKZjdzeFg2L3p1dk9BRFp0Zlg4bWZTWDMzb0wwbU9uMm5RL1RtZ25qSTQr?=
 =?utf-8?B?NFFlalJrYVJvTWEyVS9JZkg4cXNMS0dtMk5nWDBjVFBKbXl4RDU5c2FhUHJl?=
 =?utf-8?B?WERhMXIraGt2amo2bW1TSEN3d1pnL1hJcWpBZFR6TzhYM3IzTVNLMnNza2VL?=
 =?utf-8?B?U2xPTzg3ZGpOTllFblB2WWcxL2NPMmFaYTlaeEhtZVErNDdxSFJlam4zZmMz?=
 =?utf-8?B?NHkyMUVxT2hsdFk2dVJWR0pZYzRLbVdnSEZidE5ySGZFdWUrSzh0Rk1ubWR4?=
 =?utf-8?B?SDk0bFNsNy9xZFpiUEFES3pxd3FBZFlsZi9vNlhwSVM5WW92cXVweEh0eDBy?=
 =?utf-8?B?ODVwZVVhSy9DZFJrZlFlVWVQS1p0YzNHRzVlL3lVdWJGand3MDFZd3ZnTVhn?=
 =?utf-8?B?c0cwcStHOXBRdXpURDJibnc5bDlQWjB5Q3hkY09SM0VVU25FUWVIUzh6bitC?=
 =?utf-8?B?Z3dNcWpiZUh3SW5JRk8zQUxPS2t4RlFEaVZNR28rYjFWQU9NcUN3UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce62d50-74a6-414f-f6dc-08de5cd26ae3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:59:54.3260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSMWDH35ULVbktQd/SJw0EzxLc8pRbIWRpwTy7KEhK6J4kDyx+GzpgiBvPdppHJWqff4uzLhdc//FaymwC7N6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
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

On 2026/1/26 18:43, Shameer Kolothum wrote:
> Introduce an optional supports_address_space() callback in PCIIOMMUOps to
> allow a vIOMMU implementation to reject devices that should not be attached
> to it.
> 
> Currently, get_address_space() is the first and mandatory callback into the
> vIOMMU layer, which always returns an address space. For certain setups, such
> as hardware accelerated vIOMMUs (e.g. ARM SMMUv3 with accel=on), attaching
> emulated endpoint devices is undesirable as it may impact the behavior or
> performance of VFIO passthrough devices, for example, by triggering
> unnecessary invalidations on the host IOMMU.
> 
> The new callback allows a vIOMMU to check and reject unsupported devices
> early during PCI device registration.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/pci/pci.c         | 20 ++++++++++++++++++++
>   include/hw/pci/pci.h | 19 +++++++++++++++++++
>   2 files changed, 39 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 229ea7cfb1..101e745bd5 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -135,6 +135,21 @@ static void pci_set_master(PCIDevice *d, bool enable)
>       d->is_master = enable; /* cache the status */
>   }
>   
> +static bool
> +pci_device_supports_iommu_address_space(PCIDevice *dev, Error **errp)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
> +    if (iommu_bus && iommu_bus->iommu_ops->supports_address_space) {
> +        return iommu_bus->iommu_ops->supports_address_space(bus,
> +                                iommu_bus->iommu_opaque, devfn, errp);
> +    }
> +    return true;
> +}
> +
>   static void pci_init_bus_master(PCIDevice *pci_dev)
>   {
>       AddressSpace *dma_as = pci_device_iommu_address_space(pci_dev);
> @@ -1424,6 +1439,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>       pci_dev->config_write = config_write;
>       bus->devices[devfn] = pci_dev;
>       pci_dev->version_id = 2; /* Current pci device vmstate version */
> +    if (!pci_device_supports_iommu_address_space(pci_dev, errp)) {
> +        do_pci_unregister_device(pci_dev);
> +        bus->devices[devfn] = NULL;
> +        return NULL;
> +    }
>       if (phase_check(PHASE_MACHINE_READY)) {
>           pci_init_bus_master(pci_dev);
>       }
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 6fd8984c99..ddb0c98e9f 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -417,6 +417,25 @@ typedef struct IOMMUPRINotifier {
>    * framework for a set of devices on a PCI bus.
>    */
>   typedef struct PCIIOMMUOps {
> +    /**
> +     * @supports_address_space: Optional pre-check to determine whether a PCI
> +     * device can be associated with an IOMMU. If this callback returns true,
> +     * the IOMMU accepts the device association and get_address_space() can be
> +     * called to obtain the address_space to be used.
> +     *
> +     * @bus: the #PCIBus being accessed.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number.
> +     *
> +     * @errp: pass an Error out only when return false
> +     *
> +     * Returns: true if the device can be associated with an IOMMU, false
> +     * otherwise with errp set.
> +     */
> +    bool (*supports_address_space)(PCIBus *bus, void *opaque, int devfn,
> +                                   Error **errp);
>       /**
>        * @get_address_space: get the address space for a set of devices
>        * on a PCI bus.

