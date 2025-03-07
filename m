Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50797C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd7W-0007iQ-W9; Fri, 07 Mar 2025 14:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd7U-0007Un-Sf
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:12:28 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd7T-00062g-0e
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:12:28 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2239f8646f6so43514855ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374745; x=1741979545; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1HhH1/a/vNakSB0c+FiLn/ypVzfZrQhIOrDLs+y3k7k=;
 b=q9xtgzbB9+U2zUxlY6zZt7vH1eZF4rWzQqoEEtaX5164N/I99AyycScNXWjrwnNHD3
 J/jvWP86b5Lh5w4CntdWXsNnK+RshoXHNnCmyCyZI09+MN+ZzyA32Gc9ohwWHSuSlqzX
 zIIJ462xwhe5v0x0QzEoB3AaXBSbSQwBa2dxCrm6zY0M/+ouD/OLXRwcFqtdl/mZOBOb
 RIRJjc2SjavokYIMNPSr9ieq0hvlxvlL/amJM8IK4AgPipYL4xte2ZX0Gz1JL1EHbb5p
 5h60cBUQRCE/jm18D6TREibDCM9a1RYvkIVl+KUpeetp2m7S1CGu2R87+sEGxbh/gm35
 i2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374745; x=1741979545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1HhH1/a/vNakSB0c+FiLn/ypVzfZrQhIOrDLs+y3k7k=;
 b=DnbEFbdiLl7A/HStTn24FMTt5QuJS5t4PhOovaIren1uQdJz+gY9RBSoHQfmTJAmmk
 UbTWxUCLgu2O7US0CwRo33vibQSaZ42ekcHrSpbZf6n9jJ92b4St+OLeLSAk6Wc/fbWO
 N2+Db3+ZZC35Ykk5RheKpgCYT+5I384nOGYp7NyvZC+mk+euXQO87v+6oCy8fVQ7rzlr
 +nC6gX5rgzFRDgpxYvU8yK17swr4Pm4PHC/A4BKb7kK4PAdunmO8y8Xp36tala+3rXeV
 tNApu90ddTxOongPwZC6BK5RK9px6g6+r5ZGuSRYVD+hW3HAiFMKltUJnzaVvsIJspiq
 eFVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfVazxjxsVFSlFuefLnd+hl3nrJ/ejjiXdti9zPcHsIRPBuxKjGgm5gtLffz3asi6cocRvbm75qsT+@nongnu.org
X-Gm-Message-State: AOJu0Yx+hIoFH4wX1UqCpcNlaDMb6Y5LpXwnOW1EKLthrN51Q0AvJDI3
 MhzzJ/47ZHkZCC+h7JWmAUlR3DeIUxeyJj9P53ss3cEX+9XXGD0cfnQYLl7Z2V0=
X-Gm-Gg: ASbGncvbO4FE3MAXR0/4xUF5USBtwLl5tUpGWCjzfR4hY3O6THd0x+cPD3puK2m5OUO
 q1M3QPYG5rI9u6840mmBFoYfzIJ2/BKG95nU5Yp4aHaaXymeQP213rNZf1DeSFGuvPeEUDp0fvY
 yc3fP/Izvqul2RK6oN30NCEkhgGHkbIirjMD2xowYcKGadwrdSSpvltYLzdVN3u/4PRQITtG3xQ
 fG7qyo52aHvsZIoWiduTPLv7I4sXUuGuLJqNHv7wqAmF1NVdcB9QKBBBjo3oQuxSimGewtQZO7U
 RRm2EDUbB+gNsloCmc8t9gZOCJUGP81FUhgCxOYevJklNpkAxVTwe3Dmqw==
X-Google-Smtp-Source: AGHT+IH9mBy9adcB/d3+ApbHTUQq/kjpgKp5wlU+FTUwtA4SNyNzN76sewkS5ZrUP+DLk8r1CSo50A==
X-Received: by 2002:a05:6a00:987:b0:736:34ca:dee2 with SMTP id
 d2e1a72fcca58-736aa9d389fmr6657303b3a.4.1741374745550; 
 Fri, 07 Mar 2025 11:12:25 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698204fbesm3614587b3a.36.2025.03.07.11.12.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:12:25 -0800 (PST)
Message-ID: <4453772c-bba9-4d9b-a917-135ece56efae@linaro.org>
Date: Fri, 7 Mar 2025 11:12:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] accel/tcg: Compile watchpoint.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/7/25 10:56, Richard Henderson wrote:
> Move tb_check_watchpoint declaration from tb-internal.h, which is
> still target-specific, to internal-common.h, which isn't.
> Otherwise, all that is required to build watchpoint.c once is
> to include the new exec/cpu-interrupt.h instead of exec/exec-all.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 2 ++
>   accel/tcg/tb-internal.h     | 2 --
>   accel/tcg/watchpoint.c      | 5 ++---
>   accel/tcg/meson.build       | 2 +-
>   4 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> index 7ef620d963..9b6ab3a8cc 100644
> --- a/accel/tcg/internal-common.h
> +++ b/accel/tcg/internal-common.h
> @@ -72,4 +72,6 @@ void tcg_exec_unrealizefn(CPUState *cpu);
>   /* current cflags for hashing/comparison */
>   uint32_t curr_cflags(CPUState *cpu);
>   
> +void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
> +
>   #endif
> diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
> index abd423fcf5..62a59a5307 100644
> --- a/accel/tcg/tb-internal.h
> +++ b/accel/tcg/tb-internal.h
> @@ -75,6 +75,4 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
>   
>   bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
>   
> -void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
> -
>   #endif
> diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
> index 40112b2b2e..ba8c9859cf 100644
> --- a/accel/tcg/watchpoint.c
> +++ b/accel/tcg/watchpoint.c
> @@ -19,11 +19,10 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/main-loop.h"
> -#include "qemu/error-report.h"
> -#include "exec/exec-all.h"
> +#include "exec/breakpoint.h"
> +#include "exec/cpu-interrupt.h"
>   #include "exec/page-protection.h"
>   #include "exec/translation-block.h"
> -#include "tb-internal.h"
>   #include "system/tcg.h"
>   #include "system/replay.h"
>   #include "accel/tcg/cpu-ops.h"
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 69f4808ac4..979ce90eb0 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>   
>   specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>     'cputlb.c',
> -  'watchpoint.c',
>     'tcg-accel-ops.c',
>     'tcg-accel-ops-mttcg.c',
>     'tcg-accel-ops-icount.c',
> @@ -30,4 +29,5 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>   system_ss.add(when: ['CONFIG_TCG'], if_true: files(
>     'icount-common.c',
>     'monitor.c',
> +  'watchpoint.c',
>   ))

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


