Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11069E7FDEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1LP-0004Pc-4I; Mon, 02 Feb 2026 16:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1LN-0004PU-N8
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:25 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1LL-0007Jf-6Z
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:24 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4327555464cso3480468f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067221; x=1770672021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PKWo4T6xQay6H9OZBCowoxb2Fy6j0kq83QtmpitMS4U=;
 b=QHe0FIVfBdmTQqYyo2HKtH6nbI5NTpEzT7Kfg6DKaEz+duB8Y6pF0O94vaymu0vSDe
 /G6j4XVfQFzdTfiXx8/jm5cJRMBPZllchLfjHiE4AUUnyrM/IVVNexMX7MJSZ/Cg4I2b
 Jr43OXcnfAy94P6fDygQHckY3pzrEKasqJosooFxaT5H1wiEmXiCn8D+zjPcJg2lZ9Y2
 HGm1TuCBI/Q+uhWi4mxhSRy8MwEb226u/HKJAq/qq89UM+RPx1YbgQfaIn5z1vyxW44n
 bOFH7P0G8gpE1ypKVCqtXDUSwJ/KwutViDDXf98/6jXYwGx2lb2PZfvnJF6YKLhpycYu
 8tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067221; x=1770672021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PKWo4T6xQay6H9OZBCowoxb2Fy6j0kq83QtmpitMS4U=;
 b=j8QbGVdNADkDOCQ8QK/2xfZhznZo1Ijg+pOsDf2t8CRFMIn3vX2FNi0yYz9bcrnpKb
 2Ju889XOhCOagUKBvpeBfgu/yLdb1HsBS9VPJ2KJ2guEnwG9nPEV5C7BRk3eP+O1Sdyb
 fZ15zrdUUzjuwdaw6ONa77SJw8ua8+SRqmawViPnLuAgw2GZEFC8HKhfimpNDarSEJIR
 ZSFrgN1XJRd76GCVM87C8Ers3gBIqgwVZPq7QtY2L4AlxRX0Y2TUHlnNZX5GYMCEXHsP
 owsSiANu+uyBr/5mhsoka2JJ4SqFI1YRqlmF/cipXYayJWorYfQrsUiD8AAduooyUow6
 rQhA==
X-Gm-Message-State: AOJu0Ywymq0hP2ambUCGEg8OHYlzU8nfm4LCkccnMiaJmUNzZ7YOPbFV
 xs5/AWite0XlFn08XIJ5VZE5GZCb393I/X9ZTZ6Fv1/saDTpupYTyd0JzONvd+wz1QqigneCdk9
 zmn6PXMQ=
X-Gm-Gg: AZuq6aLxbDx2/73sRwTZ9Dvpq2Uo7xeoD+MZ3qCsQt3xXR5iQmA8tffT33VEvuDFJpx
 00AreASJ3zIUpVJzekftQnUFUTCuZ/2+VxDmyIk+W8lbrAn2f79FTJxpBccPcNzsqviVXxDSuD2
 5+pvlKDwjVyzdUrbB50yoNEinoTryGydXLH95o/goN2PfeD9k9iBJisalHTA/FQ4OYGKTFS15aR
 uHjBF19RrNfuvROCUNnk1RdKWFN7u/hEwHCvjuJzk6jXHttb/iiV/8gjxtkYn43qMyUgw2pukhc
 PKufyc3VgS76CsuTgKNirZvhWsjV5xghpSme+gu1BjxH9uhk627piNci1gVWHJmDUiR2+XCIHbJ
 JsIHznTof4igd6CcdLbf09ngxQQHcMX5YIEuVARZ0SXF84ib1GzvNo4p76l8sVGg+4BhfYwrILN
 QbCrA61JrK5/CwZnpjIIUQkJlPI/CDd97uoFAb6l2EIop3D1Tht2JJXzmcDIH4
X-Received: by 2002:a05:6000:2586:b0:435:e486:af82 with SMTP id
 ffacd0b85a97d-435f3aaf47cmr18134537f8f.45.1770067220970; 
 Mon, 02 Feb 2026 13:20:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee078sm46567200f8f.16.2026.02.02.13.20.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:20:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] Misc HW & Memory API patches for 2026-02-02
