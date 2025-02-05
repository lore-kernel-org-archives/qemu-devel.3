Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB882C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 04:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfWds-0008Ku-Ex; Tue, 04 Feb 2025 23:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdp-0008Ji-8C
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:57 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdn-0007Fp-3L
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:57 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f01fe1ce8so21574525ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 20:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738728234; x=1739333034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q0zAIe7SWbgfcY9vZuTS6FSoBBjcjACpHzR+Y3UmH08=;
 b=kKtBOQv6lJjN6+M8Tw5GZJ7gDEkKjxWizPZeqObGM/QsRtB74vU6nCuj3qzD4tahSA
 TvUqyuXXT1AO/yzwV33DfdnKBLEsOGaBksZuqoUqinSxhFGUjdN2kIbWmbDmqB9at3uz
 7L2vW4GSkwlqIzIeeKh2m8bCLi8QBoZjPStZTUcRZWDwBRyiUPEgjaZiKMk7+tNR0SxI
 69OTLEoUP1pogTWbABfWh1ULtQkOSYVz99G7f62D9W2TpErEd1PMkTaeyPd5+Egkv6cQ
 c2vW1GkUlPRxa7LHSpa8+LCseQU1t0uqvPi/30q+AaGiQoNBp8SdOF+2hrprA/cHerp5
 p4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738728234; x=1739333034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0zAIe7SWbgfcY9vZuTS6FSoBBjcjACpHzR+Y3UmH08=;
 b=OX2uKnyOBzvtPxfqG/UpQkhGzEE7P2gBDC/zInbFLWU31hnLqWVem+ECMMMBM0ykJ4
 l5HbS28ytWdX/aAfYGSiiP7b2kXS5cY00ki2I8quPRQPPF4U6yLpajlYHdIY12aUFwn6
 JHhmz8j0R0CNxRXQKRncqRbljmhtc8blCKSmnvvaniBbkUQnviCExIozaaF4lCUyOySM
 a8YNF9ayySq2A1hiX/SSOWTZ13e4zwqbni2JiuAjk4NuL+fwVO8uCJf5l45t9GkueBmS
 OjmZdXJyZAIpJr5loWa5LwvezmSVXsakkxh/6GHDdKAAX95Va1XsWFwp4to5a3AfFgbE
 Xwag==
X-Gm-Message-State: AOJu0YyLwWb9MNGkUpHny3rap26otVq8MJM1SrToptxcBUx5kIcqG8AX
 YUu2Xv/zUgWfk1zvePEEBoUSLZH166YPPAZaPDjWSm+b/whM5OrkS4ipwBrvhsayo3P7Tkr/t8M
 2
X-Gm-Gg: ASbGncv1VgwGAvcOBnLdnIVqk2YsDCH76DYDnpzWY0uvQ6+LFcguarOgDeJxNyuRodF
 YhhfRuXf2mNAg3xei6nN12RFAXrJWFdI+UypVQkzYiyJwEYNSnInriy+zXJzxWMot6V1GeEMpCj
 IZV8JcISCiQmQFfikl1fGb+8v8F2Av+S0a0KY7dIglIYArrE2OeNpzhy4maF8pEPFGBP88Y2uYR
 Y9Zgsdp1KsebFaxFBOP9Oov1vXoxnaZ24SRgUqMaySh27pgDpOlsnauRyZAQ+Nuq0UaFZGJ9pJl
 cSCRJSLpsS+ww5c7/4oRk19yWndsxjPlo3yu9JfHkQKRNUc=
X-Google-Smtp-Source: AGHT+IF7va74PKI1DDGVinX1zooP9rE4m5REzeDeLSkvhy5diFDcRo72ToclevN6uB17LKm9vONv4w==
X-Received: by 2002:a17:902:ced1:b0:215:65f3:27f2 with SMTP id
 d9443c01a7336-21f17e2719dmr22637905ad.8.1738728233649; 
 Tue, 04 Feb 2025 20:03:53 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f054eb89esm22380325ad.79.2025.02.04.20.03.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 20:03:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] include/exec: Use uintptr_t in CPUTLBEntry
Date: Tue,  4 Feb 2025 20:03:41 -0800
Message-ID: <20250205040341.2056361-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205040341.2056361-1-richard.henderson@linaro.org>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Since we no longer support 64-bit guests on 32-bit hosts,
we can use a 32-bit type on a 32-bit host.  This shrinks
the size of the structure to 16 bytes on a 32-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-common.h  | 10 +++++-----
 accel/tcg/cputlb.c         | 21 ++++-----------------
 tcg/arm/tcg-target.c.inc   |  1 -
 tcg/mips/tcg-target.c.inc  |  9 ++-------
 tcg/ppc/tcg-target.c.inc   | 21 +++++----------------
 tcg/riscv/tcg-target.c.inc |  1 -
 6 files changed, 16 insertions(+), 47 deletions(-)

diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index dc5a5faa0b..03b5a8ffc7 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -19,14 +19,14 @@
 #ifndef EXEC_TLB_COMMON_H
 #define EXEC_TLB_COMMON_H 1
 
