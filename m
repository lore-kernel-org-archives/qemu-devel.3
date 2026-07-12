Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E33C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj3V2-0005VK-5Z; Sun, 12 Jul 2026 19:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wj3Ur-0005Uo-Ok
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 19:22:07 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wj3Uq-0001uF-BP
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 19:22:05 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-664db84f074so4111879d50.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 16:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783898523; cv=none;
 d=google.com; s=arc-20260327;
 b=jhIJHmcbvJUiOkCsY6+0VCcVn6SDKif/igXiznwUVIIcfG2P0F4d9gkXi7R2EWSC9s
 OnluE9r36vbeLLVv+hkAjtKM8O9q11Cee35no1kPLewPcUGNedXGXqXONVk6QvZSNxS4
 5I9e7LT6xqg3+8Zdz9sFpT6GSbdTpTBT/+5GCnH9NYVI2pR9m1ZFFZ/C3kQydk8iy4RO
 P4poNviGoItcomYr++Gp2rR/xze807gn+g2hK8HGFUVuCtAzLfAMFKl3ZjatnWIh5kEt
 wb2lNNvhbFINqoG2ZwVuE9lKvpd4zOuwArlRrIGlTu7XFAyPv7hsXDDqhTHuRRkNcaHI
 rxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M3QbxB16zYHmA8LvrOxVawLXVLl9lp/I3a8ub6IlgLQ=;
 fh=GV+U9xY2fsngz0eILCgAR6kP07wTihCJE3EC5W2zarE=;
 b=pmrLKLpVMVTJyIlNHqmOV3wssH9VYVNJB2E86xGBaBL4QJ319A0v5nl3D9hy2DNXTi
 hU9c0GXz+SjXRh5PCkGXJNwkHAFB0/W+LS5py6BD5A9f9VF3fP5eMuWj7hsqIPlqrCVA
 ONnQSAVb9xHAc6x+XKpckh3fMrMz64PP/b65To5p22Yrm1b/T+euVp1SjbUnmV6WSWsU
 o9WFGhs3SSvn8ZDC06bF/lcjFngEXtKPP9fWDvw6pRNJ9t/pKhKiHO15DBPaw+DtqNFD
 l+5PzX93XswUO4g6Tfo0TIGVj0i1vh5SM40O+2ev7iunzQiH9d860mZOyHCu8RFNlROw
 NExg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783898523; x=1784503323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M3QbxB16zYHmA8LvrOxVawLXVLl9lp/I3a8ub6IlgLQ=;
 b=L9Hj4K0lDRQilZGG1o8As2vB04rRtRx//SmUXbokviUjCtG++vHSF1e8qmN5+iq5eW
 aqnDmYPVP4oAaJvIDJyEj0LII6PxSiOFwFsq1Jzjo3XhFUhoxCcRVr9B4alYDsrK9ZF1
 EgHMAvFKk8F5dS79Bfhp7eIPLJQ2bMrY/f6CnkfZpMMFv74PBEIhPnmYf1FGOtj8zUuV
 X376eZY4a8/vHCn+3zSHwX/HodTcN3E9WzzVnbBwBS9J8r2FT5Ptde57b+d0+U+0ZA1P
 8EmEaVBeQ6hy33kY/kZtaRgo2E5wujqcEuNhsZjowuV9LgkIaAQkqBYfx6BZvfr472Ue
 MGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783898523; x=1784503323;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M3QbxB16zYHmA8LvrOxVawLXVLl9lp/I3a8ub6IlgLQ=;
 b=Nv72q0PBHJ22zGN4t8SKFYanlSbb8jPTGH8za4QoAJxVHcMR3XWwXG0hpYpVAufp/e
 6AnmYD1kwio6ATjO2vmpSKcfEAY0Z9iCw15H/lAJBkomkTgpJ8thogQ+h3fHLbWhVsOH
 4U7ATxzMHkqCZjXhUs+I7aw5zDuXeeih474CViTkKil+xUhv3HnXTMMMZ83eXfVcAl5k
 aKQpckmuE9QTUNI/a61YxY0qckR67O+5LiLnxtG8VH/QL1ZeRaJdsERt1OMCiZsrK40s
 hNcR3SYOKZj3y0vx0Tjb8RxZy96OabU+QPIJ8QL1/lV1nX9xT7n0cqOoc7ZzHp/QCX5L
 Tggg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpoNVBhcNPjNmh2x/6XdmowiTYX/uoxWbHCKIJdr8s2B4gLRllnWksl7jrrfFDsJdYUm056lJqvp95b@nongnu.org
