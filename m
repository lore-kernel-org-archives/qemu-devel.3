Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE4EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdVSb-0007Ga-4P; Mon, 12 Aug 2024 09:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9472a1eb8=graf@amazon.de>)
 id 1sdVSZ-0007G3-EI
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:51:43 -0400
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9472a1eb8=graf@amazon.de>)
 id 1sdVSW-0002Ai-CY
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1723470700; x=1755006700;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dhQsCU+DGh/kxuRruU1j1xoqfMfd5RCJ5mbufIdtIE0=;
 b=gd2gU5tqSc3tvpllUmr1cGseEdupXvXENlWwGaIhZcMavcwdjseMw9Of
 J4UbVBV9j9BkdNMzT+Q5Y22xZ81ZQAFqBZgXB+vTG+rpNSA8INEQHWPU9
 7nZ9DIM7+7HO25u/9frDx0V0pLDOVBOiw8s+Hj6Qcl51RXrPpnQmeWsdH M=;
X-IronPort-AV: E=Sophos;i="6.09,283,1716249600"; d="scan'208";a="749321995"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 13:51:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:45700]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.195:2525]
 with esmtp (Farcaster)
 id b629b401-5581-4720-b127-a2cfe94a0c10; Mon, 12 Aug 2024 13:51:29 +0000 (UTC)
X-Farcaster-Flow-ID: b629b401-5581-4720-b127-a2cfe94a0c10
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 13:51:27 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 12 Aug 2024
 13:51:24 +0000
Message-ID: <974b7b36-bfd9-40e6-bbe1-d3feb3d46797@amazon.com>
Date: Mon, 12 Aug 2024 15:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <agraf@csgraf.de>, <stefanha@redhat.com>, <pbonzini@redhat.com>,
 <slp@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>,
 <philmd@linaro.org>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-5-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240810164502.19693-5-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.188.206;
 envelope-from=prvs=9472a1eb8=graf@amazon.de; helo=smtp-fw-9106.amazon.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ck9uIDEwLjA4LjI0IDE4OjQ1LCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IEFXUyBOaXRybyBF
