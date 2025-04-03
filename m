Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98E0C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 18:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0P9M-0002o9-NX; Thu, 03 Apr 2025 14:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0P9K-0002na-W9
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:18:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0P9I-0001M8-9Z
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:18:45 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2241053582dso18488505ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743704323; x=1744309123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d4me9HSa79DpI9hViQaLRRFC0BhvU5qGtbgKvQDgaM4=;
 b=v09ceJrRYHDn6zjpsfv/50TGqvvqxH8N3rpzWSZ9CCNjlOMYRu5e90bMjTALPla2r/
 iB/8xSEeolFptTNIKTcIb33dotFbkzYiAS0rmal4pJsLUaHQJCBAS7hVm2kHD06udxER
 TSTeahhEvImqO15kR0uU+wHl7J2aT16vlpvd/xga18LY1UgNldYzO5ZXBWmITH+8vcb8
 kRv18w1PPQgw/DI0LzVY3B6a2wMtaNj4Hql/MlXmr0xK86Vmy0cMhxdWkvwmvYxxsMXq
 XXwJYemEnJUnNYfRAIk3YtzNG/1EGWnClECHGSowYcDUJpUDhoVSrUOswZtud20FQb7q
 OH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743704323; x=1744309123;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d4me9HSa79DpI9hViQaLRRFC0BhvU5qGtbgKvQDgaM4=;
 b=RrBAfcoDbz18TbLnbxpNEwdwjbe+q1gXuT2J/fmPY+z30sNKuabg6bXlRUz9yldj0k
 zi8gn5jPdGl7C81NgMVwXx1UMb2dN7ts6FAsqdstkQQQYvijWT6MLrSm5Z4nyUuA0vUe
 0okty6E9Qzd8ROn+jnw2ky+Gh2clxW1j7ZKjYkbi7K/o6lZHEs9aQXrC7pRjljfmhja9
 LULbrL5rXJHVbRasTcuqujxYK0ggfFvtSZtUYxmM8fMLr0B2B/Jz9gJ/tWGno79goql8
 SVZ58AxHvdx9JobiN+PiXFtZ8k7NOJ3iXr5jgrKned3OE2bo02WMi1Bh3ZOywqZTIBEx
 FiHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrHUDmxh0otI8ULijXLEkqdwi4MapA5bZfcnBCkv1C5cA/MW7r82VSSZbiIYKSXzf5PFIqJQEDzWxG@nongnu.org
X-Gm-Message-State: AOJu0YxAnGHmkiCIhi1et0vK+KFyKu+zCs4uH//sreRIMuhdc81pvNgo
 BTt5sxADOiFRAAd5lZA9/aluSWLRLJ46vtyq+JCmiD1c6oIh7SBfY6rHRiegMgI=
X-Gm-Gg: ASbGncugrNS0AUAWzJhPUQbRo3yDl7+uvMrB1MDuFub8c4ynNaUZkLkdC+j6nO2cxeK
 VtVhUUt6PFpRbtwK3cA1TZUZYZ7GK1OQFEEC8/KmlYyuJ+0frgoYK+NlPwR5nXcjZw3zkkhSV6V
 a6ytsl7C7hmpx4NBEnuC6REu59lVPuVmf+T9BQOzq461OhCYuQAEG/NhaJmh5bVEK9459nra6ZO
 h2Tmnec5WdcFYcVU/JWBsEneBusqVnsij8zVFSJVmsn0cw1Ssx5Kt8TnONdpGJNNvCy3ZQQaVSA
 ncrbTBH89Vv6p2+EWF/m7fkM0Ulyp60TynB1AFim6t/L3+o/QFFqIDdYBg==
X-Google-Smtp-Source: AGHT+IEjY4J8no8ZTnQ4TFMyCy/7eMtsKZ9ENQyWYFqI4AYcBCFHLPYcEYfCi/uxITw8lg+LUBrNqw==
X-Received: by 2002:a17:90b:5251:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-306a48b3f74mr722833a91.32.1743704322834; 
 Thu, 03 Apr 2025 11:18:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305983bce79sm1851742a91.37.2025.04.03.11.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 11:18:42 -0700 (PDT)
