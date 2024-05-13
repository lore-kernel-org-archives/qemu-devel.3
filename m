Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6998C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Y7j-0000vd-CH; Mon, 13 May 2024 12:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=856a464c5=jgowans@amazon.com>)
 id 1s6Y7I-0000vC-20
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:01:32 -0400
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=856a464c5=jgowans@amazon.com>)
 id 1s6Y7G-00031O-4F
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1715616090; x=1747152090;
 h=from:to:cc:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version:subject;
 bh=/ZQi9dOaRQSJ70JtHs5ktPMljCtexhvs6nJFR6ZIOr8=;
 b=lpHD7g+6PA75MQ9zFcR217K7OXfb6k1ZvpxKqXHvK+0j4EIMcvZVvOeZ
 Bzt3QkbRajp8mv648hnfg0unlpQokfqlc1XbEBUWOUCM0qCt5jzs9s1Le
 MRz7Y1eH4vOqJ3Ejl52d9z6cn9hogxQ8lwZbTHEsjkuTTczabHLC0LMFc M=;
X-IronPort-AV: E=Sophos;i="6.08,158,1712620800"; d="scan'208";a="658341340"
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
Thread-Topic: Unmapping KVM Guest Memory from Host Kernel
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 16:01:25 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:5865]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.167:2525]
 with esmtp (Farcaster)
 id 1115728c-e447-424e-be56-7a79af17b930; Mon, 13 May 2024 16:01:23 +0000 (UTC)
X-Farcaster-Flow-ID: 1115728c-e447-424e-be56-7a79af17b930
Received: from EX19D022EUC004.ant.amazon.com (10.252.51.159) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 16:01:23 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D022EUC004.ant.amazon.com (10.252.51.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 16:01:23 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with
 mapi id 15.02.1258.028; Mon, 13 May 2024 16:01:23 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "seanjc@google.com" <seanjc@google.com>, "Roy, Patrick"
 <roypat@amazon.co.uk>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kalyazin, Nikita"
 <kalyazin@amazon.co.uk>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>, "somlo@cmu.edu" <somlo@cmu.edu>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "Liam.Howlett@oracle.com"
 <Liam.Howlett@oracle.com>, "kirill.shutemov@linux.intel.com"
 <kirill.shutemov@linux.intel.com>, "Woodhouse, David" <dwmw@amazon.co.uk>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "Manwaring,
 Derek" <derekmn@amazon.com>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>
Thread-Index: AQHapSDFL4wJB6zUokKkOmjg3vQ4V7GVTVUAgAAFhYA=
Date: Mon, 13 May 2024 16:01:22 +0000
Message-ID: <aaf684b5eb3a3fe9cfbb6205c16f0973c6f8bb07.camel@amazon.com>
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <ZeudRmZz7M6fWPVM@google.com> <ZexEkGkNe_7UY7w6@kernel.org>
 <58f39f23-0314-4e34-a8c7-30c3a1ae4777@amazon.co.uk>
 <ZkI0SCMARCB9bAfc@google.com>
In-Reply-To: <ZkI0SCMARCB9bAfc@google.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.220]
Content-Type: text/plain; charset="utf-8"
Content-ID: <12947CE165AA3241A48C00EB1398EF6F@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=52.119.213.152;
 envelope-from=prvs=856a464c5=jgowans@amazon.com; helo=smtp-fw-52003.amazon.com
