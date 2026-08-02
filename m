Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC18DC55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 10:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqTNL-0005ZP-PR; Sun, 02 Aug 2026 06:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wqTNI-0005Z9-Qs
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 06:24:57 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wqTNH-0007Jb-BB
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 06:24:56 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so1435100a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 03:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785666292; cv=none;
 d=google.com; s=arc-20260327;
 b=lbKvS+AThhuF5l7QovtSOmeTioip/k45tLPyqM2jaRm03M4vtqpGfGcWNJeP8ZmSSC
 r1aSBWXMrkdY9yj15b7LEP8qh0YlzamUncMJ6icEQ0O1SediQSTdp7dgpMGfviwm5Eaq
 4kHDVaqD9reoDq1NptEhDZ9yKAa6JQpTJYPy0peTle0L1hlXL099m3QWWFi/w1wDqKWZ
 MOdmCA5Z6iyOyvTWeKYPfHc7nE8ww++sccOp6GdkcyHGwvKJL+eBrcrTd0PNBWuNTJ/T
 fc4bgta9UL16XtWmKxOw+bbxxhwG9KfNBnSmQUPiSpHaEdkVLvFoNJHC0CX2DeI+pTSN
 NqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6hwSX6QhVijmpbJ/TSk2J6IuzOZpV/hvGmiIGU2ZLyM=;
 fh=2gIQpNzzkpXG5m7LosEkt1nMI2+u+V9HZRc2N0pBrkg=;
 b=fQYY39KsQNyRodrY5U4u8/6Jl6kODBLfU6cYc98MdH7e8b8waIKOzAOXoTdzmd5FBv
 DbFqwFtY3PoYy0FmFCY/YjMv4i1YOfhK5sMiWhMbBaLM1Qr/LdKsAHJfbvGMysMO7+ob
 qsy8+X+Mc9dpV2NcqlXAKVE3+A9KNbTt+pfKalMV1SVh6lVVJtjqqCE5MlJG2qfPokxr
 Pz4+hh+cVyRA3dnDOppAcFqvtq1eALDMjCwJtKzriG41sGuQeZCHrbnk6wn5m49MOBwq
 bzYxVxS8ctpCCJ4Or9fqr4DpA0mZt0ynFvwVGNJYMGtG11rVUnwjyOULZn8WOhQDD0L8
 Ezrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785666292; x=1786271092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6hwSX6QhVijmpbJ/TSk2J6IuzOZpV/hvGmiIGU2ZLyM=;
 b=bZVfBZm90M+BfiHvUcqu8eVee/q3uq3cyfUBKI6OmUP7Eckvpu2OC0r4eZpz8tzQK/
 cZmY825wPg4oU0hDT7XSN5yN8iPb6BqDCmvg7TNRwVLZZSGovjToYjybDCnvsQEDSHhg
 1gmhzliVGOee0NGzBl78mi+cZw9iZH3c3fZcqnOruw9tEqgQ1XEtMdCPMgEJtUSfb0rJ
 TzkH2PPS7N1sMO8uPEM1sHA6ujeQ9yc7Mwg4KmIFPACMthz+1ynuzP9K6N/9YtHt6odm
 jgMlBY7/HKqQzhU+BA+HYD20SJwHH15ro+A521RM8xgd4UNrpemrk7XLUXPmBh9ZnFrG
 paRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785666292; x=1786271092;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6hwSX6QhVijmpbJ/TSk2J6IuzOZpV/hvGmiIGU2ZLyM=;
 b=tYNQc5SQr0zNEvfII/RKJ8/2G7Inm5VkeM7gK6Zf47L0v2FpdI4Tz3iyTEvpDF45c9
 kKeFY5rsQlbRf1wuKB0uRGXlhVb8O9ahEGDOhWeSpb1m6PamuY8XUTUGCS4lA1MxCVV7
 XLayg/0G+t6/7ZOKT4ztOwR4fapbMFUBqAbm4Dco4dRBH3gEZ/UkqhiqVphnYVhLoTJ4
 P49bzPFy70PsMTfTn/ZD+Ainp4sf2ym1UgWtAmVIPLStg9rQIVKPoMiNLorowx51nyRn
 L3TyUemHm94Fxf+0xERkY/xqxyR9iUF844Q1z5msYHyLy4OMPrseMw4OZdUxcBX5K3lj
 HMqw==
