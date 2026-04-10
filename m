Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F01F459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEbo-00085V-9c; Fri, 10 Apr 2026 12:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stepan.Popov@kaspersky.com>)
 id 1wBEba-00084I-64; Fri, 10 Apr 2026 12:21:24 -0400
Received: from mx9.kaspersky-labs.com ([195.122.169.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stepan.Popov@kaspersky.com>)
 id 1wBEbU-0003hF-Uj; Fri, 10 Apr 2026 12:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1775838056;
 bh=vX0FuAyL7+EYBtenR9PVe6o9OLI3BOOo+1olY2h6iqc=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 b=JjFFk3d1KZ67T8JPUmCt/U+oA0vV/DCpb9haovJo3+rjQMWppP25PKOQeaSwwlUe4
 S+3frLiYhbCZrJLSceRzJpXnDkx5B4u9qffHBISfvXGDxVGumr4IFVv7FyWx+TsH55
 X2yHhk4rvBkA31UP26pvMTmQJg4I1ogf/k4wk+gPeyQazbUHjbQNBuzeDBe7iK4i8B
 vb2H+mAjgZB7a6qI0t8jP8XT0EWdlp+LSfgpiOUSZrgqrnD0OBl1JMjtqAO8+cEc7g
 BQM84IUJNXw6ie4cH7HLbd0WN6mDbcYEo7mYjSB9WgaS8uL/ckPPZ1O+42qxmv4k0H
 FheMHypA+VS1w==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
 by relay9.kaspersky-labs.com (Postfix) with ESMTP id 679728A09CD;
 Fri, 10 Apr 2026 19:20:56 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id 02A348A0926;
 Fri, 10 Apr 2026 19:20:56 +0300 (MSK)
Received: from HQMAILSRV1.avp.ru (10.64.57.51) by HQMAILSRV5.avp.ru
 (10.64.57.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Apr
 2026 19:20:55 +0300
Received: from HQMAILSRV1.avp.ru ([fe80::44b0:5a05:5379:9408]) by
 HQMAILSRV1.avp.ru ([fe80::44b0:5a05:5379:9408%2]) with mapi id
 15.02.2562.037; Fri, 10 Apr 2026 19:20:55 +0300
From: Stepan Popov <Stepan.Popov@kaspersky.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH] thread-pool: signal condition variable while holding lock
Thread-Topic: [PATCH] thread-pool: signal condition variable while holding lock
Thread-Index: AQHcwEVK1KD1gN9aGUCOqvZG/Ut9mbXHEwYAgBFyemA=
Date: Fri, 10 Apr 2026 16:20:55 +0000
Message-ID: <a8d3b3528c1f4cdda076dc6fa0fe8a34@kaspersky.com>
References: <20260330130104.85200-1-Stepan.Popov@kaspersky.com>
 <72de7dbb-ba81-4a59-9710-7e88707de31c@redhat.com>
In-Reply-To: <72de7dbb-ba81-4a59-9710-7e88707de31c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.16.90.37]
x-kse-serverinfo: HQMAILSRV5.avp.ru, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 4/10/2026 2:36:00 PM
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected, bases: 2026/04/10 16:05:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2026/04/10 14:35:00 #28384064
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/04/10 16:05:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
Received-SPF: pass client-ip=195.122.169.44;
 envelope-from=Stepan.Popov@kaspersky.com; helo=mx9.kaspersky-labs.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IE9uIDMvMzAvMjYg
