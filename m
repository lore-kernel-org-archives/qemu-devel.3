Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40EFE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVttj-00069H-Sk; Thu, 09 Jan 2025 09:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVttg-00068q-A7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:52:32 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtte-0000QS-KC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:52:32 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aab925654d9so213983966b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736434349; x=1737039149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8QsK4KXF1E7/X6QsB304xmd1cWqss5CHHaY4U1DLHv0=;
 b=frlrzmY665syEJ6q8kvxY8iPFXaNB2KII8Jy/TPp28IffIfADS33fUjlOsZqawO+7H
 2NfCni6PMeMeI9X1VhIk5hnboBYR4DjGAxL6qgZlCBFDd9seXiVlUX6futdF0Fc0fB8/
 8J09rrnjjJ1g2xpf9kbROyQaZc4lYecaCaYhGUMyr9kQriutt9yJIN758+H1HFFS9gMR
 0QR6ISYHJ5EqL4x7WuGU/gEEcGIA7FPw6m5yx0zvqnNN9VBfV83M5syXcOP+pko/xM+J
 s4CeRmx43oKzoMr4MdUsDlu4uapilDvZptzsiHMe13/mP59Dj56p7Yo5Gof4u/3okz/y
 FI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434349; x=1737039149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8QsK4KXF1E7/X6QsB304xmd1cWqss5CHHaY4U1DLHv0=;
 b=Pt3nu1CbOrWG8aPYRVljvkXfBPgNGioNHZPv1Jd4q3JMphGOZkFt1I/T5JgeAJAa9l
 o/wKwvDB4QBdZFvXyus/kxzIPBfTDh5dS2bwolJ5gI1MziVCDNs3ddLHFujRlRuoGy50
 PUkkvsDiknFMx7Sl/1u0w4vyCl2IJhwPWJYrNfmrTBhvUoe2DIbzpJQKA0u5kKhYrA4s
 gEpeyQ+nHYW7u613GU+3jFT6U1jWxJ+Yzk9Lyn8q0um6TGpZjCKZofUllJQFyYaAl2H5
 F6t3EHgq+3jcROdf1cSaP3msS3E+4Sy50Auh0nEcuSVEFlIOn0p1OgDo3Oq+gToZbRuW
 ry0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG+rigaejbWievIGw/24MUpRUZiS561fup2HqQuhReHBo6Qq7JU02Qp2cYOZBCN0XjR0qsa7mLKuDW@nongnu.org
X-Gm-Message-State: AOJu0YzJzzuHpYfKP9MJnvYMR0y0/W8SJOHKqfKdFOM/l1gWJRIgPh5k
 5kinlmNDNzALRxwYSAq2swFTqCCTfhUdnnCebibd7VPBHWPw54VpBfZD8ezDP+M=
X-Gm-Gg: ASbGncuM6pQNuOgPfW3dpW27mj/dAJq2fRsYxcfzUkCN/9fLDHm09cmclJi5tC6hdGW
 15eA0XgNpFoc7/PrOuDG8CNFof7SRaJRv2HuNI2JCUam+gL5Q8cSrQKPnwSdb5LC4QBi+nMDMaU
 my8GYGTpNDpHFVIserUF05JSEM5Pxt6jAU7F4gbi3fBtiGfjXElkWhy7b+B3tYptfpL8McxhlIG
 fyd1Ule7LNj/Q7Mw45nRvUpvMRzofSnHOPMLdUTEJf3Wlj9/eNu+5VuHbGR07iOlQDmUbR4s6nq
 bjnSX38fKYCQQSeM460llAh26TM=
X-Google-Smtp-Source: AGHT+IHGXgM9fTfEx96ocOn8KPn6jk1lCCJAfIpAK7Qb566YDBn/fYuFqa6cf4s4OaQQkQcl9HlYdA==
X-Received: by 2002:a17:907:d87:b0:aa6:7a81:3077 with SMTP id
 a640c23a62f3a-ab2abdc3649mr739964066b.54.1736434348935; 
 Thu, 09 Jan 2025 06:52:28 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905ec66sm80158666b.18.2025.01.09.06.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 06:52:28 -0800 (PST)
Message-ID: <1d775199-1182-44ad-9545-74c58ba057d2@linaro.org>
Date: Thu, 9 Jan 2025 15:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/char: stm32f2xx_usart: replace print with trace
To: Nikita Shubin <nikita.shubin@maquefel.me>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Nikita Shubin <n.shubin@yadro.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241220084623.1889-1-nikita.shubin@maquefel.me>
 <20241220111756.16511-1-nikita.shubin@maquefel.me>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241220111756.16511-1-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 20/12/24 12:17, Nikita Shubin wrote:
> From: Nikita Shubin <nshubin@yadro.com>
> 
> Drop debug printing macros and replace them with according trace
> functions.
> 
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> v1->v2:
> Phil:
> - fix typo s/recieve/receive/
> - initialize 'retvalue' with zero
> 
> ---
>   hw/char/stm32f2xx_usart.c | 49 ++++++++++++++++++---------------------
>   hw/char/trace-events      |  6 +++++
>   2 files changed, 29 insertions(+), 26 deletions(-)
Patch queued, thanks.

