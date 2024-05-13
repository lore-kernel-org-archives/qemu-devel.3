Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6B0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bZp-0006Bz-2C; Mon, 13 May 2024 15:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=856a464c5=jgowans@amazon.com>)
 id 1s6bZm-0006Bd-1v
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:43:11 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=856a464c5=jgowans@amazon.com>)
 id 1s6bZk-0002r7-3z
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1715629389; x=1747165389;
 h=from:to:cc:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version:subject;
 bh=faogjTYCdwe1pN05KrA5hMIhddpbaw6D2CQo9VmVtW4=;
 b=NAQXy3nxlugnJ63afxftNz9FD5XI6pHZtEYWAouYblG4671YeNDPqlUQ
 RxWofvwD33xu9OHyRITKaYfp6iLFy0NDrxGZVZRoBj8lgzdY3wN0iY3tX
 FEVeUJFIxBQZXups2anK7cr0WuY/icXy48qsL3RzcaibfnvUkmpb+jhb/ A=;
X-IronPort-AV: E=Sophos;i="6.08,159,1712620800"; d="scan'208";a="400889728"
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
Thread-Topic: Unmapping KVM Guest Memory from Host Kernel
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-2101.iad2.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 19:43:04 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:18348]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.177:2525]
 with esmtp (Farcaster)
 id 78eefc80-06b2-4d10-93b2-3964d443d9d9; Mon, 13 May 2024 19:43:02 +0000 (UTC)
