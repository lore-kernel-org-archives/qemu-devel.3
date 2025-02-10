Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04475C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbkx-0003Cp-S1; Mon, 10 Feb 2025 16:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thbkq-0003BP-SY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:55:49 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thbkl-0006ZP-S7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:55:47 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f7f1e1194so51031995ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739224542; x=1739829342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EB8wNvdrHW8cKwkJWprogzd09c1jUUh+Kcirc2bmyrI=;
 b=Vsw5Zq+2hpeLaWpq3zeXr68RFV1bbiwfzNkfLKYJQaiSKHFYLMhJ2wFalnOICRcJ8V
 NUT8TJ97ud7mYRFXNBXig+eP8PlFfCl7h99clJY2o2uHt9Rs9IyEplIVWpOJSprDUUHX
 rbptASNTDT1xJoB1j3QFyIwy5Wp73tybcyaXQgRr/s3kf6gqnV+8TOn9eXo24Yirb4Q8
 8D+uRwhUlQRa/r2ns+YC/mkV9wwkkGyg+BDvsd6kJRzl19Cu6aIsWtEUEnD5fPO4JzSf
 XTLyx3cpctE0MVX9Mx2FTxuBz8XXYdnTz5j9yJEFrcaIxAwNAti1p2Nbw3niEk5iGTOn
 aa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739224542; x=1739829342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EB8wNvdrHW8cKwkJWprogzd09c1jUUh+Kcirc2bmyrI=;
 b=if7OdiLVcqbM452zdUHDcZSXKmSIaueWJFpetbaA5V6QWKqeePUgLMz/s4cWedNjM2
 senW5aSpskzLLwwJxNvqAZ7DxQAPls0XAWWOakpOs8e5DV1xs5U++b5KGlbfkwBo/axp
 KZzKaEFZWrSw+oawHfqwx28fuKK8gae8bp7ElhixsY5Q2DpAYUu3hCXg6cPAr+DKjK8n
 mTOqfOyzR3w36fr1V/EwidpO2cUPhAqR1Tc2YpzONCCYiuHCUFugVbEuj6l5du7NxAGW
 kEP89pZYk0YQ7R5cZ3jTNsJoh133/q9niAcFmYDZulF3iAPLAtpt2EgLBKOMhTMyKyQK
 Xy3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX0j8dprgychyJU04Hjl5MaRB6LiAKBk/q8/eDY8R0HVGbrnpH1yf5QWNW5dG2lyrQFui/o4zM+XLq@nongnu.org
X-Gm-Message-State: AOJu0YwU8lWjsmigQXonidLzpUgJuiv8WdHyBb4JtBs4TP6Dg4htGtID
 yyRs6IQ8u1ygOr0TtX8Zal6UtlNZT9BQlwHxizMXuRYLS84yqt77BhAWTCH++XE=
X-Gm-Gg: ASbGncuDNTvWuRCxCulo1zsvPUYBxImOGSsJV4dZoNUfEZrHNxGjvez+O3m6rz0mof9
 /IMAEvcsVuX1DZdsvSOD8+C7GjOv61NAX6Wr8OezO/VQeAdiOuIDIDJ30IpXsElxVqHD1/YZAA3
 EENJBM52Mt7rScPI5bpysbBgtDtkZ61qCexn2M7y3QO5x34SltYWguxbbFNPwlBEhI0l2cnbkDv
 LG+yp8hJpGhjQbYhvZQp12dY33bnELmUOklFcq7/tRejf5VvoXPOQ/wgbNe/5C+4qDTScMXlOYu
 XR8981pt+xm6gYhiNCTpt0BJ0+AuDv8vLnMR2cgOxXrdvOeCMwVxsM0=
X-Google-Smtp-Source: AGHT+IECMRarfMDCqkErNLnAUNgtkgI0F66aVyKROltcd3fRaEfiTY+Q8pzv4D9kaPpn3XQfcfPimQ==
X-Received: by 2002:a17:902:e945:b0:21f:b483:2ad5 with SMTP id
 d9443c01a7336-21fb4832b7dmr24393175ad.20.1739224542418; 
 Mon, 10 Feb 2025 13:55:42 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f36561397sm83910685ad.89.2025.02.10.13.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 13:55:42 -0800 (PST)
Message-ID: <51fc4c66-43b4-4b19-8241-ec0af2d78355@linaro.org>
Date: Mon, 10 Feb 2025 13:55:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] target: Set disassemble_info::endian value for
 big-endian targets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210212931.62401-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
> Have theCPUClass::disas_set_info() callback set the
> disassemble_info::endian field for big-endian targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/hppa/cpu.c     | 1 +
>   target/m68k/cpu.c     | 1 +
>   target/openrisc/cpu.c | 1 +
>   target/s390x/cpu.c    | 1 +
>   target/sparc/cpu.c    | 1 +
>   5 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

