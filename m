Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B37C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 07:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS9dE-00058T-Bx; Thu, 19 Jun 2025 03:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uS9dB-00057e-Fb; Thu, 19 Jun 2025 03:24:17 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uS9d7-0002JJ-IG; Thu, 19 Jun 2025 03:24:17 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNBqv3xGnz6L4yr;
 Thu, 19 Jun 2025 15:21:47 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id A9F011402C8;
 Thu, 19 Jun 2025 15:24:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 09:24:02 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 19 Jun 2025 09:24:02 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
CC: Linuxarm <linuxarm@huawei.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>, "Wangzhou
 (B)" <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Thread-Topic: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Thread-Index: AQHb3HJK5cxfqqKOvUqssRJx2PlFXrQFdhmAgAFoTgCAAJeugIABKGfwgABr7ICAARD04A==
Date: Thu, 19 Jun 2025 07:24:02 +0000
Message-ID: <e4879b1e26f941b5baa419824e4c928c@huawei.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
 <20250616112019.00003bce@huawei.com>
 <fcd05844-d2d9-450e-b962-59b0f3964185@redhat.com>
 <20250617175247.00007d43@huawei.com>
 <49d4c4b73e9a44a783332ddfe9a2fbdf@huawei.com>
 <327b5515-467c-4666-86d6-fb2a99925a8c@redhat.com>
