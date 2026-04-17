Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E328F436BF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn2x-0007Cg-Ih; Fri, 17 Apr 2026 13:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2A-0006im-SF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn26-0001x7-1v
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so8715695e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447068; x=1777051868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4/W82uiyT+afBorDkCWoN1foEc6B52fL1ZLzDNDfnx0=;
 b=lMYbkDNgyc47x32M628ZZVAzTEOa8SJwVuI2HhVwCGi4yFFZvZ+Md7ZaL6dJHb0UkB
 1gka3l+CpIeQODkJOrfeK14itQGKuKHtEO32CCaW0lC3QuRgjsu0abS/SLm3PEnRniST
 +0uhlk7ua3BOhpKdeSbb3wHrsYL2sJoPRvzK0irZp4ygt+g/25R2ugh6kkfW68Iu5wb0
 xXIhu4rYbrY8XRLuTdhW3GH687S9uXLNPiZ6MoDrsC78WmLo46h9ijST1ORcdHrDrdIW
 2FtTScp5NEobEly1zOH3RgA4WoD/D53qwyt27cCrt3dwKCO8/aiHGEEZ16f2ublI3Eth
 cxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447068; x=1777051868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/W82uiyT+afBorDkCWoN1foEc6B52fL1ZLzDNDfnx0=;
 b=bKugucPfckqymuksRHhDy0sbQvNHeVve5jCrz3dqo0POpcnD6apY9wj8IFWeavgqkK
 qhLZ39aSS5nbw6csI27gRNnUa08Ckk1zRjoJT3sou2nzssQmzKVHJN7FU86WmYNJAvXb
 TvpzoiRkhQWLVKhQKJF86CaGbP5WK3FYPP3DqUL7yscEwEdfIIYf3noclDivmuej+mlN
 pdDPWwW3AwiyAQeAaN3gtIppH8KNJpuVwaBmUOh0ZrAz+GiRkS8VaeucpX8aHi9/yYeW
 /ghAUzRAn23gAi++xb5IaEAuBF+DZvoWek0XTgkBzrehJHwlyu/MqnOVgr7eMAkA3m5H
 FXog==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Y5wadbLAJfZ24m5Hk9af0Opujcl0owYhfpIl4FYn9hh/CivXxm8X2HPv065aLcbA/jhtIj67yOJ7o@nongnu.org
X-Gm-Message-State: AOJu0YyPucj1jUM8/YopoIvH2VZicMzG7T/LavK8q2ziKUcV4Qqkx9rH
 IMcSunyOQoGTYtygE79wUOChv2wagWT1STkjV9OxXbj0vQhNku4+du+XN1Q9F57d9xM=
X-Gm-Gg: AeBDiev/0TmU1jlihhgXx7XyD/SZ27zmV9Wc12y4czTRmqQnv2p/T1V/i88mc24xM74
 75311g1YfioB5/HNzLBAo7f3fsVslo+0hWTdf+X3v8oV+jlfAYLC56PpniCl52igBL1yGBug+wE
 5+fsOWhmw0ozVaxjHdSfdvx+Y0A9Z5hYN2gVBUWomOyOBRkSHdVmOvCe2IWWSp2nRRk1zCJPOlx
 x/4rJG8VwX3/SbgNcrATfclqZ0VvE3GFNQQbFOGz9ntldgIgLePQZZvYA0jdC8D1DIM9THFPFBw
 YEZNribZm/t7OtTXS5GWDTfS1k7SypAT0dHblNfpljvVXfgb655Z1NQrXMJtDgj+K+ZdW2D05MI
 eR+4pJOjxsOOyQJYs0gGPg5ro3kQW9xZpVaSAusSGy5s3shsCm0NNWR40nKQglPiQ5XaArEapR0
 LVbE8CP3+Zgz8vpAKFjMmrIULNbN3+UUhlNi/fQu+GW9loHfw5VWy5HLShUqLs6ItIuTzb8PuS3
 RvS8940ghDJ2Vh5+4Tw3GBU+GfWzCX0dXAWy39PzA==
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-488fb784843mr41389655e9.24.1776447067968; 
 Fri, 17 Apr 2026 10:31:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
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
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 00/17] Handle sub-page granularity in cpu_memory_rw_debug()
Date: Fri, 17 Apr 2026 18:30:48 +0100
Message-ID: <20260417173105.1648172-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

