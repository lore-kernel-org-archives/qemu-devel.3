Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97306C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xse-0002Tv-R4; Fri, 03 May 2024 14:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s2xsc-0002Th-UK; Fri, 03 May 2024 14:43:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s2xsZ-0005Gp-VN; Fri, 03 May 2024 14:43:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VWKPQ06Phz67D3k;
 Sat,  4 May 2024 02:40:42 +0800 (CST)
Received: from lhrpeml100001.china.huawei.com (unknown [7.191.160.183])
 by mail.maildlp.com (Postfix) with ESMTPS id 4BD441400CB;
 Sat,  4 May 2024 02:43:28 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 May 2024 19:43:27 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Fri, 3 May 2024 19:43:27 +0100
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, "qemu-devel@nongnu.org"
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
 Linuxarm <linuxarm@huawei.com>, Vaibhav Jain <vaibhav@linux.ibm.com>,
 "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>
Subject: RE: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
Thread-Topic: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
Thread-Index: AQHafDEqI0IXEZOVrEKJZ0IqBhm6urGGEBHA
Date: Fri, 3 May 2024 18:43:27 +0000
Message-ID: <ab66fa4ded96458cac2df04f44d53e14@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-2-salil.mehta@huawei.com>
 <ca178aae-82b9-4150-9965-50d968787d23@linux.ibm.com>
In-Reply-To: <ca178aae-82b9-4150-9965-50d968787d23@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.152.25]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

