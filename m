Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4712E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNzfM-00080T-WA; Wed, 18 Dec 2024 14:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNzfL-0007yJ-83
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:25:03 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNzfI-0002Vy-9k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:25:02 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2166f1e589cso451085ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734549899; x=1735154699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JfUscx0jbEjPXvLFeN/Jykxlq3K75yKfPSrrMS76CQw=;
 b=w5M7Le6dOeLGAmiAZ5hZyrr2mDt8Zu4ilv9lfycctJkGKQZX5g0hTpSMTHK/KZ0YzZ
 PLDlPMGtaBz4ETTPb76vfDGPKp6mYRHgt6Dp9qhkb2k4FoLAHF478Ld/t/Y9/KOSahey
 jToDIGt6+RcI27m4SBV+jAImypwfBP86cnrt4Rf5Wf20gDTYDhWmANyVvD4emLx5/RK3
 5XeSbxzGNlB8WCoD7oJjjNtGttiQvwjlFvFwFw8XsT4At4Q4d3022jdlddEcX0e5nW3V
 YyiMRb/RF7fP/7LKx3r1hDcMVhUwZMjoClIBxrY8l93ATEDiUdF6Me12NnUqQgAqH7Wh
 9hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734549899; x=1735154699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JfUscx0jbEjPXvLFeN/Jykxlq3K75yKfPSrrMS76CQw=;
 b=R6/VT7fIGOFfe+d2kSp/sZftpDIShGytBLbc2lJI0K944RrLNwIBZCVryrBvfzPn8b
 1TcUds3ziMrm4ZmvMcCU1eTC/Z50Qn4YQiZCR3/LeN1/73PXqfio0gNk3co3L/77aZba
 Hcb1Qh5kHpIZFqnuZHBUjLUzgq/jaCgRSZh5/0Gtqjui2KpLPRIJpWPyaFDZS7KDWHd/
 klIFPVdfq/0J2VY1jQQmAX3Fd2aHS5Ow0hRRCKh/rJM2Ck97weX9VXDhSqQ1Av0+a1ze
 I657t0e8AddMI5tUV9rrWu1gG8cRRmOpSrVwnKtWPmge850yDH4cezMT2Ac1Snmul9qT
 FVWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWe7u1mWOCfSpDnCNNcvlupmdZlqdBYftSznB4FXcYOL+gNU9Bxhazjc+rWmEsT68NikBtXGwAXR5a@nongnu.org
X-Gm-Message-State: AOJu0YylNhKaC/yopQfUkHB6S9Zn6m1NBhbKjN4MM07tTcUrlrZMBwxN
 8AJvxZPq/FEP0XgxGzqFqxQToe4tSxlBC0zebrfS2wKvJSrnWaf//FRhGq2/uUo=
X-Gm-Gg: ASbGncu2JQb+XHMYhCD+iWnD9ALZzGBXLWnxfSR5udsHzSmhf9uUnA9MoWbmzIB0zJ7
 IeKM87rw4+lnUqg3a1vPqB1O3d5PKhKwROb3bcFM3r3eEuqmJe5x/GMUdtd5ufT0q3P8fOr6Mvv
 AyTluSg52Fw1d9NsZiol/cf/piVgEaqrAAqwzw9DqYkf2KLh0VlASUBvVvN9qcLm5pj6VxXbLS8
 hirpXMNef7F/xMMgLRUZbwluGIOJ/RpkFoT0bAcmjo4nCldF2t+LjdQkK0/Jl146BpCpA==
X-Google-Smtp-Source: AGHT+IFapxYW2N/XWO5iA9/GwEjqm25mur3b3FIfIUFRVMvvXKUDEypEZbbf0ziLoxqOCwpp5U4Uxw==
X-Received: by 2002:a17:903:944:b0:217:803a:e47a with SMTP id
 d9443c01a7336-218d6fcd456mr68609975ad.4.1734549898714; 
 Wed, 18 Dec 2024 11:24:58 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb35esm80013535ad.62.2024.12.18.11.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 11:24:58 -0800 (PST)
