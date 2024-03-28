Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81ECCD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps5Z-0000yO-5Y; Thu, 28 Mar 2024 11:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5W-0000q6-JL
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:54:46 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps5U-0001p3-Rw
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:54:46 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56c4ca65dc6so1403170a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641282; x=1712246082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9jGFJM87g0s+QJiSxyo+fFml0FCFfdp02zPTSZX+zrs=;
 b=Oggw9Wwt2BomueR1nlPZWgmI9Ck66CU8bdSDgoyZ0UWC1MBOohdPk1ZoZ1EgAaoAnB
 Ndrn3A3v+NvwDz8Zl6RQh0Q/EvwcNXUR68+/QQXBowNOU4uIHNyoAAVOLHJJOjhmbtza
 WZP01Rtm3gP6k0po+YG80W6if7SgSVmDOLuxfT9piVqKxTnShwSFFgzqHUima7++ykVq
 UVlhyQ2VVXYCk7ttrwquaFARvayttyzxCECF1hocwB/HK9Tj05mAT6XILbo0FtrFfa5A
 xpRLvkCJS5PlI0lHCQC4r/AU/UvDjLluJPBViQHHEbnbQaZkUkvD45E1z39ppvOQsr7A
 FK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641282; x=1712246082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9jGFJM87g0s+QJiSxyo+fFml0FCFfdp02zPTSZX+zrs=;
 b=NEpD8VOyxQzdtWv4va8VzqmA7oGUsV2vTy7ktfnQanysltXcwofNDMgHpaHgOdrfKY
 v746B+tB4yyHJ1ZspiBNJ/j703EwRjdGeNsOH+ICG1nq5kDCDpKDIWALflYvOrcDDxbQ
 sdPcG/IMQNNTtGw5ve6YsEHd4kKbdxNG2ATSZOfGLMI2YguKFTAr9s2zNjKtFXP+EXpD
 4zr3fZVJdyWsBXAcWMMkMukXYEAPfTDFQ+0waf5EXLTrSktDjeQm036mynI1ZRL3sUy+
 fdn+Iu0M/9LxG4jti87FkcNPVBi3Lp9p86I42p7sNilxaoJl4HkXDnXDOp1rMskspSgV
 nM9g==
X-Gm-Message-State: AOJu0YzpuD30NlppQH4xoeulQP8JawAAFeqEAxeUnd24VuT91I9aQKMN
 apwgmSeRsahcsuX3nbj8qHIpHSzCLk700qoj445pH5A7oZz2/yifJNmQyUc2eydjviKfbAEm/hM
 H
X-Google-Smtp-Source: AGHT+IF49DaXGjHZW9HD9cL+HRM/1d+LDb7jwUvaelY4b9yVxDNea692GvPtisYDleFJnYb7JifYOA==
X-Received: by 2002:a50:99c2:0:b0:56c:2ef7:f3ed with SMTP id
 n2-20020a5099c2000000b0056c2ef7f3edmr2553704edb.35.1711641282639; 
 Thu, 28 Mar 2024 08:54:42 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 f4-20020a056402194400b0056c4cdc987esm968928edz.8.2024.03.28.08.54.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:54:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 00/29] hw/i386/pc: Decouple ISA vs PCI-based
 machines
Date: Thu, 28 Mar 2024 16:54:08 +0100
Message-ID: <20240328155439.58719-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Hi Igor,

This is the first steps to decouple the isapc VS q35/i440fx
machines. A new TYPE_PC_PCI_MACHINE is introduced to help
differentiating. Fields unrelated to the legacy isapc are
moved to the new PcPciMachineState structure.

More work remain in hw/i386/pc_piix.c so we can build a
binary with only CONFIG_ISAPC enabled.

Based-on: <20240327095124.73639-1-philmd@linaro.org>
"hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3 machines"

Philippe Mathieu-Daudé (29):
  hw/i386/pc: Declare CPU QOM types using DEFINE_TYPES() macro
  hw/i386/pc: Extract pc_machine_is_pci_enabled() helper
  hw/i386/pc: Pass base machine type as argument to DEFINE_PC_MACHINE()
  hw/i386/pc: Introduce PC_PCI_MACHINE QOM type
  hw/i386/pc: Remove PCMachineClass::pci_enabled field
  hw/i386/pc: Move pci_root_uid field to PcPciMachineClass
  hw/i386/pc: Call fw_cfg_add_extra_pci_roots() in pc_pci_machine_done()
  hw/i386/pc: Move CXLState to PcPciMachineState
  hw/i386/pc: Pass PCMachineState argument to acpi_setup()
  hw/i386/pc: Remove PCMachineClass::has_acpi_build field
  hw/i386/pc: Move acpi_setup() call to pc_pci_machine_done()
  hw/i386/pc: Move acpi_build_enabled to PcPciMachineState
  hw/i386/pc: Remove non-PCI code from pc_system_firmware_init()
  hw/i386/pc: Move pc_system_flash_create() to pc_pci_machine_initfn()
  hw/i386/pc: Move FW/pflash related fields to PcPciMachineState
  hw/i386/pc: Move south-bridge related fields to PcPciMachine
  hw/i386/pc: Inline gigabyte_align()
  hw/i386/pc: Inline has_reserved_memory()
  hw/i386/pc: Pass PcPciMachineState argument to CXL helpers
  hw/i386/pc: Pass PcPciMachineState argument to pc_pci_hole64_start()
  hw/i386/fw_cfg: Include missing 'qapi-types-machine.h' header
  hw/i386/fw_cfg: Define fw_cfg_build_smbios() stub
  hw/i386/fw_cfg: Inline smbios_defaults()
  hw/i386/fw_cfg: Inline smbios_legacy_mode()
  hw/i386/fw_cfg: Replace smbios_defaults() by !smbios_legacy_mode()
  hw/i386/fw_cfg: Factor fw_cfg_build_smbios_legacy() out
  hw/i386/pc: Call fw_cfg_build_smbios_legacy() in pc_machine_done()
  hw/i386/pc: Rename pc_init1() -> pc_piix_init()
  hw/i386/pc: Move ISA-only PC machine to pc_isa.c

 MAINTAINERS                  |   1 +
 hw/i386/acpi-build.h         |   3 +-
 hw/i386/fw_cfg.h             |   2 +
 include/hw/i386/pc.h         |  78 +++++++-------
 hw/i386/acpi-build.c         |  34 ++++--
 hw/i386/fw_cfg-smbios-stub.c |  19 ++++
 hw/i386/fw_cfg.c             |  35 +++---
 hw/i386/pc.c                 | 199 ++++++++++++++++++++++-------------
 hw/i386/pc_isa.c             |  33 ++++++
 hw/i386/pc_piix.c            |  91 +++++++---------
 hw/i386/pc_q35.c             |  12 ++-
 hw/i386/pc_sysfw.c           |  68 +++++-------
 hw/i386/xen/xen-hvm.c        |   3 +-
 hw/isa/piix.c                |   2 +-
 hw/pci-host/i440fx.c         |   4 +-
 hw/pci-host/q35.c            |   2 +-
 hw/i386/meson.build          |   2 +
 17 files changed, 342 insertions(+), 246 deletions(-)
 create mode 100644 hw/i386/fw_cfg-smbios-stub.c
 create mode 100644 hw/i386/pc_isa.c

-- 
2.41.0


