Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69178C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdnX-00081W-Am; Fri, 07 Mar 2025 14:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tqdnK-0007yv-Ug
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:43 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tqdnI-0005hx-Ac
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:42 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 063962038F37; Fri,  7 Mar 2025 11:55:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 063962038F37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741377336;
 bh=1lrxVIx5ILPDOZouKUv407Oimopn0BzJtR6nSVKMN8w=;
 h=From:To:Cc:Subject:Date:From;
 b=lmN2qPs9OqALMu107Rw7SWqSOmhZ5JOlxqmIc1VHXKd3NIr/zHmYYMyF1/5Tink/9
 C8uGssJKBWaEH2fxwlj0lRErPEDNi7zvhZlyTm2kBVf9okDDynf3RRTIi5knOkSybA
 z9q6sOkvgYvPp1o362A9VYM+Co03SzOup5PcPw44=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [PATCH v2 00/14] Factor out HVF's instruction emulator
Date: Fri,  7 Mar 2025 11:55:11 -0800
Message-Id: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi,

Microsoft's Linux Systems Group developed a Linux driver for the Microsoft
Hypervisor (MSHV for short). The driver is being upstreamed. The first
supported VMM is Cloud Hypervisor. We want to add QEMU as the second supported
VMM.

The plan is to write an mshv accelerator in QEMU. The accelerator is still in
the works.

MSHV doesn't emulate instructions. VMMs are supposed to bring their own
instruction emulator. The path we've chosen is to reuse what's already in QEMU.
The instruction emulator in HVF looks good for what we need.

This patch series makes the instruction emulator in HVF a common
component for the i386 target. It removes HVF specific code by using a
set of hooks. The new incoming MSHV accelerator will implement the
hooks, and where necessary, enhance the emulator and / or add new hooks.

The patches have been lightly tested by running a Linux VM on an Intel-based
Mac. 

Thanks,
Wei.

Changes in v2:
1. Address comments from Paolo on variable and directory names.
2. Rebase and drop the already applied patches.
3. Add a new entry in MAINTAINERS.

Wei Liu (14):
  target/i386/hvf: introduce x86_emul_ops
  target/i386/hvf: remove HVF specific calls from x86_decode.c
  target/i386/hvf: provide and use handle_io in emul_ops
  target/i386: rename hvf_mmio_buf to emu_mmio_buf
  target/i386/hvf: use emul_ops->read_mem in x86_emu.c
  taret/i386/hvf: provide and use write_mem in emul_ops
  target/i386/hvf: provide and use simulate_{wrmsr,rdmsr} in emul_ops
  target/i386: rename lazy flags field and its type
  target/i386/hvf: drop unused headers
  target/i386/hvf: rename some include guards
  target/i386: add a directory for x86 instruction emulator
  target/i386/emulate: add a panic.h
  target/i386: move x86 instruction emulator out of hvf
  MAINTAINERS: add an entry for the x86 instruction emulator

 MAINTAINERS                               |  8 +++
 target/i386/cpu.h                         |  8 +--
 target/i386/emulate/meson.build           |  5 ++
 target/i386/emulate/panic.h               | 45 ++++++++++++++++
 target/i386/{hvf => emulate}/x86.h        |  4 +-
 target/i386/{hvf => emulate}/x86_decode.c | 22 +++-----
 target/i386/{hvf => emulate}/x86_decode.h |  4 +-
 target/i386/{hvf => emulate}/x86_emu.c    | 62 +++++++++++------------
 target/i386/{hvf => emulate}/x86_emu.h    | 15 +++++-
 target/i386/{hvf => emulate}/x86_flags.c  | 56 ++++++++++----------
 target/i386/{hvf => emulate}/x86_flags.h  |  6 +--
 target/i386/hvf/hvf-i386.h                |  4 +-
 target/i386/hvf/hvf.c                     | 57 +++++++++++++++------
 target/i386/hvf/meson.build               |  3 --
 target/i386/hvf/vmx.h                     |  2 +-
 target/i386/hvf/x86.c                     |  4 +-
 target/i386/hvf/x86_cpuid.c               |  2 +-
 target/i386/hvf/x86_descr.h               |  2 +-
 target/i386/hvf/x86_mmu.c                 |  2 +-
 target/i386/hvf/x86_task.c                |  6 +--
 target/i386/hvf/x86hvf.c                  |  2 +-
 target/i386/meson.build                   |  1 +
 22 files changed, 203 insertions(+), 117 deletions(-)
 create mode 100644 target/i386/emulate/meson.build
 create mode 100644 target/i386/emulate/panic.h
 rename target/i386/{hvf => emulate}/x86.h (99%)
 rename target/i386/{hvf => emulate}/x86_decode.c (99%)
 rename target/i386/{hvf => emulate}/x86_decode.h (99%)
 rename target/i386/{hvf => emulate}/x86_emu.c (95%)
 rename target/i386/{hvf => emulate}/x86_emu.h (75%)
 rename target/i386/{hvf => emulate}/x86_flags.c (83%)
 rename target/i386/{hvf => emulate}/x86_flags.h (97%)

-- 
2.47.2


