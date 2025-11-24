Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3624CFD347
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 18:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNbQw-0005JA-20; Mon, 24 Nov 2025 13:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNbQu-0005I9-C2
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 13:37:04 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNbQs-0007T4-LE
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 13:37:04 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-299d40b0845so75119565ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764009421; x=1764614221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RATSlWM9SDnmkhVVd54eKlVYnmlml6ZviGqry/IFNyo=;
 b=yOr8hkWlBrCY/x/Gb3r5au3LvzAFdiAP9UUAW6vLjNLGPC/FEusR5+XgIOvui0R46e
 J8J9nQwOZBpRpY6LsXM5nGusM1TF64TDdVsdMwxWpZmXtSAZdWfOFvUBdwGnwVHTWr05
 pz7UpqWAgW63pO6nrfaYqghybZmgy6rbCf8youXFNT8Bpheve6gdhdXyztRRk3gjaxbI
 hFv/++lvgNDhVQQcAUAfvVFw5U9fLGDNgnq6QepFCgLk/cNz6LqTt1XFKPg6CkYYX5t3
 RipOI0vkCBhCTjR2mMcn07Ofew7d2OjzB0LGvOITyI2mKeMgDjfSwImocAt3teOyI52q
 8CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764009421; x=1764614221;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RATSlWM9SDnmkhVVd54eKlVYnmlml6ZviGqry/IFNyo=;
 b=dQjcf6JXNFlKBpXOZaugXW35BYELspNCTjd/KYWZl+5bP8g1YEjqFs4wA5utRnxwuO
 QjP3/GkXEZwqIkiOnq5Dn8vzwc4BRylxtcCXMnBQOfi+X/VhT873+0QqkkVqazqagRKY
 hwVwSHTJ1bNLphQi7jU4BwPPH32mJaOI6hCeHmf6X0IcIiM0j/k2nsJ4KjQaejhvsYmR
 TnalfOMgJrjWlQO8T7pPSCJYZxoYMZxuZ5srHbSUbfvVF40kXq7QI/YIpbuohim9VVyM
 iZdzzEd/azJ6iVIvncPLnN095YjVwcV8WRw6yOUrvLs8b+CYi9dYv5ZoYBx2sKgZEBHq
 WtjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQsvpgVUHukdAj5+ZdweleT1qz+fJIOHA/0Ucszf/DruaBlidiUDFzQ89TGafkt7p89hEmyBSSRJCB@nongnu.org
X-Gm-Message-State: AOJu0YzIPiN0YZfA8N8Ws2KC8yjjsD71nuWQuJn2S4In8A++yyEd9Nlw
 3S+7OCjxl+R9HGgyf8dlMTjP/wGE9WeOTK6IddQVicXQyyca4B1Npj0KeC63W5pUhwk=
X-Gm-Gg: ASbGnctnNGm7lYqn/zq9C5BgYw3VI+cJXDo0DZh3OquXKMqPION5XWE/qpkqpjPV2DZ
 m69sMSkcZ8Ek9L/ElONu060SNGqcUTufqmi/wxA3ULGyESPM+MG+QtHWXdRZ0t2fon5UicbbUsT
 8NZR/7jrglGsPqqDSD9RtlOk3MMbeiGHz1kcBhh7fsiiHRytd7EiamT82rIYFC3HYjM17c6xJ/i
 6r/nd6fAYkyikhu1SXIjBnO6V/iI9j+swn+PALblsM1UUDgYx6Uyp/Iz6Qm5KRzlVj360phir90
 Aethv4uXKcoGGbQd9D3/0+cjMVrYLSJIP/gfWgfJnmjFlAadPpB+2GVZanCNynwc3jxKNg2FYvP
 t9th/UsFHfgbfGAGElftExWFFoU4M6yASl+qgrcjnwPOSsrqrFaYDXmdItPJv0wk/ITwa85xNOS
 ZxPLhJS0YqAXjpFbVhBzBOFjonwsuwkwSlu8lsjRb0yI/ay+gX1A==
X-Google-Smtp-Source: AGHT+IFbayaLUdiY7X8gndxDhjgBxmz8VyzrCBBqEtbSeVlm9zzT27rwOmyewdx+Ob/a5pgboCLi6A==
X-Received: by 2002:a17:903:2c06:b0:297:fc22:3a9f with SMTP id
 d9443c01a7336-29b6bf19f1dmr142629995ad.38.1764009421123; 
 Mon, 24 Nov 2025 10:37:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b26fc24sm144558035ad.67.2025.11.24.10.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 10:37:00 -0800 (PST)
Message-ID: <ca88a786-d80f-4f66-9562-d6712484c41e@linaro.org>
Date: Mon, 24 Nov 2025 10:36:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for 10.2 0/6] gitdm updates for 2025
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20251124095337.537277-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251124095337.537277-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 11/24/25 01:53, Alex Bennée wrote:
> The following changes since commit fb241d0a1fd36a1b67ecced29d8b533316cf9e2d:
> 
>    Merge tag 'staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2025-11-23 11:46:53 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-10.2-gitdm-241125-1
> 
> for you to fetch changes up to f5b6ca5606f8a1ed29a127847932fa2bc237ae38:
> 
>    contrib/gitdm: add more individual contributors (2025-11-24 09:48:18 +0000)
> 
> ----------------------------------------------------------------
> gitdm updates for 2025
> 
> With the latest updates the last year has been made possible by:
> 
>    Top changeset contributors by employer
>    Linaro                    2959 (37.0%)
>    Red Hat                   1919 (24.0%)
>    Intel                      313 (3.9%)
>    (None)                     308 (3.9%)
>    ASPEED Technology Inc.     231 (2.9%)
>    Loongson Technology        227 (2.8%)
>    IBM                        192 (2.4%)
>    Oracle                     187 (2.3%)
>    Nutanix                    133 (1.7%)
>    Academics (various)         99 (1.2%)
> 
>    Top lines changed by employer
>    Linaro                    109812 (31.8%)
>    Red Hat                   91050 (26.4%)
>    ASPEED Technology Inc.    11811 (3.4%)
>    Intel                     10606 (3.1%)
>    IBM                       10146 (2.9%)
>    (None)                    8965 (2.6%)
>    Oracle                    8574 (2.5%)
>    Loongson Technology       7614 (2.2%)
>    Nutanix                   7404 (2.1%)
>    Microsoft                 6927 (2.0%)
> 
>    Employers with the most hackers (total 433)
>    Red Hat                     54 (12.5%)
>    IBM                         30 (6.9%)
>    Intel                       17 (3.9%)
>    (None)                      13 (3.0%)
>    AMD                         13 (3.0%)
>    Google                      11 (2.5%)
>    Rivos Inc                   10 (2.3%)
>    Linaro                       9 (2.1%)
>    Oracle                       8 (1.8%)
>    Huawei                       8 (1.8%)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

