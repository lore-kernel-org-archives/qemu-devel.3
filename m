Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC47C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbRQ-00049h-6h; Thu, 01 May 2025 17:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbRJ-0003nI-94
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:27:31 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbRH-0002xs-AV
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:27:28 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso1827613b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134846; x=1746739646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7qXM56IABKG8pT9ggCuLevrSIPVSwsztVVfwlqAyj70=;
 b=WTO60WSeSep2u892vZ1Lp+VUVHrHXx6iabS6jszGfHZ8Js7+nLxZMUzo/A/cD2eoNY
 aP2aifkH6gzta8rJ7Mf6q4H3oWzTIFj5vSVtDQ0HhVKqTJgtSXK1+LfSNcdY8uw+Cech
 v2YSAWJxPUVxmbuS+hQSIjfkkNi0IofuZLAWeDxFql/BHJwfOXKMePbqoVdKTPsVOHVk
 mboZ+bd6fiky4kitjBMGr2ncBK57iDHgecy3gWriBhU3IM3vWkq6rUhRSgfe77AAdxB+
 Y01r7oHGTl6kfydQs0/z+NVS+nFnTWW8J7fQ9iwY0ubVl4iR4GHdqYd1CUY5SN165oHW
 +gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134846; x=1746739646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7qXM56IABKG8pT9ggCuLevrSIPVSwsztVVfwlqAyj70=;
 b=pD7lVzF7W0Nycu2twHLnsCG8NAgKYx3LUXxvFTJxBnjiNKKOT9tiqmrYxZJe8jNDCf
 gpK60Rs6joIwzI+xN8xsFXOu1l20K36TrDvwPFRnUFgj5UvSw74QXAAKMG/i9NFU+Ez1
 wtG2lQuV5spQLPjyhYqaKl7Fy4oCpJRXyVv5S7Y1VZvjtR2NFwPOtbBB4jQM/BdeMOSP
 5Lh3zfRfx3eTav5+1QQTn26ROQXjDe8XvCSw0XSjpmkL3HAOIPPglOmDDFkITml/RvM1
 jFNXdjQGlNwvpS0tfV5QTtR/zPQ1TpK43O+u1tyftgek6pNhgewn3wgQ3j0gLICABCyf
 k+AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiYZYDkdtpu2qsUeKxdHk1mTXnWNIOd+hDqZtEqnVucWMAD1pdwLpibPal6AJX/0wpCnlHvjoyJUff@nongnu.org
X-Gm-Message-State: AOJu0YzC6vyJX8QtsJ1SBkwxhJv/OLcjTr/fGycMp+LN14RRjB66J5RF
 qwFgboKEam3mYbcv0ehDV8Ud8sGGyHlA3QZ383iAVGdl/CuwhGJ7rO3g0Llu/P4=
X-Gm-Gg: ASbGncveBpMZ6uWcHpKeIKYLLtmSnn05uNVwcz+oo8DZT6kwEAr02i/6qeXZCJAQZnw
 wK6m3Vm4Fzeldj5fo4/+WbCBrGPA/y0upoEmAynXpidqLBNATXPZXBxwkDBuGMXzpAuZC53okWF
 uSRc2r0rUkFl6WipYrTv+J5HwoIvtggx9ASv//zgaIyuEA+k9fwNOiDhp6AZJZpO6pHi8jF6e3a
 +PzD8YCYc/0jLSHWoEeaGPAiMwKkQmQkZS70W8VIEB9rJMv1KbGVACrRxJqeEe3FJH+/AJOM/fU
 MCU7+wvRsOy9oMMjDbBH4xE7alYKXH3JfobNnSnLXPf5a+aRtZ5Xh0PwmUEUuGjVrUfRmGRVFbZ
 uEe/4El0=
X-Google-Smtp-Source: AGHT+IGsbNnZ7pTA+gP1hCmtyRRES/gzCF0IyjwSNIAgWzW5nOvJThthR4o9ZbcSPjVEGwAnqdBI2Q==
X-Received: by 2002:a05:6a21:9985:b0:1fa:9819:c0a5 with SMTP id
 adf61e73a8af0-20cde952d8fmr649991637.11.1746134845931; 
 Thu, 01 May 2025 14:27:25 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7beb2sm146326b3a.1.2025.05.01.14.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 14:27:25 -0700 (PDT)
Message-ID: <6d4308bf-5c8d-42df-a5f9-221dc1222ae2@linaro.org>
Date: Thu, 1 May 2025 14:27:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Support madvise(MADV_DONTDUMP) when creating core dumps
 for qemu-user
To: WorksButNotTested <jonwilson030981@googlemail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
References: <20250501181758.1057834-1-62701594+WorksButNotTested@users.noreply.github.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501181758.1057834-1-62701594+WorksButNotTested@users.noreply.github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/1/25 11:17, WorksButNotTested wrote:
> ---
>   include/exec/page-protection.h | 6 ++++++
>   linux-user/elfload.c           | 4 ++++
>   linux-user/mmap.c              | 5 +++++
>   3 files changed, 15 insertions(+)
> 

Seems reasonable.  Add a patch description and a Signed-off-by, please.


r~

> diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
> index c43231af8b..f8826d917e 100644
> --- a/include/exec/page-protection.h
> +++ b/include/exec/page-protection.h
> @@ -38,4 +38,10 @@
>    */
>   #define PAGE_PASSTHROUGH 0x0800
>   
> +/*
> + * For linux-user, indicates that the page should not be included in a core
> + * dump.
> + */
> +#define PAGE_DONTDUMP   0x1000
> +
>   #endif
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index fbfdec2f17..41c46da055 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start, target_ulong end,
>           return 0;
>       }
>   
> +    if (flags & PAGE_DONTDUMP) {
> +        return 0;
> +    }
> +
>       /*
>        * Usually we don't dump executable pages as they contain
>        * non-writable code that debugger can read directly from
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index f88a80c31e..62fc8ac921 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1247,6 +1247,11 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
>        */
>       mmap_lock();
>       switch (advice) {
> +    case MADV_DONTDUMP:
> +        if (len > 0) {
> +            page_set_flags(start, start + len - 1, PAGE_DONTDUMP);
> +        }
> +        break;
>       case MADV_WIPEONFORK:
>       case MADV_KEEPONFORK:
>           ret = -EINVAL;


