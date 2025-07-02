Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367F6C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2aa-00011w-6r; Wed, 02 Jul 2025 14:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2aX-00011W-PO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:53:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2aR-0001PM-Pn
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:53:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so4491581f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482416; x=1752087216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n1E2H/j9SVmc9GvfhWyUINDMR3dS8uysg+ATGCHXWuc=;
 b=bCIV7ySfDkt7CKI3bEg0kTtr0PYWv6IQvKCRCTtuXFpy9dX5UX1+LFnujsjcGcUK9y
 Rb70i2n5QLCQCPmRR6BUiScRPcfwZpQduguP3IGmG1/JGAoM4o0OgBUXBLZsMZgyOLsX
 huJ6XX1okScHV77qwcsF6duUzqkhEBo9DSgVODnVDlPcxmC0GlaAIgqBnvFNNtL8u/Q7
 qK6uPKv7glTG3zo1YH9OvbPuYcKKMJTOvZtLsjPEy6nF7NWQeEQIO+I6XMOHbiPQJCQg
 TEJWE7RXFyTEeTrM2P63XfVXlCH+4YFPg0uHXmZr0/jG3Rt8YTRxBlB7zSKT8mBd1IXd
 jcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482416; x=1752087216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n1E2H/j9SVmc9GvfhWyUINDMR3dS8uysg+ATGCHXWuc=;
 b=P46AScRuzjMm9wur/JYs/gKOeGTxVW63NRLNrlSXPmgogw7v7A7Lw/8cNNlDahL89i
 6ejC423GbaOmDuSI0U8qzO6/TWTcUHwYSAQRNnb7ymQXBk3rgf6hyhaOJBG6q+q1kew+
 +cvx8zRB1wt0muNdPi71oocbVW7b3HY3CfW1+vMnWBzvB5p9dZofPw6eq0EUZOvdU00X
 Qviane8SSW1+6BbYEsFFC1oX7A08+JEvuf4M0beSt/H/7F0KfgsGFs1xSdtwlR9HdnTG
 U/zo81hjkOAiCv4BBlJqhzeRt7nkbKt/oHnUtgVVRS5+Lu2OUui9rkbct0m7JPAl9Odx
 wUjg==
X-Gm-Message-State: AOJu0YzGIbsazbXK7cEDx44WSXDi2rkt7xAnh0Jay9h+yoptUtqikbML
 yE5nFrouqDZ8wZrPWJCGhiwMseGvBXXJVooHhnasZxdO1ZKic3cwCL2cbySW7LbwDZqEreR++sA
 Fgf1b
X-Gm-Gg: ASbGncs88b4rmaWCfoLMNEwXHPzzGpNJuFapR3ZBjiZM+tncq98RUdhdcwSCs2vC8Q2
 qBJjSC/R8DMDtqdKgxGdFWAL/6MDsAU1tA567l8xIl8KAffioARe/om5NwS9fd3JSfQFBOU9OB6
 MoFSgD56h1JMlzP8uea5EzU7i4XqLOhPJYHYtOKH4PLuwsKJrGt6h9j3l5FRxRNJ8ZcTWFwHhoO
 MBpfUEwS+/A+rOFaWNYwdiiJHlWTxkBM3MV92/PcEIy4mMG/o6zHmVcepd7jIg54Jk/zZC0kLO8
 dnkM90ZKaXFo90UKhub6UJ+4mCfHRhYvsOTGuZzpXRu1teuRL4RQLZ/tWrbDyamk/aSv9zPv7CL
 3CGxy8kp9BIhuE1w481TbCLfTL8unCNhUtIPs
X-Google-Smtp-Source: AGHT+IF4NJ4hGwNTo/5XcnKRxNgUGs+sivMjksSdrcaD/YbkMdAjTfghLnWmDbPvCeoIUSaBoCZstg==
X-Received: by 2002:adf:e184:0:b0:3a5:2ef8:34f0 with SMTP id
 ffacd0b85a97d-3b32c0a18a9mr261372f8f.22.1751482416065; 
 Wed, 02 Jul 2025 11:53:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9989418sm5637875e9.20.2025.07.02.11.53.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:53:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 00/65] accel: Preparatory cleanups for split-accel
Date: Wed,  2 Jul 2025 20:52:22 +0200
Message-ID: <20250702185332.43650-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Missing review: 22-23, 57-59, 63

Since v3:
- Addressed Richard's review comments

Few changes needed before being able to add the
split acceleration:

