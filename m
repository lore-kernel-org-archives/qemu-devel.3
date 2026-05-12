Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD890CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMs-0001uR-EY; Tue, 12 May 2026 17:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMm-0001IE-3J; Tue, 12 May 2026 17:10:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuMj-0003hk-40; Tue, 12 May 2026 17:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619302; bh=AHato+pJk/46U2CB00QdotF83uO3YfTaijVJRABAxR8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IwrrIK9wiFsfK/wsGpiI5XvABqJBmQaasbqHl+GseQfEWeCpkdkn1esnCUB7dEUuC
 uPllPtVQ3YbZSOG0Ao14F7wKSxc+dP1FnZJZUw+muddAiH4qCPSQLANmClVUnuul8S
 fFohufiUaVsFK6YqiXPm7tLjHeS9COojzignlHX3Z600nZSedEi9UXlpaOchiU0Ad7
 2qKMuk3KMDbE0ADVLaQF5mb7dgSdYTKlG5NmACUzWGT2giJkncJkA4a5qQNai7u0ef
 4Cv/oFGt3SWQ5NKVpOTHET0YVe0BPqn4iV4DMkDnNsCZWgXYfXxgEB1t1d2nLvbiqr
 cQodIU6oO0YyQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8CFE11AA368;
 Tue, 12 May 2026 23:55:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 99B6F3ABCD8;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zenghui Yu <zenghui.yu@linux.dev>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 043/117] target/arm: Don't skip access flag fault for
 AccessType_AT
Date: Tue, 12 May 2026 23:53:45 +0300
Message-ID: <20260512205503.361097-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zenghui Yu <zenghui.yu@linux.dev>

As per the pseudo code from DDI0487 M.a.a (on J1-16021) AArch64.S1Walk():

  // Check descriptor AF bit
  elsif (descriptor<10> == '0' && walkparams.ha == '0' &&
          (!accdesc.acctype IN {AccessType_DC, AccessType_IC} ||
           boolean IMPLEMENTATION_DEFINED "Generate access flag fault on IC/DC operations")) then
      fault.statuscode = Fault_AccessFlag;

an access flag fault should be generated for AccessType_AT, if the AF bit
is 0 and !param.ha.

Besides, we should continue to not raise the access flag fault for
in_debug = true which is what we've been doing previously (before commit
efebeec13d07) for LPAE and is what intention of the debugger access
codepath is.

Cc: qemu-stable@nongnu.org
Fixes: efebeec13d07 ("target/arm: Skip AF and DB updates for AccessType_AT")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Message-id: 20260324160321.96347-1-zenghui.yu@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 31b8d287b7fe59d135b836cacaaa364efe598ec0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index b2ae00b89e..e96b1c11e8 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2128,6 +2128,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr &= ~(hwaddr)(page_size - 1);
     descaddr |= (address & (page_size - 1));
 
+    if (likely(!ptw->in_debug)) {
+        /* Check descriptor AF bit */
+        if (!(descriptor & (1 << 10)) && !param.ha) {
+            fi->type = ARMFault_AccessFlag;
+            goto do_fault;
+        }
+    }
+
     /*
      * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
      * and it is IMPLEMENTATION DEFINED whether AF is updated
@@ -2137,15 +2145,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         /*
          * Access flag.
          * If HA is enabled, prepare to update the descriptor below.
-         * Otherwise, pass the access fault on to software.
          */
-        if (!(descriptor & (1 << 10))) {
-            if (param.ha) {
-                new_descriptor |= 1 << 10; /* AF */
-            } else {
-                fi->type = ARMFault_AccessFlag;
-                goto do_fault;
-            }
+        if (!(descriptor & (1 << 10)) && param.ha) {
+            new_descriptor |= 1 << 10; /* AF */
         }
 
         /*
-- 
2.47.3


