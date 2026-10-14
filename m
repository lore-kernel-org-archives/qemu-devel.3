Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C4CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqWN-0007NZ-7I; Wed, 14 Oct 2026 00:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=740cf4029=Alistair.Francis@wdc.com>)
 id 1xGqWJ-0007NJ-Lr; Wed, 14 Oct 2026 00:23:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=740cf4029=Alistair.Francis@wdc.com>)
 id 1xGqWG-0005U3-9B; Wed, 14 Oct 2026 00:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1791951792; x=1823487792;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hhJB3/lWZZRQctlrojxFJnja/pamYtsg+N1waXESw78=;
 b=r2Uy4KoHFkUW8LaXTeAkxr7OST5ZzayK0lxIs5pROrZkdwUSRHRbwPjT
 OUElOwMBFS2uenYw67q4JO7+2x6wD/c+pvTzIAUAVaA5yBWyV78PjFbmn
 fQ9PpmmTAtbMsauTymM8Gt+SgYA4I6WMaVvV5fkTds743mwE4RNHSQlER
 tCWhjeRHzAAeZ2aXgLSQqDZkFkkicVe0pGzqp37kPhXtqUX+JKkjHR4MZ
 2EAOHMuSR5TL2nhRuFxaeN9s2/9jZQsulMzhIxj+Etj/7OFZi0+Hs2VUS
 NKv1ldtRvOBYBWHZJ5iOd8NlqQB7WSwixXmqrKZAhcYpCc5oR4pumUDy6 Q==;
X-CSE-ConnectionGUID: ZocqMLciQE6q9O9eCThTqg==
X-CSE-MsgGUID: NedoGLs0ReORR6CyLGKsOg==
X-IronPort-AV: E=Sophos;i="6.27,157,1786982400"; d="scan'208";a="157933355"
Received: from mail-northcentralusazon11012055.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.55])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Oct 2026 12:19:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFLipeY3ccnQnpTBsbMtRcoD5akjiJsZG5XarhjBpAHQIkMYdqGdoN4lc5qRxvPav0lrcYPriqz5f9QbXDPs0kgMxmuHlLRWFimS1aSrsPisxsSJd4Fto1TVGcxQSKAakwq2iy/u06WlULKYEc3m3V9iXmzyZSSVpTGYpq+OBZjkFL+xenLbfgKBjlxgqYdX5ePcipZTmVuZtuVu8huHBZ57z9BXXdlBfZp3Rk45TtJxOHlzkbfpUjImu6T76iUhZueRb6bB8EIzrUj5pw9RQXSL4vWaHwv2UvOL1AhDVDiwoCTNakeq3lzqJM1BwmZ5j2bA+NiUxI2b8KxfzFma5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhJB3/lWZZRQctlrojxFJnja/pamYtsg+N1waXESw78=;
 b=vKGzi681L0movdHmZ9S1k+ZlOBsC2PIg0fGnktbkpEmHx0RDKDULEbMeYRwSp9mLxMCTpN2+UGs1CdpTctZhhFppUaFfGiLz/BWqnYxakWB7N+lvynUgNfd/6jnXl79GBA/wOyG6pPMNauQrxekYYdzl8YOtBa0uuq3sfyDNCx8YOLsxOT44uYOmaLgnnHxrQrdQzSriOVwD/2vkbGiqe7e2eFfNwyOKI3pZbBQZ7fYlZcXNW2e+4RgCd00p0Wp3dLFQh3BbBfN7DN/sLMlBxfS0ThmXq95SzjU4mHK4NYN986mvFjDuwNsFMLlb5PhPt2rk8J+xOiVwclWwTeUK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhJB3/lWZZRQctlrojxFJnja/pamYtsg+N1waXESw78=;
 b=XfDFy/sjkXgatNJvaTMg4okuVlKs5pRKGkd411aaPP49RReOmX4aJ18xkiRUtGCVM76qUN5VaMkLNgsfEOeKGHefgV2xxX12ngRDgTJrnmnNOeOOZSK5UBGYKKLSci95caYbp3BAtjA1JVNwGP4xJKx36bCYyQ8Ghkm77QTV7W0=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS6PR04MB997317.namprd04.prod.outlook.com (2603:10b6:8:462::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:19:24 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 04:19:24 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "joel@jms.id.au" <joel@jms.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] Improve modeling of the Atlantis UART
