Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A759CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYs3-0001Wt-HP; Mon, 08 Sep 2025 06:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYrz-0001V8-L8
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYrk-0000t6-CM
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6fDrP9bH4bHquY6G+/HTgZy5Ut0rr4KQwzXkfNcFZuw=;
 b=OTgYaQTqmPC1XwEhV/S5rq7oWFMifq0xJoz/4VnLTnshKHt46z98xXg3p+YPQbqYC+2LvC
 f5rI41u0JSq4/MeFvdBpdoUwZS8ii0OcdvmN5jXK/g03ZyB5n24RfaMZmQPJNu4LYE+fol
 s1tHhno+VfEbvWyk4WQijso2MulQoF0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-C3ksNylmOTKa97J_UfLVcg-1; Mon, 08 Sep 2025 06:12:46 -0400
X-MC-Unique: C3ksNylmOTKa97J_UfLVcg-1
X-Mimecast-MFC-AGG-ID: C3ksNylmOTKa97J_UfLVcg_1757326365
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e1e7752208so2076437f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326364; x=1757931164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6fDrP9bH4bHquY6G+/HTgZy5Ut0rr4KQwzXkfNcFZuw=;
 b=oE8T98PfqwSxvLtexX3RaZ2UEgx3RS1OpPpUNF/E91YVhSKTRYYjekftoIlUHE2NsO
 IpVBROmkahffex/suyYxXmPp4nPTdtTPLxvJQpc8fh/LQ16vvagsxFX1nyaxRtZx7oqp
 FgAnD5eEFmo4QU4ZyOoNnZzEsAADEovbOrvYYw2LACLSaA8CXfurYYpWDXPOuLEe6GJJ
 uRG/7uq29sHX5/bLbfuA1LuHAIVzLjc2TW3jkqsDl389nCGj8BfQD84m/p+aXtmD5B+S
 imIe4jTYI0v+WX1Pmk3DhlwAmlsEFux8acZ4PpIe/YUVJjR+oH00dg+DdzrLb3kqVAtK
 EqkQ==
X-Gm-Message-State: AOJu0YwR108zeuape1E0hGwUbAyqp9Mp6FNmbh6faF06AdELf3qm9NLD
 gpmSkZiQ0WVhxLRgvpwiyk9MWvN5zTICXW9Z7COmOjxqCGeFP42BtOC1ctCXeGvRjrakzpK2PC1
 PUcAkZwP6Hud44B+FkAIUbRMG5vdju0wJXIrWsZB/30cv+rhxf70TFpb9pXLijxS/MPbjKAhPYm
 U1rSyMfx+bgRT/QUiU7aTDETtIPc0P/5lpgowCkiVY
X-Gm-Gg: ASbGncsb63sSUbK45PUOUhctv70/rGnM/NwclJw0W/o1VSYAtuNunDqEMOKI3efyEBM
 BRFsMVmUg5JB38KkY9O04tXnQzEen/CRHDxxdwxPlgy8vQLG5f0Tp1r2Os7XCTa38jnV+rkgrBL
 r0hTZfuurspv85HkOA38yKAs3eMEscK/OTK15X5n3wJYeushduvD9ahM2k0qj1cSZWMpnZ0HiiH
 N/IphZ+2tqvCwAlKhsuwC5Jj3ASRs4OoFwPRFyIDxqNttZdDkxh3BVkJ5LUbo/9PLfuqIJpX59t
 GK16Tk/iEBeDzNKchK/cZJEDQKWPi3/QIm2Q6uIfnnChPhjMI2l7yD7iZ3rzaDfEeYzICmPyb3I
 igkGOUetAttJlP3bFg9poLB7Gzjc5plgzUiwb/FFBb8U=
X-Received: by 2002:a05:6000:3106:b0:3e6:116a:8fed with SMTP id
 ffacd0b85a97d-3e64bde97a5mr5971702f8f.45.1757326364002; 
 Mon, 08 Sep 2025 03:12:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSKuNhPB+qA3G+1Eg5hzdiirKG2Kv243wIirEV57gAkNZy4xz8mqx4mDxa8Z8Ch5Oh5B+hKw==
X-Received: by 2002:a05:6000:3106:b0:3e6:116a:8fed with SMTP id
 ffacd0b85a97d-3e64bde97a5mr5971660f8f.45.1757326363416; 
 Mon, 08 Sep 2025 03:12:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd60b381csm140810465e9.17.2025.09.08.03.12.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/19] accel, cpus: clean up cpu->exit_request
Date: Mon,  8 Sep 2025 12:12:22 +0200
Message-ID: <20250908101241.2110068-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cpu->exit_request is used to kick vCPU threads into qemu_wait_io_event().
The code that handles the signaling of cpu->exit_request is messy, mostly
due to no one ever taking a look at it as a whole.  In fact already in commit
4b8523ee896 ("kvm: First step to push iothread lock out of inner run loop",
2015-07-01), the read of cpu->exit_request was placed outside the BQL
critical section without much attention to ordering; and it only got
worse from that point, in no small part due to a young and naive me.

