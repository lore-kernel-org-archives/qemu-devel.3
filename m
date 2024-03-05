Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CC8C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV3x-0002Ff-He; Tue, 05 Mar 2024 08:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV3t-0002FJ-HP
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:42:31 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV3r-0003wD-RS
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:42:29 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5673b5a356eso761089a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646145; x=1710250945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oq7s+3d2WZzPSy9BYq/6Wk1gHRe7Pd/DU9HZZvyDy9s=;
 b=i5M803Vq9hL4ws6tuzUSJCTIcelTTBTirbrDgH+w9JgN6pWWzq4Pb7L8QH5Q8NDftX
 /BO/ta8FqvyJmeTG0Ja07E5TvTXM48a2Ki+2WeImzDeycoaNUSh+xwm+55NtchVhkTRa
 DauweAQ2NPZ3ZIb6FcbgcZ8Br27IT8s/XHHVTF+999AxkFv0TOuh7v8Zq0OwtGzZpEUx
 rLn9EEe3neZ1KNkTWKRmcvwamu5xuFwSEW5q9QWmi/RbrwZ+vtv71g4/HgxLytYsqLix
 9yYs2gV2UVSAIP+OmsVa85eiTkqNnGtOZKNNiOpT9IsYLxtBwQDzt4fSlALDZbVuY+Cf
 9cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646145; x=1710250945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oq7s+3d2WZzPSy9BYq/6Wk1gHRe7Pd/DU9HZZvyDy9s=;
 b=KJMU3uKr4f+OWi5gAsKZqTgqQPS9neckYu0kBur6BqwhpPo5N05Ai8pzhL5PW+MAXA
 5gv5eqxCe601l3mA2ZjZrDS7/8aiTg+RGT0pA7dxVIDZfjxNayODi7+V/voAsgS+Vlwi
 wptDD1i/mVLMsZi+kWlcR1/HY1BOs0SMuA9nUL/YOG2GpqaGg2zi/Hzpc162lSanrmwY
 dqqq5xodl1I4DOHPn85wHrwUoYHSQDIRRLr5QAI/sBRBB/ci9d1TkkJR9WbEBzorziaE
 6jUSrt/JiKmavFnwmEkdflAQdAhnKysR41ouhKAB0Q6UUOTrhSPni2SIvTzZ9pdZHgye
 pTNA==
X-Gm-Message-State: AOJu0Yzdrx2ib6kjc+f+S2yVIDAMhMirdHf/2zm45sIVFZf/c2Si11/u
 vx0JPRsXjssOfAhOLbkSEldsAioEMrYngwWo/ma0iXOORIKhvO6uSHDWsBrymGRDrEQVUxCDfz7
 s
X-Google-Smtp-Source: AGHT+IEe1H1poGp10OUoKEEQQFEBCbwYqRiDyQFYhfp+3jBcvYgWoJD/I5kDi6kDS6rgjGn/iJZtJg==
X-Received: by 2002:a50:d482:0:b0:566:4797:c330 with SMTP id
 s2-20020a50d482000000b005664797c330mr8941912edi.21.1709646145496; 
 Tue, 05 Mar 2024 05:42:25 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a056402428d00b0056793ab2ad8sm549529edc.94.2024.03.05.05.42.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:42:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 00/18] hw/i386: Remove deprecated pc-i440fx-2.0 -> 2.3
 machines
Date: Tue,  5 Mar 2024 14:42:02 +0100
Message-ID: <20240305134221.30924-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Kill legacy code, because we need to evolve.

I ended there via dynamic machine -> ICH9 -> legacy ACPI...

Based-on: <20240301185936.95175-1-philmd@linaro.org>
          "hw/i386/pc: Trivial cleanups"

Philippe Mathieu-Daudé (18):
  hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
  hw/usb/hcd-xhci: Enumerate xhci_flags setting values
  hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP flag
  hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
  hw/i386/acpi: Remove PCMachineClass::legacy_acpi_table_size
  hw/i386/pc: Remove deprecated pc-i440fx-2.1 machine
  target/i386/kvm: Remove x86_cpu_change_kvm_default() and 'kvm-cpu.h'
  hw/i386/pc: Remove PCMachineClass::smbios_uuid_encoded
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

 docs/about/deprecated.rst       |   7 ---
 docs/about/removed-features.rst |   2 +-
 hw/usb/hcd-xhci.h               |   4 +-
 include/hw/i386/pc.h            |  22 -------
 include/hw/mem/memory-device.h  |   2 +-
 include/hw/mem/pc-dimm.h        |   3 +-
 target/i386/cpu.h               |   3 -
 target/i386/kvm/kvm-cpu.h       |  41 ------------
 hw/arm/virt.c                   |   2 +-
 hw/i386/acpi-build.c            |  94 +++-------------------------
 hw/i386/fw_cfg.c                |   2 +-
 hw/i386/pc.c                    | 107 +++++---------------------------
 hw/i386/pc_piix.c               | 101 ------------------------------
 hw/loongarch/virt.c             |   2 +-
 hw/mem/memory-device.c          |  12 ++--
 hw/mem/pc-dimm.c                |   6 +-
 hw/ppc/spapr.c                  |   2 +-
 hw/usb/hcd-xhci-nec.c           |   4 --
 hw/usb/hcd-xhci-pci.c           |   4 +-
 hw/usb/hcd-xhci.c               |  42 +++----------
 hw/virtio/virtio-md-pci.c       |   2 +-
 target/i386/cpu.c               |   2 -
 target/i386/kvm/kvm-cpu.c       |   3 +-
 target/i386/kvm/kvm.c           |   6 --
 24 files changed, 48 insertions(+), 427 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

-- 
2.41.0


