Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9ACC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 03:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMfeM-0005CE-7H; Wed, 26 Jun 2024 23:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sMfeI-0005Bk-Ve
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 23:18:15 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sMfeH-0002OB-2J
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 23:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719458293; x=1750994293;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zQZ1FumqF8jy1hKrAf0cqC6u5YX/URu7Xldr1q54s/0=;
 b=oJqHES2KzBMDAuyBR+V9829gCOjMi8ccZF2X9ezSaxmVSgqvGyHseSdf
 srnW/SPw60jOKN1nIJnAwIktIM4KSwriRlI4kQLUFrqRXQ4m6fVV3omBl
 FmnbtIjUQOVnazX3QDWsVfYKXUMhpHeUEiAzwwewzOtOZfGA07x9i2t2h
 2U1lcXIjchoZpaprMHQ/BbSefSxqFlffbs0Vuvtm9fvx34AWzlAHk/Ikj
 b3F3s0apJqeDNyPHIxqeRmW3UXTE4IdA4i8bu6eIBsjeCasAz7MXGmh1G
 nWsELmPKzHG9SOG8s/yjvtF9ZbTqnBgc5AfZxxPlrtZR8PoUaYWZ2a8iZ Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="123527582"
X-IronPort-AV: E=Sophos;i="6.08,268,1712588400"; d="scan'208";a="123527582"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 12:18:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWppbOsKTvK8dluDGM6UYvnqiOUgDKwQPYcw6ypi5ifW9jRsvpwqXCeX3HPlsPvjSnsj+1asVvb3a/Zz3E17VtoCyJLYA14HNxP3c1s+i4KP5g85S0iecrR4pXnM40yOG1IqFGmQymuLZbMP6+0m0OPT3zHVVFpMInhV8yvmHCRB+9jLzbZHMwMMnj6NwCssABbD5O1hgMgNMjS5tIpX7H1vj0WMiRAsAG+s8FEJ7MiQtWiV/W65JCaJPVz7BdsPvXl0sCo39FuN+rBZWFs3Wt8JRpQ2YFMdrLTzXx9XbvGytvXCPneen7bpz+zQI8uNpaSI0dtdhCmLxoxNEh1IfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQZ1FumqF8jy1hKrAf0cqC6u5YX/URu7Xldr1q54s/0=;
 b=cT4gxmlBGPBhwUnA8J2HUpsJ27l043Y77fv6+3JWSE/SMB0X/OMVwraTdm2V4zV6xOw198Nz5p6uTVoSblCRPBRj1XysxjUj/h+N4CxbDV6TmooQ+MvNCLeViRKUiwpMEL4W3gKhhl2cC2uZaD20PoAFIZ6g/4feAtPRI1Z4CAcJLvWpQJHd01ZsCWVlf71umefyNdUnEa5hdGF1Xcs3CP/5IGUVtWd4IvZL+tX+ttQc/XerEo5f/yKOe1yQmBwJ57gUQwpW64NTDR18GJl4p7RVvO2iFZYacqfFL/aHA7olWsOxMklmR3H5SMjV/ovwzlB5k/Ynoruzrz5dvtAtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB11991.jpnprd01.prod.outlook.com (2603:1096:400:37b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 03:17:58 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 03:17:58 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Richard Henderson
 <richard.henderson@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
Subject: RE: [PATCH v2 6/7] tests/plugin/mem: add option to print memory
 accesses
Thread-Topic: [PATCH v2 6/7] tests/plugin/mem: add option to print memory
 accesses
Thread-Index: AQHayCIsi4GywkD2VES3ue7CW0mN/bHa75hA
Date: Thu, 27 Jun 2024 03:17:58 +0000
Message-ID: <OSZPR01MB6453C257EED6AFD784FFFCDB8DD72@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
 <20240626233757.375083-7-pierrick.bouvier@linaro.org>
In-Reply-To: <20240626233757.375083-7-pierrick.bouvier@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NjM3ZTI4YjctODJhMS00MTBkLTkxNjMtY2M5N2QxOWNm?=
 =?utf-8?B?M2NjO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA2LTI3VDAzOjEzOjEzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB11991:EE_
x-ms-office365-filtering-correlation-id: 3759e0f6-0996-4f7c-e386-08dc9657be9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bnlTOXVmWWllSkpqTFpacTNTOUl3RG4wM044OFV3RW5EN0U1UFB6SnRoU0ll?=
 =?utf-8?B?b0ZtS1MrZmJGNVo5bkpJTWFVYWtBK205TnFwbk9kd0V1bjJ5eWlkdGRudHJn?=
 =?utf-8?B?bkwzOFZmME1NaHZrdE9hRjUwaytZeGZmVmNuT2FlK3ZoQXJVeXlYcFJVdFVP?=
 =?utf-8?B?NmdydE1kaU5zcGRIREhlN3NXcUpwalJqczZYdnNSODgyMnplaDFjOVBReDR3?=
 =?utf-8?B?b0d6V0RMR0FUSG51SHhZVWpaYnRoOUlkajN5QTVkRklDd3BmYkcwTExIdm9L?=
 =?utf-8?B?a2Q5VExTSVYrTjlaVmhBNkczdlN2MFhGQ1BLcVJ0bkhXRmNYK0R4bmNPREdC?=
 =?utf-8?B?VFhPS2tpR3JyV2hBSUhyNEVmNUlFNzFOb2M1NHR0VVQvTVdDdkV4SWxKcWli?=
 =?utf-8?B?cnBpcysrcFJJNlJMVy8xYnc0R2ViczFXVHFLcWU1dkFnSDE4YlRNeE5EbjZm?=
 =?utf-8?B?WmFCeThKcVhIeGxxd2FUWFBBellNaWthQk5WN1BrMGtvNHhmaURCTStBTHQz?=
 =?utf-8?B?SmVlSXUyL1lMMmR6bGNSblNxWHpEbjlRdDFqWDRxSEdRQ0VsMFdEaDhLWUtq?=
 =?utf-8?B?WmFYaU5YNmRMb1RyREJPaXlHeHcvZnRoWDlXSWVlb1BpSC84VTU5TWxCNllj?=
 =?utf-8?B?aW1nNy9vblg5NHliUnFRcllpL2ZtNkNieUJlY1BhcUpWbHVBUmpkOWlybGpk?=
 =?utf-8?B?N1NRaG84bUM3VHFCSEk1KzJ5c0NkSFdFNmgrUllFNHpuVElWekZLZ0VwUTk4?=
 =?utf-8?B?dkd4NmZlNm5PU1JxWW1qZkttZk5ZWk5NQmtUVEZLeGt3Y2d3U0lMWXBYdmQ1?=
 =?utf-8?B?alBiL3M3SDVzUzVHZTJ2WmFjd1BraUdSTjYxOThTOVo2bThhRnpkM2htbEda?=
 =?utf-8?B?YnRGZXdjbkQ1L1lCMFEyOElIb1U5bjhCZlo3N3l0K0pRcmFPTStQRFEzeWx5?=
 =?utf-8?B?WnpyKzRFUWxySTdiNXFia0xhWVdXcTlQaE9TakJvT05mQkFLMlV4b2cwclZP?=
 =?utf-8?B?NEZmWmJPYVVFNEMvM3NyNG0zWVd2OWZxVkhYOThWSmNLTlprMllSQ2hRc2tF?=
 =?utf-8?B?SVZwQ3VGcno1V2ZzVFFyZVV4aW43ejhuR29vbE5EWlhPK3E5Q1N6NlQrdXRP?=
 =?utf-8?B?d1AybXB6amF6NGozU0RqL1VlZk1CSlBBa0NiVC95Q2NBa09obU91bTdEVGhp?=
 =?utf-8?B?cVd6ZElSeTgyOFd5VGs4Y3BodzBvbmJNSk84V0FTa2o2WWh6QU00bkg1U0RD?=
 =?utf-8?B?enJEU0xQa3l3ZDBoc243cTZYSERiQkNTWU1RbUVBL2kwZG8rNWVvWWpUSTlp?=
 =?utf-8?B?UTZyYkUrUDh5ZU9QRG9DOUFBbnIwZk81WDJiVDQrTVhTMllhbzZYZHhBMnp5?=
 =?utf-8?B?VVpZaHU5T2Z2RUkxWWFSOERsdlMvUnZCRTZJbEpkTGQzNXpFcFJLT2xkRXM1?=
 =?utf-8?B?ZjVJWlZuREcvZmpYWHIvNzlUYzF6TWc4ZWtDTDVWaXZhVEZpM1d2Q2hiUHcv?=
 =?utf-8?B?dFJLMzhXeUd1MnNldW5vQ2hpQW9aUEdueW1tTFBURkFyOER0SnZYT3djVjVt?=
 =?utf-8?B?ai9rK0NDUWFGNzZSSzRob1BUSkdWT29uZUJjLzBXNHBjZ0t0dFcvN2FNYjg3?=
 =?utf-8?B?Z09nYlRZd1VqMFBOQklwZi9WdTI1UndyNWVTTmJxdlVwT2R3OGZQbnpmdTRD?=
 =?utf-8?B?SHRVenFrTzRPODdtbG45cDJqSzhBenQ5bWxqdnhmZ1c3dy92UGx0NkxFcith?=
 =?utf-8?B?VHZwbDlEQVdydFhuVHJFMUpUM1ZuWHMwejdFVEhaVW0zVFdXZmpFT2wxTUdH?=
 =?utf-8?B?ZkZxUmVJYXZqdWdhS2hOdE4yTWlpNCs0Z3l2Um4vQ1krQU0wR1NnRW5ZTUZZ?=
 =?utf-8?B?Sk05TjBNT040c2hqdVFIL05NbTk5Ym5QQkI2U09UZDlQOGViempxVWJteDBU?=
 =?utf-8?Q?2MRiPSU9iWE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2ZXd1AwV0hyUHRpSFdVUkc0U1N0dHlxNXAyUngwNVNTaVppT3VqRWx0dTdI?=
 =?utf-8?B?ajhHTEczVlE4cDdpeHhJQ2daeTBGQ1hOMURLV25Fa3gyTDRsUURPbDZxUjlm?=
 =?utf-8?B?NEJ6cFFoUEw2RnF5dVpWV0V1MThpRnlrVUppVkZPUERQTmpkNXBJZGNzS0p2?=
 =?utf-8?B?ZzUzdnhwWHlhOE5RN0EvTFVMeUdVdWJuRUhIbDJZZitCWEUxQzF4M054UlM2?=
 =?utf-8?B?Qi81ZmVvcDJxSzM4WENneDh2aEtiMnlyNUk1eDBYekpQczdjUEZBSS9Ucnp0?=
 =?utf-8?B?WVQ2bU9aOE95Qkg2bzB1RFhWMklySTBNa1hBbmg1cVdTbmY5WjcvaUZkOHhh?=
 =?utf-8?B?am1jQTRQOEtJQnJoVU1oZTljVStwcE1WV3J2Y3h1U213a2t5L3BMdXJUMC9Y?=
 =?utf-8?B?RHFFSUsrM2lQTDRvNi83SlcyVXJUM285MTdQWS9QcXAxWXI2S1dSVy9sY0xQ?=
 =?utf-8?B?b09oUGREdUY1dHh6YWh2NGczNkhlUjgwa0s1RUU4bFBrV3NLQ0RpY3ZUM09Q?=
 =?utf-8?B?OUVoTk9NUEZ4NFZML0tiRGN3azlpQ0RXem5qYm9ZREF6RjU0T3BCTFhMNEZK?=
 =?utf-8?B?SGoxV3djOXJySTVRQS9EMkxhUkFxTHhvZnFMKy9TTjJ2eFdwZWxUSTYwOTZn?=
 =?utf-8?B?NGg0K256U3ZveEFvakVFaDA1amdzaElkdGlkY3dhd2JlcURxYnJ5VHZtSzhQ?=
 =?utf-8?B?SGphWGFpWkxDbWxIb3l3UjZaUEFYcUZwUk8zOVF6TmRrNEVnQ052UEY4UnF0?=
 =?utf-8?B?K1Z0cy9rRTBRQ0xaUHd1Vnc0Z01RMWtBZlFpNWw3aDdHdzN6Y1E1RUdCVHJJ?=
 =?utf-8?B?QzJwL2krcm5hcXJjUG1qSU1zWU9KaXRlVmdjZDQ5ZGpKbnlkRDVjb0ZPdHk3?=
 =?utf-8?B?Wm5HcENLNVg3M3FlMUl1ZEVFQzhnZWlnbm5XY2toQ2wxQzdpZFVlTTVUS3lR?=
 =?utf-8?B?Q0gzRGVyNTRDdDBTU2FGcllYdVVET1p0NDNQejllM3VKQVMzV1FkeDhHbHRZ?=
 =?utf-8?B?N0lPWmRQVDd5L0R6aTJhNnFFaTBkdXBQSjNhVHNIZ2lDUHY3dktnbCtTQ1pp?=
 =?utf-8?B?MHczRzhOaXVjd05vZVJTM1ZvKytWM2FhLzYzb1o5Sm1qem4rMktvUkliNXNP?=
 =?utf-8?B?aENKOGpDaHhZRW1YbllpbVkxL1BzdkFNTjJ3eUpabDM3Mnptenl4dUIyNEx0?=
 =?utf-8?B?Q2NyblBOaDFWM0xzTS9ZMWRLc1Y0ZEJYTSs5ZDcxZks4dHdBZEFsajdIUGtP?=
 =?utf-8?B?bURydkEzeGUwTGZmVytDOGsrVzd3d01lb1hObGtTK1lYR1RabG5NMjB6Nk10?=
 =?utf-8?B?b01mbTdOZllqUmlkQitYYmM1cmNCWnZPS0dmNGUzWnJTOGYxQndpU1kwUHJZ?=
 =?utf-8?B?eWJ6Y3ZOTW1kdFlLb0hmMjRDUlNQbWFTRzhqaERYeWc0eWgwYlJZUjUvcitY?=
 =?utf-8?B?emF6M3pXOHNkL1RaKzRoY1dPNUY2WER4UjZlT2tqeSs2Um0xMnBiZmVxUDUz?=
 =?utf-8?B?YnBNazlCRmxTbHZUMHY0bXhMZ2JsTmluazU5Rm5hWUk2clQ5aC91NnloS2l5?=
 =?utf-8?B?UWFJQSt4VWpFS1RuM1FsOHhSL2NRaFBHZ1Z3eFBIZDJHWHJMa3B0NURCR0JO?=
 =?utf-8?B?cnZSSFBnZTlEaU5NMkM1ZDIwTU1aelFPR25HelpoLzJKWlU3NTJtL3BmUys0?=
 =?utf-8?B?emR6OWp3d1ZsNExEbWJNeE1HK1NUVEFJTlBCdU9naS9GNE5vSklNdTloUno1?=
 =?utf-8?B?QjZ6TTd5cWxGWWJLTjNGUm5WV3d5ZUVVNzQyNndwcCtvdy9TUm8vbWlMZ1pk?=
 =?utf-8?B?NHBPalJVMmZrRzJ3dWFBaXFRVjFianRtZ0xUQXlYRzlCb3lIQTZHbk8rOHVS?=
 =?utf-8?B?S29uYkF4eUVBazhSL2N6L0YrVVNpTmk1aklzQ3dWVU5EMmpHN3B3UTlwYmlm?=
 =?utf-8?B?Yjkwa3Q3Qzl3ZFMxMkhWZ0MxMWNxYVQzWXBEZ1RKY3RWejhXVnpJdGlsYWtV?=
 =?utf-8?B?OVN3ZFU2V1ZqT3ZTUGs3YStjUExnR0lJVlZBWVQyNWpFVDNsdzFsbFluaitl?=
 =?utf-8?B?L2lwaGcyTFRvc0hkMzhlVEJxY3VSWjAxSWdraytKajlkVXZKWmtpWHBQV0lS?=
 =?utf-8?Q?3q6G8tjmxgJ0y1kjPuf7IsbK5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xU2PGgERAC6zE1rIr1O81oVcsOJvkkAoIZHygN9NnyxwwQ6w5F+/niUFgVWF9fQrjXbMPpxMcMYwVgGjdBIBRpyTgSYeFbuq07oVRYJU7F/0Ks6lbbAtT3GTjo4cc4vKdz13NRSZ4uS8E/5S5xGA9bJ50NBA2YmI4rjw89NqRosCZvnyHgWTsQ+DkkcwGQObNGHjjEZjU6BbWTbnPCCr9P3zjGu/AaWLHhoCzs+yLB0nz4ptEtjYoxnkkRE6wpNHpJpsvXDnV0//PwIOonbCZBs6bcDj2TDZDfL7Av4LYY7NNs5wkKXXlG2ZhI3tm1U1J8KE1x5W6gXiNIxLqdg98R3dShbyCxfp2tFD0jRHH0zH9XYzwYmXqxuwfXdmQTOuc6/bdzLr2ZXF6CSEFlCZQkUuJTqvRbCceaf2NcCML8JRv5s5lN2WkILBeNC2hcGCjE2DLCIQdqUatkp2LCMwrssFhoCDkQkq9n5ctMW6h7ncSDAvXdFmsiDwiGEsV1Bg+GqPq6Obxx7Z/Lq88RcJgTyPnpnAS+E5YTTThtQIbDGkln0p9NCmHXe4I6l1bEh0NutGWTDdtZD10T1BKEJH6cmHyiZ5oZxPoNhSxBBLw2u/pKPUndISIq4a39z2af2U
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3759e0f6-0996-4f7c-e386-08dc9657be9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 03:17:58.3746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdcbkXs1vI3j4fONAJvDF6zVZBM15Mlc4yC1FDaBasPfyYaFbiaFpInQxS+lYJSP5LuO+NoIdJYvvXLhec8Gpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11991
Received-SPF: pass client-ip=68.232.159.83;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa6.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGksIFBpZXJyaWNrDQoNCj4gK3N0YXRpYyB2b2lkIHByaW50X2FjY2Vzcyh1bnNpZ25lZCBpbnQg
Y3B1X2luZGV4LCBxZW11X3BsdWdpbl9tZW1pbmZvX3QNCj4gbWVtaW5mbywNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50NjRfdCB2YWRkciwgdm9pZCAqdWRhdGEpDQo+ICt7DQo+ICsg
ICAgdW5zaWduZWQgc2l6ZSA9IDggPDwgcWVtdV9wbHVnaW5fbWVtX3NpemVfc2hpZnQobWVtaW5m
byk7DQo+ICsgICAgY29uc3QgY2hhciAqdHlwZSA9IHFlbXVfcGx1Z2luX21lbV9pc19zdG9yZSht
ZW1pbmZvKSA/ICJzdG9yZSIgOiAibG9hZCI7DQo+ICsgICAgdWludDY0X3QgdXBwZXIgPSBxZW11
X3BsdWdpbl9tZW1fZ2V0X3ZhbHVlX3VwcGVyX2JpdHMobWVtaW5mbyk7DQo+ICsgICAgdWludDY0
X3QgbG93ZXIgPSBxZW11X3BsdWdpbl9tZW1fZ2V0X3ZhbHVlX2xvd2VyX2JpdHMobWVtaW5mbyk7
DQo+ICsgICAgY29uc3QgY2hhciAqc3ltID0gdWRhdGEgPyB1ZGF0YSA6ICIiOw0KPiArICAgIGdf
YXV0b3B0cihHU3RyaW5nKSBvdXQgPSBnX3N0cmluZ19uZXcoIiIpOw0KPiArICAgIGdfc3RyaW5n
X3ByaW50ZihvdXQsICJhY2Nlc3M6IDB4JS4wIlBSSXg2NCIlIlBSSXg2NCIsJWQsJXMsJXNcbiIs
DQo+ICsgICAgICAgICAgICAgICAgICAgIHVwcGVyLCBsb3dlciwgc2l6ZSwgdHlwZSwgc3ltKTsN
Cj4gKyAgICBxZW11X3BsdWdpbl9vdXRzKG91dC0+c3RyKTsNCj4gK30NCkkgdGhpbmsgaXQgbWF5
IGJlIGhlbHBmdWwgdG8gb3V0cHV0IHRoZSBHVkEgYW5kIEdQQSwgY2FuIHlvdSBhcHBlbmQgdGhl
c2UgaW5mb3JtYXRpb24/DQoNCg0KVGhhbmtzDQpYaW5ndGFvDQo=

