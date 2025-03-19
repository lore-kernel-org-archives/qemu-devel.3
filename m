Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9CBC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 23:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv2XA-0003iY-1c; Wed, 19 Mar 2025 19:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2X7-0003hZ-OD
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:09:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2X5-0003Uw-3L
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:09:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso2622845ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742425745; x=1743030545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vc1QjsrUNop6NT34LfjdBlMP7nwjGJRKQWt7xwjFmPw=;
 b=KjBFRBKIHfmUIw8zmODQSd9TVMG2IsseBbVmVXRNMDsioRr/d69lxLD60A3o5AE2rR
 byOEWwLifo2S2JzkZSvovjfIkBCothH89eP0F3iYw8fvPNL6MASGVKYGnHXPxdaChzxK
 heRdsGeRVOuSK5lpB3EkfEeqrijTRdQP+dOouAzv4dJ1/EXAvS17dDCNzddJZM8DrHTw
 UJ2ZKNNOYYetCxRN5T04ouPjP0pBGRveNTf8q5qTym2Z66HLyTs9tnAuKB2bXlhxKW7y
 PBV2iBXv5OylNwwz7Yg6cqdlj0sCGLuowBYFZ1l1nLlsRmJxt6IbWCFodvvmgDZJtUaO
 mA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742425745; x=1743030545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vc1QjsrUNop6NT34LfjdBlMP7nwjGJRKQWt7xwjFmPw=;
 b=w06SUrZJxojz531NZDgXGLnIasXi/zHU4oL7O5AXA0+Lz4wSZs1rWcsyE3ZAdb6U9b
 2iomrqRSbrsUFAqpxsGF4iFx3WEK0CuCg/ZM3XVkamuyyxB4iIlvo8kl8fXJ8Bf/krSW
 mq92yFefzxtkfp1KKx3xDieL7N5Evse3kpUqokeh/Gg5vq+zJIWFIMG3W89HZwuBq7Av
 MQWEzwRq8ICbjyl9t7oHl9ro1kd84JNFVs2xn11GLNUt3Ms+mTz1QqAhTtptS8UVz510
 wF/gQPztnzg/X3Y5/SLnQ3BZls2uPeBHHHK+N2Jh3IaI5lvCVde2ocERLxI/w7/mTtjs
 oM9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ0P8iNP2NbwC7KikTYQK7mUAFaq6tsUaxf30xEQrN6VHomHfteXJhftlB3FinRkmeol4NzRwFGN4h@nongnu.org
X-Gm-Message-State: AOJu0Yzya+8e0D97j8dBkEOLmbcHoBdj4rWj2WxDk0H1yfPGt+BE3vSz
 TnoHYm+2A3GyoPGe3lvw9P03wWy84OwfhxcR+kcV62X4RMhlnSfSS8kNvYxhkJs=
X-Gm-Gg: ASbGncvAzkh5R9NMlM6Vuk6fbuDkaBvSBf6EEb5xyr3fDzs2JSOB+JYBWE5uOdTlwoY
 3FPJO11qOiOVYOhhdTr/LzNlJBk98ukF8DTKaVxiPtMb1og/TjosHVYhkQQl5mc7WnaZP78gyv3
 KUktRszrj+9+RSTpz9naZ4zPX6uLthywnHx/pQzbMzFAamq4j12JyCUietSFkTpdiO101B6Vsrm
 hdKjMSQJQACZzLg/YR73LCNrMBupYVFgkAn4wcdraj78lj+qqPMxItai1NKC3eG85LuO8jPCj/M
 QDdIGNZ8qE+eDYWPRLUiqwqmFUpe3fEGkAmDouTN9urhlh0uy95FxMAkNQ==
X-Google-Smtp-Source: AGHT+IEybpOSsnbkV87Um3HczhmpYrkNqcFe1swRytU+M2QpreJDTcs7ZY3BLcVX4mk11SEbqt2IdQ==
X-Received: by 2002:a17:903:1a27:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-2265e7c2830mr19945575ad.26.1742425745587; 
 Wed, 19 Mar 2025 16:09:05 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba724asm121095885ad.152.2025.03.19.16.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 16:09:05 -0700 (PDT)
