Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BD1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1webvq-00077t-Jb; Tue, 30 Jun 2026 13:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Amit.Shah@amd.com>) id 1web4x-0004id-PN
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 12:12:55 -0400
Received: from mail-westusazon11012016.outbound.protection.outlook.com
 ([52.101.43.16] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Amit.Shah@amd.com>) id 1web4v-0005Xi-Pl
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 12:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0TBYFnX7w5oBK+voOw6dRkNYfG2h8IpprFk9QsR/0zlu+8IjQoZCdHYCGBZcti+/xCnJKW12TT4mEJJw5oM43IJMAWEoiH1fElQwmzko9g3R0iWhj1UrLuF47fnUZXE8Os7hbLeVO3kz6ZM2ZbWNFxbW3slvkpY0Ublb9oIn39e5l6pJkbjXpHG5bqgLmjvYgalVdZsuoZsv22AhgqtczkJ0smfdChMqIFQT+SUS926wsviixoT3NXgQT4l6zh//2n48u22tGzfvro0Z1rRiAuRoqvr/T+aa3g+xFA7jRMa2cmZCWBTRh6PKw0QVpRu20rdIrShGfKr11W2TsGUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LgL2ES9z9hQyIf3LE/0AHYb60ABgZCnWS+OLQyxmws=;
 b=tAniHhSYhlLk5bP3nstXFXadPZqlAdOX5jv4vp0hkjcTLWPvQDGiG+alBLuaiAB3FuuoldWN5MpAJoQ/myzWYjsEk5KMSwg0FHmFdgr5i4tr00SOqIggJpX+TsyCK/GPsfVgn7ymnS5T860FBPAkI3oxquwWl/fSZ+rXKojRJwhpyv53Cqt5y4NVKsDoXG7Y4gxoDibczycuN3tFnhBGMdu791cAV/hY30rsv9/kC2WXFcE76jGkzaiMmNoP3RTthLZBrX4XYKkAxY6xoEiW9Y2VP6JywDcb5o3s9HCk6RZxp33lPGnvot1Mu8KRuqNEkgCXaTV4smUzhQCU4PM3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LgL2ES9z9hQyIf3LE/0AHYb60ABgZCnWS+OLQyxmws=;
 b=vBrYuWy7QCacZowswE56xIykEySufdfh67AYQKlK6ou/TtrSpZLtRnQxRQkzKxR9WJ+/VHGCHASxmZtzqrbSPl1+Fuwr0iETU1Ouox4dUjp4QSjZeveGERTPKMkAUEVfspCOOPYMOrmDrfHKQfcYxTLyGdwDLBKQ2COrg7QgS10=
Received: from PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 16:07:39 +0000
Received: from PH8PR12MB6938.namprd12.prod.outlook.com
 ([fe80::c1fd:59c7:3010:58e0]) by PH8PR12MB6938.namprd12.prod.outlook.com
 ([fe80::c1fd:59c7:3010:58e0%5]) with mapi id 15.21.0159.016; Tue, 30 Jun 2026
 16:07:39 +0000
From: "Shah, Amit" <Amit.Shah@amd.com>
To: "Cheatham, Benjamin" <Benjamin.Cheatham@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH 3/4] target/i386: Add getting RAPSIZE for ERAPS enabled
 guests
Thread-Topic: [PATCH 3/4] target/i386: Add getting RAPSIZE for ERAPS enabled
 guests
Thread-Index: AQHdCKXZ+QAkhAhS0Ua34bf5A60jnbZXQ9eA
Date: Tue, 30 Jun 2026 16:07:38 +0000
Message-ID: <90c30873c4bd0c2a8b0da82c6571e17c6272cef3.camel@amd.com>
References: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
 <20260630153315.1585-4-Benjamin.Cheatham@amd.com>
