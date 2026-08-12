Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252B4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8ie-0008H9-2q; Wed, 12 Aug 2026 09:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8i5-0007st-0q; Wed, 12 Aug 2026 09:09:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8i3-0005e5-1H; Wed, 12 Aug 2026 09:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=HJX3/iaF7LVUHvpdp8tP0vXs7VHeqO5/FwxOPf2+BrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HJjruDA62VehoI+6KTVU/fJ9ZyD0zngnFQa63rXcGAtD3acv6UQM/eQkWELIKn9v5
 U8g5UVRgUqgH+DqnWTSHJKhzel+67jGpiFL6GiBcpwUAOgA+K2ogyR/dCkmHKNeZyF
 i2U6FgW5CMI4ZC3lLxIIvESzZMFfmDhczwPwIcmq8fpXKxgI9vpEu0wC7+GZIWAJyP
 T6NfdMIj2Q6i9I50afTEYqnUdosPGv5s8aqrOFXNoTepkVuy4D1EqmawGtTwEBREsB
 myxUhclXDK1gyZh7xObh3V2L/TLZuIsYUByFhM0Fk9+7f2Y/75Ykq1FOulOEAZ8CpT
 /+Y3Ziqya1L9Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 465981CA4C1;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7CCAD409BA4;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 79B5B2F918; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 066/102] linux-user/sh4: allow full 32-bit address
 space
Date: Wed, 12 Aug 2026 16:01:41 +0300
Message-ID: <20260812130233.621965-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
(cherry picked from commit db3abd36e4c7c2a72e00e5806cf4c47f5aa5c491)
(Mjt: context fixup for 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/target_mman.h b/linux-user/sh4/target_mman.h
index dd9016081e9..2d05837c2f3 100644
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
index 2b6e11dd0ac..3e058e3aaef 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -10,10 +10,7 @@
 
 #define TARGET_PAGE_BITS 12  /* 4k */
 #define TARGET_PHYS_ADDR_SPACE_BITS  32
-#ifdef CONFIG_USER_ONLY
-# define TARGET_VIRT_ADDR_SPACE_BITS 31
-#else
-# define TARGET_VIRT_ADDR_SPACE_BITS 32
-#endif
+/* qemu-user does not emulate the MMU, so no need to limit to 31 bits. */
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #endif
-- 
2.47.3


