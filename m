Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058B2C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLkp-000556-Oy; Wed, 26 Aug 2026 18:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLkm-00054k-Ax
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:05:52 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLkj-0004f9-TT
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:05:51 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1894140a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787781947; x=1788386747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b9j9XclOGiJ0VL5ZHj9sQzSscT/RcoewZliURgVoTN0=;
 b=Hzpw5VF8dLZmlPA2tKCNxQjskPNiqy5F07t88BT4Wun/dWwZkWDv5KFYrAJhhbwGSK
 /VkYEZ03CzcCF5gwIipUOThFrJaB3lW5S1nGAZKpxPDB1SJPOuj4t2Rlaopk7n9j6ry0
 EUV5K+iBV62Ph9fyfr163Lam0X1Mnv0VIZDVKRXW6KNtgAzoyN3n1Bi2agUw348pZFIn
 iR7YG484nid6HrTbq+u9zkkVmSH1jfj1YEhB9GoRtcgxYdTAOE8ZGtLkQE7ju0YK9a9k
 ZSTQ2F5j5hN6PoQ5qP5U2hV+jIdIXlSnsSuvYRfNRGXllmK8bIPekcUiig60/XifE+ht
 jGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787781947; x=1788386747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b9j9XclOGiJ0VL5ZHj9sQzSscT/RcoewZliURgVoTN0=;
 b=ryFu7bHguvkl7uiOpXH04pNAL0XcXq05J7ZVSGTgxNtFVUy1JqCIBK45gWXqugdtYi
 PWAL/moM55MnIroRv/iUyOfX7WiUXExsSUHagdHkU+l1ANTiyrGeYUydlNPRkJjv5Ilj
 JlrHkAUSEaxKvcIkVA3rBrsYwPeK3S6t2TSEDVEAsIbWW8pS6+JhDGnypd2BzTxY7VJt
 o8xHerRa30DUv6fOovcUoX5kNGZMHWiOTx4NgUi50fCrNqOoxIaDpSlAieeCgAzfScCx
 cbgx35sTVdETynT+fyOz9cP6eWYWfgDSy3aRWhhz+yJicPomcfEtvflIvGvmdNV+P50R
 3Dbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYlGkJ6wBvFpl6OMbLETu49BGrD4X3O6/VgwstOF0p3+/352tbMWTegqivCYt7yihgwtRjeg8yA7r9@nongnu.org
X-Gm-Message-State: AFuF++kqN3pN1SagJhIgDuvh40NJXHTlMsvjRzons56REbrcpv3g/XIa
 JaXJ8aIU/WXiNkY1iNxc4ScDTEeCTob5IlkWUF72VK+9Is0LanekB7qx
X-Gm-Gg: AR+sD11kjeAtu3QMBzqPflC9sIL3aJowxpq3eESjJXplGuIkGTnu4OxQoPeu03ktgkY
 JDUA/NnReDKH1NvTSYiR2MIuXo/JX2kmObGU12GhQWPnH1H1ippGW6zlweCGEr2EGPO8pmATt0Z
 Wt0vMT0q907mcC+nJu8VrENwtJjdyPflTSqcjxTxlwDLcfsx9L82ZOBUqX8wfARZkpRUpvdmzOT
 z3KDUNaVA44z8Tb7QxXdHtF7WvJiU6LmEQmdlu9dot7P3iP2IdIvd/FDjYimpxP4P7jdSxLJ53J
 Rtd0z/0hqjG2OivAasK8J41FJj1MGfJ2oRtTcEijs3H3EO1G46yq8hOBurH6YRNNmSvn8pEcOQI
 SF4UVXi78j2uFG8E7XKyGKmgd9aYge2EODu9yxqlUOK4oCgL6S8czgWcYLGLs5rsN60/8xwAmST
 KQD2DJJyxto0/i2aSc7NklStbujRpz+nWmxrCLAQzoFt6t8CIRHKBFpEVLPblqbSkV9OrNODk3w
 RG7f4ISCSDIRZ/k4wh9msf6xek7nuFY0nhxN63EHwpJR9qPBI79fFiX0DiTXB+6FMT3yKCKMsqB
 eMS067+TGcSlqC8mq0Mi
X-Received: by 2002:a17:90b:5102:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-3966d370333mr22434531a91.3.1787781947257; 
 Wed, 26 Aug 2026 15:05:47 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a573a1sm5789956a91.14.2026.08.26.15.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:05:46 -0700 (PDT)
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
Subject: [PATCH 00/16] hw/riscv: Socify Atlantis
Date: Thu, 27 Aug 2026 07:35:10 +0930
Message-ID: <20260826220528.54516-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102f.google.com
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


