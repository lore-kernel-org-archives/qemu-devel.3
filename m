Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B994ECD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7sB-00010z-30; Thu, 21 May 2026 14:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1wQ7s9-00010e-Uw
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:11:53 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1wQ7s7-00046r-HK
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779387111; x=1810923111;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3uEHCfe4KT3GMKlzMnNaH/KROa3l1V0f5EHpLok4XUA=;
 b=cfWY93zUUQpjoko1laE3d8rTPkaA6/1+3ZfTr4LIVYZDXD9yitc7vP6F
 pqoeLtaLQWM55ojTaAKdSmk9A7PLklwFxRiZR1++WD60GPeH4lXt20ddo
 HE10wNIlIV7Uj2k9alfljTS2x5Kp3D/tcD7SDeUseXRdsbGCEyznfRKAN
 MrnqeJsDA/dKdNg2RDK3GrzgNTsr165XPk5ugBB35UMjdIwJ2fRIBJJNf
 vv8vN6Nciu4FS+Yx9EgcUQ9yn70CMl9Z9xhJK5e28FdlBbEr17ai+4OvU
 zqisLHkPgkLVVFN8uZVSsihtufd05pTienp5EkEub7gk5/8kzO9W4VYh0 Q==;
X-CSE-ConnectionGUID: HSo+jh+zQfGUHAEy55nJ6g==
X-CSE-MsgGUID: 0oSzOUaJSFenHvZ8HLDNWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="82891533"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="82891533"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 11:11:48 -0700
X-CSE-ConnectionGUID: XEif3xYpQ3izTizTkoH9Sg==
X-CSE-MsgGUID: 1tRdc/WSTH6N2+gRYd6JEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="237990525"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 11:11:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 11:11:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 11:11:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 11:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHUtq6c5XxumjMdMqiG8EDPsvGK37KBcq1rPMWoVONaQgRD4V4i3/quqcNgMz+DeC5yN9bRTjyB5XVG0muVwn86gG1RWlXO7YuCn9c0Qj8UZDNnJoZXZ9Fmr3c1lFsfRghVB07BL2+eIgDgRSML0Q21W0qOUkOXeMd6XpwRFplsK7ZnuaObzrakTCMuLlBS77wJF27lRG8OfPxKrN9xUWI8u02+DNC0nM+eGoeN7QCj35fkF0W/nVpsthdCusQdwMY4qYgZEXFTT2BCAU8CVSlp+b5OfkfPrPfdiwrHQ7UasbnHZ/FhW4KZI/Ft+c7WYzn+Wwk0cRpLhuKCSxkWLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uEHCfe4KT3GMKlzMnNaH/KROa3l1V0f5EHpLok4XUA=;
 b=hqtlLOoxa5ybMOBbzsjzFCq/+BVn4ggFm7b+fJxTVnoZ1fPqaTjYKMLObtzZv73c559kXRzJWbjqXHRG9WHdaY08O2o/qDK4Qsr4n2ZVUPyeLzyEp/FV1EiA5nBNvlIMszh1vxvQhYXMGfZMg6h2Hl/yTl7TYgTxvujBf3MBfnIipLLNsaBUbRfwca6Lb99bX0yyl4abdK/3uXiTGSz+fNwm+JG1yGuP50sVGEgGWNs8SZ6WvdJUgVdXk2FzmNWSzlol2K6YbpKTdaXyPJQm15WrvHt0B6aSq5q+n+hxKCITu64rYR8433sSkQmcTHoPI+VJDAydMh6kkJ07Hi21nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH3PPFBA2AA2BA3.namprd11.prod.outlook.com (2603:10b6:518:1::d46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 18:11:46 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 18:11:46 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] ui/egl: reset framebuffer state when creating new EGL
Thread-Topic: [PATCH] ui/egl: reset framebuffer state when creating new EGL
Thread-Index: AQHc6LufkqwUkeihV0eF4qoe4OGSKbYYVUyAgABxphA=
Date: Thu, 21 May 2026 18:11:46 +0000
Message-ID: <PH0PR11MB511233ACF47D28E9965C5A5BFA0E2@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260521004226.1914121-1-dongwon.kim@intel.com>
 <CAJ+F1CLN+y6vopPwY2gE=dHPQAjptOxFjaapzf01aHmK1a+gVw@mail.gmail.com>
