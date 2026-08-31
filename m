Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FF1C61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qmA-0003hB-J3; Sun, 30 Aug 2026 21:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qm3-0003fb-0h; Sun, 30 Aug 2026 21:25:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qlz-0000rW-CB; Sun, 30 Aug 2026 21:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788139519; x=1819675519;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lkb3YO7AHdayxUBeGCIkc9u7rbApwnPhOoUoR+qL/vc=;
 b=Fh3UbPT/U2B420FczG2rxc0u287XfLfLHJXxN0JJPN6oh34ZBjWsOlyb
 bTmG4aiQMYLjRlktXV5bdFDTjgYozOwRZlQ7O2FxtCPQW1Yyja/LGtCB1
 G6SunA87L/AGjqVbudj/S71VtnYqt492+i1XCEWdMODiXZCRKodugWLGY
 OonXIpwzyj0rjIdG/wTH291IBbqvnxxKB55DviKqvdSpCdTrBlW7Dg65M
 DOjPglhXPMMeryziS4pYi63pc4/4Mpz5CJMRPlo+7UrTbieHeRD2VjLoi
 OJUO8ebCr2L0sEeziun0FhKK4JvS9jgBba6kca+T6MrhvcJBrZVPmTYvr A==;
X-CSE-ConnectionGUID: 1X5cbKbVTdGGBb6knOo/fQ==
X-CSE-MsgGUID: KDTjlvzQRp28ULVejxsecg==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="154366150"
Received: from mail-southcentralusazon11011030.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.30])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:25:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoqV1QMEu4RXfLg7HSz3q9Um3SlsvNOGV2JYRoJkLCVa1ev1ewwvq9sUwfBVjN7vyndpJoMDTDsV6hQkC/r1w8qkkY+Y6IpcWUtwuGoKW/w3QSNATkxVQ67G3tUn/gcwkJBZshMUqMH+e3HlhhOPwRnGuKoU+omr0OFXWArwXNJHKLwFe5YxKkBBUEXiIxKkRkGobuN/P2KCQsuzu4GuqTGUQnCey5rIdxR1/049g0flMpW8vI1FW61gwi4zDY4StTrx7QxzPDd3b4ukQXz473+DkxeHH6GjCYxKJ1xeDirYItCE09cFJUxfPpP0oYysBA3xiSumsB39khoFKY3RkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkb3YO7AHdayxUBeGCIkc9u7rbApwnPhOoUoR+qL/vc=;
 b=AC88ay3cNdo+EsqSoM8m4akrx9piwvAc8wzHoftZWoaX6jKS+dn58hzDBZzaGHoeLrWoTJB6Y90wU75p784nWQ24Wsy6XQt36R1RINziTZooshxG50SDXGqEFD0XxswKvl04tQ2WPwyF+F6odFONCjTosCkBaQEZ58YVY0LgTRfP3AINgMP12tU0ORSAPr8dC6CE9Oqghstd5voUexTx8ZBbLfRKWukTdK10lC0J73dlk+txgLCPx5yOU0Hy+o9JeDPoXgOXT1ypMttqeSG5uGD70nXOmhrB5FsWK41tXHLMQvdDq90i5Xam7zMWLBRMcewipARmG4cuxaZks2AIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkb3YO7AHdayxUBeGCIkc9u7rbApwnPhOoUoR+qL/vc=;
 b=C0jvjeefrPqDhCN3uplfG5pWxFoVK+iMfiGZ6YeCa+IHPNaXqEIxriPD38ugP5gebyc/533JAUV3mmeDOAQG536EctaYt7M+iC4WI9UezZNhfHBNbybuju40yVgFSm7Dnm7YwnGUGDiu4dfVP+3KJdxkK+92xPMcOCEOky+XdmU=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9402.namprd04.prod.outlook.com (2603:10b6:208:505::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:25:13 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:25:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 10/12] tests/tcg/riscv64: Enable vectorised memory test