MTU6MDEsIFN0ZXBhbiBQb3BvdiB3cm90ZToNCj4gPiBNb3ZlIHFlbXVfY29uZF9zaWduYWwoKSBp
bnNpZGUgdGhlIGNyaXRpY2FsIHNlY3Rpb24gcHJvdGVjdGVkIGJ5IHBvb2wtPmxvY2suDQo+ID4g
U2lnbmFsaW5nIHdoaWxlIGhvbGRpbmcgdGhlIGxvY2sgaW1wb3NlcyBtb3JlIHByZWRpY3RhYmxl
IHNjaGVkdWxpbmcgYmVoYXZpb3IuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVwYW4gUG9w
b3YgPFN0ZXBhbi5Qb3BvdkBrYXNwZXJza3kuY29tPg0KPiA+IC0tLQ0KPiA+ICAgdXRpbC90aHJl
YWQtcG9vbC5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdXRpbC90aHJlYWQtcG9vbC5jIGIv
dXRpbC90aHJlYWQtcG9vbC5jIGluZGV4IA0KPiA+IDhmOGNiMzhkNWMuLjhlNTVhZWZkMDcgMTAw
NjQ0DQo+ID4gLS0tIGEvdXRpbC90aHJlYWQtcG9vbC5jDQo+ID4gKysrIGIvdXRpbC90aHJlYWQt
cG9vbC5jDQo+ID4gQEAgLTI2NSw4ICsyNjUsOCBAQCBCbG9ja0FJT0NCICp0aHJlYWRfcG9vbF9z
dWJtaXRfYWlvKFRocmVhZFBvb2xGdW5jICpmdW5jLCB2b2lkICphcmcsDQo+ID4gICAgICAgICAg
IHNwYXduX3RocmVhZChwb29sKTsNCj4gPiAgICAgICB9DQo+ID4gICAgICAgUVRBSUxRX0lOU0VS
VF9UQUlMKCZwb29sLT5yZXF1ZXN0X2xpc3QsIHJlcSwgcmVxcyk7DQo+ID4gLSAgICBxZW11X211
dGV4X3VubG9jaygmcG9vbC0+bG9jayk7DQo+ID4gICAgICAgcWVtdV9jb25kX3NpZ25hbCgmcG9v
bC0+cmVxdWVzdF9jb25kKTsNCj4gPiArICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZwb29sLT5sb2Nr
KTsNCj4gPiAgICAgICByZXR1cm4gJnJlcS0+Y29tbW9uOw0KPiA+ICAgfQ0KPg0KPiBJbiB0aGlz
IGNvZGUsIGluIHRoZSBwYXN0IGV2ZW4gdmVyeSBzbWFsbCBjaGFuZ2VzIGhhZCBiaWcgaW1wYWN0
IG9uIA0KPiBwZXJmb3JtYW5jZS4gIFNvLCB3aXRob3V0IHNvbWUgbWVhc3VyZW1lbnQgSSBhbSB3
YXJ5IG9mIHRha2luZyB0aGlzIGNoYW5nZS4NCj4NCj4gV2hhdCBpcyAibW9yZSBwcmVkaWN0YWJs
ZSBzY2hlZHVsaW5nIGJlaGF2aW9yIiBpcyB1bmNsZWFyLCB0b28uICBJZiANCj4gdGhlYWRfcG9v
bF9zdWJtaXRfYWlvKCkgaXMgcHJlZW1wdGVkIGJldHdlZW4gcWVtdV9jb25kX3NpZ25hbCgpIGFu
ZCANCj4gcWVtdV9tdXRleF91bmxvY2soKSwgdGhlbiBub3Qgb25seSB0aGUgd2FpdGluZyB0aHJl
YWQgY2Fubm90IHN0YXJ0IHRoZSANCj4gd29yaywgYnV0IHRoZSBtdXRleCBpcyB0YWtlbiBhbmQg
bm8gb25lIGVsc2UgY2FuIHN1Ym1pdCBvdGhlciByZXF1ZXN0cy4NCg0KVGhhbmsgeW91IGZvciB5
b3VyIGZlZWRiYWNrLiBJIHVuZGVyc3RhbmQgeW91ciBjb25jZXJuIGFib3V0IHBlcmZvcm1hbmNl
Lg0KDQpUbyBleHBsYWluIHRoZSBtb3RpdmF0aW9uOiB3ZSBoYXZlIHNlZW4gcmVwZXRpdGl2ZSBk
ZWFkbG9ja3MgaW4gcHJvZHVjdGlvbiBhZnRlciBydW5uaW5nIHFlbXUtaW1nIGluZm8gLS1vdXRw
dXQ9anNvbiBpbWFnZS5xY293LiANClN1Ym1pdHRlciBpcyBzdHVjayBpbiBwdGhyZWFkX2NvbmRf
c2lnbmFsICh0cnlpbmcgdG8gX19jb25kdmFyX3F1aWVzY2VfYW5kX3N3aXRjaF9nMSkgYW5kIHdh
aXRlciBpbiBfX3B0aHJlYWRfY29uZF93YWl0X2NvbW1vbiAodHJ5aW5nIHRvIF9fY29uZHZhcl9j
YW5jZWxfd2FpdGluZykuIA0KT3VyIGdsaWJjIHZlcnNpb24gaGFzIGEga25vd24gYnVnIGxlYWRp
bmcgdG8gZGVhZGxvY2sgKFVidW50dSBHTElCQyAyLjM1LTB1YnVudHUzLjEzKToNCmh0dHBzOi8v
c291cmNld2FyZS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTI1ODQ3IChwdGhyZWFkX2Nv
bmRfc2lnbmFsIGZhaWxlZCB0byB3YWtlIHVwIGR1ZSB0byBhIGJ1ZyBpbiB1bmRvaW5nIHN0ZWFs
aW5nKS4NCg0KV2UgYXJlIG5vdCBzdXJlIGlmIHRoaXMgY2hhbmdlIHdpbGwgZml4IGl0LCANCmJ1
dCBob2xkaW5nIHRoZSBtdXRleCB3aGlsZSBzaWduYWxpbmcgaXMgcHJlZmVycmVkIGZvciBwcmVk
aWN0YWJsZSBzY2hlZHVsaW5nIGJlaGF2aW91ciwgDQphcyBzdGF0ZWQgaW4gdGhlIHB0aHJlYWQg
bWFuIHBhZ2UgKGh0dHBzOi8vbGludXguZGllLm5ldC9tYW4vMy9wdGhyZWFkX2NvbmRfc2lnbmFs
KS4gDQpUaGVvcmV0aWNhbGx5LCBpdCBjb3VsZCBoZWxwIHdpdGggc2ltaWxhciBwcm9ibGVtcy4N
Cg0KVG8gbW92ZSBmb3J3YXJkLCBjb3VsZCB5b3Ugc3VnZ2VzdCBhIHNldCBvZiBiZW5jaG1hcmtz
IHRoYXQgd291bGQgYmUgc2Vuc2l0aXZlIHRvIHRoaXMgY2hhbmdlPyANCk1heWJlIHRoZXJlIGFy
ZSBleGlzdGluZyBzY3JpcHRzIG9yIHRvb2xzIHRoYXQgeW91IHdvdWxkIHJlY29tbWVuZCBydW5u
aW5nPyANCldoaWNoIFFFTVUgdXNlIGNhc2VzIChibG9jayBJL08sIHZpcnRpby1zY3NpLCBmaWxl
LWJhY2tlZCBkaXNrcywgZXRjLikgaGF2ZSBoaXN0b3JpY2FsbHkgc2hvd24gcGVyZm9ybWFuY2Ug
Y2hhbmdlcyB3aXRoIHNpbWlsYXIgY2hhbmdlcz8NCg0KVGhhbmsgeW91IGFnYWluLg0KDQpCZXN0
IHJlZ2FyZHMsDQpTdGVwYW4NCg0K

