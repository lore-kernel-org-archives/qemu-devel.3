Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC767FD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09JT-00026K-8f; Tue, 10 Mar 2026 22:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09JE-0001lH-Pi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:30 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1w09JB-0003ww-J7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:28 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-662ac74fd85so3235595a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773196103; cv=none;
 d=google.com; s=arc-20240605;
 b=FgXRA2DEDxzWw3mPzNEQMKpHMEjCAvxYO/0UNHTAhU341xst6vpMvVqgJO9VpMhD/u
 odVgK6yOc5logrxGNmOensVHS6V48o9SXl6R46U/dunyl940cmDnxzhImjRNOlPCauR/
 ZwkgoV1dFuo4zQzTSzWdAOEYlOtfIIvlsPCCjLDnKlxzcZnvu1U4lJKJ4xquQO0wIPuk
 BNPLvfI6IVSiqfn9WOy8jqOHn0S9pKbcyfUqLKXlrvd9kez31YW6pcop2iDX+OP3MckT
 2RLdd9c9wfS8ZkgfyQpK/KUJaFa9zbTdaxHakI78Z7JPRN1kHjY81TzpFKMuHRMfcygE
 0X0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/ClLbnvdevCZpZ9ZMhhQftBL9fvC2U+VXLtSIloIljs=;
 fh=ybYiV9RTOFSKEH2bLIBq3Mn1/PZ7+JiMV8qNBkyQbaY=;
 b=UXvBYlD7L3wuyd8b3f+YXw6stlOfOOQj+CkFyoXaekXvQ1Uw5CemL/VWWolOXihGWM
 UWeYfDUXGTARM5yaKvOoMRGtFxwPeI1UE/7mjXHvXwCZWb3hcxFdYqaF8M/Yjx5MsXnm
 LU6O7ghPHKcRBIZq7jnAM9qBOj5rrR8Yz27tbCSOOyWzwA+7QR8sITC69UcXr1xXK0Wg
 0v1sB51o1l6qYFBWEVgapVu/pygroRXQTOgTzPx0AwDAC2eu5vKKoOKEwinT3Br5EQeH
 g+4RvpebnsJrN6ie2LdCL6j5BK40wZOJf61wO+pqQUITVdAEHwTIJul11IYWdKDv/npO
 eZ1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773196103; x=1773800903; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ClLbnvdevCZpZ9ZMhhQftBL9fvC2U+VXLtSIloIljs=;
 b=jWAK5442nvS3ayH5Rz8Sq57sYgFSvVz5fAsI0z6xiB9cZDdFbTDEzG+s2FhXRmslF3
 CDphcyC4KZhzv2gPmFhfNg3zru6s+tR8r/TBHOfVu5iYDJUuJyPMPpc/mwP8NqTt0p37
 7cLIDpBEkOa3f5ZFkfsqOozi4Ae5Vws8dSYo4DHGrTNE2MFYURDV14VSbyGSX1JW7rVL
 ewsl3Px5cu4aP5rIc+O0kyhxRXH5ioamcJcWPumVpAOWYHjGu/qckXJJU/QEFNZquU5V
 QEZmYKd4rrw+KTWuzCgQM+q7pHI/dct8vfVLnuTYZb0XJkcYeJgoOhUxLzMdve9a07Gw
 2xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196103; x=1773800903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ClLbnvdevCZpZ9ZMhhQftBL9fvC2U+VXLtSIloIljs=;
 b=WdT62udeuzwnXe2m3fDjgsbL55jvMoWlg2Tmwu5QsiGUQwj6vTb31CSY572sUwuUnJ
 SOwYsdH5P7ssQWo5xkV2pHheiUn0ZGCMHR5e437Ku39uEzs5n7vPUHcvdWf94x+jstvO
 KwqawP+sAdeLYefsEH0o/q2LtYajddNceuFecuCcUcTET5r8217VOfNN4PSlWLh/DFe0
 RcoTWK247/nXdBRGnZTp0kkzJRao5qF6ugHKhX/icsD9c1uSiI35cTbtPiG7zpfi/cyn
 SXejmsXFFjkQxf6uqYRbHO3aumpJWSdS/hoTcL6nMytepe1G/r5co7F8B6r9uMNjskZO
 NnLw==
X-Gm-Message-State: AOJu0Yx+l0r7QkNISit/UoMvpZCuX038CdU9teBVxY0mwqI06bMCqiQF
 8LKliPYRkmOtUl9b7H0SU3lA/am9OL/3/2Q0rSLZnqvSYOYlNJRwrCT8ZOzDpKiO22RUIjl+4Yj
 pg5KYGEL2riZEUpu/g9ZFYblD/1tApPmTPtp4IRpAdS0jl+zfKMgm51pqlQ==
