Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FD0C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1U7-0002Dj-VE; Tue, 12 Mar 2024 08:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Tz-00028M-Dw
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1Tw-0008Tx-Uz
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dseMP8UyRCSQKET7Cr0mrRiAUAykMnsEpQj7w2/2lLc=;
 b=Q//3Kl4EDNu66kMwDqwwibaFX2GY1av6M/Gex/JcD0ugQuXzUjp4BW+Jmgo1Fo4Gt1kPSZ
 9bS/46A3rS1tAwgCPV/IpPFv6ZYOPJW6Cgo8gsd9qr93FQlRCWiJrrQyvvsmrUgX1Q0uwd
 rVFff2KJnoSF9SraPt1xFmhAfqWDqHA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-cdhmGH6OMDmHPcLoOD_hLg-1; Tue, 12 Mar 2024 08:43:43 -0400
X-MC-Unique: cdhmGH6OMDmHPcLoOD_hLg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A43498007A2;
 Tue, 12 Mar 2024 12:43:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA437492BC4;
 Tue, 12 Mar 2024 12:43:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/55] Misc ERRP_GUARD() and cpu_env() patches
Date: Tue, 12 Mar 2024 13:42:44 +0100
Message-ID: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:

  Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-03-12

for you to fetch changes up to 42e62aadfdcc44215482a85da55dc4758775d790:

  user: Prefer fast cpu_env() over slower CPU QOM cast macro (2024-03-12 12:04:25 +0100)

----------------------------------------------------------------
* Add missing ERRP_GUARD() statements in functions that need it
* Prefer fast cpu_env() over slower CPU QOM cast macro

----------------------------------------------------------------
Philippe Mathieu-Daudé (22):
      bulk: Access existing variables initialized to &S->F when available
      hw/core: Declare CPUArchId::cpu as CPUState instead of Object
      bulk: Call in place single use cpu_env()
      target: Replace CPU_GET_CLASS(cpu -> obj) in cpu_reset_hold() handler
      target/alpha: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/avr: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/cris: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/hexagon: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/i386/hvf: Use CPUState typedef
      target/loongarch: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/m68k: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/microblaze: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/mips: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/nios2: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/openrisc: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/ppc: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/rx: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/sh4: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/sparc: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/tricore: Prefer fast cpu_env() over slower CPU QOM cast macro
      target/xtensa: Prefer fast cpu_env() over slower CPU QOM cast macro
      user: Prefer fast cpu_env() over slower CPU QOM cast macro

