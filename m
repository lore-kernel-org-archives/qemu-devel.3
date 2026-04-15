Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30843F41986
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCyGL-0000Dv-ES; Wed, 15 Apr 2026 07:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>) id 1wCyGG-0000DH-DR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 07:18:24 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@rail5.org>) id 1wCyGE-00018c-IV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 07:18:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 88CC72650C;
 Wed, 15 Apr 2026 13:18:16 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6tAwmskDO1UY; Wed, 15 Apr 2026 13:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rail5.org; s=mail;
 t=1776251896; bh=UR6UQSfqlww9S8q5dRVffbCW+mZBwQCATEBpNojYDmY=;
 h=From:To:Cc:Subject:Date;
 b=RAAYM8P0KPgqOFlzhDR8ld7+N3gNZHoyEqbW0UOpxt+PEJ174DsXU+/88b2r7SJ5h
 EIoIUPGCw+ExlGAa/XfIM0UhXl4Id0uJx8PgnkyJynpZsb1BE3sDTihYo1NlYEdkU0
 tTJqdAcZBswB1AEfxTNBDcX/mfrGIWpzQWZp6FYEV4BZxNmQWDVqVG4A/VRcBEatpN
 rWQqBBEqOXM4A924YF/6KIWXWZg7eyThyv2ww8/7O+QSrteZmkdmNw4Ct9wCH656W6
 dqCZNK5FKdloGQC3fXdtq/NGht5bgWJaz/mOy8AJq7JdU8cNLJyiufkZZuyXRKwu6K
 92reBbsiukKDg==
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, "Andrew S. Rightenburg" <andrew@rail5.org>
Subject: [PATCH] target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT
Date: Wed, 15 Apr 2026 19:17:07 +0800
Message-ID: <20260415111738.3264448-1-andrew@rail5.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.21.23.139; envelope-from=andrew@rail5.org;
 helo=layka.disroot.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  "Andrew S. Rightenburg" <andrew@rail5.org>
From:  "Andrew S. Rightenburg" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In TCG mode, helper_csrwr_estat() updates CSR.ESTAT.IS[1:0] (SWI0/SWI1)
when the guest writes CSR_ESTAT, but it did not update the CPU interrupt
request state. As a result, software interrupts could be observed as pending
in CSR.ESTAT while no interrupt exception was taken.

Update CPU_INTERRUPT_HARD after modifying CSR_ESTAT, matching the behavior of
loongarch_cpu_set_irq(). The helper runs without the Big QEMU Lock (BQL), so
take the BQL while calling cpu_interrupt().

Fixes: 5b1dedfe848b ("target/loongarch: Add LoongArch CSR instruction")
Reported-by: Andrew S. Rightenburg <andrew@rail5.org>
Signed-off-by: Andrew S. Rightenburg <andrew@rail5.org>
---
 target/loongarch/tcg/csr_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index cd35ca93c7..0a5ed52eb6 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -98,10 +98,22 @@ target_ulong helper_csrrd_msgir(CPULoongArchState *env)
 target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
 {
     int64_t old_v = env->CSR_ESTAT;
+    CPUState *cs = env_cpu(env);
 
     /* Only IS[1:0] can be written */
     env->CSR_ESTAT = deposit64(env->CSR_ESTAT, 0, 2, val);
 
+    /*
+     * Software interrupts (SWI0/SWI1) are latched in CSR.ESTAT.IS[1:0].
+     * Make sure the CPU interrupt request state tracks the pending bits,
+     * matching the behavior of loongarch_cpu_set_irq().
+     */
+    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
+        bql_lock();
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        bql_unlock();
+    }
+
     return old_v;
 }
 
-- 
2.47.3


