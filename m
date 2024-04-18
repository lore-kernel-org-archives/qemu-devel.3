Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2412C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXO5-0007TC-9k; Thu, 18 Apr 2024 15:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXO2-0007RI-68
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:34 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXNz-0007EM-3b
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:33 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-571c25a329eso1058865a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468329; x=1714073129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UatYjw6LkKqMQcEs0xLI/ll8in5w62RsbSuNUqaD+hU=;
 b=yHL2q8P1Dwav1dlPbpPB+CtOWXCNvtxHmw0gOWZ53mU72BFSPeQYfUrM8UUWKt3Tjy
 rUUyRUmxkpEeET4otq3n4TcghYa6gxmjL7LntEFhsZEeaANddgNJr5C+Q4/2h0ADdLVu
 vheK6sFIsgP5jcAO/6rGcJq8SRsP0bX6Xbc7X0Bc+2VQi5rMxT4Zm+Rc/8JMk/3d0SLH
 TMIJp1g/wUZ+ySXg0Eyc1REOU6T2TKxnouo5waIwkzHmJ2v9dJbQqr/b42rawV+ES4LJ
 kvFulMocmexrUckSR7LuKZOWE8HD+q2HzzY6bzg6Gao1Ev6S+YEFe0fuhSfAIGmbbE5c
 Sg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468329; x=1714073129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UatYjw6LkKqMQcEs0xLI/ll8in5w62RsbSuNUqaD+hU=;
 b=lLaGzcYFKAjs0pRBkOcSsgwpXEKium86NlJVyYZ/PvQyibpq6/ftZqPoYu9UoT3dWI
 pbe8CNRDa+hSEdeezI8WodaZy64EBri3Y7wbrkhXEGt/e4ARL5sinzK1doupH/FXDRi9
 LHsDP2pQkyLRqnITCS3LzJyeFsj57Wf2njyGb2sSWWLiJ96cyJCu/UckUxEBpoM8zzdK
 ezNpHgcNVmHW8TOddDUmMOKADqbf4YTlSwLTxPOymDsisz3hu1IH0ohwvFMarXQf8+F4
 8aqbbwW0G9gRjFdCcxDyUTARB+I0sK2ux6YFygmKSq43O5/6O/4HzUMUf2LLqRaMMCCW
 YC0Q==
X-Gm-Message-State: AOJu0YxiHPcV5+kHqwnjDDwPuQOHRL0Gsj5RnXo+E5W0mdAPVFDhcjz0
 BOTIYfQwqw+kOtTy2TRjyTv3dcvFFtkTwMcifKhTuAwMgJMDQ7RJdzcS6ofe8pjuZdEh7xCjzKD
 x
X-Google-Smtp-Source: AGHT+IG6mbo7Ujao5nYsEjpEqJP1F0wz9b6JL8jKjwrBHCw0/6R9oQcHVTB20tlAD3rgevO7qdU+6w==
X-Received: by 2002:a05:6402:35c5:b0:571:bc64:f8bf with SMTP id
 z5-20020a05640235c500b00571bc64f8bfmr2699703edc.14.1713468328813; 
 Thu, 18 Apr 2024 12:25:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 b10-20020aa7dc0a000000b0056fe755f1e6sm1202106edu.91.2024.04.18.12.25.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:25:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/24] include/exec: Rework (part 2)
Date: Thu, 18 Apr 2024 21:24:59 +0200
Message-ID: <20240418192525.97451-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Reordering exec/, second round. Mostly splitting:
- TCG LDST API (to "exec/cpu_ldst.h")
- CPU TLB APIs (to "exec/cputlb.h")
from "exec/cpu-all.h" and "exec/exec-all.h", and
reducing inclusions of "hw/core/cpu.h".

Based-on: <20240417182806.69446-1-philmd@linaro.org>
or https://gitlab.com/philmd/qemu/-/commits/exec-next

