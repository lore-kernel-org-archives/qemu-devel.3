Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D77F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5uq-0007GI-63; Tue, 24 Feb 2026 22:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5uo-0007G2-LP
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5um-00085M-J4
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0bup3et5szNawG8f9MFIPIOeXNsIsTxBifUhBwpWtT0=;
 b=fTc35GysavsFJ86w+1IB7Dl1Jvd68Wgzc4MIFTOsiynpfDcn6D++VXeeztY7N0xVBgDfom
 4i9y2RM1Vx8j0dkUd9sMxe6Myn4ZAJshY7Iq6wEM/AO5SDwCDXrRmLWdydEEeHaVOydg5y
 CJ2HZew6mKDZLNklJMs9/ULs29Zc6VY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-clgaUZyoM4OxUlcPq1HOAQ-1; Tue, 24 Feb 2026 22:50:11 -0500
X-MC-Unique: clgaUZyoM4OxUlcPq1HOAQ-1
X-Mimecast-MFC-AGG-ID: clgaUZyoM4OxUlcPq1HOAQ_1771991410
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-354c0234c1fso5707660a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991410; x=1772596210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0bup3et5szNawG8f9MFIPIOeXNsIsTxBifUhBwpWtT0=;
 b=WQFC7vaAhI1ImAXZaAMdH831mi4iNr9oa6XaGc1oBykADk6d1HQ4z0bbErQ8xYBa/g
 uNbhr3WWzLz+Of1Vdj+ycEECZVqFFH5/6i+5A5d8KaCBSxddeha3smSztth+ZYgAHwTJ
 B0Bi4LkC9smVslYy47f+VydSJ1lw71HHh0+embhR8jHw0vm3Lx+VSqyViPv2Ardx3t+B
 7SgMxjltccSKOPVibxUT+tbD9jpBSoIWbNJsVmDgNcXuh9f7t9mdxNsCxRWc3zc3/aAW
 zrGNNRB443XpONUpeMJ0oQuD6VrhQpDWmCG1z/NRu7RufeB6aXtP2iXHcGob5QGhIxXN
 xKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991410; x=1772596210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bup3et5szNawG8f9MFIPIOeXNsIsTxBifUhBwpWtT0=;
 b=u6S93tQkuUnX+WkouKw7aIxTcPCFmTvmj15ml7UkscWnXEabreMZA+CTBT3vMNvk1r
 njNQXTd96pba/CzD4zFlArl5z/WUPbKzc2h824LA+HLmV8pmUuy90KLduytFpnXTrIFA
 vs3yuTU1PrN+dZCm3iJPrYxkbjZgmtnpk4Izj6Fx2viD0lMFSty2yi0QZXK1U949Nd1L
 aRq1MppoKf4/XlcVZ9M5oIhE7c5xiIbv5/94J24EV4Qmmn61fwrGBMJlEEGxkIwuQImU
 cANy1Tc8Xc+gIsiA8/+IUF7lVARQeNTv9I+CXbDspD4Nk1qYCdsRHpkLB/KLpkgoFnz2
 o2lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0vrgGDo3PGnvjvJn0g2pc5B+dsvPWTSUF4ENwin0JmycccIjSbxLJbpGBlyuOXsa7JohkwXHzzHLR@nongnu.org
X-Gm-Message-State: AOJu0YwUelUVvYIkspgjnnWVMca+8Sky+ZmvLsFK7Wy9wAr1Y9zJ80dK
 bSrTQi8Bsy8KnPPSw0Tpcf0wwBkQwuF05b5Wxs0KIVfgYvrRRMSoac8nZdfEL6fIB31y/YYWakS
 ESVUdsjlOBMIx1+89Uv/24D11J2mXCfxn+Hbd1mqxbCgtS7swJNwgt+NW
X-Gm-Gg: ATEYQzx5H4fWBEp2P0NIQagFv3qqb7QKbTk08RVZfJIiYikQdLKBWlsAhE4FYVR6aQv
 xRfn9gS9j6xDwYgFvAyUTlX9X/OIhWb/pPcr1vMkXDNcKs0xMjKDoFFnmHM/a+aazScMuCjpX36
 t/ZSiz5vfr/ikdymzDQq4aVMvRFq/LE02WKyPbC6hcT3HL6PorkTlEUsMd32TYktzoXcM8XO4i1
 8F7WYb44dnt5ntd74Ab5orzXfD3teRZrdxaPZ/dMx0w3ybjSck2blBeZmdmAqtBldF0vN1/K9t2
 AGow/T2fiUf8OrRUU/pGsreji4MroXUZ7gqdbLEMKG6b643MCMGhfjwJnvsOfZQdOWwceinLZLV
 HJhesnWeytSBM0SkXP9CNur7LJv7F2cFX+humh3iWcdAwB55yZVPJtFM=
