Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A74DCD6E4C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 23:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSkCF-00042F-J2; Thu, 28 May 2026 19:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wSkCA-00041i-TL
 for qemu-devel@nongnu.org; Thu, 28 May 2026 19:31:22 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wSkBo-00076f-55
 for qemu-devel@nongnu.org; Thu, 28 May 2026 19:31:22 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5aa4b131940so2667570e87.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 16:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780010821; cv=none;
 d=google.com; s=arc-20240605;
 b=ZUYxMdoza9PFPFW06hCiZ5ftP35Qtc5EX/zXyhX70mlF/Wpr8WIumaZkkRD2bdMa3T
 Ee5+EW/NuHqcCx0Uwrn6umt8wv564xfoCgQv4seBzE7wfNCnWcFLEXIH7mdaGYyxuAPa
 GcxtbPNohV68HPtr3r5kcMQTNX/osLqjuujLo2vzzNIP2q823MSHwNTiDFIgSDH4EQXa
 M/rDWQ0p2s9TWJLfcotXdfeo8V3xvdCiciM7RAmK90JG2BYjBxiW8slkc21XwM7QuCph
 nsYBLT/FvX8es/GsgkJBjS9c2Co53gbyV8jR2AbbLDZ3X8LLDNNhIrXc4G8OWn7VwBgh
 lgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=plpsoRt2exjMbwmGXjSp6aTajnbvdj2DAeWS7lfCGGU=;
 fh=j8pax7V+CraaRTWYClyarRdqomUw72bOD0sU3w6uFtE=;
 b=J2NWNZB8EpYnKdeeWkKdIX3ZRuC4bUqLmhhKbgu7WRTpM5WIArx+O2ZZBEAzHAPVOZ
 FscoiN6JlW3JkNVHb09OFIuuH+jrDxasrBRhyaW5Y/d0NGS/j5XiwBdAQ8is35QGNbqO
 +O3pHp9PHpYtGk0Sbez14linIjlc+cyqZ49Xqd273AFZpvAW3V/Ei8ETtptQGkEsNXFo
 cSLzorfcAUDa2ghh3uWUSYBZqWopljV/IRSykG1EJP6S5oPtSBuUMQeOYSu96F0/VZSs
 l3RpIRc9fZbtgcu/51ixkxndv3zIoJ/T7Is7/wuicAimq0oqlqnJA58cK8kBavLrFLOt
 eirQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780010821; x=1780615621; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plpsoRt2exjMbwmGXjSp6aTajnbvdj2DAeWS7lfCGGU=;
 b=FILsVHL/2TLZQAtGQZclB+VtdJiYT+Mt1Ps/GtBxjyhiNsp4N00ch1yxV8xd69EoDY
 lbjIa04jKiTvKd02/sn8P9da0F114ziJfMVTKZbILWNCd2gcTSCkUA8IX62gV7SndHTO
 nYu12Kz0BMN+6a5BEzftq3z7RVCWwvf4tTP+S1zteEE88uxk6AuOO1481q4BpK9P02mE
 G1mj48kraG6OodFCDv96plwdoOvnIP2Nb7UJlqQqv8KIEMItjEUf9Z9Ri2mmII2lPV4l
 Wk3dgPnVwBCVcaSBB7OS49CKJbUlExmv3WyNoUC/pc4cecmt4nEyEWPoS4PI60LarrPn
 mZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780010821; x=1780615621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plpsoRt2exjMbwmGXjSp6aTajnbvdj2DAeWS7lfCGGU=;
 b=V98Jn2fp5QRdHSBbtY580/p0mX42CQVEEizWqKNhIc2P8g+ILQulNZhLcGTv6saLVU
 F+WvCc4L/2Yn3L3xmTR7gcbXaLGGmHpqU8sbK6PsQjG/iaBg1vF6SbNS80dGFN/wxjoA
 tpCy5OI78HXTJn+HBH+OI74Xr1CYo2NgBR1V6MaUqQY22q9+cLa0EMS2RWPK8+omUtfn
 IScVK//oqNMzxEKjZvATJUMQeG0dw64PCHA3j+i2rG7qMdcktCmog8TgDYoj1mI6Eupd
 /z7VzTmoZFtlHntygcTHe4IOC6H/HLWWMYlwZjtPH4W06NoPnB8nIubS7lVevQPS3jFu
 FNiw==
