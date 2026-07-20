Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBD9C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlpKO-000420-NT; Mon, 20 Jul 2026 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wlpKL-000414-02
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:50:41 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wlpKJ-0005Yi-9U
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:50:40 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81ef11a0972so35834537b3.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784559036; cv=none;
 d=google.com; s=arc-20260327;
 b=ey32gFyNaYZldzQJXpg0+H9FaAKZgRGk+8P3iH98r7Vps8cZU+cn9JHgtZhOyg6sMx
 CoodpDmyzGIPCoJlfvQ+5G/SpfTnR6XvFvMNobDsltp4ZMa4c3WpNkNMCfjmhsmw2CJd
 YHJU5lNnUsNRP1L9kzn29P9VXnpVvNU8gorjCBBHTPyM3ADSXYPc3bF2ezDV5hXNyZXK
 89LI+wPM745ABGWcEqSbQXIveXQyo6nWCTvuvlKQUXZcBuTyQo272rm9ce10a2e9cpSr
 hJemNI4NfYVAHQo5YrLAWAbrWhuni4sd3TnJ6HJw0UgmHRqgReRZHvfvGdxtmXy+8xx1
 Jm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yU4Eg9Gpp85hS9tSpmgE7x7ognflN+zziQsC9Jp6pmI=;
 fh=MObVK6jyoheTNC93lvrqcrncRVan99RdZ2q9B0zA5tk=;
 b=lci9m2Phb5omk93AA9EI5K+wOm0/Bg7aQfih7ZAO4uafSQOlfBYnFk2wWJVxiPxlh4
 4LXvNCQ245Wq6iX8qnnEfATuWlIeLL8LbKicIxVv+CeVM4UO+7+AEkWwZvfyUq2EWfEJ
 cL/XTs3yd+u5gPY97WsaZ8Cpd7IsOdWfwlJZSPSUCXLJST4jl5pIkXbR5BvmrpXO2Rnf
 TwJFqkv/5y269+50NF3fCOCAAwjUbRRRkVqJed/o44OMCwSUp5Wz4vI9LC88WTxOcT4p
 F7Idw4eCwzIDIDOY3Rm+lJ5scMF8347rD44AgXKmr5twyj7D7TmiXag0lBLOgKWSIINa
 dbXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784559036; x=1785163836; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yU4Eg9Gpp85hS9tSpmgE7x7ognflN+zziQsC9Jp6pmI=;
 b=gt17ER1XlzucfrFwfjwy4KIYQOsJjTk2/GjttRJ1pKSxKDkj5Q3PH4G/fwUyf6fnfd
 z5XAlhaFUpBkvc4tL5vx9LhHF2mffD/E1M8+aQCGD8namIKIClYuG3ib+uDdKRdq/Llb
 H2DPASGnGynynEXIlSwktAwxl+8ct1YvB4hXcgz2j3CntO+cUo1Nmm6XZZbzmDnITBAF
 J6MK5f6MxgYEg8hNJWG/XhazGbKKk1BDB3y0WrnxVyVJ53WV2dh7J5nScXKleiVCUa4/
 ca2IiovF/InafQO630at5H4GZJlFTT2N02usbXSawzJztxa1QdhXz8fAf2Gf+BMALQXq
 GpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784559036; x=1785163836;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yU4Eg9Gpp85hS9tSpmgE7x7ognflN+zziQsC9Jp6pmI=;
 b=W0qbRqHAB10D8YGtRBMYqL+ycmHP4AZQNz9LXppTE/elr/nThdMEpLX886aXSLo5SI
 7uwPNfkYlEkqnIGWEIUOpcpdE+qgtdCxrNBZr8fCO9aqCPbo9EEJjFs1dLeSWbIzbvJt
 ypisJEVX1ukfivoUiqaRjxAhoMquVJRxg5RPDkNiZESDw/eK6e5Y5GDwrL/6KxOK00b3
 4CvJ3cQb4rOhVp2mHI/zukYLouZTiG1aeDYwS9GJbuKuXX4Q0sXyv1nd7IVYwjs5cDxz
 NZq2ng4dHfa0lgUE5p4s1fm5ZtOC35ozSL1baGpHL+awc5QNsJOL3heL7XfALEG6dp0o
 lYwQ==
X-Gm-Message-State: AOJu0YwbFPaV/KIqNBTKEyiA/sjYhYMXphwkZFumTyxDGFTMcKdGq7aQ
 Z4O6qvSpc80XEI2bwIkI6v+V5tlx58HUmB1RTnDJIUneWsmfBAsDWoz/0F1uHmLIKERFSTytrIG
 xo8YZX+VFuaW4eDc3dGFfgPZD3U7zn/k=
