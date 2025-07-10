Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79558C83F1F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZo8z-0006rk-Bh; Thu, 10 Jul 2025 06:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZo4C-0004Ld-Te
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:59:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZo42-0007tn-JS
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:59:48 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c8cso1143731a12.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752141576; x=1752746376; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MK8rl9XgX+WYd+inM1R0Y3/IdgU2llyu4/Xa23p6aY=;
 b=WRUp6Y20JnssR1vnTX+9+SOREhS87LioFkkMS8ICL+7njA6AJW5ZB7k/glpN2BEBeL
 igaS0mZYjINEoQz+lRuFxe9/hPwStLMkZ7kaqCttoJr8XKfw2vVGIdcWsFVclnMmx6rM
 jZ7f6Nwd6OU/MnrP642kA/qqiCJvzCrr9iNKjoVr/+p24t7DwVI6Dbb0mQPlO+lYe+4j
 ZKEd5nYqfARkCly1lZx3jE88ZY4BgkQTZCA61ckw29FLZNQp44u0lUfM5Vveb44B5je7
 3x9HU6P6PCQP1DAD5nFofrZ/5mtM9KGZN4nWmmaI+GAsDbdO8RujgBUq4hW3Qot5HTCX
 WiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752141576; x=1752746376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MK8rl9XgX+WYd+inM1R0Y3/IdgU2llyu4/Xa23p6aY=;
 b=YA1AjVBv5FExjNEjCA8CIuxnxWT2XIVC8A4p8Sjmq3TIjHNK09TjZol5jjFlNZgTt9
 jeaB/LigsZYpW2cXe+0zTSQF7uceiZny3Jw1WHU9zzG8TRlMdhUzvOzLX0zr8SJe43Nl
 2/9ybGCUATZv7SwosRQEVZ5cq5s5/HW3ZD/H8SEB/VZPTbj0iPrIgOd9zHEBPSniUtvM
 jw00+KqexPx7r+Re4KqJ94cyO+XaN9ByPpJlzzSot3qqeXHe0hmqJA3waJJSkHNuclxl
 gE8AXyPplWo7vfYE6BEfh9v1iGiKypJE3P1nFq6gbIx8kZi6cT5BFhiM5Wx3VnfJsqWN
 MJlA==
X-Gm-Message-State: AOJu0YxlyNV30Deqh1btXdmr+KUjziOJnB3ERt+c3wpmONUBxixJZTiF
 hml1JxQK2iIATlwFeXQX+Xd4EdPyWNs5kvQ3NOtoEy1BmYvUjb8G9H+UIvOAXWtlzQ0moRUcZEl
 V4CPScyVzNVrmxCvBVjRVh2lvAjqWEC/ZMGY5IWLxDg==
X-Gm-Gg: ASbGncuYK8lMuXjEoGl/f0xxQBnOm1z17FbzTBk4JjYmGMSWY5gU52G9F7SczI2cedH
 AJJ4ISTw27TUn9YcsznZzeab3yaH8e9d7edkbyGeMPFOkTQgS/shTZtRqQU296f3/IqV0GxDNFJ
 7DndkyIdaZSQMaWI7nGDqHA4s08jDc1lLgdN82/oxOAXI=
X-Google-Smtp-Source: AGHT+IHqv1uxHMH29RkNAjp+lIMeczTlFdhVo8NdeMNUDa+I+A4n9C8AE2JeD63/JS7Qwu7O+1oyZeHfChd5piO5oLM=
X-Received: by 2002:a05:6402:254f:b0:606:d25c:c779 with SMTP id
 4fb4d7f45d1cf-611c85d4c60mr1737057a12.34.1752141575564; Thu, 10 Jul 2025
 02:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250710094251.139514-1-thuth@redhat.com>
In-Reply-To: <20250710094251.139514-1-thuth@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 10 Jul 2025 12:59:08 +0300
X-Gm-Features: Ac12FXzzcijHArC_ooS-1QsFxSpO6l6JETcEx2LOGZLX-sJWbJRH4Le2zcbmQAo
Message-ID: <CAAjaMXaZEWBtQ6kV2zZEj=uzvnPnOMYPV7HgW4n0yBF=TLsRJA@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/functional: Move tests into architecture
 specific folders
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, 
 qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, Jul 10, 2025 at 12:51=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> This patch tackles two issues. First, the tests/functional folder has
> become quite crowded already, some restructuring would be helpful here.
> Second, we currently encode the target architecture twice in the test
> names since a lot of the test file names contain the target, too.
> This contributes to the very long output lines when running "make
> check-functional".
>
> So let's move the individual test files to target specific folders now.
> Then we can drop the target from the file name (and thus from the test
> name).
>
> Before the change, the output looked like this:
>
>  ...
>  195/236 qemu:func-thorough+func-microblazeel-thorough+thorough / func-mi=
croblazeel-microblazeel_s3adsp1800          OK                2.00s   2 sub=
tests passed
>  196/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-micr=
oblaze-microblaze_replay                    OK                2.78s   1 sub=
tests passed
>  197/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-micr=
oblaze-microblaze_s3adsp1800                OK                2.02s   2 sub=
tests passed
>  198/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64=
el-mips64el_fuloong2e                       OK                1.95s   1 sub=
tests passed
>  199/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64=
el-mips64el_loongson3v                      SKIP              0.07s   0 sub=
tests passed
>  200/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64=
el-mips64el_tuxrun                          OK                8.52s   1 sub=
tests passed
>  ...
>
> After this change, it gets a little bit shorter:
>
>  ...
>  195/236 qemu:func-thorough+func-microblazeel-thorough+thorough / func-mi=
croblazeel-s3adsp1800          OK                2.12s   2 subtests passed
>  196/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-micr=
oblaze-replay                  OK                2.90s   1 subtests passed
>  197/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-micr=
oblaze-s3adsp1800              OK                2.07s   2 subtests passed
>  198/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64=
el-fuloong2e                   OK                2.05s   1 subtests passed
>  199/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64=
el-loongson3v                  SKIP              0.07s   0 subtests passed
>  200/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64=
el-tuxrun                      OK                8.84s   1 subtests passed
>  ...
>
> Tests that can be used for multiple but not all targets (like the "migrat=
ion"
> test) are now handled via symlinks in the target folders.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Marked as RFC since I'm not that happy about the symlinks yet ...
>        if someone has a better idea, please let me know!

How about making those tests utility functions that each target arch
imports and calls? It feels cleaner than symlinks, I think.

>        Also the update to the MAINTAINERS file is still missing - I'll ad=
d
>        that once we agreed on whether this patch is a good idea or not.
>
>  tests/functional/aarch64/meson.build          |  47 +++
>  .../test_aspeed_ast2700.py}                   |   0
>  .../test_aspeed_ast2700fc.py}                 |   0
>  .../test_device_passthrough.py}               |   0
>  .../test_hotplug_pci.py}                      |   0
>  .../test_imx8mp_evk.py}                       |   0
>  tests/functional/aarch64/test_migration.py    |   1 +
>  tests/functional/aarch64/test_multiprocess.py |   1 +
>  .../test_raspi3.py}                           |   0
>  .../test_raspi4.py}                           |   0
>  .../test_replay.py}                           |   0
>  .../test_reverse_debug.py}                    |   0
>  .../test_rme_sbsaref.py}                      |   2 +-
>  .../test_rme_virt.py}                         |   0
>  .../test_sbsaref.py}                          |   0
>  .../test_sbsaref_alpine.py}                   |   2 +-
>  .../test_sbsaref_freebsd.py}                  |   2 +-
>  .../test_smmu.py}                             |   0
>  .../test_tcg_plugins.py}                      |   0
>  .../test_tuxrun.py}                           |   0
>  .../test_virt.py}                             |   0
>  .../test_virt_gpu.py}                         |   0
>  .../test_xen.py}                              |   0
>  .../test_xlnx_versal.py}                      |   0
>  tests/functional/alpha/meson.build            |   9 +
>  .../test_clipper.py}                          |   0
>  tests/functional/alpha/test_migration.py      |   1 +
>  .../test_replay.py}                           |   0
>  tests/functional/arm/meson.build              |  61 +++
>  .../test_aspeed_ast1030.py}                   |   0
>  .../test_aspeed_ast2500.py}                   |   0
>  .../test_aspeed_ast2600.py}                   |   0
>  .../test_aspeed_bletchley.py}                 |   0
>  .../test_aspeed_catalina.py}                  |   0
>  .../test_aspeed_gb200nvl_bmc.py}              |   0
>  .../test_aspeed_palmetto.py}                  |   0
>  .../test_aspeed_rainier.py}                   |   0
>  .../test_aspeed_romulus.py}                   |   0
>  .../test_aspeed_witherspoon.py}               |   0
>  .../{test_arm_bflt.py =3D> arm/test_bflt.py}    |   0
>  .../test_bpim2u.py}                           |   0
>  .../test_canona1100.py}                       |   0
>  .../test_collie.py}                           |   0
>  .../test_cubieboard.py}                       |   0
>  .../test_emcraft_sf2.py}                      |   0
>  .../test_integratorcp.py}                     |   0
>  .../test_microbit.py}                         |   0
>  tests/functional/arm/test_migration.py        |   1 +
>  .../test_orangepi.py}                         |   0
>  .../test_quanta_gsj.py}                       |   0
>  .../test_raspi2.py}                           |   0
>  .../test_realview.py}                         |   0
>  .../test_replay.py}                           |   0
>  .../test_smdkc210.py}                         |   0
>  .../test_stellaris.py}                        |   0
>  .../{test_arm_sx1.py =3D> arm/test_sx1.py}      |   0
>  .../test_tuxrun.py}                           |   0
>  .../test_vexpress.py}                         |   0
>  .../{test_arm_virt.py =3D> arm/test_virt.py}    |   0
>  tests/functional/avr/meson.build              |   5 +
>  .../test_mega2560.py}                         |   0
>  .../{test_avr_uno.py =3D> avr/test_uno.py}      |   0
>  .../{ =3D> generic}/test_empty_cpu_model.py     |   0
>  .../{ =3D> generic}/test_info_usernet.py        |   0
>  .../{ =3D> generic}/test_migration.py           |   0
>  .../functional/{ =3D> generic}/test_version.py  |   0
>  tests/functional/hppa/meson.build             |   4 +
>  .../test_seabios.py}                          |   0
>  tests/functional/i386/meson.build             |   9 +
>  tests/functional/i386/test_migration.py       |   1 +
>  .../test_replay.py}                           |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/loongarch64/meson.build      |   4 +
>  .../test_virt.py}                             |   0
>  tests/functional/m68k/meson.build             |   8 +
>  .../test_mcf5208evb.py}                       |   0
>  .../test_nextcube.py}                         |   0
>  .../{test_m68k_q800.py =3D> m68k/test_q800.py}  |   0
>  .../test_replay.py}                           |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/meson.build                  | 364 ++----------------
>  tests/functional/microblaze/meson.build       |   5 +
>  .../test_replay.py}                           |   0
>  .../test_s3adsp1800.py}                       |   0
>  tests/functional/microblazeel/meson.build     |   4 +
>  .../test_s3adsp1800.py}                       |   2 +-
>  tests/functional/mips/meson.build             |  11 +
>  .../test_malta.py}                            |   0
>  .../test_replay.py}                           |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/mips64/meson.build           |  10 +
>  .../test_malta.py}                            |   2 +-
>  .../test_tuxrun.py}                           |   0
>  tests/functional/mips64el/meson.build         |  14 +
>  .../test_fuloong2e.py}                        |   0
>  .../test_loongson3v.py}                       |   0
>  .../test_malta.py}                            |   4 +-
>  .../test_replay.py}                           |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/mipsel/meson.build           |  12 +
>  .../test_malta.py}                            |   2 +-
>  .../test_replay.py}                           |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/or1k/meson.build             |   5 +
>  .../test_replay.py}                           |   0
>  .../{test_or1k_sim.py =3D> or1k/test_sim.py}    |   0
>  tests/functional/ppc/meson.build              |  22 ++
>  .../{test_ppc_40p.py =3D> ppc/test_40p.py}      |   0
>  .../{test_ppc_74xx.py =3D> ppc/test_74xx.py}    |   0
>  .../{test_ppc_amiga.py =3D> ppc/test_amiga.py}  |   0
>  .../test_bamboo.py}                           |   0
>  .../{test_ppc_mac.py =3D> ppc/test_mac.py}      |   0
>  tests/functional/ppc/test_migration.py        |   1 +
>  .../test_mpc8544ds.py}                        |   0
>  .../test_replay.py}                           |   0
>  .../test_sam460ex.py}                         |   0
>  .../test_tuxrun.py}                           |   0
>  .../test_virtex_ml507.py}                     |   0
>  tests/functional/ppc64/meson.build            |  25 ++
>  .../test_e500.py}                             |   0
>  .../{test_ppc64_hv.py =3D> ppc64/test_hv.py}    |   0
>  .../test_mac99.py}                            |   0
>  tests/functional/ppc64/test_migration.py      |   1 +
>  .../test_powernv.py}                          |   0
>  .../test_pseries.py}                          |   0
>  .../test_replay.py}                           |   0
>  .../test_reverse_debug.py}                    |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/riscv32/meson.build          |   9 +
>  tests/functional/riscv32/test_migration.py    |   1 +
>  tests/functional/riscv32/test_opensbi.py      |   1 +
>  .../test_tuxrun.py}                           |   0
>  tests/functional/riscv64/meson.build          |  13 +
>  .../test_opensbi.py}                          |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/rx/meson.build               |   4 +
>  .../{test_rx_gdbsim.py =3D> rx/test_gdbsim.py}  |   0
>  tests/functional/s390x/meson.build            |  12 +
>  .../test_ccw_virtio.py}                       |   0
>  .../test_replay.py}                           |   0
>  .../test_topology.py}                         |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/sh4/meson.build              |  10 +
>  .../{test_sh4_r2d.py =3D> sh4/test_r2d.py}      |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/sh4eb/meson.build            |   4 +
>  .../{test_sh4eb_r2d.py =3D> sh4eb/test_r2d.py}  |   0
>  tests/functional/sparc/meson.build            |   9 +
>  tests/functional/sparc/test_migration.py      |   1 +
>  .../test_replay.py}                           |   0
>  .../test_sun4m.py}                            |   0
>  tests/functional/sparc64/meson.build          |   9 +
>  tests/functional/sparc64/test_migration.py    |   1 +
>  .../test_sun4u.py}                            |   0
>  .../test_tuxrun.py}                           |   0
>  tests/functional/x86_64/meson.build           |  37 ++
>  .../functional/{ =3D> x86_64}/test_acpi_bits.py |   0
>  .../{ =3D> x86_64}/test_cpu_queries.py          |   0
>  .../test_hotplug_blk.py}                      |   0
>  .../test_hotplug_cpu.py}                      |   0
>  .../{ =3D> x86_64}/test_intel_iommu.py          |   0
>  .../test_kvm_xen.py}                          |   0
>  .../{ =3D> x86_64}/test_linux_initrd.py         |   0
>  .../{ =3D> x86_64}/test_mem_addr_space.py       |   0
>  tests/functional/{ =3D> x86_64}/test_memlock.py |   0
>  tests/functional/x86_64/test_migration.py     |   1 +
>  .../{ =3D> x86_64}/test_multiprocess.py         |   0
>  .../{ =3D> x86_64}/test_netdev_ethtool.py       |   0
>  .../{ =3D> x86_64}/test_pc_cpu_hotplug_props.py |   0
>  .../test_replay.py}                           |   0
>  .../test_reverse_debug.py}                    |   0
>  .../test_tuxrun.py}                           |   0
>  .../{ =3D> x86_64}/test_virtio_balloon.py       |   0
>  .../{ =3D> x86_64}/test_virtio_gpu.py           |   0
>  .../{ =3D> x86_64}/test_virtio_version.py       |   0
>  tests/functional/{ =3D> x86_64}/test_vnc.py     |   0
>  .../test_x86_cpu_model_versions.py            |   0
>  tests/functional/xtensa/meson.build           |   5 +
>  .../test_lx60.py}                             |   0
>  .../test_replay.py}                           |   0
>  180 files changed, 426 insertions(+), 333 deletions(-)
>  create mode 100644 tests/functional/aarch64/meson.build
>  rename tests/functional/{test_aarch64_aspeed_ast2700.py =3D> aarch64/tes=
t_aspeed_ast2700.py} (100%)
>  rename tests/functional/{test_aarch64_aspeed_ast2700fc.py =3D> aarch64/t=
est_aspeed_ast2700fc.py} (100%)
>  rename tests/functional/{test_aarch64_device_passthrough.py =3D> aarch64=
/test_device_passthrough.py} (100%)
>  rename tests/functional/{test_aarch64_hotplug_pci.py =3D> aarch64/test_h=
otplug_pci.py} (100%)
>  rename tests/functional/{test_aarch64_imx8mp_evk.py =3D> aarch64/test_im=
x8mp_evk.py} (100%)
>  create mode 120000 tests/functional/aarch64/test_migration.py
>  create mode 120000 tests/functional/aarch64/test_multiprocess.py
>  rename tests/functional/{test_aarch64_raspi3.py =3D> aarch64/test_raspi3=
.py} (100%)
>  rename tests/functional/{test_aarch64_raspi4.py =3D> aarch64/test_raspi4=
.py} (100%)
>  rename tests/functional/{test_aarch64_replay.py =3D> aarch64/test_replay=
.py} (100%)
>  rename tests/functional/{test_aarch64_reverse_debug.py =3D> aarch64/test=
_reverse_debug.py} (100%)
>  rename tests/functional/{test_aarch64_rme_sbsaref.py =3D> aarch64/test_r=
me_sbsaref.py} (98%)
>  rename tests/functional/{test_aarch64_rme_virt.py =3D> aarch64/test_rme_=
virt.py} (100%)
>  rename tests/functional/{test_aarch64_sbsaref.py =3D> aarch64/test_sbsar=
ef.py} (100%)
>  rename tests/functional/{test_aarch64_sbsaref_alpine.py =3D> aarch64/tes=
t_sbsaref_alpine.py} (97%)
>  rename tests/functional/{test_aarch64_sbsaref_freebsd.py =3D> aarch64/te=
st_sbsaref_freebsd.py} (97%)
>  rename tests/functional/{test_aarch64_smmu.py =3D> aarch64/test_smmu.py}=
 (100%)
