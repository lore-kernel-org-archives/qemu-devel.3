Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D0FC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdRZ-0006lj-Hs; Tue, 02 Jul 2024 09:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sOZMF-00039x-CX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:59:27 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sOZMC-00031u-NI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:59:27 -0400
DKIM-Signature: a=rsa-sha256; bh=mEGW3zrj49GaT65o0XzYSCHp7FouVrzSmQgohB7oG8I=; 
 c=simple/simple; d=git.sr.ht; h=From:Date:Subject:Reply-to:To;
 q=dns/txt; s=20240113; t=1719910755; v=1;
 b=GsWhfxUQgQ2t4+jiLJnq2XfyGuqxKznkkzWdCVixYiidJ7332T/l/NHGBedjPAd1KVtwEQxG
 Suquix6TnwLknbcD7HfMmH1jen3Fgob5ZEBYbKSQRKjR4xJO0d14/lkKYxBGllr94p+CdNpCZnB
 hLOGeiMMiwwFsvwDwVrTxyTEqoM+qPG7BUn3KU77ARjD4g14r2SL3Zn3izlyXDx+NMcxE/ZW3g9
 yemm07lAkzCDUW5ycKJMuXHtT26Ee6fmfRIUUGP+2z5v8+W/86BGcCMRCiG0XhsOy1544fV43iI
 VnN5kNp3kpD0BmWrvnbBL+capnKe/0i/LZ4Pvs6vpAoKw==
Received: from git.sr.ht (unknown [IPv6:2a03:6000:1813:1337::155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 0610620151
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2024 08:59:15 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Tue, 02 Jul 2024 08:59:14 +0000
Subject: [PATCH qemu 0/1] target/riscv: Add Zilsd and Zcmlsd extension support
MIME-Version: 1.0
Message-ID: <171991075495.29791.18431108398571296272-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jul 2024 09:21:07 -0400
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

This patch adds support for the Zilsd and Zcmlsd extension,
which is documented at https://github.com/riscv/riscv-
zilsd/releases/tag/v0.9.0

lxx (1):
  target/riscv: Add Zilsd and Zcmlsd extension support

 target/riscv/cpu.c                         |  4 +
 target/riscv/cpu_cfg.h                     |  2 +
 target/riscv/insn16.decode                 |  8 ++
 target/riscv/insn32.decode                 | 12 ++-
 target/riscv/insn_trans/trans_zcmlsd.c.inc | 98 ++++++++++++++++++++++
 target/riscv/insn_trans/trans_zilsd.c.inc  | 97 +++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                 | 13 +++
 target/riscv/translate.c                   |  2 +
 8 files changed, 234 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zcmlsd.c.inc
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

-- 
2.43.4

