Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9174ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 09:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snaQb-0001Zo-F5; Mon, 09 Sep 2024 05:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1snaQZ-0001X6-Hp
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:11:19 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1snaQX-0003Zy-Ia
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:11:19 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5e1b55346c0so1515405eaf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725873076; x=1726477876; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8arYn/fZEea4nn7zsB6nz7hWA1dILLIkk6ch34Ywbc8=;
 b=Uttg8jS8n9aLrb2i+yqdPFXJ3WevenpdtfcbC88INBm98t4XH/s6AtmxCGIpeNKGrP
 TFmCik9QIBAGfanj3a6njoWoKkEdWTlTG55gEMl2WcLalVBVZ4H/Y6pDpEceiMLeTSfd
 VxaIjA+3XaB1/lmo/T+yMgb+SJpLB/QGEFflrTOYLAEQCJVqoAQ9pvM1MXUdpRreKVBg
 sxo5+XgpjA5N63/tL8jAeTHj2PEp3VSCOaXQpW4EPDcoNqSGLqi3Ac3pUs4GFIagQnU8
 LnXhLGhiSOeuNEGf4Fjga2xkduAWK0fqJsedbSTClTkY5X67hHW6hbmtiEXew/2LQSdh
 hv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725873076; x=1726477876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8arYn/fZEea4nn7zsB6nz7hWA1dILLIkk6ch34Ywbc8=;
 b=uzQ8Yu0prcecmEoRf8uck/kVciMvYWwip10uC+ISXPAzpDwmTrccPWWmpw4lLbYNwq
 KYdxzUOw1V0obBUG6LEaOqu5cPzf/sCKQgVifqXaxbeD/4MPCIo53EZiKQdsj/Zl81qx
 vwFdWQjs9SOYk4zZwBCgcZoYB6AEZ4DpZHuvX9AFGM3qWt/r+XaZGQpKfuWjNyq/ydow
 AbjTqxd3BUC8k03kQy+4oOjnotxur+76kM+SFkWg075ZJvTnvKwIiteUROXTzYHyx89w
 ndT0ZBxFIvZzNpWMxiPymsBVfxanHK29YSO6wygEFCALrxSTrcEjYNxldH2oBUoy8JNz
 dojQ==
X-Gm-Message-State: AOJu0YyHi/9+yOgONUgXjt9uU5u7tI6Z4ojbwgtIYFmqPY0dYsK4fdtl
 kLOQ0839ddw3kIZVwDFgg/93DzyDFdr5Mz13AgKjv2MX2xhfaH4JfA6/xh7zQouyzr+O2JW0Zmp
 450s7UnMY62WpDyg4smtfPs9IGKUKmx5SbGtkJw==
X-Google-Smtp-Source: AGHT+IEi32Q6T8gYMh+9N0hZ/KOdLWNThmgcUGAdfd0qlZ811t7uiqcTYbO1tRWaa98yIuYZb6cjJXu7eb6Wp/yEAGU=
X-Received: by 2002:a05:6871:82a:b0:277:e039:7aef with SMTP id
 586e51a60fabf-27b82dd1d37mr11919531fac.8.1725873075610; Mon, 09 Sep 2024
 02:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240808081948.25837-1-yongxuan.wang@sifive.com>
 <CAKmqyKOh9dwx8+oESM5gMmuX8UY7M5-Q5oS=+EuKMR=mk3M-3Q@mail.gmail.com>
In-Reply-To: <CAKmqyKOh9dwx8+oESM5gMmuX8UY7M5-Q5oS=+EuKMR=mk3M-3Q@mail.gmail.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 9 Sep 2024 17:11:06 +0800
Message-ID: <CAMWQL2j_EDDnC4jm4C9wcXTw164diEbKitf-LbSx_0U6iTUaKw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/intc/riscv_aplic: Check and update pending when
 write sourcecfg
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-oo1-xc2d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alistair,

