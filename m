Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DA8C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCx6d-0007eO-8p; Fri, 31 May 2024 03:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8746dd36b=graf@amazon.de>)
 id 1sCx6W-0007bE-No
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:55:13 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8746dd36b=graf@amazon.de>)
 id 1sCx6S-0007yg-NC
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1717142109; x=1748678109;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=C80pYeY4hgvTyVPPo5ZRPttiipziTviPWAQ0HqfcCIU=;
 b=HtB6ur7YoSzt5mgGhUOt/kjqZY+yNrAPmSChzJHr07oJZlUDPr9JY/7G
 S6ofF4TcL1KMJcHc9Kdxl7TCWHJVMIC2jceUiPEothFflWa7LRBwP4tnk
 6cim6CmoEZbs/yPQ2vJiBySFOZgIp2xqpQsVucUJSfvi+5KZooMdyX41W k=;
X-IronPort-AV: E=Sophos;i="6.08,203,1712620800"; d="scan'208";a="400158324"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-6001.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:55:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:60392]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.28:2525]
 with esmtp (Farcaster)
 id 01691761-dfb2-42be-b31c-efa0404303b7; Fri, 31 May 2024 07:55:02 +0000 (UTC)
X-Farcaster-Flow-ID: 01691761-dfb2-42be-b31c-efa0404303b7
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 07:55:02 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 31 May
 2024 07:54:59 +0000
Message-ID: <18cf2f43-9f79-4dd6-b581-ece9e2a02c64@amazon.com>
Date: Fri, 31 May 2024 09:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] machine/microvm: support for loading EIF image
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
CC: <qemu-devel@nongnu.org>, <agraf@csgraf.de>, <stefanha@redhat.com>,
 <pbonzini@redhat.com>, <slp@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
 <20240518080753.7083-2-dorjoychy111@gmail.com> <Zk4QGlUAmre1l74h@redhat.com>
 <CAFfO_h4yLaX9ajTWo+obHYjozJ1NvUouvfFr7AqcrSaCgo8SVg@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAFfO_h4yLaX9ajTWo+obHYjozJ1NvUouvfFr7AqcrSaCgo8SVg@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.95.48.154;
 envelope-from=prvs=8746dd36b=graf@amazon.de; helo=smtp-fw-6001.amazon.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Ck9uIDIyLjA1LjI0IDE5OjIzLCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IEhpIERhbmllbCwK