X-Gm-Gg: AR+sD12JdtVnITMTpzdOGmo/06vd+MYP1SRLa/OoUyM0Etu6bGgtNfssRC/BHV+4fwy
 696SS2ToSFAwVDm0RccAh6m1GIZyH4LQVbTG9p/QkwMuQXQzxghVymN5Su9e21ct9iY+d/ZqRxM
 KD4OZ6aRmjO2QytH33Br6Lb0tn15mZ29g7lNRKBiFbgrytaozjgXAVUUx4FbPeZg+eY34hBY3GN
 lad1hCC6a34ojOWnXchuudngf+NitKgqIPdhPimGn7y9ej4SjXwdgUaUCfil/RlCyV9y8qt
X-Received: by 2002:a05:690c:b88:b0:81e:ddfc:3db0 with SMTP id
 00721157ae682-81ef22e432fmr43420837b3.9.1784559036082; Mon, 20 Jul 2026
 07:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-3-shentey@gmail.com>
In-Reply-To: <20260719211923.1079282-3-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 20 Jul 2026 22:50:24 +0800
X-Gm-Features: AUfX_mzURYxr_jOy2-ry5_1DfSxgZeK54F34llLrDTEaeWanjPtEhCX2TPV9tUA
Message-ID: <CAEUhbmWhqc+_7MQA3Y9ZG9vwBjsbE4-w3tsx7Ep1CbBHze3Mcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1130.google.com
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

On Mon, Jul 20, 2026 at 5:19=E2=80=AFAM Bernhard Beschow <shentey@gmail.com=
> wrote:
>
> In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc() while
> the eSDHC code path uses the standard SDHC interface. Extract the quirk
> into a new `usdhc_write()` function.
>
> Fixes file system corruption on emulated i.MX53 where Linux'
> esdhc_is_usdhc() returns false. The same likely happens on e500 and
> imx25-pdk machines.
>
> Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/sd/sdhci.c | 73 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 29 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c86dfa281f..e58a610397 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>          sdhci_write(opaque, offset, value, size);
>          break;
>
> -    case ESDHC_MIX_CTRL:
> -        /*
> -         * So, when SD/MMC stack in Linux tries to write to "Transfer
> -         * Mode Register", ESDHC i.MX quirk code will translate it
> -         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
> -         * order to get where we started
> -         *
> -         * Note that Auto CMD23 Enable bit is located in a wrong place
> -         * on i.MX, but since it is not used by QEMU we do not care.
> -         *
> -         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
> -         * here because it will result in a call to
> -         * sdhci_send_command(s) which we don't want.
> -         *
> -         */
> -        s->trnmod =3D value & UINT16_MAX;
> -        break;
> -    case SDHC_TRNMOD:

Looks like this register is not eSDHC specific? I looked at linux
driver source codes and suspect we may need some more turning here
other than uSDHC only.


> -        /*
> -         * Similar to above, but this time a write to "Command
> -         * Register" will be translated into a 4-byte write to
> -         * "Transfer Mode register" where lower 16-bit of value would
> -         * be set to zero. So what we do is fill those bits with
> -         * cached value from s->trnmod and let the SDHCI
> -         * infrastructure handle the rest
> -         */
> -        sdhci_write(opaque, offset, val | s->trnmod, size);
> -        break;
>      case SDHC_BLKSIZE:
>          /*
>           * ESDHCI does not implement "Host SDMA Buffer Boundary", and
> @@ -1891,9 +1863,52 @@ static void fsl_esdhc_le_init(Object *obj)
>      qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>  }
>
> +static void
> +usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
> +    uint32_t value =3D (uint32_t)val;
> +
> +    switch (offset) {
> +    case ESDHC_MIX_CTRL:
> +        /*
> +         * So, when SD/MMC stack in Linux tries to write to "Transfer
> +         * Mode Register", uSDHC i.MX quirk code will translate it
> +         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
> +         * order to get where we started.
> +         *
> +         * Note that Auto CMD23 Enable bit is located in a wrong place
> +         * on i.MX, but since it is not used by QEMU we do not care.
> +         *
> +         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
> +         * here because it will result in a call to
> +         * sdhci_send_command(s) which we don't want.
> +         *
> +         */
> +        s->trnmod =3D value & UINT16_MAX;
> +        break;
> +
> +    case SDHC_TRNMOD:
> +        /*
> +         * Similar to above, but this time a write to "Command
> +         * Register" will be translated into a 4-byte write to
> +         * "Transfer Mode register" where lower 16-bit of value would
> +         * be set to zero. So what we do is fill those bits with
> +         * cached value from s->trnmod and let the SDHCI
> +         * infrastructure handle the rest
> +         */
> +        sdhci_write(opaque, offset, val | s->trnmod, size);
> +        break;
> +
> +    default:
> +        esdhc_write(opaque, offset, val, size);
> +        break;
> +    }
> +}
> +
>  static const MemoryRegionOps usdhc_mmio_ops =3D {
>      .read =3D esdhc_read,
> -    .write =3D esdhc_write,
> +    .write =3D usdhc_write,
>      .valid =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 4,
> --

Regards,
Bin