X-Gm-Message-State: AOJu0YwCxJRuGYfttIN3Nl/nsu9G5uTfdeL4s6VpCydV/N/9CxQH+AfF
 /kPDohJwKnegY5D4gnBbUOv8V9sM0rcqifwf7qAclgvvnYhJX8z47wgD8q7WMiA2RTkBiswjVfj
 BdAaDUGe34o6zITI0ew7hBtngichySps=
X-Gm-Gg: AR+sD10KRBLLUe7PQ1k2QB4eU+6fwFDUZBEft3SodPgRK2SSA6QfTz+AhRXS0OxHGrT
 sx7rhg+/3w7dr9FmIwbB3sgmKExBaUTjRt/0aUmwxYvjlJX3FpbASgnHnIKVP+MoS1gm+qs1Lpk
 h4j1kL5F/2COeCqeRxcV+xqegQb5wf2rZV8qU8djvX4FtRgrRauGEaXAD23tXcMQfjzRIeiF3XK
 Ev3/peqWcPWLmq6OtO/NA10WKM7yopTsBtk10ZJt5g7z5ZEJaHQVgAROQlNiBitli5SDFYOFbXa
 V5yuUpAE56Lr+6L0iy6bQHUifzMaN9AseYlyYV1jszTQ1MlCS2n8CurE0gtC0UGtWGgk5VLSrRZ
 xU8GOzxiNz14=
X-Received: by 2002:a05:6a21:790:b0:3bf:8230:1b71 with SMTP id
 adf61e73a8af0-3c91a909268mr8755753637.25.1785666292031; Sun, 02 Aug 2026
 03:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260802-pvpanic-mmio-shutdown-v1-1-483771ad0c9e@t-8ch.de>
In-Reply-To: <20260802-pvpanic-mmio-shutdown-v1-1-483771ad0c9e@t-8ch.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 2 Aug 2026 14:24:39 +0400
X-Gm-Features: AUfX_myo_XkZ6MheoR7hfTZzM_hjcxMSnhzIeSvUbWNPZ2FCos3wosSs2jYCvoI
Message-ID: <CAJ+F1CLBUUiOuiRJhtHL0oSdO2Uu9kHc_aRstaAHbvZ8BLK3nQ@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/pvpanic-mmio: Announce support for all pvpanic
 events
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52a.google.com
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

On Sun, Aug 2, 2026 at 2:08=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> The pvpanic-mmio also supports the PVPANIC_SHUTDOWN event by virtue
> of using the generic pvpanic core.
>
> Currently this is not expressed in the 'events' property,
> so users can not discover this support.
>
> Switch to the generic PVPANIC_EVENTS macro which automatically contains
> all events supported by the generic pvpanic core.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>

This changes the hardware, and should only be modified with a new machine t=
ype.

it should be enough to set it back to PVPANIC_PANICKED |
PVPANIC_CRASH_LOADED on older hw_compat.

> ---
>  hw/misc/pvpanic-mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
> index a173a1a9a589..40b167b8d8dd 100644
> --- a/hw/misc/pvpanic-mmio.c
> +++ b/hw/misc/pvpanic-mmio.c
> @@ -33,7 +33,7 @@ static void pvpanic_mmio_initfn(Object *obj)
>
>  static const Property pvpanic_mmio_properties[] =3D {
>      DEFINE_PROP_UINT8("events", PVPanicMMIOState, pvpanic.events,
> -                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
> +                      PVPANIC_EVENTS),
>  };
>
>  static void pvpanic_mmio_class_init(ObjectClass *klass, const void *data=
)
>
> ---
> base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
> change-id: 20260802-pvpanic-mmio-shutdown-9ad52be82b19
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
>
>


--=20
Marc-Andr=C3=A9 Lureau

