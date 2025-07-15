Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED97C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublsQ-0007ar-8O; Tue, 15 Jul 2025 16:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublaf-0001lo-PW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublab-0002eS-OI
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so53831925e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608718; x=1753213518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bedS8XdxUeR0U8Mxp6nnPuJPuV+JLV7Gob0+js/jbNc=;
 b=Fm9HgRW81E+COeKFKrWkrh+8gDGLxsiCI9q6QcEGYLnTRSDXg2SVV87o2g+0T6qXDE
 4DZulBlkJpAjaECjyvl073O3TmWD/jlq6+noE8KY0/OSJNZmYwKpfg8r74P7Pffqt8hC
 WZuCkzLCHkjf92+eyqlj9IygRMg7GrPqVm6gS/xdgRoQNOON8qpa++iCceRRlOGTKZu6
 6M0YYzbNv+IY1ZatK3Mm24pI7JkY+h+412pCYqGtFVvq7GSYGblhAHVkQXS8CGN83KGE
 lL/bhmLanEIuZ9LcywBGJ+JNguXIBFnzvT21VhV22C2hBTXslEsWTNa7ll8+Z7hbC/12
 7v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608718; x=1753213518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bedS8XdxUeR0U8Mxp6nnPuJPuV+JLV7Gob0+js/jbNc=;
 b=ZLEKuWhaR/QcMc5WS6CkQJT9I73aZbJdhuM3KY+t5iYAjER2gKx98jS+RWh06Ai/VD
 Co9xogl9Zt2QGSIGj3UpiwgV4BqO3ow1PjJaWzwb6fftdNbN/Vsa7QTPXv7A2qEE8+HK
 2AxNRtq8MUk5D37mEOZVl6sG1TehGr0Ros9bsPGOiCiymiCA7yuoBtjPpSItwsBijfsV
 LrkujESfy8V6zSL6UTB/t1w5azgr+asvO757qrE5rWopoNNnJCMcFvblNFGzHKrTOpcn
 tk6QlNWFBaC+dIX048xZVpmuo7IZQzSCY2JetE3hy7JA0V1g0JqtfWgQQm4N2AOwKTQ/
 WCTw==
X-Gm-Message-State: AOJu0YwLDbby0b2cEowemKGWq/urT6ygBXMElXCsGhLqPhX0LoNvFphM
 lg+7NrXS/WfgzhXDMyedfMzefpbYa3mB/LCkBif5F14D2wOkUcKklvLwWQN5BzXTGLtWGYE8+vL
 IemnT
X-Gm-Gg: ASbGncvB1on8O2Y2CHFTXEw6G8qob3Jxosrrfu+VAr9G9EySvYWXTljKGuwqrqqDEXO
 zLS54q9DKzZCNKAoaCOBozcvqUMtTgQkTnSJfBD5acafrTtSJrzz3TD7kP+3GLzq/sDYb/v2Qu/
 ZvaVBYNgF2fJ7adPdDTGUEcVE9TySz5o3OToFms+9ZGPCbapGIso5PlwFNZWpOAMoDVZQ4xmIFs
 cagg0mb9mM2J3Eh3R7V+r1wQq3mTOjDe/f5Vw0bQZFtP70jLOHszYksGSx8TW1h4fByQni05t6u
 H7TSEOZ7q4qAE2QTtU104PnPdJecoR1P1r+HM1mnQuFkFk31Hhxf3KAEmdQxNNe3VGVxP5WO94X
 CxxskCE/lNrCHkljGq4IDsJLqtRwIdwCPJu7SogYROlFbbFZSL5snx6DxGPwDHDKlSV6S88BXZV
 fyiw==
X-Google-Smtp-Source: AGHT+IFkagzP3DlyE9wNfPEHnHtJJU+61JzujMpz/V+Qlx3I0tFPPIUdmU3YtUagSeYs2ChjPMJ4rQ==
X-Received: by 2002:a05:6000:2910:b0:3a5:5fa4:a3f7 with SMTP id
 ffacd0b85a97d-3b60dd97c5bmr255577f8f.58.1752608718251; 
 Tue, 15 Jul 2025 12:45:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e2747fsm15537017f8f.100.2025.07.15.12.45.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Accelerators patches for 2025-07-15
