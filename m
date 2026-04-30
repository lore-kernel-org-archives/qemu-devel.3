Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993EAFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGP-00042h-UB; Thu, 30 Apr 2026 10:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIR3n-00072u-Be
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:04:07 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIR3i-0004Yk-UP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:04:07 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c24be9e4bso318146d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554242; cv=none;
 d=google.com; s=arc-20240605;
 b=i+INZ9Z2h39CdUfZ0BkTDKFcFAkRnZQ/d9WmlUS80BGcEtRaC0/zg5ROv+QQHmWUod
 vFz8BBjgfJ9G7Vj3zn5YeR9XwayXs+nOTmpQ07f/lIY/q7wG08/3aolH6+9u6CO0vpat
 rm+ZsJ8Ovz3ACfHyj0QSDNYuhHDxjWOpF/MDbLxvmXrbabjQf5iGOmVCt1gWY27T1bZN
 JO3L9qEeSY+pH4iITo5m17Jr326O3O3oWOZSMKG9IYDVfVg1se0BIIh4nK7VbnSIpq99
 6A90poijzWVCafS+x3sFCMevLPqzoHAJ/I5cLxKhA5vlju6jSjzTZq0vux+k7Wz1F+Vf
 8YpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HIxBMsJTZHKdbns51p3aoFGGmnWk2RZsQGGMX5I0d4Q=;
 fh=oiF8dhPxD6+w5M0oFKMgDkQ/sXE5JE9Y8kXtIO1nrJA=;
 b=cTkYVg0CFT+PlBcjs5/oyFqlcN84VABojC+lVlOEZPus/5bgJvvLsdrHJhbMY7rfQm
 QHeEi0vp3DKoyqIdJJZPlBv2HAvj3QU5ZaXSeiR4Z135wPxnX7t8XL6LXq7OIdAlwtPq
 uRTo/w3/1w5YxM36iz8LK+HhTW/aUDcJyV2qDfVy4n0ZzErn3OqVbw6P5w+xcnDgbbzB
 oeBNxvmIYvFito/QEZ0bP3Zm2xq/HvEFnihrsq/2CtfCUYfuQax5xKTCwZP0QQzgg8wi
 vQXL7qDaef70DKwWXQxFEGVVElfhJg2hodPUrSmb61U9wBD53y8cfIgW8LRUoQhfoDQK
 /eqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777554242; x=1778159042; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HIxBMsJTZHKdbns51p3aoFGGmnWk2RZsQGGMX5I0d4Q=;
 b=C0L6n4a7EVPY9yOitN7TC5IpR0Of2tdVXbzRNB91ChIzHd6pB2PTR9xTEFEn2e5+ji
 a55+iWMXuZVuYJBvEKrnqmQn2PvvFynkZsuXjnLO74MTlgvES/V3SxtJrl+cDZhitZed
 EN5lT8O4En5Xtr6fBsOOih2gsPlLbTCPaFqqGCXinTDnXUyDeY9K+w8+WwoV6NZdSeQt
 yLmpiAozDTiVn52rO5pnDkY/u+2LQIvKob2z5iF1oFAKWFqWAcGc1q64AeZU3dBkNDR3
 UlzwKCJcjtB7qDUo3gGguJ7PAu4Rgeznxxdb0fNe3wQWpbdxn7viGggVmtoKu8pdMZbq
 S+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777554242; x=1778159042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIxBMsJTZHKdbns51p3aoFGGmnWk2RZsQGGMX5I0d4Q=;
 b=OdNeyY6/sL6iLO0n5E/R4sjLDXP3KtwJK7qVnYv1LdeHzrc0AGo8SyA6Ip8bNbTtzC
 bxuCwrn7Ftdk2mjcri1k311xjGn4y3pvtcmNN8q7eQkNk/HnamYI9HJKBGusVFQvQ5as
 e9as9S/M4gC7TNRnXNc+GuYBUuWN4JyHFqVqtyhlKK18ToiuHrtKMMz9inZ8eHq3Ubpe
 bN1BAKDrbjDN5n20T2giNa8sLcaWxc0/ZBYH1R12Pu7VVYGjXiHBh+BNw7QZYy+9HnDa
 Z5fGUsRZHtZ+nd101RNQ9Qsu0FvAsyMHU8jcp79q08jHbDF0d/c4SxEKSvcbi7oR6414
 UaOw==
