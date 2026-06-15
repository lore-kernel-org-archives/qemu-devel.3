Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBBECD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 03:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYxwo-0004gP-FH; Sun, 14 Jun 2026 23:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYxwk-0004cn-DK
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 23:25:10 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYxwf-0002qu-GL
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 23:25:08 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68b90fc6a1dso5491826a12.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 20:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781493904; cv=none;
 d=google.com; s=arc-20240605;
 b=awmLsZ+P9JKQeRlWszwaPYu6HHqQM5ZsUL9DHcL3GHkhGuwZf7oRHFSvHW3P4fYf1z
 HfEGSQYnkqTr/ncm8zEF5byDmn6symABPrE6BdIK+pvgDkw4CE8QDOPrNXIhuRj7QNcl
 9WKIGnoExPtkTnljcmhxgpC1wAF3GCeNSNsXoj5kY8Wt80gHONSzFu8P62BL6ZoPvg+m
 PouVdnP8F9GAMspeLZFyp1RRoTtW7DPWHFeEdsWbq4tSRbkNgJ27q8w44ad5alZIUY8I
 YY4AB/b+EqUgGY9mprYH5QSTCkwsTwMz/kL1RPZd28hEyxcX4dJIz9AhKt/jXd2ESihs
 SKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7At/9trscbci42HAhHyi+0fQcDmVf6VzR+v398/5U8Q=;
 fh=E3TfQmhagHMVmkXYUmMdWjlHbrsvqOgPYhexNfCKUa4=;
 b=Aq7fj2IedoYFgSwkddgJor/pcN74r5VDwmsxQgz8SEznoUxX7rUtgi2CpFKUseMCU3
 w+W+TWKAjzuNQn+6IObGQYlUCPKOJTlECNp6h2U376U6bvM2nGx3iCQWRBmu49On/xRg
 y2Tq03A+FBDiYVD/7u7JVxTRmJpvCSyEqFVOHaJdKcg2e46XWFLfC7rid0lPgGcwT7uH
 w+lrcSVjzHrb6EIXCCUVyHUS699ViFiN49pRCt1lkiqsRmgRpzHQAqtL6CV9cl4kcVTG
 A3F5SrATMX1vb/wgM74WRiuVYrFkLmuKGORLloxokEpuFnMvbKZ7qw4nhe4iAv03Z5PE
 t9gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781493904; x=1782098704; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7At/9trscbci42HAhHyi+0fQcDmVf6VzR+v398/5U8Q=;
 b=XYTEGYxJAxu/4Bw9gWYwxCfS/foT/2rzdsInVx8cLsbvLEe+OnhE4AhNBfj9nZnBLY
 qsgvVyYaJmx9SnhmNhC3RRxQTvA7TvkItgB4L8/yFruScqd04HuGamD+dYcApeeX5HAp
 f5NGOUBJWnbskW+ZMhMBGxeT4ESCUHYlRdy3brlppXHybDFlFbwKdLz4Pi6+nEwq7mzE
 rSHk36+2Mb74GKDCuxv3CUbbpRR7pEUd5eKKnHdbjiW2m1PFkW8ScPKsNBuwdg+wds/G
 6hbW4MO0WaMEKxblyKcXe9W3UO6m2pWoR/32OjcPMUuPCcTe+ajs/tKuO2yf7Qp8q1Yg
 Rb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781493904; x=1782098704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7At/9trscbci42HAhHyi+0fQcDmVf6VzR+v398/5U8Q=;
 b=qJkZe3exP5MMvHC+rzCCLkK3Nv4IUdUrbe1FVj3M5iRWHMXTJZnLU8CCpUJUyxTYoH
 537+pSbNLgbxcYP8LzKJErV1qw6OhxuPFg1tKwFAcJ1+fdPa6pZY8k/DTkiMD2o48Auc
 2vv5HZkOck8zWSz2cBkFKDf/2sWCaXQrC4N9XUynZDyQ/JMn382EOwwcXHziey/GbRWe
 mzyKLvKFoQzIm/4aF2m4R5/kgmgJMfJs0sGtdY7O5pvjqOEpVBxjSmAUkHr/RAG7UxhW
 g0tVIo6JKZh5Wd3wDY9hUJzA82e1FwHH8AMGe8j/E/CiKXsIsFoYgZsHY4Burecc3Ut5
 J4Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ86REOhXVKAI6nPUn9zIMtncCiiKe4uygtmANpFN5AAHWxqA19x3W++/egMbsuHDYU4Qz69UzKTt6RQ@nongnu.org
