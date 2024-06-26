Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B544CC3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 17:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMWqW-0000Bv-47; Wed, 26 Jun 2024 13:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sMWqU-0000Al-F9; Wed, 26 Jun 2024 13:54:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sMWqS-0000Hj-0z; Wed, 26 Jun 2024 13:54:14 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W8TmV54tHz6K9JB;
 Thu, 27 Jun 2024 01:52:10 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (unknown [7.191.163.9])
 by mail.maildlp.com (Postfix) with ESMTPS id 00C191400C9;
 Thu, 27 Jun 2024 01:53:53 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 18:53:52 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 26 Jun 2024 18:53:52 +0100
To: Gavin Shan <gshan@redhat.com>, Salil Mehta <salil.mehta@opnsrc.net>, "Igor
 Mammedov" <imammedo@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V12 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V12 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHasiICqFrRyvmDr0+9IflX7gIe/7G0/EKAgAQw/ICAIBLYAIAASTeAgAD1fFA=
Date: Wed, 26 Jun 2024 17:53:52 +0000
Message-ID: <eb5880984ddf41aabca9d036e7ad445f@huawei.com>
References: <20240529234241.205053-1-salil.mehta@huawei.com>
 <20240602180241-mutt-send-email-mst@kernel.org>
 <20240605160327.3c71f4ab@imammedo.users.ipa.redhat.com>
 <CAJ7pxeYehVhPWfbEqRMMSCVHk31JQhtQhRSM_4e1WqBhqv0UHQ@mail.gmail.com>
 <b36e0d64-9653-4d48-b72a-00a1aee86629@redhat.com>
In-Reply-To: <b36e0d64-9653-4d48-b72a-00a1aee86629@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.33.18]
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

