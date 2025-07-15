Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F4EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 17:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubjwJ-0007WJ-SR; Tue, 15 Jul 2025 13:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubjQ8-0005Yg-Ke
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 13:26:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubjQ6-0001dE-GI
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 13:26:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so81755f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752600380; x=1753205180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ZryIOjtMVegiqFZuLVx5tQ8ly0y6vZbtQ5OMjijrs0=;
 b=JkxhtI4b0yaw+xp4owIdQ72TZFCvn0RL057SvPBe859IEIWIq/SXDh++yomgWZbhMj
 u12AMplZQIcguHXrpgf5eZuLXnXysAT9lQrD/4m3PPfL9Xzcfvgxa1WB3mVMhi7d1N9V
 yCNG8IEd2vR7JD2KxspucMioTmK6yfKkXYNFGtxyfgNhrNvl784ip32cgc2tAorvdLBQ
 ni9lqpQRTS+03HDzw1TNl1f57lBg93fDx10+K7wyoXTiMSwma0xvtVsBITui4LqhdcNr
 juPGSfHHTxzw7B3+X5T1bMhsBhyy2wUvLxDb32iv2il1yVtp/ydphHv3W4rJBFPQm8al
 MfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600380; x=1753205180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZryIOjtMVegiqFZuLVx5tQ8ly0y6vZbtQ5OMjijrs0=;
 b=hHp0ihNhhGbJuh0myYkQySmMkDpn8J+pkM8Ort8oZIP8s4FKzzqUbn1SFyGKWmmlcI
 Z2PwqGQtqb7IbFw7+CgeYCEFAU47evzmCFgHvx7R1MYnUuWp+EqHXB4196LQTDOspph8
 YHxsk1374VOUKpSn6aV63NDCuA/zKlcBuIkPH7gf7hZr5GcGKn8z8U2bUcOBp/UDwxuA
 1FLaXSR1z3mQXWd16S5Un+yhEnUhT7ytSnK2pi3xdYE+JRQZXky+LGY752KpNCLTxP+n
 E6RGmP+T0ZsuoVrZ8hKE++rG4j/Cg4QTZJsaiE/9RT7dZijRJGcdRtcaKHOWP+qgxyD2
 V9QA==
X-Gm-Message-State: AOJu0YzgN/ujy++sZc+Yhp3by/qA/CQW7/GjpOUw6rLdsyX/04TW9G4t
 weJJkO4Tnjw/EGI5Ynmxhp1YiuimtUs3jJMeSUwQI2uCmJOS9M72wVi8j5xUh6JBBIk=
X-Gm-Gg: ASbGncv/XxOgxGs2bb60M3/OzDTa2bsphbeDvfrto/XZQ+cmKAlEjywYVSEkXk6+D94
 6ZZy7XTGTVeTFih6/0NyREuhhXBcz6c8sT8mreQTKrZVNrXUqdEUj4C2px+3ELxUHJXlQTl5Fqb
 t0XJTGhwlE5OjmLjmwkALFJ3z2zGH7hfoQ7qJE6GeeRc8xCRiTKQE+xNSKrt9uQKIPRSmnyFZGK
 86pUzTRzcWUxtFp/OCEXYowf/EFeUEin3xmnRp7856GVOW7T/BgAS3a2tbVuKgGOwQbZ8E6tqKm
 7QhjExxNb7bqOBiZmAe9cCYh7zczMr9CsIcibsxP2s/1KThdbomfEZTnZGHqLPwNvc6hCtYUof0
 m/Ly0BuNWebU/b1dnMPvwAFrX22/6LDAY/E32kX7/bqiWXxC93UFHFZ8S66ybd6CC9g==
X-Google-Smtp-Source: AGHT+IHbnJALXUbkZ5qV8vcJVT0MpOtZ4MAkYRY7OgeMDmkZun7fXz2OmBlBEdh0Mul3Wv4xLbakZw==
X-Received: by 2002:a05:6000:18a5:b0:3a4:f722:a46b with SMTP id
 ffacd0b85a97d-3b60953aaafmr4161394f8f.15.1752600380159; 
 Tue, 15 Jul 2025 10:26:20 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2025sm15924046f8f.31.2025.07.15.10.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 10:26:19 -0700 (PDT)
Message-ID: <d4ff91fa-e015-44a5-931e-ad52d3e93179@linaro.org>
Date: Tue, 15 Jul 2025 19:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] crypto: allow client/server cert chains
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, matoro <matoro_mailinglist_qemu@matoro.tk>
References: <20250715092932.1395271-1-berrange@redhat.com>
 <20250715092932.1395271-8-berrange@redhat.com>
 <fa670d22-d882-409c-af3d-1669d6386800@linaro.org>
 <aHZ9O5N67rfnJ9SB@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aHZ9O5N67rfnJ9SB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 15/7/25 18:09, Daniel P. Berrangé wrote:
> On Tue, Jul 15, 2025 at 11:46:31AM +0200, Philippe Mathieu-Daudé wrote:
>> On 15/7/25 11:29, Daniel P. Berrangé wrote:
>>> From: matoro <matoro@users.noreply.github.com>
>>
>> Should we use <matoro_mailinglist_qemu@matoro.tk> here?
> 
> I generally don't like to change the git metadata that a user
> submits with unless it is clearly broken, which I don't think
> is the case here.

I find confusing to have a distinct email for author ...

> 
>>
>>>
>>> The existing implementation assumes that client/server certificates are
>>> single individual certificates.  If using publicly-issued certificates,
>>> or internal CAs that use an intermediate issuer, this is unlikely to be
>>> the case, and they will instead be certificate chains.  While this can
>>> be worked around by moving the intermediate certificates to the CA
>>> certificate, which DOES currently support multiple certificates, this
>>> instead allows the issued certificate chains to be used as-is, without
>>> requiring the overhead of shuffling certificates around.
>>>
>>> Corresponding libvirt change is available here:
>>> https://gitlab.com/libvirt/libvirt/-/merge_requests/222
>>>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Signed-off-by: matoro <matoro_mailinglist_qemu@matoro.tk>

... and the S-o-b. Anyway this isn't the first case, so I don't
mind at all.

>>> [DB: adapted for code conflicts with multi-CA patch]
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    crypto/tlscredsx509.c                 | 157 ++++++++++++--------------
>>>    tests/unit/test-crypto-tlscredsx509.c |  77 +++++++++++++
>>>    2 files changed, 147 insertions(+), 87 deletions(-)
>>
> 
> With regards,
> Daniel


