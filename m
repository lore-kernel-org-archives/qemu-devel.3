Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C76BE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVuTO-0008Sx-Gb; Thu, 09 Jan 2025 10:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVuTN-0008SP-CK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:29:25 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVuTL-00070e-0H
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 10:29:24 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2163bd70069so17383495ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 07:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736436561; x=1737041361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TJvPwFwqoYUVJFGIOuQcANbtbOEw+OYpBfPrpWZvpUw=;
 b=n+e8jQyPpXjnHHSYR2sgMi13DZcgYyB5a0CJz1tL374m2VIOdvH1u46+ZnWWvzRo2/
 y6liTPU1jpESNS6Qk7wZUnAJRa1Ok408doJKh9pZTGSShmQ/dVlU+DMLV6clZXcvPbaF
 zvRU4L7G63nFLBCZ4AO0Qd0+AXR8Bw0ICXJtY3GwyYb0zyjCQOj8eu/pQhPP9lentckv
 WYjnZF7sU4XHwPVh62nRwQDXKiA2HcW/f29xvW2xIngtRr64ydA0dSpHSgO/yVicbQMq
 qgLCkg7MAkW858B5FBe3H3huiOpt45aiOrCqJYqlCVecCjqXjyk+T37TR1jst4ua3V1f
 YrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736436561; x=1737041361;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TJvPwFwqoYUVJFGIOuQcANbtbOEw+OYpBfPrpWZvpUw=;
 b=Niaj5aH3ohBCZ3GSXdUw2oy0nKMhsqkNyPHGWUdUbjnXGn629XADTxZa8HTuYRCzXC
 1f+Hk9Om/dsvU9PPeoVV8+Hzc9v+acQVOG5Ho7gljfGDLVj17qvxXlLhPFlhQj9aFUs0
 EOcV6rIMt9GSq91Pmwd2+o/qyG2cy/+KvtQ62gC6BjcOokGWbs4R6UY3R6zXuQPhp4QS
 zWkNcxOazYRwnD9zHLX70G+zd11UtA17Ehu7/DPCFtnAhRo/r+mrQGhB4jjGQipLcQhD
 gGh+NVGxeCHN2Niz6oWtE1tVsCkapJMzuwssSOcSgi+LfsaCxnYdV3LI38jknkhWdhRz
 OMzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWzJ+rnPJ6h6S10YsOE54VA6gyWKfSiXiT1dFFS5mL5CZyNvAkFMFQA8R1qZMgLBom2Mg74aKxWV75@nongnu.org
X-Gm-Message-State: AOJu0YwYDPiAluo8SYT4yZHDbgXnB00rWXXZjX/u2GG72zjQaKn8h3pu
 akjlP9zqgrVkroBvJb381QL4p4xsaiv9dMmnJSNLUWG8U8LR9MfkXE6yuznaIYgFoe4lKfPMGmo
 G
X-Gm-Gg: ASbGnctrSpv5Uxj5fHmljkdGDak6cGHDY/E93W0ShOyAV2glb9WcdoWWcN1jlxsMbBz
 8b29+kqHze3fGO/8ub2puQiL724SPwKsW+uUnFa7kCLieol9wB04/YlYS5esPSeJmGurVqFCwwl
 cYvXmB2z+A0hN5TBB0WpmR4d80iBxWQdfd+BDOXBwi6uVkBPUTtXLza0L4ifGZkahiJ/EvCgbnN
 28fJ16uU07DLecjLI7KHvK33nGKfllC5ORjCC8PIUQ+8wlruK1WpnZhyEQk3+WXTNeDnbRxPi3N
 hWjnIlJYVxJRF3nSLUDiXmIb/B2olg8=
X-Google-Smtp-Source: AGHT+IFdNV0/I1URODg0EczzVisKLg+lbvH8x/IkrIRkxPBNwxcxGr5LvnhMBuL8A6ONfUr1voP7ZQ==
X-Received: by 2002:a17:902:ec83:b0:215:e98c:c5d9 with SMTP id
 d9443c01a7336-21a83f57012mr86766935ad.18.1736436561378; 
 Thu, 09 Jan 2025 07:29:21 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9c435793sm761885ad.195.2025.01.09.07.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 07:29:20 -0800 (PST)
Message-ID: <fae8c340-380d-4a20-b9c0-7a9c95f27320@linaro.org>
Date: Thu, 9 Jan 2025 07:29:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Add missing /proc/cpuinfo fields for sparc
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <Z39B1wzNNpndmOxZ@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z39B1wzNNpndmOxZ@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/8/25 19:26, Helge Deller wrote:
> Add some missing fields which may be parsed by userspace
> applications.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> v2:
> - fixed cpu name and type depending on currently active CPU
> 
> diff --git a/linux-user/sparc/target_proc.h b/linux-user/sparc/target_proc.h
> index 3bb3134a47..744fa10730 100644
> --- a/linux-user/sparc/target_proc.h
> +++ b/linux-user/sparc/target_proc.h
> @@ -8,7 +8,25 @@
>   
>   static int open_cpuinfo(CPUArchState *cpu_env, int fd)
>   {
> -    dprintf(fd, "type\t\t: sun4u\n");
> +    int i, num_cpus;
> +    const char *cpu_type;
> +
> +    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +    if (cpu_env->def.features & CPU_FEATURE_HYPV) {
> +        cpu_type = "sun4v";
> +    } else {
> +        cpu_type = "sun4u";
> +    }

Maybe

#ifdef CONFIG_SPARC64
     ...
#else
     cpu_type = "sun4m";
#endif

?

Anyway, considering we always printed v4 before,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> +
> +    dprintf(fd, "cpu\t\t: %s (QEMU)\n", cpu_env->def.name);
> +    dprintf(fd, "type\t\t: %s\n", cpu_type);
> +    dprintf(fd, "ncpus probed\t: %d\n", num_cpus);
> +    dprintf(fd, "ncpus active\t: %d\n", num_cpus);
> +    dprintf(fd, "State:\n");
> +    for (i = 0; i < num_cpus; i++) {
> +        dprintf(fd, "CPU%d:\t\t: online\n", i);
> +    }
> +
>       return 0;
>   }
>   #define HAVE_ARCH_PROC_CPUINFO


