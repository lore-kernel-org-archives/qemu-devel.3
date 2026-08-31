Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF8CC61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rYg-0003L4-Lj; Sun, 30 Aug 2026 22:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYd-0003Ka-5S
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:36 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYa-0007V9-W7
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so2378204a91.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142531; x=1788747331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mz4O3HnecUoq3Wz4In0RBCgqMHQ8636EaSh9x7GcB4c=;
 b=b4RhYoZBQ094DX4v3HLk9+/hszmdG/I0VJHqXj29rLenT/qyU5dGH0C318z0HSPU/G
 pWoQdgh+EN8kJIs8XVJ0eE2m54493cs4YENjWWM2buBZKBmTcPChxzmkB5RvdEOYKCTh
 FLnqjBkGFv3lcUr8ul9BCXbSlCBgJ35F6FiPFH75Ihia+4UcW1ZFFXyhSEd1SEYVvCmI
 9usGL3v857Av0UMkxPs4BiuH6sDO1NiCMXsItb3S+C/2qCzdHMI3HaRhOQTixiH3RRpo
 tDbLpBM9afRv5njDwZWydvfu/FvQaBH0sGQzBSYbjFTN89sZgS9p82SnNqevMlISM5i4
 wadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142531; x=1788747331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mz4O3HnecUoq3Wz4In0RBCgqMHQ8636EaSh9x7GcB4c=;
 b=jv/omYUf69xx94F2PTMwPfY+Y48kSffDaPoWmrIi1wfZM/nmGOjr4iKESZzx4fymIW
 5YLOBSBEU79wU48OucXJM4KzX0DWr3aFWxHg73J/0EF3Qvsp86HnzKTwbtXHr95tbL0y
 PNrCxWR+J5eTElcDQPeofXhXV2xxFs3o+OcdHyNzasBwiSaEHJ/UM9LWkURkderPYzCj
 Fcdli7nXUXtDVG1Ucvqmwq22QoLNJnNmInkPNybOlZnzSCuZMwHQkPLEcJIp5DFFb7GU
 68hdCtEMcNzipVsnG5tBn5y5PEwxp0nfWADpmE14bgA6xfogoD6vEI9ctDY0406xzOqA
 Ur8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBykboGwtY6vwiPtUtvlhkA2QrjI2e6Vb7CDPLh4sJ9cQqGOlIbtqMM5z5d7kAN8UrDwY3qSAg5/mXj2@nongnu.org
X-Gm-Message-State: AFuF++mdRgby3em1HTbN5SQJsPP8UKZ2hg7WcmuD7JTLUrRWBGBiI2EV
 YgHG0FqUVuC8THHj5NYOQGbchPx5+u1uXSYOQxG3B4jGNFBWtXzNYFPc
X-Gm-Gg: AYBFou2HqEJ8xMyJJQ27ihs2iPYtNoTTuiDu5mzNehNem43iAmea2h2igGWDHEtG9Lb
 XwFlDPNJ/eCjgp2yzmfsUtBE6bV7QIdSGruW8Qxi8DYnpeXvL55K0Me11aLZ93roM0EhrK8X9pc
 qLJETTd+WUiAXOMpiUkrUVpT5L0QPbI2biwz06inb+TkCkWZH0ZmuKoO3UPiLk9eV4QlXz/Hho2
 XR6z9Z8m+KuIvXHG2OYqdlZ4H/4beTRT5Lv1f5MQv+keM4bgdWKh05suW+d/ieeRfhTVKyDImLo
 Ct5UBWliJl5J/pjQ6SyAYcY6p1q7mCnC0kSO71Cr03tUq2zXVgelTuYQWPouUiPkXd9GSQGpj1B
 eSXrbnJFy//mRIkrTV4XHm1H/Hd9XCgoUgPD+5tRhQxfJCZ0dLnndBvR8zh/01VgmlNjG8H15rc
 UNWdxEAIUbI4P8aJ/k1ynMbYfpGhHjiTpG0nrT0KMZyMwURHKQlXzTR35FUQQDqvqvdRNTeyVat
 zgn6453a+OQ5Hv8oj12k7bvFu+QWhbBIGJIJuZ7rQq9pWZeI8rqLsIXWU+0QNJDH5QZfjksRDZY
 qF4oLd8jiv4r75KuDE/U
