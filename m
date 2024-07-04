Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F351BC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLBJ-00049r-3m; Thu, 04 Jul 2024 08:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sPLBG-00048p-L8; Thu, 04 Jul 2024 08:03:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sPLBE-00018J-6X; Thu, 04 Jul 2024 08:03:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFFdF18hGz6JB6Z;
 Thu,  4 Jul 2024 20:02:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 6D0121400D4;
 Thu,  4 Jul 2024 20:03:06 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 13:03:06 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Thu, 4 Jul 2024 13:03:06 +0100
To: Nicholas Piggin <npiggin@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
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
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V3 08/29] arm/virt: Init PMU at host for all possible
 vcpus
Thread-Topic: [PATCH RFC V3 08/29] arm/virt: Init PMU at host for all possible
 vcpus
Thread-Index: AQHavesi86fgew/iIE+bf2vMiBRCyLHl8hsAgACi3XA=
Date: Thu, 4 Jul 2024 12:03:05 +0000
Message-ID: <570b94603f414a3da01cb49a23a001a8@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-9-salil.mehta@huawei.com>
 <D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com>
In-Reply-To: <D2GF9A9AJO02.1G1G8UEXA5AOD@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.88]
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

SEkgTmljaywNCg0KPiAgRnJvbTogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT4N
Cj4gIFNlbnQ6IFRodXJzZGF5LCBKdWx5IDQsIDIwMjQgNDowOCBBTQ0KPiAgVG86IFNhbGlsIE1l
aHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiAg
cWVtdS1hcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gIA0KPiAgT24gRnJpIEp1biAx
NCwgMjAyNCBhdCA5OjM2IEFNIEFFU1QsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPiBQTVUgZm9y
IGFsbCBwb3NzaWJsZSB2Q1BVcyBtdXN0IGJlIGluaXRpYWxpemVkIGF0IHRoZSBWTSBpbml0aWFs
aXphdGlvbiB0aW1lLg0KPiAgPiBSZWZhY3RvciBleGlzdGluZyBjb2RlIHRvIGFjY29tb2RhdGUg
cG9zc2libGUgdkNQVXMuIFRoaXMgYWxzbyBhc3N1bWVzDQo+ICA+IHRoYXQgYWxsIHByb2Nlc3Nv
ciBiZWluZyB1c2VkIGFyZSBpZGVudGljYWwuDQo+ICA+DQo+ICA+IFBhc3QgZGlzY3Vzc2lvbiBm
b3IgcmVmZXJlbmNlOg0KPiAgPiBMaW5rOg0KPiAgPiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMC0wNi9tc2cwMDEzMS5odG1sDQo+ICANCj4gIEkgZ3Vl
c3MgaXQncyBzb21ldGhpbmcgZm9yIHRoZSBBUk0gcGVvcGxlLCBidXQgdGhlcmUncyBhIGxvdCBv
ZiBpbmZvcm1hdGlvbiBpbg0KPiAgdGhlcmUsIGNvdWxkIGl0IGJlIHVzZWZ1bCB0byBzdW1tYXJp
c2UgaW1wb3J0YW50IHBhcnRzIGhlcmUsIGUuZy4sIGZyb20NCj4gIEFuZHJldzoNCj4gIA0KPiAg
IEtWTSByZXF1aXJlcyBhbGwgVkNQVXMgdG8gaGF2ZSBhIFBNVSBpZiBvbmUgZG9lcy4gSWYgdGhl
IEFSTSBBUk0gIHNheXMNCj4gIGl0J3MgcG9zc2libGUgdG8gaGF2ZSBQTVVzIGZvciBvbmx5IHNv
bWUgQ1BVcywgdGhlbiwgZm9yIFRDRywgIHRoZQ0KPiAgcmVzdHJpY3Rpb24gY291bGQgYmUgcmVs
YXhlZC4NCj4gIA0KPiAgKEkgYXNzdW1lIGhlIG1lYW50IEFSTSBhcmNoKQ0KDQoNCkkgcmV0YWlu
ZWQgdGhlIGxpbmsganVzdCBmb3IgYSByZWZlcmVuY2UuIFJpZ2h0IG5vdyBpdCBpcyBhbiBhc3N1
bXB0aW9uIHRoYXQNCmFsbCB2Q1BVcyBoYXZlIHNpbWlsYXIgZmVhdHVyZXMuIFRoaXMgaXMgcmVm
bGVjdGVkIGluIEtWTSBhcyB3ZWxsLiANCihNYXliZSB0aGlzIG1pZ2h0IG5vdCBiZSB0aGUgY2Fz
ZSBpbiBmdXR1cmUgZXZlbnR1YWxseSB3aXRoIHRoZSBhZHZlbnQgb2YNCmhldGVyb2dlbm91cyBj
b21wdXRpbmcuIExpbmFybyBoYWQgc29tZXRoaW5nIGdvaW5nIGluIHRoYXQgZGlyZWN0aW9uPyAN
CkZvciBub3csIGl0IGxvb2tzIHRvIGJlIGEgZmFyLWZldGNoZWQgaWRlYSkuIA0KDQpJIGNhbiBk
ZWZpbml0ZWx5IHN1bW1hcml6ZSB3aGF0IHdhcyBkaXNjdXNzZWQgZWFybGllci4NCg0KDQo+ICA+
IENvLWRldmVsb3BlZC1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+
ICA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0K
PiAgPiBDby1kZXZlbG9wZWQtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4N
Cj4gID4gU2lnbmVkLW9mZi1ieTogS2VxaWFuIFpodSA8emh1a2VxaWFuMUBodWF3ZWkuY29tPg0K
PiAgPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4N
Cj4gID4gLS0tDQo+ICA+ICBody9hcm0vdmlydC5jICAgICAgICAgfCAxMiArKysrKysrKy0tLS0N
Cj4gID4gIGluY2x1ZGUvaHcvYXJtL3ZpcnQuaCB8ICAxICsNCj4gID4gIDIgZmlsZXMgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiAgPg0KPiAgPiBkaWZmIC0tZ2l0
IGEvaHcvYXJtL3ZpcnQuYyBiL2h3L2FybS92aXJ0LmMgaW5kZXgNCj4gID4gYWM1M2JmYWRjYS4u
NTdlYzQyOTAyMiAxMDA2NDQNCj4gID4gLS0tIGEvaHcvYXJtL3ZpcnQuYw0KPiAgPiArKysgYi9o
dy9hcm0vdmlydC5jDQo+ICA+IEBAIC0yMDQ1LDEyICsyMDQ1LDE0IEBAIHN0YXRpYyB2b2lkDQo+
ICBmaW5hbGl6ZV9naWNfdmVyc2lvbihWaXJ0TWFjaGluZVN0YXRlICp2bXMpDQo+ICA+ICAgKi8N
Cj4gID4gIHN0YXRpYyB2b2lkIHZpcnRfY3B1X3Bvc3RfaW5pdChWaXJ0TWFjaGluZVN0YXRlICp2
bXMsIE1lbW9yeVJlZ2lvbg0KPiAgPiAqc3lzbWVtKSAgew0KPiAgPiArICAgIENQVUFyY2hJZExp
c3QgKnBvc3NpYmxlX2NwdXMgPSB2bXMtPnBhcmVudC5wb3NzaWJsZV9jcHVzOw0KPiAgPiAgICAg
IGludCBtYXhfY3B1cyA9IE1BQ0hJTkUodm1zKS0+c21wLm1heF9jcHVzOw0KPiAgPiAtICAgIGJv
b2wgYWFyY2g2NCwgcG11LCBzdGVhbF90aW1lOw0KPiAgPiArICAgIGJvb2wgYWFyY2g2NCwgc3Rl
YWxfdGltZTsNCj4gID4gICAgICBDUFVTdGF0ZSAqY3B1Ow0KPiAgPiArICAgIGludCBuOw0KPiAg
Pg0KPiAgPiAgICAgIGFhcmNoNjQgPSBvYmplY3RfcHJvcGVydHlfZ2V0X2Jvb2woT0JKRUNUKGZp
cnN0X2NwdSksICJhYXJjaDY0IiwgTlVMTCk7DQo+ICA+IC0gICAgcG11ID0gb2JqZWN0X3Byb3Bl
cnR5X2dldF9ib29sKE9CSkVDVChmaXJzdF9jcHUpLCAicG11IiwgTlVMTCk7DQo+ICA+ICsgICAg
dm1zLT5wbXUgPSBvYmplY3RfcHJvcGVydHlfZ2V0X2Jvb2woT0JKRUNUKGZpcnN0X2NwdSksICJw
bXUiLA0KPiAgPiArIE5VTEwpOw0KPiAgPiAgICAgIHN0ZWFsX3RpbWUgPSBvYmplY3RfcHJvcGVy
dHlfZ2V0X2Jvb2woT0JKRUNUKGZpcnN0X2NwdSksDQo+ICA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAia3ZtLXN0ZWFsLXRpbWUiLCBOVUxMKTsNCj4gID4NCj4g
ID4gQEAgLTIwNzcsOCArMjA3OSwxMCBAQCBzdGF0aWMgdm9pZCB2aXJ0X2NwdV9wb3N0X2luaXQo
VmlydE1hY2hpbmVTdGF0ZQ0KPiAgKnZtcywgTWVtb3J5UmVnaW9uICpzeXNtZW0pDQo+ICA+ICAg
ICAgICAgICAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oc3lzbWVtLCBwdnRpbWVfcmVn
X2Jhc2UsDQo+ICBwdnRpbWUpOw0KPiAgPiAgICAgICAgICB9DQo+ICA+DQo+ICA+IC0gICAgICAg
IENQVV9GT1JFQUNIKGNwdSkgew0KPiAgPiAtICAgICAgICAgICAgaWYgKHBtdSkgew0KPiAgPiAr
ICAgICAgICBmb3IgKG4gPSAwOyBuIDwgcG9zc2libGVfY3B1cy0+bGVuOyBuKyspIHsNCj4gID4g
KyAgICAgICAgICAgIGNwdSA9IHFlbXVfZ2V0X3Bvc3NpYmxlX2NwdShuKTsNCj4gID4gKw0KPiAg
DQo+ICBNYXliZSBhIENQVV9GT1JFQUNIX1BPU1NJQkxFKCk/DQoNCg0Kc3VyZS4NCg0KDQpUaGFu
ayB5b3UNClNhbGlsLg0KDQo+ICANCj4gIFRoYW5rcywNCj4gIE5pY2sNCj4gIA0KPiAgPiArICAg
ICAgICAgICAgaWYgKHZtcy0+cG11KSB7DQo+ICA+ICAgICAgICAgICAgICAgICAgYXNzZXJ0KGFy
bV9mZWF0dXJlKCZBUk1fQ1BVKGNwdSktPmVudiwNCj4gIEFSTV9GRUFUVVJFX1BNVSkpOw0KPiAg
PiAgICAgICAgICAgICAgICAgIGlmIChrdm1faXJxY2hpcF9pbl9rZXJuZWwoKSkgew0KPiAgPiAg
ICAgICAgICAgICAgICAgICAgICBrdm1fYXJtX3BtdV9zZXRfaXJxKEFSTV9DUFUoY3B1KSwNCj4g
ID4gVklSVFVBTF9QTVVfSVJRKTsgZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL3ZpcnQuaA0K
PiAgPiBiL2luY2x1ZGUvaHcvYXJtL3ZpcnQuaCBpbmRleCAzNmFjNWZmNGEyLi5kOGRjYzg5YTBk
IDEwMDY0NA0KPiAgPiAtLS0gYS9pbmNsdWRlL2h3L2FybS92aXJ0LmgNCj4gID4gKysrIGIvaW5j
bHVkZS9ody9hcm0vdmlydC5oDQo+ICA+IEBAIC0xNTUsNiArMTU1LDcgQEAgc3RydWN0IFZpcnRN
YWNoaW5lU3RhdGUgew0KPiAgPiAgICAgIGJvb2wgcmFzOw0KPiAgPiAgICAgIGJvb2wgbXRlOw0K
PiAgPiAgICAgIGJvb2wgZHRiX3JhbmRvbW5lc3M7DQo+ICA+ICsgICAgYm9vbCBwbXU7DQo+ICA+
ICAgICAgT25PZmZBdXRvIGFjcGk7DQo+ICA+ICAgICAgVmlydEdJQ1R5cGUgZ2ljX3ZlcnNpb247
DQo+ICA+ICAgICAgVmlydElPTU1VVHlwZSBpb21tdTsNCg0K

