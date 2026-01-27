Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C87D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRT-0006fr-Bh; Tue, 27 Jan 2026 00:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRS-0006fP-9o
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRP-0008He-35
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769490997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fvcg2KHVRHrBZSA+PDmT6RE3g+H8KlOxhgRIhml3fXs=;
 b=IJrr1OG7TNqLrJVDjeTsZuc0EeccIrt5GDww7usvy5xaA+ubZs4aJbk/3fT+8Xp1dtK4Am
 acTj2p1le4MWK1n1KIicqD3yArlDy2+3t2A/lfPpSiqPk+dpnjZUcBQuntINKp9TtwwFIa
 HGTp5Eu4qsHViBrx6Dmcss7ZOnRO7/4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-v3vRQWeNNgeHPPMzx_RkdQ-1; Tue, 27 Jan 2026 00:16:34 -0500
X-MC-Unique: v3vRQWeNNgeHPPMzx_RkdQ-1
X-Mimecast-MFC-AGG-ID: v3vRQWeNNgeHPPMzx_RkdQ_1769490994
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34ac814f308so570870a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769490993; x=1770095793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fvcg2KHVRHrBZSA+PDmT6RE3g+H8KlOxhgRIhml3fXs=;
 b=ljUQPPIyPrfr4djoCAw9aX5P2L0AOHraPuSdr1wtcU0f1mBhzJEo6LNVKtPOEWAxun
 4gSDf7SP8Ug0tyMDLkK5VLubc4BYFLlrbD2XS5/8EjkNvzaPdRyuuq6AtZy/91oEJeX3
 2GlZZX8q6vA4YmxrkMCPPBwHMGxQsSftrCoDPRPkP6DE0VQzFZUgD1FsXig9616Pbla2
 wdu+5SmZFOxMFEiJ+V+lCuTKrHEfwTus/IiPWM/UiPLuh7hlvEwPPXnD+GPcNPpQNQ8W
 p8yPxv9vYA0WarREYHrqXXbVkyH6NzlKmzmrm6bTSSbndQML/jeEfAFFecbHOwxZxsbV
 baNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769490993; x=1770095793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvcg2KHVRHrBZSA+PDmT6RE3g+H8KlOxhgRIhml3fXs=;
 b=ZNNWfef2SaOZA4fY/m8tYVl21hXtAhQrqgBhySmADsW4x6yBPoUC50m+6IRXR3i9sK
 TeCE3zVdTve0k4Ligk481Ink4GeEBWAfSe2zRaPrEVSqTUSTWsVC3j810+Bpw0Z7w9r6
 K6P2+rd32AJ37KnWwxOL+f+JReJDctAX/CtzY4TfhjzpMKP8LpA4Tg6azyVsPkecvi7h
 X8Ox5SS+rN163RVuGcFzR7QJnOBeRof1E7aISiPqDiyOtjTQY3Xy//WUUwQmYgGpXV5g
 /cale5OZPYPdwUB7AhfwiFbzAf7utW97COLu5MGcAjHxn/tLH/uZkhBpuwLSBbMP/nNv
 Oopw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/uvdld8J3u/iXv+TojVxGFf+1YgHhXt2bpXxDsgLsevrarsy59OtJCoau78b0l8jRQGlxyNALUGr3@nongnu.org
X-Gm-Message-State: AOJu0YwXwhsOcv2WePVSb1Bct8v4Q5XG4QamRLOwXyvQPFQ4A9Ifqt6r
 zkhZKqornI5woDE757ViCQbssoysju4c3xEuyIRP7EIdQbVNysAJQ5zGzB/4AltLaBYlpqD0nWd
 g3yk0AGX2+7faKAw45wW2OT4Mp4Rda+LATfSzSS3LCjG7IJlx8N/2tVhC
X-Gm-Gg: AZuq6aK+aGV9EBupXLLxcXs40GEwuFBuuhFI7fhKPrXHq8+xiyVYIA27o07Ip/Q5/6v
 9mQ+NpdJ1c7yzFanK4vJwSUo23S9PiL7dVC5w5DbKuy5DGxeLekquGk2atfVkHpRHtgrAKTI5HM
 YDwtCWMIfKnXmlSiCYuDZbqsKOlVwlkGVPm3sp50aarT6pzq/97Sp2FqL/xSnVk05fXPQV858Ra
 8qObsHDL/TFMHsJprZFXUanevpZ9SfIfEC25TYoKM1J/0bSQftP39RRC1Np85jAML9gt1XkiVl+
 PS2xk6jl3PPl1FIY8mRtsbKbCmM/9kfTGwCnWEqGHVCSioigyNQe2k+Z1SMrApcHx4aj/bXkL86
 i4RjK7VHQaEAyGVrXiJgW8aQH7UQJdaJzLxG6TQLVDg==
