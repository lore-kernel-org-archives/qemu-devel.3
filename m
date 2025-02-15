Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AC8C02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 02:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj7k3-0004Ge-0A; Fri, 14 Feb 2025 21:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jz-0004FT-L9
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:11 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jw-0006dP-Fo
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585825; bh=Kru5Oo9ytMLO/csVYud/FazrbyUaZhJC7XhcOH6Gf9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UfiLzZu5vLwn0Jfnbe22Rp/oEX/lRInro3MXyKr9qYJBwXG+C6UUeVniNCDaolsIs
 ODXkQYLv2iQeiw8LfeGvITrwwbpL+9jvLxlVhl02oPDFiDWzDxfASz5tgLM4PNrCdz
 CJgGRk/jP4iP1Ux1lIyPyx8tylFeIEx/NDrqT2Eu+x6dZrBe+Ob2QtZjm1VtRPtqYj
 47xMIxLp4DaHB6DznAqf59/CDkgVdVWQ9LBz4oBMJ2rDNTUqjawtN/YHh5Ka1Djxcj
 fXdXFLJMxAZr9yFvOf+25qm7fJ5TNG/mLPqaqAzq+xOFJhlN+BlkRImyI1n17UBvmN
 KfDy7l5j07/jg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 55A643F22BBE
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 18:17:05 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id 3wB3QZw-B8TM; Fri, 14 Feb 2025 18:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585822; bh=Kru5Oo9ytMLO/csVYud/FazrbyUaZhJC7XhcOH6Gf9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lgvQfK+/IOlA2GgUvON5wMb0vxPzHOd+ujKPy24VLWYtHHiIzRIf2wKcwNYB5//wN
 myoYXqCtCfmg6KfHSPFOC5JbZMlEyZBxsdD91mSafITo016xfPg6A2E8LnFr09Na60
 e8Xf6O6QzxI4qbnSjFrySJQulKi43nWHyPM5L0UQDdFH/zChbNfY3ZVV7ve3AlmgG/
 xs9VVSRsPTPReW0skAiNNRPZgGgNSSZWPJEjuq/06qpj58a+aM4CC90OnRvDAWj3os
 gG9fbHTmF0c1KNyfL01K5810JX3sd6XvA84p4ZG4EHa/uFDl1V4d0SZ5lIZ2kIBU7y
 plMIHvdupLPTw==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 9BADD3F22BEA;
 Fri, 14 Feb 2025 18:17:02 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 5DB351E6009F; Fri, 14 Feb 2025 18:17:02 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 4/5] target/rx: Load reset vector from memory after first run
Date: Fri, 14 Feb 2025 18:16:53 -0800
Message-ID: <20250215021654.1786679-5-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215021654.1786679-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ROM images all get deleted as they've been loaded to memory, so we
can't go fetch the reset vector from there. Instead, fetch it from
memory. To make that work, we need to execute the delayed mmu setup
function tcg_commit_cpu as that wires up memory dispatching.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/rx/cpu.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 04dd34b310..a32b410bb1 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/translation-block.h"
+#include "exec/cpu_ldst.h"
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
@@ -77,7 +78,8 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     CPUState *cs = CPU(obj);
     RXCPUClass *rcc = RX_CPU_GET_CLASS(obj);
     CPURXState *env = cpu_env(cs);
-    uint32_t *resetvec;
+    uint32_t *resetvec_p;
+    vaddr resetvec;
 
     if (rcc->parent_phases.hold) {
         rcc->parent_phases.hold(obj, type);
@@ -85,11 +87,23 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
 
     memset(env, 0, offsetof(CPURXState, end_reset_fields));
 
-    resetvec = rom_ptr(0xfffffffc, 4);
-    if (resetvec) {
-        /* In the case of kernel, it is ignored because it is not set. */
-        env->pc = ldl_p(resetvec);
+    /*
+     * During the first reset phase, the memory dispatching hook
+     * hasn't been set, so we can't fetch the reset vector from
+     * memory. After that, the ROM image will have been discarded, so
+     * we can't fetch the reset vector from there. So we have two
+     * paths here.
+     */
+    resetvec_p = rom_ptr_for_as(cs->as, 0xfffffffc, 4);
+    if (resetvec_p)
+        resetvec = ldl_p(resetvec_p);
+    else {
+        process_queued_cpu_work(cs);
+        resetvec = cpu_ldl_data(env, 0xfffffffc);
     }
+    if (resetvec)
+        env->pc = resetvec;
+
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] = env->isp = env->usp = 0;
     env->fpsw = 0;
-- 
2.47.2


