Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0C9C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 17:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1q2j-0008OS-D7; Mon, 07 Apr 2025 13:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u1q2d-0008NH-B0
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:13:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u1q2Z-0001WM-Jr
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:13:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so3672685b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744046020; x=1744650820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Revxnf5enjv1jshQgz7V0kk+t0ztzxtdu4weUv2PGvQ=;
 b=rmvTrzA7PDd2B9G+ShRk54kVjVYbXqmVq3MlsXAXwcgvHPOCNHkOFNllueaPHCyaRH
 7rxdRPKZv2dR/MsT0wMYcdns7bgrkBakLtm7vUAmEJAwViA1idj/OIdPIZhRXchmL7kY
 PVe6dYkqGkfq51dvV13WZeX74XPVnqOzOcGBa2KIiDNJ6gSxbeej5nZ59jO7IjxVD4QK
 g339ZOUUh62LLRixtjdGpKUDkhxAY51KXTJqqQ4EfjDVby/UomLBLh5/GM+Q05IaEGWf
 r/AV0c2oku3EUI7mFkOCZwHoGmvUr/Rhqi3zPUMabIoGvcDouXeHAN1mUyAHL4u7K2Rw
 Qu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744046020; x=1744650820;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Revxnf5enjv1jshQgz7V0kk+t0ztzxtdu4weUv2PGvQ=;
 b=OefFztf6A0ZoA1PFzPGUtcDIV8FVmsewWeM7GmNGEu2Y3syal7QzD0huhWKT2keGbG
 7ieBYPpETs1VezoDcKLsFsWawyT7dFQilzj/dQkFvPPbTmCaUcwAkxUG3puLtSEH70zj
 pngQVQjg5ZAVKXLiSKQAlF9aZAmaAlKjRn1C7+c7nTTH1HSIUlo0IJ9MVwntYeLJknkh
 RmbpeGHgsTs2DQhMr20W3yYGMEHDsWMSiRMOedJsD6Rdpm2kg7nEjr2IxNhhBhdh3Mba
 ZLuPoppyCnLwExzC4sxk0x+qAsUOQvGGtFtjiguKvlUFDC8uhUMTZ4RYbpWrN1ZyISi7
 6mSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoNsw7d6e5HdfsfIhG0nelnopsSMPVKJ8svpPbuHwRkpyWqJ670agOw5BrTNzE3ISaMC0tgChNasuX@nongnu.org
X-Gm-Message-State: AOJu0YxWgQ8afCV7hlArqnJxJiMH7zTelUk6sipU2rakaqT3/UsXd3dk
 D3MjgitzUYA/cbjUYfr1/NAyeonGxOuSzbYURf7nJV2Khqtt0Pz2DHpAGfmpUXI=
X-Gm-Gg: ASbGnct7hCcDwFOGPKA/0xKCu7nTRVR5rC4kSzn+gGJxavJI+PAk6x0hhY6iTbr9sQu
 +54iflptMXJ+lZcNSDHPJiREx1zfEEfo7oqWE43Iui2lLFPbVOgAqx5QWMmvvG5GCqmC499ogKV
 xNKv8feY/Rn02MpksVp9ic/V7UiPcYhnnWr5x3rYeYsZaR2zut9YAex1dm9aRVa5evzhNcp1FjU
 Z924R+P7cNRewmYkqGRnrT4gCBa4ikqAOFqn8FR8cZNT9ner5y9xPH3r6XNNgTDO+cdsi9j+AnU
 inFZZKcuBAnSMyshmPDSzBZGn+H1yuy1glpghJD+gK45ZpoSrw+07AhP7A==
X-Google-Smtp-Source: AGHT+IH0/q1XPImuWswWLPWRcSlN+DuZ8ATKeJSRrBlGujhvstLR1GXhSuwN3pY+cwOe4FOt1ZBa2g==
X-Received: by 2002:a05:6a00:1701:b0:736:ab1d:83c4 with SMTP id
 d2e1a72fcca58-739e46ba78cmr15334879b3a.0.1744046020517; 
 Mon, 07 Apr 2025 10:13:40 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc323839sm7598438a12.30.2025.04.07.10.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 10:13:40 -0700 (PDT)
