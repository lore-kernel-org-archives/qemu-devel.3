Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D90BCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB9BP-0002Vw-Il; Tue, 21 Oct 2025 06:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB9BO-0002Vi-7m
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:01:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB9BM-0003Nh-0B
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:01:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4711810948aso36632955e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040890; x=1761645690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pwgfOhp/2ij9lnaA+c2M8qIuZDMTiHP92piX+EKP6bc=;
 b=dPtEJXumVoHUBNeMdH8be9zjQYMN6mRvU24A5pIPvOURCa4OdP9l5/joVUKHR5wxrD
 dMNXnvEIeqMSAoZ1H2xlJYHvDPlNb8EIiUHkBa5uOreTlk95d0E+NilVpKCryJkLb+Il
 t9w8hlU+se5nlQacaV1yrDVCW/TNwaXtbrLNIJS/X3lRUgFeM0lt4+Lp+hoqgE1HXFyz
 ejVA0ZDMI/Je5ruIEJUi/Zw2Kb7JHwLMwFGzlchDPujYbM90maIMpftELWaBbXuS+JVH
 CzQGLpA6hNxYh2GYDNMxGBguCSR9eSmkQnFVIwtiXzYyanhwu0iSFfhNjIAEx98vV5MM
 Wz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040890; x=1761645690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pwgfOhp/2ij9lnaA+c2M8qIuZDMTiHP92piX+EKP6bc=;
 b=Na1GW9gtGYxQdKxYKDpzMnn7Q+zFjFjyj40uaFbCn9Jg5LEUbBrSsgI2jXSNBObyu1
 ZMVdrUtZugi1WceWBLrwRUfKLZYG0LGQxLXLXyJzloBwH6OSWQDOejdCZHTM/WNJEofP
 ccRGLtI4YeZHWjpKA7LMh/nbpnVcS2gC69J8EYoMSE8k98RINdcT8h1IBcdLXvUU9/1I
 2A6/Zcdp5XuEfjAkriGpllUA8fCaKswuady4jHT7jlViTkfKefvYk7Kdrq4BwIbTpSF2
 pDiwj8ROShffYdJ+K/t5Jh9pyeWFEsxnrFSfyQsUN1JIoC/sPlFQ7wz2+7JoO0nHwBst
 L3Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTYH7xRRRP5H8deojUKPxh8tmqca7x2PUg74wMCifNyFcX6Wep360ov4iDaJabL7ZjpV73O4msMEdQ@nongnu.org
X-Gm-Message-State: AOJu0YwWH65ROcJD7VPnyP0yvqHBLq0U3ci/xLRpjIV6CWER7ucwiWJw
 8u3EZ5yR6wAXp6y5YYUHEh0KfJHZMWnakewjNHfdMY0IQ9gcllPOyW+pPcIScx6KCn8=
X-Gm-Gg: ASbGncvVnYYY5FAWHJAMYhHWgOwCeThGSii8Y6jEIUB024COG+A7Bd543mc1R3cbvQb
 OTlPnowZeQA7hCnhjCGgk8zb9gmAs5KCA5RgECHyBhdFB1agTsDVOwdReofyx+uWrJ2dCWPljgw
 4PWbY5KPn2lwKrI1hWeYHvpl+qrZhoIfoLHzKlrzIlCDgkaFtL36hvPTsfOGawjGlUEGDUiIM5M
 7n42tB3etPzpdpLfNMGyM15KEtsDiSD/+yGys14h3KBOhBOzkQjzAnC4icPaap5/ZX+tb+ZAw18
 mXrXMyLg2nBDIo5dogRB2bevJ/AfKFiTogieum3Cvx3Eaa/mgZPtqwZ3+8ZRfJVI45+be/SgQ7P
 5IVTAStHt7TJPT8W3yjXbwZ6+7escaS7f5NhIzonDNe7qBV4anjVLNYplhp7P2dLW5d4+F7fA+V
 o4Dj0YLW/p77qkqbkxjg7xw3X8iGK48Diz0E1G9JJA/R3Yk6r3HvTrvA==
X-Google-Smtp-Source: AGHT+IERV0oHns6B5iA6/gFiljyOCPcITw+hfzi338TeUN72rBdTfFHuGwofVfnfrX+607kiwGiRgg==
X-Received: by 2002:a05:600d:630a:b0:471:1b25:fa00 with SMTP id
 5b1f17b1804b1-4711b25fd7cmr75003045e9.36.1761040889838; 
 Tue, 21 Oct 2025 03:01:29 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c831asm265022405e9.13.2025.10.21.03.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 03:01:29 -0700 (PDT)
Message-ID: <aa7cde28-29f7-4134-a494-0db6a1cfb745@linaro.org>
Date: Tue, 21 Oct 2025 12:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/43] hw/audio: replace AUD_log() usage
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-32-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-32-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 21/10/25 11:03, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> AUD_log() is just printf(stderr, "prefix: "..), we can use
> error_report() or warn_report() appropriately instead.
> 
> Ideally it should be converted to traces, but there are many places to
> convert, this is left for another day.
> 
> Avoid bit-rot by using conditionals.
> 
> The patch could be splitted if necessary.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/ac97.c    | 120 ++++++++++++++++++++++-----------------------
>   hw/audio/adlib.c   |  20 +++-----
>   hw/audio/cs4231a.c |  40 +++++++--------
>   hw/audio/es1370.c  |  24 ++++-----
>   hw/audio/gus.c     |  21 ++++----
>   hw/audio/pcspk.c   |   2 +-
>   hw/audio/sb16.c    |  93 +++++++++++++++++------------------
>   7 files changed, 151 insertions(+), 169 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


