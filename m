Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B240CD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGb-00027o-4H; Tue, 12 May 2026 17:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuDo-0006qf-Jj; Tue, 12 May 2026 17:01:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuDm-0006Fk-FF; Tue, 12 May 2026 17:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619277; bh=NbkwXb1Gi680e8oCc6FrubMsy+d2+Gpa+KdzunAAzdM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZUSDhPR6MbfXYfxaCX4duHMoDUiBmhUz+XvX0xWtEUMALTKSF7Zz5UfqE63kNX0NE
 /RpgPnnO4ZV2N+CRMdMEMy9ZI0F1v8Wab5oArhBIZTPgyjdc359lL8su4YvTsNVw2R
 N9BaMvnQasyRfBs6Y90tUWdEgSLnMoazf/D4ZqHTEh8mFLl/09RvyxOH2W/UzZJ5LV
 uXMrxpuIesB64TZk2/PIvElVWQP+k2d7EyamcNOZb8sEb8ssOAZwbP08OjT45aF5jX
 1dZF1Xpk8FXgeMdVVDUwj2QPmzIMFNauPwxH3c5qB3Q3S1zf6wuSvzeF2vUiMpAxw4
 YHu58Nh8XwRkQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 748F81AA30A;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 80AD13ABC7B;
 Tue, 12 May 2026 23:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 062/107] target/i386: fix missing PF_INSTR in SIGSEGV
 context
Date: Tue, 12 May 2026 23:53:49 +0300
Message-ID: <20260512205437.360850-62-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Simon Scherer <scherer.simon89@gmail.com>

When running linux-user emulation, the SIGSEGV handler does not
correctly set the 4th bit (PF_INSTR) in the error_code variable of
the context argument (context->uc_mcontext.gregs[REG_ERR]).

Because this bit is never set, guest applications cannot distinguish
if a fault was due to missing executable permissions. This patch
ensures that when a page fault occurs during an instruction fetch,
the PF_INSTR flag is properly populated in the signal context.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3384
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260413115622.160212-1-scherer.simon89@gmail.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3eae91a8b93a35f194a39ab5b894ae405def9270)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
index b3bdb7831a..2bb088a4ee 100644
--- a/target/i386/tcg/user/excp_helper.c
+++ b/target/i386/tcg/user/excp_helper.c
@@ -37,9 +37,10 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
      * signal and set exception_index to EXCP_INTERRUPT.
      */
     env->cr[2] = addr;
-    env->error_code = ((access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT)
-                    | (maperr ? 0 : PG_ERROR_P_MASK)
-                    | PG_ERROR_U_MASK;
+    env->error_code = (maperr ? 0 : PG_ERROR_P_MASK)
+                    | ((access_type == MMU_DATA_STORE) << PG_ERROR_W_BIT)
+                    | PG_ERROR_U_MASK
+                    | ((access_type == MMU_INST_FETCH) ? PG_ERROR_I_D_MASK : 0);
     cs->exception_index = EXCP0E_PAGE;
 
     /* Disable do_interrupt_user. */
-- 
2.47.3


