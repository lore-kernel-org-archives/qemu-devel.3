Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A46C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x264e-0007fF-DT; Thu, 03 Sep 2026 07:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x264b-0007eu-RK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:57:41 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x264a-0003YV-3d
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:57:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d7195706f1so24383255ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 04:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788436658; cv=none;
 d=google.com; s=arc-20260327;
 b=CGThRhpudOwF/KWHMIcGP4c2PqOORMc72PYP4ob8EXKR+gNWGfUkVHafyu7oE44Y4V
 wnsyU0tzSXkzv12hRYRHBuX/vnCxAPFBD92Gx6b378zvhUmSyingtMMY2ef27N/lUIDj
 AbjyLFhM2rHOvYxha3WhevdLqOUiu/eESWIDtVX7ZJLz7/6rmHwrOKnBxwThtmV9EN/f
 EGbl9kKOrlesYXDDvFZUZkEAkkSbpfY8SsO5bQqgYhItywCJZpWgZ28SWlHU5fLEFruB
 yaMdXfyLso5ttivF0Rjpu7mHG/uVTI3LDD3KFhWqXuDFvyp7mFK8hLsp1RU/1stA1AHz
 briA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a41c4NbYRe6hTPKCUj4KWH6Wv69uNR5nG6SZlD706/Q=;
 fh=Gd3UpVsLQrlZxFOv1Ag/ONz8LdC+yoFGP/kJRAkmSQY=;
 b=rCgOw0sbgJGcxCSGm7nS+UbKtQIR0sk6Z0z8zNCIxQZaq0iDMzuWKkoaoSN0N7rBub
 gIaG5LPSHsNHqd+Orml/1D/8JjBPf5dyuKEoOYptL6EUsEo+yxcAW/PAj7kkNmy8y48l
 +ZOFmheMkVhPHGcV9R4z6uiQiie2heV8swQtWMfhxddbg22pgfATucff7tr8gOnjlGom
 q9Qvgbh0/XOq05ELpgsjaN/ifeVYP3wdoElFz2vJ3oIkhwq/O/h+cO4fmK8YAYPzc01a
 FFCxUp+FDz2e8vdZfKcX/NUVMjVKNCji4w6sHiw/SKs9rre8i/n5HvKi/eiL4/J4Jbef
 EpmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788436658; x=1789041458; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a41c4NbYRe6hTPKCUj4KWH6Wv69uNR5nG6SZlD706/Q=;
 b=actJr6l8XlvW4iRB3obSgFduTesyYhL1OIhnQrQS+qQ3PEHJ+EO8GPowZSgUxjaU5P
 BmDBMF3oqLkhIZr/md8ExFHLuupMku9IwjqytPQhk9WMvrcvQ+2Yrv+gJqSsvLUYYH0B
 kGg7u9gNxUzgq2ZWf0WViNTaRMv1wSThii2uhTubH45s8o5zW4E3H+D2KJ33OR9ueD06
 RKH2oVU4QY411Ao8drHXegVJsE9VQ6EPyFQyYb1vSjH0kM+lLX1yL96gdZtN+4f0euR9
 G405XVwn5j6WQ17Ibn77wf6c8hqLlBMyrG1Cqw4JHNQOz+uJ4yoXjWc+1p4HYI75G0ZT
 AF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788436658; x=1789041458;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a41c4NbYRe6hTPKCUj4KWH6Wv69uNR5nG6SZlD706/Q=;
 b=nQfgdD0lFT/454RhNu/E57JEaSR+a5Xp6EonPRen3bBaVJ7TA15XglqNOb8nHetp/c
 5dFAhWySWc1DF1GTs7aitscXkFLTIl0mMu/JnZUFgFla1ZroY+0NRRGaHLPkviEY6eWA
 bag0VK8QhkN6qBAWDo3dvUIezRWms6tqIHKQKbpqSGE5jT6l6zW1qE9k5+35X7jSG1Z2
 PTjHG/GZ98P0xfyRnEQwR/M1qgAo6uqhUsWMAXyZlcf/UXqUvuuWn7/BGyaDg8zO1XT0
 6ctuWrNjVJ1cXrmxU0xP4GF2Q6TBReoY4Y9g0Kh31idOyVzUX9guvUOT+hqN04YaTZun
 GuLg==