X-Received: by 2002:a17:90b:2886:b0:398:de86:5ff0 with SMTP id
 98e67ed59e1d1-398f88df3c3mr365943a91.19.1788142531121; 
 Sun, 30 Aug 2026 19:15:31 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:15:30 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 00/16] hw/riscv: Socify Atlantis
Date: Mon, 31 Aug 2026 11:44:41 +0930
Message-ID: <20260831021500.82565-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v1: https://lore.kernel.org/qemu-riscv/20260826220528.54516-1-joel@jms.id.au/

Changes in v2:

 - Reword patch 14 "hart private memory" commit message to clarify hart
   vs hart array
 - Fix indentation in patch 4 (riscv_aplic MemoryRegion)

Thanks to Daniel and Philippe for the reviews.

Original commit message:

This addresses the review given by Cedric on v1 of the Atlantis patches,
where he suggested making the machine a SoC. This is the pattern
followed by the Aspeed ARM machines, where the SoC represents the
modelled hardware, attaching its devices to a memory container, with the
SoC instantiated by a QEMU machine that provides the memory container
and the machine's RAM.

Aside from the clean abstraction that this encourages, this pattern will
be useful in adding other SoCs to the Atlantis machine, such as the RCPU
(boot microcontroller) and CPL (Cluster Power Logic microcontroller).

The series converts the RISC-V interrupt controllers to take a
MemoryRegion for mapping themselves, with no change in behaviour for
existing machines, and then cleans up the CPS device to place its
devices in the memory container provided.

The next few patches clean up the Atlantis machine to make extracting
the SoC device and mapping it in a container relatively straightforward.

Joel Stanley (15):
  hw/riscv/aia: Take a MemoryRegion for the created devices
  hw/intc/riscv_aclint: Take a MemoryRegion for the created devices
  hw/intc/riscv_imsic: Take a MemoryRegion for the created device
  hw/intc/riscv_aplic: Take a MemoryRegion for the created device
  hw/intc/sifive_plic: Take a MemoryRegion for the created device
  hw/riscv/cps: Map interrupt controllers in SoC container
  hw/riscv/atlantis: Make UART unimp region a SoC device
  hw/riscv/atlantis: Remove unused fdt_size
  hw/riscv/atlantis: Rename hart array 'soc' to 'cpus'
  hw/riscv/atlantis: Rework device tree creation
  hw/riscv/atlantis: Use local reference for system memory
  hw/riscv/atlantis: Decouple RAM size from MachineState
  hw/riscv/atlantis: Make TTAtlantisState own memory containers
  hw/riscv/atlantis: Extract an Atlantis SoC device
  hw/riscv/atlantis: Map the SoC through a memory container

Portia Stephens (1):
  hw/riscv: Add property to hart to allow private memory

 hw/riscv/aia.h                 |   2 +-
 include/hw/intc/riscv_aclint.h |   7 +-
 include/hw/intc/riscv_aplic.h  |   2 +-
 include/hw/intc/riscv_imsic.h  |   3 +-
 include/hw/intc/sifive_plic.h  |   3 +-
 include/hw/riscv/riscv_hart.h  |   2 +
 include/hw/riscv/tt_atlantis.h |  32 +++-
 hw/intc/riscv_aclint.c         |  12 +-
 hw/intc/riscv_aplic.c          |   5 +-
 hw/intc/riscv_imsic.c          |   6 +-
 hw/intc/sifive_plic.c          |   6 +-
 hw/riscv/aia.c                 |  14 +-
 hw/riscv/cps.c                 |  12 +-
 hw/riscv/k230.c                |   9 +-
 hw/riscv/microchip_pfsoc.c     |   8 +-
 hw/riscv/riscv_hart.c          |   8 +
 hw/riscv/shakti_c.c            |  10 +-
 hw/riscv/sifive_e.c            |   6 +-
 hw/riscv/sifive_u.c            |  10 +-
 hw/riscv/spike.c               |   4 +-
 hw/riscv/tt_atlantis.c         | 277 +++++++++++++++++++++------------
 hw/riscv/virt.c                |  21 ++-
 hw/riscv/xiangshan_kmh.c       |  17 +-
 23 files changed, 317 insertions(+), 159 deletions(-)

-- 
2.47.3


