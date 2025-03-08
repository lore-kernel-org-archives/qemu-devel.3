Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E7FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38d-0004dh-7a; Sat, 08 Mar 2025 17:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38S-0004Yv-Du
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:12 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Q-0005Lf-Lh
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:12 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225477548e1so10272865ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474749; x=1742079549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZUhu3BnFzDT2DJGeBZFOFqKQQp7EogeXchL7RAMkqI=;
 b=gxQjwbFGTYLCzHiuRkwTvYMJIBp7mICGJ5b197fSY6uQPIoJMWNPEkHS5bWeXmpYDu
 qcGfY01ahjFCD5dvxoRgClWK5T0dq0n/V9yXWezO9Ig7Tk9Au4Nj3cm+g7Z8ClVyFo9j
 Pjj9lu4/9U1URrgO+nstGCLbcstiZ49QdH0RoDXN3Brb1MlXkfep364lRQZWgeU7Gvg/
 tZeAOE/Fa6xiTwl00nmp5WOYECSKYlNRq4mFayywf6q1Dx/tej8LpB1DXtekMcoiuZhx
 FBFuFkc/ptplFVysi/ei+vFnTDdQBGnSBJSQFqtTg7JCoS4E0JBnme/wqOOwmeJXp4tY
 LLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474749; x=1742079549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZUhu3BnFzDT2DJGeBZFOFqKQQp7EogeXchL7RAMkqI=;
 b=g50fqURkNgp6MeOs7XJPlC/fTcAJDAwLaOKuOGjy5O89lND/Jd0WyDTEDTmniUJB9X
 XWQ3ou5tt2b8m8XXfTx2ILP++7OiyaTDrpgWUo+Ppc0Pxt64lqHoHN4sc/Wtoo1rYCOM
 t/dO/w6aJoLxWHQ0GwApVXe58u4EmSKW+9dc/ExRJLAJvPJQKeEWHkg0m/LNh2dkku8S
 lEct8+C5RfGor4+AYm3izJckKnWI1ABcFIaL41WlZomgsAZri+KWi5ifgEcDMPTB0T84
 ++NKeWH07jFV3Atjzaa0CYHlNviiAuSOJyZH6bcu9VupRVFF0kte++OGHOzjoPomUU8x
 wuYg==
X-Gm-Message-State: AOJu0YztYefabE3rVDBo+PFWGctIAkaSv8Ag/2rDQH09hRu723g+mOBH
 nNkxQ046+3nqOBwOy8bZkuxnrzsvqEI4U8jHXWfpzH8kPASahDyY47Yiz3JtWpc66LXjI6Sir1b
 j
X-Gm-Gg: ASbGncuR2suN/iVXQAOvUii1G70Qgi3odrhR48Ez2h1N/XhDZIWRToE7Qn4k35yQu07
 6iiw+1IZukR2C93TER1Cy6QsADvPcz34o9l0UAitRnGdI2TjsmAoCEhYwUlOzH5i+0FvfJRWZOb
 xxnIS+iZuOtiPLWJMr/71JaBR0wZnlnC/UiSGv5goB6RJjkp+cPmRINed3h/buRX2Bu8sAbEuoZ
 sLRRKSXkz4KxCnIXold97bonju1aZT7AVshhI/eIdJ8eTMSNOuKH5N6QMhrwRqboOfs+aN79BLw
 l6je72QeCGETKEmtCnkLMhHJ5o0FDbITmnUL2Mp/CJq0+guBTXaAyXdDZjP8TSJV1SyVOxxaFwT
 w
X-Google-Smtp-Source: AGHT+IE3dT/L3ABJKjRYygN4jGaIS5mHRrX+2jiFHVKGPVfWhzLfKEtochPP4IkpERNbxDBRMo5tLQ==
X-Received: by 2002:a17:903:40cb:b0:223:44c5:4eb8 with SMTP id
 d9443c01a7336-22428c0752cmr146209285ad.32.1741474749073; 
 Sat, 08 Mar 2025 14:59:09 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/23] exec: Declare tlb_set_page_with_attrs() in
 'exec/cputlb.h'
Date: Sat,  8 Mar 2025 14:58:47 -0800
Message-ID: <20250308225902.1208237-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241114011310.3615-17-philmd@linaro.org>
---
 include/exec/cputlb.h                | 28 ++++++++++++++++++++++++++++
 include/exec/exec-all.h              | 25 -------------------------
 target/i386/tcg/system/excp_helper.c |  2 +-
 target/microblaze/helper.c           |  2 +-
 4 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 733ef012d1..56dd05a148 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -21,6 +21,8 @@
 #define CPUTLB_H
 
 #include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
 #include "exec/vaddr.h"
 
 #ifdef CONFIG_TCG
@@ -62,4 +64,30 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
                        CPUTLBEntryFull *full);
 
+/**
+ * tlb_set_page_with_attrs:
+ * @cpu: CPU to add this TLB entry for
+ * @addr: virtual address of page to add entry for
+ * @paddr: physical address of the page
+ * @attrs: memory transaction attributes
+ * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
+ * @mmu_idx: MMU index to insert TLB entry for
+ * @size: size of the page in bytes
+ *
+ * Add an entry to this CPU's TLB (a mapping from virtual address
+ * @addr to physical address @paddr) with the specified memory
+ * transaction attributes. This is generally called by the target CPU
+ * specific code after it has been called through the tlb_fill()
+ * entry point and performed a successful page table walk to find
+ * the physical address and attributes for the virtual address
+ * which provoked the TLB miss.
+ *
+ * At most one entry for a given virtual address is permitted. Only a
+ * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
+ * used by tlb_flush_page.
+ */
+void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
+                             hwaddr paddr, MemTxAttrs attrs,
+                             int prot, int mmu_idx, vaddr size);
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index f43c67366b..62d6300752 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -156,31 +156,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                uint16_t idxmap,
                                                unsigned bits);
 
-/**
- * tlb_set_page_with_attrs:
- * @cpu: CPU to add this TLB entry for
- * @addr: virtual address of page to add entry for
- * @paddr: physical address of the page
- * @attrs: memory transaction attributes
- * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
- * @mmu_idx: MMU index to insert TLB entry for
- * @size: size of the page in bytes
- *
- * Add an entry to this CPU's TLB (a mapping from virtual address
- * @addr to physical address @paddr) with the specified memory
- * transaction attributes. This is generally called by the target CPU
- * specific code after it has been called through the tlb_fill()
- * entry point and performed a successful page table walk to find
- * the physical address and attributes for the virtual address
- * which provoked the TLB miss.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
-                             hwaddr paddr, MemTxAttrs attrs,
-                             int prot, int mmu_idx, vaddr size);
 /* tlb_set_page:
  *
  * This function is equivalent to calling tlb_set_page_with_attrs()
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 864e3140e3..6876329de2 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cpu_ldst.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "tcg/helper-tcg.h"
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 5d3259ce31..27fc929bee 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
-- 
2.43.0


