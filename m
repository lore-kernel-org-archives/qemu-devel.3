Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52016C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJyn-0002Ob-AP; Mon, 01 Jul 2024 12:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sOJyk-0002KQ-8d; Mon, 01 Jul 2024 12:34:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sOJyg-0008Fi-TG; Mon, 01 Jul 2024 12:34:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCWnJ6148z6JB16;
 Tue,  2 Jul 2024 00:33:24 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 1FDBA140680;
 Tue,  2 Jul 2024 00:33:58 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 17:33:57 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 1 Jul 2024 17:33:57 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: Gavin Shan <gshan@redhat.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
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
Thread-Index: AQHasiICqFrRyvmDr0+9IflX7gIe/7G0/EKAgAQw/ICAIBLYAIAASTeAgAD1fFCABzMkAIAAkbgA
Date: Mon, 1 Jul 2024 16:33:57 +0000
Message-ID: <308d3c98e30244daa3538bb898bee6b6@huawei.com>
References: <20240529234241.205053-1-salil.mehta@huawei.com>
 <20240602180241-mutt-send-email-mst@kernel.org>
 <20240605160327.3c71f4ab@imammedo.users.ipa.redhat.com>
 <CAJ7pxeYehVhPWfbEqRMMSCVHk31JQhtQhRSM_4e1WqBhqv0UHQ@mail.gmail.com>
 <b36e0d64-9653-4d48-b72a-00a1aee86629@redhat.com>
 <eb5880984ddf41aabca9d036e7ad445f@huawei.com>
 <20240701104844.32e0207b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240701104844.32e0207b@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.32.244]
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

