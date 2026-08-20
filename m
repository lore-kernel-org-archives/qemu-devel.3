Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3ADC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7Uj-0007gk-0H; Thu, 20 Aug 2026 14:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wx7Uh-0007gS-UD
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:28:03 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wx7Ud-0003tu-MA
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:28:03 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so19683166b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787250478; cv=none;
 d=google.com; s=arc-20260327;
 b=Kpf/VFYPW9pJzoFnod5ZHvVqyL0CQDfJiS2e5M8zrUvbrNcKgr+NuWi9qob0NGTNBD
 EJVSKllGnIAIIuVrs0Jvg+1wnL9ssfJqXSwmtKbfsrr0xlc3DTq4k+vOI3ckPk1/3rD2
 R3dFJUn1drFdvrCE3/4l77gIH97wtf30abFXvdbMi6k0xqMp2R1zhbsAVFUXpzX6+o/A
 Wgha8GDgxSsblFCnwy9ea5xa7er26k6YoDi3RAfckVHirJDu2KicnyxXAtmobfo2tYWh
 BPu8BQ/kDnaJEK28rdlCDG+xArI0xZzef0QIe69OYn2jydI1Nxqo4GWrPIiGEGhRieR1
 o4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pZMfJvqb0Gog2iAprWdrCcOM2ILYHmTtfcu4bsGnWeg=;
 fh=SlUN190tW2q9WA354mTR8dSysWghjGsJSMFqwvpYr2k=;
 b=aztOnLns50SiT4HmaoLR2cpJP+zP1MyGoZAjhdS8fc8FTxrZI5Nj/KkciUQBXb0Qvz
 y3kmfYByop2zsj0bapyvVjjd82cilbmYlsEJNkSQrTLl6NTxf6dDPWxjlRrXvsyHjajQ
 6YSTGM8ljVDAWygM5NsYbuE9BZFps2+p04K5jf5+FnJysmVeQ5fkxlr+eV5aqT6p0ULE
 K1YLZRQGv2W8OWJKTED6mQG26a/yg57cYyup3LLI//XKVYKpTfUN2/utEpnixDSBcCSk
 P7G6rYqk2Z93bBUcFvO2lffVCsa1gOAzxF4WNTShEuclceYL1nf7DsYPGlE5pepLeXdZ
 VD/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787250478; x=1787855278; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pZMfJvqb0Gog2iAprWdrCcOM2ILYHmTtfcu4bsGnWeg=;
 b=BxF9Wk+DpKIgc6/Rz20uApw47mikwvTAFz4f+IRjXPwR7OWx2PMUMp8+pT+NP8qY8J
 HVtVM2allYu/7Tz9Q0+7UK/wrwbUtMJ1uEyINrMDpnf3Dwms/io1uEMQuL2Lak6/rCRy
 F2POsLkeBCMb6n+jDekjSJFYdGpnZqWKso6+quoEOMPP+KXDIpfAkH1bDuAW9SwkQr+L
 BKVC2H9EKv84sF92c3AqJQH9FoHrQ8XbuFBKjzk+aEVj6agcnkBINlPMBJ4cJY2j6hm9
 HXsdVeQ8Q0vKYqXFldlIQSJCMQVUjw0zOxAlevW3Iqnx0tar2Rls1J3u6aGETF/ZyORp
 eFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787250478; x=1787855278;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pZMfJvqb0Gog2iAprWdrCcOM2ILYHmTtfcu4bsGnWeg=;
 b=WWNor9GD8aI7E6pzbUN1Oq15u8/ygU7BGzaF7WRzOSykZ8mxTh8lKYnfN6lVwPThcQ
 pBlcobgCiK4APc5b+K1wEyCh7SFL0R/sGEdbIS5/oeIaOkjnhSwQtkn9KEdkLEdOlDPY
 4NSJEQ2DdzzpGo53HxYXS3OrK/Tk6KPcbwGSoXkNuOpiv2II337F7yjQEJyWvKw+2Dpk
 qrjc/CskjnhaPQ7CGmOqOu6RmgIfOtBnjDNnTeT7hE0jo1edL1h52tQJb9HVWTvSb58G
 9tcRbcdaOHJIRkDYxSHK7mP4HE8NCU33iURsN0LA+Q0lvDyKK+x/Yc2D0rsXxUgDTgpQ
 vpzw==
