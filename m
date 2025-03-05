Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58597C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tps0A-0008RS-Cv; Wed, 05 Mar 2025 11:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tprzz-0008Pt-N4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:53:35 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tprzx-000666-Nb
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:53:35 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2233622fdffso12377155ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741193612; x=1741798412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RohP8o8uPCnosArPUo8AI33ojn5YxVBIamd26sWXm7o=;
 b=vdPWMEEXKXU1dhHBdNDYhi/RQBNXGsfiQn/KEGQSrzwaW0jBiWygZgd7oNHslbh0+P
 rU83bVV40g99z9LIMQYmWmDXvnotW6c3pPMWBGZhGscWIk7SHsA70ULcjpctvC580j1p
 jDMKEcF0vZxSwkaD+jbjukAdEOgbBD+GoyGhnQ8L8sPKiffGK4sVGl8ovCHGwIt3Ze28
 lL+I8DT3GbBsJVT9/0v1EL1tGoVSD2rowmD0af8FiTzJliEQ3QpvZ0Se8V3Oi+AKZ1WC
 NtikXOjPq3SqFRPMkFCmHJPy+4VM33YrtvH4EPGCa5/yTq7nbUUtHSWFpu0CISlrFviQ
 PtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193612; x=1741798412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RohP8o8uPCnosArPUo8AI33ojn5YxVBIamd26sWXm7o=;
 b=jth3ISjzOHaxIXHOUWhkZT8iYD41mLXuklDgT4Nd9V05Uv3NPpOczvAmqQ0bhVoPDT
 QWBHZQK5cWaNshFnYKJzg4GdF9ymrrmfOIZ+WzCwcWl1aW3CZK5jd8vJKtlZEzGj6+Dm
 43xg7LQzYtI2mVOGJSaXDvOFT3v/uh1x0bFYaViGoKPsI2bUkutTc+PylMfpndbKZXK0
 QVqIfSAqjO6a7GH2Vtensa1ed3fUbpc351f9yev1Sc3w8x92UP4w/K0TRK6km+NfdxM8
 odhkuMu4KfUvEGg7fJcHNo2K0zqhj8HFMyLpPJnrlgdXTqbtmq8iTOIrDnoVp/EykmyQ
 Yuog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVngLrT8feV7D3m1qt8QqHoS6k/UkXeyw+3zZrbxl+XZDGpOPOiezLMCVx56wFrJp3uejJpNBwRnn+h@nongnu.org
X-Gm-Message-State: AOJu0YzfItia4VhXQseR0Mf79KV8ZlDkIIPSanOkSXa9VGGhN8tqbbgb
 ynwpQQoQumD48STecQc7cnUL2TibbprdZzf7w44WvAJ93mKW86jHG96oCxZ9ltg=
X-Gm-Gg: ASbGncu/4kWk7MVVvQ6m/vI1OrEQe3AYXDM8mY/1J+uXmmd1nxQCJt+u8+wKf8KUQmD
 oup7RxABzUGwU5iYvS2MXgc+DE7KiveZY+90z8cbg4pA4G8qJ7jXSnsjabOCZf5hT5ythv4SP7g
 UNuHE1WjEKMjDutZFeaUAYQBNbif+w2o/fOKO0PrcVoQL/Q/Wrn8/2HPoj3JBuYCvPZizswFbOu
 u2sX/6Igm1KdB6usUYKK/AEds2Gl4PbF+8FtotQQV0/ly1F0tLdWxQ3PuK2ot6tD0P2EWaQxA6W
 vY3j7AebJkd+fdVEM7f0Dke2gC+pQYKtXqfSvQMy05kN+MQ86ijxjXX4qQ==
X-Google-Smtp-Source: AGHT+IGwuwXpbQoV32VUYAgJCRkhV4DwLSdrQU1r29u0W8aZnpCb1dm/xM+kCHA5sIGq7B7mVTwsqg==
X-Received: by 2002:a05:6a21:700c:b0:1f3:4261:852c with SMTP id
 adf61e73a8af0-1f3495750a2mr7273106637.28.1741193612148; 
 Wed, 05 Mar 2025 08:53:32 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73661f73895sm5706209b3a.143.2025.03.05.08.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:53:31 -0800 (PST)
