Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE37C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZk-0002WG-Hd; Fri, 04 Apr 2025 13:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZA-0002KL-GF
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZ6-0005lf-DK
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:51 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223fd89d036so27817565ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786646; x=1744391446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k75AurT1vRKzwcv0IMBf+Gpw0r62rojoxurjSWOHzJg=;
 b=FSlMrDagFe0oeQLbquwQQw0t3SvdqXX8Oj2A+lvMqMnX09BIeI9tCmK7It2JMx/+G2
 vMz+2kdWZlOssLqtOezfPa+G7Nusgdy6yuDKArdcdr+FEZ3L3bfYKH76htyFzUmyFYmp
 Cldmo5pTXdDfbg0bMlZNxYUDhM/8NdIxZ8nIFOjoRdqfP41lm60bChDn6cuuw/F4PU1W
 msm1z3b7kQRZEBhZgI8hQBS08H4Kf1es3rszSa75M6grQA0sWN+0WfbLRv75V4yEPw/O
 xWXaGVxIMXflAFslBIjGilj+RTOxP8++5C3f1p0on/3yfRFDwKWxrdDjr87+opWv5aQ3
 tQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786646; x=1744391446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k75AurT1vRKzwcv0IMBf+Gpw0r62rojoxurjSWOHzJg=;
 b=qQyyQxN7oumj10aJFAmBAYgwrWiyOxxjv28p2MfifIEmarfDBDrh3WJG6600/q4az9
 Lp+HbT7ULyj/Qa3/z0u/mmYN8QuYWjlK+m6ktxiUBVG/FZEXEa/NdEHLVodoo3M68aiA
 AR6yrjQoR9Z9qIMr/iZIe/wTkR8YCTSc2YIegdXnSc0w07VZCiFfMdk5/0cT7WddHCoB
 dtQ9Zg5UBwxgZ/VGVhLnqXbcxze03GAgATANoF31/aLRdrG6A3pDGz2pb5JRae7rGGtB
 xAHxzGpM48Bp8Yp6SI32EKrRMKRDlX1oKjOr6qxZ/A4uo7uE7AExkxMywUh9ymoAGu+k
 smIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzPlzVQp2tFNTQJ2/apixnfimpKTJE9Bo9uCsl0mQXLqZVpNz0kDpvH9IoHuOCkyvr1a69wKfPfBaQ@nongnu.org
X-Gm-Message-State: AOJu0Yw5maeJ+TKsP2XC+cyWI/rNgdnaqgAcwV4t7ykQw2cszCogB/x5
 tCO6Sf9bHAMmdw/gmiDUKtijGiK/QRJZ/JmSXHWAVU7ql9u1Tl27cyzgGXg5B3g=
X-Gm-Gg: ASbGnctJTgqPB0LtacimEBT50QkL5BwX3Bu5J6sTJBayC1HCbjPA1jjap8xV/If1GKH
 evd9IQyI6NXwyDQR0iGsZitisrzLYsTyCFlzCA/a/HWlY8lLDeZptwCIJrSqEr2PAKH2JTr4o9I
 LAAYsyFCxb3qBOSwtvy4Aw5biO/tC67r0dZWPJX86cp+LJHkjul4GHNy760Gj+8rhFvY1g/ELYb
 K/aGl+mpE8Vyc6wZjwg789zB2yFgVeUW4gkHMHQ8y1VOhshaobMoyAd8I+8nWTItqoxE+KXMnq8
 5uBX3mz/e/Pr1TPxMlD+z64J3IQl5iVjY84X3ssHVETMOsjIDX6T/ZETug==
X-Google-Smtp-Source: AGHT+IGHIATv3uAxFlHNd2fJT8yU+lGtp8N45nu4LkEXh7hkrLnB6gCKjkgNW3O+OlYUDzHESY1g/Q==
X-Received: by 2002:a17:903:3bc6:b0:224:584:6eef with SMTP id
 d9443c01a7336-22a8a0a3617mr60209105ad.41.1743786646334; 
 Fri, 04 Apr 2025 10:10:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:45 -0700 (PDT)
Message-ID: <4a9a1643-cbd6-4e67-87ff-523b47f1b2df@linaro.org>
Date: Fri, 4 Apr 2025 09:46:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 05/19] qemu: Introduce target_long_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8taW1wbC5oIHwgMyArKysN
Cj4gICBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaCAgICAgIHwgMiArKw0KPiAgIHRhcmdl
dF9pbmZvLXN0dWIuYyAgICAgICAgICAgICAgfCAxICsNCj4gICB0YXJnZXRfaW5mby5jICAg
ICAgICAgICAgICAgICAgIHwgNSArKysrKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQ0KPiANCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJy
aWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

