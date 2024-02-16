Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E27C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 06:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rarUh-0001SN-Cq; Fri, 16 Feb 2024 01:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rarUg-0001Ry-AB
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:14:42 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rarUe-0006Ns-EC
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:14:42 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 41G6EN7B007773;
 Fri, 16 Feb 2024 14:14:23 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from alvinga-VirtualBox.andestech.com (10.0.13.68) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Fri, 16 Feb 2024 14:14:20 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH 4/4] target/riscv: Set the value of CSR tcontrol when mret is
 executed
Date: Fri, 16 Feb 2024 14:13:32 +0800
Message-ID: <20240216061332.50229-5-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216061332.50229-1-alvinga@andestech.com>
References: <20240216061332.50229-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.13.68]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41G6EN7B007773
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The RISC-V debug specification defines the following operation for CSR
tcontrol when "mret" is executed:
- tcontrol.MTE is set to the value of tcontrol.MPTE

This commit implements the above operation into helper_mret().

Note that from tech-debug mailing list:
https://lists.riscv.org/g/tech-debug/topic/102702615#1461
The debug specification does not mention the operation to tcontrol.MPTE
when "mret" is executed. Therefore, we just keep its current value.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
 target/riscv/op_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f414aaebdb..12822b3afa 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -347,6 +347,12 @@ target_ulong helper_mret(CPURISCVState *env)
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
     env->mstatus = mstatus;
+
+    uint64_t tcontrol = env->tcontrol;
+    tcontrol = set_field(tcontrol, TCONTROL_MTE,
+                         get_field(tcontrol, TCONTROL_MPTE));
+    env->tcontrol = tcontrol;
+
     riscv_cpu_set_mode(env, prev_priv);
 
     if (riscv_has_ext(env, RVH)) {
-- 
2.34.1


