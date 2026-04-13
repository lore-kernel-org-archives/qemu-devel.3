Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720E7F34C4B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGVg-0007Ab-Ss; Mon, 13 Apr 2026 08:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCGVe-0007AC-V1
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:35:22 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCGVc-0004iV-Ug
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:35:22 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6501c4857b2so3473782d50.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776083720; cv=none;
 d=google.com; s=arc-20240605;
 b=idHvirusUU926J8CvLUvDVDJHGJvWVvJiDpyj1WxC4hEoLySnSPvSZ2qCLT26PCV+/
 uYkPoPiRJskNTU+qQz87XinJjEN3KgEGca34IbCxzf0ltVXR10IGoWgND9wSvG3XZ7lP
 cw0L+iCR2vS2amCI2nQYuMrHzCE0n8emTDYPMYxsrkXwIjNa1s5obHQetYidCX//tQPl
 fliZcnJWh+M0uK96GKZ5vZGp6EsBsm0M6qDVs4iYhrs4HXgIYKph8cxm5LuobVW/DA2D
 e7lKQAmgIocL2JFKkndo1llUJmf7NtTThPXlY8Me99i0N1gS1ESkifalrtRb54790yBx
 zYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yl4RxljFlL2zQhrWwJUvTBU3Rj1lgogsz3ZXCm5OQqY=;
 fh=iqRDn0HWqOWFRTM6TPT7Rp+m3JdAe6EjJsWwnoP/5Os=;
 b=i90bHWPCaMPyNTSwHdcIJkmtYp76vSOWq3cr2k16DwVw/RWe2Jls+AWxg748Tnmw/2
 nW61kxjl7L4hmCICnuqNo0f7b6VTjxgC37+YGXMIjc58C4Iz3sPtg0OLcKQQcj8Bliu/
 riLHv2nfi5lQiYcnxzY4z7pXHwPrq1QTyyg3YZ4rxD4fWeDOA23w1Gd5l8CHxXoqp/mW
 4FV0hzt3pVK57bmhQAg5IRi8VVWbwWoejZYBDyuIfIocOMSl8hKRi9+IPl9cHt+e1ZOP
 JCZH/MedJQF4XGgx6fojB2YWmjyeSWzm3hZ6lYEv3KWJU112D6XJG3iass3CiH++vl+U
 p+KA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776083720; x=1776688520; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yl4RxljFlL2zQhrWwJUvTBU3Rj1lgogsz3ZXCm5OQqY=;
 b=JGheMcJSGQ02sulSGleVe+kaqEy7e+rh9F3fgruSYmYuRVFxVamk0qX76yXgK4RX4s
 nJxh/OaR1f/IiOF3UXocMOr8dZR0fsRDw7qb+caPIDLmzqb60V0WQ3GUGXVN3LcgxgHE
 2sKRxk4wDhiUldSIy8Kr0PBtTKl+TDTdsaQdHN2TppZYk5OAYyykiucNM7+9zsCY0DOI
 KZeCCyaPGxfY9BHX+w44q1g2xFBSPcRrw/TvN1AAxJHCB9pgnveRJAkUa9czHqnq3K6p
 EXc5mDu1VAl52pWnDYP13fxTTrggzdhLRxDEaaWbyY3xeyb/PwSvQigT8mLfHiFN0iRz
 IPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776083720; x=1776688520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yl4RxljFlL2zQhrWwJUvTBU3Rj1lgogsz3ZXCm5OQqY=;
 b=Xrhr3rx4q4R4lk5/3wHOz0EMzxTgdXxICVubLAjcMBp1fdOGGadB5trpaDYyoViw+U
 AOuInx8IttxPVJ6lWFDIH5bjVkWJrFmT3698elRNWexfdOR9ww71yE7DtfkKchlO7Gsj
 GT8TJKLgWI9x+jFECzfZ3tF1/4M12QaNe5bn4W6SJqYtX9LY1z3ojwJgcUwigaXJayvn
 IJmQbdWv6pYyEBR1dwdrM0+TS5p20IWM7MFzstuax3/XuBg71Se+ZEDC1ayDURBU1F3w
 QPWf2dCkEhCzPaLezw+aZ+BP3PiSGAPGOOsA40jYQQeZt3eVudQGZBO1o+Kyt9df5ovm
 3tOQ==
