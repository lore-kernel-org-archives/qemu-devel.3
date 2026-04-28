Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7EEFF8867
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 03:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHZ3z-0008K7-64; Mon, 27 Apr 2026 23:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHZ3w-0008Jd-Mk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:24:40 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHZ3u-00017X-Tl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:24:40 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so14721377a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 20:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777346676; cv=none;
 d=google.com; s=arc-20240605;
 b=eZ2JlwCUlOEV5jO5aatMf3331UxHclNOOZjDfpB3o0KQXJkyAbgDwyTtU823iZYc+N
 ug1Wjb1xc/NlENuUM0csi1XUVCGiCWSuMWv63TfRABeSCteaIuSHdBP0o0etXdouH3Ux
 zqRtacNT6vxlZ5kwA3AqI4btQ2gQ98PifjxJC6AhXn0WVgZMHWiJwAtC5Lp77JQJFJO1
 W9DuiXBp56N2DWETGgPGPY0F6D3Y48POjDKjHNI9bXaQglUpKznP9oygmxASSUgHEl2N
 DjfjWMS9tJWZhViQpB4QezRqGGPyo0lzLEjzayX1249zyOfd82WZrX30m8JSfGlZ5nKX
 3v7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gZXjeZM8QkObS8dQg5unD4cq01c/8DKt4qjRD1C/jX8=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=M0uJzSXv2xwQgsMxR2JKF0AyWNXuSYQnU6+KtJHzYvTn3LRiywyJne/0vRAQIwIYYb
 Z16N0KyzX/5UEN3GZcmSfC6YTZWXh4VhsuIXp7FTKEhKJuLuaZS85XC0ABf/tCFHjyt6
 qTerqdAxlkYCRebUPhr+UcxRWHlMSekd8MXjtnRIUDET3wh0WJ2PSuAdDPbulJzE6GIl
 9hTEhvRijjnFRGZJvCGgLztChsHqZN+PRLfT54aSxZ7KxX+OwQ3HnLepIEZlx6bgdyYy
 l3uRchwrP+rTHd0nNWq/H20Ywklwv5OGxwWLMLE90xLLKgyjK5z1bDF1vXzTQ31hjoar
 d3tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777346676; x=1777951476; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZXjeZM8QkObS8dQg5unD4cq01c/8DKt4qjRD1C/jX8=;
 b=fIpJNDKeSyGOaRtVGZ9Z5UmMzLVwASPYOzq6QY/agAOJDyQovFEHY1z6bLwSQ+92K9
 Q7eQZL8nGC2fYC7cmWaw72Ag3OTL+qYSrheGozDqYUkoNtFx4bebSizN+ghwpHeSgOmZ
 JXCM3o6jWBlWOpi9ojp0uoj7wG0V9Ayhtwh/XmG/8y4dwA1XpjDnYBcpcjMKQ2H9VPee
 Hi7Xzy6SBbRW+2/TrvzgCHnL8VKsnUUkrT+NT5R2OuuT+AmXoMrDYU+d2KHVc0DQOJIT
 SJg5kN3bunLeI69QscI9tNJwhpWp2IHl1KX+g64ke06DsI5sc63UgrLZ/qO13ApfIH8Z
 0A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777346676; x=1777951476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gZXjeZM8QkObS8dQg5unD4cq01c/8DKt4qjRD1C/jX8=;
 b=nlNoqT9UOLEl9sny82cGbHnKjm1Sd4nJd+JNiV7nDbXTmvzY9kmKQXzHR1ZUIw9YeG
 WIdKtLAySbK3fV7uxqhjZaRz2i18pKuJp+JkMq9CSrl68GC4lkIlBiMLvVeyxDkNsMOH
 Kwjq2dSn+pNTLHsJT3BCm0I1LD7Qmc3TWTNwDKFeYAmhh2si2h2t6cTZLBdPTBk//Hg+
 jkTTPjQ6Zx7vgfZbBr+jvjhxlWs3bNCQS+kV3k1eqrkQ7agUZcTnHlPD5nKuW5sOyIPG
 DcFiw0cYtPz2gIhdW3mj7J9teoBADapCkV3pi2L1SbTDVsqh1Q3Yj5NdHYmLcArHcHke
 MatQ==
