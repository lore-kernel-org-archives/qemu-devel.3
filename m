Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFFDCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kp3-0004LR-2u; Tue, 14 Oct 2025 15:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8kp0-0004LB-1l
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:36:34 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8kos-0001Fe-IL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:36:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmPX55sdYz6L4t4;
 Wed, 15 Oct 2025 03:33:25 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 68BBE140157;
 Wed, 15 Oct 2025 03:36:16 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 20:36:16 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 20:36:16 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q///z8ACAABG8wP//+S2AAAIw8TD///c1gP//7sZQgAAX3QD//+6K8IAAFxWA//+8etA=
Date: Tue, 14 Oct 2025 19:36:15 +0000
Message-ID: <bdc3791ac7004bb281447cb8b707995f@huawei.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgUGV0ZXIsDQoNCj4gRnJvbTogcWVtdS1kZXZlbC1ib3VuY2VzK3NhbGlsLm1laHRhPWh1YXdl
aS5jb21Abm9uZ251Lm9yZyA8cWVtdS0NCj4gZGV2ZWwtYm91bmNlcytzYWxpbC5tZWh0YT1odWF3
ZWkuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZiBQZXRlcg0KPiBNYXlkZWxsDQo+IFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMTQsIDIwMjUgNDo0NCBQTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNh
bGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IA0KPiBPbiBUdWUsIDE0IE9jdCAyMDI1IGF0IDE2OjMz
LCBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+
IEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gPiA+IFNl
bnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTQsIDIwMjUgNDoyNCBQTQ0KPiA+ID4gVG86IFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgMTQgT2N0
IDIwMjUgYXQgMTY6MTMsIFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiB3
cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+IEluIHdoYXQgc2l0dWF0aW9uDQo+ID4gPiA+ID4gZG8gd2UgZXZlciBz
dGFydCBydW5uaW5nIGEgVkNQVSBiZWZvcmUgdGhlICpHSUMqIGhhcyBiZWVuDQo+ID4gPiA+ID4g
cmVhbGl6ZWQ/IFRoZSBHSUMgc2hvdWxkIGdldCByZWFsaXplZCBhcyBwYXJ0IG9mIGNyZWF0aW5n
IHRoZQ0KPiA+ID4gPiA+IHZpcnQgYm9hcmQsIHdoaWNoIG11c3QgY29tcGxldGUgYmVmb3JlIHdl
IGRvIGFueXRoaW5nIGxpa2UgcnVubmluZyBhDQo+IHZjcHUuDQo+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+IEp1c3QgYWZ0ZXIgcmVhbGl6YXRpb24gb2YgdkNQVSBpbiB0aGUgbWFjaHZpcnRfaW5p
dCgpIHlvdSBjYW4gc2VlDQo+ID4gPiA+IHRoZSBkZWZhdWx0IHBvd2VyX3N0YXRlIGlzIFBTQ0kg
Q1BVX09OLCB3aGljaCBtZWFucw0KPiA+ID4gS1ZNX01QX1NUQVRFX1JVTk5BQkxFLg0KPiA+ID4g
PiBTaW5jZSwgdGhlIHRocmVhZCBpcyB1cCBhbmQgbm90IGRvaW5nIElPIHdhaXQgaW4gdXNlcnNw
YWNlIGl0IGdldHMNCj4gPiA+ID4gaW50bw0KPiA+ID4gPiBjcHVfZXhlYygpIGxvb3AgYW5kIGFj
dHVhbGx5IHJ1biBLVk1fUlVOIElPQ1RMLiBJbnNpZGUgdGhlIEtWTSBpdA0KPiA+ID4gPiBtb21l
bnRhcmlseSB0YWtlcyB0aGUgdkNQVSBtdXRleCBidXQgbGF0ZXIgZXhpdCBhbmQgcmVsZWFzZXMu
IFRoaXMNCj4gPiA+ID4ga2VlcHMgZ29pbmcgb24gZm9yIGFsbCBvZiB0aGUgdkNQVSB0aHJlYWRz
IHJlYWxpemVkIGVhcmx5Lg0KPiA+ID4NCj4gPiA+IFlpa2VzLiBXZSBkZWZpbml0ZWx5IHNob3Vs
ZCBmaXggdGhhdCA6IGxldHRpbmcgdGhlIHZjcHUgcnVuIGJlZm9yZQ0KPiA+ID4gd2UgZ2V0IHRv
DQo+ID4gPiBxZW11X21hY2hpbmVfY3JlYXRpb25fZG9uZSgpIHNlZW1zIGxpa2UgaXQgd291bGQg
YmUgYSBtYXNzaXZlIHNvdXJjZQ0KPiA+ID4gb2YgcmFjZSBjb25kaXRpb25zLg0KPiA+DQo+ID4g
SSd2ZSBhbHJlYWR5IHByb3Bvc2VkIGZpeCBmb3IgdGhpcyBieSBwYXJraW5nIHN1Y2ggdGhyZWFk
cyBpbg0KPiA+IHVzZXJzcGFjZS4gUGxlYXNlIGNoZWNrIGZ1bmN0aW9ucyB2aXJ0Xyh1bilwYXJr
X2NwdV9pbl91c2Vyc3BhY2UoKS4NCj4gPiBCdXQgbmVlZCB0byBjaGVjayBpZiB3ZSBjYW4gdXNl
IHRoaXMgdHJpY2sgY2FuIGJlIHVzZWQgYXQgdGhlIHZlcnkgZWFybHkNCj4gc3RhZ2VzIG9mIHRo
ZSBWTSBpbml0aWFsaXphdGlvbi4NCj4gDQo+IEkgaGFkIGEgbG9vayBhdCB0aGlzIG9uIHg4Niwg
YW5kIHdlIGNvcnJlY3RseSBkb24ndCB0cnkgdG8gS1ZNX1JVTiB0aGUgdmNwdXMNCj4gZWFybHku
IFdoYXQgaGFwcGVucyB0aGVyZSBpczoNCj4gICogdGhlIHZjcHUgdGhyZWFkIGNhbGxzIHFlbXVf
cHJvY2Vzc19jcHVfZXZlbnRzKCkNCg0KDQpJIGNhbm5vdCBmaW5kIHRoaXMgZnVuY3Rpb24gaW4g
dGhlIFFlbXUgbWFpbmxpbmUgb2YgMjh0aCBTZXB0ZW1iZXIgPw0KDQoNCj4gICogdGhpcyBjYXVz
ZXMgaXQgdG8gZ28gdG8gc2xlZXAgb24gdGhlIGNwdS0+aGFsdF9jb25kOiBzbw0KPiAgICBpdCB3
aWxsIG5vdCBlbmQgdXAgZG9pbmcgS1ZNX1JVTiB5ZXQNCj4gICogbGF0ZXIsIHRoZSBtYWluIHRo
cmVhZCBjb21wbGV0ZXMgaW5pdGlhbGl6YXRpb24gb2YgdGhlIGJvYXJkDQo+ICAqIHFkZXZfbWFj
aGluZV9jcmVhdGlvbl9kb25lKCkgY2FsbHMgY3B1X3N5bmNocm9uaXplX2FsbF9wb3N0X2luaXQo
KQ0KPiAgKiBmb3Iga3ZtLCB0aGlzIGNhdXNlcyB1cyB0byBjYWxsIGt2bV9jcHVfc3luY2hyb25p
emVfcG9zdF9pbml0KCkNCj4gICAgZm9yIGVhY2ggdmNwdQ0KPiAgKiB0aGF0IHdpbGwgY2FsbCBy
dW5fb25fY3B1KCkgd2hpY2ggZW5kcyB1cCBjYWxsaW5nIHFlbXVfY3B1X2tpY2soKQ0KPiAgKiBx
ZW11X2NwdV9raWNrKCkgZG9lcyBhIGJyb2FkY2FzdCBvbiBjcHUtPmhhbHRfY29uZCwgd2hpY2gN
Cj4gICAgd2FrZXMgdXAgdGhlIHZjcHUgdGhyZWFkIGFuZCBsZXRzIGl0IGdvIGludG8ga3ZtX2Nw
dV9leGVjKCkNCj4gICAgZm9yIHRoZSBmaXJzdCB0aW1lDQo+IA0KPiBXaHkgZG9lc24ndCB0aGlz
IG1lY2hhbmlzbSB3b3JrIG9uIEFybSA/DQoNCkl0IGlzIGEgY29tYmluYXRpb24gb2YgdGhpbmdz
Og0KDQp2b2lkIHFlbXVfd2FpdF9pb19ldmVudChDUFVTdGF0ZSAqY3B1KQ0Kew0KWy4uLl0NCiAg
ICB3aGlsZSAoY3B1X3RocmVhZF9pc19pZGxlKGNwdSkpIHsNCiAgICAgICAgIFsuLi5dDQogICAg
ICAgIHFlbXVfY29uZF93YWl0KGNwdS0+aGFsdF9jb25kLCAmYnFsKTsNCiAgICB9DQpbLi4uXQ0K
fQ0KDQoxLiBUbyBibG9jayB3ZSBzaG91bGQgd2FpdCBvbiAnaGFsdF9jb25kJyBhcyB5b3Ugcmln
aHRseSBwb2ludGVkLg0KMi4gYnV0IGNvbmRpdGlvbiB0byB3YWl0IGlzIHRvIGNoZWNrIG9mIHRo
ZSBDUFUgaXMgSURMRSBvciBub3QuDQozLiBWYXJpb3VzIGNvbmRpdGlvbnMgaW4gd2hpY2ggQ1BV
IGNhbiBiZSB0ZXJtZWQgSURMRSBhcmU6DQogICAgIDMuMSAgU1RPUFBFRA0KICAgICAzLjIgIEhB
TFRFRA0KICAgICAzLjMgSXQgZG9lcyBub3QgaGF2ZSBhbnkgcXVldWVkICB3b3JrIHRvIHByb2Nl
c3MuDQoNCg0KQmVjYXVzZSBDUFUgbmV2ZXIgcmFuIHdlIGNhbiBydWxlIG91dCAzLjEgJiAzLjIu
IElmIENQVSBpcyBpbg0KJ2hhbHRlZCcgY29uZGl0aW9uIGkuZS4gICdDUFVTdGF0ZTo6aGFsdGVk
PTEnIHRoZW4gd2UgY2FuIGFsc28gYXNzdW1lDQp0aHJlYWQgdG8gYmUgaW4gSURMRSBzdGF0ZS4g
T24gQVJNLCBkZWZhdWx0IHZhbHVlIG9mIHRoaXMgdmFyaWFibGUgaXMgMC4NClRoaXMgZ2V0IG9u
bHkgc2V0IGluIGNvbnRleHQgdG8gQ1BVIGNvbW1vbiByZXNldCB3aGVuIHRoZSBmaXJzdCB0aW1l
DQphbGwgQ1BVcyBhcmUgcmVzZXQgaW4gY29udGV4dCB0byB0aGUgc3lzdGVtIHJlc2V0Lg0KDQpz
dGF0aWMgdm9pZCBjcHVfY29tbW9uX3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0
eXBlKQ0Kew0KWy4uLl0NCiAgICBjcHUtPmhhbHRlZCA9IGNwdS0+c3RhcnRfcG93ZXJlZF9vZmY7
DQogICAgIFsuLi5dOw0KfQ0KDQoNCk1heWJlIHdlIGNhbiBmaXggdGhpcyBkZWZhdWx0IHZhbHVl
Pw0KDQoNCkJlc3QgcmVnYXJkcw0KU2FsaWwuDQoNCg0K