Zhao Liu (33):
      hw/cxl/cxl-host: Fix missing ERRP_GUARD() in cxl_fixed_memory_window_config()
      hw/display/macfb: Fix missing ERRP_GUARD() in macfb_nubus_realize()
      hw/mem/cxl_type3: Fix missing ERRP_GUARD() in ct3_realize()
      hw/misc/xlnx-versal-trng: Check returned bool in trng_prop_fault_event_set()
      hw/pci-bridge/cxl_upstream: Fix missing ERRP_GUARD() in cxl_usp_realize()
      hw/intc: Check @errp to handle the error of IOAPICCommonClass.realize()
      error: Add error_vprepend() in comment of ERRP_GUARD() rules
      backends/iommufd: Fix missing ERRP_GUARD() for error_prepend()
      block: Fix missing ERRP_GUARD() for error_prepend()
      block/copy-before-write: Fix missing ERRP_GUARD() for error_prepend()
      block/nbd: Fix missing ERRP_GUARD() for error_prepend()
      block/nvme: Fix missing ERRP_GUARD() for error_prepend()
      block/qcow2-bitmap: Fix missing ERRP_GUARD() for error_prepend()
      block/qcow2: Fix missing ERRP_GUARD() for error_prepend()
      block/qed: Fix missing ERRP_GUARD() for error_prepend()
      block/snapshot: Fix missing ERRP_GUARD() for error_prepend()
      block/vdi: Fix missing ERRP_GUARD() for error_prepend()
      block/vmdk: Fix missing ERRP_GUARD() for error_prepend()
      block/virtio-blk: Fix missing ERRP_GUARD() for error_prepend()
      hw/scsi/vhost-scsi: Fix missing ERRP_GUARD() for error_prepend()
      hw/vfio/ap: Fix missing ERRP_GUARD() for error_prepend()
      hw/vfio/container: Fix missing ERRP_GUARD() for error_prepend()
      hw/vfio/helpers: Fix missing ERRP_GUARD() for error_prepend()
      hw/vfio/iommufd: Fix missing ERRP_GUARD() for error_prepend()
      hw/vfio/pci-quirks: Fix missing ERRP_GUARD() for error_prepend()
      hw/vfio/pci: Fix missing ERRP_GUARD() for error_prepend()
      hw/vfio/platform: Fix missing ERRP_GUARD() for error_prepend()
      hw/virtio/vhost-vsock: Fix missing ERRP_GUARD() for error_prepend()
      hw/virtio/vhost: Fix missing ERRP_GUARD() for error_prepend()
      migration/option: Fix missing ERRP_GUARD() for error_prepend()
      net/vhost-vdpa: Fix missing ERRP_GUARD() for error_prepend()
      target/s390x/cpu_models: Fix missing ERRP_GUARD() for error_prepend()
      error: Move ERRP_GUARD() to the beginning of the function

 include/hw/boards.h                     |  2 +-
 include/qapi/error.h                    |  2 +-
 target/i386/hvf/x86.h                   | 26 ++++++++++-----------
 target/i386/hvf/x86_descr.h             | 14 +++++------
 target/i386/hvf/x86_emu.h               |  4 ++--
 target/i386/hvf/x86_mmu.h               |  6 ++---
 accel/tcg/cpu-exec.c                    |  3 +--
 backends/iommufd.c                      |  1 +
 block.c                                 |  6 ++++-
 block/copy-before-write.c               |  1 +
 block/nbd.c                             |  1 +
 block/nvme.c                            |  3 +++
 block/qapi.c                            |  6 ++---
 block/qcow2-bitmap.c                    |  1 +
 block/qcow2.c                           |  2 ++
 block/qed.c                             |  1 +
 block/snapshot.c                        |  2 ++
 block/vdi.c                             |  1 +
 block/vmdk.c                            |  1 +
 bsd-user/signal.c                       |  3 +--
 hw/block/virtio-blk.c                   |  1 +
 hw/core/machine.c                       |  4 ++--
 hw/cxl/cxl-host.c                       |  1 +
 hw/display/ati.c                        |  2 +-
 hw/display/macfb.c                      |  1 +
 hw/i386/x86.c                           |  2 +-
 hw/intc/ioapic_common.c                 |  4 ++++
 hw/loongarch/virt.c                     |  2 +-
 hw/mem/cxl_type3.c                      |  1 +
 hw/misc/macio/pmu.c                     |  3 +--
 hw/misc/pvpanic-pci.c                   |  2 +-
 hw/misc/xlnx-versal-trng.c              |  3 +--
 hw/pci-bridge/cxl_root_port.c           |  2 +-
 hw/pci-bridge/cxl_upstream.c            |  1 +
 hw/ppc/mpc8544_guts.c                   |  3 +--
 hw/ppc/pnv.c                            | 23 +++++++++---------
 hw/ppc/pnv_xscom.c                      |  5 +---
 hw/ppc/ppce500_spin.c                   |  3 +--
 hw/ppc/spapr.c                          |  8 +++----
 hw/ppc/spapr_caps.c                     |  7 ++----
 hw/s390x/s390-virtio-ccw.c              |  4 ++--
 hw/scsi/vhost-scsi.c                    |  1 +
 hw/vfio/ap.c                            |  1 +
 hw/vfio/container.c                     |  1 +
 hw/vfio/helpers.c                       |  3 +++
 hw/vfio/iommufd.c                       |  1 +
 hw/vfio/pci-quirks.c                    |  2 ++
 hw/vfio/pci.c                           |  2 ++
 hw/vfio/platform.c                      |  1 +
 hw/virtio/vhost-user-scmi.c             |  6 ++---
 hw/virtio/vhost-vsock.c                 |  1 +
 hw/virtio/vhost.c                       |  2 ++
 hw/virtio/virtio-pci.c                  |  2 +-
 hw/xen/xen_pt.c                         |  6 ++---
 linux-user/i386/cpu_loop.c              |  4 ++--
 linux-user/signal.c                     |  6 ++---
 migration/multifd-zlib.c                |  2 +-
 migration/options.c                     |  4 +++-
 migration/postcopy-ram.c                |  4 ++--
 net/vhost-vdpa.c                        |  4 ++--
 target/alpha/cpu.c                      | 31 ++++++-------------------
 target/alpha/gdbstub.c                  |  6 ++---
 target/alpha/helper.c                   | 15 ++++--------
 target/alpha/mem_helper.c               | 11 +++------
 target/alpha/translate.c                |  4 ++--
 target/arm/cpu.c                        | 18 +++++++--------
 target/arm/kvm.c                        |  2 +-
 target/arm/machine.c                    |  6 ++---
 target/avr/cpu.c                        | 29 +++++++----------------
 target/avr/gdbstub.c                    |  6 ++---
 target/avr/helper.c                     | 10 +++-----
 target/avr/translate.c                  |  3 +--
 target/cris/cpu.c                       | 12 ++++------
 target/cris/gdbstub.c                   |  9 +++-----
 target/cris/helper.c                    | 12 ++++------
 target/cris/translate.c                 |  6 ++---
 target/hexagon/cpu.c                    | 27 ++++++----------------
 target/hexagon/gdbstub.c                |  6 ++---
 target/hppa/mem_helper.c                |  3 +--
 target/hppa/translate.c                 |  3 +--
 target/i386/cpu.c                       | 14 +++++------
 target/i386/hvf/x86.c                   | 26 ++++++++++-----------
 target/i386/hvf/x86_descr.c             | 11 +++++----
 target/i386/hvf/x86_mmu.c               | 14 +++++------
 target/i386/hvf/x86hvf.c                |  2 +-
 target/i386/nvmm/nvmm-all.c             |  6 ++---
 target/i386/whpx/whpx-all.c             | 18 +++++----------
 target/loongarch/cpu.c                  | 41 +++++++++------------------------
 target/loongarch/cpu_helper.c           |  3 +--
 target/loongarch/gdbstub.c              |  6 ++---
 target/loongarch/kvm/kvm.c              | 41 ++++++++++-----------------------
 target/loongarch/tcg/tlb_helper.c       |  3 +--
 target/loongarch/tcg/translate.c        |  3 +--
 target/m68k/cpu.c                       | 37 +++++++++++------------------
 target/m68k/gdbstub.c                   |  6 ++---
 target/m68k/helper.c                    |  8 +++----
 target/m68k/m68k-semi.c                 |  6 ++---
 target/m68k/op_helper.c                 | 11 +++------
 target/m68k/translate.c                 |  3 +--
 target/microblaze/cpu.c                 |  6 ++---
 target/microblaze/gdbstub.c             |  3 +--
 target/microblaze/helper.c              |  3 +--
 target/microblaze/translate.c           |  6 ++---
 target/mips/cpu.c                       | 17 ++++----------
 target/mips/gdbstub.c                   |  6 ++---
 target/mips/kvm.c                       | 27 ++++++++--------------
 target/mips/sysemu/physaddr.c           |  3 +--
 target/mips/tcg/exception.c             |  3 +--
 target/mips/tcg/op_helper.c             |  8 +++----
 target/mips/tcg/sysemu/special_helper.c |  3 +--
 target/mips/tcg/sysemu/tlb_helper.c     |  6 ++---
 target/mips/tcg/translate.c             |  3 +--
 target/nios2/cpu.c                      | 17 ++++----------
 target/nios2/helper.c                   |  3 +--
 target/nios2/nios2-semi.c               |  6 ++---
 target/nios2/translate.c                |  3 +--
 target/openrisc/cpu.c                   |  8 +++----
 target/openrisc/gdbstub.c               |  6 ++---
 target/openrisc/interrupt.c             |  6 ++---
 target/openrisc/translate.c             |  6 ++---
 target/ppc/cpu_init.c                   | 23 ++++++++----------
 target/ppc/excp_helper.c                |  3 +--
 target/ppc/gdbstub.c                    | 12 ++++------
 target/ppc/kvm.c                        | 20 +++++++---------
 target/ppc/ppc-qmp-cmds.c               |  3 +--
 target/ppc/user_only_helper.c           |  3 +--
 target/riscv/cpu.c                      |  2 +-
 target/rx/cpu.c                         |  6 ++---
 target/rx/gdbstub.c                     |  6 ++---
 target/rx/helper.c                      |  6 ++---
 target/rx/translate.c                   |  6 ++---
 target/s390x/cpu_models.c               |  2 ++
 target/sh4/cpu.c                        | 22 +++++++-----------
 target/sh4/gdbstub.c                    |  6 ++---
 target/sh4/helper.c                     | 14 ++++-------
 target/sh4/op_helper.c                  |  4 +---
 target/sh4/translate.c                  |  6 ++---
 target/sparc/cpu.c                      | 21 ++++++-----------
 target/sparc/gdbstub.c                  |  3 +--
 target/sparc/int32_helper.c             |  3 +--
 target/sparc/int64_helper.c             |  3 +--
 target/sparc/ldst_helper.c              |  6 ++---
 target/sparc/mmu_helper.c               | 15 ++++--------
 target/sparc/translate.c                |  9 +++-----
 target/tricore/cpu.c                    | 28 ++++++----------------
 target/tricore/gdbstub.c                |  6 ++---
 target/tricore/helper.c                 |  3 +--
 target/tricore/translate.c              |  3 +--
 target/xtensa/cpu.c                     |  9 ++++----
 target/xtensa/dbg_helper.c              |  3 +--
 target/xtensa/exc_helper.c              |  3 +--
 target/xtensa/gdbstub.c                 |  6 ++---
 target/xtensa/helper.c                  |  9 +++-----
 target/xtensa/translate.c               |  6 ++---
 154 files changed, 436 insertions(+), 692 deletions(-)