>  rename tests/functional/{test_aarch64_tcg_plugins.py =3D> aarch64/test_t=
cg_plugins.py} (100%)
>  rename tests/functional/{test_aarch64_tuxrun.py =3D> aarch64/test_tuxrun=
.py} (100%)
>  rename tests/functional/{test_aarch64_virt.py =3D> aarch64/test_virt.py}=
 (100%)
>  rename tests/functional/{test_aarch64_virt_gpu.py =3D> aarch64/test_virt=
_gpu.py} (100%)
>  rename tests/functional/{test_aarch64_xen.py =3D> aarch64/test_xen.py} (=
100%)
>  rename tests/functional/{test_aarch64_xlnx_versal.py =3D> aarch64/test_x=
lnx_versal.py} (100%)
>  create mode 100644 tests/functional/alpha/meson.build
>  rename tests/functional/{test_alpha_clipper.py =3D> alpha/test_clipper.p=
y} (100%)
>  create mode 120000 tests/functional/alpha/test_migration.py
>  rename tests/functional/{test_alpha_replay.py =3D> alpha/test_replay.py}=
 (100%)
>  create mode 100644 tests/functional/arm/meson.build
>  rename tests/functional/{test_arm_aspeed_ast1030.py =3D> arm/test_aspeed=
_ast1030.py} (100%)
>  rename tests/functional/{test_arm_aspeed_ast2500.py =3D> arm/test_aspeed=
_ast2500.py} (100%)
>  rename tests/functional/{test_arm_aspeed_ast2600.py =3D> arm/test_aspeed=
_ast2600.py} (100%)
>  rename tests/functional/{test_arm_aspeed_bletchley.py =3D> arm/test_aspe=
ed_bletchley.py} (100%)
>  rename tests/functional/{test_arm_aspeed_catalina.py =3D> arm/test_aspee=
d_catalina.py} (100%)
>  rename tests/functional/{test_arm_aspeed_gb200nvl_bmc.py =3D> arm/test_a=
speed_gb200nvl_bmc.py} (100%)
>  mode change 100644 =3D> 100755
>  rename tests/functional/{test_arm_aspeed_palmetto.py =3D> arm/test_aspee=
d_palmetto.py} (100%)
>  rename tests/functional/{test_arm_aspeed_rainier.py =3D> arm/test_aspeed=
_rainier.py} (100%)
>  rename tests/functional/{test_arm_aspeed_romulus.py =3D> arm/test_aspeed=
_romulus.py} (100%)
>  rename tests/functional/{test_arm_aspeed_witherspoon.py =3D> arm/test_as=
peed_witherspoon.py} (100%)
>  rename tests/functional/{test_arm_bflt.py =3D> arm/test_bflt.py} (100%)
>  rename tests/functional/{test_arm_bpim2u.py =3D> arm/test_bpim2u.py} (10=
0%)
>  rename tests/functional/{test_arm_canona1100.py =3D> arm/test_canona1100=
.py} (100%)
>  rename tests/functional/{test_arm_collie.py =3D> arm/test_collie.py} (10=
0%)
>  rename tests/functional/{test_arm_cubieboard.py =3D> arm/test_cubieboard=
.py} (100%)
>  rename tests/functional/{test_arm_emcraft_sf2.py =3D> arm/test_emcraft_s=
f2.py} (100%)
>  rename tests/functional/{test_arm_integratorcp.py =3D> arm/test_integrat=
orcp.py} (100%)
>  rename tests/functional/{test_arm_microbit.py =3D> arm/test_microbit.py}=
 (100%)
>  create mode 120000 tests/functional/arm/test_migration.py
>  rename tests/functional/{test_arm_orangepi.py =3D> arm/test_orangepi.py}=
 (100%)
>  rename tests/functional/{test_arm_quanta_gsj.py =3D> arm/test_quanta_gsj=
.py} (100%)
>  rename tests/functional/{test_arm_raspi2.py =3D> arm/test_raspi2.py} (10=
0%)
>  rename tests/functional/{test_arm_realview.py =3D> arm/test_realview.py}=
 (100%)
>  rename tests/functional/{test_arm_replay.py =3D> arm/test_replay.py} (10=
0%)
>  rename tests/functional/{test_arm_smdkc210.py =3D> arm/test_smdkc210.py}=
 (100%)
>  rename tests/functional/{test_arm_stellaris.py =3D> arm/test_stellaris.p=
y} (100%)
>  rename tests/functional/{test_arm_sx1.py =3D> arm/test_sx1.py} (100%)
>  rename tests/functional/{test_arm_tuxrun.py =3D> arm/test_tuxrun.py} (10=
0%)
>  rename tests/functional/{test_arm_vexpress.py =3D> arm/test_vexpress.py}=
 (100%)
>  rename tests/functional/{test_arm_virt.py =3D> arm/test_virt.py} (100%)
>  create mode 100644 tests/functional/avr/meson.build
>  rename tests/functional/{test_avr_mega2560.py =3D> avr/test_mega2560.py}=
 (100%)
>  rename tests/functional/{test_avr_uno.py =3D> avr/test_uno.py} (100%)
>  rename tests/functional/{ =3D> generic}/test_empty_cpu_model.py (100%)
>  rename tests/functional/{ =3D> generic}/test_info_usernet.py (100%)
>  rename tests/functional/{ =3D> generic}/test_migration.py (100%)
>  rename tests/functional/{ =3D> generic}/test_version.py (100%)
>  create mode 100644 tests/functional/hppa/meson.build
>  rename tests/functional/{test_hppa_seabios.py =3D> hppa/test_seabios.py}=
 (100%)
