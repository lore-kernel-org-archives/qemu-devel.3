Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36B3C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 03:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se4Kc-0008CO-JP; Tue, 13 Aug 2024 23:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se4KZ-00080m-JA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 23:05:47 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1se4KX-0006Qe-Gz
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 23:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723604745; x=1755140745;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iiOF4uKbKX+hGvUl+++h2SbClgGx1H0s72sMqH4vak4=;
 b=nNFdEFefowpaoDVSl7n375GhQRnqDisfVd3tnCFZ5bptnCVoYasZmPby
 o8unBhJJA1VU4S9yyRCjbbgNkd38vHRj0vBfus/K/wNjvxZqeZCamb1Hu
 mhwctphR/3GgN0fj5AmikeftT9hCwtHssLQuPFLBs0MmiMaJzkrXJTsGV
 9MqGphjCykS4d41j4L0DNgYVMrZfe70YpZtmmHpJ0uxLhGQ6E/xFxa01g
 luhr0IY1Dcy1APSA+iLwtGyu+vhU/vVJiFLEIL8yn6EjOM7xjgd/uLqUV
 3L/yQht4btuWFfPrYpXtBeODgb0WW7CW6+OYSqNpCbOx6bRlQjC/GnmmV A==;
X-CSE-ConnectionGUID: b9jy2XerTiqk8hJHpZ/xUA==
X-CSE-MsgGUID: pxZbVwGGTwOnPmp84zA6yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21943179"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="21943179"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 20:05:36 -0700
X-CSE-ConnectionGUID: 9DJ281A1SFW1fsRTiwapGA==
X-CSE-MsgGUID: rFdxvlMYSuKa1J62pYO5HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; d="scan'208";a="89679307"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 20:05:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 20:05:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 20:05:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 20:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIr2B6igbSP7k6ROpXNbvN/jlF7Dlv15FIbjQreJoad3nDSu5IwBgHPFAzi/+Oq27O0xnxKjmF7En7fkhGsp7F6LpUwEx/PwcAzrAsdlbCpzZb0vC3NRqXs0+Hk5aV1v8MN1GbalzJ+jtFoSQ+HHRU4XQkjnX/3v+9t77PaQBjn0+VKOOUr/64Chl1zBKht5Pvq5rjN7gXsKOzq01D1uwfrg0BO26wJdyZJvL5lzvVXIDMtHvnWaZL0JOqRZIWyPz2fOtUSWBH1OIdw/FZipCVQsM9eJKGLfjv8gU6TSSXiy5QfCxtwgt9PlgfPhlR3tk8lltIfG682Yi9xtrmtrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiOF4uKbKX+hGvUl+++h2SbClgGx1H0s72sMqH4vak4=;
 b=edyfC4gPjG3K1KPu6xHli7BV44BTpdEXfQ5cQ/dWZV/e/i4Iwo6NVXdyKskrRG5FuU6tpt4qW6wkKBZpel8gfwSszxUstHvktwDxOmKR+kWrXx4mALWkKl+CXQeW9Wd+HTxeee0/n3YXfRMuL1ZwYtTrRgoOlQv32JfhIommsAMHWzaDMSzxvzClIo6QkjNJj9g+Xw2ElqMGrmuZl9H4R9iFjyIFIJGlghK+eX/TuNtFUzuGN/p19ZkoEmd/iSuZIZkKwSusO0QnmPmqQyUV6GsXsIlW2bCseUiHQ9XWJEcrKCqQY0af5SSGZNBingPtUG1GJ5M0PsSJUQaNE4bWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB8261.namprd11.prod.outlook.com (2603:10b6:806:26f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 03:05:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Wed, 14 Aug 2024
 03:05:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>,
 =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@eviden.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v3 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
Thread-Topic: [PATCH v3 2/2] intel_iommu: Make PASID-cache and PIOTLB type
 invalid in legacy mode
Thread-Index: AQHa7fHoQw3/aeRmeU+vXKGNypk0v7ImEniA////C2A=
Date: Wed, 14 Aug 2024 03:05:33 +0000
Message-ID: <SJ0PR11MB6744F3FD7B8B23AF47E2A09292872@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240814022654.2612780-1-zhenzhong.duan@intel.com>
 <20240814022654.2612780-3-zhenzhong.duan@intel.com>
 <a08417ee-8315-45a4-b065-c6787db92f4a@intel.com>
In-Reply-To: <a08417ee-8315-45a4-b065-c6787db92f4a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB8261:EE_
x-ms-office365-filtering-correlation-id: f7f381ee-fea3-43e9-4dac-08dcbc0df636
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZU9WeEZkYXgyNnVTTVc3ZkhVdUtGcWVIZUpRc3pyTlcrNDM2MEJqM3ovWWJk?=
 =?utf-8?B?UXlOZjhqZWZtTWV2Q3VZU3libmxzYmZOVzUvTmlKQjlkRVoyeE00SHhHOGYx?=
 =?utf-8?B?R1d1ckJLUnJKbnlvK0FrYkdJYkk2TlRPTEZSTG5TcXZMSjN3dG5qMWlnYXBK?=
 =?utf-8?B?SEtTa2kvYkdVRmdiWWtWRjJtTkV6T3ArMWV3b0tsTUFVRjRxaE1VeG13OVN2?=
 =?utf-8?B?TTRrNytMaERKSGIrMWhQU09IendSMzNPSEFwKzlpK0wydFJpTm9Yc09ZWDRM?=
 =?utf-8?B?U3F5U2hKN0lEVWljSlpISGEzL213K0pMQWRJcnhZU3U2a0tuc01DcDA4cWpK?=
 =?utf-8?B?TnNvVHE3bTlqQTlaSjdYMlFoWnhvMjJqRDVvYmRMRVZnb1d4MFJzUUNsdkFC?=
 =?utf-8?B?YWFGQVh4OXVYUnErdVRRUXM5a1BMK1hWZGJxMWR0UVVyUmVpcmNIQ0cvdER0?=
 =?utf-8?B?WUFIVnVReGtuYW1yTzFuTENDVG0wTVlwbkp5SFVKSnRUcHJ6bmVVMW01V3do?=
 =?utf-8?B?czlaLzZlUW1FV0Jvc09pV2NhSmRCREptbTBNK3NVdkZVallvWHpXTE9qTWFZ?=
 =?utf-8?B?Q1NWTG1EWEtDSW9RdGxQNGNqWUYrYTlybGdMeXpWaW9vT3p2N2ROckFnZndY?=
 =?utf-8?B?M3I3VFRQQzRLSCtMazlmYzdCMFFNMnVoN3hQMW80RjUvWE1JMkplNFRWU0FW?=
 =?utf-8?B?TVF4RzMyVmVybUc4RnpWa3ZtYWU0enVZWllSSDN0amdFc2FUcTF3MW9zZXd4?=
 =?utf-8?B?Ty9haE45dmJZZ3NYNlRFc3J2Wm5CTXlnL29LOGVFNzVzc2NXUHBjZS8xMWxp?=
 =?utf-8?B?bXdvVGFxNS9NNityb21CTmkxdzVGbnNENXp4dFR3ZnVDOWQ4Wm5NeUt6eERX?=
 =?utf-8?B?TVVwOWhodXVPbnRsTWxkZ3BBeEJuM0M4R0lpUmpxRHo4dUxVcWp0bi9XSXl5?=
 =?utf-8?B?YnNWWTB2VEhqRlJRK1R4WUFNQ29rV3UxME9naU9FT1AzZnhMSDkrcmJ0WFEv?=
 =?utf-8?B?Wm9Rbk1VN1pTU3FjUFVxVzAzcVJiZGltclcvajFJNU9yd2dSVGozMHZnREU0?=
 =?utf-8?B?L0pBRktxWEZJdTE1eVBFUTUrQlZQa0ZPaVQ5TFRPWnpBaTFyRW1OOTBrUFh3?=
 =?utf-8?B?aDFBaXhNRXNDNDZSQXJMOTlHQ2xaaS80M3ZiUnZhTGo5cnhCMm5ZV3NEWTF5?=
 =?utf-8?B?NmE3S3RrQU5zQU53dG1TeFR0bVJkQkh1bDNLUVE2SW9jeEZpeFJnZGFsU2Fs?=
 =?utf-8?B?R0hxNEVSeXNPSzRSeS9YY29qM1pNam9YMXZhQW56STFmdWw0Y0w2NzIraUVY?=
 =?utf-8?B?Ry9vdWk0K3FBRll1SGl1NDZSRi9wQlI5RTZ0T3A3UGNYVlFITzk2NmM2cG9M?=
 =?utf-8?B?YWRPY0Z5cFd1Qk5GLzNCeDlzbXU4S0x1SzFXeDNMRjRkMWRETFd0enBRYUVO?=
 =?utf-8?B?bTdhZ0lNZ0c0a3FuRFoyeDl1T1RDWENEZFdEYWdOV2NJUGNScE10OHJONGYz?=
 =?utf-8?B?OFI4bDNUbEJrVE0zaGpXbDBrazZ5eEpzbTdvQ2NtWTFwc01nWmxxWVVZN0Rq?=
 =?utf-8?B?b3picjZDQXdBZ3o4d0NIZ1BYOXhhREJEMytyK1lpdytYNmNab1pmem5LdVZZ?=
 =?utf-8?B?UGkweEwzWTZ2NFl3M1FabE03aXdHSjlndEpobXdzSFBkN2llTmw5ZVI3eDc3?=
 =?utf-8?B?VUlYc2Z2MVFCa1BjZkFnS215WlhJa3FMS093WXIvQUttbzVLS1dVUDFGSEcz?=
 =?utf-8?B?dTRlU3diYjJQdXVPNmE0ajEwZGlJQXV6UEZQTEZIdERyU2RpVDFXS3NTMU9G?=
 =?utf-8?B?aFNwUDZhVWs3eGhveFN1WmNWRkZ4SW5jT0FaR3ZQU1VRTnNCWU16eFl2ZXN5?=
 =?utf-8?B?RkVCWkxXcmNhYW44YWIxRWpuRjZFL3Z0b3EyTE56NU5qSkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2FNeTFOcUdKS2I5NWFVb0NoaEhnRDhWOVBxa0l0dTJmYWFEVG9CaGNiNHdO?=
 =?utf-8?B?aVlMbWJXb3VKa0p1Sjh3SDdaZXVGTEJaUERFcWI1Z2VPZVRJUlJPSUFIaDRx?=
 =?utf-8?B?SDdYazdJdmNiZDhZYXlrN3FKcER3SXErZEZZWldFTmNYVmlhcDlaNmJXTCtz?=
 =?utf-8?B?MURBVGY2RlFsNTk1OGlVRzdGTDl1MzJkRzRDNFoxZG00aWtvbWRXR1ZROFl6?=
 =?utf-8?B?amZaZ0wrSnZLTmpta1E3U29oUHJVM29zZW0rYmNnMWQ2NVJwaUZYTlpYTFJs?=
 =?utf-8?B?WGUrb0x3SUN4a0gyVmxKWUVSYnhXOWFmUUZpdDZ4UE9JU25WbHFEaTNYRHJF?=
 =?utf-8?B?dDJod1dTcmp3NVlRQlVYdzdpbmFtYmcyekpiTGlMTHd0dHROMUpMemM4WS9Z?=
 =?utf-8?B?Snd5ak5nQXlsM2JxWDZ1VXJjWURBZ1E0MzJ2eUtmMk0xK0NDbnh1V2dEdkhv?=
 =?utf-8?B?L2QzemEwQzBmck1hc0FrUlJvZVQ1cWMrYWd6VWlyRUphelJSU3hTQ1VGRnhK?=
 =?utf-8?B?VXBzc2R2ZDVkZkNQaWwxL3FVWDBvdko2QWtDVThYZjBRNmJFY0hkVXptZUN1?=
 =?utf-8?B?M2xVM21Hai9BMTlyNzZ5cTZQeEVuSzhCUXlZckNhclgwWmhRcmhNd2JuOG1z?=
 =?utf-8?B?L0RLdEhhVC9UWlNaZEFGdXNBd1NiUUlIZWkvV1NoOTRRSjdSbkFYYkZIeDY3?=
 =?utf-8?B?U0tFNmpodnJsTGg4SUxCbTZGUGhma0NPbnlyUkZ0elpFZFdLbk9ESEtGUzhS?=
 =?utf-8?B?VmpOQmpUUFhuVTN6dTQ3WmE1Q0FYM2xWRVpIcTliNWUyMlVnanUxcTJXRExN?=
 =?utf-8?B?WUNFRlU4YXZ2UE5FQlRwQmQxUUhhSDV2M1YzemlzZGhQaHFZeW10eVBGakYr?=
 =?utf-8?B?N1orR0hKSWMzcEl0VDl2UmhwZFRtd3VzNzNtSDBUQjZjT0UxdXpiNVJpNVdO?=
 =?utf-8?B?VXVYdFIrRlRhS2UvVkdJUkZlNnNsb09zdXRsa0V6ZXZxV1pLcW9IZFVvS1BI?=
 =?utf-8?B?WGJXakR6dkFwb2Yzbk5BZjBteC9BNDl4d3g1QVhKanZMYWREUFlhanhFWGth?=
 =?utf-8?B?UFFvQ2dRZk93TjV0clRyekFTT1NVbEIwbXlURlhVb2EwY2hialNPTzU2QTZw?=
 =?utf-8?B?L1YwVG0rMnRsdURJNTNXL3Jxb3BzdmxhcTMrWDloblBVWlZSb05rSmJQakVp?=
 =?utf-8?B?cVg2UWxTTmZmZ0FUamtsNVpzNERySGRKcytnWjMzRFdHbFdKZk5Zck9nRmph?=
 =?utf-8?B?N2lYbkVEVCtPbGNiV3M2bk1YL0xnN0o5dmovNGpvOWtEQW9yRjRTd0xBTWtL?=
 =?utf-8?B?VzdjdHZMS3JPeG5NeWIxei9mcUtVNnp4OG5mN0dqMnJJT0wyQkhLb1cyZXVx?=
 =?utf-8?B?ajQ1aVRFMFFtNHlIVEpuSjAvdXRLTHV1cHZQSHgxd3VnQ01mSWlZb3ZzSkFi?=
 =?utf-8?B?SlNMQnIzR2xMOTFqaHhZcFJVWCtoWnYrNE1yZ2JhRzYzc28xd09MM3pBako5?=
 =?utf-8?B?TWxlVG5pRGtITWNwNkErUG9NRHRiKysxMng5Vkk3S2haNXdMc3IzdFVDUGZT?=
 =?utf-8?B?TEFnUGRBV3czNGpOQzJDUCtwMWdGbmhQeGNwcjBnalpXTjJOWVNRUWh3MFo3?=
 =?utf-8?B?ZGg4dHNDZzdHemFJZWR5U205aTI4L2wxVGM5aFk2VzlSaUVkVUgwanJCT3VT?=
 =?utf-8?B?QVplMXVYa0VJMFg4VjhKSWNEd3kyUUUwVE14VEpYNHE2WTdOR2FodklrcHZx?=
 =?utf-8?B?NEExVzZZN0tDRHRIbzlYbndTck56bGpyNWEvbk1ZWmhicGtJOXFiS1lCT2cz?=
 =?utf-8?B?ektUdUZ3cEZNaVlMbDk2ZHZGNi96UGVpSUFmNW5BcTJEU20vMDUxWFUwQUZ5?=
 =?utf-8?B?V1FWSmx1RStaYWpZRUhiNVRuR2pRSGc2cEFyRlZOSXEzT2NjWHEzUTFtTzEv?=
 =?utf-8?B?R2txM20rZlg0em9IK1lTMFRkMGJMckFEY2xwQnVvUkRZYWowcU1GMlhJR0ox?=
 =?utf-8?B?RzNSUk11aTYzSzFQY1g0eGR6U0NiRXJxdUlMY213Sktsb3B0c2xqSmJQWldo?=
 =?utf-8?B?RHFTYVJRMXZlSHppSGMzNlQzcURKUXYyOGx0MTN3cDdtaU13RloyU1FJK0Fw?=
 =?utf-8?Q?owgjcnhudS3lQScNQL1t4DewP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f381ee-fea3-43e9-4dac-08dcbc0df636
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 03:05:33.0924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmLYTu5UhzQ0Jp7hZ1HWsv7gKMXxvmIPhTn2ZUX93IAVXJeWmUFri8Yt4axQ+BNBxj1zbqddrxkzRNKGaHr4KbODjaCdjK+gAsjQNL3Y8zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8261
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBpbnRlbF9pb21tdTog
TWFrZSBQQVNJRC1jYWNoZSBhbmQgUElPVExCDQo+dHlwZSBpbnZhbGlkIGluIGxlZ2FjeSBtb2Rl
DQo+DQo+T24gMjAyNC84LzE0IDEwOjI2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEluIHZ0
ZF9wcm9jZXNzX2ludl9kZXNjKCksIFZURF9JTlZfREVTQ19QQyBhbmQgVlREX0lOVl9ERVNDX1BJ
T1RMQg0KPmFyZQ0KPj4gYnlwYXNzZWQgd2l0aG91dCBzY2FsYWJsZSBtb2RlIGNoZWNrLiBUaGVz
ZSB0d28gdHlwZXMgYXJlIG5vdCB2YWxpZA0KPj4gaW4gbGVnYWN5IG1vZGUgYW5kIHdlIHNob3Vs
ZCByZXBvcnQgZXJyb3IuDQo+Pg0KPj4gRml4ZXM6IDRhNGYyMTllOGExICgiaW50ZWxfaW9tbXU6
IGFkZCBzY2FsYWJsZS1tb2RlIG9wdGlvbiB0byBtYWtlDQo+c2NhbGFibGUgbW9kZSB3b3JrIikN
Cj4NCj40YTRmMjE5ZThhMTAgd291bGQgYmUgYmV0dGVyLiA6KQ0KDQpBaCwgT0ssIE1pY2hhZWws
IGxldCBtZSBrbm93IGlmIHlvdSB3YW50IG1lIHNlbmQgYSBuZXcgdmVyc2lvbi4NCg0KVGhhbmtz
DQpaaGVuemhvbmcNCg0KPg0KPj4gU3VnZ2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVs
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZjxjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwu
bGl1QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgfCAyMiAr
KysrKysrKysrKy0tLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA2OGNiNzJhNDgxLi45MGNk
NGU1MDQ0IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0yNzYzLDE3ICsyNzYzLDYgQEAgc3RhdGljIGJv
b2wNCj52dGRfcHJvY2Vzc19pbnZfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgICAgICAg
ICAgfQ0KPj4gICAgICAgICAgIGJyZWFrOw0KPj4NCj4+IC0gICAgLyoNCj4+IC0gICAgICogVE9E
TzogdGhlIGVudGl0eSBvZiBiZWxvdyB0d28gY2FzZXMgd2lsbCBiZSBpbXBsZW1lbnRlZCBpbiBm
dXR1cmUNCj5zZXJpZXMuDQo+PiAtICAgICAqIFRvIG1ha2UgZ3Vlc3QgKHdoaWNoIGludGVncmF0
ZXMgc2NhbGFibGUgbW9kZSBzdXBwb3J0IHBhdGNoIHNldCBpbg0KPj4gLSAgICAgKiBpb21tdSBk
cml2ZXIpIHdvcmssIGp1c3QgcmV0dXJuIHRydWUgaXMgZW5vdWdoIHNvIGZhci4NCj4+IC0gICAg
ICovDQo+PiAtICAgIGNhc2UgVlREX0lOVl9ERVNDX1BDOg0KPj4gLSAgICAgICAgYnJlYWs7DQo+
PiAtDQo+PiAtICAgIGNhc2UgVlREX0lOVl9ERVNDX1BJT1RMQjoNCj4+IC0gICAgICAgIGJyZWFr
Ow0KPj4gLQ0KPj4gICAgICAgY2FzZSBWVERfSU5WX0RFU0NfV0FJVDoNCj4+ICAgICAgICAgICB0
cmFjZV92dGRfaW52X2Rlc2MoIndhaXQiLCBpbnZfZGVzYy5oaSwgaW52X2Rlc2MubG8pOw0KPj4g
ICAgICAgICAgIGlmICghdnRkX3Byb2Nlc3Nfd2FpdF9kZXNjKHMsICZpbnZfZGVzYykpIHsNCj4+
IEBAIC0yNzk1LDYgKzI3ODQsMTcgQEAgc3RhdGljIGJvb2wNCj52dGRfcHJvY2Vzc19pbnZfZGVz
YyhJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgICAgICAgICAgfQ0KPj4gICAgICAgICAgIGJyZWFr
Ow0KPj4NCj4+ICsgICAgLyoNCj4+ICsgICAgICogVE9ETzogdGhlIGVudGl0eSBvZiBiZWxvdyB0
d28gY2FzZXMgd2lsbCBiZSBpbXBsZW1lbnRlZCBpbiBmdXR1cmUNCj5zZXJpZXMuDQo+PiArICAg
ICAqIFRvIG1ha2UgZ3Vlc3QgKHdoaWNoIGludGVncmF0ZXMgc2NhbGFibGUgbW9kZSBzdXBwb3J0
IHBhdGNoIHNldCBpbg0KPj4gKyAgICAgKiBpb21tdSBkcml2ZXIpIHdvcmssIGp1c3QgcmV0dXJu
IHRydWUgaXMgZW5vdWdoIHNvIGZhci4NCj4+ICsgICAgICovDQo+PiArICAgIGNhc2UgVlREX0lO
Vl9ERVNDX1BDOg0KPj4gKyAgICBjYXNlIFZURF9JTlZfREVTQ19QSU9UTEI6DQo+PiArICAgICAg
ICBpZiAocy0+c2NhbGFibGVfbW9kZSkgew0KPj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAg
ICAgICAgfQ0KPj4gKyAgICAvKiBmYWxsdGhyb3VnaCAqLw0KPj4gICAgICAgZGVmYXVsdDoNCj4+
ICAgICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgaW52IGRlc2M6IGhpPSUi
UFJJeDY0IiwgbG89JSJQUkl4NjQNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiICh1
bmtub3duIHR5cGUpIiwgX19mdW5jX18sIGludl9kZXNjLmhpLA0KPg0KPi0tDQo+UmVnYXJkcywN
Cj5ZaSBMaXUNCg==

