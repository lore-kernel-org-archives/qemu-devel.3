Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CCECA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 10:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUGU-0005X8-LE; Mon, 25 Aug 2025 06:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1uqUGS-0005Wq-K0
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:17:24 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1uqUGL-0004Jy-Pz
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:17:24 -0400
DKIM-Signature: a=rsa-sha256; bh=nDx7bVMd0eTVldIaNY7XJqT8uz6mV1pWHKkcLj3JKLg=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1756117029; v=1;
 b=AORK1iUsXVv2af9aBxo2F4Z0nwIRicrTKtUgWmv2ujQTo/CYPlFP4qBIQGIn9DJIMmIYk8i8
 ysJx3TkU7HmgGL97iR25B8bvLVqKXBOkpJD1i9V5Og3MaO74+182dR7eIT6gBCeEr2fjFQhUvwD
 eZLWzXLq+L0/D15KNpdwwN/BeBojozLC8XlaeRbBrhdCXCKqnb0JMZ1DDL6Zmikcq1EcofYId/+
 UUYsuFp9dPXNYJafB77Qs26D8jW4KU3egzdYML9f2GD5FXRSmY5U1yhsqKtYvPt/+y0gtzqjrO7
 H1VmRF1okbLnZKUpD0DYZDydron1bYYJpsGk1BB5ASVdg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id D5A6B231FF;
 Mon, 25 Aug 2025 10:17:09 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Mon, 25 Aug 2025 10:17:09 +0000
Subject: [PATCH qemu v10 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
MIME-Version: 1.0
Message-ID: <175611702979.27776.8893001401121570723-0@git.sr.ht>
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

This version has completely fixed the conflict between Zclsd and C&F
under linux-user. The specific reason is that Zilsd will imply Zclsd, so
it also needs to be disabled for the "max" CPU. The local test was also
successful.

lxx (1):
  target/riscv: Add Zilsd and Zclsd extension support

 target/riscv/cpu.c                        |   4 +
 target/riscv/cpu_cfg_fields.h.inc         |   2 +
 target/riscv/insn16.decode                |   8 ++
 target/riscv/insn32.decode                |  12 ++-
 target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                |  33 +++++++
 target/riscv/translate.c                  |   1 +
 7 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

-- 
2.49.1

