Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08253F30266
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 13:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1lln-0005yE-5v; Sun, 15 Mar 2026 09:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1llf-0005xl-1T
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 09:44:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1lld-0000Cb-7j
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 09:44:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso32289425e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773582267; x=1774187067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qQEuHLcaKmHbNeWnL/cyH3hFkJm2m7Bba1DmXkayB1A=;
 b=qafB9vz9Vc+HU0C6e//FYzNk+zw8ZULImMxvZ1J5zKi1CRmM3oXHIt7vcua4tiMUJK
 BEqXi+33HB2+RQ0nYoqa9EDYPc7XDG9cBe0qOFM1we/8NNUYLhEJWLn1rA5kuqDnVmMC
 u3fNlauqKAiFbvDzjx30rGeNOGg58/BlmAPH16qSYC/tmI2xPjN9eF3OfB+kxfvAIh14
 QKo0qwwcdyzWdZxAKJbCv1GCCFqXVyUy3O4IAp3KkDi1YdskCnBiBzazZJVGQZJgSb2E
 C5wbWYaBs/dzO9Rg5hVU3aJlFtWqQ/rT2ikNjdQJaANPWgYaTDQYDxUPtmHl9QDWPDC0
 9cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773582267; x=1774187067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQEuHLcaKmHbNeWnL/cyH3hFkJm2m7Bba1DmXkayB1A=;
 b=QSU/1yArc0BeyMTd6hMMNebQgxTk7ZugDg8Vz0SsHKL6zWi+tW5G0Te+bqRl7tytQy
 8O0dN14weaxDPoMSSgvjBa+L8JbsXsO1lqLP0sSpf83WZxa78z/GmEpndu+mXIa2JARU
 W9AQ78fcaWxrFcnKySA8xstFu+VcdzyD5x7kLnk5GcoDixA0dzSuBxnwtSYUgjlsiDAL
 ZpqXKJkRUnG9r46x9UnZglpHz2dE1mDJQRDCGYWGuDOzIH4RnZ+D4xbEvmga+clBZrJQ
 ZbvJtXTqA6bxo9u8RKxmI0kMUhvhO0leCE4Y5roWHnl0nT+qKlRLQMDBodL8HSHRj3M4
 JLXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzUfdCzu7TdR4YlzJicNfCtBoGVQgdQN398DboWnyUqHd9fo6NnMB7F+QzAFP6gX8NNfNCDqASC5w1@nongnu.org
X-Gm-Message-State: AOJu0YwGjih1fqRtJrv2lZHJQqhWofg3CInOU6zanjaFpwplVN20uyOJ
 LKo7K5QJBMWt9D2x1wAlJKJWRo2iOw1YuLnYIEFz3MegthYE2H57aideRE/ZShALUH0=
X-Gm-Gg: ATEYQzzfyNz76A86hG44sWIBlTeKsNvbXryIKudW6sH8JLZlwtvyBNbx6AjiAjwDY9Z
 2n/aMpW9ae+gg+NjlqhXoodpbLrXMg3B8cxPZbWGqpVKOcCbya1hXQu9VAAdFH+k6l2Yo+S2xwO
 yjQjQvdVPTiQzbs4URmXojbLm2I8XGB+TnkNG6X0YJkFEkpwcP1k7ebhBINTRbwJdtn4DnoBVhE
 3Cm8lpkuH82kUMzNmCNAZrXQm5+sYGiOb6H9bJqLoouCjPaD2UDRjtTKYOCgGOkGyMBAVAKtL7T
 /CZn3JLnmYgyCmpDAma/LzgjDlGbzSzfa5OC26yxFXAdDeWF5fZyCfDVG7zyFa/WK9kh7BwWXhA
 m41suxVvuJolRoad8pvbJ0JYIq3fpS5B8cPiMe9byYXAdezpoVqE9pqTUZXr1TQyxiN1OUe38qm
 7JWOGrr6I4kdL/PB8C3mstZoZAfvSjhPHw9LcGsS3SYzYSnwxj43bkovedFBSwX7sSFA==
X-Received: by 2002:a05:600c:3b90:b0:485:345b:ccb1 with SMTP id
 5b1f17b1804b1-48556720f86mr148634945e9.27.1773582267326; 
 Sun, 15 Mar 2026 06:44:27 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f708sm756964175e9.11.2026.03.15.06.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 06:44:26 -0700 (PDT)
Message-ID: <bc1cb04a-8e3a-471e-8fed-1c53799ebef0@linaro.org>
Date: Sun, 15 Mar 2026 14:44:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] whpx: arm: fix ID_AA64MMFR3_EL1 host feature
 register index
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Osama Abdelkader <osama.abdelkader@gmail.com>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
 <20260314221529.47841-7-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260314221529.47841-7-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/3/26 23:15, Mohamed Mediouni wrote:
> From: Osama Abdelkader <osama.abdelkader@gmail.com>
> 
> IdAa64Mmfr3El1 was stored in idregs[ID_AA64MMFR2_EL1_IDX], overwriting
> MMFR2 and leaving MMFR3 never set. Use ID_AA64MMFR3_EL1_IDX so the host
> MMFR3 value is stored in the correct slot.
> 

Fixes: f7fa2b88084 ("whpx: arm64: implement -cpu host")

> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/whpx/whpx-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

