Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D3CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBINI-0001PI-G4; Tue, 21 Oct 2025 15:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBINF-0001NZ-6h
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:50:25 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBINB-0007ap-S6
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:50:24 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-442003b80d0so121608b6e.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076220; x=1761681020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4nePog7tKxYNOhhw/eNTU4B6SAbRjyNtp9E+tEdZqJk=;
 b=RDo2qhbERDdBGAYoPsvRCq0sdNbtrpZj+HUYWYKL8x1FctBjrgo0W+ykySoInED2H3
 oOVVFdzFU4g+b8cs30QQeYs5Meb/Op1u9uOS2dzl1WkfNJ5jfmo32bsTlFNE883wOSCW
 1MCHDVppYf/zMZeTvl5m572f2j2W3dqPe6678i2VG/nw/9MoKhcNcKMkXiqNvF/3uFaF
 BSm87J0+dI6FrBNMjD37ehLdREfWgdkedqu4UTlOdZ4+iWpTDicOvvPK8mx841Ov4pv6
 Vdofr8Zxuk2c1MP9977Qkd72SYbpz6B9zbIMzw9CMX2F/ayEy29TQJwxqtt+nHb7aLR4
 J5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076220; x=1761681020;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4nePog7tKxYNOhhw/eNTU4B6SAbRjyNtp9E+tEdZqJk=;
 b=LLRwPRtWNju7EIFOzDz5BEngkRUQfOapIFrA4HOGnz7++TdTycj91MJhImfQjqawsW
 FfmX/cb+05XV3DJNWOwmXPtpzmBO/YSoJTkSHcYPw3okTC4NAYmbrD2UFqcRxymw9dzU
 +fFfP0rRiJ3ORFAqyZ8Yipxygk3XhFfIhLbvuWJeD8J35ElG6Ph1v5+5fvEpFNEM1GTx
 dsZTxkni2KsqirTwpRyejV1WqblGi2V/cfFlDagG4KSFzZVdBjhrPaoPXg3ZgIT6OJ/g
 sSWv1hvMFSePjQfYI6SwhnGUHuD0vu///PRICc/zB7RwX/hgWUYKkuiMZ14onO7H4rqn
 tMTQ==
X-Gm-Message-State: AOJu0Yxm8h2WFz8WjzhDL6+MCQu9iLstEhTskL7MoAD3N7k10BbAmtxP
 gpDWbDlCacBGxrWTzCFtl8yApqOt4upqg0ka/SyxDfNjw8PnL9bH5JJ0794tVjjCvJbM5Jo25ll
 aznCJ
X-Gm-Gg: ASbGncv40Ucr1XjQ/TG/7zXD2pIqbApWUpyV7IB60nQhC7dsGQVoSO8AWrkQ6nszOkS
 cLzQI/8BnyaeYo21AuSzWPUJLK8FGHAMohN1cij6p85MmeR7u9mg1JsL990CMYuUdquvZXP5Pac
 SvLi3UtItzSSFjza7vKfzVJVt1VAdwXZDdrzkejG2GD6NYEV0B9zNpjwBygn+AI3PRXjcA0UYUF
 WFZ3ZVioNuhIzvGrSFFKt3qcAZ+g4hP/sabnE+U/IyAvyj5h1SzGDPYN+aPm8X7kcL6nJVfirOb
 lqCFFmVMOdQVRkoftjzE93bGWYNBxNCyKneVnBKJNSAci+JpwzMG5jP7kXLG8Wsa9yzt3wL9uaG
 X0aoUe3VkGR+0hyO6qmlyCl2DZrvJdgoQcT6sZ2kFsiuM26yujGjTvoPQix6MumeAJXzE6Tckg6
 yIHaz2XoqeUTaC+iX+FsjL4q8haThYZNJj80HTnJNUDLIRn9kXbk62HqLjsh4vbtuCvG4uLQ==
X-Google-Smtp-Source: AGHT+IHOlXrKOUTBeTWdbaN+0psDTcy/W4urCMUIJ5oRnhbaULAWXdEryArvTJwf8f4KbYZWkC9R+g==
X-Received: by 2002:a05:6808:1529:b0:441:8f74:efe with SMTP id
 5614622812f47-4496516047bmr583117b6e.27.1761076220251; 
 Tue, 21 Oct 2025 12:50:20 -0700 (PDT)
Received: from [10.128.41.227] (c-174-170-192-123.hsd1.tx.comcast.net.
 [174.170.192.123]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dc4d5460sm2857333b6e.4.2025.10.21.12.50.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:50:19 -0700 (PDT)
Message-ID: <6f8f841c-fa4d-4cfb-b05b-fc34f5e59d93@linaro.org>
Date: Tue, 21 Oct 2025 14:50:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] linux-user: fix mremap errors for invalid ranges
To: qemu-devel@nongnu.org
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-3-mlugg@mlugg.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251011200337.30258-3-mlugg@mlugg.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 10/11/25 15:03, Matthew Lugg wrote:
> If an address range given to `mremap` is invalid (exceeds addressing
> bounds on the guest), we were previously returning `ENOMEM`, which is
> not correct. The manpage and the Linux kernel implementation both agree
> that if `old_addr`/`old_size` refer to an invalid address, `EFAULT` is
> returned, and if `new_addr`/`new_size` refer to an invalid address,
> `EINVAL` is returned.
> 
> Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
> ---
>   linux-user/mmap.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index ec8392b35b..4c5fe832ad 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1103,12 +1103,15 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>       int prot;
>       void *host_addr;
>   
> -    if (!guest_range_valid_untagged(old_addr, old_size) ||
> -        ((flags & MREMAP_FIXED) &&
> +    if (!guest_range_valid_untagged(old_addr, old_size)) {
> +        errno = EFAULT;
> +        return -1;
> +    }
> +    if (((flags & MREMAP_FIXED) &&
>            !guest_range_valid_untagged(new_addr, new_size)) ||
>           ((flags & MREMAP_MAYMOVE) == 0 &&
>            !guest_range_valid_untagged(old_addr, new_size))) {
> -        errno = ENOMEM;
> +        errno = EINVAL;
>           return -1;
>       }
>   

The order of the checks here is wrong.  We should match do_remap and check_mremap_params. 
In particular, it appears as if all of the EINVAL checks come first.


r~