On Mon, Sep 9, 2024 at 10:32=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Thu, Aug 8, 2024 at 6:21=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifi=
ve.com> wrote:
> >
> > The section 4.5.2 of the RISC-V AIA specification says that any write
> > to a sourcecfg register of an APLIC might (or might not) cause the
> > corresponding interrupt-pending bit to be set to one if the rectified
> > input value is high (=3D 1) under the new source mode.
> >
> > If an interrupt is asserted before the driver configs its interrupt
> > type to APLIC, it's pending bit will not be set except a relevant
> > write to a setip or setipnum register. When we write the interrupt
> > type to sourcecfg register, if the APLIC device doesn't check
> > rectified input value and update the pending bit, this interrupt
> > might never becomes pending.
> >
> > For APLIC.m, we can manully set pending by setip or setipnum
> > registers in driver. But for APLIC.w, the pending status totally
> > depends on the rectified input value, we can't control the pending
> > status via mmio registers. In this case, hw should check and update
> > pending status for us when writing sourcecfg registers.
> >
> > Update QEMU emulation to handle "pre-existing" interrupts.
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>
> > ---
> >  hw/intc/riscv_aplic.c | 49 +++++++++++++++++++++++++++----------------
> >  1 file changed, 31 insertions(+), 18 deletions(-)
> >
> > diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> > index 32edd6d07bb3..2a9ac76ce92e 100644
> > --- a/hw/intc/riscv_aplic.c
> > +++ b/hw/intc/riscv_aplic.c
> > @@ -159,31 +159,41 @@ static bool is_kvm_aia(bool msimode)
> >      return kvm_irqchip_in_kernel() && msimode;
> >  }
> >
> > +static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
> > +                                          uint32_t irq)
> > +{
> > +    uint32_t sourcecfg, sm, raw_input, irq_inverted;
> > +
> > +    if (!irq || aplic->num_irqs <=3D irq) {
> > +        return false;
> > +    }
> > +
> > +    sourcecfg =3D aplic->sourcecfg[irq];
> > +    if (sourcecfg & APLIC_SOURCECFG_D) {
> > +        return false;
> > +    }
> > +
> > +    sm =3D sourcecfg & APLIC_SOURCECFG_SM_MASK;
> > +    if (sm =3D=3D APLIC_SOURCECFG_SM_INACTIVE) {
> > +        return false;
> > +    }
> > +
> > +    raw_input =3D (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
> > +    irq_inverted =3D (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW ||
> > +                    sm =3D=3D APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
> > +    return !!(raw_input ^ irq_inverted);
> > +}
> > +
> >  static uint32_t riscv_aplic_read_input_word(RISCVAPLICState *aplic,
> >                                              uint32_t word)
> >  {
> > -    uint32_t i, irq, sourcecfg, sm, raw_input, irq_inverted, ret =3D 0=
;
> > +    uint32_t i, irq, rectified_val, ret =3D 0;
> >
> >      for (i =3D 0; i < 32; i++) {
> >          irq =3D word * 32 + i;
> > -        if (!irq || aplic->num_irqs <=3D irq) {
> > -            continue;
> > -        }
> > -
> > -        sourcecfg =3D aplic->sourcecfg[irq];
> > -        if (sourcecfg & APLIC_SOURCECFG_D) {
> > -            continue;
> > -        }
> > -
> > -        sm =3D sourcecfg & APLIC_SOURCECFG_SM_MASK;
> > -        if (sm =3D=3D APLIC_SOURCECFG_SM_INACTIVE) {
> > -            continue;
> > -        }
> >
> > -        raw_input =3D (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0=
;
> > -        irq_inverted =3D (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW ||
> > -                        sm =3D=3D APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : =
0;
> > -        ret |=3D (raw_input ^ irq_inverted) << i;
> > +        rectified_val =3D riscv_aplic_irq_rectified_val(aplic, irq);
> > +        ret |=3D rectified_val << i;
> >      }
> >
> >      return ret;
> > @@ -702,6 +712,9 @@ static void riscv_aplic_write(void *opaque, hwaddr =
addr, uint64_t value,
> >              (aplic->sourcecfg[irq] =3D=3D 0)) {
> >              riscv_aplic_set_pending_raw(aplic, irq, false);
> >              riscv_aplic_set_enabled_raw(aplic, irq, false);
> > +        } else {
> > +            if (riscv_aplic_irq_rectified_val(aplic, irq))
> > +                riscv_aplic_set_pending_raw(aplic, irq, true);
>
> You need curly braces for the if statement. You can run checkpatch.pl
> to catch issues like this
>

Thank you! I will fix it.

Regards,
Yong-Xuan

> Alistair
>
> >          }
> >      } else if (aplic->mmode && aplic->msimode &&
> >                 (addr =3D=3D APLIC_MMSICFGADDR)) {
> > --
> > 2.17.1
> >
> >

