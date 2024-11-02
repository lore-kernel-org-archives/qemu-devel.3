Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D888AE677E9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 05:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t76P1-0004vd-Sq; Sat, 02 Nov 2024 01:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1t76Oz-0004vE-4n
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 01:10:21 -0400
Received: from mail-bjschn02on20714.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::714]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1t76Ou-0005mW-2N
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 01:10:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogMnO+Jdsx7aBJqDs9aGEftdaGUE1N0gdkF70Vd50qv3I0rb0O98qx2CBhh0nag6s13KLYxRXVfHB4uvW+PGUO1a7SWArlRExXKUc+HNJlnimS4vX7vaF4fP2M6PGWXGGrR/Ko97YLePwWVk167IWZbqaBVDsPGgB7fhRg+kfC8n9IdixTVsUilKMx6/bMYQQLl575Y9T1eL9a/2tx1KB64lnvyre7qDeQ+CWW4mYg3XsfgJHggGfo6dUD3xmOPsfkLJeeItkWHU78B3a09GCuLZPgS5dq2IXDmGEWnVYSBQanhReVGQxREetefDsTiHyXXNetON1P8YMk2+qJng7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqRCkrU2XhCNRPBhASNiR/t5D4auvRq27R/TuXQfd+E=;
 b=XcU5Zm35YrtdFbtDdYjiGcH2mqyZi+6hvPv3Tzdrl9ySXXYoa5DSQE/yrCze3mTKjM1ndHSj59oFu0XBiCrTRD6QiEDaXjwWQvcYB+/gQeRf9Bjq4ldiv0a0IvMiP3in+SlUMLQEPR+eysF71bbdSUUcaR4kg1GJTibJFVGXqtzBeec+kiL0+CEqp8CHYuzAvPaAwlViRxxpnfi0W4Vu+ZZUdT8ulo9SgITGLipb+P/M3HmVnPQkGFNfLa6fX10LfnESs2qfHh74zhLylvLTMsLR6RiNEQcVkOnSOzOKE/6kjKDCV8WXFgV93PxQOCcL6VnTB62SzvZUtLwk9Z4/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::11) by ZQZPR01MB1043.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sat, 2 Nov
 2024 05:10:14 +0000
Received: from ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn
 ([fe80::c2e4:9bbb:24ad:3c61]) by
 ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn ([fe80::c2e4:9bbb:24ad:3c61%3])
 with mapi id 15.20.8069.024; Sat, 2 Nov 2024 05:10:14 +0000