- few method docstring added
- remove pointless stubs
- propagate soon required AccelState argument
- try to reduce current_accel() uses
- move declarations AccelClass <-> AccelOpsClass
- display model name in 'info cpus'
- add 'info accel' command to QMP/HMP
- make accel_create_vcpu_thread() more generic
- introduce hwaccel_enabled()

I plan to send a PR once fully reviewed.

Regards,

Phil.

Philippe Mathieu-Daudé (65):
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
  accel/system: Convert pre_resume() from AccelOpsClass to AccelClass
  hw/core/machine: Display CPU model name in 'info cpus' command
  qapi: Move definitions related to accelerators in their own file
  accel/system: Introduce @x-accel-stats QMP command
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
  accel: Pass old/new interrupt mask to handle_interrupt() handler
  accel: Expose and register generic_handle_interrupt()
  accel: Always register AccelOpsClass::kick_vcpu_thread() handler
  accel: Always register AccelOpsClass::get_elapsed_ticks() handler
  accel: Always register AccelOpsClass::get_virtual_clock() handler
  system/memory: Restrict eventfd dispatch_write() to emulators
  accel/tcg: Factor tcg_vcpu_init() out for re-use
  accel/tcg: Factor mttcg_cpu_exec() out for re-use
  accel/tcg: Factor rr_cpu_exec() out
  accel/tcg: Clear exit_request once in tcg_cpu_exec()
  accel/tcg: Unregister the RCU before exiting RR thread

 MAINTAINERS                       |   1 +
 qapi/accelerator.json             |  92 ++++++++
 qapi/machine.json                 |  68 +-----
 qapi/qapi-schema.json             |   1 +
 accel/accel-internal.h            |   2 +
 accel/dummy-cpus.h                |  15 ++
 accel/kvm/kvm-cpus.h              |   1 -
 accel/tcg/internal-common.h       |   2 +
 accel/tcg/tcg-accel-ops-icount.h  |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.h   |   4 +-
 accel/tcg/tcg-accel-ops.h         |   5 +-
 include/hw/core/cpu.h             |   3 +-
 include/qemu/accel.h              |  22 +-
 include/system/accel-ops.h        |  42 +++-
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
 accel/accel-qmp.c                 |  34 +++
 accel/accel-system.c              |  35 ++-
 accel/dummy-cpus.c                |  11 +-
 accel/hvf/hvf-accel-ops.c         | 341 +++++-------------------------
 accel/hvf/hvf-all.c               | 281 ++++++++++++++++++++++--
 accel/kvm/kvm-accel-ops.c         |  25 +--
 accel/kvm/kvm-all.c               |  38 ++--
 accel/qtest/qtest.c               |  10 +-
 accel/stubs/kvm-stub.c            |   9 -
 accel/stubs/nvmm-stub.c           |  12 ++
 accel/stubs/whpx-stub.c           |  12 ++
 accel/tcg/monitor.c               |  29 ++-
 accel/tcg/tcg-accel-ops-icount.c  |   8 +-
 accel/tcg/tcg-accel-ops-mttcg.c   |  28 +--
 accel/tcg/tcg-accel-ops-rr.c      |  40 ++--
 accel/tcg/tcg-accel-ops.c         |  44 ++--
 accel/tcg/tcg-all.c               |  20 +-
 accel/xen/xen-all.c               |  13 +-
 bsd-user/main.c                   |   2 +-
 gdbstub/system.c                  |   7 +-
 hw/core/machine-hmp-cmds.c        |   4 +-
 hw/core/machine-qmp-cmds.c        |   2 +
 linux-user/main.c                 |   2 +-
 system/cpus.c                     |  55 ++---
 system/memory.c                   |  11 +-
 system/physmem.c                  |   8 +
 target/arm/arm-qmp-cmds.c         |   5 +-
 target/arm/cpu.c                  |   5 +-
 target/arm/hvf/hvf.c              |  11 +-
 target/i386/hvf/hvf.c             |  11 +-
 target/i386/hvf/x86hvf.c          |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c |  17 +-
 target/i386/nvmm/nvmm-all.c       |  29 +--
 target/i386/whpx/whpx-accel-ops.c |  18 +-
 target/i386/whpx/whpx-all.c       |  33 ++-
 accel/meson.build                 |   2 +-
 accel/stubs/meson.build           |   2 +
 hmp-commands-info.hx              |  12 ++
 qapi/meson.build                  |   1 +
 63 files changed, 1013 insertions(+), 714 deletions(-)
 create mode 100644 qapi/accelerator.json
 create mode 100644 accel/dummy-cpus.h
 create mode 100644 accel/accel-qmp.c
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 accel/stubs/whpx-stub.c

-- 
2.49.0