X-Gm-Message-State: AOJu0YxK1o2cdMVE+Od3byxHIS8iJYu9qNh8xExrZO6lv8V/1LmbU9OB
 zgml/xXFMUK1Jut0xIq44k+YwG2V/CzgeMXMz1vUmXMkXqS3ShRLUjTlxApn/1dkAIrF95kot3H
 gNgt8huPGuVR0xHIMtasZCz/frNI82TmWPJCgVAb2jxzn2xhKsTEy
X-Gm-Gg: AeBDiesMoRBkzhvjYqKGG49r2K621qJrC6YEDSGtcWNH1Sz1NybNYy8ZGi+rEZXoOss
 FO0cp4gz9Dnj3XRbzljFGWSFEplicdFmtc3ptEdpxp5dtIevAut+ISXNoJx3BNFgVKCwCx8x029
 thYG3srQdRqLE8fYbaDg5YyUQoICtFrj3tluFejSWOlB9He32DQzUwJSKS2y/9a+4zzf1DZNhfA
 fLy2dA/0yU19fTikt+fAmVUm3DpFT+XF4fMeHUihKh7y3c2JQD96FuT7AwAEL1dj6FN22erXE6b
 rJ9z8umypvE7b1JWlXiAU3TNvb94PXMVi1bPFS+smPTOkmjcB2eocNhAbxApt42oExr18bqzvOe
 Chg==
X-Received: by 2002:a05:690e:134f:b0:651:b728:6f49 with SMTP id
 956f58d0204a3-65c18f7f291mr2104908d50.49.1777554240781; Thu, 30 Apr 2026
 06:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260317175031.3035740-1-peter.maydell@linaro.org>
In-Reply-To: <20260317175031.3035740-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 14:03:49 +0100
X-Gm-Features: AVHnY4K6bA5gx5m7bafvG1_0CyHENpuT63A4b0weZhC0_shwJHeqtrBHAMzYDpo
Message-ID: <CAFEAcA-OS4m7ejnq_oMDcW2hJnC947yB9JFMo-nyDFW0N2uB4g@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/mips: Move non-shallow-copy fields out of env
 to fix leaks
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

Ping? Now that 11.0 is out it would be nice to get fixes
for the remaining leak sanitizer fixes in, so we can think
about getting a CI job set up to test a sanitizer build.

thanks
-- PMM

On Tue, 17 Mar 2026 at 17:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> At the moment the linux-user cpu_copy() implementation assumes that it
> can clone a CPU object for a new guest thread by first creating and
> resetting a fresh CPU object and then doing a shallow copy with
> memcpy() of the CPU's env struct.  This is obviously a very dubious
> assumption, but for the most part it works.
>
> One place where it doesn't currently work is MIPS, where we have a few
> pointer fields at the end of the CPU struct.  Currently we don't ever
> try to free the objects we point to when the CPU is destroyed, so this
> is a leak but not incorrect behaviour. However, we can't fix the leak
> by freeing memory in CPU unrealize, because then we would get a
> double-free because both old and new thread point to the same memory.
>
> In the long term we should really reimplement cpu_copy by having CPU
> objects have a method for doing this, rather than accumulating
> architecture-specific hacks. But since in practice I only see leaks in
> 'make check-tcg' for MIPS, this series takes the simpler approach of
> moving the fields of CPUMIPSState that cannot be shallow-copied and
> that are used in user-only mode out to the MIPSCPU struct.  There are
> only two to move: mvp_init and count_clock.
>
> The remaining pointer fields in CPUMIPSState are:
>  * several fields inside the !defined(CONFIG_USER_ONLY) block
>  * cpu_model, which is always equal to MIPSCPUClass::cpu_def
>    and so can be shallow-copied
>  * timer, which is only set in system-emulation and is
>    NULL in user-only mode
>
> This patchset does the two moves of fields out of the env
> struct, and adds an unrealize method where we can free the
> mvp struct that we would otherwise leak.
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   target/mips: Move 'mvp' field from CPUMIPSState to MIPSCPU
>   target/mips: Free mvp in unrealize
>   target/mips: Move count_clock to MIPSCPU struct
>
>  hw/mips/malta.c                     |  4 ++--
>  target/mips/cpu-defs.c.inc          | 10 +++++----
>  target/mips/cpu.c                   | 18 ++++++++++++---
>  target/mips/cpu.h                   |  6 +++--
>  target/mips/internal.h              |  3 ++-
>  target/mips/system/cp0_timer.c      | 12 ++++++----
>  target/mips/system/machine.c        |  2 +-
>  target/mips/tcg/system/cp0_helper.c | 35 ++++++++++++++++++-----------
>  target/mips/tcg/translate.c         |  6 +++--
>  9 files changed, 64 insertions(+), 32 deletions(-)
>
> --
> 2.43.0

