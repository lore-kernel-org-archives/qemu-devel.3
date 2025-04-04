Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F9AC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lox-0005lP-9V; Fri, 04 Apr 2025 14:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lou-0005kg-F3
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:31:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0log-00011H-Da
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:31:11 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so1967420b3a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743791454; x=1744396254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjU9fWM3W3p4mEmnPkzfavk/VLZ1pEDvskhYVp5kNJ0=;
 b=y/TKfI7Uw1JiUZzBV30+EU63VkdsHHvjUOtI6Kx/gulcOO12a4EZ0efSkmH7nL+ILm
 rhcIR4MlVK2I1GD89mJBKUccTf6dAgooXBgZ5+nC4meUDCl+y3x8tc5lcTXhcmwUFFSQ
 fxqOdCKowv1tVoX4jQCrCkD6r3FZ1+tiqKZMjfCn8ISb82r7/hiVAyTvRcIQSgZZYtHX
 NGAtPydt+HDSpv4Wo6D5Lz8b8kNbxZn0N85j4o8Cs1bELcAuhzF4v37OxHEG1S9Ekcs8
 9/n6jt+Y9Oolkiah3mfcul/e9szcfG15xMccxneKNZuvAYXy7AwTMVFX2u9B9/7EjfLu
 zfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743791454; x=1744396254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjU9fWM3W3p4mEmnPkzfavk/VLZ1pEDvskhYVp5kNJ0=;
 b=ju1yxW8ZyYu1ALf3q0YbSaw4v6Z8IjHZuIlVFSmC88kFMKBMpCr0VuwzsBDFs0AZeP
 JM0CQHBYo6426g0rAWxu0m/isfbxZTZTyVkzp5QY7iNiX6gzfbO0TcOhcpPD/wiaANh7
 wi2EXxHogqusd93NA6tyxZa3EbLXNgpUW+pOVDenq8MI52U+QMeQ5RKxEGyjBfcOn4q9
 eGmfNexWm301OAxJdmjr1V356/9HxtJhbjeB//WUfg1OVvWM3giaAJf+mqiWmEOVMqBA
 E+6tGRVik59WCGZ4aLdtmFPfSG029fw5X3pMmM4hT5QvW/XW4+J8iI8b+ff6PnW2mI7L
 Q3BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7nroi7S0ulZkpAFlpaEN84TAqVp6MVtALHDWCB7XbU1SgNpDxfaOOarfge/jUo0g7gdtoFW0SG33p@nongnu.org
X-Gm-Message-State: AOJu0YxETqvfLU99Upj2L63RnNH8vhWCm6ZNIGb4qdvAMWqnpFLDTAlY
 kpWpe8atPBwfJ7/I8mXlx9mmHNul0QsHyWy16phJwF4BjlokL4ckeqlu8g/ckt2m8GgxOnRDciI
 g
X-Gm-Gg: ASbGncvgmwR1PfpHE8Vx4nOd501h+iEjRC/BfWHwJkR1E9FY0JxTkLjXW79TBpGnklc
 L5bbC7nwq6AprEnf3aj69XbxOdURv4uKT0RhvTnJHjmAkeaDHj3AmUfHKHCDg/5WSJ0Q1g8cmQC
 SvcvfXvvL+x0ALXNgOF5eCPVS7SfY+NN3bj9hfsYRMDf/Tq+GkgZd03ZRRO35vYngn28rPBH/lQ
 WY1E199w39hDObKBuJiaGVsFtXw7oy3eeYMinsPqaN7KpJkbHYXkBfWxk43lAaLYhE5qC0p7PJ6
 kp7nSBZxiVcVCg4+cMB13EsAtKcH9rjYDrfKnDdCOQpW79UH+boDNogqOalxn05x/LXR
X-Google-Smtp-Source: AGHT+IHhVF6r3pDBVRQ01enw9eS5Wac7L3mxP1fzsO5+4fGLf9zmCerQV6I6z8NoM/VkCajTWXMvLA==
X-Received: by 2002:a05:6a20:561a:b0:1f5:9330:2a18 with SMTP id
 adf61e73a8af0-2010801c42emr4537927637.23.1743791454548; 
 Fri, 04 Apr 2025 11:30:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b4950sm3726763b3a.153.2025.04.04.11.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:30:54 -0700 (PDT)
Message-ID: <9393c0be-541b-4a17-a27c-23cb96d09f76@linaro.org>
Date: Fri, 4 Apr 2025 11:30:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 00/39] single-binary: Make hw/arm/ common
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <bf47e696-f63f-44b1-8451-5f00c4fa7a1d@linaro.org>
 <4c9a7757-cb6c-4cbe-a9c8-56e1f97d3988@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4c9a7757-cb6c-4cbe-a9c8-56e1f97d3988@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

