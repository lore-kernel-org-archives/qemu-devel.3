Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68425D35692
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 08:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl0qq-0007J3-KZ; Wed, 28 Jan 2026 03:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vl0qY-0007GR-Dk
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:24:20 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vl0qW-0003KP-7O
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:24:17 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8842e5a2a1so899172566b.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 00:24:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769588652; cv=none;
 d=google.com; s=arc-20240605;
 b=RZObZ5x98/tCpCWwkMqH8FtSId9XOGAKtu3FZvFs//Aq5AVCx+BlicwWuusCUKJfcW
 5L/FyarWnwJbwSn8/bMusWnhruG+5N10ASAXc01YDc1gJhJl40+ZxoYrQdJSHymIhVtJ
 SN99atmlTGzslAEm0yOhPDkN4eOeCWfwMUzeSulemcx6P+Z6E/ILJBmf/LqQ8EqBIjYp
 S15oxNWk+fyYtZgsjSxrbaEd/QRHHRNs03RANNbMKGNyFOurX0ZQ+auJE3GGxoBGUQrU
 ef56/i5/qG9YpZDGD+XtXI1s7iBCxAIHdCO2B94+AKsT/INBoOJOryO7aCN9glpIPa1C
 nr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YEusifvEML7VbMyFi1hz2njdT7n98iw1Q7iHtJbks3s=;
 fh=ybYiV9RTOFSKEH2bLIBq3Mn1/PZ7+JiMV8qNBkyQbaY=;
 b=b9Z0clDkqsew5UdnQ2EReN5jgKdP0sHOX2u7uuKKdjCHxjiST6G4554Q+/PP140zhL
 QY2Z/M2yezj4zHcY8qpr2D2xYXfdXHineg3W6Gq1z3zCClo15IeoI7rRcC92sreReIHo
 HzZyYQwOhjOACRYNd2gjhnTJ5c3ExlWSYKJ0iggOoxbQRzmoDcwNtyr/HPsxa3hDMhyK
 Mt1YAQLIo93hzx+YW3To5khDvytzuTKSnWjlnZeeupwZnZKVnFhAkB3uaFzV8FXjH0A4
 HjEVAJGivdv3/Nd50QwAWYp504ZOj6+bMRMBFWTb12BXySvw9Pvf9/sFE22t6iFUrZ0D
 1Z8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769588652; x=1770193452; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YEusifvEML7VbMyFi1hz2njdT7n98iw1Q7iHtJbks3s=;
 b=fsT9Nq0LcqnoxNYredtFWOJLM9AGf9oj5+7u7lT75a8/psCAPppOw+lMWre+RgiiPj
 iuHVedC4k871AVkY/Xb2zd3tMK8BFHr9yiUrxZ3HVOrufbRT1mR8XAcpwghYZK/xs6MW
 bnzAPGVhv9RbLRxw+6MO12WEHP8nWfKg0tXaIRurBergwXpYSORMstcRDKpt04o/luMt
 Lz4ugdu2qPlxf9K0m8/cCcaXo9EWbH9nMFhovdpQqC7RMIo+ypd0/pZSHmcmEmj19+53
 EYpXbOuuEqp3gKbX8heLHa0Cg4VxLvx95QBpJosRYB+BJJGldUhGLHFWZqGdpDHQn+2w
 BV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769588652; x=1770193452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEusifvEML7VbMyFi1hz2njdT7n98iw1Q7iHtJbks3s=;
 b=kaKFpn2+9vOj0oJMCi02Jvg2AtIT5GSeq+wYLA5H2fvYxZftPldNKmbvRaHUjuDTYX
 Dt5I++tL6hz+hsciK2/50Pb4L1oYtOZoYvobRe6J1VLAH6cv+KerCNCYKimUNdT1X9HA
 3P7rlel+vH+HI8eaHaS63uFbpDdYqt3Q15o3QFl8gGuMnAZrly1D+mT4VsnxfrwgeZ2g
 jx0iBVJyjnVvajnz9OpybF8sFX5y49NryIh7xO2VPetw/1i64UN7lgJckslWZxgUOWc1
 D6HN6CbK4966qw9BhE9Ey6lA0LL/JmJ4ndPJotVn2nvXWNovxe1VLUb/lXry88R77LDA
 e/sA==
X-Gm-Message-State: AOJu0Yz+VSPl3fXuIrE9bsQjn8A4ToueY+r2npVOeDcDGMnzF+CelcZd
 5dAUN0GhRA4XmSacOuMJg5ezDWES+2GAIIsOI7Z2xVgeKvhQmvExgucmXJir9wVRF9Yt3XEJc5d
 lbhHf70tDZdeV+kBOKtGK4ebKSWB11PJSyvSlZf75eu5fKD5Ce/FE1epeiQ==
