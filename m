Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122B1F8D750
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDNYz-0005b8-FP; Thu, 16 Apr 2026 10:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDNYv-0005al-3r
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:19:23 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDNYt-0004fj-Aq
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:19:20 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6501c4857b2so5431070d50.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 07:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776349158; cv=none;
 d=google.com; s=arc-20240605;
 b=WwvVlZD/6kGxNYvy8AlZgLNaz4w6L2oT8TGJk+FcjBQgloLnNRTdTkpu2s4yW+rY4x
 Iee1/5r2dXMcpTNj3LbGz1Jyzb4VQyUGt6aUQyPHi31SgyjQRyes6CjCDLh2U5hiTnPD
 zP43XYsKDj0fGm4qQUOxpdxsGS9Ju5vYFJ+PbWYo/ZOe3fFD9zOf7tDs6gUO+2YlV/P2
 n3hafBv5a/d+zIoJ0ahmbiIM3D3aBYs26QCj5X4Y7yRQTSbU1aC1fHWY/5eRrFiT6pEB
 if+hFH3vLGzsb7MxTrF5QUYAhFuK2zteRXiFyOG1H3nkLUTgkXSWOEqdzVsN9ZtDVgBu
 wSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1geutfm8KPG93vOVreUN9aiOgGXCL5WUa6O64Iz+8QQ=;
 fh=1oF5DrJG9LIHDfFiSnej3zqcNO8fJceBJ8nnryHnEUk=;
 b=V2M4RDZUUw+YSZtdtaVyBDHOkSuju2onH0cOCa7Vlfn/tQADQQ1ehsipiyAXOY7PUj
 /YR9+CSgCFxNjiV2Qt06TKllT3YVMUVIbSMZRBh4jXzO84Ri9H8ecKdNXA4sIF2/3HPC
 86z4KsPvFhQqGB/xY9OnsDj5o+qhNRr28W+kDHqJ7kup+nJAaTWY7xUATcANl5tkb+G6
 +WMANbnSKEYVTuwMuzv3rCh/YVpnMxV+qhXrBOAaqczqPk45m1VZKe25aXhmYmDtstH+
 ZrTbbB88NMO1IUO3+5h/FFoz4gBgFMVSdbhUYYp2g7OdhhLfyB48eZPBqiD1JVgQhfFf
 B2DA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776349158; x=1776953958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1geutfm8KPG93vOVreUN9aiOgGXCL5WUa6O64Iz+8QQ=;
 b=wv/KEfp5QeEHgP0NdjTSVpfDg2tIZLkjETzqhd8/5OU1OV0SfBv+C77qoOX4MvcScT
 FYKKy9dx0rQy133SL6VWD4E/rMlzIc2DdKuBI55zhfuLd4OxjSB9dBJSS+L+zyLC5GTt
 v59Ze64mkOCJlJtyBT8o8lpVs5J7/dbwpU5hNw/+P23MyTX5dJQlxFkBEj+LUg7LFwVh
 5h/lPiG04sjBitpj36nGKa7XgyWa5m/v5inEQQzdq9GOg6uNZYgfQQFzni9g68vaN3il
 rzOsPfDke5V79HnFmYWSPQ67hxiBAh0O3yJJyHur7bZhhwo++Hi7RbSmpb4uSjclWywS
 BmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776349158; x=1776953958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1geutfm8KPG93vOVreUN9aiOgGXCL5WUa6O64Iz+8QQ=;
 b=WENaAE/VSSnUNKdsr5muyfWYK/KGrqfCHLoa650hOqTnhSJiliV9fekVmZhQidUGQh
 1psR8jpeuYNmsIZw51N10qOV5iRwnEWuTgL96rHnUOIx/IiN7lyaK9a0Po+NRyy/t73o
 QYJuTt/eAQVCz21nxh3dOA5iYroht/0MGwsWs6fuY2EoeqXOzSzM53Ml/1oEE40U5kfj
 fziYu+FBhvB/6LwGAjRjBy+ZWzScwAsYJO7kMTf/YdkchTliS0MW/9eWHteChR4Fm2fn
 ECPP/UEgD5vrFJm8psf+U+ht5PM9w8Ojknd22qsqySVXT5dHOUCpeBVuDZUMxuZas281
 yNgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i1TBjkBxZ1fjaZD9SnurwlqLAOMLvVq0XDa8XVbrpPWpgM3aTgZ5QbPKAOFTYoq7aCAasM1aI5SEQ@nongnu.org
