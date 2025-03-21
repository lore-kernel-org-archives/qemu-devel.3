Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9512BC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgFG-00061l-7C; Fri, 21 Mar 2025 13:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgFE-00061P-Bq
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:33:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgEx-0001ub-Kz
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:33:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223a7065ff8so15696585ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742578382; x=1743183182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KzVumZvZ0J1E0zr4RYJkadsPBMalPHB3dSzv/q7002o=;
 b=TvgmEFAlAIwhNU7yM/HbHOsakv9+KjNV5pt0auJFWbKHfqCarqRbVF8G2ryn1VClrW
 gLu0Nz04sKjS18Z1lzyAtJOSMGdfd7yOI/jjN5jms66J8zu6EcRWoN5+DUGuV3sobph5
 s39/qDmMsmcUhXM6I8DwEuVr2yACTuOhcgosaA4E1a46h/hM1bkU0wzTp3DjX5sNMn70
 CMB3pfjSJanjhirOF9RZPQhCkeEE3okClKz2LDEwGOxP4V5id0w9Ph/N05pg/QSOvBH3
 u2qs4cg+5JprNNx9s+v3MfjLtBGY06BMN6ZI0Zs5HU37QHjBZqmTzi+QNE+fdpEO16mp
 y7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742578382; x=1743183182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KzVumZvZ0J1E0zr4RYJkadsPBMalPHB3dSzv/q7002o=;
 b=oiORKvgABVZPO4FvwqjMTemejFHcU7LU99/h3KH3cAw+XwWNQn4XANF+32vu8AS3cK
 hivo31LHIlAmbcdc/6nZFiQdWx58pZTCRq0ryEFPEm7q0oX1gMKvXRb3BBgiofOyKnUQ
 hSuGfBfTID7mIhZNZBGvluHcSPsXlZdi6pAeu+9ER/2kpHQ2myKQv5zHQ9KT44Jmp8iL
 aAozTkSGSDevAtIf8gGrgq7ZLY/DGcVvpjxwQaJghQH7uFxV5Kf0OPGvju9dDEnY0zMO
 Dh4pcCOuBBMBrmXsub7OAjDh6fzSUy/+n8fqdV3jeZ+zMHky/o00FvnnYaOR30BdrGDC
 REUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeWlLPEDgg2PbyWV4WwZUMYyxjTQag2fGtgrlMz6z7ahVglEyvSlzIXRoqw7AomQjpFgjxgl5BRcFg@nongnu.org
X-Gm-Message-State: AOJu0Yy/0Z26lbcGY4YoR0KMtN7j7LUYWJx/+fYp7wuyn2TiDlDOdQ9m
 CRb4i+wfpz1F6h/0jsodD9EmAkEFdkmrLl40mTwIf0cB8pMWKCR+GEHHOYD/gCk=
X-Gm-Gg: ASbGncvKSvszJ/qP2db/MGHYaIn5BfbrU/ka2n7dxCWhnPeDp42Sg2WD20upLvac13/
 ztkG9eSz6HUUh4omL3v7ZhJp5hkVRgI4CeaxiVQmAHtQT2yCgtpZt/3kWupOz2blA5DpETxa/F9
 sWcozouKUB8CkA2LvbjqXYIvCguDNDWPYBq7LzvwbbD0Qq7tlyEp9j0zOFDXS+yXitqhtjBmAlt
 UI+sQyOqHSUIG8v2I1aIXAuIKjv8AQSvnWZWtaXBF9MLfGCfAvLkgoUMED9njzZqBAVe3owbYbQ
 ybmwgTuU0dxfPPzPwdesVt9Bb9bKEqJgFwgMaDlwGQ9Pv5qvI+IkEEXwQV4L31CCwjcjkg==
X-Google-Smtp-Source: AGHT+IFf7mQTdHaxDFKZnvl3CjZwCuV4G2eIyeYWS+X8gh1GwypWDYKBeVNpTpy3GDKOtOLf5ou/Yg==
X-Received: by 2002:a05:6a21:1:b0:1f5:9330:29fe with SMTP id
 adf61e73a8af0-1fe42f2c9ddmr6953945637.17.1742578382060; 
 Fri, 21 Mar 2025 10:33:02 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd613bsm2309504b3a.62.2025.03.21.10.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 10:33:01 -0700 (PDT)
Message-ID: <86dac98c-75ad-4aec-b03d-32c9e8a59e16@linaro.org>
Date: Fri, 21 Mar 2025 10:33:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/4] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250321155925.96626-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

