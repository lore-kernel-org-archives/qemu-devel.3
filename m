Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC37CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9WxV-0005YX-1E; Thu, 16 Oct 2025 19:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9WxL-0005Vg-2Q
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:00:24 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9WxI-0006P6-69
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:00:22 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63bd822b007so2261688a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760655615; x=1761260415; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkTabYCJwi1V4WPmCP8CZ0i429l+ID7DTe6WOfyuxNI=;
 b=ZGx4LPiUId3Tweo5x2Zism2PHnOC87Yci+zm3QaXGcIMvpMga0tyo79rQl0bnv2R+W
 qFpi1ZeCW0vbgQYxExfmNqSeakUmwNs4uESRhtK4Xe2Y42iUWwKMdmtnj3mG8GySzFE/
 Fh/8emSvA2cj85ddejqHeRL4FnGjTqxj6/1JruF59eVM5cOo4p4PUaxE51ivDbsZfHo6
 3gptPXtcKkGMgQjsc9JmfP47aSaDpK8NTIVtEsVKZK8T1R7ofeJLd1LLaF3xbkW5GOll
 EuPWWBfjCHa/RNVzJbzvWjJEaxONK4pScjeaPiz2FnSSEmBhMw0BMQIdC4mdHpvq2RzG
 7nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760655615; x=1761260415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkTabYCJwi1V4WPmCP8CZ0i429l+ID7DTe6WOfyuxNI=;
 b=GsRlfLzr5tKPmcDIDnGtGCSkpraFSGHLmPIgSZgW78qe4de9/RJDZ9Uoxn6KYYcyDZ
 WXRq8FPtM+94ZNE03xEKVq8sK5hvO5GqIqUpsMbuBBlo+U61uCHR/zgOQxJJGSczCn2Y
 G0cfI0PfnLgPMeTqdc3RatKQF+7T6V0z2aGWVJz5i0PYV+vLU6Hg6IBA4WmswvuRdvFO
 EWFRp2MvdIFukgnTtH+OL4yoAdRzjW4CClNRgukQUswvSUH+72imDezY5AhyXSr4NA8L
 C4bSAv+S9NTfpY1iyGlIzXyH47CaznSxxa2spADkRjLI/VPw8spwZz1eILw8a6gTK0Hs
 2WdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHbVk9ZopOPFTCOukEsxqiReXdAzEHijDi9OF0hWqkeDHBUGG9Q4QNMTfO9SJK1wswzzcQI4wlirgs@nongnu.org
X-Gm-Message-State: AOJu0YxDsAnIbh8p96mBeucqb1XetN7Fc+x9UlztFv5k3g8SH4qEXEbo
 0t7QBp5WYzWQueeOoIE+W1No3Nb6o3R6wHPK+IWq4xCdJU7FsHbCD9ctLSIiiwpwYwQ5imZWzBD
 MLk23SXwmm709I8WKX49VFG/DJTeIXe8=
X-Gm-Gg: ASbGnctcgLLpZXM8Y2G/i7mx+6igZXm09KxvztaJkHQF2Nf8ckxz9AJ4sZPXtXbReNg
 4FKVbOmLXjMPCjekbZiTBa7d5i8QXipS8uCg0TPy81bYCgQStsGXNUIM7UKUV1Guo24/x+i8ena
 mpOLNSJE7pwrMEEnnM4NpDdHj8enNJB7IXRzEzYs/Pe/5R++k2el0PWY4LE+p4DfSyvwyhFIEMo
 3qXqkZuUP37x6Jm7DhJWTLuXYkSFRjlu9ZwsfRYjaNKRVzWjS33B/NuTqlpSHbRt3aqcbFZp7pw
 eCn3mCOVA/I///Q=
X-Google-Smtp-Source: AGHT+IGlkdVv+Sb9jaOi/staA/gUSwwr9QDkbMYBxNfWFLlu7pDSk2Tw15TtBLmHPfL5RdDzphofx1yyymfZzmXTfRA=
X-Received: by 2002:a05:6402:3046:10b0:634:bb0c:728 with SMTP id
 4fb4d7f45d1cf-63c1f6c0d4amr1314045a12.23.1760655615199; Thu, 16 Oct 2025
 16:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
 <20251016173502.1261674-6-vishalc@linux.ibm.com>
In-Reply-To: <20251016173502.1261674-6-vishalc@linux.ibm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 08:59:48 +1000
X-Gm-Features: AS18NWBahsEOR_MNyY9hlz0Uk6cbzmYSkEw8yV9m8P91cAFMcQaRRzC5sPbXCUs
Message-ID: <CAKmqyKME2SWuE0LjcgcxuR=vLLnKfqUkB2DsvuTxVgX9QrxTDQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/core: Pass errp to load_image_targphys_as()
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, berrange@redhat.com, alistair@alistair23.me, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 17, 2025 at 3:41=E2=80=AFAM Vishal Chourasia <vishalc@linux.ibm=
.com> wrote:
>
> Pass errp to load_image_targphys_as() in generic-loader and
> guest-loader to capture detailed error information from the
> loader functions.
>
> Use error_prepend() instead of error_setg() to preserve the
> underlying error details while adding context about which image
> failed to load.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/generic-loader.c | 4 ++--
>  hw/core/guest-loader.c   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index 6689847c33..433efb7387 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -149,13 +149,13 @@ static void generic_loader_realize(DeviceState *dev=
, Error **errp)
>          if (size < 0 || s->force_raw) {
>              /* Default to the maximum size being the machine's ram size =
*/
>              size =3D load_image_targphys_as(s->file, s->addr,
> -                    current_machine->ram_size, as, NULL);
> +                    current_machine->ram_size, as, errp);
>          } else {
>              s->addr =3D entry;
>          }
>
>          if (size < 0) {
> -            error_setg(errp, "Cannot load specified image %s", s->file);
> +            error_prepend(errp, "Cannot load specified image %s: ", s->f=
ile);
>              return;
>          }
>      }
> diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
> index 59f325ad9c..618455e556 100644
> --- a/hw/core/guest-loader.c
> +++ b/hw/core/guest-loader.c
> @@ -101,9 +101,9 @@ static void guest_loader_realize(DeviceState *dev, Er=
ror **errp)
>
>      /* Default to the maximum size being the machine's ram size */
>      size =3D load_image_targphys_as(file, s->addr, current_machine->ram_=
size,
> -                                  NULL, NULL);
> +                                  NULL, errp);
>      if (size < 0) {
> -        error_setg(errp, "Cannot load specified image %s", file);
> +        error_prepend(errp, "Cannot load specified image %s: ", file);
>          return;
>      }
>
> --
> 2.51.0
>
>