X-Gm-Message-State: AFuF++lAhFO2F8s79QPZ7RuaqBEOVANJEjAox+570JYo9LFJvbetV/RN
 9kvHbkUyi9BTM13HiFYM2H8kqDoOYdvDe4M90q0QdBPD5I25YJXmSL9TOprdNGpStLgy3OrynnK
 J5Oh9Yti60AdNvnhkj/aSPa0nx9maRSY=
X-Gm-Gg: AYBFou1LUMn6ZdTnEdnZ0BvT7ccdlxbNci/FPBQ+YA71VePdx/PY4vVY7JfnR216uuG
 yoMFce0T89tylZ+fsRu5tnSMRz/hdLgWtc+9rj3JpDbeysGX4GJsdWcDrGOQUY6SunE1r2Tl9kp
 rD5H7ir4GM3KKZaMwW/dQL8StUcL3jSxR5InhYoQCINcgCuzsCvuVrqKjZH18cx3cE5bTZJ7Qpe
 Ndwp3l90JxCAToSmggcdU9yzTtlNlz1RzryOnNEvm+X43zWbZHwg0fVoO46wjymu7gNZ8zOpq0F
 if2zx7ePxxfV8rCHRDpPFXv/BEcryl4wqm57g9ezKA3c0l1Yan+JEqlNsfbeV+id6E9kiEUOt6W
 x
X-Received: by 2002:a17:903:1ae5:b0:2d6:fd55:3a9d with SMTP id
 d9443c01a7336-2daec5d502dmr180661595ad.3.1788436658102; Thu, 03 Sep 2026
 04:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260903100441.781277-1-pbonzini@redhat.com>
In-Reply-To: <20260903100441.781277-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 3 Sep 2026 15:57:25 +0400
X-Gm-Features: AcwNN1Uq5IRdpZ3nua1NqzUVSEG1sGqGYNz0V2D5W9rGMzK5CHhNeoJq3ocvI4M
Message-ID: <CAJ+F1CJi2kUoDqxJEo8eMonaPt4NRX4PA-YhChECO_tFNLRfqA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: reject trailers that credit an AI agent
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x633.google.com
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

Hi

On Thu, Sep 3, 2026 at 2:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> The QEMU community has broad consent to not accept assisted-by and simila=
r
> trailers, and much less fake co-authored-bys, independent of any AI polic=
y.
> Implement this in checkpatch.pl already, so that there is another way for
> contributors to discover the AI policy.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/checkpatch.pl | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012..90cb40dfe1f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1811,6 +1811,18 @@ sub process {
>                         }
>                 }
>
> +# Reject trailers that credit an AI agent.
> +               if ($realfile =3D~ /^$/ &&
> +                   ($line =3D~ /=F0=9F=A4=96/ ||
> +                    $line =3D~ /^\s*(?:Assisted|Generated)-by:/i ||
> +                    ($line =3D~ /^\s*Co-authored-by:\s*(.*?)\s*$/i &&
> +                     $1 =3D~ /\bcopilot\b | \bchatgpt\b | \bcodex\b | \b=
cursor\b | \[bot\] |
> +                            \bllama\b | \bgemini\b.*(?:pro|flash|ultra|g=
oogle\.com) |
> +                            \bclaude\b.*(?:opus|sonnet|fable|haiku|anthr=
opic\.com)/xi))) {
> +                       ERROR("QEMU does not allow using AI for contribut=
ions, " .
> +                               "see docs/devel/code-provenance.rst\n" . =
$herecurr);
> +               }
> +
>  # Check SPDX-License-Identifier references a permitted license
>                 if (($rawline =3D~ m,SPDX-License-Identifier: (.*?)(\*/)?=
\s*$,) &&
>                         $rawline !~ /^-/) {
> --

lgtm,
on subject of trailer checks, I would also kindly ask for review:
https://patchew.org/QEMU/20260727161157.2112984-1-marcandre.lureau@redhat.c=
om/

thanks!


--=20
Marc-Andr=C3=A9 Lureau

