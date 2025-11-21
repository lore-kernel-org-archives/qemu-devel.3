Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BE3CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd4G-0002WP-3E; Fri, 21 Nov 2025 21:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcVO-0000xC-FP; Fri, 21 Nov 2025 20:33:38 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcTL-0001Mr-8y; Fri, 21 Nov 2025 20:33:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 16B0C16CA8C;
 Fri, 21 Nov 2025 21:44:31 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CB323321CC8;
 Fri, 21 Nov 2025 21:44:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 81/81] target/i386: fix stack size when delivering
 real mode interrupts
Date: Fri, 21 Nov 2025 21:44:20 +0300
Message-ID: <20251121184424.1137669-81-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

The stack can be 32-bit even in real mode, and in this case
the stack pointer must be updated in its entirety rather than
just the bottom 16 bits.  The same is true of real mode IRET,
for which there was even a comment suggesting the right thing
to do.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1506
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 106d766c9d5b549bc9780d2d2c519aa2bbebc89a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 71962113fb..603993ea03 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1135,7 +1135,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     sa.env = env;
     sa.ra = 0;
     sa.sp = env->regs[R_ESP];
-    sa.sp_mask = 0xffff;
+    sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.ss_base = env->segs[R_SS].base;
     sa.mmu_index = x86_mmu_index_pl(env, 0);
 
@@ -1933,7 +1933,7 @@ void helper_iret_real(CPUX86State *env, int shift)
     sa.env = env;
     sa.ra = GETPC();
     sa.mmu_index = x86_mmu_index_pl(env, 0);
-    sa.sp_mask = 0xffff; /* XXXX: use SS segment size? */
+    sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.sp = env->regs[R_ESP];
     sa.ss_base = env->segs[R_SS].base;
 
-- 
2.47.3


