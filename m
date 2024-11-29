Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB18ED729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4U4-0006iZ-5U; Fri, 29 Nov 2024 12:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tH4U0-0006i6-TG
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:08:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tH4Tz-0008A0-Eb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:08:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21285c1b196so20495535ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 09:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732900122; x=1733504922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t2viKvgj0wwAyRIWliYcaWM9Myznzn9A44elH3XekC0=;
 b=HayK85eSQZeP37aDCnUOJIQBERjotIENIgOoROuc4NLE4MmyGSMsck/JS+4ADwDwyz
 8KHf2YTcLqo2t5v6/qrDZ4aBtmp4E2Lz8CeS0JH/ONSxb17Ths/M+CQgYLvjziLyvWY/
 O/C6Ot1lMQwUbXcuvhBNuNIEPlYOKXDZfJ+j/7BZfeDMoGGZ+QjgtERORk4pTLezdIz2
 V+eKiJ03wUEol39WVMV3mIGLPb/j/KMtRprR3NIXSrSjz38h/VvlUMpEb09fM6okB4r0
 EVsgMQuZwxNxTBPuJZ9FZqOETUGqm2jyJTjUPbP38QefRq2pyUW4/UCE26T2Itx2DOqj
 zIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732900122; x=1733504922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2viKvgj0wwAyRIWliYcaWM9Myznzn9A44elH3XekC0=;
 b=UgMU/tWFNpdqspLm0+BJyCfQ53vNnY9FpAHWfBl/oBjnMCyxhkt0h3hANSyP7mGDGQ
 1WDczqiOku4GiNeVmcFNu/Kf/46TcrpS2/J5I5iOzfWTmexYxwCY3LqTX7beq37T2adb
 m34q5TUsuhwmIUolJg46xHyVzXtVXdZdtylxQfJSTQ6SMztEQWDhylhp7Yl+MKLsQU4C
 LTDxXRQ3XBxaJne0BLLHGGOsLvbuE7OXkVTsvPij/wrkX4G1DIDJQXWj2QK3lxDT/ZEm
 Rliq2wVcf7E1VsS3Z8B5RqdtY7OiG62JBVbZvvAw2ePKZpg+tot77MVrKsahafuOO1WN
 DL5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsqxRzBbeuk8j26pinzjUIx+MAk8oTCUewpFiaOfgt6XZThQdJct7g1OiEKH0qiZW75/FksFRIlaTu@nongnu.org
X-Gm-Message-State: AOJu0YzByAGdX0ggEuk1vlddGVslLCCNV1RE1Yt66Wo9+nF/GStirGzV
 MxT9AdZ3ViQWXKFIidlAGTQreDSKa06a6unf6UDF2czieuhDGO4BPb4U0Dkl2Co=
X-Gm-Gg: ASbGnctssM1Ute6IVyTFgl2MUzPOkgwYE2avaX8x7I6biaRiMR9dd98ZSB/TGPQ/Obo
 f3jY8DQCwQW/JVe9Qquruo8fHltFL5/nx0pqlVpXYCMyNpKek4hYrBDaI2Rfo1ds+xVayPm6cpx
 1LGS5YpWh8mVzQMfKXi2OhpCT1RcyejM2HPRKJ04wGzeitkhYX1N1bgte7Xs7SY80EvD68qZGKT
 K5o0xoTTAP65GY3KF7yFM7RLCuK3O6eUaPBpxnmoQxvkt1CFWHugtpDoTEbNRU=
X-Google-Smtp-Source: AGHT+IGhr4dmw40nMvAiTQC0CYyewCWS8cLIuUYZUTyOAdjY7jAYlPGFLaACAWwc9ubsAPykNwkrJA==
X-Received: by 2002:a17:902:f682:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-2150109af63mr152710175ad.13.1732900122016; 
 Fri, 29 Nov 2024 09:08:42 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72541814731sm3814014b3a.143.2024.11.29.09.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 09:08:41 -0800 (PST)
Message-ID: <c813fcb7-8e5f-4dd2-bf58-839e76d04c28@ventanamicro.com>
Date: Fri, 29 Nov 2024 14:08:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/3] hw/char/riscv_htif: Clarify MemoryRegionOps
 expect 32-bit accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241129154304.34946-1-philmd@linaro.org>
 <20241129154304.34946-4-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241129154304.34946-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 11/29/24 12:43 PM, Philippe Mathieu-Daudé wrote:
> Looking at htif_mm_ops[] read/write handlers, we notice they
> expect 32-bit values to accumulate into to the 'fromhost' and
> 'tohost' 64-bit variables. Explicit by setting the .impl
> min/max fields.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Notes
> 
> 1/ these variables belong to HTIFState but are declared statically!
> 
>    static uint64_t fromhost_addr, tohost_addr, begin_sig_addr, end_sig_addr;
> 
> 2/ I believe a 64-bit implementation would simplify the logic.


Perhaps. We would need to check with the protocol first. There might be
a reason why we're using 64 bit read/writes internally while doing 32 bits
r/w in the device.


For now:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> 
> 3/ This is a non-QOM device model!
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/riscv_htif.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 3f84d8d6738..db69b5e3ca7 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -325,6 +325,10 @@ static const MemoryRegionOps htif_mm_ops = {
>       .read = htif_mm_read,
>       .write = htif_mm_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
>   };
>   
>   HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,


