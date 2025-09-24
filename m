Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F240CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 20:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1W8O-0000ii-OQ; Wed, 24 Sep 2025 16:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1v1W8I-0000hn-Kd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 16:30:37 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1v1W86-0007Ys-2q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 16:30:34 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-63497c2a27dso157463d50.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758745817; x=1759350617; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FTuDQF9zXmn9U0UoAIk+2JX1nQHHEydEwUFb5dgsHgE=;
 b=AfQvujr7L503s8hW3CBurQuEBP5FJ0pP9L6kbrwLDZ/AshoL4E906pmgK359LVOPkO
 pI1OyhZQ5yFxWLQQuFm+7OZ2XmPxAaFaayZSAZLMV3PosXeNC1yfs1m2LCxa/oC48wKw
 rCh5i9J3T0ymIqKajdzACFCfiaOa348sAJb62o7jMS7yWnTPo4mwdv4FtNfPOEUHGpS5
 WGKmHSs5uP4OzgvXRhyDUCG6/sQnJ38ATxo/6VwPthkXMPREZMWjGmPcMvhfeCvbOJWm
 udnBu0bKNLP7s2CYpXQPpbaRGXGTUmAGshJtJDQ1C7uBuBrD3U0GNn6OyFXGsClKpMWk
 Jdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758745817; x=1759350617;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTuDQF9zXmn9U0UoAIk+2JX1nQHHEydEwUFb5dgsHgE=;
 b=aBqZotcSfSPn0FMPTgv5LqgLWTB6IQ3YsobsCvHTU7suuw1dvwoEu1InCHqBJsVuJZ
 KjvN2hZzK1KPPZFujcxrU+1SY29tM76zZyxb4tQUwjefkksQOsspQIlDrp/vftaXTqlF
 XIekFO8cqzqXQ/s+F97Ujfl20/P+bnAfFdQ0slpEuXlhmHd83ZKutwCbrZ7BGY+azBNf
 s8yCN0Z1JjxM1TunnjBCZ0YiYw508X9+mWsj046HVTS2oj25PwwbplDeQz7F6U8ehkgV
 tBnRTpChge2C1/dg7gVMmlwSPlIDNWs43JtLgntzq3pBiLNMqbuSdB5IvQ6Rgsc96NEU
 pL9Q==
X-Gm-Message-State: AOJu0Yw0B+EUOWvY8luUW0mmRdbIYcf+IJ6nQjRawhY9QI+nRYxVwn2s
 fAjXQc+RKUAygvnlVKN0S1zv1/jGcSg2UqeJgu85RA0WFhsiBaLR/RYjI/G6FYINCEk=
X-Gm-Gg: ASbGnctOJiQ2blAc8EyAZ7wDKUbwMgaT7A50o1QEHiQbSdqiMhGHCzqu4ziR/0W/og4
 2dvpQKJJ9XSY/1QlRyCmsL7mR3h14P0C5f9CObrwupJurJ/lqT16i4osmAeyVKKKUETqdA01DDi
 btSlUblGj0VdfwSqfxyS0sWVnPg1yjQH1ovcaeJhh64TyEZShrDBaE0verwU68IvGNnGaumBdEL
 K6WLONuWO3KcPGR9hhvNkMLeeNF09nvh0fiMUoGEdsBpAT7T2djk7RLeCMLxJTSSHgcmnQKHeYl
 sweteOYr9oSKgilwLC+Gdra+0Y7GTKRqBAWXVaP3bQX5r7aF9vgUmMhPcu72Xsz9vNnOeJGyB28
 mnZ/TkGNVqHj3M2VRavWpv8FNXmCfeTzWNNs6o4gXSg==
X-Google-Smtp-Source: AGHT+IEo0ToDd65nMxjcKVOrJipoOYGWZMMtv6EqZuB8UfsIU8JhhQfds7+U5HDWBzi3XFjdfUf3PA==
X-Received: by 2002:a05:690e:160a:b0:636:1784:c5ff with SMTP id
 956f58d0204a3-6361a7156eemr594115d50.11.1758745816843; 
 Wed, 24 Sep 2025 13:30:16 -0700 (PDT)
Received: from localhost ([173.23.183.85]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-75210e5afa0sm22166757b3.3.2025.09.24.13.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 13:30:16 -0700 (PDT)
Date: Wed, 24 Sep 2025 15:30:15 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] target/riscv/kvm: Use riscv_cpu_is_32bit() when handling
 SBI_DBCN reg
Message-ID: <20250924-56f55a61a8428438eb6252ce@orel>
References: <20250924164515.51782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924164515.51782-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=ajones@ventanamicro.com; helo=mail-yx1-xb131.google.com
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

On Wed, Sep 24, 2025 at 06:45:15PM +0200, Philippe Mathieu-Daudé wrote:
> Use the existing riscv_cpu_is_32bit() helper to check for 32-bit CPU.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/kvm/kvm-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5c19062c19b..187c2c9501e 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1588,7 +1588,7 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
>           * Handle the case where a 32 bit CPU is running in a
>           * 64 bit addressing env.
>           */
> -        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
> +        if (riscv_cpu_is_32bit(cpu)) {
>              addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
>          }
>  
> -- 
> 2.51.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