From: Demin Han <demin.han@starfivetech.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: Re: [PATCH] plugins: add plugin API to get args passed to binary
Thread-Index: AQHbLDyPsgVEn9ocvUKmJf5ZUtvEebKivGIAgACzPfI=
Date: Sat, 2 Nov 2024 05:10:14 +0000
Message-ID: <ZQZPR01MB1057EB3713C55BC9F53ADE5785572@ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQZPR01MB1057:EE_|ZQZPR01MB1043:EE_
x-ms-office365-filtering-correlation-id: 1ebdf1fd-b958-466a-ccda-08dcfafca27d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: dbDTRqlkjTUiczsa4TjGqVwHF2rfmS+MbelYpfiEjHG7naA0d+pIOKF3udxxhDADiMwoCTgVDOqVvpLv6w+TyeUz9ZimWNfQZ5Zj/n2o72zqQVZHnc8F1MH4vS84FnuRUSAf93eHbkIlXubXwnykskGX2fdXXROtahTw3H2sRxgG3rAuiSdNsUKAaukdSnKI880HDnhykBOgwb28XpyOj0ZNJd41whdZw/uMH9oEo83dyKwTBzs5EzAHxAisd4lgXWGs3xU+kHhuWUwtX0oEs8WJXxSvOX+Y4S0EfwsR2murZCBkLAf/+9xJdGTM2bA36DDzpXvht/0oW6hsl2NrGgIkzZVr1C2j4cKqXkZ8Bade15XBe/k6d2IWQFlTj7LNKNqL1T4eaE2YWXSTqXy+B4BeStz6m/HzLmUd5ICUOyuOVMkW27i7d/RAwGkEFObZN4L4xzCypQHBx5sIEQfWfuJ/f/Fc5KnDBJZ4zFYvslEVh3EaxdsJihlZMsIDwE/ujUBKgwuUtkTsptBZMn2JT8Ni0aQRfFC2Gdlqrsp7sazB9L7pjgxb14QH05Ygvh2S7s/h81eglJiahVAFlAwMOXH6NZj8nY1GvPbWzlIOthSqmMlFkhHqQ6zLWvQP1H6P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(41320700013)(366016)(8096899003)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RllNVlU1VUV1U2w1NHdyYXlGZFg1N1NZVVNuUWl3eVlEVTBhSjJxTTh4bnpQ?=
 =?gb2312?B?dVN0MmNwaGxER291cUIyZHVSSFFoYzFVRDFFWDVBb0VEdmVaU2xxRkZGSTR0?=
 =?gb2312?B?QWZEU05kNXRIYW5pb25SWHNMT2U5OUdkUVF2Qmhuc0NrS0VBb3c3K3ZMaUJv?=
 =?gb2312?B?ZTVubnlyWWZVbG8yU2N6UWVHdThtUHJZQUZKUDZZa1NYUXFiL3FyaGhLY2JY?=
 =?gb2312?B?czhhWERqN0F2dy85RFBiNDUxd0xyQjdGVExsMHRIclg4bFN4b1BCVTg1ODBX?=
 =?gb2312?B?Z3lKUlRRMDk1QUNkTHN2TEYzY3FPUUg0Tmd5d2htemZVQytxRkJQR0xJSjN6?=
 =?gb2312?B?UTIwdThMR1pWWjUra0Z3c045T3ZlVUxVVVUyV0hVdVk2TnppVTQvSXpXakU4?=
 =?gb2312?B?cFBobGNhVTdHYmpTZTUwMjJKb1JVYkNtampaMXhQMVFOcSs0aVliYTdOQ2sy?=
 =?gb2312?B?Z2hnWVkwbS8rTWZ0dUtWWjFmZU1PMDY4WHRabTdOdDRxNWUzbkR2SHpKdVR3?=
 =?gb2312?B?TWZXMUpSUlk2SE05d0xmZXkyMG9GcUlYSGRsandUQnV2S3VBUlhpbU00aURs?=
 =?gb2312?B?cTNzVVVRbGVOKzZSZVNSdy83U05ZYTBPaUdveFl3OFJLL3NENEg0KzV1TXBl?=
 =?gb2312?B?a1JlM1hzUmlmb003MFpqWnJEbHVpUnNzK2RVWU0wc2lyMG5kTWpBRzFBL3h1?=
 =?gb2312?B?aDE5blplKzlTYzBybHA4aDhUNlJjbHBscGRWb1dwMGtBZ1JRa0JXU0lzeTBn?=
 =?gb2312?B?dHBBUlE1N3pSai9mOUZGUEFaUDdkZ1c4TW1pdmN3dnFOODNXN1pTTFlXNTI3?=
 =?gb2312?B?aklmWDdCbEFDSXBLSnhtSkdtNitoYUN0NGhvMXNwZFVJVWNmN2UyZVZyNzMz?=
 =?gb2312?B?SUJ6aHNnL3BZRndNMVlPOS82SjBkbllPMjRkSGJsTi9CTzlNdjBnTHVRNnly?=
 =?gb2312?B?eklCeWQvSWs2dFlBRlVSVXh2UURkaW5qRmtNbCtwZ0ZLamd4bW15a0hPdkNi?=
 =?gb2312?B?UUlJQmN1ZEtzR0pyMkNBTUN3NEgyU0w3ME5iV09mWnpwK24rbE0yMEN6a0NQ?=
 =?gb2312?B?MjRYd0dSRlQ2bExkZ1FqUElmOEJWY05STUU4MEF1QjI2bktjTTlhV2R4WGl6?=
 =?gb2312?B?ZFhGWmJaRXRubjBkazJXai9sSWRiRXJjOTI3R2lGZGNML2JPa1hHbVVUUHU2?=
 =?gb2312?B?b0hOSStZUWJBa3RLT1RZY2pBM0d3a1ExNFpwV045SmxUbklwN2g1bXdkbDUy?=
 =?gb2312?B?UlExVUJ0SUluME9iK29IdzVla0pyekt2YmMrRHplM3ZseW5qb0VkOGVZM0Fu?=
 =?gb2312?B?Z1NjM29pdlViZlpNbFU3RjdLZ29Md1BKNUlWUjFvMDRPTFhMb0s2OC9WMlkx?=
 =?gb2312?B?NWdnWXVUNHNPRTBHNndHTXZQR21FMkVVZ3IvOXlkVnlzUmZDMzBHR0pvRit2?=
 =?gb2312?B?RjQ4UGhjd2lhQXVnUFNPaERKaHBhUS9UTnhQMWtLSmlycVpOeDlXQnp2Qlo0?=
 =?gb2312?B?S1dSNWpHV3IrOW5IRW9sdGp4L0JRdEJDUnpXdi9zU1ZITHFHV1hhNDRCYjZI?=
 =?gb2312?B?Q09jc2hOb3gxaFRZR3RUVk1mdUJxQkZvd3o0akF4TVNrZVZVNkRmQnJmaW1a?=
 =?gb2312?B?bGpkQ2N6R2xBbTh2V2prNHJ6R1ZsNjkzVktFTnlWb1AyN1QzeEFLZjNqT1Ex?=
 =?gb2312?B?dDYvME9jZlRyeDRCNFo0NlpkYzc3Nk1yakx2c3hEekoyK2J2MG56UHkrang5?=
 =?gb2312?B?b2pHREFsampFNGozOVlRRTEvN05sYmFFV0lOQzZGZDAraHhNajE0S0xtcDRI?=
 =?gb2312?B?c0ptdkp2cW9WZnhDdktHTXRWNG1NTkhpZmY4TEVHNUQxd3ptVS9COWFOT096?=
 =?gb2312?B?dzIyR0lMYkRMRWZoT0ZMWlhocjdtRVpha0tjNWhBUy93VWlIS1NHRnFuVUVB?=
 =?gb2312?B?RVNaU1hjNWJUVXJQcVpEMFpyNFkxS2xVcGs3R0FBRXZMY2gzZUV6a0txNXp4?=
 =?gb2312?B?dGxlUCtRalpZZlpsOHZTNmxwVVkyaVdPYm0ycVc3VVVIR1dDdU9zOXo1TlFm?=
 =?gb2312?B?QjY0WlFvenQybGNiR1paS1B4NjUwdlJSZEtNTHF1R0hhbG1vOE1CdXFaWmxl?=
 =?gb2312?B?b1F4K0l0UjNvb1UvM0dPcm5QWUlPL3Z2STJ2aHl1amlEdXB2aDVLSXlqSjAz?=
 =?gb2312?B?TXc9PQ==?=
