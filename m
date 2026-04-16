Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6F6F8D765
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDRkt-0005oZ-9Z; Thu, 16 Apr 2026 14:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rafettaskindev@gmail.com>)
 id 1wDRkq-0005oL-VK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:47:57 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rafettaskindev@gmail.com>)
 id 1wDRkn-00021C-2e
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:47:56 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dbff3ea81fso4148855a34.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365271; cv=none;
 d=google.com; s=arc-20240605;
 b=k7Cn9m9RuiWkyCwv2TEK8Dq0JsamqxIxp7j5lb//qRs7hzKQKnmyHPZYh5gGpEcmdO
 3T9olDg0wS8wjUi+nOgSQ+V0CxcvDJDVpZ1p4X5LAt2Ug8+3yyMhqyWrQM9YCDnPgbeW
 3yGjV3oVBOlt+MdjJJ4ochLsGGguSUzNm9L5bdeAq3E7HC5/WuexwYXttAzxxaIkaMCU
 06EGZN/xIggS7hhH3QnDkvJdHeMECIhfmaMd/0rEXUz1UB2UUHEGrSSRiacvbV5nlWsX
 uF2wosjRfivMw/Fn4cy2KF/hghawg39OUWzatn3wLc4veExiSzBD3YLPyOXe7VnDCerG
 xWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sfS9VWZrR2iHoXgMPRV5+qEDclM/LEdfPAkllDQ2vCk=;
 fh=GZZl2e8I1GvW/DYrKgjBPc9AOCDXiU2Fwd8boZaRm4I=;
 b=QUKdiXPeLEXT5iKPaFO1xD8Opi3S45YzSQG6snWcDraVztUZbqvtuY32ytkrjA3Lhv
 8iVgzzivQ5gPwXdkawDJbrW+a4+tnIlDPrS6JQYQlk2YJsffWjw4KWjDrSgiGO1DddJ/
 991sVlK82EV9mxMSgSIUAySm9p6L1TfSTNkZy8/eY7yEehi5KCe1zL5X6vrz8bBwI1VE
 oa44olKOWm7XmpjQRY3hoyLfIzrFhSSaCHgMsZQ5Bf77iS3i4rLTDXxVuo0eG87jaOcR
 d6xaVo8G9D7qWVKistrntp9/bp+eSP/bP4QO1M+XynXW4ElboWUODRLdz2AFgGQhloKw
 MlYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776365271; x=1776970071; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sfS9VWZrR2iHoXgMPRV5+qEDclM/LEdfPAkllDQ2vCk=;
 b=IKa4v+b732SjAue4djV570rHlxvnjDetT3lmmEMh9jaJQd1wyVAk69AIWcDZSuZ2gr
 6m7HPtcvU0ioEV2MDX2FngOYxkjW3Im10kKlRdtV7Q7s5NdFUM2IkvRwYroduiouFU6u
 1YHluHoSE80SjT+HJ/iTN1u81ysdT9IGlxxFhKitnEzitzYqdZSU8XaAK+1YKRF71S1j
 pY5qBTUhXyi0e1p2pgkQqDk5rWwB4Oon9wOoiqsnNmWaRCi6Wl/9Jq9ZfZXzZ8EzZGm/
 TDg2ve0ReJckLQggU/xSDWZmh6T5Fm5yrl6MjtSGUk8KfFBXqgTawcECVyLORpPLzU0Q
 YodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365271; x=1776970071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfS9VWZrR2iHoXgMPRV5+qEDclM/LEdfPAkllDQ2vCk=;
 b=aLktJm5CAWWmkCWwwPQxEG6LA8Ij02kc8+veoL73K3yb/KZ9b3SR3LoDb3dX4Bispq
 dpMFTn6ZYL73fIicbR+0o1/dzCg7zpNxf33SFwF4Tg6NZircn40s43lcN7WCJGkEgCOR
 3Fy0IICEJ8qe1MrEdia7p3A2mAeWUv14jjx8YMq3Vgr6aoXDHTW+mUurlu3D7Mv1FOcA
 CB80ekshWke8yDHDOEmbDlp+XzJEZiVWJc4C1zGN6IDniwYHypqD7yCQHB9lrs2lPfaz
 h2lrWYWErZRmyKTCyiCuwNCa9Q7rrO4/bf93cUepID7n5vmlTHnrqvH/LyfDAnl9pk1t
 KHfg==
X-Gm-Message-State: AOJu0YxSWfxK0KAEqipCpu+GJ9cUtwWrreqc0UWACy2G6w+kybHVxSbo
 AUYlrPEbG5gl5VwLC3nInlRFtt976M8ckV327qMMRKzBg0nlNxqcTifRkWCeosAQCKvYxL8oIgR
 TybEcMZ2M8cBCWdpKRxjm+RxfVmfjgpjOGm9SMVE=
