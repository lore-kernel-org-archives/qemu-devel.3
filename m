Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4FEFE51FE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGFKV-0001P7-4l; Fri, 24 Apr 2026 08:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wGFKD-0001OB-Fg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:08:02 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wGFK8-0008A8-RW
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:08:01 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6715594a4c2so9197475a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 05:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777032475; cv=none;
 d=google.com; s=arc-20240605;
 b=BhxoATLhIxTbWOJqNXsmUrqbnowuX0xklI2TvnSFXmkHoGqemSOr9ljHOmW1/NzQRj
 sMgWfcTZjDTwuPiOoCHDC0orGZ1Hhgr+arQg50EXwvATiiYiG/g4FCao4g0wUUbrCmbg
 /tTStJ5sZCSTiWDW8Yt6RCdP0y6d9JRWC9zTkuxsS2+CKLU5iFelavqsllb4R0cCHx6N
 frEhj3jlyqhAUGJerohcE7IGh+wVULrzftme43DcMiW+Fm8zsv2u3gBNJCv93W/QfnCB
 w72WfqqZ08cq4oyzsKUAKbGDuK/0sGc8v2HuwUzF6chPPcJsWR1RTNWf6niLAgpfkgKI
 Tn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vczKDLzuoESfNGUm4s9aRY7W0HbZUDMSzWZpaZehUoc=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=e4GvpIrYt9GXxGDac7EQn9X33dXlrirlvSVjZyTbJH+ARWk+sKSBTt9dbtblY0tJR9
 XmJHufMkujuLJkRXXWUiL0HFqpzzR9olUmv1nZIsvLoq5NOmhQesuTL9GCefYNgu6NJS
 yTjV6rRqu0751uE878NiKKBg4+hkTIrSfnC3Ez6KxGt0PVmW4PoHHXFacunPyG4g3T/j
 kpd8ydyaal8e4KuotO0+5jvV77w6tR25JC3ip0dEgfEiHq5e2PHhv8+IgrAbFEVnamPx
 r6VBIUIPbXkSnRvHkLxWUPWdpKD39pRVyF9pZbKqTyFrJwi1TlHTQOp6pDSig44ElgnY
 qmzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777032475; x=1777637275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vczKDLzuoESfNGUm4s9aRY7W0HbZUDMSzWZpaZehUoc=;
 b=fTN5H032nv98KtnXqd0yjM+ZganHS9tqeNOrtkSXYvMlOgFkZXEA3dlhL/xqxgtB2e
 RXqCrM5L7CsyZ3kMUxAQggS8tDFzSd4v3QkQH/gjihKo4eTf1RVQpklf8ueImN5PntJE
 Y+SnXa5uyG69Vw49pcJVIakSShzGtKWpd9jo5WOtrUNk7YT1iijohv/wre1Pr8THGqj4
 vu1FvluQPEYQfFuUWK8Qhhjf5lXiKTNjXw0+HqCux7oA+m/USccHC0SStEDh/1iDQ/a1
 YeQKR3n7LlvBzLgAGjOdvL20Adi6os6Jc8f2FM8E3baMmoC754pX7rfOsWVeo5fh87ub
 juwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777032475; x=1777637275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vczKDLzuoESfNGUm4s9aRY7W0HbZUDMSzWZpaZehUoc=;
 b=dGLbI0Ng/hx4Dd+aoyL50Ak3KftuPUCXnWpVWW3wOGm6tKREzuvD/EIOWUNpZFT2SO
 e/IAlzO3uqsbWMjYjGyeYLekbyknyPDGCmeyKL9YjDJkgn+7PlnVeUJ0se8LH9dRVsV6
 fXbmyNO1H/udNVYbKReNAVka3MAoPICqJYXpk+DocMIP7ZjVocfqgk1Tb4HDN8KsasPQ
 t5DpOHRHh1Y4aaRNrgvY/gHfq5T358YcLrCVe4+3bFFUr2xp40/mQp8l06j91zpHH67e
 AJBxI4hfs+Qaq255snm/qhVvRuKUscjMVz8cM9kwdONSUoAwEspjQN1B9IFpPSCACAsV
 UZTQ==
X-Gm-Message-State: AOJu0Yx95rZWxxPoSDODi5dNrOx8gT5huHfVR7kSIU0RhIrvBpjNTRUU
 KZsZuHP0zvLhBwp6tIYzwA9+S84+srYdHnPSPysk7WY01pTTFSQ9VWx/DgYqQkH+sqyx9TRECZ6
 OKeAjDueujopWwGlsYpb5MdmgTRfiYE4=
X-Gm-Gg: AeBDieuWeTwzzLnGPD4F2TlEUWIiZ3HCR2K2kq61p1hNqt7R/RL20P1CAbFeuFX7K4u
 Lgtk4QlV4L5IsUdRzROcQfh/8CB98+YcUUZhTSZuQbebP4rh8J3YhE8Mnm4rN+WIPC26DkIZIU+
 0wrkRH9P8GkL780rPP0IhDZSoKmjOROWIREgR0EPvRV+UdEadAOfNQBfiEqjrkmFV7/QJ3gnCh3
 h7xKOlB2RD5XYePnKJaegmG/si1qyheuG8sC86P216gfLztxAJWi28G4XfXQMFUvO2mzVo9msw6
 IR6BB2+kcWQFPRPDcpKN4ERO46tSteKT5S2o8B0Qj19u+ysA
X-Received: by 2002:a05:6402:1e92:b0:674:7363:3e91 with SMTP id
 4fb4d7f45d1cf-67473633f17mr11349513a12.12.1777032474263; Fri, 24 Apr 2026
 05:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212856.68734-1-philmd@linaro.org>
In-Reply-To: <20260423212856.68734-1-philmd@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 24 Apr 2026 08:07:41 -0400
X-Gm-Features: AQROBzCswIOQEz_Lzd4Z71j2ZT9UfnGBrofeCIi3b6A7Ld3jWYhjHAfYD6l389E
Message-ID: <CAJSP0QX-MyMPwatjaqMZzaLPFqH-9va4KB347V9wHDZX=TGFiw@mail.gmail.com>
Subject: Re: [PULL v3 00/52] Misc HW patches for 2026-04-22
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006204a40650339d1b"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000006204a40650339d1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 5:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> v3:
>   now than target-arm.next is merged, 3 more MAINTAINERS patches
> v2:
> Rebased on top of
>   Merge tag 's390x-20260423' of https://gitlab.com/cohuck/qemu into
> staging
> to fix:
>   CONFLICT (content): Merge conflict in include/hw/core/boards.h
>
> The following changes since commit
> e5182fd198e85cb650cdfed1839ee8aac86e0b7e:
>
>   Merge tag 'pull-11.1-virtio-gpu-hotfixes-230426-1' of
> https://gitlab.com/stsquad/qemu into staging (2026-04-23 13:52:08 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260422
>
> for you to fetch changes up to 5d6beec09b2e41a73b3a299870865ebb31572857:
>
>   MAINTAINERS: Transfer CI maintenance to Pierrick (2026-04-23 23:26:39
> +0200)
>
> ----------------------------------------------------------------
> Misc HW patches
>
> - Build hw/avr/ as common unit files
> - Header cleanups around 'cpu.h', 'qemu/audio.h' or duplicated lines
> - Remove obsolete TPMIfClass::ppi_enabled field
> - Cleanups around load/store API
> - Restrict 'compat' properties API to system emulation
> - Correct TPM PPCI ACPI for Windows guests on ARM Virt machine
> - Simplify physical_memory_range_includes_clean()
> - Avoid including CONFIG_DEVICES in hw/arm/smmuv3
> - Initialize bus frequency in PPC e500 device tree blob
> - More ATI VGA fixes
> - Fix fuzzing issues on AVR power controller and SH4 MCU
> - MAINTAINERS updates
>
> ----------------------------------------------------------------
>

This pull request breaks run-tcg-tests-riscv64-linux-user:

