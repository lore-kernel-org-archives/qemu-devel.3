Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEBAC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLmv-0002xo-Hk; Thu, 20 Mar 2025 15:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLmt-0002xH-T3
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:42:43 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLmr-0008Es-DN
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:42:42 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301918a4e1bso1702956a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742499760; x=1743104560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A1A2OLohCw6tV7LJ1/cg/Afzs5REC66QQgYuFKn7Obs=;
 b=FT3+dGjlIedfuUj6CuxoTYTrR/X+z6lyFEnUKaJOX21H1GMw/fhrd9FumtbOXu93H0
 lBTPEf9EEIiR7pblLCNUz+PcnndyF2ot/59Hts5bI+bEf476lN8ffyOLXTLo1IJllhOa
 1qaJpdVtUKYDyxKuQWZO593O6Q7cUhvzz/n1t9VX1T+z8airG75g5f+LBeUbi38m6G/q
 W/1u1cxHvs8Y2RPBJKfAvDVkxitJUvl8l8U9DwfIBOh6W93YlRJRJtj6CoM0wDKrBtQE
 ZVECr7bIkW8miy4VxSC5rEyTvZ8u7ezlCFWP+G9W6NUjbMpsaE+7Xlrtb1jZNag7KHEX
 y+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742499760; x=1743104560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A1A2OLohCw6tV7LJ1/cg/Afzs5REC66QQgYuFKn7Obs=;
 b=SPmFTJYvPGGk54Kc/ZKKs79moT2L/q/EQxk91P5qkgojOSHHz8EL9ctUZV0gtxfCfS
 1pgiI2AhNFAj5o7jPRr7wzjmfQvgzi/tBVJ7WG2WCboKa6+TZwK3Hynbsvc7rUnABdcO
 lcp5DOX9L4nN6rFCykl5RT3xiU1KUtvpLmoiu1h/riWikUIsCkgPM8XwVIT+wB1ooilS
 aPZZZdg4Mtb93hGzc6JW0+HboFV62tHt3jcZFfIwpd56vAl5LeCD5piNJbju2VMoZQx0
 5kWWUmeARFs9+lFijMhGuHU5JV7cwFram1J/0qL5NbFqVB0xCZQVGp9CmhkT9ACXD8bv
 Vorg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhucpUGKe6v+eX4kiHgIZFc/QchSIGgm0MezbxJgXa25eO2062UCkX7/MU3T4krphP/4dWlJXkrU+u@nongnu.org
X-Gm-Message-State: AOJu0Ywwq71s5g31nwSf7XdtINmlv0RuLMCUG2zmgeumE1jlcIYf+tTT
 6nci8zWB0KMZ9+v8P4bCvBtzJr3vHfEo12Zin8isMdMjkqjfRhJxwEfQW2fwo/IdlDkLdjP1Ekh
 Y
X-Gm-Gg: ASbGnct9wPbRV0cvwVGbRa0LKS5VdnWS2aoiod8qx9mNY3ApN0BckvO6X8mIwczWatI
 ppHcNhmakrVxtNXZcFSiTh3cXMRO/p+FRaujwkQoBuTZLrISYqrxXrjSzCutn36vX/cImYOeWoW
 NcgJzUTPuAwwUYK+X+TmoxBSdnR23j+0eBxlf2p9ylfnx7uqQFZ+rQBeicumhWUmO1CBITIO0y1
 k385lEEGiRaDfUk/l4J0OWC7lDI8QjR1wYn9Ut8quOP/fKBeargX8z0WzKcwKmVTz9cuiw5p9y3
 LcmlLIJ1qp0/LH+Ivyr2egIW2oi2/d7TX0AHnFbHZVzfaP+Ih25g1pBHVA==
X-Google-Smtp-Source: AGHT+IGSb0jdF+GUsIEj620+4ctbFJYRWhG5h/WsSgGVNNDvAUjGFuYKVQa/USlU1r5DVYl2ukVdQg==
X-Received: by 2002:a17:90b:1c0d:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-3030fb216b9mr921847a91.0.1742499759801; 
 Thu, 20 Mar 2025 12:42:39 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58c243sm4349169a91.16.2025.03.20.12.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:42:39 -0700 (PDT)
Message-ID: <798bcb21-a627-4578-a335-59920916e473@linaro.org>
Date: Thu, 20 Mar 2025 12:42:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] target/ppc: expand comment on FP/VMX/VSX access
 functions
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
 <20250319182255.3096731-6-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250319182255.3096731-6-alex.bennee@linaro.org>
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

T24gMy8xOS8yNSAxMToyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBNYWlubHkgYXMgYW4g
YWlkIHRvIG15c2VsZiBnZXR0aW5nIGNvbmZ1c2VkIHRvbyBtYW55IGJzd2FwcyBkZWVwIGlu
dG8NCj4gdGhlIGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFs
ZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIHRhcmdldC9wcGMvY3B1LmggfCA3
ICsrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3BwYy9jcHUuaCBiL3RhcmdldC9w
cGMvY3B1LmgNCj4gaW5kZXggZWZhYjU0YTA2OC4uMWU4MzNhZGUwNCAxMDA2NDQNCj4gLS0t
IGEvdGFyZ2V0L3BwYy9jcHUuaA0KPiArKysgYi90YXJnZXQvcHBjL2NwdS5oDQo+IEBAIC0y
OTA2LDcgKzI5MDYsMTIgQEAgc3RhdGljIGlubGluZSBib29sIGxzd19yZWdfaW5fcmFuZ2Uo
aW50IHN0YXJ0LCBpbnQgbnJlZ3MsIGludCByeCkNCj4gICAgICAgICAgICAgIChzdGFydCAr
IG5yZWdzID4gMzIgJiYgKHJ4ID49IHN0YXJ0IHx8IHJ4IDwgc3RhcnQgKyBucmVncyAtIDMy
KSk7DQo+ICAgfQ0KPiAgIA0KPiAtLyogQWNjZXNzb3JzIGZvciBGUCwgVk1YIGFuZCBWU1gg
cmVnaXN0ZXJzICovDQo+ICsvKg0KPiArICogQWNjZXNzIGZ1bmN0aW9ucyBmb3IgRlAsIFZN
WCBhbmQgVlNYIHJlZ2lzdGVycw0KPiArICoNCj4gKyAqIFRoZSByZWdpc3RlciBpcyBzdG9y
ZWQgYXMgYSAxMjggYml0IGhvc3QgZW5kaWFuIHZhbHVlIHNvIHdlIG5lZWQgdG8NCj4gKyAq
IHRha2UgdGhhdCBpbnRvIGFjY291bnQgd2hlbiBhY2Nlc3Npbmcgc21hbGxlciBwYXJ0cyBv
ZiBpdC4NCj4gKyAqLw0KPiAgICNpZiBIT1NUX0JJR19FTkRJQU4NCj4gICAjZGVmaW5lIFZz
ckIoaSkgdThbaV0NCj4gICAjZGVmaW5lIFZzclNCKGkpIHM4W2ldDQoNClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==