X-Gm-Gg: AeBDietnWbzh9b9xUXr+Q/Ja5rG4ZaqdF07gPRWBhNBE7IqDXVI+KpdUZn7OC8D4Wot
 5a3vO9G+hrswIMWEtjXe+MCmBrBmWpds47W/Px9UNvtkEl+fo/uWasnOYZgznH7nPYPVnzw98aB
 I5VVdJlftIfTBFhmcQ7wlcIUGWNFu+9QHxN79slBSdyRyWdPDvn1LGQ+rC4d/mNmU8ooYdJLp30
 WysMzAmakEeeTrTrJboRXBQL7Bh9mMNXxVCk+9pr7d/DNwWO/ojkG3VD8WVyu1Lox3IFkoNF5hP
 RAN+OjLhFUnFDNILdQ==
X-Received: by 2002:a05:6820:c82:b0:684:dd1d:5b8f with SMTP id
 006d021491bc7-69461894576mr230329eaf.0.1776365271063; Thu, 16 Apr 2026
 11:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260416183540.142727-1-rafettaskindev@gmail.com>
In-Reply-To: <20260416183540.142727-1-rafettaskindev@gmail.com>
From: Rafet T <rafettaskindev@gmail.com>
Date: Thu, 16 Apr 2026 21:47:40 +0300
X-Gm-Features: AQROBzCYfJjf4NMa7SxQ3_zvhwiHiuDoFJvcvrLB_MrmwNgMrH-H5cjNRG3YAMw
Message-ID: <CA+JCrau4wmDG_9H8bm4ryu5sXyt602dghZ38UMGSon+aHKj=4Q@mail.gmail.com>
Subject: Re: [PATCH v2] hw/scsi: Add SCSI tape device emulation
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, pbonzini@redhat.com, fam@euphon.net
Content-Type: multipart/alternative; boundary="000000000000f92069064f9844c2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=rafettaskindev@gmail.com; helo=mail-ot1-x32e.google.com
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

--000000000000f92069064f9844c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

this is continuation of
https://lore.kernel.org/qemu-devel/aeEicSrfbE2sZo8w@redhat.com/T/#t

On Thu, Apr 16, 2026 at 9:36=E2=80=AFPM rft0 <rafettaskindev@gmail.com> wro=
te:

