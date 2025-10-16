Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFC6CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QEA-0004qb-EM; Thu, 16 Oct 2025 11:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v9QE8-0004qS-KG
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:49:16 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v9QDw-0007go-U4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:49:16 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cnXNl2FhHz6L4wq;
 Thu, 16 Oct 2025 23:45:59 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (unknown [7.214.147.1])
 by mail.maildlp.com (Postfix) with ESMTPS id 1F3EA140371;
 Thu, 16 Oct 2025 23:48:55 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml500004.china.huawei.com (7.214.147.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 16:48:54 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Thu, 16 Oct 2025 16:48:54 +0100
To: Peter Maydell <peter.maydell@linaro.org>, Salil Mehta
 <salil.mehta@opnsrc.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Marc Zyngier
 <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTC/hsAgAAPY4CAAYSEoIAAGSoAgAAtHICAAAULAIAAETbQ
Date: Thu, 16 Oct 2025 15:48:54 +0000
Message-ID: <3f92615acd9b46ef89386340400c45da@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <d6f9dfa368b2419998379ac9dd986a7b@huawei.com>
 <CAFEAcA8U_3zJsnHt2wxME3j8J83whzTNgP9vEvUGuWHe7KGaYA@mail.gmail.com>
 <e2b03da8f7514b57aef7d236be1dcb90@huawei.com>
 <CAFEAcA_KcvBOOc4nY6VMziSuh=YrcgbaNZhi3+M_kM01v97WtQ@mail.gmail.com>
 <CAJ7pxeaCeSPAzjqnhVG6VkQyX3Vx82yvb-ex1ya+j7pFjFOekg@mail.gmail.com>
 <CAFEAcA-22x0rFK+Wqwc_MfaLpmP521PYO_sPJ3dtNTvmJ6vMVw@mail.gmail.com>
In-Reply-To: <CAFEAcA-22x0rFK+Wqwc_MfaLpmP521PYO_sPJ3dtNTvmJ6vMVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.67.10]
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
IFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1IDQ6NDYgUE0NCj4gVG86IFNhbGlsIE1laHRhIDxz
YWxpbC5tZWh0YUBvcG5zcmMubmV0Pg0KPiANCj4gT24gVGh1LCAxNiBPY3QgMjAyNSBhdCAxNjoy
OCwgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQG9wbnNyYy5uZXQ+IHdyb3RlOg0KPiA+DQo+ID4g
SGkgUGV0ZXIsDQo+ID4NCj4gPiBPbiBUaHUsIE9jdCAxNiwgMjAyNSBhdCAxMjo0NuKAr1BNIFBl
dGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gT24gVGh1LCAxNiBPY3QgMjAyNSBhdCAxMjoxMywgU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBQZXRlciwNCj4g
PiA+ID4gPiA+IEFib3ZlIGNoYW5nZXMgYXNzdW1lIHRoYXQgdGhlIGRyaXZlcidzIGNvbmZpZ3Vy
ZWQgdmFsdWUgb2YgdGhlDQo+ID4gPiA+ID4gPiBJQ0NfQ1RMUl9FTDEgc3lzdGVtIHJlZ2lzdGVy
IGlzIHRoZSBzYW1lIGFzIHRoZSBkZWZhdWx0IHZhbHVlLg0KPiA+ID4gPiA+ID4gSSd2ZSB2ZXJp
ZmllZCB0aGF0IHRoaXMgY3VycmVudGx5IHRoZSBjYXNlLiBIb3dldmVyLCBpdCBzYWZlDQo+ID4g
PiA+ID4gPiB0byBhc3N1bWUgdGhhdCB0aGlzIHdpbGwgcmVtYWluIHRydWUgaW4gdGhlIGZ1dHVy
ZSBhcyB3ZWxsPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQg
eW91IG1lYW4gaGVyZS4gV2UgcmVhZCB0aGUga2VybmVsJ3MNCj4gPiA+ID4gPiBJQ0NfQ1RMUl9F
TDEgYXQgVk0gc3RhcnR1cCwgd2hlbiB3ZSBrbm93IGl0IHdpbGwgYmUgdGhlIHJlc2V0DQo+ID4g
PiA+ID4gdmFsdWUsIGJlY2F1c2Ugd2UgaGF2ZW4ndCBydW4gYW55IFZDUFVzIHlldC4NCj4gPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gU3lzdGVtIHJlZ2lzdGVyIGZldGNoZXMgaXRzIHZhbHVlIGZy
b20gSUNIX1ZNQ1JfRUwyIGFuZA0KPiBJQ0hfVlRSX0VMMi4NCj4gPiA+ID4gSW4gc3BlY2lmaWMs
IEVPSU1vZGUsIFBNSEUgYW5kIENCUFIgZmllbGRzIG9mIElDQ19DVExSX0VMMSBhcmUNCj4gPiA+
ID4gZnJvbSB0aGUgVk1DUiByZWdpc3Rlci4gTGF0ZXIgZ2V0cyBjb25maWd1cmVkIHdoZW4gZHJp
dmVyIGdldHMNCj4gPiA+ID4gbG9hZGVkIGFuZCBhZ2FpbiByZS1jb25maWd1cmVkIGluIGNvbnRl
eHQgdG8gZWFjaCBDUFUgT04NCj4gPiA+ID4gcmVxdWVzdCh2aWEgaW4ta2VybmVsICBDUFUgSG90
cGx1ZyBzdGF0ZSBtYWNoaW5lOw0KPiA+ID4gPiBDUFVIUF9BUF9JUlFfR0lDX1NUQVJUSU5HKS4g
VGhpcyBjb25maWd1cmVzIHRoZSBWTUNSIGFnYWluIGFuZA0KPiBhZ2Fpbi4gQWx0aG91Z2gsIHRo
ZSB2YWx1ZSBhcyBvZiBub3cgaXMgc2FtZS4NCj4gPiA+ID4NCj4gPiA+ID4gWW91IG1pZ2h0IHdh
bnQgdG8gY2hlY2sgZ2ljX2NwdV9zeXNfcmVnX2luaXQoKSBpbiBpcnEtZ2ljLXYzLmMNCj4gPiA+
DQo+ID4gPiBJJ20gYWZyYWlkIEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFu
IGhlcmUuIFRoaXMgaXMgYWxsDQo+ID4gPiB0aGUgZ3Vlc3Qgd3JpdGluZyB0byB0aGUgR0lDIHJl
Z2lzdGVycyBhcyBpdCBzdGFydHMgdXAsIHJpZ2h0Pw0KPiA+ID4gVGhhdCBoYXMgbm8gaW5mbHVl
bmNlIGF0IGFsbCBvbiB3aGF0IHRoZSByZXNldCB2YWx1ZSBvZiB0aGUgZW11bGF0ZWQNCj4gPiA+
IGhhcmR3YXJlIHNob3VsZCBiZS4gKFRoaXMgaXMgdGhlIHNhbWUgYXMgb24gcmVhbCBoYXJkd2Fy
ZToNCj4gPiA+IGl0IGRvZXNuJ3QgbWF0dGVyIHdoYXQgdGhlIE9TIHdyaXRlcyB0byByZWdpc3Rl
cnMgd2hlbiBpdCBpcw0KPiA+ID4gcnVubmluZzsgd2hlbiB0aGUgaGFyZHdhcmUgcmVzZXRzIGl0
IHJlc2V0cyB0byB0aGUgcmVzZXQgdmFsdWUuKQ0KPiA+DQo+ID4gRm9yIGNvbnRleHQsIHRoZSBn
aWNfY3B1X2luaXQoKSBmdW5jdGlvbiBpcyBpbnZva2VkIGZyb20gdHdvIHBhdGhzIGluDQo+ID4g
dGhlIGtlcm5lbDogZmlyc3QgZnJvbSBnaWNfaW5pdF9iYXNlcygpIHdoZW4gdGhlIEdJQ3YzIGRy
aXZlciBpcw0KPiA+IGluaXRpYWxseSBsb2FkZWQgb24gdGhlIGJvb3QgQ1BVLCBhbmQgbGF0ZXIg
ZnJvbSBnaWNfc3RhcnRpbmdfY3B1KCkNCj4gPiBkdXJpbmcgZWFjaCBDUFUgb25saW5lIHRyYW5z
aXRpb24gaW4gdGhlIGhvdHBsdWcgc3RhdGUgbWFjaGluZS4NCj4gPg0KPiA+IFRoZSBob3RwbHVn
IHBhdGggd2lyZXMgdXANCj4gPg0KPiA+IENQVUhQX0FQX0lSUV9HSUNfU1RBUlRJTkcgLT4gZ2lj
X3N0YXJ0aW5nX2NwdQ0KPiA+DQo+ID4gaW4gZ2ljX3NtcF9pbml0KCkuIE9uIGV2ZXJ5IENQVSBv
bmxpbmUgZXZlbnQgdGhpcyBsZWFkcyB0bzoNCj4gPg0KPiA+IGdpY19zdGFydGluZ19jcHUoKSAt
PiBnaWNfY3B1X2luaXQoKSAtPiBnaWNfY3B1X3N5c19yZWdfaW5pdCgpDQo+ID4NCj4gPiB3aGlj
aCByZXByb2dyYW1zIHRoZSBDUFUtaW50ZXJmYWNlIHN5c3RlbSByZWdpc3RlcnMgb24gdGhhdCBD
UFUsDQo+ID4gaW5jbHVkaW5nIElDQ19DVExSX0VMMSAoZmllbGRzIEVPSU1vZGUsIFBNSEUsIENC
UFIpLg0KPiA+DQo+ID4gVGhlIGZvbGxvd2luZyBkdW1wIHN0YWNrIGZyb20gYSBndWVzdCBob3Rw
bHVnIGV2ZW50IHNob3dzIHRoaXMNCj4gPiBzZXF1ZW5jZSBjbGVhcmx5Og0KPiA+DQo+ID4gZWNo
byAxID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MS9vbmxpbmUNCj4gPiBbICAgMzkuMjg3
NDAyXSBnaWNfY3B1X3N5c19yZWdfaW5pdCsweDRjLzB4Mjk0DQo+ID4gWyAgIDM5LjI4NzQwNl0g
Z2ljX2NwdV9pbml0LnBhcnQuMCsweGMwLzB4MTE0DQo+ID4gWyAgIDM5LjI4NzQwOV0gZ2ljX3N0
YXJ0aW5nX2NwdSsweDI0LzB4OGMNCj4gPiBbICAgMzkuMjg3NDEyXSBjcHVocF9pbnZva2VfY2Fs
bGJhY2srMHgxMDQvMHgyMGMNCj4gPiBbICAgMzkuMjg3NDE5XSBub3RpZnlfY3B1X3N0YXJ0aW5n
KzB4ODAvMHhhYw0KPiA+IFsgICAzOS4yODc0MjFdIHNlY29uZGFyeV9zdGFydF9rZXJuZWwrMHhk
Yy8weDE1Yw0KPiA+DQo+ID4NCj4gPiBBcyBhIHJlc3VsdCwgSUNDX0NUTFJfRUwxIGlzIGF0IGl0
cyBhcmNoaXRlY3R1cmFsIHJlc2V0IHZhbHVlIGF0IFZNDQo+ID4gcmVhbGl6ZSAoYmVmb3JlIGFu
eSB2Q1BVIHJ1bnMpLCBidXQgaXQgaXMgZ3Vlc3QtY29uZmlndXJlZCBhZnRlciB0aGUNCj4gPiBk
cml2ZXIgcnVucyBhbmQgYWdhaW4gb24gZWFjaCBsYXRlciBDUFUgb25saW5lIGV2ZW50Lg0KPiAN
Cj4gU28/IFdlIGRvIG5vdCBjYXJlIHdoYXQgdGhlIGd1ZXN0IGRvZXMgd2l0aCB0aGUgcmVnaXN0
ZXIuDQo+IFRoZSByZXNldCB2YWx1ZSBpcyB0aGUgdmFsdWUgaXQgaGFzICpiZWZvcmUqIHRoZSBn
dWVzdCB0b3VjaGVzIGl0Lg0KDQpTdXJlLiBnb3QgaXQuIHRoYW5rcyBmb3IgdGhlIGNsYXJpZmlj
YXRpb24uDQoNCg0KQmVzdCByZWdhcmRzDQpTYWxpbC4NCg0K

