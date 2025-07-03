Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B55C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 18:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXObN-0003nl-ES; Thu, 03 Jul 2025 14:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charmitro@posteo.net>)
 id 1uXObH-0003mW-NY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 14:24:00 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charmitro@posteo.net>)
 id 1uXObD-0007mC-30
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 14:23:59 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id B6574240103
 for <qemu-devel@nongnu.org>; Thu,  3 Jul 2025 20:23:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
 s=1984.ea087b; t=1751567028;
 bh=UUOaQIyt7794NUXeIiWvZBsaq8OcvNwQqqrdLwN4TRo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=YyqRKa6n5QdH633djdT1lCHRfnt32VTntfLRQcGfVcYEy5T21FGbVbdlUDofJPnZC
 OmS8TTnWQ9L81F3zfPU+edFAlTtA3PDgj1j3ScjT7LOSSuny8tjQlrXkfRniXigWX4
 YyBwz9KjsNJfMM94eFudnPpPmEDGCRceQE+Sb0Ql3KF9ERJ2I5A2CkGtc4w2/FpJrS
 8VmzGwlQkV8HsQJ51CtsvGlS4nkvzjU3oKCcpxfkOjvDjrB+8pm5nFBoLNisyvmtMr
 hKIK46uzAXESJCY5TZXcbHKGoUoVGbtHLLxwB38aQvRZlLZ3CJCvPcFwOTupRSA7xU
 HAPE91R39bgSBIu1IyJIoJXXIqve46m4hxYozw84G1hzVQy+l02sxjwhy+ZLmcaPGx
 H75cz/A1Fh0dhcUwZDbGrBkrgI+3jkVQfQY/tkRuoOFP3iQPjIC14zPtNt/gUB+bET
 XNIbfw5lqUzk5U2Eu/9lz3j4gtoJYhuxP7XsVFIi9Sz1AXQesb8
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4bY4sH1DnXz6tvZ;
 Thu,  3 Jul 2025 20:23:46 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 0/2] target/riscv: Fix MEPC/SEPC bit masking
Date: Thu,  3 Jul 2025 18:21:42 +0000
Message-ID: <20250703182157.281320-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=charmitro@posteo.net;
 helo=mout02.posteo.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch series fixes incorrect behavior in MEPC/SEPC CSRs where the
lower bits were not properly masked according to the RISC-V specification.

The issue was discovered when vectored mode bits from STVEC were
written to MEPC and not properly cleared, causing incorrect behavior
on MRET.

Charalampos Mitrodimas (2):
  target/riscv: Fix MEPC/SEPC bit masking for IALIGN
  tests/tcg/riscv64: Add test for MEPC bit masking

 target/riscv/csr.c                        |  8 +--
 target/riscv/internals.h                  | 11 ++++
 target/riscv/op_helper.c                  |  4 +-
 tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
 tests/tcg/riscv64/test-mepc-masking.S     | 73 +++++++++++++++++++++++
 5 files changed, 94 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-mepc-masking.S

-- 
2.47.2


