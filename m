Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A7FC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 01:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0s0v-0003m0-JB; Fri, 04 Apr 2025 21:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0s0s-0003lM-GN
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:07:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0s0q-0000Yv-Hm
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 21:07:58 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-730517040a9so3061685b3a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 18:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743815274; x=1744420074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m/zagdiGJxkEaKg1t5JesAiZeyEJ3da3hfgYU3s20uE=;
 b=HC7E+LmOgnpr2+QN0Ou+pG6KyBf6pjLvnZuvAVtqtT6HKVA56ilQJOTif1ffPA3StU
 CzaKicuI7Yhy3L3QSWBxwVKTyCIq/OrN6OCuKjCC8BaBxi0yMnPjvvp2RzU0yfWmSrln
 qqj+iR3aL6JXZi3XX3h0nMM3GbDCnQgJ3xGYGgF09AmJbu51ie92MJh4HTvNRrfr9N+K
 Bd8pIilsCgzuE9MIp2NGV6jlJA/xuPj4cEPGgmz7VF1tJo4589V1kb790NT4Wtoy2bIq
 mAP3JxBIuppwgzWxR1RepgaHkpP1RYbnglwsk90OZHTUPBRtiFJkZxU0CmnyuV38KTpV
 cvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743815274; x=1744420074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m/zagdiGJxkEaKg1t5JesAiZeyEJ3da3hfgYU3s20uE=;
 b=o7oj8Yc/Gg1hibr7nbNO7G4EQs3FgLIB0fN2AJdwfIrenWuSYahw4EiVpXdxg2KUQB
 CDmt45j+sqiVF+K32B/z6j5dZoe0QDgaHRkBSJiEXX0diuyrb9Nwt7OZlki0qegMCX4s
 ppfVbuWXsQRYo8qfKfOMDYnABq6gsGzleMyW+9mrHz/p7AMZVwMV5k7WLHwOEQ39zvxZ
 eBiwyAEveT8QJYg6dgN7CEfP3hiNWPrjlSNJR6RVODyTBxFvRPyI1UOBa4t4lJNEZ77i
 k3f58CDE3PC8XDMNGUVbwPUzXvw6oAua9V8JSU0ZV6IfXsrpXXyogobYkx8NB02YxppW
 8tmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXp2DOfbWoBaEJvc7FhXWI+gKSlj8x7fluZfyQXFOA+BFSSjsxqQVQaHuNDYYLD4+0IE1CPx5SWoCe@nongnu.org
X-Gm-Message-State: AOJu0YzIDHmcGwVoozHcFG6SbyL7hEZ2XVEMtKRIGUgXJ6Txl3DcfxWI
 f+rzx12vmPjtXLpKwqVxtCNc83qjvmzGvRv7Rx3qZw2VSgPbfEKmDxVpUZ4txxI=
X-Gm-Gg: ASbGncvhwexj15DK7dtyjq6EGhK5tiG7k9YFkyI+VsohPGMWI7rETu1CCYM3faUt2F+
 /2AvVwATSbzC/7adrSkhtjClXslUfCNvVagrtMBv8UdlZZ2aO6MbGKDr5NUm9xbb3HlUZToKdQI
 N4vLd5+ItWqlFU6b3VVveLJW8mrmAsUfpfamYiM5rNFD/MdEW/F0yqaeEtV+uOH5V6oDN+Fbo6P
 nd3hx+0HcIxG+FfjvC12vPM0xkxm7h/1DWJa/Dy7fH1JgWXVF3bx9iHhhL3+LdroTsUDKQfrPt2
 IOat7s7LWvo2V4TJBkEqVGKA3BjroN0cZnfC5OcHbvTgV3PuYlFCfINIVg==
