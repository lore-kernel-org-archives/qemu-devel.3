Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3555ACA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 15:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD1O6-0006uc-Pf; Sat, 03 Oct 2026 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xD1O5-0006uF-Td
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 11:10:57 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xD1O3-0002QA-Gw
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 11:10:57 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ace0741488so3787627b3.3
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 08:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791040254; cv=none;
 d=google.com; s=arc-20260327;
 b=rRyzl8nQYx6bT2vT7YJhBg7mKJAQEdjA4pbLlo9wSupGvmC1CnySOqANbS1AuSCIvx
 M13m7B+2KI8SCMKgc8NUd7o8xf+zx9pgeuOVbHTrHwCLHbo1A0jwdziDLPIapw6gDqGA
 3eBUa3xa/cGOW0NnDsjmw36oBsaPF3Ut/A0YtkgmYsILCPMI4Yz8p8DygB6RbYWLozJw
 ARcsMBtY3i3k9j5NNfL7oo6zbRzcGXnEn5pufUcpbMFIAK5Nj5mrdEh9lWclAsZEwpmj
 xcHzz+Gsj5vR+eLdXa/E+XT7K4UqpTD7YVdIec2SlyEy4Zbbgj22IRtgTOiYCnMrmCKe
 /41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=daO0yXKPBZz3BYw1XTIfJ1cQU3kkWirfCZRbL0ph5x4=;
 fh=P2gprTXCsmT1LMghIdcG6Nx8q0W1RwZFl3iYGMtC0FQ=;
 b=ROY6a8f4L6REpuJteeAglZ/hhTogjpldSb2gMuEvSWfhUI7n8wcwAt1vF8yR2tJf/o
 Gg4Ww8ns9Y1BiEj9sHjm8AcDC50xfZDbs/mmJLRfueMteNCmA0XjvkSNe4mj2P3WhuyT
 oT/4kOGZNTw5w4YyQBuOv0IbLgpnx25HP32z7NKltoE4m4LGWl5JBOtKF1lHB7zvUCyW
 z7xnpuy4xTtJPqChbIRNzKkJKeaCk5z0p4wDy5KR1rdytWLL5c/S9jARiLLPyApIOVsK
 2LzkuesZ9UGp35QuF2Tcpq6rSyXwxTF7RiUJpSJgGkFflHrobQ7qDtdbEXQPshOWrKs8
 7s6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791040254; x=1791645054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=daO0yXKPBZz3BYw1XTIfJ1cQU3kkWirfCZRbL0ph5x4=;
 b=UwCsl1WzGOLMN8g6DMCUij8FudlrugmSuCQS3QZEMO1T21QWqZiH6L8h7tIs641v3J
 00RDKTbnNohvHkBJ7Hq7bslE1F+ZDJ3fi7UEbomh3hYXQ13d2zbsipMcfeV8oWd566qF
 32Q0AXNlDe4fcuYLlN1/u+FfxiGXpBD3P0hHyJraxkf1i/TX2B71r8UmkhgOfSusKQex
 itlCRW+Mk4d2T7LQJGHzWWq2Bt2q2cSjxjAA34Cjhb6y4eZUP+Gmafg2eOBLCyX4N4CE
 BBaMeUJFvlgIiqAP6VhMBYPtdekDuyQOiq9lXD17CwX0OgxoT+xkzkNRHZR5NiieRWL4
 PhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791040254; x=1791645054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=daO0yXKPBZz3BYw1XTIfJ1cQU3kkWirfCZRbL0ph5x4=;
 b=SznZI3u2j9LvwSkTzhv0XgMBGLY0+ay5CNfMPTvUOEl8oLMGXq1YJEmdsvy8ZTDC/J
 gz5zVTl72azLLphywUXVWjHO5y/CP3juIU1v7RuLzUhuO2uSggGM/T9KuForvPzT0q4O
 Myn6gy5Rcp/jERuZ9wexVo7Yhiow/XndA9OHQO+u01uwrCR4oJpoSgtKvojEjfEl0fZs
 N+Huj+xdpiWLNTVI0wff4Sj3i714yMQoGn9FPcwOXrTTOPAqRP4Y3fI7NbzJFXlFkRai
 I7Us2MoTHzEvepbWEPaUdgkhsk/fuaXzBEHzxGQtmFU2SkI3HYBOyhTt0TXwgRKukB8o
 WqIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzooj9OVj0gfws61fHS25vgG5qWkHOeNFHShm+vgVC4XZxzivkmaBE97m7H4HdWIB1Erj1vhvw5Sd1L@nongnu.org
