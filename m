Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDA9CFD2FD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szBuI-00059R-S3; Fri, 11 Oct 2024 05:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1szBuH-000590-73; Fri, 11 Oct 2024 05:25:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1szBuD-00038e-HF; Fri, 11 Oct 2024 05:25:56 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XQ1Mb4d0yz6L6v2;
 Fri, 11 Oct 2024 17:21:15 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id A831B1401DC;
 Fri, 11 Oct 2024 17:25:37 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 11:25:37 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 11 Oct 2024 11:25:37 +0200
To: Miguel Luis <miguel.luis@oracle.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Marc Zyngier
 <maz@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Eric Auger
 <eric.auger@redhat.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, Karl Heubaum
 <karl.heubaum@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, 
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Subject: RE: [PATCH RFC V4 02/33] cpu-common: Add common CPU utility for
 possible vCPUs
Thread-Topic: [PATCH RFC V4 02/33] cpu-common: Add common CPU utility for
 possible vCPUs
Thread-Index: AQHbGfopZ5IUB0O0GU6Y/nBjXXT62LJ/8QuAgAFVrYA=
Date: Fri, 11 Oct 2024 09:25:37 +0000
Message-ID: <7f8a346a478e453f9d69eb1e10a80c36@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
 <20241009031815.250096-3-salil.mehta@huawei.com>
 <23D4A389-FEB6-4C24-93B5-2D775F208390@oracle.com>
