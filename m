Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071D7C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcA0-00055q-9T; Tue, 01 Jul 2025 10:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWc9x-000555-5t
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWc9r-0006nd-B0
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so38332005e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380821; x=1751985621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pg+a0dZ9LGO+rhea7wqKV8zQjvwK6ZYCVTXYkNR53wM=;
 b=oGCiASJOXlGmUVlUEu8uFeXm0/Hq25qxnpoPcMjdNO8nQmOit2QdRz95wRj4+rCD5a
 L6X4XvI9Qbw/YQ9y6nPoBaqqOpryzgqdK4stSuD3QG4o7YwCa/tJiYBbBlPgxERzJxdW
 FJlbrlhHSEqhjuxWSTcBY7S53/ed0z4OCn30/u3etBmnalGqtjzLH2e2862dGoGOn8Pe
 IPFyk32kbdxD9/f6tKgzzTFv8ZBjPdvt/naWJrfmH0vDzq9A7Dhcb57F3LCusicCHXZC
 CyBxALvLXXZT/a1jsB2pMJScZtUHs1NicZ74lQC4QvOBNHioG0dx0qxP/sAhxV2LqIdW
 +WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380821; x=1751985621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pg+a0dZ9LGO+rhea7wqKV8zQjvwK6ZYCVTXYkNR53wM=;
 b=bfgsvJqZQT3xRBjrJ4l7AWwv9O5fz0EDdfrNppne0gztWmqXC26YFLsF/yMOAD954O
 RvIWTWgX/xnOqClRKiyXMAQT6RdS5B2nSWH8fgKxiTys4keSND6hkdvrwcJEn4iRI4Cv
 WMq/vfcLIJGyLiB7JYY21KECBuW2nuFwbDgnqxXzsJr00tdfAq1SB2xp35A8wlwD+Ekd
 HcHBrgMG2ogvL4Taxzv8rwEOTRSUeLN6Ldc9/jFIsrR3EW00EZ39CEKJbaqIDFEThTFA
 EipDiwmR8gTpWoioFZUSftZ3meA981yhtQyDGquMpfeiZb4u714AV5cvYUTIjiqqWoDB
 JR5Q==
X-Gm-Message-State: AOJu0YxDF6t8umSucIH8YNfLqf1OSu/D4Yng09xpv+ucSI6wPUKvy9nh
 xHu3+6Q+vo6acvUEaUHNIa0CWHvcwi/Wn1RkhgMVuQmmMNpJO2x35atJ/4TiAShVReJOFDdgaX2
 exqd0
X-Gm-Gg: ASbGncvprAaRuPzD0ewsC+RrIXoRN4JdtpRrREe/NiaOQyNDxKKUKzVBFNye0RMpsUp
 FTLv/l1/GXTqWg/XAxQUN43/T59cc0jfn/qNdwuCrqrXWtoG9RcMW6CjgYsWKoMqTKX/RfCuKnL
 OmtIj2xHvDKQC7w60e11YdEqvnGDA9LPZUGzKtMojPzsLQbuQikaSw0QDR6/OMWc18vzch9PaNr
 KxPYEiNhwfzCfdnzQk4m7gpRRyz7L62+siyw6SrRpydT6EPLY5/364+s3wisulmcGJC1zMmlGoY
 H5nLl2BPnO0wOSqBOL9W7T5hpYAR25fDRHILl0tJ11bXGUloXDeb3pWoI2ifasdJ50u0ahsSBBX
 p7TywD2xjr2nvVYvsWt+u8lX+SnmAn84mqh7A
X-Google-Smtp-Source: AGHT+IGvYBMJovPv+ZVNncxWQJZtmvdQW3VmCnZvVp5fCPkcHyzYEZ5jpHqvM1Yz4VebBW1zqxl43g==
X-Received: by 2002:a05:600c:3482:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-4538ee9663fmr154665325e9.25.1751380821017; 
 Tue, 01 Jul 2025 07:40:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e62144sm13652507f8f.92.2025.07.01.07.40.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:40:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/68] accel: Preparatory cleanups for split-accel
Date: Tue,  1 Jul 2025 16:39:08 +0200
Message-ID: <20250701144017.43487-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Since v2:
- Addressed Richard's review comments

Few changes needed before being able to add the
split acceleration:

