Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C57C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 11:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLLqX-0002kH-4w; Sun, 23 Jun 2024 07:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLqW-0002ju-7u
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 07:57:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLqU-0003ZW-Kj
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 07:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=AumHXi24zkWbD3hbKxWrJZ177/YiwBBU4N9VCFJypbE=; b=aNdiINiMIdE94pTeX16BFQTYOJ
 FBPJLcJ5CwV51kx+IFRFwIj1MOCFCg6/9aO4TNn3WPQHs0eSnVLxFsNkxwYOEwVA3kQ0I7JlEZHoK
 6bS2lCH7ClkcFrxuX3QZcyCr8+MwoOMCR6K4ijkChdlgz2VgkwztRDKFU09adT00ZB9dvy3/MZOoH
 Pi7zDUorIKviGxDs9KzU+YktxQKiPZGrR5KZGvx9IDWGS/2NyTHKVIgDv+VDz+sP5J0s7D0dIHECB
 i0DB9N86T3cX2cSyJ3yt0mU4Zo0Acnb7G+nn++sQVZCjQhBgJG9HQSzO0gfukRBYvuD020BtQhNvS
 A0RJjbtnzzrG3P4pBGrxZWSci1UpS6F2RlFER1gyYe+6v/PLqf7u5jT4CvLT2XNP+ODpRhPRrFtvV
 /6Stwr+/5pRuqePyHE4iozzNHeFF7LQuiLnnQvH6iWaS16mFpCPaVYfbYX85xzfw5STC+FxalbMdY
 6fwKd0v0w/YT54pzcCtlX9FLQ2cTcIKy3MOzn6O3G8W3xxUYDomwa+JJB0EWUbsO3pLqz4F0jvPV8
 dSOvQXIj7m0WqFJAro8vthZ1JjUUWG8dGVr33vnbKB6SZaT5HDzDrhdKakOuOdtRqTAOMiMTg8Zhk
 4I6WdR0EDtQDQ0pZQbnocx7jL8tQEnEhWhfKavxBM=;
Received: from [2a00:23c4:8bb4:4000:e8db:395:a8c5:fda6]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLLp6-00080P-8A; Sun, 23 Jun 2024 12:56:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Sun, 23 Jun 2024 12:57:03 +0100
Message-Id: <20240623115704.315645-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:e8db:395:a8c5:fda6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/2] target/m68k: implement do_unaligned_access callback for
 m68k CPUs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For m68k CPUs that do not support unaligned accesses, any such access should
cause the CPU to raise an Address Error exception.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/m68k/cpu.c       |  1 +
 target/m68k/cpu.h       |  4 ++++
 target/m68k/op_helper.c | 11 +++++++++++
 3 files changed, 16 insertions(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index efd6bbded8..25e95f9f68 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -538,6 +538,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
     .do_interrupt = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
+    .do_unaligned_access = m68k_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
 };
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b5bbeedb7a..d4c9531b1c 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -590,6 +590,10 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  unsigned size, MMUAccessType access_type,
                                  int mmu_idx, MemTxAttrs attrs,
                                  MemTxResult response, uintptr_t retaddr);
+G_NORETURN void m68k_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                             MMUAccessType access_type,
+                                             int mmu_idx,
+                                             uintptr_t retaddr);
 #endif
 
 #include "exec/cpu-all.h"
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 15bad5dd46..417b691d8d 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -558,6 +558,17 @@ raise_exception_format2(CPUM68KState *env, int tt, int ilen, uintptr_t raddr)
     cpu_loop_exit(cs);
 }
 
+#if !defined(CONFIG_USER_ONLY)
+G_NORETURN void m68k_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                             MMUAccessType access_type,
+                                             int mmu_idx, uintptr_t retaddr)
+{
+    CPUM68KState *env = cpu_env(cs);
+
+    raise_exception(env, EXCP_ADDRESS);
+}
+#endif
+
 void HELPER(divuw)(CPUM68KState *env, int destr, uint32_t den, int ilen)
 {
     uint32_t num = env->dregs[destr];
-- 
2.39.2