X-Received: by 2002:a17:90a:e617:b0:358:d80e:383a with SMTP id
 98e67ed59e1d1-3590f045d7fmr736159a91.2.1771991409102; 
 Tue, 24 Feb 2026 19:50:09 -0800 (PST)
X-Received: by 2002:a17:90a:e617:b0:358:d80e:383a with SMTP id
 98e67ed59e1d1-3590f045d7fmr736138a91.2.1771991408683; 
 Tue, 24 Feb 2026 19:50:08 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:08 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, pbonzini@redhat.com,
 ani@anisinha.ca, qemu-devel@nongnu.org, vkuznets@redhat.com,
 graf@amazon.com
Subject: [PATCH v6 00/35] Introduce support for confidential guest reset (x86)
Date: Wed, 25 Feb 2026 09:19:05 +0530
Message-ID: <20260225035000.385950-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Tested by triggering reset through guest console as well as QMP "system_reset" command.
All tests use multi vcpu (SMP) guests.

Tested on TDX hardware running with RHEL-9.6 on the host.
Used Fedora 43 guest (cloud image) + basic UKI kernel boot (fc43 kernel).

Tested on SEV-SNP on two diferent hosts  - one running RHEL 9.8, other Fedora 43.
Used Fedora 43 guest (cloud image) + basic UKI kernel boot (fc43 kernel).

Tested SEV-ES on a SEV-SNP host running Fedora 42 on the host.
Basic UKI kernel boot only (fc39 and fc43 kernels).
It is to be noted that Fedora 43 and RHEL hosts seems to no longer support SEV-ES and
bails out with the following error:

qemu-system-x86_64: -accel kvm: sev_launch_start: LAUNCH_START ret=1 fw_error=21 'Feature not supported'
qemu-system-x86_64: -accel kvm: sev_common_kvm_init: failed to create encryption context
qemu-system-x86_64: -accel kvm: failed to initialize kvm: Operation not permitted

For non-coco ran the added functional tests on a fc43 host:

$ ./build/run tests/functional/x86_64/test_vmfd_change_reboot.py 
TAP version 13
ok 1 test_vmfd_change_reboot.KVMGuest.test_reset_console
ok 2 test_vmfd_change_reboot.KVMGuest.test_reset_hyperv_vmbus
ok 3 test_vmfd_change_reboot.KVMGuest.test_reset_kvmpit
ok 4 test_vmfd_change_reboot.KVMGuest.test_reset_qmp
ok 5 test_vmfd_change_reboot.KVMGuest.test_reset_xen_emulation
1..5

For regression, ran QEMU CI pipeline and it passes:
https://gitlab.com/anisinha/qemu/-/pipelines/2346276955

CC: qemu-devel@nongnu.org
CC: pbonzini@redhat.com
CC: kraxel@redhat.com
CC: vkuznets@redhat.com
CC: graf@amazon.com

Changelog:

v6:
 - fixed regression issue reported by Cleber on v4/v5.
 - reworked patch #28 as per review comments from v5.
 - tags added.
 - rebased.

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


Ani Sinha (35):
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
 accel/kvm/kvm-all.c                          | 371 ++++++++++++++++---
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
 include/system/confidential-guest-support.h  |  20 +
 include/system/kvm.h                         |  43 +++
 include/system/physmem.h                     |   1 +
 migration/migration.c                        |   4 +
 qapi/qom.json                                |  16 +-
 stubs/kvm.c                                  |  22 ++
 stubs/meson.build                            |   1 +
 system/physmem.c                             |  28 ++
 system/runstate.c                            |  44 ++-
 target/i386/kvm/kvm.c                        | 136 +++++--
 target/i386/kvm/tdx.c                        | 141 +++++--
 target/i386/kvm/tdx.h                        |   1 +
 target/i386/kvm/trace-events                 |   4 +
 target/i386/kvm/xen-emu.c                    |  38 +-
 target/i386/sev.c                            | 127 +++++--
 target/i386/trace-events                     |   1 +
 tests/functional/x86_64/meson.build          |   1 +
 tests/functional/x86_64/test_rebuild_vmfd.py | 136 +++++++
 34 files changed, 1438 insertions(+), 219 deletions(-)
 create mode 100644 stubs/kvm.c
 create mode 100755 tests/functional/x86_64/test_rebuild_vmfd.py

-- 
2.42.0


