Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3C3C61DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1waG-0006Qq-Pt; Wed, 02 Sep 2026 21:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1waE-0006QQ-KA; Wed, 02 Sep 2026 21:49:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1waC-0002rC-2P; Wed, 02 Sep 2026 21:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788400180; x=1819936180;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lRa3lBsGt2dpDIBAv+HR6kQe+RtBVY3GfhDuVOY65YY=;
 b=jOxW7smJXg0KgSFl32YHwIMJRe2URCVhC1K9BxwIEdPrz8KgQnxAZeJb
 CJW6YVEQkzrffcsPgW5lQ1i1eGpuSZnZxUMMT0vrFQgc28VlkQAMV184+
 /tZYk4gY5n43BIlcHWQ5j6kByMX8YhZBNVZUxueKkwoJ7G5ab9usimf+1
 Xyy1AAhNCw6F0y4Zxsa+OwXlvljzwGS/lzyjZS8TrPvItce8pag2PPEoE
 6iAXoRdfCDN+/+TIBMO9SpTYZi/QEWy3svoP6ae4RxlH9R/vIDT8NscUn
 NeYoxFQg5AJhgWPDJfDWp54Q6zy6veIBwre2pHrkfAefuF8SVfCEE/cr9 A==;
X-CSE-ConnectionGUID: RsWlcgNFQt2JTHZmfJwXkw==
X-CSE-MsgGUID: +yxoeyREQSi9xcTOtl/hdQ==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="150630319"
Received: from mail-westus2azon11010038.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.38])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 09:49:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKDNMtfOyYf6Fa96fbWvbdtwr+2/Z3bD3S95myJn0EFEozlDnx4to2UDvj1R/pBSe1jgo5gS/QzA/ILtTzPocPqPoOdRs0EUwfR0XGOAbzoKG1CK1QOmxGJ+5MgBzgtlzR6KAnKf3zX+DoP46DpCFs+jMu+fsLBT7lL7qvLMft+FvamX1yrwTo6KcFG6nPNLCkBQ54hoTRt8bGcSLKKJEhtjy1bV8uuY139IrMf1fmcaeJQXuG0ZXHk7t9rR+QykRsVLLTH/2pgfK8DI/nQoEb83BzLgEOm4byNKywqcvHmfe4/n9vUq5gwc4HUJBFtj7TvfKF2UCIU2AxUJ78NgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRa3lBsGt2dpDIBAv+HR6kQe+RtBVY3GfhDuVOY65YY=;
 b=dgfFycS18lSQn6miHNAxmYgh1+TtzqjDWwccFtbCv7CwZ95zvcwNtz7VcpSVlnD8ZcdCRAANDfZcyqM5vo7/S91jKahtyVZYxcu0BaxTACVPEPMizUUYZuwlQNCq39UOkuGH+HxYxVkG/Wb7Rzh2jRxVNLp42OlxeLoSzCPIU3+k3HuCO4Ei3E0PeLXDODBLCcsteJCEYFM2owSFDaTsQqmxk7HarSThuncHJEhs6I+8UBBmW5Q1Udtny5BzDr2RdMPYMnSM1+bSghRsb/4eBPCFTHyHoy+M9cJvFuHFdP3hKFLbt2IEMXDQB55MWROtjMGZjE73hXCX4ElLQrJTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRa3lBsGt2dpDIBAv+HR6kQe+RtBVY3GfhDuVOY65YY=;
 b=AeYf/IjFBkAbdl0SERerYtFywqhhvPWFG9mndKs1KRiloTFIZgqrQ/cLP3i0oIYNZnc6Mc5WqCtOfeW5j3xnia1w6Mjpt2l76YiKkYmIZkEbdQEfJw/ywQFV4D89XiaWS2eL81PVMmgXrDped9ARNsK7h6ds26X13C2m1KdHxNg=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9355.namprd04.prod.outlook.com (2603:10b6:208:515::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:49:34 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 01:49:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 07/16] hw/riscv/atlantis: Make UART unimp region a SoC
 device
