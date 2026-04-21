Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED102F327A3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3yS-0008SC-PF; Tue, 21 Apr 2026 01:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF3yR-0008Rh-IM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:48:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF3yP-0001LL-KH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:48:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so2767807f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776750516; x=1777355316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fmP8CTD6vOCP+HREEUktPvcUF9dXnZ4Yh2gr86npMyk=;
 b=HZ9SkbEH/EnivwCWjd1w1yYWO3gjXKsZrnSHo5d1mWC5KH+46ko/r9a+LazrojmcCE
 k/zD3gtVS9TDh9fa0L9iJLcR40SkhVHm5brVWeRjGbSjZt40S/UNw77STLc1+5vxLVdw
 dZIiXdx0mO2MZY1+e8WPkLOS4RxCpjciQOpuW5418/UpofidExD0hDo1qMpLmFypHE3U
 uTJ0i24IYDtnUgLxNpLsWKhs3psyH0A9CvLjdPn/g1bR2N5YhAQr7+WN/KxAJexR1x05
 nlRizR8zhhx7SLIjjoXbgH6uCdA5EfuRbr3nrw61RZwBcwe/OodAz2aF7euyNcj0nvwu
 zOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776750516; x=1777355316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmP8CTD6vOCP+HREEUktPvcUF9dXnZ4Yh2gr86npMyk=;
 b=GSO7GB5PvQpjrwCvXBhJGqC3IybIBJjTX/Imuh7kFaL3zb2H3AF+CqWzhf0GSdie/f
 Y8hp/G8R44LnmpQJ824b2zaDazLMTGU/Kq2ZKoxk98k1Ov5HtcjqLwvFuQfgBa2iccKN
 kz8FWkbNPsi1bIe4ilEEyDZw8yvLnlBV9CTAO9q6a7ff0FZOjdUmOiMVD+PlVTGaRlhe
 huUo4rmd01+1alXRWWEXlUOhECM3rR2VJCq4XH986tZ4YokGBPpS7xVduD5/ZY0wV0W5
 2tFv0DXhclhZcPir1Fpc5mIHv9epZBmIkh73YTrvjCIa7PribwqFwvxn6Kw1eiNGZGzC
 TZ2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wpmt4kLIGuSiFtYwMviE+HdmKY3nsa1DciPkRfBHvxr+1GF1VZMF/i0BoIZ4ijgwAsYnoaw8HWVfi@nongnu.org
X-Gm-Message-State: AOJu0YxMRw3JiUPeOHMmWS59SrT0OEqy8p55mQyi9dGHsfEkMIqDVHwY
 2ANtSA3LON3Q1/iZ1BZYo84TFrIyJe+ncBs0iXz8p69d9T9Hq68yNsSCEMAbyxAgnR4=
X-Gm-Gg: AeBDieuncl+7OcDUzrI7is8QO7Sr4YrUBBR2a0Lr5iBMKGQnn5EvEP5jMQSrLLJTFq/
 4/vOXKyIheoOE/ntA9+rH58fEleK+enDOzWaQZnV50LefbPman5HmaIrpf1jYEXrJy8MEHOYHxS
 oEPaU6ZHdnzwxbyqkzZdtrG1e9V1azo0fLOhaR7YNRR61EdfM4n/t08isZELQ91YVzEkYZwVFaE
 MisSMGUu+ungw65nWaQGgHlj7k+isNnpBqGS3U+n5YRU9GBmLh6Mkdh3Ya4rrufGAS75AnjbWa7
 XIB6xf4j4s53xPiE+ibzvEfM0c+sDQhJKNjLQwtN93ZNVZIytGRBTDjwFHLltpNDX9TA+QcuZ6I
 OSFaBLGg8Gz6L6DFztojLt6Bp54WSE3ThDrNfhL8C6XCu7wbWIJ9Fff2CqZuGAWA+QBEWJkJP9P
 i9Izr9IDqNGn6DI7CNgvlylmEL8GssBdDKJ/8LDrGBwWXl6Eea3oIondn2wynaYe7sTHP1o0dX9
 JYk
X-Received: by 2002:a05:6000:1ac9:b0:43d:6787:9934 with SMTP id
 ffacd0b85a97d-43fe3db39b2mr24542761f8f.9.1776750515665; 
 Mon, 20 Apr 2026 22:48:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a381sm38064849f8f.21.2026.04.20.22.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 22:48:35 -0700 (PDT)
Message-ID: <71de5fac-7d75-4640-ad16-2707520c53b7@linaro.org>
Date: Tue, 21 Apr 2026 07:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] hw/riscv/boot: Provide a simple halting payload
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-5-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421053140.752059-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 21/4/26 07:31, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> OpenSBI hangs before any console output if the domain init code sees the
> next stage is not in an executable region.
> 
> If no kernel payload is provided to QEMU, the next stage address is
> NULL, and the riscv virt machine memory map ends up covering the 0
> address with the catch all S-mode RWX region and so OpenSBI prints
> console messages and does not hang until the next stage boot.
> 
> The soon to be added Tenstorrent Atlantis board address map has RAM
> starting at 0 and it loads OpenSBI there, so it is M-mode and not
> accessible by S-mode, tripping the early check and hang.
> 
> Add a helper to set up a simple payload that gets OpenSBI messages
> to console.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3: MachineState argument was unused
> ---
>   include/hw/riscv/boot.h |  1 +
>   hw/riscv/boot.c         | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index fb90bf12399e..a1eb377474b9 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -78,6 +78,7 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
>                                  hwaddr rom_base, hwaddr rom_size,
>                                  uint64_t kernel_entry,
>                                  uint64_t fdt_load_addr);
> +void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr);
>   void riscv_rom_copy_firmware_info(MachineState *machine,
>                                     RISCVHartArrayState *harts,
>                                     hwaddr rom_base,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 3ea95c175c14..3a97fd1441f7 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -518,6 +518,26 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
>                                    kernel_entry);
>   }
>   
> +/* Simple payload so OpenSBI does not hang early with no output */
> +void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr)
> +{
> +    int i;
> +    uint32_t payload_vec[] = {

static const?

> +        0x10500073,                     /* 1: wfi           */
> +        0xffdff06f,                     /* j       1b       */
> +    };
> +    /* copy in the payload vector in little_endian byte order */
> +    for (i = 0; i < ARRAY_SIZE(payload_vec); i++) {
> +        payload_vec[i] = cpu_to_le32(payload_vec[i]);
> +    }
> +    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
> +                          addr, &address_space_memory);
> +
> +    info->kernel_size = sizeof(payload_vec);
> +    info->image_low_addr = addr;
> +    info->image_high_addr = info->image_low_addr + info->kernel_size;
> +}


