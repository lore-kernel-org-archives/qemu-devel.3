Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A569FD7497D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 08:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t64Ia-0007sA-Pd; Wed, 30 Oct 2024 04:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=02698110f=graf@amazon.de>)
 id 1t64IZ-0007s2-9c
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:43:27 -0400
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=02698110f=graf@amazon.de>)
 id 1t64IX-0001aE-Iy
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1730277806; x=1761813806;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IJQgboEQ7EvK434FyZvWE7IdFWznxEIt6CTmN5MJLDg=;
 b=vyKjiiePUEgIE+OdGeCfXXokK6DQYxRSG0wOmFmcArC0lmuEn+Wyh08Z
 tPQBt1/QUxhFZZvWIBSN018g+YtF07G61T1nBgRnHRLeLKjEGJAx42EdT
 wxMZysa6/HOCSRcYRjD9qN1Y3USdQXd0gMRG4gk2yGbZA5P+BudWWIJWT o=;
X-IronPort-AV: E=Sophos;i="6.11,244,1725321600"; d="scan'208";a="691626233"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52005.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 08:43:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:33712]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.102:2525]
 with esmtp (Farcaster)
 id 9063f73d-8edc-4a6d-92d2-b337478b736d; Wed, 30 Oct 2024 08:43:19 +0000 (UTC)
X-Farcaster-Flow-ID: 9063f73d-8edc-4a6d-92d2-b337478b736d
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 08:43:16 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Wed, 30 Oct 2024
 08:43:13 +0000
Message-ID: <a9595a5b-e964-4dd0-9725-278141b398a3@amazon.com>
Date: Wed, 30 Oct 2024 09:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/6] AWS Nitro Enclave emulation support
To: Paolo Bonzini <pbonzini@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <agraf@csgraf.de>, <stefanha@redhat.com>, <slp@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <philmd@linaro.org>
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
 <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
 <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
 <CAFfO_h4QCDc5qTP_U+-c0NTxPh5J53x876e5aVskMHx28OUerQ@mail.gmail.com>
 <54fe9ff2-ee5c-42dc-adb0-b4131a496a0a@redhat.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <54fe9ff2-ee5c-42dc-adb0-b4131a496a0a@redhat.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.119.213.156;
 envelope-from=prvs=02698110f=graf@amazon.de; helo=smtp-fw-52005.amazon.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

SGV5IFBhb2xvLAoKT24gMjkuMTAuMjQgMjA6MzIsIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4KPiBP
biAxMC8yMy8yNCAxNjoyNywgRG9yam95IENob3dkaHVyeSB3cm90ZToKPj4gT24gV2VkLCBPY3Qg
MTYsIDIwMjQgYXQgNzo1OOKAr1BNIERvcmpveSBDaG93ZGh1cnkgCj4+IDxkb3Jqb3ljaHkxMTFA
Z21haWwuY29tPiB3cm90ZToKPj4+Cj4+PiBQaW5nCj4+Pgo+Pj4gVGhpcyBwYXRjaCBzZXJpZXMg
aGFzIGJlZW4gcmV2aWV3ZWQgYnkgQWxleC4gSSBhbSBub3Qgc3VyZSBpZiBpdCBuZWVkcwo+Pj4g
bW9yZSByZXZpZXcuIElmIG5vdCwgbWF5YmUgdGhpcyBjYW4gYmUgcGlja2VkIHVwIGZvciBtZXJn
aW5nLiBUaGFua3MhCj4+Pgo+Pgo+PiBHZW50bGUgcGluZy4KPj4KPj4gVGhpcyBwYXRjaCBzZXJp
ZXMgaGFzIGJlZW4gcmV2aWV3ZWQgYnkgQWxleCBhbmQgdGhlcmUgaGFzbid0IGJlZW4gYW55Cj4+
IG1vcmUgcmV2aWV3cy4gaXQgd291bGQgYmUgZ3JlYXQgaWYgdGhpcyBjb3VsZCBiZSBwaWNrZWQg
dXAgZm9yCj4+IG1lcmdpbmcuIFRoYW5rcyEKPgo+IEhpLAo+Cj4gc29ycnkgYWJvdXQgdGhlIGRl
bGF5IC0tIHRoZSBwYXRjaGVzIGZhaWxlZCBDSSBhbmQgSSBkaWRuJ3QgaGF2ZSBtdWNoCj4gdGlt
ZSB0byBpbnZlc3RpZ2F0ZSB1bnRpbCBub3cuCj4KPiBUaGUgaXNzdWVzIGFyZSBiYXNpY2FsbHk6
Cj4KPiAxKSBzb21lIHJTVCBzeW50YXggZXJyb3JzCj4KPiAyKSBmYWlsdXJlcyBvbiBub24tTGlu
dXggZHVlIHRvIGxhY2sgb2YgVkhPU1RfVVNFUgo+Cj4gMykgZmFpbHVyZXMgb24gMzItYml0IGR1
ZSB0byB1aW50NjRfdC9sb25nIG1pc21hdGNoLgo+Cj4KPiBXaGlsZSBmaXhpbmcgKDIpIEkgYWxz
byBtb3ZlZCB0aGUgZGVwZW5kZW5jeSBvbiBsaWJjYm9yIGFuZCBnbnV0bHMgZnJvbQo+IG1lc29u
IHRvIEtjb25maWcsIGFuZCBhZGRlZCAtLWVuYWJsZS1saWJjYm9yIHRvIGNvbmZpZ3VyZS7CoCBJ
IGFsc28gc3BsaXQKPiBody9jb3JlL2VpZi5jIHRvIGEgc2VwYXJhdGUgc3ltYm9sLCBqdXN0IHRv
IHNpbXBsaWZ5IHJlcHJvZHVjaW5nIHRoZQo+IDMyLWJpdCBmYWlsdXJlIG9uIHRoZSByaWdodCBj
b21taXQuCj4KPiBBbmQgZmluYWxseSwgVklSVElPX05TTSBzaG91bGQgZGVmYXVsdCB0byBubyAo
dGhlIG5pdHJvLWVuY2xhdmUgbWFjaG5lCj4gdGFrZXMgY2FyZSBvZiBzZWxlY3RpbmcgaXQpLgo+
Cj4gTm8gYmlnIGRlYWw7IGl0J3MgZWFzaWVyIGRvbmUgdGhhbiBkZXNjcmliZWQuwqAgU2VlIGF0
dGFjaGVkIHBhdGNoIGZvcgo+IHRoZSBkaWZmZXJlbmNlcy4KCgpUaGFua3MgYSBidW5jaCBmb3Ig
bG9va2luZyBkZWVwbHkgYW5kIGZpeGluZyB0aGUgaXNzdWVzIGFib3ZlIDopLiBJIApzdXBwb3Nl
IHRoZSBuZXh0IHN0ZXAgaXMgdG8gcG9zdCB2OSB3aXRoIHlvdXIgY2hhbmdlcyBpbmNsdWRlZD8K
CgpBbGV4CgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hy
aXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6
IERFIDM2NSA1MzggNTk3Cg==


