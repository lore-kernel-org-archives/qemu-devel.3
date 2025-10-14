Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D7ACCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8h7s-0006gj-De; Tue, 14 Oct 2025 11:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8h7p-0006gY-0G
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:39:46 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8h7k-0001Kh-GL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:39:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmJH026JKz6GDQJ;
 Tue, 14 Oct 2025 23:36:44 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 692FC14037D;
 Tue, 14 Oct 2025 23:39:34 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 16:39:34 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 16:39:34 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q///z8ACAABG8wP//+S2AAAIw8TD///c1gP//7sZQgAAX3QD//+w+sA==
Date: Tue, 14 Oct 2025 15:39:33 +0000
Message-ID: <e8aba327f32d45d9828b0bc6a038f750@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
 <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
 <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
 <CAFEAcA8-QGBGqjw3Eefx_yyz_30azn9Trz-OGSxq7v4N=X+26Q@mail.gmail.com>
 <a630fc58d9f946988bd6c27479543dd1@huawei.com>
 <CAFEAcA8GsSDnY8GEJZYNbJ3KZAp9tJ=s_vUBB_XwwGaEwozxzQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8GsSDnY8GEJZYNbJ3KZAp9tJ=s_vUBB_XwwGaEwozxzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.67.200]
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

PiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMTQsIDIwMjUgNDoyNCBQTQ0KPiBUbzogU2FsaWwgTWVodGEgPHNh
bGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IA0KPiBPbiBUdWUsIDE0IE9jdCAyMDI1IGF0IDE2OjEz
LCBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+
IEZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gSW4gd2hhdCBz
aXR1YXRpb24gZG8NCj4gPiA+IHdlIGV2ZXIgc3RhcnQgcnVubmluZyBhIFZDUFUgYmVmb3JlIHRo
ZSAqR0lDKiBoYXMgYmVlbiByZWFsaXplZD8gVGhlDQo+ID4gPiBHSUMgc2hvdWxkIGdldCByZWFs
aXplZCBhcyBwYXJ0IG9mIGNyZWF0aW5nIHRoZSB2aXJ0IGJvYXJkLCB3aGljaA0KPiA+ID4gbXVz
dCBjb21wbGV0ZSBiZWZvcmUgd2UgZG8gYW55dGhpbmcgbGlrZSBydW5uaW5nIGEgdmNwdS4NCj4g
Pg0KPiA+DQo+ID4gSnVzdCBhZnRlciByZWFsaXphdGlvbiBvZiB2Q1BVIGluIHRoZSBtYWNodmly
dF9pbml0KCkgeW91IGNhbiBzZWUgdGhlDQo+ID4gZGVmYXVsdCBwb3dlcl9zdGF0ZSBpcyBQU0NJ
IENQVV9PTiwgd2hpY2ggbWVhbnMNCj4gS1ZNX01QX1NUQVRFX1JVTk5BQkxFLg0KPiA+IFNpbmNl
LCB0aGUgdGhyZWFkIGlzIHVwIGFuZCBub3QgZG9pbmcgSU8gd2FpdCBpbiB1c2Vyc3BhY2UgaXQg
Z2V0cw0KPiA+IGludG8NCj4gPiBjcHVfZXhlYygpIGxvb3AgYW5kIGFjdHVhbGx5IHJ1biBLVk1f
UlVOIElPQ1RMLiBJbnNpZGUgdGhlIEtWTSBpdA0KPiA+IG1vbWVudGFyaWx5IHRha2VzIHRoZSB2
Q1BVIG11dGV4IGJ1dCBsYXRlciBleGl0IGFuZCByZWxlYXNlcy4gVGhpcw0KPiA+IGtlZXBzIGdv
aW5nIG9uIGZvciBhbGwgb2YgdGhlIHZDUFUgdGhyZWFkcyByZWFsaXplZCBlYXJseS4NCj4gDQo+
IFlpa2VzLiBXZSBkZWZpbml0ZWx5IHNob3VsZCBmaXggdGhhdCA6IGxldHRpbmcgdGhlIHZjcHUg
cnVuIGJlZm9yZSB3ZSBnZXQgdG8NCj4gcWVtdV9tYWNoaW5lX2NyZWF0aW9uX2RvbmUoKSBzZWVt
cyBsaWtlIGl0IHdvdWxkIGJlIGEgbWFzc2l2ZSBzb3VyY2Ugb2YNCj4gcmFjZSBjb25kaXRpb25z
Lg0KDQoNCkJUVywgSSBkaWQgcmFpc2UgdGhpcyBpc3N1ZSBpbiB0aGUgbGFzdCBLVk0gQ2FsbCB3
aXRoIEFsZXggQmVubsOpZQ0KDQoNCkJlc3QgcmVnYXJkcw0KU2FsaWwuDQo=

