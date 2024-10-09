Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8172ACEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJG-0001Ju-26; Wed, 09 Oct 2024 11:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJC-0001JF-MM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:02 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJ8-0007vz-Pk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:00 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71dfc1124cdso849338b3a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486537; x=1729091337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FzZm7uKCk7b4BByU9zV10eNVb7kQGJkY/vOPQhrdAhc=;
 b=zMLwaiIFUdVHhc9uWJV1FrRiHULTdVdUYbYYU0djEhuOB3DgrX1+18j8RreEGkLvgz
 d6GbFgD79Bz1JISlSyfOpUfPfnoGA1TtE/RRH4++U+vDIBoA0BdofJAqplxjX8QgBEjJ
 Gk9boSG/gDmGDHkrYzG4n6Qmk45sMpquqbJUQ1l9hzoB2qBHzHe7IjhBE8IHr2nzye8h
 FR/J50mw1I2DaZ65F2808sPukj8mB602BjF7DVgwKZF/oOV5QaXPNmVqV1goZm2cQdHT
 YM5YAkTHPbymV16BivLbLu/1kk6hzz18OdgtLLmAoC/5U9QJ/2IYqb7vaAv/KaPkMjgS
 wGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486537; x=1729091337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FzZm7uKCk7b4BByU9zV10eNVb7kQGJkY/vOPQhrdAhc=;
 b=lIuayJgT8p3fomr6gM0cFr2P51CPVmRkFLuXUfLdw314Quazy6h9Ryqhh3ZG+8xPUQ
 1FNuhW+Rbff5oKjHWx18mnr5DqoFKy6UcmsusV1SHW1QcymRJHkAsXWwl3K7sBNcGcS6
 b+B5fS21nz3TZac9MI5Qx6li4NErJHX0pRSvyZPXYeDnn9zCCwiAZXUk0UBVDDS2y9oD
 qbOcd7ME0o82eux0eKILZWsj1aQaImkxA2Y82feXz/bPnop5+Cz+xXRfqeuVlzovVrBn
 Td+mgWzC6RN2K3JAcI5HDQe0DTCZUHdDF/dlMbW6f0rVT6353pMbdZJHqtgHpyj1hiHl
 5org==
X-Gm-Message-State: AOJu0Yy50pwP2meTrmDgbOF8R/FpnPynq+ejnbtKCUW/6rqK0aIBz7KH
 ORhjfIJK/HNYk3WbJfSWUDHV6l5rwLFkv8Q5WGghr+FIOr8UR5bl6+sbX3J9W/gyzMHtazKFKFw
 c
X-Google-Smtp-Source: AGHT+IH6k5D+oW4K1cE7QQy5O8YN0xRYHdY8qDzBT3Mnu+RjopIpY952N/8ON7gLa5gpHKay7FIEvg==
X-Received: by 2002:a05:6a00:2191:b0:71e:21c:bf08 with SMTP id
 d2e1a72fcca58-71e1d352956mr4849004b3a.1.1728486537109; 
 Wed, 09 Oct 2024 08:08:57 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.08.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:08:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/23] accel/tcg: Convert victim tlb to IntervalTree
Date: Wed,  9 Oct 2024 08:08:32 -0700
Message-ID: <20241009150855.804605-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Based-on: 20241009000453.315652-1-richard.henderson@linaro.org
("[PATCH v3 00/20] accel/tcg: Introduce tlb_fill_align hook")

The initial idea was: how much can we do with an intelligent data
structure for the same cost as a linear search through an array?

This is an initial installment along these lines.  This is about
as far as I can go without first converting all targets to the
new tlb_fill_align hook.  Indeed, the final two patches will not
compile with all targets enabled, but hint at the direction of
the next steps.

I do not expect large perf changes with this patch set.  I will
be happy if performance comes out even.


r~

Richard Henderson (23):
  util/interval-tree: Introduce interval_tree_free_nodes
  accel/tcg: Split out tlbfast_flush_locked
  accel/tcg: Split out tlbfast_{index,entry}
  accel/tcg: Split out tlbfast_flush_range_locked
  accel/tcg: Fix flags usage in mmu_lookup1, atomic_mmu_lookup
  accel/tcg: Early exit for zero length in tlb_flush_range_by_mmuidx*
  accel/tcg: Flush entire tlb when a masked range wraps
  accel/tcg: Add IntervalTreeRoot to CPUTLBDesc
  accel/tcg: Populate IntervalTree in tlb_set_page_full
  accel/tcg: Remove IntervalTree entry in tlb_flush_page_locked
  accel/tcg: Remove IntervalTree entries in tlb_flush_range_locked
  accel/tcg: Process IntervalTree entries in tlb_reset_dirty
  accel/tcg: Process IntervalTree entries in tlb_set_dirty
  accel/tcg: Replace victim_tlb_hit with tlbtree_hit
  accel/tcg: Remove the victim tlb
  include/exec/tlb-common: Move CPUTLBEntryFull from hw/core/cpu.h
  accel/tcg: Delay plugin adjustment in probe_access_internal
  accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
  accel/tcg: Always use IntervalTree for code lookups
  accel/tcg: Link CPUTLBEntry to CPUTLBEntryTree
  accel/tcg: Remove CPUTLBDesc.fulltlb
  accel/tcg: Drop TCGCPUOps.tlb_fill -- NOTYET
  accel/tcg: Unexport tlb_set_page*

 include/exec/cpu-all.h        |   3 +
 include/exec/exec-all.h       |  57 ----
 include/exec/tlb-common.h     |  68 +++-
 include/hw/core/cpu.h         |  75 +----
 include/hw/core/tcg-cpu-ops.h |  10 -
 include/qemu/interval-tree.h  |  11 +
 accel/tcg/cputlb.c            | 599 +++++++++++++++++++---------------
 util/interval-tree.c          |  20 ++
 util/selfmap.c                |  13 +-
 9 files changed, 431 insertions(+), 425 deletions(-)

-- 
2.43.0


