Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0411CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F4O-0003qd-VW; Mon, 29 Sep 2025 10:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3F4M-0003hY-Jg
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:41:38 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3F45-0001OT-Mw
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:41:36 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3306d93e562so5016949a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759156872; x=1759761672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MkzCGJhxmBl7pB+ADBh0H9ogb846oJxdcaEE8Qh58OA=;
 b=W2w7tfWXMHuF3azQwR0H8tP4awGwW5xh5AkikSG4A0HnL4bTC3J0c9ekWrSAB/Ruwl
 gvG572N6KlNnz6uODbIqc2BRD3sgqKeM8UShzKdKp4Vwr6Y++GqnLZ+YmNyf8cpn2tqZ
 OLj3RfkzVMqMBIzFRbnuI4dvXRWu0u5ufptUWfhOLHoveMOJ+TNYhmzyJBxpRKY34hEF
 4deTgkQvYgjOa97/Z0OXYWRW5KcQBsfthJBgJpzaII0SmtoFyFuwyHrllDgZ4Y8nWWYu
 Xvxdp/SHxz/cTmNoKvVYs6bmTsS137g1ctQkK/QWUorG6cbEHt2e87HMliMhVNSMjxX6
 Ak2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156872; x=1759761672;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MkzCGJhxmBl7pB+ADBh0H9ogb846oJxdcaEE8Qh58OA=;
 b=ZZuhUgYM1pZUuYG+0JDwY4MDMxTFbUZ2T7ZXNOVG1hWoH0EWKiidXdCQm99Fij5m+/
 ewahK8yxRV4Y32VFjJ8y7INuQtzgcgtE+yTwtPNrYZsLkaQMiIcHB8aSaQiW5Wq+D+m1
 RGZL/ai88t8cZ9ieO3qe1aB4maR7GF+WNsvG3KKmOFKRqIIJ3f6sNA/5MByfo1oC4akk
 zti9bGTr3fy20CBg9FHT+1E4S2fcgcfyQyJvBpAPMquNa2ApVYdTX/aAmbOm2JQo8kdi
 D8RBAJ24wrQLjyi3Qvvq8k1/9quuk+b2DxYZRN9pX746y7SVVdLwOEzQ2dGDaeNpnJty
 pqow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGGfATnLWkZ1qGxC+uNIGq+w3cpfxynHvMaIhVFfkMLWNpBX8Jf13c5fZ5LQOvfC1VTupcv7X8V4s3@nongnu.org
X-Gm-Message-State: AOJu0YyImk8tCcMYFjTUx7RGuOVZFgFJ566c8Y1R6z1Dyn0x2BY7BFBd
 48rIjFuxtygiLkAkSjh6E8tWhb/PbTFEd76a4wdGqfb7cNTFdlSl1Ycj5genKpfG4M8=
X-Gm-Gg: ASbGncuju3xLrMHK2IhBpwGMRiQd03hTd7aLPX23Lhag+aZPFkvu+6YD8Pyx5QFHEVT
 8j8eWGB/iuyCYjXUWVBybZIhBNMv/uurfB9tJUC1lZYmwNYqNWFX2DhQa5O/la91fquFRxeFX3y
 0EHZj9zG9yFiM2ziW0Rj1EZ8JLOs0QR096heprafQATpNy/8ySS+x+7w3Ex++34vh34YJMSRkoC
 8PVPDqKVVDIt5K98UQ7QjXUYN9q6DFW52GGrQsVOreqq2PdYEFwhnIQMIVERLJbTIb8xpibg1Cm
 BWiygLWjx6OUul2k6YHMYssSldJUj8EV7P2HPJV0RdOeS4GGw9jFZ1NAtZkmNTt46qDAkudpqHm
 RLcPomccpe8I/pja5SHExFfFEi07Gr+hmoT+45SAR5yse6zjUGSF21rgE5A==
X-Google-Smtp-Source: AGHT+IHPy3QvNuZjOj6YBc+0r5YGXTW69E4S91z1ivN0tb6fevgW3Q5wqiYPN2nAFuNMgcVURiqjBA==
X-Received: by 2002:a17:90b:5627:b0:330:793a:4240 with SMTP id
 98e67ed59e1d1-3342a2c5d9cmr15797380a91.31.1759156872409; 
 Mon, 29 Sep 2025 07:41:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bd90332sm17219996a91.1.2025.09.29.07.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 07:41:12 -0700 (PDT)
Message-ID: <3fb026bf-3b33-4cfa-a20f-8e1d442e7902@linaro.org>
Date: Mon, 29 Sep 2025 07:41:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix endianness swap on compressed
 instructions
To: Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-trivial@nongnu.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 vhaudiquet <vhaudiquet343@hotmail.fr>
References: <20250929115543.1648157-1-valentin.haudiquet@canonical.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250929115543.1648157-1-valentin.haudiquet@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 9/29/25 04:55, Valentin Haudiquet wrote:
> From: vhaudiquet <vhaudiquet343@hotmail.fr>
> 
> Three instructions were not using the endianness swap flag, which resulted in a bug on big-endian architectures.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3131
> Buglink: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2123828
> 
> Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
> ---
>   target/riscv/insn_trans/trans_rvzce.c.inc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Cc: qemu-stable@nongnu.org
Fixes: e0a3054f18e ("target/riscv: add support for Zcb extension")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
> index c77c2b927b..dd15af0f54 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -88,13 +88,13 @@ static bool trans_c_lbu(DisasContext *ctx, arg_c_lbu *a)
>   static bool trans_c_lhu(DisasContext *ctx, arg_c_lhu *a)
>   {
>       REQUIRE_ZCB(ctx);
> -    return gen_load(ctx, a, MO_UW);
> +    return gen_load(ctx, a, MO_TEUW);
>   }
>   
>   static bool trans_c_lh(DisasContext *ctx, arg_c_lh *a)
>   {
>       REQUIRE_ZCB(ctx);
> -    return gen_load(ctx, a, MO_SW);
> +    return gen_load(ctx, a, MO_TESW);
>   }
>   
>   static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
> @@ -106,7 +106,7 @@ static bool trans_c_sb(DisasContext *ctx, arg_c_sb *a)
>   static bool trans_c_sh(DisasContext *ctx, arg_c_sh *a)
>   {
>       REQUIRE_ZCB(ctx);
> -    return gen_store(ctx, a, MO_UW);
> +    return gen_store(ctx, a, MO_TEUW);
>   }
>   
>   #define X_S0    8


