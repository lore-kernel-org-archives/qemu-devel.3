Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D694C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOJM-0004To-6k; Thu, 16 Jul 2026 11:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkOIC-00047Y-Hu; Thu, 16 Jul 2026 11:46:43 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkOIA-0002LJ-8f; Thu, 16 Jul 2026 11:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1784216787;
 bh=lxnBjrZrDTNq4MzVbyRmD6PlJvUUl0ddXfJNAsm/eAM=;
 h=From:To:Cc:Subject:Date:From;
 b=J2KW3Lk/FnJ4mLUFPbwkNw2oI0plEhlY/IkgZbwlztauLdPCHEtG187XmMXmBP9P7
 IwVavNP9J3fvY21rlTCbzoCxm1J7JgJUAnx9MKbkgRciECDf1DxejwdQYnKMXUI1pI
 /hM8wnRiw7Ky6sGnahWeTx2La1+BwPSpAvnV27UmVGCrHKdpvwAGk4Xv2yTdODsJSL
 C5JtExL06gwbdgdNxNqfzHWffIGeRc8ahJ+PgKSPl5llkNA3Vu/TW29nzf9bnV5viR
 FiqIJZ2VgCUnMEg9j9uJ1QVCNaW2McRwTqzUpbf/ShurUDzQXQn273zkyAI9pxO1j+
 riW0DeSGDSUCA==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 080EE40297;
 Thu, 16 Jul 2026 17:46:27 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 03E9EFF85D;
 Thu, 16 Jul 2026 17:46:27 +0200 (CEST)
Received: from naga.tima.u-ga.fr (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 9A7C6400E7;
 Thu, 16 Jul 2026 17:46:26 +0200 (CEST)
From: frederic.petrot@univ-grenoble-alpes.fr
To: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH v2 0/3]  Correct cbo and lq disassembly
Date: Thu, 16 Jul 2026 17:46:12 +0200
Message-ID: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
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

Change in v2: 
- Move the last v1 patch to the first place to correct the original
  indentation that was making checkpatch unhappy before doing the
  real work.
  (Note that disas/riscv.c has overall many checkpatch issues, this
  patch only solves the indentation one, but otherwise keeps the
  same "style" as the rest of the file)

Daniel, I took the liberty to keep your "Reviewed-by" tag, as only
patch order and indentation changed.

Frédéric Pétrot (3):
  disas/riscv.c: Correct indent for checkpatch
  disas/riscv.c: Correct wrong shifts for cbo
  disas/riscv.c: Correct disasm of lq

 disas/riscv.c              | 38 +++++++++++++++++++-------------------
 target/riscv/insn32.decode |  2 ++
 2 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.43.0


