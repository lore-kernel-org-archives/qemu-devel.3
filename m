Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51415C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 01:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta3BN-0005ym-Ke; Mon, 20 Jan 2025 20:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1ta3BL-0005ye-2k
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 20:35:55 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1ta3BH-0006t1-In
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 20:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737423351; x=1768959351;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X6GQNbb5qPOzcTc+VlAbYlwrME8zzlx8XksrhLkHpN4=;
 b=cB+o2hh0QaQ2IhYExpU5RMyKDv/yzpxkD+/t41S9A+0TOB6Yzes8FuCd
 CicV+hjvYcEbgrhcLdt7GdPSu4ZI4Gyd/71v5UoQCoer471ojQbbzCyj3
 YgBKI/34O7J0Q0SOWN5ENg6gE/mNojcFdl5OWnVfAVdCIP600obCuOWiK
 +ESQ4Vn/56HSn0R1qw76f2s5ckD7a3GWi0lJsNv4heOiUU3ZjEbkVyTan
 IJ56uPnnf9eKcPOqVgYzCJO8t4WGwArTFGbwPv4o/L5S3/8EjSMUFfCAc
 fxR3vu3AHVUwvje/60Sur7CGnkVw4yAHlPn3PYclOUyHZhnP4tdpQWsPN g==;
X-CSE-ConnectionGUID: vlnQSklrQTemCvYTlkNajQ==
X-CSE-MsgGUID: xT4lwKxrTP2vA3BY21JqjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48412859"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="48412859"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 17:35:44 -0800
X-CSE-ConnectionGUID: Bik6YbO8TP20EuxqylxwGw==
X-CSE-MsgGUID: NV8tfsyUQi6e/Qgqb33U7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="111646891"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Jan 2025 17:35:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 17:35:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 17:35:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 17:35:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCGsNZ0P9mGzuOPpp4HjQOvYaaHAzFaaHnsKh3KehMbpUsXflil3Nh/EHssaTrlhpfo/XO+kTBzP6wuM12j6I7rWMafOJ/iamJLLmm2DsZUkw1Maj/u0ouJ/HjkJsV2lQ/SpWk2AnSEJbo+765HCwhYkL87PM5Fy9pqJXjpTnJ0G4XFI/ftOu9qdjjqGwUeebVJ/lgriG1U9IVj/yC0SrnnJ8KWpXrRkZiBhtZDv3Nin7tROR4uGXQQvZH7oedtdqxuiQ39Rl8m//PlI/z/UTIkIdFJLeuNKK9UyJ12uK81ZFieqkpGxwF3Mhd5SJlvPLZaU+aAoCfA714H6e+y6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBvInePo/iYFilXiTwnI4pnyMlsiaBvYib+LbQtfF/o=;
 b=LD9ElJVAGEDAw5aCSyrK9zKBxxLKCl7xMHK6wdb42QNOgsQVqrh0LmCLfwtEg4780EPJyQI1nG34d7IzkGQdmOpjhhB3D0KdVt+EiSmevkvdI2KmWGqEUeS34ht3+jKt5miIR8gN0RN5hTo2vO2/bReTtQGJ/5mKK0dDe1pj+ES9oEOD6FnLTLcB5PQLXMW7QCDFPY5zpLTzTFFnyzr+H/zU4P4EPBNqgk/Gkl8xp198d+eZq1A2475+edrPJqYDLt1yzvssAVUoqRKTO2SIc3fVLlUM2LKq9FNpvcbgriUzMZKu5f3yauE3kdlDa38QhxInc311mJkN3+Ft/cC/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.22; Tue, 21 Jan 2025 01:35:38 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 01:35:38 +0000
