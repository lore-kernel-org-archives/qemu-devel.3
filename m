Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B56CCF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLM3-0007gf-AY; Mon, 26 Jan 2026 07:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLK0-0005Zi-Aa; Mon, 26 Jan 2026 07:04:04 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLJa-0004Am-Os; Mon, 26 Jan 2026 07:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769429011; x=1800965011;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OuIK4Fy/hiNbUAikxsWiHJNrzSPIm3bj1MhT9CDU4a8=;
 b=k/uKHWp8lllsV0heexXa5WVRmmPs1luG692Ia/J99UgF4nLVsukSIYDA
 DusVQEIca1gTk4N6IqKd4QLjySfo/zpFcCyiqcKkQ5ie8tsq1Ohlbhh36
 Xntq2/QMBHbugaExOjBiq8QlZDxDIx1V/8N9cxb9XHkvLODs9WSPInszr
 cAilqtVeVlYlZZQxpz/vkUh6QLKsHseeYTl2QqMPmAQ4K4D0ghQtbbdQd
 bVn0fr3OcbMQ6LeONw5LXkdwKbYa1RgZAohnJA/2FX7/OGFc12jI6lCrN
 rULlhoDJG+DnH28TzxF/TLYzK0ufxqC5iOI9rW+b4+TtJfXu+InWsPG+J g==;
X-CSE-ConnectionGUID: GJRK0qMYT0SBq1MSeXJnBw==
X-CSE-MsgGUID: 8vL8Zu6HSUWsIRcivPid6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70647293"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="70647293"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:03:27 -0800
X-CSE-ConnectionGUID: QjYoVTZ9RB+a5s2Lrol2SA==
X-CSE-MsgGUID: vRaBYsknTvSp8AyxA2kUkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="238343577"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:03:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:03:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 04:03:24 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:01:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP7gNUkVIcZQ5UpdYdHgqVVJvU/dMOO9Gcfh9aoCBbtXJZyQRSmTiQwOwSPcZ0SM2y2DbjS2BR/UsvsRuEq1QvFKSmeozf4S+PCrZ9DeKgy9SD5MpVBdN5ZAvwj6fYFr6iHLz1CX+QqJUxn6Rvq3iLvBXH9djxYt2zOnmVjK6+p+0zz49Y6dMSJHEDT4Lc4F1tgN38TYFCVQce1rVy+ft6Fk5ruGZAZRqs1lj/4+ObDDaoJaDbxpBuswJ9joNMLb6TKwNfjRXGmIYlewu8ahP0IS1ivwFFO4NfXIIEiu2el8ZAniHNteSJEXsGNFfyXb0NQyXTB8IHU534qTXvPQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSJMJXsjQJLFn6k0+uSZwYD2SE31ZXeMqDGtrAYgUM4=;
 b=S0+2JFjviMDo2OsWzipTtKE+g3EPMROqYcVUqUF/3xB57DP4I6pdwoR07/BvVh1gXnQA855eYKhrSM5Xm9sHyzFOXMXbJZ+gn6vYkOt9pqK831iG3uVTi1r+B+G6ogfCa0WUIBseEdebBkgzzGzu3Wy5SAO0cYeIA/BG4Kc1rDDMqXBRPLrLwOUv4kEiPgoaRZOH17jR6u19AYt+p9g5GaOEbCi0f9+f17q5NazzCVLhNWQshDJCvXnWirMrOIfca7LhpCYenqMYlXmkKktc41Qd+XID10Y8L/afGfkpI5ujNo7Y1hND+xFSbnJfaTRnM5mLWykm02n1FXu7Z9BcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 12:01:06 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 12:01:06 +0000
