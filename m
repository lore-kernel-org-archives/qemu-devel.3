Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9729CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOWp-00040H-Ee; Sun, 04 Oct 2026 11:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOWm-0003zf-6G
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:53:28 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOWk-0007v1-AO
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:53:27 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8ac9d666d4eso8110247b3.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791129205; cv=none;
 d=google.com; s=arc-20260327;
 b=aXQZaLFu1BV4m8L0e5uaSo3uNvdI0QUsQk53FDtKgYpGGpoXNrM2WDZWFkM6q523GE
 GDHfD+//Dz3l3OEiphAPTzEyvPGJfXq5fUMpnqv+PlmzpSqcqzzcV4DHHE7h+ISM2Gi9
 /618q1xo5jmXSwI3eBmDs6InoLA34fdafF7iyfohnWc/5zGEMpi8GOkdszIM6ez1vzjL
 tVoFZyZQ2B/AIm+AfdQy2vF0bYKDKKvqo3vPqVUNxDe8TXvLcE7kILh1dc1tONqGnCGq
 tPwe76FM9Wz1uTir1UbyWf9WYvTUAFi/3B+0D38H640DjJGVChKBTGNtrX7XYYxgtIZ2
 LALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IPhuqLGHrYsnQ896hnkS6QDBb5AHYSO16+nV2JZ3S6A=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=Fut9HEBx4BQano1jqib5tsSTptXCFg9kWQaSCv/uEYjhY9dN5nF6DYOL2zUR6ebZBJ
 imSfjLHMQpwCR9czzPekWvxQ2PDsOsm+88scwcZNcc4OOe5CoOad8SjirGFh6C/IzxKE
 Ze1twbi3Awp1bSghInJoLVNLb0VHpwSIL5Vfj60I9NH7zlyv0DP5kdOnKqx2N3tHJHJt
 szeisuU1/CNs+WfYzzI7p5R/6NBRDn5ubtgp18Fyts7Z5XRG23HgSMe4C3gSgMgRCRBp
 uST0vbyDOH6+EYU9b+HnannOo3ALnre/r35uX3xNkqdkYaS7vOR2JXIAX81RtEZrAm5W
 cw1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791129205; x=1791734005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IPhuqLGHrYsnQ896hnkS6QDBb5AHYSO16+nV2JZ3S6A=;
 b=J/27gv9cUs3b4mPhUHcKBNrshu6LvfDYUmDyQPcMIh0lhGaCymwpilCiEFRtn4heBj
 fH7lvwGyf/xSdcPE6T0ybDj3SgDxl6dV7l1W44XZg2c3RxylhuEq/47IubLZNET/+Rt6
 mQ35uaVZCCpZ4io+L9vCBVvKxgQwELzJmP6jUYbc+I1Sz6COuhytHGNDxSx7Yo6vG7vN
 NZueoye4wDalOWbfQAf+sZy5EtctsQ8kvBDVOZiL9n7eCFDlElgp+gWd4TsV3U4dsauh
 Bpdw0OjmhvtLVlFW/zRnH0Y+kZaP10V0hyria0pgOQW6o78zVQ74Ph6NA0Yq7hwbom/6
 kxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791129205; x=1791734005;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IPhuqLGHrYsnQ896hnkS6QDBb5AHYSO16+nV2JZ3S6A=;
 b=SD4INkXEGCH/+Ere5hNdF4RlzvPcRIZ1zvuKjXW31qOJtZLgq3xgxJ7KzC5Gth7Yc8
 5Y1KELp2Uk/nKNwvDOmUOaIzhey12UlI7Qr9zlZeh4E66SEd0i2VCptq7nnMmacLdr0N
 ncD4IXR/40a3BBpD60lXfl8X/kcm7nw3m0pnVMfKLP2sHA5+x4uSEODV9WYkrsfV3uiy
 BQg4AY03VbVmNsWpuiqjiVgk6+wUnOdIa8FRGfRZrnmTKDkOtmwky99jnWD83bXmWk1v
 YoiYslC4/fZCC7sHVrsitVWMa6DDjpMBSBu4GAVvUK54GXDowrqc08qf/MYr/Qv7Z4zT
 mHDw==
X-Gm-Message-State: AFq9FYJZndhoUDbfChEwwDO90KdcvB5vvxYFr7gvk09NR/fk+uHXjYdN
 08isaL7xggw5EKfquyqnIhnVXz/6DExIeNWQ9Yr5HYqlo8cHiteBiLbugkVBLaK2rYSqRoKrzXe
 qpzD7gbcu+OikhUbegnqn4ye69Jv1MSo=
