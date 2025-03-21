Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BFBC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgPp-0000rw-SJ; Fri, 21 Mar 2025 13:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgPi-0000ox-Th
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:44:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgPg-0006JI-F3
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:44:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-225df540edcso70710615ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742579047; x=1743183847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Za8Rfata/87/pFSY+a1ow0zqOmujqb8k6uqizHtIpjE=;
 b=rP1rl+nIO/Sed+b+6MIgvj8YAM6wvTBmX8uyEQZuoZUdQUEfGZCzZLBC1mL+Lxbv/y
 45euELh+jufDUcTN3dx9XzTxA3mNvyCiGSJvDztuFKVGOc2sfEaAVRjZy1g5lI7fG5uZ
 jX/dq/jBIKf3DUtIlXvZIDau2LpkXFWsy8/MElMTxFKRy70Rh924ANyiyj93nPGBCs6n
 ntQBHZNXozDXCsEcJ6uD8TY/R7gKSI+VfWbbnNKFRrbxwq9t0wJMo1nzd3UjES6u6vMX
 r5mNQKvl16Z4V6IRnrl+lGLtAn+HXGa+XrYlH3VPh5qe1YMQ0IG9abD2AtlJKUKXq70G
 KZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742579047; x=1743183847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Za8Rfata/87/pFSY+a1ow0zqOmujqb8k6uqizHtIpjE=;
 b=CizyJ8IurZw3VKEcCZkSU/8rIhp9zWPa8n8hhYoxiJb15rnLeqKqOl4da1cTr7BZv8
 sENgqEFOm2FCAocWY5mh0ED6m1SP97LpqrmcYZExl9jIjZNAzoc2jfYOU6MAXctka0HU
 tb30PaiJHaWM+qHrlzG/wfOl+D19tO4vDJl1u/t2cPIbmUnIKdvUD25Di9O/YhEjJbcr
 v4hCOxcIzCb2xlg9Mp7kkqdIN27qW7QZbikPYPq7u2wrUPAQjO+XhrKi2zW1YZwdNWtC
 hChhQ9CCxvpVtIuK6v9bAV173Rw6BT+BrqOrnXnz19s+e12+7bhGSDiT+iIMhxCOWdDZ
 gcQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrC7g6AgM/9jOx6u+/AJEjOgJPfVIhsp1EP/fsfxTDWiwv+joWwNVuz3LUN7vJ328t/lrZpBVhhdWh@nongnu.org
X-Gm-Message-State: AOJu0Yyai2V8KXGMvraxhTDKGq2lXPQyZpKnX9jtd2nMHprjUUinfdY+
 Cw4+X555qix2yEOj4rb7Qr5wKfZ0RtguGsUqYyZzDqDQX9gBDlo2V0r3MhO9OA78qrSL81AzXW/
 8
X-Gm-Gg: ASbGncug68GTKKcVGasomlIo8LLnOaG2btlJYU7PZVQOsKWhV5eri9fN6JiUEvbpjPj
 yBmzbBg+aFdJrYw+MJlsVZWojJQ299sHtxJzkSv+7Gy3eIyaa/7n6GYaDUzPNEfiXHACXk5WKzx
 Ev5RMRbubuZWD4iqQddcbtjc0f3fPuSUx6OGlq9OxwzUyiDoaNFUGJg05VVvH+WBIaBd3FY3JD0
 MfDW28+UhNsFvbMW8PPFLLsLLDCib+Ysxhtncvuze7+vZ+u+NlUzGO475DcS5DmGPjF/izSydbr
 /EfJ+BjgHFcUS2wE/AO2uL6Pvaxl1mI6x1ReOyx1BclggMfDbY+ywu/bGEU=
X-Google-Smtp-Source: AGHT+IEzUFRIHfZE6dqIpzDUI4EZBVqI8w3S2KasQMwvZwuVE1CF96Pi8J8VJ9RO1g78WczB602FQw==
X-Received: by 2002:a05:6a21:3a8b:b0:1f3:1e5c:c655 with SMTP id
 adf61e73a8af0-1fe427b15ddmr6619427637.6.1742579046869; 
 Fri, 21 Mar 2025 10:44:06 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd5c90sm2344708b3a.51.2025.03.21.10.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 10:44:06 -0700 (PDT)
