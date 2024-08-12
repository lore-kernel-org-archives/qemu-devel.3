Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57E7C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdVXi-0006xx-18; Mon, 12 Aug 2024 09:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9472a1eb8=graf@amazon.de>)
 id 1sdVXg-0006sX-FV
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:57:00 -0400
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9472a1eb8=graf@amazon.de>)
 id 1sdVXe-00030r-6h
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1723471018; x=1755007018;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1Hj8iOuNQI1TmZskMP4fvtpl9PgEwCsFY0vzfABv4ls=;
 b=NFld61eBE9dlREis317B8EtV6iv+n3GLZ52HEY/6wbVp0KD8y4Nom2+h
 p9/BKEcgFQ4yAy8J+5nHvgt0ciAOUZubxsVIU4h4RIe0z987KF+EXy5wQ
 ak7Ari/avHWDmBu8pKsmVWPZTV9NoJrjqVuRcBW+cjFXS5Z3eZaMhWnK6 s=;
X-IronPort-AV: E=Sophos;i="6.09,283,1716249600"; d="scan'208";a="114433639"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80009.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 13:56:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:59234]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.243:2525]
 with esmtp (Farcaster)
 id 71afe259-8680-46d3-9429-e8951d15b02f; Mon, 12 Aug 2024 13:56:54 +0000 (UTC)
X-Farcaster-Flow-ID: 71afe259-8680-46d3-9429-e8951d15b02f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 13:56:54 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 12 Aug 2024
 13:56:51 +0000
Message-ID: <a74bd2bb-bad4-43bf-9508-4382d9d2c973@amazon.com>
Date: Mon, 12 Aug 2024 15:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] machine/nitro-enclave: New machine type for AWS
 Nitro Enclaves
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <agraf@csgraf.de>, <stefanha@redhat.com>, <pbonzini@redhat.com>,
 <slp@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>,
 <philmd@linaro.org>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-2-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240810164502.19693-2-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=99.78.197.220;
 envelope-from=prvs=9472a1eb8=graf@amazon.de; helo=smtp-fw-80009.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Ck9uIDEwLjA4LjI0IDE4OjQ0LCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IEFXUyBuaXRybyBl
