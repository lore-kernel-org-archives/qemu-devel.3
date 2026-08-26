Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4368C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGVC-00012W-NU; Wed, 26 Aug 2026 12:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wzGVB-00012H-N4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:29:25 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wzGV9-00031x-Eu
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:29:25 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66c82b32121so1938900d50.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787761762; cv=none;
 d=google.com; s=arc-20260327;
 b=QVGGergd1G+pG3YVvOf1q99oyiOHtkyruo+KS4ZLgaK1UTShYxxGqhYBzTjipxtxyq
 SDoXP1gP60DpSv2vuudqXzKL0ZqM8mSbowTV7ZUSbmjbbAzM+mgpOMPy+wwAqYUFGg5u
 clFw8gDfYIFHmT03iTE9OZQNpKMgo6JuxCTIF514I1TrvzQSWyk06JHtQCnS/aIJZfSk
 Ddr6bzjp71ynQWF+5dgCWl3viaEt5uPmoH6ANwJHqOi5wjRBjISh3nBzbgfM1EI2Bdil
 VWAEYm852UlcpZMC+l/xRgKU/6q2KVmv71p2eJif1oplHRdfLz2OFXpqUDgXqY6N35nt
 /ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OXF1nfY1G02W5U3tqjZ+o1yJ/iYl9amwN0jQLypSbMY=;
 fh=4syABB0wR8Yj5BNn2XrxmjPiQY757nOVelF71OKeELE=;
 b=SwA4pu+SGzTJT2Q1Ms9r+sMb43hrbX94Qat3sG5fdTPLeUmJUPQRRB+S8zCf+SaYmP
 1PHw0B7HqPd1Z1tIxqcQ/kS7ah1lDtI+KsKtzC5GbijrxI76AWZ5a7L8cV3457Iy4Ssf
 XocMXjHnN9J7dU6NvpJ9Eezgiq0PLm8mnmCC29qshNxkrTn6gS0funSmPCvd8M6e3XIW
 K74Frb80iDu2mtyH6yj6+4GKtM0DV0q2KKf4AYeJbASdtaSvHQ4n90Qrjh9TRoPvtwMT
 vRbSDaWi+vJ769z2YODw2ACRd6B5SykbcwB662l36heqvlAxz8WbpKeHozHbenHQw/ig
 tV6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787761762; x=1788366562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OXF1nfY1G02W5U3tqjZ+o1yJ/iYl9amwN0jQLypSbMY=;
 b=BT4VNs21ZAwTdQ26YLxdNRAHFu4FrePWuTkF3ekRA/nm/20KyejFB/lwGMU3JsEQHh
 7LU7SyibE4XF92G2YAaWZ1Bera9HqvYCeosHQJy880PPaNgSw6p+MmAboJTmvPJkF1fi
 3731ppxxhJzPzuLfUW3Pu1lEEhjpa2yBFckfy9Fko3fy6wE2d1m/o1gHc2QZXWtBj8Td
 K0dgO7zSVMw8WstA+QzVrMgwZA8b8nAauAjNPT5oqzhvKtqJ9Rq2pohcfgmys+0vQS1H
 Sox8AUGThCAVuPyQA7vMHGog/eP+4YtpJTsZrPAbj3nY77zfna6EDSSmFfx8TSOqFGCH
 HpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761762; x=1788366562;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OXF1nfY1G02W5U3tqjZ+o1yJ/iYl9amwN0jQLypSbMY=;
 b=UQwCADiCkjrAgY1rNNPkzVBt6Im5LOZQ6OOWOkhOwkNjmqA17xthU/ry/B/QuNYK4A
 JfbdN/84W7dAI6U4VlISKB/fxFHdbrnPYfKbIxQPXWwyn3A+CCu8Ol+if8h+sFC8kSCF
 lxTwR8aKaRUJzRJhXmndX0u0F+HzCjQPvyMcgmiAZNRWqlE6QTE+PT1ESfkXxZ3NMWDf
 9f8u3XdwocLk0VK7WeGOAqCMnL6MQWYHUKa68Oy4ImcpPG+nNsPBOrN0yOOtIpE4IY8g
 IfDOYC4BjG5/lXp/icnDmfEatdE2g/A6XoOyXdJJVfJ51tjztD/vPXettUL8Nelu1Gp1
 NOKA==
X-Gm-Message-State: AFuF++mREv66x66vOJDBm/ul07fAoPoVFQ8wqNkikIFc6ez1jFBpe3Rd
 f0Dyv1PkPmgTr+64G7kUJitu6kQc9GdrST81o248R66xG2aj8jRlj6EDjjcWRpyMb4j0rLNxHXJ
 H0JQHr1ED6QCE3TF/7dtV27n8lEAyqiAwZFeXWHPukQ==
