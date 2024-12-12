Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3406FE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLopv-0003Ki-3d; Thu, 12 Dec 2024 14:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLopQ-0002zT-3r
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:26:30 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLopJ-0005Ge-OQ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:26:27 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-725ef0397aeso879660b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031579; x=1734636379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q3251UF/7f/rbeIm1TZ/1eiUREkgysyv5C6D6giZ7BY=;
 b=Z5Rc3lCiid8a5RKAoeUUUtZbFJ7EP0NRomsj7GjajmCFF+v4iFjABhbVLJmsimwWHa
 Gj37+gy1VBlRvc9E7swZ5VNURcx1+d3KKiaexcE/Ryas9zJ6CKpfyrmaqOZ7KJr1EuuU
 ncG5ajiFmLxMWlVkLqXzG1jsSGgaLqSgk4fLO9VrRayxaCY8ZE3VzmUThHwEyxAroYr2
 j0/3PBA9Iw6UWxN9ojL0MBH93fReX2a/wg5zj1t4OU3agGu+/r+4ZrD4cKRSiw7kRy6h
 9FY8UC/VDdDQLX7bRZg0cM38GFczNgQj6SClsifsEivJKD7aXcsKep6IL993DJsRTCG+
 qvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031579; x=1734636379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3251UF/7f/rbeIm1TZ/1eiUREkgysyv5C6D6giZ7BY=;
 b=kNyBUsJ/hsVGttjU5Z9VWH3W45mPaUIuJKmF6eh6Qh3lc3iyVXNplLVCzW+Zosb3+V
 T313xAgHxQxUjeIpEteOKaUjP0l+quLsEgKC0lf54GUmyRC88DGw/w+5a7oM8FZIO4o7
 JJt1BqD1Fjfm9fyVDPmvZABrna+0dmPHrzhEPJ/cLTcqymqvzbi3eJgnm/e8lTEFWCED
 1vAHHFFsMvdOQSbxhSL6jg0EoJwXxcfjZ90wLUhLBLCt0mm++6YoKbVeW1egF4/SBdsc
 nBt7LWPgWTCRPZNSn7plCNv0vUla2SMpE2MPJLfoHLX6jAhCGBpM8SCKat5jEtFtc4cg
 YXKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU25jwpv1+rLEUm+k71M+R+3bkgk4lyeiDsogLX+vaDUlHOnOJvRgVcBYsif42SRKj/AIr7Gqv8bBWd@nongnu.org
X-Gm-Message-State: AOJu0YyM8sQab1LynCTDbr+vgMaOXaetuLrc/WM3rLEB7tEV4tgHDToL
 D3AlvwOavx1N50TBtj+G3PVnS5SRlscRVm/FAok/+5L+q4qjUNeGEB6LhYYFQko=
X-Gm-Gg: ASbGncsWE6Pzm/iU7S0hiH5FxqAieQv1HvN76hq22ueJ2a5pod7cI0iR0johcHDY4OB
 yHpoUmAdlDAcxo2sFuDCp7k67o5ddn+sdyl1/rJQyR3p8raw8xLI/QPuag34p2UP/2oZEkEKjEN
 6b1l0JK5v4N+tRsbwmWbM49MQZBN1bJOano5pWBw8KrPNJLw6vwiL7Ef7W2BfFzHp7qNmmuB5VK
 +tMhRs3Jx9FBJVo68kAgb0qBvtUllyot6Q3Z3Fkb8wJXG4oHWPaTlWX5Hn+8vkA1Ebz0cSziJkx
 xv231rOkklCI36EfTmqmBvMNApJJ
X-Google-Smtp-Source: AGHT+IFl1NyJtsy0otS9Iu1d3d/zR2l20YWkp+U2lOb4jB4O4AuXploQL0KMgv2RjE09mvXOloT1Xg==
X-Received: by 2002:a05:6a00:2ea7:b0:728:e9d1:218a with SMTP id
 d2e1a72fcca58-72906a68c11mr1768708b3a.17.1734031578751; 
 Thu, 12 Dec 2024 11:26:18 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725ce382204sm9921920b3a.18.2024.12.12.11.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:26:18 -0800 (PST)