In-Reply-To: <327b5515-467c-4666-86d6-fb2a99925a8c@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxOCwg
MjAyNSA2OjAwIFBNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+DQo+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+IG5pY29saW5jQG52aWRp
YS5jb207IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNvbTsNCj4gaW1hbW1l
ZG9AcmVkaGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOyBtb2Noc0BudmlkaWEuY29tOw0KPiBz
bW9zdGFmYUBnb29nbGUuY29tOyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29t
PjsNCj4gamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9A
bGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvN10gaHcvYXJtL3NtbXUtY29t
bW9uOiBDaGVjayBTTU1VIGhhcyBQQ0llDQo+IFJvb3QgQ29tcGxleCBhc3NvY2lhdGlvbg0KPiAN
Cj4gSGkgU2hhbWVlciwgSm9uYXRoYW4sDQo+IA0KPiBPbiA2LzE4LzI1IDEwOjM1IEFNLCBTaGFt
ZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSnVuZSAxNywgMjAyNSA1OjUzIFBNDQo+
ID4+IFRvOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4+IENjOiBTaGFt
ZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+ID4+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1
YXdlaS5jb20+OyBMaW51eGFybQ0KPiA+PiA8bGludXhhcm1AaHVhd2VpLmNvbT47IHFlbXUtYXJt
QG5vbmdudS5vcmc7IHFlbXUtDQo+ID4+IGRldmVsQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+ID4+IG5pY29saW5jQG52aWRpYS5jb207IGRk
dXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNvbTsNCj4gPj4gaW1hbW1lZG9AcmVk
aGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOyBtb2Noc0BudmlkaWEuY29tOw0KPiA+PiBzbW9z
dGFmYUBnb29nbGUuY29tOyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsN
Cj4gPj4gamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9A
bGluYXJvLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvN10gaHcvYXJtL3NtbXUt
Y29tbW9uOiBDaGVjayBTTU1VIGhhcw0KPiBQQ0llDQo+ID4+IFJvb3QgQ29tcGxleCBhc3NvY2lh
dGlvbg0KPiA+Pg0KPiA+PiBPbiBUdWUsIDE3IEp1biAyMDI1IDA5OjQ5OjU0ICswMjAwDQo+ID4+
IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4+DQo+ID4+PiBP
biA2LzE2LzI1IDEyOjIwIFBNLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+Pj4+IE9uIEZy
aSwgMTMgSnVuIDIwMjUgMTU6NDQ6NDMgKzAxMDANCj4gPj4+PiBTaGFtZWVyIEtvbG90aHVtIDxz
aGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+Pj4+DQo+ID4+
Pj4+IEFsdGhvdWdoIHRoaXMgY2hhbmdlIGRvZXMgbm90IGFmZmVjdCBmdW5jdGlvbmFsaXR5IGF0
IHByZXNlbnQsIGl0IGlzDQo+ID4+Pj4gUGF0Y2ggdGl0bGUgc2F5cyBQQ0llLiAgVGhpcyBjaGVj
ayBpcyB2cyBQQ0kgaG9zdCBicmlkZ2UuDQo+ID4+Pj4NCj4gPj4+PiBObyBpZGVhIHdoaWNoIG9u
ZSB5b3Ugd2FudGVkLCBidXQgaWYgaXQgaXMgUENJZSBuZWVkcyB0byBiZQ0KPiA+Pj4+IFRZUENf
UENJRV9IT1NUX0JSSURHRSBmcm9tIHBjaWVfaG9zdC5oIG5vdCB0aGUgcGNpX2hvc3QuaCBvbmUN
Cj4gPj4+PiBJIHRoaW5rLg0KPiA+Pj4gSSB0aGluayB3ZSBuZWVkIFRZUEVfUENJX0hPU1RfQlJJ
REdFIGFzIHdlIHdhbnQgdG8gY2hlY2sgYWdhaW5zdA0KPiBweGINCj4gPj4+DQo+ID4+PiBwY2kt
YnJpZGdlL3BjaV9leHBhbmRlcl9icmlkZ2UuYzrCoMKgwqAgLnBhcmVudMKgwqDCoMKgwqDCoMKg
ID0NCj4gPj4gVFlQRV9QQ0lfSE9TVF9CUklER0UsDQo+IHNvcnJ5IGJ1dCBJIHN0aWxsIGZhaWwg
dG8gdW5kZXJzdGFuZCB3aHkgd2UgY2FuJ3QganVzdCBjaGVjayBhZ2FpbnN0DQo+IA0KPiBUWVBF
X1BDSV9IT1NUX0JSSURHRSBmb3IgbWFraW5nIHN1cmUgdGhlIFNNTVUgaXMgYXR0YWNoZWQgdG8g
UFhCIG9yDQo+IEdQRVguIFdoYXQgZG9lcyBpdCBmYWlsIHRvIGNoZWNrPyBXaHkgc2hhbGwgd2Ug
Y2FyZSBhYm91dCBQQ0kgdnMgUENJZT8NCg0KSSB0aGluayB0aGUgY29uY2VybiBpcyAgZ2V0dGlu
ZyBhbnkgb3RoZXIgVFlQRV9QQ0lfSE9TVF9CUklER0UgdHlwZXMgYXR0YWNoZWQNCnRvIFNNTVV2
MyBvdGhlciB0aGFuIHB4Yi1wY2llIG9yIEdQRVguIEZvciBleGFtcGxlIHlvdSBjb3VsZCBkbywN
Cg0KLWRldmljZSBweGItY3hsLGJ1c19ucj0xMixidXM9cGNpZS4wLGlkPWN4bC4xIFwNCi1kZXZp
Y2UgYXJtLXNtbXV2MyxwcmltYXJ5LWJ1cz1jeGwuMSxpZD1zbW11djMuMSBcDQoNCmFzIHB4Yi1j
eGwgaXMgb2YgdHlwZSBUWVBFX1BDSV9IT1NUX0JSSURHRS4gSSBkb24ndCBrbm93IGlmIHRoZXJl
IGFyZSBhbnkgb3RoZXINCm9uZXMgc2ltaWxhciB0byB0aGlzIG91dCB0aGVyZS4NCg0KU28gdGhl
IGFpbSBpcyB0byBtYWtlIHRoZSBjaGVja2luZyBtb3JlIHNwZWNpZmljIHRvIFBYQi4NCg0KVGhh
bmtzLA0KU2hhbWVlcg0K