X-Received: by 2002:a17:90a:f945:b0:32d:a0f7:fa19 with SMTP id
 98e67ed59e1d1-353fed902abmr790880a91.17.1769490992834; 
 Mon, 26 Jan 2026 21:16:32 -0800 (PST)
X-Received: by 2002:a17:90a:f945:b0:32d:a0f7:fa19 with SMTP id
 98e67ed59e1d1-353fed902abmr790857a91.17.1769490992469; 
 Mon, 26 Jan 2026 21:16:32 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:16:32 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, vkuznets@redhat.com, graf@amazon.com
Subject: [PATCH v3 00/33] Introduce support for confidential guest reset (x86)
Date: Tue, 27 Jan 2026 10:45:28 +0530
Message-ID: <20260127051612.219475-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This change introduces support for confidential guests
(SEV-ES, SEV-SNP and TDX) to reset/reboot just like other non-confidential
guests. Currently, a reboot intiated from the confidential guest results
in termination of the QEMU hypervisor as the CPUs are not resettable. As the
initial state of the guest including private memory is locked and encrypted,
the contents of that memory will not be accessible post reset. Hence a new
KVM file descriptor must be opened to create a new confidential VM context
closing the old one. All KVM VM specific ioctls must be called again. New
VCPU file descriptors must be created against the new KVM fd and most VCPU
ioctls must be called again as well.

This change perfoms closing of the old KVM fd and creating a new one. After
the new KVM fd is opened, all generic and architecture specific ioctl calls
are issued again. Notifiers are added to notify subsystems that:
- The KVM file fd is about to be changed to state sync-ing from KVM to QEMU
  should be done if required.
- The KVM file fd has changed, so ioctl calls to the new KVM fd has to be
  performed again.
- That new VCPU fds are created so that VCPU ioctl calls must be called again
  where required.

Specific subsystems use these notifiers to re-issue ioctl calls where required.

Changes are made to SEV and TDX modules to reinitialize the confidential guest
state and seal it again. Along the way, some bug fixes are made so that some
initialization functions can be called again. Some refactoring of existing
code is done so that both init and reset paths can use them.

Tested on TDX, SEV-ES and SEV-SNP. Tested on non-coco hardware. Tested with Xen
emulation enabled.

CI pipeline passes:
https://gitlab.com/anisinha/qemu/-/pipelines/2278323424

Please review and test.

CC: qemu-devel@nongnu.org
CC: pbonzini@redhat.com
CC: kraxel@redhat.com
CC: vkuznets@redhat.com
CC: graf@amazon.com

Changelog:

v3:
 - Combined pre and post vmfd change notifier into one.
 - rename kvm_arch_vmfd_change_ops() -> kvm_arch_on_vmfd_change()
 - reuse kvm_arch_init() code in kvm_arch_on_vmfd_change()
 - moved around migration blockers and notifers to more appropriate place.
 - fixed Xen emulation.
 - fixed SEV-ES reset.
 - fixed/reorganized reset code in system/runstate.c
 - can_rebuild_guest_state is now a boolean not a callback.
 - misc fixes.
 - added a functional test for Xen emulation with vmfd change.
 - rebased.

v2:
 - Bugfixes.
 - Added a new machine option so that we can exercize most of the non-coco changes
   related to reboot on non-coco platforms.
 - added a new functional test. Currently its skipped on CI pipeline as KVM is not
   enabled (no /dev/kvm on the container)for QEMU CI tests. It can be run manually and it
   passes on those systems where KVM is enabled.
 - Addressed comments from v1 with regards to refactoring of code, code simplication by
   removal of redundant stuff, moved around code
   so that notifiers, migration blockers are added only on one place.
 - Added some tracepoints for future debugging on newly added functions.
 - Rebased.


