Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DD0CA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 15:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD23z-0001qn-Iu; Sat, 03 Oct 2026 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xD23x-0001q7-Bx
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 11:54:13 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xD23v-00027D-0K
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 11:54:12 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ab3fd8adb1so4128387b3.1
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 08:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791042850; cv=none;
 d=google.com; s=arc-20260327;
 b=LfFyf+Ln8GWjBFegFqZkumRJu85uhg6b69bs+iImp/IKG75hpkiSvcB/YlVhWaccog
 KFXJDYhW5BsGyHjtgoFCRoWSNRcE86stxgw4vE0kPRhXUaPvr//8VGY+8+idc3RaMsq+
 i00dG8N7o4FeKIJXbi39uVlxqMRuVhC/7J5+3TsqwprmE1sGL4iHWTi4Iy1wALhipb8O
 9yWX6vK7QE1S7qb4WR6rapDBAsXUFSXa+7xrVCqU5pt2pvcX7cBoVHtPgzARbNd+WY03
 /nKUb+62fapJr/6pbphlI68ir9QOQgaxdkBn7SIqIvo0alJYy1vhdpK0nbYAhIQWQnZZ
 2BmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w9AwatI8G+il6YcYSprji/sbw3aas/rawfgbxmnt56E=;
 fh=uMeX0JVcE8vUAkF4wkgnkWOCPsOTJfSzWP3r+Tc2dnY=;
 b=jACc/Im91ikKu/SRzG0+JtrE9DrqTqhlnNOGQ2ZkNiLi1c/KYfma15XUF/vsSAUNQQ
 YTFnJ+hQVVKdPu+KeO6g1mJjXWKe4NwFb15XA8cAXQXgVN7Z3HPzFb5Kc7Z7ruT7dghU
 1sFKLVJ1Rc49ySMT0/rAfh9ctLDNlQofS4+I1z1chMmFhtgN9w2R79Ausj7+Fqf21zzS
 +4+WQHfMYaqVRRU7Msl9snynYyG64bcQgvg6/xyPdRm/yNWMGXQf+4QvwQgcdIBqYb/v
 r0+572g1hAJY/v/ZyFiTFtC8tD0inRn+kUjcCAHHybmVjxYsjFeDyfOopUPrXD6aquM5
 ZRhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791042850; x=1791647650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w9AwatI8G+il6YcYSprji/sbw3aas/rawfgbxmnt56E=;
 b=dND+vVKzeQM+AAlWGdgB4moNKiOlB9GsgF3ahNq0JYHCFdKH0iVR75TiNyTMwbl7z9
 PyIxbw+BUiU0fNFyyPj9mHaC4g0W2K7X2HzCVTu1icSZn5UCDpLyDbaEOf+PIamTKb3p
 wN19qcH6/aoNLSgkO8Hga3wctu/UuyQiZqv5ltNXNarB8Gkl0fC+PvwOxoLdCURQNsjb
 NBn7y6nKQ51XJspgSH9+qnE/QcKL0P0vRwGabZ3tezjP02fe9mOhM2RmeHUZdjT8HCdT
 htnpDlpfA8y8ZO+4JU1Ax3pxi5gCNIKBgwnjZ8NOR4fNhpG+dVYv3cd4+Eybf5kmofih
 BnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791042850; x=1791647650;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w9AwatI8G+il6YcYSprji/sbw3aas/rawfgbxmnt56E=;
 b=lnNV8KebiKVlqELlPbErzg8g1Z6/yOh9wyHzDFJPFKF4Sf4DDYc+zL5N8xXrYIGn84
 rPR5M2bg1UmL6VNdRCPPaA2vJ6ndOmc9QiLyye7SPfowFtSDb7X1U1ueQ5+NlAknm0QM
 Eq2Q488AFn6fic1bejU0J6JnGDsSdSRUlwvoP4zdm76Q7xTTPFsajzclDe9eeIQRLh5x
 1pabVLCqs8bcwJJ8KM2ZcEwc3fZXQtKUYpdOMwmcmeV/osgKmRhk44xiN8qG2oUeHhC4
 7rZwR1HJnLct243d75iQiq7wyZ370+161qWyX1CPzZZ0OytswEw3kCLkWwrn1rkqdqVW
 XGEw==
