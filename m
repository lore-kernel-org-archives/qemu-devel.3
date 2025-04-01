Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B50C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcPE-0001z5-Th; Tue, 01 Apr 2025 10:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzcOv-0001nv-QY
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:15:38 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzcOt-0003vL-OQ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:15:37 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2b38896c534so2790630fac.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743516933; x=1744121733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+niUk4hllGfo1ecXcHPz7DAqUee7zlLULc12yB46VmI=;
 b=FvFw+grDoFOmoULFUORW0vw9ibXW6bq4Rbk9adMhS1qR+X28ceJVS590pXKZsfU7Ta
 rOJI9RzCyqxrsr0NZLxl8isNI8i4CXS7p0Xv8ripC3+cnMl4/s5JnAxTLOq543ptRqoW
 ZTIOCeXnQ7ok4cGxT+2tRRy459BCLWUEQyYschFvGTX81FALtY755h2vAYCtgUeia8gy
 MT4wjAp3rDrSWO53dJITzSt8lTwQt1vHhn2v7qwREMvrP6E939jtv1dOEY7pCJ5amvx6
 AiynVq0sYt2AnI13sQS7iNllxD9OO7xFU7OJ+u7UTmObMZC9Xx/MAWRMFVlRr1N87doo
 FRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516933; x=1744121733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+niUk4hllGfo1ecXcHPz7DAqUee7zlLULc12yB46VmI=;
 b=BPG8msKDMd0HcNwMWA0U5azsxzSAQVafI7wNmiMYQorLsqBozx1iKHLefUj5XLWkAN
 DndbXs+ERoHRvAMhVV6qcMznxWPROnGOE/Y3dNmZpiFz64fEvJN63RbNwIK8Oyv6uxfA
 7EStrYeQTB+woiqL4cRTWn4adFM7UMSwcZp8YNqi0Kp6W3o9mVdnb0Kv4HfbkHaLYhOC
 NG7x3FsM5UOgQef//duwKaql4JasSnMqOQq8IHwlJJvxpnY1Gi15eGRDzoRMITO3PN70
 VV1nO5EkhmDc8VyGkT4wGFktAAyjQ098BtQMb5Pb8ht3TXKncPlMC6LwPzCooluukskB
 pXSA==
X-Gm-Message-State: AOJu0Yygt8KEdtWkTmdTKShv0ua4ugU3YiRy1uqFuQ7gziQSpeFowDJ5
 nkI7shn9pedcfBy0JtDawN64HDw4hi1iMgUMPBTxlam7thTiSUEkPSiSbjOUXQ5nbIN1IlZCvc5
 c
X-Gm-Gg: ASbGncsINpYcQOW5xSwh34HYGc04KXC4OO0h9liPlk0d2f8ChvoLz89+71tbhWrABq+
 hhbA4EzkiM9cIwNgUfZBgA4v6crKYkHlHWBq4HBSNNB0py4Y9GT56d71kmnf5OzaJrGLqpIdThc
 XMO8A5/wNOj2HgCVziip6eNPz4pswtIX9gRcjCjBeUYU5V1dBTxou5k8WvBKV8mRvaw8FyEaxQt
 Br9bdQ3gLNqVYyF6GAfIUz7O/QbPdjGUxwqNwbnENBuZptO6Mook+dBqbKUFp2lgxeeXCLCTDgo
 eXWzHiyhoE02sirkpatmwnHcOVc8megUFXkx6/DtFCZWaDt2ztfJ+Qc6mpABHt/h2VCbqbJnczc
 h59DPAgccrfl5mZulykyYXg==
X-Google-Smtp-Source: AGHT+IFoX5sP3PhnqavWSCKSAqgTs1qkME7VEL/1vkh6s/dHBLbMY0lO19N+8IRvsEI0oS7kzAeuOQ==
X-Received: by 2002:a05:6871:3a27:b0:2c2:5639:3a4d with SMTP id
 586e51a60fabf-2cbcf848718mr7250839fac.38.1743516932763; 
 Tue, 01 Apr 2025 07:15:32 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580f29b2sm1868081a34.40.2025.04.01.07.15.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 07:15:32 -0700 (PDT)
Message-ID: <d2c19fbc-a8ac-46c1-b3ff-b9ed8d330d25@linaro.org>
Date: Tue, 1 Apr 2025 09:15:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/rx: Fix copy/paste typo (riscv -> rx)
To: qemu-devel@nongnu.org
References: <20250401072052.25892-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250401072052.25892-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 4/1/25 02:20, Philippe Mathieu-Daudé wrote:
> Rename riscv_cpu_mmu_index() -> rx_cpu_mmu_index().
> 
> Fixes: ef5cc166da1 ("target/rx: Populate CPUClass.mmu_index")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 65e26e7a6b6..723262f4b54 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -67,7 +67,7 @@ static bool rx_cpu_has_work(CPUState *cs)
>           (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
>   }
>   
> -static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
> +static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
>   {
>       return 0;
>   }
> @@ -228,7 +228,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
>                                          &rcc->parent_phases);
>   
>       cc->class_by_name = rx_cpu_class_by_name;
> -    cc->mmu_index = riscv_cpu_mmu_index;
> +    cc->mmu_index = rx_cpu_mmu_index;
>       cc->dump_state = rx_cpu_dump_state;
>       cc->set_pc = rx_cpu_set_pc;
>       cc->get_pc = rx_cpu_get_pc;


