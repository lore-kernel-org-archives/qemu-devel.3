Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67355C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lOy-0003XU-AZ; Fri, 04 Apr 2025 14:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lOw-0003XF-M9
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:04:22 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lOu-0005gu-5I
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:04:22 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so1949468b3a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743789858; x=1744394658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r68WooAav6eQw/N7a9ACaNN/oWgc/yd2zfdOvrR64Xw=;
 b=hojBKICH89dka3jXxjKLID4Fc+o9Ti25zdW+QSn/BG4FSrC+tafgtbDPq+dqLitJmR
 eNsXV1gApRe9bGSviVQDirRu8eH0qiiPOdG24etkV/bJ++Nx9pri+GWYqX7++ijRpPKP
 t3pAyJV7abwmYmUXntHQbhDiIFLdHwDHMb8hl/hcSMnutTa+66EjPI3qwFeFTiKw1joP
 G67A09VLzxe9hJMc4bYhWjx0u8i3o2aeHNCC0YFVAtSZrlkDjHL4u1kSve3+bCMmgwrY
 BQoi27C+j1n/HYwVMBzzY1ryi1JcdCth+jBeIxsLOmj3aYu6c/ykHbB+wVdpzJfZNR6m
 vHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743789858; x=1744394658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r68WooAav6eQw/N7a9ACaNN/oWgc/yd2zfdOvrR64Xw=;
 b=FIbxPcC7/Lk1FOwMCVPO6ei3x1tAVgh9LjAV+y59zKMt2Uxt6n8oVRXF+A/Oz+NxAq
 jWM+e8csczbuo9IEAEM/4SX+JWSdXFBWhG/eH4qVQO5ANB6y9k4DQVikDqN4tU2uGHis
 6tVcQoAlAQvKvJXl3Tt4CQm5SsevSsTOeQreH8nwV1PzXQ5zswI4Ex2npAaNaCytPv4s
 2Y/bKHkJkXTnFq5tMkmREAtK06dRQEOepxIT/dshG/ElK/btyKcDeQQh2l/B4EM1WBFP
 H4HJlLF8frPmfxlhwV1VZgMU6VtXcYHRTfhRWVgRtKn3dlFkqFmfCu8Af28KzTiWO6wh
 oluA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoTfuuJ6oidaGsv20pZly04/fpfsqSv2s0agjKCAA9mbyOJgJ2xGdqltuKK18L4iNp+3c56RN2M5wm@nongnu.org
X-Gm-Message-State: AOJu0YzWWP6A8EsQeLZ2kh9uU+Agzv65uhXWjItaiEce8mm9hq10appx
 K6eiF3yYrh7PIaMUFbMTJcixnEVhCpZZCIi7zLx2rqIXTRTpP+8L+4zFFaPDEzg=
X-Gm-Gg: ASbGnctv8FcZXBAbpBtaBQoQ9HFKc1qnhwH/ZRAcQnaQgycTTi66aoQ1PEFyfIOlN5S
 sNDifpnQ8zi2o+QB9P/ZrCSfXf0n+1P1edOchOgO3wntHDMFLu7t7d6s0SqOmlsIZSnJp5S5lU1
 pu8ZmXhOFhFtirn1PtORFXYAi8F9MqrwlC88HfKPc3wlL/IdklGK0+3cViF/HaG/zrxdGt/2OKb
 x7larBU7QMfwRobrTD8IyflKH6qtxN9tSTte0frr9WqgT6Czr+xwL7V25uOelzkkIsyYf5N4rtR
 PFnA1wdLll35wVpM0WHW0e3Zxba1f1OqE2ButoCXamrROx4LswG+OabsTQ==
X-Google-Smtp-Source: AGHT+IFhWgIzZdYLtfMCLGH0MtNDDkI9JEDJ5hy7t5v3sZAPkGdRaYrxJdSyEEIxEtJexYlE0cyT+A==
X-Received: by 2002:a05:6a00:c96:b0:737:6d4b:f5f8 with SMTP id
 d2e1a72fcca58-739e7103027mr4469723b3a.17.1743789857846; 
 Fri, 04 Apr 2025 11:04:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d1b9esm3824196b3a.18.2025.04.04.11.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:04:17 -0700 (PDT)
Message-ID: <6d5ee93b-844e-4a46-9fae-ae71e99ad1e0@linaro.org>
Date: Fri, 4 Apr 2025 11:04:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 11/19] accel/tcg: Replace CPU_RESOLVING_TYPE
 -> target_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-12-philmd@linaro.org>
 <86fe4d7f-f0cd-42b9-99f0-b802337657b2@linaro.org>
 <45de7f1f-c8d0-44e0-8247-6a928860614e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <45de7f1f-c8d0-44e0-8247-6a928860614e@linaro.org>
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

