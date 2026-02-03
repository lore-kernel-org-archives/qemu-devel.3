Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB53E87829
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGiQ-0007Vy-R7; Tue, 03 Feb 2026 08:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vnGiP-0007Vq-3J
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:45:13 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vnGiN-0004mw-Dz
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:45:12 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b885a18f620so852016166b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 05:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770126309; cv=none;
 d=google.com; s=arc-20240605;
 b=CS3vSN8kGIYM2x0izRHcnsh4s8kkaQtirEBvOfMxGMRLaSdkj1T/LXZjkIvyf1u0T0
 DvL4ELxYChSnnZFlD2emtQeYmtUxCvj8kxuYTB8oDSWcu8IcLdx5xRgC3yKqEhFncWhS
 JoWiuP4fETLiuytbmAn+0I4xR+3bbevfVZCOK5pGCGEJfS4Obu5ejoL58Zcydz0C9wZJ
 qLgwcGOqbyZyu4Bd0k22vfCO55DFSinkjQwxR+YUjEwNqahdukmyLBAQHOrweyE2zKWV
 NGaF0Q0ONU4Qj5D3LPXujQ5nN/zwLFB3c8mgwRuLdmK2HIm6O8FXKoU7pJq6fBrExszZ
 1e/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NjhahGtoSU0t1385+BYXmLv3Z0dInWywLmP/GpMdDqg=;
 fh=SUCZYrR0B6P8+VX8C/cKaexmJNENWp+kh6/4p9HdGuQ=;
 b=FzcPT5zcs9GTwkxII+lX5TEx2+a/NZ1qKqeml4ke3uXlBkxsalE7TZPFSC9Hkag23C
 hAG8dwhdArhyqhjEJ4AVb7tZIBkDdz659uYfi39wE5ihnDZevziYBok8J/dq033VpDD+
 u39JQ1gI448O3O8DUPt68EODEX42RHMOVqAcJvlptljpsvW58+rQ0PFKS77C5DhYC9wb
 nKfthlPPiwDU7YrtKqT5orJIDX4iO3keIExXUY0u4js/4fIrS/lgow213akIq/MUssW6
 zQZGcM8y0WaTRnwelgMNr44/5T/XcopHn68fb0yM86jKWSOyo9Hu+L2W76LEF0M2hHm9
 vkFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770126309; x=1770731109; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjhahGtoSU0t1385+BYXmLv3Z0dInWywLmP/GpMdDqg=;
 b=Nt3nefrTD0smkAj2DV/deBIyMCLSeyA2+A/GEf+PvhfzKcXsRj9sT4x5V0IZs+sHDh
 e6hYbPtdsFnPgpO4ZtNQ4a7snfCqmITAJFzk0zv2X/dAZVsFcQWZVqq8NKxocDIH673T
 gLUtEQPYh0B7CKQ9srXlNznY+4gjRmHitEuvReh5r3tW2mKw5/EyqTWnjM6nlpyeond7
 AcCxoTka/A0BZXaIHEdKefNuWkP9E1HWJri/Z/VInOMVr8hoAJH6y7wVaD9+J+Kx1DGR
 EWkLnJ3Ep9IgWQYDo+rq0G+UqVeZ/UediF1O/DcfkooNyz87AP3R5BJbgYIsnnuBU6me
 xwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770126309; x=1770731109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NjhahGtoSU0t1385+BYXmLv3Z0dInWywLmP/GpMdDqg=;
 b=KyVdvyql8cIx4qv5a3ftK1hz25HTzXjirWqTMOtk1EQV1VoJfjXO+JkSJfccTnihcW
 A9CUUEiuR/YLcv/E1Y088Nam4dedkzwjXh6u4tObUpbDKY+OcH6r/3NRT5ZQrPwqkYZ7
 thh4sD023UYQgGGXtGNNxFwhkhuBlWLpSQvxDsd2s5+K2qVOVeF49zfHc3joMf6Zybdw
 X1/oA8fbMg7zYuFnPiheEwQ4yQ6AdV2tWOvz1m2/kwpnk8YPnaL0VoLfwrEqaaYP0vq9
 zfsJ43RAcLhZgr/5RUcM8J7LU/0Bj3MAlBgy2Kmp0NB1jalW9fBq90DOQ2xHpzBrJj8T
 5ycw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjT3rRWPlf9C9WkTR1EjVSTKIjBfd5Khv++NnWZYk9tNJnTfDKPccl+5SRaqVkTIOvE2u61cL4TvcE@nongnu.org
