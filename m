Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71F2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 10:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMPh-0007c8-Dk; Fri, 09 Aug 2024 06:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1scMPe-0007Sn-FQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:59:58 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1scMPc-0003s5-7T
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:59:58 -0400
DKIM-Signature: a=rsa-sha256; bh=tPsTq3WGy20rQIS7BVX6/z4aEWuG3HSFQNiZvODi+7w=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1723197592; v=1;
 b=DyEVrfnlySehPAoi2VemqbTQqymY9rLDEBCZBffzHeywR+uLCx8m5QGBRRaCoqngsV1kNBAy
 YkMrhbnYL45QgGdl6gub4C6SBZFGBfv5pvhIVvtTphGCQ8r2SIrwKttfcdCrxjYw+ZmWnEXnkfw
 waciqi6UndPbXTv1+WVZ0sn4Ud8JJyGvtIa4yhvAQcYHAVhdb+UxEL8Jo2q2hiyJv2FMExdBeBJ
 CFbu0WbhjTpOvP92APFBXJAj2u7kOoF3hJyziTgfWux/DYlL5Yjzw5cfn9hcR2WIL/4otqFyela
 TFGFbzPTiMHcpuP/b9MTiPM9miZLQMwPk7QPG1/cNPVpg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 688052031F;
 Fri, 09 Aug 2024 09:59:52 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Fri, 09 Aug 2024 09:59:52 +0000
Subject: [PATCH qemu v3 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
MIME-Version: 1.0
Message-ID: <172319759236.18926.5462684264176580538-0@git.sr.ht>
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

Thanks for your previous reply.

Here are some explanations for the previous questions:
1. In the previous version, the 'int flag' was used to distinguish
whether an instruction was 'ld' or 'ldsp' for different processing. In
this version, a boolean type 'is_1dsp' is defined to make the code
clearer.
2. For the ldsp&sdsp instructions, since 'rs1=2' is defaulted during
insn16 decoding, no additional processing is done in trans *.

Additional modifications in this version of the patch:
1. Zcmlsd renamed to zclsd.
2. Optimized the constraint rules of instructions on registers.
3. Adjustment of implicit relationship between zclsd and zca&zlsd.

lxx (1):
  target/riscv: Add Zilsd and Zclsd extension support

 target/riscv/cpu.c                        |  4 +
 target/riscv/cpu_cfg.h                    |  2 +
 target/riscv/insn16.decode                |  8 ++
 target/riscv/insn32.decode                | 12 ++-
 target/riscv/insn_trans/trans_zclsd.c.inc | 99 +++++++++++++++++++++++
 target/riscv/insn_trans/trans_zilsd.c.inc | 89 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                | 16 ++++
 target/riscv/translate.c                  |  2 +
 8 files changed, 230 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zclsd.c.inc
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

-- 
2.45.2