X-Forwarded-Encrypted: i=1;
 AKwUvByW1l+KyEg25dPxhg7QDUivqpPvGwXqwyHYmS+4pFGKcyOjXMu1m4RTQEdFnZKxoacTpLb9XtE2EbUd@nongnu.org
X-Gm-Message-State: AFq9FYI8m3Au2J+b19Xlf89uu4sxrxLKJdOhUpG08XgK0MnbEC2k+2QZ
 sQCWS5aJs1rwFqXa7v/PwOE5TWLLxi1aPXMnc7X3KQvj9HdEkjMYRKIp/5dlpDvwJv1fNeUS+jf
 hvf2dgGDcP0WCKn2uEWxMtW+Bod2Fzm4=
X-Gm-Gg: AYBFou1DicWUhiP7vERrExs8fGucshZ/X9OQ+RCXj4dV0DV2Bz2yEaiiPKh9Ypi2PN+
 hL9GK2LnB3+bZ4hHcjjbAVngmqEpwno0/CCK4Bk09T1yM0EubSP6cuMYHS7frJSIfHgKti6CYi0
 mJCma0VHqXG6L1exRtou5whskqIlZXASG04eNU5TQgGnvbi/gif6bu7e1VOyOb1nFbidLNotvDX
 VPq3pPRDdVTUzUdYEyDfnjNrMyEB4Q1NlKJ6Kf6qzbtxs9SLzyNzIrFZ2YkQjJX/zcDTjR4cN9g
 RVMKnaXDbFfw+QeS8pUnQyfmcmV9J0E3eBmeT7goKILzpjbYpZx0C758y3pIJFeh+tcjn/FB9qJ
 oFimGUBJKFyiZVz5V3aMlE4Eacg==
X-Received: by 2002:a05:690c:3:b0:873:5ddf:d861 with SMTP id
 00721157ae682-8ae958d401cmr10299917b3.44.1791042849618; Sat, 03 Oct 2026
 08:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-17-bin.meng@processmission.com>
 <20260930-stapling-pajamas-0b49d92348dd@wendy>
In-Reply-To: <20260930-stapling-pajamas-0b49d92348dd@wendy>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 3 Oct 2026 23:53:58 +0800
X-Gm-Features: AclHuK_qMtR5kyPix6ZOX55047Mt6QrRYkHSz4TBfmzx1tRvy2lHkqKOFnC2o5Y
Message-ID: <CAEUhbmWLUY-2dt4GdKWcN1en5Td+bz3qSTFX2qb788gn+v9HsQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/24] hw/misc: pfsoc: Honor PolarFire service
 notification requests
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Conor,

On Wed, Sep 30, 2026 at 5:23=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, Sep 04, 2026 at 11:57:35PM +0800, Bin Meng wrote:
> > Polling firmware requests system services without requesting an
> > interrupt. The old model ignored this distinction:
> >
> > 1. HSS requests the serial number with REQUEST set and NOTIFY clear.
> > 2. QEMU synchronously fills the mailbox and clears REQUEST.
> > 3. QEMU incorrectly asserts PLIC source 96.
> > 4. HSS polls REQUEST and neither waits for nor handles the interrupt.
> > 5. PLIC source 96 remains pending.
> > 6. Linux registers the MPFS mailbox driver.
> > 7. The stale interrupt immediately enters mpfs_mbox_inbox_isr().
> > 8. Linux has not submitted a request or installed its response pointer.
> > 9. The ISR dereferences that null pointer and faults near address 0x10.
>
> This makes sense, and should probably have a fixes tag pointing to my
> 2022 commit? Since I was direct kernel booting, I would never had
> noticed anything of this nature.

Agreed. I've split the NOTIFY fix into a separate patch, limited to
filtering completion interrupts.

