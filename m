Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C05C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ee7-0008Pu-Vl; Thu, 24 Sep 2026 04:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x9ee5-0008PE-BL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 04:17:33 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1x9ee3-0004Uf-6k
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 04:17:33 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aa8d882so1860907d50.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 01:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790237849; cv=none;
 d=google.com; s=arc-20260327;
 b=MGgu3BPyKuNJsHnUtw+CqYjO64G3dRRh7g9cfY08u2KBkK94bc25FPt9eJm+lz+KnL
 DzsxMJTCsyQY/JpagwmYrMdKUhojHSBerUNRuGfjhiP1JBLcHRcoDGQvmTCgMl94vYSh
 4MZ/y9uCZpw1v/8x7ohNHn6ob1P7OJD+D5d85TD0wzvAJfynWr9KyQvH8qHawcNXNFa3
 R1QDs3tPTzLQgiE/cV4EDHzWrhngRX6tnbqB0X2vLvh3sshqdUk+jbkXjx7fQzFyoq3W
 1D2PKTN5vc6Hboj7+4SVnakx/GdyMGb8v2GMpH0DF7eCDusf3pogcN5H1MGEKTo2hKTb
 G4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WMDPFUIAwhcXLRMFQptmFPCdBjYlqmtypgRwhRDY7VE=;
 fh=Ar68mZRnY0T1Wf4TtQ8wXGIYrj3PsRi97Ktui9R4nSs=;
 b=EDto4wNTHkjquxeppWmwYO4YJRx7WNs3j/3H7A0ZWkx5gx6sxWJ0z0D/fs/qh5o33M
 tMHF92et8HAYpCroKV/4jGyyXUJN9l2AxmT6i3Lz/y3DZPsTiUFjvRRDx5s5XOy5f//t
 UWShSxFlKGOMfyvqqH+BZT88BKbzubmDlsJ8rr+3swyVhs56/alF6Im1HJVlnxA3tKod
 SHWw/NpwKH6jMwMCI+JXEDbiwHiETNSYCtiEgyHh1vKv0IhkByh+lW+bYGutVFylgtZM
 lmhshuTazIVSNGIgvN3AEaCqAnqpImqd+95OKT+49IcL6YQ3ag/3NfJKWtdMpaLmpoSV
 ibKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790237849; x=1790842649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WMDPFUIAwhcXLRMFQptmFPCdBjYlqmtypgRwhRDY7VE=;
 b=hjhnpX4sAHrZ3abHW8ji9QT7Wy8HIKiVajMRKlkHo8OK9BtYTxzQLqk5P6sjXPyQFU
 d44tA+f6e8eTLHpkKIS4MfkHQE+VChKCUx+P1jy3aC9wHyHerXOSFJBhaFywCOpI79LM
 pPX532rtR7tRoMeq9GkeUnAlYXipuCr+xxxTnE8K5YDFd+BbIpccVcoCi3NExW++H/tw
 F/vUzEhkxS/vP5OaXnp27W8IBbAIC4yBvhYLi8u87FWH8opouUClW70FkdYPB/+nXHp9
 XVkeZdd3wA9zV4uy1Bv5JoWVZsub8rl+Dgf+iL0HmEpcTzcWzpWSF/iLcw1Xfldwyv6z
 ihNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790237849; x=1790842649;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WMDPFUIAwhcXLRMFQptmFPCdBjYlqmtypgRwhRDY7VE=;
 b=TYOXq/FpmhVgC3NG4UptHZ4q5CP0QD7faoM6wecozI7yDUEMe/KUW8gL5vefUMM8vq
 8GyekmvKS4C2semAMaBO1x0Se0gvBHdR6vlcIvv5oZkJ7vj1HHHqyZWuewv8oMdsTs95
 Dnc1Noh7wvBHf8/vviZp3DWMT7S1fStO1ENQqdb7rEmUof/Qwye2woEPCIkIca623W35
 fP3An90aOnlVcJ2M8gBPHTf9LXDmz/sMQbIeq3fouWQ1PuGcJmAKufvfolG3ipI3gucm
 JCgDhtehGfMOqEvvXxkuK4GIMhjqheq9YhsuH7EuRuzOEMIJfe7JKZRUtsgYimD9o5/y
 B+SQ==
X-Gm-Message-State: AFuF++mnWUSKIVhsly0rD/G0mmiTUxJvGhdxFHL08mSFTCILkkTbwnEH
 fQ519e7nyQlb/RWvSicPn7w5gKVTJASfg3U8cmxTtqs1y9Y9swwXHskKb89Ew4uWZKM9hD6fn1v
 lqpinsdGDaulEhACDUMokVudgqv/Eoc4=
