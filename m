Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80E3CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXWjF-0001Fb-QZ; Thu, 11 Jun 2026 00:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXWjB-0001Ev-Vm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:09:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXWj9-00012r-Ix
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:09:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68d23396ed3so13328114a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781150949; cv=none;
 d=google.com; s=arc-20240605;
 b=IOfo+ehdB9/kFZxvfydHJySpIECDae2is9QW6enr5IVnjTVQXBWujilmjKYXBGc2eE
 Upsrj/vu1dIYxMIqfDpA6FWdxPYupg9mNqyz7F73tXbewS4ylSvklSk46PudrTlOU0gi
 dXV0+MKFY/OoAIKWBvpthUxcr/ZLhobSL49FSSlzQoh/IqR4wQeUrgNr03Y4WEL9DHMY
 O+k48sQTcBbxVZRkdBhzmS6GU7V4ZEqfzonzMV1gsb/39e58oCwNJbCfe7RMrwbeLhFn
 RYAugaV68c6WMKZtkfaxKH7eb1NztpkyFjSXqDqV+2KfJuV35T/a79m515DbwNzZWwKN
 jymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CyPO7afjoreQRD08qvBZdXR9qcILMHIlG62N59OKvFM=;
 fh=nO+eQewWF6KHcFxPGVUzEVHFNh36sGgno02vM6A0n9o=;
 b=YbjLFWEPZ3mtrfYxSukQoytbWuI788vIkuxRkhjdxv4sxtruHc0oYwqUYnNNDwo+PO
 p6uMi+vm23Zo4lIGYtTfbMR9eKjCpohIWsO4YmYxtVQq0Uh41eZ2YLKohe5XiNoYkv5c
 9+DpZ7mkfAwVD/LDCPLxbJMNgcZ/sNyaiOP20ISJpf4FjYVB5foBLiVTpWEoTYylOj/m
 2/vqyxSIhA+PxUweaHSo7aiIpI10RevpblU3MMGzuz7uYunE/yGEDOHoR8CUD5189nYA
 fhjWMVhQYrVf+AH4yPlFg78+8i2S4UJL61txyOMmY9riIM7yGKmmuGqloYJ18OHxYCFf
 Oidg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781150949; x=1781755749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyPO7afjoreQRD08qvBZdXR9qcILMHIlG62N59OKvFM=;
 b=biOZw9s6FxPi6s0p4HVqDCPaVD/mBA6bpGCyTLrrz4TUjjM/w+VDEjeswFq/df74Ju
 Vn3sru1hjG1AZzyYeBP22lF5Aabv/uwfIBKw8XqIV+LnVJSiaWiqpgZEGaLD1UruE+tq
 db6AbTu/s4R+bSlxPJoyPdkP8QI+N/Pgd24GW1iv+s25PLEyUxbeiwSq9s1azMUrLTNa
 8Y0Y+9+v9CmYCG0sLihaaEAPsYFK+UFuQfdsRoDnOS/SB7wrJVJImSRs6M0Tp6baxi2X
 QvDblzSoBKghKwDKt9zb6ZYdxYDxuFSFXglWDAeGI1GVdCbVUrurt4Pbq4KiwMsvPZMF
 rihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781150949; x=1781755749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CyPO7afjoreQRD08qvBZdXR9qcILMHIlG62N59OKvFM=;
 b=FcI25jqI+QKD/qf8Bbrer0Q4JMMCKIe/RzHuNys4scs7P9q+xEKVvsKrIPya0eLX5d
 M9Heg5kXKCornGZp3lKWYnbMurvSHfFkqXiwpe+N4rflHp49NMYCu697eC2iSuvL7HdJ
 fnuJpr4mOQ2WqKdpQl8b8a0+7hUN/Jwp3pQh94p3ixjg6zJgOI8NFJeP6pQxtKIO91al
 Nih9kmDq6c9uQAd3ejVAQ+oMc8OCwiGCNZl47nX2FKCece7KHWqdfGit84h7zgwOsMBj
 HCNcei3nCbF0pkt8RLYhyrI6bmB3Rmziyqgnw2YXbbZoQvRZ/z4leRX/6S/SXsJ0K//c
 caNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rP1QTjwKHO89BwitBpUh4ZBQFd9IdeopASMH9z4jLr44jPBvONq/z0Z4iLIXdbIRDySAWsc6FMk5J@nongnu.org
X-Gm-Message-State: AOJu0YyvjdKGkzmaSKLPeIWaoVuRrCDF0AtObSMRzWS3GQbxxZwL3pez
 7OnHKqjj1MqglM3IkXyiIXTloqel8jXHDa7oueDp7UQSvG4kwNq+kS9Z9QNsnDK2NB2m7URJtwP
 JXLgPxCfn07S81YfeXxr5Q2JhANgPJDs=