Thread-Topic: [PATCH v4 0/3] Improve modeling of the Atlantis UART
Thread-Index: AQHdW4t0NL7zqK0f0UuaKWpvJeaEtbb8b0qA
Date: Wed, 14 Oct 2026 04:19:24 +0000
Message-ID: <b0d4b87d708c9c9832bfe5cd93413046a8c2f772.camel@wdc.com>
References: <20261014032346.732257-1-portias@oss.tenstorrent.com>
In-Reply-To: <20261014032346.732257-1-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS6PR04MB997317:EE_
x-ms-office365-filtering-correlation-id: d5757a3e-8e95-4f24-fc60-08df29aa547f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|10070799003|376014|7416014|23010399003|261009223027099003|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: AVm9EWbnIm5ir+ayxBcq0oG38VvGPfIgTwFtIfIhPfzsH+3nbojS1Cd+fBUns0Ii+z2x5J4sCbL2fy8OBh4h94m4hE7HWFY3JzRyGUjQn2VkTClhoO3I+3ZvRyrignAeSzCvZSR6UPs/oYJQVDwMrRUBpnzaAhEhLF8F/KPaXztHE7DnBJouai68YiWljNM/1D8kK2J8JDip4Nc+dvOuNxCUPDlPcVNeOzj0+Y+OuwJs2f0HvhZF5vqj99EJ9KsiY7mZvFInr8A5f+EGvXHKs04avZIlM0KzGYbow2juPe7CHtXCrN2UZMEEVZLqLBiwOL1YSJTaUEW8ulJ3wXKTxMWY+2Nfh3kiuEId3UwUccSdWwm6742A5Fk++NE89KFgQ9dMkDxBJneQDMf2sat3GEXBDzdlY23HJQWCF46CfqgEXWiM44WeT/r+/4s+txs1MgEzCZUIZZfcOKSoOcfYgzYJ2dV9qMXJNy+4eUqFogkDUMDw//xMfYPzjeNsvcg+k6nrZtyVBljmx82z4priHDX0zn9qNnOeLUzRoKMBbRnSPZINjNXpi5A9hK0umU5ftG6wDlBRC68q4EqNLxRipG6uYURk5fWpSKQ5gUhsScOkxwBNuptPRNKgh9fU8y353AS1xSxlK6OaiU7Wo4nJnzRkSdt2dUKo3XOVkbrLRV2yfBWi6DGz31SafdBW1qxqpN8CtL9LnoZmuqg2hvExE8A3DbF/1HZBmdixJOIg1Do=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(10070799003)(376014)(7416014)(23010399003)(261009223027099003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXBVSVpyUDhob1FRZVlxYjFYeVVldGs1Y0l5bWdwclRkM3huTEZUZ1FsM0wz?=
 =?utf-8?B?aWthSTRSSTRoMXdDSGhjZVRjZFVuL0h4alMvMFFUYlRHVERWS2U4Z21DM1Q2?=
 =?utf-8?B?bkRXUDRhemlOM21Fa1E5YlpHdHd2UHpkT0FtUmQ2QjB6ZVVTOUdzVXJtaGdK?=
 =?utf-8?B?aTZjRG5DNENhTTUwNlkxeUNMVWVnMWcyRlJZSG1WQU83U3ByOU1KNnREMWcx?=
 =?utf-8?B?VGNmaHlvcGgvR3MwVXNiU2t2QlgvQkJ0S09qVy9OUytLalloRkZIMnpOT3c5?=
 =?utf-8?B?K3gvc0I5YUZMSmxXVXdicTRjU2dHK0ZCZWJuSG43S1RJTFhVUG5pNTZrK1h4?=
 =?utf-8?B?YTdaM3h5bkduV0d6amh0V3M3VzJHOFFwNlV2dEMxbTVaamtIU3pyNnljM1ZY?=
 =?utf-8?B?REY1WHV0emJDRXI0dTM5bXZOREkzMklDWFdqSUozYUgzZWc2eDlWYU9ERGhX?=
 =?utf-8?B?b0VKT1VLOENNMFpiSFlFWFhJcHgxTE9ZR1lDWDU0MittMXRSc3dxVjl6UkNp?=
 =?utf-8?B?cllGRG92alpmLzNMcnhXZnNXSGE2UFNGanluQW5PMEUxbWZBQ3pnVFpLMFpH?=
 =?utf-8?B?ZXpmNFYwM3V3WTVveWllOVB5REFBVGlvdXVhMXhnbmpIQWY0bWp3c2VkMGo5?=
 =?utf-8?B?Qjl4YVYrZ0c0em84Q2NGSHpsbkFTamNNajE3NSswK3BEMkw2MlU1YndHSzFK?=
 =?utf-8?B?TUt6Rmx0MEprMnZYMlpFajc2UWJrYTBBWGlPZjI2dzZsRkdBcW40aFI0Z1lF?=
 =?utf-8?B?QkVQeVJ4U2ljZ2hmRmcyblNYbTkrUm00aVNSbjVCMVNXaVBIZFBYNDhoU2Iw?=
 =?utf-8?B?U1pIMHd5c2czSUtUMHFCenRFWGt5WDBOZFlTajN0dUpVWk82YjZCUWNjOEVY?=
 =?utf-8?B?dERQN3lnWDdITVc1ZURCZXA5QUVndmhra1ZFaEhGNExpR3NtS0YwbkEzSkRn?=
 =?utf-8?B?aXRiZnNLRGExamhlQksrSnZzTS9xNk1MVVFGeU1wZEtqZmFsYWVpd0VKcmtm?=
 =?utf-8?B?WDlEc3owL0dRcE9CN29DUk4xaUxGODgyaVVtdVVzS2tpL2pENStRRGdaKzls?=
 =?utf-8?B?Um96Z1RSbVFBVWMzRVlXL1JaZXEyaWJpdDR1aWlpZTJHbUJmNTA1ZDBNZUh5?=
 =?utf-8?B?cmI5Mmg4NmVhcHM3K1A2VC9wU3hTWVBkdHEyNHpzOUw5U2RtUlp4UmdsQjhK?=
 =?utf-8?B?NlBjeGQ1TTJaKzR3VTdRSGUvMHptQnAxYjFGaytpYk50ZUxXR0Vrbzk1cFB1?=
 =?utf-8?B?MFBJaEQzMmM3OFFmZ0kvbmI5UEFkeHRVbmpkWGhCakR0aE5RS2tTeVEydnhM?=
 =?utf-8?B?QUE2RGRFS0hYNVV2THRyS2lDVFpxR3hqYy9nVFpvTEpOOXY1WW5qK2VRNlc3?=
 =?utf-8?B?ZDlyZXY5OHNQM0RaaDNaSWF3YnRvMnRYUmFDdUF5c2RySkgrNVRtYXJybXNp?=
 =?utf-8?B?aWdUWEJGMkEzK0g3MkkxMklrYjdhWnE5UE5UU2EwQTR6V1d6TUhrZG4rTHFu?=
 =?utf-8?B?U2VlWUJlcC9nNzgvV2c4QjFIQ1EwMlJxaHV0NGQ0NlJQMmdwR0d0STRaVWZs?=
 =?utf-8?B?ektSQUVWZlpBTmNDZHN6MExQZDNsRUEwUUxXTkR1NXpoVWh6b1haUjc5YW02?=
 =?utf-8?B?MFk1Q1cvMTFVZHJZZjhQam43bjVWYzFDaFZYeW56V2VTSk1idTF3OGk5bFc3?=
 =?utf-8?B?YzVMdTZkVVB4eXNHUGFyY3FJaGdvSC9vYWloaWk2MnAwSjNGUmdIcXpYZ0VO?=
 =?utf-8?B?RFpjSFlTSmdYRTljTGRwZkROeTZtY0FpQk9hd2tnSGNhZHUwYURKWUp2Skkx?=
 =?utf-8?B?Y29HV1lWSEtTMlN0RkcxRk5PTnZHS3FoZVY3WkptVzFIYW0zNlpRQVJjKzdT?=
 =?utf-8?B?U29teklCYmk1Q3o4V083OXpMS1JFRXhYODY2WVNnMi9rcjdSdFNCZ3d2eTBE?=
 =?utf-8?B?cTcxTTlxMzZsOTVTZUNMOG1VWnN4N2JHcUFiUmlGZTQ0cmhCa1FqZFRmckly?=
 =?utf-8?B?MjI0WGMxb2U2TEk1NzIvS0J5bm9hZXZYS2Q3akljSGRpRFVWZnU1U0FLd3Q5?=
 =?utf-8?B?MnRqbUI1UHUxYmRPOXR4aGJxK3VhZi8xSG14RjZJb2N5WXhxWDVLTFpEMXJY?=
 =?utf-8?B?aGhrckF5eUVPSXp6ZWlIZU9PUGFpbkRWU3RGUUcwcGlTd0hZQVdIV2NPdHdo?=
 =?utf-8?B?enZrNzBNSTg3Tkcza2Q4WHRtSTlCVlRlQXRDTVlWTFZvYjY4ZDdpWUNXdXNE?=
 =?utf-8?B?alBWeEFaVFBaUkU3bmtMRzlLbE02WmdHTTBMSERZYkxFVld6OHdyZVQxeE1l?=
 =?utf-8?B?b2JwejNPWC8zb1lTc25SUXpnY0hqdlZETWZWbW5FdGxwWDJNTnZSZkJIRVBs?=
 =?utf-8?Q?cTyNS8oNoXgfw/aYgeo3W1aZBeGnhU8w1UWnZhmykkNYq?=
