Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCC7C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x41uz-0006XX-Id; Tue, 08 Sep 2026 15:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x41uw-0006XL-TO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:55:43 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x41uu-000802-NL
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:55:42 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66c7e3a2332so3879378d50.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 12:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788897339; cv=none;
 d=google.com; s=arc-20260327;
 b=Mi0Fz2iuRUmWnLBb+9fXnUnYnxx3oLx8GOe9UXcEKhVoL5iXhYzM648vLF/3QPLYlO
 VzSalLn+6CjO2yZqfyy/4d81cPU7wonLaZrMIRFICNiSsLsfOt5cxJtbGTeU/+9ZbCe4
 eFAzSiqnBiWlVarihGRwwAqDi1UpBzZ2ECxhoWRzkI4621r37pR2sXVGYcTCFUk9RA3+
 XHB+ArLbK2/eKb2wUpHLOdf97CAM0CmujG8/iECd7y+uXBwPsm4mOY+G5A+2GoRhl+Zq
 EinLaPrOwdEC1Pcu8oRS5oopwhPnURRNHP+dhPFj+iXM4b6RMuhm5XwKkhmQ1/OsyUXy
 cd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zxXNqQ6JArRlgS/bfleXExFjFo1OX42fR2DxUDeDpgE=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=CpEScAPCj0S9f7G6VRWzgfa1qVHhQH3Hcho9xynQ8k+/zI3SNdsC8+999LTt87Nfcv
 V+Hb3OLZjb+pgbbSYnlj1RrTADMW81Y3d5+NcZQo8LmziHw6sMfXnIXZc09wc2Cm7LVp
 MmdZrFrkLzr87VdCAFJAA9R7VHveNsva5p9bW1K4bXkEw73fAIifnQtpixDnkcKqdYyZ
 fx0zgmvNWKkrO2uxbJ4hDI8dtKHDx1s3aamybJMRC4Fdse0XCRc+ItpnBYIm9C79u8Ex
 exBlZyTPcLCOBR2QfLrNwzzQyxwe71rdlRKo/CPpvyCIs40NI9dylKPYHWTCdQhiIphZ
 7qrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788897339; x=1789502139; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zxXNqQ6JArRlgS/bfleXExFjFo1OX42fR2DxUDeDpgE=;
 b=JnEupO/Xl24/BK5E/MjfjEwQAZGJrUL+loL0oBn2xsu3HYNaGTjE7sflucJR6fKv+V
 HxjCqI1a4Xr7EqViZ7mNpOhkKfBM3WvWemxZaIDXblPgxCD9FiCKeelpfgdeur6BB50P
 GXeCOWhLdrHsNi8YwR48ZDDsFK9lVCnIfWAaH0RdhOYl/N7zJCJGLHT2FX3EfCBWmtlp
 1Hh09jY6Zj0TPtRMmrFoKqP+TSuy6AE7sITus+iXtEv475d+mFK4MYeUeT+l0lR/QVKf
 fMFXUge/+7QygjF2UoPVG434U1qH85DgVhxWj1+0wBQAroHRA9rDT+RuZoFIfmuSLdXg
 5oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788897339; x=1789502139;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zxXNqQ6JArRlgS/bfleXExFjFo1OX42fR2DxUDeDpgE=;
 b=SlGiEpO9t68WJqvmg74BuuISAGryl1BPqsYjGAs0JBSmEn+ymlmRIUDKGYF9qrQh4r
 0U8ZvfVQM0UJKcy8JlkgJY+AR1bcOlAFLAlTllMFgqI2rAMMz75i9oRQS9JZGiHotwp6
 J0OqFADFRwDAm9WrTCaxUYw8uXI1Q2TF3esQbzMsdI8S3IHCgzzxd0O/rmC1tjQtI0wJ
 QelXVjrPVbQriEgPZdZFAIXoVk1Hqwyz7oX6YfqxXcSYxcjag4fCjdVjLH7SlhrBf0of
 oGLZsoWa1M2fDzDvx268QPTyBBmKUtE+sFLBNm/6fhqKYVW8EmAWwJYiQpr5JWqgd9Es
 1qMg==
