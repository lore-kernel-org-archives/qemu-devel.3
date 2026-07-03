Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90846C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfd0a-0006ak-Gr; Fri, 03 Jul 2026 08:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfd0Z-0006aY-94
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:28:39 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfd0X-0007ZO-M5
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:28:39 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-664c1406f91so627802d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 05:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081716; cv=none;
 d=google.com; s=arc-20260327;
 b=F4NqwjBb1bZIFxtDIpgFZmg7ejNjbOwiOH93RicVRi2cRbL5r1VE6DdeqrpOuX9et2
 NIVP75Jp7Mpy/TMCkdktYcQN0P5SO9zf8PBPY6G0sTQVK+f6MYc3l8toOlFkaKM7bnFT
 qRIbwtUWAQ553N8VU7uq0/Qq5VnP/sE/K4fvLcgqF/mNdJ1CoKfP77pBpDoQrxMbAdqz
 VjTnSaJKs8UitbxChNfAhRvqEySFyQ0FFaU2KZgaXPPnJs2/eu9PtQmDdUyb7xwqmtSw
 2IderI0ghMPOSfew8++hVDWeP/H3XYNs4XjcoPc0MrRDjynwlYiZu2uX0ZaY1KIzKcsA
 QCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y1mcZbNY/a+uVNlOPVgzWhWMI32ePvJpiw+ndBCzZ7I=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=Aa1rxX6oUZ9K6UP/asOpkRdmHzTmkbDmc2CwT8irqwie9EDyv8JmZWCU4TEStcZC7J
 /lEfysD4cewunoNEIv+TJ8zVHhJyaJxJ2//3LCQd9Olc3+tCvveLpw4rA+rzcFDd5BaO
 id93DFyDHc3EDtLWOD7Ro6a1WwYN+pUCxCyzNLaDW8LKjrlNsMKlRdPhTprKcK+Pn9GN
 49N3T6FvWgne3dexwihLTJ6+aR+xy2K/KJZIM4vl3mu6zsMW8d3+nbygwnfFM9GuKiPE
 G6H5vnIVrJ80fSDIkvF9NgiH+GqlUAPvwcnBM0kYmcoLWWszGCRezS0jbBCJdIHcFEK3
 QHQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783081716; x=1783686516; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1mcZbNY/a+uVNlOPVgzWhWMI32ePvJpiw+ndBCzZ7I=;
 b=XsPA+8rAdvR+AhEEmVOHRj4IKOFoj3GaIKzzGudI93txzOazqcwaEAbzJq0JemCEeT
 4pPMy/Tkw9DC6ydwlmmQ7vQ36PZ8Fl6Pf7yzVlT5lHDnFBn4/wnj+Y/2N/6OeeNVVcGA
 95aD9ss37G5PoK2MHMM9pSMqyXhmmDH7u8EZNSh8f//64bOXecqdcF1YAbKSv48jrFwK
 RIINpLnitMqcWsNyueYZcZxYVEGm3bNXfdU+lcsVoGzA0eXX3sKOQNEaQUiwHkhIcSe/
 i8RdS+/dllSLqD8qXtcK3C/foi8LUIIIRw8hm/a7XzSzmAfnDzcHcIqSWC9YncezFhl+
 TSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783081716; x=1783686516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y1mcZbNY/a+uVNlOPVgzWhWMI32ePvJpiw+ndBCzZ7I=;
 b=LieRFcmIFec+08aOlNStHBvx8U5bq8VXLbuUNQy8BMMfrpMVhYVwhjPUiipO/Hv/Eh
 oPH7kH41kUVQZDyOTDDXePu3UGGDIwbie7qWr5s88Q5H+4P9gop2djfUVB86X+fvhKPN
 g1Btt9Ub0C/pwb8sFvdUvjo2+lqmgMEk8uZ0pEhPkAsYGF2rVlZDaI72SxyINCQwLY4W
 55lbFtHv1x5jODEeYqc5q4N4Q8Nxfj0SIl+FMf5Q9X2EVikYja8t143Oo8qH1QBCLvDD
 OS2RG3MnOMVrEkIPIHw/M1+IcdT8Hoeh72b4ExIP5hGnzc20xBtH+ZYGRzQYxo+UKsvC
 LRUg==
