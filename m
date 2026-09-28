Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581AEC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB24n-0002jQ-6c; Sun, 27 Sep 2026 23:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB24a-0002hf-Lr
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:30:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB24W-000588-5v
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790566237; x=1822102237;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=R2ydGP8F22WFwMSbiI+Kr9fghI5wWQrCzshcSmCk8+s=;
 b=rcVzogz0DjFro/e2ltPl3Q8gU81RLEfwB1175glf2YXHhnb+hd01Gd/o
 DQdbmHfnz16J7+3FNAE+oPQngY4Kfy0+Em06M5v5jWtDbQbFl8l54+6qh
 +RQ3ZUupqphQnHAWWv6LfmqarhWev6QPRu784rz56ucNOkG2WZAOMSSZR
 DTHD+d5xwTafPQFxOYYlPMDwNTDLhX7f4MyxYg7INYFUlS7FzzkpJeYmY
 T98jHfx/l7GU8ebJKvdHNWlsAB2ndfAj52H/JiQegKGn9ANghUrUhzn8p
 vqspi1aHcEhtE5K0jJA8FA9gYsI81JlgptrnngtngHuWuYUyPvmvz+tMX w==;
X-CSE-ConnectionGUID: vsAMKy4LTqqpPFVoubEZcw==
X-CSE-MsgGUID: YUasgSRZTZO7SIUO5q2TAg==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="155113455"
Received: from mail-westus2azon11010021.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.21])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:30:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sd3/IjOgyBFDUXga2MV0Fy9G5Xtzz/E6h3Bs3N7aCTqnMJZ5rXR0/eDDm0oAFytWLASR44jYViNrc2yTDKZv9KsKkd5u++1fZ10VrKs5GSxzZTNoeDU8zQ4129lm/4voetYChRmlqFHoY+lAnszMJBaXIhoIm2XWzaOXHF18T1sJTXiJrvZO4CnbUH+VF9n4Kr+XLPzF9XDnjT0XwXn9bp2TSiFmmjs7sqdBb7tEUmDy1xR8a7JJPCGYwgdK44lo2fri9DBFSwyH+fDEMeLFyCTP0uH9j4cUhaZzm279NrX2Gw8DVKpanmaYFuGMGH0ZP8gVx1Y175XLeR3ElACgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2ydGP8F22WFwMSbiI+Kr9fghI5wWQrCzshcSmCk8+s=;
 b=sbEYVZ2RUnU5gnt005L+MhFIynSk/8XRNfABkN27T88frVJ4uS82wNGl97fIl/nT+IeH+HeDaTTW+zs6a0VawIQ/kjQnZgtBMwa+220+bNfd4NsEpQuPFEQeocFc1GTtU5hjHOb8ZfG85iFXnptT615sUTSdPKWKluy9hnd9iEGosszzS5yOQOGarF6qDv5CyP103pwLSYqK2WrJhW6J+UBZlc9u4xPCnflU/VHOBIv9Sbz8lRntBdcV/+JI02sY35uJQdr0Jw98Ao8dQL8kguJ3EsuDFp29wPfxKy7WvI8WFrQ1gvfZjMjXb1li/gud06wapiEvsUAkJbUeJj7Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2ydGP8F22WFwMSbiI+Kr9fghI5wWQrCzshcSmCk8+s=;
 b=lnTYlgGvsfqo981VIiVlJ9tt/mYLKRIfWWsZu4x/IzSy9gOE3cp66Ym3rIgsGoan64s7JMSunLdYAyDUhc1Vz+Y03KKwgsMjMtD0aEH8jUXeg7lwuZMu44LyDE3LP97viU/e1wWc8YP+mF2uhDF9zLVUNluMVERTVozx73pnKmk=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MN2PR04MB6366.namprd04.prod.outlook.com (2603:10b6:208:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:30:27 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:30:27 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "max.chou@sifive.com" <max.chou@sifive.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 02/11] tcg/riscv64: Rename sb-type to b-type format