$ ./configure --target-list=3Driscv64-linux-user && make check-tcg
...
  BUILD   debian-all-test-cross
  BUILD   riscv64-linux-user guest-tests
  RUN     riscv64-linux-user guest-tests
  TEST    semihosting on riscv64
  SKIPPED semiconsole on riscv64 because MANUAL ONLY
  TEST    catch-syscalls on riscv64
  TEST    convd on riscv64
  TEST    convs on riscv64
  TEST    madds on riscv64
  TEST    fnmsub on riscv64
  TEST    late-attach on riscv64
  TEST    follow-fork-mode on riscv64
  TEST    munmap-pthread on riscv64
  TEST    overflow on riscv64
  TEST    prot-none on riscv64
  TEST    segfault on riscv64
  SKIPPED float_convs check on riscv64 because no reference
  TEST    sha1 on riscv64
  SKIPPED float_convd check on riscv64 because no reference
  TEST    sha512 on riscv64
  SKIPPED float_madds check on riscv64 because no reference
  TEST    sigbus on riscv64
  TEST    signals on riscv64
  TEST    sigreturn-sigmask on riscv64
  TEST    tb-link on riscv64
  TEST    test-mmap (default) on riscv64
  TEST    testthread on riscv64
  TEST    threadcount on riscv64
  TEST    vma-pthread on riscv64
  TEST    linux-madvise on riscv64
  TEST    linux-shmat-maps on riscv64
  TEST    linux-shmat-null on riscv64
  TEST    linux-sigrtminmax on riscv64
  TEST    linux-test on riscv64
  TEST    test-vma on riscv64
  TEST    test-div on riscv64
  TEST    noexec on riscv64
  TEST    test-noc on riscv64
make[1]: *** [Makefile:223: run-test-noc] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [/home/stefanha/qemu/tests/Makefile.include:68:
run-tcg-tests-riscv64-linux-user] Error 2

Please send a v4 that resolves the test-noc failure. Thanks!

Stefan


