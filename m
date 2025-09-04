Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37341CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 13:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuAP7-0001iN-Vh; Thu, 04 Sep 2025 09:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuAP5-0001ht-5e
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 09:53:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuAOv-0004P1-5P
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 09:53:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45cb5492350so7284345e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756993992; x=1757598792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OKAPIZ+2d+SRV7Nywa5xA97xiji6grigfAj+yO0mBIg=;
 b=WtVWDw9taCjyT3mgrlm5nAj6shwXSTsMl4u0tFnm377Vdk7JSv/EFFhZyopd+YOFjA
 QrDrV4g/TO8sAeyvXP/6+g8b6eiSWdidFBncu4fMD2x6C88ai85zWP1Y+rQGVHFINeSu
 qb/wCYjFijbl8jXhT9zgknLBpvyV3K1uosnLB0Tsr/rr4Xmt24ZgTiVQC4iqP2U45Vtm
 s1K5Ssr4TJNdliXag4FrIr/o0e9z2GP7e/hlgOndjNQeYp7UPUZ59uamdppDtgomy3VS
 X3bOW7Kvzkad1m9K2WXL6j82+wG/b+bsvQSWscw8by4EP9UbnsEZ9Dc8bq7YdP0wGHVX
 +3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756993992; x=1757598792;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OKAPIZ+2d+SRV7Nywa5xA97xiji6grigfAj+yO0mBIg=;
 b=XmL9DNaidvPAcFc7+sqx+zxk9zMHY1IwKFNTtUW4Fei1mkcO6vxa4X2e5Ed4cH2C6M
 tKNHbJfLWrKrPrh0ayegpMoZlB//Bii5SpG1ZEqjrTUCu0rF15E2+Je6K8F/Df3j/anL
 kYgxPKU6klFum2qjw63Aba1YYfvU74CKKRSRRPZDE4EUqTj2HIJLjCAYY2OwKumJ9VF0
 vt2v8DRG6DywdRlWAwV6xL63pfFTl/yDHMUsqksPdpFxf0oEDLta1kE2uMcABHNxrxMh
 Uwqhxv04SeSVl4DmdHoa7vI5HpkEtngmFWy8OA65xpt1HueSLMOb6/v8NKNHvpLqpdIq
 mPrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1gwP6eRR2nn34/A53FpY6d+Wz3FQ91RIIeUrF1DAUVtogI4ia96BS/0GGHS+eBZH+vvw6tnFhw6Ge@nongnu.org
X-Gm-Message-State: AOJu0Yz9eRS3DEq/pQGLsF4/C+PJCzb5neCmOXee53HsJq2Sw3SOo3mJ
 lUE+N+9NmgjOJhWJw8BjFUZr5nd5bHjVux8RRBemnwvNdx/KNkvu8QZ4TQTSftoH1eA=
X-Gm-Gg: ASbGncu3YAxABFARcn3DMZbY2AGnR4rrOgVOkyzBfyE3ikA/XDI/cGY2PFyMy1esKRR
 uGmWWTL/YrsII2DGlSvS2I+0S98Gy2wMpWgVaEEjpb0Ani899EYp77ObVhoCHuFDNjlbTWGJuZW
 jbb8oIe1Voo1HUuM/OJb3kWrda2t4KEVEMugoxNHbgTZQ7fV9WtStsi3dFjh123xou/KSG5+tpY
 AwJE9PquYHYu5PSKh96MJy8XW3Jsdu/EPnsUzABjjd27161WmKxU2Vk5kfLZ0e+DJyiJd4lk6Uh
 iuuW1SNKBKDmqLGpjGy8u+afGQx11+/Jptxg63LakAidItRCxOp2SNWIgHaFCR48OEKGH/fSRY9
 7ZyMyFKaqsNrLtBj3txpsQyMf+70SLTr4s6LF
X-Google-Smtp-Source: AGHT+IEqcbTkt6qSg7YMb9qbRE2hplP7bBwMzR5RZT602EFr+jx4t84q17B3Qyfjns8Yyr40PzcLAA==
X-Received: by 2002:a05:600c:3b89:b0:45c:b580:f7a5 with SMTP id
 5b1f17b1804b1-45dcfa3eb0cmr27104165e9.28.1756993991999; 
 Thu, 04 Sep 2025 06:53:11 -0700 (PDT)