Thread-Topic: [PATCH v3 02/11] tcg/riscv64: Rename sb-type to b-type format
Thread-Index: AQHdQ90qpxRHAvs/WUm6l97dnKU1H7bja60A
Date: Mon, 28 Sep 2026 03:30:27 +0000
Message-ID: <cf3fea767b8f9d2a3569384bbd927a7494313170.camel@wdc.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-3-richard.henderson@linaro.org>
In-Reply-To: <20260914000814.785155-3-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MN2PR04MB6366:EE_
x-ms-office365-filtering-correlation-id: 54dd754d-c2fa-488e-1028-08df1d10d6e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|10070799003|38070700021|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: pEM1KIAQGZKIlYq3D5Z9q2C41s7/W8K96eQEip3kbWXD8LT/XEaOhuh1NDMT/LOL12teQ+tdacmbetNat1Ta+RqO8qLPBpi4EMoxBZQL79PmUL9nz1nDp/F4yBAT8br4fKZLDPT8H86n2iPWx0d8KO8pilZ4LBLcIkdiqgHntvRNnu4MCJecvad0czSCeRTBT5WzDmwhkMZNHY6kFPAQmd3W4dcMG8qTpWdbg2hZI53YaFuNjaQmDOeadqr9vMD2KGPfRfjGhyI3Q6TCd4EwAhZ/Ias7psfUzvA6VWSU8TsGHlz21B6cIXLSiU4xFd0sLfielNoK1GGHNMEDVpdgLeSfJmYsboIIOs7zkiqzUn7DzSv+q+58eu+2DKPfQDfoI9kMykbWKBKpVuL2yDqwJ3l9UAd+RxHQnW+JTNQS4ckRqnoJfx71bgah2QEDIn4Euh14mOumIZM0zaBMywwvGf3WyVAM/h+Og2vri2/nOIzBcwuw1t12gmmUldi1yUg72cHGD6J1saFWB67XOvtBQzUriQap7yuuvM1UIIjNWZ+K3LD/rlmQ/2mlvBBWAdkehBz9DHYJYduZ6up9ZFKzaLG8xiKO13u5WAeSXxULh+0+gtODkRELyjQIBqkZ7QxJ+iE7hQymiyf5qyi3MXmgp9EiO3KTb2VPI0zCvApsvQDKAHaL1Aoqh/iuUuMeKjd5Kakg+2Y3W2SEG5rcuBCe4lRfKOW4aKyji3y5HYeQ5zc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(10070799003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3hyU3pZaUFTTTZLV2c5NXFpVmVEQyswVXRKaVVvOVBqOUhGS2xPbHNranYz?=
 =?utf-8?B?aGVJTGNjMzNOTk9pbm83VURMeEFLWXV5RUNYd2FtSjZiZkhQMUp2Q1MxYTJm?=
 =?utf-8?B?QjBGRHQxdmlSTkFUVG9QK2xXcFg0RXpiWisvUDY3S1BYMkpCckMvUHZMYXFP?=
 =?utf-8?B?NFZydlFXTTBGK2d6NmJNOHF4bnpuSDNZOEtvRSsvUSs3T3JzUzBJTlJkcDZ5?=
 =?utf-8?B?bzdaMXdjL3F6RFFGUC8yQ0lBSkM0UUovQzQ5UlZxSzFqdEx0eE9DLzk2Z3pk?=
 =?utf-8?B?d21pMG54Zkx3R2ZBc0xmcHVYVmNIcjNyZGZjdldBQmJpODVBUDF6eFFVNnAr?=
 =?utf-8?B?ZU5PZ01lZG9RTDJYcnI3UVNhY3N5UzIzSS9LYk5mR0lwUDE4T3drakRtT2VL?=
 =?utf-8?B?TzFhbDVJMDVKUU9TTGNjYlcwVURVVmxuVFJjZHJ6NTJDbk5XcXMvUkV4Ky9W?=
 =?utf-8?B?ck0vR0VHMkpxME5mSU5jek1xUkNoczVXb3QwS09aWnJ0NHkwalh5R2ZkRjVw?=
 =?utf-8?B?ZkVJb0pTUCtuTFMyS2wxTjUzYWNVM2dJak5aWlQ1M3RlU04yTjhqUmN0Wkx3?=
 =?utf-8?B?b3cyK0FzdjczT24zZkdJOUFZQ2Q1aE5lRk8ydDh2ME1STy9ReWIrdkJpWVVU?=
 =?utf-8?B?UWMxRmp5a3lrT3F2UUhsaGp1ejUya0p3RXc3MW1TRTgyYnlVVWZlc09DeUFr?=
 =?utf-8?B?ZlN2QkVreWhJcWNtVGJ0ZGNKZmlYYnN0c3RWaG9ycFZkcmhuaWhGaG9hWE52?=
 =?utf-8?B?UXo0YU40aENlVjJmWlRtTy9sdjh2dTJJdCtaQU9XcjFaaFlJdmpQN01rQzg0?=
 =?utf-8?B?WEJwZEk4bUpNOVZUTjBiMXZOcGZnT0VvYkpjK3pzbnloOVNFRC9LU0dvTW9D?=
 =?utf-8?B?UVNNNTE2ZmMrSUpCcU80UGlHREtkREFZNG45TVgxTjVYbFlwTCtOL2RIUldq?=
 =?utf-8?B?eEVuZ09Qc1cyeG9neWlzNnoxbHFLemNoVGRISWpGcXpLbW1FY0VtT1JWRGV0?=
 =?utf-8?B?cW1VNjJNZGcyNDNvalpVam43alRlUzcrWVZmbzRSaU9ybHVRS2tBTml6NUxF?=
 =?utf-8?B?YWU1Z0tWY1dPakxYcS9YUkZLV0JkcTRzQ0srWEVIcTBxNjFLNVhlZnIzZVAz?=
 =?utf-8?B?bjZiOWRFT1N2OGZMTTFMdk0yY0dTdksvMDd4U1BuOVc2eUpvRFNKSjRPYzNX?=
 =?utf-8?B?eG1iRWkyMkdwY0h5TFFFaWdiYmdpZGVpWTdrUkNTaHVWTk13eVJzaWdhRlpR?=
 =?utf-8?B?OFZ0MEhXaTFkVkdzR0I2cHY2UWxRNSs2ZjRvTFNCRmRyTWN3K09nRHpBT1p6?=
 =?utf-8?B?ajZtd0RPeDlHUTNrSFB0Z2pwaktWWG5iVUVOVUpCU1psYjl3bXFZMGJKNzQr?=
 =?utf-8?B?MEtMMTlITmJSakRyMUlUSStWTFB1eGJ2c08yeFdNcWphbTNEcExkQWhIczNU?=
 =?utf-8?B?QmRTV21xcmYweEpteTBKUzRldXlUb044Vm5tVzR1c2JES0JKVjl2SEFyUXBj?=
 =?utf-8?B?V25WZ1NjblBjbktpd25aa0tUS01aa0NaaFoxS1JvM0Fib1M4NDN0K3FBMWF5?=
 =?utf-8?B?UUwweG52ZU1XNUhURmdSQUl1Zlh4d21xWFkyRFJDZjNIYkN3M05Qd3g4NnA4?=
 =?utf-8?B?ZVFJdWlkanFEYVM5ZFVWVitBQlJtQ29HUTVLNGZyVHRNUkNRUTlhU2x1aUxW?=
 =?utf-8?B?R3hpTGN5OE54Q1BMQzArVGovLzVacXlzNk1kRTh2K2pndFZoTHFWY3NjdWZk?=
 =?utf-8?B?aytRL0NMQ3FkVVN1TVJtV0llcHpPa3FpVGxxYkdZYmpZVVIxS3NhUkVTTTJV?=
 =?utf-8?B?TkZTeldlWk5HRnk5S1hqV0M4TzBXWjBVeUNOSUdNYjRwNHpnMDRraTQ5SmlN?=
 =?utf-8?B?UElXTmFBN2FqSURvVWo4OE1LdG5QYmpscjRaY0ZDRFRTaGNPRHQyV1QyQ2pW?=
 =?utf-8?B?OXhwa1o5azBqUXJnK0w1UzBoVGNzTHFFRmJ1VFRsVXRTK1pOMVpQNnRudmc5?=
 =?utf-8?B?bzZCc3ViWkMwSUd5d0x6MTR2bUd2WWlFTVFHcG1LUTh2akxwRVJodjVjMWpk?=
 =?utf-8?B?SU5FSmN3WVFJUUdCTUNZUlpDVDZqaFN2UEtRN0ViS04vN0UyNzNoeUptaEJW?=
 =?utf-8?B?N0ZCNVRoMHBKTGFIZG9XbXQyTlYwYWUxMkF1ZXdKMmpLZmJUUlFEWVB0cVFC?=
 =?utf-8?B?eVZEdm9haFl5Uyt1MVMya21QbnViMnhJZDZQWlV4cmdNT3lIbkRRSG5nY1U3?=
 =?utf-8?B?dWltUnN6NUdNSUNWMG9Wbnc3OE56ZTZpQ0MyYk9LNllKQ2pmdnZLbC9ZRGNy?=
 =?utf-8?B?a0VRKzJqQmtHT2hqL09RZkQzN2UybGg3MFY0WmxxOStLbWVJaitLRUxSRHNp?=
 =?utf-8?Q?NMmFHEBVMoqAVmGa/n5ZtkxXqfoFTPCASI6bGo8AX0GNK?=
x-ms-exchange-antispam-messagedata-1: U29d3f2CN/WprEddyL5bJpnBmwrGNexdKeo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E69ECFA10526446AD9D5540399E2B64@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uDIoCee2c9PouzfSljYuD/aZp2fCbccvc8RPRNGoxfKxPy+jwncC3T86qXTkOOyuDtOLPlQHud+lRXwAEerT+ABp0xAttQlcE+nsBpC7EqmY1oUHknzYNeZ2OtgLJ2whT71JwCjq1ZJBjiJv4GYwndGnUANtuR6wFQZC1Je1+OCPyLvsYryYu6lMcEZJosMwjepEhhR2SsotMU35L8ZGzEz9C9YAZlDc9+x5BNXPeh8yWoMlOmmIwQfyAXrBttQLA0OCASIso5pXLtvrupnfw1GYcXCMZBeguhHqtARzp4zmCvX5N+/E4Ap1kR9M+od4eGFDLDa1dSM1wCYSM6KZkQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u9QunZy1VI7aEQIe5Job1ChJsztV5z2xBIrvoABv/KtaCUAhdc+p4Qx67Xag+gNHN8LY1uzWFY10q9eC4BZWINFU9iAua/Xfw8u8TYOMXDKhT9v71G8vpKMVhCK8FpuNzCjI5Fj5je9R4F4VUkwpGHEzWHsLRYz9zvA13IRuMSqlRrWZRdFKQVB2nP8GLzdEHEPHi2ba3ZE2qVf/SXVndTyJFJnopAvi0LNYssSn0c+f8W8qQzfmT0wvTfc5ZVF/gDEL2fnlcjKplasCZ/bQJiNh1xNDp5AqoWtL6GLO6zC/Jez7HkG41HYGJTXLd9UB7KqBwZW8Z2zjDmSnM7r0muajyEsNUvRPHYQDIgMdGM3krvUHxBwI9P7lgHK9zscAqqM9jtyUodgHWQsHJ5sNUInZPbyulVNIzaMvVd0F26CAVaCdr0FWjzGeUzVxfH74BXa0j+BSgBtmh9Ype2Xva//rOIzjw7wth1Ls5kF6+TCp3GNQvVz35RpPhgcAdKjqwv7CPHQRH4QgryoVjV/idNyQ89er5CrT3daBiohNk3H9rRB0rAvGjXl2NacZS4h1dQTQrboeOspY6sIaB16mzXtCva3RB863xQUvOTdh2FWv5jxFMFCUnv7OCRlro/Ma
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dd754d-c2fa-488e-1028-08df1d10d6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:30:27.1756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrzK/FaGTaHqQM/3G8bwIObU36mdmFwR2C9hBQwxUQ7tfe572DjXH9K5/8mFUeQMq1kpun0yVrpBUjzMUhOJl/waNt6QiVNS4OxNTUNLrLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6366
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gU3VuLCAyMDI2LTA5LTEzIGF0IDE0OjA4IC0xMDAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToNCj4gVGhlIGN1cnJlbnQgcmlzY3YgZG9jdW1lbnRhdGlvbiBjYWxscyB0aGlzIGItdHlwZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRjZy9yaXNjdjY0L3Rj
Zy10YXJnZXQuYy5pbmMgfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS90Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jIGIvdGNnL3Jpc2N2NjQvdGNnLQ0KPiB0YXJn
ZXQuYy5pbmMNCj4gaW5kZXggYTI2NTAzZmExZWQuLmExMGI0MzNmMmZmIDEwMDY0NA0KPiAtLS0g
YS90Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jDQo+ICsrKyBiL3RjZy9yaXNjdjY0L3RjZy10
YXJnZXQuYy5pbmMNCj4gQEAgLTQ3Miw5ICs0NzIsOSBAQCBzdGF0aWMgdGNnX2luc25fdW5pdCBl
bmNvZGVfcyhSSVNDVkluc24gb3BjLA0KPiBUQ0dSZWcgcnMxLCBUQ0dSZWcgcnMyLCB1aW50MzJf
dCBpbQ0KPiDCoMKgwqDCoCByZXR1cm4gb3BjIHwgKHJzMSAmIDB4MWYpIDw8IDE1IHwgKHJzMiAm
IDB4MWYpIDw8IDIwIHwNCj4gZW5jb2RlX3NpbW0xMihpbW0pOw0KPiDCoH0NCj4gwqANCj4gLS8q
IFR5cGUtU0IgKi8NCj4gKy8qIFR5cGUtQiAqLw0KPiDCoA0KPiAtc3RhdGljIHRjZ19pbnNuX3Vu
aXQgZW5jb2RlX3NiaW1tMTIodWludDMyX3QgaW1tKQ0KPiArc3RhdGljIHRjZ19pbnNuX3VuaXQg
ZW5jb2RlX2JpbW0xMih1aW50MzJfdCBpbW0pDQo+IMKgew0KPiDCoMKgwqDCoCB0Y2dfaW5zbl91
bml0IHJldCA9IDA7DQo+IMKgDQo+IEBAIC00ODYsOSArNDg2LDkgQEAgc3RhdGljIHRjZ19pbnNu
X3VuaXQgZW5jb2RlX3NiaW1tMTIodWludDMyX3QgaW1tKQ0KPiDCoMKgwqDCoCByZXR1cm4gcmV0
Ow0KPiDCoH0NCj4gwqANCj4gLXN0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9zYihSSVNDVklu
c24gb3BjLCBUQ0dSZWcgcnMxLCBUQ0dSZWcNCj4gcnMyLCB1aW50MzJfdCBpbW0pDQo+ICtzdGF0
aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfYihSSVNDVkluc24gb3BjLCBUQ0dSZWcgcnMxLCBUQ0dS
ZWcgcnMyLA0KPiB1aW50MzJfdCBpbW0pDQo+IMKgew0KPiAtwqDCoMKgIHJldHVybiBvcGMgfCAo
cnMxICYgMHgxZikgPDwgMTUgfCAocnMyICYgMHgxZikgPDwgMjAgfA0KPiBlbmNvZGVfc2JpbW0x
MihpbW0pOw0KPiArwqDCoMKgIHJldHVybiBvcGMgfCAocnMxICYgMHgxZikgPDwgMTUgfCAocnMy
ICYgMHgxZikgPDwgMjAgfA0KPiBlbmNvZGVfYmltbTEyKGltbSk7DQo+IMKgfQ0KPiDCoA0KPiDC
oC8qIFR5cGUtVSAqLw0KPiBAQCAtNTg1LDcgKzU4NSw3IEBAIHN0YXRpYyB2b2lkIHRjZ19vdXRf
b3BjX3N0b3JlKFRDR0NvbnRleHQgKnMsDQo+IFJJU0NWSW5zbiBvcGMsDQo+IMKgc3RhdGljIHZv
aWQgdGNnX291dF9vcGNfYnJhbmNoKFRDR0NvbnRleHQgKnMsIFJJU0NWSW5zbiBvcGMsDQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFRDR1JlZyByczEsIFRDR1JlZyByczIsIHVpbnQzMl90IGltbSkNCj4gwqB7DQo+IC3CoMKg
wqAgdGNnX291dDMyKHMsIGVuY29kZV9zYihvcGMsIHJzMSwgcnMyLCBpbW0pKTsNCj4gK8KgwqDC
oCB0Y2dfb3V0MzIocywgZW5jb2RlX2Iob3BjLCByczEsIHJzMiwgaW1tKSk7DQo+IMKgfQ0KPiDC
oA0KPiDCoHN0YXRpYyB2b2lkIHRjZ19vdXRfb3BjX3VwcGVyKFRDR0NvbnRleHQgKnMsIFJJU0NW
SW5zbiBvcGMsDQo+IEBAIC02MTIsMTQgKzYxMiwxNCBAQCBzdGF0aWMgdm9pZCB0Y2dfb3V0X25v
cF9maWxsKHRjZ19pbnNuX3VuaXQgKnAsDQo+IGludCBjb3VudCkNCj4gwqAgKiBSZWxvY2F0aW9u
cw0KPiDCoCAqLw0KPiDCoA0KPiAtc3RhdGljIGJvb2wgcmVsb2Nfc2JpbW0xMih0Y2dfaW5zbl91
bml0ICpzcmNfcncsIGNvbnN0IHRjZ19pbnNuX3VuaXQNCj4gKnRhcmdldCkNCj4gK3N0YXRpYyBi
b29sIHJlbG9jX2JpbW0xMih0Y2dfaW5zbl91bml0ICpzcmNfcncsIGNvbnN0IHRjZ19pbnNuX3Vu
aXQNCj4gKnRhcmdldCkNCj4gwqB7DQo+IMKgwqDCoMKgIGNvbnN0IHRjZ19pbnNuX3VuaXQgKnNy
Y19yeCA9IHRjZ19zcGxpdHd4X3RvX3J4KHNyY19ydyk7DQo+IMKgwqDCoMKgIGludHB0cl90IG9m
ZnNldCA9IChpbnRwdHJfdCl0YXJnZXQgLSAoaW50cHRyX3Qpc3JjX3J4Ow0KPiDCoA0KPiDCoMKg
wqDCoCB0Y2dfZGVidWdfYXNzZXJ0KChvZmZzZXQgJiAxKSA9PSAwKTsNCj4gwqDCoMKgwqAgaWYg
KG9mZnNldCA9PSBzZXh0cmVnKG9mZnNldCwgMCwgMTIpKSB7DQo+IC3CoMKgwqDCoMKgwqDCoCAq
c3JjX3J3IHw9IGVuY29kZV9zYmltbTEyKG9mZnNldCk7DQo+ICvCoMKgwqDCoMKgwqDCoCAqc3Jj
X3J3IHw9IGVuY29kZV9iaW1tMTIob2Zmc2V0KTsNCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
dHJ1ZTsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiBAQCAtNjYyLDcgKzY2Miw3IEBAIHN0YXRpYyBi
b29sIHBhdGNoX3JlbG9jKHRjZ19pbnNuX3VuaXQgKmNvZGVfcHRyLA0KPiBpbnQgdHlwZSwNCj4g
wqDCoMKgwqAgdGNnX2RlYnVnX2Fzc2VydChhZGRlbmQgPT0gMCk7DQo+IMKgwqDCoMKgIHN3aXRj
aCAodHlwZSkgew0KPiDCoMKgwqDCoCBjYXNlIFJfUklTQ1ZfQlJBTkNIOg0KPiAtwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHJlbG9jX3NiaW1tMTIoY29kZV9wdHIsICh0Y2dfaW5zbl91bml0ICopdmFs
dWUpOw0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJlbG9jX2JpbW0xMihjb2RlX3B0ciwgKHRj
Z19pbnNuX3VuaXQgKil2YWx1ZSk7DQo+IMKgwqDCoMKgIGNhc2UgUl9SSVNDVl9KQUw6DQo+IMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJlbG9jX2ppbW0yMChjb2RlX3B0ciwgKHRjZ19pbnNuX3Vu
aXQgKil2YWx1ZSk7DQo+IMKgwqDCoMKgIGNhc2UgUl9SSVNDVl9DQUxMOg0KPiBAQCAtMTY0NCw3
ICsxNjQ0LDcgQEAgc3RhdGljIGJvb2wNCj4gdGNnX291dF9xZW11X2xkX3Nsb3dfcGF0aChUQ0dD
b250ZXh0ICpzLCBUQ0dMYWJlbFFlbXVMZHN0ICpsKQ0KPiDCoMKgwqDCoCBNZW1PcCBvcGMgPSBn
ZXRfbWVtb3AobC0+b2kpOw0KPiDCoA0KPiDCoMKgwqDCoCAvKiByZXNvbHZlIGxhYmVsIGFkZHJl
c3MgKi8NCj4gLcKgwqDCoCBpZiAoIXJlbG9jX3NiaW1tMTIobC0+bGFiZWxfcHRyWzBdLCB0Y2df
c3BsaXR3eF90b19yeChzLQ0KPiA+Y29kZV9wdHIpKSkgew0KPiArwqDCoMKgIGlmICghcmVsb2Nf
YmltbTEyKGwtPmxhYmVsX3B0clswXSwgdGNnX3NwbGl0d3hfdG9fcngocy0NCj4gPmNvZGVfcHRy
KSkpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+IMKgwqDCoMKgIH0NCj4g
wqANCj4gQEAgLTE2NjIsNyArMTY2Miw3IEBAIHN0YXRpYyBib29sDQo+IHRjZ19vdXRfcWVtdV9z
dF9zbG93X3BhdGgoVENHQ29udGV4dCAqcywgVENHTGFiZWxRZW11TGRzdCAqbCkNCj4gwqDCoMKg
wqAgTWVtT3Agb3BjID0gZ2V0X21lbW9wKGwtPm9pKTsNCj4gwqANCj4gwqDCoMKgwqAgLyogcmVz
b2x2ZSBsYWJlbCBhZGRyZXNzICovDQo+IC3CoMKgwqAgaWYgKCFyZWxvY19zYmltbTEyKGwtPmxh
YmVsX3B0clswXSwgdGNnX3NwbGl0d3hfdG9fcngocy0NCj4gPmNvZGVfcHRyKSkpIHsNCj4gK8Kg
wqDCoCBpZiAoIXJlbG9jX2JpbW0xMihsLT5sYWJlbF9wdHJbMF0sIHRjZ19zcGxpdHd4X3RvX3J4
KHMtDQo+ID5jb2RlX3B0cikpKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0K
PiDCoMKgwqDCoCB9DQo+IMKgDQo=

