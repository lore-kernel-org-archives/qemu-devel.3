Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9A0D690E9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 08:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGZiX-0004bC-9O; Thu, 28 Nov 2024 03:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tGZi5-0004YB-5z; Thu, 28 Nov 2024 03:17:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tGZi1-0003e0-7P; Thu, 28 Nov 2024 03:17:11 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XzTcG6nfQz6GD5T;
 Thu, 28 Nov 2024 16:14:22 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 2A2291400F4;
 Thu, 28 Nov 2024 16:17:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 09:17:01 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 28 Nov 2024 09:17:01 +0100
To: Donald Dutile <ddutile@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Thread-Topic: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Thread-Index: AQHbMeWSJ83HnnIr30KCqoK78hZMsLK1adCAgAAO0ACAFHTOgIABDrKggAErcACAAEyecA==
Date: Thu, 28 Nov 2024 08:17:01 +0000
Message-ID: <0bd57012eb5d43008096a6d992aef8a4@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <04c73d87-35ce-4e11-a906-17c1e2961387@redhat.com>
In-Reply-To: <04c73d87-35ce-4e11-a906-17c1e2961387@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9uYWxkIER1dGlsZSA8
ZGR1dGlsZUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjgsIDIwMjQg
NDoyOSBBTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgTmljb2xpbiBDaGVuDQo+IDxuaWNvbGluY0Budmlk
aWEuY29tPjsgRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiBDYzogcWVtdS1h
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc7IGpnZ0BudmlkaWEuY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNv
bT47IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiBqaWFuZ2t1bmt1
biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUkZDIFBBVENIIDIvNV0gaHcvYXJtL3NtbXV2MzogQWRkIGluaXRpYWwgc3VwcG9ydCBm
b3INCj4gU01NVXYzIE5lc3RlZCBkZXZpY2UNCj4gDQo+IA0KPiA+Pj4gVy5yLnQgbmFtaW5nLCBt
YXliZSBzb21ldGhpbmcgcmVsYXRlZCB0byAiaGFyZHdhcmUtYWNjZWxlcmF0ZWQiPw0KPiA+Pj4N
Cj4gPj4gR2l2ZW4gdGhhdCAnYWNjZWwnIGhhcyBiZWVuIHVzZWQgZm9yIGh3LWFjY2VsZXJhdGlv
biBlbHNld2hlcmUsIHRoYXQNCj4gc2VlbXMNCj4gPj4gbGlrZSBhIHJlYXNvbmFibGUgJ21vZGUn
Lg0KPiA+PiBCdXQsIGl0IG5lZWRzIGEgcGFyYW1hdGVyIHRvIHN0YXRlIHdhcyBpcyBiZWluZyBh
Y2NlbGVyYXRlZC4NCj4gPj4gaS5lLiwgdGhlIG1vcmUgZ2xvYmFsICdhY2NlbD1rdm0nIGhhcyAn
a3ZtJy4NCj4gPg0KPiA+IEkgd2FzIHRoaW5raW5nIG1vcmUgbGlrZSBjYWxsaW5nIHRoaXMgaHcg
YWNjZWxlcmF0ZWQgbmVzdGVkIFNNTVV2Mw0KPiBlbXVsYXRpb24NCj4gPiBhcyAnc21tdXYzLWFj
Y2VsJy4gIFRoaXMgYXZvaWRzIGNvbmZ1c2lvbiB3aXRoIHRoZSBhbHJlYWR5IGV4aXN0aW5nDQo+
ID4gJ2lvbW11PXNtbXV2MycgdGhhdCBhbHNvIGhhcyBhIG5lc3RlZCBlbXVsYXRpb24gc3VwcG9y
dC4NCj4gPg0KPiA+IGllLA0KPiA+IC1kZXZpY2UgYXJtLXNtbXV2My1hY2NlbCxpZD1zbW11djEs
YnVzPXBjaWUuMSBcDQo+ID4NCj4gSSAtdGhpbmstIHlvdSBhcmUgc2F5aW5nIGJlbG93LCB0aGF0
IHdlIGhhdmUgdG8gdGhpbmsgYSBiaXQgbW9yZSBhYm91dCB0aGlzDQo+IGRldmljZSB0YWdnaW5n
LiAgSSdtIHRoaW5raW5nIG1vcmUgbGlrZQ0KPiAgIC0gZGV2aWNlIGFybS1zbW11djMsYWNjZWw9
PHZjbWRxPixpZD1zbW11MSxidXM9cGNpZS4xIFwNCg0KT2suIEJ1dCBJIHRoaW5rIHRoZSBpbml0
aWFsIHN1Z2dlc3Rpb24gdG8gY2FsbCB0aGlzIHNvbWV0aGluZyBlbHNlIG90aGVyIHRoYW4gYXJt
LXNtbXV2Mw0KY2FtZSBmcm9tIHRoZSBmYWN0IHRoYXQgaXQgbWFrZXMgdXNlIG9mIHBoeXNpY2Fs
IFNNTVV2MyBuZXN0ZWQgc3RhZ2Ugc3VwcG9ydC4gVGhpcyBpcw0KcmVxdWlyZWQgZm9yIHZmaW8t
cGNpIGFzc2lnbm1lbnQuIFNvIEkgdXNlZCAiYWNjZWwiIGluIHRoYXQgY29udGV4dC4gVGhhdCBp
cyB3aGF0IEkNCm1lYW4gYnkgYmFzaWMgZnVuY3Rpb25hbGl0eSBvZiB0aGlzIFNNTVVWMyBkZXZp
Y2UuIElmIHdlIG5lZWQgYW55IGFkZGl0aW9uYWwgYWNjZWxlcmF0ZWQNCmZlYXR1cmUgc3VwcG9y
dCB0aGVuIHRoYXQgY2FuIGJlIHByb3ZpZGVkIGFzICJwcm9wZXJ0aWVzIiBvbiB0b3Agb2YgdGhp
cy4gTGlrZSwNCg0KLSBkZXZpY2UgYXJtLXNtbXV2My1hY2NlbCxpZD1zbW11MSxidXM9cGNpZS4x
LHZjbWRxPW9uIFwNCg0KT3IgbWF5IGJlIGFzIE5pY29saW4ncyBzdWdnZXN0aW9uKHdpdGhvdXQg
ZXhwbGljaXQgInZjbWRxIikgb2YgcHJvYmluZyBmb3IgdkNNRFENCnN1cHBvcnQgdHJhbnNwYXJl
bnRseSBhbmQgZmFsbGluZyBiYWNrIHRvIGJhc2ljIHN1cHBvcnQgaWYgbm90IGF2YWlsYWJsZS4N
Cg0KSSBwcmVmZXIgdGhlIGZpcnN0IG9uZSB3aGljaCBnaXZlcyBhbiBvcHRpb24gdG8gdHVybiBv
ZmYgaWYgcmVxdWlyZWQuIEJ1dCBkb27igJl0IGhhdmUgYW55DQpzdHJvbmcgb3BpbmlvbiBlaXRo
ZXIgd2F5LiANCg0KVGhhbmtzLA0KU2hhbWVlci4NCg==

