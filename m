Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15AFE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 09:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXdID-0006xz-UJ; Tue, 14 Jan 2025 04:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1tXdI9-0006xh-EQ; Tue, 14 Jan 2025 04:32:57 -0500
Received: from m.syntacore.com ([178.249.69.228] helo=pmg.syntacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1tXdI7-0004WP-N9; Tue, 14 Jan 2025 04:32:57 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by pmg.syntacore.com (Proxmox) with ESMTP id 44B74B41C58;
 Tue, 14 Jan 2025 12:32:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=m; bh=UZfnSxO387Hfg9RUm/AcPnZuu9lKY544wJCkcpY94h4=; b=
 WTeBMmc+yNF1DiX0WdWve8E1855L+CTvYrkR5+WduS5u/pTPIU+p925m6Y7jtFWR
 /WK1T0Hqj7n/GuBWNECsJ3WBN1yTKFoouTBeJe9SFmr5D5S6iDpQXjtDfBIPEXVW
 akkUU6ixmWoynnzLoQyYA1OuhawKv1SHIv52Mf2MBDJOt/DDTNiBCAHIjINPNraT
 XVwsWHRJrDt/ZCPlMMerPN0/fUnxhr9ZZPHi07jyZU81LQVS4ThYbkRhHve0+YCA
 PXl4FI1w8ahAYGu3q4KUL8lcU1Ne5xAW4l/zEJjCwpRmaddMrVtA0qELMrxwGYRc
 /LY7QPmklEfHFXAdf/u9Xg==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 by pmg.syntacore.com (Proxmox) with ESMTPS id 32128B412D4;
 Tue, 14 Jan 2025 12:32:44 +0300 (MSK)
Received: from mail.syntacore.com (172.17.4.249) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jan 2025 12:31:54 +0300
From: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
To: <palmer@dabbelt.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Evgenii Prokopiev
 <evgenii.prokopiev@syntacore.com>
Subject: [PATCH] target/riscv/csr.c: Turn off mstatus.vs when misa.v is turned
 off
Date: Tue, 14 Jan 2025 12:20:12 +0300
Message-ID: <20250114092012.29024-1-evgenii.prokopiev@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.4.249]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=evgenii.prokopiev@syntacore.com; helo=pmg.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A behavior of misa.v must be similar as misa.f.
So when this bit's field is turned off, mstatus.vs must be turned off
too. It follows from the privileged manual of RISC-V, paragraph 3.1.1.
"Machine ISA (misa) Register".

Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
---
 target/riscv/csr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index eab8e50012..fca2b1b40f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1537,6 +1537,10 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
         env->mstatus &= ~MSTATUS_FS;
     }
 
+    if (!(env->misa_ext & RVV)) {
+        env->mstatus &= ~MSTATUS_VS;
+    }
+
     /* flush translation cache */
     tb_flush(env_cpu(env));
     env->xl = riscv_cpu_mxl(env);
-- 
2.34.1



