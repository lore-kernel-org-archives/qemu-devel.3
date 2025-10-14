Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CB0CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hMM-0002tn-7Q; Tue, 14 Oct 2025 11:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8hMK-0002tZ-8U
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:54:44 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8hMG-0003Wg-Rh
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:54:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmJfP30ylz6L5D2;
 Tue, 14 Oct 2025 23:53:33 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 496C41402FE;
 Tue, 14 Oct 2025 23:54:32 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 16:54:31 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 16:54:31 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q///z8ACAABG8wP//+S2AAAIw8TD///c1gP//7sZQgAAX3QD//+6K8IAAFxWA///tGyA=
Date: Tue, 14 Oct 2025 15:54:31 +0000
Message-ID: <c39c066ceb8d4be8a4d462af6029793c@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
 <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
 <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
 <CAFEAcA8-QGBGqjw3Eefx_yyz_30azn9Trz-OGSxq7v4N=X+26Q@mail.gmail.com>
 <a630fc58d9f946988bd6c27479543dd1@huawei.com>
 <CAFEAcA8GsSDnY8GEJZYNbJ3KZAp9tJ=s_vUBB_XwwGaEwozxzQ@mail.gmail.com>
 <880fc89ebcb9404cbc135a501e635671@huawei.com>
 <CAFEAcA-gZj7PBM4whrvvz=qy3taO9Dz4Z2HEAAB8cE0vxH3bug@mail.gmail.com>
