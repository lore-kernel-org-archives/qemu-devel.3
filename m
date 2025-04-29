Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EACC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9of5-0004eI-6E; Tue, 29 Apr 2025 13:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9of2-0004dO-Ty
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:22:24 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9of0-0001H8-TS
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:22:24 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b13e0471a2dso4674913a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745947341; x=1746552141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GmswRc/9cjetn+duPTwa7APLS1WPCJMUloVoq/rScK8=;
 b=Mg/VEFNVLo/M5Y4nvmMgYp5oKEMwvjYt8M9+x4bAbt6pwYrxZAb4hBYSth6NCqiGx6
 IQjhPQcmzxfByA1n1ofpAQR2MWKY68e8Ho8poAzW84zxTgzXp1wzzglARx/NWz+eOrf2
 UkEQ6HMXuy4Or1s2lOoOa/eJM60tflSZtjYTU2zru8kgbSE/bVWEB1XkcqHaWl8H6288
 SCc85oQFIY/k+Jd0isCA4NXaJCdJ9M+G9sUXZRK3TBQyhiEyqkz9/Oy/vU9wWW6q6j4S
 MYFYdqITslgkiExi5Ioqk6F8bFQCfkh204++qai8+lADamCxOhh93z7z3UtUYl5Wv2FN
 9Axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947341; x=1746552141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GmswRc/9cjetn+duPTwa7APLS1WPCJMUloVoq/rScK8=;
 b=J8eP54ahWsxg7kwVpH1lFwM0FMfJ8tMMFNymS8wXQuvb6td9zZl6ZqiWm54ix5TaN7
 gsz1xMsPzLX3zU6UtuPNWXPkF+KAVEJ4oNm3jRnXq07wn23CtoSa2Ru5VUES7OA78atg
 94AJam5XVj9kp7hje8tXDgzwknPCXhWrUAE5zIIRW9zb9VTQb7biLVYLuzhk7hrXt3B9
 tgMwaSuA7KnBx4Z3ZhMrOfjiDC95+A+mqLOoYd+TGpLt3WIazhtIFb9hIa9mdx9mlV7n
 P9i7ca+OsNrBGZ9qIH8mERtq+7FIsc2tFR8GSkPUTxW2FrZsYbxc5/INLN6r26Iw5b5g
 emaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjQhhN3oJmp8H81KtURzN61cv/7XXih5HBx52OP0MIBd+fuBpYxZCX/2fGC4imdXolyrOGhACczJ9Z@nongnu.org
X-Gm-Message-State: AOJu0YwWMJvN+zEjvL8I9nggjJFVPsNVMh3GMan9T3jc4epgZgKMz0Zr
 voIJ5gqYujBadcJmhYb1BDPb2RU6DQrmEEJ7delt0+AKdBjTC563fDdnhQi8PCQ=
X-Gm-Gg: ASbGncvGwniG9VzNZfT59HzRnlo3zv6z0AMR8peEkKBdqZVf7mI0q4z47JTS3bjqOr7
 /xXY0Y5iH0HOC555grWoxYcEUABSa0FeRRzz6yc3T52FD3bm6M5r6UoJS+3qNyfe7Zt0gLpEPgz
 a8wd/NRU7SwsyWq+pjQN1VAldS/LnchRh9q++x3Iw12Yc3gS4uVVbmdIKvekrY8lQTLf2wW1+1Z
 LvJixZTa4tJqi55Ti5WoLa5PwvW1oDRnZqtPcyXlAsslC8le2mEKjGZWX9FGtgbUYTq53Ku50X9
 WXKFnGxL5YBl2PiavzysT+uJhV6ZdW6UtobypI5tHBqtKyBced5xoSc=
X-Google-Smtp-Source: AGHT+IF++3fGKDmAFrE2VkrjAd43g9IFHT24xRVs/KGbv3Xl3qAnxMFxJ5XJM9hOy7QbgX8/wuVKUg==
X-Received: by 2002:a05:6a21:600b:b0:1f5:83da:2f9f with SMTP id
 adf61e73a8af0-2046a43086fmr18740303637.12.1745947340953; 
 Tue, 29 Apr 2025 10:22:20 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f48a7sm9286727a12.9.2025.04.29.10.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:22:20 -0700 (PDT)
Message-ID: <42d5b9a0-aabf-4c37-ad0b-0701ccdf9667@ventanamicro.com>
Date: Tue, 29 Apr 2025 14:22:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] hw/riscv/virt: Use setprop_sized_cells for clint
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250429061223.1457166-1-joel@jms.id.au>
 <20250429061223.1457166-4-joel@jms.id.au>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250429061223.1457166-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52b.google.com
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



On 4/29/25 3:12 AM, Joel Stanley wrote:
> The current device tree property uses two cells for the address (and for
> the size), but assumes the they are less than 32 bits by hard coding the
> high cell to zero.
> 
> Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
> and lower 32 bits across cells.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e4c0ac8a2a9a..873d41d10c70 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -346,8 +346,8 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
>       qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
>                                     (char **)&clint_compat,
>                                     ARRAY_SIZE(clint_compat));
> -    qemu_fdt_setprop_cells(ms->fdt, clint_name, "reg",
> -        0x0, clint_addr, 0x0, s->memmap[VIRT_CLINT].size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, clint_name, "reg",
> +        2, clint_addr, 2, s->memmap[VIRT_CLINT].size);
>       qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
>           clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
>       riscv_socket_fdt_write_id(ms, clint_name, socket);


