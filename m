Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D343AC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 09:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfZU-0002Xz-Kj; Fri, 05 Jul 2024 05:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfZT-0002Xn-8V
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:49:39 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfZR-0002hS-GZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:49:39 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52e97e5a84bso2080648e87.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720172975; x=1720777775; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SA5fqbbIKfYnNVXC6O8TAip/fhhb8m+yZ0iiLyhENgE=;
 b=utsWzrAuwUvMLyFXJCRGRazRUjLcXfrXlQa3x/Eb9afGgCSAYskNMwOVhHC8+/8fV+
 HmAQNdJgm5pTyNdZRFzLaCFA6kqN76lGd1ykwl1N0SbZ+9NuB98MNWBtiB/Q21DdLF7e
 m8Gc1Mn2ni097LG0cWFPzJ8uPZLBIJfFYqky1nSfRHh161aJ7jOQCYyh7lOPlMMinnsG
 DVFGVu3SoVlA8NfM4DW6pr7rAS2JEfjvl4Mnh5dmyX5gqjRQSLLm6GqI+iF2DvMwBOVB
 frMwss7trDMsCDokt7x2WG19HMdf63VpqeVkOL6Mg84IHb7ZvhvOPpg3/tddv1NQaW8Z
 dbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720172975; x=1720777775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SA5fqbbIKfYnNVXC6O8TAip/fhhb8m+yZ0iiLyhENgE=;
 b=lFdf3x1KFG1UaGfx3FhaIxdwt6Kbw9KVn+D1hNbaiXq/vTPqlJqftlLaQAGpOZMxDy
 xYHGv8AUKj86MUAhCJ8n9K1nHh6Dwa0r53/QzKyQIENrrz7tBWQvWS0GZ+jMkF4C9tZD
 MUOQCib/9+M+QBZK2zmDwawHVpUe+n3uqZxnuPLTFhc8QDkKum6LQI0mB8aAkvye16M3
 ytSGSrLWoL7lVDq2evq6Vjr/bU+xHr9A/ZdlDGwDdfwtXVHd0TQHdKBjbSQS+tOmMgpq
 PD+ikdUjbZqEK1eAfR3Fk5SzBbrRZty6f6T1DQ/vRkkUBlhsVx+ilsmx92wCjqb2ezrr
 WGdA==
X-Gm-Message-State: AOJu0YzB89wtXWVRa/Bu/OqF4ieFZlTF8Ho13t52CZWC1aIR1GsL1nVs
 csNe+X7cKT2mTrnwzStIRiy0hD+fsIyg71/hjV5vL0yz/CXjRvvHPh9ROXrLMOM5GwfZ3uwIxO8
 YhsYM0x8Wcejps1gi9KK56//Vz4FF8k9kC0V9Pg==
X-Google-Smtp-Source: AGHT+IEVgkphEPZLVcvXk/FhDhmGKva9+16mUH7TFZa7IkicGO9tBYsN+zesRnWhkXT86MzgG9woZhiXlXUXe1a6YxU=
X-Received: by 2002:a05:6512:15e:b0:52c:76ac:329b with SMTP id
 2adb3069b0e04-52ea0632400mr3357568e87.35.1720172975271; Fri, 05 Jul 2024
 02:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-5-alex.bennee@linaro.org>
In-Reply-To: <20240705084047.857176-5-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Jul 2024 12:49:19 +0300
Message-ID: <CAAjaMXZVbuKO=f8DUYc-ogVEtBer+U5Ms3vUPYAfFuJzDNiXiQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/40] hw/core: ensure kernel_end never gets used
 undefined
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x136.google.com
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

On Fri, 5 Jul 2024 at 11:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Really the problem here is the return values of fit_load_[kernel|fdt]() a=
re a
> little all over the place. However we don't want to somehow get
> through not having set kernel_end and having it just be random unused
> data.
>
> The compiler complained on an --enable-gcov build:
>
>   In file included from ../../hw/core/loader-fit.c:20:
>   /home/alex/lsrc/qemu.git/include/qemu/osdep.h: In function =E2=80=98loa=
d_fit=E2=80=99:
>   /home/alex/lsrc/qemu.git/include/qemu/osdep.h:486:45: error: =E2=80=98k=
ernel_end=E2=80=99 may be used uninitialized [-Werror=3Dmaybe-uninitialized=
]
>     486 | #define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
>         |                                             ^
>   ../../hw/core/loader-fit.c:270:12: note: =E2=80=98kernel_end=E2=80=99 w=
as declared here
>     270 |     hwaddr kernel_end;
>         |            ^~~~~~~~~~
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/core/loader-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 9f20007dbb..7ccc9d5fbc 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -267,7 +267,7 @@ int load_fit(const struct fit_loader *ldr, const char=
 *filename, void *opaque)
>      const char *def_cfg_name;
>      char path[FIT_LOADER_MAX_PATH];
>      int itb_size, configs, cfg_off, off;
> -    hwaddr kernel_end;
> +    hwaddr kernel_end =3D 0;
>      int ret;
>
>      itb =3D load_device_tree(filename, &itb_size);
> --
> 2.39.2
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