Date: Tue, 15 Jul 2025 21:44:59 +0200
Message-ID: <20250715194516.91722-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-20250715

for you to fetch changes up to 0a94a7b8802b7f6dc2521e48d837d1b5173f9db4:

  system/runstate: Document qemu_add_vm_change_state_handler_prio* in hdr (2025-07-15 21:42:58 +0200)

----------------------------------------------------------------
Accelerators patches

- Unify x86/arm hw/xen/arch_hvm.h header
- Move non-system-specific 'accel/accel-ops.h' and 'accel-cpu-ops.h' to accel/
- Move KVM definitions qapi/accelerator.json
- Add @qom-type field to CpuInfoFast QAPI structure
- Display CPU model name in 'info cpus' HMP command
- Introduce @x-accel-stats QMP command
- Add 'info accel' on HMP
- Improve qemu_add_vm_change_state_handler*() docstring
- Extract TCG statistic related code to tcg-stats.c
- Implement AccelClass::get_[vcpu]_stats() handlers for TCG and HVF
- Do not dump NaN in TCG statistics
- Revert incomplete "accel/tcg: Unregister the RCU before exiting RR thread"

Spurious warnings ignored:

1/17 Checking commit 62b8cc1ecb37 (hw/xen/arch_hvm: Unify x86 and ARM variants)
WARNING: added, moved or deleted file(s):

  include/hw/arm/xen_arch_hvm.h
  include/hw/i386/xen_arch_hvm.h

Does MAINTAINERS need updating?

$ git grep xen_arch_hvm.h
$

7/17 Checking commit 05927e9dc937 (accel: Rename 'system/accel-ops.h' -> 'accel/accel-cpu-ops.h')
WARNING: added, moved or deleted file(s):

  include/accel/accel-cpu-ops.h

Does MAINTAINERS need updating?

$ ./scripts/get_maintainer.pl -f include/accel/accel-cpu-ops.h
Richard Henderson <richard.henderson@linaro.org> (maintainer:Overall)
Paolo Bonzini <pbonzini@redhat.com> (reviewer:Overall)
"Philippe Mathieu-Daudé" <philmd@linaro.org> (reviewer:Overall)

10/17 Checking commit 8cc04fd9df3b (accel/tcg: Extract statistic related code to tcg-stats.c)
WARNING: Saw acceptable license 'LGPL-2.1-or-later' but note 'GPL-2.0-or-later' is preferred for new files unless the code is derived from a source file with an existing declared license that must be retained. Please explain the license choice in the commit message.

LGPL-2.1-or-later copied (explained in commit).

WARNING: added, moved or deleted file(s):

  accel/tcg/tcg-stats.c

Does MAINTAINERS need updating?

$ ./scripts/get_maintainer.pl -f accel/tcg/tcg-stats.c
Richard Henderson <richard.henderson@linaro.org> (maintainer:Overall TCG CPUs)
Paolo Bonzini <pbonzini@redhat.com> (reviewer:Overall TCG CPUs)

11/17 Checking commit 1861993f1fc1 (accel/system: Introduce @x-accel-stats QMP command)
WARNING: added, moved or deleted file(s):

  accel/accel-qmp.c

Does MAINTAINERS need updating?

$ ./scripts/get_maintainer.pl -f accel/accel-qmp.c
Richard Henderson <richard.henderson@linaro.org> (maintainer:Overall)
Paolo Bonzini <pbonzini@redhat.com> (reviewer:Overall)
"Philippe Mathieu-Daudé" <philmd@linaro.org> (reviewer:Overall)
----------------------------------------------------------------

