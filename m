Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1CEC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvC2c-0000Ik-5O; Thu, 20 Mar 2025 05:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvC2a-0000HE-3m
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:18:16 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvC2U-0002Rk-10
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742462290; x=1773998290;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1EaW/IwdATVYf02aQv4o2sEI/VB/kApwwMExydbc+U0=;
 b=YvhIRCB8VG0qMUGsvLgiaDEdT3QWXyfve+h9kramHGggMp9z7X5P4wUf
 MGuTOejAzfNAxwBMDa8Xi6yvuXI75CNUYWjUQpr9tLFVMPWSFYItVq9VF
 aaJo1Q1qPxsX3TIHAnKuEOL3uinay+af+QGq1/BVBKKSjfsijqKdmJ/tu
 fLy3vgLpBc8Dkn/TBL8vJXvrTAAb5Ph6FmVF8g0zaJReQmNPf4rcbgA3f
 4BDPzyzMXCR25uOtuQ51OgVrqo4F8glSzzTPQNyNIXcbv2fQlooi9+X+8
 palpc69FQAMmphC6METZwMwSg3E5ggKIZJ3l3Z59NShXzbJTQg99IsjdV A==;
X-CSE-ConnectionGUID: s7AYflimQd6DvizGxe5m6A==
X-CSE-MsgGUID: g4x2IOTHSEe1gTn20h/49A==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43850359"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="43850359"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:18:06 -0700
X-CSE-ConnectionGUID: QlXojqbmRSGGAVNYNtP65w==
X-CSE-MsgGUID: r5yTt+iKTOeGqOks2UwjlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="128264362"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:18:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 02:18:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 02:18:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 02:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI86/EjQmhrO1Q2Th6T5UzoAOM48cG82vVVC83Kw5gpd/DCj7puu597lcmpKccdHME6aLVKr6mFnJW9AHOTRAsN1GvpXGJWNQ0iZIodYPqZnxAiuF2qxMm+VPUxTT9Pan0IYmGmWha9fqGvB1xJtX0vLtd926ED3llPb+A2G7lpSAEvXeRxRYiXcje2dA5e3qb0eVK18Zg7J1ZAyVVUEr4i1nESsjuEIJgfd3WGKaEzDLilVbkTqlVvJc4MvpMbFfTyuuXtxRl2HL1m/Yq1LM73sk9LxOL3hsONGVKdHzSnXJssYtfG1nqv3BT5166g02WZBX9zg/LBxsCujGiIz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EaW/IwdATVYf02aQv4o2sEI/VB/kApwwMExydbc+U0=;
 b=SQKWFnJ6TDJuZYKDWZo8Lkuc/jXGQxZeEWqFr4XomKWW60JXdXnEJtKRPU5mHAfcSUFUbRkclidEVW/Y5Rg0j+3K5l57N/Ss9GU1ZfY0U4EqMlUQMwQ6UwGF9xvWmQWocMDfQiCEsVEG2URn7xZWxpE3McoxXYs1xiYvrAolWpkB2aKT5xxyTfOFKfcAWCtjHNte19xhHIL9ABQKk68A+wkdOGu44TGDjJI2tSe/Kwvjf6MwQ/KO+yAGZx4jSQbyCUg7XdKZ+VfSrAXowc4GprsGhEKUAWEyLXK6ygl5CA68bE2jhidlQhKb9wmtYKnnz7ieM6UzrmydzvlrA7ZYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 09:18:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:18:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH for-10.1 09/32] vfio: Introduce a new header file for
 VFIOIOMMUFD declarations
Thread-Topic: [PATCH for-10.1 09/32] vfio: Introduce a new header file for
 VFIOIOMMUFD declarations