Message-ID: <5c977254-ee11-4604-91f0-70720d06eaeb@linaro.org>
Date: Wed, 19 Mar 2025 16:09:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/arm/cpu: define ARM_MAX_VQ once for aarch32
 and aarch64
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-10-pierrick.bouvier@linaro.org>
 <a88f54cb-73be-4947-b3be-aa12b120f07e@linaro.org>
 <52000c3d-827f-4e21-afa3-f191c6636b9d@linaro.org>
 <52c8b6dc-048c-49d2-b535-4855b9f3d26b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <52c8b6dc-048c-49d2-b535-4855b9f3d26b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMy8xOS8yNSAwMDowMywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzMvMjUgMjM6MDIsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzE4LzI1
IDExOjUwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAxOC8zLzI1
IDA1OjUxLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBUaGlzIHdpbGwgYWZmZWN0
IHpyZWdzIGZpZWxkIGZvciBhYXJjaDMyLg0KPj4+PiBUaGlzIGZpZWxkIGlzIHVzZWQgZm9y
IE1WRSBhbmQgU1ZFIGltcGxlbWVudGF0aW9ucy4gTVZFIGltcGxlbWVudGF0aW9uDQo+Pj4+
IGlzIGNsaXBwaW5nIGluZGV4IHZhbHVlIHRvIDAgb3IgMSBmb3IgenJlZ3NbKl0uZFtdLA0K
Pj4+PiBzbyB3ZSBzaG91bGQgbm90IHRvdWNoIHRoZSByZXN0IG9mIGRhdGEgaW4gdGhpcyBj
YXNlIGFueXdheS4NCj4+Pg0KPj4+IFdlIHNob3VsZCBkZXNjcmliZSB3aHkgaXQgaXMgc2Fm
ZSBmb3IgbWlncmF0aW9uLg0KPj4+DQo+Pj4gSS5lLiB2bXN0YXRlX3phIGRlcGVuZHMgb24g
emFfbmVlZGVkKCkgLT4gU01FLCBub3QgaW5jbHVkZWQgaW4gMzItYml0DQo+Pj4gY3B1cywg
ZXRjLg0KPj4+DQo+Pj4gU2hvdWxkIHdlIHVwZGF0ZSB0YXJnZXQvYXJtL21hY2hpbmUuYyBp
biB0aGlzIHNhbWUgcGF0Y2gsIG9yIGENCj4+PiBwcmVsaW1pbmFyeSBvbmU/DQo+Pj4NCj4+
DQo+PiB2bXN0YXRlX3phIGRlZmluaXRpb24gYW5kIGluY2x1c2lvbiBpbiB2bXN0YXRlX2Fy
bV9jcHUgaXMgdW5kZXIgI2lmZGVmDQo+PiBUQVJHRVRfQUFSQ0g2NC4gSW4gdGhpcyBjYXNl
IChUQVJHRVRfQUFSQ0g2NCksIEFSTV9NQVhfVlEgd2FzIGFscmVhZHkNCj4+IGRlZmluZWQg
YXMgMTYsIHNvIHRoZXJlIHNob3VsZCBub3QgYmUgYW55IGNoYW5nZS4NCj4gDQo+IEknbSBu
b3Qgc2F5aW5nIHRoaXMgaXMgaW52YWxpZCwgSSdtIHRyeWluZyB0byBzYXkgd2UgbmVlZCB0
byBkb2N1bWVudA0KPiB3aHkgaXQgaXMgc2FmZS4NCj4gDQo+PiBPdGhlciB2YWx1ZXMgZGVw
ZW5kaW5nIG9uIEFSTV9NQVhfVlEsIGZvciBtaWdyYXRpb24sIGFyZSBhcyB3ZWxsIHVuZGVy
DQo+PiBUQVJHRVRfQUFSQ0g2NCBpZmRlZnMgKHZtc3RhdGVfenJlZ19oaV9yZWcsIHZtc3Rh
dGVfcHJlZ19yZWcsDQo+PiB2bXN0YXRlX3ZyZWcpLg0KPj4NCj4+IEFuZCBmb3Igdm1zdGF0
ZV92ZnAsIHdoaWNoIGlzIHByZXNlbnQgZm9yIGFhcmNoMzIgYXMgd2VsbCwgdGhlIHNpemUg
b2YNCj4+IGRhdGEgdW5kZXIgZWFjaCByZWdpc3RlciBpcyBzcGVjaWZpY2FsbHkgc2V0IHRv
IDIuDQo+PiBWTVNUQVRFX1VJTlQ2NF9TVUJfQVJSQVkoZW52LnZmcC56cmVnc1swXS5kLCBB
Uk1DUFUsIDAsIDIpDQo+Pg0KPj4gU28gZXZlbiBpZiBzdG9yYWdlIGhhcyBtb3JlIHNwYWNl
LCBpdCBzaG91bGQgbm90IGltcGFjdCBhbnkgdXNhZ2Ugb2YgaXQuDQo+Pg0KPj4gRXZlbiB0
aG91Z2ggdGhpcyBjaGFuZ2UgaXMgdHJpdmlhbCwgSSBkaWRuJ3QgZG8gaXQgYmxpbmRseSB0
byAibWFrZSBpdA0KPj4gY29tcGlsZSIgYW5kIEkgY2hlY2tlZCB0aGUgdmFyaW91cyB1c2Fn
ZXMgb2YgQVJNX01BWF9WUSBhbmQgenJlZ3MsIGFuZCBJDQo+PiBkaWRuJ3Qgc2VlIGFueXRo
aW5nIHRoYXQgc2VlbXMgdG8gYmUgYSBwcm9ibGVtLg0KPiANCj4gWW91IGRpZCB0aGUgYW5h
bHlzaXMgb25jZSwgbGV0J3MgYWRkIGl0IGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24gc28N
Cj4gb3RoZXIgZGV2ZWxvcGVycyBsb29raW5nIGF0IHRoaXMgY29tbWl0IHdvbid0IGhhdmUg
dG8gZG8gaXQgYWdhaW4uDQo+IA0KDQpTdXJlLCBJJ2xsIGFkZCB0aGlzIHRvIHRoZSBjb21t
aXQgbWVzc2FnZS4NCg0KPj4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4+PiAtLS0NCj4+Pj4g
IMKgwqAgdGFyZ2V0L2FybS9jcHUuaCB8IDYgKy0tLS0tDQo+Pj4+ICDCoMKgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlm
ZiAtLWdpdCBhL3RhcmdldC9hcm0vY3B1LmggYi90YXJnZXQvYXJtL2NwdS5oDQo+Pj4+IGlu
ZGV4IDI3YTBkNDU1MGYyLi4wMGY3OGQ2NGJkOCAxMDA2NDQNCj4+Pj4gLS0tIGEvdGFyZ2V0
L2FybS9jcHUuaA0KPj4+PiArKysgYi90YXJnZXQvYXJtL2NwdS5oDQo+Pj4+IEBAIC0xNjks
MTEgKzE2OSw3IEBAIHR5cGVkZWYgc3RydWN0IEFSTUdlbmVyaWNUaW1lciB7DQo+Pj4+ICDC
oMKgwqAgKiBBbGlnbiB0aGUgZGF0YSBmb3IgdXNlIHdpdGggVENHIGhvc3QgdmVjdG9yIG9w
ZXJhdGlvbnMuDQo+Pj4+ICDCoMKgwqAgKi8NCj4+Pj4gLSNpZmRlZiBUQVJHRVRfQUFSQ0g2
NA0KPj4+PiAtIyBkZWZpbmUgQVJNX01BWF9WUcKgwqDCoCAxNg0KPj4+PiAtI2Vsc2UNCj4+
Pj4gLSMgZGVmaW5lIEFSTV9NQVhfVlHCoMKgwqAgMQ0KPj4+PiAtI2VuZGlmDQo+Pj4+ICsj
ZGVmaW5lIEFSTV9NQVhfVlHCoMKgwqAgMTYNCj4+Pj4gIMKgwqAgdHlwZWRlZiBzdHJ1Y3Qg
QVJNVmVjdG9yUmVnIHsNCj4+Pj4gIMKgwqDCoMKgwqDCoCB1aW50NjRfdCBkWzIgKiBBUk1f
TUFYX1ZRXSBRRU1VX0FMSUdORUQoMTYpOw0KPj4+DQo+Pg0KPiANCg0K

