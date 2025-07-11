Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D209EC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaGd5-0005nH-F3; Fri, 11 Jul 2025 12:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaGcq-0005ek-G0
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:29:28 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaGcm-0001HE-4j
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:29:28 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-40ba3d91c35so1286459b6e.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752251362; x=1752856162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mHUslz45xxbHm+hnKGeBnOWg3i2fGj+tAkUWRmPbBvU=;
 b=sIRjvhocc4CB5n/LRl9fHE8c+VZhV+5copzcnX6pVwwpAa3jnsqvxt3wjHBNQxuau3
 XHKXQm1xMoMVKUZG1Y1GLOWsa9x09slZAncqtL1wBTSh6iUlbdHDQCH2JHZtjvlGC1cU
 x+caCbrcddRiei0QRFjNS9hr3xh4Ni6RTqIQiJiwVrKFXowsO6okAfn3tKVlTNWj5zIv
 zimLIbpjq5o0Yl2yJnAPli/k3VbWlS2Z9mTlppbfFRMfWYNrg6TkUZ7X9pfZLdnpWk2V
 Hk4zfSQ6CgpYscfM23484hXHFqdtJHSEK2mk2vRBKGfqpXZJ5pBN5/ozYK7h1k/sh7FV
 3x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752251362; x=1752856162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mHUslz45xxbHm+hnKGeBnOWg3i2fGj+tAkUWRmPbBvU=;
 b=tM3ADdnYR0HZDSoWVHkx4wiHi8FAcbMht3xhOSZgpfuPBSt6yStndjzQBKH9d1KdZw
 eiHcVTVYfyQxH0EGCYk8WA5q8F4+Nj/hbegUcpDQkjdcXoYJ0TjPahRCQ21ODkkCyz0X
 r/9SIY9AbKcBqjYNL09evEgzV5aKNDd7GGxEDKFnyeR+26Ka1EZB3T/Zh4qeyu2Nfu27
 6ArecUxGa3FwgQCAUfPK/9h0kQJzd4XVNZw61Rnj4pJQKd3nR3aGIs+hWc9ggcqdJsfm
 z9Qg76XeLJC6wrmiEzOKR1EOm/z+EaRQVGDwyFUxha5SDOrrkZEQ4N/hZxJpqKFYXJl0
 LUMA==
X-Gm-Message-State: AOJu0Yx9jEeXScpHglYd3Jy11bNlR33P8LljS180V37ns8FoMt0qkqgA
 ZG5KIjrtyH6Rc4nJ4CAbe+7STbE6pdQzaAjDQnyt9xhsI0NDFhh5CVW8kpxyGY0R/1qiu9MWaxc
 pbBVQZGE=
X-Gm-Gg: ASbGncsuhHnuQL2r1ORDxPPWQgntIwOjgzZj0pziVBqUIMlLTBXisQjds4XT8zt8pRz
 cHMB+gFfbq+7KU5gcF/FFmw+pMJD06rHWk4sQWiZN6DmNbogtnbUbfo3H/gzfo8xKLbe0KPm4f7
 lTTswmIy9CNK6DkbNrItT2RvIWo9FON1dZCk21v7++xAFaUcvqrEcZTwaMK/V6hTE6vUAQAOo17
 nEkHI1Pgw/jo1VGorzd3w1G1DpCLbeA14FwLk7K4AQFykfOd8BmGLwViC45J6B4BN0oV33SwuGk
 SHdLKs+w13GxF8XKT28ypyrtENW9dC8pvsMwY7NU1htG6sOu5NoI8Mri0dOIiKSjdCvyLkuppVN
 hwBU1dHyGGfcyrE+03VwES+xBMAFpRM+2vwo7F0buRxtwAyK8uJ1YF3Skfl1Rb/PW7Y9izrs04w
 l1
X-Google-Smtp-Source: AGHT+IFkB9VvXjlhcpKONTqmCxjIoVDav/UctGP1YVpC6fm4pbaoqB2n1txFwepu/VpmMTOApVZewA==
X-Received: by 2002:a05:6808:3998:b0:40c:fcbd:61a4 with SMTP id
 5614622812f47-41537277e36mr2479838b6e.2.1752251362341; 
 Fri, 11 Jul 2025 09:29:22 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41418c0ca00sm569697b6e.9.2025.07.11.09.29.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 09:29:22 -0700 (PDT)
Message-ID: <98e6e5b0-f786-4a28-ba2c-c35bc58d00cb@linaro.org>
Date: Fri, 11 Jul 2025 10:29:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Use qemu_set_cloexec() to mark pidfd as
 FD_CLOEXEC
To: qemu-devel@nongnu.org
References: <20250711141217.1429412-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250711141217.1429412-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 7/11/25 08:12, Peter Maydell wrote:
> In the linux-user do_fork() function we try to set the FD_CLOEXEC
> flag on a pidfd like this:
> 
>      fcntl(pid_fd, F_SETFD, fcntl(pid_fd, F_GETFL) | FD_CLOEXEC);
> 
> This has two problems:
>   (1) it doesn't check errors, which Coverity complains about
>   (2) we use F_GETFL when we mean F_GETFD
> 
> Deal with both of these problems by using qemu_set_cloexec() instead.
> That function will assert() if the fcntls fail, which is fine (we are
> inside fork_start()/fork_end() so we know nothing can mess around
> with our file descriptors here, and we just got this one from
> pidfd_open()).
> 
> (As we are touching the if() statement here, we correct the
> indentation.)
> 
> Coverity: CID 1508111
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