X-Gm-Message-State: AOJu0YxUtNqQhUsKUDNBBgFf+oKj/5uQut762YNVV0ZYJZbyL6ZvWEbq
 MzgVUt5kobys5Lj1lbnELAUhLAYefH9ZuHf/4YLCUaYFnZYJnzM7PxfvwtU7GC/EDvNcx/vuK30
 vB7P4EMoOX8zQ0jgW/VYuS9QTije97uMz69uPBrwmQg==
X-Gm-Gg: AeBDievkVJV4V7wRV+4vWO8OBttakXtHqH1g5SN0jah4OzmVFT6IaK2pisrIXiVqNJT
 hlrQMt6hVPbK9DziHnPYlmr8ZJyGqYJv6tEqepMjJkkjq0nT2sLpKMNYsMtxyw9BK1xydPGq5ne
 FEqjsqTfz5vCdacXs6jK9mi/Tb28kqMWGJ677ro9DJzOo9kBQn0KNaN7QqeCVRyY5FQzYkANT35
 KIOdw3AC92JSkahVV4p9uIpxGSbvhmuTG+lA/JGX1Vnkf1WdOSx1d3cs786YScBVGc94Eike4Vn
 fxzvcq9oWgXIex7TVmIxKgqB64C5XWRkRyb5kWcF5vR8U9EgylbI4ShAHU1f12ui1zmipzI1oZ3
 9xw==
X-Received: by 2002:a05:690e:2448:b0:64f:fc0d:624b with SMTP id
 956f58d0204a3-65198b9f915mr17785441d50.56.1776349157993; Thu, 16 Apr 2026
 07:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260414025335.2847358-1-mattst88@gmail.com>
In-Reply-To: <20260414025335.2847358-1-mattst88@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2026 15:19:05 +0100
X-Gm-Features: AQROBzAuZnITnrfbKYnBrJQ0spgVDEqSuxJSm41lQM-chJZ_KrtoLjM0cEzkdEY
Message-ID: <CAFEAcA_PZ2RWNNrBoM0nzOrDZZ36p2sMOviT_NeRXWdab=6T+Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user/ppc: Fix ppc64 rt_sigframe stack offset
To: Matt Turner <mattst88@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 14 Apr 2026 at 18:27, Matt Turner <mattst88@gmail.com> wrote:
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
> Guard the +16 with #if !defined(TARGET_PPC64) in both setup_rt_frame
> and do_rt_sigreturn to match the kernel.
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
>  linux-user/ppc/signal.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git ./linux-user/ppc/signal.c ./linux-user/ppc/signal.c
> index 24e5a02a78..b21aa2430e 100644
> --- ./linux-user/ppc/signal.c
> +++ ./linux-user/ppc/signal.c
> @@ -525,7 +525,15 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>      env->fpscr = 0;
>
>      /* Create a stack frame for the caller of the handler.  */
> +#if defined(TARGET_PPC64)
> +    newsp = rt_sf_addr - SIGNAL_FRAMESIZE;
> +#else
> +    /*
> +     * The +16 is to get the siginfo and ucontext in the same positions
> +     * as in older kernels. See Linux's arch/powerpc/kernel/signal_32.c.
> +     */
>      newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + 16);
> +#endif
>      err |= put_user(env->gpr[1], newsp, target_ulong);
>
>      if (err)
> @@ -641,7 +649,11 @@ long do_rt_sigreturn(CPUPPCState *env)
>      struct target_rt_sigframe *rt_sf = NULL;
>      target_ulong rt_sf_addr;
>
> +#if defined(TARGET_PPC64)
> +    rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE;
> +#else
>      rt_sf_addr = env->gpr[1] + SIGNAL_FRAMESIZE + 16;
> +#endif
>      if (!lock_user_struct(VERIFY_READ, rt_sf, rt_sf_addr, 1))
>          goto sigsegv;

Thanks for this patch; comparing against the kernel code QEMU is
definitely wrong here.


I think I would prefer it if we avoided the in-code ifdefs
and instead had something like this defined at the top of
the file, e.g. below the target_rt_sigframe definition:

#ifdef TARGET_PPC64
#define RT_SIGFRAME_ADJUST 0
#else
/*
 * For 32-bit rt sigframes we have an extra 16 bytes of gap
 * on top of __SIGNAL_FRAMESIZE; this is to get the siginfo
 * and ucontext in the same positions as in older kernels.
 * See Linux's arch/powerpc/kernel/signal_32.c.
 */
#define RT_SIGFRAME_ADJUST 16
#endif

Then we can have the code unconditionally do
   newsp = rt_sf_addr - (SIGNAL_FRAMESIZE + RT_SIGFRAME_ADJUST);
etc.

thanks
-- PMM

