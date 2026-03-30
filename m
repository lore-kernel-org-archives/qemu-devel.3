Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423FB10D14A3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B0B-0005HW-6c; Mon, 30 Mar 2026 07:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7AxN-0003Df-GE
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:38:58 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7AxL-0003Nd-8F
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:38:57 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a1307438ddso4697096e87.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774870732; cv=none;
 d=google.com; s=arc-20240605;
 b=dXWAUTxxomJz2n4pALB+u55mRwTZL1lEI6Ddlusap9RothUq2SSWMmMLm9JYK1r+4O
 RRTES4giQg7bdxOrVrQNjLT6kuGuBLTwJJkTpy0QqhXq9ZMeXBtUMDWPDQV2LzB26P8Y
 MjAJmOjIyu4YrJZU06j8H7T6MDmViCCdrm2oaNkFm5wEI99OTY0QUUlQ7vdEJMD7WNsw
 FPkn61/z9gcFHVInq0qwOMAF7xOgdBiiok5JpQZti6ey1t40U42m/Gydxq/lLjLq608X
 3YVkt8afleE+zOxqPj2VGFciQhwKbfwwWXbBcQr8ODJq/qRc9phHQXv63KkRGtobDBBi
 MDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7QOIxGNODh8eZAcY47P2sAxksUyXoWqyutrfHbiJ/uk=;
 fh=08goD6SiRg7IGGgS0C1Qx+bWJOozwiVtoMucZMBi98Y=;
 b=d2K6wIFohiJfZvWutPkN1b32LNrsCVA7SjRoNNZrhIf35gHimyLGTFAFHninQld5Z8
 DrSVF1SXf0gbRrKpeffHS7RGJ4i6CuknnrfYMZUCMoHUBLjhNjMKlqX1pVi6Wcf5csE+
 ctMt7T9nGwTViKzen5WTAIGfS9o8rZ+m4A8+Ge80UqIcNzBEYg9cv3R4Kfi4UyUvR67V
 no/KaklhAopGx6r4JEjJXaMU6/pDfDRv8k2UvCOzW06VkTbmb//CbHPE/NGL5jiR5LHL
 CKnbEJAzZQKV4oXxvJFuh1SZXeLuEoevIN8fAL44+ZYEVVDdPnNYBL1hruyyvDwj1rIH
 90+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1774870732; x=1775475532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QOIxGNODh8eZAcY47P2sAxksUyXoWqyutrfHbiJ/uk=;
 b=DiBRG+xttjXFd9NZHGfDxu3e/GzYX/bKOaKLLrN04m3Ark2FR9HVNSZYDWTVNwCOkT
 XDQSDHrC9kVsHwOskn0KrqCyyAaN2JuUcyJ4LVAjx2pXDsz6Wx2zYYXrij2VH7VoRLs3
 QYWOCzUUfaQiLdi6cdTb0zhABoZ/4yPJQ0Ago=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774870732; x=1775475532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7QOIxGNODh8eZAcY47P2sAxksUyXoWqyutrfHbiJ/uk=;
 b=Az57O4PLUZKIVGLLmkdrl9nMDcIbVC9bcHRE7+eX6tZkgWqBIG6jvBYzF2AbPtMxHT
 R1UkmCACXCWLFKlCiovtnFqMcul3NHbA0nHqSETWKkZ8uBJxyZP0ReuRtbyZMmdPlT4o
 EocssbG1Vs77cCwLQ00pSY2j4rqYqAiYYV5V0K+CCSJL+kpNVj4CFH6jvzsVAQB/AcvW
 SsNd88MXU7B3RrNgxv0506IF/oaEnW+2XgBMrzlt5BTJhIsADFAI5q1TaYXLewzax1vU
 dJkxtiiyN6laMV3oA8SkO14/6M58NGTGA08DDTKIdNrPSTviIWE6x51taz07mXVuMWq4
 22TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoiq8fl0Cbmb7ovWCbBEPdXTjLcyFtRdGhMCHl9C6hFjDno49s2gIHQcRJV9W/BhzKWth6GZ+VHx/q@nongnu.org
X-Gm-Message-State: AOJu0Ywukf3dT72yBitkH8c4FjzXMMNiaLqdQUFxNGr62CWmhX9cuJoR
 XRgf7Vbx+U08w3jv/ZabOFhrVWin+Ku2ZgNJ4dpU4CZ+pbjdFe8Vqn5K5EM698rBoVkAvQySGHM
 RG3xNYQA4HILz46kEdst2b4KKgwdjJvbM2C22lMEbaw==
X-Gm-Gg: ATEYQzxU0TmbRBienXPaoGLL23LOob14UfblnsU7cAJ0iYxpVUtfZtXMb8/f8FO5wui
 m93IAdXTUd0Hv4frp2r6vR9nUMdXowNh1p1vpOkmKqIhAZctrXP1AYKu0eyuau3+Jn09Jl1X8VV
 03JLBY/GCFbv71fxdGs0AKOoDoDxPjVFBwkJuwsJlKp0kHzOEXni1fAugJz6EygYtNbUeb6BLcg
 w9BiqO0IfU4yOQ2Vs0W2nQBkRL0JxaSnicsg245HV3ferLbvPOiMLmjcU4INhWaAGbC1yXgNdaB
 W+VvC9gSWyLKWPSO7KJbr5MWd4Nbw12bn4RgJdc=
