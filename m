Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3120CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNuE-0005Q2-GR; Wed, 11 Dec 2024 09:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tLNuC-0005Pc-K4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:41:36 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tLNuA-0003aV-Ur
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:41:36 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-725ce7b82cbso5055291b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1733928093; x=1734532893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/uWhGCbYDIm3fLP49BajDiiIJayqpm4kXtDJna7CH3c=;
 b=FwgyVYAThkg67ijRcOp17iTeClSFWwkKKtcEfcirUIVdUdSZeSqeSscRZbF8Wcr5mq
 Nijxl2nbK7J+Znm05OPBVWvMb+bFvpi5Xn6dzWMg7BPCbQBePHQCC8EhqfzYNa80JLu0
 z3qApDv/ewngNaI4qGK1fGJ7gpCvdON/1s7jXoIIb2MD3aeZJ8txTMukl9eQS0HwOGSt
 vqqCz0FIAP8Ebm/ZNCXWQKnNlUfV7dy5VOXny8QugFuNlt1S/hv9RmyDZniry8Jk3By0
 PkzrmlStqZKva50d7X8DSgHDrKIxgBi6shxv6ZXTWT70Z+e/wA5u47Uq3Q9TqXcXI4Cy
 h0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928093; x=1734532893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/uWhGCbYDIm3fLP49BajDiiIJayqpm4kXtDJna7CH3c=;
 b=BL13uzp+itSCF7sgTt99VMQOitb1fWeTGSSt8pA+wqCuoQscNXyCUoyzuuIeZ+rvte
 RYFThhw8MqOIQ/L2M+fo3FtoV2eM/ZWarIAFtuMqu7awPFbG/g8MQjEnjeuIS9vOYsR3
 NjeAMHs0gBZyjnO1bRMlPpUcrAqqkP4dVm/nhMDAi9k6TKi3JXoN9SXlJC0d/084vuqG
 VwUNxDaCNVk6IbmMYCCxXg6qdJv6QrqILo1TjgNIuiMDKzto8dFZgxqu80KIOLIrjgvf
 QnR5hq03np8GazsSkF6xkjbTt6SNL/OMr/mc5H6vTqfDtOieR69YM1tRTnEkPGbVanLj
 TJsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVERXiQ85YOyEX7vtycsEK5C+dyzuW1hutpVUI4GCJu5N9I/S8krymZ7enXlohQKz/wOBMmd5VWMHZ0@nongnu.org
X-Gm-Message-State: AOJu0YxGoMUbcWVtAMwXYIpyrn7EiN9TQAk9c+sRlnADAK0V1xRnuq4q
 8yOaqiXBKURV6QcXf2myums0PvToEdP/WTevtUh2NZHvZuh6JW9OIJdkAyxTxzc=
X-Gm-Gg: ASbGncuTCurfWU62IQZJRd6cje2CzOxxm6dXhZtar48I7sw7AHzxIzhUe8ed8Z0WX91
 6D3gt2OFbedvIKauTBynvAj3UMd7lr8oYMfsI6FDxd1hEXiyck8mUBbaHFePVVk00m3hDsX91LA
 gOB1n0exxFvj6bGEsbrgv5r0Q2jB4uejqvPtB16fMkpsYq+hzYK7ybdTFWguS7jZhFWPO3dqwsa
 P+ITelg9+MSPKJ4flewAVPWljwV535oIpZTnjlSo6Yg2bVSIQh2mT+vYoMdQ43J3kh3cl/wCSzZ
 okLx0/NP9P2xKVzSHHfxzBjiIQ==
X-Google-Smtp-Source: AGHT+IHHPl9YnA3+HHrElgtgPNjO0pocYNuettPyCEfqAF3i2hwtqBoPRnDbefR18g414RMK/v2n7g==
X-Received: by 2002:a05:6a21:e96:b0:1e1:b105:87b with SMTP id
 adf61e73a8af0-1e1c12b0430mr4417723637.23.1733928092810; 
 Wed, 11 Dec 2024 06:41:32 -0800 (PST)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd157d45d3sm10762949a12.80.2024.12.11.06.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 06:41:32 -0800 (PST)
Message-ID: <c24746c9-9d5c-452b-90ba-a125cac91ec1@sifive.com>
Date: Wed, 11 Dec 2024 22:41:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] target/riscv: rvv: speed up small unit-stride
 loads and stores
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
References: <20241211125113.583902-1-craig.blackmore@embecosm.com>
 <20241211125113.583902-3-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20241211125113.583902-3-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
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

On 2024/12/11 8:51 PM, Craig Blackmore wrote:
> Calling `vext_continuous_ldst_tlb` for load/stores smaller than 12 bytes
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
>   target/riscv/vector_helper.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 0f57e48cc5..529b4b261e 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -393,6 +393,22 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>           return;
>       }
>   
> +#if defined(CONFIG_USER_ONLY)
> +    /*
> +     * For data sizes < 12 bits we get better performance by simply calling
I think that the `bits` should be replaced with `bytes` here.

It seems that this patch aims to strike a balance between the overhead 
of checking and probing for the fast path and
the benefits of directly executing load/store operations through the 
slow path.

Could you please share any experiment results (and the steps/commands) 
that illustrate the performance impact when the load/store size exceeds 
12 bytes?

(BTW, this version can pass the vstart test case that I created for the 
unexpected vstart value issue in the previous version.)
(https://github.com/rnax/rise-rvv-tcg-qemu-tooling/commit/bccc43a7be9f636cfdaea3c2bfb020558777c7dc) 

> +     * vext_continuous_ldst_tlb
> +     */
> +    if (nf == 1 && (evl << log2_esz) < 12) {
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


