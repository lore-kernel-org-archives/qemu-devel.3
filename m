Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B65C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqxw-0006NV-T5; Mon, 04 Aug 2025 04:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiqxU-0006KD-LN
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:54:18 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiqxS-0004Tq-E5
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:54:16 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7180bb37846so27400347b3.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754297651; x=1754902451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aYiSARvwbxeI8mzKFcdUB6EoAHA384KmQyrfnAWRD08=;
 b=eVl5GbED2k+4NgNtbjZ2V5Anqx6GpLFjRsz9b3u2QEFOBn1SeX5JZ0cRJLaRnkHD/f
 uN6OwXtm6nVL/s1H9AR3fwTZjOOWPEzuNVJTp0BXw2hke+NyFyDjVQR0Uxhji+aHUTzW
 P4wRUeJ1hDaXaq+UPEPl8OjTDZkV7/Nm2TYLqaOSs1jTKcoJUO/xGvTNwzCHzQd5RuPX
 zU0FDnPmqmiPMGc9iBsrWz8cOnn/S1Txahmmju59F8aZO6RXFdWDXs3Cow5j946gDg5h
 vEvAlfyjv/HsulbfN76tTTRy2Bu4eiM1RwwWncW0bc2mRZPKejJp14QJt4znp5Qytjj1
 iOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754297651; x=1754902451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYiSARvwbxeI8mzKFcdUB6EoAHA384KmQyrfnAWRD08=;
 b=Wpd8hI9MHE+NWYpAdatG0mmVwaMrf/6L9RkDfJ3plQ8JwzFNOmydKruRqzyLmOcfV0
 sLNTyfXGnB02gc4wkLtR56d2FCnfAjjQgc+3OFftIySa4d4qil1d7PKTpocv88PScybq
 YWsxRkPShjx1C9oSVLwJzzXK1TycrlfPNwdXvSqLeNEbL1iw8Mygq1/xwOahzJ0TQpiW
 ptdxVpQV+g8SC31T/7i2WqzbOShQ4Zw19MwZMyNJhw13za3PLNVXsqjx6eXSCzb6s8GF
 hqbanYAamBP7qOmRO4s2mbprGQ+s7hDWD8P3CIzUvfIHidLmYOlKToJhmfb4OM8/RYoE
 vGoA==
X-Gm-Message-State: AOJu0Yzfjzd/nXZVETYTVibkoVnIFA+D3dODnnPoZbB0JiKkbz/xMhNS
 MPXBfdnScrongcet8Z8xqIw2XZyPjJMmWyC4RnleytawzWfRhvDji/X+KrcTqfjrGMNnrYLn8fc
 zEPzkyMuJHPLqIemEDkdwFX9ZxxCzqwj+hbXCehS7WA==
X-Gm-Gg: ASbGncuXQ57kTaeVays6pxHNAsc7PaRViU2/6GWIvPM77Z+N9Ciqf0Ape11fJY8sHI2
 mLx6gPPTfComCwI8Z1y/vmCEzrMNGfB83ErudwyfVssx3njPC0le+SqM0AqNWhN6ocADf2K1+Un
 7ZFNgm0pD0JOy0+N4P+TJewYRkQiwYGnlbg5Z/O3RSYrG2zqs83KD5oS47jSgkhOGi/jjywPDsa
 ZrXNJeA
X-Google-Smtp-Source: AGHT+IF1/y3dxFdvVSktidJL5l00MSBS9Z4ltknnhOYeIKZfUa8tvrDxKtmSEqvQO042bWyzj6KpDA4xlupGeHhCOrA=
X-Received: by 2002:a05:690c:660c:b0:71b:657c:5878 with SMTP id
 00721157ae682-71b7ecdaafcmr97544857b3.4.1754297651408; Mon, 04 Aug 2025
 01:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-46-richard.henderson@linaro.org>
 <CAFEAcA8RJ2NKRBL6USCL12kPY_D5C1os0-t57t6aGZHSxkOE2A@mail.gmail.com>
 <9ff0f7da-f3e2-4bb6-8b76-aba7a38dcab3@linaro.org>
In-Reply-To: <9ff0f7da-f3e2-4bb6-8b76-aba7a38dcab3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Aug 2025 09:54:00 +0100
X-Gm-Features: Ac12FXzLHnd4jvl9MCCvEi2EmxSbBU76zJ5_Monob4hzGQ78kMtTgjFDTYz7vlo
Message-ID: <CAFEAcA9rzxSzVNJ00y7JJgwoy-74yCyCo2iQBc2dAy5uQiTmbw@mail.gmail.com>
Subject: Re: [PATCH v2 45/95] linux-user: Remove target_elf_greg_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Sun, 3 Aug 2025 at 21:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/3/25 20:59, Peter Maydell wrote:
> > On Sun, 3 Aug 2025 at 00:20, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> This typedef is synonymous with target_ulong.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   linux-user/elfload.c | 29 +++++++++++++----------------
> >>   1 file changed, 13 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> >> index fce4c05674..70a1e402d3 100644
> >> --- a/linux-user/elfload.c
> >> +++ b/linux-user/elfload.c
> >> @@ -131,10 +131,8 @@ int info_is_fdpic(struct image_info *info)
> >>   #endif
> >>
> >>   #ifdef TARGET_ABI_MIPSN32
> >> -typedef abi_ullong      target_elf_greg_t;
> >>   #define tswapreg(ptr)   tswap64(ptr)
> >>   #else
> >> -typedef abi_ulong       target_elf_greg_t;
> >>   #define tswapreg(ptr)   tswapal(ptr)
> >>   #endif
> >
> > Previously we had target_elf_greg_t:
> >   * for MIPSN32: abi_ullong, which is 64 bits
>
> MIPSN32 is a mips64 target.
>
> >   * for other TARGET_ABI32: abi_ulong, which is 32 bits
> >   * for 64-bit archs: abi_ulong, which is 64 bits
> >   * for 32-bit archs: abi_ulong, which is 32 bits
> >
> > Now we have target_ulong, which is:
> >   * for 64-bit archs: 64 bits
> >   * for 32-bit archs: 32 bits
> >
> > So the two TARGET_ABI32 which weren't special cased
> > (hppa and sparc32plus) will go from a 32-bit type to a 64-bit
> > type, won't they ?
> >
> > It wouldn't surprise me if this is a bug in the hppa and
> > sparc32plus cases, but if so we should say in the commit
> > message that we're fixing it.
>
> Neither sparc nor hppa implement core dumps so far,
> so we can put off considering them.

I guess so, but if we have to undo the refactoring because
it doesn't fit those architectures that would be annoying.

I had a look at the kernel sources and I think that here
mips N32 really is an outlier --
arch/mips/include/asm/elfcore-compat.h defines the
compat_elf_gregset_t to be the same as the (64-bit)
elf_gregset_t, and has some macro magic to handle the
O32 case which does have 32-bit registers.
On the other hand arch/parisc/include/asm/compat.h and
arch/sparc/include/asm/elf_64.h both define the
compat_elf_gregset_t type as 32-bit.

So I think it would be good to have at least a sketch of
how hppa and sparc32plus would work in the new setup and
why we wouldn't need to reintroduce the target_elf_greg_t
type, before we rip it out.

thanks
-- PMM