X-Gm-Gg: AR+sD11u08YzW5BoYaO+kAgfe2/FA7KtodRYuPhtdwnlc9EVUZfeynKEAtwaTopXBHV
 R2sBo7mTxeTwDp2sSDHbcqOHWimndttDGijMYLD+V/JGuvyqkXPpZNyedjTQCp6+BGdddx5BOOZ
 /vtBp/q8qCUKssQh53dO/8f+tV/Bc2Yf77p2TD30tvTDeMjnrKe0jjFw9mU++/beRGeyglnCz86
 awo7ftVe++zPlhfIgb0SbkAP+tgKoL7OfUAD0wz6rp+ywatp6Z8A1XNotQj7xEFmkjVxn004H0c
 YBioaJ9kpqPOw2uKVEgooEhkfjMeVGG0fAbLpRUkqVa0OeUay9DNv5daPU4LHtZdaF4EohoFq/g
 =
X-Received: by 2002:a05:690e:e8a:b0:66c:d6f6:eaef with SMTP id
 956f58d0204a3-66d25694eeamr2972557d50.18.1787761761980; Wed, 26 Aug 2026
 09:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
 <20260825212326.1907-9-daniel.barboza@oss.qualcomm.com>
 <CAEev2e8fbPt04kcKh5a+ohXYtWPzC5-cD58gcMFS-NV3QQKwSw@mail.gmail.com>
 <f972ec37-676c-42d9-89f0-05879713f75c@oss.qualcomm.com>
In-Reply-To: <f972ec37-676c-42d9-89f0-05879713f75c@oss.qualcomm.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 26 Aug 2026 11:29:10 -0500
X-Gm-Features: AcwNN1VDmwUl_t559iDLSfTuuOH-Ai5b0m_W7oQ5Jnlq5bzum0ne7ggp9t0_Amw
Message-ID: <CAEev2e-+=F_q03SLPxudhArPJn5bu-mphentw_K_-R2kV1eKmw@mail.gmail.com>
Subject: Re: [PATCH 08/13] hw/riscv/fdt-common, virt.c,
 tt_atlantis.c: add create_fdt_uart()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 26, 2026 at 10:05=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 8/26/2026 11:53 AM, Anirudh Srinivasan wrote:
> > Hi Daniel,
> >
> > On Tue, Aug 25, 2026 at 4:24=E2=80=AFPM Daniel Henrique Barboza
> > <daniel.barboza@oss.qualcomm.com> wrote:
> >>
> >> Add a common uart FDT helper to be used by 'virt' and 'tt-atlantis'.
> >>
> >> To accomodate both boards the helper is doing the following:
> >> - an 'additional_reg_props' flag is used to control whether we want
> >>    'reg-shift' and 'reg-io-width' elements added.  OpenSBI won't boot
> >>    with the tt-atlantis board without them, but 'virt' can't deal with
> >>    them being added unconditionally either.
> >> - an 'is_serial0' flag is added to control whether we need to set
> >>    additional properties related to the first serial.  This is require=
d
> >>    because the 'virt' board adds two uarts in the FDT.
> >>
> >> No FDT changes intended.
> >>
> >> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.co=
m>
> >> ---
> >>   hw/riscv/fdt-common.c         | 39 +++++++++++++++++++++++++++++++
> >>   hw/riscv/tt_atlantis.c        | 21 +----------------
> >>   hw/riscv/virt.c               | 44 +++++++--------------------------=
--
> >>   include/hw/riscv/fdt-common.h |  4 ++++
> >>   4 files changed, 52 insertions(+), 56 deletions(-)
> >>
> >> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> >> index f31cc9d3cc..b3f3af3762 100644
> >> --- a/hw/riscv/fdt-common.c
> >> +++ b/hw/riscv/fdt-common.c
> >> @@ -791,3 +791,42 @@ void create_fdt_socket_aclint(void *fdt, ACLINTFd=
tProps *props,
> >>           g_free(name);
> >>       }
> >>   }
> >> +
> >> +void create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
> >> +                     int uart_irq, int aia_type,
> >> +                     bool additional_reg_props, bool is_serial0,
> >> +                     uint32_t irq_mmio_phandle)
> >> +{
> >> +    g_autofree char *name =3D NULL;
> >> +
> >> +    name =3D g_strdup_printf("/soc/serial@%"HWADDR_PRIx, uart_mem->ba=
se);
> >> +    qemu_fdt_add_subnode(fdt, name);
> >> +    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
> >> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> >> +                                 2, uart_mem->base,
> >> +                                 2, uart_mem->size);
> >> +
> >> +    /*
> >> +     * The tt-atlantis board requires these extra props in the
> >> +     * DT, but adding them unconditionally will break OpenSBI
> >> +     * for 'virt'.
> >> +     */
> >> +    if (additional_reg_props) {
> >> +        qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
> >> +        qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
> >> +    }
> >
> > I think the issue is that atlantis uses a uart that has 32 bit
> > register spacing (0x0, 0x4, 0x8, 0xc....) rather than 8 bit spacing
> > (0x0, 0x1, 0x2...). So rather than "additional_reg_props", would a
> > name like "word_addressing" or "32_bit_spacing" make sense?
>
> Works for me.  I'll rename it in v2.

Thanks.

Reviewed-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

>
> Thanks,
> Daniel
>
>
> >
> > Regards
> > Anirudh Srinivasan
>

