Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F335FED2F0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bZ8-0004hh-Ru; Thu, 12 Mar 2026 04:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1w0bZ6-0004dd-RY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:38:44 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1w0bZ5-0003mw-1Q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:38:44 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so952803a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 01:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773304719; cv=none;
 d=google.com; s=arc-20240605;
 b=L8snGpljTQUJ4LGa2ynY+NbDZCAWSsLXfuRkh+GtEJC8Ytk9cif/ND0cBmaNMXb8rV
 DAFiwn+rgmY+2DQU0jm9IgpmIvvR1tYRQtKLsflXCVLAYyjF+0N1Bf7fTUHa3we8F1fx
 YDFCIDHkQtq35ap5pLSyjPXVRrBBiv/ZFfDpJpDrYPZeOS5KGaS1CFSmJeTzWjo0Sgmc
 OP/RTT4YeuDuSngD9fmv/JWcyiLy38545jHrjqTz+Q7e3IGC2wSqkPlO0bWRNb/qwwSc
 MopijgfMxaM1l7U2MzaL6ujGFlC8mrE+UrrLa2n11nI/BpZxBDzz+EU637sISQiGGbUI
 GJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1GqtqNj6teKvWK4vAhmx5TVHyge1gd+FujxZD7rXYrQ=;
 fh=7kZUjiwGtRVyLftkq+g+bZbe91QBoga3q+kHOoO2k60=;
 b=QJ3UCoD9GLUDFKxnE1/XGodgjR2zBX4s8mb2/z6zdF8kQ5RQNlcRixiF7PuNvEocBi
 ru1S4rrDjy0dnqxOjqoKFjIVdlPix9ZCCylPQjE9xx0uS37c3g0R4im8ffsVTpBMz/+T
 V5jTb0NplBEA2YO/A8XwmYzYgQd8c4RmCECAd3qRuZ2gTIKuTcWtfqhmfvCP2551rH/Q
 iXyEEN4ppTnhC1Cab9eDj96sbb3on4memAVHinJvf149OdxOWg2Dj9FumeDk6GH8lpe9
 EpMXMwMh11LhAOVi3+XDhVJeqgVRX7+5O+aMPA2HIi/hCGGFcpT8uK25dqcsNCw5O91O
 wsRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1773304719; x=1773909519; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GqtqNj6teKvWK4vAhmx5TVHyge1gd+FujxZD7rXYrQ=;
 b=Th4RkzC5+htmXerprwYWl9B9dNpJR+7HrxS8yPbE8FN/r5MOFoAbb1acnhTjgRxTOB
 g/6Y+xdhGwn7tFEFQmyO7fBBJiRevPOSh/ZRSrNjbHNOQ3QwWt/KyJZBF4AJ1OqdjkZQ
 8+i12AxdY2QwTU94nURFLPsZBfVr8I2OtEz5ZekiUPrmnAz5wJNR9EtXmCvNP/vNSsqB
 5ujATXwLE/iVtcnEGfQkUWoQOWv6rikh2upiqiNaMpUccwxvJAPrNdNSciXj3l0B+6fU
 B5nVNHVZ8BrgDsauqNyjX0fjCGpAuXE3KnM/s3Ckd0MvlH54V8Ujhp/c5ln89tlRDeqz
 eXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773304719; x=1773909519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GqtqNj6teKvWK4vAhmx5TVHyge1gd+FujxZD7rXYrQ=;
 b=rjEEnH1V1wf0Iq1Ia9MflUKp/T7BPZ0zIsfJlJQafCLwCnpLCEfPgMeqP0xowlRT6+
 GMkRzkjB1+EuMifVKlHshYS91WXKv6GdPlNuEXXRxffCX0mTzvUPVn51fINqhdCGksi3
 6whQLXv6kDuhgizSRLWCYQ8ktytLWH53y+NebTX7l54ANkKayVT2yZVrkI8FcQHVWMdM
 DSWWFwx8RosttSr4Uv+EfjxrfzUjRtsXbgM4Vn6Y9kFVz12yd3rVguvV1/xWTwdewPRT
 9IhB3vACx1RdxVQlEXpYLJPH/wObcLJZEG1yAWQJOhebQR9d2EH6B2d3oLH3c3OML9IQ
 Q9OA==
