Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03195C25B7A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 18:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s986Q-0005fy-9l; Mon, 20 May 2024 14:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s986O-0005fj-Vl; Mon, 20 May 2024 14:51:17 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1s986M-0006iL-IB; Mon, 20 May 2024 14:51:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8458ECE0C4F;
 Mon, 20 May 2024 18:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490F0C2BD10;
 Mon, 20 May 2024 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716231069;
 bh=skl0GM71jqxx5Gj3SvDrKZAauGdo1OU/uEj35Eh4Uo8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jUbmvgkGIC3tAUUndLNS26sLTap6OOzdtJC9ekuUU06gedLlC8S34zHPYVvdK+kCL
 96mpJR6Y91hSe1EvfSy3RQgtin7RzfqIu/VZfc7hmLp8uPoYWTxWkE069wb7zpuNZj
 l09+MJTXIvQlU6oU7Dt4hZPns8cra5NN+F7InfrAxzGCdLV2iNsg0Qp9kbxg3W69Y7
 XABcrilgHFHz/NAZpnl+EKWN0fY0c5U0/5oy5n2ty1j9+qe5uHtzdKklMR8edYJdC/
 IwXforJd+AMmZQiEgBdrNSZqsfCXOgL+CF2Buf+HBQDZlF+JwXdphwnaYASIQjZ0kc
 LhY/wocze/KcQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, David Hildenbrand
 <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Sunil V L
 <sunilvl@ventanamicro.com>,
 Santosh Mamila <santosh.mamila@catalinasystems.io>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>
Subject: Re: [PATCH] hw/riscv/virt: Add hotplugging and virtio-md-pci support
In-Reply-To: <afbd3799-fa2a-4c7d-8097-aeaedecf4ec3@ventanamicro.com>
References: <20240514110615.399065-1-bjorn@kernel.org>
 <3cb00bbb-7742-40b7-858c-4bdd2f9cc79b@ventanamicro.com>
 <91086379-1fbc-4179-863a-6bb2e797d564@redhat.com>
 <afbd3799-fa2a-4c7d-8097-aeaedecf4ec3@ventanamicro.com>