bmNsYXZlc1sxXSBpcyBhbiBBbWF6b24gRUMyWzJdIGZlYXR1cmUgdGhhdCBhbGxvd3MgY3JlYXRp
bmcKPiBpc29sYXRlZCBleGVjdXRpb24gZW52aXJvbm1lbnRzLCBjYWxsZWQgZW5jbGF2ZXMsIGZy
b20gQW1hem9uIEVDMgo+IGluc3RhbmNlcyB3aGljaCBhcmUgdXNlZCBmb3IgcHJvY2Vzc2luZyBo
aWdobHkgc2Vuc2l0aXZlIGRhdGEuCj4gRW5jbGF2ZXMgaGF2ZSBubyBwZXJzaXN0ZW50IHN0b3Jh
Z2UgYW5kIG5vIGV4dGVybmFsIG5ldHdvcmtpbmcuIFRoZQo+IGVuY2xhdmUgVk1zIGFyZSBiYXNl
ZCBvbiBGaXJlY3JhY2tlciBtaWNyb3ZtIHdpdGggYSB2aG9zdC12c29jawo+IGRldmljZSBmb3Ig
Y29tbXVuaWNhdGlvbiB3aXRoIHRoZSBwYXJlbnQgRUMyIGluc3RhbmNlIHRoYXQgc3Bhd25lZAo+
IGl0IGFuZCBhIE5pdHJvIFNlY3VyZSBNb2R1bGUgKE5TTSkgZGV2aWNlIGZvciBjcnlwdG9ncmFw
aGljIGF0dGVzdGF0aW9uLgo+IFRoZSBwYXJlbnQgaW5zdGFuY2UgVk0gYWx3YXlzIGhhcyBDSUQg
MyB3aGlsZSB0aGUgZW5jbGF2ZSBWTSBnZXRzIGEKPiBkeW5hbWljIENJRC4KPgo+IEFuIEVJRiAo
RW5jbGF2ZSBJbWFnZSBGb3JtYXQpWzNdIGZpbGUgaXMgdXNlZCB0byBib290IGFuIEFXUyBuaXRy
bwo+IGVuY2xhdmUgdmlydHVhbCBtYWNoaW5lLiBUaGUgRUlGIGZpbGUgY29udGFpbnMgdGhlIG5l
Y2Vzc2FyeSBrZXJuZWwsCj4gY21kbGluZSwgcmFtZGlzayhzKSBzZWN0aW9ucyB0byBib290Lgo+
Cj4gVGhpcyBjb21taXQgYWRkcyBzdXBwb3J0IGZvciBsaW1pdGVkIEFXUyBuaXRybyBlbmNsYXZl
IGVtdWxhdGlvbiB1c2luZwo+IGEgbmV3IG1hY2hpbmUgdHlwZSBvcHRpb24gJy1NIG5pdHJvLWVu
Y2xhdmUnLiBUaGlzIG5ldyBtYWNoaW5lIHR5cGUgaXMKPiBiYXNlZCBvbiB0aGUgJ21pY3Jvdm0n
IG1hY2hpbmUgdHlwZSwgc2ltaWxhciB0byBob3cgcmVhbCBuaXRybyBlbmNsYXZlCj4gVk1zIGFy
ZSBiYXNlZCBvbiBGaXJlY3JhY2tlciBtaWNyb3ZtLiBGb3Igbml0cm8tZW5jbGF2ZSB0byBib290
IGZyb20KPiBhbiBFSUYgZmlsZSwgdGhlIGtlcm5lbCBhbmQgcmFtZGlzayhzKSBhcmUgZXh0cmFj
dGVkIGludG8gYSB0ZW1wb3JhcnkKPiBrZXJuZWwgYW5kIGEgdGVtcG9yYXJ5IGluaXRyZCBmaWxl
IHdoaWNoIGFyZSB0aGVuIGhvb2tlZCBpbnRvIHRoZQo+IHJlZ3VsYXIgeDg2IGJvb3QgbWVjaGFu
aXNtIGFsb25nIHdpdGggdGhlIGV4dHJhY3RlZCBjbWRsaW5lLiBUaGUgRUlGCj4gZmlsZSBwYXRo
IHNob3VsZCBiZSBwcm92aWRlZCB1c2luZyB0aGUgJy1rZXJuZWwnIFFFTVUgb3B0aW9uLgo+Cj4g
VGhlIHZzb2NrIGFuZCBOU00gZGV2aWNlcyB3aWxsIGJlIGltcGxlbWVudGVkIHNvIHRoYXQgdGhl
eSBhcmUgYXZhaWxhYmxlCj4gYXV0b21hdGljYWxseSBpbiBuaXRyby1lbmNsYXZlIG1hY2hpbmUg
dHlwZSBpbiB0aGUgZm9sbG93aW5nIGNvbW1pdHMuCj4KPiBbMV0gaHR0cHM6Ly9kb2NzLmF3cy5h
bWF6b24uY29tL2VuY2xhdmVzL2xhdGVzdC91c2VyL25pdHJvLWVuY2xhdmUuaHRtbAo+IFsyXSBo
dHRwczovL2F3cy5hbWF6b24uY29tL2VjMi8KPiBbM10gaHR0cHM6Ly9naXRodWIuY29tL2F3cy9h
d3Mtbml0cm8tZW5jbGF2ZXMtaW1hZ2UtZm9ybWF0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBEb3Jqb3kg
Q2hvd2RodXJ5IDxkb3Jqb3ljaHkxMTFAZ21haWwuY29tPgoKCklmIEkgcnVuIHRoaXMgY29kZSB3
aXRoIGFuIGludmFsaWQga2VybmVsIHBhcmFtZXRlciwgc29tZXRoaW5nIGluIHRoZSAKZXJyb3Ig
cGF0aCBpcyBvZmYuIENhbiB5b3UgcGxlYXNlIHRyeSB0byBleGVyY2lzZSB5b3VyIGVycm9yIHBh
dGhzIHRvIAp2YWxpZGF0ZSB0aGV5IHdvcmsgY29ycmVjdGx5PwoKJCAuL2J1aWxkL3FlbXUtc3lz
dGVtLXg4Nl82NCAtTSBuaXRyby1lbmNsYXZlIC1ub2dyYXBoaWMgLWtlcm5lbCBmb29iYXIKcWVt
dS1zeXN0ZW0teDg2XzY0OiAuLi91dGlsL2Vycm9yLmM6Njg6IGVycm9yX3NldHY6IEFzc2VydGlv
biBgKmVycnAgPT0gCk5VTEwnIGZhaWxlZC4KCgpBbGV4CgoKCgpBbWF6b24gV2ViIFNlcnZpY2Vz
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVy
bGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vp
c3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1
Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


