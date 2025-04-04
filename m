Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4374C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZI-0002M8-J9; Fri, 04 Apr 2025 13:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZ8-0002JA-2h
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZ5-0005lR-N3
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22403cbb47fso24899475ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786644; x=1744391444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MdzHWJgT1larSxaL8vX28n30uB1R/Bkrzpj5XNUfvD8=;
 b=N3p6dbxQ++NcG6Kal5soIB7dNyniwhL/VDqCkC3pX88PZ/XTlxaQpz+0m7zDunRIzC
 Pc0RZone6kLAJAVw7E2if8JQbwIXPk+95XWE16CPpxR1M5q4ORoaJEpebjds2D+HYFYx
 T7Ial7NuS2hxq+QVAvu6Jnm04s/Fn1is4KtOOUNT8og+k/zzbiy6wCu3AfvdDKKduMeF
 1YlssELidcpGH0Z5hJYNaJJG9ZUnLvxZxDkcC0LwUzk8ZtNr3zvMwaf3D3FJpyPBstds
 mu8mRdJ3Pf6BRWo/WGjL/FnK5hl8TDzoiq4PYNns0R/E3PDAFiSSJVndis5uWnwtdOWk
 W9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786644; x=1744391444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdzHWJgT1larSxaL8vX28n30uB1R/Bkrzpj5XNUfvD8=;
 b=kzWQtw7aVgJKjeALKpwn85yNc65oFJV5R5mjit6hz4J74t3v5OIHB0v63lA+IstFul
 ze3md+GB92xNni018roy3Ifmw8KE5VTAbCzIzAUjmhcS/X498EDu4hQqA75RCN//XzwW
 XQDQ6w0MBV3Z5N+qXNzccjEYA9VHr8Fr+h0YB/IoATMGrE0BkVjpZQAdZqkg6w/1BX+Z
 U8bCbftzshHIEoFKEAUf3REPzPc5Nc1L9GLeY4+1mJizVyO9m2LNTrRreeMeoAwVGNBX
 ddQQ/8OTHEgSAUKRWepBICpjCa/4yfGKgQculqVV0/ErXE9TuqIEGEhsRdl3SSs/AGKL
 Ok8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPgYzvn0ADT/bDUUErCYm1TLGvY44+IsyzwfvayDCSCGAEiZ719yYMvvbBU+0jZJw9ntKQNdGHeOXN@nongnu.org
X-Gm-Message-State: AOJu0Yyif9eTA4TVzuUTu/JzZBKNLYqisP2sx6j8ojnRoV6rFyQG6Tzt
 rAQPsw+Hj28MS4wnT7iR8q7pCghV/L4a4GLlrPhanbrivZXA90rfuvaNJVVipwY=
X-Gm-Gg: ASbGncv7RmJCqFbFLkIyQ/hWfhoW/kZcHT1FzRT99Puxz0tOE8EPZGQnCgspjb16vR5
 YL3rv+4UVFEO6V2EviSpLf7ZD0/4XLMXnxzG/p+O2kD4Bu95ZqNNaTy2oApmtXgInof0+wYVYTE
 VG8FuI87A7i4J6Q/gzFUbJq433o1S1x44W0knAd0mMvhLvk9TqlcSuoGAUYEpjj9r0qB7GmicJW
 6zcYJvU7jAGIxmQtsRgg5/Ii2WusSvlJGgp36J0xnaOVLS8u1fLcWObBPmJ2fUog6H71JsnJ5am
 FyGsaLJctbGbu6cyCroC1xLIxY1A6WluJaXDQMev+AOyHhdAfIKhoPPhkw==
X-Google-Smtp-Source: AGHT+IF4W89BcOpJBiOyOKm5FINkTZyiART5gjECnXfLom8jgHsJRnojaVOymVqpyCf8xGGroM4o1g==
X-Received: by 2002:a17:903:283:b0:224:c47:b6c3 with SMTP id
 d9443c01a7336-22a8a8592a6mr35988885ad.6.1743786644396; 
 Fri, 04 Apr 2025 10:10:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:43 -0700 (PDT)
Message-ID: <a50df14f-99ed-4629-83a3-ffd5e5fb1e9d@linaro.org>
Date: Fri, 4 Apr 2025 09:44:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 03/19] qemu: Factor target_system_arch() out
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-4-philmd@linaro.org>
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

