Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7813ACCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8giQ-0007QJ-D2; Tue, 14 Oct 2025 11:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8giK-0007Pp-Th
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:13:24 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8giF-0005qL-Ox
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:13:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmHhX3L5jz6GDT1;
 Tue, 14 Oct 2025 23:10:20 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 85BF81402E9;
 Tue, 14 Oct 2025 23:13:10 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 16:13:10 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 16:13:10 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q///z8ACAABG8wP//+S2AAAIw8TD///c1gP//7sZQ
Date: Tue, 14 Oct 2025 15:13:10 +0000
Message-ID: <a630fc58d9f946988bd6c27479543dd1@huawei.com>
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
In-Reply-To: <CAFEAcA8-QGBGqjw3Eefx_yyz_30azn9Trz-OGSxq7v4N=X+26Q@mail.gmail.com>
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

PiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMTQsIDIwMjUgNDowMCBQTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNh
bGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IA0KPiBPbiBUdWUsIDE0IE9jdCAyMDI1IGF0IDE1OjQ4
LCBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBI
aSBQZXRlciwNCj4gPg0KPiA+ID4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPg0KPiA+ID4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNCwgMjAyNSAzOjI5IFBN
DQo+ID4gPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4gPg0K
PiA+ID4gT24gVHVlLCAxNCBPY3QgMjAyNSBhdCAxNToyMiwgU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBQZXRlciwNCj4g
PiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+DQo+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNCwgMjAyNSAyOjUwIFBN
DQo+ID4gPiA+ID4gVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gT24gVHVlLCAxNCBPY3QgMjAyNSBhdCAxNDo0MSwgU2FsaWwgTWVo
dGENCj4gPiA+ID4gPiA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+
ID4gPiA+ID4gSSB0aG91Z2h0IHlvdSBhc2tlZCBtZSB0byB2YWxpZGF0ZSB0aGUgZml4IGJ5IHJl
cGxhY2luZyBiZWxvdzoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsLzIwMjUxMDAxMDEwMTI3LjMwOTI2MzEtMjItcw0KPiA+ID4gPiA+
ID4gYWxpbA0KPiA+ID4gPiA+ID4gLm1laA0KPiA+ID4gPiA+ID4gdGFAb3Buc3JjLm5ldC8NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gWWVzLCBJJ20gdXNpbmcgdGhlIHJl
Y2VudCBSRkMgVjYgdkNQVSBIb3RwbHVnIHBhdGNoZXMgYnJhbmNoDQo+ID4gPiA+ID4gPiBJJ3Zl
IHB1c2hlZCB0byB0aGUgY29tbXVuaXR5Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEwMDEwMTAxMjcuMzA5MjYzMS0xLQ0K
PiBzYWxpbC4NCj4gPiA+ID4gPiA+IG1laHQNCj4gPiA+ID4gPiA+IGFAb3Buc3JjLm5ldC8NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFRoYXQncyB0aGUgb25lIHdpdGggdGhlICJsYXp5IHJlYWxpemUi
IGhhY2ssIHJpZ2h0PyBJIGltYWdpbmUNCj4gPiA+ID4gPiB3aGF0J3MgaGFwcGVuaW5nIGlzIHRo
YXQgd2UgcmVhbGl6ZSB0aGUgR0lDLCBhbmQgdGhlIGNvZGUgaW4NCj4gPiA+ID4gPiB0aGlzIHBh
dGNoIGFzc3VtZXMgdGhhdCBhbGwgdGhlIENQVXMgYXJlIGFscmVhZHkgcmVhbGl6ZWQgYXQNCj4g
PiA+ID4gPiB0aGF0IHBvaW50LiBXaGVuIHdlIHRyeSB0byBnZXQgdGhlIHJlZ2lzdGVyIHZhbHVl
IGZvciBhDQo+ID4gPiA+ID4gbm90LXlldC1yZWFsaXplZCBDUFUgdGhlIGtlcm5lbA0KPiA+ID4g
Y29tcGxhaW5zLg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBFdmVuIGlmIHdlIHJlYWxpemUg
YWxsIG9mIHRoZSB2Q1BVcyB0aGUgcHJvYmxlbSB3aWxsIG5vdCBnbyBhd2F5Lg0KPiA+ID4gPiBU
aGlzIHByb2JsZW0gaXMgaGFwcGVuaW5nIGJlY2F1c2Ugd2UgaGF2ZSByZWNlbnRseSBzdGFydGVk
IHRvIEV4aXQNCj4gPiA+ID4gSHlwZXJjYWxscw0KPiA+ID4gdG8gdXNlcnNwYWNlLg0KPiA+ID4g
PiBUaGlzIG1lYW5zIHdlIGFyZSBub3cgYWNjZXNzaW5nIHRoZSBzeXN0ZW0gcmVnaXN0ZXIgaW4g
YQ0KPiA+ID4gPiBub24tYXRvbWljDQo+ID4gPiBjb250ZXh0Lg0KPiA+ID4NCj4gPiA+IFRoZSBw
b2ludCBvZiB0aGlzIHBhdGNoIGlzIHRoYXQgaXQgbW92ZXMgdGhlIHJlYWQgb2YgSUNDX0NUTFJf
RUwxDQo+ID4gPiBvdXQgb2YgdGhlIHJlc2V0IHBhdGggYW5kIGludG8gdGhlIEdJQyByZWFsaXpl
IG1ldGhvZCwgYXQgd2hpY2gNCj4gPiA+IHBvaW50IG5vIHZDUFVzIHNob3VsZCBoYXZlIHN0YXJ0
ZWQgcnVubmluZy4gQnV0IGl0IGRvZXMgYXNzdW1lIHRoYXQNCj4gPiA+IHlvdSBkb24ndCBoYXZl
IGhhbGYtY3JlYXRlZCBWQ1BVcyBjb25uZWN0ZWQgdG8gdGhlIEdJQy4NCj4gPg0KPiA+DQo+ID4g
VGhpcyBJcyBub3QgdHJ1ZS4gQWN0dWFsbHksIGlubmVyIGNwdV9leGVjKCkgKGluIGt2bS1hbGwu
LmMpICBsb29wDQo+ID4ga2VlcHMgb24gZGlwcGluZyBpbnRvIHRoZSBLVk1fUlVOIElPQ1RMIGFu
ZCBleGl0aW5nIGJhY2sgd2l0aCBJTlRSDQo+ID4gY29udGludW91c2x5IGFzIHRoZSByZWFsaXpl
ZCB2Q1BVcyBhcmUgaW4gUlVOTkFCTEUgc3RhdGUgaW5pdGlhbGx5Lg0KPiA+IFRoZSBhY3R1YWwg
InN0YXJ0LXBvd2VyZWQtb2ZmIiBwb2xpY3kgb25seSBnZXRzIGFwcGxpZWQgYWZ0ZXIgZmlyc3Qg
c3lzdGVtLQ0KPiByZXNldCBoYXBwZW5zLg0KPiANCj4gSW4gd2hhdCBzaXR1YXRpb24gZG8gd2Ug
ZXZlciBzdGFydCBydW5uaW5nIGEgVkNQVSBiZWZvcmUgdGhlICpHSUMqIGhhcw0KPiBiZWVuIHJl
YWxpemVkPyBUaGUgR0lDIHNob3VsZCBnZXQgcmVhbGl6ZWQgYXMgcGFydCBvZiBjcmVhdGluZyB0
aGUgdmlydCBib2FyZCwNCj4gd2hpY2ggbXVzdCBjb21wbGV0ZSBiZWZvcmUgd2UgZG8gYW55dGhp
bmcgbGlrZSBydW5uaW5nIGEgdmNwdS4NCg0KDQpKdXN0IGFmdGVyIHJlYWxpemF0aW9uIG9mIHZD
UFUgaW4gdGhlIG1hY2h2aXJ0X2luaXQoKSB5b3UgY2FuIHNlZSB0aGUgZGVmYXVsdCANCnBvd2Vy
X3N0YXRlIGlzIFBTQ0kgQ1BVX09OLCB3aGljaCBtZWFucyBLVk1fTVBfU1RBVEVfUlVOTkFCTEUu
DQpTaW5jZSwgdGhlIHRocmVhZCBpcyB1cCBhbmQgbm90IGRvaW5nIElPIHdhaXQgaW4gdXNlcnNw
YWNlIGl0IGdldHMgaW50bw0KY3B1X2V4ZWMoKSBsb29wIGFuZCBhY3R1YWxseSBydW4gS1ZNX1JV
TiBJT0NUTC4gSW5zaWRlIHRoZSBLVk0gaXQNCm1vbWVudGFyaWx5IHRha2VzIHRoZSB2Q1BVIG11
dGV4IGJ1dCBsYXRlciBleGl0IGFuZCByZWxlYXNlcy4gVGhpcyBrZWVwcw0KZ29pbmcgb24gZm9y
IGFsbCBvZiB0aGUgdkNQVSB0aHJlYWRzIHJlYWxpemVkIGVhcmx5Lg0KDQpTdXJlLCBidXQgR0lD
IGlzIG5vdCBnZXR0aW5nIHVzZWQgYnkgYW55IG9mIHRoZSB2Q1BVIHRocmVhZHMuIFRoZSBndWVz
dA0Ka2VybmVsIGFuZCBoZW5jZSB0aGUgVkdJQyBkcml2ZXIgZG9lcyBub3QgZXhpc3QgeWV0LiBJ
dCBuZWVkcyB0byBkbyBpdHMNCmluaXRpYWxpemF0aW9uIGZpcnN0IGJlZm9yZSB3ZSBjYW4gZXZl
biB0aGluayBvZiBhbnkgaW50ZXJydXB0IGhhbmRsaW5nPw0KDQoNCg0KPiANCj4gPiA+ID4gVGhl
IG9ic2VydmF0aW9uIHlvdSBhcmUgc2VlaW5nIGhhcyBnb3Qgbm90aGluZyB0byBkbyB3aXRoIGxh
enkNCj4gcmVhbGl6YXRpb24uDQo+ID4gPiA+IFRoZSBwcm9ibGVtIGhhcHBlbnMgZXZlbiBhZnRl
ciB0aHJlYWRzIGFyZSByZWFsaXplZCBhbmQgdGhlbiB3ZQ0KPiA+ID4gPiB0cnkgdG8gYWNjZXNz
IHRoZSBJQ0NfQ1RMUl9FTDEgcmVnaXN0ZXIgZHVyaW5nIGNwdV9yZXNldCgpDQo+ID4gPg0KPiA+
ID4gV2l0aCB0aGlzIHBhdGNoLCB3ZSBzaG91bGQgbm90IGJlIGFjY2Vzc2luZyBJQ0NfQ1RMUl9F
TDEgZHVyaW5nIENQVQ0KPiByZXNldC4NCj4gPiA+IFRoZSBiYWNrdHJhY2UgeW91IHBvc3RlZCBk
b2VzIG5vdCBoYXZlIENQVSByZXNldCBpbiBpdCwgc28gd2hhdGV2ZXINCj4gPiA+IGlzIGdvaW5n
IHdyb25nIHRoZXJlIG11c3QgYmUgc29tZXRoaW5nIGVsc2UuDQo+ID4NCj4gPiBZZXMsIGJ1dCBp
dHMgY3Jhc2hpbmcgaW4gdGhlIHJlYWxpemF0aW9uIG9mIHRoZSBHSUMgaS5lLiBpbiBjb250ZXh0
IG9mDQo+ID4gbWFjaHZpcnRfaW5pdCgpIEZpcnN0IHJlc2V0IG9mIHRoZSB2Q1BVcyBoYXBwZW5z
IG11Y2ggbGF0ZXIgdGhhbiB0aGlzLg0KPiA+IEhlbmNlLCB0aGUgcmVhc29uIG9mIHRoaXMgY29u
dGVudGlvbiBpcyBkaWZmZXJlbnQgdGhhbiB0aGUgb25lIHlvdSBhcmUNCj4gdHJ5aW5nIHRvIHNv
bHZlIHVzaW5nIHRoaXMgcGF0Y2guDQo+IA0KPiBZZXMsIGFuZCBteSBzdWdnZXN0aW9uIGlzIHRo
YXQgdGhlIGZhaWx1cmUgeW91IGFyZSBzZWVpbmcgaXMgb25seSBiZWNhdXNlIHlvdQ0KPiBoYXZl
IGdvdCBoYWxmLWNyZWF0ZWQgdmNwdSBvYmplY3RzLiBZb3VyIGJhY2t0cmFjZSBzaG93cyB0aGF0
IHRoZSBlcnJvciBoZXJlDQo+IGlzIG5vdCBFQlVTWSwgYnV0IEVOT1RUWS4NCg0KDQpMZXQgbWUg
cmV2aXNpdCB0aGF0IHBhcnQgYWdhaW4uDQoNCg0KTWFueSB0aGFua3MhDQoNCkJlc3QgcmVnYXJk
cw0KU2FsaWwuDQo=