X-Spam_score_int: -128
X-Spam_score: -12.9
X-Spam_bar: ------------
X-Spam_report: (-12.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDA4OjM5IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFNlYW4sIHlvdSBtZW50aW9uZWQgdGhhdCB5b3UgZW52aXNpb24gZ3Vlc3RfbWVt
ZmQgYWxzbyBzdXBwb3J0aW5nIG5vbi1Db0NvIFZNcy4NCj4gPiBEbyB5b3UgaGF2ZSBzb21lIHRo
b3VnaHRzIGFib3V0IGhvdyB0byBtYWtlIHRoZSBhYm92ZSBjYXNlcyB3b3JrIGluIHRoZQ0KPiA+
IGd1ZXN0X21lbWZkIGNvbnRleHQ/DQo+IA0KPiBZZXMuwqAgVGhlIGhhbmQtd2F2eSBwbGFuIGlz
IHRvIGFsbG93IHNlbGVjdGl2ZWx5IG1tYXAoKWluZyBndWVzdF9tZW1mZCgpLsKgIFRoZXJlDQo+
IGlzIGEgbG9uZyB0aHJlYWRbKl0gZGlzY3Vzc2luZyBob3cgZXhhY3RseSB3ZSB3YW50IHRvIGRv
IHRoYXQuwqAgVGhlIFRMO0RSIGlzIHRoYXQNCj4gdGhlIGJhc2ljIGZ1bmN0aW9uYWxpdHkgaXMg
YWxzbyBzdHJhaWdodGZvcndhcmQ7IHRoZSBidWxrIG9mIHRoZSBkaXNjdXNzaW9uIGlzDQo+IGFy
b3VuZCBndXAoKSwgcmVjbGFpbSwgcGFnZSBtaWdyYXRpb24sIGV0Yy4NCg0KSSBzdGlsbCBuZWVk
IHRvIHJlYWQgdGhpcyBsb25nIHRocmVhZCwgYnV0IGp1c3QgYSB0aG91Z2h0IG9uIHRoZSB3b3Jk
DQoicmVzdHJpY3RlZCIgaGVyZTogZm9yIE1NSU8gdGhlIGluc3RydWN0aW9uIGNhbiBiZSBhbnl3
aGVyZSBhbmQNCnNpbWlsYXJseSB0aGUgbG9hZC9zdG9yZSBNTUlPIGRhdGEgY2FuIGJlIGFueXdo
ZXJlLiBEb2VzIHRoaXMgbWVhbiB0aGF0DQpmb3IgcnVubmluZyB1bm1vZGlmaWVkIG5vbi1Db0Nv
IFZNcyB3aXRoIGd1ZXN0X21lbWZkIGJhY2tlbmQgdGhhdCB3ZSdsbA0KYWx3YXlzIG5lZWQgdG8g
aGF2ZSB0aGUgd2hvbGUgb2YgZ3Vlc3QgbWVtb3J5IG1tYXBwZWQ/DQoNCkkgZ3Vlc3MgdGhlIGlk
ZWEgaXMgdGhhdCB0aGlzIHVzZSBjYXNlIHdpbGwgc3RpbGwgYmUgc3ViamVjdCB0byB0aGUNCm5v
cm1hbCByZXN0cmljdGlvbiBydWxlcywgYnV0IGZvciBhIG5vbi1Db0NvIG5vbi1wS1ZNIFZNIHRo
ZXJlIHdpbGwgYmUgDQpubyByZXN0cmljdGlvbiBpbiBwcmFjdGljZSwgYW5kIHVzZXJzcGFjZSB3
aWxsIG5lZWQgdG8gbW1hcCBldmVyeXRoaW5nDQphbHdheXM/DQoNCkl0IHJlYWxseSBzZWVtcyB5
dWNreSB0byBuZWVkIHRvIGhhdmUgYWxsIG9mIGd1ZXN0IFJBTSBtbWFwcGVkIGFsbCB0aGUNCnRp
bWUganVzdCBmb3IgTU1JTyB0byB3b3JrLi4uIEJ1dCBJIHN1cHBvc2UgdGhlcmUgaXMgbm8gd2F5
IGFyb3VuZCB0aGF0DQpmb3IgSW50ZWwgeDg2Lg0KDQpKRw0KDQo+IA0KPiBbKl0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsL1pkZm9SM25DRVAzSFR0bTFAY2FzcGVyLmluZnJhZGVhZC5vcmcN
Cg0K

