Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44940CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJT-0001Xw-Ik; Wed, 09 Oct 2024 11:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJR-0001XI-RW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:17 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJM-0007yl-BL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:17 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71df2b0a2f7so3734435b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486551; x=1729091351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tHejgt59fwDDl/z4Gy/UG4eq0kEJ+i5rqUHafxjYfQk=;
 b=NTz6aoJmMOwUcm/JwlYLvYp8fBNF0us+sHBurDHz6iF5hGxKBx42jCMBkc5A8D7Iyd
 zdwcW0JNwTGYuA8USApGsDA7L4TdVjdDO9ZT9B7PL5kq//hQdTDm+7RsI5Uq3hGihq5F
 y4e7qxlLynTbr2DKm1Zq9PYcVq/MqdR3bliTrPbtijPynwjOyl/wGpNZ3UhumZwtSSpX
 mO1QW6SfTuVXDaKCCgsjNx2x9XTOYKEne709RpmCC9WlVtLLN7zeYKcYKg2OuxusG1ll
 dmrMuaQoGHErnazqrihvSKMMb6UHg1wctXpMIhsLZ9DT0MAPIEbN3qnWed4S0CdWLSMP
 dPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486551; x=1729091351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHejgt59fwDDl/z4Gy/UG4eq0kEJ+i5rqUHafxjYfQk=;
 b=JoN8jMQWV+pCdEflE8Jxz0MAOJE+fk0EPYqmSjbRUS/XPKJNaCeGH5hzVmVyO2f1ny
 O3cc8Dr0j8QUtN6X2mQ/0kU7YQ2/B1ehf5pGQWkqZ910KjQUQCsQaIU7et092gTCdWPq
 iTuBabE8nctRAUwaeY7TDkzbqd+xoXH7EPEcfONlW3VL5OMtWiZqn/JHBdP+quKZUIIO
 4JZKPbqBkyVfrwGVeGhJW0wJqy8YaBWMiOJ7/F2RA6x+LCiehQ7ec2Cmb3uBW7Rc8Q8N
 R9cvxQWvmLWozndi8JZOcrw6JWLMWTgmbybwyqygmBvCfxLwcD8JJoQnwtW9fi52nfdF
 T51w==
X-Gm-Message-State: AOJu0YwjmcAAwh2VisptVfebHodUBdU9ctwNXtYY5twVh5XsuB4D29Rn
 sv0CRDhYxhhCkkyDR0mKEpwCATY/iRlkpyf81SEbQaq8ZYf8AwkwxY54+fe3sWapu4BDkII/Ufw
 u
X-Google-Smtp-Source: AGHT+IGnxO4UcoMHts0d6LgunxKV6UjUFs+1KrspPfi6pfoQ3qDp2E3AO6QM5KPlBp6KFTo7UnN6lA==
X-Received: by 2002:a05:6a20:d707:b0:1d3:2976:13e with SMTP id
 adf61e73a8af0-1d8a3c2666emr4537153637.30.1728486550886; 
 Wed, 09 Oct 2024 08:09:10 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/23] include/exec/tlb-common: Move CPUTLBEntryFull from
 hw/core/cpu.h
Date: Wed,  9 Oct 2024 08:08:48 -0700
Message-ID: <20241009150855.804605-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

CPUTLBEntryFull structures are no longer directly included within
the CPUState structure.  Move the structure definition out of cpu.h
to reduce visibility.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-common.h | 63 +++++++++++++++++++++++++++++++++++++++
 include/hw/core/cpu.h     | 63 ---------------------------------------
 2 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index dc5a5faa0b..300f9fae67 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -53,4 +53,67 @@ typedef struct CPUTLBDescFast {
     CPUTLBEntry *table;
 } CPUTLBDescFast QEMU_ALIGNED(2 * sizeof(void *));
 
