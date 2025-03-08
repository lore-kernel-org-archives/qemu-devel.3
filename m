Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31ABC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 18:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzMz-0002OU-UV; Sat, 08 Mar 2025 13:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqzMy-0002Kp-JJ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 13:57:56 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqzMx-00035r-08
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 13:57:56 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso51103215ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 10:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460273; x=1742065073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UP8nMfnI6L5nI/zOo2DIo9zJMX+EmGrPKRQFaN9yBBQ=;
 b=tzo3qskN5j7pty7CjnSQriBTT7d1BIRtQ+X/1Ou6ObhcWfmXpdtYdwrDPdAw1xeaMV
 eRXltqYE3iX3wCFdytKMdO9HZCR+DBS7AO9DSSoFvfqIMpp1x35MkH8arL7EfCK1PLHd
 nFnN4mVIt6tcwwkgvUavevvtoXgmk4mCj1+m6ZvOpYCMzOOROcT0UHIT8Vm0EM3huWzJ
 qLQVM/XLTNFVhDcviz5HyOWyXmK0v4tgA0KKlL0yjnRplKtc/xn/toaQKhgpUUt9c+Dw
 SLRMAQIG3vT0DhqPs3YvDm3LqUFLTxbJhPOaBRsSQkXitdZU12tO4HAl4EbwzxAFBvJz
 KosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460273; x=1742065073;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UP8nMfnI6L5nI/zOo2DIo9zJMX+EmGrPKRQFaN9yBBQ=;
 b=MQIg28XpQ63Rxg+va36A4J9Gkp9KXVhOp440VVvMzq//hc+ZYrpHHvDw3Zd6x/eYvS
 Hr/TZ3dkjx3763cuebFr1S+9+AyO/jXym8onl6xW03/5LYX2A6Z3jzBxLYBmBvdZXIG0
 1mKaJpl/FxcCiXXHwg47IkH7azwyWtxRKIz0LSuyfqIodVHgWmHZhCqgEU3XIHjhut1R
 4gHsjaRdhMgjXHAykPZqCS1QnVI5xgTOhdsYnDkeWEFADPy5LjVHdmb76a9kzCQGG8rk
 67XZBMYdYAdylyINCPxgeKmsA3xMaCrSUP4s0wxC5EW7ar17V7DEprF/k4FnxVduKtLA
 o8XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkrl9iEibYjKD1CQhuZcxOfHjjGIcEt6WxeuNiN4+t4oBfT3PMHlw6zdV6wsgOiPGPVZu+Tg3sEQGO@nongnu.org
X-Gm-Message-State: AOJu0YySsU5hm/rzsNa0gFrrKj6HDj2asYjhaS5l9GHDUHbUw3Pl5KBn
 jmXTRhNtEc10rM1AUaJpvaNLrgxk6V+ohGoVUnlwiGONKRW8fOGtHrJHF3nBs6Y=
X-Gm-Gg: ASbGnctEowhJ4vorxqtvwEkQgyYw6CttXJdGw30tKKbhI8pmrm/xO/WXGugy1Jzt+cV
 YwzHV6fLhwvxPIrkOkaIsuGXRQPuQy6DV+ceX+p9OMGSMBIBlUuP+YA9tOCgKXHCCVKTea5jJUH
 Kh/FwhnXr3lmpgtQEd31y9DFT9CzK/qQjHVBjT8n09uMa1um86fB108uqpolorwyn7sJ6ZGER1p
 NJa6O+s6eMUFgHeIwFirqurnK5ZOYENt+ACkfuTh8RGCuIIUBeswPpuSWaqiU6Uea8OoK/HTnw5
 nVKj8OoZHfyNB21B6Z/IksJHhNrMvdrXUDhJxBnynl8stt2OuFSBWJUqcQ==
X-Google-Smtp-Source: AGHT+IHXXXZR8mrHgTcO3UG4xBrolJA1B/9jj4HgdKk9SL5PR5Zt5mHu6skFXLnVMn+MY/zu1p3iHg==
X-Received: by 2002:a17:903:22c8:b0:220:cfb7:56eb with SMTP id
 d9443c01a7336-2246456b6d5mr53149225ad.26.1741460272647; 
 Sat, 08 Mar 2025 10:57:52 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ea7f9sm49881675ad.84.2025.03.08.10.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Mar 2025 10:57:52 -0800 (PST)
Message-ID: <f0dab1a3-da51-4aa8-9f99-0b1dad54b686@linaro.org>
Date: Sat, 8 Mar 2025 10:57:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250307223949.54040-1-philmd@linaro.org>
 <20250307223949.54040-6-philmd@linaro.org>
 <d3d441cb-933d-4ec5-b263-1235d7553a53@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <d3d441cb-933d-4ec5-b263-1235d7553a53@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gMy83LzI1IDIxOjQxLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
