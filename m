Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E15EC369CA
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 00:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5wWQ-00047O-6h; Fri, 18 Apr 2025 20:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wWN-000472-4T
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 20:57:27 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wWI-0001LU-Pj
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 20:57:26 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30820167b47so2324290a91.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 17:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745024239; x=1745629039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GOoXqVBYuWDtWyFSN/CpUnSqXahLlyOpPEACKS1+2Pk=;
 b=mUTqiV/UaXqIIu0cTR5v123buls6gc07srYKjqrmGOaU7k26YO9Iz88YDcHe4SMmWG
 JOp5P5yBK8nzxYXBqlDDXtuo/T6mKgtmfkNeu2zEzueJFihP4l4zmqBF8kEux1RuLkEv
 BMxzmqaYIss1B9FQR25MsCacnywyfB83VyzdtgmPtEEjARecqddi1VI2tfw18BBtRKtU
 N9nQf2NB5bCjkZ0fI1Pg/dnvTRoGXmxBvl1kwt34Owuw67r/AxFGVaZ2wuXH6P72GJr9
 Nyxt1wcHy1LTRO2kgQlEtjQ7JmOtrt2lWtY7KTT7a0S+9KDQBmh18kbOUP9cBgM2WQ9s
 Mc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745024239; x=1745629039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOoXqVBYuWDtWyFSN/CpUnSqXahLlyOpPEACKS1+2Pk=;
 b=XJqo36cQ+i678ONhwpii+4fzfkecbJ5C8ifbKFmIu8s7ciwww+eK6y0flK2naQC5Ck
 p+5+Psg73X7d8YnJduR4/CisVg4gAK2cI2juEeknewVvkUWDExmrv4tFHTDcW7K3C0k7
 lAdptqFxu50Y652H4WM/OQ14lNGvgJjsRjdyNXWUZsnAcpr4fvpcu5loMXEmJVhViq3s
 LYeFWJ0yKezNTtj0Ypdms94mgXx7mlTTkDWTg4xUw3PNnUu8lLN5Ow6ZfM1EuWtW9i09
 wjCtLfszPrrqq4710i6CmfokHFyxdrLiRy4voy3IT1Wo18ZwamAJpsUuFxF/zmygS2wY
 LSyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW5f95Qi8ELEO+ApURqqPqYXYInFZWQXkOnKcdVmhXQv5dGXBmI2NyAhPWC0QJ5R+775RX5gk8e9bw@nongnu.org
X-Gm-Message-State: AOJu0YzXZLmHN/04Vi32cuJjftp7Vn4lQF/VsUsGe1mph2xXvI7U5zF0
 9ic2Hmt1GW9XC7VaWy4Mfg2/GVn79MmP9PMxQTKFCER8OJV3ZvR4P7dBgvH2HHg=
X-Gm-Gg: ASbGncu5zPSAtQioSC1xZM3W6WPtu99wjLznaDlXfVfKb2scZeYSHG0/WJrG/XlS9+O
 VxSGq1NZTTbc/+sEo04zf70p2OHcIdoJ5jAGy3UEbeCBFwODJ5X2Drw6dXyykql37MVoNnLPk4l
 LzR0+yuB4MMhqdOKaYcbH36QRRqBLKp6au7GOL6cCSp84n6X7tYIFMlBnoMUwlCvWlu4Ird6Lox
 u3zLdO32ezemcxCoPWCRZ3uWrTnPcZVKb5mVGAnNdXg4YMp8gWghvpW0rekRlRRMUUkq9OtmtUY
 HGFp0Iz9jP4juHlevjVem+dbwBeaH8rzzX47cDYv3i6P84rK5Wqx3g==
X-Google-Smtp-Source: AGHT+IEMC0nAx0d7FarGtYzwAzCI6JxoC11yy3YUhppOou2kb5fvRvnQklrwUWerQ2+PaVgVvcv7XA==
X-Received: by 2002:a17:90b:5824:b0:2ff:53d6:2b82 with SMTP id
 98e67ed59e1d1-30879c02aa9mr8317975a91.11.1745024239267; 
 Fri, 18 Apr 2025 17:57:19 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee87f8sm1891719a91.4.2025.04.18.17.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 17:57:18 -0700 (PDT)
