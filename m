Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F0DE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxbX-0000q7-VT; Thu, 09 Jan 2025 13:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVxbU-0000ph-QC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:50:00 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVxbT-0005M5-2F
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:50:00 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21619108a6bso20862365ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 10:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736448597; x=1737053397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tysOloC1GiDq0Ki1ArIwVbUgf3JCtAzTwhZzTnebE0s=;
 b=kyxg4PRMn9yyqzuR84a2dNfyF/GX3+Uwv1tJ1h8H04e/VcCMvpnXZBePq7SHqiw9L6
 3sv9Bk+6lQhrjqHUw9SrH2JhKSgJp9TXfkAP0DXDrmtD8VjYwrKELtZUjBgMGsvaRFV/
 O08HwatxU0/zm+mPY3nDRTl3fgQJuv03cWS5vscTXpzYZHQg00ZgN3EzyBQR+dATzyis
 p3fVH39GCN5frE/ufnt0fGQkKQPTWVOm3dMXCSl/R+AgJjre5aEe25x9KBzoIlC6g5sE
 nJeH+wJyf2wZPjNzRGZJSghmZxT+p+hoIllZhP6od9UMxpCFrU7c3fkcqGTdnvIfMtf1
 WOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736448597; x=1737053397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tysOloC1GiDq0Ki1ArIwVbUgf3JCtAzTwhZzTnebE0s=;
 b=hWjcAnHP0YZCejK5/zEA9FouCEw3qRhbg4CNMxYIbbWkol9C0uqdTFrFkWN0zlIff0
 I5/eVcyNTJxrVL23C/Ewd07srIq/9HkX7tTMII1YNrCzuUVoh/QgTq4yC3h2/5eueSc2
 u1UzamPlZwPF+s4zbve4/wrOXHCBfFwcPx8nwc149OwkNBNa2p1LJ/VMa3vpyA8cs7Rh
 +w4UsvvNxV8CUii6/6hUv62c+Wl/gptVm35X/sAOcBvZptT01jnMe3lcJNqxocimNiTE
 P23JMzupqpiQy2ewd0ITaDARsllPy0S9pg+wJe41LVWORNg8JhQDlsnNFtwWbG1N6naO
 99/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5pH8bUmv/WOHl3yicPDZ9jdNY24PU0Yq6YVem7xZZOGQKjkihlAKMFLpE7y1VZTCTXGXH7evQwybP@nongnu.org
X-Gm-Message-State: AOJu0Yyow2UrB93434AHh++XDF0hpCWp+Z/zs6V5kyCCFm6/V/0/SQeM
 qOPBd4v/AYLXRINIO0wBsqd+mam1/W9H8aa+hLJywBbHN59W6epAre7mvol87sk=
X-Gm-Gg: ASbGncvSlS7MrUPylBcE4jHX1U+fChxWYjdgr2gnysErqkf7UjPbwBQVNpOQCoXMSVW
 qhWYL5Db2fKrJUhUlVMvmLY8U+65Vnkrnw29Zvp5HzBMcyJkT88aRpY0/hL9fXUQJDsDSUNEMMn
 XJcsxKZh8+32v5mKhzKMY/OugWXaUG4w+FhFi/Ng3NPH1YbzvIyaGVryenlwSNUp09EgikYxcej
 ZHHJr/Fv032UJWd+pQymeF8vwoXyYvDSIc2IYkMgsMfzkxVJKeKYLU4lKGvrtQvhKuV1Q==
X-Google-Smtp-Source: AGHT+IF6i49gKsCnEI6eg5nRrQU61NgtXDbZuiu85F3tXxDCu8a9pU0FomFHWYZj7GyxPsoe0mOcvg==
X-Received: by 2002:a05:6a00:4486:b0:729:597:4faa with SMTP id
 d2e1a72fcca58-72d21fb1d72mr10868195b3a.16.1736448597464; 
 Thu, 09 Jan 2025 10:49:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658d2bsm117032b3a.107.2025.01.09.10.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 10:49:57 -0800 (PST)
Message-ID: <11261469-ddcf-4aa0-9343-fb01e85d0e2c@linaro.org>
Date: Thu, 9 Jan 2025 10:49:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] system/vl: more error exit into config enumeration
 code
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-9-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250109170619.2271193-9-alex.bennee@linaro.org>
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

