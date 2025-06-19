Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FFBC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 08:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSAH1-0001k7-PZ; Thu, 19 Jun 2025 04:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uSAGu-0001fh-CS; Thu, 19 Jun 2025 04:05:20 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uSAGq-00023t-Gq; Thu, 19 Jun 2025 04:05:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNClJ6bjJz6L4yr;
 Thu, 19 Jun 2025 16:02:52 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id 245501404C4;
 Thu, 19 Jun 2025 16:05:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 10:05:07 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 19 Jun 2025 10:05:07 +0200
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
Thread-Index: AQHb3HJK5cxfqqKOvUqssRJx2PlFXrQFdhmAgAFoTgCAAJeugIABKGfwgABr7ICAARD04P//5UOAgAAjYGA=
Date: Thu, 19 Jun 2025 08:05:07 +0000
Message-ID: <5fd7717fcd7e45d9aaff3e293cf63683@huawei.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
 <20250616112019.00003bce@huawei.com>
 <fcd05844-d2d9-450e-b962-59b0f3964185@redhat.com>
 <20250617175247.00007d43@huawei.com>
 <49d4c4b73e9a44a783332ddfe9a2fbdf@huawei.com>
 <327b5515-467c-4666-86d6-fb2a99925a8c@redhat.com>
 <e4879b1e26f941b5baa419824e4c928c@huawei.com>
 <6e180d39-b1eb-4935-98b0-3ac73766e8aa@redhat.com>
