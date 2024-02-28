Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3245AC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfSpv-0005at-L5; Wed, 28 Feb 2024 17:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfSpt-0005aZ-Ro; Wed, 28 Feb 2024 17:55:37 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfSpe-0000aj-CH; Wed, 28 Feb 2024 17:55:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 10C0151810;
 Thu, 29 Feb 2024 01:55:33 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 74BF18BB43;
 Thu, 29 Feb 2024 01:54:56 +0300 (MSK)
Received: (nullmailer pid 274146 invoked by uid 1000);
 Wed, 28 Feb 2024 22:54:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 71/78] target/i386: mask high bits of CR3 in 32-bit mode
Date: Thu, 29 Feb 2024 01:54:47 +0300
Message-Id: <20240228225455.274062-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240229000326@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240229000326@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

CR3 bits 63:32 are ignored in 32-bit mode (either legacy 2-level
paging or PAE paging).  Do this in mmu_translate() to remove
the last where get_physical_address() meaningfully drops the high
bits of the address.

Cc: qemu-stable@nongnu.org
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 68fb78d7d5723066ec2cacee7d25d67a4143b42f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439ad..11126c860d 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -238,7 +238,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 3
              */
-            pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
+            pte_addr = ((in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18)) & a20_mask;
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -306,7 +306,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 2
          */
-        pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
+        pte_addr = ((in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc)) & a20_mask;
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
-- 
2.39.2


