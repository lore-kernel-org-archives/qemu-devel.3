Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE11CAC58F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe2y-0001f9-3x; Thu, 11 Sep 2025 05:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwe2r-0001cQ-Dk; Thu, 11 Sep 2025 05:56:49 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwe2h-0005P4-B2; Thu, 11 Sep 2025 05:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1757584579; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=1gqd1TzCEIyvFYfjyBctacJ1+0G9407EGdXdIQ5mOdw=;
 b=GZEBXztvhdIwrDy+Q0iadCMAlFff6Ubh4Rq2mkiRDA+BbJRsRcyMO9F7HW4sOq0ulDTR5rHxR1+YyxmoLiZ7lwvZ+rRpmOy9rWZJHclutNGf+jQ0S0/OSEAj+nseLi3BzmudRM/EildDfenELDKTbTSubH14C2PN1tvDTR54ypI=
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0Wnlj.L-_1757584579 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 11 Sep 2025 17:56:19 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 11 Sep 2025 17:56:16 +0800
Subject: [PATCH v3 4/4] target/riscv: Save stimer and vstimer in CPU
 vmstate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-timers-v3-4-60508f640050@linux.alibaba.com>
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
In-Reply-To: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757584576; l=1731;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=db8HgAaEdZbHQou94hhdJN2K2puP3nx87MpC33YWDYQ=;
 b=rnE8KAyA9YE2wPYoNdk7C1NlNMyzW4RDdk9kDIdRq/TxTEluv39LB2c1HOMy6tQ7vMY0CeSqN
 TQ/C8V5tDlJDLs+DBwdycbMzEPyXfF8O/IVtfM6sEYXlUzRRrHnLhEw
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

vmstate_riscv_cpu was missing env.stimer and env.vstimer.
Without migrating these QEMUTimer fields, active S/VS-mode
timer events are lost after snapshot or migration.

Add VMSTATE_TIMER_PTR() entries to save and restore them.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 1600ec44f0b755fdd49fc0df47c2288c9940afe0..51e0567ed30cbab5e791ea904165bc1854709192 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -400,6 +400,30 @@ static const VMStateDescription vmstate_ssp = {
     }
 };
 
+static bool sstc_timer_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    if (!cpu->cfg.ext_sstc) {
+        return false;
+    }
+
+    return env->stimer != NULL || env->vstimer != NULL;
+}
+
+static const VMStateDescription vmstate_sstc = {
+    .name = "cpu/timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sstc_timer_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(env.stimer, RISCVCPU),
+        VMSTATE_TIMER_PTR(env.vstimer, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 10,
@@ -476,6 +500,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_elp,
         &vmstate_ssp,
         &vmstate_ctr,
+        &vmstate_sstc,
         NULL
     }
 };

-- 
2.43.0


