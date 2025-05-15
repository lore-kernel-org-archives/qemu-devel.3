Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C7AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 04:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFPso-0001gu-Qg; Thu, 15 May 2025 00:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1uFPse-0001gI-UL
 for qemu-devel@nongnu.org; Thu, 15 May 2025 00:07:38 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1uFPsZ-0005Vg-Nf
 for qemu-devel@nongnu.org; Thu, 15 May 2025 00:07:36 -0400
DKIM-Signature: a=rsa-sha256; bh=lFyFs02+Y1/tCv/pAEJGfgiFFMzPEuoGtTk+IwxsSV0=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1747282045; v=1;
 b=QTFIYJxZMy59A48jEc7FV31K01eN70G7fgbifE9T9N0jF8RFiWBNmshJaeOm37Jgaty8fWRG
 7s5UYNjgEDSMYTqgPu3w2RDLbyAc6Mcrs/rx6A2VK1R5hTTd0MfD/c6z34j7B/m15FEkIhteSy8
 BpkArikG2d7w15G04etniICV838n7w2IuZ0D9mydRf63+AbHAkAaiCEo4PGObjcLn1/lU/w10TA
 xa+TyaYEj/+V75mskbtzUtK7ZBjhTjGziyZn+Lt+uwsEmnZ6jAh7qQzGFuyiSaE5bcmtzSumUrO
 Y4NAOs3pVj1yMgLJJs5EeaPbQW8yiz9VkY5bhziX1w2kQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 5B448212E8;
 Thu, 15 May 2025 04:07:25 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Thu, 15 May 2025 04:07:25 +0000
Subject: [PATCH qemu v7 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
MIME-Version: 1.0
Message-ID: <174728204531.21306.2652888415201006563-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~liuxu <liuxu@nucleisys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Zilsd extension implementation is synchronized to riscv-zilsd v1.0.

lxx (1):
  target/riscv: Add Zilsd and Zclsd extension support

 target/riscv/cpu.c                        |   4 +
 target/riscv/cpu_cfg.h                    |   2 +
 target/riscv/insn16.decode                |   8 ++
 target/riscv/insn32.decode                |  12 ++-
 target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                |  20 ++++
 target/riscv/translate.c                  |   1 +
 7 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

-- 
2.45.3

