Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6C1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2vHq-0007ni-Ve; Fri, 03 May 2024 11:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s2vHk-0007hs-OR; Fri, 03 May 2024 11:57:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s2vHg-00063S-Vw; Fri, 03 May 2024 11:57:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VWFjP3Ggyz6J9yc;
 Fri,  3 May 2024 23:54:17 +0800 (CST)
Received: from lhrpeml100004.china.huawei.com (unknown [7.191.162.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 6A681140B33;
 Fri,  3 May 2024 23:57:03 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 May 2024 16:57:03 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Fri, 3 May 2024 16:57:03 +0100
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
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
Subject: RE: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Topic: [PATCH V8 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Index: AQHadCEigDg8Rw6JCkW/vDs/2Ez4xbGFgsCAgAB5OpA=
Date: Fri, 3 May 2024 15:57:02 +0000
Message-ID: <ed20ba7ef8d949fea9b81ed194c59bf6@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-2-salil.mehta@huawei.com>
 <9747db79-4444-4d31-b014-8c368936cab4@linaro.org>
In-Reply-To: <9747db79-4444-4d31-b014-8c368936cab4@linaro.org>
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

SGkgUGhpbGlwcGUsDQoNCj4gIEZyb206IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
bGluYXJvLm9yZz4NCj4gIFNlbnQ6IEZyaWRheSwgTWF5IDMsIDIwMjQgMTA6NDAgQU0NCj4gIFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjggMS84XSBhY2NlbC9rdm06IEV4dHJhY3QgY29tbW9uIEtWTSB2
Q1BVDQo+ICB7Y3JlYXRpb24scGFya2luZ30gY29kZQ0KPiAgDQo+ICBIaSBTYWxpbCwNCj4gIA0K
PiAgT24gMTIvMy8yNCAwMjo1OSwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ICA+IEtWTSB2Q1BVIGNy
ZWF0aW9uIGlzIGRvbmUgb25jZSBkdXJpbmcgdGhlIHZDUFUgcmVhbGl6YXRpb24gd2hlbiBRZW11
DQo+ICA+IHZDUFUgdGhyZWFkIGlzIHNwYXduZWQuIFRoaXMgaXMgY29tbW9uIHRvIGFsbCB0aGUg
YXJjaGl0ZWN0dXJlcyBhcyBvZiBub3cuDQo+ICA+DQo+ICA+IEhvdC11bnBsdWcgb2YgdkNQVSBy
ZXN1bHRzIGluIGRlc3RydWN0aW9uIG9mIHRoZSB2Q1BVIG9iamVjdCBpbiBRT00NCj4gID4gYnV0
IHRoZSBjb3JyZXNwb25kaW5nIEtWTSB2Q1BVIG9iamVjdCBpbiB0aGUgSG9zdCBLVk0gaXMgbm90
IGRlc3Ryb3llZA0KPiAgPiBhcyBLVk0gZG9lc24ndCBzdXBwb3J0IHZDUFUgcmVtb3ZhbC4gVGhl
cmVmb3JlLCBpdHMgcmVwcmVzZW50YXRpdmUgS1ZNDQo+ICA+IHZDUFUgb2JqZWN0L2NvbnRleHQg
aW4gUWVtdSBpcyBwYXJrZWQuDQo+ICA+DQo+ICA+IFJlZmFjdG9yIGFyY2hpdGVjdHVyZSBjb21t
b24gbG9naWMgc28gdGhhdCBzb21lIEFQSXMgY291bGQgYmUgcmV1c2VkDQo+ICA+IGJ5IHZDUFUg
SG90cGx1ZyBjb2RlIG9mIHNvbWUgYXJjaGl0ZWN0dXJlcyBsaWtlcyBBUk0sIExvb25nc29uIGV0
Yy4NCj4gID4gVXBkYXRlIG5ldy9vbGQgQVBJcyB3aXRoIHRyYWNlIGV2ZW50cyBpbnN0ZWFkIG9m
IERQUklOVEYuIE5vIGZ1bmN0aW9uYWwNCj4gIGNoYW5nZSBpcyBpbnRlbmRlZCBoZXJlLg0KPiAg
Pg0KPiAgPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNv
bT4NCj4gID4gUmV2aWV3ZWQtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+ICA+
IFRlc3RlZC1ieTogVmlzaG51IFBhamp1cmkgPHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29t
Pg0KPiAgPiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBo
dWF3ZWkuY29tPg0KPiAgPiBUZXN0ZWQtYnk6IFhpYW5nbGFpIExpIDxsaXhpYW5nbGFpQGxvb25n
c29uLmNuPg0KPiAgPiBUZXN0ZWQtYnk6IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFjbGUu
Y29tPg0KPiAgPiBSZXZpZXdlZC1ieTogU2hhb3FpbiBIdWFuZyA8c2hhaHVhbmdAcmVkaGF0LmNv
bT4NCj4gID4gLS0tDQo+ICA+ICAgYWNjZWwva3ZtL2t2bS1hbGwuYyAgICB8IDY0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAtLS0tDQo+ICA+ICAgYWNjZWwva3Zt
L3RyYWNlLWV2ZW50cyB8ICA1ICsrKy0NCj4gID4gICBpbmNsdWRlL3N5c2VtdS9rdm0uaCAgIHwg
MTYgKysrKysrKysrKysNCj4gID4gICAzIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyks
IDE2IGRlbGV0aW9ucygtKQ0KPiAgPg0KPiAgPiBkaWZmIC0tZ2l0IGEvYWNjZWwva3ZtL2t2bS1h
bGwuYyBiL2FjY2VsL2t2bS9rdm0tYWxsLmMgaW5kZXgNCj4gID4gYThjZWNkMDQwZS4uM2JjMzIw
N2JkYSAxMDA2NDQNCj4gID4gLS0tIGEvYWNjZWwva3ZtL2t2bS1hbGwuYw0KPiAgPiArKysgYi9h
Y2NlbC9rdm0va3ZtLWFsbC5jDQo+ICA+IEBAIC0xMjYsNiArMTI2LDcgQEAgc3RhdGljIFFlbXVN
dXRleCBrbWxfc2xvdHNfbG9jazsNCj4gID4gICAjZGVmaW5lIGt2bV9zbG90c191bmxvY2soKSAg
cWVtdV9tdXRleF91bmxvY2soJmttbF9zbG90c19sb2NrKQ0KPiAgPg0KPiAgPiAgIHN0YXRpYyB2
b2lkIGt2bV9zbG90X2luaXRfZGlydHlfYml0bWFwKEtWTVNsb3QgKm1lbSk7DQo+ICA+ICtzdGF0
aWMgaW50IGt2bV9nZXRfdmNwdShLVk1TdGF0ZSAqcywgdW5zaWduZWQgbG9uZyB2Y3B1X2lkKTsN
Cj4gID4NCj4gID4gICBzdGF0aWMgaW5saW5lIHZvaWQga3ZtX3Jlc2FtcGxlX2ZkX3JlbW92ZShp
bnQgZ3NpKQ0KPiAgPiAgIHsNCj4gID4gQEAgLTMxNCwxNCArMzE1LDUzIEBAIGVycjoNCj4gID4g
ICAgICAgcmV0dXJuIHJldDsNCj4gID4gICB9DQo+ICA+DQo+ICA+ICt2b2lkIGt2bV9wYXJrX3Zj
cHUoQ1BVU3RhdGUgKmNwdSkNCj4gID4gK3sNCj4gID4gKyAgICBzdHJ1Y3QgS1ZNUGFya2VkVmNw
dSAqdmNwdTsNCj4gID4gKw0KPiAgPiArICAgIHRyYWNlX2t2bV9wYXJrX3ZjcHUoY3B1LT5jcHVf
aW5kZXgsIGt2bV9hcmNoX3ZjcHVfaWQoY3B1KSk7DQo+ICA+ICsNCj4gID4gKyAgICB2Y3B1ID0g
Z19tYWxsb2MwKHNpemVvZigqdmNwdSkpOw0KPiAgPiArICAgIHZjcHUtPnZjcHVfaWQgPSBrdm1f
YXJjaF92Y3B1X2lkKGNwdSk7DQo+ICA+ICsgICAgdmNwdS0+a3ZtX2ZkID0gY3B1LT5rdm1fZmQ7
DQo+ICA+ICsgICAgUUxJU1RfSU5TRVJUX0hFQUQoJmt2bV9zdGF0ZS0+a3ZtX3BhcmtlZF92Y3B1
cywgdmNwdSwgbm9kZSk7IH0NCj4gID4gKw0KPiAgPiAraW50IGt2bV9jcmVhdGVfdmNwdShDUFVT
dGF0ZSAqY3B1KQ0KPiAgPiArew0KPiAgPiArICAgIHVuc2lnbmVkIGxvbmcgdmNwdV9pZCA9IGt2
bV9hcmNoX3ZjcHVfaWQoY3B1KTsNCj4gID4gKyAgICBLVk1TdGF0ZSAqcyA9IGt2bV9zdGF0ZTsN
Cj4gID4gKyAgICBpbnQga3ZtX2ZkOw0KPiAgPiArDQo+ICA+ICsgICAgdHJhY2Vfa3ZtX2NyZWF0
ZV92Y3B1KGNwdS0+Y3B1X2luZGV4LCBrdm1fYXJjaF92Y3B1X2lkKGNwdSkpOw0KPiAgPiArDQo+
ICA+ICsgICAgLyogY2hlY2sgaWYgdGhlIEtWTSB2Q1BVIGFscmVhZHkgZXhpc3QgYnV0IGlzIHBh
cmtlZCAqLw0KPiAgPiArICAgIGt2bV9mZCA9IGt2bV9nZXRfdmNwdShzLCB2Y3B1X2lkKTsNCj4g
ID4gKyAgICBpZiAoa3ZtX2ZkIDwgMCkgew0KPiAgPiArICAgICAgICAvKiB2Q1BVIG5vdCBwYXJr
ZWQ6IGNyZWF0ZSBhIG5ldyBLVk0gdkNQVSAqLw0KPiAgPiArICAgICAgICBrdm1fZmQgPSBrdm1f
dm1faW9jdGwocywgS1ZNX0NSRUFURV9WQ1BVLCB2Y3B1X2lkKTsNCj4gID4gKyAgICAgICAgaWYg
KGt2bV9mZCA8IDApIHsNCj4gID4gKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiS1ZNX0NSRUFU
RV9WQ1BVIElPQ1RMIGZhaWxlZCBmb3IgdkNQVSAlbHUiLCAgdmNwdV9pZCk7DQo+ICA+ICsgICAg
ICAgICAgICByZXR1cm4ga3ZtX2ZkOw0KPiAgPiArICAgICAgICB9DQo+ICA+ICsgICAgfQ0KPiAg
PiArDQo+ICA+ICsgICAgY3B1LT5rdm1fZmQgPSBrdm1fZmQ7DQo+ICA+ICsgICAgY3B1LT5rdm1f
c3RhdGUgPSBzOw0KPiAgPiArICAgIGNwdS0+dmNwdV9kaXJ0eSA9IHRydWU7DQo+ICA+ICsgICAg
Y3B1LT5kaXJ0eV9wYWdlcyA9IDA7DQo+ICA+ICsgICAgY3B1LT50aHJvdHRsZV91c19wZXJfZnVs
bCA9IDA7DQo+ICA+ICsNCj4gID4gKyAgICByZXR1cm4gMDsNCj4gID4gK30NCj4gIA0KPiAgVGhp
cyBzZWVtcyBnZW5lcmljIGVub3VnaCB0byBiZSBpbXBsZW1lbnRlZCBmb3IgYWxsIGFjY2VsZXJh
dG9ycy4NCj4gIA0KPiAgU2VlIEFjY2VsT3BzQ2xhc3MgaW4gaW5jbHVkZS9zeXNlbXUvYWNjZWwt
b3BzLmguDQo+ICANCj4gIFRoYXQgc2FpZCwgY2FuIGJlIGRvbmUgbGF0ZXIgb24gdG9wLg0KDQpM
ZXQgbWUgdW5kZXJzdGFuZCBjb3JyZWN0bHkuIEFyZSB5b3Ugc3VnZ2VzdGluZyB0byBpbXBsZW1l
bnQgYWJvdmUgZXZlbiBmb3INCkhWRiwgVENHLCBRVEVTVCBldGM/DQoNClRoYW5rcw0KU2FsaWwu
DQoNCg0KDQoNCg==

