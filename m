Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A84C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnDQ-0007AG-BH; Mon, 24 Mar 2025 15:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnCs-0006vh-HO
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:11:39 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnCl-0003Df-Jq
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:11:29 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so6034604a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742843482; x=1743448282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZF7cFjujuaPFgbJpTgzr5t/+46fAwSRjELo50X3QZuo=;
 b=HdQaBfDx1c3SPH51SnTKd/3M2dDMdrHltucsMfnA9s6FJFhv5ur4IXmiPNhWEOqNJo
 y53qJvaT9EJR4jKqOI9I3VhawszGTGKJZWzioYxN4koCNh7s2H/x5OlhLDP3JZPRKdkx
 akuTeKmZDvkKxIAKOJUfTRpCBlVO4jcT7NoDYAeEj4DLYC7SlYH9h1BhTOeD1o2/XG1u
 rFNYmWZzjCrKolMAngJVd1Dszo7tC2hMcQaLlYmsuaXaqboF+oRcJh0PQidkjvAAIiFS
 +bBXx8UOO1sEMsjMHMwNVJVZMZPEnbot4oRYKfZOTvsa0Nqc0saaIPdf+jOGWjq0t4WS
 Wi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742843482; x=1743448282;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZF7cFjujuaPFgbJpTgzr5t/+46fAwSRjELo50X3QZuo=;
 b=CNLba7A8ttitQKE/VZ9DzFJ+4FRY9Khb3n7azGvKpnJLZqZaQlpvkq5P6ngv+tVuWC
 UzrFnjgY96VfhquzdLqnDjy/01g5tGUr7Ax0bmnqLez+7tJGM0jBhjhEpPCFIknKGo+p
 A7HRDcAyK++WGfhvJBP0MEtHIIvzbvUE1i2iXZhU6J85i1Uj5B6cX2MpPURUgI4HMF7k
 manvbAGCmYnX0T8Yc9fwgvgx+bY3W6P18/0G4yyL8nw/3h7e7RZ6ZZLvoIe/OPt8oQ6w
 cB0mrdW6M0JENX5SmV6Npti8kj4r0vkn5eC6An73QdtXwwE37LLMJJqap6QVCkXVPNVb
 HTWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsRiDj4yFKett0erFctqksWi8tw+Xxyshi38/mDqeEqnOatcW+LA9odpgSkC3vcIJ1iaSVWpHeAm3J@nongnu.org
X-Gm-Message-State: AOJu0YwXtMD7+ex0NWQv4x/0S4MnVyHMNanDIH8ZLF0jWyXkMctvEgQ0
 Pkqu+aXZA+AOEkauFH+w2nvRdqFp+EfwAS9JVuzj9pLTY2AnFzFHOPkw6kVgRI8=
X-Gm-Gg: ASbGncv0uDnjl74ulhg05iIUbgeLMlnAJW3LsmW7IOowHMMlgbJPK6Q3bADpr31P/7J
 3AkLvaDZCcV399zpUB6o87T+Ntl+9ZZXv5JTrSr2Vr7kmSXsAFUp6j6LtmqpSeyifueycJ/fr1J
 vll8HZ9fC0R8C9WQDFlAOK9ZK2tEvv7HsM6MqvJ+4mJz+hsPhPNICtm1KAwI/dmCmAzYRCwTrP4
 RshjAR54q23a4pSPjhy6Lbq8OlDTvgEfUuXRjlf/qcCkePiAoV63+jnf0MpreEHOEx4xVfprRu5
 6tK8APkBdgknripuoN7+2oLojjpRb/+T/ul7lVkzqORB6sm1T3cd56YyGw==
X-Google-Smtp-Source: AGHT+IHo/bFh1epFIxjsdzZJ4OtwVqGaV8c13D1qM/aJgfZk1lts3p3dEmFiHF5pDmaKUgVdwU+bTg==
X-Received: by 2002:a17:90b:3d8b:b0:2fa:13d9:39c with SMTP id
 98e67ed59e1d1-3030fe813afmr26433744a91.14.1742843481996; 
 Mon, 24 Mar 2025 12:11:21 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf61a68dsm12655450a91.39.2025.03.24.12.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:11:21 -0700 (PDT)
Message-ID: <778db1f3-58b7-4f4d-9ae5-661c4a67574d@linaro.org>
Date: Mon, 24 Mar 2025 12:11:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] gdbstub: assert earlier in handle_read_all_regs
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
 <20250324102142.67022-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBXaGVuIHRoaW5ncyBn
byB3cm9uZyB3ZSB3YW50IHRvIGFzc2VydCBvbiB0aGUgcmVnaXN0ZXIgdGhhdCBmYWlsZWQg
dG8NCj4gYmUgYWJsZSB0byBmaWd1cmUgb3V0IHdoYXQgd2VudCB3cm9uZy4NCj4gDQo+IFJl
dmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgZ2Ric3R1Yi9nZGJzdHViLmMgfCAyICstDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZ2Ric3R1Yi9nZGJzdHViLmMgYi9nZGJzdHViL2dkYnN0dWIuYw0KPiBpbmRleCAyODJl
MTNlMTYzLi5iNmQ1ZTExZTAzIDEwMDY0NA0KPiAtLS0gYS9nZGJzdHViL2dkYnN0dWIuYw0K
PiArKysgYi9nZGJzdHViL2dkYnN0dWIuYw0KPiBAQCAtMTMyOCw4ICsxMzI4LDggQEAgc3Rh
dGljIHZvaWQgaGFuZGxlX3JlYWRfYWxsX3JlZ3MoR0FycmF5ICpwYXJhbXMsIHZvaWQgKnVz
ZXJfY3R4KQ0KPiAgICAgICAgICAgbGVuICs9IGdkYl9yZWFkX3JlZ2lzdGVyKGdkYnNlcnZl
cl9zdGF0ZS5nX2NwdSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
ZGJzZXJ2ZXJfc3RhdGUubWVtX2J1ZiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZWdfaWQpOw0KPiArICAgICAgICBnX2Fzc2VydChsZW4gPT0gZ2Ric2VydmVy
X3N0YXRlLm1lbV9idWYtPmxlbik7DQo+ICAgICAgIH0NCj4gLSAgICBnX2Fzc2VydChsZW4g
PT0gZ2Ric2VydmVyX3N0YXRlLm1lbV9idWYtPmxlbik7DQo+ICAgDQo+ICAgICAgIGdkYl9t
ZW10b2hleChnZGJzZXJ2ZXJfc3RhdGUuc3RyX2J1ZiwgZ2Ric2VydmVyX3N0YXRlLm1lbV9i
dWYtPmRhdGEsIGxlbik7DQo+ICAgICAgIGdkYl9wdXRfc3RyYnVmKCk7DQoNClJldmlld2Vk
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoN
Cg==

