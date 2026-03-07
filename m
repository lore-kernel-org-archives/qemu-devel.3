Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1128F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytYC-0004vI-Im; Sat, 07 Mar 2026 10:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYA-0004uq-Bk
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:26:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytY8-00083v-MY
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:26:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48374014a77so122740185e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897197; x=1773501997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IUUztl6bBSgFR7lWmLOci/LHNfy+HKTr4AF7IDnJNFw=;
 b=kTZMN6ixzUO6cfcu0WabPPqACdWcaM9L/rLx4ZpOtCq8xkFDdXQJo3tA+l1b0CMHfb
 y2MnpG90+KWm+YHz3yu5ICNyt1DUu+a3AXsHg6Ioiaf8PV9YbggXOaIHoyGHbajzqEkC
 SLggzrN4/+hzJ3W32KYd5/NB+lf2IEVk0NX+gDjfkUt2hGHECRUEobQytGAXYTs3UY9F
 xTP2B3hX+RF+fRyQ123W7MeK81Yhl6U2yCLXNbVPjIc5AqskIgCxLiQXDWtPu9le6Hca
 cHUa65S9VfT7o+diLluZcZmQmTkDhXiDrUe1yK9mx/KL1OYkPLiCG43n+mtGpPhuRM4D
 IyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897197; x=1773501997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUUztl6bBSgFR7lWmLOci/LHNfy+HKTr4AF7IDnJNFw=;
 b=ilnKSpEkRLtxlaHwoJHbDB/Of2aaNcYPT4GLtPYl7IGO1WnKu1UoivqVau2QAAga+q
 IpyycAxIs57FS4X8X9CRn1PtdwT+1vr2g/Qlh0u7+6SuZKia571+HQ6+TMju7uF+NrTf
 XYzSQLQOvgcPOvQBv6B9b4R4sQOir6x1Rp0YacvlLig9lNJw3QPi80FHX+sq+j0gxbac
 xqeiSX0I6xhVXCnn1ViQC5/mSCkTjeLSMG/GvNFBZ4nipCX6Ldt/SP6V64+aeYls5rPD
 tt70aH0VLsamBH/z6kCkBABBvGBIaPtUnpN6v9F91H0vECYytDvruleeT1KeiCOCAYyO
 Gclg==
X-Gm-Message-State: AOJu0YzszsS/Mw9mEnaaha/TRrCw5oCIR2mffJK8SK7O57SERFrg3rM7
 zc9ilnI15vI0XZaqNvb1RvAexJQiH9gCKo8K3g/4x0jHWePD7ylhrXrkVc056OX09pIKOWAcQYX
 zZqrJhLQ=
X-Gm-Gg: ATEYQzzc8NxQoKohGcmI8TcUKvPYMySegJg+tKqATxEYjDvzbVAwNbZ7c8KpBS3ajuJ
 UMsaJin1BbjY6f71tzThWsv6GDbwcJ1Ef5EqlUJShge1rKkRPCemcUT4GWamxfO0CRUlFnCp0Uw
 aTa5v2P7ouxRIIbyeg0UUXy9lxmwBNseTFp9wEDzOlYxZThCTjifA5ih7TvYikmurcNDm0bW1QA
 2YAwwWMiHng6y4QmXbzM4eYiNkyfW6Gi+1i1GmGTnXaxCKagwCNgfjA+XWO3fGzwbw0KW4dqmuQ
 qNcDpOnAv0CemodnALa3auaJUkMwRKrEZTpfi1raF5zG7J2PNOVr3Nm6e4oOEO2pn5TO2uKj+ha
 vOzm+4SQjWrsLHSyti/HFEEFYEXayHjjQCQ8ZgELNKviuBdgEmhIJAALHUt72P7jbjQAH7h3rJG
 dED1K8FPSQjZflVOFdI4KGEbQuhIiincAUab3VJqy7pFjCGHanpsOBEnf76wQQ4ymww/CuLXHg
X-Received: by 2002:a05:600c:1d26:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-4852691abc4mr105966985e9.2.1772897197478; 
 Sat, 07 Mar 2026 07:26:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm116141745e9.5.2026.03.07.07.26.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:26:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 00/10] hw/i386/pc: Remove deprecated 3.1 machines
Date: Sat,  7 Mar 2026 16:26:24 +0100
Message-ID: <20260307152635.83893-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

1 y.o. dust Thomas asked me to rebase & post:

The versioned 'pc' and 'q35' machines up to 3.1 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

Based-on: <20260307150042.78030-1-philmd@linaro.org>
          "hw/i386/pc: Remove deprecated 3.0 machines"

Philippe Mathieu-Daudé (10):
  hw/i386/pc: Remove deprecated pc-q35-3.1 and pc-i440fx-3.1 machines
  hw/i386/pc: Remove PCMachineClass::pvh_enabled field
  hw/i386/x86: Remove @pvh_enabled argument in x86_load_linux()
  hw/core/boards: Remove MachineClass::smbus_no_migration_support field
  hw/i386/pc: Remove pc_compat_3_1[] array
  hw/i386/iommu: Remove IntelIOMMUState::dma_drain field
  target/i386/cpu: Remove X86CPU::intel_pt_auto_level field
  hw/core/machine: Remove the hw_compat_3_1[] array
  hw/pci-bridge/pcie_rp: Remove PCIESlot::disable_acs field
  hw/tpm: Remove CRBState::ppi_enabled field

 hw/tpm/tpm_tis.h               |  1 -
 include/hw/core/boards.h       |  4 ----
 include/hw/i2c/pm_smbus.h      |  7 -------
 include/hw/i386/intel_iommu.h  |  1 -
 include/hw/i386/microvm.h      |  2 +-
 include/hw/i386/pc.h           |  6 ------
 include/hw/i386/x86.h          |  3 +--
 include/hw/pci/pcie_port.h     |  3 ---
 target/i386/cpu.h              |  3 ---
 hw/acpi/piix4.c                |  8 +-------
 hw/acpi/tpm.c                  |  4 ----
 hw/core/machine.c              | 17 -----------------
 hw/i2c/pm_smbus.c              |  7 -------
 hw/i2c/smbus_eeprom.c          |  4 +---
 hw/i2c/smbus_ich9.c            | 10 ++--------
 hw/i386/acpi-build.c           |  2 +-
 hw/i386/intel_iommu.c          | 11 +----------
 hw/i386/microvm.c              |  2 +-
 hw/i386/nitro_enclave.c        |  2 +-
 hw/i386/pc.c                   | 31 ++-----------------------------
 hw/i386/pc_piix.c              | 13 -------------
 hw/i386/pc_q35.c               | 14 --------------
 hw/i386/x86-common.c           |  6 ++----
 hw/pci-bridge/pcie_root_port.c |  3 +--
 hw/tpm/tpm_crb.c               | 12 +++---------
 hw/tpm/tpm_tis_common.c        |  4 +---
 hw/tpm/tpm_tis_isa.c           |  7 ++-----
 target/i386/cpu.c              |  8 --------
 28 files changed, 21 insertions(+), 174 deletions(-)

-- 
2.52.0