X-Gm-Gg: AZuq6aJ51YzUI1wYnCiQ3W4zZyuoMynC3UnKtRhfKVbNs/Xqs1CSYudcU5yDEGo8b5H
 3YvPT+6cwto3CET48ByX7P55nv7/xwdQJH72YCfxa6bWpMumE8naFmqSU2sLCWgpnltZXBzs046
 S6lgzZbPoSg7m72tSk4eeYmkE0zrTroIdRlIr+z8tHglY377CFMnmYhUgbJ6KGehef6DUdz1p0F
 ImiByJHsjqWn1ImzMGDACE/CASQ8geG9CWKXICxUG+SQ1N0dySyXWsq8N8Co8gCtYZg8IIFeg==
X-Received: by 2002:a17:907:dab:b0:b83:972c:77fe with SMTP id
 a640c23a62f3a-b8dab189ec4mr296748566b.2.1769588651562; Wed, 28 Jan 2026
 00:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20251211163826.3998266-1-frank.chang@sifive.com>
In-Reply-To: <20251211163826.3998266-1-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 28 Jan 2026 16:24:00 +0800
X-Gm-Features: AZwV_QiLIQjCiiWxT6uRVr42omqQt9EFMGwcoKo8COAgvVa0GAwcGYN9ilHwLRo
Message-ID: <CAE_xrPiRHMZWiSvbkBQhVV4G25ws_E3xJt5NPv=0rRv09MFdUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix Zjpm implementation
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f9aca206496e7687"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000f9aca206496e7687
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Gentle ping.

Thanks,
Frank Chang

On Fri, Dec 12, 2025 at 12:38=E2=80=AFAM <frank.chang@sifive.com> wrote:

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

--000000000000f9aca206496e7687
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br><span class=3D"gmail-il"><span class=3D"gma=
il-il">Gentle ping</span></span>.<div><br></div><div>Thanks,</div><div>Fran=
k Chang</div></div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 12, 2025 at 12:38=E2=80=AFAM=
 &lt;<a href=3D"mailto:frank.chang@sifive.com">frank.chang@sifive.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank"=
>frank.chang@sifive.com</a>&gt;<br>
<br>
The current Zjpm implementation has the following issues:<br>
<br>
1. The address is shifted before obtaining the correct PMLEN value.<br>
2. riscv_pm_get_pmm() does not handle effective privilege mode correctly.<b=
r>
3. mstatus.MPRV does not affect virtual-machine load/store instructions.<br=
>
4. Sign extension for virtual-machine load/store instructions (HLV.* and<br=
>
=C2=A0 =C2=A0HSV.*) must be performed when vsatp.MODE !=3D Bare.<br>
<br>
This patchset fixes the above issues and also renames<br>
riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm(), as the helper<br>
is only used when checking the PMM configuration for virtual-machine<br>
load/store instructions, rather than for VS/VU modes.<br>
<br>
Changelog:<br>
<br>
v3:<br>
=C2=A0 * Move riscv_cpu_eff_priv() to the header file and declare it as a<b=
r>
=C2=A0 =C2=A0 static inline function.<br>
=C2=A0 * Fix the MXR check bugs pointed out by Radim Kr=C4=8Dm=C3=A1=C5=99.=
<br>
<br>
v2:<br>
=C2=A0 * Check effective privilege mode in riscv_pm_get_pmm().<br>
=C2=A0 * Fix pointer masking for virtual-machine load/store instructions<br=
>
=C2=A0 =C2=A0 (HLV.* and HSV.*).<br>
=C2=A0 * Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm().<br>
<br>
Frank Chang (5):<br>
=C2=A0 target/riscv: Add a helper to return the current effective priv mode=
<br>
=C2=A0 target/riscv: Fix pointer masking PMM field selection logic<br>
=C2=A0 target/riscv: Fix pointer masking for virtual-machine load/store ins=
ns<br>
=C2=A0 target/riscv: Rename riscv_pm_get_virt_pmm() to<br>
=C2=A0 =C2=A0 riscv_pm_get_vm_ldst_pmm()<br>
=C2=A0 target/riscv: Fix pointer masking translation mode check bug<br>
<br>
Yong-Xuan Wang (1):<br>
=C2=A0 target/riscv: fix address masking<br>
<br>
=C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 41 ++++++=
+++++++-<br>
=C2=A0target/riscv/cpu_helper.c=C2=A0 | 110 +++++++++++++++++++++++++++----=
------<br>
=C2=A0target/riscv/internals.h=C2=A0 =C2=A0|=C2=A0 =C2=A08 +--<br>
=C2=A0target/riscv/tcg/tcg-cpu.c |=C2=A0 =C2=A04 +-<br>
=C2=A04 files changed, 124 insertions(+), 39 deletions(-)<br>
<br>
--<br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000f9aca206496e7687--

