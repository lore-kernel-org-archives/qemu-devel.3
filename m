Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4688C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9Ci-0005Tr-6E; Wed, 14 Aug 2024 04:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=94947ded6=graf@amazon.de>)
 id 1se9Cg-0005T9-Rv
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:17:59 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=94947ded6=graf@amazon.de>)
 id 1se9Ce-0002MU-Q2
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1723623477; x=1755159477;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZFcGcP0nYxpsq3z2vCvQrd8L81fGMMeLGHHuWdCz1co=;
 b=UPHlOZcBEGg01qTT2O/8C0XpaaqHpJa0QspRDIYbq0uIK5TLuZWXTNHl
 y5QEEUtFd5ZINMpP1kZ333Jz41ot2JZURmhOHqP8RNJCqGfxuCNcXFXdx
 hZSPBcWQi2t1wcr+Rc03HVNe/O0oU+T79e8Lwlk07Fr9NSaEub0qI4vmc c=;
X-IronPort-AV: E=Sophos;i="6.09,288,1716249600"; d="scan'208";a="320836915"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 08:17:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:24837]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.1:2525] with
 esmtp (Farcaster)
 id 8c7742f7-211f-4d15-99db-acbdda8d4c4a; Wed, 14 Aug 2024 08:17:49 +0000 (UTC)
X-Farcaster-Flow-ID: 8c7742f7-211f-4d15-99db-acbdda8d4c4a
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 14 Aug 2024 08:17:49 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Wed, 14 Aug 2024
 08:17:46 +0000
Message-ID: <01d825dd-4c5a-4532-b4b2-6e5d63eee131@amazon.com>
Date: Wed, 14 Aug 2024 10:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] machine/nitro-enclave: Add vhost-user-vsock device
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
CC: <qemu-devel@nongnu.org>, <agraf@csgraf.de>, <stefanha@redhat.com>,
 <pbonzini@redhat.com>, <slp@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-3-dorjoychy111@gmail.com> <ZrobFFVV4tN6dueh@redhat.com>
 <CAFfO_h7nNatk=WgGiZcrTR_YEhAYniY=aeBrsxsnE_KEv+fL4Q@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAFfO_h7nNatk=WgGiZcrTR_YEhAYniY=aeBrsxsnE_KEv+fL4Q@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=99.78.197.218;
 envelope-from=prvs=94947ded6=graf@amazon.de; helo=smtp-fw-80007.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Ck9uIDEzLjA4LjI0IDIwOjAyLCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IE9uIE1vbiwgQXVn
