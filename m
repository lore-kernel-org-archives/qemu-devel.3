Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76E1CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJ4f-0007N0-Qk; Tue, 04 Nov 2025 10:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vGJ4U-0007KI-6d
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:35:47 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vGJ4Q-00027I-Px
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:35:45 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7815092cd0bso77347907b3.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 07:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1762270541; x=1762875341;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T6IVYkVcURk4ETxPxHlle71hw8vNQUU6RABYMW5Trz8=;
 b=ErXovg3ru/zz0+gjahHH+ZGfK/e+xN38K2fhUmCGXgW/tUIB6EiA90vl1gArvUSGYv
 tuZAC133lryH5yvBaqjYpKMqaEvm9ad9tB/VuGiCMjqD18OUeaZzALFDzvxXHs3ae53r
 WjeIu5vBRhw0uel6Jk3DN40Dtr91B5H8p0dN9Vqqax7t4JdyTefyJuITy4tJbKmKpmzi
 23/LvX6UpXIkb3gRI/BaFtNGQVhr9KXTjped/gPAmV7t5E64Ow31Ve8eggJmC6l3Dmej
 ab3jhtiNErajsYABl5JsafsVyS7BjWnAgbAwcGG8YJOCeGLLkJAGkPkBlma46vh4A6WC
 Nv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762270541; x=1762875341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T6IVYkVcURk4ETxPxHlle71hw8vNQUU6RABYMW5Trz8=;
 b=FHCvzswZ9RmOJhJCJxAb1cRbsbwP8I1ocPxGKxXC+/3F0ynRBaeNxOsi+jAgki4GH9
 GS9J/a5xZo7njbd+I5H4TJjPtnkslMJe3prFbOqeqtWuH/Bi9I1cpFBnD8ZAxHq/e+Ss
 g2Tnn8U2raP0pVkjA2UOUAv8AV7KGBA0vegCEJYTig/JiFMiGZSZmWrzk7eSQLmk5x2T
 JujEI+bGIWLvSQRYyreXH6fGWgZDD0YfHcMD92j9Heqtr/YcuMEUf3F9kFVWpSUR03y2
 neglVq7Vyd+WL2zVAimAd8/4f1VGQ08KvUjBo5QfsLHUgJcqyyd3h0LwGbkA8/Xp+wLy
 uCCw==
X-Gm-Message-State: AOJu0YzLhm5LYHpBT1UlvUBEv2RCTj+1Lll4SZTkMm8clYKrT3aSxbct
 Voe3RbPHlJCV5SFasXHIFNIZsJNkZWFYwWhvEKLeAn//MwJHRmq88Lw2AVlrg5f6yYgcmYyBfWx
 iDJH0kJTtCba9SK/8upjWUiGmb96Kf/1hIZeug0BEyw==
X-Gm-Gg: ASbGnctJTuPhMt0OVTmPirCS8GO7XGIOhN7JHfzPFyKae+xjEuRNFNITEKCKvSW2oi6
 SjlYIbACNtA0J/SZbHn5RemUMfY1jhMywZXl6Tdml2ptmVADbfSyyNz7MO00/aPuowxZi9kN0Z/
 2gS04h9SFS6C58t46gTOXZ78WG2NyuV/9mH5bId/K4ZzXLqabMEMNdqSMsDgXFsvP80eV6ImCwX
 M+WUPyyDPKsnQEQyx6lEXga2qRu0a1w8HwabNTekKIkp3gtaul/Nb7wiA1/
X-Google-Smtp-Source: AGHT+IEapWC1aQUu6X8mYAIgdQMFJuNz/czjSqlpULTur5LwrobLPvoJYockoJuIZyPyfdGY0M/OigAEMPEk7cs6d3c=
X-Received: by 2002:a05:690c:6d8a:b0:784:88df:d9d with SMTP id
 00721157ae682-786483e8aedmr254553647b3.2.1762270540921; Tue, 04 Nov 2025
 07:35:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <591f6d8a9dc86428723cb6876df6e717cc41a70e.1762261430.git.jan.kiszka@siemens.com>
