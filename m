Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF428C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2949-0005lA-0V; Wed, 01 May 2024 08:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=844aeb351=jhnberg@amazon.co.uk>)
 id 1s2943-0005kl-3v; Wed, 01 May 2024 08:28:00 -0400
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=844aeb351=jhnberg@amazon.co.uk>)
 id 1s2940-00082I-8n; Wed, 01 May 2024 08:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
 s=amazon201209; t=1714566476; x=1746102476;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4reabUOU6qp/XfStGM/xgCY4F7KXDXg6vov4gt4REBE=;
 b=XDSIc0a0pSixuRN5A4VQmUH1qX31du69PIZbbKcZtEJFzSnQKr/CbS7p
 GeEiazW3hUr2tlU66va6JNSPOlsKSHpBzdoTBNA1Z6pOFHyUHNnbNYer3
 ebDyBsvoDORT/F1eJUsZmNaL8tKYkjB2U0WVfBHOcnOYcnr902LF0Fob6 I=;
X-IronPort-AV: E=Sophos;i="6.07,245,1708387200"; d="scan'208";a="655761309"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 12:27:50 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:27728]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.129:2525]
 with esmtp (Farcaster)
 id 340ef41a-e59a-4653-a0fb-80c9c4d3279c; Wed, 1 May 2024 12:27:49 +0000 (UTC)
X-Farcaster-Flow-ID: 340ef41a-e59a-4653-a0fb-80c9c4d3279c
Received: from EX19D047EUA001.ant.amazon.com (10.252.50.171) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 12:27:47 +0000
Received: from EX19D047EUA001.ant.amazon.com (10.252.50.171) by
 EX19D047EUA001.ant.amazon.com (10.252.50.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 12:27:47 +0000
Received: from EX19D047EUA001.ant.amazon.com ([fe80::5ca1:870f:8b12:d403]) by
 EX19D047EUA001.ant.amazon.com ([fe80::5ca1:870f:8b12:d403%3]) with
 mapi id 15.02.1258.028; Wed, 1 May 2024 12:27:47 +0000
From: "Berg, John" <jhnberg@amazon.co.uk>
To: "its@irrelevant.dk" <its@irrelevant.dk>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "Berg, John" <jhnberg@amazon.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Thread-Topic: [PATCH] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Thread-Index: AQHam8L5lsyiHqdllES5C4Srxbuf/Q==
Date: Wed, 1 May 2024 12:27:46 +0000
Message-ID: <cecde5a0e57f4551872969798049f29fe28b3fb6.camel@amazon.co.uk>
References: <20240404120418.1611513-1-jhnberg@amazon.co.uk>
 <Zg6kmPGVZOVhfDbo@cormorant.local>
In-Reply-To: <Zg6kmPGVZOVhfDbo@cormorant.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.82.14]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BC61C6672FF1E4D9FCA9B1914E29ABA@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=52.119.213.152;
 envelope-from=prvs=844aeb351=jhnberg@amazon.co.uk;
 helo=smtp-fw-52003.amazon.com
