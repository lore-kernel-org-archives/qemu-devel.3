Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5919D70DE3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGiGN-0002RJ-EK; Thu, 28 Nov 2024 12:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGiGL-0002QX-KF
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:25:09 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGiGJ-0000Sq-1g
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:25:09 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2124a86f4cbso8108735ad.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732814705; x=1733419505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OfaLlOP7PiRfWuSQeoCVHzQNvzHHyjNwT8G0ElURzIc=;
 b=wbTtGIpAYHacSH2H5rvYdMTqVEvStVTEF+gBigVLpUbOcMCStAcjJHzu90L/LPWMum
 dqJoNkogj9GMk4MWo9XlE94SqxIZLIxrHBJrRTduSOKu0ECcZtE+oUZ1uztkba2RrTbz
 l2aUFwLbzLvk2/FqGChZfogHKH6vjzxM4ZF2RbqTX1oZCSpOe/hyQtcOpivm9wuEiWK8
 WJYfO77EntZX23i4n6NgDJLTeKsjKlWqlLp5Qz5c/6wsjDnN0Yae7TJdk1iRhlWEFoW8
 shIuVJCf7Pciubl5cedg7l/gUwzebwN0AvOsjeM7eUNLQ6whoG5yS3Ht8dum83bwuxll
 f/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732814705; x=1733419505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OfaLlOP7PiRfWuSQeoCVHzQNvzHHyjNwT8G0ElURzIc=;
 b=e4T+H+xt7vAQv1SwV3YwkiUo/Gp9YJcBWbZRuP7+3Jd9Ilrec2ZVm0osH+stjn5Rbh
 KoaaB7H/IS60XRy8k6IBVfvDjbOLjYKVkD/1WOk8Zfy8L67YGMLd4GsQkxHaiytiMEYR
 TgQr09QHDYGLX5PQEKWQENRPJX6VnfwM0kODppGPj7nyXOqT5FjvmeGYRl5x+r/2yrMd
 eCOlxj7c+Q6cpPasqOb7iuMVV67Yx/Wo+QqkKQOoRy5DW8AHeyrVpgaoROBg8jBo+YLD
 E4twzeFxNsRZdMZapRAxZ9SW8VqfvurtwwvAzSZ8XgJ4IsmPNvExrBxQU9ClzxX88wPx
 Xxdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAxz29pUU8FNGmwfMq2esBvyv8withMgZU5SYli4F6UJC8InKuhWsVjEnCTm/6vB2YDx9Cxgafs6Gs@nongnu.org
X-Gm-Message-State: AOJu0YyuMIhtkDLg5KVZlbHH+jTlT6roExSBiV+36qBV01yq3W91Xnzt
 NjSwWv40zKD5cnyqxB5ziSnIHUNkHqIKKNjfPV167ZG4Im6UPA3adHEfB92X6nM=
X-Gm-Gg: ASbGncuu1dLFkMoYmiT07e+16gxl4y4nRoicdhDke7cVaN4pFX9rh9R1CWPISJ3uoFZ
 wPAIORBMWBtMFykwAhkGgLgAWoIF5BsgmZk+o8Z7GkvkBQkMS7yhME842CoTIqb57o63+lGcypZ
 0nuhxwLZ5q4hcEL0LWTctIbFohiQ/oth4a2afUvXslev2zS0NFd076edcSGmaWCrYRMVv4GExvP
 zqL3Q/WhjeMZCnOJoXBAB2igvVVecNJ9+eTkMnZ5V2hKOHFSHCLnp+kRe7eX/Nx9Ul2jbCE+7y1
 XDjQkkjo6I7QTWQKoX6EBw==
X-Google-Smtp-Source: AGHT+IEjM3PuGa9VAgGuPNPfn6dfKoxQjiseHyoF+/tl/UOAWGjzwWct66nIE35DvmVQXCL4u9sYDQ==
X-Received: by 2002:a17:903:22cd:b0:211:f52d:4e03 with SMTP id
 d9443c01a7336-21501385b3dmr83221705ad.27.1732814704740; 
 Thu, 28 Nov 2024 09:25:04 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215219862c1sm15871115ad.214.2024.11.28.09.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:25:04 -0800 (PST)
Message-ID: <46d3b688-c14a-47fe-b5f6-7552677c3c7d@linaro.org>
Date: Thu, 28 Nov 2024 09:25:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
 <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
 <Z0bhDbpovFOkDomB@redhat.com>
 <07f2dcf3-8796-4e8e-af1e-c3e860dcd095@linaro.org>
 <Z0g5Kz77xeevUmb4@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Z0g5Kz77xeevUmb4@redhat.com>
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

