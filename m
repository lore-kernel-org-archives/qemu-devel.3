Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368FDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 03:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBb2-0005qO-Mj; Mon, 18 May 2026 23:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBb0-0005q3-OT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:58:18 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBaz-0007VZ-A6
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:58:18 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd3d7c29b4dso452866266b.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 20:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163096; cv=none;
 d=google.com; s=arc-20240605;
 b=Y5YjmjqUwsEOFArSVqzYz9OYOxiGHEfDsn/mFnQ1jl/s0/qJNpC33PjfHfnpUAojjV
 20dHtQxb1RUGI8/jW+g8Qu0HL5wc9NyewsyTjbHO9fjSRHB4PUUEULis9AIoQxKPG3CC
 tC0LaW4ZuMg0wkQwwCwCCt8RCfydCcvQTo6JhiERkhX8fcBke+n07EKLPeErGOLBaP3e
 dY7xzONRU6ftGmgX3bG7qOYZibFih8Dn6sNKRSiTecWV3c8sJ2IH/SaqMVV2gM/7mcLp
 nd+hPzqqI+kJHxAMpRFu0yZfPBBmYTsiv5i5FbC8Cw6XFMGls11PeM6QMIKFkEdATxcn
 aU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MIGO/WGN1FYJ1807LanhB9dkxUCcjyPWrFoAEdNz0Dg=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=Y9vJmosLPuBw/WgbVwkeo6YPrIEM6sY7KWXrCGyhjQyh4i4XXT1A8FGsO09LBrEmV+
 CWtFysI8AkN9eatcGvTnZV/oAO0eyQRZlps8CFhA8ntz+mmhl8vTamWCb0Tg7qoWEYqL
 RdWNoLCv69xZV4jXhB/JNEZUz29Y3Bre16dmDfd++T0zik6ZBqr/HrGjE7fP6q6bt3fi
 MQ6FeBKCP8CTjw8PK2WH5ugXuybBk/2m7H1hWN4+g8YT2GedkwZFxrdFDNFcwrhNP67d
 eTEAeetiuf5B49j98pGX45AmosLx/g/UrDRQG7opwfVlUYqIQQo15GZK5LDtx/Wc1Lzd
 /VoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163096; x=1779767896; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIGO/WGN1FYJ1807LanhB9dkxUCcjyPWrFoAEdNz0Dg=;
 b=WnzB4GJCASapCUGD44CAcvzlGQwztck52+W5hwnI2a6PS/PH0TAEho6jplLn/h9QaU
 GBXmwCfDM21fxWJ+HSssVyrNmh6G+1D7QHLmPfXdDVFegZ+OspkM4IPjt6PnEtHhhhiV
 2WU9E2x4MvgjMqMs5dLuqZaVs1ZuXLr01E2XVtQbA3/Pis4chIUtAMhTL0bdgQ7ztc6l
 2QOE6cPQWW+W37s+TjQhd/RGE/mB+i4Xe2DRAmK+4tHcEjUhsUUB2YlnsxVIdNRB2ejo
 AdhvyI8Sc4ZN4rd+h2HDBRDGghFL8n0+GDRQ0WjyZ0XTw4NuPkKWbMTJS5DkmTbgzyTF
 M2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163096; x=1779767896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MIGO/WGN1FYJ1807LanhB9dkxUCcjyPWrFoAEdNz0Dg=;
 b=ePWd7ov2ybI8Ch2mE3J5mti9JWMgxR+kP7hMBT8ENiXz1I4MMcge9figwkC4aFPIh2
 yrwXYxGlto4Alu9mjoq1wBNdx0LRr4mj6mBZq/QA+dM5YikaqW2SeuQXsivSkXY0xhuk
 tCnXsxeIXZrje/xp50juG31DS13eWLe8oAiXDKd5NXFYohO4rz+S6li+Avaf7Xjkvw/S
 TyFxB0oplEzENFcb5b7iyEbse5s8osUhlKkAg+ZDZrB16WPkqS9buNFv6ug5p++4koWn
 9jWUft7Sx6Su9uI/8wQQvvZ8N5fYMO1ueg5IFyzR0RvzDjSY5LdXphTfuy2y+cqhB4bE
 t/Ig==
X-Gm-Message-State: AOJu0YyqTXGipvXY7ZwQosTuqaix/khu5EUOqGG/dBUV++yNyaZT1P5E
 hPlfXq33qMWOtcWDY1KGzs1pteP5J19FpKOKaNZzG+5jm+E8+MnvZ9543Luy2vx6l8+tmydivsP
 BYsnA7PkjkarzNhGj8r6ddU+h78374iY=
X-Gm-Gg: Acq92OGjO2RohA7bezvavdDLREBxYEBhDuuzdyGjc/5M8KECrkSYsXmzEJdnoFYERy3
 +eZSsG9zUdJCtVPJvI2t7amQ/kk6u5ydAgfK7az7au1gxighD2/Gt37mwdCO9pUnOij0jT/wHbR
 HOUhD8LIj5eJnpsja6PtFQhYgeYOWMDa9pxs4ZS1wxtFQ9gMED8qV2MFWDGgcqZajPV9/38jukR
 TL9oby/0l8io17e6m9HCya9GAKk955ydh4ki/ycWPfhp1A9yvv3sgRUFFaKdN/HVhaBH6X1JoPu
 0qyjbTTSwAFV3kc42Y3saZM6Ogd3wiHmn5xD8Q==
X-Received: by 2002:a17:907:7b83:b0:ba4:94f8:4df with SMTP id
 a640c23a62f3a-bd5177ee697mr1038949166b.17.1779163095649; Mon, 18 May 2026
 20:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-6-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-6-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 13:57:48 +1000
X-Gm-Features: AVHnY4KnVc5cyCIObiErqjiF2SRRiS38Unu5i5llqxJFNGN7W4jDGdQGz34OcBQ
Message-ID: <CAKmqyKPgQcKTeSyVmHbZ-PKSqONNE7MGB-TU1WGv51dUGmUrFQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] target/riscv/tcg: use only isa_edata_arr[] in
 cpu_cfg_ext_get_name()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, May 12, 2026 at 1:31=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We're using both isa_edata_arr[] and riscv_cpu_named_features[] to find
> an extension name based on a cfg offset.  This is reminiscent of a past
> where isa_edata_arr[] didn't include entries for internal extensions.
>
> At this point we can use just isa_edata_arr[].
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 92406bf41f..704105d3df 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -311,7 +311,6 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_o=
ffset)
>
>  static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
>  {
> -    const RISCVCPUMultiExtConfig *feat;
>      const RISCVIsaExtData *edata;
>
>      for (edata =3D isa_edata_arr; edata->name !=3D NULL; edata++) {
> @@ -320,12 +319,6 @@ static const char *cpu_cfg_ext_get_name(uint32_t ext=
_offset)
>          }
>      }
>
> -    for (feat =3D riscv_cpu_named_features; feat->name !=3D NULL; feat++=
) {
> -        if (feat->offset =3D=3D ext_offset) {
> -            return feat->name;
> -        }
> -    }
> -
>      g_assert_not_reached();
>  }
>
> --
> 2.43.0
>
>

