Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC0DC982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Pch-0005tK-QZ; Sun, 20 Sep 2026 18:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Pcg-0005tC-9e
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:02:58 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Pce-0001Lp-FL
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:02:58 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4d2fe2056so1424523a12.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789941775; x=1790546575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K1YBeFETUYRnSiso+FbGAh4EjT5kO1i+gOd+LS3fc3w=;
 b=h65JthWeeQ6HQ5SrUD1a+7y7wtasMDoxN86Wilye4l7uZDcHOHeMQL7GgVydidj+YM
 tJT7aIawZN+caD5QE00VpUAXIEid9JWLFClQS8Ofuz5YokQjfkkroAk0t1/d3myK3yYY
 bQWNYV0IoiK+VTL8X9JjUj9V3WAGey7fqhczaUivbRkjDuzyjrrhUoHwX8M+kkXeIxG3
 CYxIX3PJ1zhEh7CeoBo9qTAcUnO5wENhzXtOCilypW49WhotxR3gC1V/Pc1CYT76cOEx
 sIxhtzOkxUGV4YCOS4dYfK+7C3ncT4yavAktLrNAia1PM/1m9IbkvMylzW7DeCwmD91l
 7Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789941775; x=1790546575;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K1YBeFETUYRnSiso+FbGAh4EjT5kO1i+gOd+LS3fc3w=;
 b=RNxP4AX056+A5jDOoZjvuaoN+4a9xo8j/giI/Ie5FRUqW2YIIQCHyYh33CImTMQ5ph
 I8cmhpslfU9iy3uiaSr63DjD7GhEGAs8H2tDygF5/GwR2PnNEEjvotViMixMMEftF3Vd
 EXoXozybYH1xYZG22OOYF+4OMRG+SX0VNstMRaL3cuJtyLp2beJ2xR9/fJGCcVXYC3T4
 BBdN0NlnF8AkqYvP48oJuBhFuWaLaZyMuwTqlE0n7t+WVf6ZIkLe+sQzacBeAmLc0DrJ
 28fvrKacwUurRxGur6RBuqXQmrqy3Cx1SWKydCzcA9wOlbN8yu8LU/2rp0Ap7doWm9oa
 g89g==
X-Gm-Message-State: AFuF++lR9tVUKr/B3FVK2+HywPOAs4xBDogIHcVWq/yP5mufCY1dk3lw
 2g259wtw3lizDOLfQRnfuZpax9IN7F9q/YesjpBZXeZSaT8XhbJ+BLs27URK3+R64xYe3TNlJ4e
 uv9JPOco=
X-Gm-Gg: AYBFou25M5TB3pGqFWUQC9D4+OUSYz1rDYDnPSd+qweePBrsJbm076WDZe5rGxhOgrB
 +DDDP/HzbsyZDAp/nctGVAKC/CgWXOqsVQFhfGyg4CLTxdER7GJNT19JhKcNopDLYnlpzY7iNDA
 faDLIWo22aMlQiqj0b/MaTyfwjKvMTVQ31nGzARGkH9KkBWC1sB26QVyEfSuWLfQpvUo4bOuCPu
 /75tfqcnTsE+1c7VYXaYKhGnRtwQVI4k+o+B6SYB41awI3sJ9AAp7wdraPs2N4JqbA0UOQZ9oKo
 3eFv5/GNX70gb5VibMC0XEHhZiSroNciVgOGIpaL0jBl6gyf9umahMS5XkN3OyCyMZdsyWhfeOQ
 0nORYCKhTJ+Km4FBZMORn56j4JT+Tl87XGzO9LEyLENG2jSXF+QulgBXisVHwsLvUOSpxe6fHgj
 0bpJFGaJ+8Ly+SH8BrSmYZ+308NGhs/+nc5fyPlzVivb69UefzATJ9yqduB5wqHFpguYq6Wh64Q
 g6cH30DiVOG1cMbYQ0KCgi9uX3wPQ59gfKucA/MSFKN+xd839Hf6s9FVNFT2w==
X-Received: by 2002:a05:6a21:394c:b0:3dd:a195:fa11 with SMTP id
 adf61e73a8af0-3dda195fd6cmr8287216637.54.1789941774516; 
 Sun, 20 Sep 2026 15:02:54 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311ad4esm14063776eec.5.2026.09.20.15.02.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 15:02:54 -0700 (PDT)
Message-ID: <7d368160-4182-4b60-9aea-11121fbff19e@linaro.org>
Date: Sun, 20 Sep 2026 12:02:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] bsd-user: Add gdb for system calls
To: qemu-devel@nongnu.org
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-4-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-4-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/19/26 19:20, Warner Losh wrote:
> Mirror what linux-user does around system calls.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
> index 7e400c89bc..38dc87f745 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -29,7 +29,7 @@
>   #include <utime.h>
>   #include <poll.h>
>   
> -#include "include/gdbstub/syscalls.h"
> +#include "gdbstub/user.h"
>   
>   #include "qemu.h"
>   #include "signal-common.h"
> @@ -1622,14 +1622,20 @@ abi_long do_freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
>                               abi_long arg5, abi_long arg6, abi_long arg7,
>                               abi_long arg8)
>   {
> +    CPUState *cpu = env_cpu(env);
>       abi_long ret;
>   
>       if (do_strace) {
>           print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>       }
>   
> +    gdb_syscall_entry(cpu, num);
> +
>       ret = freebsd_syscall(env, num, arg1, arg2, arg3, arg4, arg5, arg6,
>                             arg7, arg8);
> +
> +    gdb_syscall_return(cpu, num);
> +
>       if (do_strace) {
>           print_freebsd_syscall_ret(num, ret);
>       }
> 

This isn't quite the same -- linux now has plugin support:

static void record_syscall_start(CPUState *cpu, int num,
                                  abi_long arg1, abi_long arg2,
                                  abi_long arg3, abi_long arg4,
                                  abi_long arg5, abi_long arg6,
                                  abi_long arg7, abi_long arg8)
{
     qemu_plugin_vcpu_syscall(cpu, num,
                              arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
     gdb_syscall_entry(cpu, num);
}

static void record_syscall_return(CPUState *cpu, int num, abi_long ret)
{
     qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
     gdb_syscall_return(cpu, num);
}

and they're strictly outside strace rather than interleaved.


r~

