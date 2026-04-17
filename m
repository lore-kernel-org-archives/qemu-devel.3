Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC8EF8DFEA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDelF-00007j-Pw; Fri, 17 Apr 2026 04:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDelC-000064-N4
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:41:10 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDelA-0000FE-EQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:41:09 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6501725d888so346816d50.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 01:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776415267; cv=none;
 d=google.com; s=arc-20240605;
 b=JRO93NPaVleOvmathRD2hieCLHPmoRsQqQe7rpSHSEiGV4V1fVY5Rw/cqnK18HbSli
 P8sWc2wipQ9Xmm6XVFkenUOR8cjQQxTmb5bZNAVw+KAltnK75AsWB6OrGpzLi9iWe5n5
 s1MQzLR9N6rdq/GEGKcbaKWdLo30iHW8FOIvQflJSsunrS7bD2EHFH2t3o3DCNIz/kmL
 Vh3gkuka7TKAUb2dXEu/hfp2iaL2u8n4esWuiXkO3TjrpL7XyKmqyFTvXxZSBrI0YlJt
 YOxoDDifhJgJS3XuchOPKJ6Xv6lpiUAdGObQzsO6m9N6XKqJ9ezsPc5/r/oCkrqu3jpt
 r+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YYQ59/tFTy+T6yNzXzDUClP/6Xr6o3M2itGA5sg8Yow=;
 fh=1UCVhr4WSNKHjpDP/CcjGRPgANHuP+PpD4xnl5sbWAw=;
 b=VvhrO2ikhXQE880C5mo9KVqOO6HVLbyNkNTSDjJF0VjQFkGGBN/h82pZZTmiF8XnAh
 kjHT2o9oiHM41LIzvN/DbYhqIyoJIEmdxA8EqWXWtUzn8dnp26NCriU77ao2eK3WErkb
 wDIiGn2ErC8nNqq2QsAxfO6lGNJxe+LHzq3TtN/mU+eU2f+KjFa/3xKMX/uHEB72Gs5W
 JfDkOYtLGajGnccCbaDg2i3UMM1OU/23n+DR/KuxdA0a7a9s8DVwuGWMuMOMwDQAqUJc
 im6eL9UzcOfcFqoeCj0BIENDT8jymnc9AFMo7OuC4ocfyQKh9vIa0fb90M4Vt+YUub8l
 P62Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776415267; x=1777020067; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YYQ59/tFTy+T6yNzXzDUClP/6Xr6o3M2itGA5sg8Yow=;
 b=XZyLH+vw+sVus/2Rlgkpm5ugYl/D/ero1OWmONRkVmJ/aBdthzpGyR3i5oCs0oBQWt
 BMX/fdObl/kuEzbsTrNQEqemOZ7qF8UbUJlzG4bJPX6LOnAKl36ijCl6Oq/zL9wOPF7M
 vrwOBJWUJaoCeXx9duMODqMVa1+Cpb36iCkgiopB9wal5fGRsHketg3SSNTTurnn18+1
 q5nsUFY36wVe9l9ZSewM5CgY00050l1n7ogXJHqzQ6BFV6/59yIfWozrpqGXCUQqFEl4
 iZRaDqokuOYs1yy0whJzCutfrpot/JHtun6et8sn/kpLumZxHXLSJmkSkpt5F8xCzae8
 9KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776415267; x=1777020067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYQ59/tFTy+T6yNzXzDUClP/6Xr6o3M2itGA5sg8Yow=;
 b=iKMcxzNHuahDoUgM/R0dKqH60DHvY6pZLCLg1nqW+fwydSv3K9KjYB0wHTYzU44r4G
 +Q04rXhgW512qQMGVqCikDoFtP3dJSZ29yjJ0CZYD/9Oy3vGmJACKfTmXIXluuzfw+5P
 cNzg5EuBjnse3P1xzQsKBt1SuOtUYqsfg+5Ykc+i2jFf7yxTSJqZGrb3TFrYxkG1mjLO
 AbCPgJuWX39PHMB0e7Pig9zbSbvfCXamdtSRwmbK6EtBoMOa9sHqGoj8jkSRmikl/mYI
 54YEsj4siKyk4h6xAZvutx9BlkTmptttHh/M7o4WmwyTcpDgnUvprAWm1rz3zSgw8BOm
 w5Ew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xVZDO4SfzMrWzqBx/GKEpAsoYx1EbvYeYCyiLjYeufzVQAll73Tw9x05m4FVlW3GfiA87c45/GO7T@nongnu.org
