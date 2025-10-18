Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98E2CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 20:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vADzF-00086A-QM; Sat, 18 Oct 2025 16:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vADz9-00081E-BO; Sat, 18 Oct 2025 16:57:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vADz7-0004yX-Q9; Sat, 18 Oct 2025 16:57:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF4DE15F87E;
 Sat, 18 Oct 2025 23:56:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CE2652F0687;
 Sat, 18 Oct 2025 23:56:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.6 21/23] target/i386: user: do not set up a valid LDT on
 reset
Date: Sat, 18 Oct 2025 23:56:39 +0300
Message-ID: <20251018205644.1185050-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251018221314@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251018221314@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Paolo Bonzini <pbonzini@redhat.com>

In user-mode emulation, QEMU uses the default setting of the LDT base
and limit, which places it at the bottom 64K of virtual address space.
However, by default there is no LDT at all in Linux processes, and
therefore the limit should be 0.

This is visible as a NULL pointer dereference in LSL and LAR instructions
when they try to read the LDT at an unmapped address.

Resolves: #1376
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 58aa1d08bbc406ba3982f32ffb1bef0ff4f8f369)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 34b52ef7a1..76e0cceb10 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7513,7 +7513,11 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
 
     env->idt.limit = 0xffff;
     env->gdt.limit = 0xffff;
+#if defined(CONFIG_USER_ONLY)
+    env->ldt.limit = 0;
+#else
     env->ldt.limit = 0xffff;
+#endif
     env->ldt.flags = DESC_P_MASK | (2 << DESC_TYPE_SHIFT);
     env->tr.limit = 0xffff;
     env->tr.flags = DESC_P_MASK | (11 << DESC_TYPE_SHIFT);
-- 
2.47.3


