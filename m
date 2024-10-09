Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE12CF042D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCK-0004AM-2W; Tue, 08 Oct 2024 20:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCI-00049x-Qc
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:04:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCH-0002dW-3P
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:04:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b0b2528d8so70926965ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432295; x=1729037095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=47Pe1MH9gsNOxZkdWXv/PZJTALTB63WGwPGX9cZVdVo=;
 b=s5g3ZdfDRfaR56dgFx5ByrWzqJb9zq/5v6Md5y3hHJFqNsj15hQ2BMmfPNtFjbmApF
 ghAhFqDlTqU60xf4cpPsg465oZqgHRcMECUysVybGjDSpK3Mr5vBKC8PUDAq+QBzX0uQ
 T3qFAD0/v4hVuy12VQLO8+mKgQv0hnbM5OdqutEa2Llov/ym1cE3wKQqkgXRmyWEnKwA
 i7z+mIWrXakH6N5fFrEpypBvQIMDB4UwEPE+V2wbth3yXgxiqrrsDs7WLI6CoWimrRxe
 PEbIoPs+6ytMOs0O20qQ2FtysuzIBK+NoXHLQZnPFwn5ANFQvsoGp5Kh39iwqBLmxF+K
 M+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432295; x=1729037095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=47Pe1MH9gsNOxZkdWXv/PZJTALTB63WGwPGX9cZVdVo=;
 b=s7sTrM2wjp32gk6zkxSBpEL00pAwYCR6A5Eg67VJXFrjrNR+Oz/8mX2DJWWaZTFZ/G
 YInmtGlv+6XCylUqXyRQe/h2ujaarE6CqvWvZ2B32IMtrQqukbIEdd0HtgzmiSJFHUmf
 gKHfzSQRMxstCkLpuHIIRZCWJ33VwTVjVl6QrDe2daIiMp3coQaUXPZzKzVmrxOAWv9P
 oJ/xefJoE0BZXOjdsk/yG5rYDLWCXGk8heaJT8bVgC4WGZ8eepWt54Y0oWPlQtjm6aI5
 I8kMi5k2FXWTv53APPPzTQmdt6dY50I7FixQUfxKlj+RaYyfybtJTv0nWBksYwrJ43NA
 uCaQ==
X-Gm-Message-State: AOJu0YxC1f1MdBO6zvziBpRoTiTPIrZl+yOLUrmBtQyKYWB0hDPL3Rrq
 2W4Vf+70BaNskzlp/QWBp2uUfrtILRDTSPKldt09lfAfEyQUS7yK9AsGEYXoqer3DTUvufI+S6r
 T
X-Google-Smtp-Source: AGHT+IF7W3tFDq7NjDPWGL7RHkyhiahUq6Tk0gHdPQurTadTzr8V3g0hgvREtTGmqziBBmE6YVcFgg==
X-Received: by 2002:a17:902:d2cf:b0:202:4b65:65af with SMTP id
 d9443c01a7336-20c6378ea43mr10853195ad.52.1728432295419; 
 Tue, 08 Oct 2024 17:04:55 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:04:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v3 00/20] accel/tcg: Introduce tlb_fill_align hook
Date: Tue,  8 Oct 2024 17:04:33 -0700
Message-ID: <20241009000453.315652-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

This new hook will allow targets to recognize an alignment
fault with the correct priority with respect to other faults
that can be raised by paging.

This should fix several hppa fault priority issues, most
importantly that access permissions come before alignment.

This should fix the documented error in the Arm alignment
fault due to memory type.

Changes for v3:
  - Change the tlb_fill_hook to return data into provided
    CPUTLBEntryFull, instead of calling tlb_set_page*.
  - I have dropped some r-b, correspondingly.

Patches needing review:
  05-accel-tcg-Add-TCGCPUOps.tlb_fill_align.patch
  06-accel-tcg-Use-the-alignment-test-in-tlb_fill_alig.patch
  11-target-hppa-Implement-TCGCPUOps.tlb_fill_align.patch
  19-target-arm-Implement-TCGCPUOps.tlb_fill_align.patch


r~


Richard Henderson (20):
  accel/tcg: Assert noreturn from write-only page for atomics
  include/exec/memop: Move get_alignment_bits from tcg.h
  include/exec/memop: Rename get_alignment_bits
  include/exec/memop: Introduce memop_atomicity_bits
  accel/tcg: Add TCGCPUOps.tlb_fill_align
  accel/tcg: Use the alignment test in tlb_fill_align
  target/hppa: Add MemOp argument to hppa_get_physical_address
  target/hppa: Perform access rights before protection id check
  target/hppa: Fix priority of T, D, and B page faults
  target/hppa: Handle alignment faults in hppa_get_physical_address
  target/hppa: Implement TCGCPUOps.tlb_fill_align
  target/arm: Pass MemOp to get_phys_addr
  target/arm: Pass MemOp to get_phys_addr_with_space_nogpc
  target/arm: Pass MemOp to get_phys_addr_gpc
  target/arm: Pass MemOp to get_phys_addr_nogpc
  target/arm: Pass MemOp through get_phys_addr_twostage
  target/arm: Pass MemOp to get_phys_addr_lpae
  target/arm: Move device detection earlier in get_phys_addr_lpae
  target/arm: Implement TCGCPUOps.tlb_fill_align
  target/arm: Fix alignment fault priority in get_phys_addr_lpae

 include/exec/memop.h           |  47 ++++++++++
 include/hw/core/cpu.h          |   4 +-
 include/hw/core/tcg-cpu-ops.h  |  26 ++++++
 include/qemu/typedefs.h        |   1 +
 include/tcg/tcg.h              |  23 -----
 target/arm/internals.h         |  12 +--
 target/hppa/cpu.h              |   8 +-
 accel/tcg/cputlb.c             | 160 +++++++++++++++++----------------
 accel/tcg/user-exec.c          |   4 +-
 target/arm/cpu.c               |   2 +-
 target/arm/helper.c            |   9 +-
 target/arm/ptw.c               | 141 ++++++++++++++++-------------
 target/arm/tcg/cpu-v7m.c       |   2 +-
 target/arm/tcg/m_helper.c      |   8 +-
 target/arm/tcg/tlb_helper.c    |  49 ++++------
 target/arm/tcg/translate-a64.c |   4 +-
 target/hppa/cpu.c              |   2 +-
 target/hppa/int_helper.c       |   2 +-
 target/hppa/mem_helper.c       |  55 +++++++-----
 target/hppa/op_helper.c        |   2 +-
 target/xtensa/translate.c      |   2 +-
 tcg/tcg-op-ldst.c              |   6 +-
 tcg/tcg.c                      |   2 +-
 tcg/arm/tcg-target.c.inc       |   4 +-
 tcg/sparc64/tcg-target.c.inc   |   2 +-
 25 files changed, 326 insertions(+), 251 deletions(-)

-- 
2.43.0