Content-Type: multipart/alternative;
 boundary="_000_ZQZPR01MB1057EB3713C55BC9F53ADE5785572ZQZPR01MB1057CHNP_"
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebdf1fd-b958-466a-ccda-08dcfafca27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2024 05:10:14.4111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cP1pkT1ia4U6V8+v54qEY7OzLuEaTC8/QVJSXj3sMn1Il3QIOoDRcVbM0i07yDQk7HUHYFb71eP9Jj59sAl+OehYsBlRBmAdeIDmAUqiRVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1043
Received-SPF: pass client-ip=2406:e500:4440:2::714;
 envelope-from=demin.han@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_ZQZPR01MB1057EB3713C55BC9F53ADE5785572ZQZPR01MB1057CHNP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGksDQoNCk1hbnkgYmVuY2htYXJrcyBoYXZlIHRoZWlyIG93biBidWlsZCBhbmQgcnVuIHN5c3Rl
bSwgc3VjaCBhcyBzcGVjaW50LCB3ZSBkb26hr3Qgd2FudCB0byBjaGFuZ2UgdGhlaXIgY29kZS4N
Cg0KQWN0dWFsbHkgdGhlIGxvZyBtYXliZSBzdHJ1Y3R1cmFsIGRhdGEgc3VjaCBhcyBpbiBqc29u
IGZvcm1hdCBhbmQgbWF5IGJlIG91dHB1dCBtdWx0aXBsZSBsb2cgZmlsZXMgd2l0aCBkaWZmZXJl
bnQgc3RhdGlzdGljcyBkaW1lbnRpb24gZm9yIG9uZSBydW4uDQoNCi1EIGNhbqGvdCBzYXRpc2Z5
IHRoaXMuDQoNClJlZ2FyZCwNCkRlbmluDQoNCrvxyKEgT3V0bG9vayBmb3IgaU9TPGh0dHBzOi8v
YWthLm1zL28wdWtlZj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCreiy83Ksbzk
OiBTYXR1cmRheSwgTm92ZW1iZXIgMiwgMjAyNCAyOjE4OjIwIEFNDQrK1bz+yMs6IERlbWluIEhh
biA8ZGVtaW4uaGFuQHN0YXJmaXZldGVjaC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcgPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCrOty806IGFsZXguYmVubmVlQGxpbmFyby5vcmcgPGFsZXgu
YmVubmVlQGxpbmFyby5vcmc+OyBlcmRuYXhlQGNyYW5zLm9yZyA8ZXJkbmF4ZUBjcmFucy5vcmc+
OyBtYS5tYW5kb3VyckBnbWFpbC5jb20gPG1hLm1hbmRvdXJyQGdtYWlsLmNvbT4NCtb3zOI6IFJl
OiBbUEFUQ0hdIHBsdWdpbnM6IGFkZCBwbHVnaW4gQVBJIHRvIGdldCBhcmdzIHBhc3NlZCB0byBi
aW5hcnkNCg0KSGkgRGVtaW4sDQoNCnRoYW5rcyBmb3IgeW91ciBjb250cmlidXRpb24uDQoNCk9u
IDExLzEvMjQgMDI6MDAsIGRlbWluLmhhbiB3cm90ZToNCj4gV2h5IHdlIG5lZWQgYXJncz8NCj4g
V2hlbiBwbHVnaW4gb3V0cHV0cyBsb2cgZmlsZXMsIG9ubHkgYmluYXJ5IHBhdGggY2FuJ3QgZGlz
dGluZ3Vpc2ggbXVsdGlwbGUNCj4gcnVucyBpZiB0aGUgYmluYXJ5IHBhc3NlZCB3aXRoIGRpZmZl
cmVudCBhcmdzLg0KPiBUaGlzIGlzIGJhZCBmb3IgQ0kgdXNpbmcgcGx1Z2luLg0KPg0KDQpDYW4g
aXQgYmUgc29sdmVkIHNpbXBseSBieSBlbmNvZGluZyB0aGlzIGluIG5hbWUgb2YgbG9nIGZpbGUg
ZnJvbSB0aGUgQ0kNCnJ1biBzY3JpcHQ/DQokIGNtZD0iL3Vzci9iaW4vZWNobyBIZWxsbyB3b3Js
ZCINCiQgb3V0X2ZpbGU9IiQoZWNobyAiJGNtZCIgfCBzZWQgLWUgJ3MvXHMvXy8nKS5sb2ciDQok
IHFlbXUgLXBsdWdpbi4uLiAtZCBwbHVnaW4gLUQgIiRvdXRfZmlsZSIgJGNtZA0KDQpJIGNhbiBz
ZWUgc29tZSBnb29kIHBvaW50cyB0byBhZGQgdGhpcyBuZXcgQVBJLCBidXQgZm9yIHRoZSB1c2Ug
Y2FzZQ0KcHJlc2VudGVkIGluIGNvbW1pdCBtZXNzYWdlLCBJJ20gbm90IHN1cmUgdG8gc2VlIHdo
YXQgaXQgc29sdmVzLg0KDQo+IFNpZ25lZC1vZmYtYnk6IGRlbWluLmhhbiA8ZGVtaW4uaGFuQHN0
YXJmaXZldGVjaC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oICAg
fCAxMSArKysrKysrKysrKw0KPiAgIHBsdWdpbnMvYXBpLmMgICAgICAgICAgICAgICAgfCAxNiAr
KysrKysrKysrKysrKysrDQo+ICAgcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scyB8ICAxICsN
Cj4gICAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oIGIvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgN
Cj4gaW5kZXggNjIyYzlhMDIzMi4uZGFmNzVjOWY1YSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9x
ZW11L3FlbXUtcGx1Z2luLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4g
QEAgLTgzNyw2ICs4MzcsMTcgQEAgYm9vbCBxZW11X3BsdWdpbl9ib29sX3BhcnNlKGNvbnN0IGNo
YXIgKm5hbWUsIGNvbnN0IGNoYXIgKnZhbCwgYm9vbCAqcmV0KTsNCj4gICBRRU1VX1BMVUdJTl9B
UEkNCj4gICBjb25zdCBjaGFyICpxZW11X3BsdWdpbl9wYXRoX3RvX2JpbmFyeSh2b2lkKTsNCj4N
Cj4gKy8qKg0KPiArICogcWVtdV9wbHVnaW5fYXJndl90b19iaW5hcnkoKSAtIGFyZ3YgdG8gYmlu
YXJ5IGZpbGUgYmVpbmcgZXhlY3V0ZWQNCj4gKyAqDQo+ICsgKiBSZXR1cm4gYSBzdHJpbmcgYXJy
YXkgcmVwcmVzZW50aW5nIHRoZSBhcmd2IHRvIHRoZSBiaW5hcnkuIEZvciB1c2VyLW1vZGUNCj4g
KyAqIHRoaXMgaXMgdGhlIG1haW4gZXhlY3V0YWJsZSdzIGFyZ3YuIEZvciBzeXN0ZW0gZW11bGF0
aW9uIHdlIGN1cnJlbnRseQ0KPiArICogcmV0dXJuIE5VTEwuIFRoZSB1c2VyIHNob3VsZCBnX2Zy
ZWUoKSB0aGUgc3RyaW5nIGFycmF5IG9uY2Ugbm8gbG9uZ2VyDQo+ICsgKiBuZWVkZWQuDQo+ICsg
Ki8NCj4gK1FFTVVfUExVR0lOX0FQSQ0KPiArY29uc3QgY2hhciAqKnFlbXVfcGx1Z2luX2FyZ3Zf
dG9fYmluYXJ5KHZvaWQpOw0KPiArDQo+ICAgLyoqDQo+ICAgICogcWVtdV9wbHVnaW5fc3RhcnRf
Y29kZSgpIC0gcmV0dXJucyBzdGFydCBvZiB0ZXh0IHNlZ21lbnQNCj4gICAgKg0KPiBkaWZmIC0t
Z2l0IGEvcGx1Z2lucy9hcGkuYyBiL3BsdWdpbnMvYXBpLmMNCj4gaW5kZXggMjRlYTY0ZTJkZS4u
ZmEyNzM1ZGIwMyAxMDA2NDQNCj4gLS0tIGEvcGx1Z2lucy9hcGkuYw0KPiArKysgYi9wbHVnaW5z
L2FwaS5jDQo+IEBAIC00ODUsNiArNDg1LDIyIEBAIGNvbnN0IGNoYXIgKnFlbXVfcGx1Z2luX3Bh
dGhfdG9fYmluYXJ5KHZvaWQpDQo+ICAgICAgIHJldHVybiBwYXRoOw0KPiAgIH0NCj4NCj4gK2Nv
bnN0IGNoYXIgKipxZW11X3BsdWdpbl9hcmd2X3RvX2JpbmFyeSh2b2lkKQ0KPiArew0KPiArICAg
IGNvbnN0IGNoYXIgKiphcmd2ID0gTlVMTDsNCj4gKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+
ICsgICAgaW50IGksIGFyZ2M7DQo+ICsgICAgVGFza1N0YXRlICp0cyA9IGdldF90YXNrX3N0YXRl
KGN1cnJlbnRfY3B1KTsNCj4gKyAgICBhcmdjID0gdHMtPmJwcm0tPmFyZ2M7DQo+ICsgICAgYXJn
diA9IGdfbWFsbG9jKHNpemVvZihjaGFyICopICogKGFyZ2MgKyAxKSk7DQo+ICsgICAgZm9yIChp
ID0gMDsgaSA8IGFyZ2M7ICsraSkgew0KPiArICAgICAgICBhcmd2W2ldID0gZ19zdHJkdXAodHMt
PmJwcm0tPmFyZ3ZbaV0pOw0KPiArICAgIH0NCj4gKyAgICBhcmd2W2FyZ2NdID0gTlVMTDsNCj4g
KyNlbmRpZg0KPiArICAgIHJldHVybiBhcmd2Ow0KPiArfQ0KPiArDQo+ICAgdWludDY0X3QgcWVt
dV9wbHVnaW5fc3RhcnRfY29kZSh2b2lkKQ0KPiAgIHsNCj4gICAgICAgdWludDY0X3Qgc3RhcnQg
PSAwOw0KPiBkaWZmIC0tZ2l0IGEvcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scyBiL3BsdWdp
bnMvcWVtdS1wbHVnaW5zLnN5bWJvbHMNCj4gaW5kZXggMDMyNjYxZjllYS4uNTMyNTgyZWZmZSAx
MDA2NDQNCj4gLS0tIGEvcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scw0KPiArKysgYi9wbHVn
aW5zL3FlbXUtcGx1Z2lucy5zeW1ib2xzDQo+IEBAIC0xLDQgKzEsNSBAQA0KPiAgIHsNCj4gKyAg
cWVtdV9wbHVnaW5fYXJndl90b19iaW5hcnk7DQo+ICAgICBxZW11X3BsdWdpbl9ib29sX3BhcnNl
Ow0KPiAgICAgcWVtdV9wbHVnaW5fZW5kX2NvZGU7DQo+ICAgICBxZW11X3BsdWdpbl9lbnRyeV9j
b2RlOw0KDQpSZWdhcmRzLA0KUGllcnJpY2sNCg==