SGkgSWdvciwNCg0KPiAgRnJvbTogSWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4N
Cj4gIFNlbnQ6IE1vbmRheSwgSnVseSAxLCAyMDI0IDk6NDkgQU0NCj4gIFRvOiBTYWxpbCBNZWh0
YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIA0KPiAgT24gV2VkLCAyNiBKdW4gMjAyNCAx
Nzo1Mzo1MiArMDAwMA0KPiAgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdy
b3RlOg0KPiAgDQo+ICA+IEhpIEdhdmluLA0KPiAgPg0KPiAgPiA+ICBGcm9tOiBHYXZpbiBTaGFu
IDxnc2hhbkByZWRoYXQuY29tPg0KPiAgPiA+ICBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjYsIDIw
MjQgNToxMyBBTQ0KPiAgPiA+ICBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQG9wbnNyYy5u
ZXQ+OyBJZ29yIE1hbW1lZG92DQo+ICA+ID4gPGltYW1tZWRvQHJlZGhhdC5jb20+DQo+ICA+ID4N
Cj4gID4gPiAgSGkgU2FsaWwgYW5kIElnb3IsDQo+ICA+ID4NCj4gID4gPiAgT24gNi8yNi8yNCA5
OjUxIEFNLCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gID4gPiAgPiBPbiBXZWQsIEp1biA1LCAyMDI0
IGF0IDM6MDPigK9QTSBJZ29yIE1hbW1lZG92DQo+ICA+ID4gPGltYW1tZWRvQHJlZGhhdC5jb20g
PG1haWx0bzppbWFtbWVkb0ByZWRoYXQuY29tPj4gd3JvdGU6DQo+ICA+ID4gID4gICAgIE9uIFN1
biwgMiBKdW4gMjAyNCAxODowMzowNSAtMDQwMA0KPiAgPiA+ICA+ICAgICAiTWljaGFlbCBTLiBU
c2lya2luIiA8bXN0QHJlZGhhdC5jb20gPG1haWx0bzptc3RAcmVkaGF0LmNvbT4+IHdyb3RlOg0K
PiAgPiA+ICA+DQo+ICA+ID4gID4gICAgICA+IE9uIFRodSwgTWF5IDMwLCAyMDI0IGF0IDEyOjQy
OjMzQU0gKzAxMDAsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPiA+ICA+ICAgICAgPiA+IFZpcnR1
YWwgQ1BVIGhvdHBsdWcgc3VwcG9ydCBpcyBiZWluZyBhZGRlZCBhY3Jvc3MgdmFyaW91cyBhcmNo
aXRlY3R1cmVzWzFdWzNdLg0KPiAgPiA+ICA+ICAgICAgPiA+IFRoaXMgc2VyaWVzIGFkZHMgdmFy
aW91cyBjb2RlIGJpdHMgY29tbW9uIGFjcm9zcyBhbGwgIGFyY2hpdGVjdHVyZXM6DQo+ICA+ID4g
ID4gICAgICA+ID4NCj4gID4gPiAgPiAgICAgID4gPiAxLiB2Q1BVIGNyZWF0aW9uIGFuZCBQYXJr
aW5nIGNvZGUgcmVmYWN0b3IgW1BhdGNoIDFdDQo+ICA+ID4gID4gICAgICA+ID4gMi4gVXBkYXRl
IEFDUEkgR0VEIGZyYW1ld29yayB0byBzdXBwb3J0IHZDUFUgSG90cGx1ZyBbUGF0Y2ggMiwzXQ0K
PiAgPiA+ICA+ICAgICAgPiA+IDMuIEFDUEkgQ1BVcyBBTUwgY29kZSBjaGFuZ2UgW1BhdGNoIDQs
NV0NCj4gID4gPiAgPiAgICAgID4gPiA0LiBIZWxwZXIgZnVuY3Rpb25zIHRvIHN1cHBvcnQgdW5y
ZWFsaXphdGlvbiBvZiBDUFUgb2JqZWN0cyAgW1BhdGNoICA2LDddDQo+ICA+ID4gID4gICAgICA+
ID4gNS4gRG9jcyBbUGF0Y2ggOF0NCj4gID4gPiAgPiAgICAgID4gPg0KPiAgPiA+ICA+ICAgICAg
PiA+DQo+ICA+ID4gID4gICAgICA+ID4gUmVwb3NpdG9yeToNCj4gID4gPiAgPiAgICAgID4gPg0K
PiAgPiA+ICA+ICAgICAgPiA+IFsqXSBodHRwczovL2dpdGh1Yi5jb20vc2FsaWwtbWVodGEvcWVt
dS5naXQgICA8aHR0cHM6Ly9naXRodWIuY29tL3NhbGlsLW1laHRhL3FlbXUuZ2l0PiB2aXJ0LWNw
dWhwLWFybXY4L3JmYy12My5hcmNoLmFnbm9zdGljLnYxMg0KPiAgPiA+ICA+ICAgICAgPiA+DQo+
ICA+ID4gID4gICAgICA+ID4gTk9URTogVGhpcyBzZXJpZXMgaXMgbWVhbnQgdG8gd29yayBpbiBj
b25qdW5jdGlvbiB3aXRoIEFyY2hpdGVjdHVyZSBzcGVjaWZpYyBwYXRjaC1zZXQuDQo+ICA+ID4g
ID4gICAgICA+ID4gRm9yIEFSTSwgdGhpcyB3aWxsIHdvcmsgaW4gY29tYmluYXRpb24gb2YgdGhl
IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBwYXJ0IGJhc2VkIG9uDQo+ICA+ID4gID4gICAgICA+ID4g
UkZDIFYyIFsxXS4gVGhpcyBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgcGF0Y2gtc2V0IFJGQyBWMyBz
aGFsbCBiZSBmbG9hdGVkIHNvb24gYW5kIGlzDQo+ICA+ID4gID4gICAgICA+ID4gcHJlc2VudCBh
dCBiZWxvdyBsb2NhdGlvbg0KPiAgPiA+ICA+ICAgICAgPiA+DQo+ICA+ID4gID4gICAgICA+ID4g
WypdIGh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11L3RyZWUvdmlydC1jcHVocC1h
cm12OC9yZmMtdjMtcmMxIDxodHRwczovL2dpdGh1Yi5jb20vc2FsaWwtbWVodGEvcWVtdS90cmVl
L3ZpcnQtY3B1aHAtDQo+ICBhcm12OC9yZmMtdjMtcmMxPg0KPiAgPiA+ICA+ICAgICAgPiA+DQo+
ICA+ID4gID4gICAgICA+DQo+ICA+ID4gID4gICAgICA+DQo+ICA+ID4gID4gICAgICA+IElnb3Ig
cGxhbiB0byB0YWtlIGEgbG9vaz8NCj4gID4gPiAgPg0KPiAgPiA+ICA+ICAgICBZZXAsIEkgcGxh
biB0byByZXZpZXcgaXQNCj4gID4gPiAgPg0KPiAgPiA+ICA+DQo+ICA+ID4gID4gQSBnZW50bGUg
cmVtaW5kZXIgb24gdGhpcy4NCj4gID4gPiAgPg0KPiAgPiA+DQo+ICA+ID4gIFNpbmNlIHRoZSBs
YXRlc3QgcmV2aXNpb24gZm9yIHRoaXMgc2VyaWVzIGlzIHYxMywgc28gSSBndWVzcyBJZ29yDQo+
ICA+ID4gbmVlZHMgdG8gZG8gdGhlICBmaW5hbCBzY3JlZW5pbmcgb24gdjEzIGluc3RlYWQ/DQo+
ICA+ID4NCj4gID4gPiAgdjEzOg0KPiAgPiA+IGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNo
aXZlL2h0bWwvcWVtdS1hcm0vMjAyNC0wNi9tc2cwMDEyOS5odG1sDQo+ICA+DQo+ICA+DQo+ICA+
IFllcywgdGhhbmtzIGZvciBwb2ludGluZyB0aGlzLiDwn5iKDQo+ICANCj4gIEkgaGF2ZSB2MTMg
dGFnZ2VkLA0KPiAgU29ycnkgZm9yIGRlbGF5LCBJJ2xsIHRyeSB0byByZXZpZXcgaXQgdGhpcyB3
ZWVrDQoNClN1cmUuIE5vIHByb2JsZW0uIA0KDQpUaGFua3MNClNhbGlsLg0KDQo+ICA+ID4gIFRo
YW5rcywNCj4gID4gPiAgR2F2aW4NCg0K

