Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7357EF43683
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgLV-0001AE-SW; Fri, 17 Apr 2026 06:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rafettaskindev@gmail.com>)
 id 1wDgLU-0001A4-3V
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:22:44 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rafettaskindev@gmail.com>)
 id 1wDgLR-0002pk-Aq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:22:43 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-408778a8ec4so392620fac.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776421360; cv=none;
 d=google.com; s=arc-20240605;
 b=EOULLb9BouDFwXtTmXP8VE8NgCenVMQQ3clnU1I3GmkdLKGjDvNLvomE2sHrnZ5Xro
 6cafFwh64qMmMhSS3DwuMYxJ5hc9q9RNtW0QEgPnvgB86w3iBxGJQkD9/kHq9ldioDWo
 aLjikp2HJBTo+MM5Al3CXfwi9EUOoKL04qL6QAeoSBDfBDh3LcgYdJcNSicB88AlITAL
 t7xxVXvsyxUR9Sek34WdCJGS+/WLSqOOV5LmgaReRl7f73A1L355+Y7QMs+AnA7EgXOF
 Crn2XyhUuLKOztzj4VD5MZk1DdW6GHAUPaOUiw2AYyNCSGIh8Txa3laL0dimTgI/GZi0
 ldRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3Qn45T0k+P9EBe9g4rByzcp1WsAiBtsKt7OEEwOyfKw=;
 fh=hmcxiVGayiYta/WILi0xucvuFOa8fgzSAUgugfqkmgM=;
 b=U3pRDLoysbAx43CXOoYKeB1Brg65CTSi+ttDLgA1Os8gRbuZtY3xPUQecnhSD7uSHs
 8CU+KJcG+12N4sTwjiCZkPyYZFH4yNiZkQK7GdbNvxR2cizLlqBbvIm8yUmNJThfkIj6
 9I8Wi+TK5Ng072+cJX4lrAvGzjkvjV/erN9yCXri8Ycx3vQMc/l5ARqc/pnD9ZCMPRuq
 g3FvO9KRYWBKWsAm8OPosmTpFlM7TBC/iOTQn9EQqBSmIiZ2yInKalvKjUGZGp0QhYg7
 L06WYCqOvTJNlsy4qUGVmUOC+IEX5DlvAkNMEfq2lFwI8IRZ5SgvAxHNJVEeQZVKsVNN
 leXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776421360; x=1777026160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Qn45T0k+P9EBe9g4rByzcp1WsAiBtsKt7OEEwOyfKw=;
 b=gJ3AztOOJ2zntYsuES9aCH8RnUx+bjjOa36fNmBbFQMx5KKEOHUBgMMABRJW+ly9ca
 2bRbT43aCllxTREBGGwC3dVNN0AmUoVNNMhWZCAO5708zpmD5fT/XQo/aMXrMq49QhMM
 6JGj6Slsp67QxkVUkqF+MlfMzTn6E2RaJp+Ab/7Bhp4tyKqZtISJqyVJs7wkG3OJuYgc
 L1TM/Ay4WseAdEtCGPszt+BK22RsAvIB9asqeZC9QfHsPiZhfZadlWJkpQzZTba1/Ugb
 HGsucNEuVCiu9gAZgJC4SYYvSkXOSptv1TaN6g/kWuukYU+1+yUMUUOlWs7hcTt+JAz/
 OPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776421360; x=1777026160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Qn45T0k+P9EBe9g4rByzcp1WsAiBtsKt7OEEwOyfKw=;
 b=Xk2CVdrlOAXz3lLQE9fiIgUaxB42wV+/Ox3nK0U/SbpcmzPB3QQKrMCKoI5xABdMtf
 icTvYPebXN2Dr9IxYC3MbuyS0mqSL0MdaI4TPsDd4psi5lmKicI4KuCplyiT0dyOgR3q
 Pgts4xQDE61IKURtCXv8J1NxxHmMLIbl0w5T7t+xByR7bjVBg8R+JoDttAGQhKHbysYg
 MNJAAXBn8fXYGINXRZvEwU1MTJ1HLR4G6lVVN4foNaoNRkjUGifhviTzQ5L22HyhloEf
 slKNgezo5+deRH1oDgxGNeirSQRCl+4Jc+g8mR70VCMRiq3hBKGMv+GTm1ps6z32TXeA
 /0pQ==
