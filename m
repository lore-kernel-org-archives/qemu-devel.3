Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1408E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxQ-00036A-Gr; Wed, 18 Feb 2026 06:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxI-00033j-AX
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxE-0007cQ-Tg
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yAGRjhONPyQSVWhNDTkfT6WwKltvOiCtkYs7DwcPUOI=;
 b=Psw3tMRydZzptM993d+w4w1QdfxGtI9TwToo0tos4krlBYPupD4q1H15kCFbLw/aptJSIV
 5TYfwXyK4/ezBPC70It05vGDpOTuUVHUqvy1YfEtpXk4RCDhGVvIeyJQSgl8fuwMiLWZAx
 7/JPTqjPZvJOnSeinIpl8u5pQrSscz0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-m_qGlUfpN7-PWv5eg5E5eg-1; Wed, 18 Feb 2026 06:42:47 -0500
X-MC-Unique: m_qGlUfpN7-PWv5eg5E5eg-1
X-Mimecast-MFC-AGG-ID: m_qGlUfpN7-PWv5eg5E5eg_1771414967
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aaf0dbd073so66396415ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414967; x=1772019767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yAGRjhONPyQSVWhNDTkfT6WwKltvOiCtkYs7DwcPUOI=;
 b=sJg+phNqWd+TcOQW1lOatSVpc0nWqvfHnfSXuxcHrTyA2K31i/EkytN2ZzJ2zxak7a
 lLS4CEazffx4tehvd5Xcs6VbEHyw9/oZhGj9Cs7V8I3jO0BwOUIgyNwJfLai36EBBIj6
 Xt7rvxG7giW/fbD9KckOrlAbHmue1Ss76wTQ/pg8VNj2vXyfYucbpko/UAypTYAshF1e
 FXj/DzGsZCue0R5oZLNCONfgzNjonQVLvCw/w9wJGEU0+wh4IF4JdV1nsiTy1dlho5/l
 cY1TkJkXshv8fEPzuXfVVhTBrql7F2e1zMrqrkRyKCMKyYM+0xxt03PHOCswqy2fxG2a
 EvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414967; x=1772019767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAGRjhONPyQSVWhNDTkfT6WwKltvOiCtkYs7DwcPUOI=;
 b=Bg+yMthbJK3CCTCiOxAF/ccCaISifDGWmTgqD9qvxJruaHdPtlmqQpye5aKb9aEUt3
 0WLwssEPSQsjbxUA9KQlPnPLDd4C+mTMsvomrAULqDixBP5T8SACR7uSoaHvdm58pXN+
 qn/OYL8/6Fyj7TgDKO9aP2+fXw7v5z7uwNuRnj2VOkmzm2aedYoDJOgMEhfbICU761/M
 H7h85MdQOARua0X4G52vie2mpcRa7RwP3QJYumCCA7PgqZKbX4dvlux2Oiv1rKE9jzrd
 BpmPZ94TqisUBR7erKw/UIL/R1yepY7zXt/fKoM3f/QqIF4JMnHyDjVT+LwZQVo7KQNr
 KKDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ihiggBSTIquYVNHRQCJfcVsRU9ONWFBarqXLpoLE5DzzICkg96R4ivYVHgEhum+7sMHmih6bpKHc@nongnu.org
X-Gm-Message-State: AOJu0YyttVvxKPa9TA1HGODdzgk5nD6udcvu4/zqLrZynL+9MxHRkPl7
 cYnyhbWkHok0XoM+TOtGhlXdtTC+u1qMEtiK/C2BkwHO9jjmaF3zjw6ArObdxGuk0OrxP3YrHDJ
 cQCHr7OVqEh+jQLXtqtzSvazb7bQNjNnXayP0L5s/0c12XhMCkdEBkD3E
