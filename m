Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E048FC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20NL-0006UN-Av; Thu, 03 Sep 2026 01:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20NI-0006Tu-UI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:52:36 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20N6-0006DM-8Y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:52:26 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3964dfb5a69so2709755a91.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414742; x=1789019542; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dK6bje5b0/dxgW4rjh0ZrXVM3LSv9xhL0+dqZvcRtHM=;
 b=Pqb+qm0oIc63Z14RUmip4dAWaShhR/jlJV3ACkKxrq7kpfelZez0aVZUq3P9TNQ6Te
 nrBmn7yIEFr4apVpJ6dWSip1R7x2gJYhewxPerhfmsOLUnvhOpulukfCeYhzcOS7Mbe2
 BdTms2JlUNygVFpc9c4PVpggZvzJ+ww55qAkyksBkd3fT8J0ZxvytREwFhOGlHpmj4di
 A9Dkdjd6WFcj0s0n4CNkD6d3n+oMjSFVZr6KWJtAqWS4Sv7eSbpDF20niyps8LgNb/M2
 3V8RnIh3Y/YVuZubvOGLu0HNpGkVtyXlhkcNjclL4KAJ+ejk6HM52fzb3EoYgPI6jVDy
 Zxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414742; x=1789019542;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dK6bje5b0/dxgW4rjh0ZrXVM3LSv9xhL0+dqZvcRtHM=;
 b=QLBmH0QyMZzajkgj0WJNRjzdPSzgJUDNG+25blJ+71zfTX78Tz6T9oiLykwSObY6De
 s6iJCaYzrlO301pO7OBP2sP1LYPcqxvhsEAAtafKqIneowLRiOdOYzTIfTP7PqWdQQ+4
 iT2509e5Q4j71AOiuzpLtBs8op09ZN8sGJhGEM7ksyMYIas8L1E6L13or5QiN7Tt9mLW
 PPaVg66WKfIT4+zfh509retOpm3zkKs2s657H7Lq3q/L18mYLT1FsQk+cQkJzY6t7ecI
 FTKOSHOEpLnSC1zthU+Id/KV7PMvemeEr0tBPT6k8Yi7VVXJ3ymQPQPtk88n35paiiFW
 Qsdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwN9SM6zVZ5AxGN78zuUab3f0xgKAbUzwRIteKXeHj0tYdeo95ztWhRoeEu/hXjBkJQVGKqyYJY+gLn@nongnu.org
X-Gm-Message-State: AFuF++mpDv1q+ddkDiPOY/AQA+o8rwT4fLm0sWeUsky3Qzz3TomKAV7L
 4ax3bL/H0CCeRHwBMzP2Pmn8ZWRzl1TTDPLP6rswYXyI1K3kn2FZU1sF
X-Gm-Gg: AYBFou0jpSCTB9Tij5GG0SiKiEbf5ShIo1ul9stHvTpcPBvHXDW1QpVvnLI3Qm7L7iq
 R9/bjtevKJKzq81/oeIph2a+VFjiw/jPsTKj0PFHU6lZNHV04XkOslI7yHjHeoLgni5LYeimPyR
 2jzUwz5f/ncoAxpEn0+heBeVpIEMJ1JY9uh3/a8jKK9qmBGKcsQzHp6QBEyP3p95etR3/gAX/at
 7bfG1GDBzJavvJqvyYAbqTfkVo3Ljxs3d8uT5x/QdJ+4gDM1onFvUJXvsqXpDpnZWFJVqffjp8l
 qwn/65d7iyHlh2+OVq1E9sne9wArvqrabvJoeSqUBNAQPwewnJUefvubK1wpL9lWiQKMF4RU7RR
 kNXCz5wyXywCWxsCTfrOISdl43fkkzIMAj0n9B6KZlv3deubrSa5pRVmT3/QvXaMwixXkdFRBui
 6QAe4nXhRbKs4j/mehnwTmelrFBQ3nMmg094MkCYjHrYPxnefLWOR1kHJ4cx5N11zRcXZBZXz09
 qHbDY/H/nEWvehlIPcdc+hdeEgiEGK11gfSzYNG93PZ8kUPmN3dhMu2BPEmxpkYhwvxelNhf3eR
 Vng1q3Vhm0H3bCTChc0tjYPXXO1v2JWo
X-Received: by 2002:a17:90b:4d82:b0:398:9be8:ea65 with SMTP id
 98e67ed59e1d1-39aee1ab4c4mr12691273a91.18.1788414742166; 
 Wed, 02 Sep 2026 22:52:22 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:52:20 -0700 (PDT)
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
Subject: [PATCH v3 00/16] hw/riscv: Socify Atlantis
Date: Thu,  3 Sep 2026 15:21:14 +0930
Message-ID: <20260903055131.257903-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1029.google.com
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

v2: https://lore.kernel.org/qemu-riscv/20260831021500.82565-1-joel@jms.id.au

Changes in v3:

 - Rebase on today's riscv-to-apply.next, fixing conflicts with the
   device tree rework
 - Take up Phil's suggestion to change @mr to @container in the first
   five patches
 - Add r-b from Alistair, Daniel, Phil. Thank you!

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
  hw/riscv: Add property to hart array to allow private memory

 hw/riscv/aia.h                 |   3 +-
 include/hw/intc/riscv_aclint.h |   7 +-
 include/hw/intc/riscv_aplic.h  |   7 +-
 include/hw/intc/riscv_imsic.h  |   3 +-
 include/hw/intc/sifive_plic.h  |   4 +-
 include/hw/riscv/riscv_hart.h  |   2 +
 include/hw/riscv/tt_atlantis.h |  32 +++-
 hw/intc/riscv_aclint.c         |  12 +-
 hw/intc/riscv_aplic.c          |  10 +-
 hw/intc/riscv_imsic.c          |   6 +-
 hw/intc/sifive_plic.c          |   7 +-
 hw/riscv/aia.c                 |  17 +-
 hw/riscv/cps.c                 |  12 +-
 hw/riscv/k230.c                |   9 +-
 hw/riscv/microchip_pfsoc.c     |   8 +-
 hw/riscv/riscv_hart.c          |   8 +
 hw/riscv/shakti_c.c            |  10 +-
 hw/riscv/sifive_e.c            |   6 +-
 hw/riscv/sifive_u.c            |  10 +-
 hw/riscv/spike.c               |   4 +-
 hw/riscv/tt_atlantis.c         | 280 +++++++++++++++++++++------------
 hw/riscv/virt.c                |  21 ++-
 hw/riscv/xiangshan_kmh.c       |  17 +-
 23 files changed, 326 insertions(+), 169 deletions(-)

-- 
2.47.3


