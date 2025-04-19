Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95787C369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 01:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5wsg-0007CE-84; Fri, 18 Apr 2025 21:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wsd-0007BJ-4H
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:20:27 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wsb-00041l-5F
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:20:26 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so34853605ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 18:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745025624; x=1745630424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZ8/wSsMhmFEE8Gv+XmGEdU0huSrlJ9jJYhq099bov4=;
 b=TRE9VbLT5lQS0q1osS4l/jZ2ifIEjq5Yl8IgozJmuH3rZJeugpGuA2rnESFZEwyi4m
 SSiyM2OTaD97Pj2sMdd5eyxpGpk1GVrk9eMN3EMWH4KRFYEbzfgqI43JSJFZfNvE2Hsf
 r6L7oREHogDTmpeXt6xdGqAgxScrxSnkIxbme2ykMz6X5l8HikZ5LbuuJsFCqTE6DnrQ
 ISUCXcqKgPcxw/l2cwKORs1koYOTDdg8dt+bcwIDPo+FbcxUyX3XE7cwk/MWU/+43t1c
 du+DAGwTRLLH19s/+V/u7z1N0CNL4KpH4ozeeNP8W2ReD/BeO3nEk3aYSXVN3m8efjB+
 U3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745025624; x=1745630424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZ8/wSsMhmFEE8Gv+XmGEdU0huSrlJ9jJYhq099bov4=;
 b=n8Tnh6hRIt0ITr5WKGucLjU5FGci2aDPVUhGuKq6ts/2HmWYE8CN2p9P58mwHST+ky
 FR//olJAf9YtWVogF9aysmGh+zct8DbBoIUMPA3gFnncwUebg3d0Uvlgs3BkzSBxf2+3
 lr9K42QbQrIxDYrJV3yRmA1jKygQr4T16lCJjaiDgbjAE7gQsCXh8M7KlFjIlN/8dNJQ
 i1Q5EdrjwoEU6p6qTDyW6bYOijbe4ur4VDxziSKuBW5SnKAYkskI7E6YtplnMR146Q2R
 z0K655kxqKxbt97FhEsF4UQwPBsu00y+a9F56gCVuuw+lY6f6a4vnQMPBHADXqAtPc71
 d/EA==
X-Gm-Message-State: AOJu0YwBTSMYFm137YEwRRHl8wHGvrjPhkcb4gdo4hCjboOJPdQ3h+mV
 LhieRDQtk64YVLUvu8AkuJWdGXP4qVOAIdYhxPFsoY8N2RFo5LcgBIiFSLOZ9fY=
X-Gm-Gg: ASbGncuSTIRcmP7Vt/nZePlJvUBw3wijb8SWEHM6XatNcswx9a/f+nffOXXTWaH7ZBP
 VFbu5yCATyPJFe1O+AzYR6Dj1HUzEnpsUi5VniWu0wWsUQshUkH8vliAhyl27TLRZTrpT3e9dRW
 hPU3iM4Egouik5SH3ivorxUdPvLVuUJwd1k8YfvcbqU6YUmuDRg23H18QN208jc2f4HRKcBTjiU
 8I8fXdpQ62s3i9Uu34JZJBHSBajiH6pAbdjbJlhdAl4kX2q3YPvFRH+8OO/QSN9tFeDjTrlL60U
 zaEgBXCRwb6YYx0KYSLw2I9OZbRvFg2yWuJhWEX0bDmQTLWcQ9tKoA==
X-Google-Smtp-Source: AGHT+IEQWszImlRVzJM468TgNFJC1u69kLdSXJwU9JWJVK8YiVILEYKB5svJfPO46pWV6qxukmeUTg==
X-Received: by 2002:a17:903:2f81:b0:223:4b88:780f with SMTP id
 d9443c01a7336-22c53582679mr78594005ad.17.1745025623695; 
 Fri, 18 Apr 2025 18:20:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf5425sm23463575ad.98.2025.04.18.18.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 18:20:23 -0700 (PDT)