X-Gm-Message-State: AOJu0YwJzr0zGaBZpW8JFXjXZuwcq4PKrN2UQWCIlH/g5JcgLvvpOeT8
 Y1Otr0r+RhinsM0EXy0q1+RMwBEOV2YrtbrCTTChXXIWKzzFbi5jXRtimz3x9npNjILYVZDdgHi
 DyQx2BI2gVS/oF8qsf1RTGc6C+9uLIdmIdkpN
X-Gm-Gg: Acq92OHIA2Kw2bLC5v6xBdJHIDG7XFRFXoM0xrQqt5h/RFK3TErjk6sxORQwtiKoDEp
 uhKewkjBiLwB8F4UVOGv9HDuXDqFNcdf8s8kg+A3nmFmTeI46b6RIVWyKKvZI8zsoQYqknIICmn
 eIdBscvoWQpfLouHhbTBo4O/gh8BY+Br6z9nqABdH5VEnWO3UEJfVy7F5Yb01Y6AEvPcRtn1Pcx
 /G+9qmqXaicgMJFiY5MLRvxVjJzFTnhBB/WDM6IuTS/57EYwiKlv+z3Vh0VBEuKinKK4OJfPV7H
 Si/56WYKQ/QBAa2XDzIXSiKdWodxfVky54r2Pw==
X-Received: by 2002:a05:6402:34c5:b0:670:d548:62a1 with SMTP id
 4fb4d7f45d1cf-69378d96d9emr5214066a12.3.1781493903814; Sun, 14 Jun 2026
 20:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781246408.git.chao.liu@processmission.com>