Thread-Index: AQHbl+vrwwYtIpr72ku8grJ7eW18abN7wSow
Date: Thu, 20 Mar 2025 09:18:03 +0000
Message-ID: <SJ0PR11MB6744FA99CAB466E2D89F987E92D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-10-clg@redhat.com>
In-Reply-To: <20250318095415.670319-10-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB5278:EE_
x-ms-office365-filtering-correlation-id: e40d4d10-0796-4d70-81b3-08dd67901e15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZUFHVEYrLzhjL01NWndPNGtoc0RsZFdobG0zQm95VncrYmF6VTEvYStkZVBI?=
 =?utf-8?B?UDFsbkRTWkhvUGNpNkQ0Q2x3d3JZTk1tOTJUWUJTUEVGUWJhdjNPR2wyaEdm?=
 =?utf-8?B?eGdObUVaVTdlUGxuYVBuTHNtUHZjRkpQamhkaW1FYkdZQ1N6VFZwMXRoTkor?=
 =?utf-8?B?Y0xqcEwwdSs4UndOOUV2TnNvTXBYSzZyN01jTjExL1ZNQ3BidU0zT3g3TkhZ?=
 =?utf-8?B?TFh0ZGIwWGtLQVA1aXhENHlhM3A0bHVBeU03Q1FJa2piakU5c3RzTVVzMGpM?=
 =?utf-8?B?OWtCVStveFhCejdUbTNLTkdLYktrMlNORHpSNHJHNzVqMlIwVkovZDlyZkhy?=
 =?utf-8?B?QThnVW1UYXJxNVFydmxNNExoMHdaWktFUTBLWmhyNElaOUNNNjJ2alpGUFZo?=
 =?utf-8?B?N0lZUCtieXJwTnNzZ0NvVzJlelVKQkZIWWh1MzdlclNBaXQxYjFGaHozNUMw?=
 =?utf-8?B?dmdyLzNCVC9jMXBvTkdqdk51K3NKMFc3SzV0NlVnczlKbHhrazk1Z2JxTFA5?=
 =?utf-8?B?VFBWOVBUZ29OV0JDcmVZUFhhNnlsNENCSE83MTJuWlp4enBYM1BnZWRiMEdG?=
 =?utf-8?B?b0ZhY1ozdjZpd2xCUThJVmNCNzJQYVdoNGdhV0w2dGRQdVVBUVJ0Zi9wait6?=
 =?utf-8?B?WTdiaXA0SVFWT3lSZk51cFZyRWNHVmtHN09HUXBKRnpwd3F3WEllaDlYT0tk?=
 =?utf-8?B?dzZXS2E3c0pCR3dVTjNEU3JGWlowZE1FT1crZjdWeElMZmoxa3ZiWVdKVjhC?=
 =?utf-8?B?azhya2cwRHRjWk9TQTZyMjVwbCs0cWxwUDZzdVBjczlzY1JMOFFYZlFrbG5I?=
 =?utf-8?B?eU9YL1NoQjhnMzNYQllpYk5lWURpRFVESDdLb2lSQnlydUZ5Mk9VYXZuWjZV?=
 =?utf-8?B?SlNzem9Bc05Oc1RFQTFjNGFRT1hyS0xJTVVHVnUyL2krODc3TUxkUU9PdzVr?=
 =?utf-8?B?eTJ0QUFVR2EycThjZXZHb2xzcTBoVkE5Wmw0ZnBRWHd2S0RIM3Q5VjVZeExl?=
 =?utf-8?B?RzRrUzcrRnZQZ1J5aWZEcS9qbWk0WEVicUEzOHB3aWM1c2l2VGZaNHFLVndX?=
 =?utf-8?B?ZVl1UWdva20zUUIvbkZJbENnUDNWTkVlRVEyUFlpS3VCd0p4ZjVUOGNZRmhH?=
 =?utf-8?B?OW9saThCVzN1aHBHVnVVcVIrOFE4TzYyTC9jNFhNUjl0SXJWczNJU01rbjU0?=
 =?utf-8?B?dUpQQ0phNlpFZFMzYmJVNVcrN1V0N2NVdlNlV2dHRmJEWUpCQ29RMDNab1R6?=
 =?utf-8?B?VWxKZWFlNVNibUxUeWVpZUh2UEVlRGtUQTJPaDIvbXlwWVlES0x4bkRyWTMx?=
 =?utf-8?B?WWt1ODJyQ0dRRGd5VDZsYXZYb3hNdGVtT2RCNUxwbXA3eGdIUEdxckNNSUJp?=
 =?utf-8?B?REhLeW9oZnYyLzFmNDdnRHFHbTJ5dFpscjlCTFhoclgzMWJHNTUzRm5sYWpU?=
 =?utf-8?B?ZStSaUdESmd3QVMwV2hldTIxRWI3TDJCeDZBUlA1NTErMFFwWjlLcGJwajd3?=
 =?utf-8?B?Z3RLOUkreGZDN3NVMTM5Ymx6OHR1b0YydktPUlFZQ1hRUkpxMVVnZEhTTGNO?=
 =?utf-8?B?dkJZUjVER1VGemJHQm9uQVhsQmRWNk1kTExkSTZRVXJnQ3hLZmJDOU5LMXNW?=
 =?utf-8?B?bmN0d25Oek51dG1YbDBhVXp0dVErT0FMRmFJcnRGQ2tjSGRSc05IOUR5czNP?=
 =?utf-8?B?Nlk3WkNKamdHcHVaZHN6NHNWbjFUb1hVenBHZFpCY1ROT1QyS2hoVXNUalZq?=
 =?utf-8?B?REFGZVhXcWlHVFNBTm14SEVZVExDMGtVOWVDZ2ZTUjBWVFFBUS9LMXFIaDZq?=
 =?utf-8?B?SU9pN1hSQ2NtQ21GaHVnTU9IOE4yVjhmUWsvemxWdDQ2cTZrcjlMcW1keUhD?=
 =?utf-8?B?blhzaHp0SEErYTltK21MczU1cUtoeVF6Z1JrdGhVMThSeE80THJNMk5zTXdR?=
 =?utf-8?Q?pzejCCMANITM2qqIhwEfCvYURi78sFaj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0Z6UVdTNjRRdzFKcGtKY1AwbVNtZ0NpWTlSQmJ4UDlKNTlHY2MvM29Hd1lz?=
 =?utf-8?B?OTVLeXhhRzRwVVZqM0c5aWszMG1CZXVSd3dVMzdoYzJJYm5NK0NHcDUyZUNX?=
 =?utf-8?B?blpTVmtQdFJ0dENMbGVuV2RnK2NEcWF6ZlNZTXpQRWNHSU1JZDQxQzFPVGYz?=
 =?utf-8?B?VkNrdUdNZ1pacUpGb3NuREhKdWhscDFQbGlkLzNHbG1zM0taOFhvRmtEeWRT?=
 =?utf-8?B?Nm4rdjlIQTdjNXRUVDRkQVNGSE4zT3JEdWpVOTU0Vmh6dyt0eW5tcFdBVHBS?=
 =?utf-8?B?OXBHNzdLR2JKcFdmTWtWSVNST0N5YVRSTjRHWXpNRHV6cmdydTUvMUFmVEdB?=
 =?utf-8?B?ZEVuUnJ5SksxSGRNQU1sVzNEbFZrczJIS1RrR21pK2FUMnYxUGRZLzJ1d1hL?=
 =?utf-8?B?azdKOGRJWG5yNzRxa1BjL21JL0I4Ly9HSllUZy82V3JnR1FmZkVqSUtTT1VT?=
 =?utf-8?B?WVNuOWllUVBib050VVgyNzZLU2lGU3BFald3U01udWZhL2hNSWVESmNrSk1J?=
 =?utf-8?B?K2JRblZIcXhFaGVpNko3ZGxCVXhRZ0hzZ3JNZ3lXSkZRUnEvN2toWlFmZ1BX?=
 =?utf-8?B?REJlV2d5U0prckxQek1WeHZvd0pDZjNjcHY1U1M4OCtzMWxPUTA3Yytjdmgz?=
 =?utf-8?B?OFIyRGlKaEF4czJ6WW9OVFlvT1VvSXBWR3AzUW9MVEhpSU1iaUMwKzdyVmNP?=
 =?utf-8?B?NHJoVlBuRUxNRDdQQmN5K3RaTkxzbm01MjRyNDVac2xvUitDdHN2VjlZd1Jt?=
 =?utf-8?B?ektVYXhJeDVFL1BuOGNyUGJBbnQ1NytzMENXZG4rV1dTemFLRHBvbjJnZS9p?=
 =?utf-8?B?RWN4YlZlQ3IzaSs4NXhsblFScFFDYzY3UEFwN3I1SVMwbXpYb2g3RlhYTlRp?=
 =?utf-8?B?Nlg0ajZsVGNvYTk5a0RtRWhrM2ZEQWxFcjFocjRYd1A0Nk16bitxVW1mMy95?=
 =?utf-8?B?NUZXVkhJbUhvZXU0MEhraFlyakdtbnRqRStuQlNNM0ZscGRCZVpqY1VQK2NX?=
 =?utf-8?B?UGM4TGw5Q1N6dFBnTVFDa3Jia09SQkZSMm9WOXdoUzJMZ0V0amJGYTMzbzMx?=
 =?utf-8?B?YzczcjFveWJ5NE5DTUlaTjBpOVNLNytOQ2JZWTk2NGl2UTZKbG1iZDVZUFBF?=
 =?utf-8?B?bmRwSVNwdXVjcmZpeHNPS1k5NVJLRExYNlNvbXVSTVhYK1hLVm1TbkErZ1J2?=
 =?utf-8?B?N09GMTdJUHh4cU1OT1lVWjlmdGJ5NGM1REZFQXh4RitUdUQrMnJhejEvYUVP?=
 =?utf-8?B?Z3dqeERTK0JvRkJSanJJZTQ2V1dDMWF3S3J2QXJJOTk0ZXRsbk9vbDBXaWdN?=
 =?utf-8?B?QmdXb3pPaUFQZnZZcFJYTlQybUdWeHUrZmJvbHFmZ0VJcElWOVMxTXlVM0NG?=
 =?utf-8?B?VmhjU3JtdTZkeFBhKzJGRmY4ZGhtUTE1TktYKytKUzZ6bEhXdTY0bnozWFhC?=
 =?utf-8?B?NHpxK2xwb3QvMzlhd2ZxQXowcmdzelp5eVFlTVBpUVVKVVZONmRKZDRxbzhO?=
 =?utf-8?B?b3VHNEU4U2R0UHg5RTNOSDFuN0huSVZwNUtMcmE2ZCs2bDNVODFlR0JTckRt?=
 =?utf-8?B?SXl1THdzT3U3T3FuU2czb1p6OG9DalUvMUhxNm90dkFnVFZnTUlGZUhEaVRx?=
 =?utf-8?B?enF1VWZnbUdtT291a3RWMzdTMkNlQ2ZyRmlYZFYyMHJEajF5TnZwM1VnRTZR?=
 =?utf-8?B?WjBUWE5ObXpQNk9oOU1rd0tGU3VKcENwbE5YdHUxbE9YRGZOWjhob1U3bytO?=
 =?utf-8?B?Z1RaYzV0ejhIbWpkZFFPK2lNZjBqdHkvSHNIK2cvWUFiVTdNRGNsVjBPUnNO?=
 =?utf-8?B?RGh4Y3QzdU15RXdyanBmZG5GQm9YV2pxbW11SGlJMnllSUxtaEpHa3k3c3dx?=
 =?utf-8?B?WlFsL0pOVXBzM1FkTHZwSUFVNjZaeEtYT3luVzdITEprM3NpSWRLUFhBcXFm?=
 =?utf-8?B?OW5acmtwNHBJdDNncHRSSWlmY2lEZVp5a2tGNGw1QjBidjBDYXFtQ1EyYmlT?=
 =?utf-8?B?Smx4SjFqck90N293VDNuMGFydDFOb0FUWi9oQVRqcGVJMDkwLzhRNUFrdjR3?=
 =?utf-8?B?ZVVCd3o4cERRNllxM0w0WTNQYWZTL3RSVVpXOVovaVVSSGttS0U2ZjJYcisr?=
 =?utf-8?Q?Aadt3gTMVR8DKsImViDkK/kEb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40d4d10-0796-4d70-81b3-08dd67901e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 09:18:03.3554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJ7NZkb3zsMV+hjQTQ+WPbC/Ojpz9JaIvsyDZMiHeTFQqnij/hqdOz6UODhopgPnRqLWhWRLHnuVZ8CSjMdjXaZME1s9YL7SbBbgsUKlK8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgMDkvMzJdIHZmaW86
