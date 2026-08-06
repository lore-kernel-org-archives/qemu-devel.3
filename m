Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B298C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrtmx-0004Fj-DX; Thu, 06 Aug 2026 04:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrtmt-0004F3-8b
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 04:49:15 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrtmm-0001Mw-SJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 04:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1786006123; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=aep79KxK404UZ7b8bY7MZq5Lo+JV5Fob80bdZbwCLQE=;
 b=jxqnOkR/supWN3IYMYZhGZnyuGRT+t0EobKKpj0/xYQd0U+A/uAmhwjwl0+DmeT8IJanED4RrleJ3afY+O2Lx+sl9XnvXwv9BIS0ZBQfyjaWYGoFaxyPdaW7gbMxMVfu9UuF1GTWcI5JlxLhNZbgf/7iYHrdi3B3nxR53fT7oUk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X8TNAc4_1786006117; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8TNAc4_1786006117 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 06 Aug 2026 16:48:42 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, philmd@qualcomm.com, pbonzini@redhat.com,
 viktor.prutyanov@phystech.edu, zhengrong_li@linux.alibaba.com
Subject: [PATCH v3 0/3] elf2dmp: identify faulting CPU in Windows crash dumps
Date: Thu, 06 Aug 2026 16:47:41 +0800
Message-ID: <178600606177.41696.3160576684819885412@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

When a Windows guest crashes and QEMU generates a memory dump via
pvpanic, elf2dmp currently always sets CPU 0's context in the dump
header. This makes WinDbg default to CPU 0 when opening the dump,
even if the actual crash happened on a different CPU.

This series adds crash_occurred tracking from the runstate layer
through to the QEMUCPUState in the ELF dump, and teaches elf2dmp
to identify and use the faulting CPU's context.

Changes since v2:
   - Remove unused fault_cpu variable in fill_context()
   - Use per-CPU size check (s->size >= offsetof + sizeof) instead
     of global has_is_crash_occurred_cpu flag, fixing heterogeneous
     dumps where CPU notes have different sizes
   - Remove has_is_crash_occurred_cpu from QEMU_Elf struct and
     init_states() since per-CPU check makes it unnecessary
   - Move QEMUCPUState struct growth from patch 2 to patch 3 so
     sizeof() change and init_states() update stay together
     (bisectability)
   - Fix patch 2 commit message: remove incorrect QEMUCPUSTATE_VERSION
     bump claim
   - Clamp state->size to MIN(state->size, n_descsz) in init_states()
     to prevent reading beyond note descriptor boundary

Changes since v1:
   - Set header context before best-effort guest memory operations
     to avoid losing faulting CPU context on partial dump failures
   - Use LIVE_SYSTEM_DUMP when BugcheckCode is zero
   - Use PRIx32 for BugcheckCode format specifier
   - Use linux.alibaba.com identity

Zhengrong Li (3):
  runstate: set crash_occurred on guest crashloaded
  dump: add crash_occurred flag to QEMUCPUState
  elf2dmp: fill ContextBuffer with faulting CPU context

 contrib/elf2dmp/kdbg.h     |  9 +++++++
 contrib/elf2dmp/main.c     | 50 ++++++++++++++++++++++++++++++++++++--
 contrib/elf2dmp/qemu_elf.c |  7 ++++++
 contrib/elf2dmp/qemu_elf.h |  2 ++
 system/runstate.c          |  5 ++++
 target/i386/arch_dump.c    |  6 +++++
 6 files changed, 77 insertions(+), 2 deletions(-)

-- 
2.43.0

