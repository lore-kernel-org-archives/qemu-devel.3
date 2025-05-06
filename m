Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C3BC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDsQ-0002Cq-Fq; Tue, 06 May 2025 04:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCDsN-00021N-QS; Tue, 06 May 2025 04:42:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCDsK-00067e-RI; Tue, 06 May 2025 04:42:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsBhb349gz6K9jy;
 Tue,  6 May 2025 16:41:51 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id A52CF1402F1;
 Tue,  6 May 2025 16:42:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 10:42:01 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 6 May 2025 10:42:01 +0200
To: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Topic: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Index: AQHbu1V0fvNxmQCU0kS/eGPfhGB2G7O/hJOAgAXI4EA=
Date: Tue, 6 May 2025 08:42:01 +0000
Message-ID: <ea2789664ea646148d5bf565cffc039d@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <03c31d89-ad24-4470-99d0-a77e693e3ba2@redhat.com>
In-Reply-To: <03c31d89-ad24-4470-99d0-a77e693e3ba2@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9uYWxkIER1dGlsZSA8
ZGR1dGlsZUByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIE1heSAyLCAyMDI1IDc6MTcgUE0N
Cj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KPiBDYzogZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc7IGpnZ0BudmlkaWEuY29tOw0KPiBuaWNvbGluY0BudmlkaWEuY29tOyBiZXJyYW5nZUBy
ZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+IG1vY2hzQG52aWRpYS5jb207IHNtb3N0
YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3po
b3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGppYW5na3Vua3VuIDxqaWFuZ2t1
bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBo
dWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxLzZdIGh3L2FybS9zbW11djM6IEFkZCBzdXBwb3J0IHRvIGFzc29jaWF0ZSBhDQo+IFBD
SWUgUkMNCj4gDQo+IA0KPiANCj4gT24gNS8yLzI1IDY6MjcgQU0sIFNoYW1lZXIgS29sb3RodW0g
d3JvdGU6DQo+ID4gQWx0aG91Z2ggdGhpcyBjaGFuZ2UgZG9lcyBub3QgYWZmZWN0IGZ1bmN0aW9u
YWxpdHkgYXQgcHJlc2VudCwgaXQgbGF5cw0KPiA+IHRoZSBncm91bmR3b3JrIGZvciBlbmFibGlu
ZyB1c2VyLWNyZWF0ZWQgU01NVXYzIGRldmljZXMgaW4NCj4gPiBmdXR1cmUgcGF0Y2hlcw0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3NtbXV2My5jIHwg
MjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L2FybS92aXJ0LmMgICB8ICAz
ICsrLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My5jIGIvaHcvYXJtL3NtbXV2
My5jDQo+ID4gaW5kZXggYWI2Nzk3MjM1My4uNjA1ZGU5YjcyMSAxMDA2NDQNCj4gPiAtLS0gYS9o
dy9hcm0vc21tdXYzLmMNCj4gPiArKysgYi9ody9hcm0vc21tdXYzLmMNCj4gPiBAQCAtMjQsNiAr
MjQsNyBAQA0KPiA+ICAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5oIg0KPiA+ICAgI2lu
Y2x1ZGUgImh3L3FkZXYtY29yZS5oIg0KPiA+ICAgI2luY2x1ZGUgImh3L3BjaS9wY2kuaCINCj4g
PiArI2luY2x1ZGUgImh3L3BjaS9wY2lfYnJpZGdlLmgiDQo+ID4gICAjaW5jbHVkZSAiY3B1Lmgi
DQo+ID4gICAjaW5jbHVkZSAiZXhlYy90YXJnZXRfcGFnZS5oIg0KPiA+ICAgI2luY2x1ZGUgInRy
YWNlLmgiDQo+ID4gQEAgLTE4NzQsNiArMTg3NSwyNSBAQCBzdGF0aWMgdm9pZCBzbW11X3Jlc2V0
X2V4aXQoT2JqZWN0ICpvYmosDQo+IFJlc2V0VHlwZSB0eXBlKQ0KPiA+ICAgICAgIHNtbXV2M19p
bml0X3JlZ3Mocyk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBzbW11djNfcGNpZV9i
dXMoT2JqZWN0ICpvYmosIHZvaWQgKm9wYXF1ZSkNCj4gPiArew0KPiA+ICsgICAgRGV2aWNlU3Rh
dGUgKmQgPSBvcGFxdWU7DQo+ID4gKyAgICBQQ0lCdXMgKmJ1czsNCj4gPiArDQo+ID4gKyAgICBp
ZiAoIW9iamVjdF9keW5hbWljX2Nhc3Qob2JqLCBUWVBFX1BDSV9IT1NUX0JSSURHRSkpIHsNCj4g
PiArICAgICAgICByZXR1cm4gMDsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBidXMgPSBQ
Q0lfSE9TVF9CUklER0Uob2JqKS0+YnVzOw0KPiA+ICsgICAgaWYgKGQtPnBhcmVudF9idXMgJiYg
IXN0cmNtcChidXMtPnFidXMubmFtZSwgZC0+cGFyZW50X2J1cy0NCj4gPm5hbWUpKSB7DQo+ID4g
KyAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChkKSwgInByaW1hcnktYnVz
IiwgT0JKRUNUKGJ1cyksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZl
cnJvcl9hYm9ydCk7DQo+ID4gKyAgICAgICAgLyogUmV0dXJuIG5vbi16ZXJvIGFzIHdlIGdvdCB0
aGUgYnVzIGFuZCBkb24ndCBuZWVkIGZ1cnRoZXINCj4gaXRlcmF0aW9uLiovDQo+ID4gKyAgICAg
ICAgcmV0dXJuIDE7DQo+ID4gKyAgICB9DQo+ID4gKyAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+
ICsNCj4gPiAgIHN0YXRpYyB2b2lkIHNtbXVfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZCwgRXJyb3Ig
KiplcnJwKQ0KPiA+ICAgew0KPiA+ICAgICAgIFNNTVVTdGF0ZSAqc3lzID0gQVJNX1NNTVUoZCk7
DQo+ID4gQEAgLTE4ODIsNiArMTkwMiwxMCBAQCBzdGF0aWMgdm9pZCBzbW11X3JlYWxpemUoRGV2
aWNlU3RhdGUgKmQsIEVycm9yDQo+ICoqZXJycCkNCj4gPiAgICAgICBTeXNCdXNEZXZpY2UgKmRl
diA9IFNZU19CVVNfREVWSUNFKGQpOw0KPiA+ICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxM
Ow0KPiA+DQo+ID4gKyAgICBpZiAoIW9iamVjdF9wcm9wZXJ0eV9nZXRfbGluayhPQkpFQ1QoZCks
ICJwcmltYXJ5LWJ1cyIsICZlcnJvcl9hYm9ydCkpDQo+IHsNCj4gPiArICAgICAgICBvYmplY3Rf
Y2hpbGRfZm9yZWFjaF9yZWN1cnNpdmUob2JqZWN0X2dldF9yb290KCksDQo+IHNtbXV2M19wY2ll
X2J1cywgZCk7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICAgICAgIGMtPnBhcmVudF9yZWFsaXpl
KGQsICZsb2NhbF9lcnIpOw0KPiA+ICAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4gPiAgICAgICAg
ICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+ID4gQEAgLTE5OTYsNiArMjAy
MCw4IEBAIHN0YXRpYyB2b2lkIHNtbXV2M19jbGFzc19pbml0KE9iamVjdENsYXNzDQo+ICprbGFz
cywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgICAgICBkZXZpY2VfY2xhc3Nfc2V0X3BhcmVudF9y
ZWFsaXplKGRjLCBzbW11X3JlYWxpemUsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmYy0+cGFyZW50X3JlYWxpemUpOw0KPiA+ICAgICAgIGRldmljZV9jbGFzc19z
ZXRfcHJvcHMoZGMsIHNtbXV2M19wcm9wZXJ0aWVzKTsNCj4gPiArICAgIGRjLT5ob3RwbHVnZ2Fi
bGUgPSBmYWxzZTsNCj4gPiArICAgIGRjLT5idXNfdHlwZSA9IFRZUEVfUENJRV9CVVM7DQo+IERv
ZXMgdGhpcyBmb3JjZSBsZWdhY3kgU01NVXYzIHRvIGJlIHRpZWQgdG8gYSBQQ0llIGJ1cyBub3c/
DQo+IGlmIHNvLCB3aWxsIHRoYXQgYnJlYWsgc29tZSBleGlzdGluZyBsZWdhY3kgc21tdXYzIGNv
bmZpZ3M/LCBpLmUuLCB2aXJ0aW8tc2NzaQ0KPiBhdHRhY2hlZCB0byBhIGxlZ2FjeSBzbW11djMu
DQoNCk5vLiBJdCB3b24ndCBicmVhayB0aGUgZXhpc3RpbmcgY29uZmlnIGFzIEVyaWMgaGFzIGFs
cmVhZHkgcmVwbGllZC4gVGhlIG9ubHkgZGlmZmVyZW5jZSBpcw0KYXMgRXJpYyByaWdodGx5IHBv
aW50ZWQgb3V0LCBTTU1VdjMgaXMgYSBwbGF0Zm9ybSBkZXZpY2UgYW5kIHdlIGFyZSBzcGVjaWZ5
aW5nDQp0aGUgZGV2aWNlIGJ1cyB0eXBlIGFzIFBDSUUsIHdoaWNoIGlzIGEgYml0IG9kZC4gVGhl
IGluaXRpYWwgUkZDIHdhcyB3aXRoIGEgc3BlY2lmaWMNCiJwY2ktYnVzIiBhcyBjb21tYW5kIGxp
bmUgb3B0aW9uICwgaWUsDQoNCi1kZXZpY2UgYXJtLXNtbXV2MywgcGNpLWJ1cz1wY2llMCwuLi4N
Cg0KYW5kIHRoZW4gdGhlcmUgd2VyZSBmZWVkYmFja3MgdGhhdCBpdCBpcyBtb3JlIGludHVpdGl2
ZSBhbmQgbWFrZXMgbGlmZSBlYXN5IHdpdGggDQpsaWJ2aXJ0IGlmIHdlIGNhbiB1c2UgdGhlIFFl
bXUgZGV2aWNlICJidXMiIG9wdGlvbiBhbmQgaGVuY2UgdGhlIGNoYW5nZS4NCg0KVGhhbmtzLA0K
U2hhbWVlcg0KDQoNCg0K

