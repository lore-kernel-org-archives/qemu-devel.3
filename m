Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B206C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsWK-00074Y-Nx; Thu, 25 Jul 2024 03:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsWB-0006z0-NM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:04:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsW8-0004UY-2N
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:04:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368663d7f80so266169f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721891038; x=1722495838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H4M93FJiPvKnadIFgy3DbklKDZpChkQ52QgIglbhsUg=;
 b=V32Mvlce9QtPLE4L92pYfOhUf/mcUuOI+a+GBp4UtKLz8jQ7jDdllvzNPDubK0xSkN
 6GBcLMo6wx3o9V9r46n3nogxhCa2doh7RH7O4x0QC/6MZS443NDnMgBaRrhYIuQWtY6y
 phPR3xFeGo/Na7HyxvZa0id9iO+qgT0F1x+Qd5Fbx7aZnO0qI5oAeoi+8siJUNzvQIJJ
 8NVkDt8YEE4aB+Bz0cUQzK1yda4llJ0lxlc0GQXXm2NAZ9mcBUYEgObIalUmuklAklDn
 KNwY350Ll/THSqTYD0nbmjziBkZfc9N/LI2PF2IYKerrbMeBUUS/Yvzhzhua4R+phqZj
 EvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721891038; x=1722495838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4M93FJiPvKnadIFgy3DbklKDZpChkQ52QgIglbhsUg=;
 b=QIEaKLT/4cEMKVMhhLqs6Glai4jTx3DGnbMbbSQaw7ohppitMl3xpxfcOrwDbFfY2X
 7HBhM02KY7AVjaG3VQicIW/LWWOhAlVSIYRHoNykf8APKcrFzxftqS4V3sKGbLvHf8vH
 iiO/xyuXcG/NsIHivV0Sj07FVOrVzymIiQIEyaJ8SB3wv9k3Cte/JX0ENmJvEOhKKE8z
 n65Xxhu53pVObdVrQ30WSdb6N+4Dk60iskFLVJpZJKr4QWHSCxyUKVPBKC4746Zz+Kqt
 LUAROcmR+P4P70Igfe6gU5kwIAB0UaM6zQn4FBe73PxCjPQVljKrTp/6SJd05QByuALS
 1SWg==
X-Gm-Message-State: AOJu0YygRT3+ssZKeYSm8OWTbRX/AQQ3/YPZl6BDv6iv/TaX7pZFUzsq
 EvPfBHx3UlnhOGajLqJ6xSW2fOZMac+y9dhwLnh7ovOECjk5sv+/q9H+eQmQJ3ypI1IwcHbVtll
 N
X-Google-Smtp-Source: AGHT+IEopzO2Gm+jJ76/WlHmCYKFTjAdKGS8dyVfRleKbOq+a+6AmfGE5eJsluWBcL3yPOBVHNUl/w==
X-Received: by 2002:a5d:457a:0:b0:367:91d8:a1d2 with SMTP id
 ffacd0b85a97d-36b319f27fdmr1237561f8f.30.1721891038058; 
 Thu, 25 Jul 2024 00:03:58 -0700 (PDT)
Received: from [192.168.114.175] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36800cdasm1091329f8f.64.2024.07.25.00.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 00:03:57 -0700 (PDT)
Message-ID: <2eb95ab8-a89f-47d5-8fdf-e6eabefb0781@linaro.org>
Date: Thu, 25 Jul 2024 09:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/riscv: Remove the deprecated 'any' CPU type
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, devel@lists.libvirt.org,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240724130717.95629-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724130717.95629-1-philmd@linaro.org>
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

On 24/7/24 15:07, Philippe Mathieu-Daudé wrote:
> The 'any' CPU is deprecated since commit f57d5f8004b
> ("target/riscv: deprecate the 'any' CPU type"). Users
> are better off using the default CPUs or the 'max' CPU.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst       | 13 -------------
>   docs/about/removed-features.rst |  8 ++++++++
>   target/riscv/cpu-qom.h          |  1 -
>   target/riscv/cpu.c              | 28 ----------------------------
>   4 files changed, 8 insertions(+), 42 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 88f0f037865..0ac49b15b44 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -347,19 +347,6 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
>   which the 9p ``proxy`` backend currently suffers. However as of to date nobody
>   has indicated plans for such kind of reimplementation unfortunately.
>   
> -RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -The 'any' CPU type was introduced back in 2018 and has been around since the
> -initial RISC-V QEMU port. Its usage has always been unclear: users don't know
> -what to expect from a CPU called 'any', and in fact the CPU does not do anything
> -special that isn't already done by the default CPUs rv32/rv64.
> -
> -After the introduction of the 'max' CPU type, RISC-V now has a good coverage
> -of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
> -CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
> -CPU type starting in 8.2.
> -
>   RISC-V CPU properties which start with capital 'Z' (since 8.2)
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index fc7b28e6373..f3e9474a73e 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -850,6 +850,14 @@ The RISC-V no MMU cpus have been removed. The two CPUs: ``rv32imacu-nommu`` and
>   ``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be specified
>   via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
>   
> +RISC-V 'any' CPU type ``-cpu any`` (removed in 9.1)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''

My bad, this will be 9.2.

> +
> +The 'any' CPU type was introduced back in 2018 and was around since the
> +initial RISC-V QEMU port. Its usage was always been unclear: users don't know
> +what to expect from a CPU called 'any', and in fact the CPU does not do anything
> +special that isn't already done by the default CPUs rv32/rv64.