>
> > Honor SERVICES_CR.NOTIFY, let IOSCB own the pending interrupt state,
> > and route the SYSREG acknowledgement through an IOSCB clear input.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> > ---
> >
> > (no changes since v1)
> >
> >  include/hw/misc/mchp_pfsoc_ioscb.h |  2 ++
> >  hw/misc/mchp_pfsoc_ioscb.c         | 39 +++++++++++++++++++++++++++---
> >  hw/misc/mchp_pfsoc_sysreg.c        |  9 ++++++-
> >  hw/riscv/microchip_pfsoc.c         |  6 ++---
> >  4 files changed, 49 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_=
pfsoc_ioscb.h
> > index fd31427304..e39d995b64 100644
> > --- a/include/hw/misc/mchp_pfsoc_ioscb.h
> > +++ b/include/hw/misc/mchp_pfsoc_ioscb.h
> > @@ -26,6 +26,7 @@
> >  #include "hw/core/sysbus.h"
> >
> >  #define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x1000
> > +#define MCHP_PFSOC_IOSCB_IRQ_CLEAR "irq-clear"
> >
> >  typedef struct MchpPfSoCIoscbState {
> >      SysBusDevice parent;
> > @@ -53,6 +54,7 @@ typedef struct MchpPfSoCIoscbState {
> >      uint32_t services_sr;
> >      uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
> >      char *serial_number;
> > +    bool irq_pending;
> >      qemu_irq irq;
> >  } MchpPfSoCIoscbState;
> >
> > diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> > index 7c82b55986..ccc2201b7a 100644
> > --- a/hw/misc/mchp_pfsoc_ioscb.c
> > +++ b/hw/misc/mchp_pfsoc_ioscb.c
> > @@ -192,12 +192,13 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_=
ddr_ops =3D {
> >
> >  #define SERVICES_CR                         0x50
> >  #define SERVICES_CR_REQUEST                 BIT(0)
> > +#define SERVICES_CR_NOTIFY                  BIT(3)
> >  #define SERVICES_CR_COMMAND_SHIFT           16
> >  #define SERVICES_CR_COMMAND_WIDTH           8
> >  #define SERVICES_CR_COMMAND_MASK            \
> >          MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND=
_WIDTH)
> >  #define SERVICES_CR_MASK                    \
> > -        (SERVICES_CR_REQUEST | SERVICES_CR_COMMAND_MASK)
> > +        (SERVICES_CR_REQUEST | SERVICES_CR_NOTIFY | SERVICES_CR_COMMAN=
D_MASK)
> >  #define SERVICES_SR                         0x54
> >  #define SERVICES_SR_STATUS_SHIFT            16
> >  #define SERVICES_COMMAND_SERIAL_NUMBER      0
> > @@ -205,6 +206,21 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_d=
dr_ops =3D {
> >  #define SERVICES_STATUS_FAILED              1
> >  #define SERVICES_MAILBOX_RESPONSE_OFFSET    0
> >
> > +static void mchp_pfsoc_ioscb_update_irq(MchpPfSoCIoscbState *s)
> > +{
> > +    qemu_set_irq(s->irq, s->irq_pending);
> > +}
> > +
> > +static void mchp_pfsoc_ioscb_clear_irq(void *opaque, int n, int level)
> > +{
> > +    MchpPfSoCIoscbState *s =3D opaque;
> > +
> > +    if (level) {
> > +        s->irq_pending =3D false;
> > +        mchp_pfsoc_ioscb_update_irq(s);
> > +    }
> > +}
> > +
> >  static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
> >  {
> >      uint32_t command;
> > @@ -236,7 +252,15 @@ static void services_cr_write(MchpPfSoCIoscbState =
*s, uint32_t value)
> >      }
> >
> >      s->services_sr =3D status << SERVICES_SR_STATUS_SHIFT;
> > -    qemu_irq_raise(s->irq);
> > +    /*
> > +     * HSS and U-Boot submit polling requests with REQUEST set and NOT=
IFY
> > +     * clear, then poll REQUEST/BUSY for completion. Linux sets both b=
its
> > +     * and expects completion through PLIC source 96.
> > +     */
> > +    if (value & SERVICES_CR_NOTIFY) {
> > +        s->irq_pending =3D true;
> > +        mchp_pfsoc_ioscb_update_irq(s);
> > +    }
> >  }
> >
> >  static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
> > @@ -325,7 +349,8 @@ static void mchp_pfsoc_ioscb_reset(DeviceState *dev=
)
> >      s->services_cr =3D 0;
> >      s->services_sr =3D 0;
> >      memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
> > -    qemu_irq_lower(s->irq);
> > +    s->irq_pending =3D false;
> > +    mchp_pfsoc_ioscb_update_irq(s);
> >  }
> >
> >  static const Property mchp_pfsoc_ioscb_properties[] =3D {
> > @@ -333,6 +358,13 @@ static const Property mchp_pfsoc_ioscb_properties[=
] =3D {
> >                         MchpPfSoCIoscbState, serial_number),
> >  };
> >
> > +static void mchp_pfsoc_ioscb_init(Object *obj)
> > +{
> > +    /* Accept service interrupt acknowledgements from SYSREG MESSAGE_I=
NT */
> > +    qdev_init_gpio_in_named(DEVICE(obj), mchp_pfsoc_ioscb_clear_irq,
> > +                            MCHP_PFSOC_IOSCB_IRQ_CLEAR, 1);
> > +}
> > +
> >  static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
> >  {
> >      MchpPfSoCIoscbState *s =3D MCHP_PFSOC_IOSCB(dev);
> > @@ -456,6 +488,7 @@ static const TypeInfo mchp_pfsoc_ioscb_info =3D {
> >      .name          =3D TYPE_MCHP_PFSOC_IOSCB,
> >      .parent        =3D TYPE_SYS_BUS_DEVICE,
> >      .instance_size =3D sizeof(MchpPfSoCIoscbState),
> > +    .instance_init =3D mchp_pfsoc_ioscb_init,
> >      .class_init    =3D mchp_pfsoc_ioscb_class_init,
> >  };
> >
> > diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
> > index 1d9154280a..899b485da6 100644
> > --- a/hw/misc/mchp_pfsoc_sysreg.c
> > +++ b/hw/misc/mchp_pfsoc_sysreg.c
> > @@ -77,7 +77,14 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hw=
addr offset,
> >          }
> >          break;
> >      case MESSAGE_INT:
> > -        qemu_irq_lower(s->irq);
> > +        /*
> > +         * A MESSAGE_INT write is an acknowledgement event, not a leve=
l that
> > +         * remains asserted. Model it as an active-high pulse. The ris=
ing edge
>
> I found this comment to be really confusing. Why would someone expect
> that a write-zero-clear bit is an asserted level? Mentioning modelling
> it as a pulse further makes it seem like software writing will generate a=
n
> interrupt, which it doesn't - it writes here to clear the interrupt. I
> think this needs to be very clear that modelling this as an interrupt at
> all is just being done for QEMU's sake.
>
> I think this needs to be split in two, with the fix for the problem
> (which I think is limited to only raising the interrupt) kept apart from
> this change. Part of that is because I don't actually understand the
> reason for adding this "fake" interrupt and the commit message is
> currently focused around the bug and doesn't actually provide
> justification for it. Maybe it's obvious to people more familiar with
> Qemu than I, but this complication makes no sense to me!

I used another way to implement this in v3. I dropped the
acknowledgement pulse and irq-clear GPIO. SYSREG now links to IOSCB
and calls its pending-bit getter/setter. IOSCB owns the pending state
and the PLIC output, so a write of zero directly clears the state and
lowers the real interrupt input. There is no extra interrupt for the
acknowledgement.

>
> > +         * invokes IOSCB's irq-clear input with level 1, which clears
> > +         * irq_pending and lowers PLIC source 96. The falling edge inv=
okes the
> > +         * input with level 0 and is ignored.
> > +         */
> > +        qemu_irq_pulse(s->irq);
> >          break;
> >      default:
> >          qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index fb0e18edba..87c9c89cb0 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -336,9 +336,6 @@ static void microchip_pfsoc_soc_realize(DeviceState=
 *dev, Error **errp)
> >      sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
> >      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
> >                      memmap[MICROCHIP_PFSOC_SYSREG].base);
> > -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
> > -                       qdev_get_gpio_in(DEVICE(s->plic),
> > -                       MICROCHIP_PFSOC_MAILBOX_IRQ));
> >
> >      /* AXISW */
> >      create_unimplemented_device("microchip.pfsoc.axisw",
> > @@ -492,6 +489,9 @@ static void microchip_pfsoc_soc_realize(DeviceState=
 *dev, Error **errp)
> >      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioscb), 0,
> >                         qdev_get_gpio_in(DEVICE(s->plic),
> >                         MICROCHIP_PFSOC_MAILBOX_IRQ));
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
> > +        qdev_get_gpio_in_named(DEVICE(&s->ioscb),
> > +                               MCHP_PFSOC_IOSCB_IRQ_CLEAR, 0));
> >
> >      /* FPGA Fabric */
> >      create_unimplemented_device("microchip.pfsoc.fabricfic3",
> > --

Regards,
Bin

