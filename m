Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3086ECA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC8q6-0003IV-7M; Thu, 01 Oct 2026 00:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC8pt-0003I1-AV; Thu, 01 Oct 2026 00:56:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC8pq-0007eh-Ir; Thu, 01 Oct 2026 00:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790830559; x=1822366559;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yKl1uz9MwPnEWHjG+IOBa4EG0hIEKkebSJi43wtuHIc=;
 b=fy5IvYbuYm2NaKbL31f63UXRYadxLr0cv5MiGLBOv35DXVHVYQGBeOIP
 rVDB27riAYJRaBCuw0X395Ls7SkgkA+CTr++jA0JAq1pkZAW9HyVU8D71
 IjeWvfA92vcc/JzlQLjgcnOf6SDSjeeDDI25DKXpePpv6ImTZrfjSv8G3
 4Yt80cv9SxBvluR2wkTJzt6YJQBLljG0QIFgs+2691ZADRSbL2vSx5avk
 U9sHF3HT7FG4JJ5bhEKAtmZ+e19542Wxy0qJvluLQi2iBFkH56dUiWzj5
 KnfTJhoGfPsqjSiEZHYc1CiGAwkV2OfNvgRMNWS6aE/D/qk84OV1N0oPt Q==;
X-CSE-ConnectionGUID: 5Y2rAVgvS6evN1iMSqGlRw==
X-CSE-MsgGUID: 0dLBhQevTqqfckroNk5LKw==
X-IronPort-AV: E=Sophos;i="6.27,134,1786982400"; d="scan'208";a="157008812"
Received: from mail-centralusazon11011021.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.21])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 12:55:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9cdyLtJFmkKlHRRO7ZxM6L5Z+RjqGmavmfM2j9+/BnrKjL2oAUUlB1W3+1KKv0vmlR+dFh/yMUV00E+3es50T/D70RuhvhjDdcVc7CqHRVb2EE0aRk2XzEKum7MPyUfuQznwf86hWRyNNWkm3yMkoIZ4iO/5kU2laRz/YPK0jMmWacEXygeB7ZY5gTm96jZiC1zB9/Uz9OAenxjpmTLiorkR5x2dUpjck9FV/rRnwlf9/FIHDinAAf+abmCmFzNayj3yFzilAhILe7xko498A49BhYTCuPgmi2ToE9L3iYS9KqFczw0xnVXOhqwlu9kyeJCsH8vXQdn01H00zjR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKl1uz9MwPnEWHjG+IOBa4EG0hIEKkebSJi43wtuHIc=;
 b=bTa37nP14BUpRuiJwgFGleW6nJP9/VoAY7i6xiiFQu++/IWy1wAmjs+TC4V/vT6Z+rRYXzDnc152V3JjOvsm/4DTY/LGN6+wjdrwvJptAB/3vwWfjFrWug1t6Nje2B4UQoUZROfwbxrubWGYnoiLc+OY/9GGG5vXOwr+K1sBjANoWY4llxjAoDo9WL/7gIXNu1s3gOoQbpVgHPW3027CqDmYk/YgJCWqe0yYPlBOuRx/MsORMsl3wUPNXul8VIAqhcM3E0FKgosFQks3PquEIHEJDtVqX/k7uyY6YeJt8uHtMNkfDf4aO3NwWOfEYD2bjrtoPuLFq0BKDCuJLYXFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKl1uz9MwPnEWHjG+IOBa4EG0hIEKkebSJi43wtuHIc=;
 b=zE2E7ZO2oE6z+mJIMzRIS+xKgVe7JXLMCQi3IXWJ99ZfAcGEi1R5AgXDCV+GcGaDP1s6WwvYLXvjTKlEaR94vVXgtYJfozFETuQ8h5wKMrTpCHtCPR/qpH3esK5IirnS5NdJt0aUNzVDRowdi+pNWXD8YQ1vMEMTZMLGfIQJ4H0=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV2PR04MB993976.namprd04.prod.outlook.com (2603:10b6:408:36e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:55:27 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 04:55:27 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v10 0/7] riscv: add initial sdext support
