Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47740C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VSg-00065v-VH; Tue, 15 Sep 2026 11:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x6VSf-00065b-07
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:52:45 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x6VSd-0001Iz-7i
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:52:44 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso28068125e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 08:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789487561; cv=none;
 d=google.com; s=arc-20260327;
 b=AauhAnB3I8ctv4wMBfAc7ne05H/w41uhs3A7X12JTuJnYDDK/eyEzM3G5uhW39Pgad
 6IyCFM68jK8A6VrPeGhNWKgyKQjd4gPMk2b+wJ+1yzqIiwuk2jOPNcjVCep0kw3iO+JG
 AHojorj9E0r06pqxfXpj4DwfMLNJ7Z5/HvyIzf1l/M7nTicKeCpi32cvzvSCd6V/TjaP
 YCpMiHJ+QzfJUuKWm4sYKNa9grS80Y9YLMAFq7tUTJcCpuROadXaZe67wibnNgEq9Xr3
 Mf0oj4FqvOEv1wNpESp98L+Qic7sbM5FrFjMpkAtB/BfujiO/0uPNowKlbx+i3gjVIHp
 WhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1fDsvYVDTSXBksRxHit6uWvdlwUTm4KkWvIvwmlHs0M=;
 fh=e0Av16U704ojqi1wX5ZVo/ZbYsDQv4mwf2Q0qehHmHg=;
 b=R9ITDtYaPFXbWOBBKFM4KuRiNtKLan/siJqZ2rzF4kO3MeK8XmGSDMeQNedNGaGyvC
 nb6p6E+McmHINDao/2D58K/M341XY6qrPDrBNBJEamkHb4m/MVtj2G+n8Cykdk9L7XXB
 pgfgnfcja6ESRF7KAghaxP6prad9bkhyzWOCt6bjVwZcBrGuW4DVV4Y8/V+DHBSg2iSy
 AH7b8va1ReuEHu0VeZKR43oF/SrCbzNnHEzLQb0kFBcDFRivxdBFn3jk7PPUiV2cE677
 N8GMy6jGIGdChDwaQzFx8CKm1XNb4K0WW49vd7ZprjWTjEo3mGkDD1vzr7gznUDhseEX
 8okQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789487561; x=1790092361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1fDsvYVDTSXBksRxHit6uWvdlwUTm4KkWvIvwmlHs0M=;
 b=UDiS6iWmWJj0fcBNXDOwc9wVOoq5GQ+Z3ISYdOzSxaB5m8c1eKpN0b+SiY/ObeHoy1
 tZA6fXg//UwchLym7lfmFQyqbiRhk7YYBnRPls/667K1/NvGFpiypY3BzvBpYVARMx2P
 QA21sOXFKqCw93OKFAkS/0dloHbGfKcx7pMD9e96Vda9qaqxdcYGnr4L7bDx36LSafnJ
 cpV0HWjKt8WsYrQ+pNZqukz6fz8qkDISASjcGUIo/mta5HRlyQeD+yC02U5b/3VTBC94
 AUOcFQdDs2gtGs2vZ2+ya0qmNxAWWTDB6zl6PAqK89HF86HR2BYgCwlLE1P1calM8xMq
 nNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487561; x=1790092361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1fDsvYVDTSXBksRxHit6uWvdlwUTm4KkWvIvwmlHs0M=;
 b=zIROcC7gpWcZIXjMWYUvchz9L4wmijjA0/bLjeDvWfTDD9Yt5NABZr4I2RS/7J1fIb
 Osh5MeX07vXxkBSkmeUsZvzDGySnj3Wnc0nVpvnNbQC2LJ+j255DM2s6x6EOhB/EzV1f
 wYWH+0kYS+AXKCE/+DfGgu/pNOT8uo9VJjgPCGVsvLQ22jmI72MByPm07z8mAXFpXNxl
 dzBow81bb0rQxu+Ln9z3WUQxo/W2eVVnn2lhMBPvzwi5ydpL1u3qbI2hP1oUOpYu4cds
 k6+GViyYSp7PMJyZAFupp2IaGpLip3VyVHSZcs3KB+GY1avAzvGYJm2tC9BPiwMv4r8I
 NmXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHVmpfrfqx9ULNKAUxUReoDbVFwZobqyUlTLsFCH+F5hAXxlziQSMZDOB48l7Ym7qWs6OwNiSmJ4Qi@nongnu.org
X-Gm-Message-State: AFuF++kZpSp3bls5a4DHJ6ZlYMXUb/A4AfUWd7EZ3V5en/sb0tDAwubY
 YrvnfYyR0jDblO9DQc1BdqaP1WjxFtYB7q6L364hYWikJ3XzZVg3akDpJzHOKz/2gDZwCN+h22T
 W+K9TiyLkenGotOqww2fVpEjTvaWKMQQ=