X-Farcaster-Flow-ID: 78eefc80-06b2-4d10-93b2-3964d443d9d9
Received: from EX19D022EUC001.ant.amazon.com (10.252.51.254) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 19:43:02 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D022EUC001.ant.amazon.com (10.252.51.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 19:43:01 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with
 mapi id 15.02.1258.028; Mon, 13 May 2024 19:43:01 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
 "rppt@kernel.org" <rppt@kernel.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Roy, Patrick" <roypat@amazon.co.uk>,
 "somlo@cmu.edu" <somlo@cmu.edu>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "Woodhouse, David"
 <dwmw@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "Graf (AWS), Alexander"
 <graf@amazon.de>, "Manwaring, Derek" <derekmn@amazon.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>, "mst@redhat.com" <mst@redhat.com>
Thread-Index: AQHapSDFL4wJB6zUokKkOmjg3vQ4V7GVTVUAgAAFhYCAABOpgIAAKr2A
Date: Mon, 13 May 2024 19:43:01 +0000
Message-ID: <f880d0187e2d482bc8a8095cf5b7404ea9d6fb03.camel@amazon.com>
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <ZeudRmZz7M6fWPVM@google.com> <ZexEkGkNe_7UY7w6@kernel.org>
 <58f39f23-0314-4e34-a8c7-30c3a1ae4777@amazon.co.uk>
 <ZkI0SCMARCB9bAfc@google.com>
 <aaf684b5eb3a3fe9cfbb6205c16f0973c6f8bb07.camel@amazon.com>
 <ZkJFIpEHIQvfuzx1@google.com>
In-Reply-To: <ZkJFIpEHIQvfuzx1@google.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <831447F30D942644967CBB55B30F1E56@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=72.21.196.25;
 envelope-from=prvs=856a464c5=jgowans@amazon.com; helo=smtp-fw-2101.amazon.com
X-Spam_score_int: -128
X-Spam_score: -12.9
X-Spam_bar: ------------
X-Spam_report: (-12.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDEwOjA5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIE1heSAxMywgMjAyNCwgSmFtZXMgR293YW5zIHdyb3RlOg0KPiA+IE9u
IE1vbiwgMjAyNC0wNS0xMyBhdCAwODozOSAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90
ZToNCj4gPiA+ID4gU2VhbiwgeW91IG1lbnRpb25lZCB0aGF0IHlvdSBlbnZpc2lvbiBndWVzdF9t
ZW1mZCBhbHNvIHN1cHBvcnRpbmcgbm9uLUNvQ28gVk1zLg0KPiA+ID4gPiBEbyB5b3UgaGF2ZSBz
b21lIHRob3VnaHRzIGFib3V0IGhvdyB0byBtYWtlIHRoZSBhYm92ZSBjYXNlcyB3b3JrIGluIHRo
ZQ0KPiA+ID4gPiBndWVzdF9tZW1mZCBjb250ZXh0Pw0KPiA+ID4gDQo+ID4gPiBZZXMuwqAgVGhl
IGhhbmQtd2F2eSBwbGFuIGlzIHRvIGFsbG93IHNlbGVjdGl2ZWx5IG1tYXAoKWluZyBndWVzdF9t
ZW1mZCgpLsKgIFRoZXJlDQo+ID4gPiBpcyBhIGxvbmcgdGhyZWFkWypdIGRpc2N1c3NpbmcgaG93
IGV4YWN0bHkgd2Ugd2FudCB0byBkbyB0aGF0LsKgIFRoZSBUTDtEUiBpcyB0aGF0DQo+ID4gPiB0
aGUgYmFzaWMgZnVuY3Rpb25hbGl0eSBpcyBhbHNvIHN0cmFpZ2h0Zm9yd2FyZDsgdGhlIGJ1bGsg
b2YgdGhlIGRpc2N1c3Npb24gaXMNCj4gPiA+IGFyb3VuZCBndXAoKSwgcmVjbGFpbSwgcGFnZSBt
aWdyYXRpb24sIGV0Yy4NCj4gPiANCj4gPiBJIHN0aWxsIG5lZWQgdG8gcmVhZCB0aGlzIGxvbmcg
dGhyZWFkLCBidXQganVzdCBhIHRob3VnaHQgb24gdGhlIHdvcmQNCj4gPiAicmVzdHJpY3RlZCIg
aGVyZTogZm9yIE1NSU8gdGhlIGluc3RydWN0aW9uIGNhbiBiZSBhbnl3aGVyZSBhbmQNCj4gPiBz
aW1pbGFybHkgdGhlIGxvYWQvc3RvcmUgTU1JTyBkYXRhIGNhbiBiZSBhbnl3aGVyZS4gRG9lcyB0
aGlzIG1lYW4gdGhhdA0KPiA+IGZvciBydW5uaW5nIHVubW9kaWZpZWQgbm9uLUNvQ28gVk1zIHdp
dGggZ3Vlc3RfbWVtZmQgYmFja2VuZCB0aGF0IHdlJ2xsDQo+ID4gYWx3YXlzIG5lZWQgdG8gaGF2
ZSB0aGUgd2hvbGUgb2YgZ3Vlc3QgbWVtb3J5IG1tYXBwZWQ/DQo+IA0KPiBOb3QgbmVjZXNzYXJp
bHksIGUuZy4gS1ZNIGNvdWxkIHJlLWVzdGFibGlzaCB0aGUgZGlyZWN0IG1hcCBvciBtcmVtYXAo
KSBvbi1kZW1hbmQuDQo+IFRoZXJlIGFyZSB2YXJpYXRpb24gb24gdGhhdCwgZS5nLiBpZiBBU0lb
Kl0gd2VyZSB0byBldmVyIG1ha2UgaXQncyB3YXkgdXBzdHJlYW0sDQo+IHdoaWNoIGlzIGEgaHVn
ZSBpZiwgdGhlbiB3ZSBjb3VsZCBoYXZlIGd1ZXN0X21lbWZkIG1hcHBlZCBpbnRvIGEgS1ZNLW9u
bHkgQ1IzLg0KDQpZZXMsIG9uLWRlbWFuZCBtYXBwaW5nIGluIG9mIGd1ZXN0IFJBTSBwYWdlcyBp
cyBkZWZpbml0ZWx5IGFuIG9wdGlvbi4gSXQNCnNvdW5kcyBxdWl0ZSBjaGFsbGVuZ2luZyB0byBu
ZWVkIHRvIGFsd2F5cyBnbyB2aWEgaW50ZXJmYWNlcyB3aGljaA0KZGVtYW5kIG1hcC9mYXVsdCBt
ZW1vcnksIGFuZCBhbHNvIHBvdGVudGlhbGx5IHF1aXRlIHNsb3cgbmVlZGluZyB0bw0KdW5tYXAg
YW5kIGZsdXNoIGFmdGVyd2FyZHMuIA0KDQpOb3QgdG9vIHN1cmUgd2hhdCB5b3UgaGF2ZSBpbiBt
aW5kIHdpdGggImd1ZXN0X21lbWZkIG1hcHBlZCBpbnRvIEtWTS0NCm9ubHkgQ1IzIiAtIGNvdWxk
IHlvdSBleHBhbmQ/DQoNCj4gPiBJIGd1ZXNzIHRoZSBpZGVhIGlzIHRoYXQgdGhpcyB1c2UgY2Fz
ZSB3aWxsIHN0aWxsIGJlIHN1YmplY3QgdG8gdGhlDQo+ID4gbm9ybWFsIHJlc3RyaWN0aW9uIHJ1
bGVzLCBidXQgZm9yIGEgbm9uLUNvQ28gbm9uLXBLVk0gVk0gdGhlcmUgd2lsbCBiZQ0KPiA+IG5v
IHJlc3RyaWN0aW9uIGluIHByYWN0aWNlLCBhbmQgdXNlcnNwYWNlIHdpbGwgbmVlZCB0byBtbWFw
IGV2ZXJ5dGhpbmcNCj4gPiBhbHdheXM/DQo+ID4gDQo+ID4gSXQgcmVhbGx5IHNlZW1zIHl1Y2t5
IHRvIG5lZWQgdG8gaGF2ZSBhbGwgb2YgZ3Vlc3QgUkFNIG1tYXBwZWQgYWxsIHRoZQ0KPiA+IHRp
bWUganVzdCBmb3IgTU1JTyB0byB3b3JrLi4uIEJ1dCBJIHN1cHBvc2UgdGhlcmUgaXMgbm8gd2F5
IGFyb3VuZCB0aGF0DQo+ID4gZm9yIEludGVsIHg4Ni4NCj4gDQo+IEl0J3Mgbm90IGp1c3QgTU1J
Ty7CoCBOZXN0ZWQgdmlydHVhbGl6YXRpb24sIGFuZCBtb3JlIHNwZWNpZmljYWxseSBzaGFkb3dp
bmcgbmVzdGVkDQo+IFREUCwgaXMgYWxzbyBwcm9ibGVtYXRpYyAocHJvYmFibHkgbW9yZSBzbyB0
aGFuIE1NSU8pLsKgIEFuZCB0aGVyZSBhcmUgbW9yZSBjYXNlcywNCj4gaS5lLiB3ZSdsbCBuZWVk
IGEgZ2VuZXJpYyBzb2x1dGlvbiBmb3IgdGhpcy7CoCBBcyBhYm92ZSwgdGhlcmUgYXJlIGEgdmFy
aWV0eSBvZg0KPiBvcHRpb25zLCBpdCdzIGxhcmdlbHkganVzdCBhIG1hdHRlciBvZiBkb2luZyB0
aGUgd29yay7CoCBJJ20gbm90IHNheWluZyBpdCdzIGENCj4gdHJpdmlhbCBhbW91bnQgb2Ygd29y
ay9lZmZvcnQsIGJ1dCBpdCdzIGZhciBmcm9tIGFuIHVuc29sdmFibGUgcHJvYmxlbS4NCg0KSSBk
aWRuJ3QgZXZlbiB0aGluayBvZiBuZXN0ZWQgdmlydCwgYnV0IHRoYXQgd2lsbCBhYnNvbHV0ZWx5
IGJlIGFuIGV2ZW4NCmJpZ2dlciBwcm9ibGVtIHRvby4gTU1JTyB3YXMganVzdCB0aGUgZmlyc3Qg
cm9hZGJsb2NrIHdoaWNoIGlsbHVzdHJhdGVkDQp0aGUgcHJvYmxlbS4NCk92ZXJhbGwgd2hhdCBJ
J20gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaXMgd2hldGhlciB0aGVyZSBpcyBhbnkgc2FuZSBwYXRo
DQpoZXJlIG90aGVyIHRoYW4gbmVlZGluZyB0byBtbWFwIGFsbCBndWVzdCBSQU0gYWxsIHRoZSB0
aW1lLiBUcnlpbmcgdG8NCmdldCBuZXN0ZWQgdmlydCBhbmQgTU1JTyBhbmQgd2hhdGV2ZXIgZWxz
ZSBuZWVkcyBhY2Nlc3MgdG8gZ3Vlc3QgUkFNDQp3b3JraW5nIGJ5IGRvaW5nIGp1c3QtaW4tdGlt
ZSAoYWthOiBvbi1kZW1hbmQpIG1hcHBpbmdzIGFuZCB1bm1hcHBpbmdzDQpvZiBndWVzdCBSQU0g
c291bmRzIGxpa2UgYSBwYWluZnVsIGdhbWUgb2Ygd2hhY2stYS1tb2xlLCBwb3RlbnRpYWxseQ0K
cmVhbGx5IGJhZCBmb3IgcGVyZm9ybWFuY2UgdG9vLg0KDQpEbyB5b3UgdGhpbmsgd2Ugc2hvdWxk
IGxvb2sgYXQgZG9pbmcgdGhpcyBvbi1kZW1hbmQgbWFwcGluZywgb3IsIGZvcg0Kbm93LCBzaW1w
bHkgcmVxdWlyZSB0aGF0IGFsbCBndWVzdCBSQU0gaXMgbW1hcHBlZCBhbGwgdGhlIHRpbWUgYW5k
IEtWTQ0KYmUgZ2l2ZW4gYSB2YWxpZCB2aXJ0dWFsIGFkZHIgZm9yIHRoZSBtZW1zbG90cz8NCk5v
dGUgdGhhdCBJJ20gc3BlY2lmaWNhbGx5IHJlZmVycmluZyB0byByZWd1bGFyIG5vbi1Db0NvIG5v
bi1lbmxpZ2h0ZW5lZA0KVk1zIGhlcmUuIEZvciBDb0NvIHdlIGRlZmluaXRlbHkgbmVlZCBhbGwg
dGhlIGNvb3BlcmF0aXZlIE1NSU8gYW5kDQpzaGFyaW5nLiBXaGF0IHdlJ3JlIHRyeWluZyB0byBk
byBoZXJlIGlzIHRvIGdldCBndWVzdCBSQU0gb3V0IG9mIHRoZQ0KZGlyZWN0IG1hcCB1c2luZyBn
dWVzdF9tZW1mZCwgYW5kIG5vdyB0YWNrbGluZyB0aGUga25vY2stb24gcHJvYmxlbSBvZg0Kd2hl
dGhlciBvciBub3QgdG8gbW1hcCBhbGwgb2YgZ3Vlc3QgUkFNIGFsbCB0aGUgdGltZSBpbiB1c2Vy
c3BhY2UuDQoNCkpHDQo=

