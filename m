Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B80C369CA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 16:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5of8-00048W-9b; Fri, 18 Apr 2025 12:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5oew-00044w-7J
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 12:33:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5oeu-00014j-6e
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 12:33:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227d6b530d8so22028505ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744994023; x=1745598823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLZ88TFvJP6hHR9nA0RAmGHI0YhcTQXCuQM3vJSY5FA=;
 b=zWT8vbwGMTiph+z73oKPTkodOpcmVxrStpMXU4GQVrveEdIVbR0ek2ln7+nT+ol5qs
 +rzyJtADldTnHFsYaSmCeAcbH6Lzv4TS+aoAuTSJS6XG7Zq/77bNvK3pCALU7WIoZHjF
 IPK537qqDgq0PxluiP9HgqV91EdcK7bVQ00HpMZAib1a1VaZysw+WpsDPnlizzhoRyaK
 5BmN/zrdbX67xcfOBviHF0eBcz0Z1mivrRNyX1JKb8NWynnL/YYHtlkFT2YoEgvf5ykv
 cKTBTbDLrp3DV5WrzKgzw2LL5fHNYJjtZkkpJ8Hlza+VUcS1SGiM4xW7pD8JuKLNPWFH
 NfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744994023; x=1745598823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLZ88TFvJP6hHR9nA0RAmGHI0YhcTQXCuQM3vJSY5FA=;
 b=dfklxCMyNWnKFGc2Ob2lTHSUZpz3tGdoc4YwAyaX2KbbLe2OKkWmNAI4FpsnUsAA/J
 lTcbMtWRJqc59zsE3TBXlqjegC6Lvrea5uiSSZ1GHRg7XsW5RPF6rG8rfUkjkhD4IZvo
 QO3eVAuOkjRjugOACXYL267XEIKMu+7iiEVgoYR53IJ7vgVJyDLUhVAUJ8aRQHXgA8iF
 XhOg6yAgHFDGvHogqewCYZF7twD6E8G2ZjuIAvJ5TKeN3AKe1qEiFFvUgds2iRT0JYqn
 7AXDDhuSU6qSawwf+g1OX8w4F6P58a6t5i2D0N6dDdPZ0FWLuzGmwH2mI4GsPfOOh4O0
 jxCw==
X-Gm-Message-State: AOJu0YxB7IYi2cDH0ayVJp3k5RjkQcAVIT/FwHArT8qPLtZWHULnZMAE
 OYgGdujZrLkml8QacNTJIX78NrsiOKz+licDLFqXJm0JGstLnLsE5qgzeVWMX5Q=
X-Gm-Gg: ASbGncs4XfWxJy+6E8KcfYGculv6LtGfA6chOrSCYvcgdDIvfRC1CnHRfOrB2ycZwwd
 zLFj+5n+6d5nZNwntFr23JsHTAa4C58+egW9d1omaGLn0GwoXrjTZCh9GFS249knV/Z3K55uuyG
 H+v3OgALWjtPAtZJulmlr1oSJZO2fCFVF7QQJY+eZSNGeBMdvW0My+oVy9j+wrrz9dGTtFn9Lsy
 TLR9IXw2maH2cBXYhU2Yeyz0Y4ysCOj6CM/asF29bRodGzOyiXqPjeeRwe/5dYPo5k+xUtdKSUY
 GQhOaXr7B6O3nuFi5HNQ5kfT4Cx8dqvZZtwmmLJjMs7opvGUunF1bpd0GmWomWeq
X-Google-Smtp-Source: AGHT+IGdzPGfbCkGaZ1tzQRbWrXP2XPRZtMMzKtDyXnEJOrfmDjJVb/LfBnOAQATQE3+IYKFUvjuGw==
X-Received: by 2002:a17:903:19e3:b0:224:1af1:87f4 with SMTP id
 d9443c01a7336-22c5358625amr56820875ad.22.1744994022752; 
 Fri, 18 Apr 2025 09:33:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa58355sm1871011b3a.90.2025.04.18.09.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 09:33:42 -0700 (PDT)