bmNsYXZlcyBoYXZlIGJ1aWx0LWluIE5pdHJvIFNlY3VyZSBNb2R1bGUgKE5TTSkgZGV2aWNlIHdo
aWNoCj4gaXMgdXNlZCBmb3Igc3RyaXBwZWQgZG93biBUUE0gZnVuY3Rpb25hbGl0eSBsaWtlIGF0
dGVzdGF0aW9uLiBUaGlzIGNvbW1pdAo+IGFkZHMgdGhlIGJ1aWx0LWluIE5TTSBkZXZpY2UgaW4g
dGhlIG5pdHJvLWVuY2xhdmUgbWFjaGluZSB0eXBlLgo+Cj4gSW4gTml0cm8gRW5jbGF2ZXMsIGFs
bCB0aGUgUENScyBzdGFydCBpbiBhIGtub3duIHplcm8gc3RhdGUgYW5kIHRoZSBmaXJzdAo+IDE2
IFBDUnMgYXJlIGxvY2tlZCBmcm9tIGJvb3QgYW5kIHJlc2VydmVkLiBUaGUgUENSMCwgUENSMSwg
UENSMiBhbmQgUENSOAo+IGNvbnRhaW4gdGhlIFNIQTM4NCBoYXNoZXMgcmVsYXRlZCB0byB0aGUg
RUlGIGZpbGUgdXNlZCB0byBib290IHRoZQo+IFZNIGZvciB2YWxpZGF0aW9uLgo+Cj4gQSBuZXcg
b3B0aW9uYWwgbml0cm8tZW5jbGF2ZSBtYWNoaW5lIG9wdGlvbiAnaWQnIGhhcyBiZWVuIGFkZGVk
IHdoaWNoIHdpbGwKPiBiZSB0aGUgZW5jbGF2ZSBpZGVudGlmaWVyIHJlZmxlY3RlZCBpbiB0aGUg
bW9kdWxlLWlkIG9mIHRoZSBOU00gZGV2aWNlLgo+IE90aGVyd2lzZSwgdGhlIGRldmljZSB3aWxs
IGhhdmUgYSBkZWZhdWx0IGlkIHNldC4KPgo+IFNpZ25lZC1vZmYtYnk6IERvcmpveSBDaG93ZGh1
cnkgPGRvcmpveWNoeTExMUBnbWFpbC5jb20+Cj4gLS0tCj4gICBody9jb3JlL2VpZi5jICAgICAg
ICAgICAgICAgICAgIHwgMjA1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICBo
dy9jb3JlL2VpZi5oICAgICAgICAgICAgICAgICAgIHwgICA1ICstCj4gICBody9jb3JlL21lc29u
LmJ1aWxkICAgICAgICAgICAgIHwgICA0ICstCj4gICBody9pMzg2L0tjb25maWcgICAgICAgICAg
ICAgICAgIHwgICAxICsKPiAgIGh3L2kzODYvbml0cm9fZW5jbGF2ZS5jICAgICAgICAgfCAgODUg
KysrKysrKysrKysrLQo+ICAgaW5jbHVkZS9ody9pMzg2L25pdHJvX2VuY2xhdmUuaCB8ICAxOSAr
KysKPiAgIDYgZmlsZXMgY2hhbmdlZCwgMzEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0p
Cj4KClsuLi5dCgoKPiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9tZXNvbi5idWlsZCBiL2h3L2NvcmUv
bWVzb24uYnVpbGQKPiBpbmRleCBmMzJkMWFkOTQzLi43ZTdhMTRlZTAwIDEwMDY0NAo+IC0tLSBh
L2h3L2NvcmUvbWVzb24uYnVpbGQKPiArKysgYi9ody9jb3JlL21lc29uLmJ1aWxkCj4gQEAgLTEy
LDYgKzEyLDggQEAgaHdjb3JlX3NzLmFkZChmaWxlcygKPiAgICAgJ3FkZXYtY2xvY2suYycsCj4g
ICApKQo+Cj4gK2xpYmNib3IgPSBkZXBlbmRlbmN5KCdsaWJjYm9yJywgdmVyc2lvbjogJz49MC44
LjAnKQo+ICsKPiAgIGNvbW1vbl9zcy5hZGQoZmlsZXMoJ2NwdS1jb21tb24uYycpKQo+ICAgY29t
bW9uX3NzLmFkZChmaWxlcygnbWFjaGluZS1zbXAuYycpKQo+ICAgc3lzdGVtX3NzLmFkZCh3aGVu
OiAnQ09ORklHX0ZJVExPQURFUicsIGlmX3RydWU6IGZpbGVzKCdsb2FkZXItZml0LmMnKSkKPiBA
QCAtMjQsNyArMjYsNyBAQCBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfUkVHSVNURVInLCBp
Zl90cnVlOiBmaWxlcygncmVnaXN0ZXIuYycpKQo+ICAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09O
RklHX1NQTElUX0lSUScsIGlmX3RydWU6IGZpbGVzKCdzcGxpdC1pcnEuYycpKQo+ICAgc3lzdGVt
X3NzLmFkZCh3aGVuOiAnQ09ORklHX1hJTElOWF9BWEknLCBpZl90cnVlOiBmaWxlcygnc3RyZWFt
LmMnKSkKPiAgIHN5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19QTEFURk9STV9CVVMnLCBpZl90
cnVlOiBmaWxlcygnc3lzYnVzLWZkdC5jJykpCj4gLXN5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJ
R19OSVRST19FTkNMQVZFJywgaWZfdHJ1ZTogW2ZpbGVzKCdlaWYuYycpLCB6bGliXSkKPiArc3lz
dGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX05JVFJPX0VOQ0xBVkUnLCBpZl90cnVlOiBbZmlsZXMo
J2VpZi5jJyksIHpsaWIsIGxpYmNib3IsIGdudXRsc10pCgoKSSB0aGluayB0aGlzIGlzIG1pc3Np
bmcgYSBkZXBlbmRlbmN5IGNoZWNrIHNvbWV3aGVyZToKCi4uL2h3L2NvcmUvZWlmLmM6MTY6MTA6
IGZhdGFsIGVycm9yOiBnbnV0bHMvZ251dGxzLmg6IE5vIHN1Y2ggZmlsZSBvciAKZGlyZWN0b3J5
CiDCoMKgIDE2IHwgI2luY2x1ZGUgPGdudXRscy9nbnV0bHMuaD4KIMKgwqDCoMKgwqAgfMKgwqDC
oMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+fgoKSXQncyBhbHNvIHRoZSBmaXJzdCB0aW1l
IGFueXRoaW5nIGFjY2Vzc2VzIGdudXRscyBkaXJlY3RseSBpbnN0ZWFkIG9mIAp0aHJvdWdoIHRo
ZSBRRU1VIGNyeXB0byBmcmFtZXdvcmsuIElzIHRoZXJlIGEgcGFydGljdWxhciByZWFzb24geW91
IGNhbiAKbm90IHVzZSBxY3J5cHRvPwoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2
ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4K
R2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpF
aW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0
IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