X-Gm-Message-State: AOJu0Yy8aysdRh4wHjyYzeNvjbfJwlu61vFYWuq+tsedEsn5my50bBnG
 J7wJBBBcQ/tOrPv2cz6WpAwg4MEMquq9AlFlyNqSfVngs25YR0UISsvlFbAt5hc5I5d1GTdmKBC
 0FyO6uFHf/iwi5At4BXM1+evU7XLbAK0=
X-Gm-Gg: AR+sD13rDeRhoDnOfvwfPHgLUWCsCDk5y+2AQlz1gxWFQscwiPmLZbvk9RJrO3BY10H
 NEUwHWtfUYXxjQQB0AkZrWmFqGOmnp2h9j1+U2QOSDzadIiTo2V2jxv9QzOgcHJ0FYHXqc0TPg/
 mQuQ36mcMXrn2G5aN/nwM1o35TNQi5j/Dt04B6kpn86oQV5e91tFdyLcMHIDWj9DIWDp2yxK/Cf
 NcPT8OerxiaAe7qDS9ELnF7Y/PKluWdEEpV6KmW989la9pHsBbPmos1L4raJ6b+keA7sLaOATFs
 kfWWMAlaS41TukWkK4XiOEZbuqkb4z5tIgMpiR/L
X-Received: by 2002:a17:907:c789:b0:c16:831c:427d with SMTP id
 a640c23a62f3a-c246a736bfdmr41182966b.21.1787250477788; Thu, 20 Aug 2026
 11:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
 <20260820024834.3286721-2-kylefoxaustin.github@gmail.com>
 <CAEUhbmXjTHjw3v90p9eg4Pv587kQxuiEcMwkwT1XT-ZedWhbMA@mail.gmail.com>
In-Reply-To: <CAEUhbmXjTHjw3v90p9eg4Pv587kQxuiEcMwkwT1XT-ZedWhbMA@mail.gmail.com>
From: kylefoxaustin <kylefoxaustin.github@gmail.com>
Date: Thu, 20 Aug 2026 13:27:46 -0500
X-Gm-Features: AcwNN1WD1Z-8RawrPX0fcR-7-qNBo_r1GkfufEKIfFOsQqamRMShxihpTbQTVVU
Message-ID: <CANqqvPcoZjxDBXEWW0Ns82YXpzxDnE_1pauY-mvjyzd3pf14Qg@mail.gmail.com>
Subject: Re: [PATCH 01/16] hw/sd/sdhci: add i.MX uSDHC SDCLK_AUTO_GATE and
 NO_SDMA_BOUNDARY quirks
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000da705806597ead4c"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000da705806597ead4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bin,
Thanks for the pointer -- I had not seen series 518052, and it clearly
supersedes my patch 01. Your 06 (honor uSDHC vendor clock gates) and 08
(skip SDMA boundary stops) cover the same two problems more completely than
mine, with the RM citations and a functional boot test behind them, and
05's move to a sequential QEMU-local quirk namespace is the right call over
the top-of-word bits I picked.

The part that makes this easy on my end: you set NO_SDMA_BOUNDARY (and
CLOCKS_IN_VENDOR) directly in imx_usdhc_init(), and the i.MX 95 machine
reuses TYPE_IMX_USDHC -- so once your series lands, my uSDHC instances
inherit both behaviors with no machine-side code at all.

I'll drop my patch 01 entirely and remove the quirk-set line from the SoC
patch in my v2; the i.MX 95 series then just depends on your sdhci work.

On sequencing, I'm happy either way and will follow your preference: I can
hold my v2 until 518052 merges and rebase cleanly on top, or post v2 now
marked as based-on your series so the dependency is explicit for reviewers.

 Whichever is less noise for you.
Thanks again for catching the overlap.

Kyle

On Thu, Aug 20, 2026, 6:50=E2=80=AFAM Bin Meng <bmeng.cn@gmail.com> wrote:

