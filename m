Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F324FC54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodvd-0001Ni-5O; Tue, 28 Jul 2026 05:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wodvb-0001NU-Bs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:16:47 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wodvZ-0002Gh-7R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:16:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B5C543D27;
 Tue, 28 Jul 2026 09:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4276D1F000E9;
 Tue, 28 Jul 2026 09:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785230204;
 bh=6rj02GtnDs+0doitejnDaOYtpT5WonY0xjQXCfOhfMs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P3cdwCPOvm2LBnAsBEaTLBuBlBOkEhuF7kaTDevHzVrgWSUPZzY3yjSObq6xGgCa+
 j3JZdABTDtB/eRu4TKyny1uKH5XrWOj14Mihn9ImLFqsIRuyLSMJMGXbCSKEwtB9gA
 Fehvv2ugNPhASLlWaxabcwLgWJPJ31nxgeFldVcMpOLndePJiFkLg7+w2K7c8h5plI
 lRy280rltHNBbkrpnfADa+F5WoN+IgPPfkVLYAs+nwuvXYHhBkjxV/8+p3N4wgJsA4
 /ovmqo1bGr6QPJ/vJwfugK2Dvcvwn5esT7s4H0vKI4y70uXnPdSn32tjp3M3ZFvcnv
 4GOLLkIEUevrw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Matt Turner <mattst88@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PULL 3/3] linux-user/sh4: allow full 32-bit address space
Date: Tue, 28 Jul 2026 11:16:33 +0200
Message-ID: <20260728091633.29765-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728091633.29765-1-deller@kernel.org>
References: <20260728091633.29765-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Laurent Vivier <laurent@vivier.eu>

On real SH4 hardware, the address space is split between user mode
(U0, 0x00000000-0x7fffffff) and kernel mode (P1-P4, 0x80000000-0xffffffff),
so TARGET_VIRT_ADDR_SPACE_BITS was set to 31 for CONFIG_USER_ONLY.

However, qemu-user does not emulate the MMU, so this limit is not needed.
The only effect is to restrict reserved_va to 2 GB, causing OOM failures
for memory-intensive builds (e.g. webkit2gtk on Debian sh4 buildds).

Set TARGET_VIRT_ADDR_SPACE_BITS to 32 unconditionally, like most other
32-bit targets. Also fix the TASK_UNMAPPED_BASE macro to use 1ull instead
of 1u to avoid undefined behavior when shifting by 32.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/target_mman.h | 2 +-
 target/sh4/cpu-param.h       | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/linux-user/sh4/target_mman.h b/linux-user/sh4/target_mman.h
index dd9016081e..2d05837c2f 100644
--- a/linux-user/sh4/target_mman.h
+++ b/linux-user/sh4/target_mman.h
@@ -1,6 +1,6 @@
 /* arch/sh/include/asm/processor_32.h */
 #define TASK_UNMAPPED_BASE \
-    TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
+    TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
 
 /* arch/sh/include/asm/elf.h */
 #define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index c3b8114e53..9d72e35e31 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -9,10 +9,8 @@
 #define SH4_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 12  /* 4k */
-#ifdef CONFIG_USER_ONLY
-# define TARGET_VIRT_ADDR_SPACE_BITS 31
-#else
-# define TARGET_VIRT_ADDR_SPACE_BITS 32
-#endif
+
+/* qemu-user does not emulate the MMU, so no need to limit to 31 bits. */
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #endif
-- 
2.54.0