X-Gm-Message-State: AOJu0YwdqmGczGGuJOLbdEkJwd9KZVawBNiO38pPJy1yoFYi17tSphij
 SmNlGp0odDvHBn0qi9xnDVfp2gMX4q6vog+32H0it9YbthFFUW6pmoPalrIfKphFrxcos3xmU7s
 N/HD49by+owOetdji1tw0VwM1w/0oK780wZvsQaRGlA==
X-Gm-Gg: AeBDievauXpHUNo58ipdfD4og1j1UUEbJBWEy7M6VIzG8lu+L/0owN2tDhJUtzcvfdi
 B+TCtDwUhhUcV0xbb2jprp8VmqNzE9Idjugw3YxMnwo2pcACkhb5zGJp6BG5W1l11nZ7+XyfPnn
 owdsokji1AgHqgp28w7o351qmrj+7s6CdqMvj8PdlILfjzW9dC5O+CI6iOoAbJlZ+aYERBsa6Uf
 tLeYOJ7xBiHpyEwqnPcflAeiGlA/HkAld34n0lX62/ER8ybqZeYvQQl04uq7uwBjdbUF3O98Msi
 V7rTM+uofXphkINDVY5QiwbcLwSybxwXtsrPQtxA02V+rraghfxBTfrGEBZklqro0ehyyKG3NJ9
 e2A==
X-Received: by 2002:a05:690e:438e:b0:64a:edf2:e769 with SMTP id
 956f58d0204a3-65198a38613mr9586279d50.10.1776083719390; Mon, 13 Apr 2026
 05:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260413115622.160212-1-scherer.simon89@gmail.com>
In-Reply-To: <20260413115622.160212-1-scherer.simon89@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 13:35:07 +0100
X-Gm-Features: AQROBzAiQI3t81bsQPB-qql_jhW7sTq9mPAk2AcZpfl2s6GHtIVk-dTS8xLgJuk
Message-ID: <CAFEAcA-PGSc2bae3CxSHMqMwrvTJDOoE80_O9xAovOObOzuR=g@mail.gmail.com>
Subject: Re: [PATCH] target/i386: fix missing PF_INSTR in SIGSEGV context
To: Simon Scherer <scherer.simon89@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 13 Apr 2026 at 13:17, Simon Scherer <scherer.simon89@gmail.com> wrote:
>
> When running linux-user emulation, the SIGSEGV handler does not
> correctly set the 4th bit (PF_INSTR) in the error_code variable of
> the context argument (context->uc_mcontext.gregs[REG_ERR]).
>
> Because this bit is never set, guest applications cannot distinguish
> if a fault was due to missing executable permissions. This patch
> ensures that when a page fault occurs during an instruction fetch,
> the PF_INSTR flag is properly populated in the signal context.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3384
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
>  VERSION                            | 2 +-
>  target/i386/tcg/user/excp_helper.c | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/VERSION b/VERSION
> index de760e732f..340ebebb29 100644
> --- a/VERSION
> +++ b/VERSION
> @@ -1 +1 @@
> -10.2.92
> +10.2.93

Your patch seems to have a stray other change in it.

You don't need to respin it just to fix this, and if it gets
reviewed without needing any other changes then the maintainer
will probably fix that up, but if you need to do a v2 of the
patch then you can sort it out for that.

> diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
> index 98fab4cbc3..6c5df5e0e8 100644
> --- a/target/i386/tcg/user/excp_helper.c
> +++ b/target/i386/tcg/user/excp_helper.c
> @@ -36,9 +36,10 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
>       * signal and set exception_index to EXCP_INTERRUPT.
>       */
>      env->cr[2] = addr;
> -    env->error_code = ((access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT)
> -                    | (maperr ? 0 : PG_ERROR_P_MASK)
> -                    | PG_ERROR_U_MASK;
> +    env->error_code = (maperr ? 0 : PG_ERROR_P_MASK)
> +                    | ((access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT)

Why did you reorder these two lines ? Is there a code change here I'm missing?

> +                    | PG_ERROR_U_MASK
> +                    | ((access_type == MMU_INST_FETCH) ? PG_ERROR_I_D_MASK : 0);
>      cs->exception_index = EXCP0E_PAGE;
>
>      /* Disable do_interrupt_user. */

thanks
-- PMM

