Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938B5CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjQd-0007P8-Il; Tue, 26 May 2026 00:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQb-0007OQ-Kd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQZ-0007IF-5a
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4903974854dso39293575e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769801; x=1780374601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pR4VbMiYp6/ZuZdj902a57UbPmsVcL1enXRYqWopBDc=;
 b=p1eL4DSjReKhVnbY5r3drqUcbxLTH3Ll2asAcz4RNIJC7LESqLS/5/o1xWuMHsI2wn
 4saNUKXIRkEGPKFX41uGDY3aw3UOBp5xfDkFKUkWazyz3lbSapWMWCSyeMOnENd3/uL3
 4e5KI6QmD0BGVK7KKCGWstTNt55zREIImuHa0IhCWjkOdFPgvkVJ6gp0JElNhhd/ulSu
 vOhbbWQLPynzr6Wo7Ya3q9fl67Sjup6JV5vu7QFzFlMLjMri7++vXLnQfJg6Hg9w6ZyK
 zK9A6rYuRxYmXOvQCrGDBlwFVuTR7lBOYqTD0Quta1QUvM6zFz01d27DJh+Ln/CuAaDO
 yUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769801; x=1780374601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pR4VbMiYp6/ZuZdj902a57UbPmsVcL1enXRYqWopBDc=;
 b=AMAuuoiFs5nNm1s7MlWGtb7i4v+y4aei0SqzqQ4tfcdPUOZU3wAro9jW6yx/C2cAIl
 9Hk0uLUpgKeoPk/RvEmPkWiM4bzvDwtvBFKJob8TU06WxphDwo2d/79IyOsvXi47L9T3
 h0zGAhFzNUCBCXYPERuqbOtgjE355ofu5po0FwtuxCfrnNiIPTj7ftjSX2sZXLLMz8tR
 jZwv07w6ia1g+CokYz4cIBzdpvKXSsDlFfKM0xpeGDgNzzvDQvMxo6LhPMqxpY/OZHyc
 Sw4S6CoY62whsCb/D+0Scx4cU33VUn4avNZqCnyhiypBEixGJwJuzimdR5FFMlXglVTe
 qQBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9/yk+9oEN6u7HNDmiRnoUUb9AkmqDdjFTDUJ4KC0oazTYRnGKcb0ico8Tu9S66g4sawpZrb54r+pb@nongnu.org
X-Gm-Message-State: AOJu0YxgFYthJRFec2tHwMmAieyZ3cjrKSSU6b90jHxDHSw3TueFUACC
 jm83G6ycXLlow/BDi41RYNtoE/FMdqwNRQ1Q44pErRM5PlLEtGQjDjXM
X-Gm-Gg: Acq92OEFsEkHC1shUg9IDf06gLdur88jVGnTZz7ItYNp5f/ac9JiujyZScW2nhUaYS/
 6XrhaQf/6Sn0nwNWbYB2CQqrcyN0QIF1rcbDC5KlbO43vAmYEElxcm0bpiFMISytUadUHu9GBtO
 flbkmUBFvUoAMxDkLFNsDHPfDsprR1Hoh6uQp367sl7CRlVkAkBVzJFjOMMqORw95kvm70YoQoX
 7WQB0tn2hGHAIGcnigZiJjGaf+jTlYUK8MD+/ISG2n9vnkynfQi7uCuWP6O+90VmSnx5FqoO5ca
 JawhbNOos97oR914XHE10WMmlDxym/x5xWVcUuRHnAz+YX7VCodBmLnetDH3A2IUAxZenBy6kd1
 Yb1+vZ8vDQWba1AP89vTYA/76KyF6HGaD3RklvmsM5t8EVGHF6j9J4bBCyVHKglunPAgVVfhrgE
 xQ1Bwt7APcf59NYr7kCSM2S6Vv5wxrqjTHz+/n4LAnY2e0ohYVZrBpkI2IwSrXC6kvtP+lonp1V
 zU=
X-Received: by 2002:a05:600c:8599:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-490424acb4cmr220397825e9.8.1779769800695; 
 Mon, 25 May 2026 21:30:00 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:00 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Leonid Bloch <lb.workbox@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/8] Introduce a battery, AC adapter, and lid button
Date: Tue, 26 May 2026 07:29:19 +0300
Message-ID: <20260526042928.9203-1-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series introduces three ACPI devices that are particularly useful
for laptop/mobile virtualization:

* Battery
* AC adapter
* Laptop lid button

Link to v3: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg04138.html
Link to GitHub PR, for ease of review: https://github.com/blochl/qemu/pull/4

Changes in v4:
--------------

* Rebased on latest master

Based on the feedback on v3:

* Documentation patch split: each device is now introduced by a
  separate documentation patch followed by the code patch.

* sysfs/procfs host mirroring removed from the C devices: QEMU no
  longer reads /sys or /proc directly. The devices are now purely
  QMP-controlled. A reference Python script is added in
  scripts/laptop-mirror.py that demonstrates how a management layer
  can translate host sysfs/procfs state into the QMP commands.

* Battery I/O region cleanup: the battery registers are now native
  DWORD-access only, matching the AML AML_DWORD_ACC field layout.

* find_*_device() now reports ambiguity: when more than one matching
  device is present, QMP returns "More than one X device present".

* QAPI cleanups:
  - Stray blank documentation lines in *-set-state removed.
  - All the new types and commands carry "Since: 11.1".
  - The C devices no longer #include "qemu/error-report.h" now that
    they don't call warn_report().
  - battery-set-state now rejects impossible combinations
    (charging && discharging, charge/discharge without present,
    out-of-range charge-percent and rate).

