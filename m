Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6187E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKixS-0005jq-55; Mon, 09 Dec 2024 13:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKixP-0005jI-3i
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:58:11 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKixN-0000v5-Gx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:58:10 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2163b0c09afso16728795ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733770688; x=1734375488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rKwnPcZFW82SjtigXixjv5VxBhQz55AUkWwSjHyTPUA=;
 b=HDmfV6NcXyznj/NNroSNcfkdPg7CNUp5wJsCqiQ9KyZucZA3HsbskcGl5UtQaGQbdQ
 4TEYtkcaT2470GxlfYBERlavyntLH0yVIpj5+pTAkxGIQ+MLT1bzHJaukGM4ZnaUkp9X
 sx36Z9BwrDWsFo1OlxzqxH1rttzzVN6wIwVHqLxIC95zOo6F1fSVmBTLZkun60f62Gxa
 DR+XJuQPA6GB90lNaiy7eZomPPaCFsTouIxs0Ng/Cx1iIEK5nEQY//dL1aKlvnD2uQBN
 FfZ2McprlHjkLFP92SfdgLHtssqN2e1z399ELvyErr52EsiC9X425k7WKJ77A2yrJWvi
 yxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770688; x=1734375488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKwnPcZFW82SjtigXixjv5VxBhQz55AUkWwSjHyTPUA=;
 b=jvK09LxSIQHR9rrIsSSpnvP02mWi49CuY8oBO0k2qLDtFGlbtxZB7yQs07Md45DcgF
 cLRT/2jCovzSCGgXGBFFBfunk4n9HyftGqsUqCRAUbCc3sjvivKMEe3QrB6hOFiAucys
 E0e2mFsJlP83644+NasZ/JEGG1/hINv/TfQQ2tuKIOrEyyTQy5wN0CKrZ+lD/B1h8SdI
 8tRoKrjxQL0JY7OzCm/wOKJ2dtbYzf78um1MLF44jz7YzU90lLQpVoAU73UClkMKPNDF
 qobI5SruUy6GHx09vv5L1KpobQAniGeQxJANSmQRA45caZbCYUg1MU8H1yTLc2nelA8l
 RWzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYHnu7JMJ+ZJg7nL9iqQanq5vrZKW6jU09L0PsCrVqXMmSD7JwNE4S3UyumvI/xuSZQW1F4/OjGza7@nongnu.org
X-Gm-Message-State: AOJu0YwD9SD0se9ZDFEFiLCOtTq52u9YoJgpgOJzI3qgV21D6z7It7Ue
 RXRCx+5zrvaDcwmkMr1Lwzrz8IiUTZCGUg5DS2D2OQzxmmaigsiIzqCTBIpqHK4=
X-Gm-Gg: ASbGncuUIQzyNA51xbyPVSqk38JFlH3aCxLZNIRI5qjE4a9eX9A/C1IKEGxlhFrWXQO
 Xog0dvKgKhgNN5HlkyLPIIb+JZksS/86ylVMnt9fvzxEqkppfoBJfjiBpmdKZIXuD1FEnpYrnGb
 TDG8PQxvymnSZ+hM+/592DOZcgoGm4eH7+gvi20NQ2L9hD8enVbzsLJFLvzNBE0EDat4/1jfnnd
 Gh7cIPspE6iu52OjCt42tBDmbVv3LrfPJfplXboBkGtBji3lEY5xLUddfc8s6MjKOR2V8dq8Gh2
 Se/nGXWxGPFhstW+4IIdcg==
X-Google-Smtp-Source: AGHT+IET5oVV75AKzGbqpWzLlrnJNN1euQtK1WWipy0EyxQ5hggtfm/RmQuL3njWCzNS++J0cg/5ZA==
X-Received: by 2002:a17:902:ce85:b0:216:59d4:40eb with SMTP id
 d9443c01a7336-21659d44920mr38802365ad.57.1733770688099; 
 Mon, 09 Dec 2024 10:58:08 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21644dcf724sm27273495ad.257.2024.12.09.10.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 10:58:07 -0800 (PST)
