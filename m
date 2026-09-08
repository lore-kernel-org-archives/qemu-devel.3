Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BC2C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qtf-0003Pm-IZ; Tue, 08 Sep 2026 04:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3qtZ-0003PH-Ub
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:09:35 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3qtY-0003kF-CO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:09:33 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cc1bcdb3c4cso2867540a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 01:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788854970; cv=none;
 d=google.com; s=arc-20260327;
 b=BTjTJ0+TyQiMga8gLIlE/VLRcCHANScWHStD9Tu5oW9uK2GkhvEj4qJfuD0SiCaOUx
 mqnPDqEB95XasBQk1b397NXZ9SGtksA9QDQefaStgnEDKk+yuDEMbRrpbDny7HjaJXVH
 DjrZ0/wlohyadQ44W2JFJT3t60mj0qk/SkBOi0zgRsuwc21ZmP5wMNnghl2ZiG5KN4BT
 9pQVyMphMAYz6oj9+4XEL/6iKFuIysbK63b9oH9yxCRlctO9r+03opbQ+Tk5zRjQkqQX
 y/77BApUqRqvcjid6slrZ+92DpzHWGmXWJN0rfWhGbFdEZpqmqzBvHSKuCNcO5kpsL6O
 CzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=szNosciYtl9yHLnGx5eDxl91gUPp88mCyER93ICJvkQ=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=YobieQpvGOCpUKivXaup5F6u0jsM4GPloiu7pbbuQjtbJUIeuow3Uo51cC1Ls+0l1g
 C9CYetcEV2T/vQ2WsmlhBwFECGgwBkvDdSsjGC9RmyeKENCwMLRcx9FMCyZtkYPodWTo
 bAZUBX0454NjGTWy/FH5sOSuUBTTVx5WPYpDbP4yCNzAjlB5r0ksGYu92jHh9zs1rAgS
 EaQRv1aSs/4mSQZI8PbLnpYEPOgq2vN+wEtwGPv+bTg94dJysXQ6nPkyowvSGRY3/gD2
 5keH17zJGAdqWvXLAVIOZEbEjBBvcjF8r1nsTE0dcbAduOtcFGJrzPUXGd/PV6MdAeIt
 Ezuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788854970; x=1789459770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=szNosciYtl9yHLnGx5eDxl91gUPp88mCyER93ICJvkQ=;
 b=d2gpHn8vngBTpQRiBA7IDZb7G8lb4z/oSzJLIm6tyR4ZiSjLHqsqJ9lFx5XMu55oKt
 YlgzGw9YyYLshzgR0hVMB39e47GpMQ4ZTBMn6F+GEBQ8WWX0Fg/42wGJoOcho0VtESr0
 SRckz5pF+nFA32w2x8nOVBVjqLeM5lzL+LXI4HbYAsNzNplxWRsQPQ435y7RlX4NnL2B
 aLyY+0nFCYwFB3iJQCv3gtLkWgsueVOPv1U+vmuA6a60Y41mlyBuCc3Wgf6uKUpzs1JY
 jd2x04adNXZtSQ9hI3sX59vLFMoZtEWjpJqc8tlOLCfb2uzFbEfG0TN33stSFv8S3cWK
 WKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788854970; x=1789459770;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=szNosciYtl9yHLnGx5eDxl91gUPp88mCyER93ICJvkQ=;
 b=EhjRO8sWSBkasfOT/VUCqs6a4TQiM+SUwtJuYs7ccbY/Tl3KjBDW2qxYrdgTZf8J1y
 xVvya9++YS0LmUaEQWGFT0hs+3UzBjlMKMZvQcBKeYcsFb2Lw/5fnYUZhbk4VqicefXE
 4HM5CfLhxPIPXn70FvxJvwp5j9FuMl2zUlNemcCjShDr+mZq+EpKMxP0WRRU36tiBYR9
 FgbH8R//OyF7+mxK4sP6F4zqpc3TW0ZDYGeWH7Fq4MNsTFtHeURJwvEHCT3dv8/tRFRe
 /cEr27j1IxzlZLAQQltCXBZB+VLUwEsB3RXGUtXkUXpOsmmchmBnUrfE8z7AezyOlwVQ
 2IJg==
