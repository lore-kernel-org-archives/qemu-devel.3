Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287F2C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HZg-0006Q3-Lk; Tue, 07 May 2024 05:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s4HZQ-0006Hm-97; Tue, 07 May 2024 05:57:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s4HZN-0007EK-6J; Tue, 07 May 2024 05:57:12 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VYYZg4mnGz67y8R;
 Tue,  7 May 2024 17:56:27 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (unknown [7.191.160.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 496181400CD;
 Tue,  7 May 2024 17:56:55 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 May 2024 10:56:54 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Tue, 7 May 2024 10:56:54 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V8 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Topic: [PATCH V8 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
Thread-Index: AQHadCFXcU6yTs2isEyCNhmIUrtCDrGHWFKAgALjoLD///qlAIAAEQrggAF59YCAABVhIA==
Date: Tue, 7 May 2024 09:56:54 +0000
Message-ID: <a308e1f4f06f4e3ab6ab51f353601f43@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-7-salil.mehta@huawei.com>
 <CAFEAcA93EotG4-LXRJF034_9dWAWgZJA1VF6dB-xCsXn0T059g@mail.gmail.com>
 <10f35804a55e460a8ce6ecdb3f0c79b6@huawei.com>
 <CAFEAcA-w7wf9F4VVAnZR3b34ydEWq=QNw=CxhTMobsr+AP_LCg@mail.gmail.com>
 <55f942d2a3644bdaaff759014e3a4c20@huawei.com>
 <CAFEAcA92nCPPk0Qa6XjRqRGTq_XDyRSVVaz67WgJBEZcxoEtOQ@mail.gmail.com>
In-Reply-To: <CAFEAcA92nCPPk0Qa6XjRqRGTq_XDyRSVVaz67WgJBEZcxoEtOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.236]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

SGkgUGV0ZXIsDQoNCj4gIEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4gIFNlbnQ6IFR1ZXNkYXksIE1heSA3LCAyMDI0IDEwOjAzIEFNDQo+ICANCj4gIE9u
IFR1ZSwgNyBNYXkgMjAyNCBhdCAwMToxMSwgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdl
aS5jb20+IHdyb3RlOg0KPiAgPg0KPiAgPiA+ICBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+DQo+ICA+ID4gIFNlbnQ6IE1vbmRheSwgTWF5IDYsIDIwMjQgMTA6
MjkgQU0NCj4gID4gPiAgVG86IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiAgPiA+DQo+ICA+ID4gIE9uIE1vbiwgNiBNYXkgMjAyNCBhdCAxMDowNiwgU2FsaWwgTWVodGEg
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+ID4gIHdyb3RlOg0KPiAgPiA+ICA+DQo+ICA+
ID4gID4gSGkgUGV0ZXIsDQo+ICA+ID4gID4NCj4gID4gPiAgPiBUaGFua3MgZm9yIHRoZSByZXZp
ZXcuDQo+ICA+ID4gID4NCj4gID4gPiAgPiA+ICBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+ICBXaGVuIGRvIHdlDQo+ICA+ID4gbmVlZCB0byAgPiA+IGRlc3Ry
b3kgYSBzaW5nbGUgYWRkcmVzcyBzcGFjZSBpbiB0aGlzIHdheSB0aGF0IG1lYW5zDQo+ICA+ID4g
d2UgbmVlZCB0byAgPiA+IGtlZXAgYSBjb3VudCBvZiBob3cgbWFueSBBU2VzIHRoZSBDUFUgY3Vy
cmVudGx5IGhhcz8NCj4gID4gPiBUaGUgIGNvbW1pdCAgPiA+IG1lc3NhZ2UgdGFsa3MgYWJvdXQg
dGhlIGNhc2Ugd2hlbiB3ZSB1bnJlYWxpemUgdGhlDQo+ICA+ID4gd2hvbGUgQ1BVICA+ID4gb2Jq
ZWN0LCBidXQgaW4gdGhhdCBzaXR1YXRpb24geW91IGNhbiBqdXN0IHRocm93IGF3YXkNCj4gID4g
PiBhbGwgdGhlIEFTZXMgID4gPiBhdCBvbmNlIChlZyAgYnkgY2FsbGluZyBzb21lICA+ID4NCj4g
ID4gPiBjcHVfZGVzdHJveV9hZGRyZXNzX3NwYWNlcygpIGZ1bmN0aW9uIGZyb20NCj4gID4gPiBj
cHVfY29tbW9uX3VucmVhbGl6ZWZuKCkpLg0KPiAgPiA+ICA+DQo+ICA+ID4gID4NCj4gID4gPiAg
PiBZZXMsIG1heWJlLCB3ZSBjYW4gZGVzdHJveSBhbGwgYXQgb25jZSBmcm9tIGNvbW1vbiBsZWcg
YXMgd2VsbC4NCj4gID4gPiBJJ2QgID4gcHJlZmVyIHRoaXMgdG8gYmUgZG9uZSBmcm9tIHRoZSBh
cmNoIHNwZWNpZmljIGZ1bmN0aW9uIGZvcg0KPiAgPiA+IEFSTSB0byAgPiBtYWludGFpbiB0aGUg
Y2xhcml0eSAmIHN5bW1ldHJ5IG9mIGluaXRpYWxpemF0aW9uIGFuZCAgPg0KPiAgPiA+IHVuLWlu
aXRpYWxpemF0aW9uIGxlZ3MuICBGb3Igbm93LCBhbGwgb2YgdGhlc2UgYWRkcmVzcyBzcGFjZQ0K
PiAgPiA+IGRlc3RydWN0aW9uIGlzICBoYXBwZW5pbmcgaW4gY29udGV4dCB0byB0aGUgYXJtX2Nw
dV91bnJlYWxpemVmbigpLg0KPiAgPiA+ICA+DQo+ICA+ID4gID4gSXTigJlzIGEga2luZCBvZiB0
cmFkZS1vZmYgYmV0d2VlbiBsaXR0bGUgbW9yZSBjb2RlIGFuZCBjbGFyaXR5IGJ1dA0KPiAgPiA+
IEknbSAgPiBvcGVuIHRvIGZ1cnRoZXIgc3VnZ2VzdGlvbnMuDQo+ICA+ID4gID4NCj4gID4gPiAg
Pg0KPiAgPiA+ICA+ID4NCj4gID4gPiAgPiA+ICBBbHNvLCBpZiB3ZSdyZSBsZWFraW5nIHN0dWZm
IGhlcmUgYnkgZmFpbGluZyB0byBkZXN0cm95IGl0LCBpcw0KPiAgPiA+IHRoYXQgID4gPiBhIHBy
b2JsZW0gZm9yICBleGlzdGluZyBDUFUgdHlwZXMgbGlrZSB4ODYgdGhhdCB3ZSBjYW4gYWxyZWFk
eSAgaG90cGx1Zz8NCj4gID4gPiAgPg0KPiAgPiA+ICA+IE5vIHdlIGFyZSBub3QuIFdlIGFyZSB0
YWtpbmcgY2FyZSBvZiB0aGVzZSBpbiB0aGUgQVJNIGFyY2gNCj4gID4gPiBzcGVjaWZpYyAgPiBs
ZWdzIHdpdGhpbiBmdW5jdGlvbnMgYXJtX2NwdV8odW4pcmVhbGl6ZWZuKCkuDQo+ICA+ID4NCj4g
ID4gPiAgSG93IGNhbiB5b3UgYmUgdGFraW5nIGNhcmUgb2YgKng4NiogQ1BVIHR5cGVzIGluIHRo
ZSBBcm0gdW5yZWFsaXplPw0KPiAgPg0KPiAgPg0KPiAgPiBTb3JyeSwgeWVzLCBJIG1pc3NlZCB0
byByZXBseSB0aGF0IGNsZWFybHkuIFRoZXJlIHdhcyBpbmRlZWQgYSBsZWFrDQo+ICA+IHdpdGgg
eDg2IHJlcG9ydGVkIGJ5IFBoaWxsaXBlL0RhdmlkIGxhc3QgeWVhci4gSW4gZmFjdCwgUGhpbGxp
cGUgZmxvYXRlZCBhDQo+ICBwYXRjaCBsYXN0IHllYXIgZm9yIHRoaXMuDQo+ICA+IEkgdGhvdWdo
dCBpdCB3YXMgZml4ZWQgYWxyZWFkeSBhcyBwYXJ0IG9mIGNwdV9jb21tb25fdW5yZWFsaXplKCkg
YnV0IEkNCj4gID4ganVzdCBjaGVja2VkIGFuZCByZWFsaXplZCB0aGF0IHRoZSBiZWxvdyBwcm9w
b3NlZCBjaGFuZ2VkIHN0aWxsIGlzbuKAmXQNCj4gID4gcGFydCBvZiB0aGUgbWFpbmxpbmUNCj4g
ID4NCj4gID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDkxODE2MDI1
Ny4zMDEyNy05LQ0KPiAgcGhpbG1kQGxpbmFyDQo+ICA+IG8ub3JnLw0KPiAgDQo+ICBUaGF0IHNl
ZW1zIGxpa2UgdGhlIHJpZ2h0IHdheSB0byBjbGVhbiB0aGVzZSB1cCAtLSBQaGlsaXBwZSwgZG8g
eW91IHdhbnQgdG8NCj4gIGZpc2ggdGhhdCBidWdmaXggb3V0IG9mIHlvdXIgYmlnIHBhdGNoc2V0
IGFuZCBzdWJtaXQgaXQgc2VwYXJhdGVseSA/DQo+ICANCj4gID4gSSBjYW4gZGVmaW5pdGVseSBh
ZGQgYSBjb21tb24gQ1BVIEFkZHJlc3NTcGFjZSBkZXN0cnVjdGlvbiBsZWcgYXMgcGFydA0KPiAg
PiBvZiB0aGlzIHBhdGNoIGlmIGluIGNhc2UgYXJjaCBzcGVjaWZpYyBDUFUgdW5yZWFsaXplIGRv
ZXMgbm90IGNsZWFucw0KPiAgPiB1cCBpdHMgQ1BVIEFkZHJlc3NTcGFjZT8NCj4gIA0KPiAgQXJj
aC1zcGVjaWZpYyBDUFUgdW5yZWFsaXplIHNob3VsZG4ndCBuZWVkIHRvIGRvIGFueXRoaW5nIC0t
IGlmIHdlIGZpeCB0aGlzDQo+ICBzaW1pbGFybHkgdG8gUGhpbGlwcGUncyBwYXRjaCBhYm92ZSB0
aGVuIHRoYXQgd2lsbCBkbyB0aGUgY2xlYW51cCByZXF1aXJlZC4NCj4gIEhhbmRsaW5nIHRoaXMg
a2luZCBvZiBjbGVhbnVwIGluIGNvbW1vbiBjb2RlIGlzIG1vcmUgcmVsaWFibGUgYmVjYXVzZSBp
dA0KPiAgZG9lc24ndCByZXF1aXJlIGV2ZXJ5IHRhcmdldC1hcmNoIG1haW50YWluZXIgdG8gcmVt
ZW1iZXIgaXQgbmVlZHMgdG8gYmUNCj4gIGRvbmUsIHBsdXMgaXQncyBsZXNzIGNvZGUuDQoNCg0K
QWdyZWVkIGJ1dCBJdCBpcyBhIHRyYWRlLW9mZiBiZXR3ZWVuICdsaW5lcyBvZiBjb2RlJyBhbmQg
J2NsYXJpdHkgb2YgdGhlIGNvZGUnLg0KSWRlYWxseSwgaWYgc29tZW9uZSBpcyBhZGRpbmcgYSBp
bml0aWFsaXphdGlvbiBwYXJ0IG9uZSBtdXN0IGNvbnNjaW91c2x5IHZlcmlmeQ0KdGhlIGxvY2F0
aW9ucyB3aGVyZSB0aGVzZSB3aWxsIGdldCBkZWFsbG9jYXRlZC9kZWluaXRlZCBhcyB3ZWxsIHNv
IEkgZG8gbm90DQp0aGluayB0aGVyZSBpcyBhbiBlc2NhcGUgZnJvbSB0aGF0IGtpbmQgb2YgbWFp
bnRlbmFuY2UgcGFydC4gDQoNCkZvciBhcmNoIGxpa2UgeDg2LCB3aGVyZSB3ZSBhcmUgZG9pbmcg
ZGVmYXVsdCBBZGRyZXNzU3BhY2UgYWxsb2NhdGlvbiBmcm9tDQpjb21tb24gcmVhbGl6ZSwgaXQg
aXMgbW9yZSBvYnZpb3VzIHRvIHN5bW1ldHJpY2FsbHkgZGVzdHJveSBmcm9tIGNvbW1vbg0KbGVn
IGJ1dCBmb3IgYW55IG90aGVyIGFyY2hpdGVjdHVyZSBpbmNsdWRpbmcgQVJNIHdoZXJlIG1hbnkg
dHlwZXMgb2YgQ1BVDQpBZGRyZXNzU3BhY2UgYXJlIGdldHRpbmcgYWxsb2NhdGVkIGl0IHdvdWxk
IG5vdCBiZSBvYnZpb3VzIHRvIGZpbmQgaXRzDQpkZXN0cnVjdGlvbiBsZWcgYnVyaWVkIHNvbWV3
aGVyZSBpbiB0aGUgY29tbW9uIGNvZGUuIA0KDQpIZW5jZSwgSSB3b3VsZCBzdWdnZXN0IHRvIG1h
a2UgcmVsZWFzZSBvZiB0aGUgQWRkcmVzc1NwYWNlIGZyb20gY29tbW9uDQp1bnJlYWxpemF0aW9u
IHBhcnQgb3B0aW9uYWwgd2hpY2ggYnkgZGVmYXVsdCBpdCBpcyBpbiB0aGUgY29kZSBleGNlcnB0
IGZyb20gdGhlDQpwYXRjaDoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8y
MDIzMDkxODE2MDI1Ny4zMDEyNy05LXBoaWxtZEBsaW5hcm8ub3JnLw0KDQorICAgIC8qIERlc3Ry
b3kgQ1BVIGFkZHJlc3Mgc3BhY2UgKi8NCisgICAgZm9yICh1bnNpZ25lZCBpZHggPSAwOyBpZHgg
PCBjcHUtPm51bV9hc2VzOyBpZHgrKykgew0KKyAgICAgICAgY3B1X2FkZHJlc3Nfc3BhY2VfZGVz
dHJveShjcHUsIGlkeCk7DQorICAgIH0NCg0KY3B1LT5udW1fYXNlcyB3aWxsIGJlIDAgaW4gY2Fz
ZSBBcmNoIHNwZWNpZmljIGNvZGUgaGFzIGFscmVhZHkgZGVzdHJveWVkIGl0Lg0KDQpUaGF0IHNh
aWQgd2Ugd2lsbCBzdGlsbCBuZWVkIHNvbWUgbW9kaWZpY2F0aW9uIGluIHRoZSBhZGRyZXNzIHNw
YWNlIGRlc3RydWN0aW9uDQpmdW5jdGlvbiB0byBncmFjZWZ1bGx5IHJldHVybiBpbiBjYXNlIHRo
YXQgQ1BVIEFkZHJlc3NTcGFjZSB3YXMgYWxyZWFkeQ0KZGVzdHJveWVkIG9yIGRvZXMgbm90IGV4
aXN0LiBUaGlzIHdpbGwga2VlcCBib3RoIG9wdGlvbnMgb3Blbi4NCg0KDQpUaGFua3MNClNhbGls
Lg0KDQo+ICANCj4gIHRoYW5rcw0KPiAgLS0gUE1NDQo=

