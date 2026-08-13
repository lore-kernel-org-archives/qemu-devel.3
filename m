Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA59C5DF66
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSm2-0005uw-5f; Thu, 13 Aug 2026 06:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSm0-0005ua-Jt
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSlx-000074-B4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CKrTD1lKFUr4yRAWTh4lL9inTMGLu54Q6nkeenHxZks=;
 b=Kef72oLiSltYf0fvOrVkElenfVguNUbyy61yner8iPxwulrXu+L0lCthBprJ3F+LXG8Qcy
 S77ykTAHbiF1PmIm3yUu9HuWKW0hygVuWB++710Rjv4xO8ytLZwJGV+EZfTBhM3VTz/zPL
 XKNHMUuiaU15A9OMXg2Q6zT8medcaOY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Kzax8PAlPyaAzlH_ha88hg-1; Thu, 13 Aug 2026 06:34:47 -0400
X-MC-Unique: Kzax8PAlPyaAzlH_ha88hg-1
X-Mimecast-MFC-AGG-ID: Kzax8PAlPyaAzlH_ha88hg_1786617287
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7b87ce77so4380778a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617287; x=1787222087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CKrTD1lKFUr4yRAWTh4lL9inTMGLu54Q6nkeenHxZks=;
 b=Juvm+GRWH0+AmYOv5rsQ/XI3i4W+PEuxmr5EXNdTTomM659JjmkbMzZFrQPquQdVmD
 8pIiLfOKdZG4YNIHj5dO9AcOHqmZc8XLaKNdKJ7rs0ctHZKxNvyUuZT7zqK3MiEyBTYC
 gp4QrkguTqMRCpKzk6JlwaJDeZKGWXz0WM2ZJFmhvYGLBE8X85JShh9DFF/cmMIU0mHr
 68mhIA6Ch0ljhLi4ahLimEqbsjz1uL11qCVgeNAlDbf5JsZrY8vXBmFhXOKyNsC7LrOc
 12UmW4dsadfPdKUGRCQ3CDPtnTGcPP9bxVhlkBfXgklAig6MVdXkEF6gxvu7HbzDKyFt
 tq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617287; x=1787222087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CKrTD1lKFUr4yRAWTh4lL9inTMGLu54Q6nkeenHxZks=;
 b=AjmlAt4Q9vVKGbfREqE7DApYfrObBg5kyi9Fcg2OCAdrD07PXDZ3j+czWNSPI9fN9O
 ZrPTg583aM55ChbFbwNpJ13i3rKggKjubjjbp0vSxX0t3kw71YUYKB82y8fZuOfNzkUX
 gTXTevnj9H1OVVab0gbkVVdrx+4lCRgmf/Pn8ZBYguer7KEjE+GicJXrL9AdeqQg/OPi
 L6Xt/XuXQOLEINPeWnsEGXxa0f7crXpYRTdzdQeUQ80LaYtUgk3TZCheL1bpr2L0LSkM
 6IgV+YVxhA7ctRI2avwoWQ6//PTGZ9DErDBOV0CkPfQuEz4w/xhSoHlvvgCRBiiZdKVq
 Oe1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7GmKRDYHopsFJUJOmKerym0O4xF7BG8XEGiVQ8YWPjjSc7+0a2lzxmkEbcwRqVET8Tpyh6HDlt2z3@nongnu.org
X-Gm-Message-State: AOJu0YzT4PHKunyyaWmEZIIssXj6axDZRIR3lUgMLfcDeWDQ9LZ53DYc
 3ntFY3xMpDWExNTFe/mIMvna+5HvzFj0zgBMybrMNeAhfMA1bd0h8L5lw8J/EFHW774rdc1OmUd
 ef3lTo1b4v+q56HZW2uBlGeb+v5JmR5jKvcE71zvjpZk4TTwGfV/m4MrQ
X-Gm-Gg: AR+sD11yCNbyODQgQAh5rJrrqDDwbO3uXPcOoIqIAncDgTrc2J5htoLqHlK88oIubR3
 Kaym22rzis47BYja4M0STh0L2oj7yb4sFkwB+CGCKGNhH4U4rpj66/xlFIACbijbtfrjqREMXjk
 rHBVnLIWBUHjIXH4EfLoMxJpFgKegBzfzFGmeTc+b2IVtlgBbTBCLAVj7rtWSSJxpjgUFJE4A5y
 qRzBtzdj3zEcXJH/57lu69jrVkYjYxDfPp1ij+kV9B2kn0+WSBf/TLJCqMMWM/WvCBue6o65zgk
 AqlTP8Pqh6BQToyRoY84ugRJWmphVjK+TZ+VuZRwYPMSHZO2+D4Du4709+XScganKMs9fFwxg+O
 l7mBudVebKAIeac2A6fOGyY26cwOD/V/lAQ==
