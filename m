Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90970C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvZH-0004TB-Gs; Fri, 02 May 2025 14:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZD-0004Oz-CE
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:56:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZB-0005M2-IC
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:56:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so3660180a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212215; x=1746817015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kyc7aSZr1tLI5wvlueRbX9aGSN3XilRcqQ3b7eltrqM=;
 b=tqTgNbjGI9ewJ1f45XsKY72CKl9Tzr9A2U/iaMMtz5a0ku9x3BxM2gt51qIcLN+bsy
 YguqbuxQBH1xL5bHDIKl8a0z3obTvLkQQecXG83bxYrD3g4CTki23yjTRNjQQG1L+VlW
 XgzsaB9Q5OHyH41bI68t9YQAqeq7QfUh/ZyM3CrxGsLtqu82OqsZ1qenPkOdd8TsXYuP
 ZNpImIB/DfwEcJuCQjiL6ILeNsE55siIZbB9MTboaXOD3gK9uNdYYdm+YXOgwu4FGmMp
 hdZnTXCXwT61ikqodgzKkXsChBn5LPndCZ4IDBAsh/F7S0Qni02g8VYqe0Nll8Ljjf9E
 tkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212215; x=1746817015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kyc7aSZr1tLI5wvlueRbX9aGSN3XilRcqQ3b7eltrqM=;
 b=erS8rLJtgMmBp3OP+vqd2IYUOisOjxzq1Ao64k3C6sSlQkYvEGRASt3YoV6fuxGcSp
 T3Yi5H1APXmxxEstrU1UJuBKvvwRY2fTX+rqxeybSVPxA+se08DJgo4eDjpynSRPI/Dp
 K4rzFemn6gRssfSvGdYgfBGK+J0wRvek01nZQd494XqxfL9B6c3DaIP1L9J0IZX0AbTr
 N76Ura35ya0cSNx6NGgqJSUBk9VRA3CS6wc+JVdOoQLXytK0mGzSHMXVlfjq7aBvCXdY
 eOh6vqMPYY6owA8XAUT+HVloNxdKE2DYnGsDFzw4DxmlBl9y+NFeizEdOeSyjS3khEux
 fpgw==
X-Gm-Message-State: AOJu0YwRBRyiFLXusMRt3/DUwKV59XsuZ3Ct0fvZbq1nuqnwF+6iDfC4
 wP7u7vh2E+eoT+bhlRojsMnN8gIV1dIxTnxJSAilXy0a2/zkTpYJMHs/xru2RusHfA4l+Su1ML0
 S
X-Gm-Gg: ASbGncsRcmBFnU6LCu4wJ7S0IPj6mUSfclWKwS8EGqqnyMXObETkGwBq8Ildr08oGkK
 arzDkm9IQgYPZ84zjkBSI/+iakRe5ojrFsesR0LI+bB/pxDPUvHtOybhzzIoEcZGzOe0Jz2c8Z5
 Ht+pfPXA+8T+QQrlWxfDWo23pCEYtEkU55zn2oeYMyfQcg9znnkBYBdhZ5njXEOjopcSIoBJqeD
 PA3l268dAj/2eb3hVgWDCfqtOjNy1odZORZF2J9XMAlMWbzolJrABC+8zsRzOEyxTCbi6IVcsDl
 Qm4VJFih34nlr9ELXmkn7QqbanxuA0Px32MiUqEjl369UyT+HaWm4bxTGP3ltmWbv3Yr/YknQt9
 WnB2zO0751ybxES1859kR
X-Google-Smtp-Source: AGHT+IGaiFBziOj5AAcbdvW/F0Rp9KaYVX7xBq+SvS2Ou2kVbFElIxdKNt91TOEPXrFQjkENsTBcqg==
X-Received: by 2002:a05:6402:518b:b0:5de:dfde:c8b1 with SMTP id
 4fb4d7f45d1cf-5fa77fde6d8mr3137667a12.4.1746212215084; 
 Fri, 02 May 2025 11:56:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77816ffbsm1557324a12.34.2025.05.02.11.56.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:56:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 00/19] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
Date: Fri,  2 May 2025 20:56:32 +0200
Message-ID: <20250502185652.67370-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Since v2:
- Addressed Mark review comments and added his R-b tags

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.6 and 2.7 machines removal,
as it is a big enough number of LoC removed. Rest will
follow.

Based-on: <20250429140825.25964-1-philmd@linaro.org>

Philippe Mathieu-Daudé (19):
  hw/i386/pc: Remove deprecated pc-q35-2.6 and pc-i440fx-2.6 machines
  hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug field
  hw/mips/loongson3_virt: Prefer using fw_cfg_init_mem()
  hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal() out
  hw/i386/x86: Remove X86MachineClass::fwcfg_dma_enabled field
  hw/nvram/fw_cfg: Remove fw_cfg_io_properties::dma_enabled
  hw/i386/pc: Remove pc_compat_2_6[] array
  hw/intc/apic: Remove APICCommonState::legacy_instance_id field
  hw/core/machine: Remove hw_compat_2_6[] array
  hw/virtio/virtio-mmio: Remove
    VirtIOMMIOProxy::format_transport_address field
  hw/i386/pc: Remove deprecated pc-q35-2.7 and pc-i440fx-2.7 machines
  hw/i386/pc: Remove pc_compat_2_7[] array
  hw/audio/pcspk: Remove PCSpkState::migrate field
  hw/core/machine: Remove hw_compat_2_7[] array
  hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim field
  hw/intc/ioapic: Remove IOAPICCommonState::version field
  hw/virtio/virtio-pci: Remove VirtIOPCIProxy::ignore_backend_features
    field
  hw/char/virtio-serial: Do not expose the 'emergency-write' property
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_PAGE_PER_VQ definition

 hw/intc/ioapic_internal.h         |   3 +-
 include/hw/acpi/cpu_hotplug.h     |   3 -
 include/hw/boards.h               |   6 -
 include/hw/i386/apic_internal.h   |   1 -
 include/hw/i386/intel_iommu.h     |   1 -
 include/hw/i386/pc.h              |   9 --
 include/hw/i386/x86.h             |   2 -
 include/hw/virtio/virtio-mmio.h   |   1 -
 include/hw/virtio/virtio-pci.h    |   2 -
 include/hw/virtio/virtio-serial.h |   2 -
 hw/acpi/cpu_hotplug.c             | 230 ------------------------------
 hw/audio/pcspk.c                  |  10 --
 hw/char/virtio-serial-bus.c       |   9 +-
 hw/core/machine.c                 |  17 ---
 hw/display/virtio-vga.c           |  10 --
 hw/i386/acpi-build.c              |   4 +-
 hw/i386/intel_iommu.c             |   5 +-
 hw/i386/microvm.c                 |   3 -
 hw/i386/multiboot.c               |   7 +-
 hw/i386/pc.c                      |  18 ---
 hw/i386/pc_piix.c                 |  23 ---
 hw/i386/pc_q35.c                  |  24 ----
 hw/i386/x86-common.c              |   3 +-
 hw/i386/x86.c                     |   2 -
 hw/intc/apic_common.c             |   5 -
 hw/intc/ioapic.c                  |  18 +--
 hw/intc/ioapic_common.c           |   2 +-
 hw/mips/loongson3_virt.c          |   2 +-
 hw/nvram/fw_cfg.c                 |  46 +++---
 hw/virtio/virtio-mmio.c           |  15 --
 hw/virtio/virtio-pci.c            |  12 +-
 31 files changed, 37 insertions(+), 458 deletions(-)

-- 
2.47.1


