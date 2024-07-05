Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062DEC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 09:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPff7-0006CP-Hu; Fri, 05 Jul 2024 05:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfex-0006Am-Ng
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:55:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfej-0005Tv-Al
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:55:18 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77c9c5d68bso62237366b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720173303; x=1720778103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZaIyAsrOfFJ9WnEjgMHD7DfxJPFNfGAzAL8zCqdxjo=;
 b=NYE5Snap122Msul4k0WIrKbYRi0XKu4xduXCPOXFhurTcTSs0uT3qBgxCtS1RkJVNO
 kG+4c4Cd1vVrBwxFnlM5upca9m9XBOJfk/UZjVkpKUMCQx4DtpMmDqtJPfk1W8tMU2Bw
 tQVBxSAQu3yWJq3ltPOnWPbd2/7I02sUumeLDRSgz3d9OticCN2suL7cwQ4QAQld9qJn
 UUIegX/W6/ude2EGCurHvlyfxzY/jNJfpxIvzcJul0PA8Mx0DPU75+mLCeq7ZWISGs1G
 KeadXI1GkZzd1t3Kj3coUt/ChIXPsrUPvbOpzzaE8Y6T12zMByd8By5NZ4EMwxD/+ofO
 EcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720173303; x=1720778103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZaIyAsrOfFJ9WnEjgMHD7DfxJPFNfGAzAL8zCqdxjo=;
 b=iDz46EzuequkRjUr3eJZ7kPIxADnK64vXSLEdtJ0NLJh/aaMhELcUwpD8YuINJMH9X
 QtQnLiZ0l8YtUYfEHdCngXlVtGcr90SQH8DiBUx10ad3pMA2zKgNuda56E4Cfe33oKMZ
 r+7FFQ3Nj9E9Dv3k2tN/XJYqY3sCNi9i8V+g+U5+MzJr0aHC499EJzFJbiGL849NGViS
 AsfUUfrkFTmt/S98GcqDXjPvrKmBYVgECxWiiRSH562yM8hoF2NUtmVyd7mP3NQGQrMG
 4w2//Ax1KUXS41PKmvYEJRhVeRD0NvQYI9tsCPN/ofzLbnRzNG4QGyUAUU6bcHJDkjcM
 MG6Q==
X-Gm-Message-State: AOJu0YxveECAiGsBm4pnVW5uVZbv7zCdTZc77h9dFHZs1Z4J4Ha6Sz3i
 5cGVIOdvyUapzOlpMam/VNEZAHMICiq7t3eYuYwN1spgzl6SrJcjAgvk+ziSVLKOaAy8/31R+0a
 eQ0bRt69FerNoruGSxf5bQWpSuQdfIC83Cwv9JA==
X-Google-Smtp-Source: AGHT+IGmRyHuaw79zmkNqDKK8iyz0EVg8Qxf2l95NmNEBXotv43Qa4yKsoHeTZLADNUWU/2ZeeiDYaEyk7bBzVB0+cI=
X-Received: by 2002:a17:906:bc4b:b0:a6f:50ae:e06 with SMTP id
 a640c23a62f3a-a77ba70a749mr267466366b.53.1720173302784; Fri, 05 Jul 2024
 02:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-24-alex.bennee@linaro.org>
In-Reply-To: <20240705084047.857176-24-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Jul 2024 12:54:47 +0300
Message-ID: <CAAjaMXaZcVRb5eAa0BcZCU+uzUbHOoYC_nsk5RGPsOeNG0teOQ@mail.gmail.com>
Subject: Re: [PATCH v2 23/40] plugins/lockstep: preserve sock_path
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
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 5 Jul 2024 at 11:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> We can't assign sock_path directly from the autofree'd GStrv, take a
> copy.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  contrib/plugins/lockstep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> index 237543b43a..111ec3fa27 100644
> --- a/contrib/plugins/lockstep.c
> +++ b/contrib/plugins/lockstep.c
> @@ -347,7 +347,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
n_id_t id,
>                  return -1;
>              }
>          } else if (g_strcmp0(tokens[0], "sockpath") =3D=3D 0) {
> -            sock_path =3D tokens[1];
> +            sock_path =3D strdup(tokens[1]);

s/strdup/g_strdup
?

Otherwise,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>          } else {
>              fprintf(stderr, "option parsing failed: %s\n", p);
>              return -1;
> --
> 2.39.2
>
>