SGkgSGFyc2gsDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkgaW4gbXkgcmVwbHkuIEkndmUgYmVlbiBv
ZmYgdGhlIGdyaWQgZm9yIHNvbWUgdGltZSBzbyBtaXNzZWQgdGhpcw0KZWFybGllciBtYWlsLiBQ
bGVhc2UgZmluZCBteSByZXBseSBiZWxvdyB0byB5b3UgcXVlcnkuDQoNClRoYW5rcw0KDQo+ICBG
cm9tOiBIYXJzaCBQcmF0ZWVrIEJvcmEgPGhhcnNocGJAbGludXguaWJtLmNvbT4NCj4gIFNlbnQ6
IEZyaWRheSwgTWFyY2ggMjIsIDIwMjQgODoxNSBBTQ0KPiAgDQo+ICArIFZhaWJoYXYsIFNoaXZh
DQo+ICANCj4gIEhpIFNhbGlsLA0KPiAgDQo+ICBJIGNhbWUgYWNyb3NzIHlvdXIgcGF0Y2ggd2hp
bGUgdHJ5aW5nIHRvIHNvbHZlIGEgcmVsYXRlZCBwcm9ibGVtIG9uIHNwYXByLg0KPiAgT25lIHF1
ZXJ5IGJlbG93IC4uDQo+ICANCj4gIE9uIDMvMTIvMjQgMDc6MjksIFNhbGlsIE1laHRhIHZpYSB3
cm90ZToNCj4gID4gS1ZNIHZDUFUgY3JlYXRpb24gaXMgZG9uZSBvbmNlIGR1cmluZyB0aGUgdkNQ
VSByZWFsaXphdGlvbiB3aGVuIFFlbXUNCj4gID4gdkNQVSB0aHJlYWQgaXMgc3Bhd25lZC4gVGhp
cyBpcyBjb21tb24gdG8gYWxsIHRoZSBhcmNoaXRlY3R1cmVzIGFzIG9mIG5vdy4NCj4gID4NCj4g
ID4gSG90LXVucGx1ZyBvZiB2Q1BVIHJlc3VsdHMgaW4gZGVzdHJ1Y3Rpb24gb2YgdGhlIHZDUFUg
b2JqZWN0IGluIFFPTQ0KPiAgPiBidXQgdGhlIGNvcnJlc3BvbmRpbmcgS1ZNIHZDUFUgb2JqZWN0
IGluIHRoZSBIb3N0IEtWTSBpcyBub3QgZGVzdHJveWVkDQo+ICA+IGFzIEtWTSBkb2Vzbid0IHN1
cHBvcnQgdkNQVSByZW1vdmFsLiBUaGVyZWZvcmUsIGl0cyByZXByZXNlbnRhdGl2ZSBLVk0NCj4g
ID4gdkNQVSBvYmplY3QvY29udGV4dCBpbiBRZW11IGlzIHBhcmtlZC4NCj4gID4NCj4gID4gUmVm
YWN0b3IgYXJjaGl0ZWN0dXJlIGNvbW1vbiBsb2dpYyBzbyB0aGF0IHNvbWUgQVBJcyBjb3VsZCBi
ZSByZXVzZWQNCj4gID4gYnkgdkNQVSBIb3RwbHVnIGNvZGUgb2Ygc29tZSBhcmNoaXRlY3R1cmVz
IGxpa2VzIEFSTSwgTG9vbmdzb24gZXRjLg0KPiAgPiBVcGRhdGUgbmV3L29sZCBBUElzIHdpdGgg
dHJhY2UgZXZlbnRzIGluc3RlYWQgb2YgRFBSSU5URi4gTm8gZnVuY3Rpb25hbA0KPiAgY2hhbmdl
IGlzIGludGVuZGVkIGhlcmUuDQo+ICA+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgPiBSZXZpZXdlZC1ieTogR2F2aW4gU2hhbiA8
Z3NoYW5AcmVkaGF0LmNvbT4NCj4gID4gVGVzdGVkLWJ5OiBWaXNobnUgUGFqanVyaSA8dmlzaG51
QG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+ICA+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1l
cm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+ICA+IFRlc3RlZC1ieTogWGlhbmds
YWkgTGkgPGxpeGlhbmdsYWlAbG9vbmdzb24uY24+DQo+ICA+IFRlc3RlZC1ieTogTWlndWVsIEx1
aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+ICA+IFJldmlld2VkLWJ5OiBTaGFvcWluIEh1
YW5nIDxzaGFodWFuZ0ByZWRoYXQuY29tPg0KPiAgPiAtLS0NCj4gID4gICBhY2NlbC9rdm0va3Zt
LWFsbC5jICAgIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4g
IC0tLS0NCj4gID4gICBhY2NlbC9rdm0vdHJhY2UtZXZlbnRzIHwgIDUgKysrLQ0KPiAgPiAgIGlu
Y2x1ZGUvc3lzZW11L2t2bS5oICAgfCAxNiArKysrKysrKysrKw0KPiAgPiAgIDMgZmlsZXMgY2hh
bmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ICA+DQo+ICA+IGRpZmYg
LS1naXQgYS9hY2NlbC9rdm0va3ZtLWFsbC5jIGIvYWNjZWwva3ZtL2t2bS1hbGwuYyBpbmRleA0K
PiAgPiBhOGNlY2QwNDBlLi4zYmMzMjA3YmRhIDEwMDY0NA0KPiAgPiAtLS0gYS9hY2NlbC9rdm0v
a3ZtLWFsbC5jDQo+ICA+ICsrKyBiL2FjY2VsL2t2bS9rdm0tYWxsLmMNCj4gID4gQEAgLTEyNiw2
ICsxMjYsNyBAQCBzdGF0aWMgUWVtdU11dGV4IGttbF9zbG90c19sb2NrOw0KPiAgPiAgICNkZWZp
bmUga3ZtX3Nsb3RzX3VubG9jaygpICBxZW11X211dGV4X3VubG9jaygma21sX3Nsb3RzX2xvY2sp
DQo+ICA+DQo+ICA+ICAgc3RhdGljIHZvaWQga3ZtX3Nsb3RfaW5pdF9kaXJ0eV9iaXRtYXAoS1ZN
U2xvdCAqbWVtKTsNCj4gID4gK3N0YXRpYyBpbnQga3ZtX2dldF92Y3B1KEtWTVN0YXRlICpzLCB1
bnNpZ25lZCBsb25nIHZjcHVfaWQpOw0KPiAgPg0KPiAgPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBr
dm1fcmVzYW1wbGVfZmRfcmVtb3ZlKGludCBnc2kpDQo+ICA+ICAgew0KPiAgPiBAQCAtMzE0LDE0
ICszMTUsNTMgQEAgZXJyOg0KPiAgPiAgICAgICByZXR1cm4gcmV0Ow0KPiAgPiAgIH0NCj4gID4N
Cj4gID4gK3ZvaWQga3ZtX3BhcmtfdmNwdShDUFVTdGF0ZSAqY3B1KQ0KPiAgPiArew0KPiAgPiAr
ICAgIHN0cnVjdCBLVk1QYXJrZWRWY3B1ICp2Y3B1Ow0KPiAgPiArDQo+ICA+ICsgICAgdHJhY2Vf
a3ZtX3BhcmtfdmNwdShjcHUtPmNwdV9pbmRleCwga3ZtX2FyY2hfdmNwdV9pZChjcHUpKTsNCj4g
ID4gKw0KPiAgPiArICAgIHZjcHUgPSBnX21hbGxvYzAoc2l6ZW9mKCp2Y3B1KSk7DQo+ICA+ICsg
ICAgdmNwdS0+dmNwdV9pZCA9IGt2bV9hcmNoX3ZjcHVfaWQoY3B1KTsNCj4gID4gKyAgICB2Y3B1
LT5rdm1fZmQgPSBjcHUtPmt2bV9mZDsNCj4gID4gKyAgICBRTElTVF9JTlNFUlRfSEVBRCgma3Zt
X3N0YXRlLT5rdm1fcGFya2VkX3ZjcHVzLCB2Y3B1LCBub2RlKTsgfQ0KPiAgPiArDQo+ICA+ICtp
bnQga3ZtX2NyZWF0ZV92Y3B1KENQVVN0YXRlICpjcHUpDQo+ICA+ICt7DQo+ICA+ICsgICAgdW5z
aWduZWQgbG9uZyB2Y3B1X2lkID0ga3ZtX2FyY2hfdmNwdV9pZChjcHUpOw0KPiAgPiArICAgIEtW
TVN0YXRlICpzID0ga3ZtX3N0YXRlOw0KPiAgPiArICAgIGludCBrdm1fZmQ7DQo+ICA+ICsNCj4g
ID4gKyAgICB0cmFjZV9rdm1fY3JlYXRlX3ZjcHUoY3B1LT5jcHVfaW5kZXgsIGt2bV9hcmNoX3Zj
cHVfaWQoY3B1KSk7DQo+ICA+ICsNCj4gID4gKyAgICAvKiBjaGVjayBpZiB0aGUgS1ZNIHZDUFUg
YWxyZWFkeSBleGlzdCBidXQgaXMgcGFya2VkICovDQo+ICA+ICsgICAga3ZtX2ZkID0ga3ZtX2dl
dF92Y3B1KHMsIHZjcHVfaWQpOw0KPiAgPiArICAgIGlmIChrdm1fZmQgPCAwKSB7DQo+ICA+ICsg
ICAgICAgIC8qIHZDUFUgbm90IHBhcmtlZDogY3JlYXRlIGEgbmV3IEtWTSB2Q1BVICovDQo+ICA+
ICsgICAgICAgIGt2bV9mZCA9IGt2bV92bV9pb2N0bChzLCBLVk1fQ1JFQVRFX1ZDUFUsIHZjcHVf
aWQpOw0KPiAgPiArICAgICAgICBpZiAoa3ZtX2ZkIDwgMCkgew0KPiAgPiArICAgICAgICAgICAg
ZXJyb3JfcmVwb3J0KCJLVk1fQ1JFQVRFX1ZDUFUgSU9DVEwgZmFpbGVkIGZvciB2Q1BVICVsdSIs
DQo+ICB2Y3B1X2lkKTsNCj4gID4gKyAgICAgICAgICAgIHJldHVybiBrdm1fZmQ7DQo+ICA+ICsg
ICAgICAgIH0NCj4gID4gKyAgICB9DQo+ICA+ICsNCj4gID4gKyAgICBjcHUtPmt2bV9mZCA9IGt2
bV9mZDsNCj4gID4gKyAgICBjcHUtPmt2bV9zdGF0ZSA9IHM7DQo+ICA+ICsgICAgY3B1LT52Y3B1
X2RpcnR5ID0gdHJ1ZTsNCj4gID4gKyAgICBjcHUtPmRpcnR5X3BhZ2VzID0gMDsNCj4gID4gKyAg
ICBjcHUtPnRocm90dGxlX3VzX3Blcl9mdWxsID0gMDsNCj4gID4gKw0KPiAgPiArICAgIHJldHVy
biAwOw0KPiAgPiArfQ0KPiAgPiArDQo+ICA+ICAgc3RhdGljIGludCBkb19rdm1fZGVzdHJveV92
Y3B1KENQVVN0YXRlICpjcHUpDQo+ICA+ICAgew0KPiAgPiAgICAgICBLVk1TdGF0ZSAqcyA9IGt2
bV9zdGF0ZTsNCj4gID4gICAgICAgbG9uZyBtbWFwX3NpemU7DQo+ICA+IC0gICAgc3RydWN0IEtW
TVBhcmtlZFZjcHUgKnZjcHUgPSBOVUxMOw0KPiAgPiAgICAgICBpbnQgcmV0ID0gMDsNCj4gID4N
Cj4gID4gLSAgICB0cmFjZV9rdm1fZGVzdHJveV92Y3B1KCk7DQo+ICA+ICsgICAgdHJhY2Vfa3Zt
X2Rlc3Ryb3lfdmNwdShjcHUtPmNwdV9pbmRleCwga3ZtX2FyY2hfdmNwdV9pZChjcHUpKTsNCj4g
ID4NCj4gID4gICAgICAgcmV0ID0ga3ZtX2FyY2hfZGVzdHJveV92Y3B1KGNwdSk7DQo+ICA+ICAg
ICAgIGlmIChyZXQgPCAwKSB7DQo+ICA+IEBAIC0zNDcsMTAgKzM4Nyw3IEBAIHN0YXRpYyBpbnQg
ZG9fa3ZtX2Rlc3Ryb3lfdmNwdShDUFVTdGF0ZSAqY3B1KQ0KPiAgPiAgICAgICAgICAgfQ0KPiAg
PiAgICAgICB9DQo+ICA+DQo+ICA+IC0gICAgdmNwdSA9IGdfbWFsbG9jMChzaXplb2YoKnZjcHUp
KTsNCj4gID4gLSAgICB2Y3B1LT52Y3B1X2lkID0ga3ZtX2FyY2hfdmNwdV9pZChjcHUpOw0KPiAg
PiAtICAgIHZjcHUtPmt2bV9mZCA9IGNwdS0+a3ZtX2ZkOw0KPiAgPiAtICAgIFFMSVNUX0lOU0VS
VF9IRUFEKCZrdm1fc3RhdGUtPmt2bV9wYXJrZWRfdmNwdXMsIHZjcHUsIG5vZGUpOw0KPiAgPiAr
ICAgIGt2bV9wYXJrX3ZjcHUoY3B1KTsNCj4gID4gICBlcnI6DQo+ICA+ICAgICAgIHJldHVybiBy
ZXQ7DQo+ICA+ICAgfQ0KPiAgPiBAQCAtMzcxLDYgKzQwOCw4IEBAIHN0YXRpYyBpbnQga3ZtX2dl
dF92Y3B1KEtWTVN0YXRlICpzLCB1bnNpZ25lZA0KPiAgbG9uZyB2Y3B1X2lkKQ0KPiAgPiAgICAg
ICAgICAgaWYgKGNwdS0+dmNwdV9pZCA9PSB2Y3B1X2lkKSB7DQo+ICA+ICAgICAgICAgICAgICAg
aW50IGt2bV9mZDsNCj4gID4NCj4gID4gKyAgICAgICAgICAgIHRyYWNlX2t2bV9nZXRfdmNwdSh2
Y3B1X2lkKTsNCj4gID4gKw0KPiAgPiAgICAgICAgICAgICAgIFFMSVNUX1JFTU9WRShjcHUsIG5v
ZGUpOw0KPiAgPiAgICAgICAgICAgICAgIGt2bV9mZCA9IGNwdS0+a3ZtX2ZkOw0KPiAgPiAgICAg
ICAgICAgICAgIGdfZnJlZShjcHUpOw0KPiAgPiBAQCAtMzc4LDcgKzQxNyw3IEBAIHN0YXRpYyBp
bnQga3ZtX2dldF92Y3B1KEtWTVN0YXRlICpzLCB1bnNpZ25lZA0KPiAgbG9uZyB2Y3B1X2lkKQ0K
PiAgPiAgICAgICAgICAgfQ0KPiAgPiAgICAgICB9DQo+ICA+DQo+ICA+IC0gICAgcmV0dXJuIGt2
bV92bV9pb2N0bChzLCBLVk1fQ1JFQVRFX1ZDUFUsICh2b2lkICopdmNwdV9pZCk7DQo+ICA+ICsg
ICAgcmV0dXJuIC1FTk9FTlQ7DQo+ICA+ICAgfQ0KPiAgPg0KPiAgPiAgIGludCBrdm1faW5pdF92
Y3B1KENQVVN0YXRlICpjcHUsIEVycm9yICoqZXJycCkgQEAgLTM4OSwxOSArNDI4LDE0IEBADQo+
ICA+IGludCBrdm1faW5pdF92Y3B1KENQVVN0YXRlICpjcHUsIEVycm9yICoqZXJycCkNCj4gID4N
Cj4gID4gICAgICAgdHJhY2Vfa3ZtX2luaXRfdmNwdShjcHUtPmNwdV9pbmRleCwga3ZtX2FyY2hf
dmNwdV9pZChjcHUpKTsNCj4gID4NCj4gID4gLSAgICByZXQgPSBrdm1fZ2V0X3ZjcHUocywga3Zt
X2FyY2hfdmNwdV9pZChjcHUpKTsNCj4gID4gKyAgICByZXQgPSBrdm1fY3JlYXRlX3ZjcHUoY3B1
KTsNCj4gID4gICAgICAgaWYgKHJldCA8IDApIHsNCj4gID4gLSAgICAgICAgZXJyb3Jfc2V0Z19l
cnJubyhlcnJwLCAtcmV0LCAia3ZtX2luaXRfdmNwdToga3ZtX2dldF92Y3B1IGZhaWxlZA0KPiAg
KCVsdSkiLA0KPiAgPiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsDQo+ICA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgImt2bV9pbml0X3ZjcHU6IGt2bV9jcmVhdGVfdmNw
dSBmYWlsZWQNCj4gID4gKyAoJWx1KSIsDQo+ICA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGt2bV9hcmNoX3ZjcHVfaWQoY3B1KSk7DQo+ICANCj4gIElmIGEgdmNwdSBob3RwbHVnIGZhaWxz
IGR1ZSB0byBmYWlsdXJlIHdpdGgga3ZtX2NyZWF0ZV92Y3B1IGlvY3RsLCBjdXJyZW50DQo+ICBi
ZWhhdmlvdXIgd291bGQgYmUgdG8gYnJpbmcgZG93biB0aGUgZ3Vlc3QgYXMgZXJycCBpcyAmZXJy
b3JfZmF0YWwuIEFueQ0KPiAgdGhvdWdodHMgb24gaG93IGRvIHdlIGVuc3VyZSB0aGF0IGEgZmFp
bHVyZSB3aXRoIGt2bV9jcmVhdGVfdmNwdSBpb2N0bCBmb3INCj4gIGhvdHBsdWdnZWQgY3B1cyAo
b25seSkgZG9lc250IGJyaW5nIGRvd24gdGhlIGd1ZXN0IGFuZCBmYWlsIGdyYWNlZnVsbHkgKGJ5
DQo+ICByZXBvcnRpbmcgZXJyb3IgdG8gdXNlciBvbiBtb25pdG9yPyk/DQoNCkluIHRoZSBBUk0s
IHdlIGFyZSBieSBkZXNpZ24gcHJlLWNyZWF0aW5nIGFsbCB0aGUgdkNQVXMgaW4gdGhlIEtWTSBk
dXJpbmcgdGhlDQpRZW11L0tWTSBJbml0LiBUaGlzIGlzIHRvIHNhdGlzZnkgdGhlIGNvbnN0cmFp
bnRzIHBvc2VkIGJ5IEFSTSBhcmNoaXRlY3R1cmUNCmFzIHdlIGFyZSBub3QgYWxsb3dlZCB0byBt
ZWRkbGUgd2l0aCBhbnkgaW5pdGlhbGl6YXRpb24gYXQgS1ZNIGxldmVsIG9yIEd1ZXN0DQprZXJu
ZWwgbGV2ZWwgYWZ0ZXIgc3lzdGVtIGhhcyBib290ZWQuIFRoZSBjb25zdHJhaW50cyBhcmUgbWFp
bmx5IGNvbWluZyBmcm9tDQpHSUMgYW5kIHJlbGF0ZWQgcGVyLUNQVSBmZWF0dXJlcyB3aGljaCBj
YW4gb25seSBiZSBpbml0aWFsaXplZCBvbmNlIGR1cmluZyBpbml0DQppbiB0aGUgS1ZNIGFuZCB0
aGVuIHRoZWlyIHByZXNlbmNlIGlzIG1hZGUgdG8gZmVsdCB0byB0aGUgR3Vlc3Qga2VybmVsIG9u
bHkNCm9uY2UgZHVyaW5nIGVudW1lcmF0aW9uIG9mIHRoZSBDUFVzIGFuZCByZWxhdGVkIEdJQyBD
UFUgaW50ZXJmYWNlcy4gTGF0ZXINCmNhbm5vdCBiZSBjaGFuZ2VkIGVpdGhlci4gSGVuY2UsIGlm
IGFsbCBvZiB0aGUgS1ZNIHZDUFVzIGhhdmUgYmVlbiBjcmVhdGVkDQpzdWNjZXNzZnVsbHkgZHVy
aW5nIGluaXQgdGhlbiBob3QodW4pcGx1Z2dpbmcgb3BlcmF0aW9ucyBsYXRlciB3b24ndCBoYXZl
DQpmYXRhbCBpbml0aWFsaXphdGlvbiBlcnJvcnMgYXQgdGhlIEtWTSBhcyBhbGwgb3BlcmF0aW9u
IGdldCBoYW5kbGVkIGF0IFFPTQ0KbGV2ZWwgb25seSBmb3IgdGhlIGhvdCh1bilwbHVnZ2VkIHZD
UFVzLg0KDQpJIGZlZWwgaWYgdGhlcmUgaXMgYSBmYWlsdXJlIHRvIGNyZWF0ZSBLVk0gdkNQVSBh
dCBRZW11IEtWTSBJbml0IHRpbWUgdGhlbg0KdGhlcmUgaXMgc29tZXRoaW5nIHNldmVyYWxseSB3
cm9uZyBlaXRoZXIgd2l0aCB0aGUgaW5wdXRzIG9yIHRoZSBzeXN0ZW0uDQpIZW5jZSwgdG8ga2Vl
cCB0aGUgaGFuZGxpbmcgc2ltcGxlIEkgd2FzIGluIGZhdm9yIG9mIGFib3J0aW5nIHRoZSBpbml0
aWFsaXphdGlvbi4NCg0KDQpCdXQgYWxsIG9mIGFib3ZlIGlzIEFSTSBhcmNoIHNwZWNpZmljLiBE
byB5b3UgaGF2ZSBhbnl0aGluZyBzcGVjaWZpYyBpbiBtaW5kDQp3aHkgeW91IG5lZWQgZ3JhY2Vm
dWwgaGFuZGxpbmcgYXQgdGhlIGluaXQgdGltZT8NCg0KVGhhbmtzDQpTYWxpbC4NCg0KPiAgDQo+
ICByZWdhcmRzLA0KPiAgSGFyc2gNCj4gID4gICAgICAgICAgIGdvdG8gZXJyOw0KPiAgPiAgICAg
ICB9DQo+ICA+DQo=