X-Gm-Message-State: AOJu0Yyf7F0VRD89UIX4k9VatXrqZnAlOLvTY9oiA2h0s8E4pNFcI3Tr
 OhJJQOS/5rdI1TAXnYQNubzWD2xoYw79JnSfQUM33zbrjIouSNy6RevrivHgEttJ5BA8L8sh6Xl
 DhgBxvyLySgfCpJ7D4xN/48BwcyVwZgXvvdSYh7ab1A==
X-Gm-Gg: AeBDievqPKvQWe/Qvd1FBtRo9QQyxP2lABGOLh0yE+fFyx7fP6XNOZmMecjx2Mx9qTk
 278Xhmp+lMtI9udjgC6yQv92LZQ1AzRQTXVcZouo0Vuj+F9JNESnnoHGYQYRAtMgl5xHxuO0Y29
 Pzp1zXUAhcLF0d9+Q3T+eGJIZK6xxMnkiQjysyNjj8o8/5QnnaF/cw8DD7Oi1sN6GIyJgjoOXkY
 PDvZlsl35azEijvkLrCkhOYoZoxhK3TYhysFxBCLFKZS2KuMQHHAqiBrhYwpmOQEeqFn1nswTcv
 /w97s2YIU1n6W73pqH0WqWB2qllQC/8sH+r20OG8nbWB5oTsbYw1k1Q3rp+Jae7uH03OVTjfC6i
 0YQ==
X-Received: by 2002:a53:ca0f:0:b0:650:1c6b:bf74 with SMTP id
 956f58d0204a3-65310b5870emr1273248d50.61.1776415266718; Fri, 17 Apr 2026
 01:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260414025335.2847358-1-mattst88@gmail.com>
 <20260416182527.3862296-1-mattst88@gmail.com>
In-Reply-To: <20260416182527.3862296-1-mattst88@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2026 09:40:53 +0100
X-Gm-Features: AQROBzA6Abv6TuljFT-qeltiUNMIurVNZb8m9EFNc6LLF5ulZj-YZsVNpNA0okY
Message-ID: <CAFEAcA9jbwdo=a5cE7PD=YKiBv9qtCTwA=YaE6pbFf6xww0ZvA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
To: Matt Turner <mattst88@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 16 Apr 2026 at 19:25, Matt Turner <mattst88@gmail.com> wrote:
>
> The kernel's 64-bit signal delivery (signal_64.c) uses:
>
>     newsp = frame - __SIGNAL_FRAMESIZE
>
> while the 32-bit path (signal_32.c) uses:
>
>     newsp = frame - (__SIGNAL_FRAMESIZE + 16)
>
> The extra 16 bytes in the 32-bit case is to place siginfo and ucontext
> at the same offsets as older kernels (see the comment in signal_32.c).
> The 64-bit rt_sigframe starts with ucontext directly and does not need
> this adjustment.
>
> QEMU's setup_rt_frame() unconditionally used (SIGNAL_FRAMESIZE + 16)
> for both 32-bit and 64-bit, placing the handler's SP 16 bytes too low
> on ppc64. Signal delivery and return still worked because do_rt_sigreturn
> had the matching wrong offset, but the vDSO DWARF unwind info encodes
> the correct kernel offset. This caused any DWARF unwinder (libunwind,
> libgcc, etc.) to compute a CFA that is 16 bytes off, reading garbage
> register values from the signal frame.
>
> Define RT_SIGFRAME_ADJUST (0 on ppc64, 16 on ppc32) and use it in both
> setup_rt_frame and do_rt_sigreturn to match the kernel.
>
> This was verified by A/B testing with libunwind's test suite:
>
>   ppc64le: Gtest-bt, Ltest-bt, Gtest-concurrent, Ltest-concurrent,
>            and Ltest-sig-context all change from FAIL to PASS.
>   ppc64be: Gtest-bt, Ltest-bt, and Ltest-sig-context all change
>            from FAIL to PASS.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  linux-user/ppc/signal.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

