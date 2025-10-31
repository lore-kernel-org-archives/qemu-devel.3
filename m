Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E785CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmSW-0005T2-DS; Fri, 31 Oct 2025 06:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEmSN-0005Pd-AV
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEmSH-0006E9-AZ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761906831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/jGLV9GwwmWLPtAFMtsGUdWiI6XWtoKi7BhNW1nFXU=;
 b=eNtyhP8T049fW5usrsNF1tPnnJbC+den9Vgve+1y9cNAyPbJ5ZvFJhLSUsPI7aWqrStEFJ
 AluUFrvw7wttIxIOaFeyCMXerE446GzV1uL+hf7VGQazN4Rpmoqk6UMioG52/Upyw/3t4c
 lu+txWBUY1U3WEGtGLgI43DIMUjX84k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-cH3UFjDoNqaAE5ufGMJ1Fg-1; Fri, 31 Oct 2025 06:33:50 -0400
X-MC-Unique: cH3UFjDoNqaAE5ufGMJ1Fg-1
X-Mimecast-MFC-AGG-ID: cH3UFjDoNqaAE5ufGMJ1Fg_1761906829
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso11073975e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761906829; x=1762511629;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n/jGLV9GwwmWLPtAFMtsGUdWiI6XWtoKi7BhNW1nFXU=;
 b=sE9NDASm+0eTrREijqid+P+ghNqoEMNMEsdncodAFwDhzk5Vl4K9oZiO65m+1tJJcC
 rp1cQpZm4kipzU2Chh9OOUHGIEScQXxZx9tN3qI4HxnI6pkF8Q5bzMCL/WvRZ9COPw5v
 liTkX3bKHz5qSJM5H99yEyc86YsrvrUP8E5wFxjFlSgt5+/LZr0fir9y2kN5yXaAKkT7
 aIPxzOuv5ORg5PEs7fPmlK/jY9VtwUKBfXkfT0TU98s3vW5KecItZNJwfyiH9Z+agqKI
 prNohztESi+PY6JnestkjJJNETz+yOSLP8WeKoqub8uNePJP+nvyAVCimC46rq90NsP6
 Pw0w==
X-Gm-Message-State: AOJu0YytvmUJC9i3zSse8ykkv/M8IA8wMRcd9pXdWvPVAOsCTXAVERT2
 IS5gs1v/hnYHvAz8NTTjRt0C+3UUB5Dx7BKur0QcCuh22ACzCKPGZZjAcIDATWoc2vzKckZQEX8
 +urXehAVMdSRvqzmuVJgsXrRf0aI7OJ/Clqe2aYHqwCUElQ+dS1mZc+gk
X-Gm-Gg: ASbGncuwxY/HW9xekgoFIW5vZn92SeFMO6f9akITzvqwRqjlFRtDjX11APdXIcoyA+R
 OZ7HFYPaQ2idtYZFT/YGjp+J/sC91NSczZuFlZ+X8snp/2Ymcv71aydXfw/R4+sAyDVBFezGl0R
 800hwaEAu3P6+EIjT9vISrnM5Hc5uuRZiwIBrsc8Q3Ls7Hx7ewG7DA+9XLCiwLfjD6dUPL+8J3+
 Kw2PnAUTg24aG0zoMGBXbhFSKw2Dku6tOYCGJacLyG5vFJ0pi0BXCh8WiJRvYM0vlgOMiH1PY1O
 Ql15mKceF+hrSBglsYmWMJegk0+RRN27eQ7saS1A0UquRloWuUAdY+gdMBzy/krja3b5C7TfJh4
 VcWJk+eoyFyU=
X-Received: by 2002:a05:600c:6207:b0:477:bf1:8c82 with SMTP id
 5b1f17b1804b1-4773012927cmr30121015e9.15.1761906829102; 
 Fri, 31 Oct 2025 03:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWCHcilNykTSLc62QxcCapaqI02WJ4rPlCIQNLJ1JMRw/+H68d09txCoHrM7hGWJDTD94b9Q==
X-Received: by 2002:a05:600c:6207:b0:477:bf1:8c82 with SMTP id
 5b1f17b1804b1-4773012927cmr30120385e9.15.1761906828559; 
 Fri, 31 Oct 2025 03:33:48 -0700 (PDT)
Received: from imammedo-mac ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114b93esm2889676f8f.19.2025.10.31.03.33.46
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 31 Oct 2025 03:33:48 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:33:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 00/27] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC
 machines
Message-ID: <20251031113344.7cb11540@imammedo-mac>
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
Organization: imammedo@redhat.com
X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21;
 x86_64-apple-darwin14.0.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  8 May 2025 15:35:23 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

Are you planning to resping it?
(if yes, I can provide you with a fixed 2/27 patch that removes all legacy =
cpu hp leftovers)

