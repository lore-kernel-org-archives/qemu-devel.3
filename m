Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EC0C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Wb-0003oC-Md; Mon, 17 Jun 2024 03:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6WW-0003nx-Am
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:28 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6WT-000252-CW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:27 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6f176c5c10so470239266b.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608281; x=1719213081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xMhBTetLaxr5ifJoMZiL0KHHVvxQ+XF+aHv00sbVd4w=;
 b=be0ju16fhJTBnCJZDo827bWI8oOTd4CklTJkXr9+uT+YHnVHcZ1cc5hqP4lO5HyBby
 WCaXMjH1crOWm7cKcOBOogPBTOluf1xA7IUd1zlGrzBuCHb5ViIXI+3vkgRIo48JtX4a
 wM7a5z0gzJhacWqGuM0tWSu59lHC2TekRLtcVJijtYOg0qbgoGdiZyoSjAbe0dhKrLdv
 sjJw+ns4F6TavNAp6fYOAJGEW/TnwI3xrnnqJYuIa3UXElLeO43zPWgTSSU9KBJkTQFs
 tKx8+pjkZ1ovX6eGnybd9hQ2wQlxI+zqH9MaAWmgpj2MfQCumXkB2t/njONgCqdtPlA+
 mEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608281; x=1719213081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xMhBTetLaxr5ifJoMZiL0KHHVvxQ+XF+aHv00sbVd4w=;
 b=Qqr+SDueCLjrUxhqStNHhciZK4zrR9ZiJgenBOLcKiJ0begVfh9Pt+2ltNSKK05+rB
 s3cPxZAVNw6oYMAaJPwm3F1/QNaB+g1+AfNZr59mYC5R9wuftUVtn0sSdi08I/cAMEZ/
 Us/biravfQFK8RenzNiQZj2KHIqxBmfjSDRhHzF8cxonohP+3eFZ8E3Jwh0v+dyyLUhw
 0wVzGsQd0hEZFpfvvNoTTPfetODkJt1UAGIjU9A1XekglnFQFZEgFDVmuE0kJv5rddFZ
 fyNYHW4Auqp0f/29bB5Mf5vfCINF2/vJ2DpRCza9k/ot9Iz20lMIvL9MhGBAtQv9f+Jo
 SGEg==
X-Gm-Message-State: AOJu0YwpbDS+3c3Kdx8bk/oHzMRU+CVmmWK7GCy1Fwz17IZdvXYLKg8y
 1fZ5+rof+Wvv8oec9ILVBWjhnDiwa/rKVxf/rSndY8tPTulVvhQJikmkS+73pI1CcF6GbCzU4GN
 YIKk=
X-Google-Smtp-Source: AGHT+IHUcFsDtecK8DjGOV/+X4x8+NoXGOQsmWGZkfaQkIi3SXBuExy23V7COxq91LcBzwaUI2dIRg==
X-Received: by 2002:a17:906:a447:b0:a6f:5a47:a59e with SMTP id
 a640c23a62f3a-a6f60dc55fcmr593490166b.59.1718608281310; 
 Mon, 17 Jun 2024 00:11:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f6ac22e57sm346134166b.177.2024.06.17.00.11.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:11:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 00/23] hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3
 machines
Date: Mon, 17 Jun 2024 09:10:55 +0200
Message-ID: <20240617071118.60464-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Series fully reviewed. Since Igor reviewed, I plan to merge
it myself if no feedback from Paolo / Michael.

Since v5:
- Addressed Igor review comments
- Added R-b tags

Since v4:
- Rebased on top of 7b68a5fe2f ("Merge tag 'for-upstream')
- Removed obsolete comment (Daniel)
- Clean DEFINE_I440FX_MACHINE (Daniel, new patch).

Since v3:
- Deprecate up to 2.12 (Thomas)

Since v2:
- Addressed Zhao review comments

Since v1:
- Addressed Zhao and Thomas review comments

Clashes a bit with Daniel general deprecation policy for all
versioned machines:
https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg00084.html

Philippe Mathieu-Daudé (23):
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
  hw/i386/pc: Simplify DEFINE_I440FX_MACHINE() macro
  target/i386: Remove X86CPU::kvm_no_smi_migration field
  hw/i386/pc: Replace PCMachineClass::acpi_data_size by
    PC_ACPI_DATA_SIZE

 docs/about/deprecated.rst             |   4 +-
 docs/about/removed-features.rst       |   2 +-
 hw/usb/hcd-xhci.h                     |   4 +-
 include/hw/firmware/smbios.h          |   3 +-
 include/hw/i386/pc.h                  |  22 ----
 include/hw/mem/memory-device.h        |   2 +-
 include/hw/mem/pc-dimm.h              |   3 +-
 target/i386/cpu.h                     |   3 -
 target/i386/kvm/kvm-cpu.h             |  41 ------
 hw/acpi/ich9.c                        |  46 +------
 hw/arm/virt.c                         |   5 +-
 hw/i386/acpi-build.c                  |  96 ++-------------
 hw/i386/fw_cfg.c                      |   3 +-
 hw/i386/pc.c                          | 107 +++-------------
 hw/i386/pc_piix.c                     | 171 +++++---------------------
 hw/loongarch/virt.c                   |   4 +-
 hw/mem/memory-device.c                |  12 +-
 hw/mem/pc-dimm.c                      |   6 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/riscv/virt.c                       |   2 +-
 hw/smbios/smbios.c                    |  13 +-
 hw/usb/hcd-xhci-nec.c                 |   4 -
 hw/usb/hcd-xhci-pci.c                 |   4 +-
 hw/usb/hcd-xhci.c                     |  42 ++-----
 hw/virtio/virtio-md-pci.c             |   2 +-
 target/i386/cpu.c                     |   2 -
 target/i386/kvm/kvm-cpu.c             |   3 +-
 target/i386/kvm/kvm.c                 |   7 +-
 tests/avocado/mem-addr-space-check.py |   9 +-
 29 files changed, 98 insertions(+), 526 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

-- 
2.41.0


