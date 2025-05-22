Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0D8C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 07:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI0We-0003mC-EY; Thu, 22 May 2025 03:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uI0WZ-0003lH-Ew; Thu, 22 May 2025 03:39:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uI0WW-0008D7-CE; Thu, 22 May 2025 03:39:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b30Wt39KYz6HJjL;
 Thu, 22 May 2025 15:38:18 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id BA5041402EE;
 Thu, 22 May 2025 15:39:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 May 2025 09:39:13 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 22 May 2025 09:39:13 +0200
To: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Donald Dutile <ddutile@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Shameer Kolothum via <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Topic: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Index: AQHbu1V0fvNxmQCU0kS/eGPfhGB2G7PFgqACgAB1wICAANEzi4AAFpHggAHGkICAAANjAIABTtRAgAALigCAAAKQAIAAEBEAgBQ92UA=
Date: Thu, 22 May 2025 07:39:13 +0000
Message-ID: <af74efba48b44ceebe5b6baa5b6de18c@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org> <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
 <3d7824d9fcf04e2e961d30a5f3404b52@huawei.com>
 <CAFEAcA-HWuAUVhqsE7p2BMo6wg+7F273Q_J2LVLrHzFagTjxgg@mail.gmail.com>
 <aB3dAPNgXj7w9-7L@redhat.com>
 <CAFEAcA-2XS3jBAzLnx9m-V_mqrJr47BsbQamTzszTPN+rmisfA@mail.gmail.com>