Message-ID: <942e2191-0952-4838-bbc5-913528d91f16@linaro.org>
Date: Wed, 5 Mar 2025 08:53:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] hw/arm: Register target-specific QOM types at
 runtime
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250305161248.54901-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMy81LzI1IDA4OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gSW4g
cHJlcGFyYXRpb24gb2YgaGF2aW5nIGEgc2luZ2xlIGJpbmFyeSBmb3IgYm90aCBBUk0gYW5k
DQo+IEFhcmNoNjQgdGFyZ2V0cywgdW5pZnkgcmFzcGkgJiBhc3BlZWQgYnkgcmVwbGFjaW5n
IHRoZQ0KPiBjb21waWxlLXRpbWUgVEFSR0VUX0FBUkNINjQgY2hlY2sgYnkgYSBRT00gcnVu
dGltZSBjYWxsDQo+IG9uIGxlZ2FjeV9iaW5hcnlfaXNfNjRiaXQoKS4NCj4gDQo+IE5vIGJl
aGF2aW9yIGNoYW5nZSB3aXRoIGN1cnJlbnQgYmluYXJpZXM6DQo+IA0KPiAgICAkIC4vcWVt
dS1zeXN0ZW0tYXJtIC1NIGhlbHAgfCBmZ3JlcCByYXNwaQ0KPiAgICByYXNwaTAgICAgICAg
ICAgICAgICBSYXNwYmVycnkgUGkgWmVybyAocmV2aXNpb24gMS4yKQ0KPiAgICByYXNwaTFh
cCAgICAgICAgICAgICBSYXNwYmVycnkgUGkgQSsgKHJldmlzaW9uIDEuMSkNCj4gICAgcmFz
cGkyYiAgICAgICAgICAgICAgUmFzcGJlcnJ5IFBpIDJCIChyZXZpc2lvbiAxLjEpDQo+IA0K
PiAgICAkIC4vcWVtdS1zeXN0ZW0tYWFyY2g2NCAtTSBoZWxwIHwgZmdyZXAgcmFzcGkNCj4g
ICAgcmFzcGkwICAgICAgICAgICAgICAgUmFzcGJlcnJ5IFBpIFplcm8gKHJldmlzaW9uIDEu
MikNCj4gICAgcmFzcGkxYXAgICAgICAgICAgICAgUmFzcGJlcnJ5IFBpIEErIChyZXZpc2lv
biAxLjEpDQo+ICAgIHJhc3BpMmIgICAgICAgICAgICAgIFJhc3BiZXJyeSBQaSAyQiAocmV2
aXNpb24gMS4xKQ0KPiAgICByYXNwaTNhcCAgICAgICAgICAgICBSYXNwYmVycnkgUGkgM0Er
IChyZXZpc2lvbiAxLjApDQo+ICAgIHJhc3BpM2IgICAgICAgICAgICAgIFJhc3BiZXJyeSBQ
aSAzQiAocmV2aXNpb24gMS4yKQ0KPiAgICByYXNwaTRiICAgICAgICAgICAgICBSYXNwYmVy
cnkgUGkgNEIgKHJldmlzaW9uIDEuNSkNCj4gDQoNClRvIHNlZSBhbiBlZmZlY3Qgb24gdGhv
c2UgY2hhbmdlcywgd2Ugc2hvdWxkIGlkZWFsbHkgbWFrZSBzdXJlIHRob3NlIA0KZmlsZXMg
Y2FuIGNvbXBpbGUgd2hpbGUgYmVpbmcgY29tbW9uIChpbiBtZXNvbi5idWlsZCBzeXN0ZW1f
c3MpLCBzbyB3ZSANCmFyZSBzdXJlIHRoZXkgZG9uJ3QgZGVwZW5kIG9uIHRhcmdldCBkZWZp
bmUgYW55bW9yZS4NCg0KPiBCYXNlZC1vbjogPDIwMjUwMzA1MTUzOTI5LjQzNjg3LTEtcGhp
bG1kQGxpbmFyby5vcmc+DQo+IA0KPiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAoNCk6DQo+
ICAgIHFvbTogSW50cm9kdWNlIFR5cGVJbmZvOjpyZWdpc3RlcmFibGUoKSBjYWxsYmFjaw0K
PiAgICBody9hcm0vcmFzcGk6IFJlcGxhY2UgVEFSR0VUX0FBUkNINjQgYnkgbGVnYWN5X2Jp
bmFyeV9pc182NGJpdCgpDQo+ICAgIGh3L2FybS9hc3BlZWQ6IFJlcGxhY2UgVEFSR0VUX0FB
UkNINjQgYnkgbGVnYWN5X2JpbmFyeV9pc182NGJpdCgpDQo+ICAgIGh3L3BwYzogUmVtb3Zl
IFRBUkdFVF9QUEM2NCB1c2UgaW4gcHBjX2NyZWF0ZV9wYWdlX3NpemVzX3Byb3AoKQ0KPiAN
Cj4gICBpbmNsdWRlL3FvbS9vYmplY3QuaCB8IDEgKw0KPiAgIGh3L2FybS9hc3BlZWQuYyAg
ICAgIHwgOCArKy0tLS0tLQ0KPiAgIGh3L2FybS9iY20yODM2LmMgICAgIHwgNiArKy0tLS0N
Cj4gICBody9hcm0vcmFzcGkuYyAgICAgICB8IDcgKysrLS0tLQ0KPiAgIGh3L3BwYy9mZHQu
YyAgICAgICAgIHwgNSArKystLQ0KPiAgIHFvbS9vYmplY3QuYyAgICAgICAgIHwgNCArKysr
DQo+ICAgcW9tL3RyYWNlLWV2ZW50cyAgICAgfCAxICsNCj4gICA3IGZpbGVzIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCg0K