In-Reply-To: <cover.1781246408.git.chao.liu@processmission.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 13:24:37 +1000
X-Gm-Features: AVVi8CdNjdbRYXqQXovr7S1GFKNdzgFVixKXtDCtAPDY5J-MafsO_aZiNX1N1I8
Message-ID: <CAKmqyKPZUs+XHABifCpRX6B0LTAY0ix6Ar6=Hnn1OLK=yk1tEw@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Add support for K230 board
To: Chao Liu <chao.liu@processmission.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Jun 12, 2026 at 10:17=E2=80=AFPM Chao Liu <chao.liu@processmission.=
com> wrote:
>
> Hi Alistair,
>
> I rebased the K230 patchset on your latest riscv-to-apply.next branch and
> made some adjustments.
>
> Please review the patchset when you have time. Thanks!
>
> ---
>
> This patch series adds support for U-Boot + OpenSBI + standard Linux kern=
el on
> K230 board. Thanks to Peng Jiang, Mig Yang, Renzao Ren, Yao Zi for their =
help.
>
> Test command with the direct Linux boot:
>
> ```
> $QEMU -M k230 \
>       -kernel [Image] \
>       -dtb [k230-qemu.dtb] \
>       -initrd [rootfs.cpio.gz] \
>       -nographic
> ```
>
> The k230-boot-assets repo [1] provides K230 Linux kernel images built wit=
h
> k230-sdk and Yocto.
>
> For more information, see docs/system/riscv/k230.rst.
>
> ---
>
> PATCH v8 changelog:
> - Patches: Rebased on Alistair's riscv-to-apply.next branch.
> - Patch 1: Fixed mmode() check bug, see Milk-v Duo patchset thread [2].
> - Patch 2: Registered riscv64_machine_interfaces for K230 machine.
>
> PATCH v7 changelog:
> - Patches: Removed invalid tags for patchset.
> - Patches: Updated the K230 datasheet link in the patchset comment header=
.
> - Patch 2: Removed the unnecessary changes to MAINTAINERS.
> - Patch 2: Fixed an Oops caused by accesses to an unimpl UART MMIO addres=
s.
> - Patch 2: Adjusted the K230 machine hart count to 1.
> - Patch 2: Supported direct boot linux with `-kernel`.
> - Patch 3: Aligned the WDT interrupt number with the K230 datasheet.
> - Patch 5: Updated k230.rst Linux boot docs.
>
> PATCH v6 changelog:
> - Patches: Rebased on the latest Alistair's riscv-to-apply.next branch.
> - Patch 4: Picked up Fabiano's Acked-by.
>
> PATCH v5 changelog:
> - Patches: Rebased on Alistair's riscv-to-apply.next branch.
> - Patch 2: Fixed reset vector ROM jump to trap-handler bug.
>
> PATCH v4 changelog:
> - Patches: Rebased on the latest master branch.
> - Patches: No functional changes from v3.
>
> PATCH v3 changelog:
> - Patch 1: Align T-Head C908 CPU's RISC-V extension with XUANTIE-QEMU.
> - Patch 2: Adjust PLIC and CLINT addresses to match K230 datasheet.
>
> PATCH v2 changelog:
> - Patch 1: Add Svpbmt extension support for the T-Head C908 CPU.
> - Patch 2: Move the k230.rst definition from MAINTAINERS to Patch 5.
> - Patch 5: Apply Daniel's bugfix to build the k230 documentation successf=
ully.
>
> PATCH v1 changelog:
> - Patch 1: Add T-Head C908 and C908v CPU support.
> - Patch 2: Add K230 board initial support(big core is not supported yet).
> - Patch 3: Add Programmable Watchdog Timer (WDT) peripheral support.
> - Patch 4: Add QEMU test for K230 watchdog.
> - Patch 5: Add documentation for K230 machine.
>
> ---
>
> Link:
> [1] https://github.com/zevorn/k230-boot-assets
> [2] https://lore.kernel.org/qemu-devel/agZFchak-jsc2moK@ZEVORN-PC.localdo=
main/
>
> Thanks,
> Chao
>
> Chao Liu (5):
>   target/riscv: add thead-c908 cpu support
>   hw/riscv: add k230 board initial support
>   hw/watchdog: add k230 watchdog initial support
>   tests/qtest: add test for K230 watchdog
>   docs/system/riscv: add documentation for k230 machine

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  MAINTAINERS                    |  11 +
>  docs/system/riscv/k230.rst     | 113 +++++++
>  docs/system/target-riscv.rst   |   1 +
>  hw/riscv/Kconfig               |  11 +
>  hw/riscv/k230.c                | 526 +++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build           |   2 +-
>  hw/watchdog/Kconfig            |   4 +
>  hw/watchdog/k230_wdt.c         | 296 +++++++++++++++++++
>  hw/watchdog/meson.build        |   1 +
>  hw/watchdog/trace-events       |   9 +
>  include/hw/riscv/k230.h        | 149 ++++++++++
>  include/hw/watchdog/k230_wdt.h | 121 ++++++++
>  target/riscv/cpu-qom.h         |   2 +
>  target/riscv/cpu.c             |  51 ++++
>  target/riscv/th_csr.c          | 376 ++++++++++++++++++++++-
>  tests/qtest/k230-wdt-test.c    | 189 ++++++++++++
>  tests/qtest/meson.build        |   3 +-
>  17 files changed, 1862 insertions(+), 3 deletions(-)
>  create mode 100644 docs/system/riscv/k230.rst
>  create mode 100644 hw/riscv/k230.c
>  create mode 100644 hw/watchdog/k230_wdt.c
>  create mode 100644 include/hw/riscv/k230.h
>  create mode 100644 include/hw/watchdog/k230_wdt.h
>  create mode 100644 tests/qtest/k230-wdt-test.c
>
> --
> 2.54.0
>
>

