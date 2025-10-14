Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ACDCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fIO-0007DL-LD; Tue, 14 Oct 2025 09:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8fHs-00074t-Qt
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:42:04 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8fHV-0001ts-LN
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:41:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmFfg4X3tz6GDSK;
 Tue, 14 Oct 2025 21:38:35 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 832771402FE;
 Tue, 14 Oct 2025 21:41:25 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 14:41:25 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 14:41:25 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q
Date: Tue, 14 Oct 2025 13:41:25 +0000
Message-ID: <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
In-Reply-To: <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
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
IFR1ZXNkYXksIE9jdG9iZXIgMTQsIDIwMjUgMjozMSBQTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNh
bGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IA0KPiBPbiBUdWUsIDE0IE9jdCAyMDI1IGF0IDE0OjIz
LCBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBI
aSBQZXRlciwNCj4gPg0KPiA+ID4gRnJvbTogcWVtdS1kZXZlbC1ib3VuY2VzK3NhbGlsLm1laHRh
PWh1YXdlaS5jb21Abm9uZ251Lm9yZw0KPiA8cWVtdS0NCj4gPiA+IGRldmVsLWJvdW5jZXMrc2Fs
aWwubWVodGE9aHVhd2VpLmNvbUBub25nbnUub3JnPiBPbiBCZWhhbGYgT2YgU2FsaWwNCj4gPiA+
IE1laHRhIHZpYQ0KPiA+ID4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNCwgMjAyNSAxMTo0MSBB
TQ0KPiA+ID4gVG86IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IHFl
bXUtDQo+IGRldmVsQG5vbmdudS5vcmcNCj4gPiA+DQo+ID4gPiBIaSBQZXRlciwNCj4gPiA+DQo+
ID4gPiA+IEZyb206IHFlbXUtZGV2ZWwtYm91bmNlcytzYWxpbC5tZWh0YT1odWF3ZWkuY29tQG5v
bmdudS5vcmcNCj4gPiA+IDxxZW11LQ0KPiA+ID4gPiBkZXZlbC1ib3VuY2VzK3NhbGlsLm1laHRh
PWh1YXdlaS5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mDQo+ID4gPiA+IGRldmVsLWJvdW5j
ZXMrUGV0ZXINCj4gPiA+ID4gTWF5ZGVsbA0KPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVy
IDE0LCAyMDI1IDExOjI1IEFNDQo+ID4gPiA+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4g
PiA+ID4NCj4gPiA+ID4gQ3VycmVudGx5IGluIGFybV9naWN2M19pY2NfcmVzZXQoKSB3ZSByZWFk
IHRoZSBrZXJuZWwncyB2YWx1ZSBvZg0KPiA+ID4gPiBJQ0NfQ1RMUl9FTDEgYXMgcGFydCBvZiBy
ZXNldHRpbmcgdGhlIENQVSBpbnRlcmZhY2UuICBUaGlzIG1vc3RseQ0KPiA+ID4gPiB3b3Jrcywg
YnV0IHdlJ3JlIGFjdHVhbGx5IGJyZWFraW5nIGFuIGFzc3VtcHRpb24gdGhlIGtlcm5lbCBtYWtl
cw0KPiA+ID4gPiB0aGF0IHVzZXJzcGFjZSBvbmx5IGFjY2Vzc2VzIHRoZSBpbi1rZXJuZWwgR0lD
IGRhdGEgd2hlbiB0aGUgVk0gaXMNCj4gPiA+ID4gdG90YWxseSBwYXVzZWQsIHdoaWNoIG1heSBu
b3QgYmUgdGhlIGNhc2UgaWYgYSBzaW5nbGUgdkNQVSBpcyBiZWluZw0KPiByZXNldC4NCj4gPiA+
ID4gVGhlIGVmZmVjdCBpcyB0aGF0IGl0J3MgcG9zc2libGUgdGhhdCB0aGUgcmVhZCBhdHRlbXB0
IHJldHVybnMgRUJVU1kuDQo+ID4gPiA+DQo+ID4gPiA+IEF2b2lkIHRoaXMgYnkgcmVhZGluZyB0
aGUga2VybmVsJ3MgdmFsdWUgb2YgdGhlIHJlc2V0IElDQ19DVExSX0VMMQ0KPiA+ID4gPiBvbmNl
IGluIGRldmljZSByZWFsaXplLiBUaGlzIGJyaW5ncyBJQ0NfQ1RMUl9FTDEgaW50byBsaW5lIHdp
dGgNCj4gPiA+ID4gdGhlIG90aGVyIGNwdWlmIHJlZ2lzdGVycywgd2hlcmUgd2UgYXNzdW1lIHdl
IGtub3cgd2hhdCB0aGUga2VybmVsDQo+ID4gPiA+IGlzIHJlc2V0dGluZyB0aGVtIHRvIGFuZCBq
dXN0IHVwZGF0ZSBRRU1VJ3MgZGF0YSBzdHJ1Y3R1cmVzIGluDQo+ID4gPiBhcm1fZ2ljdjNfaWNj
X3Jlc2V0KCkuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIE1heWRlbGwg
PHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IEkndmUgb25s
eSB0ZXN0ZWQgdGhpcyBmYWlybHkgbGlnaHRseSwgYnV0IGl0IHNlZW1zIHRvIHdvcmsuDQo+ID4g
PiA+IFNhbGlsLCBkb2VzIHRoaXMgZml4IHRoZSBFQlVTWSBpc3N1ZXMgeW91IHdlcmUgc2VlaW5n
ID8NCj4gPiA+DQo+ID4gPg0KPiA+ID4gTGV0IG1lIHRyeSB0aGlzIGFuZCBnZXQgYmFjayB0byB5
b3UuICBBbHNvLCBqdXN0IHRvIGxldCB5b3Uga25vdw0KPiA+ID4gdGhhdCAtRUJVU1kgY2FuIHJl
dHVybiBmcm9tIG90aGVyIHBsYWNlcyBhcyB3ZWxsLiBQbGVhc2UgY2hlY2sgIG15DQo+ID4gPiBy
ZXBseSBpbiB0aGUgb3RoZXIgbWFpbC0gY2hhaW4uDQo+ID4NCj4gPg0KPiA+IEdvdCB0aGlzLg0K
PiA+DQo+ID4gKGdkYikgaGFuZGxlIFNJR1VTUjEgbm9zdG9wIG5vcHJpbnQgcGFzcw0KPiA+IFNp
Z25hbCAgICAgICAgU3RvcCAgICAgIFByaW50ICAgUGFzcyB0byBwcm9ncmFtIERlc2NyaXB0aW9u
DQo+ID4gU0lHVVNSMSAgICAgICBObyAgICAgICAgTm8gICAgICBZZXMgICAgICAgICAgICAgVXNl
ciBkZWZpbmVkIHNpZ25hbCAxDQo+ID4gKGdkYikgcnVuDQo+ID4gU3RhcnRpbmcgcHJvZ3JhbToN
Cj4gPiAvb3B0L3dvcmtzcGFjZS9jb2RlL3FlbXUvcWVtdS9idWlsZC9xZW11LXN5c3RlbS1hYXJj
aDY0IC0tZW5hYmxlLQ0KPiBrdm0NCj4gPiAtbWFjaGluZSB2aXJ0LGdpYy12ZXJzaW9uPTMgLWNw
dSBob3N0IC1zbXAgY3B1cz0yLGRpc2FibGVkY3B1cz0yIC1tDQo+ID4gMzAwTSAta2VybmVsIC9v
cHQvd29ya3NwYWNlL2NvZGUvbGludXgvbGludXgvYXJjaC9hcm02NC9ib290L0ltYWdlDQo+ID4g
LWluaXRyZCAvb3B0L3dvcmtzcGFjZS9jb2RlL2ZpbGVzeXN0ZW0vcm9vdGZzLmNwaW8uZ3ogLWFw
cGVuZA0KPiA+IGNvbnNvbGU9dHR5QU1BMFwgcm9vdD0vZGV2L3JhbVwgZWFybHljb25cIHJkaW5p
dD0vaW5pdFwgbWF4Y3B1cz0xXA0KPiA+IGFjcGk9Zm9yY2UgLW5vZ3JhcGhpYyAtYmlvcw0KPiA+
IC9vcHQvd29ya3NwYWNlL2NvZGUvdWVmaS9lZGsyL0J1aWxkL0FybVZpcnRRZW11LQ0KPiBBQVJD
SDY0L1JFTEVBU0VfR0NDNS9GDQo+ID4gVi9RRU1VX0VGSS5mZCBbVGhyZWFkIGRlYnVnZ2luZyB1
c2luZyBsaWJ0aHJlYWRfZGIgZW5hYmxlZF0gVXNpbmcgaG9zdA0KPiA+IGxpYnRocmVhZF9kYiBs
aWJyYXJ5ICIvbGliL2FhcmNoNjQtbGludXgtZ251L2xpYnRocmVhZF9kYi5zby4xIi4NCj4gPiBb
TmV3IFRocmVhZCAweGZmZmZmNWI1ZWI0MCAoTFdQIDMxOTk0KV0gW05ldyBUaHJlYWQgMHhmZmZm
ZjRlODhiNDANCj4gPiAoTFdQIDMxOTk2KV0gW05ldyBUaHJlYWQgMHhmZmZmZDRkZmViNDAgKExX
UCAzMTk5NyldIFVuZXhwZWN0ZWQgZXJyb3INCj4gPiBpbiBrdm1fZGV2aWNlX2FjY2VzcygpIGF0
IC4uL2FjY2VsL2t2bS9rdm0tYWxsLmM6MzQ3NToNCj4gPiBxZW11LXN5c3RlbS1hYXJjaDY0OiBL
Vk1fR0VUX0RFVklDRV9BVFRSIGZhaWxlZDogR3JvdXAgNiBhdHRyDQo+ID4gMHgwMDAwMDAwMDAw
MDBjNjY0OiBJbmFwcHJvcHJpYXRlIGlvY3RsIGZvciBkZXZpY2UNCj4gDQo+IERvZXMgaXQgZG8g
dGhpcyBjb25zaXN0ZW50bHksIG9yIG9ubHkgc29tZXRpbWVzPyBXaGF0IGhvc3Qga2VybmVsIHZl
cnNpb24gYXJlDQo+IHlvdSBydW5uaW5nPyBBbmQgd2hhdCBRRU1VIGNvbW1pdCAocGx1cyB0aGlz
IHBhdGNoKT8NCg0KSSd2ZSB0cmllZCAzIHRpbWVzIGFuZCBpdCBoYXBwZW5lZCBhbGwgdGhlIDMg
dGltZXMgYnV0IHRoaXMgaXMgYSB2ZXJ5IHBlcnRpbmVudA0KcXVlc3Rpb24gYW5kIEknbSBub3Qg
c3VyZSBpZiBldmVyeSBhdHRlbXB0IHdpbGwgbGVhZCB0byB0aGlzLg0KDQpJIHRob3VnaHQgeW91
IGFza2VkIG1lIHRvIHZhbGlkYXRlIHRoZSBmaXggYnkgcmVwbGFjaW5nIGJlbG93Og0KDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUxMDAxMDEwMTI3LjMwOTI2MzEtMjIt
c2FsaWwubWVodGFAb3Buc3JjLm5ldC8NCg0KDQpZZXMsIEknbSB1c2luZyB0aGUgcmVjZW50IFJG
QyBWNiB2Q1BVIEhvdHBsdWcgcGF0Y2hlcyBicmFuY2ggSSd2ZSBwdXNoZWQgdG8gdGhlDQpjb21t
dW5pdHkuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEwMDEwMTAx
MjcuMzA5MjYzMS0xLXNhbGlsLm1laHRhQG9wbnNyYy5uZXQvDQoNCllvdSBjYW4gYWxzbyBnZXQg
aXQgaGVyZToNCmh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11LmdpdCB2aXJ0LWNw
dWhwLWFybXY4L3JmYy12Ng0KDQoNCkFncmVlZC4gaXRzIHdvcnRoIHNlZWluZyB3aXRob3V0IHRo
ZSBwYXRjaGVzIGFwcGxpZWQuIEknbGwgc2hhcmUgd2l0aCB5b3UgdGhlDQpyZXN1bHQgc2hvcnRs
eS4NCg0KDQpUaGFua3MNClNhbGlsLg0KDQo+IA0KPiBJJ20gZ3Vlc3NpbmcgZnJvbSB0aGF0ICJk
aXNhYmxlZGNwdXM9MiIgcGFydCB0aGF0IHlvdSdyZSBydW5uaW5nIHNvbWUgbm90LQ0KPiB5ZXQt
dXBzdHJlYW0gc2V0IG9mIFFFTVUgcGF0Y2hlcy4gUGxlYXNlIGRyb3AgdGhvc2UsIGFuZCB0ZXN0
IG9ubHkgd2l0aA0KPiB0aGlzLCB0byBydWxlIG91dCB0aGUgcG9zc2liaWxpdHkgb2Ygc29tZSBi
dWcvdW5leHBlY3RlZCBpbnRlcmFjdGlvbiB3aXRoDQo+IHRob3NlLg0KPiANCj4gdGhhbmtzDQo+
IC0tIFBNTQ0K

