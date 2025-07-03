Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0BEC83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNny-0005SI-WD; Thu, 03 Jul 2025 13:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNnx-0005Rx-2s
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNnr-0007hy-CQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:32:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453066fad06so823635e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563970; x=1752168770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W8mzxLMDAw7mPbm5eyR5Sm97eof2ldzRj3FAD4w+r10=;
 b=n5BmwERjaEVhbSLpGmaD6gMlqEhsPyc0OiEZL1ZtQKJWMck7kaVguYDgv5P/iNHyrR
 8+kxfuN2qCvePZKRo7ubaYOma/cGEI/E6tRgPgl7853tEk4+2kAVpi6zYkGYOkxsw7jv
 MBPWc2Xv/KlSLbhnvCO9jokZhP28aHNrBQNBWk1WptUGDI1mCk0gkM5MSzUEaeldCqrD
 wa/mdXyyWX3NJPuehhfivd8Rgzm9S8r7wfHDOI8SQ5S0+6tlU3ni9HjK4Z9aHd48OaCU
 UpT8bSXtpg1ewDxy9XHl1GQnPegRt9yc0CkiRsf3Vj6PNsaRXvI6iekehbxMpG3sHblJ
 lQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563970; x=1752168770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W8mzxLMDAw7mPbm5eyR5Sm97eof2ldzRj3FAD4w+r10=;
 b=VGFvu0jmrkRY0hmKlyu4kQf4F9slIvKlL/CkTbEirbAvNVlR44JZYzSKsVZ82iJnfX
 CniQa2vmwzO0tmuxBIPPfrxEiHb5s4jfFPxaZ50WXnMNuL+zUw3sw0PETxw7jQXk1BPX
 FtLSgxc5IpIms/b+kYSe+WyNsKAcM5dpPkVPPgOKIY4GC5F19JAPjpuYS45b6v3vpzNf
 TMJKQztGJjyBcbBNeurENp09NMpPTZ9UgoerDhHsaBxeVkM1BTYX6ECb7zuDv1HJR2Lr
 GALaZFqHs3ecNIITt1PFbct0DYVPKLywWQxE7BnjLeb4xujJue0kOkOgw1LtWghs+d5a
 jXkQ==
X-Gm-Message-State: AOJu0YzPcjJfJfShBqpNGxPqqDrwKu3j9t4ZL/id4m8xt1wIr7Bie01h
 hBtXY7fx/avh7YtZyd+LAv31EzHXXG3jyoxIJkGtg0LSlqUECL5f+lZyl1X5ypmtMT6W8X0PD6x
 hlBnHW4U=
X-Gm-Gg: ASbGncuF+yRF46jEj9T/et6m3rt1kHCP42VNygTQfPbzPSM6wEyvJratxR4NHhaWGPS
 cfDBvLgPFW7qC3CigIdSR/PerID6kjs1HMxxhDmfKOjFZthfdmkCBhkYCjjUvNxDrP3m6BY10RT
 Et5fNtEXTk2caUmoeIypWOmiYhAkhTjXMtZTWT7DT+IJETYrJGWuoq9QolS3pMWky0VhaCjPwWW
 MLL6x51lbw9Iy5IDr4bJ02IW0+G97H+bgoy2C/GDmcVRVElt//LkPFcfVXpy7WWkyXxq6TyD3lg
 qsPtD+k6/JP2TIvyZimxdckjjxkghmtpT+CTROJtWSAokjFHgFxhuOuq7gxqoQpbEpb71szVblB
 dmKLZXFAT7EF4XIEtBxtFGr0WXUDKmVMFE9HN
X-Google-Smtp-Source: AGHT+IGxU399kjHtn1X+Y1L2lhcrBGqzpCZ23A3cz5VNFpCH+zRqLuaNUEgwDa3r8XS8h0SlrNh29Q==
X-Received: by 2002:a05:600c:528e:b0:453:7bd:2e30 with SMTP id
 5b1f17b1804b1-454ab3b1bb5mr41140895e9.29.1751563970548; 
 Thu, 03 Jul 2025 10:32:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997de2asm32336445e9.12.2025.07.03.10.32.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:32:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 00/39] accel: Preparatory cleanups for split-accel
Date: Thu,  3 Jul 2025 19:32:06 +0200
Message-ID: <20250703173248.44995-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Missing review: 11, 37-39

Since v5:
- Dropped patches with problems
- Moved system/accel-ops.h -> generic accel/ namespace
- Added R-b tags

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