Message-ID: <315cd8d3-1b6d-49a6-befe-05fd6fd57007@linaro.org>
Date: Thu, 12 Dec 2024 11:26:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (3/4)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBic2QtdXNlci9xZW11LmggICAg
ICAgICAgICAgICAgfCAgMSArDQo+ICAgaW5jbHVkZS9leGVjL2NwdS1hbGwuaCAgICAgICAg
IHwgMTIgLS0tLS0tLS0tLS0tDQo+ICAgaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlvbi5o
IHwgMTIgKysrKysrKysrKysrDQo+ICAgbGludXgtdXNlci9xZW11LmggICAgICAgICAgICAg
IHwgIDEgKw0KPiAgIHRhcmdldC9hcm0vdGNnL3N2ZV9oZWxwZXIuYyAgICB8ICAzICsrKw0K
PiAgIHRhcmdldC9ocHBhL29wX2hlbHBlci5jICAgICAgICB8ICAzICsrKw0KPiAgIHRhcmdl
dC9zcGFyYy9sZHN0X2hlbHBlci5jICAgICB8ICAzICsrKw0KPiAgIDcgZmlsZXMgY2hhbmdl
ZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYnNkLXVzZXIvcWVtdS5oIGIvYnNkLXVzZXIvcWVtdS5oDQo+IGluZGV4IDM3MzZjNDE3
ODYwLi4wNGZhZWU0NTlkZiAxMDA2NDQNCj4gLS0tIGEvYnNkLXVzZXIvcWVtdS5oDQo+ICsr
KyBiL2JzZC11c2VyL3FlbXUuaA0KPiBAQCAtMjYsNiArMjYsNyBAQA0KPiAgICNpbmNsdWRl
ICJleGVjL2V4ZWMtYWxsLmgiDQo+ICAgDQo+ICAgI2luY2x1ZGUgInVzZXIvYWJpdHlwZXMu
aCINCj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgIA0KPiAgIGV4
dGVybiBjaGFyICoqZW52aXJvbjsNCj4gICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhl
Yy9jcHUtYWxsLmggYi9pbmNsdWRlL2V4ZWMvY3B1LWFsbC5oDQo+IGluZGV4IDg2Y2Q0MDAy
MGM5Li43M2IxMWY1OGFiYiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9leGVjL2NwdS1hbGwu
aA0KPiArKysgYi9pbmNsdWRlL2V4ZWMvY3B1LWFsbC5oDQo+IEBAIC0xMzAsMTggKzEzMCw2
IEBAIGV4dGVybiBjb25zdCBUYXJnZXRQYWdlQml0cyB0YXJnZXRfcGFnZTsNCj4gICANCj4g
ICBpbnQgcGFnZV9nZXRfZmxhZ3ModGFyZ2V0X3Vsb25nIGFkZHJlc3MpOw0KPiAgIA0KPiAt
LyoqDQo+IC0gKiBwYWdlX2NoZWNrX3JhbmdlDQo+IC0gKiBAc3RhcnQ6IGZpcnN0IGJ5dGUg
b2YgcmFuZ2UNCj4gLSAqIEBsZW46IGxlbmd0aCBvZiByYW5nZQ0KPiAtICogQGZsYWdzOiBm
bGFncyByZXF1aXJlZCBmb3IgZWFjaCBwYWdlDQo+IC0gKg0KPiAtICogUmV0dXJuIHRydWUg
aWYgZXZlcnkgcGFnZSBpbiBbQHN0YXJ0LCBAc3RhcnQrQGxlbikgaGFzIEBmbGFncyBzZXQu
DQo+IC0gKiBSZXR1cm4gZmFsc2UgaWYgYW55IHBhZ2UgaXMgdW5tYXBwZWQuICBUaHVzIHRl
c3RpbmcgZmxhZ3MgPT0gMCBpcw0KPiAtICogZXF1aXZhbGVudCB0byB0ZXN0aW5nIGZvciBm
bGFncyA9PSBQQUdFX1ZBTElELg0KPiAtICovDQo+IC1ib29sIHBhZ2VfY2hlY2tfcmFuZ2Uo
dGFyZ2V0X3Vsb25nIHN0YXJ0LCB0YXJnZXRfdWxvbmcgbGFzdCwgaW50IGZsYWdzKTsNCj4g
LQ0KPiAgICNlbmRpZg0KPiAgIA0KPiAgIENQVUFyY2hTdGF0ZSAqY3B1X2NvcHkoQ1BVQXJj
aFN0YXRlICplbnYpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVj
dGlvbi5oIGIvaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlvbi5oDQo+IGluZGV4IGQyMWZh
YjFhYWY5Li5iZGQ5OGEzN2RlMSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91c2VyL3BhZ2Ut
cHJvdGVjdGlvbi5oDQo+ICsrKyBiL2luY2x1ZGUvdXNlci9wYWdlLXByb3RlY3Rpb24uaA0K
PiBAQCAtMzQsNiArMzQsMTggQEAgdm9pZCBwYWdlX3NldF9mbGFncyh0YXJnZXRfdWxvbmcg
c3RhcnQsIHRhcmdldF91bG9uZyBsYXN0LCBpbnQgZmxhZ3MpOw0KPiAgIA0KPiAgIHZvaWQg
cGFnZV9yZXNldF90YXJnZXRfZGF0YSh0YXJnZXRfdWxvbmcgc3RhcnQsIHRhcmdldF91bG9u
ZyBsYXN0KTsNCj4gICANCj4gKy8qKg0KPiArICogcGFnZV9jaGVja19yYW5nZQ0KPiArICog
QHN0YXJ0OiBmaXJzdCBieXRlIG9mIHJhbmdlDQo+ICsgKiBAbGVuOiBsZW5ndGggb2YgcmFu
Z2UNCj4gKyAqIEBmbGFnczogZmxhZ3MgcmVxdWlyZWQgZm9yIGVhY2ggcGFnZQ0KPiArICoN
Cj4gKyAqIFJldHVybiB0cnVlIGlmIGV2ZXJ5IHBhZ2UgaW4gW0BzdGFydCwgQHN0YXJ0K0Bs
ZW4pIGhhcyBAZmxhZ3Mgc2V0Lg0KPiArICogUmV0dXJuIGZhbHNlIGlmIGFueSBwYWdlIGlz
IHVubWFwcGVkLiAgVGh1cyB0ZXN0aW5nIGZsYWdzID09IDAgaXMNCj4gKyAqIGVxdWl2YWxl
bnQgdG8gdGVzdGluZyBmb3IgZmxhZ3MgPT0gUEFHRV9WQUxJRC4NCj4gKyAqLw0KPiArYm9v
bCBwYWdlX2NoZWNrX3JhbmdlKHRhcmdldF91bG9uZyBzdGFydCwgdGFyZ2V0X3Vsb25nIGxh
c3QsIGludCBmbGFncyk7DQo+ICsNCj4gICAvKioNCj4gICAgKiBwYWdlX2NoZWNrX3Jhbmdl
X2VtcHR5Og0KPiAgICAqIEBzdGFydDogZmlyc3QgYnl0ZSBvZiByYW5nZQ0KPiBkaWZmIC0t
Z2l0IGEvbGludXgtdXNlci9xZW11LmggYi9saW51eC11c2VyL3FlbXUuaA0KPiBpbmRleCA2
N2JjODFiMTQ5OS4uNWYwMDc1MDE1MTggMTAwNjQ0DQo+IC0tLSBhL2xpbnV4LXVzZXIvcWVt
dS5oDQo+ICsrKyBiL2xpbnV4LXVzZXIvcWVtdS5oDQo+IEBAIC01LDYgKzUsNyBAQA0KPiAg
ICNpbmNsdWRlICJleGVjL2NwdV9sZHN0LmgiDQo+ICAgDQo+ICAgI2luY2x1ZGUgInVzZXIv
YWJpdHlwZXMuaCINCj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAg
IA0KPiAgICNpbmNsdWRlICJzeXNjYWxsX2RlZnMuaCINCj4gICAjaW5jbHVkZSAidGFyZ2V0
X3N5c2NhbGwuaCINCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vdGNnL3N2ZV9oZWxwZXIu
YyBiL3RhcmdldC9hcm0vdGNnL3N2ZV9oZWxwZXIuYw0KPiBpbmRleCA5MDQyOTY3MDVjNi4u
NWE1NDNiOGRiYzAgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9hcm0vdGNnL3N2ZV9oZWxwZXIu
Yw0KPiArKysgYi90YXJnZXQvYXJtL3RjZy9zdmVfaGVscGVyLmMNCj4gQEAgLTI5LDYgKzI5
LDkgQEANCj4gICAjaW5jbHVkZSAidmVjX2ludGVybmFsLmgiDQo+ICAgI2luY2x1ZGUgInN2
ZV9sZHN0X2ludGVybmFsLmgiDQo+ICAgI2luY2x1ZGUgImh3L2NvcmUvdGNnLWNwdS1vcHMu
aCINCj4gKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+ICsjaW5jbHVkZSAidXNlci9wYWdl
LXByb3RlY3Rpb24uaCINCj4gKyNlbmRpZg0KPiAgIA0KPiAgIA0KPiAgIC8qIFJldHVybiBh
IHZhbHVlIGZvciBOWkNWIGFzIHBlciB0aGUgQVJNIFByZWRUZXN0IHBzZXVkb2Z1bmN0aW9u
Lg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hwcGEvb3BfaGVscGVyLmMgYi90YXJnZXQvaHBw
YS9vcF9oZWxwZXIuYw0KPiBpbmRleCA3NDQzMjU5NjlmNS4uYmViOGY4ODc5OWUgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9ocHBhL29wX2hlbHBlci5jDQo+ICsrKyBiL3RhcmdldC9ocHBh
L29wX2hlbHBlci5jDQo+IEBAIC0yNSw2ICsyNSw5IEBADQo+ICAgI2luY2x1ZGUgImV4ZWMv
Y3B1X2xkc3QuaCINCj4gICAjaW5jbHVkZSAicWVtdS90aW1lci5oIg0KPiAgICNpbmNsdWRl
ICJ0cmFjZS5oIg0KPiArI2lmZGVmIENPTkZJR19VU0VSX09OTFkNCj4gKyNpbmNsdWRlICJ1
c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiArI2VuZGlmDQo+ICAgDQo+ICAgR19OT1JFVFVS
TiB2b2lkIEhFTFBFUihleGNwKShDUFVIUFBBU3RhdGUgKmVudiwgaW50IGV4Y3ApDQo+ICAg
ew0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3NwYXJjL2xkc3RfaGVscGVyLmMgYi90YXJnZXQv
c3BhcmMvbGRzdF9oZWxwZXIuYw0KPiBpbmRleCBkOTJjOWYxNTkzNC4uNGM1NGU0NTY1NTMg
MTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9zcGFyYy9sZHN0X2hlbHBlci5jDQo+ICsrKyBiL3Rh
cmdldC9zcGFyYy9sZHN0X2hlbHBlci5jDQo+IEBAIC0yNiw2ICsyNiw5IEBADQo+ICAgI2lu
Y2x1ZGUgImV4ZWMvZXhlYy1hbGwuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9wYWdlLXByb3Rl
Y3Rpb24uaCINCj4gICAjaW5jbHVkZSAiZXhlYy9jcHVfbGRzdC5oIg0KPiArI2lmZGVmIENP
TkZJR19VU0VSX09OTFkNCj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0K
PiArI2VuZGlmDQo+ICAgI2luY2x1ZGUgImFzaS5oIg0KPiAgIA0KPiAgIC8vI2RlZmluZSBE
RUJVR19NTVUNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJv
dXZpZXJAbGluYXJvLm9yZz4NCg0K

