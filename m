Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE0FC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetpp-0000Vd-3f; Thu, 24 Jul 2025 07:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetpn-0000U8-Sm
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:09:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetpl-0002fp-Vu
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:09:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so1840741a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753355396; x=1753960196; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYo20Tk8JyK/5MxajFweWqExB+J48PSPfqMK9NFpEtI=;
 b=Oa+DV2gvV1dAmXnKDysCNIUpZcLoFe6sE5rlQhXrYCJx5LUiX3CH5z4n3FV6Gl8zbi
 fwBunurzW/TysLtY7GLbs+3Kg2l0Qlnry5y2aOu2ZOXurZcs30SSx1fCM+aT/sqPMFG9
 wkaR3Hec2YAkuIwngHmAqiwRamhK3NzSjnKFPU8V6atDmKFffPxERMhluLmr7lyDfJA2
 aSX+gTGRnJoQVyv9P8dhlVOIbwIvbZ7IkR7HXmrnCOMg9l21gE0aDHWdonRjEO24En0p
 oV1+gmAyxgqJLJhBlNVpXS29OAgd3BHPbvOtrMdYL9FInTgavqIVZjwZBbL3yeLDjKNr
 VeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355396; x=1753960196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYo20Tk8JyK/5MxajFweWqExB+J48PSPfqMK9NFpEtI=;
 b=slb0xVk721pb4qXnDN56f6uhGYkRccMXMAH7hh+6tXRSNMx/d8+6DZbnEdLiL17xSp
 38bnEV/Pan0uwDmUenJOzbQpPGPgRnnV0wlBSBvMoodS/Q2W+g+BWH1Rede6YJhEae8H
 3B2aEaQJwEGTbuKDUpIhyapWQmu5F74/zJYRe8Z2rHkIE/O2QL+MhPv/fmd1nF8V0QkA
 4Dst2DZL9IurNccP9qCsoq5i7yBg4qjmgPxhCGqM/e71mTT5OEdGJfNf1NYgzL3VHkpB
 1IOtAkVMqUYbOsS8rN8hx6MD3aVbMXyOpUzWQFbZWn0lWmHd7uAEr7uAe66Y3cs6IyWK
 jv2g==
X-Gm-Message-State: AOJu0Yya7D/f1Q35dU17LZKiLizuD6+5tItY0/B79Z/xRZDWD9qxR8Zr
 mLyLuhfnMP8GJKqumIUmk1nEE8w04m7pudFbQwdP/Kx570HsSZbXYn6arozCYiMYRxRaSFxl3Z2
 7UTH+aCzbgKml7m0LvvWH7cKtT+n1fHI6XCkmrTS4XnYf+eSNAsN+v34=
X-Gm-Gg: ASbGncviDoja6G98gq+2gHt9kLxjWN6ZTorreoLw9Fzv/WyLxyYqj947EH9B6D7RZTf
 1lQYgiiPngKGvG0l3QaYiKSQGdytB99+rh9/CgRAuKqa7p6Z5RtkhDNYJxCzdaluUKh4TV085vP
 8mtIJCFqkLV2c2luwWgM3YooyssZLhHjJvC6OHsL9HxpqRo11CJp9i5i+K+19ytk2+SliHTMnHS
 NvH2itLumpaKMDJ
X-Google-Smtp-Source: AGHT+IHGYb3/1myDgt879iBPQR1YsNJGXi4wai0dO3NzH2xJiFIH/CsGv7r0oDHSYBTXfjHi+yedZngl9UKGnRwpHbY=
X-Received: by 2002:a05:6402:440b:b0:5e6:e842:f9d2 with SMTP id
 4fb4d7f45d1cf-6149b5ad6efmr5677272a12.29.1753355395657; Thu, 24 Jul 2025
 04:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-4-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-4-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:09:29 +0300
X-Gm-Features: Ac12FXy8k_6M0kesizKLgg4ckQICYoF_nL7aCq2UunC9HW3K4oCs5fJ4A-LZVjM
Message-ID: <CAAjaMXYMgX_bZMPUusjBrdot-bsGWWAgkjX42AyzBiGKZtCfWw@mail.gmail.com>
Subject: Re: [PATCH for 10.1 03/13] docs/user: clean up headings
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, Jul 24, 2025 at 2:02=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> This was a slightly duff format for rst, make it use proper headings.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/user/main.rst | 50 ++++++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/docs/user/main.rst b/docs/user/main.rst
> index 9a1c60448c5..b8ff203c212 100644
> --- a/docs/user/main.rst
> +++ b/docs/user/main.rst
> @@ -17,28 +17,34 @@ Features
>
>  QEMU user space emulation has the following notable features:
>
> -**System call translation:**
> -   QEMU includes a generic system call translator. This means that the
> -   parameters of the system calls can be converted to fix endianness and
> -   32/64-bit mismatches between hosts and targets. IOCTLs can be
> -   converted too.
> -
> -**POSIX signal handling:**
> -   QEMU can redirect to the running program all signals coming from the
> -   host (such as ``SIGALRM``), as well as synthesize signals from
> -   virtual CPU exceptions (for example ``SIGFPE`` when the program
> -   executes a division by zero).
> -
> -   QEMU relies on the host kernel to emulate most signal system calls,
> -   for example to emulate the signal mask. On Linux, QEMU supports both
> -   normal and real-time signals.
> -
> -**Threading:**
> -   On Linux, QEMU can emulate the ``clone`` syscall and create a real
> -   host thread (with a separate virtual CPU) for each emulated thread.
> -   Note that not all targets currently emulate atomic operations
> -   correctly. x86 and Arm use a global lock in order to preserve their
> -   semantics.
> +System call translation
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +QEMU includes a generic system call translator. This means that the
> +parameters of the system calls can be converted to fix endianness
> +and 32/64-bit mismatches between hosts and targets. IOCTLs can be
> +converted too.
> +
> +POSIX signal handling
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +QEMU can redirect to the running program all signals coming from the
> +host (such as ``SIGALRM``), as well as synthesize signals from
> +virtual CPU exceptions (for example ``SIGFPE`` when the program
> +executes a division by zero).
> +
> +QEMU relies on the host kernel to emulate most signal system calls,
> +for example to emulate the signal mask. On Linux, QEMU supports both
> +normal and real-time signals.
> +
> +Threading
> +~~~~~~~~~
> +
> +On Linux, QEMU can emulate the ``clone`` syscall and create a real
> +host thread (with a separate virtual CPU) for each emulated thread.
> +Note that not all targets currently emulate atomic operations
> +correctly. x86 and Arm use a global lock in order to preserve their
> +semantics.
>
>  QEMU was conceived so that ultimately it can emulate itself. Although it
>  is not very useful, it is an important test to show the power of the
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

