Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438F9D5CC9A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 11:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t673u-0001KG-BW; Wed, 30 Oct 2024 07:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t673q-0001HI-8V
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 07:40:28 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t673o-00070F-Ae
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 07:40:25 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb59652cb9so64515171fa.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730288422; x=1730893222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+PZ5CdN9uKOMDhAIHDmLsvqs+nzb3ZYzgPxMXigN5+Y=;
 b=y4FqjvKtEJLn2KX8OZ5qhszyciyQVO4cm+5XfpRZAX1KF5ZyrTDMnwQ5KhPexRW3X2
 DX6SwWWSVu5z38ZwVU3gAilF1avwAGpvmeZ1+xVO/F6TYuGllv7labRlVMkmdWPmgJa/
 bmetXFenLZDMD71DGzbKxkYy5GpNhIDivuQethwpFEctpDsMzun/Bxh6lsedWstl9DYU
 ZcZNcEZY6GAW8sj/aiwggdES69rsO0tL2WcayFIE289tGbRdLRNSm53LBXZwBEHKtpM/
 USiEU1CSnvoNLwY33KRhGXYk0cjFJY3GHZN6VV3DcY/HW2afHsvmnB8Ec2Px0wQ6yZe0
 wQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730288422; x=1730893222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+PZ5CdN9uKOMDhAIHDmLsvqs+nzb3ZYzgPxMXigN5+Y=;
 b=SQVKe8C78anCQeXZ4WLOxPN5DMJGFKSHukyqhRmdPBZXYCxyxynX4xH57T32wrkUkK
 GOzk+npDffLIjEoDRoFLjq9e64CWGqJRAWFwyU92LyqBNztFZQVZjVA2Gia7Dh9TqgjG
 hQRf5Fd0fQ+s36rGuzEYjhFCGxTVN/nGsjWSwNL+pzmvL5hry2Er0EIzP54watXoEWAw
 3VOrXnSA7+KOACTDElhcthp+IT9fApPsmhONHL2BNJvHZit9SvQKwP4huOUpcTSVx5KX
 i/hfPo+Vcjeqvms8Wqo5sB/MQOHJp5vodQLH3E7nChNMi0d8HhRaap2Ua3v1xzZj3Pwe
 oKKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhXMyd80PYhXYmzz1XIACIK0jTHKg849u9bNpilhfu4J25gvp9fZHO752y7VqgQBxxoBPCubl6kw1h@nongnu.org
X-Gm-Message-State: AOJu0Yw8yj0pBjHT/+ZLk1x7XBTsm/IhmkWcJctetX8pwZEvAaPZBfUC
 h+T0Z3x+Sig+ZCEkcjcBQRrUf/suVz/uKV9zEoZOoI8XmymWEe4mX2OWmwJTYNU=
X-Google-Smtp-Source: AGHT+IGwco1axtQNIEF4+zACnRZ5JFnRnGzlc+t+8hW3f7Fgls0nfOwbwfcHTonW6JFTRcaXUmXvpQ==
X-Received: by 2002:a05:6512:2304:b0:53a:aea:a9e1 with SMTP id
 2adb3069b0e04-53b34a1afd9mr8447421e87.54.1730288422041; 
 Wed, 30 Oct 2024 04:40:22 -0700 (PDT)
Received: from [192.168.21.227] ([89.100.107.89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca8eesm19100815e9.43.2024.10.30.04.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 04:40:21 -0700 (PDT)
Message-ID: <7a046c99-c4e7-4395-8dc9-9139e9bfba06@linaro.org>
Date: Wed, 30 Oct 2024 11:40:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 2/2] target/riscv: rvv: improve performance of RISC-V
 vector loads and stores on large amounts of data.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
References: <20241029194348.59574-1-paolo.savini@embecosm.com>
 <20241029194348.59574-3-paolo.savini@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241029194348.59574-3-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x230.google.com
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

On 10/29/24 19:43, Paolo Savini wrote:
> This patch optimizes the emulation of unit-stride load/store RVV instructions
> when the data being loaded/stored per iteration amounts to 16 bytes or more.
> The optimization consists of calling __builtin_memcpy on chunks of data of 16
> bytes between the memory address of the simulated vector register and the
> destination memory address and vice versa.
> This is done only if we have direct access to the RAM of the host machine,
> if the host is little endiand and if it supports atomic 128 bit memory
> operations.
> 
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> ---
>   target/riscv/vector_helper.c    | 17 ++++++++++++++++-
>   target/riscv/vector_internals.h | 12 ++++++++++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 75c24653f0..e1c100e907 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -488,7 +488,22 @@ vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
>       }
>   
>       fn = fns[is_load][group_size];
> -    fn(vd, byte_offset, host + byte_offset);
> +
> +    /* __builtin_memcpy uses host 16 bytes vector loads and stores if supported.
> +     * We need to make sure that these instructions have guarantees of atomicity.
> +     * E.g. x86 processors provide strong guarantees of atomicity for 16-byte
> +     * memory operations if the memory operands are 16-byte aligned */
> +    if (!HOST_BIG_ENDIAN && (byte_offset + 16 < byte_end) &&
> +		    ((byte_offset % 16) == 0) && HOST_128_ATOMIC_MEM_OP) {
> +      group_size = MO_128;
> +      if (is_load) {
> +        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t *)(host + byte_offset), 16);
> +      } else {
> +        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t *)(vd + byte_offset), 16);
> +      }

I said this last time and I'll say it again:

     __builtin_memcpy DOES NOT equal VMOVDQA

Your comment there about 'if supported' does not really apply.

(1) You'd need a compile-time test not the runtime test that is HOST_128_ATOMIC_MEM_OP to 
ensure that the compiler knows that AVX vector support is present.

(2) Even then, you're not giving the compiler any reason to use VMOVDQA over VMOVDQU or 
ANY OTHER vector load/store.  So you're not really doing what you say you're doing.


Frankly, I think this entire patch set is premature.
We need to get Max Chou's patch set landed first.


r~

