Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E31DE7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn123-0008Ec-Bk; Mon, 02 Feb 2026 16:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn11z-0007sZ-C5; Mon, 02 Feb 2026 16:00:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn11w-0004Cc-Ua; Mon, 02 Feb 2026 16:00:22 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E2891851A0;
 Mon, 02 Feb 2026 23:57:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EC05035B317;
 Mon, 02 Feb 2026 23:58:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 20/74] target/i386: Fix #GP error code for INT
 instructions
Date: Mon,  2 Feb 2026 23:57:31 +0300
Message-ID: <20260202205833.941615-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrew Cooper <andrew.cooper3@citrix.com>

While the (intno << shift) expression is correct for indexing the IDT based on
whether Long Mode is active, the error code itself was unchanged with AMD64,
and is still the index with 3 bits of metadata in the bottom.

Found when running a Xen unit test, all under QEMU.  The unit test objected to
being told there was an error with IDT index 256 when INT $0x80 (128) was the
problem instruction:

  ...
  Error: Unexpected fault 0x800d0802, #GP[IDT[256]]
  ...

Fixes: d2fd1af76777 ("x86_64 linux user emulation")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/r/20250312000603.3666083-1-andrew.cooper3@citrix.com
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3160
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 60efba3c1bff0d78632d45c2dc927c5bc7a17ba8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 263f59937f..28bbef1bba 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -63,7 +63,7 @@ static void do_interrupt_user(CPUX86State *env, int intno, int is_int,
         cpl = env->hflags & HF_CPL_MASK;
         /* check privilege if software int */
         if (dpl < cpl) {
-            raise_exception_err(env, EXCP0D_GPF, (intno << shift) + 2);
+            raise_exception_err(env, EXCP0D_GPF, intno * 8 + 2);
         }
     }
 
-- 
2.47.3


