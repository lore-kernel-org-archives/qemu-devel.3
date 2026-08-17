Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F901C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyCf-0008Vy-CC; Mon, 17 Aug 2026 10:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCc-0008VK-2B
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCX-0002aD-7B
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ljsse5ue/0IQNEt9TI2ys6ftJU9Ud5jTmH+LZUEr4A8=;
 b=IhFo7/R6ZFARbP+Sj2UIif3+f5OGm/TR2AUAdghofg4VcxP4CshTKxDHv/cFseNWDjyred
 e59ckCDWIVbLWItfABrPEhOdttQpd47OlctoqFccM4aB8/wjRwCcZewILs+OGdrmRBc7Es
 Lqv/kAdLyU9KS6h+vZW8BDuHBdTByKQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640--lwHXHTPOqGFSJZiQDjlaQ-1; Mon, 17 Aug 2026 10:20:30 -0400
X-MC-Unique: -lwHXHTPOqGFSJZiQDjlaQ-1
X-Mimecast-MFC-AGG-ID: -lwHXHTPOqGFSJZiQDjlaQ_1786976430
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d54187d8b0so66087745ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976430; x=1787581230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ljsse5ue/0IQNEt9TI2ys6ftJU9Ud5jTmH+LZUEr4A8=;
 b=KsbfsEULvB5Fri5gnawCP3UF1gdSzyWU9Q7EbLXc5o94iesx8O0rk52Vqcs6PcVomG
 8K3oDB4vYjebgI6dDSlXEHr7aqTtQYDme5iuUuEQnHWOmDCpFhu+NyV3G5EL/f5/KGfD
 2gtHmnzr4DIYP5rc7nhuxsQyeS1ctPujNlQVnv05yqrgiR0R7nRzqavd5R6j/Dr5sS9a
 baVuTXZwfz61jMtvRs7C/frj2HdpkPrhX8IJi25Catur/07CyEfrUfl+SaQvyxpikPdj
 b2Pe2FB5KddxgQ6UmjjVnCHy3lH1CSyZYrlxcNEXp6MXyOWNEhiU27foEhzu34YJRxWE
 3U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976430; x=1787581230;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ljsse5ue/0IQNEt9TI2ys6ftJU9Ud5jTmH+LZUEr4A8=;
 b=Qm9l3jwd9DOlSD+kndfMcIDTeGuPvfNSN3XJ7o7sk5mia3vCf4EI1rBUgq2AGaFBFX
 EW9aQbxK2b7ys74B0cNlldwhFMQpWRgE9gNVBmrctCy0nM2jWPzbnnEu2nNGUY2aTq5w
 Dss/ikX3iNIq8vT4GAtd5qjrKniZPX0iACOP7U+jsasL/EpjYoCyOcm9qKtOJA8RElnw
 x9Yptvq+rtjfYHhorhMGT34ZRO1p7QWM+6MD4SKswVsXp9xzGryHKd4mUye1LavcSScP
 GcZZrcea/g11tqTevOp8BRo1qbi5zkDKHsAiQBPRHjR0dy2QIJktGbrUp9/bBQ8CUCen
 GLNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrqTSTlfxCCF18AzYUw4zQpqS9rztP9R+knQzzuatHlPykngDxQVTdPG0ZVwvTS1aF2Nq+So0R/1iO@nongnu.org
X-Gm-Message-State: AOJu0YyiMmQUMneZ6jWBgH9hyLtgnHAh1OCXNUHojcthM+sZg9DMuqqQ
 PCHoliRxeQBYR4CUzKskQfIGsDNhIasqHXUSAXHOkAvMFPSljXwyLNVIJGYZ9UWFMoO8q4d0ISx
 aga72qlcAtZ6qLePKdFdSE86Phkj97FchF7KTXla8CXbNfLFnKqqWSTD5Q6tm7r+0raA=
X-Gm-Gg: AR+sD13qapr0QsPIP2RWFP+3fqxFDbCuu+60PePY1SujX2lZVabe8dBqrjsc0YOOB6m
 QaFL2UtySPmTAM3REH7KQUtXPIjB8Go7+2wO89gK/hs2svrjyT7OL0+lSHx/DsE1mzu1ZT1JXmq
 l2Ub4PQDpPBPc8DKUKgVEP0Hb5B1x1BBll3clq7Ww1hI9EOSBDTgF5e9Xz4+fEpo2V02H1qHcPK
 kHi9BDEAk0nXfzEqXs5y+j7g9nJq+GufJD/4WhWEktflNx/8jul0aAT8iLJsuwNB7NIAFBGqsAU
 L5qBGwuyp+ah1LwMnvFivgKT8j7UjGsSbPyJA4KTIpAnvv/aMOmWaJEvVu5tdq2rpLv8OIXd80m
 sZTzYTqqeDlx9jPwkCW4Q164vUDYDfnNAPw==
X-Received: by 2002:a17:903:3905:b0:2cc:aa36:c046 with SMTP id
 d9443c01a7336-2d3b0c5dad4mr296297715ad.14.1786976429667; 
 Mon, 17 Aug 2026 07:20:29 -0700 (PDT)
