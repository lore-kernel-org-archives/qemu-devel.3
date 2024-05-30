Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB40C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCeqG-0006yO-MI; Thu, 30 May 2024 08:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqD-0006xJ-83
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:09 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeq8-00060L-MY
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717071905; x=1748607905;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=WLAejmNexOYMWdJQoLHsWEnPJXI4g56V43scPYPOj6E=;
 b=fjlW/29PFflcede8pJKMRPRQcvePa/AZBuvoHnWSoUoTj5g0OsVRmuIM
 jlx2t/BpnxEukGjHvdAxBA5fjUnEUI7pu9/1C2XSdUlrqTXiL4Kt7Cr2f
 gFBmevHCJiuDFzBQKtqaoRQoezBYCXSs4bx4ECEi8f6v8yOVEXznzDpnn
 qvECzO6bHclcLZBBXyXSlfTB0nRdc0VyW9z8E8PvwCdb4ur9mDvmKES3M
 EiTEvA11/hn2KEGkGqKCCo+uzb/dA74TriwJq0f9qyYYKocYh8/TWw+qd
 uHw1RAFIBAjbazu7h+izDN4saobmyRuRj1tDGWNGm/7Fga3d2lzAbrpNT A==;
X-IronPort-AV: E=Sophos;i="6.08,201,1712613600"; d="scan'208";a="13576847"
X-MGA-submission: =?us-ascii?q?MDG6jPA2z/fHIGw5XRcsUoKjZ+1SptpVvxIwKm?=
 =?us-ascii?q?3+tDabB6/ooLWQT3YqFrILUTcNupiRYzDp7/gm291bRvp136BiWDJomB?=
 =?us-ascii?q?gnWOvxfDTb3Af3sBCZ4GFlocG4Xo+4Mzi+nJuJvNzee4S9WRbYWrZ86J?=
 =?us-ascii?q?t+1p3ZjRlKbCoGprwwKr5aIw=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 14:25:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcgtkSN758MMddZ8yKGbvibKQsPT3o5/zpSjP/KBWVIPjTY2qw3+r+Hqd6MkHGnHv7LdwyIdVtJNpvhCrCyciB4iHWZ0hGw4VDkbKRnwaYzZCsN/Gjaui1lLXCci5I+jzo2FJChJ2ISlVo4FASNOPdi2eUg4Am10jpI3JT6/f3ZHBmX3Gq0IWZMkKmAQCS6+KcKeV+o7OIG3X6K+IOKbV39/SgRXVTMno0hOkrqfb0+u1IoqRVV9OTjaSHeJjuHjCEKGPJX/qHWXidInsng9PHQaFhEOgAuyi7KpJ/KCVaXP5R6NkCK3IHREMz3bDxYAEbfj8Zj+qqQILO6fRKShhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLAejmNexOYMWdJQoLHsWEnPJXI4g56V43scPYPOj6E=;
 b=XPrtNedTNwNcWKP2G9g7weTXLVeQXd2jRAggUzYB7A4hd8a/cn5t9lWkcH2QNHksXHI9yL1NQiwE7szeUgS5hnHal8ULhlOYoTbZqIBBNdFAE4glSaqVPb0aR4uLbLDvUEoEH/1GrGZ8JzfW8YKcXQW+2YRjhWH8Qnvz6j05+hTVU5iQ2L/FKADDDRbZHrT1+xwfG6fzIdH69fOEmbMgQsHKuVke3YC3hscuqtxXvmu96EJOHA6tiXZ/1ANnQ1nQa0kQErDbkhu4Ukpy8CmJrsV2KwHi3kZATWrQmv8aI1mrJTbX7j4s0eblGeudX7OrisOHc0TnfY8EtPKuiv87mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8069.eurprd07.prod.outlook.com (2603:10a6:20b:358::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 12:24:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 12:24:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 0/8] PRI support for VT-d
