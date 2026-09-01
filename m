Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D442C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Gq9-0000Nn-Jx; Tue, 01 Sep 2026 01:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1Gq8-0000NV-2S; Tue, 01 Sep 2026 01:15:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1Gq4-0003QW-Ce; Tue, 01 Sep 2026 01:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788239716; x=1819775716;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=M2wApvvDyaM23zTKhokHcnqikYM1zHaujNL3fHd3hmg=;
 b=GIYh4OxcarXqu9mh32r75vnxJbDFfIzKlim0v8IzW1rC+G+CrVU+XTYb
 OYS/MfH2OSou2Gryzf2Ez/T00EbuKSh6cAP+kZXbD7zQTnuxZlQ+cyYgD
 CeRRTfHeMUsY5QFZbolfhFH48sCjB4YnMUoTkNrwuZHshhfuARr+YaNJ/
 nRLaGnpalUdejY19PfwvWFN9unHqiWvhiAedNHbx6FzSVdrMV2ZbGZlGV
 HZcBedKqgre3IS9ZBS1LJxqMFNvjAaLmZh/CBo//9p8W6Ku8woDfcUwvx
 j1V2R0kYFLWAFOfv0VDj1Ymtp2cdCkWrMtblcIZCVegR8/OOX+69viocM g==;
X-CSE-ConnectionGUID: 6r3lyaxpTh+YnYFd+T1K5w==
X-CSE-MsgGUID: VGpi4+FPQua2y9t1cH083A==
X-IronPort-AV: E=Sophos;i="6.25,255,1779120000"; d="scan'208";a="153094630"
Received: from mail-westus3azon11012045.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.45])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Sep 2026 13:15:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEmwYiNLg5ajAn6cS84H/aHj1jtLrBKiuvbFlcR/a9/UFE2MynaXsXaGKg3kUzdaNUYIR5FwFZNT6rx1zF/gfpPnhVqxDmGYXZYp0eEc1Cc7sAwB+VzYonA8Zn4wGjxdtpHz0DHM1IBk2fwxZaofCT7G8n4JrbHifXZxNUif2lESe8oXSV3lwKQDhyxYrxo40rmw/pewR+eWR6agE4Mu+tBLakWJUrJSa8jM3qpeOYdBtUcFLD86HDc7WFZRB9lL5vDryltnfFEahi2JUFHZizDfLO/aqKtvglMP9AoN/G+2pWeiFHkMURPmTyfOyAdO1NT1acnPQQfMVTyNMOWC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2wApvvDyaM23zTKhokHcnqikYM1zHaujNL3fHd3hmg=;
 b=AR0VJ6tILIoU3lPWnlFWqowoEORF7Y7/DjQQRLaa3R8VjaJjPZDaIAfBw0qIF91f803lZKPlQkjlVP0E06rj3WHqEKOsbuZbvbHyX59QpF3JwIk6RjZI9mKD02TG5ZO6Mrw29PePVOx2Nc9jfcR/Y6D+VwOGkUs4vEj7PYii5ZAyUuw6G+Ec0qj9D2/x6S/QR5OWoyi5sVJPf22PR5jwokzy/KPrD92xMnDDajvInmRDJh62Hvj0G/aZav9o01KNh7NbYxKsvkYbDLu7t40FHw/UtXPYXfCK8TEq6QxQeJRNMzwy3yGt/vn6YBZLJQFVDeSuSdXLaLuwhbF2vZnQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2wApvvDyaM23zTKhokHcnqikYM1zHaujNL3fHd3hmg=;
 b=Exy8CmYI7T+n+x8e/8+Zs0ChSqCDJ7uXjevoVSG8s+nBbVENXMPlb66TXlHMfHmKmhZH8+ewJZ0Nx/WmyIC5RSzDVSh4y4dWhf2BOOSouIf2XqHzslm5Y3I8NZOLWXDHdEojz36pLiSC1aqGCzwQEPXUEct3wKYXYiGdlXLNN5w=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7617.namprd04.prod.outlook.com (2603:10b6:303:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 05:15:11 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 05:15:11 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
Thread-Topic: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
Thread-Index: AQHdNy1iL1hpWQUtSku7eDgrhJ9BH7a5M1yA
Date: Tue, 1 Sep 2026 05:15:11 +0000
Message-ID: <a0f974f049eb95ef117c788bb668548a89abd7e8.camel@wdc.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7617:EE_
x-ms-office365-filtering-correlation-id: eb54abe4-1712-482b-7810-08df07e7ff69
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|19092799006|1800799024|10070799003|366016|38070700021|11063799006|10067099003|4143699003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 0brzg6LmRVVXNDb0O3bYE9q0banVuRLU8gjSTAvKeZdW/KPqZ4EQP+hX5EipHbx8mloIojGqF0z8pX9HckajGSC/2wY/IUbps7aGHg4e0mFjuq1jGp2jfoGvKM+zSlglY4fKAweb+noaeijSMYA5j6rkySWCeSzC4zWL7DRx6HulDfTgC2S19DyGPxd5HwzRTVMK0xlVkiSDCDYdEAi/286ziqboQNFTRh8yGrIuK1rAhPK+m2BWGkjUKqrUyMtAEnhYJhJxa6fufMYnbCxy7dTo4j0YBYmiRxjYWpE9+/s9YXyiv+e5qjHyP5+9qnoc7KtIVxqglnPlQ7TbDWwtUUrP+wN3b8aaxNxbEnOvOZo38v9SpoyJzHVvwyHrJPcR+7wCaav3PHikQ2S1XYUOvPnHxz7GH77KWDW7W1cKjPqwjsffCmtBv3nZqTM4E8IlpmTfXaPf40z0MoIL4YoRETaR6PvPRWRaNV0teovbZgDAxWatvedexMhvBD9KdOfVSXYoYN/BcOnr99l7ASRuiv//NHK0N6D9Mv/q0TTFZLWVidSU9fM5mLtqUixwHoZdSOfE77dUnRPm1mthkIxnuyeM0ZlFwG0J875HzMTjUtNLI+xZ0aatQjzcH4FWQMvRxncnQYniXQKhGNfKsfDzLlu7mxFXMAu5vs91FTGndh39kPt4e/5mDMTNdE9H8wewztHT6yhBOo66KXgf/ahlGx0qxGML8KyWa9WHhnIqUR8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(19092799006)(1800799024)(10070799003)(366016)(38070700021)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTA5U1JDdEV2eXgrVnZzRHZKUFlhaG5GcXZXMXdGMWV6VkU4RDBxWnpnL29q?=
 =?utf-8?B?by9CQ1ZWNnNKQWJ1R1B3N3BCUTMxNDVwTEIvaGFRTFZuQUJJYitwV3BoSERJ?=
 =?utf-8?B?VnQ0YUY5T3lvMHNNVmdJVTZvU2VyeGJvZUVZM29zQ2R5S3BIcFhtRjZJZHZC?=
 =?utf-8?B?M3BaVjlvdGFRejZHa1BWUXJzMUNJd0s0aHZqeGtaOUZjbk1aTys5RDBvRWtv?=
 =?utf-8?B?M1RsZDVtc2E5QWVZZzIya2IvQS9uZERHbU13OHd6bG5TNXdHdXJzQ0YwMXQ1?=
 =?utf-8?B?ZVRBQytWcEI3QjF1eHJ5Z2VLMUppUVhTV2hkZzRQS0F2VHFqNFgvZjhhaGZT?=
 =?utf-8?B?TnNuRGYwRmNqR2t2bEM5TWx1aEQvNzR5amY1WTNNYTROVmpBVThDMS9IN01m?=
 =?utf-8?B?UDdhdFNlU0MwQy84M0d1cjFERXVIUzBBVGV1dXpDbWlsUWl2OWIwZ0hIcDNs?=
 =?utf-8?B?Vy9VaDlpK3poaUxuWFRpdTk0WkxNTlh1aWxnTFRZWGVTUy9Ra3U0YmFHQ1dh?=
 =?utf-8?B?b2FRc3BhRTRQc2xjcFlJZThBSGo1dmxXZU5CaG1ZUm0zTXpvdUlINXQyZlpR?=
 =?utf-8?B?Zk1IeHJYd21xTHVMUEdmMk9peWJadHIyeDdhNElkZFEzYXRqa1lTTXFQM0Zi?=
 =?utf-8?B?bDVHNkJkbzh2ZU9rZ25Vc25SeHNTU29VM1ZiZWpadVBEZHVCMU5sN25IZnhz?=
 =?utf-8?B?OXYrWHVaNmtBbVMxVEI4VzdwWEo1UUR4b1p5QjdZK3lFcFNNajAvcnhuWDRw?=
 =?utf-8?B?anBwR3BCaEw0WWNNTzM1NnI1YXF3RXF1Tm5wUE45MTlDN2lyaFZOeXlOdlRG?=
 =?utf-8?B?QmlnOTN3UkJxbVRMQTJZTTNydlpTbXJVb0Fwbk5QTVJHejczbVV2VG5RMDJ6?=
 =?utf-8?B?dkVxbFZwVkVadVFja1NGZk9KczdRd3lNWVp1d2QvRzFTcW5yNGVvN3JPbW9W?=
 =?utf-8?B?Tlp5a0VHV3ZqenNvWFZpVXJXUFZiNytyb21BQi90ZHgrckgzRlFWRU92UzVF?=
 =?utf-8?B?cm5kSkRnRFFlODlsYkJpeUZTd0t4elFXeHljV0N5cWdnb3ZRa2dhczVHR3M1?=
 =?utf-8?B?Rnh0VVd2cG1VS0hFU2xhdkI0ajlNODd1TFZVSjBZeFUvUGFTRVlPQXJVb3pu?=
 =?utf-8?B?V3RaMDFqWUxBaW1zaVdIUSt2ZDFoSGdUbndCMklkdGNCOG05VWpMajFPM0l4?=
 =?utf-8?B?eVRocmV4MWJnS0pDaW01b2I0QnB1ZG1aUUd0dldTZDhKb1FSV0NUNFpURTJl?=
 =?utf-8?B?QXliVlZkZWF5QW5UTkljNWFORHpjeWZQeCtLdFRKcVlmOHhBcWpzdzMrSE1E?=
 =?utf-8?B?OXRCaWliWTk3aEVPWkNvcmpCZDJqNWMvaHF2MUhPZHpndE8yVnVZR05kMEZz?=
 =?utf-8?B?TkZxS2g2ZG0yVjJTd3lQZmdiVU11MlBrWjkzMDZ5M05oandtWFVvOUwyaDgr?=
 =?utf-8?B?WDhCRDdrVTVQZm9SMXVPU0pjMmFpNXhpcG03QUtxTzcrSEkwdCswWmlWV3h4?=
 =?utf-8?B?ZXFHUEFKTU1TRTNxdk5yRFZpVlZjd0lhenBibll2QXpWV3h4bTFXTnNpeGd5?=
 =?utf-8?B?WUtnYVE3bjBpeTQvcEZyYWRPRGt5Qy9wa1VtYUZqSC9zZzgxZTZQZDRPOFlR?=
 =?utf-8?B?TWNaQVNKWkZXMFlTRGxNODUrTFAxM1ZBbmdMeDBPZlVPV1NoSHNLNWU4bVU4?=
 =?utf-8?B?aUVIZithR0VSVE1BZFlrdEJYbjYySjJUTC9nT3NFS2lhVnhEWGNUbzc3Sm1J?=
 =?utf-8?B?QlRVRmNpWXZ0ckJoeERmZ1k1NDlDYU0xVWVoQk42TkJ5b01qaUc2ZHVyNk9C?=
 =?utf-8?B?WEFXRlJRQm9TMktpZC9yTTVPdFlORWJQTWhLb1plQ1dyZUpVOHZubGxoRWJm?=
 =?utf-8?B?eUQ4QlJqNk8yd1MzbDJxemRZT0hsMStQVStZVkZFTHBjdGJaU0dVS25tU3RF?=
 =?utf-8?B?OU9LSWFRNkNPalBsMk52VkhTWFVub05LalpxMTJsSklSNG4wdy8vK011eWh4?=
 =?utf-8?B?Mk9vcUlBQW9QZUlMeEJsQ3d6RlVLNmgzYzNmU2QvREdqL0pIRFcrZVpsVDB2?=
 =?utf-8?B?V21lazhnUk80QmR3c25LTGw5Q0ZCV1IzZE1YZlVqejVpVjg0RlNZUkVSeFdD?=
 =?utf-8?B?ekw5OXJGMHQ1NzJoVUp5blFlaGQxUlF3MEhJNzZWUDZrenlscllCVk1ML0dt?=
 =?utf-8?B?TWhzZWRVTmNUSWM5cGhlK21rMjFBVFZjck9BM2RCaTZvQTVSdURlSTdUOWVE?=
 =?utf-8?B?ZVRYQkpabEtRMnI4Z0ljY3ZrdzY3aURWS2tkamdDcmxvb3h3Vkc0eGtaaC91?=
 =?utf-8?B?ZGRiNzY4RDZxazZ1M0xQUTJzY0dnQkUwYVBFZEluZ2hVU3g4UWppbzJUYm5p?=
 =?utf-8?Q?gXun6m/ed0ZAI+5yLS3GAonTT3faAxFj8k7To1/xc0A98?=
x-ms-exchange-antispam-messagedata-1: o5bdX56QSVfcCnLV4cBThjgQr4bC3qDIQyc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A693A6D62DC1064A896A3A071C8FCF1A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DbeWKHYxTf4Q8nnIv5XUzbHlPXofAbsy8E6KLOrD6fpH88FG8Ccs5ZHeTGhAGdBa+i1YzCgYriizFRnmu1DyWQBMNkX8Niegz5Ns1qiopZ397KTKAUOTjvPNktZbIc+SZVerSzadsmAYNSWk3+/yIigIaOMppMeeTVdWgdUTA3icbNlzhZZNzu/5xIGEMqEGIUCyiUL546FYwh58CWRQR/i2BL1+8DZqoHXHRPbc/NVUWkEj0vmb8SdLDHEs9nNC6JE7AVxjmFzAk5P73iTa/6f6KGN2RlyWRMcsMR4qFRvX8TuD718Ar/5C8SgHOx+3M8jN73A6N+t+A3BmCH0arA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2XgR5a39FxcVzkFYFLi0oKQqpfKdVlVmYD8SjlO1iNhhXg2O/xlGLVPEhdc2Pb/wMOLyDPBp1UkxEaBz7w4HS54PA6azBNZl/3wg3mhWvxtVuwtpeJHQn/2IU9Pw2jeQ3pSarfpsg1dYnNbFmsvaa/mQ0vKh+kyQdnSdQtsVUAn7bk0ErOLtmWHnyG2QpfFpJUc85IhnsPRU/qC7kTQWCHlCd9habMji7esmw8m8kNCcYQ/j6K4y1I2v6ZbSzE/e8EGsVGBcYUJ62rOExa1+VYUGvK8QkJpxOyt31cPT/P+FOwynssXZ/UYuZV/kG5ssAJ312NKY+RukQmmlobqdqsIHWg7newTfQs4A/8oAhqN6Wh3S/VjPHCqm4U9/eEcnCGQ7O/VSmvp6KDbH7AQSfWBBLwsbWYo/gtgYfO12ob+hBMUYuPKKVqI8eYPTOX/WAx4dq2ZiKSDeeD63UUdkmiZY7Lp7qSvmNp8SErwakvm1iNq5NLCXG4em1tfEAe2dJFcknoGqFYRHldwcSizLbi1hi67EzmYIe3DB1hGQkP4aSwLceTBML/EIzPqT972RGklpS+9gLzwIdyoDc1PE9zZOYVnVGVDlnNF+RgkO5F2qilgS5mGkFkVrSh+DJjAd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb54abe4-1712-482b-7810-08df07e7ff69
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 05:15:11.3666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adu4gWOGSVXNSuUMcqDO+yZ9yBlSYQIrUxEYM7Sl7gSQiARcyV+VUfSfqiT1eySa7VmvKa/gIM6DVcBrVmjQGBRLmeFXcaC/80v0O8BM+ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7617
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=6977d653a=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDE3OjM5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gUnVubmluZyAnZHRjJyB0byBnZW5lcmF0ZSBhIHJlYWRhYmxlIGZkdCBmb3Ig
dGhlIHZpcnQgbWFjaGluZSBwcm9kdWNlDQo+IHdhcm5pbmdzOg0KPiANCj4gwqAkIGR0YyAtSSBk
dGIgLU8gZHRzIHZpcnQuZHRiID4gdmlydC5kdHMNCj4gPHN0ZG91dD46IFdhcm5pbmcgKHNpbXBs
ZV9idXNfcmVnKTogL3NvYy9tdGltZXJAMjAwMDAwMDogc2ltcGxlLWJ1cw0KPiB1bml0IGFkZHJl
c3MgZm9ybWF0IGVycm9yLCBleHBlY3RlZCAiMjAwN2ZmOCINCj4gPHN0ZG91dD46IFdhcm5pbmcg
KHNpbXBsZV9idXNfcmVnKTogL3NvYy9tdGltZXJAMjAwODAwMDogc2ltcGxlLWJ1cw0KPiB1bml0
IGFkZHJlc3MgZm9ybWF0IGVycm9yLCBleHBlY3RlZCAiMjAwZmZmOCINCj4gDQo+IFRoaXMgaGFw
cGVucyBiZWNhdXNlIHRoZSAncmVnJyBmaWVsZCBkb2VzIG5vdCBtYXRjaCB0aGUgYWRkcmVzcyBp
bg0KPiB0aGUNCj4gbm9kZW5hbWUuwqAgVGhlIHJpZ2h0IGZpeCwgcG9pbnRlZCBvdXQgYnkgQ2hh
byBpbiBbMV0sIGlzIHRvIG1ha2UgdGhlDQo+IG5vZGVuYW1lIG1hdGNoIHRoZSByZWcgdmFsdWU6
DQo+IA0KPiAiSW4gdGhlIGN1cnJlbnQgUUVNVSBpbXBsZW1lbnQsIGBhZGRyYCBpcyB0aGUgTVRJ
TUVDTVAgYmFzZSBhZGRyZXNzLA0KPiB3aGlsZSB0aGUgTVRJTUUgcmVnaXN0ZXIgaXMgbG9jYXRl
ZCBhdCBhZGRyICsNCj4gUklTQ1ZfQUNMSU5UX0RFRkFVTFRfTVRJTUUuIg0KPiANCj4gSW4gb3Ro
ZXIgd29yZHMsIHRoZSAncmVnJyB2YWx1ZSBpcyBjb3JyZWN0IGJ1dCB0aGUgbm9kZW5hbWUgaXNu
J3QuDQo+IA0KPiBXZSdsbCBtYWtlIHRoZSBmaXggbm93LCBhbGxvd2luZyB0aGUgbmV4dCBwYXRj
aCB0byBtb3ZlIHRoZSBmaXhlZA0KPiB2ZXJzaW9uDQo+IG9mIGFjbGludCBGRFQgdG8gZmR0LWNv
bW1vbi4NCj4gDQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL2Fw
SEgxdXBuaDh1ZFVVVC1AQ2hhb2RlTWFjQm9vay1Qcm8ubG9jYWwvDQo+IA0KPiBDYzogcWVtdS1z
dGFibGVAbm9uZ251Lm9yZw0KPiBTdWdnZXN0ZWQtYnk6IENoYW8gTGl1IDxjaGFvLmxpdUBwcm9j
ZXNzbWlzc2lvbi5jb20+DQo+IEZpeGVzOiA5NTQ4ODZlYTZkICgiaHcvcmlzY3Y6IHZpcnQ6IEFk
ZCBvcHRpb25hbCBBQ0xJTlQgc3VwcG9ydCB0bw0KPiB2aXJ0IG1hY2hpbmUiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1
YWxjb21tLmNvbT4NCg0KQWNrZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5j
aXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqBody9yaXNjdi92aXJ0LmMgfCAz
ICsrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNjdi92aXJ0LmMNCj4g
aW5kZXggYTZlYzlkZWYxNi4uODNhNGI3NzEwZCAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3Yvdmly
dC5jDQo+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiBAQCAtMjM0LDcgKzIzNCw4IEBAIHN0YXRp
YyB2b2lkDQo+IGNyZWF0ZV9mZHRfc29ja2V0X2FjbGludChSSVNDVlZpcnRTdGF0ZSAqcywNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChzLT5tZW1tYXBbVklSVF9DTElOVF0uc2l6
ZSAqIHNvY2tldCk7DQo+IMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IHMtPm1lbW1hcFtWSVJUX0NM
SU5UXS5zaXplIC0gUklTQ1ZfQUNMSU5UX1NXSV9TSVpFOw0KPiDCoMKgwqDCoCB9DQo+IC3CoMKg
wqAgbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiL3NvYy9tdGltZXJAJWx4IiwgYWRkcik7DQo+ICvC
oMKgwqAgbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiL3NvYy9tdGltZXJAJSJIV0FERFJfUFJJeCwN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YWRkciArIFJJU0NWX0FDTElOVF9ERUZBVUxUX01USU1FKTsNCj4gwqDCoMKgwqAgcWVtdV9mZHRf
YWRkX3N1Ym5vZGUobXMtPmZkdCwgbmFtZSk7DQo+IMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3Bf
c3RyaW5nKG1zLT5mZHQsIG5hbWUsICJjb21wYXRpYmxlIiwNCj4gwqDCoMKgwqDCoMKgwqDCoCAi
cmlzY3YsYWNsaW50LW10aW1lciIpOw0K