Message-ID: <3aebe513-dd84-4cff-a191-97bc948aae01@linaro.org>
Date: Thu, 3 Apr 2025 11:18:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 00/13] arm: Spring header cleanups
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

T24gNC8yLzI1IDE1OjIzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gVGhp
cyBzZXJpZXMgaXMgbW9yZSB1c2VmdWwgZm9yIGhldGVyb2dlbmVvdXMgZW11bGF0aW9uIHBy
ZXBhcmF0aW9uDQo+IHRoYW4gc2luZ2xlIGJpbmFyeSwgYmVjYXVzZSBpdCBhbGxvd3Mgbm9u
LUFSTSBody8gY29kZSB0byBjb25maWd1cmUNCj4gQVJNIGNvcmVzLCBzbyBub3QgdXNpbmcg
dGFyZ2V0LXNwZWNpZmljIEFQSXMuIEkgZmlndXJlZCBzb21lDQo+IHBhdGNoZXMgY291bGQg
YmUgdXNlZnVsIHRvIFBpZXJyaWNrICJidWlsZCBody9hcm0gb25jZSIgc2VyaWVzIChpbg0K
PiBwYXJ0aWN1bGFyIGFybV9jcHVfaGFzX2ZlYXR1cmUpLg0KPiANCj4gUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgKDEzKToNCj4gICAgdGFyZ2V0L2FybS9jcHUtZmVhdHVyZXM6IEluY2x1
ZGUgbWlzc2luZyAnY3B1LmgnIGhlYWRlcg0KPiAgICB0YXJnZXQvYXJtL3FtcDogSW5jbHVk
ZSBtaXNzaW5nICdjcHUuaCcgaGVhZGVyDQo+ICAgIHRhcmdldC9hcm0va3ZtOiBJbmNsdWRl
IG1pc3NpbmcgJ2NwdS1xb20uaCcgaGVhZGVyDQo+ICAgIHRhcmdldC9hcm0vaHZmOiBJbmNs
dWRlIG1pc3NpbmcgJ2NwdS1xb20uaCcgaGVhZGVyDQo+ICAgIGh3L2FybTogUmVtb3ZlIHVu
bmVjZXNzYXJ5ICdjcHUuaCcgaGVhZGVyDQo+ICAgIHRhcmdldC9hcm06IFJlc3RyaWN0IGlu
Y2x1c2lvbiBvZiAnbXVsdGlwcm9jZXNzaW5nLmgnDQo+ICAgIHRhcmdldC9hcm06IE1vdmUg
c29tZSBkZWZpbml0aW9ucyBmcm9tICdjcHUuaCcgdG8gJ211bHRpcHJvY2Vzc2luZy5oJw0K
PiAgICBody9hcm06IEluY2x1ZGUgbWlzc2luZyAndGFyZ2V0L2FybS9ndGltZXIuaCcgaGVh
ZGVyDQo+ICAgIHRhcmdldC9hcm06IEV4dHJhY3QgUFNDSSBkZWZpbml0aW9ucyB0byAncHNj
aS5oJw0KPiAgICB0YXJnZXQvYXJtOiBFeHRyYWN0IGZlYXR1cmUgZGVmaW5pdGlvbnMgdG8g
J2NwdV9oYXNfZmVhdHVyZS5oJyBoZWFkZXINCj4gICAgdGFyZ2V0L2FybTogQWRkIGFybV9j
cHVfaGFzX2ZlYXR1cmUoKSBoZWxwZXINCj4gICAgaHcvYXJtL3JlYWx2aWV3OiBSZXBsYWNl
IGFybV9mZWF0dXJlKCkgLT4gYXJtX2NwdV9oYXNfZmVhdHVyZSgpDQo+ICAgIGh3L2FybS92
aXJ0LWFjcGk6IFJlcGxhY2UgYXJtX2ZlYXR1cmUoKSAtPiBhcm1fY3B1X2hhc19mZWF0dXJl
KCkNCj4gDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+DQo=

