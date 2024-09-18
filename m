Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23495CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzeK-0007Iu-Ot; Wed, 18 Sep 2024 14:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sqzeI-0007Ho-T1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:43:34 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sqzeH-0003EZ-7u
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:43:34 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so28878a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726685011; x=1727289811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mUn3vVs3PAg1jpdzhe1s5TNbomjixUrUyStKSozflik=;
 b=ulb7wqBepRucEHj4QUvMrsCAOjWZvG+K+jv7VVt+TAByo2PDptSHQk7JmlKBdLM9OZ
 fDkgNoaxb08EvvERhOp7H+oxHq5CGET5DvH05G+WHyXej7OJPaOT6kEhkSfqCdP5xjQr
 Mr1us1RNXvwI3Na1aV/lrpPHkpumeGm8mNzWhOzdbrorZyW7KxU/tFwragTZ8tyuI2qT
 otNiIQSQx1UOht2YkTQwdJ+nOYqxMs6xAUqMFJKS1u++x0yRRih5cy2XOP7JvQEAlpGC
 3He8BkTkggZzOyADeSjJUeGzT/VMHII5mR7KGxG01HMWrICXmEQVv3Fz4dq19a1zBhR6
 SOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726685011; x=1727289811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUn3vVs3PAg1jpdzhe1s5TNbomjixUrUyStKSozflik=;
 b=RSzUa0/0426ngFOJekf7Hk/MCKz6cB6yUKNVNJ2V4Y/2RXIXZIkV4RCMLbFM7NGp2K
 xRf7e7UaWYMT3F3cbASXk1/iYoD3bYHPTyTJGLJL6IRVpLFTVkOOZtakiraTWqDq3VE8
 kYx3QAdKopYU+xU5FrxZTW72lpP6TBlvmD4V8/2i8T609sqWwHHPuN77TgSMYGpWIdcH
 VcO4t8NIqADQmC4gFC/tQMOGjB164gqD5+KPcg+D1f0YsD76hJ+2+SlV+IbU80tRIMC8
 pr0gYf7UTlZkm425M3Nq64w5gre59kQlzjTlrJpIurfcRbGtbkvkCeG8f45iayNY9fMb
 X/0w==
X-Gm-Message-State: AOJu0Yyg/kXAJ+zDgnQA+lZ0MP4rRXv5mNjsNerqY7qZ7LQd/Mb2sx83
 3WE2fWg1N/wowAw6BOvlo6kiflJ7cfpDmIEtmBwC5ZEISrKmOm3nFCtU9Z7xbT8=
X-Google-Smtp-Source: AGHT+IFNeFvI+FeuoqaUjf+7LYg1q2d4BRxyYfcT+Awcekb89xJtzurLWQ9NV8ISzhOhgL4Ksf90ww==
X-Received: by 2002:a05:6a21:3401:b0:1cf:49a6:992a with SMTP id
 adf61e73a8af0-1d2fcad220amr858776637.21.1726685011098; 
 Wed, 18 Sep 2024 11:43:31 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944b7afaesm7010644b3a.130.2024.09.18.11.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 11:43:30 -0700 (PDT)
Message-ID: <c1f77391-a939-4fa6-98fa-c50622a71ede@linaro.org>
Date: Wed, 18 Sep 2024 11:43:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tcg: Fix branch/label link during plugin expansion
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240910212351.977753-1-richard.henderson@linaro.org>
 <f7f1cb70-08f8-48aa-9db7-cc7a119a4234@linaro.org>
 <87jzffrgw0.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87jzffrgw0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