Thread-Topic: [PATCH v1 0/8] PRI support for VT-d
Thread-Index: AQHasoxiO6+dgN7t50iro7G2HPLUFg==
Date: Thu, 30 May 2024 12:24:58 +0000
Message-ID: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8069:EE_
x-ms-office365-filtering-correlation-id: d41d19ce-2cab-4249-8a22-08dc80a3853e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UUNLRzJpUk1wVUlCNmgyRjJ0cmx4Zi9lQ3NoR0dONFJNbnlRYUlYREszTVdU?=
 =?utf-8?B?TjBMTnp1NjVVdE43VHZ5UG1zUEJvTE4xcWdIckZMZGRzNFczYlR5NVMxSjdF?=
 =?utf-8?B?Q0FwWW9iZWIwdHVFMi9OcGsza3hjZTFEZHhmN1hYMHJVd2xkcmtzaGlTYXUw?=
 =?utf-8?B?THp2MWZKNXJSNTczN09qV2xmNVE4TjhTOG54V2NXODhiTTBoTDNNQnZNWDNQ?=
 =?utf-8?B?WGt2TzRmTkpEdnRsdWVteDhEQ2laYndyQ1pvU2JnZjRkYlorQnQyM3hRd3hI?=
 =?utf-8?B?YmhXT09BNEZXWnJoM0ltNzNWTU8zamdPcUx1M3hnb0YrQ3Y3MVFCOVZaQlpR?=
 =?utf-8?B?UFhuei9mbXozNkZ1bCtQVjJvTks1U3pDb01hM2R5dmJNTW5GdjdLNDJaTjQ1?=
 =?utf-8?B?NEw2djI2a0NsWm5VRi9JSlZCeUppeWNZelBwdnJjR210WE85V1BGMk5NWDFM?=
 =?utf-8?B?Smt6Z1RZdEZDTnVuWEM3MkVyclZjbWwvSDVHa3A3dmxmakUzbjV5YkhnNGMy?=
 =?utf-8?B?OGdHakVqTGZPWEpRWkUrNTZ3NFQ4TkpWSkU4THlVNTR6bFhFRFZBK0NZeTQw?=
 =?utf-8?B?TjVsKzhpOGRRbVByaEErNS9zRHlVWDdMKy9VSFMrZ1FnWWZjYzE5RGRJUFZY?=
 =?utf-8?B?aW5LdndlT3E5NUFmVTB4WXhaOHJLMUt0YkJXNUErT1VSWGMxZ1NuM0JhL3pN?=
 =?utf-8?B?OUkrSzJSYWVmMFBnbHR6VHdFeUR4TzFwSFp5cytlZU8ySUxmclJkbUhFN1R1?=
 =?utf-8?B?cHRsZlAvNTdpV3pSWGlkVjZWU3RYZlA1Y3ZrWHFhOWp4RDJFRXA0U3VQdmc2?=
 =?utf-8?B?U3pnL0xVOENRZkp6ZWFzNlRuYTI4NjlNZXR4VzMxbUN3ZThiRTNoSmF4YUtj?=
 =?utf-8?B?WHBQVjRhOFJRQi9qTk1aRnhVWG1Ja00ranZVN1NaMjNXUmFsekQ2RmczbW95?=
 =?utf-8?B?dlZGMnJ0a1E3TTRwdEtoemxvSG91RlNHMjVWNlZ6Wjhuc0V3RERmVEhpNVFx?=
 =?utf-8?B?SGlBYXo4ZnFkNWtkc2RBS1Rmd280MnBHMjFvcXhmMytaNnNzWTdrR1orQXdS?=
 =?utf-8?B?UVJwMlk0NzV1K04xVWM3dHV2VGlTcEl5RWpyUkFqZGErdUgwWHZkbFJBZFZq?=
 =?utf-8?B?MUxjLytIK0lNdEpHcWZVLzlSVEVHbTZabko2MzBubWxTMWZUMjFLeG9KL3FD?=
 =?utf-8?B?Mk11d0cwSFVoZTJkbWVzZlVseTMzOFVJZU9UakhMTExZbUdOdnYxZmV6RC91?=
 =?utf-8?B?VldmNEMvY2JJMm1VdGhnZEo3VjJKUHduMGVzVzVlUWorRkhiOXU3VmxKS3Ru?=
 =?utf-8?B?YmwvOElOWFlXeWk0RHZGSkxPY1I3SjM3ZnprekZiS3dFaENvaXN5eTZsajly?=
 =?utf-8?B?K2NxTFN6dDlGelQ1QTdGL0p3dVcySGkrMEZNZTZtRkJOQTloZzNsVkg3MWFD?=
 =?utf-8?B?UjIzUmx6QVM1V1N4NXdFVHlscjQzZXRtaVNNdnFrY0pwRDlvNm0wRHpBc1Vr?=
 =?utf-8?B?Z29ISk9oVUlyN1hwSlpFZUlYN0l2R29EemsrQXJmL1EwbCtkNTNPS1Y4UCtZ?=
 =?utf-8?B?VVh2Q3hFR0EzREtlSGJiZC9hUFdvNkd5TWRwb0NrbDRleVVKdGxwVElrTTV4?=
 =?utf-8?B?Ti80c2M0M2FzRHpMbEpIUXY3Y1NTMUJwM2pwQ05ydWJwdUNmMUQ2WHVjdlhq?=
 =?utf-8?B?ei9nNFVjc0U0bE10NXp2dy9UVXc3WS85bzNMRUNEejZQSDlpUWRmRUxQWHJ2?=
 =?utf-8?B?dWtJckczOWFhenRXOTNvWXFxNmUraG93Mzg5UFRKTkZ1N01qcFRXb0tMTnVy?=
 =?utf-8?B?K2oxYkhmaGgrdytjeERZZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1hKR2NoODV2ODR1ZkpWS3BoZVR0Wm9iV2UxNTVqeFNFTk1CNE9ZYkJKcktF?=
 =?utf-8?B?NzZ0cDlBZnRmaG9ncktHRTBZWGlVcFU1TU9EOXRTYzJJbnR3S3BCbUFWblVL?=
 =?utf-8?B?REhtSjNzcCtLS1I3UWxOd1NhOGpNWVoxc0VlSFlsRnIrRXhqNS95V0d5c0tQ?=
 =?utf-8?B?c3pva0tIV2NrVUFHMVRheXRYcHpVaFFHNW01VjZOZERFdDFESjFVVDRGcnlC?=
 =?utf-8?B?STA3dHlxNW1yUDJ4MTNuWnhsU08xZjg3YUo0emJFUlNvWGZqUmdhZE1JRkpI?=
 =?utf-8?B?S24wL0VseGVOdys2elpUV1RTWEdGNS80RGg1bEN2Q3AvYUp5RFhMTGFJMHRK?=
 =?utf-8?B?dUxvRElMdSt4aUNLRXZhTHVQNVVlMUZYQktmRy9kUFZCV0U3MU5LelZmZ2dO?=
 =?utf-8?B?clZrZTJvVVdQSWpyTUswc0x1VHpQNnlrbmttN0FCaFRtdjhZQ0pnaTJPcmxu?=
 =?utf-8?B?cnV0TDUzTUpjbUVNVmpDZ2NXMktVR1VuNjgwelRSTFFPTjVVdFJpZnZNd0dm?=
 =?utf-8?B?TWJ0amlsMWM0bWxxS25ZM2JYMGNZcVoyeUZ2YWluVWtkZXl5OXdNQ1NPcksr?=
 =?utf-8?B?MnUraHJvVmpUYWZjS2Y1amgwYmt1QzVNUDl0Y1dZc2dHKzl5cXlqQ3Fack85?=
 =?utf-8?B?aEdBYThkZGJNUzZwOHh1ZUlFWE81ODUwbkNJaWF0bXQxT1ZQWDd5b1doT084?=
 =?utf-8?B?bzBKK2JCYW9PQnhtWjhKMXZNNW1rOHBwemgwVzRWMTh3NVV4YllFa0hjejZD?=
 =?utf-8?B?M0VpVUk5VDZER2xhUXcyVllzT3E2Nm9Yc0d6U0hDaGxheTVkSUE5cTJTL2RC?=
 =?utf-8?B?MXAzZ1YvSStFM1BWcFdUL2FuMEFybUhKSWhTcThRUHoyMFRYVFlmaG8zQjJB?=
 =?utf-8?B?NWR4RkVxaW1DYXFUZWRkY0lNeEd1M3NLUVpyWmNZUjA3Q1ZveFdYQVA4VFgw?=
 =?utf-8?B?dnpRdVJOc20yalkwWGZEak1JbjhyNFZGZWhDTlVsdXhUZGN5OXVUQTVyWU5V?=
 =?utf-8?B?aG5qRGRza2V0NTFxbnArdXBFTnkySzg2V2pWMzVPS2ZBYVhXNEwyOW1MUW1y?=
 =?utf-8?B?NG0wYjBxNmFiOFhlUnk4ZjZuanBncnlaRElZYk5SRmxiNjFTMVZEVGlUZkFN?=
 =?utf-8?B?VTNia0drUHArQmx3dzZ0dGdrTFJtWTE0bXVHa2llNk1hNVFpQUVGRkxNTTBm?=
 =?utf-8?B?YXIxbVBhNkUrcFZBbE9qWlNWMUg2ZGlLRjVsSTRkeG90TXVTdEZsL2QzR0Fz?=
 =?utf-8?B?VDRpOUJQanZJNWV3eE1wMVFGcFMvYzN2Yi9USGRTaXBHcytMVXBwd1hMelhh?=
 =?utf-8?B?VXJMUWNTK2tyby9DR0ozL0M4bXZVYUdtSUZnTlpubEV0UlpqMVJqNXRXVE5q?=
 =?utf-8?B?T1kyR3d4OEdHUk9nWkZUY3NKcFZ2OUFQSG5TZ1FYODRMemJRcEJ6SUs2Q29T?=
 =?utf-8?B?emlwWEFpcnYxMDhoaGxoRWpSeTdDakthbjdPM0twRFk1MDg5eWRYMTVPV1FT?=
 =?utf-8?B?SWFrSkJtS0VpRGIxb3RicXdkZDVxaVZmQktWZ2dxYzJKV1dwSCtSNW5QSlRU?=
 =?utf-8?B?RStSWkZyelpkUisyZ1F1LzlBM00zdUd3eU9PYXg4dUZLQSsrMGZ6WWladFhF?=
 =?utf-8?B?ZzNVTUtBcDlCME05ZkJXTkhYeEV4TWdML3NWNWVHSG9FZlpNNE9ycG8xTTdI?=
 =?utf-8?B?UWV6bUZ0emlVS25ISEJNRmEycVNWOGtWWUhwQUM0cDBmaW1pUWFkMmNDOWs2?=
 =?utf-8?B?N3pFZWcybkZPc2pyYUFLTjQ0SG4rZGMzOVV5SThIR1pnVUpBMVRLM1RmY0ZQ?=
 =?utf-8?B?NlJQdWFHOG16TEZqbE5YbXM4WnN3bzFZZDBtNWxNTFNWVndnc0JXL3M1Q0xG?=
 =?utf-8?B?b08wdXhvak5lQnh3VmwrV1RWMmhvYjRSelRWb0oyTVB3WmhvdzlOR3VSOEs1?=
 =?utf-8?B?dUJEaHkrbEgrSFM1WjREdW5Cc3FINml5ZVkrQ0I3TFRmODg4MXFYTk9vTkFw?=
 =?utf-8?B?MEZYVjZEWWk4RHBYZS9BaFVIaXhQeHkwTFJoam8yTG9ER1NWNk1jME5BaTlW?=
 =?utf-8?B?YXdydWtzSjJuaThyTHJXYWJIdGlnakhiRVpidkNlZXVKU3RYRngvWWRBMUtF?=
 =?utf-8?B?ZWh3QStneFA4NitVNWJ6SGQ2RGk2d1ZjTk90Rm5xUFlobW9OTTJsWGJNcGNz?=
 =?utf-8?Q?2K015ycludvZUPDXHMiEz2w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <055F9B6B1CAFB346B3E96C74191F1052@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41d19ce-2cab-4249-8a22-08dc80a3853e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 12:24:58.2961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKa54u4iD1gwyXyfRP0dM8jAiuqKYAn6CbUNqUFtTWW00050fJC1NBY9NYSHgheNesgviYBe4JK2dUBiawv0fzASXARJRBtSoj6St+doSw/2ZMb9CIm2KhGyaMBVVAWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8069
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