In-Reply-To: <6e180d39-b1eb-4935-98b0-3ac73766e8aa@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxOSwgMjAyNSA4OjQx
IEFNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb20+DQo+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IHFl
bXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+IG5pY29saW5jQG52aWRpYS5jb207IGRk
dXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNvbTsNCj4gaW1hbW1lZG9AcmVkaGF0
LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOyBtb2Noc0BudmlkaWEuY29tOw0KPiBzbW9zdGFmYUBn
b29nbGUuY29tOyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4gamlh
bmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvN10gaHcvYXJtL3NtbXUtY29tbW9uOiBDaGVj
ayBTTU1VIGhhcyBQQ0llDQo+IFJvb3QgQ29tcGxleCBhc3NvY2lhdGlvbg0KPiANCj4gSGkgU2hh
bWVlciwNCj4gDQo+IE9uIDYvMTkvMjUgOToyNCBBTSwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9k
aSB3cm90ZToNCj4gPiBIaSBFcmljLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gPj4g
U2VudDogV2VkbmVzZGF5LCBKdW5lIDE4LCAyMDI1IDY6MDAgUE0NCj4gPj4gVG86IFNoYW1lZXJh
bGkgS29sb3RodW0gVGhvZGkNCj4gPj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2Vp
LmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bT4NCj4gPj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9u
Z251Lm9yZzsgcWVtdS0NCj4gPj4gZGV2ZWxAbm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnOyBqZ2dAbnZpZGlhLmNvbTsNCj4gPj4gbmljb2xpbmNAbnZpZGlhLmNvbTsgZGR1dGls
ZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOw0KPiA+PiBpbWFtbWVkb0ByZWRoYXQu
Y29tOyBuYXRoYW5jQG52aWRpYS5jb207IG1vY2hzQG52aWRpYS5jb207DQo+ID4+IHNtb3N0YWZh
QGdvb2dsZS5jb207IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiA+
PiBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5h
cm8ub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS83XSBody9hcm0vc21tdS1jb21t
b246IENoZWNrIFNNTVUgaGFzDQo+IFBDSWUNCj4gPj4gUm9vdCBDb21wbGV4IGFzc29jaWF0aW9u
DQo+ID4+DQo+ID4+IEhpIFNoYW1lZXIsIEpvbmF0aGFuLA0KPiA+Pg0KPiA+PiBPbiA2LzE4LzI1
IDEwOjM1IEFNLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8am9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+Pj4+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTcs
IDIwMjUgNTo1MyBQTQ0KPiA+Pj4+IFRvOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5j
b20+DQo+ID4+Pj4gQ2M6IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPj4+PiA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgTGludXhhcm0NCj4gPj4+PiA8bGludXhh
cm1AaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtDQo+ID4+Pj4gZGV2ZWxA
bm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlhLmNvbTsNCj4g
Pj4+PiBuaWNvbGluY0BudmlkaWEuY29tOyBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJl
ZGhhdC5jb207DQo+ID4+Pj4gaW1hbW1lZG9AcmVkaGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29t
OyBtb2Noc0BudmlkaWEuY29tOw0KPiA+Pj4+IHNtb3N0YWZhQGdvb2dsZS5jb207IFdhbmd6aG91
IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiA+Pj4+IGppYW5na3Vua3VuIDxqaWFu
Z2t1bmt1bkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gPj4+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDEvN10gaHcvYXJtL3NtbXUtY29tbW9uOiBDaGVjayBTTU1VIGhh
cw0KPiA+PiBQQ0llDQo+ID4+Pj4gUm9vdCBDb21wbGV4IGFzc29jaWF0aW9uDQo+ID4+Pj4NCj4g
Pj4+PiBPbiBUdWUsIDE3IEp1biAyMDI1IDA5OjQ5OjU0ICswMjAwDQo+ID4+Pj4gRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPiB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+PiBPbiA2LzE2
LzI1IDEyOjIwIFBNLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+Pj4+Pj4gT24gRnJpLCAx
MyBKdW4gMjAyNSAxNTo0NDo0MyArMDEwMA0KPiA+Pj4+Pj4gU2hhbWVlciBLb2xvdGh1bSA8c2hh
bWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiB3cm90ZToNCj4gPj4+Pj4+DQo+
ID4+Pj4+Pj4gQWx0aG91Z2ggdGhpcyBjaGFuZ2UgZG9lcyBub3QgYWZmZWN0IGZ1bmN0aW9uYWxp
dHkgYXQgcHJlc2VudCwgaXQgaXMNCj4gPj4+Pj4+IFBhdGNoIHRpdGxlIHNheXMgUENJZS4gIFRo
aXMgY2hlY2sgaXMgdnMgUENJIGhvc3QgYnJpZGdlLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE5vIGlk
ZWEgd2hpY2ggb25lIHlvdSB3YW50ZWQsIGJ1dCBpZiBpdCBpcyBQQ0llIG5lZWRzIHRvIGJlDQo+
ID4+Pj4+PiBUWVBDX1BDSUVfSE9TVF9CUklER0UgZnJvbSBwY2llX2hvc3QuaCBub3QgdGhlIHBj
aV9ob3N0Lmggb25lDQo+ID4+Pj4+PiBJIHRoaW5rLg0KPiA+Pj4+PiBJIHRoaW5rIHdlIG5lZWQg
VFlQRV9QQ0lfSE9TVF9CUklER0UgYXMgd2Ugd2FudCB0byBjaGVjayBhZ2FpbnN0DQo+ID4+IHB4
Yg0KPiA+Pj4+PiBwY2ktYnJpZGdlL3BjaV9leHBhbmRlcl9icmlkZ2UuYzrCoMKgwqAgLnBhcmVu
dMKgwqDCoMKgwqDCoMKgID0NCj4gPj4+PiBUWVBFX1BDSV9IT1NUX0JSSURHRSwNCj4gPj4gc29y
cnkgYnV0IEkgc3RpbGwgZmFpbCB0byB1bmRlcnN0YW5kIHdoeSB3ZSBjYW4ndCBqdXN0IGNoZWNr
IGFnYWluc3QNCj4gPj4NCj4gPj4gVFlQRV9QQ0lfSE9TVF9CUklER0UgZm9yIG1ha2luZyBzdXJl
IHRoZSBTTU1VIGlzIGF0dGFjaGVkIHRvIFBYQiBvcg0KPiA+PiBHUEVYLiBXaGF0IGRvZXMgaXQg
ZmFpbCB0byBjaGVjaz8gV2h5IHNoYWxsIHdlIGNhcmUgYWJvdXQgUENJIHZzIFBDSWU/DQo+ID4g
SSB0aGluayB0aGUgY29uY2VybiBpcyAgZ2V0dGluZyBhbnkgb3RoZXIgVFlQRV9QQ0lfSE9TVF9C
UklER0UgdHlwZXMNCj4gYXR0YWNoZWQNCj4gPiB0byBTTU1VdjMgb3RoZXIgdGhhbiBweGItcGNp
ZSBvciBHUEVYLiBGb3IgZXhhbXBsZSB5b3UgY291bGQgZG8sDQo+ID4NCj4gPiAtZGV2aWNlIHB4
Yi1jeGwsYnVzX25yPTEyLGJ1cz1wY2llLjAsaWQ9Y3hsLjEgXA0KPiA+IC1kZXZpY2UgYXJtLXNt
bXV2MyxwcmltYXJ5LWJ1cz1jeGwuMSxpZD1zbW11djMuMSBcDQo+ID4NCj4gPiBhcyBweGItY3hs
IGlzIG9mIHR5cGUgVFlQRV9QQ0lfSE9TVF9CUklER0UuIEkgZG9uJ3Qga25vdyBpZiB0aGVyZSBh
cmUgYW55DQo+IG90aGVyDQo+ID4gb25lcyBzaW1pbGFyIHRvIHRoaXMgb3V0IHRoZXJlLg0KPiA+
DQo+ID4gU28gdGhlIGFpbSBpcyB0byBtYWtlIHRoZSBjaGVja2luZyBtb3JlIHNwZWNpZmljIHRv
IFBYQi4NCj4gDQo+IHRoYW5rIHlvdSBmb3IgdGhlIGNsYXJpZmljYXRpb24uIElzIGl0IGludmFs
aWQgdG8gaGF2ZSB0aGUgU01NVQ0KPiBwcm90ZWN0aW5nIFJJRHMgY29tbWluZyBmcm9tIHRoZSBw
eGItY3hsIGhpZXJhcmNoeT8NCg0KVGhhdOKAmXMgYSBnb29kIHF1ZXN0aW9uLiBJIGRvbid0IGtu
b3cgdGhhdCBmb3Igc3VyZS4NCkFueXdheSBjdXJyZW50bHkgdGhlIGZ1bGwgc3VwcG9ydCBmb3Ig
Q1hMIG9uIHZpcnQgaXMgaW4gcHJvZ3Jlc3MgaGVyZSwNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyNTA2MTIxMzQzMzguMTg3MTAyMy0xLUpvbmF0aGFuLkNhbWVyb25AaHVh
d2VpLmNvbS8NCg0KSm9uYXRoYW4/DQoNClRoYW5rcywNClNoYW1lZXINCg0KPiANCg0K

