Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D9C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkisq-0002C2-Hc; Fri, 17 Jul 2026 09:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkish-00029F-T2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:45:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkisf-00012N-0U
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:45:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so3538153b3a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784295931; x=1784900731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n8uyvTY4WjIM806VgX/CyzKweK5PgDcVXl9t9ioen9g=;
 b=mO3MEv6t4wbqPrHfluWv/EHGlX20V7Pf3vynKAS2PXpxM+voI04EmI2ZKJMxyKh811
 54jvTUJELfZT4b9RcO6QaKDfg6YjtNqHjjN6Pn4y6O9cPrNROB3DealEWYQ1XCevJdOT
 S/Rf9Gl9ZYgkDgD29wPuwr/5K2x6KexOs4x9pWehNq27ds7vgMT/xpCggNF0f1/6mFXg
 mRTuOsneSLaeI0l6CWzqFtyB7X1Fk8Rcl/bUKqcriKC5nWoOWuh031ZGJkQzrVbqYp9J
 oHGe79ykCGpgqv0Oai8Hi1C8VA4ENOTh/wgVyy0OA0TtEPhVldjXRmnOyp35elMdM/gk
 3NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295931; x=1784900731;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n8uyvTY4WjIM806VgX/CyzKweK5PgDcVXl9t9ioen9g=;
 b=mHzAZcO1icdEjjm7lUBJOImx7dyuVmPlAbY6EfZjmrvDXTUmm7q4TEpTEeVBwTrfWg
 X60tiYp0OpC3WrrEpuuUoKcenv59m5dwDCVcXZ3Bu2zsCuMTm3AeOyRwhyEv6FAHT01m
 tGnfxp7ZG7Japjm+ybkxAlb106++gREUW7a7iw+wzr/sPN+kKvswx5uzQKqSmyt9jNga
 0B3KCup2Y9hK0ozORDQd6M+58YPmqiqpBFwUb0p6eglJU6Hl3L2UPinSRF3hD7l4wSQI
 ivrQ5H5+NDWqYVjyhKXU5AidhFMmR1nfInGQWSAF4AzYLnU/kOup1IGlvL8EYY9bgVZK
 Em2Q==
X-Gm-Message-State: AOJu0YxPAWVPuN1YD2U6I8AGeOzl4pBjcLqJfoktvXV4VRvmY8PcyH8C
 +Qr68BM3Op3VX0KxWt9iYwe5GLYE/mbF5801jSdZVxVo99y2NKcvpkCPkBoTNBQXGyKKuN+PtkC
 diu/f
X-Gm-Gg: AfdE7cmeR8AdZPTZKHDrWamfPDNtlBqjySY/L0kiSlaRlOQHE2c1ZZSYh4JdYHLlTvK
 U+o0MZQ4EUNzfD6Sx68m4cj3fUB8bcIkbyAAz1QoqbYuTgLpczNN85NjGVerGZ9R3Rs57T9vVmz
 +Prs7Jhd7stEhUuUAvTIjBGgNbJjDh1h0NjKxMp2DxrnZwnYynE1pn/rv+xEjYFfKgf9X/maQY7
 BVqRj//hIuNvn7FShIG17Yx0cPrif6nPI+6kAKbt08sakQZeoB2dHLotpedfEkpHtWopQWTXar9
 o6eFmQv6XLTS3pRqj9X3AG9TGiMYycHfuE7cffmUUZEtGSdlRAPZSrpAu1lkdPQgZWRdjSJSmhA
 W98CGCA9b4N4a8ggMeAKVVG4n1RDRa4XJ2dw6Vzb8mQT4uOPWdxt6F+En93XEYREVnB6vW4vSzC
 LYjVXDInfOoXiUcTAz6P51ClcJxrduxQOGunw4Z5hQwk8r6aXxz7GaGpgNOyJk
X-Received: by 2002:a05:6a21:3a42:b0:3c3:9fc4:3ff5 with SMTP id
 adf61e73a8af0-3c3ad7aa1fdmr3201591637.29.1784295930666; 
 Fri, 17 Jul 2026 06:45:30 -0700 (PDT)
Received: from ?IPV6:2607:fb90:9e73:45cb:78e:ab81:8ca0:904d?
 ([2607:fb90:9e73:45cb:78e:ab81:8ca0:904d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29c2dcdsm5044655c88.1.2026.07.17.06.45.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 06:45:30 -0700 (PDT)
Message-ID: <dc49f2c9-e90a-4251-a01e-94752bda6478@linaro.org>
Date: Fri, 17 Jul 2026 06:45:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 11/17] target/riscv/debug: Put mcontrol
 load/store match address into tval
To: qemu-devel@nongnu.org
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
 <20260716123535.3709148-12-daniel.barboza@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260716123535.3709148-12-daniel.barboza@oss.qualcomm.com>
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

On 7/16/26 05:35, Daniel Henrique Barboza wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> When an mc/mc6 trigger triggers on a load/store and raises a breakpoint
> exception, put the matching memory address into tval, as is already
> done for exec addresses matching.
> 
> Tval for breakpoint exceptions is optional in the spec, but it seems
> more consistent to implement it for load/store if exec is implemented.
> 
> Fixes: a42bd00166 ("target/riscv: debug: Determine the trigger type from tdata1.type")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/tcg/debug.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> index f671ae67f8..7ecbe01fb2 100644
> --- a/target/riscv/tcg/debug.c
> +++ b/target/riscv/tcg/debug.c
> @@ -1077,6 +1077,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>   
>               if ((wp->flags & flags) && (wp->vaddr == addr)) {
>                   if (do_trigger_action(env, i)) {
> +                    env->badaddr = wp->vaddr;
>                       return true;
>                   }
>               }
> @@ -1095,6 +1096,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>   
>               if ((wp->flags & flags) && (wp->vaddr == addr)) {
>                   if (do_trigger_action(env, i)) {
> +                    env->badaddr = wp->vaddr;
>                       return true;
>                   }
>               }

check_watchpoint shouldn't set badaddr; the subsequent call to debug_excp_handler should.

Same vs patch 10 and breakpoints.

Also, wp->hitaddr is the address that actually triggered within [vaddr, vaddr+len).

r~