Message-ID: <bb505862-a65e-4d83-b6bd-066c1281daf4@linaro.org>
Date: Fri, 18 Apr 2025 18:20:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] hw/arm: Define machines as generic QOM types
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Felipe Balbi
 <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250417235814.98677-1-philmd@linaro.org>
 <a302fb91-e2d8-ef36-ac53-5e460476c2d0@eik.bme.hu>
 <25a82a76-cd63-4a42-bb68-5dcf826bd948@linaro.org>
 <26c2b844-dc96-448e-8978-e536ed1e61f6@linaro.org>
 <401c58d2-adda-81ec-eeec-0ddbcf3e4926@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <401c58d2-adda-81ec-eeec-0ddbcf3e4926@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gNC8xOC8yNSAxMTo0OCwgQkFMQVRPTiBab2x0YW4gd3JvdGU6DQo+IE9uIEZyaSwgMTgg
QXByIDIwMjUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gT24gMTgvNC8y
NSAxODozMywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+PiBPbiA0LzE4LzI1IDAxOjUz
LCBCQUxBVE9OIFpvbHRhbiB3cm90ZToNCj4+Pj4gT24gRnJpLCAxOCBBcHIgMjAyNSwgUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+PiBXaGlsZSBERUZJTkVfTUFDSElO
RSgpIGlzIGEgc3VjY2luY3QgbWFjcm8sIGl0IGRvZXNuJ3QNCj4+Pj4+IGFsbG93IHJlZ2lz
dGVyaW5nIFFPTSBpbnRlcmZhY2VzIHRvIHRoZSBkZWZpbmVkIG1hY2hpbmUuDQo+Pj4+PiBD
b252ZXJ0IHRvIHRoZSBnZW5lcmljIERFRklORV9UWVBFUygpIGluIHByZXBhcmF0aW9uIHRv
DQo+Pj4+PiByZWdpc3RlciBpbnRlcmZhY2VzLg0KPj4+Pj4NCj4+Pj4+IFBoaWxpcHBlIE1h
dGhpZXUtRGF1ZMOpICgxMSk6DQo+Pj4+PiAgwqAgaHcvY29yZS9udWxsLW1hY2hpbmU6IERl
ZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+Pj4+ICDCoCBody9hcm0vYmFu
YW5hcGk6IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+Pj4+ICDCoCBo
dy9hcm0vY3ViaWVib2FyZDogRGVmaW5lIG1hY2hpbmUgYXMgZ2VuZXJpYyBRT00gdHlwZQ0K
Pj4+Pj4gIMKgIGh3L2FybS9kaWdpYzogRGVmaW5lIG1hY2hpbmUgYXMgZ2VuZXJpYyBRT00g
dHlwZQ0KPj4+Pj4gIMKgIGh3L2FybS9pbXg6IERlZmluZSBtYWNoaW5lcyBhcyBnZW5lcmlj
IFFPTSB0eXBlcw0KPj4+Pj4gIMKgIGh3L2FybS9pbnRlZ3JhdG9yY3A6IERlZmluZSBtYWNo
aW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+Pj4+ICDCoCBody9hcm0va3ptOiBEZWZpbmUg
bWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+Pj4+PiAgwqAgaHcvYXJtL21zZjI6IERl
ZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+Pj4+ICDCoCBody9hcm0vbXVz
aWNwYWw6IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+Pj4+ICDCoCBo
dy9hcm0vb3JhbmdlcGk6IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+
Pj4+ICDCoCBody9hcm0vc3RtMzI6IERlZmluZSBtYWNoaW5lcyBhcyBnZW5lcmljIFFPTSB0
eXBlcw0KPj4+Pj4NCj4+Pj4+IGh3L2FybS9iYW5hbmFwaV9tMnUuY8KgwqDCoMKgwqAgfCAx
MyArKysrKysrKysrKy0tDQo+Pj4+PiBody9hcm0vY3ViaWVib2FyZC5jwqDCoMKgwqDCoMKg
wqAgfCAxMyArKysrKysrKysrKy0tDQo+Pj4+PiBody9hcm0vZGlnaWNfYm9hcmRzLmPCoMKg
wqDCoMKgIHwgMTQgKysrKysrKysrKysrLS0NCj4+Pj4+IGh3L2FybS9pbXgyNV9wZGsuY8Kg
wqDCoMKgwqDCoMKgwqAgfCAxNCArKysrKysrKysrKystLQ0KPj4+Pj4gaHcvYXJtL2lteDht
cC1ldmsuY8KgwqDCoMKgwqDCoMKgIHwgMTUgKysrKysrKysrKysrKy0tDQo+Pj4+PiBody9h
cm0vaW50ZWdyYXRvcmNwLmPCoMKgwqDCoMKgIHwgMTYgKysrKysrKysrKysrKy0tLQ0KPj4+
Pj4gaHcvYXJtL2t6bS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE0ICsrKysr
KysrKysrKy0tDQo+Pj4+PiBody9hcm0vbWNpbXg2dWwtZXZrLmPCoMKgwqDCoMKgIHwgMTUg
KysrKysrKysrKysrKy0tDQo+Pj4+PiBody9hcm0vbWNpbXg3ZC1zYWJyZS5jwqDCoMKgwqAg
fCAxNSArKysrKysrKysrKysrLS0NCj4+Pj4+IGh3L2FybS9tc2YyLXNvbS5jwqDCoMKgwqDC
oMKgwqDCoMKgIHwgMTMgKysrKysrKysrKystLQ0KPj4+Pj4gaHcvYXJtL211c2ljcGFsLmPC
oMKgwqDCoMKgwqDCoMKgwqAgfCAxNiArKysrKysrKysrKysrLS0tDQo+Pj4+PiBody9hcm0v
bmV0ZHVpbm8yLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTMgKysrKysrKysrKystLQ0KPj4+Pj4g
aHcvYXJtL25ldGR1aW5vcGx1czIuY8KgwqDCoMKgIHwgMTMgKysrKysrKysrKystLQ0KPj4+
Pj4gaHcvYXJtL29saW1leC1zdG0zMi1oNDA1LmMgfCAxMyArKysrKysrKysrKy0tDQo+Pj4+
PiBody9hcm0vb3JhbmdlcGkuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDEzICsrKysrKysrKysr
LS0NCj4+Pj4+IGh3L2FybS9zYWJyZWxpdGUuY8KgwqDCoMKgwqDCoMKgwqAgfCAxNCArKysr
KysrKysrKystLQ0KPj4+Pj4gaHcvYXJtL3N0bTMydmxkaXNjb3ZlcnkuY8KgIHwgMTMgKysr
KysrKysrKystLQ0KPj4+Pj4gaHcvY29yZS9udWxsLW1hY2hpbmUuY8KgwqDCoMKgIHwgMTQg
KysrKysrKysrKysrLS0NCj4+Pj4+IDE4IGZpbGVzIGNoYW5nZWQsIDIxMyBpbnNlcnRpb25z
KCspLCAzOCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gVGhpcyBpcyBtdWNoIGxvbmdlciBh
bmQgZXhwb3NpbmcgYm9pbGVyIHBsYXRlIGNvZGUuIElzIGl0IHBvc3NpYmxlIGluc3RlYWQN
Cj4+Pj4gdG8gY2hhbmdlIERFRklORV9NQUNISU5FIG9yIGFkZCBhbm90aGVyIHNpbWlsYXIg
bWFjcm8gdGhhdCBhbGxvd3MNCj4+Pj4gc3BlY2lmeWluZyBtb3JlIGRldGFpbHMgc3VjaCBh
cyBjbGFzcyBzdGF0ZSB0eXBlIGFuZCBpbnRlcmZhY2VzIGxpa2Ugd2UNCj4+Pj4gYWxyZWFk
eSBoYXZlIGZvciBPQkpFQ1RfREVGSU5FIG1hY3JvcyB0byBrZWVwIHRoZSBib2lsZXIgcGxh
dGUgY29kZSBoaWRkZW4NCj4+Pj4gYW5kIG5vdCBicmluZyBpdCBiYWNrPw0KPj4+Pg0KPj4+
DQo+Pj4gV2UgY2FuIGV2ZW50dWFsbHkgbW9kaWZ5IERFRklORV9NQUNISU5FUywgdG8gdGFr
ZSBhbiBhZGRpdGlvbmFsIGludGVyZmFjZXMNCj4+PiBwYXJhbWV0ZXIsIGFuZCByZXBsYWNl
IGFsbCBjYWxsIHNpdGVzLCB3aXRoIGFuIGVtcHR5IGxpc3QgZm9yIGFsbCBib2FyZHMNCj4+
PiBvdXQgb2YgaHcvYXJtLg0KPj4+DQo+Pj4gQXMgbG9uZyBhcyB3ZSBhdm9pZCBzb21ldGhp
bmcgbGlrZToNCj4+PiBERUZJTkVfTUFDSElORVNfV0lUSF9JTlRFUkZBQ0VfMSguLi4pDQo+
Pj4gREVGSU5FX01BQ0hJTkVTX1dJVEhfSU5URVJGQUNFXzIoLi4uKQ0KPj4+IERFRklORV9N
QUNISU5FU19XSVRIX0lOVEVSRkFDRV8zKC4uLikNCj4+PiBJJ20gb2sgd2l0aCBrZWVwaW5n
IHRoZSBtYWNyby4NCj4+Pg0KPj4+IFdvdWxkIHRoYXQgd29yayBmb3IgeW91IGZvbGtzPw0K
Pj4NCj4+IEJ1dCB0aGVuIHdlJ2xsIHdhbnQgREVGSU5FX1BQQzMyX01BQ0hJTkUoKSAtPg0K
Pj4gREVGSU5FX01BQ0hJTkVTX1dJVEhfSU5URVJGQUNFXzEoKSBldGMuLi4NCj4+DQo+PiBX
ZSB3YW50IHRvIGV2ZW50dWFsbHkgdXNlIGRlY2xhcmF0aXZlIGZpbGUgdG8gc3RydWN0dXJl
IG1vc3Qgb2YgdGhlDQo+PiBtYWNoaW5lIGJvaWxlciBwbGF0ZSBjb2RlLiBNYXliZSBiZWlu
ZyBtb21lbnRhcmlseSB2ZXJib3NlIGlzDQo+PiBhY2NlcHRhYmxlLi4uDQo+IA0KPiBNb21l
bnRzIGluIFFFTVUgY2FuIGxhc3QgeWVhcnMuLi4gSSB3YXMgdGhpbmtpbmcgYWJvdXQgc2lt
aWxhciB0bw0KPiBPQkpFQ1RfREVGSU5FX1NJTVBMRV9UWVBFX1dJVEhfSU5URVJGQUNFUy4g
V291bGQgc29tZXRoaW5nIGxpa2UgdGhhdCBiZQ0KPiBwb3NzaWJsZSBmb3IgREVGSU5FX01B
Q0hJTkUgdG9vPw0KPiANCg0KV2UgY2FuIGp1c3QgYWRkIHRoZSBsaXN0IG9mIGludGVyZmFj
ZXMgdGhlIG1hY2hpbmUgaXMgaW1wbGVtZW50aW5nIGFzIGFuIA0KYWRkaXRpb25hbCBwYXJh
bWV0ZXIgdG8gREVGSU5FX01BQ0hJTkUsIGFuZCB0aGlzIHNvbHZlcyB0aGUgcHJvYmxlbSAN
CndpdGhvdXQgYWRkaW5nIGFueSBib2lsZXJwbGF0ZS4NCg0KVWx0aW1hdGVseSwgd2UnbGwg
bmVlZCB0byB0YWcgYWxsIG1hY2hpbmVzIHRvIG1lbnRpb24gdGFyZ2V0cyBzdXBwb3J0ZWQs
IA0Kc28gdGhpcyBpbmZvcm1hdGlvbiBoYXMgdG8gYmUgd3JpdHRlbiBzb21ld2hlcmUuDQoN
Cj4gUmVnYXJkcywNCj4gQkFMQVRPTiBab2x0YW4NCg0K