>
> Bin Guo (1):
>   physmem: Simplify dirty memory type checks with loop
>
> Junjie Cao (2):
>   ati-vga: fix unsigned integer overflow in cursor bounds checks
>   ati-vga: mask out lock bit from CUR_OFFSET in cursor offset
>     calculation
>
> Mohammadfaiz Bawa (3):
>   docs/specs/tpm: document PPI support on ARM64 virt
>   hw/acpi/tpm: parameterize PPI base address in tpm_build_ppi_acpi
>   hw/tpm: add PPI support to tpm-tis-device for ARM64 virt
>
> Osama Abdelkader (3):
>   hw/virtio/virtio-iommu: remove duplicate include
>   hw/hyperv: remove duplicate include
>   hw/ppc/amigaone: remove duplicate include
>
> Peter Maydell (1):
>   hw/arm, hw/ppc: Remove unnecessary audio.h includes from board code
>
> Philippe Mathieu-Daud=C3=A9 (39):
>   hw/avr: Build as common unit files
>   hw/misc/cpc: Include missing 'hw/core/cpu.h' header
>   hw/alpha: Include full path to target 'cpu.h' header
>   hw/arm: Include full path to target 'cpu.h' header
>   hw/avr: Include full path to target 'cpu.h' header
>   hw/hppa: Include full path to target 'cpu.h' header
>   hw/i386: Include full path to target 'cpu.h' header
>   hw/m68k: Include full path to target 'cpu.h' header
>   hw/microblaze: Include full path to target 'cpu.h' header
>   hw/mips: Include full path to target 'cpu.h' header
>   hw/or1k: Include full path to target 'cpu.h' header
>   hw/ppc: Include full path to target 'cpu.h' header
>   hw/riscv: Include full path to target 'cpu.h' header
>   hw/s390x: Include full path to target 'cpu.h' header
>   hw/sh4: Include full path to target 'cpu.h' header
>   hw/sparc: Include full path to target 'cpu.h' header
>   hw/tricore: Include full path to target 'cpu.h' header
>   hw/xtensa: Include full path to target 'cpu.h' header
>   hw/tpm: Factor tpm_ppi_enabled() out
>   hw/tpm: Add TPMIfClass::ppi_enabled field
>   hw/tpm: Remove CRBState::ppi_enabled field
>   hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
>     TPMState
>   hw/tpm: Simplify tpm_ppi_enabled()
>   hw/ppc/spapr: Un-inline rtas_load/store() helpers
>   hw/hyperv: Replace legacy ld_phys() -> address_space_ld()
>   system/memory: Constify various AddressSpace arguments (flatview)
>   hw/core: Move compat_props_add() to 'hw/core/boards.h'
>   qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
>   qom: Declare compat properties API in 'qom/compat-properties.h'
>   qom: Restrict compat properties API to system emulation
>   hw/arm/smmuv3: Have smmuv3_accel_init() take an Error* parameter
>   hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/ header
>   MAINTAINERS: Merge PCIe DOE section within SPDM
>   MAINTAINERS: Cover hexloader tests under the Generic Loader section
>   MAINTAINERS: Remove my unused git tree locations
>   MAINTAINERS: Remove my disfunctional emails
>   MAINTAINERS: Remove PhilMD from NVMe Block Driver
>   MAINTAINERS: Maintain MIPS Boston
>   MAINTAINERS: Transfer CI maintenance to Pierrick
>
> Thomas Huth (2):
>   hw/misc: Fix the valid access size to the avr-power device
>   hw/sh4/sh7750: Remove forgotten abort() in the MM_ITLB_DATA handler
>
> Vivien LEGER (1):
>   hw/ppc/e500: fix bus-frequency property hardcoded to zero in CPU FDT
>     node
>
>  MAINTAINERS                                 |  28 ++---
>  docs/specs/tpm.rst                          |  24 ++++
>  hw/arm/smmuv3-accel.h                       |  41 +------
>  hw/avr/boot.h                               |   2 +-
>  hw/ppc/e500.h                               |   1 +
>  hw/s390x/ipl.h                              |   2 +-
>  hw/s390x/s390-hypercall.h                   |   2 +-
>  hw/sd/sdmmc-internal.h                      |   2 +-
>  hw/tpm/tpm_tis.h                            |   3 +-
>  hw/xtensa/xtensa_memory.h                   |   2 +-
>  include/crypto/tls-cipher-suites.h          |   2 +-
>  include/hw/acpi/tpm.h                       |   3 +-
>  include/hw/arm/digic.h                      |   2 +-
>  include/hw/arm/fsl-imx6.h                   |   2 +-
>  include/hw/arm/fsl-imx6ul.h                 |   2 +-
>  include/hw/arm/fsl-imx7.h                   |   2 +-
>  include/hw/arm/fsl-imx8mp.h                 |   2 +-
>  include/hw/core/boards.h                    |  11 ++
>  include/hw/core/qdev-properties.h           |   1 +
>  include/hw/core/qdev.h                      |  27 -----
>  include/hw/i2c/arm_sbcon_i2c.h              |   2 +-
>  include/hw/i386/apic_internal.h             |   2 +-
>  include/hw/intc/mips_gic.h                  |   2 +-
>  include/hw/misc/bcm2835_thermal.h           |   2 +-
>  include/hw/misc/led.h                       |   2 +-
>  include/hw/ppc/pnv.h                        |   2 +-
>  include/hw/ppc/spapr.h                      |  18 +--
>  include/hw/ppc/spapr_fadump.h               |   2 +-
>  include/hw/timer/bcm2835_systmr.h           |   2 +-
>  include/qemu/units.h                        |   2 +-
>  include/qom/compat-properties.h             |  40 +++++++
>  include/qom/object.h                        |   8 --
>  include/system/memory.h                     |   2 +-
>  include/system/tpm.h                        |   9 ++
>  system/memory-internal.h                    |   5 +-
>  accel/accel-system.c                        |   1 +
>  backends/hostmem.c                          |   1 +
>  crypto/tls-cipher-suites.c                  |   2 +-
>  hw/acpi/tpm.c                               |  10 +-
>  hw/alpha/dp264.c                            |   2 +-
>  hw/alpha/typhoon.c                          |   2 +-
>  hw/arm/boot.c                               |   2 +-
>  hw/arm/exynos4210.c                         |   2 +-
>  hw/arm/integratorcp.c                       |   1 -
>  hw/arm/mps3r.c                              |   2 +-
>  hw/arm/musicpal.c                           |   1 -
>  hw/arm/omap1.c                              |   2 +-
>  hw/arm/realview.c                           |   3 +-
>  hw/arm/smmuv3-accel-stubs.c                 |  52 +++++++++
>  hw/arm/smmuv3-accel.c                       |   3 +-
>  hw/arm/smmuv3.c                             |  13 +--
>  hw/arm/versatilepb.c                        |   1 -
>  hw/arm/vexpress.c                           |   1 -
>  hw/arm/virt-acpi-build.c                    |   9 +-
>  hw/arm/xlnx-zcu102.c                        |   1 -
>  hw/core/machine.c                           |   1 +
>  hw/core/qdev-properties.c                   |   1 +
>  hw/core/qdev.c                              |   1 +
>  hw/display/ati.c                            |  12 +-
>  hw/hppa/machine.c                           |   2 +-
>  hw/hyperv/hyperv.c                          |   6 +-
>  hw/hyperv/vmbus.c                           |   1 -
>  hw/i386/acpi-build.c                        |   4 +-
>  hw/i386/fw_cfg.c                            |   2 +-
>  hw/i386/multiboot.c                         |   2 +-
>  hw/i386/pc_q35.c                            |   1 +
>  hw/i386/pc_sysfw_ovmf-stubs.c               |   2 +-
>  hw/i386/pc_sysfw_ovmf.c                     |   2 +-
>  hw/i386/vmmouse.c                           |   2 +-
>  hw/intc/arm_gicv3_cpuif.c                   |   2 +-
>  hw/intc/arm_gicv3_cpuif_common.c            |   2 +-
>  hw/intc/m68k_irqc.c                         |   2 +-
>  hw/intc/sh_intc.c                           |   2 +-
>  hw/isa/lpc_ich9.c                           |   2 +-
>  hw/m68k/an5206.c                            |   2 +-
>  hw/m68k/mcf5206.c                           |   2 +-
>  hw/m68k/mcf5208.c                           |   2 +-
>  hw/m68k/mcf_intc.c                          |   2 +-
>  hw/m68k/q800-glue.c                         |   2 +-
>  hw/m68k/q800.c                              |   2 +-
>  hw/m68k/virt.c                              |   2 +-
>  hw/microblaze/boot.c                        |   2 +-
>  hw/microblaze/petalogix_ml605_mmu.c         |   2 +-
>  hw/microblaze/petalogix_s3adsp1800_mmu.c    |   2 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c             |   2 +-
>  hw/mips/bootloader.c                        |   2 +-
>  hw/mips/fuloong2e.c                         |   2 +-
>  hw/mips/jazz.c                              |   2 +-
>  hw/mips/malta.c                             |   2 +-
>  hw/misc/avr_power.c                         |   3 +
>  hw/misc/bcm2835_thermal.c                   |   2 +-
>  hw/misc/led.c                               |   2 +-
>  hw/misc/mips_cpc.c                          |   3 +-
>  hw/misc/riscv_cmgcr.c                       |   2 +-
>  hw/misc/riscv_cpc.c                         |   3 +-
>  hw/or1k/boot.c                              |   2 +-
>  hw/or1k/cputimer.c                          |   2 +-
>  hw/or1k/or1k-sim.c                          |   2 +-
>  hw/or1k/virt.c                              |   2 +-
>  hw/ppc/amigaone.c                           |   1 -
>  hw/ppc/e500.c                               |   2 +-
>  hw/ppc/e500plat.c                           |   1 +
>  hw/ppc/fw_cfg.c                             |   2 +-
>  hw/ppc/mpc8544_guts.c                       |   2 +-
>  hw/ppc/mpc8544ds.c                          |   3 +-
>  hw/ppc/ppc440_uc.c                          |   2 +-
>  hw/ppc/ppc4xx_devs.c                        |   2 +-
>  hw/ppc/ppc_booke.c                          |   2 +-
>  hw/ppc/prep.c                               |   1 -
>  hw/ppc/prep_systemio.c                      |   2 +-
>  hw/ppc/spapr_rtas.c                         |  15 +++
>  hw/ppc/spapr_vhyp_mmu.c                     |   2 +-
>  hw/ppc/virtex_ml507.c                       |   2 +-
>  hw/riscv/microblaze-v-generic.c             |   2 +-
>  hw/s390x/ap-bridge.c                        |   2 +-
>  hw/s390x/s390-hypercall.c                   |   2 +-
>  hw/s390x/s390-stattrib.c                    |   2 +-
>  hw/s390x/tod-tcg.c                          |   2 +-
>  hw/sd/sd.c                                  |   2 +-
>  hw/sh4/r2d.c                                |   2 +-
>  hw/sh4/sh7750.c                             |   1 -
>  hw/sparc/leon3.c                            |   2 +-
>  hw/sparc/sun4m.c                            |   2 +-
>  hw/sparc64/niagara.c                        |   2 +-
>  hw/sparc64/sparc64.c                        |   2 +-
>  hw/sparc64/sun4u.c                          |   2 +-
>  hw/timer/bcm2835_systmr.c                   |   2 +-
>  hw/tpm/tpm_crb.c                            |  13 +--
>  hw/tpm/tpm_tis_common.c                     |   4 +-
>  hw/tpm/tpm_tis_i2c.c                        |   2 +-
>  hw/tpm/tpm_tis_isa.c                        |  12 +-
>  hw/tpm/tpm_tis_sysbus.c                     |  13 ++-
>  hw/tricore/tricore_testboard.c              |   2 +-
>  hw/usb/bus-stub.c                           |   2 +-
>  hw/virtio/virtio-iommu.c                    |   1 -
>  hw/xtensa/pic_cpu.c                         |   2 +-
>  hw/xtensa/xtfpga.c                          |   2 +-
>  qom/compat-properties.c                     | 116 ++++++++++++++++++++
>  qom/object.c                                | 102 +----------------
>  stubs/fw_cfg.c                              |   2 +-
>  stubs/hotplug-stubs.c                       |   2 +-
>  stubs/qdev.c                                |   2 +-
>  stubs/qom-compat-properties.c               |  20 ++++
>  system/memory.c                             |   2 +-
>  system/physmem.c                            |  16 +--
>  system/rtc.c                                |   1 +
>  system/vl.c                                 |   1 +
>  target/i386/sev.c                           |   1 +
>  tests/qtest/fuzz-sb16-test.c                |   2 +-
>  tests/qtest/fuzz-sdcard-test.c              |   2 +-
>  tests/qtest/sdhci-test.c                    |   2 +-
>  ui/vdagent.c                                |   1 +
>  hw/arm/meson.build                          |   5 +-
>  hw/misc/meson.build                         |   2 +-
>  hw/timer/meson.build                        |   2 +-
>  qom/meson.build                             |   3 +
>  rust/bindings/qom-sys/lib.rs                |   2 +-
>  stubs/meson.build                           |   1 +
>  tests/functional/aarch64/test_raspi3.py     |   2 +-
>  tests/functional/arm/test_bflt.py           |   2 +-
>  tests/functional/arm/test_raspi2.py         |   2 +-
>  tests/functional/m68k/test_nextcube.py      |   2 +-
>  tests/functional/mips/test_malta.py         |   2 +-
>  tests/functional/mips64el/test_fuloong2e.py |   2 +-
>  tests/functional/mips64el/test_malta.py     |   2 +-
>  tests/functional/mipsel/test_malta.py       |   2 +-
>  tests/functional/ppc/test_40p.py            |   2 +-
>  tests/functional/qemu_test/tesseract.py     |   2 +-
>  168 files changed, 507 insertions(+), 393 deletions(-)
>  create mode 100644 include/qom/compat-properties.h
>  create mode 100644 hw/arm/smmuv3-accel-stubs.c
>  create mode 100644 qom/compat-properties.c
>  create mode 100644 stubs/qom-compat-properties.c
>
> --
> 2.53.0
>
>
>

