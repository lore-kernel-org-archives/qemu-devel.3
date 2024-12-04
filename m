Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904CEE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 13:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIpgK-0004Va-Ff; Wed, 04 Dec 2024 08:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tIpgH-0004VC-BA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 08:44:41 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tIpgD-0006iY-JO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 08:44:39 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7f71f2b1370so4387548a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733319873; x=1733924673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aHd1MRRSafUnWBC2N8SahkGvWNXk3m2ISH8lpOFbWeg=;
 b=FCO+tT1Fg6G08bVEKK6K59Yodm01wzDVQryeQN/bdw/ODEwv0ha5CnnYRMtUSPh3YG
 u29QDiOHdctxxdmOlW9xVCNnENfAmAAp+qwkLRFPwcNeE/fizLC0fx2EOt9FGapD0UTL
 Yhe/3rnaP6LnZBvtG9YIb4QalnorXIOE4iuquV8t2GlmD7Xc4CNBt7iJxLzLK1atvh5Q
 P9Ooe39tm/+LP8p2ia6ikJ8r4qkIaAwzBpVrU+qb1PHXEdDGPOpM04ZDWpIWeY7iio2c
 8h3so8kSYqD2xAywcSMJw14FfCpZ8R7wYDwpPa2qoXC5LnvIqeXkNM+vSnxwHPlh2zBV
 hNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733319873; x=1733924673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aHd1MRRSafUnWBC2N8SahkGvWNXk3m2ISH8lpOFbWeg=;
 b=LcWntpgnSPP/suELfsMK/AN77RWE6vTCz78nePnrSC/DbGLKiJOGrQBLrFF89UoNne
 Yf+jaHOMpw6d20OOPa122Lo0LiUJ7EzAgRbd+my2RSbWOnDrJRloeJrdjqZbjYHchgs8
 2+THDEDt284A3WmTENupoyiift7IH29l9sfGeuXqz8mUNGGkYX8cTSMSnoZlxS8VwA/M
 AkQ1wgyPgbZoU+OVdF7mw8jvE5aKjg296QoviFoxackac0fsjfCVz1DUZu9Jul+2YQb/
 7RCa8NhVxEXuTZp2C4E7Df0J5+3mcxeZhdmHlxTfX3wtd7725Rt14pQhBflw2JJm7Nnt
 3aBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRXihtuLpRL0vq0Tex00OwU1Y64aepnJnkYH0W10A6RvvUPZTateV6zkbSyXeUJSMtOSQ5kRACpoqI@nongnu.org
X-Gm-Message-State: AOJu0YytgX+gAmpwzRFMSk3P7EiF9FC/copflcf+rukLE3jxB3b10xJL
 4LdGTnm0idclEMKcpsit/0nqC7AK3ndRMhrDvOkQpBcp1Tpby0Dk66rFU3JxFq4=
X-Gm-Gg: ASbGnct0MLwE2ykDDgdwZZERDC+/+eZJWLv1ik0zdKmmnwbKsKx7pCmrBTx6AzcaE/m
 6xiY7Ni6GW/gkgmxos47cFAOx+FaozX988Chkovux9WryAyi2ohXTnTIYyIqlwJOKhh0vp6+85X
 QRquA+sVFEohg4MiZxCF1JZCrc7qMjs+y9229zfYFrxleHG1b02wjDYPq/XJL8tkJHju92lPLQf
 aow4PpkS1/SuUQ3IdfNGNk51kiOkRBz7ivtloSkRyfupb2uzpx9ZxlzfO7hPz+r8sbujk/0kfFt
 RHG56UfMtyjI4J9JglEXdQ==
X-Google-Smtp-Source: AGHT+IGGUyuaM3j34sxPJNaZP6nLJK5iK/C0VMiyBLxEI5ZlH5vXUhKdDMNoehPbqB7sNY8fydZrEQ==
X-Received: by 2002:a05:6a20:12d2:b0:1e0:c432:32fe with SMTP id
 adf61e73a8af0-1e16be61a86mr6809021637.26.1733319872929; 
 Wed, 04 Dec 2024 05:44:32 -0800 (PST)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fcf81228d6sm1499661a12.65.2024.12.04.05.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 05:44:32 -0800 (PST)
Message-ID: <108a264a-3744-4953-ad35-eed4fa0ac47e@sifive.com>
Date: Wed, 4 Dec 2024 21:44:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] target/riscv: rvv: reduce the overhead for simple
 RISC-V vector unit-stride loads and stores
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Paolo Savini <paolo.savini@embecosm.com>
References: <20241204122952.53375-1-craig.blackmore@embecosm.com>
 <20241204122952.53375-2-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20241204122952.53375-2-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52d.google.com
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

Hi Craig,

I think that the unexpected vstart issue persists in this patchset.
This version is unable to update the vstart CSR to the correct index when
grouping load/store elements.

For instance, if an exception is raised by an element following the first
one, and the optimization attempts to group multiple elements, the vstart
value remains the index of the first element, which is not the actual
element index that raised the exception.

Max

On 2024/12/4 8:29 PM, Craig Blackmore wrote:
> This patch improves the performance of the emulation of the RVV unit-stride
> loads and stores in the following cases:
>
> - when the data being loaded/stored per iteration amounts to 8 bytes or less.
> - when the vector length is 16 bytes (VLEN=128) and there's no grouping of the
>    vector registers (LMUL=1).
>
> The optimization consists of avoiding the overhead of probing the RAM of the
> host machine and doing a loop load/store on the input data grouped in chunks
> of as many bytes as possible (8,4,2,1 bytes).
>
> Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
> Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>
> Co-authored-by: Craig Blackmore <craig.blackmore@embecosm.com>
>
> Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 54 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index a85dd1d200..068010ccd2 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -393,6 +393,60 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>           return;
>       }
>   
> +#if defined(CONFIG_USER_ONLY) && !HOST_BIG_ENDIAN
> +    /*
> +     * For data sizes <= 64 bits and for LMUL=1 with VLEN=128 bits we get a
> +     * better performance by doing a simple simulation of the load/store
> +     * without the overhead of prodding the host RAM
> +     */
> +    if ((nf == 1) && ((evl << log2_esz) <= 8 ||
> +        ((vext_lmul(desc) == 0) && (simd_maxsz(desc) == 16)))) {
> +
> +        uint32_t evl_b = evl << log2_esz;
> +
> +        for (uint32_t j = env->vstart; j < evl_b;) {
> +            addr = base + j;
> +            if ((evl_b - j) >= 8) {
> +                if (is_load) {
> +                    lde_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                } else {
> +                    ste_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                }
> +                env->vstart += (8 >> log2_esz);
> +                j += 8;
> +            } else if ((evl_b - j) >= 4) {
> +                if (is_load) {
> +                    lde_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                } else {
> +                    ste_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                }
> +                env->vstart += (4 >> log2_esz);
> +                j += 4;
> +            } else if ((evl_b - j) >= 2) {
> +                if (is_load) {
> +                    lde_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                } else {
> +                    ste_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                }
> +                env->vstart += (2 >> log2_esz);
> +                j += 2;
> +            } else {
> +                if (is_load) {
> +                    lde_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                } else {
> +                    ste_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                }
> +                env->vstart++;
> +                j += 1;
> +            }
> +        }
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


