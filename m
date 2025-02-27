Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD19EC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 03:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnUYr-0007uU-UT; Wed, 26 Feb 2025 22:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tnUYq-0007tu-5C; Wed, 26 Feb 2025 22:27:44 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tnUYm-0005XL-Of; Wed, 26 Feb 2025 22:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740626861; x=1772162861;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=69RZLgnbvEu9VyzGjRSxx0B2DyiNkZ1bnw6o4IxH6Ss=;
 b=JHDs717stnsN245R7dSvch8SGPf04WnnU9KzakGmU/EtGBwWCReiJcbi
 7Z/LeBvQlZ/kaTI5JF8L/ywBGS8ahELEAxoxlDST5HJ9iIU3153TSWCF2
 f8yzw/hFH/2HvI6qwo782lQHhBJ7QEeW9C5xNy90c+/orQE3RnF9DoWXo
 w1FcANx1wVaowPL4SjyAfw1+7m+kFKoshfMcTFF15LGjshACVxTB5FxdW
 4JWPRsOEUQ9t6vyMx0rmh8lOHQ/4WdJopF9cwIif+cyCS4LnivUq0JX9y
 VRoFTYFUno2GY2wsRMgxQZ1Vern4QmTkUPQU+iJbXGkELdV347vCxq4TM Q==;
X-CSE-ConnectionGUID: FeRsezStSVmbbYKyfkR0pw==
X-CSE-MsgGUID: hBQDlFZXR72gjjRAKua4fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45156973"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="45156973"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 19:27:33 -0800
X-CSE-ConnectionGUID: PA/8Sxh2R+SfG7TAAAGPjg==
X-CSE-MsgGUID: r0v0YyvXSZ6c9HiSJtQwoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="122152744"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2025 19:27:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 19:27:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 19:27:31 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 19:27:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEESqSoRVQaYBYl+KoCvBOGs1WOQvXQG88FrCnrtGMnfCL1QqInHVTQ+zNKrBThaBntFiGBCXVbojaqX7njgfAMJTZM0r6Kg2oivEB3dhU3tRlXvA7I87SZL26iA+EuUMvVTcBTmpkP2txV5CFzi3Li+hlZ6QC9GRN10RAUmCOmuigeIBiiRB2A8qFK1e6/lAOqxyMcA3tsjkssftvstBznBMql7CMPBEThHHNtgwmTZRkKKLKCHiOxsKBhqjT77ajESCDzWoM+iXfkauwp5jFl5dMSzAtdAF+UBjOvG9mj+awrLYtyIi86lgTPQrAz0i3Kdt8Popo+hSRjs0AZfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccGTqL8BZ3pRe+f9WGRkwk7tf+SjjXR+pAf1SNV/WcU=;
 b=WJaB8r8vXJlxOhaldPh8FBL3dU4hm+RQ2tbWjCbgklkz80RRr/213RPDJMC9C9Nb9nA1/1bJLPbSFgGnB4ZNRupk/hpBM7v0Ar/B8nEjDyx3xiadm8ZeUSwZc/m6CVhNt0733bt/CzyrpiTSv2YINqv1kvnboY8vt5TgpZPBX6GEXXDZ6hi4QmJhYCwg0r4/cFW9/JdWc9uaUB8Ws80SZTk0HQJAd6ZEoARWHErdvI4haZ1ZoYhcGqVfwzYxAYAoI/G9+KSzDsPfkgy5JL4p8J1PZtbEAYsfJ/gnl2eiYDROlsEmgBKaOm6EGNM+zWHgkXmTlXLoLGJ/2sOfhaKC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.22; Thu, 27 Feb 2025 03:26:46 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 03:26:46 +0000
Message-ID: <39155512-8d71-412e-aa5c-591d7317d210@intel.com>
Date: Thu, 27 Feb 2025 11:26:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, Alexey Kardashevskiy
 <aik@amd.com>, Gao Chao <chao.gao@intel.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
 <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
 <75d90f78-151f-4169-84f5-cc3c13180518@intel.com>
 <ce2306f9-19a4-4979-80e6-29b1e8a92318@redhat.com>
 <108be3a5-cfc1-4268-a913-3a41d1e4451f@intel.com>
 <16cb9605-ba4c-441e-8709-369a37655b4a@intel.com>
 <4a589056-b331-4dde-aa77-9129106a14c0@redhat.com>
 <b0e11469-775e-45e3-bbcb-319557c20a47@intel.com>
