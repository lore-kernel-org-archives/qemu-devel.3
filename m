Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB555F4BB65
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwM2-0007CJ-FH; Tue, 24 Feb 2026 12:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwLy-00075j-Cp
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:37:48 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwLw-0003qb-ER
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:37:46 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64c9707fc11so1404909d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954663; cv=none;
 d=google.com; s=arc-20240605;
 b=Pm+UD2g2Cuv64FlS+8j6TjjHUrnaw7wfpYqeTQM/omzmZmuwjmOOUHk/br5vcHzP/y
 p0llm94/zzVQ/efALKFSkb5lhrWmqS2UV9n0oSqlj1YOemci9xqSJPM7FE8jKjNwVhIe
 s2L3/apdNh8sAfYx+flecGqP90bn4dcoTNRIjr48h5/L6LtVhBJBR6qn41D19rTytYPm
 pHmhgiJ69+vKTdb+5vvIQTk1FjYwtTY/6rxo8KodHeyF+D9jY8hx6uAWOLGO+6cQ9jCt
 YGEJSosfc7NpALojQbPLN6UpiF3l90deg47WX/8LVl6J3nRmfE4EsCioxYVWcJOppU24
 pi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tdh36pSD+tLfnMZN3vf5DS5AcaUa9J8WbbRp77AylTg=;
 fh=R84pXDYvJznuJb5dunrikqaEeI9MgwuEGgEYHxBIZ1A=;
 b=V/TKSkscs+G5BkgGujM6w/wuBBKKL37KhaYyc0Zdk+Lq9Vq4Y2oBtyrnjdJx8MHPsB
 4Mp9ZDte6/7gygdpoV1CXiWlhfNgWUvnK7TLsiuVSZ1hSVGxttxthaSxNiYQ4csM1ed8
 EWsDohwvIiUEVY9fHOQiLMwErkfB/Bs+UF3WfwAIfBzIKo2dFWVPnHPir3OKSJGOP739
 mnw5tgam4555f3YS4AlsOKmlp1RB8OZxUL+bwTLajLt2sDm9HeIh0XGonw8jLAQQ/x1X
 2cAS1cJtNl0sco5mt2VxbCOJnB/ZqItYkR68zD9pfC8eMguNn+9yosMvgyOLHkLWP+7Z
 cCTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771954663; x=1772559463; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tdh36pSD+tLfnMZN3vf5DS5AcaUa9J8WbbRp77AylTg=;
 b=UV9SIGjdAjBAkZ4qmnOk8rbpvq2rjkkkCJVUBKPsCDMa0A7v4l7aKMN7ZGZ4b3dhdt
 6lCmYFuULI0xLHBq2gJQ5aJT88N5csVXUSBtR3/kpRis9zS3aqqMuUmfAJHun0/TJ7nt
 e4MYtN3+rUh/T07pD/bhDqNO/FPoSbVgTRcSxN4LJH19ab5aRmOgqQzFUO1pD3fXLd1w
 Nb9FZYIIw+wNGhl3qphUHQ5FDA1MqZBrAd1xLzI3PUJUsmotbGFMltqZEB4pU9qGWe2U
 JypgkhSQmlrGOOGBiRu4bumw+LzS8MWIts13AdtT1Y889JfiCl5nAucW7pVMDnCrIXU+
 2COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771954663; x=1772559463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tdh36pSD+tLfnMZN3vf5DS5AcaUa9J8WbbRp77AylTg=;
 b=OqZUgk9hGOlxb3llWLUUxP/ni4loN7ydSYn8cPQTsqil83dKik1oZkCvkEviMYD4/z
 uKzMDxq/akPAzM2U+mb44zWd+a7iPkCKA1wOhWHSrpQ7/bKco7e7vpr/spJkZONRLdTy
 HLgSuNqP7eU2FHi1e9KZJcX6r/8FjlIjSKA0Q7cEkQ4ObW6x7rGLTsP9PiLqisi5vE4A
 D2Mxq1q9RPpKiOfWxCKCv9+I5X0sB2BOK2EHOSlpGtu3XP0q01SkxswAQTtuOIQ7h8+M
 COvxGsAqFOsypxdf7/JfKHAnAnXhFDSIpcEZm9fGp6CDgU8imFNrrl4yvLZ7sD8NUFv/
 e1OA==