X-Gm-Message-State: AOJu0YwbbCbyXWBqL9WdYxmJRFzohDlSGBY6TV1CJEIbf/cm3Wzdh3cB
 rQy+at9h82h0zYfv/7A4CDgRgfWDrZsP0UWAIZtvOvrHoWCeGgArT+EsqV422K1r0wrshHxUKb8
 99DItuwzDcw6MyhSJ6n7DiD000HXPx/g=
X-Gm-Gg: AeBDiesfYOHd8Lia4XhHLy/jWQnd5kjy+xkFL1kq1RfXoW20BXcqfckeXjz0IYJIKiF
 M6PEmnvzFRF6n920sMStUMKDx/EoQM8jxFOekA1q7aX0izDmD/JQhWK4auri1INlRld7f1be4v/
 vWvLMrUWSMBNz6KErouCZIPbyqlLAv8BJZNWAfrPtmrhYMtna7UXi7lHrtjFWd98igXvx5QzikT
 sr2rZUjNs5FCGARm0ak8qwBmWaPBvhjkOPLBAKUkIj09JRAfY9PkJdyRhNeiEPWNOmf22jXUQ8O
 TIYJksbrEP2Xmp0+nbAHxNWbZXGHENTvLoODyKXDoxElHPZFGqjVZrA2c7M=
X-Received: by 2002:a17:907:d1a:b0:baa:77ac:97a with SMTP id
 a640c23a62f3a-bb803e5c20dmr69487866b.36.1777346676028; Mon, 27 Apr 2026
 20:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260421093715.2995067-1-frank.chang@sifive.com>
In-Reply-To: <20260421093715.2995067-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 13:24:08 +1000
X-Gm-Features: AVHnY4JM-7rcS1mqEgKim4DLlpejDdYg_Tlif2I7-4WDcdFPodPQuDW1wbxv3GQ
Message-ID: <CAKmqyKMORwc_CRbC2pxGNeaw-4p=cdLBjW+HQsvcbAfxTCFMvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Fix Zjpm implementation
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Tue, Apr 21, 2026 at 7:38=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> The current Zjpm implementation has the following issues:
>
> 1. The address is shifted before obtaining the correct PMLEN value.
> 2. riscv_pm_get_pmm() does not handle effective privilege mode correctly.
> 3. mstatus.MPRV does not affect virtual-machine load/store instructions.
> 4. Sign extension for virtual-machine load/store instructions (HLV.* and
>    HSV.*) must be performed when vsatp.MODE !=3D Bare.
>
> This patchset fixes the above issues and also renames
> riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm(), as the helper
> is only used when checking the PMM configuration for virtual-machine
> load/store instructions, rather than for VS/VU modes.
>
> Changelog:
>
> v4:
>   * Rebase to the latest to-apply.next branch.
>
> v3:
>   * Move riscv_cpu_eff_priv() to the header file and declare it as a
>     static inline function.
>   * Fix the MXR check bugs pointed out by Radim Kr=C4=8Dm=C3=A1=C5=99.
>
> v2:
>   * Check effective privilege mode in riscv_pm_get_pmm().
>   * Fix pointer masking for virtual-machine load/store instructions
>     (HLV.* and HSV.*).
>   * Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm().
>
> Frank Chang (5):
>   target/riscv: Add a helper to return the current effective priv mode
>   target/riscv: Fix pointer masking PMM field selection logic
>   target/riscv: Fix pointer masking for virtual-machine load/store insns
>   target/riscv: Rename riscv_pm_get_virt_pmm() to
>     riscv_pm_get_vm_ldst_pmm()
>   target/riscv: Fix pointer masking translation mode check bug

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> Yong-Xuan Wang (1):
>   target/riscv: fix address masking
>
>  target/riscv/cpu.h         |  41 +++++++++++++-
>  target/riscv/cpu_helper.c  | 110 +++++++++++++++++++++++++++----------
>  target/riscv/internals.h   |   8 +--
>  target/riscv/tcg/tcg-cpu.c |   4 +-
>  4 files changed, 124 insertions(+), 39 deletions(-)
>
> --
> 2.43.0
>
>

