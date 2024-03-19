Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD4FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 05:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmRlg-0006NM-MI; Tue, 19 Mar 2024 01:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1rmRlb-0006Mu-8S
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 01:12:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1rmRlT-0008Vd-IC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 01:12:02 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TzKZ30n7tz1vx9R;
 Tue, 19 Mar 2024 13:11:07 +0800 (CST)
Received: from kwepemm000015.china.huawei.com (unknown [7.193.23.180])
 by mail.maildlp.com (Postfix) with ESMTPS id CCFF41A0172;
 Tue, 19 Mar 2024 13:11:52 +0800 (CST)
Received: from kwepemi500026.china.huawei.com (7.221.188.247) by
 kwepemm000015.china.huawei.com (7.193.23.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 13:11:52 +0800
Received: from kwepemi500026.china.huawei.com ([7.221.188.247]) by
 kwepemi500026.china.huawei.com ([7.221.188.247]) with mapi id 15.01.2507.035; 
 Tue, 19 Mar 2024 13:11:52 +0800
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Igor
 Mammedov" <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
CC: "Wanghaibin (D)" <wanghaibin.wang@huawei.com>, yuzenghui
 <yuzenghui@huawei.com>, jiangkunkun <jiangkunkun@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjEgMi8yXSBzeXN0ZW0vY3B1czogRml4IHJlc3Vt?=
 =?utf-8?B?ZV9hbGxfdmNwdXMoKSB1bmRlciB2Q1BVIGhvdHBsdWcgY29uZGl0aW9u?=
Thread-Topic: [PATCH v1 2/2] system/cpus: Fix resume_all_vcpus() under vCPU
 hotplug condition
Thread-Index: AQHaeEZ8RsoorYucWEqsCM8nsDv5s7E8w3cAgAHCplA=
Date: Tue, 19 Mar 2024 05:11:52 +0000
Message-ID: <60ed0bd01fc346088f48bcce1c92a6d3@huawei.com>
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
 <20240317083704.23244-3-zhukeqian1@huawei.com>
 <57c8506e-3f6a-4d1d-9720-c9b030781109@redhat.com>
In-Reply-To: <57c8506e-3f6a-4d1d-9720-c9b030781109@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.224]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhukeqian1@huawei.com;
 helo=szxga06-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  zhukeqian <zhukeqian1@huawei.com>
From:  zhukeqian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgRGF2aWQsDQoNCk9uIDE3LjAzLjI0IDA5OjM3LCBLZXFpYW4gWmh1IHZpYSB3cm90ZToNCj4+
IEZvciB2Q1BVIGJlaW5nIGhvdHBsdWdnZWQsIHFlbXVfaW5pdF92Y3B1KCkgaXMgY2FsbGVkLiBJ
biB0aGlzIA0KPj4gZnVuY3Rpb24sIHdlIHNldCB2Y3B1IHN0YXRlIGFzIHN0b3BwZWQsIGFuZCB0
aGVuIHdhaXQgdmNwdSB0aHJlYWQgdG8gDQo+PiBiZSBjcmVhdGVkLg0KPj4gDQo+PiBBcyB0aGUg
dmNwdSBzdGF0ZSBpcyBzdG9wcGVkLCBpdCB3aWxsIGluZm9ybSB1cyBpdCBoYXMgYmVlbiBjcmVh
dGVkIA0KPj4gYW5kIHRoZW4gd2FpdCBvbiBoYWx0X2NvbmQuIEFmdGVyIHdlIGhhcyByZWFsaXpl
ZCB2Y3B1IG9iamVjdCwgd2Ugd2lsbCANCj4+IHJlc3VtZSB0aGUgdmNwdSB0aHJlYWQuDQo+PiAN
Cj4+IEhvd2V2ZXIsIGR1cmluZyB3ZSB3YWl0IHZjcHUgdGhyZWFkIHRvIGJlIGNyZWF0ZWQsIHRo
ZSBicWwgaXMgDQo+PiB1bmxvY2tlZCwgYW5kIG90aGVyIHRocmVhZCBpcyBhbGxvd2VkIHRvIGNh
bGwgcmVzdW1lX2FsbF92Y3B1cygpLCANCj4+IHdoaWNoIHdpbGwgcmVzdW1lIHRoZSB1bi1yZWFs
aXplZCB2Y3B1Lg0KPj4gDQo+PiBUaGlzIGZpeGVzIHRoZSBpc3N1ZSBieSBmaWx0ZXIgb3V0IHVu
LXJlYWxpemVkIHZjcHUgZHVyaW5nIA0KPj4gcmVzdW1lX2FsbF92Y3B1cygpLg0KPg0KPlNpbWls
YXIgcXVlc3Rpb246IGlzIHRoZXJlIGEgcmVwcm9kdWNlcj8gDQo+DQo+SG93IGNvdWxkIHdlIGN1
cnJlbnRseSBob3RwbHVnIGEgVkNQVSwgYW5kIHdoaWxlIGl0IGlzIGJlaW5nIGNyZWF0ZWQsIHNl
ZSBwYXVzZV9hbGxfdmNwdXMoKS9yZXN1bWVfYWxsX3ZjcHVzKCkgZ2V0dGluZyBjbGFsZWQuIA0K
Pg0KSSBkZXNjcmliZWQgdGhlIHJlYXNvbiBmb3IgdGhpcyBhdCBwYXRjaCAxLg0KDQo+SWYgSSBh
bSBub3QgZ2V0dGluZyB0aGlzIHdyb25nLCB0aGVyZSBzZWVtcyB0byBiZSBzb21lIG90aGVyIG1l
Y2hhbmlzbSBtaXNzaW5nIHRoYXQgbWFrZXMgc3VyZSB0aGF0IHRoaXMgY2Fubm90IGhhcHBlbi4g
RHJvcHBpbmcgdGhlIEJRTCBoYWxmLXdheSB0aHJvdWdoIGNyZWF0aW5nIGEgVkNQVSBtaWdodCBi
ZSB0aGUgcHJvYmxlbS4NCj4NCldoZW4gd2UgYWRkIHJldHJ5IG1lY2hhbmlzbSBpbiBwYXVzZV9h
bGxfdmNwdXMoKSwgd2UgY2FuIHNvbHZlIHRoaXMgcHJvYmxlbS4gV2l0aCB0aGUgc2VtYXRpYyB1
bmNoYW5nZWQgZm9yIHVzZXIsIHdoaWNoIG1lYW5zOg0KV2l0aCBicWwsIHdlIGNhbiBtYWtlIHN1
cmUgYWxsIHZjcHVzIGFyZSBwYXVzZWQgYWZ0ZXIgcGF1c2VfYWxsX3ZjcHVzKCkgZmluaXNoLCAg
YW5kIGFsbCB2Y3B1cyBhcmUgcmVzdW1lZCBhZnRlciByZXN1bWVfYWxsX3ZjcHVzKCkgZmluaXNo
Lg0KDQpUaGFua3MsDQpLZXFpYW4NCg0KPg0KPg0KLS0NCkNoZWVycywNCg0KRGF2aWQgLyBkaGls
ZGVuYg0KDQo=