In-Reply-To: <591f6d8a9dc86428723cb6876df6e717cc41a70e.1762261430.git.jan.kiszka@siemens.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 4 Nov 2025 08:35:28 -0700
X-Gm-Features: AWmQ_bn014pCMGRspzI9zyEuM9xEbku-9A4d5_WqBQTufjhAE7iFe48AmLBmj2Y
Message-ID: <CANCZdfrwQmV+5XxepeCMpCg1bs030feFU6siTZsG=RZt1F3oSw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, 
 Alexander Bulekov <alxndr@bu.edu>
Content-Type: multipart/alternative; boundary="000000000000970c200642c69591"
Received-SPF: none client-ip=2607:f8b0:4864:20::112e;
 envelope-from=wlosh@bsdimp.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

--000000000000970c200642c69591
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:03=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Alignment rules apply the the individual partitions (user, boot, later
> on also RPMB) and depend both on the size of the image and the type of
> the device. Up to and including 2GB, the power-of-2 rule applies to the
> user data area. For larger images, multiples of 512 sectors must be used
> for eMMC and multiples of 512K for SD-cards. Fix the check accordingly
> and also detect if the image is too small to even hold the boot
> partitions.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> CC: Warner Losh <imp@bsdimp.com>
> CC: C=C3=A9dric Le Goater <clg@kaod.org>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: Alexander Bulekov <alxndr@bu.edu>
> ---
>  hw/sd/sd.c | 69 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 21 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Thanks for chasing down all the weird special cases to come up with this.
It's a
big improvement for modern cards.

Warner


> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d7a496d77c..76e915e190 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2759,9 +2759,32 @@ static void sd_instance_finalize(Object *obj)
>      timer_free(sd->ocr_power_timer);
>  }
>
> +static void sd_blk_size_error(SDState *sd, int64_t blk_size,
> +                              int64_t blk_size_aligned, const char *rule=
,
> +                              Error **errp)
> +{
> +    const char *dev_type =3D sd_is_emmc(sd) ? "eMMC" : "SD card";
> +    char *blk_size_str;
> +
> +    blk_size_str =3D size_to_str(blk_size);
> +    error_setg(errp, "Invalid %s size: %s", dev_type, blk_size_str);
> +    g_free(blk_size_str);
> +
> +    blk_size_str =3D size_to_str(blk_size_aligned);
> +    error_append_hint(errp,
> +                      "%s size has to be %s, e.g. %s.\n"
> +                      "You can resize disk images with"
> +                      " 'qemu-img resize <imagefile> <new-size>'\n"
> +                      "(note that this will lose data if you make the"
> +                      " image smaller than it currently is).\n",
> +                      dev_type, rule, blk_size_str);
> +    g_free(blk_size_str);
> +}
> +
>  static void sd_realize(DeviceState *dev, Error **errp)
>  {
>      SDState *sd =3D SDMMC_COMMON(dev);
> +    int64_t blk_size =3D -ENOMEDIUM;
>      int ret;
>
>      switch (sd->spec_version) {
> @@ -2774,32 +2797,36 @@ static void sd_realize(DeviceState *dev, Error
> **errp)
>      }
>
>      if (sd->blk) {
> -        int64_t blk_size;
> -
>          if (!blk_supports_write_perm(sd->blk)) {
>              error_setg(errp, "Cannot use read-only drive as SD card");
>              return;
>          }
>
>          blk_size =3D blk_getlength(sd->blk);
> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> -            int64_t blk_size_aligned =3D pow2ceil(blk_size);
> -            char *blk_size_str;
> -
> -            blk_size_str =3D size_to_str(blk_size);
> -            error_setg(errp, "Invalid SD card size: %s", blk_size_str);
> -            g_free(blk_size_str);
> -
> -            blk_size_str =3D size_to_str(blk_size_aligned);
> -            error_append_hint(errp,
> -                              "SD card size has to be a power of 2, e.g.
> %s.\n"
> -                              "You can resize disk images with"
> -                              " 'qemu-img resize <imagefile>
> <new-size>'\n"
> -                              "(note that this will lose data if you mak=
e
> the"
> -                              " image smaller than it currently is).\n",
> -                              blk_size_str);
> -            g_free(blk_size_str);
> -
> +    }
> +    if (blk_size >=3D 0) {
> +        blk_size -=3D sd->boot_part_size * 2;
> +        if (blk_size > SDSC_MAX_CAPACITY) {
> +            if (sd_is_emmc(sd) &&
> +                !QEMU_IS_ALIGNED(blk_size, 1 << HWBLOCK_SHIFT)) {
> +                int64_t blk_size_aligned =3D
> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512", errp);
> +                return;
> +            } else if (!sd_is_emmc(sd) &&
> +                !QEMU_IS_ALIGNED(blk_size, 512 * KiB)) {
> +                int64_t blk_size_aligned =3D ((blk_size >> 19) + 1) << 1=
9;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512K", errp);
> +                return;
> +            }
> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
> +            sd_blk_size_error(sd, blk_size, pow2ceil(blk_size), "a power
> of 2",
> +                              errp);
> +            return;
> +        } else if (blk_size < 0) {
> +            error_setg(errp, "eMMC image smaller than boot partitions");
>              return;
>          }
>
> @@ -2810,7 +2837,7 @@ static void sd_realize(DeviceState *dev, Error
> **errp)
>          }
>          blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
>      }
> -    if (sd->boot_part_size % (128 * KiB) ||
> +    if (!QEMU_IS_ALIGNED(sd->boot_part_size, 128 * KiB) ||
>          sd->boot_part_size > 255 * 128 * KiB) {
>          g_autofree char *size_str =3D size_to_str(sd->boot_part_size);
>
> --
> 2.51.0
>
>

--000000000000970c200642c69591
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 4, =
2025 at 6:03=E2=80=AFAM Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens=
.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">From: Jan Kiszka &lt;<a href=3D"mailto:jan.kisz=
ka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;<br>
<br>
Alignment rules apply the the individual partitions (user, boot, later<br>
on also RPMB) and depend both on the size of the image and the type of<br>
the device. Up to and including 2GB, the power-of-2 rule applies to the<br>
user data area. For larger images, multiples of 512 sectors must be used<br=
>
for eMMC and multiples of 512K for SD-cards. Fix the check accordingly<br>
and also detect if the image is too small to even hold the boot<br>
partitions.<br>
<br>
Signed-off-by: Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com" tar=
get=3D"_blank">jan.kiszka@siemens.com</a>&gt;<br>
---<br>
CC: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
CC: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org" target=3D"_bl=
ank">clg@kaod.org</a>&gt;<br>
CC: Joel Stanley &lt;<a href=3D"mailto:joel@jms.id.au" target=3D"_blank">jo=
el@jms.id.au</a>&gt;<br>
CC: Alistair Francis &lt;<a href=3D"mailto:alistair@alistair23.me" target=
=3D"_blank">alistair@alistair23.me</a>&gt;<br>
CC: Alexander Bulekov &lt;<a href=3D"mailto:alxndr@bu.edu" target=3D"_blank=
">alxndr@bu.edu</a>&gt;<br>
---<br>
=C2=A0hw/sd/sd.c | 69 +++++++++++++++++++++++++++++++++++++----------------=
-<br>
=C2=A01 file changed, 48 insertions(+), 21 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.=
com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>Thanks for chasing dow=
n all the weird special cases to come up with this. It&#39;s a</div><div>bi=
g improvement for modern cards.</div><div><br></div><div>Warner</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
index d7a496d77c..76e915e190 100644<br>
--- a/hw/sd/sd.c<br>
+++ b/hw/sd/sd.c<br>
@@ -2759,9 +2759,32 @@ static void sd_instance_finalize(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0timer_free(sd-&gt;ocr_power_timer);<br>
=C2=A0}<br>
<br>
+static void sd_blk_size_error(SDState *sd, int64_t blk_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t blk_size_aligned, const char *rule,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const char *dev_type =3D sd_is_emmc(sd) ? &quot;eMMC&quot; :=
 &quot;SD card&quot;;<br>
+=C2=A0 =C2=A0 char *blk_size_str;<br>
+<br>
+=C2=A0 =C2=A0 blk_size_str =3D size_to_str(blk_size);<br>
+=C2=A0 =C2=A0 error_setg(errp, &quot;Invalid %s size: %s&quot;, dev_type, =
blk_size_str);<br>
+=C2=A0 =C2=A0 g_free(blk_size_str);<br>
+<br>
+=C2=A0 =C2=A0 blk_size_str =3D size_to_str(blk_size_aligned);<br>
+=C2=A0 =C2=A0 error_append_hint(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;%s size has to be %s, e.g. %s.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;You can resize disk images with&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot; &#39;qemu-img resize &lt;imagefile&gt; &lt;new-size&gt;&#39;\n&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;(note that this will lose data if you make the&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot; image smaller than it currently is).\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_type, rule, blk_size_str);<br>
+=C2=A0 =C2=A0 g_free(blk_size_str);<br>
+}<br>
+<br>
=C2=A0static void sd_realize(DeviceState *dev, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SDState *sd =3D SDMMC_COMMON(dev);<br>
+=C2=A0 =C2=A0 int64_t blk_size =3D -ENOMEDIUM;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (sd-&gt;spec_version) {<br>
@@ -2774,32 +2797,36 @@ static void sd_realize(DeviceState *dev, Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (sd-&gt;blk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t blk_size;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!blk_supports_write_perm(sd-&gt;blk))=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot use read-only drive as SD card&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_size =3D blk_getlength(sd-&gt;blk);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_size &gt; 0 &amp;&amp; !is_power_of_2(=
blk_size)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t blk_size_aligned =3D pow=
2ceil(blk_size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *blk_size_str;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_size_str =3D size_to_str(blk=
_size);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Invalid S=
D card size: %s&quot;, blk_size_str);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(blk_size_str);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_size_str =3D size_to_str(blk=
_size_aligned);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_append_hint(errp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;SD card size has to be a power of 2, =
e.g. %s.\n&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;You can resize disk images with&quot;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; &#39;qemu-img resize &lt;imagefile&g=
t; &lt;new-size&gt;&#39;\n&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;(note that this will lose data if you=
 make the&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; image smaller than it currently is).=
\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_size_str);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(blk_size_str);<br>
-<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (blk_size &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_size -=3D sd-&gt;boot_part_size * 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_size &gt; SDSC_MAX_CAPACITY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sd_is_emmc(sd) &amp;&amp;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !QEMU_IS_ALIGNED(b=
lk_size, 1 &lt;&lt; HWBLOCK_SHIFT)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t blk_size_a=
ligned =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((bl=
k_size &gt;&gt; HWBLOCK_SHIFT) + 1) &lt;&lt; HWBLOCK_SHIFT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sd_blk_size_error(=
sd, blk_size, blk_size_aligned,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;multiples of 512&quot;,=
 errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!sd_is_emmc(sd) &amp;=
&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !QEMU_IS_ALIGNED(b=
lk_size, 512 * KiB)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t blk_size_a=
ligned =3D ((blk_size &gt;&gt; 19) + 1) &lt;&lt; 19;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sd_blk_size_error(=
sd, blk_size, blk_size_aligned,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;multiples of 512K&quot;=
, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (blk_size &gt; 0 &amp;&amp; !is_powe=
r_of_2(blk_size)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sd_blk_size_error(sd, blk_size, =
pow2ceil(blk_size), &quot;a power of 2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (blk_size &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;eMMC imag=
e smaller than boot partitions&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2810,7 +2837,7 @@ static void sd_realize(DeviceState *dev, Error **errp=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blk_set_dev_ops(sd-&gt;blk, &amp;sd_block=
_ops, sd);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (sd-&gt;boot_part_size % (128 * KiB) ||<br>
+=C2=A0 =C2=A0 if (!QEMU_IS_ALIGNED(sd-&gt;boot_part_size, 128 * KiB) ||<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;boot_part_size &gt; 255 * 128 * Ki=
B) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree char *size_str =3D size_to_str=
(sd-&gt;boot_part_size);<br>
<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--000000000000970c200642c69591--

