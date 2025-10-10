Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9911ACCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GQf-0002B2-O7; Fri, 10 Oct 2025 12:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GQe-0002AS-QB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:57:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GQW-0007sG-Sp
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:57:16 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-782a77b5ec7so2138851b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115420; x=1760720220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pf6DqYhLys9vVFknX9I8ydYubWfT3qAkpEC9s2UPNhM=;
 b=LytgH/FCOjQN2sipK4DATXv9hw85TOPm8DJd+XCkiDT5PIeev5JvMlMLFvjEYZ07bH
 uC+/1wWInP69SawSWVO2VkkmVWVXoTvRjnOt1YjxbMbHa3MKIq1yf7V+1wOy5Td5qKX9
 qTgIdBfE8I4harmvLzUAqMxOUhWB+LNhDvKhN4NyMFDNx71pEOYlTC8wYVyELxbc+y9z
 DJfQ2C1ZU7rkQio0L4F35YTBubWVEJld0wxll823uhTuhU/lJP6vju3EzR5xT3fUwhTl
 zdkcIGdZ0LLXbN2eAp4vo4QFPdqClrXFBUbH1obelMvQCECj2FNY+Z6UeieKEZtlMyFR
 87Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115420; x=1760720220;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pf6DqYhLys9vVFknX9I8ydYubWfT3qAkpEC9s2UPNhM=;
 b=CJLf3Qa66cjkA/W5eWWe23VIrZ7sRncCGV8LZ3m2oesObLfWGAAgrKlG6N2JHVqGp/
 AqikE760tNLP59AhjvArUctI+qEhnLZV0XMI2no2q1IS0rpKu6NOtdNDgUKI2PMezJ/D
 ooPJWnnpqfXPZk70smWdRuGAoicJHk8PvH5bDtmfU4IFJ/i7SAmTmZiI/VIqWJsDN2XE
 SQYymapogJCV5AwcODXhje4cFmRzLC7oZLz9jjM4Ghfjrg93rwIg4jSPDldHNlTUaEA/
 +w+/1+XCIu+eXxVuR7Tfb6KzUDpMzF73Xbqw9HPSXRpwXnE3h/i5odM/FpFe1f9/7H1P
 QCSA==
X-Gm-Message-State: AOJu0YyZMY+TbFPsjt8g1ZuAtrGiZ8ftxRraWj4PZUBWUo4BFxt1+8is
 vcYLQu0xKf+MQeHfWj3eXT4kPGnOPvhc/TCdeSe4elq0DkKyyV0MRUqXohZgUwybd5iVANohPcg
 tPcRbIe0=
X-Gm-Gg: ASbGncvd9FdWJCGZYsvEEZtmex9VYl2BvfX0CvJPUcJn4b952LknA/M0cYYIHa2KvzZ
 99slvcBrDN8qdTJXoIah0QhkiRRfTxSx8OSurqb5XBm/QpdkydwoK4i/nNyYCl2MAwZA5tkErg/
 kvnGIKWOrXd5ocdyrQO4D0jWgdvWVuLZVTF980NwxWDuFLYODiLnBPb3a/Y0DkwuiWsXAHhygEd
 07/OSJ5cincsk1TQe0gbiPZZIydAW5+fWtM1lXq0tWjWugWnwKLZQ/PoyxnUK5OuzRJIwgCFyYH
 2MpmygHqYB5U1XuYh2WDOjNrIPX9jsjh4LJYKpfrGC/V/lTT64poerc0wrr6WzCofY2/2yXK6rq
 6CAgwCgG/+6KC1ahnLxT5UOAgaldVeybrD5p23pi0qFHHkKfDXDM20XoIRuM=
X-Google-Smtp-Source: AGHT+IEsXfEY08hGV+hYilgSWsd5Htugm+GKIFpuczdMj8CeN/LHpMVy1gFUpCh70zlP6vq0+0908g==
X-Received: by 2002:a05:6a21:3282:b0:2df:b68d:f64 with SMTP id
 adf61e73a8af0-32da854060cmr16800662637.52.1760115420175; 
 Fri, 10 Oct 2025 09:57:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b6262de64sm3452183a91.4.2025.10.10.09.56.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 09:56:59 -0700 (PDT)
Message-ID: <18d49c34-0615-4f16-8d03-013e04192a1d@linaro.org>
Date: Fri, 10 Oct 2025 09:56:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] target/tricore: Replace target_ulong -> vaddr with
 tlb_fill() callees
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> tlb_fill() provides a vaddr type since commit 68d6eee73c
> ("target/tricore: Convert to CPUClass::tlb_fill").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index e4c53d453dd..7574111c87d 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -35,7 +35,7 @@ enum {
>   };
>   
>   static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
> -                                int *prot, target_ulong address,
> +                                int *prot, vaddr address,
>                                   MMUAccessType access_type, int mmu_idx)
>   {
>       int ret = TLBRET_MATCH;
> @@ -61,7 +61,7 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>   }
>   
>   /* TODO: Add exception support */
> -static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
> +static void raise_mmu_exception(CPUTriCoreState *env, vaddr address,
>                                   int rw, int tlb_error)
>   {
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

