Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C65D1CA0E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 02:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t89Oh-0005H1-G0; Mon, 04 Nov 2024 21:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1t89OX-0005GY-7M
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:34:14 -0500
Received: from mail-bjschn02on2118.outbound.protection.partner.outlook.cn
 ([139.219.17.118] helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1t89OT-0002n8-FY
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:34:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmpDGmWE6z5YBz3JPlvgQs/Zb9iL9B7459g+jGK7BBulKNkI1EC3zG0eBw5xsjuojaz4fSKgwxOJ8FVmuz+QbGVo2XqmL+RMHOLKxVLdkhRPc4ki0tH1889uI+ozweeZYsuNsq0ed0i9rFyjOFj+ckxICZgz0kelvsDNmNhXl7v9A2vU2RYXtlVLpO1FPPQa13cNpHdpIWUaYYOI7CA7Y0lT/+E0tUcN48/mU2DDMPd66b7kaG4SpVcPVm7cNpCg1WoIis0cBflWnCIo8gym5P7el3ZThTEJ8XeMtOFt6k2VzWTgdHLuV/ILu1LHUhVDJPeBAnvcwCTyS9nEeePfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vd/wzgcPEKhRLu7rqiffkP/RSfKknYPFFAWAxI+x2aI=;
 b=MEil9I6I2GjQyWPH//FT6Bzqk5TbFEcLtC02J12pxO2jgLCd0dQqHWURCDJIkHJvR1xDoYog7k0wbTVO7sGoN6D5aTY6ow1Z8MKBv0ydW4dzPbSRq++5aP4hvdrR5F1yqrNR4jljFzot3w5jECWlF0NZl1SvPo5NvOzWVyOE4ws9o4okTQSY5jIT2S8TrxEiipifNnGleD4/bZJD6Zbpmh2S9+RJZXkPjmag6RiZHYG3WTgnlAK0APNvjWH3DS/o760gE/9I/4l+BDVJsgOMC4b+lZ6MbEcNRL5aLb38TjVeNHZ279GQU65+qqC6nQolPbal3i0ocaKn7a93jqI0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13) by ZQ0PR01MB1093.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 02:29:04 +0000
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 ([fe80::7c03:71ed:a774:fa31]) by
 ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn ([fe80::7c03:71ed:a774:fa31%6])
 with mapi id 15.20.8114.023; Tue, 5 Nov 2024 02:29:04 +0000
From: Demin Han <demin.han@starfivetech.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: RE: [PATCH] plugins: add plugin API to get args passed to binary
Thread-Topic: [PATCH] plugins: add plugin API to get args passed to binary
Thread-Index: AQHbLDyPsgVEn9ocvUKmJf5ZUtvEebKivGIAgACzPfKABDb8gIAATDEQ
Date: Tue, 5 Nov 2024 02:29:04 +0000
Message-ID: <ZQ0PR01MB106322463E0A1A23E750901285522@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
References: <ZQZPR01MB1057EB3713C55BC9F53ADE5785572@ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn>
 <ec546d66-0ecb-4294-b8c6-a7f2c2a6e534@linaro.org>
In-Reply-To: <ec546d66-0ecb-4294-b8c6-a7f2c2a6e534@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1063:EE_|ZQ0PR01MB1093:EE_
x-ms-office365-filtering-correlation-id: 86cbfb70-6b21-4b38-7d10-08dcfd419e05
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|38070700018; 
x-microsoft-antispam-message-info: wVaTfJon1bROmzgC+jA0U9fIE912eBKrPnrf+g6ddUcBDbvDkUAzcWGSi/WyVBth9YNSI5V3ld3/dtCGrrD1RuseFjX7UP5SJp3hMTUKTAiqQkg4WmdXhTBgJUWosf2kRBpJELcFyZTykvyGwVITGzFccQNnxm2FxhNfqeMnnGHUU6KGkyUyfdqwfS0ie2lTnJLdoukqm7liz2kcM3EyV3NLJm/4OnvoBIP6XTz7sX7k5fwQdedqR40kpnvNZ+X9YMEhulBSLk2Uz310T5wvBJqribkX+zB44PWXxZgc5AbqStn0HEZrSVqhgsmNVqNhDykAYAVGtNZJl7Dprj1RI1GA4rWIGTYAYRJfFl6W8zaYfM+h23UO1c801mT7XhMdzc0j0TEICXN4EduqmN0v2VlhZDytI1frKocNofiBvp32PKHlPWhRK/ZD963mXq9rWHtu4WymFX/tw1uHAMhy74H0sNbpfcIUWyhjxYBOYjtXQf6O8acTyTiECNdmq8JgNddKORlGxjxwtslsgeW0MbUxgi8UyXx3haqDUABe6boBxT/gahoKI2M1V81IlXDHPmiXSKG33UlHDorxu1yqXy+ra/utt7jsRaJ2MD9JnMOxjzSdoFy0nQB+hNNAs+9O
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(41320700013)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3ZqSmNWaWdHSUdjeGNQdlhQR1FLd3lVa2prL2pOcEt2L0pVdjV2a3lGeTVH?=
 =?utf-8?B?aDMzUTQ0R1h1U01TODBJbXBINndlbGIwaWhtRzUwZzVDU1NqQkVRWU1oeDN6?=
 =?utf-8?B?b3c3OExqdlNMRkJ1YXh5UjJJLzNzMlNFMEFqKyt3UW42N3Z3dU5tQy9EeHVo?=
 =?utf-8?B?cWRjQU5zSi91OFRNeDRpTTYyWHhNMUhBSWJGNHE3Z0pvYmpvT1NncjRRNnFO?=
 =?utf-8?B?RFFrdzk3L1R4YVhwM3dLK3pkZHdhR083Y3JVZU9ZYVp6M3AxQlNEM3pINVI1?=
 =?utf-8?B?Ukh4eTlyYlE2QkVPcXNIZEtQL2szVG5uejZFbDRJYmZDLzNzSDRmNFJycnRh?=
 =?utf-8?B?d3ZmYzNxTlhhTWFJN0FxaFJSV05OY1hZUDRsSzE2czF2WTRiS25XYnZ3SzNF?=
 =?utf-8?B?c2hULzdFQ2FTcXVsSllyOTBoY0JqajU2dEsrZ2hQUE9XTXJuN2xCcWpIY1ZR?=
 =?utf-8?B?eFBMQzA2aG1uRnI1MElEM3dOZm5XelVuSnJyei9PMnhjbytiWFR6VGNLYzlN?=
 =?utf-8?B?Q04rV1FNZWFZd2VmU0Fsci9hbzVJVWhrdlN2a1E0bnpRZ281eURiNmhMaUxw?=
 =?utf-8?B?M1VJOXlSSFhySDdDSDY0V25EMnQyUW9oUXBLc3F0ZzFmUVFKNkIyUHFuYVhw?=
 =?utf-8?B?MlJmVDhvcUJQKysyZkFxRmoyZmR4SnB5QlZ4eWttbGxzdTBsNXdFdHFBRDZy?=
 =?utf-8?B?ZjlrWTZrUFNsSXpnRU9BU04zTUhyWkgrdTJobGIrUXUxSTJDaUY3anR5bEhj?=
 =?utf-8?B?c3F5RlVLVlk1MzhJY1JFcDY1Tk95NHk5eFdFQVNFOUUrR1NacFRRbmlpRU9a?=
 =?utf-8?B?Rmp0Q2xDN0tldmNQcmN5TDlpYXdwVVhuVVRZMUNyRm4wOUlxblE0blNDL1Uv?=
 =?utf-8?B?ZktnV0JCbzEzN1BSSHFFalZBU0xva3FYQzN1Mlg3WHdJSGVHZ05udGhKWG9G?=
 =?utf-8?B?TC9VM0c0bEtXcUtkV3VUSkx1NXR5ODJzL25QdlZMeFZ1dU5KUlo5d0pNQUZr?=
 =?utf-8?B?ZFYzRERFT3NWaVRJK0JNTXlqWkFPSVNBai9YMlJ0ZGxxWVBRL0RmSmYyd0Ry?=
 =?utf-8?B?WEROUi92Y0ZEaVRFb2txUVZHbjQ0cXRpRGxGclZydFlXNzhIYjlsY01FejFu?=
 =?utf-8?B?YWZlelZTZWJ4bm02UkxQQ0NqZzlwR3dLMjJncEZaMnZkT1YrKzlCVWdFTk40?=
 =?utf-8?B?VDRRcDBSeGIwZWZuTEwrTnZuYWFoRWk0dWFVbVYrTmVibWVLV1BHbkgwU3JT?=
 =?utf-8?B?Y3JZdFFacWYxUExaaUVXYi9JcllrRXpNUTZiRXg2OHo2d0ljNEF6ZUNZT2lK?=
 =?utf-8?B?NjVNem1YNG5wRFBObjZOUUFOemFlaUdTb3hUcFpnNjk1d2duaW0xNUNrdTNV?=
 =?utf-8?B?djBjSEdUQzF0K1Z1ZmVHekQ5YmRKM2U4UDc4WHhxNkQxZnIrY3hCTVFibVow?=
 =?utf-8?B?c2Q1VFZkQjBqN01hSnE4dzdlaDNPVjRsY3crNkZHSGVxT0NVSU1ob0ZKOWp5?=
 =?utf-8?B?MmhwdmRNYklTZ3IyZ3E2V3hvbWNONEdhWFN4WHg0MVZWbG10YkdLbGhLOVMz?=
 =?utf-8?B?RjZjLzdTK2ZnUFVuWFltR0VpS1Y3UjJtZlJFbXptVWhnMmJBb0ZNcDJXb01l?=
 =?utf-8?B?ZStSWnZlKzk3TUpNY1JlcVhhVzBGQ0pNS3FPZ0J4czAvbncwZHUwVi9vK2Fy?=
 =?utf-8?B?T2g2VTFKaXJzcUJla0IydDMvSW1idUxtRW96b1N1NU9lR1g1V2l5Z3VTbjgr?=
 =?utf-8?B?ak1IY0xUelVTWkxmRUxGQVAwWWxmOHRRM002NTJNckNmYjRZZlZibXY0dHJJ?=
 =?utf-8?B?MU5uSElvbDcxR3I0VmYvY21DcEp3QVkvM2Z1VWxPZjRSYUFNVFhiaU0yUnBx?=
 =?utf-8?B?YkdabmVwTDN2ckIwdDkzSVFPWGkzZ3FscWxzM3pBdVVHbU9jS3FQRC9RRkQw?=
 =?utf-8?B?cDBvd3NweXlGTktldXdBZWlkUGZnR1IrV1dFVTlscXNVbW5CRTQyR3J2NGtn?=
 =?utf-8?B?cEUvcTg4QjRhTjVGWHhvMnVUWmtSempJUFpNZThlTWhoSGpnbjlOemdnVkxu?=
 =?utf-8?B?RzFnbU5LK1UzVlZFOStDSEVXU0Y3cjh6WHJkbGxiSU5ibVE5c0RKWmNDc2NR?=
 =?utf-8?Q?xjX2Xy8qK8ZqVPsjV4EV9hcoZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cbfb70-6b21-4b38-7d10-08dcfd419e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 02:29:04.5174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gegvcH6vrRjMkJG3vBN6prqixNNw/8OOgSaWYkRCWMoK0XbB6/adufCbQB/T05oVWI3XdeDfVztRXVv6/lnwkp5ud8SdSv/Zo1KkIBOU/wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1093
Received-SPF: pass client-ip=139.219.17.118;
 envelope-from=demin.han@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyNOW5tDEx5pyINeaXpSA1
OjIyDQo+IFRvOiBEZW1pbiBIYW4gPGRlbWluLmhhbkBzdGFyZml2ZXRlY2guY29tPjsgcWVtdS1k
ZXZlbEBub25nbnUub3JnDQo+IENjOiBhbGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBlcmRuYXhlQGNy
YW5zLm9yZzsgbWEubWFuZG91cnJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBs
dWdpbnM6IGFkZCBwbHVnaW4gQVBJIHRvIGdldCBhcmdzIHBhc3NlZCB0byBiaW5hcnkNCj4gDQo+
IE9uIDExLzEvMjQgMjI6MTAsIERlbWluIEhhbiB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IE1h
bnkgYmVuY2htYXJrcyBoYXZlIHRoZWlyIG93biBidWlsZCBhbmQgcnVuIHN5c3RlbSwgc3VjaCBh
cyBzcGVjaW50LA0KPiA+IHdlIGRvbuKAmXQgd2FudCB0byBjaGFuZ2UgdGhlaXIgY29kZS4NCj4g
Pg0KPiANCj4gSSBkb24ndCB0aGluayB0aG9zZSBiZW5jaG1hcmtzIChzdWNoIGFzIHNwZWNpbnQp
IGludGVncmF0ZSBjYWxsaW5nIHFlbXUgd2l0aCBhDQo+IHNwZWNpZmljIHBsdWdpbiBvbiBjb21t
YW5kIGxpbmUsIHNvIEkgZ3Vlc3MgeW91IGhhdmUgYSB3cmFwcGVyIG9yIHNvbWV0aGluZw0KPiB3
aGVyZSB5b3UgY291bGQgcGFzcyBuZWNlc3NhcnkgaW5mb3JtYXRpb24sIG9yIHR3ZWFrIG91dHB1
dCBmaWxlLCB3aXRob3V0DQo+IGNoYW5naW5nIHRoZSBiZW5jaG1hcmsgaXRzZWxmLiBJbiBjYXNl
IEknbSB3cm9uZywgZmVlbCBmcmVlIHRvIGNvcnJlY3QgbWUuDQoNCkkgaGF2ZSB0d28gbWV0aG9k
cyB3aXRob3V0IGNoYW5nZSB0ZXN0IGNvZGUsIGJ1dCB0aGV5IGNhbid0IGdldCBhcmdzIHBhc3Nl
ZCB0byBiaW5hcnk6DQoxLiBmb3IgdGhvc2Ugd2l0aG91dCBob29rLCBzdWNoIGFzIHNwZWNpbnQs
IHdlIGNhbiB1dGlsaXplIGJpbmZtdF9taXNjLiANCiAgV2UgbWF5IG5lZWQgYSBzaW1wbGUgd3Jh
cHBlciBqdXN0IHRvIGxvYWQgcGx1Z2luIG9yIHNldCBzb21lIGNvbW1vbiBvcHRpb25zIGFuZCBy
ZWdpc3RlciB0aGlzIHdyYXBwZXIgdG8gYmluZm10X21pc2MNCjIuIGZvciB0aG9zZSB3aXRoIGhv
b2ssIHN1Y2ggYXMgbGx2bS10ZXN0LXN1aXRlLCB3ZSBjYW4gc2V0IFRFU1RfU1VJVEVfUlVOX1VO
REVSIG9yIHV0aWxpemUgYmluZm10X21pc2MNCg0KSSBoYXZlIG5vIGlkZWEgdG8gd3JpdGUgYSB3
cmFwcGVyIHdoaWNoIGNhbiBnZXQgYXJncyBwYXNzZWQgdG8gYmluYXJ5IHdpdGhvdXQgY2hhbmdl
IGNvZGUuDQpJZiBoYXZlLCBwbGVhc2UgZ2l2ZSBhIGV4YW1wbGUgb3Igc29tZSBoaW50Lg0KDQo+
ID4gQWN0dWFsbHkgdGhlIGxvZyBtYXliZSBzdHJ1Y3R1cmFsIGRhdGEgc3VjaCBhcyBpbiBqc29u
IGZvcm1hdCBhbmQgbWF5DQo+ID4gYmUgb3V0cHV0IG11bHRpcGxlIGxvZyBmaWxlcyB3aXRoIGRp
ZmZlcmVudCBzdGF0aXN0aWNzIGRpbWVudGlvbiBmb3Igb25lIHJ1bi4NCj4gPg0KPiA+IC1EIGNh
buKAmXQgc2F0aXNmeSB0aGlzLg0KPiANCj4gSW5kZWVkLCBpdCBjYW4gb3V0cHV0IG9ubHkgYSBz
aW5nbGUgZmlsZS4gSWYgeW91ciBwbHVnaW4gbmVlZHMgc29tZXRoaW5nIG1vcmUNCj4gYWR2YW5j
ZWQsIHlvdSBjYW4gdHJ5IHRvIG91dHB1dCBzb21ldGhpbmcgeW91cnNlbGYuIEhvd2V2ZXIsIGEg
YmV0dGVyIGFuZA0KPiBzaW1wbGVyIHdheSB3b3VsZCBiZSB0byBwcmVmaXggbGluZXMgb3V0cHV0
IHdpdGggYSBzcGVjaWZpYyBtYXJrZXIsIGFuZCBwb3N0DQo+IHByb2Nlc3MgeW91ciBwbHVnaW4g
dHJhY2Ugd2l0aCBhIGN1c3RvbSBzY3JpcHQuDQo+IA0KPiBBZGRpbmcgY29tbWFuZCBsaW5lIGFj
Y2VzcyB0byBwbHVnaW5zIGRvZXMgbm90IHNvbHZlIGFueSBvZiB0aG9zZSBwcm9ibGVtcy4NCj4g
DQo+IEkgc2VlIHZhbHVlIGluIHdoYXQgdGhpcyBzZXJpZXMgb2ZmZXIsIGJ1dCBJIGRvbid0IHNl
ZSBob3cgaXQncyByZWxhdGVkIHRvIHRoZQ0KPiBjdXJyZW50IG5lZWQgeW91IGV4cHJlc3MuDQoN
ClllcywgdGhpcyBpcyBub3QgaW1wb3J0YW50IGFuZCBub3QgbW9zdCBjb25jZXJuZWQuDQpCdXQg
aWYgd2UgY2FuIGRpcmVjdGx5IG91dHB1dCBqc29uIG9yIHlhbWwsIGl0IHdvdWxkIGJlIGNvbnZl
bmllbnQgZm9yIHBvc3QtcHJvY2Vzc2luZy4NClRoaXMgaXMgYSBib251cyBmb3IgdGhpcyBhZGRl
ZCBhcGkuDQoNClJlZ2FyZHMsDQpEZW1pbg0KDQo+IFJlZ2FyZHMsDQo+IFBpZXJyaWNrDQo+IA0K
PiA+DQo+ID4gUmVnYXJkLA0KPiA+IERlbmluDQo+ID4NCj4gPiDojrflj5YgT3V0bG9vayBmb3Ig
aU9TIDxodHRwczovL2FrYS5tcy9vMHVrZWY+DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IC0tDQo+
ID4gKuWPkeS7tuS6ujoqIFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCj4gPiAq5Y+R6YCB5pe26Ze0OiogU2F0dXJkYXksIE5vdmVtYmVyIDIsIDIwMjQgMjox
ODoyMCBBTQ0KPiA+ICrmlLbku7bkuro6KiBEZW1pbiBIYW4gPGRlbWluLmhhbkBzdGFyZml2ZXRl
Y2guY29tPjsNCj4gcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4gPHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZz4NCj4gPiAq5oqE6YCBOiogYWxleC5iZW5uZWVAbGluYXJvLm9yZyA8YWxleC5iZW5uZWVA
bGluYXJvLm9yZz47DQo+ID4gZXJkbmF4ZUBjcmFucy5vcmcgPGVyZG5heGVAY3JhbnMub3JnPjsg
bWEubWFuZG91cnJAZ21haWwuY29tDQo+ID4gPG1hLm1hbmRvdXJyQGdtYWlsLmNvbT4NCj4gPiAq
5Li76aKYOiogUmU6IFtQQVRDSF0gcGx1Z2luczogYWRkIHBsdWdpbiBBUEkgdG8gZ2V0IGFyZ3Mg
cGFzc2VkIHRvIGJpbmFyeQ0KPiA+IEhpIERlbWluLA0KPiA+DQo+ID4gdGhhbmtzIGZvciB5b3Vy
IGNvbnRyaWJ1dGlvbi4NCj4gPg0KPiA+IE9uIDExLzEvMjQgMDI6MDAsIGRlbWluLmhhbiB3cm90
ZToNCj4gPj4gV2h5IHdlIG5lZWQgYXJncz8NCj4gPj4gV2hlbiBwbHVnaW4gb3V0cHV0cyBsb2cg
ZmlsZXMsIG9ubHkgYmluYXJ5IHBhdGggY2FuJ3QgZGlzdGluZ3Vpc2gNCj4gPj4gbXVsdGlwbGUg
cnVucyBpZiB0aGUgYmluYXJ5IHBhc3NlZCB3aXRoIGRpZmZlcmVudCBhcmdzLg0KPiA+PiBUaGlz
IGlzIGJhZCBmb3IgQ0kgdXNpbmcgcGx1Z2luLg0KPiA+Pg0KPiA+DQo+ID4gQ2FuIGl0IGJlIHNv
bHZlZCBzaW1wbHkgYnkgZW5jb2RpbmcgdGhpcyBpbiBuYW1lIG9mIGxvZyBmaWxlIGZyb20gdGhl
DQo+ID4gQ0kgcnVuIHNjcmlwdD8NCj4gPiAkIGNtZD0iL3Vzci9iaW4vZWNobyBIZWxsbyB3b3Js
ZCINCj4gPiAkIG91dF9maWxlPSIkKGVjaG8gIiRjbWQiIHwgc2VkIC1lICdzL1xzL18vJykubG9n
Ig0KPiA+ICQgcWVtdSAtcGx1Z2luLi4uIC1kIHBsdWdpbiAtRCAiJG91dF9maWxlIiAkY21kDQo+
ID4NCj4gPiBJIGNhbiBzZWUgc29tZSBnb29kIHBvaW50cyB0byBhZGQgdGhpcyBuZXcgQVBJLCBi
dXQgZm9yIHRoZSB1c2UgY2FzZQ0KPiA+IHByZXNlbnRlZCBpbiBjb21taXQgbWVzc2FnZSwgSSdt
IG5vdCBzdXJlIHRvIHNlZSB3aGF0IGl0IHNvbHZlcy4NCj4gPg0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBkZW1pbi5oYW4gPGRlbWluLmhhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+PiAtLS0NCj4gPj7C
oMKgIGluY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5owqDCoCB8IDExICsrKysrKysrKysrDQo+ID4+
wqDCoCBwbHVnaW5zL2FwaS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTYgKysr
KysrKysrKysrKysrKw0KPiA+PsKgwqAgcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scyB8wqAg
MSArDQo+ID4+wqDCoCAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oIGIvaW5jbHVkZS9xZW11
L3FlbXUtcGx1Z2luLmgNCj4gPj4gaW5kZXggNjIyYzlhMDIzMi4uZGFmNzVjOWY1YSAxMDA2NDQN
Cj4gPj4gLS0tIGEvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4gPj4gKysrIGIvaW5jbHVk
ZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4gPj4gQEAgLTgzNyw2ICs4MzcsMTcgQEAgYm9vbCBxZW11
X3BsdWdpbl9ib29sX3BhcnNlKGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4+Y29uc3QgY2hhciAqdmFs
LCBib29sICpyZXQpOw0KPiA+PsKgwqAgUUVNVV9QTFVHSU5fQVBJDQo+ID4+wqDCoCBjb25zdCBj
aGFyICpxZW11X3BsdWdpbl9wYXRoX3RvX2JpbmFyeSh2b2lkKTsNCj4gPj4NCj4gPj4gKy8qKg0K
PiA+PiArICogcWVtdV9wbHVnaW5fYXJndl90b19iaW5hcnkoKSAtIGFyZ3YgdG8gYmluYXJ5IGZp
bGUgYmVpbmcgZXhlY3V0ZWQNCj4gPj4gKyAqDQo+ID4+ICsgKiBSZXR1cm4gYSBzdHJpbmcgYXJy
YXkgcmVwcmVzZW50aW5nIHRoZSBhcmd2IHRvIHRoZSBiaW5hcnkuIEZvcg0KPiA+PiArdXNlci1t
b2RlDQo+ID4+ICsgKiB0aGlzIGlzIHRoZSBtYWluIGV4ZWN1dGFibGUncyBhcmd2LiBGb3Igc3lz
dGVtIGVtdWxhdGlvbiB3ZQ0KPiA+PiArY3VycmVudGx5DQo+ID4+ICsgKiByZXR1cm4gTlVMTC4g
VGhlIHVzZXIgc2hvdWxkIGdfZnJlZSgpIHRoZSBzdHJpbmcgYXJyYXkgb25jZSBubw0KPiA+PiAr
bG9uZ2VyDQo+ID4+ICsgKiBuZWVkZWQuDQo+ID4+ICsgKi8NCj4gPj4gK1FFTVVfUExVR0lOX0FQ
SQ0KPiA+PiArY29uc3QgY2hhciAqKnFlbXVfcGx1Z2luX2FyZ3ZfdG9fYmluYXJ5KHZvaWQpOw0K
PiA+PiArDQo+ID4+wqDCoCAvKioNCj4gPj7CoMKgwqAgKiBxZW11X3BsdWdpbl9zdGFydF9jb2Rl
KCkgLSByZXR1cm5zIHN0YXJ0IG9mIHRleHQgc2VnbWVudA0KPiA+PsKgwqDCoCAqDQo+ID4+IGRp
ZmYgLS1naXQgYS9wbHVnaW5zL2FwaS5jIGIvcGx1Z2lucy9hcGkuYyAgaW5kZXgNCj4gPj4yNGVh
NjRlMmRlLi5mYTI3MzVkYjAzIDEwMDY0NA0KPiA+PiAtLS0gYS9wbHVnaW5zL2FwaS5jDQo+ID4+
ICsrKyBiL3BsdWdpbnMvYXBpLmMNCj4gPj4gQEAgLTQ4NSw2ICs0ODUsMjIgQEAgY29uc3QgY2hh
ciAqcWVtdV9wbHVnaW5fcGF0aF90b19iaW5hcnkodm9pZCkNCj4gPj7CoMKgwqDCoMKgwqAgcmV0
dXJuIHBhdGg7DQo+ID4+wqDCoCB9DQo+ID4+DQo+ID4+ICtjb25zdCBjaGFyICoqcWVtdV9wbHVn
aW5fYXJndl90b19iaW5hcnkodm9pZCkNCj4gPj4gK3sNCj4gPj4gK8KgwqDCoCBjb25zdCBjaGFy
ICoqYXJndiA9IE5VTEw7DQo+ID4+ICsjaWZkZWYgQ09ORklHX1VTRVJfT05MWQ0KPiA+PiArwqDC
oMKgIGludCBpLCBhcmdjOw0KPiA+PiArwqDCoMKgIFRhc2tTdGF0ZSAqdHMgPSBnZXRfdGFza19z
dGF0ZShjdXJyZW50X2NwdSk7DQo+ID4+ICvCoMKgwqAgYXJnYyA9IHRzLT5icHJtLT5hcmdjOw0K
PiA+PiArwqDCoMKgIGFyZ3YgPSBnX21hbGxvYyhzaXplb2YoY2hhciAqKSAqIChhcmdjICsgMSkp
Ow0KPiA+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBhcmdjOyArK2kpIHsNCj4gPj4gK8KgwqDC
oMKgwqDCoMKgIGFyZ3ZbaV0gPSBnX3N0cmR1cCh0cy0+YnBybS0+YXJndltpXSk7DQo+ID4+ICvC
oMKgwqAgfQ0KPiA+PiArwqDCoMKgIGFyZ3ZbYXJnY10gPSBOVUxMOw0KPiA+PiArI2VuZGlmDQo+
ID4+ICvCoMKgwqAgcmV0dXJuIGFyZ3Y7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj7CoMKgIHVpbnQ2
NF90IHFlbXVfcGx1Z2luX3N0YXJ0X2NvZGUodm9pZCkNCj4gPj7CoMKgIHsNCj4gPj7CoMKgwqDC
oMKgwqAgdWludDY0X3Qgc3RhcnQgPSAwOw0KPiA+PiBkaWZmIC0tZ2l0IGEvcGx1Z2lucy9xZW11
LXBsdWdpbnMuc3ltYm9scw0KPiA+PmIvcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scyAgaW5k
ZXggMDMyNjYxZjllYS4uNTMyNTgyZWZmZSAxMDA2NDQNCj4gPj4gLS0tIGEvcGx1Z2lucy9xZW11
LXBsdWdpbnMuc3ltYm9scw0KPiA+PiArKysgYi9wbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1ib2xz
DQo+ID4+IEBAIC0xLDQgKzEsNSBAQA0KPiA+PsKgwqAgew0KPiA+PiArwqAgcWVtdV9wbHVnaW5f
YXJndl90b19iaW5hcnk7DQo+ID4+wqDCoMKgwqAgcWVtdV9wbHVnaW5fYm9vbF9wYXJzZTsNCj4g
Pj7CoMKgwqDCoCBxZW11X3BsdWdpbl9lbmRfY29kZTsNCj4gPj7CoMKgwqDCoCBxZW11X3BsdWdp
bl9lbnRyeV9jb2RlOw0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBQaWVycmljaw0K

