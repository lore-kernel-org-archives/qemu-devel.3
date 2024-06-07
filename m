Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36F1C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 21:41:23 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf6J-0006Qm-CD; Fri, 07 Jun 2024 15:18:11 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf6G-000656-5a; Fri, 07 Jun 2024 15:18:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf6E-0003AG-Ic; Fri, 07 Jun 2024 15:18:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 32FCA6E571;
 Fri,  7 Jun 2024 22:14:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6CDF1E276A;
 Fri,  7 Jun 2024 22:14:00 +0300 (MSK)
Received: (nullmailer pid 529478 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 67/71] target/i386: fix xsave.flat from kvm-unit-tests
Date: Fri,  7 Jun 2024 22:13:48 +0300
Message-Id: <20240607191356.529336-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

xsave.flat checks that "executing the XSETBV instruction causes a general-
protection fault (#GP) if ECX = 0 and EAX[2:1] has the value 10b".  QEMU allows
that option, so the test fails.  Add the condition.

Cc: qemu-stable@nongnu.org
Fixes: 892544317fe ("target/i386: implement XSAVE and XRSTOR of AVX registers", 2022-10-18)
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 7604bbc2d87d153e65e38cf2d671a5a9a35917b1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4b965a5d6c..0747e8fd40 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3010,6 +3010,11 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
         goto do_gpf;
     }
 
+    /* SSE can be disabled, but only if AVX is disabled too.  */
+    if ((mask & (XSTATE_SSE_MASK | XSTATE_YMM_MASK)) == XSTATE_YMM_MASK) {
+        goto do_gpf;
+    }
+
     /* Disallow enabling unimplemented features.  */
     cpu_x86_cpuid(env, 0x0d, 0, &ena_lo, &dummy, &dummy, &ena_hi);
     ena = ((uint64_t)ena_hi << 32) | ena_lo;
-- 
2.39.2


