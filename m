Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D7BC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSYt-0003DQ-MJ; Tue, 06 Feb 2024 16:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXSYl-00038O-2D
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:00:52 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXSYj-00044H-FX
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:00:50 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d0a96bad85so43985451fa.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 13:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707253247; x=1707858047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h2qa7ZciGW1AFvnMDgRHGxHRpndT8DpWvnBRbYSqNpw=;
 b=Kc+R41GAemrxARd++f15Sd8J87p73DFZ/N+gR30uHdrnyZJ19yot0eI7cxEGRsHF9O
 vfr82LJ4hMplihxG1uMrDhkQ92kez/4qo7q/SxZ5ouVGalvHRmbCXfih8MdpgP4rmzWX
 M4a1sy8mqwODeW8G9pMVJE7x0zXNfyfHx9vNQKTIFTS+uy4+vpYBVyzO2nlxbE2j/457
 mwoIsf6xoNLvho3IjH3OWjRqrKgQ9G8SJxilSxhJsvrIU2z4xUIkgHKVQ6R8gZqY1ePD
 41vD+tYTAdBsx5JzaqksvTtTG8Jg/xTFGaC3SQJ6s9hM2ianLkk/Q5MiufXssOqD0KzU
 N4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707253247; x=1707858047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2qa7ZciGW1AFvnMDgRHGxHRpndT8DpWvnBRbYSqNpw=;
 b=fo6OekABBTSWrfAilTUVSUluOyLyUq2j9NmELZmj9GXhpD6RyI4V9XpfJAbwuueh8b
 MbbiBBzSw/9wlSgkHhuXljfRRPHyvK+8jShj1Bg3cRFGpuE3YO21ucOIP1sBnKALrUm8
 XLnSTBYJmYh8smKtDN48xY5jOkM2hN3+5x6rsDYrYi0YqZplvufWailzF9TRjxVJKNB0
 G2YmjLwVzRVrCyLr3cm2wqHiWpV6/nLvz+socRGqDbhQKrAQL9LT7PusmC27w4DG8i/R
 UniLiJZnVPE+E5jK+3IdH/S0tj2O8ZiPCw8Y1aAO7BDoTRw5aMFBRoxLwvPfuDF0zJrm
 jAoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWizdPDgxKk+V2aWgu9XDTUiH6hgPkMWNuMBIbSQ5LJhsQaxM6MGc8rEK8bKgGsIFSCl8uLcUR5gwbqDUnsCXZFfXYyFyw=
X-Gm-Message-State: AOJu0YwBhsl/2SN22JvqesSXEDS8Ir/f7oY78Gx0t4yT/f/9IIxS6nDa
 ZWgAFy345Et820Ok7aLXHzSqsETfIfvvP8/h2cBHg/f3PZRqBzvvYlTetFlrGXTmnmmKF7wEUHF
 XX6LP38gLoKbwy29Ns5tnqdw1MAdkaaKs43eDtA==
X-Google-Smtp-Source: AGHT+IGX3j9f2UEmEhIkD0M3BEryvBt0cqNxmNVYOoWi9hi/bpWWe0DNlyR91JnTgIwq2WIsmaGkYMK2pLaNRkia9H4=
X-Received: by 2002:a2e:9114:0:b0:2d0:ace4:8896 with SMTP id
 m20-20020a2e9114000000b002d0ace48896mr2695584ljg.29.1707253246942; Tue, 06
 Feb 2024 13:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-2-peter.maydell@linaro.org>
 <768c7884-1a59-461c-a810-4f8a89d4bfda@linaro.org>
In-Reply-To: <768c7884-1a59-461c-a810-4f8a89d4bfda@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 21:00:36 +0000
Message-ID: <CAFEAcA_-8Q0=iZjchVwxDNqMDuYjdLH7XjvHPJU=1oJ3smDFzg@mail.gmail.com>
Subject: Re: [PATCH 01/13] target/arm: Use new CBAR encoding for all v8 CPUs, 
 not all aarch64 CPUs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Tue, 6 Feb 2024 at 20:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/6/24 23:29, Peter Maydell wrote:
> > We support two different encodings for the AArch32 IMPDEF
> > CBAR register -- older cores like the Cortex A9, A7, A15
> > have this at 4, c15, c0, 0; newer cores like the
> > Cortex A35, A53, A57 and A72 have it at 1 c15 c0 0.
> >
> > When we implemented this we picked which encoding to
> > use based on whether the CPU set ARM_FEATURE_AARCH64.
> > However this isn't right for three cases:
> >   * the qemu-system-arm 'max' CPU, which is supposed to be
> >     a variant on a Cortex-A57; it ought to use the same
> >     encoding the A57 does and which the AArch64 'max'
> >     exposes to AArch32 guest code
> >   * the Cortex-R52, which is AArch32-only but has the CBAR
> >     at the newer encoding (and where we incorrectly are
> >     not yet setting ARM_FEATURE_CBAR_RO anyway)
> >   * any possible future support for other v8 AArch32
> >     only CPUs, or for supporting "boot the CPU into
> >     AArch32 mode" on our existing cores like the A57 etc
> >
> > Make the decision of the encoding be based on whether
> > the CPU implements the ARM_FEATURE_V8 flag instead.
> >
> > This changes the behaviour only for the qemu-system-arm
> > '-cpu max'. We don't expect anybody to be relying on the
> > old behaviour because:
> >   * it's not what the real hardware Cortex-A57 does
> >     (and that's what our ID register claims we are)
>
> Not even that, because max resets MIDR.

qemu-system-aarch64 max does (in aarch64_max_tcg_initfn(),
yes; but qemu-system-arm max is set up in arm_max_initfn()
in cpu32.c, and that sets cpu->midr = 0x411fd070 (which is
the same as A57's MIDR)...

> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

thanks
-- PMM

