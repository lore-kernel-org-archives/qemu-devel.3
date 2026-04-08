Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4DF10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVx-0005W9-9t; Wed, 08 Apr 2026 15:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAY6F-00071A-9q
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:05 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAHu8-0007fp-Bf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:40:30 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35d9827661bso2861473a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 18:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775612426; x=1776217226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LSiexCJ9o4smBQFEEGiaDlD9TcxAYTKBOunRKVeNnFw=;
 b=HfEKLx8u014/Ud12CF563CjKFy4xgZ6rXV8tshPfOiSE04uSP+Mjwmu1/mVFvBD7a3
 p1swi5xpnUNZZ0xbSk+iHI/tpYLfvGlZK8J0R/YxzDoPrC46HViHmH9cC8i9bdLbqk3c
 YKcKlsWYWLlFjYn4TmW2oR8aNHbp4GqLO8cyTQWINVSZyTfV5iqKCAt8JnpGyQVZKmOW
 xTAu01rD7kO5NQS4Upm17ZPGjtaI1bKWYZUQRxnFVVBsTL9MIKd58C3rVW3B0OO0BbNO
 tm6dzvkaMEYqOl2kjD8i05aqTIDCR7YXU3Axjlo+fj8SLE4oeM5dcDlGSbjYESn/h409
 Sgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775612426; x=1776217226;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LSiexCJ9o4smBQFEEGiaDlD9TcxAYTKBOunRKVeNnFw=;
 b=LnIvqxaJFlv89BQZR/Zap1+SJYCsCv9+vco002jhySWc3OUB3fIN7l8Iwe507R1M8d
 0Z0B/jMVvDzA+Y+TEevPV19we+v9dHacX+R9CfcbfEZb7Oy+32gJ35mGJ4RVIbpgHfZs
 icQLoe0+K/o16ydEMBymN8/fuC2ZJBX5yibHZkHNbFAPZO+SEaxyInOg4/aWzaJVQWb1
 NC1RmR/4RtfOngN02A2qVsXr0MEn2wy0LdMRtcNwIDA2O69NM6mcRLKlnCJEwLXUrKro
 yJj7UaIa20/kSVQ6KXPugQacX8TgjEU5oC0AaYRfuNjOfhZnoAXNKtUyc3dUYQOKUHNO
 otoA==
X-Gm-Message-State: AOJu0YxKbp/PHtrJwnOZj3B53KGbGD59Xuvsp3/aYVzDlT2UeWLNlHtA
 0/nt+lXX8JJ4vMQJIvPzq8/OMcx3bAb4rt/Ix1E6pZUeNW4QGqffArdp0vcKzde6NzgXT8aF/Pu
 Am6l09ug=
X-Gm-Gg: AeBDietUtDvFMoUBBQg66sjl19FInBXE4rI6ayUw4FtP+ak8CoQIUYKRK+c89XAA2in
 BWQ++4B1hEvEgediUzADKSvF+rVphi3PZmXhkfYU6sNcaBkmLHQ9OSFqPvQRDLkquJdbB4RJ2iB
 XL3zHRCqNl+0fM6SrnCdO3EhgN+eWjeIg5lA/ipgE5r5BqcmXfkz2VnwhSWrsJVxuDJTlI5h5yL
 TzNWKf4r1PFGyk80pz1vhOc90K90mhRf65d6663751rAide2KRnbjnfbw4AS6LswYFviXjYM0E1
 QMVuv/6nHl5ypX/reWDHUL9F8hffQcjUiXlq5LMfMQO3UqR3ltDy3Th+W/5uCVwptt42nTybyte
 92W1QA0bdSOdF/JrA1XSSeI+hryGOi6/MTsB6Yaf9weNcPD+P1kQmORywfhLVQG2UWT93v5iAbE
 vq0QRoKQ7XYBbFvdOrTcJhC0yQyQXJYRPAAuc43Ijd6Lr+ZCItBbxDxahgopZXW6G3SYFKtWtq9
 5OaJg==
X-Received: by 2002:a17:90b:5585:b0:355:35b0:8b78 with SMTP id
 98e67ed59e1d1-35de69a6545mr18004619a91.27.1775612425687; 
 Tue, 07 Apr 2026 18:40:25 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35e3621sm18986783a91.4.2026.04.07.18.40.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 18:40:25 -0700 (PDT)
Message-ID: <91744ff3-df7c-46e5-b2a1-cd7f49051723@linaro.org>
Date: Wed, 8 Apr 2026 11:40:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] linux-user/strace: Add a wrapper for read and write
To: qemu-devel@nongnu.org
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-3-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260407043614.372871-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 4/7/26 14:36, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The stack pointer is being truncated as 32-bits for qemu-riscv64, so
> let's add a print_read_write helper that ensures all of the bits are
> printed.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   linux-user/strace.c    | 14 ++++++++++++++
>   linux-user/strace.list |  4 ++--
>   2 files changed, 16 insertions(+), 2 deletions(-)

This is indicative of incorrect fowarding of values to system fprintf.
We really should be handling the format ourselves so abi_long etc are handled properly.

In particular,

> +print_read_write(CPUArchState *cpu_env, const struct syscallname *name,
> +        abi_long arg0, abi_long arg1, abi_long arg2,
> +        abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_pointer(arg1, 0);
> +    print_raw_param("%d", arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif

This is more work than we should require for such simple syscalls.

>   #ifdef TARGET_NR_read
> -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_read, "read" , NULL, print_read_write, NULL },

Ideally, I think %p is the correct format to use for a syscall pointer argument. 
Interpreted, of course, in the context of abi_ptr.


r~