X-Gm-Gg: AYBFou2PJNf6osG6gHn5ffxxbGip0rdB2MR7mPtr4lgj2MsGFRy6QizE7HKXxbvF9uB
 l8xZWoyhL3stMHw6+p5XuMgiexLV9/ggaM6VJrhd9fKV6U4uEY+RvMAEGbqRbgR8HW2oDi6QIdq
 KuGxGEsT+o/sHcdarKtiBH46BeDLObNlUej75xS34KkvQ762ZG1R1R/qxsnLnzYdgXizLnwifGE
 JtC+5FJ6aB16x4QgC9ITbInXKkJa6ems6p19v/dMct2MkH3FGIn+cO5mxU5T1Oc3qwjWnD+ZRkc
 YElOj4rFhhq/QCVHt67ZZxJw9cTnKYke57ULPHf3V2YMpag0uj9q5euf
X-Received: by 2002:a05:690e:4889:20b0:66e:61c8:33f2 with SMTP id
 956f58d0204a3-672ed25f1a8mr687858d50.18.1790237849200; Thu, 24 Sep 2026
 01:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260908104159.1621764-1-bin.meng@processmission.com>
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 24 Sep 2026 16:17:16 +0800
X-Gm-Features: AclHuK_3ab5DDHVGNFLlPel-dFmXix1n-nhSunxxwN4bj0jSOL9kA_S60zZjybQ
Message-ID: <CAEUhbmVH_=Q6NjhU2f5oqZwD3i1FQRQyvngvMcBsf9nKJYq02Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/32] hw/arm: Add Phytium E2000Q SoC and board support
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 8, 2026 at 6:42=E2=80=AFPM Bin Meng <bin.meng@processmission.co=
m> wrote:
>
>
> The Phytium E2000Q is a heterogeneous Armv8 SoC with two FTC664 cores
> and two FTC310 cores. This series adds a reusable E2000Q SoC QOM
> device which owns Cortex-A72 CPU children and applies the FTC core
> configuration locally. Two board machines embed the SoC:
>
>   - phytium-pi, with firmware and Linux on SD0
>   - phytium-e2000-come, with firmware in QSPI NOR and Linux on an
>     AHCI1 SATA disk
>
> The machines support the vendor firmware path from the on-chip
> Phytium Boot ROM (PBR) handoff through Processor Base Firmware (PBF),
> TF-A, OP-TEE, U-Boot, and Linux. They can also directly boot SDK Linux
> kernels when supplied with matching board device trees.
>
> The PBR model does not execute undocumented ROM code. It parses the
> selected fip-all.bin, validates the PBF, TF-A FIP, and platform
> parameter records, and reconstructs the observed handoff state. The
> MHU model handles the private SCMI power-domain requests needed to
> release secondary CPUs and exposes a separate Base-protocol channel
> to Linux.
>
> The E2000Q SoC provides GICv3/ITS, UARTs, GPEX PCIe, SMMUv3, four
> Cadence GEM controllers, two DesignWare-derived MCI controllers, QSPI,
> I2C, xHCI, AHCI, a random generator, and the firmware-facing DDR and
> control regions. Board machines retain RAM, firmware media, and
> storage backend attachment. Unimplemented register windows remain
> visible to firmware without claiming unsupported behavior.
>
> Functional tests exercise both firmware and direct Linux boot on the
> Phytium Pi with an SDK Buildroot image. Manual testing covers Phytium
> Pi SD boot, COMe QSPI-to-SATA boot, all four CPUs, and network access.
>
> Known limitations are documented. In particular, the PBR handoff is
> a behavioral model validated against the available SDK firmware
> samples.
>
> Changes in v2:
> - Use scripts/git.orderfile when generating the series
> - Configure FTC cores as SoC-owned Cortex-A72 CPU children
> - Keep Phytium CPU configuration out of the global ARM CPU list
> - Explain why the Phytium machines are restricted to TCG
> - Reduce the DesignWare MCI register migration state to 96 words
>
> Bin Meng (32):
>   hw/arm: Add Phytium E2000 SoC and Phytium Pi machine
>   hw/arm: phytium: Add Phytium E2000 PCIe host
>   hw/sd: Add Synopsys DesignWare MCI controller
>   hw/sd: Add Phytium E2000 MCI controller
>   hw/arm: phytium: Connect Phytium E2000 MCI controllers
>   tests/qtest: Add Synopsys DesignWare MCI coverage
>   hw/arm: phytium: Connect Phytium E2000 GEM controllers
>   hw/misc: Add Phytium E2000 DDR controller
>   hw/arm: phytium: Connect the Phytium E2000 DDR controller
>   hw/misc: Add Phytium E2000 MHU doorbell
>   hw/arm: phytium: Connect the Phytium E2000 MHU
>   hw/ssi: Add Phytium E2000 QSPI controller
>   hw/arm: phytium: Connect the Phytium E2000 QSPI controller
>   hw/misc: Add Phytium E2000 PBR model
>   hw/arm: phytium: Integrate the Phytium E2000 PBR
>   hw/arm: phytium: Add Phytium E2000 control region placeholders
>   hw/misc: Support Phytium E2000 SCMI CPU power control
>   hw/arm: phytium: Select the Phytium E2000 PBR boot medium
>   hw/arm: phytium: Connect the Phytium E2000 I2C controller
>   hw/arm: phytium: Add Phytium E2000 xHCI controllers
>   hw/misc: Model the Phytium E2000 random generator
>   hw/arm: phytium: Connect the Phytium E2000 random generator
>   hw/arm: phytium: Support Phytium E2000 direct Linux boot
>   hw/arm: phytium: Add Phytium E2000Q COMe machine
>   hw/block: m25p80: Add GigaDevice GD25Q128 flash
>   hw/arm: phytium: Connect the Phytium E2000Q COMe QSPI flash
>   hw/arm: phytium: Add Phytium E2000 AHCI controllers
>   hw/arm: Add Phytium E2000 Linux SCMI channel
>   hw/arm: phytium: Connect the Phytium E2000 SMMUv3
>   docs/system/arm: Document Phytium E2000 machines
>   tests/functional/aarch64: Add Phytium Pi boot tests
>   MAINTAINERS: Add Phytium E2000Q machines
>
>  MAINTAINERS                                 |   18 +
>  docs/system/arm/phytium_e2000.rst           |  422 ++++++
>  docs/system/target-arm.rst                  |    1 +
>  include/hw/arm/phytium_e2000.h              |  120 ++
>  include/hw/misc/phytium_e2000_ddr.h         |   23 +
>  include/hw/misc/phytium_e2000_mhu.h         |   34 +
>  include/hw/misc/phytium_e2000_pbr.h         |   62 +
>  include/hw/misc/phytium_e2000_rng.h         |   23 +
>  include/hw/sd/dw_mci.h                      |   75 +
>  include/hw/sd/phytium_e2000_mci.h           |   21 +
>  include/hw/ssi/phytium_qspi.h               |   23 +
>  hw/arm/phytium_e2000.c                      |  958 +++++++++++++
>  hw/arm/phytium_e2000_machine.c              |  388 ++++++
>  hw/block/m25p80.c                           |    1 +
>  hw/misc/phytium_e2000_ddr.c                 |  197 +++
>  hw/misc/phytium_e2000_mhu.c                 |  818 +++++++++++
>  hw/misc/phytium_e2000_pbr.c                 | 1366 ++++++++++++++++++
>  hw/misc/phytium_e2000_rng.c                 |  182 +++
>  hw/sd/dw_mci.c                              | 1382 +++++++++++++++++++
>  hw/sd/phytium_e2000_mci.c                   |   95 ++
>  hw/ssi/phytium_qspi.c                       |  398 ++++++
>  tests/qtest/dw_mci-test.c                   |  417 ++++++
>  hw/arm/Kconfig                              |   22 +
>  hw/arm/meson.build                          |    4 +
>  hw/misc/meson.build                         |    4 +
>  hw/sd/Kconfig                               |    5 +
>  hw/sd/meson.build                           |    2 +
>  hw/ssi/Kconfig                              |    5 +
>  hw/ssi/meson.build                          |    1 +
>  tests/functional/aarch64/meson.build        |    2 +
>  tests/functional/aarch64/test_phytium_pi.py |   77 ++
>  tests/qtest/meson.build                     |    1 +
>  32 files changed, 7147 insertions(+)
>  create mode 100644 docs/system/arm/phytium_e2000.rst
>  create mode 100644 include/hw/arm/phytium_e2000.h
>  create mode 100644 include/hw/misc/phytium_e2000_ddr.h
>  create mode 100644 include/hw/misc/phytium_e2000_mhu.h
>  create mode 100644 include/hw/misc/phytium_e2000_pbr.h
>  create mode 100644 include/hw/misc/phytium_e2000_rng.h
>  create mode 100644 include/hw/sd/dw_mci.h
>  create mode 100644 include/hw/sd/phytium_e2000_mci.h
>  create mode 100644 include/hw/ssi/phytium_qspi.h
>  create mode 100644 hw/arm/phytium_e2000.c
>  create mode 100644 hw/arm/phytium_e2000_machine.c
>  create mode 100644 hw/misc/phytium_e2000_ddr.c
>  create mode 100644 hw/misc/phytium_e2000_mhu.c
>  create mode 100644 hw/misc/phytium_e2000_pbr.c
>  create mode 100644 hw/misc/phytium_e2000_rng.c
>  create mode 100644 hw/sd/dw_mci.c
>  create mode 100644 hw/sd/phytium_e2000_mci.c
>  create mode 100644 hw/ssi/phytium_qspi.c
>  create mode 100644 tests/qtest/dw_mci-test.c
>  create mode 100644 tests/functional/aarch64/test_phytium_pi.py
>
> ---
> base-commit: 35500e5c41aec76cde59befe750600dac7a9e37a
> branch: phytium
>

Ping for review?

