Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB24CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hYZ-00081t-Hp; Tue, 14 Oct 2025 12:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8hYX-00080o-Ua
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:07:21 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8hYQ-00056d-PX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:07:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmJtl2SxBz6GDSM;
 Wed, 15 Oct 2025 00:04:15 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 828C51402C8;
 Wed, 15 Oct 2025 00:07:05 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 17:07:05 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 17:07:05 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q///z8ACAABG8wP//+S2AAAIw8TD///c1gP//7sZQgAAX3QD//+6K8P//07fQ
Date: Tue, 14 Oct 2025 16:07:05 +0000
Message-ID: <57c971afc3e64c1cbd48d032fb557c00@huawei.com>
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
In-Reply-To: <880fc89ebcb9404cbc135a501e635671@huawei.com>
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

PiBGcm9tOiBTYWxpbCBNZWh0YQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE0LCAyMDI1IDQ6
MzMgUE0NCj4gVG86ICdQZXRlciBNYXlkZWxsJyA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0K
PiANCj4gPiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+
ID4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNCwgMjAyNSA0OjI0IFBNDQo+ID4gVG86IFNhbGls
IE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+DQo+ID4gT24gVHVlLCAxNCBPY3Qg
MjAyNSBhdCAxNjoxMywgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IHdy
b3RlOg0KPiA+ID4NCj4gPiA+ID4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPiBJbiB3aGF0IHNpdHVhdGlvbg0KPiA+ID4gPiBkbyB3ZSBldmVyIHN0YXJ0IHJ1
bm5pbmcgYSBWQ1BVIGJlZm9yZSB0aGUgKkdJQyogaGFzIGJlZW4NCj4gPiA+ID4gcmVhbGl6ZWQ/
IFRoZSBHSUMgc2hvdWxkIGdldCByZWFsaXplZCBhcyBwYXJ0IG9mIGNyZWF0aW5nIHRoZSB2aXJ0
DQo+ID4gPiA+IGJvYXJkLCB3aGljaCBtdXN0IGNvbXBsZXRlIGJlZm9yZSB3ZSBkbyBhbnl0aGlu
ZyBsaWtlIHJ1bm5pbmcgYSB2Y3B1Lg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBKdXN0IGFmdGVyIHJl
YWxpemF0aW9uIG9mIHZDUFUgaW4gdGhlIG1hY2h2aXJ0X2luaXQoKSB5b3UgY2FuIHNlZQ0KPiA+
ID4gdGhlIGRlZmF1bHQgcG93ZXJfc3RhdGUgaXMgUFNDSSBDUFVfT04sIHdoaWNoIG1lYW5zDQo+
ID4gS1ZNX01QX1NUQVRFX1JVTk5BQkxFLg0KPiA+ID4gU2luY2UsIHRoZSB0aHJlYWQgaXMgdXAg
YW5kIG5vdCBkb2luZyBJTyB3YWl0IGluIHVzZXJzcGFjZSBpdCBnZXRzDQo+ID4gPiBpbnRvDQo+
ID4gPiBjcHVfZXhlYygpIGxvb3AgYW5kIGFjdHVhbGx5IHJ1biBLVk1fUlVOIElPQ1RMLiBJbnNp
ZGUgdGhlIEtWTSBpdA0KPiA+ID4gbW9tZW50YXJpbHkgdGFrZXMgdGhlIHZDUFUgbXV0ZXggYnV0
IGxhdGVyIGV4aXQgYW5kIHJlbGVhc2VzLiBUaGlzDQo+ID4gPiBrZWVwcyBnb2luZyBvbiBmb3Ig
YWxsIG9mIHRoZSB2Q1BVIHRocmVhZHMgcmVhbGl6ZWQgZWFybHkuDQo+ID4NCj4gPiBZaWtlcy4g
V2UgZGVmaW5pdGVseSBzaG91bGQgZml4IHRoYXQgOiBsZXR0aW5nIHRoZSB2Y3B1IHJ1biBiZWZv
cmUgd2UNCj4gPiBnZXQgdG8NCj4gPiBxZW11X21hY2hpbmVfY3JlYXRpb25fZG9uZSgpIHNlZW1z
IGxpa2UgaXQgd291bGQgYmUgYSBtYXNzaXZlIHNvdXJjZQ0KPiA+IG9mIHJhY2UgY29uZGl0aW9u
cy4NCj4gDQo+IEkndmUgYWxyZWFkeSBwcm9wb3NlZCBmaXggZm9yIHRoaXMgYnkgcGFya2luZyBz
dWNoIHRocmVhZHMgaW4gdXNlcnNwYWNlLiBQbGVhc2UNCj4gY2hlY2sgZnVuY3Rpb25zIHZpcnRf
KHVuKXBhcmtfY3B1X2luX3VzZXJzcGFjZSgpLiBCdXQgbmVlZCB0byBjaGVjayBpZiB3ZQ0KPiBj
YW4gdXNlIHRoaXMgdHJpY2sgY2FuIGJlIHVzZWQgYXQgdGhlIHZlcnkgZWFybHkgc3RhZ2VzIG9m
IHRoZSBWTSBpbml0aWFsaXphdGlvbi4NCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Fl
bXUtZGV2ZWwvMjAyNTEwMDEwMTAxMjcuMzA5MjYzMS0xOC0NCj4gc2FsaWwubWVodGFAb3Buc3Jj
Lm5ldC8NCj4gDQo+IA0KPiBJIGFsc28gdGhpbmsgd2UgbmVlZCAxOjEgbWFwcGluZyBiZXR3ZWVu
IHRoZSBBUk1DUFUgcG93ZXItc3RhdGUgYW5kIHRoZQ0KPiBLVk0gTVBfU1RBVEUuICBSaWdodCBu
b3csDQo+IA0KPiBLVk1fTVBfU1RBVEVfUlVOTkFCTEUgPSB7UFNDSSBDUFVfT0ZGLCBQU0NJIENQ
VV9PTn0NCj4gS1ZNX01QX1NUQVRFX1NUT1BQRUQgICAgPSB7UFNDSSBDUFVfT0ZGfQ0KPiANCj4g
S1ZNIE1QIFN0YXRlIFJVTk5BQkxFIHNlZW1zIGFtYmlndW91cy4gU2hvdWxkIHdlIHVzZSBQU0NJ
DQo+IENQVV9QRU5ESU5HIGF0IGVhcmx5IHN0YWdlcyBpbnN0ZWFkPw0KDQpUaGVyZSBpcyBvbmUg
bW9yZSBpc3N1ZS4NCg0KLyoNCiAqIFVwZGF0ZSBLVk0ncyBNUF9TVEFURSBiYXNlZCBvbiB3aGF0
IFFFTVUgdGhpbmtzIGl0IGlzDQogKi8NCnN0YXRpYyBpbnQga3ZtX2FybV9zeW5jX21wc3RhdGVf
dG9fa3ZtKEFSTUNQVSAqY3B1KQ0Kew0KICAgIGlmIChjYXBfaGFzX21wX3N0YXRlKSB7DQogICAg
ICAgIHN0cnVjdCBrdm1fbXBfc3RhdGUgbXBfc3RhdGUgPSB7DQogICAgICAgICAgICAubXBfc3Rh
dGUgPSAoY3B1LT5wb3dlcl9zdGF0ZSA9PSBQU0NJX09GRikgPw0KICAgICAgICAgICAgS1ZNX01Q
X1NUQVRFX1NUT1BQRUQgOiBLVk1fTVBfU1RBVEVfUlVOTkFCTEUNCiAgICAgICAgfTsNCiAgICAg
ICAgcmV0dXJuIGt2bV92Y3B1X2lvY3RsKENQVShjcHUpLCBLVk1fU0VUX01QX1NUQVRFLCAmbXBf
c3RhdGUpOw0KICAgIH0NCiAgICByZXR1cm4gMDsNCn0NCg0KDQp2YWx1ZSBvZiBQU0NJX09GRiA9
IDEgYW5kIHdlIGRvIG5vdCBpbml0aWFsaXplIHRoZSBkZWZhdWx0IHN0YXRlIG9mIHBvd2VyX3N0
YXRlLg0KVGhpcyBtZWFucyBLVk1fTVBfU1RBVEUgc3RhdGUgd2lsbCBiZSBjb25maWd1cmVkIGFz
IFJVTk5BQkxFIGF0IHRoZSBmaXJzdA0KaW5zdGFuY2UgdGlsbCB0aGUgY3B1X3Jlc2V0KCkgaGFw
cGVucy4gVGhpcyBpcyBub3QgY29ycmVjdCBlaXRoZXIuDQoNCkJ1dCB0aGVuIHdoYXQgc2hvdWxk
IGJlIHRoZSB2Q1BVcyBkZWZhdWx0IHN0YXRlLCBLVk1fTVBfU1RBVEUgX1NUT1BQRUQ/DQpTdG9w
cGVkIGlzIGltcGxlbWVudGVkIGFzIHNsZWVwIGluc2lkZSB0aGUgS1ZNIC0gYSBibG9ja2luZyBj
YWxsLiAgQW4gaW52aXRhdGlvbg0KdG8gdGhlIHZDUFUgbG9jayBjb250ZW50aW9uPyBvciBzaG91
bGQgYmUgc2xlZXAgaW4gdXNlcnNwYWNlPw0KDQpzdGF0aWMgdm9pZCBrdm1fdmNwdV9zbGVlcChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQp7DQoJc3RydWN0IHJjdXdhaXQgKndhaXQgPSBrdm1fYXJj
aF92Y3B1X2dldF93YWl0KHZjcHUpOw0KDQoJcmN1d2FpdF93YWl0X2V2ZW50KHdhaXQsDQoJCQkg
ICAoIWt2bV9hcm1fdmNwdV9zdG9wcGVkKHZjcHUpKSAmJiAoIXZjcHUtPmFyY2gucGF1c2UpLA0K
CQkJICAgVEFTS19JTlRFUlJVUFRJQkxFKTsNCg0KCWlmIChrdm1fYXJtX3ZjcHVfc3RvcHBlZCh2
Y3B1KSB8fCB2Y3B1LT5hcmNoLnBhdXNlKSB7DQoJCS8qIEF3YWtlbiB0byBoYW5kbGUgYSBzaWdu
YWwsIHJlcXVlc3Qgd2Ugc2xlZXAgYWdhaW4gbGF0ZXIuICovDQoJCWt2bV9tYWtlX3JlcXVlc3Qo
S1ZNX1JFUV9TTEVFUCwgdmNwdSk7DQoJfQ0KDQoJLyoNCgkgKiBNYWtlIHN1cmUgd2Ugd2lsbCBv
YnNlcnZlIGEgcG90ZW50aWFsIHJlc2V0IHJlcXVlc3QgaWYgd2UndmUNCgkgKiBvYnNlcnZlZCBh
IGNoYW5nZSB0byB0aGUgcG93ZXIgc3RhdGUuIFBhaXJzIHdpdGggdGhlIHNtcF93bWIoKSBpbg0K
CSAqIGt2bV9wc2NpX3ZjcHVfb24oKS4NCgkgKi8NCglzbXBfcm1iKCk7DQp9DQoNCg0K

