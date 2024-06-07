Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E0BC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:11:12 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf3B-0004Xw-3f; Fri, 07 Jun 2024 15:14:57 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf39-0004X2-Ba; Fri, 07 Jun 2024 15:14:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf37-0002CD-OJ; Fri, 07 Jun 2024 15:14:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 931156E54F;
 Fri,  7 Jun 2024 22:14:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C0D72E274B;
 Fri,  7 Jun 2024 22:13:10 +0300 (MSK)
Received: (nullmailer pid 528743 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexei Filippov <alexei.filippov@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 38/45] target/riscv: do not set mtval2 for non
 guest-page faults
Date: Fri,  7 Jun 2024 22:12:57 +0300
Message-Id: <20240607191307.528622-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
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

From: Alexei Filippov <alexei.filippov@syntacore.com>

Previous patch fixed the PMP priority in raise_mmu_exception() but we're still
setting mtval2 incorrectly. In riscv_cpu_tlb_fill(), after pmp check in 2 stage
translation part, mtval2 will be set in case of successes 2 stage translation but
failed pmp check.

In this case we gonna set mtval2 via env->guest_phys_fault_addr in context of
riscv_cpu_tlb_fill(), as this was a guest-page-fault, but it didn't and mtval2
should be zero, according to RISCV privileged spec sect. 9.4.4: When a guest
page-fault is taken into M-mode, mtval2 is written with either zero or guest
physical address that faulted, shifted by 2 bits. *For other traps, mtval2
is set to zero...*

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240503103052.6819-1-alexei.filippov@syntacore.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 6c9a344247132ac6c3d0eb9670db45149a29c88f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index cf97c782dd..62dda4f284 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1361,17 +1361,17 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                               __func__, pa, ret, prot_pmp, tlb_size);
 
                 prot &= prot_pmp;
-            }
-
-            if (ret != TRANSLATE_SUCCESS) {
+            } else {
                 /*
                  * Guest physical address translation failed, this is a HS
                  * level exception
                  */
                 first_stage_error = false;
-                env->guest_phys_fault_addr = (im_address |
-                                              (address &
-                                               (TARGET_PAGE_SIZE - 1))) >> 2;
+                if (ret != TRANSLATE_PMP_FAIL) {
+                    env->guest_phys_fault_addr = (im_address |
+                                                  (address &
+                                                   (TARGET_PAGE_SIZE - 1))) >> 2;
+                }
             }
         }
     } else {
-- 
2.39.2