VGhpcyBzZXJpZXMgYmVsb25ncyB0byBhIGxpc3Qgb2Ygc2VyaWVzIHRoYXQgYWRkIFNWTSBzdXBw
b3J0IGZvciBWVC1kLg0KDQpIZXJlIHdlIGZvY3VzIG9uIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBQ
Ukkgc3VwcG9ydCBpbiB0aGUgSU9NTVUgYW5kIG9uIGEgUENJLWxldmVsDQpBUEkgZm9yIFBSSSB0
byBiZSB1c2VkIGJ5IHZpcnR1YWwgZGV2aWNlcy4NCg0KVGhpcyB3b3JrIGlzIGJhc2VkIG9uIHRo
ZSBWVC1kIHNwZWNpZmljYXRpb24gdmVyc2lvbiA0LjEgKE1hcmNoIDIwMjMpLg0KSGVyZSBpcyBh
IGxpbmsgdG8gYSBHaXRIdWIgcmVwb3NpdG9yeSB3aGVyZSB5b3UgY2FuIGZpbmQgdGhlIGZvbGxv
d2luZyBlbGVtZW50cyA6DQogICAgLSBRZW11IHdpdGggYWxsIHRoZSBwYXRjaGVzIGZvciBTVk0N
CiAgICAgICAgLSBBVFMNCiAgICAgICAgLSBQUkkNCiAgICAgICAgLSBEZXZpY2UgSU9UTEIgaW52
YWxpZGF0aW9ucw0KICAgICAgICAtIFJlcXVlc3RzIHdpdGggYWxyZWFkeSB0cmFuc2xhdGVkIGFk
ZHJlc3Nlcw0KICAgIC0gQSBkZW1vIGRldmljZQ0KICAgIC0gQSBzaW1wbGUgZHJpdmVyIGZvciB0
aGUgZGVtbyBkZXZpY2UNCiAgICAtIEEgdXNlcnNwYWNlIHByb2dyYW0gKGZvciB0ZXN0aW5nIGFu
ZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0KDQpodHRwczovL2dpdGh1Yi5jb20vQnVsbFNlcXVh
bmEvUWVtdS1pbi1ndWVzdC1TVk0tZGVtbw0KDQpDbMOpbWVudCBNYXRoaWV1LS1EcmlmICg4KToN
CiAgcGNpZTogYWRkIGEgaGVscGVyIHRvIGRlY2xhcmUgdGhlIFBSSSBjYXBhYmlsaXR5IGZvciBh
IHBjaWUgZGV2aWNlDQogIHBjaWU6IGhlbHBlciBmdW5jdGlvbnMgdG8gY2hlY2sgdG8gY2hlY2sg
aWYgUFJJIGlzIGVuYWJsZWQNCiAgcGNpZTogYWRkIGEgd2F5IHRvIGdldCB0aGUgb3V0c3RhbmRp
bmcgcGFnZSByZXF1ZXN0IGFsbG9jYXRpb24gKHByaSkNCiAgICBmcm9tIHRoZSBjb25maWcgc3Bh
Y2UuDQogIHBjaTogZGVjbGFyZSBzdHJ1Y3R1cmVzIGFuZCBJT01NVSBvcGVyYXRpb24gZm9yIFBS
SQ0KICBwY2k6IGFkZCBhIFBDSS1sZXZlbCBBUEkgZm9yIFBSSQ0KICBpbnRlbF9pb21tdTogZGVj
bGFyZSBQUkkgY29uc3RhbnRzIGFuZCBzdHJ1Y3R1cmVzDQogIGludGVsX2lvbW11OiBkZWNsYXJl
IHJlZ2lzdGVycyBmb3IgUFJJDQogIGludGVsX2lvbW11OiBhZGQgUFJJIG9wZXJhdGlvbnMgc3Vw
cG9ydA0KDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMzAyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8
ICA1NCArKysrKy0NCiBody9wY2kvcGNpLmMgICAgICAgICAgICAgICAgICAgfCAgMzcgKysrKw0K
IGh3L3BjaS9wY2llLmMgICAgICAgICAgICAgICAgICB8ICA0MiArKysrKw0KIGluY2x1ZGUvZXhl
Yy9tZW1vcnkuaCAgICAgICAgICB8ICA2NSArKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmgg
ICAgICAgICAgIHwgIDQ1ICsrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpX2J1cy5oICAgICAgIHwg
ICAxICsNCiBpbmNsdWRlL2h3L3BjaS9wY2llLmggICAgICAgICAgfCAgIDcgKy0NCiBpbmNsdWRl
L2h3L3BjaS9wY2llX3JlZ3MuaCAgICAgfCAgIDQgKw0KIHN5c3RlbS9tZW1vcnkuYyAgICAgICAg
ICAgICAgICB8ICA0OSArKysrKysNCiAxMCBmaWxlcyBjaGFuZ2VkLCA2MDQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjQ1LjENCg==