Message-ID: <8e144c26-b1f4-4156-b959-93dc19ab2984@intel.com>
Date: Tue, 21 Jan 2025 09:35:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
To: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
CC: Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Michael Roth
 <michael.roth@amd.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 Williams Dan J <dan.j.williams@intel.com>, Peng Chao P
 <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com> <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com> <Z46W7Ltk-CWjmCEj@x1n>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <Z46W7Ltk-CWjmCEj@x1n>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|DM6PR11MB4753:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fc72e0-9828-4b93-b634-08dd39bbe885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzkwemtJUUJhV1BDSzRlOVVHNFVYR0xEcE8xOVlCWHFtUWw4cFBnekVBdlln?=
 =?utf-8?B?U0RyMFpvQVJaZ1hiNGJlY0FBSzdkK0RKZmZWWFhhcSs4S2pYakxreWxkQ3lD?=
 =?utf-8?B?WWlpbktydTA1amFHWDZ4Vzl0SE1mNHdRVXRMVnlhSzMyT2YwMUVlbm9rZmZD?=
 =?utf-8?B?WlRLdFhxZGNkc01KTFI3Q21YUVIwQ010cmFtOFNLN0Q5b0hrc3NKTzRYTXZO?=
 =?utf-8?B?eENrOUppWVU0cllkdTFPaXM2dGRrajYxa1FUaTRHTFdJUFFvcTQ4bGRHcWFj?=
 =?utf-8?B?MHM3Zkhidzl4YXMwSmUyVkcvZHJoYXRlTzBDeVU2NUNEajRrT0hGNHhlMEc5?=
 =?utf-8?B?eVNOVzdUdnpzcUYvR0N6cXNNbkhwdGtLWWpicWpzR1pqSnRzcFJQNS9sTmZ1?=
 =?utf-8?B?dGR0VWFNN3AxdkFZMmREQ21FWksrUTRhOUxuVTRRVGprYWZBd3NpZ1hYcDZZ?=
 =?utf-8?B?ZE1POVZBY2FnaHNvaXdiOXRrckFxbkcvOC9uUU1KSHlZeHo5WnZGTjRNMWN0?=
 =?utf-8?B?VDFveUhHcGxLZCtPL0docUVvNnF6VDI1ait5SXh1Q3orMk9QQ2lTYkVhMkpJ?=
 =?utf-8?B?MTZzOEVUY2lwRTBJNHNleC9TUm5lWUdqM2FLcTF0aVJrK1RpMkU0VWt4TnUw?=
 =?utf-8?B?b0xHYkEwa1RvQnkzcDBYT1ZHREFQL1FQZFg5Wks5V1JJbWdqY3A2eTZPeFBL?=
 =?utf-8?B?aCtkbjlxV3BCSDhwdHUyVFRZaGMwenIyNSs4a3RWVWsvWGJOQ253cDhNOHA3?=
 =?utf-8?B?UjJjaFVtaElCak96K3hQRzkyMjdEZS9RSkppalNpNCtHRWM5NUNZb3pOVlZL?=
 =?utf-8?B?amdZbmg0UzVra1VvR0FOSUVTTU5Jam1qdzA2enRJRTcxRW54VnQ0a2hkSjJ5?=
 =?utf-8?B?d0pUdVZmYXlJRVJBMy9hTnl3WmptQkM4bDUwNlkwLzNDNlVlUllmRUozdVFM?=
 =?utf-8?B?TEdPM3NFMVIyNmhrQ3BQL0FjdVR1SWErWXZGSG9UdFJDSW55ZlZ1cE9zWjky?=
 =?utf-8?B?TjdlTWJMSytwWWZwOXRiblhXOUd1ZXVEUVB4THpYYzZLbnNQZ0tZQVJZRDRh?=
 =?utf-8?B?UHZCMWNnajk3MCtlamVCUEs3NmJxbDlYeEJZbkswMWVPTWpWcE5PcTh1U0NL?=
 =?utf-8?B?cW5mS1JheXZwOTA0MWZiKzhMeXRtVDJMeE5WNHZseWNrVWpLSVJ2c25XVmw5?=
 =?utf-8?B?d0pSSG5UQmZUVjNqU3gxQmhNajRhMFpETnM4NkJTNndYQVpQWW4rVjdoMHdp?=
 =?utf-8?B?Z3AzLzZ2ZGpRRnhEYVdiSUVHOGFuTVdXR0NSenBjVDhIc1Y3ellBVFozNjJp?=
 =?utf-8?B?S2hmMFBLY1J5emM3dHFhMXJGSHZ1TkE1U2ErcjhFbVBkNkNIU2g2aTloL3pI?=
 =?utf-8?B?ZHJ4a1VqRWFUb2EzRWRBOUdGS2VqZENDNC9kb3IyQjlISmpLanFFdHcwK0Yv?=
 =?utf-8?B?dElvYVE1ck5TejhmRG9wMkszclhRaWlBdldNSGxzSmlSNGxmbndNdEowVk9a?=
 =?utf-8?B?NjNyU0x5L0Q5R2FLZXM2MEtMR2ZXT2d6K0xTQ0RXN3M3RlprZG1HTitZR1A0?=
 =?utf-8?B?SEtCOFBnTVFoM3BNeTNnc2YzM2N4WFR0bHg2N0NjY2F1Y3dER2lTcE5LNWFP?=
 =?utf-8?B?L2F1WEZCWXllQm5EVWFSUklPZjMvMFBrWVdiRk51RGcvc040Y1FIQjFDOWJQ?=
 =?utf-8?B?YlFRWmlFc3M0VWFEOG1acDlXdVo3NHp1MGVHUUlOUUVKTndmNmNrSVR3NVo4?=
 =?utf-8?B?eXRxbGc4SUVUUmtmUUpzL3k4RUdHUjFEeVVHU0gwVmJVQUR5RnppUjBWMFpx?=
 =?utf-8?B?RkRqLzA0cnZYcStSbCtvQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitCQlpIVXNSU1ZWbTRkbm80ZkFMc29ZTmJhc2EvUE1MTUtBcjFqcEhUUURv?=
 =?utf-8?B?YmJjU0krYWg3YTZYQVhDeDIycHZyT1NiZDE0L0ttZE1qSEd2SURzVE4yakVR?=
 =?utf-8?B?VWxnZk9GNFJBcERSUDRCL0VCd1dqcW1yeG8vQTlUVUJyM3ptaUlDdTJOYS9o?=
 =?utf-8?B?WWd4eDZ4S2NtVUlMMUd2cy91aVhQdDcvd3dNOUE5UmJYWUZKWnZRTUdlQ2Vw?=
 =?utf-8?B?VTJ4b2tvUHhqZThTWGFxeUtyeHM4MWJGSWRNczFiNTN1RklHM2NMdkZLVzJP?=
 =?utf-8?B?cmorVEZKSGpuNUpsWFExUEJid1NqYTJZRmJUb2FNR3prVXF6Mlo5aGtVT29Y?=
 =?utf-8?B?WDQxNk13MWV6ZzBsU1Q5U3ZHYldoUFNxby9idUxaeEJDcE42SUNvcGZobFlG?=
 =?utf-8?B?ZDN3U2hvU3ZWNHMwbkJZckM2R2RWVVVTcWhGNTdzYVBERjNodnlGT053WGJX?=
 =?utf-8?B?R1RjRmlFd2FEcDZwdjdtT0huSUFiYWNzcHBWcW5uYjhQazIzOTRyK09MQXZH?=
 =?utf-8?B?RzZRNlpiaGJZZjJKUjA4aXIxd1laQkhpZ3d1NkFiejBwaytSQ3ZRSmVqU3hj?=
 =?utf-8?B?aCsra0dzQ0NrOEt5eTkzVUxJRk5SWVhVZ2xRdkVaUHdoeHg1TFV3SUZCemVk?=
 =?utf-8?B?TGhuMFYySWNLOWdEWWZHTmdzZld1M29hSGZGKzZQVTRUQkZlcW1jTjFEZFNJ?=
 =?utf-8?B?aHVveVZ6Z2ppdDdhZmtrN3o3dzdodmtRaHJsejJWd0ROaFYxSGVBQ2JJa1hX?=
 =?utf-8?B?alYyOGhVT1BNQ2tnRmZua0s1bFNLVmNyZk0wWmZVUXdiRDN1c29jYjBVUmYy?=
 =?utf-8?B?OFJyV3QvaG9Fbk5kOXF3YmNIaW9xdUcxL2xLNGtqU3llSWZLbkJXNGRlYlNx?=
 =?utf-8?B?Z3E5ZURVaVRwVVR6dlptUEVSRGZOeDZBR3FraVJaaWVDeEZic2lkTXBrUG8w?=
 =?utf-8?B?SlhDcmtJSE55UDVtZlQzNmVUNTcxZzNONS91OVI0eTVVaUVidDlpSmFjN01a?=
 =?utf-8?B?RHlXZU9hMzZxTzJ1RWQ4YjZjcTJ5cTY1dzI1T282NzlBNXNMeXZuUVJqVDg2?=
 =?utf-8?B?NW13ZlhDS3JQZ3RLcXUzWExrc1FLZUdKZEt6a1FtdVhWdEN4QWRsUnpqZlJ3?=
 =?utf-8?B?NmZLR0dVSUFsRkI5Nmw1TFdKOWVnUkxpcmtOMUxjdWkvNm56cVlnaTZrZGY2?=
 =?utf-8?B?UVNFcFpjS0RjbjBsRXZ3ZWFUMmowN0hBSVo3YzgvaG1GOGg2dTU3alFReWZO?=
 =?utf-8?B?K2owTmM4M201UHRRak9PN2VvaFpmNnk1c0Eyam9PLzljUGZ0UHZxNU5VT09J?=
 =?utf-8?B?aGluNUdicUdyc043WVRUMGRuZjl4T0NZM1AxL2ozQjgzR2x2T1BwdENoZjFB?=
 =?utf-8?B?eldDclRSdFg2aEtFdzdIdEZhVGN6Wmwrd0V2d2pZK2w3dTRLNVl2emNTR1Nn?=
 =?utf-8?B?bi9uamJkQ1JVN2Q5ZnFJOWhydThDR2M2ZHh2ayt0SUhjTkN2VE9IeUpURzJu?=
 =?utf-8?B?UXdTc0l4SUcwRW9uZjNZbExDUHdlSG1raWo4TTZDSDRKbU9Qem1WamJEZkhO?=
 =?utf-8?B?MkdGdWxUZ1YwcUM5d2czU2tFYmsyRCtVYTd0NThENDh1VWlIQyt6QWc1SXdn?=
 =?utf-8?B?YmVZT0ZEWVloQXlxSHc5L0VGY3FSNW1xT3h6VG9rZzBXNjZoWnlNSDQvbjNQ?=
 =?utf-8?B?aGR5QW5Fb0ZoT3JGTHFIc2lRTG16b1p5OFFyTWtLRkl4d1hneHpGeWpKaHJr?=
 =?utf-8?B?eE1QY0UzSC9HaGhxRjdSZitvZjc0RGl6YUJkcU50c0pKMncydGlFemF1SkpU?=
 =?utf-8?B?WTFyYnZ5OGhYQ0lwVWNGOGhwcUpLaHBBUTVObkM1WDU2MTR3VXVIYnlIVStw?=
 =?utf-8?B?NUMrUTFscDd4cmZHODNkZVJpQjhaeDgyRTVFcmJ0Rnlrd25zTlVPU2xpZmx6?=
 =?utf-8?B?eVhaQ3FkL0FVRHpYMXNxelZ2ak1TZGgyTmdWdDNqdG1UTEFkS1lHWjhGdzJE?=
 =?utf-8?B?Q1Jkc24ydlczRzdXV0hCS21ERXBxVU81QVF5cW5Hc0diMEZpamNVYjNIL2Uy?=
 =?utf-8?B?MGsxNVM0QVhOemV1eTFxRFVxczlHRG1YZTU4NWxzWG5vNXljNnZYTkJFK3pG?=
 =?utf-8?B?Rmx4WkIzTkNGVWNGc3g0RXVKVEtvUUIzYWpqRjB1M0VrcVIzMWtob2ZpWStq?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fc72e0-9828-4b93-b634-08dd39bbe885
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 01:35:38.2874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+QV19u0t1P8Lq2rq/z9sw/S8BtJATBOMOEBxvHCg+bXWxpl7rBkyOdIhs8Rvr+eK08tqLSnvR5EP8ngsqKcog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/21/2025 2:33 AM, Peter Xu wrote:
> On Mon, Jan 20, 2025 at 06:54:14PM +0100, David Hildenbrand wrote:
>> On 20.01.25 18:21, Peter Xu wrote:
>>> On Mon, Jan 20, 2025 at 11:48:39AM +0100, David Hildenbrand wrote:
>>>> Sorry, I was traveling end of last week. I wrote a mail on the train and
>>>> apparently it was swallowed somehow ...
>>>>
>>>>>> Not sure that's the right place. Isn't it the (cc) machine that controls
>>>>>> the state?
>>>>>
>>>>> KVM does, via MemoryRegion->RAMBlock->guest_memfd.
>>>>
>>>> Right; I consider KVM part of the machine.
>>>>
>>>>
>>>>>
>>>>>> It's not really the memory backend, that's just the memory provider.
>>>>>
>>>>> Sorry but is not "providing memory" the purpose of "memory backend"? :)
>>>>
>>>> Hehe, what I wanted to say is that a memory backend is just something to
>>>> create a RAMBlock. There are different ways to create a RAMBlock, even
>>>> guest_memfd ones.
>>>>
>>>> guest_memfd is stored per RAMBlock. I assume the state should be stored per
>>>> RAMBlock as well, maybe as part of a "guest_memfd state" thing.
>>>>
>>>> Now, the question is, who is the manager?
>>>>
>>>> 1) The machine. KVM requests the machine to perform the transition, and the
>>>> machine takes care of updating the guest_memfd state and notifying any
>>>> listeners.
>>>>
>>>> 2) The RAMBlock. Then we need some other Object to trigger that. Maybe
>>>> RAMBlock would have to become an object, or we allocate separate objects.
>>>>
>>>> I'm leaning towards 1), but I might be missing something.
>>>
>>> A pure question: how do we process the bios gmemfds?  I assume they're
>>> shared when VM starts if QEMU needs to load the bios into it, but are they
>>> always shared, or can they be converted to private later?
>>
>> You're probably looking for memory_region_init_ram_guest_memfd().
> 
> Yes, but I didn't see whether such gmemfd needs conversions there.  I saw
> an answer though from Chenyi in another email:
> 
> https://lore.kernel.org/all/fc7194ee-ed21-4f6b-bf87-147a47f5f074@intel.com/
> 
> So I suppose the BIOS region must support private / share conversions too,
> just like the rest part.

