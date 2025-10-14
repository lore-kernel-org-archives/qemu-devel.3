Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3350CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gKf-0001Ke-ES; Tue, 14 Oct 2025 10:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8gKd-0001KW-1u
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:48:55 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8gKY-0002NZ-IB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:48:53 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmH875dykz6GDSn;
 Tue, 14 Oct 2025 22:45:43 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id CB0FA1402F0;
 Tue, 14 Oct 2025 22:48:33 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 15:48:33 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 15:48:33 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q///z8ACAABG8wP//+S2AAAIw8TA=
Date: Tue, 14 Oct 2025 14:48:33 +0000
Message-ID: <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
 <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
In-Reply-To: <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
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

SGkgUGV0ZXIsDQoNCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE0LCAyMDI1IDM6MjkgUE0NCj4gVG86IFNh
bGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiANCj4gT24gVHVlLCAxNCBPY3Qg
MjAyNSBhdCAxNToyMiwgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgUGV0ZXIsDQo+ID4NCj4gPiA+IEZyb206IFBldGVyIE1heWRlbGwgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTQs
IDIwMjUgMjo1MCBQTQ0KPiA+ID4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWku
Y29tPg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgMTQgT2N0IDIwMjUgYXQgMTQ6NDEsIFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4gSSB0aG91Z2h0
IHlvdSBhc2tlZCBtZSB0byB2YWxpZGF0ZSB0aGUgZml4IGJ5IHJlcGxhY2luZyBiZWxvdzoNCj4g
PiA+ID4NCj4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MTAw
MTAxMDEyNy4zMDkyNjMxLTIyLXNhbGlsDQo+ID4gPiA+IC5tZWgNCj4gPiA+ID4gdGFAb3Buc3Jj
Lm5ldC8NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gWWVzLCBJJ20gdXNpbmcgdGhlIHJlY2Vu
dCBSRkMgVjYgdkNQVSBIb3RwbHVnIHBhdGNoZXMgYnJhbmNoIEkndmUNCj4gPiA+ID4gcHVzaGVk
IHRvIHRoZSBjb21tdW5pdHkuDQo+ID4gPiA+DQo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvMjAyNTEwMDEwMTAxMjcuMzA5MjYzMS0xLXNhbGlsLg0KPiA+ID4gPiBt
ZWh0DQo+ID4gPiA+IGFAb3Buc3JjLm5ldC8NCj4gPiA+DQo+ID4gPiBUaGF0J3MgdGhlIG9uZSB3
aXRoIHRoZSAibGF6eSByZWFsaXplIiBoYWNrLCByaWdodD8gSSBpbWFnaW5lIHdoYXQncw0KPiA+
ID4gaGFwcGVuaW5nIGlzIHRoYXQgd2UgcmVhbGl6ZSB0aGUgR0lDLCBhbmQgdGhlIGNvZGUgaW4g
dGhpcyBwYXRjaA0KPiA+ID4gYXNzdW1lcyB0aGF0IGFsbCB0aGUgQ1BVcyBhcmUgYWxyZWFkeSBy
ZWFsaXplZCBhdCB0aGF0IHBvaW50LiBXaGVuDQo+ID4gPiB3ZSB0cnkgdG8gZ2V0IHRoZSByZWdp
c3RlciB2YWx1ZSBmb3IgYSBub3QteWV0LXJlYWxpemVkIENQVSB0aGUga2VybmVsDQo+IGNvbXBs
YWlucy4NCj4gPg0KPiA+DQo+ID4gRXZlbiBpZiB3ZSByZWFsaXplIGFsbCBvZiB0aGUgdkNQVXMg
dGhlIHByb2JsZW0gd2lsbCBub3QgZ28gYXdheS4gVGhpcw0KPiA+IHByb2JsZW0gaXMgaGFwcGVu
aW5nIGJlY2F1c2Ugd2UgaGF2ZSByZWNlbnRseSBzdGFydGVkIHRvIEV4aXQgSHlwZXJjYWxscw0K
PiB0byB1c2Vyc3BhY2UuDQo+ID4gVGhpcyBtZWFucyB3ZSBhcmUgbm93IGFjY2Vzc2luZyB0aGUg
c3lzdGVtIHJlZ2lzdGVyIGluIGEgbm9uLWF0b21pYw0KPiBjb250ZXh0Lg0KPiANCj4gVGhlIHBv
aW50IG9mIHRoaXMgcGF0Y2ggaXMgdGhhdCBpdCBtb3ZlcyB0aGUgcmVhZCBvZiBJQ0NfQ1RMUl9F
TDEgb3V0IG9mIHRoZQ0KPiByZXNldCBwYXRoIGFuZCBpbnRvIHRoZSBHSUMgcmVhbGl6ZSBtZXRo
b2QsIGF0IHdoaWNoIHBvaW50IG5vIHZDUFVzIHNob3VsZA0KPiBoYXZlIHN0YXJ0ZWQgcnVubmlu
Zy4gQnV0IGl0IGRvZXMgYXNzdW1lIHRoYXQgeW91IGRvbid0IGhhdmUgaGFsZi1jcmVhdGVkDQo+
IFZDUFVzIGNvbm5lY3RlZCB0byB0aGUgR0lDLg0KDQoNClRoaXMgSXMgbm90IHRydWUuIEFjdHVh
bGx5LCBpbm5lciBjcHVfZXhlYygpIChpbiBrdm0tYWxsLi5jKSAgbG9vcCBrZWVwcyBvbiBkaXBw
aW5nDQppbnRvIHRoZSBLVk1fUlVOIElPQ1RMIGFuZCBleGl0aW5nIGJhY2sgd2l0aCBJTlRSIGNv
bnRpbnVvdXNseSBhcyB0aGUgcmVhbGl6ZWQNCnZDUFVzIGFyZSBpbiBSVU5OQUJMRSBzdGF0ZSBp
bml0aWFsbHkuIFRoZSBhY3R1YWwgInN0YXJ0LXBvd2VyZWQtb2ZmIiBwb2xpY3kgb25seQ0KZ2V0
cyBhcHBsaWVkIGFmdGVyIGZpcnN0IHN5c3RlbS1yZXNldCBoYXBwZW5zLg0KDQpIZW5jZSwgdGhp
cyBpcyB0aGUgc3RhdGUgb2YgKnRyYW5zaWVudCogbG9jayBjb250ZW50aW9uIHdpdGhpbiB0aGUg
S1ZNIGFuZCBpcyANCnByb2JhYmlsaXN0aWMuIEl0IGFsc28gZXhwbGFpbnMgd2h5IGl0IGRvZXMg
bm90IGhhcHBlbnMgYWx3YXlzLg0KDQpJZiB3ZSBpbmNyZWFzZSB0aGUgbnVtYmVyIG9mIHJlYWxp
emVkIHZDUFUgdGhyZWFkcywgdGhlIHByb2JhYmlsaXR5IG9mIHRoaXMNCnRyYW5zaWVudCBsb2Nr
IGNvbnRlbnRpb24gYmVjb21lcyBldmVuIGhpZ2hlciBhbmQgeW91IHdpbGwgdGVuZCB0byBzZWUg
dGhpcw0KY29uZGl0aW9uIG1vc3Qgb2YgdGhlIHRpbWVzLg0KDQoNCg0KPiANCj4gPiBUaGUgb2Jz
ZXJ2YXRpb24geW91IGFyZSBzZWVpbmcgaGFzIGdvdCBub3RoaW5nIHRvIGRvIHdpdGggbGF6eSBy
ZWFsaXphdGlvbi4NCj4gPiBUaGUgcHJvYmxlbSBoYXBwZW5zIGV2ZW4gYWZ0ZXIgdGhyZWFkcyBh
cmUgcmVhbGl6ZWQgYW5kIHRoZW4gd2UgdHJ5IHRvDQo+ID4gYWNjZXNzIHRoZSBJQ0NfQ1RMUl9F
TDEgcmVnaXN0ZXIgZHVyaW5nIGNwdV9yZXNldCgpDQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2gsIHdl
IHNob3VsZCBub3QgYmUgYWNjZXNzaW5nIElDQ19DVExSX0VMMSBkdXJpbmcgQ1BVIHJlc2V0Lg0K
PiBUaGUgYmFja3RyYWNlIHlvdSBwb3N0ZWQgZG9lcyBub3QgaGF2ZSBDUFUgcmVzZXQgaW4gaXQs
IHNvIHdoYXRldmVyIGlzIGdvaW5nDQo+IHdyb25nIHRoZXJlIG11c3QgYmUgc29tZXRoaW5nIGVs
c2UuDQoNClllcywgYnV0IGl0cyBjcmFzaGluZyBpbiB0aGUgcmVhbGl6YXRpb24gb2YgdGhlIEdJ
QyBpLmUuIGluIGNvbnRleHQgb2YgbWFjaHZpcnRfaW5pdCgpDQpGaXJzdCByZXNldCBvZiB0aGUg
dkNQVXMgaGFwcGVucyBtdWNoIGxhdGVyIHRoYW4gdGhpcy4gSGVuY2UsIHRoZSByZWFzb24gb2Yg
dGhpcw0KY29udGVudGlvbiBpcyBkaWZmZXJlbnQgdGhhbiB0aGUgb25lIHlvdSBhcmUgdHJ5aW5n
IHRvIHNvbHZlIHVzaW5nIHRoaXMgcGF0Y2guDQpXZSBjYW4gZ2V0IC1FQlVTWSBhdCBtYW55IGRp
ZmZlcmVudCBwYXRocyBidXQgdGhlIHJlYXNvbiBpcyBhbHdheXMgdkNQVSBsb2NrDQpjb250ZW50
aW9uLiBJdCBjb3VsZCBiZSB0cmFuc2llbnQgb3IgYmVjYXVzZSBndWVzdCBhcmUgYWN0dWFsbHkg
cnVubmluZyBpbnNpZGUNCnRoZSBLVk1fUlVOIElPQ1RMICh3aGljaCBtZWFucyB2Q1BVIG11dGV4
IHdpbGwgYmUgaGVsZCAtIGEgbW9yZSBwZXJtYW5lbnQNCmNvbmRpdGlvbikNCg0KTWFueSB0aGFu
a3MhDQoNCkJlc3QgcmVnYXJkcw0KU2FsaWwuDQo=