X-Received: by 2002:a17:90b:3b81:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-3931dfdd5b1mr5435121a91.3.1786617286618; 
 Thu, 13 Aug 2026 03:34:46 -0700 (PDT)
X-Received: by 2002:a17:90b:3b81:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-3931dfdd5b1mr5435082a91.3.1786617286055; 
 Thu, 13 Aug 2026 03:34:46 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:34:45 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, ani@anisinha.ca, agraf@csgraf.de,
 graf@amazon.com, qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v5 00/11] Introducing guest driven VM launch update mechanism
 (BYOF interface)
Date: Thu, 13 Aug 2026 16:04:02 +0530
Message-ID: <20260813103425.24474-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

The patchset is also available in this branch https://gitlab.com/anisinha/qemu/-/commits/hyperface-phoenix-v5

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
# random seed: R02Sabb1bb55ca41d480b2f8963cc61697ee
1..4
# Start of vm-launch-update tests
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2747907.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2747907.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -device vm-launch-update  -accel qtest
ok 1 /vm-launch-update/cap
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2747907.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2747907.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -device vm-launch-update  -accel qtest
ok 2 /vm-launch-update/disabled
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2747907.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2747907.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -device vm-launch-update  -accel qtest
qemu-system-x86_64: info: guest was not initially started with IGVM, not changing launch state.
ok 3 /vm-launch-update/errorcheck
serial console file is /tmp/launchupdate-qtest-serial-sJROYT3
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-2747907.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2747907.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -machine q35,igvm-cfg=igvm0,confidential-guest-support=lsec0 -m 1G -accel kvm -device vm-launch-update --trace memory_region_finalize --trace qigvm_cleanup_memory -D /tmp/qemu-debug.log  -chardev file,id=serial0,path=/tmp/launchupdate-qtest-serial-sJROYT3 -serial chardev:serial0 -object igvm-cfg,id=igvm0,file=tests/data/igvm/snptest-nohello.igvm -object '{"qom-type":"sev-snp-guest","id":"lsec0","cbitpos":51,"reduced-phys-bits":1,"policy":196608}'  -accel qtest
target endianness: little
guest paddr: 100000  igvm size: 199176
writing igvm file into the guest memory
tell hypervisor where igvm is loaded in guest memory
qemu-system-x86_64: info: vmlaunchupdate: new IGVM context set.
resetting the virtual machine now
qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
hello world found on console
resetting again in order to restore host provided IGVM
qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
qemu-system-x86_64: info: restoring original host IGVM: tests/data/igvm/snptest-nohello.igvm
qemu-system-x86_64: info: vmlaunchupdate: host IGVM context set.
qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
ok 4 /vm-launch-update/load_igvm
# slow test /vm-launch-update/load_igvm executed in 7.97 secs
# End of vm-launch-update tests



Changelog:
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
 backends/igvm.c                               |  97 ++--
 backends/trace-events                         |   1 +
 docs/specs/index.rst                          |   1 +
 docs/specs/vmlaunchupdate.rst                 | 199 ++++++++
 hw/misc/meson.build                           |   3 +
 hw/misc/trace-events                          |   6 +
 hw/misc/vmlaunchupdate.c                      | 333 +++++++++++++
 include/hw/misc/vmlaunchupdate.h              |  38 ++
 .../standard-headers/misc/vmlaunchupdate.h    | 102 ++++
 include/system/igvm-internal.h                |   8 +-
 include/system/igvm.h                         |   1 +
 system/memory.c                               |   1 +
 system/trace-events                           |   1 +
 tests/data/igvm/README                        |  45 ++
 tests/data/igvm/hello.igvm                    | Bin 0 -> 137112 bytes
 tests/data/igvm/qemuinit.igvm                 | Bin 0 -> 137112 bytes
 tests/functional/aarch64/meson.build          |   4 +
 .../aarch64/test_vm_launch_update_aarch.py    |  33 ++
 tests/functional/x86_64/meson.build           |   4 +
 .../x86_64/test_vm_launch_update.py           |  48 ++
 tests/qtest/launchupdate-test.c               | 450 ++++++++++++++++++
 tests/qtest/meson.build                       |   2 +
 24 files changed, 1360 insertions(+), 33 deletions(-)
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


