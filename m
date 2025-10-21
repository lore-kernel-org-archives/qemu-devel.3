Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E9BCCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4bG-00020F-S6; Tue, 21 Oct 2025 01:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vB4bE-0001zx-TS; Tue, 21 Oct 2025 01:07:56 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vB4bB-0004Jt-DW; Tue, 21 Oct 2025 01:07:56 -0400
Received: from [172.130.10.202] ([115.90.12.10]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59L57GaZ073333
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Oct 2025 14:07:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=105prQ1bXvIqzO/KJTlaYYUQ+ECI/RYTnrCYFQpMP8s=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761023246; v=1;
 b=rEK6TxwnIMSzzY1PsGABpup6J6Tmwv5h0E9joN/zT3JT1047szf11/mOHTFt/aoh
 /BICXv+UI9RUyT53I3++mAovynDSMJRdakCLbka4JUAfNMXHgnXqJcbqv8f5wFxF
 qshp1fVCaA+4XwYLq2m3ikYM2fzK0hO5L80u6CqgZIdVEf8gmMlJjMfcx3B+5DRU
 PN2Icb8EKYIO0Elggfz0wZwOyqLz0G3A7EietnGS6CGSth8cRSbU22ByhSnR1yHK
 pVjLhdm/Cf/tSY7QQ4gw5YkcNbrUffztNKkODGe/LjaceNyTe4XFbYG8Z035AXs1
 v6JLS3SpyfWzU5mggtgUmQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 21 Oct 2025 14:07:14 +0900
Subject: [PATCH v2] target/riscv: Fix a uninitialized variable warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vlen-v2-1-1fb581d4c6bf@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAEV92gC/13MSw7CIBSF4a00dyyEh9jUUfdhOkAK7VUDDVRi0
 7B3sUOH/8nJt0OyEW2Ca7NDtBkTBl9DnBows/aTJTjWBsGE4ox3JL+sJ5Jp1Rom72MnoV6XaB1
 +DuY21J4xrSFuh5r5b/0DMiecuFYqoc9MOHbpY5qoQYr0Tdbw3ALVhj4WGEopX82pqHilAAAA
X-Change-ID: 20251019-vlen-30a57c03bd93
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

riscv_cpu_validate_v() left its variable, min_vlen, uninitialized if
no vector extension is available, causing a compiler warning.

Re-define riscv_cpu_validate_v() as no-op when no vector extension is
available to prevent the scenario that will read the unintialized
variable by construction. It also simplifies its caller as a bonus.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- De-duplicated zve32f checks as suggested by Daniel Henrique Barboza.
- Link to v1: https://lore.kernel.org/qemu-devel/20251019-vlen-v1-1-f7352a402f06@rsg.ci.i.u-tokyo.ac.jp
---
 target/riscv/tcg/tcg-cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1150bd14697c..d3968251fad5 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -426,6 +426,8 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
         min_vlen = 64;
     } else if (cfg->ext_zve32x) {
         min_vlen = 32;
+    } else {
+        return;
     }
 
     if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
@@ -676,12 +678,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (cpu->cfg.ext_zve32x) {
-        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return;
-        }
+    riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
     }
 
     /* The Zve64d extension depends on the Zve64f extension */

---
base-commit: c85ba2d7a4056595166689890285105579db446a
change-id: 20251019-vlen-30a57c03bd93

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