Philippe Mathieu-Daudé (17):
  hw/xen/arch_hvm: Unify x86 and ARM variants
  hw/arm/xen-pvh: Remove unnecessary 'hw/xen/arch_hvm.h' header
  qapi/accel: Move definitions related to accelerators in their own file
  qapi/machine: Add @qom-type field to CpuInfoFast structure
  hw/core/machine: Display CPU model name in 'info cpus' command
  accel/tcg: Do not dump NaN statistics
  accel: Rename 'system/accel-ops.h' -> 'accel/accel-cpu-ops.h'
  accel: Extract AccelClass definition to 'accel/accel-ops.h'
  Revert "accel/tcg: Unregister the RCU before exiting RR thread"
  accel/tcg: Extract statistic related code to tcg-stats.c
  accel/system: Introduce @x-accel-stats QMP command
  accel/system: Add 'info accel' on human monitor
  accel/tcg: Propagate AccelState to dump_accel_info()
  accel/tcg: Implement AccelClass::get_stats() handler
  accel/hvf: Implement AccelClass::get_vcpu_stats() handler
  system/runstate: Document qemu_add_vm_change_state_handler()
  system/runstate: Document qemu_add_vm_change_state_handler_prio* in
    hdr

 MAINTAINERS                                   |   3 +-
 qapi/accelerator.json                         |  56 +++++
 qapi/machine.json                             |  32 +--
 qapi/qapi-schema.json                         |   1 +
 accel/tcg/internal-common.h                   |   2 +-
 .../accel-ops.h => accel/accel-cpu-ops.h}     |  11 +-
 include/accel/accel-ops.h                     |  51 ++++
 include/hw/arm/xen_arch_hvm.h                 |   9 -
 include/hw/i386/xen_arch_hvm.h                |  11 -
 include/hw/xen/arch_hvm.h                     |  14 +-
 include/qemu/accel.h                          |  39 +---
 include/system/hvf_int.h                      |   3 +-
 include/system/kvm_int.h                      |   1 +
 include/system/runstate.h                     |  40 ++++
 include/tcg/tcg.h                             |   2 +
 accel/accel-common.c                          |   2 +
 accel/accel-qmp.c                             |  35 +++
 accel/accel-system.c                          |  12 +-
 accel/hvf/hvf-accel-ops.c                     |  27 ++-
 accel/hvf/hvf-all.c                           |   1 +
 accel/kvm/kvm-accel-ops.c                     |   2 +-
 accel/kvm/kvm-all.c                           |   1 +
 accel/qtest/qtest.c                           |   3 +-
 accel/tcg/monitor.c                           | 192 ---------------
 accel/tcg/tcg-accel-ops-rr.c                  |   2 -
 accel/tcg/tcg-accel-ops.c                     |   3 +-
 accel/tcg/tcg-all.c                           |   3 +
 accel/tcg/tcg-stats.c                         | 219 ++++++++++++++++++
 accel/xen/xen-all.c                           |   3 +-
 bsd-user/main.c                               |   1 +
 cpu-target.c                                  |   2 +-
 gdbstub/system.c                              |   3 +-
 hw/arm/xen-pvh.c                              |   1 -
 hw/core/machine-hmp-cmds.c                    |   5 +-
 hw/core/machine-qmp-cmds.c                    |   2 +
 linux-user/main.c                             |   1 +
 system/cpus.c                                 |   2 +-
 system/memory.c                               |   1 +
 system/runstate.c                             |  30 ---
 target/i386/nvmm/nvmm-accel-ops.c             |   2 +-
 target/i386/nvmm/nvmm-all.c                   |   1 +
 target/i386/whpx/whpx-accel-ops.c             |   2 +-
 target/i386/whpx/whpx-all.c                   |   1 +
 accel/meson.build                             |   2 +-
 accel/tcg/meson.build                         |   1 +
 hmp-commands-info.hx                          |  12 +
 qapi/meson.build                              |   1 +
 47 files changed, 515 insertions(+), 335 deletions(-)
 create mode 100644 qapi/accelerator.json
 rename include/{system/accel-ops.h => accel/accel-cpu-ops.h} (91%)
 create mode 100644 include/accel/accel-ops.h
 delete mode 100644 include/hw/arm/xen_arch_hvm.h
 delete mode 100644 include/hw/i386/xen_arch_hvm.h
 create mode 100644 accel/accel-qmp.c
 create mode 100644 accel/tcg/tcg-stats.c

-- 
2.49.0


