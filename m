Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F21C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlw0w-0006Bu-WF; Mon, 20 Jul 2026 17:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65431f960=graf@amazon.de>)
 id 1wlw0v-0006BY-79; Mon, 20 Jul 2026 17:59:05 -0400
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([3.75.33.185])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65431f960=graf@amazon.de>)
 id 1wlw0t-00019f-F5; Mon, 20 Jul 2026 17:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
 t=1784584743; x=1816120743;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VI8/iAJTcXzbL3OMGa8CV/mCl/KuJrZPoVCu4hHNDQo=;
 b=Sfj3oM+GN83xgVWGd5fqtgT58Jkjb09i+ecs9KyDN411rcsP7JCnwKD0
 b7eSaPBl/O/NIwxZexur9oxXdHcXFxf2NKCImbMJT1E3mxkhr9n5TLRxL
 NbEOwchlOfXkt36h2DGmgctUiUmzuGZQqRr/FeZNnKF919XR2ClJlMz0b
 M3nFdZDDKkLhy21vE/iggsGHo2AJOKb1EOHz98lGHaepHgrsIrIWMfdLN
 qSjyIsqYsoLLdjsuDHW/qdeYrjh8gHGc/aDRUIBFu+Fbj0CMT/TB+5EDk
 CDhtPSQSAHRbso7bJR+DuU7sgQ8dTsXAgZyTm8wasUIoN3ptWNHz8ifcQ g==;
X-CSE-ConnectionGUID: gdE5FXonRmm8BpI1WmciJg==
X-CSE-MsgGUID: mNquJlC5QrWnzJXytJt1QA==
X-IronPort-AV: E=Sophos;i="6.25,175,1779148800"; d="scan'208";a="16716930"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
 by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 21:58:56 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.233:17841]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.4.185:2525]
 with esmtp (Farcaster)
 id 970a9ea7-95ac-4f68-81f0-b58ec900e469; Mon, 20 Jul 2026 21:58:56 +0000 (UTC)
X-Farcaster-Flow-ID: 970a9ea7-95ac-4f68-81f0-b58ec900e469
Received: from EX19EXOEUC002.ant.amazon.com (10.252.51.145) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 20 Jul 2026 21:58:56 +0000
Received: from FR6P281CU001.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUC002.ant.amazon.com (10.252.51.145) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Mon, 20 Jul 2026 21:58:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=updVoUHDPurRcQQDAhGJ1kxceU3BZUI5vvWldNXv48YwMZlbqQV9htJM9GESyfO23nvJYGcwStIyUninGDiwGYVo6iSZtkh9a0wG0LSylP2vSSW/sb1KuuSso9W4YxFabvtkwaWaYfBBRBJkMSUeYaM4aoUYiakR5KUTsMamUbnNCtUDIKmIfYMJIncYUWqVzrWCRbZYKrVNzv3AhT++WYbaicltASecfExqoG+tc5NyVyfsJh2ERbBvIv4fg/Zt0kyPxePWe0ksxJVWaKkZ+rY4Fq1/I6H6nMcbz0LCYXco4LzWh1wxt5p5iQvd/KjENuGSsvVhks7WAPywedNDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI8/iAJTcXzbL3OMGa8CV/mCl/KuJrZPoVCu4hHNDQo=;
 b=REngmfflRKfx+kpxRQytRKGxKxUewOTe/Cc4L4SY21HSXsS2yf7WW12hj8NLJUOHABzhHBY4ry7GZd5ueAYv0Qkub5e+KSbOMcwhB4r3W7ypLUI0TVEdH8fIg7SMG0wrDHDZE+KjcK2gxSlGSG96+kOF56Xgx09xNEmEJIhuBkkM9LMx8RBfh+/Sog5dOecC3Pmx5GnlINx9yPlUMvUMYaSmdfqiiLYAg/hcdKGZhclqJTX06xPn1+C5ZLMDzfzq0nXpdDXFbGroMh9w/styN5gMn7xey/A+jqFH8tlolqV41az4dVENcxA4LSonotozuX7lrvAIili8O3BVmLJmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e0::23)
 by BEYP281MB3911.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 21:58:52 +0000
