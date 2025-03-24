Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E5AC36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnPw-0005uo-At; Mon, 24 Mar 2025 15:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnPk-0005lf-GD
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:24:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnPc-0004mK-Dq
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:24:48 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22401f4d35aso99832975ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742844276; x=1743449076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6020aAwZb8kumMqjWBZgP/W9xGt5ZslaNiVoWIO95Uc=;
 b=hbIanqCa2qYW6cBSSQHf+xs9UvbcTu5kmq1N2DobaM8BIs5FSUOlJPagR68Tf4kTk9
 MfKb5jtg1tpU+qU4Xa6fv1J2CTD2YtqNj/FkZerRfnvvwNwJ4rZ+JzWh1yWvi8YG3YZ1
 KIyTdPmYSCkv8NW5y41jmQec93hEh3/0IZuIwdC2j71/UqWT2ECzIp4R36EVoiH3/993
 BxkluJsTqvTQF6wb8eDltdM3mT1ibCBBOTsI5C7uCweuFh2Qg5pK9RXe4tqbJ+FBHBNu
 W0rarBqb9UkfaZfxmEt1vXxkShxr6xuN29cfa8s/7oEq3ml+/lWbkyW6EAu3b+11xd0V
 ilzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844276; x=1743449076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6020aAwZb8kumMqjWBZgP/W9xGt5ZslaNiVoWIO95Uc=;
 b=uu4pR9q0MGMcDvji+56Yy59duOcbmWeDcsuXbZOGu1CAEi5k42oXdraG8PW1YacqH2
 rTQmx5LtR8b81dKWN+/VQRkGaStpSLYkHxeSwwpfmRHhskNQNrMAJVs2GXpcu+ZjLfRi
 VkFDquDz3Xsavb93R7YpuW+QppRg8qghkD/uZmxO5yLDKbNCv1UCub6IiCygieQazMif
 jFs4rG8eNxNhyxjSbS27Sq4HWH4QJHsazl2tkXI57ASNldMnvMidtEbs4aEWxmK09vIf
 J9eYlzi4Zjp+pgKpH33RwyIKh6SSnuNkIAiAWw20U6pUO4JsLptZqPzz59i/lHZ4P0pp
 zKpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/kjAiyG5sx8nQ48U9pc/S85DNeWT0rCW2GvM6DASvHpPHHgtNsfZdZTCbJHLf5q1ZmhsFjBApIdtt@nongnu.org
X-Gm-Message-State: AOJu0YxbPJZXqACEyyrUTKidbrST/aFzg5n/gqqjwaQjXfhYEGuMGRgo
 yEYd3RoTDuYGnbAmyeO4mp1CK0GVsOWUE0OsOptI+yfSDPPW1dE3lsNB7iAR/VQ=
X-Gm-Gg: ASbGncssogBqZRNkaYpQW+LL6yB4feADssJdrFDNnq2YWMF6qpUa4JScGCealPYyVL8
 23UHJHPK3t41zgDuOQiuok3CC7nWMC5vIFeGPSMuOMH669KMsWeK6j7zUgvOuK/5uf0DqTYVrD9
 OwE1Qrh2QUP3W8Srb/O5xfxrtrk5U/atsEtQBDCvEjUDdZDHIu+S7KLpYRBCCPJTObCgD8nnSVm
 ud+a1jw5+qB/aSsTFCXuLP3V4yYIAdp/sohekoNAVZXMa5m6tIhI9WvmUpHltzFqMWZDEJMDK4q
 T9gjUdzj3AqZwR36/vaZaHVU8aPpiwrLs/5LMaS2vztidmi5+iC6I6kuyQ==
X-Google-Smtp-Source: AGHT+IE4qPUz5gYwwYIL6B6Lv2/yJz+NzSDmJ+f19kpUBF8nlsTwMnhrWAmxrZP2n2Fs7zBr32sFFQ==
X-Received: by 2002:a17:903:320e:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-22780e3f352mr215034985ad.53.1742844275928; 
 Mon, 24 Mar 2025 12:24:35 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f39772sm74794155ad.25.2025.03.24.12.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:24:35 -0700 (PDT)
