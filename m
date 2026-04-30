Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71C4FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINqk-0004ac-Bn; Thu, 30 Apr 2026 05:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqg-0004Xx-Lr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqY-0002Re-FP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so424972f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541892; x=1778146692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MmDOEj12GRPvL+JBzfQAUxV+HPwRkzr7BQY5EX/ShUY=;
 b=wkUck88i6LtVge2jomAkivon0GnLwgzpjFNJNs9OdSQwyONdO31siQnLzuUcdXU/Lj
 uaD6WK9MsuQEYrb8Chj2cV7tHnNO+0xziMUiK+/6RPxS2zlwIm3cOqv9Lxms/qB32zdi
 Bb7g9HEEltKin7RQQrZglClB82bDZcM5DHvLqCf+7p0sAtjLHDuqnWFfw3PjGkM3lHEY
 BsSoDyyEew+afBvPWS2S+l9I48MJ1i+djOIs6qDQla1PU7ZSnlW4+goslX2l5OXNbvxE
 FVq+f3oqgFPRl5Ks0zMSqO3g9mOSnxmIsNYQme9OrdLieoDjshKa2536qhujPpf26hf0
 iebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541892; x=1778146692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmDOEj12GRPvL+JBzfQAUxV+HPwRkzr7BQY5EX/ShUY=;
 b=BY4aQslbf2fn1KCzKue4ZMEoStKTSLmXSHBEA6mh6cNzrACTyl58VS+aFLV+ePsZbL
 PbO5kppJ7vUAfnBeesz/WvAo1FXsi1dXQbgu1C7Zq0xYETAyZ0c4JZCpqU27PRojkFWY
 4zsth0DM8fkaXSDSKhuhJHVPhU6aG3j6/G1NDojWJ+pENflgcI8BtrLruJJ8b/SoNI2I
 edcNz3aT0wDKgGICNnMraM6rjnGbzy9iOcAEe/BgvmqhHEB4W5O6dWe7nE5Aseija5aC
 q6k/dcdoAZiwchOasAlO1MJiTHUlV7foPBbGDsi9hhi9FWY9UFOsrpxtlD3agasqGaFS
 4c6Q==
X-Gm-Message-State: AOJu0YzmYuqBhM3di5P9NTJQMCOfCykgWlmWQnbHLflAtWAe66DK/sop
 /CJVm+P0jqCCBQff2WQ0345NJB/uvHSjsH8VgCH+qy1zsSQx370Arasl7BldHDFCIKeIMNPJkvk
 dIXg3
X-Gm-Gg: AeBDietrdB/rZF5N5C2+kDoYiWJxHZiImowD3qZlkKkFkIzpSf/cM/yU6N7KhWNc5Lu
 fBgAPixbvmaqRdzwD5nAfryRrAb7zutqw5XNPiHpnG8WYIUflQrONKKjkILFKyS5v0pnKitvLoF
 sJsFX+GivPACOWaBMddM1618tSc16vQ5yH0A9lWTDQP7YDFwyLHuNZiCUn3Uhh6nma7zhHwE5GC
 0KwLZ5Xktue0yt4AZMTY1LBKkAddsWVX5LJK77h1dCPoNdMLe9qJvbrLzkWAUgWuPBkTYdcsh8d
 f8Im9PWgPtk6q7EUqLkffwpYptG4mupFHdRxE1c+9uHAd/wPeEP/PLvcd7hY/wV4ehjv93iRTDj
 O9YSQA/bXxiQxlvo38ycc0BWp9zRdwjTt1z1gmQFdVT12VHWeCUehh3nSvhoPL+7jC0WQJdBb8g
 48OhzwScg6GehSbOtTjgjzU9X6ritsBJ8ezEii7KS8smAXB7TK9MWWLk/d0iLwSlOtZ387aL6p9
 2MO/z2AYYfmzAj7z3EVWDhvv9bSCLS/Rm81RS/7BGOGjodZzGF0