Received: from FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ad:f028:e0a7:bd4b]) by FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ad:f028:e0a7:bd4b%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 21:58:52 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, Matthew Jackson
 <matthew@pq.io>
Subject: Re: [PATCH] hw/misc/applesmc: Fix a typo setting MSSD key
Thread-Topic: [PATCH] hw/misc/applesmc: Fix a typo setting MSSD key
Thread-Index: AQHdGJLzIHRdR5gSik2rLB14ancSzQ==
Date: Mon, 20 Jul 2026 21:58:52 +0000
Message-ID: <712f880a-51d3-435b-8122-8a9b781fd838@amazon.com>
References: <20260720115336.75063-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260720115336.75063-1-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRSP281MB6250:EE_|BEYP281MB3911:EE_
x-ms-office365-filtering-correlation-id: 93182c52-a346-477d-a458-08dee6aa1601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: TjIA/V2T/39R8NILKbBpYeI9jYUcyjpuCqZIC2iINGmnBcIWSehDJAMpyZwghE7Od7fKNFqLTscxMMEzAMTmilq7QlFBqOnI1BPOTSzY6HoJzDBxtUhWgBXPP7Ti9ZqZ6a+jsICBk4F4B3YRHe5qBAuCEVoEA14UOOQqTXfEQaAqoCMnBgW6TBBmP/jP8bgOD2VJVByk6YCOxHe4G0k0HZJI2/hClMJAwIGvj+errR9NdwUO6Fdc/huNJ0CuSCMyy85Q+zNe6cwUfTsLD9x9K9qbn6YoMSkY6ESEVgi1h68096bzTNRwhlkUoq7tBMdlZpbMjfhikD8y+e0g2MwPDoyhE02ihAB4+2Sf4PR89pGf3gc5hsrxOAyvjXzKsW9w4fnn9ODdh7u38EV/OPmqND4rVlIMHeKiP3+DuwGBb2cy1XBnnOWb0mO+qG21zrSEqhjO6+bMn944Tp9adrok2Yt4F36k27VHrG4zE2P93eHONRxc+1br+Xxbtl1BpzdPq9RO8jW0BzoyBamwhHDdDouBtxTIxA+YeB/QHr04zEMRLmQZYWdO6aJRO1TTQV5s40qJPGV1kibRe3W4AgIC5kMlcoGhl55kHiWXIQjTqDJPlAeC4Yg1Xa4mgENlXBRCCpZR0BEAN3CNHfFR7hoCGd8Z+5to3ZNuTLd5k8QQPMdxmYN1q6smFhacmPwR0rAYh6L26Sh7Snw/Afqp/CZMoKmDYTtQgT8o4wsFVJo+fbI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWFpVjlSbzdzUGw3S3lEV2FsM3NXb242eVZlUEhrakZoanQ4eXd0VjlKS0lh?=
 =?utf-8?B?aFI4NGNuTG1heDN0NEY1VG40TzRGVXdpK01jeFJJWmp3RW5HL2JaWVJSM1NH?=
 =?utf-8?B?MnY5SUJmbGFrZVlJVERtL0g3c1VrQWtMOWhBNlVjTithYUN4SVExTndkTjJD?=
 =?utf-8?B?OUZBVVo2Vm12elpVcDlsRUdTMm9sTGxRWVVMd1dOOW9wRXNRZThIamlQNTVN?=
 =?utf-8?B?UDJQV0VTaEVmdHVlaDM4TWtHd2pjaTJSOXJyR2I2Ui9aTkZZWVlYeWZaT1ZY?=
 =?utf-8?B?M05vS1ZrbU9rTFlMbUhRSkcrMGZrNURDL2srVGFMYmpBV1Z4UmhKSnUrWXo4?=
 =?utf-8?B?b0xBUWpnVkRVeFBCV1d6dnVtczZtOHdRUTVQWWhyZ0h5UEZNcHJ5N0hDZzhR?=
 =?utf-8?B?K2JsRjZPT3AyMFVYRkVNaFl4bTZWV1d3VEZvd3RIcnNmamN5VFZLc1lNTDZE?=
 =?utf-8?B?NHM5R29RbUR5TDRiUGg1NU1SRGV1dmhaTGtWbnhCbHliUDdIS1l0UWN6VzJx?=
 =?utf-8?B?MktwdXZGS3MrT0tjTEk0aDU4WTlpU2FnNXgvMGlYbmhzSDYrZ3ZVTkx6dmMy?=
 =?utf-8?B?TXZOS1NYTUMwQkhhN1h3ZXhqc2xQNlVBWnZ4SkxCcWRnZXZiNVRFeU1MR0wv?=
 =?utf-8?B?d2NtOWhiUTZDckVMZ1BtKzBIWmZwcWZYSVZhMXBUN0g4TkQ5WS8xemkrNHd5?=
 =?utf-8?B?SVpHcEZrbmt2bnRrcXFyTEYrbzRGUzVWcDU5TDV1UlRidk5nRUlqR1hnWm40?=
 =?utf-8?B?YjUrTjBOMkdlWmluMlBSSk4zbE5EMjVJMVNSOS90QmJ4TEVhM0ErQ0kyNUxX?=
 =?utf-8?B?ckxtTGcxVElFNWZYQU42YitYVHpRSVFYMCtIWE4xZFZYeTcvUFlEYmxPSTBU?=
 =?utf-8?B?eC9seFBRL2oxVVR4T2NXbXJSZUY1c1E4RVVmaXVJYXZEU0l2Q1NrRHpOcFRm?=
 =?utf-8?B?ZzR2by9YVUZTSUZHK2RWNTVnd09Ra3ZuN21wbUUrVHlreXFIWFkxQlBwNmZz?=
 =?utf-8?B?QURHY1NoVU9XMGJnOTNHVnhzaGQ5NFJnSHhFckZaVm9wWnQwMEVwOHYwd0JU?=
 =?utf-8?B?SHk1S0Nld2xQalBybEF4Rytod24xWUM4WTZiMk5wS2w0UEgrVDNkais4UFpl?=
 =?utf-8?B?L3ZOcGVHL2F1cUY4VmF5cTM1d1VBTjUrTVZTNG55M1UzYngzWjI3cmcwbG4v?=
 =?utf-8?B?alpBWkZlTUwxRm5ZV1hTMkdPR3pEMU5ZdndWand0Z0VLR3R5eWlqTWdnNytN?=
 =?utf-8?B?eGZnNklYazRqdUp1ZjZZMnZVeW4zczZKNWhVb3gyc1dHY2ZMODArV09HWGFk?=
 =?utf-8?B?N1RMbUhialN1NGdLTy9TblhzT2ZBbnNnZVErNi9mZ2NsaUFsbWt1emcvNndV?=
 =?utf-8?B?WDhoU2d6TjRCTG02OTQzWlhhcUl3aCtvSDgvSUdsWFJKS0FXVE1xVlRsS2lT?=
 =?utf-8?B?NE5vdFR5cGhFdW5JeEVDU3RuQm0zS1o4WitpQTZaL0l3d0JMNUF2eUhPMFA4?=
 =?utf-8?B?LzZWM2l6QlBSWnp1UkFhd0NKVHZOaWV1WWxZSGFacWVDSVAxZ05PeGZISVFX?=
 =?utf-8?B?Q01peWx4dGxSck1tcjlIeU9mZG9oYldPZFN2YWFzYnhScm5FTXlvTVB1WE1H?=
 =?utf-8?B?ek5wcDhrUEFEMjIremJsd0w5SjBNdFl3cDRJNzJGV3NkSHQyb3lTc0Nid3J2?=
 =?utf-8?B?Z0I5Q0pjdnkrb0FheHlRS0JJVXE2clZVdTYySG1YZDVyYVNhN0c3QVE5Mnpm?=
 =?utf-8?B?RnBJa1RWTnZLcnhpTHNuRlVlV0R4RGNQVWFNemRsN2JYZ1lQdEpGL2FiMDBq?=
 =?utf-8?B?TDlXSEhkWkppbWhDZ1BkbDI5UTFwRUdsZkVxQkZ6Z3RjNHd5Rk9kc1VYWlor?=
 =?utf-8?B?RTdxcm1HU2lYUnp2dExBWnZxbnFtRUxSRS85M1A0Rko4ZVI0ZDFOckFKMnlo?=
 =?utf-8?B?M1NhV242ejN0RUlaODQycDVZbTRMZ1RUMk1kWVNtWUtmaHduUzk3dGJFNHhM?=
 =?utf-8?B?eUVVcmxudXZaT3pscmdoNXptaW1tejRiTFJxOHU0M3hod28vREZieVJLcCsz?=
 =?utf-8?B?WTZObU0zQkw0VzlYN0p6d09PaGFWS2JGcTJYNStqeEMxdVVqVUJMamUycXpl?=
 =?utf-8?B?MHNBRldwR0hvWUJwVE9zNTdqWVBIZUF5MXk2MWVHbk9wMmpQanF6Z2kwUmh3?=
 =?utf-8?B?WTdXTWhNRExYQ3FLYnQzV3JkbGJ1Ym5qVDJRM0IzQnAwZnYvMmk4b2dxNU1k?=
 =?utf-8?B?M0x5cVJza1ZPMHpSYy9ubEFlVEhVcTVJZGhJYjV2UWNhd0JlRVVUWFFhWE9w?=
 =?utf-8?Q?PIPVq6wo6UdlPzBgpw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D9BF7C2A1907E42901202088A712E81@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: daWfwETo+1biVG1wrGAlLT3dnNSleQopZfGZ3DxvmpyCZ5pKUMYU6kqFHADZtYHpBbiVZz7zq2fYZ7merse8t/LOH0mIwW24DMs7XUOL66SqLtpM6aXwIc5QH3u9rv6se9kqJLEc47uaE/E/wqHlnYmHmp/ZDOxhX3t3U162yo07g9C7LzSMa/ScyDGoZu/TYAMTgxhBGZdm+L/yW6HmRV2Q+Y2WFkUmeK7wBH0Gs0DsXS7NvjKrUu9JgNbNnaYuJFcygF41hP4YUQDlWPF03w+H81Gq4BilEfcZYPIy5x+3xUlWtgY17evzocQLyyq6IJl2K5Y7uRpFEDVo8zcJxw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93182c52-a346-477d-a458-08dee6aa1601
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 21:58:52.1047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naEm3UE+9tsOCJ0xfT+lYRV+xV0NInwgSZH2jnjj1UWx1lkdNVy8wnnprjmKb41s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB3911
X-OriginatorOrg: amazon.de
Received-SPF: pass client-ip=3.75.33.185;
 envelope-from=prvs=65431f960=graf@amazon.de;
 helo=fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

