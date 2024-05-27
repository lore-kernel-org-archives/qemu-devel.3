Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E52C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcd2-0002sm-De; Mon, 27 May 2024 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=87085421f=graf@amazon.de>)
 id 1sBcd0-0002rt-AF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:51:14 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=87085421f=graf@amazon.de>)
 id 1sBccw-0006GZ-EI
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1716825071; x=1748361071;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=oBtEMyu8Uz1YHZeVfTiPOkKoJS7ISlby/4/xzC1I8XU=;
 b=ugRjm4tJwc5LjnXrYwoolSQDWBAvtG9CQ2WvkCtao1Gp6ik//MonilOc
 xe9MCLJ7L6YNigFDaVpqCTTHWBJoPlO68KzNjQPzcl/fKj5z5KvvFrnKd
 CbmKhWLFZY6ACrkiAF7Yec74tlVljPSLV1oP0iv00WGsSBgnxXfnrVSFf Y=;
X-IronPort-AV: E=Sophos;i="6.08,192,1712620800"; d="scan'208";a="297786253"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 15:51:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:8405]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.45:2525]
 with esmtp (Farcaster)
 id 0fb5fbe9-09a5-4dd5-8cd8-8ab84c7d62bf; Mon, 27 May 2024 15:51:05 +0000 (UTC)
X-Farcaster-Flow-ID: 0fb5fbe9-09a5-4dd5-8cd8-8ab84c7d62bf
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 27 May 2024 15:51:04 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 27 May
 2024 15:51:02 +0000
Message-ID: <919e6b8c-2f9b-4f91-97e2-20146bf18263@amazon.com>
Date: Mon, 27 May 2024 17:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] machine/microvm: support for loading EIF image
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <agraf@csgraf.de>, <stefanha@redhat.com>,
 <pbonzini@redhat.com>, <slp@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
 <20240518080753.7083-2-dorjoychy111@gmail.com>
 <bf9dc551-49e4-4ed9-941d-c095bab5755a@linaro.org>
 <CAFfO_h7_V13k9WizTYrY-UsjUhvWFeY4Fn7a_8_c4qEz4=hYFg@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAFfO_h7_V13k9WizTYrY-UsjUhvWFeY4Fn7a_8_c4qEz4=hYFg@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=99.78.197.217;
 envelope-from=prvs=87085421f=graf@amazon.de; helo=smtp-fw-80006.amazon.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