IEludHJvZHVjZSBhIG5ldyBoZWFkZXIgZmlsZSBmb3INCj5WRklPSU9NTVVGRCBkZWNsYXJhdGlv
bnMNCj4NCj5HYXRoZXIgYWxsIFZGSU9JT01NVUZEIHJlbGF0ZWQgZGVjbGFyYXRpb25zIGludG8g
ImlvbW11ZmQuaCIgdG8NCj5yZWR1Y2UgZXhwb3N1cmUgb2YgVkZJTyBpbnRlcm5hbHMgaW4gImh3
L3ZmaW8vdmZpby1jb21tb24uaCIuDQo+DQo+U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPi0tLQ0KPiBody92ZmlvL2lvbW11ZmQuaCAgICAgICAgICAg
ICB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IGluY2x1ZGUvaHcvdmZpby92
ZmlvLWNvbW1vbi5oIHwgMjEgKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+IGh3L3ZmaW8vaW9tbXVm
ZC5jICAgICAgICAgICAgIHwgIDEgKw0KPiAzIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMo
KyksIDE4IGRlbGV0aW9ucygtKQ0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvdmZpby9pb21tdWZk
LmgNCj4NCj5kaWZmIC0tZ2l0IGEvaHcvdmZpby9pb21tdWZkLmggYi9ody92ZmlvL2lvbW11ZmQu
aA0KPm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+aW5kZXgNCj4wMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwLi43ZDg3OTk0YzRmYWRiYzMyOGI2YWM3ZjlhZQ0KPmUwMDQ2OWRk
ODgwOGIwDQo+LS0tIC9kZXYvbnVsbA0KPisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5oDQo+QEAgLTAs
MCArMSwyOSBAQA0KPisvKg0KPisgKiBWRklPIGlvbW11ZmQNCj4rICoNCj4rICogQ29weXJpZ2h0
IFJlZCBIYXQsIEluYy4gMjAyNQ0KPisgKg0KPisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcg0KPisgKi8NCj4rDQo+KyNpZm5kZWYgSFdfVkZJT19JT01NVUZEX0gN
Cj4rI2RlZmluZSBIV19WRklPX0lPTU1VRkRfSA0KPisNCj4rDQo+K3R5cGVkZWYgc3RydWN0IFZG
SU9JT0FTSHdwdCB7DQo+KyAgICB1aW50MzJfdCBod3B0X2lkOw0KPisgICAgdWludDMyX3QgaHdw
dF9mbGFnczsNCj4rICAgIFFMSVNUX0hFQUQoLCBWRklPRGV2aWNlKSBkZXZpY2VfbGlzdDsNCj4r
ICAgIFFMSVNUX0VOVFJZKFZGSU9JT0FTSHdwdCkgbmV4dDsNCj4rfSBWRklPSU9BU0h3cHQ7DQo+
Kw0KPit0eXBlZGVmIHN0cnVjdCBWRklPSU9NTVVGRENvbnRhaW5lciB7DQo+KyAgICBWRklPQ29u
dGFpbmVyQmFzZSBiY29udGFpbmVyOw0KPisgICAgSU9NTVVGREJhY2tlbmQgKmJlOw0KDQpEbyB3
ZSBuZWVkIHRvIGFkZCAndHlwZWRlZiBzdHJ1Y3QgSU9NTVVGREJhY2tlbmQgSU9NTVVGREJhY2tl
bmQ7JyBmb3IgYWJvdmUgbGluZT8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPisgICAgdWludDMy
X3QgaW9hc19pZDsNCj4rICAgIFFMSVNUX0hFQUQoLCBWRklPSU9BU0h3cHQpIGh3cHRfbGlzdDsN
Cj4rfSBWRklPSU9NTVVGRENvbnRhaW5lcjsNCj4rDQo+K09CSkVDVF9ERUNMQVJFX1NJTVBMRV9U
WVBFKFZGSU9JT01NVUZEQ29udGFpbmVyLA0KPlZGSU9fSU9NTVVfSU9NTVVGRCk7DQo+Kw0KPisj
ZW5kaWYgLyogSFdfVkZJT19JT01NVUZEX0ggKi8NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92
ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPmluZGV4
DQo+MzM1NWMyZDRlNTc1NjlkN2JiMDFiNGQ5Mzc4ZmI0OWE4MDczMzVlOC4uOGQ0OGY1MzAwYTc5
MWQ4ODU4ZmUyOWQxYmINCj45MDVmODE0ZWYxMTk5MCAxMDA2NDQNCj4tLS0gYS9pbmNsdWRlL2h3
L3ZmaW8vdmZpby1jb21tb24uaA0KPisrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5o
DQo+QEAgLTY5LDI3ICs2OSwxMiBAQCB0eXBlZGVmIHN0cnVjdCBWRklPQ29udGFpbmVyIHsNCj4N
Cj4gT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoVkZJT0NvbnRhaW5lciwgVkZJT19JT01NVV9M
RUdBQ1kpOw0KPg0KPi10eXBlZGVmIHN0cnVjdCBJT01NVUZEQmFja2VuZCBJT01NVUZEQmFja2Vu
ZDsNCj4tDQo+LXR5cGVkZWYgc3RydWN0IFZGSU9JT0FTSHdwdCB7DQo+LSAgICB1aW50MzJfdCBo
d3B0X2lkOw0KPi0gICAgdWludDMyX3QgaHdwdF9mbGFnczsNCj4tICAgIFFMSVNUX0hFQUQoLCBW
RklPRGV2aWNlKSBkZXZpY2VfbGlzdDsNCj4tICAgIFFMSVNUX0VOVFJZKFZGSU9JT0FTSHdwdCkg
bmV4dDsNCj4tfSBWRklPSU9BU0h3cHQ7DQo+LQ0KPi10eXBlZGVmIHN0cnVjdCBWRklPSU9NTVVG
RENvbnRhaW5lciB7DQo+LSAgICBWRklPQ29udGFpbmVyQmFzZSBiY29udGFpbmVyOw0KPi0gICAg
SU9NTVVGREJhY2tlbmQgKmJlOw0KPi0gICAgdWludDMyX3QgaW9hc19pZDsNCj4tICAgIFFMSVNU
X0hFQUQoLCBWRklPSU9BU0h3cHQpIGh3cHRfbGlzdDsNCj4tfSBWRklPSU9NTVVGRENvbnRhaW5l
cjsNCj4tDQo+LU9CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKFZGSU9JT01NVUZEQ29udGFpbmVy
LA0KPlZGSU9fSU9NTVVfSU9NTVVGRCk7DQo+LQ0KPiB0eXBlZGVmIHN0cnVjdCBWRklPRGV2aWNl
T3BzIFZGSU9EZXZpY2VPcHM7DQo+IHR5cGVkZWYgc3RydWN0IFZGSU9NaWdyYXRpb24gVkZJT01p
Z3JhdGlvbjsNCj4NCj4rdHlwZWRlZiBzdHJ1Y3QgSU9NTVVGREJhY2tlbmQgSU9NTVVGREJhY2tl
bmQ7DQo+K3R5cGVkZWYgc3RydWN0IFZGSU9JT0FTSHdwdCBWRklPSU9BU0h3cHQ7DQo+Kw0KPiB0
eXBlZGVmIHN0cnVjdCBWRklPRGV2aWNlIHsNCj4gICAgIFFMSVNUX0VOVFJZKFZGSU9EZXZpY2Up
IG5leHQ7DQo+ICAgICBRTElTVF9FTlRSWShWRklPRGV2aWNlKSBjb250YWluZXJfbmV4dDsNCj5k
aWZmIC0tZ2l0IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPmluZGV4
DQo+MmZiMmEwMWVjNmQyOWRiYzI4NGNmZDk4MzBjMjRlNzhjZTU2MGRkMC4uYTIxOWI2NDUzMDM3
ZTJkNGUwZDEyODAwZWENCj4yNTY3ODg4NWFmOThmOCAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2lv
bW11ZmQuYw0KPisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+QEAgLTI2LDYgKzI2LDcgQEANCj4g
I2luY2x1ZGUgInFlbXUvY2hhcmRldl9vcGVuLmgiDQo+ICNpbmNsdWRlICJwY2kuaCINCj4gI2lu
Y2x1ZGUgIm1pZ3JhdGlvbi5oIg0KPisjaW5jbHVkZSAiaW9tbXVmZC5oIg0KPg0KPiBzdGF0aWMg
aW50IGlvbW11ZmRfY2Rldl9tYXAoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIs
IGh3YWRkcg0KPmlvdmEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByYW1fYWRkcl90
IHNpemUsIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KQ0KPi0tDQo+Mi40OC4xDQoNCg==

