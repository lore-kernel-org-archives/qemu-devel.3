Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DA8CDD0C6
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 18:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3JVT-00051i-48; Tue, 22 Oct 2024 14:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3JVO-00051W-Hs
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 14:21:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3JVK-0001Mt-H6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 14:21:17 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c805a0753so51755075ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729621271; x=1730226071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+fP23rdWcpn6aLMbhsTv6p1qfbZO7Mb3SdJy7i6QTq8=;
 b=f20zbxQfW4NuQgxRy9Gx7fEbsdTENiSHMRSiLCBckgTtGhIkycC3SFUe3XX+569U8j
 vqtfknQqSzGu0qX/spYPKT4ZP327+2SbrVUjHQ7zTpKDGc8uTQNj6DnQyL+ICM1ZkwgB
 s0daQv9ttw7RXCdkA+gN3bypDGjPLFT+RNj4TKWRAoMCapeZwPcqrN9pc0PPlNeBXDVz
 R1OrXDrjNC2NDmoX3EXktjcIxaEB5u5Dbg2ebWxMZm28ZF7BKsvQHgsfYLQnnBwrg5yY
 aRFXZjVROS5GnWUDacDS+eBBrjAO6oVxTvAcWEij3w7HCRty2v1KJJV10YBRAKE9AG2l
 EynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729621271; x=1730226071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+fP23rdWcpn6aLMbhsTv6p1qfbZO7Mb3SdJy7i6QTq8=;
 b=s2JknZsXPbybsiW1RxV8yi8iw8Jy24Ruz+kx9BGOrW18OAvOTZr9ORiOOeYHud6YzW
 DtzF0UIsoHIRK4EN/AeOdMBCqWUTM+RCvZCockmnymuqTEF1H0MqBx5X4dpGteImTZfG
 vOeOTpAXl+QTJ1r6X0+vqCkVBT0/HTWEJvZl3SOHQPkfWZfL78vZADPCwVcyrn9sHuoe
 Z4lUcREYTpxqBrAQUyrR8E6x2z7YHv/bwcFEzX5sGap5fhwkNC4UxKcG3VQbtA8QJpJt
 uoXGKBpjtvUiQoiWnthZ/UXUgijQIST67xcK5Oy/LYnlhlrQ2fodFMR51KxWs+2L+hvN
 whjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3/b6kFAhzGQ02Iy+yvvGYRNMUUoI1mYo9le58CUCvskSSU7zrWx5p45yhM1JoSxwVU+n8QXOJOGcP@nongnu.org
X-Gm-Message-State: AOJu0Yy/WLObl+hPzchpIYgVPnCvbF53MOV0uoJQHrpbrQr5XfHxCKts
 rL7XLpnuix7DCr55VTzUxEl5BPyB7PeL8Rk5OA1h41wIisccG3D1TCSL3os/VFA=
X-Google-Smtp-Source: AGHT+IHJCDNUb5LM1tFzjzPLm1EFNU4jPeAi1FK5pibNMSOjmoHi/IHDJJp2YzxPbnSg7HRMasmATg==
X-Received: by 2002:a17:903:1c6:b0:20c:769b:f042 with SMTP id
 d9443c01a7336-20fa9e61c9fmr250115ad.31.1729621271274; 
 Tue, 22 Oct 2024 11:21:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd508sm45787355ad.138.2024.10.22.11.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 11:21:10 -0700 (PDT)
Message-ID: <f7d3c8b9-ea03-45e2-9037-315a241bcac1@linaro.org>
Date: Tue, 22 Oct 2024 11:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix build failure caused by missing __u64 on
 musl
To: Yao Zi <ziyao@disroot.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Michael Vogt <mvogt@redhat.com>
References: <20241022122929.17465-2-ziyao@disroot.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241022122929.17465-2-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/22/24 05:29, Yao Zi wrote:
> Commit 9651cead2f ("linux-user: add openat2 support in linux-user")
> ships a definition of struct open_how_ver0 while assuming type __u64 is
> available in code, which is not the case when building QEMU on musl.
> Let's replaces __u64 with uint64_t.
> 
> Fixes: 9651cead2f ("linux-user: add openat2 support in linux-user")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>   linux-user/syscall_defs.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 0ade83745e..0e08dfae3e 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2750,9 +2750,9 @@ struct target_sched_param {
>   
>   /* from kernel's include/uapi/linux/openat2.h */
>   struct open_how_ver0 {
> -    __u64 flags;
> -    __u64 mode;
> -    __u64 resolve;
> +    uint64_t flags;
> +    uint64_t mode;
> +    uint64_t resolve;
>   };
>   struct target_open_how_ver0 {
>       abi_ullong flags;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.

r~

