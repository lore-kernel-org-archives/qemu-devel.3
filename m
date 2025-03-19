Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E810C36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoOl-000819-UN; Wed, 19 Mar 2025 04:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOZ-0007yV-2e
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:26 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOW-0004Nw-HQ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225477548e1so115047185ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371397; x=1742976197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d97oawvz8CwDMw6pfcxqX05lgcbKJXMjocbN9tIklM8=;
 b=JGkHbzfYM/rgM3secDpzIeSkHKM499F6uZYk6/89ouCTac007vtuJl3eU3j6sCpD5l
 XMX6LheqIV7usNiEGgao0MCWhGe7JDpfSDjoShkycGNiUZFzQbTikZzMUgmR53is1Azg
 zCSGmDnik5eT8OLq0KuCcAHbX1H7f8X+9e0nfujg1JNkI6ImwQTkZ6sdTwGAhQUc8Rsu
 7Nddiiy7UC3KaPIdux+K8QQdjCi2qs++GmQx1/FXVc3GtG8x3z2VTkCOGpmo6Q7dGweF
 2Gs0HTTsDrn8VY6NTt+zyrBYmpLxi6Ca/D/1z58aT2YBr6R2Lw9c9x8qSBnyJOs2vDEK
 i/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371397; x=1742976197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d97oawvz8CwDMw6pfcxqX05lgcbKJXMjocbN9tIklM8=;
 b=Xln1lp/LOZa01kThQoGKxuxoCqw/oj7n+E2eQTPS0Z06xUMGIsecE7RmDJVLCe9OHp
 5NMYtInB8NbOuZw5uGQSPMhPhC5/cUFTKDvJohROJtWFBto4nAbbAxdzbDrofgpJPvmI
 /kMA0D6KbZWYsBthd47YsEvXqYnOUn7Zh9eORMKWLnuIqmXuuIgjEV6i+n+zzLXqYEA+
 +lPAi4fBKynmbIUKXQJ8GKC1KCMT2Q+LEHF5HSmTSmtlL7OCHfxeNYUpqnI/ygUUbt+F
 BjOVyNja5jaOSXbnYQAtP9RHd5ucWubvWedRLUair/2rbvvahlMw9LPNqrMKXlNkJ/AH
 5QKw==
X-Gm-Message-State: AOJu0YyNIn5bfqhncFxnb5CHLFkIWWIkT0LdM+K5zfNg7joN4vDihmWa
 zufkB4Jc2KeMEwB+YLRTgpHJU0I2QrseeQT1I6nobVmU7RU/owVbGsycJg==
X-Gm-Gg: ASbGncu5hkXv82oZn88ggYdlKJk56mfZStk5L/nFso/MkVH+y7bsxyUZhvvwMaG7JZg
 SUsuPH8T9FBhI8Ydi4AzdOWIj01AtPMmZNpzgstBWwRJsXoaYg3CXn25FYnmoDQSzWgqhnS7/hh
 7A4+ZWq3PXg/brqqejLfR1Odv11FGJyxSNJtvVoMr5b9L0mXexq2dbyUuKKiSXrzRloeZoCdgqh
 K5BZiL7Wx7YKboWmb8ANGPjocd9H5/NN8Errs/Tr38sE8HsZ7acxLu8Gp/ZGvPXomNmHJyaSkgY
 9Mf7ZvUx0dRtbLmZ5VpA5z5RttwVPdJipdvtN6jlns2EbATzg2v8w8LM0A5urH3aW4nGiqrIuL5
 +pejsIeiJf1xei3O66Z8YZMqNc9qWGkmX2SCzw+XCebi94012
X-Google-Smtp-Source: AGHT+IEAV8fFfRpyJBGZ3hXjffYhIQ6BSkYoeqeyvus7oYLrOOFvD61SiP0a6fmT9V77zcmHq9AzDA==
X-Received: by 2002:a17:902:f68e:b0:224:2a6d:55ae with SMTP id
 d9443c01a7336-22649a6a8f8mr31076955ad.48.1742371396651; 
 Wed, 19 Mar 2025 01:03:16 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:15 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/10] riscv-to-apply queue
Date: Wed, 19 Mar 2025 18:02:58 +1000
Message-ID: <20250319080308.609520-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 1dae461a913f9da88df05de6e2020d3134356f2e:

  Update version for v10.0.0-rc0 release (2025-03-18 10:18:14 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250319

for you to fetch changes up to ffe4db11f8aed79c7ec7d3ebd92674a1cfab4fe7:

  target/riscv: Add check for 16-bit aligned PC for different priv versions. (2025-03-19 17:11:46 +1000)

----------------------------------------------------------------
Fourth RISC-V PR for 10.0

* Fix broken emulation link
* Optimize the memory probing for vector fault-only-first loads
* Fix access permission checks for CSR_SSP
* Fixes a bug against `ssamoswap` behavior in M-mode
* Fix IOMMU process directory table walk
* Fix OVERFLOW_BEFORE_WIDEN in rmw_sctrdepth()
* Enhance VSTART and VL checks for vector instructions
* Fix handling of cpu mask in riscv_hwprobe syscall
* Add check for 16-bit aligned PC for different priv versions

----------------------------------------------------------------
Chao Liu (2):
      target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to accept vl as a parameter
      target/riscv: fix handling of nop for vstart >= vl in some vector instruction

Daniel Henrique Barboza (1):
      target/riscv/csr.c: fix OVERFLOW_BEFORE_WIDEN in rmw_sctrdepth()

Deepak Gupta (2):
      target/riscv: fix access permission checks for CSR_SSP
      target/riscv: fixes a bug against `ssamoswap` behavior in M-mode

Jason Chien (1):
      hw/riscv/riscv-iommu: Fix process directory table walk

Paolo Savini (1):
      optimize the memory probing for vector fault-only-first loads.

Richard Henderson (1):
      linux-user/riscv: Fix handling of cpu mask in riscv_hwprobe syscall

Santiago Monserrat Campanello (1):
      docs/about/emulation: Fix broken link

Yu-Ming Chang (1):
      target/riscv: Add check for 16-bit aligned PC for different priv versions.

 docs/about/emulation.rst                      |   2 +-
 hw/riscv/riscv-iommu-bits.h                   |   6 +-
 target/riscv/cpu.h                            |  12 ++
 target/riscv/vector_internals.h               |  12 +-
 hw/riscv/riscv-iommu.c                        |   4 +-
 linux-user/syscall.c                          |  55 ++++----
 target/riscv/csr.c                            |   7 +-
 target/riscv/op_helper.c                      |   8 +-
 target/riscv/translate.c                      |   4 +-
 target/riscv/vcrypto_helper.c                 |  32 ++---
 target/riscv/vector_helper.c                  | 186 ++++++++++++++------------
 target/riscv/vector_internals.c               |   4 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |   8 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  17 +++
 14 files changed, 214 insertions(+), 143 deletions(-)

