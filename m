Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB53EEDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ95-0007Yq-HN; Thu, 12 Feb 2026 01:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ92-0007YF-SR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ8z-0005BT-5l
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=M/zIKHy/JLp58WzuFBf64VPZGmrfg1O41eyasP7iQqY=;
 b=dUlBt4XBhmWkvhJbn2X3NpOXP3IYJRbtVFuFMv/kyIAR9O2RRTFqKB6uzGZubfyHGZcbQS
 M4dL72zsY8oiIurPqBmB/FrgePBB2B6qYlMjfT6l9py2odAdGnZCWU9GzZuoXVVQyrxCYd
 26XMNrrCgwCcTFDHjKdggdzYHPFnz/0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-6DSHxJMGNbmJOUNSo8Jhyg-1; Thu, 12 Feb 2026 01:25:37 -0500
X-MC-Unique: 6DSHxJMGNbmJOUNSo8Jhyg-1
X-Mimecast-MFC-AGG-ID: 6DSHxJMGNbmJOUNSo8Jhyg_1770877536
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aaeafeadbcso45912885ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877536; x=1771482336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M/zIKHy/JLp58WzuFBf64VPZGmrfg1O41eyasP7iQqY=;
 b=WLgTgC39HbIjy01zvdXs12q8Kuy1xWkNXwgRHicnZWPH5O5wFPOb5SJDizwn8rL4cG
 kSiB9hgDvehyg9pMv294o1ViOVWuYQKBaC9S4FpP/1URFOo3wXgtLRvR0/AandoRd1Av
 9leijtlxZgDz9WbaUya/XephUwoUIXa1oVU58JTzzAZoIMLQLNvwjBU6ylPgbDaramA4
 JGPoLBYw+j6u15UuXPyxMwYsigg8d+hDr6LQBNLjMTqter05WS+7ZWXz0DrmT51QSv86
 Ywv4V+rQx66NSEPmbw2BuLLrUaKMX3f2G7yq+cDEKwnBaLfN7LDFMvCMaWT3aS9fc/jA
 8OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877536; x=1771482336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/zIKHy/JLp58WzuFBf64VPZGmrfg1O41eyasP7iQqY=;
 b=wMbUqmGVLBK1HL8033gT7x+qJPDhikUfxn2ySd+bVnGicrw94wilE8ad26IUGKOwOQ
 Ahr7jygRlcPvPaa45113ybftCee5i8N/HpvLIK5VQiQZjXzkbz+fGy3U6iBH2iVQbBB0
 88WDqt+Qi+YYrybPuFucbA1kVDLMul/IuF6UoSCwlOfEkmfqTOzViLidQm2/0fBA9OZn
 KgATZE50BFfFJvOVU+axwjFxnwgFIt4UuK7Yg2d+ODjTQ0Dx9ytUnYZ23niCuPKgioxw
 MrKiwNJLf7V1/NEySxg2DLV1cckAGkKaxN5NNd/88H8yL/qwALMxquoU/UgzhGAlhPTq
 qqqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLC8Q6uo3LkkUBcB9iqBKoaD+mTKWOUAEBtuevCA6moE+QAywOwWDtbkhkcMW4Fnk3iLgecxxd9jm3@nongnu.org
X-Gm-Message-State: AOJu0YwFZ2aKww8GRdxlX/L/PemBvZj/vqrnTSAIZginmgx5zm2IQ+D/
 e5rV27bQkfJDzL1XWy5O3c7CvM53TQOYyCgRZtEpfCHOW2pi3GKGejqMndkdUrnLsLmkQ2wB9Vn
 sXuiAxjK+H4dYy+L/sIyPbaxTPHPU3S2ecPN0GFHxn+Gs9TAqX7wlV6lo
X-Gm-Gg: AZuq6aJwumegWm7rLXIBeGhRI9oKOyUYdv/XZgDclylJ/2xAoFV0PEutsBFL7guv1If
 STn7EX06VSGTx/CWihEkzDb9WWvhSCdwF8Z7TFCtWuEGns8aVDf+TxjOndMjS5OMgMXwxlYMGjg
 sOXDKqXFpVtncTyFNz85+M0OoW7glMfkE4UGE47BHEfYCedJEQRmlLXgg5k/VSjB13Vox4bhlSK
 KKxxXsTbiknjeA6L19mi2pDuxeD8OE1NCjbQ5/pQ4avWSadmt4KO/VgXM5pOkuYxL9viGIOkcKM
 xrYoKsDIVUJjT8/Hk83wUffsT17klYPXQGD2lUoXMukrDvRl0n9akUtcoPFLTFMdLqJu703lWC4
 6FajAkycXHc5vnqpEg2PJRIxVfxbZlu0vbix+k0MkGsI0ufavlpkBqAQ=
