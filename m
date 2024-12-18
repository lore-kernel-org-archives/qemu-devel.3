Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA96AE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvu9-0007u8-7l; Wed, 18 Dec 2024 10:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNvu1-0007sX-CX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:23:57 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNvts-0005eT-Vk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:23:55 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2166651f752so70355735ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734535423; x=1735140223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IcvknnzbKwTg7BsjcyqYwtJ2nROQCleL1kFjUBkrSwE=;
 b=aUsdnsl+x2ziQ9wcWqhK7n8/+FkO4AGA2LvYpQT/4KRIAZGZKw6H1frc6f3ZRqkS7d
 6Dw7iTF7DHjMg2MtWK7E6s1yoOQpZykvB1UmJqezegziEdOoU7rwGnoP5Qv4siLPBbCl
 8zAPglB9uVBVua26FZ/Ebwmen1gqazI15Bg9e88m/f+OYn5zw1seSu0vjo1VVuN73vx9
 dpvPNKeWRO0cRq4sKQ4Xji/wtLEwvfbtc/c2xgeLhy9PU+0TSDPwK7isoGAueE/U/YtE
 cqD38lYZ2Blf7GsUP2dgLih/14mpwtRoNhiJCNCJLdkRwWLb1rCLF/p7OhbfxLk1K1dK
 6Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734535423; x=1735140223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IcvknnzbKwTg7BsjcyqYwtJ2nROQCleL1kFjUBkrSwE=;
 b=Wlo1MxP+X3TfiiSpbN6CqmKif4aP+87Ufx9xVovUexkLVdICPrOdPMbjsK3ZC64BGN
 UEy9rvDpYCmmb8eb1+35KflBNCAatfZooh/jeTRWDLfeWBa3qIpLf4tP448BC5utzF2y
 k0NQv4eVGbi3JIstGnXlTdkmjfcVXOSyvl6XBtgkpL+Al04asB6Urd24tAjDsAZZzKYp
 052KkCWEQlIFUFe4flIW8C0+mhLDxCspybx4m1FWPXjriv0oJuVGxd4F9fiUvneBW6fr
 TC4l8/+76txEUFVKiUlX9hrQvI3ycJies7tDqPGMo6y+LXvCBlWQzDgs5kWAd6f66HHI
 amFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRKurStUL5BZ57txYlzWlTJ7YL07eOZf1hF1ga8s1PlU9KKPHabs2XIvFhmyEse+Zf7ysoCNpTWm53@nongnu.org
X-Gm-Message-State: AOJu0Ywb0JqpxNnQza4HQuDreDpTJ49/ZVWdE0RMQro8+iPnRKrA6qy4
 33JHiOfVs42bWzUvkv4yN1qwEHAr7V30Nv3aOnCF44PDIyqA2Vf5kElM8ezW9DY=
X-Gm-Gg: ASbGnctgO8UqXFR41E5jUE/d20P7irbo04/pZI/1xkKvaw9sRyOq2Di/+fawTAk5FMu
 zaJ6Aok78QOxGNsLrq74vvVmLZErE9zI4PmWNVjpYQ4xHgCyJHc8Cn3TiXAuKMlOfiTm+Q83NT+
 /7nLhe5FWkSppVTT+ZEtVWr2o6SYyjFahwf5PXHaA/vddfzOQg8bdzqbMWFYNHakfce/eIA1/pp
 2M0TxvlSl+t61sdooQG21GPPyS+yA9lvkHyDySF8Gh4vA7BcU7o5VByurt5cD4aRun8Lw==
X-Google-Smtp-Source: AGHT+IFdwDHNtoOXwHcTq9Y2/+uyLTkQev/FTnmn4asLI2SyxpaY6W3rxwEL+Bpqo4R+VqNoQI7VEw==
X-Received: by 2002:a17:903:2306:b0:216:4724:2757 with SMTP id
 d9443c01a7336-218d6fd791bmr50793385ad.4.1734535422872; 
 Wed, 18 Dec 2024 07:23:42 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcc20dsm77622415ad.85.2024.12.18.07.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 07:23:42 -0800 (PST)
Message-ID: <2f526fe2-9524-4a17-b386-644b0ce5167d@ventanamicro.com>
Date: Wed, 18 Dec 2024 12:23:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] target/riscv: rvv: speed up small unit-stride
 loads and stores
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
References: <14dfb7b7-98bb-4e8c-a223-c568512180b7@embecosm.com>
 <20241218142353.1027938-3-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241218142353.1027938-3-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 12/18/24 11:23 AM, Craig Blackmore wrote:
> Calling `vext_continuous_ldst_tlb` for load/stores up to 6 bytes
> significantly improves performance.
> 
> Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
> Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>
> Co-authored-by: Craig Blackmore <craig.blackmore@embecosm.com>
> 
> Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 0f57e48cc5..ead3ec5194 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -393,6 +393,22 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>           return;
>       }
>   
> +#if defined(CONFIG_USER_ONLY)
> +    /*
> +     * For data sizes <= 6 bytes we get better performance by simply calling
> +     * vext_continuous_ldst_tlb
> +     */
> +    if (nf == 1 && (evl << log2_esz) <= 6) {
> +        addr = base + (env->vstart << log2_esz);
> +        vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart, ra,
> +                                 esz, is_load);
> +
> +        env->vstart = 0;
> +        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
> +        return;
> +    }
> +#endif
> +
>       /* Calculate the page range of first page */
>       addr = base + ((env->vstart * nf) << log2_esz);
>       page_split = -(addr | TARGET_PAGE_MASK);


