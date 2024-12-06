Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB0AE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 20:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJf89-0004Pl-0V; Fri, 06 Dec 2024 15:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJf86-0004Pd-O2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 15:40:50 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJf85-00035G-2M
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 15:40:50 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7fd21e4aa2eso1175363a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733517647; x=1734122447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s14vva1wF8cmigYTWbjEqRFV/MQBehFISGn2aiOGDJM=;
 b=aC0i4+LC29p4PzstU0Hq4kpgk/Z+dWnOeqBauks0wUkc7jHV/JzpNg7eIAnXlStnfr
 cf1PxOIndMnAOqqHbpQHtI0EHHQYiYyb+0kZWj23EbP9YGYwA0CX7PL11NbRzpQ0FlyX
 9rYDiwvNDr3Q74P50ZPrWewzHO7CsmOuvoSoWRm/l9oVPEsrlncWqA9AIMRFLiWMD4GE
 T+zJrPOiteNKV1AJqEQQGtT8k7QNEhdV+akF4a6Z57i3N9/6US9+9IHE0zXF58W6VXRB
 m8FdoB4hIX3gYPDX9+TkyHV8qske7X6cZhN+bZ1tz9G4aK/WLQyL9yrjusW4y+jEdKYB
 uLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733517647; x=1734122447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s14vva1wF8cmigYTWbjEqRFV/MQBehFISGn2aiOGDJM=;
 b=YsXMm13jTjrf7jLwoc26zfTw5YrQJfOGVukcs1R+7RLqX08T6j4qFDHtuo1Hp/MEGW
 6tCCklFdKs1qKDODZDNfZClmhVG31Nq/eoYsZvYtUrQWkPezlBZvZKAVNtPTMkNWQ7Ks
 ItBxXfvZRJGkB53Sc2ZSHrMehfiK+NJkD42eIapZxZ8ngagZ+R+RxIjmPDUOB9HsjoXz
 meAJbOOOGjnKsUY6Z39yNI9dHbXp54KXn4d1lAjZpTW3qn8BbdCHqfFS0D+KPMTTolpM
 hIErfED61pO5aCfbOgoJfAlhpNWIBdnwQil4sin2JYng6KmHxlEO8tarQzabFvC7vtsK
 fSYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgImsMnVRnmRQswQwfAIJA1E4sk0YP1YTdFX4VWkxUvJIcDD/JxlFZFjKqtWsUlLcYi9bCFT99JWnB@nongnu.org
X-Gm-Message-State: AOJu0Yw7DaEYqVztc/U5KdjisvdfkqU2fgY/p9HuhW1iQ0e2N3CKdK/x
 CtKsTZl9G8ePWMf09d0TnHtcje+Ch2na4Du/qO7v1N/e9bCEUPJBLcO7L8zLuU0=
X-Gm-Gg: ASbGncuyEhdNhcfxF90EkpnRwm6SoLJzfm2XjIN+CrksVMDqa1aE4Sg1Mz7xQ/LyYIT
 T9l6jM5wVTqtYuxDtcIJBFs9DMgOubLJD+tAJlrXGWGCfCJjvzbSyDAdRGB7w4OOOy/GPmHrs1E
 EWOoE0N7/h9LbeKtPyu6OKo05wl63QeC2q/lzso2/PiVyNZetGvfivSQ14d7TO96cO8yC5IJYfW
 Aj1sYrJ9JT29xHnHh5M/mivhWbU+e1V6G7gwwXBv7rvaiN6/35Mm0E3cWuoBmbygJ0xALIfCsrV
 If7LKuOcIXR/g/oeR2JvLw==
X-Google-Smtp-Source: AGHT+IFxrevtBViW6mDCEUjxoWbXSjjlHdwH2FCgw9ILoCrXkRyvAv1llKX3RauoSzsMkWc7lN+HZA==
X-Received: by 2002:a05:6a20:c78d:b0:1e0:df27:10d6 with SMTP id
 adf61e73a8af0-1e1870c9084mr6722289637.23.1733517647020; 
 Fri, 06 Dec 2024 12:40:47 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd157ad3aesm3044728a12.53.2024.12.06.12.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 12:40:46 -0800 (PST)