T24gMTEvMjgvMjQgMDE6MzQsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9uIFdl
ZCwgTm92IDI3LCAyMDI0IGF0IDEwOjMxOjEzQU0gLTA4MDAsIFBpZXJyaWNrIEJvdXZpZXIg
d3JvdGU6DQo+PiBPbiAxMS8yNy8yNCAwMTowNiwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90
ZToNCj4+PiBPbiBUdWUsIE5vdiAyNiwgMjAyNCBhdCAwNDo1NDoxOFBNIC0wNjAwLCBSaWNo
YXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+Pj4gT24gMTEvMjYvMjQgMTE6NTIsIFRob21hcyBI
dXRoIHdyb3RlOg0KPj4+Pj4gSSB0aGluayB3ZSB3YW50IHRvIGNvbnRpbnVlIHRvIG1hZWsg
ZmFpbGluZyBkb3dubG9hZHMgYXMgdGVzdCBmYWlsdXJlcywNCj4+Pj4+IG90aGVyd2lzZSB3
ZSdsbCBuZXZlciBub3RpY2Ugd2hlbiBhbiBhc3NldCBpcyBub3QgYXZhaWxhYmxlIGZyb20g
dGhlDQo+Pj4+PiBpbnRlcm5ldCBhbnltb3JlIChzaW5jZSBTS0lQcyBqdXN0IGdldCBpZ25v
cmVkKS4NCj4+Pj4NCj4+Pj4gSSBkaXNhZ3JlZS4gIERvd25sb2FkIGZhaWx1cmVzIGFyZSBu
b3QgcmFyZS4NCj4+Pg0KPj4+IEZhaWx1cmVzIG9mIHRoZSB0ZXN0IHRvIGRvd25sb2FkIGFz
c2V0cyB3aWxsIGJlIHJhcmUgKmlmKiB3ZSBoYXZlIHRoZQ0KPj4+IENJIHJ1bm5lciBjYWNo
ZSBmaXhlZC4gV2Ugb25seSBuZWVkIHRvIHN1Y2Nlc3NmdWxseSBkb3dubG9hZCBlYWNoDQo+
Pj4gYXNzZXQgb25jZSwgYW5kIGl0IHNob3VsZCBiZSBjYWNoZWQgZm9yZXZlciB3aXRoIG5v
IGV4cGlyeSB0aW1lb3V0Lg0KPj4+DQo+Pj4gU28gd2UgaGF2ZSBhbiBpbml0aWFsbHkgYm9v
dHN0cmFwcGluZyBwcm9ibGVtIG9uY2UgY2FjaGluZyBpcyBmaXhlZCwNCj4+PiB3aGVyZSBk
b3dubG9hZCBmYWlsdXJlcyBjb3VsZCBpbXBhY3QgdXMuIE9uY2UgdGhlIGNhY2hlIGlzIHBy
aW1lZCwNCj4+PiB3ZSdsbCBvbmx5IGJlIGF0IHJpc2sgb2YgZG93bmxvYWQgZmFpbHVyZXMg
d2hlbiBpbnRyb2R1Y2luZyBuZXcNCj4+PiBhc3NldCBVUkxzLCBzbyBJIHRoaW5rIGl0IGlz
IGZhaXIgdG8gc2F5IGZhaWx1cmVzIHNob3VsZCBiZSByYXJlDQo+Pj4gKmlmKiB3ZSBnZXQg
dGhlIGNhY2hpbmcgZml4ZWQuDQo+Pj4NCj4+PiBXaXRoIHJlZ2FyZHMsDQo+Pj4gRGFuaWVs
DQo+Pg0KPj4gQmV5b25kIHRoZSBRRU1VIENJLCB3ZSBzaG91bGQgdGhpbmsgYWJvdXQgdXNl
cnMgdHJ5aW5nIHRvIHJ1biB0ZXN0cywgYW5kDQo+PiBoYXZpbmcgdGhlIHNhbWUga2luZCBv
ZiBwcm9ibGVtcywgYnV0IHdpdGhvdXQgaGF2aW5nIGFjY2VzcyB0byB0aGUgbWFnaWMNCj4+
IGNhY2hlLg0KPj4NCj4+IFJlZ2FyZGluZyB0aGUgYXNzZXRzIGRvd25sb2FkLCB3aHkgZG9u
J3Qgd2UgbWlycm9yIHRoZW0gc29tZXdoZXJlIHJlbGlhYmxlDQo+PiBpbnN0ZWFkIG9mIHJl
bHlpbmcgb24gdGhpcmQgcGFydHkgc3RvcmFnZT8NCj4gDQo+IElmIFFFTVUgaG9zdHMgdGhl
c2UgZmlsZXMsIHRoZW4gUUVNVSBpcyBsaWFibGUgZm9yIGxpY2Vuc2UgY29tcGxpYW5jZSwN
Cj4gSU9XLCB3ZSBoYXZlIHRvIGlkZW50aWZ5ICYgcG90ZW50aWFsbHkgaG9zdCB0aGUgZnVs
bCAmIGNvcnJlc3BvbmRpbmcNCj4gc291cmNlIGZvciBhbGwgYmluYXJpZXMgaW4gdGhlIGlt
YWdlcy4gVGhpcyBpcyBub3QgYSBidXNpbmVzcyB3ZSB3YW50DQo+IHRvIGJlIGludm9sdmVk
IGluIGFzIGEgcHJvamVjdC4NCj4NCg0KVGhhdCdzIGludGVyZXN0aW5nIHRvIGtub3cuDQpJ
biB0aGlzIGNhc2UsIHBvaW50aW5nIHRoZSBvcmlnaW5hbCBsaW5rIG9yaWdpbiB3aXRoIHRo
ZSBhcnRpZmFjdCBpcyBub3QgDQplbm91Z2g/DQoNCj4gV2l0aCByZWdhcmRzLA0KPiBEYW5p
ZWwNCg0K

