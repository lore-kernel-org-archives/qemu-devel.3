Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50918C982E6
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 01:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ovi-0005sC-KO; Mon, 21 Sep 2026 21:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8ova-0005rg-1e; Mon, 21 Sep 2026 21:04:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8ovV-00006d-Uz; Mon, 21 Sep 2026 21:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790039046; x=1821575046;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kG36ccSixFKMfowTVmBi5+pjwSkEy24cjnbMOnp7anI=;
 b=SjiUesQaSuX+1rCrfFycAXwmbmjMCGmh5ssaNX3W24jTVrUeuL/ztnif
 7pqvs/DrhtEEgiMa7TLg9TATf7cCQhWHyu2KWQVNXie4DlcMhyfj/1NPq
 62BvNxg+ngW+5Pycss/hSHJHD0Jw2DSCcH5356U65Gm/cslrV92Nu9ts0
 ZpfhNko12AL2kZJzRhPB1XjR/Yaq0ib5ACLjmqZjF7cyuqAAYPZZihccu
 ijdFAeilktlUB0ZI+jWaxOHM6bCWZd+eKq4key/iVHzTloVFlBhI3dnhy
 omoEmkh+U2ykk2G9W+mDgTHrcD/VPtApq7d0JRbyZFrDSVg3Yn3JBp8YV A==;