> Since v3:
> - Addressed Thomas and Zhao review comments
> - Rename fw_cfg_init_mem_[no]dma() helpers
> - Remove unused CPU properties
> - Remove {multi,linux}boot.bin
> - Added R-b tags
>=20
> Since v2:
> - Addressed Mark review comments and added his R-b tags
>=20
> The versioned 'pc' and 'q35' machines up to 2.12 been marked
> as deprecated two releases ago, and are older than 6 years,
> so according to our support policy we can remove them.
>=20
> This series only includes the 2.6 and 2.7 machines removal,
> as it is a big enough number of LoC removed. Rest will
> follow.
>=20
> Based-on: <20250506143905.4961-1-philmd@linaro.org>
>=20
> Philippe Mathieu-Daud=C3=A9 (27):
>   hw/i386/pc: Remove deprecated pc-q35-2.6 and pc-i440fx-2.6 machines
>   hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug field
>   hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with '_nodma' suffix
>   hw/mips/loongson3_virt: Prefer using fw_cfg_init_mem_nodma()
>   hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal() out
>   hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() ->
>     fw_cfg_init_mem_dma()
>   hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled field
>   hw/i386/pc: Remove multiboot.bin
>   hw/nvram/fw_cfg: Remove fw_cfg_io_properties::dma_enabled
>   hw/i386/pc: Remove linuxboot.bin
>   hw/i386/pc: Remove pc_compat_2_6[] array
>   target/i386/cpu: Remove CPUX86State::enable_cpuid_0xb field
>   target/i386/cpu: Remove CPUX86State::fill_mtrr_mask field
>   hw/intc/apic: Remove APICCommonState::legacy_instance_id field
>   hw/core/machine: Remove hw_compat_2_6[] array
>   hw/virtio/virtio-mmio: Remove
>     VirtIOMMIOProxy::format_transport_address field
>   hw/i386/pc: Remove deprecated pc-q35-2.7 and pc-i440fx-2.7 machines
>   hw/i386/pc: Remove pc_compat_2_7[] array
>   target/i386/cpu: Remove CPUX86State::full_cpuid_auto_level field
>   target/i386/cpu: Remove CPUX86State::enable_l3_cache field
>   hw/audio/pcspk: Remove PCSpkState::migrate field
>   hw/core/machine: Remove hw_compat_2_7[] array
>   hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim field
>   hw/intc/ioapic: Remove IOAPICCommonState::version field
>   hw/virtio/virtio-pci: Remove VirtIOPCIProxy::ignore_backend_features
>     field
>   hw/char/virtio-serial: Do not expose the 'emergency-write' property
>   hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_PAGE_PER_VQ definition
>=20
>  hw/intc/ioapic_internal.h           |   3 +-
>  include/hw/acpi/cpu_hotplug.h       |   3 -
>  include/hw/boards.h                 |   6 -
>  include/hw/i386/apic_internal.h     |   1 -
>  include/hw/i386/intel_iommu.h       |   1 -
>  include/hw/i386/pc.h                |   9 --
>  include/hw/i386/x86.h               |   2 -
>  include/hw/nvram/fw_cfg.h           |   9 +-
>  include/hw/virtio/virtio-mmio.h     |   1 -
>  include/hw/virtio/virtio-pci.h      |   2 -
>  include/hw/virtio/virtio-serial.h   |   2 -
>  pc-bios/optionrom/optionrom.h       |   4 -
>  target/i386/cpu.h                   |  15 --
>  hw/acpi/cpu_hotplug.c               | 230 ---------------------------
>  hw/arm/virt.c                       |   2 +-
>  hw/audio/pcspk.c                    |  10 --
>  hw/char/virtio-serial-bus.c         |   9 +-
>  hw/core/machine.c                   |  17 --
>  hw/display/virtio-vga.c             |  10 --
>  hw/hppa/machine.c                   |   2 +-
>  hw/i386/acpi-build.c                |   4 +-
>  hw/i386/fw_cfg.c                    |   5 +-
>  hw/i386/intel_iommu.c               |   5 +-
>  hw/i386/microvm.c                   |   3 -
>  hw/i386/multiboot.c                 |   7 +-
>  hw/i386/pc.c                        |  22 +--
>  hw/i386/pc_piix.c                   |  23 ---
>  hw/i386/pc_q35.c                    |  24 ---
>  hw/i386/x86-common.c                |   6 +-
>  hw/i386/x86.c                       |   2 -
>  hw/intc/apic_common.c               |   5 -
>  hw/intc/ioapic.c                    |  18 +--
>  hw/intc/ioapic_common.c             |   2 +-
>  hw/mips/loongson3_virt.c            |   2 +-
>  hw/nvram/fw_cfg.c                   |  48 +++---
>  hw/riscv/virt.c                     |   4 +-
>  hw/virtio/virtio-mmio.c             |  15 --
>  hw/virtio/virtio-pci.c              |  12 +-
>  target/i386/cpu.c                   | 152 ++++++++----------
>  target/i386/kvm/kvm.c               |  10 +-
>  tests/qtest/test-x86-cpuid-compat.c |  11 --
>  pc-bios/meson.build                 |   2 -
>  pc-bios/multiboot.bin               | Bin 1024 -> 0 bytes
>  pc-bios/optionrom/Makefile          |   2 +-
>  pc-bios/optionrom/linuxboot.S       | 195 -----------------------
>  pc-bios/optionrom/multiboot.S       | 232 ---------------------------
>  pc-bios/optionrom/multiboot_dma.S   | 234 +++++++++++++++++++++++++++-
>  47 files changed, 349 insertions(+), 1034 deletions(-)
>  delete mode 100644 pc-bios/multiboot.bin
>  delete mode 100644 pc-bios/optionrom/linuxboot.S
>  delete mode 100644 pc-bios/optionrom/multiboot.S
>=20