Message-ID: <f138ea6d-342e-4d8b-9e50-8aa112981744@linaro.org>
Date: Mon, 24 Mar 2025 12:24:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] target/ppc: make ppc_maybe_bswap_register static
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
 <20250324102142.67022-9-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-9-alex.bennee@linaro.org>
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBJdCdzIG5vdCB1c2Vk
IG91dHNpZGUgb2YgdGhlIGdkYnN0dWIgY29kZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+IFJldmlld2Vk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFNp
Z25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4g
LS0tDQo+ICAgdGFyZ2V0L3BwYy9jcHUuaCAgICAgfCAxIC0NCj4gICB0YXJnZXQvcHBjL2dk
YnN0dWIuYyB8IDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9wcGMvY3B1LmggYi90
YXJnZXQvcHBjL2NwdS5oDQo+IGluZGV4IDFlODMzYWRlMDQuLjk1MGJiNmUwNmMgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9wcGMvY3B1LmgNCj4gKysrIGIvdGFyZ2V0L3BwYy9jcHUuaA0K
PiBAQCAtMzAxNiw3ICszMDE2LDYgQEAgc3RhdGljIGlubGluZSBib29sIHBwY19pbnRlcnJ1
cHRzX2xpdHRsZV9lbmRpYW4oUG93ZXJQQ0NQVSAqY3B1LCBib29sIGh2KQ0KPiAgIA0KPiAg
IHZvaWQgZHVtcF9tbXUoQ1BVUFBDU3RhdGUgKmVudik7DQo+ICAgDQo+IC12b2lkIHBwY19t
YXliZV9ic3dhcF9yZWdpc3RlcihDUFVQUENTdGF0ZSAqZW52LCB1aW50OF90ICptZW1fYnVm
LCBpbnQgbGVuKTsNCj4gICB2b2lkIHBwY19zdG9yZV92c2NyKENQVVBQQ1N0YXRlICplbnYs
IHVpbnQzMl90IHZzY3IpOw0KPiAgIHVpbnQzMl90IHBwY19nZXRfdnNjcihDUFVQUENTdGF0
ZSAqZW52KTsNCj4gICB2b2lkIHBwY19zZXRfY3IoQ1BVUFBDU3RhdGUgKmVudiwgdWludDY0
X3QgY3IpOw0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3BwYy9nZGJzdHViLmMgYi90YXJnZXQv
cHBjL2dkYnN0dWIuYw0KPiBpbmRleCAzYjI4ZDRlMjFjLi5jMDllOTNhYmFmIDEwMDY0NA0K
PiAtLS0gYS90YXJnZXQvcHBjL2dkYnN0dWIuYw0KPiArKysgYi90YXJnZXQvcHBjL2dkYnN0
dWIuYw0KPiBAQCAtODEsNyArODEsNyBAQCBzdGF0aWMgaW50IHBwY19nZGJfcmVnaXN0ZXJf
bGVuKGludCBuKQ0KPiAgICAqIFRBUkdFVF9CSUdfRU5ESUFOIGlzIGFsd2F5cyBzZXQsIGFu
ZCB3ZSBtdXN0IGNoZWNrIHRoZSBjdXJyZW50DQo+ICAgICogbW9kZSBvZiB0aGUgY2hpcCB0
byBzZWUgaWYgd2UncmUgcnVubmluZyBpbiBsaXR0bGUtZW5kaWFuLg0KPiAgICAqLw0KPiAt
dm9pZCBwcGNfbWF5YmVfYnN3YXBfcmVnaXN0ZXIoQ1BVUFBDU3RhdGUgKmVudiwgdWludDhf
dCAqbWVtX2J1ZiwgaW50IGxlbikNCj4gK3N0YXRpYyB2b2lkIHBwY19tYXliZV9ic3dhcF9y
ZWdpc3RlcihDUFVQUENTdGF0ZSAqZW52LCB1aW50OF90ICptZW1fYnVmLCBpbnQgbGVuKQ0K
PiAgIHsNCj4gICAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gICAgICAgaWYgKCFGSUVM
RF9FWDY0KGVudi0+bXNyLCBNU1IsIExFKSkgew0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