PiBUaGFua3MgZm9yIHJldmlld2luZy4KPgo+IE9uIFdlZCwgTWF5IDIyLCAyMDI0IGF0IDk6MzLi
gK9QTSBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToKPj4g
T24gU2F0LCBNYXkgMTgsIDIwMjQgYXQgMDI6MDc6NTJQTSArMDYwMCwgRG9yam95IENob3dkaHVy
eSB3cm90ZToKPj4+IEFuIEVJRiAoRW5jbGF2ZSBJbWFnZSBGb3JtYXQpWzFdIGltYWdlIGlzIHVz
ZWQgdG8gYm9vdCBhbiBBV1Mgbml0cm8KPj4+IGVuY2xhdmVbMl0gdmlydHVhbCBtYWNoaW5lLiBU
aGUgRUlGIGZpbGUgY29udGFpbnMgdGhlIG5lY2Vzc2FyeQo+Pj4ga2VybmVsLCBjbWRsaW5lLCBy
YW1kaXNrKHMpIHNlY3Rpb25zIHRvIGJvb3QuCj4+Pgo+Pj4gVGhpcyBjb21taXQgYWRkcyBzdXBw
b3J0IGZvciBsb2FkaW5nIEVJRiBpbWFnZSB1c2luZyB0aGUgbWljcm92bQo+Pj4gbWFjaGluZSBj
b2RlLiBGb3IgbWljcm92bSB0byBib290IGZyb20gYW4gRUlGIGZpbGUsIHRoZSBrZXJuZWwgYW5k
Cj4+PiByYW1kaXNrKHMpIGFyZSBleHRyYWN0ZWQgaW50byBhIHRlbXBvcmFyeSBrZXJuZWwgYW5k
IGEgdGVtcG9yYXJ5Cj4+PiBpbml0cmQgZmlsZSB3aGljaCBhcmUgdGhlbiBob29rZWQgaW50byB0
aGUgcmVndWxhciB4ODYgYm9vdCBtZWNoYW5pc20KPj4+IGFsb25nIHdpdGggdGhlIGV4dHJhY3Rl
ZCBjbWRsaW5lLgo+PiBJIGNhbiB1bmRlcnN0YW5kIHdoeSB5b3UgZGlkIGl0IHRoaXMgd2F5LCBi
dXQgSSBmZWVsIGl0cyBwcmV0dHkKPj4gZ3Jvc3MgdG8gYmUgbG9hZGluZyBldmVyeXRoaW5nIGlu
dG8gbWVtb3J5LCB3cml0aW5nIGl0IGJhY2sgdG8KPj4gZGlzaywgYW5kIHRoZW4gaW1tZWRpYXRl
bHkgbG9hZGluZyBpdCBhbGwgYmFjayBpbnRvIG1lbW9yeS4KPj4KPj4gVGhlIHJvb3QgcHJvYmxl
bSBpcyB0aGUgeDg2X2xvYWRfbGludXgoKSBtZXRob2QsIHdoaWNoIGRpcmVjdGx5Cj4+IGFjY2Vz
c2VzIHRoZSBtYWNoaW5lIHByb3BlcnRpZXM6Cj4+Cj4+ICAgICAgY29uc3QgY2hhciAqa2VybmVs
X2ZpbGVuYW1lID0gbWFjaGluZS0+a2VybmVsX2ZpbGVuYW1lOwo+PiAgICAgIGNvbnN0IGNoYXIg
KmluaXRyZF9maWxlbmFtZSA9IG1hY2hpbmUtPmluaXRyZF9maWxlbmFtZTsKPj4gICAgICBjb25z
dCBjaGFyICpkdGJfZmlsZW5hbWUgPSBtYWNoaW5lLT5kdGI7Cj4+ICAgICAgY29uc3QgY2hhciAq
a2VybmVsX2NtZGxpbmUgPSBtYWNoaW5lLT5rZXJuZWxfY21kbGluZTsKPj4KPj4gVG8gcHJvcGVy
bHkgaGFuZGxlIHRoaXMsIEknZCBzYXkgd2UgbmVlZCB0byBpbnRyb2R1Y2UgYW4gYWJzdHJhY3Rp
b24KPj4gZm9yIGxvYWRpbmcgdGhlIGtlcm5lbC9pbml0dHJkL2NtZGxraW5lIGRhdGEuCj4+Cj4+
IGllIG9uIHRoZSAgIFg4Nk1hY2hpbmVDbGFzcyBvYmplY3QsIHdlIHNob3VsZCBpbnRyb2R1Y2Ug
Zm91ciB2aXJ0dWFsCj4+IG1ldGhvZHMKPj4KPj4gICAgIHVpbnQ4X3QgKigqbG9hZF9rZXJuZWwp
KFg4Nk1hY2hpbmVTdGF0ZSAqbWFjaGluZSk7Cj4+ICAgICB1aW50OF90ICooKmxvYWRfaW5pdHJk
KShYODZNYWNoaW5lU3RhdGUgKm1hY2hpbmUpOwo+PiAgICAgdWludDhfdCAqKCpsb2FkX2R0Yiko
WDg2TWFjaGluZVN0YXRlICptYWNoaW5lKTsKPj4gICAgIHVpbnQ4X3QgKigqbG9hZF9jbWRsaW5l
KShYODZNYWNoaW5lU3RhdGUgKm1hY2hpbmUpOwo+Pgo+PiBUaGUgZGVmYXVsdCBpbXBsIG9mIHRo
ZXNlIGZvdXIgbWV0aG9kcyBzaG91bGQganVzdCBmb2xsb3dpbmcgdGhlCj4+IGV4aXN0aW5nIGxv
Z2ljLCBvZiByZWFkaW5nIGFuZCByZXR1cm5pbmcgdGhlIGRhdGEgYXNzb2NpYXRlZCB3aXRoCj4+
IHRoZSBrZXJuZWxfZmlsZW5hbWUsIGluaXRyZF9maWxlbmFtZSwgZHRiIGFuZCBrZXJuZWxfY21k
bGluZQo+PiBwcm9wZXJ0aWVzLgo+Pgo+PiBUaGUgTml0cm8gbWFjaGluZSBzdWItY2xhc3MsIGhv
d2V2ZXIsIGNhbiBwcm92aWRlIGFuIGFsdGVybmF0aXZlCj4+IGltcGwgb2YgdGhzZSB2aXJ0dWFs
IG1ldGhvZHMgd2hpY2ggcmV0dXJucyBkYXRhIGRpcmVjdGx5IGZyb20KPj4gdGhlIEVJRiBmaWxl
IGluc3RlYWQuCj4+Cj4gR3JlYXQgc3VnZ2VzdGlvbiEgSSBhZ3JlZSB0aGUgaW1wbGVtZW50YXRp
b24gcGF0aCB5b3Ugc3VnZ2VzdGVkIHdvdWxkCj4gbG9vayBtdWNoIG5pY2VyIGFzIGEgd2hvbGUu
IE5vdyB0aGF0IEkgbG9va2VkIGEgYml0IGludG8gdGhlCj4gIng4Nl9sb2FkX2xpbnV4IiBpbXBs
ZW1lbnRhdGlvbiwgaXQgbG9va3MgbGlrZSBwcmV0dHkgbXVjaCBldmVyeXRoaW5nCj4gaXMgdGll
ZCB0byBleHBlY3RpbmcgYSBmaWxlbmFtZS4gRm9yIGV4YW1wbGUsIGFmdGVyIHJlYWRpbmcgdGhl
IGhlYWRlcgo+IGZyb20gdGhlIGtlcm5lbF9maWxlbmFtZSB4ODZfbG9hZF9saW51eCBjYWxscyBp
bnRvIGxvYWRfbXVsdGlib290LAo+IGxvYWRfZWxmICh3aGljaCBpbiB0dXJuIGNhbGxzIGxvYWRf
ZWxmNjQsIDMyKSBhbmQgdGhleSBhbGwgZXhwZWN0IGEKPiBmaWxlbmFtZS4gSSB0aGluayBJIHdv
dWxkIG5lZWQgdG8gcmVmYWN0b3IgYWxsIG9mIHRoZW0gdG8gaW5zdGVhZCB3b3JrCj4gd2l0aCAo
dWludDhfdCAqKSBidWZmZXJzIGluc3RlYWQsIHJpZ2h0PyBBbHNvIGluIGNhc2Ugb2YKPiBpbml0
cmRfZmlsZW5hbWUgdGhlIGV4aXN0aW5nIGNvZGUgbWFwcyB0aGUgZmlsZSB1c2luZwo+IGdfbWFw
cGVkX2ZpbGVfbmV3IHRvIHRoZSBYODZNYWNoaW5lU3RhdGUgbWVtYmVyIGluaXRyZF9tYXBwZWRf
ZmlsZS4gU28KPiB0aGF0IHdpbGwgbmVlZCB0byBiZSBsb29rZWQgaW50byBhbmQgcmVmYWN0b3Jl
ZC4gUGxlYXNlIGNvcnJlY3QgbWUgaWYKPiBJIG1pc3VuZGVyc3Rvb2Qgc29tZXRoaW5nIGFib3V0
IHRoZSB3YXkgdG8gaW1wbGVtZW50IHlvdXIgc3VnZ2VzdGVkCj4gYXBwcm9hY2guCj4KPiBJZiBJ
IGFtIHVuZGVyc3RhbmRpbmcgdGhpcyByaWdodCwgdGhpcyBwcm9iYWJseSByZXF1aXJlcyBhIGxv
dCBvZiB3b3JrCj4gd2hpY2ggd2lsbCBhbHNvIHByb2JhYmx5IG5vdCBiZSBzdHJhaWdodGZvcndh
cmQgdG8gaW1wbGVtZW50IG9yIHRlc3QuCj4gUmlnaHQgbm93LCB0aGUgd2F5IHRoZSBjb2RlIGlz
LCBpdCdzIGVhc3kgdG8gc2VlIHRoYXQgdGhlIGV4aXN0aW5nCj4gY29kZSBwYXRocyBhcmUgc3Rp
bGwgY29ycmVjdCBhcyB0aGV5IGFyZSBub3QgY2hhbmdlZCBhbmQgdGhlIG5ldwo+IG5pdHJvLWVu
Y2xhdmUgbWFjaGluZSBjb2RlIGp1c3QgaG9va3MgaW50byB0aGVtLiBBcyB0aGUgbG9hZGluZyB0
bwo+IG1lbW9yeSwgd3JpdGluZyB0byBkaXNrIGFuZCBsb2FkaW5nIGJhY2sgdG8gbWVtb3J5IG9u
bHkgaXMgaW4gdGhlCj4gZXhlY3V0aW9uIHBhdGggb2YgdGhlIG5ldyBuaXRyby1lbmNsYXZlIG1h
Y2hpbmUgdHlwZSwgSSB0aGluayB0aGUgd2F5Cj4gdGhlIHBhdGNoIGlzIHJpZ2h0IG5vdywgaXMg
YSBnb29kIGZpcnN0IGltcGxlbWVudGF0aW9uLiBXaGF0IGRvIHlvdQo+IHRoaW5rPwoKCkkgdGhp
bmsgdGhlICJyZWFsIiBmaXggaGVyZSBpcyB0byBtb3ZlIGFsbCBvZiB0aGUgY3J1ZnR5IGxvYWRl
ciBsb2dpYyAKZnJvbSAiZmlsZSBhY2Nlc3MiIHRvICJibG9jayBsYXllciBhY2Nlc3MiLiBBbG9u
ZyB3aXRoIHRoYXQsIGNyZWF0ZSBhIApnZW5lcmljIGhlbHBlciBmdW5jdGlvbiAobGlrZSB0aGlz
WzFdKSB0aGF0IG9wZW5zIGFsbCAKLWtlcm5lbC8taW5pdHJkLy1kdGIgZmlsZXMgdGhyb3VnaCB0
aGUgYmxvY2sgbGF5ZXIgYW5kIGNhbGxzIGEgYm9hcmQgCnNwZWNpZmljIGNhbGxiYWNrIHRvIHBl
cmZvcm0gdGhlIGxvYWQuCgpXaXRoIHRoYXQgaW4gcGxhY2UsIHdlIHdvdWxkIGhhdmUgYSByZWVu
dHJhbnQgY29kZSBwYXRoIGZvciB0aGUgRUlGIApjYXNlOiBFSUYgY291bGQgcGx1ZyBpbnRvIHRo
ZSBnZW5lcmljIHg4NiBsb2FkZXIgYW5kIHdoZW4gaXQgZGV0ZWN0cyAKRUlGLCBjcmVhdGUgaW50
ZXJuYWwgYmxvY2sgZGV2aWNlcyB0aGF0IHJlZmVyZW5jZSB0aGUgZXhpc3RpbmcgZmlsZSBwbHVz
IAphbiBvZmZzZXQvbGltaXQgc2V0dGluZyB0byBlbnN1cmUgaXQgb25seSBhY2Nlc3NlcyB0aGUg
Y29ycmVjdCByYW5nZSBpbiAKdGhlIHRhcmdldCBmaWxlLiBJdCBjYW4gdGhlbiBzaW1wbHkgcmVp
bnZva2UgdGhlIHg4NiBsb2FkZXIgd2l0aCB0aGUgbmV3IApibG9jayBkZXZpY2Ugb2JqZWN0cy4K
CldpdGggdGhhdCBpbiBwbGFjZSwgd2UgY291bGQgYWxzbyBmaW5hbGx5IHN1cHBvcnQgLWtlcm5l
bCAKaHR0cDovLy4uLi92bWxpbnV6IGNvbW1hbmQgbGluZSBpbnZvY2F0aW9ucyB3aGljaCBjdXJy
ZW50bHkgb25seSB3b3JrcyAKb24gYmxvY2sgZGV2aWNlcy4KCkhvd2V2ZXIsIEkgZG8gYWdyZWUg
dGhhdCB0aGUgYWJvdmUgaXMgc2lnbmlmaWNhbnQgZWZmb3J0IHRvIGdldCBnb2luZyAKYW5kIHNo
b3VsZG4ndCBob2xkIGJhY2sgdGhlIE5pdHJvIEVuY2xhdmUgbWFjaGluZSBtb2RlbC4KCgpBbGV4
CgoKWzFdIApodHRwczovL2dpdGh1Yi5jb20vYWdyYWYvcWVtdS9jb21taXQvZTQ5YjdhMThmMmQ4
YTM4NmU1ZjIwN2M1NjdhZDlhYjJlM2NiNTQyOQoKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2
ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4K
R2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpF
aW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0
IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


