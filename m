Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03426C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1semYk-0002Xq-UL; Thu, 15 Aug 2024 22:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1semYj-0002XL-Ec
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:19:21 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1semYh-0004Ig-I9
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723774759; x=1755310759;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RTm9m0WCdl8XE7D34Hl7WnNviJH9IblqMOoeMKIIi7g=;
 b=fVT9Dv9O/6MXLghHgL/ryXRNke7szXU3EWaeZqA4L/D/0qOmchES7ZD5
 CW1y2NEtDozrNYvAGkNEB+hs2FuBqGHeWCzYimge6+iQS+yvdubPjmqr2
 RvQ5ghmlGgo4/sZA0WxMjkWx+zxMzH6mJV7LZLyqdQlgZWQ9q7dQfdxPX
 hlTS/i9FDMCeamZepgfcFHIGl449LRM1WJcrufeTNy0QQhYOaFtmPM8mb
 diq1YAfkDHXfKb8U5xuS/F7NJbwD1I/MN5lVlQtCJ5NqlFy5CbFFmUZVD
 wWEbFUVPNcP7eLW3lKPyoIy0ksikGog/l0+2MmDQ91OC/Uq6e3W71uKvn A==;
X-CSE-ConnectionGUID: 9IWwCD/NTlOrJyhQmFBzQw==
X-CSE-MsgGUID: f3bT7sewSmmz1HySacwH3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="24963013"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; d="scan'208";a="24963013"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2024 19:19:16 -0700
X-CSE-ConnectionGUID: 0UQFpaZdT0SZeKJ9ptL9jA==
X-CSE-MsgGUID: LZ8VhTgoT46WE/d4SwSJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; d="scan'208";a="63946781"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Aug 2024 19:19:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:19:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 19:19:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 19:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONHI5FrVUgI9DkN8/W9nH4UrONcutnWLxJ590BjmfPREjuXJA9kONK3aDI7zRNvL4dXJXdsGZ1p95NIAVm6smNJmRGTaiUJXCS7H+HVIuXJIB0fRiypFdJKkA96yG6kwSnSvxLK6voDh+N/WvAgMOK+655soJOYHSnMRWj3hAeYmDi9C/4bDZWWobH+2WN1KaK2BchYfilzKA/mAZfJEimGYVjhUaQPR4pfJuXPyeNX98eBd200lPy50ucSr4ck3uHcs20Ivz2eSVsa6XvHXciGz7HS4U8mGoMPF/FNN3BpzeZWOHmVQT9kAo1gOxv0XSkKn0xsd0LiNFFaOhwGhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTm9m0WCdl8XE7D34Hl7WnNviJH9IblqMOoeMKIIi7g=;
 b=KQ96lXvIQ/mXySXKRTkXN6kRvvN54XC8/hL70X5Sv86MLmqiZt2b7Bq7M0jWL2jGBvvi5IzOj82TuSnvwK3bm3q33DezeSJmwKOVjb0OLCMJ/dQ2SB7A36p46xqbluOpt3DxCDk9X1xXE5tykVYJ4DsnPP9ImMSNX7Z0wiv8KTtVpTLJXlvAffei0RfXMugeaGkZHusUqLGXwo2CmZuhjreo7wkAHBIRQL6YoLFdRj3E5OzgCbLebFIoljDJm4r7sLV4Bu6nQbGF85Wi0emxG90szQa0f+5vTSzQPy4/N/VwslZcL//IahXVQL5jRnKJvPLJBIDTcJaGUV+5u1tJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Fri, 16 Aug
 2024 02:19:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Fri, 16 Aug 2024
 02:19:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v2 07/17] intel_iommu: Check if the input address is
 canonical
Thread-Topic: [PATCH v2 07/17] intel_iommu: Check if the input address is
 canonical
Thread-Index: AQHa5wERgjBU6UsGL0mHlXAfyXFamrImtbsAgAKAhDA=
Date: Fri, 16 Aug 2024 02:19:13 +0000
Message-ID: <SJ0PR11MB6744A539A1CDAADD6D4A6C3B92812@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-8-zhenzhong.duan@intel.com>
 <ea60177f-697b-40c0-9f70-b3ac56e88e06@intel.com>
