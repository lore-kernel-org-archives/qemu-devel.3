Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67417CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqWv-0003Ju-3A; Mon, 07 Oct 2024 12:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxqWl-0003JQ-GB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:24:07 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxqWj-00075z-QH
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:24:07 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e0b9bca173so3316971a91.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728318244; x=1728923044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GNhy6N33fhQzXa586y2PloJNvuEVBTAVV6x/iLs9MW0=;
 b=Uxg7av8BTcEw5lixFnWdKvaDuWlSUTUINOivnKQ0j/mOvHmkU6sSyrtW1yoezcBCqG
 kpE1IIn0vhZkamGTURrWETOIV9R8hPYkESRPiU51I5TanlTIt5V1Rqc/d+W5Pca+/qoA
 anvdpnUpEpfaJVEfMZZn6PXNepnR0mDECkc3S5tidEZQq51hllivM2TjpxPnniI5ENe0
 +UicU4k2/AVjLwW3SpOWjw8W5wO0Lijxk5K7zs+qVnTg13Q4cPKUVquW7hJyK148eqL7
 OPkRfnS5yVgrNF+pG3iH4yp0QT2uWrK57zsTuV+pt/gKHncPL2A/p0NTpRmfqal8/gJk
 HZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728318244; x=1728923044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GNhy6N33fhQzXa586y2PloJNvuEVBTAVV6x/iLs9MW0=;
 b=avuPq7xA6YXA9ScL7p1VSqoNy4il4pooFp0UgtdbSL7YiKSMlzSyPGBsj0YiR1QCWw
 eQR3ok1Pb8GqLLo9PQNi9HZ9yG8UIxfrFE0gECfZHB/VgrtDfloNOYs7J2sloXTQjCrv
 AszlYLtRa/QyO9jRLxiaIKVEO63ZuTlLSPtBrfhU5yQIRyd60Er+sRh70ufI8cw4kPYC
 3wBz/ejAm0avu+KK0rKeL5taunyQII+1DfnhJtCAWQqSdkgOUcu+t29yxEFRDzldWdKA
 SUWhnhPJcdcEakY0KBG3EiBufa/oz4RXQRq9+Fuoi3GoQzitm85h4MZMte6Mc4ULdizd
 Y2OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb5AjMDSaay55GdgBp5sXwnNvEExcIoKocFknCcTsU2lU736YyRlX3EPlJlw0LdIlzaTExaLgu7jkS@nongnu.org
X-Gm-Message-State: AOJu0Yzh9Xp4ig0IyCoxtmqXFjuvPCXLWjNRn2vWKtbKJOOVarzKqAAm
 hE7MSeInPWnUCB7z9HGsR8NzHant7jZ2PV/jtqC7HnRSN9GIf0oBsCM128F0rRc=
X-Google-Smtp-Source: AGHT+IGeN0Mdhrv1ZeWspIV1/mWHnSAFphaPVja0DECtwXWxigvdBu8JICqp6Y1MLuqXPSq4f37jpA==
X-Received: by 2002:a17:90b:1e4c:b0:2e0:ab57:51ec with SMTP id
 98e67ed59e1d1-2e1e631f179mr14113797a91.30.1728318243858; 
 Mon, 07 Oct 2024 09:24:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e85c905esm7388585a91.17.2024.10.07.09.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 09:24:03 -0700 (PDT)
Message-ID: <a370de66-d966-44d2-9dee-091b28082fcc@linaro.org>
Date: Mon, 7 Oct 2024 09:24:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] tcg/riscv: Add vset{i}vli and ld/st vec ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
 <20241007025700.47259-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241007025700.47259-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 10/6/24 19:56, LIU Zhiwei wrote:
> +static void probe_frac_lmul(void)
> +{
> +    unsigned long vlmax[3];
> +
> +    for (int i = MO_8; i <= MO_64; ++i) {
> +        switch (i) {
> +        case MO_8:
> +            asm volatile(
> +                "vsetvli %0, zero, e8, mf2\n\t"
> +                "vsetvli %1, zero, e8, mf4\n\t"
> +                "vsetvli %2, zero, e8, mf8"
> +                : "=r"(vlmax[0]), "=r"(vlmax[1]), "=r"(vlmax[2])
> +            );
> +            break;
> +        case MO_16:
> +            asm volatile(
> +                "vsetvli %0, zero, e16, mf2\n\t"
> +                "vsetvli %1, zero, e16, mf4\n\t"
> +                "vsetvli %2, zero, e16, mf8"
> +                : "=r"(vlmax[0]), "=r"(vlmax[1]), "=r"(vlmax[2])
> +            );
> +            break;
> +        case MO_32:
> +            asm volatile(
> +                "vsetvli %0, zero, e32, mf2\n\t"
> +                "vsetvli %1, zero, e32, mf4\n\t"
> +                "vsetvli %2, zero, e32, mf8"
> +                : "=r"(vlmax[0]), "=r"(vlmax[1]), "=r"(vlmax[2])
> +            );
> +            break;
> +        case MO_64:
> +            asm volatile(
> +                "vsetvli %0, zero, e64, mf2\n\t"
> +                "vsetvli %1, zero, e64, mf4\n\t"
> +                "vsetvli %2, zero, e64, mf8"
> +                : "=r"(vlmax[0]), "=r"(vlmax[1]), "=r"(vlmax[2])
> +            );
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        vaild_frac_lmul[i][1] = vlmax[0] != 0;
> +        vaild_frac_lmul[i][2] = vlmax[1] != 0;
> +        vaild_frac_lmul[i][3] = vlmax[2] != 0;
> +    }
>   }

This fails to build on debian with default cflags:

/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc: Assembler messages:
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2880: Error: unrecognized opcode `vsetvli 
a3,zero,e8,mf2', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2881: Error: unrecognized opcode `vsetvli 
a4,zero,e8,mf4', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2882: Error: unrecognized opcode `vsetvli 
a5,zero,e8,mf8', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2888: Error: unrecognized opcode `vsetvli 
a3,zero,e16,mf2', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2889: Error: unrecognized opcode `vsetvli 
a4,zero,e16,mf4', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2890: Error: unrecognized opcode `vsetvli 
a5,zero,e16,mf8', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2896: Error: unrecognized opcode `vsetvli 
a3,zero,e32,mf2', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2897: Error: unrecognized opcode `vsetvli 
a4,zero,e32,mf4', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2898: Error: unrecognized opcode `vsetvli 
a5,zero,e32,mf8', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2904: Error: unrecognized opcode `vsetvli 
a3,zero,e64,mf2', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2905: Error: unrecognized opcode `vsetvli 
a4,zero,e64,mf4', extension `v' or `zve64x' or `zve32x' required
/home/rth/qemu/src/tcg/riscv/tcg-target.c.inc:2906: Error: unrecognized opcode `vsetvli 
a5,zero,e64,mf8', extension `v' or `zve64x' or `zve32x' required

Rather than expanding this with a switch over immediate encodings, perhaps better feed 
encode_vtype() to the .insn encoding of vsetvl.


> @@ -2160,6 +2483,7 @@ static void tcg_target_init(TCGContext *s)
>          tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
>          break;
>      }
> +    probe_frac_lmul();

You need to avoid this call if the host does not support vectors.

It occurs to me that, rather than caching valid_frac_lmul[][], we can pre-compute 
encode_vtype and lmul_eq_avl.  It's not much of a savings within set_vtype(), but perhaps 
it is clearer.


r~

