Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A4BCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3O3-0001GX-Pm; Mon, 01 Sep 2025 08:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut3Ns-0001EI-26
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:11:41 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut3Nj-00069J-7s
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:11:37 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71d6051afbfso35282577b3.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756728686; x=1757333486; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbNVQaexgAuFhrLbfwjT8f6bBZHzfViMaeZ+WkQJx+4=;
 b=oUtF+uocsVeCryeuXvRwyOdL9ZOOxfrecTwFFQ68hlFT/8wYtkjd9Ib8c0nNJH+A+l
 jYzZJ8ez37oMS5Gu2ncYveIpxblwbzH6aGe+j5RJcLxONZg/Qaa6shiVzRUPAT7954Yp
 RSi8MuJiftVuRWirGq2gfKzlj3KiGlJFrr+W8XD6fx3RMJRLnPUh072DO4hSQXxTCOBq
 wJRLLJyYPVff2ijodD33vPa/lWPKE5l6MeUTWR4F7RJe+lclj159ZB/stAz5tAQ6ljNH
 AYQ1pmr7N4XxwEuNW1YiTjmINSG4lihwOBGfD7zhGutB3ytokjkowOgA21krL9TSZ3bx
 WaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756728686; x=1757333486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbNVQaexgAuFhrLbfwjT8f6bBZHzfViMaeZ+WkQJx+4=;
 b=pz+fwUL1q4+Y0Zw93KWWiEP7J88ZW69Sx4tEeeU+Bsaum2kAqrjsLixS13Eg9+jMq6
 XH4v0Xdb+8l+WpH6wgOhmUea3Ukiq+ueTO+ZZnBAj3En261eqw2o41mOAhBZekRPsiA2
 HDWlyDO6XtXXhMBq6D7p+e4qcj9/9Hy14zl+1g6FbrdlHX3fq41QFik7iTnhJnzTVdS/
 gOw0DYRyBOyxOLqwUC2EaYsY3v3TlzCtCDsAVL4ESQ5mbGI2d6p2gNFLDuqBy+vAt6kj
 gL7fb9oz7yZ1XD8Wt4la9nu1Esrj8s4FTtCsAC1reBIk38p0+scFFTu/bVCjQ/pzP6Oe
 GoSw==
X-Gm-Message-State: AOJu0Yyw1nZag59Psn60RDzHy4oLFCnkh1prRNtwHf4fXrfuqTEnWOGx
 6kZjPA4gD3iLVM58LT7bKtgGYDmoIqMU9hKcJqjExwcHwSq4mEJjhscsOg7MstZiqw+FikI5FE8
 UFWb9k4bfGdt0gyTNzdsJqaj9hke/sJQ/Hb37zWGM6Q==
X-Gm-Gg: ASbGnctdwW2I2Twc/Kup7ooDpB1XvYD7j6P3Cpd19ZB4Gc1cwyuvD24IX6LrLP0mJ4r
 XnKiECRQd5MmiptjVuW8ZCBBq8wuLGDAtYBQ5GF4x5dpXm9pOEmXpczJp0Asu9IAfDA2fJIYEzx
 UxScvUhE6fw5zlsMI1Tb8RHPTDlqCmBIvKCF4odvAaabboqVLQsHh1cBx8UWItuWhg2PNxF69G8
 lBdTrCzOG7wVXjNDqc=
X-Google-Smtp-Source: AGHT+IEWVYsxghN1L89xV+vGw7FY2LaeFkI9jKIlYRG6AEkR9borrcdyv7N9aW/v15HbHS3vbchG+sXJweHSlnZwIBo=
X-Received: by 2002:a05:690c:c1a:b0:71a:234c:aa86 with SMTP id
 00721157ae682-722763573dfmr74380497b3.8.1756728686090; Mon, 01 Sep 2025
 05:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250811095550.93655-1-philmd@linaro.org>
In-Reply-To: <20250811095550.93655-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 13:11:14 +0100
X-Gm-Features: Ac12FXxyiPKcSQNLKiQyuMXdfG8wyAlYhA5lO9pyTmCO8Sqiq5Co7gdcFbA1dpY
Message-ID: <CAFEAcA-XW_VV6=UUj3fcUFvuYR+Yf-Pc5EzxXZfARQrJJJC3oA@mail.gmail.com>
Subject: Re: [PATCH] hw/scsi/mptsas: Avoid silent integer truncation in
 MPI_FUNC_IOC_INIT
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Don Slutz <don.slutz@gmail.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 11 Aug 2025 at 10:55, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> For the MaxDevices 8-bit field of the request / response structures
> of the MPI_FUNCTION_IOC_INIT command, the 0x00 value means "max 256
> devices". This is not a problem because when max_devices=3D256, its
> value (0x100), being casted to a uint8_t, is truncated to 0x00.
> However Coverity complains for an "Overflowed constant". Fix by
> re-using the request fields in the response, since they are not
> modified and use the same types.
>
> Fix: Coverity 1547736 (Overflowed constant)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/scsi/mptsas.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 1ebe0b82a79..4ada35b7ec8 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -579,11 +579,11 @@ static void mptsas_process_ioc_init(MPTSASState *s,=
 MPIMsgIOCInit *req)
>      }
>
>      memset(&reply, 0, sizeof(reply));
> -    reply.WhoInit    =3D s->who_init;
> +    reply.WhoInit    =3D req->WhoInit;
>      reply.MsgLength  =3D sizeof(reply) / 4;
>      reply.Function   =3D req->Function;
> -    reply.MaxDevices =3D s->max_devices;
> -    reply.MaxBuses   =3D s->max_buses;
> +    reply.MaxDevices =3D req->MaxDevices;
> +    reply.MaxBuses   =3D req->MaxBuses;
>      reply.MsgContext =3D req->MsgContext;
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

