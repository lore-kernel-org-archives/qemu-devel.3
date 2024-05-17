Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21F5C25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 10:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uaw-0006If-2p; Fri, 17 May 2024 06:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s7uau-0006IE-LE; Fri, 17 May 2024 06:13:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s7uar-00023u-Nc; Fri, 17 May 2024 06:13:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VgjPY1Hrxz6K65Y;
 Fri, 17 May 2024 18:09:53 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (unknown [7.191.163.9])
 by mail.maildlp.com (Postfix) with ESMTPS id B75DD140C72;
 Fri, 17 May 2024 18:13:27 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 May 2024 11:13:27 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Fri, 17 May 2024 11:13:27 +0100
To: Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "danielhb413@gmail.com" <danielhb413@gmail.com>, "vaibhav@linux.ibm.com"
 <vaibhav@linux.ibm.com>, "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>
Subject: RE: [PATCH v2 1/4] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
Thread-Topic: [PATCH v2 1/4] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
Thread-Index: AQHap1J3XuFeE+ZUnUegULMwM5sk3bGZg7UwgAAQyoCAAC+4UIAAACWAgAATpACAAOGXAIAAdpog
Date: Fri, 17 May 2024 10:13:27 +0000
Message-ID: <f62a54bd19a941d8bef549482043c1d2@huawei.com>
References: <20240516053211.145504-1-harshpb@linux.ibm.com>
 <20240516053211.145504-2-harshpb@linux.ibm.com>
 <fc08e87c979a4916aaff649724df9c6b@huawei.com>
 <bfb5888c-c66c-4000-ba12-5af202b0fe17@linux.ibm.com>
 <2e290791a92949d79fe0fdfcb972a029@huawei.com>
 <49f4d0cb-260e-45fb-a678-2dec45c9fab8@linux.ibm.com>
 <7a5608c768254869a4a6b68d719c24f1@huawei.com>
 <D1BLZ35ZE9EI.18TYUB70KCCY7@gmail.com>
In-Reply-To: <D1BLZ35ZE9EI.18TYUB70KCCY7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.29]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

