Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65939CA5FE4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 01:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDAti-0003Bq-Pw; Sat, 03 Oct 2026 21:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDAta-00035r-7l
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 21:20:07 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDAtY-0003KZ-2V
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 21:20:05 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ac47074ae1so3849597b3.2
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 18:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791076803; cv=none;
 d=google.com; s=arc-20260327;
 b=JeuRB0dB6AwB0ixKz893iz0jMU4QTtA6jr3M4wGZrDQP0bs3ZEX/uhITTKYxptA4Ua
 KpNvcgAx3H2/xop63lX4QklNH+084q5GbmmxB1RBfPoBQm+XuNrWOBZHARFczf90nX0R
 nZtO6veKIrb2Tjlqxr935jjaOQoGWvdN4z7vPowbbn7c9N2akYj4XGdAIV6s82/mJCLk
 e9htKKEfGvDb/IC5itY4jnBeg78hU24fBbNG2y1q2x9Lsi4Q/1i81U90qJAIRkqy+M3j
 rnVfSU1kOjikBkyPKSYw4mP5r8+lOVydamPlV5qQ81SgqJl1XdfFiCsuqzjaTwIy9Y3m
 ANnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W6pCVEfc1+l0CJAgHWpRs7RM2mUmGEWIEO5KudN0MVc=;
 fh=eNSGfvFK8UFBnhwENrAOTFcGjadzcUHh2Bunbt0DEak=;
 b=czkiBbbC9Vdke4DmJNmbZBiHCqEuKGPoQcrnmBV7Y3ged0/2HiR+LRQ2ntonw6l6t8
 Q8AGwUsU2dZw3USFofClxyXn15hCysqmAswR8krxKx8AZFU2jRDMAIQk0Ug/QsM1Uxba
 5CzEZykoYoMsZdQioEZJJ9DsxupRwzq3qkNzz3eDvd8gS8mYfQPsr5++myb9uIUdkx8m
 yT8id7eIzLKG18Kx1qxZsv8cklxC72ePrG2MOF3RIFdhNX1Ty1h1a7qWbV5dgeEUWReO
 cNJHFup2WorLhVIcDLbUoPnXEi0FYHVKfYlvIW0lfyls8jbKlWCh0nuTPO8VxKJaU4NZ
 iIAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791076803; x=1791681603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W6pCVEfc1+l0CJAgHWpRs7RM2mUmGEWIEO5KudN0MVc=;
 b=NyDsZDq7uYBjGbwS4gFIOhNqe1/wbWwp/04YwjvXVKLxWyKpyUOvi9iccIRIsMuykN
 JS0tcOObvlVmmy2pjpU4q3nU686v1Q2ZzL6hboSZPoAWrLwgJHo8maQqLm1xEKPjFQ6b
 2nYL/dehkqvzkVF5v6efIzpS7sXUp8NO90Ki9ruyjxeWyWjBqW2jY1Gn61e/nWCwajW1
 /jma7FoxexKnmyZPx2TmOS3KNEJXJ9sJikRGg8Co39fz9dxebqqarwut7Uy/iAQFvfu+
 StwNceqTf1aZFrJZBqWiWK+PW6vAf7RGMgxCfKWMqd4BrIOgqbf+oNEh12e6/vxtZpIs
 rd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791076803; x=1791681603;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W6pCVEfc1+l0CJAgHWpRs7RM2mUmGEWIEO5KudN0MVc=;
 b=SuGXjfcnS5iA6gU3eUNyKtTm20iKTMxCLyD8/WL5AllNl+jI7UX1Lnts116pGw7bEd
 Ww7707o4OC1J6ZgeMvRbzEcit0rN6rYoqA3HU20Y6WPnEz0fWT5IoHvVk+e6YMPFt/u6
 VS6JuSOSrzFCf1/c6gwdcbOLKeB53YWU5CbjuZZ1mjpXbun+wJVan/BtxTV3Frf/oMHm
 S6LBsekg5BpMD/70gHOL36CIX/WMROHxlKNgRob3KPwRPJkeglBHrJZo0GRIdrcONoTI
 8h7IQtOQZtOp3NxlbbdgRkL5LLVXzVJq0QN+6Thp1RML6MmOWBOHHeduNhIPSURLjMLB
 HmxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDbbuSafKrjK1ISRlUqEkiUplE5V6VLXp72+aPYhA9py0GiajTYKjsb8srCEY5maB7u7hAN057YcS6@nongnu.org