X-Gm-Message-State: AFuF++koB9q92fbeSf/wZb8bqWpRgptnIpaL2mPzB5lwAENcrR7dTrRU
 4cPgy8IU7brZQ3+bdsIfCCkXpHqOT7AvAChoVnaiyzuCtovL0lckgQiKtGftlTLdUAnXGJ+Oou+
 zv2Upabb3DraPXTHtpnyz1iru1fCaAJR7o7pNSJKiZA==
X-Gm-Gg: AYBFou0j4HMYDENrHUNKrEzUhzCupEjmlf9BL6KQ19gYD2dIJh7pJji/tOeh+zUSiFt
 mW4n07xw2Y8NBq3E8t/1KoeJVi7/C9s0IvOVKOOjg4XuQoKPati5u9vdTJ7MF7fFrL0Gy8Iopki
 UVLUdhfsvsWzb/9sDPXfVFxQnyLiwBDqbiXsE4/7aIUO6/T/1IrBK0cKxGZbUPre4tuHaRCK4qM
 WX/OapYtxYOETlY0hbd84Z29nW+4kVGUPe9d4v7aSweNr3/UrBr6a5Kb2bkcEhEssonGwIcghIE
 VAKuY60H4p8P3PZHw0lraohsAHtnu0r29I8WJghFbxjhY633FQIwOBjUCvETMRkrZ6NuYFyjUIM
 qNIE9cQcBOxex35/2mFuOc6i24N0I
X-Received: by 2002:a05:690c:e3e3:b0:866:4769:d60d with SMTP id
 00721157ae682-8712a9f58bemr116318927b3.22.1788897338927; Tue, 08 Sep 2026
 12:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
 <20260906222551.3712954-2-brian.cain@oss.qualcomm.com>
 <CAFEAcA92z5Hqn=Rb8dH+e8-G_WUSnhruYooq_fDzEC_VYiithA@mail.gmail.com>
 <e1825e93-6dd9-4c0b-83c5-e87059f49297@oss.qualcomm.com>
In-Reply-To: <e1825e93-6dd9-4c0b-83c5-e87059f49297@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 20:55:26 +0100
X-Gm-Features: AcwNN1Vm0xNWhBoZFlANkM-svoeNqSj5lvW6s9C3DC0z-r2iYgBXM6B0L3YjBHY
Message-ID: <CAFEAcA-93c+AFUAGrRNhi+XSE3ATsGoSO_hdmUfD1fhEdo+Gig@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/hexagon: Fix semihosting OPEN filename handling
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 8 Sept 2026 at 20:09, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
>
> On 9/8/2026 12:40 PM, Peter Maydell wrote:
> > On Sun, 6 Sept 2026 at 23:25, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
> >> HEX_SYS_OPEN copied guest bytes into a fixed-size buffer until it found a NUL.
> >> A missing terminator could overrun that buffer, so use lock_user_string() instead.
> > Do you have a link to the specification for these hexagon semihosting
> > calls? Looking at this patch I'm wondering if maybe I steered you
> > a bit wrong with suggesting lock_user_string():
>
>
> Here's the link -
> https://docs.qualcomm.com/doc/80-N2040-101/topic/semihosting-specification.html

Thanks. It looks like it's rather inconsistent about how to
pass filename strings, so for instance:
 * SYS_OPEN requires that the string is NUL terminated and also
   that the caller passes its length
 * SYS_REMOVE requires string + length but doesn't say it has to
   be NUL terminated
 * SYS_ACCESS requires a NUL terminated string and the caller does
   not pass the length

Where the ABI gives us a length I guess we might as well use it
plus lock_user() (that's more efficient as we don't need to do
the "scan to find the NUL byte" part first).

Patches 2 and 3 in this series are probably OK as those calls
don't give us a length. I'll review those later, hopefully.

-- PMM

