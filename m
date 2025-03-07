Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF39BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcse-0007XL-Pw; Fri, 07 Mar 2025 13:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsR-0007S6-25
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:56 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsP-0007mC-2V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:54 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso4743171a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373812; x=1741978612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZUhu3BnFzDT2DJGeBZFOFqKQQp7EogeXchL7RAMkqI=;
 b=TjFxp62lW6qfz2KMRvOfTFrngP/swyyxTDqLTVU9VmcS2EzN/2r6STr/RjbgutX5wu
 ay9jP/RSBa24CzrCpzaln6YtEvqU+pLKKzt6jrvB3Vd+Qp94DFWUTcjtT0EbW5JuANZA
 sL/gJYkQbNti4S9yTkjEcTmOPYId01lWeHbOGOtRfUzXQMU7/E79PJyOPqIaAkA9Y2I9
 TYEePamAwscer3rpgB8wq7I677QKsOTlBlfuPaThe7hrmgrhTUFQs9K+FBnocuhmLEWG
 2HNZpCnmAoOSC7PB3vDCBGhUlrMKei1reDJBRLYou7F6XpwHZLppWNXZMESLHufOmajU
 vciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373812; x=1741978612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OZUhu3BnFzDT2DJGeBZFOFqKQQp7EogeXchL7RAMkqI=;
 b=BpMCSHsiY/8zdt2FS0T916/2SurcljnTXuakUmhLupR35CbU9WuRk4NbHk3sjm/15u
 m7kT6tijffyT4YGEUNUqcB/MjH5mCCXOqBCqldDTUfu2xqSjEttjRFeXniGKsA961oTC
 PC4fL/lgICljTAt4mFzNpnr6ry8sNPtCoAIcWOQ3BgmTZgate+MXBUFSDmZkRkBnqxD3
 arVsx2cNSvkiZp3z2wKjBDdNUDcdXWEAcBkVtwWTgE2c000ffn4RfRzA/qvzZBct50Aq
 tMFm1e1H8PYTNQgF1BG6MfV9LPLrPqPYe1Dhe6BJRToD4wMcZGMralFASj2hO6AuOXOU
 ZGTg==
X-Gm-Message-State: AOJu0YxGf6m+ygIFTPjgReVemckjk1wUqJ1fa5VIQbZ2PgSVWV1f2OvA
 obs2gxMw3vadYpOPfCWUjidSMqHOpshaVJTM9AdD9CbcWkxlRzIAfLfm4YZ5nl5HphArg/em5NP
 N
X-Gm-Gg: ASbGnctSq08v1xIBZjrg90DlvFph77ltrX4RHOfklGK1hNw1q7SzW7JLXmlfVL1uAWj
 W5fSNx0V8tVoyABTWCPmk4wVO4SCQBBptYEVWpOR0DBSXy+oPbDmbRdwpE0jwkJ4pzqt7pcDMZn
 Tq/uDlD9NwbOQ2TUaDP3rZs5JhTyENmLuAEXd3YqpuZSGMhWoIz339bL+cIvn8sphf2wy0Unwk1
 3Yi+pYlEcy0H0+BdhB7hPfgkQtGb8Xx38GMgv8PJ+gY/N43oyEouWlVt44kmSoELgMDYbbcSeQs
 QRwVwuP4C+N0lDBYBxirJLqddIuq4McjxO5LR8NH11u9lOnaZrYKAFb3XFtytfHHqowlAcZd948
 u
X-Google-Smtp-Source: AGHT+IFN1/MYxbnPD7Vm9r+4vYkKdXRttulS8CDzGXr81qKZMEL6KXrgWiLqGjvM6FgPkqFZbS9AnA==
X-Received: by 2002:a17:90b:3804:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2ff7ce77a3fmr7203085a91.13.1741373811734; 
 Fri, 07 Mar 2025 10:56:51 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/16] exec: Declare tlb_set_page_with_attrs() in
 'exec/cputlb.h'
Date: Fri,  7 Mar 2025 10:56:34 -0800
Message-ID: <20250307185645.970034-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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