DQpPbiAyMC4wNy4yNiAxMzo1MywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElu
IGNvbW1pdCAxZGRkYTVjZDM2NCB3ZSBtZWFudCB0byBzZXQgTVNTRD0zLCBidXQgZHVlDQo+IHRv
IGEgdHlwbyB3ZSBlbmRlZCBzZXR0aW5nIE1TU0Q9MC4gQ29udmVydCB0aGUgdHdvIG90aGVyDQo+
IE5BVEogYW5kIE1TU1Aga2V5cyB0byB1c2UgaGV4YWRlY2ltYWwgbm90YXRpb24gdG8gYXZvaWQN
Cj4gc2ltaWxhciBjb3B5L3Bhc3RlIHR5cG9zLg0KPg0KPiBDYzogcWVtdS1zdGFibGVAbm9uZ251
Lm9yZw0KPiBGaXhlczogMWRkZGE1Y2QzNjQgKCJBcHBsZVNNQyBkZXZpY2UgZW11bGF0aW9uIikN
Cj4gUmVwb3J0ZWQtYnk6IE1hdHRoZXcgSmFja3NvbiA8bWF0dGhld0BwcS5pbz4NCj4gU2lnbmVk
LW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29t
Pg0KDQoNCkZ1bm55IDopDQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgR3JhZiA8YWdyYWZAY3Nn
cmFmLmRlPg0KDQoNCkFsZXgNCg==