X-Gm-Message-State: AOJu0Yzu4Sv7VX4bEVxRZmIExt2hOjmA1FJM5k2bVCApWXsXxHSBKemQ
 LDAhOAXG2ahyt3BNhnRG9vXUbkTIwUAiA1H4hsf2sSm2+/0TeNtYUZyk1sVskhOvsMC0fP/+L/h
 ZRdZ6ZytXakzm04SUKs3jLvRr4xpSZFg=
X-Gm-Gg: AeBDievZ5xIodAfqzQsCOAhfZAgURguARSQje612K/06HKcfpPguLRlACVAV08q1Qbr
 pdKYbNm4Ei/EmLbsXLbW/hNnJrJgB5lXWp2e94aazSo1yoEcfyy+4+31qrnMYXgNQGTtcyXY0Rz
 HcpkXHkjHtsVyY2Yo1T8LcLPdwKEAhHWvPnXQHbCMoLxi1LJHM3PvtWvgP9yCgE9lfpOb0C+Bzu
 ZBvkVxYJN+7ufGDXdMUBQ4qCxMod4QruIxMbb5PNhjAS1tvelzWH0FFD2YlRZ8dQKf4DAT0gr5i
 7wve7U7vgswq8BJ8tM49
X-Received: by 2002:a05:6871:d216:b0:417:22c9:a311 with SMTP id
 586e51a60fabf-42abf220077mr1089589fac.6.1776421359880; Fri, 17 Apr 2026
 03:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260416183540.142727-1-rafettaskindev@gmail.com>
 <aeIED0hn1vC9NpZH@redhat.com>
In-Reply-To: <aeIED0hn1vC9NpZH@redhat.com>
From: Rafet T <rafettaskindev@gmail.com>
Date: Fri, 17 Apr 2026 13:22:28 +0300
X-Gm-Features: AQROBzAx0M4qc5HPZo3W9OT_vc6DJBdLprCHHpNCQEqbCFhz1ffeV-Uqpzt64iY
Message-ID: <CA+JCratnMOAzjXPcHAGUco50WWXSrHHCzZPnnQEUkU7k-m2VDw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/scsi: Add SCSI tape device emulation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net
Content-Type: multipart/alternative; boundary="000000000000208eb0064fa554ae"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=rafettaskindev@gmail.com; helo=mail-oa1-x31.google.com
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

--000000000000208eb0064fa554ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

