Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2A3C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 08:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDIwO-0005hZ-1g; Fri, 09 May 2025 04:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uDIwG-0005ec-1A; Fri, 09 May 2025 04:18:36 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uDIwD-0002da-A8; Fri, 09 May 2025 04:18:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zv1wt4Ytfz6M4l0;
 Fri,  9 May 2025 16:13:50 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 5F4B21402A5;
 Fri,  9 May 2025 16:18:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 10:18:11 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Fri, 9 May 2025 10:18:11 +0200
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Donald Dutile <ddutile@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Shameer Kolothum via <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Topic: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Index: AQHbu1V0fvNxmQCU0kS/eGPfhGB2G7PFgqACgAB1wICAANEzi4AAFpHggAHGkICAAUBjwP//9XyAgAAiG3A=
Date: Fri, 9 May 2025 08:18:11 +0000
Message-ID: <5b46c81a412f410494f28a2f9ebb9430@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org> <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <c0ab36fc56ff498196b359f5aee3746b@huawei.com> <aB25ZRu7pCJNpamt@redhat.com>
In-Reply-To: <aB25ZRu7pCJNpamt@redhat.com>
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgOSwgMjAyNSA5
OjE0IEFNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IENjOiBEb25hbGQgRHV0aWxlIDxkZHV0aWxlQHJlZGhh
dC5jb20+OyBNYXJrdXMgQXJtYnJ1c3Rlcg0KPiA8YXJtYnJ1QHJlZGhhdC5jb20+OyBTaGFtZWVy
IEtvbG90aHVtIHZpYSA8cWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZz47IHFlbXUtYXJtQG5vbmdu
dS5vcmc7IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsNCj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
OyBqZ2dAbnZpZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gbmF0aGFuY0BudmlkaWEu
Y29tOyBtb2Noc0BudmlkaWEuY29tOyBzbW9zdGFmYUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA8
bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5j
b20+Ow0KPiBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENh
bWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5h
cm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS82XSBody9hcm0vc21tdXYzOiBBZGQg
c3VwcG9ydCB0byBhc3NvY2lhdGUgYQ0KPiBQQ0llIFJDDQo+IA0KDQpbLi4uXQ0KDQo+ID4gPiAt
IGJ1cyBwY2llLCBpZD1wY2llLjxudW0+DQo+ID4gPiAtIGRldmljZSBpb21tdT1baW50ZWxfaW9t
bXV8c21tdXYzfGFtZF9pb21tdV0sIGJ1cz1bc3lzYnVzIHwNCj4gPiA+IHBjaWUuPG51bT5dLCBp
ZD1pb21tdS48bnVtPg0KPiA+ID4gW1llcywgSSdtIHN0aWNraW5nIHdpdGggJ2lvbW11JyBhcyB0
aGUgZ2VuZXJpYyBuYW1pbmcuLi4gZXZlcnlvbmUgdGhpbmtzDQo+IG9mDQo+ID4gPiBkZXZpY2Ug
U01NVXMgYXMgSU9NTVVzLA0KPiA+ID4gICBhbmQgUUVNVSBzaG91bGQgaGF2ZSBhIG1vcmUgYXJj
aC1hZ25vc3RpYyBuYW1pbmcgb2YgdGhlc2Ugc3lzdGVtDQo+ID4gPiBmdW5jdGlvbnMuIF0NCj4g
Pg0KPiA+IE9rLiBCdXQgdG8gY2lyY2xlIGJhY2sgdG8gd2hhdCBvcmlnaW5hbGx5IHN0YXJ0ZWQg
dGhpcyBkaXNjdXNzaW9u4oCUaG93DQo+IGltcG9ydGFudA0KPiA+IGlzIGl0IHRvIHJlbHkgb24g
dGhlIGRlZmF1bHQgImJ1cyIgaW4gdGhpcyBjYXNlPyBBcyBNYXJrdXMgcG9pbnRlZCBvdXQsDQo+
IFNNTVV2Mw0KPiA+IGlzIGEgcGxhdGZvcm0gZGV2aWNlIG9uIHRoZSBzeXNidXMsIHNvIGl0cyBk
ZWZhdWx0IGJ1cyB0eXBlIGNhbuKAmXQgcG9pbnQgdG8NCj4gc29tZXRoaW5nDQo+ID4gbGlrZSBQ
Q0llLiBRRU1VIGRvZXNu4oCZdCBjdXJyZW50bHkgc3VwcG9ydCB0aGF0Lg0KPiA+DQo+ID4gVGhl
IG1haW4gbW90aXZhdGlvbiBmb3IgdXNpbmcgdGhlIGRlZmF1bHQgImJ1cyIgc28gZmFyIGhhcyBi
ZWVuIHRvIGhhdmUNCj4gYmV0dGVyDQo+ID4gY29tcGF0aWJpbGl0eSB3aXRoIGxpYnZpcnQuIFdv
dWxkIGxpYnZpcnQgYmUgZmxleGlibGUgZW5vdWdoIGlmIHdlIHN3aXRjaGVkDQo+IHRvIHVzaW5n
DQo+ID4gc29tZXRoaW5nIGxpa2UgYSAicHJpbWFyeS1idXMiIHByb3BlcnR5IGluc3RlYWQ/DQo+
IA0KPiBTb3JyeSBpZiBteSBwcmV2aW91cyBjb21tZW50cyBtaXNsZWQgeW91LCB3aGVuIEkgcHJl
dmlvdXNseSB0YWxrZWQgYWJvdXQNCj4gbGlua2luZyB2aWEgYSAiYnVzIiBwcm9wZXJ0eSBJIHdh
cyBub3QgY29uc2lkZXJpbmcgdGhlIGZhY3QgdGhhdCAiYnVzIg0KPiBpcyBhIHNwZWNpYWwgcHJv
cGVydHkgaW5zaWRlIFFFTVUuIEZyb20gYSBsaWJ2aXJ0IFBPViB3ZSBkb24ndCBjYXJlIHdoYXQN
Cj4gdGhlIHByb3BlcnR5IGlzIGNhbGwgLSBpdCB3YXMganVzdCBpbnRlbmRlZCB0byBiZSBhIGdl
bmVyYWwgaWxsdXN0cmF0aW9uDQo+IG9mIGNyb3NzLXJlZmVyZW5jaW5nIHRoZSBpb21tdSB3aXRo
IHRoZSBQQ0kgYnVzIGl0IG5lZWRlZCB0byBiZSBhc3NvY2lhdGVkDQo+IHdpdGguDQoNCkNvb2wu
IFRoYXQgbWFrZXMgbGlmZSBlYXNpZXIg8J+Yig0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

