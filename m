Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F49C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eoz-0006bm-5V; Wed, 08 May 2024 06:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s4eov-0006aJ-El; Wed, 08 May 2024 06:46:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s4eos-0001C3-M6; Wed, 08 May 2024 06:46:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZBZK4nV6z6K6MM;
 Wed,  8 May 2024 18:43:21 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 0DE0F140B38;
 Wed,  8 May 2024 18:46:27 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 May 2024 11:46:26 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 8 May 2024 11:46:26 +0100
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
Thread-Index: AQHadCEigDg8Rw6JCkW/vDs/2Ez4xbGFgsCAgAB5OpCAABjHgIAHWGwg
Date: Wed, 8 May 2024 10:46:26 +0000
Message-ID: <ec1f4df024d94542a55835c852eededb@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-2-salil.mehta@huawei.com>
 <9747db79-4444-4d31-b014-8c368936cab4@linaro.org>
 <ed20ba7ef8d949fea9b81ed194c59bf6@huawei.com>
 <2f817b76-8090-418b-8547-98d366c52838@linaro.org>
In-Reply-To: <2f817b76-8090-418b-8547-98d366c52838@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.172.42]
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

SGkgUGhpbGxpcGUsDQoNClNvcnJ5LCBJIG1pc3NlZCB0aGlzIG1haWwgZWFybGllci4NCg0KPiAg
RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAgU2Vu
dDogRnJpZGF5LCBNYXkgMywgMjAyNCA3OjIzIFBNDQo+ICBUbzogU2FsaWwgTWVodGEgPHNhbGls
Lm1laHRhQGh1YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+ICBxZW11LWFybUBu
b25nbnUub3JnDQo+ICANCj4gIE9uIDMvNS8yNCAxNzo1NywgU2FsaWwgTWVodGEgd3JvdGU6DQo+
ICA+IEhpIFBoaWxpcHBlLA0KPiAgPg0KPiAgPj4gICBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+ICA+PiAgIFNlbnQ6IEZyaWRheSwgTWF5IDMsIDIw
MjQgMTA6NDAgQU0NCj4gID4+ICAgU3ViamVjdDogUmU6IFtQQVRDSCBWOCAxLzhdIGFjY2VsL2t2
bTogRXh0cmFjdCBjb21tb24gS1ZNIHZDUFUNCj4gID4+ICAge2NyZWF0aW9uLHBhcmtpbmd9IGNv
ZGUNCj4gID4+DQo+ICA+PiAgIEhpIFNhbGlsLA0KPiAgPj4NCj4gID4+ICAgT24gMTIvMy8yNCAw
Mjo1OSwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ICA+PiAgID4gS1ZNIHZDUFUgY3JlYXRpb24gaXMg
ZG9uZSBvbmNlIGR1cmluZyB0aGUgdkNQVSByZWFsaXphdGlvbiB3aGVuIFFlbXUNCj4gID4+ICAg
PiB2Q1BVIHRocmVhZCBpcyBzcGF3bmVkLiBUaGlzIGlzIGNvbW1vbiB0byBhbGwgdGhlIGFyY2hp
dGVjdHVyZXMgYXMgb2Ygbm93Lg0KPiAgPj4gICA+DQo+ICA+PiAgID4gSG90LXVucGx1ZyBvZiB2
Q1BVIHJlc3VsdHMgaW4gZGVzdHJ1Y3Rpb24gb2YgdGhlIHZDUFUgb2JqZWN0IGluIFFPTQ0KPiAg
Pj4gICA+IGJ1dCB0aGUgY29ycmVzcG9uZGluZyBLVk0gdkNQVSBvYmplY3QgaW4gdGhlIEhvc3Qg
S1ZNIGlzIG5vdCBkZXN0cm95ZWQNCj4gID4+ICAgPiBhcyBLVk0gZG9lc24ndCBzdXBwb3J0IHZD
UFUgcmVtb3ZhbC4gVGhlcmVmb3JlLCBpdHMgcmVwcmVzZW50YXRpdmUgS1ZNDQo+ICA+PiAgID4g
dkNQVSBvYmplY3QvY29udGV4dCBpbiBRZW11IGlzIHBhcmtlZC4NCj4gID4+ICAgPg0KPiAgPj4g
ICA+IFJlZmFjdG9yIGFyY2hpdGVjdHVyZSBjb21tb24gbG9naWMgc28gdGhhdCBzb21lIEFQSXMg
Y291bGQgYmUgcmV1c2VkDQo+ICA+PiAgID4gYnkgdkNQVSBIb3RwbHVnIGNvZGUgb2Ygc29tZSBh
cmNoaXRlY3R1cmVzIGxpa2VzIEFSTSwgTG9vbmdzb24gZXRjLg0KPiAgPj4gICA+IFVwZGF0ZSBu
ZXcvb2xkIEFQSXMgd2l0aCB0cmFjZSBldmVudHMgaW5zdGVhZCBvZiBEUFJJTlRGLiBObyBmdW5j
dGlvbmFsDQo+ICA+PiAgIGNoYW5nZSBpcyBpbnRlbmRlZCBoZXJlLg0KPiAgPj4gICA+DQo+ICA+
PiAgID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+
DQo+ICA+PiAgID4gUmV2aWV3ZWQtYnk6IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+
ICA+PiAgID4gVGVzdGVkLWJ5OiBWaXNobnUgUGFqanVyaSA8dmlzaG51QG9zLmFtcGVyZWNvbXB1
dGluZy5jb20+DQo+ICA+PiAgID4gUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0
aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gID4+ICAgPiBUZXN0ZWQtYnk6IFhpYW5nbGFpIExp
IDxsaXhpYW5nbGFpQGxvb25nc29uLmNuPg0KPiAgPj4gICA+IFRlc3RlZC1ieTogTWlndWVsIEx1
aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQo+ICA+PiAgID4gUmV2aWV3ZWQtYnk6IFNoYW9x
aW4gSHVhbmcgPHNoYWh1YW5nQHJlZGhhdC5jb20+DQo+ICA+PiAgID4gLS0tDQo+ICA+PiAgID4g
ICBhY2NlbC9rdm0va3ZtLWFsbC5jICAgIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystDQo+ICAtLS0tLQ0KPiAgPj4gICAtLS0tDQo+ICA+PiAgID4gICBhY2NlbC9rdm0vdHJh
Y2UtZXZlbnRzIHwgIDUgKysrLQ0KPiAgPj4gICA+ICAgaW5jbHVkZS9zeXNlbXUva3ZtLmggICB8
IDE2ICsrKysrKysrKysrDQo+ICA+PiAgID4gICAzIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlv
bnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiAgPj4gICA+DQo+ICA+PiAgID4gZGlmZiAtLWdpdCBh
L2FjY2VsL2t2bS9rdm0tYWxsLmMgYi9hY2NlbC9rdm0va3ZtLWFsbC5jIGluZGV4DQo+ICA+PiAg
ID4gYThjZWNkMDQwZS4uM2JjMzIwN2JkYSAxMDA2NDQNCj4gID4+ICAgPiAtLS0gYS9hY2NlbC9r
dm0va3ZtLWFsbC5jDQo+ICA+PiAgID4gKysrIGIvYWNjZWwva3ZtL2t2bS1hbGwuYw0KPiAgPj4g
ICA+IEBAIC0xMjYsNiArMTI2LDcgQEAgc3RhdGljIFFlbXVNdXRleCBrbWxfc2xvdHNfbG9jazsN
Cj4gID4+ICAgPiAgICNkZWZpbmUga3ZtX3Nsb3RzX3VubG9jaygpICBxZW11X211dGV4X3VubG9j
aygma21sX3Nsb3RzX2xvY2spDQo+ICA+PiAgID4NCj4gID4+ICAgPiAgIHN0YXRpYyB2b2lkIGt2
bV9zbG90X2luaXRfZGlydHlfYml0bWFwKEtWTVNsb3QgKm1lbSk7DQo+ICA+PiAgID4gK3N0YXRp
YyBpbnQga3ZtX2dldF92Y3B1KEtWTVN0YXRlICpzLCB1bnNpZ25lZCBsb25nIHZjcHVfaWQpOw0K
PiAgPj4gICA+DQo+ICA+PiAgID4gICBzdGF0aWMgaW5saW5lIHZvaWQga3ZtX3Jlc2FtcGxlX2Zk
X3JlbW92ZShpbnQgZ3NpKQ0KPiAgPj4gICA+ICAgew0KPiAgPj4gICA+IEBAIC0zMTQsMTQgKzMx
NSw1MyBAQCBlcnI6DQo+ICA+PiAgID4gICAgICAgcmV0dXJuIHJldDsNCj4gID4+ICAgPiAgIH0N
Cj4gID4+ICAgPg0KPiAgPj4gICA+ICt2b2lkIGt2bV9wYXJrX3ZjcHUoQ1BVU3RhdGUgKmNwdSkN
Cj4gID4+ICAgPiArew0KPiAgPj4gICA+ICsgICAgc3RydWN0IEtWTVBhcmtlZFZjcHUgKnZjcHU7
DQo+ICA+PiAgID4gKw0KPiAgPj4gICA+ICsgICAgdHJhY2Vfa3ZtX3BhcmtfdmNwdShjcHUtPmNw
dV9pbmRleCwga3ZtX2FyY2hfdmNwdV9pZChjcHUpKTsNCj4gID4+ICAgPiArDQo+ICA+PiAgID4g
KyAgICB2Y3B1ID0gZ19tYWxsb2MwKHNpemVvZigqdmNwdSkpOw0KPiAgPj4gICA+ICsgICAgdmNw
dS0+dmNwdV9pZCA9IGt2bV9hcmNoX3ZjcHVfaWQoY3B1KTsNCj4gID4+ICAgPiArICAgIHZjcHUt
Pmt2bV9mZCA9IGNwdS0+a3ZtX2ZkOw0KPiAgPj4gICA+ICsgICAgUUxJU1RfSU5TRVJUX0hFQUQo
Jmt2bV9zdGF0ZS0+a3ZtX3BhcmtlZF92Y3B1cywgdmNwdSwgbm9kZSk7IH0NCj4gID4+ICAgPiAr
DQo+ICA+PiAgID4gK2ludCBrdm1fY3JlYXRlX3ZjcHUoQ1BVU3RhdGUgKmNwdSkNCj4gID4+ICAg
PiArew0KPiAgPj4gICA+ICsgICAgdW5zaWduZWQgbG9uZyB2Y3B1X2lkID0ga3ZtX2FyY2hfdmNw
dV9pZChjcHUpOw0KPiAgPj4gICA+ICsgICAgS1ZNU3RhdGUgKnMgPSBrdm1fc3RhdGU7DQo+ICA+
PiAgID4gKyAgICBpbnQga3ZtX2ZkOw0KPiAgPj4gICA+ICsNCj4gID4+ICAgPiArICAgIHRyYWNl
X2t2bV9jcmVhdGVfdmNwdShjcHUtPmNwdV9pbmRleCwga3ZtX2FyY2hfdmNwdV9pZChjcHUpKTsN
Cj4gID4+ICAgPiArDQo+ICA+PiAgID4gKyAgICAvKiBjaGVjayBpZiB0aGUgS1ZNIHZDUFUgYWxy
ZWFkeSBleGlzdCBidXQgaXMgcGFya2VkICovDQo+ICA+PiAgID4gKyAgICBrdm1fZmQgPSBrdm1f
Z2V0X3ZjcHUocywgdmNwdV9pZCk7DQo+ICA+PiAgID4gKyAgICBpZiAoa3ZtX2ZkIDwgMCkgew0K
PiAgPj4gICA+ICsgICAgICAgIC8qIHZDUFUgbm90IHBhcmtlZDogY3JlYXRlIGEgbmV3IEtWTSB2
Q1BVICovDQo+ICA+PiAgID4gKyAgICAgICAga3ZtX2ZkID0ga3ZtX3ZtX2lvY3RsKHMsIEtWTV9D
UkVBVEVfVkNQVSwgdmNwdV9pZCk7DQo+ICA+PiAgID4gKyAgICAgICAgaWYgKGt2bV9mZCA8IDAp
IHsNCj4gID4+ICAgPiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJLVk1fQ1JFQVRFX1ZDUFUg
SU9DVEwgZmFpbGVkIGZvciB2Q1BVICVsdSIsIHZjcHVfaWQpOw0KPiAgPj4gICA+ICsgICAgICAg
ICAgICByZXR1cm4ga3ZtX2ZkOw0KPiAgPj4gICA+ICsgICAgICAgIH0NCj4gID4+ICAgPiArICAg
IH0NCj4gID4+ICAgPiArDQo+ICA+PiAgID4gKyAgICBjcHUtPmt2bV9mZCA9IGt2bV9mZDsNCj4g
ID4+ICAgPiArICAgIGNwdS0+a3ZtX3N0YXRlID0gczsNCj4gID4+ICAgPiArICAgIGNwdS0+dmNw
dV9kaXJ0eSA9IHRydWU7DQo+ICA+PiAgID4gKyAgICBjcHUtPmRpcnR5X3BhZ2VzID0gMDsNCj4g
ID4+ICAgPiArICAgIGNwdS0+dGhyb3R0bGVfdXNfcGVyX2Z1bGwgPSAwOw0KPiAgPj4gICA+ICsN
Cj4gID4+ICAgPiArICAgIHJldHVybiAwOw0KPiAgPj4gICA+ICt9DQo+ICA+Pg0KPiAgPj4gICBU
aGlzIHNlZW1zIGdlbmVyaWMgZW5vdWdoIHRvIGJlIGltcGxlbWVudGVkIGZvciBhbGwgYWNjZWxl
cmF0b3JzLg0KPiAgPj4NCj4gID4+ICAgU2VlIEFjY2VsT3BzQ2xhc3MgaW4gaW5jbHVkZS9zeXNl
bXUvYWNjZWwtb3BzLmguDQo+ICA+Pg0KPiAgPj4gICBUaGF0IHNhaWQsIGNhbiBiZSBkb25lIGxh
dGVyIG9uIHRvcC4NCj4gID4NCj4gID4gTGV0IG1lIHVuZGVyc3RhbmQgY29ycmVjdGx5LiBBcmUg
eW91IHN1Z2dlc3RpbmcgdG8gaW1wbGVtZW50IGFib3ZlDQo+ICA+IGV2ZW4gZm9yIEhWRiwgVENH
LCBRVEVTVCBldGM/DQo+ICANCj4gIE5vdCBmb3IgeW91IHRvIGltcGxlbWVudCB0aGUgb3RoZXIg
bm9uLUtWTSBhY2NlbGVyYXRvcnMsIGJ1dCBzaW5jZSB5b3UNCj4gIGFyZSBpbnRyb2R1Y2luZyB0
aGlzLCBub3cgaXMgYSBnb29kIHRpbWUgdG8gdGhpbmsgYWJvdXQgYSBnZW5lcmljIGludGVyZmFj
ZS4NCj4gIA0KPiAgU28gZmFyIEFjY2VsT3BzQ2xhc3M6Olt1bl1wYXJrX3ZjcHUoKSBoYW5kbGVy
cyBtYWtlIHNlbnNlIHRvIG1lLg0KDQpTdXJlLCBidXQgd2hhdCBpcyB0aGUgYWR2YW50YWdlIG9m
IGRlZmluaW5nIHRoZXNlICdzdXBwb3J0aW5nJyBmdW5jdGlvbnMNCmFzIHBhcnQgb2YgdGhlIEFj
Y2VsT3BzQ2xhc3M/IEVhY2ggb2YgdGhlc2UgZnVuY3Rpb25zIGluIGFueSBjYXNlIHdpbGwgbmVl
ZA0KdG8gYmUgZGVmaW5lZCBpbmRpdmlkdWFsbHkgZm9yIGRpZmZlcmVudCBBY2NlbGVyYXRvcnMg
b3IgdW5sZXNzIHdlIGFyZQ0KcGxhbm5pbmcgdG8gZXh0cmFjdCBzb21lIGNvbW1vbiBhY2NlbGVy
YXRvciBmdW5jdGlvbnMgaW4gYSBzZXBhcmF0ZSBmaWxlDQphbmQgdXNlIHRoZW0gYWNyb3NzIGFs
bCB0aGUgYWNjZWxlcmF0b3JzPw0KDQpJJ20gc3VyZWx5IG1pc3Npbmcgc29tZSBrZXkgcG9pbnQg
aGVyZS4NCg0KVGhhbmtzDQpTYWxpbC4NCg0KDQoNCg0KDQo=

