Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A489CC369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WYS-00023z-2b; Wed, 23 Apr 2025 05:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WYO-0001xS-F0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:38:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WYM-0007uO-HJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:38:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso5044385e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745401081; x=1746005881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=67uTXp5dXdKL6tOsDTOv+uwAJPHIt6IAbB7sPlQplzY=;
 b=QAtwG8m2PgCJe1heZfctpDYth3qzfvrBYhowX9b2Oa/te/r5HZYeAwRHgVv+zxXgdM
 Xt3sRaIyH+PO0lwP63aImTf0ETZpR7c7TrmLWjcLnIR0qtSJX9A1GUOkIhVMxMQ9+cPO
 8pmjOylGz/vSRcxjCJpr0XtaO5yjUI4BMnZMtbTJ6yovmTLo+edNgUoOfZXiAOi/sFN2
 +VE4zoHja6tO+bJGqTZfUJduDUlJtwYZ59OpQCurRH/PS3q9TN07mRN0FfmNoQWz702u
 K2VvdtHFS+d5+ocQKc/U7KnryMIazVmNgFr5OVIftr1Gi4azhcked1nl8aXRwISHZ0ld
 4pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401081; x=1746005881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=67uTXp5dXdKL6tOsDTOv+uwAJPHIt6IAbB7sPlQplzY=;
 b=Qc2jRSolvK4E0xhtXetrqbeh1zz6gWynipXEetYaausBM2x5y8+2hFf056gWTSRP9g
 ebDNNQcIZWomXG5FXVY6AgOlDp05tNYb2XUkwh0qwVTD2cuWZmQOworyjkUk5HlZKsKs
 /iYL7OFGBVmMFj7DnwgIUDl2xsoc1BOkeb4VsNojnojaxSRLgo7KN++FG/hUtRY5onbA
 BPXOtJBQ47YmH/FLKEJvlhZBoB6vWqWji0haB1DTHeiKroF1FAGyf1fBjMu7USkFn6hx
 E9swT4bXrvyNrPVyKE/s+D2P/y4uGQognlsD4UIB85hOzE4HmGiJuz/k+/HUmgnOZC0F
 23Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1y8viu3I4PyaMVONY4VhjfCqtkI8kc4IT0pdT6KY6bxvyJx4d+5Mg6hE6DPtf3tS/X79qEFF48FYV@nongnu.org
X-Gm-Message-State: AOJu0YwpJCcGRfHjDyJboyZervBMzxfdx9PdXGhDjQdcA24y+gDwVMTV
 uSWPtD8QUFlty5II8mbcfs7GlHhGAwY0nAjk8aZbGgz8b2U16ChZgg8lOeJDB0Kq0WXnGoF6xuP
 V
X-Gm-Gg: ASbGncu/6K2uCjIHlgudtsdhrl2/gfS6zNxuW5ct7FAs6z/FybMfJ9Cw7c0W58JMTLj
 ej9El0nPYKT8D7+uGtl7QK2wsbuJlZaAO6MKgF0wI8/kzIS84wN/+K4sK3NWVxQVQQGEXpewzRy
 JpZnwpaGQmk9LiKDDx8+EdzzOalAYoeDaS5DJiWtM4sHcMRAkYENyhAArw7o6FXS+JFOSxJK4+U
 mZqEABvlPPCzIWX4NfYxaXI2YN+OOOjfm2h+q3coxWNV5w+ODv5yDbzlEpyHVnJL9ZM6gKQEIcf
 8rjgz+MR4sSCDJh4Yt+fmJ5Jg5mu5jAaz4x79B3ardZwtqKqZzCmTSsOi8Bwwter26ln8pHAV2K
 Fd1CgYFvT
X-Google-Smtp-Source: AGHT+IE6zeO/suq/tt06p7owY1n8PcDFsrfruOilTVQ7Y0kTeOKlsWlEtlQdeFGyhFa+vxYP0watzw==
X-Received: by 2002:a7b:c5c6:0:b0:440:67d4:ec70 with SMTP id
 5b1f17b1804b1-44091ef2dffmr16649715e9.8.1745401080786; 
 Wed, 23 Apr 2025 02:38:00 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d40766sm19039485e9.37.2025.04.23.02.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:37:59 -0700 (PDT)
Message-ID: <7b4addd7-48b8-4664-9830-9858e6364573@linaro.org>
Date: Wed, 23 Apr 2025 11:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 048/147] include/exec: Split out watchpoint.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-49-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> Relatively few objects in qemu care about watchpoints, so split
> out to a new header.  Removes an instance of CONFIG_USER_ONLY
> from hw/core/cpu.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/watchpoint.h           | 41 +++++++++++++++++++++++++++++
>   include/hw/core/cpu.h               | 30 ---------------------
>   accel/tcg/tcg-accel-ops.c           |  1 +
>   system/watchpoint.c                 |  1 +
>   target/arm/debug_helper.c           |  1 +
>   target/i386/cpu.c                   |  1 +
>   target/i386/machine.c               |  2 +-
>   target/i386/tcg/system/bpt_helper.c |  1 +
>   target/ppc/cpu.c                    |  1 +
>   target/ppc/cpu_init.c               |  2 +-
>   target/riscv/debug.c                |  1 +
>   target/s390x/helper.c               |  1 +
>   target/s390x/tcg/excp_helper.c      |  1 +
>   target/xtensa/dbg_helper.c          |  1 +
>   14 files changed, 53 insertions(+), 32 deletions(-)
>   create mode 100644 include/exec/watchpoint.h
> 
> diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
> new file mode 100644
> index 0000000000..4b6668826c
> --- /dev/null
> +++ b/include/exec/watchpoint.h
> @@ -0,0 +1,41 @@
> +/*
> + * CPU watchpoints
> + *
> + * Copyright (c) 2012 SUSE LINUX Products GmbH
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef EXEC_WATCHPOINT_H
> +#define EXEC_WATCHPOINT_H
> +
> +#if defined(CONFIG_USER_ONLY)
> +static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> +                                        int flags, CPUWatchpoint **watchpoint)
> +{
> +    return -ENOSYS;
> +}
> +
> +static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> +                                        vaddr len, int flags)
> +{
> +    return -ENOSYS;
> +}
> +
> +static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
> +                                                CPUWatchpoint *wp)
> +{
> +}
> +
> +static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> +{
> +}
> +#else
> +int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> +                          int flags, CPUWatchpoint **watchpoint);
> +int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> +                          vaddr len, int flags);
> +void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
> +void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> +#endif
> +
> +#endif /* EXEC_WATCHPOINT_H */

Should we also move the CPUWatchpoint definition?

Can be done later, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


