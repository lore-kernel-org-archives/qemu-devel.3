Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199C6C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 15:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4ma-0004A0-4q; Mon, 19 Aug 2024 11:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=954944eb4=graf@amazon.de>)
 id 1sg4mX-00049H-Nr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:58:57 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=954944eb4=graf@amazon.de>)
 id 1sg4mV-0005ct-67
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1724083136; x=1755619136;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IuY8N5ze9iM8+wa+G6OVMiRT1CobA7gQArX+d3qve/U=;
 b=AWHmJ7D6HPT52uz0XZ9Fy3HZhkksHuojlux95CsvydCQf8G89aZTfDim
 X70jTbMtS908q7WPa9DRqOTi13FPxe6yGAFafBdSF+B9kAQwQEPG1bY6o
 SYZDi2b/DNt9NoVNMGVih2Q48KQ5Jd++kEyp8CUmPIeZboqNXc3hst2gb A=;
X-IronPort-AV: E=Sophos;i="6.10,159,1719878400"; d="scan'208";a="322248185"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-80007.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:58:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:55678]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.118:2525]
 with esmtp (Farcaster)
 id 56f92258-5f09-45d4-9df4-2e9d757aaa82; Mon, 19 Aug 2024 15:58:47 +0000 (UTC)
X-Farcaster-Flow-ID: 56f92258-5f09-45d4-9df4-2e9d757aaa82
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 15:58:43 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 19 Aug 2024
 15:58:40 +0000
Message-ID: <5a7cd886-0694-45ed-a0fc-6bf69c5ed97f@amazon.com>
Date: Mon, 19 Aug 2024 17:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
CC: <qemu-devel@nongnu.org>, <agraf@csgraf.de>, <stefanha@redhat.com>,
 <pbonzini@redhat.com>, <slp@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <berrange@redhat.com>, <philmd@linaro.org>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
 <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
 <CAFfO_h6eSmizJuSwRSQ1+gzeVBfmsmrLiN0mCXYuQFXGaJ4_Vw@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAFfO_h6eSmizJuSwRSQ1+gzeVBfmsmrLiN0mCXYuQFXGaJ4_Vw@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=99.78.197.218;
 envelope-from=prvs=954944eb4=graf@amazon.de; helo=smtp-fw-80007.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
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