Message-ID: <84254251-b469-46f3-85dd-da5e7f2e3d2c@linaro.org>
Date: Fri, 18 Apr 2025 17:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/14] system/vl: Filter machine list available for
 a particular target binary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-4-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418172908.25147-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

T24gNC8xOC8yNSAxMDoyOCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEJp
bmFyaWVzIGNhbiByZWdpc3RlciBhIFFPTSB0eXBlIHRvIGZpbHRlciB0aGVpciBtYWNoaW5l
cw0KPiBieSBmaWxsaW5nIHRoZWlyIFRhcmdldEluZm86Om1hY2hpbmVfdHlwZW5hbWUgZmll
bGQuDQo+IA0KPiBUaGlzIGNhbiBiZSB1c2VkIGJ5IGV4YW1wbGUgYnkgbWFpbigpIC0+IG1h
Y2hpbmVfaGVscF9mdW5jKCkNCj4gdG8gZmlsdGVyIHRoZSBtYWNoaW5lcyBsaXN0Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5h
cm8ub3JnPg0KPiAtLS0NCj4gICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgIHwg
IDEgKw0KPiAgIGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1pbXBsLmggfCAgMyArKysNCj4g
ICBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaCAgICAgIHwgIDggKysrKysrKysNCj4gICBz
eXN0ZW0vdmwuYyAgICAgICAgICAgICAgICAgICAgIHwgIDMgKystDQo+ICAgdGFyZ2V0X2lu
Zm8tcW9tLmMgICAgICAgICAgICAgICB8IDE1ICsrKysrKysrKysrKysrKw0KPiAgIHRhcmdl
dF9pbmZvLXN0dWIuYyAgICAgICAgICAgICAgfCAgMiArKw0KPiAgIHRhcmdldF9pbmZvLmMg
ICAgICAgICAgICAgICAgICAgfCAgNSArKysrKw0KPiAgIDcgZmlsZXMgY2hhbmdlZCwgMzYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
YXJnZXRfaW5mby1xb20uYw0KPiANCj4gZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVz
b24uYnVpbGQNCj4gaW5kZXggNDlhMDUwYTI4YTMuLjE2OGIwN2I1ODg3IDEwMDY0NA0KPiAt
LS0gYS9tZXNvbi5idWlsZA0KPiArKysgYi9tZXNvbi5idWlsZA0KPiBAQCAtMzgwOCw2ICsz
ODA4LDcgQEAgY29tbW9uX3NzLmFkZChwYWdldmFyeSkNCj4gICBzcGVjaWZpY19zcy5hZGQo
ZmlsZXMoJ3BhZ2UtdGFyZ2V0LmMnLCAncGFnZS12YXJ5LXRhcmdldC5jJykpDQo+ICAgDQo+
ICAgY29tbW9uX3NzLmFkZChmaWxlcygndGFyZ2V0X2luZm8uYycpKQ0KPiArc3lzdGVtX3Nz
LmFkZChmaWxlcygndGFyZ2V0X2luZm8tcW9tLmMnKSkNCj4gICBzcGVjaWZpY19zcy5hZGQo
ZmlsZXMoJ3RhcmdldF9pbmZvLXN0dWIuYycpKQ0KPiAgIA0KPiAgIHN1YmRpcignYmFja2Vu
ZHMnKQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLWltcGwuaCBi
L2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1pbXBsLmgNCj4gaW5kZXggMTFiOTI3OTZiMjgu
LmUzMzQ0Mjc4YTkyIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8t
aW1wbC5oDQo+ICsrKyBiL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1pbXBsLmgNCj4gQEAg
LTE2LDYgKzE2LDkgQEAgdHlwZWRlZiBzdHJ1Y3QgVGFyZ2V0SW5mbyB7DQo+ICAgICAgIC8q
IHJ1bnRpbWUgZXF1aXZhbGVudCBvZiBUQVJHRVRfTkFNRSBkZWZpbml0aW9uICovDQo+ICAg
ICAgIGNvbnN0IGNoYXIgKmNvbnN0IHRhcmdldF9uYW1lOw0KPiAgIA0KPiArICAgIC8qIFFP
TSB0eXBlbmFtZSBtYWNoaW5lcyBmb3IgdGhpcyBiaW5hcnkgbXVzdCBpbXBsZW1lbnQgKi8N
Cj4gKyAgICBjb25zdCBjaGFyICpjb25zdCBtYWNoaW5lX3R5cGVuYW1lOw0KPiArDQo+ICAg
fSBUYXJnZXRJbmZvOw0KPiAgIA0KPiAgIGNvbnN0IFRhcmdldEluZm8gKnRhcmdldF9pbmZv
KHZvaWQpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLmggYi9p
bmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaA0KPiBpbmRleCAzZjZjYmJiZDMwMC4uYzY3Yjk3
ZDY2ZjMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby5oDQo+ICsr
KyBiL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby5oDQo+IEBAIC0xNiw0ICsxNiwxMiBAQA0K
PiAgICAqLw0KPiAgIGNvbnN0IGNoYXIgKnRhcmdldF9uYW1lKHZvaWQpOw0KPiAgIA0KPiAr
LyoqDQo+ICsgKiB0YXJnZXRfbWFjaGluZV90eXBlbmFtZToNCj4gKyAqDQo+ICsgKiBSZXR1
cm5zOiBOYW1lIG9mIHRoZSBRT00gaW50ZXJmYWNlIGltcGxlbWVudGVkIGJ5IG1hY2hpbmVz
DQo+ICsgKiAgICAgICAgICB1c2FibGUgb24gdGhpcyB0YXJnZXQgYmluYXJ5Lg0KPiArICov
DQo+ICtjb25zdCBjaGFyICp0YXJnZXRfbWFjaGluZV90eXBlbmFtZSh2b2lkKTsNCj4gKw0K
PiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvc3lzdGVtL3ZsLmMgYi9zeXN0ZW0vdmwuYw0K
PiBpbmRleCBkOGEwZmU3MTNjOS4uOGZiMThmODJlMjAgMTAwNjQ0DQo+IC0tLSBhL3N5c3Rl
bS92bC5jDQo+ICsrKyBiL3N5c3RlbS92bC5jDQo+IEBAIC0yNyw2ICsyNyw3IEBADQo+ICAg
I2luY2x1ZGUgInFlbXUvZGF0YWRpci5oIg0KPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgi
DQo+ICAgI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJn
ZXRfaW5mby5oIg0KPiAgICNpbmNsdWRlICJleGVjL2NwdS1jb21tb24uaCINCj4gICAjaW5j
bHVkZSAiZXhlYy9wYWdlLXZhcnkuaCINCj4gICAjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0
aWVzLmgiDQo+IEBAIC0xNTY0LDcgKzE1NjUsNyBAQCBzdGF0aWMgdm9pZCBtYWNoaW5lX2hl
bHBfZnVuYyhjb25zdCBRRGljdCAqcWRpY3QpDQo+ICAgICAgIEdTTGlzdCAqZWw7DQo+ICAg
ICAgIGNvbnN0IGNoYXIgKnR5cGUgPSBxZGljdF9nZXRfdHJ5X3N0cihxZGljdCwgInR5cGUi
KTsNCj4gICANCj4gLSAgICBtYWNoaW5lcyA9IG9iamVjdF9jbGFzc19nZXRfbGlzdChUWVBF
X01BQ0hJTkUsIGZhbHNlKTsNCj4gKyAgICBtYWNoaW5lcyA9IG9iamVjdF9jbGFzc19nZXRf
bGlzdCh0YXJnZXRfbWFjaGluZV90eXBlbmFtZSgpLCBmYWxzZSk7DQo+ICAgICAgIGlmICh0
eXBlKSB7DQo+ICAgICAgICAgICBPYmplY3RDbGFzcyAqbWFjaGluZV9jbGFzcyA9IE9CSkVD
VF9DTEFTUyhmaW5kX21hY2hpbmUodHlwZSwgbWFjaGluZXMpKTsNCj4gICAgICAgICAgIGlm
IChtYWNoaW5lX2NsYXNzKSB7DQo+IGRpZmYgLS1naXQgYS90YXJnZXRfaW5mby1xb20uYyBi
L3RhcmdldF9pbmZvLXFvbS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAwMDAwLi5hNmZkOGYxZDVhMw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rhcmdl
dF9pbmZvLXFvbS5jDQo+IEBAIC0wLDAgKzEsMTUgQEANCj4gKy8qDQo+ICsgKiBRRU1VIGJp
bmFyeS90YXJnZXQgQVBJIChRT00gdHlwZXMpDQo+ICsgKg0KPiArICogIENvcHlyaWdodCAo
YykgTGluYXJvDQo+ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb3ItbGF0ZXINCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0K
PiArI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4gKw0KPiArc3RhdGljIGNvbnN0IFR5cGVJ
bmZvIHRhcmdldF9pbmZvX3R5cGVzW10gPSB7DQo+ICt9Ow0KPiArDQo+ICtERUZJTkVfVFlQ
RVModGFyZ2V0X2luZm9fdHlwZXMpDQo+IGRpZmYgLS1naXQgYS90YXJnZXRfaW5mby1zdHVi
LmMgYi90YXJnZXRfaW5mby1zdHViLmMNCj4gaW5kZXggZjE1OTcyYzViMjIuLjE0ZTZkNWU2
OGQyIDEwMDY0NA0KPiAtLS0gYS90YXJnZXRfaW5mby1zdHViLmMNCj4gKysrIGIvdGFyZ2V0
X2luZm8tc3R1Yi5jDQo+IEBAIC04LDkgKzgsMTEgQEANCj4gICANCj4gICAjaW5jbHVkZSAi
cWVtdS9vc2RlcC5oIg0KPiAgICNpbmNsdWRlICJxZW11L3RhcmdldF9pbmZvLWltcGwuaCIN
Cj4gKyNpbmNsdWRlICJody9ib2FyZHMuaCINCj4gICANCj4gICBzdGF0aWMgY29uc3QgVGFy
Z2V0SW5mbyB0YXJnZXRfaW5mb19zdHViID0gew0KPiAgICAgICAudGFyZ2V0X25hbWUgPSBU
QVJHRVRfTkFNRSwNCj4gKyAgICAubWFjaGluZV90eXBlbmFtZSA9IFRZUEVfTUFDSElORSwN
Cj4gICB9Ow0KDQpFeGNlbGxlbnQsIGV2ZW4gbW9yZSBzaW1wbGUgdGhhbiByZXR1cm5pbmcg
TlVMTC4NCg0KPiAgIA0KPiAgIGNvbnN0IFRhcmdldEluZm8gKnRhcmdldF9pbmZvKHZvaWQp
DQo+IGRpZmYgLS1naXQgYS90YXJnZXRfaW5mby5jIGIvdGFyZ2V0X2luZm8uYw0KPiBpbmRl
eCA0OGM0YTQxMzMyNi4uMWRlNDMzNGVjYzUgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldF9pbmZv
LmMNCj4gKysrIGIvdGFyZ2V0X2luZm8uYw0KPiBAQCAtMTQsMyArMTQsOCBAQCBjb25zdCBj
aGFyICp0YXJnZXRfbmFtZSh2b2lkKQ0KPiAgIHsNCj4gICAgICAgcmV0dXJuIHRhcmdldF9p
bmZvKCktPnRhcmdldF9uYW1lOw0KPiAgIH0NCj4gKw0KPiArY29uc3QgY2hhciAqdGFyZ2V0
X21hY2hpbmVfdHlwZW5hbWUodm9pZCkNCj4gK3sNCj4gKyAgICByZXR1cm4gdGFyZ2V0X2lu
Zm8oKS0+bWFjaGluZV90eXBlbmFtZTsNCj4gK30NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNr
IEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