>  create mode 100644 tests/functional/i386/meson.build
>  create mode 120000 tests/functional/i386/test_migration.py
>  rename tests/functional/{test_i386_replay.py =3D> i386/test_replay.py} (=
100%)
>  rename tests/functional/{test_i386_tuxrun.py =3D> i386/test_tuxrun.py} (=
100%)
>  create mode 100644 tests/functional/loongarch64/meson.build
>  rename tests/functional/{test_loongarch64_virt.py =3D> loongarch64/test_=
virt.py} (100%)
>  create mode 100644 tests/functional/m68k/meson.build
>  rename tests/functional/{test_m68k_mcf5208evb.py =3D> m68k/test_mcf5208e=
vb.py} (100%)
>  rename tests/functional/{test_m68k_nextcube.py =3D> m68k/test_nextcube.p=
y} (100%)
>  rename tests/functional/{test_m68k_q800.py =3D> m68k/test_q800.py} (100%=
)
>  rename tests/functional/{test_m68k_replay.py =3D> m68k/test_replay.py} (=
100%)
>  rename tests/functional/{test_m68k_tuxrun.py =3D> m68k/test_tuxrun.py} (=
100%)
>  create mode 100644 tests/functional/microblaze/meson.build
>  rename tests/functional/{test_microblaze_replay.py =3D> microblaze/test_=
replay.py} (100%)
>  rename tests/functional/{test_microblaze_s3adsp1800.py =3D> microblaze/t=
est_s3adsp1800.py} (100%)
>  create mode 100644 tests/functional/microblazeel/meson.build
>  rename tests/functional/{test_microblazeel_s3adsp1800.py =3D> microblaze=
el/test_s3adsp1800.py} (92%)
>  create mode 100644 tests/functional/mips/meson.build
>  rename tests/functional/{test_mips_malta.py =3D> mips/test_malta.py} (10=
0%)
>  rename tests/functional/{test_mips_replay.py =3D> mips/test_replay.py} (=
100%)
>  rename tests/functional/{test_mips_tuxrun.py =3D> mips/test_tuxrun.py} (=
100%)
>  create mode 100644 tests/functional/mips64/meson.build
>  rename tests/functional/{test_mips64_malta.py =3D> mips64/test_malta.py}=
 (96%)
>  rename tests/functional/{test_mips64_tuxrun.py =3D> mips64/test_tuxrun.p=
y} (100%)
>  create mode 100644 tests/functional/mips64el/meson.build
>  rename tests/functional/{test_mips64el_fuloong2e.py =3D> mips64el/test_f=
uloong2e.py} (100%)
>  rename tests/functional/{test_mips64el_loongson3v.py =3D> mips64el/test_=
loongson3v.py} (100%)
>  rename tests/functional/{test_mips64el_malta.py =3D> mips64el/test_malta=
.py} (98%)
>  rename tests/functional/{test_mips64el_replay.py =3D> mips64el/test_repl=
ay.py} (100%)
>  rename tests/functional/{test_mips64el_tuxrun.py =3D> mips64el/test_tuxr=
un.py} (100%)
>  create mode 100644 tests/functional/mipsel/meson.build
>  rename tests/functional/{test_mipsel_malta.py =3D> mipsel/test_malta.py}=
 (98%)
>  rename tests/functional/{test_mipsel_replay.py =3D> mipsel/test_replay.p=
y} (100%)
>  rename tests/functional/{test_mipsel_tuxrun.py =3D> mipsel/test_tuxrun.p=
y} (100%)
>  create mode 100644 tests/functional/or1k/meson.build
>  rename tests/functional/{test_or1k_replay.py =3D> or1k/test_replay.py} (=
100%)
>  rename tests/functional/{test_or1k_sim.py =3D> or1k/test_sim.py} (100%)
>  create mode 100644 tests/functional/ppc/meson.build
>  rename tests/functional/{test_ppc_40p.py =3D> ppc/test_40p.py} (100%)
>  rename tests/functional/{test_ppc_74xx.py =3D> ppc/test_74xx.py} (100%)
>  rename tests/functional/{test_ppc_amiga.py =3D> ppc/test_amiga.py} (100%=
)
>  rename tests/functional/{test_ppc_bamboo.py =3D> ppc/test_bamboo.py} (10=
0%)
>  rename tests/functional/{test_ppc_mac.py =3D> ppc/test_mac.py} (100%)
>  create mode 120000 tests/functional/ppc/test_migration.py
>  rename tests/functional/{test_ppc_mpc8544ds.py =3D> ppc/test_mpc8544ds.p=
y} (100%)
>  rename tests/functional/{test_ppc_replay.py =3D> ppc/test_replay.py} (10=
0%)
>  rename tests/functional/{test_ppc_sam460ex.py =3D> ppc/test_sam460ex.py}=
 (100%)
>  rename tests/functional/{test_ppc_tuxrun.py =3D> ppc/test_tuxrun.py} (10=
0%)
>  rename tests/functional/{test_ppc_virtex_ml507.py =3D> ppc/test_virtex_m=
l507.py} (100%)
>  create mode 100644 tests/functional/ppc64/meson.build
>  rename tests/functional/{test_ppc64_e500.py =3D> ppc64/test_e500.py} (10=
0%)
>  rename tests/functional/{test_ppc64_hv.py =3D> ppc64/test_hv.py} (100%)
>  rename tests/functional/{test_ppc64_mac99.py =3D> ppc64/test_mac99.py} (=
100%)
>  create mode 120000 tests/functional/ppc64/test_migration.py
>  rename tests/functional/{test_ppc64_powernv.py =3D> ppc64/test_powernv.p=
y} (100%)
>  rename tests/functional/{test_ppc64_pseries.py =3D> ppc64/test_pseries.p=
y} (100%)
>  rename tests/functional/{test_ppc64_replay.py =3D> ppc64/test_replay.py}=
 (100%)
>  rename tests/functional/{test_ppc64_reverse_debug.py =3D> ppc64/test_rev=
erse_debug.py} (100%)
>  rename tests/functional/{test_ppc64_tuxrun.py =3D> ppc64/test_tuxrun.py}=
 (100%)
>  create mode 100644 tests/functional/riscv32/meson.build
>  create mode 120000 tests/functional/riscv32/test_migration.py
>  create mode 120000 tests/functional/riscv32/test_opensbi.py
>  rename tests/functional/{test_riscv32_tuxrun.py =3D> riscv32/test_tuxrun=
.py} (100%)
>  create mode 100644 tests/functional/riscv64/meson.build
>  rename tests/functional/{test_riscv_opensbi.py =3D> riscv64/test_opensbi=
.py} (100%)
>  rename tests/functional/{test_riscv64_tuxrun.py =3D> riscv64/test_tuxrun=
.py} (100%)
>  create mode 100644 tests/functional/rx/meson.build
>  rename tests/functional/{test_rx_gdbsim.py =3D> rx/test_gdbsim.py} (100%=
)
>  create mode 100644 tests/functional/s390x/meson.build
>  rename tests/functional/{test_s390x_ccw_virtio.py =3D> s390x/test_ccw_vi=
rtio.py} (100%)
>  rename tests/functional/{test_s390x_replay.py =3D> s390x/test_replay.py}=
 (100%)
>  rename tests/functional/{test_s390x_topology.py =3D> s390x/test_topology=
.py} (100%)
>  rename tests/functional/{test_s390x_tuxrun.py =3D> s390x/test_tuxrun.py}=
 (100%)
>  create mode 100644 tests/functional/sh4/meson.build
>  rename tests/functional/{test_sh4_r2d.py =3D> sh4/test_r2d.py} (100%)
>  rename tests/functional/{test_sh4_tuxrun.py =3D> sh4/test_tuxrun.py} (10=
0%)
>  create mode 100644 tests/functional/sh4eb/meson.build
>  rename tests/functional/{test_sh4eb_r2d.py =3D> sh4eb/test_r2d.py} (100%=
)
>  create mode 100644 tests/functional/sparc/meson.build
>  create mode 120000 tests/functional/sparc/test_migration.py
>  rename tests/functional/{test_sparc_replay.py =3D> sparc/test_replay.py}=
 (100%)
