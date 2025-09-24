Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94E0CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jn6-0005Sa-Vc; Wed, 24 Sep 2025 03:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jn3-0005RV-2b
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:49 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmq-0003Nz-Lr
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=tIUjEoxmD+L3v5TUv5lmknEUjE1dS8nrXtJKYtFhI0M=; b=G/FRv/dNNOrxu9I
 WUwmliUrglHH/LdvdYh9ayDDc9rgqUXMaeE7wLEKbiVM6YOVEzg7cDW9laEmfagYBFbBOlrHeCgTL
 fJHjb1SzX8zXs2gIQwH0tUVosT0SAOGO3KSAB2AJX49IBfYytXydQKnRYHJcptLtSmcoYGZvlPLGe
 K0=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 03/34] target/riscv: Fix size of mcause
Date: Wed, 24 Sep 2025 09:20:53 +0200
Message-ID: <20250924072124.6493-4-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

and update formatting in logs.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h     | 2 +-
 target/riscv/machine.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8d34f3ac..32e30a36ac 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -323,7 +323,7 @@ struct CPUArchState {
 
     uint64_t mtvec;
     uint64_t mepc;
-    target_ulong mcause;
+    uint64_t mcause;
     uint64_t mtval;  /* since: priv-1.10.0 */
 
     uint64_t mctrctl;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index f42be027e3..438c44dbb0 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -442,7 +442,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64(env.scause, RISCVCPU),
         VMSTATE_UINT64(env.mtvec, RISCVCPU),
         VMSTATE_UINT64(env.mepc, RISCVCPU),
-        VMSTATE_UINTTL(env.mcause, RISCVCPU),
+        VMSTATE_UINT64(env.mcause, RISCVCPU),
         VMSTATE_UINT64(env.mtval, RISCVCPU),
         VMSTATE_UINTTL(env.miselect, RISCVCPU),
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
-- 
2.51.0


