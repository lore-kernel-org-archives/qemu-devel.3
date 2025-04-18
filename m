Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04897C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5p7T-0005dZ-Mj; Fri, 18 Apr 2025 13:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5p7S-0005dL-6u
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:03:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5p7Q-0004lJ-BV
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:03:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so1854528b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744995790; x=1745600590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=evtNphXxaFH71ju8wrtSa4YQjBanemanWnMBRRa1Iog=;
 b=YBWeWqqah7uBNExTNGmQPUxZgmWi8PitrSJl7AWTHeDZkZNg1JGCM9qnNpPh7wHJkD
 yDtfoziOBnJZvUxOiScCGvhNWkfZvX8AuMgx1+1qRHY1TFHWPLZO+H29gnTMUpuAZvWk
 Bs+nnZzk1DnBmt469/wMYcU9+15Ndyku0jpWKmTTrwPjd/VirAdnmPueqIg82Tyx3oi+
 jQA7qKlLKEkJMIdOCOydllXX73dsLB9l4b8A+Dl705SC/+Hcu0VPH6ePHsSQLUvtLtXY
 emTW/gxH1prC+hr7R8fPp7Verto2Y9ejyvzab8asCCw0YlqYHVtOIV4YPVL6Uc9QT5vQ
 3BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744995790; x=1745600590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=evtNphXxaFH71ju8wrtSa4YQjBanemanWnMBRRa1Iog=;
 b=ZJ1v5LFAqVg7jG8YwFDxlbqxrlYxT67HMNLkKU4p9u8x6r06yDCAcW18OvKdnSosF/
 sLycAXUEwXn4TVM1WeLqF7eKx7i5TOQQKxaFW9nKsXH8DR9CVJR6hCGnPFCthzRpwsar
 1aAHoz83oGfzRjxXLxJNS7UBJF1qTO5fEKU1o9EmYR5rnf42SJrPLYHSYpcQmLuGuLkZ
 SU9jWbk+CO1vLKNUp3Jy++YpKI2VEkvp1JF0Pq5Z+j2igeHn/psOk5i3FS+uhy6LPx3b
 QZBAw8cLehmYoo9gA2O0qcsIzQ1ErYLh7Eup+IeRjPk9Uh67Rpq19EmwRyHVDN34pHxn
 jiaw==
X-Gm-Message-State: AOJu0YxiuQsl4XOCptjxaxrDHfUxBaaeWT7t+oWUNs9E6aEIaV1Luy50
 JZ50a2r1LdAA7y+umxoV3XQonE/KUb/gaKAAemgizXz+ah1McQOmIP6lNwd3qCA=
X-Gm-Gg: ASbGncur1hxaOTUJRjczvzhouZrwH/28nPjdnU21zjrTp7BoYuCP3Mem2C0OQriDL3Y
 yGgwQqjCzxRr3nlu4rCj0JlzQddzh88ifLra38TYWiXh1H1w5Lv2gRO8IM2+VxSzU7JsyWA3zQt
 UI1PI2k0BWwgz1mtUORmh41XJuNVG4xwRwwKC3/t6l6x1W0mnIZIV/LGi4cpXXKBeImjAm720fU
 XNMwL/ifIj/ZNrVpgfGKrV66TVf6DsGJSYYc64gfyWqHfXZBvch3OEAv1y4duU4XjEcnz31MAnV
 Flgd2GsA2dEmVi37xCtZVJG3rutP+jqTL/9sPs3gG8G5N+JOctEExg==
X-Google-Smtp-Source: AGHT+IGROqeltytGbdkHUZo2QFfji6rCbFSGaIDTBRFE/Dw8KWNUZQ45FMLXtUfvxylu6HkBPHhGDg==
X-Received: by 2002:a05:6a00:2285:b0:736:4d05:2e2e with SMTP id
 d2e1a72fcca58-73dc149716dmr4381970b3a.6.1744995790216; 
 Fri, 18 Apr 2025 10:03:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa59176sm1827621b3a.113.2025.04.18.10.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:03:09 -0700 (PDT)
Message-ID: <35ae8633-4195-446b-9a22-0c131b9cab88@linaro.org>
Date: Fri, 18 Apr 2025 10:03:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] hw/arm: Define machines as generic QOM types
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
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
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <26c2b844-dc96-448e-8978-e536ed1e61f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

