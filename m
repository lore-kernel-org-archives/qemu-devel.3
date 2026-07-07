Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3133BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh77D-0005Ae-QG; Tue, 07 Jul 2026 10:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wh779-0005AD-H6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:49:36 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wh777-0003If-LC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:49:34 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-664e3ed58bcso927270d50.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 07:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783435772; cv=none;
 d=google.com; s=arc-20260327;
 b=iDSKBjTIUlxy8vseD0YgK6wr+s/hMvS/LSk3DnVgyOJru2tJ3cVtkuo4gNOySUp4dK
 w+UggLZAf3p0k43J5tLwVGGu50QEICoTqgiANbCqvzAGfSo0w0OPR5DCnBZBvAjt/uk7
 CQULY8S5oSADYl4mdMOt9jjhYRKX4KqbnLSkiVAssD48MLzrYIJll5o/9qYfkxYcPMVx
 FME+vwgqw35YmVA7z4Yn4PjiOnBzkfjRlHfzQqroYKWEAclrfh890xDf9XOk/EkCJLcq
 BlL0h5xpD3tE/hbF+HySaCz7i6X2ojc4nTXSIMFFcZ+LeO0dVy2G9ErBLEcIU3BPvSWA
 B1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G8dXC3qhNMMWw97FDxwoE4srNdTqVNi1YC+JexXxDPU=;
 fh=1gFdGoFQOrgQ2BJKc+lMjq7ko14vRrum0ELKhNNTOLQ=;
 b=N44yUe07iADB0Kq4smEnJYtLf5iZfpUAk7x9BeMiVnb+EDe/6kLbdR/gFpjShnY1kl
 JrDBfEHIBe8Thdrc9PsHUlvcjiQYbk9H2p032XHsnQYIkmKmJDcB5phmGvKLfGn6bXqz
 JmHwf6LVcDWBNwGP5qKaa/5/Z6z1zrs+fLmqtqX52PZQTYswQDPrXl5YQdeeRDfBAQtQ
 /AYB8QDo/i9UVP9UmGbJMUAWjHgBrARWBuxsJqWD0xJw+PXU5kzPW4BxyppC2wp+dw4v
 RrmjOTy6uWC7IQgcSeS663c9mP3XSoAh/28kOOScDkytu+XfwjVvmO/jLRSbIHyCdakw
 yu4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783435772; x=1784040572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8dXC3qhNMMWw97FDxwoE4srNdTqVNi1YC+JexXxDPU=;
 b=P0nja47Sam4fqC4vctkT3qiaEAKEzu6Jn3xAXZfVodCjtQ4omr2FvPuDn/2+vq9mwg
 zKxbYmFLPU+TZ3ZrhL4GHEXUQTq5Yp6UyI5uKiQli6LIhRuRE1KB42cS1byO/9opKBJz
 KjAzmxWzCeL7B5vJqdfuDsVDESeCAQuERmqoJK+rfWoLyi15KYcmjtbUn1E1kkQ2N7iu
 S7yVqDn75dsvjwdFB65d6Uxd9Xic64P1til/2Ukhr2O9x9swNLmT4YtGp17fpJGwUqPy
 r4tGGwmcZXMv9UJsfE64xF00iUdMyAOlimuaJq3Zgg2k04VACx9ZPACryEAjU0McP/IZ
 z4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783435772; x=1784040572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G8dXC3qhNMMWw97FDxwoE4srNdTqVNi1YC+JexXxDPU=;
 b=Ngrbs5adf6yGAzokhv7J8UXXgvuW1lLjKJn5PgStXFtKIKXGAsGmQRPT6dhiGgnE0b
 4Z5xeixs0IL344sDAyGBIRQ9dgaGFV55iDOzOl/J4q+eAfbGV37dnHI8fasfrnHWIx6Y
 FDxNh1NKWrjHhyeDLORwCL/eVFx8Ea10hSSsjlnH4GqNonc5ctvQFcGUY/CAJf65BqlY
 sUZgBfS2CnG+g1jv8+cyYrBu6k2/1l7Lh7HhTReNv3BcJ4KCNwpn1HMUNn3XdZ/tsjV9
 gAtudrhJvQBdlTDZTtRncbxxe2YpnMZIEts3guLuSc6mN2yjyLLsEo0jKNxAjTxH0sWw
 HOzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqS1ntr7rhG5BuweDA13fCj/YUhQxjr1DE3gLzuqPnTrX1Qt79vtwJgLMz4FnXQGKDsXIAkAjYT3/ws@nongnu.org
