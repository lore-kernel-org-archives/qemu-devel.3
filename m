Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6043C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4xn-0003zH-3z; Wed, 15 Jul 2026 15:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wk4xW-0003iv-6n; Wed, 15 Jul 2026 15:07:55 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wk4xS-0001nw-7V; Wed, 15 Jul 2026 15:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1784142461;
 bh=kDq4h/6EOPW7FyQ5cFgBeyyIzyzvkpfCV+CV6p1+2ms=;
 h=From:To:Cc:Subject:Date:From;
 b=p1gSAe4p4KGIEotEpNP4d/X6eJ0/uYgxZhCDZh1l+O23lCUiUbU+QdDuEnHkIeHy0
 3SkJ6P0zEydffd7V0AiltNBnjy+HpE0PDGz/lNdGX50kh/eugXb0eNZv3nE8q0OMHj
 rDShsAerYtFurAjQQXqeDfC6FhXJKBLrxn7ezOBktzVFA+ix0yBNyUSbUq0eK3LF1l
 rpyvSAGmzTLgJRd+XbtwpK64iI/6zCxANTVdSYcUQ66x2Tq5ALTOYxqKcgKd2RVjxK
 VwKo8jKIItjLPd/MRg6ZeyNK3talJIcOFtsDRA4MEw/jB/85tyFJzxjGscVBHSUGNy
 d4jLeZ8ZhKPGA==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id F0AC140215;
 Wed, 15 Jul 2026 21:07:41 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id EC2E4FF85F;
 Wed, 15 Jul 2026 21:07:41 +0200 (CEST)
Received: from naga.. (unknown [78.243.103.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id BB795400E7;
 Wed, 15 Jul 2026 21:07:40 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH 0/3] Correct cbo and lq disassembly
Date: Wed, 15 Jul 2026 21:07:34 +0200
Message-ID: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

The CBO instructions were, AFAIU, disassembled erroneously.
In addition, lq (load-quad, a RV128 instruction) shares the same
opcode space as the CBOs, which also led to incorrect dasm for that
instruction (understandable since RV128 is an experimental feature).
To avoid overlaps, we now require that lq is decoded only if
rd is not 0, as CBO requires the field corresponding to rd to be zero,
both in dasm and decodetree.
The last patch corrects the original indentation that was making
checkpatch unhappy.

Frédéric Pétrot (3):
  disas/riscv.c: Correct wrong shifts for cbo
  disas/riscv.c: Correct disasm of lq
  disas/riscv.c: Correct indent for checkpatch

 disas/riscv.c              | 38 +++++++++++++++++++-------------------
 target/riscv/insn32.decode |  2 ++
 2 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.43.0


