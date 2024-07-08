Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144F9C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQr8f-00041K-Py; Mon, 08 Jul 2024 12:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9123e1945=jhnberg@amazon.co.uk>)
 id 1sQr8b-00040I-0w; Mon, 08 Jul 2024 12:22:49 -0400
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=9123e1945=jhnberg@amazon.co.uk>)
 id 1sQr8Y-00037d-Ve; Mon, 08 Jul 2024 12:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
 s=amazon201209; t=1720455767; x=1751991767;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=leM10Wlfof7CoViLmMaND13orUrH3iO66YXnfgjrIDM=;
 b=cScCgNPxvZAj/HuD2vyDbf/rG3qZyetWpMmEsRD3FB5Wjl1H9dUc66qV
 3pG6EqBxnMWEjZ+WiXTS/cMfEtNXAQi93VXUllX+GyJHe9Q7njCAyhM0p
 io1dm5NGcr0NCrSOXt1APN1GgLdF1g57MZ/Zk27CQnqo9LivnEZWlGHqf M=;
X-IronPort-AV: E=Sophos;i="6.09,192,1716249600"; d="scan'208";a="739032779"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9106.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 16:22:36 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:8623]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.19.28:2525]
 with esmtp (Farcaster)
 id eb3e4287-8986-482d-8c96-d0353291f69d; Mon, 8 Jul 2024 16:22:33 +0000 (UTC)
X-Farcaster-Flow-ID: eb3e4287-8986-482d-8c96-d0353291f69d
Received: from EX19D047EUA001.ant.amazon.com (10.252.50.171) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 16:22:33 +0000
Received: from EX19D047EUA001.ant.amazon.com (10.252.50.171) by
 EX19D047EUA001.ant.amazon.com (10.252.50.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 16:22:33 +0000
Received: from EX19D047EUA001.ant.amazon.com ([fe80::5ca1:870f:8b12:d403]) by
 EX19D047EUA001.ant.amazon.com ([fe80::5ca1:870f:8b12:d403%3]) with
 mapi id 15.02.1258.034; Mon, 8 Jul 2024 16:22:33 +0000
From: "Berg, John" <jhnberg@amazon.co.uk>
To: "its@irrelevant.dk" <its@irrelevant.dk>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Thread-Topic: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Thread-Index: AQHa0VMJPhwnWDfBHkSRh1g9otc/Wg==
Date: Mon, 8 Jul 2024 16:22:33 +0000
Message-ID: <5039ce9596dd8a15450525cc7219ba7d70b054c6.camel@amazon.co.uk>
References: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
 <Zg6kmPGVZOVhfDbo@cormorant.local>
 <cecde5a0e57f4551872969798049f29fe28b3fb6.camel@amazon.co.uk>
 <ZjI3AOEZ4GzFdKTg@cormorant.local>
In-Reply-To: <ZjI3AOEZ4GzFdKTg@cormorant.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.82.24]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EAEEE2C690B2D4F8A04E11CF6CA6684@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=207.171.188.206;
 envelope-from=prvs=9123e1945=jhnberg@amazon.co.uk;
 helo=smtp-fw-9106.amazon.com
