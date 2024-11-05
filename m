Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B35D3E775
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Ruw-0001Th-IA; Tue, 05 Nov 2024 17:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8Ruu-0001TD-SZ; Tue, 05 Nov 2024 17:20:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8Rut-00080T-91; Tue, 05 Nov 2024 17:20:52 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XjjQM4046z6K6RZ;
 Wed,  6 Nov 2024 06:18:03 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id D588A140517;
 Wed,  6 Nov 2024 06:20:48 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 23:20:48 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 5 Nov 2024 23:20:48 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "maz@kernel.org" <maz@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>
Subject: RE: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs
 for reuse
Thread-Topic: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs
 for reuse
Thread-Index: AQHbLgSbwU64kgKDNkuiSDBIJV8mp7KnDaaAgAI3n/A=
Date: Tue, 5 Nov 2024 22:20:48 +0000
Message-ID: <7d27ceab963441dc8355d06e6bc4b88d@huawei.com>
References: <20241103152455.202462-1-salil.mehta@huawei.com>
 <CAFEAcA91DoU4dAHYy6OOeMjEQ+0LGZX8KM-rKsCh89UnFS4yTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA91DoU4dAHYy6OOeMjEQ+0LGZX8KM-rKsCh89UnFS4yTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.66]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SEkgUGV0ZXIsDQoNCj4gIEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4gIFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxOjI3IFBNDQo+ICBUbzog
U2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICANCj4gIE9uIFN1biwgMyBO
b3YgMjAyNCBhdCAxNToyNSwgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdy
b3RlOg0KPiAgPg0KPiAgPiBFeHRyYWN0IGNvbW1vbiBHSUMgYW5kIENQVSBpbnRlcnJ1cHQgd2ly
aW5nIGNvZGUgdG8gaW1wcm92ZSBjb2RlDQo+ICA+IHJlYWRhYmlsaXR5IGFuZCBtb2R1bGFyaXR5
LCBzdXBwb3J0aW5nIHJldXNlIGluIGZ1dHVyZSBwYXRjaCBzZXRzLg0KPiAgPiBUaGlzIHJlZmFj
dG9yIGlzIGJlbmlnbiBhbmQgaW50cm9kdWNlcyAqbm8qIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4g
ID4NCj4gID4gTm90ZTogVGhpcyBwYXRjaCBoYXMgYmVlbiBpc29sYXRlZCBmcm9tIGEgbGFyZ2Vy
IHBhdGNoIHNldCB0bw0KPiAgPiBmYWNpbGl0YXRlIGVhcmx5IG1lcmdpbmcgYW5kIHJlZHVjZSB0
aGUgY29tcGxleGl0eSBvZiB0aGUgb3JpZ2luYWwNCj4gID4gc2V0LCBhcyBpdCBvcGVyYXRlcyBp
bmRlcGVuZGVudGx5LiBBbGwgb3JpZ2luYWwgdGFncyBhbmQgYXV0aG9yDQo+ICA+IGNvbnRyaWJ1
dGlvbnMgYXJlIHJldGFpbmVkLg0KPiAgDQo+ICBJIHdvdWxkIHByZWZlciB0byBzZWUgcmVmYWN0
b3JpbmcgcGF0Y2hlcyBpbiB0aGUgY29udGV4dCBvZiB0aGUgc2VyaWVzIHRoYXQNCj4gIG1ha2Vz
IHRoZW0gbmVjZXNzYXJ5LiBBcyBpdCBzdGFuZHMsIHRoZXJlIGRvZXNuJ3QgcmVhbGx5IHNlZW0g
dG8gYmUgbXVjaA0KPiAgYmVuZWZpdCB0byB0aGlzIGNoYW5nZS4NCg0KDQpPayBubyBpc3N1ZXMu
IEp1c3QgdG8gY29uZmlybSwgeW91ciBhYm92ZSBjb21tZW50IGlzIGp1c3Qgc3BlY2lmaWMgdG8g
dGhpcyBwYXRjaA0Kb3IgYWxsIHRoZSAzIGluZGl2aWR1YWwgcGF0Y2hlcyBJIGhhZCBzZW50IGZv
ciByZXZpZXc/DQoNClRoYW5rcw0KU2FsaWwuDQo+ICANCj4gIHRoYW5rcw0KPiAgLS0gUE1NDQo=