- few method docstring added
- remove pointless stubs
- propagate soon required AccelState argument
- try to reduce current_accel() uses
- move declarations AccelClass <-> AccelOpsClass
- display model name in 'info cpus'
- add 'info accel' command to monitor
- rename CPUState @dirty -> @hwaccel_synchronized
- make accel_create_vcpu_thread() more generic
- introduce hwaccel_enabled()
- expose init/exec/destroy vcpu hooks in AccelOpsClass for re-use
- add SysemuCPUOps::can_accelerate() hook

Regards,

Phil.

Philippe Mathieu-Daudé (68):
  system/runstate: Document qemu_add_vm_change_state_handler()
  system/cpus: Defer memory layout changes until vCPUs are realized
  system/cpus: Assert interrupt handling is done with BQL locked
  accel: Keep reference to AccelOpsClass in AccelClass
  accel: Introduce AccelOpsClass::cpu_target_realize() hook
  accel/hvf: Add hvf_arch_cpu_realize() stubs
  accel/kvm: Remove kvm_init_cpu_signals() stub
  accel/kvm: Reduce kvm_create_vcpu() declaration scope
  accel: Propagate AccelState to AccelClass::init_machine()
  accel/kvm: Prefer local AccelState over global MachineState::accel
  accel/hvf: Re-use QOM allocated state
  accel/tcg: Prefer local AccelState over global current_accel()
  accel: Directly pass AccelState argument to AccelClass::has_memory()
  accel/kvm: Directly pass KVMState argument to do_kvm_create_vm()
  accel: Remove unused MachineState argument of AccelClass::setup_post()
  accel: Pass AccelState argument to gdbstub_supported_sstep_flags()
  accel: Move supports_guest_debug() declaration to AccelClass
  accel: Move cpus_are_resettable() declaration to AccelClass
  accel: Move cpu_common_[un]realize() declarations to AccelOpsClass
  accel/system: Introduce AccelClass::pre_resume_vm() handler
  accel/whpx: Convert ops::synchronize_pre_resume() -> pre_resume_vm()
  accel/system: Remove AccelOpsClass::synchronize_pre_resume()
  hw/core/machine: Display CPU model name in 'info cpus' command
  accel/system: Add 'info accel' on human monitor
  accel/tcg: Factor tcg_dump_flush_info() out
  accel/tcg: Implement get_[vcpu]_stats()
  accel/hvf: Implement get_vcpu_stats()
  accel/hvf: Report missing com.apple.security.hypervisor entitlement
  accel/hvf: Restrict internal declarations
  accel/hvf: Move per-cpu method declarations to hvf-accel-ops.c
  accel/hvf: Move generic method declarations to hvf-all.c
  cpus: Document CPUState::vcpu_dirty field
  accel/hvf: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/whpx: Replace @dirty field by generic CPUState::vcpu_dirty field
  accel/kvm: Remove kvm_cpu_synchronize_state() stub
  accel/system: Document cpu_synchronize_state()
  accel/system: Document cpu_synchronize_state_post_init/reset()
  accel/nvmm: Expose nvmm_enabled() to common code
  accel/whpx: Expose whpx_enabled() to common code
  accel/system: Introduce hwaccel_enabled() helper
  target/arm: Use generic hwaccel_enabled() to check 'host' cpu type
  accel/dummy: Extract 'dummy-cpus.h' header from 'system/cpus.h'
  accel/dummy: Factor dummy_thread_precreate() out
  accel/tcg: Factor tcg_vcpu_thread_precreate() out
  accel: Factor accel_create_vcpu_thread() out
  accel: Introduce AccelOpsClass::cpu_thread_routine handler
  accel/dummy: Convert to AccelOpsClass::cpu_thread_routine
  accel/tcg: Convert to AccelOpsClass::cpu_thread_routine
  accel/hvf: Convert to AccelOpsClass::cpu_thread_routine
  accel/kvm: Convert to AccelOpsClass::cpu_thread_routine
  accel/nvmm: Convert to AccelOpsClass::cpu_thread_routine
  accel/whpx: Convert to AccelOpsClass::cpu_thread_routine
  accel: Factor accel_cpu_realize() out
  accel/tcg: Factor tcg_vcpu_init() out for re-use
  accel/tcg: Unregister the RCU before exiting RR thread
  accel/tcg: Expose vcpu_[un]register() for MTTCG
  accel/tcg: Factor mttcg_cpu_exec() out for re-use
  accel/tcg: Expose vcpu_[un]register() for RR
  accel/tcg: Factor rr_cpu_exec() out for re-use
  accel/tcg: Clear exit_request once in tcg_cpu_exec()
  accel/tcg: Add rr_vcpu_destroy() stub
  accel/system: Declare init/exec/destroy vcpu hooks
  accel/tcg: Register init/exec/destroy vcpu hooks
  accel/hvf: Register init/exec/destroy vcpu hooks
  accel/system: Pass old/new interrupt mask to handle_interrupt()
    handler
  accel: Have each accelerator implement the handle_interrupt() hook
  RFC system/memory: Restrict eventfd dispatch_write() to emulators

 qapi/machine.json                 |   3 +
 accel/accel-internal.h            |   2 +
 accel/dummy-cpus.h                |  16 ++
 accel/tcg/internal-common.h       |   2 +
 accel/tcg/tcg-accel-ops-icount.h  |   6 +-
 accel/tcg/tcg-accel-ops-mttcg.h   |   4 +-
 accel/tcg/tcg-accel-ops-rr.h      |   4 +
 accel/tcg/tcg-accel-ops.h         |   5 +-
 include/hw/core/cpu.h             |   5 +-
 include/qemu/accel.h              |  21 +-
 include/system/accel-ops.h        |  38 +++-
 include/system/cpus.h             |   5 -
 include/system/hvf.h              |  38 ----
 include/system/hvf_int.h          |  37 +++-
 include/system/hw_accel.h         |  34 ++-
 include/system/kvm.h              |   8 -
 include/system/nvmm.h             |  23 +-
 include/system/runstate.h         |  10 +
 include/system/whpx.h             |  27 +--
 target/i386/whpx/whpx-accel-ops.h |   1 -
 accel/accel-common.c              |  55 ++++-
 accel/accel-system.c              |  54 ++++-
 accel/dummy-cpus.c                |  18 +-
 accel/hvf/hvf-accel-ops.c         | 342 ++++++------------------------
 accel/hvf/hvf-all.c               | 276 ++++++++++++++++++++++--
 accel/kvm/kvm-accel-ops.c         |  20 +-
 accel/kvm/kvm-all.c               |  33 +--
 accel/qtest/qtest.c               |   7 +-
 accel/stubs/kvm-stub.c            |   9 -
 accel/stubs/nvmm-stub.c           |  12 ++
 accel/stubs/whpx-stub.c           |  12 ++
 accel/tcg/monitor.c               |  27 ++-
 accel/tcg/tcg-accel-ops-icount.c  |  16 +-
 accel/tcg/tcg-accel-ops-mttcg.c   |  58 +++--
 accel/tcg/tcg-accel-ops-rr.c      |  79 +++++--
 accel/tcg/tcg-accel-ops.c         |  44 ++--
 accel/tcg/tcg-all.c               |  20 +-
 accel/xen/xen-all.c               |   8 +-
 bsd-user/main.c                   |   2 +-
 gdbstub/system.c                  |   7 +-
 hw/core/machine-hmp-cmds.c        |   3 +-
 hw/core/machine-qmp-cmds.c        |   1 +
 linux-user/main.c                 |   2 +-
 system/cpus.c                     |  39 +---
 system/memory.c                   |  11 +-
 system/physmem.c                  |   8 +
 target/arm/arm-qmp-cmds.c         |   5 +-
 target/arm/cpu.c                  |   5 +-
 target/arm/hvf/hvf.c              |  11 +-
 target/i386/hvf/hvf.c             |  11 +-
 target/i386/hvf/x86hvf.c          |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c |  14 +-
 target/i386/nvmm/nvmm-all.c       |  29 +--
 target/i386/whpx/whpx-accel-ops.c |  15 +-
 target/i386/whpx/whpx-all.c       |  33 ++-
 accel/stubs/meson.build           |   2 +
 hmp-commands-info.hx              |  12 ++
 57 files changed, 947 insertions(+), 644 deletions(-)
 create mode 100644 accel/dummy-cpus.h
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 accel/stubs/whpx-stub.c

-- 
2.49.0


