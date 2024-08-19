Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37540C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 09:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfyTm-00028h-VR; Mon, 19 Aug 2024 05:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=954944eb4=graf@amazon.de>)
 id 1sfyTl-00028D-Bv
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:15:09 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=954944eb4=graf@amazon.de>)
 id 1sfyTj-0003g1-AQ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1724058907; x=1755594907;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ac4XxlNOiNdqMjF4A6zZFYnRRYM2pVz/xNCVNc4QQcw=;
 b=QhAr6iI7AWeo2K7zXEY7hfW7Gb9TnKxzz8rcF0Z8nXhmvUbDjeh4btxJ
 JSU3D9lL8bwy638gk34mfON06tTaZ5Prwz8LDZHEKkIUd+yen4dp9L7xo
 gdQUkALRiqoLCu9a/FdSObjoew0MtP6riN8PH+EblE1jquAAHFzOoorZg 8=;
X-IronPort-AV: E=Sophos;i="6.10,158,1719878400"; d="scan'208";a="427652735"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 09:15:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:50242]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.153:2525]
 with esmtp (Farcaster)
 id c17c806e-febf-4a04-82b7-6af7ea62ce23; Mon, 19 Aug 2024 09:15:01 +0000 (UTC)
X-Farcaster-Flow-ID: c17c806e-febf-4a04-82b7-6af7ea62ce23
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 09:15:01 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 19 Aug 2024
 09:14:58 +0000
Message-ID: <6668cd68-ff37-4f92-85bb-73852b4ef260@amazon.com>
Date: Mon, 19 Aug 2024 11:14:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] device/virtio-nsm: Support for Nitro Secure Module
 device
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <agraf@csgraf.de>, <stefanha@redhat.com>, <pbonzini@redhat.com>,
 <slp@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>,
 <philmd@linaro.org>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-4-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240818114257.21456-4-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=954944eb4=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Ck9uIDE4LjA4LjI0IDEzOjQyLCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IE5pdHJvIFNlY3Vy