Thread-Topic: [PATCH 10/12] tests/tcg/riscv64: Enable vectorised memory test
Thread-Index: AQHdNeJ/9XTLoXA0n0CeP7IweAGXnLa3Y10A
Date: Mon, 31 Aug 2026 01:25:13 +0000
Message-ID: <c67946fd035ae3c632684cffba9a350a4d529ca5.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-11-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-11-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9402:EE_
x-ms-office365-filtering-correlation-id: 27d6a986-c024-420b-ac88-08df06feb4dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|10070799003|366016|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 46bmltq5VFdZrR8eB11UGTkLlyDac6yAsrEE5CmTljOOy2xVQKUOF9Vb3yIVTgiP8pKw846arjIrSrlEceYW8GwA0xg3do/NvJM6iHaCRiQkp5HEUVddIPcDCRvxhj6B0IbJyFE1q/Q24ZRi85fQIlaz8eSTnjDjQJ7tOQ/riNWpVCPhIEzdfHDShSpvJlJ8ZZwFI6o/WgT4ZKPVK2YegPM04eRYhYVLetqPvfmyZb0LHzImZ8PiUbc08Nh5ER5YCSeq3ywjY5onrw65CzF6L0a7JDIzOo/K3onkLcaovsTIHqwpYwKm5K8Rb7suAsoaCX5Ej4iIzgkpXChdQJBvr61B5xVRAtdYXqCyYuVwycymLfJjqWSBoII4FWApLY4/WUITKvE6ZL3VvlLGwTmKIYehShsY/6LdI/5chycnkisezhNm8jMDbUHe1xkFzBFcNc8qjYHT0dwa3RfXhNWJ7pLORyaJDa4ond8i/iChxwozKJUf4MT/E8YLiTXjdGShp+WBgyIf+rV9c/L/1y7BlJQHC5hR5WutSN3GMSA9K0XVlEfd0t2D82vMuPDUVa6Mg45ucbmhCeyirWs7HKK2x1gsTvtZ2XOtbXX9+vSetVkC182XlO7ZzOpNlM99I2wbGBtAn0qsmInjs8ctSK4oHnoI1F/puc2e745LlKXJl/6XcaJEfPwYI4fXA/Iu1IpwNHYoca+BHIqslcQ/cINCPwL019n3SNvigOUQvp1SG+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGVra3RKUUdiOTNibEplRVNkTXlIdU5kTy9lRk1BWHZpaTdSTjJEbmxabldv?=
 =?utf-8?B?b3NvaGVxZ0JORHg1YWRJK0NPYTBaOTNYU3ByWWE1ZlJyOEtaVHhUbW1yQ0hV?=
 =?utf-8?B?RjZ3UnF3OUZFVE5hRGYzc3VMVVlZTWc4Uk4rekljblFJNENmaUhOenV1RFc1?=
 =?utf-8?B?T2xLM1liZEs4SnNTNmxtcFZIVlpnbVhWWVd5dWVobjBUVVB1WGpPMS9wZEJY?=
 =?utf-8?B?bktBdDVSL3lYQkM3dlpFY25YMHV6R2JQN29WbVZKNk1Jd21Od1kwQlkvekNr?=
 =?utf-8?B?NHZrM0JHb0piQnZGNmlyR1JnZytRdW9aWCtLbEJhNlV3OHJldGh2bWhhdUhH?=
 =?utf-8?B?NTZVNUNjSGVoeUtIOW1KUHdKSUJpVXErYnJUYTl4TDBIZEZYWTd0WXRJY2Vp?=
 =?utf-8?B?eDI3WDNOVXBsNGRQdmx4MXdUNm5RYjBTNEF6UDhIQW1ESG5JMExMcGw1c2ZT?=
 =?utf-8?B?Q0REVjBodXlLajFXU1MrOE9hOTBDK1VYMkxXQ1BuT1FsWk9QMDc0a1FON0ZV?=
 =?utf-8?B?WndpbWRxdGZyQjN2NXRuMFc5V2R4aGhWY3V6WTNlQlFtK0FiZ2JNM0Z1MHYv?=
 =?utf-8?B?VmFxaXJ2SzN5Q0w2UHNXWGNwVTFYSEtJY0tsZzk1dGZkRFNrWTJkZ2I4dGJv?=
 =?utf-8?B?dDZ4V0JnMHptTDhiQ3RYblJGMzB2RGV3WDZQd1NIQ2ttdFFUWUdsMGlkMUQ2?=
 =?utf-8?B?VHkyOXQ5Q2RKZktHL2RnSE9GMlFJL2tmQmI4MEJGb0xCWGdlR2lUaE8xaXo1?=
 =?utf-8?B?QmJPSU1iV2JEWk5kc3UyL3gyNGx4cEZRYmMvK3hZSWU2Zm9rVUtkUlZxYWkw?=
 =?utf-8?B?Y2xiRUttOElEMjFtUHllVEUvZzRjMXI4L29uaXlnSnhtV0VRSjBzWE5KOW5o?=
 =?utf-8?B?Z1I3UGkvbnVyRUJzdGhvN0JOOGlueitEMHF0NmJ4OXBxcWNYdGV2OHF3ZlBV?=
 =?utf-8?B?SGMzd2hrNEp1bkV4NW9RYTdVUGRuaGdZQnZOTzBOSjdTOUU1M29Ua0dzeU1J?=
 =?utf-8?B?QjRmYzdRMHJ0TmRjQmREWUNLNUsvK3AyOUhteldLY0gyTnN3aC9nRjIrU3BG?=
 =?utf-8?B?M0JwOHZieHhrdVlhUmpIUnBpVFpvYnF3Tm03UWpsbkFCczk4R2M4V0hHOGZT?=
 =?utf-8?B?UHYyNWVtdjhpTWRFeGphdDF1SjdtQUFHbmpyaW1pakFITjB3eFFlbVIzc2NZ?=
 =?utf-8?B?MTg1REV2QkhhVjBRSURjb1o3SGYyblJnY0FWV0xtbHlENzlna3pKLzdiRnNN?=
 =?utf-8?B?dzJUaUlMMzdGOVRSZFN4L05CNFBVMWQ5NG9xNFBpeHAxQkRGWFAxU3c1akwr?=
 =?utf-8?B?R2ZVUmE0WE1PaC9vc3dESnI1bFU5T3lxbFFDU3l3bnZLMGlmdHA1aDRsWUdP?=
 =?utf-8?B?eTIxeTloSzVVYm9rdHlKdnBidm84bnFZYXBUK3F6NnBidUdaeDlDbm9tM2kv?=
 =?utf-8?B?cUZ3ZlJHSXl1amsyTlVDNEZtZUc4cElDYlJxb1FWWDl2TmFQeWNNMitVVmdv?=
 =?utf-8?B?eHdTcFc2RWUveXlhSnpUaVpXYVdlRklJRWMrMEoxZUFPUzlRbmRpMTBualZI?=
 =?utf-8?B?NzBoWDBiK1Bab2FYcVBTMG5zTUhQN1pBd2dpWXRsL3FLVVBBSFR4MXZXcU40?=
 =?utf-8?B?V2Zwa3hqWlorSzJUMGJibUJtcFM4NFEwT3Rwblg3T21HOURIWUVYQURMc3d4?=
 =?utf-8?B?UVhCeGNYS2JIK0dObEt4aitHditMMHJnZzdrWktUdWE2UGRKejkydElWZDhw?=
 =?utf-8?B?TkZGbW1ycUF3dFFwdTJrUlNzTHF3ZVZRNmdlRCtxOUdkcXpqM2dLcWdqbFdj?=
 =?utf-8?B?RnRFano5QTJWdWEzdUN6Q3RQU0d4NHRVV05yL3h3Vm1nNmtrUU5iMC9LaG9x?=
 =?utf-8?B?Y0xNeTlYMXR5UHV2ZzZHb2JMOTJ5SmZaWkFGeGdXQWJGVndpSjNzVWNudEJv?=
 =?utf-8?B?MkJ1eTl2MFJYa0tDREhyc1AwcVNpa1poem9rcWExWURVT29wQ2FqMGNBczRO?=
 =?utf-8?B?d0w1QlRLbENqaG1sTk1HRnRJOUFjVDNnck01MFVvMjk4Y3lnQ3dTL1RCc0JX?=
 =?utf-8?B?WkVjS0dzdVBuUWNSQ28rSGhVSi9ISDlDUDZmbFhNaFFldXpTNFh6Rmc3dUt3?=
 =?utf-8?B?OTZnajJ5UzVoRmYzMVZKODhNUURzMTVDclg5NmVZZFNkRHRHWVhrU2VibFE4?=
 =?utf-8?B?UDNxQ01ZWkJDL3lON0cyaEhmZjJ3enM4K2p4T3lqMGQ5RWNZOHllN3JDT3Mv?=
 =?utf-8?B?R0dhS3o3eHlFUFdWdlFoUEx2NVYvSlFLc2ZMQ2dUdnR5KzBLNkNCSmsyN2Fj?=
 =?utf-8?B?VFNKdDBlQWFaTnNCT25ac2tQM3JnKy9LOU9sZUlqcnlzRVpOalFUenlJWnhY?=
 =?utf-8?Q?qrnR2ubo3aajl1SqU8abPTjAAFCSvmJwsjLoqxagutnsP?=