X-Spam_score_int: -127
X-Spam_score: -12.8
X-Spam_bar: ------------
X-Spam_report: (-12.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

T24gVGh1LCAyMDI0LTA0LTA0IGF0IDE1OjAxICswMjAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+
IE9uIEFwcsKgIDQgMTM6MDQsIEpvaG4gQmVyZyB3cm90ZToNCj4gPiBGcm9tOiBKb2huIEJlcmcg
PGpobmJlcmdAYW1hem9uLmNvbT4NCj4gPiANCj4gPiBUaGUgTVFFUyBmaWVsZCBpbiB0aGUgQ0FQ
IHJlZ2lzdGVyIGRlc2NyaWJlcyB0aGUgTWF4aW11bSBRdWV1ZQ0KPiA+IEVudHJpZXMNCj4gPiBT
dXBwb3J0ZWQgZm9yIHRoZSBJTyBxdWV1ZXMgb2YgYW4gTlZNZSBjb250cm9sbGVyLiBBZGRpbmcg
YSArMSB0bw0KPiA+IHRoZQ0KPiA+IHZhbHVlIGluIHRoaXMgZmllbGQgcmVzdWx0cyBpbiB0aGUg
dG90YWwgcXVldWUgc2l6ZS4gQSBmdWxsIHF1ZXVlDQo+ID4gaXMNCj4gPiB3aGVuIGEgcXVldWUg
b2Ygc2l6ZSBOIGNvbnRhaW5zIE4gLSAxIGVudHJpZXMsIGFuZCB0aGUgbWluaW11bQ0KPiA+IHF1
ZXVlDQo+ID4gc2l6ZSBpcyAyLiBUaHVzIHRoZSBsb3dlc3QgTVFFUyB2YWx1ZSBpcyAxLg0KPiA+
IA0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgbmV3IG1xZXMgcHJvcGVydHkgdG8gdGhlIE5WTWUg
ZW11bGF0aW9uIHdoaWNoDQo+ID4gYWxsb3dzDQo+ID4gYSB1c2VyIHRvIHNwZWNpZnkgdGhlIG1h
eGltdW0gcXVldWUgc2l6ZSBieSBzZXR0aW5nIHRoaXMgcHJvcGVydHkuDQo+ID4gVGhpcw0KPiA+
IGlzIHVzZWZ1bCBhcyBpdCBlbmFibGVzIHRlc3Rpbmcgb2YgTlZNZSBjb250cm9sbGVyIHdoZXJl
IHRoZSBNUUVTDQo+ID4gaXMNCj4gPiByZWxhdGl2ZWx5IHNtYWxsLiBUaGUgc21hbGxlc3QgTlZN
ZSBxdWV1ZSBzaXplIHN1cHBvcnRlZCBpbiBOVk1lIGlzDQo+ID4gMg0KPiA+IHN1Ym1pc3Npb24g
YW5kIGNvbXBsZXRpb24gZW50cmllcywgd2hpY2ggbWVhbnMgdGhhdCB0aGUgc21hbGxlc3QNCj4g
PiBsZWdhbA0KPiA+IG1xZXMgdmFsdWUgaXMgMS4NCj4gPiANCj4gPiBUaGUgZm9sbG93aW5nIGV4
YW1wbGUgc2hvd3MgaG93IHRoZSBtcWVzIGNhbiBiZSBzZXQgZm9yIGEgdGhlIE5WTWUNCj4gPiBl
bXVsYXRpb246DQo+ID4gDQo+ID4gLWRyaXZlIGlkPW52bWUwLGlmPW5vbmUsZmlsZT1udm1lLmlt
Zyxmb3JtYXQ9cmF3DQo+ID4gLWRldmljZSBudm1lLGRyaXZlPW52bWUwLHNlcmlhbD1mb28sbXFl
cz0xDQo+ID4gDQo+ID4gSWYgdGhlIG1xZXMgcHJvcGVydHkgaXMgbm90IHByb3ZpZGVkIHRoZW4g
dGhlIGRlZmF1bHQgbXFlcyB3aWxsDQo+ID4gc3RpbGwgYmUNCj4gPiAweDdmZiAodGhlIHF1ZXVl
IHNpemUgaXMgMjA0OCBlbnRyaWVzKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2huIEJl
cmcgPGpobmJlcmdAYW1hem9uLmNvLnVrPg0KPiA+IC0tLQ0KPiA+IMKgaHcvbnZtZS9jdHJsLmMg
fCA5ICsrKysrKysrLQ0KPiA+IMKgaHcvbnZtZS9udm1lLmggfCAxICsNCj4gPiDCoDIgZmlsZXMg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2h3L252bWUvY3RybC5jIGIvaHcvbnZtZS9jdHJsLmMNCj4gPiBpbmRleCAxMjdjM2Qy
MzgzLi44NmNkYTliYzczIDEwMDY0NA0KPiA+IC0tLSBhL2h3L252bWUvY3RybC5jDQo+ID4gKysr
IGIvaHcvbnZtZS9jdHJsLmMNCj4gPiBAQCAtNzgwNSw2ICs3ODA1LDEyIEBAIHN0YXRpYyBib29s
IG52bWVfY2hlY2tfcGFyYW1zKE52bWVDdHJsICpuLA0KPiA+IEVycm9yICoqZXJycCkNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsNCj4gPiDCoMKgwqDCoCB9DQo+ID4gwqANCj4g
PiArwqDCoMKgIGlmIChwYXJhbXMtPm1xZXMgPCAxKQ0KPiA+ICvCoMKgwqAgew0KPiANCj4gUGxl
YXNlIGtlZXAgdGhlIGB7YCBvbiB0aGUgc2FtZSBsaW5lIGFzIHRoZSBgaWZgLiBJIHRoaW5rDQo+
IGNoZWNrcGF0Y2gucGwNCj4gc2hvdWxkIGNhdGNoIHRoaXMuDQo+IA0KPiBObyBuZWVkIHRvIHNl
bmQgYSB2MiwgSSdsbCBmaXggaXQgdXAgd2hlbiBJIGFwcGx5IGl0IHRvIG52bWUtbmV4dCA6KQ0K
PiANCj4gVGhhbmtzIQ0KDQoNCkhlbGxvDQoNClNvcnJ5IGZvciBjaGFzaW5nLiBJIHdhcyBqdXN0
IHdvbmRlcmluZyB3aGVuIHRoaXMgcGF0Y2ggd2lsbCBiZQ0KYXBwbGllZC4gSSBjYW4gc2VuZCBh
IHNlY29uZCByZXZpc2lvbiBpZiB0aGF0IGhlbHBzLg0KDQpLaW5kIHJlZ2FyZHMsDQpKb2huDQo=

