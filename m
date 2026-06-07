Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A598ECD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWE6f-0004IX-NY; Sun, 07 Jun 2026 10:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6e-0004IC-Mt
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:04 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6d-0007wr-23
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:04 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A83F1444A1;
 Sun,  7 Jun 2026 14:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B5A1F00893;
 Sun,  7 Jun 2026 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841040;
 bh=Ehewi21KCB8+ZvN7wBtsAhDnIzIFLGUR7xeLDo5MqXM=;
 h=From:To:Cc:Subject:Date;
 b=CHKKOb4OxQbuA06ADmkDYF8xWExP4I1asyoa7nOoIKGXIUF5Mohu9YJSpZaXy9dvC
 BlSe37Druue5nAREloC3LuBsrkC5mmBETG614CBZP+hGERC0+B3/a5XA4IcVZ/FEUr
 a1N+lcMpkJu8y7kqzYLgF42vTQlg6fh/kRTIxwnkCTwEGVWX1/h7VIs9sFentVvdIR
 zogX+/itAKBfC61MPq0vzE7E768Nl9JvsnTxWfZYFJorlnBbdQbcPPAWwPGHn/Bhqf
 1hsCqCHM4mj9FVTB7kjQzUJliY//zyndFAUt2YFqq1PcPYksA4phhfe0U8G6CY63zE
 p5yP1Pk5H0fxQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 00/10] linux-user patches for alpha, sparc, sh4 and xtensa
Date: Sun,  7 Jun 2026 16:03:46 +0200
Message-ID: <20260607140356.10702-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Various linux-user related patches from Matt Turner with coredump support for
alpha and sparc, as well as some fixes for the signal handler in sparc and
xtensa.

The patches from Xinhui Yang add the missing fsmount series syscalls support
for systemd.

Especially the sparc and xtensa patches would benefit from a review, as I'm not an
expert in those architectures.

Matt Turner (8):
  linux-user/alpha: add coredump support
  linux-user/sparc: add coredump support
  linux-user/sparc: restore L/I registers from RSA in
    sparc64_set_context
  linux-user/sparc: call block_signals() before set_sigmask() in
    setcontext
  linux-user/sparc: flush register windows before core dump
  target/sh4: decode_gusa: recognize add#imm with prior mov Rm, Rn
  linux-user/xtensa: restore FP rounding mode on sigreturn
  target/xtensa: add cpu_set_fcr/fsr helpers to sync fp_status

Xinhui Yang (2):
  linux-user: implement fsmount(2) series of syscalls
  linux-user/strace: add fsmount series of syscalls

 linux-user/alpha/elfload.c    |  12 ++++
 linux-user/alpha/target_elf.h |  13 +++++
 linux-user/elfload.c          |   9 +++
 linux-user/sparc/cpu_loop.c   |   3 +-
 linux-user/sparc/cpu_loop.h   |   7 +++
 linux-user/sparc/elfload.c    |  54 +++++++++++++++++
 linux-user/sparc/signal.c     |  27 +++++++++
 linux-user/sparc/target_elf.h |  20 +++++++
 linux-user/strace.c           | 105 ++++++++++++++++++++++++++++++++++
 linux-user/strace.list        |  15 +++++
 linux-user/syscall.c          |  91 +++++++++++++++++++++++++++++
 linux-user/xtensa/signal.c    |  36 ++++++++++--
 target/sh4/translate.c        |   2 +-
 target/xtensa/cpu.h           |   4 ++
 target/xtensa/fpu_helper.c    |  42 ++++++++++++++
 15 files changed, 433 insertions(+), 7 deletions(-)
 create mode 100644 linux-user/sparc/cpu_loop.h

-- 
2.54.0


