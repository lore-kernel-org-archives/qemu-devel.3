Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ECCD12D49
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVnJ-0003lR-UP; Mon, 11 Nov 2024 09:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAVnH-0003kt-P5
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:53:31 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAVnG-0002Ea-3d
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:53:31 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ea7e2ff5ceso3176634a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 06:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731336808; x=1731941608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wkjkek4yunltea4BRJOejUUhd7EmZvVp7H9de6ECF8w=;
 b=nSYn5ZFP1LV3BWJ8NBUtXbKSQxIYXBLd4wNTXl6ACyt+BNX2cFn7v/CBQGJK2HIXkb
 K5a6OWXmHZYiThToa3KIfHQnq5Q0J3YR/63JxjUyq4jSdzJJY3JPWx/l9AJRi0sf22Z5
 VtSEupBduz9iHI/ucX2/KWWZl7hCDeQNgXDiu/pe3Lg+qvmM7gwbyG+BJutPFARslxn+
 NxHgS1I4JZGcw0CzUQaAjx3yi3AQBzfyncJIqBBGvSis05cqWz3PdFupEdHYy5qcFBTf
 7LZJFwTs1h75sfFTiP8v10kviwfnOMUgbAeJnLLlCdVI4aKOTaZu0+RWvJW+CHLwcDBf
 L4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731336808; x=1731941608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wkjkek4yunltea4BRJOejUUhd7EmZvVp7H9de6ECF8w=;
 b=qn+oTTXXVvm3O4sMbPo9lpJxpYPUJbQZkLfBAGbfWQ9uN19PoX3dBoMnJP4vLznrVc
 bDj7XgfbyUl00z1iYJ5lzj8QLBF4nn69TPsfKaUJrkBd2pmI9kAndqOsDM66XjqB4dWM
 h99r9m69DkwjnIcpXUhcXLPuiWHfCraHHJeMUuv1fuR1IcyIu1WGS0sE7i8AyYhifUBl
 h/mHBG0RyLRTDuLnJaxQsr5gUM32ZTjnYcY7ya/fJoCrXdJNXfr8OTRxTR02BfppgTKb
 zcZpmYUO8AcBcWn2EzshGZVDA1Y7KufK6wdcHZm213xS7TuPeQrUL2PD2feiPPKbVAt1
 jztg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaf6PPvUDFv18aCqYI9v5nJ0k1f8MNBrUyL+KNx37HQMCfNk9L3eyHAyLswdSRXHq0sDVUJwjatrAo@nongnu.org
X-Gm-Message-State: AOJu0YxEyxCsu+8vz1Za6IdbtaACgDrchrFqrF2jAAt755BN9p73wTIR
 MSzb+TzblnVRDxkUyp0ZfX7u3Qc4gtOOT7+yfSOlGjsjNpTbXh7sJhayqNZgRRqGb63PH+ERCK3
 y
X-Google-Smtp-Source: AGHT+IF6ZjTT2d+mQm7v0Qn1rSRsrLTCiDJNY38G75Vxos2vlvhrKSyhyuMPuMmQJUh3Ir9H1rCjSQ==
X-Received: by 2002:a17:90b:1a85:b0:2e9:449e:d57f with SMTP id
 98e67ed59e1d1-2e9b1749291mr17571713a91.34.1731336808623; 
 Mon, 11 Nov 2024 06:53:28 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9b2b4cd58sm6598906a91.20.2024.11.11.06.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 06:53:27 -0800 (PST)
Message-ID: <141f99ec-37f3-40a3-910d-f8194b552c54@linaro.org>
Date: Mon, 11 Nov 2024 06:53:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20241023002558.34589-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241023002558.34589-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 10/22/24 17:24, Ilya Leoshkevich wrote:
> Running qemu-i386 on a system running with SELinux in enforcing mode
> (more precisely: s390x trixie container on Fedora 40) fails with:
> 
>      qemu-i386: tests/tcg/i386-linux-user/sigreturn-sigmask: Unable to find a guest_base to satisfy all guest address mapping requirements
>        00000000-ffffffff
> 
> The reason is that main() determines mmap_min_addr from
> /proc/sys/vm/mmap_min_addr, but SELinux additionally defines
> CONFIG_LSM_MMAP_MIN_ADDR, which is normally larger: 32K or 64K, but,
> in general, can be anything. There is no portable way to query its
> value: /boot/config, /proc/config and /proc/config.gz are distro- and
> environment-specific.
> 
> Once the identity map fails, the magnitude of guest_base does not
> matter, so fix by starting the search from 1M or 1G.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2598
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> v1: https://lore.kernel.org/qemu-devel/20241021121820.483535-1-iii@linux.ibm.com/
> v1 -> v2: Start looking for a suitable hole from a higher address,
>            instead of falling back to probing (Richard).
> 
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 6cef8db3b53..d6ad77d27dc 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2898,7 +2898,7 @@ static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
>   static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
>                                   uintptr_t align, uintptr_t brk)
>   {
> -    uintptr_t last = mmap_min_addr;
> +    uintptr_t last = sizeof(uintptr_t) == 4 ? MiB : GiB;
>       uintptr_t base, skip;
>   
>       while (true) {

Queued, thanks.

r~