In-Reply-To: <20260630153315.1585-4-Benjamin.Cheatham@amd.com>
Accept-Language: en-US, de-DE, en-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6938:EE_|BL1PR12MB5705:EE_
x-ms-office365-filtering-correlation-id: a569dd8c-fca0-437b-dfeb-08ded6c1b535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: /dHtvzBmO+H72pzIHsLjUcU+f345Z/Ys+yxROB3ryFST6JmE3TNB/qId0Dr1sbqzb5dpV8ztcwv4O5S50goax+kP2fBnYkrkpK9hIHS0y2zQHNAaeQXBvkS4d5/+81mVq/Z/rWe0HqcOvEcnEJ5SpNlv5xbLkZHuYZ5YclVFvx3Vezw0oiY3/Ry05t9PVBqcBvQdoTxTT7r+AvZPqnzn7ZaZqgtfLekO0Lh0FBMNtsyZIE0sut5caIDi9ubaXIxmDyd8RBlKPlitNIM3k/Q+7yAqpyLbfWeukKAdGt12HMgeraDMueBX1BQ6/sR91L3qzOJf37plNvMmW+WWmOAabpGHQ95W8yt/WVffSjuAvBcID7sTszePU+f+e3sKlZODah8FPKVFdvR3eBKndZ9PnkdXvr1h2+Xvf+zzdTarEqdHjl79bLD9aekYh9ZMZT47OIewORpweZVDMgPQCppZB8KpfAaGUCIJrOrLaBg8fPDu9hkbmNie9DQMtD03CP1O2Y10W0X3ANtEiPEMjRxLko8qFK41fZlcv8KiRAfohOLnJqNLqnfspEkM3MVe0zFW5LxNDrvU21HzH9NT2A4XFbqnBZ7zuxH8+mTiobbXHw1RfjCvG6FyZJsBtJoNNpSsMOXf24jF1ThQzrwoz7L9PBmtqCp+qtVRsJwOJ5LSSq16nuSjMQOpcvkAqOWMZLc+AzGZCxeRiTaQ5LbbJZWIGBQYXQgcNh2r0Q6p/e8g5Rs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFk0bjhTT2ZpYXovWUljbEZZdVJ6WVd3ZlVYY2EvL3dURm00N1gwVk9yb3gz?=
 =?utf-8?B?WW4xZFJzbFBTWkIyclFGd3o4WmJqcy9vejMvRFljYXMxQStjM2Z4bW1RVEhQ?=
 =?utf-8?B?MzNLZ2xLRkpIdzdxQTNsZUs3RkYyeDM3emlQSzlQWG9aTi92QWtPLzhNVUZV?=
 =?utf-8?B?WWFQRU00VzFNOWJOdzZpRW5IcHRnZ28vMmZMWERoTFdpdXBQWEdWZkFjM0Jp?=
 =?utf-8?B?WnI2OVc5ZVl2dytseWlXMTIyTzNxb1J3WWh4OWVQTXVPSzJyOTQwa05ic1Ey?=
 =?utf-8?B?R1dQSjRDT3ZZZ2VKNEl6cDRZdUlqTHBNOWRmOEpTQUk5bXZSZTZZb1U2RGRz?=
 =?utf-8?B?R2FyWXRUeW9mNTVYWmovVHRIYlo2N0JuZHVSbzRJdmRQemJMNFJQM0dkc2di?=
 =?utf-8?B?SEpHeDNtejlQVTNIQkgrQndZeXh1dkc1WjdLdEMxUldCbTdmeUVSeVp3bmsr?=
 =?utf-8?B?NzY0d213U0t6bHpHNjBRVUVFOXBaMklyMWJBVWV2VDR1YmRMUkQ4eGVqdHhD?=
 =?utf-8?B?MEFmVEVyZzh2eDZqVUZETVRWbTBSdmZ2Znk1QkVhZ1VwTHVyZ3pzRS9rZW93?=
 =?utf-8?B?eWZzdGlDcG8zV0ljR1puNFdUVzQ4amVwQ2N2SzE1RjB5aDV6alJZYjFmR3RH?=
 =?utf-8?B?NDFVWVQ5NHdLZEpNd3VzQ2NpWlhVangyOUhoTGpzWE1qbm42TnBKa1JPME1T?=
 =?utf-8?B?SE5lR0FiL3R4cmRhZDZ4UDlnV0dBWURYT1k2MXVoM2ExdGNTdHRFR0lMRUlt?=
 =?utf-8?B?UG9MaEgyUFBUc3ZEUjFXelljNlo5ZFBIS3RKRHkwV1VtZ0d1SG0wSGlodWVF?=
 =?utf-8?B?cytBdlNuVXl4WE5rLzdaNVExc3FSNElZRlpjVmxBcW5XenR4UTdiKzFJVzFx?=
 =?utf-8?B?NngxUUR3OUJOSE5qRG1BakdzZkUya3VIT09RVk5xNVpQZk4ybmlNaExYVith?=
 =?utf-8?B?anFVWHdrR0JOQUFFaE5iWTdrNSt5QXViNXRoVFpSNzd4eEY4alFVYzMyZWlv?=
 =?utf-8?B?NWl2SFMvY1pOL2JmeEREeEovaDVwSWc0MFN5UGVVckxENDFOUkRkYmY2Yys5?=
 =?utf-8?B?VlJkUkhQaTJ6VktFd2svZWJ5cUdzL1JRV3lRa2VGWnhOQldqRkRLdTU4eFBO?=
 =?utf-8?B?WWFaU2pIZVpKWitRTnZrQVM3dXo0c2dDNlh4Y0dtMyszeUp6UW1ycDhkUUdn?=
 =?utf-8?B?UmJKN1R5ZVByTVdmYXpnNzNXc200dG9sSW5IT2lEYUw2UG9taytKcGY3dlA2?=
 =?utf-8?B?Y1Y1L1YzL1RKc3gveUloZ3Y0Mkh3MWVLRkRRdDlmWDkzeGRTbHhZMDc0QWU5?=
 =?utf-8?B?b0ZUVDI5Y0NFZHJWdXdDS0VmT05SekpzZnZLKzlHdDlRVG83UmxlNTdLYVJy?=
 =?utf-8?B?TjhZZTVjM0VGM1ArMlRqbkh4aldvNVRFSWZYL2w5VE9saDNBOC9mOG5FTnBN?=
 =?utf-8?B?TG5JaEZ1TXNwN2kreDRSaEJYbjlEUUs1R0IvSDBQQWxCWFE3ZU16U1BUZzV4?=
 =?utf-8?B?WGpLUlBHL0VqQVpiWUg1MU54MHpnS2x6NU1UUy9FQkZUMFNiU2wraE00R2Fo?=
 =?utf-8?B?RmRyeGZILzZHY3RIajQ4aUlqV1YvS1EvRm9jNXBtMDdjTVRVazlLK3hoaUhI?=
 =?utf-8?B?T2tZaGh0YWlVakVKNGRIQUVqNXlhcWt0NGo4eitqMi9GRHlTNWI4dy9QSG8v?=
 =?utf-8?B?T0RKeXVPV0Jzc0FJOUZGWXhkT3JzVU03YUI1TEwvRFVXZWVrVHZ2RzkvVUh5?=
 =?utf-8?B?a2RBUTdhZW1wenh2dmIyM2lyMmdiNlBvNERzc0VMQjVaOFpSNklnZXppT0FQ?=
 =?utf-8?B?ZXJKYmFXQ1A1YW9XaVNicVB6dlY0QW81VFc0WGVQZTJLaUFkVDFnSDNmdEhG?=
 =?utf-8?B?QkdYMU03Ym5PdlFZc2VuNHRwakhrS3J0TkV5c1NCSHI5L2NIUDdWcHJQdzA1?=
 =?utf-8?B?SzZPa3BadUI2T1VUdVFrbWVqNEZieUw2b0NqdVl3Tit3ZUlodzZ0eWFmMXIx?=
 =?utf-8?B?M29IM3pzVElHTndpMVM0blBJVXhhMWJ0ZUh5azg2NEllVUhjazMwdmk2U3Zw?=
 =?utf-8?B?TUtKYUUrSHFkeWl5bFJ4Zk9JdlF0SmY2SG5UY3JiL29na0NpM0ZaWjVTSUww?=
 =?utf-8?B?U3ZSblVVSWpsbkNtQ2VwazNmM1RkSXdMdnJHdklPSGJ2V20wckdtUlM5M2dw?=
 =?utf-8?B?NnI4Z3RoaXNuMFBkOUcxdldPck1lM2FUcFNyNmpCM2p4ZjFJMExFNUtGUEM1?=
 =?utf-8?B?SGk2b0psMWFYN20zTjFDWFlYMTF5Z012UndhbmVKS0txenoyeHM1R1pvYVZV?=
 =?utf-8?B?YXNIaEQ4ajRjMDljMDlhZTRxTUFFNWVkRGxCcGE4YlZKUG1mVkJrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDD1648F4DC9064DA2D3C8B9BCE64DE1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a569dd8c-fca0-437b-dfeb-08ded6c1b535
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 16:07:39.0122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvOGhvB1xx7PdxazKr3BAO1jFEPx7foC8NQTZ0BAb2KMus7KsHvD/4ngm1btiY8hF1hYT7R/WocCacwrWjIavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
Received-SPF: permerror client-ip=52.101.43.16; envelope-from=Amit.Shah@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2026 13:07:29 -0400
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