Date: Mon,  2 Feb 2026 22:20:03 +0100
Message-ID: <20260202212019.94205-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The following changes since commit 587f4a1805c83a4e1d59dd43cb14e0a834843d1d:

  python: fix msys64 wheel directory specification (2026-02-02 16:46:40 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260202

for you to fetch changes up to d8316b64dfbb4fdb706f20c3b42fd9bcf70b0cdc:

  monitor: Reduce target-specific methods (2026-02-02 22:14:51 +0100)

Ignoring this checkpatch.pl error:

  ERROR: unnecessary whitespace before a quoted newline
  #85: FILE: tests/unit/test-cutils.c:3685:
  +            "s is \n";

----------------------------------------------------------------
Misc HW & memory API patches

- Add unit test for qemu_hexdump()
- Remove legacy native endianness API uses on the Alpha target
- Remove unused memory_region_init_rom_device_nomigrate()
- Fix use-after-free in NvmeNamespace "bootindex" suffix
- Correct documentation of SCSI Rotation Rate field
- Make iotlb_to_section() work with non-CPU AddressSpaces
- Reduce few monitor target-specific methods
----------------------------------------------------------------

Akihiko Odaki (1):
  hw/nvme: Fix bootindex suffix use-after-free

Alberto Garcia (1):
  hw/ide, scsi-disk: Fix typo on the rotation_rate documentation

BALATON Zoltan (2):
  memory: Remove memory_region_init_rom_device_nomigrate()
  memory: Add internal memory_region_set_ops helper function

Jim Shu (3):
  accel/tcg: Send the CPUTLBEntryFull struct into io_prepare()
  accel/tcg: Fix iotlb_to_section() for different AddressSpace
  system/physmem: Remove the assertion of page-aligned section number

Philippe Mathieu-Daudé (8):
  target/alpha: Use explicit little-endian LD/ST API
  target/alpha: Inline translator_ldl()
  configs/targets: Forbid Alpha to use legacy native endianness APIs
  target/alpha: Replace legacy ld_phys() -> address_space_ld()
  target/i386: Include missing 'svm.h' header in 'sev.h'
  monitor: Reduce target-specific declarations
  monitor: Add hmp_cmds_for_target() helper
  monitor: Reduce target-specific methods

Vladimir Sementsov-Ogievskiy (1):
  tests/unit: add unit test for qemu_hexdump()

 docs/devel/memory.rst                         |  1 -
 configs/targets/alpha-linux-user.mak          |  2 +
 configs/targets/alpha-softmmu.mak             |  2 +
 .../memory-region-housekeeping.cocci          |  8 ---
 hw/nvme/nvme.h                                |  1 +
 include/accel/tcg/iommu.h                     | 15 -----
 include/exec/cputlb.h                         |  4 +-
 include/hw/core/cpu.h                         | 17 ++---
 include/hw/ide/ide-dev.h                      |  2 +-
 include/hw/misc/mos6522.h                     |  2 -
 include/monitor/hmp-target.h                  | 14 ----
 include/monitor/hmp.h                         | 13 ++++
 include/system/memory.h                       | 27 --------
 monitor/monitor-internal.h                    |  9 ++-
 target/i386/sev.h                             |  2 +
 accel/tcg/cputlb.c                            | 32 +++++----
 hw/i386/sgx-stub.c                            |  1 +
 hw/i386/sgx.c                                 |  1 +
 hw/nvme/ns.c                                  |  7 +-
 hw/scsi/scsi-disk.c                           |  2 +-
 monitor/hmp-cmds.c                            |  1 +
 monitor/hmp-target.c                          | 66 ++-----------------
 monitor/hmp.c                                 | 63 +++++++++++++++++-
 system/memory.c                               | 56 +++++++---------
 system/physmem.c                              | 31 ---------
 target/alpha/helper.c                         | 28 ++++----
 target/alpha/translate.c                      |  2 +-
 target/i386/cpu-apic.c                        |  1 +
 target/i386/sev-system-stub.c                 |  1 +
 target/i386/sev.c                             |  1 +
 target/m68k/monitor.c                         |  1 +
 target/riscv/monitor.c                        |  1 +
 tests/unit/test-cutils.c                      | 66 +++++++++++++++++++
 util/meson.build                              |  2 +-
 34 files changed, 239 insertions(+), 243 deletions(-)

-- 
2.52.0