--0000000000006204a40650339d1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFp
bmVyIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVGh1LCBBcHIgMjMsIDIw
MjYgYXQgNTozMOKAr1BNIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVmPSJtYWls
dG86cGhpbG1kQGxpbmFyby5vcmciPnBoaWxtZEBsaW5hcm8ub3JnPC9hPiZndDsgd3JvdGU6PGJy
PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij52Mzo8YnI+DQrCoCBub3cgdGhhbiB0YXJnZXQtYXJtLm5leHQgaXMgbWVy
Z2VkLCAzIG1vcmUgTUFJTlRBSU5FUlMgcGF0Y2hlczxicj4NCnYyOjxicj4NClJlYmFzZWQgb24g
dG9wIG9mPGJyPg0KwqAgTWVyZ2UgdGFnICYjMzk7czM5MHgtMjAyNjA0MjMmIzM5OyBvZiA8YSBo
cmVmPSJodHRwczovL2dpdGxhYi5jb20vY29odWNrL3FlbXUiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0bGFiLmNvbS9jb2h1Y2svcWVtdTwvYT4gaW50byBzdGFn
aW5nPGJyPg0KdG8gZml4Ojxicj4NCsKgIENPTkZMSUNUIChjb250ZW50KTogTWVyZ2UgY29uZmxp
Y3QgaW4gaW5jbHVkZS9ody9jb3JlL2JvYXJkcy5oPGJyPg0KPGJyPg0KVGhlIGZvbGxvd2luZyBj
aGFuZ2VzIHNpbmNlIGNvbW1pdCBlNTE4MmZkMTk4ZTg1Y2I2NTBjZGZlZDE4MzllZThhYWM4NmUw
YjdlOjxicj4NCjxicj4NCsKgIE1lcmdlIHRhZyAmIzM5O3B1bGwtMTEuMS12aXJ0aW8tZ3B1LWhv
dGZpeGVzLTIzMDQyNi0xJiMzOTsgb2YgPGEgaHJlZj0iaHR0cHM6Ly9naXRsYWIuY29tL3N0c3F1
YWQvcWVtdSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRsYWIu
Y29tL3N0c3F1YWQvcWVtdTwvYT4gaW50byBzdGFnaW5nICgyMDI2LTA0LTIzIDEzOjUyOjA4IC0w
NDAwKTxicj4NCjxicj4NCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Ojxi
cj4NCjxicj4NCsKgIDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9waGlsbWQvcWVtdS5naXQi
IHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9waGls
bWQvcWVtdS5naXQ8L2E+IHRhZ3MvaHctbWlzYy0yMDI2MDQyMjxicj4NCjxicj4NCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA1ZDZiZWVjMDliMmU0MWE3M2IzYTI5OTg3MDg2NWViYjMx
NTcyODU3Ojxicj4NCjxicj4NCsKgIE1BSU5UQUlORVJTOiBUcmFuc2ZlciBDSSBtYWludGVuYW5j
ZSB0byBQaWVycmljayAoMjAyNi0wNC0yMyAyMzoyNjozOSArMDIwMCk8YnI+DQo8YnI+DQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPGJyPg0KTWlzYyBIVyBwYXRjaGVzPGJyPg0KPGJyPg0KLSBCdWlsZCBody9hdnIvIGFzIGNv
bW1vbiB1bml0IGZpbGVzPGJyPg0KLSBIZWFkZXIgY2xlYW51cHMgYXJvdW5kICYjMzk7Y3B1Lmgm
IzM5OywgJiMzOTtxZW11L2F1ZGlvLmgmIzM5OyBvciBkdXBsaWNhdGVkIGxpbmVzPGJyPg0KLSBS
ZW1vdmUgb2Jzb2xldGUgVFBNSWZDbGFzczo6cHBpX2VuYWJsZWQgZmllbGQ8YnI+DQotIENsZWFu
dXBzIGFyb3VuZCBsb2FkL3N0b3JlIEFQSTxicj4NCi0gUmVzdHJpY3QgJiMzOTtjb21wYXQmIzM5
OyBwcm9wZXJ0aWVzIEFQSSB0byBzeXN0ZW0gZW11bGF0aW9uPGJyPg0KLSBDb3JyZWN0IFRQTSBQ
UENJIEFDUEkgZm9yIFdpbmRvd3MgZ3Vlc3RzIG9uIEFSTSBWaXJ0IG1hY2hpbmU8YnI+DQotIFNp
bXBsaWZ5IHBoeXNpY2FsX21lbW9yeV9yYW5nZV9pbmNsdWRlc19jbGVhbigpPGJyPg0KLSBBdm9p
ZCBpbmNsdWRpbmcgQ09ORklHX0RFVklDRVMgaW4gaHcvYXJtL3NtbXV2Mzxicj4NCi0gSW5pdGlh
bGl6ZSBidXMgZnJlcXVlbmN5IGluIFBQQyBlNTAwIGRldmljZSB0cmVlIGJsb2I8YnI+DQotIE1v
cmUgQVRJIFZHQSBmaXhlczxicj4NCi0gRml4IGZ1enppbmcgaXNzdWVzIG9uIEFWUiBwb3dlciBj
b250cm9sbGVyIGFuZCBTSDQgTUNVPGJyPg0KLSBNQUlOVEFJTkVSUyB1cGRhdGVzPGJyPg0KPGJy
Pg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLTxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGlzIHB1bGwg
cmVxdWVzdCBicmVha3PCoHJ1bi10Y2ctdGVzdHMtcmlzY3Y2NC1saW51eC11c2VyOjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+JMKgLi9jb25maWd1cmUgLS10YXJnZXQtbGlzdD1yaXNjdjY0LWxp
bnV4LXVzZXIgJmFtcDsmYW1wOyBtYWtlIGNoZWNrLXRjZzwvZGl2PjxkaXY+Li4uPC9kaXY+PGRp
dj7CoCBCVUlMRCDCoCBkZWJpYW4tYWxsLXRlc3QtY3Jvc3M8YnI+wqAgQlVJTEQgwqAgcmlzY3Y2
NC1saW51eC11c2VyIGd1ZXN0LXRlc3RzPGJyPsKgIFJVTiDCoCDCoCByaXNjdjY0LWxpbnV4LXVz
ZXIgZ3Vlc3QtdGVzdHM8YnI+wqAgVEVTVCDCoCDCoHNlbWlob3N0aW5nIG9uIHJpc2N2NjQ8YnI+
wqAgU0tJUFBFRCBzZW1pY29uc29sZSBvbiByaXNjdjY0IGJlY2F1c2UgTUFOVUFMIE9OTFk8YnI+
wqAgVEVTVCDCoCDCoGNhdGNoLXN5c2NhbGxzIG9uIHJpc2N2NjQ8YnI+wqAgVEVTVCDCoCDCoGNv
bnZkIG9uIHJpc2N2NjQ8YnI+wqAgVEVTVCDCoCDCoGNvbnZzIG9uIHJpc2N2NjQ8YnI+wqAgVEVT
VCDCoCDCoG1hZGRzIG9uIHJpc2N2NjQ8YnI+wqAgVEVTVCDCoCDCoGZubXN1YiBvbiByaXNjdjY0
PGJyPsKgIFRFU1QgwqAgwqBsYXRlLWF0dGFjaCBvbiByaXNjdjY0PGJyPsKgIFRFU1QgwqAgwqBm
b2xsb3ctZm9yay1tb2RlIG9uIHJpc2N2NjQ8YnI+wqAgVEVTVCDCoCDCoG11bm1hcC1wdGhyZWFk
IG9uIHJpc2N2NjQ8YnI+wqAgVEVTVCDCoCDCoG92ZXJmbG93IG9uIHJpc2N2NjQ8YnI+wqAgVEVT
VCDCoCDCoHByb3Qtbm9uZSBvbiByaXNjdjY0PGJyPsKgIFRFU1QgwqAgwqBzZWdmYXVsdCBvbiBy
aXNjdjY0PGJyPsKgIFNLSVBQRUQgZmxvYXRfY29udnMgY2hlY2sgb24gcmlzY3Y2NCBiZWNhdXNl
IG5vIHJlZmVyZW5jZTxicj7CoCBURVNUIMKgIMKgc2hhMSBvbiByaXNjdjY0PGJyPsKgIFNLSVBQ
RUQgZmxvYXRfY29udmQgY2hlY2sgb24gcmlzY3Y2NCBiZWNhdXNlIG5vIHJlZmVyZW5jZTxicj7C
oCBURVNUIMKgIMKgc2hhNTEyIG9uIHJpc2N2NjQ8YnI+wqAgU0tJUFBFRCBmbG9hdF9tYWRkcyBj
aGVjayBvbiByaXNjdjY0IGJlY2F1c2Ugbm8gcmVmZXJlbmNlPGJyPsKgIFRFU1QgwqAgwqBzaWdi
dXMgb24gcmlzY3Y2NDxicj7CoCBURVNUIMKgIMKgc2lnbmFscyBvbiByaXNjdjY0PGJyPsKgIFRF
U1QgwqAgwqBzaWdyZXR1cm4tc2lnbWFzayBvbiByaXNjdjY0PGJyPsKgIFRFU1QgwqAgwqB0Yi1s
aW5rIG9uIHJpc2N2NjQ8YnI+wqAgVEVTVCDCoCDCoHRlc3QtbW1hcCAoZGVmYXVsdCkgb24gcmlz
Y3Y2NDxicj7CoCBURVNUIMKgIMKgdGVzdHRocmVhZCBvbiByaXNjdjY0PGJyPsKgIFRFU1QgwqAg
wqB0aHJlYWRjb3VudCBvbiByaXNjdjY0PGJyPsKgIFRFU1QgwqAgwqB2bWEtcHRocmVhZCBvbiBy
aXNjdjY0PGJyPsKgIFRFU1QgwqAgwqBsaW51eC1tYWR2aXNlIG9uIHJpc2N2NjQ8YnI+wqAgVEVT
VCDCoCDCoGxpbnV4LXNobWF0LW1hcHMgb24gcmlzY3Y2NDxicj7CoCBURVNUIMKgIMKgbGludXgt
c2htYXQtbnVsbCBvbiByaXNjdjY0PGJyPsKgIFRFU1QgwqAgwqBsaW51eC1zaWdydG1pbm1heCBv
biByaXNjdjY0PGJyPsKgIFRFU1QgwqAgwqBsaW51eC10ZXN0IG9uIHJpc2N2NjQ8YnI+wqAgVEVT
VCDCoCDCoHRlc3Qtdm1hIG9uIHJpc2N2NjQ8YnI+wqAgVEVTVCDCoCDCoHRlc3QtZGl2IG9uIHJp
c2N2NjQ8YnI+wqAgVEVTVCDCoCDCoG5vZXhlYyBvbiByaXNjdjY0PGJyPsKgIFRFU1QgwqAgwqB0
ZXN0LW5vYyBvbiByaXNjdjY0PGJyPm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjIzOiBydW4tdGVz
dC1ub2NdIEVycm9yIDE8YnI+bWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi48YnI+bWFrZTogKioqIFsvaG9tZS9zdGVmYW5oYS9xZW11L3Rlc3RzL01ha2VmaWxlLmlu
Y2x1ZGU6Njg6IHJ1bi10Y2ctdGVzdHMtcmlzY3Y2NC1saW51eC11c2VyXSBFcnJvciAyPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2Ugc2VuZCBhIHY0IHRoYXQgcmVzb2x2ZXMgdGhlIHRl
c3Qtbm9jIGZhaWx1cmUuIFRoYW5rcyE8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlN0ZWZhbjwv
ZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0
LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+DQo8YnI+DQpCaW4gR3VvICgxKTo8YnI+DQrCoCBwaHlz
bWVtOiBTaW1wbGlmeSBkaXJ0eSBtZW1vcnkgdHlwZSBjaGVja3Mgd2l0aCBsb29wPGJyPg0KPGJy
Pg0KSnVuamllIENhbyAoMik6PGJyPg0KwqAgYXRpLXZnYTogZml4IHVuc2lnbmVkIGludGVnZXIg
b3ZlcmZsb3cgaW4gY3Vyc29yIGJvdW5kcyBjaGVja3M8YnI+DQrCoCBhdGktdmdhOiBtYXNrIG91
dCBsb2NrIGJpdCBmcm9tIENVUl9PRkZTRVQgaW4gY3Vyc29yIG9mZnNldDxicj4NCsKgIMKgIGNh
bGN1bGF0aW9uPGJyPg0KPGJyPg0KTW9oYW1tYWRmYWl6IEJhd2EgKDMpOjxicj4NCsKgIGRvY3Mv
c3BlY3MvdHBtOiBkb2N1bWVudCBQUEkgc3VwcG9ydCBvbiBBUk02NCB2aXJ0PGJyPg0KwqAgaHcv
YWNwaS90cG06IHBhcmFtZXRlcml6ZSBQUEkgYmFzZSBhZGRyZXNzIGluIHRwbV9idWlsZF9wcGlf
YWNwaTxicj4NCsKgIGh3L3RwbTogYWRkIFBQSSBzdXBwb3J0IHRvIHRwbS10aXMtZGV2aWNlIGZv
ciBBUk02NCB2aXJ0PGJyPg0KPGJyPg0KT3NhbWEgQWJkZWxrYWRlciAoMyk6PGJyPg0KwqAgaHcv
dmlydGlvL3ZpcnRpby1pb21tdTogcmVtb3ZlIGR1cGxpY2F0ZSBpbmNsdWRlPGJyPg0KwqAgaHcv
aHlwZXJ2OiByZW1vdmUgZHVwbGljYXRlIGluY2x1ZGU8YnI+DQrCoCBody9wcGMvYW1pZ2FvbmU6
IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZTxicj4NCjxicj4NClBldGVyIE1heWRlbGwgKDEpOjxi
cj4NCsKgIGh3L2FybSwgaHcvcHBjOiBSZW1vdmUgdW5uZWNlc3NhcnkgYXVkaW8uaCBpbmNsdWRl
cyBmcm9tIGJvYXJkIGNvZGU8YnI+DQo8YnI+DQpQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAoMzkp
Ojxicj4NCsKgIGh3L2F2cjogQnVpbGQgYXMgY29tbW9uIHVuaXQgZmlsZXM8YnI+DQrCoCBody9t
aXNjL2NwYzogSW5jbHVkZSBtaXNzaW5nICYjMzk7aHcvY29yZS9jcHUuaCYjMzk7IGhlYWRlcjxi
cj4NCsKgIGh3L2FscGhhOiBJbmNsdWRlIGZ1bGwgcGF0aCB0byB0YXJnZXQgJiMzOTtjcHUuaCYj
Mzk7IGhlYWRlcjxicj4NCsKgIGh3L2FybTogSW5jbHVkZSBmdWxsIHBhdGggdG8gdGFyZ2V0ICYj
Mzk7Y3B1LmgmIzM5OyBoZWFkZXI8YnI+DQrCoCBody9hdnI6IEluY2x1ZGUgZnVsbCBwYXRoIHRv
IHRhcmdldCAmIzM5O2NwdS5oJiMzOTsgaGVhZGVyPGJyPg0KwqAgaHcvaHBwYTogSW5jbHVkZSBm
dWxsIHBhdGggdG8gdGFyZ2V0ICYjMzk7Y3B1LmgmIzM5OyBoZWFkZXI8YnI+DQrCoCBody9pMzg2
OiBJbmNsdWRlIGZ1bGwgcGF0aCB0byB0YXJnZXQgJiMzOTtjcHUuaCYjMzk7IGhlYWRlcjxicj4N
CsKgIGh3L202OGs6IEluY2x1ZGUgZnVsbCBwYXRoIHRvIHRhcmdldCAmIzM5O2NwdS5oJiMzOTsg
aGVhZGVyPGJyPg0KwqAgaHcvbWljcm9ibGF6ZTogSW5jbHVkZSBmdWxsIHBhdGggdG8gdGFyZ2V0
ICYjMzk7Y3B1LmgmIzM5OyBoZWFkZXI8YnI+DQrCoCBody9taXBzOiBJbmNsdWRlIGZ1bGwgcGF0
aCB0byB0YXJnZXQgJiMzOTtjcHUuaCYjMzk7IGhlYWRlcjxicj4NCsKgIGh3L29yMWs6IEluY2x1
ZGUgZnVsbCBwYXRoIHRvIHRhcmdldCAmIzM5O2NwdS5oJiMzOTsgaGVhZGVyPGJyPg0KwqAgaHcv
cHBjOiBJbmNsdWRlIGZ1bGwgcGF0aCB0byB0YXJnZXQgJiMzOTtjcHUuaCYjMzk7IGhlYWRlcjxi
cj4NCsKgIGh3L3Jpc2N2OiBJbmNsdWRlIGZ1bGwgcGF0aCB0byB0YXJnZXQgJiMzOTtjcHUuaCYj
Mzk7IGhlYWRlcjxicj4NCsKgIGh3L3MzOTB4OiBJbmNsdWRlIGZ1bGwgcGF0aCB0byB0YXJnZXQg
JiMzOTtjcHUuaCYjMzk7IGhlYWRlcjxicj4NCsKgIGh3L3NoNDogSW5jbHVkZSBmdWxsIHBhdGgg
dG8gdGFyZ2V0ICYjMzk7Y3B1LmgmIzM5OyBoZWFkZXI8YnI+DQrCoCBody9zcGFyYzogSW5jbHVk
ZSBmdWxsIHBhdGggdG8gdGFyZ2V0ICYjMzk7Y3B1LmgmIzM5OyBoZWFkZXI8YnI+DQrCoCBody90
cmljb3JlOiBJbmNsdWRlIGZ1bGwgcGF0aCB0byB0YXJnZXQgJiMzOTtjcHUuaCYjMzk7IGhlYWRl
cjxicj4NCsKgIGh3L3h0ZW5zYTogSW5jbHVkZSBmdWxsIHBhdGggdG8gdGFyZ2V0ICYjMzk7Y3B1
LmgmIzM5OyBoZWFkZXI8YnI+DQrCoCBody90cG06IEZhY3RvciB0cG1fcHBpX2VuYWJsZWQoKSBv
dXQ8YnI+DQrCoCBody90cG06IEFkZCBUUE1JZkNsYXNzOjpwcGlfZW5hYmxlZCBmaWVsZDxicj4N
CsKgIGh3L3RwbTogUmVtb3ZlIENSQlN0YXRlOjpwcGlfZW5hYmxlZCBmaWVsZDxicj4NCsKgIGh3
L3RwbTogUHJvcGFnYXRlIEBwcGlfZW5hYmxlZCB0byB0cG1fdGlzX3Jlc2V0KCkgYW5kIHJlbW92
ZSBpbjxicj4NCsKgIMKgIFRQTVN0YXRlPGJyPg0KwqAgaHcvdHBtOiBTaW1wbGlmeSB0cG1fcHBp
X2VuYWJsZWQoKTxicj4NCsKgIGh3L3BwYy9zcGFwcjogVW4taW5saW5lIHJ0YXNfbG9hZC9zdG9y
ZSgpIGhlbHBlcnM8YnI+DQrCoCBody9oeXBlcnY6IFJlcGxhY2UgbGVnYWN5IGxkX3BoeXMoKSAt
Jmd0OyBhZGRyZXNzX3NwYWNlX2xkKCk8YnI+DQrCoCBzeXN0ZW0vbWVtb3J5OiBDb25zdGlmeSB2
YXJpb3VzIEFkZHJlc3NTcGFjZSBhcmd1bWVudHMgKGZsYXR2aWV3KTxicj4NCsKgIGh3L2NvcmU6
IE1vdmUgY29tcGF0X3Byb3BzX2FkZCgpIHRvICYjMzk7aHcvY29yZS9ib2FyZHMuaCYjMzk7PGJy
Pg0KwqAgcW9tOiBEZWNsYXJlIEdsb2JhbFByb3BlcnR5IHN0cnVjdHVyZSBpbiAmIzM5O3FvbS9j
b21wYXQtcHJvcGVydGllcy5oJiMzOTs8YnI+DQrCoCBxb206IERlY2xhcmUgY29tcGF0IHByb3Bl
cnRpZXMgQVBJIGluICYjMzk7cW9tL2NvbXBhdC1wcm9wZXJ0aWVzLmgmIzM5Ozxicj4NCsKgIHFv
bTogUmVzdHJpY3QgY29tcGF0IHByb3BlcnRpZXMgQVBJIHRvIHN5c3RlbSBlbXVsYXRpb248YnI+
DQrCoCBody9hcm0vc21tdXYzOiBIYXZlIHNtbXV2M19hY2NlbF9pbml0KCkgdGFrZSBhbiBFcnJv
ciogcGFyYW1ldGVyPGJyPg0KwqAgaHcvYXJtL3NtbXV2MzogQXZvaWQgaW5jbHVkaW5nIENPTkZJ
R19ERVZJQ0VTIGluIGh3LyBoZWFkZXI8YnI+DQrCoCBNQUlOVEFJTkVSUzogTWVyZ2UgUENJZSBE
T0Ugc2VjdGlvbiB3aXRoaW4gU1BETTxicj4NCsKgIE1BSU5UQUlORVJTOiBDb3ZlciBoZXhsb2Fk
ZXIgdGVzdHMgdW5kZXIgdGhlIEdlbmVyaWMgTG9hZGVyIHNlY3Rpb248YnI+DQrCoCBNQUlOVEFJ
TkVSUzogUmVtb3ZlIG15IHVudXNlZCBnaXQgdHJlZSBsb2NhdGlvbnM8YnI+DQrCoCBNQUlOVEFJ
TkVSUzogUmVtb3ZlIG15IGRpc2Z1bmN0aW9uYWwgZW1haWxzPGJyPg0KwqAgTUFJTlRBSU5FUlM6
IFJlbW92ZSBQaGlsTUQgZnJvbSBOVk1lIEJsb2NrIERyaXZlcjxicj4NCsKgIE1BSU5UQUlORVJT
OiBNYWludGFpbiBNSVBTIEJvc3Rvbjxicj4NCsKgIE1BSU5UQUlORVJTOiBUcmFuc2ZlciBDSSBt
YWludGVuYW5jZSB0byBQaWVycmljazxicj4NCjxicj4NClRob21hcyBIdXRoICgyKTo8YnI+DQrC
oCBody9taXNjOiBGaXggdGhlIHZhbGlkIGFjY2VzcyBzaXplIHRvIHRoZSBhdnItcG93ZXIgZGV2
aWNlPGJyPg0KwqAgaHcvc2g0L3NoNzc1MDogUmVtb3ZlIGZvcmdvdHRlbiBhYm9ydCgpIGluIHRo
ZSBNTV9JVExCX0RBVEEgaGFuZGxlcjxicj4NCjxicj4NClZpdmllbiBMRUdFUiAoMSk6PGJyPg0K
wqAgaHcvcHBjL2U1MDA6IGZpeCBidXMtZnJlcXVlbmN5IHByb3BlcnR5IGhhcmRjb2RlZCB0byB6
ZXJvIGluIENQVSBGRFQ8YnI+DQrCoCDCoCBub2RlPGJyPg0KPGJyPg0KwqBNQUlOVEFJTkVSU8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDI4ICsr
LS0tPGJyPg0KwqBkb2NzL3NwZWNzL3RwbS5yc3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgMjQgKysrKzxicj4NCsKgaHcvYXJtL3NtbXV2My1hY2NlbC5owqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNDEgKy0tLS0tLTxicj4NCsKgaHcvYXZy
L2Jvb3QuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgMiArLTxicj4NCsKgaHcvcHBjL2U1MDAuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KwqBody9zMzkweC9pcGwuaMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3
L3MzOTB4L3MzOTAtaHlwZXJjYWxsLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDC
oDIgKy08YnI+DQrCoGh3L3NkL3NkbW1jLWludGVybmFsLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody90cG0vdHBtX3Rpcy5owqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMyArLTxicj4NCsKgaHcveHRlbnNh
L3h0ZW5zYV9tZW1vcnkuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxi
cj4NCsKgaW5jbHVkZS9jcnlwdG8vdGxzLWNpcGhlci1zdWl0ZXMuaMKgIMKgIMKgIMKgIMKgIHzC
oCDCoDIgKy08YnI+DQrCoGluY2x1ZGUvaHcvYWNwaS90cG0uaMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIMKgMyArLTxicj4NCsKgaW5jbHVkZS9ody9hcm0vZGlnaWMuaMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGluY2x1ZGUv
aHcvYXJtL2ZzbC1pbXg2LmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08
YnI+DQrCoGluY2x1ZGUvaHcvYXJtL2ZzbC1pbXg2dWwuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfMKgIMKgMiArLTxicj4NCsKgaW5jbHVkZS9ody9hcm0vZnNsLWlteDcuaMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaW5jbHVkZS9ody9hcm0vZnNsLWlt
eDhtcC5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBpbmNsdWRl
L2h3L2NvcmUvYm9hcmRzLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMTEgKys8
YnI+DQrCoGluY2x1ZGUvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaMKgIMKgIMKgIMKgIMKgIMKg
fMKgIMKgMSArPGJyPg0KwqBpbmNsdWRlL2h3L2NvcmUvcWRldi5owqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIDI3IC0tLS0tPGJyPg0KwqBpbmNsdWRlL2h3L2kyYy9hcm1fc2Jj
b25faTJjLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBpbmNsdWRlL2h3
L2kzODYvYXBpY19pbnRlcm5hbC5owqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0K
wqBpbmNsdWRlL2h3L2ludGMvbWlwc19naWMuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzC
oCDCoDIgKy08YnI+DQrCoGluY2x1ZGUvaHcvbWlzYy9iY20yODM1X3RoZXJtYWwuaMKgIMKgIMKg
IMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaW5jbHVkZS9ody9taXNjL2xlZC5owqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBpbmNsdWRlL2h3L3Bw
Yy9wbnYuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+
DQrCoGluY2x1ZGUvaHcvcHBjL3NwYXByLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8wqAgMTggKy0tPGJyPg0KwqBpbmNsdWRlL2h3L3BwYy9zcGFwcl9mYWR1bXAuaMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaW5jbHVkZS9ody90aW1lci9iY20yODM1
X3N5c3Rtci5owqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBpbmNsdWRlL3FlbXUv
dW5pdHMuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+
DQrCoGluY2x1ZGUvcW9tL2NvbXBhdC1wcm9wZXJ0aWVzLmjCoCDCoCDCoCDCoCDCoCDCoCDCoHzC
oCA0MCArKysrKysrPGJyPg0KwqBpbmNsdWRlL3FvbS9vYmplY3QuaMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDggLS08YnI+DQrCoGluY2x1ZGUvc3lzdGVtL21lbW9y
eS5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBpbmNs
dWRlL3N5c3RlbS90cG0uaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDC
oDkgKys8YnI+DQrCoHN5c3RlbS9tZW1vcnktaW50ZXJuYWwuaMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHzCoCDCoDUgKy08YnI+DQrCoGFjY2VsL2FjY2VsLXN5c3RlbS5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KwqBiYWNrZW5kcy9ob3N0
bWVtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAxICs8YnI+
DQrCoGNyeXB0by90bHMtY2lwaGVyLXN1aXRlcy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgMiArLTxicj4NCsKgaHcvYWNwaS90cG0uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDEwICstPGJyPg0KwqBody9hbHBoYS9kcDI2NC5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKg
aHcvYWxwaGEvdHlwaG9vbi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgMiArLTxicj4NCsKgaHcvYXJtL2Jvb3QuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaHcvYXJtL2V4eW5vczQyMTAu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKg
aHcvYXJtL2ludGVncmF0b3JjcC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8
wqAgwqAxIC08YnI+DQrCoGh3L2FybS9tcHMzci5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvYXJtL211c2ljcGFsLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgLTxicj4NCsKgaHcv
YXJtL29tYXAxLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8
wqAgwqAyICstPGJyPg0KwqBody9hcm0vcmVhbHZpZXcuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMyArLTxicj4NCsKgaHcvYXJtL3NtbXV2My1hY2NlbC1z
dHVicy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNTIgKysrKysrKysrPGJyPg0KwqBo
dy9hcm0vc21tdXYzLWFjY2VsLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzC
oCDCoDMgKy08YnI+DQrCoGh3L2FybS9zbW11djMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIDEzICstLTxicj4NCsKgaHcvYXJtL3ZlcnNhdGlsZXBiLmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAxIC08YnI+DQrCoGh3L2Fy
bS92ZXhwcmVzcy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAg
wqAxIC08YnI+DQrCoGh3L2FybS92aXJ0LWFjcGktYnVpbGQuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHzCoCDCoDkgKy08YnI+DQrCoGh3L2FybS94bG54LXpjdTEwMi5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSAtPGJyPg0KwqBody9jb3JlL21hY2hp
bmUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJy
Pg0KwqBody9jb3JlL3FkZXYtcHJvcGVydGllcy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB8wqAgwqAxICs8YnI+DQrCoGh3L2NvcmUvcWRldi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KwqBody9kaXNwbGF5L2F0aS5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDEyICstPGJyPg0KwqBo
dy9ocHBhL21hY2hpbmUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIMKgMiArLTxicj4NCsKgaHcvaHlwZXJ2L2h5cGVydi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgNiArLTxicj4NCsKgaHcvaHlwZXJ2L3ZtYnVzLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgLTxicj4NCsKgaHcv
aTM4Ni9hY3BpLWJ1aWxkLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAg
wqA0ICstPGJyPg0KwqBody9pMzg2L2Z3X2NmZy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvaTM4Ni9tdWx0aWJvb3QuY8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaHcvaTM4
Ni9wY19xMzUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDC
oDEgKzxicj4NCsKgaHcvaTM4Ni9wY19zeXNmd19vdm1mLXN0dWJzLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGh3L2kzODYvcGNfc3lzZndfb3ZtZi5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9pMzg2L3ZtbW91c2Uu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4N
CsKgaHcvaW50Yy9hcm1fZ2ljdjNfY3B1aWYuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIMKgMiArLTxicj4NCsKgaHcvaW50Yy9hcm1fZ2ljdjNfY3B1aWZfY29tbW9uLmPCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody9pbnRjL202OGtfaXJxYy5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9pbnRjL3No
X2ludGMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiAr
LTxicj4NCsKgaHcvaXNhL2xwY19pY2g5LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGh3L202OGsvYW41MjA2LmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody9tNjhrL21j
ZjUyMDYuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiAr
LTxicj4NCsKgaHcvbTY4ay9tY2Y1MjA4LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGh3L202OGsvbWNmX2ludGMuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3L202OGsvcTgw
MC1nbHVlLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08
YnI+DQrCoGh3L202OGsvcTgwMC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvbTY4ay92aXJ0LmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody9taWNyb2Js
YXplL2Jvb3QuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08
YnI+DQrCoGh3L21pY3JvYmxhemUvcGV0YWxvZ2l4X21sNjA1X21tdS5jwqAgwqAgwqAgwqAgwqB8
wqAgwqAyICstPGJyPg0KwqBody9taWNyb2JsYXplL3BldGFsb2dpeF9zM2Fkc3AxODAwX21tdS5j
wqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvbWljcm9ibGF6ZS94bG54LXp5bnFtcC1wbXUuY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaHcvbWlwcy9ib290bG9hZGVyLmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody9t
aXBzL2Z1bG9vbmcyZS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAg
wqAyICstPGJyPg0KwqBody9taXBzL2phenouY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3L21pcHMvbWFsdGEuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaHcv
bWlzYy9hdnJfcG93ZXIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgMyArPGJyPg0KwqBody9taXNjL2JjbTI4MzVfdGhlcm1hbC5jwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9taXNjL2xlZC5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9taXNj
L21pcHNfY3BjLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAz
ICstPGJyPg0KwqBody9taXNjL3Jpc2N2X2NtZ2NyLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGh3L21pc2MvcmlzY3ZfY3BjLmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDMgKy08YnI+DQrCoGh3L29yMWsvYm9v
dC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiAr
LTxicj4NCsKgaHcvb3Ixay9jcHV0aW1lci5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvb3Ixay9vcjFrLXNpbS5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvb3Ixay92aXJ0
LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICst
PGJyPg0KwqBody9wcGMvYW1pZ2FvbmUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfMKgIMKgMSAtPGJyPg0KwqBody9wcGMvZTUwMC5jwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9wcGMvZTUw
MHBsYXQuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSAr
PGJyPg0KwqBody9wcGMvZndfY2ZnLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGh3L3BwYy9tcGM4NTQ0X2d1dHMuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaHcvcHBjL21wYzg1
NDRkcy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMyArLTxi
cj4NCsKgaHcvcHBjL3BwYzQ0MF91Yy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvcHBjL3BwYzR4eF9kZXZzLmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody9wcGMvcHBjX2Jvb2tl
LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0K
wqBody9wcGMvcHJlcC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8wqAgwqAxIC08YnI+DQrCoGh3L3BwYy9wcmVwX3N5c3RlbWlvLmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody9wcGMvc3BhcHJfcnRhcy5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMTUgKysrPGJyPg0KwqBo
dy9wcGMvc3BhcHJfdmh5cF9tbXUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgMiArLTxicj4NCsKgaHcvcHBjL3ZpcnRleF9tbDUwNy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9yaXNjdi9taWNyb2JsYXplLXYtZ2Vu
ZXJpYy5jwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9zMzkweC9hcC1i
cmlkZ2UuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+
DQrCoGh3L3MzOTB4L3MzOTAtaHlwZXJjYWxsLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHzCoCDCoDIgKy08YnI+DQrCoGh3L3MzOTB4L3MzOTAtc3RhdHRyaWIuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3L3MzOTB4L3RvZC10Y2cuY8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3L3Nk
L3NkLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8
wqAgwqAyICstPGJyPg0KwqBody9zaDQvcjJkLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody9zaDQvc2g3NzUwLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgLTxicj4NCsKg
aHcvc3BhcmMvbGVvbjMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHzCoCDCoDIgKy08YnI+DQrCoGh3L3NwYXJjL3N1bjRtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KwqBody9zcGFyYzY0L25pYWdhcmEu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3
L3NwYXJjNjQvc3BhcmM2NC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKg
IMKgMiArLTxicj4NCsKgaHcvc3BhcmM2NC9zdW40dS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvdGltZXIvYmNtMjgzNV9zeXN0bXIu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaHcvdHBtL3Rw
bV9jcmIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAxMyAr
LS08YnI+DQrCoGh3L3RwbS90cG1fdGlzX2NvbW1vbi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB8wqAgwqA0ICstPGJyPg0KwqBody90cG0vdHBtX3Rpc19pMmMuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3L3RwbS90cG1fdGlz
X2lzYS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDEyICstPGJyPg0K
wqBody90cG0vdHBtX3Rpc19zeXNidXMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIDEzICsrLTxicj4NCsKgaHcvdHJpY29yZS90cmljb3JlX3Rlc3Rib2FyZC5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgaHcvdXNiL2J1cy1zdHViLmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGh3L3ZpcnRp
by92aXJ0aW8taW9tbXUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgLTxi
cj4NCsKgaHcveHRlbnNhL3BpY19jcHUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaHcveHRlbnNhL3h0ZnBnYS5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgcW9tL2NvbXBhdC1wcm9w
ZXJ0aWVzLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgMTE2ICsrKysrKysrKysr
KysrKysrKysrPGJyPg0KwqBxb20vb2JqZWN0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8IDEwMiArLS0tLS0tLS0tLS0tLS0tLTxicj4NCsKgc3R1YnMv
ZndfY2ZnLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAg
wqAyICstPGJyPg0KwqBzdHVicy9ob3RwbHVnLXN0dWJzLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoHN0dWJzL3FkZXYuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoHN0dWJz
L3FvbS1jb21wYXQtcHJvcGVydGllcy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMjAgKysr
Kzxicj4NCsKgc3lzdGVtL21lbW9yeS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBzeXN0ZW0vcGh5c21lbS5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDE2ICstLTxicj4NCsKgc3lzdGVtL3J0
Yy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKg
MSArPGJyPg0KwqBzeXN0ZW0vdmwuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KwqB0YXJnZXQvaTM4Ni9zZXYuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KwqB0ZXN0cy9x
dGVzdC9mdXp6LXNiMTYtdGVzdC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxi
cj4NCsKgdGVzdHMvcXRlc3QvZnV6ei1zZGNhcmQtdGVzdC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgMiArLTxicj4NCsKgdGVzdHMvcXRlc3Qvc2RoY2ktdGVzdC5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4NCsKgdWkvdmRhZ2VudC5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KwqBody9h
cm0vbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAg
wqA1ICstPGJyPg0KwqBody9taXNjL21lc29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody90aW1lci9tZXNvbi5idWlsZMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoHFvbS9tZXNv
bi5idWlsZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKg
MyArPGJyPg0KwqBydXN0L2JpbmRpbmdzL3FvbS1zeXMvbGliLnJzwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfMKgIMKgMiArLTxicj4NCsKgc3R1YnMvbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCsKgdGVzdHMvZnVuY3Rpb25h
bC9hYXJjaDY0L3Rlc3RfcmFzcGkzLnB5wqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqB0ZXN0cy9m
dW5jdGlvbmFsL2FybS90ZXN0X2JmbHQucHnCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+
DQrCoHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfcmFzcGkyLnB5wqAgwqAgwqAgwqAgwqB8wqAg
wqAyICstPGJyPg0KwqB0ZXN0cy9mdW5jdGlvbmFsL202OGsvdGVzdF9uZXh0Y3ViZS5wecKgIMKg
IMKgIHzCoCDCoDIgKy08YnI+DQrCoHRlc3RzL2Z1bmN0aW9uYWwvbWlwcy90ZXN0X21hbHRhLnB5
wqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqB0ZXN0cy9mdW5jdGlvbmFsL21pcHM2NGVs
L3Rlc3RfZnVsb29uZzJlLnB5IHzCoCDCoDIgKy08YnI+DQrCoHRlc3RzL2Z1bmN0aW9uYWwvbWlw
czY0ZWwvdGVzdF9tYWx0YS5wecKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgdGVzdHMvZnVuY3Rp
b25hbC9taXBzZWwvdGVzdF9tYWx0YS5wecKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgdGVz
dHMvZnVuY3Rpb25hbC9wcGMvdGVzdF80MHAucHnCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICst
PGJyPg0KwqB0ZXN0cy9mdW5jdGlvbmFsL3FlbXVfdGVzdC90ZXNzZXJhY3QucHnCoCDCoCDCoHzC
oCDCoDIgKy08YnI+DQrCoDE2OCBmaWxlcyBjaGFuZ2VkLCA1MDcgaW5zZXJ0aW9ucygrKSwgMzkz
IGRlbGV0aW9ucygtKTxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvcW9tL2NvbXBh
dC1wcm9wZXJ0aWVzLmg8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vc21tdXYzLWFj
Y2VsLXN0dWJzLmM8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCBxb20vY29tcGF0LXByb3BlcnRp
ZXMuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHN0dWJzL3FvbS1jb21wYXQtcHJvcGVydGll
cy5jPGJyPg0KPGJyPg0KLS0gPGJyPg0KMi41My4wPGJyPg0KPGJyPg0KPGJyPg0KPC9ibG9ja3F1
b3RlPjwvZGl2PjwvZGl2Pg0K
--0000000000006204a40650339d1b--