Message-ID: <649ce0d6-4c4e-4bfe-801e-ea63c51e79e5@intel.com>
Date: Mon, 26 Jan 2026 20:06:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 33/37] backends/iommufd: Add get_pasid_info() callback
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-34-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-34-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6487d9-8b77-4ab1-0607-08de5cd295a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnZpSUJRK2lyZXd1eWQyRTNpQ1FONDl6VDJqRmhSaWJpY1pRVFFVbTNCVTVw?=
 =?utf-8?B?ZDB1S2paYWdBTnhnU2NmYkt0bkFsRTJOM3ZYdjdNSm5xS0hxbnpQY3ZHamVh?=
 =?utf-8?B?S2dRUi9ZRmtNem1MNi9NbXkrbkdFSEg3eWlOVFl3MEE1bEhvL0ZMZlYyaHRV?=
 =?utf-8?B?dlQ4Mnpnd1VlNGR0WEEzSWlmNno5TjNaUDNRS1l3bzBMS0wxT01iWnp6MHN3?=
 =?utf-8?B?WXJPaTZXMFRDOE5LNWxReEFaeDFXcU5lWFB0ZGVCK0NndUxmVnJPOW5BS055?=
 =?utf-8?B?Uk1JUloybVpoTkwzN1BqMTh6RzIvTWUwTlRRNlhUMVRWY1k2MnlIM084WWQx?=
 =?utf-8?B?OTFXSW5TTitNem5RQ3hlUEpaNytRQ09PYk5hKzVucWVta2NCUE45TzBwdmp2?=
 =?utf-8?B?Q29maDlkNDhzc0VJazV5cnR5TW5oWXpXeEhZKytrcEVLRGxEL2R5VHR1akdm?=
 =?utf-8?B?M2wyYnhYbFdZS3JqaURaNWl0MkV4WGlPRkdHYTA0ck1rNExFSVZ5RDlaSkQy?=
 =?utf-8?B?bkRmY2hGdlZVek12QzNmbGVpT2RFMGw2dDcwZjR3aFJFWFZHMlduWnBFZm5E?=
 =?utf-8?B?WmxWOTl2N0p1d1VaZVRRdW1icjkxV2pVMGRvNnVkSUxUK0U1WXFzOUpsOWFt?=
 =?utf-8?B?YUZjYnNuTWNhMUhVUldBdW5IRlVqR0U0Z3N0ZUhvT0NsTFNhUkl0ejh6c21y?=
 =?utf-8?B?Y1ZhRHlEM3ByTTBOTGFheVo4dTlocVNibXJFR1JyL0lKalRVWjlqWUFtdkgr?=
 =?utf-8?B?MFA3QnVxTVVKR3hVaEpXWUFtNHZkVHhQa3NJZmozb0cwOUUwN1dXTko2ZWpm?=
 =?utf-8?B?elJKNXArVXIzKzJwRHpIelVPVVllL2RGSTYrTXVYYUUrU0N4WWV3eDlETS9l?=
 =?utf-8?B?MS9JWkFmNlB5VGppbTl1MkgxTWRyR2wxbG9tR0JNS3J6dmh5R0xmVzVncG1i?=
 =?utf-8?B?L1BCQkJkRk5FbzBlbGY1Z2pTTWw1eXlvYlZ6aldhQVQrMW9sMVJXS3ptQkFI?=
 =?utf-8?B?UEd2MFY4RXpxUW5wTzB1SWJhR2txODhueHVWSDVmaEhrakNWSUQ1QXpyTFJx?=
 =?utf-8?B?RWNmampFYlN4ZGRlckdWai9sQUNGY25RSEtTNzVzTmpkUjk4c1N6T2xMY2Jp?=
 =?utf-8?B?ajJzMWhDODV4c1dlSGk5VnUwb1VSVFczcHlLMzBVdDB0RkhiMVduQnF6Rnk2?=
 =?utf-8?B?ZTd5MVh6Qi9ndFRQN1BGSjE5TlNpeWFyc29pRi8xMDlZazA4bEtFciszb2VN?=
 =?utf-8?B?YVFEWGo4RzF0Qmo1b3ptUTQxTUMvRGhGSncyd00vQUlxbDkrYXJBNlNuNVRt?=
 =?utf-8?B?Y0l1aGdrUHVvVzVhMTMyeS9yRUs2SmN5STJKT0d5QTZIZEVlQ2QzZ2hiM3hW?=
 =?utf-8?B?RW50cDlYMER2R1Y2S0JiN1JDZnp4YWcyeUVLaCt5SVZTM3NseEZTRmpSeG9r?=
 =?utf-8?B?V2Zna3lsREE1cytBR3pBTTVxclJjeVc3RmhqYVR0T3VBWFBKQWo5YmhTV1VZ?=
 =?utf-8?B?RzJNeUlOdjZVS2p2OE9PODd4T0lWT0pwOVpQYjRuTVVDN3FyYlZSZWlTWnoy?=
 =?utf-8?B?Qm1JakRVZGNNVXJLcGxlS1diNnRuNU9IWEYrc1F4R0JJVW5FTDZvZUFmS0JQ?=
 =?utf-8?B?eE0xaURoc1l5ZWhleDVLMnBtNEJpSFNFVk1CQVpBTXBObEh3L1VsbGZjM3Vt?=
 =?utf-8?B?SUdOKzZkZDJPbjlBOFZkSFJDMWxkbDl6MEl1aU9XTTR1ZU5GZkx0VDVmL0d1?=
 =?utf-8?B?cmZLRHV6eEhDVkJWNEN2MGQ3RkxFMGxZYlJEaGxxWnRuWWx3blpUZkh2bi9q?=
 =?utf-8?B?QldyNWdGcjVIeHlrcW9hUW5HZkRNTkcrUXZVNWN2Y25rNUFwS25FOGNWeEc2?=
 =?utf-8?B?a3FMSUwvQXF2dUZQR3laSzBTQUorTHRmeEU2YXRVUW95by9wc3V3RlFMNUV2?=
 =?utf-8?B?Y1hzZmZNRXBHYS9kODZFTlV1SEtWL29KakIydVdnditkR2xRUktiSzdNcHNh?=
 =?utf-8?B?bHoxN0JXNWw4MURYK2F0RW5MZ29zY1hKanZSR0lrRDhqalc2UjRNRUFVVXRq?=
 =?utf-8?B?NUUvNGlzdGIyMjI4Qm5vcDJ1alZUeGZocWZqYWFuWVo2T0NEeVV2aDdnRXVl?=
 =?utf-8?Q?JDwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ektyV0t2MFlJbDZmTzhqWFNqa0NyaXoyRlNKcmZnV1U5dmhhVFkvd0MvWEE2?=
 =?utf-8?B?MWRwTnA4TElyK0dYam5oWDhDQmN5ZnR2V0pjK05UYnFGdnF5SVlxK2ZReUJW?=
 =?utf-8?B?R2Q1RmQ0TGF4cTFXZ1pXaUFoVVlJei9IdlcrblQranJpWGh2TzVPa0dDOHBp?=
 =?utf-8?B?Y0FMaldFN2xhZHNpYXhvNEtOdTZNT25ZbVE2dCtjS3ZnblIrSzZmbzB0THBz?=
 =?utf-8?B?cWh2dEZlVVdMSkFEWlpEbGRXKzdTYUVad28wV3Q1dnpSQm1pOHdVZlFWN09s?=
 =?utf-8?B?Q1h2NTl5NDBEY2NvejBYZ2l2UURxNG16U25ydlcwd1J0aTJjNEpCd25IdFRX?=
 =?utf-8?B?T3JMTmQxOHIxalA4elM0WmFMTUJuWGdGalpDTGIrYW9CU0J5Y1pVajlzamo1?=
 =?utf-8?B?YW0rRk5jMUd2WGljZGxialphYkNJaWFhelRuS2FqbVpPYTZkYlljRGpNNkpR?=
 =?utf-8?B?TkxXZnBhNlhTWDl1V2lyUnZtYjI0UStLV011ckViaTdjYW1KQ2dncUI3WExV?=
 =?utf-8?B?S2dFR0RPSUV1aFlvaGZmWnBUVS82dUUrTUhWM2ZranZHQmMyRDc4ZmhIZDJ5?=
 =?utf-8?B?c1huUEdYMko0MFpRcnRXSEhrMGNpZUdvNk4xRHhoTlFKRHJxZ2RIb2hpWWMy?=
 =?utf-8?B?UTdXMFRrcTRrSnFGVlAwTFZ2YzUzOEcrd1JiZUdvYzg4Z1N4a3h5RjF1MjR4?=
 =?utf-8?B?OVpFUGV6UkEzNGEvY3BkNmF5Tm1YQnBZandOYytWQlNTQXVEdkc1Vmd0L1lY?=
 =?utf-8?B?K01zZER4UkRBQktXU0dDeU5VQnlicTF1QVptYkNEb3A5WUhESTV1LzljdjIz?=
 =?utf-8?B?b0xzN2hzaVVXdGErM3IxSXlEaGNwenR2ZVc0dEVlVTRyeC9EUy9vK1VEWFNF?=
 =?utf-8?B?K2RodGY5Q0VndTBRUi9wamxDRm9rMVJ0QVlPdW9NMi8yNnlYN0pYZWpCRnc2?=
 =?utf-8?B?U1hESnUvMFZYeGN4NHVtMzk5czJkRDNaZGE1cU9oN0tOcEhsMHNwM3dEVXFB?=
 =?utf-8?B?MUVXVTFFSUFqU3lCZWxqQTNFKzdLMmVKNnpHeWRLNXFlcG1xZ3NLSXVNdGxh?=
 =?utf-8?B?Qm1lQ0dxVCtyZ0RCanBhb25zQnM5WnZZbEc4ejJ3TmlYUSt3NkdzdzNBdVlv?=
 =?utf-8?B?eVNBSVp5bkJOcGJUUUwyWlJ6T0VBNjQwUTh4Z3RNRHIxR2h6VStFMnM3MHdT?=
 =?utf-8?B?Z0ZpVUlDenlLdXYrUWpEVHUrc2VMT2kxSmRpOThEL3VaYTBPRTJ6SHJBZFVF?=
 =?utf-8?B?b0lGNWJXdHJmQjk0dlRsaUxuTy9QbjVsdnVYcktFTklkUm9FVjZ0S3lRcnpU?=
 =?utf-8?B?dGExcGNDTUt5ejdCbXRCQnVrb09mVHM3QnhWS3ZPdy83V1p3Y2dXUXBibFRL?=
 =?utf-8?B?dWkzWDZLTnBIYlZ3R3NMU2pnMVFoRVRGUThFaitJTTFiZWZDelFtdUlhZEg0?=
 =?utf-8?B?RFZPWUhzb1NONFRsY0RDOGZUWU9Xd04xaWNmVEJsdVYvdnlNaVNZRE84Skdi?=
 =?utf-8?B?bnZhKzhzMmRoVE11Umhpd250dEZ3TVNKRWkyRGRCVzBGMlh0UGlQU3B6TC8r?=
 =?utf-8?B?K0NUck9zdXlVL0E1WDNhMWRvNUpvVmdPVm5qYU1hZ1BlK2hWV1E2NktnMVF4?=
 =?utf-8?B?M1NGRlVNL0VqUWtvWVk0cWl4WGxiQjJ5WldZcUFZZnZOMzIwTEQ2dWMvY2Z6?=
 =?utf-8?B?bWE2K2g2RWFIcHhWM1kxeHE3NnNPaERmOTdsdURDc1lmWUJrSWxScW1ieXE3?=
 =?utf-8?B?d0c1dm9iT0xwSGhLWFAvZG5iQTFZSkFFWE9BcTdlUFVBRWFRYXh2b1VtZmJn?=
 =?utf-8?B?VFkrbVRSSjBiclBTT0tMQnhia1JIemJqNjBuYm1VcU5Cenh4SEJRS0thNjhQ?=
 =?utf-8?B?QjFmK3ZvZGd4SWtsNkR0T0VsajZ0dzNNYUZzMCtkVVZmV3JPQlBDb0N3enpq?=
 =?utf-8?B?cVZURWZCb2E5b2lDeWxnaElWVUE2cUlmNkxXOFEyK2xKeGdrQ1BnbGJRaElq?=
 =?utf-8?B?Zm9sYXFxS2tDNlFjZEdORXUvREFwUjNhQkF0NUtBbFJuRk4zNUl0cjd5NXor?=
 =?utf-8?B?MWRiMVNZWExaTmd4ZnlhekcwOEUvcGRzT3lGWjJhbFh0WW1FMW9QTUZzaUk2?=
 =?utf-8?B?Q203NUZsQWhFeWtjQ1VEYVJRU3JhK3pJWHpKU0pabXFKTHM1RW5CeUVJMWhI?=
 =?utf-8?B?QlVxUWxDU21RZTBLclhKTjdVVnBVOFZtUGJPeXkxOEFyQ3dZMXpza0JMZHJC?=
 =?utf-8?B?bGEwVHJRb3lKQUVBOHdvZFBHckJ6WmhqM1ZOdlFCV2F5bnNrcUlDdEVkbFAx?=
 =?utf-8?B?bld2UWJhbHVaYXRkaXlkblRzL0FnNnZHQU5wWWsveTh0SURWV0l2dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6487d9-8b77-4ab1-0607-08de5cd295a3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 12:01:06.1834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6J7MJwcvd03Aw9ROEAUNeASCeG/Z56rQuqqCM8pK1dKcWj9JMy24jAIKxJv6qQvYvi5/jbJSKKByMX7YbBoHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> The get_pasid_info callback retrieves PASID capability information