This series is complementary to the cpu->interrupt_request cleanups
that Igor did in "memory: reintroduce BQL-free fine-grained PIO/MMIO"
(https://lore.kernel.org/qemu-devel/20250808120137.2208800-1-imammedo@redhat.com/T/),
and in fact includes some extra changes to interrupt_request at the
beginning.

Paolo

Paolo Bonzini (19):
  target/ppc: limit cpu_interrupt_exittb to system emulation
  target/sparc: limit cpu_check_irqs to system emulation
  target/i386: limit a20 to system emulation
  target-arm: remove uses of cpu_interrupt() for user-mode emulation
  user-exec: remove cpu_interrupt() stub
  treewide: clear bits of cs->interrupt_request with cpu_reset_interrupt()
  cpu-common: use atomic access for interrupt_request
  cpus: document that qemu_cpu_kick() can be used for BQL-less operation
  accel: use store_release/load_acquire for cross-thread exit_request
  accel: use atomic accesses for exit_request
  accel/tcg: create a thread-kick function for TCG
  accel/tcg: inline cpu_exit()
  cpus: remove TCG-ism from cpu_exit()
  cpus: properly kick CPUs out of inner execution loop
  treewide: rename qemu_wait_io_event/qemu_wait_io_event_common
  bsd-user, linux-user: introduce qemu_process_cpu_events
  cpus: clear exit_request in qemu_process_cpu_events
  accel: make all calls to qemu_process_cpu_events look the same
  tcg/user: do not set exit_request gratuitously

v2->v3:
- [accel: use store_release/load_acquire for cross-thread exit_request]
  improve comments for memory barriers, match rr_kick_next_cpu() more
  accurately

- [cpus: properly kick CPUs out of inner execution loop]
  fix comment

- [treewide: rename qemu_wait_io_event/qemu_wait_io_event_common]
  new patch; new names used throughout in patches 16-19

 docs/devel/tcg-icount.rst           |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.h     |   3 -
 accel/tcg/tcg-accel-ops.h           |   1 +
 bsd-user/aarch64/target_arch_cpu.h  |   2 +-
 bsd-user/arm/target_arch_cpu.h      |   2 +-
 bsd-user/i386/target_arch_cpu.h     |   2 +-
 bsd-user/riscv/target_arch_cpu.h    |   2 +-
 bsd-user/x86_64/target_arch_cpu.h   |   2 +-
 include/hw/core/cpu.h               |  22 +-
 include/system/cpus.h               |   3 +-
 target/arm/internals.h              |   5 +
 accel/dummy-cpus.c                  |   2 +-
 accel/hvf/hvf-accel-ops.c           |   2 +-
 accel/kvm/kvm-accel-ops.c           |   3 +-
 accel/kvm/kvm-all.c                 |  23 +-
 accel/tcg/cpu-exec.c                |  34 ++-
 accel/tcg/tcg-accel-ops-mttcg.c     |  12 +-
 accel/tcg/tcg-accel-ops-rr.c        |  55 ++--
 accel/tcg/tcg-accel-ops.c           |   4 +-
 accel/tcg/user-exec.c               |  11 +-
 bsd-user/main.c                     |   5 -
 cpu-common.c                        |   3 +-
 hw/core/cpu-common.c                |  19 +-
 hw/core/cpu-system.c                |   2 +-
 hw/ppc/ppc.c                        |   2 +
 hw/ppc/spapr_hcall.c                |   7 +-
 hw/ppc/spapr_rtas.c                 |   2 +-
 linux-user/aarch64/cpu_loop.c       |   2 +-
 linux-user/alpha/cpu_loop.c         |   2 +-
 linux-user/arm/cpu_loop.c           |   2 +-
 linux-user/hexagon/cpu_loop.c       |   2 +-
 linux-user/hppa/cpu_loop.c          |   2 +-
 linux-user/i386/cpu_loop.c          |   2 +-
 linux-user/loongarch64/cpu_loop.c   |   2 +-
 linux-user/m68k/cpu_loop.c          |   2 +-
 linux-user/main.c                   |   5 -
 linux-user/microblaze/cpu_loop.c    |   2 +-
 linux-user/mips/cpu_loop.c          |   2 +-
 linux-user/openrisc/cpu_loop.c      |   2 +-
 linux-user/ppc/cpu_loop.c           |   2 +-
 linux-user/riscv/cpu_loop.c         |   2 +-
 linux-user/s390x/cpu_loop.c         |   2 +-
 linux-user/sh4/cpu_loop.c           |   2 +-
 linux-user/sparc/cpu_loop.c         |   2 +-
 linux-user/xtensa/cpu_loop.c        |   2 +-
 replay/replay-events.c              |   3 +-
 system/cpu-timers.c                 |   6 +-
 system/cpus.c                       |  15 +-
 target/arm/cpu-irq.c                | 381 ++++++++++++++++++++++++++++
 target/arm/cpu.c                    | 370 ---------------------------
 target/arm/el2-stubs.c              |  37 +++
 target/arm/helper.c                 |   4 +
 target/arm/tcg/mte_helper.c         |   2 +-
 target/avr/helper.c                 |   4 +-
 target/i386/helper.c                |   2 +
 target/i386/hvf/x86hvf.c            |   8 +-
 target/i386/kvm/hyperv.c            |   1 -
 target/i386/kvm/kvm.c               |  20 +-
 target/i386/nvmm/nvmm-accel-ops.c   |   8 +-
 target/i386/nvmm/nvmm-all.c         |  19 +-
 target/i386/tcg/system/seg_helper.c |  13 +-
 target/i386/tcg/system/svm_helper.c |   2 +-
 target/i386/whpx/whpx-accel-ops.c   |   6 +-
 target/i386/whpx/whpx-all.c         |  23 +-
 target/openrisc/sys_helper.c        |   2 +-
 target/ppc/helper_regs.c            |   2 +
 target/rx/helper.c                  |   4 +-
 target/s390x/tcg/excp_helper.c      |   2 +-
 target/sparc/int32_helper.c         |   2 +
 target/sparc/int64_helper.c         |   2 +
 target/arm/meson.build              |   2 +
 71 files changed, 645 insertions(+), 566 deletions(-)
 create mode 100644 target/arm/cpu-irq.c
 create mode 100644 target/arm/el2-stubs.c

-- 
2.51.0