In-Reply-To: <CAFEAcA-2XS3jBAzLnx9m-V_mqrJr47BsbQamTzszTPN+rmisfA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSA5LCAyMDI1IDEy
OjQ0IFBNDQo+IFRvOiBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0K
PiBDYzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPjsgRG9uYWxkIER1dGlsZQ0KPiA8ZGR1dGlsZUByZWRoYXQuY29tPjsg
TWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPjsNCj4gU2hhbWVlciBLb2xvdGh1
bSB2aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IHFlbXUtDQo+IGFybUBub25nbnUub3JnOyBl
cmljLmF1Z2VyQHJlZGhhdC5jb207IGpnZ0BudmlkaWEuY29tOw0KPiBuaWNvbGluY0BudmlkaWEu
Y29tOyBuYXRoYW5jQG52aWRpYS5jb207IG1vY2hzQG52aWRpYS5jb207DQo+IHNtb3N0YWZhQGdv
b2dsZS5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpDQo+
IDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3
ZWkuY29tPjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
PjsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAx
LzZdIGh3L2FybS9zbW11djM6IEFkZCBzdXBwb3J0IHRvIGFzc29jaWF0ZSBhDQo+IFBDSWUgUkMN
Cj4gDQo+IE9uIEZyaSwgOSBNYXkgMjAyNSBhdCAxMTo0NiwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIE1heSAwOSwg
MjAyNSBhdCAxMTozNzoxNEFNICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0KPiA+ID4gKEkg
d2FudCB0byBzdGFydCBoZXJlIGJ5IHNheWluZyB0aGF0IEkgYXBwcmVjaWF0ZSB0aGF0IEknbQ0K
PiA+ID4gY29taW5nIGluIHdpdGhvdXQgaGF2aW5nIHJlYWQgdGhlIHByZXZpb3VzIGRpc2N1c3Np
b24sIHNvDQo+ID4gPiB0aGlzIGlzIGtpbmQgb2YgZ29pbmcgYmFjayBvdmVyIGdyb3VuZCB5b3Un
dmUgYWxyZWFkeQ0KPiA+ID4gYmVlbiB0aHJvdWdoLikNCj4gPiA+DQo+ID4gPiBJIGFncmVlIHRo
YXQgcmF0aGVyIHRoYW4gaGF2aW5nIGFuIGVudGlyZWx5IHNlcGFyYXRlICJTTU1VIHdpdGgNCj4g
PiA+IGFjY2VsZXJhdGlvbiIgaXQgd291bGQgYmUgYmV0dGVyIHRvIGhhdmUgaXQgYmUgYSBwcm9w
ZXJ0eSBvbg0KPiA+ID4gdGhlIFNNTVUgZGV2aWNlLiBCdXQgd2h5IGRvIHdlIG5lZWQgaXQgdG8g
YmUgdXNlciBjcmVhdGVkPw0KPiA+ID4gTWFraW5nIGl0IHVzZXItY3JlYXRlZCBsZWFkcyBpbnRv
IGFsbCBraW5kcyBvZiB0cmlja3kgYXJlYXMNCj4gPiA+IG1vc3RseSBzdXJyb3VuZGluZyB0aGUg
ZmFjdCB0aGF0IFFFTVUgcmlnaHQgbm93IHNpbXBseSBkb2Vzbid0DQo+ID4gPiBzdXBwb3J0IGhh
dmluZyB1c2VyLWNyZWF0ZWQgc3lzYnVzIGRldmljZXMgYW5kIG90aGVyIGtpbmRzDQo+ID4gPiBv
ZiBkZXZpY2Ugd2l0aCBjb21wbGV4IHdpcmluZy11cC4gLWRldmljZSBpcyByZWFsbHkgaW50ZW5k
ZWQNCj4gPiA+IGZvciAidGhpcyBpcyBhIG1vZGVsIG9mIGEgZGV2aWNlIHRoYXQgaW4gcmVhbCBo
YXJkd2FyZSBpcw0KPiA+ID4gcGx1Z2dhYmxlIGFuZCBoYXMgYmFzaWNhbGx5IG9uZSBjb25uZWN0
aW9uLCBsaWtlIGEgUENJIGNhcmQNCj4gPiA+IGhhcyBhIFBDSS1zbG90Ii4NCj4gPg0KPiA+IElu
IHRlcm1zIG9mICJ3aHkgZG9lcyBpdCBuZWVkIHRvIGJlIHVzZXIgY3JlYXRlZCIgLSB0aGUgZ29h
bCB3YXMgdG8gZXhwb3NlDQo+ID4gbXVsdGlwbGUgU01NVXMgdG8gdGhlIGd1ZXN0LCBlYWNoIGFz
c29jaWF0ZWQgd2l0aCBhIHNlcGFyYXRlIHBoeXNpY2FsDQo+IFNNTVUuDQo+ID4gSUlVQywgZWFj
aCBwaHlzaWNhbCBOVU1BIG5vZGUgd291bGQgaGF2ZSBpdHMgb3duIFNNTVUuDQo+ID4NCj4gPiBT
byBjb25maWd1cmluZyBhIGd1ZXN0IFZNIHdpbGwgcmVxdWlyZSBjcmVhdGluZyBtdWx0aXBsZSBQ
WEJzLCBvbmUgZm9yDQo+ID4gZWFjaCB2aXJ0dWFsIE5VTUEgbm9kZSwgYW5kIHRoZW4gY3JlYXRp
bmcgU01NVXMgZm9yIGVhY2ggUFhCLg0KPiA+DQo+ID4gU2luY2UgdGhlcmUgd2FzIGEgbmVlZCBm
b3IgdGhlIHVzZXIgdG8gY3JlYXRlIFNNTVVzIGZvciB0aGUgUFhCcywgdGhlDQo+ID4gcXVlc3Rp
b24gd2FzIHRoZW4gcmFpc2VkLCB3aHkgc2hvdWxkbid0IHRoZSBkZWZhdWx0IFNNTVUgYWxzbyBi
ZQ0KPiA+IHVzZXIgY3JlYXRhYmxlIGluIHRoZSBzYW1lIHdheSwgc28gdGhhdCBtZ210IGFwcHMg
bGlrZSBsaWJ2aXJ0IGhhdmUNCj4gPiBhIHNpbmdsZSB3YXkgdG8gY29uZmlndXJlIHRoZSBTTU1V
cyB3aXRoIC1kZXZpY2UuDQo+IA0KPiBTdXJlLCB0aGUgZGVmYXVsdCAidGhlcmUncyBqdXN0IG9u
ZSBwY2kgYnJpZGdlIGFuZCBlaXRoZXINCj4gbm8gU01NVSBvciBvbmUgU01NVSIgaXNuJ3QgdGhh
dCBzcGVjaWFsLiBCdXQgd2UgZG9uJ3QNCj4gaGF2ZSBnb29kIGluZnJhc3RydWN0dXJlIGZvciBj
cmVhdGluZyBzeXNidXMgZGV2aWNlcyBvbg0KPiB0aGUgY29tbWFuZCBsaW5lLCB3aGV0aGVyIGl0
J3MgdGhlIGRlZmF1bHQgU01NVSBvciB0aGUNCj4gZXh0cmEgU01NVXMgb3IgYSBVQVJUIG9yIGFu
eXRoaW5nIGVsc2UuIEkgZ3Vlc3MgdGhlDQo+IGR5bmFtaWNfc3lzYnVzIHN0dWZmIHdvcmtzLCBi
dXQgSSd2ZSBuZXZlciByZWFsbHkgbGlrZWQgaXQNCj4gKGl0J3MgYmFzaWNhbGx5ICJ0aGUgYm9h
cmQgd2lsbCBtYWdpY2FsbHkgZG8gdGhlIHJpZ2h0IHRoaW5nIiwNCj4gYW5kIHRvIHNvbWUgZXh0
ZW50IGl0J3Mgd29ya2luZyBhcm91bmQgdGhlIHdheSB3ZSBoYXZlDQo+IHZlcnkgcGF0Y2h5IHN1
cHBvcnQgZm9yICJJIHdhbnQgdG8gY29uZmlndXJlIGEgYm9hcmQgdGhlDQo+IGRldmljZSBjcmVh
dGVkIHJhdGhlciB0aGFuIGNvbmZpZ3VyaW5nIGEgZGV2aWNlIEkgYW0NCj4gY3JlYXRpbmciKS4N
Cg0KSSBhZ3JlZSB0aGF0IGhhdmluZyB1c2VycyBjcmVhdGUgc3lzYnVzIGRldmljZXMgZm9yIGEg
bWFjaGluZSBpc24ndA0KaWRlYWwuICBIb3dldmVyLCBpbiB0aGlzIGNhc2UsIHRoZSBhc3NvY2lh
dGlvbiBiZXR3ZWVuIFNNTVV2MyBhbmQNClBDSWUgbWFrZXMgdGhlIHRvcG9sb2d5IGRpZmZpY3Vs
dCB0byByZXByZXNlbnQgY2xlYW5seSBpbiBhbnkgb3RoZXIgd2F5Lg0KDQpUaGVyZSB3YXMgYSBw
cmV2aW91cyBhdHRlbXB0IGJ5IE5pY29saW4gWzBdLCB3aGVyZSB0aGUgdmlydCBtYWNoaW5lDQp3
b3VsZCBwcm9iZSBhbGwgaG9zdCBwaHlzaWNhbCBTTU1VdjMgaW5zdGFuY2VzIGFuZCBhdXRvbWF0
aWNhbGx5DQpjcmVhdGUgdGhlIGNvcnJlc3BvbmRpbmcgYXJtLXNtbXV2MyBkZXZpY2VzIGFsb25n
IHdpdGggYXNzb2NpYXRlZA0KcHhiLXBjaWUgYnJpZGdlcy4gVGhlIG1haW4gY29uY2VybiByYWlz
ZWQgd2l0aCB0aGF0IGFwcHJvYWNoIHdhcyB0aGF0DQpRRU1VIHNob3VsZG4ndCBpbXBsaWNpdGx5
IGNvbnN0cnVjdCBQQ0llIHRvcG9sb2d5IGJlaGluZCB0aGUgc2NlbmVzDQplc3BlY2lhbGx5IHdo
ZW4gaXQgY2FuIGNvbmZsaWN0IHdpdGggaG93IGxpYnZpcnQgZXhwZWN0cyB0byBkZWZpbmUgdGhl
DQpQQ0llIGhpZXJhcmNoeSBbMV0uDQoNCkFub3RoZXIgc3VnZ2VzdGlvbiB3YXMgdG8gYWRkIGFu
IGlvbW11PTxpZD4gb3B0aW9uIHRvIHRoZSBQQ0llIGJyaWRnZToNCi1kZXZpY2UgcHhiLXBjaWUs
aW9tbXU9PGlkPiwuLi4NCg0KV2l0aCB0aGlzLCB0aGUgdmlydCBtYWNoaW5lIHdvdWxkIGNyZWF0
ZSBhIG5ldyBTTU1VdjMgZGV2aWNlDQp3aGVuZXZlciBhIG5ldyBpb21tdSBJRCBpcyBlbmNvdW50
ZXJlZC4NCg0KQnV0IHRoaXMgYWxzbyBoYXMgbGltaXRhdGlvbnMsIGFzIHdlIHdhbnQgdG8gc3Vw
cG9ydCBhZGRpdGlvbmFsIG9wdGlvbnMNCmxpa2UgYWNjZWwgb3IgdmNtZHEgb24gdGhlIGNyZWF0
ZWQgU01NVXYzIGRldmljZXMuIFRoZSBtb3N0IGZsZXhpYmxlDQp3YXkgdG8gZXhwcmVzcyBzdWNo
IGNvbmZpZ3VyYXRpb25zIGlzIGRpcmVjdGx5IHZpYSB0aGUgZGV2aWNlIG1vZGVsLCBlLmcuOg0K
DQotZGV2aWNlIGFybS1zbW11djMsYWNjZWw9b24sdmNtZHE9b24sDQoNCkkgdGhpbmsgdGhpcyBp
cyBhbHNvIGNvbnNpc3RlbnQgd2l0aCBob3cgdGhlIGludGVsLWlvbW11IGRldmljZSB3b3Jrcw0K
dG9kYXkuDQoNClBsZWFzZSBsZXQgbWUga25vdyBzdWdnZXN0aW9ucyBpZiB0aGVyZSdzIGEgYmV0
dGVyIHNvbHV0aW9uIGhlcmUuIEJ1dCBpZg0KdGhlIGN1cnJlbnQgYXBwcm9hY2gg4oCUIHdoaWxl
IG5vdCBpZGVhbCDigJQgaXMgYWNjZXB0YWJsZSwgSSBjYW4gcmV3b3JrIA0KdGhlIHNlcmllcyB3
aXRoIHRoZSByZXZpZXcgY29tbWVudHMgYW5kIHBvc3QgYSB2MyBzb29uLg0KDQpQbGVhc2UgbGV0
IG1lIGtub3cuDQoNClRoYW5rcywNClNoYW1lZXINClswXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsL2NvdmVyLjE3MTkzNjExNzQuZ2l0Lm5pY29saW5jQG52aWRpYS5jb20vDQpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQUJKejYyUFZ0OWg5Nzc2RGpY
a1BZcV9NZitBVUotMFlobkRpLU9zYXFDcXJzckdTUVFAbWFpbC5nbWFpbC5jb20vDQoNCg0K

