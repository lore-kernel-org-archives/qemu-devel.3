Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F70EC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzWC-0007L4-CW; Wed, 16 Jul 2025 06:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubzLR-0005T3-Qs; Wed, 16 Jul 2025 06:26:38 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ubzLL-0004xo-Pj; Wed, 16 Jul 2025 06:26:37 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhsd26KLRz6L5GG;
 Wed, 16 Jul 2025 18:25:10 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 71A011400D3;
 Wed, 16 Jul 2025 18:26:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 12:26:21 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 16 Jul 2025 12:26:21 +0200
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Thread-Topic: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Thread-Index: AQHb9OL/KzyFCa43q0WZckDJkcpGaLQz75CAgACTTuA=
Date: Wed, 16 Jul 2025 10:26:21 +0000
Message-ID: <d3396db488164f558aeafafd151aa7ee@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
In-Reply-To: <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
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
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTYsIDIwMjUgMzo1
OCBBTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZl
bEBub25nbnUub3JnOw0KPiBlcmljLmF1Z2VyQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOw0KPiBtb2Noc0BudmlkaWEuY29tOyBzbW9z
dGFmYUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6
aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiBqaWFuZ2t1bmt1biA8amlhbmdr
dW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOw0KPiB6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb207IHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggdjMgMTQvMTVdIFJlYWQgYW5kIHZhbGlkYXRlIGhvc3QgU01NVXYzIGZlYXR1cmUNCj4g
Yml0cw0KPiANCj4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMDQ6NTk6NDBQTSArMDEwMCwgU2hh
bWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52
aWRpYS5jb20+DQo+ID4NCj4gPiBOb3QgYWxsIGZpZWxkcyBpbiB0aGUgU01NVSBJRFIgcmVnaXN0
ZXJzIGFyZSBtZWFuaW5nZnVsIGZvciB1c2Vyc3BhY2UuDQo+ID4gT25seSB0aGUgZm9sbG93aW5n
IGZpZWxkcyBjYW4gYmUgdXNlZDoNCj4gPg0KPiA+IMKgIC0gSURSMDogU1RfTEVWRUwsIFRFUk1f
TU9ERUwsIFNUQUxMX01PREVMLCBUVEVORElBTiwgQ0QyTCwgQVNJRDE2LA0KPiBUVEYNCj4gPiDC
oCAtIElEUjE6IFNJRFNJWkUsIFNTSURTSVpFDQo+ID4gwqAgLSBJRFIzOiBCQk1MLCBSSUwNCj4g
PiDCoCAtIElEUjU6IFZBWCwgR1JBTjY0SywgR1JBTjE2SywgR1JBTjRLDQo+IA0KPiBCdXQgaGFs
ZiBvZiB0aGVzZSBmaWVsZHMgYXJlIG5vdCB2YWxpZGF0ZWQgaW4gdGhlIHBhdGNoIDotLw0KDQpU
aGF04oCZcyB3aHkgSSBzYWlkICIgVXNlIHRoZSByZWxldmFudCBmaWVsZHMgZnJvbSB0aGVzZSB0
byBjaGVjay4uIiAuDQpCdXQgc29ycnksIEkgd2FzIGNvbnNlcnZhdGl2ZSDimLkgYW5kIG5vdCBz
dXJlIHRoZSBTU0lEU0laRS9TVEFMTCBtYXR0ZXJlZA0KZm9yIG5vbiBwYXNpZCBjYXNlcy4NCg0K
PiBNeSB2U01NVSBkaWRuJ3Qgd29yayB1bnRpbCBJIGFkZGVkIGVudHJpZXMgbGlrZSBTSURTSVpF
LCBTU0lEU0laRSwNCj4gVEVSTV9NT0RFTCwgU1RBTExfTU9ERUwsIGFuZCBSSUwuDQoNCkhvdyBj
b21lIHlvdXIgdlNNTVUgbm90IHdvcmtpbmc/IE9yIHlvdSBtZWFudCB0aGUgYXNzaWduZWQNCmRl
diBpcyBub3Qgd29ya2luZz8NCg0KVGhlIGVtdWxhdGlvbiBzdXBwb3J0cyBTSURTSVpFID0gMTYg
YW5kIFJJTC4gQ291bGQgeW91IHBsZWFzZQ0Kc2hhcmUgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0
aGVzZSB2YWx1ZXMgdy5yLnQgaG9zdCBTTU1VdjMuDQoNCj4gSSB0aGluayBJRFI1Lk9BUyBzaG91
bGQgYmUgYWxzbyBhZGRlZCBpbiB0aGUgbGlzdC4gTWF5YmUgd2Ugc2hvdWxkDQo+IHVwZGF0ZSB0
aGUga2VybmVsIHVBUEkgbWVhbndoaWxlLg0KDQpPay4NCiANCj4gPiArICAgIHZhbCA9IEZJRUxE
X0VYMzIoc19hY2NlbC0+aW5mby5pZHJbNV0sIElEUjUsIEdSQU40Syk7DQo+ID4gKyAgICBpZiAo
dmFsIDwgRklFTERfRVgzMihzLT5pZHJbNV0sIElEUjUsIEdSQU40SykpIHsNCj4gPiArICAgICAg
ICBzLT5pZHJbNV0gPSBGSUVMRF9EUDMyKHMtPmlkcls1XSwgSURSNSwgR1JBTjRLLCB2YWwpOw0K
PiA+ICsgICAgfQ0KPiA+ICsgICAgdmFsID0gRklFTERfRVgzMihzX2FjY2VsLT5pbmZvLmlkcls1
XSwgSURSNSwgR1JBTjE2Syk7DQo+ID4gKyAgICBpZiAodmFsIDwgRklFTERfRVgzMihzLT5pZHJb
NV0sIElEUjUsIEdSQU4xNkspKSB7DQo+ID4gKyAgICAgICAgcy0+aWRyWzVdID0gRklFTERfRFAz
MihzLT5pZHJbNV0sIElEUjUsIEdSQU4xNkssIHZhbCk7DQo+ID4gKyAgICB9DQo+ID4gKyAgICB2
YWwgPSBGSUVMRF9FWDMyKHNfYWNjZWwtPmluZm8uaWRyWzVdLCBJRFI1LCBHUkFONjRLKTsNCj4g
PiArICAgIGlmICh2YWwgPCBGSUVMRF9FWDMyKHMtPmlkcls1XSwgSURSNSwgR1JBTjY0SykpIHsN
Cj4gPiArICAgICAgICBzLT5pZHJbNV0gPSBGSUVMRF9EUDMyKHMtPmlkcls1XSwgSURSNSwgR1JB
TjY0SywgdmFsKTsNCj4gDQo+IFVubGVzcyB0aGVyZSBpcyBzb21lIGNvbmZsaWN0cyBiZXR3ZWVu
IHRoZSBRRU1VIGVtdWxhdGlvbiBhbmQgdGhlDQo+IFNNTVUgSFcsIEkgdGhpbmsgd2Ugc2hvdWxk
IHByb2JhYmx5IGp1c3Qgb3ZlcnJpZGUgdGhlc2UgZmllbGRzIHRvDQo+IHRoZSBIVyB2YWx1ZXMs
IGluc3RlYWQgb2YgcnVubmluZyBjb21wYXJpc29ucy4gVGhlIGp1c3RpZmljYXRpb24NCj4gY291
bGQgYmUgdGhhdCB0aGVzZSBmaWVsZHMgYXJlIHVubGlrZWx5IGdvaW5nIHRvIGJlIGNvbnRyb2xs
ZWQgYnkNCj4gdGhlIFFFTVUgYnV0IHN1cHBvcnRlZCBkaXJlY3RseSBieSB0aGUgcmVhbCBIVy4N
Cj4gDQo+IEZvciBleGFtcGxlLCBpZiBIVyBzdXBwb3J0cyBTU0lEU0laRT01LCB0aGVyZSBzZWVt
cyB0byBiZSBubyBnb29kDQo+IHJlYXNvbiB0byBsaW1pdCBpdCB0byBTU0lEU0laRT00PyBFdmVu
IGlmIHRoZSBkZWZhdWx0IFNTSURTSVpFIGluDQo+IHRoZSBzbW11djNfaW5pdF9yZWdzKCkgaXMg
NC4NCj4gDQo+ID4gQEAgLTE5MDMsNiArMTkwNCw5IEBAIHN0YXRpYyB2b2lkIHNtbXVfcmVzZXRf
ZXhpdChPYmplY3QgKm9iaiwNCj4gUmVzZXRUeXBlIHR5cGUpDQo+ID4gICAgICB9DQo+ID4NCj4g
PiAgICAgIHNtbXV2M19pbml0X3JlZ3Mocyk7DQo+ID4gKyAgICBpZiAoc3lzLT5hY2NlbCkgew0K
PiA+ICsgICAgICAgIHNtbXV2M19hY2NlbF9pbml0X3JlZ3Mocyk7DQo+ID4gKyAgICB9DQo+IA0K
PiBJIGZlZWwgdGhhdCB3ZSBzaG91bGQgbGlrZWx5IGRvIGFuIGlmLWVsc2UgaW5zdGVhZCwgaS5l
Lg0KPiANCj4gICAgIGlmIChzeXMtPmFjY2VsKSB7DQo+ICAgICAgICAgc21tdXYzX2FjY2VsX2lu
aXRfcmVncyhzKTsNCj4gICAgIH0gZWxzZSB7DQo+ICAgICAgICAgc21tdXYzX2luaXRfcmVncyhz
KTsNCj4gICAgIH0NCj4gDQo+IFRoZSBzbW11djNfaW5pdF9yZWdzKCkgZW5hYmxlcyBjZXJ0YWlu
IGJpdHMgdGhhdCByZWFsbHkgc2hvdWxkIGJlDQo+IHNldCBieSB0aGUgcmV0dXJuZWQgSURScyBm
cm9tIGh3X2luZm8gaW4gc21tdXYzX2FjY2VsX2luaXRfcmVncygpLg0KPiANCj4gRG9pbmcgYW4g
b3ZlcnJpZGluZyBjYWxsIGNhbiBwb3RlbnRpYWxseSBnaXZlIHVzIHNvbWUgdHJvdWJsZSBpbg0K
PiB0aGUgZnV0dXJlIGlmIHRoZXJlIGFyZSBuZXcgYml0cyBiZWluZyBpbnRyb2R1Y2VkIGFuZCBl
bmFibGVkIGluDQo+IHNtbXV2M19pbml0X3JlZ3MoKSBidXQgbWlzc2VkIGluIHNtbXV2M19hY2Nl
bF9pbml0X3JlZ3MoKS4NCj4gDQo+IFNvLCBpdCBjYW4gYmUgc2ltcGxlciBpbiB0aGUgbG9uZyBy
dW4gaWYgc21tdXYzX2FjY2VsX2luaXRfcmVncygpDQo+IGluaXRpYWxpemVzIGluIGl0cyBvd24g
d2F5LCBJTUhPLg0KDQpPay4gQXJlIHlvdSBzdWdnZXN0aW5nIHdlIHNpbXBseSBvdmVycmlkZSB0
aGUgSURSIHZhbHVlcyBmcm9tIEhvc3Q/DQpJIGRvbid0IHRoaW5rIHRoYXQgaXMgYSBnb29kIGlk
ZWEgYXMgaXQgaXMgbm90IGp1c3QgdGhlIElEUiB2YWx1ZXMgdGhhdA0KZGV0ZXJtaW5lcyB0aGUg
aG9zdCBmZWF0dXJlcy4gQW5kIHdlIGhhZCBhIGRpc2N1c3Npb24gb24gdGhpcyANCmluIHYyIGFu
ZCB0aGUgc3VnZ2VzdGlvbiB3YXMgIiB2bW0gc2hvdWxkIG5vdCBiZSBjb3B5aW5nIElEUiBmaWVs
ZHMNCmJsaW5kbHkuLi4iDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvWitW
TkEraEZ1MExKbjE5bEBudmlkaWEuY29tLw0KDQpQcm9iYWJseSB3ZSBzaG91bGQgdGFrZSBhIGxv
b2sgYXQgSW50ZWwgdnRkIGltcGxlbWVudGF0aW9uIG1lbnRpb25lZA0KYnkgWmhlbnpob25nIGlu
IHRoZSBvdGhlciB0aHJlYWQgd2hlcmUgaXQgbG9va3MgbGlrZSB0aGVyZSBzZWVtcyB0byBiZQ0K
YSBwcm9wZXJ0eSBmb3IgZWFjaCBjYXBhYmlsaXR5IHRoZXkgY2FyZSBhYm91dC4NCg0KUHJvYmFi
bHkgc29tZXRoaW5nIGxpa2UsDQotZGV2aWNlIGFybS1zbW11djMsYWNjZWw9b24scGFzaWRfY2Fw
PW9uLA0KDQpBbmQgdGhlbiBlbmFibGluZyBhbGwgZmVhdHVyZXMgcmVsYXRlZCB0byBwYXNpZCBh
bmQgb24gbGF0ZXIgd2hlbg0Kd2UgcmV0cmlldmUgdGhlIEhXX0lORk8gb24gZGV2aWNlIHBsdWcs
IGNvbXBhcmUgYW5kIGZhaWwgaWYgbm90Pw0KDQpCdXQgSSB0aGluayBvbiBBUk0sIHdlIHN0aWxs
IHdlIGhhdmUgbGltaXRhdGlvbnMgaW4ga25vd2luZyB0aGUgYWN0dWFsDQpob3N0IHN1cHBvcnRl
ZCBmZWF0dXJlcyB0aHJvdWdoIElEUi4gSW4gdGhhdCBjYXNlLCB3ZSBjYW4gb25seSBhc3N1bWUN
CnRoYXQgdXNlciBpcyBtYWtpbmcgYW4gaW5mb3JtZWQgZGVjaXNpb24gd2hpbGUgZW5hYmxpbmcg
dGhlc2UgZmVhdHVyZXMuDQoNClRoYW5rcywNClNoYW1lZXINCg0KDQo=

