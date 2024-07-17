Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70831C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 07:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzWU-00052c-PQ; Wed, 17 Jul 2024 03:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTzWS-00050S-8z; Wed, 17 Jul 2024 03:56:24 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTzWO-00021s-J6; Wed, 17 Jul 2024 03:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721202980; x=1752738980;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=42Hfgv7EsMnnIb+rSbiLvAg6s/qTbzIQgBwkLCxQBMs=;
 b=bLsky23/f/H0LGnpVLaxiwCMgv0XlxEzZZSiqDgLH61jc3vVMBg8xTNx
 V8ZVg+ECTTlmb9O8wuZBEqogTPPdEwHuaBaTrOmL32OCbqvCt1q7CTi87
 NaGJTutZSDIAUfaZxdKx49GKGAiXjH2Dh5LdVJbcWyXN9Dh2oIS31QMKz
 OA1ygt3ZlKOGSUPuPfzn4Bby8WVk6fuC2DnKfojxJ2UK0495BR1ALZqzA
 2F6HKhDZjTTGni0pvgL+OQuPUx0jKIFTqtwzd1NF6gMuOP8f3cROa1xHX
 AWbi6rtBxiKPOJp46F1zORDWqK0mbMw34NB2h/2xT5mv70A7tVyid8XO1 g==;
X-CSE-ConnectionGUID: wgiryP4NQ4KI+bO1/FXmAQ==
X-CSE-MsgGUID: H8hSHVAjTD+K7lBQqYwccA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="21592576"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; d="scan'208";a="21592576"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2024 00:56:12 -0700
X-CSE-ConnectionGUID: vxPM3cGcQuOmKL5C6gB/tw==
X-CSE-MsgGUID: I+I/d+lnSsufg89MEfvyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; d="scan'208";a="80971805"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jul 2024 00:56:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 00:56:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 00:56:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 00:56:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4FGt6iPhX2sHFWRNOjIqCNHtYs7B3maidk43UcDfA5n5LX8eLHykpjQ7HVAyQkTakmFdH8A9gDLZhKFgKQGEI8weAhZ4y9TfB5sMVUrH9hEtGeTgi+7jLJAJ5xvbK27JlovJcKE8HxyO0k3sgaHVLJKHIdN0hJd67jXWNmAkCMOk8Eixzs5WAgMHdc+4iWX3en+kOYEyD66cRULwKCdU6JdDJ/7+KorIR+d0daqPh/D3DhhO2ZoF+GabTeyr3Mjoti/NNxd4KDPsw9uQRuIOBvgRdMsCq+3ei/dux6SXaM1olgt8P6QGMtvBIYaLJ+mOOZjggf1w/BNvjsQv1Mb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42Hfgv7EsMnnIb+rSbiLvAg6s/qTbzIQgBwkLCxQBMs=;
 b=wrs83yPRhhqj21FMGgA/1v471WnEHw9ZHQ2Anjqie+iSvEyJrxMP8yAFy0cDNRV0dnJOH7ZXb+jeBPP0SFKnYVv2o7jChVgVTLEYucKO28usC2RAt9wzlW0wxA8ot00stUlgtmRdsrjxccYVxE9i+lBuZfsRxDvlT1GLQYqvPplj1VhUT+2yxY6BUNW84uAxWFw8drMb/qPbtzCf7CUJyPcEPxNnyJQOZBDPMflKg6q7oAQo3vZxO3xbgBnhwo9MvZvbWgojfv9TPjo/WVnGKQRi4+STrHu5Zl00gjWYd4PfCro06s0ZC3Gh9A+8SkbVv2BZYqSoAFaq9PTQ8MmfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 07:56:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 07:56:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "yanghliu@redhat.com" <yanghliu@redhat.com>
