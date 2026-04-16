Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F6F8DFC3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDU4B-0000C5-62; Thu, 16 Apr 2026 17:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wDU43-0000AT-IR
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:16:01 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wDU40-0004dp-U5
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776374149; x=1776978949; i=deller@gmx.de;
 bh=MPrKvoKTpYibUkgSt/ax/6DaZmHsR7L4hNDHAw8uMRo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kMvmTM/owntvEYVk8CSXB6xWCFQv5LnhSat33AwBMVrEj9KgVmFtUg2jQ8Ts9G6h
 /2vZGCX484137IlVMqp3egWjp5Q57ybYB1jgLntLrW/rXOUm/n3WIAJmw0GTzYkZw
 wd9BRcXGwedyCE1bEDoIlpeqiSNaD1GUcclpxM+0iGEElcFbpxU/RZzBVESnQul0o
 +skyiTC2wFWV3nCcXP0FOWOb4KIxN89JjHk0bDnkHhqbk+ykhAfPkTnEp5ebCwMvc
 t7//FWgpQ6DYTlHgtEe9w/cLNFezjxAp1EVDP7RbQ0LXySsCStRmo0es5TEVl05by
 5I/adKRJCeLIZJQmWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1vpGBh2JXk-00N0lA; Thu, 16
 Apr 2026 23:15:49 +0200
Message-ID: <c2ec0a72-8c35-44de-bd7c-cef445c646f4@gmx.de>
Date: Thu, 16 Apr 2026 23:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] hw/scsi: Add SCSI tape device emulation
To: rft0 <rafettaskindev@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net
References: <20260416173448.88831-1-rafettaskindev@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20260416173448.88831-1-rafettaskindev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O/xJ0QkoG4sfk/MDkTx2IuatKkwKyK5v98rXVCrp8bBAf3+P1Du
 KSXyK5QjYvY+FLBLJthGsqFDLFfV0K2g5X7fQaIi40fza7t46mOW90isSHEL2qe17rNAVOS
 zgJ8/EgdqXxP7btq107Z06mm0iy0qKGMbEhdk9bCsb2W7uh1MvP4zsfQgkgWjr4VbTQZbZM
 M+rcJm8rPlFX4kCsoXVcQ==
UI-OutboundReport: notjunk:1;M01:P0:GbGHwepf2zg=;Ud+rDF8SC9C//WOsebI97/gZzN1
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Rafet,

On 4/16/26 19:34, rft0 wrote:
> Add initial emulation of SCSI tape device supporting basic
> INQUIRY operation for now.
>=20
> Hi, I am a GSoC 2026 applicant and this is my first patch.
> Any feedback or corrections appreciated.

I'm really shocked that you sent this patch!

You are one (!!!) out of 8 applicants for the SCSI tape GSCO project.
Everyone of those applicants is eager to be choosen for this project, and =
I think
everyone of them would be able to send such a patch.
And, I've not yet decided who will be mentored by me.

So, why did you sent this patch?


Helge


>=20
> Signed-off-by: rft0 <rafettaskindev@gmail.com>
> ---
>   hw/scsi/meson.build |   1 +
>   hw/scsi/scsi-tape.c | 334 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 335 insertions(+)
>   create mode 100644 hw/scsi/scsi-tape.c
>=20
> diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
> index 69fde0cf84..1699b6e591 100644
> --- a/hw/scsi/meson.build
> +++ b/hw/scsi/meson.build
> @@ -7,6 +7,7 @@ scsi_ss.add(files(
>     'scsi-bus.c',
>     'scsi-disk.c',
>     'scsi-generic.c',
> +  'scsi-tape.c',
>   ))
>   scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
>   scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
> diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c
> new file mode 100644
> index 0000000000..e457167649
> --- /dev/null
> +++ b/hw/scsi/scsi-tape.c
> @@ -0,0 +1,334 @@
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
> +        r->iov.iov_base =3D qemu_memalign(qemu_real_host_page_size(), s=
ize);
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
> +static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf=
)
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
> +            return -1;   /* not supported, caller sends INVALID_FIELD *=
/
> +        }
> +        {
> +            int l =3D strlen(s->serial);
> +            if (l > 36) {
> +                l =3D 36;
> +            }
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
> +static int32_t scsi_tape_emulate_command(SCSIRequest *req, uint8_t *buf=
)
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
> +    }
> +    if (!s->product) {
> +        s->product =3D g_strdup("QEMU TAPE");
> +    }
> +    if (!s->version) {
> +        s->version =3D g_strdup(QEMU_HW_VERSION);
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
> +static void scsi_tape_class_initfn(ObjectClass *klass, const void *data=
)
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


