Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2410CC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 09:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuq2J-0006T8-MP; Wed, 19 Mar 2025 05:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuq2H-0006SX-GE; Wed, 19 Mar 2025 05:48:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuq2E-0006Mj-CR; Wed, 19 Mar 2025 05:48:29 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZHkMR6MWzz6L750;
 Wed, 19 Mar 2025 17:44:51 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 371DD1408E8;
 Wed, 19 Mar 2025 17:48:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Mar 2025 10:48:10 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 19 Mar 2025 10:48:10 +0100
To: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Thread-Topic: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Thread-Index: AQHbkuuEEgiH8g4VGkW4jjcernEsFrN5pqEAgACXapA=
Date: Wed, 19 Mar 2025 09:48:09 +0000
Message-ID: <42f9953fc7dd40d9bcd4919914530b89@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
 <28452954-7be2-4114-8d37-a208250b6f83@redhat.com>
In-Reply-To: <28452954-7be2-4114-8d37-a208250b6f83@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9uYWxkIER1dGlsZSA8
ZGR1dGlsZUByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE5LCAyMDI1IDE6
MzEgQU0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KPiBDYzogZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29tOw0KPiBuaWNvbGluY0BudmlkaWEuY29tOyBiZXJy
YW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+IG1vY2hzQG52aWRpYS5jb207
IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPjsg
V2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGppYW5na3Vua3VuIDxq
aWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2Ft
ZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6
IFtSRkMgUEFUQ0ggdjIgMTMvMjBdIGh3L2FybS9zbW11djMtYWNjZWw6IEludHJvZHVjZSBoZWxw
ZXJzDQo+IHRvIGJhdGNoIGFuZCBpc3N1ZSBjYWNoZSBpbnZhbGlkYXRpb25zDQo+IA0KPiBTaGFt
ZWVyLA0KPiANCj4gSGksDQo+IA0KPiANCj4gT24gMy8xMS8yNSAxMDoxMCBBTSwgU2hhbWVlciBL
b2xvdGh1bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5j
b20+DQo+ID4NCj4gPiBJbnJvZHVjZSBhbiBTTU1VQ29tbWFuZEJhdGNoIGFuZCBzb21lIGhlbHBl
cnMgdG8gYmF0Y2ggYW5kIGlzc3VlDQo+IHRoZQ0KPiAgICBeXl5eXl5eXiBJbnRyb2R1Y2UNCj4g
PiBjb21tYW5kcy4gIEN1cnJlbnRseSBzZXBhcmF0ZSBvdXQgVExCSSBjb21tYW5kcyBhbmQgZGV2
aWNlIGNhY2hlDQo+ID4gY29tbWFuZHMgdG8gYXZvaWQgc29tZSBlcnJhdGEgb24gY2VydGFpbiB2
ZXJzaW9ucyBvZiBTTU1Vcy4gTGF0ZXIgaXQNCj4gPiBzaG91bGQgY2hlY2sgSUlEUiByZWdpc3Rl
ciB0byBkZXRlY3QgaWYgdW5kZXJseWluZyBTTU1VIGh3IGhhcyBzdWNoIGFuDQo+IGVycmF0dW0u
DQo+IFdoZXJlIGlzIGFsbCB0aGlzIGluZm8gYWJvdXQgJ2NlcnRhaW4gdmVyc2lvbnMgb2YgU01N
VXMnIGFuZCAnY2hlY2sgSUlEUg0KPiByZWdpc3RlcicgaGFzIHNvbWV0aGluZyB0byBkbyB3aXRo
ICd1bmRlcmx5aW5nIFNNTVUgaHcgc3VjaCBhbiBlcnJhdHVtJywNCj4gLS0gd2hpY2ggSUlEUiAo
JiBiaXRzKT8gb3IgYXJlIHdlIHRhbGtpbmcgYWJvdXQgcnN2ZCBTTU1VX0lEUjw+IHJlZ2lzdGVy
cz8NCg0KSSBndWVzcyB0aGUgYmF0Y2hpbmcgaGFzIGNvbnN0cmFpbnRzIG9uIHNvbWUgcGxhdGZv
cm1zLCBJSVJDLCB0aGlzIHdhcyBkaXNjdXNzZWQNCnNvbWV3aGVyZSBpbiBhIGtlcm5lbCB0aHJl
YWQuICANCg0KTmljb2xpbiwgY291bGQgeW91IHBsZWFzZSBwcm92aWRlIHNvbWUgYmFja2dyb3Vu
ZCBvbiB0aGlzLg0KDQo+IA0KPiBBbmQgY2FuJ3QgdGhlc2UgaGVscGVycyBiZSB1c2VkIGZvciBl
bXVsYXRlZCBzbW11djMgYXMgd2VsbCBhcw0KPiBhY2NlbGVyYXRlZD8NCg0KQ291bGQgYmUgSSBn
dWVzcy4gQnV0IG5vIGJlbmVmaXQgaW4gdGVybXMgb2YgcGVyZm9ybWFuY2UuIE1heSBiZSB3aWxs
IG1ha2UNCmNvZGUgbG9vayBuaWNlci4gSSB3aWxsIHRha2UgYSBsb29rIGlmIG5vdCBtdWNoIG9m
IGNoYW5nZXMgaW4gdGhlIGVtdWxhdGVkIHBhdGguDQoNClRoYW5rcywNClNoYW1lZXINCg0KDQo=