IDEyLCAyMDI0IGF0IDg6MjTigK9QTSBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRo
YXQuY29tPiB3cm90ZToKPj4gT24gU2F0LCBBdWcgMTAsIDIwMjQgYXQgMTA6NDQ6NTlQTSArMDYw
MCwgRG9yam95IENob3dkaHVyeSB3cm90ZToKPj4+IEFXUyBOaXRybyBFbmNsYXZlcyBoYXZlIGJ1
aWx0LWluIHZob3N0LXZzb2NrIGRldmljZSBzdXBwb3J0IHdoaWNoCj4+PiBlbmFibGVzIGFwcGxp
Y2F0aW9ucyBpbiBlbmNsYXZlIFZNcyB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSBwYXJlbnQKPj4+
IEVDMiBWTSBvdmVyIHZzb2NrLiBUaGUgZW5jbGF2ZSBWTXMgaGF2ZSBkeW5hbWljIENJRCB3aGls
ZSB0aGUgcGFyZW50Cj4+PiBhbHdheXMgaGFzIENJRCAzLiBJbiBRRU1VLCB0aGUgdnNvY2sgZW11
bGF0aW9uIGZvciBuaXRybyBlbmNsYXZlIGlzCj4+PiBhZGRlZCB1c2luZyB2aG9zdC11c2VyLXZz
b2NrIGFzIG9wcG9zZWQgdG8gdmhvc3QtdnNvY2suIHZob3N0LXZzb2NrCj4+PiBkb2Vzbid0IHN1
cHBvcnQgc2libGluZyBWTSBjb21tdW5pY2F0aW9uIHdoaWNoIGlzIG5lZWRlZCBmb3Igbml0cm8K
Pj4+IGVuY2xhdmVzLgo+Pj4KPj4+IEluIFFFTVUncyBuaXRyby1lbmNsYXZlIGVtdWxhdGlvbiwg
Zm9yIHRoZSB2c29jayBjb21tdW5pY2F0aW9uIHRvIENJRAo+Pj4gMyB0byB3b3JrLCBhbm90aGVy
IHByb2Nlc3MgdGhhdCBkb2VzIHRoZSB2c29jayBlbXVsYXRpb24gaW4gIHVzZXJzcGFjZQo+Pj4g
bXVzdCBiZSBydW4sIGZvciBleGFtcGxlLCB2aG9zdC1kZXZpY2UtdnNvY2tbMV0gZnJvbSBydXN0
LXZtbSwgd2l0aAo+Pj4gbmVjZXNzYXJ5IHZzb2NrIGNvbW11bmljYXRpb24gc3VwcG9ydCBpbiBh
bm90aGVyIGd1ZXN0IFZNIHdpdGggQ0lEIDMuCj4+PiBBIG5ldyBtYW5kYXRvcnkgbml0cm8tZW5j
bGF2ZSBtYWNoaW5lIG9wdGlvbiAndnNvY2snIGhhcyBiZWVuIGFkZGVkLgo+Pj4gVGhlIHZhbHVl
IGZvciB0aGlzIG9wdGlvbiBzaG91bGQgYmUgdGhlIGNoYXJkZXYgaWQgZnJvbSB0aGUgJy1jaGFy
ZGV2Jwo+Pj4gb3B0aW9uIGZvciB0aGUgdmhvc3QtdXNlci12c29jayBkZXZpY2UgdG8gd29yay4K
Pj4+Cj4+PiBVc2luZyB2aG9zdC11c2VyLXZzb2NrIGFsc28gZW5hYmxlcyB0aGUgcG9zc2liaWxp
dHkgdG8gaW1wbGVtZW50IHNvbWUKPj4+IHByb3h5aW5nIHN1cHBvcnQgaW4gdGhlIHZob3N0LXVz
ZXItdnNvY2sgZGFlbW9uIHRoYXQgd2lsbCBmb3J3YXJkIGFsbAo+Pj4gdGhlIHBhY2tldHMgdG8g
dGhlIGhvc3QgbWFjaGluZSBpbnN0ZWFkIG9mIENJRCAzIHNvIHRoYXQgdXNlcnMgb2YKPj4+IG5p
dHJvLWVuY2xhdmUgY2FuIHJ1biB0aGUgbmVjZXNzYXJ5IGFwcGxpY2F0aW9ucyBpbiB0aGVpciBo
b3N0IG1hY2hpbmUKPj4+IGluc3RlYWQgb2YgcnVubmluZyBhbm90aGVyIHdob2xlIFZNIHdpdGgg
Q0lEIDMuCj4+Pgo+Pj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9ydXN0LXZtbS92aG9zdC1kZXZp
Y2UvdHJlZS9tYWluL3Zob3N0LWRldmljZS12c29jawo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IERv
cmpveSBDaG93ZGh1cnkgPGRvcmpveWNoeTExMUBnbWFpbC5jb20+Cj4+PiAtLS0KPj4+ICAgYmFj
a2VuZHMvaG9zdG1lbS1tZW1mZC5jICAgICAgICB8ICAgMiAtCj4+PiAgIGh3L2NvcmUvbWFjaGlu
ZS5jICAgICAgICAgICAgICAgfCAgNzEgKysrKysrKysrLS0tLS0tLS0tCj4+PiAgIGh3L2kzODYv
S2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgIDEgKwo+Pj4gICBody9pMzg2L25pdHJvX2VuY2xh
dmUuYyAgICAgICAgIHwgMTIzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiAg
IGluY2x1ZGUvaHcvYm9hcmRzLmggICAgICAgICAgICAgfCAgIDIgKwo+Pj4gICBpbmNsdWRlL2h3
L2kzODYvbml0cm9fZW5jbGF2ZS5oIHwgICA4ICsrKwo+Pj4gICBpbmNsdWRlL3N5c2VtdS9ob3N0
bWVtLmggICAgICAgIHwgICAyICsKPj4+ICAgNyBmaWxlcyBjaGFuZ2VkLCAxNzQgaW5zZXJ0aW9u
cygrKSwgMzUgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvbml0cm9f
ZW5jbGF2ZS5jIGIvaHcvaTM4Ni9uaXRyb19lbmNsYXZlLmMKPj4+IGluZGV4IDk4NjkwYzYzNzMu
LjI4MGFiNGNjOWIgMTAwNjQ0Cj4+PiAtLS0gYS9ody9pMzg2L25pdHJvX2VuY2xhdmUuYwo+Pj4g
KysrIGIvaHcvaTM4Ni9uaXRyb19lbmNsYXZlLmMKPj4+IEBAIC0xMSwxMSArMTEsODEgQEAKPj4+
ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIKPj4+ICAgI2luY2x1ZGUgInFlbXUvZXJyb3ItcmVw
b3J0LmgiCj4+PiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiCj4+PiArI2luY2x1ZGUgInFvbS9v
YmplY3RfaW50ZXJmYWNlcy5oIgo+Pj4KPj4+ICsjaW5jbHVkZSAiY2hhcmRldi9jaGFyLmgiCj4+
PiArI2luY2x1ZGUgImh3L3N5c2J1cy5oIgo+Pj4gICAjaW5jbHVkZSAiaHcvY29yZS9laWYuaCIK
Pj4+ICAgI2luY2x1ZGUgImh3L2kzODYveDg2LmgiCj4+PiAgICNpbmNsdWRlICJody9pMzg2L21p
Y3Jvdm0uaCIKPj4+ICAgI2luY2x1ZGUgImh3L2kzODYvbml0cm9fZW5jbGF2ZS5oIgo+Pj4gKyNp
bmNsdWRlICJody92aXJ0aW8vdmlydGlvLW1taW8uaCIKPj4+ICsjaW5jbHVkZSAiaHcvdmlydGlv
L3Zob3N0LXVzZXItdnNvY2suaCIKPj4+ICsjaW5jbHVkZSAic3lzZW11L2hvc3RtZW0uaCIKPj4+
ICsKPj4+ICtzdGF0aWMgQnVzU3RhdGUgKmZpbmRfZnJlZV92aXJ0aW9fbW1pb19idXModm9pZCkK
Pj4+ICt7Cj4+PiArICAgIEJ1c0NoaWxkICpraWQ7Cj4+PiArICAgIEJ1c1N0YXRlICpidXMgPSBz
eXNidXNfZ2V0X2RlZmF1bHQoKTsKPj4+ICsKPj4+ICsgICAgUVRBSUxRX0ZPUkVBQ0goa2lkLCAm
YnVzLT5jaGlsZHJlbiwgc2libGluZykgewo+Pj4gKyAgICAgICAgRGV2aWNlU3RhdGUgKmRldiA9
IGtpZC0+Y2hpbGQ7Cj4+PiArICAgICAgICBpZiAob2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1Qo
ZGV2KSwgVFlQRV9WSVJUSU9fTU1JTykpIHsKPj4+ICsgICAgICAgICAgICBWaXJ0SU9NTUlPUHJv
eHkgKm1taW8gPSBWSVJUSU9fTU1JTyhPQkpFQ1QoZGV2KSk7Cj4+PiArICAgICAgICAgICAgVmly
dGlvQnVzU3RhdGUgKm1taW9fdmlydGlvX2J1cyA9ICZtbWlvLT5idXM7Cj4+PiArICAgICAgICAg
ICAgQnVzU3RhdGUgKm1taW9fYnVzID0gJm1taW9fdmlydGlvX2J1cy0+cGFyZW50X29iajsKPj4+
ICsgICAgICAgICAgICBpZiAoUVRBSUxRX0VNUFRZKCZtbWlvX2J1cy0+Y2hpbGRyZW4pKSB7Cj4+
PiArICAgICAgICAgICAgICAgIHJldHVybiBtbWlvX2J1czsKPj4+ICsgICAgICAgICAgICB9Cj4+
PiArICAgICAgICB9Cj4+PiArICAgIH0KPj4+ICsKPj4+ICsgICAgcmV0dXJuIE5VTEw7Cj4+PiAr
fQo+Pj4gKwo+Pj4gK3N0YXRpYyB2b2lkIHZob3N0X3VzZXJfdnNvY2tfaW5pdChOaXRyb0VuY2xh
dmVNYWNoaW5lU3RhdGUgKm5lbXMpCj4+PiArewo+Pj4gKyAgICBEZXZpY2VTdGF0ZSAqZGV2ID0g
cWRldl9uZXcoVFlQRV9WSE9TVF9VU0VSX1ZTT0NLKTsKPj4+ICsgICAgVkhvc3RVc2VyVlNvY2sg
KnZzb2NrID0gVkhPU1RfVVNFUl9WU09DSyhkZXYpOwo+Pj4gKyAgICBCdXNTdGF0ZSAqYnVzOwo+
Pj4gKwo+Pj4gKyAgICBpZiAoIW5lbXMtPnZzb2NrKSB7Cj4+PiArICAgICAgICBlcnJvcl9yZXBv
cnQoIkEgdmFsaWQgY2hhcmRldiBpZCBmb3Igdmhvc3QtdXNlci12c29jayBkZXZpY2UgbXVzdCBi
ZSAiCj4+PiArICAgICAgICAgICAgICAgICAgICAgInByb3ZpZGVkIHVzaW5nIHRoZSAndnNvY2sn
IG1hY2hpbmUgb3B0aW9uIik7Cj4+PiArICAgICAgICBleGl0KDEpOwo+Pj4gKyAgICB9Cj4+PiAr
Cj4+PiArICAgIGJ1cyA9IGZpbmRfZnJlZV92aXJ0aW9fbW1pb19idXMoKTsKPj4+ICsgICAgaWYg
KCFidXMpIHsKPj4+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiRmFpbGVkIHRvIGZpbmQgYnVzIGZv
ciB2aG9zdC11c2VyLXZzb2NrIGRldmljZSIpOwo+Pj4gKyAgICAgICAgZXhpdCgxKTsKPj4+ICsg
ICAgfQo+Pj4gKwo+Pj4gKyAgICBDaGFyZGV2ICpjaGFyZGV2ID0gcWVtdV9jaHJfZmluZChuZW1z
LT52c29jayk7Cj4+PiArICAgIGlmICghY2hhcmRldikgewo+Pj4gKyAgICAgICAgZXJyb3JfcmVw
b3J0KCJGYWlsZWQgdG8gZmluZCBjaGFyZGV2IHdpdGggaWQgJXMiLCBuZW1zLT52c29jayk7Cj4+
PiArICAgICAgICBleGl0KDEpOwo+Pj4gKyAgICB9Cj4+PiArCj4+PiArICAgIHZzb2NrLT5jb25m
LmNoYXJkZXYuY2hyID0gY2hhcmRldjsKPj4+ICsKPj4+ICsgICAgcWRldl9yZWFsaXplX2FuZF91
bnJlZihkZXYsIGJ1cywgJmVycm9yX2ZhdGFsKTsKPj4+ICt9Cj4+IFdoeSBkb2VzIHRoaXMgbWFj
aGluZSBuZWVkIHRvIGNyZWF0ZSB0aGUgdmhvc3QtdXNlci12c29jayBkZXZpY2UgaXRzZWxmID8K
Pj4gRG9pbmcgaXQgdGhpcyB3YXkgcHJldmVudHMgdGhlIG1nbXQgYXBwIGZyb20gY2hhbmdpbmcg
YW55IG9mIHRoZSBvdGhlcgo+PiB2c29jayBkZXZpY2Ugc2V0dGluZ3MgYmV5b25kICdjaGFyZGV2
Jy4gVGhlIGVudGl0eSBjcmVhdGluZyBRRU1VIGNhbiB1c2UKPj4gLWRldmljZSB0byBjcmVhdGUg
dGhlIHZzb2NrIGRldmljZS4KPj4KPiBIaSBEYW5pZWwuIEdvb2QgcG9pbnQuIFRoZSByZWFzb24g
dG8gbWFrZSB0aGUgdmhvc3QtdXNlci12c29jayBkZXZpY2UKPiBidWlsdC1pbiBpcyBiZWNhdXNl
IG5pdHJvIFZNcyB3aWxsIGFsd2F5cyBuZWVkIGl0IGFueXdheSAobGlrZSB0aGUKPiB2aXJ0aW8t
bnNtIGRldmljZSB3aGljaCBpcyBidWlsdC1pbiB0b28pLiBXaGVuIGFuIEVJRiBpbWFnZSBpcyBi
dWlsdAo+IHVzaW5nIG5pdHJvLWNsaSB0aGUgImluaXQiIHByb2Nlc3MgaW4gdGhlIEVJRiBpbWFn
ZSB0cmllcyB0byBjb25uZWN0Cj4gdG8gKEFGX1ZTT0NLLCBDSUQgMywgcG9ydCA5MDAwKSB0byBz
ZW5kIGEgaGVhcnRiZWF0IGFuZCBleHBlY3RzIGEKPiBoZWFydGJlYXQgcmVwbHkuIFNvIG15IHVu
ZGVyc3RhbmRpbmcgaXMgdGhhdCBpZiB3ZSBkb24ndCBjcmVhdGUgaXQKPiBpbnNpZGUgdGhlIG1h
Y2hpbmUgY29kZSBpdHNlbGYsIHVzZXJzIHdvdWxkIGFsd2F5cyBuZWVkIHRvIHByb3ZpZGUgdGhl
Cj4gZXhwbGljaXQgb3B0aW9ucyBmb3IgdGhlIGRldmljZSBhbnl3YXkuIEJ1dCBhcyB5b3UgcG9p
bnQgb3V0IHRoaXMgYWxzbwo+IG1ha2VzIHRoZSBkZXZpY2Ugc2V0dGluZ3Mgbm9uLWNvbmZpZ3Vy
YWJsZS4KPgo+IEhleSBBbGV4LCBkbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMgb24gdGhpcz8K
CgpJTUhPIGRldmljZXMgdGhhdCBhcmUgcmVxdWlyZWQgZm9yIHRoZSBtYWNoaW5lIHRvIGZ1bmN0
aW9uIHNob3VsZCBiZSAKcGFydCBvZiB0aGUgbWFjaGluZS4gU2luY2UgdnNvY2sgaXMgYSBjb3Jl
IHBhcnQgb2YgdGhlIE5pdHJvIEVuY2xhdmUsIGl0IApzaG91bGQgYmUgcGFydCBvZiB0aGUgbWFj
aGluZSBkZWZpbml0aW9uLiBJdCdzIGFzIG11Y2ggYSBib2FyZCAKZGVwZW5kZW5jeSBhcyBmd19j
ZmcuCgpBbGV4CgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzog
Q2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dl
cmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3Qt
SUQ6IERFIDM2NSA1MzggNTk3Cg==


