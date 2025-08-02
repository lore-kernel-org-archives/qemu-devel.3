Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21804C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJ6F-0002jO-7p; Sat, 02 Aug 2025 16:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ50-0001oy-0g
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:43:47 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ4x-0006Up-Jc
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:43:45 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71b73225060so18169497b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167419; x=1754772219; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nDo6vqmxy1zh+VjEUO6P+Azd/gbs+BaoDPwF0YGGuFI=;
 b=O9JdqY6XTxvEvQ8BfI//8GvhB0EQViiVn6xg2hU2GJ57+jBDpxtSJh3g3/WUTK+bgL
 6L4GnsI7tBaFeI1DWJA9DicMCV/yQRyJodCM1xZVWr4MPpfCuEuLx2T6/f5/cVVskeUT
 gOEaLSz888KobY2AYROVMIF45BSre4sIxjSUbY9TGfpHfgLVUzznF5WUCWM7BTq+uCCf
 8uNqQz4/C6w3KbXvK2OvQoADKQA+8vfCxqG2WA9F89omh9hUxBR32h9/VkEeTAiywYMY
 47o/aMEwYxBCUYCr4b8b8LLQNulN1nytrYcpqbn7VTNDyHsjxesp7Wu9XCT7grEvJvdo
 TQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167419; x=1754772219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nDo6vqmxy1zh+VjEUO6P+Azd/gbs+BaoDPwF0YGGuFI=;
 b=oLW4vhjCxNouJVFRAelwPM4KhxVYB5xJcXx7d7lWeGnM331CQIYxwUw3xN8KR/X6k8
 FNgz/wAbR/IQYuLlPSfdpNknv1ffTcaSUPKuULom+cnC/yOpDTkqazpA5kIh6GPwKv1S
 X7clVo7W/J/NDvSldjmMgMifZmcmqsUdCu9rKHvqQGvUtWteykTJCx+dW7Uq1nP1ppiC
 sl05QaoWzWC9m66iALdjlK7j+yoJt16vcCcwYLZg6gAK33YeWhclbCgh3YZwhstJqZQa
 ml+fhNIeehEEOk+AotQhMBGrk5Dnrs4NfY8y7i6jZSiy1iACmwUE/cs8a2dhZbq/3hIY
 I/cw==
X-Gm-Message-State: AOJu0Yz9eNqFv/gYE0BwtNHG0PHyVkTSzlrJRuk1ch0dWIvPk00xUp2M
 JqXJiVVyQkRtklFM6RLB02DxBE/2xHrGb5XMGrIOor93QSv4RusMdsZEzzkDeexzFk+I+ZAHe53
 rEPoHRX5P4yd4SB9x9F/FHD7t9glGOQKGeK0mP/uRiA==
X-Gm-Gg: ASbGncsVb3rJZU9Y+CitZmct2nsjEo2bBgLaP/iymLYULH6TGdtnUsXAARfp4N6WZhs
 hKjKrYv1fPkBE5u+tGuPM+IQfzAuGTRsU0LwUl1On3YLftvvLw1dcnvey2hGeNazBoaLpNTgjLa
 pI34+G+wvkiBWU7MFze4Lg92I38UOnLLy9dl/RpNKB0+vyapcboO9nheV7mrudMHB67UPuvXiLI
 iSHloa/
X-Google-Smtp-Source: AGHT+IFYuvuYlEpDdKV/q35g/QCaQu8Apvpfddg+0a+ItdifeCA0l9w95Xfv2EVq2DPgzpRv4kNf+RznRIuKUOqYGkg=
X-Received: by 2002:a0d:e505:0:b0:71a:23b3:13b2 with SMTP id
 00721157ae682-71b7f89cfcdmr41619257b3.32.1754167418908; Sat, 02 Aug 2025
 13:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-88-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-88-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:43:27 +0100
X-Gm-Features: Ac12FXx61SB7wlBhNZ6XM4pdHR3jrg8ll99v_hr8ioHjHOqTd3rkpsjKYMns_ko
Message-ID: <CAFEAcA-XJHoOvHaq1mH-rgRgRjvh9iK24HeOTaphhQ_WFNE1Zw@mail.gmail.com>
Subject: Re: [PATCH 87/89] linux-user/openrisc: Move target_pt_regs to signal.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This structure is part of the openrisc signal frame.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/openrisc/target_syscall.h | 11 -----------
>  linux-user/openrisc/signal.c         | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
> index 7fe5b73d3b..c8394e9dcd 100644
> --- a/linux-user/openrisc/target_syscall.h
> +++ b/linux-user/openrisc/target_syscall.h
> @@ -1,17 +1,6 @@
>  #ifndef OPENRISC_TARGET_SYSCALL_H
>  #define OPENRISC_TARGET_SYSCALL_H
>
> -/* Note that in linux/arch/openrisc/include/uapi/asm/ptrace.h,
> - * this is called user_regs_struct.  Given that this is what
> - * is used within struct sigcontext we need this definition.
> - * However, elfload.c wants this name.
> - */
> -struct target_pt_regs {
> -    abi_ulong gpr[32];
> -    abi_ulong pc;
> -    abi_ulong sr;
> -};
> -
>  #define UNAME_MACHINE "openrisc"
>  #define UNAME_MINIMUM_RELEASE "2.6.32"
>
> diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
> index cb74a9fe5e..9242d06002 100644
> --- a/linux-user/openrisc/signal.c
> +++ b/linux-user/openrisc/signal.c
> @@ -22,6 +22,18 @@
>  #include "signal-common.h"
>  #include "linux-user/trace.h"
>
> +/*
> + * Note that in linux/arch/openrisc/include/uapi/asm/ptrace.h,
> + * this is called user_regs_struct.  Given that this is what
> + * is used within struct sigcontext we need this definition.
> + * However, elfload.c wants this name.

Is this bit about elfload.c still relevant? (Presumably not as
it won't be able to see the definition now we've moved it.)

> + */
> +struct target_pt_regs {
> +    abi_ulong gpr[32];
> +    abi_ulong pc;
> +    abi_ulong sr;
> +};
> +
>  typedef struct target_sigcontext {
>      struct target_pt_regs regs;
>      abi_ulong oldmask;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