X-Gm-Message-State: AOJu0YxYk47GR+gKGscvhm7j45jzk09T/tRgrbpWZM2oDfPKxQy6kDwW
 NRYqbKjLOjGg0Q85NHgNTe7FO11gE3Ms2zyPGTQMQWUpquKPElXTmlZtyefGc838jqVl18HTMPM
 su9qC4OIUKgol9SMwhf2DKh7qG6+WnFo=
X-Gm-Gg: Acq92OG8Iy/aCUm7j6F/s1u/01QXgg4PpvgckEWMPMi6s43T7EDADchZ3ZAWzBHX5sY
 i557Y+5RRZf5EX9nsulN2SvEeTCvTFSDaSiCjX4BijdnpQsyXnPm/wCemDETejgtsK9T0z7fPLr
 VsNURR++Xuooi2eEVmxY+bytxOxBcXo1sySiXeP6Wbk0hbddxvoAelXFEvG1m56rsSdNGu4Pzjx
 6iipLKrnT2GC6ryfdgq3BvMhnsliZJeqMHOq/Tp8U+LYeihMln3A5T45FF5pmM/0tMO0XVy/jX+
 J1yYa4szQQ64jh1uViFK
X-Received: by 2002:a05:6512:3e12:b0:5a4:6f5:6c2d with SMTP id
 2adb3069b0e04-5aa5949b53emr52672e87.31.1780010821193; Thu, 28 May 2026
 16:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260521184119.1631958-1-mattst88@gmail.com>
 <d5cad829-a61c-45fe-85b7-0a310cb882cd@tls.msk.ru>
In-Reply-To: <d5cad829-a61c-45fe-85b7-0a310cb882cd@tls.msk.ru>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 28 May 2026 19:26:48 -0400
X-Gm-Features: AVHnY4JQ9Whb8IXnv1_DKx9rDjAz-2e7A4HjnlPQMn9tBlh9AL8LPl5wdpfobgw
Message-ID: <CAEdQ38EuNCBnjYg0oednDTrJC_aN-pzWZawyG7AGqiwcfj534w@mail.gmail.com>
Subject: Re: [PATCH 1/3] linux-user/mips64: fix elf_core_copy_regs register
 layout in core files
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, May 27, 2026 at 7:06=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 21.05.2026 21:41, Matt Turner wrote:
> > mips64/elfload.c uses #include "../mips/elfload.c" to share code. When
> > the compiler processes mips/elfload.c the quoted #include "target_elf.h=
"
> > resolves relative to the including file's directory, so it picks up
> > mips/target_elf.h instead of mips64/target_elf.h.  mips/target_elf.h
> > pulls in mips/target_ptrace.h, whose target_pt_regs has a pad0[6] field
> > before regs[].  As a result elf_core_copy_regs writes:
> >
> >    r->pt.regs[i]   -> reserved[6+i]   (shifted by 6 from the correct in=
dex)
> >    r->pt.cp0_epc   -> reserved[40]    (correct mips64 N64 index is 34)
> >
> > The Linux kernel and glibc both use the mips64 N64 layout (no pad0): EP=
C
> > at reserved[34].  Debuggers and libunwind reading the core with N64
> > constants therefore see a completely wrong register set =E2=80=94 EPC p=
oints to
> > GP, RA holds the branch target instead of the link address, etc.
> >
> > Fix by:
> >   - Guarding the mips32 elf_core_copy_regs in mips/elfload.c with #ifnd=
ef
> >     TARGET_MIPS64 so it is not compiled for mips64/mipsn32 targets.
> >   - Providing a mips64-specific elf_core_copy_regs in mips64/elfload.c
> >     that writes directly to r->reserved[i] with the correct N64 indices=
,
> >     bypassing the struct field names that are tainted by the wrong head=
er
> >     include.
> >
> > The mipsn32 (TARGET_ABI_MIPSN32) and mips64el targets are covered by th=
e
> > same mips64/elfload.c and benefit from the same fix.
>
> This code was different before the linux/elfload.c split into targets -
> before the split, all this was in single linux/elfload.c file.  While
> this patch should not be needed before the split (eg. for stable-10.0
> branch), the following patch is apparently needed still.
>
> Can you verify please, and maybe provide a similar fix for 10.0.x too -
> provided it's actually needed there?

I just took a look at this.

10.2 & 11.0: clean cherry-picks.

10.0 & 10.1: not affected by any of the issues fixed in this series.
Looks like all the issues were introduced by commit a8081da18d
("linux-user: Move elf_core_copy_regs to mips/elfload.c"). If I'd
realized that beforehand I would have inserted a Fixes: tag and saved
you the email :)

Thanks,
Matt

