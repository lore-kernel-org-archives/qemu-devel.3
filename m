Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36827C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLwO-0007NG-6K; Thu, 20 Mar 2025 15:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLwK-0007MQ-0q
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:52:29 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLwI-0002td-0C
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:52:27 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301302a328bso2242885a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742500344; x=1743105144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZelqN++iCMoSo52o6BA78GDAobp/ZBCEMMpAtQoOxRQ=;
 b=Btm7fBMqKduPWQUxyRRzvYrw41U+xPuHX/1qQaRr5ooTRUnwGNJFTOO8TwertBX9t6
 YW/5OkcMrOLEwdvj30LnlC/Y4Eqk+2qjpR54Gk3tjXEeWErBZCjfknLrnMTipqm8z4Bj
 W4bsngcNjujZXrl02z1UJi0+7QnFXS2gRK1MeY+zfN3Z+KRZYPvvlDpB5T5pV+4g5+Z0
 urvJVWD0QfwqkPLgQJa0hDsKeUjHR2k5TrQJSnPvi//QYVU0yDjej91VQvC1XpHsE/LL
 NDHhtceTGtoLeR7hMfnRYOeX5MccpV6q650l0Svvae8rv0vjsR10tqAWJOQtgfTe2arc
 eHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742500344; x=1743105144;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZelqN++iCMoSo52o6BA78GDAobp/ZBCEMMpAtQoOxRQ=;
 b=NowrRgtYPQ+Egtd8x9EYwlg3r+9O+V/FCChqUCN2qfMzImq9MIAMLaeCjqNZC6prot
 F0j9RtTXNg0R06SxRq6rFNvGQXd3wGNCckkxxnMlC1quZVDeyNz3HppxPpFLBr97FWS1
 xkPGqV/SEDYq4IGL70M5RlwMwBc2vTES/y5XNAxbGxNQ1mLUyntCqLhGMKNkngy0h+RZ
 jggVarIyr8o/76arAnrBzqp1GvvPlz2p36HKuvGK4+4BEOwnMkkWM8cr8g42YJ7+FQzJ
 TwQEB4UXP76xw/QRQvU8wyVowXcd1RZmK8EWwRRVIT/bsdVftVs96K+LwHu4eWs4XxFe
 WmPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJBxTNg8BFtfKgnlsN6KwZ1U9CJNtYRPO85ds07uhy7LA07ZNw+kSg/zEfgZ/gZu7zO/MaUrDrJ4dZ@nongnu.org
X-Gm-Message-State: AOJu0Ywwrcks6iQ86POlcmDYIfJm2jX/y/rvaRQDnc9MjyGK5LbAq4kg
 /ChJevJ4YWWGVN7a7UpOkjrhAHYnMmHd7QW3gzdaz+Fm8o8H3jMPS8KWX9XuM+0=
X-Gm-Gg: ASbGncuxGKBCDGMeIq2p+VyZbhP4clYhXc7gqZuRcyfFz9zuK01eAch8yk871apgckG
 WeCjUrPAA4n7f/L/cu86FAhLxde50YnIOg6SBXikk4A3tIIAy4lSNuVebz4/g9ifUh4DtZ83mJY
 N5+8kxPoHZrtOsOMi0KKfh0R56I6zghANxENswVrdHZqKpVyQ1ShOhtfsw6a46M3oOo35uEo0b6
 ntERD8YRM0FR+ZSZzW7aY+4ABBt210jC/+tV3EFaZoh2Z2wzzRfFf1M2U3Av2G2Mu+ChNyItqaj
 zzHxyn7uAnnX2MzTZlaXxcGpKFlOQCg06OIHE0Q3h/uIJI3pKEieSgvsHw==
X-Google-Smtp-Source: AGHT+IGJuf4ol3bGpAuFAEyjwcYYmBGqRJbdgnhUNcY24zfdKNi8RMFq0qjGpMDJHQaLBUjpTb3uLg==
X-Received: by 2002:a17:90b:4a11:b0:2ff:7b28:a51c with SMTP id
 98e67ed59e1d1-3030ff09e7fmr572817a91.34.1742500343884; 
 Thu, 20 Mar 2025 12:52:23 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f651asm1826915ad.209.2025.03.20.12.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:52:23 -0700 (PDT)
Message-ID: <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org>
Date: Thu, 20 Mar 2025 12:52:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