Philippe Mathieu-Daudé (24):
  exec: Declare MMUAccessType type in 'mmu-access-type.h' header
  exec: Declare CPUBreakpoint/CPUWatchpoint type in 'breakpoint.h'
    header
  hw/core: Avoid including the full 'hw/core/cpu.h' in 'tcg-cpu-ops.h'
  exec: Restrict TCG specific declarations of 'cputlb.h'
  exec: Restrict 'cpu_ldst.h' to TCG accelerator
  exec: Have guest_addr_valid() methods take abi_ptr/size_t arguments
  exec: Un-inline tlb_vaddr_to_host() and declare it in 'exec/cputlb.h'
  physmem: Move TCG CPU IOTLB methods around
  physmem: Restrict TCG CPU IOTLB code to TCG accel
  exec: Reduce tlb_set_dirty() declaration scope
  exec: Move tlb_reset_dirty*() declarations to 'exec/cputlb.h'
  exec: Move CPUTLBEntry helpers to cputlb.c
  target/sparc: Replace abi_ulong by uint32_t for TARGET_ABI32
  exec: Rename 'exec/user/guest-base.h' as 'user/guest-base.h'
  exec: Restrict inclusion of 'user/guest-base.h'
  exec: Move GUEST_ADDR_MAX definition to 'cpu_ldst.h'
  exec: Include missing 'qemu/log-for-trace.h' header in 'exec/log.h'
  plugins: Include missing 'qemu/bitmap.h' header
  gdbstub: Avoid including 'cpu.h' in 'gdbstub/helpers.h'
  hw/xtensa: Include missing 'exec/cpu-common.h' in 'bootparam.h'
  plugins: Un-inline qemu_plugin_disable_mem_helpers()
  exec: Remove 'exec/tswap.h' from 'exec/cpu-all.h'
  exec: Remove 'disas/disas.h' from 'exec/log.h'
  exec: Remove unnecessary inclusions of 'hw/core/cpu.h'

 hw/xtensa/bootparam.h            |   3 +
 include/exec/breakpoint.h        |  23 ++++++
 include/exec/cpu-all.h           |  39 +---------
 include/exec/cpu-defs.h          |   1 -
 include/exec/cpu_ldst.h          | 122 ++++++++++---------------------
 include/exec/cputlb.h            |  58 ++++++++++++++-
 include/exec/exec-all.h          |  26 +------
 include/exec/log.h               |   2 +-
 include/exec/mmu-access-type.h   |  18 +++++
 include/exec/ram_addr.h          |   1 +
 include/exec/user/guest-base.h   |  12 ---
 include/gdbstub/helpers.h        |   3 +-
 include/hw/boards.h              |   1 -
 include/hw/core/cpu.h            |  24 +-----
 include/hw/core/tcg-cpu-ops.h    |   6 +-
 include/hw/ppc/openpic.h         |   1 -
 include/qemu/plugin.h            |   7 +-
 include/sysemu/hw_accel.h        |   1 -
 include/user/guest-base.h        |  18 +++++
 target/arm/internals.h           |   1 +
 target/ppc/internal.h            |   1 +
 target/riscv/debug.h             |   2 +
 accel/stubs/tcg-stub.c           |   4 -
 accel/tcg/cpu-exec.c             |   1 -
 accel/tcg/cputlb.c               |  53 +++++++++++++-
 accel/tcg/translator.c           |   1 +
 accel/tcg/user-exec.c            |   7 ++
 bsd-user/main.c                  |   1 +
 hw/arm/boot.c                    |   1 +
 hw/arm/npcm7xx.c                 |   1 +
 hw/mips/fuloong2e.c              |   1 +
 hw/mips/malta.c                  |   1 +
 hw/ppc/sam460ex.c                |   1 +
 hw/ppc/spapr.c                   |   1 +
 hw/ppc/virtex_ml507.c            |   1 +
 hw/sh4/r2d.c                     |   1 +
 linux-user/elfload.c             |   1 +
 linux-user/main.c                |   1 +
 plugins/core.c                   |   5 ++
 system/physmem.c                 |  58 ++++++++-------
 target/arm/gdbstub.c             |   1 +
 target/arm/tcg/helper-a64.c      |   1 +
 target/avr/gdbstub.c             |   1 +
 target/avr/translate.c           |   1 +
 target/hexagon/translate.c       |   1 +
 target/loongarch/tcg/translate.c |   1 +
 target/riscv/vector_helper.c     |   1 +
 target/rx/translate.c            |   1 +
 target/sparc/gdbstub.c           |   2 +-
 target/sparc/mmu_helper.c        |   1 +
 target/tricore/gdbstub.c         |   1 +
 target/xtensa/xtensa-semi.c      |   1 +
 tcg/tcg.c                        |   3 +-
 53 files changed, 300 insertions(+), 226 deletions(-)
 create mode 100644 include/exec/breakpoint.h
 create mode 100644 include/exec/mmu-access-type.h
 delete mode 100644 include/exec/user/guest-base.h
 create mode 100644 include/user/guest-base.h

-- 
2.41.0


