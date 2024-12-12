Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7683EE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLopH-0002Yx-ST; Thu, 12 Dec 2024 14:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLooq-0002J2-1e
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:25:54 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLool-0005C9-JV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:25:49 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-72909c459c4so114324b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031546; x=1734636346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JoPku5GNuqFGgZmnnfGpD3YYnlT5QqB82Ub1937qmvA=;
 b=p+gVxoebBcIH9wDUmSzFz5+NjHcldQjnJhNw7ZQhDIGCTmUJ60+JcCzmi/x/ibvkUL
 ZWdBDEeUzWdbOw2ZZ5MqfLG+HovEx5qIknFwJ1fKDArIyaL3dPwPvH2eQgG5SEv/eNfJ
 D89J3LlZD+mKq5j4oujoPeHsxUOGvB9zvUlptjmREIUqg5zKFYERHsjUuGE/Gfis8twp
 kax+2f4enZO4BOZr8a38lCI6Diyj21D/c7z/yfoah31EvS48/UAbSNSd7AwSFlnnUmd/
 nahfJQJWwLqUd1vaxGnJ7LBPDG+rzq0PZXRf70uqryGJIYzKQVEYjvJ39YeSQFHOQoiL
 pV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031546; x=1734636346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JoPku5GNuqFGgZmnnfGpD3YYnlT5QqB82Ub1937qmvA=;
 b=f6Pl90C/7REqk5KWTV8waheyb2sQpB6TscCqTPubO57M1JVZpNENIgvs68DATHDcDP
 MVJIAGmVhwFiFVoEWexCmTWUssiPlee+lsZtD3ZX8JRedxRZKNjOwFymxwD+mf3rkvIs
 UrYIu0Olwak3Yn3HZw1ApwCN9qC5M9129O0+/ZVy1iL12Oeabs/RE9YkuarZD0FkHIax
 kXFdHXCfJbc5y01X5Pgtu8f9rJw9T5YzJgD4Ug8mHjRGu893Ng3PHONTAoIG9M5wdLHr
 N2m3BFZ3A1EbuS+5Jv5CO+aotbW52AfPZndcW/E7pagR0qjsOgcjs/j0UzehtXdab2mH
 YOYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3dAD6xa5WBU2+PcrooYoC35PmIQ8AegqkJVS2w71+1rCIzyRa9ypCeHLhicKmlypngHClju+e4kSL@nongnu.org
X-Gm-Message-State: AOJu0YxGySPfpEPI/W4xkzQS4w1hFnrJMB20rth+WhWQJ6h9mdjbp1Ar
 7ptjqgsFd/QvuAb/CeAeH9fq5CsSd2sf9go//JdDzm3XPKn/dLRaj6jR4Em8n948roxDk2wwVW+
 VRWw=
X-Gm-Gg: ASbGncvisyCrKk8NYaZr67EVtMuVfOD36f4+E6wH/kNZRSpBx6Cn64O3xYYiqVgxIo/
 L9Gh1kqbFU27spvUIhTymXvbs6bnaWbdvy78nLu78wQjp72Hw8Qr/dVIekeegglrLtVF2tfDaW9
 7YCaiYAFXlGzHBjU9Qn798gYuNibdc8I3/6H2o6Hr2BrNuJ3DzYqpnGUYveFWByYmXdrRb5VqYB
 RDbVN5qgvKnc5DAQySbbb5E/4vt55ZWliUwdOjU2H1iV3y4fRBG7Hkb2UTlSUabisil7RvDlNJR
 swbRrJ8R72CGKXewQw23+ZDscnhJ
X-Google-Smtp-Source: AGHT+IHQ59S6WEDP5YuUMznm33Cf5wd41PfYD9eknl/Km7fU5BdZLVogWQBN/lPS+J3hJ259ga0NhQ==
X-Received: by 2002:a05:6a20:7347:b0:1e1:a9c1:b343 with SMTP id
 adf61e73a8af0-1e1dabfa465mr2195219637.43.1734031546027; 
 Thu, 12 Dec 2024 11:25:46 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd3a637c41sm9274263a12.78.2024.12.12.11.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:25:45 -0800 (PST)
