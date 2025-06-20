Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8D2C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJG-0000Ms-Nw; Fri, 20 Jun 2025 13:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJF-0000Mc-LV
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:13:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJD-00048Y-Eb
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:13:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so1406899f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439624; x=1751044424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sGEipVp0kvRMcwTf7xREM8W2Qp766KJTGueyK0gIYiM=;
 b=wVBRqRr+kQUexKAbNc4Y5wtzKBNa95tM75kxvfXVdly96tLkki27FOJGujy79bEQU0
 ojB8UzCWgiwoRLUM0hOb5xJ9Jp21WzotOn5ZiAsoSalTZo8VIsgsYx0uYHX5me9NqijL
 la47noWnlUwkHwtzP9Lg0Bbd4xOrk8YIEEjD8di9ywfS3jtGrRaBKQhVWxsf4DD9uKZu
 0QOFluFc055n4kWdzQbzXbALtDynB1Q2AGltZD0Q+QBNzH/WWjvgLvVZK5kNfWHDa+YM
 afO87tGvJ8Okt6HCVt0hYKPusjoQL9Hr0QvOhM//534JvSzxfYqRWEY0cEemYoENxW6a
 JX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439624; x=1751044424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sGEipVp0kvRMcwTf7xREM8W2Qp766KJTGueyK0gIYiM=;
 b=KY95VU1ZLlJjJ20zsW5R148D3PRWfoWwXLnbLVn+Hdvgt6NSydTOAnRGoRKPWeTUDI
 SPJ/WWi6s8Wf3EKYjuQPMP7wj40qfT8W2N8CIfn53NqqONOZM55BKa5QMOqFXzEsQuRG
 LxqB7pG/nrClH7jY5tzpOWSB9IjPxfy5EhvdiGEukQmjrfacmDRt6xQoovUqaAOgh6jE
 ubFwtJH3DFluBILMyM+Ua0PhxKVDBKM0zgdr3wri5SKwIJqBg3JqiyS57q24vcxrrU2h
 R1USuXbORTxoZAWF07rHOd0E/9bKXfiJ1SPW0p+l9cxJY7Zr1GSKsPSMlK792oeDKUl9
 YaQg==
X-Gm-Message-State: AOJu0YwdXwZ90PAPhcMu7QKOPvYKkHSE1Wz38qGVcJIBKaAynbcQ7aHh
 XcRh7XfPyEI173aqiKGi63SG5HB4gHLaxZPsktD+0sLioEc7N4lyR4WK7ZZmSRACzBd/S8B6V78
 6skgpok0=
X-Gm-Gg: ASbGncuvMliOMC8Nz32dy6R2rh/YGwflce2E7a3v8nGvN0RkpOKAQAb2/b+NdH2Dula
 jGTyI443/ngVwnpvoeEfunRjT8EGqPetRIOuZBks9Hx+2uqjF4gHOaa+WCHpe4ZAg0I654hXxDW
 L/e1YnRomcs2qVaq7KUmF7rmk6l1I1gta9y3TwcvydkZ2dVfHn7LOPh9S48qBLLNGK9nTK6gUaq
 PeyHqBdQ94dPLtONQy99CcCcu9EBEuQJJQtpdCl4OiQr1wiPp96BkcNundHqozsI1XFWwC0U9Vr
 AMVGJ0XTfUGpVWgQbdpFWJbyomrR1FPJ9JDZuAGETzacHDf6G/9SMYBn3TO23fTrinER6DMNdgk
 Z2+ifzdq/ZLxCPNAmrbMVR8vzfIvBjRWOzTA2
X-Google-Smtp-Source: AGHT+IFg5tTtZTHnXhs8aVR4hLF6fsp9NnTEA6y3Ve2uLQm4z4itQYvoLhEsAruOgN3kSTWEgb8q7Q==
X-Received: by 2002:a05:6000:3109:b0:3a5:2c18:b181 with SMTP id
 ffacd0b85a97d-3a6d1317ed0mr3376060f8f.53.1750439624120; 
 Fri, 20 Jun 2025 10:13:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c6b2sm2580736f8f.46.2025.06.20.10.13.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:13:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 00/48] accel: Preparatory cleanups for split-accel
