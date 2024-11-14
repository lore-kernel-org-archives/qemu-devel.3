Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B75D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJ8-0005m6-Uc; Thu, 14 Nov 2024 11:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI5-0004zy-IZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:56 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI3-0002F4-AO
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:52 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e3d523a24dso687271a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600109; x=1732204909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q3hq8/WORX9tjGeTrB15u911iYQPv1dQgSnGBISFTlA=;
 b=Cmlz0NUQdtgnoOegqJSXWKxJwjpM6H8bkqcetUsacOznDI5tYiS5QAMjHnjulV/Boo
 schnG8YS1m/QVMe6fAOQvjOXgo2PSvHVkSdhbcWJAXbVk0znJB9jjFi3TuLxiH0uXTUK
 ykPlO9Iz3XQpF/hoTvXREIgkZS5YS2XbCCKDAE84yWLcdHgEtV1JHIVzyyDNNuuQxJ41
 zjMotGN6ytYBqCgU//uQwVJbF+/emmQaE99minwO+E7Lp1hgoJpxSkw9gAYNjsyVMwk7
 qvLVKWmHbvvNOykIwLPZHqUAZIXy5wWmfkZwgx54BdE4egUoIIPq6ShthM3Yc5mf0dNR
 ttSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600109; x=1732204909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3hq8/WORX9tjGeTrB15u911iYQPv1dQgSnGBISFTlA=;
 b=e4/lOS30re3zBXimCJlJ6vy0xJhehssd6v/tEv3wTrLcUI3nEGRYhxqTDJG2RsVajz
 eR71vc9I3h57xwcOI+g0ui/ULwvd2ycJm+rtlbarwv2SXtposDsQ8Dk/f10Org2i0o1A
 5X/6VTVBPP8UkOSZCjCo5OPxkSKjTlb52OES5RZM31WsApei9RNl0P+tiJ+h1HcgrUX6
 nwCVZK52RTpFi9gBPJ6F4YAfgLoOvr93vD4NhRtKAmAJf26JVCxUKUU3lLrwV0aE2NmF
 fCd4X+0QP/ReW2hCHiq9jmiaEhnlTmltLZUaykpzNDZvYb824L0sFxYgTUNUZaVDbdr/
 Mxdg==
X-Gm-Message-State: AOJu0YxG/fKtYUz8sQqyD4xHtpyf7k3vIfsAl76ml0bxkUsCWltEABo1
 O3FxmluBeJiSL1OgejTawo76+S7S9W/5PeGSNkEhTav7oyAsp41e90ZNYhLMnlE0tjSEdbpm22M
 +
X-Google-Smtp-Source: AGHT+IFtPIHgC6GpjZH9+1GsaXgTn2s1n/5wfBLUc1GdUUBRC2fxmiLGTPdJ65XmtPZb/7yBspHvrg==
X-Received: by 2002:a17:90b:4acb:b0:2e2:d5fc:2847 with SMTP id
 98e67ed59e1d1-2e9b177fe40mr32056117a91.30.1731600107271; 
 Thu, 14 Nov 2024 08:01:47 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/54] include/exec/tlb-common: Move CPUTLBEntryFull from
 hw/core/cpu.h
Date: Thu, 14 Nov 2024 08:00:56 -0800
Message-ID: <20241114160131.48616-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index 8eda0574b2..4364ddb1db 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,69 +201,6 @@ struct CPUClass {
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