X-Gm-Message-State: AOJu0YyrvJlly5rjpUCmK0+Cfho5be65HqyegrNhPhilhVOiW7d9c6Mq
 WZkK52OvIy+hY25SSh45E2Vgyxi6aan5aLKT29e8XrAbb9UXfKSv3RUpa6hPJTSlZ3/yeNsIRCU
 DJP73NTZsihm/CW8QddhDbAstt8ADcNfzOBjPujFUrQ==
X-Gm-Gg: AZuq6aKnIbxzZdeqEekf+2yILBXZlQU56dfjUEMFpFzSmyB+qnxLloEJpbRUuiFZQYj
 /n07uITYgD/mx0qwnTwepfIFAr6SM/8ldFdEd5TuGfsjTvavAeJtqsmOIk2NgArw+LLIMm/ltpL
 jwf1VShhIozWXilCdEr2TXPEUxB17oplPjqFaWsOzVlSfvALJeeQ5/SYoQO4i6MnCo6Cl7v3Lgt
 UIP6DcO+CHbCc9RORg8+yyA7/N0iP7qXYaO0Q1QAn0I/CyZ3mJDpjkvHq9NIIWR7qzwZmbrBQ==
X-Received: by 2002:a17:907:1c1e:b0:b88:68ca:50d5 with SMTP id
 a640c23a62f3a-b8dff74a328mr961249066b.47.1770126309291; Tue, 03 Feb 2026
 05:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-2-jim.shu@sifive.com>
 <7b65cfff-3255-4fc7-b151-80ab284dbc1e@linaro.org>
 <28846f01-a97e-4034-8f56-7bef90417f69@linaro.org>
In-Reply-To: <28846f01-a97e-4034-8f56-7bef90417f69@linaro.org>
From: Jim Shu <jim.shu@sifive.com>
Date: Tue, 3 Feb 2026 21:44:55 +0800
X-Gm-Features: AZwV_QgLJoNwOTWAWdFK4kXumsE0-7bXVbT2gpTg0JqEtp5G0_iq03OybL_rNws
Message-ID: <CALw707q9aDMR0R7wtBoBzT1FOOgMtrVsqN1FcooA_OjJHkEeKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] accel/tcg: Send the CPUTLBEntryFull struct into
 io_prepare()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x630.google.com
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

Sorry for the late reply.
Yes, I can send a cleanup patch soon to fix the issue Richard mentioned, th=
anks!

Thanks,
Jim


On Tue, Feb 3, 2026 at 6:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 3/2/26 02:15, Richard Henderson wrote:
> > On 1/29/26 01:23, Jim Shu wrote:
> >> To let io_prepare() function use the multiple members in
> >> CPUTLBEntryFull struct, send the full struct instead of 'xlat_section'
> >> member as the argument.
> >>
> >> It is the preliminary patch of next commit.
> >>
> >> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> >> ---
> >>   accel/tcg/cputlb.c | 14 +++++++-------
> >>   1 file changed, 7 insertions(+), 7 deletions(-)
>
>
> >>   static MemoryRegionSection *
> >> -io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
> >> +io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
> >>              MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
> >>   {
> >>       MemoryRegionSection *section;
> >>       hwaddr mr_offset;
> >> -    section =3D iotlb_to_section(cpu, xlat, attrs);
> >> -    mr_offset =3D (xlat & TARGET_PAGE_MASK) + addr;
> >> +    section =3D iotlb_to_section(cpu, full->xlat_section, attrs);
> >> +    mr_offset =3D (full->xlat_section & TARGET_PAGE_MASK) + addr;
> >
> > attrs is also present in CPUTLBEntryFull; you can also drop that parame=
ter.
>
> Jim, now that this patch got merged (commit 94c6e9cf044), do you mind
> sending a cleanup patch?
>
> Thanks,
>
> Phil.

