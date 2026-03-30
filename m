Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69AD1061B0F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ExX-0001kd-SB; Mon, 30 Mar 2026 11:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stepan.Popov@kaspersky.com>)
 id 1w7ExP-0001k2-AV; Mon, 30 Mar 2026 11:55:15 -0400
Received: from mx9.kaspersky-labs.com ([195.122.169.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stepan.Popov@kaspersky.com>)
 id 1w7ExK-00010t-49; Mon, 30 Mar 2026 11:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1774886106;
 bh=Sv/IVOFxxN/Y0ujCD6+bP+PpSS940V8xMPoJ/Lxz0PY=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 b=UoxKyj2owr5+JbYapyakR08G+0M4tyUPRuGF6h15BTOE26oR3vV5hnxo6/UR9doW0
 W6IhYg07Wy2UmrzI+Nat04deTTQzpT8CL15k6S/ZQFxPz3qeGpyZOTba5oiE5EbeA4
 sExEP7b941wLK/yLLyI3wnP/RWQ+nAQmdqmPygXHN1DmyU3d3wdEuBBMKeSrJzG0FE
 TGmiFfVYGds69YXuvn4LZMcwLafFfzxxG9zOoVaN9r9mQZIpj6JjabfFJ9ON7N/zcM
 b9T/miR8vKRKTK4T4MnKF/smX3UUNAyA6jLMhgHKQTxV5RLz/MSRNarfUJbv0+xYv0
 W2apKmxgUr0uw==
Received: from relay9.kaspersky-labs.com (localhost [127.0.0.1])
 by relay9.kaspersky-labs.com (Postfix) with ESMTP id 037598A057F;
 Mon, 30 Mar 2026 18:55:06 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub9.kaspersky-labs.com (Postfix) with ESMTPS id 9B56F8A091B;
 Mon, 30 Mar 2026 18:55:05 +0300 (MSK)
Received: from HQMAILSRV1.avp.ru (10.64.57.51) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 30 Mar
 2026 18:55:05 +0300
Received: from HQMAILSRV1.avp.ru ([fe80::44b0:5a05:5379:9408]) by
 HQMAILSRV1.avp.ru ([fe80::44b0:5a05:5379:9408%2]) with mapi id
 15.02.2562.037; Mon, 30 Mar 2026 18:55:04 +0300
From: Stepan Popov <Stepan.Popov@kaspersky.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH] thread-pool: signal condition variable while holding lock
Thread-Topic: [PATCH] thread-pool: signal condition variable while holding lock
Thread-Index: AQHcwEVK1KD1gN9aGUCOqvZG/Ut9mbXG43eAgABSvGA=
Date: Mon, 30 Mar 2026 15:55:04 +0000
Message-ID: <acf8cfea80f048218030fdde6bd0ceca@kaspersky.com>
References: <20260330130104.85200-1-Stepan.Popov@kaspersky.com>
 <acp97_c_brNSk7t4@redhat.com>
In-Reply-To: <acp97_c_brNSk7t4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.16.90.37]
x-kse-serverinfo: HQMAILSRV2.avp.ru, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/30/2026 2:16:00 PM
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected, bases: 2026/03/30 11:25:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2026/03/30 05:24:00 #28352470
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/03/30 11:25:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
Received-SPF: pass client-ip=195.122.169.44;
 envelope-from=Stepan.Popov@kaspersky.com; helo=mx9.kaspersky-labs.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

