Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6DCC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 11:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s91BK-00054U-8D; Mon, 20 May 2024 07:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s91BI-00054F-G2; Mon, 20 May 2024 07:27:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s91BB-0003K3-OK; Mon, 20 May 2024 07:27:52 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VjZz205J3z67G9M;
 Mon, 20 May 2024 19:26:54 +0800 (CST)
Received: from lhrpeml100005.china.huawei.com (unknown [7.191.160.25])
 by mail.maildlp.com (Postfix) with ESMTPS id DFBEF140B67;
 Mon, 20 May 2024 19:27:40 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 12:27:40 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 20 May 2024 12:27:40 +0100
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
Thread-Index: AQHaqjCk+Krm+sEOpEGrtSE0xbsEKbGfs2mAgABBGrA=
Date: Mon, 20 May 2024 11:27:40 +0000
Message-ID: <e02713782ae34f6caad43283b9608e5e@huawei.com>
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

PiAgRnJvbTogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT4NCj4gIFNlbnQ6IE1v
bmRheSwgTWF5IDIwLCAyMDI0IDk6MDQgQU0NCj4gIA0KPiAgT24gTW9uIE1heSAyMCwgMjAyNCBh
dCA3OjA2IEFNIEFFU1QsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPiBLVk0gdkNQVSBjcmVhdGlv
biBpcyBkb25lIG9uY2UgZHVyaW5nIHRoZSB2Q1BVIHJlYWxpemF0aW9uIHdoZW4gUWVtdQ0KPiAg
PiB2Q1BVIHRocmVhZCBpcyBzcGF3bmVkLiBUaGlzIGlzIGNvbW1vbiB0byBhbGwgdGhlIGFyY2hp
dGVjdHVyZXMgYXMgb2Ygbm93Lg0KPiAgPg0KPiAgPiBIb3QtdW5wbHVnIG9mIHZDUFUgcmVzdWx0
cyBpbiBkZXN0cnVjdGlvbiBvZiB0aGUgdkNQVSBvYmplY3QgaW4gUU9NDQo+ICA+IGJ1dCB0aGUg
Y29ycmVzcG9uZGluZyBLVk0gdkNQVSBvYmplY3QgaW4gdGhlIEhvc3QgS1ZNIGlzIG5vdCBkZXN0
cm95ZWQNCj4gID4gYXMgS1ZNIGRvZXNuJ3Qgc3VwcG9ydCB2Q1BVIHJlbW92YWwuIFRoZXJlZm9y
ZSwgaXRzIHJlcHJlc2VudGF0aXZlIEtWTQ0KPiAgPiB2Q1BVIG9iamVjdC9jb250ZXh0IGluIFFl
bXUgaXMgcGFya2VkLg0KPiAgPg0KPiAgPiBSZWZhY3RvciBhcmNoaXRlY3R1cmUgY29tbW9uIGxv
Z2ljIHNvIHRoYXQgc29tZSBBUElzIGNvdWxkIGJlIHJldXNlZA0KPiAgPiBieSB2Q1BVIEhvdHBs
dWcgY29kZSBvZiBzb21lIGFyY2hpdGVjdHVyZXMgbGlrZXMgQVJNLCBMb29uZ3NvbiBldGMuDQo+
ICA+IFVwZGF0ZSBuZXcvb2xkIEFQSXMgd2l0aCB0cmFjZSBldmVudHMgaW5zdGVhZCBvZiBEUFJJ
TlRGLiBObyBmdW5jdGlvbmFsDQo+ICBjaGFuZ2UgaXMgaW50ZW5kZWQgaGVyZS4NCj4gIA0KDQpb
Li4uXQ0KDQp2b2lkIGt2bV9wYXJrX3ZjcHUoQ1BVU3RhdGUgKmNwdSkNCj4gID4gK3sNCj4gID4g
KyAgICBzdHJ1Y3QgS1ZNUGFya2VkVmNwdSAqdmNwdTsNCj4gID4gKw0KPiAgPiArICAgIHRyYWNl
X2t2bV9wYXJrX3ZjcHUoY3B1LT5jcHVfaW5kZXgsIGt2bV9hcmNoX3ZjcHVfaWQoY3B1KSk7DQo+
ICA+ICsNCj4gID4gKyAgICB2Y3B1ID0gZ19tYWxsb2MwKHNpemVvZigqdmNwdSkpOw0KPiAgPiAr
ICAgIHZjcHUtPnZjcHVfaWQgPSBrdm1fYXJjaF92Y3B1X2lkKGNwdSk7DQo+ICA+ICsgICAgdmNw
dS0+a3ZtX2ZkID0gY3B1LT5rdm1fZmQ7DQo+ICA+ICsgICAgUUxJU1RfSU5TRVJUX0hFQUQoJmt2
bV9zdGF0ZS0+a3ZtX3BhcmtlZF92Y3B1cywgdmNwdSwgbm9kZSk7IH0NCj4gIA0KPiAgQ291bGQg
eW91IG1vdmUga3ZtX2dldF92Y3B1IHVwIGhlcmUgc28gaXQncyBuZXh0IHRvIGt2bV9wYXJrX3Zj
cHUsIGFuZA0KPiAgdGhlbiB5b3UgZG9uJ3QgbmVlZCB0byBmb3J3YXJkIGRlY2xhcmUgaXQuIENh
bGwgaXQga3ZtX3VucGFya192Y3B1KCkgZm9yDQo+ICBzeW1tZXRyeSB3aXRoIHBhcmsuDQoNCg0K
c29ycnkgSSBtaXNzZWQgdGhpcyBwYXJ0IGVhcmxpZXIgYW5kIFBoaWwgYWxzbyBzdWdnZXN0ZWQg
dGhlIHNhbWUuIFllcywgSSBjYW4uDQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0KPiAgDQo+ICBUaGFu
a3MsDQo+ICBOaWNrDQo=