In-Reply-To: <CAJ+F1CLN+y6vopPwY2gE=dHPQAjptOxFjaapzf01aHmK1a+gVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|PH3PPFBA2AA2BA3:EE_
x-ms-office365-filtering-correlation-id: 92e2253a-4fda-4d1a-de51-08deb7646ba3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|4143699003|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: CauQdWlfaPy4wnEoezMO7UD2dZGdh8cUGYJmUyj7bXRgMG+kTq6v9SfHpl3IwZXI4nRi5YZvDDz4/AGcNFdMHOLv2vDKgU+GHLvKU3HMPuuo6fCirZ5kXmQ6LXlXQXacdvlYwh2pce0Gt3wWTIVGbvCEB4gFPTE1DRcp8xY9q0p6O38njDuvlk/bQV0JyMR+nZ0YD+Z2Uxek8+JV++0fpiVrHLeaXM+bpaXwOCsTayg+1Ujm8mMZBO4T5P8UecSPgmpbrY/b2cIz/cJCv6THDdjMKwYdUNPtRLdah7htproN/Tb7lxCsX8+s2W7iCxBZW0eJz/czsk8xcgSnypA+k0t6lhzJ+ll3sTdnK415c3g/S9qS558fVf6IwNa9GaqghEjwKNJQYO+w0Mi7oWtkS/W4Ejhm1Axzq7XmjBzKnNVni4t9QxmG7EMsfpXsl1GPIr34YfkBuJaraH8lJVJmZJxVBlECa2zKTbX+pxHruXidinNN+Qp6hnFerNNL6lKe59KpCO8ThiAqscrY/o4eaonWq639iLE+30qI5IwUnDOESOQTCAvDLvFSroyiw7FqC76cmJbUIQvWANAaF5Xu282Wug8/y/cY8HEafiBEEJmgAVdBKuVHbbIwviecmjuwUNbEyGeYRla8fXClRgRJf1knLPiwRCKMBXLr5/V6CMpfqdVgvSsKgfs9WOAh0mYh/G3Ld29Kje/DJYBCUCJmwkMVTA3CVtQ4/9ATCVw2eO40gOEnFutVfMWcl4cIR2ET
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(4143699003)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjM1ZjBUdDJoMklCa05HeDNyemdrMkRwelZIcWNLT3FlOTF4K3JEZlArb1Q0?=
 =?utf-8?B?ZU15b1hubGdSQUdnRmYzNlBkazFjUXRCU1g4ZDhyR2tJQ3BSa1VacENrcE5W?=
 =?utf-8?B?UWg4Rmp3TXJYRnBzUkZONDNiWm5OVFpOL2RpekR0QXM2VzhEZUs0VkdUbXNr?=
 =?utf-8?B?b2QwSmYra3kvOWluMGZ0U3I1cDZoLzdnRHZlSklmc3lGTUtBeWhYM2crSnZ3?=
 =?utf-8?B?RWhoSjF4cXE1MGFrbGpKWW95V0RxclBXTVpPN2M0M1lod0N1QXlBTlZ5NUlj?=
 =?utf-8?B?di9paVdidEhXcWtXY0dScUNRNU1vQjM5NTg2VUdNZkRyZW5CQ2tzVWY3QytT?=
 =?utf-8?B?ZDNxNFdTY0ljMmVZSG1jd3RLYXVzVVJMT1dnYmlKYlNITHovMkR0bDVCNkpH?=
 =?utf-8?B?aUxEQ3Z0MlRHR0lHbzFnOFlLTi9Gb1duOS93MlFZczh2YUJ4Y2ZhZEJwNTg1?=
 =?utf-8?B?S1VVUTRod1M3Z1NjQ3kzYUVOcTlVUTN2amZXNmdvNWNVNnRTT05WQ3daU24w?=
 =?utf-8?B?TGYrMlRqUWNJM0xqSHhCalM1L1BvTFk4ekY5SGlyNEVCRVQ3VTBiNVFiMjFm?=
 =?utf-8?B?U1lVRndzK0lNZk1BalBTTUdReHJVWmlOSVNKRm9NRWtjMTNiTEZZTVFZOXpB?=
 =?utf-8?B?MVp4MVRreVNnZm1SQXhjWXczVlJjMjdhdHZyM2FYQVZoZWJaVkFDS0xGc0lx?=
 =?utf-8?B?eWZBRTZaMCt1WTZ0dlIzcmNSaHpiejU5bGtxMzJSTVlMQk5adml5NUtZeWdB?=
 =?utf-8?B?T3RSUndkQld4SGR3bG0xelJmV0tINXdOejBLN2cvVndJeVBIbjhwcjlxSFo0?=
 =?utf-8?B?UWRzZThCQStoT3dibjNVdU4wTzJJSCtVVWFsRnVjNzBrdDhXaTlPQ2pycFFD?=
 =?utf-8?B?L0k4Zy95d3JzVUIxaEZROVJuRFo4eG9sNEJHN2J4MnhuNEkrNUZLaEZUY1BV?=
 =?utf-8?B?WHp5eHFMdXBZSzMrcjE5dEwzOTNSUFozYll6VkRmNlo3bjY5c2xLWGErQ2Qr?=
 =?utf-8?B?WDRQczF6d0s1T2pDODl1M0Y5ZTdXYzZISjVJcVNaSHdmNDdXQzVxeEp2dllX?=
 =?utf-8?B?amM0WWpXRitOMkJhRkJpYUE1WGpuUHF2cmREbUpwSHB2YVdFL0ZNQjJoalpu?=
 =?utf-8?B?b0x6QVlyZ3duSG1xamlLS1JueEQxaFR6Zk0xT3RzNVM3MWthMEgvMG91a05a?=
 =?utf-8?B?ZXdJbnFNMEdsSit2ckZkbmVEOEhaWnhNbDlod1ZmZ2prZHdzVno2ZE1NSjF5?=
 =?utf-8?B?WERaWTZTcUtNaXVFank1ODFKSnQvNFhNQlg3Z29vNzRzQ3R5czBTZkdqRlNE?=
 =?utf-8?B?OEExOERhZTk1ZWtwSk5HVGxwbGI1dU42ZnVWakNORDdhUkpJWllaUyt3SW03?=
 =?utf-8?B?d3JyTWtrWExNWjdVeGxMZXVSeTNpN0lISXZNcnlkWnlRMmpNc1JrK0xiRHM2?=
 =?utf-8?B?NWNlUVNmdUlxUm81TVp2ZG1lZ0ttajNaeEhCVmdnd3FER0FhVkNISTh0Z3NU?=
 =?utf-8?B?cDMxVzVabjNKTzNXd0JuU1ZwdC9QRFVpN0ZpMHdJWTRieFZ1UWJPZ0h3ZGM5?=
 =?utf-8?B?alJOS3NhNGM5M3k4Q1RPSzl2MjIzY1c4TWdnVFdxZzlMeHBFd2JQN2gwOGph?=
 =?utf-8?B?enVTZUI0TDM0KzdaeTdDbVZqbzB2QW1pSWJFQ2pPeks4VER6d1FSL256ayt3?=
 =?utf-8?B?cVpoTTRnT1NNMVRJNmdVYlBmaUgwb0p3N0NrMy9vNXUwWk1WNlowNmFiSTBH?=
 =?utf-8?B?eEJZQ0k2dVJodUhma2s3SG1lN0gyQjVqbDZnckpLRWdMWWVQUXBtQmhrY3NF?=
 =?utf-8?B?NWFJYlRPS2JUZzhRdHYvODRTM1M0V3IxcnNYVlpQVHgydmdYWlRWb2N1Vms2?=
 =?utf-8?B?aGo0NzVzc2JEMU5IWUlta1FCbkZzVlpjekgzOVU0bGJZOTgzSlFqMmg2SEk5?=
 =?utf-8?B?OSszRnJNTWFMb0FhV0ZCTUY2T25EMmhieTQwOEFPQmlFQW13ekQ0SXVwR3Rs?=
 =?utf-8?B?Wkg3RFQvN1o1NytBZjl0MEZmUzZ5bHlHS25yejhycDZZM1F0UXVxTDdOUlhI?=
 =?utf-8?B?SXhFNlp5QkQyWHNKUUNPck9YNTlxL1NlYlROM2U1ZUFpY09iYVJTaTJqQTFQ?=
 =?utf-8?B?b293ck56bDJ6cGhmU1RqVDg0TW4xM2l4aGc3Sm4rbHhSME9sY3V6c0puU1k4?=
 =?utf-8?B?ZXR2RkF3alJRSUd5YyttN00rRVFhdUNFd1ZPakJYZzFySnpsazJHNGZyUWZz?=
 =?utf-8?B?M1Jpd1dZUmcwZ2w5d3VBNStqMjI5Nk8xL21zdHArZmFNdWJKM205V2FIdXBt?=
 =?utf-8?B?aW9PTjdsQWNjR1VzWnl1Z2hWUE9yckd4TWdLTHgyQW1JcExsVm8vQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HB5rgm2QlJ7if6pfd8P6EMdbZS14JeVbnkNwqQ8Q/6BoHIKvD8rTsQlNOVgzl0NXjHJp6otDQ6BODPiezFvievhY/BZXM8Hu/eWhAIxSC560ciQXIgYkzOcWlAymN9ei+JVbdcI5NEwdBYU9gpUrCbYxUrCVVtnM10n9/t3k233Dl44CMN4rSzg1UarWxAtb2ITgw33elDiBFGlErfnyMi00KhrL8FJY9cG1zallKPfk0gSXQ3sDsatDfKWTe6YHWYBEOsmWSx2l9q3k78swt/ksatKaeY25XS0L1TRq0k379UsnSz9dEiWtmDK8r3lNsoUxnkuiwkdjiBMqfB9RHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e2253a-4fda-4d1a-de51-08deb7646ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 18:11:46.2727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGYdWmEO7VLXqUIwYhB6TLTrZIhoWuu4YEP///VhqhhdEb0RhtlOxApfs3FZsLRApclweFj0oI19oKcvlwZd+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBA2AA2BA3
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdWkvZWdsOiByZXNldCBm
cmFtZWJ1ZmZlciBzdGF0ZSB3aGVuIGNyZWF0aW5nIG5ldyBFR0wNCj4gDQo+IEhpDQo+IA0KPiBP
biBUaHUsIE1heSAyMSwgMjAyNiBhdCA0OjQ44oCvQU0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29t
Pg0KPiA+DQo+ID4gV2hlbiBhbiBvbGQgRUdMIGNvbnRleHQgaXMgZGVzdHJveWVkLCBpdHMgYXNz
b2NpYXRlZCBPcGVuR0wgdGV4dHVyZXMNCj4gPiBhbmQgZnJhbWVidWZmZXIgcmVzb3VyY2UgSURz
IGFyZSBhbHJlYWR5IGltcGxpY2l0bHkgZnJlZWQgYnkgdGhlDQo+ID4gZHJpdmVyLiBIb3dldmVy
LCB0aGUgY2FjaGVkIElEcyBhbmQgZ2VvbWV0cnkgYXR0cmlidXRlcyBzdG9yZWQgd2l0aGluDQo+
ID4gdGhlIGVnbF9mYiBzdHJ1Y3R1cmVzIHJlbWFpbiBzdGFsZSBhbmQgaW52YWxpZCBmb3IgdGhl
IG5ldyBjb250ZXh0Lg0KPiA+DQo+ID4gQ2FsbCBlZ2xfZmJfZGVzdHJveSgpIG9uIHRoZSBndWVz
dCwgY3Vyc29yLCBhbmQgd2luZG93IGZyYW1lYnVmZmVycyBpbg0KPiA+IGdkX2VnbF9yZWZyZXNo
KCkgdG8gc2FmZWx5IGNsZWFyIHRoZXNlIHN0YWxlIGZpZWxkcyBiYWNrIHRvIHplcm8NCj4gPiBi
ZWZvcmUgdGhleSBhcmUgcmUtaW5pdGlhbGl6ZWQgdW5kZXIgdGhlIG5ldyBjdXJyZW50IGNvbnRl
eHQuDQo+ID4NCj4gPiBDYzogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJl
ZGhhdC5jb20+DQo+ID4gQ2M6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4gPiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0K
PiA+IC0tLQ0KPiA+ICB1aS9ndGstZWdsLmMgfCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdWkvZ3RrLWVnbC5jIGIv
dWkvZ3RrLWVnbC5jIGluZGV4IDdjNWM5YjI0MjguLmZkMTRiMzkxZWQNCj4gPiAxMDA2NDQNCj4g
PiAtLS0gYS91aS9ndGstZWdsLmMNCj4gPiArKysgYi91aS9ndGstZWdsLmMNCj4gPiBAQCAtMTYz
LDYgKzE2MywxMiBAQCB2b2lkIGdkX2VnbF9yZWZyZXNoKERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAq
ZGNsKQ0KPiA+ICAgICAgICAgICAgICBzdXJmYWNlX2dsX2NyZWF0ZV90ZXh0dXJlKHZjLT5nZngu
Z2xzLCB2Yy0+Z2Z4LmRzKTsNCj4gPiAgICAgICAgICB9DQo+ID4gICNpZmRlZiBDT05GSUdfR0JN
DQo+ID4gKw0KPiA+ICsgICAgICAgIC8qIHJlc2V0dGluZyBvbGQgaWRzIHRvIDAgZm9yIG5ldyBl
Z2wgY29udGV4dCAqLw0KPiA+ICsgICAgICAgIGVnbF9mYl9kZXN0cm95KCZ2Yy0+Z2Z4Lmd1ZXN0
X2ZiKTsNCj4gPiArICAgICAgICBlZ2xfZmJfZGVzdHJveSgmdmMtPmdmeC5jdXJzb3JfZmIpOw0K
PiA+ICsgICAgICAgIGVnbF9mYl9kZXN0cm95KCZ2Yy0+Z2Z4Lndpbl9mYik7DQo+ID4gKw0KPiAN
Cj4gSG1tLi4gSXQgbG9va3MgbGlrZSB0aGUgd2hvbGUgYmxvY2sgaXMgZmxhd2VkLi4gQWxsIHRo
ZSBkZXN0cnVjdGlvbiBzaG91bGQgYmUNCj4gZG9uZSBiZWZvcmUgdGhlIG5ldyBjb250ZXh0IGlz
IGNyZWF0ZWQgaW4gZ2RfZWdsX2luaXQoKS4NCg0KWWVhaCB0aGUgYmVzdCB0aGluZyBpcyB0byBk
ZXN0cm95IGFuZCByZXNldCBhbGwgZWdsL2dsIHJlZmVyZW5jZXMgYmVmb3JlIGRlc3Ryb3lpbmcN
CkVHTCBDb250ZXh0LiBUaGVuIHdlIHdpbGwgaW50cm9kdWNlIGEgbmV3IGZ1bmN0aW9uIHRoYXQg
Y2xlYW5zIHVwIGFuZCBjYWxsIGl0DQpmcm9tIGd0ay5jIHdoZXJlIGVnbERlc3Ryb3lDb250ZXh0
IGFyZSBjYWxsZWQuIFdlIGNhbiBnbyB3aXRoIHRoaXMgcm91dGUuDQoNCiBPciB3YXMgZ2RfZWds
X2luaXQoKQ0KPiBpbnRlbmRlZCB0byBiZSBjYWxsZWQgb25seSBvbmNlPyBUYmgsIHRoaXMgaXMg
WDExIHN0dWZmIEkgdGhpbmsgd2Ugc2hvdWxkIGdldCByaWQNCj4gb2YuLg0KDQpnZF9lZ2xfaW5p
dCBpcyBkZXNpZ25lZCB0byBiZSBjYWxsZWQgYWZ0ZXIgd2hlbmV2ZXIgZ3RrIHdpbmRvdyBpcyBj
bG9zZWQgb3IgY3JlYXRlZA0KKHdoZW4gY29udGV4dCBpcyBkZXN0cm95ZWQuLikgDQoNCj4gDQo+
IA0KPiANCj4gDQo+IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdQ0K