Thread-Topic: [PATCH v2 07/16] hw/riscv/atlantis: Make UART unimp region a SoC
 device
Thread-Index: AQHdOO6xDBzjRWRaKkOJxU1/thnP+7a8GxGA
Date: Thu, 3 Sep 2026 01:49:34 +0000
Message-ID: <d03d077efe1a284568d59fc87141950ab124dfe7.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-8-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-8-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9355:EE_
x-ms-office365-filtering-correlation-id: f97c7224-4a89-4a92-8431-08df095d9ac2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|19092799006|366016|1800799024|23010399003|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: 4S+dOhRWklINKoRv2jN/915dIu5Y0439B9gXq3bR7Xa/1u1cI1Ofqqdtk+r8QnpF0NGdR1FtEg57JO6m7QwHOHL+rj1uNGn0Faqr9ttBfUc6h5QSL/n84rryYNsauxv+S97barT3/oBcVcM66k0UjLoYgDvTu5TFtVpimeG7snXIvNhQzpBm/R1ONuJWR2Rh+spsgAre0mpbvWYYL4JSI0rYy262KZXVU5FtqzCfRewOJcEExdLnXARgc2OXRtfhpmXC49vbBy7ApEMXb4Cs2B+b9jl5umTupn1WQfBFfiftA9KPFP9H8qntimn77li0zxZnBw17mssPnWwVDVBQENvrYln1pHxB0mGjBuk+2rOQ1/wvYQ3ocaIis65/JragWfLFsONFNHlLf5t1rvE9v4CLVSFNa4KgglxQcJCrVfFfj7E5nUi26vVwqSz8s+ScueykBxh/qf+muhFW3qEpSUohuLaIys0J0FP66MBHEBBiCyDI8RrFIC6ky7s1sG5g0zliLFahVZLk9HvGsUYv//SoFLxlFeyJiypxWNhROwtTGVQTc3zjNp6ISm0lMVBiD38Ur0dz7TvlWP4P9B5d+bnprJY7FCRDza6mz8JbIjSmx8IbMkY7W1ET7ghqh2rAi2nkOgvIAvyOBz/uQiUrDTw46NyWNLV3K50NzFpxOBNO0rzXMWerLyGCFoCMMgTdPyLpPQbbv60Ukw2Jffdf9w2IThp6vfwWkkkqZ71tIAQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTZiamV2QllSb0k3dkcycVJxWVhBWUhxNE9BZ2xSaThZT1ZrNHZ5TmpLSWJX?=
 =?utf-8?B?RUVXVGx5S3d3QTZIU0I4RGR6RklYNUlzY0VtOGw0NzRhbzN0ZE5MWXlLSmhk?=
 =?utf-8?B?SkRKV25tVWQ0b0VhSmV3eDhVMitUaE1lSzR1eWU5SjRrRDJCcjFYYVJaZ3hx?=
 =?utf-8?B?cWdoRk1xUE9IWDZlMmNrK0NZK1loRHhZT0llaDBxQlB5bmRudVBQQWd1akFN?=
 =?utf-8?B?R1MvZUlJSjFqRkx5d0taQU9Rc2pJWnJkcjN3LzF5M3BtcVBQNitFVGxvRFUv?=
 =?utf-8?B?MmtvMGczWkFEdWxnYld1MTRFQXVLa0lmZ3JEeW5uRmRQT3lSRXg2VGtBL3VZ?=
 =?utf-8?B?SG80YXk0dnVhZzFVM254M1piZHdSNUtJZlBIK1BlWCtMZDNjTmxtSG40R2Rt?=
 =?utf-8?B?WEJsRDM0TXFlaEFHVk1TVC85aEtvUGFnQW55U0NIUDcyK24rMkpYRjQ4YzBF?=
 =?utf-8?B?Z0lUYUc0cDRiY0s4YUtQRWlPR0tHZUMydUwxV0lZUnNVSUphcmk0cTc5aFdn?=
 =?utf-8?B?ZlZGQzRNK09xYVFRRnZDbnBWNklzaDJwR0Y4RkN4ZkoxWFpWQWVPWWlnZUpG?=
 =?utf-8?B?V3llSDlvUGhKc1lkSHB5K0c0VnJEeXhNK21PZklzSS9BMDZuK2ZJZHhIUXRm?=
 =?utf-8?B?T3RrVFZ5UzB3RytNa1NuZGd4eDZ4Wmx4RXNqQmZlSzJ1UlBqSFdXN1NqeHg3?=
 =?utf-8?B?TzJCTVdSdlN4ditpMENRU0Qydkcwak1zOWJsYnZxOEptc3d2NGh4b1JvU3U0?=
 =?utf-8?B?UnYzRnIyTS9wcUxtUFdEQjdWS29kQ2ZPOU8ySkVjVGRoaUxROEZrUk1XYWg4?=
 =?utf-8?B?amV3d214dlp0em01YXJWem9zcHdZR09vZmNCUys4WVpJejFTQy95V2FyNUlG?=
 =?utf-8?B?bjlEdUFSdVFlWlM0MWR5b0NyYTU1T3VJYzlYTEhjRmpEdUNPeTE4eEZ3NkNJ?=
 =?utf-8?B?THJtZUFnMldhdTRXaUgxNmFjQTRvbk9nQTFmNDZBWE01UWRuWlZhRTZsUXUr?=
 =?utf-8?B?Vkk1d21DNENMTFJRbWJ0cGVxcjYwajlPRTNqbUljWUJWcWxQVFR2Zm1VUkZj?=
 =?utf-8?B?aWxzc0FZMEFOWjBoMzJNRXc0RjNrV3paNXVRLzVFVlJmQnhIanZ4SnlxY3h4?=
 =?utf-8?B?NTN1d1pEcyswbTgwTGJzeVI3WlFVcDNyNXREcjNmQW1RQ0ltemlnbG5mMVB0?=
 =?utf-8?B?cWdDWDRNb3kxazQyTTc2azJqZ0N4L1Fvc3ZoaWFYNlNCRlc0OU5WWWxNK1Ru?=
 =?utf-8?B?cXlJdjFldjRHSC9kbTdWbVdBR3ozZXU3T0dKc2RCakZKMmdHaFIrRjhlWVhJ?=
 =?utf-8?B?eFpSNy9IS0tFb2laeHJPNTBOQmkvRUJqVnJmU2hDL0kxbHZ2L3pqUmY3SE50?=
 =?utf-8?B?RjduS05PSWNWVkRvL0RBS0EwYTZsYk1xVlpHdHFoeUlSMVVJT3RDL3Q5TUhy?=
 =?utf-8?B?dDBSUW5VR3BJS1B6OGl5dnJiNTFBWXE4UGJkak02d1dZL3BTVzlhSEhRM0Zy?=
 =?utf-8?B?Y3dEaTdNUm80MW8zWFFTQ0hqSThFZ0NHeVZQOUdRL3lqUG1RM3h1TEdhU2pa?=
 =?utf-8?B?ODAyc1hDcjVtZTlpR2NIOWJ4NzZVcllvaXNKUEVFTUNJYndITXVUSVNNL0tX?=
 =?utf-8?B?Y0p3MjZHZVZBSmwzdlgzYVJNR09WZU9tVnJvWllLLzJMenNuNmhRcXFaZHlt?=
 =?utf-8?B?UnR0OWdvbEhOekpXWnd6MEtzblg2b3dtdnZlVU1zRWVZZ0toQnJ1Qjc4eGhD?=
 =?utf-8?B?bVN2QW5nMjdSRzBjQ1crbitWeERHWXQwbURmZVZHVlNzUXpxZnlTRHhhVGJ0?=
 =?utf-8?B?WnhtYTZ2TnlLNGt1SGhwWWNNWDhCUmswcXhyWUZXMlVpblNsQk0vZ0grdEVk?=
 =?utf-8?B?VWJWeDk0SXpIZzJETGVMTnNYczhmOGdHMHhDWVFXYUlqcnNGaTl5dUlsT1lF?=
 =?utf-8?B?RXhSWklwclAzZjF0MjA1RmFvS3NSSnpINU5WbHU3WjUvZW5PUnc2S1pBR3M2?=
 =?utf-8?B?ZVdvL1BrY09tdW1OQmJrbWNBd2FSZTAzL2lUNU0wdlkxaERWUW94eVI4VEVt?=
 =?utf-8?B?ekRNL1J2TUpFbUEzZzJYckFKUkRpN09PSnBvam9pNENEa1NaUzZaUjZhc3Vt?=
 =?utf-8?B?TWlLTElYWC9GZHUxcHVMK1ErYXlDZHVxWWpTbTd2ekVQcGpralkzQXZjRTRu?=
 =?utf-8?B?NUMrei9wU3BJTzhLTXZTMlNPcWxKRWYxL3BNM3VtZ0w0S1hiVHJnZ1luSEk2?=
 =?utf-8?B?Q2NDQzNGT253TFlSRHN6azBBZC9JaXdDa2pJYWRwRTdmM2RZRHloOVNRTGRQ?=
 =?utf-8?B?QjVna2pJcEIxbEVhNTV5bjN4NU5ZVG9ZeHBlL05RYlBwRXpVa3Y1N056VUlm?=
 =?utf-8?Q?OqWgQxAfCZ+4JJys+TQPnGUWQdm6dLaKpi5JH+zS5ccF0?=
