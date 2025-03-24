Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95379C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 20:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twonh-00084B-46; Mon, 24 Mar 2025 16:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twone-00083n-J0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:53:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twond-0000pS-1m
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 16:53:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2239c066347so109333065ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742849611; x=1743454411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=88YvAE8DHJtQExw71spkPnxGo/vHZiXw4d08iXvKagQ=;
 b=rns/Hz0BIwTOwt+x1O7iBIX2OU58+PKu7I1q5/9LR93j2fNDPQWusgKWMc/LCTEzhm
 E408hpcohk67VT/h9O7iPiCzXXvZtxUg5to9qsCZFY81+H9j34IX2rB5YNdXqwqu+pkl
 pGu7623KGRLVt1xbnAXIRwb05k0MiykgpJWHEvNlhAIqtChXPQuj0+Sr/4GvJovJddOC
 4QJx+MjsSfq+G8mL3DN+gUrx6Fx22xhg9BjVUvUDK/xz8QAlkIli6HLvyivvnUToEtOV
 xTpfoI+nLtEonGYGCC+snftwtQBb4teWrcnE3yx/YOUe19Ral+zG8uWvvRhP8rdxfEOZ
 rwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742849611; x=1743454411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88YvAE8DHJtQExw71spkPnxGo/vHZiXw4d08iXvKagQ=;
 b=u/cmRI7WVAW+/iSXs+j0+W3jUefPNaJ+J8eKabm0RuwcxikdrnT15jCYgzTXV1HvvB
 IjvHAfISr//J8SYgCtxJARvUTfmeZqq4lXS+ajuVKVj/MbFKA5vDMxrLcp3PQJjP7bOK
 dCI0U3ndvJCxK3bZUAgXK55qqjI/0I6aj+YGeNyT9dtD8lnkMjevJPaY/pq/hAs3OZNQ
 30vLpUBAUFlc8uDPntKCFthl4hYjpa2h0O7RdI+mV/sRE1nPtQSWnnsQVT1wbus89N+q
 GrKD9+V3yyfKNx6iioSaZNaNd3RYjR2g2dbXd2dgAm/Zgu1j9rU+X7+yMZp2/NL6YlOj
 hZ6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXCY/i6uk6CB8hfp3ngnDViaQKLxlXm1oKyckXRl7U+1YJexlriufxxzHnjUmk3Y5czsv/e3BYpTwC@nongnu.org
X-Gm-Message-State: AOJu0Yz4yaIPZH7pLysZxb8QPkMvJZHJVtRO/G4kplk5JWGBHKmRxSyZ
 PEwkBAc5Zu7Vmzrf4+Sa9/ep+uzv5oVq67+WymJ3yfVwg1SsG9XUT1eVgE49SBA=
X-Gm-Gg: ASbGncsVzcyuFbVjgXxSfUIWP2AC5+1e3p8Ay/fhCRnWQvqlnlBZQf5lK1UDfxLIi9u
 t+47I8H/v8fofw+oWbe+3pDwBv0Lyt1J4egsI2UGZec7hfDmb2gVLJXhxaS4ZmfMddQvmmIniyR
 GcjZYEE66shfuSTb83aRCb6B6si93eIdH3pJJwokkpkerYeL6JpAW4fRqB7Cp935fzfW/G8YiZH
 TGDQcyljYaAc5bTU2eoEb6pxjAeoDujLtEq+lG/kMAkaOkfbxcV4DQnkuOSq2M1EmirxpU966Nu
 KyadLwkjBFTJVHghz3itrICNJL6uKV1cBjiA7LoxN/I41UQ8nbQVCfiIEw==
X-Google-Smtp-Source: AGHT+IFeM2v0gx5z6CsXblUDqG+nXYcWeunH7nAHf3QM4d1IOxn4/99E2mWYWVmTUVw1YWwhxOdxHQ==
X-Received: by 2002:a17:903:41c6:b0:224:584:6eef with SMTP id
 d9443c01a7336-22780e3fb95mr264892305ad.41.1742849611542; 
 Mon, 24 Mar 2025 13:53:31 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd7a3fsm8807493b3a.67.2025.03.24.13.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 13:53:31 -0700 (PDT)
Message-ID: <541bf7bf-a5a6-4260-a50b-a4b7e2d0bf0a@linaro.org>
Date: Mon, 24 Mar 2025 13:53:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/3] migration/cpu: Remove
 qemu_{get,put}_[s]betl[s] macros
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Huacai Chen <chenhuacai@kernel.org>, Peter Xu <peterx@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Aleksandar Rikalo <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250323225047.35419-1-philmd@linaro.org>
 <20250323225047.35419-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323225047.35419-4-philmd@linaro.org>
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