Ani Sinha (33):
  i386/kvm: avoid installing duplicate msr entries in msr_handlers
  accel/kvm: add confidential class member to indicate guest rebuild
    capability
  hw/accel: add a per-accelerator callback to change VM accelerator
    handle
  system/physmem: add helper to reattach existing memory after KVM VM fd
    change
  accel/kvm: add changes required to support KVM VM file descriptor
    change
  accel/kvm: mark guest state as unprotected after vm file descriptor
    change
  accel/kvm: add a notifier to indicate KVM VM file descriptor has
    changed
  accel/kvm: notify when KVM VM file fd is about to be changed
  i386/kvm: unregister smram listeners prior to vm file descriptor
    change
  kvm/i386: implement architecture support for kvm file descriptor
    change
  hw/i386: refactor x86_bios_rom_init for reuse in confidential guest
    reset
  hw/i386: export a new function x86_bios_rom_reload
  kvm/i386: reload firmware for confidential guest reset
  accel/kvm: rebind current VCPUs to the new KVM VM file descriptor upon
    reset
  i386/tdx: refactor TDX firmware memory initialization code into a new
    function
  i386/tdx: finalize TDX guest state upon reset
  i386/tdx: add a pre-vmfd change notifier to reset tdx state
  i386/sev: add migration blockers only once
  i386/sev: add notifiers only once
  i386/sev: free existing launch update data and kernel hashes data on
    init
  i386/sev: add support for confidential guest reset
  hw/vfio: generate new file fd for pseudo device and rebind existing
    descriptors
  kvm/i8254: refactor pit initialization into a helper
  kvm/i8254: add support for confidential guest reset
  hw/hyperv/vmbus: add support for confidential guest reset
  kvm/xen-emu: re-initialize capabilities during confidential guest
    reset
  kvm/xen_evtchn: add support for confidential guest reset
  ppc/openpic: create a new openpic device and reattach mem region on
    coco reset
  kvm/vcpu: add notifiers to inform vcpu file descriptor change
  kvm/i386/apic: set local apic after vcpu file descriptors changed
  kvm/clock: add support for confidential guest reset
  hw/machine: introduce machine specific option 'x-change-vmfd-on-reset'
  tests/functional/x86_64: add functional test to exercise vm fd change
    on reset

 MAINTAINERS                                   |   6 +
 accel/kvm/kvm-all.c                           | 348 ++++++++++++++++--
 accel/kvm/trace-events                        |   2 +
 accel/stubs/kvm-stub.c                        |  18 +
 hw/core/machine.c                             |  22 ++
 hw/hyperv/vmbus.c                             |  36 ++
 hw/i386/kvm/apic.c                            |  13 +
 hw/i386/kvm/clock.c                           |  59 +++
 hw/i386/kvm/i8254.c                           |  88 +++--
 hw/i386/kvm/xen_evtchn.c                      | 113 +++++-
 hw/i386/x86-common.c                          |  72 +++-
 hw/intc/openpic_kvm.c                         | 112 ++++--
 hw/vfio/helpers.c                             |  86 ++++-
 include/accel/accel-ops.h                     |   1 +
 include/hw/core/boards.h                      |   6 +
 include/hw/i386/apic_internal.h               |   1 +
 include/hw/i386/x86.h                         |   2 +-
 include/system/confidential-guest-support.h   |  20 +
 include/system/kvm.h                          |  42 +++
 include/system/physmem.h                      |   1 +
 system/physmem.c                              |  28 ++
 system/runstate.c                             |  30 +-
 target/arm/kvm.c                              |  10 +
 target/i386/kvm/kvm.c                         | 137 +++++--
 target/i386/kvm/tdx.c                         | 141 +++++--
 target/i386/kvm/tdx.h                         |   1 +
 target/i386/kvm/trace-events                  |   4 +
 target/i386/kvm/xen-emu.c                     |  50 ++-
 target/i386/sev.c                             | 127 +++++--
 target/i386/trace-events                      |   1 +
 target/loongarch/kvm/kvm.c                    |  10 +
 target/mips/kvm.c                             |  10 +
 target/ppc/kvm.c                              |  10 +
 target/riscv/kvm/kvm-cpu.c                    |  10 +
 target/s390x/kvm/kvm.c                        |  10 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vmfd_change_reboot.py         |  96 +++++
 37 files changed, 1508 insertions(+), 216 deletions(-)
 create mode 100755 tests/functional/x86_64/test_vmfd_change_reboot.py

-- 
2.42.0