I would like to continue but Helge said only choosen applicant should work
on this. (
https://lore.kernel.org/qemu-devel/aeEicSrfbE2sZo8w@redhat.com/T/#t)

With regards,
Rafet


On Fri, Apr 17, 2026, 12:57 Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:

> On Thu, Apr 16, 2026 at 09:35:40PM +0300, rft0 wrote:
> > Add initial emulation of SCSI tape device supporting basic
> > INQUIRY operation for now.
> >
> > Signed-off-by: rft0 <rafettaskindev@gmail.com>
> > ---
> > Second patch:
> >  - Add kconfig entry
> >  - Validate vendor, product, version, serial lengths
> >
> >  hw/scsi/Kconfig     |   5 +
> >  hw/scsi/meson.build |   1 +
> >  hw/scsi/scsi-tape.c | 349 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 355 insertions(+)
> >  create mode 100644 hw/scsi/scsi-tape.c
> >
> > diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> > index 5743ee9b4d..06e7cab178 100644
> > --- a/hw/scsi/Kconfig
> > +++ b/hw/scsi/Kconfig
> > @@ -1,6 +1,11 @@
> >  config SCSI
> >      bool
> >
> > +config SCSI_TAPE
> > +    bool
> > +    default y
> > +    depends on SCSI
> > +
> >  config LSI_SCSI_PCI
> >      bool
> >      default y if PCI_DEVICES
> > diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
> > index 69fde0cf84..1c62115d8e 100644
> > --- a/hw/scsi/meson.build
> > +++ b/hw/scsi/meson.build
> > @@ -8,6 +8,7 @@ scsi_ss.add(files(
> >    'scsi-disk.c',
> >    'scsi-generic.c',
> >  ))
> > +scsi_ss.add(when: 'CONFIG_SCSI_TAPE', if_true: files('scsi-tape.c'))
> >  scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
> >  scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
> >  scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'=
))
> > diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c
> > new file mode 100644
> > index 0000000000..adbae9b4ad
> > --- /dev/null
> > +++ b/hw/scsi/scsi-tape.c
> > @@ -0,0 +1,349 @@
> > +/*
> > + * SCSI Tape Device emulation
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * Written by Rafet Taskin <rafettaskindev@gmail.com>
> > + *
> > + * SCSI Tape device emulation.
> > + *
> > + */
> > +
> > +#include "qemu/hw-version.h"
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +#include "qemu/memalign.h"
> > +#include "qemu/cutils.h"
> > +#include "hw/scsi/scsi.h"
> > +#include "scsi/constants.h"
> > +#include "system/block-backend.h"
> > +#include "hw/block/block.h"
> > +#include "hw/core/qdev-properties.h"
> > +#include "hw/core/qdev-properties-system.h"
> > +#include "qom/object.h"
> > +
> > +#define SCSI_MAX_INQUIRY_LEN    256
> > +
> > +#define MAX_SERIAL_LEN 36
>
> This doesn't appear to be used - the value is just
> hardcoded at time of use. Can we use that, and also
> add constants for the max product, vendor and
> version fields, since those magic constants are
> used several times over
>
>
> > +static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbu=
f)
> > +{
> > +    SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, req->dev);
> > +    uint8_t page_code =3D req->cmd.buf[2];
> > +
> > +    outbuf[0] =3D TYPE_TAPE;
> > +    outbuf[1] =3D page_code;
> > +    outbuf[2] =3D 0x00;
> > +    outbuf[3] =3D 0x00;
> > +
> > +    switch (page_code) {
> > +    case 0x00: /* Supported VPD pages */
> > +        outbuf[4] =3D 0x00;   /* page 0x00 (this page) */
> > +        if (s->serial) {
> > +            outbuf[5] =3D 0x80;   /* page 0x80 (serial number) */
> > +            outbuf[3] =3D 2;      /* page data length */
> > +            return 6;
> > +        }
> > +        outbuf[3] =3D 1;
> > +        return 5;
> > +
> > +    case 0x80: /* Unit Serial Number */
> > +        if (!s->serial) {
> > +            return -1;   /* not supported, caller sends INVALID_FIELD =
*/
> > +        }
> > +        {
> > +            int l =3D strlen(s->serial);
> > +            outbuf[3] =3D l;
> > +            memcpy(&outbuf[4], s->serial, l);
>
> strpadcpy is probably a better idea, as this leaves the tail of
> the buffer uninitialized and does not include a NUL terminator.
> Even if the caller has initialized the buffer with nuls, it is
> more reassuring to reviewers if we explicitly pad here.
>
> Use  MAX_SERIAL_LEN here too with strpadcpy
>
> > +            return 4 + l;
> > +        }
> > +
> > +    default:
> > +        return -1;  /* unsupported VPD page */
> > +    }
> > +}
> > +
> > +static int scsi_tape_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf=
)
> > +{
> > +    SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, req->dev);
> > +    int buflen;
> > +
> > +    if (req->cmd.buf[1] & 0x1) {
> > +        return scsi_disk_emulate_vpd_page(req, outbuf);
> > +    }
> > +
> > +    /* Standard INQUIRY, not a VPD request */
> > +    if (req->cmd.buf[2] !=3D 0) {
> > +        return -1;
> > +    }
> > +
> > +    /* PAGE_CODE =3D=3D 0 */
> > +    buflen =3D req->cmd.xfer;
> > +    if (buflen > SCSI_MAX_INQUIRY_LEN) {
> > +        buflen =3D SCSI_MAX_INQUIRY_LEN;
> > +    }
> > +
> > +    outbuf[0] =3D TYPE_TAPE;      /* 0x01 =3D Tape */
> > +    outbuf[1] =3D 0x80;           /* Always removable */
> > +    outbuf[2] =3D 0x05;           /* SPC-3 */
> > +    outbuf[3] =3D 0x02 | 0x10;    /* Format 2, HiSup */
> > +
> > +    if (buflen > 36) {
> > +        outbuf[4] =3D buflen - 5;
> > +    } else {
> > +        outbuf[4] =3D 36 - 5;
> > +    }
> > +
> > +    outbuf[7] =3D 0x10 | (req->bus->info->tcq ? 0x02 : 0);
> > +
> > +    strpadcpy((char *)&outbuf[16], 16, s->product, ' ');
> > +    strpadcpy((char *)&outbuf[8], 8, s->vendor, ' ');
>
> The 2nd arg here can use MAX_VENDOR_LEN / MAX_PRODUCT_LEN
>
> > +
> > +    memset(&outbuf[32], 0, 4);
> > +    memcpy(&outbuf[32], s->version, MIN(4, strlen(s->version)));
>
> Why not use strpadcpy like the two lines above. Also MAX_VERSION_LEN
> constant would be wise.
>
> > +
> > +    return buflen;
> > +}
>
> > +static void scsi_tape_realize(SCSIDevice *dev, Error **errp)
> > +{
> > +    SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, dev);
> > +
> > +    dev->type =3D TYPE_TAPE;
> > +
> > +    if (!s->qdev.conf.blk) {
> > +        error_setg(errp, "Drive property not set");
> > +        return;
> > +    }
> > +
> > +    if (!blk_is_inserted(s->qdev.conf.blk)) {
> > +        error_setg(errp, "Device needs media, but drive is empty");
> > +        return;
> > +    }
> > +
> > +    if (!s->vendor) {
> > +        s->vendor =3D g_strdup("QEMU");
> > +    } else if (strlen(s->vendor) > 8) {
> > +        error_setg(errp, "Vendor must be 8 characters at most");
> > +        return;
> > +    }
>
> Get rid of the "else" here and in the checks below - we want
> to sanity check that the static constant is not oversized too,
> especially for QEMU_HW_VERSION. Also use the constants for max
> length and include the string in the error message . IOW more
> like this code:
>
>     if (!s->vendor) {
>         s->vendor =3D g_strdup("QEMU");
>     }
>     if (strlen(s->vendor) > MAX_VENDOR_LEN) {
>         error_setg(errp, "Vendor '%s' must be %d characters at most",
>                    s->vendor, MAX_VENDOR_LEN);
>         return;
>     }
>
>
>
>
> > +    if (!s->product) {
> > +        s->product =3D g_strdup("QEMU TAPE");
> > +    } else if (strlen(s->product) > 16) {
> > +        error_setg(errp, "Product must be 16 characters at most");
> > +        return;
> > +    }
> > +
> > +    if (!s->version) {
> > +        s->version =3D g_strdup(QEMU_HW_VERSION);
> > +    } else if (strlen(s->version) > 4) {
> > +        error_setg(errp, "Version must be 4 characters at most");
> > +        return;
> > +    }
> > +
> > +    if (s->serial && strlen(s->serial) > 36) {
> > +        error_setg(errp, "Serial must be 36 characters at most");
> > +        return;
> > +    }
> > +}
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000208eb0064fa554ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Daniel,<div dir=3D"auto"><br></div><div dir=3D"auto=
">I would like to continue but Helge said only choosen applicant should wor=
k on this. (<a href=3D"https://lore.kernel.org/qemu-devel/aeEicSrfbE2sZo8w@=
redhat.com/T/#t">https://lore.kernel.org/qemu-devel/aeEicSrfbE2sZo8w@redhat=
.com/T/#t</a>)</div><div dir=3D"auto"><br></div><div dir=3D"auto">With rega=
rds,</div><div dir=3D"auto">Rafet</div><br><br><div class=3D"gmail_quote" d=
ir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 17, 2026, 12:=
57 Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On Thu, Apr 16, 2026 at 09:35:40PM +0300, r=
ft0 wrote:<br>
&gt; Add initial emulation of SCSI tape device supporting basic<br>
&gt; INQUIRY operation for now.<br>
&gt; <br>
&gt; Signed-off-by: rft0 &lt;<a href=3D"mailto:rafettaskindev@gmail.com" re=
l=3D"noreferrer noreferrer" target=3D"_blank">rafettaskindev@gmail.com</a>&=
gt;<br>
&gt; ---<br>
&gt; Second patch:<br>
&gt;=C2=A0 - Add kconfig entry<br>
&gt;=C2=A0 - Validate vendor, product, version, serial lengths<br>
&gt; <br>
&gt;=C2=A0 hw/scsi/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 hw/scsi/meson.build |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/scsi/scsi-tape.c | 349 ++++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 3 files changed, 355 insertions(+)<br>
&gt;=C2=A0 create mode 100644 hw/scsi/scsi-tape.c<br>
&gt; <br>
&gt; diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig<br>
&gt; index 5743ee9b4d..06e7cab178 100644<br>
&gt; --- a/hw/scsi/Kconfig<br>
&gt; +++ b/hw/scsi/Kconfig<br>
&gt; @@ -1,6 +1,11 @@<br>
&gt;=C2=A0 config SCSI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 <br>
&gt; +config SCSI_TAPE<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 default y<br>
&gt; +=C2=A0 =C2=A0 depends on SCSI<br>
&gt; +<br>
&gt;=C2=A0 config LSI_SCSI_PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default y if PCI_DEVICES<br>
&gt; diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build<br>
&gt; index 69fde0cf84..1c62115d8e 100644<br>
&gt; --- a/hw/scsi/meson.build<br>
&gt; +++ b/hw/scsi/meson.build<br>
&gt; @@ -8,6 +8,7 @@ scsi_ss.add(files(<br>
&gt;=C2=A0 =C2=A0 &#39;scsi-disk.c&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;scsi-generic.c&#39;,<br>
&gt;=C2=A0 ))<br>
&gt; +scsi_ss.add(when: &#39;CONFIG_SCSI_TAPE&#39;, if_true: files(&#39;scs=
i-tape.c&#39;))<br>
&gt;=C2=A0 scsi_ss.add(when: &#39;CONFIG_ESP&#39;, if_true: files(&#39;esp.=
c&#39;))<br>
&gt;=C2=A0 scsi_ss.add(when: &#39;CONFIG_ESP_PCI&#39;, if_true: files(&#39;=
esp-pci.c&#39;))<br>
&gt;=C2=A0 scsi_ss.add(when: &#39;CONFIG_LSI_SCSI_PCI&#39;, if_true: files(=
&#39;lsi53c895a.c&#39;))<br>
&gt; diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..adbae9b4ad<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/scsi/scsi-tape.c<br>
&gt; @@ -0,0 +1,349 @@<br>
&gt; +/*<br>
&gt; + * SCSI Tape Device emulation<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + *<br>
&gt; + * Written by Rafet Taskin &lt;<a href=3D"mailto:rafettaskindev@gmail=
.com" rel=3D"noreferrer noreferrer" target=3D"_blank">rafettaskindev@gmail.=
com</a>&gt;<br>
&gt; + *<br>
&gt; + * SCSI Tape device emulation.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/hw-version.h&quot;<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qemu/memalign.h&quot;<br>
&gt; +#include &quot;qemu/cutils.h&quot;<br>
&gt; +#include &quot;hw/scsi/scsi.h&quot;<br>
&gt; +#include &quot;scsi/constants.h&quot;<br>
&gt; +#include &quot;system/block-backend.h&quot;<br>
&gt; +#include &quot;hw/block/block.h&quot;<br>
&gt; +#include &quot;hw/core/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/core/qdev-properties-system.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +<br>
&gt; +#define SCSI_MAX_INQUIRY_LEN=C2=A0 =C2=A0 256<br>
&gt; +<br>
&gt; +#define MAX_SERIAL_LEN 36<br>
<br>
This doesn&#39;t appear to be used - the value is just<br>
hardcoded at time of use. Can we use that, and also<br>
add constants for the max product, vendor and<br>
version fields, since those magic constants are<br>
used several times over<br>
<br>
<br>
&gt; +static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outb=
uf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, req=
-&gt;dev);<br>
&gt; +=C2=A0 =C2=A0 uint8_t page_code =3D req-&gt;cmd.buf[2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 outbuf[0] =3D TYPE_TAPE;<br>
&gt; +=C2=A0 =C2=A0 outbuf[1] =3D page_code;<br>
&gt; +=C2=A0 =C2=A0 outbuf[2] =3D 0x00;<br>
&gt; +=C2=A0 =C2=A0 outbuf[3] =3D 0x00;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (page_code) {<br>
&gt; +=C2=A0 =C2=A0 case 0x00: /* Supported VPD pages */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[4] =3D 0x00;=C2=A0 =C2=A0/* page 0=
x00 (this page) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;serial) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[5] =3D 0x80;=C2=A0 =
=C2=A0/* page 0x80 (serial number) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[3] =3D 2;=C2=A0 =C2=
=A0 =C2=A0 /* page data length */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[3] =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 5;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case 0x80: /* Unit Serial Number */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;serial) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;=C2=A0 =C2=A0/* n=
ot supported, caller sends INVALID_FIELD */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int l =3D strlen(s-&gt;seri=
al);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[3] =3D l;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;outbuf[4], s-&g=
t;serial, l);<br>
<br>
strpadcpy is probably a better idea, as this leaves the tail of<br>
the buffer uninitialized and does not include a NUL terminator.<br>
Even if the caller has initialized the buffer with nuls, it is<br>
more reassuring to reviewers if we explicitly pad here.<br>
<br>
Use=C2=A0 MAX_SERIAL_LEN here too with strpadcpy<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 4 + l;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;=C2=A0 /* unsupported VPD page =
*/<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int scsi_tape_emulate_inquiry(SCSIRequest *req, uint8_t *outbu=
f)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, req=
-&gt;dev);<br>
&gt; +=C2=A0 =C2=A0 int buflen;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (req-&gt;cmd.buf[1] &amp; 0x1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return scsi_disk_emulate_vpd_page(req, ou=
tbuf);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Standard INQUIRY, not a VPD request */<br>
&gt; +=C2=A0 =C2=A0 if (req-&gt;cmd.buf[2] !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* PAGE_CODE =3D=3D 0 */<br>
&gt; +=C2=A0 =C2=A0 buflen =3D req-&gt;cmd.xfer;<br>
&gt; +=C2=A0 =C2=A0 if (buflen &gt; SCSI_MAX_INQUIRY_LEN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buflen =3D SCSI_MAX_INQUIRY_LEN;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 outbuf[0] =3D TYPE_TAPE;=C2=A0 =C2=A0 =C2=A0 /* 0x01 =
=3D Tape */<br>
&gt; +=C2=A0 =C2=A0 outbuf[1] =3D 0x80;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* Always removable */<br>
&gt; +=C2=A0 =C2=A0 outbuf[2] =3D 0x05;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* SPC-3 */<br>
&gt; +=C2=A0 =C2=A0 outbuf[3] =3D 0x02 | 0x10;=C2=A0 =C2=A0 /* Format 2, Hi=
Sup */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (buflen &gt; 36) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[4] =3D buflen - 5;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[4] =3D 36 - 5;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 outbuf[7] =3D 0x10 | (req-&gt;bus-&gt;info-&gt;tcq ? 0x=
02 : 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 strpadcpy((char *)&amp;outbuf[16], 16, s-&gt;product, &=
#39; &#39;);<br>
&gt; +=C2=A0 =C2=A0 strpadcpy((char *)&amp;outbuf[8], 8, s-&gt;vendor, &#39=
; &#39;);<br>
<br>
The 2nd arg here can use MAX_VENDOR_LEN / MAX_PRODUCT_LEN<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(&amp;outbuf[32], 0, 4);<br>
&gt; +=C2=A0 =C2=A0 memcpy(&amp;outbuf[32], s-&gt;version, MIN(4, strlen(s-=
&gt;version)));<br>
<br>
Why not use strpadcpy like the two lines above. Also MAX_VERSION_LEN<br>
constant would be wise.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return buflen;<br>
&gt; +}<br>
<br>
&gt; +static void scsi_tape_realize(SCSIDevice *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, dev=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev-&gt;type =3D TYPE_TAPE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;qdev.conf.blk) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Drive property not=
 set&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!blk_is_inserted(s-&gt;qdev.conf.blk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Device needs media=
, but drive is empty&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;vendor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;vendor =3D g_strdup(&quot;QEMU&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 } else if (strlen(s-&gt;vendor) &gt; 8) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Vendor must be 8 c=
haracters at most&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Get rid of the &quot;else&quot; here and in the checks below - we want<br>
to sanity check that the static constant is not oversized too,<br>
especially for QEMU_HW_VERSION. Also use the constants for max<br>
length and include the string in the error message . IOW more<br>
like this code:<br>
<br>
=C2=A0 =C2=A0 if (!s-&gt;vendor) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;vendor =3D g_strdup(&quot;QEMU&quot;);<br=
>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 if (strlen(s-&gt;vendor) &gt; MAX_VENDOR_LEN) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Vendor &#39;%s&#39; must=
 be %d characters at most&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
vendor, MAX_VENDOR_LEN);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 }<br>
<br>
<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;product) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;product =3D g_strdup(&quot;QEMU TAP=
E&quot;);<br>
&gt; +=C2=A0 =C2=A0 } else if (strlen(s-&gt;product) &gt; 16) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Product must be 16=
 characters at most&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;version) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;version =3D g_strdup(QEMU_HW_VERSIO=
N);<br>
&gt; +=C2=A0 =C2=A0 } else if (strlen(s-&gt;version) &gt; 4) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Version must be 4 =
characters at most&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;serial &amp;&amp; strlen(s-&gt;serial) &gt; 3=
6) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Serial must be 36 =
characters at most&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer noreferrer=
" target=3D"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=
=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://hachyderm.i=
o/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer noreferrer"=
 target=3D"_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ~~=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.=
org" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://ent=
angle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer n=
oreferrer" target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0=
~~=C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer=
 noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange.com</a>=
 :|<br>
<br>
</blockquote></div></div>

--000000000000208eb0064fa554ae--