X-Gm-Gg: AZuq6aI2IBfWEZrVoKoUdCRPNzL4auY51Xtg/nfi3R7Zthgs6Ut3wu7qMTJOkhetfIS
 pqpFICToMVWi/ijO+5avKmwIGv3mQzRc3nRj9ZJmT/uoCZ2feA1vMeOWo2SuoTC8Cfj4Mk62Rnz
 qn/SkHYFzn5mgnonrUnZVL3/ZNyzXBDNwqnmEth3DB+JrcuFy8ug5W7r4nA6cP9H2DehTiLcnBI
 VGvNuV5avRvdbC38LtHP5f44c/jcbroIBAcpp3hXn3UPkpAkR8XtQvzw+yvSi1vWDtiDLf1IkAr
 ouwHQVh9x/CiHX3AOMYTo2nV90taxpjxPnB6AVJnQKQM8Rw3Ud8A07KOcNG4TMhQUxUJOdIa6/n
 6HOsEtp5N6kMNBwO3+4iJlA7/mmvEo4vyrZQfxt8R/UGP1thPZiJq
X-Received: by 2002:a17:903:fb0:b0:2a9:30d4:2af3 with SMTP id
 d9443c01a7336-2ab5060e720mr146478315ad.49.1771414966763; 
 Wed, 18 Feb 2026 03:42:46 -0800 (PST)
X-Received: by 2002:a17:903:fb0:b0:2a9:30d4:2af3 with SMTP id
 d9443c01a7336-2ab5060e720mr146478175ad.49.1771414966331; 
 Wed, 18 Feb 2026 03:42:46 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:42:46 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, vkuznets@redhat.com, graf@amazon.com
Subject: [PATCH v5 00/34] Introduce support for confidential guest reset (x86)
Date: Wed, 18 Feb 2026 17:11:53 +0530
Message-ID: <20260218114233.266178-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All changes can be browsed here:
https://gitlab.com/anisinha/qemu/-/compare/master...coco-reboot-v5?from_project_id=11167699

Hoping to make v5 the final revision on this work.

CI pipeline passes:
https://gitlab.com/anisinha/qemu/-/pipelines/2329137956

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

v5:
 - suggestions from v4 added.
 - xen code refactoring seperated into a new patch.
 - minor fixes.
 - tags added.
 - rebased.

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

Ani Sinha (34):
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
  i386/kvm: refactor xen init into a new function
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
  qom: add 'confidential-guest-reset' property for x86 confidential vms
  migration: return EEXIST when trying to add the same migration blocker

 MAINTAINERS                                  |   7 +
 accel/kvm/kvm-all.c                          | 360 ++++++++++++++++---
 accel/kvm/trace-events                       |   2 +
 accel/stubs/kvm-stub.c                       |  18 +
 hw/core/machine.c                            |  22 ++
 hw/hyperv/trace-events                       |   1 +
 hw/hyperv/vmbus.c                            |  37 ++
 hw/i386/kvm/clock.c                          |  59 +++
 hw/i386/kvm/i8254.c                          |  91 +++--
 hw/i386/kvm/trace-events                     |   1 +
 hw/i386/x86-common.c                         |  71 +++-
 hw/intc/openpic_kvm.c                        | 112 ++++--
 hw/vfio/helpers.c                            |  92 +++++
 include/accel/accel-ops.h                    |   2 +
 include/hw/core/boards.h                     |   6 +
 include/hw/i386/x86.h                        |   1 +
 include/system/confidential-guest-support.h  |  20 ++
 include/system/kvm.h                         |  43 +++
 include/system/physmem.h                     |   1 +
 migration/migration.c                        |   4 +
 qapi/qom.json                                |  16 +-
 stubs/kvm.c                                  |  22 ++
 stubs/meson.build                            |   1 +
 system/physmem.c                             |  28 ++
 system/runstate.c                            |  44 ++-
 target/i386/kvm/kvm.c                        | 136 +++++--
 target/i386/kvm/tdx.c                        | 141 ++++++--
 target/i386/kvm/tdx.h                        |   1 +
 target/i386/kvm/trace-events                 |   4 +
 target/i386/kvm/xen-emu.c                    |  50 ++-
 target/i386/sev.c                            | 127 +++++--
 target/i386/trace-events                     |   1 +
 tests/functional/x86_64/meson.build          |   1 +
 tests/functional/x86_64/test_rebuild_vmfd.py | 136 +++++++
 34 files changed, 1438 insertions(+), 220 deletions(-)
 create mode 100644 stubs/kvm.c
 create mode 100755 tests/functional/x86_64/test_rebuild_vmfd.py

-- 
2.42.0


