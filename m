Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BE5CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4htG-0004g3-FG; Fri, 03 Oct 2025 11:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htC-0004Yk-KJ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4ht6-0007JT-6I
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759505994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wX1LmVehk+k3MR0xoXMa/YxugTpui46fvbHNb0vuak0=;
 b=MIQYqy3kMQTkNBaZr4xMPAGyMplCUkLX6NfgtDx6BK4a107gX0aXCWLIKkVtp5DpQ706SJ
 XpvRsqKV4j0Qzy1rGdPcoEO9/3yOkZpGQwFrrwzMZB69vZZ0EcZFAw/UmwloVEfMKCy9oD
 Z5dUP9VfJAQHYyZIeWWjhtuyObvVeAY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-TEMudXhBPtK73gxaCRJH7g-1; Fri, 03 Oct 2025 11:39:53 -0400
X-MC-Unique: TEMudXhBPtK73gxaCRJH7g-1
X-Mimecast-MFC-AGG-ID: TEMudXhBPtK73gxaCRJH7g_1759505992
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7fa235e330dso45644446d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759505992; x=1760110792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wX1LmVehk+k3MR0xoXMa/YxugTpui46fvbHNb0vuak0=;
 b=SIWDhXAHpLk506ezUOWdBO9qIkC3OOdaU/OH5dYmtv0CteGLRWURTwgEYkb72DqyM7
 Ld2ZQy+GZRpDbruWwQbuxDdmtZ9635K9U8WEAlJnTO3Dh8pszZQ4x9ogqZztt3n87hSv
 BVKWEi9B7u/a555l25QxefVT8pLn0m0palBmIdLU5llhB+kYn0rERDoTSQ07+19bHk6a
 m3bx9Ko8ZZlKdgxtai0uJKctcsjC6D0MdWBn87iVnhEvKnv9t4+9JSin9hTZ9Hj3bOBK
 mBK7Sfqz3b3ke3jt/qzvWhaJzPFJ+TDDfXA1v1f5tn0KXSr2b7S1a5UENsebd5R26yRb
 5G7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwVhwA1p3tPV/9c2lrwYzQ/QoWrZL/5JKox7JpAEspNOjc8IVctQ28ayIb5TdyGOXw98FpnuzIOnQE@nongnu.org
X-Gm-Message-State: AOJu0Yy2lMjmT8/FlFiNH1X/waZQrTCmZXU7zbk8O2dBE9+NcNL34Onm
 kFg/4XAsXKUUGU0ki/uKgC5sfBPZVd6tXEXtCp3/56bru0ElqspA8lQB3ns4ivffIU/RbmuAKW2
 cHep/a4jPe2hE86eM0TiZcce7a9YqSIH5/8AIO+T7bsh9WUMdykv0M5QJ
X-Gm-Gg: ASbGncvuR7IyOcFZO0NpDA/ucq9SOjbYjWQclz40pAxSkGStGohBbJFXACKmoowOlhM
 ramuO7KuqBm4td8Teujo3xbv4MmEmwQyRJRX0lh14UPbni6ZEn+TcxFUoI5uCB0qmRH1XQAOi5d
 5JB8Wsk+/6HV/QJNP6wRdRWsoCtsjjpqrjX4AmJx4O1pxYQ5XV8rBnueuK54tujxEj65Z1fTzC1
 NE67Nl6ghHdKFxBPzH2LJLAWAEWO3StQIYabUAt2kkPOzlfi6BD2PhljulxT8DCxRNw4Tc7aGJt
 lYjxIEqrq1rSYgpJsE8Fo2P+0PozUnOxWY8ZuA==
X-Received: by 2002:ad4:5ccd:0:b0:77c:7fbc:281d with SMTP id
 6a1803df08f44-879dc386df6mr46275736d6.10.1759505992398; 
 Fri, 03 Oct 2025 08:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqsWmP3w+bwpHpmQDfA+BPdON/dV7W+JHj1hjh8PxdodqLY4L6dGWJjkXwMOu9PZDvyj8xQQ==
X-Received: by 2002:ad4:5ccd:0:b0:77c:7fbc:281d with SMTP id
 6a1803df08f44-879dc386df6mr46275166d6.10.1759505991810; 
 Fri, 03 Oct 2025 08:39:51 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:39:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/45] Staging patches
Date: Fri,  3 Oct 2025 11:39:03 -0400
Message-ID: <20251003153948.1304776-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 517e9b4862cc9798b7a24b1935d94c2f96787f12:

  Merge tag 'qtest-20251001-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-10-01 15:03:00 -0700)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/staging-pull-request

for you to fetch changes up to 27cffe16354816d57710d2d4357f16139405c749:

  migration-test: test cpr-exec (2025-10-03 09:48:02 -0400)

----------------------------------------------------------------
Migration/Memory Pull for 10.2

- PeterX's fix on tls warning for preempt channel when migratino completes
- Arun's series to enhance error reporting for vTPM and migration framework
- PeterX's patch to cleanup multifd send TLS BYE messages
- Juraj's fix on postcopy start state transition when switchover failed
- Yanfei's fix to migrate APIC before VFIO-PCI to avoid irq fallbacks
- Dan's cleanup to simplify error reporting in qemu_fill_buffer()
- PeterM's fix on address space leak when cpu hot plug / unplug
- Steve's cpr-exec wholeset

----------------------------------------------------------------