-#define CPU_TLB_ENTRY_BITS 5
+#define CPU_TLB_ENTRY_BITS (HOST_LONG_BITS == 32 ? 4 : 5)
 
 /* Minimalized TLB entry for use by TCG fast path. */
 typedef union CPUTLBEntry {
     struct {
-        uint64_t addr_read;
-        uint64_t addr_write;
-        uint64_t addr_code;
+        uintptr_t addr_read;
+        uintptr_t addr_write;
+        uintptr_t addr_code;
         /*
          * Addend to virtual address to get host address.  IO accesses
          * use the corresponding iotlb value.
@@ -37,7 +37,7 @@ typedef union CPUTLBEntry {
      * Padding to get a power of two size, as well as index
      * access to addr_{read,write,code}.
      */
-    uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
+    uintptr_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uintptr_t)];
 } CPUTLBEntry;
 
 QEMU_BUILD_BUG_ON(sizeof(CPUTLBEntry) != (1 << CPU_TLB_ENTRY_BITS));
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 75d075d044..ad158050a1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -104,22 +104,15 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
 {
     /* Do not rearrange the CPUTLBEntry structure members. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
-                      MMU_DATA_LOAD * sizeof(uint64_t));
+                      MMU_DATA_LOAD * sizeof(uintptr_t));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
-                      MMU_DATA_STORE * sizeof(uint64_t));
+                      MMU_DATA_STORE * sizeof(uintptr_t));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * sizeof(uint64_t));
+                      MMU_INST_FETCH * sizeof(uintptr_t));
 
-#if TARGET_LONG_BITS == 32
-    /* Use qatomic_read, in case of addr_write; only care about low bits. */
-    const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
-    ptr += HOST_BIG_ENDIAN;
-    return qatomic_read(ptr);
-#else
-    const uint64_t *ptr = &entry->addr_idx[access_type];
+    const uintptr_t *ptr = &entry->addr_idx[access_type];
     /* ofs might correspond to .addr_write, so use qatomic_read */
     return qatomic_read(ptr);
-#endif
 }
 
 static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
@@ -899,14 +892,8 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
         addr &= TARGET_PAGE_MASK;
         addr += tlb_entry->addend;
         if ((addr - start) < length) {
-#if TARGET_LONG_BITS == 32
-            uint32_t *ptr_write = (uint32_t *)&tlb_entry->addr_write;
-            ptr_write += HOST_BIG_ENDIAN;
-            qatomic_set(ptr_write, *ptr_write | TLB_NOTDIRTY);
-#else
             qatomic_set(&tlb_entry->addr_write,
                         tlb_entry->addr_write | TLB_NOTDIRTY);
-#endif
         }
     }
 }
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 865aab0ccd..f03bb76396 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1506,7 +1506,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
          * Load the tlb comparator into R2 and the fast path addend into R1.
          */
-        QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
         if (cmp_off == 0) {
             tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
         } else {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index d744b853cd..6fe7a77813 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1262,13 +1262,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         /* Add the tlb_table pointer, creating the CPUTLBEntry address.  */
         tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
-        if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
-            /* Load the (low half) tlb comparator.  */
-            tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3,
-                       cmp_off + HOST_BIG_ENDIAN * 4);
-        } else {
-            tcg_out_ld(s, TCG_TYPE_I64, TCG_TMP0, TCG_TMP3, cmp_off);
-        }
+        /* Load the tlb comparator.  */
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, TCG_TMP3, cmp_off);
 
         if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
             /* Load the tlb addend for the fast path.  */
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 2d16807ec7..822925a19b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2490,27 +2490,16 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
 
         /*
-         * Load the (low part) TLB comparator into TMP2.
+         * Load the TLB comparator into TMP2.
          * For 64-bit host, always load the entire 64-bit slot for simplicity.
          * We will ignore the high bits with tcg_out_cmp(..., addr_type).
          */
-        if (TCG_TARGET_REG_BITS == 64) {
-            if (cmp_off == 0) {
-                tcg_out32(s, LDUX | TAB(TCG_REG_TMP2,
-                                        TCG_REG_TMP1, TCG_REG_TMP2));
-            } else {
-                tcg_out32(s, ADD | TAB(TCG_REG_TMP1,
-                                       TCG_REG_TMP1, TCG_REG_TMP2));
-                tcg_out_ld(s, TCG_TYPE_I64, TCG_REG_TMP2,
-                           TCG_REG_TMP1, cmp_off);
-            }
-        } else if (cmp_off == 0 && !HOST_BIG_ENDIAN) {
-            tcg_out32(s, LWZUX | TAB(TCG_REG_TMP2,
-                                     TCG_REG_TMP1, TCG_REG_TMP2));
+        if (cmp_off == 0) {
+            tcg_out32(s, (TCG_TARGET_REG_BITS == 64 ? LDUX : LWZUX)
+                      | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
         } else {
             tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
-            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
-                       cmp_off + 4 * HOST_BIG_ENDIAN);
+            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
         }
 
         /*
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 689fbea0df..dae892437e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1760,7 +1760,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
         }
 
         /* Load the tlb comparator and the addend.  */
-        QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
         tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
                    is_ld ? offsetof(CPUTLBEntry, addr_read)
                          : offsetof(CPUTLBEntry, addr_write));
-- 
2.43.0


