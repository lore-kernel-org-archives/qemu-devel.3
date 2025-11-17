Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D84CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2kZ-0003FS-Do; Mon, 17 Nov 2025 12:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>) id 1vL2kS-0002zn-3u
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:10:40 -0500
Received: from mlugg.co.uk ([104.238.170.239] helo=mail.mlugg.co.uk)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>) id 1vL2kD-0006FC-0l
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:10:27 -0500
Received: from localhost.localdomain
 (3.c.0.2.2.e.e.a.9.8.5.7.2.1.b.b.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:bb12:7589:aee2:20c3])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id C77A2359B5;
 Mon, 17 Nov 2025 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1763399421; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=vQaPbsDya+DT/xQXtMXTu2BCH23a7jXmjkrd5R6uwCw=;
 b=G8iHb9IQ/TJ1QBEQaAvpPkBum2CEll00al+AgAKamcolkiaXZCy7yFb9+eGd79c+zuNzhr
 k3d+x40ZxgI64FKazzyOP4jynNvICyrAYK2Ad8Gzg6EwoaiwQ/PmU+doqzjWp/dIZ8MI3X
 l+bUE5dm44kQ+CibmkAQmXor8mizDt8=
From: Matthew Lugg <mlugg@mlugg.co.uk>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org,
 Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PATCH v2 0/4] linux-user: fix several mremap bugs
Date: Mon, 17 Nov 2025 17:09:50 +0000
Message-ID: <20251117170954.31451-1-mlugg@mlugg.co.uk>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.238.170.239; envelope-from=mlugg@mlugg.co.uk;
 helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This version of the series should address all feedback I received. The original
cover letter is replicated below.

I was recently debugging a strange crash in a downstream project which turned
out to be a QEMU bug related to the `mremap` implementation in linux-user. In
practice, this bug essentially led to arbitrary memory regions being unmapped
when a 32-bit guest, running on a 64-bit host, uses `mremap` to shrink a memory
mapping.

The first patch in this set resolves that bug. Since the patch is very simple,
and the bug is quite likely to be hit, I suspect that that commit is a good
candidate for qemu-stable.

The following two patches just resolve two more bugs I became aware of whilst
working on this code. I believe the messages in those patches contain all
necessary context. They are less critical and the fixes more complex, so are
likely not suitable for backporting into qemu-stable.

The final commits adds tcg tests for the fixed `mremap` behavior. The third fix
is unfortunately difficult to test programmatically, but I have confirmed that
it behaves as expected by observing the output of `strace qemu-i386 repro`,
where `repro` is the following C program:

    #define _GNU_SOURCE
    #include <stddef.h>
    #include <sys/mman.h>
    int main(void) {
        char *a = mmap(NULL, 4097, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        char *b = mmap(NULL, 4097, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        mremap(b, 4097, 4097, MREMAP_FIXED | MREMAP_MAYMOVE, a);
        // QEMU has now leaked a page of its memory reservation!
        return 0;
    }

Prior to the patch, as the comment says, QEMU leaks a page of its address space
reservation (i.e. the page becomes unmapped). After the patch, QEMU correctly
reclaims that page with `mmap`.

Matthew Lugg (4):
  linux-user: fix mremap unmapping adjacent region
  linux-user: fix mremap errors for invalid ranges
  linux-user: fix reserved_va page leak in do_munmap
  tests: add tcg coverage for fixed mremap bugs

 linux-user/mmap.c               | 16 ++++++++-----
 tests/tcg/multiarch/test-mmap.c | 42 +++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 8 deletions(-)

-- 
2.51.2