X-Gm-Message-State: AOJu0Yxo1U0HMCtKKnHspuO0UDYT5qQwsBHbS318Uo2xXGYPxu6AbGGq
 Mm2Q7xrbBWhUApYgqxRhrCGWFRBoJHyzOHgKvH6PUkS+TcMY+g3QGLuu+hBUf4/ByuBACDYcsxg
 vEcCnJYQnIgMIYOhN6Z3DI+hdyM8sEN8=
X-Gm-Gg: AfdE7cn84/zGJgnk23f4AHd7VobQsCKwRfBct5HoDOATUVzu4cNQD55rbF47fQoTtZt
 tFuibNTK7Rxfgr/sV3msj1546RoTvHyrdILhEXZnMYpMqXdyqayiVL4mlqpuPqqGfmINHT8zh04
 Bby4aaCXoVJnbZrDmlmTObeditHra9+QNsrlQsnc6plVmsQf7Olq18uXconUYlED/jg9hLx/2uU
 EPHbHnByfke4f6ey3mjpO8xWICHaa/sg6lIlArex1Or7con69IN8cLFBKiV3Hb1BA0iVD8qTtn3
 7P2uk7jt3Kwv
X-Received: by 2002:a05:690e:24d4:b0:664:cca2:8c35 with SMTP id
 956f58d0204a3-66788f06c8fmr1863784d50.29.1783435771854; Tue, 07 Jul 2026
 07:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260707083431.219671-1-bin.meng@processmission.com>
 <20260707083431.219671-5-bin.meng@processmission.com>
 <92dd132e-e4d5-43f9-a207-c59697c87204@oss.qualcomm.com>
 <1e79dc11-0df2-47ac-a1c5-819398303e48@redhat.com>
 <a13c292e-fa89-4953-9893-d09629ac9872@redhat.com>
 <20d58663-a8d1-41ff-9348-cae4982c30f0@redhat.com>
In-Reply-To: <20d58663-a8d1-41ff-9348-cae4982c30f0@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 7 Jul 2026 22:49:20 +0800
X-Gm-Features: AVVi8Ccx1j3UUZdW8t4ixpmYES7w-_G0KaTtku2V-saUQwXsaZHgiqQgfWNClTY
Message-ID: <CAEUhbmU0_XTvpNq0igBbp8UgBnG9JMiUuFBhbL99FeWjXOFD+A@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] hw/block: m25p80: Fix dummy byte handling for
 Spansion flash
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb130.google.com
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

Hi C=C3=A9dric,

On Tue, Jul 7, 2026 at 10:27=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Bin, Philippe,
>
> On 7/7/26 16:05, C=C3=A9dric Le Goater wrote:
> >
> >>> This breaks the test_arm_emcraft_sf2 functional test:
> >>>
> >>> not ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
> >>>
> >>
> >>
> >> No problem on my side.
> >>
> > Sorry. you are right ! It fails too.
> >
> > So we have a machine using a Spansion flash.
> >
> >      spi_flash =3D qdev_new("s25sl12801"); /* Spansion S25FL128SDPBHICO=
 */
> >
> >
> > C.
>
>
> Here is the fix. Feel free to merge in patch 4.

Thanks for the quick fix.

>
> Thanks,
>
> C.
>
>  From 17ae23e5bc3629a5a301f14f47125f6f685ca9d9 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@redhat.com>
> Date: Tue, 7 Jul 2026 16:23:29 +0200
> Subject: [PATCH] hw/arm/msf2-som: Fix spansion-cr2nv value for S25FL128S
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The emcraft-sf2 board set spansion-cr2nv to 1, which the old m25p80
> code treated as a byte count. With the dummy cycle to byte conversion
> fix, CR2V=3D1 at SPI x1 is 1 bit, not byte-aligned, and triggers an
> assertion. Use the S25FL128S default of 0x8 (8 cycles =3D 1 byte at
> SPI x1), preserving the same runtime behavior.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>   hw/arm/msf2-som.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> index caf6e7e1ad7d..1ada1a136130 100644
> --- a/hw/arm/msf2-som.c
> +++ b/hw/arm/msf2-som.c
> @@ -84,7 +84,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machi=
ne)
>       /* Attach SPI flash to SPI0 controller */
>       spi_bus =3D qdev_get_child_bus(dev, "spi0");
>       spi_flash =3D qdev_new("s25sl12801"); /* Spansion S25FL128SDPBHICO =
*/
> -    qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 1);
> +    qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 0x8);

Indeed the default reset value of cr2nv[3:0] is 8 according to the
flash datasheet.

Reviewed-by: Bin Meng <bin.meng@processmission.com>

>       if (dinfo) {
>           qdev_prop_set_drive_err(spi_flash, "drive",
>                                   blk_by_legacy_dinfo(dinfo), &error_fata=
l);
> --

Regards,
Bin