X-Gm-Message-State: AOJu0YwVRSvM2J7pEvQvhAUhKFa/dkhjQLDFVj/GuERwPBHOk9IL3rtF
 eKvZRWJX/oGoXN9tPy7hCNHbUkrDo/rBqqrjvdfou+IdKzyq2lMNB1jimBnMFzD9hoN1G45WzJ5
 BSfeh7nkrgPrqkB1+Cm6bVBWn1ZcQXB/O4UCclJTIaA==
X-Gm-Gg: ATEYQzzlK6fZ5d7QKSvMHE/0lsbARSL2lrOuQaJwF/SaWZIibw1MB5YJf/TXI490Noy
 oktHL4flxS0pJs6/4QDlDaa181BFWtL3PYqu7lM2bGDAxGl+BtXNbJhttIVmT3If7qX04nitphd
 Tuz/SHKvnoeDxgk8DZ8V7W+Dr87A5UZiFrxapYMeOoZMpxUQ69QdpDbcpA3sMjSjE6PzscGnWRP
 Yo4/WZsFe/GH0zWJPjR5Nq0HmV7g042169aKAb366tp2RMHsMkZqDigvGhhQtMCivRuV+TnXf3Z
 Ebo+/wVsT51jiyaCu0p878MYIfO8WJGVvuVvga6dSRKCKpWV6ngTL+nLGJFq2L4awx2YLvakGxF
 wUA==
X-Received: by 2002:a05:690e:d4c:b0:64a:ced1:4fa6 with SMTP id
 956f58d0204a3-64c788d282cmr9683307d50.12.1771954663283; Tue, 24 Feb 2026
 09:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-4-alex.bennee@linaro.org>
In-Reply-To: <20260219171810.602667-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:37:31 +0000
X-Gm-Features: AaiRm51OBLSPJe1_nI5Tcc3wkfFFTGvqTYeKCQ4XRDuIx756xp6sVyNLXUQUg_s
Message-ID: <CAFEAcA_gi319MwW8pV0doMxpvKx6H4pCeMA=0vmFm8ynyWP5Uw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/14] hw/m68k: transition virt machine to
 multi-phase reset
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 19 Feb 2026 at 17:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We don't need to re-create the architectural reset behaviour now it is
> handled in the core m68k CPU reset code. We do however need to add
> support for direct kernel booting so we stash that value in
> env->direct_kernel_boot_pc and enhance m68k_cpu_reset_exit() to use it
> if set.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - re-write to use proper 3-phase logic, so dropped all tags
>   - favour cpu_reset over resettable_reset(cs)

The commit message says it's doing three-phase reset, but
the actual code is not:

> +static void virt_machine_reset(MachineState *ms, ResetType type)
> +{
> +    CPUState *cs =3D first_cpu;
> +
> +    qemu_devices_reset(type);
> +    cpu_reset(cs);

This first resets the whole system (going through its
three phases) and then the CPU (which does its phases
separately). Three-phase support would imply having the
CPU do its enter phase at the same time as the other devices,
its hold phase with the others, and so on.

If you wanted that you could do it by using
qemu_register_resettable(OBJECT(cpu)) instead of having
a MachineClass::reset method, given that the only two
things you're doing in it are the default thing and a
cpu_reset() call.

> @@ -315,6 +300,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
const void *data)
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      mc->desc =3D "QEMU M68K Virtual Machine";
>      mc->init =3D virt_init;
> +    mc->reset =3D virt_machine_reset;
>      mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m68040");
>      mc->max_cpus =3D 1;
>      mc->no_floppy =3D 1;

I did have a plan to look at making MachineClass a subset of
Device so that it could be three-phase-reset aware rather than
having its own special-snowflake reset method.

thanks
-- PMM