Thread-Topic: [PATCH v10 0/7] riscv: add initial sdext support
Thread-Index: AQHdT4PVL6AYZGzIaECiddjxc2Vy/bboIxyA
Date: Thu, 1 Oct 2026 04:55:27 +0000
Message-ID: <881cdcfb3c35dd4821cec955314b7ed6642e8f01.camel@wdc.com>
References: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV2PR04MB993976:EE_
x-ms-office365-filtering-correlation-id: faa2c25d-4134-484f-4923-08df1f7835fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|10070799003|366016|376014|1800799024|38070700021|6133799003|3023799007|10067099003|56012099006|11063799006|18092099006|18002099003|10086099003|22082099003;
x-microsoft-antispam-message-info: O58ZXaQ9zrRCaCiH01tLcs8AQULGOSNWjAEQie1DFzR6DN4Ythp0nnl8nX7jTcp1xv3ONDesui06DS3rFNyGkFOlZ1OJZVoMRDeSDQCCadBY28HWklV5i0pRqT5n451X+Ohm+366QVCq/vUYw1jFQlHnfYT1nBbstV0KPJef3qLdzVZ6pP1nCx4lr3/O8RN0PRxfJ97l8xjdqg8BKUcA9P7VXs4oAYcTyr0RlGSYo4Q7+Wv6GMMw1zLdKOQYKY8x3wlHbrcZM0pdZKHu62YoZAW+CBRyqAdodvRck9Ug2UkezjGm6XcrdKwpt7P04qQCcb6MeNMSsWBX/TUsDTGawZHVtqBf4tWTX8CFO+TOLrbwqG2W4hrj+R0O4AHHHjjqlSRUV1MUA7VJMMpo7ghPsuAvfI2+geY+5TfMZJR3XaTTUHtwD0/CxP19WegN/l6mKcvoaHwaNQtLwkAO4nvo+Fl6w3fWFC14bMYYDZRROcuJdNSahCpYjz9Q5gXwFKgHNsVF1sQM7mO7UNj94XpK3diTZaHGLJdQVMPrSUXmALkdU/GttqGjH2CdPQ4MlxQuBrfVxI69DpDmaZ1pIVpBMsFJAzC7VMbLzp1mULh2h9H/9Md3AZISRPku+JUO34Ees1Y+UGEh4CXuIC7H+u+GtQd976R+ODXYYgB4wyTIBTQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(10070799003)(366016)(376014)(1800799024)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18092099006)(18002099003)(10086099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWw4dHlwckdIY2M5WkRlajA1RXFRZFNjRFI2UVZSSHZ4c1VQeDJqdXdYaGdk?=
 =?utf-8?B?K2I1WElLUlh2Q2FZSlNSYWNXeHV1RW9PZ2VBTU56L2M4KzBIRTM5U0l2aWRw?=
 =?utf-8?B?dkZQZS9HU2k2b1NheU9saWV1bUg2YzVweHdGS3JnSG1PSTNyd2Q0bDJuSVF3?=
 =?utf-8?B?Zy9IUlo2czg2eUEzV2JtTzNHalpqVC9CcDV1a3g5L0dWVW1yNnFjSlo2eDVI?=
 =?utf-8?B?NkNkQ2dvZ0phT0ROSlFYY09GSjZud21JNjVUczlyMXltQXJUdXY1RU84OFpr?=
 =?utf-8?B?MFBjREw1VWMvK1pBUXhCcmxLTHg0L2pkdG52UG1aY2xHdC9WNUZ4M2dPM1lz?=
 =?utf-8?B?Y3ZOZDVBdXN6V2xHeDFHUE1yNmZzQTVoMElwT3lscnF3SnlPYXRPZm5KeDh5?=
 =?utf-8?B?T1RvN0ozUktWUTJxeHM5M2RYMG11UHlsb0VGOFVkWm9pVXh4Y0NtQ3VrNEFY?=
 =?utf-8?B?UjArZFcwczRVZnQ4OHk2M29FMGRrSmM0dTd0RG9nd2RjdE9kejFuUVVsVHBy?=
 =?utf-8?B?SHFUMWY2TGYrUXY0b3pQaW9td2NONmVtVHozWkQ5RWhsTlpMOWNNN3FQQVRq?=
 =?utf-8?B?U0JUSlRtRTJSUWlFcExwMFJ0eXRGZGVvRUlpWE9HcnV4MnBHSXJqL1lsUVMv?=
 =?utf-8?B?bitmTHBUL25YYXBPd012OWplSzdSbnpRUThBbXVUMHJzOXIyNFZwMFUxNWxO?=
 =?utf-8?B?MDRnQUZFNTFRUllNaWozSUF0RXpGVE51SnNpQWJtZDJwenVORHhqSStlckkr?=
 =?utf-8?B?OGduaUgzNGpvRlAwSlUvTTErQ3REZFh4b211Q2xFZ2QvU0F3d011Rk80Z3kx?=
 =?utf-8?B?cFNlQm5KNTNyeGNFSFgyRG8wRkgrNFBCaEFVTFVMbTVSSkpuZjMwT29VL25J?=
 =?utf-8?B?eWVNd2NiNnZqRTFhVjhscFFjYmRld0d2S0d2aVNuZEo3WHhyRnkzNzJwT0ov?=
 =?utf-8?B?NFRJajB4UmFnMlRqL3RyU0VjOHVCZmhvWGxqYkdVZytvM244Rm9WTlB5VnEr?=
 =?utf-8?B?TXVob0x0WkxmaVEzVUhpVTc3bXFWVVpCOWtkaWVnMTNNaUdDQVRVS0hiTjVE?=
 =?utf-8?B?S2VoUitjQ1BJVUUxWFNObnl0S052aW5BQlhreFBrTVhteWxibkRpVkdMamFw?=
 =?utf-8?B?WFB2K2hYcWJMYXhHN0pJVElwcEFWZ2xobm5NeWs1dXVzVzVteWRWZTh0M01h?=
 =?utf-8?B?NFZPY2EyLytURXNaOU1zQ3d2ZmZRaHIzVTRqNkN6TGZleUZ2L3VkZzlpOFo4?=
 =?utf-8?B?OE1EdkdwUkE5OENxeFVsMU5IVlJ0bDliZmxJMFQzdDMrc2xjWXUyOG1RZGpW?=
 =?utf-8?B?eXIwbllBK3VzSTFZbW80ZDQ1a1ZWQVA2NGplOGVmR3RhMmlEM1pCK3hDMlVn?=
 =?utf-8?B?VG0yVkZaZERGSEpJTnlEVStKdzNubHRQa2hDZElwM2h1QWVjM1pIUnJteGpn?=
 =?utf-8?B?TUN6akxVWE5qaFBjd0lTamtOZzRWV24rT0o1aW5GaEowa3BUQ0NtdGFhLy9X?=
 =?utf-8?B?Qlk1eVBITHZPVnhKT2I5VnQwMThRZU9TbU41SERvRVovL0dQK2ZWR3BzK3hO?=
 =?utf-8?B?amNKRjlGcEk3aGpORVBtUEptelJkVmU0Zld2b29jenY4cDZRcHpwOUdDejBI?=
 =?utf-8?B?cjBJbXUzM2NtYnRPWkxmK2Q0Y3hRcndnamp6VzBQUnNOcWc1OTRKUzYycmIy?=
 =?utf-8?B?TTdGbnJSaC9zZTBCdUJhUEg3Wi9sV1cwTlpwcFFuKy9wa0lVUTdsRjl4Qkxk?=
 =?utf-8?B?alhnMVhNaUpvTVNRdlpTVzNNVGlmVE83VlFLTnUwL1JCQWY5S1FFQTZaM1NS?=
 =?utf-8?B?RkJMeVorZXR4dlZveng4RVdKYWUrdUU0QjR5KzhqaHQrcnFES2tnT1pxSVp0?=
 =?utf-8?B?UE1iZ3R4QkR0VDVmQmJmMStJYVFHT1JjelV1Vkc4U1FONk96N0Nta29nWWJa?=
 =?utf-8?B?SEVlekRsSFRsVXRVbyswUjhGZFgvM0l1TmFvZmhva0V2eDVKWTVuam1oamVZ?=
 =?utf-8?B?dEVOWWk5KzhTNitmUkJoRk1vamRPNnFxUjUzMjlJZ0htQ0hFT0xXSmdveTk5?=
 =?utf-8?B?NVVYK2xRNnBETWdQRFlJNmYzZGxqZ2pJZmgyYkxWNTdXUDVBOHhteDBpbVZJ?=
 =?utf-8?B?V0lxMlRrYWc2a0d2YlA0ZzlLL0lueVFabDRrZDFrUzRaWTBVTW5HVzlCZmxP?=
 =?utf-8?B?MFRLOVV5NnMvOFI4eDNiTERmLzVjcTY3bElkZk92WGp3eFRBbHUveERHUjBx?=
 =?utf-8?B?RGNWYVpBa3RreklkRVQrckMxbnYwZ1k1RTBQMXJjV1dRZTFHYzR4eFNJVTRD?=
 =?utf-8?B?eHVnWEJmZ1NmR1hOZWFoTitJQlhVemUycE52aWZpNHJOM3JUZUJ3Y1lxR2FI?=
 =?utf-8?Q?nrEw8uh5ptDgyAa9QQB4HyLgLr7/vYjciAQYnPR5YdqO6?=
x-ms-exchange-antispam-messagedata-1: biykJf2HrAmXyYtA9z8I9FDlUMWjlIjZu28=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4341BB88E18D44E96D018226EF00DB3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uHNwnLGDpbIULaIphUAvxSmME0GlEK2HfYQlk2Io9OmJr9wReNkO1NEf9wqR5NWIxWGff/Jy+uvjcSwtCcfCmcd/qkravd4Kd+Jdl6sQRJ1c3HP07rDrrbMOM5FcOzF0yjn8slxqCq/hLIb6ZT/arwpfvaRVfg2LWBDZwcwfJrV8H3viX0iNnarMFYa96v1wQ2AsKunXJt5WYjO5iev6wV8/lJNc5dxR66F+dh97zGUtgc9AIZKK3Byx1RVM0dgBq7wKrpV07DElYqf4l3QYdeT4Farq8+II7n5yxM12oVDiuwklfBxtLmDuE+KME0LHCqOx7oTh2ZN/Ik0+OZ4j2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KxxL5CDkH7M2Lx3uGz0V4pqy/DECv6STA5ri8nhxIeJp5xI1sJg/GknXjfSg4ryOuLXUN+4pJCaSk3su+Xqh+mzo/cx8+pUM/U2ZCgHUj2KUUIt84tkmmYrN9dmN0iv933RohRRDgsn/4CTV34C5Hon9mXNnesn3dNnYil4dXbz3VzIb6b1ut1ZxmO5yHpO0yTkl7gOXUO+3yo2cO6iqUH+kXYKWFGlys0yKqJzWduvEmWJ/32lJ+kaDBPfNe+ueM1+PTja/vhRaKlo1AqyA1zzxSyEIZtQzua2JgiKtBX+AzkobveNKjod/6bFK0m19dxqXNPuwBR9vZgRv92PDPkSHBzzf+v1c0whZm75ZTqYitJtMWJfl+ntXvJLyM8/4sklKbgg037gqZ3rc4QaCQBJJWQFnQLF/8gxHNfjtgaUgC0k678OLrGPwR6EtrOPSW2djGEGEsuSJY/G5jq+MBHZXRPjjxVbIDI7GeAb7EDqt8xlcnFUcdzyD7CpAsl1l3C1g9c14xncj/ubwT+fvkU9rYZdkoNxkDhRX3HNK7/1cbSp+fpy+ZgJtg7uHtPoyqv2M5GomFa62owo6JObfqUdwJciAnyMWExiTFBSm3rbVWGo3CQ9t4tq9xzrXEVBf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa2c25d-4134-484f-4923-08df1f7835fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 04:55:27.1934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JT8KLKH3Bia8vtowCMu7Xwgo1p0mhhv14TaAl+15fseKooco+4hiF+kmlzfsTfFsEGqj6VakI5AioeiRmy85lKcN3hDg+afHD2horxM6j70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB993976
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE2OjU4IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBIaSwKPiAKPiBJbiB0aGlzIHZlcnNpb24gd2UgaGF2ZSBtaW5vciBjaGFuZ2Vz
IHByb3Bvc2VkIGR1cmluZyB2OCwgaW4KPiBwYXJ0aWN1bGFyCj4gdGhlICdkY3NyJyBmaWVsZCBi
ZWluZyBhbiB1aW50MzJfdCBpbnN0ZWFkIG9mIGEgdGFyZ2V0X3Vsb25nIGdpdmVuCj4gdGhhdAo+
IHRoZSByZWcgaXMgYWx3YXlzIDMyIGJpdHMuCj4gCj4gTm8gb3RoZXIgY2hhbmdlcyBtYWRlLsKg
IFBhdGNoZXMgYmFzZWQgb24gYWxpc3RhaXIvcmlzY3YtdG8tCj4gYXBwbHkubmV4dC4KPiAKPiBD
aGFuZ2VzIGZyb20gdjk6Cj4gLSBwYXRjaCAxOgo+IMKgIC0gY2hhbmdlICdkY3NyJyBmaWVsZCB0
eXBlIGZyb20gdGFyZ2V0X3Vsb25nIHRvIHVpbnQzMl90Lgo+IC0gcGF0Y2ggMgo+IMKgIC0gcmVt
b3ZlICh0YXJnZXRfdWxvbmcpIGNhc3Qgd2hlbiBldmFsdWF0aW5nIGVudi0+ZGNzciBpbgo+IMKg
wqDCoCByaXNjdl9jcHVfZW50ZXJfZGVidWdfbW9kZSgpOwo+IMKgIC0gbW92ZSB2YXIgZGVjbGFy
YXRpb25zIHRvIHRoZSB0b3Agb2YgcmlzY3ZfY3B1X2xlYXZlX2RlYnVnX21vZGUoKS4KPiAtIHBh
dGNoIDM6Cj4gwqAgLSBtb3ZlICdyZXRwYycgdmFyIGRlY2xhcmF0aW9uIHVwIGluIGhlbHBlcl9k
cmV0KCkuCj4gLSB2OSBsaW5rOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
MjAyNjA5MDkxNDQ4NDEuMTc2NjkyMS0xLWRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20v
Cj4gCj4gCj4gQ2hhbyBMaXUgKDYpOgo+IMKgIHRhcmdldC9yaXNjdjogYWRkIHNkZXh0IGRlYnVn
IENTUnMgc3RhdGUKPiDCoCB0YXJnZXQvcmlzY3Y6IGFkZCBzZGV4dCBEZWJ1ZyBNb2RlIGhlbHBl
cnMKPiDCoCB0YXJnZXQvcmlzY3Y6IGFkZCBkcmV0IGluc3RydWN0aW9uCj4gwqAgdGFyZ2V0L3Jp
c2N2OiBhZGQgc2RleHQgZW50ZXIgRGVidWcgTW9kZSBvbiBlYnJlYWsKPiDCoCB0YXJnZXQvcmlz
Y3Y6IGFkZCBzZGV4dCBzaW5nbGUtc3RlcCBzdXBwb3J0Cj4gwqAgdGFyZ2V0L3Jpc2N2OiBhZGQg
c2R0cmlnIHRyaWdnZXIgYWN0aW9uPWRlYnVnIG1vZGUKPiAKPiBEYW5pZWwgSGVucmlxdWUgQmFy
Ym96YSAoMSk6Cj4gwqAgdGVzdHMvdGNnL3Jpc2N2NjQ6IGFkZCBzZGV4dCAibm90IG9uIERlYnVn
IG1vZGUiIHNpZ2lsbCB0ZXN0cwoKClRoYW5rcyEKCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHku
bmV4dCB3aXRoIHRoZSBjb21tZW50cyBvbiBwYXRjaCAyIGZpeGVkIHVwCgpBbGlzdGFpcgoKPiAK
PiDCoGluY2x1ZGUvZXhlYy90cmFuc2xhdGlvbi1ibG9jay5owqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgNCArLQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdS5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDcgKwo+IMKgdGFyZ2V0
L3Jpc2N2L2NwdS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDkgKysKPiDCoHRhcmdldC9yaXNjdi9jcHVfYml0cy5owqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMzICsrKysrCj4gwqB0YXJn
ZXQvcmlzY3YvY3B1X2NmZ19maWVsZHMuaC5pbmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqAgMSArCj4gwqB0YXJnZXQvcmlzY3YvaGVscGVyLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArCj4gwqB0YXJnZXQvcmlzY3YvaW5zbjMy
LmRlY29kZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+
IMKgdGFyZ2V0L3Jpc2N2L21hY2hpbmUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDIyICsrKwo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVy
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOTQgKysrKysrKysrKysrKwo+
IMKgdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAxMjYKPiArKysrKysrKysrKysrKysrKysKPiDCoHRhcmdldC9yaXNj
di90Y2cvZGVidWcuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgNTkgKysrKysrKy0KPiDCoC4uLi90Y2cvaW5zbl90cmFucy90cmFuc19wcml2aWxlZ2VkLmMu
aW5jwqDCoMKgwqAgfMKgIDI0ICsrKysKPiDCoHRhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA3MiArKysrKysrKysrCj4gwqB0
YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAxOSArKysKPiDCoHRhcmdldC9yaXNjdi90Y2cvdHJhbnNsYXRlLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxNSArKy0KPiDCoHRlc3RzL3RjZy9yaXNj
djY0L3N5c3RlbS9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsrCj4gwqB0
ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXNkZXh0LXNpZ2lsbC5TwqDCoMKgwqDCoMKgwqDCoCB8wqAg
ODMgKysrKysrKysrKysrCj4gwqAxNyBmaWxlcyBjaGFuZ2VkLCA1NzQgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvcmlzY3Y2NC90
ZXN0LXNkZXh0LXNpZ2lsbC5TCg==