X-Gm-Message-State: AFq9FYIrbYCxdj3u1Kq5UJGj3tWXOg2U5Zr87t/Ej6VlXEvqxnjYf060
 krwSujT9JSMSEaVGl5yorHgx2B/YkoGZeQPLKxs3P/iiGAu6E+9dYCsNFZpv5w61SItDrRUmoVf
 kfkCVeeu95bRaJhyvh1ec7JdHB4d+Bl4=
X-Gm-Gg: AYBFou0IV2EcCpCvwmNH6DEpZ1vzrx1Z5meSJtABJ+NWBPua1pPZ0vo+7uFd92R54Df
 hYz+sbcLLYKnfeW0JKPd6OOsLGXwLIKFSH9cuLbEamCx8mj2UPd2e3VmiAaYtH6DZri4n52V4C2
 8LUHBOh728jLiI2FvBgS7P2Po5M5TPr7f5LmsKRjaCrlAGD+RjE3Tnun/60GFVqjKeOgkHevU5J
 s21UJLZiBbu1c8ECnKIZSnHNsXNhLmwWLJzEy99Zqi0vMH8l6mRr/5DcMzDb5wtRd1fcSemSNPP
 yEHjiiJx8tgElzar3sGUSDpOvTjmyNyHZUb4LhmwxXJRI/LnKdu9zZYzYl5dNU7N1UBffd/gB2t
 fRxgKUdkwKDQprw==
X-Received: by 2002:a05:690c:e1c9:10b0:872:1e2e:b4c5 with SMTP id
 00721157ae682-8ae951f63c3mr6388517b3.18.1791040254091; Sat, 03 Oct 2026
 08:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-13-bin.meng@processmission.com>
 <20260930-attitude-dragging-9c89c9c27c5b@wendy>
In-Reply-To: <20260930-attitude-dragging-9c89c9c27c5b@wendy>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 3 Oct 2026 23:10:42 +0800
X-Gm-Features: AclHuK-TkPdTZmamBpQVx-2klP8x7hqaeBtXqy3ZBQMHeqirYiAys6k_1EJoHd4
Message-ID: <CAEUhbmWKQ0Hky_jMWV7W_BgsQ0TX-uu-O80+UjOnZE3y1EKd8g@mail.gmail.com>
Subject: Re: [PATCH v2 12/24] hw/misc: pfsoc: Model PolarFire SoC serial
 number service
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 qemu-riscv@nongnu.org
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

Hi Conor,

On Wed, Sep 30, 2026 at 4:37=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, Sep 04, 2026 at 11:57:31PM +0800, Bin Meng wrote:
> > U-Boot requests the PolarFire SoC device serial number during board
> > late initialization. The IOSCB previously rejected every request, so
>
> This is kinda crazy actually, we probably should change u-boot to not do
> this since the reason for acquiring the serial number is populating the
> mac address.
> I guess it just never actually ever is problematic in hardware, but it
> does seem a bit mad to reject boot over.

Will prepare a U-Boot patch to correct this upstream.