X-Gm-Gg: Acq92OGdOfCpW2UDsndm/BZ6fcvGw6RPR7GUDXEf5jwDmpW5SF1qHKMPDchz2NbEsTd
 kpoCCkHHIG5AXlDal8AOTQSL1xmZ1h61ZOyRHbBgzXQvAKbQqKvjtYZnmJzC5v554gW7qzdhsou
 msVzOWrdBKjwo0BBvVFGPeA5fAeZhY8L4wFeNjQtq+7sy0H3hSgRbCr627R3Wd3O8kmU/pdPpch
 VA/3aAphmQ2iLAu1JEDYD923nr49leralDH9XbiH+4a5SaqqMR/VafHfPNP8vTdzg8FfLRjPypL
 0/dPKaEPB138/dHsr6U21/Rb9d7ThJAHXxrQKkx5ADwdkuLWtCc6rKQFk7E=
X-Received: by 2002:a05:6402:27c8:b0:68c:bf82:884c with SMTP id
 4fb4d7f45d1cf-6930e26f9b7mr438372a12.6.1781150949527; Wed, 10 Jun 2026
 21:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
 <b3dc23332a8a6f02a15012308fe79f5a172a3837.1778516731.git.chao.liu.zevorn@gmail.com>
In-Reply-To: <b3dc23332a8a6f02a15012308fe79f5a172a3837.1778516731.git.chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Jun 2026 14:08:43 +1000
X-Gm-Features: AVVi8CeDP6aSf6g0NuthVeX0saJTUFhHzpqt2ItKBDWh54ZYds3EEqRYxL1OQ9c
Message-ID: <CAKmqyKPF2kGM_CnUpZO7a8rTbZr_UZa2gTbOQH2Tthxm_K6SJw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] docs/system/riscv: add documentation for k230
 machine
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
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

