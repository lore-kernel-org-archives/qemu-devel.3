Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418DDECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snv72-0000gj-Jx; Tue, 10 Sep 2024 03:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snv6y-0000Qd-39
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:16:28 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snv6w-00011l-C2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:16:27 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d6d0fe021so169578066b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725952583; x=1726557383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WMpuYTM3BY/R4BIa8OIB+TBg60VZ6qIbSVsTmOAK1C8=;
 b=yd/OkvaxwDX314ZoQEYV9JD375SMEoOrgt7SEnS0+6KkywIVMKRStntqgmnL2ZqMWA
 lA20L+ZpLIPzv/668efiddJupGChkxU3j+ylnvwCwwjs5Dsv1+nU3dSRyHzogiCnIEku
 bBEdsuUUhEXBRzXL/cjmhoEPedp6oUTm+ECz3ks6fGXM+PIEeXeG/ElgdGmX9RJzcgWg
 UP1RX9OiWFH8AG5HH0d3L9kscWsuMzCUZzvPeIMs6pm/3kFPQ21lCbPj89+l5BemVsT2
 Ul7LnSNSfpn+JwWN6FjaKC+4tJs4/8b+hovcn6IslkRunP4qnL+cuPhMr7R05g5UdiE9
 Ytbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725952583; x=1726557383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WMpuYTM3BY/R4BIa8OIB+TBg60VZ6qIbSVsTmOAK1C8=;
 b=NWAorJ6AT7nDS6F0SM6Vb4tchoYgLI8WyrFGmg8BEGlV7aT1jwhizU7pCAslU3AVLa
 g8dPRDeFrFVhxuaTZ4pKagK8EhQu65T4z5PmAyUlYd+lEsM5SWtWxfpIkpX4OmT2EG0R
 wnQRMIXqsC7j8DD+qu7MSwXh0hNEjdJJ56Hh7UOV3t/cNJW8TffK31nGwwp2JN/R6vHv
 grIkeCZox1X4/EL65X92RnaVxwOP5z1CB20e0cwtkdqlHJqKvdNldKkM9ekYti02laQ2
 pKuWKCcEXofUh6SrIjWjT1ctUQt0eGFPRAXeKkudUqspTgCgDhSMHp2iGsQexED+XeNt
 /0LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdoXpfEJt96vhJXWeapijQWXbYvlKGYXU/OHTsJRdp2Xu6ImwFmtY6gEhOIfpn/CbgYvPKZb7UcZJJ@nongnu.org
X-Gm-Message-State: AOJu0YzsQ8f7RoqDKY7Dub2/iLTlNrcTS/DcLEKU4LMZAljyrWdeopFN
 dzPG0yyuWtFWbXomqW6qb6PYfgJ4eMkMc4lcX1UL8EhtQ2Mr7cFSQzRuPZ22b3g=
X-Google-Smtp-Source: AGHT+IG6LkhkWQwkIHCrBmKGHYF/uVdmN56ShGQj3DJCtNB7ZLvl81bd8Jd9qxmRtgVSns7vNL3khA==
X-Received: by 2002:a17:907:1c1b:b0:a7a:af5d:f312 with SMTP id
 a640c23a62f3a-a8a887e60c8mr982735866b.46.1725952582939; 
 Tue, 10 Sep 2024 00:16:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c727e4sm437636466b.126.2024.09.10.00.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:16:22 -0700 (PDT)
Message-ID: <998e3864-f091-41a7-8616-3f2e5357d059@linaro.org>
Date: Tue, 10 Sep 2024 09:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hw/char: sifive_uart: Print uart characters async
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Cc: Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, dbarboza@ventanamicro.com,
 Thomas Huth <thuth@redhat.com>
References: <20240910045419.1252277-1-alistair.francis@wdc.com>
 <20240910045419.1252277-3-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910045419.1252277-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 10/9/24 06:54, Alistair Francis wrote:
> The current approach of using qemu_chr_fe_write() and ignoring the
> return values results in dropped characters [1].
> 
> Let's update the SiFive UART to use a async sifive_uart_xmit() function
> to transmit the characters and apply back pressure to the guest with
> the SIFIVE_UART_TXFIFO_FULL status.
> 
> This should avoid dropped characters and more realisticly model the
> hardware.
> 
> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/char/sifive_uart.h | 16 +++++-
>   hw/char/sifive_uart.c         | 94 ++++++++++++++++++++++++++++++++---
>   2 files changed, 102 insertions(+), 8 deletions(-)


> +static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
> +                                      int size)
> +{
> +    uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    if (size > fifo8_num_free(&s->tx_fifo)) {
> +        size = fifo8_num_free(&s->tx_fifo);
> +        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
> +    }
> +
> +    fifo8_push_all(&s->tx_fifo, buf, size);
> +
> +    if (fifo8_is_full(&s->tx_fifo)) {
> +        s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
> +    }
> +
> +    timer_mod(s->fifo_trigger_handle, current_time + 100);

Preferably using a #define instead of this magic '100' value (no
need to repost):

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +}



