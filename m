Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E68CD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGb9-0007bl-DV; Wed, 27 May 2026 11:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGas-0007ZQ-Nu
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:54:55 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGaq-0002RC-MV
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:54:54 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c80148ae949so4821224a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779897286; x=1780502086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eI2F1/rHAWW8refW8gHVUFSwthBwxaeWHa8VyBA86rs=;
 b=PC3t5eFSMn6DKZUHCH+YTZUI3KYMEgcwLRxZtrj34qGqDa0s3XWomxLglhvuWmMdiW
 9iJgkWaGBqxWeWLiY8WiESKCBVPNUlq95FYenVzfwhPUeauYfntCbua34Lj97HdKvXLQ
 3Tv6ajqCJH+q5uT4eql8Xz2fmBtklT/rCEPBw31xFCR7sTDzLMEoKT4EFhCk5Oha9TC/
 vilpVV/b2kpkgrKZjiFxktpeDSNagsSAo3Ic+6WR7UnymfdGO4BuQkrtz2Kzk6aTWbAF
 ROboMyb0K+YmiwXj1sxXEM6rTk6mFf0FyLO5jX7CdD3zOr5HzUdEj97eXWDuBim5/ntH
 wPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779897286; x=1780502086;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eI2F1/rHAWW8refW8gHVUFSwthBwxaeWHa8VyBA86rs=;
 b=WTLDiYzHC1Hxh4vqjFX0K8MYKbmU9FCm6b9FYog+rdNimn2n/TjVxIOWigC2Al8Gm1
 AyEYwcOIkr0SYsGlj5wDYsVH20qOP5ogPBpM9PlPmIxBiyixwCTWn5oH0GI8MmbQFqTj
 +6IItSNljt8bOYKapCkvUUy4Hru2TQHfJSazu6QM+oSZjZgZpr+gZqVP+hFtT3RJscsH
 UBaRxD6BM28JTkbCA7dMXr11T24VqTOHseh8GLwawLAUASzTRfzhPomyZq6uu4n1T3Lm
 PInRLcnUFRUaU2eVasGms+TZPGcc+9jfBs9VJk3GrcyiFarBU9+8cmSMkFO+cGUe0pZP
 0pXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BW+TcMtKNpAHFec2I+p3NL9PCsmNGZOmFDr/N7pI+o74MxClJ5P88BYuETaKEhNstE1mzb1m0zhzt@nongnu.org
X-Gm-Message-State: AOJu0YylAwnGjAtlTttVNdKmqHHGGuqxggpB0ouqi6gaBkiV9PXBzTik
 xxv2FHMy6Wij7lYhVk+x8icNDTbntoKZh637Jz0gMvCwY1SVl6Z0u/OxjBH9ooTB1ZU=
X-Gm-Gg: Acq92OHNS4wFB92/AYikHhO6yN6sMJPE3plkL/d9Hpy+OpyUYy+4rLwSEvtsejD+MuQ
 5LkNN+x3cEtvGuNhW65CTChIHsYe9mFs6iuAAlC79Og6ofOV1AqpeW7aYq3DDiNNmavMZL3q6tu
 MTNob2VyZlP8n3YeajiSfrI1cm8B6kGhL0B/H6LAIyL4FB4rfjtQhO+WCserx/j2/waInLdD4It
 fX+eXopdzZ2c1dbJaDeUvvAEadXJIjCBlQLUZtB3VQ4Usvb2f/wJP7YeDt23u3+7dBfvipKmvNL
 kaVHENRHwmNxrVBLCt2f8XMjKHmm2QLhN8QHCRZcTYZy+rW88c/DWLZ7VKZbLZ2qkseN1+a6Rr4
 J63KiqONfyoOzI9mBO1IxHHW6O19MN1WKOFCicogAqg04Z7hn+Ru8XytJJ6rb8nqIququo2nlyv
 SULF6x/hTK8L+VnYshZiInt3c6l4nwiTtnRAQs+jH4qw9YFeM=
X-Received: by 2002:a05:6a00:194f:b0:837:acd7:a78 with SMTP id
 d2e1a72fcca58-8415f329ac5mr21927425b3a.16.1779897285626; 
 Wed, 27 May 2026 08:54:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d7300ea4sm2773057b3a.56.2026.05.27.08.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:54:44 -0700 (PDT)
Message-ID: <05a21fdd-9894-48f3-aa21-589e81cc43c2@linaro.org>
Date: Wed, 27 May 2026 08:54:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] linux-user: Fix loading static ARM cortex-m55
 binaries
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Eric Farman <farman@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
References: <20260526190535.10833-1-deller@kernel.org>
 <20260526190535.10833-11-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260526190535.10833-11-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/26/26 12:05, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Static built ARM binaries for Cortex-m55 may have been linked to have
> their load address at address 0 (because they are effectively a
> bare-metal image). When qemu-user is running as non-root user and will
> try to mmap() a host address at 0 (which is smaller than mmap_min_addr
> according to /proc/sys/vm/mmap_min_addr), it will fail with EPERM and as
> such loading those guest program will fail.
> 
> Fix pgb_addr_set() to always return false if the guest_loaddr <
> mmap_min_addr, that way a valdid guest_base address will be calculated
> and the EPERM can be avoided.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1890
> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Nack; this check is for PIE binaries.


r~

> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f7625c0952..62f12e4149 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -866,7 +866,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
>           if (LO_COMMPAGE != -1 && LO_COMMPAGE < mmap_min_addr) {
>               return false;
>           }
> -        if (guest_loaddr != 0 && guest_loaddr < mmap_min_addr) {
> +        if (guest_loaddr < mmap_min_addr) {
>               return false;
>           }
>       }