Philippe Mathieu-Daudé (39):
  hw/core/machine: Display CPU model name in 'info cpus' command
  system/memory: Restrict eventfd dispatch_write() to emulators
  system/runstate: Document qemu_add_vm_change_state_handler()
  system/cpus: Assert interrupt handling is done with BQL locked
  accel/kvm: Remove kvm_init_cpu_signals() stub
  accel/kvm: Reduce kvm_create_vcpu() declaration scope
  accel/tcg: Remove 'info opcount' and @x-query-opcount
  accel/tcg: Remove profiler leftover
  accel/tcg: Factor tcg_dump_flush_info() out
  accel/tcg: Factor tcg_dump_stats() out for re-use
  accel/tcg: Extract statistic related code to tcg-stats.c
  accel: Move supports_guest_debug() declaration to AccelClass
  accel: Move cpus_are_resettable() declaration to AccelClass
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
  accel/dummy: Extract 'dummy-cpus.h' header from 'system/cpus.h'
  accel: Pass old/new interrupt mask to handle_interrupt() handler
  accel: Expose and register generic_handle_interrupt()
  accel: Keep reference to AccelOpsClass in AccelClass
  accel: Propagate AccelState to AccelClass::init_machine()
  accel/kvm: Prefer local AccelState over global MachineState::accel
  accel/tcg: Prefer local AccelState over global current_accel()
  accel: Directly pass AccelState argument to AccelClass::has_memory()
  accel/kvm: Directly pass KVMState argument to do_kvm_create_vm()
  accel: Remove unused MachineState argument of AccelClass::setup_post()
  accel: Pass AccelState argument to gdbstub_supported_sstep_flags()
  accel: Rename 'system/accel-ops.h' -> 'accel/accel-cpu-ops.h'
  accel: Extract AccelClass definition to 'accel/accel-ops.h'
  MAINTAINERS: Add me as reviewer of overall accelerators section

 MAINTAINERS                                   |   4 +-
 qapi/machine.json                             |  21 +-
 accel/dummy-cpus.h                            |  14 +
 accel/kvm/kvm-cpus.h                          |   1 -
 accel/tcg/internal-common.h                   |   2 +
 accel/tcg/tcg-accel-ops-icount.h              |   2 +-
 accel/tcg/tcg-accel-ops.h                     |   2 +-
 .../accel-ops.h => accel/accel-cpu-ops.h}     |  34 +-
 include/accel/accel-ops.h                     |  50 +++
 include/hw/core/cpu.h                         |   3 +-
 include/qemu/accel.h                          |  35 +-
 include/system/cpus.h                         |   5 -
 include/system/hvf.h                          |  38 ---
 include/system/hvf_int.h                      |  38 ++-
 include/system/hw_accel.h                     |  21 +-
 include/system/kvm.h                          |   8 -
 include/system/kvm_int.h                      |   1 +
 include/system/nvmm.h                         |  23 +-
 include/system/runstate.h                     |  10 +
 include/system/whpx.h                         |  27 +-
 accel/accel-common.c                          |   4 +-
 accel/accel-system.c                          |  20 +-
 accel/dummy-cpus.c                            |   1 +
 accel/hvf/hvf-accel-ops.c                     | 317 +++---------------
 accel/hvf/hvf-all.c                           | 279 +++++++++++++--
 accel/kvm/kvm-accel-ops.c                     |  10 +-
 accel/kvm/kvm-all.c                           |  39 ++-
 accel/qtest/qtest.c                           |   7 +-
 accel/stubs/kvm-stub.c                        |   9 -
 accel/stubs/nvmm-stub.c                       |  12 +
 accel/stubs/whpx-stub.c                       |  12 +
 accel/tcg/monitor.c                           | 210 +-----------
 accel/tcg/tcg-accel-ops-icount.c              |   8 +-
 accel/tcg/tcg-accel-ops.c                     |  19 +-
 accel/tcg/tcg-all.c                           |  13 +-
 accel/tcg/tcg-stats.c                         | 206 ++++++++++++
 accel/xen/xen-all.c                           |   9 +-
 bsd-user/main.c                               |   3 +-
 cpu-target.c                                  |   2 +-
 gdbstub/system.c                              |  11 +-
 hw/core/machine-hmp-cmds.c                    |   3 +-
 hw/core/machine-qmp-cmds.c                    |   1 +
 linux-user/main.c                             |   3 +-
 system/cpus.c                                 |  28 +-
 system/memory.c                               |  12 +-
 target/arm/hvf/hvf.c                          |   6 +-
 target/i386/hvf/hvf.c                         |   6 +-
 target/i386/hvf/x86hvf.c                      |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c             |   3 +-
 target/i386/nvmm/nvmm-all.c                   |  32 +-
 target/i386/whpx/whpx-accel-ops.c             |   3 +-
 target/i386/whpx/whpx-all.c                   |  33 +-
 tests/qtest/qmp-cmd-test.c                    |   1 -
 accel/stubs/meson.build                       |   2 +
 accel/tcg/meson.build                         |   1 +
 hmp-commands-info.hx                          |  14 -
 56 files changed, 876 insertions(+), 804 deletions(-)
 create mode 100644 accel/dummy-cpus.h
 rename include/{system/accel-ops.h => accel/accel-cpu-ops.h} (70%)
 create mode 100644 include/accel/accel-ops.h
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 accel/stubs/whpx-stub.c
 create mode 100644 accel/tcg/tcg-stats.c

-- 
2.49.0