> Add initial emulation of SCSI tape device supporting basic
> INQUIRY operation for now.
>
> Signed-off-by: rft0 <rafettaskindev@gmail.com>
> ---
> Second patch:
>  - Add kconfig entry
>  - Validate vendor, product, version, serial lengths
>
>  hw/scsi/Kconfig     |   5 +
>  hw/scsi/meson.build |   1 +
>  hw/scsi/scsi-tape.c | 349 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 hw/scsi/scsi-tape.c
>
> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> index 5743ee9b4d..06e7cab178 100644
> --- a/hw/scsi/Kconfig
> +++ b/hw/scsi/Kconfig
> @@ -1,6 +1,11 @@
>  config SCSI
>      bool
>
> +config SCSI_TAPE
> +    bool
> +    default y
> +    depends on SCSI
> +
>  config LSI_SCSI_PCI
>      bool
>      default y if PCI_DEVICES
> diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
> index 69fde0cf84..1c62115d8e 100644
> --- a/hw/scsi/meson.build
> +++ b/hw/scsi/meson.build
> @@ -8,6 +8,7 @@ scsi_ss.add(files(
>    'scsi-disk.c',
>    'scsi-generic.c',
>  ))
> +scsi_ss.add(when: 'CONFIG_SCSI_TAPE', if_true: files('scsi-tape.c'))
>  scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
>  scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
>  scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
> diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c
> new file mode 100644
> index 0000000000..adbae9b4ad
> --- /dev/null
> +++ b/hw/scsi/scsi-tape.c
> @@ -0,0 +1,349 @@
> +/*
> + * SCSI Tape Device emulation
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Written by Rafet Taskin <rafettaskindev@gmail.com>
> + *
> + * SCSI Tape device emulation.
> + *
> + */
> +
> +#include "qemu/hw-version.h"
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "qemu/memalign.h"
> +#include "qemu/cutils.h"
> +#include "hw/scsi/scsi.h"
> +#include "scsi/constants.h"
> +#include "system/block-backend.h"
> +#include "hw/block/block.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "qom/object.h"
> +
> +#define SCSI_MAX_INQUIRY_LEN    256
> +
> +#define MAX_SERIAL_LEN 36
> +
> +#define TYPE_SCSI_TAPE "scsi-tape"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(SCSITapeState, SCSI_TAPE)
> +
> +typedef struct SCSITapeReq {
> +    SCSIRequest req;
> +
> +    uint32_t buflen;
> +    struct iovec iov;
> +
> +    QEMUIOVector qiov;
> +} SCSITapeReq;
> +
> +struct SCSITapeState {
> +    SCSIDevice qdev;
> +
> +    char *vendor;
> +    char *product;
> +    char *version;
> +    char *serial;
> +};
> +
> +static void scsi_free_request(SCSIRequest *req)
> +{
> +    SCSITapeReq *r =3D DO_UPCAST(SCSITapeReq, req, req);
> +
> +    qemu_vfree(r->iov.iov_base);
> +}
> +
> +static uint8_t *scsi_get_buf(SCSIRequest *req)
> +{
> +    SCSITapeReq *r =3D DO_UPCAST(SCSITapeReq, req, req);
> +
> +    return (uint8_t *)r->iov.iov_base;
> +}
> +
> +static void scsi_init_iovec(SCSITapeReq *r, size_t size)
> +{
> +    if (!r->iov.iov_base) {
> +        r->buflen =3D size;
> +        r->iov.iov_base =3D qemu_memalign(qemu_real_host_page_size(), si=
ze);
> +    }
> +
> +    r->iov.iov_len =3D size;
> +    qemu_iovec_init_external(&r->qiov, &r->iov, 1);
> +}
> +
> +static void scsi_check_condition(SCSITapeReq *r, SCSISense sense)
> +{
> +    scsi_req_build_sense(&r->req, sense);
> +    scsi_req_complete(&r->req, CHECK_CONDITION);
> +}
> +
> +static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
> +{
> +    SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, req->dev);
> +    uint8_t page_code =3D req->cmd.buf[2];
> +
> +    outbuf[0] =3D TYPE_TAPE;
> +    outbuf[1] =3D page_code;
> +    outbuf[2] =3D 0x00;
> +    outbuf[3] =3D 0x00;
> +
> +    switch (page_code) {
> +    case 0x00: /* Supported VPD pages */
> +        outbuf[4] =3D 0x00;   /* page 0x00 (this page) */
> +        if (s->serial) {
> +            outbuf[5] =3D 0x80;   /* page 0x80 (serial number) */
> +            outbuf[3] =3D 2;      /* page data length */
> +            return 6;
> +        }
> +        outbuf[3] =3D 1;
> +        return 5;
> +
> +    case 0x80: /* Unit Serial Number */
> +        if (!s->serial) {
> +            return -1;   /* not supported, caller sends INVALID_FIELD */
> +        }
> +        {
> +            int l =3D strlen(s->serial);
> +            outbuf[3] =3D l;
> +            memcpy(&outbuf[4], s->serial, l);
> +            return 4 + l;
> +        }
> +
> +    default:
> +        return -1;  /* unsupported VPD page */
> +    }
> +}
> +
> +static int scsi_tape_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
> +{
> +    SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, req->dev);
> +    int buflen;
> +
> +    if (req->cmd.buf[1] & 0x1) {
> +        return scsi_disk_emulate_vpd_page(req, outbuf);
> +    }
> +
> +    /* Standard INQUIRY, not a VPD request */
> +    if (req->cmd.buf[2] !=3D 0) {
> +        return -1;
> +    }
> +
> +    /* PAGE_CODE =3D=3D 0 */
> +    buflen =3D req->cmd.xfer;
> +    if (buflen > SCSI_MAX_INQUIRY_LEN) {
> +        buflen =3D SCSI_MAX_INQUIRY_LEN;
> +    }
> +
> +    outbuf[0] =3D TYPE_TAPE;      /* 0x01 =3D Tape */
> +    outbuf[1] =3D 0x80;           /* Always removable */
> +    outbuf[2] =3D 0x05;           /* SPC-3 */
> +    outbuf[3] =3D 0x02 | 0x10;    /* Format 2, HiSup */
> +
> +    if (buflen > 36) {
> +        outbuf[4] =3D buflen - 5;
> +    } else {
> +        outbuf[4] =3D 36 - 5;
> +    }
> +
> +    outbuf[7] =3D 0x10 | (req->bus->info->tcq ? 0x02 : 0);
> +
> +    strpadcpy((char *)&outbuf[16], 16, s->product, ' ');
> +    strpadcpy((char *)&outbuf[8], 8, s->vendor, ' ');
> +
> +    memset(&outbuf[32], 0, 4);
> +    memcpy(&outbuf[32], s->version, MIN(4, strlen(s->version)));
> +
> +    return buflen;
> +}
> +
> +/*
> + * > 0 - number of bytes from device to host
> + * < 0 - number of bytes from host to device
> + * =3D 0 - no data transfer, already completed
> + */
> +static int32_t scsi_tape_emulate_command(SCSIRequest *req, uint8_t *buf)
> +{
> +    SCSITapeReq *r =3D DO_UPCAST(SCSITapeReq, req, req);
> +    uint8_t *outbuf;
> +    int32_t len =3D 0;
> +    uint8_t command =3D buf[0];
> +
> +    if (req->cmd.xfer > 65536) {
> +        scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
> +        return 0;
> +    }
> +    r->buflen =3D MAX(4096, req->cmd.xfer);
> +    scsi_init_iovec(r, r->buflen);
> +
> +    outbuf =3D r->iov.iov_base;
> +    memset(outbuf, 0, r->buflen);
> +
> +    switch (command) {
> +    case INQUIRY:
> +        len =3D scsi_tape_emulate_inquiry(req, outbuf);
> +        if (len < 0) {
> +            scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
> +            return 0;
> +        }
> +        break;
> +
> +    case TEST_UNIT_READY:
> +        if (!blk_is_available(req->dev->conf.blk)) {
> +            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
> +            return 0;
> +        }
> +
> +        /* TODO: check if tape is really ready */
> +        scsi_req_complete(&r->req, GOOD);
> +        return 0;
> +    case REQUEST_SENSE:
> +        /* TODO: returning NO SENSE for now handle it later. */
> +        /* 0x0: 0x70 =3D current errors, fixed format */
> +        /* 0x2: sense key (0x00 =3D NO SENSE) */
> +        /* 0x7: additional sense length */
> +        {
> +            int sense_len =3D MIN(buf[4], 18);
> +            memset(outbuf, 0, sense_len);
> +            outbuf[0] =3D 0x70;
> +            outbuf[2] =3D 0x00;
> +            outbuf[7] =3D 10;
> +            len =3D sense_len;
> +        }
> +        break;
> +
> +    case REWIND:
> +        if (!blk_is_available(req->dev->conf.blk)) {
> +            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
> +            return 0;
> +        }
> +
> +        /* TODO: reset tape position to beginning of SIMH image */
> +        scsi_req_complete(&r->req, GOOD);
> +        return 0;
> +
> +    /* Add rest later */
> +    default:
> +        scsi_check_condition(r, SENSE_CODE(INVALID_OPCODE));
> +        return 0;
> +    }
> +
> +    r->iov.iov_len =3D len;
> +    return len;
> +}
> +
> +
> +/* TODO */
> +static void scsi_tape_emulate_read_data(SCSIRequest *req)
> +{
> +    SCSITapeReq *r =3D DO_UPCAST(SCSITapeReq, req, req);
> +    int buflen =3D r->iov.iov_len;
> +
> +    if (buflen) {
> +        r->iov.iov_len =3D 0;
> +        scsi_req_data(&r->req, buflen);
> +        return;
> +    }
> +
> +    scsi_req_complete(&r->req, GOOD);
> +}
> +
> +/* TODO: not implemented yet */
> +static void scsi_tape_emulate_write_data(SCSIRequest *req)
> +{
> +    scsi_req_complete(req, GOOD);
> +}
> +
> +static const SCSIReqOps scsi_tape_reqops =3D {
> +    .size         =3D sizeof(SCSITapeReq),
> +    .free_req     =3D scsi_free_request,
> +    .send_command =3D scsi_tape_emulate_command,
> +    .read_data    =3D scsi_tape_emulate_read_data,
> +    .write_data   =3D scsi_tape_emulate_write_data,
> +    .get_buf      =3D scsi_get_buf,
> +};
> +
> +static SCSIRequest *scsi_tape_new_request(SCSIDevice *d, uint32_t tag,
> +                                          uint32_t lun, uint8_t *buf,
> +                                          void *hba_private)
> +{
> +    return scsi_req_alloc(&scsi_tape_reqops, d, tag, lun, hba_private);
> +}
> +
> +static void scsi_tape_realize(SCSIDevice *dev, Error **errp)
> +{
> +    SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, dev);
> +
> +    dev->type =3D TYPE_TAPE;
> +
> +    if (!s->qdev.conf.blk) {
> +        error_setg(errp, "Drive property not set");
> +        return;
> +    }
> +
> +    if (!blk_is_inserted(s->qdev.conf.blk)) {
> +        error_setg(errp, "Device needs media, but drive is empty");
> +        return;
> +    }
> +
> +    if (!s->vendor) {
> +        s->vendor =3D g_strdup("QEMU");
> +    } else if (strlen(s->vendor) > 8) {
> +        error_setg(errp, "Vendor must be 8 characters at most");
> +        return;
> +    }
> +
> +    if (!s->product) {
> +        s->product =3D g_strdup("QEMU TAPE");
> +    } else if (strlen(s->product) > 16) {
> +        error_setg(errp, "Product must be 16 characters at most");
> +        return;
> +    }
> +
> +    if (!s->version) {
> +        s->version =3D g_strdup(QEMU_HW_VERSION);
> +    } else if (strlen(s->version) > 4) {
> +        error_setg(errp, "Version must be 4 characters at most");
> +        return;
> +    }
> +
> +    if (s->serial && strlen(s->serial) > 36) {
> +        error_setg(errp, "Serial must be 36 characters at most");
> +        return;
> +    }
> +}
> +
> +static Property scsi_tape_properties[] =3D {
> +    DEFINE_PROP_DRIVE("drive", SCSITapeState, qdev.conf.blk),
> +    DEFINE_PROP_STRING("vendor", SCSITapeState, vendor),
> +    DEFINE_PROP_STRING("product", SCSITapeState, product),
> +    DEFINE_PROP_STRING("ver", SCSITapeState, version),
> +    DEFINE_PROP_STRING("serial", SCSITapeState, serial),
> +};
> +
> +static void scsi_tape_class_initfn(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(klass);
> +
> +    sc->realize   =3D scsi_tape_realize;
> +    sc->alloc_req =3D scsi_tape_new_request;
> +    dc->desc      =3D "SCSI Tape";
> +    device_class_set_props(dc, scsi_tape_properties);
> +}
> +
> +static const TypeInfo scsi_tape_info =3D {
> +    .name          =3D TYPE_SCSI_TAPE,
> +    .parent        =3D TYPE_SCSI_DEVICE,
> +    .instance_size =3D sizeof(SCSITapeState),
> +    .class_init    =3D scsi_tape_class_initfn,
> +};
> +
> +static void scsi_tape_register_types(void)
> +{
> +    type_register_static(&scsi_tape_info);
> +}
> +
> +type_init(scsi_tape_register_types)
> --
> 2.47.3
>
>