On Tue, May 12, 2026 at 2:32=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                  |   1 +
>  docs/system/riscv/k230.rst   | 113 +++++++++++++++++++++++++++++++++++
>  docs/system/target-riscv.rst |   1 +
>  3 files changed, 115 insertions(+)
>  create mode 100644 docs/system/riscv/k230.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7e3ed0c5c..6a752b1a0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1784,6 +1784,7 @@ K230 Machines
>  M: Chao Liu <chao.liu.zevorn@gmail.com>
>  L: qemu-riscv@nongnu.org
>  S: Maintained
> +F: docs/system/riscv/k230.rst
>  F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
>  F: include/hw/riscv/k230.h
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> new file mode 100644
> index 0000000000..cea8202e55
> --- /dev/null
> +++ b/docs/system/riscv/k230.rst
> @@ -0,0 +1,113 @@
> +Kendryte K230 virt reference platform (``k230``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The ``k230`` machine is compatible with the Kendryte K230 SDK.
> +
> +The K230 is a chip from the AIoT SoC series made by Kendryte =C2=AE =E2=
=80=94 a part of
> +Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated com=
puting
> +structure.
> +
> +This chip has 2 RISC-V computing cores and a new-generation KPU (Knowled=
ge
> +Process Unit) smart computing unit.
> +
> +For more information, see <https://www.kendryte.com/en/proDetail/230>
> +
> +Supported devices
> +-----------------
> +The ``k230`` machine supports the following devices:
> +
> +* 1 c908 cores (little core)
> +* Core Local Interruptor (CLINT)
> +* Platform-Level Interrupt Controller (PLIC)
> +* 2 K230 Watchdog Timer
> +* 5 UART
> +
> +Boot options
> +------------
> +The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which=
 then
> +starts OpenSBI/Linux with ``bootm``. It also supports direct Linux boot.
> +
> +K230 SDK Linux kernels use T-HEAD C9xx private MAEE page table attribute=
s. QEMU
> +does not implement MAEE in the generic RISC-V MMU, so such kernels need =
to be
> +built with standard RISC-V PTE bits before they can boot under QEMU.
> +
> +Running
> +-------
> +
> +Direct Linux boot
> +~~~~~~~~~~~~~~~~~
> +
> +This flow lets QEMU load OpenSBI, Linux, initrd, and DTB directly, witho=
ut
> +running SDK U-Boot. The Linux Image must be rebuilt with standard RISC-V=
 PTE
> +bits before running under QEMU.
> +
> +.. code-block:: bash
> +
> +   $ SDK=3Dk230_sdk/output/k230_canmv_defconfig
> +   $ qemu-system-riscv64 -machine k230 \
> +      -kernel "$SDK/images/little-core/Image" \
> +      -dtb "/tmp/user-k230-qemu.dtb" \
> +      -initrd "$SDK/images/little-core/rootfs.cpio.gz" \
> +      -append "console=3DttyS0,115200 earlycon=3Dsbi cma=3D0" \
> +      -nographic
> +
> +Direct boot uses the SDK little-core RAM layout for OpenSBI at
> +``0x08000000``, Linux at ``0x08200000``, and the DTB at ``0x0a000000``. =
The
> +initrd is placed by QEMU's generic RISC-V boot helper, and QEMU writes t=
he
> +initrd range and kernel command line into ``/chosen``. The DTB passed wi=
th
> +``-dtb`` should be derived from ``$SDK/images/little-core/k230.dtb`` and=
 must
> +describe that initrd location as usable memory and disable any devices t=
hat are
> +not emulated by this machine.
> +
> +U-Boot boot
> +~~~~~~~~~~~
> +
> +This flow starts SDK U-Boot in M-mode with ``-bios``. Until the SDK stor=
age
> +path is modeled, place OpenSBI, Linux, initrd, and DTB in RAM with loade=
r
> +devices and run ``bootm`` manually. The Linux Image must be rebuilt with
> +standard RISC-V PTE bits before running under QEMU.
> +
> +.. code-block:: bash
> +
> +   $ SDK=3Dk230_sdk/output/k230_canmv_defconfig
> +   $ IMAGE=3D$SDK/images/little-core/Image
> +   $ INITRD=3D$SDK/images/little-core/rootfs.cpio.gz
> +   $ DTB=3D$SDK/images/little-core/k230.dtb
> +   $ FWJUMP_UIMAGE=3D/tmp/k230-fw-jump.uImage
> +   $ INITRD_END=3D$(printf "0x%x" $((0x0a100000 + $(stat -c %s "$INITRD"=
))))
> +   $ "$SDK/little/buildroot-ext/host/bin/mkimage" \
> +      -A riscv -O linux -T kernel -C none \
> +      -a 0x8000000 -e 0x8000000 -n opensbi \
> +      -d "$SDK/images/little-core/fw_jump.bin" "$FWJUMP_UIMAGE"
> +   $ qemu-system-riscv64 -machine k230 \
> +      -bios "$SDK/little/uboot/u-boot" \
> +      -device loader,file=3D"$FWJUMP_UIMAGE",addr=3D0xc100000,force-raw=
=3Don \
> +      -device loader,file=3D"$IMAGE",addr=3D0x8200000,force-raw=3Don \
> +      -device loader,file=3D"$INITRD",addr=3D0xa100000,force-raw=3Don \
> +      -device loader,file=3D"$DTB",addr=3D0xa000000,force-raw=3Don \
> +      -nographic
> +
> +The loader addresses mirror the SDK ``k230_canmv_defconfig`` output. Rea=
d the
> +U-Boot addresses from the generated environment, and read the Linux RAM =
base
> +from the generated ``hw/k230.dts.txt``. This replaces the SDK storage an=
d
> +decompression steps.
> +
> +Press Enter to stop autoboot. At the U-Boot prompt, run these commands:
> +
> +.. code-block:: bash
> +
> +   K230# setenv bootargs console=3DttyS0,115200 earlycon=3Dsbi cma=3D0
> +   K230# fdt addr 0xa000000
> +   K230# fdt resize 8192
> +   K230# fdt set /chosen linux,initrd-start <0x0 0xa100000>
> +   K230# fdt set /chosen linux,initrd-end <0x0 ${INITRD_END}>
> +   K230# fdt set /soc/sdhci0@91580000 status disabled
> +   K230# fdt set /soc/sdhci1@91581000 status disabled
> +   K230# bootm 0xc100000 - 0xa000000
> +
> +Use ``setenv`` so ``bootm`` writes the kernel command line into
> +``/chosen/bootargs``. The ``fdt`` commands select the loaded DTB, add sp=
ace for
> +edits, describe the initrd range in ``/chosen``, and disable SDHCI nodes=
 because
> +this machine does not emulate those controllers yet. Replace ``${INITRD_=
END}``
> +with the host-calculated value above when typing the command. ``cma=3D0`=
` avoids
> +the SDK kernel reserving too much of the little-core memory window for i=
nitramfs
> +boot.
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 3ad5d1ddaf..b0b2f9584f 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
>  .. toctree::
>     :maxdepth: 1
>
> +   riscv/k230
>     riscv/microblaze-v-generic
>     riscv/microchip-icicle-kit
>     riscv/mips
>