Message-ID: <00df4f06-73db-409a-b5c6-977d5f8de831@linaro.org>
Date: Thu, 12 Dec 2024 11:25:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (1/4)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBN
b3ZlIGRlY2xhcmF0aW9ucyByZWxhdGVkIHRvIHBhZ2UgcHJvdGVjdGlvbiB1bmRlciB1c2Vy
DQo+IGVtdWxhdGlvbiBmcm9tICJleGVjL2NwdS1hbGwuaCIgdG8gInVzZXIvcGFnZS1wcm90
ZWN0aW9uLmgiLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBpbmNsdWRlL2V4ZWMvY3B1LWFs
bC5oICAgICAgICAgfCA1IC0tLS0tDQo+ICAgaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlv
bi5oIHwgOCArKysrKysrKw0KPiAgIGJzZC11c2VyL21haW4uYyAgICAgICAgICAgICAgICB8
IDEgKw0KPiAgIGJzZC11c2VyL21tYXAuYyAgICAgICAgICAgICAgICB8IDEgKw0KPiAgIGxp
bnV4LXVzZXIvbWFpbi5jICAgICAgICAgICAgICB8IDEgKw0KPiAgIGxpbnV4LXVzZXIvbW1h
cC5jICAgICAgICAgICAgICB8IDEgKw0KPiAgIGxpbnV4LXVzZXIvc3lzY2FsbC5jICAgICAg
ICAgICB8IDEgKw0KPiAgIDcgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvY3B1LWFsbC5o
IGIvaW5jbHVkZS9leGVjL2NwdS1hbGwuaA0KPiBpbmRleCAxYzhlMDQ0NmQwNi4uM2Q5NzMy
Mzg5M2IgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZXhlYy9jcHUtYWxsLmgNCj4gKysrIGIv
aW5jbHVkZS9leGVjL2NwdS1hbGwuaA0KPiBAQCAtMTI3LDExICsxMjcsNiBAQCBleHRlcm4g
Y29uc3QgVGFyZ2V0UGFnZUJpdHMgdGFyZ2V0X3BhZ2U7DQo+ICAgI2RlZmluZSBUQVJHRVRf
UEFHRV9BTElHTihhZGRyKSBST1VORF9VUCgoYWRkciksIFRBUkdFVF9QQUdFX1NJWkUpDQo+
ICAgDQo+ICAgI2lmIGRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkNCj4gLXZvaWQgcGFnZV9k
dW1wKEZJTEUgKmYpOw0KPiAtDQo+IC10eXBlZGVmIGludCAoKndhbGtfbWVtb3J5X3JlZ2lv
bnNfZm4pKHZvaWQgKiwgdGFyZ2V0X3Vsb25nLA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB0YXJnZXRfdWxvbmcsIHVuc2lnbmVkIGxvbmcpOw0KPiAtaW50
IHdhbGtfbWVtb3J5X3JlZ2lvbnModm9pZCAqLCB3YWxrX21lbW9yeV9yZWdpb25zX2ZuKTsN
Cj4gICANCj4gICBpbnQgcGFnZV9nZXRfZmxhZ3ModGFyZ2V0X3Vsb25nIGFkZHJlc3MpOw0K
PiAgIA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIGIv
aW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlvbi5oDQo+IGluZGV4IDQ0OGM3YTAzNDQ5Li5l
YTExY2Y5ZTMyOCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlv
bi5oDQo+ICsrKyBiL2luY2x1ZGUvdXNlci9wYWdlLXByb3RlY3Rpb24uaA0KPiBAQCAtMTIs
OSArMTIsMTcgQEANCj4gICAjZXJyb3IgQ2Fubm90IGluY2x1ZGUgdGhpcyBoZWFkZXIgZnJv
bSBzeXN0ZW0gZW11bGF0aW9uDQo+ICAgI2VuZGlmDQo+ICAgDQo+ICsjaW5jbHVkZSAiY3B1
LXBhcmFtLmgiDQo+ICsjaW5jbHVkZSAiZXhlYy90YXJnZXRfbG9uZy5oIg0KPiAgICNpbmNs
dWRlICJleGVjL3RyYW5zbGF0aW9uLWJsb2NrLmgiDQo+ICAgDQo+ICAgdm9pZCBwYWdlX3By
b3RlY3QodGJfcGFnZV9hZGRyX3QgcGFnZV9hZGRyKTsNCj4gICBpbnQgcGFnZV91bnByb3Rl
Y3QodGJfcGFnZV9hZGRyX3QgYWRkcmVzcywgdWludHB0cl90IHBjKTsNCj4gK3R5cGVkZWYg
aW50ICgqd2Fsa19tZW1vcnlfcmVnaW9uc19mbikodm9pZCAqLCB0YXJnZXRfdWxvbmcsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRhcmdldF91bG9uZywg
dW5zaWduZWQgbG9uZyk7DQo+ICsNCj4gK2ludCB3YWxrX21lbW9yeV9yZWdpb25zKHZvaWQg
Kiwgd2Fsa19tZW1vcnlfcmVnaW9uc19mbik7DQo+ICsNCj4gK3ZvaWQgcGFnZV9kdW1wKEZJ
TEUgKmYpOw0KPiAgIA0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvYnNkLXVzZXIvbWFp
bi5jIGIvYnNkLXVzZXIvbWFpbi5jDQo+IGluZGV4IDYxY2E3M2M0NzgxLi4wYTViYzU3ODM2
NSAxMDA2NDQNCj4gLS0tIGEvYnNkLXVzZXIvbWFpbi5jDQo+ICsrKyBiL2JzZC11c2VyL21h
aW4uYw0KPiBAQCAtMzgsNiArMzgsNyBAQA0KPiAgICNpbmNsdWRlICJxZW11L3BsdWdpbi5o
Ig0KPiAgICNpbmNsdWRlICJleGVjL2V4ZWMtYWxsLmgiDQo+ICAgI2luY2x1ZGUgInVzZXIv
Z3Vlc3QtYmFzZS5oIg0KPiArI2luY2x1ZGUgInVzZXIvcGFnZS1wcm90ZWN0aW9uLmgiDQo+
ICAgI2luY2x1ZGUgInRjZy9zdGFydHVwLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvdGltZXIu
aCINCj4gICAjaW5jbHVkZSAicWVtdS9lbnZsaXN0LmgiDQo+IGRpZmYgLS1naXQgYS9ic2Qt
dXNlci9tbWFwLmMgYi9ic2QtdXNlci9tbWFwLmMNCj4gaW5kZXggNzc1ZTkwNTk2MGIuLjM0
NmYyY2VmZDMyIDEwMDY0NA0KPiAtLS0gYS9ic2QtdXNlci9tbWFwLmMNCj4gKysrIGIvYnNk
LXVzZXIvbW1hcC5jDQo+IEBAIC0xOCw2ICsxOCw3IEBADQo+ICAgICovDQo+ICAgI2luY2x1
ZGUgInFlbXUvb3NkZXAuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9wYWdlLXByb3RlY3Rpb24u
aCINCj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgIA0KPiAgICNp
bmNsdWRlICJxZW11LmgiDQo+ICAgDQo+IGRpZmYgLS1naXQgYS9saW51eC11c2VyL21haW4u
YyBiL2xpbnV4LXVzZXIvbWFpbi5jDQo+IGluZGV4IGIwOWFmOGQ0MzY1Li4wNjAzNzMwNGNi
MSAxMDA2NDQNCj4gLS0tIGEvbGludXgtdXNlci9tYWluLmMNCj4gKysrIGIvbGludXgtdXNl
ci9tYWluLmMNCj4gQEAgLTM5LDYgKzM5LDcgQEANCj4gICAjaW5jbHVkZSAicWVtdS9tb2R1
bGUuaCINCj4gICAjaW5jbHVkZSAicWVtdS9wbHVnaW4uaCINCj4gICAjaW5jbHVkZSAidXNl
ci9ndWVzdC1iYXNlLmgiDQo+ICsjaW5jbHVkZSAidXNlci9wYWdlLXByb3RlY3Rpb24uaCIN
Cj4gICAjaW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiAgICNpbmNsdWRlICJleGVjL2dk
YnN0dWIuaCINCj4gICAjaW5jbHVkZSAiZ2Ric3R1Yi91c2VyLmgiDQo+IGRpZmYgLS1naXQg
YS9saW51eC11c2VyL21tYXAuYyBiL2xpbnV4LXVzZXIvbW1hcC5jDQo+IGluZGV4IGU0YmY1
ZDVmMzljLi40ZTA0NDRiNGNiYyAxMDA2NDQNCj4gLS0tIGEvbGludXgtdXNlci9tbWFwLmMN
Cj4gKysrIGIvbGludXgtdXNlci9tbWFwLmMNCj4gQEAgLTIyLDYgKzIyLDcgQEANCj4gICAj
aW5jbHVkZSAiZXhlYy9sb2cuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9wYWdlLXByb3RlY3Rp
b24uaCINCj4gICAjaW5jbHVkZSAicWVtdS5oIg0KPiArI2luY2x1ZGUgInVzZXIvcGFnZS1w
cm90ZWN0aW9uLmgiDQo+ICAgI2luY2x1ZGUgInVzZXItaW50ZXJuYWxzLmgiDQo+ICAgI2lu
Y2x1ZGUgInVzZXItbW1hcC5oIg0KPiAgICNpbmNsdWRlICJ0YXJnZXRfbW1hbi5oIg0KPiBk
aWZmIC0tZ2l0IGEvbGludXgtdXNlci9zeXNjYWxsLmMgYi9saW51eC11c2VyL3N5c2NhbGwu
Yw0KPiBpbmRleCAxY2U0Yzc5Nzg0Zi4uYzU0YjE5OWI2ZDMgMTAwNjQ0DQo+IC0tLSBhL2xp
bnV4LXVzZXIvc3lzY2FsbC5jDQo+ICsrKyBiL2xpbnV4LXVzZXIvc3lzY2FsbC5jDQo+IEBA
IC0xMzUsNiArMTM1LDcgQEANCj4gICAjaW5jbHVkZSAic2lnbmFsLWNvbW1vbi5oIg0KPiAg
ICNpbmNsdWRlICJsb2FkZXIuaCINCj4gICAjaW5jbHVkZSAidXNlci1tbWFwLmgiDQo+ICsj
aW5jbHVkZSAidXNlci9wYWdlLXByb3RlY3Rpb24uaCINCj4gICAjaW5jbHVkZSAidXNlci9z
YWZlLXN5c2NhbGwuaCINCj4gICAjaW5jbHVkZSAicWVtdS9ndWVzdC1yYW5kb20uaCINCj4g
ICAjaW5jbHVkZSAicWVtdS9zZWxmbWFwLmgiDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

