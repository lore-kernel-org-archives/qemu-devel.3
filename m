Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF74E776FD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 19:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYUHv-0006nc-6c; Wed, 24 Dec 2025 14:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUHu-0006mh-1V
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:12:46 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUHq-00054p-OQ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:12:45 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so7554003a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 11:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766603561; x=1767208361; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLl89HoeBZ/7qns277sIVk6Koj5YVYh3H7WGsKrZPdw=;
 b=cJf1N/ucowoUK+32v86Cnk5hK1fug+l3EcIEvtLturOc5MnGF7AEXOrdglHWt+Mw4n
 Btlyol9/lPOD/M1fvPgKxaX6/VnmTjRtkno9FzwA0eRiS1VxmNYDVF711MNaWgHKcfAt
 P/k4eQOwR6ZH4cfDtG/00FBHk4Kz/N9AOqLUGSMpSVWnPjbRAZd8a8fjBsd0jK7YmSB9
 XiFbfcD54fimoKYXPbSRNkLU/azk/yIy4EnuB71aneeEfhtH62z4ptKeCmOkziN3h+I6
 IyrR8STflPOuKo6O4cAXvqSJsJueTByxu5pEDkbT9lZWGdP7erVOnKkBxMrDcv+kiITo
 iAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766603561; x=1767208361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iLl89HoeBZ/7qns277sIVk6Koj5YVYh3H7WGsKrZPdw=;
 b=RSXri0ECmJxioHOXZndmmg60anmPqAc+QEok+BOUKcQo24l7tkrYM9nS8O9zvI4jAj
 6Q4+olTKcOip2splVLUJr4lYw0UnDjRlfAd/JeIYNVrL1HhX1OGvvW1jWhA/rj5Hh9gq
 uBxDT0rugu2UpZiaCs82qbD5smb9xPYAnNVzuvHPXqqdryWM9JlsGUybWdL+nc4eDMAa
 5kfEhmS7Yf15mxBrF/zwrwu+38Y7L1MR6YVhKEh2HTn9RA0DFGawCoQJmKn5SadxdxLi
 H7Ji85BrW9HZwFE5Y+mNtgBEkAgVEBM5Q0b2aH9Odw+aC3VOArYeni0LKMRWZWRMThqF
 c09w==
X-Gm-Message-State: AOJu0YwR5y6A0WrJRL9ZHBfBY0D82UgyntPUn+gjC3z5+47lzmOsuzyX
 b8JSspL/UNW6yLBBDFqbOUQ+W6y2KKHke2YXY+/Vv8F9aLpJXVYJZ0psLhM7pC5+O2euaJYXyd7
 LzcaE9ZKYZEJPVuz2fSUMQhqEebObjb9dq0kAITcSKVu5etE6Cg8GZSA=
X-Gm-Gg: AY/fxX60tEl+55NuhjFKyZ1dD9Jk1QxwZHPHbVMOHbHobG9yk5PlyQtz0VqDnbJ5JFP
 nj+fpePxkUSI8hrCF4KHpVR/YqckPY6BXZXkdlglr93nQ8ecXXDpbrdQeIXy9TE2/4pnpKxkEVj
 KM/pR8koC54J6jXrcp+1QG2ACFKTYOvQ/Of+diTTl7e6LvdzxnmbFnz0mH9nCHnEtKfO3sxSolE
 340VbHqdxRIeddIh+cSuyAWsewlMRpm8LG3Ahm/Vvq9fcQ4n7dLio7ma/Xr0jlgQaw39s8=
X-Google-Smtp-Source: AGHT+IFCLNeRlrOPwsA9qTWV/Ef8tWs8MnAqYv/j1N03z3S92h+XBOZwmHayN8qVP7Zsl6MOxzh9lEM7cWzLfP37DUo=
X-Received: by 2002:a17:907:7e85:b0:b7f:eb45:f572 with SMTP id
 a640c23a62f3a-b80371e9f7amr1842335566b.55.1766603561145; Wed, 24 Dec 2025
 11:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20251224134644.85582-1-philmd@linaro.org>
 <20251224134644.85582-5-philmd@linaro.org>
In-Reply-To: <20251224134644.85582-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 21:12:15 +0200
X-Gm-Features: AQt7F2pyicc5oJjLnd9aP4LMaMLZhjqbQp67_KEfGJOU-myLWUx8CBy3FKdj2ms
Message-ID: <CAAjaMXZ1kYwPpEEiKMj8m_cK_eNxTZsNJdT54Givg1-WpdfP_g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] hw/misc/pvpanic: Expose MMIO interface as
 little-endian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-rust@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 24, 2025 at 3:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Make the PVPanic MMIO interface behave like the ISA and PCI
> variants: access it using little endianness.
>
> Fixes: a89607c4d0e ("hw/misc/pvpanic: Add MMIO interface")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/misc/pvpanic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index c83247c4087..3e60b226e18 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -62,6 +62,7 @@ static void pvpanic_write(void *opaque, hwaddr addr, ui=
nt64_t val,
>  }
>
>  static const MemoryRegionOps pvpanic_ops =3D {
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .read =3D pvpanic_read,
>      .write =3D pvpanic_write,
>      .impl =3D {
> --
> 2.52.0
>