T24gVHVlLCAyMDI2LTA2LTMwIGF0IDEwOjMzIC0wNTAwLCBCZW4gQ2hlYXRoYW0gd3JvdGU6DQo+
IEZyb206IEFtaXQgU2hhaCA8YW1pdC5zaGFoQGFtZC5jb20+DQo+IA0KPiBOZXdlciBBTUQgQ1BV
cyBoYXZlIHRoZSBFUkFQUyAoRW5oYW5jZWQgUmV0dXJuIEFkZHJlc3MgUHJlZGljdG9yDQo+IFNl
Y3VyaXR5KSBjcHVpZCBiaXQuIFdoZW4gdGhpcyBiaXQgaXMgYXZhaWxhYmxlLCB0aGUgc2l6ZSBv
ZiB0aGUgUlNCDQo+IGlzDQo+IGluZGljYXRlZCBpbiBFQlggYml0cyAxNjoyMyBvZiB0aGUgc2Ft
ZSBmdW5jdGlvbi4gQWxsb3cgdGhlIGd1ZXN0IHRvDQo+IHVzZQ0KPiB0aGVzZSBmZWF0dXJlcyB3
aGVuIGt2bSBpcyBlbmFibGVkIGFuZCBhcmUgYXZhaWxhYmxlIG9uIHRoZSBob3N0Lg0KPiANCj4g
Tk9URTogVGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBpcyBmcm9tIGEgcGF0Y2ggbWFkZSBieSBBbWl0
IHdoaWxlIHRoZQ0KPiBhY3R1YWwgY2hhbmdlcyBhcmUgYSBzdWJzZXQgb2YgdGhhdCBwYXRjaCwg
aGVuY2UgbXkgQ28tZGV2ZWxvcGVkLWJ5Lg0KPiBBbWl0LCBsZXQgbWUga25vdyBpZiB0aGUgYXR0
cmlidXRpb24gbG9va3MgZ29vZCB0byB5b3UuDQoNCkxvb2tzIGdvb2QsIHRoYW5rcy4gIEJUVyB5
b3UgY2FuIG1vdmUgdGhpcyBibHVyYiBiZWxvdyB0aGUgLS0tIGxpbmVzIHNvDQp0aGF0IGl0IGRv
ZXNuJ3Qgc2hvdyB1cCBpbiB0aGUgY29tbWl0IGxvZy4NCg0KDQo+IFNpZ25lZC1vZmYtYnk6IEFt
aXQgU2hhaCA8YW1pdC5zaGFoQGFtZC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogQmVuIENoZWF0
aGFtIDxCZW5qYW1pbi5DaGVhdGhhbUBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCZW4gQ2hl
YXRoYW0gPEJlbmphbWluLkNoZWF0aGFtQGFtZC5jb20+DQo+IC0tLQ0KPiDCoHRhcmdldC9pMzg2
L2NwdS5jIHwgOCArKysrKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuYyBiL3Rh
cmdldC9pMzg2L2NwdS5jDQo+IGluZGV4IGE4NWNjNjc3MDBmYS4uOTM0MmNjM2NhNGM2IDEwMDY0
NA0KPiAtLS0gYS90YXJnZXQvaTM4Ni9jcHUuYw0KPiArKysgYi90YXJnZXQvaTM4Ni9jcHUuYw0K
PiBAQCAtOTI5Miw3ICs5MjkyLDEzIEBAIHZvaWQgY3B1X3g4Nl9jcHVpZChDUFVYODZTdGF0ZSAq
ZW52LCB1aW50MzJfdA0KPiBpbmRleCwgdWludDMyX3QgY291bnQsDQo+IMKgwqDCoMKgIGNhc2Ug
MHg4MDAwMDAyMToNCj4gwqDCoMKgwqDCoMKgwqDCoCAqZWF4ID0gKmVieCA9ICplY3ggPSAqZWR4
ID0gMDsNCj4gwqDCoMKgwqDCoMKgwqDCoCAqZWF4ID0gZW52LT5mZWF0dXJlc1tGRUFUXzgwMDBf
MDAyMV9FQVhdOw0KPiAtwqDCoMKgwqDCoMKgwqAgKmVieCA9IGVudi0+ZmVhdHVyZXNbRkVBVF84
MDAwXzAwMjFfRUJYXTsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqAgaWYgKGt2bV9lbmFibGVkKCkg
JiYgKCplYXggJiBDUFVJRF84MDAwXzAwMjFfRUFYX0VSQVBTKSkgew0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqZWJ4IHw9DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdm1fYXJj
aF9nZXRfc3VwcG9ydGVkX2NwdWlkKGNzLT5rdm1fc3RhdGUsIGluZGV4LA0KPiBjb3VudCwgUl9F
QlgpICYNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENQVUlEXzgwMDBfMDAyMV9FQlhf
UkFQU0laRTsNCj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoMKgwqDCoMKgICpl
Y3ggPSBlbnYtPmZlYXR1cmVzW0ZFQVRfODAwMF8wMDIxX0VDWF07DQo+IMKgwqDCoMKgwqDCoMKg
wqAgYnJlYWs7DQo+IMKgwqDCoMKgIGNhc2UgMHg4MDAwMDAyMjoNCg==

