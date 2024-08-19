Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0CDC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 08:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfxka-0004M9-CK; Mon, 19 Aug 2024 04:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sfxif-0003xP-IF
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 04:26:29 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sfxiW-0002hK-36
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 04:26:28 -0400
DKIM-Signature: a=rsa-sha256; bh=F1rH6AHXtrLLIuOcbxKCtt5Q5I5A79OHGK++yBaEZzI=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1724055972; v=1;
 b=cmbdG9GaKfQ3vuWvciMY9CNtLGxSv4J98jMiUeE0XDbR1jyAxT3Py0h/KllacsROfp71i1Ih
 Knzx9XQM14nt4sHFwK41ACM/U6NKt1tSIeSurJdmBQEQV0FD7UF9/NvDZAMGWLfpw+cYgwtLFr/
 gNQvfu8qmFiqfu2Af1XcAmssE2v1zSYRgtdS7B2hmh9ymcxqUInpRtd+sFNwLKeiTLZzwcuY0WG
 cmtqdzCKHhN/Ga4siR/O2m4EHePci2Ew9oK12csWyGQT+2idHk+EUDMYf/GPcOSJe55XQoAeTqL
 zCU6L9zZG5UAmyCpizsClUTy4z6nf2hXHpOtaY/R0espg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id B892D2012C;
 Mon, 19 Aug 2024 08:26:12 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Mon, 19 Aug 2024 08:26:12 +0000
Subject: [PATCH qemu v5 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
MIME-Version: 1.0
Message-ID: <172405597271.16131.17500975829010964500-0@git.sr.ht>
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
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Fix for the last reply:
https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg02469.html

lxx (1):
  target/riscv: Add Zilsd and Zclsd extension support

 target/riscv/cpu.c                        |   4 +
 target/riscv/cpu_cfg.h                    |   2 +
 target/riscv/insn16.decode                |   8 ++
 target/riscv/insn32.decode                |  12 ++-
 target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                |  16 ++++
 target/riscv/translate.c                  |   1 +
 7 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

-- 
2.45.2

