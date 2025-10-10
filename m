Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD50ACCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7I6t-00041y-D9; Fri, 10 Oct 2025 14:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I6r-00041Y-VC
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:44:57 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I6l-0000O8-3m
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:44:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so2069626b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760121888; x=1760726688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ITqQGH8IDJWvdAzvzfY+h4upG6orQiBSDPieBX6KY3A=;
 b=DOV1oG91fBI1jNQgY2ybNiI2bjio4YXeV/k/TKgwqdJYE1pKJ1/BPUeSJHkowOoBy/
 XbRIY+V3INeaYjyimczCXdJRF2yW+Wq6NhO0lv6hDx9Mj5X6Ns5x3fKzjVTHiw/N6lxQ
 EfojUC83YcwVOA7a6ISLSK1s/AoYbH/1f/VPR5+XCTEySPX2VvHz7tZb6jY0/5S5xfCF
 LrdzUCxcmCHtRPVd/onRSsX6opkZCshApRg+VKvVd6Cfiw2ilVCYcSto8jiyMM3Zyykk
 0ulMRKgetHQQ5oq1zdYhzxei0eMzNca52F0l+sdyx3syS7OoNgtmG4hDoMQlxfsvebAG
 RiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760121888; x=1760726688;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ITqQGH8IDJWvdAzvzfY+h4upG6orQiBSDPieBX6KY3A=;
 b=Olk6qL2iUam/hNHT8EV9YaebCZwa6EO6fElAKDPGPeiWt20eipkFF3UPqNDjDZnhdv
 fDTJYFSMRvrf5f/vLUDrbufn1M+P7n76LHruRcbhVVa1QJAm1BC8Y5ylibVy9MQ2xDCm
 qfZpeYlHL6MqV8FkQNIumbeDyCYCwTOYf6DpZC7i4KNi3nU05vu/Sw3XCn7eGwXJeaZ9
 3cDSY7CcxYkqEhRW9W2cfdZT0fueO3U6fsRGx19cDK7uMh4v4Jc3e3du1EyBTEetnopI
 Gimgdn7tau0dCoskatycL4P0m61cyFF0HLDCx+FgyMxIDNYq+MCaVxSIiM/a0GF+MrLE
 9rqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbzQIKKxAWiLNvM4lTP5laFWK90iLoZn1uBvX4kufclTTfjfytFG5/LQ1a4rVdp5cV0dda9a0nvfV1@nongnu.org
X-Gm-Message-State: AOJu0YwDKvUfQZQFVPRc/gnrftNoaNQulQLS3MOjDUpQKOSuOiefYPP+
 Us5awL3swAGO379WfKx9IEBcjbgsoy4NbmVayfQIV/s2kSZfLo5Opm5hOP+W0genbv4=
X-Gm-Gg: ASbGnctHuAl4vLHr0NaubKCk1nmd0YNH2hy/w05GwYBTTHarNXpYJsqS315SyC8lsQi
 ETve4rO0zGVs5CDiQL61yBOjRWR0TAFpYnbgBu6NsHZ9Qjxzn5AQULkPZfNySqMmF4Is36nAeSw
 Yki1p6kja1az1TRDDVswWwBgChNwzAiv0K70mAo9a4Q362llxm6tIt+eLQVgL0n8oxDKGziAiAp
 XQ8L2jIW7u2LL/DdY0sRksbm6Qrb1LjRbittMBiEcr3WmEqFg94bAoZkute1zWpWE5ObZNNjmJ9
 3wLfWmGJkXl5ZR/EbAL11vJcUTBUZ9NBsBXmcAOx9ocwdqitHGbo85dKtvse2LGQwpi9WFZMtSi
 a9uYuT386tCFRwwGXX2vjh/UzuSr89NKFXYrsfKnGU//sMMbhpWC4orxqyAw=
X-Google-Smtp-Source: AGHT+IGpfLRUoPc2YLqeQ4HQ8s+GgQtZvk0S7j6XU/hifYl6mB16yXIshdTbbNS06zzSfwL/la8L/w==
X-Received: by 2002:a05:6a00:a14:b0:792:574d:b2c with SMTP id
 d2e1a72fcca58-793878284b0mr15248275b3a.15.1760121888318; 
 Fri, 10 Oct 2025 11:44:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d2d2b29sm3692419b3a.55.2025.10.10.11.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:44:47 -0700 (PDT)
Message-ID: <88f8d901-b7b4-47e6-b209-f9375c5b95e1@linaro.org>
Date: Fri, 10 Oct 2025 11:44:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] target/riscv: Really use little endianness for
 128-bit loads/stores
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fabien Portas <fabien.portas@grenoble-inp.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 10/10/25 08:50, Philippe Mathieu-Daudé wrote:
> Per commit a2f827ff4f4 ("target/riscv: accessors to registers upper
> part and 128-bit load/store") description:
> 
>   > The 128-bit ISA adds ldu, lq and sq. We provide support for these
>   > instructions. Note that (a) we compute only 64-bit addresses to
>   > actually access memory, cowardly utilizing the existing address
>   > translation mechanism of QEMU, and (b) we assume for now
>   > little-endian memory accesses.
> 
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> However this commit used MO_TE (target endianness) for the
> gen_load_i128() and gen_store_i128() helpers. Likely it was
> unnoticed because current targets are only built using little
> endianness:
> 
>    $ git grep -L TARGET_BIG_ENDIAN=y configs/targets/riscv*
>    configs/targets/riscv32-linux-user.mak
>    configs/targets/riscv32-softmmu.mak
>    configs/targets/riscv64-bsd-user.mak
>    configs/targets/riscv64-linux-user.mak
>    configs/targets/riscv64-softmmu.mak
> 
> Replace by MO_TE -> MO_LE to really use little endianness.
> 
> Cc: Fabien Portas <fabien.portas@grenoble-inp.org>
> Cc: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> Fixes: a2f827ff4f4 ("target/riscv: accessors to registers upper part and 128-bit load/store")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_rvi.c.inc | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index b9c71604687..df0b555176a 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -389,9 +389,11 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
>           }
>       } else {
>           /* assume little-endian memory access for now */
> -        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
> +        MemOp memop = MO_LEUQ;
> +
> +        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, memop);
>           tcg_gen_addi_tl(addrl, addrl, 8);
> -        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
> +        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, memop);
>       }
>   
>       gen_set_gpr128(ctx, a->rd, destl, desth);
> @@ -494,9 +496,11 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
>           tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
>       } else {
>           /* little-endian memory access assumed for now */
> -        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
> +        MemOp memop = MO_LEUQ;
> +
> +        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
>           tcg_gen_addi_tl(addrl, addrl, 8);
> -        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
> +        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, memop);
>       }
>       return true;
>   }

We fix this to use tcg_gen_qemu_{ld,st}_i128.


r~