X-Gm-Message-State: AOJu0YwGXtk0YCKhPy4QKZyfmNb8INt56sGECJaDbgqd9H4moPt5hDvj
 H0SjAnAV8eM4URog5Y4bJoGU21O8PwSoNxPXbJoS/IZztyaPkcA/47VGEbJuJIpe48xQLdFL5N/
 AozSsPggL6l153M9UfbEy7s+QVb5zcO0wdcrWNkMdgA==
X-Gm-Gg: AfdE7ck/kdUEJUZfCZhBnrQXJhWH39T7qkiT8YT9vnk967YPlZf+y1tpwwVm8Qvg2ML
 DhHaT6VQC6YpYzUosKGYBi09TJcLQ7iinNSxdRqWVzUjlpnEde3ngzZO1FTeagaZzyuVcm+bnN/
 KSmZVfCS14NHad7/Ii3Opr6Pzk97GUsn7YxHCS9ZS2f4jA/OuAlCNcrJTqGHOsQGSDdbpQ9th3P
 /pY7QQQULQEjJtJI4xJELJprl4qGfG76AT3TpG+ME1QBLy/LMvbHa5xCA7+UdT/rjW/9hrQ5rWm
 pMeAbb/U/WzG8oRSkPGDIOljXQKCTKvNnjEBtQ/ZOJXSvtRC0h2SfeE9
X-Received: by 2002:a05:690e:169b:b0:660:44bb:427b with SMTP id
 956f58d0204a3-66521bbdc2cmr9157773d50.55.1783081715384; Fri, 03 Jul 2026
 05:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260512062142.67998-1-philmd@linaro.org>
 <20260512062142.67998-41-philmd@linaro.org>
In-Reply-To: <20260512062142.67998-41-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 13:28:22 +0100
X-Gm-Features: AVVi8Cd83-y_0TdFXy-W7YUlmsp4lVl0PjjHqvVFAyl37jGUbBZUhi5e7wv4rz8
Message-ID: <CAFEAcA88TQhP6HFOhrAMjRMXU3UPYcw_EGp-Fj5GfA6L_WdjFA@mail.gmail.com>
Subject: Re: [PULL 40/41] ati-vga: fix ati_set_dirty address calculation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 12 May 2026 at 07:30, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> From: Chad Jablonski <chad@jablonski.xyz>
>
> This fixes three bugs with the ati_set_dirty address calculation.
>
> First, vbe_start_addr is a word offset. All other values in the
> calculation are byte offsets. It must be converted to bytes.
>
> Second, when setting the dirty region with memory_region_set_dirty
> the vbe_start_addr is used to calculate the start of the dirty region.
> This is a problem because the vbe_start_addr is the offset at which scan =
out
> begins. This puts it in the visible screen coordinate system. The dirty
> region however is in the virtual screen coordinate system. This can cause=
 both
> overmarking and missed updates. This is removed from the calculation.
>
> Third, when the start address of a blit is outside of the bounds check
> the entire blit is missed and not set to dirty. This happens even if the
> blit does partially overlap with the visible screen. The fix here is to
> find the intersection of the visible screen and the blit and mark only
> that region as dirty.
>
> This does not attempt to apply clipping to the blit. So there will be
> overmarking in some cases.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> [balaton: drop excess parenthesis, use offsets instead of pointers]
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Message-ID: <20260506153920.C6B27596978@zero.eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Hi; Coverity warns here about some "we did a 32 x 32 multiply
and put the result into a 64 bit calculation" issue here (CID 1660048):

> ---
>  hw/display/ati_2d.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 504d1c57085..48498677c7e 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -69,18 +69,28 @@ typedef struct {
>  static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
>  {
>      DisplaySurface *ds =3D qemu_console_surface(vga->con);
> +    unsigned int bypp =3D ctx->bpp / 8;
> +    hwaddr dirty_start =3D ctx->dst_offset + ctx->dst.x * bypp +
> +                         ctx->dst.y * ctx->dst_stride;

dst.y is uint16_t and dst_stride is int, so we do the multiply
at 32-bits, and then the whole set of additions at 32-bits before
putting it into a 64-bit hwaddr.

Should we cast one of them to 64-bits to avoid the overflow,
or do we know here that these values can't actually be large
enough to overflow ?

thanks
-- PMM