--_000_ZQZPR01MB1057EB3713C55BC9F53ADE5785572ZQZPR01MB1057CHNP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Hi,</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Many benchmarks have their own build and run system, such =
as specint, we don=A1=AFt want to change their code.</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Actually the log maybe structural data such as in json for=
mat and may be output multiple log files with different statistics dimentio=
n for one run.</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">-D can=A1=AFt satisfy this.</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regard,</div>
<div dir=3D"ltr">Denin</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
=BB=F1=C8=A1 <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Pierric=
k Bouvier &lt;pierrick.bouvier@linaro.org&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Saturday, November 2, 2024 2:18:20 AM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Demin Han &lt;demin.han@starfivetech.com&gt;; qe=
mu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>=B3=AD=CB=CD:</b> alex.bennee@linaro.org &lt;alex.bennee@linaro.org&gt;;=
 erdnaxe@crans.org &lt;erdnaxe@crans.org&gt;; ma.mandourr@gmail.com &lt;ma.=
mandourr@gmail.com&gt;<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH] plugins: add plugin API to get args passed=
 to binary</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Demin,<br>
<br>
thanks for your contribution.<br>
<br>
On 11/1/24 02:00, demin.han wrote:<br>
&gt; Why we need args?<br>
&gt; When plugin outputs log files, only binary path can't distinguish mult=
iple<br>
&gt; runs if the binary passed with different args.<br>
&gt; This is bad for CI using plugin.<br>
&gt;<br>
<br>
Can it be solved simply by encoding this in name of log file from the CI <b=
r>
run script?<br>
$ cmd=3D&quot;/usr/bin/echo Hello world&quot;<br>
$ out_file=3D&quot;$(echo &quot;$cmd&quot; | sed -e 's/\s/_/').log&quot;<br=
>
$ qemu -plugin... -d plugin -D &quot;$out_file&quot; $cmd<br>
<br>
I can see some good points to add this new API, but for the use case <br>
presented in commit message, I'm not sure to see what it solves.<br>
<br>
&gt; Signed-off-by: demin.han &lt;demin.han@starfivetech.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; include/qemu/qemu-plugin.h&nbsp;&nbsp; | 11 +++++++++++<br=
>
&gt;&nbsp;&nbsp; plugins/api.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 16 ++++++++++++++++<br>
&gt;&nbsp;&nbsp; plugins/qemu-plugins.symbols |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; 3 files changed, 28 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h<b=
r>
&gt; index 622c9a0232..daf75c9f5a 100644<br>
&gt; --- a/include/qemu/qemu-plugin.h<br>
&gt; +++ b/include/qemu/qemu-plugin.h<br>
&gt; @@ -837,6 +837,17 @@ bool qemu_plugin_bool_parse(const char *name, con=
st char *val, bool *ret);<br>
&gt;&nbsp;&nbsp; QEMU_PLUGIN_API<br>
&gt;&nbsp;&nbsp; const char *qemu_plugin_path_to_binary(void);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +/**<br>
&gt; + * qemu_plugin_argv_to_binary() - argv to binary file being executed<=
br>
&gt; + *<br>
&gt; + * Return a string array representing the argv to the binary. For use=
r-mode<br>
&gt; + * this is the main executable's argv. For system emulation we curren=
tly<br>
&gt; + * return NULL. The user should g_free() the string array once no lon=
ger<br>
&gt; + * needed.<br>
&gt; + */<br>
&gt; +QEMU_PLUGIN_API<br>
&gt; +const char **qemu_plugin_argv_to_binary(void);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * qemu_plugin_start_code() - returns start of text s=
egment<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; diff --git a/plugins/api.c b/plugins/api.c<br>
&gt; index 24ea64e2de..fa2735db03 100644<br>
&gt; --- a/plugins/api.c<br>
&gt; +++ b/plugins/api.c<br>
&gt; @@ -485,6 +485,22 @@ const char *qemu_plugin_path_to_binary(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return path;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +const char **qemu_plugin_argv_to_binary(void)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; const char **argv =3D NULL;<br>
&gt; +#ifdef CONFIG_USER_ONLY<br>
&gt; +&nbsp;&nbsp;&nbsp; int i, argc;<br>
&gt; +&nbsp;&nbsp;&nbsp; TaskState *ts =3D get_task_state(current_cpu);<br>
&gt; +&nbsp;&nbsp;&nbsp; argc =3D ts-&gt;bprm-&gt;argc;<br>
&gt; +&nbsp;&nbsp;&nbsp; argv =3D g_malloc(sizeof(char *) * (argc + 1));<br=
>
&gt; +&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; argc; ++i) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; argv[i] =3D g_strdup(ts-&g=
t;bprm-&gt;argv[i]);<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; argv[argc] =3D NULL;<br>
&gt; +#endif<br>
&gt; +&nbsp;&nbsp;&nbsp; return argv;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; uint64_t qemu_plugin_start_code(void)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start =3D 0;<br>
&gt; diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbo=
ls<br>
&gt; index 032661f9ea..532582effe 100644<br>
&gt; --- a/plugins/qemu-plugins.symbols<br>
&gt; +++ b/plugins/qemu-plugins.symbols<br>
&gt; @@ -1,4 +1,5 @@<br>
&gt;&nbsp;&nbsp; {<br>
&gt; +&nbsp; qemu_plugin_argv_to_binary;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; qemu_plugin_bool_parse;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; qemu_plugin_end_code;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; qemu_plugin_entry_code;<br>
<br>
Regards,<br>
Pierrick<br>
</div>
</span></font></div>
</body>
</html>

--_000_ZQZPR01MB1057EB3713C55BC9F53ADE5785572ZQZPR01MB1057CHNP_--