Ny8zLzI1IDIzOjM5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+IFVzZSBx
ZW11X2FyY2hfYXZhaWxhYmxlKCkgdG8gY2hlY2sgYXQgcnVudGltZSBpZiBhIHRhcmdldA0K
Pj4gYXJjaGl0ZWN0dXJlIGlzIGJ1aWx0IGluLg0KPj4NCj4+IENvbnNpZGVyIHRoZSBtYXhp
bXVtIGV4dGVudCBzaXplIG9mIGFueSBhcmNoaXRlY3R1cmUgYnVpbHQgaW4uDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8u
b3JnPg0KPj4gLS0tDQo+PiAgICBody92aXJ0aW8vdmlydGlvLW1lbS5jIHwgMjggKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiANCj4+IEBAIC0xNzAsMTMgKzE3MSwy
NCBAQCBzdGF0aWMgYm9vbCB2aXJ0aW9fbWVtX2hhc19zaGFyZWRfemVyb3BhZ2UoUkFNQmxv
Y2sgKnJiKQ0KPj4gICAgICogbmVjZXNzYXJ5IChhcyB0aGUgc2VjdGlvbiBzaXplIGNhbiBj
aGFuZ2UpLiBCdXQgaXQncyBtb3JlIGxpa2VseSB0aGF0IHRoZQ0KPj4gICAgICogc2VjdGlv
biBzaXplIHdpbGwgcmF0aGVyIGdldCBzbWFsbGVyIGFuZCBub3QgYmlnZ2VyIG92ZXIgdGlt
ZS4NCj4+ICAgICAqLw0KPj4gLSNpZiBkZWZpbmVkKFRBUkdFVF9YODZfNjQpIHx8IGRlZmlu
ZWQoVEFSR0VUX0kzODYpIHx8IGRlZmluZWQoVEFSR0VUX1MzOTBYKQ0KPj4gLSNkZWZpbmUg
VklSVElPX01FTV9VU0FCTEVfRVhURU5UICgyICogKDEyOCAqIE1pQikpDQo+PiAtI2VsaWYg
ZGVmaW5lZChUQVJHRVRfQVJNKQ0KPj4gLSNkZWZpbmUgVklSVElPX01FTV9VU0FCTEVfRVhU
RU5UICgyICogKDUxMiAqIE1pQikpDQo+PiAtI2Vsc2UNCj4+IC0jZXJyb3IgVklSVElPX01F
TV9VU0FCTEVfRVhURU5UIG5vdCBkZWZpbmVkDQo+PiAtI2VuZGlmDQo+PiArc3RhdGljIHVp
bnQ2NF90IHZpcnRpb19tZW1fdXNhYmxlX2V4dGVudF9zaXplKHZvaWQpDQo+PiArew0KPj4g
KyAgICB1aW50NjRfdCBzaXplID0gMDsNCj4+ICsNCj4+ICsgICAgYXNzZXJ0KHFlbXVfYXJj
aF9hdmFpbGFibGUoUUVNVV9BUkNIX0FSTSB8IFFFTVVfQVJDSF9JMzg2IHwgUUVNVV9BUkNI
X1MzOTBYKSk7DQo+IA0KPiBJJ20gbm90IHN1cmUgdGhpcyBhc3NlcnRpb24gaXMgZG9pbmcg
d2hhdCBJIHRob3VnaHQgaXQnZCBkby4NCj4gDQo+IEZvciBleGFtcGxlLCBidWlsZGluZyB3
aXRoIC0tdGFyZ2V0LWxpc3Q9YWFyY2g2NC1zb2Z0bW11LHJpc2N2MzItc29mdG1tdSwNCj4g
dGhpcyBkZXZpY2UgaXMgbm93IGxpbmtlZCBpbi4gSG93ZXZlciwgcmlzY3YzMiBtYWNoaW5l
cyB3b24ndCBiZSBhYmxlDQo+IHRvIHBsdWcgaXQgdW50aWwgdGhleSBhbGxvdyBUWVBFX1ZJ
UlRJT19NRF9QQ0kgaW4gc29tZSBvZiB0aGVpcg0KPiBIb3RwbHVnSGFuZGxlckNsYXNzIGhh
bmRsZXJzLiBTdGlsbCBJJ2QgbGlrZSB0byBjYXRjaCB0aGlzIGNhc2UgaGVyZQ0KPiB0byBh
dm9pZCBiYWQgc3VycHJpc2VzLg0KPiANCg0KV2l0aCB0aGUgc2luZ2xlIGJpbmFyeSwgYSBs
b3Qgb2YgZGV2aWNlcyB3aWxsIGJlIGxpbmtlZCBpbiwgZXZlbiB0aG91Z2ggDQp0aGV5IHdv
bid0IGJlIHVzZWQuIFRoZXJlIGlzIG5vIHNwZWNpZmljIHZlcnkgc3BlY2lmaWMgaGVyZSwg
YW5kIA0KZGVmaW5pdGVseSBzb21ldGhpbmcgd2UgY2FuIHRhY2tsZSBsYXRlciwgb25jZSB3
ZSBhcmUgYWJsZSB0byBsaW5rIGEgDQpzaW5nbGUgYmluYXJ5Lg0KDQo+PiArICAgIC8qDQo+
PiArICAgICAqIEZJWE1FOiBXZSBzaG91bGQgdXNlIHRoZSBtYXhpbXVtIG9mIGluc3RhbnRp
YXRlZCB2Q1BVcyBBUkNILCBidXQNCj4+ICsgICAgICogICAgICAgIGZvciBub3cgaXQgaXMg
ZWFzaWVyIHRvIHRha2UgdGhlIG1heGltdW0gb2YgYW55IEFSQ0ggYnVpbHQgaW4uDQo+PiAr
ICAgICAqLw0KPj4gKyAgICBpZiAocWVtdV9hcmNoX2F2YWlsYWJsZShRRU1VX0FSQ0hfSTM4
NiB8IFFFTVVfQVJDSF9TMzkwWCkpIHsNCj4+ICsgICAgICAgIHNpemUgPSBNQVgoc2l6ZSwg
MiAqIDEyOCAqIE1pQik7DQo+PiArICAgIH0NCj4+ICsgICAgaWYgKHFlbXVfYXJjaF9hdmFp
bGFibGUoUUVNVV9BUkNIX0FSTSkpIHsNCj4+ICsgICAgICAgIHNpemUgPSBNQVgoc2l6ZSwg
MiAqIDUxMiAqIE1pQik7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0dXJuIHNpemU7
DQo+PiArfQ0KPiANCg0K

