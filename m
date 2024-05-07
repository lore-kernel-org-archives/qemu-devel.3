Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7057FC25B10
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 01:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s49yt-0007SW-LK; Mon, 06 May 2024 21:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1s49yq-0007QM-8u; Mon, 06 May 2024 21:50:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1s49yn-0000yn-5O; Mon, 06 May 2024 21:50:56 -0400
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VYLkQ1NKJzvQWW;
 Tue,  7 May 2024 09:47:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
 by mail.maildlp.com (Postfix) with ESMTPS id 5880918009D;
 Tue,  7 May 2024 09:50:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 09:50:43 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Tue, 7 May 2024 09:50:43 +0800
To: Peter Xu <peterx@redhat.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, Michael Galaxy <mgalaxy@akamai.com>, Yu
 Zhang <yu.zhang@ionos.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "Jinpu Wang" <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuval Shaia
 <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>, "Prasanna Kumar
 Kalever" <prasanna.kalever@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Prasanna Kumar Kalever
 <prasanna4324@gmail.com>, "integration@gluster.org"
 <integration@gluster.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "devel@lists.libvirt.org"
 <devel@lists.libvirt.org>, Hanna Reitz <hreitz@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake
 <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Wainer dos Santos
 Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>,
 zhengchuan <zhengchuan@huawei.com>
