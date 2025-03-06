Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3892C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJtW-0001QB-Iq; Thu, 06 Mar 2025 17:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqJtJ-0001Od-8e
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:40:34 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqJtH-0003SU-KU
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:40:32 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2239c066347so22671795ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741300829; x=1741905629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5wgvyjqfSSFbzTIm6MSjQdiHQSjDlgIq0rnpnyaG52A=;
 b=tw6Eg4weXESAd7PuibneKsW57MjP3G2EzoANpYnHU9ykv7yuOSGBefE1EG/GArUasr
 aBNWEnRFlKsNUuZ8Z/frI1uxN44OLkhoks79ipL3uSxBNvQLgSJ3j5F9Lb8IiNOirCAZ
 I2Hu5iXXIZcDCz9Cwg9dtEJidlGEYjHtgW5NcIss37IgZ5AVP4/IBLvSirREgU/0V7fX
 9GDlow7Gxplj2r7DWFhOSDTSdls5K7f1H6yWMhU3khhvrkwJeXWH4ZRSd8IcpKCbu1dV
 IyUADxURCGB7y9vo3bk7fqwOMaOQK4BrQY12o2qwJVbMTGy2+z8CowqlBtC5XCg42/Ia
 1IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741300829; x=1741905629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5wgvyjqfSSFbzTIm6MSjQdiHQSjDlgIq0rnpnyaG52A=;
 b=dvEP9zKs04ENSqPjxMtKTzFbKJgilntISBIaa3zAa1cpyp4qpRDAK9afFb7YpHHRfs
 MJRp7GZke/UJdyxTKbNrjEaJLWOl4A8EOfw1BPud9QsX/Qi5/P7eMCN8vRF+4a9qQfmB
 xBl2BIAh42VRUvNXABDTBn6jC6mAYC3Eaeok2K1Qo7fbtlt+Cl54y8UKgXjG/6TfLfKS
 keAubD+c+M3Mz+sCnwuBOOY2etvDUSN4MtAXpqgwa9M2f+e9fmuPUOL+VqqvZaW8fCYN
 fn2q/Z664Ou5dq6S2Ip3d45C4TELvO5cPgkGkJt2pgou8XPp7gc0yUzdQMUP850suhhK
 wZhQ==
X-Gm-Message-State: AOJu0YxM+yvBAIIrZCCz192fl3i6QmvPoPWWfwYt24SgjA7yw/28tJ80
 JFN2wCvvhhFYANmED7VcjrRBcU2gYjx5p3mHK585sVeMzL/TwuADMLvcA3VF7Dk=
X-Gm-Gg: ASbGnctpQPTtPMod/xS+Y5ECz6xwsS8cB4Nh47cJ4+ZSqx9xP/JEBO43mvJRLvUTXeH
 /sOIRPBUMCKnu91frJY3lLZmlvMp6PROrcFE/v5T5t2sGYUwXubX939zJiKN4WWbLsK8LU/9cSK
 UWBenu4vnijWYrhHpPNOdax3Ixcyn3wQ4CUIRLC+Pz+mMNIwvjU5pJ4wPEKUSAtSZZScZyuh4Op
 jNu/XOxB2LRzH3cgd/AnDAEyXzWnDuBEcqogmvUcUvhdeI8nTTvroLs9b+Ajky3h70K/jiawRoJ
 tjGG7vR8RXUj9DJv/PQpJAQ8H4Irmbc/exZ/pbzSOwHgxv8VmCWQvGIZPg==
X-Google-Smtp-Source: AGHT+IGmTJmzUvFzEPcruXwZyIQW6yWjOjJ8NYJviz1AlqgPMQI9qYaa3LUE5w2TJ0ZfNZOJTGEOog==
X-Received: by 2002:a17:902:f645:b0:223:4d5e:789d with SMTP id
 d9443c01a7336-2242889f262mr18156565ad.19.1741300829645; 
 Thu, 06 Mar 2025 14:40:29 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109fefa6sm17755115ad.106.2025.03.06.14.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:40:29 -0800 (PST)
Message-ID: <18fd9ebb-dfe0-403f-994a-e542e890eb4e@linaro.org>
Date: Thu, 6 Mar 2025 14:40:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] hw/hyperv/hyperv.h: header cleanup
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-3-pierrick.bouvier@linaro.org>
 <871pva4a5g.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <871pva4a5g.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gMy82LzI1IDA0OjI3LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IFNpZ25l
ZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zz4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2h3L2h5cGVydi9oeXBlcnYuaCB8IDQgKysrLQ0K
Pj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaHlwZXJ2L2h5cGVydi5oIGIvaW5jbHVk
ZS9ody9oeXBlcnYvaHlwZXJ2LmgNCj4+IGluZGV4IGQ3MTdiNGUxM2Q0Li5jNmY3MDM5NDQ3
ZiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvaHlwZXJ2L2h5cGVydi5oDQo+PiArKysg
Yi9pbmNsdWRlL2h3L2h5cGVydi9oeXBlcnYuaA0KPj4gQEAgLTEwLDcgKzEwLDkgQEANCj4+
ICAgI2lmbmRlZiBIV19IWVBFUlZfSFlQRVJWX0gNCj4+ICAgI2RlZmluZSBIV19IWVBFUlZf
SFlQRVJWX0gNCj4+ICAgDQo+PiAtI2luY2x1ZGUgImNwdS1xb20uaCINCj4+ICsjaW5jbHVk
ZSAicWVtdS9vc2RlcC5oIg0KPiANCj4gV2Ugc2hvdWxkbid0IG5lZWQgdG8gaW5jbHVkZSBv
c2RlcC5oIGluIGhlYWRlcnMsIGluZGVlZCBzdHlsZSBzYXlzOg0KPiANCj4gICAgRG8gbm90
IGluY2x1ZGUgInFlbXUvb3NkZXAuaCIgZnJvbSBoZWFkZXIgZmlsZXMgc2luY2UgdGhlIC5j
IGZpbGUgd2lsbCBoYXZlDQo+ICAgIGFscmVhZHkgaW5jbHVkZWQgaXQuDQo+DQoNClN1cmUs
IEknbGwgcmVtb3ZlIGl0Lg0KDQo+PiArI2luY2x1ZGUgImV4ZWMvaHdhZGRyLmgiDQo+PiAr
I2luY2x1ZGUgImh3L2NvcmUvY3B1LmgiDQo+PiAgICNpbmNsdWRlICJody9oeXBlcnYvaHlw
ZXJ2LXByb3RvLmgiDQo+PiAgIA0KPj4gICB0eXBlZGVmIHN0cnVjdCBIdlNpbnRSb3V0ZSBI
dlNpbnRSb3V0ZTsNCj4gDQoNCg==

