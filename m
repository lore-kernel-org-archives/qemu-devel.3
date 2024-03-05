Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09433C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWyz-0007Ih-BM; Tue, 05 Mar 2024 10:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhWym-0007I4-4B
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:45:26 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhWyf-0006FY-4W
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:45:19 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e58d259601so3698087b3a.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709653511; x=1710258311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Ip500dlxzfGuh2FzRWKT4kqSpk/fKaCL2rIPzbIeh8=;
 b=NWzrOp1P+x2uZ7uV2Fmknz1YohUgnw6Dvc6PnFoBR4t+Ter5QgxZQFQ70MO1ZJLYTK
 lvcvAn1m4DEkudH+dqzODPxTFUhZv5ayBTVWBMaJLtrOt6I2qMiQGKrVPt90EvhQ95en
 JI7OgoChg7Sh1NgU28Y/92593MuOgpw2NMr9k/FsDto8CEcEWWxWfUMYfE35C7VXC+f2
 XvoYUGGab8pMEgocrOIyZiTGRliQCs713hTi22nuZmVQOfhj0BjTLjn6nvrBtlu4Xpfn
 p72+dxgzT82X99zyJzWrT7M0yDkSvmBBPSI3PjGfvuCsHjCPkLrDR3IKthc79lsOrIxb
 QaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709653511; x=1710258311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ip500dlxzfGuh2FzRWKT4kqSpk/fKaCL2rIPzbIeh8=;
 b=cLoIi98LGinX5XSt+EVdpQ74uTFES7v+QJEBy4DLNX0S5vMP9zsVEXbnL5HcJgfLbw
 Jb/UMW099d6c5xxGyGByjjWM6ocggpCGL6gu5tP7UuUUHbeFqN6SS8qzZiZsX92H68EV
 5z+vLvL6i54iH9AXINVwFseQM3IgPoA74XG5PvAcikmTgntPPWBCLP0xMcQnqguk/1MR
 wDs0sLoRrBAbd+uCFOiEjASHFs/dMsm3AN5vqcftO36SV08J5jP2x4OjGvCipby9L9XY
 CX34JiEc3FHBH/Hv43+Pegk3YHjAjDeHuwfjmIyNcpYV4TOZCaE8elg9O5kV4gIRSPBx
 uV3g==
X-Gm-Message-State: AOJu0Yyssesn+dmWQPR242zCq5X99qN9KpUrNkkKL2B9jcywBax0IfNJ
 43WVphEjNSEJxsTH2avALIr6RqQrL0ufi+ZvTsI6FvNif8isg0rk0eup6yJek5Q=
X-Google-Smtp-Source: AGHT+IHCwR0jV88kE1J3fJY2CVjYe85MLMCyZPy09ZQcIt2uzI9OCzC/snAjqbS3x9L9eDws5YZvAw==
X-Received: by 2002:a05:6a00:1955:b0:6e4:eb29:357 with SMTP id
 s21-20020a056a00195500b006e4eb290357mr15582680pfk.12.1709653511382; 
 Tue, 05 Mar 2024 07:45:11 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 y19-20020a056a00191300b006e482a238b7sm9018006pfi.31.2024.03.05.07.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 07:45:11 -0800 (PST)
Message-ID: <31e8832d-d853-412d-8f98-c4b91febd450@linaro.org>
Date: Tue, 5 Mar 2024 05:45:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/loongarch: Add TCG macro in structure
 CPUArchState
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240305062644.1564155-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305062644.1564155-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 3/4/24 20:26, Bibo Mao wrote:
> +#ifdef CONFIG_TCG
>   static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
>                                      int *prot, target_ulong address,
>                                      int access_type, int index, int mmu_idx)
> @@ -154,6 +155,14 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>   
>       return TLBRET_NOMATCH;
>   }
> +#else
> +static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
> +                                 int *prot, target_ulong address,
> +                                 MMUAccessType access_type, int mmu_idx)
> +{
> +    return TLBRET_NOMATCH;
> +}
> +#endif

You may find that debugging with gdbstub or the qemu monitor easier with a routine that 
walks page tables for loongarch_cpu_get_phys_page_debug.  For kvm, the existing code is 
insufficient anyway, because you'd need to emulate a hardware page table walk, not use 
env->tlb[], which would not be populated.

This can be improved later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