X-Spam_score_int: -119
X-Spam_score: -12.0
X-Spam_bar: ------------
X-Spam_report: (-12.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

T24gV2VkLCAyMDI0LTA1LTAxIGF0IDE0OjM1ICswMjAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+
IE9uIE1hecKgIDEgMTI6MjcsIEJlcmcsIEpvaG4gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI0LTA0
LTA0IGF0IDE1OjAxICswMjAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+ID4gPiBPbiBBcHLCoCA0
IDEzOjA0LCBKb2huIEJlcmcgd3JvdGU6DQo+ID4gPiA+IEZyb206IEpvaG4gQmVyZyA8amhuYmVy
Z0BhbWF6b24uY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIE1RRVMgZmllbGQgaW4gdGhlIENB
UCByZWdpc3RlciBkZXNjcmliZXMgdGhlIE1heGltdW0gUXVldWUNCj4gPiA+ID4gRW50cmllcw0K
PiA+ID4gPiBTdXBwb3J0ZWQgZm9yIHRoZSBJTyBxdWV1ZXMgb2YgYW4gTlZNZSBjb250cm9sbGVy
LiBBZGRpbmcgYSArMQ0KPiA+ID4gPiB0bw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gdmFsdWUgaW4g
dGhpcyBmaWVsZCByZXN1bHRzIGluIHRoZSB0b3RhbCBxdWV1ZSBzaXplLiBBIGZ1bGwNCj4gPiA+
ID4gcXVldWUNCj4gPiA+ID4gaXMNCj4gPiA+ID4gd2hlbiBhIHF1ZXVlIG9mIHNpemUgTiBjb250
YWlucyBOIC0gMSBlbnRyaWVzLCBhbmQgdGhlIG1pbmltdW0NCj4gPiA+ID4gcXVldWUNCj4gPiA+
ID4gc2l6ZSBpcyAyLiBUaHVzIHRoZSBsb3dlc3QgTVFFUyB2YWx1ZSBpcyAxLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBuZXcgbXFlcyBwcm9wZXJ0eSB0byB0aGUgTlZN
ZSBlbXVsYXRpb24NCj4gPiA+ID4gd2hpY2gNCj4gPiA+ID4gYWxsb3dzDQo+ID4gPiA+IGEgdXNl
ciB0byBzcGVjaWZ5IHRoZSBtYXhpbXVtIHF1ZXVlIHNpemUgYnkgc2V0dGluZyB0aGlzDQo+ID4g
PiA+IHByb3BlcnR5Lg0KPiA+ID4gPiBUaGlzDQo+ID4gPiA+IGlzIHVzZWZ1bCBhcyBpdCBlbmFi
bGVzIHRlc3Rpbmcgb2YgTlZNZSBjb250cm9sbGVyIHdoZXJlIHRoZQ0KPiA+ID4gPiBNUUVTDQo+
ID4gPiA+IGlzDQo+ID4gPiA+IHJlbGF0aXZlbHkgc21hbGwuIFRoZSBzbWFsbGVzdCBOVk1lIHF1
ZXVlIHNpemUgc3VwcG9ydGVkIGluDQo+ID4gPiA+IE5WTWUgaXMNCj4gPiA+ID4gMg0KPiA+ID4g
PiBzdWJtaXNzaW9uIGFuZCBjb21wbGV0aW9uIGVudHJpZXMsIHdoaWNoIG1lYW5zIHRoYXQgdGhl
DQo+ID4gPiA+IHNtYWxsZXN0DQo+ID4gPiA+IGxlZ2FsDQo+ID4gPiA+IG1xZXMgdmFsdWUgaXMg
MS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBmb2xsb3dpbmcgZXhhbXBsZSBzaG93cyBob3cgdGhl
IG1xZXMgY2FuIGJlIHNldCBmb3IgYSB0aGUNCj4gPiA+ID4gTlZNZQ0KPiA+ID4gPiBlbXVsYXRp
b246DQo+ID4gPiA+IA0KPiA+ID4gPiAtZHJpdmUgaWQ9bnZtZTAsaWY9bm9uZSxmaWxlPW52bWUu
aW1nLGZvcm1hdD1yYXcNCj4gPiA+ID4gLWRldmljZSBudm1lLGRyaXZlPW52bWUwLHNlcmlhbD1m
b28sbXFlcz0xDQo+ID4gPiA+IA0KPiA+ID4gPiBJZiB0aGUgbXFlcyBwcm9wZXJ0eSBpcyBub3Qg
cHJvdmlkZWQgdGhlbiB0aGUgZGVmYXVsdCBtcWVzIHdpbGwNCj4gPiA+ID4gc3RpbGwgYmUNCj4g
PiA+ID4gMHg3ZmYgKHRoZSBxdWV1ZSBzaXplIGlzIDIwNDggZW50cmllcykuDQo+ID4gPiA+IA0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb2huIEJlcmcgPGpobmJlcmdAYW1hem9uLmNvLnVrPg0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBody9udm1lL2N0cmwuYyB8IDkgKysrKysrKystDQo+ID4g
PiA+IMKgaHcvbnZtZS9udm1lLmggfCAxICsNCj4gPiA+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2h3L252bWUvY3RybC5jIGIvaHcvbnZtZS9jdHJsLmMNCj4gPiA+ID4gaW5kZXggMTI3YzNk
MjM4My4uODZjZGE5YmM3MyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvaHcvbnZtZS9jdHJsLmMNCj4g
PiA+ID4gKysrIGIvaHcvbnZtZS9jdHJsLmMNCj4gPiA+ID4gQEAgLTc4MDUsNiArNzgwNSwxMiBA
QCBzdGF0aWMgYm9vbCBudm1lX2NoZWNrX3BhcmFtcyhOdm1lQ3RybA0KPiA+ID4gPiAqbiwNCj4g
PiA+ID4gRXJyb3IgKiplcnJwKQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxz
ZTsNCj4gPiA+ID4gwqDCoMKgwqAgfQ0KPiA+ID4gPiDCoA0KPiA+ID4gPiArwqDCoMKgIGlmIChw
YXJhbXMtPm1xZXMgPCAxKQ0KPiA+ID4gPiArwqDCoMKgIHsNCj4gPiA+IA0KPiA+ID4gUGxlYXNl
IGtlZXAgdGhlIGB7YCBvbiB0aGUgc2FtZSBsaW5lIGFzIHRoZSBgaWZgLiBJIHRoaW5rDQo+ID4g
PiBjaGVja3BhdGNoLnBsDQo+ID4gPiBzaG91bGQgY2F0Y2ggdGhpcy4NCj4gPiA+IA0KPiA+ID4g
Tm8gbmVlZCB0byBzZW5kIGEgdjIsIEknbGwgZml4IGl0IHVwIHdoZW4gSSBhcHBseSBpdCB0byBu
dm1lLW5leHQNCj4gPiA+IDopDQo+ID4gPiANCj4gPiA+IFRoYW5rcyENCj4gPiANCj4gPiANCj4g
PiBIZWxsbw0KPiA+IA0KPiA+IFNvcnJ5IGZvciBjaGFzaW5nLiBJIHdhcyBqdXN0IHdvbmRlcmlu
ZyB3aGVuIHRoaXMgcGF0Y2ggd2lsbCBiZQ0KPiA+IGFwcGxpZWQuIEkgY2FuIHNlbmQgYSBzZWNv
bmQgcmV2aXNpb24gaWYgdGhhdCBoZWxwcy4NCj4gPiANCj4gDQo+IE5vIG5lZWQgZm9yIHRoZSBz
b3JyeS4gTXkgYXBvbG9naWVzLiBJdCBmZWVsIG9mZiBteSByYWRhciwgc28gdGhhbmtzDQo+IGZv
cg0KPiB0aGUgYnVtcC4NCj4gDQo+IEkndmUgcXVldWVkIHRoaXMgb24gbnZtZS1uZXh0LCB3aWxs
IHNlbmQgYSBwdWxsIGZvciBtYXN0ZXIgQVNBUC4NCg0KSGVsbG8sIGp1c3QgY2hlY2tpbmcgaW4g
YWdhaW4uIFdpbGwgdGhpcyBiZSBtZXJnZWQgaW50byBtYXN0ZXIgc29vbj8NCg0K