>  rename tests/functional/{test_sparc_sun4m.py =3D> sparc/test_sun4m.py} (=
100%)
>  create mode 100644 tests/functional/sparc64/meson.build
>  create mode 120000 tests/functional/sparc64/test_migration.py
>  rename tests/functional/{test_sparc64_sun4u.py =3D> sparc64/test_sun4u.p=
y} (100%)
>  rename tests/functional/{test_sparc64_tuxrun.py =3D> sparc64/test_tuxrun=
.py} (100%)
>  create mode 100644 tests/functional/x86_64/meson.build
>  rename tests/functional/{ =3D> x86_64}/test_acpi_bits.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_cpu_queries.py (100%)
>  rename tests/functional/{test_x86_64_hotplug_blk.py =3D> x86_64/test_hot=
plug_blk.py} (100%)
>  rename tests/functional/{test_x86_64_hotplug_cpu.py =3D> x86_64/test_hot=
plug_cpu.py} (100%)
>  rename tests/functional/{ =3D> x86_64}/test_intel_iommu.py (100%)
>  rename tests/functional/{test_x86_64_kvm_xen.py =3D> x86_64/test_kvm_xen=
.py} (100%)
>  rename tests/functional/{ =3D> x86_64}/test_linux_initrd.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_mem_addr_space.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_memlock.py (100%)
>  create mode 120000 tests/functional/x86_64/test_migration.py
>  rename tests/functional/{ =3D> x86_64}/test_multiprocess.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_netdev_ethtool.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_pc_cpu_hotplug_props.py (100=
%)
>  rename tests/functional/{test_x86_64_replay.py =3D> x86_64/test_replay.p=
y} (100%)
>  rename tests/functional/{test_x86_64_reverse_debug.py =3D> x86_64/test_r=
everse_debug.py} (100%)
>  rename tests/functional/{test_x86_64_tuxrun.py =3D> x86_64/test_tuxrun.p=
y} (100%)
>  rename tests/functional/{ =3D> x86_64}/test_virtio_balloon.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_virtio_gpu.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_virtio_version.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_vnc.py (100%)
>  rename tests/functional/{ =3D> x86_64}/test_x86_cpu_model_versions.py (1=
00%)
>  create mode 100644 tests/functional/xtensa/meson.build
>  rename tests/functional/{test_xtensa_lx60.py =3D> xtensa/test_lx60.py} (=
100%)
>  rename tests/functional/{test_xtensa_replay.py =3D> xtensa/test_replay.p=
y} (100%)
>
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarc=
h64/meson.build
> new file mode 100644
> index 00000000000..ebb16282692
> --- /dev/null
> +++ b/tests/functional/aarch64/meson.build
> @@ -0,0 +1,47 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_aarch64_timeouts =3D {
> +  'aspeed_ast2700' : 600,
> +  'aspeed_ast2700fc' : 600,
> +  'device_passthrough' : 720,
> +  'imx8mp_evk' : 240,
> +  'raspi4' : 480,
> +  'reverse_debug' : 180,
> +  'rme_virt' : 1200,
> +  'rme_sbsaref' : 1200,
> +  'sbsaref_alpine' : 1200,
> +  'sbsaref_freebsd' : 720,
> +  'smmu' : 720,
> +  'tuxrun' : 240,
> +  'virt' : 360,
> +  'virt_gpu' : 480,
> +}
> +
> +tests_aarch64_system_quick =3D [
> +  'migration',
> +]
> +
> +tests_aarch64_system_thorough =3D [
> +  'aspeed_ast2700',
> +  'aspeed_ast2700fc',
> +  'device_passthrough',
> +  'hotplug_pci',
> +  'imx8mp_evk',
> +  'raspi3',
> +  'raspi4',
> +  'replay',
> +  'reverse_debug',
> +  'rme_virt',
> +  'rme_sbsaref',
> +  'sbsaref',
> +  'sbsaref_alpine',
> +  'sbsaref_freebsd',
> +  'smmu',
> +  'tcg_plugins',
> +  'tuxrun',
> +  'virt',
> +  'virt_gpu',
> +  'xen',
> +  'xlnx_versal',
> +  'multiprocess',
> +]
> diff --git a/tests/functional/test_aarch64_aspeed_ast2700.py b/tests/func=
tional/aarch64/test_aspeed_ast2700.py
> similarity index 100%
> rename from tests/functional/test_aarch64_aspeed_ast2700.py
> rename to tests/functional/aarch64/test_aspeed_ast2700.py
> diff --git a/tests/functional/test_aarch64_aspeed_ast2700fc.py b/tests/fu=
nctional/aarch64/test_aspeed_ast2700fc.py
> similarity index 100%
> rename from tests/functional/test_aarch64_aspeed_ast2700fc.py
> rename to tests/functional/aarch64/test_aspeed_ast2700fc.py
> diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/=
functional/aarch64/test_device_passthrough.py
> similarity index 100%
> rename from tests/functional/test_aarch64_device_passthrough.py
> rename to tests/functional/aarch64/test_device_passthrough.py
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functio=
nal/aarch64/test_hotplug_pci.py
> similarity index 100%
> rename from tests/functional/test_aarch64_hotplug_pci.py
> rename to tests/functional/aarch64/test_hotplug_pci.py
> diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/function=
al/aarch64/test_imx8mp_evk.py
> similarity index 100%
> rename from tests/functional/test_aarch64_imx8mp_evk.py
> rename to tests/functional/aarch64/test_imx8mp_evk.py
> diff --git a/tests/functional/aarch64/test_migration.py b/tests/functiona=
l/aarch64/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/aarch64/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/aarch64/test_multiprocess.py b/tests/functi=
onal/aarch64/test_multiprocess.py
> new file mode 120000
> index 00000000000..ff4ff5314a7
> --- /dev/null
> +++ b/tests/functional/aarch64/test_multiprocess.py
> @@ -0,0 +1 @@
> +../x86_64/test_multiprocess.py
> \ No newline at end of file
> diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/a=
arch64/test_raspi3.py
> similarity index 100%
> rename from tests/functional/test_aarch64_raspi3.py
> rename to tests/functional/aarch64/test_raspi3.py
> diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/a=
arch64/test_raspi4.py
> similarity index 100%
> rename from tests/functional/test_aarch64_raspi4.py
> rename to tests/functional/aarch64/test_raspi4.py
> diff --git a/tests/functional/test_aarch64_replay.py b/tests/functional/a=
arch64/test_replay.py
> similarity index 100%
> rename from tests/functional/test_aarch64_replay.py
> rename to tests/functional/aarch64/test_replay.py
> diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/funct=
ional/aarch64/test_reverse_debug.py
> similarity index 100%
> rename from tests/functional/test_aarch64_reverse_debug.py
> rename to tests/functional/aarch64/test_reverse_debug.py
> diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functio=
nal/aarch64/test_rme_sbsaref.py
> similarity index 98%
> rename from tests/functional/test_aarch64_rme_sbsaref.py
> rename to tests/functional/aarch64/test_rme_sbsaref.py
> index 746770e776d..100f1c7738b 100755
> --- a/tests/functional/test_aarch64_rme_sbsaref.py
> +++ b/tests/functional/aarch64/test_rme_sbsaref.py
> @@ -13,7 +13,7 @@
>
>  from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
>  from qemu_test import exec_command_and_wait_for_pattern
> -from test_aarch64_rme_virt import test_realms_guest
> +from test_rme_virt import test_realms_guest
>
>
>  class Aarch64RMESbsaRefMachine(QemuSystemTest):
> diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional=
/aarch64/test_rme_virt.py
> similarity index 100%
> rename from tests/functional/test_aarch64_rme_virt.py
> rename to tests/functional/aarch64/test_rme_virt.py
> diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/=
aarch64/test_sbsaref.py
> similarity index 100%
> rename from tests/functional/test_aarch64_sbsaref.py
> rename to tests/functional/aarch64/test_sbsaref.py
> diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/func=
tional/aarch64/test_sbsaref_alpine.py
> similarity index 97%
> rename from tests/functional/test_aarch64_sbsaref_alpine.py
> rename to tests/functional/aarch64/test_sbsaref_alpine.py
> index 87769993831..abb8f5114bd 100755
> --- a/tests/functional/test_aarch64_sbsaref_alpine.py
> +++ b/tests/functional/aarch64/test_sbsaref_alpine.py
> @@ -12,7 +12,7 @@
>
>  from qemu_test import QemuSystemTest, Asset, skipSlowTest
>  from qemu_test import wait_for_console_pattern
> -from test_aarch64_sbsaref import fetch_firmware
> +from test_sbsaref import fetch_firmware
>
>
>  class Aarch64SbsarefAlpine(QemuSystemTest):
> diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/fun=
ctional/aarch64/test_sbsaref_freebsd.py
> similarity index 97%
> rename from tests/functional/test_aarch64_sbsaref_freebsd.py
> rename to tests/functional/aarch64/test_sbsaref_freebsd.py
> index 7ef016fba62..3b942f7795c 100755
> --- a/tests/functional/test_aarch64_sbsaref_freebsd.py
> +++ b/tests/functional/aarch64/test_sbsaref_freebsd.py
> @@ -12,7 +12,7 @@
>
>  from qemu_test import QemuSystemTest, Asset, skipSlowTest
>  from qemu_test import wait_for_console_pattern
> -from test_aarch64_sbsaref import fetch_firmware
> +from test_sbsaref import fetch_firmware
>
>
>  class Aarch64SbsarefFreeBSD(QemuSystemTest):
> diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/aar=
ch64/test_smmu.py
> similarity index 100%
> rename from tests/functional/test_aarch64_smmu.py
> rename to tests/functional/aarch64/test_smmu.py
> diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functio=
nal/aarch64/test_tcg_plugins.py
> similarity index 100%
> rename from tests/functional/test_aarch64_tcg_plugins.py
> rename to tests/functional/aarch64/test_tcg_plugins.py
> diff --git a/tests/functional/test_aarch64_tuxrun.py b/tests/functional/a=
arch64/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_aarch64_tuxrun.py
> rename to tests/functional/aarch64/test_tuxrun.py
> diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/aar=
ch64/test_virt.py
> similarity index 100%
> rename from tests/functional/test_aarch64_virt.py
> rename to tests/functional/aarch64/test_virt.py
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional=
/aarch64/test_virt_gpu.py
> similarity index 100%
> rename from tests/functional/test_aarch64_virt_gpu.py
> rename to tests/functional/aarch64/test_virt_gpu.py
> diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/aarc=
h64/test_xen.py
> similarity index 100%
> rename from tests/functional/test_aarch64_xen.py
> rename to tests/functional/aarch64/test_xen.py
> diff --git a/tests/functional/test_aarch64_xlnx_versal.py b/tests/functio=
nal/aarch64/test_xlnx_versal.py
> similarity index 100%
> rename from tests/functional/test_aarch64_xlnx_versal.py
> rename to tests/functional/aarch64/test_xlnx_versal.py
> diff --git a/tests/functional/alpha/meson.build b/tests/functional/alpha/=
meson.build
> new file mode 100644
> index 00000000000..a69ac82dd2c
> --- /dev/null
> +++ b/tests/functional/alpha/meson.build
> @@ -0,0 +1,9 @@
> +
> +tests_alpha_system_quick =3D [
> +  'migration',
> +]
> +
> +tests_alpha_system_thorough =3D [
> +  'clipper',
> +  'replay',
> +]
> diff --git a/tests/functional/test_alpha_clipper.py b/tests/functional/al=
pha/test_clipper.py
> similarity index 100%
> rename from tests/functional/test_alpha_clipper.py
> rename to tests/functional/alpha/test_clipper.py
> diff --git a/tests/functional/alpha/test_migration.py b/tests/functional/=
alpha/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/alpha/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/test_alpha_replay.py b/tests/functional/alp=
ha/test_replay.py
> similarity index 100%
> rename from tests/functional/test_alpha_replay.py
> rename to tests/functional/alpha/test_replay.py
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meso=
n.build
> new file mode 100644
> index 00000000000..59acfb10f1e
> --- /dev/null
> +++ b/tests/functional/arm/meson.build
> @@ -0,0 +1,61 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_arm_timeouts =3D {
> +  'aspeed_palmetto' : 120,
> +  'aspeed_romulus' : 120,
> +  'aspeed_witherspoon' : 120,
> +  'aspeed_ast2500' : 720,
> +  'aspeed_ast2600' : 1200,
> +  'aspeed_bletchley' : 480,
> +  'aspeed_catalina' : 480,
> +  'aspeed_gb200nvl_bmc' : 480,
> +  'aspeed_rainier' : 480,
> +  'bpim2u' : 500,
> +  'collie' : 180,
> +  'cubieboard' : 360,
> +  'orangepi' : 540,
> +  'quanta_gsj' : 240,
> +  'raspi2' : 120,
> +  'replay' : 240,
> +  'tuxrun' : 240,
> +  'sx1' : 360,
> +}
> +
> +tests_arm_system_quick =3D [
> +  'migration',
> +]
> +
> +tests_arm_system_thorough =3D [
> +  'aspeed_ast1030',
> +  'aspeed_palmetto',
> +  'aspeed_romulus',
> +  'aspeed_witherspoon',
> +  'aspeed_ast2500',
> +  'aspeed_ast2600',
> +  'aspeed_bletchley',
> +  'aspeed_catalina',
> +  'aspeed_gb200nvl_bmc',
> +  'aspeed_rainier',
> +  'bpim2u',
> +  'canona1100',
> +  'collie',
> +  'cubieboard',
> +  'emcraft_sf2',
> +  'integratorcp',
> +  'microbit',
> +  'orangepi',
> +  'quanta_gsj',
> +  'raspi2',
> +  'realview',
> +  'replay',
> +  'smdkc210',
> +  'stellaris',
> +  'sx1',
> +  'vexpress',
> +  'virt',
> +  'tuxrun',
> +]
> +
> +tests_arm_linuxuser_thorough =3D [
> +  'bflt',
> +]
> diff --git a/tests/functional/test_arm_aspeed_ast1030.py b/tests/function=
al/arm/test_aspeed_ast1030.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_ast1030.py
> rename to tests/functional/arm/test_aspeed_ast1030.py
> diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/function=
al/arm/test_aspeed_ast2500.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_ast2500.py
> rename to tests/functional/arm/test_aspeed_ast2500.py
> diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/function=
al/arm/test_aspeed_ast2600.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_ast2600.py
> rename to tests/functional/arm/test_aspeed_ast2600.py
> diff --git a/tests/functional/test_arm_aspeed_bletchley.py b/tests/functi=
onal/arm/test_aspeed_bletchley.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_bletchley.py
> rename to tests/functional/arm/test_aspeed_bletchley.py
> diff --git a/tests/functional/test_arm_aspeed_catalina.py b/tests/functio=
nal/arm/test_aspeed_catalina.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_catalina.py
> rename to tests/functional/arm/test_aspeed_catalina.py
> diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/fun=
ctional/arm/test_aspeed_gb200nvl_bmc.py
> old mode 100644
> new mode 100755
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_gb200nvl_bmc.py
> rename to tests/functional/arm/test_aspeed_gb200nvl_bmc.py
> diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functio=
nal/arm/test_aspeed_palmetto.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_palmetto.py
> rename to tests/functional/arm/test_aspeed_palmetto.py
> diff --git a/tests/functional/test_arm_aspeed_rainier.py b/tests/function=
al/arm/test_aspeed_rainier.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_rainier.py
> rename to tests/functional/arm/test_aspeed_rainier.py
> diff --git a/tests/functional/test_arm_aspeed_romulus.py b/tests/function=
al/arm/test_aspeed_romulus.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_romulus.py
> rename to tests/functional/arm/test_aspeed_romulus.py
> diff --git a/tests/functional/test_arm_aspeed_witherspoon.py b/tests/func=
tional/arm/test_aspeed_witherspoon.py
> similarity index 100%
> rename from tests/functional/test_arm_aspeed_witherspoon.py
> rename to tests/functional/arm/test_aspeed_witherspoon.py
> diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/arm/tes=
t_bflt.py
> similarity index 100%
> rename from tests/functional/test_arm_bflt.py
> rename to tests/functional/arm/test_bflt.py
> diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/arm/t=
est_bpim2u.py
> similarity index 100%
> rename from tests/functional/test_arm_bpim2u.py
> rename to tests/functional/arm/test_bpim2u.py
> diff --git a/tests/functional/test_arm_canona1100.py b/tests/functional/a=
rm/test_canona1100.py
> similarity index 100%
> rename from tests/functional/test_arm_canona1100.py
> rename to tests/functional/arm/test_canona1100.py
> diff --git a/tests/functional/test_arm_collie.py b/tests/functional/arm/t=
est_collie.py
> similarity index 100%
> rename from tests/functional/test_arm_collie.py
> rename to tests/functional/arm/test_collie.py
> diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/a=
rm/test_cubieboard.py
> similarity index 100%
> rename from tests/functional/test_arm_cubieboard.py
> rename to tests/functional/arm/test_cubieboard.py
> diff --git a/tests/functional/test_arm_emcraft_sf2.py b/tests/functional/=
arm/test_emcraft_sf2.py
> similarity index 100%
> rename from tests/functional/test_arm_emcraft_sf2.py
> rename to tests/functional/arm/test_emcraft_sf2.py
> diff --git a/tests/functional/test_arm_integratorcp.py b/tests/functional=
/arm/test_integratorcp.py
> similarity index 100%
> rename from tests/functional/test_arm_integratorcp.py
> rename to tests/functional/arm/test_integratorcp.py
> diff --git a/tests/functional/test_arm_microbit.py b/tests/functional/arm=
/test_microbit.py
> similarity index 100%
> rename from tests/functional/test_arm_microbit.py
> rename to tests/functional/arm/test_microbit.py
> diff --git a/tests/functional/arm/test_migration.py b/tests/functional/ar=
m/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/arm/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/arm=
/test_orangepi.py
> similarity index 100%
> rename from tests/functional/test_arm_orangepi.py
> rename to tests/functional/arm/test_orangepi.py
> diff --git a/tests/functional/test_arm_quanta_gsj.py b/tests/functional/a=
rm/test_quanta_gsj.py
> similarity index 100%
> rename from tests/functional/test_arm_quanta_gsj.py
> rename to tests/functional/arm/test_quanta_gsj.py
> diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/arm/t=
est_raspi2.py
> similarity index 100%
> rename from tests/functional/test_arm_raspi2.py
> rename to tests/functional/arm/test_raspi2.py
> diff --git a/tests/functional/test_arm_realview.py b/tests/functional/arm=
/test_realview.py
> similarity index 100%
> rename from tests/functional/test_arm_realview.py
> rename to tests/functional/arm/test_realview.py
> diff --git a/tests/functional/test_arm_replay.py b/tests/functional/arm/t=
est_replay.py
> similarity index 100%
> rename from tests/functional/test_arm_replay.py
> rename to tests/functional/arm/test_replay.py
> diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/arm=
/test_smdkc210.py
> similarity index 100%
> rename from tests/functional/test_arm_smdkc210.py
> rename to tests/functional/arm/test_smdkc210.py
> diff --git a/tests/functional/test_arm_stellaris.py b/tests/functional/ar=
m/test_stellaris.py
> similarity index 100%
> rename from tests/functional/test_arm_stellaris.py
> rename to tests/functional/arm/test_stellaris.py
> diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/arm/test=
_sx1.py
> similarity index 100%
> rename from tests/functional/test_arm_sx1.py
> rename to tests/functional/arm/test_sx1.py
> diff --git a/tests/functional/test_arm_tuxrun.py b/tests/functional/arm/t=
est_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_arm_tuxrun.py
> rename to tests/functional/arm/test_tuxrun.py
> diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/arm=
/test_vexpress.py
> similarity index 100%
> rename from tests/functional/test_arm_vexpress.py
> rename to tests/functional/arm/test_vexpress.py
> diff --git a/tests/functional/test_arm_virt.py b/tests/functional/arm/tes=
t_virt.py
> similarity index 100%
> rename from tests/functional/test_arm_virt.py
> rename to tests/functional/arm/test_virt.py
> diff --git a/tests/functional/avr/meson.build b/tests/functional/avr/meso=
n.build
> new file mode 100644
> index 00000000000..b311ee89dc8
> --- /dev/null
> +++ b/tests/functional/avr/meson.build
> @@ -0,0 +1,5 @@
> +
> +tests_avr_system_thorough =3D [
> +  'mega2560',
> +  'uno',
> +]
> diff --git a/tests/functional/test_avr_mega2560.py b/tests/functional/avr=
/test_mega2560.py
> similarity index 100%
> rename from tests/functional/test_avr_mega2560.py
> rename to tests/functional/avr/test_mega2560.py
> diff --git a/tests/functional/test_avr_uno.py b/tests/functional/avr/test=
_uno.py
> similarity index 100%
> rename from tests/functional/test_avr_uno.py
> rename to tests/functional/avr/test_uno.py
> diff --git a/tests/functional/test_empty_cpu_model.py b/tests/functional/=
generic/test_empty_cpu_model.py
> similarity index 100%
> rename from tests/functional/test_empty_cpu_model.py
> rename to tests/functional/generic/test_empty_cpu_model.py
> diff --git a/tests/functional/test_info_usernet.py b/tests/functional/gen=
eric/test_info_usernet.py
> similarity index 100%
> rename from tests/functional/test_info_usernet.py
> rename to tests/functional/generic/test_info_usernet.py
> diff --git a/tests/functional/test_migration.py b/tests/functional/generi=
c/test_migration.py
> similarity index 100%
> rename from tests/functional/test_migration.py
> rename to tests/functional/generic/test_migration.py
> diff --git a/tests/functional/test_version.py b/tests/functional/generic/=
test_version.py
> similarity index 100%
> rename from tests/functional/test_version.py
> rename to tests/functional/generic/test_version.py
> diff --git a/tests/functional/hppa/meson.build b/tests/functional/hppa/me=
son.build
> new file mode 100644
> index 00000000000..046241562cb
> --- /dev/null
> +++ b/tests/functional/hppa/meson.build
> @@ -0,0 +1,4 @@
> +
> +tests_hppa_system_quick =3D [
> +  'seabios',
> +]
> diff --git a/tests/functional/test_hppa_seabios.py b/tests/functional/hpp=
a/test_seabios.py
> similarity index 100%
> rename from tests/functional/test_hppa_seabios.py
> rename to tests/functional/hppa/test_seabios.py
> diff --git a/tests/functional/i386/meson.build b/tests/functional/i386/me=
son.build
> new file mode 100644
> index 00000000000..90bed3cbc35
> --- /dev/null
> +++ b/tests/functional/i386/meson.build
> @@ -0,0 +1,9 @@
> +
> +tests_i386_system_quick =3D [
> +  'migration',
> +]
> +
> +tests_i386_system_thorough =3D [
> +  'replay',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/i386/test_migration.py b/tests/functional/i=
386/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/i386/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/test_i386_replay.py b/tests/functional/i386=
/test_replay.py
> similarity index 100%
> rename from tests/functional/test_i386_replay.py
> rename to tests/functional/i386/test_replay.py
> diff --git a/tests/functional/test_i386_tuxrun.py b/tests/functional/i386=
/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_i386_tuxrun.py
> rename to tests/functional/i386/test_tuxrun.py
> diff --git a/tests/functional/loongarch64/meson.build b/tests/functional/=
loongarch64/meson.build
> new file mode 100644
> index 00000000000..90f2e4056f4
> --- /dev/null
> +++ b/tests/functional/loongarch64/meson.build
> @@ -0,0 +1,4 @@
> +
> +tests_loongarch64_system_thorough =3D [
> +  'virt',
> +]
> diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional=
/loongarch64/test_virt.py
> similarity index 100%
> rename from tests/functional/test_loongarch64_virt.py
> rename to tests/functional/loongarch64/test_virt.py
> diff --git a/tests/functional/m68k/meson.build b/tests/functional/m68k/me=
son.build
> new file mode 100644
> index 00000000000..c499fecb3cf
> --- /dev/null
> +++ b/tests/functional/m68k/meson.build
> @@ -0,0 +1,8 @@
> +
> +tests_m68k_system_thorough =3D [
> +  'mcf5208evb',
> +  'nextcube',
> +  'replay',
> +  'q800',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/=
m68k/test_mcf5208evb.py
> similarity index 100%
> rename from tests/functional/test_m68k_mcf5208evb.py
> rename to tests/functional/m68k/test_mcf5208evb.py
> diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/m6=
8k/test_nextcube.py
> similarity index 100%
> rename from tests/functional/test_m68k_nextcube.py
> rename to tests/functional/m68k/test_nextcube.py
> diff --git a/tests/functional/test_m68k_q800.py b/tests/functional/m68k/t=
est_q800.py
> similarity index 100%
> rename from tests/functional/test_m68k_q800.py
> rename to tests/functional/m68k/test_q800.py
> diff --git a/tests/functional/test_m68k_replay.py b/tests/functional/m68k=
/test_replay.py
> similarity index 100%
> rename from tests/functional/test_m68k_replay.py
> rename to tests/functional/m68k/test_replay.py
> diff --git a/tests/functional/test_m68k_tuxrun.py b/tests/functional/m68k=
/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_m68k_tuxrun.py
> rename to tests/functional/m68k/test_tuxrun.py
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 050c9000b95..c7ee4b1f172 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -9,63 +9,33 @@ if get_option('tcg_interpreter')
>    subdir_done()
>  endif
>
> -# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> -test_timeouts =3D {
> -  'aarch64_aspeed_ast2700' : 600,
> -  'aarch64_aspeed_ast2700fc' : 600,
> -  'aarch64_device_passthrough' : 720,
> -  'aarch64_imx8mp_evk' : 240,
> -  'aarch64_raspi4' : 480,
> -  'aarch64_reverse_debug' : 180,
> -  'aarch64_rme_virt' : 1200,
> -  'aarch64_rme_sbsaref' : 1200,
> -  'aarch64_sbsaref_alpine' : 1200,
> -  'aarch64_sbsaref_freebsd' : 720,
> -  'aarch64_smmu' : 720,
> -  'aarch64_tuxrun' : 240,
> -  'aarch64_virt' : 360,
> -  'aarch64_virt_gpu' : 480,
> -  'acpi_bits' : 420,
> -  'arm_aspeed_palmetto' : 120,
> -  'arm_aspeed_romulus' : 120,
> -  'arm_aspeed_witherspoon' : 120,
> -  'arm_aspeed_ast2500' : 720,
> -  'arm_aspeed_ast2600' : 1200,
> -  'arm_aspeed_bletchley' : 480,
> -  'arm_aspeed_catalina' : 480,
> -  'arm_aspeed_gb200nvl_bmc' : 480,
> -  'arm_aspeed_rainier' : 480,
> -  'arm_bpim2u' : 500,
> -  'arm_collie' : 180,
> -  'arm_cubieboard' : 360,
> -  'arm_orangepi' : 540,
> -  'arm_quanta_gsj' : 240,
> -  'arm_raspi2' : 120,
> -  'arm_replay' : 240,
> -  'arm_tuxrun' : 240,
> -  'arm_sx1' : 360,
> -  'intel_iommu': 300,
> -  'mips_malta' : 480,
> -  'mipsel_malta' : 420,
> -  'mipsel_replay' : 480,
> -  'mips64_malta' : 240,
> -  'mips64el_malta' : 420,
> -  'mips64el_replay' : 180,
> -  'netdev_ethtool' : 180,
> -  'ppc_40p' : 240,
> -  'ppc64_hv' : 1000,
> -  'ppc64_powernv' : 480,
> -  'ppc64_pseries' : 480,
> -  'ppc64_replay' : 210,
> -  'ppc64_tuxrun' : 420,
> -  'ppc64_mac99' : 120,
> -  'riscv64_tuxrun' : 120,
> -  's390x_ccw_virtio' : 420,
> -  'sh4_tuxrun' : 240,
> -  'virtio_balloon': 120,
> -  'x86_64_kvm_xen' : 180,
> -  'x86_64_replay' : 480,
> -}
> +subdir('aarch64')
> +subdir('alpha')
> +subdir('arm')
> +subdir('avr')
> +subdir('hppa')
> +subdir('i386')
> +subdir('loongarch64')
> +subdir('m68k')
> +subdir('microblaze')
> +subdir('microblazeel')
> +subdir('mips')
> +subdir('mips64')
> +subdir('mips64el')
> +subdir('mipsel')
> +subdir('or1k')
> +subdir('ppc')
> +subdir('ppc64')
> +subdir('riscv32')
> +subdir('riscv64')
> +subdir('rx')
> +subdir('s390x')
> +subdir('sh4')
> +subdir('sh4eb')
> +subdir('sparc')
> +subdir('sparc64')
> +subdir('x86_64')
> +subdir('xtensa')
>
>  tests_generic_system =3D [
>    'empty_cpu_model',
> @@ -79,271 +49,6 @@ tests_generic_linuxuser =3D [
>  tests_generic_bsduser =3D [
>  ]
>
> -tests_aarch64_system_quick =3D [
> -  'migration',
> -]
> -
> -tests_aarch64_system_thorough =3D [
> -  'aarch64_aspeed_ast2700',
> -  'aarch64_aspeed_ast2700fc',
> -  'aarch64_device_passthrough',
> -  'aarch64_hotplug_pci',
> -  'aarch64_imx8mp_evk',
> -  'aarch64_raspi3',
> -  'aarch64_raspi4',
> -  'aarch64_replay',
> -  'aarch64_reverse_debug',
> -  'aarch64_rme_virt',
> -  'aarch64_rme_sbsaref',
> -  'aarch64_sbsaref',
> -  'aarch64_sbsaref_alpine',
> -  'aarch64_sbsaref_freebsd',
> -  'aarch64_smmu',
> -  'aarch64_tcg_plugins',
> -  'aarch64_tuxrun',
> -  'aarch64_virt',
> -  'aarch64_virt_gpu',
> -  'aarch64_xen',
> -  'aarch64_xlnx_versal',
> -  'multiprocess',
> -]
> -
> -tests_alpha_system_quick =3D [
> -  'migration',
> -]
> -
> -tests_alpha_system_thorough =3D [
> -  'alpha_clipper',
> -  'alpha_replay',
> -]
> -
> -tests_arm_system_quick =3D [
> -  'migration',
> -]
> -
> -tests_arm_system_thorough =3D [
> -  'arm_aspeed_ast1030',
> -  'arm_aspeed_palmetto',
> -  'arm_aspeed_romulus',
> -  'arm_aspeed_witherspoon',
> -  'arm_aspeed_ast2500',
> -  'arm_aspeed_ast2600',
> -  'arm_aspeed_bletchley',
> -  'arm_aspeed_catalina',
> -  'arm_aspeed_gb200nvl_bmc',
> -  'arm_aspeed_rainier',
> -  'arm_bpim2u',
> -  'arm_canona1100',
> -  'arm_collie',
> -  'arm_cubieboard',
> -  'arm_emcraft_sf2',
> -  'arm_integratorcp',
> -  'arm_microbit',
> -  'arm_orangepi',
> -  'arm_quanta_gsj',
> -  'arm_raspi2',
> -  'arm_realview',
> -  'arm_replay',
> -  'arm_smdkc210',
> -  'arm_stellaris',
> -  'arm_sx1',
> -  'arm_vexpress',
> -  'arm_virt',
> -  'arm_tuxrun',
> -]
> -
> -tests_arm_linuxuser_thorough =3D [
> -  'arm_bflt',
> -]
> -
> -tests_avr_system_thorough =3D [
> -  'avr_mega2560',
> -  'avr_uno',
> -]
> -
> -tests_hppa_system_quick =3D [
> -  'hppa_seabios',
> -]
> -
> -tests_i386_system_quick =3D [
> -  'migration',
> -]
> -
> -tests_i386_system_thorough =3D [
> -  'i386_replay',
> -  'i386_tuxrun',
> -]
> -
> -tests_loongarch64_system_thorough =3D [
> -  'loongarch64_virt',
> -]
> -
> -tests_m68k_system_thorough =3D [
> -  'm68k_mcf5208evb',
> -  'm68k_nextcube',
> -  'm68k_replay',
> -  'm68k_q800',
> -  'm68k_tuxrun',
> -]
> -
> -tests_microblaze_system_thorough =3D [
> -  'microblaze_replay',
> -  'microblaze_s3adsp1800'
> -]
> -
> -tests_microblazeel_system_thorough =3D [
> -  'microblazeel_s3adsp1800'
> -]
> -
> -tests_mips_system_thorough =3D [
> -  'mips_malta',
> -  'mips_replay',
> -  'mips_tuxrun',
> -]
> -
> -tests_mipsel_system_thorough =3D [
> -  'mipsel_malta',
> -  'mipsel_replay',
> -  'mipsel_tuxrun',
> -]
> -
> -tests_mips64_system_thorough =3D [
> -  'mips64_malta',
> -  'mips64_tuxrun',
> -]
> -
> -tests_mips64el_system_thorough =3D [
> -  'mips64el_fuloong2e',
> -  'mips64el_loongson3v',
> -  'mips64el_malta',
> -  'mips64el_replay',
> -  'mips64el_tuxrun',
> -]
> -
> -tests_or1k_system_thorough =3D [
> -  'or1k_replay',
> -  'or1k_sim',
> -]
> -
> -tests_ppc_system_quick =3D [
> -  'migration',
> -  'ppc_74xx',
> -]
> -
> -tests_ppc_system_thorough =3D [
> -  'ppc_40p',
> -  'ppc_amiga',
> -  'ppc_bamboo',
> -  'ppc_mac',
> -  'ppc_mpc8544ds',
> -  'ppc_replay',
> -  'ppc_sam460ex',
> -  'ppc_tuxrun',
> -  'ppc_virtex_ml507',
> -]
> -
> -tests_ppc64_system_quick =3D [
> -  'migration',
> -]
> -
> -tests_ppc64_system_thorough =3D [
> -  'ppc64_e500',
> -  'ppc64_hv',
> -  'ppc64_powernv',
> -  'ppc64_pseries',
> -  'ppc64_replay',
> -  'ppc64_reverse_debug',
> -  'ppc64_tuxrun',
> -  'ppc64_mac99',
> -]
> -
> -tests_riscv32_system_quick =3D [
> -  'migration',
> -  'riscv_opensbi',
> -]
> -
> -tests_riscv32_system_thorough =3D [
> -  'riscv32_tuxrun',
> -]
> -
> -tests_riscv64_system_quick =3D [
> -  'migration',
> -  'riscv_opensbi',
> -]
> -
> -tests_riscv64_system_thorough =3D [
> -  'riscv64_tuxrun',
> -]
> -
> -tests_rx_system_thorough =3D [
> -  'rx_gdbsim',
> -]
> -
> -tests_s390x_system_thorough =3D [
> -  's390x_ccw_virtio',
> -  's390x_replay',
> -  's390x_topology',
> -  's390x_tuxrun',
> -]
> -
> -tests_sh4_system_thorough =3D [
> -  'sh4_r2d',
> -  'sh4_tuxrun',
> -]
> -
> -tests_sh4eb_system_thorough =3D [
> -  'sh4eb_r2d',
> -]
> -
> -tests_sparc_system_quick =3D [
> -  'migration',
> -]
> -
> -tests_sparc_system_thorough =3D [
> -  'sparc_replay',
> -  'sparc_sun4m',
> -]
> -
> -tests_sparc64_system_quick =3D [
> -  'migration',
> -]
> -
> -tests_sparc64_system_thorough =3D [
> -  'sparc64_sun4u',
> -  'sparc64_tuxrun',
> -]
> -
> -tests_x86_64_system_quick =3D [
> -  'cpu_queries',
> -  'mem_addr_space',
> -  'migration',
> -  'pc_cpu_hotplug_props',
> -  'virtio_version',
> -  'x86_cpu_model_versions',
> -  'vnc',
> -  'memlock',
> -]
> -
> -tests_x86_64_system_thorough =3D [
> -  'acpi_bits',
> -  'intel_iommu',
> -  'linux_initrd',
> -  'multiprocess',
> -  'netdev_ethtool',
> -  'virtio_balloon',
> -  'virtio_gpu',
> -  'x86_64_hotplug_blk',
> -  'x86_64_hotplug_cpu',
> -  'x86_64_kvm_xen',
> -  'x86_64_replay',
> -  'x86_64_reverse_debug',
> -  'x86_64_tuxrun',
> -]
> -
> -tests_xtensa_system_thorough =3D [
> -  'xtensa_lx60',
> -  'xtensa_replay',
> -]
>
>  precache_all =3D []
>  foreach speed : ['quick', 'thorough']
> @@ -386,7 +91,11 @@ foreach speed : ['quick', 'thorough']
>
>      foreach test : target_tests
>        testname =3D '@0@-@1@'.format(target_base, test)
> -      testfile =3D 'test_' + test + '.py'
> +      if fs.exists('generic' / 'test_' + test + '.py')
> +        testfile =3D 'generic' / 'test_' + test + '.py'
> +      else
> +        testfile =3D target_base / 'test_' + test + '.py'
> +      endif
>        testpath =3D meson.current_source_dir() / testfile
>        teststamp =3D testname + '.tstamp'
>        test_precache_env =3D environment()
> @@ -400,6 +109,11 @@ foreach speed : ['quick', 'thorough']
>                                 build_by_default: false,
>                                 env: test_precache_env)
>        precache_all +=3D precache
> +      if is_variable('test_' + target_base + '_timeouts')
> +        time_out =3D get_variable('test_' + target_base + '_timeouts').g=
et(test, 90)
> +      else
> +        time_out =3D 90
> +      endif
>
>        # Ideally we would add 'precache' to 'depends' here, such that
>        # 'build_by_default: false' lets the pre-caching automatically
> @@ -415,8 +129,8 @@ foreach speed : ['quick', 'thorough']
>             env: test_env,
>             args: [testpath],
>             protocol: 'tap',
> -           timeout: test_timeouts.get(test, 90),
> -           priority: test_timeouts.get(test, 90),
> +           timeout:  time_out,
> +           priority: time_out,
>             suite: suites)
>      endforeach
>    endforeach
> diff --git a/tests/functional/microblaze/meson.build b/tests/functional/m=
icroblaze/meson.build
> new file mode 100644
> index 00000000000..a067393acdc
> --- /dev/null
> +++ b/tests/functional/microblaze/meson.build
> @@ -0,0 +1,5 @@
> +
> +tests_microblaze_system_thorough =3D [
> +  'replay',
> +  's3adsp1800'
> +]
> diff --git a/tests/functional/test_microblaze_replay.py b/tests/functiona=
l/microblaze/test_replay.py
> similarity index 100%
> rename from tests/functional/test_microblaze_replay.py
> rename to tests/functional/microblaze/test_replay.py
> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/funct=
ional/microblaze/test_s3adsp1800.py
> similarity index 100%
> rename from tests/functional/test_microblaze_s3adsp1800.py
> rename to tests/functional/microblaze/test_s3adsp1800.py
> diff --git a/tests/functional/microblazeel/meson.build b/tests/functional=
/microblazeel/meson.build
> new file mode 100644
> index 00000000000..69e3f58dd81
> --- /dev/null
> +++ b/tests/functional/microblazeel/meson.build
> @@ -0,0 +1,4 @@
> +
> +tests_microblazeel_system_thorough =3D [
> +  's3adsp1800'
> +]
> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/fun=
ctional/microblazeel/test_s3adsp1800.py
> similarity index 92%
> rename from tests/functional/test_microblazeel_s3adsp1800.py
> rename to tests/functional/microblazeel/test_s3adsp1800.py
> index 915902d48bd..75ce8856ed1 100755
> --- a/tests/functional/test_microblazeel_s3adsp1800.py
> +++ b/tests/functional/microblazeel/test_s3adsp1800.py
> @@ -7,7 +7,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later. See the COPYING file in the top-level directory.
>
> -from test_microblaze_s3adsp1800 import MicroblazeMachine
> +from microblaze.test_s3adsp1800 import MicroblazeMachine
>
>
>  class MicroblazeLittleEndianMachine(MicroblazeMachine):
> diff --git a/tests/functional/mips/meson.build b/tests/functional/mips/me=
son.build
> new file mode 100644
> index 00000000000..3c09f461770
> --- /dev/null
> +++ b/tests/functional/mips/meson.build
> @@ -0,0 +1,11 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_mips_timeouts =3D {
> +  'malta' : 480,
> +}
> +
> +tests_mips_system_thorough =3D [
> +  'malta',
> +  'replay',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_mips_malta.py b/tests/functional/mips/=
test_malta.py
> similarity index 100%
> rename from tests/functional/test_mips_malta.py
> rename to tests/functional/mips/test_malta.py
> diff --git a/tests/functional/test_mips_replay.py b/tests/functional/mips=
/test_replay.py
> similarity index 100%
> rename from tests/functional/test_mips_replay.py
> rename to tests/functional/mips/test_replay.py
> diff --git a/tests/functional/test_mips_tuxrun.py b/tests/functional/mips=
/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_mips_tuxrun.py
> rename to tests/functional/mips/test_tuxrun.py
> diff --git a/tests/functional/mips64/meson.build b/tests/functional/mips6=
4/meson.build
> new file mode 100644
> index 00000000000..65166fc1a45
> --- /dev/null
> +++ b/tests/functional/mips64/meson.build
> @@ -0,0 +1,10 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_mips64_timeouts =3D {
> +  'malta' : 240,
> +}
> +
> +tests_mips64_system_thorough =3D [
> +  'malta',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_mips64_malta.py b/tests/functional/mip=
s64/test_malta.py
> similarity index 96%
> rename from tests/functional/test_mips64_malta.py
> rename to tests/functional/mips64/test_malta.py
> index 53c3e0c1221..a553d3c5bc7 100755
> --- a/tests/functional/test_mips64_malta.py
> +++ b/tests/functional/mips64/test_malta.py
> @@ -5,7 +5,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>
>  from qemu_test import LinuxKernelTest, Asset
> -from test_mips_malta import mips_check_wheezy
> +from mips.test_malta import mips_check_wheezy
>
>
>  class MaltaMachineConsole(LinuxKernelTest):
> diff --git a/tests/functional/test_mips64_tuxrun.py b/tests/functional/mi=
ps64/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_mips64_tuxrun.py
> rename to tests/functional/mips64/test_tuxrun.py
> diff --git a/tests/functional/mips64el/meson.build b/tests/functional/mip=
s64el/meson.build
> new file mode 100644
> index 00000000000..096b12dc607
> --- /dev/null
> +++ b/tests/functional/mips64el/meson.build
> @@ -0,0 +1,14 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_mips64el_timeouts =3D {
> +  'malta' : 420,
> +  'replay' : 180,
> +}
> +
> +tests_mips64el_system_thorough =3D [
> +  'fuloong2e',
> +  'loongson3v',
> +  'malta',
> +  'replay',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_mips64el_fuloong2e.py b/tests/function=
al/mips64el/test_fuloong2e.py
> similarity index 100%
> rename from tests/functional/test_mips64el_fuloong2e.py
> rename to tests/functional/mips64el/test_fuloong2e.py
> diff --git a/tests/functional/test_mips64el_loongson3v.py b/tests/functio=
nal/mips64el/test_loongson3v.py
> similarity index 100%
> rename from tests/functional/test_mips64el_loongson3v.py
> rename to tests/functional/mips64el/test_loongson3v.py
> diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/m=
ips64el/test_malta.py
> similarity index 98%
> rename from tests/functional/test_mips64el_malta.py
> rename to tests/functional/mips64el/test_malta.py
> index 3cc79b74c18..8fdc49b3005 100755
> --- a/tests/functional/test_mips64el_malta.py
> +++ b/tests/functional/mips64el/test_malta.py
> @@ -16,7 +16,7 @@
>  from qemu_test import exec_command_and_wait_for_pattern
>  from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrusted=
Test
>
> -from test_mips_malta import mips_check_wheezy
> +from mips.test_malta import mips_check_wheezy
>
>
>  class MaltaMachineConsole(LinuxKernelTest):
> @@ -191,7 +191,7 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(sel=
f):
>          self.do_test_i6400_framebuffer_logo(8)
>
>
> -from test_mipsel_malta import MaltaMachineYAMON
> +from mipsel.test_malta import MaltaMachineYAMON
>
>  if __name__ =3D=3D '__main__':
>      LinuxKernelTest.main()
> diff --git a/tests/functional/test_mips64el_replay.py b/tests/functional/=
mips64el/test_replay.py
> similarity index 100%
> rename from tests/functional/test_mips64el_replay.py
> rename to tests/functional/mips64el/test_replay.py
> diff --git a/tests/functional/test_mips64el_tuxrun.py b/tests/functional/=
mips64el/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_mips64el_tuxrun.py
> rename to tests/functional/mips64el/test_tuxrun.py
> diff --git a/tests/functional/mipsel/meson.build b/tests/functional/mipse=
l/meson.build
> new file mode 100644
> index 00000000000..f719f03e1a3
> --- /dev/null
> +++ b/tests/functional/mipsel/meson.build
> @@ -0,0 +1,12 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_mipsel_timeouts =3D {
> +  'malta' : 420,
> +  'replay' : 480,
> +}
> +
> +tests_mipsel_system_thorough =3D [
> +  'malta',
> +  'replay',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/mip=
sel/test_malta.py
> similarity index 98%
> rename from tests/functional/test_mipsel_malta.py
> rename to tests/functional/mipsel/test_malta.py
> index 9ee2884da8e..427e163d19d 100755
> --- a/tests/functional/test_mipsel_malta.py
> +++ b/tests/functional/mipsel/test_malta.py
> @@ -13,7 +13,7 @@
>  from qemu_test import interrupt_interactive_console_until_pattern
>  from qemu_test import wait_for_console_pattern
>
> -from test_mips_malta import mips_check_wheezy
> +from mips.test_malta import mips_check_wheezy
>
>
>  class MaltaMachineConsole(LinuxKernelTest):
> diff --git a/tests/functional/test_mipsel_replay.py b/tests/functional/mi=
psel/test_replay.py
> similarity index 100%
> rename from tests/functional/test_mipsel_replay.py
> rename to tests/functional/mipsel/test_replay.py
> diff --git a/tests/functional/test_mipsel_tuxrun.py b/tests/functional/mi=
psel/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_mipsel_tuxrun.py
> rename to tests/functional/mipsel/test_tuxrun.py
> diff --git a/tests/functional/or1k/meson.build b/tests/functional/or1k/me=
son.build
> new file mode 100644
> index 00000000000..e439087d938
> --- /dev/null
> +++ b/tests/functional/or1k/meson.build
> @@ -0,0 +1,5 @@
> +
> +tests_or1k_system_thorough =3D [
> +  'replay',
> +  'sim',
> +]
> diff --git a/tests/functional/test_or1k_replay.py b/tests/functional/or1k=
/test_replay.py
> similarity index 100%
> rename from tests/functional/test_or1k_replay.py
> rename to tests/functional/or1k/test_replay.py
> diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/or1k/te=
st_sim.py
> similarity index 100%
> rename from tests/functional/test_or1k_sim.py
> rename to tests/functional/or1k/test_sim.py
> diff --git a/tests/functional/ppc/meson.build b/tests/functional/ppc/meso=
n.build
> new file mode 100644
> index 00000000000..81f73a44417
> --- /dev/null
> +++ b/tests/functional/ppc/meson.build
> @@ -0,0 +1,22 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_ppc_timeouts =3D {
> +  '40p' : 240,
> +}
> +
> +tests_ppc_system_quick =3D [
> +  'migration',
> +  '74xx',
> +]
> +
> +tests_ppc_system_thorough =3D [
> +  '40p',
> +  'amiga',
> +  'bamboo',
> +  'mac',
> +  'mpc8544ds',
> +  'replay',
> +  'sam460ex',
> +  'tuxrun',
> +  'virtex_ml507',
> +]
> diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/ppc/test=
_40p.py
> similarity index 100%
> rename from tests/functional/test_ppc_40p.py
> rename to tests/functional/ppc/test_40p.py
> diff --git a/tests/functional/test_ppc_74xx.py b/tests/functional/ppc/tes=
t_74xx.py
> similarity index 100%
> rename from tests/functional/test_ppc_74xx.py
> rename to tests/functional/ppc/test_74xx.py
> diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/ppc/te=
st_amiga.py
> similarity index 100%
> rename from tests/functional/test_ppc_amiga.py
> rename to tests/functional/ppc/test_amiga.py
> diff --git a/tests/functional/test_ppc_bamboo.py b/tests/functional/ppc/t=
est_bamboo.py
> similarity index 100%
> rename from tests/functional/test_ppc_bamboo.py
> rename to tests/functional/ppc/test_bamboo.py
> diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/ppc/test=
_mac.py
> similarity index 100%
> rename from tests/functional/test_ppc_mac.py
> rename to tests/functional/ppc/test_mac.py
> diff --git a/tests/functional/ppc/test_migration.py b/tests/functional/pp=
c/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/ppc/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/test_ppc_mpc8544ds.py b/tests/functional/pp=
c/test_mpc8544ds.py
> similarity index 100%
> rename from tests/functional/test_ppc_mpc8544ds.py
> rename to tests/functional/ppc/test_mpc8544ds.py
> diff --git a/tests/functional/test_ppc_replay.py b/tests/functional/ppc/t=
est_replay.py
> similarity index 100%
> rename from tests/functional/test_ppc_replay.py
> rename to tests/functional/ppc/test_replay.py
> diff --git a/tests/functional/test_ppc_sam460ex.py b/tests/functional/ppc=
/test_sam460ex.py
> similarity index 100%
> rename from tests/functional/test_ppc_sam460ex.py
> rename to tests/functional/ppc/test_sam460ex.py
> diff --git a/tests/functional/test_ppc_tuxrun.py b/tests/functional/ppc/t=
est_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_ppc_tuxrun.py
> rename to tests/functional/ppc/test_tuxrun.py
> diff --git a/tests/functional/test_ppc_virtex_ml507.py b/tests/functional=
/ppc/test_virtex_ml507.py
> similarity index 100%
> rename from tests/functional/test_ppc_virtex_ml507.py
> rename to tests/functional/ppc/test_virtex_ml507.py
> diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/=
meson.build
> new file mode 100644
> index 00000000000..58867c3b5b6
> --- /dev/null
> +++ b/tests/functional/ppc64/meson.build
> @@ -0,0 +1,25 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_ppc64_timeouts =3D {
> +  'hv' : 1000,
> +  'powernv' : 480,
> +  'pseries' : 480,
> +  'replay' : 210,
> +  'tuxrun' : 420,
> +  'mac99' : 120,
> +}
> +
> +tests_ppc64_system_quick =3D [
> +  'migration',
> +]
> +
> +tests_ppc64_system_thorough =3D [
> +  'e500',
> +  'hv',
> +  'powernv',
> +  'pseries',
> +  'replay',
> +  'reverse_debug',
> +  'tuxrun',
> +  'mac99',
> +]
> diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/ppc64=
/test_e500.py
> similarity index 100%
> rename from tests/functional/test_ppc64_e500.py
> rename to tests/functional/ppc64/test_e500.py
> diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/ppc64/t=
est_hv.py
> similarity index 100%
> rename from tests/functional/test_ppc64_hv.py
> rename to tests/functional/ppc64/test_hv.py
> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/ppc6=
4/test_mac99.py
> similarity index 100%
> rename from tests/functional/test_ppc64_mac99.py
> rename to tests/functional/ppc64/test_mac99.py
> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/=
ppc64/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/ppc64/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/pp=
c64/test_powernv.py
> similarity index 100%
> rename from tests/functional/test_ppc64_powernv.py
> rename to tests/functional/ppc64/test_powernv.py
> diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/pp=
c64/test_pseries.py
> similarity index 100%
> rename from tests/functional/test_ppc64_pseries.py
> rename to tests/functional/ppc64/test_pseries.py
> diff --git a/tests/functional/test_ppc64_replay.py b/tests/functional/ppc=
64/test_replay.py
> similarity index 100%
> rename from tests/functional/test_ppc64_replay.py
> rename to tests/functional/ppc64/test_replay.py
> diff --git a/tests/functional/test_ppc64_reverse_debug.py b/tests/functio=
nal/ppc64/test_reverse_debug.py
> similarity index 100%
> rename from tests/functional/test_ppc64_reverse_debug.py
> rename to tests/functional/ppc64/test_reverse_debug.py
> diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/ppc=
64/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_ppc64_tuxrun.py
> rename to tests/functional/ppc64/test_tuxrun.py
> diff --git a/tests/functional/riscv32/meson.build b/tests/functional/risc=
v32/meson.build
> new file mode 100644
> index 00000000000..19298b564fe
> --- /dev/null
> +++ b/tests/functional/riscv32/meson.build
> @@ -0,0 +1,9 @@
> +
> +tests_riscv32_system_quick =3D [
> +  'migration',
> +  'opensbi',
> +]
> +
> +tests_riscv32_system_thorough =3D [
> +  'tuxrun',
> +]
> diff --git a/tests/functional/riscv32/test_migration.py b/tests/functiona=
l/riscv32/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/riscv32/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/riscv32/test_opensbi.py b/tests/functional/=
riscv32/test_opensbi.py
> new file mode 120000
> index 00000000000..67763bc7829
> --- /dev/null
> +++ b/tests/functional/riscv32/test_opensbi.py
> @@ -0,0 +1 @@
> +../riscv64/test_opensbi.py
> \ No newline at end of file
> diff --git a/tests/functional/test_riscv32_tuxrun.py b/tests/functional/r=
iscv32/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_riscv32_tuxrun.py
> rename to tests/functional/riscv32/test_tuxrun.py
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/risc=
v64/meson.build
> new file mode 100644
> index 00000000000..c03772882cb
> --- /dev/null
> +++ b/tests/functional/riscv64/meson.build
> @@ -0,0 +1,13 @@
> +
> +test_riscv64_timeouts =3D {
> +  'tuxrun' : 120,
> +}
> +
> +tests_riscv64_system_quick =3D [
> +  'migration',
> +  'opensbi',
> +]
> +
> +tests_riscv64_system_thorough =3D [
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_riscv_opensbi.py b/tests/functional/ri=
scv64/test_opensbi.py
> similarity index 100%
> rename from tests/functional/test_riscv_opensbi.py
> rename to tests/functional/riscv64/test_opensbi.py
> diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/r=
iscv64/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_riscv64_tuxrun.py
> rename to tests/functional/riscv64/test_tuxrun.py
> diff --git a/tests/functional/rx/meson.build b/tests/functional/rx/meson.=
build
> new file mode 100644
> index 00000000000..da311c169e8
> --- /dev/null
> +++ b/tests/functional/rx/meson.build
> @@ -0,0 +1,4 @@
> +
> +tests_rx_system_thorough =3D [
> +  'gdbsim',
> +]
> diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/rx/tes=
t_gdbsim.py
> similarity index 100%
> rename from tests/functional/test_rx_gdbsim.py
> rename to tests/functional/rx/test_gdbsim.py
> diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/=
meson.build
> new file mode 100644
> index 00000000000..892e7d6dd52
> --- /dev/null
> +++ b/tests/functional/s390x/meson.build
> @@ -0,0 +1,12 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_s390x_timeouts =3D {
> +  'ccw_virtio' : 420,
> +}
> +
> +tests_s390x_system_thorough =3D [
> +  'ccw_virtio',
> +  'replay',
> +  'topology',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional=
/s390x/test_ccw_virtio.py
> similarity index 100%
> rename from tests/functional/test_s390x_ccw_virtio.py
> rename to tests/functional/s390x/test_ccw_virtio.py
> diff --git a/tests/functional/test_s390x_replay.py b/tests/functional/s39=
0x/test_replay.py
> similarity index 100%
> rename from tests/functional/test_s390x_replay.py
> rename to tests/functional/s390x/test_replay.py
> diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/s=
390x/test_topology.py
> similarity index 100%
> rename from tests/functional/test_s390x_topology.py
> rename to tests/functional/s390x/test_topology.py
> diff --git a/tests/functional/test_s390x_tuxrun.py b/tests/functional/s39=
0x/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_s390x_tuxrun.py
> rename to tests/functional/s390x/test_tuxrun.py
> diff --git a/tests/functional/sh4/meson.build b/tests/functional/sh4/meso=
n.build
> new file mode 100644
> index 00000000000..d731581048a
> --- /dev/null
> +++ b/tests/functional/sh4/meson.build
> @@ -0,0 +1,10 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_sh4_timeouts =3D {
> +  'tuxrun' : 240,
> +}
> +
> +tests_sh4_system_thorough =3D [
> +  'r2d',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/sh4/test=
_r2d.py
> similarity index 100%
> rename from tests/functional/test_sh4_r2d.py
> rename to tests/functional/sh4/test_r2d.py
> diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/sh4/t=
est_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_sh4_tuxrun.py
> rename to tests/functional/sh4/test_tuxrun.py
> diff --git a/tests/functional/sh4eb/meson.build b/tests/functional/sh4eb/=
meson.build
> new file mode 100644
> index 00000000000..5575e235776
> --- /dev/null
> +++ b/tests/functional/sh4eb/meson.build
> @@ -0,0 +1,4 @@
> +
> +tests_sh4eb_system_thorough =3D [
> +  'r2d',
> +]
> diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/sh4eb/=
test_r2d.py
> similarity index 100%
> rename from tests/functional/test_sh4eb_r2d.py
> rename to tests/functional/sh4eb/test_r2d.py
> diff --git a/tests/functional/sparc/meson.build b/tests/functional/sparc/=
meson.build
> new file mode 100644
> index 00000000000..18d9c75c23a
> --- /dev/null
> +++ b/tests/functional/sparc/meson.build
> @@ -0,0 +1,9 @@
> +
> +tests_sparc_system_quick =3D [
> +  'migration',
> +]
> +
> +tests_sparc_system_thorough =3D [
> +  'replay',
> +  'sun4m',
> +]
> diff --git a/tests/functional/sparc/test_migration.py b/tests/functional/=
sparc/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/sparc/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/test_sparc_replay.py b/tests/functional/spa=
rc/test_replay.py
> similarity index 100%
> rename from tests/functional/test_sparc_replay.py
> rename to tests/functional/sparc/test_replay.py
> diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/spar=
c/test_sun4m.py
> similarity index 100%
> rename from tests/functional/test_sparc_sun4m.py
> rename to tests/functional/sparc/test_sun4m.py
> diff --git a/tests/functional/sparc64/meson.build b/tests/functional/spar=
c64/meson.build
> new file mode 100644
> index 00000000000..4a5a65defd3
> --- /dev/null
> +++ b/tests/functional/sparc64/meson.build
> @@ -0,0 +1,9 @@
> +
> +tests_sparc64_system_quick =3D [
> +  'migration',
> +]
> +
> +tests_sparc64_system_thorough =3D [
> +  'sun4u',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/sparc64/test_migration.py b/tests/functiona=
l/sparc64/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/sparc64/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/test_sparc64_sun4u.py b/tests/functional/sp=
arc64/test_sun4u.py
> similarity index 100%
> rename from tests/functional/test_sparc64_sun4u.py
> rename to tests/functional/sparc64/test_sun4u.py
> diff --git a/tests/functional/test_sparc64_tuxrun.py b/tests/functional/s=
parc64/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_sparc64_tuxrun.py
> rename to tests/functional/sparc64/test_tuxrun.py
> diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_6=
4/meson.build
> new file mode 100644
> index 00000000000..49b05a8a170
> --- /dev/null
> +++ b/tests/functional/x86_64/meson.build
> @@ -0,0 +1,37 @@
> +
> +# Timeouts for individual tests that can be slow e.g. with debugging ena=
bled
> +test_x86_64_timeouts =3D {
> +  'acpi_bits' : 420,
> +  'intel_iommu': 300,
> +  'netdev_ethtool' : 180,
> +  'kvm_xen' : 180,
> +  'replay' : 480,
> +  'virtio_balloon': 120,
> +}
> +
> +tests_x86_64_system_quick =3D [
> +  'cpu_queries',
> +  'mem_addr_space',
> +  'migration',
> +  'pc_cpu_hotplug_props',
> +  'virtio_version',
> +  'x86_cpu_model_versions',
> +  'vnc',
> +  'memlock',
> +]
> +
> +tests_x86_64_system_thorough =3D [
> +  'acpi_bits',
> +  'intel_iommu',
> +  'linux_initrd',
> +  'multiprocess',
> +  'netdev_ethtool',
> +  'virtio_balloon',
> +  'virtio_gpu',
> +  'hotplug_blk',
> +  'hotplug_cpu',
> +  'kvm_xen',
> +  'replay',
> +  'reverse_debug',
> +  'tuxrun',
> +]
> diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/x86_64=
/test_acpi_bits.py
> similarity index 100%
> rename from tests/functional/test_acpi_bits.py
> rename to tests/functional/x86_64/test_acpi_bits.py
> diff --git a/tests/functional/test_cpu_queries.py b/tests/functional/x86_=
64/test_cpu_queries.py
> similarity index 100%
> rename from tests/functional/test_cpu_queries.py
> rename to tests/functional/x86_64/test_cpu_queries.py
> diff --git a/tests/functional/test_x86_64_hotplug_blk.py b/tests/function=
al/x86_64/test_hotplug_blk.py
> similarity index 100%
> rename from tests/functional/test_x86_64_hotplug_blk.py
> rename to tests/functional/x86_64/test_hotplug_blk.py
> diff --git a/tests/functional/test_x86_64_hotplug_cpu.py b/tests/function=
al/x86_64/test_hotplug_cpu.py
> similarity index 100%
> rename from tests/functional/test_x86_64_hotplug_cpu.py
> rename to tests/functional/x86_64/test_hotplug_cpu.py
> diff --git a/tests/functional/test_intel_iommu.py b/tests/functional/x86_=
64/test_intel_iommu.py
> similarity index 100%
> rename from tests/functional/test_intel_iommu.py
> rename to tests/functional/x86_64/test_intel_iommu.py
> diff --git a/tests/functional/test_x86_64_kvm_xen.py b/tests/functional/x=
86_64/test_kvm_xen.py
> similarity index 100%
> rename from tests/functional/test_x86_64_kvm_xen.py
> rename to tests/functional/x86_64/test_kvm_xen.py
> diff --git a/tests/functional/test_linux_initrd.py b/tests/functional/x86=
_64/test_linux_initrd.py
> similarity index 100%
> rename from tests/functional/test_linux_initrd.py
> rename to tests/functional/x86_64/test_linux_initrd.py
> diff --git a/tests/functional/test_mem_addr_space.py b/tests/functional/x=
86_64/test_mem_addr_space.py
> similarity index 100%
> rename from tests/functional/test_mem_addr_space.py
> rename to tests/functional/x86_64/test_mem_addr_space.py
> diff --git a/tests/functional/test_memlock.py b/tests/functional/x86_64/t=
est_memlock.py
> similarity index 100%
> rename from tests/functional/test_memlock.py
> rename to tests/functional/x86_64/test_memlock.py
> diff --git a/tests/functional/x86_64/test_migration.py b/tests/functional=
/x86_64/test_migration.py
> new file mode 120000
> index 00000000000..3933b7f3345
> --- /dev/null
> +++ b/tests/functional/x86_64/test_migration.py
> @@ -0,0 +1 @@
> +../generic/test_migration.py
> \ No newline at end of file
> diff --git a/tests/functional/test_multiprocess.py b/tests/functional/x86=
_64/test_multiprocess.py
> similarity index 100%
> rename from tests/functional/test_multiprocess.py
> rename to tests/functional/x86_64/test_multiprocess.py
> diff --git a/tests/functional/test_netdev_ethtool.py b/tests/functional/x=
86_64/test_netdev_ethtool.py
> similarity index 100%
> rename from tests/functional/test_netdev_ethtool.py
> rename to tests/functional/x86_64/test_netdev_ethtool.py
> diff --git a/tests/functional/test_pc_cpu_hotplug_props.py b/tests/functi=
onal/x86_64/test_pc_cpu_hotplug_props.py
> similarity index 100%
> rename from tests/functional/test_pc_cpu_hotplug_props.py
> rename to tests/functional/x86_64/test_pc_cpu_hotplug_props.py
> diff --git a/tests/functional/test_x86_64_replay.py b/tests/functional/x8=
6_64/test_replay.py
> similarity index 100%
> rename from tests/functional/test_x86_64_replay.py
> rename to tests/functional/x86_64/test_replay.py
> diff --git a/tests/functional/test_x86_64_reverse_debug.py b/tests/functi=
onal/x86_64/test_reverse_debug.py
> similarity index 100%
> rename from tests/functional/test_x86_64_reverse_debug.py
> rename to tests/functional/x86_64/test_reverse_debug.py
> diff --git a/tests/functional/test_x86_64_tuxrun.py b/tests/functional/x8=
6_64/test_tuxrun.py
> similarity index 100%
> rename from tests/functional/test_x86_64_tuxrun.py
> rename to tests/functional/x86_64/test_tuxrun.py
> diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/x=
86_64/test_virtio_balloon.py
> similarity index 100%
> rename from tests/functional/test_virtio_balloon.py
> rename to tests/functional/x86_64/test_virtio_balloon.py
> diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/x86_6=
4/test_virtio_gpu.py
> similarity index 100%
> rename from tests/functional/test_virtio_gpu.py
> rename to tests/functional/x86_64/test_virtio_gpu.py
> diff --git a/tests/functional/test_virtio_version.py b/tests/functional/x=
86_64/test_virtio_version.py
> similarity index 100%
> rename from tests/functional/test_virtio_version.py
> rename to tests/functional/x86_64/test_virtio_version.py
> diff --git a/tests/functional/test_vnc.py b/tests/functional/x86_64/test_=
vnc.py
> similarity index 100%
> rename from tests/functional/test_vnc.py
> rename to tests/functional/x86_64/test_vnc.py
> diff --git a/tests/functional/test_x86_cpu_model_versions.py b/tests/func=
tional/x86_64/test_x86_cpu_model_versions.py
> similarity index 100%
> rename from tests/functional/test_x86_cpu_model_versions.py
> rename to tests/functional/x86_64/test_x86_cpu_model_versions.py
> diff --git a/tests/functional/xtensa/meson.build b/tests/functional/xtens=
a/meson.build
> new file mode 100644
> index 00000000000..ca1b6e943b4
> --- /dev/null
> +++ b/tests/functional/xtensa/meson.build
> @@ -0,0 +1,5 @@
> +
> +tests_xtensa_system_thorough =3D [
> +  'lx60',
> +  'replay',
> +]
> diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/xten=
sa/test_lx60.py
> similarity index 100%
> rename from tests/functional/test_xtensa_lx60.py
> rename to tests/functional/xtensa/test_lx60.py
> diff --git a/tests/functional/test_xtensa_replay.py b/tests/functional/xt=
ensa/test_replay.py
> similarity index 100%
> rename from tests/functional/test_xtensa_replay.py
> rename to tests/functional/xtensa/test_replay.py
> --
> 2.50.0
>
>

