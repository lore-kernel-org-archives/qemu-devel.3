Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1287BCCA471
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 01:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5wq8-0003iX-I5; Mon, 06 Oct 2025 21:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5wq6-0003hf-QU
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 21:50:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5wq4-0005Q7-FV
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 21:50:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso4887919f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 18:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759801800; x=1760406600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hr3PB1R9nHm/kPCRhxX105VJye7sFqD5bZZ+Vm5Pit8=;
 b=q/eAFSo8X0Qj5ibK/ouVD1QCNc1wT2XFTnQH4mhn/bam+HIw0m7XVIpSXwQaEdk38W
 mhf5tBIf0KdMESm4rLmC639aO7wT+E6PQfUqWD331GsD9eM5q+yo7XpbVDrAv5fmlRtf
 uJo0aEGE9XCKSAij0Hzm24tpRQUM+giVx2Ym9lq8CyilKMiTdj1t/2bbjfNgopPnkLVH
 dEzNJPKB/DnOJ7o3CkE/R2UVHn/Ex84CJwV5u8Kt9+TadjgdYqNpsxSL3bghuMou4/N+
 uVYNZpHZEHNDq9LdznMo/Q+glQfSf8x7AlfR+E/XpHNdjqdi7o4bc7mMyT2cznu4Fqs5
 tPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759801800; x=1760406600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hr3PB1R9nHm/kPCRhxX105VJye7sFqD5bZZ+Vm5Pit8=;
 b=k69axM6lHGg/3S0cvEHGwUfvQc+PHsLG4s6QKorjpD0QQzc2RJ6+2dtCrngacZhAzC
 GvLSg2WQOk1/o8t6j6BNTVV734UcyTgUUp+f7xgUVYtySYUBTmYQTVzjx5ZPHmx7xAmf
 hiQmW/ne5Abt43Nyt+XtVh8J8S9vnK1fy+Cir48VPav02Ultim3RLWuRnprev0mtvrJ0
 nVNB527GC0nNGYvkX1tBf4B8WjimcOhIKi5Kb2duUbXpc0pxb05QlerByYEtjIjW9QDq
 S9R3IelsYj+QyHzzhsUtMWWnD+QEW/U8ZlU5XNvADNgemE1oLpGPPsWcosgd2+0B9mS8
 bnGg==
X-Gm-Message-State: AOJu0Yx0Q7jEXIoWYSVW6S/0feAexM97rbn3n20LzVGsZJQFvSnfITm2
 8BlwZdN/8AogfGihXUhQ7hDQccxRUrU6jt7tlAvZ9Fbsp65xhLKvnIhcFJi38TyG39EVNN/vkAc
 hWKxXWc1y6ufv
X-Gm-Gg: ASbGncuu39BjSox+tqKSscgXy9Rsxe2V8ALilmEZekQN5AlrlVf/4V8k35zl4W1rfu2
 VoUoBsts0vE6lLLzZEca8ykgz85ibn5gnbTqOdMY7KeOnu7Q+gJqL6iZkYo6bM7DA6qdHIc45Lf
 tQZKyr6IUPf0XtYknZdjR6kbaHgZYIy6mr/bQ28Ij6I2YDV7FVzlyx/co7Tz6CCp4Er+MNzwsK4
 Jp7TbwrIJAQmJ2klSN+ZZF5IOqKd2wEkrPOQQbhXtI2DQPiuiukKZcohC0Y8VB7x/NdPCF4H1+X
 T7uzj6sp0SzTHQpp0BDFd0Xx8JiaxVJlwZuIimTZBzc7zIqnVPM3KKNjDrxHQuUkOvLZpaf3rCQ
 Y3mFHldKR0aR1OH9fOFsXRgChXNsZzYX5F5Ln0SkpHLOz2n+WuF76XNrEUB9mQ9qway1XWtGq2Z
 iCp3ckmVisb5bdvnU8q1ZNe5YH
X-Google-Smtp-Source: AGHT+IFwQbExrDHwTSVjvbqqcxkVVIDY7UTFVAp1ryhqW03dcc7uT19YYpnrDWUfEAkMOTV2/t3N/g==
X-Received: by 2002:a05:6000:2dc9:b0:3ea:6680:8fcd with SMTP id
 ffacd0b85a97d-425671368bemr9790097f8f.13.1759801800201; 
 Mon, 06 Oct 2025 18:50:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e980dsm25017959f8f.36.2025.10.06.18.49.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Oct 2025 18:49:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] Memory patches for 2025-10-07
