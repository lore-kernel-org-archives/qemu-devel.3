Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D299C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5GB-0006Z5-KK; Thu, 23 May 2024 06:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sA5G8-0006U6-4z; Thu, 23 May 2024 06:01:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sA5G5-0004Ll-3m; Thu, 23 May 2024 06:01:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlNrB2QXVz67lTC;
 Thu, 23 May 2024 17:57:14 +0800 (CST)
Received: from lhrpeml100001.china.huawei.com (unknown [7.191.160.183])
 by mail.maildlp.com (Postfix) with ESMTPS id A8FA61400CA;
 Thu, 23 May 2024 18:01:08 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 11:01:08 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Thu, 23 May 2024 11:01:08 +0100
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
 "npiggin@gmail.com" <npiggin@gmail.com>, Linuxarm <linuxarm@huawei.com>,
 Shaoqin Huang <shahuang@redhat.com>
Subject: RE: [PATCH V11 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Topic: [PATCH V11 1/8] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Index: AQHarIy1xqvYHVQ4NECnyJL8JKGWMLGkVUEAgABBiDA=
Date: Thu, 23 May 2024 10:01:08 +0000
Message-ID: <97e51bc928ad470180c836ce60ae14fe@huawei.com>
References: <20240522211111.232114-1-salil.mehta@huawei.com>
 <20240522211111.232114-2-salil.mehta@huawei.com>
 <a5f3d78e-cfed-441f-9c56-e3e78fa5edee@linux.ibm.com>
In-Reply-To: <a5f3d78e-cfed-441f-9c56-e3e78fa5edee@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.123]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

PiAgRnJvbTogSGFyc2ggUHJhdGVlayBCb3JhIDxoYXJzaHBiQGxpbnV4LmlibS5jb20+DQo+ICBT
ZW50OiBUaHVyc2RheSwgTWF5IDIzLCAyMDI0IDg6MDUgQU0NCj4gIA0KPiAgSGkgU2FsaWwsDQo+
ICANCj4gIE9uIDUvMjMvMjQgMDI6NDEsIFNhbGlsIE1laHRhIHdyb3RlOg0KPiAgPiArdm9pZCBr
dm1fcGFya192Y3B1KENQVVN0YXRlICpjcHUpOw0KPiAgPiArDQo+ICA+ICsvKioNCj4gID4gKyAq
IGt2bV91bnBhcmtfdmNwdSAtIHVucGFyayBRRU1VIEtWTSB2Q1BVIGNvbnRleHQNCj4gID4gKyAq
IEBzOiBLVk0gU3RhdGUNCj4gID4gKyAqIEBjcHU6IEFyY2hpdGVjdHVyZSB2Q1BVIElEIG9mIHRo
ZSBwYXJrZWQgdkNQVQ0KPiAgDQo+ICBzL0BjcHUvQHZjcHVpZCA/DQoNCg0KVGhhbmtzLiBXaWxs
IGZpeCB0aGlzLg0KDQpDaGVlcnMNClNhbGlsLg0KDQoNCj4gIA0KPiAgVGhhbmtzDQo+ICBIYXJz
aA0KPiAgPiArICoNCj4gID4gKyAqIEByZXR1cm5zOiBLVk0gZmQNCj4gID4gKyAqLw0KPiAgPiAr
aW50IGt2bV91bnBhcmtfdmNwdShLVk1TdGF0ZSAqcywgdW5zaWduZWQgbG9uZyB2Y3B1X2lkKTsN
Cj4gID4gICAjZW5kaWYgLyogS1ZNX0NQVVNfSCAqLw0K

