Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C732BD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeJJ-0001Bs-6P; Thu, 14 Nov 2024 13:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeJH-0001BX-4W
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:11:15 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeJF-0004IC-N5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:11:14 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ee4c57b037so738001a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607872; x=1732212672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ea/KZy4pMUypZfCAI/+M5qKcDT4H53YHmMVaAGp96JM=;
 b=tW2CU1pW/pAXyrgPlmE8c5PcA0PteUlFOV7+I4NcLOdsK0NBi+jX+Uf9dqY2VKNbNp
 bNbXUUFhxtstYAJ8bbbSnq+DSOq/9ekNDo2OtY1NiqcX/ntzm0uTGwv/6lqUj9z87GpE
 t1XBLvdD0E/yDz9y5aiGgtfTM8aDH21lyoGR9+CreANED8jtm/VxYihRqmjLZDwAX50U
 39UJzHK98t+6MDK/btINmrFdBmyEL/J/g/Z++DneNUfvQM4lFkbz+VFg5+5W3otcK+Uj
 uRXabKrZxFBVHdAhESDAEot8A4AVVf3QWVZtTn80ZcWmkzyCXeyV1N3KqVNow0SSnBx5
 U7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607872; x=1732212672;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ea/KZy4pMUypZfCAI/+M5qKcDT4H53YHmMVaAGp96JM=;
 b=wpb/mKQ7bd0m+zsA1EOqak/fp9H4/LqhUeHlDGbgjgEaNVFgmtkcDnD/OiucH1/se7
 1erIRaN3X2SMOpuPA6rQ1L0xTMV04TZPwcIJDA+4RU8IoSctDaBXHVyDXTsF2qX7MHsI
 on/maC7Q0Izg52bqZ743sJ2YiBEn5EvWaEJlYVP/NomyZ2ychDmRYNe+lkIn8wGW+f0v
 YmzYKsiCe1y/SsM51UfaeBHYOaOgSWY4SB8clH/q57S2Vd+zAvHJTISCCn3EEoAwgpgs
 KjvVqyjB1sJF/JQGAGHKMTXFqBgzmfLgFLJa455BfE4KwNh2CYjKvENb+8s/oYYwvrRi
 snbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2+XwYX4dT/LII+GV8yUTACILGfsz0hiEF+mNy+87YO8yCmlYnvPDRZ98CDVBKx2cqmreJ2YV7F1UV@nongnu.org
X-Gm-Message-State: AOJu0YxUROFd9K+TVj1A0R9OOLiJneEJgS1AveAIJPgfGtDIN6zJp9/M
 S/83Jl/fJzUq46isiCilI8mI8DoGQzOQO4Uo4vcyoffbvXZB6zZcmVMzIT1F4BwLJknG/3ZAS0j
 jMAOVLQ==
X-Google-Smtp-Source: AGHT+IHCnCv2GVUp8Qh0cxKZqm7Zui0QlYfBNFnEzIPgn/vG0Qz09Kh1pXOPfuB/Yn+SE6JF4VpG3Q==
X-Received: by 2002:a05:6a21:6d92:b0:1db:e3c7:9975 with SMTP id
 adf61e73a8af0-1dc833a9104mr4439026637.15.1731607872115; 
 Thu, 14 Nov 2024 10:11:12 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b3976801sm1406287a12.56.2024.11.14.10.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:11:11 -0800 (PST)
Message-ID: <c22708b5-994c-4b7a-9350-a7366d6a4312@linaro.org>
Date: Thu, 14 Nov 2024 10:11:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/54] accel/tcg: Preserve tlb flags in tlb_set_compare
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-25-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 11/14/24 08:01, Richard Henderson wrote:
> Before, if !enable, we squashed the entire address comparator to -1.
> This works because TLB_INVALID_MASK is set.  It seemed natural, because
> the tlb is cleared with memset of 0xff.
> 
> With this patch, we retain all of the other TLB_* bits even when
> the page is not enabled.  This works because TLB_INVALID_MASK is set.
> This will be used in a subsequent patch; the addr_read comparator
> contains the flags for pages that are executable but not readable.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ae3a99eb47..585f4171cc 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1032,15 +1032,13 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
>                                      vaddr address, int flags,
>                                      MMUAccessType access_type, bool enable)
>   {
> -    if (enable) {
> -        address |= flags & TLB_FLAGS_MASK;
> -        flags &= TLB_SLOW_FLAGS_MASK;
> -        if (flags) {
> -            address |= TLB_FORCE_SLOW;
> -        }
> -    } else {
> -        address = -1;
> -        flags = 0;
> +    if (!enable) {
> +        address = TLB_INVALID_MASK;
> +    }
> +    address |= flags & TLB_FLAGS_MASK;
> +    flags &= TLB_SLOW_FLAGS_MASK;
> +    if (flags) {
> +        address |= TLB_FORCE_SLOW;
>       }
>       ent->addr_idx[access_type] = address;
>       full->slow_flags[access_type] = flags;

Good that you extracted that from original patch, it's much more clear now.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


