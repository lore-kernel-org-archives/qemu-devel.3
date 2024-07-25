Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC734C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWztS-0000YG-8G; Thu, 25 Jul 2024 10:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sWztQ-0000Xj-So
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:56:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sWztO-0002U7-Bc
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:56:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVDSL3fZRz6HJTn;
 Thu, 25 Jul 2024 22:54:42 +0800 (CST)
Received: from lhrpeml100005.china.huawei.com (unknown [7.191.160.25])
 by mail.maildlp.com (Postfix) with ESMTPS id DFEC9140519;
 Thu, 25 Jul 2024 22:56:23 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 15:56:14 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Thu, 25 Jul 2024 15:56:14 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>, Vishnu Pajjuri
 <vishnu@os.amperecomputing.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Xianglai Li <lixianglai@loongson.cn>, "Miguel
 Luis" <miguel.luis@oracle.com>, Shaoqin Huang <shahuang@redhat.com>,
 "Nicholas Piggin" <npiggin@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Subject: RE: [PULL v2 37/61] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Topic: [PULL v2 37/61] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Index: AQHa3O9RebBRo1C7H0iEcr177twQ1LIHMiGAgAApesD///W5gIAAOgIw
Date: Thu, 25 Jul 2024 14:56:14 +0000
Message-ID: <20ade2533af544ca96862154a0be1a56@huawei.com>
References: <cover.1721731723.git.mst@redhat.com>
 <08c328682231b64878fc052a11091bea39577a6f.1721731723.git.mst@redhat.com>
 <CAFEAcA-3_d1c7XSXWkFubD-LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
 <8f5fcf0c1deb4f199d86441f79298629@huawei.com>
 <CAFEAcA9-gVBLAH9PaFrPmBLD5tHXMZ+-2m+pRvtjodOBaBa0GQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9-gVBLAH9PaFrPmBLD5tHXMZ+-2m+pRvtjodOBaBa0GQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.169.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