In-Reply-To: <23D4A389-FEB6-4C24-93B5-2D775F208390@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.149.195]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SEkgTWlndWVsLA0KDQo+ICBGcm9tOiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNv
bT4NCj4gIFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDEwLCAyMDI0IDM6NDcgUE0NCj4gIFRvOiBT
YWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIA0KPiAgSGkgU2FsaWwsDQo+
ICANCj4gID4gT24gOSBPY3QgMjAyNCwgYXQgMDM6MTcsIFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0
YUBodWF3ZWkuY29tPiB3cm90ZToNCj4gID4NCj4gID4gVGhpcyBwYXRjaCBhZGRzIHZhcmlvdXMg
dXRpbGl0eSBmdW5jdGlvbnMgdGhhdCBtYXkgYmUgcmVxdWlyZWQgdG8NCj4gID4gZmV0Y2ggb3Ig
Y2hlY2sgdGhlIHN0YXRlIG9mIHBvc3NpYmxlIHZDUFVzLiBJdCBhbHNvIGludHJvZHVjZXMgdGhl
DQo+ICA+IGNvbmNlcHQgb2YgKmRpc2FibGVkKiB2Q1BVcywgd2hpY2ggYXJlIHBhcnQgb2YgdGhl
ICpwb3NzaWJsZSogdkNQVXMNCj4gID4gYnV0IGFyZSBub3QgZW5hYmxlZC4gVGhpcyBzdGF0ZSB3
aWxsIGJlIHVzZWQgZHVyaW5nIG1hY2hpbmUNCj4gID4gaW5pdGlhbGl6YXRpb24gYW5kIGxhdGVy
IGR1cmluZyB0aGUgcGx1Z2dpbmcgb3IgdW5wbHVnZ2luZyBvZiB2Q1BVcy4gV2UNCj4gIHJlbGVh
c2UgdGhlIFFPTSBDUFUgb2JqZWN0cyBmb3IgYWxsIGRpc2FibGVkIHZDUFVzLg0KPiAgPg0KPiAg
PiBDby1kZXZlbG9wZWQtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4g
ID4gU2lnbmVkLW9mZi1ieTogS2VxaWFuIFpodSA8emh1a2VxaWFuMUBodWF3ZWkuY29tPg0KPiAg
PiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4g
ID4gLS0tDQo+ICA+IGNwdS1jb21tb24uYyAgICAgICAgICB8IDIxICsrKysrKysrKysrKysrKysr
KysrDQo+ICA+IGluY2x1ZGUvaHcvY29yZS9jcHUuaCB8IDQ2DQo+ICArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICA+IDIgZmlsZXMgY2hhbmdlZCwgNjcgaW5z
ZXJ0aW9ucygrKQ0KPiAgPg0KPiAgPiBkaWZmIC0tZ2l0IGEvY3B1LWNvbW1vbi5jIGIvY3B1LWNv
bW1vbi5jIGluZGV4IDZiMjYyMjMzYTMuLjRhNDQ2ZjZmN2YNCj4gID4gMTAwNjQ0DQo+ICA+IC0t
LSBhL2NwdS1jb21tb24uYw0KPiAgPiArKysgYi9jcHUtY29tbW9uLmMNCj4gID4gQEAgLTI0LDYg
KzI0LDcgQEANCj4gID4gI2luY2x1ZGUgInN5c2VtdS9jcHVzLmgiDQo+ICA+ICNpbmNsdWRlICJx
ZW11L2xvY2thYmxlLmgiDQo+ICA+ICNpbmNsdWRlICJ0cmFjZS90cmFjZS1yb290LmgiDQo+ICA+
ICsjaW5jbHVkZSAiaHcvYm9hcmRzLmgiDQo+ICA+DQo+ICA+IFFlbXVNdXRleCBxZW11X2NwdV9s
aXN0X2xvY2s7DQo+ICA+IHN0YXRpYyBRZW11Q29uZCBleGNsdXNpdmVfY29uZDsNCj4gID4gQEAg
LTEwOCw2ICsxMDksMjYgQEAgdm9pZCBjcHVfbGlzdF9yZW1vdmUoQ1BVU3RhdGUgKmNwdSkNCj4g
ID4gICAgIGNwdV9saXN0X2dlbmVyYXRpb25faWQrKzsNCj4gID4gfQ0KPiAgPg0KPiAgPiArQ1BV
U3RhdGUgKnFlbXVfZ2V0X3Bvc3NpYmxlX2NwdShpbnQgaW5kZXgpIHsNCj4gID4gKyAgICBNYWNo
aW5lU3RhdGUgKm1zID0gTUFDSElORShxZGV2X2dldF9tYWNoaW5lKCkpOw0KPiAgPiArICAgIGNv
bnN0IENQVUFyY2hJZExpc3QgKnBvc3NpYmxlX2NwdXMgPSBtcy0+cG9zc2libGVfY3B1czsNCj4g
ID4gKw0KPiAgPiArICAgIGFzc2VydCgoaW5kZXggPj0gMCkgJiYgKGluZGV4IDwgcG9zc2libGVf
Y3B1cy0+bGVuKSk7DQo+ICA+ICsNCj4gID4gKyAgICByZXR1cm4gQ1BVKHBvc3NpYmxlX2NwdXMt
PmNwdXNbaW5kZXhdLmNwdSk7DQo+ICA+ICt9DQo+ICA+ICsNCj4gID4gK2Jvb2wgcWVtdV9wcmVz
ZW50X2NwdShDUFVTdGF0ZSAqY3B1KQ0KPiAgPiArew0KPiAgPiArICAgIHJldHVybiBjcHU7DQo+
ICANCj4gIEkgZG9u4oCZdCBmZWVsIHFlbXVfcHJlc2VudF9jcHUgc2hvdWxkIGJlIG5lZWRlZCBh
cyBjcHVzIGFyZSBpbXBsaWNpdGx5DQo+ICBwcmVzZW50IGFzIGFuIGluaXRpYWxpemF0aW9uIHBy
ZW1pc2UgYW5kIGFybS92aXJ0IGJlaW5nIHRoZSBvbmx5IHVzZXIgb2YgdGhpcw0KPiAgbm93Lg0K
DQoNClllcywgYXMgZXhwbGFpbmVkIHRvIHlvdSBlYXJsaWVyIHRoZXJlIGlzIGEgaGlzdG9yeSB0
byBpdC4gSW4gdGhlIGVhcmxpZXIgcHJvdG95cGVzLA0KSSB3YXMgcGxhbm5pbmcgdG8gaGlkZSB0
aGUgcGVyc2lzdGVuY2Ugb2YgdGhlIHZDUFUgb2JqZWN0IGJlaGluZCB0aGlzIGZ1bmN0aW9uDQpi
dXQgdGhlbiB0aGUgc2FtZSBmdW5jdGlvbiB3YXMgYWxzbyBiZWluZyB1c2VkIGF0IG90aGVyIHBs
YWNlIHdpdGhpbiB0aGUgY29kZQ0KbGlrZSBHSUN2My4gTGF0ZXIsIEkgaW50cm9kdWNlZCBxZW11
X2VuYWJsZWRfY3B1KCkgYW5kIGFjcGlfcGVyc2lzdGVudF9jcHUoKQ0KcmVhbGl6aW5nIHRoYXQg
cGVyc2lzdGVuY2Ugb2YgdkNQVSBpcyBvbmx5IHJlcXVpcmVkIGF0IHRoZSBBQ1BJIGxldmVsLiBB
bmQgaGVuY2UNCmdvdCBhd2F5IHdpdGggbW9zdCBvZiB0aGUgcWVtdV9wcmVzZW50X2NwdSgpIHVz
YWdlcy4NCg0KR2F2aW4gYWxzbyBjb21tZW50ZWQgb24gdGhpcyBlYXJsaWVyLiBNYXliZSB3ZSBj
YW4gZGVwcmVjYXRlIGl0Lg0KDQoNClRoYW5rcw0KU2FsaWwuDQoNCg0KPiAgDQo+ICBUaGFua3MN
Cj4gIE1pZ3VlbA0KPiAgDQo+ICA+ICt9DQo+ICA+ICsNCj4gID4gK2Jvb2wgcWVtdV9lbmFibGVk
X2NwdShDUFVTdGF0ZSAqY3B1KQ0KPiAgPiArew0KPiAgPiArICAgIHJldHVybiBjcHUgJiYgIWNw
dS0+ZGlzYWJsZWQ7DQo+ICA+ICt9DQo+ICA+ICsNCj4gID4gQ1BVU3RhdGUgKnFlbXVfZ2V0X2Nw
dShpbnQgaW5kZXgpDQo+ICA+IHsNCj4gID4gICAgIENQVVN0YXRlICpjcHU7DQo+ICA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2h3L2NvcmUvY3B1LmggYi9pbmNsdWRlL2h3L2NvcmUvY3B1LmggaW5k
ZXgNCj4gID4gMWM5Yzc3NWRmNi4uNzNhNGU0Y2NlMSAxMDA2NDQNCj4gID4gLS0tIGEvaW5jbHVk
ZS9ody9jb3JlL2NwdS5oDQo+ICA+ICsrKyBiL2luY2x1ZGUvaHcvY29yZS9jcHUuaA0KPiAgPiBA
QCAtNTM4LDYgKzUzOCwyMCBAQCBzdHJ1Y3QgQ1BVU3RhdGUgew0KPiAgPiAgICAgQ1BVUGx1Z2lu
U3RhdGUgKnBsdWdpbl9zdGF0ZTsNCj4gID4gI2VuZGlmDQo+ICA+DQo+ICA+ICsgICAgLyoNCj4g
ID4gKyAgICAgKiBJbiB0aGUgZ3Vlc3Qga2VybmVsLCB0aGUgcHJlc2VuY2Ugb2YgdkNQVXMgaXMg
ZGV0ZXJtaW5lZCBieQ0KPiAgaW5mb3JtYXRpb24NCj4gID4gKyAgICAgKiBwcm92aWRlZCBieSB0
aGUgVk1NIG9yIGZpcm13YXJlIHZpYSB0aGUgQUNQSSBNQURUIGF0IGJvb3QgdGltZS4NCj4gIFNv
bWUNCj4gID4gKyAgICAgKiBhcmNoaXRlY3R1cmVzIGRvIG5vdCBhbGxvdyBtb2RpZmljYXRpb25z
IHRvIHRoaXMgY29uZmlndXJhdGlvbiBhZnRlcg0KPiAgPiArICAgICAqIHRoZSBndWVzdCBoYXMg
Ym9vdGVkLiBUaGVyZWZvcmUsIGZvciBzdWNoIGFyY2hpdGVjdHVyZXMsDQo+ICBob3RwbHVnZ2Fi
bGUNCj4gID4gKyAgICAgKiB2Q1BVcyBhcmUgZXhwb3NlZCBieSB0aGUgVk1NIGFzIG5vdCAnQUNQ
SSBFbmFibGVkJyB0byB0aGUga2VybmVsLg0KPiAgPiArICAgICAqIFdpdGhpbiBRRU1VLCBzdWNo
IHZDUFVzICh0aG9zZSB0aGF0IGFyZSAneWV0LXRvLWJlLXBsdWdnZWQnIG9yDQo+ICBoYXZlDQo+
ICA+ICsgICAgICogYmVlbiBob3QtdW5wbHVnZ2VkKSBtYXkgZWl0aGVyIGhhdmUgYSBgQ1BVU3Rh
dGVgIG9iamVjdCBpbiBhDQo+ICAnZGlzYWJsZWQnDQo+ICA+ICsgICAgICogc3RhdGUgb3IgbWF5
IG5vdCBoYXZlIGEgYENQVVN0YXRlYCBvYmplY3QgYXQgYWxsLg0KPiAgPiArICAgICAqDQo+ICA+
ICsgICAgICogQnkgZGVmYXVsdCwgYENQVVN0YXRlYCBvYmplY3RzIGFyZSBlbmFibGVkIGFjcm9z
cyBhbGwgYXJjaGl0ZWN0dXJlcy4NCj4gID4gKyAgICAgKi8NCj4gID4gKyAgICBib29sIGRpc2Fi
bGVkOw0KPiAgPiArDQo+ICA+ICAgICAvKiBUT0RPIE1vdmUgY29tbW9uIGZpZWxkcyBmcm9tIENQ
VUFyY2hTdGF0ZSBoZXJlLiAqLw0KPiAgPiAgICAgaW50IGNwdV9pbmRleDsNCj4gID4gICAgIGlu
dCBjbHVzdGVyX2luZGV4Ow0KPiAgPiBAQCAtOTI0LDYgKzkzOCwzOCBAQCBzdGF0aWMgaW5saW5l
IGJvb2wgY3B1X2luX2V4Y2x1c2l2ZV9jb250ZXh0KGNvbnN0DQo+ICA+IENQVVN0YXRlICpjcHUp
ICAqLyBDUFVTdGF0ZSAqcWVtdV9nZXRfY3B1KGludCBpbmRleCk7DQo+ICA+DQo+ICA+ICsvKioN
Cj4gID4gKyAqIHFlbXVfZ2V0X3Bvc3NpYmxlX2NwdToNCj4gID4gKyAqIEBpbmRleDogVGhlIENQ
VVN0YXRlQGNwdV9pbmRleCB2YWx1ZSBvZiB0aGUgQ1BVIHRvIG9idGFpbi4NCj4gID4gKyAqICAg
ICAgICAgSW5wdXQgaW5kZXggTVVTVCBiZSBpbiByYW5nZSBbMCwgTWF4IFBvc3NpYmxlIENQVXMp
DQo+ICA+ICsgKg0KPiAgPiArICogSWYgQ1BVU3RhdGUgb2JqZWN0IGV4aXN0cyx0aGVuIGl0IGdl
dHMgYSBDUFUgbWF0Y2hpbmcNCj4gID4gKyAqIEBpbmRleCBpbiB0aGUgcG9zc2libGUgQ1BVIGFy
cmF5Lg0KPiAgPiArICoNCj4gID4gKyAqIFJldHVybnM6IFRoZSBwb3NzaWJsZSBDUFUgb3IgJU5V
TEwgaWYgQ1BVIGRvZXMgbm90IGV4aXN0Lg0KPiAgPiArICovDQo+ICA+ICtDUFVTdGF0ZSAqcWVt
dV9nZXRfcG9zc2libGVfY3B1KGludCBpbmRleCk7DQo+ICA+ICsNCj4gID4gKy8qKg0KPiAgPiAr
ICogcWVtdV9wcmVzZW50X2NwdToNCj4gID4gKyAqIEBjcHU6IFRoZSB2Q1BVIHRvIGNoZWNrDQo+
ICA+ICsgKg0KPiAgPiArICogQ2hlY2tzIGlmIHRoZSB2Q1BVIGlzIGFtb25nc3QgdGhlIHByZXNl
bnQgcG9zc2libGUgdmNwdXMuDQo+ICA+ICsgKg0KPiAgPiArICogUmV0dXJuczogVHJ1ZSBpZiBp
dCBpcyBwcmVzZW50IHBvc3NpYmxlIHZDUFUgZWxzZSBmYWxzZSAgKi8gYm9vbA0KPiAgPiArcWVt
dV9wcmVzZW50X2NwdShDUFVTdGF0ZSAqY3B1KTsNCj4gID4gKw0KPiAgPiArLyoqDQo+ICA+ICsg
KiBxZW11X2VuYWJsZWRfY3B1Og0KPiAgPiArICogQGNwdTogVGhlIHZDUFUgdG8gY2hlY2sNCj4g
ID4gKyAqDQo+ICA+ICsgKiBDaGVja3MgaWYgdGhlIHZDUFUgaXMgZW5hYmxlZC4NCj4gID4gKyAq
DQo+ICA+ICsgKiBSZXR1cm5zOiBUcnVlIGlmIGl0IGlzICdlbmFibGVkJyBlbHNlIGZhbHNlICAq
LyBib29sDQo+ICA+ICtxZW11X2VuYWJsZWRfY3B1KENQVVN0YXRlICpjcHUpOw0KPiAgPiArDQo+
ICA+IC8qKg0KPiAgPiAgKiBjcHVfZXhpc3RzOg0KPiAgPiAgKiBAaWQ6IEd1ZXN0LWV4cG9zZWQg
Q1BVIElEIHRvIGxvb2t1cC4NCj4gID4gLS0NCj4gID4gMi4zNC4xDQo+ICA+DQoNCg==

