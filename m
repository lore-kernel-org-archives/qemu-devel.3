Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9154C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 00:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skugu-0004P8-PW; Sun, 01 Sep 2024 20:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skugp-0004Nj-Kd
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 20:13:03 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skugo-0004tL-0Y
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 20:13:03 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d877dab61fso1285422a91.3
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 17:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725235980; x=1725840780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yc+VPVnFPO/pMwvWd5m+AbWo9/GcBzAjwWFYro2xepw=;
 b=hM+dRWryx2ExAdv6VTiRo93XbNpGa9rXSVicr5W0EKNs+JN4GFq9D6cJw6icLrYKr0
 oRPEQgf1Tpfvgnn0RaDaAr7a5cOqzh66OLls+3g1MZNmDarIoSzjZuieaJ1scR/m7l2c
 y7r+6M4uKLQCOwHKb+1D7cIEtOMqMSXpG7Apcn8ENe+viecZ6zDQeSPha8C+muOMocqZ
 Nj1MEMakK3PXqW3JY672LZ3c7yb5QeBApc5PerIoAF+HjwvkeqW8lZsa2b3bMQVVUyyY
 Q8NPV9tBEvhgOQr54coxxu8HjtnTO7DEuQODaGJutkBqs/LYeTzNCqvaA2dN4B5p5ZAV
 QswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725235980; x=1725840780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yc+VPVnFPO/pMwvWd5m+AbWo9/GcBzAjwWFYro2xepw=;
 b=ZvWOkZ4rsK6K0s4DhayCXymgCJ5Y1c27bc7Oa7/M5sqriFxe2EH7VP42DX7KndcxUw
 QvPybjVob3Fj0ddkpJ6tvg9u6MxQq+nS6k9nlAume5Hb1/8RVPkkHPJcDW74qZcUwnWh
 ajYtzXCIJuhh+DpNaZoxn+PkLhLLor7KVT6kLIfrGYkWX4P7MyNNzD7CWHbI2iioGb2G
 dzxGvLHduSkR8mWV/qltl+5OA4x+wMhjaKN63F3wma8DCnRIM7ulJEdOSs9KA2G5YxVS
 ct77rLDPSZQquYoQVq9+MEOR789RQ+UicDEmGr3DVcp0MyJp9AwZDeOscc1wO/2iS7Bx
 BniQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqExIGHxRTRbcaqa0Cy9BY43ifX4Luvswma+mGdNC22g0A8abEGUOxMyf7gMCUaiWKBwZ3Zy73L5Ny@nongnu.org
X-Gm-Message-State: AOJu0YwnN0b7+RKUL+ye0+OEBRl96+KZuIpJ9BEngEh6whCKka20aP7T
 shxdBM03CDsBfoCuv1V92TWton8L+Gc2uOffk60nf9dLkg2kDuhsHOx1+367Xgo=
X-Google-Smtp-Source: AGHT+IH3WWEgiwS6M/JLj4II9pOHmX2qAXrsxoz+XnIyvqCEcVrt6nI2a0ZoNI3pCkGWQUxB3XZxzg==
X-Received: by 2002:a17:90b:3141:b0:2d3:c862:aa80 with SMTP id
 98e67ed59e1d1-2d856503ac0mr10749138a91.41.1725235979739; 
 Sun, 01 Sep 2024 17:12:59 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:ef9d:e346:b99e:7072?
 ([2001:8004:5170:1fd8:ef9d:e346:b99e:7072])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8c399f7c9sm1585028a91.21.2024.09.01.17.12.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 17:12:59 -0700 (PDT)
Message-ID: <b9562511-007e-4144-9291-119251c2d4e8@linaro.org>
Date: Mon, 2 Sep 2024 10:12:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] util: Add RISC-V vector extension probe in
 cpuinfo
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-3-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/30/24 16:15, LIU Zhiwei wrote:
> +extern unsigned riscv_vlen;

Do you really want to store vlen and not vlenb?
It seems that would simplify some of your computation in the tcg backend.


> @@ -49,6 +50,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   #endif
>   #if defined(__riscv_arch_test) && defined(__riscv_zicond)
>       info |= CPUINFO_ZICOND;
> +#endif
> +#if defined(__riscv_arch_test) && defined(__riscv_zve64x)
> +    info |= CPUINFO_ZVE64X;
>   #endif
>       left &= ~info;
>   
> @@ -64,7 +68,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>               && pair.key >= 0) {
>               info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
>               info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
> -            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB);
> +            info |= pair.value & RISCV_HWPROBE_IMA_V ? CPUINFO_ZVE64X : 0;
> +            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZVE64X);
>   #ifdef RISCV_HWPROBE_EXT_ZICOND
>               info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
>               left &= ~CPUINFO_ZICOND;
> @@ -112,6 +117,23 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>           assert(left == 0);
>       }
>   
> +    if (info & CPUINFO_ZVE64X) {
> +        /*
> +         * Get vlen for Vector.
> +         * VLMAX = LMUL * VLEN / SEW.
> +         * The "vsetvli rd, x0, e64" means "LMUL = 1, SEW = 64, rd = VLMAX",
> +         * so "vlen = VLMAX * 64".
> +         */
> +        unsigned long vlmax = 0;
> +        asm("vsetvli %0, x0, e64" : "=r"(vlmax));

This doesn't compile, surely.

s/x0/zero/ is surely the minimum change, but this still won't work unless V is enabled at 
compile-time.

You need to use the .insn form, like we do for the Zba probe above:

	.insn i 0x57, 7, %0, zero, 3 << 3

I have verified that RISCV_HWPROBE_IMA_V went into the linux kernel at the same time as 
vector support, so this probing is complete and sufficient.


r~

