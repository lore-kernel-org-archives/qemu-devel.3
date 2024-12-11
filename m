Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA0FE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIaA-0005rI-9T; Wed, 11 Dec 2024 04:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIa8-0005r7-3b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIa4-0007p7-2M
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MaKWt+sa+9MTo4wMwi1e7BQIyjX/csXwGJl8YCq44Rk=;
 b=bMWCvraWnOEN5VQze/Phq1twsWZP18DCi3QyrycfwizvraGj7CsTWFXaDqcyFTdDWkGDPk
 XGnOqrJg4/a78CjyC5isQi7v3/zqYSnixGs1txyO61ctxaz5EzNzNYVAXQvtddXcFAGBRr
 eSavACFPDy84CDso7WeOVuNyxcDBSuM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-7DSoQknDOz6KyJCc3BhVHg-1; Wed,
 11 Dec 2024 04:00:20 -0500
X-MC-Unique: 7DSoQknDOz6KyJCc3BhVHg-1
X-Mimecast-MFC-AGG-ID: 7DSoQknDOz6KyJCc3BhVHg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 543EC1955F3B; Wed, 11 Dec 2024 09:00:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47BC51956094; Wed, 11 Dec 2024 09:00:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/26] First s390x and functional testing patches for v10.0
Date: Wed, 11 Dec 2024 09:59:44 +0100
Message-ID: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

 Hi!

