Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE28CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 20:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw5Ou-00050H-NB; Tue, 09 Sep 2025 16:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uw5Oq-0004zL-SY
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 16:57:13 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uw5Oj-0001s6-9b
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 16:57:12 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-32da35469f7so1243652a91.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1757451420; x=1758056220;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ee3LM2mTuY71FsskUj8THQjhM2jFxw20MT+w+Yf2s8I=;
 b=ToIbaLXAxE9I/bVNIp6jnwzspyMGibxDMWb2iNjNN1ELhurnVHl3Wn3V/hSSFlWK9b
 owHkx9llaFKsG26ZJ/uKJbCVB8vSdimk7b7LPWxkHOcCvxtVkGh9QOwuVtmbr1b5gEhI
 rW/zDNzA52Qvni+GIRDZVAyKcLMPeVstl36XOkg7A03PwMG7F+KA5tZeh6/X8zNg4rJ5
 Ni3h/5bt61PBAw31mAN+AzJHu0BRXWOOtHSVmlgRAUU/MsH3ls/DyZxdxiWjexA0N5AG
 oPS1j9PPabRDI+332C8mii1Qa1+4LzdWZFsn3vxA9/UjzuD7sy3PwADF+GRXf9oM3j6W
 L5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757451420; x=1758056220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ee3LM2mTuY71FsskUj8THQjhM2jFxw20MT+w+Yf2s8I=;
 b=DC+mco/u7oc3hvRShpmRB0qgJiokPGdRVm1W/5kqYj2wQKkRBdF8IkYG+tC+44WtQW
 5P+iHToBmf0v52Zu90bHtZj1AFLZRjlU4eFAajy+cwncLaf7ZpdmVw7n3ESrhVlxdlT5
 dLSTT48EEYAUoeaW4dloI0WYQBx/JEjscyBJS5AM322mNXTsbXNSIYmR54XCXkcdTDnu
 SJSeZi9VAHkvGfVNYL8/vsduOjbPK+ZxQsWPklSOGP2BJKK1pYd/5tCXG7CYMxrcj0Fh
 lOoJeiaiPCI2XfI69m2ye3+bWW0qpZmgz/2Ph7ikCe+YV9pQqYW/a+CZNxvofZgijriH
 DI5A==
X-Gm-Message-State: AOJu0Yx2bHcEWKfksq2T67vFbwjmia+4UybO8fHhQIvq4JLLr9IR7sqv
 ktnKNnIqpQuLSWQvjjxYOwMNuS3nT7F6NEU+54auXVgBhF+V9Q2IdoGSlq3GoS/MCYowZb7Lcca
 17+swA0SaONXBlRcpILmOmo0+bYfw+1iL29K3hpLlYw==
X-Gm-Gg: ASbGncvi2TRFqe1PMLASe/85iaPceOINlg7UhDaslB5+2Rr5SD0dhKtJHH2zzTt+nNV
 lKgQAZ9fDxt/6bY3caHpJ6QpFKwekd1j45VQBIUBSCFKK10lQJYDjBzxestVNKzSk29zqqnxvNQ
 5s61VLMqJCPJW2IgLJlISWTTdDCvs8EpFYE+jxjoAj3YTHGigMyUPJL3XzpJokAPLCfpwa/y+5d
 9GDgX9AwpOhKCE4uA2X+bfULksQoLAAx0+9H3A=
X-Google-Smtp-Source: AGHT+IHi6OhA+k1XaVwnkeZGrL2Pp23vSnEPR2+OOmSdhNZ/nbCOZDP9ByD7bEuH1GPXn5nvXOh5KXk7nKDVmGK6arQ=
X-Received: by 2002:a17:90b:56cb:b0:32b:6223:25a with SMTP id
 98e67ed59e1d1-32d43fbb270mr14813074a91.28.1757451419660; Tue, 09 Sep 2025
 13:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757422256.git.jan.kiszka@siemens.com>
 <8fa0fa4158dc2e62edb59d5af8fa54a41e50e306.1757422256.git.jan.kiszka@siemens.com>
In-Reply-To: <8fa0fa4158dc2e62edb59d5af8fa54a41e50e306.1757422256.git.jan.kiszka@siemens.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 9 Sep 2025 14:56:47 -0600
X-Gm-Features: Ac12FXwJ6PyAFbsOiqtdw1W4f7IWx880C2ILEWXOiIKNCIgPjo5i3L6HLhEpv1k
Message-ID: <CANCZdfqBMsq-GW6VnaS5WfJTwoP1DVbZcr8E++2NPmHa-_4jgQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, 
 Alexander Bulekov <alxndr@bu.edu>
Content-Type: multipart/alternative; boundary="0000000000009442bc063e648b5f"
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102a.google.com
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

--0000000000009442bc063e648b5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 6:51=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com> =
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
>  hw/sd/sd.c | 61 +++++++++++++++++++++++++++++++++++++-----------------
>

Reviewed-by: Warner Losh <imp@bsdimp.com>



>  1 file changed, 42 insertions(+), 19 deletions(-)
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d7a496d77c..b42cd01d1f 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2759,6 +2759,28 @@ static void sd_instance_finalize(Object *obj)
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
> @@ -2781,25 +2803,26 @@ static void sd_realize(DeviceState *dev, Error
> **errp)
>              return;
>          }
>
> -        blk_size =3D blk_getlength(sd->blk);
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
> +        blk_size =3D blk_getlength(sd->blk) - sd->boot_part_size * 2;
> +        if (blk_size > SDSC_MAX_CAPACITY) {
> +            if (sd_is_emmc(sd) && blk_size % (1 << HWBLOCK_SHIFT) !=3D 0=
) {
> +                int64_t blk_size_aligned =3D
> +                    ((blk_size >> HWBLOCK_SHIFT) + 1) << HWBLOCK_SHIFT;
> +                sd_blk_size_error(sd, blk_size, blk_size_aligned,
> +                                  "multiples of 512", errp);
> +                return;
> +            } else if (!sd_is_emmc(sd) && blk_size % (512 * KiB)) {
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
> --
> 2.51.0
>
>

--0000000000009442bc063e648b5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 9, =
2025 at 6:51=E2=80=AFAM Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens=
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
=C2=A0hw/sd/sd.c | 61 +++++++++++++++++++++++++++++++++++++----------------=
-<br></blockquote><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=
=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A01 file changed, 42 insertions(+), 19 deletions(-)<br>
diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
index d7a496d77c..b42cd01d1f 100644<br>
--- a/hw/sd/sd.c<br>
+++ b/hw/sd/sd.c<br>
@@ -2759,6 +2759,28 @@ static void sd_instance_finalize(Object *obj)<br>
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
@@ -2781,25 +2803,26 @@ static void sd_realize(DeviceState *dev, Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_size =3D blk_getlength(sd-&gt;blk);<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_size =3D blk_getlength(sd-&gt;blk) - sd-&g=
t;boot_part_size * 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_size &gt; SDSC_MAX_CAPACITY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sd_is_emmc(sd) &amp;&amp; bl=
k_size % (1 &lt;&lt; HWBLOCK_SHIFT) !=3D 0) {<br>
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
&amp; blk_size % (512 * KiB)) {<br>
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
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--0000000000009442bc063e648b5f--