* I/O port unknown-address handling: the default branches in the
  ioport_read paths now g_assert_not_reached() instead of logging and
  returning 0.

* Set the devices not hotpluggable.

* ISA vs. PCI base: kept ISA. ACPI defines PNP0C0A (battery),
  ACPI0003 (AC adapter) and PNP0C0D (lid) as namespace devices under
  \_SB with control methods (_BIF/_BST, _PSR, _LID) - see ACPI 6.5
  sections 10.2, 10.3 and 9.4
  (https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf).
  There is no PCI class code defined for any of these in the first place,
  and no actual laptop puts them on PCI - the signals come out of the
  embedded controller and surface as fixed-hardware ACPI devices.
  Guest power-management code matches the same way: Linux uses
  drivers/acpi/{battery,ac,button}, Windows acpi.sys, macOS and the
  BSDs follow the same pattern. Making the devices PCI would mean
  inventing a device class no guest has a driver for.

Changes in v3:
--------------

* Rebased on latest master
* Addressed the v2 review by Igor Mammedov

Changes in v2:
--------------
Based on the feedback from Philippe Mathieu-Daudé and Michael S. Tsirkin:

* Complete redesign with dual-mode operation:
  - QMP control mode (default): Devices are controlled via QMP commands,
    providing deterministic behavior essential for migration and CI/testing
  - Host mirroring mode (opt-in): Original sysfs/procfs monitoring behavior,
    now disabled by default

* Migrated to modern QEMU ACPI architecture:
  - Devices now implement ACPI_DEV_AML_IF interface
  - AML generation moved from centralized acpi-build.c to device files

* Added a QMP interface:
  - battery-set-state/query-battery
  - ac-adapter-set-state/query-ac-adapter
  - lid-button-set-state/query-lid-button

* Documentation improvements:
  - Converted to .rst format
  - Added examples for both QMP and "fake" sysfs/procfs testing

The dual-mode design ensures these devices are migration-safe and
deterministic by default, while still allowing host state mirroring
when explicitly requested for desktop use cases.

Use cases:
----------
1. Testing: CI systems can programmatically control power states.
2. Cloud: Expose a virtual battery for usage-based resource limiting.
3. Desktop virtualization: Mirror host laptop state to the guest via
   the laptop-mirror.py reference script (or a libvirt equivalent).
4. Development: Test power management without physical hardware.

Example usage:
--------------
# QMP-controlled battery
qemu-system-x86_64 -device battery \
    -qmp unix:/tmp/qmp.sock,server=on,wait=off

# Control via QMP
{"execute": "battery-set-state",
 "arguments": {"state": {"present": true, "charging": false,
                         "discharging": true, "charge-percent": 42,
                         "rate": 500}}}

# Or, to mirror host laptop state through QMP:
$builddir/run scripts/laptop-mirror.py -s /tmp/qmp.sock

The series has been tested with Windows and Linux guests, correctly
showing battery status, AC adapter state, and lid button events in
guest UIs and triggering appropriate power management actions.

Thanks again for the reviews.
Leonid.

Leonid Bloch (8):
  hw/acpi: Support extended GPE handling for additional ACPI devices
  docs/specs: Introduce the QEMU Battery documentation
  hw/acpi: Introduce the QEMU Battery
  docs/specs: Introduce the QEMU AC adapter documentation
  hw/acpi: Introduce the QEMU AC adapter
  docs/specs: Introduce the QEMU lid button documentation
  hw/acpi: Introduce the QEMU lid button
  scripts: Add laptop-mirror reference script

 MAINTAINERS                          |  27 ++
 docs/specs/acad.rst                  | 126 ++++++++++
 docs/specs/battery.rst               | 154 ++++++++++++
 docs/specs/button.rst                | 131 ++++++++++
 docs/specs/index.rst                 |   3 +
 docs/tools/index.rst                 |   1 +
 docs/tools/laptop-mirror.rst         |  82 ++++++
 hw/acpi/Kconfig                      |  12 +
 hw/acpi/acad-stub.c                  |  20 ++
 hw/acpi/acad.c                       | 251 ++++++++++++++++++
 hw/acpi/battery-stub.c               |  20 ++
 hw/acpi/battery.c                    | 364 +++++++++++++++++++++++++++
 hw/acpi/button-stub.c                |  20 ++
 hw/acpi/button.c                     | 227 +++++++++++++++++
 hw/acpi/core.c                       |  17 +-
 hw/acpi/meson.build                  |   6 +
 hw/acpi/trace-events                 |  12 +
 hw/i386/Kconfig                      |   3 +
 include/hw/acpi/acad.h               |  25 ++
 include/hw/acpi/acpi_dev_interface.h |   3 +
 include/hw/acpi/battery.h            |  32 +++
 include/hw/acpi/button.h             |  23 ++
 qapi/acpi.json                       | 165 ++++++++++++
 scripts/laptop-mirror.py             | 219 ++++++++++++++++
 24 files changed, 1941 insertions(+), 2 deletions(-)
 create mode 100644 docs/specs/acad.rst
 create mode 100644 docs/specs/battery.rst
 create mode 100644 docs/specs/button.rst
 create mode 100644 docs/tools/laptop-mirror.rst
 create mode 100644 hw/acpi/acad-stub.c
 create mode 100644 hw/acpi/acad.c
 create mode 100644 hw/acpi/battery-stub.c
 create mode 100644 hw/acpi/battery.c
 create mode 100644 hw/acpi/button-stub.c
 create mode 100644 hw/acpi/button.c
 create mode 100644 include/hw/acpi/acad.h
 create mode 100644 include/hw/acpi/battery.h
 create mode 100644 include/hw/acpi/button.h
 create mode 100755 scripts/laptop-mirror.py

-- 
2.54.0


