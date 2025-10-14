Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE80FCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fvs-0007mz-QW; Tue, 14 Oct 2025 10:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8fvp-0007ma-4e
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:23:17 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8fvb-0006ri-L0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:23:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmGZV4KBXz6GDSK;
 Tue, 14 Oct 2025 22:20:02 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 905BF1402F0;
 Tue, 14 Oct 2025 22:22:52 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 15:22:52 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 15:22:52 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0D///KGAIAAES+Q///z8ACAABG8wA==
Date: Tue, 14 Oct 2025 14:22:52 +0000
Message-ID: <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
In-Reply-To: <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
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
 RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgUGV0ZXIsDQoNCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE0LCAyMDI1IDI6NTAgUE0NCj4gVG86IFNh
bGlsIE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiANCj4gT24gVHVlLCAxNCBPY3Qg
MjAyNSBhdCAxNDo0MSwgU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+IHdyb3Rl
Og0KPiA+IEkgdGhvdWdodCB5b3UgYXNrZWQgbWUgdG8gdmFsaWRhdGUgdGhlIGZpeCBieSByZXBs
YWNpbmcgYmVsb3c6DQo+ID4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVs
LzIwMjUxMDAxMDEwMTI3LjMwOTI2MzEtMjItc2FsaWwubWVoDQo+ID4gdGFAb3Buc3JjLm5ldC8N
Cj4gPg0KPiA+DQo+ID4gWWVzLCBJJ20gdXNpbmcgdGhlIHJlY2VudCBSRkMgVjYgdkNQVSBIb3Rw
bHVnIHBhdGNoZXMgYnJhbmNoIEkndmUNCj4gPiBwdXNoZWQgdG8gdGhlIGNvbW11bml0eS4NCj4g
Pg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEwMDEwMTAxMjcu
MzA5MjYzMS0xLXNhbGlsLm1laHQNCj4gPiBhQG9wbnNyYy5uZXQvDQo+IA0KPiBUaGF0J3MgdGhl
IG9uZSB3aXRoIHRoZSAibGF6eSByZWFsaXplIiBoYWNrLCByaWdodD8gSSBpbWFnaW5lIHdoYXQn
cyBoYXBwZW5pbmcNCj4gaXMgdGhhdCB3ZSByZWFsaXplIHRoZSBHSUMsIGFuZCB0aGUgY29kZSBp
biB0aGlzIHBhdGNoIGFzc3VtZXMgdGhhdCBhbGwgdGhlDQo+IENQVXMgYXJlIGFscmVhZHkgcmVh
bGl6ZWQgYXQgdGhhdCBwb2ludC4gV2hlbiB3ZSB0cnkgdG8gZ2V0IHRoZSByZWdpc3RlciB2YWx1
ZQ0KPiBmb3IgYSBub3QteWV0LXJlYWxpemVkIENQVSB0aGUga2VybmVsIGNvbXBsYWlucy4NCg0K
DQpFdmVuIGlmIHdlIHJlYWxpemUgYWxsIG9mIHRoZSB2Q1BVcyB0aGUgcHJvYmxlbSB3aWxsIG5v
dCBnbyBhd2F5LiBUaGlzIHByb2JsZW0NCmlzIGhhcHBlbmluZyBiZWNhdXNlIHdlIGhhdmUgcmVj
ZW50bHkgc3RhcnRlZCB0byBFeGl0IEh5cGVyY2FsbHMgdG8gdXNlcnNwYWNlLg0KVGhpcyBtZWFu
cyB3ZSBhcmUgbm93IGFjY2Vzc2luZyB0aGUgc3lzdGVtIHJlZ2lzdGVyIGluIGEgbm9uLWF0b21p
YyBjb250ZXh0Lg0KDQpJbiBmYWN0IGluIGNvbnRyYXJ5IHRvIGFib3ZlLCBsYXp5IHJlYWxpemF0
aW9uIGFjdHVhbGx5IGhlbHBzIGluIHJlZHVjaW5nIHRoZSB2Q1BVDQpsb2NrIGNvbnRlbnRpb24g
YXMgdGhlcmUgYXJlIG5vIHRocmVhZHMgcnVubmluZyB3aXRoaW4gS1ZNX1JVTiBJT0NUTC4gSGVu
Y2UsDQp0aG9zZSB0aHJlYWRzIGRvIG5vdCB0YWtlIHRoZSBsb2NrIGFuZCBoZW5jZSBkbyBub3Qg
Y2F1c2UgbG9jayBjb250ZW50aW9uLg0KDQpJZiB3ZSBhcmUgaGFuZGxpbmcgSFZDIGFuZCByZXNl
dHRpbmcgdGhlIHN5c3RlbSByZWdpc3RlciBpbiB2Q1BVIHRocmVhZCBjb250ZXh0DQp0aGVuIHdl
IGFyZSBhbHJlYWR5IGluIGF0b21pYyBjb250ZXh0IGFzIHZDUFUgbXV0ZXhlcyBhcmUgdGFrZW4g
aW5zaWRlIHRoZSBLVk0gLg0KVGhlIHByb2JsZW0gd2hhdCB3ZSBhcmUgc2VlaW5nIGNvbWVzIGlu
dG8gcGljdHVyZSBvbmx5IHdoZW4gd2UgYXJlIHRyeWluZyB0bw0KYWNjZXNzIHRoZSBzeXN0ZW0g
cmVnaXN0ZXJzIHdpdGhvdXQgaG9sZGluZyB2Q1BVIG11dGV4IGxvY2sgYmVjYXVzZSB3ZSBhcmUN
Cm5vdCBpbiBLVk1fUlVOIElPQ1RMLg0KDQpGb3IgZXhhbXBsZSwNCjEuIFdoZW4gd2UgRXhpdCB0
aGUgSFZDLlNNQyBIeXBlcmNhbGwgaW50byB1c2Vyc3BhY2UgYW5kIGFjY2VzcyB0aGUgSUNDX0NU
TFJfRUwxDQpzeXN0ZW0gcmVnaXN0ZXIgdmlhIEtWTSBEZXZpY2UgSU9DVEwuDQoNCk9SDQoNCjIu
IExpa2UgaW4gdGhlIGN1cnJlbnQgcGF0Y2gsIHdlIGFyZSB0cnlpbmcgdG8gYWNjZXNzIElDQ19D
VExSX0VMMSB3aGVuIHdlIGFyZSBub3QNCmluIGFueSB2Q1BVIGNvbnRleHQgcnVubmluZyBpbnNp
ZGUgS1ZNX1JVTiBJT0NUTC4gSGVyZSwgd2Ugd2lsbCBtb3N0IHByb2JhYmx5DQpjb250ZW5kIHdp
dGggQ1BVMCBoZWxkIG11dGV4IChhdCBsZWFzdCkNCg0KDQoNCj4gDQo+IChJIHN0cm9uZ2x5IGFn
cmVlIHdpdGggSWdvcidzIHJldmlldyByZW1hcmtzIGhlcmUNCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcWVtdS1kZXZlbC8yMDI1MTAwNjE2MDAyNy4yMDA2N2ZlNEBmZWRvcmEvDQo+IHRoYXQg
bGF6eSByZWFsaXppbmcgb2YgQ1BVIG9iamVjdHMgaXMgYSBiYWQgaWRlYS4pDQoNCg0KVGhlIG9i
c2VydmF0aW9uIHlvdSBhcmUgc2VlaW5nIGhhcyBnb3Qgbm90aGluZyB0byBkbyB3aXRoIGxhenkg
cmVhbGl6YXRpb24uDQpUaGUgcHJvYmxlbSBoYXBwZW5zIGV2ZW4gYWZ0ZXIgdGhyZWFkcyBhcmUg
cmVhbGl6ZWQgYW5kIHRoZW4gd2UgdHJ5IHRvIGFjY2Vzcw0KdGhlIElDQ19DVExSX0VMMSByZWdp
c3RlciBkdXJpbmcgY3B1X3Jlc2V0KCkNCg0KDQpNYW55IHRoYW5rcyENCg0KQmVzdCByZWdhcmRz
DQpTYWxpbC4NCg0K