X-Gm-Message-State: AFq9FYIAgiq1ArlMvs6y7FevSN6NJr2VVflyS6SWYRW1QEV9oGOXfyfn
 snfYECMngy+xKN9m1eHJGhCHSmTI1eZkD64/iYX7KzVCRAMF5mkQUcQW/nWFn8akvfvhqy70jeT
 vXE+wENC644LMCcAYHPOOVLMhd650BdY=
X-Gm-Gg: AYBFou3tMqA1HUmjvGWvqCZhl8wz6OcOCx5DBxRviRPxlLTuEowlZCoRTF6K4Ee4lVk
 kN7y2GzYBBpINOrNpChPCv75LrO6/pUKgcAg2591KhC37XicuYhGtPQL5gTxn/88De5abr/KKUD
 ibbyeiYMTTYaKIeKnemmJjQrdNvbRde4YfTZnkVYBBcQcf0MiR4kxoZYuHEJV7FiG14IX6WqpqT
 OEBRTUvVz7j3XqGIpOXbfT4SzGsi/Etm8YKDNDYBOlKUeA2oZJx8cWfP8Vijc3YSiAzD6lP8M4V
 CKZzmLOsPgS0h1i0SvOWEZTeN5xl/WwKDBlhuggP9mFd/w3o9eC8ppakkreTdFa7OM7PNiPUSrf
 i/nCbgZ86OobfENc=
X-Received: by 2002:a05:690c:6987:b0:8ac:c329:67e6 with SMTP id
 00721157ae682-8ae38eafcefmr34042927b3.16.1791076802573; Sat, 03 Oct 2026
 18:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-2-bin.meng@processmission.com>
 <CAFEAcA-p=UaNk-Qddid99o7zeGS4WqmvqAugxtjtBKZwv9ie8Q@mail.gmail.com>
 <CAEUhbmX3N2u732mUZ8wG0pdtN+vCrVf4rdX3TR+vHPeRunsGPQ@mail.gmail.com>
 <CAFEAcA91O71cLf9ogos_xuTx+9fn-jdUGP5u80RD6hOxAQNQOw@mail.gmail.com>
In-Reply-To: <CAFEAcA91O71cLf9ogos_xuTx+9fn-jdUGP5u80RD6hOxAQNQOw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 09:19:49 +0800
X-Gm-Features: AclHuK8-6iTzb4hOTo4dqedK0rv7xlSGConn0L0ynMFv4dao_GjPbhVkAmtAh1o
Message-ID: <CAEUhbmUeeuKiZiaTrU2wm3Gi8NbZ+o9XVegUf-gLNBr-+rogVA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] hw/arm: fsl-imx6ul: Add SCU compatibility window
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Peter,

On Wed, Sep 16, 2026 at 12:13=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Tue, 15 Sept 2026 at 16:52, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Peter,
> >
> > On Mon, Sep 14, 2026 at 5:20=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Fri, 4 Sept 2026 at 17:15, Bin Meng <bin.meng@processmission.com> =
wrote:
> > > >
> > > > +    /*
> > > > +     * U-Boot's shared i.MX6 CPU identification code reads the
> > > > +     * Cortex-A9 SCU configuration register on i.MX6UL. Cortex-A7
> > > > +     * reserves this address, so provide only the compatibility wo=
rd
> > > > +     * needed before the console is initialized.
> > > > +     */
> > > > +    create_unimplemented_device("a7mpcore-scu-compat",
> > > > +                                FSL_IMX6UL_A7MPCORE_ADDR + 0x4, 4)=
;
> > >
> > > What is actually going on here, though? Why is u-boot reading
> > > an address that's only here for the A9? Has this been reported
> > > to u-boot as a bug? What does the real hardware do?
> >
> > I suspect the reason is that the imx6 family contains both A9 and A7
> > based SoCs and it's a leftover when imx6ul support was introduced in
> > U-Boot. I do not see a bug report against U-Boot yet.
> >
> > >
> > > Whatever the answers are, I expect the correct fix is not going
> > > to be "fake up this specific 4 bytes to ignore accesses in the
> > > imx6 SoC model".
> > >
> >
> > Apparently the real hardware ignores the scu access on A7. So IMO it
> > could be accepted as a workaround for buggy software although guests
> > should not do so.
>
> Mmm, but I don't think the fix is going to be just this 4 bytes,
> and possibly it shouldn't be in this SoC specifically.
>
> What does the TRM for the SoC say is at this address?
>

The TRM for the SoC only says 00A0_0000 - 00A0_7FFF windows is for
"ARM Peripherals: GIC400 Only visible to ARM core(s)", then in the TRM
for Cortex-A7 the address 0x0000 - 0x0FFF is marked as reserved.

I plan to submit a patch to the U-Boot upstream to see how the
maintainer thinks.

Regards,
Bin

