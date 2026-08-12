Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A28EC5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQE-0008V3-JU; Wed, 12 Aug 2026 10:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAPU-0006fN-GB; Wed, 12 Aug 2026 10:58:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAPS-00015F-RA; Wed, 12 Aug 2026 10:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=ixnMl8LV90Qy6bGmRervizdPJU0ngIMcfhvAryUecws=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=e5bffYj00Nm5SmDLhMXORN0OqCygqIle8E/iSmmqti4NCd2xiq8Qe8N8l0oTgjeXd
 SD0/M0fjL8hSNFflmFVKOdsTkUGJX2GX7HN5MYb6qATPt8jqG+89gk6YNw1AtOEgI1
 YMQBj/1/GJEoy+wQbpJu20NdjIQ7wuFaaQvQv2du8LBznsTQad0ySaGLC5ltq3YHn4
 N+2lrcN0tFLQ7znMIlcN19giXZef6eek3HM8E5j6dBmxiYQyX8ACd9v3Kev42y2NxM
 PLVZZezg+jb+aLVnlG80ep+G16bM0abmHt3eEQPBBHTYtrKbiADJsFxdh+iPGCDaSX
 W0mweDUEBAWeA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DE0971CA651;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4505F409D93;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A56512F9FD; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 077/120] linux-user/sh4: allow full 32-bit address
 space
Date: Wed, 12 Aug 2026 17:49:00 +0300
Message-ID: <20260812144955.649205-77-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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
index c3b8114e538..9d72e35e312 100644
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
2.47.3