X-Received: by 2002:a05:6000:40c9:b0:43d:9bb5:bda5 with SMTP id
 ffacd0b85a97d-4493ee4d4c5mr3067189f8f.40.1777541891983; 
 Thu, 30 Apr 2026 02:38:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 00/25] Handle sub-page granularity in cpu_memory_rw_debug()
Date: Thu, 30 Apr 2026 10:37:45 +0100
Message-ID: <20260430093810.2762539-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


A while back we added support for targets having memory protection at
a sub-page granularity in TCG: the target returns a CPUTLBEntryFull
with a lg_page_size field that tells TCG how big a block of memory the
translation covers. At the moment we only use this in Arm, for the
M-profile and R-profile MPU which can set protections on small regions
of memory.

However, we forgot about cpu_memory_rw_debug(), which still assumes
that translations cover target-page sized regions. It rounds the input
virtual address down to a page boundary, translates that, and then
puts the offset within the page back in again. This causes problems
for the Arm MPU case, because if the MPU is set up so that the memory
at the rounded-down address isn't within a valid region then we
incorrectly conclude that we can't read the memory at the address we
were actually asked about.
https://gitlab.com/qemu-project/qemu/-/work_items/3292 is a report of
this for the semihosting case, but it applies also to general debug
accesses.

This series fixes this by providing and using a new
cpu_translate_for_debug() function which takes a non-page-aligned
virtual address and returns all of:
 - the exact physical address for that virtual address
 - the memory attributes
 - the lg_page_size the translation is valid for

Changes in v2:
 - I noticed that I'd missed that a vapic.c callsite currently relies
   on the i386 "always return a page-aligned result" behaviour;
   patch 1 is new and makes it work with both "returns the page
   address" and "returns the exact adress"
 - fixed a TARGET_PAGE_BITS/TARGET_PAGE_SIZE mixup pointed out
   in code review
 - in the arm translate_for_debug patch, name a (preexisting) bool
   variable 'fault' rather than 'ret' to help clarify that it is
   true-on-failure
 - the last 7 patches are new, and update callers of
   cpu_get_phys_addr_debug() to use the new cpu_translate_for_debug();
   this means we can remove cpu_get_phys_addr_debug() and
   cpu_get_phys_addr_attrs_debug(), so there is only one API
   now for doing debug virt-to-phys translations

Further cleanup for once this series is accepted:
 - we could convert the 15 targets using get_phys_addr_debug and the
   two using get_phys_addr_attrs_debug to translate_for_debug, so we
   only have one CPU method for phys-to-virt translations instead of
   three

Patches 1, 18, and 19-25 need review.

thanks
-- PMM

