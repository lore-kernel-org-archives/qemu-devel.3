Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C06CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJt-0005xD-HH; Wed, 01 Oct 2025 03:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJh-0005ut-95
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:32:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJ8-0003aO-2m
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=IXmYPWFl3bYzDtQHHlzPLTboQ8KQSIwkWY0rdyAZYsM=; b=Ng9yIgpK9Nt8K9v
 mjpcW8W9fSIlv42eyFFO/CnqeQza6FofOowv7uMf9kKvs9hUxb0gi2dFRmKuXbKwCAFEvsBgFBulV
 xa3kHGICrFWBE0esEgryIbcagP3HtYgU9zhG0o9hzMGFBNwoNobM6d9wXQ5kBO5xUWFVq1LZxO1sk
 IA=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 28/33] target/riscv: Fix size of trigger data
Date: Wed,  1 Oct 2025 09:33:01 +0200
Message-ID: <20251001073306.28573-29-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

mcontext is at most 14 bits in size with the H extension, fix to 16
bits. trigger_cur indexes into tdata*[RV_MAX_TRIGGERS] which holds 2
elements, fix to 8 bits.

Note, the cpu/debug VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h     | 10 +++++-----
 target/riscv/machine.c | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b17aca0e02..b718f6f3b1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -460,11 +460,11 @@ struct CPUArchState {
     target_ulong mseccfg;
 
     /* trigger module */
-    target_ulong trigger_cur;
-    target_ulong tdata1[RV_MAX_TRIGGERS];
-    target_ulong tdata2[RV_MAX_TRIGGERS];
-    target_ulong tdata3[RV_MAX_TRIGGERS];
-    target_ulong mcontext;
+    uint16_t mcontext;
+    uint8_t trigger_cur;
+    uint64_t tdata1[RV_MAX_TRIGGERS];
+    uint64_t tdata2[RV_MAX_TRIGGERS];
+    uint64_t tdata3[RV_MAX_TRIGGERS];
     struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
     QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 18dbc1bfa9..aa71aa6eb1 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -238,15 +238,15 @@ static int debug_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_debug = {
     .name = "cpu/debug",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .needed = debug_needed,
     .post_load = debug_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
-        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
-        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
+        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
+        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.51.0