X-Received: by 2002:a05:6512:ac9:b0:5a2:b57d:9522 with SMTP id
 2adb3069b0e04-5a2b57d97a3mr1677480e87.23.1774870731527; Mon, 30 Mar 2026
 04:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
In-Reply-To: <20260317102708.126725-1-alexander@mihalicyn.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 30 Mar 2026 13:38:40 +0200
X-Gm-Features: AQROBzA5UkXxkIX2qGteSU584sxU6z3PrbrMXcF21Lzsv_q78vKId8NWIvCrVSo
Message-ID: <CAJqdLrqiOqJy91aTiv-VfuUjpyeOS5quodGK7JGAczV+hjqqZQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] hw/nvme: add basic live migration support
To: Klaus Jensen <its@irrelevant.dk>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x130.google.com
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

Hi Klaus,

sorry for bothering you with this.

I've fixed my patchset in accordance with all your suggestions from
https://lore.kernel.org/qemu-devel/aaFrB7fMMUPfMP_5@AALNPWKJENSEN.aal.scsc.=
local/
please can you take a look on my patchset once again?

Kind regards,
Alex

Am Di., 17. M=C3=A4rz 2026 um 11:27 Uhr schrieb Alexander Mikhalitsyn
<alexander@mihalicyn.com>:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Dear friends,
>
> This patchset adds basic live migration support for
> QEMU emulated NVMe device.
>
> Implementation has some limitations:
> - only one NVMe namespace is supported
> - SMART counters are not preserved
> - CMB is not supported
> - PMR is not supported
> - SPDM is not supported
> - SR-IOV is not supported
>
> I believe this is something I can support in next patchset versions or
> separately on-demand (when usecase appears).
>
> Testing.
>
> This patch series was manually tested on:
> - Debian 13.3 VM (kernel 6.12.69+deb13-amd64) using fio on *non-root* NVM=
e disk
>   (root disk was virtio-scsi):
>
> time fio --name=3Dnvme-verify \
>     --filename=3D/dev/nvme0n1 \
>     --size=3D5G \
>     --rw=3Drandwrite \
>     --bs=3D4k \
>     --iodepth=3D16 \
>     --numjobs=3D1 \
>     --direct=3D0 \
>     --ioengine=3Dio_uring \
>     --verify=3Dcrc32c \
>     --verify_fatal=3D1
>
> - Windows Server 2022 VM (NVMe drive was a *root* disk) with opened brows=
er
>   playing video.
>
> No defects were found.
>
> Git tree:
> https://github.com/mihalicyn/qemu/commits/nvme-live-migration
>
> Changelog for version 5:
> - rebased on top of https://lore.kernel.org/all/20260304212303.667141-1-v=
sementsov@yandex-team.ru/
>   (as Peter has requested)
>
> Changelog for version 4:
> - vmstate dynamic array support reworked as suggested by Peter Xu
>   VMS_ARRAY_OF_POINTER_ALLOW_NULL flag was introduced
>   qtests were added
> - NVMe migration blockers were reworked as Klaus has requested earlier
>   Now, instead of having "deny list" approach, we have more strict patter=
n
>   of NVMe features filtering and it should be harded to break migration w=
hen
>   adding new NVMe features.
>
> Changelog for version 3:
> - rebased
> - simple functional test was added (in accordance with Klaus Jensen's rev=
iew comment)
>   $ meson test 'func-x86_64-nvme_migration' --setup thorough -C build
>
> Changelog for version 2:
> - full support for AERs (in-flight requests and queued events too)
>
> Kind regards,
> Alex
>
> Alexander Mikhalitsyn (8):
>   migration/vmstate: export vmstate_{load, save}_field helpers
>   migration: add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
>   tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_ALLOW_NULL
>   tests/functional/migration: add VM launch/configure hooks
>   hw/nvme: add migration blockers for non-supported cases
>   hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
>   hw/nvme: add basic live migration support
>   tests/functional/x86_64: add migration test for NVMe device
>
>  hw/nvme/ctrl.c                                | 874 +++++++++++++++++-
>  hw/nvme/ns.c                                  | 160 ++++
>  hw/nvme/nvme.h                                |   8 +
>  hw/nvme/trace-events                          |  11 +
>  include/block/nvme.h                          |  12 +
>  include/migration/vmstate.h                   |  83 +-
>  migration/savevm.c                            |  26 +
>  migration/vmstate-types.c                     |  91 ++
>  migration/vmstate.c                           |  64 +-
>  tests/functional/migration.py                 |  22 +-
>  tests/functional/x86_64/meson.build           |   1 +
>  .../functional/x86_64/test_nvme_migration.py  | 159 ++++
>  tests/unit/test-vmstate.c                     | 157 ++++
>  13 files changed, 1618 insertions(+), 50 deletions(-)
>  create mode 100755 tests/functional/x86_64/test_nvme_migration.py
>
> --
> 2.47.3
>