T24gNC80LzI1IDEwOjU2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
NC80LzI1IDE4OjUxLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC8zLzI1IDE2
OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+Pj4gLS0t
DQo+Pj4gIMKgIGFjY2VsL3RjZy90Y2ctYWxsLmMgfCA0ICsrLS0NCj4+PiAgwqAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRp
ZmYgLS1naXQgYS9hY2NlbC90Y2cvdGNnLWFsbC5jIGIvYWNjZWwvdGNnL3RjZy1hbGwuYw0K
Pj4+IGluZGV4IGJmMjdjNWMwZmIzLi5hMTNjYjM5NjQ0ZiAxMDA2NDQNCj4+PiAtLS0gYS9h
Y2NlbC90Y2cvdGNnLWFsbC5jDQo+Pj4gKysrIGIvYWNjZWwvdGNnL3RjZy1hbGwuYw0KPj4+
IEBAIC0zNSw2ICszNSw3IEBADQo+Pj4gIMKgICNpbmNsdWRlICJxYXBpL3FhcGktdHlwZXMt
Y29tbW9uLmgiDQo+Pj4gIMKgICNpbmNsdWRlICJxYXBpL3FhcGktYnVpbHRpbi12aXNpdC5o
Ig0KPj4+ICDCoCAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0KPj4+ICsjaW5jbHVkZSAicWVt
dS90YXJnZXRfaW5mby5oIg0KPj4+ICDCoCAjaWYgZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZ
KQ0KPj4+ICDCoCAjaW5jbHVkZSAiaHcvcWRldi1jb3JlLmgiDQo+Pj4gIMKgICNlbHNlDQo+
Pj4gQEAgLTQ0LDcgKzQ1LDYgQEANCj4+PiAgwqAgI2luY2x1ZGUgImFjY2VsL3RjZy9jcHUt
b3BzLmgiDQo+Pj4gIMKgICNpbmNsdWRlICJpbnRlcm5hbC1jb21tb24uaCINCj4+PiAgwqAg
I2luY2x1ZGUgImNwdS1wYXJhbS5oIg0KPj4+IC0jaW5jbHVkZSAiY3B1LmgiDQo+Pj4gIMKg
IHN0cnVjdCBUQ0dTdGF0ZSB7DQo+Pj4gQEAgLTczLDcgKzczLDcgQEAgYm9vbCBxZW11X3Rj
Z19tdHRjZ19lbmFibGVkKHZvaWQpDQo+Pj4gIMKgIHN0YXRpYyB2b2lkIG10dGNnX2luaXQo
VENHU3RhdGUgKnMpDQo+Pj4gIMKgIHsNCj4+PiAtwqDCoMKgIENQVUNsYXNzICpjYyA9IENQ
VV9DTEFTUyhvYmplY3RfY2xhc3NfYnlfbmFtZShDUFVfUkVTT0xWSU5HX1RZUEUpKTsNCj4+
PiArwqDCoMKgIENQVUNsYXNzICpjYyA9IENQVV9DTEFTUyhvYmplY3RfY2xhc3NfYnlfbmFt
ZSh0YXJnZXRfY3B1X3R5cGUoKSkpOw0KPj4+ICDCoMKgwqDCoMKgIGJvb2wgbXR0Y2dfc3Vw
cG9ydGVkID0gY2MtPnRjZ19vcHMtPm10dGNnX3N1cHBvcnRlZDsNCj4+PiAgwqDCoMKgwqDC
oCBpZiAocy0+bXR0Y2dfZW5hYmxlZCA9PSBPTl9PRkZfQVVUT19BVVRPKSB7DQo+Pg0KPj4g
SXQgY2FuIGJlIHNxdWFzaGVkIHdpdGggcHJldmlvdXMgY29tbWl0Lg0KPiANCj4gTm90IGV4
YWN0bHkgdGhlIHNhbWUgc2V0IG9mIG1haW50YWluZXJzLCBidXQgY2FuIGRvLg0KPiANCg0K
Rm9yIG1lY2hhbmljYWwgY2hhbmdlcyBsaWtlIHRoaXMsIEkgZ3Vlc3MgaXQncyBsZXNzIGlt
cG9ydGFudCB0aGFuIHdoZW4gDQpyZWFsbHkgdG91Y2hpbmcgYSBzcGVjaWZpYyBzdWJzeXN0
ZW0uDQoNCj4+IFJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+DQo+IA0KPiBUaGFua3MhDQoNCg==

