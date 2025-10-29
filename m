Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8C8CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6xP-0001tB-Qh; Wed, 29 Oct 2025 10:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vE6xL-0001rf-JP
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:15:20 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vE6x6-0007Aj-HO
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:15:13 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-78487b0960bso79387467b3.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761747294; x=1762352094; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwGA6TiP3+h65Ac9ZA/bVLC2L4ED5pNAUeXlEISuypQ=;
 b=WKMVs+FG1I3OuR561yMLcUePAeQ1YtOcb6NpZNUP+cudfZcoef8ibIP6g8yhbJLydG
 8DYk+pdz8SZ8OjeLedMXNRmioCF2r+H4ZwYdvCxd2mmu97qKA6DJQAtj7o1AWnqWs4GT
 5A0uotEV6jUOMuR+L5qEWzR++cUXd81XgR1YuHfW7mhDr0Q8152m4PHYNFtqdgDEm79w
 6M+UOTgUW67VQ55aZOArT4skVTLvr7kd6p3/iY/m59SL+VABjSTqyjIEQkF3mya64zsE
 YL0Ax5LsLImJ0z79zXcBVmu+GM63NRBB0rdbZVKyHxI+uT6D+4mLAGAugxVeofIjU1AV
 4UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761747294; x=1762352094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwGA6TiP3+h65Ac9ZA/bVLC2L4ED5pNAUeXlEISuypQ=;
 b=FVekXWBQNjQay93lwBF49p7aXY1f+k8OUMPIsfU3Ua9oquUdNMObD17DvFznlIuM5O
 S9Tt6xmgawlwSbBax47HsrIkRHjgGXwWqs/B8pnOEiUvk1UH/q8AUFXJHb3FuW9d6CTQ
 tdMEdYYCKkebAbTxJUPvkWd8bG68yMuluEHHbs0zSBs6ecQRbCKyrqonP+nHzqA+IYHM
 jc6kiHPsaMNbCeUbGYAboN4q3m/ZVduPOChnjAWWsKLaqzJu1MYFHMGa9HbQ8hYYBDNL
 x/Haw70rKLKrgO+tUNXu09qrJBnLH3VDh9znIXbHEblkpveKXwa/0Ms3OstbR1H8dCiW
 pRww==
X-Gm-Message-State: AOJu0Yzpx+rkYAl83TqJ5OvScZyrbIHQhTy7L3vX3qlJwvZ0QnGaDsj0
 pFPswgeiW9llpVhQZEPA+2rl6ssntxolH3o2iLNZdS9tW77uNVrZhw6FJVwp8ToIOhswADsRyZp
 g4Y+m9teYdx6UkdnrK/pI433mihxoI6LurqtiDqaCiA==
X-Gm-Gg: ASbGncuQlbvllPRUqA4OnXVhwFGdVwYSFWOLBoe6LwO1bsESlSEG+xjqpo58J6ju1hg
 vYJmQ9h8uInsQXvZtc/3P+igQVc/CVIVWpe1M4UIpFoWD/wOEKHp0iUan4MHHvt+uh7XYr/cF24
 7aE6aoF5FS4PWWjFmXh4BxzVhKABANtNJYh6a+IujU0eJEMLxCLuRAvt5YrCA8g628cUOYXpgQ/
 urFOeeK4PFYCVoviJAzi3DXCg0fgQJVuwjX7/lscMIJaWwyOkuNzAwAvAhmaXtCJQ4avxCM
X-Google-Smtp-Source: AGHT+IEdruYSy7UfB8uXYXyKevLHd49l26K92FKJ00kcH7+bZRQ1VzjjZxSSZE6EBk/3Azkgj92qhQgroEZT5blRnLE=
X-Received: by 2002:a05:690c:c82:b0:784:7f42:617b with SMTP id
 00721157ae682-786290392fbmr25199267b3.67.1761747294003; Wed, 29 Oct 2025
 07:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251029075257.63635-1-philmd@linaro.org>
In-Reply-To: <20251029075257.63635-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Oct 2025 14:14:42 +0000
X-Gm-Features: AWmQ_bkNDTqtpLKqRTmK5JBEh5Lrep8qoVdYw0QrKoaxmKpekVqc9V-8rZu3txM
Message-ID: <CAFEAcA961WKB4fxwAS0WHXXKwYEO7TnmovD4z-BPGehr6sxBQw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/bcm283x: Initialize CPU objects in SoC common
 DeviceRealize()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 29 Oct 2025 at 07:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QOM .instance_init() handler can not fail. QDev DeviceRealize
> can.
>
> The device-introspect QTest enumerates all QDev types and
> instantiate each one, without realizing it, then introspects
> the instance properties.
>
> When switching to a single QEMU binary, all QDev types are
> available in the binary, but only a filtered subset might be
> available, depending on which previous target the binary is
> trying to mimic.
>
> In particular with the Raspi machines, the TYPE_RASPI4B_MACHINE
> and ARM_CPU_TYPE_NAME("cortex-a72") will be built in the
> qemu-system-arm binary, while not available (because filtered
> as being 64-bit, for the qemu-system-aarch64 binary).
>
> However the TYPE_BCM2838 SoC is not filtered out, and will
> abort when being initialized, because the "cortex-a72" CPU type
> is filtered out, leading to device-introspect failure:
>
>   1/1 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test        ERRO=
R            2.46s   killed by signal 6 SIGABRT
>   stderr:
>   unknown type 'cortex-a72-arm-cpu'
>   Broken pipe
>   ../../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU p=
rocess but encountered exit status 1 (expected 0)
>   (test program exited with status code -6)
>   TAP parsing error: Too few tests run (expected 167, got 5)
>
> In order to avoid that, move the CPU *initialization* in the
> SoC DeviceRealize handler, so the SoC initialization won't
> fail, while realization still will.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/bcm2836.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index cd61ba15054..6e4066f137d 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,12 +25,7 @@ static void bcm283x_base_init(Object *obj)
>  {
>      BCM283XBaseState *s =3D BCM283X_BASE(obj);
>      BCM283XBaseClass *bc =3D BCM283X_BASE_GET_CLASS(obj);
> -    int n;
>
> -    for (n =3D 0; n < bc->core_count; n++) {
> -        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
> -                                bc->cpu_type);
> -    }
>      if (bc->core_count > 1) {
>          qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_pro=
perty);
>          qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count=
);
> @@ -65,6 +60,11 @@ bool bcm283x_common_realize(DeviceState *dev, BCMSocPe=
ripheralBaseState *ps,
>      BCM283XBaseClass *bc =3D BCM283X_BASE_GET_CLASS(dev);
>      Object *obj;
>
> +    for (int n =3D 0; n < bc->core_count; n++) {
> +        object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
> +                                bc->cpu_type);
> +    }
> +

This seems a bit odd to me. Yes, object instance_init isn't
allowed to fail. But it's OK for one object to init another
in its own init method, exactly because of this. And even
if we do move this, the failure won't cause the realize
method to fail cleanly, because object_initialize_child()
doesn't return a failure message.

The problem as described in the commit message seems to be
fairly general: we have effectively blacklisted some types
as "not really creatable", but we haven't got a mechanism for
propagating that to other types that unconditionally use those.
Working around this problem by moving child init from
init to realize in parent classes is going to result in
a lot of weird parent classes that do work in realize that
ought to be in init.

I think we should either:
(1) find a way to propagate the "this type doesn't really
exist for this binary" downwards
(2) allow the "shouldn't really exist types" to be created
programmatically, but just don't advertise them to the user.

thanks
-- PMM

