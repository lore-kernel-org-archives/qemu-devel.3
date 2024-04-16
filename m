Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB0CC04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo26-0000mJ-Dp; Tue, 16 Apr 2024 14:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo20-0000le-ID
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:59:49 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo1x-0005KR-8x
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:59:48 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a5544fd07easo144916566b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713293983; x=1713898783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aKI7O+b3Bo+xsao49zshX9B958w9RaU2PXoPe3/rS/I=;
 b=PJoywWtKizVzh0lZVvQHtZaUbWvRTSyNA5w4ouS63ig/zxaY/IKWzR5LgOxEAd1T1P
 mYzw+NVjVz6eTg9Uw4DMYzpWBuAM/bQb8BZLxt6533GPGvwQ9DyI3LbaqwDCfxKJPkBY
 cSt1zlGKFOxXPVEtvzjhIaOlhY/SCgJqBt5bARCxZG7A4qtxriiwrCAx1VsD0rwkfOjb
 lD9TqmLn+b6PdLRz6JHSmqVg51KwsfvmysFxaZMT5p8ehel8I4Pm/AlMFLna6w7CH47Z
 Q/Ms+tkttOTKaLlNBENUu/a3ZoNlzk/F8Y/15GwAdwXhpa+olNF1fyOD5ly0bzs9+zx6
 Kgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713293983; x=1713898783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aKI7O+b3Bo+xsao49zshX9B958w9RaU2PXoPe3/rS/I=;
 b=MWLliC0fD0dGdVr3DCh7fO1BBkgncHVi4iBkDxUyGHnIZaDQOSbt3HdCl9n/OxU/6g
 uHtD1TlMXUTJThpOLjx6GyRQciR2cpwP2oi6M6nq7QY5/0HFwvGcK0+6iAVq9jq8emOg
 lBRrbwf6wZ+COMs5Jal2F3h9YP5MuRtiFL52VF2vEVFQKhsLi962Yoa7PLxoDEbi9RcE
 fcdheNhMTgM7gdVRk6ypkLqBUHK6grboUylcNoxe0XC7Or8ldfB92OWEFETXvbYbaCnO
 PEPRxU8eVnbhkOIbmZ4CXiWcfGoQvPQ0ve6xt5H49CS1pH/cyl3v91OaJ4YjEYBVrIAe
 VKsw==
X-Gm-Message-State: AOJu0YzinJ2RnK8Pr2ok4P9Ihj6SNdY5IhcBaSnT4JVmHZhlmCyigjBC
 syTbFkc5xBqfGSQEX6gZ9sfKms9pZVYN1q5FWgWsB3rVQ+/GP4ucvAK5Ge04OqxWf8DOthLLSbT
 G
X-Google-Smtp-Source: AGHT+IFKgUSVsIVRMT5nMr3cABObk1lQpiHZ360coDmul5EDy1HnpHZOBxGQZGiixLiic7I+g4y/cA==
X-Received: by 2002:a17:906:794e:b0:a4e:904:3c7f with SMTP id
 l14-20020a170906794e00b00a4e09043c7fmr11383890ejo.50.1713293983216; 
 Tue, 16 Apr 2024 11:59:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 jw9-20020a170906e94900b00a52241b823esm6940165ejb.109.2024.04.16.11.59.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 11:59:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/22] hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3
 machines
Date: Tue, 16 Apr 2024 20:59:16 +0200
Message-ID: <20240416185939.37984-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Series fully reviewed.

Since v3:
- Deprecate up to 2.12 (Thomas)

Since v2:
- Addressed Zhao review comments

Since v1:
- Addressed Zhao and Thomas review comments

Kill legacy code, because we need to evolve.

I ended there via dynamic machine -> ICH9 -> legacy ACPI...

This should also help Igor cleanups:
http://lore.kernel.org/qemu-devel/20240326171632.3cc7533d@imammedo.users.ipa.redhat.com/

Philippe Mathieu-Daudé (22):
  hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
  hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
  hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP flag
  hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
  hw/i386/acpi: Remove PCMachineClass::legacy_acpi_table_size
  hw/acpi/ich9: Remove 'memory-hotplug-support' property
  hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
  hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
  target/i386/kvm: Remove x86_cpu_change_kvm_default() and 'kvm-cpu.h'
  hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
  hw/smbios: Remove 'uuid_encoded' argument from smbios_set_defaults()
  hw/smbios: Remove 'smbios_uuid_encoded', simplify smbios_encode_uuid()
  hw/i386/pc: Remove PCMachineClass::enforce_aligned_dimm
  hw/mem/pc-dimm: Remove legacy_align argument from pc_dimm_pre_plug()
  hw/mem/memory-device: Remove legacy_align from
    memory_device_pre_plug()
  hw/i386/pc: Remove deprecated pc-i440fx-2.2 machine
  hw/i386/pc: Remove PCMachineClass::resizable_acpi_blob
  hw/i386/pc: Remove PCMachineClass::rsdp_in_ram
  hw/i386/acpi: Remove AcpiBuildState::rsdp field
  hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine
  target/i386: Remove X86CPU::kvm_no_smi_migration field
  hw/i386/pc: Replace PCMachineClass::acpi_data_size by
    PC_ACPI_DATA_SIZE

 docs/about/deprecated.rst             |   4 +-
 docs/about/removed-features.rst       |   2 +-
 hw/usb/hcd-xhci.h                     |   4 +-
 include/hw/firmware/smbios.h          |   3 +-
 include/hw/i386/pc.h                  |  22 ------
 include/hw/mem/memory-device.h        |   2 +-
 include/hw/mem/pc-dimm.h              |   3 +-
 target/i386/cpu.h                     |   3 -
 target/i386/kvm/kvm-cpu.h             |  41 ----------
 hw/acpi/ich9.c                        |  46 ++---------
 hw/arm/virt.c                         |   5 +-
 hw/i386/acpi-build.c                  |  95 ++---------------------
 hw/i386/fw_cfg.c                      |   3 +-
 hw/i386/pc.c                          | 107 ++++----------------------
 hw/i386/pc_piix.c                     | 102 +-----------------------
 hw/loongarch/virt.c                   |   4 +-
 hw/mem/memory-device.c                |  12 +--
 hw/mem/pc-dimm.c                      |   6 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/riscv/virt.c                       |   2 +-
 hw/smbios/smbios.c                    |  13 +---
 hw/usb/hcd-xhci-nec.c                 |   4 -
 hw/usb/hcd-xhci-pci.c                 |   4 +-
 hw/usb/hcd-xhci.c                     |  42 ++--------
 hw/virtio/virtio-md-pci.c             |   2 +-
 target/i386/cpu.c                     |   2 -
 target/i386/kvm/kvm-cpu.c             |   3 +-
 target/i386/kvm/kvm.c                 |   7 +-
 tests/avocado/mem-addr-space-check.py |   9 +--
 29 files changed, 69 insertions(+), 485 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

-- 
2.41.0


