Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147C6D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 20:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t841r-0007WI-2S; Mon, 04 Nov 2024 15:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t841p-0007Vo-PK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:50:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t841n-0003me-6x
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:50:25 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so3138043f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 12:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730753421; x=1731358221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pMMxOBw2dh19te8EtH8Ezcy3wzinirkjVOWhdgBBZcc=;
 b=AVP50W23rdeUDybfD3+gvwK6s4ZvcklgWN6Da5S4PRIs7SXM+wcPZCs8zbzpyEPqg3
 ZLHSjvvdN2fwDZ7V8GlyvKlE/rQIdkO+Z0ryf0lRWe4fiI0ATGN8R+j3NwMkR0JOByzW
 5OHfPCeJGegj6+p9eM12oIM8E1fM7f5UvcIubJ2pE4vqX0G8d2uHgrScpa/gUnhSIXkd
 GuQ+XFgfrrs3cX2xYPFRHG/ghogO1igOwEvpPSYx1A5j/1Gte0I+Urc1ysQXc/6SiTn2
 IukT47ze/9M/910yqChqI7pB7nfsn7mg9Low1lSqd8BF7GUHFNcJaYaDCk3OOVeoHAHb
 1DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730753421; x=1731358221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pMMxOBw2dh19te8EtH8Ezcy3wzinirkjVOWhdgBBZcc=;
 b=lKJKtBd2PILWgOa2vA3jm265eKpHLD4KKGHXJOzGJuBAZbZJTSqgaJfrnM6tIpZanP
 2dSYgcd8nlYpDMaFupkJS+0vmepyFp7PdHDOOfkJTKlIXJXi1HThMaTRkxF4XtWvDP+u
 5Wp2XkMTN3CE8d5gvjKPxDb5k0jU7STSObPrLbALWEzlKHhefkRIKguwk7E2q4nqbPaY
 sM7SJM+NKwYqjTSZ15Lt4pzg5HiXZ9f9B2hxxeOlFNerXtfb/POKrD7ryRzKHJJ3TKgz
 zlNhUaRm9Yff5DNSQNaYvazkM9I+UtPxNBvJ+ZGmhgJxxVi5pD7hOpqsnZM1zAz4ZJpq
 /ixg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0SBrfnhWhdA0r7pEO3gbX7gzW930v75fYzqVaNapncVGuZLl2lAjaO7NkTO6JW4xP48mwDgxkt1+K@nongnu.org
X-Gm-Message-State: AOJu0YzG3omTzda6HDrIz+0kEDguRYrjiIC/52t6C7wJ5Wn+j4OVVZLG
 dajghJOxh+pO7Ry5k/axith49Jkn8Pag0Mrug4ffnQ7rpCmYDczzNrgK4EJh68o=
X-Google-Smtp-Source: AGHT+IE0CZNppMuuiYeNhmcmTQyGJhw5PmF5Sx3MpQB4+LDkChNCshQsFn01HrTYxRYAGTgm77R9tA==
X-Received: by 2002:a05:6000:1865:b0:37d:460d:2d07 with SMTP id
 ffacd0b85a97d-381c7973ad1mr10363456f8f.10.1730753420993; 
 Mon, 04 Nov 2024 12:50:20 -0800 (PST)
Received: from [192.168.69.126] (juv34-h02-176-184-26-5.dsl.sta.abo.bbox.fr.
 [176.184.26.5]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e7f33sm193810075e9.6.2024.11.04.12.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 12:50:20 -0800 (PST)
Message-ID: <b2f85535-3f5d-4045-8b6d-2073639feb8d@linaro.org>
Date: Mon, 4 Nov 2024 21:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/sifive_uart: Fix broken UART on big endian hosts
To: Thomas Huth <thuth@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20241104163504.305955-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241104163504.305955-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 4/11/24 13:35, Thomas Huth wrote:
> Casting a "uint32_t *" to a "uint8_t *" to get to the lowest 8-bit
> part of the value does not work on big endian hosts. We've got to
> take the proper detour through an 8-bit variable.
> 
> Fixes: 53c1557b23 ("hw/char: sifive_uart: Print uart characters async")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/char/sifive_uart.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


