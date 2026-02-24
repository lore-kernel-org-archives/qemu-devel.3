Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B7FF4BB6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwej-00087E-HX; Tue, 24 Feb 2026 12:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwei-00086y-66
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:57:08 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuweg-0007q1-7O
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:57:07 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ae222d87dso5251169d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771955825; cv=none;
 d=google.com; s=arc-20240605;
 b=RasRYBhqsArGv1XJjVeciUQEjW+4qhScSm6yH7wVYwbmp08h+0rLJ5LBzymAqBqxdm
 lDlji9xkm56CFwxyMazyHuoRKWKsBh4NUG42gQSLYBTornnmQ5dHkYdwtEZ5DJL6ajEg
 GPUT2k0pWrzcvb2bLnJ5Tsxh6wnXkCXZFhIjaIL0DmkXB3kkr/1YN2iBwucQrBYBGaAQ
 HJ6sTSBaUpCHr6mnaRSk8RWQ/ndeCjm6CT6H4z0UZ5zvLFgS81dEiRa1m5CeVetDOxQp
 RXD6/8e6GWceYENiLplMDHGezgNjZUljSXgHBC0yxal6vNkewxUYjKudQhgUI2Ejz5RH
 09mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AeUfhO9UW6TQFC0dOdBcr5wjEXoxdisHitpRcJO+Ehk=;
 fh=R84pXDYvJznuJb5dunrikqaEeI9MgwuEGgEYHxBIZ1A=;
 b=lHFKfAX+cJSD4M7RdWxNaHp+Fp+65CnSL57EobG22SCJfwHvAN360RDdCpo5zVy5fK
 zluwz95V0QfPjFMWu7sStwco9WDdlgXgfPJxzi5SA9rdych8zz9mMaL/GjuQCdR0/cXC
 MRHYh0Tw0aatzehYFW/dZno9TMddPQQ3aWPuQUk3wzOUEWhlpJalJOldWqWI93q3Pb7F
 aAAqRppvutFZc+L46aieWAje/itvLo01lvyFz1nk2zvS5Fv0w69USaLZJKfjR9V/TGxC
 BHetiLVeHuI/ZQFLK/rTXWapUsvU6gl9MY69pLJXx79qSPRTXbE7CAiGm6USwJ201MaZ
 dc7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771955825; x=1772560625; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeUfhO9UW6TQFC0dOdBcr5wjEXoxdisHitpRcJO+Ehk=;
 b=NFVopUEQEhQz05h1baGXuYvADc+1iGPrvDwNrXkTP0d4e4Fy6hntxaxh6y7q1eWF1h
 myvWrxAxr7fdL0o28u48q9TfgHkklgS7DeUFz8UQCxy+TlmXfNPLtSNl3TEcywdJzIaG
 WKcjIVXDYXn/piicD2zrUNLR6KsIP8pqk6bbm3+Em4y+RbzEotLzmdx/BGUkzXWUxxAm
 SzdhwBnBJXaSJXqfGV08BAa/S2gY9NwWLGAD2Q5ZLeJJIr+L+dYSKickIQ90vGTj0i36
 evpVMRBh+wbZlUMjilR9kfvF5axDFwNf31yzclEtFuNHfU3oJ+dboJUc1RPtz86VPnRP
 /BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771955825; x=1772560625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeUfhO9UW6TQFC0dOdBcr5wjEXoxdisHitpRcJO+Ehk=;
 b=fc0pWRL/f0nFc07aFzAkOdtulMxRGv5GggjQV+dxsP64kfcff+bAE8ESPUPHwXibZL
 7rRlRU7GHjESWZWVYaD2DadG4aTpYz7HFOVkz4ufCwDmcukueE65GP9kH7Chm0Jt2nFF
 kK+3zuiF36bjj0zgWfmeDsCUqz59vIkuXQ5JCkXDmeEZvSku4sUOldWeuZrORAfjf57E
 j8RaWUMc2FgY2Mm55mqtH6ijcka7wbmTdn4m6i/oone6Vs/GU/rk+5oDIaOLcOI+m289
 LawKm7zM0dtoptM8pnAMu6K3qJVzu/zoPhKL6yzKYHO1puDJqPpBWLzoXcbYiIxt6ZU7
 6Kiw==
X-Gm-Message-State: AOJu0YzzUcVJvo5OSEFjDSRI9CIeqWuuDEYKfu6z81wn2wELpoW05OM+
 oOKHnutgomM1Tdptsrz8lRN2tM+ztVnm4HGguIDIHdZ8A2fmWoxzv1/93Rk6eIntD/7lvNVxUX3
 sfbgQJ/4Ln8gEFv5wM7MEoAfz1wy22m4eUIB7CHo3nw==
X-Gm-Gg: ATEYQzz2eMcGvSr6veOvmcxEL2N7ycrhIRUo+1zw+N+EsQAGeiivfx2Jzsj7j+SYZhe
 nEtCCHpLHO8iYCFIQcdQR6Ane2pLiXid8Vo6DECet8n38/p0JMApFUHozEfxC54XxwgpGacIn8q
 YokzCyezhSGGx1wdsSizG7QaXyVifZOh3EnwqUjbWyC0yFSO+pQJWjn50spiacx816vBdS+FvYe
 Yijf8fDgxcGF6iunLYhKYNq5FzKBsFosjyEOtUWEemlDBK3Cm+DqHCCfz/cxG+CSoQ7Bf6efuDh
 EcQPD/ejk+WR/Dn2RsAPfcRzcDlzgRQD8PaFmXwZcCR/27tAGV2MTjxSywkOl+vbv7c=