Received: from [10.175.133.6] ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6fe5sm368513785e9.5.2025.09.04.06.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 06:53:11 -0700 (PDT)
Message-ID: <0cb963d6-744b-4181-b590-08fee5516e30@linaro.org>
Date: Thu, 4 Sep 2025 15:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] target/riscv: Use tcg nodes for strided vector
 ld/st generation
To: Chao Liu <chao.liu@zevorn.cn>, paolo.savini@embecosm.com,
 npiggin@gmail.com, ebiggers@kernel.org, dbarboza@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1756975571.git.chao.liu@zevorn.cn>
 <74e3337dfebbeb29667492a1e57e87c75b55c725.1756975571.git.chao.liu@zevorn.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <74e3337dfebbeb29667492a1e57e87c75b55c725.1756975571.git.chao.liu@zevorn.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 9/4/25 11:13, Chao Liu wrote:
> +/*
> + * Check whether the i bit of the mask is 0 or 1.
> + *
> + * static inline int vext_elem_mask(void *v0, int index)
> + * {
> + *     int idx = index / 64;
> + *     int pos = index % 64;
> + *     return (((uint64_t *)v0)[idx] >> pos) & 1;
> + * }
> + *
> + * And
> + *
> + * if (vext_elem_mask(v0, i) != 0) {
> + *     goto label;
> + * }
> + */
> +static void gen_check_vext_elem_mask(TCGLabel *label, TCGv mask, TCGv mask_offs)
> +{
> +    TCGv mask_offs_64 = tcg_temp_new();
> +    TCGv mask_offs_rem = tcg_temp_new();
> +    TCGv mask_elem = tcg_temp_new();
> +
> +    tcg_gen_shri_tl(mask_offs_64, mask_offs, 3);
> +    tcg_gen_add_tl(mask_offs_64, mask_offs_64, mask);
> +    tcg_gen_ld_i64((TCGv_i64)mask_elem, (TCGv_ptr)mask_offs_64, 0);

Each and every time you cast a TCGv, you're doing something wrong.
There are a lot of them in this patch.

Your host pointer arithmetic should be using TCGv_ptr and tcg_gen_*_ptr().
This mask_elem should itself be TCGv_i64.

> +    tcg_gen_andi_tl(mask_elem, mask_elem, 1);
> +    tcg_gen_brcond_tl(TCG_COND_NE, mask_elem, tcg_constant_tl(0), label);

This should be

     tcg_gen_brcond_i64(TCG_COND_TSTNE, mask_elem, tcg_constant_i64(1), label);


> +/*
> + * Simulate the strided load/store main loop:
> + *
> + * for (i = env->vstart; i < env->vl; env->vstart = ++i) {
> + *     k = 0;
> + *     while (k < nf) {
> + *         if (!vm && !vext_elem_mask(v0, i)) {
> + *             vext_set_elems_1s(vd, vma, (i + k * max_elems) * esz,
> + *                               (i + k * max_elems + 1) * esz);
> + *             k++;
> + *             continue;
> + *         }
> + *         target_ulong addr = base + stride * i + (k << log2_esz);
> + *         ldst(env, adjust_addr(env, addr), i + k * max_elems, vd, ra);
> + *         k++;
> + *     }
> + * }

The form of this loop causes you to do more reads for vext_elem_mask than necessary.

Better to test once outside of the loop over K:

     for (i in vl) {
         if (!vm && !vext_elem_mask(v0, i)) {
             for (k in nf) {
                 vd[i, k] = -1;
             }
         } else {
             for (k in nf) {
                 vd[i, k] = ld(addr);
             }
         }
     }

If vl_eq_vlmax, and VL is a multiple of 64, you can structure this loop like:

     i = 0;
     do {
         mask = v0[i / 64];
         do {
             if (mask & 1) {
                 ...
             }
             mask >>= 1;
         } while (++i & 63);
     } while (i < vl);

If VL is a smaller power of 2, you can load smaller units of mask to match.  Though beware 
of the big-endian host addressing fixup.

If VM, you should fuse I and K into a single loop over all elements.


r~