Content-Language: en-US
In-Reply-To: <b0e11469-775e-45e3-bbcb-319557c20a47@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SA2PR11MB4892:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a048fd6-75c8-42c7-5524-08dd56de9016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akRoRTJTQWZTVGZBQTZKMjUrc1dOMXoydVhUNjZrd1dLQlFUQkozcG9xcTVL?=
 =?utf-8?B?Q2RjZWViU2VsMnEwcFRZU25YYXBldHYraC9wWUp1ejAzNU5EYWlXWXlPdUZs?=
 =?utf-8?B?L0pUK3FYeGEzZG1RTmpaYVRWVGdsSERVcDFPQ21laXV1ZVUzUFd0ek4xZjdh?=
 =?utf-8?B?eEhQcTdER05TVmVPQlN3ZE5WdThWWUQxUWZhU0JnakN6UkJPam8vNTBUanZD?=
 =?utf-8?B?VVQ2TFppUHRHd2pQeStKWVJ0NU9WWE1DMDcvWlA0eHF1OGxiNmJ5OXF4MFo2?=
 =?utf-8?B?Q3h3N25PYTU5c3czMjAxRGQyVVFCTXFZRzVyTU5sQk81ckpMdkZwakkwRlNo?=
 =?utf-8?B?eFM2QmRhYVVhUk9VejI5SHhaQy9kajlUZ3dOL0t4RkZZSkpYbUZYcDlNcjR6?=
 =?utf-8?B?bGxhU0RxcDVISkc0b01SUXJFMXhVTjg2djVublhRYWlhL3FSRFdXWjdEYUd5?=
 =?utf-8?B?TVV5UmdTT3hRUkdjMHNKUDdTM05VVmkwUldrT2NLelJWY1BYRVUyckt5OWc1?=
 =?utf-8?B?bHBDZHc5TDZZNy9EUVphcjBZU0xFeFVzR3ZSbWlMVElWYks5QTgySjRJQWt0?=
 =?utf-8?B?akoySEtaMnJSeEFrclFXLzJMRlVVcUVVbkdDSXVJS05sRWFDVUpNK3EzajBQ?=
 =?utf-8?B?RnNneVFmeHJlM08zeHhtb2k3cmlFRW1zb2VHVmRPS3FENFJDR3AzTDNJcE9m?=
 =?utf-8?B?VEFOSjZxWVc1eW50UERBNk9Rc0k1V0ZKRmkydUlBa2Z1UVVJU0R0eFBvVG5N?=
 =?utf-8?B?RUdyNUkvMjZLREhMYnNURHBpazhiVkRodUl4WGk4b0VJNFNiZzZCbjhUSXQ1?=
 =?utf-8?B?M3RIUFB3Q215RUs5WVBiSE1zMytwcnhFLzJzWGVMTjErZ3llTkR4L2RFNjJ4?=
 =?utf-8?B?cDBqNWRqZXpFck5MOGlTN0lKTzVVcTJRSXRlWkZHT3JCYlFqTjNUSm1IVU90?=
 =?utf-8?B?cVhKZjZHNDNuancwcllSQ1hCa2tJclJsaWp4RDhSTFdBTzJIejhPZHlwMmVF?=
 =?utf-8?B?VTBSQ1NqdHA0QlhnK3pkWEQ3QWdtbHp3TlhlVW50ai8vakkxY1FPQTdjck9Z?=
 =?utf-8?B?a0JxWVBTSkRvY1lzeGQxeG5lVFVRTENIYVZ0Q1VSTVljcUt0YlhLRmJwaFdG?=
 =?utf-8?B?YnkvMFhaZG9mMkpKYzA2V2l2OXBjclpvTG41cVFQUWo4MVNnWFd4K2VCUS81?=
 =?utf-8?B?cEU2dzZRU1Q3Y09rUWVkYXdPZE9sZ3o0Nk9WK1IyVkQ0d0JsOFAvcFZnUlhU?=
 =?utf-8?B?M0g3R0ZQaXNaTXJwUEttYWRsd2Z2TmdrUFZwdDJtU01uVEtjMG5QM2tCUGkz?=
 =?utf-8?B?OGxTQlRpMXRkRXhrL3c2NWxMbFhpQjU5emYwQ0U4czVlQVRWT1B0dG9IbjF2?=
 =?utf-8?B?YWljb3cxSFFCRmdQZjVnbHMxN1Z3eS9WSGlzUHRxRisxbzUvOTNWdlhNVzFF?=
 =?utf-8?B?a3REUmMvZFZMZkw1VEdxaW9JcEh3T2pNY0ZyZXhRcU00cVVxcTZ6aHpRMFB6?=
 =?utf-8?B?bTA3OVlyQ2NMWkxvOE1ZYUlWMEx4amdxWE1GclNYa2MyZmc4U3VKaFpJaHFY?=
 =?utf-8?B?MFg5VkNTZ0hURFU2cUEwcHRheHBsWjF2eGw0V1VaaDEyVEpWbGFydVNYNk9k?=
 =?utf-8?B?eTVkakU4RnN1d3gyWWt0K0JmVlpaZTljbG5ESW1OVVQ3TmtoeURYb0RpYzNv?=
 =?utf-8?B?cXBLeGVpMDF4TEErd2ZSVE4vWTNQVE5wM09GeHF4QWNkM3JhTjhnSjh2VFEx?=
 =?utf-8?B?dTBiZHJWSlZhUGRUNUVKeDhlS1FHYUdxN0NRZHE5bGc1ZEtrRFZKZUtOWTZy?=
 =?utf-8?B?OEFDbVBQTW9EN0VXZ3V4RWdyVWs0bGtkeVRIakloYlNsUUVnbTM1eWlHa3NZ?=
 =?utf-8?Q?O6axX2aCBLe79?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anNyd0JsOXJ2RHZlT3RTTlZ3RkZHU1gzVEFJZ2JMcnBHNE9haExTZXhpOXVs?=
 =?utf-8?B?WjV1cHRYeGtRQklteTRXNEh6ckhJOTV2QW96dXRmNllVeWtGVzZkWmVzdzl0?=
 =?utf-8?B?akVaQk1yTDd1dUFrOUxGUVhGcjRjanBtMnQ5U3VteUdvTVBLanZQZTdsNWpo?=
 =?utf-8?B?eExLRU4rajFBOXI2UDhQWE4ya1h1R3RGQXNxYkthVWd2M0JrM1hQMFlqbnVG?=
 =?utf-8?B?QUZhZ3NEODNodEUyeVc5YjFtVXRPZ2twTnNqNUZhTEdNSTZyNVVRYVhySS9k?=
 =?utf-8?B?OVBMVjFPYW9ZL1FjQU8ydFNjaExpVEJEcnZVRG02RjhwYkxYZ0FyMzVVODdh?=
 =?utf-8?B?UnBFdnRkbEFkMlA1VXlMbGlta3lvK2FMUGRzN2xVbU1BYW01SzlvalZERlVH?=
 =?utf-8?B?TThWaENhdC9WOVY4Szh1NUZTUHFOV2dEZzhtUjJOd3RybWE1SlFMYWpxNllJ?=
 =?utf-8?B?ckhQekt4UVFzNVoyOXBtSForVnNkU0pzcTEvRGxQeC83OFBlaGw4OXJzRzRt?=
 =?utf-8?B?MUpVVXl4dnNTS2NjaExtNU41N1h0QXlUM1hiS2p4UHFrMGhwY1R0RFpGdndB?=
 =?utf-8?B?ZVEwY25EZzk0bW5rUUJxOEQ0Y1RDMXdsbUFwNmRCc292ZmR0RTBSQ3l5bTZw?=
 =?utf-8?B?VG5sdHI0cStXajhoVmFMNlNkN3BZRldRODdtenZFQmpoVHpJUXVSRFBXbHh6?=
 =?utf-8?B?ek51SHJkNFZRbFlsTDc5aFZkNFBMN3Ric3lUOTVqMnl3WnRJRFVSU1FPdFJI?=
 =?utf-8?B?aDBzVEhhQjJHL3BMZmppRnEveldOekdOL0RFSk41dlczWFdJOTRvdit0TTFu?=
 =?utf-8?B?ekRRZjIyN1I5QjlMRnl2Z2dVdXdVc2RwSmtqTkM3OXB0aXExQXJaeXkrbnRX?=
 =?utf-8?B?elo0UDJWMVIzaEhmejgxeXFzWWtabUZIaUk0MjhXakpqaTgzaHN0cGVES290?=
 =?utf-8?B?M0d1Y3R1WHlZdUhmcHlXT1NYbnFNN0lCUFdMSkovbGpxcmpGN09KdnJKTGFl?=
 =?utf-8?B?Z20zWEVCMDdHaHdDYTJlQlBZL0FqOXJNNjRSZG9YaFdWeXhQK0Q2enpRcjIw?=
 =?utf-8?B?SlAxS3NnRXhzY0JYWVJjb21oaWRST1llbDMyME1iMG1jT0IwYXRZWm1reWpP?=
 =?utf-8?B?TlB1cVdaU1dXeERTNGcvL2NHdDcrS2pOdFlveEZKYXhuM0FXU21tbmlsb2Vq?=
 =?utf-8?B?cTlrc3BKM3psQTFvNldEY2tJVFZzcHJVUitNK2dENitVc0FsK2MvSVBXNnNV?=
 =?utf-8?B?SmxsVEVQSDB5cnFUMXZqMWsydTYrZGEwaDNXcVdDejNTMHBOZjJRcjY0T2Ru?=
 =?utf-8?B?U1RXaUkzc3pwcDVCK1VVdk54WUxHK3h4alA3Q05wMFF4cElSdkJFNzBudnNz?=
 =?utf-8?B?UHhSZ0sxMm5wWmdjWTloS1lIVnArVDhRbkdpUVQ1TVVFdzFZNXZFaDJMekNh?=
 =?utf-8?B?QWNqZDBNMXdxdzlrU3MwbnVzeTJ0dGNpTGo5MVQ2cFNiNUkzeFNwMjhjRVBW?=
 =?utf-8?B?UHAzOTFoa3ZVMkpmT29nM0tEYVBjb1VNb2txSlMwOWw0aXU1L0JKQ3RyVDN1?=
 =?utf-8?B?b3BoeHNlRzlKM0ljb3k3SG9KMjFBT09udVRneE95cURwOWplU2owRm56QnA4?=
 =?utf-8?B?VHRYOTlkcVByc0VGWEFsdWM1Z2d5VCtsbHkzb0lUVmdUTm1OVUhtanFmM0tF?=
 =?utf-8?B?WjNvb1JwdjFDT3VrL0FFUTN6UjV1SHFrMDNyWGpoR0FtRnN1aWNYbDhoTmha?=
 =?utf-8?B?Q21KeTZWS0todndHRkZoWFBMZUxJaGVLaFNoWFhRN3ZKRURMME5lWHJWaFQ2?=
 =?utf-8?B?TWhMTytLNzNEeTlhZVYxK0dYYTh3anhxODVrdUNvam9xTDJDWGU5cjBlQXNU?=
 =?utf-8?B?OTVranN0LzZCamdDdUQ0REFad05FNVZaa21KRVNKTHZRMDROUzdTdS80Uk1I?=
 =?utf-8?B?Z0lQSzUvN2dBRy9sSnEzdnNQZk1JNkJlTVVjNFVHZGNuUUwydlFCbmVmdzBp?=
 =?utf-8?B?djBLS2oxSHpKSUY2L0F6dk9lTytWbUtkTCtXbGlRWU1vS0FNMk8vbVpTT0I5?=
 =?utf-8?B?dGFNM2xaOWpSb1BiME51M0JkQXJ4amhtY1ZmRTA1ZUY5NkNwcCtmWWswUTNT?=
 =?utf-8?B?L28yU0dMUXJQQmo0U3lETGE1ZDdjbzd4TWthRUlGeDZ5QTBmYnJrL0hKTllU?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a048fd6-75c8-42c7-5524-08dd56de9016
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 03:26:46.0813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNrC4XsszSJqnS56kPVBBcVb9Z2BxBh94udCudg8XpF6VaanBam8eKb3FpyhmqF6rdtWFxYaKmqRu3NXj/Djng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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