X-Gm-Gg: AYBFou1mrePmzUWuyR+nKWlQHJUI1t1jv/kwRghrNjOmQmwzvn8JZg7FtMa8t75K90J
 T2dANsGYNcIuJXJGbg9mklk6qXneX6hr4yaUtqhwoRMT7EsyesHNoaE8rHHb9MlPtvYpsl0XWS6
 OxgIHHgQodgovsoA2r625XVmP4D5oumoqcmNkFIiiC+fge2upvpDG0nUUZO33WfJ0+eeT9056Ws
 XIX+fnO15EikmqFxg3l8LmykjPCrjnAr647LZNxDMgnfkTr35uIqv55Rv0ZczzLNAP3zy4l67Xf
 g0PP7m9bD4FSIvmsHQDkzW/QjX5v2iJvB8BL6q2RVqP7yoa/zhl5zWY=
X-Received: by 2002:a05:600c:3b9a:b0:49c:ffde:45ff with SMTP id
 5b1f17b1804b1-49e7a66b656mr98016625e9.17.1789487560659; Tue, 15 Sep 2026
 08:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-2-bin.meng@processmission.com>
 <CAFEAcA-p=UaNk-Qddid99o7zeGS4WqmvqAugxtjtBKZwv9ie8Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-p=UaNk-Qddid99o7zeGS4WqmvqAugxtjtBKZwv9ie8Q@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 15 Sep 2026 23:52:27 +0800
X-Gm-Features: AcwNN1U6jgOO9d3b_xdMqJWyq5NWUAoCAikbNt--Rpxy9oQo_8wv40bxA3Bsup8
Message-ID: <CAEUhbmX3N2u732mUZ8wG0pdtN+vCrVf4rdX3TR+vHPeRunsGPQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] hw/arm: fsl-imx6ul: Add SCU compatibility window
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 14, 2026 at 5:20=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 4 Sept 2026 at 17:15, Bin Meng <bin.meng@processmission.com> wrot=
e:
> >
> > U-Boot's common i.MX6 CPU identification code reads the Cortex-A9
> > SCU configuration register at PERIPHBASE + 0x4 even on i.MX6UL.
> > The value is only used to distinguish Cortex-A9 i.MX6 variants.
> >
> > Cortex-A7 reserves this address and reading it causes data abort.
> >
> > The same U-Boot abort was discussed on qemu-arm in September 2024:
> > https://lists.gnu.org/archive/html/qemu-arm/2024-09/msg00072.html
> >
> > Map only the four-byte configuration-register address as an
> > unimplemented device. Its zero read result gives U-Boot the
> > single-CPU encoding after the low two bits are masked, while
> > the remainder of the reserved Cortex-A7 page stays unmapped.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> > (no changes since v1)
> >
> >  hw/arm/fsl-imx6ul.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> > index 1863558a0d..d6f662efe4 100644
> > --- a/hw/arm/fsl-imx6ul.c
> > +++ b/hw/arm/fsl-imx6ul.c
> > @@ -187,6 +187,15 @@ static void fsl_imx6ul_realize(DeviceState *dev, E=
rror **errp)
> >      sysbus_realize(SYS_BUS_DEVICE(mpcore), &error_abort);
> >      sysbus_mmio_map(SYS_BUS_DEVICE(mpcore), 0, FSL_IMX6UL_A7MPCORE_ADD=
R);
> >
> > +    /*
> > +     * U-Boot's shared i.MX6 CPU identification code reads the
> > +     * Cortex-A9 SCU configuration register on i.MX6UL. Cortex-A7
> > +     * reserves this address, so provide only the compatibility word
> > +     * needed before the console is initialized.
> > +     */
> > +    create_unimplemented_device("a7mpcore-scu-compat",
> > +                                FSL_IMX6UL_A7MPCORE_ADDR + 0x4, 4);
>
> What is actually going on here, though? Why is u-boot reading
> an address that's only here for the A9? Has this been reported
> to u-boot as a bug? What does the real hardware do?

I suspect the reason is that the imx6 family contains both A9 and A7
based SoCs and it's a leftover when imx6ul support was introduced in
U-Boot. I do not see a bug report against U-Boot yet.

>
> Whatever the answers are, I expect the correct fix is not going
> to be "fake up this specific 4 bytes to ignore accesses in the
> imx6 SoC model".
>

Apparently the real hardware ignores the scu access on A7. So IMO it
could be accepted as a workaround for buggy software although guests
should not do so.

Regards,
Bin