X-Received: by 2002:a17:903:3905:b0:2cc:aa36:c046 with SMTP id
 d9443c01a7336-2d3b0c5dad4mr296296925ad.14.1786976428977; 
 Mon, 17 Aug 2026 07:20:28 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:20:28 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, ani@anisinha.ca, agraf@csgraf.de,
 graf@amazon.com, qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v6 00/11] Introducing guest driven VM launch update mechanism
 (BYOF interface)
Date: Mon, 17 Aug 2026 19:49:55 +0530
Message-ID: <20260817142010.80693-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is the resurrection of the work that was previously discussed here:
https://lists.endsoftwarepatents.org/archive/html/qemu-devel/2025-03/msg05872.html

This relates to the 'bring your own firmware' work that we are driving at Red Hat,
now with IGVM support.

The patchset includes a spec doc that has more details.

This patchset implements the hypervisor interface using fw-cfg. Using this interface, the guest
can pass its own IGVM file to the hypervisor. Upon reset, the hypervisor re-initializes the guest
using the IGVM file the guest provided.  This is useful in order to have deterministic and trustworthy
launch measurements, mostly for the cloud confidential guest deployments.

The patchset is also available in this branch https://gitlab.com/anisinha/qemu/-/commits/hyperface-phoenix-v6

This patchset has added functional and unit tests that exercize the hypervisor interface. It has been
tested for both confidential guests and non-confidential guests.

Here is the functional test runs for aarch64 and x86_64

$ export QEMU_TEST_QEMU_BINARY=qemu-system-aarch64
$ ./build/run tests/functional/aarch64/test_vm_launch_update_aarch.py 
TAP version 13
ok 1 test_vm_launch_update_aarch.VmLaunchUpdateDeviceCheck.test_vm_launch_update
1..1

$  export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
$ ./build/run tests/functional/x86_64/test_vm_launch_update.py 
TAP version 13
ok 1 test_vm_launch_update.VmLaunchUpdateDeviceCheck.test_vm_launch_update
1..1


For  CoCo case, here is the run for the qtest unit test:

$ COCO=1 LAUNCHUPDATE_TRACE=1 LAUNCHUPDATE_DEBUG=1 QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/launchupdate-test
TAP version 14
# random seed: R02S390d06a8e540c421f90f272aee203aa3
1..5
# Start of vm-launch-update tests
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-958552.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-958552.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -machine none  -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-958552.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-958552.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -device vm-launch-update  -accel qtest
ok 1 /vm-launch-update/cap
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-958552.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-958552.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -device vm-launch-update  -accel qtest
ok 2 /vm-launch-update/disabled
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-958552.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-958552.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -device vm-launch-update  -accel qtest
qemu-system-x86_64: info: guest was not initially started with IGVM, not changing launch state.
ok 3 /vm-launch-update/errorcheck
serial console file is /tmp/launchupdate-qtest-serial-sBHG7T3
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-958552.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-958552.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -machine q35,igvm-cfg=igvm0,confidential-guest-support=lsec0 -m 1G -accel kvm -device vm-launch-update --trace memory_region_finalize --trace qigvm_cleanup_memory -D /tmp/qemu-debug.log  -chardev file,id=serial0,path=/tmp/launchupdate-qtest-serial-sBHG7T3 -serial chardev:serial0 -object igvm-cfg,id=igvm0,file=tests/data/igvm/snptest-nohello.igvm -object '{"qom-type":"sev-snp-guest","id":"lsec0","cbitpos":51,"reduced-phys-bits":1,"policy":196608}'  -accel qtest
target endianness: little
initially booted with host igvm
guest paddr: 100000  igvm size: 195048
writing igvm file into the guest memory
tell hypervisor where igvm is loaded in guest memory
qemu-system-x86_64: info: vmlaunchupdate: new IGVM context set.
resetting the virtual machine now
qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
hello world found on console
resetting again in order to restore host provided IGVM
qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
qemu-system-x86_64: info: restoring original host IGVM: tests/data/igvm/snptest-nohello.igvm
qemu-system-x86_64: info: vmlaunchupdate: host IGVM context set.
booted with host igvm again
ok 4 /vm-launch-update/load_igvm
# slow test /vm-launch-update/load_igvm executed in 5.01 secs
serial console file is /tmp/launchupdate-qtest-serial-s8YOOU3
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-958552.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-958552.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -machine q35,igvm-cfg=igvm0,confidential-guest-support=lsec0 -m 1G -accel kvm -device vm-launch-update -chardev file,id=serial0,path=/tmp/launchupdate-qtest-serial-s8YOOU3 -serial chardev:serial0 -object igvm-cfg,id=igvm0,file=tests/data/igvm/snptest-nohello.igvm -object '{"qom-type":"sev-snp-guest","id":"lsec0","cbitpos":51,"reduced-phys-bits":1,"policy":196608}'  -accel qtest
initially booted with host igvm
guest paddr: 100000  igvm size: 195048
writing igvm file into the guest memory
tell hypervisor where igvm is loaded in guest memory
qemu-system-x86_64: info: vmlaunchupdate: new IGVM context set.
resetting the virtual machine. This should load user provided igvm.
qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
qemu-system-x86_64: info: vmlaunchupdate: next reset will use host igvm
hello world found on console
Now resetting again in order to reset to host igvm
qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
qemu-system-x86_64: info: restoring original host IGVM: tests/data/igvm/snptest-nohello.igvm
qemu-system-x86_64: info: vmlaunchupdate: host IGVM context set.
booted with host igvm
ok 5 /vm-launch-update/ctrl_set_once
# slow test /vm-launch-update/ctrl_set_once executed in 4.77 secs
# End of vm-launch-update tests