SGkgR2F2aW4sDQoNCj4gIEZyb206IEdhdmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQo+ICBT
ZW50OiBXZWRuZXNkYXksIEp1bmUgMjYsIDIwMjQgNToxMyBBTQ0KPiAgVG86IFNhbGlsIE1laHRh
IDxzYWxpbC5tZWh0YUBvcG5zcmMubmV0PjsgSWdvciBNYW1tZWRvdg0KPiAgPGltYW1tZWRvQHJl
ZGhhdC5jb20+DQo+ICANCj4gIEhpIFNhbGlsIGFuZCBJZ29yLA0KPiAgDQo+ICBPbiA2LzI2LzI0
IDk6NTEgQU0sIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPiBPbiBXZWQsIEp1biA1LCAyMDI0IGF0
IDM6MDPigK9QTSBJZ29yIE1hbW1lZG92DQo+ICA8aW1hbW1lZG9AcmVkaGF0LmNvbSA8bWFpbHRv
OmltYW1tZWRvQHJlZGhhdC5jb20+PiB3cm90ZToNCj4gID4gICAgIE9uIFN1biwgMiBKdW4gMjAy
NCAxODowMzowNSAtMDQwMA0KPiAgPiAgICAgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRo
YXQuY29tIDxtYWlsdG86bXN0QHJlZGhhdC5jb20+Pg0KPiAgd3JvdGU6DQo+ICA+DQo+ICA+ICAg
ICAgPiBPbiBUaHUsIE1heSAzMCwgMjAyNCBhdCAxMjo0MjozM0FNICswMTAwLCBTYWxpbCBNZWh0
YSB3cm90ZToNCj4gID4gICAgICA+ID4gVmlydHVhbCBDUFUgaG90cGx1ZyBzdXBwb3J0IGlzIGJl
aW5nIGFkZGVkIGFjcm9zcyB2YXJpb3VzIGFyY2hpdGVjdHVyZXNbMV1bM10uDQo+ICA+ICAgICAg
PiA+IFRoaXMgc2VyaWVzIGFkZHMgdmFyaW91cyBjb2RlIGJpdHMgY29tbW9uIGFjcm9zcyBhbGwg
YXJjaGl0ZWN0dXJlczoNCj4gID4gICAgICA+ID4NCj4gID4gICAgICA+ID4gMS4gdkNQVSBjcmVh
dGlvbiBhbmQgUGFya2luZyBjb2RlIHJlZmFjdG9yIFtQYXRjaCAxXQ0KPiAgPiAgICAgID4gPiAy
LiBVcGRhdGUgQUNQSSBHRUQgZnJhbWV3b3JrIHRvIHN1cHBvcnQgdkNQVSBIb3RwbHVnIFtQYXRj
aCAyLDNdDQo+ICA+ICAgICAgPiA+IDMuIEFDUEkgQ1BVcyBBTUwgY29kZSBjaGFuZ2UgW1BhdGNo
IDQsNV0NCj4gID4gICAgICA+ID4gNC4gSGVscGVyIGZ1bmN0aW9ucyB0byBzdXBwb3J0IHVucmVh
bGl6YXRpb24gb2YgQ1BVIG9iamVjdHMgW1BhdGNoICA2LDddDQo+ICA+ICAgICAgPiA+IDUuIERv
Y3MgW1BhdGNoIDhdDQo+ICA+ICAgICAgPiA+DQo+ICA+ICAgICAgPiA+DQo+ICA+ICAgICAgPiA+
IFJlcG9zaXRvcnk6DQo+ICA+ICAgICAgPiA+DQo+ICA+ICAgICAgPiA+IFsqXSBodHRwczovL2dp
dGh1Yi5jb20vc2FsaWwtbWVodGEvcWVtdS5naXQgICA8aHR0cHM6Ly9naXRodWIuY29tL3NhbGls
LW1laHRhL3FlbXUuZ2l0PiB2aXJ0LWNwdWhwLWFybXY4L3JmYy0gdjMuYXJjaC5hZ25vc3RpYy52
MTINCj4gID4gICAgICA+ID4NCj4gID4gICAgICA+ID4gTk9URTogVGhpcyBzZXJpZXMgaXMgbWVh
bnQgdG8gd29yayBpbiBjb25qdW5jdGlvbiB3aXRoIEFyY2hpdGVjdHVyZSBzcGVjaWZpYyBwYXRj
aC1zZXQuDQo+ICA+ICAgICAgPiA+IEZvciBBUk0sIHRoaXMgd2lsbCB3b3JrIGluIGNvbWJpbmF0
aW9uIG9mIHRoZSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgcGFydCBiYXNlZCBvbg0KPiAgPiAgICAg
ID4gPiBSRkMgVjIgWzFdLiBUaGlzIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBwYXRjaC1zZXQgUkZD
IFYzIHNoYWxsIGJlIGZsb2F0ZWQgc29vbiBhbmQgaXMNCj4gID4gICAgICA+ID4gcHJlc2VudCBh
dCBiZWxvdyBsb2NhdGlvbg0KPiAgPiAgICAgID4gPg0KPiAgPiAgICAgID4gPiBbKl0gaHR0cHM6
Ly9naXRodWIuY29tL3NhbGlsLW1laHRhL3FlbXUvdHJlZS92aXJ0LWNwdWhwLWFybXY4L3JmYy12
My1yYzEgPGh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11L3RyZWUvdmlydC1jcHVo
cC1hcm12OC9yZmMtdjMtcmMxPg0KPiAgPiAgICAgID4gPg0KPiAgPiAgICAgID4NCj4gID4gICAg
ICA+DQo+ICA+ICAgICAgPiBJZ29yIHBsYW4gdG8gdGFrZSBhIGxvb2s/DQo+ICA+DQo+ICA+ICAg
ICBZZXAsIEkgcGxhbiB0byByZXZpZXcgaXQNCj4gID4NCj4gID4NCj4gID4gQSBnZW50bGUgcmVt
aW5kZXIgb24gdGhpcy4NCj4gID4NCj4gIA0KPiAgU2luY2UgdGhlIGxhdGVzdCByZXZpc2lvbiBm
b3IgdGhpcyBzZXJpZXMgaXMgdjEzLCBzbyBJIGd1ZXNzIElnb3IgbmVlZHMgdG8gZG8gdGhlDQo+
ICBmaW5hbCBzY3JlZW5pbmcgb24gdjEzIGluc3RlYWQ/DQo+ICANCj4gIHYxMzogaHR0cHM6Ly9s
aXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWFybS8yMDI0LTA2L21zZzAwMTI5Lmh0
bWwNCg0KDQpZZXMsIHRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcy4g8J+Yig0KDQoNCj4gIA0KPiAg
VGhhbmtzLA0KPiAgR2F2aW4NCj4gIA0KDQo=