T24gNC80LzI1IDExOjA0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
NC80LzI1IDE5OjEyLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC8zLzI1IDE2
OjU3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBIaSwNCj4+Pg0KPj4+
IEF0IHRoaXMgcG9pbnQgdGhpcyBzZXJpZXMgaXMgbW9zdGx5IGEgZHJhZnQgZm9yIFBpZXJy
aWNrLg0KPj4+DQo+Pj4gQWZ0ZXIgaW50cm9kdWNpbmcgdGhlIGdlbmVyaWMgVGFyZ2V0SW5m
byBBUEkgWypdLCB3ZSBpbXBsZW1lbnQNCj4+PiB0aGUgQVJNIHZhcmlhbnRzLCB0aGVuIHVz
ZSB0aGUgQVBJIHRvIHJlbW92ZSB0YXJnZXQtc3BlY2lmaWMgY29kZSwNCj4+PiBhbGxvd2lu
ZyB0byBldmVudHVhbGx5IHJlbW92ZSB0aGUgdGFyZ2V0LXNwZWNpZmljIGFybV9zc1tdIHNv
dXJjZQ0KPj4+IHNldCBpbiBtZXNvbi5idWlsZCwgaGF2aW5nIGFsbCBvYmplY3RzIGluIGFy
bV9jb21tb25fc3NbXS4NCj4+PiBWYXJpb3VzIGhlYWRlciBjbGVhbnVwcyBhcmUgbmVjZXNz
YXJ5IGJlZm9yZSBnZXR0aW5nIHRoZXJlLg0KPj4+DQo+Pg0KPj4gQXMgdGhlcmUgYXJlIHNv
bWUgY2hhbmdlcyBhc2tlZCBvbiB0aGlzIEFQSSwgSSB0aGluayBpdCdzIGJldHRlciBpZiB3
ZQ0KPj4gcmV2aWV3IHRoaXMgc2VyaWVzIGxhdGVyLg0KPiANCj4gSSB0aGluayBJIG1pc3Vu
ZGVyc3Rvb2QgeW91ciBjb21tZW50cyBpbiBteSBzZXJpZXMgWypdIHJld29ya2luZw0KPiBh
cm1fY3B1X2hhc19mZWF0dXJlKCksIEkgdGhvdWdodCB5b3Ugd2FudGVkIHRvIHNlZSB3aHkg
aXQgd2FzIGZvcg0KPiAoY29tcGxldGluZyB5b3VyICdNYWtlIGh3L2FybS8gY29tbW9uJyBl
ZmZvcnQpLg0KPiANCg0KVGhlIGFzc3VtcHRpb24gbWFkZSBpbiB0aGUgY3VycmVudCBzZXJp
ZXMgaXMgdGhhdCB3ZSBzaG91bGQgcmVtb3ZlIA0KZGVwZW5kZW5jeSBvbiBjcHUuaCBpbiB0
YXJnZXQgY29tbW9uIGNvZGUuDQpIb3dldmVyLCB0aGlzIGFzc3VtcHRpb24gaXMgZmFsc2Us
IGFuZCB3ZSBjYW4gc2ltcGx5IGluY2x1ZGUgY3B1LmggYW5kIA0KZG8gdGhlIHNhbWUgYXMg
YmVmb3JlLiBGb3IgdGFyZ2V0L2FybS9jcHUuaCwgaXQncyBwb3NzaWJsZSBiZWNhdXNlIGl0
IA0Kd2FzIGNsZWFuZWQgdXAgcHJldmlvdXNseSB0byBub3QgaGF2ZSBhbnkgdGFyZ2V0IHNw
ZWNpZmljIGRlZmluaXRpb24gDQoocmVtb3ZpbmcgYW55IHBvaXNvbmVkIFRBUkdFVF8gb3Ig
Q09ORklHXyBieSBleHBvc2luZyBtYXRjaGluZyBmaWVsZHMgDQppbmNvbmRpdGlvbm5hbGx5
KS4NCg0KPj4gSSdsbCBzdGlsbCBjb21tZW50IGEgZmV3IGNvbW1pdHMgaGVyZSB0aGF0IHBv
aW50IHNvbWUgcHJvYmxlbXMgaW4gdGhlDQo+PiBhcHByb2FjaC4NCj4gDQo+IFRoYW5rcyEN
Cj4gDQo+IFsqXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL2NlY2Jh
YjBmLTU2ZjItNDM0YS04NTA4LThhNGRmMjk5MjI1OUBsaW5hcm8ub3JnLw0KPiANCg0K

