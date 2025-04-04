Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E481CC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lf6-0001bH-0y; Fri, 04 Apr 2025 14:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lf1-0001am-Ft
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:21:01 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0les-0007y4-Ub
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:20:59 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so1997363a91.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743790844; x=1744395644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oQ4UAfbeyYopWVznNjT2qiND8F7mIympl7VgqsNdaf8=;
 b=OJuPHeBlqTco2KUyXOeP1ZChQ55su/f++EKblnUlZ88bkqofuRIYKaJXZU9P5O/s76
 xGE8LSyDK/81AiCggvyfGlWnZL92uBCQn7Xs8J137Yx/G9FsPwLUQcR/Z1XqAbyij7Mf
 6kBDFC8VvpSFCbzQIWFs+bi+dWnPIgFDGu+w0muewYQ+dAfRXi16WJVxgl0N1UiPnzk3
 Uhp/wracSMawBoXqZE+B3uEnwyVyEm5tjVtVcL0EJvzIGrRtYOMTZnFz5R3RfqPa/Jbw
 /KBK8tSPMRpFSOiWLqz7hF+gCenT2+FB/rI8JhEr3ACp4uaTk87dHVJSfWbGHjGN84dc
 Ie/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743790844; x=1744395644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oQ4UAfbeyYopWVznNjT2qiND8F7mIympl7VgqsNdaf8=;
 b=NWGLrO4mxVQWXChN+7VkHsZtCxnjhMUx2xBG/Tg+EN9fsiBneCVPytgwPRb2JILS7i
 Sx52H0MUP/pGhnlSHTJsh4gZXkkLWB1e8Ni9qFp9R1WlzORHYwoEBNML6XCO3A76c3lP
 iTRCx9/vrjaBT3RpJ7iMoCPWVotXdpKQdDom40QjIaKJGX12cK3A81u5wb0Mb8b/2Udb
 +gkgRJBBdKnQ/J63u1GtWqQmHDOQzrEldapdUh/UfkAuly953tkUHX9Hvg7glRB2xucg
 KeMSHUuTbLnxmY/t4drJ32Ug6DI9K4EeqSgy8rl84qTS8ECdOn+JI5AJ/KUUHBpSzE6y
 LQ5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGk5LRjjfT28pJo/fmaoRxMeW2jrauWqI36zl7R1CSIsGdLz31CGAo9ITy2hb6f0mNn8klN/PQ3LIT@nongnu.org
X-Gm-Message-State: AOJu0YyUVrJVZ62k8Xu+ki9g7R5wJLKsDTcXSvF3Ks1s195C1WISJYg7
 zwIJePTBsZThKRush+UHUtbJCIqAmnoPeONjArQB2DsMFvsDBASuXkA736fgp4Y=
X-Gm-Gg: ASbGncvulfYfjeOuegNVbSy8wgatOQOsyTUskSWZvz1MmYGjaeFkVm9C28/XmqE8I88
 5xdtvpUbNZiS1k6+K53IAOTcvWgkEWTgRTfoEZDSZZyMwHj4ewLHI8BRWEBUF83cFIiq+8UHaSL
 MZMfHSlzjzNtKCqj4CiOT7iVIqXwHM2mI2Kk9UpIWnEHc+Yry0J3NCXZ1Oy27zNzO0j8V7xcYom
 fP4fCG51TYeuzzcyqdeurLnB6lqovFHSa1UItBkWOrKeL6+aXQdCjdIooQzNumWvIwbyn5hnicd
 e2m7EV48beCy/slzOWaRk4H/QVUTHbOxpUp2mMBrhEA3bLahqLqNNVaI0g==
X-Google-Smtp-Source: AGHT+IETFxl+JSUiNCrmhl0NGe7IPurbDORhn8ZujwIlhA04cwwGPaC7tmCPPcalfEIpRNbC3n0u3w==
X-Received: by 2002:a17:90b:51cd:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-306a4ec74acmr6080326a91.16.1743790844281; 
 Fri, 04 Apr 2025 11:20:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305983d7f2fsm3802902a91.42.2025.04.04.11.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:20:43 -0700 (PDT)