On 2/26/2025 8:43 PM, Chenyi Qiang wrote:
> 
> 
> On 2/25/2025 5:41 PM, David Hildenbrand wrote:
>> On 25.02.25 03:00, Chenyi Qiang wrote:
>>>
>>>
>>> On 2/21/2025 6:04 PM, Chenyi Qiang wrote:
>>>>
>>>>
>>>> On 2/21/2025 4:09 PM, David Hildenbrand wrote:
>>>>> On 21.02.25 03:25, Chenyi Qiang wrote:
>>>>>>
>>>>>>
>>>>>> On 2/21/2025 3:39 AM, David Hildenbrand wrote:
>>>>>>> On 20.02.25 17:13, Jean-Philippe Brucker wrote:
>>>>>>>> For Arm CCA we'd like the guest_memfd discard notifier to call the
>>>>>>>> IOMMU
>>>>>>>> notifiers and create e.g. VFIO mappings. The default VFIO discard
>>>>>>>> notifier isn't sufficient for CCA because the DMA addresses need a
>>>>>>>> translation (even without vIOMMU).
>>>>>>>>
>>>>>>>> At the moment:
>>>>>>>> * guest_memfd_state_change() calls the populate() notifier
>>>>>>>> * the populate notifier() calls IOMMU notifiers
>>>>>>>> * the IOMMU notifier handler calls memory_get_xlat_addr() to get
>>>>>>>> a VA
>>>>>>>> * it calls ram_discard_manager_is_populated() which fails.
>>>>>>>>
>>>>>>>> guest_memfd_state_change() only changes the section's state after
>>>>>>>> calling the populate() notifier. We can't easily invert the order of
>>>>>>>> operation because it uses the old state bitmap to know which
>>>>>>>> pages need
>>>>>>>> the populate() notifier.
>>>>>>>
>>>>>>> I assume we talk about this code: [1]
>>>>>>>
>>>>>>> [1] https://lkml.kernel.org/r/20250217081833.21568-1-
>>>>>>> chenyi.qiang@intel.com
>>>>>>>
>>>>>>>
>>>>>>> +static int memory_attribute_state_change(MemoryAttributeManager
>>>>>>> *mgr,
>>>>>>> uint64_t offset,
>>>>>>> +                                         uint64_t size, bool
>>>>>>> shared_to_private)
>>>>>>> +{
>>>>>>> +    int block_size = memory_attribute_manager_get_block_size(mgr);
>>>>>>> +    int ret = 0;
>>>>>>> +
>>>>>>> +    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
>>>>>>> +        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
>>>>>>> +                     __func__, offset, size);
>>>>>>> +        return -1;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if ((shared_to_private &&
>>>>>>> memory_attribute_is_range_discarded(mgr,
>>>>>>> offset, size)) ||
>>>>>>> +        (!shared_to_private &&
>>>>>>> memory_attribute_is_range_populated(mgr,
>>>>>>> offset, size))) {
>>>>>>> +        return 0;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (shared_to_private) {
>>>>>>> +        memory_attribute_notify_discard(mgr, offset, size);
>>>>>>> +    } else {
>>>>>>> +        ret = memory_attribute_notify_populate(mgr, offset, size);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (!ret) {
>>>>>>> +        unsigned long first_bit = offset / block_size;
>>>>>>> +        unsigned long nbits = size / block_size;
>>>>>>> +
>>>>>>> +        g_assert((first_bit + nbits) <= mgr->bitmap_size);
>>>>>>> +
>>>>>>> +        if (shared_to_private) {
>>>>>>> +            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
>>>>>>> +        } else {
>>>>>>> +            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        return 0;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return ret;
>>>>>>> +}
>>>>>>>
>>>>>>> Then, in memory_attribute_notify_populate(), we walk the bitmap
>>>>>>> again.
>>>>>>>
>>>>>>> Why?
>>>>>>>
>>>>>>> We just checked that it's all in the expected state, no?
>>>>>>>
>>>>>>>
>>>>>>> virtio-mem doesn't handle it that way, so I'm curious why we would
>>>>>>> have
>>>>>>> to do it here?
>>>>>>
>>>>>> I was concerned about the case where the guest issues a request that
>>>>>> only partial of the range is in the desired state.
>>>>>> I think the main problem is the policy for the guest conversion
>>>>>> request.
>>>>>> My current handling is:
>>>>>>
>>>>>> 1. When a conversion request is made for a range already in the
>>>>>> desired
>>>>>>     state, the helper simply returns success.
>>>>>
>>>>> Yes.
>>>>>
>>>>>> 2. For requests involving a range partially in the desired state, only
>>>>>>     the necessary segments are converted, ensuring the entire range
>>>>>>     complies with the request efficiently.
>>>>>
>>>>>
>>>>> Ah, now I get:
>>>>>
>>>>> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
>>>>> offset, size)) ||
>>>>> +        (!shared_to_private &&
>>>>> memory_attribute_is_range_populated(mgr,
>>>>> offset, size))) {
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>>
>>>>> We're not failing if it might already partially be in the other state.
>>>>>
>>>>>> 3. In scenarios where a conversion request is declined by other
>>>>>> systems,
>>>>>>     such as a failure from VFIO during notify_populate(), the
>>>>>> helper will
>>>>>>     roll back the request, maintaining consistency.
>>>>>>
>>>>>> And the policy of virtio-mem is to refuse the state change if not all
>>>>>> blocks are in the opposite state.
>>>>>
>>>>> Yes.
>>>>>
>>>>>>
>>>>>> Actually, this part is still a uncertain to me.
>>>>>>
>>>>>
>>>>> IIUC, the problem does not exist if we only convert a single page at a
>>>>> time.
>>>>>
>>>>> Is there a known use case where such partial conversions could happen?
>>>>
>>>> I don't see such case yet. Actually, I'm trying to follow the behavior
>>>> of KVM_SET_MEMORY_ATTRIBUTES ioctl during page conversion. In KVM, it
>>>> doesn't reject the request if the whole range isn't in the opposite
>>>> state. It just uses xa_store() to update it. Also, I don't see the spec
>>>> says how to handle such case. To be robust, I just allow this special
>>>> case.
>>>>
>>>>>
>>>>>> BTW, per the status/bitmap track, the virtio-mem also changes the
>>>>>> bitmap
>>>>>> after the plug/unplug notifier. This is the same, correct?
>>>>> Right. But because we reject these partial requests, we don't have to
>>>>> traverse the bitmap and could just adjust the bitmap operations.
>>>>
>>>> Yes, If we treat it as a guest error/bug, we can adjust it.
>>>
>>> Hi David, do you think which option is better? If prefer to reject the
>>> partial requests, I'll change it in my next version.
>>
>> Hi,
>>
>> still scratching my head. Having to work around it as in this patch here is
>> suboptimal.
>>
>> Could we simplify the whole thing while still allowing for (unexpected)
>> partial
>> conversions?
>>
>> Essentially: If states are mixed, fallback to a "1 block at a time"
>> handling.
>>
>> The only problem is: what to do if we fail halfway through? Well, we can
>> only have
>> such partial completions for "populate", not for discard.
>>
>> Option a) Just leave it as "partially completed populate" and return the
>> error. The
>> bitmap and the notifiers are consistent.
>>
>> Option b) Just discard everything: someone tried to convert something
>> "partial
>> shared" to "shared". So maybe, if anything goes wrong, we can just have
>> "all private".
>>
>> The question is also, what the expectation from the caller is: can the
>> caller
>> even make progress on failure or do we have to retry until it works?
> 
> Yes, That's the key problem.
> 
> For core mm side conversion, The caller (guest) handles three case:
> success, failure and retry. guest can continue on failure but will keep
> the memory in its original attribute and trigger some calltrace. While
> in QEMU side, it would cause VM stop if kvm_set_memory_attributes() failed.
> 
> As for the VFIO conversion, at present, we allow it to fail and don't
> return error code to guest as long as we undo the conversion. It only
> causes the device not work in guest.
> 
> I think if we view the attribute mismatch between core mm and IOMMU as a
> fatal error, we can call VM stop or let guest retry until it converts
> successfully.
> 

Just think more about the options for the failure case handling
theoretically as we haven't hit such state_change() failure:

1. Undo + return invalid error
Pros: The guest can make progress
Cons: Complicated undo operations: Option a) is not appliable, because
it leaves it as partial completed populate, but the guest thinks the
operation has failed.
Also need to add the undo for set_memory_attribute() after
state_change() failed. Maybe also apply the attribute bitmap to
set_memory_attribute() operation to handle the mixed request case

2. Undo in VFIO and no undo for set_memory_attribute() + return success
(Current approach in my series)
Pros: The guest can make progress although device doesn't work.
Cons: the attribute bitmap only tracks the status in iommu.

3. No undo + return retry
Pros: It keeps the attribute bitmap aligned in core mm and iommu.
Cons: The guest doesn't know how to handle the retry. It would cause
infinite loop.

4. No undo + no return. Just VM stop.
Pros: simple
Cons: maybe overkill.

Maybe option 1 or 4 is better?

> 


