Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E951FD0653
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 08:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0EhT-0007uX-Os; Wed, 11 Mar 2026 04:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1w0EhA-0007tS-8C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 04:13:32 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1w0Eh4-0002N7-Ck
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 04:13:27 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-662dc987dfdso2399251a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 01:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773216804; cv=none;
 d=google.com; s=arc-20240605;
 b=LC3Qbx1S2zJh7MI6Npcte/HT6ydW5s1QfHJ+O04rLvcBYaQ8LlYXbLAn04ZsVQ5Ef/
 wMTEC+peyVAwvURwfaeloohU2aUa5Mm0XO6VXYzSnYhV1/mHuz3PARm5iXS5TVtH9BxJ
 cl0UInLZyQEDfbYX7HSk7z9gsEx82Yfq2DbdMygqrkyyQtgxaq+rgVSCZV7igckQ92jl
 RKLuBuyKjVFBMp0fH+fcF/9uSIw7vvtZJlfugDmzNksROHQp70e7P0caRRO/Jh01SIhT
 E661GLTaEPd6AmLFD9jGlK0Zz4ay5E/B51qXJQdFw7CW6GrDUKM+fDA26f6CsQCb9Lov
 eLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+AWHQMw8K2l/umvDM5ot3nGiQBwcgBc7i2Vm1COpjfQ=;
 fh=7kZUjiwGtRVyLftkq+g+bZbe91QBoga3q+kHOoO2k60=;
 b=Yfp5lptHSX9ETxqPOjb7g1TU/5eomrG4pjMmyrzcSOF2Jr0AcYB+c5im0X7zVm9y6Y
 DBYa5pqSTM682LLR3IlxQdt018MT7x12cBh/L77CoD1B1hVsXkpepp8B9RR/+XvBe7jQ
 fek8ci82S4fX0EJ92/ri6u3ggpkyHUlK75C4zo3CwO5jmc7ElPXpcB2/m/1rE25aqutV
 IJ5E2575QOEqlpMd3SDaB7Y+oDEWDgUF1kM+eRzPeoWtARfvOmsjJI2W1o1mV7bz61UW
 qgBowd8AukVVZ0VqALAnJxHnj3jiP/XnU9TnK8IgfUmglF6MkxWl8IX+v3t6y3XCZjEh
 HpVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1773216804; x=1773821604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AWHQMw8K2l/umvDM5ot3nGiQBwcgBc7i2Vm1COpjfQ=;
 b=k/fPLIyPoeyiQTzZVOMSYIo4s6WTGnhtIl741AYDL3aNr7tmMLbi7Mh6zVAbS1pzzI
 sNSaEoC0dIHlPo2NUWL2PGyhYkXEsH4rvyrEqyRbdbsafQC+J03g0G+drt+Aze/sFPH9
 9tCJ4R+2ulp67NszIjeN/FqnkXBKWKUFtOBcrSpJbwMf7lzUYlEZhrBnvSzIPy43Y5CZ
 gIWQSf2raAXBbqR/sCSWDjt+xQwRVm+nQr8CJ6L0gVYmW7mCMZY/ldQvFrLCOmUFNhhx
 vcpH6LMRPLAkUWQw9lrvcWBwEBrd3a8ISJP/X/34rGkvF9/L2EnykKgFuiVz4jP01AwR
 3pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773216804; x=1773821604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+AWHQMw8K2l/umvDM5ot3nGiQBwcgBc7i2Vm1COpjfQ=;
 b=OfZXRYxwUhfei7T+k9dx2sc+wYWTAX5mwCSc/g1iLZQMnUvCD1O2c/0jonP70DcSq2
 FF9tO7u9jFvTuaaIqGDJNiV1xWCCWpEyF6N4S+J6YuRkaIrXYcs4LtbU+dQ/qJ1r0iLp
 gFaIgzkcWLCgi52j22AldE43JremHJDlO60PgNabI6PvW0r79MQy+TDnb+Otd8RmjvvM
 UyAhEK77sMPv8SkywKkYuTI1BL3Joootj6UiQmgy64CB8jlf3kTVw2A5vJFfHcw+ebEV
 q4H8UvWCSv42RanbaVsY177OGANbtYLEHJ0B/zarkF7WYJ3qOKpCJPrsGqxOgOjnJHng
 8fSg==
X-Gm-Message-State: AOJu0Ywr61ANvktrNWv4Kj+tacKzLbtVNZjYlx7PjCRbo4u5LSW8dYBr
 J8seyXff/Jmc6EMf973wX7fdBBvumMMYtYIKoJ+NzxYiB546IKyxedVJFprYDegYqZZVU1sdWqv
 v0cS/01m34dt8/HGnb/HYQzXltqwPaUeoGXX09xMK4pp2fMsYp+o=
X-Gm-Gg: ATEYQzyXLAZPX7tZ3BokQWCvXgt4sbSTECPtzx0ts0/woTLQwJwVNcU4QN5efslg4/T
 pjJgns4g8hpBCr8qJlwuE0MX0DevK8HW/py0E1PVGg+4U8PnHjLnacw5l8dS3PW/SZ0Y5V7b4r5
 iBIvNnGyjz3pTNe+5bf/gGXBOjlKG6PcY3fiB5TcjDSEpTbIBy+7vVTtKJx2PUiMewyh0bvuiQE
 Phku0dygJl+ojZdCvKbziHOjQeb98AXYqUb/WF15ISz6V8hShLUvpepEjqWesRj7KKqTf9ykDhI
 SBGNP2GuubrVPtF0BV3LNbU8VAprpGp5KIFsbJ9ufQ==
X-Received: by 2002:a05:6402:35c6:b0:663:a14:b8c4 with SMTP id
 4fb4d7f45d1cf-663194d5f62mr771630a12.10.1773216804179; Wed, 11 Mar 2026
 01:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-3-viking4@gmail.com>
In-Reply-To: <20260310182801.196443-3-viking4@gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 11 Mar 2026 09:13:13 +0100
X-Gm-Features: AaiRm50Oz5lwK7IRWZoxkaNkRXPh6JSL_CRYCXlghRQHpWbZpiF0OI99i0JHNWs
Message-ID: <CAJ307EgitD_KtieRL+_-TNs31EiLESt8vm7eVQ23w1tEkxV_Jw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/core/loader: fix error handling for get_image_size
 callers
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <minyard@acm.org>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52d.google.com
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

On Tue, Mar 10, 2026 at 7:32=E2=80=AFPM Trieu Huynh <vikingtc4@gmail.com> w=
rote:
>
> From: Trieu Huynh <vikingtc4@gmail.com>
>
> Check return value of get_image_size() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 2 ++
>  hw/sparc/leon3.c       | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 012e2ee4fe..fd875491f5 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -2561,6 +2561,8 @@ static void ipmi_fru_init(IPMIFru *fru)
>              g_free(fru->data);
>              fru->data =3D NULL;
>          }
> +    } else {
> +        error_report("Could not get file size '%s'", fru->filename);
>      }
>
>  out:
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 9147d56bd4..c821dfd3bb 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -354,6 +354,11 @@ static void leon3_generic_hw_init(MachineState *mach=
ine)
>      } else {
>          bios_size =3D -1;
>      }
> +    if (bios_size < 0) {
> +        error_report("could not found or failed to get file size: '%s'",
> +                     filename);
> +        exit(1);
> +    }

This makes the bios mandatory for leon3 machines, which has not been
the case until now. I think we should introduce `-bios none`, as in
RiscV to allow such possibility.

>      if (bios_size > prom_size) {
>          error_report("could not load prom '%s': file too big", filename)=
;
> --
> 2.43.0
>

