Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727CDC35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 18:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt9uO-00031n-K5; Fri, 14 Mar 2025 14:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt9u3-0002wz-FK
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:37:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt9tx-00088x-JS
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:37:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-225a28a511eso43911245ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741977416; x=1742582216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2dszydW0ry8gherDQSJEAvtBXObpAYjVrurGpm1pFvE=;
 b=InyWsCGbTPUaZ+FMvg15csA6erATvNlgXsFo+guJ/s9xh3qzg1HSXLUP7dFPz1VXm1
 buylm0yrozidASmvEIPxlifYsEfXwMfUCKUEapOaRznGHNCh1lf8SIMTEip6T+3LVcw/
 F9hYeP9cr0sEWb4nkZx6sVKn/gA/lNbG6yMWadJFebmf0v9snXCs3fIWqSzLGsXKJAvu
 ph3TY6Sd7lwdBIv73jsQjLrWJmnH1BSPPdepvk1NwUHeLy+j43sedTtlQewBJNdBfB6c
 MFBUDrWG8gJR6SA1k7Uo2b7EsKAyRQ6REZAUeEMYxIOqnMsjmAzCQExAgJ55yDzk3Y/9
 J9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741977416; x=1742582216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2dszydW0ry8gherDQSJEAvtBXObpAYjVrurGpm1pFvE=;
 b=BK39YfyQ7IHIZekH896On0h2qWMv+/QHLVAnf6oVirH+LjOkJBuozh1pWhiPHsvRXn
 2l0AJHoOL/EhnJwJaQbTUvE8JMkct8mKVdjM2YsbHUz5dU+WRwjCXxtXlpxpr9s4lZtP
 IUUeWAmbPjlSVFgAihug9XeIJBAHm2IzyL3c77n3D/dweMrfeTFUVYbkd9IhaAMzT8kT
 Ibc28Vvomiw1pvr/rZIkKwFuDzuK+zhae4RabgyYjeRW1qz4WD7KoR8Kdd3kJmmBfKkU
 QyrBzQh308TU+Ou3xd253DDihxH2ObVR05VmgANvq6LaSJduRnBfbihqGLXeNfjekDuD
 pd8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9gHD260J4+kPdqjztWfMwzS5EN7Py5NR7zMQXl5DK/1EXbsJJXkZ158j+u8xNajY+UKXOOIxMANQj@nongnu.org
X-Gm-Message-State: AOJu0YxlfM91saH2nPkdeT7NGmuT0dce8+Zddpgnn+q4A8pvWSZlTpux
 oFUSqRAzeA8jkMnMVmBjm0AWih8270Tz/Ie4yYed1JFHb6V3fNxUOjxM9WII1ag=
X-Gm-Gg: ASbGnctDTeXF6LGFz60aS11B43um7AsNTr3SSUCpgk5lr9lQytW+rcohyYgvdtV1hg7
 f3H9yQMWKq8Y8/zfXRPgqbAhQYxZUS+LjuXocz8lPab97e2ITTxetmS/W6lVOLyLRLnwxZFiD96
 Ffv/6jtD/+UBqtlHbXNnVmOcrpOTHGwiCMhsUX3kv2mBf4wpgszpIS8I4mCH6soPTP9mfh3J9+B
 ggG9KdzKbxwFYg2O9gP9/UTLu17Bw3QfzaAoRmKhFf9g4J6qraIjk2k1APVuY5dcL7ac54gFAHe
 Sz3I4tf2zodwpyaoKiTYdtLI+f4nnQLuLg7XlUZPmevdPcD0LdH5GLkN9XCKZRCobEFI
X-Google-Smtp-Source: AGHT+IG+MNcx02igZCtDdqnMxKY6C6sZtidzuHraDmvioHI+P6PclezoKZBlVUoISU3zwskEC7a1uQ==
X-Received: by 2002:a05:6a20:ad0c:b0:1f5:9098:e42e with SMTP id
 adf61e73a8af0-1f5c1126c30mr6118696637.7.1741977415936; 
 Fri, 14 Mar 2025 11:36:55 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea93e1dsm3064964a12.69.2025.03.14.11.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 11:36:55 -0700 (PDT)
Message-ID: <42b1f9f3-2ed4-461b-9460-0318011097ee@linaro.org>
Date: Fri, 14 Mar 2025 11:36:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/37] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-33-richard.henderson@linaro.org>
 <7f665a47-2bba-4c3a-980c-a252ec44723c@linaro.org>
 <807dbc0d-db15-4bd3-95f3-b3e87951bd7f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <807dbc0d-db15-4bd3-95f3-b3e87951bd7f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMy8xNC8yNSAxMToxMywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTMv
MjUgMTQ6MDAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvaW50Yy9hcm12N21fbnZpYy5oIGIvaW5jbHVkZS9ody9pbnRjL2FybXY3bV9u
dmljLmgNCj4+PiBpbmRleCA4OWZlOGFlZGFhLi43Yjk5NjRmZTdlIDEwMDY0NA0KPj4+IC0t
LSBhL2luY2x1ZGUvaHcvaW50Yy9hcm12N21fbnZpYy5oDQo+Pj4gKysrIGIvaW5jbHVkZS9o
dy9pbnRjL2FybXY3bV9udmljLmgNCj4+PiBAQCAtMTg5LDIxICsxODksNyBAQCBpbnQgYXJt
djdtX252aWNfcmF3X2V4ZWN1dGlvbl9wcmlvcml0eShOVklDU3RhdGUgKnMpOw0KPj4+ICDC
oMKgICogQHNlY3VyZTogdGhlIHNlY3VyaXR5IHN0YXRlIHRvIHRlc3QNCj4+PiAgwqDCoCAq
IFRoaXMgY29ycmVzcG9uZHMgdG8gdGhlIHBzZXVkb2NvZGUgSXNSZXFFeGVjUHJpTmVnKCku
DQo+Pj4gIMKgwqAgKi8NCj4+PiAtI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+Pj4gIMKg
IGJvb2wgYXJtdjdtX252aWNfbmVnX3ByaW9fcmVxdWVzdGVkKE5WSUNTdGF0ZSAqcywgYm9v
bCBzZWN1cmUpOw0KPj4+IC0jZWxzZQ0KPj4+IC1zdGF0aWMgaW5saW5lIGJvb2wgYXJtdjdt
X252aWNfbmVnX3ByaW9fcmVxdWVzdGVkKE5WSUNTdGF0ZSAqcywgYm9vbCBzZWN1cmUpDQo+
Pj4gLXsNCj4+PiAtwqDCoMKgIHJldHVybiBmYWxzZTsNCj4+PiAtfQ0KPj4+IC0jZW5kaWYN
Cj4+PiAtI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+Pj4gIMKgIGJvb2wgYXJtdjdtX252
aWNfY2FuX3Rha2VfcGVuZGluZ19leGNlcHRpb24oTlZJQ1N0YXRlICpzKTsNCj4+PiAtI2Vs
c2UNCj4+PiAtc3RhdGljIGlubGluZSBib29sIGFybXY3bV9udmljX2Nhbl90YWtlX3BlbmRp
bmdfZXhjZXB0aW9uKE5WSUNTdGF0ZSAqcykNCj4+PiAtew0KPj4+IC3CoMKgwqAgcmV0dXJu
IHRydWU7DQo+Pj4gLX0NCj4+PiAtI2VuZGlmDQo+Pj4gIMKgICNlbmRpZg0KPj4NCj4+IEkn
bSBhIGJpdCB3b3JyaWVkIHdlIG1pZ2h0IGhhdmUgcmVncmVzc2lvbiB3aGVuIGRvaW5nIHRo
aW5ncyB0aGlzIHdheS4NCj4gDQo+IEkgZXhwZWN0IGxpbmsgZXJyb3JzIHRvIGRpYWdub3Nl
IGVycm9ycy4NCj4NCg0KSW4gdGhpcyBjYXNlLCB5ZXMuDQoNCk1vcmUgZ2VuZXJhbGx5LCBm
b3Igc3lzdGVtIHZzIHVzZXIsIGl0IG1pZ2h0IGJlIHN1ZmZpY2llbnQgKGV2ZW4gdGhvdWdo
IA0KSSB3b3VsZCBwcmVmZXIgdG8gYmUgYmxpbmRseSBwcnVkZW50IG9uIHRoaXMpLCBidXQg
aXQgbWlnaHQgbm90IHByb3RlY3QgDQphbGwgY2FzZXMsIHdpdGggc3VidGxlIGNvbmZpZ3Mg
b3IgZmVhdHVyZXMgZW5hYmxlZC9kaXNhYmxlZC4NCg0KV2l0aCBhIHJ1bnRpbWUgY2hlY2ss
IHdlIGNvdWxkIGlkZW50aWZ5IHRoZSBtaXNzaW5nIGNhbGxzIA0KImZlYXR1cmVfZW5hYmxl
ZCgpIi4gSW4gdGhpcyBjYXNlLCB3ZSB3b3VsZCBsaW5rLCBidXQgY291bGQgZW5kIHVwIA0K
Y2FsbF9mZWF0dXJlIGluIHNvbWUgY2FzZXMsIHdoZW4gaXQgc2hvdWxkIGJlIGhpZGRlbiBi
ZWhpbmQgYSANCiJfZW5hYmxlZCgpIiBjaGVjay4NCg0KaWYgKGZlYXR1cmVfZW5hYmxlZCgp
KSB7DQogICBjYWxsX2ZlYXR1cmUoKTsNCn0NCg0KU3R1YnMgYXJlIHJlYWxseSBhIGRlcGVu
ZGVuY3kgaGFjayB0byBwYWxsaWF0ZSBhcmNoaXRlY3R1cmUgcHJvYmxlbXMuDQoNCj4gDQo+
IHJ+DQoNCg==

