Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACEFD68B3F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBdPO-0006qF-FP; Thu, 14 Nov 2024 12:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBdPM-0006lj-1a
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:13:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBdPJ-0005bP-JK
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:13:27 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20cb47387ceso10585905ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731604403; x=1732209203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1S4kl0Wc7DondKyIIA0GBxvrpljQ86jixVzu7yYNSIk=;
 b=cOUqUFsxE4sb/XmY2UR+711cuN7JeBumXDHRfmGE7TyD3hlcJhkAOo7/HBYGoGfLKg
 8gFRj0KmEy7xN0wQlF1YlHkDWeNKjly4V46Sh9p/ck9fb5c6JLx5YizqX7cOe2ly3vSs
 1ojulBksv9vZ3xzSIKM+yhHqn+POtu2jaKguZh9Xuu5UjjNIIdBvNn2sJSE/6pPT3aq+
 nxH1DLj3r/NvKjmyvsQ/5VDWqnl1cukO7qcJdLPdphrmAlUnKfQc4yezNU5YfYBlbJhT
 IdBolrpNuGf2m+5w3RUg1gu9sZ6g+WdC4gudt/YulLlA9sS95xe3f9KoS31vMe26skXD
 SfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731604403; x=1732209203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1S4kl0Wc7DondKyIIA0GBxvrpljQ86jixVzu7yYNSIk=;
 b=Kc5b6xjBath3SYXYvBV8eZSOcESKT8pWqncvrV5LTQA6o48dE7Wh4LFAEN+VMV39XU
 k81xUJOgVymoMXh4snhnw5SavpEH+SvKSmkJ2oYhkAwYzZ2VpXd7vW7ACAmgQ7CMnjIJ
 tCavdXdFhQu7dpZ0srdqFvJ9cMqJWugVzStZGefEmlznckk/9SOy0EV9NHUf0hzhqTBO
 GeDQ120poWrdNic9RS6XJt0jmRd+A5oFueaAgbeCEOhM0wbVPJM2xwFU8O91NWgqIpzR
 qw9D2EEhvfmAkPXzTnomnjM2VeCtHni3V/ERD7FzWULedpthAGqXFrC4Zyz6nDLlvYSo
 pJ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPshhvjyF2mXnDEQJvsCN6BavQ5PSfv55EoJ3py/Eq9azupDjRnYc1aSPqD6SyqLSQIolwBOuif7h6@nongnu.org
X-Gm-Message-State: AOJu0Yy/VwF/4ZrB2luUvPrZd23Q4iH87QzEZJN/1qBCYZpZHinB0MCs
 KtaDoDr3z2GrqRwU5WyWtoZbZPWwQKnjEZHUL2dzceFTAf1LlDBbDqA3YtgYzIA=
X-Google-Smtp-Source: AGHT+IHFEx+3uNH+loQ5sdWRXNzX/DUBg7iLKPz2X2MyhTvyYrflvy+P05asaSgwQyFwFNDhunF4yA==
X-Received: by 2002:a17:903:4306:b0:20c:f0dd:c408 with SMTP id
 d9443c01a7336-21183521d2bmr211430885ad.20.1731604403141; 
 Thu, 14 Nov 2024 09:13:23 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d37fb7sm13045565ad.262.2024.11.14.09.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:13:22 -0800 (PST)
Message-ID: <a5d8253f-b25f-4c1c-bccf-3a6185f21dc2@linaro.org>
Date: Thu, 14 Nov 2024 09:13:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] exec/translation-block: Include missing
 'exec/vaddr.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-4-philmd@linaro.org>
 <8406e329-5b09-4960-b5b7-baca62d3747c@linaro.org>
 <50fac36d-86af-48ce-890a-033887da05e1@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <50fac36d-86af-48ce-890a-033887da05e1@linaro.org>
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

