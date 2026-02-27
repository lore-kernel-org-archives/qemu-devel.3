Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D2BFD7F91
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvvYK-0007pa-Iv; Fri, 27 Feb 2026 05:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvvYF-0007pJ-RB
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:58:34 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvvYD-0005Zu-0g
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:58:31 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4377174e1ebso1320341f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772189902; cv=none;
 d=google.com; s=arc-20240605;
 b=lz/vf6g4GILeyvqFNm70J5/qVDMV6uGyEkHvtAq1GpCDbEGFMTiDAzIj3xtc+xcQVE
 pfzO5o8R9AW0ccOv3Ei/WxpyXohJKtGWa77U08GV1Ch3Dfr1VADOTLVUDorYGbs5ZEG0
 b8Skfw4tos+1iiV8/ASuyNKKlZh7u9SSidK88q7lNlP2ion2/FDHOrkkxTv26MFqoZfM
 WW25XEt70d3IwyURZtMyswMavqzAhPk9b/qPx+7CcjTpvSKQWF068lMw2IF92ry7Q9R8
 Qh6bNgkgXptr8KEM4qPt2sO02f3YkrUDtMEIc+H2BeODv32Vz7uDqhQpF7dmjx0WPPUU
 QoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vdZnAot3DC0NpJa2X37ZE62i7x8eIS0h6kIzZLeXd4o=;
 fh=YTxI/2B0tIA4OGE8g1nLoHfXTEPH/KCzPpRqw/hY+Dc=;
 b=NQPmtJJNvBGnSGQXg7uW1p/Sy9JgB9O//fAoAh4KdwVxqOf10ER7Ou5onri3DURPZW
 qL3Gy6MOVaKzNTtPp3T7Y9ICxow3Qhc+UrR6y1XU5dhe04KeGJsWKqYC7jIsFXnjUzxB
 dn1xWdfSzEwYQMXXNWNNw3nZxplsoscZ5lNoYjsnWIZl5QX4PIGpltCCBS5cG6QAOaTC
 DzjcZRQnTklXq/YJYtHTbiwGYgFLxvA6Z9uIrXeWa3Ke9I2K7mWH8LuAuS2OJklvSzbm
 hl3XS6M/9r222sYDRIJITvDzN9geBCXLRJZAsX+FTVTb3/U1kHd50IlBC6xMczoFu8/y
 t6Ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772189902; x=1772794702; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdZnAot3DC0NpJa2X37ZE62i7x8eIS0h6kIzZLeXd4o=;
 b=zbLyUQkGVLMgvkN3dG0GgTj+8GYeLW/u5tB5fpVlhyaXItVa+/CnoP2Jrb3yK0K+k3
 7GO4wWFDiImoBUrlyz9OQ5nNfMja9WtHv2/FktCABUXni1umPue5sKUUlcN9W4eWCVF4
 9UcyLcixZnPMNq0Ln5NVoMJ/6fQLxphNHa/pXHy4c7nrNQIWBKyrsg7alSQjCTxBeDnT
 NFipBa38Ml5PVw3h2C5kkAGnPj7H8Cj7nT0krFuPwnsuB9MQW8L1hOHzAu4R/MxIef98
 yfKe5mNQhMlC4PSxJoBHACx+IDPQLO18MeYmPnNjLsO1GMSIszdINwUzGkJ5Rj+Bq2sr
 RmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772189902; x=1772794702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vdZnAot3DC0NpJa2X37ZE62i7x8eIS0h6kIzZLeXd4o=;
 b=boIqVGLmGF7852v+WrSX7dOAGHoFK1zhb5tfN1J7BcsdOgSiwJcT4rOft1Z3VZ3QvD
 012c/2QO4e7eKrjnihMbUqGiMHD93pjmkRPnypjSRopw6QBbbyPMqaSoqxm3rqtPi5a0
 hP/rGVY6iqx7PgPh4erKhIVNGEeX29xuI1Yjx8YBLpwJDzPNhav4Ugith3tBKu+nH77n
 5m0XRjCFyByxkDdjp1kF69eXiJTMdDKUnvNCy2BelokIBJgO0XvDBgZUNMJtyIQaRRGq
 yautPEx5zHptx7s4Dyer8DIRQz1tJxnFqDbGDkQH2oMvPyefvjklzxCkX0nctVLLtuFD
 cWiw==
X-Gm-Message-State: AOJu0Yy0VkjptMLrurmIxGDgiP/FOTHpHyQ1LfFIPH1FduHGlkX4WP4b
 ffAfQGA/vfyzxjf4DWa9m9Ap1xDpwIpdcsC0AQhDKJZVHL7kIbnI8GHBa9A/4jCOrr0vmSzai09
 xEr6CLGKgRf8JSqOQfnW4wXJw1QLl6hK3GxxV0thEWfWHNt8fOm8Vscfj5w==
X-Gm-Gg: ATEYQzy165mipfzLbIEGEXdXJMpGLVlDKNkyLphwMYSYAhF+nmDUQtPFyZ91/620uoK
 MF3w7LmyUexGIdcWi/a3vZ71V5hysmUkUJS505d8LuPWeSwiTSAqvd4PlaBM4gPVVmE4EqBpyjr
 euzC95PdDh/yjIsF+0g8fia7Yfun0Mjoh0KOSRgDhUeh9xVuwEd7X4AuJaOu+oFH18hOd2uG5Ib
 +Wwa/neaZnhvDxt36F8cVxaFjTbhlH7wEaAwi2mgQ5+O4YXlsek+1GH3/NEsCugKxVxI9r4Yr4b
 NVh7JSUsNZei0AlHU4wRMwUWXiCVpuSu/quWT96eqjTOKv+h4A==
X-Received: by 2002:a5d:5f47:0:b0:437:895d:2026 with SMTP id
 ffacd0b85a97d-4399de2b9b7mr4038964f8f.38.1772189902495; Fri, 27 Feb 2026
 02:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-2-philmd@linaro.org>
In-Reply-To: <20260227104314.81038-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 27 Feb 2026 12:57:56 +0200
X-Gm-Features: AaiRm52CaE3UCGPWUgr43jb9qYSdvrDHaB8VIQ6x-VoONK6F8oMXYn0KUMmx5p0
Message-ID: <CAAjaMXZZ1migvDAhFsJcSua2QqSgnNL-dHA0ym5K+=Mi4ygYvA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] meson: Restrict gdbstub to user/system builds
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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

On Fri, Feb 27, 2026 at 12:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Limited builds (tools, documentation) don't need to generate /
> build gdbstub files. Only process the gdbstub/ folder when
> user / system emulation / acceleration is built.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 3cd1d8dbc66..60415df69a1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3724,7 +3724,6 @@ subdir('qom')
>  subdir('authz')
>  subdir('crypto')
>  subdir('ui')
> -subdir('gdbstub')
>  if have_system
>    subdir('hw')
>  else
> @@ -3767,6 +3766,7 @@ if have_system or have_user
>                           output: 'decode-@BASENAME@.c.inc',
>                           arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@=
OUTPUT@'])
>    subdir('libdecnumber')
> +  subdir('gdbstub')
>    subdir('target')
>  endif
>
> --
> 2.52.0
>
>