X-Gm-Gg: AYBFou0nbNnng/iuKQxmBbxEzy9zDV5ddoimSxDS3FIjAiVg3GTR1tF3iuM8JcRHb2x
 8GP+RQR3Cn4ZjyKRQA+UGRJVDSnZR6wujscnzmkIXTshCNtLPvXBl0CtzmRUHjmcCb8Ik1Nj02o
 pjhxQGKgZiTJWcEfWcN7OkFtPIGVztncB+grqwipNgANcRFqLQ6mX6Jv40VNa5+romKMr4SdKCA
 aGUEgSGrqcbyjr8PX9uER32ON4/Elo8072b62cRndtVpUSKC4LcAi2q6E6kmbEQID8P9f82YQJb
 ilM2y2YHiu3RlFlN3WHxWxvRX1sfUDHvZhVC/q+gaj82xUc9qaKmpLbY4czT/AoUnKjEPLtiS2F
 8VtMmi8exFcJBIZo=
X-Received: by 2002:a05:690c:6c07:b0:8ab:42fd:2cc2 with SMTP id
 00721157ae682-8ae948abd2cmr18084437b3.3.1791129204937; Sun, 04 Oct 2026
 08:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-11-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-11-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:53:11 +0800
X-Gm-Features: AclHuK9C-2-y7S9nPdOcUh6UsopZpEUX2Y3UTQrWFieju1PrSZM9j_7xEKY6_vg
Message-ID: <CAEUhbmVcGKSUFLCKX=eREfmXwjq7oKTqjqsUxCus7-2g2WpwBg@mail.gmail.com>
Subject: Re: [PATCH v2 10/30] tests/functional/arm: Add console test for
 `mcimx7d-sabre` machine
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Bernhard,

On Sun, Oct 4, 2026 at 8:29=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:

nits: please add a simple commit body.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  MAINTAINERS                                |  1 +
>  tests/functional/arm/meson.build           |  1 +
>  tests/functional/arm/test_mcimx7d_sabre.py | 46 ++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f31245716a..a605d65d94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -935,6 +935,7 @@ F: include/hw/misc/imx7_*.h
>  F: hw/pci-host/designware.c
>  F: include/hw/pci-host/designware.h
>  F: docs/system/arm/mcimx7d-sabre.rst
> +F: tests/functional/arm/test_mcimx7d_sabre.py
>
>  MCIMX8MM-EVK / iMX8MM
>  M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meso=
n.build
> index 761b371a8d..e49a04ea6a 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -20,6 +20,7 @@ test_arm_timeouts =3D {
>    'bpim2u' : 500,
>    'collie' : 180,
>    'cubieboard' : 360,
> +  'mcimx7d-sabre' : 240,

This should be "mcimx7d_sabre".

>    'orangepi' : 540,
>    'quanta_gsj' : 240,
>    'raspi2' : 120,

and missing an entry in tests_arm_system_thorough.

> diff --git a/tests/functional/arm/test_mcimx7d_sabre.py b/tests/functiona=
l/arm/test_mcimx7d_sabre.py
> new file mode 100755
> index 0000000000..2894b5201f
> --- /dev/null
> +++ b/tests/functional/arm/test_mcimx7d_sabre.py
> @@ -0,0 +1,46 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +
> +
> +class Mcimx7dSabreMachine(LinuxKernelTest):
> +
> +    ASSET_KERNEL =3D Asset(
> +        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-ar=
mhf/'
> +         '20230607/images/netboot/vmlinuz'),
> +        '5851e9c61465a26db810796db671c4729e66e81c365b3ebb1a4b7f772737605=
b')
> +
> +    ASSET_INITRD =3D Asset(
> +        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-ar=
mhf/'
> +         '20230607/images/netboot/initrd.gz'),
> +        'fe33f836232a9107716d34dc56d36dea81bab039243a2a42ea6583a50c9b92c=
a')
> +
> +    ASSET_DTB =3D Asset(
> +        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-ar=
mhf/'
> +         '20230607/images/device-tree/imx7d-sdb.dtb'),
> +        'eed45fe3ba682cc814217bc4558551d36c034ec7a7692c4eb6eaf86132baf80=
c')
> +
> +    def setUp(self):
> +        super().setUp()
> +
> +        self.kernel_path =3D self.ASSET_KERNEL.fetch()
> +        self.initrd_path =3D self.ASSET_INITRD.fetch()
> +        self.dtb_path =3D self.ASSET_DTB.fetch()
> +
> +    def test_console(self):
> +        self.require_accelerator("tcg")
> +        self.set_machine('mcimx7d-sabre')
> +        self.vm.set_console(console_index=3D0)
> +        self.vm.add_args('-kernel', self.kernel_path,
> +                         '-initrd', self.initrd_path,
> +                         '-dtb', self.dtb_path)
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Starting system log daemon:')
> +
> +if __name__ =3D=3D '__main__':
> +    LinuxKernelTest.main()
> --

Regards,
Bin

