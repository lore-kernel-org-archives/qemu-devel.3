Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F271C5AC81
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD60-0001HS-6l; Fri, 07 Aug 2026 01:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD5y-0001HB-EV
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD5v-0000j1-9h
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786080369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ANGEOZl5gv5hQtKbPXweFt8ekileN6DDVjtcq6Dy8u4=;
 b=iAL+7AI0pWERfuoIjmEDf+WyJJkUluFGBK+PM1XK9pgRYZq/Rb+L0ETBbgeDkHmHis+GOg
 zNRqtMOKVl2uSDvX2zouzZc8/BndffDa0DjiwJIxKTzmbVdauG6qxCQBme6CYdGB48Km8r
 tmH6dkJI7fqooeDkP72Za/JVKTTuK/U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-w8Lk5dmbObiu1gZ2V7a4cA-1; Fri, 07 Aug 2026 01:26:08 -0400
X-MC-Unique: w8Lk5dmbObiu1gZ2V7a4cA-1
X-Mimecast-MFC-AGG-ID: w8Lk5dmbObiu1gZ2V7a4cA_1786080367
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so4730690a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786080367; x=1786685167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ANGEOZl5gv5hQtKbPXweFt8ekileN6DDVjtcq6Dy8u4=;
 b=fkXM+soqWONLgi6X9SyKJy+kso4QmyaQa+NRn5kSrOZFkG4FYavsEKZTopEer/C/SY
 bb7HhAGJrvvEStR4mkfJFTAp5FbP/7xomjyD8HpPR8g2yROz2OmeJXYwwNx4Xbp3ojbD
 7ZvIIjnESrsN3Ubr6kXUo1OQm9srQQNDsBFBDa8TxWHEa3JDXhwHYpHxCbuMlyUOe99+
 O4euzYk57Uaxub261UY8l6YsmvY1mu4mwMol0eN5kODKAJiCUM77jQk6w495LMJWU93l
 QUoxlYzWArCFf46JpIEsPlVaQgtmH3joWHzagIbdsLXU4RRuKAKCk6DHri2cnnJowo2+
 nKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080367; x=1786685167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ANGEOZl5gv5hQtKbPXweFt8ekileN6DDVjtcq6Dy8u4=;
 b=m7tp0YCKh3re7Wv2FSivsEP2vjPpdfqtT5AK61mJi6s8b6oTMShzwc2/5RpgD9XKl1
 u6M43gpyGGSdfEMHPpt4aHp3jonBAkRbWimCNj7dCnYl9aPERGtRyprpHwiFU8ahgrmy
 pQ5yx4JidgAc7guxMniVDy6SQ9qyLS2i6ku/jEcxvAjKUJ5zv6utDnxspjL3rMo3BpkZ
 XnNK7rj/cKFCYl0S+zZ0TF/LHnFZyOShq4zqdyN6ZbqUlOi9xRgbyY57ze9uCWQSJ6aJ
 1GQyeWVdYxz3vBTTn5kHxZ9wXw004SgOwNdPzT4CZJLmrPQQ70pL8k1DGReBlH2OqtYW
 lxYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rptt85wEZSe+4OHprqi/U1J13TfK33dr25OHWvOiMg8msci6KSEnnoyQMuSpjj15wPsQLSS6u11xHha@nongnu.org
X-Gm-Message-State: AOJu0Yz6DUdbDtcylV94H2cuCP2f+edqS8CWuyaBuBEuOGRpQwrt4Yt3
 mDQi6qbGu7ylj6OgWJfB1LusuLT6n1AmWmqaZiF9nSYi+RYM4iDvET+rrNqKk0SbVCn2Xl+0FxL
 oI1jyTgcQALqwcrS0yYyeNLAA8ZCtuxxWttewxPx0A0ZgRupz2mOJPzzP
X-Gm-Gg: AR+sD12Y9EcHZyh2AMkBn82jTu29QkPq2FqkGdFyzZ2SMMhaU93ugE+VJEjpCXmnhSQ
 wnSiAXNgJwt+Rfaun+cvxq/+jhkUCQeMgYq0D3s+I6XlNHzt7E6qntzZgS1LoRdz7uiGyzptOSG
 Kaeh7n/pGbyFCw3GIsV98q71uIZlOnJwYFwLunLJyLAoXnLjQ5Z5YytZ+3Qc/drcfy5qK05Aeja
 dZd4xotvHICEn30Vrzd7mSUv9RPPhn3wBRWqYMxi3fqgrKxu8vC4vbg7tPXPzX+C4275KrWf8Gh
 NcAmLmoG7/gxA7CjW9nV6IFe41AOrWV9guVvjsyT0TSH+wTMLZHtHsEtyiQJKEKx87t5bNyPm+V
 iXUOhwlxIjy9khtcFjNC8YhZlPfX7RQpkmQ==
X-Received: by 2002:a17:90b:28c3:b0:38e:2e16:859b with SMTP id
 98e67ed59e1d1-3903c68096emr22165964a91.20.1786080367043; 
 Thu, 06 Aug 2026 22:26:07 -0700 (PDT)
X-Received: by 2002:a17:90b:28c3:b0:38e:2e16:859b with SMTP id
 98e67ed59e1d1-3903c68096emr22165912a91.20.1786080366473; 
 Thu, 06 Aug 2026 22:26:06 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3908616d21esm3316334a91.17.2026.08.06.22.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:26:06 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, agraf@csgraf.de, graf@amazon.com,
 qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v4 00/11] Introducing guest driven VM launch update mechanism
 (BYOF interface)
Date: Fri,  7 Aug 2026 10:55:42 +0530
Message-ID: <20260807052559.50643-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patchset has added functional and unit tests that exercize the hypervisor interface. It has been
tested for both confidential guests and non-confidential guests. For  CoCo case, here is the run:

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
 docs/specs/vmlaunchupdate.rst                 | 197 +++++++++
 hw/misc/meson.build                           |   3 +
 hw/misc/trace-events                          |   6 +
 hw/misc/vmlaunchupdate.c                      | 333 ++++++++++++++
 include/hw/misc/vmlaunchupdate.h              |  38 ++
 .../standard-headers/misc/vmlaunchupdate.h    | 102 +++++
 include/system/igvm-internal.h                |   8 +-
 include/system/igvm.h                         |   1 +
 system/memory.c                               |   1 +
 system/trace-events                           |   1 +
 tests/data/igvm/README                        |  40 ++
 tests/data/igvm/hello.igvm                    | Bin 0 -> 137112 bytes
 tests/data/igvm/qemuinit.igvm                 | Bin 0 -> 137112 bytes
 tests/functional/aarch64/meson.build          |   1 +
 .../aarch64/test_vm_launch_update_aarch.py    |  33 ++
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vm_launch_update.py           |  48 ++
 tests/qtest/launchupdate-test.c               | 418 ++++++++++++++++++
 tests/qtest/meson.build                       |   2 +
 24 files changed, 1315 insertions(+), 33 deletions(-)
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