Message-ID: <5b6baf4f-0b84-4d07-8c3f-d01b9b9a0678@linaro.org>
Date: Fri, 21 Mar 2025 10:44:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/4] tcg: Always define TCG_GUEST_DEFAULT_MO
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250321125737.72839-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gMy8yMS8yNSAwNTo1NywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFdl
IG9ubHkgcmVxdWlyZSB0aGUgVENHX0dVRVNUX0RFRkFVTFRfTU8gZm9yIE1UVENHLWVuYWJs
ZWQNCj4gZnJvbnRlbmRzLCBvdGhlcndpc2Ugd2UgdXNlIGEgZGVmYXVsdCB2YWx1ZSBvZiBU
Q0dfTU9fQUxMLg0KPiANCj4gSW4gb3JkZXIgdG8gc2ltcGxpZnksIHJlcXVpcmUgdGhlIGRl
ZmluaXRpb24gZm9yIGFsbCB0YXJnZXRzLA0KPiBkZWZpbmluZyBpdCBmb3IgaGV4YWdvbiwg
bTY4aywgcngsIHNoNCBhbmQgdHJpY29yZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgdGFy
Z2V0L2hleGFnb24vY3B1LXBhcmFtLmggfCAzICsrKw0KPiAgIHRhcmdldC9tNjhrL2NwdS1w
YXJhbS5oICAgIHwgMyArKysNCj4gICB0YXJnZXQvcngvY3B1LXBhcmFtLmggICAgICB8IDMg
KysrDQo+ICAgdGFyZ2V0L3NoNC9jcHUtcGFyYW0uaCAgICAgfCAzICsrKw0KPiAgIHRhcmdl
dC90cmljb3JlL2NwdS1wYXJhbS5oIHwgMyArKysNCj4gICBhY2NlbC90Y2cvdHJhbnNsYXRl
LWFsbC5jICB8IDQgLS0tLQ0KPiAgIDYgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUtcGFyYW0uaCBiL3RhcmdldC9oZXhhZ29uL2NwdS1wYXJhbS5oDQo+IGluZGV4IDQ1ZWU3
YjQ2NDA5Li4yZDU3ZWE2Y2FmOSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LXBhcmFtLmgNCj4gKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LXBhcmFtLmgNCj4gQEAgLTIz
LDQgKzIzLDcgQEANCj4gICAjZGVmaW5lIFRBUkdFVF9QSFlTX0FERFJfU1BBQ0VfQklUUyAz
Ng0KPiAgICNkZWZpbmUgVEFSR0VUX1ZJUlRfQUREUl9TUEFDRV9CSVRTIDMyDQo+ICAgDQo+
ICsvKiBNVFRDRyBub3QgeWV0IHN1cHBvcnRlZDogcmVxdWlyZSBzdHJpY3Qgb3JkZXJpbmcg
Ki8NCj4gKyNkZWZpbmUgVENHX0dVRVNUX0RFRkFVTFRfTU8gICAgICAgIFRDR19NT19BTEwN
Cj4gKw0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L202OGsvY3B1LXBhcmFt
LmggYi90YXJnZXQvbTY4ay9jcHUtcGFyYW0uaA0KPiBpbmRleCA3YWZiZjZkMzAyZC4uMWE5
MDllYWExM2UgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9tNjhrL2NwdS1wYXJhbS5oDQo+ICsr
KyBiL3RhcmdldC9tNjhrL2NwdS1wYXJhbS5oDQo+IEBAIC0xNyw0ICsxNyw3IEBADQo+ICAg
I2RlZmluZSBUQVJHRVRfUEhZU19BRERSX1NQQUNFX0JJVFMgMzINCj4gICAjZGVmaW5lIFRB
UkdFVF9WSVJUX0FERFJfU1BBQ0VfQklUUyAzMg0KPiAgIA0KPiArLyogTVRUQ0cgbm90IHll
dCBzdXBwb3J0ZWQ6IHJlcXVpcmUgc3RyaWN0IG9yZGVyaW5nICovDQo+ICsjZGVmaW5lIFRD
R19HVUVTVF9ERUZBVUxUX01PICAgICAgICBUQ0dfTU9fQUxMDQo+ICsNCj4gICAjZW5kaWYN
Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yeC9jcHUtcGFyYW0uaCBiL3RhcmdldC9yeC9jcHUt
cGFyYW0uaA0KPiBpbmRleCBlZjE5NzBhMDllOS4uMmNlMTk5MTY0ZDcgMTAwNjQ0DQo+IC0t
LSBhL3RhcmdldC9yeC9jcHUtcGFyYW0uaA0KPiArKysgYi90YXJnZXQvcngvY3B1LXBhcmFt
LmgNCj4gQEAgLTI0LDQgKzI0LDcgQEANCj4gICAjZGVmaW5lIFRBUkdFVF9QSFlTX0FERFJf
U1BBQ0VfQklUUyAzMg0KPiAgICNkZWZpbmUgVEFSR0VUX1ZJUlRfQUREUl9TUEFDRV9CSVRT
IDMyDQo+ICAgDQo+ICsvKiBNVFRDRyBub3QgeWV0IHN1cHBvcnRlZDogcmVxdWlyZSBzdHJp
Y3Qgb3JkZXJpbmcgKi8NCj4gKyNkZWZpbmUgVENHX0dVRVNUX0RFRkFVTFRfTU8gICAgICAg
IFRDR19NT19BTEwNCj4gKw0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3No
NC9jcHUtcGFyYW0uaCBiL3RhcmdldC9zaDQvY3B1LXBhcmFtLmgNCj4gaW5kZXggMmI2ZTEx
ZGQwYWMuLjFiYzkwZDQ2OTVlIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvc2g0L2NwdS1wYXJh
bS5oDQo+ICsrKyBiL3RhcmdldC9zaDQvY3B1LXBhcmFtLmgNCj4gQEAgLTE2LDQgKzE2LDcg
QEANCj4gICAjIGRlZmluZSBUQVJHRVRfVklSVF9BRERSX1NQQUNFX0JJVFMgMzINCj4gICAj
ZW5kaWYNCj4gICANCj4gKy8qIE1UVENHIG5vdCB5ZXQgc3VwcG9ydGVkOiByZXF1aXJlIHN0
cmljdCBvcmRlcmluZyAqLw0KPiArI2RlZmluZSBUQ0dfR1VFU1RfREVGQVVMVF9NTyAgICAg
ICAgVENHX01PX0FMTA0KPiArDQo+ICAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS90YXJnZXQv
dHJpY29yZS9jcHUtcGFyYW0uaCBiL3RhcmdldC90cmljb3JlL2NwdS1wYXJhbS5oDQo+IGlu
ZGV4IDc5MDI0MmVmM2QyLi45MjM0NTkzNzBjYyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Ry
aWNvcmUvY3B1LXBhcmFtLmgNCj4gKysrIGIvdGFyZ2V0L3RyaWNvcmUvY3B1LXBhcmFtLmgN
Cj4gQEAgLTEyLDQgKzEyLDcgQEANCj4gICAjZGVmaW5lIFRBUkdFVF9QSFlTX0FERFJfU1BB
Q0VfQklUUyAzMg0KPiAgICNkZWZpbmUgVEFSR0VUX1ZJUlRfQUREUl9TUEFDRV9CSVRTIDMy
DQo+ICAgDQo+ICsvKiBNVFRDRyBub3QgeWV0IHN1cHBvcnRlZDogcmVxdWlyZSBzdHJpY3Qg
b3JkZXJpbmcgKi8NCj4gKyNkZWZpbmUgVENHX0dVRVNUX0RFRkFVTFRfTU8gICAgICAgIFRD
R19NT19BTEwNCj4gKw0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL3Ry
YW5zbGF0ZS1hbGwuYyBiL2FjY2VsL3RjZy90cmFuc2xhdGUtYWxsLmMNCj4gaW5kZXggODJi
YzE2YmQ1MzUuLmZiOWY4M2RiYmEzIDEwMDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvdHJhbnNs
YXRlLWFsbC5jDQo+ICsrKyBiL2FjY2VsL3RjZy90cmFuc2xhdGUtYWxsLmMNCj4gQEAgLTM0
OSwxMSArMzQ5LDcgQEAgVHJhbnNsYXRpb25CbG9jayAqdGJfZ2VuX2NvZGUoQ1BVU3RhdGUg
KmNwdSwNCj4gICAgICAgdGNnX2N0eC0+dGxiX2R5bl9tYXhfYml0cyA9IENQVV9UTEJfRFlO
X01BWF9CSVRTOw0KPiAgICNlbmRpZg0KPiAgICAgICB0Y2dfY3R4LT5pbnNuX3N0YXJ0X3dv
cmRzID0gVEFSR0VUX0lOU05fU1RBUlRfV09SRFM7DQo+IC0jaWZkZWYgVENHX0dVRVNUX0RF
RkFVTFRfTU8NCj4gICAgICAgdGNnX2N0eC0+Z3Vlc3RfbW8gPSBUQ0dfR1VFU1RfREVGQVVM
VF9NTzsNCj4gLSNlbHNlDQo+IC0gICAgdGNnX2N0eC0+Z3Vlc3RfbW8gPSBUQ0dfTU9fQUxM
Ow0KPiAtI2VuZGlmDQo+ICAgDQo+ICAgIHJlc3RhcnRfdHJhbnNsYXRlOg0KPiAgICAgICB0
cmFjZV90cmFuc2xhdGVfYmxvY2sodGIsIHBjLCB0Yi0+dGMucHRyKTsNCg0KUmV2aWV3ZWQt
Ynk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K


