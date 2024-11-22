Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17588E69191
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 20:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEaKF-0006sH-9L; Fri, 22 Nov 2024 15:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEaKD-0006s6-Q7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 15:32:21 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEaKC-00054g-BH
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 15:32:21 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-296539a58b4so1449738fac.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 12:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732307538; x=1732912338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6DUw4FGMVo+PMACX2UgvPvLMGgk9keNv+PGsqaPN/Gg=;
 b=yJZleBSYUxPkx6zjVt7khLzvEux7Tp81vug0pJ59uTEm7KmIqlZjx+tAa1N0bpYt5O
 oeALPcDc8AnA0DZFUHmqfWHESaND5TduJWcIbL2Yj+KFK1PRl1zY8IUoavAkAA0lQCzq
 RcRzjs90zGK17WwwxYUYbSfZUySH0XcNC3OKt2aYoxMUx43KhPmXvKx5ACDbWjstLkWJ
 iNxfLH7QFE4av/pbaAbR+TjJlwjV5aZU+LlWVepO/hdyQE/j+J+MnvJ0N6T+YVWuYPk0
 tZip41KG/V0qq6efWK/V1NoAI+FTlKKrTwGVJfLcSyjD7Rqalfp0db1zJTYcqaHZLM1T
 uCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732307538; x=1732912338;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6DUw4FGMVo+PMACX2UgvPvLMGgk9keNv+PGsqaPN/Gg=;
 b=IZwY959e4EJoSLJlSoxc3RIPB2MsSjERJcCVO/jV09XO/9rqpcIGGiCGCmFFVTKHg/
 96d0vIlr+LT6tFPAJlyEjuJCUIZRVMJVe+DSJ8IeYBfnBESv1enhwL56mnbGomebXQ5a
 gbuymh54e1Wl6BbQe0KSQ614u7sPOR82jPUVRCCGWzru0+TyPr/pXrCPFjZku7mc5FDM
 6N3ThrTPn+NqngspqNDPuOtAXUZYqz98GojGs+kkykZpzKU09zjBFMChCxb/PfmZT3qt
 Bq5lTbWycQbVW0o2L886E4ErKr6PTxWjHSnm7b9gJNEf+5cjoPVMFF+zmKK/l6zoZtiZ
 R3lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmoa6rZiGUlLWrq7+Jkjun7mwQpAmy82LxJoSl5OFndYmnS+fYniRAENxgQSDzt1JHFCkZ4mHnLlsU@nongnu.org
X-Gm-Message-State: AOJu0YzILOAVYVc/ou8U0Feno86m/Vs58cjOK/OCQSYj22LIxrKjwGsf
 r/0LEKrzUWNMe5PMSeCjYV2VMGnmEQAGuAhv0eLRmwF2EQZ0IbsYAhVUc/C93kE=
X-Gm-Gg: ASbGncvY4oZBHEIsxqxvXYLRe1zn7ggdmiSjJu/DGanY/qGEd3ou8dZLpgTg340FcjF
 MshIGZTOZ8AGojRZXoLrQ6O0wgaXxeT3Sn/o/ILFU4km84OPVrjkCaRSNa85PnBzqzJ8/oBrw/c
 8XbXYFohT4eZtK4l3rZOuidIX74iO5QDmO7Ei1G8XyYnswUoqLE8wp7ooKC8bjSDxEut1F2vED/
 W/9yI+PnlYZ8+mUvysLpJcKaxJOoiGbbRqZOUwR+SYwRZJ58Id83vTGCRYaWBUATpRp61g=
X-Google-Smtp-Source: AGHT+IF6bLk+d/dWBz31xJMH6gaFj8r9ZUUA5ekp194C8o3z2ywBlXKBHg0vWNjWVXsuTfO3UAWLoA==
X-Received: by 2002:a05:6870:8992:b0:296:a7bf:b503 with SMTP id
 586e51a60fabf-29720b45681mr4532139fac.7.1732307537552; 
 Fri, 22 Nov 2024 12:32:17 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d56d992sm803351fac.9.2024.11.22.12.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 12:32:17 -0800 (PST)
Message-ID: <4d3f8a83-7c03-4b48-9a84-d99b88b0d47c@linaro.org>
Date: Fri, 22 Nov 2024 14:32:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Fix cpu_memory_rw_debug for armv7m MPU
To: Xiong Nandi <xndchn@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241120151515.56884-1-xndchn@gmail.com>
 <20241120151515.56884-2-xndchn@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241120151515.56884-2-xndchn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 11/20/24 09:15, Xiong Nandi wrote:
> The actual page size (region size for MPU) of armv7m may
> smaller than TARGET_PAGE_SIZE (2^5 vs 2^10). So we should
> use the actual virtual address to get the phys page address.
> 
> Signed-off-by: Xiong Nandi <xndchn@gmail.com>
> ---
>   system/physmem.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index dc1db3a384..a76b305130 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3564,11 +3564,12 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>           MemTxResult res;
>   
>           page = addr & TARGET_PAGE_MASK;
> -        phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
> +        phys_addr = cpu_get_phys_page_attrs_debug(cpu, addr, &attrs);
>           asidx = cpu_asidx_from_attrs(cpu, attrs);
>           /* if no physical page mapped, return an error */
>           if (phys_addr == -1)
>               return -1;
> +        phys_addr &= TARGET_PAGE_MASK;
>           l = (page + TARGET_PAGE_SIZE) - addr;
>           if (l > len)
>               l = len;

So... I guess this might accidentally work, but L is definitely incorrect under the 
circumstances.  So we could easily be exchanging one set of bugs for another.

We really need to be returning the range of addresses under which the address translation 
is valid.  One solution could be passing in 'l = len, &l' to be modified so that (addr, l) 
translates to (phys_addr, l) after the call; iterate for sum l < len as we're currently doing.


r~