Message-ID: <48fdbb0b-dd81-408f-80fe-77d75b6c2d77@linaro.org>
Date: Mon, 7 Apr 2025 10:13:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 11/39] hw/arm: Use full "target/arm/cpu.h"
 path to include target's "cpu.h"
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-12-philmd@linaro.org>
 <83a57c49-93fd-4463-81bf-fc0014ff5f3d@linaro.org>
 <a3d5cd32-4a1f-4753-8536-43180229721f@linaro.org>
 <a61d8331-27ef-489f-8cd3-0374da0b4b1b@linaro.org>
 <e34e8ce6-798e-4af5-9541-a2de2d4d314d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e34e8ce6-798e-4af5-9541-a2de2d4d314d@linaro.org>
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

T24gNC81LzI1IDA3OjI3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
NS80LzI1IDAzOjAzLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNC80LzI1IDE0
OjUzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiA0LzQvMjUgMjA6
MjAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+IE9uIDQvMy8yNSAxNjo1NywgUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4+PiBXZSB3b3VsZCBsaWtlIHRvIGdl
dCByaWQgb2YgJy1JIHRhcmdldC8kQVJDSC8nIGluIHRoZSBDUFBGTEFHUy4NCj4+Pj4NCj4+
Pj4gV2hpbGUgdGhpcyBjaGFuZ2UgaXMgY29ycmVjdCwgdGhpcyBpcyBub3Qgc3RyaWN0bHkg
bmVlZGVkLg0KPj4+PiBXaXRoIHRoZSBjdXJyZW50IGFwcHJvYWNoLCB1c2luZyBhIHNldCBv
ZiBjb21tb24gZmlsZXMgcGVyIGFyY2hpdGVjdHVyZSwNCj4+Pj4gd2UgY2FuIHJlbHkgb24g
dGhpcyBpbmNsdWRlIHRvIGJlIHByZXNlbnQsIGFuZCBpdCBkb2VzIG5vdCBibG9jayBmcm9t
DQo+Pj4+IGhhdmluZyBjb21tb24gZmlsZXMuDQo+Pj4NCj4+PiBJbmRlZWQsIEkgcmViYXNl
ZCB0aGlzIGNvbW1pdCBmcm9tIG15IGhldGVyb2dlbmVvdXMgYnJhbmNoLg0KPj4+DQo+Pj4g
SSdsbCBrZWVwaW5nIGNhcnJ5aW5nIC8gcmViYXNpbmcgaXQgZm9yIHZhcmlvdXMgbW9udGhz
LCB0cnlpbmcgdG8NCj4+PiByZW1lbWJlciB0byBub3Qga2VlcGluZyBwb3N0aW5nIGl0Lg0K
Pj4+DQo+Pj4gT3IgYWx0ZXJuYXRpdmVseSBJJ2xsIHBvc3QgaXQgaW4gYSBzZXBhcmF0ZSAi
Y2xlYW51cCBzZXJpZXMiLCBub3QNCj4+PiBtZW50aW9uaW5nIHNpbmdsZS1iaW5hcnkgb3Ig
aGV0ZXJvZ2VuZW91cyBlbXVsYXRpb24uDQo+Pj4NCj4+DQo+PiBNeSBwb2ludCB3YXMgbm90
ICJwbGVhc2UgcG9zdCB0aGF0IGxhdGVyIiwgYnV0IHNpbXBseSB0byBzYXkgdGhvc2UNCj4+
IGNoYW5nZXMgYXJlIG5vdCBuZWVkZWQsIG5vdyBvciBpbiB0aGUgZnV0dXJlLg0KPj4gV2Ug
Y2FuIGhhdmUgYSBzcGVjaWZpYyBpbmNsdWRlIHBhdGggZm9yIHZhcmlvdXMgZmlsZXMgd2l0
aG91dA0KPj4gY29tcHJvbWlzaW5nIHRoZSBzaW5nbGUgYmluYXJ5L2hldGVyb2dlbmVub3Vz
LCBhcyBsb25nIGFzIHdlIGNvbXBpbGUgaXQNCj4+IG9ubHkgb25jZS4NCj4gDQo+IEluY29y
cmVjdCwgdGhpcyBpcyByZXF1aXJlZCBmb3IgaGV0ZXJvZ2VuZW5vdXMgZW11bGF0aW9uLg0K
PiANCg0KVGhlcmUgYXJlIHByb2JhYmx5IHR3byBkaWZmZXJlbnQgdG9waWNzIGhlcmUuDQoN
CklmIGJ5ICJ0aGlzIiwgeW91IG1lYW4gdGhlIGN1cnJlbnQgY2hhbmdlIChpbmNsdWRlIGV4
cGxpY2l0IA0KdGFyZ2V0L1gvY3B1LmgpLCB0aGVuIG5vLCBpdCdzIG5vdCByZXF1aXJlZC4N
CkNoYW5naW5nIGluY2x1ZGUgImNwdS5oIiB0byBpbmNsdWRlICJ0YXJnZXQvYXJtL2NwdS5o
IiBoYXMgYWJzb2x1dGVseSBubyANCmVmZmVjdCBmb3IgdGhlIGNvbW1vbiBmaWxlcyBpbiBo
dy9hcm0sIGFzIHRoZXkgYXJlIGFscmVhZHkgY29tcGlsZWQgd2l0aCANCi1JIHRhcmdldC9h
cm0uIEl0IHByb2R1Y2VzIHRoZSBleGFjdCBzYW1lIGNvbXBpbGF0aW9uIHVuaXQuDQpJIGRp
ZCB0aGUgc2FtZSBjaGFuZ2UgYXMgeW91IGRvIGhlcmUgd2hlbiB3b3JraW5nIG9uIGh3L2Fy
bSwgYW5kIGZpbmFsbHkgDQp1bmRlcnN0b29kIGl0IGhhZCBubyBlZmZlY3QsIHNvIEkgcmV2
ZXJ0ZWQgaXQsIGFuZCBzaW1wbHkgbGV0IHRoZSANCm9yaWdpbmFsIGluY2x1ZGUgImNwdS5o
Ii4NCg0KSWYgeW91IHdlcmUgdGFsa2luZyBhYm91dCBhY2Nlc3NpbmcgYXJtL2NwdS5oIGZl
YXR1cmVzLCB0aGVuIEkgc3RpbGwgDQpkb24ndCBzZWUgd2h5IGl0J3MgbmVlZGVkLiBUaGVy
ZSBpcyBubyByZWFzb24gYW55IGNvZGUgb3V0IG9mIGh3L2FybSBvciANCnRhcmdldC9hcm0g
c2hvdWxkIGFjY2VzcyB0aGlzLiBJZiBJIG1pc3NlZCBzb21ldGhpbmcsIGZlZWwgZnJlZSB0
byBwb3N0IA0KYSBjb25jcmV0ZSBleGFtcGxlIG9mIHdoZXJlIGl0J3MgbmVlZGVkLg0KDQpJ
biBhbnkgY2FzZSwgaWYgYW55IGh3IGNvZGUgcmVsaWVzIG9uIGNwdS5oIGluY2x1c2lvbiwg
aXQgd2lsbCBub3QgDQpjb21waWxlIHdoZW4gd2UgbWFrZSBpdCBjb21tb24sIGJlY2F1c2Ug
Y3B1Lmggd29uJ3QgYmUgZm91bmQuDQpBdCB0aGlzIHRpbWUsIGFuZCBvbmx5IGF0IHRoaXMg
dGltZSwgdGhlbiB3ZSdsbCBleHRyYWN0IHRoZSBleHBlY3RlZCANCmludGVyZmFjZSwgYW5k
IGV4cG9zZSBpdCB0byBjb21tb24gY29kZS4gQnV0IGJlZm9yZSB3ZSBtZWV0IHRoZSANCnNp
dHVhdGlvbiwgSSBkb24ndCB0aGluayB3ZSBzaG91bGQgZG8gYW55IG9mIHRob3NlIGNoYW5n
ZXMuDQoNClBpZXJyaWNrDQo=

