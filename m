Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81424C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 03:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS71g-0000oX-Az; Thu, 11 Jul 2024 23:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sS71Z-0000nd-EG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 23:32:45 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sS71X-00039d-3u
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 23:32:45 -0400
DKIM-Signature: a=rsa-sha256; bh=qu7QkQBBgWV1ZwidtAMD5sMHyU0gwg48o+DJysHjs0A=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1720755160; v=1;
 b=IxFiD/AjyeP90+fOFrcDyaXiBmVhS7K8xqNNoNEz/BzLv8yDeUAA+f8dSjzgKWIfEgrPsA9+
 /eyvn6SfxwXl3McSyY6Z+8qrnikw+8oCu91GzkN5TMVvyCCQ6DuLgx+OPmp6WXTJUEp+TT3q795
 5DIugTTqA/xeno25c/Q453CVL+GLdNwtypx9Qll25MA/0/5ZpEeBZEkrjm8wCBTE3lB6iaV36+2
 1sOZ2k8BmTeXu5CiJT/Z9vV9FGO3Qc6CzLETVZs9Bq789bpvnoElvpjAAJ8nkX7Rk+VtyxbNFag
 ht3+E9yA0UQapDSboCGvF96phlRtFYu7z3YlC5xb3dEHg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 1D68F20333;
 Fri, 12 Jul 2024 03:32:40 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Fri, 12 Jul 2024 03:32:39 +0000
Subject: [PATCH qemu v2 0/1] target/riscv: Add Zilsd and Zcmlsd extension
 support
MIME-Version: 1.0
Message-ID: <172075515999.22382.15550760745449625636-0@git.sr.ht>
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
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

In this version of the patch:
1. Adjusted the code formatting issue
2. Optimize the processing of all instructions

lxx (1):
  target/riscv: Add Zilsd and Zcmlsd extension support

 target/riscv/cpu.c                         |  4 +
 target/riscv/cpu_cfg.h                     |  2 +
 target/riscv/insn16.decode                 |  8 ++
 target/riscv/insn32.decode                 | 12 ++-
 target/riscv/insn_trans/trans_zcmlsd.c.inc | 91 +++++++++++++++++++++
 target/riscv/insn_trans/trans_zilsd.c.inc  | 94 ++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                 | 13 +++
 target/riscv/translate.c                   |  2 +
 8 files changed, 224 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zcmlsd.c.inc
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

-- 
2.43.4