SGkgTmljaywNCg0KPiAgRnJvbTogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT4N
Cj4gIFNlbnQ6IEZyaWRheSwgTWF5IDE3LCAyMDI0IDQ6NDQgQU0NCj4gIA0KPiAgT24gVGh1IE1h
eSAxNiwgMjAyNCBhdCAxMTozNSBQTSBBRVNULCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gID4NCj4g
ID4gPiAgRnJvbTogSGFyc2ggUHJhdGVlayBCb3JhIDxoYXJzaHBiQGxpbnV4LmlibS5jb20+DQo+
ICA+ID4gIFNlbnQ6IFRodXJzZGF5LCBNYXkgMTYsIDIwMjQgMjowNyBQTQ0KPiAgPiA+DQo+ICA+
ID4gIEhpIFNhbGlsLA0KPiAgPiA+DQo+ICA+ID4gIE9uIDUvMTYvMjQgMTc6NDIsIFNhbGlsIE1l
aHRhIHdyb3RlOg0KPiAgPiA+ICA+IEhpIEhhcnNoLA0KPiAgPiA+ICA+DQo+ICA+ID4gID4+ICAg
RnJvbTogSGFyc2ggUHJhdGVlayBCb3JhIDxoYXJzaHBiQGxpbnV4LmlibS5jb20+DQo+ICA+ID4g
ID4+ICAgU2VudDogVGh1cnNkYXksIE1heSAxNiwgMjAyNCAxMToxNSBBTQ0KPiAgPiA+ICA+Pg0K
PiAgPiA+ICA+PiAgIEhpIFNhbGlsLA0KPiAgPiA+ICA+Pg0KPiAgPiA+ICA+PiAgIFRoYW5rcyBm
b3IgeW91ciBlbWFpbC4NCj4gID4gPiAgPj4gICBZb3VyIHBhdGNoIDEvOCBpcyBpbmNsdWRlZCBo
ZXJlIGJhc2VkIG9uIHJldmlldyBjb21tZW50cyBvbiBteSBwcmV2aW91cw0KPiAgPiA+ICA+PiAg
IHBhdGNoIGZyb20gb25lIG9mIHRoZSBtYWludGFpbmVycyBpbiB0aGUgY29tbXVuaXR5IGFuZCB0
aGVyZWZvcmUgSSAgaGFkDQo+ICA+ID4gID4+ICAga2VwdCB5b3UgaW4gQ0MgdG8gYmUgYXdhcmUg
b2YgdGhlIGRlc2lyZSBvZiBoYXZpbmcgdGhpcyBpbmRlcGVuZGVudCBwYXRjaCB0bw0KPiAgPiA+
ICA+PiAgIGdldCBtZXJnZWQgZWFybGllciBldmVuIGlmIHlvdXIgb3RoZXIgcGF0Y2hlcyBpbiB0
aGUgc2VyaWVzIG1heSBnbyB0aHJvdWdoDQo+ICA+ID4gID4+ICAgZnVydGhlciByZXZpZXdzLg0K
PiAgPiA+ICA+DQo+ICA+ID4gID4gSSByZWFsbHkgZG9u4oCZdCBrbm93IHdoaWNoIGRpc2N1c3Np
b24gYXJlICB5b3UgcG9pbnRpbmcgYXQ/IFBsZWFzZQ0KPiAgPiA+ID4gdW5kZXJzdGFuZCB5b3Ug
YXJlIGZpeGluZyBhIGJ1ZyBhbmQgd2UgYXJlIHB1c2hpbmcgYSBmZWF0dXJlIHdoaWNoIGhhcyBn
b3QgbGFyZ2Ugc2VyaWVzLg0KPiAgPiA+ICA+IEl0IHdpbGwgYnJlYWsgdGhlIHBhdGNoLXNldCAg
d2hpY2ggaXMgYWJvdXQgdCBiZSBtZXJnZWQuDQo+ICA+ID4gID4NCj4gID4gPiAgPiBUaGVyZSB3
aWxsIGJlIHNpZ25pZmljYW50IG92ZXJoZWFkIG9mIHRlc3Rpbmcgb24gdXMgZm9yIHRoZSB3b3Jr
DQo+ICA+ID4gd2UgID4gaGF2ZSBiZWVuIGNhcnJ5aW5nIGZvcndhcmQgZm9yIGxhcmdlIHRpbWUu
IFRoaXMgd2lsbCBiZSBkaXNydXB0aXZlLiBQbGVhc2UgZG9udCENCj4gID4gPiAgPg0KPiAgPiA+
DQo+ICA+ID4gIEkgd2FzIHJlZmVycmluZyB0byB0aGUgcmV2aWV3IGRpc2N1c3Npb24gb24gbXkg
cHJldiBwYXRjaCBoZXJlOg0KPiAgPiA+DQo+ICA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC9EMTkxRDJKRkFSN0wuMkVINFM0NDVNNFRHS0BnbWFpbC5jb20vDQo+ICA+DQo+
ICA+DQo+ICA+IFN1cmUsIEknbSwgbm90IHN1cmUgd2hhdCB0aGlzIG1lYW5zLg0KPiAgPg0KPiAg
Pg0KPiAgPiA+ICBBbHRob3VnaCB5b3VyIHBhdGNoIHdhcyBpbmNsdWRlZCB3aXRoIHRoaXMgc2Vy
aWVzIG9ubHkgdG8NCj4gID4gPiBmYWNpbGl0YXRlIHJldmlldyBvZiAgdGhlIGFkZGl0aW9uYWwg
cGF0Y2hlcyBkZXBlbmRpbmcgb24ganVzdCBvbmUgb2YgeW91ciBwYXRjaC4NCj4gID4NCj4gID4N
Cj4gID4gR2VuZXJhbGx5IHlvdSByZWJhc2UgeW91ciBwYXRjaC1zZXQgb3ZlciB0aGUgb3RoZXIg
YW5kIGNsZWFybHkgc3RhdGUNCj4gID4gb24gdGhlIGNvdmVyIGxldHRlciB0aGF0IHRoaXMgcGF0
Y2gtc2V0IGlzIGRlcGVuZGVudCB1cG9uIHN1Y2ggYW5kDQo+ICA+IHN1Y2ggcGF0Y2gtc2V0LiBK
dXN0IGltYWdpbmUgaWYgZXZlcnlvbmUgc3RhcnRzIHRvIHVuaWxhdGVyYWxseSBwaWNrDQo+ICA+
IHVwIHBhdGNoZXMgZnJvbSBlYWNoIG90aGVyJ3MgcGF0Y2gtc2V0IGl0IHdpbGwgY3JlYXRlIGEg
Y2hhb3Mgbm90IG9ubHkgZm9yDQo+ICB0aGUgZmVhdHVyZSBvd25lcnMgYnV0IGFsc28gZm9yIHRo
ZSBtYWludGFpbmVycy4NCj4gID4NCj4gID4NCj4gID4gPg0KPiAgPiA+ICBJIGFtIG5vdCBzdXJl
IHdoYXQgaXMgYXBwZWFyaW5nIGRpc3J1cHRpdmUgaGVyZS4gSXQgaXMgYSBjb21tb24NCj4gID4g
PiBwcmFjdGl2ZSBpbiAgdGhlIGNvbW11bml0eSB0aGF0IG1haW50YWluZXIocykgY2FuIHBpY2sg
aW5kaXZpZHVhbA0KPiAgPiA+IHBhdGNoZXMgZnJvbSB0aGUgIHNlcmllcyBpZiBpdCBoYXMgYmVl
biB2ZXR0ZWQgYnkgc2lnaW5pZmljYW50IG51bWJlciBvZiByZXZpZXdlcnMuDQo+ICA+DQo+ICA+
DQo+ICA+IERvbuKAmXQgeW91IHRoaW5rIHRoaXMgcGF0Y2gtc2V0IGlzIGFza2luZyBmb3IgYWNj
ZXB0YW5jZSBmb3IgYSBwYXRjaA0KPiAgPiBhbHJlYWR5IHBhcnQgb2YgYW5vdGhlciBwYXRjaC1z
ZXQgd2hpY2ggaXMgYWJvdXQgdG8gYmUgYWNjZXB0ZWQgYW5kIGlzIGEgYmlnZ2VyIGZlYXR1cmU/
DQo+ICA+IFdpbGwgaXQgY2F1c2UgbWFpbnRlbmFuY2Ugb3ZlcmhlYWQgYXQgdGhlIGxhc3QgbW9t
ZW50PyBZZXMsIG9mIGNvdXJzZSENCj4gID4NCj4gID4NCj4gID4gPiAgSG93ZXZlciwgaW4gdGhp
cyBjYXNlLCBzaW5jZSB5b3UgaGF2ZSBtZW50aW9uZWQgdG8gcG9zdCBuZXh0DQo+ICA+ID4gdmVy
c2lvbiBzb29uLCAgeW91IG5lZWQgbm90IHdvcnJ5IGFib3V0IGl0IGFzIHRoYXQgd291bGQgYmUg
dGhlDQo+ICA+ID4gcHJlZmVycmVkIHZlcnNpb24gZm9yIGJvdGggIG9mIHRoZSBzZXJpZXMuDQo+
ICA+DQo+ICA+DQo+ICA+IFllcywgYnV0IHBsZWFzZSB1bmRlcnN0YW5kIHdlIGFyZSB3b3JraW5n
IGZvciB0aGUgYmVuZWZpdCBvZiBvdmVyYWxsIGNvbW11bml0eS4NCj4gID4gUGxlYXNlIGNvb3Bl
cmF0ZSBoZXJlLg0KPiAgDQo+ICBUaGVyZSBtaWdodCBiZSBhIG1pc3VuZGVyc3RhbmRpbmcsIEhh
cnNoIGp1c3Qgc2FpZCB0aGVyZSBoYWQgbm90IGJlZW4NCj4gIG11Y2ggcHJvZ3Jlc3Mgb24geW91
ciBzZXJpZXMgZm9yIGEgd2hpbGUgYW5kIGhlIHdhc24ndCBzdXJlIHdoYXQgdGhlIHN0YXR1cw0K
PiAgd2FzLiBJIG1lbnRpb25lZCB0aGF0IHdlICpjb3VsZCogdGFrZSB5b3VyIHBhdGNoIDEgKHdp
dGggeW91cg0KPiAgYmxlc3NpbmcpIGlmIHRoZXJlIHdhcyBhIGhvbGQgdXAgd2l0aCB0aGUgcmVz
dCBvZiB0aGUgc2VyaWVzLiBIZSB3YXMgZ29pbmcgdG8NCj4gIGNoZWNrIGluIHdpdGggeW91IHRv
IHNlZSBob3cgaXQgd2FzIGdvaW5nLg0KDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24u
IE5vIGlzc3Vlcy4gSSdtIHBsYW5uaW5nIHRvIGZsb2F0IFY5IG9mIHRoaXMgc2VyaWVzIGJ5DQpN
b25kYXkgYW5kIHBlcmhhcHMgdGhhdOKAmXMgYWxsIHlvdSB3YW50LiDwn5iKDQoNCkFzIHN1Y2gs
IG5ldyBjeWNsZSBzdGFydGVkIG9uIDIzcmQgQXByaWwgYW5kIHdlIGhhZCBiZWVuIGJ1c3kgcmVi
YXNpbmcgYW5kDQp0ZXN0aW5nLiBUaGlzIHNlcmllcyB3b3JrcyBpbiBjb25qdW5jdGlvbiB3aXRo
IG90aGVyIHNlcmllcy4gV2UgaGF2ZSB0byBlbnN1cmUgYm90aA0KYXJlIGNvbXBhdGlibGUuDQoN
Cg0KPiAgVGhpcyBwYXRjaCAxIHdhcyBub3QgaW50ZW5kZWQgdG8gYmUgbWVyZ2VkIGFzIGlzIHdp
dGhvdXQgc3luY2luZyB1cCB3aXRoDQo+ICB5b3UgZmlyc3QsIGJ1dCBpdCdzIHVuZGVyc3RhbmRh
YmxlIHlvdSB3ZXJlIGNvbmNlcm5lZCBiZWNhdXNlIHRoYXQgd2FzDQo+ICBwcm9iYWJseSBub3Qg
Y29tbXVuaWNhdGVkIHdpdGggeW91IGNsZWFybHkuDQoNCg0KTm8gaXNzdWVzLiBJIHRoaW5rIHdl
IGFsbCBhcmUgaW4gdGhlIHNhbWUgcGFnZSBub3cuIEkgdW5kZXJzdGFuZCB5b3VyDQpyZXF1aXJl
bWVudC4gV2UgYXJlIHRyeWluZyBvdXIgYmVzdCB0byBleHBlZGl0ZSBhY2NlcHRhbmNlIG9mIHRo
aXMgc2VyaWVzLg0KUGVyaGFwcyB5b3VyIHJldmlld3Mgb24gVjkgbWlnaHQgaGVscC4NCg0KDQo+
ICANCj4gIEkgYXBwcmVjaWF0ZSB5b3UgYnJpbmdpbmcgdXAgeW91ciBjb25jZXJucywgd2UnbGwg
dHJ5IHRvIGRvIGJldHRlci4NCg0KTm8gcHJvYmxlbS4gVGhhbmtzDQoNClNhbGlsLg0KDQo+ICAN
Cj4gIFRoYW5rcywNCj4gIE5pY2sNCg==

