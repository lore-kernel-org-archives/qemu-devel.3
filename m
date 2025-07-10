Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4C3C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 16:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuLM-0004m8-RO; Thu, 10 Jul 2025 12:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZu0X-0003VS-Hu
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:20:25 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZu0V-00022V-Qp
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:20:25 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73b0efea175so698175a34.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752164422; x=1752769222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77NDXvfnyJHQgen3w9eLWPHyCMzThnuK2Zm+p5mdbnY=;
 b=KyNMg62r3/miTYTPi0fZX1OlJnxod7nLNhYUqBcKn8BQrS2JhphP1lKfI9CrS/GGu9
 2MO05fTh6+G9nK6vH+rvCOrS2UUuZY8pVLZgtjMCYwsgexjKCofyMv4jH7dFAJNEm8Ps
 R3Fhb8GzQdWWqeWsHP6+aopzOep0brjXoOAiUONPb3DVNs1+8ZTdlAlZuHGaauImWiBm
 c9P0jUC36EXH5MF1PL2jtwEhTcwU4W1hM7xKcEYBRiY6p5KWM36p3vb5jM7tQze3IXdk
 CnZ6MuOXPhl0zLTph8zO2rmjrEO6J+6Wpl1jZJQkHDy950XD+OkRnqF+h4mGR8TIF3Xe
 KPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752164422; x=1752769222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77NDXvfnyJHQgen3w9eLWPHyCMzThnuK2Zm+p5mdbnY=;
 b=hgev1y8G9RyObUgPHLsqr5WPkqn51zMkz/lxZ3NCazQd/1VAVJlDeD6ooyU57LtiOA
 fD6Q8vxU5WNEfD6rSQ1xywtpR1GrVndnfWpE1ROLHp9gqGtkwvyO+3fTDDKOGTDD6VBb
 tH5vfBrVu+6ZJ/Z7cjNvwmmFVxrJl4jr1UeRbaM4Mi6dbOT0TfVVwsUVAa37sJhQ9cUq
 GNHoy36PkIri/VhWWxw0QKqFGV3VhDDoNM2Xrs3tN5IjT1E0/zwD2ruUkOzbknDEoKhE
 0kjno0Gq6y5PM7AtK+PszHT2kmMW5TuYhxUURO9UFpEJpiKMtDocGl8lksZCFmdYoJyW
 RUhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDdkaiuKM3PQESzkoE6hVXKVSujHJbPhYxLo9ebv5UXNgFbjEiSF9zUkplBISpHA+j+rUEfywc9D4j@nongnu.org
X-Gm-Message-State: AOJu0Yx984qLxg4mabjJUCkx6gkwWY8JhLeZxFsTTB1YOpIGM+7PHxRj
 WIv9IM0fgRDfwUbmYyxW4TkSmNX8o34jff9S/Dj96X2+kE1qNb6qOBDpyDysTg8MqHI=
X-Gm-Gg: ASbGncuFlp+wOfg/NnIwHamGJOsCZYwqqBBkbixoTCi2a3bERD06B7YgLeSOWTHRE80
 KRnX2HLu7oBIvwpyaaZV8lH2aZmtqrHItVe7dDXo/5yq3fAEkgUqed5rnEDrRQGbGSIIbtwEttB
 Zc3EVKWRHi8R0mqRbrCyGG9WtDCKh74goYLBBJd/TVl8+MUT+KEuPZdqiOjdTbDs2phgjjr410q
 5C7qj+umJxFB6fPUkyYlkBkcP/62qiagm4byDthC2au+6uLchj3PETyeKUR/m0SEuC1QmozbGRG
 AEf41N7m6TinfjqFFUzglksmXHa1MdTfAraQX0cmQUu/q1PhkzbXsulK2Wz8agdbIHh+5sxXMht
 KIwo=
X-Google-Smtp-Source: AGHT+IGKZOHh0D58FGjwBKBCceC0330WkrZ6C63cQvu1zGM1HGKgTsAACPpzRFvuWSAU3Hd97fxN1w==
X-Received: by 2002:a05:6830:d09:b0:72b:a712:4b72 with SMTP id
 46e09a7af769-73cf9e91120mr103618a34.9.1752164422247; 
 Thu, 10 Jul 2025 09:20:22 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf10a7e16sm255052a34.26.2025.07.10.09.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 09:20:21 -0700 (PDT)
Message-ID: <65bcde86-90bb-4be1-b5d0-fd3f113d9169@linaro.org>
Date: Thu, 10 Jul 2025 10:20:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Implement fchmodat2 syscall
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250710113123.1109461-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710113123.1109461-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 7/10/25 05:31, Peter Maydell wrote:
> The fchmodat2 syscall is new from Linux 6.6; it is like the
> existing fchmodat syscall except that it takes a flags parameter.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: don't bother with trying to fall back to libc fchmodat();
> add missing braces for if()
> ---
>   linux-user/syscall.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index fc37028597c..e1b1476936c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -790,6 +790,10 @@ safe_syscall6(ssize_t, copy_file_range, int, infd, loff_t *, pinoff,
>                 int, outfd, loff_t *, poutoff, size_t, length,
>                 unsigned int, flags)
>   #endif
> +#if defined(TARGET_NR_fchmodat2) && defined(__NR_fchmodat2)
> +safe_syscall4(int, fchmodat2, int, dfd, const char *, filename,
> +              unsigned short, mode, unsigned int, flags)
> +#endif
>   
>   /* We do ioctl like this rather than via safe_syscall3 to preserve the
>    * "third argument might be integer or pointer or not present" behaviour of
> @@ -10713,6 +10717,15 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>           ret = get_errno(fchmodat(arg1, p, arg3, 0));
>           unlock_user(p, arg2, 0);
>           return ret;
> +#endif
> +#if defined(TARGET_NR_fchmodat2) && defined(__NR_fchmodat2)
> +    case TARGET_NR_fchmodat2:
> +        if (!(p = lock_user_string(arg2))) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(safe_fchmodat2(arg1, p, arg3, arg4));
> +        unlock_user(p, arg2, 0);
> +        return ret;
>   #endif
>       case TARGET_NR_getpriority:
>           /* Note that negative values are valid for getpriority, so we must