Subject: RE: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
Thread-Topic: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
Thread-Index: AQHa12UbO4rn2UclD0a3Gm+CKXWFyLH6PYMQgABNAoCAAAPA0A==
Date: Wed, 17 Jul 2024 07:56:08 +0000
Message-ID: <SJ0PR11MB6744A31211982D86A9F7040E92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <20240716094619.1713905-4-eric.auger@redhat.com>
 <SJ0PR11MB6744D54C9B81BD1AD2BE5E1A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d31d814e-ba00-4a2c-b905-d01022883b95@redhat.com>
In-Reply-To: <d31d814e-ba00-4a2c-b905-d01022883b95@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8444:EE_
x-ms-office365-filtering-correlation-id: 78686463-633d-40d3-72b4-08dca635ead7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SUJ4bFcrTzVRU1A2OG1iL0VIMVplNElqR1FUb29yZkwzTkl5Qnc3WVFuSWta?=
 =?utf-8?B?TkFyL3M3bVpzQ25UN0FpT05KQ3FvcDdmdWlpeG8zM2wxVkRnb0syRDlHNGt2?=
 =?utf-8?B?VFVjZ0FZY3J0eEhDM1RsVnF3TDYwOHlUYWZ0Yk9VOG9HdThWQkpaRTdUR2py?=
 =?utf-8?B?ZVgrNnpSUXY4dS9uWDFQRG9kM1JNRXBWTStiRHBDTDFraEtrSlE5U0xaeURx?=
 =?utf-8?B?NzhDRGhqajM3b1RZNHpPdUhLc2ZKeDhYakk5YTdhYkt5bFdiZTIyVmxVd3Iz?=
 =?utf-8?B?dXRxTXVWYlFaV3JQdkl5MXViNVJNbUJnTzBxVFdmK1djWElBRXZSa1dvVEo1?=
 =?utf-8?B?dTh6ZEt2alJiUE1tOCtuUWhpZlg4bVdnTWVqV0R5NFBPS2dlampwdFU2clp0?=
 =?utf-8?B?UUpaZTlBY1BRVE5nVGdFTTQwMmZRMkRVK25LUE9Qa1FJdWFDb1NZTzBxcmxp?=
 =?utf-8?B?dWxPOGdXRUszOFdSZW9iNTJYaWN1b2pNWjhTeVlJS2VmaDJJd0o5cjVIYTk5?=
 =?utf-8?B?b1FESVkvMGdZUjVVcnhNa2pVRW5iZW9Zdm5MS1BGOXd0a1NCNU9DbW1mM1pT?=
 =?utf-8?B?Y2h6T1NVdWtFVjBHaFFYelVyWHQzVTVpVFAwMGdUaTZ3MjdmRU1UUUFYd1Iy?=
 =?utf-8?B?cEtlWnkzOU5sRUMxUnh4N3ZEbXNtcjVFYjRNb1hMT2s0TW9kUnpVeXY3YldL?=
 =?utf-8?B?cjRwNEx3dnQ5Y1JZcGpvRG9IbFc4bWZzbzAxTUgzWTFuRXgyNVZiTnBZSXhw?=
 =?utf-8?B?YjZaMnQ5Y3k5UG9oZkFmaVZtVENSQ0ZxZXVqOGwwaUdqaUkvS0VkWndjM3BQ?=
 =?utf-8?B?dWZWLzFqcGVLT3VkbEE5bjZoZ25BQUtYaEFHWTRadUp5MUtVNUVqYWZJNFpT?=
 =?utf-8?B?cWZBUHplaFIycXZyQzRERDNQU1drc0VlWjl5RldaQ1ozaFRwUlY2RkQ0Mit2?=
 =?utf-8?B?ZkgyUS9vZW5YaW9sczZ2WWYzOE9TRW54Nzh2d0F0K0ZPZVFYRU5YbXQ3TUh5?=
 =?utf-8?B?VGlMTVV3cTJEUkdQdWwrMXBQckNhaUNLS3Zqa0tFL3JvL1VUYTFaamQvUzBZ?=
 =?utf-8?B?bWR3Z3Rjdi9XUlJtRVNzUTZnN041M1hMS2FxUXhIN3JpbU1lUndCQllHUUpV?=
 =?utf-8?B?ZGhXbTJ2RE8zaXNvbE41bzFVYU9mWEs2eGs3L0szYnhXSGNFbURieU4vTldX?=
 =?utf-8?B?VXpqRUE5ZlNKY2srR3BmQy9yUlk3OHpoMlE3ZVZESTA2cEsrK3FQVFZCdm5k?=
 =?utf-8?B?V1pNSnc1Y1lGQVp1Y1hKbzNQNjJaUUZaaW5UblVsRkYwQU5pcnVvaElaemVY?=
 =?utf-8?B?SHphYmFmS1VKY1hKWlI5Q21sbVkyZDFvUE5BZ0gxVm5RbEhiN2hwKzVhYjBU?=
 =?utf-8?B?NWduNW9UUEhKQzRvWUZmQlllMDJvTG5lK0g4UnhqWEZYQkdQK2UxSml2cEpk?=
 =?utf-8?B?cWdTNFIvQ24zdkpIQXZqaGMrUE1BZlpaMDJVNXU2cC9QQW11L0tHSkQzQVNY?=
 =?utf-8?B?VC91bjZIY21YR2crVFVEZTdGOTZ2bHdCZEVYOFl3Z0pjU3ZSbFhudW1MU2J4?=
 =?utf-8?B?YlpCTGZzL09kRTFiTTlNM0g0OGpKNjlYcFZoS2MzMGsxZm0yZndFOE1yckhD?=
 =?utf-8?B?dEU1YXAySzgyeSs5dzBUSHY1UEhaRlBNMndhWmpHRmtBampIN0thb0xXbkR5?=
 =?utf-8?B?TWhJTnVLK2YvWkJKeFoyOGJObFU2cFpPNDZDVVNyYnJxRFZQK0dVazJ1dmoy?=
 =?utf-8?B?a2tFa3BKbE5tM1cxc3RIRExaSTdVSjRLWXBaZ1RUSkRxWEkzVEx4cEZMcUlq?=
 =?utf-8?B?VVZXSy9XUlFUQjQzckh6V3VpL2E1VGpFVUw0ektkODlaRGtNUERuNzlOUVNp?=
 =?utf-8?B?ZlhDYkpTd3BFRFdOelJ3SjNRMjlBUzdITTlCdjRLSFl6YTNFeWUrdDFPMHJB?=
 =?utf-8?Q?OaXvcAD1i1E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxqZkxZTk52dGZVV2V1c2EyTnBLV0hiYXFmK2xRbGVoajF6WWxyZUM3dWZx?=
 =?utf-8?B?cmdicFZ3b2FvVnNqQ0Y1NENYWEpuUVZwN2JDRjdpdXYzRUxtZGhlK1pjeFNP?=
 =?utf-8?B?ZnVFSThjTkpiNFZHcEtQbHRCYVhsU0VHeUZ2ODBnODkwR2NMYVBsamtMaTcx?=
 =?utf-8?B?dGVneU50Q3VZR2hBZGNpcEp3djIyYnJZSWdOV2VtKzFUOEdld3ZoczlSL0Vv?=
 =?utf-8?B?V2ZkTEhFYUFhRys5WVpYWXNnRzdxaktJeDlKQWkvc0R5aGtWME5ndDdnNnAr?=
 =?utf-8?B?bURscHFNVVdXRlM3d2d2OGZCTk1LcWVMOENkUCt1blFDUEwxbkRySDVNN0tt?=
 =?utf-8?B?cHU5YXAxZGxQa1JSbkt4aDZLZmxVYlM1QlIrMmxyTWEyUWJFcW4rMmVnZEd6?=
 =?utf-8?B?SkJLdTdSNU92YTJnNXIzNzBLeG51UC8vVWViMWtvemt3Titnc3M3OUlyd2Z0?=
 =?utf-8?B?SUJ1VDA0RUNhMWZYU3hicXh1VHlZWmc0emdqeDd0ZUlBUWtXcHRUYURVNmhj?=
 =?utf-8?B?emlGZERPN245SVNiZEdyNmRpVVNXV2tIWnR4cjRleThxR09ocEU1bTRsNytr?=
 =?utf-8?B?aE13aklwZ3ozRlcvaDVwUHRYalE1U2pCM2pwaWtuczFNcFFTMHJ4a1RtK3RN?=
 =?utf-8?B?RjJQMDZiMG9oRWhBbHZMNXliY1dXNTA0bmh3cjA5bFFKTkRUN2hrTEoxYmUw?=
 =?utf-8?B?OEV6TkgxVEEwZ2NBUEtraW5MaFRwTGUxdjM0UFpKcUczYWVUL2N5d0lxbnIv?=
 =?utf-8?B?YjkwaSsyMDlyL1VPaGQwQ0FGb01RampQazBqbi8vc1ZJa2lYQUF6bUhlQmw1?=
 =?utf-8?B?S2o4djFYNzY1NWJrL3o2TlhKQmxvc255MUx1N0ZsZFc4SWhlN1ZpKytBSGtP?=
 =?utf-8?B?a21oK0grdGVQSzhkWU1ScVQrZHZDcXU5NVkwWXFnM2g5VTdVK3ZRdUVHOGlp?=
 =?utf-8?B?YkZaalp0YzUySXQ1bTB2QmtvTEQ2Rk1TRGlwK2lzbFg3aWVnQTBwUTFEZDJX?=
 =?utf-8?B?UGU5QTNVb1kwR1hBenBWeEdxdGpCV215blZpT3VmMnZOODZyb0lvRHhFdnZS?=
 =?utf-8?B?L3dUVTRBNmtIQ0wvNURVeHhnRGh4blNweHJXQzRyWStnT3IvYnArMW5JRlQr?=
 =?utf-8?B?dDBEVnhrVlNSRG45a3BqbXBCS1RvZ3JGRmNtSm1wVDZRVGhJNDFHcnBBN1A3?=
 =?utf-8?B?N3FhbUFkdFFaVVBRaHNpVkJtbXFCRGYvZTljTHVRaUVMNEpUYTAzRW1oeVFm?=
 =?utf-8?B?TEl5UE1QZkNYZWVnakZmMjRIV09XQzZndnJLWHllYlVUWVNwNXloZm5hd1gw?=
 =?utf-8?B?eTkvMjJQYnRoaFc5L3ptcUNIVngvcSt0WEJBTkJ6eWZ1WmxOckdSVlB4Vmdy?=
 =?utf-8?B?LzBwR2UxN0l6bjlZbFB1VGFJbWZKQVJQY1JmS09KY2VwSmpiVnlpVTZsRWpT?=
 =?utf-8?B?VmZ3WlM1a0JjT1BSRnhEd3FIR1laU1BWRkQ2MjZRZHBJSHY2NHBQS1lsTDdS?=
 =?utf-8?B?SnNidHB1WERyOW5tWVdnZ2pobDd2R0YrQnVnS1RuTkg5OUNKNHBQdFFSZnFo?=
 =?utf-8?B?aU5kSWpXOGNBT1VsblV2VTIvUzNOL1hGV2Z5UEZEWWpPM0lqZWUxbks5M3lV?=
 =?utf-8?B?ODFlelRMS1Y1SGxFVkJ4Tk5oSHpGSGFnZWVKYUNsRmJ1cXdxd0VaVnhYNGlh?=
 =?utf-8?B?MVpBN2ZkSk9WSWRKQldDaTRZNGNkUStMdlFIaE14eTVSYTdURVZURCtMVHkz?=
 =?utf-8?B?TjdVZlc1d0NHaTZhVzd3MnZJcTB4dmFrZ2J0TjRERy9CMVJaaXNVTG9WU0M4?=
 =?utf-8?B?UnlZcmNmam9GM1ZBcnZTMGRiYlpsYzVSeWtGNU1rRjFZQ3RJT3duTnF3T2tO?=
 =?utf-8?B?RGpaS3FoZFBlbjJQbVpzZGVJMHp5bS9BQXVzV2dpUVpxMWdSamFxWUJJdm4y?=
 =?utf-8?B?QWQxUmtlbVN2dE5tN1pSQzlUemdYdkt1SVdBWnpBWjQyMklHSXBsYzI4UmlQ?=
 =?utf-8?B?cGhUQ1JWRkpqY0lOUFdRYm4rWVdNYXhKQzFlL2o5SWFWWW9aS05LdXI0Ykht?=
 =?utf-8?B?ZDkrN2hlbVFwcDVsRFdJSlJEMzdCSXBPeXB4V0xLM0Y4M3FNdGE1aDA4R3ZN?=
 =?utf-8?Q?/r0UL3EIK3FK0oR3hLvbpz4gl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78686463-633d-40d3-72b4-08dca635ead7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 07:56:08.2624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aubt6yiuuEDIO26uovuV1C+sErJwCSAxpq/tZjMugM/mmq7PAnqnJXWrpRogOb1zoveX1QHVIzjtahvlmbszZm8fLJx8zSf2w2/3ZFPwFuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDMvNl0gdmlydGlvLWlvbW11