V2hlbiBwdGhyZWFkX2NvbmRfc2lnbmFsIHdha2VzIHRoZSB3YWl0ZXIsIHRoZSBrZXJuZWwgcmVx
dWV1ZXMgdGhlIHdhaXRlciBkaXJlY3RseSBvbnRvIHRoZSBtdXRleCdzIFBJIGZ1dGV4IGFuZCB0
cmFuc2ZlcnMgdGhlIGxvY2sgb3duZXJzaGlwIGF0b21pY2FsbHkuIFNvIHRoZSB3YWl0ZXIgcmV0
dXJucyBmcm9tIHRoZSBzeXNjYWxsIGFscmVhZHkgaG9sZGluZyB0aGUgbXV0ZXguIE5vIGV4dHJh
IHB0aHJlYWRfbXV0ZXhfbG9jayBjYWxsLCBubyByZS1ibG9ja2luZy4NClNvIHdpdGggYSBQSSBt
dXRleCwgbW92aW5nIHRoZSBzaWduYWwgdW5kZXIgdGhlIGxvY2sgaXMgZmluZSDigJMgdGhlIHdh
aXRlciB3b24ndCBnZXQgc3R1Y2sgd2FpdGluZyBmb3IgdGhlIGxvY2sgYWdhaW4uDQoNCkdsaWJj
IGhhcyBzdXBwb3J0ZWQgUEkgbXV0ZXhlcyB3aXRoIEZVVEVYX1JFUVVFVUVfUEkuDQpIZXJlIGFy
ZSBnbGliYyBjb21taXRzOg0KeDg2OiBodHRwczovL3NvdXJjZXdhcmUub3JnL2dpdC8/cD1nbGli
Yy5naXQ7YT1jb21taXQ7aD00MmU2OWJjZjExMzdmY2NmZDdhOTU2NDVhOWQzMTZjNjQ5MGI5ZmY5
DQpub24teDg2IDogaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9naXQvP3A9Z2xpYmMuZ2l0O2E9Y29t
bWl0O2g9ODMxM2NiOTk3ZDJkYTI0NjVjODU2MGQzMTY0MzU4YTY4ZWExZTlhZA0KDQpMb29raW5n
IGZvcndhcmQgdG8geW91ciByZXBseSwNClN0ZXBhbi4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+IA0K
U2VudDogTW9uZGF5LCBNYXJjaCAzMCwgMjAyNiA0OjQzIFBNDQpUbzogU3RlcGFuIFBvcG92IDxT
dGVwYW4uUG9wb3ZAa2FzcGVyc2t5LmNvbT4NCkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFl
bXUtdHJpdmlhbEBub25nbnUub3JnOyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gdGhyZWFkLXBvb2w6IHNpZ25hbCBjb25kaXRpb24gdmFy
aWFibGUgd2hpbGUgaG9sZGluZyBsb2NrDQoNCg0KDQpPbiBNb24sIE1hciAzMCwgMjAyNiBhdCAw
NDowMTowNFBNICswMzAwLCBTdGVwYW4gUG9wb3Ygd3JvdGU6DQo+IE1vdmUgcWVtdV9jb25kX3Np
Z25hbCgpIGluc2lkZSB0aGUgY3JpdGljYWwgc2VjdGlvbiBwcm90ZWN0ZWQgYnkgcG9vbC0+bG9j
ay4NCj4gU2lnbmFsaW5nIHdoaWxlIGhvbGRpbmcgdGhlIGxvY2sgaW1wb3NlcyBtb3JlIHByZWRp
Y3RhYmxlIHNjaGVkdWxpbmcgYmVoYXZpb3IuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFN0ZXBhbiBQ
b3BvdiA8U3RlcGFuLlBvcG92QGthc3BlcnNreS5jb20+DQo+IC0tLQ0KPiAgdXRpbC90aHJlYWQt
cG9vbC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS91dGlsL3RocmVhZC1wb29sLmMgYi91dGlsL3RocmVh
ZC1wb29sLmMgaW5kZXggDQo+IDhmOGNiMzhkNWMuLjhlNTVhZWZkMDcgMTAwNjQ0DQo+IC0tLSBh
L3V0aWwvdGhyZWFkLXBvb2wuYw0KPiArKysgYi91dGlsL3RocmVhZC1wb29sLmMNCj4gQEAgLTI2
NSw4ICsyNjUsOCBAQCBCbG9ja0FJT0NCICp0aHJlYWRfcG9vbF9zdWJtaXRfYWlvKFRocmVhZFBv
b2xGdW5jICpmdW5jLCB2b2lkICphcmcsDQo+ICAgICAgICAgIHNwYXduX3RocmVhZChwb29sKTsN
Cj4gICAgICB9DQo+ICAgICAgUVRBSUxRX0lOU0VSVF9UQUlMKCZwb29sLT5yZXF1ZXN0X2xpc3Qs
IHJlcSwgcmVxcyk7DQo+IC0gICAgcWVtdV9tdXRleF91bmxvY2soJnBvb2wtPmxvY2spOw0KPiAg
ICAgIHFlbXVfY29uZF9zaWduYWwoJnBvb2wtPnJlcXVlc3RfY29uZCk7DQo+ICsgICAgcWVtdV9t
dXRleF91bmxvY2soJnBvb2wtPmxvY2spOw0KPiAgICAgIHJldHVybiAmcmVxLT5jb21tb247DQo+
ICB9DQoNCkRvZXNuJ3QgdGhpcyBvcmRlciBtZWFuIHRoYXQgd2hlbiB0aGUgc2lnbmFsIHdha2Vz
IHVwIHRoZSB3YWl0aW5nIHRocmVhZCwgdGhhdCB0aHJlYWQgd2lsbCBnZXQgdGVtcG9yYXJpbHkg
cmUtYmxvY2tlZCB3YWl0aW5nIGZvciAnbG9jaycgdG8gYmUgcmVsZWFzZWQgYnkgdGhlIG9yaWdp
bmFsIHRocmVhZCB0b28uDQoNCldpdGggcmVnYXJkcywNCkRhbmllbA0KLS0NCnw6IGh0dHBzOi8v
YmVycmFuZ2UuY29tICAgICAgIH5+ICAgICAgICBodHRwczovL2hhY2h5ZGVybS5pby9AYmVycmFu
Z2UgOnwNCnw6IGh0dHBzOi8vbGlidmlydC5vcmcgICAgICAgICAgfn4gICAgICAgICAgaHR0cHM6
Ly9lbnRhbmdsZS1waG90by5vcmcgOnwNCnw6IGh0dHBzOi8vcGl4ZWxmZWQuYXJ0L2JlcnJhbmdl
ICAgfn4gICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20gOnwNCg0K

