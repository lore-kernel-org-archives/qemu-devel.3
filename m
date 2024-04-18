Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB32C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXRU-0005Gr-Ri; Thu, 18 Apr 2024 15:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOv-00086D-9h
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:31 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXOr-0007UL-RZ
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:29 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a4715991c32so134644166b.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468384; x=1714073184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cz2i/C3VQ13wYP5OhAoy8JFwTzWM+gW+I5eQgS4AVJI=;
 b=rGFJFJXqayyEX3JVK8pZ5TI/WNYzNoTP4Dozlcd7Tk8SXB50Ez/w5Icno2lGsdWUqc
 d48ck1S386PiW1Kn1Uwei0YGNk5SVt7ItCQRd80wi+W3zCAxCkNrTOnlR5f2hg0qFxlf
 hXrs+V/ejuTgQ+Slof0BMzHJM1swRDY66f4CMIgEo5asri3fKu9IxlIBEHRmP3A8NRYk
 lqtN/7uuANzx0+Ww5JhuHzyEayBIAYzYEBLykLY7M5GczDdBFMT6kCkR2KzzJuKD3Ota
 n+R5w5jJRMZlfJq6BJJhDSZALe3jotGAgt5oFBh6r/vm5pSmnCLg7XQ8a9kEVIFCioG4
 07OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468384; x=1714073184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cz2i/C3VQ13wYP5OhAoy8JFwTzWM+gW+I5eQgS4AVJI=;
 b=Ce3QcYbcN70eEHcnMuJyX/p85MynH+9BX93cdC4m56ZbF45h+0tlNP6/9LqBTCmkVJ
 H07Rt6rSMn91kxVqQdYiSwWIkDnSIlXsKPRT+qP8Pr9OGAmJju/OjSzPgOEHbs6ByJ9t
 Vfw+x38oFf7NHzh3oSXCXUplWy3C91foLWvh5UmvPkZUx20fRHWC8fw/oeHPzrI0o8Be
 5mkvZVuoWMZhWcBRoiQ13swUV3qHkV1InODU/x/qoVxlUirkgyk0CmiGTUc3Qc9HIFZW
 1zQhi79/RGTwBgfJBwkraFJbgG1b1cqVoL0WmP85tCRdFLObFCBzIoPCNAyxuSXwm1lN
 lS6Q==
X-Gm-Message-State: AOJu0Yx79Rdhy6G/mHwa9eTEK02pqXWO7EauRM18C7PEd3+nLZYCLqoI
 rkXZRfrw7aNU6hBMFOdwr64ZxFivi1wwTnJO6DN3bVbdXrdZpxhLbqUXFBQx2u8Ggw28cabmXDp
 f
X-Google-Smtp-Source: AGHT+IEvmItgMVF6C3/vVOPtGDziKuF0Mk9IzmEgs2m+jrdat7LuYqaRaUfsQ5Ozj1eVRXpxQ9qu5A==
X-Received: by 2002:a17:906:c290:b0:a52:1e53:febf with SMTP id
 r16-20020a170906c29000b00a521e53febfmr42958ejz.69.1713468383981; 
 Thu, 18 Apr 2024 12:26:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a170906bc4d00b00a553de860c6sm1262836ejv.133.2024.04.18.12.26.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:26:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 09/24] physmem: Restrict TCG CPU IOTLB code to TCG accel
Date: Thu, 18 Apr 2024 21:25:08 +0200
Message-ID: <20240418192525.97451-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Restrict iotlb_to_section(), address_space_translate_for_iotlb()
and memory_region_section_get_iotlb() to TCG. Declare them in
"exec/cputlb.h". Declare iotlb_to_section() using the
MemoryRegionSection typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cputlb.h   | 25 +++++++++++++++++++++++--
 include/exec/exec-all.h | 21 ---------------------
 system/physmem.c        |  6 ++++++
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 173eb98b9a..3594f904b4 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -21,6 +21,8 @@
 #define CPUTLB_H
 
 #include "exec/abi_ptr.h"
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
 #include "exec/cpu-common.h"
 #include "exec/mmu-access-type.h"
 
@@ -43,10 +45,29 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
                         MMUAccessType access_type, int mmu_idx);
 
 #if !defined(CONFIG_USER_ONLY)
-/* cputlb.c */
+
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
-#endif
+
+/**
+ * iotlb_to_section:
+ * @cpu: CPU performing the access
+ * @index: TCG CPU IOTLB entry
+ *
+ * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
+ * it refers to. @index will have been initially created and returned
+ * by memory_region_section_get_iotlb().
+ */
+MemoryRegionSection *iotlb_to_section(CPUState *cpu,
+                                      hwaddr index, MemTxAttrs attrs);
+MemoryRegionSection *
+address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
+                                  hwaddr *xlat, hwaddr *plen,
+                                  MemTxAttrs attrs, int *prot);
+hwaddr memory_region_section_get_iotlb(CPUState *cpu,
+                                       MemoryRegionSection *section);
+
+#endif /* CONFIG_USER_ONLY */
 
 #endif /* CONFIG_TCG */
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 5cddfea01b..e4cff08db4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -536,21 +536,6 @@ extern __thread uintptr_t tci_tb_ptr;
    smaller than 4 bytes, so we don't worry about special-casing this.  */
 #define GETPC_ADJ   2
 
-#if !defined(CONFIG_USER_ONLY)
-
-/**
- * iotlb_to_section:
- * @cpu: CPU performing the access
- * @index: TCG CPU IOTLB entry
- *
- * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
- * it refers to. @index will have been initially created and returned
- * by memory_region_section_get_iotlb().
- */
-struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                             hwaddr index, MemTxAttrs attrs);
-#endif
-
 /**
  * get_page_addr_code_hostp()
  * @env: CPUArchState
@@ -659,12 +644,6 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, vaddr addr);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
-MemoryRegionSection *
-address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
-                                  hwaddr *xlat, hwaddr *plen,
-                                  MemTxAttrs attrs, int *prot);
-hwaddr memory_region_section_get_iotlb(CPUState *cpu,
-                                       MemoryRegionSection *section);
 #endif
 
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index cf6334f3a3..38d3ede9f9 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -31,6 +31,7 @@
 #endif /* CONFIG_TCG */
 
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/target_page.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
@@ -585,6 +586,7 @@ typedef struct TCGIOMMUNotifier {
     bool active;
 } TCGIOMMUNotifier;
 
+#ifdef CONFIG_TCG
 static void tcg_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     TCGIOMMUNotifier *notifier = container_of(n, TCGIOMMUNotifier, n);
@@ -648,6 +650,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
         notifier->active = true;
     }
 }
+#endif
 
 void tcg_iommu_free_notifier_list(CPUState *cpu)
 {
@@ -668,6 +671,7 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
     cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier *));
 }
 
+#ifdef CONFIG_TCG
 /* Called from RCU critical section */
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
@@ -761,6 +765,8 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     return section - d->map.sections;
 }
 
+#endif /* CONFIG_TCG */
+
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
 {
-- 
2.41.0


