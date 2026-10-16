Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E09ACCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHXB4-0001WF-GL; Thu, 15 Oct 2026 21:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXB1-0001VK-Ik; Thu, 15 Oct 2026 21:56:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXB0-00010Y-1m; Thu, 15 Oct 2026 21:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792115771; x=1823651771;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=T7EPBpLdu7/Ci/4w/PHc6sa6hGlarCPOaV1d0lMLUes=;
 b=RisEin2jZKXAvqXowkx8I8ebGQfqt37oUqB4ugC65pd+KxWMvHW4ECoJ
 xGcQM74DJ3/Gf1w4kgh2eEF9KSIr9aKc9BFkX0zwVogSbB2TZ/wjuQG3n
 FtBtbWN7K9NEBftDIXIf1dKTyZUwWvzNhUvXAThdK226q2jaYml9UeEq4
 G/CToQ4zohOd5SHkBV07LzlTLA/hqvqmNrNNqRr0xUi6rqcH9s3bYJ0If
 3Gtktb8LNM1rWBqbq44t4AerHX7Tm6+vYBwsfo9dYljkK5hQcdv50Mg5a
 rUt5odxBKal4pi4IMsRy2NVdZuKfPshmADk+NA/ugFUlP3go/S6csIiVB w==;
X-CSE-ConnectionGUID: BeWb7/8mSCOYxpnrDCQNmA==
X-CSE-MsgGUID: b/pRYkz6TSWYbAIGFnYE+A==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="159177352"
Received: from mail-westus3azon11011031.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.31])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 09:56:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCoLYW4ZUuEbTuF4wP3QmtoY0m9YYkgzqS4GJmSVYEK0UEoXw5+eqeqg10Ez6O9IOB8uIsjmHtAZktlkqTjTsGRk1wUfgyghqYNOIYfo1qLS3Msht1OkI+wcvSG3GCfcPCDeIt65VMouWfteOBp0n13wrz5tU4/ib6lXRXn16xarsUFhY/r6vDmMJE6AnS4aiu97SToRbn5QV0RVoV92URE4csuxIkc0MgC3HLZ5qnBmnpDLp5B0aCZhvwSiT9YcBnxzTjZEw+0a+3CmUsm40bXVKPwNDjWLag2MSeEsze3qzO9gM5E6sv3PgkNJEBzWRlmx8gdkL4hMfrSaKSI3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7EPBpLdu7/Ci/4w/PHc6sa6hGlarCPOaV1d0lMLUes=;
 b=dUVh+iBcMtJsP11D+dI5vwN2r+iAAVqGJuwl/JwyJlbReZzdghXF4VVevGINPqeKtU3kiglQbqUKxV4LypTkGxoI4uE3fADWT2U0pINJleUjL0Qo4kWyZpz1oDiwn/DgPWAXNI/Ofn+U9wWLG0Y1Mocvyj/XWvK6lbpb2qZl3zJeeQiYcA/N5MXOUY569mqHNdfh/bmm4hUmsa1MyWJMprdKsOD2hJKH92gDIZ4GKze6eGL/2GZxSwiMm6MajsMvdXsMzScdVssQ3amPBty4yhrjsvW/iMbZMacJsBFzzcMXrDok3mwP+X3HQGDMW9tzx3P/XCipiBoqkIFZOwRbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7EPBpLdu7/Ci/4w/PHc6sa6hGlarCPOaV1d0lMLUes=;
 b=KUY18uwo2qtmysEJIJ8Q+K9TlSou9tVnnDU9nLRb+ni84VWzx3GY2xDJeP9UOPc1XYOmsKpHyF4KzNwTz0OMIr2f/o1HZRCmbNljV7pCMqQuo3M9KmuYJ6yDMzbeargvqmflnA4+0T08Qtlqj+9+4G6HzX/kknRHzPrNJ8XGW+Q=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 01:55:58 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 01:55:58 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/5] hw/misc: fix calculating output address overflow
 in k230_decomp_gzip
Thread-Topic: [PATCH v2 1/5] hw/misc: fix calculating output address overflow
 in k230_decomp_gzip
Thread-Index: AQHdUnbDy6pYHvtJa0uv1tvRQOIiBLb/fgqA
Date: Fri, 16 Oct 2026 01:55:58 +0000
Message-ID: <e1b3a725b785215b5c3bf1e90d38b07139361ca0.camel@wdc.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
 <20261002140245.30214-2-dingtao0430@163.com>