X-Received: by 2002:a05:690e:1447:b0:64a:f0cd:d47 with SMTP id
 956f58d0204a3-64c78e5987cmr11083078d50.84.1771955824692; Tue, 24 Feb 2026
 09:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-8-alex.bennee@linaro.org>
In-Reply-To: <20260219171810.602667-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:56:53 +0000
X-Gm-Features: AaiRm51620G_UI-4oTZzZTam6sQ4dpDFeeZbSdJRqXMq_KZwqAV4ImnEWAYP9zM
Message-ID: <CAFEAcA_d87=weQS4+s5X6fPGNOGBNyWzq7V4EgFE=HDsyK95ug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/14] hw/mips: defer finalising gcr_base until
 reset time
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 19 Feb 2026 at 17:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Currently the cpu_reset() in mips_cpu_realizefn() hides an implicit
> sequencing requirement when setting gcr_base. Without it we barf
> because we end up setting the region between 0x0-0x000000001fbfffff
> which trips over a qtest that accesses the GCR during "memsave 0 4096
> /dev/null".
>
> By moving to the reset phase we have to drop the property lest we are
> admonished for "Attempting to set...after it was realized" but there
> doesn't seem to be a need to expose the property anyway.
>
> NB: it would be safer if I could guarantee the place in the reset tree
> but I haven't quite grokked how to do that yet. Currently I see this
> sequence when testing:
>
>   env MALLOC_PERTURB_=3D43 G_TEST_DBUS_DAEMON=3D/home/alex/lsrc/qemu.git/=
tests/dbus-vmstate-daemon.sh UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_err=
or=3D1:print_summary=3D1:print_stacktrace=3D1 QTEST_QEMU_IMG=3D./qemu-img Q=
TEST_QEMU_BINARY=3D./qemu-system-mips64el SPEED=3Dthorough MESON_TEST_ITERA=
TION=3D1 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1:print_stacktrace=3D1 PYTHON=3D/home/alex/lsrc/qemu.git/builds/all/pyve=
nv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-sto=
rage-daemon ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summa=
ry=3D1 G_TEST_SLOW=3D1 RUST_BACKTRACE=3D1 /home/alex/lsrc/qemu.git/builds/a=
ll/tests/qtest/test-hmp --tap -p /mips64el/hmp/boston
>   TAP version 14
>   # random seed: R02S0d3b1a4f1aef5198107851bdee539e7d
>   # Start of mips64el tests
>   # Start of hmp tests
>   # starting QEMU: exec ./qemu-system-mips64el -qtest unix:/tmp/qtest-530=
181.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-530181.qmp,=
id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -r=
un-with exit-with-parent=3Don -S -M boston -accel qtest
>   main_cpu_reset: dbg
>   mips_gcr_reset: dbg
>   mps_reset_exit: dbg

This works because we call reset hooks in the order
they're registered, and clearly the qemu_register_reset()
in mips_cps_realize() gets in first.

To actually get the three-phase ordering so that the
'exit' phase hook you add in this patch definitely
runs after the 'hold' phase of the CPU, you would need
to stop using cpu_reset() and instead use
use qemu_register_resettable(OBJ(cpu));.

>   ok 1 /mips64el/hmp/boston
>   # End of hmp tests
>   # End of mips64el tests
>   1..1
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <20260108143423.1378674-9-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - use proper 3-phase reset
> ---
>  include/hw/mips/cps.h | 14 +++++++++++++-
>  hw/mips/cps.c         | 26 +++++++++++++++++---------
>  hw/misc/mips_cmgcr.c  |  1 -
>  3 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
> index 878b4d819f4..1084a10de0f 100644
> --- a/include/hw/mips/cps.h
> +++ b/include/hw/mips/cps.h
> @@ -30,7 +30,7 @@
>  #include "qom/object.h"
>
>  #define TYPE_MIPS_CPS "mips-cps"
> -OBJECT_DECLARE_SIMPLE_TYPE(MIPSCPSState, MIPS_CPS)
> +OBJECT_DECLARE_TYPE(MIPSCPSState, MIPSCPSClass, MIPS_CPS)
>
>  struct MIPSCPSState {
>      SysBusDevice parent_obj;
> @@ -48,6 +48,18 @@ struct MIPSCPSState {
>      Clock *clock;
>  };
>
> +/*
> + * MIPSCPSClass:
> + * @parent_phases: The parent class' reset phase handlers.
> + *
> + * A Coherent Processing System model.
> + */
> +struct MIPSCPSClass {
> +    SysBusDeviceClass parent_class;
> +
> +    ResettablePhases parent_phases;
> +};
> +
>  qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
>
>  #endif
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 620ee972f8f..23918147276 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -55,6 +55,17 @@ static void main_cpu_reset(void *opaque)
>      cpu_reset(cs);
>  }
>
> +static void mps_reset_exit(Object *obj, ResetType type)
> +{
> +    MIPSCPSState *s =3D MIPS_CPS(obj);
> +    hwaddr gcr_base;
> +
> +    /* Global Configuration Registers - only valid once the CPU has been=
 reset */
> +    gcr_base =3D MIPS_CPU(first_cpu)->env.CP0_CMGCRBase << 4;
> +    memory_region_add_subregion(&s->container, gcr_base,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gc=
r), 0));

It still seems odd to me that we are messing with the GCR device
in this CPS reset method. The TYPE_MIPS_GCR device (in hw/misc/mips_cmgcr.c=
)
is the one that owns these memory regions and it has code that
adjusts their addresses at runtime based on guest register writes.
It would seem more logical to have the CPs code just set things up
(e.g. map them at address 0) in realize, and then have the GCR
device's reset (exit phase) set the address/enabled of the MRs
according to their required state at reset.

thanks
-- PMM