In-Reply-To: <CAFEAcA-gZj7PBM4whrvvz=qy3taO9Dz4Z2HEAAB8cE0vxH3bug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.67.200]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMrc2FsaWwubWVodGE9aHVhd2VpLmNvbUBub25nbnUu
b3JnIDxxZW11LQ0KPiBkZXZlbC1ib3VuY2VzK3NhbGlsLm1laHRhPWh1YXdlaS5jb21Abm9uZ251
Lm9yZz4gT24gQmVoYWxmIE9mIFBldGVyDQo+IE1heWRlbGwNCj4gU2VudDogVHVlc2RheSwgT2N0
b2JlciAxNCwgMjAyNSA0OjQ0IFBNDQo+IFRvOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVh
d2VpLmNvbT4NCj4gDQo+IE9uIFR1ZSwgMTQgT2N0IDIwMjUgYXQgMTY6MzMsIFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gRnJvbTogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogVHVlc2RheSwg
T2N0b2JlciAxNCwgMjAyNSA0OjI0IFBNDQo+ID4gPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+DQo+ID4gPg0KPiA+ID4gT24gVHVlLCAxNCBPY3QgMjAyNSBhdCAxNjox
MywgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiA+IEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz4gSW4gd2hhdCBzaXR1YXRpb24NCj4gPiA+ID4gPiBkbyB3ZSBldmVyIHN0YXJ0IHJ1bm5pbmcg
YSBWQ1BVIGJlZm9yZSB0aGUgKkdJQyogaGFzIGJlZW4NCj4gPiA+ID4gPiByZWFsaXplZD8gVGhl
IEdJQyBzaG91bGQgZ2V0IHJlYWxpemVkIGFzIHBhcnQgb2YgY3JlYXRpbmcgdGhlDQo+ID4gPiA+
ID4gdmlydCBib2FyZCwgd2hpY2ggbXVzdCBjb21wbGV0ZSBiZWZvcmUgd2UgZG8gYW55dGhpbmcg
bGlrZSBydW5uaW5nIGENCj4gdmNwdS4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSnVzdCBh
ZnRlciByZWFsaXphdGlvbiBvZiB2Q1BVIGluIHRoZSBtYWNodmlydF9pbml0KCkgeW91IGNhbiBz
ZWUNCj4gPiA+ID4gdGhlIGRlZmF1bHQgcG93ZXJfc3RhdGUgaXMgUFNDSSBDUFVfT04sIHdoaWNo
IG1lYW5zDQo+ID4gPiBLVk1fTVBfU1RBVEVfUlVOTkFCTEUuDQo+ID4gPiA+IFNpbmNlLCB0aGUg
dGhyZWFkIGlzIHVwIGFuZCBub3QgZG9pbmcgSU8gd2FpdCBpbiB1c2Vyc3BhY2UgaXQgZ2V0cw0K
PiA+ID4gPiBpbnRvDQo+ID4gPiA+IGNwdV9leGVjKCkgbG9vcCBhbmQgYWN0dWFsbHkgcnVuIEtW
TV9SVU4gSU9DVEwuIEluc2lkZSB0aGUgS1ZNIGl0DQo+ID4gPiA+IG1vbWVudGFyaWx5IHRha2Vz
IHRoZSB2Q1BVIG11dGV4IGJ1dCBsYXRlciBleGl0IGFuZCByZWxlYXNlcy4gVGhpcw0KPiA+ID4g
PiBrZWVwcyBnb2luZyBvbiBmb3IgYWxsIG9mIHRoZSB2Q1BVIHRocmVhZHMgcmVhbGl6ZWQgZWFy
bHkuDQo+ID4gPg0KPiA+ID4gWWlrZXMuIFdlIGRlZmluaXRlbHkgc2hvdWxkIGZpeCB0aGF0IDog
bGV0dGluZyB0aGUgdmNwdSBydW4gYmVmb3JlDQo+ID4gPiB3ZSBnZXQgdG8NCj4gPiA+IHFlbXVf
bWFjaGluZV9jcmVhdGlvbl9kb25lKCkgc2VlbXMgbGlrZSBpdCB3b3VsZCBiZSBhIG1hc3NpdmUg
c291cmNlDQo+ID4gPiBvZiByYWNlIGNvbmRpdGlvbnMuDQo+ID4NCj4gPiBJJ3ZlIGFscmVhZHkg
cHJvcG9zZWQgZml4IGZvciB0aGlzIGJ5IHBhcmtpbmcgc3VjaCB0aHJlYWRzIGluDQo+ID4gdXNl
cnNwYWNlLiBQbGVhc2UgY2hlY2sgZnVuY3Rpb25zIHZpcnRfKHVuKXBhcmtfY3B1X2luX3VzZXJz
cGFjZSgpLg0KPiA+IEJ1dCBuZWVkIHRvIGNoZWNrIGlmIHdlIGNhbiB1c2UgdGhpcyB0cmljayBj
YW4gYmUgdXNlZCBhdCB0aGUgdmVyeSBlYXJseQ0KPiBzdGFnZXMgb2YgdGhlIFZNIGluaXRpYWxp
emF0aW9uLg0KPiANCj4gSSBoYWQgYSBsb29rIGF0IHRoaXMgb24geDg2LCBhbmQgd2UgY29ycmVj
dGx5IGRvbid0IHRyeSB0byBLVk1fUlVOIHRoZSB2Y3B1cw0KPiBlYXJseS4gV2hhdCBoYXBwZW5z
IHRoZXJlIGlzOg0KPiAgKiB0aGUgdmNwdSB0aHJlYWQgY2FsbHMgcWVtdV9wcm9jZXNzX2NwdV9l
dmVudHMoKQ0KPiAgKiB0aGlzIGNhdXNlcyBpdCB0byBnbyB0byBzbGVlcCBvbiB0aGUgY3B1LT5o
YWx0X2NvbmQ6IHNvDQo+ICAgIGl0IHdpbGwgbm90IGVuZCB1cCBkb2luZyBLVk1fUlVOIHlldA0K
PiAgKiBsYXRlciwgdGhlIG1haW4gdGhyZWFkIGNvbXBsZXRlcyBpbml0aWFsaXphdGlvbiBvZiB0
aGUgYm9hcmQNCj4gICogcWRldl9tYWNoaW5lX2NyZWF0aW9uX2RvbmUoKSBjYWxscyBjcHVfc3lu
Y2hyb25pemVfYWxsX3Bvc3RfaW5pdCgpDQo+ICAqIGZvciBrdm0sIHRoaXMgY2F1c2VzIHVzIHRv
IGNhbGwga3ZtX2NwdV9zeW5jaHJvbml6ZV9wb3N0X2luaXQoKQ0KPiAgICBmb3IgZWFjaCB2Y3B1
DQo+ICAqIHRoYXQgd2lsbCBjYWxsIHJ1bl9vbl9jcHUoKSB3aGljaCBlbmRzIHVwIGNhbGxpbmcg
cWVtdV9jcHVfa2ljaygpDQo+ICAqIHFlbXVfY3B1X2tpY2soKSBkb2VzIGEgYnJvYWRjYXN0IG9u
IGNwdS0+aGFsdF9jb25kLCB3aGljaA0KPiAgICB3YWtlcyB1cCB0aGUgdmNwdSB0aHJlYWQgYW5k
IGxldHMgaXQgZ28gaW50byBrdm1fY3B1X2V4ZWMoKQ0KPiAgICBmb3IgdGhlIGZpcnN0IHRpbWUN
Cj4gDQo+IFdoeSBkb2Vzbid0IHRoaXMgbWVjaGFuaXNtIHdvcmsgb24gQXJtID8NCg0KDQpJIHdp
bGwgbmVlZCBzb21lIHRpbWUgdG8gcmV2aXNpdCB0aGlzLg0KDQoNCk1hbnkgdGhhbmtzIQ0KDQpC
ZXN0IHJlZ2FyZHMNClNhbGlsLg0KDQo=

