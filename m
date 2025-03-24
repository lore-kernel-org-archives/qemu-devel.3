Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C324C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnZh-0003Qv-S7; Mon, 24 Mar 2025 15:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnZb-0003P1-Lx
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:35:00 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnZY-0006C9-AA
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:34:59 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223fd89d036so94616285ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742844895; x=1743449695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aeH9RQhBnFZWp0TPHaRdCYGX7cmOgtfwhX7OsjrUk0Q=;
 b=KKVOntMi0LrmZchHCgNb9VS29S35Xcm3W7n6Fpn+YrzHWXRIjdy3qO1TKtSb6YQWq2
 8xN6M+I/Hlh1fxQF4Bk0girZG6nxt37b50Ug4YXONi21Zb0aTd1GoIoKFyr4bDFdIliU
 mhf10B6P+NOH5nL+uunwW6FKgCnlu5WVnFwZzYEMU+FZSydjy1V9ii1Aw85wCnYarcvF
 BuMiGTPFRFoRhnyyrUkkz1OX1LGiKmnTVjGFzrlLOXTN5LYxV/whZ0uaGWtXrCimiDak
 nDbGJ+g72SiqTPlLxrmeKXpK2os4k+Cj1EXIeZaR2RX6HwenzaV0PA/ivUIo50iGAfT+
 5nYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844895; x=1743449695;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aeH9RQhBnFZWp0TPHaRdCYGX7cmOgtfwhX7OsjrUk0Q=;
 b=KqotDK/sFi1X0R4ROWKmBJDxmwXUG8AFU1JWXVD3smOMLifcJJeAQMldjhuxu6OqS8
 8va/nJ1+u5vWgm+GOxAo/76fsjM1HeIs7ZN2a5KmlIsZt6zvKaF1xh6lM55Sf/eQDpZ+
 BADt8vKPYuhD7HU/f/V3zT77p5yuZBtx/YeJzv0ZwTM03j1rgy3VAZNvjFrYRXcU89qB
 bVZVOlJdWtT991NerTHi5kCmWMVciqnP9vTPIY3LJScixG04aYl5mywzCbnk3gdDXGSb
 f75i0sNDxKj259Ma/b/UfDbKr6ab0G7s3rFi1+2fcrtPbWmbyAmwk7bCAuGmLgD+Ehvh
 W5Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHwCWHIB02SNXBlwn0ubnX0tm1bEgXN5udsCyRnL9LX4OCeaJmyoIoC74PQDDtUmO7DANWEn71BquR@nongnu.org
X-Gm-Message-State: AOJu0Yz2MSPgF6/bRAK/M1dNof5L3mG3BBTzPN9d3u5pJu3UluPt16jM
 a+tBCtGXWDjbq8CjRufhEcQ0FZgJRWY3JwUjpKT7BexPg9EzZFDcm/MAxemzmJt2/KiLUzYK0GA
 DGk4=
X-Gm-Gg: ASbGncuaN3RyB3LlGr6XKZj1yNC6u0kLbuuizqZ3TVq423rr8OdUHs+3t4JDzJ0iTCD
 hLxznIJNarUX7qLR6LHJS1DUSys4A7TAOSgPNfkc052uGkFs7V4N4Z2JSoOzXd4MHkiRneCh9P2
 UbUZnlCp2ueh3DVGN9PGUgcRVMeTOQ43VwXSm5oIuV1Auu9UfpKWZMttYkvkzdUxp9hViUkGFJl
 PoE+YD15QTwv2wtNAMLZTH7Nn7jJSaYs8MeTP3o43AnEVW81ckQJnA2HNu9PKYCFTGwfGK4pcza
 malVP7NMOWwlcTFE5Y37sRi5IdR3Av5RRXlZUeoTdXxMJnZ6Gs1+SHYD7QxYYRoLA0ub
X-Google-Smtp-Source: AGHT+IHooO5jL1ziRCiPCn/CL3jhY0Q1Avc/fRUahnKG9/h+A+OqC0J8SiM5HjBbmuZFp7eBPW/ieg==
X-Received: by 2002:a17:902:d4c5:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-22780e3fb8amr226951415ad.39.1742844894529; 
 Mon, 24 Mar 2025 12:34:54 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3b596sm75355245ad.16.2025.03.24.12.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:34:54 -0700 (PDT)