Changelog:
v6:
 - vmlaunchupdate-test should only run for x86_64 and not for i386 as the device
   is not supported on i386.
 - squashed https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg02839.html into
   existing patchset.
 - small refactoring of the vmlaunchupdate-test code to put checks for skipping the test
   earlier.
 - CI Passed https://gitlab.com/anisinha/qemu/-/pipelines/2766101668
v5:
 - add functional tests only if igvm libraries are present as without it, the support for
   the device is absent in QEMU.
 - add some more checks for the unit test for the required dependencies (device, kvm, q35 etc).
 - minor spec doc update.
 - rebased,
 - tags added.
 - QEMU CI passed https://gitlab.com/anisinha/qemu/-/pipelines/2756839922
v4:
 - Alex's suggestions addressed.
 - Fixed memory region memory leak issue pointed by Alex.
 - Updated test/data/igvm/README to mention how to download IGVM bundles for CoCo case.
 - Updated qtest to add some tracepoints.
 - Added a couple of new patches that add new tracepoints for tracing mr decalocation.
 - Tested on CoCo and non-CoCo. 
 - Rebased and tags added.
v3:
 - Gerd's suggestions incorporated.
 - Rebased.
 - tags added.
v2:
 - API definitions moved to a separate userland header file.
 - A new ctrl flag is added that will restore original host provided IGVM. Tests for the same are added as well.
 - doc updates that describe how the interface works with the new ctrl flag set.
 - A memory corruption issue is fixed.
 - total size of test IGVM files reduced to 270 KB.
 - other review comments addressed.
 - tags added.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>
CC: qemu-devel@nongnu.org


Ani Sinha (8):
  system/memory: add a tracepoint for memory_region_finalize
  backends/igvm: add a tracepoint for qigvm_cleanup_memory
  hw/misc/vmlaunchupdate: add api header
  hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg interface support
  docs/spec: Add a specification document for vm-launch-update device
  tests/qtest: Add small igvm files for testing purpose
  Add functional and unit tests for the vm-launch-update device
  Update MAINTAINERS

Gerd Hoffmann (3):
  igvm: store IgvmCfg pointer in QIgvm
  igvm: track memory regions
  igvm: cleanup memory regions

 MAINTAINERS                                   |  13 +
 backends/igvm-cfg.c                           |   3 +
 backends/igvm.c                               |  97 ++-
 backends/trace-events                         |   1 +
 docs/specs/index.rst                          |   1 +
 docs/specs/vmlaunchupdate.rst                 | 199 ++++++
 hw/misc/meson.build                           |   3 +
 hw/misc/trace-events                          |   6 +
 hw/misc/vmlaunchupdate.c                      | 333 ++++++++++
 include/hw/misc/vmlaunchupdate.h              |  38 ++
 .../standard-headers/misc/vmlaunchupdate.h    | 102 +++
 include/system/igvm-internal.h                |   8 +-
 include/system/igvm.h                         |   1 +
 system/memory.c                               |   1 +
 system/trace-events                           |   1 +
 tests/data/igvm/README                        |  45 ++
 tests/data/igvm/hello.igvm                    | Bin 0 -> 137112 bytes
 tests/data/igvm/qemuinit.igvm                 | Bin 0 -> 137112 bytes
 tests/functional/aarch64/meson.build          |   4 +
 .../aarch64/test_vm_launch_update_aarch.py    |  33 +
 tests/functional/x86_64/meson.build           |   4 +
 .../x86_64/test_vm_launch_update.py           |  48 ++
 tests/qtest/launchupdate-test.c               | 625 ++++++++++++++++++
 tests/qtest/meson.build                       |   2 +
 24 files changed, 1535 insertions(+), 33 deletions(-)
 create mode 100644 docs/specs/vmlaunchupdate.rst
 create mode 100644 hw/misc/vmlaunchupdate.c
 create mode 100644 include/hw/misc/vmlaunchupdate.h
 create mode 100644 include/standard-headers/misc/vmlaunchupdate.h
 create mode 100644 tests/data/igvm/README
 create mode 100644 tests/data/igvm/hello.igvm
 create mode 100644 tests/data/igvm/qemuinit.igvm
 create mode 100755 tests/functional/aarch64/test_vm_launch_update_aarch.py
 create mode 100755 tests/functional/x86_64/test_vm_launch_update.py
 create mode 100644 tests/qtest/launchupdate-test.c

-- 
2.42.0