T24gMy8yMS8yNSAwODo1OSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IHFl
bXVfdGNnX210dGNnX2VuYWJsZWQoKSBpcyBzcGVjaWZpYyB0byAxLyBUQ0cgYW5kDQo+IDIv
IHN5c3RlbSBlbXVsYXRpb24uIE1vdmUgdGhlIHByb3RvdHlwZSBkZWNsYXJhdGlvbg0KPiB0
byAic3lzdGVtL3RjZy5oIiwgcmVkdWNpbmcgJ210dGNnX2VuYWJsZWQnIHZhcmlhYmxlDQo+
IHNjb3BlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
PHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBpbmNsdWRlL2h3L2NvcmUvY3B1Lmgg
ICAgICB8ICA5IC0tLS0tLS0tLQ0KPiAgIGluY2x1ZGUvc3lzdGVtL3RjZy5oICAgICAgIHwg
IDggKysrKysrKysNCj4gICBhY2NlbC90Y2cvdGNnLWFsbC5jICAgICAgICB8IDExICsrKysr
KysrKystDQo+ICAgdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmMgfCAgMSArDQo+ICAgdGNn
L3JlZ2lvbi5jICAgICAgICAgICAgICAgfCAgNCArKystDQo+ICAgNSBmaWxlcyBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2h3L2NvcmUvY3B1LmggYi9pbmNsdWRlL2h3L2NvcmUvY3B1LmgNCj4gaW5k
ZXggNWQxMWQyNjU1NmEuLjU0NTcwZDIxYWVhIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3
L2NvcmUvY3B1LmgNCj4gKysrIGIvaW5jbHVkZS9ody9jb3JlL2NwdS5oDQo+IEBAIC01OTcs
MTUgKzU5Nyw2IEBAIGV4dGVybiBDUFVUYWlsUSBjcHVzX3F1ZXVlOw0KPiAgIA0KPiAgIGV4
dGVybiBfX3RocmVhZCBDUFVTdGF0ZSAqY3VycmVudF9jcHU7DQo+ICAgDQo+IC0vKioNCj4g
LSAqIHFlbXVfdGNnX210dGNnX2VuYWJsZWQ6DQo+IC0gKiBDaGVjayB3aGV0aGVyIHdlIGFy
ZSBydW5uaW5nIE11bHRpVGhyZWFkIFRDRyBvciBub3QuDQo+IC0gKg0KPiAtICogUmV0dXJu
czogJXRydWUgaWYgd2UgYXJlIGluIE1UVENHIG1vZGUgJWZhbHNlIG90aGVyd2lzZS4NCj4g
LSAqLw0KPiAtZXh0ZXJuIGJvb2wgbXR0Y2dfZW5hYmxlZDsNCj4gLSNkZWZpbmUgcWVtdV90
Y2dfbXR0Y2dfZW5hYmxlZCgpIChtdHRjZ19lbmFibGVkKQ0KPiAtDQo+ICAgLyoqDQo+ICAg
ICogY3B1X3BhZ2luZ19lbmFibGVkOg0KPiAgICAqIEBjcHU6IFRoZSBDUFUgd2hvc2Ugc3Rh
dGUgaXMgdG8gYmUgaW5zcGVjdGVkLg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXN0ZW0v
dGNnLmggYi9pbmNsdWRlL3N5c3RlbS90Y2cuaA0KPiBpbmRleCA3MzIyOTY0OGM2My4uNzYy
MmRjZWEzMDIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvc3lzdGVtL3RjZy5oDQo+ICsrKyBi
L2luY2x1ZGUvc3lzdGVtL3RjZy5oDQo+IEBAIC0xNyw0ICsxNywxMiBAQCBleHRlcm4gYm9v
bCB0Y2dfYWxsb3dlZDsNCj4gICAjZGVmaW5lIHRjZ19lbmFibGVkKCkgMA0KPiAgICNlbmRp
Zg0KPiAgIA0KPiArLyoqDQo+ICsgKiBxZW11X3RjZ19tdHRjZ19lbmFibGVkOg0KPiArICog
Q2hlY2sgd2hldGhlciB3ZSBhcmUgcnVubmluZyBNdWx0aVRocmVhZCBUQ0cgb3Igbm90Lg0K
PiArICoNCj4gKyAqIFJldHVybnM6ICV0cnVlIGlmIHdlIGFyZSBpbiBNVFRDRyBtb2RlICVm
YWxzZSBvdGhlcndpc2UuDQo+ICsgKi8NCj4gK2Jvb2wgcWVtdV90Y2dfbXR0Y2dfZW5hYmxl
ZCh2b2lkKTsNCj4gKw0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL3Rj
Zy1hbGwuYyBiL2FjY2VsL3RjZy90Y2ctYWxsLmMNCj4gaW5kZXggY2I2MzJjYzhjYzcuLmQ3
NWVjZjUzMWI2IDEwMDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvdGNnLWFsbC5jDQo+ICsrKyBi
L2FjY2VsL3RjZy90Y2ctYWxsLmMNCj4gQEAgLTM4LDYgKzM4LDcgQEANCj4gICAjaW5jbHVk
ZSAiaHcvcWRldi1jb3JlLmgiDQo+ICAgI2Vsc2UNCj4gICAjaW5jbHVkZSAiaHcvYm9hcmRz
LmgiDQo+ICsjaW5jbHVkZSAic3lzdGVtL3RjZy5oIg0KPiAgICNlbmRpZg0KPiAgICNpbmNs
dWRlICJpbnRlcm5hbC1jb21tb24uaCINCj4gICAjaW5jbHVkZSAiY3B1LXBhcmFtLmgiDQo+
IEBAIC01OCw2ICs1OSwxNSBAQCB0eXBlZGVmIHN0cnVjdCBUQ0dTdGF0ZSBUQ0dTdGF0ZTsN
Cj4gICBERUNMQVJFX0lOU1RBTkNFX0NIRUNLRVIoVENHU3RhdGUsIFRDR19TVEFURSwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9UQ0dfQUNDRUwpDQo+ICAgDQo+ICtz
dGF0aWMgYm9vbCBtdHRjZ19lbmFibGVkOw0KPiArDQo+ICsjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkNCj4gK2Jvb2wgcWVtdV90Y2dfbXR0Y2dfZW5hYmxlZCh2b2lkKQ0KPiArew0KPiAr
ICAgIHJldHVybiBtdHRjZ19lbmFibGVkOw0KPiArfQ0KPiArI2VuZGlmDQo+ICsNCj4gICAv
Kg0KPiAgICAqIFdlIGRlZmF1bHQgdG8gZmFsc2UgaWYgd2Uga25vdyBvdGhlciBvcHRpb25z
IGhhdmUgYmVlbiBlbmFibGVkDQo+ICAgICogd2hpY2ggYXJlIGN1cnJlbnRseSBpbmNvbXBh
dGlibGUgd2l0aCBNVFRDRy4gT3RoZXJ3aXNlIHdoZW4gZWFjaA0KPiBAQCAtOTcsNyArMTA3
LDYgQEAgc3RhdGljIHZvaWQgdGNnX2FjY2VsX2luc3RhbmNlX2luaXQoT2JqZWN0ICpvYmop
DQo+ICAgI2VuZGlmDQo+ICAgfQ0KPiAgIA0KPiAtYm9vbCBtdHRjZ19lbmFibGVkOw0KPiAg
IGJvb2wgb25lX2luc25fcGVyX3RiOw0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgdGNnX2luaXRf
bWFjaGluZShNYWNoaW5lU3RhdGUgKm1zKQ0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2
L3RjZy90Y2ctY3B1LmMgYi90YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuYw0KPiBpbmRleCA2
MGEyNmFjYzUwMy4uNWNjZDdiOWRjMDcgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90
Y2cvdGNnLWNwdS5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jDQo+IEBA
IC0zNSw2ICszNSw3IEBADQo+ICAgI2luY2x1ZGUgInRjZy90Y2cuaCINCj4gICAjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkNCj4gICAjaW5jbHVkZSAiaHcvYm9hcmRzLmgiDQo+ICsjaW5j
bHVkZSAic3lzdGVtL3RjZy5oIg0KPiAgICNlbmRpZg0KPiAgIA0KPiAgIC8qIEhhc2ggdGhh
dCBzdG9yZXMgdXNlciBzZXQgZXh0ZW5zaW9ucyAqLw0KPiBkaWZmIC0tZ2l0IGEvdGNnL3Jl
Z2lvbi5jIGIvdGNnL3JlZ2lvbi5jDQo+IGluZGV4IDQ3OGVjMDUxYzRiLi41NmQyZTk4ODcx
OSAxMDA2NDQNCj4gLS0tIGEvdGNnL3JlZ2lvbi5jDQo+ICsrKyBiL3RjZy9yZWdpb24uYw0K
PiBAQCAtMzQsNyArMzQsOSBAQA0KPiAgICNpbmNsdWRlICJleGVjL3RyYW5zbGF0aW9uLWJs
b2NrLmgiDQo+ICAgI2luY2x1ZGUgInRjZy1pbnRlcm5hbC5oIg0KPiAgICNpbmNsdWRlICJo
b3N0L2NwdWluZm8uaCINCj4gLQ0KPiArI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+ICsj
aW5jbHVkZSAic3lzdGVtL3RjZy5oIg0KPiArI2VuZGlmDQo+ICAgDQo+ICAgLyoNCj4gICAg
KiBMb2NhbCBzb3VyY2UtbGV2ZWwgY29tcGF0aWJpbGl0eSB3aXRoIFVuaXguDQoNClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+
DQoNCg==