x-ms-exchange-antispam-messagedata-1: L8R9FTb3OYAClcFguXATsrKg6VynN62Oo+s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78D23C639586E14FA3B2C14434353BAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VpUNUAaw2cON7vn3pEWSa1xdYvYN23c/6A7e42XXTsb6HVeJuKE6iuAuz5EfgFEMdjeSaogPm33N+fwqzQjD3d0LLWXstcJjusJE4v3lOmOlcGOK6gWe0gf3kA4TeOl2oHPfV9oJrxlrA1Cw3FGDysPpSVEBG70DgPDqANnWMHZnFbN2VJqau0Hum6pUlhOlY0+tamjD342jhP7uZRZmMCj22vRp+7aG9OF+RuXi8QRsRMSiyYFHMcJ+94UXA9Sy4/Be0tl8Dx/RVJuR6UyLgRfMkkeAzrQiZ8TzwBT+EO5g1DH9tBuwNvK1QlfrqSKOXz3IhqyIULcCc8k0cShcJw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i7vHnYNT7B3ywRRvbcFCssP/ogZbE3UrCWOYEs03wR/t7nujLzHiFafEOiQMuSM52/Q5L5vK4UWNL96rM+GRqnN57/3Uplg40H6VEHunwTQGRsINb5ovKLVbR5czVbrIzsaYJjeI/eqvThzkUHbZqAwu2/4t7iHW+rNeml76pWYDR4fBtSUwSjOKuPbUD19m7VJWuRnc3BIhu/i00th0UdJPoiHoeR1UJT5lso84ZrRRNIEkYmF0JaV5wo+spU15n7jLRQGs1l15nWHvg0xlb7sA4KyIZw2TQ3BVa9MT645zm/ISJq9g5rClw4MYophMNutWlrX7Q9ZGNbdLG0aqAtIc+GKwFTkrvqCdtUfZ3RM7j47BkBwJHoUOu36egxhgtW/OSZQNfzyVgcfDqj2qqs6KnL0C+fM/K0cVNEyvdVwUyNUM9Gm95QoMPqsKatwclfD9PeexAGU1zDQMzAz4ONMUrDY7egM3RqWots1krVxsW0FBgmvmrIvcQg9+p5xP5GJsALmfgMZ+PrqndnYXZVi6T1stbcIARoAYUS5XDP77DKNn37QqLr+hSiHE2hbIMfKn/DBRj59klGAkZ7TiIIndkNKzQH0yha22PrIR4/Yzy5TXseV/ZRwZNl2wSl2F
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d6a986-c024-420b-ac88-08df06feb4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:25:13.5520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 846qNFYXauV1UQEsHqgxRCsq3j8QXCKtT6nzY/DVINgl2DxKLyjmM6q+gYA7ACZpY6Y2sN2NH9BFNi6gexSKUl7LsYywjyd17w0c6dXVY24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9402
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=696fae14a=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IEJ1aWxkIG1lbW9yeS5jIGEgc2Vjb25kIHRpbWUgd2l0aCAtbWFyY2g9cnY2NGdjdiAtTzMsIHNp
bWlsYXIgdG8NCj4gYWFyY2g2NCdzIG1lbW9yeS1zdmUsIHNvIHRoZSBtZW1vcnkgdGVzdCBjaGVj
a3MgUlZWIGxvYWRzIGFuZA0KPiBzdG9yZXMsIGluY2x1ZGluZyBhY3Jvc3MgcGFnZSBib3VuZGFy
aWVzLg0KPiANCj4gUnVuIGl0IHVuZGVyIC1jcHUgcnY2NCx2PXRydWUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQpSZXZpZXdlZC1ieTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+
IC0tLQ0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0IHwgOCAr
KysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldA0KPiBiL3Rl
c3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IGluZGV4IDNmMmE4ZWQx
NjE0Mi4uMzAxYTZlNmU1NzAwIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cvcmlzY3Y2NC9NYWtl
ZmlsZS5zb2Z0bW11LXRhcmdldA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC9NYWtlZmlsZS5z
b2Z0bW11LXRhcmdldA0KPiBAQCAtNzYsNiArNzYsMTQgQEAgRVhUUkFfUlVOUyArPSAkKE1VTFRJ
QVJDSF9SVU5TKQ0KPiDCoCMgRGVmYXVsdCBpcyB6aWNjbHNtPXRydWUsIHNvIG1pc2FsaWduZWQg
YWNjZXNzZXMgbXVzdCB3b3JrDQo+IMKgbWVtb3J5OiBwcml2YXRlIENGTEFHUyArPSAtRENIRUNL
X1VOQUxJR05FRD0xDQo+IMKgDQo+ICttZW1vcnktcnZ2OiBtZW1vcnkuYyAkKExJTktfU0NSSVBU
KSAkKENSVF9PQkpTKSAkKE1JTklMSUJfT0JKUykNCj4gKwkkKGNhbGwgcXVpZXQtY29tbWFuZCwg
XA0KPiArCSAkKENDKSAkKENGTEFHUykgJChFWFRSQV9DRkxBR1MpICQ8IC1vICRAICQoTERGTEFH
UykNCj4gJChDUlRfT0JKUyksIENDLCAkQCkNCj4gK21lbW9yeS1ydnY6IHByaXZhdGUgQ0ZMQUdT
ICs9IC1EQ0hFQ0tfVU5BTElHTkVEPTEgLW1hcmNoPXJ2NjRnY3YgLU8zDQo+ICtydW4tbWVtb3J5
LXJ2djogUUVNVV9DUFUgPSBydjY0LHY9dHJ1ZQ0KPiArDQo+ICtURVNUUyArPSBtZW1vcnktcnZ2
DQo+ICsNCj4gwqAjIFNpbXBsZSBSZWNvcmQvUmVwbGF5IFRlc3QNCj4gwqAuUEhPTlk6IG1lbW9y
eS1yZWNvcmQNCj4gwqBydW4tbWVtb3J5LXJlY29yZDogbWVtb3J5LXJlY29yZCBtZW1vcnkNCg==