X-Gm-Message-State: AFuF++ndEIJ0D/9V0Upmy2KyHoERw3NPo0ujZl54QpPGVWFnSIgVeXrG
 GrE2fCJBb15N1qj91GbzPp+FEjCJMNG0VaV2IyjVz2wLCs6jj3zmbbWKxGkXDA2W6qrhDV9LOAt
 MA2bAC0z8eqZmDGabs37bscX6nrhcVBGxhg==
X-Gm-Gg: AYBFou2xGg3N/EzRTvzns0X7rXAJv98Y1HRSd9feEBFLetE6mAygmI+9q+1yq1hyaa5
 eX40Bu5+aPErseqF5kQbvSUnAzp01bvk5sX8lL+C3Cf34tWjwst153jOLbwpYjgYIX/n0aVmRpg
 MvpJlNizIqh4gPwJYFfE8VtKQARBb+fa3rKBuwSn2YddHfoJkBeY/0a2ex7PeepN/y/c/TtE1H2
 yt9NEJeHm7ImN6D+/CqncgcioDOMs+KSada54zodec9cAX0U6gNiONmXeWPjhfSH8KuNyyuWXH4
 24/IYOG4T1j5weiiyirpef2hF1+dNYa7STvyRXve6BXDROpvnyN8Mawoc7eS9sJcE+qS9JatGpZ
 p
X-Received: by 2002:a05:6a20:c91c:b0:3d0:8cbb:8c2d with SMTP id
 adf61e73a8af0-3da39d18686mr46754429637.4.1788854969270; Tue, 08 Sep 2026
 01:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260831114749.2758129-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260831114749.2758129-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Sep 2026 12:09:16 +0400
X-Gm-Features: AcwNN1XqvSTfs5eKkQmdR5ssVHQTaH5wXqNln5yIQGpTZFBDEwCAU604C09P_S0
Message-ID: <CAJ+F1C+RV6=nU=8d+QXd=X14WppRvPP76-jxBE0jNhx5UWpqWw@mail.gmail.com>
Subject: Re: [PATCH] migration: remove duplicate VMSTATE_STRUCT_VARRAY
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 31, 2026 at 3:48=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Fixes: 028d4ec43de6 ("migration: Remove duplicate vmstate macros")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping, trivial

> ---
>  include/migration/vmstate.h | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index e72c3fae9a69..21a31ed7053c 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -723,16 +723,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_STRUCT_VARRAY_POINTER_UINT32 VMSTATE_STRUCT_VARRAY_POINT=
ER
>  #define VMSTATE_STRUCT_VARRAY_POINTER_UINT16 VMSTATE_STRUCT_VARRAY_POINT=
ER
>
> -#define VMSTATE_STRUCT_VARRAY(_field, _state, _field_num, _version, _vms=
d, \
> -                              _type) {                                  =
\
> -    .name       =3D (stringify(_field)),                               \
> -    .num_indirect =3D vmstate_field_offset(_state, _field_num),        \
> -    .version_id =3D (_version),                                        \
> -    .vmsd       =3D &(_vmsd),                                          \
> -    .size       =3D sizeof(_type),                                     \
> -    .flags      =3D VMS_STRUCT | VMS_VARRAY,                           \
> -    .offset     =3D vmstate_offset_varray(_state, _field, _type),      \
> -}
>  #define VMSTATE_STRUCT_VARRAY_INT32 VMSTATE_STRUCT_VARRAY
>  #define VMSTATE_STRUCT_VARRAY_UINT32 VMSTATE_STRUCT_VARRAY
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