X-Gm-Gg: ATEYQzyt6HYGrwXZ+SJSq6ZjZKQxg6NBfvIjkkvKbztLp5/RSej0+c913M7aEVaxV5X
 jBtMMAangvv8ImH0YntI0t1pwiaqmDZsyWiPqakip4J15GmTTbWZrMx+nvTQ2m+5bOWaPi4YW4w
 VqLqOmE+l7Oi1RtVrMGTy/exJNOXRMNHDGD81QggyGzWPg1EalRv+1SaeB0DdfANn7xHqNFwRj3
 lHUKhuZ6VJwjZ+xhlsAyCgr09amKPonMSvzX+e9G7vxeTriY2rQDGj8Ng7prgPBs8DkD+/ZYelN
 rWH5LAiwiQ==
X-Received: by 2002:a05:6402:2354:b0:65f:7f90:fb89 with SMTP id
 4fb4d7f45d1cf-66319cc2b62mr432908a12.17.1773196103153; Tue, 10 Mar 2026
 19:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251211163826.3998266-1-frank.chang@sifive.com>
 <CAE_xrPiRHMZWiSvbkBQhVV4G25ws_E3xJt5NPv=0rRv09MFdUA@mail.gmail.com>
In-Reply-To: <CAE_xrPiRHMZWiSvbkBQhVV4G25ws_E3xJt5NPv=0rRv09MFdUA@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 11 Mar 2026 10:28:12 +0800
X-Gm-Features: AaiRm53tMMwIu9OvdvnC1JCEti9rj8bAPjfwU42Nrzes9sOXNI1CTxehy9N3xq8
Message-ID: <CAE_xrPgtGnNkvUaA0E1pXc-55Oai-LyUN5kft35=wk76cjiyhw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix Zjpm implementation
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d889ab064cb66370"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000d889ab064cb66370
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

Thanks~

On Wed, Jan 28, 2026 at 4:24=E2=80=AFPM Frank Chang <frank.chang@sifive.com=
> wrote:

> Hi all,
>
> Gentle ping.
>
> Thanks,
> Frank Chang
>
> On Fri, Dec 12, 2025 at 12:38=E2=80=AFAM <frank.chang@sifive.com> wrote:
>
>> From: Frank Chang <frank.chang@sifive.com>
>>
>> The current Zjpm implementation has the following issues:
>>
>> 1. The address is shifted before obtaining the correct PMLEN value.
>> 2. riscv_pm_get_pmm() does not handle effective privilege mode correctly=
.
>> 3. mstatus.MPRV does not affect virtual-machine load/store instructions.
>> 4. Sign extension for virtual-machine load/store instructions (HLV.* and
>>    HSV.*) must be performed when vsatp.MODE !=3D Bare.
>>
>> This patchset fixes the above issues and also renames
>> riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm(), as the helper
>> is only used when checking the PMM configuration for virtual-machine
>> load/store instructions, rather than for VS/VU modes.
>>
>> Changelog:
>>
>> v3:
>>   * Move riscv_cpu_eff_priv() to the header file and declare it as a
>>     static inline function.
>>   * Fix the MXR check bugs pointed out by Radim Kr=C4=8Dm=C3=A1=C5=99.
>>
>> v2:
>>   * Check effective privilege mode in riscv_pm_get_pmm().
>>   * Fix pointer masking for virtual-machine load/store instructions
>>     (HLV.* and HSV.*).
>>   * Rename riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm().
>>
>> Frank Chang (5):
>>   target/riscv: Add a helper to return the current effective priv mode
>>   target/riscv: Fix pointer masking PMM field selection logic
>>   target/riscv: Fix pointer masking for virtual-machine load/store insns
>>   target/riscv: Rename riscv_pm_get_virt_pmm() to
>>     riscv_pm_get_vm_ldst_pmm()
>>   target/riscv: Fix pointer masking translation mode check bug
>>
>> Yong-Xuan Wang (1):
>>   target/riscv: fix address masking
>>
>>  target/riscv/cpu.h         |  41 +++++++++++++-
>>  target/riscv/cpu_helper.c  | 110 +++++++++++++++++++++++++++----------
>>  target/riscv/internals.h   |   8 +--
>>  target/riscv/tcg/tcg-cpu.c |   4 +-
>>  4 files changed, 124 insertions(+), 39 deletions(-)
>>
>> --
>> 2.43.0
>>
>>

--000000000000d889ab064cb66370
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gentle ping.<div><br></div><div>Thanks~</div></div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Wed, Jan 28, 2026 at 4:24=E2=80=AFPM Frank Chang &lt;<a href=3D=
"mailto:frank.chang@sifive.com">frank.chang@sifive.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi a=
ll,<br><br><span><span>Gentle ping</span></span>.<div><br></div><div>Thanks=
,</div><div>Frank Chang</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Dec 12, 2025 at 12:38=E2=80=AFAM &lt;=
<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sif=
ive.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" targ=
et=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
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
</blockquote></div>

--000000000000d889ab064cb66370--