T24gOS8xMy8yNCAwMzoyMywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBSaWNoYXJkIEhlbmRl
cnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IE9u
IDkvMTAvMjQgMTQ6MjMsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPj4+IFdpdGggdGNn
X2xhc3Rfb3AoKSwgd2UgYWx3YXlzIGdldCB0aGUgbGFzdCBvcCBvZiB0aGUgc3RyZWFtLg0K
Pj4+IFdpdGggVENHQ29udGV4dC5lbWl0X2JlZm9yZV9vcCwgdGhlIG1vc3QgcmVjZW50bHkg
ZW1pdHRlZCBvcA0KPj4+IGlzIG5vIGxvbmdlciB0aGUgbGFzdCBvcC4NCj4+PiBJbnN0ZWFk
LCBwYXNzIHRoZSBvcCBiZWluZyBlbWl0dGVkIGJhY2sgZnJvbSB0aGUgYWxsb2NhdG9yIHNv
DQo+Pj4gdGhhdCB3ZSBjYW4gbGluayBpdCB0byB0aGUgbGFiZWwgd2l0aG91dCBuZWVkaW5n
IHRvIGxvb2sgaXQgdXAuDQo+Pg0KPj4gT2gsIEkgbWVhbnQgdG8gcG9pbnQgb3V0IGZyb20g
d2hlbmNlIHRoaXMgY29tZXMuDQo+PiBUaGUgcGx1Z2luIHVzZXMgYSBjb25kaXRpb25hbA0K
PiANCj4gICAgICBzaXplX3Qgbl9pbnNucyA9IHFlbXVfcGx1Z2luX3RiX25faW5zbnModGIp
Ow0KPiAgICAgIHFlbXVfcGx1Z2luX3U2NCBxdWFudHVtX2luc24gPQ0KPiAgICAgICAgICBx
ZW11X3BsdWdpbl9zY29yZWJvYXJkX3U2NF9pbl9zdHJ1Y3QodmNwdXMsIHZDUFVUaW1lLCBx
dWFudHVtX2luc24pOw0KPiAgICAgIC8qIGNvdW50IChhbmQgZXZlbnR1YWxseSB0cmFwKSBv
bmNlIHBlciB0YiAqLw0KPiAgICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfdGJfZXhl
Y19pbmxpbmVfcGVyX3ZjcHUoDQo+ICAgICAgICAgIHRiLCBRRU1VX1BMVUdJTl9JTkxJTkVf
QUREX1U2NCwgcXVhbnR1bV9pbnNuLCBuX2luc25zKTsNCj4gDQo+PiAgIGxkX2kzMiB0bXAx
OCxlbnYsJDB4ZmZmZmZmZmZmZmZmZGIxMA0KPj4gICBtdWxfaTMyIHRtcDE4LHRtcDE4LCQw
eDE4DQo+PiAgIGV4dF9pMzJfaTY0IHRtcDE3LHRtcDE4DQo+PiAgIGFkZF9pNjQgdG1wMTcs
dG1wMTcsJDB4NTc1NDEwZWRhZGM4DQo+IA0KPiAgICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVy
X3ZjcHVfdGJfZXhlY19jb25kX2NiKA0KPiAgICAgICAgICB0YiwgZXZlcnlfcXVhbnR1bV9p
bnNuLA0KPiAgICAgICAgICBRRU1VX1BMVUdJTl9DQl9OT19SRUdTLCBRRU1VX1BMVUdJTl9D
T05EX0dFLA0KPiAgICAgICAgICBxdWFudHVtX2luc24sIG1heF9pbnNuX3Blcl9xdWFudHVt
LCBOVUxMKTsNCj4gDQo+ID8NCj4gDQo+PiAgIGxkX2k2NCB0bXAyMSx0bXAxNywkMHgwDQo+
PiAgIGJyY29uZF9pNjQgdG1wMjEsJDB4MCxsdHUsJEwxDQo+PiAgIGxkX2kzMiB0bXAxOCxl
bnYsJDB4ZmZmZmZmZmZmZmZmZGIxMA0KPj4gICBjYWxsIHBsdWdpbigweDc5YTJhYmZkZTY2
YSksJDB4MSwkMCx0bXAxOCwkMHgwDQo+PiAgIHNldF9sYWJlbCAkTDENCj4+DQo+PiBOb3Rl
IHRoYXQgdGhlIGJyYW5jaCBpcyBYIDwgMCAodW5zaWduZWQpLCB3aGljaCBpcyBhbHdheXMg
ZmFsc2UsIGFuZA0KPj4gdGh1cyB0aGUgYnJhbmNoIGlzIG9wdGltaXplZCBhd2F5Lg0KPiAN
Cj4gSSdtIG9idmlvdXNseSBtaXNzaW5nIHNvbWV0aGluZyByZWFkaW5nIHRoaXMuIEhvdyBj
YW4gVENHIGtub3cgdGhlIHN0YXRlDQo+IG9mIHRoZSBzY29yZWJvYXJkIHZhcmlhYmxlcyBh
bmQgb3B0aW1pc2UgYXdheSB0aGUgYnJhbmNoPw0KPiANCg0KVGhlIGNvbnN0YW50IGFnYWlu
c3Qgd2hpY2ggd2UgY29tcGFyZSBzY29yZWJvYXJkIGVudHJ5IHZhbHVlIGlzIGtub3duIGF0
IA0KdHJhbnNsYXRpb24gdGltZS4NCg0KPj4NCj4+DQo+PiByfg0KPiANCg==

