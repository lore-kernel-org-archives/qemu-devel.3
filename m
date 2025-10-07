Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF3ECCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 10:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64iQ-0005KR-9e; Tue, 07 Oct 2025 06:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v64i4-00056B-9K; Tue, 07 Oct 2025 06:14:23 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v64hz-0005i7-MG; Tue, 07 Oct 2025 06:14:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgsR92RKHz6K611;
 Tue,  7 Oct 2025 18:13:25 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (unknown [7.214.147.1])
 by mail.maildlp.com (Postfix) with ESMTPS id 32AD01400D9;
 Tue,  7 Oct 2025 18:14:01 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml500004.china.huawei.com (7.214.147.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Oct 2025 11:14:00 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 7 Oct 2025 11:14:00 +0100
To: Richard Henderson <richard.henderson@linaro.org>, "salil.mehta@opnsrc.net"
 <salil.mehta@opnsrc.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
Subject: RE: [PATCH RFC V6 24/24] tcg: Defer TB flush for 'lazy realized'
 vCPUs on first region alloc
Thread-Topic: [PATCH RFC V6 24/24] tcg: Defer TB flush for 'lazy realized'
 vCPUs on first region alloc
Thread-Index: AQHcMm8thab5icRQDUiueWrRPyo9/bStwJoAgADuznCAAEDrAIAHiv6g
Date: Tue, 7 Oct 2025 10:14:00 +0000
Message-ID: <524d3e6e5f44438285b1a74d4bbb933e@huawei.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-25-salil.mehta@opnsrc.net>
 <60631203-626f-4628-8a40-226bd45d1c8e@linaro.org>
 <bc780e0c68fa44da975d8f6fcdb38cd7@huawei.com>
 <7605b216-8aa1-4897-a96e-6ed9953f4e91@linaro.org>
In-Reply-To: <7605b216-8aa1-4897-a96e-6ed9953f4e91@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.146.151]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgUmljaGFyZCwNCg0KU29ycnkgZm9yIHRoZSBkZWxheSBpbiByZXBseS4gDQoNCj4gRnJvbTog
UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDIsIDIwMjUgNDo0MSBQTQ0KPiANCj4gT24gMTAvMi8yNSAwNToy
NywgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4gSGkgUmljaGFyZCwNCj4gPg0KPiA+IFRoYW5rcyBm
b3IgdGhlIHJlcGx5LiBQbGVhc2UgZmluZCBteSByZXNwb25zZSBpbmxpbmUuDQo+ID4NCj4gPiBD
aGVlcnMuDQo+ID4NCj4gPj4gRnJvbTogcWVtdS1kZXZlbC1ib3VuY2VzK3NhbGlsLm1laHRhPWh1
YXdlaS5jb21Abm9uZ251Lm9yZw0KPiA8cWVtdS0NCj4gPj4gZGV2ZWwtYm91bmNlcytzYWxpbC5t
ZWh0YT1odWF3ZWkuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZg0KPiBSaWNoYXJkDQo+ID4+
IEhlbmRlcnNvbg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMSwgMjAyNSAxMDozNCBQ
TQ0KPiA+PiBUbzogc2FsaWwubWVodGFAb3Buc3JjLm5ldDsgcWVtdS1kZXZlbEBub25nbnUub3Jn
OyBxZW11LQ0KPiA+PiBhcm1Abm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb20NCj4gPj4gU3ViamVj
dDogUmU6IFtQQVRDSCBSRkMgVjYgMjQvMjRdIHRjZzogRGVmZXIgVEIgZmx1c2ggZm9yICdsYXp5
DQo+ID4+IHJlYWxpemVkJyB2Q1BVcyBvbiBmaXJzdCByZWdpb24gYWxsb2MNCj4gPj4NCj4gPj4g
T24gOS8zMC8yNSAxODowMSwgc2FsaWwubWVodGFAb3Buc3JjLm5ldCB3cm90ZToNCj4gPj4+IEZy
b206IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiA+Pj4NCj4gPj4+IFRo
ZSBUQ0cgY29kZSBjYWNoZSBpcyBzcGxpdCBpbnRvIHJlZ2lvbnMgc2hhcmVkIGJ5IHZDUFVzIHVu
ZGVyIE1UVENHLg0KPiA+Pj4gRm9yIGNvbGQtYm9vdCAoZWFybHkgcmVhbGl6ZWQpIHZDUFVzLCBy
ZWdpb25zIGFyZSBzaXplZC9hbGxvY2F0ZWQNCj4gPj4+IGR1cmluZw0KPiA+PiBicmluZy11cC4N
Cj4gPj4+IEhvd2V2ZXIsIHdoZW4gYSB2Q1BVIGlzICpsYXp5X3JlYWxpemVkKiAoYWRtaW5pc3Ry
YXRpdmVseSAiZGlzYWJsZWQiDQo+ID4+PiBhdCBib290IGFuZCByZWFsaXplZCBsYXRlciBvbiBk
ZW1hbmQpLCBpdHMgVENHQ29udGV4dCBtYXkgZmFpbCB0aGUNCj4gPj4+IHZlcnkgZmlyc3QgY29k
ZSByZWdpb24gYWxsb2NhdGlvbiBpZiB0aGUgc2hhcmVkIFRCIGNhY2hlIGlzDQo+ID4+PiBzYXR1
cmF0ZWQgYnkgYWxyZWFkeS1ydW5uaW5nIHZDUFVzLg0KPiA+Pj4NCj4gPj4+IEZsdXNoaW5nIHRo
ZSBUQiBjYWNoZSBpcyB0aGUgcmlnaHQgcmVtZWRpYXRpb24sIGJ1dCBgdGJfZmx1c2goKWANCj4g
Pj4+IG11c3QgYmUgcGVyZm9ybWVkIGZyb20gdGhlIHNhZmUgZXhlY3V0aW9uIGNvbnRleHQNCj4g
Pj4gKGNwdV9leGVjX2xvb3AoKS90Yl9nZW5fY29kZSgpKS4NCj4gPj4+IFRoaXMgcGF0Y2ggd2ly
ZXMgYSBkZWZlcnJlZCBmbHVzaDoNCj4gPj4+DQo+ID4+PiAgICAgKiBJbiBgdGNnX3JlZ2lvbl9p
bml0aWFsX2FsbG9jX19sb2NrZWQoKWAsIHRyZWF0IGFuIGluaXRpYWwgYWxsb2NhdGlvbg0KPiA+
Pj4gICAgICAgZmFpbHVyZSBmb3IgYSBsYXppbHkgcmVhbGl6ZWQgdkNQVSBhcyBub24tZmF0YWw6
IHNldCBgcy0+dGJmbHVzaF9wZW5kYA0KPiA+Pj4gICAgICAgYW5kIHJldHVybi4NCj4gPj4+DQo+
ID4+PiAgICAgKiBJbiBgdGNnX3RiX2FsbG9jKClgLCBpZiBgcy0+dGJmbHVzaF9wZW5kYCBpcyBv
YnNlcnZlZCwgY2xlYXIgaXQgYW5kDQo+ID4+PiAgICAgICByZXR1cm4gTlVMTCBzbyB0aGUgY2Fs
bGVyIHBlcmZvcm1zIGEgc3luY2hyb25vdXMgYHRiX2ZsdXNoKClgIGFuZA0KPiB0aGVuDQo+ID4+
PiAgICAgICByZXRyaWVzIGFsbG9jYXRpb24uDQo+ID4+Pg0KPiA+Pj4gVGhpcyBhdm9pZHMgaGFu
Z3Mgb2JzZXJ2ZWQgd2hlbiBhIG5ld2x5IHJlYWxpemVkIHZDUFUgY2Fubm90IG9idGFpbg0KPiA+
Pj4gaXRzIGZpcnN0IHJlZ2lvbiB1bmRlciBUQi1jYWNoZSBwcmVzc3VyZSwgd2hpbGUga2VlcGlu
ZyB0aGUgZmx1c2ggYXQNCj4gPj4+IGEgc2FmZQ0KPiA+PiBwb2ludC4NCj4gPj4+DQo+ID4+PiBO
byBjaGFuZ2UgZm9yIGNvbGQtYm9vdCB2Q1BVcyBhbmQgd2hlbiBhY2NlbCBvcHMgaXMgS1ZNLg0K
PiA+Pj4NCj4gPj4+IEluIGVhcmxpZXIgc2VyaWVzLCB0aGlzIHBhdGNoIHdhcyB3aXRoIGJlbG93
IG5hbWVkLA0KPiA+Pj4gJ3RjZzogVXBkYXRlIHRjZ19yZWdpc3Rlcl90aHJlYWQoKSBsZWcgdG8g
aGFuZGxlIHJlZ2lvbiBhbGxvYyBmb3INCj4gPj4+IGhvdHBsdWdnZWQNCj4gPj4gdkNQVScNCj4g
Pj4NCj4gPj4NCj4gPj4gSSBkb24ndCBzZWUgd2h5IHlvdSBuZWVkIHR3byBkaWZmZXJlbnQgYm9v
bGVhbnMgZm9yIHRoaXMuDQo+ID4NCj4gPg0KPiA+IEkgY2FuIHNlZSB5b3VyIHBvaW50LiBNYXli
ZSBJIGNhbiBtb3ZlIGBzLT50YmZsdXNoX3BlbmRgICB0byAnQ1BVU3RhdGUnDQo+IGluc3RlYWQ/
DQo+ID4NCj4gPg0KPiA+PiBJdCBzZWVtcyB0byBtZSB0aGF0IHlvdSBjb3VsZCBjcmVhdGUgdGhl
IGNwdSBpbiBhIHN0YXRlIGZvciB3aGljaCB0aGUNCj4gPj4gZmlyc3QgY2FsbCB0bw0KPiA+PiB0
Y2dfdGJfYWxsb2MoKSBzZWVzIGhpZ2h3YXRlciBzdGF0ZSwgYW5kIGV2ZXJ5dGhpbmcgYWZ0ZXIg
dGhhdA0KPiA+PiBoYXBwZW5zIHBlciB1c3VhbCBhbGxvY2F0aW5nIGEgbmV3IHJlZ2lvbiwgYW5k
IHBvc3NpYmx5IGZsdXNoaW5nIHRoZSBmdWxsDQo+IGJ1ZmZlci4NCj4gPg0KPiA+DQo+ID4gQ29y
cmVjdC4gYnV0IHdpdGggYSBkaXN0aW5jdGlvbiB0aGF0IGhpZ2h3YXRlciBzdGF0ZSBpcyByZWxl
dmFudCB0byBhDQo+ID4gVENHQ29udGV4dCBhbmQgdGhlIHJlZ2lvbnMgYXJlIGFsbG9jYXRlZCBm
cm9tIGEgY29tbW9uIHBvb2wgJ0NvZGUNCj4gR2VuZXJhdGlvbiBCdWZmZXInLg0KPiA+ICdjb2Rl
X2dlbl9oaWdod2F0ZXInIGlzIHVzZSB0byBkZXRlY3Qgd2hldGhlciBjdXJyZW50IGNvbnRleHQg
bmVlZHMNCj4gPiBtb3JlIHJlZ2lvbiBhbGxvY2F0aW9uIGZvciB0aGUgZHluYW1pYyB0cmFuc2xh
dGlvbiB0byBjb250aW51ZS4gVGhpcw0KPiA+IGlzIGEgZGlmZmVyZW50IGNvbmRpdGlvbiB0aGFu
IHdoYXQgd2UgYXJlIGVuY291bnRlcmluZzsgd2hpY2ggaXMgdGhlDQo+ID4gd29yc3QgY2FzZSBj
b25kaXRpb24gdGhhdCB0aGUgZW50aXJlIGNvZGUgZ2VuZXJhdGlvbiBidWZmZXIgaXMNCj4gPiBz
YXR1cmF0ZWQgYW5kIGNhbm5vdCBldmVuIGFsbG9jYXRlIGEgc2luZ2xlIGZyZWUgVENHIHJlZ2lv
biBzdWNjZXNzZnVsbHkuDQo+IA0KPiBJIHRoaW5rIHlvdSBtaXN1bmRlcnN0YW5kICJhbmQgZXZl
cnl0aGluZyBhZnRlciB0aGF0IGhhcHBlbnMgcGVyIHVzdWFsIi4NCj4gDQo+IFdoZW4gYWxsb2Nh
dGluZyBhIHRiLCBpZiBhIGNwdSBmaW5kcyB0aGF0IGl0J3MgY3VycmVudCByZWdpb24gaXMgZnVs
bCwgdGhlbiBpdCB0cmllcw0KPiB0byBhbGxvY2F0ZSBhbm90aGVyIHJlZ2lvbi4gIElmIHRoYXQg
aXMgbm90IHN1Y2Nlc3NmdWwsIHRoZW4gd2UgZmx1c2ggdGhlIGVudGlyZQ0KPiBjb2RlX2dlbl9i
dWZmZXIgYW5kIHRyeSBhZ2Fpbi4NCj4gDQo+IFRodXMgdGJmbHVzaF9wZW5kIGlzIGV4YWN0bHkg
ZXF1aXZhbGVudCB0byBzZXR0aW5nDQo+IA0KPiAgICAgIHMtPmNvZGVfZ2VuX3B0ciA+IHMtPmNv
ZGVfZ2VuX2hpZ2h3YXRlci4NCj4gDQo+IEFzIGZhciBhcyBsYXp5X3JlYWxpemVkLi4uICBUaGUg
dXRpbGl0eSBvZiB0aGUgYXNzZXJ0IHVuZGVyIHRoZXNlIGNvbmRpdGlvbnMgbWF5DQo+IGJlIGNh
bGxlZCBpbnRvIHF1ZXN0aW9uOyB3ZSBjb3VsZCBqdXN0IHJlbW92ZSBpdC4NCg0KDQpJIHVuZGVy
c3RhbmQgeW91ciBwb2ludC4gSSdsbCByZW1vdmUgdGhlICd0YmZsdXNoX3BlbmQnIGZsYWcgIGFu
ZCBkaXJlY3RseSB1c2UNCidjb2RlX2dlbl9oaWdod2F0ZXIgPSBOVUxMJyBzbyB0aGF0IHdlIGhp
dCB0aGUgaGlnaHdhdGVyIGNvbmRpdGlvbiBlYXJseQ0Kd2hlbiB0aGUgVENHIHRocmVhZHMgZ2V0
cyBsYXppbHkgcmVhbGl6ZWQuIEFuZCB5ZXMsIHdlIG1pZ2h0IGhhdmUgdG8gZWl0aGVyDQpyZW1v
dmUgb3IgY29uZGl0aW9uYWxseSBieXBhc3MgdGhlIGFzc2VydCgpLiBXaWxsIGRpZyBmdXJ0aGVy
IGFuZCB2YWxpZGF0ZS4gDQoNCk1hbnkgdGhhbmtzIGZvciB0aGlzIG9wdGltaXphdGlvbiENCg0K
QmVzdCByZWdhcmRzDQpTYWxpbC4NCg0KDQo+IA0KPiANCj4gcn4NCg==

