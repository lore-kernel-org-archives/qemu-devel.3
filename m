Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C516C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnPL-0005Xt-Kz; Mon, 24 Mar 2025 15:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnPI-0005W9-9m
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:24:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnPG-0004iy-Bt
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:24:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22398e09e39so97279295ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742844257; x=1743449057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EwhYSCmxzwkZb62e1aTLdPHYo8Ds6ne6ZazzzgXRd7Q=;
 b=GsfE1F/hcP8MIicJCiO5GAVmGsvAlGcn+/tERtiWu5DZsnXEvpDRgI2xjoa6DpsNzE
 3Xg7Sbd5UAlQpqDSxE+ofakJxMaSe4i7OiTBn+zROku3v/jchbhsWbnQc9f0iUMPalLA
 tdD5YbjxPa5ZqVZ1eL7GULKEyiF4BZ0gnpO8PXvhDDQ39qKziczIhdP5RYK6fHMXJ92Z
 upmWXTismwgUDm/GkXXXDnJ3ktjmProd/JMghEpVK/y0Tto5qcfC9hjsbzfEx1QfXx2A
 E5wJ/opwiFcbpuk8hRvm6k50xsqoVhsyDmoEkxyxvQQwLXO1Kntt6Bc8hE5lgpMi5y5w
 Flcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844257; x=1743449057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EwhYSCmxzwkZb62e1aTLdPHYo8Ds6ne6ZazzzgXRd7Q=;
 b=Fpbfkz2k4XmZwpqJGuANplgujfqUOZWWMKldVYa6OGxCPquDLqwddVVOwcFLljish9
 Tbx8orUNT3LT9gzKDLaQAbrNlYMfOFov968hvNO8+U/W5lrWvWU/njjVg6+igoNZovbV
 XDG8WoxtoL4grrkLY2pAbl6BC+68OtlLbShrUcdSwvJbJYEmTFHs+ObYTf+z70Lc9WqG
 tWKsup77JBglyrSgwhb8bIL5tEQdJEEtFNn1Y3vhfs/5EgQUrFGJLk3kOmk+cL0b3hWb
 GGNAGk7ZVXyMfbbWzzeaXOLJ/3CCLlReK8UShyCc1K5wB1dnZunNV17oWbaeWz9934Vb
 xqxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl/IuyydGLdsdru6vR3xOy1KBNCKqlYtFWi2Hw+iNlVaTaEKTmToKJDM8+/8vs5ZRNxw07DGnuJC/s@nongnu.org
X-Gm-Message-State: AOJu0YyrzhjTbrbS6bJzdY2VAWbeDPxMUtohHTiBistwtYTxxafSZu7A
 kHlAlEJC8jFJtiGYIS4IKw8nBMgowg0P1KEcSUMiG5ExEQgzsINpLyhpNcAfLPk=
X-Gm-Gg: ASbGnctW5uiAmtYwDlgiLjH6qQOGfXpEfXvSbit3xlag71PtWYM580e7kODr80n601A
 AGLEMuiXTHwkN88FPolALOrK1iVR/CCzxJWP7zr85ov0s/dyCHdndYDZouphBQBWigsAqYwIoBL
 aindEKatwOYR7NU9fG/EU5KE3otDtgAaCuynQsa0NYd9kFCeylcggl910VBC5qJEMc++IjuvbUW
 ph8PdmdFhWwyJz3UWSsAlmAyfhFkJdCMlH+P1YWdGm5CWnBEXQTwLZyVqs3xa0P3BfA3B33TORA
 N05tbPMCrG7itqT8N4pA7huWV1O7GWdA1+AP4hLr5T+c5lMQ9BUVQ+tiMw==
X-Google-Smtp-Source: AGHT+IHyTyBan8NZNA14WNQohEUVRTjEyDJWTb1J+7RFKPhNpOynuqByDr5qY1jmtK1ovlPYsPpCqg==
X-Received: by 2002:a17:902:da8c:b0:21f:988d:5758 with SMTP id
 d9443c01a7336-22780e0ae4amr209382725ad.35.1742844256673; 
 Mon, 24 Mar 2025 12:24:16 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b289fsm74963235ad.158.2025.03.24.12.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:24:16 -0700 (PDT)
Message-ID: <a504eab5-97a4-4e1e-986f-ff96cd46362e@linaro.org>
Date: Mon, 24 Mar 2025 12:24:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] target/ppc: expand comment on FP/VMX/VSX access
 functions
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
 <20250324102142.67022-8-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-8-alex.bennee@linaro.org>
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBNYWlubHkgYXMgYW4g
YWlkIHRvIG15c2VsZiBnZXR0aW5nIGNvbmZ1c2VkIHRvbyBtYW55IGJzd2FwcyBkZWVwIGlu
dG8NCj4gdGhlIGNvZGUuDQo+IA0KPiBSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJl
bm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIHRhcmdldC9wcGMv
Y3B1LmggfCA3ICsrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3BwYy9jcHUuaCBi
L3RhcmdldC9wcGMvY3B1LmgNCj4gaW5kZXggZWZhYjU0YTA2OC4uMWU4MzNhZGUwNCAxMDA2
NDQNCj4gLS0tIGEvdGFyZ2V0L3BwYy9jcHUuaA0KPiArKysgYi90YXJnZXQvcHBjL2NwdS5o
DQo+IEBAIC0yOTA2LDcgKzI5MDYsMTIgQEAgc3RhdGljIGlubGluZSBib29sIGxzd19yZWdf
aW5fcmFuZ2UoaW50IHN0YXJ0LCBpbnQgbnJlZ3MsIGludCByeCkNCj4gICAgICAgICAgICAg
IChzdGFydCArIG5yZWdzID4gMzIgJiYgKHJ4ID49IHN0YXJ0IHx8IHJ4IDwgc3RhcnQgKyBu
cmVncyAtIDMyKSk7DQo+ICAgfQ0KPiAgIA0KPiAtLyogQWNjZXNzb3JzIGZvciBGUCwgVk1Y
IGFuZCBWU1ggcmVnaXN0ZXJzICovDQo+ICsvKg0KPiArICogQWNjZXNzIGZ1bmN0aW9ucyBm
b3IgRlAsIFZNWCBhbmQgVlNYIHJlZ2lzdGVycw0KPiArICoNCj4gKyAqIFRoZSByZWdpc3Rl
ciBpcyBzdG9yZWQgYXMgYSAxMjggYml0IGhvc3QgZW5kaWFuIHZhbHVlIHNvIHdlIG5lZWQg
dG8NCj4gKyAqIHRha2UgdGhhdCBpbnRvIGFjY291bnQgd2hlbiBhY2Nlc3Npbmcgc21hbGxl
ciBwYXJ0cyBvZiBpdC4NCj4gKyAqLw0KPiAgICNpZiBIT1NUX0JJR19FTkRJQU4NCj4gICAj
ZGVmaW5lIFZzckIoaSkgdThbaV0NCj4gICAjZGVmaW5lIFZzclNCKGkpIHM4W2ldDQoNClJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5v
cmc+DQoNCg==

