Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F882C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGg0-0004ki-KQ; Tue, 20 May 2025 02:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uHGfu-0004f5-6Q; Tue, 20 May 2025 02:42:06 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uHGfp-0006OL-EQ; Tue, 20 May 2025 02:42:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 36676629EE;
 Tue, 20 May 2025 06:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B977C19422;
 Tue, 20 May 2025 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747723316;
 bh=IFmn3TGKExVDd1wxxEYMsXWoX1TFSrOKOnMBoZJDqUY=;
 h=From:To:Cc:Subject:Date:From;
 b=oM+oGXMEIx1SdctT9QSXQZzxXe05Oo7Kb33qE5yezRJhOAlJQxwLvp9INowxBIduS
 l4NSnLwTND93jjV7KJKbKeZgXKoGusIQ6dOZRnedHkSTqI6JE0VxJr+angQ76ZE7Je
 BsoBBRus9SguCurHjN/2xlpW3zou7HZZZKxAGbmDTuevbpADjLT3RUiZRzQz9Dd2Ax
 qFvfkrLEekoUedWRss1xv72P3FcJjwEJy00UDhGR22h8uCW6IdKlL4OfEZo3IOFEkD
 djSWZnpmawaxNB5pc6/sf/H90JeKosAXXJ5a3qnfydSfQmSzeP4f1p1rICPH9z123O
 13u+Wn8s/mBvQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1uHGfh-00000005qsz-2i2C; Tue, 20 May 2025 08:41:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org
Subject: [PATCH v9 00/20] Change ghes to use HEST-based offsets and add
 support for error inject
Date: Tue, 20 May 2025 08:41:19 +0200
Message-ID: <cover.1747722973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael,

This is v9 of the patch series, rebased to apply after release
10.0. It addresses 3 issues:

- backward compatibility logic moved to version 10.0;
- fixed a compilation issue with target/arm/kvm.c (probably
  caused by some rebase - funny enough, incremental 
  compilation was fine here);
- added two missing SPDX comments.

As ghes_record_cper_errors() was written since the beginning
to be public and used by ghes-cper.c. It ended being meged
earlier because the error-injection series become too big,
so it was decided last year to split in two to make easier for
reviewers and maintainers to discuss.

This series change the way HEST table offsets are calculated,
making them identical to what an OSPM would do and allowing
multiple HEST entries without causing migration issues. It open
space to add HEST support for non-arm architectures, as now
the number and type of HEST notification entries are not
hardcoded at ghes.c. Instead, they're passed as a parameter
from the arch-dependent init code.

With such issue addressed, it adds a new notification type and
add support to inject errors via a Python script. The script
itself is at the final patch.

---
v9:
- backward compatibility logic moved to version 10.0;
- fixed a compilation issue with target/arm/kvm.c (probably
  caused by some rebase - funny enough, incremental 
  compilation was fine here);
- added two missing SPDX comments.

v8:
  - added a patch to revert recently-added changeset causing a
    conflict with these. All remaining patches are identical.

v7:
  - minor editorial change at the patch updating HEST doc spec
   with the new workflow

v6:
- some minor nits addressed:
   - use GPA instead of offset;
   - merged two patches;
   - fixed a couple of long line coding style issues;
   - the HEST/DSDT diff inside a patch was changed to avoid troubles
     applying it.

v5:
- make checkpatch happier;
- HEST table is now tested;
- some changes at HEST spec documentation to align with code changes;
- extra care was taken with regards to git bisectability.

v4:
- added an extra comment for AcpiGhesState structure;
- patches reordered;
- no functional changes, just code shift between the patches in this series.

v3:
- addressed more nits;
- hest_add_le now points to the beginning of HEST table;
- removed HEST from tests/data/acpi;
- added an extra patch to not use fw_cfg with virt-10.0 for hw_error_le

v2: 
- address some nits;
- improved ags cleanup patch and removed ags.present field;
- added some missing le*_to_cpu() calls;
- update date at copyright for new files to 2024-2025;
- qmp command changed to: inject-ghes-v2-error ans since updated to 10.0;
- added HEST and DSDT tables after the changes to make check target happy.
  (two patches: first one whitelisting such tables; second one removing from
   whitelist and updating/adding such tables to tests/data/acpi)


Mauro Carvalho Chehab (20):
  tests/acpi: virt: add an empty HEST file
  tests/qtest/bios-tables-test: extend to also check HEST table
  tests/acpi: virt: update HEST file with its current data
  Revert "hw/acpi/ghes: Make ghes_record_cper_errors() static"
  acpi/ghes: Cleanup the code which gets ghes ged state
  acpi/ghes: prepare to change the way HEST offsets are calculated
  acpi/ghes: add a firmware file with HEST address
  acpi/ghes: Use HEST table offsets when preparing GHES records
  acpi/ghes: don't hard-code the number of sources for HEST table
  acpi/ghes: add a notifier to notify when error data is ready
  acpi/generic_event_device: Update GHES migration to cover hest addr
  acpi/generic_event_device: add logic to detect if HEST addr is
    available
  acpi/generic_event_device: add an APEI error device
  tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
  arm/virt: Wire up a GED error device for ACPI / GHES
  qapi/acpi-hest: add an interface to do generic CPER error injection
  acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
  tests/acpi: virt: update HEST and DSDT tables
  docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
  scripts/ghes_inject: add a script to generate GHES error inject

 MAINTAINERS                                   |  10 +
 docs/specs/acpi_hest_ghes.rst                 |  28 +-
 hw/acpi/Kconfig                               |   5 +
 hw/acpi/aml-build.c                           |  10 +
 hw/acpi/generic_event_device.c                |  44 ++
 hw/acpi/ghes-stub.c                           |   7 +-
 hw/acpi/ghes.c                                | 233 ++++--
 hw/acpi/ghes_cper.c                           |  39 +
 hw/acpi/ghes_cper_stub.c                      |  20 +
 hw/acpi/meson.build                           |   2 +
 hw/arm/virt-acpi-build.c                      |  35 +-
 hw/arm/virt.c                                 |  19 +-
 hw/core/machine.c                             |   5 +-
 include/hw/acpi/acpi_dev_interface.h          |   1 +
 include/hw/acpi/aml-build.h                   |   2 +
 include/hw/acpi/generic_event_device.h        |   1 +
 include/hw/acpi/ghes.h                        |  51 +-
 include/hw/arm/virt.h                         |   2 +
 qapi/acpi-hest.json                           |  35 +
 qapi/meson.build                              |   1 +
 qapi/qapi-schema.json                         |   1 +
 scripts/arm_processor_error.py                | 476 ++++++++++++
 scripts/ghes_inject.py                        |  51 ++
 scripts/qmp_helper.py                         | 703 ++++++++++++++++++
 target/arm/kvm.c                              |   7 +-
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
 tests/data/acpi/aarch64/virt/HEST             | Bin 0 -> 224 bytes
 tests/qtest/bios-tables-test.c                |   2 +-
 32 files changed, 1699 insertions(+), 91 deletions(-)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/acpi-hest.json
 create mode 100644 scripts/arm_processor_error.py
 create mode 100755 scripts/ghes_inject.py
 create mode 100755 scripts/qmp_helper.py
 create mode 100644 tests/data/acpi/aarch64/virt/HEST

-- 
2.49.0



