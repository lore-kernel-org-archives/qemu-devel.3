Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0DEC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJSS-0006ul-FV; Tue, 06 May 2025 10:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJRv-0006a0-Ti
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJRu-0001LF-24
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so47938805e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542347; x=1747147147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6pHJth71V1NU+j8DWvRO78dboaItuaL0yLZwlUfF5zg=;
 b=PVV8SdpfzIdRKTX48bfekccu+ZPA8DPYtEY0qQBdSy2iZKCSryclFla0WjqqtlnWse
 F0huZgBiXUYg33fjEnOtwvmDDDZXQd/nKbfpZiBdxb8hVivFEM7OAwhgQPNE/kQcfchH
 AHlULg+CSvQX4RUbCJEYdklIc0K70pGsYl2uK7ODMGSyVY3pkbz8oU2oqnivk9yUg1cw
 HR9tptYigNcYGE7PshQYy3O1iJrwtpiZmS3xJcIQJamQ+3QrXdYuBJeuvBjDtG88ZDxc
 HZok9ePbZ5PeBMWX22SAblxoL6mnyWPest4vWv3lYxae/pp9DkS2HPtFZ6U+Z9qjnEPB
 9rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542347; x=1747147147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6pHJth71V1NU+j8DWvRO78dboaItuaL0yLZwlUfF5zg=;
 b=MUdJShbFHHKPfDCHB9u0Jumspzkt+hlC83bB80tIM2uqmYAzl+ApG7wS38mtsztvo/
 2kQouNvVnbRgxfc4KSdxpC1UvYrgk05sOIh93goAaD7aNKD6JgQ145WYIOXphtyr83GD
 AG2hZif5YkXyIaNZFa2rG3XHgKM/nQzbuI55X0F1y/7fw5SPYf95LsGvGo7ireq+nIHJ
 Ma7b0+1TOuI2BYjwnGwi+altIwn2PR2S3fYknAWkM8aNBh8Jf5Po4AH6WZDpT5gRDzLN
 6l4MAhO96zuKGqvaxSfZxmZr7wJJ/yMb3GiZ3Ul4XpgyS0v+GA5KYdc4UW3DnJhfn3kI
 GEww==
X-Gm-Message-State: AOJu0Yz3EXnbk5JMSp/yrNuzM1sT0NIO2dZccXPvQ+JHBb1CAOljMpmi
 CsCnaPc/RP6YHZDtfM3fGAjiIJmHmvzQIzKXa5AeTe2+NK3xGANvdeC0Pq9oZh2JvkRMFLLDWUX
 s
X-Gm-Gg: ASbGncu+BJvF3Kv/+3SBNQfzVtaRIC/i5kAMWv/78oCOtUMYuyuSZCBWiqhDhwcG1xJ
 uSnjQnOErLm4YfNapEC4zqTv+C8cTb0fZIq4FdohnTpJDqND24o0NJLKh+xMLPiDM2JmLT3qsFR
 L4+iUSOeR5FIMMxuTr8LgC94tSi05gqoDOUx6leu2DG+WlwPLE1nDNO1zDM5ZBiNEHwo2dqoz6d
 aoQTs8O3xTA4IMWdhpz6XsICDlYP1vBoikzqGN8ddijpQxC970x7+e/K5xEWbYCZXybZf0NvHon
 qIEHMp1W+2jgC/bPl5igLR+RfEaRcw1eUmgR+VWcr5E2M93lY1ENSVRVEO80XW9g7zdaZQdIXD0
 z7q+lXp0aDz9NaRZcGTpy
X-Google-Smtp-Source: AGHT+IEtO6jRSCUHQs/X0p4D/Ex7Bd32kW11LPFVrdG5NDUA1r2blDLvOigA+FA/jqJAu/ZpVnWFdA==
X-Received: by 2002:a05:600c:1f96:b0:43d:186d:a4bf with SMTP id
 5b1f17b1804b1-441d39e275emr578965e9.0.1746542347439; 
 Tue, 06 May 2025 07:39:07 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0c5esm13683960f8f.1.2025.05.06.07.39.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC machines
Date: Tue,  6 May 2025 16:38:46 +0200
Message-ID: <20250506143905.4961-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

(series reviewed)

Since v2:
- Removed qtest in test-x86-cpuid-compat.c

Since v1:
- Fixed issues noticed by Thomas

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.4 and 2.5 machines removal,
as it is a big enough number of LoC removed. Rest will
follow. Highlight is the legacy fw_cfg API removal :)

Philippe Mathieu-Daudé (19):
  hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
  hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
  hw/i386/pc: Remove pc_compat_2_4[] array
  target/i386/cpu: Remove X86CPU::check_cpuid field
  hw/core/machine: Remove hw_compat_2_4[] array
  hw/net/e1000: Remove unused E1000_FLAG_MAC flag
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_DISABLE_PCIE definition
  hw/i386/pc: Remove deprecated pc-q35-2.5 and pc-i440fx-2.5 machines
  hw/i386/x86: Remove X86MachineClass::save_tsc_khz field
  hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
  hw/core/machine: Remove hw_compat_2_5[] array
  hw/block/fdc-isa: Remove 'fallback' property
  hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_OLD_PCI_CONFIGURATION
    definition
  hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
  hw/scsi/vmw_pvscsi: Convert DeviceRealize -> InstanceInit
  hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
  hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
  hw/net/vmxnet3: Merge DeviceRealize in InstanceInit

 include/hw/boards.h                 |   9 +--
 include/hw/i386/pc.h                |   7 --
 include/hw/i386/x86.h               |   5 --
 include/hw/loader.h                 |   2 -
 include/hw/nvram/fw_cfg.h           |  10 ---
 include/hw/virtio/virtio-pci.h      |   8 --
 target/i386/cpu.h                   |   1 -
 hw/block/fdc-isa.c                  |   4 +-
 hw/core/loader.c                    |  14 ----
 hw/core/machine.c                   |  18 -----
 hw/i386/pc.c                        |  42 ++---------
 hw/i386/pc_piix.c                   |  26 -------
 hw/i386/pc_q35.c                    |  26 -------
 hw/i386/x86.c                       |   1 -
 hw/net/e1000.c                      |  72 ++++--------------
 hw/net/vmxnet3.c                    |  44 ++---------
 hw/nvram/fw_cfg.c                   | 109 ++--------------------------
 hw/scsi/vmw_pvscsi.c                |  67 +++--------------
 hw/virtio/virtio-pci.c              |  11 +--
 system/vl.c                         |   5 --
 target/i386/cpu.c                   |   3 +-
 target/i386/machine.c               |   5 +-
 tests/qtest/test-x86-cpuid-compat.c |  14 ----
 23 files changed, 51 insertions(+), 452 deletions(-)

-- 
2.47.1


