Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C06CD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS2TY-0008Do-Cz; Tue, 26 May 2026 20:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2TW-0008DN-Dq; Tue, 26 May 2026 20:50:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS2TU-0008Vh-Hh; Tue, 26 May 2026 20:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779843021; x=1811379021;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=l4JRhERiUXYTwD0BkXjglJpXQvIEqkz1F9mxCJ69QG0=;
 b=ckvMVX7DsxmBDkGjbOqXG8DfWMf3hKigKZ/xQ80Q6Oo5Gm3ECjoRRHP7
 shvLOb2Fn8SV6D7S9MbJfwj7VG6yRAm2sginaQ8Lk3SfxRaTQmti3HYvX
 oLF4tWXa/ht8iPlaBLQJRyUzj16SV6TupcIWPD3lRzkfgLoS3iTyAmswB
 EQUIH7viVi5yVQjC0OXXTL6bjOELqbHt6JqpLgStPhOWk5s2Qg9HdGwL5
 4i5F+kJPD/zRYHWkutCIhfsSOI6tagPE1QvsQVO5Vwc+OeYxZVh1sfx2c
 HsXAS87nMZolCJC+1O8tg0/4dHLiSppCkQJPv8zV5v2/fAtfvxe6qT8P5 Q==;
X-CSE-ConnectionGUID: khdtiCRETp6FZ4CQfRp0DQ==
X-CSE-MsgGUID: Y4YX9+tiQIaMpv2rjm57lw==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="147844520"
Received: from mail-northcentralusazon11013018.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.18])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:50:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQBvwqVlo8/vXopWh3VmdxlQ3KPgmjozMRk+58aSdQ4yT1Q1eb7GAtH+pWZiGehDsanpJBJRF2aYIGMs2IZWvVP5dbSeJonbMC1tZPDWhTru3gUf58DjI3wPNMzQ5QMNmO6f+jhfQ+6BUqF8KwV60+4jvDr25IzuKY2ssswvw0T2MDwtnlFRfCtiN/5PMck3NcGWcl+ok2en0QtDeWAdKd8rZZ/VnD6COeiqCsFB7k9Rmo0+2BMI0yZq+9PAW4CeaqtLBjZU4PJGA75hwyQAzPIWoe0xxLuT+dNBvNg1pSTW+yN6MmCxq+yIApWfzQqMKqMFfCcBkzLRZ961ff8SdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4JRhERiUXYTwD0BkXjglJpXQvIEqkz1F9mxCJ69QG0=;
 b=elKfNmw9SeZ/ICiISVvJpc3tbF6jqA7t9LhIFXwWBGXO2n4pmmWCjgTc4YuQy3PaP65JLtPBadzc/tsHkenW3/BphJX1rRACGZHsvrsYQpgGgMysNsIuLs8c3jSa/fHAaZqpeVtbh6BuAX3cI7HwwflR42bz81G6qcyHHGMHr/mXgzTzdePZQSjKMORYCqn+hVPfaoYUV/MOnTYi4vouc0uE9bfeD4suYFyMNNHBrVxTsWiJdNJEc83FhkIbOYWD32qAs84maqXS56KfpQBtgE7nL3eic8wCFbemLb9uGbIqD0Ks0tbnTsweBS/zJx7HYIPIQd7I/UX+J5vbEB6O+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4JRhERiUXYTwD0BkXjglJpXQvIEqkz1F9mxCJ69QG0=;
 b=chXOEbTqG5B+QvYv6E/OyIDwxELvxqWITmU9kEqUg23EDPcaaP9/ZUAgcm3uHwEsuSG5K8MzE4n6we9f3u0jrhUmrOTH/Kbbe3R53It0jIiwhcIs1PwcsyiajZYoSgwpufavsPhtMIz2fb5oxQecY95OQ6TfRT4dBLo8mZ6TXAo=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH2PR04MB6903.namprd04.prod.outlook.com (2603:10b6:610:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 00:50:13 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:50:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion
 to AMO fault
Thread-Topic: [PATCH] target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion
 to AMO fault
Thread-Index: AQHc6hbHoHyAdiTIvEKeWW+ERz4/o7YhEV4A
Date: Wed, 27 May 2026 00:50:13 +0000
Message-ID: <41f0adbabbd4b101134d0a737f366f000f64b5f2.camel@wdc.com>
References: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH2PR04MB6903:EE_
x-ms-office365-filtering-correlation-id: 6b9b4e9b-1e45-4767-4125-08debb89e97d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|19092799006|38070700021|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: dPfqek+tQHg5QQACL7IPMoZA/jo03OWt9GaLVjTfS23q/4txsjZu3bdVpSp2qFW45meglvWRojNZngxRCeaIiSHtdiA6mPYG7MEeIMU0ExX3oISw4vV2NhqvNGHd1hsw6+ksiLMa35iz+SUmseiVBW+18pCyb7JHgjhFcnwgd20eoDJ/7Gzhlmv10+Q+UqCfSD8LSMQlc+q8rmSBGFOQq1GdNwHqEX3lnZSj1kIoGugnfPOC9FUgfQJyqJw21mpdsxBNJxipm/WpqALx3n84JquJeI+CYDxgSHPmpIrrBqdeUJXhLz7sKDNYWm0Rt2/lBm9H12xSA3hHIqlEVCuLCQbHO3FE9jMyfDhytR+1caRenS2S1hfEhx7YNXCMxdkzvKQsePiNrmeAiz5rlW+uII3xO5r9V653iQnh+8VBzJquDVivtT3pM5+7QTUEjqGHVgFIXflnWoGJBuopxO8urKjvoa+IAgsEd75jEq10kSB9HmfpUwh19i7SL4ofn14v4s8gA1Tcv8ZjrTiJSd1jrkwI+qamOQQj4xBYw57tDV9n1YRFjmedTKY21/Y4zFclFOB514Kimf7aXon+jFfoNYdhJsispa4MRdPhHwmzTmPFf5n0nYTM42TOrRcAlIRJssXHyLVJr591cqBRJofz4b4ym6/Ws97GB2z3KZfZQFAOne77sffT6MEvERSH1qXdSagGYP15eMod5xqDRcC8TViOrG0RWPwmgaEmJTBM25jIWjAh65qWPWsX/E47ptl2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(19092799006)(38070700021)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2xSWHBYcUdPT2ZTOHBud05Zc0hFTUpVVWtBNURNUjhmSDJvdm02TG1od2Z6?=
 =?utf-8?B?SHhoeElPVlJ3dDRYLys2SHRlcjkxUXdhc3NaSlRyMDZGSFprN2trVXhJZytZ?=
 =?utf-8?B?M1dWcEE5MzkzeEl4R0ttOGZ6b2FzdTlhMTZuM21iNjY2bVFVYWxRM1BxNFdx?=
 =?utf-8?B?RUNCcEVTSitZNGtnNmxsWjVRd1pvN1BCc1ZkR0FwQk12Y0dCV1NKUEJPbTUz?=
 =?utf-8?B?VVROb2Mwc2UwYjFvTDNkNGZiQ3B5d1ZwWUw0ZjRQdFF1TXAxbnVZa2N5cmVO?=
 =?utf-8?B?ZFBxUEJnWENMZ1F4UmxqOU5mTzFCSUtuc1BtbGhSM3VmWWszSUp1YmkzMHhO?=
 =?utf-8?B?UjYwQ1FaMGc3eEcxRmZaOVMyWlNpOVVsMWNIM0FiZnFSVXByS3lBZTI0YVIx?=
 =?utf-8?B?NFNjQ0NNeExudjdwOWtSRUtYTWhrTWZNLzU5cnFNMWpUdWFXVkxzd21PTjEv?=
 =?utf-8?B?R0dzdU5OeTlvNGIvN2N0eXQwR1gxQmttWEI2N25OK0F5MzYrSkdGTEVJK3Y2?=
 =?utf-8?B?aVpwajZEVjdTOVBQZjlxTmNDZFRkdTF1blljM1JsS1E5OTFxMzFEdVkvNHZn?=
 =?utf-8?B?VzdSWmwyQUlQVXhIbk8zOHpUSC9xSVZmUHNMVGxzNzdmN3BXREJYQU8zUThM?=
 =?utf-8?B?V09MenpiKzM0aWZhclRWOGk3TXN5SnRaeXFVc3JxV096MDVGMElyV0NBYUlF?=
 =?utf-8?B?cWgxVllEYzQ0dWJCY2ZyRkRYZ2lDRmFKY1F6NWVJOFJ0VmxLRXlMTXJLSzdo?=
 =?utf-8?B?ZXlnSW8vSDh3ZmxQaTRRM1cyVjI3YktFMXJ0b00xclF4YWsvNnZodDRiblVk?=
 =?utf-8?B?R2dPSGR3a1dZbWF4MGRDQnM0QkNrTHJlV0pvcHJ3ODBWYmFlQTB4YUlCSHBC?=
 =?utf-8?B?UG9wNlN1RldaOG1PZGJTZ1FZRGhmMWxFNHFMZkp5cDNwMzJZbndtUjBLQXU0?=
 =?utf-8?B?dEQwUEpEWHFnQTJtaG5hSTY3b0d3RTFpcHF2YVh4UUM0dWl0UGhUU1FGQXQx?=
 =?utf-8?B?Z21NMzNyVDNEVmU0UUo1UTFrK3ZhU3JjaHQvUEtoeUxsa1d3U2cxbmlhRDVx?=
 =?utf-8?B?N3dxZWhDNFh3NWdBMERwQmN4ZzkrWjVMU2djekRRbytQckxMMWxZWnNaUy9J?=
 =?utf-8?B?Y0sxb0Vwcng3TEJ4T3RmTkJpL3h4V2VSWFh0dkYyNVl4NWs5MWZIWlBpanZ0?=
 =?utf-8?B?SjlYSktOc1NaOTRiZVcybExaMWFIcGl0SkFhd2l3Yi9RUHkzdzI4WXNvMTB6?=
 =?utf-8?B?eXBEc0tMaXZVMmJNUS9mSFBTRFBVcVU1THdpaWsvM0lUQTNZZnlseCtyV2tt?=
 =?utf-8?B?Y0lyb2tpcGhlSVRoazQ4dndBR2d6RFY4U1RGWG8xbkRHVG5TM3I3YVZmVUR5?=
 =?utf-8?B?ZEg1N01qRnZJQlpXRExHc2U3TzNzNTY2SVFOSWFQNTBjOFFWNFhzOGNaUDgz?=
 =?utf-8?B?cldwZWhTUndaRTVsc3pnTFpvYWtWMWVNa2F1WGxoamVPNEFBUGNjUHkzanJZ?=
 =?utf-8?B?Si9OMHpHTkJuRU4wRUhIdU9ya2dvVkNnVjNtb0pxREx1QkUrOURTSU13bDYr?=
 =?utf-8?B?QXJTRTBodk5LcnBuM0NDbEllSVduUmtHU1ZNRFRiWnNSRjE2ZFRxL1NicW5H?=
 =?utf-8?B?V1F5cXJGaTdRalFRZkpWZmxUdkZ3MmQyZ21sa1Q1VFhXSmVndjR6a2NZUWZr?=
 =?utf-8?B?SVp0Z0R1b0U4SWdsMyt3aUdUN1JkNlJBUEhHc1djeE1UbDdyTEJWMk9iUUw5?=
 =?utf-8?B?VTExUkUzM3ZjU1owYjNkSDlaVmVkMDB6WkdwR3dyVW5NZkYzektrR1JuMkRM?=
 =?utf-8?B?WHpXOWNrYW94WE5FREt0Z1B6TEtRSUNZa2tJVWxDZDdFd1VCSlgrOTdqSGpX?=
 =?utf-8?B?c3hhVElZaG9ZcHdSdlJLUWVIeWQ0L3BhdW1LWmNhRUJGeE5wQWZjUHJNMFVC?=
 =?utf-8?B?cVM3QUY4TU9ONmdyL3VoZ2xLVzQrS3piNFRPUlJ2ajdTbkFuU1I1ZUJtakNF?=
 =?utf-8?B?MFNjdVc4ZDJILzQwUHlFSkhEWTdJaTdmRGl0dkhsRkdMeWtSU2xvR3lmYlpB?=
 =?utf-8?B?NXpRVDRiZmhKS3VQM1hzRUd5S1pDaXlObWhHR0x4a2FRd2dBd1VGMUdQWlJF?=
 =?utf-8?B?cXVaSnQwbnNVUXBja2pnSEt5T1pZUmhFTGQ5cm11VjBrSWhPQzFSRGNZT3JK?=
 =?utf-8?B?ckpNY0hMRHVBTDYzMEg4YjJ2WnhmNjJVekNhQ3RPNEtwcGdhUGlVZUk4TThI?=
 =?utf-8?B?ZmVtYWdTd3FNMUVpVy9KUlVId0VBRW14RG54WXAyWkVuQThHczdmSkNwaXo5?=
 =?utf-8?B?dmNMS25WYVUyMVZoMGdzSGpUbjhucFNzbnFZd1VNYVF3eEV6RzdsVmcyRkZj?=
 =?utf-8?Q?ZJAVfUYAvXMilFOOVcQHQD3Wuo56o8Q2V/8kdHC+mn9C2?=
x-ms-exchange-antispam-messagedata-1: oXFHyQklVls2+wwhrFG9CKzVVjzcScH5qn8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C96356D5FDD86D4FB8F5509941227566@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: scsOlyF7BeXczmqx0bAg5UuDVlgc8ovkLAMBbajCOwlUUC8z/jCLPpyXO2ZSmiXYImiOEorLI1DmrNHrsKVXw9AWyso2cneP7ijyp5QqGZ1Kj2OEOyhsmbmGKqaBUg6YkV7Z7eh2s5H9Hi8/yd14Ulm6vv1VV1GXMRSLJrVA7MwXycwbXa5+ZXDRTYkK8IxhfYjj/fWjHAZyk88x4P7cQILxsOEcmIrAm5mVPMvAJptX7fUMePllfXyjTRBKnO8yF8GWvrNvxHqi31i6wgoPa9nLzyby+G3UHQzrbaJz/Mm0lDGs2K/9Esk2m3HEUUnFHMRHmRrhrCMO8+9nwkIp6Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PobZqbjrfeHOCKc8BdCcQW6w3rLBaYXdTduXaHi+poqJwZFuaH2DDcq74fmXzsbTuGOe44QlkqMt82p92pj5q0IqU2OObSU+4T0coYiHKy1VI0DwR+0ctsjEIf0Rn7BkmqNcF2B/jWOPIwjjje8FrY2STQNieomTDaFUaxgh6m4bRJUklstWvxw5gMqsPHAGdEgNYR8oy0xIaSFYyAURCv8vEu6A0YKlAoESe8xX2PuA0XwB5KIgLqshriAPOqy8le9dYHt+tki+PoD2rkq/OBEP5o01+RrsUzL1sWHXWL/VZ57RNb0onhrBAvh3Ux+j+4w482KeDYy03RttCUElZ9chrqIac0Mx2L/ZKOBxeQAPGaO5lZtxknbzSA+hk9WJk3ojMri8b8DVLW3Qyn6xRS7Dl3kUruM50yigCAit4sYiYOhKTK8hFCEA8k56dxVfmXvfWwVElHDBQ4LErogVw7WAT610MxmFlVNNn92hXA+bJfaPOWFFGaiUNGHE57MmYA/Y2LmtRlPSz+aI4QKRFkkqg6xhZ0hI/yik/T0SYFzYyZPFeK+7iM+/OLpmi4Sd5dhUM9HG5cK27tEb9TQ1I1nxlG9MGZOiRciLCBRa0TBs/Ij1WWBsj5oliuXEyMLu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9b4e9b-1e45-4767-4125-08debb89e97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:50:13.4821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nK6ray+rzknI7H3Kck5ksVTu9PojGf0gAMp7RJ6UWZkGjyNakpofU77DNYwsJHyG5M9Vyzvdi2Kw7R/qzMPk9B3evJyuXFHgZ/mkpihX3xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6903
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDE1OjEzIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gcHJvbW90ZV9sb2FkX2ZhdWx0KCkgaXMgbWlzc2luZyB0aGUgcHJvbW90aW9u
IG9mIG1pc2FsaWduZWQgQU1PIGxvYWQNCj4gYWRkcmVzc2VzLCBpLmUuIFJJU0NWX0VYQ1BfTE9B
RF9BRERSX01JUyBzaG91bGQgYmUgcHJvbW90ZWQgdG8NCj4gUklTQ1ZfRVhDUF9TVE9SRV9BTU9f
QUREUl9NSVMgd2hlbiBSSVNDVl9VVzJfQUxXQVlTX1NUT1JFX0FNTyAoaS5lLg0KPiBhbHdheXNf
c3RvcmVhbW8gaXMgdHJ1ZSkuDQo+IA0KPiBBbGwgb3RoZXIgbG9hZCBBTU8gZmF1bHRzIGFyZSBh
bHJlYWR5IGJlaW5nIGNvdmVyZWQuDQo+IA0KPiBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZw0K
PiBGaXhlczogOThmMjFjMzBmNSAoInRhcmdldC9yaXNjdjogQU1PIG9wZXJhdGlvbnMgYWx3YXlz
IHJhaXNlDQo+IHN0b3JlL0FNTyBmYXVsdCIpDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5j
b20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzM1MDMNCj4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5j
b20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdk
Yy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIu
YyB8IDMgKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMgYi90YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jDQo+IGluZGV4IDE3MzA1ZTFiYjcuLmFhNGNiZmNmNDAgMTAwNjQ0DQo+IC0tLSBhL3Rh
cmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIu
Yw0KPiBAQCAtMjE3NCw2ICsyMTc0LDkgQEAgc3RhdGljIHRhcmdldF91bG9uZw0KPiBwcm9tb3Rl
X2xvYWRfZmF1bHQodGFyZ2V0X3Vsb25nIG9yaWdfY2F1c2UpDQo+IMKgDQo+IMKgwqDCoMKgIGNh
c2UgUklTQ1ZfRVhDUF9MT0FEX1BBR0VfRkFVTFQ6DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IFJJU0NWX0VYQ1BfU1RPUkVfUEFHRV9GQVVMVDsNCj4gKw0KPiArwqDCoMKgIGNhc2UgUklTQ1Zf
RVhDUF9MT0FEX0FERFJfTUlTOg0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1Bf
U1RPUkVfQU1PX0FERFJfTUlTOw0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+IMKgwqDCoMKgIC8qIGlm
IG5vIHByb21vdGlvbiwgcmV0dXJuIG9yaWdpbmFsIGNhdXNlICovDQo=