T24gNC8xOC8yNSAwOTo1OSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzQvMjUgMTg6MzMsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzE4LzI1
IDAxOjUzLCBCQUxBVE9OIFpvbHRhbiB3cm90ZToNCj4+PiBPbiBGcmksIDE4IEFwciAyMDI1
LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4gV2hpbGUgREVGSU5FX01B
Q0hJTkUoKSBpcyBhIHN1Y2NpbmN0IG1hY3JvLCBpdCBkb2Vzbid0DQo+Pj4+IGFsbG93IHJl
Z2lzdGVyaW5nIFFPTSBpbnRlcmZhY2VzIHRvIHRoZSBkZWZpbmVkIG1hY2hpbmUuDQo+Pj4+
IENvbnZlcnQgdG8gdGhlIGdlbmVyaWMgREVGSU5FX1RZUEVTKCkgaW4gcHJlcGFyYXRpb24g
dG8NCj4+Pj4gcmVnaXN0ZXIgaW50ZXJmYWNlcy4NCj4+Pj4NCj4+Pj4gUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgKDExKToNCj4+Pj4gIMKgIGh3L2NvcmUvbnVsbC1tYWNoaW5lOiBEZWZp
bmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+Pj4+ICDCoCBody9hcm0vYmFuYW5h
cGk6IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+Pj4gIMKgIGh3L2Fy
bS9jdWJpZWJvYXJkOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+Pj4+
ICDCoCBody9hcm0vZGlnaWM6IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUN
Cj4+Pj4gIMKgIGh3L2FybS9pbXg6IERlZmluZSBtYWNoaW5lcyBhcyBnZW5lcmljIFFPTSB0
eXBlcw0KPj4+PiAgwqAgaHcvYXJtL2ludGVncmF0b3JjcDogRGVmaW5lIG1hY2hpbmUgYXMg
Z2VuZXJpYyBRT00gdHlwZQ0KPj4+PiAgwqAgaHcvYXJtL2t6bTogRGVmaW5lIG1hY2hpbmUg
YXMgZ2VuZXJpYyBRT00gdHlwZQ0KPj4+PiAgwqAgaHcvYXJtL21zZjI6IERlZmluZSBtYWNo
aW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+Pj4gIMKgIGh3L2FybS9tdXNpY3BhbDogRGVm
aW5lIG1hY2hpbmUgYXMgZ2VuZXJpYyBRT00gdHlwZQ0KPj4+PiAgwqAgaHcvYXJtL29yYW5n
ZXBpOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+Pj4+ICDCoCBody9h
cm0vc3RtMzI6IERlZmluZSBtYWNoaW5lcyBhcyBnZW5lcmljIFFPTSB0eXBlcw0KPj4+Pg0K
Pj4+PiBody9hcm0vYmFuYW5hcGlfbTJ1LmPCoMKgwqDCoMKgIHwgMTMgKysrKysrKysrKyst
LQ0KPj4+PiBody9hcm0vY3ViaWVib2FyZC5jwqDCoMKgwqDCoMKgwqAgfCAxMyArKysrKysr
KysrKy0tDQo+Pj4+IGh3L2FybS9kaWdpY19ib2FyZHMuY8KgwqDCoMKgwqAgfCAxNCArKysr
KysrKysrKystLQ0KPj4+PiBody9hcm0vaW14MjVfcGRrLmPCoMKgwqDCoMKgwqDCoMKgIHwg
MTQgKysrKysrKysrKysrLS0NCj4+Pj4gaHcvYXJtL2lteDhtcC1ldmsuY8KgwqDCoMKgwqDC
oMKgIHwgMTUgKysrKysrKysrKysrKy0tDQo+Pj4+IGh3L2FybS9pbnRlZ3JhdG9yY3AuY8Kg
wqDCoMKgwqAgfCAxNiArKysrKysrKysrKysrLS0tDQo+Pj4+IGh3L2FybS9rem0uY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNCArKysrKysrKysrKystLQ0KPj4+PiBody9h
cm0vbWNpbXg2dWwtZXZrLmPCoMKgwqDCoMKgIHwgMTUgKysrKysrKysrKysrKy0tDQo+Pj4+
IGh3L2FybS9tY2lteDdkLXNhYnJlLmPCoMKgwqDCoCB8IDE1ICsrKysrKysrKysrKystLQ0K
Pj4+PiBody9hcm0vbXNmMi1zb20uY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDEzICsrKysrKysr
KysrLS0NCj4+Pj4gaHcvYXJtL211c2ljcGFsLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNiAr
KysrKysrKysrKysrLS0tDQo+Pj4+IGh3L2FybS9uZXRkdWlubzIuY8KgwqDCoMKgwqDCoMKg
wqAgfCAxMyArKysrKysrKysrKy0tDQo+Pj4+IGh3L2FybS9uZXRkdWlub3BsdXMyLmPCoMKg
wqDCoCB8IDEzICsrKysrKysrKysrLS0NCj4+Pj4gaHcvYXJtL29saW1leC1zdG0zMi1oNDA1
LmMgfCAxMyArKysrKysrKysrKy0tDQo+Pj4+IGh3L2FybS9vcmFuZ2VwaS5jwqDCoMKgwqDC
oMKgwqDCoMKgIHwgMTMgKysrKysrKysrKystLQ0KPj4+PiBody9hcm0vc2FicmVsaXRlLmPC
oMKgwqDCoMKgwqDCoMKgIHwgMTQgKysrKysrKysrKysrLS0NCj4+Pj4gaHcvYXJtL3N0bTMy
dmxkaXNjb3ZlcnkuY8KgIHwgMTMgKysrKysrKysrKystLQ0KPj4+PiBody9jb3JlL251bGwt
bWFjaGluZS5jwqDCoMKgwqAgfCAxNCArKysrKysrKysrKystLQ0KPj4+PiAxOCBmaWxlcyBj
aGFuZ2VkLCAyMTMgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBU
aGlzIGlzIG11Y2ggbG9uZ2VyIGFuZCBleHBvc2luZyBib2lsZXIgcGxhdGUgY29kZS4gSXMg
aXQgcG9zc2libGUNCj4+PiBpbnN0ZWFkDQo+Pj4gdG8gY2hhbmdlIERFRklORV9NQUNISU5F
IG9yIGFkZCBhbm90aGVyIHNpbWlsYXIgbWFjcm8gdGhhdCBhbGxvd3MNCj4+PiBzcGVjaWZ5
aW5nIG1vcmUgZGV0YWlscyBzdWNoIGFzIGNsYXNzIHN0YXRlIHR5cGUgYW5kIGludGVyZmFj
ZXMgbGlrZSB3ZQ0KPj4+IGFscmVhZHkgaGF2ZSBmb3IgT0JKRUNUX0RFRklORSBtYWNyb3Mg
dG8ga2VlcCB0aGUgYm9pbGVyIHBsYXRlIGNvZGUNCj4+PiBoaWRkZW4NCj4+PiBhbmQgbm90
IGJyaW5nIGl0IGJhY2s/DQo+Pj4NCj4+DQo+PiBXZSBjYW4gZXZlbnR1YWxseSBtb2RpZnkg
REVGSU5FX01BQ0hJTkVTLCB0byB0YWtlIGFuIGFkZGl0aW9uYWwNCj4+IGludGVyZmFjZXMg
cGFyYW1ldGVyLCBhbmQgcmVwbGFjZSBhbGwgY2FsbCBzaXRlcywgd2l0aCBhbiBlbXB0eSBs
aXN0IGZvcg0KPj4gYWxsIGJvYXJkcyBvdXQgb2YgaHcvYXJtLg0KPj4NCj4+IEFzIGxvbmcg
YXMgd2UgYXZvaWQgc29tZXRoaW5nIGxpa2U6DQo+PiBERUZJTkVfTUFDSElORVNfV0lUSF9J
TlRFUkZBQ0VfMSguLi4pDQo+PiBERUZJTkVfTUFDSElORVNfV0lUSF9JTlRFUkZBQ0VfMigu
Li4pDQo+PiBERUZJTkVfTUFDSElORVNfV0lUSF9JTlRFUkZBQ0VfMyguLi4pDQo+PiBJJ20g
b2sgd2l0aCBrZWVwaW5nIHRoZSBtYWNyby4NCj4+DQo+PiBXb3VsZCB0aGF0IHdvcmsgZm9y
IHlvdSBmb2xrcz8NCj4gDQo+IEJ1dCB0aGVuIHdlJ2xsIHdhbnQgREVGSU5FX1BQQzMyX01B
Q0hJTkUoKSAtPg0KPiBERUZJTkVfTUFDSElORVNfV0lUSF9JTlRFUkZBQ0VfMSgpIGV0Yy4u
Lg0KPiANCg0KV2UgY2FuIHNlZSB0aGF0IGxhdGVyIHdoZW4gdG91Y2hpbmcgb3RoZXIgdGFy
Z2V0cy4gRm9yIG5vdywgDQpERUZJTkVfTUFDSElORSBpcyBub3QgdXNlZCBpbiBhIGxvdCBv
ZiBwbGFjZXMsIHNvIHJlcGxhY2luZyBjYWxsIHNpdGVzIA0Kc2hvdWxkIGJlIGVhc3ksIGFu
ZCBpdCB3aWxsIGNvdmVyIGh3L2FybSwgd2hpY2ggaXMgb3VyIHBvaW50IG9mIGludGVyZXN0
IA0Kbm93Lg0KDQo+IFdlIHdhbnQgdG8gZXZlbnR1YWxseSB1c2UgZGVjbGFyYXRpdmUgZmls
ZSB0byBzdHJ1Y3R1cmUgbW9zdCBvZiB0aGUNCj4gbWFjaGluZSBib2lsZXIgcGxhdGUgY29k
ZS4gTWF5YmUgYmVpbmcgbW9tZW50YXJpbHkgdmVyYm9zZSBpcw0KPiBhY2NlcHRhYmxlLi4u
DQoNCg==