Arun Menon (26):
  migration: push Error **errp into vmstate_subsection_load()
  migration: push Error **errp into vmstate_load_state()
  migration: push Error **errp into qemu_loadvm_state_header()
  migration: push Error **errp into vmstate_load()
  migration: push Error **errp into loadvm_process_command()
  migration: push Error **errp into loadvm_handle_cmd_packaged()
  migration: push Error **errp into qemu_loadvm_state()
  migration: push Error **errp into qemu_load_device_state()
  migration: push Error **errp into qemu_loadvm_state_main()
  migration: push Error **errp into qemu_loadvm_section_start_full()
  migration: push Error **errp into qemu_loadvm_section_part_end()
  migration: Update qemu_file_get_return_path() docs and remove dead
    checks
  migration: make loadvm_postcopy_handle_resume() void
  migration: push Error **errp into ram_postcopy_incoming_init()
  migration: push Error **errp into loadvm_postcopy_handle_advise()
  migration: push Error **errp into loadvm_postcopy_handle_listen()
  migration: push Error **errp into loadvm_postcopy_handle_run()
  migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
  migration: push Error **errp into loadvm_handle_recv_bitmap()
  migration: Return -1 on memory allocation failure in ram.c
  migration: push Error **errp into loadvm_process_enable_colo()
  migration: push Error **errp into
    loadvm_postcopy_handle_switchover_start()
  migration: Capture error in postcopy_ram_listen_thread()
  migration: Remove error variant of vmstate_save_state() function
  migration: Add error-parameterized function variants in VMSD struct
  backends/tpm: Propagate vTPM error on migration failure

Bin Guo (1):
  migration: HMP: Adjust the order of output fields

Daniel P. Berrangé (1):
  migration: simplify error reporting after channel read

Juraj Marcin (1):
  migration: Fix state transition in postcopy_start() error handling

Peter Maydell (2):
  include/system/memory.h: Clarify address_space_destroy() behaviour
  physmem: Destroy all CPU AddressSpaces on unrealize

Peter Xu (4):
  io/crypto: Move tls premature termination handling into QIO layer
  migration: Make migration_has_failed() work even for CANCELLING
  migration/multifd/tls: Cleanup BYE message processing on sender side
  memory: New AS helper to serialize destroy+free

Steve Sistare (9):
  migration: multi-mode notifier
  migration: add cpr_walk_fd
  oslib: qemu_clear_cloexec
  migration: cpr-exec-command parameter
  migration: cpr-exec save and load
  migration: cpr-exec mode
  migration: cpr-exec docs
  vfio: cpr-exec mode
  migration-test: test cpr-exec

Yanfei Xu (1):
  migration: ensure APIC is loaded prior to VFIO PCI devices

 docs/devel/migration/CPR.rst       | 112 +++++++++-
 docs/devel/migration/main.rst      |  19 ++
 qapi/migration.json                |  46 +++-
 include/crypto/tlssession.h        |  10 +-
 include/exec/cpu-common.h          |  10 +-
 include/hw/core/cpu.h              |   1 -
 include/migration/colo.h           |   2 +-
 include/migration/cpr.h            |  10 +
 include/migration/misc.h           |  12 ++
 include/migration/vmstate.h        |  19 +-
 include/qemu/osdep.h               |   9 +
 include/system/memory.h            |  24 ++-
 migration/postcopy-ram.h           |   2 +-
 migration/ram.h                    |   4 +-
 migration/savevm.h                 |   7 +-
 backends/tpm/tpm_emulator.c        |  40 ++--
 crypto/tlssession.c                |   7 +-
 hw/core/cpu-common.c               |   1 +
 hw/display/virtio-gpu.c            |   5 +-
 hw/intc/apic_common.c              |   1 +
 hw/pci/pci.c                       |   5 +-
 hw/s390x/virtio-ccw.c              |   4 +-
 hw/scsi/spapr_vscsi.c              |   6 +-
 hw/vfio/container-legacy.c         |   3 +-
 hw/vfio/cpr-iommufd.c              |   3 +-
 hw/vfio/cpr-legacy.c               |   9 +-
 hw/vfio/cpr.c                      |  13 +-
 hw/vfio/pci.c                      |   9 +-
 hw/virtio/virtio-mmio.c            |   5 +-
 hw/virtio/virtio-pci.c             |   4 +-
 hw/virtio/virtio.c                 |  13 +-
 io/channel-tls.c                   |  21 +-
 migration/colo.c                   |  10 +-
 migration/cpr-exec.c               | 194 +++++++++++++++++
 migration/cpr.c                    |  42 +++-
 migration/migration-hmp-cmds.c     |  44 +++-
 migration/migration.c              | 116 +++++++---
 migration/multifd.c                |  65 +++---
 migration/options.c                |  14 ++
 migration/postcopy-ram.c           |   9 +-
 migration/qemu-file.c              |   7 +-
 migration/ram.c                    |  17 +-
 migration/savevm.c                 | 329 +++++++++++++++++------------
 migration/vmstate-types.c          |  61 ++++--
 migration/vmstate.c                | 103 ++++++---
 stubs/cpu-destroy-address-spaces.c |  15 ++
 system/memory.c                    |  20 +-
 system/physmem.c                   |  32 ++-
 system/vl.c                        |   4 +-
 tests/qtest/migration/cpr-tests.c  | 133 ++++++++++++
 tests/unit/test-vmstate.c          |  83 ++++++--
 ui/vdagent.c                       |   8 +-
 util/oslib-posix.c                 |   9 +
 util/oslib-win32.c                 |   4 +
 hmp-commands.hx                    |   2 +-
 migration/meson.build              |   1 +
 migration/trace-events             |   1 +
 stubs/meson.build                  |   1 +
 58 files changed, 1351 insertions(+), 409 deletions(-)
 create mode 100644 migration/cpr-exec.c
 create mode 100644 stubs/cpu-destroy-address-spaces.c

-- 
2.50.1