T24gMTEvMTQvMjQgMDc6MjMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
biAxNC8xMS8yNCAwNDoxMCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IE9uIDExLzEz
LzI0IDE3OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiAndmFkZHIn
IGlzIGRlY2xhcmVkIGluICJleGVjL3ZhZGRyLmgiLg0KPj4+IEluY2x1ZGUgaXQgaW4gb3Jk
ZXIgdG8gYXZvaWQgd2hlbiByZWZhY3RvcmluZzoNCj4+Pg0KPj4+ICDCoMKgIGluY2x1ZGUv
ZXhlYy90cmFuc2xhdGlvbi1ibG9jay5oOjU2OjU6IGVycm9yOiB1bmtub3duIHR5cGUgbmFt
ZQ0KPj4+ICd2YWRkcicNCj4+PiAgwqDCoMKgwqDCoCA1NiB8wqDCoMKgwqAgdmFkZHIgcGM7
DQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgIF4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4+
PiAtLS0NCj4+PiAgwqAgaW5jbHVkZS9leGVjL3RyYW5zbGF0aW9uLWJsb2NrLmggfCAxICsN
Cj4+PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9leGVjL3RyYW5zbGF0aW9uLWJsb2NrLmgNCj4+PiBiL2luY2x1
ZGUvZXhlYy90cmFuc2xhdGlvbi1ibG9jay5oDQo+Pj4gaW5kZXggYTZkMWFmNmU5Yi4uYjk5
YWZiMDA3NyAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2V4ZWMvdHJhbnNsYXRpb24tYmxv
Y2suaA0KPj4+ICsrKyBiL2luY2x1ZGUvZXhlYy90cmFuc2xhdGlvbi1ibG9jay5oDQo+Pj4g
QEAgLTksNiArOSw3IEBADQo+Pj4gIMKgICNpbmNsdWRlICJxZW11L3RocmVhZC5oIg0KPj4+
ICDCoCAjaW5jbHVkZSAiZXhlYy9jcHUtY29tbW9uLmgiDQo+Pj4gKyNpbmNsdWRlICJleGVj
L3ZhZGRyLmgiDQo+Pj4gIMKgICNpZmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+Pj4gIMKgICNp
bmNsdWRlICJxZW11L2ludGVydmFsLXRyZWUuaCINCj4+PiAgwqAgI2VuZGlmDQo+Pg0KPj4g
SSdtIGEgYml0IGNvbmZ1c2VkIGJ5IGNvbW1pdCBtZXNzYWdlLCBidXQgaXQgc2VlbXMgdGhh
dCB0aGlzIHNlcmllcyBoYXMNCj4+IHNvbWUgY29tbWl0cyB0aGF0IHdpbGwgbm90IGNvbXBp
bGUuIElzIHRoYXQgc29tZXRoaW5nIGFjY2VwdGFibGU/DQo+IA0KPiBCZWNhdXNlIGNvbW1p
dHMgbXVzdCBiZSBiaXNlY3QtYWJsZSwgdGhhdCBpcyBub3QgYWNjZXB0YWJsZS4NCj4gDQo+
IEkgdG9vayBhIGxvdCBvZiBjYXJlIHRvIG1ha2UgdGhpcyBzZXJpZXMgYnVpbGFibGUgb24g
ZWFjaCBzdGVwLA0KPiBidXQgbWlnaHQgaGF2ZSBtaXNzZWQgc29tZXRoaW5nLiBDYW4geW91
IHBvaW50IG1lIGF0IHRoZQ0KPiBjb25maWd1cmF0aW9uIHVzZWQgYW5kIGJyb2tlbiBwYXRj
aD8NCj4gDQo+IEknbGwgcmV3b3JkIHRoZSBjb21taXQgZGVzY3JpcHRpb24gYXM6DQo+IA0K
PiAtLS0NCj4gJ3ZhZGRyJyB0eXBlIGlzIGRlY2xhcmVkIGluICJleGVjL3ZhZGRyLmgiLg0K
PiAiZXhlYy90cmFuc2xhdGlvbi1ibG9jay5oIiB1c2VzIHRoaXMgdHlwZSB3aXRob3V0IGlu
Y2x1ZGluZw0KPiB0aGUgY29ycmVzcG9uZGluZyBoZWFkZXIuIEl0IHdvcmtzIGJlY2F1c2Ug
dGhpcyBoZWFkZXIgaXMNCj4gaW5kaXJlY3RseSBpbmNsdWRlZCwgYnV0IHdvbid0IHdvcmsg
d2hlbiB0aGUgb3RoZXIgaGVhZGVycw0KPiBhcmUgcmVmYWN0b3JlZDoNCj4gDQo+ICAgICBb
ZXJyb3JdDQo+IA0KPiBFeHBsaXRseSBpbmNsdWRlICJleGVjL3ZhZGRyLmgiIHRvIGF2b2lk
IHN1Y2ggcHJvYmxlbSBpbiBhDQo+IGZldyBjb21taXRzLg0KPiAtLS0NCj4gDQo+IERvZXMg
aXQgY2xhcmlmeT8NCj4gDQoNClllcyBpdCdzIG1vcmUgY2xlYXIgbGlrZSB0aGF0LiBUaGUg
Y29tbWl0IG1lc3NhZ2Ugc2VlbWVkIHRvIGltcGx5IHRoYXQgDQp5b3Ugd2VyZSBmaXhpbmcg
YnVpbGQgb25lIHN0ZXAgYXQgYSB0aW1lLg0KDQo+PiBJZiBpdCdzIG9rLA0KPj4gUmV2aWV3
ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4N
Cj4+DQo+IA0KDQpUaGFua3MsDQpQaWVycmljaw0K