OiBGcmVlIFtob3N0X11yZXN2X3JhbmdlcyBvbg0KPnVuc2V0X2lvbW11X2RldmljZXMNCj4NCj5I
aSBaaGVuemhvbmcsDQo+DQo+T24gNy8xNy8yNCAwNTowNiwgRHVhbiwgWmhlbnpob25nIHdyb3Rl
Og0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVn
ZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0ggMy82XSB2aXJ0
aW8taW9tbXU6IEZyZWUgW2hvc3RfXXJlc3ZfcmFuZ2VzIG9uDQo+Pj4gdW5zZXRfaW9tbXVfZGV2
aWNlcw0KPj4+DQo+Pj4gV2UgYXJlIGN1cnJlbnRseSBtaXNzaW5nIHRoZSBkZWFsbG9jYXRpb24g
b2YgdGhlIFtob3N0X11yZXN2X3JlZ2lvbnMNCj4+PiBpbiBjYXNlIG9mIGhvdCB1bnBsdWcuIEFs
c28gdG8gbWFrZSB0aGluZ3MgbW9yZSBzaW1wbGUgbGV0J3MgcnVsZQ0KPj4+IG91dCB0aGUgY2Fz
ZSB3aGVyZSBtdWx0aXBsZSBIb3N0SU9NTVVEZXZpY2VzIHdvdWxkIGJlIGFsaWFzZWQgYW5kDQo+
Pj4gYXR0YWNoZWQgdG8gdGhlIHNhbWUgSU9NTVVEZXZpY2UuIFRoaXMgYWxsb3dzIHRvIHJlbW92
ZSB0aGUgaGFuZGxpbmcNCj4+PiBvZiBjb25mbGljdGluZyBIb3N0IHJlc2VydmVkIHJlZ2lvbnMu
IEFueXdheSB0aGlzIGlzIG5vdCBwcm9wZXJseQ0KPj4+IHN1cHBvcnRlZCBhdCBndWVzdCBrZXJu
ZWwgbGV2ZWwuIE9uIGhvdHVucGx1ZyB0aGUgcmVzZXJ2ZWQgcmVnaW9ucw0KPj4+IGFyZSByZXNl
dCB0byB0aGUgb25lcyBzZXQgYnkgdmlydGlvLWlvbW11IHByb3BlcnR5Lg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+IC0tLQ0K
Pj4+IGh3L3ZpcnRpby92aXJ0aW8taW9tbXUuYyB8IDYyICsrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwg
MzQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1p
b21tdS5jIGIvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+Pj4gaW5kZXggMmM1NGMwZDk3Ni4u
MmRlNDFhYjQxMiAxMDA2NDQNCj4+PiAtLS0gYS9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4+
PiArKysgYi9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4+PiBAQCAtNTM4LDggKzUzOCw2IEBA
IHN0YXRpYyBpbnQNCj4+PiB2aXJ0aW9faW9tbXVfc2V0X2hvc3RfaW92YV9yYW5nZXMoVmlydElP
SU9NTVUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4+IHsNCj4+PiAgICAgSU9NTVVQY2lCdXMgKnNidXMg
PSBnX2hhc2hfdGFibGVfbG9va3VwKHMtPmFzX2J5X2J1c3B0ciwgYnVzKTsNCj4+PiAgICAgSU9N
TVVEZXZpY2UgKnNkZXY7DQo+Pj4gLSAgICBHTGlzdCAqY3VycmVudF9yYW5nZXM7DQo+Pj4gLSAg
ICBHTGlzdCAqbCwgKnRtcCwgKm5ld19yYW5nZXMgPSBOVUxMOw0KPj4+ICAgICBpbnQgcmV0ID0g
LUVJTlZBTDsNCj4+Pg0KPj4+ICAgICBpZiAoIXNidXMpIHsNCj4+PiBAQCAtNTUzLDMzICs1NTEs
MTAgQEAgc3RhdGljIGludA0KPj4+IHZpcnRpb19pb21tdV9zZXRfaG9zdF9pb3ZhX3JhbmdlcyhW
aXJ0SU9JT01NVSAqcywgUENJQnVzICpidXMsDQo+Pj4gICAgICAgICByZXR1cm4gcmV0Ow0KPj4+
ICAgICB9DQo+Pj4NCj4+PiAtICAgIGN1cnJlbnRfcmFuZ2VzID0gc2Rldi0+aG9zdF9yZXN2X3Jh
bmdlczsNCj4+PiAtDQo+Pj4gLSAgICAvKiBjaGVjayB0aGF0IGVhY2ggbmV3IHJlc3YgcmVnaW9u
IGlzIGluY2x1ZGVkIGluIGFuIGV4aXN0aW5nIG9uZSAqLw0KPj4+ICAgICBpZiAoc2Rldi0+aG9z
dF9yZXN2X3Jhbmdlcykgew0KPj4+IC0gICAgICAgIHJhbmdlX2ludmVyc2VfYXJyYXkoaW92YV9y
YW5nZXMsDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbmV3X3JhbmdlcywNCj4+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIFVJTlQ2NF9NQVgpOw0KPj4+IC0NCj4+
PiAtICAgICAgICBmb3IgKHRtcCA9IG5ld19yYW5nZXM7IHRtcDsgdG1wID0gdG1wLT5uZXh0KSB7
DQo+Pj4gLSAgICAgICAgICAgIFJhbmdlICpuZXdyID0gKFJhbmdlICopdG1wLT5kYXRhOw0KPj4+
IC0gICAgICAgICAgICBib29sIGluY2x1ZGVkID0gZmFsc2U7DQo+Pj4gLQ0KPj4+IC0gICAgICAg
ICAgICBmb3IgKGwgPSBjdXJyZW50X3JhbmdlczsgbDsgbCA9IGwtPm5leHQpIHsNCj4+PiAtICAg
ICAgICAgICAgICAgIFJhbmdlICogciA9IChSYW5nZSAqKWwtPmRhdGE7DQo+Pj4gLQ0KPj4+IC0g
ICAgICAgICAgICAgICAgaWYgKHJhbmdlX2NvbnRhaW5zX3JhbmdlKHIsIG5ld3IpKSB7DQo+Pj4g
LSAgICAgICAgICAgICAgICAgICAgaW5jbHVkZWQgPSB0cnVlOw0KPj4+IC0gICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPj4+IC0gICAgICAgICAgICAgICAgfQ0KPj4+IC0gICAgICAgICAgICB9
DQo+Pj4gLSAgICAgICAgICAgIGlmICghaW5jbHVkZWQpIHsNCj4+PiAtICAgICAgICAgICAgICAg
IGdvdG8gZXJyb3I7DQo+Pj4gLSAgICAgICAgICAgIH0NCj4+PiAtICAgICAgICB9DQo+Pj4gLSAg
ICAgICAgLyogYWxsIG5ldyByZXNlcnZlZCByYW5nZXMgYXJlIGluY2x1ZGVkIGluIGV4aXN0aW5n
IG9uZXMgKi8NCj4+PiAtICAgICAgICByZXQgPSAwOw0KPj4+IC0gICAgICAgIGdvdG8gb3V0Ow0K
Pj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIiVzIHZpcnRpby1pb21tdSBkb2VzIG5vdCBz
dXBwb3J0IGFsaWFzZWQgQkRGIiwNCj4+PiArICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsN
Cj4+PiArICAgICAgICByZXR1cm4gcmV0Ow0KPj4+ICAgICB9DQo+Pj4NCj4+PiAgICAgcmFuZ2Vf
aW52ZXJzZV9hcnJheShpb3ZhX3JhbmdlcywNCj4+PiBAQCAtNTg4LDE0ICs1NjMsMzEgQEAgc3Rh
dGljIGludA0KPj4+IHZpcnRpb19pb21tdV9zZXRfaG9zdF9pb3ZhX3JhbmdlcyhWaXJ0SU9JT01N
VSAqcywgUENJQnVzICpidXMsDQo+Pj4gICAgIHJlYnVpbGRfcmVzdl9yZWdpb25zKHNkZXYpOw0K
Pj4+DQo+Pj4gICAgIHJldHVybiAwOw0KPj4+IC1lcnJvcjoNCj4+PiAtICAgIGVycm9yX3NldGco
ZXJycCwgIiVzIENvbmZsaWN0aW5nIGhvc3QgcmVzZXJ2ZWQgcmFuZ2VzIHNldCEiLA0KPj4+IC0g
ICAgICAgICAgICAgICBfX2Z1bmNfXyk7DQo+Pj4gLW91dDoNCj4+PiAtICAgIGdfbGlzdF9mcmVl
X2Z1bGwobmV3X3JhbmdlcywgZ19mcmVlKTsNCj4+PiAtICAgIHJldHVybiByZXQ7DQo+Pj4gfQ0K
Pj4+DQo+Pj4gK3N0YXRpYyB2b2lkIHZpcnRpb19pb21tdV91bnNldF9ob3N0X2lvdmFfcmFuZ2Vz
KFZpcnRJT0lPTU1VICpzLA0KPj4+IFBDSUJ1cyAqYnVzLA0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZGV2Zm4pDQo+Pj4gK3sNCj4+PiAr
ICAgIElPTU1VUGNpQnVzICpzYnVzID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT5hc19ieV9idXNw
dHIsIGJ1cyk7DQo+Pj4gKyAgICBJT01NVURldmljZSAqc2RldjsNCj4+PiArDQo+Pj4gKyAgICBp
ZiAoIXNidXMpIHsNCj4+PiArICAgICAgICByZXR1cm47DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+
ICsgICAgc2RldiA9IHNidXMtPnBiZGV2W2RldmZuXTsNCj4+PiArICAgIGlmICghc2Rldikgew0K
Pj4+ICsgICAgICAgIHJldHVybjsNCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gKyAgICBnX2xpc3Rf
ZnJlZV9mdWxsKGdfc3RlYWxfcG9pbnRlcigmc2Rldi0+aG9zdF9yZXN2X3JhbmdlcyksIGdfZnJl
ZSk7DQo+Pj4gKyAgICBnX2xpc3RfZnJlZV9mdWxsKHNkZXYtPnJlc3ZfcmVnaW9ucywgZ19mcmVl
KTsNCj4+PiArICAgIHNkZXYtPmhvc3RfcmVzdl9yYW5nZXMgPSBOVUxMOw0KPj4+ICsgICAgc2Rl
di0+cmVzdl9yZWdpb25zID0gTlVMTDsNCj4+PiArICAgIGFkZF9wcm9wX3Jlc3ZfcmVnaW9ucyhz
ZGV2KTsNCj4+IElzIHRoaXMgbmVjZXNzYXJ5PyByZWJ1aWxkX3Jlc3ZfcmVnaW9ucygpIHdpbGwg
ZG8gdGhhdCBhZ2Fpbi4NCj5NeSBnb2FsIHdhcyB0byByZXNldCB0aGUgc3RhdGUgdGhhdCBleGlz
dGVkIGJlZm9yZSB0aGUNCj4NCj52aXJ0aW9faW9tbXVfc2V0X2hvc3RfaW92YV9yYW5nZXMoKSB3
YXMgY2FsbGVkLiBwcm9wIHJlc3YgcmVnaW9ucyB3ZXJlDQo+b3JpZ2luYWxseSBhZGRlZCBpbiB2
aXJ0aW9faW9tbXVfZmluZF9hZGRfYXMuDQo+VGhlIG5leHQgZGV2aWNlIHRvIGJlIGhvdHBsdWdn
ZWQgYXQgdGhpcyBhbGlhc2VkIGJkZiBpcyBub3QgbmVjZXNzYXJpbHkgYSBWRklPDQo+ZGV2aWNl
IChtYXkgYmUgYSB2aXJ0aW8gb25lKSwgaW4gd2hpY2ggY2FzZSB3ZSB3b3VsZCBtaXNzIHRoZSBw
cm9wIHJlc3YNCj5yZWdpb25zLg0KDQpZZWFoLCB5b3UgYXJlIHJpZ2h0LCB3ZSBtdXN0IGhhdmUg
aXQuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4+DQo+PiBPdGhlciB0aGFuIHRoYXQsIGZv
ciB0aGUgd2hvbGUgc2VyaWVzLA0KPj4NCj4+IFJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPg0KPlRoYW5rcyENCj4NCj5FcmljDQo+Pg0KPj4g
VGhhbmtzDQo+PiBaaGVuemhvbmcNCj4+DQo+Pj4gK30NCj4+PiArDQo+Pj4gKw0KPj4+IHN0YXRp
YyBib29sIGNoZWNrX3BhZ2Vfc2l6ZV9tYXNrKFZpcnRJT0lPTU1VICp2aW9tbXUsIHVpbnQ2NF90
DQo+Pj4gbmV3X21hc2ssDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJy
b3IgKiplcnJwKQ0KPj4+IHsNCj4+PiBAQCAtNzA0LDYgKzY5Niw4IEBAIHZpcnRpb19pb21tdV91
bnNldF9pb21tdV9kZXZpY2UoUENJQnVzDQo+KmJ1cywNCj4+PiB2b2lkICpvcGFxdWUsIGludCBk
ZXZmbikNCj4+PiAgICAgaWYgKCFoaW9kKSB7DQo+Pj4gICAgICAgICByZXR1cm47DQo+Pj4gICAg
IH0NCj4+PiArICAgIHZpcnRpb19pb21tdV91bnNldF9ob3N0X2lvdmFfcmFuZ2VzKHZpb21tdSwg
aGlvZC0+YWxpYXNlZF9idXMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBoaW9kLT5hbGlhc2VkX2RldmZuKTsNCj4+Pg0KPj4+ICAgICBnX2hhc2hfdGFibGVf
cmVtb3ZlKHZpb21tdS0+aG9zdF9pb21tdV9kZXZpY2VzLCAma2V5KTsNCj4+PiB9DQo+Pj4gLS0N
Cj4+PiAyLjQxLjANCg0K