To get there, the series starts off by fixing an inconsistency in our
current get_phys_page_debug and get_phys_page_attrs_debug
implementations: most of them can handle non-page-aligned addresses
and return the corresponding non-page-aligned physical address, but
some cannot. As a result most callers need to work around this by
putting the page-offset bits back into the result. The first seven
patches fix the targets which weren't accepting and returning
non-page-aligned addresses (riscv, alpha, microblaze, sparc, x86,
s390x, ppc).

At that point, the "page" in the function names is misleading, so we
rename them to get_phys_addr_debug and get_phys_addr_attrs_debug.
Then we can remove the workarounds in callsits in the monitor and
plugins.

Once all that is complete, we can implement our new
cpu_translate_for_debug(), either with a new translate_for_debug
method provided by the CPU, or falling back to using
get_phys_addr_attrs_debug or get_phys_addr_debug for CPUs where
protections are still page sized. Finally we can rewrite
cpu_memory_rw_debug() to use it.

There is potentially some followup cleanup we could do:
 - the only caller of cpu_get_phys_addr_attrs_debug() now is
   cpu_get_phys_addr_debug() so we could make the latter
   directly call cpu_translate_for_debug()
 - more ambitiously, we could make the 10 callers of
   cpu_get_phys_addr_debug() use cpu_translate_for_debug(),
   so we only have one function for phys-to-virt translations
   instead of three
 - even more ambitious would be to convert the 15 targets
   using get_phys_addr_debug and the two using
   get_phys_addr_attrs_debug to translate_for_debug, so
   we only have one CPU method for phys-to-virt translations
   instead of three

But I thought this was a good place to stop and get feedback on
whether I have the right API for things first, and it does fix the
reported bug.

thanks
-- PMM

Peter Maydell (17):
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

 hw/core/cpu-system.c             | 57 +++++++++++++++++++++++---------
 hw/i386/vapic.c                  |  4 +--
 hw/xtensa/sim.c                  |  2 +-
 hw/xtensa/xtfpga.c               |  2 +-
 include/hw/core/cpu.h            | 56 ++++++++++++++++++++++++++-----
 include/hw/core/sysemu-cpu-ops.h | 39 ++++++++++++++++++----
 monitor/hmp-cmds.c               |  5 ++-
 plugins/api.c                    |  4 +--
 system/physmem.c                 | 38 +++++++++++++--------
 target/alpha/cpu.c               |  2 +-
 target/alpha/cpu.h               |  2 +-
 target/alpha/helper.c            |  3 +-
 target/arm/cpu.c                 |  2 +-
 target/arm/cpu.h                 |  3 --
 target/arm/internals.h           |  4 +++
 target/arm/ptw.c                 | 37 ++++++++++++---------
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
 target/microblaze/helper.c       | 11 +++---
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
 target/s390x/helper.c            | 20 +++--------
 target/s390x/s390x-internal.h    |  1 -
 target/sh4/cpu.c                 |  2 +-
 target/sh4/cpu.h                 |  2 +-
 target/sh4/helper.c              |  2 +-
 target/sparc/cpu.c               |  2 +-
 target/sparc/cpu.h               |  2 +-
 target/sparc/mmu_helper.c        | 10 +++---
 target/tricore/cpu.c             |  2 +-
 target/tricore/cpu.h             |  2 +-
 target/tricore/helper.c          |  2 +-
 target/xtensa/cpu.c              |  2 +-
 target/xtensa/cpu.h              |  2 +-
 target/xtensa/mmu_helper.c       |  2 +-
 target/xtensa/xtensa-semi.c      |  2 +-
 67 files changed, 250 insertions(+), 152 deletions(-)

-- 
2.43.0