Message-ID: <1c5c58c6-a5aa-47bf-8098-c31bad65633b@linaro.org>
Date: Wed, 18 Dec 2024 11:24:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
 <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
 <87pllq69l6.fsf@draig.linaro.org>
 <CAFEAcA_xe5QEPsrByM8ems_rxt-KsVRAgkKhGk24X-1J0vcCDA@mail.gmail.com>
 <75ff92e0-7384-4af4-bc9f-64a6b0febc9f@linaro.org>
 <CAFEAcA8YNcft8KU8mytHv+H71L7L8d=QBgQmSAmq9J7Ny23=tA@mail.gmail.com>
 <48dd3afc-d78d-4bd9-9392-873d5a8ac26a@linaro.org>
 <f2bdc8f2-5735-400c-b15f-06289b467826@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f2bdc8f2-5735-400c-b15f-06289b467826@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMTIvMTgvMjQgMTE6MjAsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBPbiAxMi8x
OC8yNCAxMzowOCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IE9uIDEyLzE4LzI0IDA1
OjUxLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0KPj4+IE9uIFR1ZSwgMTcgRGVjIDIwMjQgYXQg
MjE6MDgsIFBpZXJyaWNrIEJvdXZpZXINCj4+PiA8cGllcnJpY2suYm91dmllckBsaW5hcm8u
b3JnPiB3cm90ZToNCj4+Pj4NCj4+Pj4gT24gMTIvMTcvMjQgMDI6MzgsIFBldGVyIE1heWRl
bGwgd3JvdGU6DQo+Pj4+PiBPbiBUdWUsIDE3IERlYyAyMDI0IGF0IDA3OjQwLCBBbGV4IEJl
bm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4g
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6
DQo+Pj4+Pj4+IEkgdGhpbmsgdGhpcyBpcyBzdGlsbCBhIGNoYW5nZSB3b3J0aCB0byBkbywg
YmVjYXVzZSBwZW9wbGUgY2FuIGdldCBhDQo+Pj4+Pj4+IDEwMCUgc3BlZWR1cCB3aXRoIHRo
aXMgc2ltcGxlIGNoYW5nZSwgYW5kIGl0J3MgYSBiZXR0ZXIgZGVmYXVsdCB0aGFuDQo+Pj4+
Pj4+IHRoZSBwcmV2aW91cyB2YWx1ZS4NCj4+Pj4+Pj4gSW4gbW9yZSwgaW4gY2FzZSBvZiB0
aGlzIG1pZ3JhdGlvbiBzY2VuYXJpbywgUUVNVSB3aWxsIGltbWVkaWF0ZWx5DQo+Pj4+Pj4+
IGFib3J0IHVwb24gYWNjZXNzaW5nIG1lbW9yeSB0aHJvdWdoIGEgcG9pbnRlci4NCj4+Pj4+
Pj4NCj4+Pj4+Pj4gSSdtIG5vdCBzdXJlIGFib3V0IHdoYXQgd291bGQgYmUgdGhlIGJlc3Qg
d2F5IHRvIG1ha2UgdGhpcyBjaGFuZ2UgYXMNCj4+Pj4+Pj4gc21vb3RoIGFzIHBvc3NpYmxl
IGZvciBRRU1VIHVzZXJzLg0KPj4+Pj4+DQo+Pj4+Pj4gU3VyZWx5IHdlIGNhbiBvbmx5IGhv
bm91ciBhbmQgYXBwbHkgdGhlIG5ldyBkZWZhdWx0IHRvIC1jcHUgbWF4Pw0KPj4+Pj4NCj4+
Pj4NCj4+Pj4gV2l0aCBhbGwgbXkgcmVzcGVjdCwgSSB0aGluayB0aGUgY3VycmVudCBkZWZh
dWx0IGlzIHdyb25nLCBhbmQgaXQgd291bGQNCj4+Pj4gYmUgc2FkIHRvIGtlZXAgaXQgd2hl
biBwZW9wbGUgZG9uJ3QgcHJlY2lzZSBjcHUgbWF4LCBvciBmb3Igb3RoZXIgY3B1cw0KPj4+
PiBlbmFibGluZyBwb2ludGVyIGF1dGhlbnRpY2F0aW9uLg0KPj4+Pg0KPj4+PiBJbiBhbGwg
b3VyIGNvbnZlcnNhdGlvbnMsIHRoZXJlIHNlZW1zIHRvIGJlIGEgZm9jdXMgb24gY2hvb3Np
bmcgdGhlDQo+Pj4+ICJmYXN0ZXN0IiBlbXVsYXRpb24gc29sdXRpb24gdGhhdCBzYXRpc2Zp
ZXMgdGhlIGd1ZXN0IChiZWhhdmlvdXIgd2lzZSkuDQo+Pj4+IEFuZCwgZm9yIGEgcmVhc29u
IEkgaWdub3JlLCBwb2ludGVyIGF1dGhlbnRpY2F0aW9uIGVzY2FwZWQgdGhpcyBydWxlLg0K
Pj4+DQo+Pj4gSSB0aGluayB0aGUgcmVhc29uIGlzIGp1c3QgdGhhdCB3ZSBkaWRuJ3QgdW5k
ZXJzdGFuZCBob3cgbXVjaA0KPj4+IG9mIGEgcGVyZm9ybWFuY2UgaGl0IHRoZSBhcmNoaXRl
Y3RlZCBhbGdvcml0aG0gZm9yIHBvaW50ZXIgYXV0aA0KPj4+IGlzIGluIGVtdWxhdGlvbi4g
U28gd2UgdG9vayBvdXIgZGVmYXVsdCBhcHByb2FjaCBvZiAiaW1wbGVtZW50DQo+Pj4gd2hh
dCB0aGUgYXJjaGl0ZWN0dXJlIHNheXMiLiBUaGVuIGxhdGVyIHdoZW4gd2UgcmVhbGlzZWQg
aG93DQo+Pj4gYmFkIHRoZSBlZmZlY3Qgd2FzIHdlIGFkZGVkIGluIGEgZmFzdGVyIGltcGRl
ZiBhdXRoZW50aWNhdGlvbg0KPj4+IGFsZ29yaXRobSwgYnV0IHdlIHB1dCBpdCBpbiBhcyBu
b3QtdGhlLWRlZmF1bHQgYmVjYXVzZSBvZiBvdXINCj4+PiB1c3VhbCBiaWFzIHRvd2FyZHMg
ImRvbid0IGNoYW5nZSBleGlzdGluZyBiZWhhdmlvdXIiLg0KPj4+DQo+Pg0KPj4gSSB1bmRl
cnN0YW5kIHRoZSByZWFzb24gYmVoaW5kIHRoZSBjdXJyZW50IGNob2ljZS4NCj4+IEZvciBt
eSBwZXJzb25hbCBrbm93bGVkZ2UsIGlzIHRoZXJlIGEgUUVNVSBwb2xpY3kgZm9yICJicmVh
a2luZyBjaGFuZ2VzIj8NCj4+DQo+Pj4+IEkgdW5kZXJzdGFuZCB0aGUgY29uY2VybiByZWdh
cmRpbmcgcmV0cm8gY29tcGF0aWJpbGl0eSwgYnV0IGl0IHdvdWxkIGJlDQo+Pj4+IGJldHRl
ciB0byBhc2sgcG9saXRlbHkgKHdpdGggYW4gZXJyb3IgbWVzc2FnZSkgdG8gcGVvcGxlIHRv
IHJlc3RhcnQNCj4+Pj4gdGhlaXIgdmlydHVhbCBtYWNoaW5lcyB3aGVuIHRoZXkgdHJ5IHRv
IG1pZ3JhdGUsIGluc3RlYWQgb2YgYmVpbmcgc3R1Y2sNCj4+Pj4gd2l0aCBhIHNsb3cgZGVm
YXVsdCBmb3JldmVyLg0KPj4+PiBJbiBtb3JlLCB3ZSBhcmUgdGFsa2luZyBvZiBhIHRjZyBz
Y2VuYXJpbywgZm9yIHdoaWNoIEknbSBub3Qgc3VyZSBwZW9wbGUNCj4+Pj4gdXNlIG1pZ3Jh
dGlvbiBmZWF0dXJlIChzYXZlL3Jlc3RvcmUpIGhlYXZpbHksIGJ1dCBJIG1heSBiZSB3cm9u
ZyBvbiB0aGlzLg0KPj4+Pg0KPj4+PiBCZXR3ZWVuIHRoZSByaXNrIG9mIGJyZWFraW5nIG1p
Z3JhdGlvbiAod2l0aCBhIHBvbGl0ZSBlcnJvciBtZXNzYWdlKSwNCj4+Pj4gYW5kIGhhdmlu
ZyBhIGRlZmF1bHQgdGhhdCBpcyAxMDAlIGZhc3RlciwgSSB0aGluayBpdCB3b3VsZCBiZSBi
ZXR0ZXIgdG8NCj4+Pj4gZmF2b3IgdGhlIHNlY29uZCBvbmUuIElmIGl0IHdvdWxkIGJlIGEg
NSUgc3BlZWR1cCwgSSB3b3VsZCBub3QgYXJndWUsDQo+Pj4+IGJ1dCBzbG93aW5nIGRvd24g
ZXhlY3V0aW9uIHdpdGggYSBmYWN0b3Igb2YgMiBpcyByZWFsbHkgYSBsb3QuDQo+Pj4NCj4+
PiBUaGUgcG9pbnQgaGVyZSBhYm91dCAiYnJlYWtpbmcgbWlncmF0aW9uIiBpcyB0aGF0IHdl
IGhhdmUgYSBzdHJvbmcNCj4+PiBzZXQgb2YgcnVsZXM6DQo+Pj4gIMKgICogaWYgeW91IHNh
eSAiLW1hY2hpbmUgdmlydC04LjIiIHlvdSBnZXQgImV4YWN0bHkgdGhlIGJlaGF2aW91cg0K
Pj4+ICDCoMKgwqAgdGhhdCB0aGUgJ3ZpcnQnIG1hY2hpbmUgdHlwZSBoYWQgaW4gUUVNVSA4
LjIsIGFuZCBpdCBpcw0KPj4+ICDCoMKgwqAgbWlncmF0aW9uIGNvbXBhdGlibGUNCj4+PiAg
wqAgKiB3ZSBjYW4gbWFrZSBjaGFuZ2VzIHRoYXQgYXJlIG5vdCBtaWdyYXRpb24gY29tcGF0
aWJsZSBvbmx5IGlmIHdlDQo+Pj4gIMKgwqDCoCBlbnN1cmUgdGhhdCB0aGV5IGFyZSBub3Qg
YXBwbGllZCB0byBvbGRlciB2ZXJzaW9uZWQgbWFjaGluZSB0eXBlcw0KPj4+ICDCoMKgwqAg
KG9yIGlmIHRoZXkncmUgdG8gZGV2aWNlcyB0aGF0IGFyZSBvbmx5IHVzZWQgaW4gbWFjaGlu
ZXMgd2hpY2gNCj4+PiAgwqDCoMKgIGRvIG5vdCBoYXZlIHZlcnNpb25lZCBtYWNoaW5lIHR5
cGVzIGF0IGFsbCkNCj4+PiAgwqAgKiBUQ0cgJy1jcHUgbWF4JyBpcyBhIHNwZWNpYWwgY2Fz
ZTogaXQgaXMgbm90IGEgZml4ZWQgdGhpbmcsIGFuZCBzbw0KPj4+ICDCoMKgwqAgaXQgbWF5
IGFjcXVpcmUgbmV3IG5vbi1taWdyYXRpb24tY29tcGF0aWJsZSBjaGFuZ2VzIGJldHdlZW4g
dmVyc2lvbnMNCj4+PiAgwqDCoMKgIChhbmQgc28gaWYgeW91IGNhcmUgYWJvdXQgVk0gbWln
cmF0aW9uIGNvbXBhdCB5b3UgZG9uJ3QgdXNlIGl0KTsNCj4+PiAgwqDCoMKgIGJ1dCB0aGlz
IGlzIG5vdCB0cnVlIG9mIHRoZSBuYW1lZCBDUFUgdHlwZXMgdGhhdCBtYXRjaCByZWFsDQo+
Pj4gIMKgwqDCoCBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbnMNCj4+Pg0KPj4+IFRoaXMgcGF0
Y2ggYXMgaXQgc3RhbmRzIHdpbGwgbm90IHByZXNlcnZlIHRoZSBtaWdyYXRpb24NCj4+PiBn
dWFyYW50ZWVzIHRoYXQgd2UgbWFrZS4gU28gd2UgbmVlZCB0byBmaXggaXQgYnkgZWl0aGVy
Og0KPj4+ICDCoCAqIG9ubHkgbWFraW5nIHRoZSBkZWZhdWx0IGNoYW5nZSBvbiAtY3B1IG1h
eA0KPj4+ICDCoCAqIG1ha2luZyB0aGUgZGVmYXVsdCBjaGFuZ2UgYmUgYm91bmQgdG8gdmVy
c2lvbmVkIHR5cGVzDQo+Pj4NCj4+DQo+PiBJJ20gbm90IHN1cmUgdG8gZm9sbG93IHlvdSBv
biB0aGlzIHNlY29uZCBhcHByb2FjaC4gVGhlIGNwdSBpcyBub3QgdmVyc2lvbmVkLCBhbmQg
aWYNCj4+IHNvbWVvbmUgdXNlIC1tYWNoaW5lIHZpcnQgKG5vbiB2ZXJzaW9uZWQpLCBpcyB0
aGVyZSBhIGd1YXJhbnRlZSBpdCBzaG91bGQgc3RheSBwb3NzaWJsZSB0bw0KPj4gbWlncmF0
ZT8NCj4+DQo+PiBJbiBvdGhlciB3b3JkcywgY2FuIHdlIGJyZWFrIHRoZSBtaWdyYXRpb24g
d2l0aCAiLW1hY2hpbmUgdmlydCAtY3B1IG1vZGVsIj8NCj4gDQo+IFllcywgYmVjYXVzZSAi
dmlydCIgaXMgYW4gYWxpYXMgZm9yICJ2aXJ0LTxjdXJyZW50PiIuDQo+IEZvbGtzIHdobyBy
ZWx5IG9uIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5IG11c3QgdXNlICJ2aXJ0LTkuMiIgZXRj
Lg0KPg0KDQpUaGFua3MsIEkgZGlkbid0IHJlYWxpemUgdGhpcywgYW5kIGl0IG1ha2VzIHNl
bnNlIG5vdy4NClRoZW4sIEknbGwgY2hhbmdlIHRoZSBiZWhhdmlvdXIgZm9yIGFsbCBjcHVz
IHVzaW5nIHRoZSBzYW1lIHBhdHRlcm4gYXMgDQpjbnRmcmVxLg0KDQo+IFRodXMgaGF2aW5n
IGEgZ2xvYmFsIHByb3BlcnR5IHNldCBieSB2ZXJzaW9uIDkuMiBjb21wYXQgd2hpY2ggc2F5
cyAidXNlIHFhcm1hNSBhcyBkZWZhdWx0DQo+IHBhYyIgd2lsbCB3b3JrLiAgSXQncyBhIGxp
dHRsZSBiYWNrd2FyZCBoYXZpbmcgdGhlIHZlcnNpb24gb24gdGhlIGJvYXJkLCBub3QgdGhl
IGNwdSwgYnV0DQo+IHdlJ3ZlIGRvbmUgaXQgYmVmb3JlLCBhcyBQZXRlciBtZW50aW9uZWQg
cmUgY3B1IGNsb2NrIHRpbWUgYmFzZS4NCj4NCg0KV2UgY2FuIHNlZSBpdCBhcyAidGhlIHBs
YXRmb3JtIGNvbmZpZ3VyZWQgc29tZSBkZXZpY2VzIHNwZWNpZmljYWxseSIsIA0KYW5kIGl0
J3MgYW4gYWNjZXB0YWJsZSBhbmQgbXVjaCBzaW1wbGVyIHNvbHV0aW9uIHRoYW4gaGF2aW5n
IHZlcnNpb25lZCANCmNwdSBmb3IgdGhpcyB1c2UgY2FzZS4NCg0KPiANCj4gcn4NCg0K

