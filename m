Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FD5C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgxPn-0003R7-JS; Sun, 03 Mar 2024 20:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rgxPk-0003QD-SH; Sun, 03 Mar 2024 20:46:48 -0500
Received: from mail-psaapc01on20720.outbound.protection.outlook.com
 ([2a01:111:f400:feae::720]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rgxPg-0005KK-FJ; Sun, 03 Mar 2024 20:46:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frWc1MVQ7aa5DZH2ZiuG7+sBBHS1UEhvtL3Pr8nJeS72RubitFGEUtT4ZZyhG44go2ojK934uhFZH8jaHJzfppzFJKspGhR9sYjR2296F7KwpuRO9igG60pG67a7Bgs/3jZCSIwIoYxmqi1InXJidLHPD9CXufye2o0RNw/39cRBJHNM+f/N3OPOgGweCOEqcNfOgKKgmg2uCF++xfR3QuJsjxYzR4gkUi9BATb7hq6w54KvX9BziS0xocgnsdChdKgZJIlyWShF2dyDyIb8f1fjRcW/ngk71yCkYavWQiw3ve+Jr32VEUcatTM0ZjZGefP/Ynj/z86fL8eOeyAtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq+Ogogwq2NQ7/xXMgYMah6eUVxhDIdeF+enblWB7jo=;
 b=GyN3QxIwqyFWV1GZmK9luZCzD/Sr2xtkNJ4LkQR9uVmxHGVjTsVROo8/W1/O4nO8ed7rk3X7zMnIsj6cb767ZKuN7bMTSCch85Ld+1pkbIKk6o791goHeld+/4cVDRUt9cqPxp9ammGzoprB+gmuS/XSqyFDBoyod5uIo6wXFa7cwzwgAbywQY9CFEToawpo81upksqHiw/ZsovtqSsmVM+XvC8hNrk9TZSFsKqPbhgiyClxo2FpztQo01yZsMakfi6V3W773JPsyn+TzQEJJIki9IqAqmvcg/5cuzqsLDu1svisXfbVnAJCmFedMn6F7RJRbzDx3/ZzgVmxg3wzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq+Ogogwq2NQ7/xXMgYMah6eUVxhDIdeF+enblWB7jo=;
 b=W8GVHW0WmYHCCUMrJiyIcWF5wQiL8098Lv/SVNFiW0Zp1WnBBZFoHz+cps1g2eSdpS4DRi8GFHr9eYbKE+KbYyoVocmjzXQgGk3H4+3zSiorRDCDuagCysQM2LCFNMEaPi6KYoWe4h3E02OrReb2dfhvT9cleoqZJtZtqYnMihJ2S5Gp9sEPt7iVYfxzWa8+XPMggxjZ28CyqbiRS7uMEdE+PcDppfMywlDRP+yp8JS8lLkesp2JBlO2ON82CQgUAdiDn0dk5dB76D2nYcruRXt+7xxoDXMw1bZtrdNZIaD7VvikiRbDF2bCDERkoKyFukGrt+Kwrg84sehP0BPTnw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB7372.apcprd06.prod.outlook.com (2603:1096:405:9b::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.32; Mon, 4 Mar 2024 01:46:32 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 01:46:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PULL 2/2] aspeed: fix hardcode boot address 0
Thread-Topic: [PULL 2/2] aspeed: fix hardcode boot address 0
Thread-Index: AQHaaXvNgomQZD51X0GcrdHzK2AKnLEjDOiAgAPLd3A=
Date: Mon, 4 Mar 2024 01:46:31 +0000
Message-ID: <SI2PR06MB5041357F8C72141B5BCC801EFC232@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240227125201.414060-1-clg@kaod.org>
 <20240227125201.414060-3-clg@kaod.org>
 <eb260acf-859f-4b48-a2eb-2aff8416620a@linaro.org>
In-Reply-To: <eb260acf-859f-4b48-a2eb-2aff8416620a@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB7372:EE_
x-ms-office365-filtering-correlation-id: ec64ca99-75e5-444b-da61-08dc3beceaec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WkjK063m69C4Hnb8BOZvXud9YuUt/wxGnZv1DgVMoS1nOPwUY+P+kEbMVZ+FLfGGKi1qL+yKV/u/U7G8xjR1XfvSDi0/fxHT1KUC0TniNhYXr4PcbF6QKkfcykBHn+fMgg52Nhq2DNWUr8Oly4p/XPbOWHo5x0Eiyj2tVvV6VQVzFZqrnbQhG1xjlPE1MXMT5m3H8As1hhJgmdEar7uIQLHbzE7lJ5LHsZSmjtDBqUUUcr7rUdSnlOusAk2QwrAel1wlRvttp+8cq8LP8M6AD9awCrsUWlHodJkJThgIlWZ5TWyoC7QIKZCur50p6GEikY0AnH4LDZLLhSR2MG6M6pkqHNionAMW0kNydRjNMm2ghFs/0joHVtVrsR1PWNqHtxgfuY0Q4foKbwBp+L84Mnjjg5SHy0P9PRux2TWQpFfh0uLfb8jRESkeelr9Woegvkp20sDU5nCcL0dgptDLJFeaGXNDqrDdCsqgtpRHuEdBFmV/do7zxSGzB6krlNV5TZ3CMv3q/g0U6zjp3o0e8RP+e8K4yEfnUcpwds3o9R9NSBFLwkExZg/YzanBZy6ypLSk7Dee/Pl3K44A/2eNnLL89X6CmtNtQhmF3T2OgiTQM1Sygd7ox+xOsJV3HXF81dErBlXcGEsPPfBWNWsFSbXL6126M+O2r0eXBprznAQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHdrMDVVamU3aTdjQW9UMkJlZWw1Q041SDdsMU5td0czK3FTZW5rZ01XTDd6?=
 =?utf-8?B?QnN3Q0FWenh4M0s4Z2QvRFJzdnNIZnRzbm1HN0E1K1lSUnZneHNDdnJvQ0l2?=
 =?utf-8?B?bUZqRTZIZUE4cWJOeUFGY0NVdm1ZY2pVMjZDSm1VT3ExaGIxc2FtV0ZtQTM2?=
 =?utf-8?B?b2I1RFQySGFHeGszdkZpRjZyOFpHdS9wV2ltUGhvSS9LMVMyZlQ0YVJoUlpz?=
 =?utf-8?B?M2Vza2dWNWwzUFFvTnBCN3VETm4xZTBzdkppRERaa1BIWm1sVWVXZFAyU3c1?=
 =?utf-8?B?Z0U1eUtiSEJjMWFmVndWRkJpSDluNTd5cEIxR2RGLzBNa05LMi9yMERZaTR0?=
 =?utf-8?B?dHJnOS9GYXJyZU92V05UN2l5YWxFdWh2Nkg0U2hlNUJoeVcvOWRLQ2pZQnlQ?=
 =?utf-8?B?aDVWd3BTOUt2ck1zVDBCTnBXYnY4UzRRb3JCYjlUcmlIaXQrV0tEa3lQbnNu?=
 =?utf-8?B?RVBMTGp4SERTZlZSNmFjOU9OQ0hBTWJXTzh5RldXNU03eWFCUkVuWkdlRHM3?=
 =?utf-8?B?QnZCWHhZRU9YK09hNHBLRmh0QVozam5iaHRoQW5VajNTRWpORVRUUkY0MVIy?=
 =?utf-8?B?ZW51Z0pTVFV1eVE3aldORDgweFdPTmJDMUdXLy9KZDJqVmxZN0x6cU9pUERL?=
 =?utf-8?B?WFM5UGZsK1QwV1RRUVBxemhpNC93Z1BGa3I3bVZvc1UrM0E3K1ZFSUR2U0lR?=
 =?utf-8?B?ekR2K1FsMk43emxvK3VvTmwxUk10RCtBOWlBWXhMbmZYYzQweFQwVnpHOEZ6?=
 =?utf-8?B?OFRJb0xlRHdkYW5IVEZiQ25qb3JLM3VjZDJuZkFRSDRMMWd5dDk0Sk9NRkRH?=
 =?utf-8?B?WC8wWmE0WnhrQmhlZU02SHVhNUlML3gvazVaald3dVVyRTBxRXRYWlBRSWMx?=
 =?utf-8?B?bU1hQ0tOcjR3eUZSbWxBRmduQ3UyUFFpZ3NwS1J3cUJ1RVY2bVUxd01zNTBt?=
 =?utf-8?B?UTNXS1MzckNNRTdXTU53WHNwRTBGYzNsYVhJL2pJYTZRZUt4cWUzNzF0cVVq?=
 =?utf-8?B?QWd3NzZDMGhlS2lOcDZmTVNSWVhUOHlab1FLejZVeFAxMG5QaXY3bm9SZGdp?=
 =?utf-8?B?d0xyRFg2ZHNIaFQrN1J6cTU4RFVudEp4MDh1R0puU1BQV1NSY0NRZkdYMW9T?=
 =?utf-8?B?TDdoV0pSK091K1RabitOOGxaSjVHRzByVi9Gd0FMWUhNMXRKbG00bklKaHZs?=
 =?utf-8?B?QTAxNmFNa1pPcGE0VmhJNG8waUM3Y1NTdWxNTjd0ZFhFT1FzcnlYUytBVHRS?=
 =?utf-8?B?RUhXUVp3eEQ3NUk2RzRtOW1KeDJ1SzI3eG85VlRoWDZ1L2hPc05JTWtwcWdJ?=
 =?utf-8?B?U0ZFdGt4WTVncVFqb3N1bXFuOTJtcUtsbzMxS2FkbWxWcGoyejJlTllNV3NM?=
 =?utf-8?B?TDdBcHV5Ymg1NjlVK2FDNEpsSnJKRnpSTnBraGxTT0FmOTczR3l1ZldCMXlJ?=
 =?utf-8?B?cWZzaitueGdybnBsUHh2YTJFSjg2YVFYRmMzMG56K09nZ2RvRkJrZFhPTDcv?=
 =?utf-8?B?UFRrQjBMVzJURzNlSk9Db01kdVBQeFd4UC9Ga000NkVTdnFralZvOW82YnV0?=
 =?utf-8?B?U3IwUFJXbmFibk5Vcy9xbEpET2R3ajRramowR0lyaFpvY25JNUtMS1krWTls?=
 =?utf-8?B?cGwwcm5ORUg0R1d2UGs2TkhFTlQydWhYVmt3YjAxVWpVakVuR3JuTDFOa1lJ?=
 =?utf-8?B?Ri9aTC8vNXVCSTRyQkk5cmh2Y1FUMUtSVlBQV3FJR1pkRThsNkVzc3VveXY1?=
 =?utf-8?B?WDdZa3NCcVM0QnJVQVkvY3ROUGFqUUNQL2pwUHNMeEdKeXcwYWhmdFpEU0cw?=
 =?utf-8?B?cWNDMm1laXpPK0ZaeXgxdktYTDNXaFFOaUZBcjg4TWMrb3Fqdk4xV0cybklR?=
 =?utf-8?B?VXNacUJWRzVXcE1kR0hQOFVFZWJNRlU1ZzI0QTAxaTkvbWc1TDhwa3lOR1k3?=
 =?utf-8?B?OFN6QWVOR3IySERmNk04L2d4ZDJ3QlF1TG5JOHhTS0J4TVhMdzdvUlppNmpo?=
 =?utf-8?B?SjFmbUpLQkRRL2cxRHJPM0NZR1kvQnMyUWNWMVEzMkg0REc3ZXY5RGlMUDBi?=
 =?utf-8?B?cjFIc3VSS0liYVIzZy9VSnpWckd0SFEzNmZUTklYQmJBbnVQSFJPc1JFSE1F?=
 =?utf-8?Q?dnWyrqxTCnXOyNxtarUYj9CvO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec64ca99-75e5-444b-da61-08dc3beceaec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 01:46:31.8955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hp+5cHhqgDoyGnL/n6ltQdd1pEssC3Rn5M8trb6/B0uJepZ1qD0eapNPE6fsTUU1187HvtfFzuIIBSg/abkOScZr0he92bPPBXTAdjci48A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7372
Received-SPF: pass client-ip=2a01:111:f400:feae::720;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMSwgMjAyNCAx
MTo0OSBQTQ0KPiBUbzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz47IHFlbXUtYXJt
QG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZQ0KPiA8dHJveV9sZWVAYXNwZWVkdGVj
aC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUFVMTCAyLzJdIGFzcGVlZDogZml4IGhhcmRjb2RlIGJv
b3QgYWRkcmVzcyAwDQo+IA0KPiBIaSBKYW1pbiwNCj4gDQo+IE9uIDI3LzIvMjQgMTM6NTIsIEPD
qWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiA+IEZyb206IEphbWluIExpbiA8amFtaW5fbGluQGFz
cGVlZHRlY2guY29tPg0KPiA+DQo+ID4gSW4gdGhlIHByZXZpb3VzIGRlc2lnbiBvZiBBU1BFRUQg
U09DcyBRRU1VIG1vZGVsLCBpdCBzZXQgdGhlIGJvb3QNCj4gPiBhZGRyZXNzIGF0ICIwIiB3aGlj
aCB3YXMgdGhlIGhhcmRjb2RlIHNldHRpbmcgZm9yIGFzdDEweDAsIGFzdDI2MDAsDQo+ID4gYXN0
MjUwMCBhbmQgYXN0MjQwMC4NCj4gPg0KPiA+IEFjY29yZGluZyB0byB0aGUgZGVzaWduIG9mIGFz
dDI3MDAsIGl0IGhhcyBhIGJvb3RtY3UocmlzY3YtMzIpIHdoaWNoDQo+ID4gaXMgdXNlZCBmb3Ig
ZXhlY3V0aW5nIFNQTCBhbmQgaW5pdGlhbGl6ZSBEUkFNIGFuZCBjb3B5IHUtYm9vdCBpbWFnZQ0K
PiA+IGZyb20gU1BJL0ZsYXNoIHRvIERSQU0gYXQgYWRkcmVzcyAweDQwMDAwMDAwMCBhdCBTUEwg
Ym9vdCBzdGFnZS4NCj4gPiBUaGVuLCBDUFVzKGNvcnRleC1hMzUpIGV4ZWN1dGUgdS1ib290LCBr
ZXJuZWwgYW5kIHJvZnMuDQo+ID4NCj4gPiBDdXJyZW50bHksIHFlbXUgbm90IHN1cHBvcnQgZW11
bGF0ZSB0d28gQ1BVIGFyY2hpdGVjdHVyZXMgYXQgdGhlIHNhbWUNCj4gPiBtYWNoaW5lLiBUaGVy
ZWZvcmUsIHFlbXUgd2lsbCBvbmx5IHN1cHBvcnQgdG8gZW11bGF0ZSBDUFUoY29ydGV4LWEzNSkN
Cj4gPiBzaWRlIGZvciBhc3QyNzAwIGFuZCB0aGUgYm9vdCBhZGRyZXNzIGlzICIweDQgMDAwMDAw
MDAiLg0KPiA+DQo+ID4gRml4ZWQgaGFyZGNvZGUgYm9vdCBhZGRyZXNzICIwIiBmb3IgZnV0dXJl
IG1vZGVscyB1c2luZyBhIGRpZmZlcmVudA0KPiA+IG1hcHBpbmcgYWRkcmVzcy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gDQo+IFRpcCBm
b3IgdGhlIGVtYWlsIHdvcmtmbG93OiB3aGVuIHNvbWVvbmUgcHJvdmlkZSBhIFItYiB0YWcgZm9y
IGEgcGF0Y2gsDQo+IHBsZWFzZSBjYXJyeSBpdCBvbiBpbiB5b3VyIG5leHQgaXRlcmF0aW9ucy4N
Cj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMDlmOWNhMzQtNGUwYy00
YWRhLWI4MDgtNjQzYThjNTc4NTExDQo+IEBsaW5hcm8ub3JnLw0KPiANCj4gU2VlDQo+IGh0dHBz
Oi8vd3d3LnFlbXUub3JnL2RvY3MvbWFzdGVyL2RldmVsL3N1Ym1pdHRpbmctYS1wYXRjaC5odG1s
I3Byb3Blci11cw0KPiBlLW9mLXJldmlld2VkLWJ5LXRhZ3MtY2FuLWFpZC1yZXZpZXcNCj4NCkdv
dCBpdCBhbmQgdGhhbmtzIGZvciBub3RpZmljYXRpb24uDQogDQo+ID4gU2lnbmVkLW9mZi1ieTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUv
aHcvYXJtL2FzcGVlZF9zb2MuaCB8IDIgLS0NCj4gPiAgIGh3L2FybS9hc3BlZWQuYyAgICAgICAg
ICAgICB8IDQgKysrLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyNDAwLmMgICAgIHwgNCArKy0t
DQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI2MDAuYyAgICAgfCAyICstDQo+ID4gICA0IGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg==