Subject: RE: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHaib4eb+nVph6utEe7HatbjXSGr7FeBxGAgAD/kQCAAM0PAIAAcGaAgAC+EICAAZsBgIAAJisAgBwPpQCAAB5mAIABl4t9//+GhYCAAhAsgIAHeqWwgABddICAATP+EA==
Date: Tue, 7 May 2024 01:50:43 +0000
Message-ID: <addaa8d094904315a466533763689ead@huawei.com>
References: <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
In-Reply-To: <Zjj0xa-3KrFHTK0S@x1n>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.124.235]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=arei.gonglei@huawei.com; helo=szxga01-in.huawei.com
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
Reply-to:  "Gonglei (Arei)" <arei.gonglei@huawei.com>
From:  "Gonglei (Arei)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgWHUg
W21haWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gU2VudDogTW9uZGF5LCBNYXkgNiwgMjAyNCAx
MToxOCBQTQ0KPiBUbzogR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPg0K
PiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IE1hcmt1cyBB
cm1icnVzdGVyDQo+IDxhcm1icnVAcmVkaGF0LmNvbT47IE1pY2hhZWwgR2FsYXh5IDxtZ2FsYXh5
QGFrYW1haS5jb20+OyBZdSBaaGFuZw0KPiA8eXUuemhhbmdAaW9ub3MuY29tPjsgWmhpamlhbiBM
aSAoRnVqaXRzdSkgPGxpemhpamlhbkBmdWppdHN1LmNvbT47IEppbnB1IFdhbmcNCj4gPGppbnB1
LndhbmdAaW9ub3MuY29tPjsgRWxtYXIgR2VyZGVzIDxlbG1hci5nZXJkZXNAaW9ub3MuY29tPjsN
Cj4gcWVtdS1kZXZlbEBub25nbnUub3JnOyBZdXZhbCBTaGFpYSA8eXV2YWwuc2hhaWEubWxAZ21h
aWwuY29tPjsgS2V2aW4gV29sZg0KPiA8a3dvbGZAcmVkaGF0LmNvbT47IFByYXNhbm5hIEt1bWFy
IEthbGV2ZXINCj4gPHByYXNhbm5hLmthbGV2ZXJAcmVkaGF0LmNvbT47IENvcm5lbGlhIEh1Y2sg
PGNvaHVja0ByZWRoYXQuY29tPjsNCj4gTWljaGFlbCBSb3RoIDxtaWNoYWVsLnJvdGhAYW1kLmNv
bT47IFByYXNhbm5hIEt1bWFyIEthbGV2ZXINCj4gPHByYXNhbm5hNDMyNEBnbWFpbC5jb20+OyBp
bnRlZ3JhdGlvbkBnbHVzdGVyLm9yZzsgUGFvbG8gQm9uemluaQ0KPiA8cGJvbnppbmlAcmVkaGF0
LmNvbT47IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgZGV2ZWxAbGlzdHMubGlidmlydC5vcmc7DQo+
IEhhbm5hIFJlaXR6IDxocmVpdHpAcmVkaGF0LmNvbT47IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+Ow0KPiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT47IEVyaWMgQmxh
a2UgPGVibGFrZUByZWRoYXQuY29tPjsgU29uZw0KPiBHYW8gPGdhb3NvbmdAbG9vbmdzb24uY24+
OyBNYXJjLUFuZHLDqSBMdXJlYXUNCj4gPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IEFs
ZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz47DQo+IFdhaW5lciBkb3MgU2FudG9z
IE1vc2NoZXR0YSA8d2FpbmVyc21AcmVkaGF0LmNvbT47IEJlcmFsZG8gTGVhbA0KPiA8YmxlYWxA
cmVkaGF0LmNvbT47IFBhbm5lbmd5dWFuIDxwYW5uZW5neXVhbkBodWF3ZWkuY29tPjsNCj4gWGll
eGlhbmd5b3UgPHhpZXhpYW5neW91QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gt
Zm9yLTkuMSB2MiAyLzNdIG1pZ3JhdGlvbjogUmVtb3ZlIFJETUEgcHJvdG9jb2wgaGFuZGxpbmcN
Cj4gDQo+IE9uIE1vbiwgTWF5IDA2LCAyMDI0IGF0IDAyOjA2OjI4QU0gKzAwMDAsIEdvbmdsZWkg
KEFyZWkpIHdyb3RlOg0KPiA+IEhpLCBQZXRlcg0KPiANCj4gSGV5LCBMZWksDQo+IA0KPiBIYXBw
eSB0byBzZWUgeW91IGFyb3VuZCBhZ2FpbiBhZnRlciB5ZWFycy4NCj4gDQpIYWhhLCBtZSB0b28u
DQoNCj4gPiBSRE1BIGZlYXR1cmVzIGhpZ2ggYmFuZHdpZHRoLCBsb3cgbGF0ZW5jeSAoaW4gbm9u
LWJsb2NraW5nIGxvc3NsZXNzDQo+ID4gbmV0d29yayksIGFuZCBkaXJlY3QgcmVtb3RlIG1lbW9y
eSBhY2Nlc3MgYnkgYnlwYXNzaW5nIHRoZSBDUFUgKEFzIHlvdQ0KPiA+IGtub3csIENQVSByZXNv
dXJjZXMgYXJlIGV4cGVuc2l2ZSBmb3IgY2xvdWQgdmVuZG9ycywgd2hpY2ggaXMgb25lIG9mDQo+
ID4gdGhlIHJlYXNvbnMgd2h5IHdlIGludHJvZHVjZWQgb2ZmbG9hZCBjYXJkcy4pLCB3aGljaCBU
Q1AgZG9lcyBub3QgaGF2ZS4NCj4gDQo+IEl0J3MgYW5vdGhlciBjb3N0IHRvIHVzZSBvZmZsb2Fk
IGNhcmRzLCB2LnMuIHByZXBhcmluZyBtb3JlIGNwdSByZXNvdXJjZXM/DQo+IA0KU29mdHdhcmUg
YW5kIGhhcmR3YXJlIG9mZmxvYWQgY29udmVyZ2VkIGFyY2hpdGVjdHVyZSBpcyB0aGUgd2F5IHRv
IGdvIGZvciBhbGwgY2xvdWQgdmVuZG9ycyANCihJbmNsdWRpbmcgY29tcHJlaGVuc2l2ZSBiZW5l
Zml0cyBpbiB0ZXJtcyBvZiBwZXJmb3JtYW5jZSwgY29zdCwgc2VjdXJpdHksIGFuZCBpbm5vdmF0
aW9uIHNwZWVkKSwgDQppdCdzIG5vdCBqdXN0IGEgbWF0dGVyIG9mIGFkZGluZyB0aGUgcmVzb3Vy
Y2Ugb2YgYSBEUFUgY2FyZC4NCg0KPiA+IEluIHNvbWUgc2NlbmFyaW9zIHdoZXJlIGZhc3QgbGl2
ZSBtaWdyYXRpb24gaXMgbmVlZGVkIChleHRyZW1lbHkgc2hvcnQNCj4gPiBpbnRlcnJ1cHRpb24g
ZHVyYXRpb24gYW5kIG1pZ3JhdGlvbiBkdXJhdGlvbikgaXMgdmVyeSB1c2VmdWwuIFRvIHRoaXMN
Cj4gPiBlbmQsIHdlIGhhdmUgYWxzbyBkZXZlbG9wZWQgUkRNQSBzdXBwb3J0IGZvciBtdWx0aWZk
Lg0KPiANCj4gV2lsbCBhbnkgb2YgeW91IHVwc3RyZWFtIHRoYXQgd29yaz8gIEknbSBjdXJpb3Vz
IGhvdyBpbnRydXNpdmUgd291bGQgaXQgYmUNCj4gd2hlbiBhZGRpbmcgaXQgdG8gbXVsdGlmZCwg
aWYgaXQgY2FuIGtlZXAgb25seSA1IGV4cG9ydGVkIGZ1bmN0aW9ucyBsaWtlIHdoYXQNCj4gcmRt
YS5oIGRvZXMgcmlnaHQgbm93IGl0J2xsIGJlIHByZXR0eSBuaWNlLiAgV2UgYWxzbyB3YW50IHRv
IG1ha2Ugc3VyZSBpdCB3b3Jrcw0KPiB3aXRoIGFyYml0cmFyeSBzaXplZCBsb2FkcyBhbmQgYnVm
ZmVycywgZS5nLiB2ZmlvIGlzIGNvbnNpZGVyaW5nIHRvIGFkZCBJTyBsb2FkcyB0bw0KPiBtdWx0
aWZkIGNoYW5uZWxzIHRvby4NCj4gDQoNCkluIGZhY3QsIHdlIHNlbnQgdGhlIHBhdGNoc2V0IHRv
IHRoZSBjb21tdW5pdHkgaW4gMjAyMS4gUGxzIHNlZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIxMDIwMzE4NTkwNi5HVDI5NTBAd29yay12bS9ULw0KDQoNCj4gT25lIHRoaW5nIHRv
IG5vdGUgdGhhdCB0aGUgcXVlc3Rpb24gaGVyZSBpcyBub3QgYWJvdXQgYSBwdXJlIHBlcmZvcm1h
bmNlDQo+IGNvbXBhcmlzb24gYmV0d2VlbiByZG1hIGFuZCBuaWNzIG9ubHkuICBJdCdzIGFib3V0
IGhlbHAgdXMgbWFrZSBhIGRlY2lzaW9uDQo+IG9uIHdoZXRoZXIgdG8gZHJvcCByZG1hLCBpb3cs
IGV2ZW4gaWYgcmRtYSBwZXJmb3JtcyB3ZWxsLCB0aGUgY29tbXVuaXR5IHN0aWxsDQo+IGhhcyB0
aGUgcmlnaHQgdG8gZHJvcCBpdCBpZiBub2JvZHkgY2FuIGFjdGl2ZWx5IHdvcmsgYW5kIG1haW50
YWluIGl0Lg0KPiBJdCdzIGp1c3QgdGhhdCBpZiBuaWNzIGNhbiBwZXJmb3JtIGFzIGdvb2QgaXQn
cyBtb3JlIGEgcmVhc29uIHRvIGRyb3AsIHVubGVzcw0KPiBjb21wYW5pZXMgY2FuIGhlbHAgdG8g
cHJvdmlkZSBnb29kIHN1cHBvcnQgYW5kIHdvcmsgdG9nZXRoZXIuDQo+IA0KDQpXZSBhcmUgaGFw
cHkgdG8gcHJvdmlkZSB0aGUgbmVjZXNzYXJ5IHJldmlldyBhbmQgbWFpbnRlbmFuY2Ugd29yayBm
b3IgUkRNQQ0KaWYgdGhlIGNvbW11bml0eSBuZWVkcyBpdC4NCg0KQ0MnaW5nIENodWFuIFpoZW5n
Lg0KDQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0KDQo=

