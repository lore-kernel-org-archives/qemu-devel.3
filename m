Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9669F8FA9B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDyd-0008Ra-JI; Tue, 21 Apr 2026 12:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDya-0008Qu-UH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:29:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDyY-0005fB-C9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:29:27 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso2770706a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776788963; x=1777393763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fKLHNR+PvJTST4stDanwNx2v3oIgsTYeoIhN3yrPYUA=;
 b=LJB5ukNq5XUBrXy0cWP88XoFhZ8NA4GCH4wFliS5D/L9XdPgRGeVp/BrB0nOEm6dlp
 UYirzFInWu0H/hCXM/+tZ5oeHLnQsrjmDFnN6SAQSdi6Z7EboiaO2/Iqh4WzYPYTQVat
 Qqg0kjMy+0fWcNNEkH4yKpLHhXUyKYnTtrTZDsQH/9by6/x2GMKtsiXJNnoIkioGUF/c
 iytD95vJmXqm+L/fwcyXs8ZcPxbZYZ2t9lx5G0uPOPxXEFISsBACHPP1w1vJsBncOfHh
 Vtgb39fgifgcD4E92ldlP0atfZIjG0sBCbSOnl56kW2U6eU8gHkh8TuoRg2eeJienDJi
 dAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776788963; x=1777393763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKLHNR+PvJTST4stDanwNx2v3oIgsTYeoIhN3yrPYUA=;
 b=atq0mnbtiBl2I1OGLbKwvaw3gmZHxYN4S/TD3VwwA1+9IeRpNrIkprpRfdGQ1owYt2
 bjbM8s8EhhBTZifB1l0DaeV+QYPum1TtXv/YotOoVFRdzU9e3FNcFP6+sIYrVU0Yub39
 O6uaems6vbEKzwPSannctSd8p8oEv/ylArtwr6qbYVOnUpbJxkto95i/NY+EIfG6VC/7
 /nL4ZkeII47ZS1+70KcF55dvSV5JYjrgF6EHrTUpbd2aYoKBnKjLhOok4myMdqX2W1x0
 RLfVPge1A696cJMnGOkbE1MFMF4PtMDNQNCzFbnhVHJ8z28vqZlXOk8Jluj86CkCLr6k
 q7Lw==
X-Gm-Message-State: AOJu0YyM70qzIeDrOM3TNGfVSxFm38NTwhKuBL/JAev5feCLspbd7r21
 B4StKCW4afx6DcxnWpkE+yebU6czHaEmWyaqeVUGmACI9oAOfUcciWyfNYeudshTIhFvvSFnTI2
 ZucdKbwpObozThGjb8jHVgwLWs68xyrmzCSyxxZg+ntscp5dosVJ6pOskUkJUMzVBewM08N++/6
 3n6YI8jrOpcZL0V8z0oLG0YGLwi3jdI7Vt2XenTxoZ
X-Gm-Gg: AeBDietVXi7TYS0cGI1vGVLOGJIXPw4hCYA1OpOm+ognE+vz56Ku1aj0tU9EldfhJTT
 p0sJw7Mecn6QkepLIQ9rwOO9HpfmrvWYRRSYqJ5ztwK+rpft9MExzgHarCHyrveYc8Y+JVvMKSD
 XoygndJGXc/0L2UYGNXATNs89rN+A41z8LK+MdU4HYrBJLyq1+1Z5SaPS18ELNdbEduZ5JKO/ao
 lCf5MppC186yt54yCRJLV5B3SsErsk6xwi4BBQXFGQOLHNp1s/uH4Ty5fjM7P2OrToavlYVKjRf
 l9NgRC4mRqv4T9NK8sPyGCvnAIt3AtLv6mScKVGZLN2dlP0SqeIrkhIRTkaZktwAhlPv3H80Tx5
 Q6AbRrMVs6oXfNnbxywgBWx84wsIbDULoCO/7GLVXtPvU4jIv11tJrAhL+VxpvVVphKSvk8bm3i
 OsxNqYKbR0SY7Nja55B3L63z8JpdaDVJPpuctylU03bAQPVWKJNVeOVxQ=
X-Received: by 2002:a17:90b:3f47:b0:35f:bae8:3531 with SMTP id
 98e67ed59e1d1-361404a723fmr19996826a91.25.1776788962662; 
 Tue, 21 Apr 2026 09:29:22 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140ff2e1esm13529470a91.8.2026.04.21.09.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:29:22 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 0/5] Defer the IOMMU translation and support access_type