T24gMy8yMy8yNSAxNTo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFRo
ZSBmb2xsb3dpbmcgbWFjcm9zOg0KPiANCj4gICAtIHFlbXVfcHV0X2JldGwoKQ0KPiAgIC0g
cWVtdV9nZXRfYmV0bCgpDQo+ICAgLSBxZW11X3B1dF9iZXRscygpDQo+ICAgLSBxZW11X2dl
dF9iZXRscygpDQo+ICAgLSBxZW11X3B1dF9zYmV0bCgpDQo+ICAgLSBxZW11X2dldF9zYmV0
bCgpDQo+ICAgLSBxZW11X3B1dF9zYmV0bHMoKQ0KPiAgIC0gcWVtdV9nZXRfc2JldGxzKCkN
Cj4gDQo+IGFyZSBub3QgdXNlZCBpbiB0aGUgd2hvbGUgY29kZSBiYXNlLCByZW1vdmUgdGhl
bS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGls
bWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9taWdyYXRpb24vY3B1LmggfCAx
OCAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTggZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9taWdyYXRpb24vY3B1LmggYi9pbmNs
dWRlL21pZ3JhdGlvbi9jcHUuaA0KPiBpbmRleCA2NWFiZTNjOGNjMC4uNTA2NjkzOWQ0Yzkg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbWlncmF0aW9uL2NwdS5oDQo+ICsrKyBiL2luY2x1
ZGUvbWlncmF0aW9uL2NwdS5oDQo+IEBAIC04LDE1ICs4LDYgQEANCj4gICAjaW5jbHVkZSAi
bWlncmF0aW9uL3Ztc3RhdGUuaCINCj4gICANCj4gICAjaWYgVEFSR0VUX0xPTkdfQklUUyA9
PSA2NA0KPiAtI2RlZmluZSBxZW11X3B1dF9iZXRsIHFlbXVfcHV0X2JlNjQNCj4gLSNkZWZp
bmUgcWVtdV9nZXRfYmV0bCBxZW11X2dldF9iZTY0DQo+IC0jZGVmaW5lIHFlbXVfcHV0X2Jl
dGxzIHFlbXVfcHV0X2JlNjRzDQo+IC0jZGVmaW5lIHFlbXVfZ2V0X2JldGxzIHFlbXVfZ2V0
X2JlNjRzDQo+IC0jZGVmaW5lIHFlbXVfcHV0X3NiZXRsIHFlbXVfcHV0X3NiZTY0DQo+IC0j
ZGVmaW5lIHFlbXVfZ2V0X3NiZXRsIHFlbXVfZ2V0X3NiZTY0DQo+IC0jZGVmaW5lIHFlbXVf
cHV0X3NiZXRscyBxZW11X3B1dF9zYmU2NHMNCj4gLSNkZWZpbmUgcWVtdV9nZXRfc2JldGxz
IHFlbXVfZ2V0X3NiZTY0cw0KPiAtDQo+ICAgI2RlZmluZSBWTVNUQVRFX1VJTlRUTF9WKF9m
LCBfcywgX3YpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAg
Vk1TVEFURV9VSU5UNjRfVihfZiwgX3MsIF92KQ0KPiAgICNkZWZpbmUgVk1TVEFURV9VSU5U
VExfRVFVQUxfVihfZiwgX3MsIF92KSAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+
IEBAIC0yOSwxNSArMjAsNiBAQA0KPiAgICAgICBWTVNUQVRFX1VJTlQ2NF9URVNUKF9mLCBf
cywgX3QpDQo+ICAgI2RlZmluZSB2bXN0YXRlX2luZm9fdWludHRsIHZtc3RhdGVfaW5mb191
aW50NjQNCj4gICAjZWxzZQ0KPiAtI2RlZmluZSBxZW11X3B1dF9iZXRsIHFlbXVfcHV0X2Jl
MzINCj4gLSNkZWZpbmUgcWVtdV9nZXRfYmV0bCBxZW11X2dldF9iZTMyDQo+IC0jZGVmaW5l
IHFlbXVfcHV0X2JldGxzIHFlbXVfcHV0X2JlMzJzDQo+IC0jZGVmaW5lIHFlbXVfZ2V0X2Jl
dGxzIHFlbXVfZ2V0X2JlMzJzDQo+IC0jZGVmaW5lIHFlbXVfcHV0X3NiZXRsIHFlbXVfcHV0
X3NiZTMyDQo+IC0jZGVmaW5lIHFlbXVfZ2V0X3NiZXRsIHFlbXVfZ2V0X3NiZTMyDQo+IC0j
ZGVmaW5lIHFlbXVfcHV0X3NiZXRscyBxZW11X3B1dF9zYmUzMnMNCj4gLSNkZWZpbmUgcWVt
dV9nZXRfc2JldGxzIHFlbXVfZ2V0X3NiZTMycw0KPiAtDQo+ICAgI2RlZmluZSBWTVNUQVRF
X1VJTlRUTF9WKF9mLCBfcywgX3YpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gICAgICAgVk1TVEFURV9VSU5UMzJfVihfZiwgX3MsIF92KQ0KPiAgICNkZWZpbmUg
Vk1TVEFURV9VSU5UVExfRVFVQUxfVihfZiwgX3MsIF92KSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