X-Google-Smtp-Source: AGHT+IGB3cG17Rh06mGrc/X3ujRQ/9xvhGXwYBVkEOhkq8xZolYcV6QripFYQYcPmoWDGDcNpME3bQ==
X-Received: by 2002:a05:6a20:258a:b0:1f5:55b7:1bb2 with SMTP id
 adf61e73a8af0-2010444e004mr7914735637.6.1743815274393; 
 Fri, 04 Apr 2025 18:07:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0dedd4sm4089117b3a.166.2025.04.04.18.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 18:07:54 -0700 (PDT)
Message-ID: <2fb96610-1a00-4481-bebb-914e208cc410@linaro.org>
Date: Fri, 4 Apr 2025 18:07:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 28/39] exec: Do not poison hardware
 accelerators
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-29-philmd@linaro.org>
 <c1418cb6-1c92-4f7d-a4f8-85099fc2f6dc@linaro.org>
 <d7d8590c-424f-43fd-918b-68603720b3dd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d7d8590c-424f-43fd-918b-68603720b3dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

T24gNC80LzI1IDE1OjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gK1Bh
b2xvDQo+IA0KPiBPbiA0LzQvMjUgMjA6MjUsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+
PiBPbiA0LzMvMjUgMTY6NTgsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+
IEhhcmR3YXJlIGFjY2VsZXJhdG9ycyBkZXBlbmRzIG9uIHRoZSBob3N0LCBub3QgdGhlIGd1
ZXN0Lg0KPj4+DQo+Pg0KPj4gV2hpbGUgdGhpcyBpcyB0cnVlLCBubyB3ZSBjYW4ndCB1bnBv
aXNvbiB0aG9zZSBkZWZpbmUuDQo+PiBUaGV5IGFyZSBhcHBsaWVkIHBlciB0YXJnZXQsIGFu
ZCBub3QgaW4gY29uZmlnLWhvc3QuIFNvIHVucG9pc29pbmluZw0KPj4gdGhlbSBvcGVucyB0
aGUgcG9zc2liaWxpdHkgdG8gbWlzcyBzb21ldGhpbmcuDQo+Pg0KPj4gSSB3b3VsZCBzdGlj
ayB0byBjbGVhbiB1cCB0aG9zZSBpZmRlZiBpbnN0ZWFkLCBieSBleHBvc2luZyBpbnRlcmZh
Y2UgdG8NCj4+IGFsbCBjb2RlLCBhbmQgbGluayBhcHByb3ByaWF0ZSBzdHVicyBkZXBlbmRp
bmcgb24gdGhlIHZhcmlhbnQgYnVpbHQuDQo+IA0KPiBPSywgc28gSUlVQyB0aGlzIGlzIHRo
ZSBzYW1lIHJlYXNvbmluZyB0aGFuIHByZXZpb3VzIHBhdGNoIGNvbW1lbnQsDQo+IGFsd2F5
cyBkZWNsYXJlIGt2bV9lbmFibGVkKCkgc28gY29kZSBlbGlzaW9uIGlzbid0IHBvc3NpYmxl
IGFueW1vcmUsDQo+IHRoZW4gcmVtb3ZlIGFsbCBDT05GSUdfS1ZNICNpZmRlZidyeT8NCj4g
DQoNClllcywgcmlnaHQuIEFuZCB0aGlzIENPTkZJR197YWNjZWx9IHdpbGwgYmUgdXNlZCBv
bmx5IGluIGJ1aWxkIHN5c3RlbSB0byANCnNlbGVjdCB0aGUgaG9zdCBpbXBsZW1lbnRhdGlv
biBvciB0aGUgc3R1YmJlZCBvbmUuDQoNCj4+DQo+Pj4gU3VnZ2VzdGVkLWJ5OiBSaWNoYXJk
IEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+
Pj4gLS0tDQo+Pj4gIMKgIGluY2x1ZGUvZXhlYy9wb2lzb24uaMKgwqDCoMKgwqDCoMKgwqAg
fCA0IC0tLS0NCj4+PiAgwqAgc2NyaXB0cy9tYWtlLWNvbmZpZy1wwqDCoMKgIG9pc29uLnNo
IHwgNCArKysrDQo+Pj4gIMKgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9wb2lz
b24uaCBiL2luY2x1ZGUvZXhlYy9wb2lzb24uaA0KPj4+IGluZGV4IDAwYWVkYzQxZDgyLi4w
NTc0ZDY4M2Y2YSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2V4ZWMvcG9pc29uLmgNCj4+
PiArKysgYi9pbmNsdWRlL2V4ZWMvcG9pc29uLmgNCj4+PiBAQCAtNjIsMTEgKzYyLDcgQEAN
Cj4+PiAgwqAgI3ByYWdtYSBHQ0MgcG9pc29uIENPTkZJR19TUEFSQ19ESVMNCj4+PiAgwqAg
I3ByYWdtYSBHQ0MgcG9pc29uIENPTkZJR19YVEVOU0FfRElTDQo+Pj4gLSNwcmFnbWEgR0ND
IHBvaXNvbiBDT05GSUdfSFZGDQo+Pj4gIMKgICNwcmFnbWEgR0NDIHBvaXNvbiBDT05GSUdf
TElOVVhfVVNFUg0KPj4+IC0jcHJhZ21hIEdDQyBwb2lzb24gQ09ORklHX0tWTQ0KPj4+IC0j
cHJhZ21hIEdDQyBwb2lzb24gQ09ORklHX1dIUFgNCj4+PiAtI3ByYWdtYSBHQ0MgcG9pc29u
IENPTkZJR19YRU4NCj4+PiAgwqAgI2lmbmRlZiBDT01QSUxJTkdfU1lTVEVNX1ZTX1VTRVIN
Cj4+PiAgwqAgI3ByYWdtYSBHQ0MgcG9pc29uIENPTkZJR19VU0VSX09OTFkNCj4+PiBkaWZm
IC0tZ2l0IGEvc2NyaXB0cy9tYWtlLWNvbmZpZy1wb2lzb24uc2ggYi9zY3JpcHRzL21ha2Ut
Y29uZmlnLQ0KPj4+IHBvaXNvbi5zaA0KPj4+IGluZGV4IDJiMzY5MDdlMjM5Li4wOWQyMzg0
NzQ1ZiAxMDA3NTUNCj4+PiAtLS0gYS9zY3JpcHRzL21ha2UtY29uZmlnLXBvaXNvbi5zaA0K
Pj4+ICsrKyBiL3NjcmlwdHMvbWFrZS1jb25maWctcG9pc29uLnNoDQo+Pj4gQEAgLTgsNiAr
OCwxMCBAQCBmaQ0KPj4+ICDCoCAjIGJ1dCBmaWx0ZXIgb3V0IHNldmVyYWwgd2hpY2ggYXJl
IGhhbmRsZWQgbWFudWFsbHkuDQo+Pj4gIMKgIGV4ZWMgc2VkIC1uIFwNCj4+PiAgwqDCoMKg
IC1lJyAvQ09ORklHX1RDRy9kJyBcDQo+Pj4gK8KgIC1lJyAvQ09ORklHX0hWRi9kJyBcDQo+
Pj4gK8KgIC1lJyAvQ09ORklHX0tWTS9kJyBcDQo+Pj4gK8KgIC1lJyAvQ09ORklHX1dIUFgv
ZCcgXA0KPj4+ICvCoCAtZScgL0NPTkZJR19YRU4vZCcgXA0KPj4+ICDCoMKgwqAgLWUgJy9D
T05GSUdfVVNFUl9PTkxZL2QnIFwNCj4+PiAgwqDCoMKgIC1lICcvQ09ORklHX1NPRlRNTVUv
ZCcgXA0KPj4+ICDCoMKgwqAgLWUgJy9eI2RlZmluZSAvIHsnIFwNCj4+DQo+IA0KDQo=