x-ms-exchange-antispam-messagedata-1: QatlYNKPFvYR5p9r44NuWiDyCInFMtN018Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25E2AB42BD1BC24AAE675BEBFC57E2CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rx9IYlMl2icMc2synMvAEV8j6F0sYa8S8nAqIYVEbWn5xfpY+egExVJVU1h8kgdDnYHgQ65KON48NFUd+lkYPRQjjM6NwwryGzo1PQKO/fqmhF3YfLPVbAsJOUZzmtu1AkwfqKVIQuQhj7649UD9kVkg9GQaVml27AnqbaL5SGUsUdqbLzpjP/iLqh4ERNdQBr7vC3qwNqo3ZFOwvZ2BOZs9kDOnsoLsWt2vI+filDd48ZKm47IMFQf0eIQuccq4XQPKlBzOzoFeIMhfvtElk0djqhSAPoyAaxGch7blpVGHeOUMFWhMVWPNdimTw3W7J5nZPpyx0F7TkhRKAjL8jQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6eg+Uv+cvG3B/rMITey93SweGnTJ/2hVdjZEEUFsehIFV1bmepCMHDDjcN8FSX8FusHTwQBUDRtu/3OslVc++aLrf7PrdE5OS9BUGkRMDFuhobiGyrRbOcbvPDGM6dfUoqgtshHDumQXve5XJV1yeWZhXz/570izXK996T6u0ANEKMGulLhqJjKNzPEsf5lltJVUju1+4n8BWEZXFHgH6CGarY1RtD9Mv6BzPx48tyhHaCEjrzSz6BKJNACC24K0NgHw9MaHdaK7psDpMgeEqrylF05sYTvOTxi1bw2P1DMH7W4sgdlx1kga/Cb3G2aktIDA9DQsOJQx2xoM4F+64dqWT0Nlgc/yGW666wlINB8bpYg8w9xwOPontYNxXghDb+mxMzbSvm1X1Op8ir8MOnMKwyNAEorPv5OY9xUlqfM0wAgWBmi9jvesmsw8rz8OWt2uVi8FRmBRD2kB6atQrNblUdCdY0Ci8j8b7d6OPuZvzSERjM9X4kwYCqdb74uQ/SPQwZ+DDVYzf38HsH5L4eJWTWC+gnJMiegrCI1fx9J+KPJ3df+8CLsDhnrMB4jrXBQhTbyso1101QroGY0lXqDSME4ufDr7DOv0gjzlVAWnAggtyvT51Te3CQNOU5U8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5757a3e-8e95-4f24-fc60-08df29aa547f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 04:19:24.8468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uhr0ORSF4HpmolrHHJd0gZdC9SrHh5Aq1NM0PwwT2C1p6Mo/Q7MXsH46tdF7oIQkNCShJC3LVqf4eNY6YJzoNAdkIEl5J5voO3uya/V6NHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR04MB997317
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=740cf4029=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTEwLTE0IGF0IDEzOjIzICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
DQo+IFRoZSBBdGxhbnRpcyBTb0MgaGFzIGEgRGVzaWduV2FyZSBVQVJUIGNvbXBhdGlibGUgd2l0
aCBEVzgyNTAuDQo+IFByZXZpb3VzbHkNCj4gdGhlIEF0bGFudGlzIG1hY2hpbmUgaGFkIHVzZWQg
dGhlIG5zMTY1NTAgVUFSVCB3aXRoIGFuIHVuaW1wbGVtZW50ZWQNCj4gbWVtb3J5DQo+IHJlZ2lv
biBiYWNraW5nIHRoZSBEZXNpZ25XYXJlIHNwZWNpZmljIHJlZ2lzdGVyIHNwYWNlLiBUaGlzIHVw
ZGF0ZXMNCj4gdGhlIEF0bGFudGlzDQo+IG1vZGVsIHRvIHVzZSB0aGUgbm93IG1vZGVsZWQgRFc4
MjUwLg0KPiANCj4gVGhlIEFzY2Fsb24gY29uc29sZSwgdWFydDEsIHJlbWFpbnMgb24gdGhlIGZp
cnN0IGNvbW1hbmQgbGluZSBzZXJpYWwNCj4gaW50ZXJmYWNlLiBUaGUNCj4gb3RoZXIgNCB1YXJ0
cyBhcmUgbm90IGFkZGVkIHRvIHRoZSBjb21tYW5kIGxpbmUgaW50ZXJmYWNlIHlldC4gVGhleQ0K
PiB3aWxsIGJlIGFkZGVkDQo+IGFzIG1vZGVsaW5nIGlzIGFkZGVkIHRoYXQgcHJvZHVjZXMgb3V0
cHV0IG9uIHRoZW0uDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjM6DQo+IC0gRHJvcCBtYWNoaW5lIHBy
b3BlcnR5IHdoaWNoIGNoYW5nZXMgdGhlIG9yZGVyaW5nIG9mIHRoZSBzZXJpYWwNCj4gZGV2aWNl
cyBvbiB0aGUNCj4gY29tbWFuZCBsaW5lIGFuZCB1cGRhdGUgZG9jdW1lbnRhdGlvbiB3aXRoIHRo
ZSBjaGFuZ2UuDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjI6DQo+IC0gRml4IHR5cG8gaW4gZG9jdW1l
bnRhdGlvbg0KPiAtIEZpeCB3aGl0ZSBzcGFjaW5nIGlzc3VlIGluIG1hY2hpbmUgaGVscCB0ZXh0
DQo+IA0KPiBDaGFuZ2VzIGZyb20gdjE6DQo+IC0gRHJvcCBEVzgyNTAgZml4LCB0byBiZSBzcXVh
c2hlZCBpbnRvIG9yaWdpbmFsIHBhdGNoIHdoaWNoIGlzIG5vdA0KPiBhcHBsaWVkIHlldC4NCj4g
LSBVc2UgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmdfYXJyYXkgZm9yIGNyZWF0aW5nIGNvbXBhdGli
bGUgc3RyaW5nDQo+IC0gQ2hhbmdlIG1hY2hpbmUgcHJvcGVydHksY29uc29sZSwgZnJvbSBzdHJp
bmcgdG8gdWludDMyIGFuZCBzZXQNCj4gZGVmYXVsdCB2YWx1ZS4NCj4gLSBEb2N1bWVudGF0aW9u
IGZpeGVzDQo+IA0KPiBQb3J0aWEgU3RlcGhlbnMgKDMpOg0KPiDCoCBody9yaXNjdi9hdGxhbnRp
czogVXNlIGR3ODI1MCBVQVJUIG1vZGVsDQo+IMKgIGh3L3Jpc2N2L2F0bGFudGlzOiBBZGQgYWxs
IFVBUlRzIGZvciBBdGxhbnRpcyBTb0MNCj4gwqAgZG9jcy9hdGxhbnRpczogVXBkYXRlIEF0bGFu
dGlzIFVBUlQgZG9jdW1lbnRhdGlvbg0KDQpMb29rcyBnb29kLCBidXQgaXQgY29uZmxpY3RzIHdp
dGggdGhlIHJlY2VudCBQUkNNIHBhdGNoZXMuIEkgdHJpZWQgdG8NCmhhbmRsZSB0aGUgY29uZmxp
Y3RzIG15c2VsZiwgYnV0IGl0IHNlZW1zIGxpa2Ugc29tZSBuZXcgY2xvY2sNCmluZm9ybWF0aW9u
IGlzIHJlcXVpcmVkLCBzbyBJJ2xsIGxlYXZlIHRoYXQgdG8geW91Lg0KDQpBbGlzdGFpcg0KDQo+
IA0KPiDCoGRvY3Mvc3lzdGVtL3Jpc2N2L3R0X2F0bGFudGlzLnJzdCB8wqAgNyArKy0NCj4gwqBo
dy9yaXNjdi9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiAr
LQ0KPiDCoGh3L3Jpc2N2L3R0X2F0bGFudGlzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgODMg
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gLS0NCj4gwqBpbmNsdWRlL2h3L3Jpc2N2
L3R0X2F0bGFudGlzLmjCoMKgwqAgfCAxMyArKysrLQ0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgNjEg
aW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQo=