ZSBNb2R1bGUgKE5TTSlbMV0gZGV2aWNlIGlzIHVzZWQgaW4gQVdTIE5pdHJvIEVuY2xhdmVzIGZv
cgo+IHN0cmlwcGVkIGRvd24gVFBNIGZ1bmN0aW9uYWxpdHkgbGlrZSBjcnlwdG9ncmFwaGljIGF0
dGVzdGF0aW9uLiBUaGUKPiByZXF1ZXN0cyB0byBhbmQgcmVzcG9uc2VzIGZyb20gTlNNIGRldmlj
ZSBhcmUgQ0JPUlsyXSBlbmNvZGVkLgo+Cj4gVGhpcyBjb21taXQgYWRkcyBzdXBwb3J0IGZvciBO
U00gZGV2aWNlIGluIFFFTVUuIEFsdGhvdWdoIHJlbGF0ZWQgdG8KPiBBV1MgTml0cm8gRW5jbGF2
ZXMsIHRoZSB2aXJpdG8tbnNtIGRldmljZSBpcyBpbmRlcGVuZGVudCBhbmQgY2FuIGJlCj4gdXNl
ZCBpbiBvdGhlciBtYWNoaW5lIHR5cGVzIGFzIHdlbGwuIFRoZSBsaWJjYm9yWzNdIGxpYnJhcnkg
aGFzIGJlZW4KPiB1c2VkIGZvciB0aGUgQ0JPUiBlbmNvZGluZyBhbmQgZGVjb2RpbmcgZnVuY3Rp
b25hbGl0aWVzLgo+Cj4gWzFdIGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMv
dmlydGlvLWNvbW1lbnQvMjAyMzEwL21zZzAwMzg3Lmh0bWwKPiBbMl0gaHR0cDovL2Nib3IuaW8v
Cj4gWzNdIGh0dHBzOi8vbGliY2Jvci5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBEb3Jqb3kgQ2hvd2RodXJ5IDxkb3Jqb3ljaHkxMTFAZ21haWwuY29tPgoKClsu
Li5dCgoKPiArc3RhdGljIGJvb2wgYWRkX3BheWxvYWRfdG9fY29zZShjYm9yX2l0ZW1fdCAqY29z
ZSwgVmlydElPTlNNICp2bnNtKQo+ICt7Cj4gKyAgICBjYm9yX2l0ZW1fdCAqcm9vdCA9IE5VTEw7
Cj4gKyAgICBjYm9yX2l0ZW1fdCAqbmVzdGVkX21hcDsKPiArICAgIGNib3JfaXRlbV90ICpicyA9
IE5VTEw7Cj4gKyAgICBzaXplX3QgbG9ja2VkX2NudDsKPiArICAgIHVpbnQ4X3QgaW5kW05TTV9N
QVhfUENSU107Cj4gKyAgICBzaXplX3QgcGF5bG9hZF9tYXBfc2l6ZSA9IDY7Cj4gKyAgICBzaXpl
X3QgbGVuOwo+ICsgICAgc3RydWN0IFBDUkluZm8gKnBjcjsKPiArICAgIHVpbnQ4X3QgemVyb1s2
NF0gPSB7MH07Cj4gKyAgICBib29sIHIgPSBmYWxzZTsKPiArICAgIHNpemVfdCBidWZfbGVuID0g
MTYzODQ7Cj4gKyAgICB1aW50OF90ICpidWYgPSBnX21hbGxvYyhidWZfbGVuKTsKPiArCj4gKyAg
ICBpZiAodm5zbS0+cHVibGljX2tleV9sZW4gPiAwKSB7Cj4gKyAgICAgICAgcGF5bG9hZF9tYXBf
c2l6ZSsrOwo+ICsgICAgfQo+ICsgICAgaWYgKHZuc20tPnVzZXJfZGF0YV9sZW4gPiAwKSB7Cj4g
KyAgICAgICAgcGF5bG9hZF9tYXBfc2l6ZSsrOwo+ICsgICAgfQo+ICsgICAgaWYgKHZuc20tPm5v
bmNlX2xlbiA+IDApIHsKPiArICAgICAgICBwYXlsb2FkX21hcF9zaXplKys7Cj4gKyAgICB9CgoK
Tm93IHRoYXQgeW91J3JlIGFsd2F5cyBlbWl0dGluZyB1c2VyX2RhdGEgYW5kIG5vbmNlLCB5b3Ug
c2hvdWxkIGluY2x1ZGUgCnRoZW0gaW4gcGF5bG9hZF9tYXBfc2l6ZSB1bmNvbmRpdGlvbmFsbHkg
YXMgd2VsbDsgb3RoZXJ3aXNlIHlvdXIgbWFwIGlzIAp0b28gc21hbGwgdG8gaG9sZCBhbGwgbWVt
YmVycy4KCkluIGFkZGl0aW9uLCBhIHJlYWwgTml0cm8gRW5jbGF2ZSBhdHRlc3RhdGlvbiBkb2N1
bWVudCB3aWxsIHJldHVybiBOdWxsIApvYmplY3RzIGZvciB0aGVzZSBmaWVsZHMgd2hlbiB0aGV5
J3JlIG5vdCBzZXQgaW5zdGVhZCBvZiBlbXB0eSBzdHJpbmdzLiAKV2l0aCB0aGUgcGF0Y2ggYmVs
b3cgSSB3YXMgYWJsZSB0byBnZW5lcmF0ZSBhIGRvYyB0aGF0IGxvb2tzIHZlcnkgCnNpbWlsYXIg
dG8gYSByZWFsIG9uZToKCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vY2Jvci1oZWxwZXJzLmMgYi9o
dy92aXJ0aW8vY2Jvci1oZWxwZXJzLmMKaW5kZXggNTE0MDAyMGQ0ZS4uZmZlY2M5N2M0OCAxMDA2
NDQKLS0tIGEvaHcvdmlydGlvL2Nib3ItaGVscGVycy5jCisrKyBiL2h3L3ZpcnRpby9jYm9yLWhl
bHBlcnMuYwpAQCAtMTQwLDcgKzE0MCwxMSBAQCBib29sIHFlbXVfY2Jvcl9hZGRfYnl0ZXN0cmlu
Z190b19tYXAoY2Jvcl9pdGVtX3QgCiptYXAsIGNvbnN0IGNoYXIgKmtleSwKIMKgwqDCoMKgIGlm
ICgha2V5X2Nib3IpIHsKIMKgwqDCoMKgwqDCoMKgwqAgZ290byBjbGVhbnVwOwogwqDCoMKgwqAg
fQotwqDCoMKgIHZhbHVlX2Nib3IgPSBjYm9yX2J1aWxkX2J5dGVzdHJpbmcoYXJyLCBsZW4pOwor
wqDCoMKgIGlmIChsZW4pIHsKK8KgwqDCoMKgwqDCoMKgIHZhbHVlX2Nib3IgPSBjYm9yX2J1aWxk
X2J5dGVzdHJpbmcoYXJyLCBsZW4pOworwqDCoMKgIH0gZWxzZSB7CivCoMKgwqDCoMKgwqDCoCB2
YWx1ZV9jYm9yID0gY2Jvcl9uZXdfbnVsbCgpOworwqDCoMKgIH0KIMKgwqDCoMKgIGlmICghdmFs
dWVfY2JvcikgewogwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXA7CiDCoMKgwqDCoCB9CkBA
IC0yNDEsNyArMjQ1LDExIEBAIGJvb2wgCnFlbXVfY2Jvcl9hZGRfdWludDhfa2V5X2J5dGVzdHJp
bmdfdG9fbWFwKGNib3JfaXRlbV90ICptYXAsIHVpbnQ4X3Qga2V5LAogwqDCoMKgwqAgaWYgKCFr
ZXlfY2JvcikgewogwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXA7CiDCoMKgwqDCoCB9Ci3C
oMKgwqAgdmFsdWVfY2JvciA9IGNib3JfYnVpbGRfYnl0ZXN0cmluZyhidWYsIGxlbik7CivCoMKg
wqAgaWYgKGxlbikgeworwqDCoMKgwqDCoMKgwqAgdmFsdWVfY2JvciA9IGNib3JfYnVpbGRfYnl0
ZXN0cmluZyhidWYsIGxlbik7CivCoMKgwqAgfSBlbHNlIHsKK8KgwqDCoMKgwqDCoMKgIHZhbHVl
X2Nib3IgPSBjYm9yX25ld19udWxsKCk7CivCoMKgwqAgfQogwqDCoMKgwqAgaWYgKCF2YWx1ZV9j
Ym9yKSB7CiDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gY2xlYW51cDsKIMKgwqDCoMKgIH0KZGlmZiAt
LWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8tbnNtLmMgYi9ody92aXJ0aW8vdmlydGlvLW5zbS5jCmlu
ZGV4IGU5MTg0OGEyYjAuLmI0NWQ5N2VmZTIgMTAwNjQ0Ci0tLSBhL2h3L3ZpcnRpby92aXJ0aW8t
bnNtLmMKKysrIGIvaHcvdmlydGlvL3ZpcnRpby1uc20uYwpAQCAtMTEyNiw3ICsxMTI2LDcgQEAg
c3RhdGljIGJvb2wgYWRkX3BheWxvYWRfdG9fY29zZShjYm9yX2l0ZW1fdCAqY29zZSwgClZpcnRJ
T05TTSAqdm5zbSkKIMKgwqDCoMKgIGNib3JfaXRlbV90ICpicyA9IE5VTEw7CiDCoMKgwqDCoCBz
aXplX3QgbG9ja2VkX2NudDsKIMKgwqDCoMKgIHVpbnQ4X3QgaW5kW05TTV9NQVhfUENSU107Ci3C
oMKgwqAgc2l6ZV90IHBheWxvYWRfbWFwX3NpemUgPSA2OworwqDCoMKgIHNpemVfdCBwYXlsb2Fk
X21hcF9zaXplID0gODsKIMKgwqDCoMKgIHNpemVfdCBsZW47CiDCoMKgwqDCoCBzdHJ1Y3QgUENS
SW5mbyAqcGNyOwogwqDCoMKgwqAgdWludDhfdCB6ZXJvWzY0XSA9IHswfTsKQEAgLTExMzcsMTIg
KzExMzcsNiBAQCBzdGF0aWMgYm9vbCBhZGRfcGF5bG9hZF90b19jb3NlKGNib3JfaXRlbV90IAoq
Y29zZSwgVmlydElPTlNNICp2bnNtKQogwqDCoMKgwqAgaWYgKHZuc20tPnB1YmxpY19rZXlfbGVu
ID4gMCkgewogwqDCoMKgwqDCoMKgwqDCoCBwYXlsb2FkX21hcF9zaXplKys7CiDCoMKgwqDCoCB9
Ci3CoMKgwqAgaWYgKHZuc20tPnVzZXJfZGF0YV9sZW4gPiAwKSB7Ci3CoMKgwqDCoMKgwqDCoCBw
YXlsb2FkX21hcF9zaXplKys7Ci3CoMKgwqAgfQotwqDCoMKgIGlmICh2bnNtLT5ub25jZV9sZW4g
PiAwKSB7Ci3CoMKgwqDCoMKgwqDCoCBwYXlsb2FkX21hcF9zaXplKys7Ci3CoMKgwqAgfQogwqDC
oMKgwqAgcm9vdCA9IGNib3JfbmV3X2RlZmluaXRlX21hcChwYXlsb2FkX21hcF9zaXplKTsKIMKg
wqDCoMKgIGlmICghcm9vdCkgewogwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXA7CgoKQWxl
eAoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJI
CktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlh
biBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENo
YXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAz
NjUgNTM4IDU5Nwo=


