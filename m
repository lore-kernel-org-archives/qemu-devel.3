Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EBCC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s90ZQ-0007n2-3y; Mon, 20 May 2024 06:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s90ZH-0007jm-QT; Mon, 20 May 2024 06:48:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s90ZD-0002dB-Qs; Mon, 20 May 2024 06:48:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VjZ2W3cj5z6J9xb;
 Mon, 20 May 2024 18:44:51 +0800 (CST)
Received: from lhrpeml100006.china.huawei.com (unknown [7.191.160.224])
 by mail.maildlp.com (Postfix) with ESMTPS id CC4EE140CB9;
 Mon, 20 May 2024 18:48:24 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 11:48:24 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 20 May 2024 11:48:24 +0100
To: Nicholas Piggin <npiggin@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
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
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, Linuxarm
 <linuxarm@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shaoqin Huang <shahuang@redhat.com>
Subject: RE: [PATCH V9 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Topic: [PATCH V9 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Index: AQHaqjCk+Krm+sEOpEGrtSE0xbsEKbGfs2mAgAA2vKA=
Date: Mon, 20 May 2024 10:48:24 +0000
Message-ID: <68a66945081c444789c0381da0920b6d@huawei.com>
References: <20240519210620.228342-1-salil.mehta@huawei.com>
 <20240519210620.228342-2-salil.mehta@huawei.com>
 <D1EBDKJQ19G2.7K7FS8Z9BA5D@gmail.com>
In-Reply-To: <D1EBDKJQ19G2.7K7FS8Z9BA5D@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgTmljaywNCg0KPiAgRnJvbTogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT4N
Cj4gIFNlbnQ6IE1vbmRheSwgTWF5IDIwLCAyMDI0IDk6MDQgQU0NCj4gIFRvOiBTYWxpbCBNZWh0
YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gIHFl
bXUtYXJtQG5vbmdudS5vcmcNCj4gIA0KPiAgT24gTW9uIE1heSAyMCwgMjAyNCBhdCA3OjA2IEFN
IEFFU1QsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPiBLVk0gdkNQVSBjcmVhdGlvbiBpcyBkb25l
IG9uY2UgZHVyaW5nIHRoZSB2Q1BVIHJlYWxpemF0aW9uIHdoZW4gUWVtdQ0KPiAgPiB2Q1BVIHRo
cmVhZCBpcyBzcGF3bmVkLiBUaGlzIGlzIGNvbW1vbiB0byBhbGwgdGhlIGFyY2hpdGVjdHVyZXMg
YXMgb2Ygbm93Lg0KPiAgPg0KPiAgPiBIb3QtdW5wbHVnIG9mIHZDUFUgcmVzdWx0cyBpbiBkZXN0
cnVjdGlvbiBvZiB0aGUgdkNQVSBvYmplY3QgaW4gUU9NDQo+ICA+IGJ1dCB0aGUgY29ycmVzcG9u
ZGluZyBLVk0gdkNQVSBvYmplY3QgaW4gdGhlIEhvc3QgS1ZNIGlzIG5vdCBkZXN0cm95ZWQNCj4g
ID4gYXMgS1ZNIGRvZXNuJ3Qgc3VwcG9ydCB2Q1BVIHJlbW92YWwuIFRoZXJlZm9yZSwgaXRzIHJl
cHJlc2VudGF0aXZlIEtWTQ0KPiAgPiB2Q1BVIG9iamVjdC9jb250ZXh0IGluIFFlbXUgaXMgcGFy
a2VkLg0KPiAgPg0KPiAgPiBSZWZhY3RvciBhcmNoaXRlY3R1cmUgY29tbW9uIGxvZ2ljIHNvIHRo
YXQgc29tZSBBUElzIGNvdWxkIGJlIHJldXNlZA0KPiAgPiBieSB2Q1BVIEhvdHBsdWcgY29kZSBv
ZiBzb21lIGFyY2hpdGVjdHVyZXMgbGlrZXMgQVJNLCBMb29uZ3NvbiBldGMuDQo+ICA+IFVwZGF0
ZSBuZXcvb2xkIEFQSXMgd2l0aCB0cmFjZSBldmVudHMgaW5zdGVhZCBvZiBEUFJJTlRGLiBObyBm
dW5jdGlvbmFsDQo+ICBjaGFuZ2UgaXMgaW50ZW5kZWQgaGVyZS4NCj4gIA0KPiAgVGhpcyBpcyBh
IG5pY2UgY2xlYW51cCBhbmQgaGVscHMgd2l0aCBwcGMgaG90cGx1ZyBhcyB3ZWxsLg0KDQoNClRo
YW5rcyBhbmQgZ2xhZCB0aGF0IGl0IGlzIG9mIGhlbHAuDQoNCg0KPiAgDQo+ICBIYXMgdGhlcmUg
YmVlbiBhbnkgYXJjaGl0ZWN0dXJlIGNvZGUgcG9zdGVkIHlldD8NCg0KDQpZZXMsIEkgY3JlYXRl
ZCBvbmUgaW4gIEFwcmlsL2Vhcmx5IE1heS4gIEl0IGNvbnRhaW5zIGFyY2ggc3BlY2lmaWMgcGF0
Y2gtc2V0IHN0YWNrZWQgdXANCm9uIHRoZSBhcmNoIGFnbm9zdGljIHBhdGNoLXNldCBWOC4gQXJj
aCBzcGVjaWZpYyBwYXRjaC1zZXQgY29udGFpbnMgcGF0Y2hlcyBmcm9tIHRoZQ0KUkZDIFYyIEkg
ZmxvYXRlZCBsYXN0IHllYXIuIA0KDQpodHRwczovL2dpdGh1Yi5jb20vc2FsaWwtbWVodGEvcWVt
dS9jb21taXRzL3ZpcnQtY3B1aHAtYXJtdjgvcmZjLXYzLXJjMS8NCg0KDQpBcyBzdWNoLCBhIGNv
bXBsZXRlIGNvZGUgb2YgUkZDIFYyIHdhcyBwb3N0ZWQgbGFzdCB5ZWFyLiBUaGVyZSBpcyBubyBj
bGVhciBzZXBhcmF0aW9uIG9mDQphcmNoaXRlY3R1cmUgYWdub3N0aWMgYW5kIHNwZWNpZmljIHBh
dGNoLXNldCBpbiB0aGlzIHZlcnNpb24uIGFuZCBjYW4gYmUgZm91bmQgYXQgYmVsb3cNCnJlcG9z
aXRvcnkuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyMzA5MjYxMDA0
MzYuMjgyODQtMS1zYWxpbC5tZWh0YUBodWF3ZWkuY29tLw0KDQoNCkkgc2hhbGwgYmUgZmxvYXRp
bmcgUkZDIFYzIHNvb24gd2hpY2ggd2lsbCBoYXZlIG9ubHkgQVJNIGFyY2hpdGVjdHVyZSBzcGVj
aWZpYyBwYXJ0IGFuZA0KeWVzIHdpbGwgYWxzbyBoYXZlIFRDRyBjb2RlIGJ1dCB0aGVyZSBhcmUg
c29tZSBpc3N1ZXMgdG8gYmUgZml4ZWQgZm9yIFRDRyBhbmQgd2UgYXJlDQp3b3JraW5nIHRvd2Fy
ZHMgaXQuIEhlbmNlLCB3ZSBoYXZlIGRpc2FibGVkIFRDRyBieSBkZWZhdWx0IGZvciBub3cuDQoN
Cg0KVGhhbmtzDQpTYWxpbC4NCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KPiAgDQo+ICBKdXN0
IGEgZmV3IG1pbm9yIHRoaW5nOg0KPiAgDQo+ICA+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IFNhbGls
IE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgPiBSZXZpZXdlZC1ieTogR2F2aW4g
U2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gID4gVGVzdGVkLWJ5OiBWaXNobnUgUGFqanVyaSA8
dmlzaG51QG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+ICA+IFJldmlld2VkLWJ5OiBKb25hdGhh
biBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+ICA+IFRlc3RlZC1ieTog
WGlhbmdsYWkgTGkgPGxpeGlhbmdsYWlAbG9vbmdzb24uY24+DQo+ICA+IFRlc3RlZC1ieTogTWln
dWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+ICA+IFJldmlld2VkLWJ5OiBTaGFv
cWluIEh1YW5nIDxzaGFodWFuZ0ByZWRoYXQuY29tPg0KPiAgPiBSZXZpZXdlZC1ieTogVmlzaG51
IFBhamp1cmkgPHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPiAgPiAtLS0NCj4gID4g
IGFjY2VsL2t2bS9rdm0tYWxsLmMgICAgfCA2NCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLQ0KPiAgLS0tLQ0KPiAgPiAgYWNjZWwva3ZtL2t2bS1jcHVzLmggICB8IDE0ICsr
KysrKysrKw0KPiAgPiAgYWNjZWwva3ZtL3RyYWNlLWV2ZW50cyB8ICA1ICsrKy0NCj4gID4gIDMg
ZmlsZXMgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ICA+DQo+
ICA+IGRpZmYgLS1naXQgYS9hY2NlbC9rdm0va3ZtLWFsbC5jIGIvYWNjZWwva3ZtL2t2bS1hbGwu
YyBpbmRleA0KPiAgPiBjMGJlOWY1ZWVkLi45Y2Q3ZDY5YmRlIDEwMDY0NA0KPiAgPiAtLS0gYS9h
Y2NlbC9rdm0va3ZtLWFsbC5jDQo+ICA+ICsrKyBiL2FjY2VsL2t2bS9rdm0tYWxsLmMNCj4gID4g
QEAgLTEyOCw2ICsxMjgsNyBAQCBzdGF0aWMgUWVtdU11dGV4IGttbF9zbG90c19sb2NrOyAgI2Rl
ZmluZQ0KPiAgPiBrdm1fc2xvdHNfdW5sb2NrKCkgIHFlbXVfbXV0ZXhfdW5sb2NrKCZrbWxfc2xv
dHNfbG9jaykNCj4gID4NCj4gID4gIHN0YXRpYyB2b2lkIGt2bV9zbG90X2luaXRfZGlydHlfYml0
bWFwKEtWTVNsb3QgKm1lbSk7DQo+ICA+ICtzdGF0aWMgaW50IGt2bV9nZXRfdmNwdShLVk1TdGF0
ZSAqcywgdW5zaWduZWQgbG9uZyB2Y3B1X2lkKTsNCj4gID4NCj4gID4gIHN0YXRpYyBpbmxpbmUg
dm9pZCBrdm1fcmVzYW1wbGVfZmRfcmVtb3ZlKGludCBnc2kpICB7IEBAIC0zNDAsMTQNCj4gID4g
KzM0MSw1MyBAQCBlcnI6DQo+ICA+ICAgICAgcmV0dXJuIHJldDsNCj4gID4gIH0NCj4gID4NCj4g
ID4gK3ZvaWQga3ZtX3BhcmtfdmNwdShDUFVTdGF0ZSAqY3B1KQ0KPiAgPiArew0KPiAgPiArICAg
IHN0cnVjdCBLVk1QYXJrZWRWY3B1ICp2Y3B1Ow0KPiAgPiArDQo+ICA+ICsgICAgdHJhY2Vfa3Zt
X3BhcmtfdmNwdShjcHUtPmNwdV9pbmRleCwga3ZtX2FyY2hfdmNwdV9pZChjcHUpKTsNCj4gID4g
Kw0KPiAgPiArICAgIHZjcHUgPSBnX21hbGxvYzAoc2l6ZW9mKCp2Y3B1KSk7DQo+ICA+ICsgICAg
dmNwdS0+dmNwdV9pZCA9IGt2bV9hcmNoX3ZjcHVfaWQoY3B1KTsNCj4gID4gKyAgICB2Y3B1LT5r
dm1fZmQgPSBjcHUtPmt2bV9mZDsNCj4gID4gKyAgICBRTElTVF9JTlNFUlRfSEVBRCgma3ZtX3N0
YXRlLT5rdm1fcGFya2VkX3ZjcHVzLCB2Y3B1LCBub2RlKTsgfQ0KPiAgDQo+ICBDb3VsZCB5b3Ug
bW92ZSBrdm1fZ2V0X3ZjcHUgdXAgaGVyZSBzbyBpdCdzIG5leHQgdG8ga3ZtX3BhcmtfdmNwdSwg
YW5kDQo+ICB0aGVuIHlvdSBkb24ndCBuZWVkIHRvIGZvcndhcmQgZGVjbGFyZSBpdC4gQ2FsbCBp
dCBrdm1fdW5wYXJrX3ZjcHUoKSBmb3INCj4gIHN5bW1ldHJ5IHdpdGggcGFyay4NCj4gIA0KPiAg
VGhhbmtzLA0KPiAgTmljaw0K