Message-ID: <25a82a76-cd63-4a42-bb68-5dcf826bd948@linaro.org>
Date: Fri, 18 Apr 2025 09:33:41 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a302fb91-e2d8-ef36-ac53-5e460476c2d0@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gNC8xOC8yNSAwMTo1MywgQkFMQVRPTiBab2x0YW4gd3JvdGU6DQo+IE9uIEZyaSwgMTgg
QXByIDIwMjUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gV2hpbGUgREVG
SU5FX01BQ0hJTkUoKSBpcyBhIHN1Y2NpbmN0IG1hY3JvLCBpdCBkb2Vzbid0DQo+PiBhbGxv
dyByZWdpc3RlcmluZyBRT00gaW50ZXJmYWNlcyB0byB0aGUgZGVmaW5lZCBtYWNoaW5lLg0K
Pj4gQ29udmVydCB0byB0aGUgZ2VuZXJpYyBERUZJTkVfVFlQRVMoKSBpbiBwcmVwYXJhdGlv
biB0bw0KPj4gcmVnaXN0ZXIgaW50ZXJmYWNlcy4NCj4+DQo+PiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSAoMTEpOg0KPj4gICBody9jb3JlL251bGwtbWFjaGluZTogRGVmaW5lIG1hY2hp
bmUgYXMgZ2VuZXJpYyBRT00gdHlwZQ0KPj4gICBody9hcm0vYmFuYW5hcGk6IERlZmluZSBt
YWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+ICAgaHcvYXJtL2N1YmllYm9hcmQ6IERl
ZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+ICAgaHcvYXJtL2RpZ2ljOiBE
ZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+PiAgIGh3L2FybS9pbXg6IERl
ZmluZSBtYWNoaW5lcyBhcyBnZW5lcmljIFFPTSB0eXBlcw0KPj4gICBody9hcm0vaW50ZWdy
YXRvcmNwOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+PiAgIGh3L2Fy
bS9rem06IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+ICAgaHcvYXJt
L21zZjI6IERlZmluZSBtYWNoaW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+ICAgaHcvYXJt
L211c2ljcGFsOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+PiAgIGh3
L2FybS9vcmFuZ2VwaTogRGVmaW5lIG1hY2hpbmUgYXMgZ2VuZXJpYyBRT00gdHlwZQ0KPj4g
ICBody9hcm0vc3RtMzI6IERlZmluZSBtYWNoaW5lcyBhcyBnZW5lcmljIFFPTSB0eXBlcw0K
Pj4NCj4+IGh3L2FybS9iYW5hbmFwaV9tMnUuYyAgICAgIHwgMTMgKysrKysrKysrKystLQ0K
Pj4gaHcvYXJtL2N1YmllYm9hcmQuYyAgICAgICAgfCAxMyArKysrKysrKysrKy0tDQo+PiBo
dy9hcm0vZGlnaWNfYm9hcmRzLmMgICAgICB8IDE0ICsrKysrKysrKysrKy0tDQo+PiBody9h
cm0vaW14MjVfcGRrLmMgICAgICAgICB8IDE0ICsrKysrKysrKysrKy0tDQo+PiBody9hcm0v
aW14OG1wLWV2ay5jICAgICAgICB8IDE1ICsrKysrKysrKysrKystLQ0KPj4gaHcvYXJtL2lu
dGVncmF0b3JjcC5jICAgICAgfCAxNiArKysrKysrKysrKysrLS0tDQo+PiBody9hcm0va3pt
LmMgICAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKy0tDQo+PiBody9hcm0vbWNpbXg2
dWwtZXZrLmMgICAgICB8IDE1ICsrKysrKysrKysrKystLQ0KPj4gaHcvYXJtL21jaW14N2Qt
c2FicmUuYyAgICAgfCAxNSArKysrKysrKysrKysrLS0NCj4+IGh3L2FybS9tc2YyLXNvbS5j
ICAgICAgICAgIHwgMTMgKysrKysrKysrKystLQ0KPj4gaHcvYXJtL211c2ljcGFsLmMgICAg
ICAgICAgfCAxNiArKysrKysrKysrKysrLS0tDQo+PiBody9hcm0vbmV0ZHVpbm8yLmMgICAg
ICAgICB8IDEzICsrKysrKysrKysrLS0NCj4+IGh3L2FybS9uZXRkdWlub3BsdXMyLmMgICAg
IHwgMTMgKysrKysrKysrKystLQ0KPj4gaHcvYXJtL29saW1leC1zdG0zMi1oNDA1LmMgfCAx
MyArKysrKysrKysrKy0tDQo+PiBody9hcm0vb3JhbmdlcGkuYyAgICAgICAgICB8IDEzICsr
KysrKysrKysrLS0NCj4+IGh3L2FybS9zYWJyZWxpdGUuYyAgICAgICAgIHwgMTQgKysrKysr
KysrKysrLS0NCj4+IGh3L2FybS9zdG0zMnZsZGlzY292ZXJ5LmMgIHwgMTMgKysrKysrKysr
KystLQ0KPj4gaHcvY29yZS9udWxsLW1hY2hpbmUuYyAgICAgfCAxNCArKysrKysrKysrKyst
LQ0KPj4gMTggZmlsZXMgY2hhbmdlZCwgMjEzIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9u
cygtKQ0KPiANCj4gVGhpcyBpcyBtdWNoIGxvbmdlciBhbmQgZXhwb3NpbmcgYm9pbGVyIHBs
YXRlIGNvZGUuIElzIGl0IHBvc3NpYmxlIGluc3RlYWQNCj4gdG8gY2hhbmdlIERFRklORV9N
QUNISU5FIG9yIGFkZCBhbm90aGVyIHNpbWlsYXIgbWFjcm8gdGhhdCBhbGxvd3MNCj4gc3Bl
Y2lmeWluZyBtb3JlIGRldGFpbHMgc3VjaCBhcyBjbGFzcyBzdGF0ZSB0eXBlIGFuZCBpbnRl
cmZhY2VzIGxpa2Ugd2UNCj4gYWxyZWFkeSBoYXZlIGZvciBPQkpFQ1RfREVGSU5FIG1hY3Jv
cyB0byBrZWVwIHRoZSBib2lsZXIgcGxhdGUgY29kZSBoaWRkZW4NCj4gYW5kIG5vdCBicmlu
ZyBpdCBiYWNrPw0KPiANCg0KV2UgY2FuIGV2ZW50dWFsbHkgbW9kaWZ5IERFRklORV9NQUNI
SU5FUywgdG8gdGFrZSBhbiBhZGRpdGlvbmFsIA0KaW50ZXJmYWNlcyBwYXJhbWV0ZXIsIGFu
ZCByZXBsYWNlIGFsbCBjYWxsIHNpdGVzLCB3aXRoIGFuIGVtcHR5IGxpc3QgZm9yIA0KYWxs
IGJvYXJkcyBvdXQgb2YgaHcvYXJtLg0KDQpBcyBsb25nIGFzIHdlIGF2b2lkIHNvbWV0aGlu
ZyBsaWtlOg0KREVGSU5FX01BQ0hJTkVTX1dJVEhfSU5URVJGQUNFXzEoLi4uKQ0KREVGSU5F
X01BQ0hJTkVTX1dJVEhfSU5URVJGQUNFXzIoLi4uKQ0KREVGSU5FX01BQ0hJTkVTX1dJVEhf
SU5URVJGQUNFXzMoLi4uKQ0KSSdtIG9rIHdpdGgga2VlcGluZyB0aGUgbWFjcm8uDQoNCldv
dWxkIHRoYXQgd29yayBmb3IgeW91IGZvbGtzPw0KDQo+IFJlZ2FyZHMsDQo+IEJBTEFUT04g
Wm9sdGFuDQoNCg==

