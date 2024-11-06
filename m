Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16017D44D58
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fvK-0005yT-0x; Wed, 06 Nov 2024 08:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8fvH-0005vu-Th; Wed, 06 Nov 2024 08:18:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8fvF-0006dv-AY; Wed, 06 Nov 2024 08:18:11 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xk5Lz6CkLz6JBSG;
 Wed,  6 Nov 2024 21:16:27 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id 4425214011D;
 Wed,  6 Nov 2024 21:18:05 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:18:05 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 6 Nov 2024 14:18:05 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "maz@kernel.org" <maz@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>
Subject: RE: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs
 for reuse
Thread-Topic: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs
 for reuse
Thread-Index: AQHbLgSbwU64kgKDNkuiSDBIJV8mp7KnDaaAgAI3n/CAAOW0gIAAFNFQ
Date: Wed, 6 Nov 2024 13:18:04 +0000
Message-ID: <34aa0c9efb3144ab80a444144810b264@huawei.com>
References: <20241103152455.202462-1-salil.mehta@huawei.com>
 <CAFEAcA91DoU4dAHYy6OOeMjEQ+0LGZX8KM-rKsCh89UnFS4yTQ@mail.gmail.com>
 <7d27ceab963441dc8355d06e6bc4b88d@huawei.com>
 <CAFEAcA9Jhz9a-X0B_bW++3kUePzTENJfq520A0CEst1o+QES4Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9Jhz9a-X0B_bW++3kUePzTENJfq520A0CEst1o+QES4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.112]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SEkgUGV0ZXIsDQoNCj4gIEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4gIFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgNiwgMjAyNCAxOjAxIFBNDQo+ICBU
bzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICANCj4gIE9uIFR1ZSwg
NSBOb3YgMjAyNCBhdCAyMjoyMCwgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+
IHdyb3RlOg0KPiAgPg0KPiAgPiBISSBQZXRlciwNCj4gID4NCj4gID4gPiAgRnJvbTogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiAgPiA+ICBTZW50OiBNb25kYXks
IE5vdmVtYmVyIDQsIDIwMjQgMToyNyBQTQ0KPiAgPiA+ICBUbzogU2FsaWwgTWVodGEgPHNhbGls
Lm1laHRhQGh1YXdlaS5jb20+DQo+ICA+ID4NCj4gID4gPiAgT24gU3VuLCAzIE5vdiAyMDI0IGF0
IDE1OjI1LCBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gIHdyb3RlOg0K
PiAgPiA+ICA+DQo+ICA+ID4gID4gRXh0cmFjdCBjb21tb24gR0lDIGFuZCBDUFUgaW50ZXJydXB0
IHdpcmluZyBjb2RlIHRvIGltcHJvdmUgY29kZQ0KPiAgPiA+ID4gcmVhZGFiaWxpdHkgYW5kIG1v
ZHVsYXJpdHksIHN1cHBvcnRpbmcgcmV1c2UgaW4gZnV0dXJlIHBhdGNoIHNldHMuDQo+ICA+ID4g
ID4gVGhpcyByZWZhY3RvciBpcyBiZW5pZ24gYW5kIGludHJvZHVjZXMgKm5vKiBmdW5jdGlvbmFs
IGNoYW5nZXMuDQo+ICA+ID4gID4NCj4gID4gPiAgPiBOb3RlOiBUaGlzIHBhdGNoIGhhcyBiZWVu
IGlzb2xhdGVkIGZyb20gYSBsYXJnZXIgcGF0Y2ggc2V0IHRvICA+DQo+ICA+ID4gZmFjaWxpdGF0
ZSBlYXJseSBtZXJnaW5nIGFuZCByZWR1Y2UgdGhlIGNvbXBsZXhpdHkgb2YgdGhlIG9yaWdpbmFs
DQo+ICA+ID4gPiBzZXQsIGFzIGl0IG9wZXJhdGVzIGluZGVwZW5kZW50bHkuIEFsbCBvcmlnaW5h
bCB0YWdzIGFuZCBhdXRob3IgID4NCj4gID4gPiBjb250cmlidXRpb25zIGFyZSByZXRhaW5lZC4N
Cj4gID4gPg0KPiAgPiA+ICBJIHdvdWxkIHByZWZlciB0byBzZWUgcmVmYWN0b3JpbmcgcGF0Y2hl
cyBpbiB0aGUgY29udGV4dCBvZiB0aGUNCj4gID4gPiBzZXJpZXMgdGhhdCAgbWFrZXMgdGhlbSBu
ZWNlc3NhcnkuIEFzIGl0IHN0YW5kcywgdGhlcmUgZG9lc24ndA0KPiAgPiA+IHJlYWxseSBzZWVt
IHRvIGJlIG11Y2ggIGJlbmVmaXQgdG8gdGhpcyBjaGFuZ2UuDQo+ICA+DQo+ICA+DQo+ICA+IE9r
IG5vIGlzc3Vlcy4gSnVzdCB0byBjb25maXJtLCB5b3VyIGFib3ZlIGNvbW1lbnQgaXMganVzdCBz
cGVjaWZpYyB0bw0KPiAgPiB0aGlzIHBhdGNoIG9yIGFsbCB0aGUgMyBpbmRpdmlkdWFsIHBhdGNo
ZXMgSSBoYWQgc2VudCBmb3IgcmV2aWV3Pw0KPiAgDQo+ICBJdCBhcHBsaWVzIHRvIGFsbCBvZiB0
aGVtIChhbmQgYXMgYSBnZW5lcmFsIHByaW5jaXBsZSkuDQoNCg0KR290IGl0LiBJIHRob3VnaHQg
Y2hhbmdlcyBpbiBiZWxvdyBwYXRjaGVzIHdlcmUgaW4gYW55IGNhc2UgdXNlZnVsIGFzIHRoZXkg
d2VyZQ0KaW1wcm92aW5nIHRoZSBjb2RlPw0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjQxMTAzMTUyMjU2LjIwMjQ0NC0xLXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQpo
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMTAzMTUyNjM5LjIwMjQ4MC0x
LXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQoNClRoYW5rcw0KDQo+ICANCj4gIHRoYW5rcw0KPiAg
LS0gUE1NDQo=