Message-ID: <3d79c73d-cfab-4995-8425-f7021b7c2dff@linaro.org>
Date: Mon, 24 Mar 2025 12:34:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] gdbstub: introduce target independent gdb
 register helper
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgY3VycmVudCBo
ZWxwZXIuaCBmdW5jdGlvbnMgcmVseSBvbiBoYXJkIGNvZGVkIGFzc3VtcHRpb25zIGFib3V0
DQo+IHRhcmdldCBlbmRpYW5lc3MgdG8gdXNlIHRoZSB0c3dhcCBtYWNyb3MuIFdlIGFsc28g
ZW5kIHVwIGRvdWJsZQ0KPiBzd2FwcGluZyBhIGJ1bmNoIG9mIHZhbHVlcyBpZiB0aGUgdGFy
Z2V0IGNhbiBydW4gaW4gbXVsdGlwbGUgZW5kaWFuZXNzDQo+IG1vZGVzLiBBdm9pZCB0aGlz
IGJ5IGdldHRpbmcgdGhlIHRhcmdldCB0byBwYXNzIHRoZSBlbmRpYW5lc3MgYW5kIHNpemUN
Cj4gdmlhIGEgTWVtT3AgYW5kIGZpeGluZyB1cCBhcHByb3ByaWF0ZWx5Lg0KPiANCj4gUmV2
aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8u
b3JnPg0KPiANCj4gLS0tDQo+IHYyDQo+ICAgIC0gdXNlIHVuc2lnbmVkIGNvbnNpc3RlbnRs
eQ0KPiAgICAtIGZpeCBzb21lIHJvdWdlIHdoaXRlc3BhY2UNCj4gICAgLSBhZGQgdHlwZWQg
cmVnMzIvNjQgd3JhcHBlcnMNCj4gICAgLSBwYXNzIHZvaWQgKiB0byB1bmRlcmx5aW5nIGhl
bHBlciB0byBhdm9pZCBjYXN0aW5nDQo+IC0tLQ0KPiAgIGluY2x1ZGUvZ2Ric3R1Yi9yZWdp
c3RlcnMuaCB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
ICBnZGJzdHViL2dkYnN0dWIuYyAgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaA0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaCBiL2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3Rl
cnMuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi4yMjIw
ZjU4ZWZlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9nZGJzdHViL3JlZ2lz
dGVycy5oDQo+IEBAIC0wLDAgKzEsNTUgQEANCj4gKy8qDQo+ICsgKiBHREIgQ29tbW9uIFJl
Z2lzdGVyIEhlbHBlcnMNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUgTGluYXJv
IEx0ZA0KPiArICoNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBHREJfUkVHSVNURVJTX0gNCj4gKyNk
ZWZpbmUgR0RCX1JFR0lTVEVSU19IDQo+ICsNCj4gKyNpbmNsdWRlICJleGVjL21lbW9wLmgi
DQo+ICsNCj4gKy8qKg0KPiArICogZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZSgpIC0gZ2V0IHJl
Z2lzdGVyIHZhbHVlIGZvciBnZGINCj4gKyAqIG1vOiBzaXplIGFuZCBlbmRpYW4gTWVtT3AN
Cj4gKyAqIGJ1ZjogR0J5dGVBcnJheSB0byBzdG9yZSBpbiB0YXJnZXQgb3JkZXINCj4gKyAq
IHZhbDogcG9pbnRlciB0byB2YWx1ZSBpbiBob3N0IG9yZGVyDQo+ICsgKg0KPiArICogVGhp
cyByZXBsYWNlcyB0aGUgcHJldmlvdXMgbGVnYWN5IHJlYWQgZnVuY3Rpb25zIHdpdGggYSBz
aW5nbGUNCj4gKyAqIGZ1bmN0aW9uIHRvIGhhbmRsZSBhbGwgc2l6ZXMuIFBhc3NpbmcgQG1v
IGFsbG93cyB0aGUgdGFyZ2V0IG1vZGUgdG8NCj4gKyAqIGJlIHRha2VuIGludG8gYWNjb3Vu
dCBhbmQgYXZvaWRzIHVzaW5nIGhhcmQgY29kZWQgdHN3YXAoKSBtYWNyb3MuDQo+ICsgKg0K
PiArICogVGhlcmUgYXJlIHdyYXBwZXIgZnVuY3Rpb25zIGZvciB0aGUgY29tbW9uIHNpemVz
IHlvdSBjYW4gdXNlIHRvDQo+ICsgKiBrZWVwIHR5cGUgY2hlY2tpbmcuDQo+ICsgKg0KPiAr
ICogUmV0dXJucyB0aGUgbnVtYmVyIG9mIGJ5dGVzIHdyaXR0ZW4gdG8gdGhlIGFycmF5Lg0K
PiArICovDQo+ICtpbnQgZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShNZW1PcCBvcCwgR0J5dGVB
cnJheSAqYnVmLCB2b2lkICp2YWwpOw0KPiArDQo+ICsvKioNCj4gKyAqIGdkYl9nZXRfcmVn
MzJfdmFsdWUoKSAtIHR5cGUgY2hlY2tlZCB3cmFwcGVyIGZvciBnZGJfZ2V0X3JlZ2lzdGVy
X3ZhbHVlKCkNCj4gKyAqIG1vOiBzaXplIGFuZCBlbmRpYW4gTWVtT3ANCj4gKyAqIGJ1Zjog
R0J5dGVBcnJheSB0byBzdG9yZSBpbiB0YXJnZXQgb3JkZXINCj4gKyAqIHZhbDogcG9pbnRl
ciB0byB1aW50MzJfdCB2YWx1ZSBpbiBob3N0IG9yZGVyDQo+ICsgKi8NCj4gK3N0YXRpYyBp
bmxpbmUgaW50IGdkYl9nZXRfcmVnMzJfdmFsdWUoTWVtT3Agb3AsIEdCeXRlQXJyYXkgKmJ1
ZiwgdWludDMyX3QgKnZhbCkgew0KPiArICAgIGdfYXNzZXJ0KChvcCAmIE1PX1NJWkUpID09
IE1PXzMyKTsNCj4gKyAgICByZXR1cm4gZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShvcCwgYnVm
LCB2YWwpOw0KPiArfQ0KPiArDQoNCkFmdGVyIHJlYWRpbmcgdGhlIHdob2xlIHNlcmllcywg
SSB0aGluayBJIGFtIG1pc3NpbmcgdGhlIHBvaW50IG9mIA0KaW50cm9kdWNlIG9wIGhlcmUu
DQpJZiB3aGF0IHdlIHJlYWxseSB3YW50IGlzIGp1c3QgdGhlIHRhcmdldCBlbmRpYW5uZXNz
LCB3aHkgbm90IGFkZCB0aGUgDQoiaWYgdGFyZ2V0X3dvcmRzX2JpZ2VuZGlhbigpIiBpbiB0
aGUgd3JhcHBlciBoZXJlPw0KDQpBcmUgdGhlcmUgY2FzZXMgd2hlcmUgd2Ugd2FudCBhbm90
aGVyIGVuZGlhbm5lc3MgdGhhbiB0YXJnZXQgb25lPw0KDQo+ICsvKioNCj4gKyAqIGdkYl9n
ZXRfcmVnNjRfdmFsdWUoKSAtIHR5cGUgY2hlY2tlZCB3cmFwcGVyIGZvciBnZGJfZ2V0X3Jl
Z2lzdGVyX3ZhbHVlKCkNCj4gKyAqIG1vOiBzaXplIGFuZCBlbmRpYW4gTWVtT3ANCj4gKyAq
IGJ1ZjogR0J5dGVBcnJheSB0byBzdG9yZSBpbiB0YXJnZXQgb3JkZXINCj4gKyAqIHZhbDog
cG9pbnRlciB0byB1aW50MzJfdCB2YWx1ZSBpbiBob3N0IG9yZGVyDQo+ICsgKi8NCj4gK3N0
YXRpYyBpbmxpbmUgaW50IGdkYl9nZXRfcmVnNjRfdmFsdWUoTWVtT3Agb3AsIEdCeXRlQXJy
YXkgKmJ1ZiwgdWludDY0X3QgKnZhbCkgew0KPiArICAgIGdfYXNzZXJ0KChvcCAmIE1PX1NJ
WkUpID09IE1PXzY0KTsNCj4gKyAgICByZXR1cm4gZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShv
cCwgYnVmLCB2YWwpOw0KPiArfQ0KPiArDQo+ICsjZW5kaWYgLyogR0RCX1JFR0lTVEVSU19I
ICovDQo+ICsNCj4gKw0KPiBkaWZmIC0tZ2l0IGEvZ2Ric3R1Yi9nZGJzdHViLmMgYi9nZGJz
dHViL2dkYnN0dWIuYw0KPiBpbmRleCBiNmQ1ZTExZTAzLi5lNzk5ZmRjMDE5IDEwMDY0NA0K
PiAtLS0gYS9nZGJzdHViL2dkYnN0dWIuYw0KPiArKysgYi9nZGJzdHViL2dkYnN0dWIuYw0K
PiBAQCAtMzIsNiArMzIsNyBAQA0KPiAgICNpbmNsdWRlICJleGVjL2dkYnN0dWIuaCINCj4g
ICAjaW5jbHVkZSAiZ2Ric3R1Yi9jb21tYW5kcy5oIg0KPiAgICNpbmNsdWRlICJnZGJzdHVi
L3N5c2NhbGxzLmgiDQo+ICsjaW5jbHVkZSAiZ2Ric3R1Yi9yZWdpc3RlcnMuaCINCj4gICAj
aWZkZWYgQ09ORklHX1VTRVJfT05MWQ0KPiAgICNpbmNsdWRlICJhY2NlbC90Y2cvdmNwdS1z
dGF0ZS5oIg0KPiAgICNpbmNsdWRlICJnZGJzdHViL3VzZXIuaCINCj4gQEAgLTQ1LDYgKzQ2
LDcgQEANCj4gICAjaW5jbHVkZSAic3lzdGVtL3J1bnN0YXRlLmgiDQo+ICAgI2luY2x1ZGUg
ImV4ZWMvcmVwbGF5LWNvcmUuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCINCj4g
KyNpbmNsdWRlICJleGVjL21lbW9wLmgiDQo+ICAgDQo+ICAgI2luY2x1ZGUgImludGVybmFs
cy5oIg0KPiAgIA0KPiBAQCAtNTUxLDYgKzU1MywyNyBAQCBzdGF0aWMgaW50IGdkYl93cml0
ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3B1LCB1aW50OF90ICptZW1fYnVmLCBpbnQgcmVnKQ0K
PiAgICAgICByZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+ICsvKg0KPiArICogVGFyZ2V0IGhl
bHBlciBmdW5jdGlvbiB0byByZWFkIHZhbHVlIGludG8gR0J5dGVBcnJheSwgdGFyZ2V0DQo+
ICsgKiBzdXBwbGllcyB0aGUgc2l6ZSBhbmQgdGFyZ2V0IGVuZGlhbmVzcyB2aWEgdGhlIE1l
bU9wLg0KPiArICovDQo+ICtpbnQgZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShNZW1PcCBvcCwg
R0J5dGVBcnJheSAqYnVmLCB2b2lkICp2YWwpDQo+ICt7DQo+ICsgICAgdW5zaWduZWQgYnl0
ZXMgPSBtZW1vcF9zaXplKG9wKTsNCj4gKw0KPiArICAgIGlmIChvcCAmIE1PX0JTV0FQKSB7
DQo+ICsgICAgICAgIHVpbnQ4X3QgKnB0ciA9ICYoKHVpbnQ4X3QgKikgdmFsKVtieXRlcyAt
IDFdOw0KPiArICAgICAgICBmb3IgKHVuc2lnbmVkIGkgPSBieXRlczsgaSA+IDA7IGktLSkg
ew0KPiArICAgICAgICAgICAgZ19ieXRlX2FycmF5X2FwcGVuZChidWYsIHB0ci0tLCAxKTsN
Cj4gKyAgICAgICAgfTsNCj4gKyAgICB9IGVsc2Ugew0KPiArICAgICAgICBnX2J5dGVfYXJy
YXlfYXBwZW5kKGJ1ZiwgdmFsLCBieXRlcyk7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0
dXJuIGJ5dGVzOw0KPiArfQ0KPiArDQo+ICsNCj4gICBzdGF0aWMgdm9pZCBnZGJfcmVnaXN0
ZXJfZmVhdHVyZShDUFVTdGF0ZSAqY3B1LCBpbnQgYmFzZV9yZWcsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ2RiX2dldF9yZWdfY2IgZ2V0X3JlZywgZ2RiX3Nl
dF9yZWdfY2Igc2V0X3JlZywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBHREJGZWF0dXJlICpmZWF0dXJlKQ0KDQo=

