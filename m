Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF7D5E122
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f9n-0005Ux-I7; Sat, 09 Nov 2024 01:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8o-0003zX-4q; Sat, 09 Nov 2024 01:40:14 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8k-0002RY-Rg; Sat, 09 Nov 2024 01:40:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D8A0A12F7;
 Sat,  9 Nov 2024 09:38:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D7E0E167DDB;
 Sat,  9 Nov 2024 09:39:04 +0300 (MSK)
Received: (nullmailer pid 3272540 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 16/33] target/i386: Avoid unreachable variable
 declaration in mmu_translate()
Date: Sat,  9 Nov 2024 09:38:42 +0300
Message-Id: <20241109063903.3272404-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Peter Maydell <peter.maydell@linaro.org>

Coverity complains (CID 1507880) that the declaration "int error_code;"
in mmu_translate() is unreachable code. Since this is only a declaration,
this isn't actually a bug, but:
 * it's a bear-trap for future changes, because if it was changed to
   include an initialization 'int error_code = foo;' then the
   initialization wouldn't actually happen (being dead code)
 * it's against our coding style, which wants declarations to be
   at the start of blocks
 * it means that anybody reading the code has to go and look up
   exactly what the C rules are for skipping over variable declarations
   using a goto

Move the declaration to the top of the function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230406155946.3362077-1-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 987b63f24afe027a09b1c549c05a032a477f7e96)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: cherry-pick this for stable-7.2 so that the next patch applies cleanly)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5f13252d68..eb78fcba11 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -146,6 +146,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
     hwaddr pte_addr, paddr;
     uint32_t pkr;
     int page_size;
+    int error_code;
 
  restart_all:
     rsvd_mask = ~MAKE_64BIT_MASK(0, env_archcpu(env)->phys_bits);
@@ -464,7 +465,6 @@ do_check_protect_pse36:
     out->page_size = page_size;
     return true;
 
-    int error_code;
  do_fault_rsvd:
     error_code = PG_ERROR_RSVD_MASK;
     goto do_fault_cont;
-- 
2.39.5