X-CSE-ConnectionGUID: yWrdTj4ORISX2z+741HvuQ==
X-CSE-MsgGUID: 62s3ioZbRRO1bR76AfmMxw==
X-IronPort-AV: E=Sophos;i="6.27,115,1786982400"; d="scan'208";a="152007174"
Received: from mail-eastusazon11012033.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.33])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Sep 2026 09:04:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXHhT7Che40KTgNo8M7//OliHeAxBpjA5z8Bcm5rm57mXmu9of3RY3Burt2ao7+fpWDV1tn4MfqWbC913UYjPVNaCZDT8BXMGirgtjzGXkFR77VS9ZNNz7w/OvW7b04jOnKLLSzBxhBciPT2W7PwDv7t6VJDP+npSm9CZyIx0+iWAMLCGFDUzXumLIOqq5qScndWvJx2lLEpr71d1R+MaLt4BUi1P6vU8Q3VcW6e6UI/a1vVEYdVMYYBRbvTefPaN7fI9Azl0VKwR1hDw2uKwn+cBqSifnQonNuTr9ZDT2GagLl6jw+LTYKgFKUPmltnmp7a3tFiqgs4RUs1Su3WRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG36ccSixFKMfowTVmBi5+pjwSkEy24cjnbMOnp7anI=;
 b=SzVwAA59g0p045pcWo8IJmpVrBXjtA/JQR2IPNsueayTabeeoBdd13u8meo+tSPPj9vL+AQ4JcUuU3r63FdAipkNnqmrFMY3VUEantymPl3sZsAEMMqZWZIC1Jd+07TsOWRJJC4ltWYS2O7/4lFFyb25lP0KSRJSfBeJxLA8GBcDf+TnYhyBIwIgjSPvajmu9zLYwk5oSo41uKSpE14MPV8NUyj54mUKxwltJrjI0SQEZ5sW5qB5OHMuds0PW43tGQj3zEbX99s/HHk+I2cU8swBgd/0Zuyq1ZyEcHvkEGTIXVllaA/t632uU/SrOozbMomPsnf/IEu3uJ2Q0PbnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG36ccSixFKMfowTVmBi5+pjwSkEy24cjnbMOnp7anI=;
 b=YHBxItDNgCf+6XrAZWrP79cRSucX+sIyJLgri32fhAGaF+gnBy3v+igSwXIDLDtZOM9014b27BPkVx/R1HhUO+G7kZwUx7EswIlLj6SxzQVUEErM7HWe6hrucAsa5zS8KciWfNqeVVb/bpnlDb3DjUtorTvwoNK0XrSDTg8kEsU=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7521.namprd04.prod.outlook.com (2603:10b6:303:af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 01:03:57 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 01:03:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: stop translating after WFI
Thread-Topic: [PATCH v2] target/riscv: stop translating after WFI
Thread-Index: AQHdQM+c/JT5C05PEECL4u35t8Wr27bZ2tuA
Date: Tue, 22 Sep 2026 01:03:57 +0000
Message-ID: <73f1820e30f514856ddd09ecbfa84adbafca28bf.camel@wdc.com>
References: <20260910025324.54990-1-fritchleybohrer@gmail.com>
In-Reply-To: <20260910025324.54990-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7521:EE_
x-ms-office365-filtering-correlation-id: 1e798374-1e61-4197-19e5-08df1845612e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|10070799003|1800799024|376014|366016|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: Em8ZA65YTpBtIU9qJ3W1MkB3OC0wHTyPqSgmAXE6jNXtge25HEdrQzK5it/BPiJy/4AQX6jzIlT4JTiyzuwkDDU6w0opeIfhWGHbH5NExHkcbFJ/6VZ6DYFzGx9nH8nyzNEv6Rvxxnns9YuD+zA6v70dY/xR6C0W8frlYDFMZnb9kMitZ92XGE7492In4Q4UnU7Kpy2NHrm+fpYiy/kRr8cr4L6Z5lVDhEVB2Ni6V60Fz9I8TG2c336Jg/Tuqm/3y2yufcItpVkv9bofYwcJd54i6UbsWdwSTXp/stT6vxtftS1TIECIu4md2eDydW5Jr7+5UsE5o6dLzeLen+YLFIz+bhbm+BZ7txQWNHuO7rrQy04MEHRdm59Fr0O8UIeHME/OQ56ij3JhLig9IPyytbDh37KZBSKmwAYyo8pwYPh1TecqjBRI6IgMcmzC7QeoyPz/Xdt6H39serqvlMUYPsYkw01c7cvH5G9mkYpK5eagWDhaBH91+l7ZRxzpXEcoWhZun/0sAE84JLTLJrF0TwrC180VYfnPzb9d8U797oe8Hv4bTSRECRlxBovv/I/MICV0paT6ctF7+gekep2mXrxDMDEpvo7KCjaJ9gQi0+ywgwRONgc1TWYc1xnSYKrVHFcNNDeUvb8wEn83YEiheyekA3MxtWnKamCykdXKVbEXlWW55rw7DMBBAy9SYhIpT3voqh9L7ZJXSkJZzRiyoqOUS6i28JyFzV8zQwS35Pc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(10070799003)(1800799024)(376014)(366016)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUpqTDB1c0Vjak5ZVXNNcmJTQlZVVWsydkFJOWhVTzFHWWhxbkRuSEJvYTQr?=
 =?utf-8?B?SG1PRkRYWlZvVjZIektkSmJ5SnhSV0Q5T1hpL1EyaHhxcmE4NGpINElZK1Av?=
 =?utf-8?B?bnl3SmdCN1JDZG9wMHBOZjk0OG5uMm4wczh0bmd4WTlEMjZaaVZERVlidU9t?=
 =?utf-8?B?Rk9XZjcxQThoQUhuOE9KQW5xeENVbWU2T3M4VVdYZXk0ZTZRWlhBS1hucXQ0?=
 =?utf-8?B?OFdnNEM3cUxEOHZBTXVVZlM4UjFybzA0NHVyZmpuemUzMWd6a0lrK2V0SG5Q?=
 =?utf-8?B?eWZ3Y29VNEtrcWJVWHZJZ3JOeitMeXdBb3FXa2ZTYzlpdTc3dFJxWnNHbHFU?=
 =?utf-8?B?Z2JVQS91b0U3UnNqSm1tRlVKNHZsb0Z2TkhqK3hpYlB1RldaSzF5c2loOUpW?=
 =?utf-8?B?cTAwTzk1dWJlMjJkcTNabkVoSWRSSmhaa0xybHFza0N3bm1WK0dMSitzckxS?=
 =?utf-8?B?RlEzcjVzTUtEaVpYVEl1VnZjSldHNXlPNUR5YkY0WFE4a1M5K2ROYmw5MWVW?=
 =?utf-8?B?Wm8yQW5EdktjeGk4NENJL0U3cHJYRk5Rb3ZNbG9LWEZ6Y2FPeG9teFNUbTFS?=
 =?utf-8?B?K2d4eDFpdUhnUUpCV3ZKV3JWdzlBbGwvV2V3cDBkQlA1UkhtcWdHZjh2NmFh?=
 =?utf-8?B?UHhTOGNIb0dwMzJGcDRZV1pZbi9WQzlJZHY4c3hkak5QT1V2U0l6UGR5RUFk?=
 =?utf-8?B?aVlzVXJzSFJYNU13QkRXUldWSG1jRkxRSHlJSUZ1Y2Q3clhuaHUzVk9oRi9E?=
 =?utf-8?B?eDlMbCs1c2ZrL2xaTGg0K29aWW00OGlBbUhwMU9LejdaWU05ckZ4T2Z4WVBq?=
 =?utf-8?B?MzVZOEsrc29qRlU1YlIzdWlxMCtlMVpSdFNqRy8vYWcyVHFKOW0rQkRlL0Ir?=
 =?utf-8?B?eDBuS0M1NlA5THdoc1JJMGtMbEhVdS9xZndPMFhpdHNwemx2ejdMNWtZRWVu?=
 =?utf-8?B?eXZYL1pMWXFoNmhFeGowQUdEdEVyS1VpRGkyc2N5eFJOSVArNllZZFpUVmsr?=
 =?utf-8?B?N0Y1VmpvRlpRd29sMFYzRkh5MXBJRWxxeDJDUm5xc3hOMWVjN0t5V2dLeVVj?=
 =?utf-8?B?RFYyeitET3pCczh3T2RGVGlqUkJUdjR4NFlRTUk3QUpCSWlWTHRIb3VHUXlx?=
 =?utf-8?B?VlRPSCtyQUhaZ2RweXowS2VOekJ2VmwyMkxiVHlaejVzZzVnNTdUUG03dmV6?=
 =?utf-8?B?NmlYdVZjaW1yNVdzV2E1eGpMQ2Z5QXNpcStwV1BST0N6RVZ3ZUk0dmN3Wnda?=
 =?utf-8?B?WjUxRUdlcG8rNVI3cFBYQUVNUmw5WFJmTWRVT2E4R3JBVGVuRElZT0hOZDdX?=
 =?utf-8?B?Rjdjc2hveTVDM2xBWDFxVWJNdEJheXVERG1TVTl5UlZ6SndhNFkrYzhYRmcw?=
 =?utf-8?B?WUw1QWVWNXV0OVhqMmJQVElVaE8rNVhzVVNnMjBhVVB6YjVqMW4wUDhqbDF1?=
 =?utf-8?B?SFkvb1J3QkJCdytCVFlSNUdYeHhMUWZ0UjJUb0FnQlFVQUZxVlBCRER3c01N?=
 =?utf-8?B?eDJQL1B6QVZzRjdPZ3BwSG1kVkxGdE1GV2lHemRJMndpcVdGWjB2OE5zeCtx?=
 =?utf-8?B?VXordG14VFpUQkNmUmFLSXpKeXh2Uk5pTjRseFovS2lQakVSU3hoWHJ2Nlp6?=
 =?utf-8?B?MVdFSEtaQjNYZkcwMEtrLzNIVUJQU01sN0xpQmhPdnRLMkhRSFBkc2hHY1Fk?=
 =?utf-8?B?ekQzVGVZbFN2SkJlUG1CSU1zeFZiWlI5clZ1ekhldWFGazJiTDAxWWl5Skwy?=
 =?utf-8?B?ejhQaG45K2pubTZKcVJjM2c4YnhLdTZueXBrNTBoZGZxV3FhbXM0M3RJTUFK?=
 =?utf-8?B?Z28zSEl4Y2NINCsxVW8wWUFWaC9jc2V0RlBIZDN3WFVqamdXaVFMOEtXcXZm?=
 =?utf-8?B?SE1UNnhoQ0hIY0NQOUFvVFVGZHR3bjRxRVRyanZCREE0RnFoMWNlbmlnZlhS?=
 =?utf-8?B?MW5NRmd4YyswQ2Y1VzVIV0s5bmtyTHBxOVYxdU53YkpKL1ByTjN1Lyt1NVFm?=
 =?utf-8?B?SzIvc08ybGlYc0ttK2gzbGFodHBPWTJwc1JZMnFhdGtTVGF2dUVJLzltL1Yr?=
 =?utf-8?B?cURQRE1lVURzbFE0V0t4RDVIMVhaNnYrcjM2cGQ3Wkc2VnQzY2loRUpQWWor?=
 =?utf-8?B?d05CZW5Cc2ZQUXFiblprYWMySkdWdnNFY294bExTUVNTWVRkTkxYdzFwMGNH?=
 =?utf-8?B?NElVTXRUamxjQ3JRNHlOdjVOTlNINlFJcjIyUFF6T1dFZVJzTy9uTHNpTmd2?=
 =?utf-8?B?UWpJNnVCNXZFOEEzbHZQUEVXZXFHWGp5TTMyV0xZdnAxQ0V0N01YOWREZ3Fz?=
 =?utf-8?B?dmw4MklmVFY3bUlRN0JzTUE3ZWNJWUhyUlVVSGF4VHE1WnlWakpDQUVJd2lq?=
 =?utf-8?Q?uOX+vkLg1ROq6mo7Ot7v/toBAMVp/Na7VE0c7E/3UC/TG?=
x-ms-exchange-antispam-messagedata-1: RRwaXeLlk0Gc2l1v2eE/gVVc5P7SRKgTuTg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <321F638CBCDC334DB4DC0DD3FA975195@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JOlRtc1BGKO3sIwew3jXjVsSqPNYMvlls0FpoD2fbCWrilAT/DjS/0gjzIB/7vbWX+VDk7QQn5vs37siw7/iHXE+K57aLhy8iegWsb1B4WfvWAq2NLYaZXylj/J6kHoWnpQ38EWmIeELee6lb2IJhgFQ7B2OZ+53bEz/xOgTzOhK7ygL1u216Do0JmuXTxZxR6hiAFQ7TgfRJuCbkMxr7QRFrqbSCaY7WM1XD/s/tS5DrEibf3WZI/ZEY3/QMe03dRZODl1a+mO2HavRa7353zvW3OhztpBNdFHGlNfeTcqOMgVYulv5roUemvmQrMIZj0CNkcHw4yJtWlkUSNJh3Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1EEGNN/3DOs2m6hjgEJqyeGzkpzCw64sse4trQq3x5M3bHy05pr1YGUAdF+WSWvYIOCm0TMp6o6nvpLkeSEhA5ngUdBtlTjNQJ6E2v61aHhIgaWHynw3WQgmmhzYwV+zovpj207w9NcrTP9EVIDn0L4gjz79QlehgMdbFUqEkzav0xq9KXRidXtmOmUF3yaLAI1cOZjjQEOsytwz0rALpzbwhxIePG7gGo4ae0lFWd6w2mAg/hGm1c0uOeh8KHNN9OySHzySCZY6k5LI2gRy2kPylCGuse/sdlGrO+TPYzHWePsVaPv8pdtHMzAJ5OWE9LkY/S6ZA8ZXvFeScmF8f/3G/jc73v/eivz5qi7miuWmh5KVeZ9iClxsFQPKH6Y3l0MO47332PCxqjHXNgX0SFO97ANZnJbSRt7YTXaCpZwxeQcfl+hFgwUHrLIg+Ku3k67gOa2WTUReYutL/uVmlkHtJ1u4Qh6P4SDY3IvzKuxh0U8Zg6rEKfNjIjA9QrhC9+dET6pT5qhGGlh2r2Sc1ZacPUrhJqciuAxw3GFSedSif1X25baOtJMxPBHsIRQl0XFvs438ZnBakY1Mo2G9V07Cyph2r0hW741JluOgX8rmzfjpyqt8gcbT91n2Oetr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e798374-1e61-4197-19e5-08df1845612e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 01:03:57.1835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u26SEGb4IzPT58EYMMWIAeuuebf3oope+4MDyYyZMn2DN19EbPCRxPQsiuPu3GwbT65aTP1afsTQlBYuB7vKUe4R+oTDi6VYWtT0RYy7Z6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7521
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=718ae7c5e=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTA5LTEwIGF0IDEwOjUzICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IGhl
bHBlcl93ZmkoKSBuZXZlciByZXR1cm5zIHRvIHRyYW5zbGF0ZWQgY29kZTogaXQgZWl0aGVyIHJh
aXNlcyBhbg0KPiBleGNlcHRpb24gb3IgZXhpdHMgdGhlIENQVSBsb29wIGFmdGVyIG1hcmtpbmcg
dGhlIENQVSBhcyBoYWx0ZWQuDQo+IEhvd2V2ZXIsDQo+IHRyYW5zX3dmaSgpIGxlYXZlcyB0aGUg
dHJhbnNsYXRpb24gc3RhdGUgYXMgRElTQVNfTkVYVCwgc28NCj4gaW5zdHJ1Y3Rpb25zDQo+IGZv
bGxvd2luZyBXRkkgY2FuIGJlIGluY2x1ZGVkIGluIHRoZSBzYW1lIFRCLg0KPiANCj4gV2l0aCBp
Y291bnQgZW5hYmxlZCwgdGhpcyBtYWtlcyB0aGUgZm9sbG93aW5nIGluc3RydWN0aW9uIHBhcnQg
b2YgdGhlDQo+IFRCJ3MNCj4gaW5zdHJ1Y3Rpb24gY291bnQgd2hlbiBXRkkgZXhpdHMsIGNhdXNp
bmcgbWluc3RyZXQgdG8gYmUgaW5jcmVtZW50ZWQNCj4gb25jZQ0KPiB0b28gbWFueS4gU2V0IERJ
U0FTX05PUkVUVVJOIGFmdGVyIGVtaXR0aW5nIHRoZSBoZWxwZXIuDQo+IA0KPiBBZGQgYSBUQ0cg
dGVzdCBmb3IgYm90aCByZXBvcnRlZCBjYXNlczogV0ZJIHdha2luZyBmb3IgYSBsb2NhbGx5DQo+
IGVuYWJsZWQNCj4gcGVuZGluZyBpbnRlcnJ1cHQgd2l0aCBtc3RhdHVzLk1JRSBjbGVhciwgYW5k
IFdGSSB0YWtpbmcgYSB0aW1lcg0KPiBpbnRlcnJ1cHQuDQo+IA0KPiBGaXhlczogNTVjMmExMmNi
Y2QzICgiUklTQy1WIFRDRyBDb2RlIEdlbmVyYXRpb24iKQ0KPiBSZXNvbHZlczogaHR0cHM6Ly9n
aXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vd29ya19pdGVtcy80MjMwDQo+IFNpZ25lZC1v
ZmYtYnk6IFplcGh5ciBMaSA8ZnJpdGNobGV5Ym9ocmVyQGdtYWlsLmNvbT4NCg0KVGhhbmtzIQ0K
DQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiANCj4gLS0t
DQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gUmVnaXN0ZXIgdGVzdC1taW5zdHJldC13ZmkuUyB3aXRo
IHRoZSBNZXNvbiBUQ0cgdGVzdCBmcmFtZXdvcmsgc28NCj4gwqAgY2hlY2stdGNnIGV4ZWN1dGVz
IGl0Lg0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFu
c19wcml2aWxlZ2VkLmMuaW5jDQo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5z
X3ByaXZpbGVnZWQuYy5pbmMNCj4gaW5kZXggYThlYWNjZWY2Ny4uZWJiYmIwMTE3OSAxMDA2NDQN
Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3ByaXZpbGVnZWQuYy5p
bmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3ByaXZpbGVnZWQu
Yy5pbmMNCj4gQEAgLTE0NSw2ICsxNDUsNyBAQCBzdGF0aWMgYm9vbCB0cmFuc193ZmkoRGlzYXND
b250ZXh0ICpjdHgsIGFyZ193ZmkNCj4gKmEpDQo+IMKgwqDCoMKgIGRlY29kZV9zYXZlX29wYyhj
dHgsIDApOw0KPiDCoMKgwqDCoCBnZW5fdXBkYXRlX3BjKGN0eCwgY3R4LT5jdXJfaW5zbl9sZW4p
Ow0KPiDCoMKgwqDCoCBnZW5faGVscGVyX3dmaSh0Y2dfZW52KTsNCj4gK8KgwqDCoCBjdHgtPmJh
c2UuaXNfam1wID0gRElTQVNfTk9SRVRVUk47DQo+IMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiDC
oCNlbHNlDQo+IMKgwqDCoMKgIHJldHVybiBmYWxzZTsNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Rj
Zy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0KPiBiL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3Rl
bS9tZXNvbi5idWlsZA0KPiBpbmRleCA4NjA0YzJhNDVhLi4yYWNhNjhlMDc4IDEwMDY0NA0KPiAt
LS0gYS90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gKysrIGIvdGVzdHMv
dGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IEBAIC0yMyw2ICsyMyw3IEBAIHRlc3Rz
ICs9IHsNCj4gwqDCoCAndGVzdC1tZXBjLW1hc2tpbmcuUyc6IHNldHVwLA0KPiDCoMKgICd0ZXN0
LWNyYzMyLlMnOiBzZXR1cCArIHsncWVtdV9hcmdzJzogWyctY3B1JywgJ3J2NjQseGxyYnI9dHJ1
ZScsDQo+IHFlbXVfYXJnc119LA0KPiDCoMKgICd0ZXN0LW1pbnN0cmV0LWVjYWxsLlMnOiBzZXR1
cCArIHsncWVtdV9hcmdzJzogWyctaWNvdW50JywNCj4gJ3NoaWZ0PTEnLCBxZW11X2FyZ3NdfSwN
Cj4gK8KgICd0ZXN0LW1pbnN0cmV0LXdmaS5TJzogc2V0dXAgKyB7J3FlbXVfYXJncyc6IFsnLWlj
b3VudCcsDQo+ICdzaGlmdD0xJywgcWVtdV9hcmdzXX0sDQo+IMKgwqAgJ3Rlc3QtbWlzYS13LlMn
OiBzZXR1cCArIHsncWVtdV9hcmdzJzogWyctY3B1JywgJ3J2NjQseC1taXNhLQ0KPiB3PXRydWUs
Yz10cnVlLHY9dHJ1ZScsIHFlbXVfYXJnc119LA0KPiDCoH0NCj4gwqANCj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtbWluc3RyZXQtd2ZpLlMNCj4gYi90ZXN0cy90Y2cvcmlz
Y3Y2NC90ZXN0LW1pbnN0cmV0LXdmaS5TDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4
IDAwMDAwMDAwMDAuLjBmZDAxNThkNWINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy90
Y2cvcmlzY3Y2NC90ZXN0LW1pbnN0cmV0LXdmaS5TDQo+IEBAIC0wLDAgKzEsMTAwIEBADQo+ICsv
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLw0KPiArDQo+ICsJ
Lm9wdGlvbglub3J2Yw0KPiArDQo+ICsJLnRleHQNCj4gKwkuZ2xvYmFsCV9zdGFydA0KPiArX3N0
YXJ0Og0KPiArCWxsYQl0MCwgdHJhcA0KPiArCWNzcncJbXR2ZWMsIHQwDQo+ICsJbGkJczMsIDAN
Cj4gKw0KPiArCS8qDQo+ICsJICogQSBwZW5kaW5nLCBsb2NhbGx5IGVuYWJsZWQgaW50ZXJydXB0
IHdha2VzIFdGSSBldmVuIHdpdGgNCj4gTUlFDQo+ICsJICogY2xlYXIuDQo+ICsJICovDQo+ICsJ
bGkJdDAsIDB4OAkJLyogTUlFX01TSUUgKi8NCj4gKwljc3J3CW1pZSwgdDANCj4gKwljc3JjaQlt
c3RhdHVzLCAweDgJLyogTVNUQVRVU19NSUUgKi8NCj4gKwlsaQl0MCwgMHgyMDAwMDAwCS8qIE1T
SVAwICovDQo+ICsJbGkJdDEsIDENCj4gKwlzdwl0MSwgMCh0MCkNCj4gKw0KPiArCS8qDQo+ICsJ
ICogVGhlIGZpcnN0IENTUiByZWFkIGFuZCBXRkkgcmV0aXJlIGJlZm9yZSB0aGUgc2Vjb25kIHJl
YWQNCj4gb2J0YWlucyBzMSwNCj4gKwkgKiBzbyB0aGUgZXhwZWN0ZWQgZGlmZmVyZW5jZSBpcyB0
d28uDQo+ICsJICovDQo+ICsJY3NycglzMCwgbWluc3RyZXQNCj4gKwl3ZmkNCj4gKwljc3JyCXMx
LCBtaW5zdHJldA0KPiArCXN1YglzMSwgczEsIHMwDQo+ICsJbGkJdDEsIDINCj4gKwliZXEJczEs
IHQxLCAxZg0KPiArCW9yaQlzMywgczMsIDENCj4gKzE6DQo+ICsNCj4gKwkvKiBDbGVhciB0aGUg
c29mdHdhcmUgaW50ZXJydXB0IGJlZm9yZSB0ZXN0aW5nIHRoZSB0cmFwDQo+IHBhdGguICovDQo+
ICsJc3cJemVybywgMCh0MCkNCj4gKwljc3J3CW1pZSwgemVybw0KPiArDQo+ICsJLyogU2NoZWR1
bGUgYSB0aW1lciBpbnRlcnJ1cHQgZmFyIGVub3VnaCBhaGVhZCB0byByZWFjaCBXRkkNCj4gZmly
c3QuICovDQo+ICsJbGkJdDAsIDB4MjAwYmZmOAkvKiBNVElNRSAqLw0KPiArCWxkCXQxLCAwKHQw
KQ0KPiArCWFkZGkJdDEsIHQxLCAxMDANCj4gKwlsaQl0MCwgMHgyMDA0MDAwCS8qIE1USU1FQ01Q
MCAqLw0KPiArCXNkCXQxLCAwKHQwKQ0KPiArCWxpCXQwLCAweDgwCQkvKiBNSUVfTVRJRSAqLw0K
PiArCWNzcncJbWllLCB0MA0KPiArCWNzcnNpCW1zdGF0dXMsIDB4OAkvKiBNU1RBVFVTX01JRSAq
Lw0KPiArDQo+ICsJLyoNCj4gKwkgKiBUaGUgZmlyc3QgQ1NSIHJlYWQgYW5kIFdGSSByZXRpcmUg
YmVmb3JlIHRoZSB0cmFwIGhhbmRsZXINCj4gb2J0YWlucyBzMSwNCj4gKwkgKiBzbyB0aGUgZXhw
ZWN0ZWQgZGlmZmVyZW5jZSBpcyBhZ2FpbiB0d28uDQo+ICsJICovDQo+ICsJbGkJczIsIDENCj4g
Kwljc3JyCXMwLCBtaW5zdHJldA0KPiArCXdmaQ0KPiArCWJlcXoJczIsIDFmDQo+ICsJb3JpCXMz
LCBzMywgMg0KPiArMToNCj4gKwlibmV6CXMzLCBmYWlsDQo+ICsJbGkJYTAsIDANCj4gKwlqCV9l
eGl0DQo+ICsNCj4gK2ZhaWw6DQo+ICsJbXYJYTAsIHMzDQo+ICsNCj4gK19leGl0Og0KPiArCWxs
YQlhMSwgc2VtaWFyZ3MNCj4gKwlsaQl0MCwgMHgyMDAyNgkvKiBBRFBfU3RvcHBlZF9BcHBsaWNh
dGlvbkV4aXQgKi8NCj4gKwlzZAl0MCwgMChhMSkNCj4gKwlzZAlhMCwgOChhMSkNCj4gKwlsaQlh
MCwgMHgyMAkvKiBUQVJHRVRfU1lTX0VYSVRfRVhURU5ERUQgKi8NCj4gKw0KPiArCS8qIFNlbWlo
b3N0aW5nIGNhbGwgc2VxdWVuY2UgKi8NCj4gKwkuYmFsaWduCTE2DQo+ICsJc2xsaQl6ZXJvLCB6
ZXJvLCAweDFmDQo+ICsJZWJyZWFrDQo+ICsJc3JhaQl6ZXJvLCB6ZXJvLCAweDcNCj4gKwlqCS4N
Cj4gKw0KPiArCS5iYWxpZ24JNA0KPiArdHJhcDoNCj4gKwkvKiBSZWFkIG1pbnN0cmV0IGJlZm9y
ZSByZXRpcmluZyBhbiBpbnN0cnVjdGlvbiBpbiB0aGUNCj4gaGFuZGxlci4gKi8NCj4gKwljc3Jy
CXMxLCBtaW5zdHJldA0KPiArCXN1YglzMSwgczEsIHMwDQo+ICsJYWRkaQlzMSwgczEsIC0yDQo+
ICsJc25leglzMiwgczENCj4gKw0KPiArCS8qIERpc2FibGUgdGhlIHRpbWVyIGludGVycnVwdCBi
ZWZvcmUgcmV0dXJuaW5nIHBhc3QgV0ZJLiAqLw0KPiArCWxpCXQwLCAweDIwMDQwMDAJLyogTVRJ
TUVDTVAwICovDQo+ICsJbGkJdDEsIC0xDQo+ICsJc2QJdDEsIDAodDApDQo+ICsJbGkJdDAsIDB4
ODAJCS8qIE1JRV9NVElFICovDQo+ICsJY3NyYwltaWUsIHQwDQo+ICsJbXJldA0KPiArDQo+ICsJ
LmRhdGENCj4gKwkuYmFsaWduCTE2DQo+ICtzZW1pYXJnczoNCj4gKwkuc3BhY2UJMTYNCg==