Message-ID: <70666b89-1f04-4615-ae16-e1eefac2a446@linaro.org>
Date: Fri, 6 Dec 2024 12:40:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
To: Richard Henderson <richard.henderson@linaro.org>,
 Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
 <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
 <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
 <c850ee89e15d2775e7c0137a218286e7060874dd@nut.email>
 <867d8a3a-ddf4-4655-9bfc-51c1a2ad8203@linaro.org>
 <b02abe90-d57b-4010-aace-1b47d92e5c26@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b02abe90-d57b-4010-aace-1b47d92e5c26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

T24gMTIvNi8yNCAxMTo0MiwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDEyLzYv
MjQgMTM6MDIsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAxMi82LzI0IDAwOjQy
LCBKdWxpYW4gR2FueiB3cm90ZToNCj4+PiBIaSBQaWVycmljaywNCj4+Pg0KPj4+IERlY2Vt
YmVyIDUsIDIwMjQgYXQgMTE6MjggUE0sICJQaWVycmljayBCb3V2aWVyIiB3cm90ZToNCj4+
Pj4gT24gMTIvNS8yNCAxMzoyMiwgSnVsaWFuIEdhbnogd3JvdGU6DQo+Pj4+PiAgwqAgRGVj
ZW1iZXIgNSwgMjAyNCBhdCA2OjMwIFBNLCAiUGllcnJpY2sgQm91dmllciIgd3JvdGU6DQo+
Pj4+Pj4gV2UgY2FuIHN0b3JlIHRoZSBuZXh0X2V4cGVjdGVkIHBjIGZvciBlYWNoIGluc3Ry
dWN0aW9uIChmcm9tIGN1cnJlbnRfaW5zdHJ1Y3Rpb24gKw0KPj4+Pj4+IGluc25fbGVuZ3Ro
KSwgYW5kIHdlIHNob3VsZCBiZSBhYmxlIHRvIGNvbXBhcmUgdGhhdCB3aXRoIHRoZSBleHBl
Y3RlZCBmcm9tX3BjLg0KPj4+Pj4+ICDCoCBUaGlzIGlzIG1vc3RseSB3aGF0IGNvbnRyaWIv
cGx1Z2lucy9jZmxvdy5jIGRvZXMuDQo+Pj4+Pj4NCj4+Pj4+PiAgwqAgV2l0aCB0aGF0LCB3
ZSBjYW4gdGVzdCBmcm9tX3BjLg0KPj4+Pj4+DQo+Pj4+PiAgwqAgSSdtIG5vdCBjb25maWRl
bnQgdGhhdCB0aGlzIHdpbGwgd29yayByZWxpYWJseSBmb3IgYnJhbmNoLCBqdW1wIGFuZA0K
Pj4+Pj4gIMKgIG90aGVyICJpbnRlcmVzdGluZyIgaW5zdHJ1Y3Rpb25zLiBCdXQgSSBjYW4g
aGF2ZSBhIGNsb3NlciBsb29rIGF0IHRoZQ0KPj4+Pj4gIMKgIGNmbG93IHBsdWdpbiBhbmQg
dHJ5IHRvIGZpZ3VyZSBvdXQgaG93IHRoYXQgcGx1Z2luIGhhbmRsZXMgdGhvc2UgY2FzZXMu
DQo+Pj4+Pg0KPj4+PiBJdCB3b24ndCB3b3JrIGZvciBsYXRlc3QgaW5zdHJ1Y3Rpb25zIGlu
IGEgdGIgKGJlY2F1c2Ugd2UgZG9uJ3Qga25vdyB3aGF0IHdpbGwgYmUgdGhlDQo+Pj4+IG5l
eHQgb25lKSwgYnV0IHNob3VsZCBiZSBnb29kIGZvciBhbGwgdGhlIG90aGVycyBjYXNlcy4N
Cj4+Pg0KPj4+IElJVUMgcWVtdSB3aWxsIHNjaGVkdWxlIGludGVycnVwdHMgIm9wcG9ydHVu
aXN0aWNhbGx5IiBiZXR3ZWVuIHRiDQo+Pj4gZXhlY3V0aW9ucy4gSWYgdGhhdCdzIHRoZSBj
YXNlIHdlJ2xsIG9ic2VydmUgaW50ZXJydXB0cyBleGNsdXNpdmVseQ0KPj4+IGFmdGVyIHRo
ZSBsYXN0IGluc3RydWN0aW9uIGluIGEgdGIuIFRoYXQgc3RyaWtlcyBtZSBhcyBhIHNlcmlv
dXMNCj4+PiBsaW1pdGF0aW9uLg0KPj4+DQo+Pg0KPj4gVG8gcmV1c2UgZmFuY3kgdm9jYWJ1
bGFyeSwgbWF5YmUgd2Ugc2hvdWxkIGhhdmUgYSBkaXN0aW5jdGlvbiBiZXR3ZWVuIGluZmVy
YWJsZQ0KPj4gaW50ZXJydXB0aW9ucyAoaW50ZXJydXB0IGluc3RydWN0aW9uKSBhbmQgdW5p
bmZlcmFibGUgaW50ZXJydXB0cywgdHJpZ2dlcmVkIGJ5IGFuIGV4dGVybmFsDQo+PiBldmVu
dC4NCj4+DQo+PiBJbiB0aGUgbGF0dGVyLCBpdCAqbWlnaHQqIGJlIGFjY2VwdGFibGUgdG8g
bm90IHByb3ZpZGUgYSBmcm9tX3BjIChsZXQncyBzYXkgYSB2YWx1ZSAwKSwNCj4+IGJlY2F1
c2UgdGhlcmUgaXMgbm8gdXNlZnVsIGluZm9ybWF0aW9uIGluIGl0c2VsZiwgZXhjZXB0IGNy
ZWF0aW5nIHJhbmRvbSBlZGdlcyBpbiB0aGUNCj4+IGNvbnRyb2wgZmxvdyBncmFwaCwgd2hp
Y2ggd2UgZG9uJ3Qgd2FudCB0byBkby4NCj4+DQo+PiBXaGF0IGRvIHlvdSB0aGluayBvZiBp
dD8NCj4gDQo+IEkgdGhpbmsgeW91IGJvdGggYXJlIG92ZXItY29tcGxpY2F0aW5nIHRoaW5n
cy4NCj4gDQo+IEFsd2F5cywgZW52LT5wYyAob3Igd2hhdGV2ZXIpIHdpdGhpbiBjYy0+Y3B1
X2V4ZWNfaW50ZXJydXB0ICppcyogd2hlcmUgdGhlIGludGVycnVwdCBpcw0KPiByZWNvZ25p
emVkLCBhbmQgKmlzKiB3aGVyZSB0aGUgZGlzY29udGludWl0eSBvY2N1cnMuICBSZXBvcnQg
dGhhdC4NCj4gDQoNCkRvIHdlIGhhdmUgYW4gYXJjaGl0ZWN0dXJlIGFnbm9zdGljIHBjIHJl
cHJlc2VudGF0aW9uLCBvciBkbyB3ZSBoYXZlIHRvIA0KYWRkIHRoaXMgZm9yIGV2ZXJ5IHRh
cmdldCBpbiB7YXJjaH1fY3B1X2V4ZWNfaW50ZXJydXB0Pw0KDQpCZXlvbmQgdGhlIHNjb3Bl
IG9mIGludGVycnVwdGlvbnMsIGFyZSB3ZSBndWFyYW50ZWVkIHRoaXMgaW5zdHJ1Y3Rpb24g
DQpwb2ludGVyIChwZXIgYXJjaCkgaXMgYWx3YXlzIHVwZGF0ZWQgYmV0d2VlbiBpbnN0cnVj
dGlvbnM/IEFueSBjb3JuZXIgY2FzZXM/DQoNCj4gSnVzdCBiZWNhdXNlIHNvbWUgZGV2aWNl
IGludGVycnVwdHMgYXJlIGRlZmVycmVkIHRvIHRoZSBlbmQgb2YgdGhlIFRCLCB0aGF0IG1h
a2VzIG5vDQo+IGRpZmZlcmVuY2UuICBUaGVyZSBpcyBubyAicmlnaHQiIGFuc3dlciBmb3Ig
dGltaW5nIGJldHdlZW4gZXhlY3V0aW9uIGFuZCBhc3luY2hyb25vdXMNCj4gaW50ZXJydXB0
cy4NCj4gDQo+IA0KPiByfg0KDQo=

