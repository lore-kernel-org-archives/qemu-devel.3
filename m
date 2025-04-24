Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA11C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lFd-00035b-H3; Wed, 23 Apr 2025 21:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFO-0002WY-6W
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:27 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFJ-00078F-F1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so345665b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457559; x=1746062359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NPOl1qVh5PpGUnfloyYun4n/3KH4UfiLKminhWf++hY=;
 b=aF29aEZP+zQnBs0jmsI9BQLwq8QBZFMu3IbwMLxYL8pCSUrR+3ZuwS6BFcTmbpphAz
 KHKC7cQmmxnh9xYrotqZF3nHGgHHyKf5+WGn9W2tydQ9LBe4tE16p3sj3OihPKHQiUuv
 Hj1v+cdq6j2yyyc4XN1vK6uSK5KwH8DCX2ja/QaDKlCOojUvxmAXU7g74nf3p84jnhUh
 hSI7O7zMVw6Xhrw2rkTBtMEf81amlMePapJQdSY/tSEMPceBMOm5SkdDMRPYRnHHXOdD
 rVEuSt/CbcXmldc6SHLrJ/poVirdswQWohnEDjy3xX6HOkRRaT49DAoXMn7EJEigrrZS
 ariQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457559; x=1746062359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NPOl1qVh5PpGUnfloyYun4n/3KH4UfiLKminhWf++hY=;
 b=GMWaNs5bHSYHNiFtfeby7SQ81/wMxO3FmRqj6cnJ5HjdbG4E2FCLfJuHnMIgrcYSYS
 pMGF3533DWP1okxQdSBWz1xm+WuNleiSjb67XXxaZ44dkH9f+t1AOIeUulMBhrv8E/WE
 Z58vfbl7CHvokLv32Ph8KKqXCZuQm9MZ7wBbXSHRaxwi0bakcm5P+kiOasTHBENVd4f6
 QUI+gyuPhtqjtkfCgf7ZaXS91f2sD2zU3FymW1s08TtxissuOs9GyrAav8HjcV9NXgX/
 9Yg2VngPCOgM/sf+i7k4MOoy/kzFkXsvnv7ajS7zak7A889iDfmwVTZygmD5TjaRjNWv
 ZC5w==
X-Gm-Message-State: AOJu0YxnLlKVMkJGy81yN9qcfMVh3do3BNkv7wk4ludLYb49mDp7dcsq
 8ZWsFZj+YkF10XaQvovd2WVWZcR+6pluYLJZQX4m2Bnx3Fqb1fkbdWtqGH7axH0CFYM80il2OT6
 j
X-Gm-Gg: ASbGnct0y9dC7AUP2OPilFhLwt4V4iUVUK7VzZ/Yz4RQvGlpwlINKweuH7YVKkzDSqq
 7RjwNYDldtaVUL1oS5jE+u2zVOGAhdC0yhid45y95BcpNM4hHo4vzAndXK4zr/WH9DWX8O1tAdO
 8XTnWEuZhANwk4UK8FdQ6LbYfMOm7fckQQXshAnlRGqai4WIjon34ZoTlyUE1+4BcgW8Q15LQfW
 7xiila5cbER58lxYIloROESLL38mfZa8dl9vTjSTIJa8NrO/g9xxCul1R9Vyy56seNXAdS9Q/gk
 PpmlXL+wj75HkPGivchss74e6XhTZ3EXo5XLhcX6y3fLGP3vTm73pdgKsUf2oj16r28JxfvyRrU
 =
X-Google-Smtp-Source: AGHT+IF4JmFF4kRPt//lg/M7SIf9HMhPlzEQ6HLZywbw1r52ZhH4I7Z5nwMGurNLHU1UaiIGAHllzw==
X-Received: by 2002:a05:6a00:a02:b0:736:39d4:ccf6 with SMTP id
 d2e1a72fcca58-73e245e643dmr1354137b3a.8.1745457559630; 
 Wed, 23 Apr 2025 18:19:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/15] accel/tcg: Compile tb-maint.c twice
Date: Wed, 23 Apr 2025 18:19:03 -0700
Message-ID: <20250424011918.599958-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

More progress for single-binary: build tb-maint.c once
for user mode and once for system mode.


r~


Richard Henderson (15):
  accel/tcg: Add CPUState argument to page_unprotect
  accel/tcg: Add CPUState argument to tb_invalidate_phys_page_unwind
  accel/tcg: Add CPUState arg to tb_invalidate_phys_page_range__locked
  accel/tcg: Merge tb_invalidate_phys_range{__locked}
  accel/tcg: Add CPUState arg to tb_invalidate_phys_range
  accel/tcg: Add CPUState arg to tb_invalidate_phys_range_fast
  accel/tcg: Convert TARGET_HAS_PRECISE_SMC to TCGCPUOps.precise_smc
  accel/tcg: Simplify CPU_TLB_DYN_MAX_BITS
  accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS
  accel/tcg: Merge internal-target.h into internal-common.h
  accel/tcg: Reduce scope of tb_phys_invalidate, tb_set_jmp_target
  accel/tcg: Use vaddr for walk_memory_regions callback
  accel/tcg: Use vaddr in user/page-protection.h
  include/exec: Move tb_invalidate_phys_range to translation-block.h
  accel/tcg: Compile tb-maint.c twice

 accel/tcg/internal-common.h      |  32 ++++++++++
 accel/tcg/internal-target.h      |  46 --------------
 accel/tcg/tb-hash.h              |   3 +-
 accel/tcg/tb-internal.h          |   8 +--
 accel/tcg/tlb-bounds.h           |  21 +------
 include/accel/tcg/cpu-ops.h      |   7 +++
 include/exec/exec-all.h          |   5 --
 include/exec/poison.h            |   1 -
 include/exec/translation-block.h |   4 ++
 include/user/page-protection.h   |  24 ++++----
 target/i386/cpu.h                |   4 --
 target/s390x/cpu.h               |   2 -
 accel/tcg/cpu-exec.c             |   1 -
 accel/tcg/cputlb.c               |   3 +-
 accel/tcg/tb-maint.c             | 100 ++++++++++++-------------------
 accel/tcg/translate-all.c        |   3 +-
 accel/tcg/user-exec.c            |  89 ++++++++++++++-------------
 linux-user/elfload.c             |  21 ++++---
 linux-user/syscall.c             |   8 +--
 system/physmem.c                 |   2 +-
 target/arm/helper.c              |   2 +-
 target/i386/tcg/tcg-cpu.c        |   1 +
 target/s390x/cpu.c               |   1 +
 accel/tcg/meson.build            |   2 +-
 24 files changed, 163 insertions(+), 227 deletions(-)
 delete mode 100644 accel/tcg/internal-target.h

-- 
2.43.0