Yes, the BIOS region can support conversion as well. I think guest_memfd
backed memory regions all follow the same sequence during setup time:

guest_memfd is shared when the guest_memfd fd is created by
kvm_create_guest_memfd() in ram_block_add(), But it will sooner be
converted to private just after kvm_set_user_memory_region() in
kvm_set_phys_mem(). So at the boot time of cc VM, the default attribute
is private. During runtime, the vBIOS can also do the conversion if it
wants.

> 
> Though in that case, I'm not 100% sure whether that could also be done by
> reusing the major guest memfd with some specific offset regions.

Not sure if I understand you clearly. guest_memfd is per-Ramblock. It
will have its own slot. So the vBIOS can use its own guest_memfd to get
the specific offset regions.

> 
>>
>>>
>>> I wonder if it's possible (now, or in the future so it can be >2 fds) that
>>> a VM can contain multiple guest_memfds, meanwhile they request different
>>> security levels. Then it could be more future proof that such idea be
>>> managed per-fd / per-ramblock / .. rather than per-VM. For example, always
>>> shared gmemfds can avoid the manager but be treated like normal memories,
>>> while some gmemfds can still be confidential to install the manager.
>>
>> I think all of that is possible with whatever design we chose.
>>
>> The situation is:
>>
>> * guest_memfd is per RAMBlock (block->guest_memfd set in ram_block_add)
>> * Some RAMBlocks have a memory backend, others do not. In particular,
>>   the ones calling memory_region_init_ram_guest_memfd() do not.
>>
>> So the *guest_memfd information* (fd, bitmap) really must be stored per
>> RAMBlock.
>>
>> The question *which object* implements the RamDiscardManager interface to
>> manage the RAMBlocks that have a guest_memfd.
>>
>> We either need
>>
>> 1) Something attached to the RAMBlock or the RAMBlock itself. This
>>    series does it via a new object attached to the RAMBlock.
>> 2) A per-VM entity (e.g., machine, distinct management object)
>>
>> In case of 1) KVM looks up the RAMBlock->object to trigger the state change.
>> That object will inform all listeners.
>>
>> In case of 2) KVM calls the per-VM entity (e.g., guest_memfd manager), which
>> looks up the RAMBlock and triggers the state change. It will inform all
>> listeners.
> 
> (after I finished reading the whole discussion..)
> 
> Looks like Yilun raised another point, on how to reuse the same object for
> device TIO support here (conversions for device MMIOs):
> 
> https://lore.kernel.org/r/https://lore.kernel.org/all/Z4RA1vMGFECmYNXp@yilunxu-OptiPlex-7050/
> 
> Thanks,
> 


