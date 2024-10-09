Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B026ECF0435
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNC3-000201-Hi; Tue, 08 Oct 2024 23:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1syNC0-0001zi-VM
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:16:53 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1syNBy-00048K-Ci
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:16:52 -0400
To: Junjie Mao <junjie.mao@hotmail.com>, "Zuo,Boqun" <zuoboqun@baidu.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "david@redhat.com" <david@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "alxndr@bu.edu" <alxndr@bu.edu>,
 "peterx@redhat.com" <peterx@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Thread-Topic: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Thread-Index: AQHbGfl9beIMvx7hS4K1J5o2R2S6yQ==
Date: Wed, 9 Oct 2024 03:15:28 +0000
Message-ID: <101C7CA0-3665-4BF4-949D-15CE22E22103@baidu.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.154]
Content-Type: text/plain; charset="utf-8"
Content-ID: <42EF24425D563F44962C8979E8A24590@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiA+PiA+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpX2JyaWRnZS5jIGIvaHcvcGNpL3BjaV9icmlk
Z2UuYyBpbmRleA0KPiA+PiA+IDZhNGUzODg1NmQuLjc0NjgzZTc0NDUgMTAwNjQ0DQo+ID4+ID4g
LS0tIGEvaHcvcGNpL3BjaV9icmlkZ2UuYw0KPiA+PiA+ICsrKyBiL2h3L3BjaS9wY2lfYnJpZGdl
LmMNCj4gPj4gPiBAQCAtMzgwLDYgKzM4MCw3IEBAIHZvaWQgcGNpX2JyaWRnZV9pbml0Zm4oUENJ
RGV2aWNlICpkZXYsIGNvbnN0IGNoYXINCj4gPj4gKnR5cGVuYW1lKQ0KPiA+PiA+IHNlY19idXMt
Pm1hcF9pcnEgPSBici0+bWFwX2lycSA/IGJyLT5tYXBfaXJxIDoNCj4gPj4gcGNpX3N3aXp6bGVf
bWFwX2lycV9mbjsNCj4gPj4gPiBzZWNfYnVzLT5hZGRyZXNzX3NwYWNlX21lbSA9ICZici0+YWRk
cmVzc19zcGFjZV9tZW07DQo+ID4+ID4gbWVtb3J5X3JlZ2lvbl9pbml0KCZici0+YWRkcmVzc19z
cGFjZV9tZW0sIE9CSkVDVChiciksDQo+ID4+ID4gInBjaV9icmlkZ2VfcGNpIiwgVUlOVDY0X01B
WCk7DQo+ID4+ID4gKyBhZGRyZXNzX3NwYWNlX2luaXQoJmJyLT5hc19tZW0sICZici0+YWRkcmVz
c19zcGFjZV9tZW0sDQo+ID4+ID4gKyAicGNpX2JyaWRnZV9wY2kiKTsNCj4gPj4NCj4gPj4gSSBk
b24ndCB0aGluayB0aGlzICJwY2lfYnJpZGdlX3BjaSIgYWRkcmVzcyBzcGFjZSBpcyBuZWNlc3Nh
cnkuIFRoZQ0KPiA+PiBWaXJ0SU9QQ0lQcm94eS5tb2Rlcm5fYXMgQWRkcmVzc1NwYWNlIGlzIHN1
ZmZpY2llbnQgZm9yDQo+ID4+IG1lbW9yeV9yZWdpb25fYWRkKCkgdG8gd29yay4NCj4gPg0KPiA+
IFRoaXMgaXMgYmVjYXVzZSBtZW1vcnlfcmVnaW9uX2ZpbmRfcmN1ICgpIGFuZCBtZW1vcnlfcmVn
aW9uX3RvX2FkZHJlc3Nfc3BhY2UoKSB3aWxsIGZpbmQgdGhlIG1lbW9yeSBjb250YWluZXINCj4g
PiBvbiB0aGUgdG9wIGxldmVsIGFuZCB0aGVuIGdldCB0aGUgY29ycmVzcG9uZGluZyBhZGRyZXNz
IHNwYWNlIG9mIGl0Lg0KPiA+IElmIHdlIG9ubHkgYWRkICJWaXJ0SU9QQ0lQcm94eS5tb2Rlcm5f
YXMgQWRkcmVzc1NwYWNlIiwgbWVtb3J5X3JlZ2lvbl9maW5kKCkgc3RpbGwgY2Fubm90IGZpbmQg
YSBhZGRyZXNzIHNwYWNlLg0KPiA+IEJlY2F1c2UgInBjaV9icmlkZ2VfcGNpIiBpcyB0aGUgbWVt
b3J5IGNvbnRhaW5lciBvbiB0b3AgbGV2ZWwgYW5kIGl0IGRvZXNuJ3QgaGF2ZSBhIGNvcnJlc3Bv
bmRpbmcgYWRkcmVzcyBzcGFjZS4NCj4NCj4NCj4gR290IHlvdXIgcG9pbnQuIFRoYXQgYWRkcmVz
cyBzcGFjZSBjYW4gaGVscCB3aGVuIGEgc28taWxsLWJlaGF2ZWQgZ3Vlc3QNCj4gZW5hYmxlcyBi
b3RoIHRoZSBicmlkZ2UgYW5kIHRoZSB2aXJ0aW8gZGV2aWNlLCBjbGVhcnMgdGhlIG1lbW9yeSBi
YXNlIG9mDQo+IHNlY29uZGFyeSBidXMgYW5kIHRoZW4gYWNjZXNzZXMgdGhlIHZpcnRpbyBjb25m
aWd1cmF0aW9ucyB2aWEgdGhlIFBDSQ0KPiBjb25maWcgYWNjZXNzIGNhcC4gVGhhbmtzIGZvciB0
aGUgY2xhcmlmaWNhdGlvbi4NCj4NCj4NCj4gQXMgbWVudGlvbmVkIGVhcmxpZXIsIHlvdSBtYXkg
d2FudCB0byBhZGQgdGhlIEkvTyBzcGFjZSBjb3VudGVycGFydHMgZm9yDQo+IGJvdGggYWRkcmVz
cyBzcGFjZXMsIGFzIHRoZSBjYXAgY2FuIHRhcmdldCBtb2Rlcm4gSS9PIEJBUnMgKHdoZW4gdGhl
eQ0KPiBhcmUgcHJlc2VudCkgYXMgd2VsbC4NCg0KVGhhbmtzLCBJJ2xsIGFkZCBhIGFkZHJlc3Mg
c3BhY2UgZm9yIEkvTyBCQVJzIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCg==

