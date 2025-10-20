Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF90CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 19:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAvRk-0001se-Lb; Mon, 20 Oct 2025 15:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvRf-0001sF-UD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:21:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvRc-00050W-SD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:21:27 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so2778213f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760988083; x=1761592883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d5oX/dVngrWwYgEAjMZ5eA0XwcyGfjsg5vZuWHlLquI=;
 b=kcnoY13+EmYxRZ1Kd354PguS1fUkHYfj0SLWGxtQxdMN822N/4XucsO0Jm2UnvYgrW
 KGlU5LHXF5CZ83l+POMSJacQbsVaLmL3bStnb5ASomSA/t95NqFHRATH9mi+fileR83h
 zA5WOxL5gcV/dV/0rNAIe2UT7tumegoYfGC3RBMWG2GzdVQZm4aCYnDqnyjB4XGWBuc2
 HYnhWw/C3IHfMrx+9FCBzYEWr8MvWl+eBRxzZFPL60pNqbtmVI5fQnMhAbANR+lZRT5C
 XhASb5bpkKnJEJY39XfRikbqn3pXn0RoMwyAbm2Z/kfYyFaS5IhIcUggqMOon5Olw+aD
 7kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760988083; x=1761592883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5oX/dVngrWwYgEAjMZ5eA0XwcyGfjsg5vZuWHlLquI=;
 b=mD0389oqOYpGBZW0dIuUZyuQzevIZRfURSiGswsagl1XY40JHk+7RTNVF5rzdky0k6
 AqEpGVix4upmn3YhMbZUzZDFZsHCIimR4e3mCDrtDurl6dF4eMw1yPeoSFq+GKFOoNX1
 bd7w5ZlSITx7OrYkb4XBw+g6e6VidANaugpPqgTdcJcvKznASsUOh0wwPAprtfKuFW6F
 7GCm2jMsrSTAlWHTJtGFlBs3S1zDj/IpDCbBgIZMDj19DzelIgJW7HJ6cj035SX20U6D
 dW5QsaBr/IX1CSynodBXalN2wSUv+7oJTSNXEwFlNVcC9j3raN5Pw6c00dYRwnPLr4F6
 Pn3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKbr4bHdkZs1krPEJUNLvKHlVfBwOOVxDuVy0x6Cqelto/ZpyoOAR9kW6EMQvxRPy5m/75zNxCJekr@nongnu.org
X-Gm-Message-State: AOJu0Yy8Da6HEaivC/dhVhze0r2YykABKCipWCcmiQI9EZNGzrnslCHm
 1SsEzDUawO0UoRYt8saBhTDZq8NshmTeLO6qNZTLkplSCQ9l4g32EoGfFff0E+oq4uw=
X-Gm-Gg: ASbGncvZo6D+th+36H4ucxpT5RrUZUsi+DojB3VpeyT2IqHTUx21ZH6h3R6yxubTrYB
 tzVXuQIpXZkUFKGAwpc2ECuJcukWcwitVESfg3XHSndh0IzkmKsXt9ndOHzsz8uapwCm1vT1Niq
 +lr8KRXCHYeULyZu9anqq9NDOKdyajukmIQfgWrvX8yGoKnXsPR5gG3g9YFzJhMh1MW9YsZdSdM
 q+wEVRhuU1FA6ikdr5oy1jo18xGoT2viBBdLrQBxx+RoCLEx2zzmctevfXHNftGvs/gV/NQT78V
 STIn8LEq6NW9VwJTF9txinGCnfApNX2RaSxQH/ZnbDH8prPrXbVbpmZqu9+TM5udV868mI/k7Ex
 96zU7ICagDR9gOBaoq35Rjcb0+jU7K2jECA+KQgBTkCc9SCHUINmEHEUo2VPFzblQ1MfdOY/YTu
 F9sdp4PhxNuqtS+ZnznIKXeiw4mt0E3dZvoAo9sAfvb+tlNsN7eXaZ1A==