Peter Maydell (25):
  hw/i386/vapic: Cope with non-page-aligned return from
    cpu_get_phys_page_debug()
  target/riscv: Make get_phys_page_debug handle non-page-aligned addrs
  target/alpha: Make get_phys_page_debug handle non-page-aligned addrs
  target/microblaze: Make get_phys_page_attrs_debug handle
    non-page-aligned addrs
  target/sparc: Make get_phys_page_debug handle non-page-aligned addrs
  target/x86: Make get_phys_page_attrs_debug handle non-page-aligned
    addrs
  target/s390x: Make get_phys_page_debug handle non-page-aligned addrs
  target/ppc: Make get_phys_page_debug handle non-page-aligned addrs
  target: Rename get_phys_page_debug to get_phys_addr_debug
  target: Rename cpu_get_phys_page_{,attrs_}debug
  hw/core: Update docs for get_phys_addr_{attrs_,}debug
  target/arm: Rename arm_cpu_get_phys_page()
  monitor: hmp_gva2gpa: Don't page-align cpu_get_phys_addr_debug() arg
    and return
  plugins/api.c: Trust cpu_get_phys_addr_debug() return address
  hw/core: Implement new cpu_translate_for_debug()
  hw/core: Implement cpu_get_phys_addr_attrs_debug() with
    cpu_translate_for_debug()
  target/arm: Implement translate_for_debug
  system/physmem: Use translate_for_debug() in cpu_memory_rw_debug()
  hw/i386/vapic.c: Use cpu_translate_for_debug()
  target/sparc: Use cpu_translate_for_debug()
  hw/xtensa: Use cpu_translate_for_debug()
  target/xtensa/xtensa-semi: Use cpu_translate_for_debug()
  monitor/hmp-cmds: Use cpu_translate_for_debug()
  plugins/api.c: Use cpu_translate_for_debug()
  Remove cpu_get_phys_addr_debug() and cpu_get_phys_addr_attrs_debug()

 hw/core/cpu-system.c             | 47 ++++++++++++++++++--------------
 hw/i386/vapic.c                  | 13 +++++----
 hw/xtensa/sim.c                  |  6 +++-
 hw/xtensa/xtfpga.c               |  6 +++-
 include/hw/core/cpu.h            | 40 +++++++++++++++------------
 include/hw/core/sysemu-cpu-ops.h | 39 ++++++++++++++++++++++----
 monitor/hmp-cmds.c               |  8 ++----
 plugins/api.c                    |  8 +++---
 system/physmem.c                 | 38 ++++++++++++++++----------
 target/alpha/cpu.c               |  2 +-
 target/alpha/cpu.h               |  2 +-
 target/alpha/helper.c            |  3 +-
 target/arm/cpu.c                 |  2 +-
 target/arm/cpu.h                 |  3 --
 target/arm/internals.h           |  4 +++
 target/arm/ptw.c                 | 39 +++++++++++++++-----------
 target/avr/cpu.c                 |  2 +-
 target/avr/cpu.h                 |  2 +-
 target/avr/helper.c              |  2 +-
 target/hppa/cpu.c                |  2 +-
 target/hppa/cpu.h                |  2 +-
 target/hppa/mem_helper.c         |  2 +-
 target/i386/cpu.c                |  2 +-
 target/i386/cpu.h                |  2 +-
 target/i386/helper.c             |  4 +--
 target/i386/whpx/whpx-all.c      |  2 +-
 target/loongarch/cpu-mmu.h       |  2 +-
 target/loongarch/cpu.c           |  2 +-
 target/loongarch/cpu_helper.c    |  2 +-
 target/m68k/cpu.c                |  2 +-
 target/m68k/cpu.h                |  2 +-
 target/m68k/helper.c             |  2 +-
 target/microblaze/cpu.c          |  2 +-
 target/microblaze/cpu.h          |  2 +-
 target/microblaze/helper.c       | 11 ++++----
 target/mips/cpu.c                |  2 +-
 target/mips/internal.h           |  2 +-
 target/mips/system/physaddr.c    |  2 +-
 target/or1k/cpu.c                |  2 +-
 target/or1k/cpu.h                |  2 +-
 target/or1k/mmu.c                |  2 +-
 target/ppc/cpu.h                 |  2 +-
 target/ppc/cpu_init.c            |  2 +-
 target/ppc/mmu-hash32.c          |  2 +-
 target/ppc/mmu_common.c          |  4 +--
 target/riscv/cpu.c               |  2 +-
 target/riscv/cpu.h               |  2 +-
 target/riscv/cpu_helper.c        |  4 +--
 target/rx/cpu.c                  |  2 +-
 target/rx/cpu.h                  |  2 +-
 target/rx/helper.c               |  2 +-
 target/s390x/cpu-system.c        |  2 +-
 target/s390x/helper.c            | 20 ++++----------
 target/s390x/s390x-internal.h    |  1 -
 target/sh4/cpu.c                 |  2 +-
 target/sh4/cpu.h                 |  2 +-
 target/sh4/helper.c              |  2 +-
 target/sparc/cpu.c               |  2 +-
 target/sparc/cpu.h               |  2 +-
 target/sparc/mmu_helper.c        | 23 ++++++++++++----
 target/tricore/cpu.c             |  2 +-
 target/tricore/cpu.h             |  2 +-
 target/tricore/helper.c          |  2 +-
 target/xtensa/cpu.c              |  2 +-
 target/xtensa/cpu.h              |  2 +-
 target/xtensa/mmu_helper.c       |  2 +-
 target/xtensa/xtensa-semi.c      |  9 ++++--
 67 files changed, 246 insertions(+), 176 deletions(-)

-- 
2.43.0