In-Reply-To: <20261002140245.30214-2-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: 1f512b06-e771-40df-1698-08df2b289f4f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|19092799006|23010399003|22082099003|261009223027099003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|3023799007;
x-microsoft-antispam-message-info: YgGz6miyFUO+SJbasI2w2yFTadkhzT+eqD52B7/fWzevfpqUcyaygFwr5+pt+GB5EnOtXRiB4hN9wF6p5HfCxyF9C4CWAmwm+bVyEHa6ai526mesHgJBbBfXKtD9S1Yr7/rnlrruL+G4+QXBRP4McmwyHhteVdvKlWnLqRVz4gEgCSwqzD3awKmpSCnObTfBzWmfKWIDlDEr9KKiIuqkSmC7okobVZE2RuDny9W/s4C8Sk6vWThtx2/5ToaBpmg0ZqQgKnI6N0vc0cVEyQ2DHnhX4KP2v0KOVp9HiZeohEChcazz98glas2d0N3R2PW3gd1n8lrBAvbVg7Iw7sx+IkNvBr39NwLaYV7sR0/N0K4/E0mMUub8sU58R9njfXdkb2f59ilx7jeUn3FeadabW925R7SnTqncbPeY+Hbv1q4DwoBTa2fsBZykolU2s/V9LJykvomRBlYg7lqxcDMH6sTCKnqj6ZBESbpWQCYd2R5wJS00SdUr0+a/4nqWvTkrZ3GXj68NDfJrYPa6fAR9KFmuKCkqfr9073Y7mgrDt9D5igriDXuRTe9o6YxNbkJ0QLig1+rW6dTQNQ1dXAlIOPyJCz7VFJOR4DZGkMdNX8uD7tYqGEO/NwYKzIrEvtImnnBCb/HrbPDhOZxrdr7KzBI6cVqLvTtVWzDCgL6tG+7wAz1/rpxzI7vETf2k8b+vLLSKDfWEihwspBHGB+VIILLp2S5wFpxpSCW2j7DSe6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(19092799006)(23010399003)(22082099003)(261009223027099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b25FYkVsWERRa20rbldsbzZOQkNLcSswWjVzSVFYY1BnM2lSMjgwUU5IZGtL?=
 =?utf-8?B?NExLeE9KaGl1bHcrNlRZc1EwNUhkaEM3Z0laMUdNSzhHZlc2d3lMK2VFcnR1?=
 =?utf-8?B?N2p1dUI3WndBOEdNK2pvUlBaM3lpTGtIdXRLeUs5eDhiVFFtNHlhcGUvUmdB?=
 =?utf-8?B?a0xVRFkrOXZsckNxRUM0TzVpNmhrR1FkZ3ZOWXZkaXZRNXNFOUFHakhTclhG?=
 =?utf-8?B?U3hscWFGaVpScEZRanZyM21Dem5MbWZMeURZVVVhSWF3V2tEWnlldVhWTC9U?=
 =?utf-8?B?VUFJNngyb1R0MjlFeVduU1FXTkRQZFc3NHBWMkhWSG1MNUxXVE8zK0hSWlAv?=
 =?utf-8?B?TDRaM0dWcEo5NS8rNk1RWnNzek50YzdheFA4eHI1bDQ2TWhBbjZKbGp2QzFy?=
 =?utf-8?B?bGhFL2VqNCtWaFgreHpCUkgydzdtR1pnWGp0bXhERThQajkwZExqM1hxNkoz?=
 =?utf-8?B?djQwbElIYVJ3Z3dZTm5HYnYxZTBINkl1L0JVU3JqZUhRQWRkcmw2dWF0YlhM?=
 =?utf-8?B?Y0srRHEzKzdpSnhDNmgvcm5sd3hzbG5HUlhtWW5TdjhiSklQaU9vU09FSnVy?=
 =?utf-8?B?UGd2ZEh1WjdoWm1uRXNYK3Mzakg5UUtSYUJnU2dMTVNqWmFEV28xWlJxUVNi?=
 =?utf-8?B?Z1Q3aExEd29WVVk2TzdvSE0zVTh5MEhSOFJpYk9LVE93a1Y0ZGNtY2RzZDlR?=
 =?utf-8?B?bmY2YXZFRkIzd1I5MjY0d1hyakF5ZFJhdjdXa3VNOGYwV3NlaEFtaWtXM0VY?=
 =?utf-8?B?WlRucXFpelgrcXFEVlBZQy9WYnBUS0FXaFFqMWVYMkFtQlRtQ1dtSHJ2dHBY?=
 =?utf-8?B?MDd5Q0pBaDdkdGl6elkyazdOUFhsbFp6R1FXaEZTV0dEcnkvajA1T0JvbWUz?=
 =?utf-8?B?QThlTEREbU9nZzZSYmZNcWNJbTA2VU1GWW5aY0RZc29NYTRVYkpJWHBtSFdu?=
 =?utf-8?B?ZG11dWJ0K3ExbUhodXZhdS81UVNjM09TSWEyZm5HdEhnTTdXeURSL2dBZlM2?=
 =?utf-8?B?Y3VicE5hdFZDN0diSE5SbGYvNmc1ZldTMkVYaTcrWWVDQnZHYklVbDBNMTRn?=
 =?utf-8?B?cjVGcExFQXRhbTA2YVNaaDVzQzFqT2JaeFRGSFFuSGRJWVhpaE1aZEE4a1NE?=
 =?utf-8?B?Z1FMU1Z5a3V5eFdpS0tYSEdoSUFIS2dHbU55bXZEbG1nekhtRXliSWpSSDJJ?=
 =?utf-8?B?UkpLazV1NThWWmVYRC9ONEQyZkEzUUdwRFJ5WWVYQUFWUkVucWRxS0o4Sy9W?=
 =?utf-8?B?UWtuVDVnK0VDaFk2K3grVTExMHVzb1JpRFdvQndHWkdMQUt5WXY5YTlwUGVX?=
 =?utf-8?B?UDhpUnRMdERjeVdrYTF5VnFEZ3ZxUEJoZXVTK214bHM4enFja1BoVFJWRXBS?=
 =?utf-8?B?cmxaV1owSWNoZEJJSGpPM0x3ODdPUG54aUttQVhBRUVkcUo0YzRNZTIzTFhY?=
 =?utf-8?B?b3owV3NDTkJDQmZBa1daZDN6WWVPNzl4MWFVNytCUHlTS3VGUW9PSndxUHo0?=
 =?utf-8?B?aWcybWlNV3VPMUlONFJCdy9NcVhubnpnbWxjVm5zQVZVYlM1cEhuNXo2YXJZ?=
 =?utf-8?B?YTR0ZDhreVl4d2J1K2J1VVlYQTdSK092TjlJUmovUzBWbGNiTkx2RXB6UzVG?=
 =?utf-8?B?TUplaTYxakZMSFNzTFM1cjZaak9WWlVKQVRjSldhM0dBMzcrblRxRS9IZXBF?=
 =?utf-8?B?QmpnWlJFYXpKdkxubWM1ZzZnMWV2MmEwRXdLV1lrWW1JVEtuZmYzNGtCQitV?=
 =?utf-8?B?UUtOWkZUY1JDbkJkSGpIdllnemlwTElsa0JIRHMxajJVYUd5RHFNbDhyV09D?=
 =?utf-8?B?aVV3ckpzWE5TUVJwdHd6aklDam1kUElmeEhJa0hLc1hybnJzeWxZV0duQldi?=
 =?utf-8?B?UFhXQmw0REFQYVZVZlJ5UE9CTXZGbC81UTA5RUlLeUZteGttUG1NTkdFMTE4?=
 =?utf-8?B?WVR1VFZXNmM4Rmp2T2ZMT0hvOElGcDJCNHVUTDZqRGlxTGR3amVwcnZOUjBL?=
 =?utf-8?B?M2E5YVBTb3NQYWY1alB4WGx2a01LRUpJb0I5WWZTT08weHdFdklQVmRLOHlS?=
 =?utf-8?B?cEcwZmtVWDdEVXJZVTZydW5jM3c4ditVMGEyalJXTmNqczhxejlXY0hrQkRl?=
 =?utf-8?B?NlRveDllaFlPT2xSRStWb2ZYVmVNWnBsUjJpWERoczQ1aFJabjFqSC90a0hU?=
 =?utf-8?B?bWtzYTJEd3FQUzhuM0hEb1pRNXFPVVlNU0JHRVh0YkZKeUVJWXZGM2tVNTha?=
 =?utf-8?B?NEZjajBsUVJpYi9RMUlOazlLOGFPNkttRjB1YVpud2lMWnV1Zm9udXhGWjdN?=
 =?utf-8?B?R3dWOGZRZlpnaFVLZnFuV2tOc2hPWEtKNUYyTEd1bmdPMmlWZjBEN3B0SnZK?=
 =?utf-8?Q?rsEG3VmGr/GkDCbwUdKl3y3acMiKdO3jfp+oB/2mnu0Kp?=
x-ms-exchange-antispam-messagedata-1: ANjA36y34zap7e2ebgBaAkqrfhFlmfr3m44=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9598CEAB756AA747BF665B75DC155A54@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B5uO7Yp9taDsFqirHaI80ip5w3UeY7KJXe86eWmjarHOR2lEAAZnnp1Y0OoJF1SLGjg0UHYyNOX2oDEOUF/o+imOAaT1bhH4sNRnWRGInO5xhm2i32xhvXql7LmimPDWBap8pIMLjgWmbIMmsyieFqZnkxQ1jJjB6YrDTTKy6mEEAutIeUktnrDIqFsGPqtOn0VH+tcbisszeZ6TJSSMEt8DfCFyH6YK0hnhJ0fzrxGEe0i3DFzxHdh7iNRvP3abNjnTzg0bwEMo54yi1QWeF+f4u3q98vnryi5AThgEM0W1x62Iq9RkkMn25B8iXgmioAcMWT1DoQT+hqjrU7yw5A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fBvVI+qUpcRhbjic4Yy/0SK5bW8TmZkzhIBEnz7We7x4y1XWfudUrJGWFch04ubrjZMYFs6OaOU/QW6/Js+G2UOGc107aJTm3dJdjHSJvAN1Q89+mktbImEP1+u9dLw5eqo4k6ur/A8d9oPaKWnHFd4rfBmKI228se5f7fHG6CJBspzK217ldxmd9k3dN+JPGdPEFHNQ1995UA1pHA0NteKfNONr5OCbd9f91ZdA0G4rHNDUDZZiwaBztLKwud8Ku/mUmA/5AugX/NPA8TWuldYV2IcRQFY63f3CPMFFQeU+zDvp7RSEp+Q2sSkz4/fdmJmkS9CvVzK6O0Al7Vzko53jZTd6fXIv1nS7IOFlG0Oxpq0tepwMXlpCU0s1DV8NqLBTcbDnCra1z9R2zE0LyUgg8oeXPZARs2esjsoITQd2I4afCMlZeuqii+OORuqMcLTW9auNmOsiJSmeIKxJXAMZPCiSJs3IT89c0MsO02Rh+T4+Aipx3oDqGpY/tPFC4R2evrBUJS4JQo17UAT23PJI/WK2PB0b4BDkuVby5dHH7qmMG8F2wmXZxYAvzbe7x7CrMqlXstCvTaNmzLpvW+q86UbZcSGPj7qDC2vsz3bcEtjD7/qmHHHHKp+faMof
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f512b06-e771-40df-1698-08df2b289f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 01:55:58.1279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulOHqCnAVYMZXUTIyyrLe+XoLvAXNZm6zUZGFuv9GnJa6NqK4rNAGYnafKbEMkSyhPs4grLRVcbDSmUFz42oW/qTqn+gdIjmx6y0aKRTzKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=742cbab99=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDIyOjAyICswODAwLCBUYW8gRGluZyB3cm90ZToNCj4gVXNl
IGh3YWRkciBmb3IgYWRkcmVzcyBjYWxjdWxhdGlvbnMgdG8gYXZvaWQgMzItYml0IG92ZXJmbG93
Lg0KPiANCj4gUmVzb2x2ZXM6IENvdmVyaXR5IENJRCAxNjg1NTE1DQo+IA0KPiBSZXBvcnRlZC1i
eTogQWxpc3RhaXIgRnJhbmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBUYW8gRGluZyA8ZGluZ3RhbzA0MzBAMTYzLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFs
aXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0K
PiAtLS0NCj4gwqBody9taXNjL2syMzBfZGVjb21wX2d6aXAuYyB8IDIgKy0NCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9ody9taXNjL2syMzBfZGVjb21wX2d6aXAuYyBiL2h3L21pc2MvazIzMF9kZWNvbXBfZ3ppcC5j
DQo+IGluZGV4IDBkOGEzYjJkMmUuLmFjMDZjYzE1NzEgMTAwNjQ0DQo+IC0tLSBhL2h3L21pc2Mv
azIzMF9kZWNvbXBfZ3ppcC5jDQo+ICsrKyBiL2h3L21pc2MvazIzMF9kZWNvbXBfZ3ppcC5jDQo+
IEBAIC01Myw3ICs1Myw3IEBAIHN0YXRpYyBib29sDQo+IGsyMzBfZGVjb21wX2d6aXBfd3JpdGVf
bWVtKEsyMzBEZWNvbXBHemlwU3RhdGUgKnMsIGh3YWRkciBhZGRyLA0KPiDCoHN0YXRpYyBod2Fk
ZHIgazIzMF9kZWNvbXBfZ3ppcF9vdXRwdXRfYWRkcihLMjMwRGVjb21wR3ppcFN0YXRlICpzKQ0K
PiDCoHsNCj4gwqDCoMKgwqAgcmV0dXJuIEsyMzBfREVDT01QX0daSVBfU1JBTV9PVVRfQkFTRSAr
DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5vdXRwdXQuc2xvdCAqIEsyMzBfREVDT01QX0da
SVBfQkxPQ0tfU0laRSArDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAoaHdhZGRyKSBzLT5vdXRw
dXQuc2xvdCAqIEsyMzBfREVDT01QX0daSVBfQkxPQ0tfU0laRSArDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcy0+b3V0cHV0LmN1cnJlbnRfb2Zmc2V0Ow0KPiDCoH0NCj4gwqANCg==