X-Google-Smtp-Source: AGHT+IETbkaajZKDtUvfodjkEB1/bVdY7KitcQzgE5FtPzHYIDW7MZbj31ih3AE87xH+3f6Owm8xDw==
X-Received: by 2002:a05:6000:2008:b0:3ee:d165:2edd with SMTP id
 ffacd0b85a97d-42704d78cccmr9062200f8f.28.1760988082712; 
 Mon, 20 Oct 2025 12:21:22 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427e1be5d6csm16630489f8f.0.2025.10.20.12.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 12:21:22 -0700 (PDT)
Message-ID: <b2a91079-f6b5-4bb5-89c3-18307481c7a9@linaro.org>
Date: Mon, 20 Oct 2025 21:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/riscv: adding support for NeoRV32 RiscV MCU
Content-Language: en-US
To: Michael Levit <michael@videogpu.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com
References: <20251020181435.8242-1-michael@videogpu.com>
 <20251020181435.8242-2-michael@videogpu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251020181435.8242-2-michael@videogpu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Michael,

On 20/10/25 20:14, Michael Levit wrote:
> From: Michael <michael@videogpu.com>
> 
> 1) Initial support for Neorv32 soft-core MCU
> 2) IMEM, DMEM memory regions, bootloader ROM
> 3) Basic support for UART0 (no interrupts yet)
> 4) Basic support for SPI
> 5) Added SPI flash memory for loading firmware following  bootloader
> 6) Based on Neorv32 RTL implementation repo
>     https://github.com/stnolting/neorv32
>     commit id 7d0ef6b2
> 
> Signed-off-by: Michael Levit <michael@videogpu.com>
> ---
>   .gitignore                                  |   1 +
>   configs/devices/riscv32-softmmu/default.mak |   1 +
>   docs/system/riscv/neorv32.rst               | 110 +++++
>   hw/char/Kconfig                             |   3 +
>   hw/char/meson.build                         |   1 +
>   hw/char/neorv32_uart.c                      | 311 ++++++++++++
>   hw/misc/Kconfig                             |   2 +
>   hw/misc/meson.build                         |   1 +
>   hw/misc/neorv32_sysinfo.c                   | 183 +++++++
>   hw/misc/neorv32_sysinfo.h                   |  79 +++
>   hw/misc/neorv32_sysinfo_rtl.h               | 134 ++++++
>   hw/riscv/Kconfig                            |   8 +
>   hw/riscv/meson.build                        |   1 +
>   hw/riscv/neorv32.c                          | 219 +++++++++
>   hw/ssi/Kconfig                              |   4 +
>   hw/ssi/meson.build                          |   1 +
>   hw/ssi/neorv32_spi.c                        | 504 ++++++++++++++++++++
>   include/hw/char/neorv32_uart.h              |  68 +++
>   include/hw/riscv/neorv32.h                  |  60 +++
>   include/hw/ssi/neorv32_spi.h                |  70 +++
>   target/riscv/cpu-qom.h                      |   2 +
>   target/riscv/cpu.c                          |  18 +
>   target/riscv/cpu.h                          |   3 +
>   target/riscv/cpu_cfg.h                      |   1 +
>   target/riscv/cpu_cfg_fields.h.inc           |   1 +
>   target/riscv/cpu_vendorid.h                 |   2 +
>   target/riscv/meson.build                    |   1 +
>   target/riscv/neorv32_csr.c                  |  54 +++
>   28 files changed, 1843 insertions(+)

Thanks for your contribution! However I'm afraid this patch is too big
to be reviewed without missing something. I'd suggest splitting like
the 6 bullets you enumerated.

> diff --git a/.gitignore b/.gitignore
> index 61fa39967b..b53806de50 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -9,6 +9,7 @@
>   .clang-format
>   .gdb_history
>   cscope.*
> +phases.hold

Not sure from where this file comes; maybe a shell typo?
Regards,

Phil.