Ck9uIDE5LjA4LjI0IDE3OjI4LCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IEhleSBBbGV4LAo+
Cj4gT24gTW9uLCBBdWcgMTksIDIwMjQgYXQgNDoxM+KAr1BNIEFsZXhhbmRlciBHcmFmIDxncmFm
QGFtYXpvbi5jb20+IHdyb3RlOgo+PiBIZXkgRG9yam95LAo+Pgo+PiBPbiAxOC4wOC4yNCAxMzo0
MiwgRG9yam95IENob3dkaHVyeSB3cm90ZToKPj4+IEFXUyBOaXRybyBFbmNsYXZlcyBoYXZlIGJ1
aWx0LWluIE5pdHJvIFNlY3VyZSBNb2R1bGUgKE5TTSkgZGV2aWNlIHdoaWNoCj4+PiBpcyB1c2Vk
IGZvciBzdHJpcHBlZCBkb3duIFRQTSBmdW5jdGlvbmFsaXR5IGxpa2UgYXR0ZXN0YXRpb24uIFRo
aXMgY29tbWl0Cj4+PiBhZGRzIHRoZSBidWlsdC1pbiBOU00gZGV2aWNlIGluIHRoZSBuaXRyby1l
bmNsYXZlIG1hY2hpbmUgdHlwZS4KPj4+Cj4+PiBJbiBOaXRybyBFbmNsYXZlcywgYWxsIHRoZSBQ
Q1JzIHN0YXJ0IGluIGEga25vd24gemVybyBzdGF0ZSBhbmQgdGhlIGZpcnN0Cj4+PiAxNiBQQ1Jz
IGFyZSBsb2NrZWQgZnJvbSBib290IGFuZCByZXNlcnZlZC4gVGhlIFBDUjAsIFBDUjEsIFBDUjIg
YW5kIFBDUjgKPj4+IGNvbnRhaW4gdGhlIFNIQTM4NCBoYXNoZXMgcmVsYXRlZCB0byB0aGUgRUlG
IGZpbGUgdXNlZCB0byBib290IHRoZQo+Pj4gVk0gZm9yIHZhbGlkYXRpb24uCj4+Pgo+Pj4gU29t
ZSBvcHRpb25hbCBuaXRyby1lbmNsYXZlIG1hY2hpbmUgb3B0aW9ucyBoYXZlIGJlZW4gYWRkZWQ6
Cj4+PiAgICAgICAtICdpZCc6IEVuY2xhdmUgaWRlbnRpZmllciwgcmVmbGVjdGVkIGluIHRoZSBt
b2R1bGUtaWQgb2YgdGhlIE5TTQo+Pj4gZGV2aWNlLiBJZiBub3QgcHJvdmlkZWQsIGEgZGVmYXVs
dCBpZCB3aWxsIGJlIHNldC4KPj4+ICAgICAgIC0gJ3BhcmVudC1yb2xlJzogUGFyZW50IGluc3Rh
bmNlIElBTSByb2xlIEFSTiwgcmVmbGVjdGVkIGluIFBDUjMKPj4+IG9mIHRoZSBOU00gZGV2aWNl
Lgo+Pj4gICAgICAgLSAncGFyZW50LWlkJzogUGFyZW50IGluc3RhbmNlIGlkZW50aWZpZXIsIHJl
ZmxlY3RlZCBpbiBQQ1I0IG9mIHRoZQo+Pj4gTlNNIGRldmljZS4KPj4+Cj4+PiBTaWduZWQtb2Zm
LWJ5OiBEb3Jqb3kgQ2hvd2RodXJ5IDxkb3Jqb3ljaHkxMTFAZ21haWwuY29tPgo+Pj4gLS0tCj4+
PiAgICBjcnlwdG8vbWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgICAyICstCj4+PiAgICBjcnlw
dG8veDUwOS11dGlscy5jICAgICAgICAgICAgIHwgIDczICsrKysrKysrKysrCj4+Cj4+IENhbiB5
b3UgcGxlYXNlIHB1dCB0aGlzIG5ldyBBUEkgaW50byBpdHMgb3duIHBhdGNoIGZpbGU/Cj4+Cj4+
Cj4+PiAgICBody9jb3JlL2VpZi5jICAgICAgICAgICAgICAgICAgIHwgMjI1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tCj4+PiAgICBody9jb3JlL2VpZi5oICAgICAgICAgICAgICAg
ICAgIHwgICA1ICstCj4+Cj4+IFRoZXNlIGNoYW5nZXMgdG8gZWlmLmMgc2hvdWxkIGlkZWFsbHkg
YWxyZWFkeSBiZSBwYXJ0IG9mIHRoZSBwYXRjaCB0aGF0Cj4+IGludHJvZHVjZXMgZWlmLmMgKHBh
dGNoIDEpLCBubz8gSW4gZmFjdCwgZG8geW91IHRoaW5rIHlvdSBjYW4gbWFrZSB0aGUKPj4gd2hv
bGUgZWlmIGxvZ2ljIGl0cyBvd24gcGF0Y2ggZmlsZT8KPj4KPiBHb29kIHBvaW50LiBJIGd1ZXNz
IGl0IHNob3VsZCBiZSBwb3NzaWJsZSBpZiBJIGhhdmUgdGhlIHZpcnRpby1uc20KPiBkZXZpY2Ug
Y29tbWl0IGZpcnN0IGFuZCB0aGVuIGFkZCB0aGUgbWFjaGluZS9uaXRyby1lbmNsYXZlIGNvbW1p
dCB3aXRoCj4gZnVsbCBzdXBwb3J0IHdpdGggdGhlIGRldmljZXMuIFRoYXQgd2lsbCBvZiBjb3Vy
c2UgbWFrZSB0aGUKPiBtYWNoaW5lL25pdHJvLWVuY2xhdmUgY29tbWl0IGxhcmdlci4gV2hhdCBk
byB5b3UgdGhpbms/CgoKQXMgbG9uZyBhcyBub3RoaW5nIGNvbXBpbGVzIHRoZSBjb2RlLCBpdCBj
YW4gcmVseSBvbiBub3QgeWV0IGltcGxlbWVudGVkIApmdW5jdGlvbnMuIFNvIGl0J3MgcGVyZmVj
dGx5IGxlZ2l0IHRvIGFkZCBhbGwgeW91ciBjb2RlIGluIGluZGl2aWR1YWwgCmNvbW1pdHMgYW5k
IHRoZW4gYXQgdGhlIGVuZCBhZGQgdGhlIG1lc29uLmJ1aWxkIGNoYW5nZSB0aGF0IGltcGxlbWVu
dHMgCnRoZSBjb25maWcgb3B0aW9uLiBIb3cgYWJvdXQgdGhlIG9yZGVyIGJlbG93PwoKKiBDcnlw
dG8gcGF0Y2ggZm9yIFNIQTM4NAoqIENyeXB0byBwYXRjaCBmb3IgeDUwOSBmaW5nZXJwcmludAoq
IE5TTSBkZXZpY2UgZW11bGF0aW9uIChpbmNsdWRpbmcgbGliY2JvciBjaGVjaywgaW50cm9kdWNl
cyAKQ09ORklHX1ZJUlRJT19OU00pCiogRUlGIGZvcm1hdCBwYXJzaW5nIChub3QgY29tcGlsZWQg
eWV0KQoqIE5pdHJvIEVuY2xhdmVzIG1hY2hpbmUgKGludHJvZHVjZXMgQ09ORklHX05JVFJPX0VO
Q0xBVkUpCiogTml0cm8gRW5jbGF2ZXMgZG9jcwoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2Vydmlj
ZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBC
ZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBX
ZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIg
MjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