T24gNC8zLzI1IDE2OjQ4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8taW1wbC5oIHwgIDQgKysr
Kw0KPiAgIGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby5oICAgICAgfCAgNCArKysrDQo+ICAg
aHcvY29yZS9tYWNoaW5lLXFtcC1jbWRzLmMgICAgICB8ICA2ICsrLS0tLQ0KPiAgIHRhcmdl
dF9pbmZvLXN0dWIuYyAgICAgICAgICAgICAgfCAgMSArDQo+ICAgdGFyZ2V0X2luZm8uYyAg
ICAgICAgICAgICAgICAgICB8IDEyICsrKysrKysrKysrKw0KPiAgIDUgZmlsZXMgY2hhbmdl
ZCwgMjMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8taW1wbC5oIGIvaW5jbHVkZS9xZW11L3Rhcmdl
dF9pbmZvLWltcGwuaA0KPiBpbmRleCAwMGJiNzQ2NTcyYi4uMGNlYzIxMWUzNjIgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1pbXBsLmgNCj4gKysrIGIvaW5j
bHVkZS9xZW11L3RhcmdldF9pbmZvLWltcGwuaA0KPiBAQCAtMTAsNiArMTAsNyBAQA0KPiAg
ICNkZWZpbmUgUUVNVV9UQVJHRVRfSU5GT19JTVBMX0gNCj4gICANCj4gICAjaW5jbHVkZSAi
cWVtdS90YXJnZXRfaW5mby5oIg0KPiArI2luY2x1ZGUgInFhcGkvcWFwaS10eXBlcy1tYWNo
aW5lLmgiDQo+ICAgDQo+ICAgc3RydWN0IEJpbmFyeVRhcmdldEluZm8gew0KPiAgIA0KPiBA
QCAtMTksNiArMjAsOSBAQCBzdHJ1Y3QgQmluYXJ5VGFyZ2V0SW5mbyB7DQo+ICAgICAgIC8q
IHJ1bnRpbWUgZXF1aXZhbGVudCBvZiBUQVJHRVRfTkFNRSBkZWZpbml0aW9uICovDQo+ICAg
ICAgIGNvbnN0IGNoYXIgKmNvbnN0IG5hbWU7DQo+ICAgDQo+ICsgICAgLyogcmVsYXRlZCB0
byBUQVJHRVRfQVJDSCBkZWZpbml0aW9uICovDQo+ICsgICAgU3lzRW11VGFyZ2V0IHN5c3Rl
bV9hcmNoOw0KPiArDQo+ICAgfTsNCj4gICANCj4gICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby5oIGIvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZv
LmgNCj4gaW5kZXggNWI4ZjE3YTE1YTMuLjZjYTM2ZGFlOGEzIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaA0KPiArKysgYi9pbmNsdWRlL3FlbXUvdGFyZ2V0
X2luZm8uaA0KPiBAQCAtOSw2ICs5LDggQEANCj4gICAjaWZuZGVmIFFFTVVfVEFSR0VUX0lO
Rk9fSA0KPiAgICNkZWZpbmUgUUVNVV9UQVJHRVRfSU5GT19IDQo+ICAgDQo+ICsjaW5jbHVk
ZSAicWFwaS9xYXBpLXR5cGVzLW1hY2hpbmUuaCINCj4gKw0KPiAgIHR5cGVkZWYgc3RydWN0
IEJpbmFyeVRhcmdldEluZm8gQmluYXJ5VGFyZ2V0SW5mbzsNCj4gICANCj4gICBjb25zdCBC
aW5hcnlUYXJnZXRJbmZvICp0YXJnZXRfaW5mbyh2b2lkKTsNCj4gQEAgLTE3LDQgKzE5LDYg
QEAgYm9vbCB0YXJnZXRfaW5mb19pc19zdHViKHZvaWQpOw0KPiAgIA0KPiAgIGNvbnN0IGNo
YXIgKnRhcmdldF9uYW1lKHZvaWQpOw0KPiAgIA0KPiArU3lzRW11VGFyZ2V0IHRhcmdldF9z
eXN0ZW1fYXJjaCh2b2lkKTsNCj4gKw0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvaHcv
Y29yZS9tYWNoaW5lLXFtcC1jbWRzLmMgYi9ody9jb3JlL21hY2hpbmUtcW1wLWNtZHMuYw0K
PiBpbmRleCA2NzAxZTIxMGY1NC4uOWUyZGQzNDhjMDYgMTAwNjQ0DQo+IC0tLSBhL2h3L2Nv
cmUvbWFjaGluZS1xbXAtY21kcy5jDQo+ICsrKyBiL2h3L2NvcmUvbWFjaGluZS1xbXAtY21k
cy5jDQo+IEBAIC0zNiw4ICszNiw3IEBAIENwdUluZm9GYXN0TGlzdCAqcW1wX3F1ZXJ5X2Nw
dXNfZmFzdChFcnJvciAqKmVycnApDQo+ICAgICAgIE1hY2hpbmVTdGF0ZSAqbXMgPSBNQUNI
SU5FKHFkZXZfZ2V0X21hY2hpbmUoKSk7DQo+ICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBN
QUNISU5FX0dFVF9DTEFTUyhtcyk7DQo+ICAgICAgIENwdUluZm9GYXN0TGlzdCAqaGVhZCA9
IE5VTEwsICoqdGFpbCA9ICZoZWFkOw0KPiAtICAgIFN5c0VtdVRhcmdldCB0YXJnZXQgPSBx
YXBpX2VudW1fcGFyc2UoJlN5c0VtdVRhcmdldF9sb29rdXAsIHRhcmdldF9uYW1lKCksDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtMSwgJmVycm9y
X2Fib3J0KTsNCj4gKyAgICBTeXNFbXVUYXJnZXQgdGFyZ2V0ID0gdGFyZ2V0X3N5c3RlbV9h
cmNoKCk7DQo+ICAgICAgIENQVVN0YXRlICpjcHU7DQo+ICAgDQo+ICAgICAgIENQVV9GT1JF
QUNIKGNwdSkgew0KPiBAQCAtMTM3LDggKzEzNiw3IEBAIFRhcmdldEluZm8gKnFtcF9xdWVy
eV90YXJnZXQoRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gICAgICAgVGFyZ2V0SW5mbyAqaW5m
byA9IGdfbWFsbG9jMChzaXplb2YoKmluZm8pKTsNCj4gICANCj4gLSAgICBpbmZvLT5hcmNo
ID0gcWFwaV9lbnVtX3BhcnNlKCZTeXNFbXVUYXJnZXRfbG9va3VwLCB0YXJnZXRfbmFtZSgp
LCAtMSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9y
dCk7DQo+ICsgICAgaW5mby0+YXJjaCA9IHRhcmdldF9zeXN0ZW1fYXJjaCgpOw0KPiAgIA0K
PiAgICAgICByZXR1cm4gaW5mbzsNCj4gICB9DQo+IGRpZmYgLS1naXQgYS90YXJnZXRfaW5m
by1zdHViLmMgYi90YXJnZXRfaW5mby1zdHViLmMNCj4gaW5kZXggZGI2MWEzMzU5MDguLjQ2
YTI0MGFjNjZhIDEwMDY0NA0KPiAtLS0gYS90YXJnZXRfaW5mby1zdHViLmMNCj4gKysrIGIv
dGFyZ2V0X2luZm8tc3R1Yi5jDQo+IEBAIC0xNCw2ICsxNCw3IEBADQo+ICAgc3RhdGljIGNv
bnN0IEJpbmFyeVRhcmdldEluZm8gdGFyZ2V0X2luZm9fc3R1YiA9IHsNCj4gICAgICAgLmlz
X3N0dWIgPSB0cnVlLA0KPiAgICAgICAubmFtZSA9IFRBUkdFVF9OQU1FLA0KPiArICAgIC5z
eXN0ZW1fYXJjaCA9IC0xLA0KPiAgIH07DQo+ICAgDQo+ICAgY29uc3QgQmluYXJ5VGFyZ2V0
SW5mbyAqdGFyZ2V0X2luZm8odm9pZCkNCj4gZGlmZiAtLWdpdCBhL3RhcmdldF9pbmZvLmMg
Yi90YXJnZXRfaW5mby5jDQo+IGluZGV4IDZiNDRlYTlmYzBlLi5iZTRmMTkwMDliMyAxMDA2
NDQNCj4gLS0tIGEvdGFyZ2V0X2luZm8uYw0KPiArKysgYi90YXJnZXRfaW5mby5jDQo+IEBA
IC05LDYgKzksNyBAQA0KPiAgICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ICAgI2luY2x1
ZGUgInFlbXUvdGFyZ2V0X2luZm8taW1wbC5oIg0KPiAgICNpbmNsdWRlICJxZW11L3Rhcmdl
dF9pbmZvLmgiDQo+ICsjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiAgIA0KPiAgIGJvb2wg
dGFyZ2V0X2luZm9faXNfc3R1Yih2b2lkKQ0KPiAgIHsNCj4gQEAgLTE5LDMgKzIwLDE0IEBA
IGNvbnN0IGNoYXIgKnRhcmdldF9uYW1lKHZvaWQpDQo+ICAgew0KPiAgICAgICByZXR1cm4g
dGFyZ2V0X2luZm8oKS0+bmFtZTsNCj4gICB9DQo+ICsNCj4gK1N5c0VtdVRhcmdldCB0YXJn
ZXRfc3lzdGVtX2FyY2godm9pZCkNCj4gK3sNCj4gKyAgICBTeXNFbXVUYXJnZXQgc3lzdGVt
X2FyY2ggPSB0YXJnZXRfaW5mbygpLT5zeXN0ZW1fYXJjaDsNCj4gKw0KPiArICAgIGlmIChz
eXN0ZW1fYXJjaCA+PSBTWVNfRU1VX1RBUkdFVF9fTUFYKSB7DQo+ICsgICAgICAgIHN5c3Rl
bV9hcmNoID0gcWFwaV9lbnVtX3BhcnNlKCZTeXNFbXVUYXJnZXRfbG9va3VwLCB0YXJnZXRf
bmFtZSgpLCAtMSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JmVycm9yX2Fib3J0KTsNCj4gKyAgICB9DQo+ICsgICAgcmV0dXJuIHN5c3RlbV9hcmNoOw0K
PiArfQ0KDQpNYXliZSB3ZSBjb3VsZCBsZWF2ZSB0aGF0IG91dCBmb3Igbm93LCBhbmQgZm9j
dXMgb24gcmVwcmVzZW50aW5nIGNvbXBpbGUgDQp0aW1lIGRlZmluZXMgb25seSBhcyBhIGZp
cnN0IHN0ZXAuDQo=

