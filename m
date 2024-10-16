Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A8ED1AD45
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ApC-0004Aq-Fi; Wed, 16 Oct 2024 16:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1Ap9-000493-BW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:40:51 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1Ap6-0004bf-AM
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:40:50 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e3d523a24dso175400a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729111245; x=1729716045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=igh5mCCa45zVdSMgTR9Sg53Z9Gk2P3nQElo7HTvMwp8=;
 b=Blowfvub8TAtUH/624pYvL5I/7dUH10fmeL6GRgzYw1MjcAr6oJ8mkBknwDkS08le8
 To+HiECBlkj9aXFFEGfBlYeolvNHY6hk54+av54KXn8Q+UUwM0AS/TlhhbAx3KKbMHm/
 T1mIKTDBcOroCpYR/g4o2dX8oqQFfc/mhG2WVBTXIRr5XHmuOoCxJF0VckIkYjpFxbT8
 lJkpT1jGo6Ze6j37I1uBoiFBHml0DfWhovbnFI+9u2FZIOI6W8BtqFAl0StTNwjxQqyn
 I2IlCqE7dH5RiMHSENuevYZFg1eEym29T5bqm0MI5BeEB7t4+hVq+UMeTBQvuMjG1p3e
 GgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729111245; x=1729716045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igh5mCCa45zVdSMgTR9Sg53Z9Gk2P3nQElo7HTvMwp8=;
 b=a/8XxmDLn4e887c1qky1SsWgVHBl69pxxtEk5qMWW/OByQuhgpy7f51Hja9C6k5ZQ8
 s5yRo9daRW1+zFkW/fwW1VIh7vGbMiJ7F7FHNMnb6RFaw1WmwK3HJqInb+gvTS+i5OBy
 DgFZ4Y2NhfMm7hcrex1/cpkmtxwEyoXm5poyNSTxEJYB77XtwJVu4jQm6RuyF4ZzOgZ9
 AWRMdiwQukT0oIWfxM85d7TnNttCom8o0UcfqOGdAyKlJyZMLFdbdV1TPVxeiIuFzZ7N
 uR4tIqVcQ5BA2/ABHoAD1nggQRcu86kNQF6Ui7U4rPs/4aagRvQsXUW9DNSVfASvlSh9
 O/Tg==
X-Gm-Message-State: AOJu0YwIJg6K89Lw4iq6yEIdjkQ2n6S1eNQeCo2L+oehiSOHF9zYizA1
 uTKNfDOP+/A6Ck7ZdWQLKTFaIC6LZ17g7jhhMREsp0nR0OxHdc/n2rO+w9HpY1Fcb6fL36y+6ZZ
 O
X-Google-Smtp-Source: AGHT+IEvjxU3S/vg1O9J6hb7WndUw9xEA9M9uBovBR971LFudAfTOnTrtGaKmL65/6fPOlGCGc9/sg==
X-Received: by 2002:a17:90a:f184:b0:2e2:e82d:48cf with SMTP id
 98e67ed59e1d1-2e3ab7fc85fmr6211847a91.16.1729111245276; 
 Wed, 16 Oct 2024 13:40:45 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e09085cfsm242158a91.54.2024.10.16.13.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 13:40:44 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 00/12] riscv: QEMU RISC-V IOMMU support
Date: Wed, 16 Oct 2024 17:40:24 -0300
Message-ID: <20241016204038.649340-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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

Hi,

In this new version we fixed address alignment issues in some command
queue commands, pointed out by Jason in v9.

No other changes made. Series based on alistair/riscv-to-apply.next.

All patches reviewed.

Changes from v9:
- patch 3:
  - fixed cmd.dword1 alignment in riscv_iommu_process_cq_tail()
- patch 8:
  - fixed cmd.dword1 alignment in riscv_iommu_process_cq_tail()
- v9 link: https://lore.kernel.org/qemu-riscv/20241004155721.2154626-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (4):
  pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
  test/qtest: add riscv-iommu-pci tests
  qtest/riscv-iommu-test: add init queues test
  docs/specs: add riscv-iommu

Tomasz Jeznach (8):
  exec/memtxattr: add process identifier to the transaction attributes
  hw/riscv: add riscv-iommu-bits.h
  hw/riscv: add RISC-V IOMMU base emulation
  hw/riscv: add riscv-iommu-pci reference device
  hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
  hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
  hw/riscv/riscv-iommu: add ATS support
  hw/riscv/riscv-iommu: add DBG support

 docs/specs/index.rst             |    1 +
 docs/specs/pci-ids.rst           |    2 +
 docs/specs/riscv-iommu.rst       |   90 ++
 docs/system/riscv/virt.rst       |   13 +
 hw/riscv/Kconfig                 |    4 +
 hw/riscv/meson.build             |    1 +
 hw/riscv/riscv-iommu-bits.h      |  421 ++++++
 hw/riscv/riscv-iommu-pci.c       |  202 +++
 hw/riscv/riscv-iommu.c           | 2399 ++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h           |  130 ++
 hw/riscv/trace-events            |   17 +
 hw/riscv/trace.h                 |    1 +
 hw/riscv/virt.c                  |   33 +-
 include/exec/memattrs.h          |    5 +
 include/hw/pci/pci.h             |    1 +
 include/hw/riscv/iommu.h         |   36 +
 meson.build                      |    1 +
 tests/qtest/libqos/meson.build   |    4 +
 tests/qtest/libqos/riscv-iommu.c |   76 +
 tests/qtest/libqos/riscv-iommu.h |  101 ++
 tests/qtest/meson.build          |    1 +
 tests/qtest/riscv-iommu-test.c   |  210 +++
 22 files changed, 3748 insertions(+), 1 deletion(-)
 create mode 100644 docs/specs/riscv-iommu.rst
 create mode 100644 hw/riscv/riscv-iommu-bits.h
 create mode 100644 hw/riscv/riscv-iommu-pci.c
 create mode 100644 hw/riscv/riscv-iommu.c
 create mode 100644 hw/riscv/riscv-iommu.h
 create mode 100644 hw/riscv/trace-events
 create mode 100644 hw/riscv/trace.h
 create mode 100644 include/hw/riscv/iommu.h
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 tests/qtest/riscv-iommu-test.c

-- 
2.45.2