> when the HostIOMMUDevice backend supports it. Currently, only the
> Linux IOMMUFD backend provides this information.
> 
> This will be used by a subsequent patch to synthesize a PASID
> capability for vfio-pci devices behind a vIOMMU that supports PASID.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   backends/iommufd.c                 | 17 +++++++++++++++++
>   include/system/host_iommu_device.h | 17 +++++++++++++++++
>   2 files changed, 34 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 9b63d74083..13822df82f 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -539,11 +539,28 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>       }
>   }
>   
> +static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
> +                                        PasidInfo *pasid_info)
> +{
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +
> +    if (!caps->max_pasid_log2) {
> +        return false;
> +    }
> +
> +    g_assert(pasid_info);
> +    pasid_info->exec_perm = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC);
> +    pasid_info->priv_mod = (caps->hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV);
> +    pasid_info->max_pasid_log2 = caps->max_pasid_log2;
> +    return true;
> +}
> +
>   static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
>   {
>       HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
>   
>       hioc->get_cap = hiod_iommufd_get_cap;
> +    hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
>   };
>   
>   static const TypeInfo types[] = {
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index bfb2b60478..f000301583 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -59,6 +59,12 @@ struct HostIOMMUDevice {
>   #endif
>   };
>   
> +typedef struct PasidInfo {
> +    bool exec_perm;
> +    bool priv_mod;
> +    uint8_t max_pasid_log2;
> +} PasidInfo;
> +
>   /**
>    * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
>    *
> @@ -116,6 +122,17 @@ struct HostIOMMUDeviceClass {
>        * @hiod: handle to the host IOMMU device
>        */
>       uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);
> +    /**
> +     * @get_pasid_info: Return the PASID information associated with the
> +     * @hiod Host IOMMU device.
> +     *
> +     * @hiod: handle to the host IOMMU device
> +     *
> +     * @pasid_info: If success, returns the PASID related information.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
>   };
>   
>   /*