> Hi Kyle,
>
> On Thu, Aug 20, 2026 at 10:48=E2=80=AFAM Kyle Fox
> <kylefoxaustin.github@gmail.com> wrote:
> >
> > The i.MX uSDHC issues commands with SDCLK auto-gated (its driver never
> > sets SDCLK_EN), and its SDMA does not honour the 512 KiB ADMA buffer
> > boundary the generic core assumes. Add two opt-in quirk bits for this:
> >
> >   - SDCLK_AUTO_GATE: treat the clock as running once the internal clock
> >     is enabled and stable, instead of also requiring SDCLK_EN.
> >   - NO_SDMA_BOUNDARY: skip the buffer-boundary break in multi-block SDM=
A.
> >
> > Both default off and are a no-op when the bit is clear, so no existing
> > user of the SDHCI models changes behaviour; a machine opts in by settin=
g
> > the bits on its own uSDHC instances (the i.MX 95 SoC does so).
> >
> > Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
> > ---
> >  hw/sd/sdhci.c         | 67 +++++++++++++++++++++++++++++++++++++++----
> >  include/hw/sd/sdhci.h | 21 ++++++++++++++
> >  2 files changed, 82 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> > index e58a6103970..327e9a7cb74 100644
> > --- a/hw/sd/sdhci.c
> > +++ b/hw/sd/sdhci.c
> > @@ -611,12 +611,27 @@ static void
> sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
> >      }
> >
> >      /*
> > -     * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not
> account for
> > -     * possible stop at page boundary if initial address is not page
> aligned,
> > -     * allow them to work properly
> > +     * The i.MX/FSL uSDHC silicon does not implement the SDHCI "Host
> SDMA
> > +     * Buffer Boundary" mechanism; it transfers all blocks back-to-bac=
k
> > +     * regardless of buffer-boundary address alignment. The
> blksize-quirk
> > +     * in esdhc_write() forces bits 14:12 to 0b111 (=3D 512 KiB) so
> Linux's
> > +     * "zero this field out" pattern doesn't trip a 4 KiB boundary
> break,
> > +     * but the real hardware never pauses for the boundary at all, so
> > +     * neither should we. Skipping the page-aligned path makes the SDM=
A
> > +     * transfer run to completion (blkcnt -> 0) and fire
> transfer-complete,
> > +     * which is what the FSL U-Boot SPL driver expects (it doesn't ack
> > +     * SDMA-boundary IRQs by re-writing SYSAD). Controllers with this
> > +     * behaviour set SDHCI_QUIRK_NO_SDMA_BOUNDARY.
> >       */
> > -    if ((s->sdmasysad % boundary_chk) =3D=3D 0) {
> > -        page_aligned =3D true;
> > +    if (!(s->quirks & SDHCI_QUIRK_NO_SDMA_BOUNDARY)) {
> > +        /*
> > +         * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not
> > +         * account for possible stop at page boundary if initial addre=
ss
> > +         * is not page aligned, allow them to work properly
> > +         */
> > +        if ((s->sdmasysad % boundary_chk) =3D=3D 0) {
> > +            page_aligned =3D true;
> > +        }
> >      }
> >
> >      s->prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
> > @@ -992,9 +1007,26 @@ static void sdhci_data_transfer(void *opaque)
> >      }
> >  }
> >
> > +static bool sdhci_clock_is_on(SDHCIState *s)
> > +{
> > +    /*
> > +     * The i.MX (u)SDHC has no software SD-clock-enable bit (the card
> clock
> > +     * is auto-gated by hardware), so its driver never sets
> > +     * SDHC_CLOCK_SDCLK_EN. For such a controller, treat the clock as
> > +     * running once the internal clock is enabled and stable; otherwis=
e
> > +     * every command would be silently dropped (no completion/timeout
> IRQ),
> > +     * stalling the guest on 10s host-side timeouts.
> > +     */
> > +    if (s->quirks & SDHCI_QUIRK_SDCLK_AUTO_GATE) {
> > +        return (s->clkcon & (SDHC_CLOCK_INT_EN |
> SDHC_CLOCK_INT_STABLE)) =3D=3D
> > +               (SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE);
> > +    }
> > +    return SDHC_CLOCK_IS_ON(s->clkcon);
> > +}
> > +
> >  static bool sdhci_can_issue_command(SDHCIState *s)
> >  {
> > -    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
> > +    if (!sdhci_clock_is_on(s) ||
> >          (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
> >          ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
> >          ((s->cmdreg & SDHC_CMD_RESPONSE) =3D=3D SDHC_CMD_RSP_WITH_BUSY=
 &&
> > @@ -1613,6 +1645,9 @@ static void sdhci_bus_class_init(ObjectClass
> *klass, const void *data)
> >
> >  #define ESDHC_VENDOR_SPEC               0xc0
> >  #define ESDHC_FRC_SDCLK_ON              (1 << 8)
> > +#define ESDHC_VENDORSPEC_IPGEN          (1 << 11)
> > +#define ESDHC_VENDORSPEC_HCKEN          (1 << 12)
> > +#define ESDHC_VENDORSPEC_CKEN           (1 << 14)
> >
> >  #define ESDHC_DLL_CTRL                  0x60
> >
> > @@ -1707,6 +1742,26 @@ esdhc_write(void *opaque, hwaddr offset, uint64_=
t
> val, unsigned size)
> >          } else {
> >              s->prnsts |=3D ESDHC_PRNSTS_CLOCK_GATE_OFF;
> >          }
> > +        /*
> > +         * An SDCLK_AUTO_GATE i.MX uSDHC drives the SD clock through
> > +         * VENDORSPEC, not through the SDHCI CLKCON. For those instanc=
es
> > +         * mirror the VENDORSPEC clock-enable bits into clkcon so the
> > +         * standard SDHCI paths (PRNSTS.SDSTB derived from
> CLOCK_INT_STABLE;
> > +         * sdhci_can_issue_command gating on CLOCK_IS_ON) see the cloc=
k
> as
> > +         * enabled; otherwise the U-Boot fsl_esdhc_imx driver waits
> forever
> > +         * for SDSTB. Consumers without the quirk keep the upstream
> behaviour
> > +         * (a VENDORSPEC write touches only vendor_spec/prnsts).
> > +         */
> > +        if (s->quirks & SDHCI_QUIRK_SDCLK_AUTO_GATE) {
> > +            if (value & (ESDHC_VENDORSPEC_HCKEN |
> ESDHC_VENDORSPEC_IPGEN)) {
> > +                s->clkcon |=3D SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STAB=
LE;
> > +            }
> > +            if (value & ESDHC_VENDORSPEC_CKEN) {
> > +                s->clkcon |=3D SDHC_CLOCK_SDCLK_EN;
> > +            } else {
> > +                s->clkcon &=3D ~SDHC_CLOCK_SDCLK_EN;
> > +            }
> > +        }
> >          break;
> >
> >      case SDHC_HOSTCTL:
> > diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> > index a9da6203fcb..e6940b62562 100644
> > --- a/include/hw/sd/sdhci.h
> > +++ b/include/hw/sd/sdhci.h
> > @@ -115,6 +115,27 @@ typedef struct SDHCIState SDHCIState;
> >   */
> >  #define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
> >
> > +/*
> > + * The i.MX (u)SDHC gates the SD card clock automatically and has no
> > + * software-visible "SD Clock Enable" bit: its driver programs only th=
e
> > + * divider and the internal-clock enable, never SDHC_CLOCK_SDCLK_EN.
> With
> > + * this quirk the controller is considered ready to issue commands onc=
e
> the
> > + * internal clock is enabled and stable, instead of also requiring
> > + * SDHC_CLOCK_SDCLK_EN (which such a driver never sets). QEMU-internal
> bit,
> > + * taken from the top of the word to avoid the Linux quirk numbering.
> > + */
> > +#define SDHCI_QUIRK_SDCLK_AUTO_GATE    BIT(31)
> > +
> > +/*
> > + * The i.MX uSDHC silicon does not implement the SDHCI "Host SDMA Buff=
er
> > + * Boundary" mechanism; it streams all blocks back-to-back regardless
> of the
> > + * buffer-boundary alignment, never pausing at the boundary. With this
> quirk
> > + * the SDMA engine skips the page-aligned boundary-break path so the
> transfer
> > + * runs to completion. QEMU-internal bit, taken from the top of the
> word to
> > + * avoid the Linux quirk numbering.
> > + */
> > +#define SDHCI_QUIRK_NO_SDMA_BOUNDARY    BIT(30)
> > +
> >  #define TYPE_PCI_SDHCI "sdhci-pci"
> >  DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
> >                           TYPE_PCI_SDHCI)
> > --
>
> A patch series was already sent to ML before to enable the i.MX uSDHC
> controller.
> Please see
> https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D518052
>
> Regards,
> Bin
>

--000000000000da705806597ead4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hi Bin,</div><div dir=3D"auto">Thanks f=
or the pointer -- I had not seen series 518052, and it clearly supersedes m=
y patch 01. Your 06 (honor uSDHC vendor clock gates) and 08 (skip SDMA boun=
dary stops) cover the same two problems more completely than mine, with the=
 RM citations and a functional boot test behind them, and 05&#39;s move to =
a sequential QEMU-local quirk namespace is the right call over the top-of-w=
ord bits I picked.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The p=
art that makes this easy on my end: you set NO_SDMA_BOUNDARY (and CLOCKS_IN=
_VENDOR) directly in imx_usdhc_init(), and the i.MX 95 machine reuses TYPE_=
IMX_USDHC -- so once your series lands, my uSDHC instances inherit both beh=
aviors with no machine-side code at all.=C2=A0</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">I&#39;ll drop my patch 01 entirely and remove the qu=
irk-set line from the SoC patch in my v2; the i.MX 95 series then just depe=
nds on your sdhci work.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
On sequencing, I&#39;m happy either way and will follow your preference: I =
can hold my v2 until 518052 merges and rebase cleanly on top, or post v2 no=
w marked as based-on your series so the dependency is explicit for reviewer=
s.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0Whichever is le=
ss noise for you.</div><div dir=3D"auto">Thanks again for catching the over=
lap.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Kyle</div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Thu, Aug 20, 2026, 6:50=E2=80=AFAM Bin Meng &lt;<a href=3D"=
mailto:bmeng.cn@gmail.com">bmeng.cn@gmail.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Hi Kyle,<br>
<br>
On Thu, Aug 20, 2026 at 10:48=E2=80=AFAM Kyle Fox<br>
&lt;<a href=3D"mailto:kylefoxaustin.github@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">kylefoxaustin.github@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The i.MX uSDHC issues commands with SDCLK auto-gated (its driver never=
<br>
&gt; sets SDCLK_EN), and its SDMA does not honour the 512 KiB ADMA buffer<b=
r>
&gt; boundary the generic core assumes. Add two opt-in quirk bits for this:=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0- SDCLK_AUTO_GATE: treat the clock as running once the int=
ernal clock<br>
&gt;=C2=A0 =C2=A0 =C2=A0is enabled and stable, instead of also requiring SD=
CLK_EN.<br>
&gt;=C2=A0 =C2=A0- NO_SDMA_BOUNDARY: skip the buffer-boundary break in mult=
i-block SDMA.<br>
&gt;<br>
&gt; Both default off and are a no-op when the bit is clear, so no existing=
<br>
&gt; user of the SDHCI models changes behaviour; a machine opts in by setti=
ng<br>
&gt; the bits on its own uSDHC instances (the i.MX 95 SoC does so).<br>
&gt;<br>
&gt; Signed-off-by: Kyle Fox &lt;<a href=3D"mailto:kylefoxaustin.github@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">kylefoxaustin.github@gmail.com=
</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/sd/sdhci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 67 ++++++++++++=
+++++++++++++++++++++++++++----<br>
&gt;=C2=A0 include/hw/sd/sdhci.h | 21 ++++++++++++++<br>
&gt;=C2=A0 2 files changed, 82 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c<br>
&gt; index e58a6103970..327e9a7cb74 100644<br>
&gt; --- a/hw/sd/sdhci.c<br>
&gt; +++ b/hw/sd/sdhci.c<br>
&gt; @@ -611,12 +611,27 @@ static void sdhci_sdma_transfer_multi_blocks(SDH=
CIState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* XXX: Some sd/mmc drivers (for example, u-boot-s=
lp) do not account for<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* possible stop at page boundary if initial addre=
ss is not page aligned,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* allow them to work properly<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The i.MX/FSL uSDHC silicon does not implement t=
he SDHCI &quot;Host SDMA<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Buffer Boundary&quot; mechanism; it transfers a=
ll blocks back-to-back<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* regardless of buffer-boundary address alignment=
. The blksize-quirk<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* in esdhc_write() forces bits 14:12 to 0b111 (=
=3D 512 KiB) so Linux&#39;s<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* &quot;zero this field out&quot; pattern doesn&#=
39;t trip a 4 KiB boundary break,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* but the real hardware never pauses for the boun=
dary at all, so<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* neither should we. Skipping the page-aligned pa=
th makes the SDMA<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* transfer run to completion (blkcnt -&gt; 0) and=
 fire transfer-complete,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* which is what the FSL U-Boot SPL driver expects=
 (it doesn&#39;t ack<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* SDMA-boundary IRQs by re-writing SYSAD). Contro=
llers with this<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* behaviour set SDHCI_QUIRK_NO_SDMA_BOUNDARY.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 if ((s-&gt;sdmasysad % boundary_chk) =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 page_aligned =3D true;<br>
&gt; +=C2=A0 =C2=A0 if (!(s-&gt;quirks &amp; SDHCI_QUIRK_NO_SDMA_BOUNDARY))=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* XXX: Some sd/mmc drivers (for exa=
mple, u-boot-slp) do not<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* account for possible stop at page=
 boundary if initial address<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is not page aligned, allow them t=
o work properly<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s-&gt;sdmasysad % boundary_chk) =3D=
=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 page_aligned =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LIN=
E_ACTIVE;<br>
&gt; @@ -992,9 +1007,26 @@ static void sdhci_data_transfer(void *opaque)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static bool sdhci_clock_is_on(SDHCIState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The i.MX (u)SDHC has no software SD-clock-enabl=
e bit (the card clock<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* is auto-gated by hardware), so its driver never=
 sets<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* SDHC_CLOCK_SDCLK_EN. For such a controller, tre=
at the clock as<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* running once the internal clock is enabled and =
stable; otherwise<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* every command would be silently dropped (no com=
pletion/timeout IRQ),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* stalling the guest on 10s host-side timeouts.<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;quirks &amp; SDHCI_QUIRK_SDCLK_AUTO_GATE) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (s-&gt;clkcon &amp; (SDHC_CLOCK_IN=
T_EN | SDHC_CLOCK_INT_STABLE)) =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(SDHC_CLOCK_IN=
T_EN | SDHC_CLOCK_INT_STABLE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return SDHC_CLOCK_IS_ON(s-&gt;clkcon);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static bool sdhci_can_issue_command(SDHCIState *s)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 if (!SDHC_CLOCK_IS_ON(s-&gt;clkcon) ||<br>
&gt; +=C2=A0 =C2=A0 if (!sdhci_clock_is_on(s) ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((s-&gt;prnsts &amp; SDHC_DATA_INHI=
BIT) || s-&gt;stopped_state) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((s-&gt;cmdreg &amp; SDHC_CMD_DATA_P=
RESENT) ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((s-&gt;cmdreg &amp; SDHC_CMD_RESPON=
SE) =3D=3D SDHC_CMD_RSP_WITH_BUSY &amp;&amp;<br>
&gt; @@ -1613,6 +1645,9 @@ static void sdhci_bus_class_init(ObjectClass *kl=
ass, const void *data)<br>
&gt;<br>
&gt;=C2=A0 #define ESDHC_VENDOR_SPEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00xc0<br>
&gt;=C2=A0 #define ESDHC_FRC_SDCLK_ON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 &lt;&lt; 8)<br>
&gt; +#define ESDHC_VENDORSPEC_IPGEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &=
lt;&lt; 11)<br>
&gt; +#define ESDHC_VENDORSPEC_HCKEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &=
lt;&lt; 12)<br>
&gt; +#define ESDHC_VENDORSPEC_CKEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1 &lt;&lt; 14)<br>
&gt;<br>
&gt;=C2=A0 #define ESDHC_DLL_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x60<br>
&gt;<br>
&gt; @@ -1707,6 +1742,26 @@ esdhc_write(void *opaque, hwaddr offset, uint64=
_t val, unsigned size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;prnsts |=3D ESDH=
C_PRNSTS_CLOCK_GATE_OFF;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* An SDCLK_AUTO_GATE i.MX uSDHC dri=
ves the SD clock through<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* VENDORSPEC, not through the SDHCI=
 CLKCON. For those instances<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* mirror the VENDORSPEC clock-enabl=
e bits into clkcon so the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* standard SDHCI paths (PRNSTS.SDST=
B derived from CLOCK_INT_STABLE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* sdhci_can_issue_command gating on=
 CLOCK_IS_ON) see the clock as<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* enabled; otherwise the U-Boot fsl=
_esdhc_imx driver waits forever<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* for SDSTB. Consumers without the =
quirk keep the upstream behaviour<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (a VENDORSPEC write touches only =
vendor_spec/prnsts).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;quirks &amp; SDHCI_QUIRK_SDCLK_=
AUTO_GATE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; (ESDHC_VEND=
ORSPEC_HCKEN | ESDHC_VENDORSPEC_IPGEN)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;clkcon =
|=3D SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; ESDHC_VENDO=
RSPEC_CKEN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;clkcon =
|=3D SDHC_CLOCK_SDCLK_EN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;clkcon =
&amp;=3D ~SDHC_CLOCK_SDCLK_EN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case SDHC_HOSTCTL:<br>
&gt; diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h<br>
&gt; index a9da6203fcb..e6940b62562 100644<br>
&gt; --- a/include/hw/sd/sdhci.h<br>
&gt; +++ b/include/hw/sd/sdhci.h<br>
&gt; @@ -115,6 +115,27 @@ typedef struct SDHCIState SDHCIState;<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define SDHCI_QUIRK_NO_BUSY_IRQ=C2=A0 =C2=A0 BIT(14)<br>
&gt;<br>
&gt; +/*<br>
&gt; + * The i.MX (u)SDHC gates the SD card clock automatically and has no<=
br>
&gt; + * software-visible &quot;SD Clock Enable&quot; bit: its driver progr=
ams only the<br>
&gt; + * divider and the internal-clock enable, never SDHC_CLOCK_SDCLK_EN. =
With<br>
&gt; + * this quirk the controller is considered ready to issue commands on=
ce the<br>
&gt; + * internal clock is enabled and stable, instead of also requiring<br=
>
&gt; + * SDHC_CLOCK_SDCLK_EN (which such a driver never sets). QEMU-interna=
l bit,<br>
&gt; + * taken from the top of the word to avoid the Linux quirk numbering.=
<br>
&gt; + */<br>
&gt; +#define SDHCI_QUIRK_SDCLK_AUTO_GATE=C2=A0 =C2=A0 BIT(31)<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * The i.MX uSDHC silicon does not implement the SDHCI &quot;Host SDM=
A Buffer<br>
&gt; + * Boundary&quot; mechanism; it streams all blocks back-to-back regar=
dless of the<br>
&gt; + * buffer-boundary alignment, never pausing at the boundary. With thi=
s quirk<br>
&gt; + * the SDMA engine skips the page-aligned boundary-break path so the =
transfer<br>
&gt; + * runs to completion. QEMU-internal bit, taken from the top of the w=
ord to<br>
&gt; + * avoid the Linux quirk numbering.<br>
&gt; + */<br>
&gt; +#define SDHCI_QUIRK_NO_SDMA_BOUNDARY=C2=A0 =C2=A0 BIT(30)<br>
&gt; +<br>
&gt;=C2=A0 #define TYPE_PCI_SDHCI &quot;sdhci-pci&quot;<br>
&gt;=C2=A0 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_PCI_SDHCI)<br>
&gt; --<br>
<br>
A patch series was already sent to ML before to enable the i.MX uSDHC<br>
controller.<br>
Please see <a href=3D"https://patchwork.ozlabs.org/project/qemu-devel/list/=
?series=3D518052" rel=3D"noreferrer noreferrer" target=3D"_blank">https://p=
atchwork.ozlabs.org/project/qemu-devel/list/?series=3D518052</a><br>
<br>
Regards,<br>
Bin<br>
</blockquote></div>

--000000000000da705806597ead4c--