--000000000000f92069064f9844c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">this is continuation of=C2=A0<a href=3D"https://lore.kerne=
l.org/qemu-devel/aeEicSrfbE2sZo8w@redhat.com/T/#t">https://lore.kernel.org/=
qemu-devel/aeEicSrfbE2sZo8w@redhat.com/T/#t</a></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Apr 16, 2026 at 9:36=E2=80=AFPM rft0 &lt;<a href=3D"mailto:rafettaskindev=
@gmail.com">rafettaskindev@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Add initial emulation of SCSI tape devi=
ce supporting basic<br>
INQUIRY operation for now.<br>
<br>
Signed-off-by: rft0 &lt;<a href=3D"mailto:rafettaskindev@gmail.com" target=
=3D"_blank">rafettaskindev@gmail.com</a>&gt;<br>
---<br>
Second patch:<br>
=C2=A0- Add kconfig entry<br>
=C2=A0- Validate vendor, product, version, serial lengths<br>
<br>
=C2=A0hw/scsi/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
=C2=A0hw/scsi/meson.build |=C2=A0 =C2=A01 +<br>
=C2=A0hw/scsi/scsi-tape.c | 349 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A03 files changed, 355 insertions(+)<br>
=C2=A0create mode 100644 hw/scsi/scsi-tape.c<br>
<br>
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig<br>
index 5743ee9b4d..06e7cab178 100644<br>
--- a/hw/scsi/Kconfig<br>
+++ b/hw/scsi/Kconfig<br>
@@ -1,6 +1,11 @@<br>
=C2=A0config SCSI<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
<br>
+config SCSI_TAPE<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 default y<br>
+=C2=A0 =C2=A0 depends on SCSI<br>
+<br>
=C2=A0config LSI_SCSI_PCI<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0default y if PCI_DEVICES<br>
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build<br>
index 69fde0cf84..1c62115d8e 100644<br>
--- a/hw/scsi/meson.build<br>
+++ b/hw/scsi/meson.build<br>
@@ -8,6 +8,7 @@ scsi_ss.add(files(<br>
=C2=A0 =C2=A0&#39;scsi-disk.c&#39;,<br>
=C2=A0 =C2=A0&#39;scsi-generic.c&#39;,<br>
=C2=A0))<br>
+scsi_ss.add(when: &#39;CONFIG_SCSI_TAPE&#39;, if_true: files(&#39;scsi-tap=
e.c&#39;))<br>
=C2=A0scsi_ss.add(when: &#39;CONFIG_ESP&#39;, if_true: files(&#39;esp.c&#39=
;))<br>
=C2=A0scsi_ss.add(when: &#39;CONFIG_ESP_PCI&#39;, if_true: files(&#39;esp-p=
ci.c&#39;))<br>
=C2=A0scsi_ss.add(when: &#39;CONFIG_LSI_SCSI_PCI&#39;, if_true: files(&#39;=
lsi53c895a.c&#39;))<br>
diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c<br>
new file mode 100644<br>
index 0000000000..adbae9b4ad<br>
--- /dev/null<br>
+++ b/hw/scsi/scsi-tape.c<br>
@@ -0,0 +1,349 @@<br>
+/*<br>
+ * SCSI Tape Device emulation<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ *<br>
+ * Written by Rafet Taskin &lt;<a href=3D"mailto:rafettaskindev@gmail.com"=
 target=3D"_blank">rafettaskindev@gmail.com</a>&gt;<br>
+ *<br>
+ * SCSI Tape device emulation.<br>
+ *<br>
+ */<br>
+<br>
+#include &quot;qemu/hw-version.h&quot;<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/memalign.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
+#include &quot;hw/scsi/scsi.h&quot;<br>
+#include &quot;scsi/constants.h&quot;<br>
+#include &quot;system/block-backend.h&quot;<br>
+#include &quot;hw/block/block.h&quot;<br>
+#include &quot;hw/core/qdev-properties.h&quot;<br>
+#include &quot;hw/core/qdev-properties-system.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+<br>
+#define SCSI_MAX_INQUIRY_LEN=C2=A0 =C2=A0 256<br>
+<br>
+#define MAX_SERIAL_LEN 36<br>
+<br>
+#define TYPE_SCSI_TAPE &quot;scsi-tape&quot;<br>
+<br>
+OBJECT_DECLARE_SIMPLE_TYPE(SCSITapeState, SCSI_TAPE)<br>
+<br>
+typedef struct SCSITapeReq {<br>
+=C2=A0 =C2=A0 SCSIRequest req;<br>
+<br>
+=C2=A0 =C2=A0 uint32_t buflen;<br>
+=C2=A0 =C2=A0 struct iovec iov;<br>
+<br>
+=C2=A0 =C2=A0 QEMUIOVector qiov;<br>
+} SCSITapeReq;<br>
+<br>
+struct SCSITapeState {<br>
+=C2=A0 =C2=A0 SCSIDevice qdev;<br>
+<br>
+=C2=A0 =C2=A0 char *vendor;<br>
+=C2=A0 =C2=A0 char *product;<br>
+=C2=A0 =C2=A0 char *version;<br>
+=C2=A0 =C2=A0 char *serial;<br>
+};<br>
+<br>
+static void scsi_free_request(SCSIRequest *req)<br>
+{<br>
+=C2=A0 =C2=A0 SCSITapeReq *r =3D DO_UPCAST(SCSITapeReq, req, req);<br>
+<br>
+=C2=A0 =C2=A0 qemu_vfree(r-&gt;iov.iov_base);<br>
+}<br>
+<br>
+static uint8_t *scsi_get_buf(SCSIRequest *req)<br>
+{<br>
+=C2=A0 =C2=A0 SCSITapeReq *r =3D DO_UPCAST(SCSITapeReq, req, req);<br>
+<br>
+=C2=A0 =C2=A0 return (uint8_t *)r-&gt;iov.iov_base;<br>
+}<br>
+<br>
+static void scsi_init_iovec(SCSITapeReq *r, size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 if (!r-&gt;iov.iov_base) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r-&gt;buflen =3D size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r-&gt;iov.iov_base =3D qemu_memalign(qemu_real=
_host_page_size(), size);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 r-&gt;iov.iov_len =3D size;<br>
+=C2=A0 =C2=A0 qemu_iovec_init_external(&amp;r-&gt;qiov, &amp;r-&gt;iov, 1)=
;<br>
+}<br>
+<br>
+static void scsi_check_condition(SCSITapeReq *r, SCSISense sense)<br>
+{<br>
+=C2=A0 =C2=A0 scsi_req_build_sense(&amp;r-&gt;req, sense);<br>
+=C2=A0 =C2=A0 scsi_req_complete(&amp;r-&gt;req, CHECK_CONDITION);<br>
+}<br>
+<br>
+static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)<b=
r>
+{<br>
+=C2=A0 =C2=A0 SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, req-&gt;=
dev);<br>
+=C2=A0 =C2=A0 uint8_t page_code =3D req-&gt;cmd.buf[2];<br>
+<br>
+=C2=A0 =C2=A0 outbuf[0] =3D TYPE_TAPE;<br>
+=C2=A0 =C2=A0 outbuf[1] =3D page_code;<br>
+=C2=A0 =C2=A0 outbuf[2] =3D 0x00;<br>
+=C2=A0 =C2=A0 outbuf[3] =3D 0x00;<br>
+<br>
+=C2=A0 =C2=A0 switch (page_code) {<br>
+=C2=A0 =C2=A0 case 0x00: /* Supported VPD pages */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[4] =3D 0x00;=C2=A0 =C2=A0/* page 0x00 (=
this page) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;serial) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[5] =3D 0x80;=C2=A0 =C2=A0=
/* page 0x80 (serial number) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[3] =3D 2;=C2=A0 =C2=A0 =
=C2=A0 /* page data length */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 6;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[3] =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 5;<br>
+<br>
+=C2=A0 =C2=A0 case 0x80: /* Unit Serial Number */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;serial) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;=C2=A0 =C2=A0/* not su=
pported, caller sends INVALID_FIELD */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int l =3D strlen(s-&gt;serial);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[3] =3D l;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;outbuf[4], s-&gt;ser=
ial, l);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 4 + l;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;=C2=A0 /* unsupported VPD page */<br=
>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static int scsi_tape_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)<br=
>
+{<br>
+=C2=A0 =C2=A0 SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, req-&gt;=
dev);<br>
+=C2=A0 =C2=A0 int buflen;<br>
+<br>
+=C2=A0 =C2=A0 if (req-&gt;cmd.buf[1] &amp; 0x1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return scsi_disk_emulate_vpd_page(req, outbuf)=
;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Standard INQUIRY, not a VPD request */<br>
+=C2=A0 =C2=A0 if (req-&gt;cmd.buf[2] !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* PAGE_CODE =3D=3D 0 */<br>
+=C2=A0 =C2=A0 buflen =3D req-&gt;cmd.xfer;<br>
+=C2=A0 =C2=A0 if (buflen &gt; SCSI_MAX_INQUIRY_LEN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buflen =3D SCSI_MAX_INQUIRY_LEN;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 outbuf[0] =3D TYPE_TAPE;=C2=A0 =C2=A0 =C2=A0 /* 0x01 =3D Tap=
e */<br>
+=C2=A0 =C2=A0 outbuf[1] =3D 0x80;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* Always removable */<br>
+=C2=A0 =C2=A0 outbuf[2] =3D 0x05;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* SPC-3 */<br>
+=C2=A0 =C2=A0 outbuf[3] =3D 0x02 | 0x10;=C2=A0 =C2=A0 /* Format 2, HiSup *=
/<br>
+<br>
+=C2=A0 =C2=A0 if (buflen &gt; 36) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[4] =3D buflen - 5;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[4] =3D 36 - 5;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 outbuf[7] =3D 0x10 | (req-&gt;bus-&gt;info-&gt;tcq ? 0x02 : =
0);<br>
+<br>
+=C2=A0 =C2=A0 strpadcpy((char *)&amp;outbuf[16], 16, s-&gt;product, &#39; =
&#39;);<br>
+=C2=A0 =C2=A0 strpadcpy((char *)&amp;outbuf[8], 8, s-&gt;vendor, &#39; &#3=
9;);<br>
+<br>
+=C2=A0 =C2=A0 memset(&amp;outbuf[32], 0, 4);<br>
+=C2=A0 =C2=A0 memcpy(&amp;outbuf[32], s-&gt;version, MIN(4, strlen(s-&gt;v=
ersion)));<br>
+<br>
+=C2=A0 =C2=A0 return buflen;<br>
+}<br>
+<br>
+/*<br>
+ * &gt; 0 - number of bytes from device to host<br>
+ * &lt; 0 - number of bytes from host to device<br>
+ * =3D 0 - no data transfer, already completed<br>
+ */<br>
+static int32_t scsi_tape_emulate_command(SCSIRequest *req, uint8_t *buf)<b=
r>
+{<br>
+=C2=A0 =C2=A0 SCSITapeReq *r =3D DO_UPCAST(SCSITapeReq, req, req);<br>
+=C2=A0 =C2=A0 uint8_t *outbuf;<br>
+=C2=A0 =C2=A0 int32_t len =3D 0;<br>
+=C2=A0 =C2=A0 uint8_t command =3D buf[0];<br>
+<br>
+=C2=A0 =C2=A0 if (req-&gt;cmd.xfer &gt; 65536) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_check_condition(r, SENSE_CODE(INVALID_FIE=
LD));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 r-&gt;buflen =3D MAX(4096, req-&gt;cmd.xfer);<br>
+=C2=A0 =C2=A0 scsi_init_iovec(r, r-&gt;buflen);<br>
+<br>
+=C2=A0 =C2=A0 outbuf =3D r-&gt;iov.iov_base;<br>
+=C2=A0 =C2=A0 memset(outbuf, 0, r-&gt;buflen);<br>
+<br>
+=C2=A0 =C2=A0 switch (command) {<br>
+=C2=A0 =C2=A0 case INQUIRY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D scsi_tape_emulate_inquiry(req, outbuf)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_check_condition(r, SENSE_CO=
DE(INVALID_FIELD));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case TEST_UNIT_READY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!blk_is_available(req-&gt;dev-&gt;conf.blk=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_check_condition(r, SENSE_CO=
DE(NO_MEDIUM));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: check if tape is really ready */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_req_complete(&amp;r-&gt;req, GOOD);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 case REQUEST_SENSE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: returning NO SENSE for now handle it =
later. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x0: 0x70 =3D current errors, fixed format =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x2: sense key (0x00 =3D NO SENSE) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x7: additional sense length */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int sense_len =3D MIN(buf[4], 18=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(outbuf, 0, sense_len);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[0] =3D 0x70;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[2] =3D 0x00;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outbuf[7] =3D 10;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D sense_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case REWIND:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!blk_is_available(req-&gt;dev-&gt;conf.blk=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_check_condition(r, SENSE_CO=
DE(NO_MEDIUM));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: reset tape position to beginning of S=
IMH image */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_req_complete(&amp;r-&gt;req, GOOD);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+<br>
+=C2=A0 =C2=A0 /* Add rest later */<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_check_condition(r, SENSE_CODE(INVALID_OPC=
ODE));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 r-&gt;iov.iov_len =3D len;<br>
+=C2=A0 =C2=A0 return len;<br>
+}<br>
+<br>
+<br>
+/* TODO */<br>
+static void scsi_tape_emulate_read_data(SCSIRequest *req)<br>
+{<br>
+=C2=A0 =C2=A0 SCSITapeReq *r =3D DO_UPCAST(SCSITapeReq, req, req);<br>
+=C2=A0 =C2=A0 int buflen =3D r-&gt;iov.iov_len;<br>
+<br>
+=C2=A0 =C2=A0 if (buflen) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r-&gt;iov.iov_len =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_req_data(&amp;r-&gt;req, buflen);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 scsi_req_complete(&amp;r-&gt;req, GOOD);<br>
+}<br>
+<br>
+/* TODO: not implemented yet */<br>
+static void scsi_tape_emulate_write_data(SCSIRequest *req)<br>
+{<br>
+=C2=A0 =C2=A0 scsi_req_complete(req, GOOD);<br>
+}<br>
+<br>
+static const SCSIReqOps scsi_tape_reqops =3D {<br>
+=C2=A0 =C2=A0 .size=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D sizeof(SCSITapeRe=
q),<br>
+=C2=A0 =C2=A0 .free_req=C2=A0 =C2=A0 =C2=A0=3D scsi_free_request,<br>
+=C2=A0 =C2=A0 .send_command =3D scsi_tape_emulate_command,<br>
+=C2=A0 =C2=A0 .read_data=C2=A0 =C2=A0 =3D scsi_tape_emulate_read_data,<br>
+=C2=A0 =C2=A0 .write_data=C2=A0 =C2=A0=3D scsi_tape_emulate_write_data,<br=
>
+=C2=A0 =C2=A0 .get_buf=C2=A0 =C2=A0 =C2=A0 =3D scsi_get_buf,<br>
+};<br>
+<br>
+static SCSIRequest *scsi_tape_new_request(SCSIDevice *d, uint32_t tag,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
int32_t lun, uint8_t *buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=
oid *hba_private)<br>
+{<br>
+=C2=A0 =C2=A0 return scsi_req_alloc(&amp;scsi_tape_reqops, d, tag, lun, hb=
a_private);<br>
+}<br>
+<br>
+static void scsi_tape_realize(SCSIDevice *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 SCSITapeState *s =3D DO_UPCAST(SCSITapeState, qdev, dev);<br=
>
+<br>
+=C2=A0 =C2=A0 dev-&gt;type =3D TYPE_TAPE;<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;qdev.conf.blk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Drive property not set&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!blk_is_inserted(s-&gt;qdev.conf.blk)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Device needs media, but=
 drive is empty&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;vendor) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;vendor =3D g_strdup(&quot;QEMU&quot;);<b=
r>
+=C2=A0 =C2=A0 } else if (strlen(s-&gt;vendor) &gt; 8) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Vendor must be 8 charac=
ters at most&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;product) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;product =3D g_strdup(&quot;QEMU TAPE&quo=
t;);<br>
+=C2=A0 =C2=A0 } else if (strlen(s-&gt;product) &gt; 16) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Product must be 16 char=
acters at most&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;version) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;version =3D g_strdup(QEMU_HW_VERSION);<b=
r>
+=C2=A0 =C2=A0 } else if (strlen(s-&gt;version) &gt; 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Version must be 4 chara=
cters at most&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;serial &amp;&amp; strlen(s-&gt;serial) &gt; 36) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Serial must be 36 chara=
cters at most&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static Property scsi_tape_properties[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_PROP_DRIVE(&quot;drive&quot;, SCSITapeState, qdev.con=
f.blk),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;vendor&quot;, SCSITapeState, vendor=
),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;product&quot;, SCSITapeState, produ=
ct),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;ver&quot;, SCSITapeState, version),=
<br>
+=C2=A0 =C2=A0 DEFINE_PROP_STRING(&quot;serial&quot;, SCSITapeState, serial=
),<br>
+};<br>
+<br>
+static void scsi_tape_class_initfn(ObjectClass *klass, const void *data)<b=
r>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+=C2=A0 =C2=A0 SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 sc-&gt;realize=C2=A0 =C2=A0=3D scsi_tape_realize;<br>
+=C2=A0 =C2=A0 sc-&gt;alloc_req =3D scsi_tape_new_request;<br>
+=C2=A0 =C2=A0 dc-&gt;desc=C2=A0 =C2=A0 =C2=A0 =3D &quot;SCSI Tape&quot;;<b=
r>
+=C2=A0 =C2=A0 device_class_set_props(dc, scsi_tape_properties);<br>
+}<br>
+<br>
+static const TypeInfo scsi_tape_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SCSI_TAPE,<=
br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SCSI_DEVICE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(SCSITapeState),<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D scsi_tape_class_initfn,<br>
+};<br>
+<br>
+static void scsi_tape_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;scsi_tape_info);<br>
+}<br>
+<br>
+type_init(scsi_tape_register_types)<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div>

--000000000000f92069064f9844c2--

