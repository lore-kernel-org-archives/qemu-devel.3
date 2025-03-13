Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC0DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdd0-0001Wo-A8; Thu, 13 Mar 2025 04:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsdcw-0001W7-VN; Thu, 13 Mar 2025 04:09:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsdct-0008Sl-JG; Thu, 13 Mar 2025 04:09:14 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD0QT5qZrz6J6FS;
 Thu, 13 Mar 2025 16:04:33 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 1DA791403A8;
 Thu, 13 Mar 2025 16:09:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 09:09:04 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 13 Mar 2025 09:09:04 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 07/20] hw/arm/smmu-common: Introduce callbacks for
 PCIIOMMUOps
Thread-Topic: [RFC PATCH v2 07/20] hw/arm/smmu-common: Introduce callbacks for
 PCIIOMMUOps
Thread-Index: AQHbkqnXk2A5Q1HeeUCFKLsnwwQVo7NvoCEAgAEVsnA=
Date: Thu, 13 Mar 2025 08:09:04 +0000
Message-ID: <2606bc1d06f24495a8f382b3d1af3fc6@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-8-shameerali.kolothum.thodi@huawei.com>
 <fe047856-b564-4776-8651-daa65c02133b@redhat.com>
In-Reply-To: <fe047856-b564-4776-8651-daa65c02133b@redhat.com>
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIs
IDIwMjUgNDoyNCBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4g
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpn
Z0BudmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207
IGJlcnJhbmdlQHJlZGhhdC5jb207IG5hdGhhbmNAbnZpZGlhLmNvbTsNCj4gbW9jaHNAbnZpZGlh
LmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5j
b20+OyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4gamlhbmdrdW5r
dW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhh
bi5jYW1lcm9uQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1JGQyBQQVRDSCB2MiAwNy8yMF0gaHcvYXJtL3NtbXUtY29tbW9uOiBJbnRyb2R1Y2UN
Cj4gY2FsbGJhY2tzIGZvciBQQ0lJT01NVU9wcw0KPiANCj4gDQo+IA0KPiANCj4gT24gMy8xMS8y
NSAzOjEwIFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IFN1YnNlcXVlbnRseSBzbW11
djMtYWNjZWwgd2lsbCBwcm92aWRlwqB0aGVzZSBjYWxsYmFja3MNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVh
d2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3NtbXUtY29tbW9uLmMgICAgICAgICB8IDI3
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2h3L2FybS9zbW11LWNv
bW1vbi5oIHwgIDUgKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXUtY29tbW9uLmMgYi9ody9hcm0vc21t
dS1jb21tb24uYyBpbmRleA0KPiA+IDgzYzA2OTNmNWEuLjlmZDQ1NWJhYTAgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvYXJtL3NtbXUtY29tbW9uLmMNCj4gPiArKysgYi9ody9hcm0vc21tdS1jb21tb24u
Yw0KPiA+IEBAIC04NjUsNiArODY1LDEwIEBAIHN0YXRpYyBBZGRyZXNzU3BhY2UgKnNtbXVfZmlu
ZF9hZGRfYXMoUENJQnVzDQo+ICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuKQ0KPiA+ICAg
ICAgU01NVVN0YXRlICpzID0gb3BhcXVlOw0KPiA+ICAgICAgU01NVVBjaUJ1cyAqc2J1cyA9IHNt
bXVfZ2V0X3NidXMocywgYnVzKTsNCj4gPg0KPiA+ICsgICAgaWYgKHMtPmFjY2VsICYmIHMtPmdl
dF9hZGRyZXNzX3NwYWNlKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIHMtPmdldF9hZGRyZXNzX3Nw
YWNlKGJ1cywgb3BhcXVlLCBkZXZmbik7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiB3aHkgZG8gd2Ug
cmVxdWlyZSB0aGF0IG5ldyBjYWxsIHNpdGU/IFRoaXMgbmVlZHMgdG8gYmUgZG9jdW1lbnRlZCBp
biB0aGUNCj4gY29tbWl0IG1zZyBlc3AuIGJlY2F1c2Ugd2UgZG9uJ3Qga25vdyB3aGF0IHRoaXMg
Y2Igd2lsbCBkby4NCg0KQ3VycmVudGx5LCB0aGlzIGlzIHdoZXJlIHRoZSBmaXJzdCB0aW1lIFNN
TVVEZXZpY2Ugc2RldiBpcyBhbGxvY2F0ZWQuIEFuZCBmb3Igc21tdXYzLWFjY2VsDQpjYXNlcyB3
ZSBhcmUgaW50cm9kdWNpbmcgYSBuZXcgU01NVXYzQWNjZWxEZXZpY2UgYWNjZWxfZGV2IGZvciBo
b2xkaW5nIGFkZGl0aW9uYWwNCmFjY2VsIHNwZWNpZmljIGluZm9ybWF0aW9uLiBJbiBvcmRlciB0
byBkbyB0aGF0IHRoZSBhYm92ZSBjYiBpcyB1c2VkLiBTYW1lIGZvciBvdGhlciBjYWxsYmFja3MN
CmFzIHdlbGwuDQoNCkFub3RoZXIgd2F5IG9mIGF2b2lkaW5nIHRoZSBjYWxsYmFja3Mgd291bGQg
YmUgdG8gIG1vdmUgdGhlIHBjaV9zZXR1cF9pb21tdShidXMsIG9wcykgDQpjYWxsIGZyb20gdGhl
IHNtbXUtY29tbW9uLmMgdG8gc21tdXYzL3NtbXV2My1hY2NlbCBhbmQgaGFuZGxlIGl0IGRpcmVj
dGx5IHRoZXJlLg0KDQpPciBpcyB0aGVyZSBhIGJldHRlciBpZGVhPw0KDQo+ID4gICAgICBzZGV2
ID0gc2J1cy0+cGJkZXZbZGV2Zm5dOw0KPiA+ICAgICAgaWYgKCFzZGV2KSB7DQo+ID4gICAgICAg
ICAgc2RldiA9IHNidXMtPnBiZGV2W2RldmZuXSA9IGdfbmV3MChTTU1VRGV2aWNlLCAxKTsgQEAg
LTg3NCw4DQo+ID4gKzg3OCwzMSBAQCBzdGF0aWMgQWRkcmVzc1NwYWNlICpzbW11X2ZpbmRfYWRk
X2FzKFBDSUJ1cyAqYnVzLCB2b2lkDQo+ICpvcGFxdWUsIGludCBkZXZmbikNCj4gPiAgICAgIHJl
dHVybiAmc2Rldi0+YXM7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCBzbW11X2Rldl9z
ZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsDQo+IGludCBkZXZmbiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZp
Y2UgKmhpb2QsIEVycm9yDQo+ID4gKyoqZXJycCkgew0KPiA+ICsgICAgU01NVVN0YXRlICpzID0g
b3BhcXVlOw0KPiA+ICsNCj4gPiArICAgIGlmIChzLT5hY2NlbCAmJiBzLT5zZXRfaW9tbXVfZGV2
aWNlKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIHMtPnNldF9pb21tdV9kZXZpY2UoYnVzLCBvcGFx
dWUsIGRldmZuLCBoaW9kLCBlcnJwKTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICByZXR1
cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHNtbXVfZGV2X3Vuc2V0
X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLA0KPiA+ICtpbnQgZGV2Zm4p
IHsNCj4gPiArICAgIFNNTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiArDQo+ID4gKyAgICBpZiAo
cy0+YWNjZWwgJiYgcy0+dW5zZXRfaW9tbXVfZGV2aWNlKSB7DQo+ID4gKyAgICAgICAgcy0+dW5z
ZXRfaW9tbXVfZGV2aWNlKGJ1cywgb3BhcXVlLCBkZXZmbik7DQo+ID4gKyAgICB9DQo+ID4gK30N
Cj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBQQ0lJT01NVU9wcyBzbW11X29wcyA9IHsNCj4gPiAg
ICAgIC5nZXRfYWRkcmVzc19zcGFjZSA9IHNtbXVfZmluZF9hZGRfYXMsDQo+ID4gKyAgICAuc2V0
X2lvbW11X2RldmljZSA9IHNtbXVfZGV2X3NldF9pb21tdV9kZXZpY2UsDQo+ID4gKyAgICAudW5z
ZXRfaW9tbXVfZGV2aWNlID0gc21tdV9kZXZfdW5zZXRfaW9tbXVfZGV2aWNlLA0KPiA+ICB9Ow0K
PiA+DQo+ID4gIFNNTVVEZXZpY2UgKnNtbXVfZmluZF9zZGV2KFNNTVVTdGF0ZSAqcywgdWludDMy
X3Qgc2lkKSBkaWZmIC0tZ2l0DQo+ID4gYS9pbmNsdWRlL2h3L2FybS9zbW11LWNvbW1vbi5oIGIv
aW5jbHVkZS9ody9hcm0vc21tdS1jb21tb24uaA0KPiBpbmRleA0KPiA+IDgwZmYyZWY2YWEuLjdi
MDU2NDAxNjcgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9hcm0vc21tdS1jb21tb24uaA0K
PiA+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL3NtbXUtY29tbW9uLmgNCj4gPiBAQCAtMTYwLDYgKzE2
MCwxMSBAQCBzdHJ1Y3QgU01NVVN0YXRlIHsNCj4gPg0KPiA+ICAgICAgLyogRm9yIHNtbXV2My1h
Y2NlbCAqLw0KPiA+ICAgICAgYm9vbCBhY2NlbDsNCj4gPiArDQo+ID4gKyAgICBBZGRyZXNzU3Bh
Y2UgKiAoKmdldF9hZGRyZXNzX3NwYWNlKShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQN
Cj4gZGV2Zm4pOw0KPiA+ICsgICAgYm9vbCAoKnNldF9pb21tdV9kZXZpY2UpKFBDSUJ1cyAqYnVz
LCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBIb3N0SU9NTVVEZXZpY2UgKmRldiwgRXJyb3IgKiplcnJwKTsNCj4gPiArICAgIHZvaWQg
KCp1bnNldF9pb21tdV9kZXZpY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZm
bik7DQo+IEkgdGhpbmsgdGhpcyBzaG91bGQgYmUgZXhwb3NlZCBieSBhIGNsYXNzIGFuZCBvbmx5
IGltcGxlbWVudGVkIGluIHRoZQ0KPiBzbW11djMgYWNjZWwgZGV2aWNlLiBBZGRpbmcgdGhvc2Ug
Y2JzIGRpcmVjdGx5IGluIHRoZSBTdGF0ZSBsb29rcyBub3QgdGhlDQo+IHN0ZCB3YXkuDQoNCk9r
LiBZb3UgbWVhbiB3ZSBjYW4gZGlyZWN0bHkgcGxhY2UgIFBDSUlPTU1VT3BzICpvcHMgaGVyZSB0
aGVuPyANCg0KVGhhbmtzLA0KU2hhbWVlcg0K

