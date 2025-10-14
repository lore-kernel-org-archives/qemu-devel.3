Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280C8CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gln-0001pf-2I; Tue, 14 Oct 2025 11:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8glj-0001pG-CY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:16:55 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8gld-0006Ov-Oa
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:16:54 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmHls4Rssz6K91q;
 Tue, 14 Oct 2025 23:13:13 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (unknown [7.214.147.1])
 by mail.maildlp.com (Postfix) with ESMTPS id 594B01402F7;
 Tue, 14 Oct 2025 23:16:41 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml500004.china.huawei.com (7.214.147.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 16:16:41 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 16:16:40 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q///z8ACAABG8wP//+S2AAAIw8TD///c1gP//7sZQ///ZxVA=
Date: Tue, 14 Oct 2025 15:16:40 +0000
Message-ID: <f4e1d82c905148529e6628a0e69b365d@huawei.com>
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
In-Reply-To: <a630fc58d9f946988bd6c27479543dd1@huawei.com>
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

DQoNCj4gRnJvbTogU2FsaWwgTWVodGENCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNCwgMjAy
NSA0OjEzIFBNDQo+IFRvOiAnUGV0ZXIgTWF5ZGVsbCcgPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRh
QG9wbnNyYy5uZXQ+OyBNYXJjDQo+IFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBSRTogW1BBVENIXSBody9pbnRjL2FybV9naWN2M19rdm06IEF2b2lkIHJlYWRpbmcgSUNDX0NU
TFJfRUwxDQo+IGZyb20ga2VybmVsIGluIGNwdWlmIHJlc2V0DQo+IA0KPiA+IEZyb206IFBldGVy
IE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDE0LCAyMDI1IDQ6MDAgUE0NCj4gPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRh
QGh1YXdlaS5jb20+DQo+ID4NCj4gPiBPbiBUdWUsIDE0IE9jdCAyMDI1IGF0IDE1OjQ4LCBTYWxp
bCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4g
SGkgUGV0ZXIsDQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+DQo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTQsIDIwMjUg
MzoyOSBQTQ0KPiA+ID4gPiBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+
DQo+ID4gPiA+DQo+ID4gPiA+IE9uIFR1ZSwgMTQgT2N0IDIwMjUgYXQgMTU6MjIsIFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gSGkgUGV0ZXIsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZyb206IFBldGVyIE1heWRl
bGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXks
IE9jdG9iZXIgMTQsIDIwMjUgMjo1MCBQTQ0KPiA+ID4gPiA+ID4gVG86IFNhbGlsIE1laHRhIDxz
YWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uIFR1ZSwg
MTQgT2N0IDIwMjUgYXQgMTQ6NDEsIFNhbGlsIE1laHRhDQo+ID4gPiA+ID4gPiA8c2FsaWwubWVo
dGFAaHVhd2VpLmNvbT4NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEkgdGhvdWdodCB5
b3UgYXNrZWQgbWUgdG8gdmFsaWRhdGUgdGhlIGZpeCBieSByZXBsYWNpbmcgYmVsb3c6DQo+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNTEwMDEwMTAxMjcuMzA5MjYzMS0yMg0KPiA+ID4gPiA+ID4gPiAtcw0KPiA+ID4gPiA+
ID4gPiBhbGlsDQo+ID4gPiA+ID4gPiA+IC5tZWgNCj4gPiA+ID4gPiA+ID4gdGFAb3Buc3JjLm5l
dC8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gWWVzLCBJJ20g
dXNpbmcgdGhlIHJlY2VudCBSRkMgVjYgdkNQVSBIb3RwbHVnIHBhdGNoZXMgYnJhbmNoDQo+ID4g
PiA+ID4gPiA+IEkndmUgcHVzaGVkIHRvIHRoZSBjb21tdW5pdHkuDQo+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEwMDEw
MTAxMjcuMzA5MjYzMS0xLQ0KPiA+IHNhbGlsLg0KPiA+ID4gPiA+ID4gPiBtZWh0DQo+ID4gPiA+
ID4gPiA+IGFAb3Buc3JjLm5ldC8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGF0J3MgdGhl
IG9uZSB3aXRoIHRoZSAibGF6eSByZWFsaXplIiBoYWNrLCByaWdodD8gSSBpbWFnaW5lDQo+ID4g
PiA+ID4gPiB3aGF0J3MgaGFwcGVuaW5nIGlzIHRoYXQgd2UgcmVhbGl6ZSB0aGUgR0lDLCBhbmQg
dGhlIGNvZGUgaW4NCj4gPiA+ID4gPiA+IHRoaXMgcGF0Y2ggYXNzdW1lcyB0aGF0IGFsbCB0aGUg
Q1BVcyBhcmUgYWxyZWFkeSByZWFsaXplZCBhdA0KPiA+ID4gPiA+ID4gdGhhdCBwb2ludC4gV2hl
biB3ZSB0cnkgdG8gZ2V0IHRoZSByZWdpc3RlciB2YWx1ZSBmb3IgYQ0KPiA+ID4gPiA+ID4gbm90
LXlldC1yZWFsaXplZCBDUFUgdGhlIGtlcm5lbA0KPiA+ID4gPiBjb21wbGFpbnMuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEV2ZW4gaWYgd2UgcmVhbGl6ZSBhbGwgb2YgdGhlIHZD
UFVzIHRoZSBwcm9ibGVtIHdpbGwgbm90IGdvIGF3YXkuDQo+ID4gPiA+ID4gVGhpcyBwcm9ibGVt
IGlzIGhhcHBlbmluZyBiZWNhdXNlIHdlIGhhdmUgcmVjZW50bHkgc3RhcnRlZCB0bw0KPiA+ID4g
PiA+IEV4aXQgSHlwZXJjYWxscw0KPiA+ID4gPiB0byB1c2Vyc3BhY2UuDQo+ID4gPiA+ID4gVGhp
cyBtZWFucyB3ZSBhcmUgbm93IGFjY2Vzc2luZyB0aGUgc3lzdGVtIHJlZ2lzdGVyIGluIGENCj4g
PiA+ID4gPiBub24tYXRvbWljDQo+ID4gPiA+IGNvbnRleHQuDQo+ID4gPiA+DQo+ID4gPiA+IFRo
ZSBwb2ludCBvZiB0aGlzIHBhdGNoIGlzIHRoYXQgaXQgbW92ZXMgdGhlIHJlYWQgb2YgSUNDX0NU
TFJfRUwxDQo+ID4gPiA+IG91dCBvZiB0aGUgcmVzZXQgcGF0aCBhbmQgaW50byB0aGUgR0lDIHJl
YWxpemUgbWV0aG9kLCBhdCB3aGljaA0KPiA+ID4gPiBwb2ludCBubyB2Q1BVcyBzaG91bGQgaGF2
ZSBzdGFydGVkIHJ1bm5pbmcuIEJ1dCBpdCBkb2VzIGFzc3VtZQ0KPiA+ID4gPiB0aGF0IHlvdSBk
b24ndCBoYXZlIGhhbGYtY3JlYXRlZCBWQ1BVcyBjb25uZWN0ZWQgdG8gdGhlIEdJQy4NCj4gPiA+
DQo+ID4gPg0KPiA+ID4gVGhpcyBJcyBub3QgdHJ1ZS4gQWN0dWFsbHksIGlubmVyIGNwdV9leGVj
KCkgKGluIGt2bS1hbGwuLmMpICBsb29wDQo+ID4gPiBrZWVwcyBvbiBkaXBwaW5nIGludG8gdGhl
IEtWTV9SVU4gSU9DVEwgYW5kIGV4aXRpbmcgYmFjayB3aXRoIElOVFINCj4gPiA+IGNvbnRpbnVv
dXNseSBhcyB0aGUgcmVhbGl6ZWQgdkNQVXMgYXJlIGluIFJVTk5BQkxFIHN0YXRlIGluaXRpYWxs
eS4NCj4gPiA+IFRoZSBhY3R1YWwgInN0YXJ0LXBvd2VyZWQtb2ZmIiBwb2xpY3kgb25seSBnZXRz
IGFwcGxpZWQgYWZ0ZXIgZmlyc3QNCj4gPiA+IHN5c3RlbS0NCj4gPiByZXNldCBoYXBwZW5zLg0K
PiA+DQo+ID4gSW4gd2hhdCBzaXR1YXRpb24gZG8gd2UgZXZlciBzdGFydCBydW5uaW5nIGEgVkNQ
VSBiZWZvcmUgdGhlICpHSUMqIGhhcw0KPiA+IGJlZW4gcmVhbGl6ZWQ/IFRoZSBHSUMgc2hvdWxk
IGdldCByZWFsaXplZCBhcyBwYXJ0IG9mIGNyZWF0aW5nIHRoZQ0KPiA+IHZpcnQgYm9hcmQsIHdo
aWNoIG11c3QgY29tcGxldGUgYmVmb3JlIHdlIGRvIGFueXRoaW5nIGxpa2UgcnVubmluZyBhIHZj
cHUuDQo+IA0KPiANCj4gSnVzdCBhZnRlciByZWFsaXphdGlvbiBvZiB2Q1BVIGluIHRoZSBtYWNo
dmlydF9pbml0KCkgeW91IGNhbiBzZWUgdGhlIGRlZmF1bHQNCj4gcG93ZXJfc3RhdGUgaXMgUFND
SSBDUFVfT04sIHdoaWNoIG1lYW5zIEtWTV9NUF9TVEFURV9SVU5OQUJMRS4NCj4gU2luY2UsIHRo
ZSB0aHJlYWQgaXMgdXAgYW5kIG5vdCBkb2luZyBJTyB3YWl0IGluIHVzZXJzcGFjZSBpdCBnZXRz
IGludG8NCj4gY3B1X2V4ZWMoKSBsb29wIGFuZCBhY3R1YWxseSBydW4gS1ZNX1JVTiBJT0NUTC4g
SW5zaWRlIHRoZSBLVk0gaXQNCj4gbW9tZW50YXJpbHkgdGFrZXMgdGhlIHZDUFUgbXV0ZXggYnV0
IGxhdGVyIGV4aXQgYW5kIHJlbGVhc2VzLiBUaGlzIGtlZXBzDQo+IGdvaW5nIG9uIGZvciBhbGwg
b2YgdGhlIHZDUFUgdGhyZWFkcyByZWFsaXplZCBlYXJseS4NCg0KU29ycnkgZm9yIHRoZSBjb25m
dXNpb24sDQoNCkZvcmdpdmUgbWUsIHBvd2VyIHN0YXRlIGlzIG5vdCBQU0NJIENQVV9PTiBidXQg
dGhlIEtWTV9NUF9TVEFURSBpcyBzdGlsbA0KUlVOTkFCTEUNCg0K

