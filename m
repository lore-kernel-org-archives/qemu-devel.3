Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92422ECD98B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIfR-00046O-OB; Fri, 06 Feb 2026 05:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastien.michelland@inria.fr>)
 id 1voIfO-000465-MN; Fri, 06 Feb 2026 05:02:22 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastien.michelland@inria.fr>)
 id 1voIfJ-0003Q5-T3; Fri, 06 Feb 2026 05:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2PPuiRZdhHyFg9QKlovQ1yn/0RKOPXWGD5EAjDsddyA=;
 b=MYriSG5wiKy4aLZCBQqxftkRaiNcgN+DNRfksQHPWp3OUbDtosyeTBqR
 +TNlZ6Z37QGGLPiG31iVMEir3xsyjc1cD6Gl6tFFUq9yLPFeXTc0PNPrn
 LrI8O20QM5ctYhXI/qjfLfukeL0RuvQKDWXJpL0tszOHydc/FCdZxnjIt I=;
X-CSE-ConnectionGUID: 61pu5ybbRvWHp8rfFKKFqQ==
X-CSE-MsgGUID: oDdKvZ+mTTCM2SIRNyd/Iw==
Authentication-Results: mail3-relais-sop.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=sebastien.michelland@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,276,1763420400"; d="scan'208";a="138096553"
Received: from ptb-03250204.irisa.fr ([131.254.16.132])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 11:02:08 +0100
From: =?UTF-8?q?S=C3=A9bastien=20Michelland?= <sebastien.michelland@inria.fr>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 qemu-riscv@nongnu.org, Jean-Michel Gorius <jean-michel.gorius@irisa.fr>,
 =?UTF-8?q?S=C3=A9bastien=20Michelland?= <sebastien.michelland@inria.fr>
Subject: [PATCH v3] target/riscv: fix require_rvv passing on non-RVV CPUs
Date: Fri,  6 Feb 2026 11:01:23 +0100
Message-ID: <20260206100256.1360597-1-sebastien.michelland@inria.fr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.134.164.104;
 envelope-from=sebastien.michelland@inria.fr;
 helo=mail3-relais-sop.national.inria.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

trans_rvv.c.inc checks for the RVV extension through the function
require_rvv. However, at least under CONFIG_USER_ONLY, the RVV extension
status in DisasContex->mstatus_vs is always set to DIRTY, therefore
treating RVV instructions as legal even when the extension is not
present, e.g. with -cpu=rv32,v=false.

This bug manifests rarely because vset{i}vl{i} perform extra checks that
do fail without RVV, thus raising SIGILL, and with no vtype set nearly
all other RVV instructions still pass require_rvv but fail the vill check.
Only instructions that don't depend on type (whole-register load/stores,
such as vs*r.v) would show the bug by being executed when v=false.

This patch sets mstatus_vs to DISABLED when RVV is not present (checked
with the minimalistic Zve32x), meaning require_rvv now fails as intended.

Signed-off-by: Sébastien Michelland <sebastien.michelland@inria.fr>
---
Thanks Max for your patience with this patch.

 target/riscv/tcg/tcg-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..9c2c3ac278 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -153,7 +153,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
-    vs = EXT_STATUS_DIRTY;
+    vs = cpu->cfg.ext_zve32x ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
 #else
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
-- 
2.52.0


