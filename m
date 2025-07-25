Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD66C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 02:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7sU-0005Ei-Jv; Thu, 24 Jul 2025 22:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1uf7rz-0004Kp-BA; Thu, 24 Jul 2025 22:09:12 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1uf7ru-0002Us-9c; Thu, 24 Jul 2025 22:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
 MIME-Version; bh=BeOyYMZK3vF3A36IALcn58yWpRIK9tgxHRU/4T7Up0E=;
 b=Mh5AkzCukuhtZMqCccK6jzRVo76I2NaziqxtnDTqEtXZPJM8xGQstf/GBx+Vkp
 +gNQ9ZYoU9WV5U15yDWQbKJr71aLMWubupICsC85BwjBQWed6MDnSVAMpe9zbQXd
 5YzSgTj86d41LPFLxePYAmOB+E8wTfcbYktuTNSHnPEvU=
Received: from OS3PR01MB7756.jpnprd01.prod.outlook.com (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgD39pAt54Jof1pXAQ--.50184S2;
 Fri, 25 Jul 2025 10:08:46 +0800 (CST)
From: "z_bajeer@yeah.net" <z_bajeer@yeah.net>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
CC: "yangjialong@rvcore.com" <yangjialong@rvcore.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIGludGMvcmlzY3ZfYXBsaWM6IEZpeCB0YXJn?=
 =?utf-8?Q?et_register_read_when_source_is_inactive?=
Thread-Topic: [PATCH v1] intc/riscv_aplic: Fix target register read when
 source is inactive
Thread-Index: AXJfMS4wACQBZRBl1eFvSrISyBaTozE1YzRk0bIEWpg=
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 25 Jul 2025 02:08:39 +0000
Message-ID: <OS3PR01MB77568C8FEA443592D17CED54F559A@OS3PR01MB7756.jpnprd01.prod.outlook.com>
References: <20250724093426.4179617-1-z_bajeer@yeah.net>
 <a779c4ed-913e-4886-a2c6-7d3b505077c1@ventanamicro.com>
In-Reply-To: <a779c4ed-913e-4886-a2c6-7d3b505077c1@ventanamicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CM-TRANSID: M88vCgD39pAt54Jof1pXAQ--.50184S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4xXr47Zr1kZw1kWr4Uurg_yoW8Zw1Upr
 s5GFZ8ArW5KF1kGa1xGr1UXFW8Grn8W3Z8ur1UZFy8CwsxJw4Ygryqgr909r1UGr48Cr1Y
 yF4UZr13ZF47ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8wIDUUUUU=
X-Originating-IP: [2603:1046:c0a:2099::5]
X-CM-SenderInfo: p2betyxhhuq5hhdkh0dhw/1tbiCQKVI2iC1jxAYAAAsd
Received-SPF: pass client-ip=220.197.32.18; envelope-from=z_bajeer@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PiBPbiA3LzI0LzI1IDY6MzQgQU0sIFlhbmcgSmlhbG9uZyB3cm90ZToKPiA+IFRoZSBSSVNDLVYg
QWR2YW5jZWQgaW50ZXJydXB0IEFyY2hpdGVjdHVyZToKPiA+IDQuNS4xNi4gSW50ZXJydXB0IHRh
cmdldHM6Cj4gPiBJZiBpbnRlcnJ1cHQgc291cmNlIGkgaXMgaW5hY3RpdmUgaW4gdGhpcyBkb21h
aW4sIHJlZ2lzdGVyIHRhcmdldFtpXSBpcwo+ID4gcmVhZC1vbmx5IHplcm8uCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IFlhbmcgSmlhbG9uZyA8el9iYWplZXJAeWVhaC5uZXQ+Cj4gPiAtLS0KPiA+
wqDCoCBody9pbnRjL3Jpc2N2X2FwbGljLmMgfCA2ICsrKysrLQo+ID7CoMKgIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBh
L2h3L2ludGMvcmlzY3ZfYXBsaWMuYyBiL2h3L2ludGMvcmlzY3ZfYXBsaWMuYwo+ID4gaW5kZXgg
NGZhNWY3NS4uY2ZlZjY5ZiAxMDA2NDQKPiA+IC0tLSBhL2h3L2ludGMvcmlzY3ZfYXBsaWMuYwo+
ID4gKysrIGIvaHcvaW50Yy9yaXNjdl9hcGxpYy5jCj4gPiBAQCAtNjI4LDcgKzYyOCw3IEBAIHN0
YXRpYyB2b2lkIHJpc2N2X2FwbGljX3JlcXVlc3Qodm9pZCAqb3BhcXVlLCBpbnQgaXJxLCBpbnQg
bGV2ZWwpCj4gPsKgwqAgCj4gPsKgwqAgc3RhdGljIHVpbnQ2NF90IHJpc2N2X2FwbGljX3JlYWQo
dm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdW5zaWduZWQgc2l6ZSkKPiA+wqDCoCB7Cj4gPiAt
wqDCoMKgIHVpbnQzMl90IGlycSwgd29yZCwgaWRjOwo+ID4gK8KgwqDCoCB1aW50MzJfdCBpcnEs
IHdvcmQsIGlkYywgc207Cj4gPsKgwqDCoMKgwqDCoCBSSVNDVkFQTElDU3RhdGUgKmFwbGljID0g
b3BhcXVlOwo+ID7CoMKgIAo+ID7CoMKgwqDCoMKgwqAgLyogUmVhZHMgbXVzdCBiZSA0IGJ5dGUg
d29yZHMgKi8KPiA+IEBAIC02OTYsNiArNjk2LDEwIEBAIHN0YXRpYyB1aW50NjRfdCByaXNjdl9h
cGxpY19yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVuc2lnbmVkIHNpemUpCj4gPsKg
wqDCoMKgwqDCoCB9IGVsc2UgaWYgKChBUExJQ19UQVJHRVRfQkFTRSA8PSBhZGRyKSAmJgo+ID7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChhZGRyIDwgKEFQTElDX1RBUkdFVF9CQVNFICsg
KGFwbGljLT5udW1faXJxcyAtIDEpICogNCkpKSB7Cj4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgIGly
cSA9ICgoYWRkciAtIEFQTElDX1RBUkdFVF9CQVNFKSA+PiAyKSArIDE7Cj4gPiArwqDCoMKgwqDC
oMKgwqAgc20gPSBhcGxpYy0+c291cmNlY2ZnW2lycV0gKiBBUExJQ19TT1VSQ0VDRkdfU01fTUFT
SzsKPiAKPiBJIGJlbGlldmUgeW91IHdhbnQgJyYnIGhlcmU6Cj4gCgouLi4gWWVzLiBUaGFua3Mu
IEkgd2lsbCBzdWJtaXQgYSBuZXdlciBvbmUuCgo+IAo+IHNtID0gYXBsaWMtPnNvdXJjZWNmZ1tp
cnFdICYgQVBMSUNfU09VUkNFQ0ZHX1NNX01BU0s7Cj4gCj4gT3RoZXJ3aXNlLCBnaXZlbiB0aGF0
IEFQTElDX1NPVVJDRUNGR19TTV9JTkFDVElWRSBpcyAweDAsIHRoZSBvbmx5IHdheQo+IAo+IHNt
ID09IEFQTElDX1NPVVJDRUNGR19TTV9JTkFDVElWRQo+IAo+IHdpbGwgaGFwcGVuIGlzIGFwbGlj
LT5zb3VyY2VjZmdbaXJxXSBiZWluZyAwLgo+IAo+IAo+IFRoYW5rcywKPiAKPiBEYW5pZWwKPiAK
PiA+ICvCoMKgwqDCoMKgwqDCoCBpZiAoc20gPT0gQVBMSUNfU09VUkNFQ0ZHX1NNX0lOQUNUSVZF
KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+ICvCoMKgwqDCoMKg
wqDCoCB9Cj4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBhcGxpYy0+dGFyZ2V0W2lycV07
Cj4gPsKgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKCFhcGxpYy0+bXNpbW9kZSAmJiAoQVBMSUNfSURD
X0JBU0UgPD0gYWRkcikgJiYKPiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoYWRkciA8
IChBUExJQ19JRENfQkFTRSArIGFwbGljLT5udW1faGFydHMgKiBBUExJQ19JRENfU0laRSkpKSB7
Cg==


