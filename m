Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEF5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 23:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rijLH-0007KV-1k; Fri, 08 Mar 2024 18:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=790d2038c=derekmn@amazon.com>)
 id 1rihPE-0001TG-In
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:05:28 -0500
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=790d2038c=derekmn@amazon.com>)
 id 1rihPC-0002I4-Eq
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1709931926; x=1741467926;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=HRn+4j3s0uvW5ahHq0WE6UyDKv//dbnY5NHz7Jy33W8=;
 b=GnyPYtgBWzy64NX9VDQ3F0yyrkbP2AaL7o9QdPJRlXpumwVav5ifjujG
 prZW4W65cCzlZ/s2R9L8nvOkvgNXwPm3irkTo8XTEKowbHspaahbM3x8i
 Ss3jBR4DEFY3nHAz2I+eRiRuur/NLn0FRH78EDsswlBb4KUhNkyQvaJNl 8=;
X-IronPort-AV: E=Sophos;i="6.07,110,1708387200"; d="scan'208";a="71864338"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80009.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 21:05:22 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:33697]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.238:2525]
 with esmtp (Farcaster)
 id 0d5eeb03-8eea-46eb-993f-a3909d8a0217; Fri, 8 Mar 2024 21:05:21 +0000 (UTC)
X-Farcaster-Flow-ID: 0d5eeb03-8eea-46eb-993f-a3909d8a0217
Received: from EX19D022EUC001.ant.amazon.com (10.252.51.254) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 21:05:21 +0000
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19D022EUC001.ant.amazon.com (10.252.51.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 21:05:20 +0000
Received: from EX19D003UWC002.ant.amazon.com ([fe80::ab31:cc39:59f9:18b3]) by
 EX19D003UWC002.ant.amazon.com ([fe80::ab31:cc39:59f9:18b3%3]) with
 mapi id 15.02.1258.028; Fri, 8 Mar 2024 21:05:19 +0000
From: "Manwaring, Derek" <derekmn@amazon.com>
To: David Woodhouse <dwmw2@infradead.org>, David Matlack
 <dmatlack@google.com>, Brendan Jackman <jackmanb@google.com>,
 "tabba@google.com" <tabba@google.com>, "qperret@google.com"
 <qperret@google.com>, "jason.cj.chen@intel.com" <jason.cj.chen@intel.com>
CC: "Gowans, James" <jgowans@amazon.com>, "seanjc@google.com"
 <seanjc@google.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
 "Roy, Patrick" <roypat@amazon.co.uk>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Kalyazin, Nikita"
 <kalyazin@amazon.co.uk>, "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "mst@redhat.com" <mst@redhat.com>,
 "somlo@cmu.edu" <somlo@cmu.edu>, "Graf (AWS), Alexander" <graf@amazon.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
 <linux-coco@lists.linux.dev>, "kvmarm@lists.linux.dev"
 <kvmarm@lists.linux.dev>, "kvmarm@lists.cs.columbia.edu"
 <kvmarm@lists.cs.columbia.edu>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
Thread-Topic: Unmapping KVM Guest Memory from Host Kernel
Thread-Index: AQHacZxTeX10YUH0O0SiQBg1zQLaEw==
Date: Fri, 8 Mar 2024 21:05:19 +0000
Message-ID: <335E21FA-7F1E-4540-8A70-01A63D8C72FA@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.138.181]
Content-Type: text/plain; charset="utf-8"
Content-ID: <105008749F655A45808AA99CDA7541DE@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=99.78.197.220;
 envelope-from=prvs=790d2038c=derekmn@amazon.com; helo=smtp-fw-80009.amazon.com
X-Spam_score_int: -124
X-Spam_score: -12.5
X-Spam_bar: ------------
X-Spam_report: (-12.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 Mar 2024 18:09:25 -0500
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

T24gMjAyNC0wMy0wOCBhdCAxMDo0Ni0wNzAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6DQo+IE9u
IEZyaSwgMjAyNC0wMy0wOCBhdCAwOTozNSAtMDgwMCwgRGF2aWQgTWF0bGFjayB3cm90ZToNCj4g
PiBJIHRoaW5rIHdoYXQgSmFtZXMgaXMgbG9va2luZyBmb3IgKGFuZCB3aGF0IHdlIGFyZSBhbHNv
IGludGVyZXN0ZWQNCj4gPiBpbiksIGlzIF9lbGltaW5hdGluZ18gdGhlIGFiaWxpdHkgdG8gYWNj
ZXNzIGd1ZXN0IG1lbW9yeSBmcm9tIHRoZQ0KPiA+IGRpcmVjdCBtYXAgZW50aXJlbHkuIEFuZCBp
biBnZW5lcmFsLCBlbGltaW5hdGUgdGhlIGFiaWxpdHkgdG8gYWNjZXNzDQo+ID4gZ3Vlc3QgbWVt
b3J5IGluIGFzIG1hbnkgd2F5cyBhcyBwb3NzaWJsZS4NCj4NCj4gV2VsbCwgcEtWTSBkb2VzIHRo
YXQuLi4NCg0KWWVzIHdlJ3ZlIGJlZW4gbG9va2luZyBhdCBwS1ZNIGFuZCBpdCBhY2NvbXBsaXNo
ZXMgYSBsb3Qgb2Ygd2hhdCB3ZSdyZSB0cnlpbmcNCnRvIGRvLiBPdXIgaW5pdGlhbCBpbmNsaW5h
dGlvbiBpcyB0aGF0IHdlIHdhbnQgdG8gc3RpY2sgd2l0aCBWSEUgZm9yIHRoZSBsb3dlcg0Kb3Zl
cmhlYWQuIFdlIGFsc28gd2FudCBmbGV4aWJpbGl0eSBhY3Jvc3Mgc2VydmVyIHBhcnRzLCBzbyB3
ZSB3b3VsZCBuZWVkIHRvDQpnZXQgcEtWTSB3b3JraW5nIG9uIEludGVsICYgQU1EIGlmIHdlIHdl
bnQgdGhpcyByb3V0ZS4NCg0KQ2VydGFpbmx5IHRoZXJlIGFyZSBhZHZhbnRhZ2VzIG9mIHBLVk0g
b24gdGhlIHBlcmYgc2lkZSBsaWtlIHRoZSBpbi1wbGFjZQ0KbWVtb3J5IHNoYXJpbmcgcmF0aGVy
IHRoYW4gY29weWluZyBhcyB3ZWxsIGFzIG9uIHRoZSBzZWN1cml0eSBzaWRlIGJ5IHNpbXBseQ0K
cmVkdWNpbmcgdGhlIFRDQi4gSSdkIGJlIGludGVyZXN0ZWQgdG8gaGVhciBvdGhlcnMnIHRob3Vn
aHRzIG9uIHBLVk0gdnMNCm1lbWZkX3NlY3JldCBvciBnZW5lcmFsIEFTSS4NCg0KRGVyZWsNCg0K