In-Reply-To: <ea60177f-697b-40c0-9f70-b3ac56e88e06@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7313:EE_
x-ms-office365-filtering-correlation-id: fa2abdc1-6558-4e68-d5df-08dcbd99d265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZmtpOWtUOEJhTGpIYkpnVnRCVVVoYWkyeXBwNEpseG9MQzdqR3p0d1JYcUhI?=
 =?utf-8?B?ZFhidHFXajFpempXNjdEYjBhT2VHNHozcjhTQmFBMTF5a3NzUVlDdzhDTEVk?=
 =?utf-8?B?KzZ4RmcrYmZGL1FjWkRIT3BPMXJuWFBpL001WTRCeXBUT1VldlJRc2Y2SldD?=
 =?utf-8?B?UGkyelMrM0p3T2d1SHdYcS9UM1BCa3lyTEgya2pxb1EyQ2R3cG93ejM0Z3hJ?=
 =?utf-8?B?NzNOa2xUelN0cXlGbXNSS3hxNTlGTVl2YTBDMitQYzQ5K1o5MnNZdis1akMz?=
 =?utf-8?B?YnVIV1YvV00xWUJwTmM1aGJkN1daZWI5WmJzcGlJWWc0RFVvR1Y1eUlocEJy?=
 =?utf-8?B?V0FqUTJsWW9ycVJ2azRycXU5aG1JV3VLbEQ0dHFCZ2d4QTNYbFFRNVk0VUFw?=
 =?utf-8?B?ZjZYTm0zdDh2SVYwNnJVdjdtK1RJNFhMUmhNZ2QzTFNDOVdwVGwxbjI3TW5j?=
 =?utf-8?B?NzVBbzloREdoOTBFYWFxZk45V2hYajFLMU9aNjFROHZYeUFwR1JXY1oycm9V?=
 =?utf-8?B?eXhhSklNUTgwdlZLYmhjaTNYdTBmMlpReFBySlJNUTNJZEg3NStJMmNGOHdJ?=
 =?utf-8?B?MEswRENXRGVuM1VTVnZyNEF1dEVTT3VnS2lJeDNnblhWY0pxT1BFMTc3VDJG?=
 =?utf-8?B?dWVOTHBBWmQzb2h2ZklJa2ZwaGVPTzNWODZTc1d3aXhody91VXd2dkQ0NnNu?=
 =?utf-8?B?TG1QN2t4VkFVT3NFMjlkRXllakNjYUt4V0lpOUJzcEtPcEpKL0ZURE9DOHZj?=
 =?utf-8?B?TnM2Y29LTTAzVXlWUWJrMEhVZnNKUnp6K2d1ZzBDZWxISW5tNjYrRm9BVE0w?=
 =?utf-8?B?ZUgvNzFJRUV5K29jNWdxV0E5cUxRNzRGUjVxejRYQlZnYUllNnNPU0tOR2oz?=
 =?utf-8?B?SUVid0s0a2duOTU0SkQ0aFJKQS9GNVg1Rk4zNmdzVnBWOEc4VlcwRXRQemJG?=
 =?utf-8?B?cm1FT0lpMGM5bDgrZGtYZlBqWUY0Rk1HdHFiS2NTYnpUajQ5R3p4V2NRRzRL?=
 =?utf-8?B?am9FTnBGV0hmYjVTQVczV2NocmVMOUh4b1d5cDRFRW0wZU1TQllsWmlkMnIv?=
 =?utf-8?B?SjRydjdUS3FvRE1oK21TVUtvMzIrMDJRL1NyQzY1MFJYbElOdXBTMVRQdUhh?=
 =?utf-8?B?ZER5YUhhOStXa0ExMXZuaHlKRXlpUUpuK0MvYzFaeGE4Wm5WWkZCejN4OGk3?=
 =?utf-8?B?S3p1NTU5TFd2ckpPb0pqZExOTkZDRlc1YXVGQ2F4MXBPeDlmOXdZQU9pQXhZ?=
 =?utf-8?B?ZWlBc2pZckVnU2t1RlhJcE15NnlrbWR5dEwzMUtBUjhPM01TK0F2NFBVTklF?=
 =?utf-8?B?VllyazFMNmhQdi85Yk10QnBPVEsrWkcySXBEV0FjMU5vSHhtQ1VhZXdBSmpE?=
 =?utf-8?B?eDllc25UcytlaXhRM05rNUFBcEhZWXdmajllS0k0UmpwYk9YaUorcTBBY1Rn?=
 =?utf-8?B?ZEtKSHgzangyNWNkeUVpeFlVY2dKclRFTXJJblFNcUVJMXhzWnVTc0pGNXlM?=
 =?utf-8?B?bWFXNTlEeHU1TXJPVEMwYndMTGpYT0x0VUFSRVp4cVJ4UmdiekFtdS85ZVVp?=
 =?utf-8?B?TFlNSlk5dE90dzBWSkJZS0lWYU9UaTdFOGFhNlZQYXpPam1KZk9DRkQxSTJw?=
 =?utf-8?B?MnhaU1A0T2dYRWp6S2xkVkUzM051ZFBobkJ2aFhOWHpWWnQ1aEwwUTRMbjNS?=
 =?utf-8?B?ZG9neTRiSFR2cmV0MzFDMGh6QTNRS2hRL0RrRDhvbVBkeVFqd2wrVkVkeXVQ?=
 =?utf-8?B?VGFmUWVNdzBtUXFpZU5lWkw4ckpLUFRtSmJONE56Rm14a054OGFmMnV6Mk5l?=
 =?utf-8?B?K1ZjZmwwRWZIS2hvSzd3ZHFoaDI5QWwzSjhvWFRDd1crSW1pbVMyMUxLVDI5?=
 =?utf-8?B?K09CVWpVNmVyRFZsd1BqM09uRnMvNjVMaUdkWUZCSTArMlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEhGckNCdmNhMm9Vdkx5ZFNXZ1BHdnJqeUpzM2tQd1B6aVg0elZ6OHVmTGVK?=
 =?utf-8?B?TUxSTGw5a3FWUHVBTFR5TG4vUnIrUzBXVm9idkx5U1JubXg1L0pNMjA3a3dt?=
 =?utf-8?B?Wkhxd1BTM1dPcHZGWDBFNUdvSGVWSlRvVWp2YTl4NVozMDl0MnhKNEpQa21t?=
 =?utf-8?B?Q1VWN3RzbFpFYXhwMmlhcUhCYVJFZ3RuOUNMWkJ1NG4wNk04U1o5NG45ZGI2?=
 =?utf-8?B?dHVmdlpoZG9TU21saGJSN0p3M1A0VDZhMGhhSzZpcm8wOElCQnI0SmRoaHJz?=
 =?utf-8?B?Z1EvZkpORVozVzhkNHpkQWhHclJESWZDdi9yVjRHVTJEMHRVclRFcGVOQVBs?=
 =?utf-8?B?eWRqR3ZVOW5vRVgxTXZNYXByOWMxSkxNcG9YR0QwZldQem9yMHBVVWFlMnF0?=
 =?utf-8?B?OExxSjZzTDBMWkMySHRQZ1hkUmpIYWpTWFdFTjBuczVQaUk1R1NVY1MrMjJ5?=
 =?utf-8?B?T0hNczB0MGI5TjJCbHFVaWZ0Q2JQNEJUemM5Uk9nblNxVFhmVExFcGJGM2Mv?=
 =?utf-8?B?NWlsbnNnTnV2TVlYdldHWi9BWWM4bEVOZHJSTU5WOTFFcE5EampBM1Y1YzRw?=
 =?utf-8?B?aDY0VG5aVE1IZmxQRUVHbDFuOWYrWEVTV0lFS3ZnRVNyYlNJNVVpa0dUYVBL?=
 =?utf-8?B?OUs5NkRKdFgxYVRIc2NlWXh6MGpFRTkxZWhIRGI4Z3FTSmlyMDNvb1pjYnZB?=
 =?utf-8?B?RzR6ZVZiNy9XZG5Gdzcrb3ZIQWpaTVdoRVgyYWxWYW1ERy9YU0E3QUxqY0JQ?=
 =?utf-8?B?VWxhSVhLNDVRMUVaR3NtN0ZuZjV6bnp0N0ZPSDl3U00zdE55Wk15YWNaWTI2?=
 =?utf-8?B?cDY4M2RZOTY1Q0wvTU5xZDNNZk1ZbjFlSExrakF4NGpVTkp1UEpiME5uMi9O?=
 =?utf-8?B?elYyVDNYd2hnZUh1QjliV3FqRmdtOHN2cHFMbGVHQlNqUmRkakkvS1YyZDVN?=
 =?utf-8?B?dFdxcnliSnNUbDMvUkxNRUpkWnJyenFPTUtDeHRORWNQamFPZ1owckVtL1NX?=
 =?utf-8?B?Z3RXNXZlbkx2YjFBY0dGeGpsWCthaGpjSWtnRGxkdlArbE1HVDdaQmRaNEkw?=
 =?utf-8?B?KzNqRlNBRktaOFZWaGpxd1cwT2JzRG1RMFFJMStucWVFT1VUemFxVFhEU3RK?=
 =?utf-8?B?UHhKaGVHMERDWHVMcVlZZFVvNW1RRit5ajc1RzV0bllscEExMzBtZHRQZkNB?=
 =?utf-8?B?RHZTSEl1aWZ1Uk9hV1FqOTRzd3hTK2cyZmZkZUk1aVp6aG0wMGY1NFl5NWpy?=
 =?utf-8?B?TTNpY2lqVXpJTjk3VmFXL0xWOUE1elNlN1Z6VWhydjBjSkRQb1UvcGZOd2xu?=
 =?utf-8?B?NDBuem5ESzNIOGtDVkpwdStVVUJFc0wxUEVucjl2R21TbTh3dWVaNkdOQndy?=
 =?utf-8?B?aWRJZ3pieCs1OTZIM1lwL1NPd0ZzZ3N3d2ozYmtoK2luUmhxVWtTYkdqb04w?=
 =?utf-8?B?R2xrTWVQZE5iaWxteWpId0pXT2dkZDJ1d2laS1RWVzNxaVJCRjdPQjBvdDdn?=
 =?utf-8?B?a1h2NTh3bDFRbkZ5dm1HZHNqYmhXVlpWT0hodzUwNm45K2ZYQlRFcm03L1Qx?=
 =?utf-8?B?dmhxUDdjUVRxSWs0dlFtR0EzU2hUcm5MNDBUc21HMGZPOXh1UGpaa1g1UGNW?=
 =?utf-8?B?RGFNaDM2T0M3RG1EQWFOL2tTaFlNS0c5RW96alo1NGp3VU5aVkxkL2NXOG1D?=
 =?utf-8?B?U2JKczlFaUdBVG1HUU83NStvazc3TzN5cGwwRzN5OU95YzFqK3Rma1g3ZTM4?=
 =?utf-8?B?N1FmZnRpbldMUG5ucmZmL2E4a1JlMXBkUU5XMXF0WFpEUHUwaGxOejZHa3JL?=
 =?utf-8?B?NjBUSnYybDlIYmV2R0t2QWkxSGdESDZNdytMcUVDRGR5SGJWMC9EVjRObDdi?=
 =?utf-8?B?bk1aUERVMW5ZY0dNekVWakgxUzR6eEZsNVZqV20xWmVBekZrWGpBSkRqSVYz?=
 =?utf-8?B?T1M5ZXA4QTBiMmJYdkVGRjRCdWdlUDVQYXlocU03V00rMGU2T09acWorbFdZ?=
 =?utf-8?B?Wnp2enlremFYOWZLRzhWUzIwNjJLeCs0SktQSnJxaHVDVzVjdEJ4akg5emxL?=
 =?utf-8?B?MFRmejJmVGdzN3M0Nldnd1U4WmpZN1N2WVBaM0d6Ylo3TTBYQ0ZDSzMxUW5U?=
 =?utf-8?Q?T141vqX2ECMcO1wvVQCJGQM+e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2abdc1-6558-4e68-d5df-08dcbd99d265
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 02:19:13.7224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kk5AHFa6b4H6pu/mXO7YR/gvYGkmRzwrcFMLqyJFZtx9qZ7c1qbFjaiYwqz7dPyrdJ1GNjDxlfJZKHOwmXNnqOKrTQKx8zqeQt8O2VZIEO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDcvMTddIGludGVsX2lvbW11
OiBDaGVjayBpZiB0aGUgaW5wdXQgYWRkcmVzcyBpcw0KPmNhbm9uaWNhbA0KPg0KPk9uIDIwMjQv
OC81IDE0OjI3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206IENsw6ltZW50IE1hdGhp
ZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4NCj4+IEZpcnN0
IHN0YWdlIHRyYW5zbGF0aW9uIG11c3QgZmFpbCBpZiB0aGUgYWRkcmVzcyB0byB0cmFuc2xhdGUg
aXMNCj4+IG5vdCBjYW5vbmljYWwuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0
aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0t
DQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAyICsrDQo+PiAgIGh3L2kz
ODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0KPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmgNCj4+IGluZGV4IDUxZTliMWZjNDMuLjY2ODU4M2FlY2EgMTAwNjQ0DQo+PiAtLS0g
YS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTMyMCw2ICszMjAsOCBAQCB0eXBlZGVmIGVudW0gVlRE
RmF1bHRSZWFzb24gew0KPj4gICAgICAgVlREX0ZSX1BBU0lEX0VOVFJZX1AgPSAweDU5LA0KPj4g
ICAgICAgVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOViA9IDB4NWIsICAvKkludmFsaWQgUEFT
SUQgdGFibGUgZW50cnkNCj4qLw0KPj4NCj4+ICsgICAgVlREX0ZSX0ZTX05PTl9DQU5PTklDQUwg
PSAweDgwLCAvKiBTTkcuMSA6IEFkZHJlc3MgZm9yIEZTIG5vdA0KPmNhbm9uaWNhbC4qLw0KPj4g
Kw0KPj4gICAgICAgLyogT3V0cHV0IGFkZHJlc3MgaW4gdGhlIGludGVycnVwdCBhZGRyZXNzIHJh
bmdlIGZvciBzY2FsYWJsZSBtb2RlICovDQo+PiAgICAgICBWVERfRlJfU01fSU5URVJSVVBUX0FE
RFIgPSAweDg3LA0KPj4gICAgICAgVlREX0ZSX01BWCwgICAgICAgICAgICAgICAgIC8qIEd1YXJk
ICovDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+PiBpbmRleCAwYmNiZDViNzc3Li42MTIxY2NhNGNkIDEwMDY0NA0KPj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+IEBAIC0xODIxLDYgKzE4MjEsNyBAQCBzdGF0aWMgY29uc3QgYm9vbCB2dGRfcXVhbGlmaWVk
X2ZhdWx0c1tdID0gew0KPj4gICAgICAgW1ZURF9GUl9QQVNJRF9FTlRSWV9QXSA9IHRydWUsDQo+
PiAgICAgICBbVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOVl0gPSB0cnVlLA0KPj4gICAgICAg
W1ZURF9GUl9TTV9JTlRFUlJVUFRfQUREUl0gPSB0cnVlLA0KPj4gKyAgICBbVlREX0ZSX0ZTX05P
Tl9DQU5PTklDQUxdID0gdHJ1ZSwNCj4+ICAgICAgIFtWVERfRlJfTUFYXSA9IGZhbHNlLA0KPj4g
ICB9Ow0KPj4NCj4+IEBAIC0xOTI0LDYgKzE5MjUsMjAgQEAgc3RhdGljIGlubGluZSBib29sIHZ0
ZF9mbHB0ZV9wcmVzZW50KHVpbnQ2NF90DQo+ZmxwdGUpDQo+PiAgICAgICByZXR1cm4gISEoZmxw
dGUgJiBWVERfRkxfUCk7DQo+PiAgIH0NCj4+DQo+PiArLyogUmV0dXJuIHRydWUgaWYgSU9WQSBp
cyBjYW5vbmljYWwsIG90aGVyd2lzZSBmYWxzZS4gKi8NCj4+ICtzdGF0aWMgYm9vbCB2dGRfaW92
YV9mbF9jaGVja19jYW5vbmljYWwoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50NjRfdA0KPmlvdmEs
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURENvbnRleHRF
bnRyeSAqY2UsIHVpbnQzMl90IHBhc2lkKQ0KPj4gK3sNCj4+ICsgICAgdWludDY0X3QgaW92YV9s
aW1pdCA9IHZ0ZF9pb3ZhX2xpbWl0KHMsIGNlLCBzLT5hd19iaXRzLCBwYXNpZCk7DQo+PiArICAg
IHVpbnQ2NF90IHVwcGVyX2JpdHNfbWFzayA9IH4oaW92YV9saW1pdCAtIDEpOw0KPj4gKyAgICB1
aW50NjRfdCB1cHBlcl9iaXRzID0gaW92YSAmIHVwcGVyX2JpdHNfbWFzazsNCj4+ICsgICAgYm9v
bCBtc2IgPSAoKGlvdmEgJiAoaW92YV9saW1pdCA+PiAxKSkgIT0gMCk7DQo+PiArICAgIHJldHVy
biAhKA0KPj4gKyAgICAgICAgICAgICAoIW1zYiAmJiAodXBwZXJfYml0cyAhPSAwKSkgfHwNCj4+
ICsgICAgICAgICAgICAgKG1zYiAmJiAodXBwZXJfYml0cyAhPSB1cHBlcl9iaXRzX21hc2spKQ0K
Pj4gKyAgICAgICAgICAgICk7DQo+PiArfQ0KPj4gKw0KPg0KPndpbGwgdGhlIGJlbG93IGJlIGNs
ZWFyZXI/DQo+DQo+ICAgICBpZiAobXNiKQ0KPiAgICAgICAgIHJldHVybiB1cHBlcl9iaXRzID09
IHVwcGVyX2JpdHNfbWFzazsNCj4gICAgIGVsc2UNCj4gICAgICAgICByZXR1cm4gIXVwcGVyX2Jp
dHM7DQoNClllcywgY2xlYXJlciwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