T24gMy8xOS8yNSAxMToyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgYWltIG9mIHRo
aXMgd29yayBpcyB0byBnZXQgcmlkIG9mIHRoZSBlbmRpYW4gYXdhcmUgaGVscGVycyBpbg0K
PiBnZGJzdHViL2hlbHBlcnMuaCB3aGljaCBkdWUgdG8gdGhlaXIgdXNlIG9mIHRzd2FwKCkg
bWVhbiB0YXJnZXQNCj4gZ2Ric3R1YnMgbmVlZCB0byBiZSBidWlsdCBtdWx0aXBsZSB0aW1l
cy4gV2hpbGUgdGhpcyBzZXJpZXMgZG9lc24ndA0KPiBhY3R1YWxseSBidWlsZCBlYWNoIHN0
dWIgb25jZSBpdCBpbnRyb2R1Y2VzIGEgbmV3IGhlbHBlciAtDQo+IGdkYl9nZXRfcmVnaXN0
ZXJfdmFsdWUoKSB3aGljaCB0YWtlcyBhIE1lbU9wIHdoaWNoIGNhbiBkZXNjcmliZSB0aGUN
Cj4gY3VycmVudCBlbmRpYW4gc3RhdGUgb2YgdGhlIHN5c3RlbS4gVGhpcyB3aWxsIGJlIGEg
bG90IGVhc2llciB0bw0KPiBkeW5hbWljYWxseSBmZWVkIGZyb20gYSBoZWxwZXIgZnVuY3Rp
b24uDQo+IA0KPiBUaGUgbW9zdCBjb21wbGV4IGV4YW1wbGUgaXMgUFBDIHdoaWNoIGhhcyBh
IGhlbHBlciBjYWxsZWQNCj4gcHBjX21heWJlX2Jzd2FwX3JlZ2lzdGVyKCkgd2hpY2ggd2Fz
IGRvaW5nIHRoaXMuDQo+IA0KPiBUaGlzIGlzIHN0aWxsIGFuIFJGQyBzbyBJJ20gaW50ZXJl
c3RlZCBpbiBmZWVkYmFjazoNCj4gDQo+ICAgIC0gaXMgdGhlIEFQSSBzYW5lDQo+ICAgIC0g
Y2FuIHdlIGF2b2lkIGxvdHMgb2YgKHVpbnQ4X3QgKikgY2FzdGluZz8NCg0KRXZlbiB0aG91
Z2ggdGhlIHNlcmllcyBoYXMgYSBnb29kIGludGVudCwgdGhlIGZhY3Qgd2UgbWFrZSBldmVy
eXRoaW5nIA0KImdlbmVyaWMiIG1ha2VzIHRoYXQgd2UgbG9zZSBhbGwgZ3VhcmFudGVlcyB3
ZSBjb3VsZCBnZXQgYnkgcmVseWluZyBvbiANCnN0YXRpYyB0eXBpbmcsIGFuZCB0aGF0IHdl
IGhhZCBwb3NzaWJpbGl0eSBvZiBtaXN0YWtlcyB3aGVuIHBhc3Npbmcgc2l6ZSANCih3aGlj
aCBoYXBwZW5lZCBpbiBwYXRjaCA0IGlmIEknbSBjb3JyZWN0KS4gQW5kIGV4cGxpY2l0IGNh
c3RpbmcgY29tZXMgDQphcyBhICpzdHJvbmcqIHdhcm5pbmcgYWJvdXQgdGhhdC4NCg0KQnkg
cGF0Y2ggNywgSSB3YXMgcmVhbGx5IGZlZWxpbmcgaXQncyBub3QgYSB3aW4gdnMgZXhwbGlj
aXQgZnVuY3Rpb25zIA0KcGVyIHNpemUuDQoNCklmIHRoZSBnb2FsIG9mIHRoZSBzZXJpZXMg
aXMgdG8gZ2V0IHJpZCBvZiBlbmRpYW4gYXdhcmUgaGVscGVycywgd2VsbCwgDQp0aGlzIGNh
biBiZSBmaXhlZCBpbiB0aGUgaGVscGVycyB0aGVtc2VsdmVzLCB3aXRob3V0IG5lZWRpbmcg
dG8gDQppbnRyb2R1Y2UgYSAiZ2VuZXJpYyIgc2l6ZSBoZWxwZXIuIE1heWJlIHdlIGFyZSB0
cnlpbmcgdG8gc29sdmUgdHdvIA0KZGlmZmVyZW50IHByb2JsZW1zIGhlcmU/DQoNCj4gICAg
LSBzaG91bGQgd2UgaGF2ZSBhIHJldmVyc2UgaGVscGVyIGZvciBzZXR0aW5nIHJlZ2lzdGVy
cw0KPiANCj4gSWYgdGhpcyBzZWVtcyBsaWtlIHRoZSByaWdodCBhcHByb2FjaCBJIGNhbiBo
YXZlIGEgZ28gYXQgbW9yZSBvZiB0aGUNCj4gZnJvbnRlbmRzIGxhdGVyLg0KPiANCj4gVGhl
cmUgYXJlIGEgZmV3IG90aGVyIG1pc2MgY2xlYW4tdXBzIEkgZGlkIG9uIHRoZSB3YXkgd2hp
Y2ggbWlnaHQgYmUNCj4gd29ydGggY2hlcnJ5IHBpY2tpbmcgZm9yIDEwLjAgYnV0IEknbGwg
bGVhdmUgdGhhdCB1cCB0byBtYWludGFpbmVycy4NCj4gDQo+IEFsZXguDQo+IA0KPiBBbGV4
IEJlbm7DqWUgKDEwKToNCj4gICAgaW5jbHVkZS9nZGJzdHViOiBmaXggaW5jbHVkZSBndWFy
ZCBpbiBjb21tYW5kcy5oDQo+ICAgIGdkYnN0dWI6IGludHJvZHVjZSB0YXJnZXQgaW5kZXBl
bmRlbnQgZ2RiIHJlZ2lzdGVyIGhlbHBlcg0KPiAgICB0YXJnZXQvYXJtOiBjb252ZXJ0IDMy
IGJpdCBnZGJzdHViIHRvIG5ldyBoZWxwZXINCj4gICAgdGFyZ2V0L2FybTogY29udmVydCA2
NCBiaXQgZ2Ric3R1YiB0byBuZXcgaGVscGVyDQo+ICAgIHRhcmdldC9wcGM6IGV4cGFuZCBj
b21tZW50IG9uIEZQL1ZNWC9WU1ggYWNjZXNzIGZ1bmN0aW9ucw0KPiAgICB0YXJnZXQvcHBj
OiBtYWtlIHBwY19tYXliZV9ic3dhcF9yZWdpc3RlciBzdGF0aWMNCj4gICAgdGFyZ2V0L3Bw
YzogY29udmVydCBnZGJzdHViIHRvIG5ldyBoZWxwZXIgKCFoYWNreSkNCj4gICAgZ2Ric3R1
YjogYXNzZXJ0IGVhcmxpZXIgaW4gaGFuZGxlX3JlYWRfYWxsX3JlZ3MNCj4gICAgaW5jbHVk
ZS9leGVjOiBmaXggYXNzZXJ0IGluIHNpemVfbWVtb3ANCj4gICAgdGFyZ2V0L21pY3JvYmxh
emU6IGNvbnZlcnQgZ2Ric3R1YiB0byBuZXcgaGVscGVyDQo+IA0KPiAgIGluY2x1ZGUvZXhl
Yy9tZW1vcC5oICAgICAgICB8ICAgNCArLQ0KPiAgIGluY2x1ZGUvZ2Ric3R1Yi9jb21tYW5k
cy5oICB8ICAgMiArLQ0KPiAgIGluY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaCB8ICAzMCAr
KysrKysNCj4gICB0YXJnZXQvcHBjL2NwdS5oICAgICAgICAgICAgfCAgIDggKy0NCj4gICBn
ZGJzdHViL2dkYnN0dWIuYyAgICAgICAgICAgfCAgMjQgKysrKy0NCj4gICB0YXJnZXQvYXJt
L2dkYnN0dWIuYyAgICAgICAgfCAgNTcgKysrKysrKy0tLS0NCj4gICB0YXJnZXQvYXJtL2dk
YnN0dWI2NC5jICAgICAgfCAgNTMgKysrKysrLS0tLQ0KPiAgIHRhcmdldC9taWNyb2JsYXpl
L2dkYnN0dWIuYyB8ICA0NCArKysrLS0tLQ0KPiAgIHRhcmdldC9wcGMvZ2Ric3R1Yi5jICAg
ICAgICB8IDE5NCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gICA5
IGZpbGVzIGNoYW5nZWQsIDI1NyBpbnNlcnRpb25zKCspLCAxNTkgZGVsZXRpb25zKC0pDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaA0KPiAN
Cg0K

