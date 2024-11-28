Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD783D690E8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 08:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGZt0-0007Mj-0K; Thu, 28 Nov 2024 03:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tGZsu-0007LO-HC; Thu, 28 Nov 2024 03:28:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tGZss-0000Of-6a; Thu, 28 Nov 2024 03:28:23 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XzTqm0ldKz6K5Xl;
 Thu, 28 Nov 2024 16:24:20 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id DF0DC1400F4;
 Thu, 28 Nov 2024 16:28:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 09:28:15 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 28 Nov 2024 09:28:15 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Zhangfei Gao
 <zhangfei.gao@linaro.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Donald Dutile <ddutile@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Thread-Topic: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Thread-Index: AQHbMeWSJ83HnnIr30KCqoK78hZMsLK1adCAgAAO0ACAFHTOgIABDrKggABaSYCAAAGHgIAAvdCAgABOkYCAABTxcA==
Date: Thu, 28 Nov 2024 08:28:15 +0000
Message-ID: <3fa6f093ff9a4749bcd25d0dfa60b1d7@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <20241127160031.GA1253388@nvidia.com>
 <bd4c4665-148c-427b-8717-457c584fb233@redhat.com>
 <CABQgh9ErT6BmvbrUr_aNiLFws2Kx-=NzGJJCo+vV7AV_U6Pk9g@mail.gmail.com>
 <05470fe6-4336-455a-8b30-e05fb273aa25@redhat.com>
In-Reply-To: <05470fe6-4336-455a-8b30-e05fb273aa25@redhat.com>
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
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.931, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjgsIDIwMjQg
ODowNyBBTQ0KPiBUbzogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4g
Q2M6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBTaGFtZWVyYWxpIEtvbG90aHVt
IFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBEb25hbGQg
RHV0aWxlDQo+IDxkZHV0aWxlQHJlZGhhdC5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52
aWRpYS5jb20+OyBxZW11LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3Jn
OyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7DQo+IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWku
Y29tPjsgV2FuZ3pob3UgKEIpDQo+IDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vu
a3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRo
YW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAyLzVdIGh3
L2FybS9zbW11djM6IEFkZCBpbml0aWFsIHN1cHBvcnQgZm9yDQo+IFNNTVV2MyBOZXN0ZWQgZGV2
aWNlDQo+IA0KPiANCj4gDQo+IE9uIDExLzI4LzI0IDA0OjI1LCBaaGFuZ2ZlaSBHYW8gd3JvdGU6
DQo+ID4gSGksIEVyaWMNCj4gPg0KPiA+IE9uIFRodSwgMjggTm92IDIwMjQgYXQgMDA6MDYsIEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4+IFllYWgs
IHRoZXJlIGlzIG5vIGxpdmUgbWlncmF0aW9uIHN1cHBvcnQgeWV0IGluIHRoZSBTTU1VIHFtZXUg
ZHJpdmVyLA0KPiA+Pj4gQUZBSUs/DQo+ID4+IHRoZSBub24gYWNjZWxlcmF0ZWQgU01NVSBRRU1V
IGRldmljZSBkb2VzIHN1cHBvcnQgbWlncmF0aW9uLg0KPiA+IENvdWxkIHlvdSBjbGFyaWZ5IG1v
cmUgYWJvdXQgdGhpcz8NCj4gPiBUaGUgbWlncmF0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgaWYgdXNp
bmcgdmlvbW11IChTTU1VIFFFTVUgZGV2aWNlKSwNCj4gaXNuJ3QgaXQ/DQo+IE5vIHRoaXMgaXMg
bm90IGNvcnJlY3QuIEN1cnJlbnQgUUVNVSBTTU1VIGRldmljZSAqZG9lcyogc3VwcG9ydA0KPiBt
aWdyYXRpb24gKHNlZSBWTVN0YXRlRGVzY3JpcHRpb24pIGFzIHdlbGwgYXMgcWVtdSB2aXJ0aW8t
aW9tbXUgZGV2aWNlLg0KPiBzbyBmb3IgaW5zdGFuY2UgaWYgeW91IHJ1biBhIGd1ZXN0IHdpdGgg
c21tdXYzIGFuZCBwcm90ZWN0ZWQgdmlydGlvLXBjaQ0KPiBkZXZpY2VzIHRoaXMgaXMgc3VwcG9z
ZWQgdG8gYmUgbWlncmF0YWJsZS4gSWYgaXQgZG9lcyBub3Qgd29yayB0aGlzIGlzDQo+IGJ1ZyBh
bmQgdGhpcyBzaG91bGQgYmUgZml4ZWQgOy0pDQoNCkkgdGhpbmsgaWYgSSBhbSByaWdodCBaaGFu
Z2ZlaSB3YXMgdGVzdGluZyB3aXRoIHZmaW8tcGNpIGRldmljZSBhc3NpZ25lZCBvbiBoaXMgdlNW
QQ0KYnJhbmNoLiBCdXQgbWlncmF0aW9uIHdpdGggdmZpbyBkZXZpY2UgaXMgY3VycmVudGx5IGV4
cGxpY2l0bHkgYmxvY2tlZCBpZiB2SU9NTVUgaXMNCnByZXNlbnQuIA0KDQpJIHRoaW5rIEpvYW8g
aXMgd29ya2luZyBvbiBpdCBoZXJlWzFdLg0KDQpCdXQgd2UgbWF5IHJlcXVpcmUgYWRkaXRpb25h
bCBzdXBwb3J0IHdoZW4gd2UgaGF2ZSB2U1ZBIHRvIGhhbmRsZSBhbnkNCmluLWZsaWdodCBwYWdl
IGZhdWx0IGhhbmRsaW5nIGdyYWNlZnVsbHkuDQoNClRoYW5rcywNClNoYW1lZXINCjEuIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDYyMjIxNDg0NS4zOTgwLTEtam9hby5tLm1hcnRp
bnNAb3JhY2xlLmNvbS8NCg0KDQoNCg==