Message-ID: <be877e3b-837c-402a-8d00-2e5ca8033c9c@linaro.org>
Date: Mon, 9 Dec 2024 10:58:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/net/can: clean-up unnecessary includes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>
References: <20241209100635.93243-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241209100635.93243-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gMTIvOS8yNCAwMjowNiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgZXZlbnRfbm90
aWZpZXIsIHRocmVhZCBhbmQgc29ja2V0IGluY2x1ZGVzIGxvb2sgbGlrZSBjb3B5IGFuZA0K
PiBwYXN0ZSBvZiBzdGFuZGFyZCBoZWFkZXJzLiBOb25lIG9mIHRoZSBjYW5idXMgZGV2aWNl
cyB1c2UgY2hhcmRldg0KPiBhbHRob3VnaCBzb21lIHJlbGllZCBvbiBjaGFyZGV2IHRvIGJy
aW5nIGluIGJpdG9wcyBhbmQgYnl0ZSBzd2FwcGluZw0KPiBoZWFkZXJzLiBJbiB0aGlzIGNh
c2UgaW5jbHVkZSB0aGVtIGRpcmVjdGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBC
ZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBody9uZXQvY2Fu
L2Nhbl9rdmFzZXJfcGNpLmMgICB8IDQgLS0tLQ0KPiAgIGh3L25ldC9jYW4vY2FuX21pb2Uz
NjgwX3BjaS5jIHwgNCAtLS0tDQo+ICAgaHcvbmV0L2Nhbi9jYW5fcGNtMzY4MF9wY2kuYyAg
fCA0IC0tLS0NCj4gICBody9uZXQvY2FuL2Nhbl9zamExMDAwLmMgICAgICB8IDIgKy0NCj4g
ICBody9uZXQvY2FuL2N0dWNhbl9jb3JlLmMgICAgICB8IDMgKystDQo+ICAgaHcvbmV0L2Nh
bi9jdHVjYW5fcGNpLmMgICAgICAgfCA0IC0tLS0NCj4gICA2IGZpbGVzIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcv
bmV0L2Nhbi9jYW5fa3Zhc2VyX3BjaS5jIGIvaHcvbmV0L2Nhbi9jYW5fa3Zhc2VyX3BjaS5j
DQo+IGluZGV4IDM4NDM0ZDNhMDQuLjllMzYzZDUzMmYgMTAwNjQ0DQo+IC0tLSBhL2h3L25l
dC9jYW4vY2FuX2t2YXNlcl9wY2kuYw0KPiArKysgYi9ody9uZXQvY2FuL2Nhbl9rdmFzZXJf
cGNpLmMNCj4gQEAgLTMwLDEyICszMCw4IEBADQo+ICAgICovDQo+ICAgDQo+ICAgI2luY2x1
ZGUgInFlbXUvb3NkZXAuaCINCj4gLSNpbmNsdWRlICJxZW11L2V2ZW50X25vdGlmaWVyLmgi
DQo+ICAgI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiDQo+IC0jaW5jbHVkZSAicWVtdS90aHJl
YWQuaCINCj4gLSNpbmNsdWRlICJxZW11L3NvY2tldHMuaCINCj4gICAjaW5jbHVkZSAicWFw
aS9lcnJvci5oIg0KPiAtI2luY2x1ZGUgImNoYXJkZXYvY2hhci5oIg0KPiAgICNpbmNsdWRl
ICJody9pcnEuaCINCj4gICAjaW5jbHVkZSAiaHcvcGNpL3BjaV9kZXZpY2UuaCINCj4gICAj
aW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQo+IGRpZmYgLS1naXQgYS9ody9uZXQv
Y2FuL2Nhbl9taW9lMzY4MF9wY2kuYyBiL2h3L25ldC9jYW4vY2FuX21pb2UzNjgwX3BjaS5j
DQo+IGluZGV4IDIxNjU5YjdhZmIuLjU4MGYwOTllMDAgMTAwNjQ0DQo+IC0tLSBhL2h3L25l
dC9jYW4vY2FuX21pb2UzNjgwX3BjaS5jDQo+ICsrKyBiL2h3L25ldC9jYW4vY2FuX21pb2Uz
NjgwX3BjaS5jDQo+IEBAIC0yNiwxMiArMjYsOCBAQA0KPiAgICAqLw0KPiAgIA0KPiAgICNp
bmNsdWRlICJxZW11L29zZGVwLmgiDQo+IC0jaW5jbHVkZSAicWVtdS9ldmVudF9ub3RpZmll
ci5oIg0KPiAgICNpbmNsdWRlICJxZW11L21vZHVsZS5oIg0KPiAtI2luY2x1ZGUgInFlbXUv
dGhyZWFkLmgiDQo+IC0jaW5jbHVkZSAicWVtdS9zb2NrZXRzLmgiDQo+ICAgI2luY2x1ZGUg
InFhcGkvZXJyb3IuaCINCj4gLSNpbmNsdWRlICJjaGFyZGV2L2NoYXIuaCINCj4gICAjaW5j
bHVkZSAiaHcvaXJxLmgiDQo+ICAgI2luY2x1ZGUgImh3L3BjaS9wY2lfZGV2aWNlLmgiDQo+
ICAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5oIg0KPiBkaWZmIC0tZ2l0IGEvaHcv
bmV0L2Nhbi9jYW5fcGNtMzY4MF9wY2kuYyBiL2h3L25ldC9jYW4vY2FuX3BjbTM2ODBfcGNp
LmMNCj4gaW5kZXggYWYyMWRjNjg1NS4uMzE5NWI3OTk1NCAxMDA2NDQNCj4gLS0tIGEvaHcv
bmV0L2Nhbi9jYW5fcGNtMzY4MF9wY2kuYw0KPiArKysgYi9ody9uZXQvY2FuL2Nhbl9wY20z
NjgwX3BjaS5jDQo+IEBAIC0yNiwxMiArMjYsOCBAQA0KPiAgICAqLw0KPiAgIA0KPiAgICNp
bmNsdWRlICJxZW11L29zZGVwLmgiDQo+IC0jaW5jbHVkZSAicWVtdS9ldmVudF9ub3RpZmll
ci5oIg0KPiAgICNpbmNsdWRlICJxZW11L21vZHVsZS5oIg0KPiAtI2luY2x1ZGUgInFlbXUv
dGhyZWFkLmgiDQo+IC0jaW5jbHVkZSAicWVtdS9zb2NrZXRzLmgiDQo+ICAgI2luY2x1ZGUg
InFhcGkvZXJyb3IuaCINCj4gLSNpbmNsdWRlICJjaGFyZGV2L2NoYXIuaCINCj4gICAjaW5j
bHVkZSAiaHcvaXJxLmgiDQo+ICAgI2luY2x1ZGUgImh3L3BjaS9wY2lfZGV2aWNlLmgiDQo+
ICAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5oIg0KPiBkaWZmIC0tZ2l0IGEvaHcv
bmV0L2Nhbi9jYW5fc2phMTAwMC5jIGIvaHcvbmV0L2Nhbi9jYW5fc2phMTAwMC5jDQo+IGlu
ZGV4IDY2OTRkN2JmZDguLjViNmJhOWRmNmMgMTAwNjQ0DQo+IC0tLSBhL2h3L25ldC9jYW4v
Y2FuX3NqYTEwMDAuYw0KPiArKysgYi9ody9uZXQvY2FuL2Nhbl9zamExMDAwLmMNCj4gQEAg
LTI3LDcgKzI3LDcgQEANCj4gICANCj4gICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiAg
ICNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiAtI2luY2x1ZGUgImNoYXJkZXYvY2hhci5oIg0K
PiArI2luY2x1ZGUgInFlbXUvYml0b3BzLmgiDQo+ICAgI2luY2x1ZGUgImh3L2lycS5oIg0K
PiAgICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPiAgICNpbmNsdWRlICJuZXQv
Y2FuX2VtdS5oIg0KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L2Nhbi9jdHVjYW5fY29yZS5jIGIv
aHcvbmV0L2Nhbi9jdHVjYW5fY29yZS5jDQo+IGluZGV4IDgxMmI4M2U5M2UuLjQ0MDJkNGNi
MWYgMTAwNjQ0DQo+IC0tLSBhL2h3L25ldC9jYW4vY3R1Y2FuX2NvcmUuYw0KPiArKysgYi9o
dy9uZXQvY2FuL2N0dWNhbl9jb3JlLmMNCj4gQEAgLTI4LDcgKzI4LDggQEANCj4gICANCj4g
ICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiAgICNpbmNsdWRlICJxZW11L2xvZy5oIg0K
PiAtI2luY2x1ZGUgImNoYXJkZXYvY2hhci5oIg0KPiArI2luY2x1ZGUgInFlbXUvYnN3YXAu
aCINCj4gKyNpbmNsdWRlICJxZW11L2JpdG9wcy5oIg0KPiAgICNpbmNsdWRlICJody9pcnEu
aCINCj4gICAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4gICAjaW5jbHVkZSAi
bmV0L2Nhbl9lbXUuaCINCj4gZGlmZiAtLWdpdCBhL2h3L25ldC9jYW4vY3R1Y2FuX3BjaS5j
IGIvaHcvbmV0L2Nhbi9jdHVjYW5fcGNpLmMNCj4gaW5kZXggNjVmMWY4MjMwMy4uYThjNzdi
OTE5NCAxMDA2NDQNCj4gLS0tIGEvaHcvbmV0L2Nhbi9jdHVjYW5fcGNpLmMNCj4gKysrIGIv
aHcvbmV0L2Nhbi9jdHVjYW5fcGNpLmMNCj4gQEAgLTI3LDEyICsyNyw4IEBADQo+ICAgICov
DQo+ICAgDQo+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gLSNpbmNsdWRlICJxZW11
L2V2ZW50X25vdGlmaWVyLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiDQo+IC0j
aW5jbHVkZSAicWVtdS90aHJlYWQuaCINCj4gLSNpbmNsdWRlICJxZW11L3NvY2tldHMuaCIN
Cj4gICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiAtI2luY2x1ZGUgImNoYXJkZXYvY2hh
ci5oIg0KPiAgICNpbmNsdWRlICJody9pcnEuaCINCj4gICAjaW5jbHVkZSAiaHcvcGNpL3Bj
aV9kZXZpY2UuaCINCj4gICAjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQoNClJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5v
cmc+DQoNCg==

