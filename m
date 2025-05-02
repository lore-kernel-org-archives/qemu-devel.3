Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB309C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 08:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAlN6-0006rc-LN; Fri, 02 May 2025 04:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAlN0-0006qh-US
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:03:45 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAlMy-0001Wi-Ug
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:03:42 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-acec5b99052so281072866b.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746173018; x=1746777818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tiJvtTX5wuZG3YSRsS5RnnZOinfylkMzkNba9BpdC78=;
 b=dNIl52FMxDUMkoQkt7HJV9M1mzKV4ciTz273hTBYGLn7tQGvplCCUhH2FcImTA3tu1
 WlYCgpddWZvYw5qmamE+0XRiuBvOjesaOcJBfQiHtV1tZeRFMO3L2dBW9yYD6PAcx6j1
 4hn0bgE6A/zfuJkrdD6Hq1hJrWOzljFEIXW0hIQcHovBK6CQFuwyn/IeWfllouhVKVMb
 fPLMz7mgsOpLq4+4ZObG7vAwDfSB4N73JBBdkWkJtigUQfmHGT8O3csVDOD6kSOlpk7k
 9ZYtYfrPn8sE3op5v8gPU/C+eNK3GfXjfyWUf5uuzyASgUPJ+S32vmDRnFI6mLovkr15
 IYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746173018; x=1746777818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tiJvtTX5wuZG3YSRsS5RnnZOinfylkMzkNba9BpdC78=;
 b=ttY2cjYYWtAgc/upq36Oa3va8+Bdx3kvmC67ysDXTPKcm6+rsj9J/1ir6lYxSt1+h9
 HQndxYwJvZiuVREMrfv5yqEufjng2YlhP6qDqCdb0GYkEFeGUxScf3ocI98ydBV5YdWo
 2OyEwyQj02GIrzGqmDKcAE7/73Oz3lF8LvcIBP56NDk57y5utoP2PgHyQpNOETifYlrh
 ORvi36ZaIPK5Hjjy4Sbk7I/A++K7J6jc+JG/D5PwaQIlz0WZHbKj3W9k+CjKMtbZWdN1
 GCg2DyhsZvid87Yl8mAxDy2FusDG0ojmJcYVW4Us3sR0qTlwbx2hBFb1ccyfJhzvPCmb
 IZRg==
X-Gm-Message-State: AOJu0YyRHaOKx0ArWr38ucu1XqgX6DdKm9K5WDnfB8A2JUWLkMSj8OGo
 ClWKI1q6ZjHmdjarRYI48pfrEbPc8270UPBAyIpRPFPBVoH7TCFVvsDa8ZLb/ZgHG/1CEkTzdMM
 u
X-Gm-Gg: ASbGncv68NysvVG10TkPoc9Tt8XtcEcLw2bqgAKe5MNLnv7Ba1UTr6qa1XwOV9JBQij
 3Ms65Jzp5/OK1KbmHvDAFEMd1bREmbl/8vk4R9fTTA0wf6o9aMlZFQXk8tmFSNBGuMaenCxqeW+
 ZHyL7xfNb3811lNEvppzs5GJVe38rXRjfaAr+OSEYN4uAN8B2cnZMRDk0bTA4Jaxh6JjubXQFH/
 0dfEKBE0C1gQEOrLdu0u3us+XyogJKhai0Dazia80ZzJnezWlLXV03M/SLWSOA13e5/pa3XSLT5
 woG5Btxb/7hQ3KCqSuQjhXgph8/yCx+j9TcPqvKZTpwNZzkv6PAJGZVXRzSNQJkN69a8OFcdYWw
 NgojCcSdA
X-Google-Smtp-Source: AGHT+IF6fnskXDe5d9YMwx7vL5ewdGfbnq5Qkvm3i/YGfATPG/cqHQTmhx4+bncc+SvgsPlK+zugWA==
X-Received: by 2002:a17:907:7206:b0:ace:d95f:6582 with SMTP id
 a640c23a62f3a-ad17af7f8e1mr193574766b.53.1746173018277; 
 Fri, 02 May 2025 01:03:38 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a24a4sm11119466b.41.2025.05.02.01.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 01:03:37 -0700 (PDT)
Message-ID: <7e661024-9d76-4f82-ae4a-144915ff48ff@linaro.org>
Date: Fri, 2 May 2025 10:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Support madvise(MADV_DONTDUMP) when creating core
 dumps for qemu-user
To: qemu-devel@nongnu.org, Jon Wilson <jonwilson030981@googlemail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
References: <20250502063140.1098807-1-62701594+WorksButNotTested@users.noreply.github.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250502063140.1098807-1-62701594+WorksButNotTested@users.noreply.github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Hi Jon,

On 2/5/25 08:31, WorksButNotTested wrote:
> When running applications which make large (sparsely populated) address ranges
> (e.g. when using address sanitizer with LibAFL) the inability to exclude these
> regions from any core dump can result in very large files which fill the disk.
> A coredump is obvously very useful for performing a post-mortem when fuzzing.
> 
> Whilst the man pages state that madvise provides only a hint (and hence can be
> ignored), this patch adds support to handle MADV_DONTDUMP and set a
> corresponding flag in the page flags, thus allowing QEMU to exclude these
> regions from the core file.
> 
> Signed-off-by: WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>

In v1 you use Jon Wilson <jonwilson030981@googlemail.com>,
is this other address the one you really want to use here?

> ---
>   include/exec/page-protection.h | 6 ++++++
>   linux-user/elfload.c           | 4 ++++
>   linux-user/mmap.c              | 5 +++++
>   3 files changed, 15 insertions(+)
> 
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