The following changes since commit ae35f033b874c627d81d51070187fbf55f0bf1a7:

  Update version for v9.2.0 release (2024-12-10 16:20:54 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-12-11

for you to fetch changes up to f29c96d0f5760f72220623500ee659f1fc2d1542:

  tests/functional: remove pointless with statement (2024-12-11 09:19:12 +0100)

----------------------------------------------------------------
* Add compat machines for QEMU 10.0
* Add s390x CPU model for the gen17 mainframe
* Convert some more avocado tests to the new functional framework
* Some minor clean-ups for functional tests

----------------------------------------------------------------
Cornelia Huck (1):
      hw: add compat machines for 10.0

Daniel P. Berrangé (4):
      hw/i386: define _AS_LATEST() macros for machine types
      docs: replace 'Edit on GitLab' with 'View page source'
      tests/functional: remove unused system imports
      tests/functional: remove pointless with statement

Hendrik Brueckner (15):
      s390x/cpumodel: add msa10 subfunctions
      s390x/cpumodel: add msa11 subfunctions
      s390x/cpumodel: add msa12 changes
      s390x/cpumodel: add msa13 subfunctions
      s390x/cpumodel: Add ptff Query Time-Stamp Event (QTSE) support
      linux-headers: Update to Linux 6.13-rc1
      s390x/cpumodel: add Concurrent-functions facility support
      s390x/cpumodel: add Vector Enhancements facility 3
      s390x/cpumodel: add Miscellaneous-Instruction-Extensions Facility 4
      s390x/cpumodel: add Vector-Packed-Decimal-Enhancement facility 3
      s390x/cpumodel: add Ineffective-nonconstrained-transaction facility
      s390x/cpumodel: Add Sequential-Instruction-Fetching facility
      s390x/cpumodel: correct PLO feature wording
      s390x/cpumodel: Add PLO-extension facility
      s390x/cpumodel: gen17 model

Thomas Huth (6):
      tests/functional: Bump the timeout of the sh4_tuxrun test
      MAINTAINERS: Cover the tests/functional/test_sh4eb_r2d.py file
      tests/functional: Convert the xlnx_versal_virt avocado test
      tests/functional: Convert the emcraft_sf2 avocado test
      tests/functional: Convert the smdkc210 avocado test
      tests/functional: Convert the cubieboard avocado tests

 MAINTAINERS                                    |   6 +-
 docs/conf.py                                   |   2 +-
 include/hw/boards.h                            |   3 +
 include/hw/i386/pc.h                           |   7 +-
 include/standard-headers/drm/drm_fourcc.h      |   1 +
 include/standard-headers/linux/ethtool.h       |   5 +
 include/standard-headers/linux/pci_regs.h      |  38 +++-
 include/standard-headers/linux/virtio_crypto.h |   1 +
 include/standard-headers/linux/virtio_pci.h    | 131 ++++++++++++
 linux-headers/asm-arm64/kvm.h                  |   6 +
 linux-headers/asm-arm64/unistd_64.h            |   4 +
 linux-headers/asm-generic/mman-common.h        |   3 +
 linux-headers/asm-generic/mman.h               |   4 +
 linux-headers/asm-generic/unistd.h             |  11 +-
 linux-headers/asm-loongarch/kvm.h              |  20 ++
 linux-headers/asm-loongarch/unistd_64.h        |   4 +
 linux-headers/asm-mips/mman.h                  |   3 +
 linux-headers/asm-mips/unistd_n32.h            |   4 +
 linux-headers/asm-mips/unistd_n64.h            |   4 +
 linux-headers/asm-mips/unistd_o32.h            |   4 +
 linux-headers/asm-powerpc/unistd_32.h          |   4 +
 linux-headers/asm-powerpc/unistd_64.h          |   4 +
 linux-headers/asm-riscv/kvm.h                  |   4 +
 linux-headers/asm-riscv/unistd_32.h            |   4 +
 linux-headers/asm-riscv/unistd_64.h            |   4 +
 linux-headers/asm-s390/kvm.h                   |   3 +-
 linux-headers/asm-s390/unistd_32.h             |   4 +
 linux-headers/asm-s390/unistd_64.h             |   4 +
 linux-headers/asm-x86/kvm.h                    |   1 +
 linux-headers/asm-x86/mman.h                   |   3 -
 linux-headers/asm-x86/unistd_32.h              |   4 +
 linux-headers/asm-x86/unistd_64.h              |   4 +
 linux-headers/asm-x86/unistd_x32.h             |   4 +
 linux-headers/linux/iommufd.h                  | 224 +++++++++++++++++++-
 linux-headers/linux/kvm.h                      |   8 +
 linux-headers/linux/psci.h                     |   5 +
 linux-headers/linux/vfio.h                     |   2 +-
 target/s390x/cpu_features.h                    |   1 +
 target/s390x/cpu_features_def.h.inc            |  94 ++++++++-
 hw/arm/virt.c                                  |   9 +-
 hw/core/machine.c                              |   3 +
 hw/i386/pc.c                                   |   3 +
 hw/i386/pc_piix.c                              |  20 +-
 hw/i386/pc_q35.c                               |  20 +-
 hw/m68k/virt.c                                 |   9 +-
 hw/ppc/spapr.c                                 |  15 +-
 hw/s390x/s390-virtio-ccw.c                     |  14 +-
 target/s390x/cpu_features.c                    |  11 +
 target/s390x/cpu_models.c                      |  61 ++++++
 target/s390x/gen-features.c                    | 178 ++++++++++++++++
 target/s390x/kvm/kvm.c                         |   6 +
 tests/avocado/boot_linux_console.py            | 269 -------------------------
 tests/functional/meson.build                   |   6 +
 tests/functional/test_aarch64_sbsaref.py       |   1 -
 tests/functional/test_aarch64_xlnx_versal.py   |  37 ++++
 tests/functional/test_acpi_bits.py             |   1 -
 tests/functional/test_arm_cubieboard.py        | 150 ++++++++++++++
 tests/functional/test_arm_emcraft_sf2.py       |  52 +++++
 tests/functional/test_arm_smdkc210.py          |  57 ++++++
 tests/functional/test_m68k_mcf5208evb.py       |   2 -
 tests/functional/test_microblaze_s3adsp1800.py |   1 -
 tests/functional/test_mips64el_loongson3v.py   |   1 -
 tests/functional/test_or1k_sim.py              |   2 -
 tests/functional/test_ppc64_hv.py              |   7 +-
 tests/functional/test_s390x_topology.py        |   1 -
 tests/functional/test_sh4_tuxrun.py            |   4 -
 tests/functional/test_sh4eb_r2d.py             |   1 -
 tests/functional/test_virtio_version.py        |   2 -
 68 files changed, 1248 insertions(+), 337 deletions(-)
 create mode 100755 tests/functional/test_aarch64_xlnx_versal.py
 create mode 100755 tests/functional/test_arm_cubieboard.py
 create mode 100755 tests/functional/test_arm_emcraft_sf2.py
 create mode 100755 tests/functional/test_arm_smdkc210.py