Date: Fri, 20 Jun 2025 19:12:53 +0200
Message-ID: <20250620171342.92678-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Commit descriptions are scarse because it is a RFC
(and I'm quite tired before the week-end).

Also available in the split-accel-rfc-v5 tag:
https://gitlab.com/philmd/qemu/-/commits/split-accel-rfc-v5

Regards,

Phil.

Philippe Mathieu-Daudé (48):
  system/runstate: Document qemu_add_vm_change_state_handler()
  system/cpus: Defer memory layout changes until vCPUs are realized
  system/cpus: Assert interrupt handling is done with BQL locked
  accel/kvm: Remove kvm_init_cpu_signals() stub
  accel/kvm: Reduce kvm_create_vcpu() declaration scope
  accel: Propagate AccelState to AccelClass::init_machine()
  accel/kvm: Prefer local AccelState over global MachineState::accel
  accel/hvf: Re-use QOM allocated state
  accel/tcg: Prefer local AccelState over global current_accel()
  accel: Pass AccelState argument to gdbstub_supported_sstep_flags()
  accel: Move supports_guest_debug() declaration to AccelClass
  accel: Move cpus_are_resettable() declaration to AccelClass
  accel: Move cpu_common_[un]realize() declarations to AccelOpsClass
  hw/core/machine: Display CPU model name in 'info cpus' command
  accel/system: Add 'info accel' on human monitor
  accel/tcg: Factor tcg_dump_flush_info() out
  accel/tcg: Implement get_[vcpu]_stats()
  accel/hvf: Implement get_vcpu_stats()
  cpus: Document CPUState::vcpu_dirty field
  cpus: Rename 'vcpu_dirty' field as negated 'hwaccel_synchronized'
  accel/hvf: Replace @dirty field by generic @hwaccel_synchronized
  accel/nvmm: Replace @dirty field by generic @hwaccel_synchronized
  accel/whpx: Replace @dirty field by generic @hwaccel_synchronized
  accel/kvm: Remove kvm_cpu_synchronize_state() stub
  accel/system: Document cpu_synchronize_state()
  accel/system: Document cpu_synchronize_state_post_init/reset()
  accel/dummy: Factor dummy_thread_precreate() out
  accel/dummy: Factor tcg_vcpu_thread_precreate() out
  accel: Factor accel_create_vcpu_thread() out
  accel: Introduce AccelOpsClass::cpu_thread_routine handler
  accel/dummy: Convert to AccelOpsClass::cpu_thread_routine
  accel/tcg: Convert to AccelOpsClass::cpu_thread_routine
  accel/hvf: Convert to AccelOpsClass::cpu_thread_routine
  accel/kvm: Convert to AccelOpsClass::cpu_thread_routine
  accel/nvmm: Convert to AccelOpsClass::cpu_thread_routine
  accel/whpx: Convert to AccelOpsClass::cpu_thread_routine
  accel/nvmm: Expose nvmm_enabled() to common code
  accel/whpx: Expose whpx_enabled() to common code
  accel/system: Introduce hwaccel_enabled() helper
  accel: Factor accel_cpu_realize() out
  accel/tcg: Factor tcg_vcpu_init() out for re-use
  accel/tcg: Expose vcpu_[un]register() and cpu_exec() for MTTCG
  accel/tcg: Expose vcpu_[un]register() and cpu_exec() for RR
  accel/system: Declare init/exec/destroy vcpu hooks
  accel/tcg: Register init/exec/destroy vcpu hooks
  accel/hvf: Register init/exec/destroy vcpu hooks
  accel: Expose generic_handle_interrupt()
  system: Introduce SysemuCPUOps::can_accelerate()

 qapi/machine.json                 |  3 ++
 accel/accel-internal.h            |  2 +
 accel/tcg/internal-common.h       |  2 +
 accel/tcg/tcg-accel-ops-icount.h  |  4 +-
 accel/tcg/tcg-accel-ops-mttcg.h   |  7 ++-
 accel/tcg/tcg-accel-ops-rr.h      |  3 ++
 accel/tcg/tcg-accel-ops.h         |  5 ++
 include/hw/core/cpu.h             | 13 +++++-
 include/hw/core/sysemu-cpu-ops.h  |  4 ++
 include/qemu/accel.h              | 11 +++--
 include/system/accel-ops.h        | 32 +++++++++++--
 include/system/cpus.h             |  5 +-
 include/system/hvf.h              |  2 +-
 include/system/hvf_int.h          |  1 -
 include/system/hw_accel.h         | 34 +++++++++++++-
 include/system/kvm.h              |  8 ----
 include/system/nvmm.h             | 23 +++++-----
 include/system/runstate.h         | 10 ++++
 include/system/whpx.h             | 27 +++++------
 accel/accel-common.c              | 60 ++++++++++++++++++++----
 accel/accel-system.c              | 40 +++++++++++++++-
 accel/dummy-cpus.c                | 10 +---
 accel/hvf/hvf-accel-ops.c         | 60 ++++++++++++------------
 accel/kvm/kvm-accel-ops.c         | 18 +-------
 accel/kvm/kvm-all.c               | 42 ++++++++++-------
 accel/qtest/qtest.c               |  5 +-
 accel/stubs/kvm-stub.c            |  9 ----
 accel/stubs/nvmm-stub.c           | 12 +++++
 accel/stubs/whpx-stub.c           | 12 +++++
 accel/tcg/monitor.c               | 27 +++++++----
 accel/tcg/tcg-accel-ops-icount.c  |  8 ++--
 accel/tcg/tcg-accel-ops-mttcg.c   | 53 +++++++++++++--------
 accel/tcg/tcg-accel-ops-rr.c      | 76 +++++++++++++++++++++----------
 accel/tcg/tcg-accel-ops.c         | 36 +++++++++++----
 accel/tcg/tcg-all.c               | 20 ++++++--
 accel/xen/xen-all.c               |  3 +-
 bsd-user/main.c                   |  2 +-
 gdbstub/system.c                  |  7 +--
 hw/core/cpu-system.c              | 13 ++++++
 hw/core/machine-hmp-cmds.c        |  3 +-
 hw/core/machine-qmp-cmds.c        |  1 +
 linux-user/main.c                 |  2 +-
 system/cpus.c                     | 18 ++------
 system/physmem.c                  |  8 ++++
 target/arm/hvf/hvf.c              |  6 +--
 target/i386/hvf/hvf.c             |  6 +--
 target/i386/hvf/x86hvf.c          |  2 +-
 target/i386/nvmm/nvmm-accel-ops.c | 12 +----
 target/i386/nvmm/nvmm-all.c       | 29 +++++-------
 target/i386/whpx/whpx-accel-ops.c | 12 +----
 target/i386/whpx/whpx-all.c       | 30 +++++-------
 target/mips/kvm.c                 |  4 +-
 accel/stubs/meson.build           |  2 +
 hmp-commands-info.hx              | 12 +++++
 54 files changed, 560 insertions(+), 296 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 accel/stubs/whpx-stub.c

-- 
2.49.0