Ck9uIDI3LjA1LjI0IDE2OjUyLCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IEhpIFBoaWxpcHBl
LAo+IFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nLgo+Cj4gT24gTW9uLCBNYXkgMjcsIDIwMjQgYXQg
NDo0N+KAr1BNIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpCj4gPHBoaWxtZEBsaW5hcm8ub3JnPiB3
cm90ZToKPj4gSGkgRG9yam95LAo+Pgo+PiBPbiAxOC81LzI0IDEwOjA3LCBEb3Jqb3kgQ2hvd2Ro
dXJ5IHdyb3RlOgo+Pj4gQW4gRUlGIChFbmNsYXZlIEltYWdlIEZvcm1hdClbMV0gaW1hZ2UgaXMg
dXNlZCB0byBib290IGFuIEFXUyBuaXRybwo+Pj4gZW5jbGF2ZVsyXSB2aXJ0dWFsIG1hY2hpbmUu
IFRoZSBFSUYgZmlsZSBjb250YWlucyB0aGUgbmVjZXNzYXJ5Cj4+PiBrZXJuZWwsIGNtZGxpbmUs
IHJhbWRpc2socykgc2VjdGlvbnMgdG8gYm9vdC4KPj4+Cj4+PiBUaGlzIGNvbW1pdCBhZGRzIHN1
cHBvcnQgZm9yIGxvYWRpbmcgRUlGIGltYWdlIHVzaW5nIHRoZSBtaWNyb3ZtCj4+PiBtYWNoaW5l
IGNvZGUuIEZvciBtaWNyb3ZtIHRvIGJvb3QgZnJvbSBhbiBFSUYgZmlsZSwgdGhlIGtlcm5lbCBh
bmQKPj4+IHJhbWRpc2socykgYXJlIGV4dHJhY3RlZCBpbnRvIGEgdGVtcG9yYXJ5IGtlcm5lbCBh
bmQgYSB0ZW1wb3JhcnkKPj4+IGluaXRyZCBmaWxlIHdoaWNoIGFyZSB0aGVuIGhvb2tlZCBpbnRv
IHRoZSByZWd1bGFyIHg4NiBib290IG1lY2hhbmlzbQo+Pj4gYWxvbmcgd2l0aCB0aGUgZXh0cmFj
dGVkIGNtZGxpbmUuCj4+Pgo+Pj4gQWx0aG91Z2ggbm90IHVzZWZ1bCBmb3IgdGhlIG1pY3Jvdm0g
bWFjaGluZSBpdHNlbGYsIHRoaXMgaXMgbmVlZGVkCj4+PiBhcyB0aGUgZm9sbG93aW5nIGNvbW1p
dCBhZGRzIHN1cHBvcnQgZm9yIGEgbmV3IG1hY2hpbmUgdHlwZQo+Pj4gJ25pdHJvLWVuY2xhdmUn
IHdoaWNoIHVzZXMgdGhlIG1pY3Jvdm0gbWFjaGluZSB0eXBlIGFzIHBhcmVudC4gVGhlCj4+PiBj
b2RlIGZvciBjaGVja2luZyBhbmQgbG9hZGluZyBFSUYgd2lsbCBiZSBwdXQgaW5zaWRlIGEgJ25p
dHJvLWVuY2xhdmUnCj4+PiBtYWNoaW5lIHR5cGUgY2hlY2sgaW4gdGhlIGZvbGxvd2luZyBjb21t
aXQgc28gdGhhdCBtaWNyb3ZtIGNhbm5vdCBsb2FkCj4+PiBFSUYgYmVjYXVzZSBpdCBzaG91bGRu
J3QuCj4+Pgo+Pj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9hd3MvYXdzLW5pdHJvLWVuY2xhdmVz
LWltYWdlLWZvcm1hdAo+PiBUaGUgZG9jdW1lbnRhdGlvbiBpcyByYXRoZXIgc2NhcnNlLi4uCj4+
Cj4gRG8geW91IG1lYW4gZG9jdW1lbnRhdGlvbiBhYm91dCBFSUYgZmlsZSBmb3JtYXQ/ICBJZiBz
bywgeWVzLCByaWdodAo+IG5vdyB0aGVyZSBpcyBubyBzcGVjaWZpY2F0aW9uIG90aGVyIHRoYW4g
dGhlIGdpdGh1YiByZXBvIGZvciBFSUYuCj4KPj4+IFsyXSBodHRwczovL2F3cy5hbWF6b24uY29t
L2VjMi9uaXRyby9uaXRyby1lbmNsYXZlcy8KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBEb3Jqb3kg
Q2hvd2RodXJ5IDxkb3Jqb3ljaHkxMTFAZ21haWwuY29tPgo+Pj4gLS0tCj4+PiAgICBody9pMzg2
L2VpZi5jICAgICAgIHwgNDg2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4+PiAgICBody9pMzg2L2VpZi5oICAgICAgIHwgIDIwICsrCj4+PiAgICBody9pMzg2
L21lc29uLmJ1aWxkIHwgICAyICstCj4+IC4uLiBzdGlsbCBpdCBzZWVtcyBhIGdlbmVyaWMgbG9h
ZGVyLCBub3QgcmVzdHJpY3RlZCB0byB4ODYuCj4+Cj4+IE1heWJlIGJldHRlciBhZGQgaXQgYXMg
aHcvY29yZS9sb2FkZXItZWlmLltjaF0/Cj4+Cj4gWWVzLCB0aGUgY29kZSBpbiBlaWYuYyBpcyBh
cmNoaXRlY3R1cmUgYWdub3N0aWMuIFNvIGl0IGNvdWxkIG1ha2UKPiBzZW5zZSB0byBtb3ZlIHRo
ZSBmaWxlcyB0byBody9jb3JlLiBCdXQgSSBkb24ndCB0aGluayB0aGUgbmFtZXMgc2hvdWxkCj4g
aGF2ZSAibG9hZGVyIiBwcmVmaXggYXMgdGhlcmUgaXMgbm8gbG9hZGluZyBsb2dpYyBpbiBlaWYu
Yy4gVGhlcmUgaXMKPiBvbmx5IGxvZ2ljIGZvciBwYXJzaW5nIGFuZCBleHRyYWN0aW5nIGtlcm5l
bCwgaW50aXJkLCBjbWRsaW5lIGV0Yy4KPiBCZWNhdXNlIG5pdHJvLWVuY2xhdmUgbWFjaGluZSB0
eXBlIGlzIGJhc2VkIG9uIG1pY3Jvdm0gd2hpY2ggb25seQo+IHN1cHBvcnRzIHg4NiBub3csIEkg
dGhpbmsgaXQgYWxzbyBtYWtlcyBzZW5zZSB0byBrZWVwIHRoZSBmaWxlcyBpbnNpZGUKPiBody9p
Mzg2IGZvciBub3cgYXMgd2UgY2FuIG9ubHkgcmVhbGx5IGxvYWQgeDg2IGtlcm5lbCB1c2luZyBp
dC4gTWF5YmUKPiBpZiB3ZSwgaW4gdGhlIGZ1dHVyZSwgYWRkIHN1cHBvcnQgZm9yIG90aGVyIGFy
Y2hpdGVjdHVyZXMsIHRoZW4gd2UgY2FuCj4gbW92ZSB0aGVtIHRvIGh3L2NvcmUuIFdoYXQgZG8g
eW91IHRoaW5rPwoKCkkgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gcHV0IEVJRiBwYXJzaW5nIGlu
dG8gZ2VuZXJpYyBjb2RlIGZyb20gdGhlIApzdGFydC4gTml0cm8gRW5jbGF2ZXMgc3VwcG9ydHMg
QWFyY2g2NCB3aXRoIHRoZSBzYW1lIEVJRiBzZW1hbnRpY3MuIEluIApmYWN0LCBpdCB3b3VsZCBi
ZSBwcmV0dHkgc2ltcGxlIHRvIGRvIGEgc3ViLW1hY2hpbmUtY2xhc3Mgc2ltaWxhciB0byB0aGUg
Cng4NiBORSBvbmUgZm9yIGFybSBiYXNlZCBvbiAtTSB2aXJ0IGFzIGEgZm9sbG93LXVwIGFuZCBi
eSBtYWtpbmcgdGhlIEVJRiAKbG9naWMgeDg2IG9ubHkgd2UncmUgb25seSBtYWtpbmcgb3VyIGxp
dmVzIGhhcmRlciBmb3IgdGhhdCBmdXR1cmUuCgoKQWxleAoKCgoKQW1hem9uIFdlYiBTZXJ2aWNl
cyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJl
cmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdl
aXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAy
NTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