+/*
+ * The full TLB entry, which is not accessed by generated TCG code,
+ * so the layout is not as critical as that of CPUTLBEntry. This is
+ * also why we don't want to combine the two structs.
+ */
+struct CPUTLBEntryFull {
+    /*
+     * @xlat_section contains:
+     *  - in the lower TARGET_PAGE_BITS, a physical section number
+     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
+     *    must be added to the virtual address to obtain:
+     *     + the ram_addr_t of the target RAM (if the physical section
+     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
+     *     + the offset within the target MemoryRegion (otherwise)
+     */
+    hwaddr xlat_section;
+
+    /*
+     * @phys_addr contains the physical address in the address space
+     * given by cpu_asidx_from_attrs(cpu, @attrs).
+     */
+    hwaddr phys_addr;
+
+    /* @attrs contains the memory transaction attributes for the page. */
+    MemTxAttrs attrs;
+
+    /* @prot contains the complete protections for the page. */
+    uint8_t prot;
+
+    /* @lg_page_size contains the log2 of the page size. */
+    uint8_t lg_page_size;
+
+    /* Additional tlb flags requested by tlb_fill. */
+    uint8_t tlb_fill_flags;
+
+    /*
+     * Additional tlb flags for use by the slow path. If non-zero,
+     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
+     */
+    uint8_t slow_flags[MMU_ACCESS_COUNT];
+
+    /*
+     * Allow target-specific additions to this structure.
+     * This may be used to cache items from the guest cpu
+     * page tables for later use by the implementation.
+     */
+    union {
+        /*
+         * Cache the attrs and shareability fields from the page table entry.
+         *
+         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
+         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
+         * For shareability and guarded, as in the SH and GP fields respectively
+         * of the VMSAv8-64 PTEs.
+         */
+        struct {
+            uint8_t pte_attrs;
+            uint8_t shareability;
+            bool guarded;
+        } arm;
+    } extra;
+};
+
 #endif /* EXEC_TLB_COMMON_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 87b864f5c4..6b1c2bfadd 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -198,69 +198,6 @@ struct CPUClass {
  */
 #define NB_MMU_MODES 16
 
-/*
- * The full TLB entry, which is not accessed by generated TCG code,
- * so the layout is not as critical as that of CPUTLBEntry. This is
- * also why we don't want to combine the two structs.
- */
-struct CPUTLBEntryFull {
-    /*
-     * @xlat_section contains:
-     *  - in the lower TARGET_PAGE_BITS, a physical section number
-     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
-     *    must be added to the virtual address to obtain:
-     *     + the ram_addr_t of the target RAM (if the physical section
-     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
-     *     + the offset within the target MemoryRegion (otherwise)
-     */
-    hwaddr xlat_section;
-
-    /*
-     * @phys_addr contains the physical address in the address space
-     * given by cpu_asidx_from_attrs(cpu, @attrs).
-     */
-    hwaddr phys_addr;
-
-    /* @attrs contains the memory transaction attributes for the page. */
-    MemTxAttrs attrs;
-
-    /* @prot contains the complete protections for the page. */
-    uint8_t prot;
-
-    /* @lg_page_size contains the log2 of the page size. */
-    uint8_t lg_page_size;
-
-    /* Additional tlb flags requested by tlb_fill. */
-    uint8_t tlb_fill_flags;
-
-    /*
-     * Additional tlb flags for use by the slow path. If non-zero,
-     * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
-     */
-    uint8_t slow_flags[MMU_ACCESS_COUNT];
-
-    /*
-     * Allow target-specific additions to this structure.
-     * This may be used to cache items from the guest cpu
-     * page tables for later use by the implementation.
-     */
-    union {
-        /*
-         * Cache the attrs and shareability fields from the page table entry.
-         *
-         * For ARMMMUIdx_Stage2*, pte_attrs is the S2 descriptor bits [5:2].
-         * Otherwise, pte_attrs is the same as the MAIR_EL1 8-bit format.
-         * For shareability and guarded, as in the SH and GP fields respectively
-         * of the VMSAv8-64 PTEs.
-         */
-        struct {
-            uint8_t pte_attrs;
-            uint8_t shareability;
-            bool guarded;
-        } arm;
-    } extra;
-};
-
 /*
  * Data elements that are per MMU mode, minus the bits accessed by
  * the TCG fast path.
-- 
2.43.0