Date: Tue,  7 Oct 2025 03:49:56 +0200
Message-ID: <20251007014958.19086-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit eb7abb4a719f93ddd56571bf91681044b4159399:

  hw/intc/loongarch_dintc: Set class_size for LoongArchDINTCClass (2025-10-06 13:54:50 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/physmem-20251007

for you to fetch changes up to 9ccfde942d8b4e66eb012cf975dac16913875a2c:

  system/physmem: Extract API out of 'system/ram_addr.h' header (2025-10-07 03:37:40 +0200)

----------------------------------------------------------------
Memory patches

- Cleanups on RAMBlock API
- Cleanups on Physical Memory API
- Remove cpu_physical_memory_is_io()
- Remove cpu_physical_memory_rw()
- Legacy conversion [cpu_physical_memory -> address_space]_[un]map()

----------------------------------------------------------------

Philippe Mathieu-Daudé (40):
  system/ramblock: Remove obsolete comment
  system/ramblock: Move ram_block_is_pmem() declaration
  system/ramblock: Move ram_block_discard_*_range() declarations
  system/ramblock: Rename @start -> @offset in ram_block_discard_range()
  system/ramblock: Move RAMBlock helpers out of "system/ram_addr.h"
  docs/devel/loads-stores: Stop mentioning
    cpu_physical_memory_write_rom()
  system/memory: Factor address_space_is_io() out
  target/i386/arch_memory_mapping: Use address_space_memory_is_io()
  hw/s390x/sclp: Use address_space_memory_is_io() in sclp_service_call()
  system/physmem: Remove cpu_physical_memory_is_io()
  system/physmem: Pass address space argument to
    cpu_flush_icache_range()
  hw/s390x/sclp: Replace [cpu_physical_memory -> address_space]_r/w()
  target/s390x/mmu: Replace [cpu_physical_memory -> address_space]_rw()
  target/i386/whpx: Replace legacy cpu_physical_memory_rw() call
  target/i386/kvm: Replace legacy cpu_physical_memory_rw() call
  target/i386/nvmm: Inline cpu_physical_memory_rw() in nvmm_mem_callback
  hw/xen/hvm: Inline cpu_physical_memory_rw() in rw_phys_req_item()
  system/physmem: Un-inline cpu_physical_memory_read/write()
  system/physmem: Avoid cpu_physical_memory_rw when is_write is constant
  system/physmem: Remove legacy cpu_physical_memory_rw()
  hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
  hw/virtio/virtio: Replace legacy cpu_physical_memory_map() call
  system/ram_addr: Remove unnecessary 'exec/cpu-common.h' header
  accel/kvm: Include missing 'exec/target_page.h' header
  hw/s390x/s390-stattrib: Include missing 'exec/target_page.h' header
  hw/vfio/listener: Include missing 'exec/target_page.h' header
  target/arm/tcg/mte: Include missing 'exec/target_page.h' header
  hw: Remove unnecessary 'system/ram_addr.h' header
  system/physmem: Un-inline cpu_physical_memory_get_dirty_flag()
  system/physmem: Un-inline cpu_physical_memory_is_clean()
  system/physmem: Un-inline cpu_physical_memory_range_includes_clean()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_flag()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_range()
  system/physmem: Remove _WIN32 #ifdef'ry
  system/physmem: Un-inline cpu_physical_memory_set_dirty_lebitmap()
  system/physmem: Un-inline cpu_physical_memory_dirty_bits_cleared()
  system/physmem: Reduce cpu_physical_memory_clear_dirty_range() scope
  system/physmem: Reduce cpu_physical_memory_sync_dirty_bitmap() scope
  system/physmem: Drop 'cpu_' prefix in Physical Memory API
  system/physmem: Extract API out of 'system/ram_addr.h' header

Richard Henderson (1):
  system/memory: Split address_space_write_rom_internal

 MAINTAINERS                               |   1 +
 docs/devel/loads-stores.rst               |   6 +-
 scripts/coccinelle/exec_rw_const.cocci    |  22 -
 include/exec/cpu-common.h                 |  21 +-
 include/system/memory.h                   |  11 +
 include/system/physmem.h                  |  54 +++
 include/system/ram_addr.h                 | 426 -------------------
 include/system/ramblock.h                 |  27 +-
 accel/kvm/kvm-all.c                       |   6 +-
 accel/tcg/cputlb.c                        |  13 +-
 hw/core/loader.c                          |   2 +-
 hw/hyperv/hv-balloon-our_range_memslots.c |   1 +
 hw/ppc/spapr.c                            |   1 -
 hw/ppc/spapr_caps.c                       |   1 -
 hw/ppc/spapr_pci.c                        |   1 -
 hw/remote/memory.c                        |   1 -
 hw/remote/proxy-memory-listener.c         |   1 -
 hw/s390x/s390-stattrib-kvm.c              |   2 +-
 hw/s390x/s390-stattrib.c                  |   2 +-
 hw/s390x/s390-virtio-ccw.c                |   1 -
 hw/s390x/sclp.c                           |  14 +-
 hw/vfio/container-legacy.c                |  10 +-
 hw/vfio/container.c                       |   5 +-
 hw/vfio/listener.c                        |   2 +-
 hw/vfio/spapr.c                           |   1 -
 hw/virtio/vhost.c                         |   7 +-
 hw/virtio/virtio-balloon.c                |   1 +
 hw/virtio/virtio-mem.c                    |   2 +-
 hw/virtio/virtio.c                        |  10 +-
 hw/xen/xen-hvm-common.c                   |   8 +-
 migration/ram.c                           |  81 +++-
 system/memory.c                           |   9 +-
 system/physmem.c                          | 475 +++++++++++++++++-----
 target/arm/tcg/mte_helper.c               |   5 +-
 target/i386/arch_memory_mapping.c         |  10 +-
 target/i386/kvm/xen-emu.c                 |   4 +-
 target/i386/nvmm/nvmm-all.c               |   5 +-
 target/i386/whpx/whpx-all.c               |   7 +-
 target/s390x/mmu_helper.c                 |   7 +-
 system/memory_ldst.c.inc                  |   2 +-
 tests/tsan/ignore.tsan                    |   4 +-
 41 files changed, 636 insertions(+), 633 deletions(-)
 create mode 100644 include/system/physmem.h

-- 
2.51.0