X-Gm-Message-State: AOJu0Yw1CPVJFIL6aK73qDIHT3T2nzAFY4YLUeVGBaC4dznhpxJ25Tyt
 y4onP5e7kaHJDFJ4MxnddAq1UtKC2CJyFZKZmP6uUcuv2+17vV2P5Ijw76AcGTUbQB/5tHfw11T
 eYnPEYBBhIGFGZFtnk51NXtHeVWFz1UI=
X-Gm-Gg: AfdE7cneFkUjoOfyiRAgPkwfN/ulZFm9U1L+GUhwqNL2HBlUn9IxZYHwvwa8SFRrca7
 AioN2u0/B8eu3zYMb/aVPW5cyrqeQZnXgfNP72RK0+uBy07KbGnycYQ/MOA5JIG+gBXPjRWbhYx
 fTcWLkktRO0x0l0x44Ko1t9bZPLSjiT5c15v2OobSYPv9c3n01E8dYfqksfo/i2bWoeVNfuK8+i
 V8SqDrCVQIw2dS1OSwpLJE4WfbTBUmsXzka73wHrGkSaZf1z/zP3ns959qNjOhfnySar9Qn
X-Received: by 2002:a53:cf0e:0:b0:667:8b91:244c with SMTP id
 956f58d0204a3-667d7f17737mr3832417d50.99.1783898523053; Sun, 12 Jul 2026
 16:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-2-armbru@redhat.com>
 <CAEUhbmXaA6wpyUeVGL4Vn-zaP9LBFfmpTuWxDB=aMaXez_p=1w@mail.gmail.com>
 <20260712-prodigal-subscribe-759f57ab6d4e@spud>
In-Reply-To: <20260712-prodigal-subscribe-759f57ab6d4e@spud>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 13 Jul 2026 07:21:50 +0800
X-Gm-Features: AVVi8CfIcyyJwlOa9l0DbbGVlRctTot5epZaAhMqqxRLM3fWDdUcdbMHkkEEbqA
Message-ID: <CAEUhbmU66PUcuuWSL8i040XOU6j184ga-huToOULfEFrTrUp5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark "Microchip PolarFire SoC Icicle
 Kit" orphaned
To: Conor Dooley <conor@kernel.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 alistair23@gmail.com, 
 qemu-riscv@nongnu.org, bin.meng@processmission.com, mzamazal@redhat.com, 
 mst@redhat.com, sgarzare@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jul 13, 2026 at 5:51=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sat, Jul 11, 2026 at 07:04:14PM +0800, Bin Meng wrote:
> > On Fri, Jul 10, 2026 at 7:44=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> > >
> > > Commit 4a16a1a7ad (MAINTAINERS: Remove Bin Meng from RISC-V
> > > maintainers, 2025-01-28) removed the only M:, but left S: Supported.
> > > This makes no sense.  Downgrade to S: Orphan.
> > >
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > > ---
> > >  MAINTAINERS | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 576ef6fff5..aa2df9cbe3 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1761,7 +1761,7 @@ F: tests/tcg/riscv64/test-crc32.S
> > >
> > >  Microchip PolarFire SoC Icicle Kit
> > >  L: qemu-riscv@nongnu.org
> > > -S: Supported
> > > +S: Orphan
> > >  F: docs/system/riscv/microchip-icicle-kit.rst
> > >  F: hw/riscv/microchip_pfsoc.c
> > >  F: hw/char/mchp_pfsoc_mmuart.c
> > > --
> >
> > I plan to send a patch series to resurrect PolarFire SoC support.
>
> What does this resurrection constitute? The files aren't gone anywhere
> (yet, at least), so I take it you mean you'll be actively working on the
> platform?

Yes, I will rework HSS boot support to accommodate newer versions,
just as HSS was originally supported years ago.

Regards,
Bin