Date: Mon, 20 May 2024 20:51:06 +0200
Message-ID: <87v838uxk5.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=145.40.73.55; envelope-from=bjorn@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RGFuaWVsL0RhdmlkLA0KDQpEYW5pZWwgSGVucmlxdWUgQmFyYm96YSA8ZGJhcmJvemFAdmVudGFu
YW1pY3JvLmNvbT4gd3JpdGVzOg0KDQo+IE9uIDUvMTgvMjQgMTY6NTAsIERhdmlkIEhpbGRlbmJy
YW5kIHdyb3RlOg0KPj4gDQo+PiBIaSwNCj4+IA0KPj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9ody9y
aXNjdi92aXJ0LmMgYi9ody9yaXNjdi92aXJ0LmMNCj4+Pj4gaW5kZXggNGZkYjY2MDUyNTg3Li4x
NmMyYmRiZmU2YjYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3Jpc2N2L3ZpcnQuYw0KPj4+PiArKysg
Yi9ody9yaXNjdi92aXJ0LmMNCj4+Pj4gQEAgLTUzLDYgKzUzLDggQEANCj4+Pj4gwqDCoCAjaW5j
bHVkZSAiaHcvcGNpLWhvc3QvZ3BleC5oIg0KPj4+PiDCoMKgICNpbmNsdWRlICJody9kaXNwbGF5
L3JhbWZiLmgiDQo+Pj4+IMKgwqAgI2luY2x1ZGUgImh3L2FjcGkvYW1sLWJ1aWxkLmgiDQo+Pj4+
ICsjaW5jbHVkZSAiaHcvbWVtL21lbW9yeS1kZXZpY2UuaCINCj4+Pj4gKyNpbmNsdWRlICJody92
aXJ0aW8vdmlydGlvLW1lbS1wY2kuaCINCj4+Pj4gwqDCoCAjaW5jbHVkZSAicWFwaS9xYXBpLXZp
c2l0LWNvbW1vbi5oIg0KPj4+PiDCoMKgICNpbmNsdWRlICJody92aXJ0aW8vdmlydGlvLWlvbW11
LmgiDQo+Pj4+IEBAIC0xNDA3LDYgKzE0MDksNyBAQCBzdGF0aWMgdm9pZCB2aXJ0X21hY2hpbmVf
aW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+Pj4+IMKgwqDCoMKgwqDCoCBEZXZpY2VTdGF0
ZSAqbW1pb19pcnFjaGlwLCAqdmlydGlvX2lycWNoaXAsICpwY2llX2lycWNoaXA7DQo+Pj4+IMKg
wqDCoMKgwqDCoCBpbnQgaSwgYmFzZV9oYXJ0aWQsIGhhcnRfY291bnQ7DQo+Pj4+IMKgwqDCoMKg
wqDCoCBpbnQgc29ja2V0X2NvdW50ID0gcmlzY3Zfc29ja2V0X2NvdW50KG1hY2hpbmUpOw0KPj4+
PiArwqDCoMKgIGh3YWRkciBkZXZpY2VfbWVtb3J5X2Jhc2UsIGRldmljZV9tZW1vcnlfc2l6ZTsN
Cj4+Pj4gwqDCoMKgwqDCoMKgIC8qIENoZWNrIHNvY2tldCBjb3VudCBsaW1pdCAqLw0KPj4+PiDC
oMKgwqDCoMKgwqAgaWYgKFZJUlRfU09DS0VUU19NQVggPCBzb2NrZXRfY291bnQpIHsNCj4+Pj4g
QEAgLTE1NTMsNiArMTU1NiwyNSBAQCBzdGF0aWMgdm9pZCB2aXJ0X21hY2hpbmVfaW5pdChNYWNo
aW5lU3RhdGUgKm1hY2hpbmUpDQo+Pj4+IMKgwqDCoMKgwqDCoCBtZW1vcnlfcmVnaW9uX2FkZF9z
dWJyZWdpb24oc3lzdGVtX21lbW9yeSwgbWVtbWFwW1ZJUlRfTVJPTV0uYmFzZSwNCj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbWFza19yb20pOw0KPj4+PiArwqDCoMKgIGRldmljZV9tZW1vcnlfYmFzZSA9IFJP
VU5EX1VQKHMtPm1lbW1hcFtWSVJUX0RSQU1dLmJhc2UgKyBtYWNoaW5lLT5yYW1fc2l6ZSwNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBHaUIpOw0KPj4+PiArwqDCoMKgIGRldmljZV9tZW1vcnlfc2l6ZSA9IG1h
Y2hpbmUtPm1heHJhbV9zaXplIC0gbWFjaGluZS0+cmFtX3NpemU7DQo+Pj4+ICsNCj4+Pj4gK8Kg
wqDCoCBpZiAocmlzY3ZfaXNfMzJiaXQoJnMtPnNvY1swXSkpIHsNCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIGh3YWRkciBtZW10b3AgPSBkZXZpY2VfbWVtb3J5X2Jhc2UgKyBST1VORF9VUChkZXZpY2Vf
bWVtb3J5X3NpemUsIEdpQik7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChtZW10
b3AgPiBVSU5UMzJfTUFYKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3Jl
cG9ydCgiTWVtb3J5IGV4Y2VlZHMgMzItYml0IGxpbWl0IGJ5ICVsdSBieXRlcyIsDQo+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVtdG9wIC0g
VUlOVDMyX01BWCk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4aXQoRVhJVF9GQUlM
VVJFKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4+Pj4gK8KgwqDCoCB9DQo+Pj4+ICsNCj4+
Pj4gK8KgwqDCoCBpZiAoZGV2aWNlX21lbW9yeV9zaXplID4gMCkgew0KPj4+PiArwqDCoMKgwqDC
oMKgwqAgbWFjaGluZV9tZW1vcnlfZGV2aWNlc19pbml0KG1hY2hpbmUsIGRldmljZV9tZW1vcnlf
YmFzZSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlX21lbW9yeV9zaXplKTsNCj4+Pj4gK8Kg
wqDCoCB9DQo+Pj4+ICsNCj4+Pg0KPj4+IEkgdGhpbmsgd2UgbmVlZCBhIGRlc2lnbiBkaXNjdXNz
aW9uIGJlZm9yZSBwcm9jZWVkaW5nIGhlcmUuIFlvdSdyZSBhbGxvY2F0aW5nIGFsbA0KPj4+IGF2
YWlsYWJsZSBtZW1vcnkgYXMgYSBtZW1vcnkgZGV2aWNlIGFyZWEsIGJ1dCBpbiB0aGVvcnkgd2Ug
bWlnaHQgYWxzbyBzdXBwb3J0DQo+Pj4gcGMtZGltbSBob3RwbHVncyAod2hpY2ggd291bGQgYmUg
dGhlIGVxdWl2YWxlbnQgb2YgYWRkaW5nIHBoeXNpY2FsIFJBTSBkaW1tcyB0bw0KPj4+IHRoZSBi
b2FyZC4pIGluIHRoZSBmdXR1cmUgdG9vLiBJZiB5b3UncmUgbm90IGZhbWlsaWFyIHdpdGggdGhp
cyBmZWF0dXJlIHlvdSBjYW4NCj4+PiBjaGVjayBpdCBvdXQgdGhlIGRvY3MgaW4gWzFdLg0KPj4g
DQo+PiBOb3RlIHRoYXQgRElNTXMgYXJlIG1lbW9yeSBkZXZpY2VzIGFzIHdlbGwuIFlvdSBjYW4g
cGx1ZyBpbnRvIHRoZSBtZW1vcnkgZGV2aWNlIGFyZWEgYm90aCwgQUNQSS1iYXNlZCBtZW1vcnkg
ZGV2aWNlcyAoRElNTSwgTlZESU1NKSBvciB2aXJ0aW8tYmFzZWQgbWVtb3J5IGRldmljZXMgKHZp
cnRpby1tZW0sIHZpcnRpby1wbWVtKS4NCj4+IA0KPj4+DQo+Pj4gQXMgYW4gZXhhbXBsZSwgdGhl
ICd2aXJ0JyBBUk0gYm9hcmQgKGh3L2FybS92aXJ0LmMpIHJlc2VydmVzIGEgc3BhY2UgZm9yIHRo
aXMNCj4+PiB0eXBlIG9mIGhvdHBsdWcgYnkgY2hlY2tpbmcgaG93IG11Y2ggJ3JhbV9zbG90cycg
d2UncmUgYWxsb2NhdGluZyBmb3IgaXQ6DQo+Pj4NCj4+PiBkZXZpY2VfbWVtb3J5X3NpemUgPSBt
cy0+bWF4cmFtX3NpemUgLSBtcy0+cmFtX3NpemUgKyBtcy0+cmFtX3Nsb3RzICogR2lCOw0KPj4+
DQo+PiANCj4+IE5vdGUgdGhhdCB3ZSBpbmNyZWFzZWQgdGhlIHJlZ2lvbiBzaXplIHRvIGJlIGFi
bGUgdG8gZml0IG1vc3QgcmVxdWVzdHMgZXZlbiBpZiBhbGlnbm1lbnQgb2YgbWVtb3J5IGRldmlj
ZXMgaXMgd2VpcmQuIFNlZSBiZWxvdy4NCj4+IA0KPj4gSW4gc2FuZSBzZXR1cHMsIHRoaXMgaXMg
dXN1YWxseSBub3QgcmVxdWlyZWQgKGFkZGluZyBhIHNpbmdsZSBhZGRpdGlvbmFsIEdCIGZvciBz
b21lIGZsZXhpaWxpdHkgbWlnaHQgYmUgZ29vZCBlbm91Z2gpLg0KPj4gDQo+Pj4gT3RoZXIgYm9h
cmRzIGRvIHRoZSBzYW1lIHdpdGggbXMtPnJhbV9zbG90cy4gV2Ugc2hvdWxkIGNvbnNpZGVyIGRv
aW5nIGl0IGFzIHdlbGwsDQo+Pj4gbm93LCBldmVuIGlmIHdlJ3JlIG5vdCB1cCB0byB0aGUgcG9p
bnQgb2Ygc3VwcG9ydGluZyBwYy1kaW1tIGhvdHBsdWcsIHRvIGF2b2lkDQo+Pj4gaGF2aW5nIHRv
IGNoYW5nZSB0aGUgbWVtb3J5IGxheW91dCBsYXRlciBpbiB0aGUgcm9hZCBhbmQgYnJlYWtpbmcg
ZXhpc3RpbmcNCj4+PiBzZXR1cHMuDQo+Pj4NCj4+PiBJZiB3ZSB3YW50IHRvIGNvcHkgdGhlIEFS
TSBib2FyZCwgcmFtX3Nsb3RzIGlzIGNhcHBlZCB0byBBQ1BJX01BWF9SQU1fU0xPVFMgKDI1Niku
DQo+Pj4gRWFjaCBSQU0gc2xvdCBpcyBjb25zaWRlcmVkIHRvIGJlIGEgMUdpQiBkaW1tLCBpLmUu
IHdlIHdvdWxkIHJlc2VydmUgMjU2R2lCIGZvcg0KPj4+IHRoZW0uDQo+PiANCj4+IFRoaXMgb25s
eSByZXNlcnZlcyBzb21lICphZGRpdGlvbmFsKiBzcGFjZSB0byBmaXh1cCB3ZWlyZCBhbGlnbm1l
bnQgb2YgbWVtb3J5IGRldmljZXMuICpub3QqIHRoZSBhY3R1YWwgc3BhY2UgZm9yIHRoZXNlIGRl
dmljZXMuDQo+PiANCj4+IFdlIGRvbid0IGNvbnNpZGVyIGVhY2ggRElNTSB0byBiZSAxIEdpQiBp
biBzaXplLCBidXQgYWRkIGFuIGFkZGl0aW9uYWwgMSBHaUIgaW4gY2FzZSB3ZSBoYXZlIHRvIGFs
aWduIERJTU1zIGluIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UuDQo+PiANCj4+IEkgKnRoaW5rKiB0
aGlzIGRhdGVzIGJhY2sgdG8gb2xkIHg4NiBoYW5kbGluZyB3aGVyZSB3ZSBhbGlnbmVkIHRoZSBh
ZGRyZXNzIG9mIGVhY2ggRElNTSB0byBiZSBhdCBhIDEgR2lCIGJvdW5kYXJ5LiBTbyBpZiB5b3Ug
d291bGQgaGF2ZSBwbHVnZ2VkIHR3byAxMjggTWlCIERJTU1zLCB5b3UnZCBoYXZlIHJlcXVpcmVk
IG1vcmUgdGhhbiAyNTYgTWlCIG9mIHNwYWNlIGluIHRoZSBhcmVhIGFmdGVyIGFsaWduaW5nIGlu
c2lkZSB0aGUgbWVtb3J5IGRldmljZSBhcmVhLg0KPj4gDQo+DQo+IFRoYW5rcyBmb3IgdGhlIGV4
cGxhbmF0aW9uLiBJIG1pc3NlZCB0aGUgcGFydCB3aGVyZSB0aGUgcmFtX3Nsb3RzIHdlcmUgYmVp
bmcNCj4gdXNlZCBqdXN0IHRvIHNvbHZlIHBvdGVudGlhbCBhbGlnbm1lbnQgaXNzdWVzIGFuZCBw
Yy1kaW1tcyBjb3VsZCBvY2N1cHkgdGhlIHNhbWUNCj4gc3BhY2UgYmVpbmcgYWxsb2NhdGVkIHZp
YSBtYWNoaW5lX21lbW9yeV9kZXZpY2VzX2luaXQoKS4NCj4NCj4gVGhpcyBwYXRjaCBpc24ndCBm
YXIgb2ZmIHRoZW4uIElmIHdlIHRha2UgY2FyZSB0byBhdm9pZCBwbHVnZ2luZyB1bmFsaWduZWQg
bWVtb3J5DQo+IHdlIG1pZ2h0IG5vdCBldmVuIG5lZWQgdGhpcyBzcGFyZSBhcmVhLg0KDQpJJ20g
YSBiaXQgbG9zdCBoZXJlLCBzbyBwbGVhc2UgYmFyZSB3aXRoIG1lLiBXZSBkb24ndCByZXF1aXJl
IHRoZSAxIEdpQg0KYWxpZ25tZW50IG9uIFJWIEFGQUlVLiBJJ20gaGF2aW5nIGEgaGFyZCB0aW1l
IGZpZ3VyaW5nIG91dCB3aGF0IG1pc3NpbmcNCmluIG15IHBhdGNoLg0KDQpbLi4uXQ0KDQo+Pj4g
SSBzZWUgdGhhdCBEYXZpZCBIaWxkZW5icmFuZCBpcyBhbHNvIENDZWQgaW4gdGhlIHBhdGNoIHNv
IGhlJ2xsIGxldCB1cyBrbm93IGlmDQo+Pj4gSSdtIG91dCBvZiBsaW5lIHdpdGggd2hhdCBJJ20g
YXNraW5nLg0KPj4gDQo+PiBTdXBwb3J0aW5nIFBDLURJTU1zIG1pZ2h0IGJlIHJlcXVpcmVkIGF0
IHNvbWUgcG9pbnQgd2hlbiBkZWFsaW5nIHdpdGggT1NlcyB0aGF0IGRvbid0IHN1cHBvcnQgdmly
dGlvLW1lbSBhbmQgZnJpZW5kcy4NCg0KLi4uYW5kIGFsc28gZm9yIHRlc3RpbmcgdGhlIFBDLURJ
TU0gQUNQSSBwYXRjaGluZyBwYXRoLiA7LSkNCg0KDQpDaGVlcnMsDQpCasO2cm4NCg==