SGkgUGV0ZXIsDQoNCj4gIEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4gIFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI1LCAyMDI0IDE6MjcgUE0NCj4gIFRvOiBT
YWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIA0KPiAgT24gVGh1LCAyNSBK
dWwgMjAyNCBhdCAxMzowNSwgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdy
b3RlOg0KPiAgPg0KPiAgPiBISSBQZXRlciwNCj4gID4NCj4gID4gPiAgRnJvbTogUGV0ZXIgTWF5
ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiAgPiA+ICBTZW50OiBUaHVyc2RheSwg
SnVseSAyNSwgMjAyNCAxMTozNiBBTQ0KPiAgPiA+ICBUbzogTWljaGFlbCBTLiBUc2lya2luIDxt
c3RAcmVkaGF0LmNvbT4NCj4gID4gPg0KPiAgPiA+ICBPbiBUdWUsIDIzIEp1bCAyMDI0IGF0IDEx
OjU4LCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToNCj4gID4gPiAg
Pg0KPiAgPiA+ICA+IEZyb206IFNhbGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPiAg
PiAgPiBLVk0gdkNQVQ0KPiAgPiA+IGNyZWF0aW9uIGlzIGRvbmUgb25jZSBkdXJpbmcgdGhlIHZD
UFUgcmVhbGl6YXRpb24gd2hlbiBRZW11ICA+IHZDUFUNCj4gID4gPiB0aHJlYWQgaXMgc3Bhd25l
ZC4gVGhpcyBpcyBjb21tb24gdG8gYWxsIHRoZSBhcmNoaXRlY3R1cmVzIGFzIG9mIG5vdy4NCj4g
ID4gPiAgPg0KPiAgPiA+ICA+IEhvdC11bnBsdWcgb2YgdkNQVSByZXN1bHRzIGluIGRlc3RydWN0
aW9uIG9mIHRoZSB2Q1BVIG9iamVjdCBpbg0KPiAgPiA+IFFPTSAgPiBidXQgdGhlIGNvcnJlc3Bv
bmRpbmcgS1ZNIHZDUFUgb2JqZWN0IGluIHRoZSBIb3N0IEtWTSBpcyBub3QNCj4gID4gPiBkZXN0
cm95ZWQgID4gYXMgS1ZNIGRvZXNuJ3Qgc3VwcG9ydCB2Q1BVIHJlbW92YWwuIFRoZXJlZm9yZSwg
aXRzDQo+ICA+ID4gcmVwcmVzZW50YXRpdmUgS1ZNICA+IHZDUFUgb2JqZWN0L2NvbnRleHQgaW4g
UWVtdSBpcyBwYXJrZWQuDQo+ICA+ID4gID4NCj4gID4gPiAgPiBSZWZhY3RvciBhcmNoaXRlY3R1
cmUgY29tbW9uIGxvZ2ljIHNvIHRoYXQgc29tZSBBUElzIGNvdWxkIGJlDQo+ICA+ID4gcmV1c2Vk
ICA+IGJ5IHZDUFUgSG90cGx1ZyBjb2RlIG9mIHNvbWUgYXJjaGl0ZWN0dXJlcyBsaWtlcyBBUk0s
DQo+ICBMb29uZ3NvbiBldGMuDQo+ICA+ID4gID4gVXBkYXRlIG5ldy9vbGQgQVBJcyB3aXRoIHRy
YWNlIGV2ZW50cy4gTmV3IEFQSXMgID4NCj4gID4gPiBxZW11X3tjcmVhdGUscGFyayx1bnBhcmt9
X3ZjcHUoKSBjYW4gYmUgZXh0ZXJuYWxseSBjYWxsZWQuIE5vDQo+ICA+ID4gZnVuY3Rpb25hbCAg
Y2hhbmdlIGlzIGludGVuZGVkIGhlcmUuDQo+ICA+ID4NCj4gID4gPiAgSGk7IENvdmVyaXR5IHBv
aW50cyBvdXQgYW4gaXNzdWUgd2l0aCB0aGlzIGNvZGUgKENJRCAxNTU4NTUyKToNCj4gID4gPg0K
PiAgPiA+ICA+ICtpbnQga3ZtX3VucGFya192Y3B1KEtWTVN0YXRlICpzLCB1bnNpZ25lZCBsb25n
IHZjcHVfaWQpIHsNCj4gID4gPiAgPiArICAgIHN0cnVjdCBLVk1QYXJrZWRWY3B1ICpjcHU7DQo+
ICA+ID4gID4gKyAgICBpbnQga3ZtX2ZkID0gLUVOT0VOVDsNCj4gID4gPiAgPiArDQo+ICA+ID4g
ID4gKyAgICBRTElTVF9GT1JFQUNIKGNwdSwgJnMtPmt2bV9wYXJrZWRfdmNwdXMsIG5vZGUpIHsN
Cj4gID4gPiAgPiArICAgICAgICBpZiAoY3B1LT52Y3B1X2lkID09IHZjcHVfaWQpIHsNCj4gID4g
PiAgPiArICAgICAgICAgICAgUUxJU1RfUkVNT1ZFKGNwdSwgbm9kZSk7DQo+ICA+ID4gID4gKyAg
ICAgICAgICAgIGt2bV9mZCA9IGNwdS0+a3ZtX2ZkOw0KPiAgPiA+ICA+ICsgICAgICAgICAgICBn
X2ZyZWUoY3B1KTsNCj4gID4gPiAgPiArICAgICAgICB9DQo+ICA+ID4gID4gKyAgICB9DQo+ICA+
ID4NCj4gID4gPiAgSWYgeW91IGFyZSBnb2luZyB0byByZW1vdmUgYW4gZW50cnkgZnJvbSBhIGxp
c3QgYXMgeW91IGl0ZXJhdGUgb3Zlcg0KPiAgPiA+IGl0LCB5b3UgIGNhbid0IHVzZSBRTElTVF9G
T1JFQUNIKCksIGJlY2F1c2UgUUxJU1RfRk9SRUFDSCB3aWxsIGxvb2sNCj4gID4gPiBhdCB0aGUg
bmV4dCAgcG9pbnRlciBvZiB0aGUgaXRlcmF0aW9uIHZhcmlhYmxlIGF0IHRoZSBlbmQgb2YgdGhl
DQo+ICA+ID4gbG9vcCB3aGVuIGl0IHdhbnRzIHRvICBhZHZhbmNlIHRvIHRoZSBuZXh0IG5vZGUu
IEluIHRoaXMgY2FzZSB3ZSd2ZQ0KPiAgPiA+IGFscmVhZHkgZnJlZWQgJ2NwdScsIHNvIGl0IHdv
dWxkICBiZSByZWFkaW5nIGZyZWVkIG1lbW9yeS4NCj4gID4gPg0KPiAgPiA+ICBTaG91bGQgd2Ug
YnJlYWsgb3V0IG9mIHRoZSBsb29wIHdoZW4gd2UgZmluZCB0aGUgZW50cnk/DQo+ICA+DQo+ICA+
DQo+ICA+IFRoYW5rcyBmb3IgaWRlbnRpZnlpbmcgdGhpcy4gWWVzLCBhICBicmVhayBpcyBtaXNz
aW5nLiBTaG91bGQgSSBzZW5kIGENCj4gID4gZml4IGZvciB0aGlzIG5vdyBvciB5b3UgY2FuIGlu
Y29ycG9yYXRlIGl0Pw0KPiAgDQo+ICBUaGUgY29kZSBpcyBhbHJlYWR5IGluIHVwc3RyZWFtIGdp
dCwgc28gcGxlYXNlIHNlbmQgYSBwYXRjaCB0byBmaXggdGhlIGJ1Zy4NCg0KDQpTdXJlLCBkb25l
LiBQbGVhc2UgaGF2ZSBhIGxvb2ssDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNDA3MjUxNDUxMzIuOTkzNTUtMS1zYWxpbC5tZWh0YUBodWF3ZWkuY29tLw0KDQoNCkJl
c3QgcmVnYXJkcw0KU2FsaWwuDQoNCj4gIA0KPiAgdGhhbmtzDQo+ICAtLSBQTU0NCg==