>
> > board setup could not complete.
> >
> > Model the System Services control registers and byte-addressable
> > mailbox. Obtain the 128-bit serial number from an optional device
> > property, using a deterministic value when it is not configured.
> > Return an explicit failure for unsupported services and reset the new
> > runtime state with the rest of the device.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > ---
> >
> > (no changes since v1)
> >
> >  include/hw/misc/mchp_pfsoc_ioscb.h |   6 ++
> >  hw/misc/mchp_pfsoc_ioscb.c         | 141 +++++++++++++++++++++++++----
> >  2 files changed, 130 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_=
pfsoc_ioscb.h
> > index 9687ea25b1..fd31427304 100644
> > --- a/include/hw/misc/mchp_pfsoc_ioscb.h
> > +++ b/include/hw/misc/mchp_pfsoc_ioscb.h
> > @@ -25,6 +25,8 @@
> >
> >  #include "hw/core/sysbus.h"
> >
> > +#define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x1000
> > +
> >  typedef struct MchpPfSoCIoscbState {
> >      SysBusDevice parent;
> >      MemoryRegion container;
> > @@ -47,6 +49,10 @@ typedef struct MchpPfSoCIoscbState {
> >      MemoryRegion cfm_sgmii;
> >      MemoryRegion bc_sgmii;
> >      MemoryRegion io_calib_sgmii;
> > +    uint32_t services_cr;
> > +    uint32_t services_sr;
> > +    uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
> > +    char *serial_number;
> >      qemu_irq irq;
> >  } MchpPfSoCIoscbState;
> >
> > diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> > index 09b702e520..7c82b55986 100644
> > --- a/hw/misc/mchp_pfsoc_ioscb.c
> > +++ b/hw/misc/mchp_pfsoc_ioscb.c
> > @@ -25,6 +25,7 @@
> >  #include "qemu/log.h"
> >  #include "qapi/error.h"
> >  #include "hw/core/irq.h"
> > +#include "hw/core/qdev-properties.h"
> >  #include "hw/core/sysbus.h"
> >  #include "hw/misc/mchp_pfsoc_ioscb.h"
> >
> > @@ -37,6 +38,9 @@
> >  #define IOSCB_CCC_REG_SIZE          0x2000000
> >  #define IOSCB_CTRL_REG_SIZE         0x800
> >  #define IOSCB_QSPIXIP_REG_SIZE      0x200
> > +#define IOSCB_SERIAL_NUMBER_SIZE    16U
> > +#define IOSCB_DEFAULT_SERIAL_NUMBER "0123456789abcdef"
> > +#define IOSCB_PROP_SERIAL_NUMBER    "serial-number"
> >
> >
> >  /*
> > @@ -186,33 +190,71 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_=
ddr_ops =3D {
> >      .endianness =3D DEVICE_LITTLE_ENDIAN,
> >  };
> >
> > -#define SERVICES_CR             0x50
> > -#define SERVICES_SR             0x54
> > -#define SERVICES_STATUS_SHIFT   16
> > +#define SERVICES_CR                         0x50
> > +#define SERVICES_CR_REQUEST                 BIT(0)
> > +#define SERVICES_CR_COMMAND_SHIFT           16
> > +#define SERVICES_CR_COMMAND_WIDTH           8
>
> This I think should actually be 7.

Will fix in v3.

>
> > +#define SERVICES_CR_COMMAND_MASK            \
> > +        MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND=
_WIDTH)
> > +#define SERVICES_CR_MASK                    \
> > +        (SERVICES_CR_REQUEST | SERVICES_CR_COMMAND_MASK)
> > +#define SERVICES_SR                         0x54
> > +#define SERVICES_SR_STATUS_SHIFT            16
> > +#define SERVICES_COMMAND_SERIAL_NUMBER      0
> > +#define SERVICES_STATUS_SUCCESS             0
> > +#define SERVICES_STATUS_FAILED              1
> > +#define SERVICES_MAILBOX_RESPONSE_OFFSET    0
> > +
> > +static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
> > +{
> > +    uint32_t command;
> > +    uint32_t status =3D SERVICES_STATUS_FAILED;
> > +
> > +    if (device_is_in_reset(DEVICE(s)) ||
> > +        !(value & SERVICES_CR_REQUEST)) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * System services complete synchronously in this model, so clear =
the
> > +     * request bit before exposing the response to the guest.
> > +     */
> > +    s->services_cr &=3D ~SERVICES_CR_REQUEST;
> > +
> > +    command =3D (value & SERVICES_CR_COMMAND_MASK) >>
> > +              SERVICES_CR_COMMAND_SHIFT;
> > +    if (command =3D=3D SERVICES_COMMAND_SERIAL_NUMBER) {
> > +        /*
> > +         * The serial-number service returns a 128-bit response starti=
ng at
> > +         * the beginning of the mailbox.
>
> That's not actually strictly true, bits 15:7 of the command actually
> determine the location in the mailbox. I'm not actually aware of any user=
s
> of this feature, Linux and U-Boot both leave this at 0, so it doesn't rea=
lly
> matter for functionality, but the comment is wrong.
> See section 3 of the document in the comment you're removing below for
> how this works.

Will fix the comment in v3.

>
> > +         */
> > +        memset(&s->mailbox_data[SERVICES_MAILBOX_RESPONSE_OFFSET], 0,
> > +               IOSCB_SERIAL_NUMBER_SIZE);
> > +        memcpy(&s->mailbox_data[SERVICES_MAILBOX_RESPONSE_OFFSET],
> > +               s->serial_number, strlen(s->serial_number));
> > +        status =3D SERVICES_STATUS_SUCCESS;
> > +    }
> > +
> > +    s->services_sr =3D status << SERVICES_SR_STATUS_SHIFT;
> > +    qemu_irq_raise(s->irq);
> > +}
> >
> >  static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
> >                                       unsigned size)
> >  {
> > -    uint32_t val =3D 0;
> > +    MchpPfSoCIoscbState *s =3D opaque;
> >
> >      switch (offset) {
> > +    case SERVICES_CR:
> > +        return s->services_cr;
> >      case SERVICES_SR:
> > -        /*
> > -         * Although some services have no error codes, most do. All se=
rvices
> > -         * that do implement errors, begin their error codes at 1. Tre=
at all
> > -         * service requests as failures & return 1.
> > -         * See the "PolarFire=C2=AE FPGA and PolarFire SoC FPGA System=
 Services"
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^
>
> > -         * user guide for more information on service error codes.
> > -         */
> > -        val =3D 1u << SERVICES_STATUS_SHIFT;
> > -        break;
> > +        return s->services_sr;
> >      default:
> >          qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
> >                        "(size %d, offset 0x%" HWADDR_PRIx ")\n",
> >                        __func__, size, offset);
> > +        return 0;
> >      }
> > -
> > -    return val;
> >  }
> >
> >  static void mchp_pfsoc_ctrl_write(void *opaque, hwaddr offset,
> > @@ -222,13 +264,17 @@ static void mchp_pfsoc_ctrl_write(void *opaque, h=
waddr offset,
> >
> >      switch (offset) {
> >      case SERVICES_CR:
> > -        qemu_irq_raise(s->irq);
> > +        s->services_cr =3D value & SERVICES_CR_MASK;
> > +        services_cr_write(s, value);
> > +        break;
> > +    case SERVICES_SR:
> >          break;
> >      default:
> >          qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> >                        "(size %d, value 0x%" PRIx64
> >                        ", offset 0x%" HWADDR_PRIx ")\n",
> >                        __func__, size, value, offset);
> > +        break;
> >      }
> >  }
> >
> > @@ -236,6 +282,55 @@ static const MemoryRegionOps mchp_pfsoc_ctrl_ops =
=3D {
> >      .read =3D mchp_pfsoc_ctrl_read,
> >      .write =3D mchp_pfsoc_ctrl_write,
> >      .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D sizeof(uint32_t),
>
> I'm not au fait enough with qemu to know, but does this mean that
> accessing these registers with an 8 or 16 bit accessor will fail
> somehow?
> If so, that's not how the hardware behaves, and below...

This was added during debugging. Checked the doc and found no clear
clue about the access limitation. Testing showed that dropping these
does not prevent the firmware from booting. Will drop this in v3.

>
> > +        .max_access_size =3D sizeof(uint32_t),
> > +    },
> > +};
> > +
> > +/*
> > + * The System Controller uses the mailbox as a byte-addressable shared=
 buffer
> > + * for service command payloads and responses.
> > + */
> > +static uint64_t mchp_pfsoc_mailbox_read(void *opaque, hwaddr offset,
> > +                                        unsigned size)
> > +{
> > +    MchpPfSoCIoscbState *s =3D opaque;
> > +
> > +    return ldn_le_p(&s->mailbox_data[offset], size);
> > +}
> > +
> > +static void mchp_pfsoc_mailbox_write(void *opaque, hwaddr offset,
> > +                                     uint64_t value, unsigned size)
> > +{
> > +    MchpPfSoCIoscbState *s =3D opaque;
> > +
> > +    stn_le_p(&s->mailbox_data[offset], size, value);
> > +}
> > +
> > +static const MemoryRegionOps mchp_pfsoc_mailbox_ops =3D {
> > +    .read =3D mchp_pfsoc_mailbox_read,
> > +    .write =3D mchp_pfsoc_mailbox_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D sizeof(uint8_t),
>
> ...you have the more expected 8.
>
> > +        .max_access_size =3D sizeof(uint32_t),
> > +    },
> > +};
> > +
> > +static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
> > +{
> > +    MchpPfSoCIoscbState *s =3D MCHP_PFSOC_IOSCB(dev);
> > +
> > +    s->services_cr =3D 0;
> > +    s->services_sr =3D 0;
> > +    memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
> > +    qemu_irq_lower(s->irq);
> > +}
> > +
> > +static const Property mchp_pfsoc_ioscb_properties[] =3D {
> > +    DEFINE_PROP_STRING(IOSCB_PROP_SERIAL_NUMBER,
> > +                       MchpPfSoCIoscbState, serial_number),
> >  };
> >
> >  static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
> > @@ -243,6 +338,16 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *=
dev, Error **errp)
> >      MchpPfSoCIoscbState *s =3D MCHP_PFSOC_IOSCB(dev);
> >      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> >
> > +    /* Use a deterministic identity when no serial number is configure=
d */
> > +    if (!s->serial_number) {
> > +        s->serial_number =3D g_strdup(IOSCB_DEFAULT_SERIAL_NUMBER);
> > +    }
> > +    if (strlen(s->serial_number) > IOSCB_SERIAL_NUMBER_SIZE) {
> > +        error_setg(errp, "The serial number can't be longer than %u by=
tes",
> > +                   IOSCB_SERIAL_NUMBER_SIZE);
> > +        return;
> > +    }
> > +
> >      memory_region_init(&s->container, OBJECT(s),
> >                         "mchp.pfsoc.ioscb", IOSCB_WHOLE_REG_SIZE);
> >      sysbus_init_mmio(sbd, &s->container);
> > @@ -265,7 +370,7 @@ static void mchp_pfsoc_ioscb_realize(DeviceState *d=
ev, Error **errp)
> >                            "mchp.pfsoc.ioscb.qspixip", IOSCB_QSPIXIP_RE=
G_SIZE);
> >      memory_region_add_subregion(&s->container, IOSCB_QSPIXIP_BASE, &s-=
>qspixip);
> >
> > -    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_dummy_op=
s, s,
> > +    memory_region_init_io(&s->mailbox, OBJECT(s), &mchp_pfsoc_mailbox_=
ops, s,
> >                            "mchp.pfsoc.ioscb.mailbox", IOSCB_SUBMOD_REG=
_SIZE);
> >      memory_region_add_subregion(&s->container, IOSCB_MAILBOX_BASE, &s-=
>mailbox);
> >
> > @@ -343,6 +448,8 @@ static void mchp_pfsoc_ioscb_class_init(ObjectClass=
 *klass, const void *data)
> >
> >      dc->desc =3D "Microchip PolarFire SoC IOSCB modules";
> >      dc->realize =3D mchp_pfsoc_ioscb_realize;
> > +    device_class_set_legacy_reset(dc, mchp_pfsoc_ioscb_reset);
> > +    device_class_set_props(dc, mchp_pfsoc_ioscb_properties);
> >  }
> >
> >  static const TypeInfo mchp_pfsoc_ioscb_info =3D {
> > --

Regards,
Bin