X-Received: by 2002:a05:6a20:cf8a:b0:394:2fbb:bc6b with SMTP id
 adf61e73a8af0-39448803ac0mr1506227637.46.1770877535933; 
 Wed, 11 Feb 2026 22:25:35 -0800 (PST)
X-Received: by 2002:a05:6a20:cf8a:b0:394:2fbb:bc6b with SMTP id
 adf61e73a8af0-39448803ac0mr1506203637.46.1770877535496; 
 Wed, 11 Feb 2026 22:25:35 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:35 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, vkuznets@redhat.com, graf@amazon.com
Subject: [PATCH v4 00/31] Introduce support for confidential guest reset (x86)
Date: Thu, 12 Feb 2026 11:54:44 +0530
Message-ID: <20260212062522.99565-1-anisinha@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CI pipeline passes (one failure is unrelated):
https://gitlab.com/anisinha/qemu/-/pipelines/2320974514

Added functional test passed:

$ ./build/run tests/functional/x86_64/test_vmfd_change_reboot.py 
TAP version 13
ok 1 test_vmfd_change_reboot.KVMGuest.test_reset_console
ok 2 test_vmfd_change_reboot.KVMGuest.test_reset_hyperv_vmbus
ok 3 test_vmfd_change_reboot.KVMGuest.test_reset_kvmpit
ok 4 test_vmfd_change_reboot.KVMGuest.test_reset_qmp
ok 5 test_vmfd_change_reboot.KVMGuest.test_reset_xen_emulation
1..5

Please review and test.

CC: qemu-devel@nongnu.org
CC: pbonzini@redhat.com
CC: kraxel@redhat.com
CC: vkuznets@redhat.com
CC: graf@amazon.com

Changelog:

v4:
 - Fixed reset on non-coco with qmp "system_reset" command.
 - Numerious misc fixes.
 - addressed review comments from v3.
 - dropped three patches that are not required.
 - Added more functional tests including one vmbus test.
 - added noop callbacks to stubs/kvm removing them from arch specific headers.
 - Tags added.
 - Rebased.

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


Ani Sinha (31):
  i386/kvm: avoid installing duplicate msr entries in msr_handlers
  accel/kvm: add confidential class member to indicate guest rebuild
    capability
  hw/accel: add a per-accelerator callback to change VM accelerator
    handle
  system/physmem: add helper to reattach existing memory after KVM VM fd
    change
  accel/kvm: add changes required to support KVM VM file descriptor
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
  kvm/hyperv: add synic feature to CPU only if its not enabled
  hw/hyperv/vmbus: add support for confidential guest reset
  kvm/xen-emu: re-initialize capabilities during confidential guest
    reset
  ppc/openpic: create a new openpic device and reattach mem region on
    coco reset
  kvm/vcpu: add notifiers to inform vcpu file descriptor change
  kvm/clock: add support for confidential guest reset
  hw/machine: introduce machine specific option 'x-change-vmfd-on-reset'
  tests/functional/x86_64: add functional test to exercise vm fd change
    on reset

 MAINTAINERS                                   |   7 +
 accel/kvm/kvm-all.c                           | 360 +++++++++++++++---
 accel/kvm/trace-events                        |   2 +
 accel/stubs/kvm-stub.c                        |  18 +
 hw/core/machine.c                             |  22 ++
 hw/hyperv/trace-events                        |   1 +
 hw/hyperv/vmbus.c                             |  37 ++
 hw/i386/kvm/clock.c                           |  59 +++
 hw/i386/kvm/i8254.c                           |  91 +++--
 hw/i386/kvm/trace-events                      |   1 +
 hw/i386/x86-common.c                          |  71 +++-
 hw/intc/openpic_kvm.c                         | 112 ++++--
 hw/vfio/helpers.c                             |  94 +++++
 include/accel/accel-ops.h                     |   1 +
 include/hw/core/boards.h                      |   6 +
 include/hw/i386/x86.h                         |   1 +
 include/system/confidential-guest-support.h   |  20 +
 include/system/kvm.h                          |  43 +++
 include/system/physmem.h                      |   1 +
 stubs/kvm.c                                   |  22 ++
 stubs/meson.build                             |   1 +
 system/physmem.c                              |  28 ++
 system/runstate.c                             |  43 ++-
 target/i386/kvm/kvm.c                         | 139 +++++--
 target/i386/kvm/tdx.c                         | 141 +++++--
 target/i386/kvm/tdx.h                         |   1 +
 target/i386/kvm/trace-events                  |   4 +
 target/i386/kvm/xen-emu.c                     |  50 ++-
 target/i386/sev.c                             | 127 ++++--
 target/i386/trace-events                      |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vmfd_change_reboot.py         | 135 +++++++
 32 files changed, 1422 insertions(+), 218 deletions(-)
 create mode 100644 stubs/kvm.c
 create mode 100755 tests/functional/x86_64/test_vmfd_change_reboot.py

-- 
2.42.0


