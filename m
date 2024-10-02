Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5651CF318A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 01:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svnm9-0006pR-Qv; Tue, 01 Oct 2024 21:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnm1-0006oQ-85
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:03:26 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnly-0002bY-Sr
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:03:24 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b86298710so26320335ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 18:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727831001; x=1728435801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SlhZ73ciK+p+3j/fy+Mq63OJeXjgTFX1amEfNnuVDy0=;
 b=mDl4/i2b2cornM4g2V+6cWC/lVu3e680MHq8rE0gcIMGQVtacaORKvlmcr3KMn7t7j
 7fRwNDhTvIicAAAU1vYPSMJhw2r0FUBM/+HuvzgsV1zo/ecVgCY2S+Yqr+ksOFAk2KoV
 gjZfo4VysokFxRrKxpNLeEwrZP49oQRzI7J87bOWrTJ4tiU2MuHUYK5aw0FvkJ0Om6AR
 ny66xnr2nQ7Fws1CjsgAZqkKwiDa0XKyFmliX6mDFMwcdqLDlx/aGMaWz9Q/90wERz4h
 eXfKNLD5v1qLgOZTBbNntydhgF1mqQ0e8npoJldXw31IHNb/dLGyN9sZ9RYC1vgKi0Td
 J9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727831001; x=1728435801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SlhZ73ciK+p+3j/fy+Mq63OJeXjgTFX1amEfNnuVDy0=;
 b=QVi64x7Lcvo1UFKCTtQDKUx4m7mNYxTtDGAdfjT4tkLXNCKWrkhSetl8ZhyofgwOKK
 sV2xQ0UnnPszmeAsvVVXM0Pp9+YOowUjAQQwP236Y9reAvT/ycgI7GO7Uv1NR+wSaAnI
 /oPZYMzMV1BQ7R5KkzE6AElVFz4/7vTvS5pjM0OUELAiwHoYOFkteDjlALVuUANk0OyW
 IF6ffc6LXqKJ/y/t/+tbj4qVa0HA/ZH6VVmC7lS7Dcj+7Jwy6WpxECRw3zk1+3zUusLV
 M3HIvlMxI+OO0UAwBRMUN0kOlw2VlmEso92FVwdHzyGiitSaynDlzZnCbRPifeIxFEeH
 38WA==
X-Gm-Message-State: AOJu0YyjKLkFPcWoDPW5rmlBclTT/xAHNx1GD8TWqbBtxPO7rB5sXFia
 h+DhGDYMHD9Zvjc4S4A9+JsaTkjejxwDCVMvq8mg5zXPAPQ8OmRT3P+YTFazNntQ9Xm5c2EbMha
 p
X-Google-Smtp-Source: AGHT+IEoR78xhL0U+aKqygjVd2BSvqgFocVhprN/h6fK4soZVu9zpWnDGadH8g4Pr9QDn3CssDna/w==
X-Received: by 2002:a17:902:db03:b0:1f7:26f:9185 with SMTP id
 d9443c01a7336-20bc59bc498mr19122145ad.10.1727831000776; 
 Tue, 01 Oct 2024 18:03:20 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37d63971sm76061295ad.4.2024.10.01.18.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 18:03:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 00/12] riscv: QEMU RISC-V IOMMU Support
Date: Tue,  1 Oct 2024 22:02:55 -0300
Message-ID: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

Hi,

We had problems right at the finish line of the pull request due to endianness
problems reported in the Gitlab CI [1]. This triggered discussions in the
middle of the pull request patches [2] that resulted in this new version.

We dealt with the endianness problem that was hitting the Gitlab CI in s390x.
It was a mix of test changes required in the libqos support, a solution
proposed by Peter, and a real endianness problem in patch 3.  I made sure to
test this version in a s390x VM and everything seems good.

Another change made, after review comments from Peter, was the removal of all
locks that were result of the old threading approach that we abandoned in v3.
BQL is proven to be enough, at least in my testing, to prevent race conditions.
Nothing is stopping us from changing our minds later, and even rollback to a
thread model with spinlocks and so on, but for now we'll stick to what we
decided back in v3.

The rest were punctual changes also requested by Peter and Tomasz during the
discussions in the pull request [1].

Patches based on riscv-to-apply.next. All patches acked.

Changes from v7:
- patch 3:
  - fixed Copyright text of added files
  - all functions starting with '__X' were renamed to 'riscv_iommu_X'
  - removed qemu/osdep.h from riscv-iommu.h 
  - removed unused '__rfu' attribute from RISCVIOMMUContext
  - removed core_lock, ctx_lock and regs_lock
  - converted the 'read page table entry' code from using dma_memory_read() and
    le_to_cpu() to use ldl_le_dma()
  - replaced the 'if size' chain for 'ldn_le_p()' in riscv_iommu_mmio_read()
  - added a new riscv_iommu_write_reg_val() helper. Used it to remove the 'if
    size' chains inside riscv_iommu_mmio_write() 
  - do le64_to_cpu() before using 'val' in riscv_iommu_mmio_write() ICVEC/IPSR
    path;
  - use brackets to wrap around (icvec & bit) in riscv_iommu_get_icvec_vector()
- patch 5:
  - fixed Copyright text of riscv-iommu-pci.c
- patch 7:
  - use qpci_io_read(l/q) instead of qcpi_memread()
- patch 8:
  - remove iot_lock
  - remove unused '__rfu' attribute from RISCVIOMMUEntry
  - all functions starting with '__X' were renamed to 'riscv_iommu_X'
- patch 11:
  - use qpci_io_write(l/q) instead of qpci_memwrite()
- v7 link: https://lore.kernel.org/qemu-riscv/20240903201633.93182-1-dbarboza@ventanamicro.com/

[1] https://lore.kernel.org/qemu-devel/CAFEAcA_8A=8q8aFSPwy177x6q3RLOS-kOHwyUDhTbpOjNjLexg@mail.gmail.com/
[2] https://lore.kernel.org/qemu-devel/CAFEAcA8rdFYACFKdJga72WA4ET9NFRwrOifdbTYDBxY6G6uOXA@mail.gmail.com/

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
 hw/riscv/riscv-iommu.c           | 2396 ++++++++++++++++++++++++++++++
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
 22 files changed, 3745 insertions(+), 1 deletion(-)
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


