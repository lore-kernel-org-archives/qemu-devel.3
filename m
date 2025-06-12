Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549DAC71143
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPidV-0006jf-4P; Thu, 12 Jun 2025 10:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uPidS-0006j3-Cc
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:10:30 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uPidN-0003r3-Vh
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:10:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ42p4kM6z6L532;
 Thu, 12 Jun 2025 22:01:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 596C714020C;
 Thu, 12 Jun 2025 22:06:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 16:06:16 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 12 Jun 2025 16:06:16 +0200
To: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
 Nicolin Chen <nicolinc@nvidia.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJHUawRnIodOUq2mz8F4Dn7BLPdj0MAgAIQvoCAAPjWAIADz6UAgACqsQCAAnaBgIAYEmR9gAAR++A=
Date: Thu, 12 Jun 2025 14:06:15 +0000
Message-ID: <7b684d1b8454496f9a302c66298daf37@huawei.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
In-Reply-To: <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWkgTGl1IDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEyLCAyMDI1IDE6NTQgUE0NCj4g
VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsgTmljb2xpbiBD
aGVuDQo+IDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiBDYzogUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBhbGV4LndpbGxpYW1zb25AcmVkaGF0
LmNvbTsgY2xnQHJlZGhhdC5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsNCj4gbXN0QHJlZGhh
dC5jb207IGphc293YW5nQHJlZGhhdC5jb207IGRkdXRpbGVAcmVkaGF0LmNvbTsNCj4gamdnQG52
aWRpYS5jb207IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3Ro
dW0udGhvZGlAaHVhd2VpLmNvbT47IGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb207DQo+IGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tOyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRl
bC5jb20+Ow0KPiBQZW5nLCBDaGFvIFAgPGNoYW8ucC5wZW5nQGludGVsLmNvbT47IFlpIFN1biA8
eWkueS5zdW5AbGludXguaW50ZWwuY29tPjsNCj4gTWFyY2VsIEFwZmVsYmF1bSA8bWFyY2VsLmFw
ZmVsYmF1bUBnbWFpbC5jb20+OyBQYW9sbyBCb256aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29t
PjsgUmljaGFyZCBIZW5kZXJzb24NCj4gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBF
ZHVhcmRvIEhhYmtvc3QNCj4gPGVkdWFyZG9AaGFia29zdC5uZXQ+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggcmZjdjMgMTUvMjFdIGludGVsX2lvbW11OiBCaW5kL3VuYmluZCBndWVzdCBwYWdlDQo+
IHRhYmxlIHRvIGhvc3QNCiANCj4gPj4gVGhlICJzd2l0Y2giIGluIHZTTU1VIG1vZGVsIGlzIG9u
bHkgbmVlZGVkIGJ5IEtWTSBmb3IgTVNJIGRvb3JiZWxsDQo+ID4+IHRyYW5zbGF0aW9uLiBCeSB0
aGlua2luZyBpdCBjYXJlZnVsbHksIG1heWJlIGl0IHNob3VsZG4ndCBzd2l0Y2ggQVMNCj4gPj4g
YmVjYXVzZSBWRklPIG1pZ2h0IGJlIGNvbmZ1c2VkIGlmIGl0IHNvbWVob3cgZG9lcyBnZXRfYWRk
cmVzc19zcGFjZQ0KPiA+PiBhZ2FpbiBpbiB0aGUgZnV0dXJlLi4NCj4gDQo+IEBOaWNvbGluLCBu
b3QgcXVpdGUgZ2V0IHRoZSBkZXRhaWxlZCBsb2dpYyBmb3IgdGhlIE1TSSBzdHVmZiBvbiBTTU1V
LiBCdXQgSQ0KPiBhZ3JlZSB3aXRoIHRoZSBsYXN0IHNlbnRlbmNlLiBnZXRfYWRkcmVzc19zcGFj
ZSBzaG91bGQgcmV0dXJuIGEgY29uc2lzdGVudA0KPiBBUy4NCg0KSSB0aGluayBpdCBpcyBiZWNh
dXNlLCBpbiBBUk0gd29ybGQgdGhlIE1TSSBkb29yYmVsbCBhZGRyZXNzIGlzIHRyYW5zbGF0ZWQg
YnkNCmFuIElPTU1VLiBIZW5jZSwgaWYgdGhlIEd1ZXN0IGRldmljZSBpcyBiZWhpbmQgSU9NTVUs
IGl0IG5lZWRzIHRvIHJldHVybg0KdGhlIElPTU1VIEFTIGluLA0KDQprdm1faXJxY2hpcF9hZGRf
bXNpX3JvdXRlKCkNCiBrdm1fYXJjaF9maXh1cF9tc2lfcm91dGUoKQ0KICAgcGNpX2RldmljZV9p
b21tdV9hZGRyZXNzX3NwYWNlKCkgIC0tPiAuZ2V0X2FkZHJlc3Nfc3BhY2UoKSAgLS0+QXQgdGhp
cyBwb2ludCB3ZSBub3cgcmV0dXJuIElPTU1VIEFTLg0KDQpJZiBub3QgdGhlIGRldmljZSB3aWxs
IGJlIGNvbmZpZ3VyZWQgd2l0aCBhICB3cm9uZyBNU0kgZG9vcmJlbGwgYWRkcmVzcy4NCg0KTmlj
b2xpbiwgeW91IHNlZW1zIHRvIHN1Z2dlc3Qgd2UgY291bGQgYXZvaWQgdGhpcyBzd2l0Y2hpbmcg
YW5kIGFsd2F5cyByZXR1cm4NClN5c3RlbSBBUy4gRG9lcyB0aGF0IG1lYW4gd2UgaGFuZGxlIHRo
aXMgS1ZNL01TSSBjYXNlIHNlcGFyYXRlbHk/DQpDb3VsZCB5b3UgcGxlYXNlIGRldGFpbCBvdXQg
dGhlIGlkZWE/DQoNClRoYW5rcywNClNoYW1lZXINCg0K