x-ms-exchange-antispam-messagedata-1: 6JWhA1ubur/WvLneyJ2TQx9f0Ej3SlqFFqk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08422E2D3D96584889EFD98E501105A1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Aduy1O4/tQ/rrAYcxWCKzk2AtS/2zjxaNPPHpy9p7nlou+lTQYJO2qEm9ipY9yo+m7ON4sae/nTHw366JcDG0UOILzM5YMV2CGmiW1l1kDtU6ilObWyImAKp3mJ/RKyyeoJerLLK8QQ3BWxTmPSREnufNPnc7bI2CTlZuip/jfse+0NIsg+bklJ/0yV4stA/bb2lwLVUxVAukyWYBW7xgOFhgy66zZN11GzM2is2PI0AA2efk7QkiTC0pmakL7SIdumXUIGs9YcXMtTbNPLA3/oFnQh4Ki8XIUQnGjgHLgwn4tTIzeBuWJHB2qoMsqvx1u4JrXGCZIXQZFh1fr+h4A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j2j5Q9sgqOWCXael+HEPRIznVucmaTkNY/ohovntRUQiK+/EuBuI6rGCtTdqESBAD0uYSbYsYlmd7TbLUxQuFegaTbhRpujcDExcIcQkFLqX1KX9HeCUr/lJuYpCfmJsEURv3wta8jwYH5vYWo0xgYsZORgHHyj/xjFNQDqGeOrFcxmVDV9PYVWm8U+eY4WeQGOuqiQD2YUQlTB8NDPBCCI9Ur/HzAHqQu+ONwEsZoc/akJrgE934+ibiqbno059hCNvb8tfXiekHiJlsag12WT1Lt5Yyk5xEdfRuoziBrjBw4p40Zj8ZLn6Vq4VEq0Klk5oLEJ4WK4Sr6nQX3sZfYfXM8nDpiR8QS7FfJcy4FD9Fo7gIBuRO0vqSlHAnFh4qYmpmt0dsHzPA5cmhqiEmWIH+fujqo+vfEDU7HPriETO7HKKz1L4GpJyQyp+nhHBIhNeX5iXu3tigIVojpvhJrneGcYL4wGMaEnSvM8Zgj4d2Ddzn/DcTVUgUN+LlXBw5Iqng8WWfKGTw07xk27jRpTw//arCMFZ/Bk3G1u/hyI9pzuDlTPkFMIOwgKtCZI9pkfU+XgR3YM5DftyGc2h+eynikIK6SlDwRzPNckOHxTKF07b10MdfpZZb5fnQHE+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97c7224-4a89-4a92-8431-08df095d9ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:49:34.2901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQSvewY5SkNDkaVkBoaBivuZmz0bFBF++umn41mXTc9uA3JqkoB2YcFBQUOKznpNbNeXvUtLFCqD1S8l/9V1ozt3fSk8uikHuZkun+BxAk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9355
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
TWFrZSB0aGUgdW5pbXBsZW1lbnRlZCByZWdpb24gY292ZXJpbmcgdGhlIHJlbWFpbmRlciBvZiB0
aGUgY29uc29sZQo+IFVBUlQncyByZWdpc3RlciBzcGFjZSBhIFNvQyBjaGlsZCBkZXZpY2UsIG1h
cHBlZCB1c2luZyBhIGhlbHBlci4gVGhpcwo+IG1ha2VzIGl0IGVhc2llciB0byBtYXAgaXQgaW50
byB0aGUgU29DJ3MgbWVtb3J5IGNvbnRhaW5lciBhbG9uZyB3aXRoCj4gdGhlIG90aGVyIGRldmlj
ZXMgaW4gdGhlIGZ1dHVyZS4KPiAKPiBXaGlsZSBoZXJlLCByZW5hbWUgdGhlIHJlZ2lvbiBmcm9t
IHVhcnQwIHRvIHVhcnQxLiBUaGUgdWFydDAgbmFtZSB3YXMKPiBhIGxlZnRvdmVyIGZyb20gYW4g
ZWFybGllciByZXZpc2lvbiB0aGF0IHVzZWQgYSBkaWZmZXJlbnQgZGV2aWNlIGZvcgo+IHRoZSBj
b25zb2xlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+
CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
PgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmggfMKg
IDIgKysKPiDCoGh3L3Jpc2N2L3R0X2F0bGFudGlzLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTkgKysr
KysrKysrKysrKysrKy0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFu
dGlzLmgKPiBiL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+IGluZGV4IDdmN2Q0YTVh
NTkwNS4uYzkzMDhhYTU3MDE3IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRs
YW50aXMuaAo+ICsrKyBiL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+IEBAIC0xMyw2
ICsxMyw3IEBACj4gwqAjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMuaCIKPiDCoCNpbmNsdWRlICJo
dy9pMmMvZGVzaWdud2FyZV9pMmMuaCIKPiDCoCNpbmNsdWRlICJody9pbnRjL3Jpc2N2X2ltc2lj
LmgiCj4gKyNpbmNsdWRlICJody9taXNjL3VuaW1wLmgiCj4gwqAjaW5jbHVkZSAiaHcvcmlzY3Yv
cmlzY3ZfaGFydC5oIgo+IMKgCj4gwqAjZGVmaW5lIFRZUEVfVFRfQVRMQU5USVNfTUFDSElORSBN
QUNISU5FX1RZUEVfTkFNRSgidHQtYXRsYW50aXMiKQo+IEBAIC0zMSw2ICszMiw3IEBAIHN0cnVj
dCBUVEF0bGFudGlzU3RhdGUgewo+IMKgwqDCoMKgIFJJU0NWSGFydEFycmF5U3RhdGUgc29jOwo+
IMKgwqDCoMKgIERldmljZVN0YXRlICppcnFjaGlwOwo+IMKgwqDCoMKgIERlc2lnbldhcmVJMkNT
dGF0ZSBpMmNbVFRfQVRMX05VTV9JMkNdOwo+ICvCoMKgwqAgVW5pbXBsZW1lbnRlZERldmljZVN0
YXRlIHVhcnQxOwo+IMKgCj4gwqDCoMKgwqAgaW50IGZkdF9zaXplOwo+IMKgfTsKPiBkaWZmIC0t
Z2l0IGEvaHcvcmlzY3YvdHRfYXRsYW50aXMuYyBiL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmMKPiBp
bmRleCAzZjE4M2RiNWMzMDIuLmFjZmQwZDMxYjM2OCAxMDA2NDQKPiAtLS0gYS9ody9yaXNjdi90
dF9hdGxhbnRpcy5jCj4gKysrIGIvaHcvcmlzY3YvdHRfYXRsYW50aXMuYwo+IEBAIC00MDksNiAr
NDA5LDE3IEBAIHN0YXRpYyB2b2lkIGxvYWRfZmR0KFRUQXRsYW50aXNTdGF0ZSAqcykKPiDCoMKg
wqDCoCBjcmVhdGVfZmR0X21lbW9yeShzKTsKPiDCoH0KPiDCoAo+ICtzdGF0aWMgdm9pZCBtbWlv
X21hcF91bmltcGxlbWVudGVkKE1lbW9yeVJlZ2lvbiAqbWVtb3J5LAo+IFN5c0J1c0RldmljZSAq
ZGV2LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpuYW1lLCBod2FkZHIgYWRkciwKPiB1aW50
NjRfdCBzaXplKQo+ICt7Cj4gK8KgwqDCoCBxZGV2X3Byb3Bfc2V0X3N0cmluZyhERVZJQ0UoZGV2
KSwgIm5hbWUiLCBuYW1lKTsKPiArwqDCoMKgIHFkZXZfcHJvcF9zZXRfdWludDY0KERFVklDRShk
ZXYpLCAic2l6ZSIsIHNpemUpOwo+ICvCoMKgwqAgc3lzYnVzX3JlYWxpemUoZGV2LCAmZXJyb3Jf
YWJvcnQpOwo+ICsKPiArwqDCoMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbl9vdmVybGFw
KG1lbW9yeSwgYWRkciwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5c2J1c19tbWlvX2dldF9y
ZWdpb24oZGV2LAo+IDApLCAtMTAwMCk7Cj4gK30KPiArCj4gwqBzdGF0aWMgdm9pZCB0dF9hdGxh
bnRpc19tYWNoaW5lX2RvbmUoTm90aWZpZXIgKm5vdGlmaWVyLCB2b2lkICpkYXRhKQo+IMKgewo+
IMKgwqDCoMKgIFRUQXRsYW50aXNTdGF0ZSAqcyA9IGNvbnRhaW5lcl9vZihub3RpZmllciwgVFRB
dGxhbnRpc1N0YXRlLAo+IG1hY2hpbmVfZG9uZSk7Cj4gQEAgLTU2MCw5ICs1NzEsMTEgQEAgc3Rh
dGljIHZvaWQKPiB0dF9hdGxhbnRpc19tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5l
KQo+IMKgwqDCoMKgwqAgKiBDcmVhdGUgYW4gdW5pbXBsZW1lbnRlZCBkZXZpY2UgcmVnaW9uIHNv
IHdyaXRlcyBkb24ndCBmYXVsdAo+IMKgwqDCoMKgwqAgKiBhbmQgcmVhZHMgcmV0dXJuIHplcm8s
IHdoaWNoIGtlZXBzIExpbnV4IGhhcHB5Lgo+IMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgIGNyZWF0
ZV91bmltcGxlbWVudGVkX2RldmljZSgidHQtYXRsYW50aXMudWFydDAiLAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5t
ZW1tYXBbVFRfQVRMX1VBUlQxXS5iYXNlLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5tZW1tYXBbVFRfQVRMX1VBUlQx
XS5zaXplKTsKPiArwqDCoMKgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKE9CSkVDVChzKSwgInVh
cnQxIiwgJnMtPnVhcnQxLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgVFlQRV9VTklNUExFTUVOVEVEX0RFVklDRSk7Cj4gK8KgwqDCoCBt
bWlvX21hcF91bmltcGxlbWVudGVkKHN5c3RlbV9tZW1vcnksIFNZU19CVVNfREVWSUNFKCZzLT51
YXJ0MSksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgInR0LWF0bGFudGlzLnVhcnQxIiwgcy0KPiA+bWVtbWFwW1RUX0FUTF9VQVJUMV0uYmFz
ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzLT5tZW1tYXBbVFRfQVRMX1VBUlQxXS5zaXplKTsKPiDCoAo+IMKgwqDCoMKgIC8qIEkyQyAq
Lwo+IMKgwqDCoMKgIGZvciAoaW50IGkgPSAwOyBpIDwgVFRfQVRMX05VTV9JMkM7IGkrKykgewo=