T24gMS85LzI1IDA5OjA2LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IEFsbCBvZiB0aGUgZmFp
bHVyZXMgdG8gY29uZmlndXJlIGRldmljZXMgd2lsbCByZXN1bHQgaW4gUUVNVSBleGl0aW5n
DQo+IHdpdGggYW4gZXJyb3IgY29kZS4gSW4gcHJlcGFyYXRpb24gZm9yIHBhc3NpbmcgRXJy
b3IgKiBkb3duIHRoZSBjaGFpbg0KPiByZS1uYW1lIHRoZSBpdGVyYXRvciB0byBmb3JlYWNo
X2RldmljZV9jb25maWdfb3JfZXhpdCBhbmQgZXhpdCB1c2luZw0KPiAmZXJyb3JfZmF0YWwg
aW5zdGVhZCBvZiByZXR1cm5pbmcgYSBmYWlsdXJlIGluZGljYXRpb24uDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0t
LQ0KPiAgIHN5c3RlbS92bC5jIHwgMzEgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zeXN0ZW0vdmwuYyBiL3N5c3RlbS92bC5jDQo+IGlu
ZGV4IDA4NDNiN2FiNDkuLjI1ZDk5NjhjY2MgMTAwNjQ0DQo+IC0tLSBhL3N5c3RlbS92bC5j
DQo+ICsrKyBiL3N5c3RlbS92bC5jDQo+IEBAIC0xMzA3LDcgKzEzMDcsMTQgQEAgc3RhdGlj
IHZvaWQgYWRkX2RldmljZV9jb25maWcoaW50IHR5cGUsIGNvbnN0IGNoYXIgKmNtZGxpbmUp
DQo+ICAgICAgIFFUQUlMUV9JTlNFUlRfVEFJTCgmZGV2aWNlX2NvbmZpZ3MsIGNvbmYsIG5l
eHQpOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbnQgZm9yZWFjaF9kZXZpY2VfY29uZmln
KGludCB0eXBlLCBpbnQgKCpmdW5jKShjb25zdCBjaGFyICpjbWRsaW5lKSkNCj4gKy8qKg0K
PiArICogZm9yZWFjaF9kZXZpY2VfY29uZmlnX29yX2V4aXQoKTogcHJvY2VzcyBwZXItZGV2
aWNlIGNvbmZpZ3MNCj4gKyAqIEB0eXBlOiBkZXZpY2VfY29uZmlnIHR5cGUNCj4gKyAqIEBm
dW5jOiBkZXZpY2Ugc3BlY2lmaWMgY29uZmlnIGZ1bmN0aW9uLCByZXR1cm5pbmcgcGFzcy9m
YWlsDQo+ICsgKg0KPiArICogQW55IGZhaWx1cmUgaXMgZmF0YWwgYW5kIHdlIGV4aXQgd2l0
aCBhbiBlcnJvciBtZXNzYWdlLg0KPiArICovDQo+ICtzdGF0aWMgdm9pZCBmb3JlYWNoX2Rl
dmljZV9jb25maWdfb3JfZXhpdChpbnQgdHlwZSwgaW50ICgqZnVuYykoY29uc3QgY2hhciAq
Y21kbGluZSkpDQo+ICAgew0KPiAgICAgICBzdHJ1Y3QgZGV2aWNlX2NvbmZpZyAqY29uZjsN
Cj4gICAgICAgaW50IHJjOw0KPiBAQCAtMTMxOSwxMCArMTMyNiwxMCBAQCBzdGF0aWMgaW50
IGZvcmVhY2hfZGV2aWNlX2NvbmZpZyhpbnQgdHlwZSwgaW50ICgqZnVuYykoY29uc3QgY2hh
ciAqY21kbGluZSkpDQo+ICAgICAgICAgICByYyA9IGZ1bmMoY29uZi0+Y21kbGluZSk7DQo+
ICAgICAgICAgICBsb2NfcG9wKCZjb25mLT5sb2MpOw0KPiAgICAgICAgICAgaWYgKHJjKSB7
DQo+IC0gICAgICAgICAgICByZXR1cm4gcmM7DQo+ICsgICAgICAgICAgICBlcnJvcl9zZXRn
KCZlcnJvcl9mYXRhbCwgImZhaWxlZCB0byBjb25maWd1cmU6ICVzIiwgY29uZi0+Y21kbGlu
ZSk7DQo+ICsgICAgICAgICAgICBleGl0KDEpOw0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9
DQo+IC0gICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIHFlbXVf
ZGlzYWJsZV9kZWZhdWx0X2RldmljZXModm9pZCkNCj4gQEAgLTIwNDQsMTIgKzIwNTEsOSBA
QCBzdGF0aWMgdm9pZCBxZW11X2NyZWF0ZV9sYXRlX2JhY2tlbmRzKHZvaWQpDQo+ICAgICAg
IHFlbXVfb3B0c19mb3JlYWNoKHFlbXVfZmluZF9vcHRzKCJtb24iKSwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgbW9uX2luaXRfZnVuYywgTlVMTCwgJmVycm9yX2ZhdGFsKTsNCj4g
ICANCj4gLSAgICBpZiAoZm9yZWFjaF9kZXZpY2VfY29uZmlnKERFVl9TRVJJQUwsIHNlcmlh
bF9wYXJzZSkgPCAwKQ0KPiAtICAgICAgICBleGl0KDEpOw0KPiAtICAgIGlmIChmb3JlYWNo
X2RldmljZV9jb25maWcoREVWX1BBUkFMTEVMLCBwYXJhbGxlbF9wYXJzZSkgPCAwKQ0KPiAt
ICAgICAgICBleGl0KDEpOw0KPiAtICAgIGlmIChmb3JlYWNoX2RldmljZV9jb25maWcoREVW
X0RFQlVHQ09OLCBkZWJ1Z2Nvbl9wYXJzZSkgPCAwKQ0KPiAtICAgICAgICBleGl0KDEpOw0K
PiArICAgIGZvcmVhY2hfZGV2aWNlX2NvbmZpZ19vcl9leGl0KERFVl9TRVJJQUwsIHNlcmlh
bF9wYXJzZSk7DQo+ICsgICAgZm9yZWFjaF9kZXZpY2VfY29uZmlnX29yX2V4aXQoREVWX1BB
UkFMTEVMLCBwYXJhbGxlbF9wYXJzZSk7DQo+ICsgICAgZm9yZWFjaF9kZXZpY2VfY29uZmln
X29yX2V4aXQoREVWX0RFQlVHQ09OLCBkZWJ1Z2Nvbl9wYXJzZSk7DQo+ICAgDQo+ICAgICAg
IC8qIG5vdyBjaGFyZGV2cyBoYXZlIGJlZW4gY3JlYXRlZCB3ZSBtYXkgaGF2ZSBzZW1paG9z
dGluZyB0byBjb25uZWN0ICovDQo+ICAgICAgIHFlbXVfc2VtaWhvc3RpbmdfY2hhcmRldl9p
bml0KCk7DQo+IEBAIC0yNjcwLDggKzI2NzQsNyBAQCBzdGF0aWMgdm9pZCBxZW11X2NyZWF0
ZV9jbGlfZGV2aWNlcyh2b2lkKQ0KPiAgIA0KPiAgICAgICAvKiBpbml0IFVTQiBkZXZpY2Vz
ICovDQo+ICAgICAgIGlmIChtYWNoaW5lX3VzYihjdXJyZW50X21hY2hpbmUpKSB7DQo+IC0g
ICAgICAgIGlmIChmb3JlYWNoX2RldmljZV9jb25maWcoREVWX1VTQiwgdXNiX3BhcnNlKSA8
IDApDQo+IC0gICAgICAgICAgICBleGl0KDEpOw0KPiArICAgICAgICBmb3JlYWNoX2Rldmlj
ZV9jb25maWdfb3JfZXhpdChERVZfVVNCLCB1c2JfcGFyc2UpOw0KPiAgICAgICB9DQo+ICAg
DQo+ICAgICAgIC8qIGluaXQgZ2VuZXJpYyBkZXZpY2VzICovDQo+IEBAIC0yNzE4LDEwICsy
NzIxLDggQEAgc3RhdGljIGJvb2wgcWVtdV9tYWNoaW5lX2NyZWF0aW9uX2RvbmUoRXJyb3Ig
KiplcnJwKQ0KPiAgICAgICAgICAgZXhpdCgxKTsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAg
IGlmIChmb3JlYWNoX2RldmljZV9jb25maWcoREVWX0dEQiwgZ2Ric2VydmVyX3N0YXJ0KSA8
IDApIHsNCj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiY291bGQgbm90IHN0YXJ0IGdk
YnNlcnZlciIpOw0KPiAtICAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0gICAgfQ0KPiArICAg
IGZvcmVhY2hfZGV2aWNlX2NvbmZpZ19vcl9leGl0KERFVl9HREIsIGdkYnNlcnZlcl9zdGFy
dCk7DQo+ICsNCj4gICAgICAgaWYgKCF2Z2FfaW50ZXJmYWNlX2NyZWF0ZWQgJiYgIWRlZmF1
bHRfdmdhICYmDQo+ICAgICAgICAgICB2Z2FfaW50ZXJmYWNlX3R5cGUgIT0gVkdBX05PTkUp
IHsNCj4gICAgICAgICAgIHdhcm5fcmVwb3J0KCJBIC12Z2Egb3B0aW9uIHdhcyBwYXNzZWQg
YnV0IHRoaXMgbWFjaGluZSAiDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