Date: Wed, 22 Apr 2026 00:29:07 +0800
Message-ID: <20260421162912.3295598-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1033.google.com
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

Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegion"

Incoming security protection devices feature more complex IOMMUMemoryRegion
implementation in the CPU path than ARM MPC device. For example,
RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
Consequently, the IOMMUMemoryRegion could return different sections for
read & write access.

To support such IOMMUMemoryRegion behavior in the CPU path, the design
of IOMMU translation must be updated:

1. address_space_translate*() must now pass the access_type to
   IOMMUMemoryRegion.
2. Since IOMMU translation results are too complex to be fully stored
   in the CPU TLB. we will defer the translation until the actual access
   occurs. Also, TLB is allowed to store the untranslated IOMMU region.

To implement deferred IOMMU translation, this patchset introduces the
following changes:

1. tlb_set_page_full() no longer translates the IOMMU region
   immediately. Instead, it stores the untranslated region directly in
   the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
   access into the slow path when a region has not yet been translated
   in the TLB entry.

2. When the CPU utilizes a TLB entry in the slow path, it should perform
   the lazy IOMMU translation of the access_type first. The resulting
   translated region and access type are stored in CPUTLBEntryFull.
   Since the slow path always performs lazy translation first, we can
   switch the CPUTLBEntryFull content to the correct access type before
   use.

3. To accelerate memory access in the fast path, lazy translation can
   update the addend of the CPUTLBEntry when translating the region to a
   host memory region. We restrict the IOMMU region to have a single
   non-zero 'addend' across all permissions. If a second 'addend' is
   present for a CPUTLBEntry, QEMU will trigger an assertion. This
   limitation is sufficient for security devices, as their "secondary"
   region is typically an IO region used to emulate device error
   handling when access is rejected.

4. To support non-slow TLB flags, lazy translation can update the TLB
   flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
   updates the flags for the permissions specified in @prot. This
   ensures that each access_type of a translated region to maintains
   independent TLB flags. For example, TLB_DIRTY of memory region will
   not be "polluted" from other permission that translated to different
   region.

Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
feature.

[1] RISC-V WG:
https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
[2] RISC-V IOPMP:
https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/

Changed since v1:
- Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
  translation until actual access in the CPU path. Provide a IOMMU
  lazy translation function with the special handling of 'addend'
  and 'addr_idx' fields of CPUTLBEntry.
- Fix the checkpatch warning.


Jim Shu (5):
  accel/tcg: Pass access_type as an argument of tlb_set_page*()
  accel/tcg: address_space_translate*() will pass the correct
    iommu_flags
  accel/tcg: Provide early AS translate function
  accel/tcg: Add IOMMU lazy translation function
  accel/tcg: Support IOMMU lazy translation in CPU TLB

 accel/tcg/cputlb.c                   | 247 +++++++++++++++++++++++++--
 include/accel/tcg/iommu.h            |  17 +-
 include/exec/cputlb.h                |  11 +-
 include/exec/tlb-flags.h             |   4 +-
 include/hw/core/cpu.h                |  15 ++
 system/physmem.c                     |  60 ++++++-
 target/alpha/helper.c                |   2 +-
 target/avr/helper.c                  |   3 +-
 target/hppa/mem_helper.c             |   1 -
 target/i386/tcg/system/excp_helper.c |   3 +-
 target/loongarch/tcg/tlb_helper.c    |   2 +-
 target/m68k/helper.c                 |  10 +-
 target/microblaze/helper.c           |   8 +-
 target/mips/tcg/system/tlb_helper.c  |   4 +-
 target/or1k/mmu.c                    |   2 +-
 target/ppc/mmu_helper.c              |   2 +-
 target/riscv/cpu_helper.c            |   2 +-
 target/rx/cpu.c                      |   3 +-
 target/s390x/tcg/excp_helper.c       |   2 +-
 target/sh4/helper.c                  |   3 +-
 target/sparc/mmu_helper.c            |   6 +-
 target/tricore/helper.c              |   2 +-
 target/xtensa/helper.c               |   3 +-
 23 files changed, 354 insertions(+), 58 deletions(-)

-- 
2.43.0