Message-ID: <83a57c49-93fd-4463-81bf-fc0014ff5f3d@linaro.org>
Date: Fri, 4 Apr 2025 11:20:43 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403235821.9909-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

T24gNC8zLzI1IDE2OjU3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gV2Ug
d291bGQgbGlrZSB0byBnZXQgcmlkIG9mICctSSB0YXJnZXQvJEFSQ0gvJyBpbiB0aGUgQ1BQ
RkxBR1MuDQoNCldoaWxlIHRoaXMgY2hhbmdlIGlzIGNvcnJlY3QsIHRoaXMgaXMgbm90IHN0
cmljdGx5IG5lZWRlZC4NCldpdGggdGhlIGN1cnJlbnQgYXBwcm9hY2gsIHVzaW5nIGEgc2V0
IG9mIGNvbW1vbiBmaWxlcyBwZXIgYXJjaGl0ZWN0dXJlLCANCndlIGNhbiByZWx5IG9uIHRo
aXMgaW5jbHVkZSB0byBiZSBwcmVzZW50LCBhbmQgaXQgZG9lcyBub3QgYmxvY2sgZnJvbSAN
CmhhdmluZyBjb21tb24gZmlsZXMuDQoNCj4gVXNlIHRoZSBmdWxsIHBhdGggdG8gImNwdS5o
IjogInRhcmdldC9hcm0vY3B1LmgiLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVu
ZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0K
PiAgIGluY2x1ZGUvaHcvYXJtL2RpZ2ljLmggICAgICB8IDIgKy0NCj4gICBpbmNsdWRlL2h3
L2FybS9mc2wtaW14Ni5oICAgfCAyICstDQo+ICAgaW5jbHVkZS9ody9hcm0vZnNsLWlteDZ1
bC5oIHwgMiArLQ0KPiAgIGluY2x1ZGUvaHcvYXJtL2ZzbC1pbXg3LmggICB8IDIgKy0NCj4g
ICBpbmNsdWRlL2h3L2FybS9mc2wtaW14OG1wLmggfCAyICstDQo+ICAgNSBmaWxlcyBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9hcm0vZGlnaWMuaCBiL2luY2x1ZGUvaHcvYXJtL2RpZ2ljLmgNCj4g
aW5kZXggOGYyNzM1YzI4NGYuLjY0NjgwMjgwNmUwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2h3L2FybS9kaWdpYy5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL2RpZ2ljLmgNCj4gQEAg
LTE4LDcgKzE4LDcgQEANCj4gICAjaWZuZGVmIEhXX0FSTV9ESUdJQ19IDQo+ICAgI2RlZmlu
ZSBIV19BUk1fRElHSUNfSA0KPiAgIA0KPiAtI2luY2x1ZGUgImNwdS5oIg0KPiArI2luY2x1
ZGUgInRhcmdldC9hcm0vY3B1LmgiDQo+ICAgI2luY2x1ZGUgImh3L3RpbWVyL2RpZ2ljLXRp
bWVyLmgiDQo+ICAgI2luY2x1ZGUgImh3L2NoYXIvZGlnaWMtdWFydC5oIg0KPiAgICNpbmNs
dWRlICJxb20vb2JqZWN0LmgiDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9mc2wt
aW14Ni5oIGIvaW5jbHVkZS9ody9hcm0vZnNsLWlteDYuaA0KPiBpbmRleCAxMjRiYmQ0Nzhm
ZC4uMGFjMTQ1Y2Y2YmEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcvYXJtL2ZzbC1pbXg2
LmgNCj4gKysrIGIvaW5jbHVkZS9ody9hcm0vZnNsLWlteDYuaA0KPiBAQCAtMzUsNyArMzUs
NyBAQA0KPiAgICNpbmNsdWRlICJody9wY2ktaG9zdC9kZXNpZ253YXJlLmgiDQo+ICAgI2lu
Y2x1ZGUgImh3L29yLWlycS5oIg0KPiAgICNpbmNsdWRlICJzeXN0ZW0vbWVtb3J5LmgiDQo+
IC0jaW5jbHVkZSAiY3B1LmgiDQo+ICsjaW5jbHVkZSAidGFyZ2V0L2FybS9jcHUuaCINCj4g
ICAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KPiAgIA0KPiAgICNkZWZpbmUgVFlQRV9GU0xf
SU1YNiAiZnNsLWlteDYiDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9mc2wtaW14
NnVsLmggYi9pbmNsdWRlL2h3L2FybS9mc2wtaW14NnVsLmgNCj4gaW5kZXggNGUzMjA5YjI1
YjIuLmY4ZjljMjQ5YTIzIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2FybS9mc2wtaW14
NnVsLmgNCj4gKysrIGIvaW5jbHVkZS9ody9hcm0vZnNsLWlteDZ1bC5oDQo+IEBAIC0zNCw3
ICszNCw3IEBADQo+ICAgI2luY2x1ZGUgImh3L3VzYi9jaGlwaWRlYS5oIg0KPiAgICNpbmNs
dWRlICJody91c2IvaW14LXVzYi1waHkuaCINCj4gICAjaW5jbHVkZSAic3lzdGVtL21lbW9y
eS5oIg0KPiAtI2luY2x1ZGUgImNwdS5oIg0KPiArI2luY2x1ZGUgInRhcmdldC9hcm0vY3B1
LmgiDQo+ICAgI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4gICAjaW5jbHVkZSAicWVtdS91
bml0cy5oIg0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9hcm0vZnNsLWlteDcu
aCBiL2luY2x1ZGUvaHcvYXJtL2ZzbC1pbXg3LmgNCj4gaW5kZXggYWE3ODE4YzQ5OTkuLjZh
ZWRkMmI4MGI1IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2FybS9mc2wtaW14Ny5oDQo+
ICsrKyBiL2luY2x1ZGUvaHcvYXJtL2ZzbC1pbXg3LmgNCj4gQEAgLTM3LDcgKzM3LDcgQEAN
Cj4gICAjaW5jbHVkZSAiaHcvcGNpLWhvc3QvZGVzaWdud2FyZS5oIg0KPiAgICNpbmNsdWRl
ICJody91c2IvY2hpcGlkZWEuaCINCj4gICAjaW5jbHVkZSAiaHcvb3ItaXJxLmgiDQo+IC0j
aW5jbHVkZSAiY3B1LmgiDQo+ICsjaW5jbHVkZSAidGFyZ2V0L2FybS9jcHUuaCINCj4gICAj
aW5jbHVkZSAicW9tL29iamVjdC5oIg0KPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+
ICAgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9mc2wtaW14OG1wLmggYi9pbmNs
dWRlL2h3L2FybS9mc2wtaW14OG1wLmgNCj4gaW5kZXggYmM5N2ZjNDE2ZWIuLmYyMGY5ZTUz
MTg3IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2FybS9mc2wtaW14OG1wLmgNCj4gKysr
IGIvaW5jbHVkZS9ody9hcm0vZnNsLWlteDhtcC5oDQo+IEBAIC05LDcgKzksNyBAQA0KPiAg
ICNpZm5kZWYgRlNMX0lNWDhNUF9IDQo+ICAgI2RlZmluZSBGU0xfSU1YOE1QX0gNCj4gICAN
Cj4gLSNpbmNsdWRlICJjcHUuaCINCj4gKyNpbmNsdWRlICJ0YXJnZXQvYXJtL2NwdS5oIg0K
PiAgICNpbmNsdWRlICJody9jaGFyL2lteF9zZXJpYWwuaCINCj4gICAjaW5jbHVkZSAiaHcv
Z3Bpby9pbXhfZ3Bpby5oIg0KPiAgICNpbmNsdWRlICJody9pMmMvaW14X2kyYy5oIg0KDQo=


