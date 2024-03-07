Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FD4C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 21:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riL0D-0001LB-Br; Thu, 07 Mar 2024 16:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riL0A-0001Kt-CG
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:10:06 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riL05-0001y5-Pw
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:10:05 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso1140111a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709845799; x=1710450599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z3FfCHYft6qroDOKmbK3yyeWhDFazotU6y4xX/OA2wU=;
 b=Smr0Dd+bDnlb+1bcmAgFGAFAI/532w5fu69aOXnArnn1S0uH+v1dXatwvEKWze0i4t
 AWkJZqEBNSHK2+uDdzrFbSf+jouYVEZDZ95wnU8C7cVYIzY3CGoje/cXOaOdAUcRwNnW
 AZsifoG2qJ37hKQN6rlijN4oBg+NcfxOHJlkvKCmCHYEf6Kd+Aqfu18cxVbr498blNln
 d0vdfnm0Oz7bJJewGaMIB9RBXPQ+YfTOFuIPhUiRe1/rF8SCwHvm/ZgR9Tw7HiUaayQf
 sWR/8J3cYJQqeuxvdmGUf1E7EBtZX+I3w3cD151pOmfD0x4Q9y7jWGAvsWUDrdtLBBgg
 sopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709845799; x=1710450599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3FfCHYft6qroDOKmbK3yyeWhDFazotU6y4xX/OA2wU=;
 b=CEju2LFqaK+7AiBvGFJTIfSS+04wyuXGNZZaI+SjN9VEopzq0HDrB5aY2CYfbca7Nw
 KXM9eQN5oBG10Vuoqb2k6Wt7mUhfS5z2Q1CoZuEH1smPrIUQWpGy+bNcXLtE5XqT32QV
 Balolrqp/QT8ApT7eE8c5dbHzFVDswExEE87AkarV5k8ck2zkrqbMzAQpPg2gFhpHbkp
 S/ZfIFJEVj6WWeDDAicCdFmSNge4kIrY4mRgikdNYgCt13ihkdX+xf6aOAcs4a3WPR6Z
 9xLowB3sOCuw7mrwdfdWaPr7F6adGWpW+7XWpA+ZN50mhoLH01+n+IP9Yn1qIjwBWmwr
 SsMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiZ3oxKs8XxrB7QQKzoUIBcw+WMRCE2sjU+XCfpLYHPbEtQWRrn/f/IFIUtFjSx8MwAhN29bqku9fWr98wK9Hb38ucmO0=
X-Gm-Message-State: AOJu0YzgqEHlOW04oKGc47EiOFdmHnGhxw93EG2gv3fagGPSXHeIcxaF
 Hpt2ds8BEjmghuc8wBLKnQeKy1pmpYET9qvHNZ7QuHLHBSbmlJodDIYz/JwFJH0=
X-Google-Smtp-Source: AGHT+IHYQIl3JXqKushFTKXB/ElhdF+VKyfIMpX6xfMJ2pK+Om1/Wf8RCN/1K0mTQDK51AkYJuhZBw==
X-Received: by 2002:a05:6a20:7f96:b0:19e:c3a1:238d with SMTP id
 d22-20020a056a207f9600b0019ec3a1238dmr10085579pzj.52.1709845798772; 
 Thu, 07 Mar 2024 13:09:58 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 m6-20020a62f206000000b006e56a4a2518sm12852685pfh.203.2024.03.07.13.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 13:09:58 -0800 (PST)
Message-ID: <637e4407-4519-4d87-981a-acd9b5124970@linaro.org>
Date: Thu, 7 Mar 2024 11:09:54 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] gdbstub: Save target's siginfo
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-3-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307182623.1450717-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/7/24 08:26, Gustavo Romero wrote:
> Save target's siginfo into gdbserver_state so it can be used later, for
> example, in any stub that requires the target's si_signo and si_code.
> 
> This change affects only linux-user mode.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   gdbstub/internals.h    |  3 +++
>   gdbstub/user-target.c  |  3 ++-
>   gdbstub/user.c         | 14 ++++++++++----
>   include/gdbstub/user.h |  6 +++++-
>   linux-user/main.c      |  2 +-
>   linux-user/signal.c    |  5 ++++-
>   6 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 56b7c13b75..a7cc69dab3 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -58,6 +58,9 @@ typedef struct GDBState {
>       int line_csum; /* checksum at the end of the packet */
>       GByteArray *last_packet;
>       int signal;
> +#ifdef CONFIG_USER_ONLY
> +    uint8_t siginfo[MAX_SIGINFO_LENGTH];
> +#endif

If we this in GDBUserState in user.c -- no need for ifdefs then.

> --- a/gdbstub/user-target.c
> +++ b/gdbstub/user-target.c
> @@ -10,11 +10,12 @@
>   #include "qemu/osdep.h"
>   #include "exec/gdbstub.h"
>   #include "qemu.h"
> -#include "internals.h"
>   #ifdef CONFIG_LINUX
>   #include "linux-user/loader.h"
>   #include "linux-user/qemu.h"
> +#include "gdbstub/user.h"
>   #endif
> +#include "internals.h"
>   
>   /*
>    * Map target signal numbers to GDB protocol signal numbers and vice

Why are any changes required here?
Perhaps this is improper patch split from one of the others?

> @@ -140,6 +141,11 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
>           return sig;
>       }
>   
> +    if (siginfo) {
> +        /* Save target-specific siginfo. */
> +        memcpy(gdbserver_state.siginfo, siginfo, siginfo_len);
> +    }

A comment here about asserting the size at compile-time elsewhere would be welcome for 
future code browsers.

Need to record siginfo_len for later use -- you don't want to expose all 128 bytes if the 
actual structure is smaller.

> @@ -510,7 +516,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
>   void gdb_syscall_handling(const char *syscall_packet)
>   {
>       gdb_put_packet(syscall_packet);
> -    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL);
> +    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL, NULL, 0);
>   }
>   
>   static bool should_catch_syscall(int num)
> @@ -528,7 +534,7 @@ void gdb_syscall_entry(CPUState *cs, int num)
>   {
>       if (should_catch_syscall(num)) {
>           g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
> -        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
> +        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
>       }
>   }
>   
> @@ -536,7 +542,7 @@ void gdb_syscall_return(CPUState *cs, int num)
>   {
>       if (should_catch_syscall(num)) {
>           g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
> -        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
> +        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
>       }

All of this makes me wonder if we should provide a different interface for syscalls, even 
if it uses the same code paths internally.

Do we want to zero the gdbserver siginfo to indicate that the contents are no longer 
valid?  I know it's not a real signal delivered to the process, but might we need to 
construct a simple siginfo struct to match the sigtrap?


r~