X-Gm-Message-State: AOJu0YyLsLShgfZZQ60Op1cViURnvToMx6ZQJzhYwCwU3Gk3hikifccU
 SohWx5Hvk+n2OTO7CTFx8+J7NHp9T4qjNjB+Q4TTtdEXn9eITzWGNPhAwSJJXKaKrwaD6r6LrHX
 0Jsp9YAlMUVyiHzyFuDk7Lc9adtnFmw8pK/LVJOVK
X-Gm-Gg: ATEYQzx8SolArmdGJSqSNxMZeSEGGliPeSFFQKSqCYqIDgc/+SXmxuF3rSPC96Qq8LV
 SsW4iwf/KETcsoRafbaAw7v2EH6x8I/ISAQpkFa2ge3GRHbYRSAaSCUloltcDSMkIQJ7yCSXWGS
 nPeC15I8tQBojtN4cK/57byRqgT7AjhG8tZi8j+49M+fE0wXcU/vnf78glZnbNTMS5dknA6jr3m
 ic0y2W6QSCUmRzCPIaI+pqDDn3MgXwnfZaVxhd+gD/IYsJPfayzFfe/G9rETFzbjUYDkwOlG2jX
 WshscHdXdMk2XDAhiRFGxBNArW62bPVDEOFBM0zX3w==
X-Received: by 2002:a05:6402:34ca:b0:662:c64f:6c7c with SMTP id
 4fb4d7f45d1cf-66319cd05cemr3093250a12.19.1773304719255; Thu, 12 Mar 2026
 01:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260311183432.214960-1-viking4@gmail.com>
 <20260311183432.214960-3-viking4@gmail.com>
In-Reply-To: <20260311183432.214960-3-viking4@gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 12 Mar 2026 09:38:28 +0100
X-Gm-Features: AaiRm51gK0zRQxBCkti9j61-WWptzSKAduiGIWeo2dk-Ecfh4rn2Q4txlqrWmFk
Message-ID: <CAJ307EjpN-VBRHvevX6GpwwPKgi9uS2FQDUMuMqmKRnq6=NrEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/core/loader: fix error handling for
 get_image_size callers
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <minyard@acm.org>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x531.google.com
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

On Wed, Mar 11, 2026 at 7:35=E2=80=AFPM Trieu Huynh <vikingtc4@gmail.com> w=
rote:
>
> From: Trieu Huynh <vikingtc4@gmail.com>
>
> Check the return value of get_image_size() and report failures
> for non-mandatory files such as BIOS or FRU images.
>
> - Use ret < 0 to detect failures in getting image size.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
>
> ---
> v2:
> - Keep error reporting as it is.
> - Remove exit on error since it is not mandatory.
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 2 ++
>  hw/sparc/leon3.c       | 4 ++++
>  2 files changed, 6 insertions(+)
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
> index 9147d56bd4..122366829d 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -354,6 +354,10 @@ static void leon3_generic_hw_init(MachineState *mach=
ine)
>      } else {
>          bios_size =3D -1;
>      }
> +    if (bios_size < 0) {
> +        error_report("could not found or failed to get file size: '%s'",
> +                     filename);
> +    }

Honestly, I'm not sure what improvements that brings. This warning is
meaningless for Baremetal programs (launched without bios). Moreover,
an error handling is already there if "bios_size < 0" and -kernel is
not provided (just below).

A better approach could be to add support for "-bios none". With the
whole bios handling section (from "Allocate BIOS" up to
"g_free(filename);") could be wrapped under "if -bios !=3D none".
But that differs slightly from your initial goal. So up to you.

>      if (bios_size > prom_size) {
>          error_report("could not load prom '%s': file too big", filename)=
;
> --
> 2.43.0
>

